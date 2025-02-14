Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4281FE44C
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513503; cv=none; b=gG3+LPgmwcl3Ifl49hA9A3ZMBSRf5VMvpz2QFYW27TEZYW+GDroSJzmZJ2GgDj6++SptZaMw5xE5/srbec0B2ElCzHNdSE78Fkr8/Xot0BBD8jtu94tIjAX5p1kIGpNsIETjgNdzA1A/tyssFrsypTMKnuZcW7vY4YZLJKHZmSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513503; c=relaxed/simple;
	bh=z5CHmSpsIFmOesfR9bqyE2APGqdUsxwoh53fDjhiLjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1y6+P+kTQ6MFaGOOnXfnPRhhl5ZJB4efe8Rkno63iQfgz2H6GQHIhkxbM18kPQYS2ZoNVtjEp5ZoHfiqDdrBINnn3zG0RhxAjtjj9VXiZYo7gONT0xjDv8rYUo72rUy9rwhjtOFeAe8vX88/EKaZ1jWtdCMkpGx/DSUyA7ljjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXIetwel; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXIetwel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513501; x=1771049501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z5CHmSpsIFmOesfR9bqyE2APGqdUsxwoh53fDjhiLjs=;
  b=WXIetwelyrFk9lFIr4UwJrHlKyWX2bAVRT+KnNAqQ/52NSHbqOg0uvLq
   j1mwCZvtj5xgxcmAAFORXQp+oajgsYUAf8zHLAYUtEuIdPorLVNN5drpJ
   AIPMMiNa1v+pLujathUnaX/AGmkIlXhBOX9q9jF/O7gMqnizKtHRE3oFL
   ZmuT5377HqlE3qjs3J4isbER4mO3+TXJEVl6UdYlaax33SrPDJHbvg2Gk
   ljEJa50zSS1JlHuF7SLG6wBrOAmPO0+n7aUEYRKvELFurg4yhj0/mwKDF
   YW9ULkQK1vD7gVKzHLcWEeyMZQfyIPHHOHWSPpXoUBGz1rBVZgSrrZS0o
   A==;
X-CSE-ConnectionGUID: Tv301mFaTJWge/wa21RETw==
X-CSE-MsgGUID: dF6taDs/SxCvHKtI7Lwv9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124618"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124618"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:41 -0800
X-CSE-ConnectionGUID: p1fHdXFMQdGfjFTo4KvYzQ==
X-CSE-MsgGUID: 4acGqe8YQPKMgQcIdt32IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268187"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:38 -0800
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
Subject: [PATCH 12/12] iommu: Remove iommu_dev_enable/disable_feature()
Date: Fri, 14 Feb 2025 14:11:04 +0800
Message-ID: <20250214061104.1959525-13-baolu.lu@linux.intel.com>
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

No external drivers use these interfaces anymore. Furthermore, no existing
iommu drivers implement anything in the callbacks. Remove them to avoid
dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/iommu.c                   | 32 -------------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 ---------------------
 drivers/iommu/intel/iommu.c                 | 25 ---------------
 drivers/iommu/iommu.c                       | 32 -------------------
 include/linux/iommu.h                       | 28 -----------------
 5 files changed, 151 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e3653bdfcd7d..8d74afa552fb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2983,36 +2983,6 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
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
@@ -3026,8 +2996,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.def_domain_type = amd_iommu_def_domain_type,
-	.dev_enable_feat = amd_iommu_dev_enable_feature,
-	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ee945a9db641..28e67a9e3861 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3617,38 +3617,6 @@ static void arm_smmu_get_resv_regions(struct device *dev,
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
@@ -3681,8 +3649,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.dev_enable_feat	= arm_smmu_dev_enable_feature,
-	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.viommu_alloc		= arm_vsmmu_alloc,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 20d07f5fea85..aad11e76ac40 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3920,29 +3920,6 @@ void intel_iommu_disable_iopf(struct device *dev)
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
@@ -4387,8 +4364,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.device_group		= intel_iommu_device_group,
-	.dev_enable_feat	= intel_iommu_dev_enable_feat,
-	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.pgsize_bitmap		= SZ_4K,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 870c3cdbd0f6..c86ab80dce4d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2877,38 +2877,6 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
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
index 1d0dde49168d..127f99acab5f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -301,16 +301,6 @@ struct iommu_iort_rmr_data {
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
@@ -630,9 +620,6 @@ struct iommu_ops {
 	bool (*is_attach_deferred)(struct device *dev);
 
 	/* Per device IOMMU features */
-	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
-	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
-
 	void (*page_response)(struct device *dev, struct iopf_fault *evt,
 			      struct iommu_page_response *msg);
 
@@ -1102,9 +1089,6 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
-int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
-int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -1393,18 +1377,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
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

