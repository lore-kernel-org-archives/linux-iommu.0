Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E141FC7E8
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513479; cv=none; b=X5Knp/p4w0TjnD827jvgyfpiaHFbIjiYqvHHJqgc+DACFocKK2G+PWYVZzsO19cYcI9KlG/g6iycr7CrLLRtIvH/jDYXuYfHjYjo4hwW/qls7t1QCOx7D7UseIS4VJH7qfV1AZLQ2pIe+6LjhnrAYKTOVXi/sfdRrqbTUy2R6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513479; c=relaxed/simple;
	bh=GOZqyliaqlfKT5b1FsGeKsIwtb6yo0npf3cr3VU+cTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmk/U/1E7QxAlyz3xequFG6OWGW/LFChCoibaMIK2MEGJfFCbFCfw5r3ZeDJ1rMzSdArtrLIRXwZi5x8WN8zVMMEHpDfeVeL6raK7P/Q1Aa27ZqobR42vz2GO0FHP1kA5uVpInCGt/J2dXILrJsV77cmKrsEo4pEKQqXqfexF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8PMvOFL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8PMvOFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513478; x=1771049478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GOZqyliaqlfKT5b1FsGeKsIwtb6yo0npf3cr3VU+cTU=;
  b=X8PMvOFLK+21zFzG6LV76w/ibk6ImAwkkfwULwv6DO4ErH2kEkomx6q1
   ywyYbgupV2q1tW4q/ZEaNDC1b0rILGBoGTet1ihag6Pg+OWPlkZoN4VXJ
   K5i7eSXS/Kyyn8eKZfs+nVHeyAWqknJVpx2honrKYGhM+mJQ/8wbVoE8n
   7aKPNJ48NCxeOaXJS/ep05wtRqgPEcs+rplyEUSUY6n7eTXnmLgK88Sqs
   gYOCYy2XKqSlUcxDcgm1hpSWG0/X38DMAWE71l4iluEDzZXyWkargAhWB
   tvjcnjl4OfNxOPWY9awxw/kvjBHZ9qyE9yqDgRgd/kP9x9IhCiLUzVPQB
   Q==;
X-CSE-ConnectionGUID: 04uDqgWfQ3u+O6VKPSbVig==
X-CSE-MsgGUID: 9732U7mmQ9S73u43cgbWxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124518"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124518"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:17 -0800
X-CSE-ConnectionGUID: X7qgak+ST9eYdT8PIWkv4w==
X-CSE-MsgGUID: hJ/YtUldQgq7m4PHJQH2eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268110"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:14 -0800
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
Subject: [PATCH 05/12] iommu/vt-d: Move PRI enablement in probe path
Date: Fri, 14 Feb 2025 14:10:57 +0800
Message-ID: <20250214061104.1959525-6-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 145 +++++++++++-------------------------
 drivers/iommu/intel/iommu.h |   4 +
 drivers/iommu/intel/pasid.c |   2 +
 drivers/iommu/intel/prq.c   |   2 +-
 4 files changed, 51 insertions(+), 102 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f52602bde742..91d49e2cea34 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3743,6 +3743,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			else
 				info->ats_enabled = 1;
 		}
+
+		if (info->ats_enabled && info->pri_supported) {
+			/* PASID is required in PRG Response Message. */
+			if (info->pasid_enabled || !pci_prg_resp_pasid_required(pdev)) {
+				if (!pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
+					info->pri_enabled = 1;
+				else
+					pci_info(pdev, "Failed to enable PRI on device\n");
+			}
+		}
 	}
 
 	return &iommu->iommu;
@@ -3761,6 +3771,13 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	WARN_ON(info->iopf_refcount);
+
+	if (info->pri_enabled) {
+		pci_disable_pri(to_pci_dev(dev));
+		info->pri_enabled = 0;
+	}
+
 	if (info->ats_enabled) {
 		pci_disable_ats(to_pci_dev(dev));
 		info->ats_enabled = 0;
@@ -3852,118 +3869,43 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
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
-		return -ENODEV;
-
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
-
-	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
-	if (ret)
-		return ret;
-
-	ret = context_flip_pri(info, true);
-	if (ret)
-		goto err_remove_device;
-
-	ret = pci_enable_pri(pdev, PRQ_DEPTH);
-	if (ret)
-		goto err_clear_pri;
-
-	info->pri_enabled = 1;
-
-	return 0;
-err_clear_pri:
-	context_flip_pri(info, false);
-err_remove_device:
-	iopf_queue_remove_device(iommu->iopf_queue, dev);
-
-	return ret;
-}
-
-static int intel_iommu_disable_iopf(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
-
 	if (!info->pri_enabled)
-		return -EINVAL;
+		return -ENODEV;
 
-	/* Disable new PRI reception: */
-	context_flip_pri(info, false);
+	if (info->iopf_refcount) {
+		info->iopf_refcount++;
+		return 0;
+	}
 
-	/*
-	 * Remove device from fault queue and acknowledge all outstanding
-	 * PRQs to the device:
-	 */
-	iopf_queue_remove_device(iommu->iopf_queue, dev);
+	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
+	if (ret)
+		return ret;
 
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
+	info->iopf_refcount = 1;
 
 	return 0;
 }
 
+void intel_iommu_disable_iopf(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	if (WARN_ON(!info->pri_enabled))
+		return;
+
+	if (--info->iopf_refcount)
+		return;
+
+	iopf_queue_remove_device(iommu->iopf_queue, dev);
+}
+
 static int
 intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
@@ -3981,7 +3923,8 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		return intel_iommu_disable_iopf(dev);
+		intel_iommu_disable_iopf(dev);
+		return 0;
 
 	default:
 		return -ENODEV;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6ea7bbe26b19..f7d78cf0778c 100644
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
@@ -1314,6 +1315,9 @@ void intel_iommu_page_response(struct device *dev, struct iopf_fault *evt,
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
index c2d792db52c3..2bdaf9293ab4 100644
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

