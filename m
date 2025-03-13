Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7D1FAC46
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843193; cv=none; b=PCDeZORVl1J22liku/84GTtpAhE3BqPsp57zKkAJ6fUEpiapPjNdB6zDgqZzo38q9J2AzmTXNCg6XYFju+VyxNZ/cEBC7kf+beMdA5yA8YfrUdKHTJSaaTtpo0YP7Ojkxx8H6+29hAipcmxv78CmEwx/GQx4Ezy7aaKeA1oFd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843193; c=relaxed/simple;
	bh=OsPnqn8stGVN29sdcgTKrocAvdCEyCUXSwHRlazMKIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFk+21R/TZL7BCqYpD6SryA7tQMpweKVqH2yOsJ94e7MTwDJFaCtmsJ9+KB7GWX0F1glLezLbAZClz9IfQC5ysOcGXvWKfEIn5xp2eKvHrwSsIzsJGCUxIMjVhmgEQ/F6643TrOWuz6Wp3Kq7F8+AwxA5y9dShYojWaBRD7yjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxpgvRVb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxpgvRVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741843190; x=1773379190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OsPnqn8stGVN29sdcgTKrocAvdCEyCUXSwHRlazMKIU=;
  b=NxpgvRVbHK85voxz/qkAj36ta6LQJYIk80FLnOtozp7BimXd3TAIieNF
   8u1keT+MLS+PiOSgExd10urn/75NY8DiFVB0bPZb0WcV7IY25T5Ni7JX2
   /CK7o5vrTobEmzT9B240hL7tEdcM3KnTxGqe9sn/NGVjmV9XmW4cxpS7v
   aMR1kxxuyNZ0mM2z+esB/wCS756eNNFFYosHchiLfxb9WGQck4Tw4ghL1
   oH4j6m7q6ZJ4xBVMOOah6XJccV0EKSjdGtgvlAmw874Lc6E+8RaiAt9I7
   dN9XH015W8j30VjxtocfgFAnKyM+ObD93HbOqYm8c6k4m/0P6XFvOAfOz
   Q==;
X-CSE-ConnectionGUID: kTKwyBw2Q3uvH82yrMOXoA==
X-CSE-MsgGUID: F2GXpNV2RAKEBmyRzVH+3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54323670"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="54323670"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 22:19:50 -0700
X-CSE-ConnectionGUID: y1YuBFcXTfaVWqqmGWYhRw==
X-CSE-MsgGUID: Wd3EShg7RiqSyFxZQD0XAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151807079"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 22:19:47 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 3/8] iommu/vt-d: Put iopf enablement in domain attach path
Date: Thu, 13 Mar 2025 13:19:48 +0800
Message-ID: <20250313051953.4064532-4-baolu.lu@linux.intel.com>
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
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/intel/iommu.c  | 42 ++++++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.h  | 33 ++++++++++++++++++++++++++++
 drivers/iommu/intel/nested.c | 16 ++++++++++++--
 drivers/iommu/intel/svm.c    |  9 ++++++--
 4 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8d557d04a273..227cbe7a66bc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3280,6 +3280,9 @@ void device_block_translation(struct device *dev)
 static int blocking_domain_attach_dev(struct iommu_domain *domain,
 				      struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	iopf_for_domain_remove(info->domain ? &info->domain->domain : NULL, dev);
 	device_block_translation(dev);
 	return 0;
 }
@@ -3489,7 +3492,15 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
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
@@ -3910,6 +3921,8 @@ int intel_iommu_enable_iopf(struct device *dev)
 	if (!info->pri_enabled)
 		return -ENODEV;
 
+	/* pri_enabled is protected by the group mutex. */
+	iommu_group_mutex_assert(dev);
 	if (info->iopf_refcount) {
 		info->iopf_refcount++;
 		return 0;
@@ -3932,6 +3945,7 @@ void intel_iommu_disable_iopf(struct device *dev)
 	if (WARN_ON(!info->pri_enabled || !info->iopf_refcount))
 		return;
 
+	iommu_group_mutex_assert(dev);
 	if (--info->iopf_refcount)
 		return;
 
@@ -3943,8 +3957,7 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		return intel_iommu_enable_iopf(dev);
-
+		return 0;
 	default:
 		return -ENODEV;
 	}
@@ -3955,7 +3968,6 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		intel_iommu_disable_iopf(dev);
 		return 0;
 
 	default:
@@ -4036,6 +4048,7 @@ static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
+	iopf_for_domain_remove(old, dev);
 	intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
 	domain_remove_dev_pasid(old, dev, pasid);
 
@@ -4109,6 +4122,10 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
+	ret = iopf_for_domain_replace(domain, old, dev);
+	if (ret)
+		goto out_remove_dev_pasid;
+
 	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid, old);
@@ -4116,7 +4133,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = domain_setup_second_level(iommu, dmar_domain,
 						dev, pasid, old);
 	if (ret)
-		goto out_remove_dev_pasid;
+		goto out_unwind_iopf;
 
 	domain_remove_dev_pasid(old, dev, pasid);
 
@@ -4124,6 +4141,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 
+out_unwind_iopf:
+	iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
@@ -4338,6 +4357,11 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
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
@@ -4357,9 +4381,15 @@ static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
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
index c4916886da5a..02649eafcc24 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1298,6 +1298,39 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid);
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

