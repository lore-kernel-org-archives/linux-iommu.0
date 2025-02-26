Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD4215785
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570042; cv=none; b=cho0uOWSw8APx3yFMMZ+zka3i9761lFUrSafW8JS8whCtTyRf8jHo0LiNSN4pHBUdVFzGxj7w7MQE3QOeYKg0DrFjsTvUUHoBe4EEX4sL0QuM3rMZ7FZADKaIsqaHLrwhQnCQ/c3dIAdHI21ZFtARALxvdAPWKXPUS0jSPuDpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570042; c=relaxed/simple;
	bh=/bJfwctC8lUUgU0M/8hG62WnG5qAAa9a66BW8jU4qWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHs1gKzuvLOvuw0f4TNyoTCwtUaxWpEdeTHvRywuSCJHV0nwC8vE/ULZT22IxXBTY9xM4ksuJ0/9as81R6/SWDtfmS2Ge/A9DRvkEZEuAvcXPqxFUYWenz3FJxHkLbTljGp87fSuN9UXOqaSfXknZJ9W7+3Zmb+Dad071sapgco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5pXcjBl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5pXcjBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570041; x=1772106041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/bJfwctC8lUUgU0M/8hG62WnG5qAAa9a66BW8jU4qWU=;
  b=Z5pXcjBlL/bxKHJnXJGTc5HUJAe1lgYZVNLH4YteZRaehVeHyrJE1n9m
   BXHOHg0s0URdf+Vfw5YEBsAwM9EkzI+PiIPRYC5nep/QzazKJ9fauMeK/
   bSDE0mDjY017fMUUVZ81bk98MB4BOly+dw/wD6tjgK4yxVT3HYQnLong6
   Zby584bBEHAT32GsJbGUuGAy7wt5rl6QsfhyrHpAi4dIRC1jbV+SYumAO
   zYCRZyM6rvN/xuQTe8kK+7I06kalcKrXfhYVJhdJJoHnNAuLhc9nHscYx
   VEVVQEfm6Kfi7x1siccY+up+x1Z8rkYLSGiZK+CQaYMwqTTvYuR0OAGB4
   g==;
X-CSE-ConnectionGUID: Vw+mnkcATHC5oqKArxsuIw==
X-CSE-MsgGUID: XA6YdfqITvSLQ4J4PJlU4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827096"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827096"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:35 -0800
X-CSE-ConnectionGUID: F2InBBwbTZKYej7YPRYMSg==
X-CSE-MsgGUID: hjwsb4r4Rpi//QhUR5hhow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171595"
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
Subject: [PATCH v8 07/12] iommufd: Enforce PASID-compatible domain for RID
Date: Wed, 26 Feb 2025 03:40:27 -0800
Message-Id: <20250226114032.4591-8-yi.l.liu@intel.com>
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

Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
the RID to use PASID-compatible domain if PASID has been attached, and
vice versa. The PASID path has already enforced it. This adds the
enforcement in the RID path.

This enforcement requires a lock across the RID and PASID attach path,
the idev->igroup->lock is used as both the RID and the PASID path holds
it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 30dd2f79491a..e0f097b04467 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -357,6 +357,22 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
+static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev,
+				     ioasid_t pasid)
+{
+	lockdep_assert_held(&idev->igroup->lock);
+
+	if (pasid == IOMMU_NO_PASID &&
+	    !xa_empty(&idev->pasid_hwpts) && !hwpt->pasid_compat)
+		return -EINVAL;
+
+	if (pasid != IOMMU_NO_PASID &&
+	    (!idev->igroup->hwpt->pasid_compat || !hwpt->pasid_compat))
+		return -EINVAL;
+	return 0;
+}
+
 int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 			       struct iommufd_device *idev,
 			       ioasid_t pasid)
@@ -364,10 +380,9 @@ int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach_handle *handle;
 	int rc;
 
-	lockdep_assert_held(&idev->igroup->lock);
-
-	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
-		return -EINVAL;
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
@@ -441,8 +456,9 @@ int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
-	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
-		return -EINVAL;
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
 
 	old_handle = iommufd_device_get_attach_handle(idev, pasid);
 
-- 
2.34.1

