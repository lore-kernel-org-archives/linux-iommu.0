From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 19/25] MIPS: IP32: use generic dma noncoherent ops
Date: Fri, 25 May 2018 11:21:05 +0200
Message-ID: <20180525092111.18516-20-hch@lst.de>
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

Provide phys_to_dma/dma_to_phys helpers, everything else is generic.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/Kconfig                             |  2 +-
 .../include/asm/mach-ip32/dma-coherence.h     | 92 -------------------
 arch/mips/sgi-ip32/Makefile                   |  2 +-
 arch/mips/sgi-ip32/ip32-dma.c                 | 37 ++++++++
 4 files changed, 39 insertions(+), 94 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ip32/dma-coherence.h
 create mode 100644 arch/mips/sgi-ip32/ip32-dma.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3140955bc77c..bde16399a8fe 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -720,6 +720,7 @@ config SGI_IP28
 
 config SGI_IP32
 	bool "SGI IP32 (O2)"
+	select ARCH_HAS_PHYS_TO_DMA
 	select FW_ARC
 	select FW_ARC32
 	select BOOT_ELF32
@@ -728,7 +729,6 @@ config SGI_IP32
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select R5000_CPU_SCACHE
 	select RM7000_CPU_SCACHE
 	select SYS_HAS_CPU_R5000
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
deleted file mode 100644
index 7bdf212587a0..000000000000
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
- *
- */
-#ifndef __ASM_MACH_IP32_DMA_COHERENCE_H
-#define __ASM_MACH_IP32_DMA_COHERENCE_H
-
-#include <asm/ip32/crime.h>
-
-struct device;
-
-/*
- * Few notes.
- * 1. CPU sees memory as two chunks: 0-256M@0x0, and the rest @0x40000000+256M
- * 2. PCI sees memory as one big chunk @0x0 (or we could use 0x40000000 for
- *    native-endian)
- * 3. All other devices see memory as one big chunk at 0x40000000
- * 4. Non-PCI devices will pass NULL as struct device*
- *
- * Thus we translate differently, depending on device.
- */
-
-#define RAM_OFFSET_MASK 0x3fffffffUL
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
-	size_t size)
-{
-	dma_addr_t pa = virt_to_phys(addr) & RAM_OFFSET_MASK;
-
-	if (dev == NULL)
-		pa += CRIME_HI_MEM_BASE;
-
-	return pa;
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	dma_addr_t pa;
-
-	pa = page_to_phys(page) & RAM_OFFSET_MASK;
-
-	if (dev == NULL)
-		pa += CRIME_HI_MEM_BASE;
-
-	return pa;
-}
-
-/* This is almost certainly wrong but it's what dma-ip32.c used to use	*/
-static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr)
-{
-	unsigned long addr = dma_addr & RAM_OFFSET_MASK;
-
-	if (dma_addr >= 256*1024*1024)
-		addr += CRIME_HI_MEM_BASE;
-
-	return addr;
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
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;		/* IP32 is non-coherent */
-}
-
-#endif /* __ASM_MACH_IP32_DMA_COHERENCE_H */
diff --git a/arch/mips/sgi-ip32/Makefile b/arch/mips/sgi-ip32/Makefile
index 60f0227425e7..4745cd94df11 100644
--- a/arch/mips/sgi-ip32/Makefile
+++ b/arch/mips/sgi-ip32/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-y	+= ip32-berr.o ip32-irq.o ip32-platform.o ip32-setup.o ip32-reset.o \
-	   crime.o ip32-memory.o
+	   crime.o ip32-memory.o ip32-dma.o
diff --git a/arch/mips/sgi-ip32/ip32-dma.c b/arch/mips/sgi-ip32/ip32-dma.c
new file mode 100644
index 000000000000..fa7b17cb5385
--- /dev/null
+++ b/arch/mips/sgi-ip32/ip32-dma.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2006  Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
+ */
+#include <linux/dma-direct.h>
+#include <asm/ip32/crime.h>
+
+/*
+ * Few notes.
+ * 1. CPU sees memory as two chunks: 0-256M@0x0, and the rest @0x40000000+256M
+ * 2. PCI sees memory as one big chunk @0x0 (or we could use 0x40000000 for
+ *    native-endian)
+ * 3. All other devices see memory as one big chunk at 0x40000000
+ * 4. Non-PCI devices will pass NULL as struct device*
+ *
+ * Thus we translate differently, depending on device.
+ */
+
+#define RAM_OFFSET_MASK 0x3fffffffUL
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	dma_addr_t dma_addr = paddr & RAM_OFFSET_MASK;
+
+	if (!dev)
+		dma_addr += CRIME_HI_MEM_BASE;
+	return dma_addr;
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	phys_addr_t paddr = dma_addr & RAM_OFFSET_MASK;
+
+	if (dma_addr >= 256*1024*1024)
+		paddr += CRIME_HI_MEM_BASE;
+	return paddr;
+}
-- 
2.17.0
