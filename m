Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D916CD0F
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183100; cv=none; b=G7ietXcAoinJBG7pSC+ZDLa3gqDlan1XkW03YqywjL6czCo7lFGUxYN+h/84TWqu9DbsFQDgs/Jk/MhnsfMG3s44j97spfils3B7ffymXToF5AiOZx4Exc+tuIuVqBIcCHftS9PdH0OLgRRjMnqHxfEzTKmc0lN5Iyt+JptNSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183100; c=relaxed/simple;
	bh=mtEW4ev0XF+iEMlZrviXKZKC5R84z3hVc9Es+xopaqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0eg4hqNMIO086q7KVD5Kgv2Uy4PAEWvtm2oi0B1/7gdROhCvj/+u4gASL4af1FKSNdwCUDIcTDV+3HuwtYHfCt/4x1Xb6A8fj1oS526Nj3ydoepsf0lsFZyvKtQ+sxDwMx06UAu5ecCa0ktL71oqEWS/Gp9+bFvOAJdF9E5nSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHp2Mpqb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHp2Mpqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723183099; x=1754719099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mtEW4ev0XF+iEMlZrviXKZKC5R84z3hVc9Es+xopaqY=;
  b=gHp2MpqbbtRKTvLXh27OJ3h8LefsTUyj+znKbl5Mtta+3Isp4doGAXd1
   9SSOVaX10ZDZflL6/fLaDTOSdGyVOuaod+R9GJXlgGuEYjWuVWyyYT2fo
   GVbLYaUPmC7rN8pz+VU+OcRLrxs31qEWRbi2L1WO9nofrKGFfkFxZEV+O
   WcMKJhUtX2QxWRKgk+SLzfTDipw+CFxNn5BJk8dmsSZHyXaucqdRHEBCB
   QJqJmNVeQqH4YcpbHrR/xSz3GF7jVa1ieeW7audAEmg5tnNUK4GATx9pE
   aPQwyDiz6fp8ouF/0LXrJACK28qELciSTS2cd52SLp5IPVBPJ5mNsgHoE
   w==;
X-CSE-ConnectionGUID: 1Klv0Lt6SCu1a5R/55en2Q==
X-CSE-MsgGUID: lZgu/uucSO2xk6hdgjxdEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21469181"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21469181"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 22:58:19 -0700
X-CSE-ConnectionGUID: ABrRPWwtTy+x1i0mwY/L+w==
X-CSE-MsgGUID: v3x3qcDXQOisvGdbhg23SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57540949"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 22:58:17 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 7/7] iommu/vt-d: Cleanup si_domain
Date: Fri,  9 Aug 2024 13:54:31 +0800
Message-Id: <20240809055431.36513-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809055431.36513-1-baolu.lu@linux.intel.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static identity domain has been introduced, rendering the si_domain
obsolete. Remove si_domain and cleanup the code accordingly.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 91 ++++++++-----------------------------
 1 file changed, 19 insertions(+), 72 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 14f1fcf17152..159da629349c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -167,8 +167,6 @@ static void device_rbtree_remove(struct device_domain_info *info)
 	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
 }
 
-static struct dmar_domain *si_domain;
-
 struct dmar_rmrr_unit {
 	struct list_head list;		/* list of rmrr units	*/
 	struct acpi_dmar_header *hdr;	/* ACPI header		*/
@@ -286,11 +284,6 @@ static int __init intel_iommu_setup(char *str)
 }
 __setup("intel_iommu=", intel_iommu_setup);
 
-static int domain_type_is_si(struct dmar_domain *domain)
-{
-	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
-}
-
 static int domain_pfn_supported(struct dmar_domain *domain, unsigned long pfn)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
@@ -1664,9 +1657,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	int agaw, ret;
 
-	if (domain_type_is_si(domain))
-		translation = CONTEXT_TT_PASS_THROUGH;
-
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
@@ -1685,34 +1675,24 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	context_set_domain_id(context, did);
 
-	if (translation != CONTEXT_TT_PASS_THROUGH) {
-		/*
-		 * Skip top levels of page tables for iommu which has
-		 * less agaw than default. Unnecessary for PT mode.
-		 */
-		for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-			ret = -ENOMEM;
-			pgd = phys_to_virt(dma_pte_addr(pgd));
-			if (!dma_pte_present(pgd))
-				goto out_unlock;
-		}
-
-		if (info && info->ats_supported)
-			translation = CONTEXT_TT_DEV_IOTLB;
-		else
-			translation = CONTEXT_TT_MULTI_LEVEL;
-
-		context_set_address_root(context, virt_to_phys(pgd));
-		context_set_address_width(context, agaw);
-	} else {
-		/*
-		 * In pass through mode, AW must be programmed to
-		 * indicate the largest AGAW value supported by
-		 * hardware. And ASR is ignored by hardware.
-		 */
-		context_set_address_width(context, iommu->msagaw);
+	/*
+	 * Skip top levels of page tables for iommu which has
+	 * less agaw than default. Unnecessary for PT mode.
+	 */
+	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
+		ret = -ENOMEM;
+		pgd = phys_to_virt(dma_pte_addr(pgd));
+		if (!dma_pte_present(pgd))
+			goto out_unlock;
 	}
 
+	if (info && info->ats_supported)
+		translation = CONTEXT_TT_DEV_IOTLB;
+	else
+		translation = CONTEXT_TT_MULTI_LEVEL;
+
+	context_set_address_root(context, virt_to_phys(pgd));
+	context_set_address_width(context, agaw);
 	context_set_translation_type(context, translation);
 	context_set_fault_enable(context);
 	context_set_present(context);
@@ -1977,23 +1957,6 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
-static int md_domain_init(struct dmar_domain *domain, int guest_width);
-
-static int __init si_domain_init(void)
-{
-	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
-	if (!si_domain)
-		return -EFAULT;
-
-	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-		domain_exit(si_domain);
-		si_domain = NULL;
-		return -EFAULT;
-	}
-
-	return 0;
-}
-
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
@@ -2016,8 +1979,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 
 	if (!sm_supported(iommu))
 		ret = domain_context_mapping(domain, dev);
-	else if (domain_type_is_si(domain))
-		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
 	else if (domain->use_first_level)
 		ret = domain_setup_first_level(iommu, domain, dev, IOMMU_NO_PASID);
 	else
@@ -2026,8 +1987,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
-	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
-		iommu_enable_pci_caps(info);
+	iommu_enable_pci_caps(info);
 
 	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 	if (ret)
@@ -2386,10 +2346,6 @@ static int __init init_dmars(void)
 
 	check_tylersburg_isoch();
 
-	ret = si_domain_init();
-	if (ret)
-		goto free_iommu;
-
 	/*
 	 * for each drhd
 	 *   enable fault log
@@ -2435,10 +2391,6 @@ static int __init init_dmars(void)
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
-	if (si_domain) {
-		domain_exit(si_domain);
-		si_domain = NULL;
-	}
 
 	return ret;
 }
@@ -3572,8 +3524,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		domain->geometry.force_aperture = true;
 
 		return domain;
-	case IOMMU_DOMAIN_IDENTITY:
-		return &si_domain->domain;
 	default:
 		return NULL;
 	}
@@ -3640,8 +3590,7 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 
 	WARN_ON(dmar_domain->nested_parent &&
 		!list_empty(&dmar_domain->s1_domains));
-	if (domain != &si_domain->domain)
-		domain_exit(dmar_domain);
+	domain_exit(dmar_domain);
 }
 
 int prepare_domain_attach_device(struct iommu_domain *domain,
@@ -4364,9 +4313,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_detach_iommu;
 
-	if (domain_type_is_si(dmar_domain))
-		ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
-	else if (dmar_domain->use_first_level)
+	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
 	else
-- 
2.34.1

