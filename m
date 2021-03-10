Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F4C433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 09:07:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8079664FFC
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 09:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8079664FFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B6E3431B2;
	Wed, 10 Mar 2021 09:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jNR2tlnoX1_O; Wed, 10 Mar 2021 09:07:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6A34431A7;
	Wed, 10 Mar 2021 09:07:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 636A2C0011;
	Wed, 10 Mar 2021 09:07:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AA20C0018
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 09:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 260884EBDC
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 09:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id McZWntFc0PFs for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 09:06:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 619F54C65F
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 09:06:56 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DwR3z3PF8zrTKj;
 Wed, 10 Mar 2021 17:05:03 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Mar 2021 17:06:22 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Robin Murphy <robin.murphy@arm.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 05/11] iommu/arm-smmu-v3: Merge a span of page when stop
 dirty log
Date: Wed, 10 Mar 2021 17:06:08 +0800
Message-ID: <20210310090614.26668-6-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210310090614.26668-1-zhukeqian1@huawei.com>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, lushenming@huawei.com,
 Kirti Wankhede <kwankhede@nvidia.com>, James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: jiangkunkun <jiangkunkun@huawei.com>

When stop dirty log tracking, we need to recover all block descriptors
which are splited when start dirty log tracking.

This adds a new interface named stop_dirty_log in iommu layer and
arm smmuv3 implements it, which reinstall block mappings and unmap
the span of page mappings. Other types of IOMMU perform architecture
specific actions to stop dirty log.

To allow code reuse, the merge_page operation is realized as an
iommu_ops too. We flush all iotlbs after the whole procedure is
completed to ease the pressure of iommu, as we will hanle a huge
range of mapping in general.

Merging page does not simultaneously work with other pgtable ops,
as the only designed user is vfio, which always hold a lock, so race
condition is not considered in the pgtable ops.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---

changelog:

v2:
 - Change the return type of merge_page(). size_t -> int.
 - Change commit message to properly describe race condition. (Robin)
 - Add a new interface named stop_dirty_log(). (Sun Yi)
 - Change commit message to explain the realtionship of merge_page() and stop_dirty_log().
 
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 52 +++++++++++++
 drivers/iommu/io-pgtable-arm.c              | 78 ++++++++++++++++++++
 drivers/iommu/iommu.c                       | 82 +++++++++++++++++++++
 include/linux/io-pgtable.h                  |  2 +
 include/linux/iommu.h                       | 24 ++++++
 5 files changed, 238 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5d2fb926a08e..ac0d881c77b8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2587,6 +2587,56 @@ static int arm_smmu_start_dirty_log(struct iommu_domain *domain,
 	return 0;
 }
 
+static int arm_smmu_merge_page(struct iommu_domain *domain,
+			       unsigned long iova, phys_addr_t paddr,
+			       size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	size_t handled_size;
+
+	if (!(smmu->features & (ARM_SMMU_FEAT_BBML1 | ARM_SMMU_FEAT_BBML2))) {
+		dev_err(smmu->dev, "don't support BBML1/2, can't merge page\n");
+		return -ENODEV;
+	}
+	if (!ops || !ops->merge_page) {
+		pr_err("io-pgtable don't realize merge page\n");
+		return -ENODEV;
+	}
+
+	handled_size = ops->merge_page(ops, iova, paddr, size, prot);
+	if (handled_size != size) {
+		pr_err("merge page failed\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * For SMMU, the action to stop dirty log is merge page mapping. The hardware
+ * dirty management is always enabled if hardware supports HTTU HD.
+ */
+static int arm_smmu_stop_dirty_log(struct iommu_domain *domain,
+				   unsigned long iova, size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_HD))
+		return -ENODEV;
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	/*
+	 * Even if the merge operation fail, it just effects performace of DMA
+	 * transaction.
+	 */
+	iommu_merge_page(domain, iova, size, prot);
+	return 0;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2688,6 +2738,8 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.split_block		= arm_smmu_split_block,
 	.start_dirty_log	= arm_smmu_start_dirty_log,
+	.merge_page		= arm_smmu_merge_page,
+	.stop_dirty_log		= arm_smmu_stop_dirty_log,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4c4eec3c0698..9028328b99b0 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -800,6 +800,83 @@ static size_t arm_lpae_split_block(struct io_pgtable_ops *ops,
 	return __arm_lpae_split_block(data, iova, size, lvl, ptep);
 }
 
+static size_t __arm_lpae_merge_page(struct arm_lpae_io_pgtable *data,
+				    unsigned long iova, phys_addr_t paddr,
+				    size_t size, int lvl, arm_lpae_iopte *ptep,
+				    arm_lpae_iopte prot)
+{
+	arm_lpae_iopte pte, *tablep;
+	struct io_pgtable *iop = &data->iop;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
+
+	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+	pte = READ_ONCE(*ptep);
+	if (WARN_ON(!pte))
+		return 0;
+
+	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
+		if (iopte_leaf(pte, lvl, iop->fmt))
+			return size;
+
+		/* Race does not exist */
+		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_BBML1) {
+			prot |= ARM_LPAE_PTE_NT;
+			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+			io_pgtable_tlb_flush_walk(iop, iova, size,
+						  ARM_LPAE_GRANULE(data));
+
+			prot &= ~(ARM_LPAE_PTE_NT);
+			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+		} else {
+			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+		}
+
+		tablep = iopte_deref(pte, data);
+		__arm_lpae_free_pgtable(data, lvl + 1, tablep);
+		return size;
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		/* The size is too small, already merged */
+		return size;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_merge_page(data, iova, paddr, size, lvl + 1, ptep, prot);
+}
+
+static size_t arm_lpae_merge_page(struct io_pgtable_ops *ops, unsigned long iova,
+				  phys_addr_t paddr, size_t size, int iommu_prot)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	arm_lpae_iopte prot;
+	long iaext = (s64)iova >> cfg->ias;
+
+	/* If no access, then nothing to do */
+	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
+		return size;
+
+	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+		return 0;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext || paddr >> cfg->oas))
+		return 0;
+
+	/* If it is smallest granule, then nothing to do */
+	if (size == ARM_LPAE_BLOCK_SIZE(ARM_LPAE_MAX_LEVELS - 1, data))
+		return size;
+
+	prot = arm_lpae_prot_to_pte(data, iommu_prot);
+	return __arm_lpae_merge_page(data, iova, paddr, size, lvl, ptep, prot);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -879,6 +956,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.unmap		= arm_lpae_unmap,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.split_block	= arm_lpae_split_block,
+		.merge_page	= arm_lpae_merge_page,
 	};
 
 	return data;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f644e0b16843..2a10294b62a3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2768,6 +2768,88 @@ int iommu_start_dirty_log(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_start_dirty_log);
 
+static int __iommu_merge_page(struct iommu_domain *domain,
+			      unsigned long iova, phys_addr_t paddr,
+			      size_t size, int prot)
+{
+	const struct iommu_ops *ops = domain->ops;
+	unsigned int min_pagesz;
+	size_t pgsize;
+	int ret = 0;
+
+	if (unlikely(!ops || !ops->merge_page))
+		return -ENODEV;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%x\n",
+			iova, &paddr, size, min_pagesz);
+		return -EINVAL;
+	}
+
+	while (size) {
+		pgsize = iommu_pgsize(domain, iova | paddr, size);
+
+		ret = ops->merge_page(domain, iova, paddr, pgsize, prot);
+		if (ret)
+			break;
+
+		pr_debug("merge handled: iova 0x%lx pa %pa size 0x%zx\n",
+			 iova, &paddr, pgsize);
+
+		iova += pgsize;
+		paddr += pgsize;
+		size -= pgsize;
+	}
+
+	return ret;
+}
+
+int iommu_merge_page(struct iommu_domain *domain, unsigned long iova,
+		     size_t size, int prot)
+{
+	phys_addr_t phys;
+	dma_addr_t p, i;
+	size_t cont_size;
+	int ret = 0;
+
+	while (size) {
+		phys = iommu_iova_to_phys(domain, iova);
+		cont_size = PAGE_SIZE;
+		p = phys + cont_size;
+		i = iova + cont_size;
+
+		while (cont_size < size && p == iommu_iova_to_phys(domain, i)) {
+			p += PAGE_SIZE;
+			i += PAGE_SIZE;
+			cont_size += PAGE_SIZE;
+		}
+
+		ret = __iommu_merge_page(domain, iova, phys, cont_size, prot);
+		if (ret)
+			break;
+
+		iova += cont_size;
+		size -= cont_size;
+	}
+	iommu_flush_iotlb_all(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_merge_page);
+
+int iommu_stop_dirty_log(struct iommu_domain *domain, unsigned long iova,
+			 size_t size, int prot)
+{
+	const struct iommu_ops *ops = domain->ops;
+
+	if (unlikely(!ops || !ops->stop_dirty_log))
+		return -ENODEV;
+
+	return ops->stop_dirty_log(domain, iova, size, prot);
+}
+EXPORT_SYMBOL_GPL(iommu_stop_dirty_log);
+
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index d86dd2ade6ad..38b4e17c70f0 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -169,6 +169,8 @@ struct io_pgtable_ops {
 				    unsigned long iova);
 	size_t (*split_block)(struct io_pgtable_ops *ops, unsigned long iova,
 			      size_t size);
+	size_t (*merge_page)(struct io_pgtable_ops *ops, unsigned long iova,
+			     phys_addr_t phys, size_t size, int prot);
 };
 
 /**
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 85ffa451547d..28111009cf6f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -207,6 +207,8 @@ struct iommu_iotlb_gather {
  * @domain_set_attr: Change domain attributes
  * @split_block: Split block mapping into page mapping
  * @start_dirty_log: Perform actions to start dirty log tracking
+ * @merge_page: Merge page mapping into block mapping
+ * @stop_dirty_log: Perform actions to stop dirty log tracking
  * @get_resv_regions: Request list of reserved regions for a device
  * @put_resv_regions: Free list of reserved regions for a device
  * @apply_resv_region: Temporary helper call-back for iova reserved ranges
@@ -267,6 +269,10 @@ struct iommu_ops {
 			   size_t size);
 	int (*start_dirty_log)(struct iommu_domain *domain, unsigned long iova,
 			       size_t size);
+	int (*merge_page)(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t phys, size_t size, int prot);
+	int (*stop_dirty_log)(struct iommu_domain *domain, unsigned long iova,
+			      size_t size, int prot);
 
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
@@ -523,6 +529,10 @@ extern int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
 			     size_t size);
 extern int iommu_dirty_log_start(struct iommu_domain *domain,
 				 unsigned long iova, size_t size);
+extern int iommu_merge_page(struct iommu_domain *domain, unsigned long iova,
+			    size_t size, int prot);
+extern int iommu_stop_dirty_log(struct iommu_domain *domain,
+				unsigned long iova, size_t size, int prot);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
@@ -925,6 +935,20 @@ static inline int iommu_start_dirty_log(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_merge_page(struct iommu_domain *domain,
+				   unsigned long iova, size_t size,
+				   int prot)
+{
+	return -EINVAL;
+}
+
+static inline int iommu_stop_dirty_log(struct iommu_domain *domain,
+				       unsigned long iova, size_t size,
+				       int prot)
+{
+	return -EINVAL;
+}
+
 static inline int  iommu_device_register(struct iommu_device *iommu)
 {
 	return -ENODEV;
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
