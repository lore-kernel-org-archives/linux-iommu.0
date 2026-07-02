Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703E36896D
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972080; cv=none; b=rRNIJtUdHf7OSMkptI4C4oVBKkltE2SXr2q71Bn+4U+cysXc48AdBy3ai4524CpVrmvr0rKC/B4NPbYvcPAFNmSbxuUENeZ6Neo3SrFKiBS2lQuxBuxg3YdMokxgXhx1pKdVGZDCflsFsM93NUqMQnoVvQxYjqZog4OUe9k6Km8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972080; c=relaxed/simple;
	bh=eEQeJRiwKnkgZIXXyBCGHOaTOZfotVPbeQtPSPl6MDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFkLC93+gXP3leMH/EUtsegfEZZwyCeG37AuL8iMmrtSvMZE2GNzUVGBH8K4Au64LLu3LVbB5Ec1jmIPVZIfisWX/4XLzmj+hPHhpOJn3u669uKAzVv1ZNUfxM7Cs/a5RBnVHg/0ZD0XIfAb7cY+OvQUm1AiUIY1lwQI5Q4Adk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGg4KyUT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGg4KyUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972078; x=1814508078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eEQeJRiwKnkgZIXXyBCGHOaTOZfotVPbeQtPSPl6MDk=;
  b=jGg4KyUTqjSyvp6DKBICSNYAHlbX6RnCb/vCFGhi52owUFvOjMJBwvAP
   bUhzIQHfHhPxLYKbsirlEH3io2NwfSNpdmO5mIEg3N5N1R4YOwgH16ti+
   z5zKN3xrE/5cB2v6sf0SLvLpD0XytzTBELNXhatxJ/cNJt7GZV3cFJX8J
   3C4wubPq6LlB3R0QTbIwaqRoRy32FoO54ea5KEMxF9Wlo7yKBxKuu2qGR
   kw5Syfihqm8LOegWR0C5b9iUJE3mTlqH2AU8SkoiFROvElatHb8qrpdse
   dG9waxcLDl2hu+sAuuVJqTBU1Xb2VZ6jIfLbsYpWeuaM9jG9sntYGEWIF
   g==;
X-CSE-ConnectionGUID: Q+r1I9VRS8WFwnto8LKF1A==
X-CSE-MsgGUID: WzqXEsv0TDun3Vs01x26pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256466"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256466"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:18 -0700
X-CSE-ConnectionGUID: ZD8ZCMOGSy2JDkI/2kkPaQ==
X-CSE-MsgGUID: FzFHrPK1T7uzsj43BtWOxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425813"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:15 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
Date: Thu,  2 Jul 2026 06:12:10 +0000
Message-ID: <20260702061216.388743-4-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702061216.388743-1-kevin.tian@intel.com>
References: <20260702061216.388743-1-kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those are leftovers and unreachable now: the entire intel directory
is built only when CONFIG_INTEL_IOMMU is set.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2cee36138d6e..785aa3b62055 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1340,7 +1340,6 @@ static inline bool intel_domain_is_ss_paging(struct dmar_domain *domain)
 	return domain->domain.ops == &intel_ss_paging_domain_ops;
 }
 
-#ifdef CONFIG_INTEL_IOMMU
 extern int intel_iommu_sm;
 int iommu_calculate_agaw(struct intel_iommu *iommu);
 int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
@@ -1355,20 +1354,6 @@ static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
 extern int intel_iommu_tboot_noforce;
-#else
-static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
-{
-	return 0;
-}
-static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
-{
-	return 0;
-}
-#define dmar_disabled	(1)
-#define intel_iommu_enabled (0)
-#define intel_iommu_sm (0)
-#define intel_iommu_tboot_noforce (0)
-#endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
 		u64 dw0, u64 dw1, u64 dw2, u64 dw3)
-- 
2.43.0

