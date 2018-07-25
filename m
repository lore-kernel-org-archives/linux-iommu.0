From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/6] swiotlb: merge swiotlb_unmap_page and unmap_single
Date: Wed, 25 Jul 2018 13:37:59 +0200
Message-ID: <20180725113802.18943-4-hch@lst.de>
References: <20180725113802.18943-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725113802.18943-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 06cfc4d00325..03016221fc64 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -812,9 +812,9 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
  * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
-static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
-			 size_t size, enum dma_data_direction dir,
-			 unsigned long attrs)
+void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs)
 {
 	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
 
@@ -837,13 +837,6 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 	dma_mark_clean(phys_to_virt(paddr), size);
 }
 
-void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
-			size_t size, enum dma_data_direction dir,
-			unsigned long attrs)
-{
-	unmap_single(hwdev, dev_addr, size, dir, attrs);
-}
-
 /*
  * Make physical memory consistent for a single streaming mode DMA translation
  * after a transfer.
@@ -947,7 +940,7 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i)
-		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir,
+		swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
 }
 
-- 
2.18.0
