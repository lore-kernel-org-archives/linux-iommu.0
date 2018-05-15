From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/6] swiotlb: do not panic on mapping failures
Date: Tue, 15 May 2018 20:05:19 +0200
Message-ID: <20180515180523.3038-3-hch@lst.de>
References: <20180515180523.3038-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180515180523.3038-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We now have error handling in map_single/map_page callers (most of them
anyway). As swiotlb_tbl_map_single already prints a useful warning
when running out of swiotlb pool swace we can also remove swiotlb_full
entirely as it serves no purpose now.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 lib/swiotlb.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 721f93677eee..4d36340bc4f9 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -763,34 +763,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 	return true;
 }
 
-static void
-swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
-	     int do_panic)
-{
-	if (swiotlb_force == SWIOTLB_NO_FORCE)
-		return;
-
-	/*
-	 * Ran out of IOMMU space for this operation. This is very bad.
-	 * Unfortunately the drivers cannot handle this operation properly.
-	 * unless they check for dma_mapping_error (most don't)
-	 * When the mapping is small enough return a static buffer to limit
-	 * the damage, or panic when the transfer is too big.
-	 */
-	dev_err_ratelimited(dev, "DMA: Out of SW-IOMMU space for %zu bytes\n",
-			    size);
-
-	if (size <= io_tlb_overflow || !do_panic)
-		return;
-
-	if (dir == DMA_BIDIRECTIONAL)
-		panic("DMA: Random memory could be DMA accessed\n");
-	if (dir == DMA_FROM_DEVICE)
-		panic("DMA: Random memory could be DMA written\n");
-	if (dir == DMA_TO_DEVICE)
-		panic("DMA: Random memory could be DMA read\n");
-}
-
 /*
  * Map a single buffer of the indicated size for DMA in streaming mode.  The
  * physical address to use is returned.
@@ -819,10 +791,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 
 	/* Oh well, have to allocate and map a bounce buffer. */
 	map = map_single(dev, phys, size, dir, attrs);
-	if (map == SWIOTLB_MAP_ERROR) {
-		swiotlb_full(dev, size, dir, 1);
+	if (map == SWIOTLB_MAP_ERROR)
 		return __phys_to_dma(dev, io_tlb_overflow_buffer);
-	}
 
 	dev_addr = __phys_to_dma(dev, map);
 
@@ -950,7 +920,6 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
 			if (map == SWIOTLB_MAP_ERROR) {
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
-				swiotlb_full(hwdev, sg->length, dir, 0);
 				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
 				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
 						       attrs);
-- 
2.17.0
