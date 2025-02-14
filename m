Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573A1FC7C4
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513475; cv=none; b=ZhmmovzsqQ687SyPYt9/r5/VI7VZ0bYtq91Xa78evA6X6edmyz8Z6dejhlyeRydWUOlBS3XsLggV5KbdwqQvqAOEsplaMvam0DcGhAQVQeZ0qsS5m/iT6wHTCrT5i2dSpf89gNkP8igPqZngcC5YbHs1dYY0fIL7bUx2uVu8Ubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513475; c=relaxed/simple;
	bh=+tLnVPAC1yQLSjyQ6Ddtkoj6n74XKHutEDN5LFTmZpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iutc1wnMh4D54kST+N5SVhVIJw1aFx/W3biGF3N2Np9T+ifxCg7KWbLc0jXeWZUiXxIIZxCK6tdlHAEF9qAhDjGvrczP39JQ6iEzmgV7uOWs5IIDl2/iM93Ejv2Ok8PkvjnIoeKeRw3LAc75gtFlRu19cHTnnRVCe6DHRb6K9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwqrVgIG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwqrVgIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513474; x=1771049474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tLnVPAC1yQLSjyQ6Ddtkoj6n74XKHutEDN5LFTmZpc=;
  b=cwqrVgIGXrkHT0kTLgWh+boOl4MJipXY+ef1Jl4LwZsGDpTBwxfmICIF
   OTvCahCUg8zS7uCChT0ILVP/ZwYIJRa7ztXJdm3ohFZEHoT1glz+PXSJ0
   WclK+ekDag5BFe3gfc9YcGCComWnmAvy/Xg+petgvuBeKwqxJQHxtvFQg
   xiGKU7RLQq7tcSKR0MiWWEiFOo/tGJ/tpByvCBDb0bDRT8Sf6c0jnoX8J
   ToNYG0D9kKIyIZQ3QHZOITw5nAvaEo8S6q3J/IZ6a6iyl+hUamt01jdLf
   D7Y40nIUZ4pfjhCEY4FqyVLD3RXs6xGQfFL3b217zFIsQ63pvou+WpnqP
   w==;
X-CSE-ConnectionGUID: 8AnUZIglTKiYZ5VPqy+bwg==
X-CSE-MsgGUID: 3SQIdWcyQ6W7PaEowy7MMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124502"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124502"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:14 -0800
X-CSE-ConnectionGUID: vKsfK4teSHK2nqsV3KpT1g==
X-CSE-MsgGUID: tj9/Y4ZdSa+0alSzzxWEXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268103"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:11 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 04/12] iommu/vt-d: Move scalable mode ATS enablement to probe path
Date: Fri, 14 Feb 2025 14:10:56 +0800
Message-ID: <20250214061104.1959525-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device ATS is currently enabled when a domain is attached to the device
and disabled when the domain is detached. This creates a limitation:
when the IOMMU is operating in scalable mode and IOPF is enabled, the
device's domain cannot be changed.

Remove this limitation by moving ATS enablement to the device probe path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 78 ++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 16dd8f0de76d..f52602bde742 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1172,34 +1172,6 @@ static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 	return true;
 }
 
-static void iommu_enable_pci_caps(struct device_domain_info *info)
-{
-	struct pci_dev *pdev;
-
-	if (!dev_is_pci(info->dev))
-		return;
-
-	pdev = to_pci_dev(info->dev);
-	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
-		info->ats_enabled = 1;
-}
-
-static void iommu_disable_pci_caps(struct device_domain_info *info)
-{
-	struct pci_dev *pdev;
-
-	if (!dev_is_pci(info->dev))
-		return;
-
-	pdev = to_pci_dev(info->dev);
-
-	if (info->ats_enabled) {
-		pci_disable_ats(pdev);
-		info->ats_enabled = 0;
-	}
-}
-
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	cache_tag_flush_all(to_dmar_domain(domain));
@@ -1556,12 +1528,22 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	u8 bus = info->bus, devfn = info->devfn;
+	struct pci_dev *pdev;
+	int ret;
 
 	if (!dev_is_pci(dev))
 		return domain_context_mapping_one(domain, iommu, bus, devfn);
 
-	return pci_for_each_dma_alias(to_pci_dev(dev),
-				      domain_context_mapping_cb, domain);
+	pdev = to_pci_dev(dev);
+	ret = pci_for_each_dma_alias(pdev, domain_context_mapping_cb, domain);
+	if (ret)
+		return ret;
+
+	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
+	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
+		info->ats_enabled = 1;
+
+	return 0;
 }
 
 /* Return largest possible superpage level for a given mapping */
@@ -1843,8 +1825,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
-	iommu_enable_pci_caps(info);
-
 	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 	if (ret)
 		goto out_block_translation;
@@ -3191,13 +3171,20 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  */
 static void domain_context_clear(struct device_domain_info *info)
 {
+	struct pci_dev *pdev;
+
 	if (!dev_is_pci(info->dev)) {
 		domain_context_clear_one(info, info->bus, info->devfn);
 		return;
 	}
 
-	pci_for_each_dma_alias(to_pci_dev(info->dev),
-			       &domain_context_clear_one_cb, info);
+	pdev = to_pci_dev(info->dev);
+	pci_for_each_dma_alias(pdev, &domain_context_clear_one_cb, info);
+
+	if (info->ats_enabled) {
+		pci_disable_ats(pdev);
+		info->ats_enabled = 0;
+	}
 }
 
 /*
@@ -3214,7 +3201,6 @@ void device_block_translation(struct device *dev)
 	if (info->domain)
 		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 
-	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
@@ -3749,6 +3735,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
+	if (sm_supported(iommu)) {
+		if (info->ats_supported && pci_ats_page_aligned(pdev)) {
+			ret = pci_enable_ats(pdev, VTD_PAGE_SHIFT);
+			if (ret)
+				pci_info(pdev, "Failed to enable ATS on device\n");
+			else
+				info->ats_enabled = 1;
+		}
+	}
+
 	return &iommu->iommu;
 free_table:
 	intel_pasid_free_table(dev);
@@ -3765,6 +3761,11 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	if (info->ats_enabled) {
+		pci_disable_ats(to_pci_dev(dev));
+		info->ats_enabled = 0;
+	}
+
 	if (info->pasid_enabled) {
 		pci_disable_pasid(to_pci_dev(dev));
 		info->pasid_enabled = 0;
@@ -4365,13 +4366,10 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 	if (dev_is_real_dma_subdevice(dev))
 		return 0;
 
-	if (sm_supported(iommu)) {
+	if (sm_supported(iommu))
 		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
-		if (!ret)
-			iommu_enable_pci_caps(info);
-	} else {
+	else
 		ret = device_setup_pass_through(dev);
-	}
 
 	return ret;
 }
-- 
2.43.0

