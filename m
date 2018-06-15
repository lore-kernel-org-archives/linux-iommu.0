From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 18/25] MIPS: loongson64: use generic dma noncoherent ops
Date: Fri, 15 Jun 2018 13:08:47 +0200
Message-ID: <20180615110854.19253-19-hch@lst.de>
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

Provide phys_to_dma/dma_to_phys helpers, everything else is generic.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/Kconfig                             |  1 +
 .../asm/mach-loongson64/dma-coherence.h       | 69 -------------------
 arch/mips/loongson64/Kconfig                  |  2 -
 arch/mips/loongson64/common/Makefile          |  1 +
 arch/mips/loongson64/common/dma.c             | 16 +++++
 5 files changed, 18 insertions(+), 71 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson64/dma-coherence.h
 create mode 100644 arch/mips/loongson64/common/dma.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 326bd73bc5bf..e192e484b1b8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1827,6 +1827,7 @@ config CPU_LOONGSON2
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
+	select ARCH_HAS_PHYS_TO_DMA
 
 config CPU_LOONGSON1
 	bool
diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
deleted file mode 100644
index 651dd2eb3ee5..000000000000
--- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006, 07  Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx-h23VmSynlr/QT0dZR+AlfA@public.gmane.org
- *
- */
-#ifndef __ASM_MACH_LOONGSON64_DMA_COHERENCE_H
-#define __ASM_MACH_LOONGSON64_DMA_COHERENCE_H
-
-#ifdef CONFIG_SWIOTLB
-#include <linux/swiotlb.h>
-#endif
-
-struct device;
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
-					  size_t size)
-{
-	return virt_to_phys(addr) | 0x80000000;
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-					       struct page *page)
-{
-	return page_to_phys(page) | 0x80000000;
-}
-
-static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr)
-{
-#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
-	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
-#else
-	return dma_addr & 0x7fffffff;
-#endif
-}
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
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-
-#endif /* __ASM_MACH_LOONGSON64_DMA_COHERENCE_H */
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index a785bf8da3f3..c865b4b9b775 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -13,7 +13,6 @@ config LEMOTE_FULOONG2E
 	select CSRC_R4K
 	select SYS_HAS_CPU_LOONGSON2E
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select BOOT_ELF32
 	select BOARD_SCACHE
 	select HW_HAS_PCI
@@ -45,7 +44,6 @@ config LEMOTE_MACH2F
 	select CS5536
 	select CSRC_R4K if ! MIPS_EXTERNAL_TIMER
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select HAVE_CLK
 	select HW_HAS_PCI
diff --git a/arch/mips/loongson64/common/Makefile b/arch/mips/loongson64/common/Makefile
index 684624f61f5a..57ee03022941 100644
--- a/arch/mips/loongson64/common/Makefile
+++ b/arch/mips/loongson64/common/Makefile
@@ -6,6 +6,7 @@
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
     bonito-irq.o mem.o machtype.o platform.o serial.o
 obj-$(CONFIG_PCI) += pci.o
+obj-$(CONFIG_CPU_LOONGSON2) += dma.o
 
 #
 # Serial port support
diff --git a/arch/mips/loongson64/common/dma.c b/arch/mips/loongson64/common/dma.c
new file mode 100644
index 000000000000..95ede4b0fbbb
--- /dev/null
+++ b/arch/mips/loongson64/common/dma.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-direct.h>
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr | 0x80000000;
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+	if (dma_addr > 0x8fffffff)
+		return dma_addr;
+#endif
+	return dma_addr & 0x0fffffff;
+}
-- 
2.17.1
