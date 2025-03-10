Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9061B4F15
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574866; cv=none; b=j34Mw2ow4mXoDB9gUxk8b4UbpHPoXCpDSgMuQr2oLaEOO7s7SgWNqj55gOp1kDDjVpbB27Y27183MUw3RpuzO1/NU5L7mR5qIPV9Xuflt62jzyhzkm+ZCwwrZ/BkxLsZR2YxNgtV5vj8dnF3HaZloqP63Jq+o78D4dbU7FSi7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574866; c=relaxed/simple;
	bh=dgeoentwBe0HLcO4MQEbm5laWuF8AElUddpbU2Pg3DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlVIRrmRpvE+RJU17VD4TX0Wb0cSYJ1xBwX9jEBe7vH1uBPIBDI2v+jRvzaNdQfA4vtVllkNhvnAni2CXdAQ0bk0K/rEmt7UHPrSX7Y0BozoB+CdTaBcwxbqF30Wo3Clnjvfei0VjXTFG7p3Gch3WzrKxX2muVZ+ZnN0M82voYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqLpS2o4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqLpS2o4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741574865; x=1773110865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dgeoentwBe0HLcO4MQEbm5laWuF8AElUddpbU2Pg3DM=;
  b=QqLpS2o4YTQErd9TAakCnDDD6bRH72TCdMMLPuNzm08ay6KClbjZB590
   cYYFhEahMdbVZEadJ26CR4NKDLnEHlw9YfxGctZqYDzH7NOUdLtymg47C
   JeFdKx+1SFZvWiQJbzEJayILmYagXgogG5UAR9TLexNfQ4Ty5x/JumDNU
   zR7fgSenuVCEcWGOfwDI7yPVJhCRXX2bPbNeLasmu1RJcrNsD68EvfZJ8
   QpljAiSbXY1G8XNG0Uk2/YsJaJtGCurZgy+DnRd0ftzUb2UvPWlE4deHs
   32L09hWqvHlwQ6GRRjwi7b0B5dvY4f8822WEWkHKIc7Z2Es3kmnCdkQTg
   w==;
X-CSE-ConnectionGUID: rPsR+uSsSgyZaNIVDHzIcA==
X-CSE-MsgGUID: J6x+rAwNRzaP/B0y6LoinQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42401613"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42401613"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:47:43 -0700
X-CSE-ConnectionGUID: khlVlSr+SNq+qLmIbOFc0g==
X-CSE-MsgGUID: UKioD/1eSMO7oZtfAdWWVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143079237"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2025 19:47:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] iommu/vt-d: Move PRI enablement in probe path
Date: Mon, 10 Mar 2025 10:47:48 +0800
Message-ID: <20250310024749.3702681-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
References: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update PRI enablement to use the new method, similar to the amd iommu
driver. Enable PRI in the device probe path and disable it when the device
is released. PRI is enabled throughout the device's iommu lifecycle. The
infrastructure for the iommu subsystem to handle iopf requests is created
during iopf enablement and released during iopf disablement.  All invalid
page requests from the device are automatically handled by the iommu
subsystem if iopf is not enabled. Add iopf_refcount to track the iopf
enablement.

Convert the return type of intel_iommu_disable_iopf() to void, as there
is no way to handle a failure when disabling this feature.  Make
intel_iommu_enable/disable_iopf() helpers global, as they will be used
beyond the current file in the subsequent patch.

The iopf_refcount is not protected by any lock. This is acceptable, as
there is no concurrent access to it in the current code. The following
patch will address this by moving it to the domain attach/detach paths,
which are protected by the iommu group mutex.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Link: https://lore.kernel.org/r/20250228092631.3425464-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 137 +++++++++++++-----------------------
 drivers/iommu/intel/iommu.h |   4 ++
 drivers/iommu/intel/pasid.c |   2 +
 drivers/iommu/intel/prq.c   |   2 +-
 4 files changed, 55 insertions(+), 90 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1c8724cd2ddc..6a6c271ef7e6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1197,6 +1197,37 @@ static void iommu_disable_pci_ats(struct device_domain_info *info)
 	info->ats_enabled = 0;
 }
 
+static void iommu_enable_pci_pri(struct device_domain_info *info)
+{
+	struct pci_dev *pdev;
+
+	if (!info->ats_enabled || !info->pri_supported)
+		return;
+
+	pdev = to_pci_dev(info->dev);
+	/* PASID is required in PRG Response Message. */
+	if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev))
+		return;
+
+	if (pci_reset_pri(pdev))
+		return;
+
+	if (!pci_enable_pri(pdev, PRQ_DEPTH))
+		info->pri_enabled = 1;
+}
+
+static void iommu_disable_pci_pri(struct device_domain_info *info)
+{
+	if (!info->pri_enabled)
+		return;
+
+	if (WARN_ON(info->iopf_refcount))
+		iopf_queue_remove_device(info->iommu->iopf_queue, info->dev);
+
+	pci_disable_pri(to_pci_dev(info->dev));
+	info->pri_enabled = 0;
+}
+
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	cache_tag_flush_all(to_dmar_domain(domain));
@@ -3763,6 +3794,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	if (sm_supported(iommu))
 		iommu_enable_pci_ats(info);
+	iommu_enable_pci_pri(info);
 
 	return &iommu->iommu;
 free_table:
@@ -3780,6 +3812,7 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	iommu_disable_pci_pri(info);
 	iommu_disable_pci_ats(info);
 
 	if (info->pasid_enabled) {
@@ -3868,116 +3901,41 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
-static int context_flip_pri(struct device_domain_info *info, bool enable)
+int intel_iommu_enable_iopf(struct device *dev)
 {
-	struct intel_iommu *iommu = info->iommu;
-	u8 bus = info->bus, devfn = info->devfn;
-	struct context_entry *context;
-	u16 did;
-
-	spin_lock(&iommu->lock);
-	if (context_copied(iommu, bus, devfn)) {
-		spin_unlock(&iommu->lock);
-		return -EINVAL;
-	}
-
-	context = iommu_context_addr(iommu, bus, devfn, false);
-	if (!context || !context_present(context)) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
-	did = context_domain_id(context);
-
-	if (enable)
-		context_set_sm_pre(context);
-	else
-		context_clear_sm_pre(context);
-
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(context, sizeof(*context));
-	intel_context_flush_present(info, context, did, true);
-	spin_unlock(&iommu->lock);
-
-	return 0;
-}
-
-static int intel_iommu_enable_iopf(struct device *dev)
-{
-	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu;
+	struct intel_iommu *iommu = info->iommu;
 	int ret;
 
-	if (!pdev || !info || !info->ats_enabled || !info->pri_supported)
+	if (!info->pri_enabled)
 		return -ENODEV;
 
-	if (info->pri_enabled)
-		return -EBUSY;
-
-	iommu = info->iommu;
-	if (!iommu)
-		return -EINVAL;
-
-	/* PASID is required in PRG Response Message. */
-	if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev))
-		return -EINVAL;
-
-	ret = pci_reset_pri(pdev);
-	if (ret)
-		return ret;
+	if (info->iopf_refcount) {
+		info->iopf_refcount++;
+		return 0;
+	}
 
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
 	if (ret)
 		return ret;
 
-	ret = context_flip_pri(info, true);
-	if (ret)
-		goto err_remove_device;
-
-	ret = pci_enable_pri(pdev, PRQ_DEPTH);
-	if (ret)
-		goto err_clear_pri;
-
-	info->pri_enabled = 1;
+	info->iopf_refcount = 1;
 
 	return 0;
-err_clear_pri:
-	context_flip_pri(info, false);
-err_remove_device:
-	iopf_queue_remove_device(iommu->iopf_queue, dev);
-
-	return ret;
 }
 
-static int intel_iommu_disable_iopf(struct device *dev)
+void intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
-	if (!info->pri_enabled)
-		return -EINVAL;
+	if (WARN_ON(!info->pri_enabled || !info->iopf_refcount))
+		return;
 
-	/* Disable new PRI reception: */
-	context_flip_pri(info, false);
+	if (--info->iopf_refcount)
+		return;
 
-	/*
-	 * Remove device from fault queue and acknowledge all outstanding
-	 * PRQs to the device:
-	 */
 	iopf_queue_remove_device(iommu->iopf_queue, dev);
-
-	/*
-	 * PCIe spec states that by clearing PRI enable bit, the Page
-	 * Request Interface will not issue new page requests, but has
-	 * outstanding page requests that have been transmitted or are
-	 * queued for transmission. This is supposed to be called after
-	 * the device driver has stopped DMA, all PASIDs have been
-	 * unbound and the outstanding PRQs have been drained.
-	 */
-	pci_disable_pri(to_pci_dev(dev));
-	info->pri_enabled = 0;
-
-	return 0;
 }
 
 static int
@@ -4000,7 +3958,8 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		return intel_iommu_disable_iopf(dev);
+		intel_iommu_disable_iopf(dev);
+		return 0;
 
 	case IOMMU_DEV_FEAT_SVA:
 		return 0;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index dd980808998d..42b4e500989b 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -774,6 +774,7 @@ struct device_domain_info {
 	u8 ats_enabled:1;
 	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
 	u8 ats_qdep;
+	unsigned int iopf_refcount;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
@@ -1295,6 +1296,9 @@ void intel_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 			       struct iommu_page_response *msg);
 void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid);
 
+int intel_iommu_enable_iopf(struct device *dev);
+void intel_iommu_disable_iopf(struct device *dev);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index fb59a7d35958..c2742e256552 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -992,6 +992,8 @@ static int context_entry_set_pasid_table(struct context_entry *context,
 		context_set_sm_dte(context);
 	if (info->pasid_supported)
 		context_set_pasid(context);
+	if (info->pri_supported)
+		context_set_sm_pre(context);
 
 	context_set_fault_enable(context);
 	context_set_present(context);
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index 064194399b38..5b6a64d96850 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -67,7 +67,7 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 	u16 sid, did;
 
 	info = dev_iommu_priv_get(dev);
-	if (!info->pri_enabled)
+	if (!info->iopf_refcount)
 		return;
 
 	iommu = info->iommu;
-- 
2.43.0

