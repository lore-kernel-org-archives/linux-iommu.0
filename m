Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675D215780
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570042; cv=none; b=itdDgZy21WPkveSwRwSiu2bO9i2uwj4llbO12daaLbPe4HM1vgryEUQM1ia6XS7u6/QRj/wvma7IFtwmzoObPNYDQ8CWAeG9aybvrJRbbZdX3deRn6SF3udgmZR81qY+84os0HpKgV+JQFJz7TiOi8zg0loYXHxBcHZJEhFNDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570042; c=relaxed/simple;
	bh=3PkkXD8i6gsoFK48VjfMKN/0OsdAC0iS/hZifrxwFJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MAi5vuHy45fskypzlLWwoSPn3tX8BtwIfSQkUlE+5zamYUpFYb6X5TNdwOcPihwPX9AGSdKq5o8Oi+341ZL7r0r9HwLPnjTVI3n9/2jrmXtjFF+1xp/ofjByX5gkajqhitcBJcxuSrGTwdhYjA9FPMNBsEYSYGVKBZh/Jwe2jCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvtnfiqM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvtnfiqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570040; x=1772106040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3PkkXD8i6gsoFK48VjfMKN/0OsdAC0iS/hZifrxwFJw=;
  b=AvtnfiqMyTFQ2qmRkO/EtgmXjeuToUM4bKtz83X9oSi2r6IaYjvogA4Z
   nwrkc5F0f0WbJ5dwHhgmR3THo1HnxVPBxTG5/1jnF7bDzmrfjxT1C789q
   X9OnX4EOz2D9n4Q/LVkdO940LTRYPbM4m+nOj9cCHPka1VydAitPUoDee
   Wmj1ERbknrtjxQOKmDmiVxaKZVrIvrd2CeVO/XkZ14rrxPahHOSyR54Mz
   8nnSUw7r9gq2zpFQhh5+MmN1GZ3tVc6NNYyLyw6dkv9e1ojQNzewbbs80
   LluZvW75IQR8uiHwwrNzZHf23JzjDtxNXyMfK+iFN+a6KDa54D4YgeQp8
   g==;
X-CSE-ConnectionGUID: 5FlPvJP0Tke4n4kUSGIy/A==
X-CSE-MsgGUID: FRpeZ7GnQ328hdKV9RE2ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827094"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827094"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:35 -0800
X-CSE-ConnectionGUID: fi2Q7X2TTyqiiKNijLc9PA==
X-CSE-MsgGUID: 1lSdFaMzRO2saKGDmox0sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171592"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 26 Feb 2025 03:40:36 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v8 06/12] iommufd: Support pasid attach/replace
Date: Wed, 26 Feb 2025 03:40:26 -0800
Message-Id: <20250226114032.4591-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226114032.4591-1-yi.l.liu@intel.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces three APIs for device drivers to manage pasid attach/
replace/detach.

    int iommufd_device_pasid_attach(struct iommufd_device *idev,
				    ioasid_t pasid, u32 *pt_id);
    int iommufd_device_pasid_replace(struct iommufd_device *idev,
				     ioasid_t pasid, u32 *pt_id);
    void iommufd_device_pasid_detach(struct iommufd_device *idev,
				     ioasid_t pasid);

The pasid operations share underlying attach/replace/detach infrastructure
with the device operations, but still have some different implications:

 - no reserved region per pasid otherwise SVA architecture is already
   broken (CPU address space doesn't count device reserved regions);

 - accordingly no sw_msi trick;

Cache coherency enforcement is still applied to pasid operations since
it is about memory accesses post page table walking (no matter the walk
is per RID or per PASID).

Since the attach is per PASID, this introduces a pasid_hwpts xarray to
track the per-pasid attach data.

AMD requires using PASID-compatible domains for PASIDs, hence the hwpts
directing the PASID path requires to flagged with IOMMU_HWPT_ALLOC_PASID.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/device.c          |  64 ++++++----
 drivers/iommu/iommufd/iommufd_private.h |  26 ++++
 drivers/iommu/iommufd/pasid.c           | 155 ++++++++++++++++++++++++
 include/linux/iommufd.h                 |   7 ++
 5 files changed, 227 insertions(+), 26 deletions(-)
 create mode 100644 drivers/iommu/iommufd/pasid.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cb784da6cddc..a64a67b502ae 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -7,6 +7,7 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
+	pasid.o \
 	vfio_compat.o \
 	viommu.o
 
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 72f6195e32f2..30dd2f79491a 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -136,6 +136,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	WARN_ON(!xa_empty(&idev->pasid_hwpts));
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
@@ -217,6 +218,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	idev->igroup = igroup;
 	mutex_init(&idev->iopf_lock);
 
+	xa_init(&idev->pasid_hwpts);
+
 	/*
 	 * If the caller fails after this success it must call
 	 * iommufd_unbind_device() which is safe since we hold this refcount.
@@ -354,15 +357,18 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
-static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_device *idev,
-				      ioasid_t pasid)
+int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
+			       struct iommufd_device *idev,
+			       ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 	int rc;
 
 	lockdep_assert_held(&idev->igroup->lock);
 
+	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
+		return -EINVAL;
+
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
@@ -374,9 +380,12 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	handle->idev = idev;
-	WARN_ON(pasid != IOMMU_NO_PASID);
-	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
-				       &handle->handle);
+	if (pasid == IOMMU_NO_PASID)
+		rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
+					       &handle->handle);
+	else
+		rc = iommu_attach_device_pasid_handle(hwpt->domain, idev->dev,
+						      pasid, &handle->handle);
 	if (rc)
 		goto out_disable_iopf;
 
@@ -404,16 +413,19 @@ iommufd_device_get_attach_handle(struct iommufd_device *idev, ioasid_t pasid)
 	return to_iommufd_handle(handle);
 }
 
-static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
-				       struct iommufd_device *idev,
-				       ioasid_t pasid)
+void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
+				struct iommufd_device *idev,
+				ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 
-	WARN_ON(pasid != IOMMU_NO_PASID);
-
 	handle = iommufd_device_get_attach_handle(idev, pasid);
-	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+
+	if (pasid == IOMMU_NO_PASID)
+		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	else
+		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
+
 	if (hwpt->fault) {
 		iommufd_auto_response_faults(hwpt, handle);
 		iommufd_fault_iopf_disable(idev);
@@ -421,15 +433,16 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 	kfree(handle);
 }
 
-static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
-				       ioasid_t pasid,
-				       struct iommufd_hw_pagetable *hwpt,
-				       struct iommufd_hw_pagetable *old)
+int iommufd_hwpt_replace_device(struct iommufd_device *idev,
+				ioasid_t pasid,
+				struct iommufd_hw_pagetable *hwpt,
+				struct iommufd_hw_pagetable *old)
 {
 	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
-	WARN_ON(pasid != IOMMU_NO_PASID);
+	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
+		return -EINVAL;
 
 	old_handle = iommufd_device_get_attach_handle(idev, pasid);
 
@@ -444,8 +457,12 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	}
 
 	handle->idev = idev;
-	rc = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
-					&handle->handle);
+	if (pasid == IOMMU_NO_PASID)
+		rc = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
+						&handle->handle);
+	else
+		rc = iommu_replace_device_pasid_handle(hwpt->domain, idev->dev,
+						       pasid, &handle->handle);
 	if (rc)
 		goto out_disable_iopf;
 
@@ -649,10 +666,6 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	return ERR_PTR(rc);
 }
 
-typedef struct iommufd_hw_pagetable *(*attach_fn)(
-	struct iommufd_device *idev, ioasid_t pasid,
-	struct iommufd_hw_pagetable *hwpt);
-
 /*
  * When automatically managing the domains we search for a compatible domain in
  * the iopt and if one is found use it, otherwise create a new domain.
@@ -736,9 +749,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 	return destroy_hwpt;
 }
 
-static int iommufd_device_change_pt(struct iommufd_device *idev,
-				    ioasid_t pasid,
-				    u32 *pt_id, attach_fn do_attach)
+int iommufd_device_change_pt(struct iommufd_device *idev, ioasid_t pasid,
+			     u32 *pt_id, attach_fn do_attach)
 {
 	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_object *pt_obj;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index cfb6a0767a30..d533171d28de 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -400,6 +400,7 @@ struct iommufd_device {
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
+	struct xarray pasid_hwpts;
 	bool enforce_cache_coherency;
 	/* protect iopf_enabled counter */
 	struct mutex iopf_lock;
@@ -417,6 +418,31 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
+typedef struct iommufd_hw_pagetable *(*attach_fn)(
+			struct iommufd_device *idev, ioasid_t pasid,
+			struct iommufd_hw_pagetable *hwpt);
+
+int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
+			       struct iommufd_device *idev,
+			       ioasid_t pasid);
+void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
+				struct iommufd_device *idev,
+				ioasid_t pasid);
+int iommufd_hwpt_replace_device(struct iommufd_device *idev,
+				ioasid_t pasid,
+				struct iommufd_hw_pagetable *hwpt,
+				struct iommufd_hw_pagetable *old);
+
+int iommufd_device_change_pt(struct iommufd_device *idev, ioasid_t pasid,
+			     u32 *pt_id, attach_fn do_attach);
+
+struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_attach(struct iommufd_device *idev, ioasid_t pasid,
+			       struct iommufd_hw_pagetable *hwpt);
+struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_replace(struct iommufd_device *idev, ioasid_t pasid,
+				struct iommufd_hw_pagetable *hwpt);
+
 struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/pasid.c b/drivers/iommu/iommufd/pasid.c
new file mode 100644
index 000000000000..4450c101e557
--- /dev/null
+++ b/drivers/iommu/iommufd/pasid.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, Intel Corporation
+ */
+#include <linux/iommufd.h>
+#include <linux/iommu.h>
+#include "../iommu-priv.h"
+
+#include "iommufd_private.h"
+
+struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_attach(struct iommufd_device *idev, ioasid_t pasid,
+			       struct iommufd_hw_pagetable *hwpt)
+{
+	void *curr;
+	int rc;
+
+	mutex_lock(&idev->igroup->lock);
+	curr = xa_cmpxchg(&idev->pasid_hwpts, pasid, NULL, hwpt, GFP_KERNEL);
+	if (curr) {
+		if (curr == hwpt)
+			rc = 0;
+		else
+			rc = xa_err(curr) ? : -EINVAL;
+		goto out_unlock;
+	}
+
+	rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
+	if (rc)
+		goto out_erase;
+
+	mutex_unlock(&idev->igroup->lock);
+	refcount_inc(&hwpt->obj.users);
+	return NULL;
+
+out_erase:
+	xa_erase(&idev->pasid_hwpts, pasid);
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	return rc ? ERR_PTR(rc) : NULL;
+}
+
+struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_replace(struct iommufd_device *idev, ioasid_t pasid,
+				struct iommufd_hw_pagetable *hwpt)
+{
+	void *curr;
+	int rc;
+
+	mutex_lock(&idev->igroup->lock);
+	curr = xa_store(&idev->pasid_hwpts, pasid, hwpt, GFP_KERNEL);
+	rc = xa_err(curr);
+	if (rc)
+		goto out_unlock;
+
+	if (curr == hwpt)
+		goto out_unlock;
+
+	/* Not replace case */
+	if (!curr) {
+		xa_erase(&idev->pasid_hwpts, pasid);
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
+	/*
+	 * After replacement, the reference on the old hwpt is retained
+	 * in this thread as caller would free it.
+	 */
+	rc = iommufd_hwpt_replace_device(idev, pasid, hwpt, curr);
+	if (rc) {
+		WARN_ON(xa_err(xa_store(&idev->pasid_hwpts, pasid,
+					curr, GFP_KERNEL)));
+		goto out_unlock;
+	}
+
+	mutex_unlock(&idev->igroup->lock);
+	refcount_inc(&hwpt->obj.users);
+	/* Caller must destroy old_hwpt */
+	return curr;
+
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	return rc ? ERR_PTR(rc) : NULL;
+}
+
+/**
+ * iommufd_device_pasid_attach - Connect a {device, pasid} to an iommu_domain
+ * @idev: device to attach
+ * @pasid: pasid to attach
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This connects a pasid of the device to an iommu_domain. Once this
+ * completes the device could do DMA with the pasid.
+ *
+ * This function is undone by calling iommufd_device_detach_pasid().
+ *
+ * Return 0 for success, otherwise errno.
+ */
+int iommufd_device_pasid_attach(struct iommufd_device *idev,
+				ioasid_t pasid, u32 *pt_id)
+{
+	return iommufd_device_change_pt(idev, pasid, pt_id,
+					&iommufd_device_pasid_do_attach);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_pasid_attach, "IOMMUFD");
+
+/**
+ * iommufd_device_pasid_replace - Change the {device, pasid}'s iommu_domain
+ * @idev: device to change
+ * @pasid: pasid to change
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This is the same as
+ *   iommufd_device_pasid_detach();
+ *   iommufd_device_pasid_attach();
+ *
+ * If it fails then no change is made to the attachment. The iommu driver may
+ * implement this so there is no disruption in translation. This can only be
+ * called if iommufd_device_pasid_attach() has already succeeded.
+ *
+ * Return 0 for success, otherwise errno.
+ */
+int iommufd_device_pasid_replace(struct iommufd_device *idev,
+				 ioasid_t pasid, u32 *pt_id)
+{
+	return iommufd_device_change_pt(idev, pasid, pt_id,
+					&iommufd_device_pasid_do_replace);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_pasid_replace, "IOMMUFD");
+
+/**
+ * iommufd_device_pasid_detach - Disconnect a {device, pasid} to an iommu_domain
+ * @idev: device to detach
+ * @pasid: pasid to detach
+ *
+ * Undo iommufd_device_pasid_attach(). This disconnects the idev/pasid from
+ * the previously attached pt_id.
+ */
+void iommufd_device_pasid_detach(struct iommufd_device *idev, ioasid_t pasid)
+{
+	struct iommufd_hw_pagetable *hwpt;
+
+	mutex_lock(&idev->igroup->lock);
+	hwpt = xa_erase(&idev->pasid_hwpts, pasid);
+	if (WARN_ON(!hwpt)) {
+		mutex_unlock(&idev->igroup->lock);
+		return;
+	}
+	iommufd_hwpt_detach_device(hwpt, idev, pasid);
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_hw_pagetable_put(idev->ictx, hwpt);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_pasid_detach, "IOMMUFD");
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 11110c749200..af7e5a4bfcf2 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/iommu.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -56,6 +57,12 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id);
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id);
 void iommufd_device_detach(struct iommufd_device *idev);
 
+int iommufd_device_pasid_attach(struct iommufd_device *idev,
+				ioasid_t pasid, u32 *pt_id);
+int iommufd_device_pasid_replace(struct iommufd_device *idev,
+				 ioasid_t pasid, u32 *pt_id);
+void iommufd_device_pasid_detach(struct iommufd_device *idev, ioasid_t pasid);
+
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
 
-- 
2.34.1

