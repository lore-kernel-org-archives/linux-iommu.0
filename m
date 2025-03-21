Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EB722D78E
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577592; cv=none; b=J3jkFjnDQBpEpFI3o5dOQDqW8vbEZpaOWLJ86JCynyF6FhuZtKPLpgqES1QwaVruA2dmZkvDoPL32FUZO3raJUxcNy36pZdzRBG0grZrXHdC7oTQf100khCX7jCJvZHUZYEZnGt8QLSg83QA0GRMmaTZQkBRBEW6jGrIAgXGICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577592; c=relaxed/simple;
	bh=fovyjiNGlXME5aor4xVaNmnfotmSGcEzZK39JSC2su0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SeAriOer7GVxk3E4SbEA1Gsul0qNFTlSF53EFntbOZKnob3X2SYDxbq4msuVFf/MSW3V4GytFWyvXq8MC0c/i4NXypMlNPd6QKZNOAKfi/AvSesYsYfVcSSsJfYOhLMyCPSO1cV8IZ09R1g9aVN1HdQ4DO3tFWOUE0YWWaeeKqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8Uir2Ec; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8Uir2Ec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577591; x=1774113591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fovyjiNGlXME5aor4xVaNmnfotmSGcEzZK39JSC2su0=;
  b=G8Uir2Ecm80YjH6zAKPWLthwe1s5SeKUteucZG0/mfhmo2DJnXW6RlJO
   O7R6NMsj+6PghtlngJZu0tlUozHJ4qDWuh7REPitpvbMZ5aswVtfE0CuU
   wUdJTQqPCb1zh8IWXDRs44AN1G5FOlLyErEKUknXN+GP5VI636O3TNXTZ
   +YZlHT1H+tTGTeQEMhx7MHrX+o2qDc99QE4rqdj9qMLqbzJwuAl2quY6c
   c5XO3W0JKGZ0Brku0vKFvLNA3jdK/aZOl+v1WL0AvNmCgzI3eSDe2GH00
   75s/581Tdn7KJPjcJ5nLKz2ubFQP60g7krQLgstWoQ3VeIjzw5E5Db2Ng
   w==;
X-CSE-ConnectionGUID: pY7fQdKSQlWnsbC7NUamnA==
X-CSE-MsgGUID: 5j7L9bHgQ9u2DmUoyRRX5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976818"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976818"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:46 -0700
X-CSE-ConnectionGUID: BYHd3NvdTZa0hbZtOlMMdQ==
X-CSE-MsgGUID: DoKhW3rXR/K0CYbv5GAlaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914497"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:46 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 10/18] iommufd: Enforce PASID-compatible domain in PASID path
Date: Fri, 21 Mar 2025 10:19:32 -0700
Message-Id: <20250321171940.7213-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321171940.7213-1-yi.l.liu@intel.com>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
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
index 175f3d39baaa..ba21b81e43bc 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -395,6 +395,15 @@ static bool iommufd_device_is_attached(struct iommufd_device *idev,
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
@@ -404,6 +413,10 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 
 	lockdep_assert_held(&idev->igroup->lock);
 
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
+
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
@@ -472,6 +485,10 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 
 	WARN_ON(pasid != IOMMU_NO_PASID);
 
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
+
 	old_handle = iommufd_device_get_attach_handle(idev, pasid);
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index bd9dd26a5295..3724533a23c9 100644
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
index 85467f53bdb2..80e8c76d25f2 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -299,6 +299,7 @@ struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
 	struct iommufd_fault *fault;
+	bool pasid_compat : 1;
 };
 
 struct iommufd_hwpt_paging {
-- 
2.34.1

