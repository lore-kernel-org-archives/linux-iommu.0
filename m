Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5717C68
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726328; cv=none; b=Ltazu2M4r0n3+pQfLQ0f6LJ7x5kxrBS0VHgNGHiOZBt8OJS2fsrv2X/F8KkxBUsZKbrU2jyk8FcM9+YBoacDfoB0PfLvD2DBJyrTX4oROHPfyh9iAJkZHNo8VrxiEkHQU90xevadw971aUUb5XDO6EO0+9f0mayYr2KfAL0xokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726328; c=relaxed/simple;
	bh=XUY4M10giWpp1imPrBkxND4P85th0AQd6g2stSV1JM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uiBOVCiHyZAgogTu3Q7UlzDosd3LV3XFXudLfANv+5vHaP+OoT97JUUpDtcW0BZN4hI3qEsFHCg8PkgcD1GQ5ZMQOmnbMZKuYzmcrPlYM1Z9NKl/11rcbPUqfD4ENagnCxASUJ5Ta0YwfHkprxMwEMPoDvjamJAIIaCLrbcLGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMNLPK5+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMNLPK5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726327; x=1762262327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XUY4M10giWpp1imPrBkxND4P85th0AQd6g2stSV1JM8=;
  b=kMNLPK5+5GeK8jRGkHzvCwiW/kSQ2Z2q2v1vaogkcZAWJX2NaNQQipxW
   c/Cj9F21P8+2O5eTHeCZGtlI/1un7GoJJBuAtiSimsoju+wHgNrHZWNZR
   e60bEANl1jDlhTuVNtnskqfEscgPhRUFPodXqH7fg0BO31q22Jfx7RBCz
   IU1YFHrP2rjwvsYKws48ZcsA28OJkdrha6A8a1fqbuqI0j8KyI3/9v3CO
   uv3FU8OwJZPnp/ki8pMfMMjS5Hzh+MubY8SjXU/ycrkx17fwjl17f0c8t
   Z6KNFvkKsHTMk1NWeogTURrU5aNzH5JrBgJnciSpsX0Wwrszs6CcMwmfy
   A==;
X-CSE-ConnectionGUID: BQ2jCkqUQi2ZKzOq7QIOkA==
X-CSE-MsgGUID: EJBjvJS4RYC2CpCXpXHMLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41003718"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="41003718"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:18:47 -0800
X-CSE-ConnectionGUID: p8CJc2ZbSder92qhFUgrFA==
X-CSE-MsgGUID: Z6ySCt9WR5qHTImZ5ueUng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83999477"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 04 Nov 2024 05:18:46 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v4 03/13] iommu/vt-d: Refactor the pasid setup helpers
Date: Mon,  4 Nov 2024 05:18:32 -0800
Message-Id: <20241104131842.13303-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104131842.13303-1-yi.l.liu@intel.com>
References: <20241104131842.13303-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As iommu driver is going to support pasid replacement, the new pasid replace
helpers need to config the pasid entry as well. Hence, there are quite a few
code to be shared with existing pasid setup helpers. This moves the pasid
config codes into helpers which can be used by existing pasid setup helpers
and the future new pasid replace helpers.

No functional change is intended.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/pasid.c | 169 ++++++++++++++++++++++--------------
 1 file changed, 105 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 81d038222414..65fd2fee01b7 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -325,6 +325,32 @@ static void intel_pasid_flush_present(struct intel_iommu *iommu,
  * Set up the scalable mode pasid table entry for first only
  * translation type.
  */
+static void pasid_pte_config_first_level(struct intel_iommu *iommu,
+					 struct pasid_entry *pte,
+					 pgd_t *pgd, u16 did, int flags)
+{
+	lockdep_assert_held(&iommu->lock);
+
+	pasid_clear_entry(pte);
+
+	/* Setup the first level page table pointer: */
+	pasid_set_flptr(pte, (u64)__pa(pgd));
+
+	if (flags & PASID_FLAG_FL5LP)
+		pasid_set_flpm(pte, 1);
+
+	if (flags & PASID_FLAG_PAGE_SNOOP)
+		pasid_set_pgsnp(pte);
+
+	pasid_set_domain_id(pte, did);
+	pasid_set_address_width(pte, iommu->agaw);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+
+	/* Setup Present and PASID Granular Transfer Type: */
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
+	pasid_set_present(pte);
+}
+
 int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 				  struct device *dev, pgd_t *pgd,
 				  u32 pasid, u16 did, int flags)
@@ -355,24 +381,8 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		return -EBUSY;
 	}
 
-	pasid_clear_entry(pte);
-
-	/* Setup the first level page table pointer: */
-	pasid_set_flptr(pte, (u64)__pa(pgd));
-
-	if (flags & PASID_FLAG_FL5LP)
-		pasid_set_flpm(pte, 1);
-
-	if (flags & PASID_FLAG_PAGE_SNOOP)
-		pasid_set_pgsnp(pte);
-
-	pasid_set_domain_id(pte, did);
-	pasid_set_address_width(pte, iommu->agaw);
-	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+	pasid_pte_config_first_level(iommu, pte, pgd, did, flags);
 
-	/* Setup Present and PASID Granular Transfer Type: */
-	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
-	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
 
 	pasid_flush_caches(iommu, pte, pasid, did);
@@ -402,6 +412,26 @@ static int iommu_skip_agaw(struct dmar_domain *domain,
 /*
  * Set up the scalable mode pasid entry for second only translation type.
  */
+static void pasid_pte_config_second_level(struct intel_iommu *iommu,
+					  struct pasid_entry *pte,
+					  u64 pgd_val, int agaw, u16 did,
+					  bool dirty_tracking)
+{
+	lockdep_assert_held(&iommu->lock);
+
+	pasid_clear_entry(pte);
+	pasid_set_domain_id(pte, did);
+	pasid_set_slptr(pte, pgd_val);
+	pasid_set_address_width(pte, agaw);
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_SL_ONLY);
+	pasid_set_fault_enable(pte);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+	if (dirty_tracking)
+		pasid_set_ssade(pte);
+
+	pasid_set_present(pte);
+}
+
 int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, u32 pasid)
@@ -444,17 +474,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 		return -EBUSY;
 	}
 
-	pasid_clear_entry(pte);
-	pasid_set_domain_id(pte, did);
-	pasid_set_slptr(pte, pgd_val);
-	pasid_set_address_width(pte, agaw);
-	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_SL_ONLY);
-	pasid_set_fault_enable(pte);
-	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
-	if (domain->dirty_tracking)
-		pasid_set_ssade(pte);
-
-	pasid_set_present(pte);
+	pasid_pte_config_second_level(iommu, pte, pgd_val, agaw,
+				      did, domain->dirty_tracking);
 	spin_unlock(&iommu->lock);
 
 	pasid_flush_caches(iommu, pte, pasid, did);
@@ -534,6 +555,20 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 /*
  * Set up the scalable mode pasid entry for passthrough translation type.
  */
+static void pasid_pte_config_pass_through(struct intel_iommu *iommu,
+					  struct pasid_entry *pte, u16 did)
+{
+	lockdep_assert_held(&iommu->lock);
+
+	pasid_clear_entry(pte);
+	pasid_set_domain_id(pte, did);
+	pasid_set_address_width(pte, iommu->agaw);
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_PT);
+	pasid_set_fault_enable(pte);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+	pasid_set_present(pte);
+}
+
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct device *dev, u32 pasid)
 {
@@ -552,13 +587,7 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 		return -EBUSY;
 	}
 
-	pasid_clear_entry(pte);
-	pasid_set_domain_id(pte, did);
-	pasid_set_address_width(pte, iommu->agaw);
-	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_PT);
-	pasid_set_fault_enable(pte);
-	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
-	pasid_set_present(pte);
+	pasid_pte_config_pass_through(iommu, pte, did);
 	spin_unlock(&iommu->lock);
 
 	pasid_flush_caches(iommu, pte, pasid, did);
@@ -589,6 +618,46 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	intel_pasid_flush_present(iommu, dev, pasid, did, pte);
 }
 
+static void pasid_pte_config_nestd(struct intel_iommu *iommu,
+				   struct pasid_entry *pte,
+				   struct iommu_hwpt_vtd_s1 *s1_cfg,
+				   struct dmar_domain *s2_domain,
+				   u16 did)
+{
+	struct dma_pte *pgd = s2_domain->pgd;
+
+	lockdep_assert_held(&iommu->lock);
+
+	pasid_clear_entry(pte);
+
+	if (s1_cfg->addr_width == ADDR_WIDTH_5LEVEL)
+		pasid_set_flpm(pte, 1);
+
+	pasid_set_flptr(pte, s1_cfg->pgtbl_addr);
+
+	if (s1_cfg->flags & IOMMU_VTD_S1_SRE) {
+		pasid_set_sre(pte);
+		if (s1_cfg->flags & IOMMU_VTD_S1_WPE)
+			pasid_set_wpe(pte);
+	}
+
+	if (s1_cfg->flags & IOMMU_VTD_S1_EAFE)
+		pasid_set_eafe(pte);
+
+	if (s2_domain->force_snooping)
+		pasid_set_pgsnp(pte);
+
+	pasid_set_slptr(pte, virt_to_phys(pgd));
+	pasid_set_fault_enable(pte);
+	pasid_set_domain_id(pte, did);
+	pasid_set_address_width(pte, s2_domain->agaw);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+	if (s2_domain->dirty_tracking)
+		pasid_set_ssade(pte);
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
+	pasid_set_present(pte);
+}
+
 /**
  * intel_pasid_setup_nested() - Set up PASID entry for nested translation.
  * @iommu:      IOMMU which the device belong to
@@ -606,7 +675,6 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 	struct iommu_hwpt_vtd_s1 *s1_cfg = &domain->s1_cfg;
 	struct dmar_domain *s2_domain = domain->s2_domain;
 	u16 did = domain_id_iommu(domain, iommu);
-	struct dma_pte *pgd = s2_domain->pgd;
 	struct pasid_entry *pte;
 
 	/* Address width should match the address width supported by hardware */
@@ -649,34 +717,7 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 		return -EBUSY;
 	}
 
-	pasid_clear_entry(pte);
-
-	if (s1_cfg->addr_width == ADDR_WIDTH_5LEVEL)
-		pasid_set_flpm(pte, 1);
-
-	pasid_set_flptr(pte, s1_cfg->pgtbl_addr);
-
-	if (s1_cfg->flags & IOMMU_VTD_S1_SRE) {
-		pasid_set_sre(pte);
-		if (s1_cfg->flags & IOMMU_VTD_S1_WPE)
-			pasid_set_wpe(pte);
-	}
-
-	if (s1_cfg->flags & IOMMU_VTD_S1_EAFE)
-		pasid_set_eafe(pte);
-
-	if (s2_domain->force_snooping)
-		pasid_set_pgsnp(pte);
-
-	pasid_set_slptr(pte, virt_to_phys(pgd));
-	pasid_set_fault_enable(pte);
-	pasid_set_domain_id(pte, did);
-	pasid_set_address_width(pte, s2_domain->agaw);
-	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
-	if (s2_domain->dirty_tracking)
-		pasid_set_ssade(pte);
-	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
-	pasid_set_present(pte);
+	pasid_pte_config_nestd(iommu, pte, s1_cfg, s2_domain, did);
 	spin_unlock(&iommu->lock);
 
 	pasid_flush_caches(iommu, pte, pasid, did);
-- 
2.34.1

