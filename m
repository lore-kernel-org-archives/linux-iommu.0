Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503E1D8DE0
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374192; cv=none; b=maCIQpBFxp0l7M0ZwSFy+0ToUjJeM3aYVGR0SzqkvV9t8CKsfWUHgNUwlpcifPrTWIv4wyNVDNFRQ2YHR9J4rQhu4BN8eqWGQt75zkgRWAoFWhti+p+hBPpE415QkmsNiA1TWIk72doH8Fs6OPyvWo5QojDe6L8m75oZPDHiOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374192; c=relaxed/simple;
	bh=B5Wnjavs3tz+SGvDL7JCaEEWvolmhuwfTsKr0yPk+Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2i9pDnr7TMr7p+IBq0zNhv4xJiaILPl5CJq/88Mqynr4a5AB4hRpUvDl/I+LuSmdz/ZirSPN/zktf+7cLx3P5ThCPTiuBKoOrMt9/aV6jDATwGslA2A8nE+ykmoLPDGKUgTqHq1SLXJUJqgfXG/OWggo0l4b2e8wYaEmsLjXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqEzq9rB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqEzq9rB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740374191; x=1771910191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B5Wnjavs3tz+SGvDL7JCaEEWvolmhuwfTsKr0yPk+Ok=;
  b=MqEzq9rBPAdL82XA8OdJO8OglEhKFqeuqRVHItaX0e0FnhtgiUYAIVeN
   f9PPzeW8gmkE6aSY9cL/bWtLC0zsUIRzzjjPirN5PoX5cQsMSGBUmqWQ1
   G4OVXAs5hCFwmeCkKQvQwsH2bo9li3LBnIBcMdaFrxVlHzKE7Fw1+7x6s
   ZQGZogk7rYHY8sRGOaOuH8F+38vVoTv2brlQx7/Aa3SbpwcwB9wPV9re6
   6WHEfhFq2z8xIPJkxW1hb5WCN4FkC2OuVVVo9DWGKec+2TSfzgkzDyf36
   HdH8fD+JjWv1EYwKOxKZVu4mEGcNMNKZGxVbs2YtQIaLWBC04TAUZB9iv
   A==;
X-CSE-ConnectionGUID: OXLK8HA7RXGmZoef/XtvIg==
X-CSE-MsgGUID: eGrWFxkVRJCl06dnZwWrlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="45024203"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45024203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:16:30 -0800
X-CSE-ConnectionGUID: 8VGOrzJ1SDWipcgUTKeDWQ==
X-CSE-MsgGUID: oQiWEgnwQqmsafgCCnxxxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116143391"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 23 Feb 2025 21:16:26 -0800
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 03/12] iommu: Remove IOMMU_DEV_FEAT_SVA
Date: Mon, 24 Feb 2025 13:16:17 +0800
Message-ID: <20250224051627.2956304-4-baolu.lu@linux.intel.com>
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
index 4aaf9b7bf862..3a2faf4fdd09 100644
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

