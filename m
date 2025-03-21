Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540F22D798
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577589; cv=none; b=Y3tveDKFGZXMRCLbngOr6n7jO0OfjLDP2GcMVoJDmLO0MZaUS1jvr9cctyPJVYOfxHpi9ugVQwF/JD5OgJ8vlJ2BXmQeAaYAWhvHLyugfGpLvfcBh9hs2KYQEZztXuV0IyGn090lSueiADWQYmYKLbx/4CWFl9guc+WYcUFcKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577589; c=relaxed/simple;
	bh=azxnl3b+sqNITCrd54eU/HWleHoXJmWVAfXq9h9xprk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTH7kDElMq+X6XcAZpLH+RaWY4A5tNUI9HwhjQsrqKSKj3bVkbnQ7RiZ2i299wfjppy5p0ovIlVi1joG1c/MDvK0T8596HPWb4SAHOaG91a8+F5KQvW/q7CWNuoyXnu/gMmWTrv3qLhCQeqxJWk9w2yah5DopDoL45fxTXrosp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gF4VOYWR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gF4VOYWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577588; x=1774113588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azxnl3b+sqNITCrd54eU/HWleHoXJmWVAfXq9h9xprk=;
  b=gF4VOYWR4M5HGikNbrbQEYd0uWVU41ZmT88C4L7g6grt0gir5GR4K91h
   db1oYcwxuGTrFCrBoeiN0fNnhzvsEieLBH3WBPAYwUCICo8aTBNUy5VN6
   cMZtjX6lNkpeK675tZEIEdC7bFN3eLk25HplvAUTAhW3PigxVXoaJhPnV
   ifSMWkOBc4fAO/a2pc8imiO+uCGkM0+Yao5gexh3YMam0EfADhtf+aMBz
   OYg4W+J+0/w201Pkr6TePzB8OMbNDya7J6YRH9Y7KANmB8s/b+9loehTS
   OvblxdALWgv7xSG+qz0Cd2idvf+U8p+OZKtf+ra73Vp27myQX1+u7xhsG
   g==;
X-CSE-ConnectionGUID: nLjH0jlCSc6oTkEmZ4EcTQ==
X-CSE-MsgGUID: 7/UwSYT1RHaMeYUgJisToA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976797"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976797"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:45 -0700
X-CSE-ConnectionGUID: w564FsNrTIuntoxM0SKl/w==
X-CSE-MsgGUID: tpD9Bk80SEGrW/WzoPfkQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914473"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:44 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 05/18] iommufd/device: Replace idev->igroup with local variable
Date: Fri, 21 Mar 2025 10:19:27 -0700
Message-Id: <20250321171940.7213-6-yi.l.liu@intel.com>
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

With more use of the fields of igroup, use a local vairable instead of
using the idev->igroup heavily.

No functional change expected.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 43 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4625f084f7d0..15733b316b70 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -333,18 +333,19 @@ static int
 iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 				    struct iommufd_hwpt_paging *hwpt_paging)
 {
+	struct iommufd_group *igroup = idev->igroup;
 	int rc;
 
-	lockdep_assert_held(&idev->igroup->lock);
+	lockdep_assert_held(&igroup->lock);
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
 						 idev->dev,
-						 &idev->igroup->sw_msi_start);
+						 &igroup->sw_msi_start);
 	if (rc)
 		return rc;
 
-	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_group_setup_msi(idev->igroup, hwpt_paging);
+	if (list_empty(&igroup->device_list)) {
+		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
 						  idev->dev);
@@ -484,11 +485,12 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
+	struct iommufd_group *igroup = idev->igroup;
 	int rc;
 
-	mutex_lock(&idev->igroup->lock);
+	mutex_lock(&igroup->lock);
 
-	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt) {
+	if (igroup->hwpt && igroup->hwpt != hwpt) {
 		rc = -EINVAL;
 		goto err_unlock;
 	}
@@ -506,39 +508,40 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * reserved regions are only updated during individual device
 	 * attachment.
 	 */
-	if (list_empty(&idev->igroup->device_list)) {
+	if (list_empty(&igroup->device_list)) {
 		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
-		idev->igroup->hwpt = hwpt;
+		igroup->hwpt = hwpt;
 	}
 	refcount_inc(&hwpt->obj.users);
-	list_add_tail(&idev->group_item, &idev->igroup->device_list);
-	mutex_unlock(&idev->igroup->lock);
+	list_add_tail(&idev->group_item, &igroup->device_list);
+	mutex_unlock(&igroup->lock);
 	return 0;
 err_unresv:
 	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 err_unlock:
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 	return rc;
 }
 
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
-	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hw_pagetable *hwpt = igroup->hwpt;
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 
-	mutex_lock(&idev->igroup->lock);
+	mutex_lock(&igroup->lock);
 	list_del(&idev->group_item);
-	if (list_empty(&idev->igroup->device_list)) {
+	if (list_empty(&igroup->device_list)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
-		idev->igroup->hwpt = NULL;
+		igroup->hwpt = NULL;
 	}
 	if (hwpt_paging && pasid == IOMMU_NO_PASID)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 
 	/* Caller must destroy hwpt */
 	return hwpt;
@@ -610,7 +613,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	unsigned int num_devices;
 	int rc;
 
-	mutex_lock(&idev->igroup->lock);
+	mutex_lock(&igroup->lock);
 
 	if (igroup->hwpt == NULL) {
 		rc = -EINVAL;
@@ -623,7 +626,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	}
 
 	if (hwpt == igroup->hwpt) {
-		mutex_unlock(&idev->igroup->lock);
+		mutex_unlock(&igroup->lock);
 		return NULL;
 	}
 
@@ -654,7 +657,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	if (num_devices > 1)
 		WARN_ON(refcount_sub_and_test(num_devices - 1,
 					      &old_hwpt->obj.users));
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
@@ -662,7 +665,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	if (attach_resv)
 		iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
 err_unlock:
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 	return ERR_PTR(rc);
 }
 
-- 
2.34.1

