From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/6] swiotlb: share more code between map_page and map_sg
Date: Wed, 25 Jul 2018 13:38:01 +0200
Message-ID: <20180725113802.18943-6-hch@lst.de>
References: <20180725113802.18943-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725113802.18943-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Refactor all the common code into what previously was map_single, which
is now renamed to __swiotlb_map_page.  This also improves the map_sg
error handling and diagnostics to match the map_page ones.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 114 ++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 61 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 5555e1fd03cf..8ca0964ebf3a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -593,21 +593,47 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 /*
  * Allocates bounce buffer and returns its physical address.
  */
-static phys_addr_t
-map_single(struct device *hwdev, phys_addr_t phys, size_t size,
-	   enum dma_data_direction dir, unsigned long attrs)
+static int
+__swiotlb_map_page(struct device *dev, phys_addr_t phys, size_t size,
+		enum dma_data_direction dir, unsigned long attrs,
+		dma_addr_t *dma_addr)
 {
-	dma_addr_t start_dma_addr;
-
-	if (swiotlb_force == SWIOTLB_NO_FORCE) {
-		dev_warn_ratelimited(hwdev, "Cannot do DMA to address %pa\n",
-				     &phys);
-		return SWIOTLB_MAP_ERROR;
+	phys_addr_t map_addr;
+
+	if (WARN_ON_ONCE(dir == DMA_NONE))
+		return -EINVAL;
+	*dma_addr = phys_to_dma(dev, phys);
+
+	switch (swiotlb_force) {
+	case SWIOTLB_NO_FORCE:
+		dev_warn_ratelimited(dev,
+			"swiotlb: force disabled for address %pa\n", &phys);
+		return -EOPNOTSUPP;
+	case SWIOTLB_NORMAL:
+		/* can we address the memory directly? */
+		if (dma_capable(dev, *dma_addr, size))
+			return 0;
+		break;
+	case SWIOTLB_FORCE:
+		break;
 	}
 
-	start_dma_addr = __phys_to_dma(hwdev, io_tlb_start);
-	return swiotlb_tbl_map_single(hwdev, start_dma_addr, phys, size,
-				      dir, attrs);
+	trace_swiotlb_bounced(dev, *dma_addr, size, swiotlb_force);
+	map_addr = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
+			phys, size, dir, attrs);
+	if (unlikely(map_addr == SWIOTLB_MAP_ERROR))
+		return -ENOMEM;
+
+	/* Ensure that the address returned is DMA'ble */
+	*dma_addr = __phys_to_dma(dev, map_addr);
+	if (unlikely(!dma_capable(dev, *dma_addr, size))) {
+		dev_err_ratelimited(dev,
+			"DMA: swiotlb buffer not addressable.\n");
+		swiotlb_tbl_unmap_single(dev, map_addr, size, dir,
+			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+		return -EINVAL;
+	}
+	return 0;
 }
 
 /*
@@ -773,35 +799,12 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 			    enum dma_data_direction dir,
 			    unsigned long attrs)
 {
-	phys_addr_t map, phys = page_to_phys(page) + offset;
-	dma_addr_t dev_addr = phys_to_dma(dev, phys);
-
-	BUG_ON(dir == DMA_NONE);
-	/*
-	 * If the address happens to be in the device's DMA window,
-	 * we can safely return the device addr and not worry about bounce
-	 * buffering it.
-	 */
-	if (dma_capable(dev, dev_addr, size) && swiotlb_force != SWIOTLB_FORCE)
-		return dev_addr;
+	dma_addr_t dma_addr;
 
-	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
-
-	/* Oh well, have to allocate and map a bounce buffer. */
-	map = map_single(dev, phys, size, dir, attrs);
-	if (map == SWIOTLB_MAP_ERROR)
+	if (unlikely(__swiotlb_map_page(dev, page_to_phys(page) + offset, size,
+			dir, attrs, &dma_addr) < 0))
 		return __phys_to_dma(dev, io_tlb_overflow_buffer);
-
-	dev_addr = __phys_to_dma(dev, map);
-
-	/* Ensure that the address returned is DMA'ble */
-	if (dma_capable(dev, dev_addr, size))
-		return dev_addr;
-
-	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
-
-	return __phys_to_dma(dev, io_tlb_overflow_buffer);
+	return dma_addr;
 }
 
 /*
@@ -892,37 +895,26 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
  * same here.
  */
 int
-swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
+swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
 		     enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
 
-	BUG_ON(dir == DMA_NONE);
-
 	for_each_sg(sgl, sg, nelems, i) {
-		phys_addr_t paddr = sg_phys(sg);
-		dma_addr_t dev_addr = phys_to_dma(hwdev, paddr);
-
-		if (swiotlb_force == SWIOTLB_FORCE ||
-		    !dma_capable(hwdev, dev_addr, sg->length)) {
-			phys_addr_t map = map_single(hwdev, sg_phys(sg),
-						     sg->length, dir, attrs);
-			if (map == SWIOTLB_MAP_ERROR) {
-				/* Don't panic here, we expect map_sg users
-				   to do proper error handling. */
-				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
-						       attrs);
-				sg_dma_len(sgl) = 0;
-				return 0;
-			}
-			sg->dma_address = __phys_to_dma(hwdev, map);
-		} else
-			sg->dma_address = dev_addr;
+		if (unlikely(__swiotlb_map_page(dev, sg_phys(sg), sg->length,
+				dir, attrs, &sg->dma_address) < 0))
+			goto out_error;
 		sg_dma_len(sg) = sg->length;
 	}
+
 	return nelems;
+
+out_error:
+	swiotlb_unmap_sg_attrs(dev, sgl, i, dir,
+			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	sg_dma_len(sgl) = 0;
+	return 0;
 }
 
 /*
-- 
2.18.0
