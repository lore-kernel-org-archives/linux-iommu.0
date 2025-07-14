Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5132153F1
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468779; cv=none; b=d1TaNojV4haRgR3DKm386h9+3KHP093XWi1sqlIDDaBiwOAc1JmO8iDgrc9JNQXJwYbZ/TUgIvARiWTag0ogFs05Rh+T7VpOsiuVaHQOCjOzufjVPvcu8KJGPxa80Knw1cfFKf4RnCWyJxa4zViRnCC4lQeovLFP29Uvd99hAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468779; c=relaxed/simple;
	bh=/K48GTJABaYkID4O43SBS3bLezuf6em0COXTSVHitjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGGKvN3sKQrSyeQuuC3ZpV/njjDIIowq/ry+6NOG6PtoYnJ7O5ATITJJYgzmG6Wp+LjtdudYfR7s2Ep5+5vLl5sbX0ceb3boPwvxB4+itttJWuPWp1r5E/MUmI508ndtELOIHrLgQi6s9+sWcYrehFA3svQYnLYdlm/DL0WgMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJZyXTNN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJZyXTNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468777; x=1784004777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/K48GTJABaYkID4O43SBS3bLezuf6em0COXTSVHitjU=;
  b=UJZyXTNNb5nozwdUFiXUmfqwJn7M/S5NkPnT3XbX15CMObn7dTVlMzpv
   FQrG6J6AX0eeyMAGlK21WCZLSdeTuQtAIsiF/vOa2ujiRslCeAgn2xrDK
   GD3Yrtij6xap0kmuLn+tAYSDXVxQEZ8ycnl2CNgd4oymWCQg/RVCKtwXi
   T/LHNIFtDMfWKlE75dr4uyq4Z5tzBTXLoE/vDSVk3QH/m2zzs5jIuzVZR
   jHN/kqpYmJl65WxNaHDwWc9tUUag2eN6Qz0+2tqMc7o7LZZ6kauM/DFvO
   ySiO+DwVsRYqQZ4ksHny0UesWNewvKB5nPT+3dQEwTk8/uCS1w/qu8Ysp
   A==;
X-CSE-ConnectionGUID: s8jrSrTFSVaQarwRMuAvEw==
X-CSE-MsgGUID: 9OyBvpB0QNGQo7BYDCvBTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765062"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765062"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:57 -0700
X-CSE-ConnectionGUID: 6A6KHF5USeOmFRjmrW5cdQ==
X-CSE-MsgGUID: YfYsnvz5QnO2n/upohUSbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166186"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:56 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] iommu/vt-d: Create unique domain ops for each stage
Date: Mon, 14 Jul 2025 12:50:24 +0800
Message-ID: <20250714045028.958850-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

Use the domain ops pointer to tell what kind of domain it is instead of
the internal use_first_level indication. This also protects against
wrongly using a SVA/nested/IDENTITY/BLOCKED domain type in places they
should not be.

The only remaining uses of use_first_level outside the paging domain are in
paging_domain_compatible() and intel_iommu_enforce_cache_coherency().

Thus, remove the useless sets of use_first_level in
intel_svm_domain_alloc() and intel_iommu_domain_alloc_nested(). None of
the unique ops for these domain types ever reference it on their call
chains.

Add a WARN_ON() check in domain_context_mapping_one() as it only works
with second stage.

This is preparation for iommupt which will have different ops for each of
the stages.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/5-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c  |  5 +--
 drivers/iommu/intel/iommu.c  | 60 +++++++++++++++++++++++++-----------
 drivers/iommu/intel/iommu.h  | 12 ++++++++
 drivers/iommu/intel/nested.c |  4 +--
 drivers/iommu/intel/svm.c    |  1 -
 5 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 47692cbfaabd..876630e10849 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -370,7 +370,7 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	struct intel_iommu *iommu = tag->iommu;
 	u64 type = DMA_TLB_PSI_FLUSH;
 
-	if (domain->use_first_level) {
+	if (intel_domain_is_fs_paging(domain)) {
 		qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid, addr,
 				    pages, ih, domain->qi_batch);
 		return;
@@ -545,7 +545,8 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			qi_batch_flush_descs(iommu, domain->qi_batch);
 		iommu = tag->iommu;
 
-		if (!cap_caching_mode(iommu->cap) || domain->use_first_level) {
+		if (!cap_caching_mode(iommu->cap) ||
+		    intel_domain_is_fs_paging(domain)) {
 			iommu_flush_write_buffer(iommu);
 			continue;
 		}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0ac3c3a6d9e7..b7b1a3d2cbfc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1462,6 +1462,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	int ret;
 
+	if (WARN_ON(!intel_domain_is_ss_paging(domain)))
+		return -EINVAL;
+
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
@@ -1780,7 +1783,7 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
 				       struct intel_iommu *iommu)
 {
-	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
+	if (cap_caching_mode(iommu->cap) && intel_domain_is_ss_paging(domain))
 		return true;
 
 	if (rwbf_quirk || cap_rwbf(iommu->cap))
@@ -1812,12 +1815,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 
 	if (!sm_supported(iommu))
 		ret = domain_context_mapping(domain, dev);
-	else if (domain->use_first_level)
+	else if (intel_domain_is_fs_paging(domain))
 		ret = domain_setup_first_level(iommu, domain, dev,
 					       IOMMU_NO_PASID, NULL);
-	else
+	else if (intel_domain_is_ss_paging(domain))
 		ret = domain_setup_second_level(iommu, domain, dev,
 						IOMMU_NO_PASID, NULL);
+	else if (WARN_ON(true))
+		ret = -EINVAL;
 
 	if (ret)
 		goto out_block_translation;
@@ -3288,7 +3293,6 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	domain->use_first_level = first_stage;
 
 	domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
-	domain->domain.ops = intel_iommu_ops.default_domain_ops;
 
 	/* calculate the address width */
 	addr_width = agaw_to_width(iommu->agaw);
@@ -3346,6 +3350,8 @@ intel_iommu_domain_alloc_first_stage(struct device *dev,
 	dmar_domain = paging_domain_alloc(dev, true);
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
+
+	dmar_domain->domain.ops = &intel_fs_paging_domain_ops;
 	return &dmar_domain->domain;
 }
 
@@ -3374,6 +3380,7 @@ intel_iommu_domain_alloc_second_stage(struct device *dev,
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
 
+	dmar_domain->domain.ops = &intel_ss_paging_domain_ops;
 	dmar_domain->nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
@@ -4107,12 +4114,15 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_remove_dev_pasid;
 
-	if (dmar_domain->use_first_level)
+	if (intel_domain_is_fs_paging(dmar_domain))
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid, old);
-	else
+	else if (intel_domain_is_ss_paging(dmar_domain))
 		ret = domain_setup_second_level(iommu, dmar_domain,
 						dev, pasid, old);
+	else if (WARN_ON(true))
+		ret = -EINVAL;
+
 	if (ret)
 		goto out_unwind_iopf;
 
@@ -4387,6 +4397,32 @@ static struct iommu_domain identity_domain = {
 	},
 };
 
+const struct iommu_domain_ops intel_fs_paging_domain_ops = {
+	.attach_dev = intel_iommu_attach_device,
+	.set_dev_pasid = intel_iommu_set_dev_pasid,
+	.map_pages = intel_iommu_map_pages,
+	.unmap_pages = intel_iommu_unmap_pages,
+	.iotlb_sync_map = intel_iommu_iotlb_sync_map,
+	.flush_iotlb_all = intel_flush_iotlb_all,
+	.iotlb_sync = intel_iommu_tlb_sync,
+	.iova_to_phys = intel_iommu_iova_to_phys,
+	.free = intel_iommu_domain_free,
+	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+};
+
+const struct iommu_domain_ops intel_ss_paging_domain_ops = {
+	.attach_dev = intel_iommu_attach_device,
+	.set_dev_pasid = intel_iommu_set_dev_pasid,
+	.map_pages = intel_iommu_map_pages,
+	.unmap_pages = intel_iommu_unmap_pages,
+	.iotlb_sync_map = intel_iommu_iotlb_sync_map,
+	.flush_iotlb_all = intel_flush_iotlb_all,
+	.iotlb_sync = intel_iommu_tlb_sync,
+	.iova_to_phys = intel_iommu_iova_to_phys,
+	.free = intel_iommu_domain_free,
+	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+};
+
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
 	.release_domain		= &blocking_domain,
@@ -4405,18 +4441,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.pgsize_bitmap		= SZ_4K,
 	.page_response		= intel_iommu_page_response,
-	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= intel_iommu_attach_device,
-		.set_dev_pasid		= intel_iommu_set_dev_pasid,
-		.map_pages		= intel_iommu_map_pages,
-		.unmap_pages		= intel_iommu_unmap_pages,
-		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-		.flush_iotlb_all        = intel_flush_iotlb_all,
-		.iotlb_sync		= intel_iommu_tlb_sync,
-		.iova_to_phys		= intel_iommu_iova_to_phys,
-		.free			= intel_iommu_domain_free,
-		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
-	}
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 50d69cc88a1f..d09b92871659 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1380,6 +1380,18 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 					 u8 devfn, int alloc);
 
 extern const struct iommu_ops intel_iommu_ops;
+extern const struct iommu_domain_ops intel_fs_paging_domain_ops;
+extern const struct iommu_domain_ops intel_ss_paging_domain_ops;
+
+static inline bool intel_domain_is_fs_paging(struct dmar_domain *domain)
+{
+	return domain->domain.ops == &intel_fs_paging_domain_ops;
+}
+
+static inline bool intel_domain_is_ss_paging(struct dmar_domain *domain)
+{
+	return domain->domain.ops == &intel_ss_paging_domain_ops;
+}
 
 #ifdef CONFIG_INTEL_IOMMU
 extern int intel_iommu_sm;
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index fc312f649f9e..1b6ad9c900a5 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -216,8 +216,7 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	/* Must be nested domain */
 	if (user_data->type != IOMMU_HWPT_DATA_VTD_S1)
 		return ERR_PTR(-EOPNOTSUPP);
-	if (parent->ops != intel_iommu_ops.default_domain_ops ||
-	    !s2_domain->nested_parent)
+	if (!intel_domain_is_ss_paging(s2_domain) || !s2_domain->nested_parent)
 		return ERR_PTR(-EINVAL);
 
 	ret = iommu_copy_struct_from_user(&vtd, user_data,
@@ -229,7 +228,6 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->use_first_level = true;
 	domain->s2_domain = s2_domain;
 	domain->s1_cfg = vtd;
 	domain->domain.ops = &intel_nested_domain_ops;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8c0bed36c587..e147f71f91b7 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -214,7 +214,6 @@ struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	domain->domain.ops = &intel_svm_domain_ops;
-	domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->dev_pasids);
 	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->cache_lock);
-- 
2.43.0

