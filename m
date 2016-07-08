From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/20] iommu/amd: Make use of the generic IOVA allocator
Date: Fri,  8 Jul 2016 13:44:59 +0200
Message-ID: <1467978311-28322-9-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Remove the old address allocation code and make use of the
generic IOVA allocator that is also used by other dma-ops
implementations.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 183 +++++++---------------------------------------
 1 file changed, 26 insertions(+), 157 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 08aa46c..4276c88 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1646,167 +1646,32 @@ out_free:
 	return -ENOMEM;
 }
 
-static dma_addr_t dma_ops_aperture_alloc(struct dma_ops_domain *dom,
-					 struct aperture_range *range,
-					 unsigned long pages,
-					 unsigned long dma_mask,
-					 unsigned long boundary_size,
-					 unsigned long align_mask,
-					 bool trylock)
-{
-	unsigned long offset, limit, flags;
-	dma_addr_t address;
-	bool flush = false;
-
-	offset = range->offset >> PAGE_SHIFT;
-	limit  = iommu_device_max_index(APERTURE_RANGE_PAGES, offset,
-					dma_mask >> PAGE_SHIFT);
-
-	if (trylock) {
-		if (!spin_trylock_irqsave(&range->bitmap_lock, flags))
-			return -1;
-	} else {
-		spin_lock_irqsave(&range->bitmap_lock, flags);
-	}
-
-	address = iommu_area_alloc(range->bitmap, limit, range->next_bit,
-				   pages, offset, boundary_size, align_mask);
-	if (address == -1) {
-		/* Nothing found, retry one time */
-		address = iommu_area_alloc(range->bitmap, limit,
-					   0, pages, offset, boundary_size,
-					   align_mask);
-		flush = true;
-	}
-
-	if (address != -1)
-		range->next_bit = address + pages;
-
-	spin_unlock_irqrestore(&range->bitmap_lock, flags);
-
-	if (flush) {
-		domain_flush_tlb(&dom->domain);
-		domain_flush_complete(&dom->domain);
-	}
-
-	return address;
-}
-
-static unsigned long dma_ops_area_alloc(struct device *dev,
-					struct dma_ops_domain *dom,
-					unsigned int pages,
-					unsigned long align_mask,
-					u64 dma_mask)
+static unsigned long dma_ops_alloc_iova(struct device *dev,
+					struct dma_ops_domain *dma_dom,
+					unsigned int pages, u64 dma_mask)
 {
-	unsigned long boundary_size, mask;
-	unsigned long address = -1;
-	bool first = true;
-	u32 start, i;
-
-	preempt_disable();
-
-	mask = dma_get_seg_boundary(dev);
-
-again:
-	start = this_cpu_read(*dom->next_index);
-
-	/* Sanity check - is it really necessary? */
-	if (unlikely(start > APERTURE_MAX_RANGES)) {
-		start = 0;
-		this_cpu_write(*dom->next_index, 0);
-	}
-
-	boundary_size = mask + 1 ? ALIGN(mask + 1, PAGE_SIZE) >> PAGE_SHIFT :
-				   1UL << (BITS_PER_LONG - PAGE_SHIFT);
+	unsigned long pfn = 0;
 
-	for (i = 0; i < APERTURE_MAX_RANGES; ++i) {
-		struct aperture_range *range;
-		int index;
-
-		index = (start + i) % APERTURE_MAX_RANGES;
+	pages = __roundup_pow_of_two(pages);
 
-		range = dom->aperture[index];
-
-		if (!range || range->offset >= dma_mask)
-			continue;
-
-		address = dma_ops_aperture_alloc(dom, range, pages,
-						 dma_mask, boundary_size,
-						 align_mask, first);
-		if (address != -1) {
-			address = range->offset + (address << PAGE_SHIFT);
-			this_cpu_write(*dom->next_index, index);
-			break;
-		}
-	}
-
-	if (address == -1 && first) {
-		first = false;
-		goto again;
-	}
+	if (dma_mask > DMA_BIT_MASK(32))
+		pfn = alloc_iova_fast(&dma_dom->iovad, pages,
+				      IOVA_PFN(DMA_BIT_MASK(32)));
 
-	preempt_enable();
+	if (!pfn)
+		pfn = alloc_iova_fast(&dma_dom->iovad, pages, IOVA_PFN(dma_mask));
 
-	return address;
+	return (pfn << PAGE_SHIFT);
 }
 
-static unsigned long dma_ops_alloc_addresses(struct device *dev,
-					     struct dma_ops_domain *dom,
-					     unsigned int pages,
-					     unsigned long align_mask,
-					     u64 dma_mask)
+static void dma_ops_free_iova(struct dma_ops_domain *dma_dom,
+			      unsigned long address,
+			      unsigned int pages)
 {
-	unsigned long address = -1;
-
-	while (address == -1) {
-		address = dma_ops_area_alloc(dev, dom, pages,
-					     align_mask, dma_mask);
-
-		if (address == -1 && alloc_new_range(dom, false, GFP_ATOMIC))
-			break;
-	}
-
-	if (unlikely(address == -1))
-		address = DMA_ERROR_CODE;
-
-	WARN_ON((address + (PAGE_SIZE*pages)) > dom->aperture_size);
-
-	return address;
-}
-
-/*
- * The address free function.
- *
- * called with domain->lock held
- */
-static void dma_ops_free_addresses(struct dma_ops_domain *dom,
-				   unsigned long address,
-				   unsigned int pages)
-{
-	unsigned i = address >> APERTURE_RANGE_SHIFT;
-	struct aperture_range *range = dom->aperture[i];
-	unsigned long flags;
-
-	BUG_ON(i >= APERTURE_MAX_RANGES || range == NULL);
-
-#ifdef CONFIG_IOMMU_STRESS
-	if (i < 4)
-		return;
-#endif
-
-	if (amd_iommu_unmap_flush) {
-		domain_flush_tlb(&dom->domain);
-		domain_flush_complete(&dom->domain);
-	}
-
-	address = (address % APERTURE_RANGE_SIZE) >> PAGE_SHIFT;
-
-	spin_lock_irqsave(&range->bitmap_lock, flags);
-	if (address + pages > range->next_bit)
-		range->next_bit = address + pages;
-	bitmap_clear(range->bitmap, address, pages);
-	spin_unlock_irqrestore(&range->bitmap_lock, flags);
+	pages = __roundup_pow_of_two(pages);
+	address >>= PAGE_SHIFT;
 
+	free_iova_fast(&dma_dom->iovad, address, pages);
 }
 
 /****************************************************************************
@@ -2583,9 +2448,7 @@ static dma_addr_t __map_single(struct device *dev,
 	if (align)
 		align_mask = (1UL << get_order(size)) - 1;
 
-	address = dma_ops_alloc_addresses(dev, dma_dom, pages, align_mask,
-					  dma_mask);
-
+	address = dma_ops_alloc_iova(dev, dma_dom, pages, dma_mask);
 	if (address == DMA_ERROR_CODE)
 		goto out;
 
@@ -2623,7 +2486,10 @@ out_unmap:
 		iommu_unmap_page(&dma_dom->domain, start, PAGE_SIZE);
 	}
 
-	dma_ops_free_addresses(dma_dom, address, pages);
+	domain_flush_tlb(&dma_dom->domain);
+	domain_flush_complete(&dma_dom->domain);
+
+	dma_ops_free_iova(dma_dom, address, pages);
 
 	return DMA_ERROR_CODE;
 }
@@ -2655,7 +2521,10 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
 		start += PAGE_SIZE;
 	}
 
-	dma_ops_free_addresses(dma_dom, dma_addr, pages);
+	domain_flush_tlb(&dma_dom->domain);
+	domain_flush_complete(&dma_dom->domain);
+
+	dma_ops_free_iova(dma_dom, dma_addr, pages);
 }
 
 /*
-- 
1.9.1
