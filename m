Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AA266B71
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869351; cv=none; b=sqhnQ9QR0VluF1EEENBYPGxnQDZ9lt5auXqWlEzIckDoef0IhFez8zFuoZdQ6+qZmHq+0WTnZqqPbGWY6J9WKAEtiNp4HuJYeEEmeWx7AJb6PdlulHTRhWe3RJbXV1xAwh/UShA8ZGfRNHHVRSaB/5YgRUiGmC8c8a0iFLciHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869351; c=relaxed/simple;
	bh=bspyFcxpIVIREzeSumUwIoZ4szpWMgBdR9V1I20xn6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFstgRD/zDkjcw6Ha+VZHu1RKYhMRikA+r82N5qwj96uOCcw6Ky/VSmFBkjYTha28MHgpO//qsaZvCxspGFdIj3Z2yOe27XxkK5NY+6M4ljgrNW9I8//mxZg91aAD3Mj9vejCW4Mb0KLahpNynHZ3gBY6bX/0TgK5cwcjHXxCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbioZKuE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbioZKuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869350; x=1773405350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bspyFcxpIVIREzeSumUwIoZ4szpWMgBdR9V1I20xn6E=;
  b=VbioZKuEUV7U6VjDjf9lNVmzfIlBH1HpY7YzL2UXzhNwWZUvUVMw1SLe
   VWzug3ncHH/ol1jeSlxzHg5oiny57wAswK1PsB1vEyzR9FG/8JbffiqBm
   HIv7e3o0JSrCOY5k2acmCFhW006RYS1SOHcsvluNCPycrIYsBVV/zTRoa
   PH9ePth9s/rvOkNsMFwgUSBBPdQ55CEHawhoHPFj2RR+CmxQIZ8j/5wFP
   gklO6sWslgZ/W85LR8Vo/SwWoBxMffxBJeAIi0bbhzT4DQaaLWfHXzwRD
   L0ba5TGdh2q69Oqm3Vy24VAK6FmlrXBj99sz1l/7KXj9KywdlOnHqKYZO
   Q==;
X-CSE-ConnectionGUID: 1cquYt2DS1ORrDDG3iW7AA==
X-CSE-MsgGUID: Kl2EtzCqTm6lCbYHLzEScg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863946"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863946"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:35 -0700
X-CSE-ConnectionGUID: Oe79Xv2kSPi2ZRmeV8kpSQ==
X-CSE-MsgGUID: M5cL1a7SQnmVxKkgPX854w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005498"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:35 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 05/21] iommufd/device: Only add reserved_iova in non-pasid path
Date: Thu, 13 Mar 2025 05:35:16 -0700
Message-Id: <20250313123532.103522-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
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

