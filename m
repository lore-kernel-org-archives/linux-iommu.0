Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914324A0F
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715906268; cv=none; b=Zk7J94x4eDD+UKyEjLyKR0rhqTyDsIgGxouUrHfqm2pj2mfbtd/PyfKTFpPdB/Vrq2DYvQhXiTsyhdyP1Vb+WAJJm6B56oT3TUkRckzK/NS2r6kQqNbPlq8pwQ/oo0GkckfAns531VSGB/ywiPi85k3FNYrweceBeIO4lBzmdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715906268; c=relaxed/simple;
	bh=RsoDwxwTJmigE4wXYXquFNlckms3y6pHrxxvGaa20Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzEbEPtTGxl51R1KYRCU7xleVfQhBCEfQzeR4JS4FdDMHpz9oMqJkoJl9LaghPQS3t+0GIQpxwPPEJFRwaFT6an1+4d4/CkuK8Jtamhk8B95TQCEeHuFat74r/jdKNcnCHgz0mjbo5T/qPe0Zp5A99okKT5Usd1lnM1zcCIeRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kr0hs9CP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kr0hs9CP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715906266; x=1747442266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RsoDwxwTJmigE4wXYXquFNlckms3y6pHrxxvGaa20Ps=;
  b=kr0hs9CP349u0XRin5E2kVO0OTDHU7Qc2tSAgdVS+XVJdAKYMaJ3LnFn
   BBFiWWqY9mokoH9fgEPnxvK2dlEd8Es4fX4QiiF0qeigbeVQJlXl6uHOS
   Nr91o90Ru1aNWjv0n9lqnHde7EC4nXF3h1lnZ7TcN9LValsgT7eJLZqOb
   OsW1n5RHGJCRXJ+8Kk15/5ml52I4hCD7a1WcC2/hRzKs1m9rldBThxjs+
   AC5d3H8w/1h0ysoZhQwxvCRFlY+MZU6YmRIwRrsvYQMaETC+/MrzNqCFg
   sc+EEQ4S26ENZREfBFkwZYw997f7D353rPEisekEawGMydEnevTA977hq
   Q==;
X-CSE-ConnectionGUID: XIMwGizhT5mnSY63Tj9BsQ==
X-CSE-MsgGUID: gLJOfCehT9a78SBeQNNsAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11902658"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="11902658"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 17:37:45 -0700
X-CSE-ConnectionGUID: 74cnot/3TsON23vvMWd2rw==
X-CSE-MsgGUID: huxYs48qSzmL1JqVl+AF+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="32217210"
Received: from chunleis-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.214.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 17:37:43 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Batch IOTLB/dev-IOTLB invalidation commands
Date: Fri, 17 May 2024 08:37:28 +0800
Message-Id: <20240517003728.251115-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517003728.251115-1-tina.zhang@intel.com>
References: <20240517003728.251115-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilize batch command processing in IOTLB/dev-IOTLB invalidation
operations.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/cache.c | 76 ++++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index dcf5e0e6af17..0a06e8565554 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -19,6 +19,14 @@
 #include "pasid.h"
 #include "trace.h"
 
+/* The max number of descriptors in a batch processing*/
+#define QI_MAX_BATCH_DESC_COUNT 2
+
+struct qi_cmd_batch {
+	struct qi_desc desc[QI_MAX_BATCH_DESC_COUNT];
+	int num;
+};
+
 /* Check if an existing cache tag can be reused for a new association. */
 static bool cache_tage_match(struct cache_tag *tag, u16 domain_id,
 			     struct intel_iommu *iommu, struct device *dev,
@@ -254,6 +262,26 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
 }
 
+static inline void cache_invalidate_cmd_batch_submit(struct intel_iommu *iommu,
+						     struct qi_cmd_batch *cmds)
+{
+	if (!cmds->num)
+		return;
+
+	qi_submit_sync(iommu, cmds->desc, cmds->num, 0);
+	memset(cmds, 0, sizeof(struct qi_cmd_batch));
+}
+
+static inline void cache_invalidate_cmd_batch_add(struct intel_iommu *iommu,
+						  struct qi_cmd_batch *cmds)
+{
+	if (!cmds->desc[cmds->num].qw0)
+		return;
+
+	if (++cmds->num == QI_MAX_BATCH_DESC_COUNT)
+		cache_invalidate_cmd_batch_submit(iommu, cmds);
+}
+
 /*
  * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
  * when the memory mappings in the target domain have been modified.
@@ -264,21 +292,28 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 	unsigned long pages, mask, addr;
 	struct cache_tag *tag;
 	unsigned long flags;
+	struct intel_iommu *iommu = NULL;
+	struct qi_cmd_batch cmds = {0};
 
 	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
-		struct intel_iommu *iommu = tag->iommu;
 		struct device_domain_info *info;
 		u16 sid;
 
+		if (iommu != tag->iommu) {
+			cache_invalidate_cmd_batch_submit(iommu, &cmds);
+			iommu = tag->iommu;
+		}
+
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
 			if (domain->use_first_level) {
 				qi_flush_piotlb(iommu, tag->domain_id,
-						tag->pasid, addr, pages, ih, NULL);
+						tag->pasid, addr, pages,
+						ih, &cmds.desc[cmds.num]);
 			} else {
 				/*
 				 * Fallback to domain selective flush if no
@@ -288,13 +323,14 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 				    mask > cap_max_amask_val(iommu->cap))
 					iommu->flush.flush_iotlb(iommu, tag->domain_id,
 								 0, 0, DMA_TLB_DSI_FLUSH,
-								 NULL);
+								 &cmds.desc[cmds.num]);
 				else
 					iommu->flush.flush_iotlb(iommu, tag->domain_id,
 								 addr | ih, mask,
 								 DMA_TLB_PSI_FLUSH,
-								 NULL);
+								 &cmds.desc[cmds.num]);
 			}
+			cache_invalidate_cmd_batch_add(iommu, &cmds);
 			break;
 		case CACHE_TAG_NESTING_DEVTLB:
 			/*
@@ -310,23 +346,25 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 		case CACHE_TAG_DEVTLB:
 			info = dev_iommu_priv_get(tag->dev);
 			sid = PCI_DEVID(info->bus, info->devfn);
-
 			if (tag->pasid == IOMMU_NO_PASID)
 				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
 						   info->ats_qdep, addr, mask,
-						   NULL);
+						   &cmds.desc[cmds.num]);
 			else
 				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
 							 tag->pasid, info->ats_qdep,
-							 addr, mask, NULL);
+							 addr, mask, &cmds.desc[cmds.num]);
+			cache_invalidate_cmd_batch_add(iommu, &cmds);
 
 			quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid,
-						  info->ats_qdep, NULL);
+						  info->ats_qdep, &cmds.desc[cmds.num]);
+			cache_invalidate_cmd_batch_add(iommu, &cmds);
 			break;
 		}
 
 		trace_cache_tag_flush_range(tag, start, end, addr, pages, mask);
 	}
+	cache_invalidate_cmd_batch_submit(iommu, &cmds);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
 
@@ -338,40 +376,50 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 {
 	struct cache_tag *tag;
 	unsigned long flags;
+	struct intel_iommu *iommu = NULL;
+	struct qi_cmd_batch cmds = {0};
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
-		struct intel_iommu *iommu = tag->iommu;
 		struct device_domain_info *info;
 		u16 sid;
 
+		if (iommu != tag->iommu) {
+			cache_invalidate_cmd_batch_submit(iommu, &cmds);
+			iommu = tag->iommu;
+		}
+
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
 			if (domain->use_first_level)
 				qi_flush_piotlb(iommu, tag->domain_id,
 						tag->pasid, 0, -1, 0,
-						NULL);
+						&cmds.desc[cmds.num]);
 			else
 				iommu->flush.flush_iotlb(iommu, tag->domain_id,
 							 0, 0, DMA_TLB_DSI_FLUSH,
-							 NULL);
+							 &cmds.desc[cmds.num]);
+			cache_invalidate_cmd_batch_add(iommu, &cmds);
 			break;
 		case CACHE_TAG_DEVTLB:
 		case CACHE_TAG_NESTING_DEVTLB:
 			info = dev_iommu_priv_get(tag->dev);
 			sid = PCI_DEVID(info->bus, info->devfn);
-
 			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
-					   0, MAX_AGAW_PFN_WIDTH, NULL);
+					   0, MAX_AGAW_PFN_WIDTH, &cmds.desc[cmds.num]);
+			cache_invalidate_cmd_batch_add(iommu, &cmds);
+
 			quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
 						  IOMMU_NO_PASID, info->ats_qdep,
-						  NULL);
+						  &cmds.desc[cmds.num]);
+			cache_invalidate_cmd_batch_add(iommu, &cmds);
 			break;
 		}
 
 		trace_cache_tag_flush_all(tag);
 	}
+	cache_invalidate_cmd_batch_submit(iommu, &cmds);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
 
-- 
2.39.3

