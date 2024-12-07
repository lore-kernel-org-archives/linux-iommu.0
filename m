Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB18289A
	for <iommu@lists.linux.dev>; Sat,  7 Dec 2024 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733572872; cv=none; b=PqqwhU5x19sDtwSnySUhV6/ez48ApfN0rpPAZr7TWY9q3zCk6RF77iqtgB/ZjHT08A6jagpHvrgPxmJBZPxMGlqdjlKsGZbkacf3tgr8scVFIa3QOlAhDIuQWCN//HB1i/3S/rkgnfWbsYIGK+ovpVFzxkqeQdl0nZ6Rm+D4oqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733572872; c=relaxed/simple;
	bh=E8igdJPxz8UP3J4LKAl9dof6CMVQU2mznGHc4tQEe/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oxhyTT6Dc98oKDTUdkv6O41KoTq/+I79IDlrZSVsHOdWuyOJLSzXjgoci0T3tT04BxoJtbawM5MfwX/eO2O+6Uq2n8l4nz5GGF8L1VPfDxqeHklRgm3DUAr3AsbmPkLezty/+Z8fxn+/ZpxTB/9cSE5j+8T3S0H7erCKNX+Za9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJT/445c; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJT/445c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733572871; x=1765108871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E8igdJPxz8UP3J4LKAl9dof6CMVQU2mznGHc4tQEe/Q=;
  b=cJT/445cCzCBj6LFFHdXx1uLsvAFNCFSeDaxG5YQLHyv2V5JBoWjjYgM
   wIXNNC7Im0Lyig4lBkCbfsefaP9oEUA+feyqpmFszpxHNnsv9U1Akzp+I
   016uAYWDBnDYOABqHd0kzAT1OZsvZUXlmVa4JiPjZgBYlHCcFtNfM7+Yc
   JNny1+4vtyJ8AzCRwaiZJbmN4pLOf/p2YPkk2dWoDRhzlKWzELIoGQDSO
   0Icpv52vdWFRFQHQfOcubQ0mpIy6KQUIXCxfoEEblZZrfIb1RR4r/mwaP
   +EIibTP9O3mkoYLMyP9+4B3ELurSLXGGAwE6Dy5biS6dXG95K8JdFNrIO
   w==;
X-CSE-ConnectionGUID: wrAifhksRuCNIA5c+6+PoQ==
X-CSE-MsgGUID: utmempN2T6SBnKFC/g4ZZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="36757999"
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="36757999"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 04:01:10 -0800
X-CSE-ConnectionGUID: /5tnOk0kRtq8a6GxfXTGAw==
X-CSE-MsgGUID: 7RUo4u0gQIej5tmnX3VIjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="95124780"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa009.fm.intel.com with ESMTP; 07 Dec 2024 04:01:09 -0800
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
Subject: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd core
Date: Sat,  7 Dec 2024 04:01:08 -0800
Message-Id: <20241207120108.5640-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
iommu_hwp_alloc is valid or not. As the fault_id field is handled in
the iommufd core, so it makes sense to sanitize the
IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it out
before passing the user flags to the iommu drivers.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c |  8 +-------
 drivers/iommu/intel/iommu.c                         |  3 +--
 drivers/iommu/iommufd/hw_pagetable.c                | 10 +++++++---
 drivers/iommu/iommufd/selftest.c                    |  2 +-
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 6cc14d82399f..72050bb507fd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -178,18 +178,12 @@ arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data)
 {
 	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
-	const u32 SUPPORTED_FLAGS = IOMMU_HWPT_FAULT_ID_VALID;
 	struct arm_smmu_nested_domain *nested_domain;
 	struct iommu_hwpt_arm_smmuv3 arg;
 	bool enable_ats = false;
 	int ret;
 
-	/*
-	 * Faults delivered to the nested domain are faults that originated by
-	 * the S1 in the domain. The core code will match all PASIDs when
-	 * delivering the fault due to user_pasid_table
-	 */
-	if (flags & ~SUPPORTED_FLAGS)
+	if (flags)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	ret = iommu_copy_struct_from_user(&arg, user_data,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7d0acb74d5a5..c8f9c70a04ab 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3340,8 +3340,7 @@ intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	bool first_stage;
 
 	if (flags &
-	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING
-	       | IOMMU_HWPT_FAULT_ID_VALID)))
+	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ce03c3804651..598be26a14e2 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -140,8 +140,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if (ops->domain_alloc_paging_flags) {
-		hwpt->domain = ops->domain_alloc_paging_flags(idev->dev, flags,
-							      user_data);
+		hwpt->domain = ops->domain_alloc_paging_flags(idev->dev,
+				flags & ~IOMMU_HWPT_FAULT_ID_VALID, user_data);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
@@ -280,6 +280,8 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
+	if (flags & ~IOMMU_HWPT_FAULT_ID_VALID)
+		return ERR_PTR(-EOPNOTSUPP);
 	if (!user_data->len)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!viommu->ops || !viommu->ops->alloc_domain_nested)
@@ -296,7 +298,9 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	hwpt_nested->parent = viommu->hwpt;
 
 	hwpt->domain =
-		viommu->ops->alloc_domain_nested(viommu, flags, user_data);
+		viommu->ops->alloc_domain_nested(viommu,
+				flags & ~IOMMU_HWPT_FAULT_ID_VALID,
+				user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
 		hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index a0de6d6d4e68..658fecae3464 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -595,7 +595,7 @@ mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 	struct mock_iommu_domain_nested *mock_nested;
 
-	if (flags & ~IOMMU_HWPT_FAULT_ID_VALID)
+	if (flags)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mock_nested = __mock_domain_alloc_nested(user_data);
-- 
2.34.1

