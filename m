Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D4225A3D
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614875; cv=none; b=DRQO8tH6EF/yt+LOpApd/i40dn9CbipnJx4RiCSQM6NbKJKAgX14qGboshrRA0KL8p4cQoqcvAtu7AU/veil9/E2YcRZCOqutHXFB50YJOzr7DWTzi1ddP+EZ2u7h1soyf4X6HJdYTtq3ddau3MTnKsByTGEZL93nuQ/LKwDRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614875; c=relaxed/simple;
	bh=EizXVbgVc8a185omJDzSUC7adwzfbS4lgDqTI9x9rUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R30H/Q05sS/hOBK/a+elqysQ8JnmU5gLp8gBBUuk7GtXuQOsTS3jzy8gqEeTJZj9KbTsrKnkJn8pjPqJ1IZTHyWI62cOU4TCyFVyfb3npgCH1zEMCwO5BTSP8weY4Sde7cVvBS+a630hqVBUjGi6IxkArIkj5ECpOeFTNkc9y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBF4S6Wy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBF4S6Wy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614874; x=1766150874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EizXVbgVc8a185omJDzSUC7adwzfbS4lgDqTI9x9rUY=;
  b=MBF4S6WyUSH+ceqq0Cbl8BZpqQP2pgP+F3nQ8KJISFBQmVjyAKSfj1la
   Uj754uei0vEdvHv9WP59YNgQd6UOEzdPDowm24yRxkVNYA5CmABUSZDpn
   bpyZGufAWLqH1Dfrzs62KBYGsY0KgsjOZ0ixTr9Wry4QOATLd29VoB9z2
   y7eL2b8LC/IjObGktocJVUzCZtorUvdRhd5uUVF32jn+zmu5nNkTjZ1nX
   IC0Il110VFSjPekZp37dA942ZJ7XBDaRE/XVI1s2XuJnwBN+jNwavpTCu
   bU7RH7SJEZfvPUHYcVz4v2nwgpPX1NzEXY9hcGjUGvfaegOaw96j8livd
   A==;
X-CSE-ConnectionGUID: p9g5W3yeRK2DpokNRfM+Ew==
X-CSE-MsgGUID: 4I7x4vMhSLetO/gU85n2OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542286"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542286"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:51 -0800
X-CSE-ConnectionGUID: lGcLkJ4oRn2nYGqqJBBoBw==
X-CSE-MsgGUID: CPGQ1yl/Qn6imfjGw3iE6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177323"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:50 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 07/14] iommufd: Support pasid attach/replace
Date: Thu, 19 Dec 2024 05:27:39 -0800
Message-Id: <20241219132746.16193-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
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

pasid operations have different implications when comparing to device
operations:

 - No connection to iommufd_group since pasid is a device capability
   and can be enabled only in singleton group;

 - no reserved region per pasid otherwise SVA architecture is already
   broken (CPU address space doesn't count device reserved regions);

 - accordingly no sw_msi trick;

 - immediated_attach is not supported, expecting that arm-smmu driver
   will already remove that requirement before supporting this pasid
   operation. This avoids unnecessary change in iommufd_hw_pagetable_alloc()
   to carry the pasid from device.c.

With above differences, this puts all pasid related logics into a new
pasid.c file.

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
 drivers/iommu/iommufd/device.c          |  30 +++--
 drivers/iommu/iommufd/fault.c           |   6 +-
 drivers/iommu/iommufd/iommufd_private.h |  27 +++-
 drivers/iommu/iommufd/pasid.c           | 161 ++++++++++++++++++++++++
 include/linux/iommufd.h                 |   7 ++
 6 files changed, 215 insertions(+), 17 deletions(-)
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
index c22ef4077348..c1ff3dbe109c 100644
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
@@ -329,9 +332,12 @@ int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
 		return -ENOMEM;
 
 	handle->idev = idev;
-	WARN_ON(pasid != IOMMU_NO_PASID);
-	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
-					&handle->handle);
+	if (pasid == IOMMU_NO_PASID)
+		ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
+						&handle->handle);
+	else
+		ret = iommu_attach_device_pasid(hwpt->domain, idev->dev, pasid,
+						&handle->handle);
 	if (ret)
 		kfree(handle);
 
@@ -351,9 +357,12 @@ int iommufd_dev_replace_handle(struct iommufd_device *idev,
 		return -ENOMEM;
 
 	handle->idev = idev;
-	WARN_ON(pasid != IOMMU_NO_PASID);
-	ret = iommu_replace_group_handle(idev->igroup->group,
-					 hwpt->domain, &handle->handle);
+	if (pasid == IOMMU_NO_PASID)
+		ret = iommu_replace_group_handle(idev->igroup->group,
+						 hwpt->domain, &handle->handle);
+	else
+		ret = iommu_replace_device_pasid(hwpt->domain, idev->dev,
+						 pasid, &handle->handle);
 	if (ret)
 		kfree(handle);
 
@@ -600,10 +609,6 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	return ERR_PTR(rc);
 }
 
-typedef struct iommufd_hw_pagetable *(*attach_fn)(
-			struct iommufd_device *idev, ioasid_t pasid,
-			struct iommufd_hw_pagetable *hwpt);
-
 /*
  * When automatically managing the domains we search for a compatible domain in
  * the iopt and if one is found use it, otherwise create a new domain.
@@ -687,9 +692,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
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
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 99d58df8f6db..96ca28ff31f7 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -116,8 +116,10 @@ void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach_handle *handle;
 
 	handle = iommufd_device_get_attach_handle(idev, pasid);
-	WARN_ON(pasid != IOMMU_NO_PASID);
-	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	if (pasid == IOMMU_NO_PASID)
+		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	else
+		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
 	iommufd_auto_response_faults(hwpt, handle);
 	iommufd_fault_iopf_disable(idev);
 	kfree(handle);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 21d33a784193..e9d6bd8b44bc 100644
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
@@ -417,6 +418,20 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
+typedef struct iommufd_hw_pagetable *(*attach_fn)(
+			struct iommufd_device *idev, ioasid_t pasid,
+			struct iommufd_hw_pagetable *hwpt);
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
@@ -498,6 +513,9 @@ static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 					     struct iommufd_device *idev,
 					     ioasid_t pasid)
 {
+	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
+		return -EINVAL;
+
 	if (hwpt->fault)
 		return iommufd_fault_domain_attach_dev(hwpt, idev, pasid);
 
@@ -516,8 +534,10 @@ static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	handle = iommufd_device_get_attach_handle(idev, pasid);
-	WARN_ON(pasid != IOMMU_NO_PASID);
-	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	if (pasid == IOMMU_NO_PASID)
+		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	else
+		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
 	kfree(handle);
 }
 
@@ -529,6 +549,9 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *curr;
 	int ret;
 
+	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
+		return -EINVAL;
+
 	if (old->fault || hwpt->fault)
 		return iommufd_fault_domain_replace_dev(idev, pasid,
 							hwpt, old);
diff --git a/drivers/iommu/iommufd/pasid.c b/drivers/iommu/iommufd/pasid.c
new file mode 100644
index 000000000000..fcdfbc01dcbb
--- /dev/null
+++ b/drivers/iommu/iommufd/pasid.c
@@ -0,0 +1,161 @@
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
+	refcount_inc(&hwpt->obj.users);
+	curr = xa_cmpxchg(&idev->pasid_hwpts, pasid, NULL, hwpt, GFP_KERNEL);
+	if (curr) {
+		if (curr == hwpt)
+			rc = 0;
+		else
+			rc = xa_err(curr) ? : -EINVAL;
+		goto err_put_hwpt;
+	}
+
+	rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
+	if (rc) {
+		xa_erase(&idev->pasid_hwpts, pasid);
+		goto err_put_hwpt;
+	}
+
+	return NULL;
+
+err_put_hwpt:
+	refcount_dec(&hwpt->obj.users);
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
+	refcount_inc(&hwpt->obj.users);
+	curr = xa_store(&idev->pasid_hwpts, pasid, hwpt, GFP_KERNEL);
+	rc = xa_err(curr);
+	if (rc)
+		goto out_put_hwpt;
+
+	if (!curr) {
+		xa_erase(&idev->pasid_hwpts, pasid);
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	if (curr == hwpt)
+		goto out_put_hwpt;
+
+	/*
+	 * After replacement, the reference on the old hwpt is retained
+	 * in this thread as caller would free it.
+	 */
+	rc = iommufd_hwpt_replace_device(idev, pasid, hwpt, curr);
+	if (rc) {
+		WARN_ON(xa_err(xa_store(&idev->pasid_hwpts, pasid,
+					curr, GFP_KERNEL)));
+		goto out_put_hwpt;
+	}
+
+	/* Caller must destroy old_hwpt */
+	return curr;
+
+out_put_hwpt:
+	refcount_dec(&hwpt->obj.users);
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
+ * iommufd does not handle race between iommufd_device_pasid_attach(),
+ * iommufd_device_pasid_replace() and iommufd_device_pasid_detach().
+ * So caller of them should guarantee no concurrent call on the same
+ * device and pasid.
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
+ * iommufd does not handle race between iommufd_device_pasid_replace(),
+ * iommufd_device_pasid_attach() and iommufd_device_pasid_detach().
+ * So caller of them should guarantee no concurrent call on the same
+ * device and pasid.
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
+ *
+ * iommufd does not handle race between iommufd_device_pasid_detach(),
+ * iommufd_device_pasid_attach() and iommufd_device_pasid_replace().
+ * So caller of them should guarantee no concurrent call on the same
+ * device and pasid.
+ */
+void iommufd_device_pasid_detach(struct iommufd_device *idev, ioasid_t pasid)
+{
+	struct iommufd_hw_pagetable *hwpt;
+
+	hwpt = xa_erase(&idev->pasid_hwpts, pasid);
+	if (WARN_ON(!hwpt))
+		return;
+	iommufd_hwpt_detach_device(hwpt, idev, pasid);
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

