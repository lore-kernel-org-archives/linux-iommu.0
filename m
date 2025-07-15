Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623132701C7
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561702; cv=none; b=HPTvl2l2BsnSU05ptz/4Xf4FipGbD4GbtyuHO8U2ROkfpB7FRNd5fTNwJonxntDpxS4aVreQ+IKIK+5znshxwa8a8pCkV0BwreFti1v9aHIRWaelF42p+gfG/dqhWXoEGEUEX8e/C9TzzHpvH4+kd/NhPOk4Y1N2t4OIEoRB8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561702; c=relaxed/simple;
	bh=shnm6bgro/rhfz5nWp9YsK4zVE2tz+/luZAIycNTsrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWRkZ37bjHtUihcReeMI14UPi8dujHCHp/vm8rN9dGBXQjH9J1c/cTI9rwoMUazAvyIrNK3otJFBkOGJm9cilRlNkh6qIqGUghTEWGFw3tZnUNggqHc6afrSBYDGEEaNzYE59n/TxKmXQ5AhPa9RRP069S+q44CHSkmyjPuD8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWSZg/Ru; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWSZg/Ru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561701; x=1784097701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shnm6bgro/rhfz5nWp9YsK4zVE2tz+/luZAIycNTsrw=;
  b=KWSZg/RurfOjoHNJdmd03WdLJJkVU8bsREILyiLRbdUFLa7/aLP1cFTt
   DMseMs9e6OcZndtrvbqOGxz94kCwS6W4mFKzAsp/AoeeISSf2jTmn12d8
   UH5Q+TWKOUEu808qRvCfTaWq/c/rZawKtPWBJCR21B+hOEesczuQJI8D6
   cH8ALEhh456kytvLDqL2IAeHAm16EvT/070o7iu4XtSa2NLWqhe4UKHjY
   G7d6JZNm+FeTYiJ0ntu/4yZMT3MtCXVdVokP0ufR4xySKdY9j9/1N/RQ4
   Ef93l4WtIBGxXK+WQEezDNHsfT7grnlYhhUUghTSbkJVR1UXoMzMXsM0M
   Q==;
X-CSE-ConnectionGUID: T/Y6iIQqQWadGpkjjvw2uw==
X-CSE-MsgGUID: /O4CAIihR3yqb3RkTJHe7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880871"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880871"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:40 -0700
X-CSE-ConnectionGUID: 4IqddqbjTAWWE8IAuLTJ2g==
X-CSE-MsgGUID: J9yXILHiQ4e/Z76d5mcSLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157649010"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:36 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v5 4/8] iommufd: Destroy vdevice on idevice destroy
Date: Tue, 15 Jul 2025 14:32:41 +0800
Message-Id: <20250715063245.1799534-5-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Destroy iommufd_vdevice (vdev) on iommufd_idevice (idev) destruction so
that vdev can't outlive idev.

idev represents the physical device bound to iommufd, while the vdev
represents the virtual instance of the physical device in the VM. The
lifecycle of the vdev should not be longer than idev. This doesn't
cause real problem on existing use cases cause vdev doesn't impact the
physical device, only provides virtualization information. But to
extend vdev for Confidential Computing (CC), there are needs to do
secure configuration for the vdev, e.g. TSM Bind/Unbind. These
configurations should be rolled back on idev destroy, or the external
driver (VFIO) functionality may be impact.

The idev is created by external driver so its destruction can't fail.
The idev implements pre_destroy() op to actively remove its associated
vdev before destroying itself. There are 3 cases on idev pre_destroy():

  1. vdev is already destroyed by userspace. No extra handling needed.
  2. vdev is still alive. Use iommufd_object_tombstone_user() to
     destroy vdev and tombstone the vdev ID.
  3. vdev is being destroyed by userspace. The vdev ID is already
     freed, but vdev destroy handler is not completed. This requires
     multi-threads syncing - vdev holds idev's short term users
     reference until vdev destruction completes, idev leverages
     existing wait_shortterm mechanism for syncing.

idev should also block any new reference to it after pre_destroy(),
or the following wait shortterm would timeout. Introduce a 'destroying'
flag, set it to true on idev pre_destroy(). Any attempt to reference
idev should honor this flag under the protection of
idev->igroup->lock.

Originally-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/device.c          | 51 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h | 12 ++++++
 drivers/iommu/iommufd/main.c            |  2 +
 drivers/iommu/iommufd/viommu.c          | 52 +++++++++++++++++++++++--
 include/linux/iommufd.h                 |  1 +
 include/uapi/linux/iommufd.h            |  5 +++
 6 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e2ba21c43ad2..ee6ff4caf398 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -137,6 +137,57 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	}
 }
 
+static void iommufd_device_remove_vdev(struct iommufd_device *idev)
+{
+	struct iommufd_vdevice *vdev;
+
+	mutex_lock(&idev->igroup->lock);
+	/* prevent new references from vdev */
+	idev->destroying = true;
+	/* vdev has been completely destroyed by userspace */
+	if (!idev->vdev)
+		goto out_unlock;
+
+	vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
+	/*
+	 * An ongoing vdev destroy ioctl has removed the vdev from the object
+	 * xarray, but has not finished iommufd_vdevice_destroy() yet as it
+	 * needs the same mutex. We exit the locking then wait on short term
+	 * users for the vdev destruction.
+	 */
+	if (IS_ERR(vdev))
+		goto out_unlock;
+
+	/* Should never happen */
+	if (WARN_ON(vdev != idev->vdev)) {
+		iommufd_put_object(idev->ictx, &vdev->obj);
+		goto out_unlock;
+	}
+
+	/*
+	 * vdev is still alive. Hold a users refcount to prevent racing with
+	 * userspace destruction, then use iommufd_object_tombstone_user() to
+	 * destroy it and leave a tombstone.
+	 */
+	refcount_inc(&vdev->obj.users);
+	iommufd_put_object(idev->ictx, &vdev->obj);
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_object_tombstone_user(idev->ictx, &vdev->obj);
+	return;
+
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+}
+
+void iommufd_device_pre_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_device *idev =
+		container_of(obj, struct iommufd_device, obj);
+
+	/* Release the short term users on this */
+	iommufd_device_remove_vdev(idev);
+}
+
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 149545060029..5d6ea5395cfe 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -489,6 +489,8 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	struct iommufd_vdevice *vdev;
+	bool destroying;
 };
 
 static inline struct iommufd_device *
@@ -499,6 +501,7 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_device, obj);
 }
 
+void iommufd_device_pre_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
@@ -687,9 +690,18 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 
+static inline struct iommufd_vdevice *
+iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
+{
+	return container_of(iommufd_get_object(ictx, id,
+					       IOMMUFD_OBJ_VDEVICE),
+			    struct iommufd_vdevice, obj);
+}
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 53085d24ce4a..99c1aab3d396 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -655,6 +655,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_access_destroy_object,
 	},
 	[IOMMUFD_OBJ_DEVICE] = {
+		.pre_destroy = iommufd_device_pre_destroy,
 		.destroy = iommufd_device_destroy,
 	},
 	[IOMMUFD_OBJ_FAULT] = {
@@ -676,6 +677,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
+		.abort = iommufd_vdevice_abort,
 	},
 	[IOMMUFD_OBJ_VEVENTQ] = {
 		.destroy = iommufd_veventq_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index dcf8a85b9f6e..ecbae5091ffe 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -110,20 +110,37 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
-void iommufd_vdevice_destroy(struct iommufd_object *obj)
+void iommufd_vdevice_abort(struct iommufd_object *obj)
 {
 	struct iommufd_vdevice *vdev =
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
+	struct iommufd_device *idev = vdev->idev;
+
+	lockdep_assert_held(&idev->igroup->lock);
 
 	if (vdev->destroy)
 		vdev->destroy(vdev);
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->virt_id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
+	idev->vdev = NULL;
 	put_device(vdev->dev);
 }
 
+void iommufd_vdevice_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *vdev =
+		container_of(obj, struct iommufd_vdevice, obj);
+	struct iommufd_device *idev = vdev->idev;
+	struct iommufd_ctx *ictx = idev->ictx;
+
+	mutex_lock(&idev->igroup->lock);
+	iommufd_vdevice_abort(obj);
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(ictx, &idev->obj);
+}
+
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
@@ -153,6 +170,17 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
+	mutex_lock(&idev->igroup->lock);
+	if (idev->destroying) {
+		rc = -ENOENT;
+		goto out_unlock_igroup;
+	}
+
+	if (idev->vdev) {
+		rc = -EEXIST;
+		goto out_unlock_igroup;
+	}
+
 	if (viommu->ops && viommu->ops->vdevice_size) {
 		/*
 		 * It is a driver bug for:
@@ -171,7 +199,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		ucmd->ictx, vdev_size, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
-		goto out_put_idev;
+		goto out_unlock_igroup;
 	}
 
 	vdev->virt_id = virt_id;
@@ -179,6 +207,19 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	get_device(idev->dev);
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
+	/*
+	 * A short term users reference is held on the idev so long as we have
+	 * the pointer. iommufd_device_pre_destroy() will revoke it before the
+	 * idev real destruction.
+	 */
+	vdev->idev = idev;
+
+	/*
+	 * iommufd_device_destroy() delays until idev->vdev is NULL before
+	 * freeing the idev, which only happens once the vdev is finished
+	 * destruction.
+	 */
+	idev->vdev = vdev;
 
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
 	if (curr) {
@@ -197,12 +238,15 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (rc)
 		goto out_abort;
 	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
-	goto out_put_idev;
+	goto out_unlock_igroup;
 
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_unlock_igroup:
+	mutex_unlock(&idev->igroup->lock);
 out_put_idev:
-	iommufd_put_object(ucmd->ictx, &idev->obj);
+	if (rc)
+		iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index e3a0cd47384d..b88911026bc4 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -108,6 +108,7 @@ struct iommufd_viommu {
 struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
 	struct device *dev;
 
 	/*
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 554aacf89ea7..c218c89e0e2e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1070,6 +1070,11 @@ struct iommu_viommu_alloc {
  *
  * Allocate a virtual device instance (for a physical device) against a vIOMMU.
  * This instance holds the device's information (related to its vIOMMU) in a VM.
+ * User should use IOMMU_DESTROY to destroy the virtual device before
+ * destroying the physical device (by closing vfio_cdev fd). Otherwise the
+ * virtual device would be forcibly destroyed on physical device destruction,
+ * its vdevice_id would be permanently leaked (unremovable & unreusable) until
+ * iommu fd closed.
  */
 struct iommu_vdevice_alloc {
 	__u32 size;
-- 
2.25.1

