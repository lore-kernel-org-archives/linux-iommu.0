From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/6] arc: fix arc_dma_{map,unmap}_page
Date: Fri, 18 May 2018 15:45:44 +0200
Message-ID: <20180518134545.5036-6-hch@lst.de>
References: <20180518134545.5036-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180518134545.5036-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, iommu@lists.linux-foundation.org
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

These functions should perform the same cache synchronoization as calling
arc_dma_sync_single_for_{cpu,device} in addition to doing any required
address translation or mapping [1].  Ensure they actually do that by calling
arc_dma_sync_single_for_{cpu,device} instead of passing the dir argument
along to _dma_cache_sync.

The now unused _dma_cache_sync function is removed as well.

[1] in fact various drivers rely on that by passing DMA_ATTR_SKIP_CPU_SYNC
to the map/unmap routines and doing the cache synchronization manually.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/mm/dma.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index eafdbd2ad20a..08d91c13ac52 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -130,29 +130,6 @@ static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	return ret;
 }
 
-/*
- * streaming DMA Mapping API...
- * CPU accesses page via normal paddr, thus needs to explicitly made
- * consistent before each use
- */
-static void _dma_cache_sync(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-	switch (dir) {
-	case DMA_FROM_DEVICE:
-		dma_cache_inv(paddr, size);
-		break;
-	case DMA_TO_DEVICE:
-		dma_cache_wback(paddr, size);
-		break;
-	case DMA_BIDIRECTIONAL:
-		dma_cache_wback_inv(paddr, size);
-		break;
-	default:
-		pr_err("Invalid DMA dir [%d] for OP @ %pa[p]\n", dir, &paddr);
-	}
-}
-
 static void arc_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -185,7 +162,7 @@ static dma_addr_t arc_dma_map_page(struct device *dev, struct page *page,
 	phys_addr_t paddr = page_to_phys(page) + offset;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		_dma_cache_sync(paddr, size, dir);
+		arc_dma_sync_single_for_device(dev, paddr, size, dir);
 
 	return paddr;
 }
@@ -205,7 +182,7 @@ static void arc_dma_unmap_page(struct device *dev, dma_addr_t handle,
 	phys_addr_t paddr = handle;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		_dma_cache_sync(paddr, size, dir);
+		arc_dma_sync_single_for_cpu(dev, paddr, size, dir);
 }
 
 static int arc_dma_map_sg(struct device *dev, struct scatterlist *sg,
-- 
2.17.0
