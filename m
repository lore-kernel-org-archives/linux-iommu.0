Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7E1FC0EA
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843208; cv=none; b=ZULoO/k67NzbMOrxGSIifYy0o2ezudJurpuI7+79Z05v8XuHTRindz73phqjQZoKDBHGvMok1iGqvO0QtTAqhx8p8UTGrtviaLW+0VoJpEl5HXvMlZuvnUQncjgIhqcjE1Y86Q4QYXgirKYF/SjZ0Gg1/wSzfjb9oCalD+LoKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843208; c=relaxed/simple;
	bh=IicNJJWhcVrC701Xw55MKOCimwP8CKV9QzJcDXc1rU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk71BzMQU9a/B7UOQ+7BqrNtX0Ngr1ioWou16fqByFojk3cqBmTkyMd82f34Gfgaj1a/Pgp/HhNthiSeybnHOn5YCjhL5KFXhAauWqD6bxnYxifWiN1vfHTgo2/ifdaLqR0Uzczjo1382bmmrSHiZ048/M08eknSJLJPepER6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmZu5FrO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmZu5FrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741843207; x=1773379207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IicNJJWhcVrC701Xw55MKOCimwP8CKV9QzJcDXc1rU4=;
  b=OmZu5FrOr7dyvyeOW+E6l/DEQZYhRtfJHJNzBalSAT1K8IFH87TUaUv7
   2QEaEDSKhKXhRZf1gsuQWynSHIR3X1NLL4j4pFyon+Lqqqm2M55GQRh4V
   beXeAeCNVaM8e8+AXAH27MAYbF3zUO/JUsM1myX1iRxhinn+9fV3cKD9b
   +sxpW1x/uH9/jYPy+ZMwsg3KuluqJKg6sgSb/7M3ujA3fW2noNd1B/HH5
   lOw1g2x2dx6LyIQcUyuLPLQ2Lb36PzjCV/35xB9mz+esDAfQ9kHuBAkWw
   KC7FL+lfi48VyoiitIVBDDb3c9bWZ9Hayp5rV8LvpgLOqlqQNxykDXl+H
   g==;
X-CSE-ConnectionGUID: Q3V4v+vCSVCnT603iL0xrg==
X-CSE-MsgGUID: eGkjtOWwSHOmWeTJHghD8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54323749"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="54323749"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 22:20:07 -0700
X-CSE-ConnectionGUID: a+i5FHz+TmKFiFhPsszcaQ==
X-CSE-MsgGUID: VrHdXNiWSbaDe1zlTmr0Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151807188"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 22:20:04 -0700
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
Subject: [PATCH v4 8/8] iommu: Remove iommu_dev_enable/disable_feature()
Date: Thu, 13 Mar 2025 13:19:53 +0800
Message-ID: <20250313051953.4064532-9-baolu.lu@linux.intel.com>
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

No external drivers use these interfaces anymore. Furthermore, no existing
iommu drivers implement anything in the callbacks. Remove them to avoid
dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/amd/iommu.c                   | 32 -------------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 ---------------------
 drivers/iommu/intel/iommu.c                 | 25 ---------------
 drivers/iommu/iommu.c                       | 32 -------------------
 include/linux/iommu.h                       | 28 -----------------
 5 files changed, 151 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 25449a564804..16892bff1eaa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2980,36 +2980,6 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
 
-static int amd_iommu_dev_enable_feature(struct device *dev,
-					enum iommu_dev_features feat)
-{
-	int ret = 0;
-
-	switch (feat) {
-	case IOMMU_DEV_FEAT_IOPF:
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-	return ret;
-}
-
-static int amd_iommu_dev_disable_feature(struct device *dev,
-					 enum iommu_dev_features feat)
-{
-	int ret = 0;
-
-	switch (feat) {
-	case IOMMU_DEV_FEAT_IOPF:
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-	return ret;
-}
-
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
@@ -3023,8 +2993,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.def_domain_type = amd_iommu_def_domain_type,
-	.dev_enable_feat = amd_iommu_dev_enable_feature,
-	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 60c8f1fa5bf0..fc6943b2665a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3620,38 +3620,6 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static int arm_smmu_dev_enable_feature(struct device *dev,
-				       enum iommu_dev_features feat)
-{
-	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-
-	if (!master)
-		return -ENODEV;
-
-	switch (feat) {
-	case IOMMU_DEV_FEAT_IOPF:
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-static int arm_smmu_dev_disable_feature(struct device *dev,
-					enum iommu_dev_features feat)
-{
-	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-
-	if (!master)
-		return -EINVAL;
-
-	switch (feat) {
-	case IOMMU_DEV_FEAT_IOPF:
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
 /*
  * HiSilicon PCIe tune and trace device can be used to trace TLP headers on the
  * PCIe link and save the data to memory by DMA. The hardware is restricted to
@@ -3684,8 +3652,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.dev_enable_feat	= arm_smmu_dev_enable_feature,
-	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.viommu_alloc		= arm_vsmmu_alloc,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 227cbe7a66bc..9f14195e7781 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3952,29 +3952,6 @@ void intel_iommu_disable_iopf(struct device *dev)
 	iopf_queue_remove_device(iommu->iopf_queue, dev);
 }
 
-static int
-intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
-{
-	switch (feat) {
-	case IOMMU_DEV_FEAT_IOPF:
-		return 0;
-	default:
-		return -ENODEV;
-	}
-}
-
-static int
-intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
-{
-	switch (feat) {
-	case IOMMU_DEV_FEAT_IOPF:
-		return 0;
-
-	default:
-		return -ENODEV;
-	}
-}
-
 static bool intel_iommu_is_attach_deferred(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
@@ -4416,8 +4393,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.device_group		= intel_iommu_device_group,
-	.dev_enable_feat	= intel_iommu_dev_enable_feat,
-	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.pgsize_bitmap		= SZ_4K,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c283721579b3..f3e70b146826 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2884,38 +2884,6 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
-/*
- * Per device IOMMU features.
- */
-int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
-{
-	if (dev_has_iommu(dev)) {
-		const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-		if (ops->dev_enable_feat)
-			return ops->dev_enable_feat(dev, feat);
-	}
-
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
-
-/*
- * The device drivers should do the necessary cleanups before calling this.
- */
-int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
-{
-	if (dev_has_iommu(dev)) {
-		const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-		if (ops->dev_disable_feat)
-			return ops->dev_disable_feat(dev, feat);
-	}
-
-	return -EBUSY;
-}
-EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
-
 /**
  * iommu_setup_default_domain - Set the default_domain for the group
  * @group: Group to change
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1308c8f85591..e6c21e15c74f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -321,16 +321,6 @@ struct iommu_iort_rmr_data {
 	u32 num_sids;
 };
 
-/**
- * enum iommu_dev_features - Per device IOMMU features
- * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall.
- *
- * Device drivers enable a feature using iommu_dev_enable_feature().
- */
-enum iommu_dev_features {
-	IOMMU_DEV_FEAT_IOPF,
-};
-
 #define IOMMU_NO_PASID	(0U) /* Reserved for DMA w/o PASID */
 #define IOMMU_FIRST_GLOBAL_PASID	(1U) /*starting range for allocation */
 #define IOMMU_PASID_INVALID	(-1U)
@@ -650,9 +640,6 @@ struct iommu_ops {
 	bool (*is_attach_deferred)(struct device *dev);
 
 	/* Per device IOMMU features */
-	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
-	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
-
 	void (*page_response)(struct device *dev, struct iopf_fault *evt,
 			      struct iommu_page_response *msg);
 
@@ -1121,9 +1108,6 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
-int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
-int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -1408,18 +1392,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
-static inline int
-iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
-{
-	return -ENODEV;
-}
-
-static inline int
-iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
-{
-	return -ENODEV;
-}
-
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
 	return NULL;
-- 
2.43.0

