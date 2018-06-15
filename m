From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 23/25] MIPS: bmips: use generic dma noncoherent ops
Date: Fri, 15 Jun 2018 13:08:52 +0200
Message-ID: <20180615110854.19253-24-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180615110854.19253-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Provide phys_to_dma/dma_to_phys helpers, and the special
arch_sync_dma_for_cpu_all hook, everything else is generic

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/Kconfig                             |  3 +-
 arch/mips/bmips/dma.c                         | 32 ++++++-----
 arch/mips/include/asm/bmips.h                 | 16 ------
 .../include/asm/mach-bmips/dma-coherence.h    | 54 -------------------
 4 files changed, 21 insertions(+), 84 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-bmips/dma-coherence.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f30ef932451f..7f7edb2b4fcd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -214,6 +214,8 @@ config ATH79
 
 config BMIPS_GENERIC
 	bool "Broadcom Generic BMIPS kernel"
+	select ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+	select ARCH_HAS_PHYS_TO_DMA
 	select BOOT_RAW
 	select NO_EXCEPT_FILL
 	select USE_OF
@@ -226,7 +228,6 @@ config BMIPS_GENERIC
 	select BCM7120_L2_IRQ
 	select BRCMSTB_L2_IRQ
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 6dec30842b2f..3d13c77c125f 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -17,7 +17,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <dma-coherence.h>
+#include <asm/bmips.h>
 
 /*
  * BCM338x has configurable address translation windows which allow the
@@ -40,7 +40,7 @@ static struct bmips_dma_range *bmips_dma_ranges;
 
 #define FLUSH_RAC		0x100
 
-static dma_addr_t bmips_phys_to_dma(struct device *dev, phys_addr_t pa)
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t pa)
 {
 	struct bmips_dma_range *r;
 
@@ -52,17 +52,7 @@ static dma_addr_t bmips_phys_to_dma(struct device *dev, phys_addr_t pa)
 	return pa;
 }
 
-dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size)
-{
-	return bmips_phys_to_dma(dev, virt_to_phys(addr));
-}
-
-dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	return bmips_phys_to_dma(dev, page_to_phys(page));
-}
-
-unsigned long plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
 	struct bmips_dma_range *r;
 
@@ -74,6 +64,22 @@ unsigned long plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
 	return dma_addr;
 }
 
+void arch_sync_dma_for_cpu_all(struct device *dev)
+{
+	void __iomem *cbr = BMIPS_GET_CBR();
+	u32 cfg;
+
+	if (boot_cpu_type() != CPU_BMIPS3300 &&
+	    boot_cpu_type() != CPU_BMIPS4350 &&
+	    boot_cpu_type() != CPU_BMIPS4380)
+		return;
+
+	/* Flush stale data out of the readahead cache */
+	cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
+	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
+	__raw_readl(cbr + BMIPS_RAC_CONFIG);
+}
+
 static int __init bmips_init_dma_ranges(void)
 {
 	struct device_node *np =
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index b3e2975f83d3..bf6a8afd7ad2 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -123,22 +123,6 @@ static inline void bmips_write_zscm_reg(unsigned int offset, unsigned long data)
 	barrier();
 }
 
-static inline void bmips_post_dma_flush(struct device *dev)
-{
-	void __iomem *cbr = BMIPS_GET_CBR();
-	u32 cfg;
-
-	if (boot_cpu_type() != CPU_BMIPS3300 &&
-	    boot_cpu_type() != CPU_BMIPS4350 &&
-	    boot_cpu_type() != CPU_BMIPS4380)
-		return;
-
-	/* Flush stale data out of the readahead cache */
-	cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
-	__raw_readl(cbr + BMIPS_RAC_CONFIG);
-}
-
 #endif /* !defined(__ASSEMBLY__) */
 
 #endif /* _ASM_BMIPS_H */
diff --git a/arch/mips/include/asm/mach-bmips/dma-coherence.h b/arch/mips/include/asm/mach-bmips/dma-coherence.h
deleted file mode 100644
index d29781f02285..000000000000
--- a/arch/mips/include/asm/mach-bmips/dma-coherence.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Copyright (C) 2006 Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
- * Copyright (C) 2009 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-#ifndef __ASM_MACH_BMIPS_DMA_COHERENCE_H
-#define __ASM_MACH_BMIPS_DMA_COHERENCE_H
-
-#include <asm/bmips.h>
-#include <asm/cpu-type.h>
-#include <asm/cpu.h>
-
-struct device;
-
-extern dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size);
-extern dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page);
-extern unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr);
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
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
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;
-}
-
-#define plat_post_dma_flush	bmips_post_dma_flush
-
-#endif /* __ASM_MACH_BMIPS_DMA_COHERENCE_H */
-- 
2.17.1
