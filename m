From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] MIPS: remove mips_swiotlb_ops
Date: Fri, 27 Jul 2018 19:26:06 +0200
Message-ID: <20180727172606.21253-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
Cc: Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

mips_swiotlb_ops differs from the generic swiotlb_dma_ops only in that
it contains a mb() barrier after each operations that maps or syncs
dma memory to the device.

The dma operations are defined to not be memory barriers, but instead
the write* operations to kick the DMA off are supposed to contain them.

For mips this handled by war_io_reorder_wmb(), which evaluates to the
stronger wmb() instead of the pure compiler barrier barrier() for
just those platforms that use swiotlb, so I think we are covered
properly.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/include/asm/dma-mapping.h |  3 +-
 arch/mips/mm/Makefile               |  1 -
 arch/mips/mm/dma-swiotlb.c          | 61 -----------------------------
 3 files changed, 1 insertion(+), 64 deletions(-)
 delete mode 100644 arch/mips/mm/dma-swiotlb.c

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 1c6e0c8ef4830..8ae7b20b68627 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -3,14 +3,13 @@
 #define _ASM_DMA_MAPPING_H
 
 extern const struct dma_map_ops jazz_dma_ops;
-extern const struct dma_map_ops mips_swiotlb_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #if defined(CONFIG_MACH_JAZZ)
 	return &jazz_dma_ops;
 #elif defined(CONFIG_SWIOTLB)
-	return &mips_swiotlb_ops;
+	return &swiotlb_dma_ops;
 #elif defined(CONFIG_DMA_NONCOHERENT_OPS)
 	return &dma_noncoherent_ops;
 #else
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 6922f393af196..3e5bb203c95ac 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-noncoherent.o
-obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
 obj-$(CONFIG_CPU_R4K_CACHE_TLB) += c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R3000)		+= c-r3k.o tlb-r3k.o
diff --git a/arch/mips/mm/dma-swiotlb.c b/arch/mips/mm/dma-swiotlb.c
deleted file mode 100644
index 6014ed3479fd7..0000000000000
--- a/arch/mips/mm/dma-swiotlb.c
+++ /dev/null
@@ -1,61 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/dma-mapping.h>
-#include <linux/swiotlb.h>
-
-static void *mips_swiotlb_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
-{
-	void *ret = swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
-
-	mb();
-	return ret;
-}
-
-static dma_addr_t mips_swiotlb_map_page(struct device *dev,
-		struct page *page, unsigned long offset, size_t size,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
-					dir, attrs);
-	mb();
-	return daddr;
-}
-
-static int mips_swiotlb_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, attrs);
-	mb();
-
-	return r;
-}
-
-static void mips_swiotlb_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
-{
-	swiotlb_sync_single_for_device(dev, dma_handle, size, dir);
-	mb();
-}
-
-static void mips_swiotlb_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir)
-{
-	swiotlb_sync_sg_for_device(dev, sg, nents, dir);
-	mb();
-}
-
-const struct dma_map_ops mips_swiotlb_ops = {
-	.alloc			= mips_swiotlb_alloc,
-	.free			= swiotlb_free,
-	.map_page		= mips_swiotlb_map_page,
-	.unmap_page		= swiotlb_unmap_page,
-	.map_sg			= mips_swiotlb_map_sg,
-	.unmap_sg		= swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
-	.sync_single_for_device	= mips_swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device	= mips_swiotlb_sync_sg_for_device,
-	.mapping_error		= swiotlb_dma_mapping_error,
-	.dma_supported		= swiotlb_dma_supported,
-};
-EXPORT_SYMBOL(mips_swiotlb_ops);
-- 
2.18.0
