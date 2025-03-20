Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5873221DB3
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478474; cv=none; b=XZ00wbuFtcJF8+K9BXyREdYowDw7AL7CUHV2eakIxySKs841ODvfWkiW/o6DxGkN7LpVbr6dzIFTaEN8Hz2PE6cHsPkqSHsUxlncMyiQDAHlKz8tD4xzVhtMop9wT//Z+IHtgqCG9PXhnZoSO0sc3Z0vW8h3ab40sYJyuRgS8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478474; c=relaxed/simple;
	bh=HN11Sr2kr7Qo2VL1KmL1uGJVKonvaDssm8Nw7fOb0sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LTIt7THZ/PZWlXgX8ie1i4X/T2WUh7mBFaPebLoG5oqmBokbemDc9vH/8qPVxwCgYoXnR7VPZd8YGnUHpY+AMNfAv60nVd6VSlNpA5LZtbOXy43vuOLrN1KO7dRMUQqHEVLcjxbP5TCpgHSST85HpTI/sl7u2WfkZ5a6Smc49Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHO3TumY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHO3TumY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478472; x=1774014472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HN11Sr2kr7Qo2VL1KmL1uGJVKonvaDssm8Nw7fOb0sE=;
  b=hHO3TumYvTW6H7T2bNwXbnK/1hIowf4n2EfUj5wNpS+1xsgBEXDy+Opr
   Q28PjaFsr23UB0wD6EvUFKZegBVwhZPwDxZ8EwjjSvJyq3T0Vyv9bcCEX
   g13Dx0P0l7/XOfoN8iiRgWyJFiLgcD0h0ZSOfy2PCYLq/Qtwvu4MK9jGN
   Mk8MUIPJOb+yZNIfxmqy3qK25Tdn6P/o+r5uyKp5TF1P+uZeQo9EtFygw
   BJWbmOxnqBx9EKO0MtnxGNQuiICZN20Cc50TfJCwrP0IacCax1Fm7m42p
   3o3zcaNtraIIQ6ULIvAXK7xY1NwkII0JILJTJZFqze1MS1bN+v5aoLYm/
   w==;
X-CSE-ConnectionGUID: js86u8EmSfe2yqburdamwQ==
X-CSE-MsgGUID: dILTkURMQYaXOF1+6laj7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063059"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063059"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:47 -0700
X-CSE-ConnectionGUID: TxtPoNtNTaW58kK7ozNSvg==
X-CSE-MsgGUID: 3UQYCBTyTZSfDvqMgCv/uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319162"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:47 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 08/18] iommufd/device: Replace device_list with device_array
Date: Thu, 20 Mar 2025 06:47:34 -0700
Message-Id: <20250320134744.5777-9-yi.l.liu@intel.com>
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

igroup->attach->device_list is used to track attached device of a group
in the RID path. Such tracking is also needed in the PASID path in order
to share path with the RID path.

While there is only one list_head in the iommufd_device. It cannot work
if the device has been attached in both RID path and PASID path. To solve
it, replacing the device_list with an xarray. The attached iommufd_device
is stored in the entry indexed by the idev->obj.id.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 58 +++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7a3e105362cb..ef579b5d463d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -20,7 +20,7 @@ MODULE_PARM_DESC(
 
 struct iommufd_attach {
 	struct iommufd_hw_pagetable *hwpt;
-	struct list_head device_list;
+	struct xarray device_array;
 };
 
 static void iommufd_group_release(struct kref *kref)
@@ -298,6 +298,20 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
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
+	if (igroup->attach)
+		xa_for_each(&igroup->attach->device_array, index, idev)
+			count++;
+	return count;
+}
+
 /*
  * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
  * layer. The mapping to IOVA is global to the iommufd file descriptor, every
@@ -486,12 +500,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 /* Check if idev is attached to igroup->hwpt */
 static bool iommufd_device_is_attached(struct iommufd_device *idev)
 {
-	struct iommufd_device *cur;
-
-	list_for_each_entry(cur, &idev->igroup->attach->device_list, group_item)
-		if (cur == idev)
-			return true;
-	return false;
+	return xa_load(&idev->igroup->attach->device_array, idev->obj.id);
 }
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
@@ -625,20 +634,27 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 			rc = -ENOMEM;
 			goto err_unlock;
 		}
-		INIT_LIST_HEAD(&attach->device_list);
+		xa_init(&attach->device_array);
 	}
 
 	old_hwpt = attach->hwpt;
 
+	rc = xa_insert(&igroup->attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
+		       GFP_KERNEL);
+	if (rc) {
+		WARN_ON(rc == -EBUSY && !old_hwpt);
+		goto err_free_attach;
+	}
+
 	if (old_hwpt && old_hwpt != hwpt) {
 		rc = -EINVAL;
-		goto err_free_attach;
+		goto err_release_devid;
 	}
 
 	if (attach_resv) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
-			goto err_free_attach;
+			goto err_release_devid;
 	}
 
 	/*
@@ -656,12 +672,15 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		igroup->attach = attach;
 	}
 	refcount_inc(&hwpt->obj.users);
-	list_add_tail(&idev->group_item, &attach->device_list);
+	WARN_ON(xa_is_err(xa_store(&attach->device_array, idev->obj.id,
+				   idev, GFP_KERNEL)));
 	mutex_unlock(&igroup->lock);
 	return 0;
 err_unresv:
 	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
+err_release_devid:
+	xa_release(&attach->device_array, idev->obj.id);
 err_free_attach:
 	if (igroup_first_attach(igroup, pasid))
 		kfree(attach);
@@ -683,8 +702,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 	hwpt = attach->hwpt;
 	hwpt_paging = find_hwpt_paging(hwpt);
 
-	list_del(&idev->group_item);
-	if (list_empty(&attach->device_list)) {
+	xa_erase(&attach->device_array, idev->obj.id);
+	if (xa_empty(&attach->device_array)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		igroup->attach = NULL;
 		kfree(attach);
@@ -714,10 +733,11 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
 	struct iommufd_device *cur;
+	unsigned long index;
 
 	lockdep_assert_held(&igroup->lock);
 
-	list_for_each_entry(cur, &igroup->attach->device_list, group_item)
+	xa_for_each(&igroup->attach->device_array, index, cur)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
 }
 
@@ -727,14 +747,14 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 {
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_device *cur;
+	unsigned long index;
 	int rc;
 
 	lockdep_assert_held(&igroup->lock);
 
 	old_hwpt_paging = find_hwpt_paging(igroup->attach->hwpt);
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
-		list_for_each_entry(cur,
-				    &igroup->attach->device_list, group_item) {
+		xa_for_each(&igroup->attach->device_array, index, cur) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
 			if (rc)
@@ -775,7 +795,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	old_hwpt = attach->hwpt;
 
-	WARN_ON(!old_hwpt || list_empty(&attach->device_list));
+	WARN_ON(!old_hwpt || xa_empty(&attach->device_array));
 
 	if (!iommufd_device_is_attached(idev)) {
 		rc = -EINVAL;
@@ -804,9 +824,9 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	attach->hwpt = hwpt;
 
-	num_devices = list_count_nodes(&attach->device_list);
+	num_devices = iommufd_group_device_num(igroup);
 	/*
-	 * Move the refcounts held by the device_list to the new hwpt. Retain a
+	 * Move the refcounts held by the device_array to the new hwpt. Retain a
 	 * refcount for this thread as the caller will free it.
 	 */
 	refcount_add(num_devices, &hwpt->obj.users);
-- 
2.34.1

