Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDDD215769
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570040; cv=none; b=QuA8288K1s2Z147Uxp5DC7gjWU1db84rq1CPFO7eKAf78QgALCXebOwGt+t2wBm7LZf2AH9RcJ/NT91lcmbPeO1jSw9S4a22mkRict/tPzs0RygBCzmtAeBp7p+lijZBgIpo+IU6NuqutMw9QyLPkIrBDU0Td4Rl4yZHxKPKZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570040; c=relaxed/simple;
	bh=IVB51Jb3HQBo/6C/d7V1x9BurGDz/yArkL3vmTnm/u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwoGro2iTSA0aBCDVfiEim8jw8Whuy6Ot6MJxArrFxWvv6yhNKaikvIXWxOpJAahZZPvfO6FKXdm7lQGdCcy9EYnsDq8G8nDt8IqFHN4bzDgzCA9OrxowhL0c3IAVsdutITjXYL+KeJdQ+UqTubZ4nSqHdlFIbTTNZrzY+n+vJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=colkjU9O; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="colkjU9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570039; x=1772106039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IVB51Jb3HQBo/6C/d7V1x9BurGDz/yArkL3vmTnm/u0=;
  b=colkjU9OHhv4nCvjxKlwuRTIzX+A3ERlCrIDV/26armH6OS/+qSAupcI
   LRXnylxrIK2sN3tJHf5bZncY751rSEJciuCHZmrpNy/7p+OE4vCBnBQUl
   PRfyGwBiwKOzhQSAX53D5tm7hVLyNPMBMcKWGHVCp+U7UVpMk3Dr2DZ1s
   2jljnOSqnaDydz5+a9Swkmiw1qPd7WaF0zfGheamfdty9SwDW+fcqt9bI
   ra3c6etQKesZ2RGrNZSPdkD9t6FBSV5HygngXJUW4HHXuwsLQof1+bFtO
   SpADxgs3N1uYLq4Rs8XHDC1QOOx+hg9YxTqUSBUX1SD3fWkvBBDeDgx8f
   Q==;
X-CSE-ConnectionGUID: Knx228eCTNeGh4iHQ4xVrQ==
X-CSE-MsgGUID: KHZy/34iR4uIx5OkItzYiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827088"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827088"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:35 -0800
X-CSE-ConnectionGUID: TeKF9WxoRxKxj8a2fuOBOQ==
X-CSE-MsgGUID: dml966K1TCOYoQmOvib0GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171584"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 26 Feb 2025 03:40:35 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v8 04/12] iommufd/device: Only add reserved_iova in non-pasid path
Date: Wed, 26 Feb 2025 03:40:24 -0800
Message-Id: <20250226114032.4591-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226114032.4591-1-yi.l.liu@intel.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the pasid is passed through the attach/replace/detach helpers, it is
necessary to ensure only the non-pasid path adds reserved_iova.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6ec7f6935115..72f6195e32f2 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -471,6 +471,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				ioasid_t pasid)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	bool add_reserved = !!(hwpt_paging && pasid == IOMMU_NO_PASID);
 	int rc;
 
 	mutex_lock(&idev->igroup->lock);
@@ -480,7 +481,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	if (hwpt_paging) {
+	if (add_reserved) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
 			goto err_unlock;
@@ -504,7 +505,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
-	if (hwpt_paging)
+	if (add_reserved)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
@@ -523,7 +524,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		idev->igroup->hwpt = NULL;
 	}
-	if (hwpt_paging)
+	if (hwpt_paging && pasid == IOMMU_NO_PASID)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 	mutex_unlock(&idev->igroup->lock);
 
@@ -590,6 +591,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	bool add_reserved = !!(hwpt_paging && pasid == IOMMU_NO_PASID);
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
@@ -609,7 +611,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	}
 
 	old_hwpt = igroup->hwpt;
-	if (hwpt_paging) {
+	if (add_reserved) {
 		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
 		if (rc)
 			goto err_unlock;
@@ -620,7 +622,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 		goto err_unresv;
 
 	old_hwpt_paging = find_hwpt_paging(old_hwpt);
-	if (old_hwpt_paging &&
+	if (old_hwpt_paging && pasid == IOMMU_NO_PASID &&
 	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
 		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
 
@@ -640,7 +642,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
 err_unresv:
-	if (hwpt_paging)
+	if (add_reserved)
 		iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
-- 
2.34.1

