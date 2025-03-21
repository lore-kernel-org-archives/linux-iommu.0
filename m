Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AA222DFA4
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577594; cv=none; b=PTgkYrA+2RUBTz4OuigKSc/DPgj4eacAUXol4uKA0HDROPm+xDnLhpEgxRNYXyIlF9y1nVfPi9ahc6iG1K5JDEd22FVQ5TrucWGI8FgB7ZZuNzQTHZzMwG/7nvVEhlwnlD5Ds21iW6Vx8hZ8gFjMxlYInYGT+TINlTbqxNQ1lts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577594; c=relaxed/simple;
	bh=GJ60IRiMTBj+cLaQB45+S74lRcvCqxiaD5jwrb+1RHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zjgecr8sCqd5ZZZuKpXtwoYyQn16tFNKXwXBuv0YwkyVrQPDi3LEKSfcsVHvmIR5ks+FlbyMuO2Jwv0RKu8Uirv/MtYqoTXfugKL1l3grABJxVPXAU7n6gJ7DHKxlt+rogYq1dpFgFQ5zAesZDB4Tvplj2NAw7/0z/vmr4QuqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpNZRWLO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpNZRWLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577594; x=1774113594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GJ60IRiMTBj+cLaQB45+S74lRcvCqxiaD5jwrb+1RHA=;
  b=GpNZRWLOlx7vMzG9DZ4TyEKxzXM0RrC1pBQb6oQFVCjbkG8gpj7TKOpa
   d8A43b/5Vw8UYzQO79sGW4RnaiQjeWDo5/VLqcY0JJrJAsS3UYkBpUhYt
   I4E89Nqql2P7UDOWlSVw7dPpDMRuMs0kXYwIhhujt4XEyL4H/VEISJPkV
   9XEgqA/Vunw8KBwBr2KizvBSiR2jcP/t0h132kqWeE6ca3f7g60WPPHzP
   P5WtRviMBKhm/gkS/UHKQU6Lhx27H3gxc/Bqy1RxCRi+KgXJOi6Kha8kW
   12PsOoQIKu3qIBzWkeBkE7X+N7ixrb6J8qcmNQRlRRpg0auppAQgWrVRR
   Q==;
X-CSE-ConnectionGUID: WmqRxs9VQK2kNYGAEi/vEg==
X-CSE-MsgGUID: 2pMwkMfmRcuFvEvoHjCq0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976833"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976833"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:47 -0700
X-CSE-ConnectionGUID: drOz63qjT3CVdjLwRb7Brg==
X-CSE-MsgGUID: +FoUMOl5ScSmu6EOQj9pTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914516"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:47 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 14/18] iommufd: Allow allocating PASID-compatible domain
Date: Fri, 21 Mar 2025 10:19:36 -0700
Message-Id: <20250321171940.7213-15-yi.l.liu@intel.com>
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

The underlying infrastructure has supported the PASID attach and related
enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
extends iommufd to support PASID compatible domain requested by userspace.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v10 -> v11: make auto_hwpt always non-pasid-compat to avoid confussions
            between RID and PASID path
---
 drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
 include/uapi/linux/iommufd.h         | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 3724533a23c9..487779470261 100644
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
@@ -233,7 +234,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	if ((flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID)) ||
 	    !user_data->len || !ops->domain_alloc_nested)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent ||
@@ -290,7 +291,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags & ~IOMMU_HWPT_FAULT_ID_VALID)
+	if (flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!user_data->len)
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 8719d4f5d618..6901804ec736 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -393,6 +393,9 @@ struct iommu_vfio_ioas {
  *                          Any domain attached to the non-PASID part of the
  *                          device must also be flagged, otherwise attaching a
  *                          PASID will blocked.
+ *                          For the user that wants to attach PASID, ioas is
+ *                          not recommended for both the non-PASID part
+ *                          and PASID part of the device.
  *                          If IOMMU does not support PASID it will return
  *                          error (-EOPNOTSUPP).
  */
-- 
2.34.1

