Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9ED17C9B
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172195; cv=none; b=GxWLWs9gR6v5F/S4cMRId/pg4aDNgCWUND9em4BmmFZXjxwkmLNZFDk/0X0nrOFSyYAS6UzlpxxvpexgpWwxZxrAlsH40xAyoiaaxpTH+KVEPpsxau51aEBztY0GEmG/NjewVGYyPYU3H3S3n9/cCRQam0COJVc25IqCRUO7Hq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172195; c=relaxed/simple;
	bh=KckKa/R5b/+837PBERqDENwklzGlb1Ks72KL9Ex+/Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ily7VGDnK03jNOlL7dacAOoVVEzb9GqCu0DQ+Di5eGT9bsPWzZJkiGxQH9h+QFOTWFADP69hxUUzwc8z88cSwkfwVpz2o0v/5UTAnDGA6mEZw+8xAbGm2DMY/CnOOtGkTUnjIN9eMiHD5m7pj8laV61syD6oFQzBzKoXkFxt9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dd6VaM7E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dd6VaM7E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723172193; x=1754708193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KckKa/R5b/+837PBERqDENwklzGlb1Ks72KL9Ex+/Jg=;
  b=dd6VaM7E2DbW7PRV20wi5rzv92DV4Vz8ICuC/RqVhN/8r11jbgk9RRNj
   A3ftpKtNyRvvPDVMSsyEqMlhwlEQQLCl/etLKy9iVcfBD71TY4+8NfTFw
   QliowUoM23mowp7L/+ZYZnk04o01W5r15n/1oQ7Nsz2SFM7ZXJSZUW2rB
   3iJCemCbM3zyGNN4wzKhouDzK+Hf3zVWLgGwArHJWgjsaehAI/Qy7RZjg
   KFX8CBltiTeYV9LHwgQiE8cFgyE8oCMcWn2Z0UnEMnv9AedLly7w4p8so
   xngyH4U7RvgFF0JxVOJ5dlFRN5OESd1pQ+Lgnd3/N/78H0OYjd33a45US
   Q==;
X-CSE-ConnectionGUID: GpulIGOqTyqSbPWUN39NLw==
X-CSE-MsgGUID: oWT8l4QHSGa0czWDrvN8Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24239356"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="24239356"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:56:31 -0700
X-CSE-ConnectionGUID: G7GH4bExSi++4EJcY1GlvQ==
X-CSE-MsgGUID: mTVerTHdRSaiAdyCjycGUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62072647"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2024 19:56:30 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 2/5] iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush logic
Date: Fri,  9 Aug 2024 10:54:28 +0800
Message-Id: <20240809025431.14605-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809025431.14605-1-tina.zhang@intel.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce three new helper functions, handle_iotlb_flush(), handle_dev_
tlb_flush() and handle_dev_tlb_flush_all() to encapsulate the logic for
IOTLB and Dev-IOTLB invalidation commands. This refactoring aims to
improve code readability and maintainability by centralizing the handling
of these flush operations.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/cache.c | 136 +++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 44e92638c0cd..3ae84ccfcfa1 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -255,6 +255,72 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
 }
 
+static inline void handle_iotlb_flush(struct dmar_domain *domain,
+				      struct cache_tag *tag,
+				      unsigned long addr,
+				      unsigned long pages,
+				      unsigned long mask,
+				      int ih)
+{
+	struct intel_iommu *iommu = tag->iommu;
+
+	if (domain->use_first_level) {
+		qi_flush_piotlb(iommu, tag->domain_id,
+				tag->pasid, addr, pages, ih);
+	} else {
+		/*
+		 * Fallback to domain selective flush if no
+		 * PSI support or the size is too big.
+		 */
+		if (!cap_pgsel_inv(iommu->cap) ||
+		    mask > cap_max_amask_val(iommu->cap) ||
+		    pages == -1)
+			iommu->flush.flush_iotlb(iommu, tag->domain_id,
+						 0, 0, DMA_TLB_DSI_FLUSH);
+		else
+			iommu->flush.flush_iotlb(iommu, tag->domain_id,
+						 addr | ih, mask,
+						 DMA_TLB_PSI_FLUSH);
+	}
+}
+
+static void handle_dev_tlb_flush(struct cache_tag *tag,
+				 unsigned long addr,
+				 unsigned long mask)
+{
+	struct intel_iommu *iommu = tag->iommu;
+	struct device_domain_info *info;
+	u16 sid;
+
+	info = dev_iommu_priv_get(tag->dev);
+	sid = PCI_DEVID(info->bus, info->devfn);
+
+	if (tag->pasid == IOMMU_NO_PASID)
+		qi_flush_dev_iotlb(iommu, sid, info->pfsid,
+				   info->ats_qdep, addr, mask);
+	else
+		qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
+					 tag->pasid, info->ats_qdep,
+					 addr, mask);
+
+	quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid, info->ats_qdep);
+}
+
+static void handle_dev_tlb_flush_all(struct cache_tag *tag)
+{
+	struct intel_iommu *iommu = tag->iommu;
+	struct device_domain_info *info;
+	u16 sid;
+
+	info = dev_iommu_priv_get(tag->dev);
+	sid = PCI_DEVID(info->bus, info->devfn);
+
+	qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
+			   0, MAX_AGAW_PFN_WIDTH);
+	quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
+				  IOMMU_NO_PASID, info->ats_qdep);
+}
+
 /*
  * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
  * when the memory mappings in the target domain have been modified.
@@ -270,30 +336,10 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 
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
+			handle_iotlb_flush(domain, tag, addr, pages, mask, ih);
 			break;
 		case CACHE_TAG_NESTING_DEVTLB:
 			/*
@@ -307,18 +353,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
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
+			handle_dev_tlb_flush(tag, addr, mask);
 			break;
 		}
 
@@ -338,29 +373,14 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 
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
+			handle_iotlb_flush(domain, tag, 0, -1, 0, 0);
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
+			handle_dev_tlb_flush_all(tag);
 			break;
 		}
 
@@ -399,20 +419,8 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
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
+			handle_iotlb_flush(domain, tag, addr, pages, mask, 0);
 
 		trace_cache_tag_flush_range_np(tag, start, end, addr, pages, mask);
 	}
-- 
2.43.0

