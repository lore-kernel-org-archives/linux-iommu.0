From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 4/4] swiotlb-xen: ensure we have a single callsite for
	xen_dma_map_page
Date: Thu, 11 Apr 2019 09:20:00 +0200
Message-ID: <20190411072000.4306-5-hch@lst.de>
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

Refactor the code a bit to make further changes easier.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/xen/swiotlb-xen.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 9a951504dc12..5dcb06fe9667 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -391,13 +391,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	if (dma_capable(dev, dev_addr, size) &&
 	    !range_straddles_page_boundary(phys, size) &&
 		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
-		(swiotlb_force != SWIOTLB_FORCE)) {
-		/* we are not interested in the dma_addr returned by
-		 * xen_dma_map_page, only in the potential cache flushes executed
-		 * by the function. */
-		xen_dma_map_page(dev, page, dev_addr, offset, size, dir, attrs);
-		return dev_addr;
-	}
+		swiotlb_force != SWIOTLB_FORCE)
+		goto done;
 
 	/*
 	 * Oh well, have to allocate and map a bounce buffer.
@@ -410,19 +405,25 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 		return DMA_MAPPING_ERROR;
 
 	dev_addr = xen_phys_to_bus(map);
-	xen_dma_map_page(dev, pfn_to_page(map >> PAGE_SHIFT),
-					dev_addr, map & ~PAGE_MASK, size, dir, attrs);
 
 	/*
 	 * Ensure that the address returned is DMA'ble
 	 */
-	if (dma_capable(dev, dev_addr, size))
-		return dev_addr;
-
-	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
+	if (unlikely(!dma_capable(dev, dev_addr, size))) {
+		swiotlb_tbl_unmap_single(dev, map, size, dir,
+				attrs | DMA_ATTR_SKIP_CPU_SYNC);
+		return DMA_MAPPING_ERROR;
+	}
 
-	return DMA_MAPPING_ERROR;
+	page = pfn_to_page(map >> PAGE_SHIFT);
+	offset = map & ~PAGE_MASK;
+done:
+	/*
+	 * we are not interested in the dma_addr returned by xen_dma_map_page,
+	 * only in the potential cache flushes executed by the function.
+	 */
+	xen_dma_map_page(dev, page, dev_addr, offset, size, dir, attrs);
+	return dev_addr;
 }
 
 /*
-- 
2.20.1
