Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4441C92
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244288; cv=none; b=tvkV4CCDBLVmjmD8dMasJScpdmpoWIYTCDnMBfUQ4TLnARD+4K4EK7q2xTmB1u9MNC8RaH6y+HrNFnpGuqF0JNe0m1IE+/lWfbsZuTT2onlgZJzyRBZ00ATVHphjURJkNo4m62eZPqI36GVzF29Zko1bBpt7FH8u9ocPxKZutlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244288; c=relaxed/simple;
	bh=s0E6ICdgpmiD25EF4GAVXtGxvzQCqhxtQQwT91zUvSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=me0FKL7BnZXm6w+nOOM4jMIYZBYzACeNTKQVAop25QfqK6gCllINcSMg1Mh63EpnZVCU1rL5Lt8k9JZOijJL8A5+n24PraqebUp7E81AR5EhfAHGrwwZKzF79bPhNeOmh+J9pfq/WJXQiIRTM+2SoIdN3lHDKdxA8ml9NZPaqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFHRasqq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFHRasqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244287; x=1756780287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s0E6ICdgpmiD25EF4GAVXtGxvzQCqhxtQQwT91zUvSA=;
  b=HFHRasqqnP1Dm91gfXrYQM6XCnjvdrtdXOay8C55jrirH0NROrAg4omn
   irBAtKHyHVowBxnwtb7nmAkn+S2Zk5KTWSzu4CLhxXxIbngkOZWjLM5Sy
   BkVlEy+w6y0f7HEdFC1ZY5DlFFBpWI7vCJzJBIrbNRIV4i0N8RhNsynKv
   KgpEsAekGAcUxQoRbJELJjE6Bag+QWrQMyJ0eKVbx/vbJrGchLtYmUIe2
   NDG82fZdwiyLY9SWRvPDIUvi0hyYuO4NNvohcUDG9fmRAShaR36JkmW75
   3COA17Q8zd6u8gnSHrgvfyRoi14PR4ISeeC8nKNJzAxYlJQdzgPMMnreB
   g==;
X-CSE-ConnectionGUID: PdYcg+K0Sp6oKFTLm8y8jg==
X-CSE-MsgGUID: G4cpJD9KRTaQoNEQWWzkjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994289"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994289"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:27 -0700
X-CSE-ConnectionGUID: YIDfa1x5TEuVlJrU8gvHNQ==
X-CSE-MsgGUID: H45BLma4QHe0ZRF5+wsVxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359287"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] iommu/vt-d: Remove has_iotlb_device flag
Date: Mon,  2 Sep 2024 10:27:14 +0800
Message-Id: <20240902022724.67059-5-baolu.lu@linux.intel.com>
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

The has_iotlb_device flag was used to indicate if a domain had attached
devices with ATS enabled. Domains without this flag didn't require device
TLB invalidation during unmap operations, optimizing performance by
avoiding unnecessary device iteration.

With the introduction of cache tags, this flag is no longer needed. The
code to iterate over attached devices was removed by commit 06792d067989
("iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()").

Remove has_iotlb_device to avoid unnecessary code.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240809055431.36513-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h  |  2 --
 drivers/iommu/intel/iommu.c  | 34 +---------------------------------
 drivers/iommu/intel/nested.c |  2 --
 3 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a969be2258b1..b3b295e60626 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -588,7 +588,6 @@ struct dmar_domain {
 	int	nid;			/* node id */
 	struct xarray iommu_array;	/* Attached IOMMU array */
 
-	u8 has_iotlb_device: 1;
 	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
 	u8 set_pte_snp:1;
@@ -1104,7 +1103,6 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
-void domain_update_iotlb(struct dmar_domain *domain);
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index baf79c6a5a84..b58137ecaf87 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -485,7 +485,6 @@ void domain_update_iommu_cap(struct dmar_domain *domain)
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
 
 	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
-	domain_update_iotlb(domain);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -1263,32 +1262,6 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 	return NULL;
 }
 
-void domain_update_iotlb(struct dmar_domain *domain)
-{
-	struct dev_pasid_info *dev_pasid;
-	struct device_domain_info *info;
-	bool has_iotlb_device = false;
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (info->ats_enabled) {
-			has_iotlb_device = true;
-			break;
-		}
-	}
-
-	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
-		info = dev_iommu_priv_get(dev_pasid->dev);
-		if (info->ats_enabled) {
-			has_iotlb_device = true;
-			break;
-		}
-	}
-	domain->has_iotlb_device = has_iotlb_device;
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
 /*
  * The extra devTLB flush quirk impacts those QAT devices with PCI device
  * IDs ranging from 0x4940 to 0x4943. It is exempted from risky_device()
@@ -1325,10 +1298,8 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 		info->pasid_enabled = 1;
 
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
+	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
 		info->ats_enabled = 1;
-		domain_update_iotlb(info->domain);
-	}
 }
 
 static void iommu_disable_pci_caps(struct device_domain_info *info)
@@ -1343,7 +1314,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 	if (info->ats_enabled) {
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
-		domain_update_iotlb(info->domain);
 	}
 
 	if (info->pasid_enabled) {
@@ -1517,7 +1487,6 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	domain->nid = NUMA_NO_NODE;
 	if (first_level_by_default(type))
 		domain->use_first_level = true;
-	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
 	INIT_LIST_HEAD(&domain->cache_tags);
@@ -3520,7 +3489,6 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	xa_init(&domain->iommu_array);
 
 	domain->nid = dev_to_node(dev);
-	domain->has_iotlb_device = info->ats_enabled;
 	domain->use_first_level = first_stage;
 
 	/* calculate the address width */
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 16a2bcf5cfeb..36a91b1b52be 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -66,8 +66,6 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	list_add(&info->link, &dmar_domain->devices);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
-	domain_update_iotlb(dmar_domain);
-
 	return 0;
 unassign_tag:
 	cache_tag_unassign_domain(dmar_domain, dev, IOMMU_NO_PASID);
-- 
2.34.1

