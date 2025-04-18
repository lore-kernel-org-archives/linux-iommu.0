Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8F26FD8D
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963288; cv=none; b=JQ3BGkIVca6UJPeUfluJuxnh7eSQ5tsWmeFqNl78zfw35PX+Wg3yxO1Ru7FnLu2FoWJQIqt4W9c2oOdOyf4zFPjuouC/jsgaphOPb5Z12u/OZxzYF31lmt3S//MhAl2gyQDBh22n7/Pd2eCw4pC6bqrbIUEZ4Qkb9SvZfrDXU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963288; c=relaxed/simple;
	bh=2ivYTc1Aw/K7/4eZ2gxR9fOzWvHJ5qgw1szy/sntLAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgXL6UDsT7sF/3i1JfNQ0F4ptqYH4/3nomuR2bwCG/B8YXOaW3CunwGpvmXdz4pQU8mvHr6IMYBPagfWspqxMrOMz/LOubMM3iMDizCRgRW3IINTYbV7CS+j235bfOp93C/7jiks9CelGEG2DAQgocgzVj2gKLsb19NwLgRy/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HL/pzvpU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HL/pzvpU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744963286; x=1776499286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ivYTc1Aw/K7/4eZ2gxR9fOzWvHJ5qgw1szy/sntLAU=;
  b=HL/pzvpUX370dwi+s+rSawCydz8RoUreg89K95GYImbnW4993nGYlqqH
   LNIyWUMz04GoGq7Lgwu1RaCTPYjggmeLz57Hyht7Uewtf9cM+0htm6OS2
   aZz61JTIv2/z8zlKysMBDUTjK9zad3TgXogOwV/CbfnFzLF2/3gLi82eJ
   a+Gxc47T67H+/V3gZL32wRtf8qq4rEhNtn5vXK/7B7Ji3CYjMm48jzCCt
   fVoHmi7+Yu630KUs0QXS5iYEAi3eWDgEQT9ySTH48M/+IXSP1EunuVNAu
   cpn84NMxXN+F0+CKWZ4/59UAfYx1Fa0pMgycsRXTEWmn8ZZVuAF1v61ne
   Q==;
X-CSE-ConnectionGUID: SehmfXHPQgGNrWReie7pAA==
X-CSE-MsgGUID: WQg+Tre8QLOr1XfSl+OPgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46708540"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="46708540"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:01:26 -0700
X-CSE-ConnectionGUID: Q8sUrZy6Q0KxwUpx6k1Y+g==
X-CSE-MsgGUID: rikO5Jo4Req/26nNS6CRVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="131358674"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2025 01:01:22 -0700
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
Subject: [PATCH v5 7/8] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Fri, 18 Apr 2025 16:01:29 +0800
Message-ID: <20250418080130.1844424-8-baolu.lu@linux.intel.com>
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

The iopf enablement has been moved to the iommu drivers. It is unnecessary
for iommufd to handle iopf enablement. Remove the iopf enablement logic to
avoid duplication.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommufd/device.c          | 59 ++++++++++++-------------
 drivers/iommu/iommufd/eventq.c          | 48 +-------------------
 drivers/iommu/iommufd/iommufd_private.h |  6 ---
 3 files changed, 30 insertions(+), 83 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2111bad72c72..86244403b532 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -221,7 +221,6 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
-	mutex_init(&idev->iopf_lock);
 
 	/*
 	 * If the caller fails after this success it must call
@@ -425,6 +424,25 @@ static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
 	return 0;
 }
 
+static bool iommufd_hwpt_compatible_device(struct iommufd_hw_pagetable *hwpt,
+					   struct iommufd_device *idev)
+{
+	struct pci_dev *pdev;
+
+	if (!hwpt->fault || !dev_is_pci(idev->dev))
+		return true;
+
+	/*
+	 * Once we turn on PCI/PRI support for VF, the response failure code
+	 * should not be forwarded to the hardware due to PRI being a shared
+	 * resource between PF and VFs. There is no coordination for this
+	 * shared capability. This waits for a vPRI reset to recover.
+	 */
+	pdev = to_pci_dev(idev->dev);
+
+	return (!pdev->is_virtfn || !pci_pri_supported(pdev));
+}
+
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 				      struct iommufd_device *idev,
 				      ioasid_t pasid)
@@ -432,6 +450,9 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach_handle *handle;
 	int rc;
 
+	if (!iommufd_hwpt_compatible_device(hwpt, idev))
+		return -EINVAL;
+
 	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
 	if (rc)
 		return rc;
@@ -440,12 +461,6 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	if (!handle)
 		return -ENOMEM;
 
-	if (hwpt->fault) {
-		rc = iommufd_fault_iopf_enable(idev);
-		if (rc)
-			goto out_free_handle;
-	}
-
 	handle->idev = idev;
 	if (pasid == IOMMU_NO_PASID)
 		rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
@@ -454,13 +469,10 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 		rc = iommu_attach_device_pasid(hwpt->domain, idev->dev, pasid,
 					       &handle->handle);
 	if (rc)
-		goto out_disable_iopf;
+		goto out_free_handle;
 
 	return 0;
 
-out_disable_iopf:
-	if (hwpt->fault)
-		iommufd_fault_iopf_disable(idev);
 out_free_handle:
 	kfree(handle);
 	return rc;
@@ -492,10 +504,7 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 	else
 		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
 
-	if (hwpt->fault) {
-		iommufd_auto_response_faults(hwpt, handle);
-		iommufd_fault_iopf_disable(idev);
-	}
+	iommufd_auto_response_faults(hwpt, handle);
 	kfree(handle);
 }
 
@@ -507,6 +516,9 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
+	if (!iommufd_hwpt_compatible_device(hwpt, idev))
+		return -EINVAL;
+
 	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
 	if (rc)
 		return rc;
@@ -517,12 +529,6 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	if (!handle)
 		return -ENOMEM;
 
-	if (hwpt->fault && !old->fault) {
-		rc = iommufd_fault_iopf_enable(idev);
-		if (rc)
-			goto out_free_handle;
-	}
-
 	handle->idev = idev;
 	if (pasid == IOMMU_NO_PASID)
 		rc = iommu_replace_group_handle(idev->igroup->group,
@@ -531,20 +537,13 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 		rc = iommu_replace_device_pasid(hwpt->domain, idev->dev,
 						pasid, &handle->handle);
 	if (rc)
-		goto out_disable_iopf;
+		goto out_free_handle;
 
-	if (old->fault) {
-		iommufd_auto_response_faults(hwpt, old_handle);
-		if (!hwpt->fault)
-			iommufd_fault_iopf_disable(idev);
-	}
+	iommufd_auto_response_faults(hwpt, old_handle);
 	kfree(old_handle);
 
 	return 0;
 
-out_disable_iopf:
-	if (hwpt->fault && !old->fault)
-		iommufd_fault_iopf_disable(idev);
 out_free_handle:
 	kfree(handle);
 	return rc;
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f39cf0797347..e373b9eec7f5 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -9,8 +9,6 @@
 #include <linux/iommufd.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/pci.h>
-#include <linux/pci-ats.h>
 #include <linux/poll.h>
 #include <uapi/linux/iommufd.h>
 
@@ -18,50 +16,6 @@
 #include "iommufd_private.h"
 
 /* IOMMUFD_OBJ_FAULT Functions */
-
-int iommufd_fault_iopf_enable(struct iommufd_device *idev)
-{
-	struct device *dev = idev->dev;
-	int ret;
-
-	/*
-	 * Once we turn on PCI/PRI support for VF, the response failure code
-	 * should not be forwarded to the hardware due to PRI being a shared
-	 * resource between PF and VFs. There is no coordination for this
-	 * shared capability. This waits for a vPRI reset to recover.
-	 */
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-
-		if (pdev->is_virtfn && pci_pri_supported(pdev))
-			return -EINVAL;
-	}
-
-	mutex_lock(&idev->iopf_lock);
-	/* Device iopf has already been on. */
-	if (++idev->iopf_enabled > 1) {
-		mutex_unlock(&idev->iopf_lock);
-		return 0;
-	}
-
-	ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
-	if (ret)
-		--idev->iopf_enabled;
-	mutex_unlock(&idev->iopf_lock);
-
-	return ret;
-}
-
-void iommufd_fault_iopf_disable(struct iommufd_device *idev)
-{
-	mutex_lock(&idev->iopf_lock);
-	if (!WARN_ON(idev->iopf_enabled == 0)) {
-		if (--idev->iopf_enabled == 0)
-			iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
-	}
-	mutex_unlock(&idev->iopf_lock);
-}
-
 void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 				  struct iommufd_attach_handle *handle)
 {
@@ -70,7 +24,7 @@ void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 	struct list_head free_list;
 	unsigned long index;
 
-	if (!fault)
+	if (!fault || !handle)
 		return;
 	INIT_LIST_HEAD(&free_list);
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 80e8c76d25f2..9ccc83341f32 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -425,9 +425,6 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
-	/* protect iopf_enabled counter */
-	struct mutex iopf_lock;
-	unsigned int iopf_enabled;
 };
 
 static inline struct iommufd_device *
@@ -506,9 +503,6 @@ iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
 int iommufd_fault_iopf_handler(struct iopf_group *group);
-
-int iommufd_fault_iopf_enable(struct iommufd_device *idev);
-void iommufd_fault_iopf_disable(struct iommufd_device *idev);
 void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 				  struct iommufd_attach_handle *handle);
 
-- 
2.43.0

