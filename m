Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0F18044
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172195; cv=none; b=hQzoEuLHVOrZ2/7d5NnFPXqQiFjeuNfn9fYpmMWwXesVNJ9bdxPc/c5hj04SeMfnr6689ElGH+yBdaXtukBvkxqzAG4KbI6cotaOQs/6MVJzIFpiV02dVjPgtLWut4dAj602XZK/riFydbN9KqedkwoqqjacwFiWoqOGsGDSRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172195; c=relaxed/simple;
	bh=fBlM0qLseZLN9df3ook7bpErdmbmwNQHQ19NE1NArGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Enf451pOZbIU6wa9WHQCgNyhWSzXAKAIjKpwzgVuk+FvO4gUjRc+tTXrBKTzuqAag7Ds2VCcxaVm2q/EC1MqWr4UFGdt0bYqHTL+3FRj+cbG6cv6pVN866bBgX9bOlbCpigZEzcuKA954JHhaU89Kg+l9uqHOPi0UHMR+e6DEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wm6Mn7r5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wm6Mn7r5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723172194; x=1754708194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fBlM0qLseZLN9df3ook7bpErdmbmwNQHQ19NE1NArGs=;
  b=Wm6Mn7r5BRs+GKOXhlFEK+CJmJRVXJ7IzuNNJG/dP3gNms9MWpbnt4K1
   5jrG1pVF96OSv8yFtGTGYAQY/CCUO1g+OOJlj87uQdWZtuyjnEMyFWbOc
   /pQNM01wndJPbsI6Slt1sDvNjar5vH7nGkDftctAe0zk7fbmULC2Q9lOH
   nXVvwpwv/aDRTmYrzietZU0el2CnRZObrSvsB5vJpF5FigsPeVi7AVayf
   nyoX/tyhTqUQC7CnXEVweb/jBoLgVG4QuRUVOZItDhdsxnVnm2Oj17EhN
   01mvd+J5ZEbnccfIQzSEcAOn0bBC+oKFpGCbDR31yNWjjIQ53+k4Yt8XU
   Q==;
X-CSE-ConnectionGUID: uFuUzQTnSDyu5KRVZVjIqA==
X-CSE-MsgGUID: IKo6EFYuRQqy2F1oa+RrAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24239358"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="24239358"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:56:33 -0700
X-CSE-ConnectionGUID: nzBwAlseRAeUkivd8GNMhw==
X-CSE-MsgGUID: 8bqFr1YQRXmWURAMUx+axA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62072650"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2024 19:56:32 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 3/5] iommu/vt-d: Introduce interfaces for QI batching operations
Date: Fri,  9 Aug 2024 10:54:29 +0800
Message-Id: <20240809025431.14605-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809025431.14605-1-tina.zhang@intel.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces qi_batch_xxx() interfaces to the VT-d driver to enhance the
efficiency of IOTLB and Dev-IOTLB invalidation command processing.
By allowing these commands to be batched together before submission,
the patch aims to minimize the overhead previously incurred when
handling these operations individually.

The addition of qi_batch_add_xxx() functions enable the accumulation of
invalidation commands into a batch, while the qi_batch_flush_descs()
function allows for the collective submission of these commands.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/dmar.c  | 78 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.h | 39 +++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 64724af1a618..8d55c49382fc 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1636,6 +1636,84 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
+static void qi_batch_increment_index(struct intel_iommu *iommu,
+					   struct qi_batch *batch)
+{
+	if (++batch->index == QI_MAX_BATCHED_DESC_COUNT)
+		qi_batch_flush_descs(iommu, batch);
+}
+
+void qi_batch_flush_descs(struct intel_iommu *iommu, struct qi_batch *batch)
+{
+	if (!batch->index)
+		return;
+
+	qi_submit_sync(iommu, batch->descs, batch->index, 0);
+
+	/* Reset the index value and clean the whole batch buffer */
+	memset(batch, 0, sizeof(struct qi_batch));
+}
+
+void qi_batch_add_iotlb_desc(struct intel_iommu *iommu, u16 did, u64 addr,
+			     unsigned int size_order, u64 type,
+			     struct qi_batch *batch)
+{
+	qi_desc_iotlb(iommu, did, addr, size_order, type, &(batch->descs[batch->index]));
+	qi_batch_increment_index(iommu, batch);
+}
+
+void qi_batch_add_dev_iotlb_desc(struct intel_iommu *iommu, u16 sid,
+				 u16 pfsid, u16 qdep, u64 addr,
+				 unsigned int mask,
+				 struct qi_batch *batch)
+{
+	/*
+	 * According to VT-d spec, software is recommended to not submit any Device-TLB
+	 * invalidation requests while address remapping hardware is disabled.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE))
+		return;
+
+	qi_desc_dev_iotlb(sid, pfsid, qdep, addr, mask, &(batch->descs[batch->index]));
+	qi_batch_increment_index(iommu, batch);
+}
+
+void qi_batch_add_piotlb_desc(struct intel_iommu *iommu, u16 did,
+			      u32 pasid, u64 addr,
+			      unsigned long npages, bool ih,
+			      struct qi_batch *batch)
+{
+	/*
+	 * npages == -1 means a PASID-selective invalidation, otherwise,
+	 * a positive value for Page-selective-within-PASID invalidation.
+	 * 0 is not a valid input.
+	 */
+	if (!npages)
+		return;
+
+	qi_desc_piotlb(did, pasid, addr, npages, ih, &(batch->descs[batch->index]));
+	qi_batch_increment_index(iommu, batch);
+}
+
+void qi_batch_add_dev_iotlb_pasid_desc(struct intel_iommu *iommu,
+				       u16 sid, u16 pfsid,
+				       u32 pasid,  u16 qdep,
+				       u64 addr, unsigned int size_order,
+				       struct qi_batch *batch)
+{
+	/*
+	 * According to VT-d spec, software is recommended to not submit any Device-TLB
+	 * invalidation requests while address remapping hardware is disabled.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE))
+		return;
+
+	qi_desc_dev_iotlb_pasid(sid, pfsid, pasid,
+				qdep, addr, size_order,
+				&(batch->descs[batch->index]));
+	qi_batch_increment_index(iommu, batch);
+}
+
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask)
 {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da1240..cd7c1d0a01c6 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -584,6 +584,22 @@ struct iommu_domain_info {
 					 * to VT-d spec, section 9.3 */
 };
 
+/*
+ * The QI_MAX_BATCHED_DESC_COUNT value is determined by the two considerations:
+ * 1) Maximizing the batching of IOTLB and Dev-IOTLB invalidation commands, which is
+ *    especially advantageous in virtualization environments where multiple devices may be
+ *    associated with a single virtual IOMMU.
+ * 2) Minimizing unnecessary memory allocation for domains lacking ATS support.
+ *
+ * Future enhancements could include dynamically allocating the batch buffer based on actual
+ * demand, allowing for adjustments to the batch size to better accommodate various use cases.
+ */
+#define QI_MAX_BATCHED_DESC_COUNT 16
+struct qi_batch {
+	struct qi_desc descs[QI_MAX_BATCHED_DESC_COUNT];
+	unsigned int index;
+};
+
 struct dmar_domain {
 	int	nid;			/* node id */
 	struct xarray iommu_array;	/* Attached IOMMU array */
@@ -1098,6 +1114,29 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		   unsigned int count, unsigned long options);
+
+void qi_batch_flush_descs(struct intel_iommu *iommu,
+			  struct qi_batch *batch);
+
+void qi_batch_add_iotlb_desc(struct intel_iommu *iommu, u16 did, u64 addr,
+			     unsigned int size_order, u64 type,
+			     struct qi_batch *batch);
+
+void qi_batch_add_dev_iotlb_desc(struct intel_iommu *iommu, u16 sid,
+				 u16 pfsid, u16 qdep, u64 addr,
+				 unsigned int mask,
+				 struct qi_batch *batch);
+
+void qi_batch_add_piotlb_desc(struct intel_iommu *iommu, u16 did,
+			      u32 pasid, u64 addr,
+			      unsigned long npages, bool ih,
+			      struct qi_batch *batch);
+
+void qi_batch_add_dev_iotlb_pasid_desc(struct intel_iommu *iommu,
+				       u16 sid, u16 pfsid,
+				       u32 pasid,  u16 qdep,
+				       u64 addr, unsigned int size_order,
+				       struct qi_batch *batch);
 /*
  * Options used in qi_submit_sync:
  * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
-- 
2.43.0

