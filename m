From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 15/23] iommu/amd: Remove need_flush from struct dma_ops_domain
Date: Tue, 22 Dec 2015 23:21:20 +0100
Message-ID: <1450822888-22590-16-git-send-email-joro@8bytes.org>
References: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450822888-22590-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The flushing of iommu tlbs is now done on a per-range basis.
So there is no need anymore for domain-wide flush tracking.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index faf51a0..39a2048 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -151,9 +151,6 @@ struct dma_ops_domain {
 
 	/* address space relevant data */
 	struct aperture_range *aperture[APERTURE_MAX_RANGES];
-
-	/* This will be set to true when TLB needs to be flushed */
-	bool need_flush;
 };
 
 /****************************************************************************
@@ -1563,7 +1560,7 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 					unsigned long align_mask,
 					u64 dma_mask)
 {
-	unsigned long next_bit, boundary_size, mask;
+	unsigned long boundary_size, mask;
 	unsigned long address = -1;
 	int start = dom->next_index;
 	int i;
@@ -1581,8 +1578,6 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 		if (!range || range->offset >= dma_mask)
 			continue;
 
-		next_bit  = range->next_bit;
-
 		address = dma_ops_aperture_alloc(dom, range, pages,
 						 dma_mask, boundary_size,
 						 align_mask);
@@ -1591,9 +1586,6 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 			dom->next_index = i;
 			break;
 		}
-
-		if (next_bit > range->next_bit)
-			dom->need_flush = true;
 	}
 
 	return address;
@@ -1609,7 +1601,6 @@ static unsigned long dma_ops_alloc_addresses(struct device *dev,
 
 #ifdef CONFIG_IOMMU_STRESS
 	dom->next_index = 0;
-	dom->need_flush = true;
 #endif
 
 	address = dma_ops_area_alloc(dev, dom, pages, align_mask, dma_mask);
@@ -1642,7 +1633,8 @@ static void dma_ops_free_addresses(struct dma_ops_domain *dom,
 		return;
 #endif
 
-	if (address + pages > range->next_bit) {
+	if (amd_iommu_unmap_flush ||
+	    (address + pages > range->next_bit)) {
 		domain_flush_tlb(&dom->domain);
 		domain_flush_complete(&dom->domain);
 	}
@@ -1868,8 +1860,6 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	if (!dma_dom->domain.pt_root)
 		goto free_dma_dom;
 
-	dma_dom->need_flush = false;
-
 	add_domain_to_list(&dma_dom->domain);
 
 	if (alloc_new_range(dma_dom, true, GFP_KERNEL))
@@ -2503,11 +2493,10 @@ retry:
 
 	ADD_STATS_COUNTER(alloced_io_mem, size);
 
-	if (unlikely(dma_dom->need_flush && !amd_iommu_unmap_flush)) {
-		domain_flush_tlb(&dma_dom->domain);
-		dma_dom->need_flush = false;
-	} else if (unlikely(amd_iommu_np_cache))
+	if (unlikely(amd_iommu_np_cache)) {
 		domain_flush_pages(&dma_dom->domain, address, size);
+		domain_flush_complete(&dma_dom->domain);
+	}
 
 out:
 	return address;
@@ -2519,8 +2508,6 @@ out_unmap:
 		dma_ops_domain_unmap(dma_dom, start);
 	}
 
-	domain_flush_pages(&dma_dom->domain, address, size);
-
 	dma_ops_free_addresses(dma_dom, address, pages);
 
 	return DMA_ERROR_CODE;
@@ -2553,11 +2540,6 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
 		start += PAGE_SIZE;
 	}
 
-	if (amd_iommu_unmap_flush || dma_dom->need_flush) {
-		domain_flush_pages(&dma_dom->domain, flush_addr, size);
-		dma_dom->need_flush = false;
-	}
-
 	SUB_STATS_COUNTER(alloced_io_mem, size);
 
 	dma_ops_free_addresses(dma_dom, dma_addr, pages);
-- 
1.9.1
