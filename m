Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CA1EDA38
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478474; cv=none; b=GWLCzm6SNT352m+bMx6JnuEMZLuRffu88eWlkMCk91A6A+T2CfuItJxzTdA4TOsRdVwiEsmF35cghP+EpJhRG/HruLInfqUcT+n7knvrrhWBPIl6MTb3CetcT+pbHBPS9ZPvrv0GRZSAL2EmTSuG302/lLO9kSEabkrBvC/ncF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478474; c=relaxed/simple;
	bh=6IvhSTJtzw1Ee407dRpIGfZp/rIdtsjjMOCKMXnTL1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBujtl2gv2Hlq8ppYL70bIWCdyybPJ78s5SM+SVnEojhDibi0VyZ+Md51Mo3Gv5sjewmXEF6FmDu0GOn+z6PsVZMndqZB3n7yfc0wcbjBUH8TOQ/0CgwpGBa2aSuEMc1arYYoympJQoeUYXzZF0IzMdUE+hQwHr8qYzNS/IBIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3wMrp6U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3wMrp6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478473; x=1774014473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6IvhSTJtzw1Ee407dRpIGfZp/rIdtsjjMOCKMXnTL1Q=;
  b=a3wMrp6U/eBOnvRUWbLW9Cw527m0WanpeKiOvHisM1ZJ/dQV2A3/w8/y
   PbpqFZJRKTy05Vxqklo8M92dp8as9bRHISxLv7s48Lb3Ap5JR6/SWC9qU
   gNuyEMVADOrgv70LVs6WP0djSg6z9Jim38PsXyZ4M0or7+xr5IW8zA6/B
   lK/qzky50vGy8GM8nVQ2h7BStoquV6cCqzOKVwRQbo1NPuG7BuKtQXjk7
   r6VkyYZ2YIi94yDF0/186D8YlCo78ColBsfnDy3v6RKZJ5eSGT3JIXoTq
   GXel1E0hsxFVWpNp3EFpTLvRsNzWEIyRHip2aP6im7EV4ySup4swInHJd
   Q==;
X-CSE-ConnectionGUID: 1a2VaL6cRlCynxVadhgzHQ==
X-CSE-MsgGUID: Obx225Z7RpCJGanXBXiDGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063063"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063063"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:47 -0700
X-CSE-ConnectionGUID: iowxu3lWRLO5dTpXlHtzqg==
X-CSE-MsgGUID: zCrQPRZPTeSCqI6wFTvRQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319165"
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
Subject: [PATCH v10 09/18] iommufd/device: Add pasid_attach array to track per-PASID attach
Date: Thu, 20 Mar 2025 06:47:35 -0700
Message-Id: <20250320134744.5777-10-yi.l.liu@intel.com>
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

PASIDs of PASID-capable device can be attached to hwpt separately, hence
a pasid array to track per-PASID attachment is necessary. The index
IOMMU_NO_PASID is used by the RID path. Hence drop the igroup->attach.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 68 +++++++++++++++++--------
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ef579b5d463d..370aed636e8d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -28,7 +28,7 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
-	WARN_ON(igroup->attach);
+	WARN_ON(!xa_empty(&igroup->pasid_attach));
 
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
@@ -95,6 +95,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
+	xa_init(&new_igroup->pasid_attach);
 	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
@@ -298,16 +299,19 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
-static int iommufd_group_device_num(struct iommufd_group *igroup)
+static int iommufd_group_device_num(struct iommufd_group *igroup,
+				    ioasid_t pasid)
 {
+	struct iommufd_attach *attach;
 	struct iommufd_device *idev;
 	unsigned long index;
 	int count = 0;
 
 	lockdep_assert_held(&igroup->lock);
 
-	if (igroup->attach)
-		xa_for_each(&igroup->attach->device_array, index, idev)
+	attach = xa_load(&igroup->pasid_attach, pasid);
+	if (attach)
+		xa_for_each(&attach->device_array, index, idev)
 			count++;
 	return count;
 }
@@ -466,7 +470,7 @@ static inline bool
 igroup_first_attach(struct iommufd_group *igroup, ioasid_t pasid)
 {
 	lockdep_assert_held(&igroup->lock);
-	return !igroup->attach;
+	return !xa_load(&igroup->pasid_attach, pasid);
 }
 
 static int
@@ -497,10 +501,13 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
-/* Check if idev is attached to igroup->hwpt */
-static bool iommufd_device_is_attached(struct iommufd_device *idev)
+static bool iommufd_device_is_attached(struct iommufd_device *idev,
+				       ioasid_t pasid)
 {
-	return xa_load(&idev->igroup->attach->device_array, idev->obj.id);
+	struct iommufd_attach *attach;
+
+	attach = xa_load(&idev->igroup->pasid_attach, pasid);
+	return xa_load(&attach->device_array, idev->obj.id);
 }
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
@@ -627,19 +634,25 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 
 	mutex_lock(&igroup->lock);
 
-	attach = igroup->attach;
+	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
+			    XA_ZERO_ENTRY, GFP_KERNEL);
+	if (xa_is_err(attach)) {
+		rc = xa_err(attach);
+		goto err_unlock;
+	}
+
 	if (!attach) {
 		attach = kzalloc(sizeof(*attach), GFP_KERNEL);
 		if (!attach) {
 			rc = -ENOMEM;
-			goto err_unlock;
+			goto err_release_pasid;
 		}
 		xa_init(&attach->device_array);
 	}
 
 	old_hwpt = attach->hwpt;
 
-	rc = xa_insert(&igroup->attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
+	rc = xa_insert(&attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
 		       GFP_KERNEL);
 	if (rc) {
 		WARN_ON(rc == -EBUSY && !old_hwpt);
@@ -669,7 +682,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		if (rc)
 			goto err_unresv;
 		attach->hwpt = hwpt;
-		igroup->attach = attach;
+		WARN_ON(xa_is_err(xa_store(&igroup->pasid_attach, pasid, attach,
+					   GFP_KERNEL)));
 	}
 	refcount_inc(&hwpt->obj.users);
 	WARN_ON(xa_is_err(xa_store(&attach->device_array, idev->obj.id,
@@ -684,6 +698,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 err_free_attach:
 	if (igroup_first_attach(igroup, pasid))
 		kfree(attach);
+err_release_pasid:
+	if (igroup_first_attach(igroup, pasid))
+		xa_release(&igroup->pasid_attach, pasid);
 err_unlock:
 	mutex_unlock(&igroup->lock);
 	return rc;
@@ -698,14 +715,14 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 	struct iommufd_attach *attach;
 
 	mutex_lock(&igroup->lock);
-	attach = igroup->attach;
+	attach = xa_load(&igroup->pasid_attach, pasid);
 	hwpt = attach->hwpt;
 	hwpt_paging = find_hwpt_paging(hwpt);
 
 	xa_erase(&attach->device_array, idev->obj.id);
 	if (xa_empty(&attach->device_array)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
-		igroup->attach = NULL;
+		xa_erase(&igroup->pasid_attach, pasid);
 		kfree(attach);
 	}
 	if (hwpt_paging && pasid == IOMMU_NO_PASID)
@@ -732,12 +749,14 @@ static void
 iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
+	struct iommufd_attach *attach;
 	struct iommufd_device *cur;
 	unsigned long index;
 
 	lockdep_assert_held(&igroup->lock);
 
-	xa_for_each(&igroup->attach->device_array, index, cur)
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	xa_for_each(&attach->device_array, index, cur)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
 }
 
@@ -746,15 +765,17 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 				       struct iommufd_hwpt_paging *hwpt_paging)
 {
 	struct iommufd_hwpt_paging *old_hwpt_paging;
+	struct iommufd_attach *attach;
 	struct iommufd_device *cur;
 	unsigned long index;
 	int rc;
 
 	lockdep_assert_held(&igroup->lock);
 
-	old_hwpt_paging = find_hwpt_paging(igroup->attach->hwpt);
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	old_hwpt_paging = find_hwpt_paging(attach->hwpt);
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
-		xa_for_each(&igroup->attach->device_array, index, cur) {
+		xa_for_each(&attach->device_array, index, cur) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
 			if (rc)
@@ -787,8 +808,15 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	mutex_lock(&igroup->lock);
 
-	attach = igroup->attach;
+	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
+			    XA_ZERO_ENTRY, GFP_KERNEL);
+	if (xa_is_err(attach)) {
+		rc = xa_err(attach);
+		goto err_unlock;
+	}
+
 	if (!attach) {
+		xa_release(&igroup->pasid_attach, pasid);
 		rc = -EINVAL;
 		goto err_unlock;
 	}
@@ -797,7 +825,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	WARN_ON(!old_hwpt || xa_empty(&attach->device_array));
 
-	if (!iommufd_device_is_attached(idev)) {
+	if (!iommufd_device_is_attached(idev, pasid)) {
 		rc = -EINVAL;
 		goto err_unlock;
 	}
@@ -824,7 +852,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	attach->hwpt = hwpt;
 
-	num_devices = iommufd_group_device_num(igroup);
+	num_devices = iommufd_group_device_num(igroup, pasid);
 	/*
 	 * Move the refcounts held by the device_array to the new hwpt. Retain a
 	 * refcount for this thread as the caller will free it.
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 09f5086e37cb..03a231f8f5bf 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -403,7 +403,7 @@ struct iommufd_group {
 	struct mutex lock;
 	struct iommufd_ctx *ictx;
 	struct iommu_group *group;
-	struct iommufd_attach *attach;
+	struct xarray pasid_attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
 };
-- 
2.34.1

