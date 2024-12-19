Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCCF225A45
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614877; cv=none; b=g3w8dPtNJ3lny+5H3ooWHkRS3DivhT1GX/1YBlv+TsbkTG+trWZhqBN8adEnFlrSKlb3QpXvTtTewbSTlVYFJsCDSmJpypEkVJFqy8rnFLnVJTbJWwJzc9H8/1oW3N0x7xY9Z71aT+d7nc+k+6m0aEcLYHTPci7S/tYiKSYoNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614877; c=relaxed/simple;
	bh=LjXZy3D4E8cHf1e2AiavsRTAhxHXUIm0znoHAXz8a9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=re7I8G2m47xZbhbX9N/vA8S0LOaI8wJ+snHrCbrZsohgVU2oTw/4Y9ILbTQmDgpjKAojRYPpZZNVJDd/i4R+p39ZXeVbVb/2N9FUBPP0gKxhnIGpTXyWl7W1rYB1VSB5Ib6sKkcYKiNWuX39+tbaH7cocNZ3G/kXjCkD9mTRTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhNrcUrw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhNrcUrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614876; x=1766150876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LjXZy3D4E8cHf1e2AiavsRTAhxHXUIm0znoHAXz8a9s=;
  b=bhNrcUrw+3rfdJ0KshOyO6Jf9q8hNnBNGXCTDB2UZdmrSMdtgaHNR0XK
   3iGYM7Dimtal+3OEopj4rGBqMtXjBHKVYMkfR6ufx+GKDTHUMb/aFRWFd
   VOs4HhExNUyupivHjqgKIMbZIim8Jcx3UrP7UDb+HufKL7le0yy8sWYB9
   z56wwkDOPnVbiM10aING2p6mSN9O6z5WpWNy4Npp5VeGbgFpds2msWoJS
   NZO41DfEbNLq0JQmSiMy30uOeUQhjNae+TsruMC5gsrso3TjLvk67BsQC
   rMKpQra6AHVG57fD3KU3+vU9YJ1zzk53xzmBW1b/lFmkU15lRi7v4PSrP
   g==;
X-CSE-ConnectionGUID: OdeYAZmjQZWrGR/90ElQhg==
X-CSE-MsgGUID: EZv3yAaTSNeTEqBo3HA9NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542298"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542298"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:51 -0800
X-CSE-ConnectionGUID: LJ1r+vjGREeJI1Y+baYsTw==
X-CSE-MsgGUID: ZOSBcfj0Sl2AxCPCHOgzOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177329"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:50 -0800
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
Subject: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Date: Thu, 19 Dec 2024 05:27:41 -0800
Message-Id: <20241219132746.16193-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
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
index cd5e339fd5bb..0a622a89d876 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3347,7 +3347,8 @@ intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
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

