Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA71FCF54
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513486; cv=none; b=JiXKO4RMgQ+PGhwrVZRfby0ELkMFNvTEKfb29v4+i3Bf78Po2YKH8+DqIcVoblIYL3X/s0xwOQebC6drk8L+pkXeF58UC8iHUj8PyA3dt12K3caczI0HVuJH65lDWAz9GmfVO61YzhQklaAsTEH+TLjVfDkmxYI+1Yy20Ecjbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513486; c=relaxed/simple;
	bh=WH8Sh6k+wR2mFocNNDMzXcNLMpGaPtVWIrSa7fLjAfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJFtb5ws85davV82fX/+DraiNdxpjtJktEGBqUNwNgJyQUvMEeyuBuWJ0gx8ijGGZdETAsPB1R1XPDhxF1RNjIbufpMMgYeIyx69pXUP4XhDV6MR8vvHsi2sBMgQN0GCtBBtht/Q47rdSJPAaIe4VAGnVubVhxLYfN3i7UgeMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFeMWhn0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFeMWhn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513485; x=1771049485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WH8Sh6k+wR2mFocNNDMzXcNLMpGaPtVWIrSa7fLjAfM=;
  b=dFeMWhn01idOIj1WtqGtj3yJicRRuGMycLtvQiC6pOkzmiwNY9AAW8nU
   P6pleMENgdSmC1x/QBvxnVaVkz+t24If8PLHAjobJLZWApiosPQx/+Vuz
   D+vTclHQobdU2/0IdNlg0dfPd3dbywN8L6vPqShbEmDlFblU+/3amQsiB
   kcxZkI0pUg3gSzMxSxAe0OVoj2Ots7m5qqpOEcQ1LRuMTdCpMMpsImyNj
   FX8Wyezkq0LfJzpgbolw4jG0LkmUFCSWTUCohF5UJ5PhTlWpWoTZSP6p+
   CyHJ+jYOfGI4TMc2FAxpGWAdqZSIl82UQgQyZMA5Es2lBjrnM32hFF7gK
   g==;
X-CSE-ConnectionGUID: yeSiIuWwSdScGJO5iuYI3A==
X-CSE-MsgGUID: YFsh4nFTSaG5jbu3nJi5Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124553"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124553"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:24 -0800
X-CSE-ConnectionGUID: NlaYAP5MQpKSsOEjJmhnQQ==
X-CSE-MsgGUID: YHAeWMmNRYOsCLlsCAxhhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268136"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:21 -0800
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
Subject: [PATCH 07/12] iommu/vt-d: Put iopf enablement in domain attach path
Date: Fri, 14 Feb 2025 14:10:59 +0800
Message-ID: <20250214061104.1959525-8-baolu.lu@linux.intel.com>
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

Update iopf enablement in the driver to use the new method, similar to
the arm-smmu-v3 driver. Enable iopf support when any domain with an
iopf_handler is attached, and disable it when the domain is removed.

Place all the logic for controlling the PRI and iopf queue in the domain
set/remove/replace paths. Keep track of the number of domains set to the
device and PASIDs that require iopf. When the first domain requiring iopf
is attached, add the device to the iopf queue and enable PRI. When the
last domain is removed, remove it from the iopf queue and disable PRI.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c  | 42 ++++++++++++++++++++++++++++++-----
 drivers/iommu/intel/iommu.h  | 43 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/nested.c | 16 ++++++++++++--
 drivers/iommu/intel/svm.c    |  9 ++++++--
 4 files changed, 100 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1d564240c977..20d07f5fea85 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3223,6 +3223,9 @@ void device_block_translation(struct device *dev)
 static int blocking_domain_attach_dev(struct iommu_domain *domain,
 				      struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	iopf_for_domain_remove(info->domain ? &info->domain->domain : NULL, dev);
 	device_block_translation(dev);
 	return 0;
 }
@@ -3432,7 +3435,15 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
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
@@ -3878,6 +3889,8 @@ int intel_iommu_enable_iopf(struct device *dev)
 	if (!info->pri_enabled)
 		return -ENODEV;
 
+	/* pri_enabled is protected by the group mutex. */
+	iommu_group_mutex_assert(dev);
 	if (info->iopf_refcount) {
 		info->iopf_refcount++;
 		return 0;
@@ -3900,6 +3913,7 @@ void intel_iommu_disable_iopf(struct device *dev)
 	if (WARN_ON(!info->pri_enabled))
 		return;
 
+	iommu_group_mutex_assert(dev);
 	if (--info->iopf_refcount)
 		return;
 
@@ -3911,8 +3925,7 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		return intel_iommu_enable_iopf(dev);
-
+		return 0;
 	default:
 		return -ENODEV;
 	}
@@ -3923,7 +3936,6 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		intel_iommu_disable_iopf(dev);
 		return 0;
 
 	default:
@@ -4004,6 +4016,7 @@ static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
+	iopf_for_domain_remove(old, dev);
 	intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
 	domain_remove_dev_pasid(old, dev, pasid);
 
@@ -4077,6 +4090,10 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
+	ret = iopf_for_domain_replace(domain, old, dev);
+	if (ret)
+		goto out_remove_dev_pasid;
+
 	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid, old);
@@ -4084,7 +4101,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = domain_setup_second_level(iommu, dmar_domain,
 						dev, pasid, old);
 	if (ret)
-		goto out_remove_dev_pasid;
+		goto out_unwind_iopf;
 
 	domain_remove_dev_pasid(old, dev, pasid);
 
@@ -4092,6 +4109,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 
+out_unwind_iopf:
+	iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
@@ -4309,6 +4328,11 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
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
@@ -4328,9 +4352,15 @@ static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
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
index 754f6d7ade26..dfb0628fabf8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1317,6 +1317,49 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid);
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
+	if (!old)
+		return iopf_for_domain_set(new, dev);
+
+	if (!new) {
+		iopf_for_domain_remove(old, dev);
+		return 0;
+	}
+
+	/*
+	 * Replace a non-iopf-capable domain with an iopf-capable one requires
+	 * to enable PRI on the device. On the contrary, disable it.
+	 */
+	if (new->iopf_handler && !old->iopf_handler)
+		return intel_iommu_enable_iopf(dev);
+
+	if (!new->iopf_handler && old->iopf_handler)
+		intel_iommu_disable_iopf(dev);
+
+	return 0;
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index aba92c00b427..ad307248bcae 100644
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

