Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42D25C712
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734813; cv=none; b=hsCHUKCRkCZnnK4WmQjg1T5CRhn7IELVEH87xA3Q9TnP9tyh/Hux4ejSlWtPxH4xgW+0KbNDombPbMYZxZX/OnV/G4EITVYH14+nPO+nC922gWwwXSdb9+mE4nI0iOTaFljoiWMLambQvvmDapgyfnRU6sIOdG1L9EqRB4UsYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734813; c=relaxed/simple;
	bh=LalUdJVj91uyCo7aoTOFqO1HMi4LdrZjiQ2EMwM8TAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+nEmhJoRvH/xCsU+CMEy04BjPLpFSMVTRZH4VLspWtmo0TmRu/FYYxzRlHWJwW2xPFvZh+oyB4Owp6OgOMoW6egb8dPTiLjf/PYvgnQRr3l13N9Y/soiWk0GsBaV6Chw5XfrOL+39SSskUKq4fMHWV6rfqghz+1V+g0HeY4kTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7Rqr7Zb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7Rqr7Zb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740734811; x=1772270811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LalUdJVj91uyCo7aoTOFqO1HMi4LdrZjiQ2EMwM8TAI=;
  b=S7Rqr7ZbGDMX3vul18vVaFivawtpU63GdPQWadXRYE0DBe9XoqEQMPLN
   2cHGyx5nlk9ORNW0Isjwy85E5IunBqhg8Gvj6ClRaq1U1I1qj6WhLDGlM
   aU7gOnillcH6SWFRGfMNk/+ilS+K3CAEtmerIP4IDIAAL1TW9X9ZogOVO
   Tmzi0diYPG1a++uRK6s3Y/vieyASdHWOKYxvJkDs+O8CFOqXg9ctQUSa3
   HEnjfbZZiv7Gek5NwvtQQjRmlKByGk+HZmITq+4G1d3af9vmHJupNX+f2
   JNwW4zoAhI1I2pKRy1+aZeKtFyYjqIVAJHkFsgmRiD3H9aDvjyxD6n9G+
   Q==;
X-CSE-ConnectionGUID: DUvxqJBcQZKpSRgOmeJ/mA==
X-CSE-MsgGUID: kTcoqf1rQriPvC0dwMC/5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45438388"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45438388"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:26:51 -0800
X-CSE-ConnectionGUID: rIN3CM7pREaYG0jjKCaufQ==
X-CSE-MsgGUID: kXPuFILMQm+V+D/OlpANQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148213026"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 01:26:47 -0800
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
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 09/12] dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Fri, 28 Feb 2025 17:26:28 +0800
Message-ID: <20250228092631.3425464-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a no-op.
It will also be removed from the iommu driver in the subsequent patch.
Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/dma/idxd/init.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 1e5038cca22c..d44944195807 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -626,21 +626,6 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
 	idxd->pasid = IOMMU_PASID_INVALID;
 }
 
-static int idxd_enable_sva(struct pci_dev *pdev)
-{
-	int ret;
-
-	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
-	if (ret)
-		return ret;
-	return 0;
-}
-
-static void idxd_disable_sva(struct pci_dev *pdev)
-{
-	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
-}
-
 static int idxd_probe(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
@@ -655,17 +640,13 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
-		if (idxd_enable_sva(pdev)) {
-			dev_warn(dev, "Unable to turn on user SVA feature.\n");
-		} else {
-			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
+		set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
 
-			rc = idxd_enable_system_pasid(idxd);
-			if (rc)
-				dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
-			else
-				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
-		}
+		rc = idxd_enable_system_pasid(idxd);
+		if (rc)
+			dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
+		else
+			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 	} else if (!sva) {
 		dev_warn(dev, "User forced SVA off via module param.\n");
 	}
@@ -703,8 +684,6 @@ static int idxd_probe(struct idxd_device *idxd)
  err:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	if (device_user_pasid_enabled(idxd))
-		idxd_disable_sva(pdev);
 	return rc;
 }
 
@@ -715,8 +694,6 @@ static void idxd_cleanup(struct idxd_device *idxd)
 	idxd_cleanup_internals(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	if (device_user_pasid_enabled(idxd))
-		idxd_disable_sva(idxd->pdev);
 }
 
 /*
@@ -1248,8 +1225,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	free_irq(irq_entry->vector, irq_entry);
 	pci_free_irq_vectors(pdev);
 	pci_iounmap(pdev, idxd->reg_base);
-	if (device_user_pasid_enabled(idxd))
-		idxd_disable_sva(pdev);
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
-- 
2.43.0

