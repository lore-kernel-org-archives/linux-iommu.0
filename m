Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD622AE59
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577588; cv=none; b=dOK0UXtOzEZfqAZ1Za5nv9v32CEHO27184uRWH5hx/DOipH1GsIYYTVkkjw+SdVYwGUdoV+xWACuXr/sR4erUKTpdksYG3uFtsre9L0sxNrzHezZ8WBE2NtqWJB6NGZxiHrpnAzOSK03LHagsnmyt/L39A2vfLXGP1MLJALcII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577588; c=relaxed/simple;
	bh=7Q9J6jlZFaBSOcitKGPC1Dr45u6/lq3TEqB+NXreofo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+4hx0fn4eeK/oYSyCPvjMMpx0nqeTWKCORhbVXiwrqfWBXC33zZ6feVE6lB2W+oXlgLhFn+Fm9BeFB7Uve00LWOlvJrkeW6ZpE405W13hnhtTCvF2NGaetHAqET++2TkAjNMYyhUsLCbaiE3Swvqn/94ytnqYya/OgNjmfh9DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBd7qkfK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBd7qkfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577586; x=1774113586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Q9J6jlZFaBSOcitKGPC1Dr45u6/lq3TEqB+NXreofo=;
  b=GBd7qkfKi8tv2E3rtQFqpIVohOVuSs1omXriBGyyhPI/JnWGoKALxkKq
   sYUCsLWgmliQsPOv4rYYTXDvlaEAUo11LvfagzWce2MUizu15kPg3GiPr
   zZvs4/0wrNUtSoi60u2eZhY9SpcgoCsEutshDQTdsPSMMuX3O5017TNXd
   07lQUY5h/dCEBVr3mHDBzXs1+EWYCd8Zbly/b0YE4oYp9FqMyIvEmrVmB
   k8QIOVfhVRCJV+tLhV5fIm5lr9uNhhU5roi/51ESo5JtBree6P0kdZcHC
   lw8DFJjDCdoezEMQQPVoK18vdQIrTlbNWMbSjWju0lO84SITT/Lm/NgUp
   Q==;
X-CSE-ConnectionGUID: DOkY8uk2SXqMLbgu0pWcCw==
X-CSE-MsgGUID: CDFFLMXXQCmBA00T/3lk+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976789"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976789"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:44 -0700
X-CSE-ConnectionGUID: qx9YFzs9SpGW8QI0sZDKlw==
X-CSE-MsgGUID: YNcvBMg/T1GPc+K9913Cbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914431"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:43 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 03/18] iommufd: Pass @pasid through the device attach/replace path
Date: Fri, 21 Mar 2025 10:19:25 -0700
Message-Id: <20250321171940.7213-4-yi.l.liu@intel.com>
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

Most of the core logic before conducting the actual device attach/
replace operation can be shared with pasid attach/replace. So pass
@pasid through the device attach/replace helpers to prepare adding
pasid attach/replace.

So far the @pasid should only be IOMMU_NO_PASID. No functional change.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 70 +++++++++++++++----------
 drivers/iommu/iommufd/hw_pagetable.c    | 13 ++---
 drivers/iommu/iommufd/iommufd_private.h |  8 +--
 3 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d18ea9a61522..7051feda2fab 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -368,7 +368,8 @@ static bool iommufd_device_is_attached(struct iommufd_device *idev)
 }
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_device *idev)
+				      struct iommufd_device *idev,
+				      ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 	int rc;
@@ -386,6 +387,7 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	handle->idev = idev;
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
 				       &handle->handle);
 	if (rc)
@@ -402,25 +404,28 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 }
 
 static struct iommufd_attach_handle *
-iommufd_device_get_attach_handle(struct iommufd_device *idev)
+iommufd_device_get_attach_handle(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommu_attach_handle *handle;
 
 	lockdep_assert_held(&idev->igroup->lock);
 
 	handle =
-		iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+		iommu_attach_handle_get(idev->igroup->group, pasid, 0);
 	if (IS_ERR(handle))
 		return NULL;
 	return to_iommufd_handle(handle);
 }
 
 static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
-				       struct iommufd_device *idev)
+				       struct iommufd_device *idev,
+				       ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 
-	handle = iommufd_device_get_attach_handle(idev);
+	WARN_ON(pasid != IOMMU_NO_PASID);
+
+	handle = iommufd_device_get_attach_handle(idev, pasid);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
 	if (hwpt->fault) {
 		iommufd_auto_response_faults(hwpt, handle);
@@ -430,13 +435,17 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 }
 
 static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
+				       ioasid_t pasid,
 				       struct iommufd_hw_pagetable *hwpt,
 				       struct iommufd_hw_pagetable *old)
 {
-	struct iommufd_attach_handle *handle, *old_handle =
-		iommufd_device_get_attach_handle(idev);
+	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
+	WARN_ON(pasid != IOMMU_NO_PASID);
+
+	old_handle = iommufd_device_get_attach_handle(idev, pasid);
+
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
@@ -471,7 +480,7 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 }
 
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
-				struct iommufd_device *idev)
+				struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	int rc;
@@ -497,7 +506,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_hwpt_attach_device(hwpt, idev);
+		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -515,7 +524,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 }
 
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_detach(struct iommufd_device *idev)
+iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
@@ -523,7 +532,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommufd_hwpt_detach_device(hwpt, idev);
+		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_paging)
@@ -535,12 +544,12 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 }
 
 static struct iommufd_hw_pagetable *
-iommufd_device_do_attach(struct iommufd_device *idev,
+iommufd_device_do_attach(struct iommufd_device *idev, ioasid_t pasid,
 			 struct iommufd_hw_pagetable *hwpt)
 {
 	int rc;
 
-	rc = iommufd_hw_pagetable_attach(hwpt, idev);
+	rc = iommufd_hw_pagetable_attach(hwpt, idev, pasid);
 	if (rc)
 		return ERR_PTR(rc);
 	return NULL;
@@ -589,7 +598,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 }
 
 static struct iommufd_hw_pagetable *
-iommufd_device_do_replace(struct iommufd_device *idev,
+iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
@@ -623,7 +632,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
+	rc = iommufd_hwpt_replace_device(idev, pasid, hwpt, old_hwpt);
 	if (rc)
 		goto err_unresv;
 
@@ -656,7 +665,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 }
 
 typedef struct iommufd_hw_pagetable *(*attach_fn)(
-	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+	struct iommufd_device *idev, ioasid_t pasid,
+	struct iommufd_hw_pagetable *hwpt);
 
 /*
  * When automatically managing the domains we search for a compatible domain in
@@ -664,7 +674,7 @@ typedef struct iommufd_hw_pagetable *(*attach_fn)(
  * Automatic domain selection will never pick a manually created domain.
  */
 static struct iommufd_hw_pagetable *
-iommufd_device_auto_get_domain(struct iommufd_device *idev,
+iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 			       struct iommufd_ioas *ioas, u32 *pt_id,
 			       attach_fn do_attach)
 {
@@ -693,7 +703,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		hwpt = &hwpt_paging->common;
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt)) {
 			iommufd_put_object(idev->ictx, &hwpt->obj);
 			/*
@@ -711,8 +721,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 
-	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
-						immediate_attach, NULL);
+	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, pasid,
+						0, immediate_attach, NULL);
 	if (IS_ERR(hwpt_paging)) {
 		destroy_hwpt = ERR_CAST(hwpt_paging);
 		goto out_unlock;
@@ -720,7 +730,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt = &hwpt_paging->common;
 
 	if (!immediate_attach) {
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_abort;
 	} else {
@@ -741,8 +751,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	return destroy_hwpt;
 }
 
-static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
-				    attach_fn do_attach)
+static int iommufd_device_change_pt(struct iommufd_device *idev,
+				    ioasid_t pasid,
+				    u32 *pt_id, attach_fn do_attach)
 {
 	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_object *pt_obj;
@@ -757,7 +768,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -766,8 +777,8 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
-							      do_attach);
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, pasid, ioas,
+							      pt_id, do_attach);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -804,7 +815,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
 	int rc;
 
-	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	rc = iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
+				      &iommufd_device_do_attach);
 	if (rc)
 		return rc;
 
@@ -834,7 +846,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, "IOMMUFD");
  */
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
-	return iommufd_device_change_pt(idev, pt_id,
+	return iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
 					&iommufd_device_do_replace);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, "IOMMUFD");
@@ -850,7 +862,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
-	hwpt = iommufd_hw_pagetable_detach(idev);
+	hwpt = iommufd_hw_pagetable_detach(idev, IOMMU_NO_PASID);
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 8e87ae71e128..bd9dd26a5295 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -90,6 +90,7 @@ iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
  * @ictx: iommufd context
  * @ioas: IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
+ * @pasid: PASID to get an iommu_domain for
  * @flags: Flags from userspace
  * @immediate_attach: True if idev should be attached to the hwpt
  * @user_data: The user provided driver specific data describing the domain to
@@ -105,8 +106,8 @@ iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
  */
 struct iommufd_hwpt_paging *
 iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			  struct iommufd_device *idev, u32 flags,
-			  bool immediate_attach,
+			  struct iommufd_device *idev, ioasid_t pasid,
+			  u32 flags, bool immediate_attach,
 			  const struct iommu_user_data *user_data)
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
@@ -189,7 +190,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	 * sequence. Once those drivers are fixed this should be removed.
 	 */
 	if (immediate_attach) {
-		rc = iommufd_hw_pagetable_attach(hwpt, idev);
+		rc = iommufd_hw_pagetable_attach(hwpt, idev, pasid);
 		if (rc)
 			goto out_abort;
 	}
@@ -202,7 +203,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 out_detach:
 	if (immediate_attach)
-		iommufd_hw_pagetable_detach(idev);
+		iommufd_hw_pagetable_detach(idev, pasid);
 out_abort:
 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
@@ -364,8 +365,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
 		mutex_lock(&ioas->mutex);
 		hwpt_paging = iommufd_hwpt_paging_alloc(
-			ucmd->ictx, ioas, idev, cmd->flags, false,
-			user_data.len ? &user_data : NULL);
+			ucmd->ictx, ioas, idev, IOMMU_NO_PASID, cmd->flags,
+			false, user_data.len ? &user_data : NULL);
 		if (IS_ERR(hwpt_paging)) {
 			rc = PTR_ERR(hwpt_paging);
 			goto out_unlock;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8c49ca16919a..891800948d1a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -369,13 +369,13 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd);
 
 struct iommufd_hwpt_paging *
 iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			  struct iommufd_device *idev, u32 flags,
-			  bool immediate_attach,
+			  struct iommufd_device *idev, ioasid_t pasid,
+			  u32 flags, bool immediate_attach,
 			  const struct iommu_user_data *user_data);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
-				struct iommufd_device *idev);
+				struct iommufd_device *idev, ioasid_t pasid);
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_detach(struct iommufd_device *idev);
+iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid);
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj);
 void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
 void iommufd_hwpt_nested_destroy(struct iommufd_object *obj);
-- 
2.34.1

