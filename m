Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC75155383
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333088; cv=none; b=j+XLwZe6GUu8ef+Vo7rF1BXueRS8ium9Hs9aAOa9ehvD7OpdZwhewmnAWRoqvn3muIN5BPb6t/GnqB9pWQxrbMl96g/PssscKyKwJHRuaxSiJ8w0CYHROZHUINOBvVG+xMfrvrF/dVtTFJtVPfgyKY0LZA/dEbAJ/fXkp56K4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333088; c=relaxed/simple;
	bh=ftJbBlWpjwZNe/1FS4EnOcju++knLjq8w7xu9aQ/9RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0+4+WdSaMy4N8WQ7+KJBokkBCt6Sh11pmVeKSPYZqa6yFogHjEu68zz2BUCuMJpAYVbJoxHoEjnNcD2jkbzxHsQzz3fIC1AHIe1HHxMNAr5KrRCIg97ZBDHZ4ACs3TI86qKOElJw9R7jMToKnl8j+kHR5ZnhDY8b88+Ra2BbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HH0jAIZw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HH0jAIZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333087; x=1742869087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ftJbBlWpjwZNe/1FS4EnOcju++knLjq8w7xu9aQ/9RQ=;
  b=HH0jAIZwY+ysQCNGYimgiv9iUQZvbSkucNoTmqJj+THWY42BmctGSETe
   Tr7NwX7JCrC/MPh0N7Wsk1IJGagIZ4qSetokz0pMl71k86AlrEXazKowE
   9kSPdIkqSYuT7tKVZKrmGdZNy/PpnkeZOY/sENZOYmwEjG3kbywiS3Y/u
   tqLCBp6dy4Hfqg8uXkys9F7E+YZ/A2WWyXFqgbzjiqwMdDd1NtTouTuYf
   58ZS/7SHBNj/PDA44tCrLeRpW06AwB1oP4g1CTH5QVeasHZshUm3176Es
   CC33Sr7LWHByEqnJNcaq4jzJyT3hr6xEdY5uZir3Z3jmILPgU72+ZvT+V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271330"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271330"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353914"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 02/12] iommu/vt-d: Add cache tag invalidation helpers
Date: Mon, 25 Mar 2024 10:16:55 +0800
Message-Id: <20240325021705.249769-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several helpers to invalidate the caches after mappings in the
affected domain are changed.

- cache_tag_flush_range() invalidates a range of caches after mappings
  within this range are changed. It uses the page-selective cache
  invalidation methods.

- cache_tag_flush_all() invalidates all caches tagged by a domain ID.
  It uses the domain-selective cache invalidation methods.

- cache_tag_flush_cm_range() invalidates a range of caches if IOMMU is
  working in the caching mode and second-only translation is used for
  the affected domain. It is called when non-present to present mappings
  are created.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |   7 ++
 drivers/iommu/intel/cache.c | 189 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |   5 -
 3 files changed, 196 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index e3723b7a0b31..d05fa0122d65 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -35,6 +35,8 @@
 #define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
 #define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) & VTD_PAGE_MASK)
 
+#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
+
 #define VTD_STRIDE_SHIFT        (9)
 #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
 
@@ -1116,6 +1118,11 @@ int cache_tag_assign_domain(struct dmar_domain *domain, u16 did,
 			    struct device *dev, ioasid_t pasid);
 void cache_tag_unassign_domain(struct dmar_domain *domain, u16 did,
 			       struct device *dev, ioasid_t pasid);
+void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
+			   unsigned long end, int ih);
+void cache_tag_flush_all(struct dmar_domain *domain);
+void cache_tag_flush_cm_range(struct dmar_domain *domain, unsigned long start,
+			      unsigned long end);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 5a4e12e494b6..4c245d39faf2 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -12,6 +12,7 @@
 #include <linux/dmar.h>
 #include <linux/iommu.h>
 #include <linux/memory.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 
 #include "iommu.h"
@@ -190,3 +191,191 @@ void cache_tag_unassign_domain(struct dmar_domain *domain, u16 did,
 	if (domain->domain.type == IOMMU_DOMAIN_NESTED)
 		__cache_tag_unassign_parent_domain(domain->s2_domain, did, dev, pasid);
 }
+
+static unsigned long calculate_psi_aligned_address(unsigned long start,
+						   unsigned long end,
+						   unsigned long *_pages,
+						   unsigned long *_mask)
+{
+	unsigned long pages = (end - start + VTD_PAGE_SIZE - 1) >> VTD_PAGE_SHIFT;
+	unsigned long aligned_pages = __roundup_pow_of_two(pages);
+	unsigned long bitmask = aligned_pages - 1;
+	unsigned long mask = ilog2(aligned_pages);
+	unsigned long pfn = IOVA_PFN(start);
+
+	/*
+	 * PSI masks the low order bits of the base address. If the
+	 * address isn't aligned to the mask, then compute a mask value
+	 * needed to ensure the target range is flushed.
+	 */
+	if (unlikely(bitmask & pfn)) {
+		unsigned long end_pfn = pfn + pages - 1, shared_bits;
+
+		/*
+		 * Since end_pfn <= pfn + bitmask, the only way bits
+		 * higher than bitmask can differ in pfn and end_pfn is
+		 * by carrying. This means after masking out bitmask,
+		 * high bits starting with the first set bit in
+		 * shared_bits are all equal in both pfn and end_pfn.
+		 */
+		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
+		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+	}
+
+	*_pages = aligned_pages;
+	*_mask = mask;
+
+	return ALIGN_DOWN(start, VTD_PAGE_SIZE);
+}
+
+/*
+ * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
+ * when the memory mappings in the target domain have been modified.
+ */
+void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
+			   unsigned long end, int ih)
+{
+	unsigned long pages, mask, addr;
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		struct device_domain_info *info = dev_iommu_priv_get(tag->dev);
+		struct intel_iommu *iommu = tag->iommu;
+		u16 sid = PCI_DEVID(info->bus, info->devfn);
+
+		switch (tag->type) {
+		case CACHE_TAG_TYPE_IOTLB:
+		case CACHE_TAG_TYPE_PARENT_IOTLB:
+			if (domain->use_first_level) {
+				qi_flush_piotlb(iommu, tag->domain_id,
+						tag->pasid, addr, pages, ih);
+			} else {
+				/*
+				 * Fallback to domain selective flush if no
+				 * PSI support or the size is too big.
+				 */
+				if (!cap_pgsel_inv(iommu->cap) ||
+				    mask > cap_max_amask_val(iommu->cap))
+					iommu->flush.flush_iotlb(iommu, tag->domain_id,
+								 0, 0, DMA_TLB_DSI_FLUSH);
+				else
+					iommu->flush.flush_iotlb(iommu, tag->domain_id,
+								 addr | ih, mask,
+								 DMA_TLB_PSI_FLUSH);
+			}
+			break;
+		case CACHE_TAG_TYPE_DEVTLB:
+			if (tag->pasid == IOMMU_NO_PASID)
+				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
+						   info->ats_qdep, addr, mask);
+			else
+				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
+							 tag->pasid, info->ats_qdep,
+							 addr, mask);
+
+			quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid, info->ats_qdep);
+			break;
+		case CACHE_TAG_TYPE_PARENT_DEVTLB:
+			/*
+			 * Address translation cache in device side caches the
+			 * result of nested translation. There is no easy way
+			 * to identify the exact set of nested translations
+			 * affected by a change in S2. So just flush the entire
+			 * device cache.
+			 */
+			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
+					   0, MAX_AGAW_PFN_WIDTH);
+			quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
+						  IOMMU_NO_PASID, info->ats_qdep);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
+
+/*
+ * Invalidates all ranges of IOVA when the memory mappings in the target
+ * domain have been modified.
+ */
+void cache_tag_flush_all(struct dmar_domain *domain)
+{
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		struct device_domain_info *info = dev_iommu_priv_get(tag->dev);
+		struct intel_iommu *iommu = tag->iommu;
+		u16 sid = PCI_DEVID(info->bus, info->devfn);
+
+		switch (tag->type) {
+		case CACHE_TAG_TYPE_IOTLB:
+		case CACHE_TAG_TYPE_PARENT_IOTLB:
+			if (domain->use_first_level)
+				qi_flush_piotlb(iommu, tag->domain_id,
+						tag->pasid, 0, -1, 0);
+			else
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 0, 0, DMA_TLB_DSI_FLUSH);
+			break;
+		case CACHE_TAG_TYPE_DEVTLB:
+		case CACHE_TAG_TYPE_PARENT_DEVTLB:
+			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
+					   0, MAX_AGAW_PFN_WIDTH);
+			quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
+						  IOMMU_NO_PASID, info->ats_qdep);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
+
+/*
+ * Invalidate a range of IOVA when IOMMU is in caching mode and new mappings
+ * are added to the target domain.
+ */
+void cache_tag_flush_cm_range(struct dmar_domain *domain, unsigned long start,
+			      unsigned long end)
+{
+	unsigned long pages, mask, addr;
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		struct intel_iommu *iommu = tag->iommu;
+
+		/*
+		 * When IOMMU is enabled in caching mode some non-present
+		 * mappings may be cached by the IOTLB if it uses second-
+		 * only translation.
+		 */
+		if (!cap_caching_mode(iommu->cap) || domain->use_first_level) {
+			iommu_flush_write_buffer(iommu);
+			continue;
+		}
+
+		if (tag->type == CACHE_TAG_TYPE_IOTLB ||
+		    tag->type == CACHE_TAG_TYPE_PARENT_IOTLB) {
+			/*
+			 * Fallback to domain selective flush if no
+			 * PSI support or the size is too big.
+			 */
+			if (!cap_pgsel_inv(iommu->cap) ||
+			    mask > cap_max_amask_val(iommu->cap))
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 0, 0, DMA_TLB_DSI_FLUSH);
+			else
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 addr, mask,
+							 DMA_TLB_PSI_FLUSH);
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b4efbdedccce..93e4422c9b10 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -54,11 +54,6 @@
 				__DOMAIN_MAX_PFN(gaw), (unsigned long)-1))
 #define DOMAIN_MAX_ADDR(gaw)	(((uint64_t)__DOMAIN_MAX_PFN(gaw)) << VTD_PAGE_SHIFT)
 
-/* IO virtual address start page frame number */
-#define IOVA_START_PFN		(1)
-
-#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
 
-- 
2.34.1

