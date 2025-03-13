Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E7267384
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869359; cv=none; b=TE/qQWeSEv+iRHvnGyY3yddQArmVCpjJbInm9Do9XsAzIadbpnDiJz99Gogq5ppVRJjaoEfoD26lAx2Ya/qXRS69mLNXIVRvou3U14NHoLJ6FJ7fZDPasMO0PK1xF8LA0gi7jd1+3wutYaJeZ6lLdh4bFkLdlubfOjGVe4sj+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869359; c=relaxed/simple;
	bh=DGC3XVOxzkwR84N1d1+2adVM8FcKTbWMiFBt8n6wiZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AntnNnuXraPH7IkY8cMxUbqWdo+5GqwZhS964DjM6dMOhrDrjDSlJg9JK5mEqK6KrkdZ1tE7HKaeBs0OC8oGyj7vKdjMuuZ5zVhcxMQonvaz5uQk396RyGCzNU1Zz4LCMyaeMjNhTnOISOkbhogFhFXB3plYQDXOUPMVSzrO63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzRpzh5Y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzRpzh5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869358; x=1773405358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGC3XVOxzkwR84N1d1+2adVM8FcKTbWMiFBt8n6wiZs=;
  b=QzRpzh5YfudMKx/CDSoVZEsP+RLtIObpJ56D5mfjUS5qDhkE35B2PL9B
   si6GuafnKfUVxfKzw/eNncyXMuU+wPk2QyFF+Qu8TKauRpGIuaEbbSenF
   5JK9HZHMQxhptK/zU6IGq5qvJu31OWVP+yIBzjRnpf79BFvfj2Kvq68pR
   Q9jViJWS4OIxk7q/SpQAKZlo2vOA6Ep2rS68LSvxqj43AFBNUuPLW2TIn
   LZYHmwp89fCCvs+h36gl3kJt11wJL84ZMBqEqDXQz7tQR910S1FNr6QXf
   JDJ/HPqW8HWzRQ3tBkuy84h6L4aLgy+/5Qw02zk8MtYJpZK+jAd51MGrs
   g==;
X-CSE-ConnectionGUID: iC7j1R4VSm2dYH1yGjLfdQ==
X-CSE-MsgGUID: i3UZatxISQC0Pp4Vq5knhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863987"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863987"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:41 -0700
X-CSE-ConnectionGUID: g7CW7QgIQIClq+Me+dP+7A==
X-CSE-MsgGUID: Ka6IxqPXSl+COXSg0zB1+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005550"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:41 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 17/21] iommufd: Allow allocating PASID-compatible domain
Date: Thu, 13 Mar 2025 05:35:28 -0700
Message-Id: <20250313123532.103522-18-yi.l.liu@intel.com>
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

The underlying infrastructure has supported the PASID attach and related
enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
extends iommufd to support PASID compatible domain requested by userspace
or the PASID compatible domain allocated in the auto_domain path.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v8 -> v9: Add description in uapi on how user should start using PASID. It
	  should attach its RID path to pasid-compat domain before attaching
	  any PASID.
---
 drivers/iommu/iommufd/device.c       | 4 +++-
 drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
 include/uapi/linux/iommufd.h         | 3 +++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5db6dc705d44..70da39f5e227 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -929,7 +929,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 	}
 
 	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, pasid,
-						0, immediate_attach, NULL);
+						pasid != IOMMU_NO_PASID ?
+						    IOMMU_HWPT_ALLOC_PASID : 0,
+						immediate_attach, NULL);
 	if (IS_ERR(hwpt_paging)) {
 		destroy_hwpt = ERR_CAST(hwpt_paging);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 7a86c164f514..2384b5db7eea 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -112,7 +112,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-				IOMMU_HWPT_FAULT_ID_VALID;
+				IOMMU_HWPT_FAULT_ID_VALID |
+				IOMMU_HWPT_ALLOC_PASID;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
@@ -232,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	if ((flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID)) ||
 	    !user_data->len || !ops->domain_alloc_nested)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent ||
@@ -288,7 +289,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags & ~IOMMU_HWPT_FAULT_ID_VALID)
+	if (flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!user_data->len)
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 78747b24bd0f..75905f59b87f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -392,6 +392,9 @@ struct iommu_vfio_ioas {
  *                          Any domain attached to the non-PASID part of the
  *                          device must also be flagged, otherwise attaching a
  *                          PASID will blocked.
+ *                          For the user that wants to attach PASID, it should
+ *                          attach its RID to a domain flagged. It should not
+ *                          use the auto-allocated domain by kernel on RID.
  *                          If IOMMU does not support PASID it will return
  *                          error (-EOPNOTSUPP).
  */
-- 
2.34.1

