Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F131D6187
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374217; cv=none; b=dIm6qmov7JgR9VSrqqzIYot2JkA2oCkntt9McDBh8jY3aoPIHBnuBNk/v66vTAYmmZ92k9/BiTxXDBzfrhPezojnPByK5Fj8pAYaVzTqgYE3XbYPmUzCMPfum7rEUPiszlxONFMwImT9BW7rnIBnCgOdE4MZSXCLrubp5XCZVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374217; c=relaxed/simple;
	bh=BaH3dqvXJbqXyjZWTDN8VLvMk+7WNEdJEIOX4CmMhLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbbJv13Pth8JUhIJnTrfktCb04hO6UR3i9HAOb2dir2SKXVQh72TaihO/jhQXAoT3Sky0knmCJ4OhmKQDPdCAF/iDX4D6PA93f5I8zpdhoKEorohztxzboo2JQY2JhVXzWzOn5e10sPa413diQh9ZPhA8eKmL3+sPBjN6dZZkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRhjCH+8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRhjCH+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740374216; x=1771910216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BaH3dqvXJbqXyjZWTDN8VLvMk+7WNEdJEIOX4CmMhLE=;
  b=cRhjCH+8tq6fA0A9eo+qs1g7hMOckV/3GJ0iJ873mTNxmqhfFvbdYSkx
   4+i24kJw1aqyhi5eK//zHOQsvTCGnSip3ix3ejyuRYZvLK0g5U47Rxe/I
   NixNzN4tkiYwmlxZl0Grz2bhyNnnxrs0H1/IQYjAEJodNFZefupi8VBGi
   0mY6sfvsRyy0yAzEwgCJWGra5z687NzBfCQp02Xiz7oo+yaU045/YG7af
   s7OhcB8JMIcvejoU0F+ULl3MMZuTplaU6X0tWFL4j7qu4UZuKExxufOwC
   gi+YeS5IypvJTwo3FfoMg9Llu1Xtb7F4djqcS2xunRzlXnG+VCZ21jQG+
   g==;
X-CSE-ConnectionGUID: bRAhY3ndR8qmncl6evjFxw==
X-CSE-MsgGUID: XcrYso/USaaf34hyccXKbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="45024293"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45024293"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:16:56 -0800
X-CSE-ConnectionGUID: WFjRItSvSsenB6zQ0OKvhA==
X-CSE-MsgGUID: pYydqd1OTzuo8o7xpSla8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116143436"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 23 Feb 2025 21:16:52 -0800
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
Subject: [PATCH v2 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Mon, 24 Feb 2025 13:16:25 +0800
Message-ID: <20250224051627.2956304-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/iommufd/device.c          |   1 -
 drivers/iommu/iommufd/fault.c           | 111 ++++++------------------
 drivers/iommu/iommufd/iommufd_private.h |   3 -
 3 files changed, 28 insertions(+), 87 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dfd0898fb6c1..47e36456b438 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -215,7 +215,6 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
-	mutex_init(&idev->iopf_lock);
 
 	/*
 	 * If the caller fails after this success it must call
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index d9a937450e55..4776c632cff2 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -17,49 +17,6 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
-static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
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
-static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
-{
-	mutex_lock(&idev->iopf_lock);
-	if (!WARN_ON(idev->iopf_enabled == 0)) {
-		if (--idev->iopf_enabled == 0)
-			iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
-	}
-	mutex_unlock(&idev->iopf_lock);
-}
-
 static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_device *idev)
 {
@@ -82,20 +39,23 @@ static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 				    struct iommufd_device *idev)
 {
-	int ret;
-
 	if (!hwpt->fault)
 		return -EINVAL;
 
-	ret = iommufd_fault_iopf_enable(idev);
-	if (ret)
-		return ret;
+	/*
+	 * Once we turn on PCI/PRI support for VF, the response failure code
+	 * should not be forwarded to the hardware due to PRI being a shared
+	 * resource between PF and VFs. There is no coordination for this
+	 * shared capability. This waits for a vPRI reset to recover.
+	 */
+	if (dev_is_pci(idev->dev)) {
+		struct pci_dev *pdev = to_pci_dev(idev->dev);
 
-	ret = __fault_domain_attach_dev(hwpt, idev);
-	if (ret)
-		iommufd_fault_iopf_disable(idev);
+		if (pdev->is_virtfn && pci_pri_supported(pdev))
+			return -EINVAL;
+	}
 
-	return ret;
+	return __fault_domain_attach_dev(hwpt, idev);
 }
 
 static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
@@ -155,13 +115,12 @@ void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 	handle = iommufd_device_get_attach_handle(idev);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
 	iommufd_auto_response_faults(hwpt, handle);
-	iommufd_fault_iopf_disable(idev);
 	kfree(handle);
 }
 
-static int __fault_domain_replace_dev(struct iommufd_device *idev,
-				      struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_hw_pagetable *old)
+int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_hw_pagetable *old)
 {
 	struct iommufd_attach_handle *handle, *curr = NULL;
 	int ret;
@@ -170,6 +129,19 @@ static int __fault_domain_replace_dev(struct iommufd_device *idev,
 		curr = iommufd_device_get_attach_handle(idev);
 
 	if (hwpt->fault) {
+		/*
+		 * Once we turn on PCI/PRI support for VF, the response failure code
+		 * should not be forwarded to the hardware due to PRI being a shared
+		 * resource between PF and VFs. There is no coordination for this
+		 * shared capability. This waits for a vPRI reset to recover.
+		 */
+		if (dev_is_pci(idev->dev)) {
+			struct pci_dev *pdev = to_pci_dev(idev->dev);
+
+			if (pdev->is_virtfn && pci_pri_supported(pdev))
+				return -EINVAL;
+		}
+
 		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 		if (!handle)
 			return -ENOMEM;
@@ -190,33 +162,6 @@ static int __fault_domain_replace_dev(struct iommufd_device *idev,
 	return ret;
 }
 
-int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
-				     struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_hw_pagetable *old)
-{
-	bool iopf_off = !hwpt->fault && old->fault;
-	bool iopf_on = hwpt->fault && !old->fault;
-	int ret;
-
-	if (iopf_on) {
-		ret = iommufd_fault_iopf_enable(idev);
-		if (ret)
-			return ret;
-	}
-
-	ret = __fault_domain_replace_dev(idev, hwpt, old);
-	if (ret) {
-		if (iopf_on)
-			iommufd_fault_iopf_disable(idev);
-		return ret;
-	}
-
-	if (iopf_off)
-		iommufd_fault_iopf_disable(idev);
-
-	return 0;
-}
-
 void iommufd_fault_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0b1bafc7fd99..0eb3779db156 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -399,9 +399,6 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
-	/* protect iopf_enabled counter */
-	struct mutex iopf_lock;
-	unsigned int iopf_enabled;
 };
 
 static inline struct iommufd_device *
-- 
2.43.0

