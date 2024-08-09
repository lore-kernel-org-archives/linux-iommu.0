Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DF16C87C
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183088; cv=none; b=bsPLGQWpX7sIk/FWzbsr+BeExsjdwBhxc+tHw9Ho4a9Msus29qkBBpuqmxkJpiGdzb/+c/canLrJztjD8QhttexXsiHRHLsOj62J4JA5EDvTlwT4YAWCLiWkk0dvBa0MV7acgFDS1O1nfhU9CzS1h4LDmDy8b7+1JcnRiWYAMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183088; c=relaxed/simple;
	bh=wbU3ZV/NJxEZIOwGOe90pQPqrLese+1fXkQ3W4IMrQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bpfm/FZjnh9Uwi/M34tmBZRb9HnMmROGLHadpdP24jQ4iI/piV4euJ4OUka4j84s7JEwnyfcS0b9jv8ZkRRpgT7cSOEmHdQK6OTi/pxEXGo3ABXW0YDMOx2XcAf6iKCpSmI5YHoHSpqUny30R/jVRaZBtkYEqFYEOX2QZr4GmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lt5RK1r1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lt5RK1r1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723183088; x=1754719088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wbU3ZV/NJxEZIOwGOe90pQPqrLese+1fXkQ3W4IMrQI=;
  b=Lt5RK1r1mgUjDc1GruQC40VeODyZ0mZnf90X+ieUcIlRCxQULqbKWoPw
   COwnemqierzOPY3cFmo9tMJEuqbkiHWbEYz8j/6w7Gh5ihAB5WUQzpiws
   5akcGiIEfmkPeHlw0WYeasAuRYYJPmaLzvU2sDltNpe15u1YNInWyyokm
   NoS6KSPdQ4a5pU7eXXNebOdpYgPnfch3zh1OBB7E+LiFA+e9JUH+JMxV/
   7/GfSlOJZZ4dbrKFFFvPDNI+K6BiJQQdCcKfmKvtg6lZuKwBW5CTAxlSZ
   OsRtusYZ2aHv1EHy899MR+2GTAvCw5thmqmk48SjmYBDCrlpaNqehC0v7
   w==;
X-CSE-ConnectionGUID: gygsfC1DR7O9e4QpY8w+eg==
X-CSE-MsgGUID: +B3zFXKeRc+32gwrx1sT4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21469124"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21469124"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 22:58:07 -0700
X-CSE-ConnectionGUID: 1lkTrB73Qmivd9q1L2AKAg==
X-CSE-MsgGUID: HTnGqAznR16qMLikK7HsNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57540880"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 22:58:05 -0700
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
Subject: [PATCH v4 2/7] iommu/vt-d: Remove identity mappings from si_domain
Date: Fri,  9 Aug 2024 13:54:26 +0800
Message-Id: <20240809055431.36513-3-baolu.lu@linux.intel.com>
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

As the driver has enforced DMA domains for devices managed by an IOMMU
hardware that doesn't support passthrough translation mode, there is no
need for static identity mappings in the si_domain. Remove the identity
mapping code to avoid dead code.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 122 ++----------------------------------
 1 file changed, 4 insertions(+), 118 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 90ad794a1be7..723ea9f3f501 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -167,14 +167,7 @@ static void device_rbtree_remove(struct device_domain_info *info)
 	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
 }
 
-/*
- * This domain is a statically identity mapping domain.
- *	1. This domain creats a static 1:1 mapping to all usable memory.
- * 	2. It maps to each iommu if successful.
- *	3. Each iommu mapps to this domain if successful.
- */
 static struct dmar_domain *si_domain;
-static int hw_pass_through = 1;
 
 struct dmar_rmrr_unit {
 	struct list_head list;		/* list of rmrr units	*/
@@ -1647,7 +1640,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	int agaw, ret;
 
-	if (hw_pass_through && domain_type_is_si(domain))
+	if (domain_type_is_si(domain))
 		translation = CONTEXT_TT_PASS_THROUGH;
 
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
@@ -1998,29 +1991,10 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
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
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
-static int __init si_domain_init(int hw)
+static int __init si_domain_init(void)
 {
-	struct dmar_rmrr_unit *rmrr;
-	struct device *dev;
-	int i, nid, ret;
-
 	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
 	if (!si_domain)
 		return -EFAULT;
@@ -2031,44 +2005,6 @@ static int __init si_domain_init(int hw)
 		return -EFAULT;
 	}
 
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
-					mm_to_dma_pfn_end(end_pfn-1));
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
 	return 0;
 }
 
@@ -2094,7 +2030,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 
 	if (!sm_supported(iommu))
 		ret = domain_context_mapping(domain, dev);
-	else if (hw_pass_through && domain_type_is_si(domain))
+	else if (domain_type_is_si(domain))
 		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
 	else if (domain->use_first_level)
 		ret = domain_setup_first_level(iommu, domain, dev, IOMMU_NO_PASID);
@@ -2449,8 +2385,6 @@ static int __init init_dmars(void)
 			}
 		}
 
-		if (!ecap_pass_through(iommu->ecap))
-			hw_pass_through = 0;
 		intel_svm_check(iommu);
 	}
 
@@ -2466,7 +2400,7 @@ static int __init init_dmars(void)
 
 	check_tylersburg_isoch();
 
-	ret = si_domain_init(hw_pass_through);
+	ret = si_domain_init();
 	if (ret)
 		goto free_iommu;
 
@@ -2893,12 +2827,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
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
@@ -3149,43 +3077,6 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
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
-			LIST_HEAD(freelist);
-
-			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
-			iommu_put_pages_list(&freelist);
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
@@ -3482,12 +3373,7 @@ int __init intel_iommu_init(void)
 
 		iommu_pmu_register(iommu);
 	}
-	up_read(&dmar_global_lock);
 
-	if (si_domain && !hw_pass_through)
-		register_memory_notifier(&intel_iommu_memory_nb);
-
-	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
 
-- 
2.34.1

