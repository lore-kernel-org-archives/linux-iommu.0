Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AE26B951
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963274; cv=none; b=GhOTk/NiU+pdSZhtnCsQY5K84o3ZVRA5IAvgGpMY0/CBO+xg8+ufuiIPwW0lCqBgOHdGndFoFhVuQFeEM8rHjdOkuVX/d2bspjC6wIEs2wOeW9HJDVh8BOEDDhrIyyyQTCFOGoNESNOtbNEHE1lW+AJcEHdTVzauypB+1jW3+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963274; c=relaxed/simple;
	bh=lVKb2Ow+iC1sIAH6K7AYwMND/hrpD+cM6y844vnRWGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWrPdm56oU7vDdzDRZGIvEze+fN3b/c6gKn7BHN5jrlicgnGQ9KmMBUiIG3AfRKIXFEKBm2+u7mcICkyzrnm1AdrxTCnPu6tKEGirbLtpSdCC+Jear2PMc9Sy7HHUW+GV2/IpzTV+snbgoLOwCiKFmzlB5vI9EddUEX5RubU0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flOog56r; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flOog56r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744963272; x=1776499272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lVKb2Ow+iC1sIAH6K7AYwMND/hrpD+cM6y844vnRWGA=;
  b=flOog56rj9Yfa+k4A0JiyXhf51tPkNTSgCZA8ZE9Z49shP6DLxg4GLeQ
   nVJKyyepmdmlt90KbQOq6ols3GJlKArrNwikWc+HeEi65mShTkNhkWKOM
   mEWqHv7hzVYPfCiKiIWmukNzgd/ABVyWgNomMb/wiLdzwau6mD0urOLL8
   zFTLITtx6jCK7/hYzWmtbHXOG7jvbO0hFj5vipVjOESfWJV/TD9v4J6Gj
   9m3ozdSyJBePmlZ7vg3oZ1aXT2dq9QOZ+L6ejmMwCvK3ENR731wZ/r5V0
   X6E1GravwuQnMvWi6H5tKpkoAiRFuDx51avPXjR7HaiIOipKbMA0pXKaD
   Q==;
X-CSE-ConnectionGUID: 9HN8W45PTri/tq15qDV98A==
X-CSE-MsgGUID: N/PPKorGR4aZe36QsC2jMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46708471"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="46708471"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:01:12 -0700
X-CSE-ConnectionGUID: VCT4eEGuTkSUoU36JGFNNw==
X-CSE-MsgGUID: jOYINdLOS8SbXu9HwBmimA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="131358593"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2025 01:01:09 -0700
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
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 3/8] iommu/vt-d: Put iopf enablement in domain attach path
Date: Fri, 18 Apr 2025 16:01:25 +0800
Message-ID: <20250418080130.1844424-4-baolu.lu@linux.intel.com>
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

Update iopf enablement in the driver to use the new method, similar to
the arm-smmu-v3 driver. Enable iopf support when any domain with an
iopf_handler is attached, and disable it when the domain is removed.

Place all the logic for controlling the PRI and iopf queue in the domain
set/remove/replace paths. Keep track of the number of domains set to the
device and PASIDs that require iopf. When the first domain requiring iopf
is attached, add the device to the iopf queue and enable PRI. When the
last domain is removed, remove it from the iopf queue and disable PRI.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/intel/iommu.c  | 42 ++++++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.h  | 33 ++++++++++++++++++++++++++++
 drivers/iommu/intel/nested.c | 16 ++++++++++++--
 drivers/iommu/intel/svm.c    |  9 ++++++--
 4 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4c3be92804e2..9af558390d42 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3284,6 +3284,9 @@ void device_block_translation(struct device *dev)
 static int blocking_domain_attach_dev(struct iommu_domain *domain,
 				      struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	iopf_for_domain_remove(info->domain ? &info->domain->domain : NULL, dev);
 	device_block_translation(dev);
 	return 0;
 }
@@ -3494,7 +3497,15 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
+	ret = iopf_for_domain_set(domain, dev);
+	if (ret)
+		return ret;
+
+	ret = dmar_domain_attach_device(to_dmar_domain(domain), dev);
+	if (ret)
+		iopf_for_domain_remove(domain, dev);
+
+	return ret;
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
@@ -3921,6 +3932,8 @@ int intel_iommu_enable_iopf(struct device *dev)
 	if (!info->pri_enabled)
 		return -ENODEV;
 
+	/* pri_enabled is protected by the group mutex. */
+	iommu_group_mutex_assert(dev);
 	if (info->iopf_refcount) {
 		info->iopf_refcount++;
 		return 0;
@@ -3943,6 +3956,7 @@ void intel_iommu_disable_iopf(struct device *dev)
 	if (WARN_ON(!info->pri_enabled || !info->iopf_refcount))
 		return;
 
+	iommu_group_mutex_assert(dev);
 	if (--info->iopf_refcount)
 		return;
 
@@ -3954,8 +3968,7 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		return intel_iommu_enable_iopf(dev);
-
+		return 0;
 	default:
 		return -ENODEV;
 	}
@@ -3966,7 +3979,6 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		intel_iommu_disable_iopf(dev);
 		return 0;
 
 	default:
@@ -4047,6 +4059,7 @@ static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
+	iopf_for_domain_remove(old, dev);
 	intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
 	domain_remove_dev_pasid(old, dev, pasid);
 
@@ -4120,6 +4133,10 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
+	ret = iopf_for_domain_replace(domain, old, dev);
+	if (ret)
+		goto out_remove_dev_pasid;
+
 	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid, old);
@@ -4127,7 +4144,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = domain_setup_second_level(iommu, dmar_domain,
 						dev, pasid, old);
 	if (ret)
-		goto out_remove_dev_pasid;
+		goto out_unwind_iopf;
 
 	domain_remove_dev_pasid(old, dev, pasid);
 
@@ -4135,6 +4152,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 
+out_unwind_iopf:
+	iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
@@ -4349,6 +4368,11 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 	if (dev_is_real_dma_subdevice(dev))
 		return 0;
 
+	/*
+	 * No PRI support with the global identity domain. No need to enable or
+	 * disable PRI in this path as the iommu has been put in the blocking
+	 * state.
+	 */
 	if (sm_supported(iommu))
 		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
 	else
@@ -4368,9 +4392,15 @@ static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
+	ret = iopf_for_domain_replace(domain, old, dev);
+	if (ret)
+		return ret;
+
 	ret = domain_setup_passthrough(iommu, dev, pasid, old);
-	if (ret)
+	if (ret) {
+		iopf_for_domain_replace(old, domain, dev);
 		return ret;
+	}
 
 	domain_remove_dev_pasid(old, dev, pasid);
 	return 0;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8d5d85bf0080..f9dcf0ab93d1 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1297,6 +1297,39 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid);
 int intel_iommu_enable_iopf(struct device *dev);
 void intel_iommu_disable_iopf(struct device *dev);
 
+static inline int iopf_for_domain_set(struct iommu_domain *domain,
+				      struct device *dev)
+{
+	if (!domain || !domain->iopf_handler)
+		return 0;
+
+	return intel_iommu_enable_iopf(dev);
+}
+
+static inline void iopf_for_domain_remove(struct iommu_domain *domain,
+					  struct device *dev)
+{
+	if (!domain || !domain->iopf_handler)
+		return;
+
+	intel_iommu_disable_iopf(dev);
+}
+
+static inline int iopf_for_domain_replace(struct iommu_domain *new,
+					  struct iommu_domain *old,
+					  struct device *dev)
+{
+	int ret;
+
+	ret = iopf_for_domain_set(new, dev);
+	if (ret)
+		return ret;
+
+	iopf_for_domain_remove(old, dev);
+
+	return 0;
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 6ac5c534bef4..d2a94025d0a0 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -56,10 +56,14 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	if (ret)
 		goto detach_iommu;
 
+	ret = iopf_for_domain_set(domain, dev);
+	if (ret)
+		goto unassign_tag;
+
 	ret = intel_pasid_setup_nested(iommu, dev,
 				       IOMMU_NO_PASID, dmar_domain);
 	if (ret)
-		goto unassign_tag;
+		goto disable_iopf;
 
 	info->domain = dmar_domain;
 	spin_lock_irqsave(&dmar_domain->lock, flags);
@@ -67,6 +71,8 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	return 0;
+disable_iopf:
+	iopf_for_domain_remove(domain, dev);
 unassign_tag:
 	cache_tag_unassign_domain(dmar_domain, dev, IOMMU_NO_PASID);
 detach_iommu:
@@ -166,14 +172,20 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
-	ret = domain_setup_nested(iommu, dmar_domain, dev, pasid, old);
+	ret = iopf_for_domain_replace(domain, old, dev);
 	if (ret)
 		goto out_remove_dev_pasid;
 
+	ret = domain_setup_nested(iommu, dmar_domain, dev, pasid, old);
+	if (ret)
+		goto out_unwind_iopf;
+
 	domain_remove_dev_pasid(old, dev, pasid);
 
 	return 0;
 
+out_unwind_iopf:
+	iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ba93123cb4eb..f3da596410b5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,18 +164,23 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
+	ret = iopf_for_domain_replace(domain, old, dev);
+	if (ret)
+		goto out_remove_dev_pasid;
+
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	ret = __domain_setup_first_level(iommu, dev, pasid,
 					 FLPT_DEFAULT_DID, mm->pgd,
 					 sflags, old);
 	if (ret)
-		goto out_remove_dev_pasid;
+		goto out_unwind_iopf;
 
 	domain_remove_dev_pasid(old, dev, pasid);
 
 	return 0;
-
+out_unwind_iopf:
+	iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
-- 
2.43.0

