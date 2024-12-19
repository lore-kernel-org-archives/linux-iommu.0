Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49851225A4A
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614878; cv=none; b=reHtV4W1E98QUziLJiyJuD+MQdqGqXhWr5reZR/jRuOnXbU1fCevqDj+fjs5OSIpzF4CN0vIxgEUvuibLHwYeLxOJcufEAE+UF6Q5RfhGENXT64CulDvAO51CNOsm5KLHH4F/sYzmkJWvS4UKxhpZIuayZIKnPUbAo7vaqV9nb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614878; c=relaxed/simple;
	bh=I2NVYTE9vD7zEI+84eBMbk/urc6q8XgfJnAgCXlNOug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p4DlVQggZmP8ujQwdahx6lk9Rai7PrmEfcgXHwcHM4kBIuCr4V1Ithbk37MYBsZiCuHTCaqQLfNgft2HftKj9ZuomTnVcqGon/q6lhAEpn6pZrcfXHefEYMUuyty+aSwlVkjw5QfqCYMNK+LGvVvU7OYOnPhhDZCPYSTCir4N9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEKkxvlg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEKkxvlg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614876; x=1766150876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I2NVYTE9vD7zEI+84eBMbk/urc6q8XgfJnAgCXlNOug=;
  b=lEKkxvlg+uSJ85cMHyh5VzsPTxbVVv6zAg5SuJrflKv2CBmW1Fru95Jm
   2CJIg3caeRAH0+i2nBdEh4TiIMTqGAYu+f64EteZh+Kr3u4YEx3Nt8JB2
   G1otNdyvNIyAhYpBENEP0A8L9WZIe5pHgVQMuzepJV5ynZvRKJTW7ICzq
   yQAHicmMaX1eAn8iYcVsRUHZw9noK/XNds0Chmrp/cfJcEd+0DNXIXVl0
   ZUOFb1lVFC4X5xwHDzf8tXT0mNzsvhhtUTHBFfvg0kc6XR5+YqO09eQtn
   FDelCX9lh/kPJM1HoJa3XYYA6oRXanGSQFRuHV5B7ZYgDdGTuz8bAC65K
   A==;
X-CSE-ConnectionGUID: jfu9aEj5RdWWa9mgYnkK7A==
X-CSE-MsgGUID: IcVkeaJjQIqCmcqPY5WSbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542304"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542304"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:51 -0800
X-CSE-ConnectionGUID: lNMKF+WTTMWguBPJfdfvOQ==
X-CSE-MsgGUID: 16bJ+O24TX2/stLjqmoYog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177333"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:51 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 10/14] iommufd: Allow allocating PASID-compatible domain
Date: Thu, 19 Dec 2024 05:27:42 -0800
Message-Id: <20241219132746.16193-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The underlying framework has supported the PASID attach and related
enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag.
This extends iommufd to support PASID compatible domain requested by
userspace or the PASID compatible domain allocated in the auto_domain
path.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c       | 4 +++-
 drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c1ff3dbe109c..768eae6c3275 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -662,7 +662,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
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

