Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8CBE49
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677955; cv=none; b=dgD2gOwWRv4YCIj9ayfkLgm7g98JrfkoBnv3wUgY54dYJ1dfIxAXPw3uc/r3MdqM23jsxrDpeSARWvTWXHjpoGadldjV0xTxZQRHZ1jmYhivIx+PvM9hx92VeVl/t7OnumtcJI983c3N/fUHyoTKV7IL1nWekazWQ/yZPW+c3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677955; c=relaxed/simple;
	bh=X3EvKlObj3zn8zY2bW5xKBMXdbn2fuvq2W93FiR7orY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Picchotxs+9z68jZSv4sjQf7e/CWtUxrr7DYVH3rhM3MBq1Y1wJGbE/EgPhw3fOYdawpRprNfNnBH/lr0NXkw/tzWmbo+61yeHrwC4hEmwtJfyWtSI0E0ZOBDDUpOSkIBT/QP93OVUQi8bbs00xe7TfaBsz+LqCJXpt3CVf1+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKEsj2L6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKEsj2L6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677953; x=1771213953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3EvKlObj3zn8zY2bW5xKBMXdbn2fuvq2W93FiR7orY=;
  b=EKEsj2L6h2Iqw2Etd7tZ0Vj3mh+yZupZBTIoG8crshMNWtRv/lKjtfQg
   HF3955I0Tz9rNvHhNkM/KK6qrGGYfSxDdkzWenl94vItZl0qRVv4Yz8sD
   e6ZBvyWzEKTFF8bH1WiPPdM4MU0mZfuzF4hwbc1XFAUPwEuUxXy5nNt+D
   WpDCbH6oeaZj4snElvsfGBU6rVnumyF6Fh+tt9P5c0TtYwPfdOmocevHi
   S4RlRwvyXNXjg+vlbtlvcwlz8ltBRUHF0WZ35Bp+/rWyGU97OOQBml8Y/
   0TUNTyWRtPr1+D3cRNAEDBXnw4Gw+QZtovz43wI5Uxh9UKTvwzLRfPCI/
   g==;
X-CSE-ConnectionGUID: tVkeRCUwTZe1ytaPSkdk4A==
X-CSE-MsgGUID: F32qIkf6TaayeyV249k9cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919308"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919308"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:32 -0800
X-CSE-ConnectionGUID: JXoW0OgvRhWP6k7lyuE3cA==
X-CSE-MsgGUID: Pb5XVrWgQpaInhtGBiD5HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544667"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 15 Feb 2025 19:52:33 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v7 03/13] iommufd: Pass @pasid through the device attach/replace path
Date: Sat, 15 Feb 2025 19:52:18 -0800
Message-Id: <20250216035228.23831-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216035228.23831-1-yi.l.liu@intel.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
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
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 67 +++++++++++++++----------
 drivers/iommu/iommufd/hw_pagetable.c    |  5 +-
 drivers/iommu/iommufd/iommufd_private.h |  5 +-
 3 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0786290b4056..6ec7f6935115 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -355,7 +355,8 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 /* The device attach/detach/replace helpers for attach_handle */
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_device *idev)
+				      struct iommufd_device *idev,
+				      ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 	int rc;
@@ -373,6 +374,7 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	handle->idev = idev;
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
 				       &handle->handle);
 	if (rc)
@@ -389,25 +391,28 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
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
@@ -417,13 +422,17 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
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
@@ -458,7 +467,8 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 }
 
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
-				struct iommufd_device *idev)
+				struct iommufd_device *idev,
+				ioasid_t pasid)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	int rc;
@@ -484,7 +494,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_hwpt_attach_device(hwpt, idev);
+		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -502,7 +512,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 }
 
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_detach(struct iommufd_device *idev)
+iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
@@ -510,7 +520,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommufd_hwpt_detach_device(hwpt, idev);
+		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_paging)
@@ -522,12 +532,12 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
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
@@ -576,7 +586,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 }
 
 static struct iommufd_hw_pagetable *
-iommufd_device_do_replace(struct iommufd_device *idev,
+iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
@@ -605,7 +615,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
+	rc = iommufd_hwpt_replace_device(idev, pasid, hwpt, old_hwpt);
 	if (rc)
 		goto err_unresv;
 
@@ -638,7 +648,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 }
 
 typedef struct iommufd_hw_pagetable *(*attach_fn)(
-	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+	struct iommufd_device *idev, ioasid_t pasid,
+	struct iommufd_hw_pagetable *hwpt);
 
 /*
  * When automatically managing the domains we search for a compatible domain in
@@ -646,7 +657,7 @@ typedef struct iommufd_hw_pagetable *(*attach_fn)(
  * Automatic domain selection will never pick a manually created domain.
  */
 static struct iommufd_hw_pagetable *
-iommufd_device_auto_get_domain(struct iommufd_device *idev,
+iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 			       struct iommufd_ioas *ioas, u32 *pt_id,
 			       attach_fn do_attach)
 {
@@ -675,7 +686,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		hwpt = &hwpt_paging->common;
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt)) {
 			iommufd_put_object(idev->ictx, &hwpt->obj);
 			/*
@@ -702,7 +713,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt = &hwpt_paging->common;
 
 	if (!immediate_attach) {
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_abort;
 	} else {
@@ -723,8 +734,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
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
@@ -739,7 +751,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -748,8 +760,8 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
-							      do_attach);
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, pasid, ioas,
+							      pt_id, do_attach);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -786,7 +798,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
 	int rc;
 
-	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	rc = iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
+				      &iommufd_device_do_attach);
 	if (rc)
 		return rc;
 
@@ -816,7 +829,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, "IOMMUFD");
  */
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
-	return iommufd_device_change_pt(idev, pt_id,
+	return iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
 					&iommufd_device_do_replace);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, "IOMMUFD");
@@ -832,7 +845,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
-	hwpt = iommufd_hw_pagetable_detach(idev);
+	hwpt = iommufd_hw_pagetable_detach(idev, IOMMU_NO_PASID);
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 598be26a14e2..af2b72647d5a 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -184,7 +184,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	 * sequence. Once those drivers are fixed this should be removed.
 	 */
 	if (immediate_attach) {
-		rc = iommufd_hw_pagetable_attach(hwpt, idev);
+		/* Sinc this is just a trick, so passing IOMMU_NO_PASID is enough */
+		rc = iommufd_hw_pagetable_attach(hwpt, idev, IOMMU_NO_PASID);
 		if (rc)
 			goto out_abort;
 	}
@@ -197,7 +198,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 out_detach:
 	if (immediate_attach)
-		iommufd_hw_pagetable_detach(idev);
+		iommufd_hw_pagetable_detach(idev, IOMMU_NO_PASID);
 out_abort:
 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8e0e3ab64747..193ee8a3d5f9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -350,9 +350,10 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  bool immediate_attach,
 			  const struct iommu_user_data *user_data);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
-				struct iommufd_device *idev);
+				struct iommufd_device *idev,
+				ioasid_t pasid);
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_detach(struct iommufd_device *idev);
+iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid);
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj);
 void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
 void iommufd_hwpt_nested_destroy(struct iommufd_object *obj);
-- 
2.34.1

