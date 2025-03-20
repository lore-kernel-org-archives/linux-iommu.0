Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE811204C3A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478471; cv=none; b=Eumee0mE6d2TcnLcb5LTxjTQ6GUlXH/VnTAHLlVIGLa1r/MBNjylx0bFFv81vHUXsCmG9JAjZxp2Da2QxRw9fnAVRr6vGs/hC3zLoUtxjmX2Rq515DuqiczJHq22ZCuu7ekn5QWyRt9ncm7PNe6HxmaesdvjVZKoXYZnPFJApfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478471; c=relaxed/simple;
	bh=/323r85Td3X58JzNb5AqLm+N5m0grWhCaALZdDPCm94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjLRVpneukQlpUY+UY5xdCY3uXxUNN33bKDwnZnNBknkVhRDZNAqvrf9oZ9nGrAiZoMs78RRA3WscixHgZ323yA2HmhUQNhDr66W7nweSOw1/qWaY6pjFnAeJhzWFS1TnTrmteKp3CntqiiHFB/mAMJ7ohIoqIR2lm8CNE/8Ko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ev6oWOJ4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ev6oWOJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478469; x=1774014469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/323r85Td3X58JzNb5AqLm+N5m0grWhCaALZdDPCm94=;
  b=Ev6oWOJ4rV3/MLPCq9SI/0mjVksbBoBzHAG9bBH6ao/Hm70FyUd3F3bw
   mXDuw8eYgyj2yTBenXkalRaO1ME3Vspo27gs+cqkfyiOSBn5yUizKAzJq
   rigHEaa+Xm3+OLje3f9cdprW/ScJa7U87GRDTvS66G4G52yKyy+/Hwh+5
   eMxFj7LwwQDRMN+c70Z89JyBEKhOCTq4DxJ8svy8n1C+De0aOwLt3BC6C
   aH+cqReXJJnhQet0Y7CyaZoD9tpB+WOgt0VYwfwB8JSzeg3IBr0RsyeI/
   sbQ1VT7vT7wI212kJv9P7cM3DvxxaqZHMvcNXJCgd0o1Hmsq1PEjXaFSH
   Q==;
X-CSE-ConnectionGUID: oyKSNp60R+yzu0TeidYHlw==
X-CSE-MsgGUID: /cQvuW6eSHKBCbaS1MfTyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063044"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063044"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:46 -0700
X-CSE-ConnectionGUID: LxLL45ksTOqGagRve8wYKA==
X-CSE-MsgGUID: JpVkgIdoRqqM/9TnUI+GkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319142"
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
Subject: [PATCH v10 03/18] iommufd: Pass @pasid through the device attach/replace path
Date: Thu, 20 Mar 2025 06:47:29 -0700
Message-Id: <20250320134744.5777-4-yi.l.liu@intel.com>
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

Most of the core logic before conducting the actual device attach/
replace operation can be shared with pasid attach/replace. So pass
@pasid through the device attach/replace helpers to prepare adding
pasid attach/replace.

So far the @pasid should only be IOMMU_NO_PASID. No functional change.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 70 +++++++++++++++----------
 drivers/iommu/iommufd/hw_pagetable.c    | 13 ++---
 drivers/iommu/iommufd/iommufd_private.h |  8 +--
 3 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index bd50146e2ad0..3c83fb014dcb 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -483,7 +483,8 @@ static bool iommufd_device_is_attached(struct iommufd_device *idev)
 }
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_device *idev)
+				      struct iommufd_device *idev,
+				      ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 	int rc;
@@ -501,6 +502,7 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	handle->idev = idev;
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
 				       &handle->handle);
 	if (rc)
@@ -517,25 +519,28 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
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
@@ -545,13 +550,17 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
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
@@ -586,7 +595,7 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 }
 
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
-				struct iommufd_device *idev)
+				struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	int rc;
@@ -612,7 +621,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_hwpt_attach_device(hwpt, idev);
+		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -630,7 +639,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 }
 
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_detach(struct iommufd_device *idev)
+iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
@@ -638,7 +647,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommufd_hwpt_detach_device(hwpt, idev);
+		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_paging)
@@ -650,12 +659,12 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
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
@@ -704,7 +713,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 }
 
 static struct iommufd_hw_pagetable *
-iommufd_device_do_replace(struct iommufd_device *idev,
+iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
@@ -738,7 +747,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
+	rc = iommufd_hwpt_replace_device(idev, pasid, hwpt, old_hwpt);
 	if (rc)
 		goto err_unresv;
 
@@ -771,7 +780,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 }
 
 typedef struct iommufd_hw_pagetable *(*attach_fn)(
-	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+	struct iommufd_device *idev, ioasid_t pasid,
+	struct iommufd_hw_pagetable *hwpt);
 
 /*
  * When automatically managing the domains we search for a compatible domain in
@@ -779,7 +789,7 @@ typedef struct iommufd_hw_pagetable *(*attach_fn)(
  * Automatic domain selection will never pick a manually created domain.
  */
 static struct iommufd_hw_pagetable *
-iommufd_device_auto_get_domain(struct iommufd_device *idev,
+iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 			       struct iommufd_ioas *ioas, u32 *pt_id,
 			       attach_fn do_attach)
 {
@@ -808,7 +818,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		hwpt = &hwpt_paging->common;
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt)) {
 			iommufd_put_object(idev->ictx, &hwpt->obj);
 			/*
@@ -826,8 +836,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 
-	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
-						immediate_attach, NULL);
+	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, pasid,
+						0, immediate_attach, NULL);
 	if (IS_ERR(hwpt_paging)) {
 		destroy_hwpt = ERR_CAST(hwpt_paging);
 		goto out_unlock;
@@ -835,7 +845,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt = &hwpt_paging->common;
 
 	if (!immediate_attach) {
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_abort;
 	} else {
@@ -856,8 +866,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
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
@@ -872,7 +883,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -881,8 +892,8 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
-							      do_attach);
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, pasid, ioas,
+							      pt_id, do_attach);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -919,7 +930,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
 	int rc;
 
-	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	rc = iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
+				      &iommufd_device_do_attach);
 	if (rc)
 		return rc;
 
@@ -949,7 +961,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, "IOMMUFD");
  */
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
-	return iommufd_device_change_pt(idev, pt_id,
+	return iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
 					&iommufd_device_do_replace);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, "IOMMUFD");
@@ -965,7 +977,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
-	hwpt = iommufd_hw_pagetable_detach(idev);
+	hwpt = iommufd_hw_pagetable_detach(idev, IOMMU_NO_PASID);
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 9a89f3a28dc5..9bf970b6a1c3 100644
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
index 8cda9c4672eb..1f81cd3787cb 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -366,13 +366,13 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd);
 
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

