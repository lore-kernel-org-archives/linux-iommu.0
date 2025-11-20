Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24726305946
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623667; cv=none; b=EmqIq/YQjS+2sSyqm3bdoqlUBwPA0z1GC0yZeRCNxzZXg/I+i/OW9zufHMB20Sxp9Z2EgMFC79njOXg984ma+CwiGwRsdvdY4fKSaeKYIqXgu3La1Tvch1SssBz+4L7nvf2myMW+4QHCD64jx6PW4kY5HA59x4YcxYQwcc/a3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623667; c=relaxed/simple;
	bh=ptjORu0u50L+Ut1e+sehWPAN+mFtSJgBawvfq1MVrtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVDI8kHZ58hk7/ZIClK3Y4QcthZ/GGN85oHeO7BBdkAhAkO0qeeNYURvqvUgk92S3u4eNbM8rXesfRbDcKiPri17VwN1IH5Cy0fklbjhSYEmAv3THC7xV4i56HrSEZQZTYSk1LcHiIBi9bBHRrCM6J24jLfJn+fIKaR+A8KPrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDX+OHk2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDX+OHk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763623664; x=1795159664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ptjORu0u50L+Ut1e+sehWPAN+mFtSJgBawvfq1MVrtk=;
  b=lDX+OHk2TF9YT4lWGrxS9L3RhJA/gQuMFR39pSyd/Hh5iIauMhgs13pI
   ualjOu6j40jT2XvO5iM0WLyI5yQEG/UcAKxO6vSPPzQ4cnxn+klcwnQxb
   cejfYZuX+FwTVEqheQIg2k6a3jdRlINgTmgHS1jRQJu8y92L+tIFZ5ABJ
   ERhktK/OffKpkYon9lCkE3A9GFVw4KCwW2jIJQ6wfPwhIRWt+cPtxY1+v
   6+X/JNxOWaDeb4GF4OW28Rgm4FAhabUX6HXvxI7kpy+yNHj20lFKFUdkV
   afcqd5XgssLSt/JbIKqlSwomuw42LnncSBH6zymsSsSQED/oAfvJCmskq
   Q==;
X-CSE-ConnectionGUID: cqf/ha1eR9GlvIE4ZCjiQg==
X-CSE-MsgGUID: euYRC1r4QTSAqBUKP88XpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65720151"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65720151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:27:43 -0800
X-CSE-ConnectionGUID: w+8tDen+RMKnirUCF72U5w==
X-CSE-MsgGUID: /H5rQ/yZSI2Oud6/KaMUiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191085137"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 19 Nov 2025 23:27:41 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Restore previous domain::aperture_end calculation
Date: Thu, 20 Nov 2025 15:25:24 +0800
Message-ID: <20251120072524.3218282-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d373449d8e97 ("iommu/vt-d: Use the generic iommu page table")
changed the calculation of domain::aperture_end. Previously, it was
calculated as:

    domain->domain.geometry.aperture_end =
            __DOMAIN_MAX_ADDR(domain->gaw - 1);

where domain->gaw was limited to less than MGAW.

Currently, it is calculated purely based on the max level of the page
table that the hardware supports. This is incorrect as stated in Section
3.6 of the VT-d spec:

  "Software using first-stage translation structures to translate an IO
   Virtual Address (IOVA) must use canonical addresses. Additionally,
   software must limit addresses to less than the minimum of MGAW and the
   lower canonical address width implied by FSPM (i.e., 47-bit when FSPM
   is 4-level and 56-bit when FSPM is 5-level)."

Restore the previous calculation method for domain::aperture_end to avoid
violating the spec. Incorrect aperture calculation causes GPU hangs
without generating VT-d faults on some Intel client platforms.

Fixes: d373449d8e97 ("iommu/vt-d: Use the generic iommu page table")
Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/r/4f15cf3b-6fad-4cd8-87e5-6d86c0082673@intel.com
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2d2f64ce2bc6..7b3016491ca5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2817,6 +2817,16 @@ intel_iommu_domain_alloc_first_stage(struct device *dev,
 		cfg.common.hw_max_vasz_lg2 = 57;
 	else
 		cfg.common.hw_max_vasz_lg2 = 48;
+
+	/*
+	 * Spec 3.6 First-Stage Translation:
+	 *
+	 * Software must limit addresses to less than the minimum of MGAW
+	 * and the lower canonical address width implied by FSPM (i.e.,
+	 * 47-bit when FSPM is 4-level and 56-bit when FSPM is 5-level).
+	 */
+	cfg.common.hw_max_vasz_lg2 = min(cap_mgaw(iommu->cap),
+					 cfg.common.hw_max_vasz_lg2);
 	cfg.common.hw_max_oasz_lg2 = 52;
 	cfg.common.features = BIT(PT_FEAT_SIGN_EXTEND) |
 			      BIT(PT_FEAT_FLUSH_RANGE);
-- 
2.43.0

