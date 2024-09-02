Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBE14AD3B
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244309; cv=none; b=fRfO9y70yghHwpmXccDhH2hjjtDOSPfl4ZXRGSOglecRVZ0KMetWIfRKHBUhIpNMKQ2Gz0GModlIUrfn8qO0Cqctv2avm6tx/tuoCC6Y4Pah+pe2RFrLF/tS7oQ3etB17859HowjPHOHZlHRX3fe5KFwGfQyrFeCnha2icInqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244309; c=relaxed/simple;
	bh=SuXh1x2aBDH4m7kXr22UkyynOu2sb7NDnWcLtZYzL9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFQ7OZuiaLg87gc4VSx+im4N3cgRwd7L2PlZNpVuBEYD26rKq0m2s/MfN8xYBz96HYn4asY43qIUJnoIdj4tKW2205y8sRbkYCw7mZSI3X6f/w5QhmmhsiTb41nNW2UFkv2ZXfLsCAyeGyZQ29XRImzv31p1Fn34U8BFCUgt/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEjavwIk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEjavwIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244307; x=1756780307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SuXh1x2aBDH4m7kXr22UkyynOu2sb7NDnWcLtZYzL9g=;
  b=KEjavwIk7w/kSO4pBDh0ead4ClgJv0b9eJuUxgXzP3y2p7ZDZ0pHHLCC
   NP1ltyO6jZ/81vmEIIQFkVggJJwGkC6ssVp8mz3N2gKvgmTLj46gOF9cB
   ggGVFiHEmmyDSy11yWW5jQeu4T9ogbglFIg0eFS9TnYYagU6cZu4CvHLk
   aPpqCGM3MDufZmgER2UKf2ixyjG9rbOFl3f3jZo6XS9KJcCvL6zVOFUrP
   rDaaBHwk5wqRiYme0mkWBwogr2YTeSTHStFZxZ0mnhXFu658/OhafLt0Z
   oNsoE8Zd49Bn2X6jCcOU+KGn0+ingfqY3HlZHWUg6GTWovATWx4YjZ22R
   g==;
X-CSE-ConnectionGUID: KtQ5ZUziQMOR4ufxmtaEqw==
X-CSE-MsgGUID: u7XZ771aR5a6MMRTONy7oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994356"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994356"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:46 -0700
X-CSE-ConnectionGUID: QCManA9OTjmiSvACN9UoVQ==
X-CSE-MsgGUID: TR13/FedQtSK0xkPIqMYMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359372"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] iommu/vt-d: Introduce batched cache invalidation
Date: Mon,  2 Sep 2024 10:27:24 +0800
Message-Id: <20240902022724.67059-15-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

Converts IOTLB and Dev-IOTLB invalidation to a batched model. Cache tag
invalidation requests for a domain are now accumulated in a qi_batch
structure before being flushed in bulk. It replaces the previous per-
request qi_flush approach with a more efficient batching mechanism.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20240815065221.50328-5-tina.zhang@intel.com
---
 drivers/iommu/intel/cache.c | 122 +++++++++++++++++++++++++++++++-----
 1 file changed, 107 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 2e997d782beb..e5b89f728ad3 100644
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
+	qi_desc_iotlb(iommu, did, addr, size_order, type, &batch->descs[batch->index]);
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
+	qi_desc_dev_iotlb(sid, pfsid, qdep, addr, mask, &batch->descs[batch->index]);
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
+	qi_desc_piotlb(did, pasid, addr, npages, ih, &batch->descs[batch->index]);
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
+				&batch->descs[batch->index]);
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

