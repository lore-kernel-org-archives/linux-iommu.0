Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186B10957
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677956; cv=none; b=c+N7pPcTssy7Z9L/3gORSMRJuGMeFquIcw4XBHQHq4S3phjkKix2Nve10Tw80MOT3oz/Ls50kfC8VLSgDj5Gb7XnnaDAj12RUqAsRl5EnKWDJ0vCW1Q9DW1umX3ghKpL95bY39hZcDnpbuMnB5cqPxon7chpPei5GBStz3NnfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677956; c=relaxed/simple;
	bh=IVB51Jb3HQBo/6C/d7V1x9BurGDz/yArkL3vmTnm/u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbKC+wJJw1ZegRCxFCz1129VS7s6F+qI1BFtEo4QDDcwqytWTVs62wTDm6n4Uk92HPk2rpFqJ1GlkP1WU3NaB+0z7/CI643gCBVai7hTWLAF+XRI8QwgrUMllobm09kxDy7CuIfTFUjzGKZHk0Q5RD7l5polSx2pZzAhCMtXyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKGWR6sK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKGWR6sK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677954; x=1771213954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IVB51Jb3HQBo/6C/d7V1x9BurGDz/yArkL3vmTnm/u0=;
  b=KKGWR6sK1vJQapqkwumkCqwe0JHGvNAi8K+0Nxzz9xQdfvUk9gc7grJG
   ZPQXiYPXp5FP4JLw2jfByxbcYB3n4QI5aHmx63VrDtFuYyJjK8HFah3Sl
   naebvv6pymQbob17N2NwADC59Xw7nAYQo2mqQEbES38Nema+Qpb66mebn
   XUVdw8YAkrGhSDRprkjBSJi+zhb+Y9InK10LbZYudnaC7UwXU4eEhugWn
   1HiP2KgqU9bc1zT+jfKxq4nn+b9bjkSHHRLaBJHEn84O7sDdIDAA44a3V
   /SbarnZxz5hPvnGmyfKN6FvAKfXmVcrR63ZFWyE3lGuXiVU0OBbwtKUy8
   Q==;
X-CSE-ConnectionGUID: EgfNOqzWTbaP3xsp/x3ROQ==
X-CSE-MsgGUID: Kjd4cpl1T66LydE6Blkw3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919314"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919314"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:32 -0800
X-CSE-ConnectionGUID: 0v1wB/YKSL+468ZjGKqjkg==
X-CSE-MsgGUID: TAiJb96HRvutmuo090Wj8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544689"
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
Subject: [PATCH v7 04/13] iommufd/device: Only add reserved_iova in non-pasid path
Date: Sat, 15 Feb 2025 19:52:19 -0800
Message-Id: <20250216035228.23831-5-yi.l.liu@intel.com>
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

