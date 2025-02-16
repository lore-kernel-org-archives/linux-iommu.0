Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060E13957E
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677959; cv=none; b=hTizu+HeM5nLAZ2Z3gph6oQZbct13vwpaNU6Pd8kQjdP1o0/q9d2kUVHfy6vivytas5unvC69wJ33cnfO3AJL7hDa9OhS5t7Ws/GQ1Z65Dig6QE7DjPfK7yooCT5z20+Z/kqCEHB+n6b6gpaSIbBA0hzCIDfKGo8GbHBT9spncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677959; c=relaxed/simple;
	bh=yGFk3N86vHRwAY5DwaUNcy7t+CHww/wNoYApgFafIiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhGtcqdLv5K5Ac+AUt1+pM+egcplPtHg6iGtHF5xhPxVahuDgS2AIOPoY8O+kWjb5bystWfpskUR7E/IFUnRSgRCDLx3RoDRkbC/+dD2MbRUeUZi/H9kfBoiT5b6Q1dHKwbT3NTcEeJ0uYhwr3eXeLMkfsV4YuMXwIprfUHyviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9y+ww6j; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9y+ww6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677957; x=1771213957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yGFk3N86vHRwAY5DwaUNcy7t+CHww/wNoYApgFafIiU=;
  b=S9y+ww6jH6jb4g6TVo1/6F+FY37mP4MxeAlQkOQzEHkWO6++OMEum3ZT
   RskixtxknsdR9E8hIN+iqi6QsCN2QnNs8+VFKFAQ4d1NygRwihRONj8nu
   lo6hn6a0A4CTguXlJlA69MlR1DAAQffqIelLh2TgbscnGGKAqTIWVw1AY
   vVG2LBU/5uxuIrtAYWJD8VycysR1188A1KXMfKREbHPeH1FfkDo2/xakV
   Z2zXGswYfBd+B96csL5bTZIce249jeXoYB1yAnjwEI1kgYFobCERAR4Oe
   d6peP1YDTSYjZlg8JOYMjmICCAsCIkzNRX3QAwe/PL9LTxzwtDjsRiedA
   g==;
X-CSE-ConnectionGUID: yrRnyvr0S/2Zjai9KtwFvg==
X-CSE-MsgGUID: zjtXzw2fSQ+0nbbWJi7a/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919348"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919348"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:35 -0800
X-CSE-ConnectionGUID: +FH0ND9GSkuj5StEHL/kbw==
X-CSE-MsgGUID: 33HtLYNMQLKqYlWNTWmJVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544772"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 15 Feb 2025 19:52:36 -0800
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
Subject: [PATCH v7 09/13] iommufd: Allow allocating PASID-compatible domain
Date: Sat, 15 Feb 2025 19:52:24 -0800
Message-Id: <20250216035228.23831-10-yi.l.liu@intel.com>
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
index 6fc848d3ef47..7787d0931761 100644
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
@@ -228,7 +229,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	if ((flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID)) ||
 	    !user_data->len || !ops->domain_alloc_nested)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent ||
@@ -283,7 +284,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags & ~IOMMU_HWPT_FAULT_ID_VALID)
+	if (flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!user_data->len)
 		return ERR_PTR(-EOPNOTSUPP);
-- 
2.34.1

