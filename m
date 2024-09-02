Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02952D7B8
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244294; cv=none; b=D1wjkFODvfCkxjYW5tYNqKn3ikG1vn+TXOevddowGkPgjtq666Duc5v4zyAL6fKk1anDYvvabiKTFYayg7o03yTu0dM9e8m7+sMGOfe5Ou1Z8n/rW+qiSztw7ZDZF2xf0VPeBhZ4al0//EtSONJl/xTmM0DDR/apoZ1MoD3ZVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244294; c=relaxed/simple;
	bh=1tvzBKq+Ft34pip0KC4KcaOEa/uEFjJ1tKEKuGuNIgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cU9xpQ9BdzSoi2THubh/UdfFCStOKp0by7yY9dIIyrS6kqQow35GuZJOnN77dPtzxVHHw8fKjw+Q4TrpF5E2HdSZp0tKHT6ADDSw2cYVmUl0kik50f0lWLMOTls4vUZWF+JAHRHRur+aVpgl43W5ZcCDdxqtreIswLG33lE3E5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noo6Tr4z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noo6Tr4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244293; x=1756780293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1tvzBKq+Ft34pip0KC4KcaOEa/uEFjJ1tKEKuGuNIgc=;
  b=noo6Tr4zmCMcNr3MMi4cLlsfbPkQNrWRMUGX9mJ1RDSN6ipq1MSTAanl
   oVJM6K19ISHy7a0k1HweRIG9o4TYzAKFg+ASNsn69djDAWsMnhfzE1ie0
   nlCiaI0TXHJDgZDlQImDhNy1Nxu1VLGr0Tiypht4nTKA5WciVU45QReJp
   ZepECX0Bjw7dz2qa+wnM0VM7rUAUxxcyINpIzrtxxLcdwVl/bUJTerYy3
   7GsRzFMPNrlQEqvK+ZovSjrBenx4/NOMW1JQDnKy52FLsi5X/4bmBFlHt
   OVz2k3NMYuVhPPKWskhmCjSyVENjyTab83ecIRSp/MEZJ2xssRSTC1ahR
   Q==;
X-CSE-ConnectionGUID: ggY3tacDRC2Qc7cSAljqLg==
X-CSE-MsgGUID: XEhya9MTRriKe0Myj6kfXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994313"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994313"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:33 -0700
X-CSE-ConnectionGUID: 8wSd623JQ666cfEYeBp8RQ==
X-CSE-MsgGUID: TfRPOLNpQ/WD9k/NsHM8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359325"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:31 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] iommu/vt-d: Cleanup si_domain
Date: Mon,  2 Sep 2024 10:27:17 +0800
Message-Id: <20240902022724.67059-8-baolu.lu@linux.intel.com>
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

The static identity domain has been introduced, rendering the si_domain
obsolete. Remove si_domain and cleanup the code accordingly.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240809055431.36513-8-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 91 ++++++++-----------------------------
 1 file changed, 19 insertions(+), 72 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df34416ba7bf..34006b6e89eb 100644
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
@@ -1979,23 +1959,6 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
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
@@ -2018,8 +1981,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 
 	if (!sm_supported(iommu))
 		ret = domain_context_mapping(domain, dev);
-	else if (domain_type_is_si(domain))
-		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
 	else if (domain->use_first_level)
 		ret = domain_setup_first_level(iommu, domain, dev, IOMMU_NO_PASID);
 	else
@@ -2028,8 +1989,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
-	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
-		iommu_enable_pci_caps(info);
+	iommu_enable_pci_caps(info);
 
 	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 	if (ret)
@@ -2388,10 +2348,6 @@ static int __init init_dmars(void)
 
 	check_tylersburg_isoch();
 
-	ret = si_domain_init();
-	if (ret)
-		goto free_iommu;
-
 	/*
 	 * for each drhd
 	 *   enable fault log
@@ -2437,10 +2393,6 @@ static int __init init_dmars(void)
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
-	if (si_domain) {
-		domain_exit(si_domain);
-		si_domain = NULL;
-	}
 
 	return ret;
 }
@@ -3574,8 +3526,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		domain->geometry.force_aperture = true;
 
 		return domain;
-	case IOMMU_DOMAIN_IDENTITY:
-		return &si_domain->domain;
 	default:
 		return NULL;
 	}
@@ -3642,8 +3592,7 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 
 	WARN_ON(dmar_domain->nested_parent &&
 		!list_empty(&dmar_domain->s1_domains));
-	if (domain != &si_domain->domain)
-		domain_exit(dmar_domain);
+	domain_exit(dmar_domain);
 }
 
 int prepare_domain_attach_device(struct iommu_domain *domain,
@@ -4368,9 +4317,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
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

