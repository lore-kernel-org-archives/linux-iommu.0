Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BC1C6B8
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172200; cv=none; b=WMLM3f2O6ReiA3Rg0gcYLY1VYZ4oNkr53vTe+mhPfZ+z2NZJryJ735bunY/y7xXOx40XhZ95eSVV2VCKFGJ+yfZJK8EBHE664kyIRjNb9de6aNFx3ipmDumN2atIro7WchmWCRi0o+T75JgntJ7vZexX0Plh/heV1oSqsaXZGjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172200; c=relaxed/simple;
	bh=RGRzvg1dpdiE/0xoWJxcDwnO1TbWA2NedxHlvDFTfAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1/0UmViMWuR32s7jCRZS6Kj8XgT1Fy1JhEumw16Afa/lYw0Wwi+m4cGGcpuf9BE1zcA7IJPSC4mfL7NNsMD8CoqumW/v9Ma3KjoTvdVZgtSMUMsCK59BVKkqWzy9MJRvE0IACsIp+pamvNF4qjou2LkOYeCZwl/BUF7t+1OCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/NG20CG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/NG20CG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723172197; x=1754708197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGRzvg1dpdiE/0xoWJxcDwnO1TbWA2NedxHlvDFTfAk=;
  b=e/NG20CGcUpr092VmxtK1jv3x7QLwI8Q1U8LeA37aODUFAW+VK4xKYAW
   8coU18DtsMCeshxD+yFYAB8m7Nbtftuvs2XfJrnEUXy7hGDN/liyccOb3
   A7M9k673P2Iuwn6MFRHoh0b//LQkPrL34GHQT0jOvjqnYIzQJYZVknAr9
   OPEtEIOv4uSTjnKNloccw6wmrq3o6WT5djNJ7cYivLgdgcICyzexjPuTm
   nbSdNK02uWIK7T2VrnL7eAf9UCITeE6XFOuT9RnF/8FL1ONu3U6f69P2K
   gLw99vzopqJT8QgoO7Y7iTCLVPtVg1zM+oBHJR/RmbDPnYeqjQzwRswuN
   w==;
X-CSE-ConnectionGUID: rTJh/tn7Q0KNznOhLH13Bw==
X-CSE-MsgGUID: ysh4KrOCRoWTjDvBEpYq5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24239364"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="24239364"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:56:37 -0700
X-CSE-ConnectionGUID: 0Zbb8TqrRqanZETzp6wlwg==
X-CSE-MsgGUID: VlD7KDGuRDSAvBeGDMM2kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62072660"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2024 19:56:35 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 5/5] vt-d/iommu: Enable batching of IOTLB/Dev-IOTLB invalidations
Date: Fri,  9 Aug 2024 10:54:31 +0800
Message-Id: <20240809025431.14605-6-tina.zhang@intel.com>
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

Enable batch processing for IOTLB/Dev-IOTLB invalidation commands of SVA
domains and default domains with ATS enabled.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/cache.c | 145 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/iommu.c |   1 +
 drivers/iommu/intel/iommu.h |   1 +
 drivers/iommu/intel/svm.c   |   5 +-
 4 files changed, 145 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 3ae84ccfcfa1..fabb98138760 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -59,10 +59,19 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 	tag->pasid = pasid;
 	tag->users = 1;
 
-	if (type == CACHE_TAG_DEVTLB || type == CACHE_TAG_NESTING_DEVTLB)
+	if (type == CACHE_TAG_DEVTLB || type == CACHE_TAG_NESTING_DEVTLB) {
 		tag->dev = dev;
-	else
+
+		if (!domain->qi_batch && iommu->qi)
+			/*
+			 * It doesn't matter if domain->qi_batch is NULL, as in
+			 * this case the commands will be submitted individually.
+			 */
+			domain->qi_batch = kzalloc(sizeof(struct qi_batch),
+						   GFP_KERNEL);
+	} else {
 		tag->dev = iommu->iommu.dev;
+	}
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(temp, &domain->cache_tags, node) {
@@ -255,6 +264,84 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
 }
 
+static inline void handle_batched_iotlb_descs(struct dmar_domain *domain,
+					 struct cache_tag *tag,
+					 unsigned long addr,
+					 unsigned long pages,
+					 unsigned long mask,
+					 int ih)
+{
+	struct intel_iommu *iommu = tag->iommu;
+
+	if (domain->use_first_level) {
+		qi_batch_add_piotlb_desc(iommu, tag->domain_id,
+					 tag->pasid, addr, pages,
+					 ih, domain->qi_batch);
+	} else {
+		/*
+		 * Fallback to domain selective flush if no
+		 * PSI support or the size is too big.
+		 */
+		if (!cap_pgsel_inv(iommu->cap) ||
+		    mask > cap_max_amask_val(iommu->cap) ||
+		    pages == -1)
+			qi_batch_add_iotlb_desc(iommu, tag->domain_id,
+						0, 0, DMA_TLB_DSI_FLUSH,
+						domain->qi_batch);
+		else
+			qi_batch_add_iotlb_desc(iommu, tag->domain_id,
+						addr | ih, mask,
+						DMA_TLB_PSI_FLUSH,
+						domain->qi_batch);
+	}
+
+}
+
+static inline void handle_batched_dev_tlb_descs(struct dmar_domain *domain,
+						struct cache_tag *tag,
+						unsigned long addr,
+						unsigned long mask)
+{
+	struct intel_iommu *iommu = tag->iommu;
+	struct device_domain_info *info;
+	u16 sid;
+
+	info = dev_iommu_priv_get(tag->dev);
+	sid = PCI_DEVID(info->bus, info->devfn);
+
+	if (tag->pasid == IOMMU_NO_PASID)
+		qi_batch_add_dev_iotlb_desc(iommu, sid, info->pfsid,
+					    info->ats_qdep, addr, mask,
+					    domain->qi_batch);
+	else
+		qi_batch_add_dev_iotlb_pasid_desc(iommu, sid, info->pfsid,
+						  tag->pasid, info->ats_qdep,
+						  addr, mask, domain->qi_batch);
+
+	batch_quirk_extra_dev_tlb_flush(info, addr, mask,
+					tag->pasid,
+					info->ats_qdep,
+					domain->qi_batch);
+}
+
+static void handle_batched_dev_tlb_descs_all(struct dmar_domain *domain,
+					    struct cache_tag *tag)
+{
+	struct intel_iommu *iommu = tag->iommu;
+	struct device_domain_info *info;
+	u16 sid;
+
+	info = dev_iommu_priv_get(tag->dev);
+	sid = PCI_DEVID(info->bus, info->devfn);
+
+	qi_batch_add_dev_iotlb_desc(iommu, sid, info->pfsid, info->ats_qdep,
+				    0, MAX_AGAW_PFN_WIDTH, domain->qi_batch);
+	batch_quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
+					IOMMU_NO_PASID, info->ats_qdep,
+					domain->qi_batch);
+
+}
+
 static inline void handle_iotlb_flush(struct dmar_domain *domain,
 				      struct cache_tag *tag,
 				      unsigned long addr,
@@ -264,6 +351,12 @@ static inline void handle_iotlb_flush(struct dmar_domain *domain,
 {
 	struct intel_iommu *iommu = tag->iommu;
 
+	if (domain->qi_batch) {
+		handle_batched_iotlb_descs(domain, tag, addr,
+					pages, mask, ih);
+		return;
+	}
+
 	if (domain->use_first_level) {
 		qi_flush_piotlb(iommu, tag->domain_id,
 				tag->pasid, addr, pages, ih);
@@ -284,7 +377,8 @@ static inline void handle_iotlb_flush(struct dmar_domain *domain,
 	}
 }
 
-static void handle_dev_tlb_flush(struct cache_tag *tag,
+static void handle_dev_tlb_flush(struct dmar_domain *domain,
+				 struct cache_tag *tag,
 				 unsigned long addr,
 				 unsigned long mask)
 {
@@ -292,6 +386,11 @@ static void handle_dev_tlb_flush(struct cache_tag *tag,
 	struct device_domain_info *info;
 	u16 sid;
 
+	if (domain->qi_batch) {
+		handle_batched_dev_tlb_descs(domain, tag, addr, mask);
+		return;
+	}
+
 	info = dev_iommu_priv_get(tag->dev);
 	sid = PCI_DEVID(info->bus, info->devfn);
 
@@ -306,12 +405,18 @@ static void handle_dev_tlb_flush(struct cache_tag *tag,
 	quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid, info->ats_qdep);
 }
 
-static void handle_dev_tlb_flush_all(struct cache_tag *tag)
+static void handle_dev_tlb_flush_all(struct dmar_domain *domain,
+				     struct cache_tag *tag)
 {
 	struct intel_iommu *iommu = tag->iommu;
 	struct device_domain_info *info;
 	u16 sid;
 
+	if (domain->qi_batch) {
+		handle_batched_dev_tlb_descs_all(domain, tag);
+		return;
+	}
+
 	info = dev_iommu_priv_get(tag->dev);
 	sid = PCI_DEVID(info->bus, info->devfn);
 
@@ -329,6 +434,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			   unsigned long end, int ih)
 {
 	unsigned long pages, mask, addr;
+	struct intel_iommu *iommu = NULL;
 	struct cache_tag *tag;
 	unsigned long flags;
 
@@ -336,6 +442,17 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
+		if (domain->qi_batch && iommu != tag->iommu) {
+			/*
+			 * If domain supports batching commands, need to flush the
+			 * batch buffer before switching to another iommu.
+			 */
+			if (iommu)
+				qi_batch_flush_descs(iommu, domain->qi_batch);
+
+			iommu = tag->iommu;
+		}
+
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
@@ -353,12 +470,14 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			mask = MAX_AGAW_PFN_WIDTH;
 			fallthrough;
 		case CACHE_TAG_DEVTLB:
-			handle_dev_tlb_flush(tag, addr, mask);
+			handle_dev_tlb_flush(domain, tag, addr, mask);
 			break;
 		}
 
 		trace_cache_tag_flush_range(tag, start, end, addr, pages, mask);
 	}
+	if (domain->qi_batch && domain->qi_batch->index)
+		qi_batch_flush_descs(iommu, domain->qi_batch);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
 
@@ -368,11 +487,23 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
  */
 void cache_tag_flush_all(struct dmar_domain *domain)
 {
+	struct intel_iommu *iommu = NULL;
 	struct cache_tag *tag;
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
+		if (domain->qi_batch && iommu != tag->iommu) {
+			/*
+			 * If domain supports batching commands, need to flush the
+			 * batch buffer before switching to another iommu.
+			 */
+			if (iommu)
+				qi_batch_flush_descs(iommu, domain->qi_batch);
+
+			iommu = tag->iommu;
+		}
+
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
@@ -380,12 +511,14 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 			break;
 		case CACHE_TAG_DEVTLB:
 		case CACHE_TAG_NESTING_DEVTLB:
-			handle_dev_tlb_flush_all(tag);
+			handle_dev_tlb_flush_all(domain, tag);
 			break;
 		}
 
 		trace_cache_tag_flush_all(tag);
 	}
+	if (domain->qi_batch && domain->qi_batch->index)
+		qi_batch_flush_descs(iommu, domain->qi_batch);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 160d569015b4..5907470b9b35 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1632,6 +1632,7 @@ static void domain_exit(struct dmar_domain *domain)
 	if (WARN_ON(!list_empty(&domain->devices)))
 		return;
 
+	kfree(domain->qi_batch);
 	kfree(domain);
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 04aa1f200124..f16ffda48095 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -625,6 +625,7 @@ struct dmar_domain {
 
 	spinlock_t cache_lock;		/* Protect the cache tag list */
 	struct list_head cache_tags;	/* Cache tag list */
+	struct qi_batch *qi_batch;	/* QI descriptors batch */
 
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0e3a9b38bef2..3421813995db 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -184,7 +184,10 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static void intel_mm_free_notifier(struct mmu_notifier *mn)
 {
-	kfree(container_of(mn, struct dmar_domain, notifier));
+	struct dmar_domain *domain = container_of(mn, struct dmar_domain, notifier);
+
+	kfree(domain->qi_batch);
+	kfree(domain);
 }
 
 static const struct mmu_notifier_ops intel_mmuops = {
-- 
2.43.0

