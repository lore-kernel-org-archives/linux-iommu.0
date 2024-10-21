Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC61E4123
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501002; cv=none; b=L/WTe76McsMCpBDBCozGQAW+SXM8iox4VFKa9d+8TVPn2u+ZdwDl5tfZIY56tjmPo92l0nFi+jWQjH+Ytl4CmitzSZH0Feb25OStFEOdUKLl2sQomUS5XeTfOWO2HPXfC9wZ/H1ksH/btOzcNckwF2izv+hxmhFAK0KQRbXdybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501002; c=relaxed/simple;
	bh=Tbzk8V51fVW+LwkB30xCPUlXehhiTd4lUy3vVxrhRKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDoFp2i6LJpxLHCJGIZIFstWEUR1ND1fDwlTpM5tcctVDRVLFU6nLqZg9jpjynoWrV/u2idgjzXR2HWRHIqJALnJVpSWAiuIiicRW2Tr7SzfBxVLhMtcW3l5o7rzz4DE4wAMF7/KVPNV8EoUInT9NVG0O7MPMX1Gn7WPHJaXR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjEkMnPO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjEkMnPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729501001; x=1761037001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tbzk8V51fVW+LwkB30xCPUlXehhiTd4lUy3vVxrhRKw=;
  b=AjEkMnPOD/N7fCTnNVwVdnijLKl6KgOk5Asti1FNaS1JaTQY+bKyPsup
   Y82gxdElsOoHEU3nEGeZ/4Zt0u9LVoGJHnSGV2FhzIVh3TpX4cCjokKdE
   iq2SRcDkXWkttxVtiYccEbRiyMcAOynArnKLhhEvgjX4cmjVaIN/raQtl
   ujs/RoILaYu88KJ+9allZDpTpVVXVtj7Pm3rJtwlpStZxNII5g4+moVEV
   320Elmr1bOuYPNUZcCf5ES5pqloSaOxjvw+JF4rRtFyx2H+LNGicvdsdp
   AciXXBmleUiPVqtsrdyIvQSxHn4FUtSWip7MKXIK48wrE2VlwYA3GVaRx
   g==;
X-CSE-ConnectionGUID: ZJMaGuSRSZqT3US4NLVs6g==
X-CSE-MsgGUID: LpXCsXnkRYC2Bf9W3XV+gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32780391"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32780391"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:56:41 -0700
X-CSE-ConnectionGUID: ZdfzkpVEQTKMlDCFIOscXw==
X-CSE-MsgGUID: NzmZKRbdTgC9gNuCVrvutA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79812794"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 01:56:38 -0700
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
Subject: [PATCH v2 7/7] iommu/vt-d: Refine intel_iommu_domain_alloc_user()
Date: Mon, 21 Oct 2024 16:51:24 +0800
Message-ID: <20241021085125.192333-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021085125.192333-1-baolu.lu@linux.intel.com>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bad9593f2464..2b5027dd0c96 100644
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

