Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5D1848
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 07:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692602223; x=1724138223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mp06sKxsEyi8dKUXRfKZkwtsNeGvoZXxbRdz3z7YgGs=;
  b=DkQ4FgVo2W279AIaJPm2tPt8AtisdHEuhjr7M5VguZO7LzwgkPXwlRcj
   VXtc6lKnFE10KemhPyzX+jRknOkd0jcgGx7qeF0/CvTlTzGfAfucGz6w3
   8ttosr5Ib+hvNKluIMH5YjI38fjcPuPkhjMy4XpU7ZE7RC3lO56IeMkxp
   jptn84lxtov3mspzYezfKVdOyR4NNVx4JStIxgjDcDKYxQdeYb9+aysCs
   L6ec22cL+gNVcIlhUqg0A35+zI6Ky3MSH2WIM1iulYlyzOkd/pNuKZPsb
   bFGvITQQASR4MslPBKjRvk+zTS9TYsiVXBhDonDUkjWsChxGdhTfSxn97
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="353093898"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353093898"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 00:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="765257785"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="765257785"
Received: from b49691a74c3c.jf.intel.com ([10.165.59.100])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2023 00:17:01 -0700
From: Huang Jiaqing <jiaqing.huang@intel.com>
To: kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jacob.jun.pan@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@intel.com,
	jiaqing.huang@intel.com
Subject: [PATCH] iommu/vt-d: Introduce a rb_tree for looking up device
Date: Mon, 21 Aug 2023 00:16:59 -0700
Message-Id: <20230821071659.123981-1-jiaqing.huang@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing IO page fault handler locates the PCI device by calling
pci_get_domain_bus_and_slot(), which searches the list of all PCI
devices until the desired PCI device is found. This is inefficient
because the algorithm efficiency of searching a list is O(n). In the
critical path of handling an IO page fault, this can cause a significant
performance bottleneck.

To improve the performance of the IO page fault handler, replace
pci_get_domain_bus_and_slot() with a local red-black tree. A red-black
tree is a self-balancing binary search tree, which means that the
average time complexity of searching a red-black tree is O(log(n)). This
is significantly faster than O(n), so it can significantly improve the
performance of the IO page fault handler.

In addition, we can only insert the affected devices (those that have IO
page fault enabled) into the red-black tree. This can further improve
the performance of the IO page fault handler.

Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
---
 drivers/iommu/intel/iommu.c | 68 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.h |  8 +++++
 drivers/iommu/intel/svm.c   | 13 +++----
 3 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5c8c5cdc36cf..fcebb7493d99 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -235,6 +235,65 @@ clear_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
 	clear_bit(((long)bus << 8) | devfn, iommu->copied_tables);
 }
 
+
+struct device_domain_info *device_rbtree_find(struct intel_iommu *iommu, u8 bus, u8 devfn)
+{
+	struct device_domain_info *data = NULL;
+	struct rb_node *node;
+
+	down_read(&iommu->iopf_device_sem);
+
+	node = iommu->iopf_device_rbtree.rb_node;
+	while (node) {
+		data = container_of(node, struct device_domain_info, node);
+		s16 result = RB_NODE_CMP(bus, devfn, data->bus, data->devfn);
+
+		if (result < 0)
+			node = node->rb_left;
+		else if (result > 0)
+			node = node->rb_right;
+		else
+			break;
+	}
+	up_read(&iommu->iopf_device_sem);
+
+	return node ? data : NULL;
+}
+
+static int device_rbtree_insert(struct intel_iommu *iommu, struct device_domain_info *data)
+{
+	struct rb_node **new, *parent = NULL;
+
+	down_write(&iommu->iopf_device_sem);
+
+	new = &(iommu->iopf_device_rbtree.rb_node);
+	while (*new) {
+		struct device_domain_info *this = container_of(*new, struct device_domain_info, node);
+		s16 result = RB_NODE_CMP(data->bus, data->devfn, this->bus, this->devfn);
+
+		parent = *new;
+		if (result < 0)
+			new = &((*new)->rb_left);
+		else if (result > 0)
+			new = &((*new)->rb_right);
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(&data->node, parent, new);
+	rb_insert_color(&data->node, &iommu->iopf_device_rbtree);
+
+	up_write(&iommu->iopf_device_sem);
+	return 0;
+}
+
+static void device_rbtree_remove(struct intel_iommu *iommu, struct device_domain_info *data)
+{
+	down_write(&iommu->iopf_device_sem);
+	rb_erase(&data->node, &iommu->iopf_device_rbtree);
+	up_write(&iommu->iopf_device_sem);
+}
+
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
@@ -3920,6 +3979,9 @@ int __init intel_iommu_init(void)
 			iommu_enable_translation(iommu);
 
 		iommu_disable_protect_mem_regions(iommu);
+
+		iommu->iopf_device_rbtree = RB_ROOT;
+		init_rwsem(&iommu->iopf_device_sem);
 	}
 	up_read(&dmar_global_lock);
 
@@ -4601,6 +4663,11 @@ static int intel_iommu_enable_iopf(struct device *dev)
 	ret = pci_enable_pri(pdev, PRQ_DEPTH);
 	if (ret)
 		goto iopf_unregister_handler;
+
+	ret = device_rbtree_insert(iommu, info);
+	if(ret)
+		goto iopf_unregister_handler;
+
 	info->pri_enabled = 1;
 
 	return 0;
@@ -4620,6 +4687,7 @@ static int intel_iommu_disable_iopf(struct device *dev)
 
 	if (!info->pri_enabled)
 		return -EINVAL;
+	device_rbtree_remove(iommu, info);
 
 	/*
 	 * PCIe spec states that by clearing PRI enable bit, the Page
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1c5e1d88862b..d49c9facb40e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -360,6 +360,8 @@
 /* PERFINTRSTS_REG */
 #define DMA_PERFINTRSTS_PIS	((u32)1)
 
+#define RB_NODE_CMP(bus1, devfn1, bus2, devfn2) (s16)(PCI_DEVID(bus1, devfn1) - PCI_DEVID(bus2, devfn2))
+
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
 	cycles_t start_time = get_cycles();				\
@@ -682,6 +684,9 @@ struct intel_iommu {
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
 
+	struct rb_root iopf_device_rbtree;
+	struct rw_semaphore iopf_device_sem;
+
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */
 	struct irq_domain *ir_domain;
@@ -715,6 +720,7 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+	struct rb_node node; /*device tracking node(lookup by (bus, devfn))*/
 };
 
 static inline void __iommu_flush_cache(
@@ -844,6 +850,8 @@ int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(void);
 void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+struct device_domain_info *device_rbtree_find(struct intel_iommu *iommu,
+				u8 bus, u8 devfn);
 
 struct intel_svm_dev {
 	struct list_head list;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e95b339e9cdc..78a10677630c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -664,7 +664,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	struct intel_iommu *iommu = d;
 	struct page_req_dsc *req;
 	int head, tail, handled;
-	struct pci_dev *pdev;
+	struct device_domain_info *info;
 	u64 address;
 
 	/*
@@ -710,23 +710,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
 			goto prq_advance;
 
-		pdev = pci_get_domain_bus_and_slot(iommu->segment,
-						   PCI_BUS_NUM(req->rid),
-						   req->rid & 0xff);
+		info = device_rbtree_find(iommu, PCI_BUS_NUM(req->rid), req->rid & 0xff);
 		/*
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (!pdev)
+		if (!info)
 			goto bad_req;
 
-		if (intel_svm_prq_report(iommu, &pdev->dev, req))
+		if (intel_svm_prq_report(iommu, info->dev, req))
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 		else
-			trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
+			trace_prq_report(iommu, info->dev, req->qw_0, req->qw_1,
 					 req->priv_data[0], req->priv_data[1],
 					 iommu->prq_seq_number++);
-		pci_dev_put(pdev);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.31.1

