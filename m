Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23854267387
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869356; cv=none; b=NpFlteoOq6bz9TPfrF81oIoEXT9tNd5fY5AfLq6WJJjcS2s0lsoFP6+ZDMTNujIAgroyc6cusLUIVVGbIqyt0+aHvNiuAGbR/qIeohTfosFsJIy8JQchJLnW2dRADWqY4xjLQRF62psQ9gRdIBR8dg3oeQ+uR7p90/5E+CS8gbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869356; c=relaxed/simple;
	bh=HajQuTHXQ0Db6egaGYEQeGNFHp6E/mT2mhCP0cgbTJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sli2wEYqI87iYNeg1sPF2w7sMbqyziqVjlHzBkXx3YXKthajkdlODld0rAz9jEDD4Z8KNer//JX7oOppCdCYQJvEmSTo9hSe9rpr9r5/xyrvKd43rt7UJGa6ksY53SnUs5Xze6/zJk+fIWASZql1rr1kC+/7pctkFo1mns1v5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYRTY/Mn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYRTY/Mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869355; x=1773405355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HajQuTHXQ0Db6egaGYEQeGNFHp6E/mT2mhCP0cgbTJM=;
  b=CYRTY/Mndo8A/1P2ER1KazvV8AdQG2BiA1aenuOS2jf71ANPaHVvzpGv
   mseLAarSIIShgBHLIJsGGCvh19yESIjehXtXygIwPqd7Cj+y//B5j9mFz
   KmuhKxRGAGEO/rn9NxqrxA2p0waeh96K2PFJDynF0Fw3bfXGqwXyZBJI5
   +0Tilp6B03uUnUmHlhBXpVdnHGqTGZg56x1Oa7Hzx1twKzaa2W4pA8Fkx
   JVGshSBTCXrigZYMXZMZex0wAMHzpT7rxsU4Cr0mUnmGMbPKg3vBp9FyV
   QJ4A1JHwlghI5fQM9rEpTqonhMW8TxyHOHqDzoh18ldWBtn20zQAwotSk
   w==;
X-CSE-ConnectionGUID: jPSSDr0pRv65LiHlttcXEQ==
X-CSE-MsgGUID: aam24xY7T5GBM0REQvxiDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863971"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863971"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:39 -0700
X-CSE-ConnectionGUID: Mzd+ekpxTBKvjNpGqVGZbw==
X-CSE-MsgGUID: +8KZgvfVS1uAj4umMWc3YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005530"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:39 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 12/21] iommufd/device: Add pasid_attach array to track per-PASID attach
Date: Thu, 13 Mar 2025 05:35:23 -0700
Message-Id: <20250313123532.103522-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PASIDs of PASID-capable device can be attached to hwpt separately, hence
a pasid array to track per-PASID attachment is necessary. The index
IOMMU_NO_PASID is used by the RID path. Hence drop the igroup->handle.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 78 +++++++++++++++++--------
 drivers/iommu/iommufd/iommufd_private.h |  4 +-
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7d52f304b9bb..63b189a5b8ac 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -23,7 +23,7 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
-	WARN_ON(igroup->handle);
+	WARN_ON(!xa_empty(&igroup->pasid_attach));
 
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
@@ -90,6 +90,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
+	xa_init(&new_igroup->pasid_attach);
 	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
@@ -293,16 +294,19 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
-static int iommufd_group_device_num(struct iommufd_group *igroup)
+static int iommufd_group_device_num(struct iommufd_group *igroup,
+				    ioasid_t pasid)
 {
+	struct iommufd_attach_handle *handle;
 	struct iommufd_device *idev;
 	unsigned long index;
 	int count = 0;
 
 	lockdep_assert_held(&igroup->lock);
 
-	if (igroup->handle)
-		xa_for_each(&igroup->handle->device_array, index, idev)
+	handle = xa_load(&igroup->pasid_attach, pasid);
+	if (handle)
+		xa_for_each(&handle->device_array, index, idev)
 			count++;
 	return count;
 }
@@ -472,7 +476,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	if (rc)
 		return rc;
 
-	if (!igroup->handle) {
+	if (!xa_load(&igroup->pasid_attach, IOMMU_NO_PASID)) {
 		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
@@ -485,10 +489,14 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
-static bool iommufd_device_is_attached(struct iommufd_device *idev)
+static bool iommufd_device_is_attached(struct iommufd_device *idev,
+				       ioasid_t pasid)
 {
-	WARN_ON(!idev->igroup->handle);
-	return xa_load(&idev->igroup->handle->device_array, idev->obj.id);
+	struct iommufd_attach_handle *handle;
+
+	handle = xa_load(&idev->igroup->pasid_attach, pasid);
+	WARN_ON(!handle);
+	return xa_load(&handle->device_array, idev->obj.id);
 }
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
@@ -574,19 +582,25 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
+	struct iommufd_hw_pagetable *old_hwpt = NULL;
 	struct iommufd_group *igroup = idev->igroup;
-	struct iommufd_hw_pagetable *old_hwpt;
 	struct iommufd_attach_handle *handle;
 	int rc;
 
 	mutex_lock(&igroup->lock);
 
-	handle = igroup->handle;
+	handle = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
+			    XA_ZERO_ENTRY, GFP_KERNEL);
+	if (xa_is_err(handle)) {
+		rc = PTR_ERR(handle);
+		goto err_unlock;
+	}
+
 	if (!handle) {
 		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 		if (!handle) {
 			rc = -ENOMEM;
-			goto err_unlock;
+			goto err_release_pasid;
 		}
 		handle->idev = idev;
 		xa_init(&handle->device_array);
@@ -619,12 +633,13 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * reserved regions are only updated during individual device
 	 * attachment.
 	 */
-	if (!iommufd_group_device_num(igroup)) {
+	if (!iommufd_group_device_num(igroup, pasid)) {
 		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid, handle);
 		if (rc)
 			goto err_unresv;
 		handle->hwpt = hwpt;
-		igroup->handle = handle;
+		WARN_ON(xa_is_err(xa_store(&igroup->pasid_attach, pasid, handle,
+					   GFP_KERNEL)));
 	}
 	refcount_inc(&hwpt->obj.users);
 	WARN_ON(xa_is_err(__xa_store(&handle->device_array, idev->obj.id,
@@ -639,6 +654,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 err_free_handle:
 	if (!old_hwpt)
 		kfree(handle);
+err_release_pasid:
+	if (!old_hwpt)
+		xa_release(&igroup->pasid_attach, pasid);
 err_unlock:
 	mutex_unlock(&igroup->lock);
 	return rc;
@@ -653,13 +671,13 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 	struct iommufd_hw_pagetable *hwpt;
 
 	mutex_lock(&igroup->lock);
-	handle = igroup->handle;
+	handle = xa_load(&igroup->pasid_attach, pasid);
 	hwpt = handle->hwpt;
 	hwpt_paging = find_hwpt_paging(hwpt);
 	xa_erase(&handle->device_array, idev->obj.id);
 	if (xa_empty(&handle->device_array)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid, handle);
-		igroup->handle = NULL;
+		xa_erase(&igroup->pasid_attach, pasid);
 		kfree(handle);
 	}
 	if (hwpt_paging && pasid == IOMMU_NO_PASID)
@@ -686,13 +704,15 @@ static void
 iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
+	struct iommufd_attach_handle *handle;
 	struct iommufd_device *cur;
 	unsigned long index;
 
 	lockdep_assert_held(&igroup->lock);
 
-	WARN_ON(!igroup->handle);
-	xa_for_each(&igroup->handle->device_array, index, cur)
+	handle = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	WARN_ON(!handle);
+	xa_for_each(&handle->device_array, index, cur)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
 }
 
@@ -701,16 +721,18 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 				       struct iommufd_hwpt_paging *hwpt_paging)
 {
 	struct iommufd_hwpt_paging *old_hwpt_paging;
+	struct iommufd_attach_handle *handle;
 	struct iommufd_device *cur;
 	unsigned long index;
 	int rc;
 
 	lockdep_assert_held(&igroup->lock);
 
-	WARN_ON(!igroup->handle);
-	old_hwpt_paging = find_hwpt_paging(igroup->handle->hwpt);
+	handle = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	WARN_ON(!handle);
+	old_hwpt_paging = find_hwpt_paging(handle->hwpt);
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
-		xa_for_each(&igroup->handle->device_array, index, cur) {
+		xa_for_each(&handle->device_array, index, cur) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
 			if (rc)
@@ -743,18 +765,24 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	mutex_lock(&igroup->lock);
 
-	if (!igroup->handle) {
+	handle = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
+			    XA_ZERO_ENTRY, GFP_KERNEL);
+	if (xa_is_err(handle)) {
+		rc = xa_err(handle);
+		goto err_unlock;
+	}
+
+	if (!handle) {
+		xa_release(&igroup->pasid_attach, pasid);
 		rc = -EINVAL;
 		goto err_unlock;
 	}
 
-	if (!iommufd_device_is_attached(idev)) {
+	if (!iommufd_device_is_attached(idev, pasid)) {
 		rc = -EINVAL;
 		goto err_unlock;
 	}
 
-	handle = igroup->handle;
-	WARN_ON(!handle);
 	old_hwpt = handle->hwpt;
 
 	if (hwpt == old_hwpt) {
@@ -779,7 +807,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	handle->hwpt = hwpt;
 
-	num_devices = iommufd_group_device_num(igroup);
+	num_devices = iommufd_group_device_num(igroup, pasid);
 	/*
 	 * Move the refcounts held by the device_array to the new hwpt. Retain a
 	 * refcount for this thread as the caller will free it.
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2c0ff618b916..f1e9b45ebd79 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -396,16 +396,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 	refcount_dec(&hwpt->obj.users);
 }
 
-struct iommufd_attach_handle;
-
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
 	struct iommufd_ctx *ictx;
 	struct iommu_group *group;
-	struct iommufd_attach_handle *handle;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
+	struct xarray pasid_attach;
 };
 
 /*
-- 
2.34.1

