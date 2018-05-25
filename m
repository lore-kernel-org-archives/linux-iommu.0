From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 21/25] MIPS: jazz: split dma mapping operations from
	dma-default
Date: Fri, 25 May 2018 11:21:07 +0200
Message-ID: <20180525092111.18516-22-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180525092111.18516-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Jazz actually has a very basic IOMMU, so split the ops into a separate
implementation from the generic default support (which is about to go
away anyway).

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/include/asm/dma-mapping.h           |   5 +-
 .../include/asm/mach-jazz/dma-coherence.h     |  60 --------
 arch/mips/jazz/Kconfig                        |   3 -
 arch/mips/jazz/jazzdma.c                      | 141 +++++++++++++++++-
 4 files changed, 144 insertions(+), 65 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-jazz/dma-coherence.h

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index e32a7b439816..caf97f739897 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -10,12 +10,15 @@
 #include <dma-coherence.h>
 #endif
 
+extern const struct dma_map_ops jazz_dma_ops;
 extern const struct dma_map_ops mips_default_dma_map_ops;
 extern const struct dma_map_ops mips_swiotlb_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-#ifdef CONFIG_SWIOTLB
+#if defined(CONFIG_MACH_JAZZ)
+	return &jazz_dma_ops;
+#elif defined(CONFIG_SWIOTLB)
 	return &mips_swiotlb_ops;
 #elif defined(CONFIG_MIPS_DMA_DEFAULT)
 	return &mips_default_dma_map_ops;
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
deleted file mode 100644
index dc347c25c343..000000000000
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
- */
-#ifndef __ASM_MACH_JAZZ_DMA_COHERENCE_H
-#define __ASM_MACH_JAZZ_DMA_COHERENCE_H
-
-#include <asm/jazzdma.h>
-
-struct device;
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size)
-{
-	return vdma_alloc(virt_to_phys(addr), size);
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	return vdma_alloc(page_to_phys(page), PAGE_SIZE);
-}
-
-static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr)
-{
-	return vdma_log2phys(dma_addr);
-}
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
-	vdma_free(dma_addr);
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s,
-	 * so we can't guarantee allocations that must be
-	 * within a tighter range than GFP_DMA..
-	 */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;
-}
-
-#endif /* __ASM_MACH_JAZZ_DMA_COHERENCE_H */
diff --git a/arch/mips/jazz/Kconfig b/arch/mips/jazz/Kconfig
index d3ae3e0356f6..06838f80a5d7 100644
--- a/arch/mips/jazz/Kconfig
+++ b/arch/mips/jazz/Kconfig
@@ -3,7 +3,6 @@ config ACER_PICA_61
 	bool "Support for Acer PICA 1 chipset"
 	depends on MACH_JAZZ
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  This is a machine with a R4400 133/150 MHz CPU. To compile a Linux
@@ -15,7 +14,6 @@ config MIPS_MAGNUM_4000
 	bool "Support for MIPS Magnum 4000"
 	depends on MACH_JAZZ
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
@@ -28,7 +26,6 @@ config OLIVETTI_M700
 	bool "Support for Olivetti M700-10"
 	depends on MACH_JAZZ
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  This is a machine with a R4000 100 MHz CPU. To compile a Linux
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index d626a9a391cc..446fc8c92e1e 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -16,6 +16,8 @@
 #include <linux/bootmem.h>
 #include <linux/spinlock.h>
 #include <linux/gfp.h>
+#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <asm/mipsregs.h>
 #include <asm/jazz.h>
 #include <asm/io.h>
@@ -86,6 +88,7 @@ static int __init vdma_init(void)
 	printk(KERN_INFO "VDMA: R4030 DMA pagetables initialized.\n");
 	return 0;
 }
+arch_initcall(vdma_init);
 
 /*
  * Allocate DMA pagetables using a simple first-fit algorithm
@@ -556,4 +559,140 @@ int vdma_get_enable(int channel)
 	return enable;
 }
 
-arch_initcall(vdma_init);
+static void *jazz_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	void *ret;
+
+	ret = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
+	if (!ret)
+		return NULL;
+
+	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
+	if (*dma_handle == VDMA_ERROR) {
+		dma_direct_free(dev, size, ret, *dma_handle, attrs);
+		return NULL;
+	}
+
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT)) {
+		dma_cache_wback_inv((unsigned long)ret, size);
+		ret = UNCAC_ADDR(ret);
+	}
+	return ret;
+}
+
+static void jazz_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
+{
+	vdma_free(dma_handle);
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
+		vaddr = (void *)CAC_ADDR((unsigned long)vaddr);
+	return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
+}
+
+static dma_addr_t jazz_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(dev, phys, size, dir);
+	return vdma_alloc(phys, size);
+}
+
+static void jazz_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_cpu(dev, vdma_log2phys(dma_addr), size, dir);
+	vdma_free(dma_addr);
+}
+
+static int jazz_dma_map_sg(struct device *dev, struct scatterlist *sglist,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nents, i) {
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+			arch_sync_dma_for_device(dev, sg_phys(sg), sg->length,
+				dir);
+		sg->dma_address = vdma_alloc(sg_phys(sg), sg->length);
+		if (sg->dma_address == VDMA_ERROR)
+			return 0;
+		sg_dma_len(sg) = sg->length;
+	}
+
+	return nents;
+}
+
+static void jazz_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nents, i) {
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+			arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length,
+				dir);
+		vdma_free(sg->dma_address);
+	}
+}
+
+static void jazz_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	arch_sync_dma_for_device(dev, vdma_log2phys(addr), size, dir);
+}
+
+static void jazz_dma_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	arch_sync_dma_for_cpu(dev, vdma_log2phys(addr), size, dir);
+}
+
+static void jazz_dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
+}
+
+static void jazz_dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+}
+
+static int jazz_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == VDMA_ERROR;
+}
+
+const struct dma_map_ops jazz_dma_ops = {
+	.alloc			= jazz_dma_alloc,
+	.free			= jazz_dma_free,
+	.mmap			= arch_dma_mmap,
+	.map_page		= jazz_dma_map_page,
+	.unmap_page		= jazz_dma_unmap_page,
+	.map_sg			= jazz_dma_map_sg,
+	.unmap_sg		= jazz_dma_unmap_sg,
+	.sync_single_for_cpu	= jazz_dma_sync_single_for_cpu,
+	.sync_single_for_device	= jazz_dma_sync_single_for_device,
+	.sync_sg_for_cpu	= jazz_dma_sync_sg_for_cpu,
+	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
+	.dma_supported		= dma_direct_supported,
+	.cache_sync		= arch_dma_cache_sync,
+	.mapping_error		= jazz_dma_mapping_error,
+};
+EXPORT_SYMBOL(jazz_dma_ops);
-- 
2.17.0
