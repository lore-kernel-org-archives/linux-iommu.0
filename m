From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH 1/4] iommu: alloc_iova returns a pfn
Date: Tue, 24 Nov 2015 13:54:07 -0800
Message-ID: <c4055aad7e86e7e180c6af82bb12414f414f726f.1448401089.git.shli@fb.com>
References: <cover.1448401089.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1448401089.git.shli-b10kYP2dOMg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Kernel-team-b10kYP2dOMg@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

make alloc_iova return a pfn instead of iova. This is a preparation
patch.

Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
---
 drivers/iommu/dma-iommu.c   | 30 ++++++++++----------
 drivers/iommu/intel-iommu.c | 67 ++++++++++++++++++++++++++-------------------
 drivers/iommu/iova.c        | 11 ++++----
 include/linux/iova.h        |  6 ++--
 4 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3a20db4..a86291e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -148,7 +148,7 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
 	}
 }
 
-static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
+static unsigned long __alloc_iova(struct iova_domain *iovad, size_t size,
 		dma_addr_t dma_limit)
 {
 	unsigned long shift = iova_shift(iovad);
@@ -279,7 +279,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size,
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iova_domain *iovad = domain->iova_cookie;
-	struct iova *iova;
+	unsigned long iova_pfn;
 	struct page **pages;
 	struct sg_table sgt;
 	dma_addr_t dma_addr;
@@ -291,8 +291,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size,
 	if (!pages)
 		return NULL;
 
-	iova = __alloc_iova(iovad, size, dev->coherent_dma_mask);
-	if (!iova)
+	iova_pfn = __alloc_iova(iovad, size, dev->coherent_dma_mask);
+	if (!iova_pfn)
 		goto out_free_pages;
 
 	size = iova_align(iovad, size);
@@ -311,7 +311,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size,
 		sg_miter_stop(&miter);
 	}
 
-	dma_addr = iova_dma_addr(iovad, iova);
+	dma_addr = iova_dma_addr(iovad, iova_pfn);
 	if (iommu_map_sg(domain, dma_addr, sgt.sgl, sgt.orig_nents, prot)
 			< size)
 		goto out_free_sg;
@@ -323,7 +323,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size,
 out_free_sg:
 	sg_free_table(&sgt);
 out_free_iova:
-	__free_iova(iovad, iova);
+	free_iova(iovad, iova_pfn);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -363,14 +363,14 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	size_t iova_off = iova_offset(iovad, phys);
 	size_t len = iova_align(iovad, size + iova_off);
-	struct iova *iova = __alloc_iova(iovad, len, dma_get_mask(dev));
+	unsigned long iova_pfn = __alloc_iova(iovad, len, dma_get_mask(dev));
 
-	if (!iova)
+	if (!iova_pfn)
 		return DMA_ERROR_CODE;
 
-	dma_addr = iova_dma_addr(iovad, iova);
+	dma_addr = iova_dma_addr(iovad, iova_pfn);
 	if (iommu_map(domain, dma_addr, phys - iova_off, len, prot)) {
-		__free_iova(iovad, iova);
+		free_iova(iovad, iova_pfn);
 		return DMA_ERROR_CODE;
 	}
 	return dma_addr + iova_off;
@@ -437,7 +437,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iova_domain *iovad = domain->iova_cookie;
-	struct iova *iova;
+	unsigned long iova_pfn;
 	struct scatterlist *s, *prev = NULL;
 	dma_addr_t dma_addr;
 	size_t iova_len = 0;
@@ -477,22 +477,22 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
-	iova = __alloc_iova(iovad, iova_len, dma_get_mask(dev));
-	if (!iova)
+	iova_pfn = __alloc_iova(iovad, iova_len, dma_get_mask(dev));
+	if (!iova_pfn)
 		goto out_restore_sg;
 
 	/*
 	 * We'll leave any physical concatenation to the IOMMU driver's
 	 * implementation - it knows better than we do.
 	 */
-	dma_addr = iova_dma_addr(iovad, iova);
+	dma_addr = iova_dma_addr(iovad, iova_pfn);
 	if (iommu_map_sg(domain, dma_addr, sg, nents, prot) < iova_len)
 		goto out_free_iova;
 
 	return __finalise_sg(dev, sg, nents, dma_addr);
 
 out_free_iova:
-	__free_iova(iovad, iova);
+	free_iova(iovad, iova_pfn);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 	return 0;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 24aa0b3..5c57b9a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -462,6 +462,8 @@ static DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
 struct deferred_flush_tables {
 	int next;
 	struct iova *iova[HIGH_WATER_MARK];
+	unsigned long iova_pfn[HIGH_WATER_MARK];
+	unsigned long iova_size[HIGH_WATER_MARK];
 	struct dmar_domain *domain[HIGH_WATER_MARK];
 	struct page *freelist[HIGH_WATER_MARK];
 };
@@ -3303,11 +3305,11 @@ static int __init init_dmars(void)
 }
 
 /* This takes a number of _MM_ pages, not VTD pages */
-static struct iova *intel_alloc_iova(struct device *dev,
+static unsigned long intel_alloc_iova(struct device *dev,
 				     struct dmar_domain *domain,
 				     unsigned long nrpages, uint64_t dma_mask)
 {
-	struct iova *iova = NULL;
+	unsigned long iova_pfn = 0;
 
 	/* Restrict dma_mask to the width that the iommu can handle */
 	dma_mask = min_t(uint64_t, DOMAIN_MAX_ADDR(domain->gaw), dma_mask);
@@ -3320,19 +3322,19 @@ static struct iova *intel_alloc_iova(struct device *dev,
 		 * DMA_BIT_MASK(32) and if that fails then try allocating
 		 * from higher range
 		 */
-		iova = alloc_iova(&domain->iovad, nrpages,
+		iova_pfn = alloc_iova(&domain->iovad, nrpages,
 				  IOVA_PFN(DMA_BIT_MASK(32)), 1);
-		if (iova)
-			return iova;
+		if (iova_pfn)
+			return iova_pfn;
 	}
-	iova = alloc_iova(&domain->iovad, nrpages, IOVA_PFN(dma_mask), 1);
-	if (unlikely(!iova)) {
+	iova_pfn = alloc_iova(&domain->iovad, nrpages, IOVA_PFN(dma_mask), 1);
+	if (unlikely(!iova_pfn)) {
 		pr_err("Allocating %ld-page iova for %s failed",
 		       nrpages, dev_name(dev));
-		return NULL;
+		return 0;
 	}
 
-	return iova;
+	return iova_pfn;
 }
 
 static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
@@ -3430,7 +3432,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 {
 	struct dmar_domain *domain;
 	phys_addr_t start_paddr;
-	struct iova *iova;
+	unsigned long iova_pfn;
 	int prot = 0;
 	int ret;
 	struct intel_iommu *iommu;
@@ -3448,8 +3450,8 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	iommu = domain_get_iommu(domain);
 	size = aligned_nrpages(paddr, size);
 
-	iova = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
-	if (!iova)
+	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
+	if (!iova_pfn)
 		goto error;
 
 	/*
@@ -3467,7 +3469,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	 * might have two guest_addr mapping to the same host paddr, but this
 	 * is not a big problem
 	 */
-	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova->pfn_lo),
+	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
 				 mm_to_dma_pfn(paddr_pfn), size, prot);
 	if (ret)
 		goto error;
@@ -3475,18 +3477,18 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	/* it's a non-present to present mapping. Only flush if caching mode */
 	if (cap_caching_mode(iommu->cap))
 		iommu_flush_iotlb_psi(iommu, domain,
-				      mm_to_dma_pfn(iova->pfn_lo),
+				      mm_to_dma_pfn(iova_pfn),
 				      size, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
 
-	start_paddr = (phys_addr_t)iova->pfn_lo << PAGE_SHIFT;
+	start_paddr = (phys_addr_t)iova_pfn << PAGE_SHIFT;
 	start_paddr += paddr & ~PAGE_MASK;
 	return start_paddr;
 
 error:
-	if (iova)
-		__free_iova(&domain->iovad, iova);
+	if (iova_pfn)
+		free_iova(&domain->iovad, iova_pfn);
 	pr_err("Device %s request: %zx@%llx dir %d --- failed\n",
 		dev_name(dev), size, (unsigned long long)paddr, dir);
 	return 0;
@@ -3523,19 +3525,24 @@ static void flush_unmaps(void)
 		for (j = 0; j < deferred_flush[i].next; j++) {
 			unsigned long mask;
 			struct iova *iova = deferred_flush[i].iova[j];
+			unsigned long iova_pfn = deferred_flush[i].iova_pfn[j];
+			unsigned long iova_size = deferred_flush[i].iova_size[j];
 			struct dmar_domain *domain = deferred_flush[i].domain[j];
 
 			/* On real hardware multiple invalidations are expensive */
 			if (cap_caching_mode(iommu->cap))
 				iommu_flush_iotlb_psi(iommu, domain,
-					iova->pfn_lo, iova_size(iova),
+					iova_pfn, iova_size,
 					!deferred_flush[i].freelist[j], 0);
 			else {
-				mask = ilog2(mm_to_dma_pfn(iova_size(iova)));
+				mask = ilog2(mm_to_dma_pfn(iova_size));
 				iommu_flush_dev_iotlb(deferred_flush[i].domain[j],
-						(uint64_t)iova->pfn_lo << PAGE_SHIFT, mask);
+						(uint64_t)iova_pfn << PAGE_SHIFT, mask);
 			}
-			__free_iova(&deferred_flush[i].domain[j]->iovad, iova);
+			if (iova)
+				__free_iova(&deferred_flush[i].domain[j]->iovad, iova);
+			else
+				free_iova(&deferred_flush[i].domain[j]->iovad, iova_pfn);
 			if (deferred_flush[i].freelist[j])
 				dma_free_pagelist(deferred_flush[i].freelist[j]);
 		}
@@ -3554,7 +3561,8 @@ static void flush_unmaps_timeout(unsigned long data)
 	spin_unlock_irqrestore(&async_umap_flush_lock, flags);
 }
 
-static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *freelist)
+static void add_unmap(struct dmar_domain *dom, unsigned long iova_pfn,
+	unsigned long iova_size, struct page *freelist, struct iova *iova)
 {
 	unsigned long flags;
 	int next, iommu_id;
@@ -3570,6 +3578,8 @@ static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *f
 	next = deferred_flush[iommu_id].next;
 	deferred_flush[iommu_id].domain[next] = dom;
 	deferred_flush[iommu_id].iova[next] = iova;
+	deferred_flush[iommu_id].iova_pfn[next] = iova_pfn;
+	deferred_flush[iommu_id].iova_size[next] = iova_size;
 	deferred_flush[iommu_id].freelist[next] = freelist;
 	deferred_flush[iommu_id].next++;
 
@@ -3617,7 +3627,8 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
 		__free_iova(&domain->iovad, iova);
 		dma_free_pagelist(freelist);
 	} else {
-		add_unmap(domain, iova, freelist);
+		add_unmap(domain, IOVA_PFN(dev_addr), last_pfn - start_pfn + 1,
+			freelist, iova);
 		/*
 		 * queue up the release of the unmap to save the 1/6th of the
 		 * cpu used up by the iotlb flush operation...
@@ -3721,7 +3732,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct dmar_domain *domain;
 	size_t size = 0;
 	int prot = 0;
-	struct iova *iova = NULL;
+	unsigned long iova_pfn;
 	int ret;
 	struct scatterlist *sg;
 	unsigned long start_vpfn;
@@ -3740,9 +3751,9 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	for_each_sg(sglist, sg, nelems, i)
 		size += aligned_nrpages(sg->offset, sg->length);
 
-	iova = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size),
+	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size),
 				*dev->dma_mask);
-	if (!iova) {
+	if (!iova_pfn) {
 		sglist->dma_length = 0;
 		return 0;
 	}
@@ -3757,13 +3768,13 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
 		prot |= DMA_PTE_WRITE;
 
-	start_vpfn = mm_to_dma_pfn(iova->pfn_lo);
+	start_vpfn = mm_to_dma_pfn(iova_pfn);
 
 	ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
 	if (unlikely(ret)) {
 		dma_pte_free_pagetable(domain, start_vpfn,
 				       start_vpfn + size - 1);
-		__free_iova(&domain->iovad, iova);
+		free_iova(&domain->iovad, iova_pfn);
 		return 0;
 	}
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index fa0adef..2c5e197 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -36,6 +36,8 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->rbroot = RB_ROOT;
 	iovad->cached32_node = NULL;
 	iovad->granule = granule;
+	if (start_pfn == 0)
+		start_pfn = 1;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
 }
@@ -267,7 +269,7 @@ EXPORT_SYMBOL_GPL(iova_cache_put);
  * flag is set then the allocated address iova->pfn_lo will be naturally
  * aligned on roundup_power_of_two(size).
  */
-struct iova *
+unsigned long
 alloc_iova(struct iova_domain *iovad, unsigned long size,
 	unsigned long limit_pfn,
 	bool size_aligned)
@@ -277,17 +279,17 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 
 	new_iova = alloc_iova_mem();
 	if (!new_iova)
-		return NULL;
+		return 0;
 
 	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn,
 			new_iova, size_aligned);
 
 	if (ret) {
 		free_iova_mem(new_iova);
-		return NULL;
+		return 0;
 	}
 
-	return new_iova;
+	return new_iova->pfn_lo;
 }
 EXPORT_SYMBOL_GPL(alloc_iova);
 
@@ -365,7 +367,6 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 
 	if (iova)
 		__free_iova(iovad, iova);
-
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 92f7177..cfe5ee9 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -58,9 +58,9 @@ static inline size_t iova_align(struct iova_domain *iovad, size_t size)
 	return ALIGN(size, iovad->granule);
 }
 
-static inline dma_addr_t iova_dma_addr(struct iova_domain *iovad, struct iova *iova)
+static inline dma_addr_t iova_dma_addr(struct iova_domain *iovad, unsigned long iova_pfn)
 {
-	return (dma_addr_t)iova->pfn_lo << iova_shift(iovad);
+	return (dma_addr_t)iova_pfn << iova_shift(iovad);
 }
 
 static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
@@ -75,7 +75,7 @@ struct iova *alloc_iova_mem(void);
 void free_iova_mem(struct iova *iova);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
-struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
+unsigned long alloc_iova(struct iova_domain *iovad, unsigned long size,
 	unsigned long limit_pfn,
 	bool size_aligned);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
-- 
2.4.6
