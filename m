Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AE165F1A
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684490; cv=none; b=svUqr8JrtFZcEV6/Tf7507MzjxCA2tIEmGqVwBGrPszjeL1k9yOnv2WiiohXg6e2ZNNaOfFJGBz4nCdTWCx9I2yq5HrYnbptMwPf8hMiEjuncfa9iAJXof/t1ZiQA0IOl6r/YgMs+MLZsST8uY8xL0R2LDUFbM6Exr32WdsJUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684490; c=relaxed/simple;
	bh=LbHzjAUeQ3zsb39FqSUhJRB8MTVCVe7JjRVHN/PvsKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX07Z+PapeHXRIX/YWTGqxsMxLzHcbaMwImS0tktMVqKzp9OCjYGCf3WZyLEYRgb3T51PcoiqMSKV9yVS2HyEeRJ0bxfZb7Gf8MmQqgOL4p9rLnciiCOfAbbPESZpy+qdXr/96UeW+hujvTlsu1lYd2bkb6j/2aPaA8F9Wh/H28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jo228Esx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jo228Esx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684488; x=1762220488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LbHzjAUeQ3zsb39FqSUhJRB8MTVCVe7JjRVHN/PvsKE=;
  b=Jo228Esxcdz0JplhEtj4R53FWMqVDW3T35PAhJ4BuzqFzXSzXQs1v6zR
   yWyKQQab0UGNZoyZPehNOmUB9aBQj4tTqlY9+hSxa01xliyBYrbQJ12+4
   n5Tg2ABoPHlwVKQwLTRbICOP8yvfOd1oy4sSB8kD69oETLCUYZfjjnsk7
   IlkgCPy1w+I96m9rEQ4zYUSUdfJ6JurVQ3hI8UUcQAIq/3DgQDInc44wh
   x3XVjDw/LQmXFsKIB4dLxa2zyG9onhY/7MYnbH7a42/pHCggfxHJJVuLV
   bSfeyuFBvTwcOENAUxyp12qIdldVwYooBKEQb6Ztoy7LYH+edWCEXRhwh
   A==;
X-CSE-ConnectionGUID: nIP78GSUQrOmNOjF3B1/jw==
X-CSE-MsgGUID: 37pc7LhfTIiejcAxdSiKzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221918"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221918"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:28 -0800
X-CSE-ConnectionGUID: Ku8NpdsGS1ypwZCf1hbjgQ==
X-CSE-MsgGUID: d6vFzYqwR7G9pCleVfcW2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020875"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:27 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] iommu/vt-d: Enhance compatibility check for paging domain attach
Date: Mon,  4 Nov 2024 09:40:23 +0800
Message-ID: <20241104014040.106100-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver now supports domain_alloc_paging, ensuring that a valid device
pointer is provided whenever a paging domain is allocated. Additionally,
the dmar_domain attributes are set up at the time of allocation.

Consistent with the established semantics in the IOMMU core, if a domain is
attached to a device and found to be incompatible with the IOMMU hardware
capabilities, the operation will return an -EINVAL error. This implicitly
advises the caller to allocate a new domain for the device and attempt the
domain attachment again.

Rename prepare_domain_attach_device() to a more meaningful name.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20241021085125.192333-4-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c  | 70 ++++++++++++------------------------
 drivers/iommu/intel/iommu.h  |  3 +-
 drivers/iommu/intel/nested.c |  2 +-
 drivers/iommu/intel/pasid.c  | 28 +--------------
 4 files changed, 26 insertions(+), 77 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 204e624b3f9a..0fca84ac6794 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1606,7 +1606,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	int translation = CONTEXT_TT_MULTI_LEVEL;
 	struct dma_pte *pgd = domain->pgd;
 	struct context_entry *context;
-	int agaw, ret;
+	int ret;
 
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
@@ -1623,27 +1623,15 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	copied_context_tear_down(iommu, context, bus, devfn);
 	context_clear_entry(context);
-
 	context_set_domain_id(context, did);
 
-	/*
-	 * Skip top levels of page tables for iommu which has
-	 * less agaw than default. Unnecessary for PT mode.
-	 */
-	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-		ret = -ENOMEM;
-		pgd = phys_to_virt(dma_pte_addr(pgd));
-		if (!dma_pte_present(pgd))
-			goto out_unlock;
-	}
-
 	if (info && info->ats_supported)
 		translation = CONTEXT_TT_DEV_IOTLB;
 	else
 		translation = CONTEXT_TT_MULTI_LEVEL;
 
 	context_set_address_root(context, virt_to_phys(pgd));
-	context_set_address_width(context, agaw);
+	context_set_address_width(context, domain->agaw);
 	context_set_translation_type(context, translation);
 	context_set_fault_enable(context);
 	context_set_present(context);
@@ -1876,20 +1864,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 				    u32 pasid)
 {
 	struct dma_pte *pgd = domain->pgd;
-	int agaw, level;
-	int flags = 0;
+	int level, flags = 0;
 
-	/*
-	 * Skip top levels of page tables for iommu which has
-	 * less agaw than default. Unnecessary for PT mode.
-	 */
-	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-		pgd = phys_to_virt(dma_pte_addr(pgd));
-		if (!dma_pte_present(pgd))
-			return -ENOMEM;
-	}
-
-	level = agaw_to_level(agaw);
+	level = agaw_to_level(domain->agaw);
 	if (level != 4 && level != 5)
 		return -EINVAL;
 
@@ -3494,42 +3471,41 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 	domain_exit(dmar_domain);
 }
 
-int prepare_domain_attach_device(struct iommu_domain *domain,
-				 struct device *dev)
+int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
 	int addr_width;
 
+	if (WARN_ON_ONCE(!(domain->type & __IOMMU_DOMAIN_PAGING)))
+		return -EPERM;
+
 	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
 		return -EINVAL;
 
 	if (domain->dirty_ops && !ssads_supported(iommu))
 		return -EINVAL;
 
+	if (dmar_domain->iommu_coherency !=
+			iommu_paging_structure_coherency(iommu))
+		return -EINVAL;
+
+	if (dmar_domain->iommu_superpage !=
+			iommu_superpage_capability(iommu, dmar_domain->use_first_level))
+		return -EINVAL;
+
+	if (dmar_domain->use_first_level &&
+	    (!sm_supported(iommu) || !ecap_flts(iommu->ecap)))
+		return -EINVAL;
+
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
 		addr_width = cap_mgaw(iommu->cap);
 
-	if (dmar_domain->max_addr > (1LL << addr_width))
+	if (dmar_domain->gaw > addr_width || dmar_domain->agaw > iommu->agaw)
 		return -EINVAL;
-	dmar_domain->gaw = addr_width;
-
-	/*
-	 * Knock out extra levels of page tables if necessary
-	 */
-	while (iommu->agaw < dmar_domain->agaw) {
-		struct dma_pte *pte;
-
-		pte = dmar_domain->pgd;
-		if (dma_pte_present(pte)) {
-			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
-			iommu_free_page(pte);
-		}
-		dmar_domain->agaw--;
-	}
 
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
 	    context_copied(iommu, info->bus, info->devfn))
@@ -3545,7 +3521,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 
 	device_block_translation(dev);
 
-	ret = prepare_domain_attach_device(domain, dev);
+	ret = paging_domain_compatible(domain, dev);
 	if (ret)
 		return ret;
 
@@ -4216,7 +4192,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
-	ret = prepare_domain_attach_device(domain, dev);
+	ret = paging_domain_compatible(domain, dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1497f3112b12..b1928ca3aaa8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1230,8 +1230,7 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
-int prepare_domain_attach_device(struct iommu_domain *domain,
-				 struct device *dev);
+int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
 void domain_update_iommu_cap(struct dmar_domain *domain);
 
 int dmar_ir_support(void);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 433c58944401..96016bc40f94 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	 * The s2_domain will be used in nested translation, hence needs
 	 * to ensure the s2_domain is compatible with this IOMMU.
 	 */
-	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
+	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
 	if (ret) {
 		dev_err_ratelimited(dev, "s2 domain is not compatible\n");
 		return ret;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 2e5fa0a23299..53157e1194f4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -345,25 +345,6 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	return 0;
 }
 
-/*
- * Skip top levels of page tables for iommu which has less agaw
- * than default. Unnecessary for PT mode.
- */
-static int iommu_skip_agaw(struct dmar_domain *domain,
-			   struct intel_iommu *iommu,
-			   struct dma_pte **pgd)
-{
-	int agaw;
-
-	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-		*pgd = phys_to_virt(dma_pte_addr(*pgd));
-		if (!dma_pte_present(*pgd))
-			return -EINVAL;
-	}
-
-	return agaw;
-}
-
 /*
  * Set up the scalable mode pasid entry for second only translation type.
  */
@@ -374,7 +355,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	struct pasid_entry *pte;
 	struct dma_pte *pgd;
 	u64 pgd_val;
-	int agaw;
 	u16 did;
 
 	/*
@@ -388,12 +368,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	}
 
 	pgd = domain->pgd;
-	agaw = iommu_skip_agaw(domain, iommu, &pgd);
-	if (agaw < 0) {
-		dev_err(dev, "Invalid domain page table\n");
-		return -EINVAL;
-	}
-
 	pgd_val = virt_to_phys(pgd);
 	did = domain_id_iommu(domain, iommu);
 
@@ -412,7 +386,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
 	pasid_set_slptr(pte, pgd_val);
-	pasid_set_address_width(pte, agaw);
+	pasid_set_address_width(pte, domain->agaw);
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_SL_ONLY);
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
-- 
2.43.0

