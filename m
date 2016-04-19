From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: [PATCH v3 6/7] iommu: change intel-iommu to use IOVA frame numbers
Date: Tue, 19 Apr 2016 19:49:31 +0300
Message-ID: <4cdfef844fefb82b20d7494e8539e2250ffd91a5.1460733778.git.mad@cs.technion.ac.il>
References: <cover.1460733778.git.mad@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1460733778.git.mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, shli-b10kYP2dOMg@public.gmane.org, gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>

Make intel-iommu map/unmap/invalidate work with IOVA pfns instead of
pointers to "struct iova". This avoids using the iova struct from the IOVA
red-black tree and the resulting explicit find_iova() on unmap.

This patch will allow us to cache IOVAs in the next patch, in order to
avoid rbtree operations for the majority of map/unmap operations.

Note: In eliminating the find_iova() operation, we have also eliminated
the sanity check previously done in the unmap flow. Arguably, this was
overhead that is better avoided in production code, but it could be
brought back as a debug option for driver development.

Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
[mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased, fixed to not break iova api, and reworded
 the commit message]
Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 61 +++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b371455..885e2a6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -459,7 +459,7 @@ static LIST_HEAD(dmar_rmrr_units);
 static void flush_unmaps_timeout(unsigned long data);
 
 struct deferred_flush_entry {
-	struct iova *iova;
+	unsigned long iova_pfn;
 	unsigned long nrpages;
 	struct dmar_domain *domain;
 	struct page *freelist;
@@ -3353,7 +3353,7 @@ error:
 }
 
 /* This takes a number of _MM_ pages, not VTD pages */
-static struct iova *intel_alloc_iova(struct device *dev,
+static unsigned long intel_alloc_iova(struct device *dev,
 				     struct dmar_domain *domain,
 				     unsigned long nrpages, uint64_t dma_mask)
 {
@@ -3373,16 +3373,16 @@ static struct iova *intel_alloc_iova(struct device *dev,
 		iova = alloc_iova(&domain->iovad, nrpages,
 				  IOVA_PFN(DMA_BIT_MASK(32)), 1);
 		if (iova)
-			return iova;
+			return iova->pfn_lo;
 	}
 	iova = alloc_iova(&domain->iovad, nrpages, IOVA_PFN(dma_mask), 1);
 	if (unlikely(!iova)) {
 		pr_err("Allocating %ld-page iova for %s failed",
 		       nrpages, dev_name(dev));
-		return NULL;
+		return 0;
 	}
 
-	return iova;
+	return iova->pfn_lo;
 }
 
 static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
@@ -3480,7 +3480,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 {
 	struct dmar_domain *domain;
 	phys_addr_t start_paddr;
-	struct iova *iova;
+	unsigned long iova_pfn;
 	int prot = 0;
 	int ret;
 	struct intel_iommu *iommu;
@@ -3498,8 +3498,8 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	iommu = domain_get_iommu(domain);
 	size = aligned_nrpages(paddr, size);
 
-	iova = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
-	if (!iova)
+	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
+	if (!iova_pfn)
 		goto error;
 
 	/*
@@ -3517,7 +3517,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	 * might have two guest_addr mapping to the same host paddr, but this
 	 * is not a big problem
 	 */
-	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova->pfn_lo),
+	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
 				 mm_to_dma_pfn(paddr_pfn), size, prot);
 	if (ret)
 		goto error;
@@ -3525,18 +3525,18 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
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
@@ -3576,7 +3576,7 @@ static void flush_unmaps(struct deferred_flush_data *flush_data)
 			unsigned long mask;
 			struct deferred_flush_entry *entry =
 						&flush_table->entries[j];
-			struct iova *iova = entry->iova;
+			unsigned long iova_pfn = entry->iova_pfn;
 			unsigned long nrpages = entry->nrpages;
 			struct dmar_domain *domain = entry->domain;
 			struct page *freelist = entry->freelist;
@@ -3584,14 +3584,14 @@ static void flush_unmaps(struct deferred_flush_data *flush_data)
 			/* On real hardware multiple invalidations are expensive */
 			if (cap_caching_mode(iommu->cap))
 				iommu_flush_iotlb_psi(iommu, domain,
-					mm_to_dma_pfn(iova->pfn_lo),
+					mm_to_dma_pfn(iova_pfn),
 					nrpages, !freelist, 0);
 			else {
 				mask = ilog2(nrpages);
 				iommu_flush_dev_iotlb(domain,
-						(uint64_t)iova->pfn_lo << PAGE_SHIFT, mask);
+						(uint64_t)iova_pfn << PAGE_SHIFT, mask);
 			}
-			__free_iova(&domain->iovad, iova);
+			free_iova(&domain->iovad, iova_pfn);
 			if (freelist)
 				dma_free_pagelist(freelist);
 		}
@@ -3611,7 +3611,7 @@ static void flush_unmaps_timeout(unsigned long cpuid)
 	spin_unlock_irqrestore(&flush_data->lock, flags);
 }
 
-static void add_unmap(struct dmar_domain *dom, struct iova *iova,
+static void add_unmap(struct dmar_domain *dom, unsigned long iova_pfn,
 		      unsigned long nrpages, struct page *freelist)
 {
 	unsigned long flags;
@@ -3645,7 +3645,7 @@ static void add_unmap(struct dmar_domain *dom, struct iova *iova,
 
 	entry = &flush_data->tables[iommu_id].entries[entry_id];
 	entry->domain = dom;
-	entry->iova = iova;
+	entry->iova_pfn = iova_pfn;
 	entry->nrpages = nrpages;
 	entry->freelist = freelist;
 
@@ -3664,7 +3664,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	struct dmar_domain *domain;
 	unsigned long start_pfn, last_pfn;
 	unsigned long nrpages;
-	struct iova *iova;
+	unsigned long iova_pfn;
 	struct intel_iommu *iommu;
 	struct page *freelist;
 
@@ -3676,13 +3676,10 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 
 	iommu = domain_get_iommu(domain);
 
-	iova = find_iova(&domain->iovad, IOVA_PFN(dev_addr));
-	if (WARN_ONCE(!iova, "Driver unmaps unmatched page at PFN %llx\n",
-		      (unsigned long long)dev_addr))
-		return;
+	iova_pfn = IOVA_PFN(dev_addr);
 
 	nrpages = aligned_nrpages(dev_addr, size);
-	start_pfn = mm_to_dma_pfn(iova->pfn_lo);
+	start_pfn = mm_to_dma_pfn(iova_pfn);
 	last_pfn = start_pfn + nrpages - 1;
 
 	pr_debug("Device %s unmapping: pfn %lx-%lx\n",
@@ -3694,10 +3691,10 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
 				      nrpages, !freelist, 0);
 		/* free iova */
-		__free_iova(&domain->iovad, iova);
+		free_iova(&domain->iovad, iova_pfn);
 		dma_free_pagelist(freelist);
 	} else {
-		add_unmap(domain, iova, nrpages, freelist);
+		add_unmap(domain, iova_pfn, nrpages, freelist);
 		/*
 		 * queue up the release of the unmap to save the 1/6th of the
 		 * cpu used up by the iotlb flush operation...
@@ -3809,7 +3806,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct dmar_domain *domain;
 	size_t size = 0;
 	int prot = 0;
-	struct iova *iova = NULL;
+	unsigned long iova_pfn;
 	int ret;
 	struct scatterlist *sg;
 	unsigned long start_vpfn;
@@ -3828,9 +3825,9 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
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
@@ -3845,13 +3842,13 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
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
 
-- 
1.9.1
