Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69726659C
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869359; cv=none; b=OXMZp2VA+i+gKO7/m5HugM8WxgKmk4YiUA8BGiSmPxFawdeV+2If7Ba2ug2onu+8FAkv6+MvQSbpGiAvzIgJpIT7Fmw7qo90YjDS8N20QC5IQMJFYRnRPP6wsHatG9XXSScoo6tsm3X16g6P8mwosBtIurAr643xEV080M2I58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869359; c=relaxed/simple;
	bh=5qqe5wfjVMCe8ki0ELgpVyKjy/R1qRLhW9Ip/y7Rh/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=liWtjZyUemhDPXav4sEGWfuU2yYER4+iiiU9MIc3jBZKVQ09w4LaoX5lKyU+Ab51uZ7QK8xxoE4gWiWPNXhIj397n1Usr7PWrfGtFWJ+K52I0ihsRY8fupMC+jdyuf0My6IyfpU5H91dEeIRjkcdDHqxnIXFgjAYw2jhJYeDc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgViRMYw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgViRMYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869357; x=1773405357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5qqe5wfjVMCe8ki0ELgpVyKjy/R1qRLhW9Ip/y7Rh/E=;
  b=OgViRMYwAR4Arh0CvLIyMGU+ZispbgLHsncyVuWJFPN4Vo2sTegDvK1A
   77sT6Ct4BvvJyVS4SoVNIOQmVwpGVtLfetzQJ2ye07c5lNZN/+LyDqnwe
   y0p/gifope1uF2UcpDa9ij+SC/7lIhxhCyQnHAK1a8EVVEVY0abZyF6iq
   dTM0o60y9NHFlXsxQW0tvKknHOVGjHY0irJJ+ozpAqte7d0KkcbP6aLLu
   1sTLkEBu8yd+e+/3+l7UkjI76ypmwUS98VGsF9iTuysTJ/lMolO4kYf02
   h4uMRWsTqqw6kX9LVxfoieqVds2/1WI3nqEhGgrTE3K0wr6gVkOU6SfXu
   g==;
X-CSE-ConnectionGUID: IIqNedcISeGcv9Dn7WqE4A==
X-CSE-MsgGUID: Z0BC9uxZS+yWMIXp1s24uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863984"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863984"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:40 -0700
X-CSE-ConnectionGUID: E/ID3XP6QbylX35IQLlOIQ==
X-CSE-MsgGUID: 2YWc18M/QoSukqyRikfNOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005546"
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
Subject: [PATCH v9 16/21] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Date: Thu, 13 Mar 2025 05:35:27 -0700
Message-Id: <20250313123532.103522-17-yi.l.liu@intel.com>
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

