Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248B26AA89
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963270; cv=none; b=NqPWtDUzB/hnDnOXqt/uxCWpKMUENsgSQ0o5QuBph1ONYBT6UDYO0/G+PhwwrzIzAwBanneFHCJMFc4S3hkpZudLOzBswv9SBrYyC1PyP87TQQQKWXn3FN6Z60rZ3rMzy08sfM3F1AnkkgXsnno9GTTmc3IvUmzCOwR7GlnsOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963270; c=relaxed/simple;
	bh=BOm3DIf88NOf46tYqguBLQX+n5JC5pFLUDkJxKKkypQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvCftL90WMJdeiCxKE9AXjReSvcCIUdmH+N9LfTYgTxo6Zxf6vxPU4ujMW0njdBXiLWN6f1xH2vxS54GhKI+F3HEgmQvzmwgWTf48O2IMMccWYd3pZw6/gIJ18NNOGfBjQDnmyHTBO7Cg7vS9n0jpUPzTru0tPmWTWOfTDLqHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARCRAcGg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARCRAcGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744963269; x=1776499269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOm3DIf88NOf46tYqguBLQX+n5JC5pFLUDkJxKKkypQ=;
  b=ARCRAcGgzbQzIrRqRxKB2HpPVnLElhcYSjUkARoumN0ADyfAJXiCyhIL
   bSdALQGUQnoeaMzoQ7t3hSi2RuorYVpuqJFDwCfUMjnpvPlxiCnUEA/pa
   F0zrnPFIyHXL8wg9DmTU0/dr1e21ApSD2cN2SZKPWFpBsNSwT8swttrBA
   AoDL0ZYa8ETukk/HjrLUCum8RIXQ63EjiGuPqFQuwFNjjvAe5PvN1W4BW
   QPy2nI78OQONdSq1VWD0S5uhs8NXXaSHa4XB/YSVvEflMk+rX3zx4g7pq
   h5/49XF0kupaygycNaPuOynDHDV8VhYFEF0NPJMS/+d1G4T++w1/59Xjp
   g==;
X-CSE-ConnectionGUID: vx/ZyLMESiuWi0r3XTawfA==
X-CSE-MsgGUID: B8T/9nRHTwO6kLTyV1JWfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46708453"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="46708453"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:01:09 -0700
X-CSE-ConnectionGUID: xMDROQwPQMeEK4mWg1r4zQ==
X-CSE-MsgGUID: MJ5YZzceRy+P4a2ih5Nrmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="131358570"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2025 01:01:05 -0700
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 2/8] iommu: Remove IOMMU_DEV_FEAT_SVA
Date: Fri, 18 Apr 2025 16:01:24 +0800
Message-ID: <20250418080130.1844424-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
References: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

None of the drivers implement anything here anymore, remove the dead code.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/accel/amdxdna/aie2_pci.c            | 13 ++-----------
 drivers/dma/idxd/init.c                     |  8 +-------
 drivers/iommu/amd/iommu.c                   |  2 --
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 --
 drivers/iommu/intel/iommu.c                 |  6 ------
 drivers/iommu/iommu-sva.c                   |  3 ---
 drivers/misc/uacce/uacce.c                  |  9 ---------
 include/linux/iommu.h                       |  9 +--------
 8 files changed, 4 insertions(+), 48 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 5a058e565b01..c6cf7068d23c 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -512,12 +512,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
 		goto release_fw;
 	}
 
-	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
-	if (ret) {
-		XDNA_ERR(xdna, "Enable PASID failed, ret %d", ret);
-		goto free_irq;
-	}
-
 	psp_conf.fw_size = fw->size;
 	psp_conf.fw_buf = fw->data;
 	for (i = 0; i < PSP_MAX_REGS; i++)
@@ -526,14 +520,14 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	if (!ndev->psp_hdl) {
 		XDNA_ERR(xdna, "failed to create psp");
 		ret = -ENOMEM;
-		goto disable_sva;
+		goto free_irq;
 	}
 	xdna->dev_handle = ndev;
 
 	ret = aie2_hw_start(xdna);
 	if (ret) {
 		XDNA_ERR(xdna, "start npu failed, ret %d", ret);
-		goto disable_sva;
+		goto free_irq;
 	}
 
 	ret = aie2_mgmt_fw_query(ndev);
@@ -584,8 +578,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	aie2_error_async_events_free(ndev);
 stop_hw:
 	aie2_hw_stop(xdna);
-disable_sva:
-	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 free_irq:
 	pci_free_irq_vectors(pdev);
 release_fw:
@@ -601,7 +593,6 @@ static void aie2_fini(struct amdxdna_dev *xdna)
 
 	aie2_hw_stop(xdna);
 	aie2_error_async_events_free(ndev);
-	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 	pci_free_irq_vectors(pdev);
 }
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index fca1d2924999..2d3d580b9987 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -633,17 +633,11 @@ static int idxd_enable_sva(struct pci_dev *pdev)
 	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
 	if (ret)
 		return ret;
-
-	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
-	if (ret)
-		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
-
-	return ret;
+	return 0;
 }
 
 static void idxd_disable_sva(struct pci_dev *pdev)
 {
-	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dea0fed7abb0..17aab6d04a13 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2991,7 +2991,6 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -3007,7 +3006,6 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6cb875f98905..73f9885d20f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3664,7 +3664,6 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		return 0;
 	default:
 		return -EINVAL;
@@ -3681,7 +3680,6 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		return 0;
 	default:
 		return -EINVAL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 857c431d8ec5..4c3be92804e2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3956,9 +3956,6 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	case IOMMU_DEV_FEAT_IOPF:
 		return intel_iommu_enable_iopf(dev);
 
-	case IOMMU_DEV_FEAT_SVA:
-		return 0;
-
 	default:
 		return -ENODEV;
 	}
@@ -3972,9 +3969,6 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 		intel_iommu_disable_iopf(dev);
 		return 0;
 
-	case IOMMU_DEV_FEAT_SVA:
-		return 0;
-
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index ab18bc494eef..944daa0dabd6 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -63,9 +63,6 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
  * reference is taken. Caller must call iommu_sva_unbind_device()
  * to release each reference.
  *
- * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
- * initialize the required SVA features.
- *
  * On error, returns an ERR_PTR value.
  */
 struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index bdc2e6fda782..2a1db2abeeca 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -479,14 +479,6 @@ static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
 		dev_err(parent, "failed to enable IOPF feature! ret = %pe\n", ERR_PTR(ret));
 		return flags;
 	}
-
-	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
-	if (ret) {
-		dev_err(parent, "failed to enable SVA feature! ret = %pe\n", ERR_PTR(ret));
-		iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
-		return flags;
-	}
-
 	return flags | UACCE_DEV_SVA;
 }
 
@@ -495,7 +487,6 @@ static void uacce_disable_sva(struct uacce_device *uacce)
 	if (!(uacce->flags & UACCE_DEV_SVA))
 		return;
 
-	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
 	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7e8c2af89799..bfdd2e71e124 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -318,18 +318,11 @@ struct iommu_iort_rmr_data {
 
 /**
  * enum iommu_dev_features - Per device IOMMU features
- * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
- * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
- *			 enabling %IOMMU_DEV_FEAT_SVA requires
- *			 %IOMMU_DEV_FEAT_IOPF, but some devices manage I/O Page
- *			 Faults themselves instead of relying on the IOMMU. When
- *			 supported, this feature must be enabled before and
- *			 disabled after %IOMMU_DEV_FEAT_SVA.
+ * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall.
  *
  * Device drivers enable a feature using iommu_dev_enable_feature().
  */
 enum iommu_dev_features {
-	IOMMU_DEV_FEAT_SVA,
 	IOMMU_DEV_FEAT_IOPF,
 };
 
-- 
2.43.0

