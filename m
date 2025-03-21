Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAC22D7A4
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577590; cv=none; b=A6zeVa5EJFgQ7HDwK8HvynFL+LFeMPaEyulaybEtLxFL+Ly+GpIat1x3qenAX32cpQgzCfLawOpulLpHskuENHWvwFo4r6fFf1CpnaQYKVP/Lwj0SlfWAR6M9ufpPXCF1V3gAvGoJ34bYQhFmHJLtAzxN0HEcARMmOfvFMa9Pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577590; c=relaxed/simple;
	bh=E63T76SMmxZzx+V4WsBcBpODEHNeKfrkgrR9EwcJZaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQTPJaTP8/Mi6fWeLm8UamtiPq35xLUEDlcLdIBbQFX3su8UhCCv7hF2evljb0w2gfOtd70W5ECGHekqUO86N4E7ieAlIVk03GVaAljSVOCtjoZQcofWyjnSv/ytAsP7KLFmREg6S279+Jb3wqqCmZheua8vvGQ8urrjZUZXijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YetGWRwq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YetGWRwq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577589; x=1774113589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E63T76SMmxZzx+V4WsBcBpODEHNeKfrkgrR9EwcJZaE=;
  b=YetGWRwqhTsenHsdfIJ6aRIiXp1whBo1jWUpRI6tRs7ncarJcsQw3ro1
   QvsOQl9m1VPDZH96jno/PPSjnbJv0t0hTQSMli1enpYgo2ftzDaUoG2tP
   mevYlIlZz1KBhuI+QzAt4Oz4Pr24Ajz+hEy/S8Y1tFhGcbqvlfrZm1bgE
   OXnTzSF1iumTBCaNmXjDwRxaTDnTrrJKeAk6k+u6K7yIIM+C12A8tU/YO
   HYLZBF5aaFflHpCTzW/NNh5XtLqB/Zo6HGeIYi2XztCFyKkYOt+t8xjp0
   JZyVs7PWDTFvrA9xMteJxmXBbTbonuCvBLfPOdc3ysm4drI0xiEdrRM0F
   A==;
X-CSE-ConnectionGUID: ritPG4t2QtKJy/7hPmgjwg==
X-CSE-MsgGUID: guRpvt4LQrepADanjEEclA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976805"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976805"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:45 -0700
X-CSE-ConnectionGUID: mpSQucD4TAWVeOaKYDvuvw==
X-CSE-MsgGUID: e6epOq8dQdqG/x3bHxnPqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914484"
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
Subject: [PATCH v11 07/18] iommufd/device: Wrap igroup->hwpt and igroup->device_list into attach struct
Date: Fri, 21 Mar 2025 10:19:29 -0700
Message-Id: <20250321171940.7213-8-yi.l.liu@intel.com>
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

The igroup->hwpt and igroup->device_list are used to track the hwpt attach
of a group in the RID path. While the coming PASID path also needs such
tracking. To be prepared, wrap igroup->hwpt and igroup->device_list into
attach struct which is allocated per attaching the first device of the
group and freed per detaching the last device of the group.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 76 ++++++++++++++++++-------
 drivers/iommu/iommufd/iommufd_private.h |  5 +-
 2 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2cc3c12d301d..6b4764c2d9af 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -17,12 +17,17 @@ MODULE_PARM_DESC(
 	"Allow IOMMUFD to bind to devices even if the platform cannot isolate "
 	"the MSI interrupt window. Enabling this is a security weakness.");
 
+struct iommufd_attach {
+	struct iommufd_hw_pagetable *hwpt;
+	struct list_head device_list;
+};
+
 static void iommufd_group_release(struct kref *kref)
 {
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
-	WARN_ON(igroup->hwpt || !list_empty(&igroup->device_list));
+	WARN_ON(igroup->attach);
 
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
@@ -89,7 +94,6 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
-	INIT_LIST_HEAD(&new_igroup->device_list);
 	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
@@ -333,7 +337,7 @@ static bool
 iommufd_group_first_attach(struct iommufd_group *igroup, ioasid_t pasid)
 {
 	lockdep_assert_held(&igroup->lock);
-	return !igroup->hwpt;
+	return !igroup->attach;
 }
 
 static int
@@ -369,7 +373,7 @@ static bool iommufd_device_is_attached(struct iommufd_device *idev)
 {
 	struct iommufd_device *cur;
 
-	list_for_each_entry(cur, &idev->igroup->device_list, group_item)
+	list_for_each_entry(cur, &idev->igroup->attach->device_list, group_item)
 		if (cur == idev)
 			return true;
 	return false;
@@ -493,19 +497,33 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
 	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hw_pagetable *old_hwpt;
+	struct iommufd_attach *attach;
 	int rc;
 
 	mutex_lock(&igroup->lock);
 
-	if (igroup->hwpt && igroup->hwpt != hwpt) {
+	attach = igroup->attach;
+	if (!attach) {
+		attach = kzalloc(sizeof(*attach), GFP_KERNEL);
+		if (!attach) {
+			rc = -ENOMEM;
+			goto err_unlock;
+		}
+		INIT_LIST_HEAD(&attach->device_list);
+	}
+
+	old_hwpt = attach->hwpt;
+
+	if (old_hwpt && old_hwpt != hwpt) {
 		rc = -EINVAL;
-		goto err_unlock;
+		goto err_free_attach;
 	}
 
 	if (attach_resv) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
-			goto err_unlock;
+			goto err_free_attach;
 	}
 
 	/*
@@ -519,15 +537,19 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
-		igroup->hwpt = hwpt;
+		attach->hwpt = hwpt;
+		igroup->attach = attach;
 	}
 	refcount_inc(&hwpt->obj.users);
-	list_add_tail(&idev->group_item, &igroup->device_list);
+	list_add_tail(&idev->group_item, &attach->device_list);
 	mutex_unlock(&igroup->lock);
 	return 0;
 err_unresv:
 	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
+err_free_attach:
+	if (iommufd_group_first_attach(igroup, pasid))
+		kfree(attach);
 err_unlock:
 	mutex_unlock(&igroup->lock);
 	return rc;
@@ -537,14 +559,20 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_group *igroup = idev->igroup;
-	struct iommufd_hw_pagetable *hwpt = igroup->hwpt;
-	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_attach *attach;
 
 	mutex_lock(&igroup->lock);
+	attach = igroup->attach;
+	hwpt = attach->hwpt;
+	hwpt_paging = find_hwpt_paging(hwpt);
+
 	list_del(&idev->group_item);
-	if (list_empty(&igroup->device_list)) {
+	if (list_empty(&attach->device_list)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
-		igroup->hwpt = NULL;
+		igroup->attach = NULL;
+		kfree(attach);
 	}
 	if (hwpt_paging && pasid == IOMMU_NO_PASID)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
@@ -574,7 +602,7 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 
 	lockdep_assert_held(&igroup->lock);
 
-	list_for_each_entry(cur, &igroup->device_list, group_item)
+	list_for_each_entry(cur, &igroup->attach->device_list, group_item)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
 }
 
@@ -588,9 +616,10 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 
 	lockdep_assert_held(&igroup->lock);
 
-	old_hwpt_paging = find_hwpt_paging(igroup->hwpt);
+	old_hwpt_paging = find_hwpt_paging(igroup->attach->hwpt);
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
-		list_for_each_entry(cur, &igroup->device_list, group_item) {
+		list_for_each_entry(cur,
+				    &igroup->attach->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
 			if (rc)
@@ -617,27 +646,32 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
+	struct iommufd_attach *attach;
 	unsigned int num_devices;
 	int rc;
 
 	mutex_lock(&igroup->lock);
 
-	if (igroup->hwpt == NULL) {
+	attach = igroup->attach;
+	if (!attach) {
 		rc = -EINVAL;
 		goto err_unlock;
 	}
 
+	old_hwpt = attach->hwpt;
+
+	WARN_ON(!old_hwpt || list_empty(&attach->device_list));
+
 	if (!iommufd_device_is_attached(idev)) {
 		rc = -EINVAL;
 		goto err_unlock;
 	}
 
-	if (hwpt == igroup->hwpt) {
+	if (hwpt == old_hwpt) {
 		mutex_unlock(&igroup->lock);
 		return NULL;
 	}
 
-	old_hwpt = igroup->hwpt;
 	if (attach_resv) {
 		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
 		if (rc)
@@ -653,9 +687,9 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
 		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
 
-	igroup->hwpt = hwpt;
+	attach->hwpt = hwpt;
 
-	num_devices = list_count_nodes(&igroup->device_list);
+	num_devices = list_count_nodes(&attach->device_list);
 	/*
 	 * Move the refcounts held by the device_list to the new hwpt. Retain a
 	 * refcount for this thread as the caller will free it.
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 891800948d1a..5b4d8962166b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -399,13 +399,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 	refcount_dec(&hwpt->obj.users);
 }
 
+struct iommufd_attach;
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
 	struct iommufd_ctx *ictx;
 	struct iommu_group *group;
-	struct iommufd_hw_pagetable *hwpt;
-	struct list_head device_list;
+	struct iommufd_attach *attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
 };
-- 
2.34.1

