From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/6] swiotlb: respect DMA_ATTR_NO_WARN in __swiotlb_map_page
Date: Wed, 25 Jul 2018 13:38:02 +0200
Message-ID: <20180725113802.18943-7-hch@lst.de>
References: <20180725113802.18943-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725113802.18943-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca0964ebf3a..5c3db7c89e0f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -606,8 +606,11 @@ __swiotlb_map_page(struct device *dev, phys_addr_t phys, size_t size,
 
 	switch (swiotlb_force) {
 	case SWIOTLB_NO_FORCE:
-		dev_warn_ratelimited(dev,
-			"swiotlb: force disabled for address %pa\n", &phys);
+		if (!(attrs & DMA_ATTR_NO_WARN)) {
+			dev_warn_ratelimited(dev,
+				"swiotlb: force disabled for address %pa\n",
+				&phys);
+		}
 		return -EOPNOTSUPP;
 	case SWIOTLB_NORMAL:
 		/* can we address the memory directly? */
@@ -627,10 +630,12 @@ __swiotlb_map_page(struct device *dev, phys_addr_t phys, size_t size,
 	/* Ensure that the address returned is DMA'ble */
 	*dma_addr = __phys_to_dma(dev, map_addr);
 	if (unlikely(!dma_capable(dev, *dma_addr, size))) {
-		dev_err_ratelimited(dev,
-			"DMA: swiotlb buffer not addressable.\n");
+		if (!(attrs & DMA_ATTR_NO_WARN)) {
+			dev_err_ratelimited(dev,
+				"DMA: swiotlb buffer not addressable.\n");
+		}
 		swiotlb_tbl_unmap_single(dev, map_addr, size, dir,
-			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+				attrs | DMA_ATTR_SKIP_CPU_SYNC);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.18.0
