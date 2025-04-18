Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747726B2D2
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963291; cv=none; b=q/zmFvpgNWAXaKnqxuQ2k9CeQITAJL4BZLdlUlAyzm/S3Z2YSTEJPnlbnAEaFtkh5uk4/wySf7pqIdg9aQ/69dT5EzlRXjOhPxsuDs3YN73Er7+96oyNG6v/vIewILxf8mw00URjOqk9bOlda7BzzXkyj4h/nBG9qYIVEWYT9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963291; c=relaxed/simple;
	bh=xHvdqCW9VAdclXNKbC1MlwSO7w2MFGw/1Ft2J9d8fQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHb5s1NP+a9/h1/i2af1vHyVLwUm1MGAcV7Q4cf0rAPg39wX6Pc3Hyixb6IPM1NPMI5BrvRQtH+d9xHtr3fv0RanP3IRkNipOLvba6ZTydSTfk2ftD/+ODsQtAe1ybB8HeTBepxgP/zxef4ONuGNjJb8xUG4DScPGilh49tB2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAy/tkpf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAy/tkpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744963289; x=1776499289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xHvdqCW9VAdclXNKbC1MlwSO7w2MFGw/1Ft2J9d8fQM=;
  b=kAy/tkpfVXfR60FyJ89snIKeu9YYQPG418vlWSrlo0Yf+NABZl6N9EmB
   LIA1rosHucjtyOaz3YcpgERoy/iuEfZfgYEhsM/qq1e3iZ8Zxg0hSBLA6
   mNUx23APqkH9JIVTyUhI8+0Sz662GsA5FzDo1ZSFIrlFtQJC0NmGCgqGS
   B0orsHvRkF5nwTDXtTolV5iW9xfDx6d1mt3/t6Xx7BtI7Bjhk9nTYQ3ks
   aa2EOLuCoqmS1PwNKCgwPq45lxhOWZCq0ypean42JKFqnRaPlrp97jJt7
   f+3sH+yGvRl00MkIH2z4irftBGDvygyCEE+nOkVUQzKfYgWDShISPLo23
   A==;
X-CSE-ConnectionGUID: 6SFCZm4vTMSz+fKshPTjZQ==
X-CSE-MsgGUID: TcV41muJT0SVAZvu4SR3RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46708555"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="46708555"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:01:29 -0700
X-CSE-ConnectionGUID: W5K9zok5TFOqHy2BBJ4TUw==
X-CSE-MsgGUID: bnsmEDeQSu+2qGeTkk4tyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="131358694"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2025 01:01:26 -0700
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
Subject: [PATCH v5 8/8] iommu: Remove iommu_dev_enable/disable_feature()
Date: Fri, 18 Apr 2025 16:01:30 +0800
Message-ID: <20250418080130.1844424-9-baolu.lu@linux.intel.com>
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
index 17aab6d04a13..a9d539fce982 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2984,36 +2984,6 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
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
@@ -3027,8 +2997,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.def_domain_type = amd_iommu_def_domain_type,
-	.dev_enable_feat = amd_iommu_dev_enable_feature,
-	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 73f9885d20f1..e91d20e5785e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3654,38 +3654,6 @@ static void arm_smmu_get_resv_regions(struct device *dev,
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
@@ -3718,8 +3686,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.dev_enable_feat	= arm_smmu_dev_enable_feature,
-	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.viommu_alloc		= arm_vsmmu_alloc,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9af558390d42..93bc6574d148 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3963,29 +3963,6 @@ void intel_iommu_disable_iopf(struct device *dev)
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
@@ -4428,8 +4405,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.device_group		= intel_iommu_device_group,
-	.dev_enable_feat	= intel_iommu_dev_enable_feat,
-	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.pgsize_bitmap		= SZ_4K,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 264383b507bc..df283bddf6cd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2910,38 +2910,6 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
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
index bfdd2e71e124..5c05c0851f9f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -316,16 +316,6 @@ struct iommu_iort_rmr_data {
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
@@ -657,9 +647,6 @@ struct iommu_ops {
 	bool (*is_attach_deferred)(struct device *dev);
 
 	/* Per device IOMMU features */
-	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
-	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
-
 	void (*page_response)(struct device *dev, struct iopf_fault *evt,
 			      struct iommu_page_response *msg);
 
@@ -1128,9 +1115,6 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
-int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
-int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -1415,18 +1399,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
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

