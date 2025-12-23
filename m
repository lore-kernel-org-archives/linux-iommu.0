Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101F2D23A8
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473108; cv=none; b=Oxoh9LfTEyGZxv84tUetcsrF2uu/GnzNKqb21l66ZHC1mP0r5zzHMDu4pAVbZDmipkKZFTO9XTYXcMQnr9zYs/QPAUytmapuyQFf/Gp7xopcT7vQ+egXepg1+tjgrATA1Im6z9O7rQB0x99QRpIQ6Gv4t5DTCc/XpoEXNTtCTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473108; c=relaxed/simple;
	bh=zpaVwFbUivXP/cI2W4vCV3Tja5yvYCmqgql3KIFE9k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrmSd6QukRdfM0iiiCGD+N69TnBwhGCfbB61UiiW8XgYz89Mz7DyHmW53JixNAI8jp/ekAqcHGK5h+ZbUtBzQSlZaGQwfZEEIPeKcuzk+sM57tvfls92bF8YRUMVDvXMfhGfOt/vnb4Ef97F/cHMGlOno/evKtEN/kNmXBcoR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUWCpe5c; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUWCpe5c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766473106; x=1798009106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zpaVwFbUivXP/cI2W4vCV3Tja5yvYCmqgql3KIFE9k8=;
  b=lUWCpe5ciSuEL4QFTi59f67aQfZ9ny/1dkWyEt2iBwTcwYIMsCJtNwMv
   boK9lsczXGRhB2R0L0/BbCxD3u0VRFOv6DMOO1GPeR8d6HmPtxBif0OZV
   ZyMbcsweHwGCeMBNP4UcRi2Zj2NAe4y//rjs1w0nO/5/Hfe7VUaULx8zg
   a6LSQtuSKOfivspMgUDKbEeeYbvh4T8rI6Lo3XAC29Fcs4PJP+3YC3RwY
   xbTHE8asf8L8IX8S0fwkqJ74xE04jLhkuR6/DPPXRJjH6/HtsPPUK0pPi
   /1OhBkHE/470OfM4YhXqLm49o2GYlRcnF9vyoPyFQMg/+OsUHpKlM0o2E
   g==;
X-CSE-ConnectionGUID: sGQF5likTwaD24tvSFgjSg==
X-CSE-MsgGUID: t38QhK1DRhOUwqecb9akQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79684170"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="79684170"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 22:58:25 -0800
X-CSE-ConnectionGUID: NU4vTuCCQS2nMPWT+rxpnQ==
X-CSE-MsgGUID: oahmy5jcQpyeMo0vKOt1mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="237121402"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2025 22:58:25 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: joro@8bytes.org,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	jgg@nvidia.com
Subject: [PATCH v2] iommu/vt-d: Flush piotlb for SVM and Nested domain
Date: Mon, 22 Dec 2025 22:58:24 -0800
Message-ID: <20251223065824.6164-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides the paging domains that use FS, SVM and Nested domains need to
use piotlb invalidation descriptor as well.

Fixes: b33125296b50 ("iommu/vt-d: Create unique domain ops for each stage")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
Change log:
v2:
- Use domain.type to filter nested and SVA type domain. This eliminates
  the SVA domain ops reference issue when SVM is compiled out. (Kevin)
- Add a intel_domain_use_piotlb() helper to cover the three cases which
  need to flush piotlb. (Kevin)

v1: https://lore.kernel.org/linux-iommu/20251208091907.74719-1-yi.l.liu@intel.com/
---
 drivers/iommu/intel/cache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 265e7290256b..385ae5cfb30d 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -363,6 +363,13 @@ static void qi_batch_add_pasid_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16
 	qi_batch_increment_index(iommu, batch);
 }
 
+static bool intel_domain_use_piotlb(struct dmar_domain *domain)
+{
+	return domain->domain.type == IOMMU_DOMAIN_SVA ||
+			domain->domain.type == IOMMU_DOMAIN_NESTED ||
+			intel_domain_is_fs_paging(domain);
+}
+
 static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *tag,
 				  unsigned long addr, unsigned long pages,
 				  unsigned long mask, int ih)
@@ -370,7 +377,7 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	struct intel_iommu *iommu = tag->iommu;
 	u64 type = DMA_TLB_PSI_FLUSH;
 
-	if (intel_domain_is_fs_paging(domain)) {
+	if (intel_domain_use_piotlb(domain)) {
 		qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid, addr,
 				    pages, ih, domain->qi_batch);
 		return;
-- 
2.43.0

