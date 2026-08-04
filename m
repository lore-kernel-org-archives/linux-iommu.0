Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333833F3294
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811721; cv=none; b=NSddoG607XiEeVPH2lEbebM5MGfFeXpai8AXWJAsbgljBwVEHdZ0LAVsYCeFeozTgabcXbl0W6lP3I3ywxCEyxAFC9WyKjks9K7eKJNYvc9i2vbKyZJZfSYJJ6EFJBb95ehfyyvNU2Zk1hHgMxrRn170j7t9YzWqq++xQigu4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811721; c=relaxed/simple;
	bh=Fms6Rbz+/KJEXKC76z5BRIO8rQtmau8kHn5raAO6hWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsII9bMcLkR/kfJR0uDwKM5Mv3tDC7tKcWdy2tMWZi2Qg1vMpLNkmO0+qSvnK7MxHXXhNlGFyAgXV4Ci9c9Gehfd6lNHEwDVS6NyBLBF/xnIHd3nMsZpyffyzSfAjxAfTHMQnOMZTJ05qHqYE2hCCAAVELBVo0SBCGQlVfaq3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eg/uTaBB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg/uTaBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811719; x=1817347719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fms6Rbz+/KJEXKC76z5BRIO8rQtmau8kHn5raAO6hWY=;
  b=Eg/uTaBB62zETG9k1V1kB3IyulyODcWAc6PCTejj8a0aGQ+I3RWkdWb/
   Kg/5DwPTqVD63e429uo+lNmnh7WzlRXeIYNaSHx3/eTQLM1Cm2kAx6dA8
   +EHhOzGR64zmbD+GfNer9BWcs92q5kCMBrfAineco9rBmT12GV5eVtA0g
   4xcdiBVtSAiUrYbE3/dagW4odvxcnwQHezxmtw/75yc8dUYotMDDcMIck
   oz/UzPt33f85FSSxh9iv+L80zmUaWlR32FDvML3j4VN5FsnJKF8vx6H+z
   bQmxX3JoEEEPrqlnxzTXTuWeceMtQFwOmYDAhk43DX8HXG+Cel1Io2AW/
   w==;
X-CSE-ConnectionGUID: h7FtqLCoTh+tsuXpTqYKkA==
X-CSE-MsgGUID: uCXur3yFQWqXWRIJZdfe6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231273"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231273"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:39 -0700
X-CSE-ConnectionGUID: OFqmluWSSPGS5c47jzdDQA==
X-CSE-MsgGUID: xK6staLGRIS1x4vuCzDmgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587494"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
Date: Tue,  4 Aug 2026 10:37:01 +0800
Message-ID: <20260804023714.3080506-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Tian <kevin.tian@intel.com>

Those are leftovers and unreachable now: the entire intel directory
is built only when CONFIG_INTEL_IOMMU is set.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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

