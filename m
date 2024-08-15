Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC417A58C
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704811; cv=none; b=G6hTufE5LD+lTQ9CGfz8GWfOCv7XPRg33ivIxRZ+WKanDyPpdzqqx3hxaP2hPgQx59N/Wk8aytM4muvEt/9+hvpbbssc0ljLi2Rw6nV4v1J2cCkEhxWEmMQET/Hy4y5qkmhAzHghx4QQfrphDB8BcEj/pLrqH8iB18n3ahcCGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704811; c=relaxed/simple;
	bh=NxnI69OedtlYQflM+SHnZiz78ueK/p8w3vNn+Ui1nB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyMTOzw5xyLSp+xRUaDO6h53j284ksSsIR7tK9+cNvj1874h1zyvu1F+GjC+P4qO1gMU3bQcVoQE0NWETMw8Yx7tHv+eIf9y6pWTZtYdN5RIdgxzJ3/YQt5VW+VerMt8yX7qoABl0ajZmTBVV2MC8Ac60wCboowAc94oVH9aU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5yfCzes; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5yfCzes"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723704809; x=1755240809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NxnI69OedtlYQflM+SHnZiz78ueK/p8w3vNn+Ui1nB4=;
  b=B5yfCzes1KBNMlA1nDSCSAZ+Tz03/EGMxHaBWIurg7bIazA4bHrugxC0
   b9VqZXmSSMd8wg7huu2RYU5kQ6sXNXfMhFC9SSJIxIsdDdOxkQPRD1ZZs
   Lu7hRFkzuMF1rdrG2oJZbYVB/TZ8hD+po60hf/OM8hNCvp0paC6fErP/+
   XiAod6GjLnRRkkh3FMxTIcBXlQa6XT3PS1VZL0bE4uhWVb7+o70X3h78W
   XKLL7pdNSwgZVtIvsW+/1PcJSgmYeKvB3hydygsNrIquMdUhv0nWLsZ5t
   IflBwQkOLkTrJ1pV6udN+4XVV/O0VOhqMGpCVZb43JeDN/V5bDtZA/7PI
   Q==;
X-CSE-ConnectionGUID: Zbjx6a/OTgC3D8Qsm6Tg8A==
X-CSE-MsgGUID: dDaXYlOrSp6WTRf/NmM9Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32528289"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="32528289"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:53:29 -0700
X-CSE-ConnectionGUID: iSHSpCD0Qt6kiPHBwihV1g==
X-CSE-MsgGUID: kkYUWm2CSPqqK/VnzQJ4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="82471555"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2024 23:53:27 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 2/4] iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush for batching
Date: Thu, 15 Aug 2024 14:52:19 +0800
Message-Id: <20240815065221.50328-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815065221.50328-1-tina.zhang@intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extracts IOTLB and Dev-IOTLB invalidation logic from cache tag flush
interfaces into dedicated helper functions. It prepares the codebase
for upcoming changes to support batched cache invalidations.

To enable direct use of qi_flush helpers in the new functions,
iommu->flush.flush_iotlb and quirk_extra_dev_tlb_flush() are opened up.

No functional changes are intended.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/cache.c | 142 ++++++++++++++++++++----------------
 drivers/iommu/intel/iommu.c |   5 +-
 drivers/iommu/intel/iommu.h |   3 +
 3 files changed, 83 insertions(+), 67 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 44e92638c0cd1..08f7ce2c16c3b 100644
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
index 159da629349c4..14020414af892 100644
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
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index e297a322ba2d9..74634805abd19 100644
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
-- 
2.34.1

