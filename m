From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/6] arc: use generic dma_noncoherent_ops
Date: Fri, 18 May 2018 15:45:45 +0200
Message-ID: <20180518134545.5036-7-hch@lst.de>
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

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig                   |   4 +
 arch/arc/include/asm/Kbuild        |   1 +
 arch/arc/include/asm/dma-mapping.h |  21 -----
 arch/arc/mm/dma.c                  | 140 +++--------------------------
 4 files changed, 18 insertions(+), 148 deletions(-)
 delete mode 100644 arch/arc/include/asm/dma-mapping.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 7498aca4b887..89d47eac18b2 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -9,11 +9,15 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select DMA_NONCOHERENT_OPS
+	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_FIND_FIRST_BIT
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 4bd5d4369e05..bbdcb955e18f 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -2,6 +2,7 @@
 generic-y += bugs.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += extable.h
 generic-y += fb.h
diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
deleted file mode 100644
index 7a16824bfe98..000000000000
--- a/arch/arc/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * DMA Mapping glue for ARC
- *
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef ASM_ARC_DMA_MAPPING_H
-#define ASM_ARC_DMA_MAPPING_H
-
-extern const struct dma_map_ops arc_dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &arc_dma_ops;
-}
-
-#endif
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 08d91c13ac52..8c1071840979 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -16,13 +16,12 @@
  * The default DMA address == Phy address which is 0x8000_0000 based.
  */
 
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
 
-
-static void *arc_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	unsigned long order = get_order(size);
 	struct page *page;
@@ -89,7 +88,7 @@ static void *arc_dma_alloc(struct device *dev, size_t size,
 	return kvaddr;
 }
 
-static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	phys_addr_t paddr = dma_handle;
@@ -105,9 +104,9 @@ static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
 	__free_pages(page, get_order(size));
 }
 
-static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			unsigned long attrs)
+int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
 {
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -130,127 +129,14 @@ static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	return ret;
 }
 
-static void arc_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
-{
-	dma_cache_wback(dma_handle, size);
-}
-
-static void arc_dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
-{
-	dma_cache_inv(dma_handle, size);
-}
-
-/*
- * arc_dma_map_page - map a portion of a page for streaming DMA
- *
- * Ensure that any data held in the cache is appropriately discarded
- * or written back.
- *
- * The device owns this memory once this call has completed.  The CPU
- * can regain ownership by calling dma_unmap_page().
- *
- * Note: while it takes struct page as arg, caller can "abuse" it to pass
- * a region larger than PAGE_SIZE, provided it is physically contiguous
- * and this still works correctly
- */
-static dma_addr_t arc_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	phys_addr_t paddr = page_to_phys(page) + offset;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arc_dma_sync_single_for_device(dev, paddr, size, dir);
-
-	return paddr;
-}
-
-/*
- * arc_dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
- *
- * After this call, reads by the CPU to the buffer are guaranteed to see
- * whatever the device wrote there.
- *
- * Note: historically this routine was not implemented for ARC
- */
-static void arc_dma_unmap_page(struct device *dev, dma_addr_t handle,
-			       size_t size, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-	phys_addr_t paddr = handle;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arc_dma_sync_single_for_cpu(dev, paddr, size, dir);
-}
-
-static int arc_dma_map_sg(struct device *dev, struct scatterlist *sg,
-	   int nents, enum dma_data_direction dir, unsigned long attrs)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		s->dma_address = dma_map_page(dev, sg_page(s), s->offset,
-					       s->length, dir);
-
-	return nents;
+	dma_cache_wback(paddr, size);
 }
 
-static void arc_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-			     int nents, enum dma_data_direction dir,
-			     unsigned long attrs)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		arc_dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir,
-				   attrs);
+	dma_cache_inv(paddr, size);
 }
-
-static void arc_dma_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sglist, int nelems,
-		enum dma_data_direction dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i)
-		arc_dma_sync_single_for_cpu(dev, sg_phys(sg), sg->length, dir);
-}
-
-static void arc_dma_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sglist, int nelems,
-		enum dma_data_direction dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i)
-		arc_dma_sync_single_for_device(dev, sg_phys(sg), sg->length,
-				dir);
-}
-
-static int arc_dma_supported(struct device *dev, u64 dma_mask)
-{
-	/* Support 32 bit DMA mask exclusively */
-	return dma_mask == DMA_BIT_MASK(32);
-}
-
-const struct dma_map_ops arc_dma_ops = {
-	.alloc			= arc_dma_alloc,
-	.free			= arc_dma_free,
-	.mmap			= arc_dma_mmap,
-	.map_page		= arc_dma_map_page,
-	.unmap_page		= arc_dma_unmap_page,
-	.map_sg			= arc_dma_map_sg,
-	.unmap_sg		= arc_dma_unmap_sg,
-	.sync_single_for_device	= arc_dma_sync_single_for_device,
-	.sync_single_for_cpu	= arc_dma_sync_single_for_cpu,
-	.sync_sg_for_cpu	= arc_dma_sync_sg_for_cpu,
-	.sync_sg_for_device	= arc_dma_sync_sg_for_device,
-	.dma_supported		= arc_dma_supported,
-};
-EXPORT_SYMBOL(arc_dma_ops);
-- 
2.17.0
