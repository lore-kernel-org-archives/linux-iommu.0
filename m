Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EC266F1D
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869355; cv=none; b=cSdc9m0716of34YLygBeUrf3l40zCUZSS8qbkrc2zDIhC7Qh/HrI82E7RBfE5IESK0AE9H1kNW/Mru+k3mkMkycL3SQc1Bnq3hVjhM3t2eBKnzUqAsuaSYManmQ4FXSpToyHLcs5XVXWQZ6N4e71p8FRynju/JhmQb73JVfVV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869355; c=relaxed/simple;
	bh=cbFzeZWWuiKf1kkL1lonR0AJEynVNwK3XlyMh46XqcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rzbxz2eNRZmNruaem3VcgCDgSSssCmja71VreDWDyKkuyfW0hxFyPzLryM0JqS5nTzY9qcF/jqRxLI8e5TsQvf9kLBbnDYhtw3EtPLGSqwrIkLfsK2NDNsQV8My7AXIHdbIIwkJGg05wOcSSau1bCtG1f+EzO5vu5RWNH/biH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDFGf7gF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDFGf7gF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869353; x=1773405353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbFzeZWWuiKf1kkL1lonR0AJEynVNwK3XlyMh46XqcA=;
  b=LDFGf7gFXNDqSH35BUxF9AoCQoZTct9GrCkmZ2srON4qR+kEuJZ0Vm6H
   QD4Wpr1w32lNGUKBbBrhohnDxoWH7MKo57o2rszSfofyYt4POZj5Sgika
   HHFrCxaQ3m9VnLmEOqTaKzXijC7WDsmRUnRgkdMOc2Fe5adGL9QVPePv/
   tbOM/bZMbbQaolIwdC+5EzkpXRLpMq1DrFE2OtVcy0ny3ySKjxEp36vWy
   41uYvcc9bL57D5k0RdC4zyAxalCZKUGTKNIAFs0q3DsaTJV7Fmodk4ewe
   OUyBoQA4hVRH5l2nHJSac3oSpk60CCxI70gg2Tri/CaDkv28R7Y8pLSR8
   g==;
X-CSE-ConnectionGUID: 1wBgUP2mTXCLqBGUevvruw==
X-CSE-MsgGUID: SqO1QEKoT7uGnWnZFFCY3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863965"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863965"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:38 -0700
X-CSE-ConnectionGUID: FrF5hELVSmCpmxOKruoeNg==
X-CSE-MsgGUID: 7Q2lp9mBSE2lGkodwVljjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005521"
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
Subject: [PATCH v9 10/21] iommufd/device: Replace device_list with device_array
Date: Thu, 13 Mar 2025 05:35:21 -0700
Message-Id: <20250313123532.103522-11-yi.l.liu@intel.com>
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

igroup->device_list is used to track attached device of a group in the
RID path. Such a tracking is also needed in the PASID path in order to
share common path with the RID path.

While there is only one list_head in the iommufd_device. It cannot work
out if the device has been attached in both RID path and PASID path. To
solve it, replacing the device_list with an xarray. The attached
iommufd_device is stored in the entry indexed by the idev->obj.id.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 57 +++++++++++++++++--------
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9f31fc6acde3..f34481940b6b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -23,7 +23,7 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
-	WARN_ON(igroup->handle || !list_empty(&igroup->device_list));
+	WARN_ON(igroup->handle || !xa_empty(&igroup->device_array));
 
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
@@ -90,7 +90,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
-	INIT_LIST_HEAD(&new_igroup->device_list);
+	xa_init(&new_igroup->device_array);
 	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
@@ -294,6 +294,20 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
+static int iommufd_group_device_num(struct iommufd_group *igroup)
+{
+	struct iommufd_device *idev;
+	unsigned long index;
+	int count = 0;
+
+	lockdep_assert_held(&igroup->lock);
+
+	if (igroup->handle)
+		xa_for_each(&igroup->device_array, index, idev)
+			count++;
+	return count;
+}
+
 /*
  * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
  * layer. The mapping to IOVA is global to the iommufd file descriptor, every
@@ -474,12 +488,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 static bool iommufd_device_is_attached(struct iommufd_device *idev)
 {
-	struct iommufd_device *cur;
-
-	list_for_each_entry(cur, &idev->igroup->device_list, group_item)
-		if (cur == idev)
-			return true;
-	return false;
+	return xa_load(&idev->igroup->device_array, idev->obj.id);
 }
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
@@ -584,15 +593,22 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 
 	old_hwpt = handle->hwpt;
 
+	rc = xa_insert(&igroup->device_array, idev->obj.id, XA_ZERO_ENTRY,
+		       GFP_KERNEL);
+	if (rc) {
+		WARN_ON(rc == -EBUSY && !old_hwpt);
+		goto err_free_handle;
+	}
+
 	if (old_hwpt && old_hwpt != hwpt) {
 		rc = -EINVAL;
-		goto err_free_handle;
+		goto err_release_devid;
 	}
 
 	if (attach_resv) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
-			goto err_free_handle;
+			goto err_release_devid;
 	}
 
 	/*
@@ -602,7 +618,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * reserved regions are only updated during individual device
 	 * attachment.
 	 */
-	if (list_empty(&igroup->device_list)) {
+	if (!iommufd_group_device_num(igroup)) {
 		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid, handle);
 		if (rc)
 			goto err_unresv;
@@ -610,12 +626,15 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		igroup->handle = handle;
 	}
 	refcount_inc(&hwpt->obj.users);
-	list_add_tail(&idev->group_item, &igroup->device_list);
+	WARN_ON(xa_is_err(__xa_store(&igroup->device_array, idev->obj.id,
+				     idev, GFP_KERNEL)));
 	mutex_unlock(&igroup->lock);
 	return 0;
 err_unresv:
 	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
+err_release_devid:
+	xa_release(&igroup->device_array, idev->obj.id);
 err_free_handle:
 	if (!old_hwpt)
 		kfree(handle);
@@ -636,8 +655,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 	handle = igroup->handle;
 	hwpt = handle->hwpt;
 	hwpt_paging = find_hwpt_paging(hwpt);
-	list_del(&idev->group_item);
-	if (list_empty(&igroup->device_list)) {
+	xa_erase(&igroup->device_array, idev->obj.id);
+	if (xa_empty(&igroup->device_array)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid, handle);
 		igroup->handle = NULL;
 		kfree(handle);
@@ -667,10 +686,11 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
 	struct iommufd_device *cur;
+	unsigned long index;
 
 	lockdep_assert_held(&igroup->lock);
 
-	list_for_each_entry(cur, &igroup->device_list, group_item)
+	xa_for_each(&igroup->device_array, index, cur)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
 }
 
@@ -680,6 +700,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 {
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_device *cur;
+	unsigned long index;
 	int rc;
 
 	lockdep_assert_held(&igroup->lock);
@@ -687,7 +708,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 	WARN_ON(!igroup->handle);
 	old_hwpt_paging = find_hwpt_paging(igroup->handle->hwpt);
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
-		list_for_each_entry(cur, &igroup->device_list, group_item) {
+		xa_for_each(&igroup->device_array, index, cur) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
 			if (rc)
@@ -756,9 +777,9 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	handle->hwpt = hwpt;
 
-	num_devices = list_count_nodes(&igroup->device_list);
+	num_devices = iommufd_group_device_num(igroup);
 	/*
-	 * Move the refcounts held by the device_list to the new hwpt. Retain a
+	 * Move the refcounts held by the device_array to the new hwpt. Retain a
 	 * refcount for this thread as the caller will free it.
 	 */
 	refcount_add(num_devices, &hwpt->obj.users);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index d07ba94e63b3..387a0fab258c 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -404,9 +404,9 @@ struct iommufd_group {
 	struct iommufd_ctx *ictx;
 	struct iommu_group *group;
 	struct iommufd_attach_handle *handle;
-	struct list_head device_list;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
+	struct xarray device_array;
 };
 
 /*
-- 
2.34.1

