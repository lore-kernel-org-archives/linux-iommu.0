Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09C1FBEA3
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843205; cv=none; b=h5oSJ5IzSUisFQ69hmMy1tRTO12DNew/upaV5j1tO0EYUo4rMFnvLhZ8h6KHis3SKpacbiTUpIksqHHDCYGeLgB8e2CO4+hCJwkKUnUClkazldkZbuXTEgbFgIz9cBmfEQDVaAAisnLN+8w+kExO5c9Gxre5TX3lZN5JVohXZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843205; c=relaxed/simple;
	bh=V7ywk2YTMAug3Uyr00XKpk9JyG+QyJ6kX584FYr4XQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9tjrlTE/ylWFg07tpcHihH0GOSDqfeVdplssboI5Gnc68wjM1jE+jMfDRfEDtmwqklS2ydnFyU8Kt0d7KJPtenznqVnr+kpkd2Mgo5PVjPJB9pcpxmOquqZ3+L7a6EmtiLHoY+CeNJ9To+6bjaO230d9EJ2t0nYKRNAjMJB4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esn1So3X; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esn1So3X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741843204; x=1773379204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V7ywk2YTMAug3Uyr00XKpk9JyG+QyJ6kX584FYr4XQY=;
  b=esn1So3X8Ps6UJtTyGhjYVAHo7R+az2g6cWoz11V5JdtBy0OZzVJdoy5
   f5mWaTJ+hEBC+uyTPMlNpchug7A1yxtbq2X23QGd1fOiOe8gxPeGm8TEW
   wY+/3if26yaqv5Yax+IIlaGQhQJOMWXgC/1VVbiGRuL9b29qXlQQu3x13
   zC8BQ13O6Z3QyjjP0vbfluPVg1UyxJGGW1Io7YL4ZEJJ7wi1IBvYHjjDL
   ldmrxQHNwIBaZGQNqYGwmBnMkUfbK3rAAvdOv9lFKMSSfjOlIZRx40DiX
   A7/pAkLJRm/yZa8y8gvDhcmQrhHwszQmdnfrxwiKb7C2n5Ul7JT5umFNE
   A==;
X-CSE-ConnectionGUID: KqYUOesyRAGir4ahOJ6bSg==
X-CSE-MsgGUID: kqAHjejMTM2H4cyloG/G6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54323732"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="54323732"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 22:20:03 -0700
X-CSE-ConnectionGUID: iO0mLwbXR6yPpMhfJNyFHw==
X-CSE-MsgGUID: rhkGRUhPTqqJOsSdHqlM9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151807170"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 22:20:00 -0700
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
Subject: [PATCH v4 7/8] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Thu, 13 Mar 2025 13:19:52 +0800
Message-ID: <20250313051953.4064532-8-baolu.lu@linux.intel.com>
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

The iopf enablement has been moved to the iommu drivers. It is unnecessary
for iommufd to handle iopf enablement. Remove the iopf enablement logic to
avoid duplication.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommufd/device.c          | 64 +++++++++++++------------
 drivers/iommu/iommufd/fault.c           | 45 -----------------
 drivers/iommu/iommufd/iommufd_private.h |  5 --
 3 files changed, 33 insertions(+), 81 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4e107f69f951..9c488680871f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -6,6 +6,8 @@
 #include <linux/slab.h>
 #include <uapi/linux/iommufd.h>
 #include <linux/msi.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
 
 #include "../iommu-priv.h"
 #include "io_pagetable.h"
@@ -216,7 +218,6 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
-	mutex_init(&idev->iopf_lock);
 
 	/*
 	 * If the caller fails after this success it must call
@@ -471,6 +472,25 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
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
 				      struct iommufd_device *idev)
 {
@@ -479,30 +499,22 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 
 	lockdep_assert_held(&idev->igroup->lock);
 
+	if (!iommufd_hwpt_compatible_device(hwpt, idev))
+		return -EINVAL;
+
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
 
-	if (hwpt->fault) {
-		rc = iommufd_fault_iopf_enable(idev);
-		if (rc)
-			goto out_free_handle;
-	}
-
 	handle->idev = idev;
 	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
 				       &handle->handle);
-	if (rc)
-		goto out_disable_iopf;
+	if (rc) {
+		kfree(handle);
+		return rc;
+	}
 
 	return 0;
-
-out_disable_iopf:
-	if (hwpt->fault)
-		iommufd_fault_iopf_disable(idev);
-out_free_handle:
-	kfree(handle);
-	return rc;
 }
 
 static struct iommufd_attach_handle *
@@ -526,10 +538,8 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 
 	handle = iommufd_device_get_attach_handle(idev);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
-	if (hwpt->fault) {
+	if (hwpt->fault)
 		iommufd_auto_response_faults(hwpt, handle);
-		iommufd_fault_iopf_disable(idev);
-	}
 	kfree(handle);
 }
 
@@ -541,34 +551,26 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 		iommufd_device_get_attach_handle(idev);
 	int rc;
 
+	if (!iommufd_hwpt_compatible_device(hwpt, idev))
+		return -EINVAL;
+
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
 
-	if (hwpt->fault && !old->fault) {
-		rc = iommufd_fault_iopf_enable(idev);
-		if (rc)
-			goto out_free_handle;
-	}
-
 	handle->idev = idev;
 	rc = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
 					&handle->handle);
 	if (rc)
-		goto out_disable_iopf;
+		goto out_free_handle;
 
 	if (old->fault) {
 		iommufd_auto_response_faults(hwpt, old_handle);
-		if (!hwpt->fault)
-			iommufd_fault_iopf_disable(idev);
 	}
 	kfree(old_handle);
 
 	return 0;
 
-out_disable_iopf:
-	if (hwpt->fault && !old->fault)
-		iommufd_fault_iopf_disable(idev);
 out_free_handle:
 	kfree(handle);
 	return rc;
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index c48d72c9668c..46f17eb20ee2 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -9,57 +9,12 @@
 #include <linux/iommufd.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/pci.h>
-#include <linux/pci-ats.h>
 #include <linux/poll.h>
 #include <uapi/linux/iommufd.h>
 
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
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
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 246297452a44..dcab49f79e7a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -420,9 +420,6 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
-	/* protect iopf_enabled counter */
-	struct mutex iopf_lock;
-	unsigned int iopf_enabled;
 };
 
 static inline struct iommufd_device *
@@ -517,8 +514,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
 int iommufd_fault_iopf_handler(struct iopf_group *group);
 
-int iommufd_fault_iopf_enable(struct iommufd_device *idev);
-void iommufd_fault_iopf_disable(struct iommufd_device *idev);
 void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 				  struct iommufd_attach_handle *handle);
 
-- 
2.43.0

