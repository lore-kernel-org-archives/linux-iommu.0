Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5B1FA26C
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843188; cv=none; b=YDe0kqNyG22QUxMcVGYMhu4rjihPBJN5fuLJRwtnxK8TLNB2dsbWFhzBc3//2FOlHBqVvqzsT8SXHe0rzTlfST3btAkbr4mW/lJJjprBzbtg9YReHddJPB1NCTaqTpeRs2+bHvM6zq/X1hBXMROrS9Ct56x0hNpSgoiIXc0AqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843188; c=relaxed/simple;
	bh=5WpIAtvUZEudfnZ7/xlT7gQO4ZGNWmu92yCMmWN4QdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lero2060+D9NyRMV9RAlteM15FnBMqDjYA01G41xuhtjBPNEFrg1yvC+uIWyQdZnlnTyyVIdGnb79a1q1fuYNVFGGTBbOsa9j+UaqkwwK12PHgCi3QQ6GQ4gU4asmFEWff5pxMMtMdrU1hw0VqaM+7hIX/EIKLhfTjXBAHwNdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzBqorjK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzBqorjK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741843187; x=1773379187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5WpIAtvUZEudfnZ7/xlT7gQO4ZGNWmu92yCMmWN4QdA=;
  b=SzBqorjKCoxj/X67TteyV7qvnBUsVERS0P/FxwQ0K7APUnrYqgyXJiuq
   lnikdu9wbKp0oUkXJixe7ZGGGbJ+LlUdVbLpJs58Lydod7ltGcOSVoypZ
   ePxC5H+VygY85LMaW8MnvE79FrCFmLBQIWsBsR0IbaS04IH6zyYr1xFZe
   v1Nl5mpNdyfTkCGtTB3XfEAN1mMkyLCRs6gzuWdkhbthXhG4w0UBjmm5F
   j/isGE9Ww+Drkef3aVxkAp0lgZ9jXtlmKLI8k+Q+wCVlpFyAqy/U5p0qj
   f27BYILJ1bj6ZN/sebq08Q5DONYk1Kip3C6my2ZkwAMcC9q6drmE36Gx7
   A==;
X-CSE-ConnectionGUID: fkGm/0IzRIiPKtprqv2Lbg==
X-CSE-MsgGUID: xTFsqjcIQ1+CQIQrz7krjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54323659"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="54323659"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 22:19:47 -0700
X-CSE-ConnectionGUID: ZxGle/DsQQmjLJjHp/c8Kg==
X-CSE-MsgGUID: BwUdKLrWTEG5kkWF69v+Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151807056"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 22:19:43 -0700
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
Subject: [PATCH v4 2/8] iommu: Remove IOMMU_DEV_FEAT_SVA
Date: Thu, 13 Mar 2025 13:19:47 +0800
Message-ID: <20250313051953.4064532-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
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
index 6e4fd6351646..25449a564804 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2987,7 +2987,6 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -3003,7 +3002,6 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a8b1b8b17992..60c8f1fa5bf0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3630,7 +3630,6 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		return 0;
 	default:
 		return -EINVAL;
@@ -3647,7 +3646,6 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-	case IOMMU_DEV_FEAT_SVA:
 		return 0;
 	default:
 		return -EINVAL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 85aa66ef4d61..8d557d04a273 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3945,9 +3945,6 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	case IOMMU_DEV_FEAT_IOPF:
 		return intel_iommu_enable_iopf(dev);
 
-	case IOMMU_DEV_FEAT_SVA:
-		return 0;
-
 	default:
 		return -ENODEV;
 	}
@@ -3961,9 +3958,6 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 		intel_iommu_disable_iopf(dev);
 		return 0;
 
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
index cf8c16ba04a0..1308c8f85591 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -323,18 +323,11 @@ struct iommu_iort_rmr_data {
 
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

