From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] hexagon: implement the sync_sg_for_device DMA operation
Date: Thu, 19 Jul 2018 05:56:34 -0700
Message-ID: <20180719125635.824-3-hch@lst.de>
References: <20180719125635.824-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719125635.824-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This methods needs to provide the equivalent of sync_single_for_device
for each S/G list element, but was missing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index d2b717f352f4..9e46556a227d 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -188,6 +188,18 @@ static void hexagon_sync_single_for_device(struct device *dev,
 	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
 }
 
+static void hexagon_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		hexagon_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
+}
+
+
 static int hexagon_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == HEXAGON_MAPPING_ERROR;
@@ -199,6 +211,7 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
 	.sync_single_for_device = hexagon_sync_single_for_device,
+	.sync_sg_for_device = hexagon_sync_sg_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
 
-- 
2.18.0
