Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CED17B41B
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704814; cv=none; b=HRgM6ZGIhCkChjgvuRcbdrM/6mG2h8TLuNANDVKDnNVh9luXhl3KfFZ69s9Wo2W0zMG1pvKfYnNM2L8kzzRGS6pqN44jjqfZAtYnDaRu/h1fRjtttaZTSOkFMRP3Ek8qeJq/4jAaDFcCl7OSF4GbSudbDa5PbgwzqeGxupZAmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704814; c=relaxed/simple;
	bh=EZRupiXcACIS811ijjV9HK/TmFHYK3tDinzBUIa98RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9eNkDIfkDXJut4M+XdE2wBLR3Mk8d+gQKk4KeUh95m9XF6W+uAqsT5LP1EZ2z255aS/2SYR39UWYHpDR2WxMq5MmPeF+fzThBoTqGyo2q9uMOJB0tGh0bJhJd+ztmziSqmCZPJmyY6blTKCStCDM36GKmzWgmgT0DDyr5GlOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvY66DxZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvY66DxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723704812; x=1755240812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EZRupiXcACIS811ijjV9HK/TmFHYK3tDinzBUIa98RM=;
  b=CvY66DxZkE+j5btRiw18/OlAkUVe1u/SM+O+OE3Y/BS31iJAYGrWyj5D
   GU5dk94HbAo3ApFC4UlW4ZXFn+jU/ViPETzr9xZF6+wn3sHSZAOmUlrkV
   qvrnD+qfzsuZeKkH5Um4YYJlHe1sCV0rjOoPNPUTBHIpdFbkdW2NsozSD
   mFFlG+jaMyfxYUODsjezPlqJkNgqx+qY/u5An8HnzmaE7gGugruT927B0
   KwxG6177x478O5DDZpzkLVVhOCnrfFgr1D6d47wjpnzTFnrZ4qBcPU1G1
   /4J9vwC1so6qtv+UFifYrQKQn7b3ittRyBUH6YSWB13YkX+KvvAS/xhKZ
   g==;
X-CSE-ConnectionGUID: SHDrV8PmRu+RrqPiTREKdA==
X-CSE-MsgGUID: XplqFuWEQ7+KJp3l3gKSPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32528297"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="32528297"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:53:32 -0700
X-CSE-ConnectionGUID: Qp922m7wR+SFq2/AXOrdiw==
X-CSE-MsgGUID: ZYUHu4UKQGGD0IhSTc5spA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="82471591"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2024 23:53:30 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 4/4] iommu/vt-d: Introduce batched cache invalidation
Date: Thu, 15 Aug 2024 14:52:21 +0800
Message-Id: <20240815065221.50328-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815065221.50328-1-tina.zhang@intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converts IOTLB and Dev-IOTLB invalidation to a batched model. Cache tag
invalidation requests for a domain are now accumulated in a qi_batch
structure before being flushed in bulk. It replaces the previous per-
request qi_flush approach with a more efficient batching mechanism.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/cache.c | 122 +++++++++++++++++++++++++++++++-----
 1 file changed, 107 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 21485c86e7381..983769de3bc90 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -262,6 +262,79 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
 }
 
+static void qi_batch_flush_descs(struct intel_iommu *iommu, struct qi_batch *batch)
+{
+	if (!iommu || !batch->index)
+		return;
+
+	qi_submit_sync(iommu, batch->descs, batch->index, 0);
+
+	/* Reset the index value and clean the whole batch buffer. */
+	memset(batch, 0, sizeof(*batch));
+}
+
+static void qi_batch_increment_index(struct intel_iommu *iommu, struct qi_batch *batch)
+{
+	if (++batch->index == QI_MAX_BATCHED_DESC_COUNT)
+		qi_batch_flush_descs(iommu, batch);
+}
+
+static void qi_batch_add_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+			       unsigned int size_order, u64 type,
+			       struct qi_batch *batch)
+{
+	qi_desc_iotlb(iommu, did, addr, size_order, type, &(batch->descs[batch->index]));
+	qi_batch_increment_index(iommu, batch);
+}
+
+static void qi_batch_add_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+				   u16 qdep, u64 addr, unsigned int mask,
+				   struct qi_batch *batch)
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
+static void qi_batch_add_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid,
+				u64 addr, unsigned long npages, bool ih,
+				struct qi_batch *batch)
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
+static void qi_batch_add_pasid_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+					 u32 pasid,  u16 qdep, u64 addr,
+					 unsigned int size_order, struct qi_batch *batch)
+{
+	/*
+	 * According to VT-d spec, software is recommended to not submit any
+	 * Device-TLB invalidation requests while address remapping hardware
+	 * is disabled.
+	 */
+	if (!(iommu->gcmd & DMA_GCMD_TE))
+		return;
+
+	qi_desc_dev_iotlb_pasid(sid, pfsid, pasid, qdep, addr, size_order,
+				&(batch->descs[batch->index]));
+	qi_batch_increment_index(iommu, batch);
+}
+
 static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *tag,
 				  unsigned long addr, unsigned long pages,
 				  unsigned long mask, int ih)
@@ -270,7 +343,8 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	u64 type = DMA_TLB_PSI_FLUSH;
 
 	if (domain->use_first_level) {
-		qi_flush_piotlb(iommu, tag->domain_id, tag->pasid, addr, pages, ih);
+		qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid, addr,
+				    pages, ih, domain->qi_batch);
 		return;
 	}
 
@@ -287,7 +361,8 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	}
 
 	if (ecap_qis(iommu->ecap))
-		qi_flush_iotlb(iommu, tag->domain_id, addr | ih, mask, type);
+		qi_batch_add_iotlb(iommu, tag->domain_id, addr | ih, mask, type,
+				   domain->qi_batch);
 	else
 		__iommu_flush_iotlb(iommu, tag->domain_id, addr | ih, mask, type);
 }
@@ -303,19 +378,20 @@ static void cache_tag_flush_devtlb_psi(struct dmar_domain *domain, struct cache_
 	sid = PCI_DEVID(info->bus, info->devfn);
 
 	if (tag->pasid == IOMMU_NO_PASID) {
-		qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
-				   addr, mask);
+		qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
+				       addr, mask, domain->qi_batch);
 		if (info->dtlb_extra_inval)
-			qi_flush_dev_iotlb(iommu, sid, info->pfsid,
-					   info->ats_qdep, addr, mask);
+			qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
+					       addr, mask, domain->qi_batch);
 		return;
 	}
 
-	qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid, tag->pasid,
-				 info->ats_qdep, addr, mask);
+	qi_batch_add_pasid_dev_iotlb(iommu, sid, info->pfsid, tag->pasid,
+				     info->ats_qdep, addr, mask, domain->qi_batch);
 	if (info->dtlb_extra_inval)
-		qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid, tag->pasid,
-					 info->ats_qdep, addr, mask);
+		qi_batch_add_pasid_dev_iotlb(iommu, sid, info->pfsid, tag->pasid,
+					     info->ats_qdep, addr, mask,
+					     domain->qi_batch);
 }
 
 static void cache_tag_flush_devtlb_all(struct dmar_domain *domain, struct cache_tag *tag)
@@ -327,11 +403,11 @@ static void cache_tag_flush_devtlb_all(struct dmar_domain *domain, struct cache_
 	info = dev_iommu_priv_get(tag->dev);
 	sid = PCI_DEVID(info->bus, info->devfn);
 
-	qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
-			   MAX_AGAW_PFN_WIDTH);
+	qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
+			       MAX_AGAW_PFN_WIDTH, domain->qi_batch);
 	if (info->dtlb_extra_inval)
-		qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
-				   MAX_AGAW_PFN_WIDTH);
+		qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
+				       MAX_AGAW_PFN_WIDTH, domain->qi_batch);
 }
 
 /*
@@ -341,6 +417,7 @@ static void cache_tag_flush_devtlb_all(struct dmar_domain *domain, struct cache_
 void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			   unsigned long end, int ih)
 {
+	struct intel_iommu *iommu = NULL;
 	unsigned long pages, mask, addr;
 	struct cache_tag *tag;
 	unsigned long flags;
@@ -349,6 +426,10 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
+		if (iommu && iommu != tag->iommu)
+			qi_batch_flush_descs(iommu, domain->qi_batch);
+		iommu = tag->iommu;
+
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
@@ -372,6 +453,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 
 		trace_cache_tag_flush_range(tag, start, end, addr, pages, mask);
 	}
+	qi_batch_flush_descs(iommu, domain->qi_batch);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
 
@@ -381,11 +463,16 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
  */
 void cache_tag_flush_all(struct dmar_domain *domain)
 {
+	struct intel_iommu *iommu = NULL;
 	struct cache_tag *tag;
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
+		if (iommu && iommu != tag->iommu)
+			qi_batch_flush_descs(iommu, domain->qi_batch);
+		iommu = tag->iommu;
+
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
@@ -399,6 +486,7 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 
 		trace_cache_tag_flush_all(tag);
 	}
+	qi_batch_flush_descs(iommu, domain->qi_batch);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
 
@@ -416,6 +504,7 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end)
 {
+	struct intel_iommu *iommu = NULL;
 	unsigned long pages, mask, addr;
 	struct cache_tag *tag;
 	unsigned long flags;
@@ -424,7 +513,9 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
-		struct intel_iommu *iommu = tag->iommu;
+		if (iommu && iommu != tag->iommu)
+			qi_batch_flush_descs(iommu, domain->qi_batch);
+		iommu = tag->iommu;
 
 		if (!cap_caching_mode(iommu->cap) || domain->use_first_level) {
 			iommu_flush_write_buffer(iommu);
@@ -437,5 +528,6 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 
 		trace_cache_tag_flush_range_np(tag, start, end, addr, pages, mask);
 	}
+	qi_batch_flush_descs(iommu, domain->qi_batch);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
-- 
2.34.1

