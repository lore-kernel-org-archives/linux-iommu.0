Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C944C65E
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887682; cv=none; b=gepO6t02pBya+wvENaNSFf2Q041ImKcr1UF9YB9yL5soqtH2CpWDxwCVFNxoBhLYgPjNFJUQXFqyFhm7ThSZhGcfMZBqkvpaKF1Tsa9ribLahVI8dL+69CbBKpNGTOyU1S4u4S7bptKyCaA9yV2+XN1IsDq5S0ZDJhdevh8vQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887682; c=relaxed/simple;
	bh=Fms6Rbz+/KJEXKC76z5BRIO8rQtmau8kHn5raAO6hWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRP3Gr7C+/R5fu2O9yP6hHs6weC+TsH64B3fQ90Rj7vW1Fcdk2t/jHaehmY8tA89VRhURdCRwix7GYft8aVXjQQ3qbnl9JaSGN8wmoD+PfZe9W2Zp165zQDgZqFtIVaPuttbtsew2bW65IgVEtXZNyfn/SnZKFIG/O0jKRZkuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eqegvrpj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eqegvrpj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887680; x=1817423680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fms6Rbz+/KJEXKC76z5BRIO8rQtmau8kHn5raAO6hWY=;
  b=Eqegvrpj76dk/WpWssup5cjjqGTdlbKo9y6Zk/48ZwQqNMwWUWw7IDUJ
   L6Yir03x3e/A5pi+yPXbEPR0UODzOKVj7WZ9uiPzCXEj2Bs8Y7k/JMm1J
   G+OdrBmOBgBI1HAJAzykRnQKrhIwNbs78+eQB5WMmmTYArOWNZQ+SwsMj
   C/YL9ayzPWRRhh8k3uOj+W0mr+okADc+jwmIzAQhYS4tyzb3mroAm4yCu
   m5bggS3B1eOBjjV+FJucT6tXC2HdDfmMNNgdGH2WQkX2JRCRGNQlclgWz
   PspM9HHOaxoLY+7VNpQt9WHL4hg+cOz+FwtJHo2FfrzoJZlXhEnKlFA9+
   g==;
X-CSE-ConnectionGUID: 7+kAY6jfQkmWQNOCuwwVwQ==
X-CSE-MsgGUID: BiTm2agASOOYNQ/lqs3LLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263253"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263253"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:39 -0700
X-CSE-ConnectionGUID: z0dG605mQBuDFYVk2cpXSQ==
X-CSE-MsgGUID: 9+79yXaeSSGPBiAktxi9JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324358"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:37 -0700
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
Subject: [PATCH v2 07/19] iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
Date: Wed,  5 Aug 2026 07:43:01 +0800
Message-ID: <20260804234314.3087110-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
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

