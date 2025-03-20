Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69C221574
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478471; cv=none; b=I/pWGGWrJ45XwhjW9JzTmslwMkXX9LmEU4uZDVpoYmzhWrwsCM9XRCUsqLMOI+NGNYZN3nhRhfOALoUKWKXcEM3QmSznJ45tTxRKMc69ID8mV+m1fBnDTXyssIj7xArehgb+i22ym8NhSUZQdd04JQf2agskokq17PMqQcLo7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478471; c=relaxed/simple;
	bh=9pEdYABrsxPUmIY1AdWXW24P99LHa40iHZRjYghQ4Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNFAvQ8vCfu5AA3VzNkY/wW+kuRaAvmMCfSEt0Bo+E1Ft+p3AE6F9kzfv/s4SQqiVaGB7uLQLHklB3GhEMjti4gpPUcHp3TfdlAouHHM5XtOI1pp/G98jE2D06dk8RpnyoDhSn6f7isx7l4OMeA6zPNgZOXInnrNvWc+dBnoL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmYYiv67; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmYYiv67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478469; x=1774014469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9pEdYABrsxPUmIY1AdWXW24P99LHa40iHZRjYghQ4Eg=;
  b=LmYYiv67wIMfn5HqSIe380c1kzoKt/Zf0BUBICbrvhBeVgEY2STlv/tT
   yJjA9e+9vyxarEO87UGhALCjTss0H2cTxzYoyV05RtzRHit0fIO1UKJ9T
   y7IZIhlvgjiHoXayJMDmXXfg+8sxdxPWTFmG8p8cfQloU+rJ+8YJ8dtVN
   8MNxysH6gA4gown9BYmaBu9d9ldfzSUV6eWKB49p2TgeWWopgHKqMHsBQ
   kkoetxrqXTm3aFEoiXnTS8R1MMBJw8yQvngtY0QJnhCsXkNiV7zeJmjnv
   Ez8y8oFJ9NIbfzOamQSf1jPRCsITvA20RUByXfnkBffhTG4q0/aq+1kY2
   Q==;
X-CSE-ConnectionGUID: szWU0gQsTg6SJGNvuLjrsQ==
X-CSE-MsgGUID: g8f37BV3RZm1aCihz6vgOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063047"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063047"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:47 -0700
X-CSE-ConnectionGUID: hT2k94iBQey/ezZaUfbOGQ==
X-CSE-MsgGUID: vz+7G9ePSsC7eEkazLt59Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319147"
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
Subject: [PATCH v10 04/18] iommufd/device: Only add reserved_iova in non-pasid path
Date: Thu, 20 Mar 2025 06:47:30 -0700
Message-Id: <20250320134744.5777-5-yi.l.liu@intel.com>
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

As the pasid is passed through the attach/replace/detach helpers, it is
necessary to ensure only the non-pasid path adds reserved_iova.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3c83fb014dcb..be5226d2883e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -598,6 +598,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
 	int rc;
 
 	mutex_lock(&idev->igroup->lock);
@@ -607,7 +608,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	if (hwpt_paging) {
+	if (attach_resv) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
 			goto err_unlock;
@@ -631,7 +632,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
-	if (hwpt_paging)
+	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
@@ -650,7 +651,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		idev->igroup->hwpt = NULL;
 	}
-	if (hwpt_paging)
+	if (hwpt_paging && pasid == IOMMU_NO_PASID)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 	mutex_unlock(&idev->igroup->lock);
 
@@ -717,6 +718,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
@@ -741,7 +743,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	}
 
 	old_hwpt = igroup->hwpt;
-	if (hwpt_paging) {
+	if (attach_resv) {
 		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
 		if (rc)
 			goto err_unlock;
@@ -752,7 +754,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 		goto err_unresv;
 
 	old_hwpt_paging = find_hwpt_paging(old_hwpt);
-	if (old_hwpt_paging &&
+	if (old_hwpt_paging && pasid == IOMMU_NO_PASID &&
 	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
 		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
 
@@ -772,7 +774,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
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

