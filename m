Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB9215F7F
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570044; cv=none; b=IYn888W4XEZAdrfDHZ1Szv3XOlu8igK3Vd6q+q+AIjq6dbFnxdNoYcNWCAH8Gu9IrXVq+Pa0JZsgufaAPtVhxk3DhL86JXfUUlJVCioZ1B9x/ZgUNkY2czLx+JMMf79oc9KQKxMn4UJXD+wVPtKLcpeObAngLJdR2XbcfCTNjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570044; c=relaxed/simple;
	bh=oxsdy580hMKEAI0uQr/bAnzN3Vid6yIZdjNWbOkIqoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I1Gq4NhyYCyEa6YxQpH2toNrsUItLQapFKh9GBGPbUjK8jujQHtEm+QZqJlJR/pV7D1vIAWcWFK04/TotpAYJA5F88syALuzXiHgv1fLL8+PSjYSQA0yUamSYIY+b2pMW5s5ivKtHXvoEUBckhH5O8gl2M7H1aG8ILlSSSN0wZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUkVdTD9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUkVdTD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570042; x=1772106042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oxsdy580hMKEAI0uQr/bAnzN3Vid6yIZdjNWbOkIqoQ=;
  b=DUkVdTD9NLacIws5XlBtOzU1lxAeeHtGc3Mh65xKcBK8FoqqGv15GXnS
   2ml17U63uJI2C6mAZSaR403igl4pAxAjMOMRLpwSaHOM52FexnAxY8ht8
   a1TUHulKdoh1uWKW1fRucY5iNj4Y2yQQaQJOmYCGsBbsa6jkOH0Lg5U6e
   6RDgul97X8AWIHaR1jjbhNP0Xura2XFbULaKdMTAINxIwAbM6trXxrGIZ
   LzBvgVpq73GF4pcRT2Qn3Fh1RFL2HOVfb0qz1vbaaIjIDQQfL0cmtZYbI
   jdf4J460I9YENuKeTcJ3HpkMQbAc69hix9i9oi0QxCuXY9dsJNdcDkHeD
   g==;
X-CSE-ConnectionGUID: m0PKwakBS4iJenNd8L+zpw==
X-CSE-MsgGUID: k0StmYC5QDWjWOOryFwZWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827103"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827103"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:36 -0800
X-CSE-ConnectionGUID: b/Ouy+guRx6I57SPsYdRjw==
X-CSE-MsgGUID: zF83JtPLSyGqwBDt7YnKPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171605"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 26 Feb 2025 03:40:36 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible domain
Date: Wed, 26 Feb 2025 03:40:29 -0800
Message-Id: <20250226114032.4591-10-yi.l.liu@intel.com>
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

The underlying infrastructure has supported the PASID attach and related
enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
extends iommufd to support PASID compatible domain requested by userspace
or the PASID compatible domain allocated in the auto_domain path.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c       | 4 +++-
 drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e0f097b04467..afba66211b11 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -735,7 +735,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 		goto out_unlock;
 	}
 
-	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
+	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
+						pasid != IOMMU_NO_PASID ?
+						IOMMU_HWPT_ALLOC_PASID : 0,
 						immediate_attach, NULL);
 	if (IS_ERR(hwpt_paging)) {
 		destroy_hwpt = ERR_CAST(hwpt_paging);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 5df837388419..36da52311893 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -111,7 +111,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-				IOMMU_HWPT_FAULT_ID_VALID;
+				IOMMU_HWPT_FAULT_ID_VALID |
+				IOMMU_HWPT_ALLOC_PASID;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
@@ -231,7 +232,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	if ((flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID)) ||
 	    !user_data->len || !ops->domain_alloc_nested)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent ||
@@ -286,7 +287,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags & ~IOMMU_HWPT_FAULT_ID_VALID)
+	if (flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!user_data->len)
 		return ERR_PTR(-EOPNOTSUPP);
-- 
2.34.1

