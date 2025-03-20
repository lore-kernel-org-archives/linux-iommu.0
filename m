Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131751EDA38
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478476; cv=none; b=pzVPNtMCxT020ddKTnHtcSSXfmAV36obSRNES4S/HaN7XgJOdzIz7wJSeXUuSODjQ2b/99NE8jJtGcW/ZKzPewbpaYPazswI5ZsLk0d36G3bIKCaE0Udgefw4SIX0jqKES5E0402/Zc1bdEBvzS11uxDqnAOBBMtya76tyfOKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478476; c=relaxed/simple;
	bh=MbFUnfUs5WWbMyvhcCVJ0o+OZoqopmM9Oz2Hn4hEvXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5byGKKQEt9qwO3WDbH1Yqb8PlJi/k1uaTQia1hui83PtC/1hHIHF33OpEnpH/DGboLjhV6YP0fDgg03gqlHaid45DP/dazvnGJYMAHuBwZgo7OYi4L14qpu7g+ZB78XbFloJolz7z5jrfsG94/tdyi/Yr+9QGzarR+kVQUYi6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSTOoGMC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSTOoGMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478475; x=1774014475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MbFUnfUs5WWbMyvhcCVJ0o+OZoqopmM9Oz2Hn4hEvXc=;
  b=iSTOoGMCRpcYpHgWzKrbA7azNKJZgsbY/BdQNBHL2F8stUNuxf4HWPyd
   QvmnsbpNryMZwmtx6BUR1JxIxKimTM5XQ8FmuCmdrTVAeF79NO4YWIVp0
   HpqRYME/ja/zEERLz/WHNbtf/0hHopknBXbQfzHtVUYxa2l6ACcwy+d+D
   VqSCcpHwfCwbL73ZjGzHUaGstVQ2ZLIvecxHzCe7dqb2lhOKxI5BzovSo
   lNjCKj19rG6vfJ9rNDNIAjj52jgmwC1PHZXlFIzqxxdnBTTMySG4QyCOf
   RfyJ+9xJleP1ZLYmSO43/JhtH7D22djYveQ8hcFRLxxo4t/74HnyapPjP
   g==;
X-CSE-ConnectionGUID: 0iE6KYbtRRa2MKR+JKI1dQ==
X-CSE-MsgGUID: eEAlCJ60T4udAA4syHW3kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063075"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063075"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:48 -0700
X-CSE-ConnectionGUID: RXEdM5qJQd6f033tE5EyBg==
X-CSE-MsgGUID: QrQmi4MmSt6lOBHaD9hAnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319183"
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
Subject: [PATCH v10 13/18] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Date: Thu, 20 Mar 2025 06:47:39 -0700
Message-Id: <20250320134744.5777-14-yi.l.liu@intel.com>
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

Intel iommu driver just treats it as a nop since Intel VT-d does not have
special requirement on domains attached to either the PASID or RID of a
PASID-capable device.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v9 -> v10: Dropped the auto_domain terms in commit message
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

