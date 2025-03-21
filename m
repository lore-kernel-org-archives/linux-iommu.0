Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E31EA7DC
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577587; cv=none; b=m7oHC3Nz3wWa3lc+vpLqVDwps6FJBSOtBg2YNfA09IAVwrl+9hCdLaXd4SQyS5Ak1VVECezzTFZuZwY5uKSrx1DYndEzAYRvbpA/VXwo8xz0t/srzNiBoXKIgGW9zKnNjnGtzAjQrn/KaTnQhYQqiSlgUMuJr03qWtWyr1k0n7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577587; c=relaxed/simple;
	bh=5T0CJC9rvIrjh8WNW0BUVKUC/0lxcBIsrFUe/8P2uzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+SKxPRjU6T5dpsVMzod9kdJ6cnU1NjyOoNkQIVtDZ3dF1NPhRdDMlEvYYURLTeKvdy1K25Yy9pNwOG8TSbi+zoCbfZSfOUMPiAIh082Kk494d2b0oD3A9X15FAG+iH5Ksj0Tgg77evnGTZXLDL0rtaTfxM/j6PEKfadvkUy6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPRjth62; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPRjth62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577586; x=1774113586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5T0CJC9rvIrjh8WNW0BUVKUC/0lxcBIsrFUe/8P2uzI=;
  b=mPRjth6242ftBTwuJ2+sGRVFg3SchD76mxLl0aVz5Cq53gUgcLsfkLvJ
   366WOir/E2fv2Na7p3Jtiy2K2J4Z5/n5XDI8kIJKcDZGOAC+BPGnqQbot
   EP4LiFHpGu15aHm3zmVxuvYTZPbV4DLzELlLuNA7xri75LDW3mjq2RGHd
   JGhbBOUfQyzMEhDJAPaTEG3qXMfVA+Sl9IMvMBrWfjvjG2xs+oeEz3lT4
   ICwULzuIrjZ9IJ6oPK1qP5SZFWxgBc2crKLptgeozyuBCMQ7O5eymFVVT
   tc1Kqo6isYZGHEESuDKRhpn/A0FKYwz87UmBrNq2w2hbQFl2MbMmBWkoP
   g==;
X-CSE-ConnectionGUID: CPGDyYfrSLqjog6jF31WWw==
X-CSE-MsgGUID: qsETOqP+RGuYhOlgWaFOUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976792"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976792"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:44 -0700
X-CSE-ConnectionGUID: 294nwd4FRWWkPkJSNfc+jA==
X-CSE-MsgGUID: C++Yxwx5QEyD6p+c2oYbMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914445"
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
Subject: [PATCH v11 04/18] iommufd/device: Only add reserved_iova in non-pasid path
Date: Fri, 21 Mar 2025 10:19:26 -0700
Message-Id: <20250321171940.7213-5-yi.l.liu@intel.com>
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

As the pasid is passed through the attach/replace/detach helpers, it is
necessary to ensure only the non-pasid path adds reserved_iova.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7051feda2fab..4625f084f7d0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -483,6 +483,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
 	int rc;
 
 	mutex_lock(&idev->igroup->lock);
@@ -492,7 +493,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	if (hwpt_paging) {
+	if (attach_resv) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
 			goto err_unlock;
@@ -516,7 +517,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
-	if (hwpt_paging)
+	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
@@ -535,7 +536,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		idev->igroup->hwpt = NULL;
 	}
-	if (hwpt_paging)
+	if (hwpt_paging && pasid == IOMMU_NO_PASID)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 	mutex_unlock(&idev->igroup->lock);
 
@@ -602,6 +603,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
@@ -626,7 +628,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	}
 
 	old_hwpt = igroup->hwpt;
-	if (hwpt_paging) {
+	if (attach_resv) {
 		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
 		if (rc)
 			goto err_unlock;
@@ -637,7 +639,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 		goto err_unresv;
 
 	old_hwpt_paging = find_hwpt_paging(old_hwpt);
-	if (old_hwpt_paging &&
+	if (old_hwpt_paging && pasid == IOMMU_NO_PASID &&
 	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
 		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
 
@@ -657,7 +659,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
 err_unresv:
-	if (hwpt_paging)
+	if (attach_resv)
 		iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
-- 
2.34.1

