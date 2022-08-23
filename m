Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC4A3D
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 06:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661235682; x=1692771682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4A7WLTgNKyM03WZb+mOYvYov8OQ18fQTV2WrzcjLqQA=;
  b=eBRGmZ4NPwZyhdk71YyyULX6gCNgDFKjx6QeDsCnDoo12ycAgWbaH2hb
   TNfGaW1vwE3SYAXqCFFPR37hII5BxT9oa7E8poFdvwcSvd4pUHDfAeGd4
   8bpfHLvNxKPHuR8PTcGGsDTOaiHPdyV0pQWb8fGCUlN41BMPOPUV5yzTj
   2UdFZRTq7fx+8pftMc2LXjvJQeZNejS/fw/GCBFgNjvXORWT8Q2/2IG9U
   hQzBxFX6cnpe1/S1z7z0KSTjk48kv6NATkZctcLgD8SalRm+gKjl6ug6Q
   T32dgEOXEYfFMpRAa9gDj7/GOahyvTz/lzPvSt55zeTz/M/LPEgbAJfxH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273356204"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="273356204"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="605553178"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2022 23:21:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Wen Jin <wen.jin@intel.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/4] iommu/vt-d: Fix kdump kernels boot failure with scalable mode
Date: Tue, 23 Aug 2022 14:15:54 +0800
Message-Id: <20220823061557.1631056-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823061557.1631056-1-baolu.lu@linux.intel.com>
References: <20220823061557.1631056-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The translation table copying code for kdump kernels is currently based
on the extended root/context entry formats of ECS mode defined in older
VT-d v2.5, and doesn't handle the scalable mode formats. This causes
the kexec capture kernel boot failure with DMAR faults if the IOMMU was
enabled in scalable mode by the previous kernel.

The ECS mode has already been deprecated by the VT-d spec since v3.0 and
Intel IOMMU driver doesn't support this mode as there's no real hardware
implementation. Hence this converts ECS checking in copying table code
into scalable mode.

The existing copying code consumes a bit in the context entry as a mark
of copied entry. It needs to work for the old format as well as for the
extended context entries. As it's hard to find such a common bit for both
legacy and scalable mode context entries. This replaces it with a per-
IOMMU bitmap.

Fixes: 7373a8cc38197 ("iommu/vt-d: Setup context and enable RID2PASID support")
Cc: stable@vger.kernel.org
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Wen Jin <wen.jin@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20220817011035.3250131-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |   9 ++--
 drivers/iommu/intel/iommu.c | 100 ++++++++++++++++--------------------
 2 files changed, 50 insertions(+), 59 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index fae45bbb0c7f..74b0e19e23ee 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -197,7 +197,6 @@
 #define ecap_dis(e)		(((e) >> 27) & 0x1)
 #define ecap_nest(e)		(((e) >> 26) & 0x1)
 #define ecap_mts(e)		(((e) >> 25) & 0x1)
-#define ecap_ecs(e)		(((e) >> 24) & 0x1)
 #define ecap_iotlb_offset(e) 	((((e) >> 8) & 0x3ff) * 16)
 #define ecap_max_iotlb_offset(e) (ecap_iotlb_offset(e) + 16)
 #define ecap_coherent(e)	((e) & 0x1)
@@ -265,7 +264,6 @@
 #define DMA_GSTS_CFIS (((u32)1) << 23)
 
 /* DMA_RTADDR_REG */
-#define DMA_RTADDR_RTT (((u64)1) << 11)
 #define DMA_RTADDR_SMT (((u64)1) << 10)
 
 /* CCMD_REG */
@@ -579,6 +577,7 @@ struct intel_iommu {
 
 #ifdef CONFIG_INTEL_IOMMU
 	unsigned long 	*domain_ids; /* bitmap of domains */
+	unsigned long	*copied_tables; /* bitmap of copied tables */
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
 
@@ -701,6 +700,11 @@ static inline int nr_pte_to_next_page(struct dma_pte *pte)
 		(struct dma_pte *)ALIGN((unsigned long)pte, VTD_PAGE_SIZE) - pte;
 }
 
+static inline bool context_present(struct context_entry *context)
+{
+	return (context->lo & 1);
+}
+
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
 
 extern int dmar_enable_qi(struct intel_iommu *iommu);
@@ -784,7 +788,6 @@ static inline void intel_iommu_debugfs_init(void) {}
 #endif /* CONFIG_INTEL_IOMMU_DEBUGFS */
 
 extern const struct attribute_group *intel_iommu_groups[];
-bool context_present(struct context_entry *context);
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 					 u8 devfn, int alloc);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7cca030a508e..b9d058c27568 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -163,38 +163,6 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
 	return re->hi & VTD_PAGE_MASK;
 }
 
-static inline void context_clear_pasid_enable(struct context_entry *context)
-{
-	context->lo &= ~(1ULL << 11);
-}
-
-static inline bool context_pasid_enabled(struct context_entry *context)
-{
-	return !!(context->lo & (1ULL << 11));
-}
-
-static inline void context_set_copied(struct context_entry *context)
-{
-	context->hi |= (1ull << 3);
-}
-
-static inline bool context_copied(struct context_entry *context)
-{
-	return !!(context->hi & (1ULL << 3));
-}
-
-static inline bool __context_present(struct context_entry *context)
-{
-	return (context->lo & 1);
-}
-
-bool context_present(struct context_entry *context)
-{
-	return context_pasid_enabled(context) ?
-	     __context_present(context) :
-	     __context_present(context) && !context_copied(context);
-}
-
 static inline void context_set_present(struct context_entry *context)
 {
 	context->lo |= 1;
@@ -242,6 +210,26 @@ static inline void context_clear_entry(struct context_entry *context)
 	context->hi = 0;
 }
 
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
+
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
@@ -578,6 +566,13 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 	struct context_entry *context;
 	u64 *entry;
 
+	/*
+	 * Except that the caller requested to allocate a new entry,
+	 * returning a copied context entry makes no sense.
+	 */
+	if (!alloc && context_copied(iommu, bus, devfn))
+		return NULL;
+
 	entry = &root->lo;
 	if (sm_supported(iommu)) {
 		if (devfn >= 0x80) {
@@ -1688,6 +1683,11 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		iommu->domain_ids = NULL;
 	}
 
+	if (iommu->copied_tables) {
+		bitmap_free(iommu->copied_tables);
+		iommu->copied_tables = NULL;
+	}
+
 	/* free context mapping */
 	free_context_table(iommu);
 
@@ -1913,7 +1913,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		goto out_unlock;
 
 	ret = 0;
-	if (context_present(context))
+	if (context_present(context) && !context_copied(iommu, bus, devfn))
 		goto out_unlock;
 
 	/*
@@ -1925,7 +1925,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	 * in-flight DMA will exist, and we don't need to worry anymore
 	 * hereafter.
 	 */
-	if (context_copied(context)) {
+	if (context_copied(iommu, bus, devfn)) {
 		u16 did_old = context_domain_id(context);
 
 		if (did_old < cap_ndoms(iommu->cap)) {
@@ -1936,6 +1936,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
 		}
+
+		clear_context_copied(iommu, bus, devfn);
 	}
 
 	context_clear_entry(context);
@@ -2684,32 +2686,14 @@ static int copy_context_table(struct intel_iommu *iommu,
 		/* Now copy the context entry */
 		memcpy(&ce, old_ce + idx, sizeof(ce));
 
-		if (!__context_present(&ce))
+		if (!context_present(&ce))
 			continue;
 
 		did = context_domain_id(&ce);
 		if (did >= 0 && did < cap_ndoms(iommu->cap))
 			set_bit(did, iommu->domain_ids);
 
-		/*
-		 * We need a marker for copied context entries. This
-		 * marker needs to work for the old format as well as
-		 * for extended context entries.
-		 *
-		 * Bit 67 of the context entry is used. In the old
-		 * format this bit is available to software, in the
-		 * extended format it is the PGE bit, but PGE is ignored
-		 * by HW if PASIDs are disabled (and thus still
-		 * available).
-		 *
-		 * So disable PASIDs first and then mark the entry
-		 * copied. This means that we don't copy PASID
-		 * translations from the old kernel, but this is fine as
-		 * faults there are not fatal.
-		 */
-		context_clear_pasid_enable(&ce);
-		context_set_copied(&ce);
-
+		set_context_copied(iommu, bus, devfn);
 		new_ce[idx] = ce;
 	}
 
@@ -2735,8 +2719,8 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	bool new_ext, ext;
 
 	rtaddr_reg = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
-	ext        = !!(rtaddr_reg & DMA_RTADDR_RTT);
-	new_ext    = !!ecap_ecs(iommu->ecap);
+	ext        = !!(rtaddr_reg & DMA_RTADDR_SMT);
+	new_ext    = !!sm_supported(iommu);
 
 	/*
 	 * The RTT bit can only be changed when translation is disabled,
@@ -2747,6 +2731,10 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	if (new_ext != ext)
 		return -EINVAL;
 
+	iommu->copied_tables = bitmap_zalloc(BIT_ULL(16), GFP_KERNEL);
+	if (!iommu->copied_tables)
+		return -ENOMEM;
+
 	old_rt_phys = rtaddr_reg & VTD_PAGE_MASK;
 	if (!old_rt_phys)
 		return -EINVAL;
-- 
2.25.1

