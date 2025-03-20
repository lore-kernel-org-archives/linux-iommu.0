Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4C221F12
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478474; cv=none; b=eVmm2DMAixotFqG4R7tHJXc9K+9IYuJfx0rcbKd9b942YwLtRXXuX4SSZDrMaEoyWEjTIztS/nOKBj4NkDy9R+jdboGf7bgNjSGvRlZnVP9kRPkRZmsU4jFPqav6Hj4f+gyWTI2SQRcfr4FJVFiiOWmQnfrhWuhE8/ZYK9am7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478474; c=relaxed/simple;
	bh=oHaiKUOIX1YVV/1rgySDuB3SSQomxbX7tAkYUytNXq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ToTzLLjPD9yqsU4GwSZ5HmRdPxUySBxLRUCWMQSmJRfU1N2s6EIjooOKNJ0QrMp1g5lbjFsnVQ3zblvZS8+Z50PXRzGB2j4Jz5DOuNUYCwO8rduXExpusV/VPwgtQWWazxYO9qSMT65LF4uWioLZkeG+68+SOjUscvDWYpSeVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcN5qok1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcN5qok1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478473; x=1774014473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oHaiKUOIX1YVV/1rgySDuB3SSQomxbX7tAkYUytNXq4=;
  b=TcN5qok1xF0HCXrXX1O3WlcN3qP1Lld/l4eZ2xLgxD/3xCJ548Yz6yev
   Z8TBnxFf/C+CGlObifwjYKm5sIsWVw32aYCNeOzER4R1Xa2e/8uyUOj/n
   f1MKM5li5QjXBO7pyAl37oUNgIaQ8kP7lSJ+1Ubw5vY1pGNXJCexJCDv2
   SNeJ7oSJLIUNm0LhPyFTa1dlRowdvcfk67h7vS4d4gTz0YxrfP0nmQQYU
   UFJj0FcLivqpJOc1nxQiH3ZuyJmG0YuLqCpRPsgPc3K8wL4vsKwktpYjN
   SNvKGJEEgAjv94PccLuxdiJgqCczfYYelorzdO9GxbLbAQglArFxi9lvE
   Q==;
X-CSE-ConnectionGUID: 3fg8je79TNWfEvoZstOVJQ==
X-CSE-MsgGUID: UJnuvs6FRGWVPvHtHU8nqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063065"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063065"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:47 -0700
X-CSE-ConnectionGUID: k464uS8+SkaPopLM21AyRg==
X-CSE-MsgGUID: 5QnwIuueTMGqF76L1s1nhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319171"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:48 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 10/18] iommufd: Enforce PASID-compatible domain in PASID path
Date: Thu, 20 Mar 2025 06:47:36 -0700
Message-Id: <20250320134744.5777-11-yi.l.liu@intel.com>
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

AMD IOMMU requires attaching PASID-compatible domains to PASID-capable
devices. This includes the domains attached to RID and PASIDs. Related
discussions in link [1] and [2]. ARM also has such a requirement, Intel
does not need it, but can live up with it. Hence, iommufd is going to
enforce this requirement as it is not harmful to vendors that do not
need it.

Mark the PASID-compatible domains and enforce it in the PASID path.

[1] https://lore.kernel.org/linux-iommu/20240709182303.GK14050@ziepe.ca/
[2] https://lore.kernel.org/linux-iommu/20240822124433.GD3468552@ziepe.ca/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 17 +++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    |  3 +++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 370aed636e8d..6d003f9f0668 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -510,6 +510,15 @@ static bool iommufd_device_is_attached(struct iommufd_device *idev,
 	return xa_load(&attach->device_array, idev->obj.id);
 }
 
+static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev,
+				     ioasid_t pasid)
+{
+	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
+		return -EINVAL;
+	return 0;
+}
+
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 				      struct iommufd_device *idev,
 				      ioasid_t pasid)
@@ -519,6 +528,10 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 
 	lockdep_assert_held(&idev->igroup->lock);
 
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
+
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
@@ -587,6 +600,10 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 
 	WARN_ON(pasid != IOMMU_NO_PASID);
 
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
+
 	old_handle = iommufd_device_get_attach_handle(idev, pasid);
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 9bf970b6a1c3..b8c1e5ca7be8 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -136,6 +136,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt_paging))
 		return ERR_CAST(hwpt_paging);
 	hwpt = &hwpt_paging->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	INIT_LIST_HEAD(&hwpt_paging->hwpt_item);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
@@ -244,6 +245,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	if (IS_ERR(hwpt_nested))
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
@@ -300,6 +302,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	if (IS_ERR(hwpt_nested))
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	hwpt_nested->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 03a231f8f5bf..84c89f594ed0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -296,6 +296,7 @@ struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
 	struct iommufd_fault *fault;
+	bool pasid_compat : 1;
 };
 
 struct iommufd_hwpt_paging {
-- 
2.34.1

