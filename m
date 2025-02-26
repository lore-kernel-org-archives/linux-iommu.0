Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC6215769
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570042; cv=none; b=nBmmQTsxePYh7PcOmUdbLg/dsx0t5NP8q52GMgm+bPcdsiuwL/vxSY6otjEopvT56O3sGRvxLOZEqa4RVjMUSOLCKBViurk7WLPuaPArKTjxYd7r1dF71pcYjgXk+0oNNO+Z3GRE2VWdehnVNJ/WSPsJGtpsKSNejk6yTC7zKNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570042; c=relaxed/simple;
	bh=g76yQs23lFu2jEx0sokX6uIeA30iUsVAfGJnUlnGUj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nz3EG9kc0KiAO4tdFdpdV7DxmO0RfCgAGZe10YmovoHEW0HRQ1siIyszP3+qFNhDfBsPgbgGKvFfyYT2K+Cv6CWo3N2TwUYsOHAtkRi6Sa6/1I41lEV+86SHf8s6bRg8LNLqARmEhLKLgqg23RvmkL1pHyhzX77gNQwAtNfPN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNsmOc4l; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNsmOc4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570041; x=1772106041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g76yQs23lFu2jEx0sokX6uIeA30iUsVAfGJnUlnGUj8=;
  b=KNsmOc4l/86WDLu8x+9SYHW9HgkeckUyac80v0TUSEX5y0NqQYLYZpd1
   ql6+p7XEp1ooFmHWyAWtXbgd/iGE5GiVFhxeD3DZLilhIx/GHrWAr+N7d
   0RR88cqz301mHTryNKh1enLAwCfC+UzZ1kQXvri6ObCeSzRhMvVUd1UgU
   E2wLhgXnfY1aC4u6YSTSR+/w2YlZfb7YsgA4lOi8qhZOEtSX/2yKY2eOH
   PkUc2A23VCWK8xLL2f2mR5bVkM8sJdE3nEWFSkrRvLXR5DiyynESBhAJR
   eHLPTKPIheZ6+aA/i8IOfRS9kpc1AxrAMAsIeRLVWNVI+GIgKvXbBrGFx
   w==;
X-CSE-ConnectionGUID: x8gE+zebRBK8Rkqu+BgLKg==
X-CSE-MsgGUID: nt8fzeoRSoaeKaH8dSYsFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827099"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827099"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:36 -0800
X-CSE-ConnectionGUID: UZc9thtxQsaoPKtYROgvxA==
X-CSE-MsgGUID: PktiYADOSDODBTegAd9gTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171599"
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
Subject: [PATCH v8 08/12] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Date: Wed, 26 Feb 2025 03:40:28 -0800
Message-Id: <20250226114032.4591-9-yi.l.liu@intel.com>
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

Intel iommu driver just treats it as a nop since Intel VT-d does not have
special requirement on domains attached to either the PASID or RID of a
PASID-capable device.

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

