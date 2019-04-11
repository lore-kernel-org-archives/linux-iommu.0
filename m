From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/4] swiotlb-xen: use ->map_page to implement ->map_sg
Date: Thu, 11 Apr 2019 09:19:58 +0200
Message-ID: <20190411072000.4306-3-hch@lst.de>
References: <20190411072000.4306-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190411072000.4306-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We can simply loop over the segments and map them, removing lots of
duplicate code.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/xen/swiotlb-xen.c | 68 ++++++---------------------------------
 1 file changed, 10 insertions(+), 58 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index d4bc3aabd44d..97a55c225593 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -517,24 +517,8 @@ xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 
 }
 
-/*
- * Map a set of buffers described by scatterlist in streaming mode for DMA.
- * This is the scatter-gather version of the above xen_swiotlb_map_page
- * interface.  Here the scatter gather list elements are each tagged with the
- * appropriate dma address and length.  They are obtained via
- * sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for xen_swiotlb_map_page are the
- * same here.
- */
 static int
-xen_swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
+xen_swiotlb_map_sg(struct device *dev, struct scatterlist *sgl, int nelems,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
@@ -543,50 +527,18 @@ xen_swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i) {
-		phys_addr_t paddr = sg_phys(sg);
-		dma_addr_t dev_addr = xen_phys_to_bus(paddr);
-
-		if (swiotlb_force == SWIOTLB_FORCE ||
-		    xen_arch_need_swiotlb(hwdev, paddr, dev_addr) ||
-		    !dma_capable(hwdev, dev_addr, sg->length) ||
-		    range_straddles_page_boundary(paddr, sg->length)) {
-			phys_addr_t map = swiotlb_tbl_map_single(hwdev,
-								 start_dma_addr,
-								 sg_phys(sg),
-								 sg->length,
-								 dir, attrs);
-			if (map == DMA_MAPPING_ERROR) {
-				dev_warn(hwdev, "swiotlb buffer is full\n");
-				/* Don't panic here, we expect map_sg users
-				   to do proper error handling. */
-				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-				xen_swiotlb_unmap_sg(hwdev, sgl, i, dir, attrs);
-				sg_dma_len(sgl) = 0;
-				return 0;
-			}
-			dev_addr = xen_phys_to_bus(map);
-			xen_dma_map_page(hwdev, pfn_to_page(map >> PAGE_SHIFT),
-						dev_addr,
-						map & ~PAGE_MASK,
-						sg->length,
-						dir,
-						attrs);
-			sg->dma_address = dev_addr;
-		} else {
-			/* we are not interested in the dma_addr returned by
-			 * xen_dma_map_page, only in the potential cache flushes executed
-			 * by the function. */
-			xen_dma_map_page(hwdev, pfn_to_page(paddr >> PAGE_SHIFT),
-						dev_addr,
-						paddr & ~PAGE_MASK,
-						sg->length,
-						dir,
-						attrs);
-			sg->dma_address = dev_addr;
-		}
+		sg->dma_address = xen_swiotlb_map_page(dev, sg_page(sg),
+				sg->offset, sg->length, dir, attrs);
+		if (sg->dma_address == DMA_MAPPING_ERROR)
+			goto out_unmap;
 		sg_dma_len(sg) = sg->length;
 	}
+
 	return nelems;
+out_unmap:
+	xen_swiotlb_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	sg_dma_len(sgl) = 0;
+	return 0;
 }
 
 /*
-- 
2.20.1
