Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102B22D7AE
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577591; cv=none; b=m+HxsQB9woHBiBprISoFhwwoDTo3Hcnw8rBCag9EAKYGCDYk3qgxci3HmDrJiQ/Eo6TAHqe7GQi0ZZNqqXNaggEUVg8pLRYI7gOB2FLb2ZdCiDNKQo81Cx8Ie8vbOLzOg87LMLk1VvuhxQ9+f1cJ7GRVjm/j8UcmzHoW39V30YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577591; c=relaxed/simple;
	bh=aTW9pQwplHwYG6ytfI7IZTB7lMpEbOd/vGLjeA/2COM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nAO5zpBpCaJTSOoo3Oa/BBNNXr5EcASy+mMoiN6ZZ1Rlm5vXTxr/8jR2mrRbwKJQm3mSwqVbT9ZyNmigDTdIzbDW7/VOWwUntjiXrQZlP/zF+kpwViGlGtMGKDoA1OvDuQWm/ya3X9x+AU3ZeUFYGLzUnmftsqievTRv0XcnN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dse4T24o; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dse4T24o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577590; x=1774113590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aTW9pQwplHwYG6ytfI7IZTB7lMpEbOd/vGLjeA/2COM=;
  b=Dse4T24oYjySDHiNoBNd7dVWD1quoYSpKm3xQct2n3WW3+RmWv+XV79y
   tctT/jYu+gnCMK/5uiyui5KPo/88GRVjhLTBAvkrm49az+VpmCfgiDGfS
   r5Pw6EJ2i6uEBS0wb1su38DzoaI0h2i88owahAG/EQiQ5dD/96tQz05Nc
   ZnyFPwq/FiQ4k3b0Zghjc8m1CMIIsCQaQUrS1TM1OXaupglgRVcH/WnHi
   JVJWD6h+o6ea+xBdemqGSsiCFzDmipOsxL58kT0HzyozgiHLoTZRkhWND
   AvR0EJtkXuh60F2TMZN3anHknYDEyaCcjS5evJGyshYbbTN6ia/vqwJGX
   g==;
X-CSE-ConnectionGUID: d6nUNs5jRZu3QueWo0vx1w==
X-CSE-MsgGUID: Gbbtn3lyQdmE8FfYqvMP3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976809"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976809"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:46 -0700
X-CSE-ConnectionGUID: 0qnBiFqrTC2Bmt7lXABlxw==
X-CSE-MsgGUID: OnwkfobERiqubgnl1rMGMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914489"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:45 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 08/18] iommufd/device: Replace device_list with device_array
Date: Fri, 21 Mar 2025 10:19:30 -0700
Message-Id: <20250321171940.7213-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321171940.7213-1-yi.l.liu@intel.com>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
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

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 58 +++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6b4764c2d9af..760917f5d764 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -19,7 +19,7 @@ MODULE_PARM_DESC(
 
 struct iommufd_attach {
 	struct iommufd_hw_pagetable *hwpt;
-	struct list_head device_list;
+	struct xarray device_array;
 };
 
 static void iommufd_group_release(struct kref *kref)
@@ -297,6 +297,20 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
+static unsigned int iommufd_group_device_num(struct iommufd_group *igroup)
+{
+	struct iommufd_device *idev;
+	unsigned int count = 0;
+	unsigned long index;
+
+	lockdep_assert_held(&igroup->lock);
+
+	if (igroup->attach)
+		xa_for_each(&igroup->attach->device_array, index, idev)
+			count++;
+	return count;
+}
+
 #ifdef CONFIG_IRQ_MSI_IOMMU
 static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
@@ -371,12 +385,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
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
@@ -510,20 +519,27 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 			rc = -ENOMEM;
 			goto err_unlock;
 		}
-		INIT_LIST_HEAD(&attach->device_list);
+		xa_init(&attach->device_array);
 	}
 
 	old_hwpt = attach->hwpt;
 
+	rc = xa_insert(&attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
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
@@ -541,12 +557,15 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
 	if (iommufd_group_first_attach(igroup, pasid))
 		kfree(attach);
@@ -568,8 +587,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 	hwpt = attach->hwpt;
 	hwpt_paging = find_hwpt_paging(hwpt);
 
-	list_del(&idev->group_item);
-	if (list_empty(&attach->device_list)) {
+	xa_erase(&attach->device_array, idev->obj.id);
+	if (xa_empty(&attach->device_array)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		igroup->attach = NULL;
 		kfree(attach);
@@ -599,10 +618,11 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
 	struct iommufd_device *cur;
+	unsigned long index;
 
 	lockdep_assert_held(&igroup->lock);
 
-	list_for_each_entry(cur, &igroup->attach->device_list, group_item)
+	xa_for_each(&igroup->attach->device_array, index, cur)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
 }
 
@@ -612,14 +632,14 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
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
@@ -660,7 +680,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	old_hwpt = attach->hwpt;
 
-	WARN_ON(!old_hwpt || list_empty(&attach->device_list));
+	WARN_ON(!old_hwpt || xa_empty(&attach->device_array));
 
 	if (!iommufd_device_is_attached(idev)) {
 		rc = -EINVAL;
@@ -689,9 +709,9 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
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

