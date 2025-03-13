Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E28267383
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869355; cv=none; b=MzgAOIVz0exZDGKUFbW0OVOfpVg9HniVus8cRFyNzFOYD2EVX0bAT5kZS7N30khmwX0TFPtsXYcy3QQq6Cwj6yeFSIMzUYnYdXG+kOIwZqUqzdPjrN5GnQUVDrzJVyr2TnUjGYuDcLX4P4fUC9lk0j0mvJJvnyjVO7TJd5voBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869355; c=relaxed/simple;
	bh=h47RnR7RfOwl2msRVNGOyX3YvBCwRPHYpJ6z/zr8F/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUjiHEdMuIqt59JED0p6hV8hqI67M+4fWEY3LQcV0YgKDwCY9xZ12RvPE+0QZZ210HexwYXUCVTJ0QlV9NPdUPXs5NQqgkKLN2bJmqzSRJjD72TtQK+mkC+GbHAgBTneDrke38bjdgeLe9pzf+fVe334TWNOqyd9r34MvcMX//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEASY6hG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEASY6hG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869354; x=1773405354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h47RnR7RfOwl2msRVNGOyX3YvBCwRPHYpJ6z/zr8F/Y=;
  b=fEASY6hGOoXiouQsaNzQZiuK8VkNUydtuxW7gkXOi14Gd8rkFT2sOcGK
   qO8eQyMU651vNVN61VOIGA1y1nbuc3ISKfJ/0a07FL4gOhHTKAJXMUaYv
   kpDmL/xgUWs8hqG/N7B/7triZQk+xHWQ9Pu2XyZHhFNyWw3wUlPiY8vAp
   tW4ZEtWlbTjEnGB0+tjiTaQImyeBwOiE8LnW3+/D6qf+jfzslTmUubURH
   P2jEEGi+O99LNz1KRgRjdys+vz07FMpqrf4+eq4c5I2dIXWYYnBdlvhEj
   nnK6+WwWM3uMKewtVkDRnmG5JBJAIpZwQWAd6r/fXlH38kmjzw5Hq9WFE
   w==;
X-CSE-ConnectionGUID: rC4KdhJOQkOdpnSv46FC3A==
X-CSE-MsgGUID: le9zLL9VSEGzYQEtetbVWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863968"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863968"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:39 -0700
X-CSE-ConnectionGUID: S71Lu6F5R1Cks79POi03ZA==
X-CSE-MsgGUID: CaufroFcSEG4EdQP5Z5BbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005526"
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
Subject: [PATCH v9 11/21] iommufd/device: Move attached device tracking to handle
Date: Thu, 13 Mar 2025 05:35:22 -0700
Message-Id: <20250313123532.103522-12-yi.l.liu@intel.com>
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

By tracking both attached hwpt and devices, iommufd_attach_handle is
prepared to be used as attach object. This prepares for adding per-PASID
attachment by using handle.

The handle has cached the first attached idev, this is used in the PRI
reading path to retrieve devid. This field is kept although it is a
bit duplicated with the devices tracked in device_array. However, there
is open on the PRI path. Conceptually, the PRI read path should use the
device_array to loop all attached devices to figure out the correct idev.
But the existing code can only work for the groups that have only one
device attached as it needs the PRI flushing of the detach path to fence
the detach path and the PRI read path. If the group has multiple devices
attached, this fence does not work because the detach path only flushes
PRI when the last attached device is detached. We may solve it separately
hence no need to touch it in this commit.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 24 +++++++++++++-----------
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index f34481940b6b..7d52f304b9bb 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -23,7 +23,7 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
-	WARN_ON(igroup->handle || !xa_empty(&igroup->device_array));
+	WARN_ON(igroup->handle);
 
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
@@ -90,7 +90,6 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
-	xa_init(&new_igroup->device_array);
 	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
@@ -303,7 +302,7 @@ static int iommufd_group_device_num(struct iommufd_group *igroup)
 	lockdep_assert_held(&igroup->lock);
 
 	if (igroup->handle)
-		xa_for_each(&igroup->device_array, index, idev)
+		xa_for_each(&igroup->handle->device_array, index, idev)
 			count++;
 	return count;
 }
@@ -488,7 +487,8 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 static bool iommufd_device_is_attached(struct iommufd_device *idev)
 {
-	return xa_load(&idev->igroup->device_array, idev->obj.id);
+	WARN_ON(!idev->igroup->handle);
+	return xa_load(&idev->igroup->handle->device_array, idev->obj.id);
 }
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
@@ -589,11 +589,12 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 			goto err_unlock;
 		}
 		handle->idev = idev;
+		xa_init(&handle->device_array);
 	}
 
 	old_hwpt = handle->hwpt;
 
-	rc = xa_insert(&igroup->device_array, idev->obj.id, XA_ZERO_ENTRY,
+	rc = xa_insert(&handle->device_array, idev->obj.id, XA_ZERO_ENTRY,
 		       GFP_KERNEL);
 	if (rc) {
 		WARN_ON(rc == -EBUSY && !old_hwpt);
@@ -626,7 +627,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		igroup->handle = handle;
 	}
 	refcount_inc(&hwpt->obj.users);
-	WARN_ON(xa_is_err(__xa_store(&igroup->device_array, idev->obj.id,
+	WARN_ON(xa_is_err(__xa_store(&handle->device_array, idev->obj.id,
 				     idev, GFP_KERNEL)));
 	mutex_unlock(&igroup->lock);
 	return 0;
@@ -634,7 +635,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 err_release_devid:
-	xa_release(&igroup->device_array, idev->obj.id);
+	xa_release(&handle->device_array, idev->obj.id);
 err_free_handle:
 	if (!old_hwpt)
 		kfree(handle);
@@ -655,8 +656,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 	handle = igroup->handle;
 	hwpt = handle->hwpt;
 	hwpt_paging = find_hwpt_paging(hwpt);
-	xa_erase(&igroup->device_array, idev->obj.id);
-	if (xa_empty(&igroup->device_array)) {
+	xa_erase(&handle->device_array, idev->obj.id);
+	if (xa_empty(&handle->device_array)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid, handle);
 		igroup->handle = NULL;
 		kfree(handle);
@@ -690,7 +691,8 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 
 	lockdep_assert_held(&igroup->lock);
 
-	xa_for_each(&igroup->device_array, index, cur)
+	WARN_ON(!igroup->handle);
+	xa_for_each(&igroup->handle->device_array, index, cur)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
 }
 
@@ -708,7 +710,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 	WARN_ON(!igroup->handle);
 	old_hwpt_paging = find_hwpt_paging(igroup->handle->hwpt);
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
-		xa_for_each(&igroup->device_array, index, cur) {
+		xa_for_each(&igroup->handle->device_array, index, cur) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
 			if (rc)
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 387a0fab258c..2c0ff618b916 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -406,7 +406,6 @@ struct iommufd_group {
 	struct iommufd_attach_handle *handle;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
-	struct xarray device_array;
 };
 
 /*
@@ -503,6 +502,7 @@ struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
 	struct iommufd_hw_pagetable *hwpt;
+	struct xarray device_array;
 };
 
 /* Convert an iommu attach handle to iommufd handle. */
-- 
2.34.1

