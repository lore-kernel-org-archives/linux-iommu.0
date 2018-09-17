From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/9] swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
Date: Mon, 17 Sep 2018 17:38:23 +0200
Message-ID: <20180917153826.28052-7-hch@lst.de>
References: <20180917153826.28052-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917153826.28052-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

No need to duplicate the code - map_sg is equivalent to map_page
for each page in the scatterlist.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 15335f3a1bf3..15755d7a5242 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -845,37 +845,27 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
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
+		sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
+				sg->length, dir, attrs);
+		if (sg->dma_address == DIRECT_MAPPING_ERROR)
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
