From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] openrisc: fix cache maintainance the the sync_single_for_device DMA operation
Date: Thu, 19 Jul 2018 06:02:31 -0700
Message-ID: <20180719130232.1819-4-hch@lst.de>
References: <20180719130232.1819-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719130232.1819-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The cache maintaince in the sync_single_for_device operation should be
equivalent to the map_page operation to facilitate reusing buffers.  Fix the
openrisc implementation by moving the cache maintaince performed in map_page
into the sync_single method, and calling that from map_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 42 +++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 7cadff93d179..d6a0bf1fa713 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -133,19 +133,15 @@ or1k_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages_exact(vaddr, size);
 }
 
-static dma_addr_t
-or1k_map_page(struct device *dev, struct page *page,
-	      unsigned long offset, size_t size,
-	      enum dma_data_direction dir,
-	      unsigned long attrs)
+static void
+or1k_sync_single_for_device(struct device *dev,
+			    dma_addr_t dma_handle, size_t size,
+			    enum dma_data_direction dir)
 {
 	unsigned long cl;
-	dma_addr_t addr = page_to_phys(page) + offset;
+	dma_addr_t addr = dma_handle;
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return addr;
-
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		/* Flush the dcache for the requested range */
@@ -168,6 +164,20 @@ or1k_map_page(struct device *dev, struct page *page,
 		break;
 	}
 
+}
+
+static dma_addr_t
+or1k_map_page(struct device *dev, struct page *page,
+	      unsigned long offset, size_t size,
+	      enum dma_data_direction dir,
+	      unsigned long attrs)
+{
+	unsigned long cl;
+	dma_addr_t addr = page_to_phys(page) + offset;
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		or1k_sync_single_for_device(dev, addr, size, dir);
 	return addr;
 }
 
@@ -187,20 +197,6 @@ or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-static void
-or1k_sync_single_for_device(struct device *dev,
-			    dma_addr_t dma_handle, size_t size,
-			    enum dma_data_direction dir)
-{
-	unsigned long cl;
-	dma_addr_t addr = dma_handle;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
-	/* Flush the dcache for the requested range */
-	for (cl = addr; cl < addr + size; cl += cpuinfo->dcache_block_size)
-		mtspr(SPR_DCBFR, cl);
-}
-
 const struct dma_map_ops or1k_dma_map_ops = {
 	.alloc = or1k_dma_alloc,
 	.free = or1k_dma_free,
-- 
2.18.0
