From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH V2 3/4] intel-iommu: remove find_iova in unmap path
Date: Fri, 8 Jan 2016 16:44:48 -0800
Message-ID: <ca65bd42f2edd0f4f7da1259829dc8750a80762d.1452297604.git.shli@fb.com>
References: <cover.1452297604.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1452297604.git.shli-b10kYP2dOMg@public.gmane.org>
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

unmap path does find_iova and follows __free_iova, which takes lock
twice. The find_iova isn't really required and so we can avoid the lock
overhead. Also next patch depends on this to reduce lock further.

Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 62 ++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ac73876..b06a901 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -81,6 +81,7 @@
 #define IOVA_START_PFN		(1)
 
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
+#define IOVA_PFN_ROUNDUP(addr) ((addr + PAGE_SIZE -1) >> PAGE_SHIFT)
 #define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
 #define DMA_64BIT_PFN		IOVA_PFN(DMA_BIT_MASK(64))
 
@@ -461,7 +462,8 @@ static DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
 #define HIGH_WATER_MARK 250
 struct deferred_flush_tables {
 	int next;
-	struct iova *iova[HIGH_WATER_MARK];
+	unsigned long iova_pfn[HIGH_WATER_MARK];
+	unsigned long pages[HIGH_WATER_MARK];
 	struct dmar_domain *domain[HIGH_WATER_MARK];
 	struct page *freelist[HIGH_WATER_MARK];
 };
@@ -3518,20 +3520,24 @@ static void flush_unmaps(void)
 					 DMA_TLB_GLOBAL_FLUSH);
 		for (j = 0; j < deferred_flush[i].next; j++) {
 			unsigned long mask;
-			struct iova *iova = deferred_flush[i].iova[j];
+			unsigned long iova_pfn = deferred_flush[i].iova_pfn[j];
+			size_t pages = deferred_flush[i].pages[j];
 			struct dmar_domain *domain = deferred_flush[i].domain[j];
+			struct iova_domain *iovad = &domain->iovad;
 
 			/* On real hardware multiple invalidations are expensive */
 			if (cap_caching_mode(iommu->cap))
 				iommu_flush_iotlb_psi(iommu, domain,
-					iova->pfn_lo, iova_size(iova),
+					mm_to_dma_pfn(iova_pfn),
+					mm_to_dma_pfn(pages),
 					!deferred_flush[i].freelist[j], 0);
 			else {
-				mask = ilog2(mm_to_dma_pfn(iova_size(iova)));
-				iommu_flush_dev_iotlb(deferred_flush[i].domain[j],
-						(uint64_t)iova->pfn_lo << PAGE_SHIFT, mask);
+				mask = ilog2(mm_to_dma_pfn(pages));
+				iommu_flush_dev_iotlb(domain,
+					(uint64_t)iova_pfn << PAGE_SHIFT, mask);
 			}
-			__free_iova(&deferred_flush[i].domain[j]->iovad, iova);
+
+			free_iova(iovad, iova_pfn);
 			if (deferred_flush[i].freelist[j])
 				dma_free_pagelist(deferred_flush[i].freelist[j]);
 		}
@@ -3550,7 +3556,8 @@ static void flush_unmaps_timeout(unsigned long data)
 	spin_unlock_irqrestore(&async_umap_flush_lock, flags);
 }
 
-static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *freelist)
+static void add_unmap(struct dmar_domain *dom, unsigned long iova_pfn,
+	size_t pages, struct page *freelist)
 {
 	unsigned long flags;
 	int next, iommu_id;
@@ -3565,7 +3572,8 @@ static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *f
 
 	next = deferred_flush[iommu_id].next;
 	deferred_flush[iommu_id].domain[next] = dom;
-	deferred_flush[iommu_id].iova[next] = iova;
+	deferred_flush[iommu_id].iova_pfn[next] = iova_pfn;
+	deferred_flush[iommu_id].pages[next] = pages;
 	deferred_flush[iommu_id].freelist[next] = freelist;
 	deferred_flush[iommu_id].next++;
 
@@ -3577,11 +3585,10 @@ static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *f
 	spin_unlock_irqrestore(&async_umap_flush_lock, flags);
 }
 
-static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
+static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t pages)
 {
 	struct dmar_domain *domain;
 	unsigned long start_pfn, last_pfn;
-	struct iova *iova;
 	struct intel_iommu *iommu;
 	struct page *freelist;
 
@@ -3592,14 +3599,11 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
 	BUG_ON(!domain);
 
 	iommu = domain_get_iommu(domain);
+	/* intel_alloc_iova does the roundup */
+	pages = __roundup_pow_of_two(pages);
 
-	iova = find_iova(&domain->iovad, IOVA_PFN(dev_addr));
-	if (WARN_ONCE(!iova, "Driver unmaps unmatched page at PFN %llx\n",
-		      (unsigned long long)dev_addr))
-		return;
-
-	start_pfn = mm_to_dma_pfn(iova->pfn_lo);
-	last_pfn = mm_to_dma_pfn(iova->pfn_hi + 1) - 1;
+	start_pfn = mm_to_dma_pfn(IOVA_PFN(dev_addr));
+	last_pfn = mm_to_dma_pfn(IOVA_PFN(dev_addr) + pages) - 1;
 
 	pr_debug("Device %s unmapping: pfn %lx-%lx\n",
 		 dev_name(dev), start_pfn, last_pfn);
@@ -3610,10 +3614,10 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
 				      last_pfn - start_pfn + 1, !freelist, 0);
 		/* free iova */
-		__free_iova(&domain->iovad, iova);
+		free_iova(&domain->iovad, IOVA_PFN(dev_addr));
 		dma_free_pagelist(freelist);
 	} else {
-		add_unmap(domain, iova, freelist);
+		add_unmap(domain, IOVA_PFN(dev_addr), pages, freelist);
 		/*
 		 * queue up the release of the unmap to save the 1/6th of the
 		 * cpu used up by the iotlb flush operation...
@@ -3625,7 +3629,8 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     struct dma_attrs *attrs)
 {
-	intel_unmap(dev, dev_addr);
+	intel_unmap(dev, dev_addr, IOVA_PFN_ROUNDUP(dev_addr + size) -
+		IOVA_PFN(dev_addr));
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3684,7 +3689,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	intel_unmap(dev, dma_handle);
+	intel_unmap(dev, dma_handle, size);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, order);
 }
@@ -3693,7 +3698,18 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction dir,
 			   struct dma_attrs *attrs)
 {
-	intel_unmap(dev, sglist[0].dma_address);
+	struct scatterlist *sg;
+	size_t size = 0;
+	int i;
+
+	for_each_sg(sglist, sg, nelems, i) {
+		dma_addr_t dma_addr = sg_dma_address(sg);
+		unsigned int dma_len = sg_dma_len(sg);
+		size += IOVA_PFN_ROUNDUP(dma_addr + dma_len) -
+			IOVA_PFN(dma_addr);
+	}
+
+	intel_unmap(dev, sglist[0].dma_address, size);
 }
 
 static int intel_nontranslate_map_sg(struct device *hddev,
-- 
2.4.6
