Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1171F9AA4
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621133; cv=none; b=CLm8GUd/jawUDpZ6ubZwibKIz14ToOLmk1nPokluOWRa9mi3GxmdGaxfjNg3PqwxF8Hz6s3fCT3I5KEV057MDpt1/k4N1jGhZao53gTL025gcD0gFlKs69pW+ynf886g2GVdDa+Xljhc2ppWUfekpZlVq+VQ672Jh8rswFvoPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621133; c=relaxed/simple;
	bh=UTBlQOi+stEX3XIyVuR9P1VuUd5LAYimx8CGympPPL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5vh3yiUxb8ohdiYDLP0f/FWvvqwiUXarLUDFqJ9Ep72gW2oYMB1P0XFMulIVqYo/ZTMMUKo7WGyphTKDuRGpdeJRo1OH+riGSIbEFfyg7sDJSDixhjvHZiFIHzYuNZXT4CetOQ6NuIQhp7jy+MclUNGo2xI8RmBhXT1cQGJ9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkACw/Pn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkACw/Pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621132; x=1760157132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UTBlQOi+stEX3XIyVuR9P1VuUd5LAYimx8CGympPPL8=;
  b=WkACw/PnmXjw6GaGjvpgkHEgxk7gdfVLYvTzVAIA8By7FWcaZ47WgLOV
   r84864Lx5p0hw9V+Y4UI7/mKJRwypZt2V8eHxwp7XG69l5iaqfI7pl3K6
   cYtBXqYJW/wL1Q3YWf9m/C+nfrAgDXb3PK0MQgswV7eb8aTH9u+pxmHAA
   LMKYJOSRA2qX0xpXVwyymQXIpqZQehlBd4g++hVYSV0QVs2e85YEjILMP
   3WRDZyTNUFyG2JBBM6tfv+ON7ORC4eqz8cX/2Lt9IOeKZ+xnwHlf8tyqn
   A/J4KWa5vztsolHPDtneCIQYjjTgX/BDzKzMuuAyAtSkHAPX/s7A5TS6w
   A==;
X-CSE-ConnectionGUID: MdEgMAQGT3OUGEjeYws5FQ==
X-CSE-MsgGUID: nbUz1TZQRICYpNo625jztA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28101769"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28101769"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:32:11 -0700
X-CSE-ConnectionGUID: Kw3eTvwuThyKT90ND2+ooQ==
X-CSE-MsgGUID: RIGdyHj0Ti2a1Nf+skQsVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81412185"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 21:32:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging domain attach
Date: Fri, 11 Oct 2024 12:27:18 +0800
Message-ID: <20241011042722.73930-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011042722.73930-1-baolu.lu@linux.intel.com>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
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

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 70 ++++++++++++-------------------------
 drivers/iommu/intel/pasid.c | 28 +--------------
 2 files changed, 24 insertions(+), 74 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dd158ff5fd45..f6a3266b17d4 100644
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
 
@@ -3506,27 +3483,26 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 	if (domain->dirty_ops && !ssads_supported(iommu))
 		return -EINVAL;
 
-	/* check if this iommu agaw is sufficient for max mapped address */
-	addr_width = agaw_to_width(iommu->agaw);
-	if (addr_width > cap_mgaw(iommu->cap))
-		addr_width = cap_mgaw(iommu->cap);
-
-	if (dmar_domain->max_addr > (1LL << addr_width))
+	if (dmar_domain->iommu_coherency !=
+			iommu_paging_structure_coherency(iommu))
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
+
+	if (domain->type & __IOMMU_DOMAIN_PAGING) {
+		if (dmar_domain->iommu_superpage !=
+				iommu_superpage_capability(iommu, dmar_domain->use_first_level))
+			return -EINVAL;
+
+		if (dmar_domain->use_first_level &&
+		    (!sm_supported(iommu) || !ecap_flts(iommu->ecap)))
+			return -EINVAL;
+
+		/* check if this iommu agaw is sufficient for max mapped address */
+		addr_width = agaw_to_width(iommu->agaw);
+		if (addr_width > cap_mgaw(iommu->cap))
+			addr_width = cap_mgaw(iommu->cap);
+
+		if (dmar_domain->gaw > addr_width || dmar_domain->agaw > iommu->agaw)
+			return -EINVAL;
 	}
 
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
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

