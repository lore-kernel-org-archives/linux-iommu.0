Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF4818BB82
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684494; cv=none; b=UyRcbJwdUlOQ/jLh+LTNU1CunYESl0xsLvclTSjifSYDQA3yKbORdKohb3yfO+G/8qeKEBbTLs9fSyUod9RRlUFAD9VGDFzpkW3dqzecrgPjmXT/b3T0xjCptUtRKM03tLzv9ljQxZ64xKlF1jC3FovywOoguSdc2oH1KF78Uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684494; c=relaxed/simple;
	bh=hHWOhtrzyy1oJVxolJisT1bL+SjbIN7Mcj7uqoaKufU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/dtmlI1zgXPJDBu3l8rXxSRJzA5Rj4MiNpC9qbu8zD+YssRayM2QuPAMql4IOM0YvJBmVaPGvGChHpsq09SpGXn3Qjb32Rz8wBs0zPzOEob+G4Cn1t17uwJoPf9prJcMwda/858y6Ea60jlCcFmiMusPed0Xc1oi/7i2R39h8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ksdz9Mjt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ksdz9Mjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684493; x=1762220493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHWOhtrzyy1oJVxolJisT1bL+SjbIN7Mcj7uqoaKufU=;
  b=Ksdz9MjtN0CAphMEuWZez0U9MfjMI2xTJB7dEKx4b9LZzaw6YPwhTn0P
   Yiduqyc0HqqI2Gk3cCxZ/00aCJAGE8cSgpVoq+bTtImtZv7cg1EtFM8/H
   TVXT9bn/VUjkiGnciP1nQQKSb4hUIpwqK1vy/0j6vrcb7Jtb4sDs5/CHC
   /8ItKCm+zJbxWW8hAEDXbO5pY296vQT60bcKxmBn9Q6rmid7IAkIpdi3Z
   onqkj6FDQbqY9jII0g7WYZPN5X3o7GwNpcxLSQpXo/wpkcE+rB1L5YShO
   0vpIosJYXOVUnDab2RF0ZaXe3vjJa7FayKiUOrpvJylZs0SzCJxonzLR0
   w==;
X-CSE-ConnectionGUID: bLUqTaOHQR25QZqh7x2Wxw==
X-CSE-MsgGUID: g6YW2RHYTCuJC93kJV5eXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221930"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221930"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:33 -0800
X-CSE-ConnectionGUID: elTsiTcpTQS/52W7Ulji1Q==
X-CSE-MsgGUID: uRBZJ9L0Qhu8gqaUZEloqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020884"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:32 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] iommu/vt-d: Refine intel_iommu_domain_alloc_user()
Date: Mon,  4 Nov 2024 09:40:27 +0800
Message-ID: <20241104014040.106100-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The domain_alloc_user ops should always allocate a guest-compatible page
table unless specific allocation flags are specified.

Currently, IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_ALLOC_DIRTY_TRACKING
require special handling, as both require hardware support for scalable
mode and second-stage translation. In such cases, the driver should select
a second-stage page table for the paging domain.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20241021085125.192333-8-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ebdb97835fc3..5fbf1237188c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3299,6 +3299,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	struct intel_iommu *iommu = info->iommu;
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	bool first_stage;
 
 	/* Must be NESTING domain */
 	if (parent) {
@@ -3315,8 +3316,20 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	/* Do not use first stage for user domain translation. */
-	dmar_domain = paging_domain_alloc(dev, false);
+	/*
+	 * Always allocate the guest compatible page table unless
+	 * IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING
+	 * is specified.
+	 */
+	if (nested_parent || dirty_tracking) {
+		if (!sm_supported(iommu) || !ecap_slts(iommu->ecap))
+			return ERR_PTR(-EOPNOTSUPP);
+		first_stage = false;
+	} else {
+		first_stage = first_level_by_default(iommu);
+	}
+
+	dmar_domain = paging_domain_alloc(dev, first_stage);
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
 	domain = &dmar_domain->domain;
-- 
2.43.0

