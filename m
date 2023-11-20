Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714D14F8A
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyOsthyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700480061; x=1732016061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ALg7aRm8HDUzcoLeQTe5aQTvAuPKnbdlNSYa+yIhmEU=;
  b=IyOsthywRCbury8GNGOmgEGYU76UPRT+Jdahq5lqKSlMNY4j7Ipcn7Xc
   UgjEdresrYR0w6BJKislp07er6PB7bIjM1XZ5g0Tjvark/eqDL7iX4ZT5
   grWVOToc3imePcO3VPqxUU9eZI4rN2isNI3/UvByAN7S+QJYbeAgtA/iP
   81F0+Lx6ThLKgP+jxcraMWBslzP0jgbdbrNKg+NzSaci6VT8UehD1vaUl
   rUNg9jMNE21JECHsW0fkf/+q8CXdMY1gwKH4E2mJaDij5/pUGqC6v4lUG
   QItCdKhr8jkvPFe/UZ2Z26P7w8xgNmntAodD87JFNVqBUIeYTbR/16o4d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="376635034"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="376635034"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856963657"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="856963657"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2023 03:34:17 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/5] iommu/vt-d: Remove si_domain
Date: Mon, 20 Nov 2023 19:29:44 +0800
Message-Id: <20231120112944.142741-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120112944.142741-1-baolu.lu@linux.intel.com>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 226 ++++--------------------------------
 1 file changed, 23 insertions(+), 203 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ad2e53821a05..90dd7f24beda 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -97,15 +97,6 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
 	return re->hi & VTD_PAGE_MASK;
 }
 
-/*
- * This domain is a statically identity mapping domain.
- *	1. This domain creats a static 1:1 mapping to all usable memory.
- * 	2. It maps to each iommu if successful.
- *	3. Each iommu mapps to this domain if successful.
- */
-static struct dmar_domain *si_domain;
-static int hw_pass_through = 1;
-
 struct dmar_rmrr_unit {
 	struct list_head list;		/* list of rmrr units	*/
 	struct acpi_dmar_header *hdr;	/* ACPI header		*/
@@ -240,11 +231,6 @@ void free_pgtable_page(void *vaddr)
 	free_page((unsigned long)vaddr);
 }
 
-static int domain_type_is_si(struct dmar_domain *domain)
-{
-	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
-}
-
 static int domain_pfn_supported(struct dmar_domain *domain, unsigned long pfn)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
@@ -1796,9 +1782,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	int agaw, ret;
 
-	if (hw_pass_through && domain_type_is_si(domain))
-		translation = CONTEXT_TT_PASS_THROUGH;
-
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
@@ -1817,34 +1800,24 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
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
@@ -2078,14 +2051,10 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 		return;
 	}
 
-	if (sm_supported(iommu)) {
-		if (hw_pass_through && domain_type_is_si(info->domain))
-			did_old = FLPT_DEFAULT_DID;
-		else
-			did_old = domain_id_iommu(info->domain, iommu);
-	} else {
-		did_old = context_domain_id(context);
-	}
+	if (info->domain)
+		did_old = domain_id_iommu(info->domain, iommu);
+	else
+		did_old = FLPT_DEFAULT_DID;
 
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
@@ -2148,80 +2117,6 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
-static int iommu_domain_identity_map(struct dmar_domain *domain,
-				     unsigned long first_vpfn,
-				     unsigned long last_vpfn)
-{
-	/*
-	 * RMRR range might have overlap with physical memory range,
-	 * clear it first
-	 */
-	dma_pte_clear_range(domain, first_vpfn, last_vpfn);
-
-	return __domain_mapping(domain, first_vpfn,
-				first_vpfn, last_vpfn - first_vpfn + 1,
-				DMA_PTE_READ|DMA_PTE_WRITE, GFP_KERNEL);
-}
-
-static int md_domain_init(struct dmar_domain *domain, int guest_width);
-
-static int __init si_domain_init(int hw)
-{
-	struct dmar_rmrr_unit *rmrr;
-	struct device *dev;
-	int i, nid, ret;
-
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
-	if (hw)
-		return 0;
-
-	for_each_online_node(nid) {
-		unsigned long start_pfn, end_pfn;
-		int i;
-
-		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn_start(start_pfn),
-					mm_to_dma_pfn_end(end_pfn));
-			if (ret)
-				return ret;
-		}
-	}
-
-	/*
-	 * Identity map the RMRRs so that devices with RMRRs could also use
-	 * the si_domain.
-	 */
-	for_each_rmrr_units(rmrr) {
-		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
-					  i, dev) {
-			unsigned long long start = rmrr->base_address;
-			unsigned long long end = rmrr->end_address;
-
-			if (WARN_ON(end < start ||
-				    end >> agaw_to_width(si_domain->agaw)))
-				continue;
-
-			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn_start(start >> PAGE_SHIFT),
-					mm_to_dma_pfn_end(end >> PAGE_SHIFT));
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
@@ -2243,8 +2138,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 
 	if (!sm_supported(iommu))
 		ret = domain_context_mapping(domain, dev);
-	else if (hw_pass_through && domain_type_is_si(domain))
-		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
 	else if (domain->use_first_level)
 		ret = domain_setup_first_level(iommu, domain, dev, IOMMU_NO_PASID);
 	else
@@ -2255,8 +2148,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return ret;
 	}
 
-	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
-		iommu_enable_pci_caps(info);
+	iommu_enable_pci_caps(info);
 
 	return 0;
 }
@@ -2606,8 +2498,6 @@ static int __init init_dmars(void)
 			}
 		}
 
-		if (!ecap_pass_through(iommu->ecap))
-			hw_pass_through = 0;
 		intel_svm_check(iommu);
 	}
 
@@ -2630,10 +2520,6 @@ static int __init init_dmars(void)
 
 	check_tylersburg_isoch();
 
-	ret = si_domain_init(hw_pass_through);
-	if (ret)
-		goto free_iommu;
-
 	/*
 	 * for each drhd
 	 *   enable fault log
@@ -2679,10 +2565,6 @@ static int __init init_dmars(void)
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
-	if (si_domain) {
-		domain_exit(si_domain);
-		si_domain = NULL;
-	}
 
 	return ret;
 }
@@ -3057,12 +2939,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ret)
 		goto out;
 
-	if (hw_pass_through && !ecap_pass_through(iommu->ecap)) {
-		pr_warn("%s: Doesn't support hardware pass through.\n",
-			iommu->name);
-		return -ENXIO;
-	}
-
 	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
 	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
 		pr_warn("%s: Doesn't support large page.\n",
@@ -3313,52 +3189,6 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 	return 0;
 }
 
-static int intel_iommu_memory_notifier(struct notifier_block *nb,
-				       unsigned long val, void *v)
-{
-	struct memory_notify *mhp = v;
-	unsigned long start_vpfn = mm_to_dma_pfn_start(mhp->start_pfn);
-	unsigned long last_vpfn = mm_to_dma_pfn_end(mhp->start_pfn +
-			mhp->nr_pages - 1);
-
-	switch (val) {
-	case MEM_GOING_ONLINE:
-		if (iommu_domain_identity_map(si_domain,
-					      start_vpfn, last_vpfn)) {
-			pr_warn("Failed to build identity map for [%lx-%lx]\n",
-				start_vpfn, last_vpfn);
-			return NOTIFY_BAD;
-		}
-		break;
-
-	case MEM_OFFLINE:
-	case MEM_CANCEL_ONLINE:
-		{
-			struct dmar_drhd_unit *drhd;
-			struct intel_iommu *iommu;
-			LIST_HEAD(freelist);
-
-			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
-
-			rcu_read_lock();
-			for_each_active_iommu(iommu, drhd)
-				iommu_flush_iotlb_psi(iommu, si_domain,
-					start_vpfn, mhp->nr_pages,
-					list_empty(&freelist), 0);
-			rcu_read_unlock();
-			put_pages_list(&freelist);
-		}
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block intel_iommu_memory_nb = {
-	.notifier_call = intel_iommu_memory_notifier,
-	.priority = 0
-};
-
 static void intel_disable_iommus(void)
 {
 	struct intel_iommu *iommu = NULL;
@@ -3655,12 +3485,7 @@ int __init intel_iommu_init(void)
 
 		iommu_pmu_register(iommu);
 	}
-	up_read(&dmar_global_lock);
 
-	if (si_domain && !hw_pass_through)
-		register_memory_notifier(&intel_iommu_memory_nb);
-
-	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
 
@@ -3827,8 +3652,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		domain->geometry.force_aperture = true;
 
 		return domain;
-	case IOMMU_DOMAIN_IDENTITY:
-		return &si_domain->domain;
 	case IOMMU_DOMAIN_SVA:
 		return intel_svm_domain_alloc();
 	default:
@@ -3888,8 +3711,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
-	if (domain != &si_domain->domain)
-		domain_exit(to_dmar_domain(domain));
+	domain_exit(to_dmar_domain(domain));
 }
 
 int prepare_domain_attach_device(struct iommu_domain *domain,
@@ -4596,9 +4418,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_free;
 
-	if (domain_type_is_si(dmar_domain))
-		ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
-	else if (dmar_domain->use_first_level)
+	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
 	else
-- 
2.34.1

