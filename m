Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094E139CE3
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726723; cv=none; b=BTo/Eg9SI6xXyjBwV8f2kqZ0tTgnheiH2QfGotAYEi4sTNQnCDCLnxG9WGkvLOy4iRWPHBlEUu6TkBKr5mxjyy58tfbbZ0ZXuKeINGqZXF4D01gmYWzVrqIOUTywdFOQ+II3LQZ/KmbuOmH007aUYQKznxEp7TvufY3l95WWwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726723; c=relaxed/simple;
	bh=BcJNnKcdyTF5yjmj2IotBTGqGiR3ueh+E/24lMauZu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZLpIA7mvkBgEZK81QIPrRKivAzIGsOKJ5WKYF94oNdTKDFq/Bl6kzWCA8eNPRfgK44Jfgs15u0cU7rAwhigbNOhj7qPVjHuDWg85DVCMPQS2xv/AOTovNXMmtmUKAM3puZnYklOyrEUz1pg43fQ8YntH1WF99LBJDxABCygOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJ4PuetA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJ4PuetA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726722; x=1762262722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BcJNnKcdyTF5yjmj2IotBTGqGiR3ueh+E/24lMauZu4=;
  b=NJ4PuetAGLGQlkYeFKBSH6F6ZFlxCN5zsCMNvYNtd/O+5yQWMXB2JZmU
   wEuYLm1y0GlkCZTFtSxxNsmligknBr8YPPrvGf7CGbFqdIDoFCEF5ea96
   /xNyox+nEmXmldjbRs+7RQfm27T17SkJ3FLeu3xJ4XmtPgrCtpaNtsJCg
   Ka5ZtrW2HiGtVTOFu4uCir5Wmw2OI2+3WCbjittyFHnnyq5PG6NEeSFvq
   uewuWaaXkWckAljrKTS+TmWx+AQNB9NLwlqrBv+wRZg5zLNrU5qB100f0
   kBzbHbb5x+sj9xE8OCnd7yHcPyKA1sJ9Uy09qtXqJn6U3or8VNVFQp+oB
   g==;
X-CSE-ConnectionGUID: fmUB46F4Srm/AswJ7w3zWQ==
X-CSE-MsgGUID: xLJWyHUbSBul4KMo30f6DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47884071"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47884071"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:25:20 -0800
X-CSE-ConnectionGUID: JYx5kUXgQLuSOrvfAtbx1g==
X-CSE-MsgGUID: bBc1mJOFRw+mM5MeGPqowQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84100464"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 05:25:20 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com
Subject: [PATCH v5 08/12] iommufd: Enforce pasid compatible domain for PASID-capable device
Date: Mon,  4 Nov 2024 05:25:09 -0800
Message-Id: <20241104132513.15890-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104132513.15890-1-yi.l.liu@intel.com>
References: <20241104132513.15890-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu hw may have special requirement on the domain attached to PASID
capable device. e.g. AMD IOMMU requires the domain allocated with the
IOMMU_HWPT_ALLOC_PASID flag. Hence, iommufd should enforce it when the
domain is used by PASID-capable device.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c             | 6 ++++--
 drivers/iommu/iommufd/hw_pagetable.c    | 7 +++++--
 drivers/iommu/iommufd/iommufd_private.h | 7 +++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a1341078b962..d24e21a757ff 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3545,13 +3545,15 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
 	/* Must be NESTING domain */
 	if (parent) {
-		if (!nested_supported(iommu) || flags)
+		if (!nested_supported(iommu) ||
+		    flags & ~IOMMU_HWPT_ALLOC_PASID)
 			return ERR_PTR(-EOPNOTSUPP);
 		return intel_nested_domain_alloc(parent, user_data);
 	}
 
 	if (flags &
-	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+	       IOMMU_HWPT_ALLOC_PASID)))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 48639427749b..e4932a5a87ea 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -107,7 +107,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  const struct iommu_user_data *user_data)
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
-				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+				IOMMU_HWPT_ALLOC_PASID;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
@@ -128,6 +129,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt_paging))
 		return ERR_CAST(hwpt_paging);
 	hwpt = &hwpt_paging->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	INIT_LIST_HEAD(&hwpt_paging->hwpt_item);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
@@ -223,7 +225,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	if ((flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID)) ||
 	    !user_data->len || !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent ||
@@ -235,6 +237,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	if (IS_ERR(hwpt_nested))
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 11773cef5acc..81a95f869e10 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -296,6 +296,7 @@ struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
 	struct iommufd_fault *fault;
+	bool pasid_compat : 1;
 };
 
 struct iommufd_hwpt_paging {
@@ -531,6 +532,9 @@ static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 					     struct iommufd_device *idev,
 					     ioasid_t pasid)
 {
+	if (idev->dev->iommu->max_pasids && !hwpt->pasid_compat)
+		return -EINVAL;
+
 	if (hwpt->fault)
 		return iommufd_fault_domain_attach_dev(hwpt, idev, pasid);
 
@@ -564,6 +568,9 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *curr;
 	int ret;
 
+	if (idev->dev->iommu->max_pasids && !hwpt->pasid_compat)
+		return -EINVAL;
+
 	if (old->fault || hwpt->fault)
 		return iommufd_fault_domain_replace_dev(idev, pasid,
 							hwpt, old);
-- 
2.34.1

