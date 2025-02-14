Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28C1FBEB4
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513473; cv=none; b=p0Cy35rfCEGza4dfk/HQCCc0J9tETi7ajySvG2S+xdZ+hSH0Y8CmT0acxLGNDfM+9qn5elp2YtrJRfmSTokFnpq5woe/j4H5/DYxJ+AHpuIZetIxf8wt8XAOMn3QWKdbfKN3gKMnwPtrWalNnUauAjVrD3tE9RymHcew2U7wUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513473; c=relaxed/simple;
	bh=Ae7CCwklY2u5LEf02DzBnSRtB2PBYlj9DOJ8QQ3Rb2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGt2at5urZOsMNBLVVACFba3u8lzzIet0IxsbgOT8IuKTGllJXxC2N1Ot2uUis5R02NdvGqtgUBvT8spAbplUww9HyB8ObBohxlBx7y02Wx547xoTN+YSRHdD/XuHDSbjaN8AkohTgcKw074jgBfXGDlP5+xNrAS5gs8NUZSMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2kNuEqO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2kNuEqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513471; x=1771049471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ae7CCwklY2u5LEf02DzBnSRtB2PBYlj9DOJ8QQ3Rb2A=;
  b=E2kNuEqORzLe/F9IG9wdDyTPaJI0OjklU3s2BlRJFks/7SaWdDs8bwGK
   Lk8Vf1JWZB2Xtkb9U2nZky9gRK6lIFzbg1rYIAYg0gWLUFX0W4bNH4A87
   hXkRBka9nvo986hHDWIouQ8abkVVvuiRp5FuOekAUMqHZUQnq73weAELj
   W0O6E/ifYbKjq1QVoVb3PbByK9/+nFAEFANtQOXXi+cqPiagWX3N8C7Dc
   aOi8uKo7cbGCU9tC66i5IhR6pOJLEXP4MueDHyZW7v9vq0tLxL3wyI+zt
   wFrlgh35cV7z49cGQKiisIyhnIz11Nhj5oRKtMl7U4MhfabGwRo8mCigs
   w==;
X-CSE-ConnectionGUID: qe7StNaLR6GYHvIgmjrRGQ==
X-CSE-MsgGUID: A3H67sowSESkdCxLw4LncQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124492"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124492"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:11 -0800
X-CSE-ConnectionGUID: EKoubrT0R5OJcCKse+6KVA==
X-CSE-MsgGUID: ATOI6KNXSyKTaAUUlsf+6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268092"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:07 -0800
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 03/12] iommu: Remove IOMMU_DEV_FEAT_SVA
Date: Fri, 14 Feb 2025 14:10:55 +0800
Message-ID: <20250214061104.1959525-4-baolu.lu@linux.intel.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

None of the drivers implement anything here anymore, remove the dead code.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
index b946f78f85e1..1e5038cca22c 100644
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
index b48a72bd7b23..e3653bdfcd7d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2990,7 +2990,6 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -3006,7 +3005,6 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 75b2f7c609ca..ee945a9db641 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3627,7 +3627,6 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		return 0;
 	default:
 		return -EINVAL;
@@ -3644,7 +3643,6 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		return 0;
 	default:
 		return -EINVAL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a4048de66378..16dd8f0de76d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3970,9 +3970,6 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	case IOMMU_DEV_FEAT_IOPF:
 		return intel_iommu_enable_iopf(dev);
 
-	case IOMMU_DEV_FEAT_SVA:
-		return 0;
-
 	default:
 		return -ENODEV;
 	}
@@ -3985,9 +3982,6 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 	case IOMMU_DEV_FEAT_IOPF:
 		return intel_iommu_disable_iopf(dev);
 
-	case IOMMU_DEV_FEAT_SVA:
-		return 0;
-
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 503c5d23c1ea..331be2761a75 100644
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
index 38c65e92ecd0..1d0dde49168d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -303,18 +303,11 @@ struct iommu_iort_rmr_data {
 
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

