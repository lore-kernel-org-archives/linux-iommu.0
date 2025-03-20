Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E44221726
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478472; cv=none; b=rZ3gwy6bNH9obCpYertdBvXGdftYHCGPac6VqK3q6Qis2NoEtwGbeDoRS7EDFf9a+vxIffTZFrF2n1E7rd2gguKP0eOXwAmj3sn4mbcJ+eINeNnpFTnNkeZhKiJIuf4yrxVrabX/6nDzDZTbRkZPf5pYvEbkqaGwmcr4kWp6zW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478472; c=relaxed/simple;
	bh=VUe49AGgk3lnIrNTsqCXmsFxTaC/jydnlVEwzzl0sTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=it/7VCdlXpr7W3QJD8C6guJG/j7ImMummPlbFmIUn8Te0gviSzYW5OwDwG5aOYgbZnbXHACpR27MQisIYuXKr+q08tJiFxxuPsAI6OxMkRjl5XUBz4j0fpnYn7fWzgkUzO9IWJ8fi9ipdqcTZDF++gyS1LXKJ8HLkHEvtdihw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2eGcQNj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2eGcQNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478470; x=1774014470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUe49AGgk3lnIrNTsqCXmsFxTaC/jydnlVEwzzl0sTY=;
  b=m2eGcQNjJc298/t3TDMFTgZ/hUHOrPKk66ywiFHrgNKDV1kvfY6P819F
   ELpAaWnlolwxaZZvD7ucoJiY/tWB+Hoq6/DsRHgI1TXMD1Z9+c2G9oRYL
   5kNm3oEjYuLmXo550Ql2r2BVVA9HPZgf8r1Ttp6uBLFo7eJsaBZQu8JIU
   +zZBw28skUkfo7W/oEePB6BXnxfVAoAnDsrck3jFpmvdGE5DqnIoVssKX
   29rlVG8qUrSPLaeUcCch6d+gKmrgmwAVMHQpl4rOqUDFLpQKJ8XIwRjLV
   SfvHX+775EARmVQiudsX+uDiQI4fR+nYjkOV1LllCqCJjZeUYKsIGmCse
   A==;
X-CSE-ConnectionGUID: /2OrSoHYQpasolcEkF+Dzw==
X-CSE-MsgGUID: UjI1XUcgSXm4obz/6dFlNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063050"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063050"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:47 -0700
X-CSE-ConnectionGUID: Gwt58Wt7R3CJmrYLYZKgRQ==
X-CSE-MsgGUID: ER3vcN+sTVSsqn54/aXr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319151"
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
Subject: [PATCH v10 05/18] iommufd/device: Replace idev->igroup with local variable
Date: Thu, 20 Mar 2025 06:47:31 -0700
Message-Id: <20250320134744.5777-6-yi.l.liu@intel.com>
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

With more use of the fields of igroup, use a local vairable instead of
using the idev->igroup heavily.

No functional change expected.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 43 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index be5226d2883e..ac54d734b819 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -448,18 +448,19 @@ static int
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
@@ -599,11 +600,12 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
@@ -621,39 +623,40 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
@@ -725,7 +728,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	unsigned int num_devices;
 	int rc;
 
-	mutex_lock(&idev->igroup->lock);
+	mutex_lock(&igroup->lock);
 
 	if (igroup->hwpt == NULL) {
 		rc = -EINVAL;
@@ -738,7 +741,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	}
 
 	if (hwpt == igroup->hwpt) {
-		mutex_unlock(&idev->igroup->lock);
+		mutex_unlock(&igroup->lock);
 		return NULL;
 	}
 
@@ -769,7 +772,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	if (num_devices > 1)
 		WARN_ON(refcount_sub_and_test(num_devices - 1,
 					      &old_hwpt->obj.users));
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
@@ -777,7 +780,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	if (attach_resv)
 		iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
 err_unlock:
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 	return ERR_PTR(rc);
 }
 
-- 
2.34.1

