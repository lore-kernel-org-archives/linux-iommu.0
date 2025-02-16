Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3C13632B
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677958; cv=none; b=OysLj0uClIT1FeA08VVgdL7FABgQGnj9miMZ/C5QlMR4fdkg55GTQFa0iI48aB6WovbXDgWip7tQ0HguARjD7/tTB9ISixh7dLbw4g6ItNiH5TsqHakaIFoKx95WnYE3qn8v0pLY8wI0LUDWampra+U2sAav88Bxj4exZ8kBMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677958; c=relaxed/simple;
	bh=g76yQs23lFu2jEx0sokX6uIeA30iUsVAfGJnUlnGUj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PJ8SRWLgnL2bUudzlqtxHwDvinpzki1vio18LrB4v430Y0WMYv+tMO3a2Y1plH9bP1ESDi0JuvHk5NK0/mjWQgvD1AbPmEqRGICGdqw5FBdLIyUB0qu/RMqmXkumDELeP87l9ntrSopkquWg3gFIxmrbM0wWROIlMnLbO0+hd8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g03prw/P; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g03prw/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677956; x=1771213956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g76yQs23lFu2jEx0sokX6uIeA30iUsVAfGJnUlnGUj8=;
  b=g03prw/PLy00cPmN1cosv2XCW1bBDUjUE59nrGESp15tYi8fgLljLEHU
   dYj57SoHNCmHCRsarg7o+/tn5bINaXVgGxEFrnawXb6xnJ2IOnCiepQ8d
   NV4vTcVm7QC9u1ivO2bIrkn537rV4U8eK5xUcMC0FX858/DQp4ZFzRc0s
   K9Nj9IriolY8+0f6nyNktBQHjkbWkObT7hk3krgca4TErqB+uJHKfuCgl
   VPv2Rxgo2sHCNkukMge4aKcT/FsxV91RS2isxpfzzMH9HCsyIk8KWilVu
   4pTaEsR6KuYLzCOxjzij7oCkB4ggdpVOsRZWALozW2C8hw2WRk5U0dSPU
   A==;
X-CSE-ConnectionGUID: P1QjywjQQHmp2Xo+bcRSZg==
X-CSE-MsgGUID: DFQbpSIKTRaD1pRuqKl89Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919341"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919341"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:34 -0800
X-CSE-ConnectionGUID: MO0mHbsjQL6cK/bM6hz0HA==
X-CSE-MsgGUID: 8WVyFGIcR0WMLwTTPwKXOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544753"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 15 Feb 2025 19:52:35 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v7 08/13] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Date: Sat, 15 Feb 2025 19:52:23 -0800
Message-Id: <20250216035228.23831-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216035228.23831-1-yi.l.liu@intel.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
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

