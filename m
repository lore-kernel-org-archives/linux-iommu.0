Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DD1DB34E
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374195; cv=none; b=E+Efg/Pcd6e0GsrXtcvma0E0a0f0a1GdcSh/j9lw68ItgHVFSVyb+JLePmY7Uj4BvvLoXzNeZXuaQlt1hCctuSutNuLT/xyYhmOW6dc4NFEGBzFdeXq0csCsSu5Dg95n5iL0TQBd1FRppRff70SoJD1FlPLtUN4quBPh6KLrB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374195; c=relaxed/simple;
	bh=+tLnVPAC1yQLSjyQ6Ddtkoj6n74XKHutEDN5LFTmZpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rS/yVRk7oetA/a20qvLKJauE3x6XxpLv+pwCkj+u9RtV5gYtT4+aOQPGQ9XBrIzW54OlWICul9qQUTuB+vVbgBkKAeitxYMlIUGXsekRhoMmLe62AJ0n5xN2uOeOmxqCYLmo8ZkkzzF3Um074xWGmT1jzAM9+CvSOvyO19v8gt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TD0t+PGf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TD0t+PGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740374194; x=1771910194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tLnVPAC1yQLSjyQ6Ddtkoj6n74XKHutEDN5LFTmZpc=;
  b=TD0t+PGfPlGipu9Q7QiefexK9QiwvgKXz+u6OG5wbUQeeeBds4u7ziMO
   zPEeXh30Uz5qZs13WRl7h4c2UVGVE6m9c7w2UHabQMds2WMPLSr2DyS0b
   5n4xVz/N7kOsfGoUI9JeDCLfDjbB9Yi1/XtnlgaHvX9W2tlqDRXba5p18
   YYYKNeTHkxgMeCP+rzjSAmiq3aXRh19hSvUTjseGgvFc8QRznJCOW5VRO
   ZtQb/2kvu4j7JN8Eo91dcUNY13JfIx9PzdiHCpLvAw9EM+cuYl77bWZ+a
   w15zvELfsAmPHVQldM34IA2zF05GDoqFV+R3Vx0gnRXQIchvOqGUQytkr
   w==;
X-CSE-ConnectionGUID: ZYuKLuLgRcyeMSjRz/ggLQ==
X-CSE-MsgGUID: GdvaCwD0TY2cHgXRSWJq0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="45024216"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45024216"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:16:33 -0800
X-CSE-ConnectionGUID: uMAkBR1HTkqjUgaL134Dxw==
X-CSE-MsgGUID: hWm2vuvcR+KLBM+/N4ziWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116143401"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 23 Feb 2025 21:16:30 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 04/12] iommu/vt-d: Move scalable mode ATS enablement to probe path
Date: Mon, 24 Feb 2025 13:16:18 +0800
Message-ID: <20250224051627.2956304-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
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

