Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97084266F1A
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869354; cv=none; b=RhlQkgGLDQ8ary9zmmwhWUANCfRJrtKZ3NYyt5pYDiFAhdjofsc4LN5jEVwkD/+PytCXJHRjBdTDAAwlIqHkt/IE1JTT2rxlw2ylNquo4bcDifo7V0SZBIZBcZQrGUHVIBJKQ41TyJKVSwWOV/w6pbnCwDDZCNZhXfCeyQwaKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869354; c=relaxed/simple;
	bh=C1eFuWsP/KGEGjd/AEpq7OSAV2cKWU5xMtLWCX8QY1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=besM1hJwRPEUdsxnE2TZ3eO5BNpIF2eKpxOLrMJYp2tOW4P/jyjYYMkyrfNzo2CZjuUOiZrpC8yzu3w9TjsUiBqSNSVTMGF4X4uL2fcNTIo4O1ZCsSszCYcuVGdGLVmSJACQohlgeQbmJ5qao3s4XTNw3NC59E2dhq6cOzJUQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtG56Zsi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtG56Zsi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869353; x=1773405353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C1eFuWsP/KGEGjd/AEpq7OSAV2cKWU5xMtLWCX8QY1w=;
  b=QtG56Zsi481p6RhW0DY7zOo6F0ZJVLneWagEnFq9jP8i68PszocpcIIo
   JpYAMGtWmDb9cJd2AmtXI+lRIdWmKKH7EbE6i/9eDFozbzOPDCf1I0ZKQ
   6J0SR4ldRdWf38DFZKSTX3bVjzCmrMJ+QeB4H0uS2EERNgMLoCxsD5gfH
   fqbnfi791mfYfNr7aDVDmAvig3eL9HWtpoXA+TEyeoaFGoMMI/0wMTyED
   GBW5xkLk6i2Fsjgp49BWCKZVvCxbQjKZaucmDj/VgCpuSRKBVoDxkWANo
   VY43QDTPMHTZPlDNsDn5qbDMxJpZLgwgNtyQJw086RL82J7Uldp1mM0SB
   Q==;
X-CSE-ConnectionGUID: QT4uLuWSQ16p9t9rGHbVdQ==
X-CSE-MsgGUID: 87TaqiJyS3KkmUEoGiY+2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863962"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863962"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:38 -0700
X-CSE-ConnectionGUID: 8FyZMmSYQTC/hY+cEXaebw==
X-CSE-MsgGUID: xmvZ0vNfRLiu7CZCEylhLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005518"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:38 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 09/21] iommufd/device: Use iommufd_attach_handle track attachment
Date: Thu, 13 Mar 2025 05:35:20 -0700
Message-Id: <20250313123532.103522-10-yi.l.liu@intel.com>
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

Currently, in the RID path, the attached hwpt is stored in igroup->hwpt,
and the attached devices of a group are tracked in igroup->device_list.
However, this setup is insufficient for supporting PASID. PASID allows
a device to be attached on a per-PASID basis, operating in parallel with
the RID path.

To accommodate this, iommufd will require a per-PASID object to track
PASID attachments. This object should include both the attached hwpt and
the device list. The iommufd_attach_handle is a suitable candidate for
this role. It is currently created when the first device of a group is
attached and destroyed when the last device is detached. This lifecycle
aligns well with the requirements for attach tracking.

To initiate the transition, the igroup->hwpt will be moved to the
iommufd_attach_handle. The device_list will be relocated in a separate
commit.

iommufd_device_get_attach_handle() is dropped as iommufd can get handle
from igroup.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 67 +++++++++++--------------
 drivers/iommu/iommufd/iommufd_private.h |  5 +-
 2 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e1f27da65720..9f31fc6acde3 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -23,7 +23,7 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
-	WARN_ON(igroup->hwpt || !list_empty(&igroup->device_list));
+	WARN_ON(igroup->handle || !list_empty(&igroup->device_list));
 
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
@@ -459,7 +459,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	if (rc)
 		return rc;
 
-	if (!igroup->hwpt) {
+	if (!igroup->handle) {
 		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
@@ -472,7 +472,6 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
-/* Check if idev is attached to igroup->hwpt */
 static bool iommufd_device_is_attached(struct iommufd_device *idev)
 {
 	struct iommufd_device *cur;
@@ -512,20 +511,6 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	return rc;
 }
 
-static struct iommufd_attach_handle *
-iommufd_device_get_attach_handle(struct iommufd_device *idev, ioasid_t pasid)
-{
-	struct iommu_attach_handle *handle;
-
-	lockdep_assert_held(&idev->igroup->lock);
-
-	handle =
-		iommu_attach_handle_get(idev->igroup->group, pasid, 0);
-	if (IS_ERR(handle))
-		return NULL;
-	return to_iommufd_handle(handle);
-}
-
 static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 				       struct iommufd_device *idev,
 				       ioasid_t pasid,
@@ -581,17 +566,14 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
 	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hw_pagetable *old_hwpt;
 	struct iommufd_attach_handle *handle;
 	int rc;
 
 	mutex_lock(&igroup->lock);
 
-	if (igroup->hwpt && igroup->hwpt != hwpt) {
-		rc = -EINVAL;
-		goto err_unlock;
-	}
-
-	if (!igroup->hwpt) {
+	handle = igroup->handle;
+	if (!handle) {
 		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 		if (!handle) {
 			rc = -ENOMEM;
@@ -600,6 +582,13 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		handle->idev = idev;
 	}
 
+	old_hwpt = handle->hwpt;
+
+	if (old_hwpt && old_hwpt != hwpt) {
+		rc = -EINVAL;
+		goto err_free_handle;
+	}
+
 	if (attach_resv) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
@@ -617,7 +606,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid, handle);
 		if (rc)
 			goto err_unresv;
-		igroup->hwpt = hwpt;
+		handle->hwpt = hwpt;
+		igroup->handle = handle;
 	}
 	refcount_inc(&hwpt->obj.users);
 	list_add_tail(&idev->group_item, &igroup->device_list);
@@ -627,7 +617,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 err_free_handle:
-	if (!igroup->hwpt)
+	if (!old_hwpt)
 		kfree(handle);
 err_unlock:
 	mutex_unlock(&igroup->lock);
@@ -638,16 +628,18 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_group *igroup = idev->igroup;
-	struct iommufd_hw_pagetable *hwpt = igroup->hwpt;
-	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_attach_handle *handle;
+	struct iommufd_hw_pagetable *hwpt;
 
 	mutex_lock(&igroup->lock);
+	handle = igroup->handle;
+	hwpt = handle->hwpt;
+	hwpt_paging = find_hwpt_paging(hwpt);
 	list_del(&idev->group_item);
 	if (list_empty(&igroup->device_list)) {
-		handle = iommufd_device_get_attach_handle(idev, pasid);
 		iommufd_hwpt_detach_device(hwpt, idev, pasid, handle);
-		igroup->hwpt = NULL;
+		igroup->handle = NULL;
 		kfree(handle);
 	}
 	if (hwpt_paging && pasid == IOMMU_NO_PASID)
@@ -692,7 +684,8 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 
 	lockdep_assert_held(&igroup->lock);
 
-	old_hwpt_paging = find_hwpt_paging(igroup->hwpt);
+	WARN_ON(!igroup->handle);
+	old_hwpt_paging = find_hwpt_paging(igroup->handle->hwpt);
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
@@ -727,7 +720,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	mutex_lock(&igroup->lock);
 
-	if (igroup->hwpt == NULL) {
+	if (!igroup->handle) {
 		rc = -EINVAL;
 		goto err_unlock;
 	}
@@ -737,15 +730,15 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 		goto err_unlock;
 	}
 
-	if (hwpt == igroup->hwpt) {
+	handle = igroup->handle;
+	WARN_ON(!handle);
+	old_hwpt = handle->hwpt;
+
+	if (hwpt == old_hwpt) {
 		mutex_unlock(&igroup->lock);
 		return NULL;
 	}
 
-	handle = iommufd_device_get_attach_handle(idev, pasid);
-	WARN_ON(!handle);
-
-	old_hwpt = igroup->hwpt;
 	if (attach_resv) {
 		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
 		if (rc)
@@ -761,7 +754,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
 		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
 
-	igroup->hwpt = hwpt;
+	handle->hwpt = hwpt;
 
 	num_devices = list_count_nodes(&igroup->device_list);
 	/*
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 488851dab44a..d07ba94e63b3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -396,12 +396,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 	refcount_dec(&hwpt->obj.users);
 }
 
+struct iommufd_attach_handle;
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
 	struct iommufd_ctx *ictx;
 	struct iommu_group *group;
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach_handle *handle;
 	struct list_head device_list;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
@@ -500,6 +502,7 @@ static inline void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
+	struct iommufd_hw_pagetable *hwpt;
 };
 
 /* Convert an iommu attach handle to iommufd handle. */
-- 
2.34.1

