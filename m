From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/4] openrisc: remove the no-op unmap_page and unmap_sg DMA operations
Date: Thu, 19 Jul 2018 06:02:30 -0700
Message-ID: <20180719130232.1819-3-hch@lst.de>
References: <20180719130232.1819-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719130232.1819-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 47601274abf7..7cadff93d179 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -171,14 +171,6 @@ or1k_map_page(struct device *dev, struct page *page,
 	return addr;
 }
 
-static void
-or1k_unmap_page(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	/* Nothing special to do here... */
-}
-
 static int
 or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	    int nents, enum dma_data_direction dir,
@@ -195,19 +187,6 @@ or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-static void
-or1k_unmap_sg(struct device *dev, struct scatterlist *sg,
-	      int nents, enum dma_data_direction dir,
-	      unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		or1k_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, 0);
-	}
-}
-
 static void
 or1k_sync_single_for_device(struct device *dev,
 			    dma_addr_t dma_handle, size_t size,
@@ -226,9 +205,7 @@ const struct dma_map_ops or1k_dma_map_ops = {
 	.alloc = or1k_dma_alloc,
 	.free = or1k_dma_free,
 	.map_page = or1k_map_page,
-	.unmap_page = or1k_unmap_page,
 	.map_sg = or1k_map_sg,
-	.unmap_sg = or1k_unmap_sg,
 	.sync_single_for_device = or1k_sync_single_for_device,
 };
 EXPORT_SYMBOL(or1k_dma_map_ops);
-- 
2.18.0
