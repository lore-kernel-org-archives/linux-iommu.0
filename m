Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9157225785
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614875; cv=none; b=S6c32XxFYDPB8pXJf78cy3UhuK1WFgvyhevpie9MSf3D/fml4tGtysKwAC0fuVwAcw1+5Cpcc06Gaw8nQqBGQaq7RnIQyFHt/pNz7hHRuISdyNHjFNaawEhekW88eIKUYwQ8rUWiSC/RmsJmYQviwmzIyKnXKfVd2NIKuPlgi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614875; c=relaxed/simple;
	bh=tbJUGDuAwDeeWPqTI4ksKwcHsrYA3di2JeEuHX9jhfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KZNM/+zJHmsDN2W8N0Nj682bt9XJOAFXN0isuA4w/hmIR+VzGFdcHzfOT+MvM5+IlzgJ7HXZsZEOsTgL0Ty5I/tb6XCB9YmRYH5c2qBNUkEjoxwp2PVSPtKd4W410CqlIib/J4rBZNOsy4p4f1POCaezwAzyoAY931oWO/itWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTMWpS2z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTMWpS2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614873; x=1766150873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tbJUGDuAwDeeWPqTI4ksKwcHsrYA3di2JeEuHX9jhfw=;
  b=VTMWpS2zWemHVRJZ/mGAZ+dfqFWo2vEpN/ZH/Qd2yNxjtPra645/WMOV
   h2HmnAxf2e9h8ipSTN16L7FULkduhsVCDY0akdII5tPWmBCh7CteC191e
   Kmj3uj6BLqWdDBxusj8V+zzDRkPyl6ZULbR0ryJ+VWmbOMQVBOJhWmhhQ
   17sOWP1Cff1eNZaIdGhVoqIDchW7gbbCFH+RSGnKE0+00i1s1KqnYl8Oe
   5UfuCP1gAUOqdQ2Snd42nQ4fbeAkJm4WfwArfcjKI8EjsfCXFibJQR4k9
   jM0gdhXcpRHulomB7SWCnCkM/+YQmnl11/w/166PVWknfWPZKruUeHkgL
   Q==;
X-CSE-ConnectionGUID: 7Cv/OZu7T7mXRpn4H+vBzQ==
X-CSE-MsgGUID: 8PTqTKUQRN+EphxjS1zgig==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542274"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542274"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:50 -0800
X-CSE-ConnectionGUID: Vc8FahbfRaiLjOEyaDjh9w==
X-CSE-MsgGUID: 36A2EkQcRGKOt1175QN+eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177317"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:50 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 05/14] iommufd: Pass pasid through the device attach/replace path
Date: Thu, 19 Dec 2024 05:27:37 -0800
Message-Id: <20241219132746.16193-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the core logic before conducting the actual device attach/
replace operation can be shared with pasid attach/replace. So pass
pasid through the device attach/replace helpers to prepare adding
pasid attach/replace.

So far the @pasid should only be IOMMU_NO_PASID. No functional change.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 57 ++++++++++++++-----------
 drivers/iommu/iommufd/fault.c           | 16 ++++---
 drivers/iommu/iommufd/hw_pagetable.c    |  5 ++-
 drivers/iommu/iommufd/iommufd_private.h | 41 +++++++++++-------
 4 files changed, 72 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0e1baf84e887..c22ef4077348 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -294,9 +294,10 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
 /**
- * iommufd_device_get_attach_handle - Return the attach handle for the RID
+ * iommufd_device_get_attach_handle - Return the attach handle for the RID/PASID
  *
  * @idev: The device to get attach_handle
+ * @pasid: The pasid of the device to get attach_handle
  *
  * Currently there is no locking to synchronize threads that access the
  * returned handle with those attaching or replacing the domain which might
@@ -305,11 +306,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
  * Return valid attach_handle if there is, otherwise NULL.
  */
 struct iommufd_attach_handle *
-iommufd_device_get_attach_handle(struct iommufd_device *idev)
+iommufd_device_get_attach_handle(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommu_attach_handle *handle;
 
-	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	handle = iommu_attach_handle_get(idev->igroup->group, pasid, 0);
 	if (IS_ERR(handle))
 		return NULL;
 
@@ -317,7 +318,8 @@ iommufd_device_get_attach_handle(struct iommufd_device *idev)
 }
 
 int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
-			      struct iommufd_device *idev)
+			      struct iommufd_device *idev,
+			      ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 	int ret;
@@ -327,6 +329,7 @@ int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
 		return -ENOMEM;
 
 	handle->idev = idev;
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
 					&handle->handle);
 	if (ret)
@@ -336,6 +339,7 @@ int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
 }
 
 int iommufd_dev_replace_handle(struct iommufd_device *idev,
+			       ioasid_t pasid,
 			       struct iommufd_hw_pagetable *hwpt,
 			       struct iommufd_hw_pagetable *old)
 {
@@ -347,6 +351,7 @@ int iommufd_dev_replace_handle(struct iommufd_device *idev,
 		return -ENOMEM;
 
 	handle->idev = idev;
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	ret = iommu_replace_group_handle(idev->igroup->group,
 					 hwpt->domain, &handle->handle);
 	if (ret)
@@ -415,7 +420,8 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 }
 
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
-				struct iommufd_device *idev)
+				struct iommufd_device *idev,
+				ioasid_t pasid)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	int rc;
@@ -441,7 +447,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_hwpt_attach_device(hwpt, idev);
+		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -459,7 +465,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 }
 
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_detach(struct iommufd_device *idev)
+iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
@@ -467,7 +473,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommufd_hwpt_detach_device(hwpt, idev);
+		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_paging)
@@ -479,12 +485,12 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
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
@@ -533,7 +539,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 }
 
 static struct iommufd_hw_pagetable *
-iommufd_device_do_replace(struct iommufd_device *idev,
+iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
@@ -562,7 +568,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
+	rc = iommufd_hwpt_replace_device(idev, pasid, hwpt, old_hwpt);
 	if (rc)
 		goto err_unresv;
 
@@ -595,7 +601,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 }
 
 typedef struct iommufd_hw_pagetable *(*attach_fn)(
-	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+			struct iommufd_device *idev, ioasid_t pasid,
+			struct iommufd_hw_pagetable *hwpt);
 
 /*
  * When automatically managing the domains we search for a compatible domain in
@@ -603,7 +610,7 @@ typedef struct iommufd_hw_pagetable *(*attach_fn)(
  * Automatic domain selection will never pick a manually created domain.
  */
 static struct iommufd_hw_pagetable *
-iommufd_device_auto_get_domain(struct iommufd_device *idev,
+iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 			       struct iommufd_ioas *ioas, u32 *pt_id,
 			       attach_fn do_attach)
 {
@@ -632,7 +639,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		hwpt = &hwpt_paging->common;
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt)) {
 			iommufd_put_object(idev->ictx, &hwpt->obj);
 			/*
@@ -659,7 +666,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt = &hwpt_paging->common;
 
 	if (!immediate_attach) {
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_abort;
 	} else {
@@ -680,8 +687,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
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
@@ -696,7 +704,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -705,8 +713,8 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
-							      do_attach);
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, pasid, ioas,
+							      pt_id, do_attach);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -743,7 +751,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
 	int rc;
 
-	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	rc = iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
+				      &iommufd_device_do_attach);
 	if (rc)
 		return rc;
 
@@ -773,7 +782,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, "IOMMUFD");
  */
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
-	return iommufd_device_change_pt(idev, pt_id,
+	return iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
 					&iommufd_device_do_replace);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, "IOMMUFD");
@@ -789,7 +798,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
-	hwpt = iommufd_hw_pagetable_detach(idev);
+	hwpt = iommufd_hw_pagetable_detach(idev, IOMMU_NO_PASID);
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 19f6e2b84274..99d58df8f6db 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -61,7 +61,8 @@ static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
 }
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev)
+				    struct iommufd_device *idev,
+				    ioasid_t pasid)
 {
 	int ret;
 
@@ -72,7 +73,7 @@ int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 	if (ret)
 		return ret;
 
-	ret = iommufd_dev_attach_handle(hwpt, idev);
+	ret = iommufd_dev_attach_handle(hwpt, idev, pasid);
 	if (ret)
 		iommufd_fault_iopf_disable(idev);
 
@@ -109,11 +110,13 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 }
 
 void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
+				     struct iommufd_device *idev,
+				     ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 
-	handle = iommufd_device_get_attach_handle(idev);
+	handle = iommufd_device_get_attach_handle(idev, pasid);
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
 	iommufd_auto_response_faults(hwpt, handle);
 	iommufd_fault_iopf_disable(idev);
@@ -121,6 +124,7 @@ void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 }
 
 int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     ioasid_t pasid,
 				     struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_hw_pagetable *old)
 {
@@ -135,9 +139,9 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 			return ret;
 	}
 
-	curr = iommufd_device_get_attach_handle(idev);
+	curr = iommufd_device_get_attach_handle(idev, pasid);
 
-	ret = iommufd_dev_replace_handle(idev, hwpt, old);
+	ret = iommufd_dev_replace_handle(idev, pasid, hwpt, old);
 	if (ret) {
 		if (iopf_on)
 			iommufd_fault_iopf_disable(idev);
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
index 6cf9c1f10e85..6d4e743ea8fe 100644
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
@@ -460,10 +461,12 @@ struct iommufd_attach_handle {
 #define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
 
 struct iommufd_attach_handle *
-iommufd_device_get_attach_handle(struct iommufd_device *idev);
+iommufd_device_get_attach_handle(struct iommufd_device *idev, ioasid_t pasid);
 int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
-			      struct iommufd_device *idev);
+			      struct iommufd_device *idev,
+			      ioasid_t pasid);
 int iommufd_dev_replace_handle(struct iommufd_device *idev,
+			       ioasid_t pasid,
 			       struct iommufd_hw_pagetable *hwpt,
 			       struct iommufd_hw_pagetable *old);
 
@@ -480,38 +483,45 @@ void iommufd_fault_destroy(struct iommufd_object *obj);
 int iommufd_fault_iopf_handler(struct iopf_group *group);
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev);
+				    struct iommufd_device *idev,
+				    ioasid_t pasid);
 void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev);
+				     struct iommufd_device *idev,
+				     ioasid_t pasid);
 int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     ioasid_t pasid,
 				     struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_hw_pagetable *old);
 
 static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
-					     struct iommufd_device *idev)
+					     struct iommufd_device *idev,
+					     ioasid_t pasid)
 {
 	if (hwpt->fault)
-		return iommufd_fault_domain_attach_dev(hwpt, idev);
+		return iommufd_fault_domain_attach_dev(hwpt, idev, pasid);
 
-	return iommufd_dev_attach_handle(hwpt, idev);
+	return iommufd_dev_attach_handle(hwpt, idev, pasid);
 }
 
 static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
-					      struct iommufd_device *idev)
+					      struct iommufd_device *idev,
+					      ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 
 	if (hwpt->fault) {
-		iommufd_fault_domain_detach_dev(hwpt, idev);
+		iommufd_fault_domain_detach_dev(hwpt, idev, pasid);
 		return;
 	}
 
-	handle = iommufd_device_get_attach_handle(idev);
+	handle = iommufd_device_get_attach_handle(idev, pasid);
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
 	kfree(handle);
 }
 
 static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
+					      ioasid_t pasid,
 					      struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_hw_pagetable *old)
 {
@@ -519,11 +529,12 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	int ret;
 
 	if (old->fault || hwpt->fault)
-		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
+		return iommufd_fault_domain_replace_dev(idev, pasid,
+							hwpt, old);
 
-	curr = iommufd_device_get_attach_handle(idev);
+	curr = iommufd_device_get_attach_handle(idev, pasid);
 
-	ret = iommufd_dev_replace_handle(idev, hwpt, old);
+	ret = iommufd_dev_replace_handle(idev, pasid, hwpt, old);
 	if (ret)
 		return ret;
 
-- 
2.34.1

