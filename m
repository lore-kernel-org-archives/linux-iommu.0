Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9483A1C9
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244304; cv=none; b=GqJg35p/DF12km4t+L17CjyXwngS72iifmqG6yGlRLE4TnKwAs8+vI48znBjVAgpyOZboOXhr425aiCzXPm/PUjtmZ8REl1SLAL0ke9y5zfjmXZGlTm2zCbkCDsxdSaRWThmse9ju53SmI/xUx0J3+H2nO5ZtHenZu5PLRR5sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244304; c=relaxed/simple;
	bh=4bOekfGoUt0BjvOBLIs3P9Ihuchvum6NOSE4iIcjOUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kzbdk49hNTHkcz++wMXgMWTZK0Ouz8zZ3/goL1GUgiA1OhY9elEl+Z+xq8sW9I4OGMgIje21jDW0P0yQrVVI5/dDJSf8ClhjAok1yLL3Bi93R3liSP3B5GO/6I8xgXvjVED4yWf2Qb9r4mw9DmpPkd/bSaq6tUfiREMMzRt+spo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoUA5xbI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoUA5xbI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244303; x=1756780303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4bOekfGoUt0BjvOBLIs3P9Ihuchvum6NOSE4iIcjOUA=;
  b=ZoUA5xbI7K9+7xNbKDkaIcN3KqP+ESlY348U5mSDZ4pA2xugmB4o+G3H
   uvYesl2Pv+NyBrs4b+ftfLtBFK2PBW6v725WQSxFF1lJQ/Bnpi/0h1gA7
   gx9zPPXNHiLbhJeBVenl7TJVDVfgO2/7FON9LpJbAlmTc4LlAfrnVKpxP
   mKj62+pwpnNwnET9P/rlayCAZrb1xpHO+ojHDlL6Ffh/gMN1CpggWYgt+
   /YyzmcTMverMkzgwEEfFLEDAhAplp5b43uwqI2DIOPe4HyOCF8nybTvNN
   t6d4+moYIAe6BHCSyIyZeFcbPeAZAkYluGIVEHSaS8isoRpv+rqqFQF1i
   A==;
X-CSE-ConnectionGUID: 0RJgsKeYSd6Ms1O0aQMN3A==
X-CSE-MsgGUID: 9VIpCVzaQtC3KaUPqdZFXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994346"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994346"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:42 -0700
X-CSE-ConnectionGUID: KQjXHFpIRM+j72ssQHoQog==
X-CSE-MsgGUID: TYMCf4PiSAmUyMZjhAyAPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359353"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush for batching
Date: Mon,  2 Sep 2024 10:27:22 +0800
Message-Id: <20240902022724.67059-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

Extracts IOTLB and Dev-IOTLB invalidation logic from cache tag flush
interfaces into dedicated helper functions. It prepares the codebase
for upcoming changes to support batched cache invalidations.

To enable direct use of qi_flush helpers in the new functions,
iommu->flush.flush_iotlb and quirk_extra_dev_tlb_flush() are opened up.

No functional changes are intended.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20240815065221.50328-3-tina.zhang@intel.com
---
 drivers/iommu/intel/iommu.h |   3 +
 drivers/iommu/intel/cache.c | 142 ++++++++++++++++++++----------------
 drivers/iommu/intel/iommu.c |   5 +-
 3 files changed, 83 insertions(+), 67 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8884aae56ca7..ba40db4f8399 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1206,6 +1206,9 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		   unsigned int count, unsigned long options);
+
+void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+			 unsigned int size_order, u64 type);
 /*
  * Options used in qi_submit_sync:
  * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 44e92638c0cd..08f7ce2c16c3 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -255,6 +255,78 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
 }
 
+static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *tag,
+				  unsigned long addr, unsigned long pages,
+				  unsigned long mask, int ih)
+{
+	struct intel_iommu *iommu = tag->iommu;
+	u64 type = DMA_TLB_PSI_FLUSH;
+
+	if (domain->use_first_level) {
+		qi_flush_piotlb(iommu, tag->domain_id, tag->pasid, addr, pages, ih);
+		return;
+	}
+
+	/*
+	 * Fallback to domain selective flush if no PSI support or the size
+	 * is too big.
+	 */
+	if (!cap_pgsel_inv(iommu->cap) ||
+	    mask > cap_max_amask_val(iommu->cap) || pages == -1) {
+		addr = 0;
+		mask = 0;
+		ih = 0;
+		type = DMA_TLB_DSI_FLUSH;
+	}
+
+	if (ecap_qis(iommu->ecap))
+		qi_flush_iotlb(iommu, tag->domain_id, addr | ih, mask, type);
+	else
+		__iommu_flush_iotlb(iommu, tag->domain_id, addr | ih, mask, type);
+}
+
+static void cache_tag_flush_devtlb_psi(struct dmar_domain *domain, struct cache_tag *tag,
+				       unsigned long addr, unsigned long mask)
+{
+	struct intel_iommu *iommu = tag->iommu;
+	struct device_domain_info *info;
+	u16 sid;
+
+	info = dev_iommu_priv_get(tag->dev);
+	sid = PCI_DEVID(info->bus, info->devfn);
+
+	if (tag->pasid == IOMMU_NO_PASID) {
+		qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
+				   addr, mask);
+		if (info->dtlb_extra_inval)
+			qi_flush_dev_iotlb(iommu, sid, info->pfsid,
+					   info->ats_qdep, addr, mask);
+		return;
+	}
+
+	qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid, tag->pasid,
+				 info->ats_qdep, addr, mask);
+	if (info->dtlb_extra_inval)
+		qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid, tag->pasid,
+					 info->ats_qdep, addr, mask);
+}
+
+static void cache_tag_flush_devtlb_all(struct dmar_domain *domain, struct cache_tag *tag)
+{
+	struct intel_iommu *iommu = tag->iommu;
+	struct device_domain_info *info;
+	u16 sid;
+
+	info = dev_iommu_priv_get(tag->dev);
+	sid = PCI_DEVID(info->bus, info->devfn);
+
+	qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
+			   MAX_AGAW_PFN_WIDTH);
+	if (info->dtlb_extra_inval)
+		qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
+				   MAX_AGAW_PFN_WIDTH);
+}
+
 /*
  * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
  * when the memory mappings in the target domain have been modified.
@@ -270,30 +342,10 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
-		struct intel_iommu *iommu = tag->iommu;
-		struct device_domain_info *info;
-		u16 sid;
-
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
-			if (domain->use_first_level) {
-				qi_flush_piotlb(iommu, tag->domain_id,
-						tag->pasid, addr, pages, ih);
-			} else {
-				/*
-				 * Fallback to domain selective flush if no
-				 * PSI support or the size is too big.
-				 */
-				if (!cap_pgsel_inv(iommu->cap) ||
-				    mask > cap_max_amask_val(iommu->cap))
-					iommu->flush.flush_iotlb(iommu, tag->domain_id,
-								 0, 0, DMA_TLB_DSI_FLUSH);
-				else
-					iommu->flush.flush_iotlb(iommu, tag->domain_id,
-								 addr | ih, mask,
-								 DMA_TLB_PSI_FLUSH);
-			}
+			cache_tag_flush_iotlb(domain, tag, addr, pages, mask, ih);
 			break;
 		case CACHE_TAG_NESTING_DEVTLB:
 			/*
@@ -307,18 +359,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			mask = MAX_AGAW_PFN_WIDTH;
 			fallthrough;
 		case CACHE_TAG_DEVTLB:
-			info = dev_iommu_priv_get(tag->dev);
-			sid = PCI_DEVID(info->bus, info->devfn);
-
-			if (tag->pasid == IOMMU_NO_PASID)
-				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
-						   info->ats_qdep, addr, mask);
-			else
-				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
-							 tag->pasid, info->ats_qdep,
-							 addr, mask);
-
-			quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid, info->ats_qdep);
+			cache_tag_flush_devtlb_psi(domain, tag, addr, mask);
 			break;
 		}
 
@@ -338,29 +379,14 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
-		struct intel_iommu *iommu = tag->iommu;
-		struct device_domain_info *info;
-		u16 sid;
-
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
-			if (domain->use_first_level)
-				qi_flush_piotlb(iommu, tag->domain_id,
-						tag->pasid, 0, -1, 0);
-			else
-				iommu->flush.flush_iotlb(iommu, tag->domain_id,
-							 0, 0, DMA_TLB_DSI_FLUSH);
+			cache_tag_flush_iotlb(domain, tag, 0, -1, 0, 0);
 			break;
 		case CACHE_TAG_DEVTLB:
 		case CACHE_TAG_NESTING_DEVTLB:
-			info = dev_iommu_priv_get(tag->dev);
-			sid = PCI_DEVID(info->bus, info->devfn);
-
-			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
-					   0, MAX_AGAW_PFN_WIDTH);
-			quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
-						  IOMMU_NO_PASID, info->ats_qdep);
+			cache_tag_flush_devtlb_all(domain, tag);
 			break;
 		}
 
@@ -399,20 +425,8 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 		}
 
 		if (tag->type == CACHE_TAG_IOTLB ||
-		    tag->type == CACHE_TAG_NESTING_IOTLB) {
-			/*
-			 * Fallback to domain selective flush if no
-			 * PSI support or the size is too big.
-			 */
-			if (!cap_pgsel_inv(iommu->cap) ||
-			    mask > cap_max_amask_val(iommu->cap))
-				iommu->flush.flush_iotlb(iommu, tag->domain_id,
-							 0, 0, DMA_TLB_DSI_FLUSH);
-			else
-				iommu->flush.flush_iotlb(iommu, tag->domain_id,
-							 addr, mask,
-							 DMA_TLB_PSI_FLUSH);
-		}
+		    tag->type == CACHE_TAG_NESTING_IOTLB)
+			cache_tag_flush_iotlb(domain, tag, addr, pages, mask, 0);
 
 		trace_cache_tag_flush_range_np(tag, start, end, addr, pages, mask);
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index eab87a649804..779e258188cd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1184,9 +1184,8 @@ static void __iommu_flush_context(struct intel_iommu *iommu,
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-/* return value determine if we need a write buffer flush */
-static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
-				u64 addr, unsigned int size_order, u64 type)
+void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+			 unsigned int size_order, u64 type)
 {
 	int tlb_offset = ecap_iotlb_offset(iommu->ecap);
 	u64 val = 0, val_iva = 0;
-- 
2.34.1

