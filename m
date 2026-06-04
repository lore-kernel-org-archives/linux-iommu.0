Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38643BF693
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549581; cv=none; b=K7N7Aleba61UDdWDT3xOXr5uadKJQz9Fhb5KIEKF6xHP+kHpVuWUIX4HcNKSwYqBV03EwX4/ay2lnE7usHfP5lBR56fm3bg/+sS6LMelHeoEHIzd4oQ8OiXuTEo1esHkeCT7Vuy0stJiKbfGFthwFitcJCxVy8vGxur3Wx0akoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549581; c=relaxed/simple;
	bh=fr50bxFDZoN5oD6CVKRoBY4dTO3Z/daURhaYNGuwjrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY823jZtxbfnc2Eo0fNBO4gkiFIxlCFmi42Fo/KExPkuErZxfk5pyKu9f59ULquMnwDJxxxjdjaDbATak+6TnjaeprFZt7xd/J4T92KRBheMTpIa3kcDg1C0k4KjtL6M4H0SlHFPCY4Sh6YUUxKGhmW6LAE/f6llvUB5orLwwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQIsI9vW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQIsI9vW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780549580; x=1812085580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fr50bxFDZoN5oD6CVKRoBY4dTO3Z/daURhaYNGuwjrs=;
  b=HQIsI9vWYmvLjgkFAKefdEoKxzJI+0i+hxASzpqDTzCZ35Tyb+RKGKAz
   RPrQHjMU0CHVuuDutDXvhrd1aTCEh8G1XKc6AX9t0fKAIBf/1GSgitcxu
   unyZc81rRz0YC135YcRWau6WgXwCz5rJYRArXhxvkLU+59DiPGdyrbLFv
   TEDPi89bO/d6fHMqBnP+kDgG7king0pdCxWTt3rq9kY/PK+NwisFI/2Q+
   2Scb1gsxdvyz6Jk8yG0fKkJ6Ywx2Ni7bAfFukGIfAk69/JG2YSQ25+lAM
   BYYe1CJRGDr2BPmkUvrb03VJz8t8ehMXq7G9CqsKtm2nlw9saFo6+ksyF
   w==;
X-CSE-ConnectionGUID: RrLb3WOrTzSRWko6DI2oxQ==
X-CSE-MsgGUID: BV7wwYTJSkOiNo5bTtvuIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91943467"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91943467"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:06:20 -0700
X-CSE-ConnectionGUID: GictYhYeQYWBIYNZTRQerg==
X-CSE-MsgGUID: Qmd5NI/1QVCbRvsLVSu2gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246266448"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 22:06:17 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
Date: Thu,  4 Jun 2026 05:15:34 +0000
Message-ID: <20260604051540.592925-4-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604051540.592925-1-kevin.tian@intel.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
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
index e0ac9efa1aa9..bb8b973476f6 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1329,7 +1329,6 @@ static inline bool intel_domain_is_ss_paging(struct dmar_domain *domain)
 	return domain->domain.ops == &intel_ss_paging_domain_ops;
 }
 
-#ifdef CONFIG_INTEL_IOMMU
 extern int intel_iommu_sm;
 int iommu_calculate_agaw(struct intel_iommu *iommu);
 int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
@@ -1344,20 +1343,6 @@ static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
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

