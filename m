Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA74221574
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478476; cv=none; b=PKbfeT+2A90CfE5dPdL2GzET51eS/RZwvj1it2m456U39pw6VxdLbrCeAemrAiwF5CN3G/9QFVTDf28Q73Z/l9enSSASKYc0Hd5kc43VF+Pb9R6bUkeq7Mgv4Df5K+lm71ByZ9MNEETQd4GMKGjgNhOnGLrPwFpmhvb++ZdDCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478476; c=relaxed/simple;
	bh=oKycaAVaShSydjYPr5wbESaDU7bHIEfKsTnDdYfUdqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIdzMYZpM+GPZ20EHXHpUbIiM80F4namRtnDI4HSzk4wDJSGU9/Bo8Vkbu4/aSGSLvhEs32rBISpv8OxZshVHIX0D6Er6u48o6/zS5IFMv9yDlrr+Ph9h8Ujz0Mu1iBAp1okCBaHGZAn2DMIQ6EB9vK5rOgZgyB/xPno2eh7BxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBGysbBa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBGysbBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478474; x=1774014474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKycaAVaShSydjYPr5wbESaDU7bHIEfKsTnDdYfUdqI=;
  b=iBGysbBaQQ1zeJqeNm1dqiEXlfp0MkCIY6OoEK7P09Vo2tSagGSkh7re
   ODPJHNahSzPBcXD5VN+2Vuq9kcjfkMmqXhMT3KiW6aSFSPr8OTL3Uho82
   Kn/ttm+BbOviZDZJu8bq+3PXV7Ue5hBJk04JH0xS6LfEoEsFtCTBZ96eC
   YAEr0PsPe9har/kxKTEgQPjlfShvVxIJmt2kFcHyaYme0iydDQllzVqeF
   7GHB03pLrdaImNb2pryACz8opcltbABfnmChgW+IICvmf3/WbCTnyP5gf
   8yOAudVCwcUXAdIsXDDqYHY/8q8Ac5LQzrH89P5srmZrNUqA3/1MJ9lpH
   Q==;
X-CSE-ConnectionGUID: R3Wm+2UVTXyUWCcOmPpwRg==
X-CSE-MsgGUID: YrTgQjAUT0SKTewyBMPlYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063068"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063068"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:48 -0700
X-CSE-ConnectionGUID: wWkXba1bRRCoS0iTDxKxhg==
X-CSE-MsgGUID: jBQfylu6QSqji5Qu56+4FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319176"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:48 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 11/18] iommufd: Support pasid attach/replace
Date: Thu, 20 Mar 2025 06:47:37 -0700
Message-Id: <20250320134744.5777-12-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320134744.5777-1-yi.l.liu@intel.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends the below APIs to support PASID. Device drivers to manage pasid
attach/replace/detach.

    int iommufd_device_attach(struct iommufd_device *idev,
			      ioasid_t pasid, u32 *pt_id);
    int iommufd_device_replace(struct iommufd_device *idev,
			       ioasid_t pasid, u32 *pt_id);
    void iommufd_device_detach(struct iommufd_device *idev,
			       ioasid_t pasid);

The pasid operations share underlying attach/replace/detach infrastructure
with the device operations, but still have some different implications:

 - no reserved region per pasid otherwise SVA architecture is already
   broken (CPU address space doesn't count device reserved regions);

 - accordingly no sw_msi trick;

Cache coherency enforcement is still applied to pasid operations since
it is about memory accesses post page table walking (no matter the walk
is per RID or per PASID).

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v9 -> v10: minor tweaks per rebase
---
 drivers/iommu/iommufd/device.c   | 57 ++++++++++++++++++++------------
 drivers/iommu/iommufd/selftest.c |  8 ++---
 drivers/vfio/iommufd.c           | 10 +++---
 include/linux/iommufd.h          |  9 +++--
 4 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6d003f9f0668..17c424d9a355 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -543,9 +543,12 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	handle->idev = idev;
-	WARN_ON(pasid != IOMMU_NO_PASID);
-	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
-				       &handle->handle);
+	if (pasid == IOMMU_NO_PASID)
+		rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
+					       &handle->handle);
+	else
+		rc = iommu_attach_device_pasid(hwpt->domain, idev->dev, pasid,
+					       &handle->handle);
 	if (rc)
 		goto out_disable_iopf;
 
@@ -579,10 +582,12 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_attach_handle *handle;
 
-	WARN_ON(pasid != IOMMU_NO_PASID);
+	if (pasid == IOMMU_NO_PASID)
+		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	else
+		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
 
 	handle = iommufd_device_get_attach_handle(idev, pasid);
-	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
 	if (hwpt->fault) {
 		iommufd_auto_response_faults(hwpt, handle);
 		iommufd_fault_iopf_disable(idev);
@@ -598,8 +603,6 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
-	WARN_ON(pasid != IOMMU_NO_PASID);
-
 	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
 	if (rc)
 		return rc;
@@ -617,8 +620,12 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	}
 
 	handle->idev = idev;
-	rc = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
-					&handle->handle);
+	if (pasid == IOMMU_NO_PASID)
+		rc = iommu_replace_group_handle(idev->igroup->group,
+						hwpt->domain, &handle->handle);
+	else
+		rc = iommu_replace_device_pasid(hwpt->domain, idev->dev,
+						pasid, &handle->handle);
 	if (rc)
 		goto out_disable_iopf;
 
@@ -1026,22 +1033,25 @@ static int iommufd_device_change_pt(struct iommufd_device *idev,
 }
 
 /**
- * iommufd_device_attach - Connect a device to an iommu_domain
+ * iommufd_device_attach - Connect a device/pasid to an iommu_domain
  * @idev: device to attach
+ * @pasid: pasid to attach
  * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
  *         Output the IOMMUFD_OBJ_HWPT_PAGING ID
  *
- * This connects the device to an iommu_domain, either automatically or manually
- * selected. Once this completes the device could do DMA.
+ * This connects the device/pasid to an iommu_domain, either automatically
+ * or manually selected. Once this completes the device could do DMA with
+ * @pasid. @pasid is IOMMU_NO_PASID if this attach is for no pasid usage.
  *
  * The caller should return the resulting pt_id back to userspace.
  * This function is undone by calling iommufd_device_detach().
  */
-int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
+int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,
+			  u32 *pt_id)
 {
 	int rc;
 
-	rc = iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
+	rc = iommufd_device_change_pt(idev, pasid, pt_id,
 				      &iommufd_device_do_attach);
 	if (rc)
 		return rc;
@@ -1056,8 +1066,9 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, "IOMMUFD");
 
 /**
- * iommufd_device_replace - Change the device's iommu_domain
+ * iommufd_device_replace - Change the device/pasid's iommu_domain
  * @idev: device to change
+ * @pasid: pasid to change
  * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
  *         Output the IOMMUFD_OBJ_HWPT_PAGING ID
  *
@@ -1068,27 +1079,31 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, "IOMMUFD");
  *
  * If it fails then no change is made to the attachment. The iommu driver may
  * implement this so there is no disruption in translation. This can only be
- * called if iommufd_device_attach() has already succeeded.
+ * called if iommufd_device_attach() has already succeeded. @pasid is
+ * IOMMU_NO_PASID for no pasid usage.
  */
-int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
+int iommufd_device_replace(struct iommufd_device *idev, ioasid_t pasid,
+			   u32 *pt_id)
 {
-	return iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
+	return iommufd_device_change_pt(idev, pasid, pt_id,
 					&iommufd_device_do_replace);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, "IOMMUFD");
 
 /**
- * iommufd_device_detach - Disconnect a device to an iommu_domain
+ * iommufd_device_detach - Disconnect a device/device to an iommu_domain
  * @idev: device to detach
+ * @pasid: pasid to detach
  *
  * Undo iommufd_device_attach(). This disconnects the idev from the previously
  * attached pt_id. The device returns back to a blocked DMA translation.
+ * @pasid is IOMMU_NO_PASID for no pasid usage.
  */
-void iommufd_device_detach(struct iommufd_device *idev)
+void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
-	hwpt = iommufd_hw_pagetable_detach(idev, IOMMU_NO_PASID);
+	hwpt = iommufd_hw_pagetable_detach(idev, pasid);
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d55dde28e9bc..0b3f5cbf242b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -945,7 +945,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	}
 	sobj->idev.idev = idev;
 
-	rc = iommufd_device_attach(idev, &pt_id);
+	rc = iommufd_device_attach(idev, IOMMU_NO_PASID, &pt_id);
 	if (rc)
 		goto out_unbind;
 
@@ -960,7 +960,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return 0;
 
 out_detach:
-	iommufd_device_detach(idev);
+	iommufd_device_detach(idev, IOMMU_NO_PASID);
 out_unbind:
 	iommufd_device_unbind(idev);
 out_mdev:
@@ -994,7 +994,7 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 		goto out_dev_obj;
 	}
 
-	rc = iommufd_device_replace(sobj->idev.idev, &pt_id);
+	rc = iommufd_device_replace(sobj->idev.idev, IOMMU_NO_PASID, &pt_id);
 	if (rc)
 		goto out_dev_obj;
 
@@ -1655,7 +1655,7 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 
 	switch (sobj->type) {
 	case TYPE_IDEV:
-		iommufd_device_detach(sobj->idev.idev);
+		iommufd_device_detach(sobj->idev.idev, IOMMU_NO_PASID);
 		iommufd_device_unbind(sobj->idev.idev);
 		mock_dev_destroy(sobj->idev.mock_dev);
 		break;
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 516294fd901b..37e1efa2c7bf 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -128,7 +128,7 @@ void vfio_iommufd_physical_unbind(struct vfio_device *vdev)
 	lockdep_assert_held(&vdev->dev_set->lock);
 
 	if (vdev->iommufd_attached) {
-		iommufd_device_detach(vdev->iommufd_device);
+		iommufd_device_detach(vdev->iommufd_device, IOMMU_NO_PASID);
 		vdev->iommufd_attached = false;
 	}
 	iommufd_device_unbind(vdev->iommufd_device);
@@ -146,9 +146,11 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 		return -EINVAL;
 
 	if (vdev->iommufd_attached)
-		rc = iommufd_device_replace(vdev->iommufd_device, pt_id);
+		rc = iommufd_device_replace(vdev->iommufd_device,
+					    IOMMU_NO_PASID, pt_id);
 	else
-		rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
+		rc = iommufd_device_attach(vdev->iommufd_device,
+					   IOMMU_NO_PASID, pt_id);
 	if (rc)
 		return rc;
 	vdev->iommufd_attached = true;
@@ -163,7 +165,7 @@ void vfio_iommufd_physical_detach_ioas(struct vfio_device *vdev)
 	if (WARN_ON(!vdev->iommufd_device) || !vdev->iommufd_attached)
 		return;
 
-	iommufd_device_detach(vdev->iommufd_device);
+	iommufd_device_detach(vdev->iommufd_device, IOMMU_NO_PASID);
 	vdev->iommufd_attached = false;
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_physical_detach_ioas);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 60eff9272551..34b6e6ca4bfa 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/iommu.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -54,9 +55,11 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
 
-int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id);
-int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id);
-void iommufd_device_detach(struct iommufd_device *idev);
+int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,
+			  u32 *pt_id);
+int iommufd_device_replace(struct iommufd_device *idev, ioasid_t pasid,
+			   u32 *pt_id);
+void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid);
 
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
-- 
2.34.1

