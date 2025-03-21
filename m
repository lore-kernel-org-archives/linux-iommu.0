Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFD22D785
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577594; cv=none; b=H9es6F2L+qhwS5ksCDpAu1WL/KQswNbXjjDdFS4P8frTwD6Et4Xndq5PuOFiX2YlBHo1F4oHd3tV929CsY+FzUOI7jSijcievRMogV3e+MVdBJmQGVKpAEwjSX6gBWz6rm5VbM077CZErK1c91vRcu9tuF53yVlFjP7T0Nodgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577594; c=relaxed/simple;
	bh=5qqe5wfjVMCe8ki0ELgpVyKjy/R1qRLhW9Ip/y7Rh/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncryBl63jzRsU0zkat4/4uUlXggzQmiABeL8cMJAJWROZHe0g2q/a7Cg3ZxVYjeSx1Cei6pfWscopYjZFnEEy4LXLwSipp3IZRLMCa6CrZfkhyE2No6r+MGx6V/2wUFQon1mb9OwFTeDLbgWUhos5kUPA+RV6M4XJxcaG7j0+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyrJ9Kd3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyrJ9Kd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577592; x=1774113592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5qqe5wfjVMCe8ki0ELgpVyKjy/R1qRLhW9Ip/y7Rh/E=;
  b=FyrJ9Kd3hbYmzn+RmjjC2vahhZnsGjEfzeAOIDCddEc1u/aOMJhMiwSW
   5tNwn4bVSfoifpI2kr3gyB5jlnhgQeWaZhLOyU5Wijd9M9lpOjZzxlBRV
   VSl8OY8vNRVpC7oOVZsno9si2iOFqifpD1WTDKEo4BXKzD+cAvAJIwWM8
   FNgJ+qGlfRGNxyT6K4dXToBVdOOS1vpVezdH8VL7UYcuX+DIbzO00XeHo
   oq+ta2BSAptCBqcKwdC+gt7uIuRArqPtJfVyYw4D4g0Fl4D3uMB0tl88r
   aRZqfgiPIW2un+QFQnNU76iT1VOvsYoyYLMyXyP32JNNefXy3QtxUPvsX
   Q==;
X-CSE-ConnectionGUID: OtofAIj6SFO7d/zp/8/wmA==
X-CSE-MsgGUID: kZmUON8aTj2T6sP4vs8f0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976830"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976830"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:47 -0700
X-CSE-ConnectionGUID: ObPo1oSRSGm3H3B1Zu9phg==
X-CSE-MsgGUID: hnkTZn+NQ0GDLfzBap7BZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914511"
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
Subject: [PATCH v11 13/18] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Date: Fri, 21 Mar 2025 10:19:35 -0700
Message-Id: <20250321171940.7213-14-yi.l.liu@intel.com>
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

Intel iommu driver just treats it as a nop since Intel VT-d does not have
special requirement on domains attached to either the PASID or RID of a
PASID-capable device.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 3 ++-
 drivers/iommu/intel/nested.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..7bc890609b90 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3338,7 +3338,8 @@ intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	bool first_stage;
 
 	if (flags &
-	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+	       IOMMU_HWPT_ALLOC_PASID)))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index aba92c00b427..6ac5c534bef4 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	struct dmar_domain *domain;
 	int ret;
 
-	if (!nested_supported(iommu) || flags)
+	if (!nested_supported(iommu) || flags & ~IOMMU_HWPT_ALLOC_PASID)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	/* Must be nested domain */
-- 
2.34.1

