From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 3/4] swiotlb-xen: simplify the DMA sync method implementations
Date: Thu, 11 Apr 2019 09:19:59 +0200
Message-ID: <20190411072000.4306-4-hch@lst.de>
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

Get rid of the grand multiplexer and implement the sync_single_for_cpu
and sync_single_for_device methods directly, and then loop over them
for the scatterlist based variants.

Note that this also loses a few comments related to highlevel DMA API
concepts, which have nothing to do with the swiotlb-xen implementation
details.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/xen/swiotlb-xen.c | 84 +++++++++++++--------------------------
 1 file changed, 28 insertions(+), 56 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 97a55c225593..9a951504dc12 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -455,48 +455,28 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
 }
 
-/*
- * Make physical memory consistent for a single streaming mode DMA translation
- * after a transfer.
- *
- * If you perform a xen_swiotlb_map_page() but wish to interrogate the buffer
- * using the cpu, yet do not wish to teardown the dma mapping, you must
- * call this function before doing so.  At the next point you give the dma
- * address back to the card, you must first perform a
- * xen_swiotlb_dma_sync_for_device, and then the device again owns the buffer
- */
 static void
-xen_swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
-			size_t size, enum dma_data_direction dir,
-			enum dma_sync_target target)
+xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir)
 {
-	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
+	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
 
-	BUG_ON(dir == DMA_NONE);
-
-	if (target == SYNC_FOR_CPU)
-		xen_dma_sync_single_for_cpu(hwdev, dev_addr, size, dir);
+	xen_dma_sync_single_for_cpu(dev, dma_addr, size, dir);
 
-	/* NOTE: We use dev_addr here, not paddr! */
-	if (is_xen_swiotlb_buffer(dev_addr))
-		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
-
-	if (target == SYNC_FOR_DEVICE)
-		xen_dma_sync_single_for_device(hwdev, dev_addr, size, dir);
+	if (is_xen_swiotlb_buffer(dma_addr))
+		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
 
-void
-xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-				size_t size, enum dma_data_direction dir)
+static void
+xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir)
 {
-	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
-}
+	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
 
-void
-xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
-				   size_t size, enum dma_data_direction dir)
-{
-	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
+	if (is_xen_swiotlb_buffer(dma_addr))
+		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
+
+	xen_dma_sync_single_for_device(dev, dma_addr, size, dir);
 }
 
 /*
@@ -541,38 +521,30 @@ xen_swiotlb_map_sg(struct device *dev, struct scatterlist *sgl, int nelems,
 	return 0;
 }
 
-/*
- * Make physical memory consistent for a set of streaming mode DMA translations
- * after a transfer.
- *
- * The same as swiotlb_sync_single_* but for a scatter-gather list, same rules
- * and usage.
- */
 static void
-xen_swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sgl,
-		    int nelems, enum dma_data_direction dir,
-		    enum dma_sync_target target)
+xen_swiotlb_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
+			    int nelems, enum dma_data_direction dir)
 {
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgl, sg, nelems, i)
-		xen_swiotlb_sync_single(hwdev, sg->dma_address,
-					sg_dma_len(sg), dir, target);
-}
-
-static void
-xen_swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-			    int nelems, enum dma_data_direction dir)
-{
-	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
+	for_each_sg(sgl, sg, nelems, i) {
+		xen_swiotlb_sync_single_for_cpu(dev, sg->dma_address,
+				sg->length, dir);
+	}
 }
 
 static void
-xen_swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 			       int nelems, enum dma_data_direction dir)
 {
-	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nelems, i) {
+		xen_swiotlb_sync_single_for_device(dev, sg->dma_address,
+				sg->length, dir);
+	}
 }
 
 /*
-- 
2.20.1
