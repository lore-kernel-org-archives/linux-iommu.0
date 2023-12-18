Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF61DDBF
	for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5vMhpWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702885179; x=1734421179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJK33T24Rs1tahauXtUCxn8oUk/sPrrzWAzacffyxKA=;
  b=l5vMhpWyPUvzDmISmu7OfFcGmC/G5i/RBkYL0Ta0NfU9D+QJaNSNmZm2
   xLY8bCtjO7vb92tJV+2P1CnngpTMith9mK0jXAMmUR+v1jxLhwyMtC/i/
   bUoJ4I6Ui/xQv1pIBZypnSn1Y/z1uutIQpmnpJe+S1DIF1es01fVf3bde
   BRPSMWaaX/M+JU5jZXUiFiaQRulq1Lrax1d2euUjiM0MbUxCeGlbYYTtE
   aq4h+g0f21qIJ0u6cCgXehf/BHzvFn11m48ZnHCLCL3iNVpxk+wk6HPl3
   CF9DsfLBgQHROjckChIVqBYtaQOwLP+0QNl8h4d2+c0pIv9IvYwxbjXWK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="459793940"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="459793940"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893723261"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="893723261"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2023 23:39:38 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu/vt-d: Move inline helpers to header files
Date: Mon, 18 Dec 2023 15:34:45 +0800
Message-Id: <20231218073445.142401-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218073445.142401-1-baolu.lu@linux.intel.com>
References: <20231218073445.142401-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move inline helpers to header files so that other files can use them
without duplicating the code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20231116015048.29675-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 175 +++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h | 210 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c | 204 ++--------------------------------
 drivers/iommu/intel/pasid.c | 216 +-----------------------------------
 4 files changed, 400 insertions(+), 405 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1c6366f60805..d02f916d8e59 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -851,6 +851,181 @@ static inline bool context_present(struct context_entry *context)
 	return (context->lo & 1);
 }
 
+#define LEVEL_STRIDE		(9)
+#define LEVEL_MASK		(((u64)1 << LEVEL_STRIDE) - 1)
+#define MAX_AGAW_WIDTH		(64)
+#define MAX_AGAW_PFN_WIDTH	(MAX_AGAW_WIDTH - VTD_PAGE_SHIFT)
+
+static inline int agaw_to_level(int agaw)
+{
+	return agaw + 2;
+}
+
+static inline int agaw_to_width(int agaw)
+{
+	return min_t(int, 30 + agaw * LEVEL_STRIDE, MAX_AGAW_WIDTH);
+}
+
+static inline int width_to_agaw(int width)
+{
+	return DIV_ROUND_UP(width - 30, LEVEL_STRIDE);
+}
+
+static inline unsigned int level_to_offset_bits(int level)
+{
+	return (level - 1) * LEVEL_STRIDE;
+}
+
+static inline int pfn_level_offset(u64 pfn, int level)
+{
+	return (pfn >> level_to_offset_bits(level)) & LEVEL_MASK;
+}
+
+static inline u64 level_mask(int level)
+{
+	return -1ULL << level_to_offset_bits(level);
+}
+
+static inline u64 level_size(int level)
+{
+	return 1ULL << level_to_offset_bits(level);
+}
+
+static inline u64 align_to_level(u64 pfn, int level)
+{
+	return (pfn + level_size(level) - 1) & level_mask(level);
+}
+
+static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
+{
+	return 1UL << min_t(int, (lvl - 1) * LEVEL_STRIDE, MAX_AGAW_PFN_WIDTH);
+}
+
+/* VT-d pages must always be _smaller_ than MM pages. Otherwise things
+   are never going to work. */
+static inline unsigned long mm_to_dma_pfn_start(unsigned long mm_pfn)
+{
+	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
+}
+static inline unsigned long mm_to_dma_pfn_end(unsigned long mm_pfn)
+{
+	return ((mm_pfn + 1) << (PAGE_SHIFT - VTD_PAGE_SHIFT)) - 1;
+}
+static inline unsigned long page_to_dma_pfn(struct page *pg)
+{
+	return mm_to_dma_pfn_start(page_to_pfn(pg));
+}
+static inline unsigned long virt_to_dma_pfn(void *p)
+{
+	return page_to_dma_pfn(virt_to_page(p));
+}
+
+static inline void context_set_present(struct context_entry *context)
+{
+	context->lo |= 1;
+}
+
+static inline void context_set_fault_enable(struct context_entry *context)
+{
+	context->lo &= (((u64)-1) << 2) | 1;
+}
+
+static inline void context_set_translation_type(struct context_entry *context,
+						unsigned long value)
+{
+	context->lo &= (((u64)-1) << 4) | 3;
+	context->lo |= (value & 3) << 2;
+}
+
+static inline void context_set_address_root(struct context_entry *context,
+					    unsigned long value)
+{
+	context->lo &= ~VTD_PAGE_MASK;
+	context->lo |= value & VTD_PAGE_MASK;
+}
+
+static inline void context_set_address_width(struct context_entry *context,
+					     unsigned long value)
+{
+	context->hi |= value & 7;
+}
+
+static inline void context_set_domain_id(struct context_entry *context,
+					 unsigned long value)
+{
+	context->hi |= (value & ((1 << 16) - 1)) << 8;
+}
+
+static inline void context_set_pasid(struct context_entry *context)
+{
+	context->lo |= CONTEXT_PASIDE;
+}
+
+static inline int context_domain_id(struct context_entry *c)
+{
+	return((c->hi >> 8) & 0xffff);
+}
+
+static inline void context_clear_entry(struct context_entry *context)
+{
+	context->lo = 0;
+	context->hi = 0;
+}
+
+#ifdef CONFIG_INTEL_IOMMU
+static inline bool context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
+{
+	if (!iommu->copied_tables)
+		return false;
+
+	return test_bit(((long)bus << 8) | devfn, iommu->copied_tables);
+}
+
+static inline void
+set_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
+{
+	set_bit(((long)bus << 8) | devfn, iommu->copied_tables);
+}
+
+static inline void
+clear_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
+{
+	clear_bit(((long)bus << 8) | devfn, iommu->copied_tables);
+}
+#endif /* CONFIG_INTEL_IOMMU */
+
+/*
+ * Set the RID_PASID field of a scalable mode context entry. The
+ * IOMMU hardware will use the PASID value set in this field for
+ * DMA translations of DMA requests without PASID.
+ */
+static inline void
+context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
+{
+	context->hi |= pasid & ((1 << 20) - 1);
+}
+
+/*
+ * Set the DTE(Device-TLB Enable) field of a scalable mode context
+ * entry.
+ */
+static inline void context_set_sm_dte(struct context_entry *context)
+{
+	context->lo |= BIT_ULL(2);
+}
+
+/*
+ * Set the PRE(Page Request Enable) field of a scalable mode context
+ * entry.
+ */
+static inline void context_set_sm_pre(struct context_entry *context)
+{
+	context->lo |= BIT_ULL(4);
+}
+
+/* Convert value to context PASID directory size field coding. */
+#define context_pdts(pds)	(((pds) & 0x7) << 9)
+
 struct dmar_drhd_unit *dmar_find_matched_drhd_unit(struct pci_dev *dev);
 
 int dmar_enable_qi(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 00401cfc2a40..8d40d4c66e31 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -86,6 +86,216 @@ static inline u16 pasid_pte_get_pgtt(struct pasid_entry *pte)
 	return (u16)((READ_ONCE(pte->val[0]) >> 6) & 0x7);
 }
 
+static inline void pasid_clear_entry(struct pasid_entry *pe)
+{
+	WRITE_ONCE(pe->val[0], 0);
+	WRITE_ONCE(pe->val[1], 0);
+	WRITE_ONCE(pe->val[2], 0);
+	WRITE_ONCE(pe->val[3], 0);
+	WRITE_ONCE(pe->val[4], 0);
+	WRITE_ONCE(pe->val[5], 0);
+	WRITE_ONCE(pe->val[6], 0);
+	WRITE_ONCE(pe->val[7], 0);
+}
+
+static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
+{
+	WRITE_ONCE(pe->val[0], PASID_PTE_FPD);
+	WRITE_ONCE(pe->val[1], 0);
+	WRITE_ONCE(pe->val[2], 0);
+	WRITE_ONCE(pe->val[3], 0);
+	WRITE_ONCE(pe->val[4], 0);
+	WRITE_ONCE(pe->val[5], 0);
+	WRITE_ONCE(pe->val[6], 0);
+	WRITE_ONCE(pe->val[7], 0);
+}
+
+static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
+{
+	u64 old;
+
+	old = READ_ONCE(*ptr);
+	WRITE_ONCE(*ptr, (old & ~mask) | bits);
+}
+
+static inline u64 pasid_get_bits(u64 *ptr)
+{
+	return READ_ONCE(*ptr);
+}
+
+/*
+ * Setup the DID(Domain Identifier) field (Bit 64~79) of scalable mode
+ * PASID entry.
+ */
+static inline void
+pasid_set_domain_id(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[1], GENMASK_ULL(15, 0), value);
+}
+
+/*
+ * Get domain ID value of a scalable mode PASID entry.
+ */
+static inline u16
+pasid_get_domain_id(struct pasid_entry *pe)
+{
+	return (u16)(READ_ONCE(pe->val[1]) & GENMASK_ULL(15, 0));
+}
+
+/*
+ * Setup the SLPTPTR(Second Level Page Table Pointer) field (Bit 12~63)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_slptr(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[0], VTD_PAGE_MASK, value);
+}
+
+/*
+ * Setup the AW(Address Width) field (Bit 2~4) of a scalable mode PASID
+ * entry.
+ */
+static inline void
+pasid_set_address_width(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[0], GENMASK_ULL(4, 2), value << 2);
+}
+
+/*
+ * Setup the PGTT(PASID Granular Translation Type) field (Bit 6~8)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_translation_type(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[0], GENMASK_ULL(8, 6), value << 6);
+}
+
+/*
+ * Enable fault processing by clearing the FPD(Fault Processing
+ * Disable) field (Bit 1) of a scalable mode PASID entry.
+ */
+static inline void pasid_set_fault_enable(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[0], 1 << 1, 0);
+}
+
+/*
+ * Enable second level A/D bits by setting the SLADE (Second Level
+ * Access Dirty Enable) field (Bit 9) of a scalable mode PASID
+ * entry.
+ */
+static inline void pasid_set_ssade(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[0], 1 << 9, 1 << 9);
+}
+
+/*
+ * Disable second level A/D bits by clearing the SLADE (Second Level
+ * Access Dirty Enable) field (Bit 9) of a scalable mode PASID
+ * entry.
+ */
+static inline void pasid_clear_ssade(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[0], 1 << 9, 0);
+}
+
+/*
+ * Checks if second level A/D bits specifically the SLADE (Second Level
+ * Access Dirty Enable) field (Bit 9) of a scalable mode PASID
+ * entry is set.
+ */
+static inline bool pasid_get_ssade(struct pasid_entry *pe)
+{
+	return pasid_get_bits(&pe->val[0]) & (1 << 9);
+}
+
+/*
+ * Setup the SRE(Supervisor Request Enable) field (Bit 128) of a
+ * scalable mode PASID entry.
+ */
+static inline void pasid_set_sre(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 0, 1);
+}
+
+/*
+ * Setup the WPE(Write Protect Enable) field (Bit 132) of a
+ * scalable mode PASID entry.
+ */
+static inline void pasid_set_wpe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
+}
+
+/*
+ * Setup the P(Present) field (Bit 0) of a scalable mode PASID
+ * entry.
+ */
+static inline void pasid_set_present(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[0], 1 << 0, 1);
+}
+
+/*
+ * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
+ * entry.
+ */
+static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
+{
+	pasid_set_bits(&pe->val[1], 1 << 23, value << 23);
+}
+
+/*
+ * Setup No Execute Enable bit (Bit 133) of a scalable mode PASID
+ * entry. It is required when XD bit of the first level page table
+ * entry is about to be set.
+ */
+static inline void pasid_set_nxe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 5, 1 << 5);
+}
+
+/*
+ * Setup the Page Snoop (PGSNP) field (Bit 88) of a scalable mode
+ * PASID entry.
+ */
+static inline void
+pasid_set_pgsnp(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1ULL << 24, 1ULL << 24);
+}
+
+/*
+ * Setup the First Level Page table Pointer field (Bit 140~191)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_flptr(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[2], VTD_PAGE_MASK, value);
+}
+
+/*
+ * Setup the First Level Paging Mode field (Bit 130~131) of a
+ * scalable mode PASID entry.
+ */
+static inline void
+pasid_set_flpm(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
+}
+
+/*
+ * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
+ * of a scalable mode PASID entry.
+ */
+static inline void pasid_set_eafe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
+}
+
 extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a91959c42781..84b78e42a470 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -46,9 +46,6 @@
 
 #define DEFAULT_DOMAIN_ADDRESS_WIDTH 57
 
-#define MAX_AGAW_WIDTH 64
-#define MAX_AGAW_PFN_WIDTH	(MAX_AGAW_WIDTH - VTD_PAGE_SHIFT)
-
 #define __DOMAIN_MAX_PFN(gaw)  ((((uint64_t)1) << ((gaw) - VTD_PAGE_SHIFT)) - 1)
 #define __DOMAIN_MAX_ADDR(gaw) ((((uint64_t)1) << (gaw)) - 1)
 
@@ -63,74 +60,6 @@
 
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
 
-/* page table handling */
-#define LEVEL_STRIDE		(9)
-#define LEVEL_MASK		(((u64)1 << LEVEL_STRIDE) - 1)
-
-static inline int agaw_to_level(int agaw)
-{
-	return agaw + 2;
-}
-
-static inline int agaw_to_width(int agaw)
-{
-	return min_t(int, 30 + agaw * LEVEL_STRIDE, MAX_AGAW_WIDTH);
-}
-
-static inline int width_to_agaw(int width)
-{
-	return DIV_ROUND_UP(width - 30, LEVEL_STRIDE);
-}
-
-static inline unsigned int level_to_offset_bits(int level)
-{
-	return (level - 1) * LEVEL_STRIDE;
-}
-
-static inline int pfn_level_offset(u64 pfn, int level)
-{
-	return (pfn >> level_to_offset_bits(level)) & LEVEL_MASK;
-}
-
-static inline u64 level_mask(int level)
-{
-	return -1ULL << level_to_offset_bits(level);
-}
-
-static inline u64 level_size(int level)
-{
-	return 1ULL << level_to_offset_bits(level);
-}
-
-static inline u64 align_to_level(u64 pfn, int level)
-{
-	return (pfn + level_size(level) - 1) & level_mask(level);
-}
-
-static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
-{
-	return 1UL << min_t(int, (lvl - 1) * LEVEL_STRIDE, MAX_AGAW_PFN_WIDTH);
-}
-
-/* VT-d pages must always be _smaller_ than MM pages. Otherwise things
-   are never going to work. */
-static inline unsigned long mm_to_dma_pfn_start(unsigned long mm_pfn)
-{
-	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
-}
-static inline unsigned long mm_to_dma_pfn_end(unsigned long mm_pfn)
-{
-	return ((mm_pfn + 1) << (PAGE_SHIFT - VTD_PAGE_SHIFT)) - 1;
-}
-static inline unsigned long page_to_dma_pfn(struct page *pg)
-{
-	return mm_to_dma_pfn_start(page_to_pfn(pg));
-}
-static inline unsigned long virt_to_dma_pfn(void *p)
-{
-	return page_to_dma_pfn(virt_to_page(p));
-}
-
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
 
@@ -168,78 +97,6 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
 	return re->hi & VTD_PAGE_MASK;
 }
 
-static inline void context_set_present(struct context_entry *context)
-{
-	context->lo |= 1;
-}
-
-static inline void context_set_fault_enable(struct context_entry *context)
-{
-	context->lo &= (((u64)-1) << 2) | 1;
-}
-
-static inline void context_set_translation_type(struct context_entry *context,
-						unsigned long value)
-{
-	context->lo &= (((u64)-1) << 4) | 3;
-	context->lo |= (value & 3) << 2;
-}
-
-static inline void context_set_address_root(struct context_entry *context,
-					    unsigned long value)
-{
-	context->lo &= ~VTD_PAGE_MASK;
-	context->lo |= value & VTD_PAGE_MASK;
-}
-
-static inline void context_set_address_width(struct context_entry *context,
-					     unsigned long value)
-{
-	context->hi |= value & 7;
-}
-
-static inline void context_set_domain_id(struct context_entry *context,
-					 unsigned long value)
-{
-	context->hi |= (value & ((1 << 16) - 1)) << 8;
-}
-
-static inline void context_set_pasid(struct context_entry *context)
-{
-	context->lo |= CONTEXT_PASIDE;
-}
-
-static inline int context_domain_id(struct context_entry *c)
-{
-	return((c->hi >> 8) & 0xffff);
-}
-
-static inline void context_clear_entry(struct context_entry *context)
-{
-	context->lo = 0;
-	context->hi = 0;
-}
-
-static inline bool context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
-{
-	if (!iommu->copied_tables)
-		return false;
-
-	return test_bit(((long)bus << 8) | devfn, iommu->copied_tables);
-}
-
-static inline void
-set_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
-{
-	set_bit(((long)bus << 8) | devfn, iommu->copied_tables);
-}
-
-static inline void
-clear_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
-{
-	clear_bit(((long)bus << 8) | devfn, iommu->copied_tables);
-}
-
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
@@ -383,13 +240,12 @@ void free_pgtable_page(void *vaddr)
 	free_page((unsigned long)vaddr);
 }
 
-static inline int domain_type_is_si(struct dmar_domain *domain)
+static int domain_type_is_si(struct dmar_domain *domain)
 {
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
 }
 
-static inline int domain_pfn_supported(struct dmar_domain *domain,
-				       unsigned long pfn)
+static int domain_pfn_supported(struct dmar_domain *domain, unsigned long pfn)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
 
@@ -451,7 +307,7 @@ int iommu_calculate_agaw(struct intel_iommu *iommu)
 	return __iommu_calculate_agaw(iommu, DEFAULT_DOMAIN_ADDRESS_WIDTH);
 }
 
-static inline bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
+static bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 {
 	return sm_supported(iommu) ?
 			ecap_smpwc(iommu->ecap) : ecap_coherent(iommu->ecap);
@@ -1574,9 +1430,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 }
 
 /* Notification for newly created mappings */
-static inline void __mapping_notify_one(struct intel_iommu *iommu,
-					struct dmar_domain *domain,
-					unsigned long pfn, unsigned int pages)
+static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *domain,
+				 unsigned long pfn, unsigned int pages)
 {
 	/*
 	 * It's a non-present to present mapping. Only flush if caching mode
@@ -1843,7 +1698,7 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	spin_unlock(&iommu->lock);
 }
 
-static inline int guestwidth_to_adjustwidth(int gaw)
+static int guestwidth_to_adjustwidth(int gaw)
 {
 	int agaw;
 	int r = (gaw - 12) % 9;
@@ -1877,7 +1732,7 @@ static void domain_exit(struct dmar_domain *domain)
  * Value of X in the PDTS field of a scalable mode context entry
  * indicates PASID directory with 2^(X + 7) entries.
  */
-static inline unsigned long context_get_sm_pds(struct pasid_table *table)
+static unsigned long context_get_sm_pds(struct pasid_table *table)
 {
 	unsigned long pds, max_pde;
 
@@ -1889,38 +1744,6 @@ static inline unsigned long context_get_sm_pds(struct pasid_table *table)
 	return pds - 7;
 }
 
-/*
- * Set the RID_PASID field of a scalable mode context entry. The
- * IOMMU hardware will use the PASID value set in this field for
- * DMA translations of DMA requests without PASID.
- */
-static inline void
-context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
-{
-	context->hi |= pasid & ((1 << 20) - 1);
-}
-
-/*
- * Set the DTE(Device-TLB Enable) field of a scalable mode context
- * entry.
- */
-static inline void context_set_sm_dte(struct context_entry *context)
-{
-	context->lo |= BIT_ULL(2);
-}
-
-/*
- * Set the PRE(Page Request Enable) field of a scalable mode context
- * entry.
- */
-static inline void context_set_sm_pre(struct context_entry *context)
-{
-	context->lo |= BIT_ULL(4);
-}
-
-/* Convert value to context PASID directory size field coding. */
-#define context_pdts(pds)	(((pds) & 0x7) << 9)
-
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
 				      struct pasid_table *table,
@@ -2102,18 +1925,15 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 }
 
 /* Returns a number of VTD pages, but aligned to MM page size */
-static inline unsigned long aligned_nrpages(unsigned long host_addr,
-					    size_t size)
+static unsigned long aligned_nrpages(unsigned long host_addr, size_t size)
 {
 	host_addr &= ~PAGE_MASK;
 	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT;
 }
 
 /* Return largest possible superpage level for a given mapping */
-static inline int hardware_largepage_caps(struct dmar_domain *domain,
-					  unsigned long iov_pfn,
-					  unsigned long phy_pfn,
-					  unsigned long pages)
+static int hardware_largepage_caps(struct dmar_domain *domain, unsigned long iov_pfn,
+				   unsigned long phy_pfn, unsigned long pages)
 {
 	int support, level = 1;
 	unsigned long pfnmerge;
@@ -3607,7 +3427,7 @@ void intel_iommu_shutdown(void)
 	up_write(&dmar_global_lock);
 }
 
-static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
+static struct intel_iommu *dev_to_intel_iommu(struct device *dev)
 {
 	struct iommu_device *iommu_dev = dev_to_iommu_device(dev);
 
@@ -3686,7 +3506,7 @@ const struct attribute_group *intel_iommu_groups[] = {
 	NULL,
 };
 
-static inline bool has_external_pci(void)
+static bool has_external_pci(void)
 {
 	struct pci_dev *pdev = NULL;
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 57ae716a2c70..3239cefa4c33 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -173,30 +173,6 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 /*
  * Interfaces for PASID table entry manipulation:
  */
-static inline void pasid_clear_entry(struct pasid_entry *pe)
-{
-	WRITE_ONCE(pe->val[0], 0);
-	WRITE_ONCE(pe->val[1], 0);
-	WRITE_ONCE(pe->val[2], 0);
-	WRITE_ONCE(pe->val[3], 0);
-	WRITE_ONCE(pe->val[4], 0);
-	WRITE_ONCE(pe->val[5], 0);
-	WRITE_ONCE(pe->val[6], 0);
-	WRITE_ONCE(pe->val[7], 0);
-}
-
-static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
-{
-	WRITE_ONCE(pe->val[0], PASID_PTE_FPD);
-	WRITE_ONCE(pe->val[1], 0);
-	WRITE_ONCE(pe->val[2], 0);
-	WRITE_ONCE(pe->val[3], 0);
-	WRITE_ONCE(pe->val[4], 0);
-	WRITE_ONCE(pe->val[5], 0);
-	WRITE_ONCE(pe->val[6], 0);
-	WRITE_ONCE(pe->val[7], 0);
-}
-
 static void
 intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
 {
@@ -212,192 +188,6 @@ intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
 		pasid_clear_entry(pe);
 }
 
-static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
-{
-	u64 old;
-
-	old = READ_ONCE(*ptr);
-	WRITE_ONCE(*ptr, (old & ~mask) | bits);
-}
-
-static inline u64 pasid_get_bits(u64 *ptr)
-{
-	return READ_ONCE(*ptr);
-}
-
-/*
- * Setup the DID(Domain Identifier) field (Bit 64~79) of scalable mode
- * PASID entry.
- */
-static inline void
-pasid_set_domain_id(struct pasid_entry *pe, u64 value)
-{
-	pasid_set_bits(&pe->val[1], GENMASK_ULL(15, 0), value);
-}
-
-/*
- * Get domain ID value of a scalable mode PASID entry.
- */
-static inline u16
-pasid_get_domain_id(struct pasid_entry *pe)
-{
-	return (u16)(READ_ONCE(pe->val[1]) & GENMASK_ULL(15, 0));
-}
-
-/*
- * Setup the SLPTPTR(Second Level Page Table Pointer) field (Bit 12~63)
- * of a scalable mode PASID entry.
- */
-static inline void
-pasid_set_slptr(struct pasid_entry *pe, u64 value)
-{
-	pasid_set_bits(&pe->val[0], VTD_PAGE_MASK, value);
-}
-
-/*
- * Setup the AW(Address Width) field (Bit 2~4) of a scalable mode PASID
- * entry.
- */
-static inline void
-pasid_set_address_width(struct pasid_entry *pe, u64 value)
-{
-	pasid_set_bits(&pe->val[0], GENMASK_ULL(4, 2), value << 2);
-}
-
-/*
- * Setup the PGTT(PASID Granular Translation Type) field (Bit 6~8)
- * of a scalable mode PASID entry.
- */
-static inline void
-pasid_set_translation_type(struct pasid_entry *pe, u64 value)
-{
-	pasid_set_bits(&pe->val[0], GENMASK_ULL(8, 6), value << 6);
-}
-
-/*
- * Enable fault processing by clearing the FPD(Fault Processing
- * Disable) field (Bit 1) of a scalable mode PASID entry.
- */
-static inline void pasid_set_fault_enable(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[0], 1 << 1, 0);
-}
-
-/*
- * Enable second level A/D bits by setting the SLADE (Second Level
- * Access Dirty Enable) field (Bit 9) of a scalable mode PASID
- * entry.
- */
-static inline void pasid_set_ssade(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[0], 1 << 9, 1 << 9);
-}
-
-/*
- * Disable second level A/D bits by clearing the SLADE (Second Level
- * Access Dirty Enable) field (Bit 9) of a scalable mode PASID
- * entry.
- */
-static inline void pasid_clear_ssade(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[0], 1 << 9, 0);
-}
-
-/*
- * Checks if second level A/D bits specifically the SLADE (Second Level
- * Access Dirty Enable) field (Bit 9) of a scalable mode PASID
- * entry is set.
- */
-static inline bool pasid_get_ssade(struct pasid_entry *pe)
-{
-	return pasid_get_bits(&pe->val[0]) & (1 << 9);
-}
-
-/*
- * Setup the SRE(Supervisor Request Enable) field (Bit 128) of a
- * scalable mode PASID entry.
- */
-static inline void pasid_set_sre(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 0, 1);
-}
-
-/*
- * Setup the WPE(Write Protect Enable) field (Bit 132) of a
- * scalable mode PASID entry.
- */
-static inline void pasid_set_wpe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
-}
-
-/*
- * Setup the P(Present) field (Bit 0) of a scalable mode PASID
- * entry.
- */
-static inline void pasid_set_present(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[0], 1 << 0, 1);
-}
-
-/*
- * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
- * entry.
- */
-static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
-{
-	pasid_set_bits(&pe->val[1], 1 << 23, value << 23);
-}
-
-/*
- * Setup No Execute Enable bit (Bit 133) of a scalable mode PASID
- * entry. It is required when XD bit of the first level page table
- * entry is about to be set.
- */
-static inline void pasid_set_nxe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 5, 1 << 5);
-}
-
-/*
- * Setup the Page Snoop (PGSNP) field (Bit 88) of a scalable mode
- * PASID entry.
- */
-static inline void
-pasid_set_pgsnp(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[1], 1ULL << 24, 1ULL << 24);
-}
-
-/*
- * Setup the First Level Page table Pointer field (Bit 140~191)
- * of a scalable mode PASID entry.
- */
-static inline void
-pasid_set_flptr(struct pasid_entry *pe, u64 value)
-{
-	pasid_set_bits(&pe->val[2], VTD_PAGE_MASK, value);
-}
-
-/*
- * Setup the First Level Paging Mode field (Bit 130~131) of a
- * scalable mode PASID entry.
- */
-static inline void
-pasid_set_flpm(struct pasid_entry *pe, u64 value)
-{
-	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
-}
-
-/*
- * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
- * of a scalable mode PASID entry.
- */
-static inline void pasid_set_eafe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
-}
-
 static void
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 				    u16 did, u32 pasid)
@@ -556,9 +346,9 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
  * Skip top levels of page tables for iommu which has less agaw
  * than default. Unnecessary for PT mode.
  */
-static inline int iommu_skip_agaw(struct dmar_domain *domain,
-				  struct intel_iommu *iommu,
-				  struct dma_pte **pgd)
+static int iommu_skip_agaw(struct dmar_domain *domain,
+			   struct intel_iommu *iommu,
+			   struct dma_pte **pgd)
 {
 	int agaw;
 
-- 
2.34.1

