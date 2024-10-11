Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB50209686
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621143; cv=none; b=ivQthdRyDw/P7xk6PAlhZtUmZILksl/fhtXoA++RCuOhMbOQSACbHY+71gVt+p9GrRCSYdE5nGWDVwdtCFxlwXbXZjBUh1WHWKYUalto4ec8TahqRShZEJQ9em/jmQTrUflpb4borJU8hOp4TINkNyu2SW0cGV8Mynb0ETOfjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621143; c=relaxed/simple;
	bh=7l85wAhsV53A4Gthz5W2k1JJUWZgHM2JRy41YBqIVaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtU4kD9ajj2zKWbmGF89kDzb6UlwlyiLfHlYP71ndwqQ3j4AHgQo56LJ3izQyZHyMcbWidFvYqm0AgWMUYphI5JwD4gARHkQo9LqS7eOaRh78s+EOBYANZ9rcFfnmnjUFckMxSaGwC2YyBZRkZFxAJty76kESxBpRX/m0JpTu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkNIeV18; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkNIeV18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621142; x=1760157142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7l85wAhsV53A4Gthz5W2k1JJUWZgHM2JRy41YBqIVaM=;
  b=NkNIeV18pNfEVTtyNTkr46ecJ0zPmkVsVMNT++NvwyNQA73F/d3DYmYr
   xdtOeRS3ictqh9OcPItr0sjsM2BifzWg6OmN3BUZ9FufxO9gRKZqaJapq
   eQiuL5poEHRAwz6K82CQN+ZD3NLFYoAEM6ZZLtfRz+NY+VyMW69aLdVvm
   hSToa/e5DP+X76EICSLxXcVJQE37dOvROpMRYQWSUcA8ijJcmAtqZG4Zr
   eRT8Tb+cPxiQ0do9DgjT/sC+oPB7JR9G7PX1LCwHZM5JjVi5FyISi7eNv
   ONvuf5LR7WI4rA7GmjIDFOQMeLtSW3ciyO4IjfZFgQUuuRWxbWSVdkktJ
   w==;
X-CSE-ConnectionGUID: L0kom77TTJ2hyx2tSeq0lQ==
X-CSE-MsgGUID: asw3VWn7SpKo7M1kfVZrUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28101826"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28101826"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:32:22 -0700
X-CSE-ConnectionGUID: yiET3efXSuW5MTeQPCTlnA==
X-CSE-MsgGUID: mSPCexufQ8ScfnMgN9mQ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81412261"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 21:32:19 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 7/7] iommu/vt-d: Refine intel_iommu_domain_alloc_user()
Date: Fri, 11 Oct 2024 12:27:22 +0800
Message-ID: <20241011042722.73930-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011042722.73930-1-baolu.lu@linux.intel.com>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 70f3cbcc3160..02d0dc2c6490 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3297,6 +3297,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	struct intel_iommu *iommu = info->iommu;
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	bool first_stage;
 
 	/* Must be NESTING domain */
 	if (parent) {
@@ -3313,8 +3314,20 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
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

