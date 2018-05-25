From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 20/25] MIPS: ath25: use generic dma noncoherent ops
Date: Fri, 25 May 2018 11:21:06 +0200
Message-ID: <20180525092111.18516-21-hch@lst.de>
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

Provide phys_to_dma/dma_to_phys helpers only if PCI support is
enabled, everything else is generic.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/Kconfig                             |  1 -
 arch/mips/ath25/Kconfig                       |  1 +
 .../include/asm/mach-ath25/dma-coherence.h    | 71 -------------------
 arch/mips/pci/pci-ar2315.c                    | 24 +++++++
 4 files changed, 25 insertions(+), 72 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ath25/dma-coherence.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bde16399a8fe..25a3c3262554 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -176,7 +176,6 @@ config ATH25
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
 	select IRQ_DOMAIN
-	select MIPS_DMA_DEFAULT
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/ath25/Kconfig b/arch/mips/ath25/Kconfig
index 7070b4bcd01d..2c1dfd06c366 100644
--- a/arch/mips/ath25/Kconfig
+++ b/arch/mips/ath25/Kconfig
@@ -12,6 +12,7 @@ config SOC_AR2315
 config PCI_AR2315
 	bool "Atheros AR2315 PCI controller support"
 	depends on SOC_AR2315
+	select ARCH_HAS_PHYS_TO_DMA
 	select HW_HAS_PCI
 	select PCI
 	default y
diff --git a/arch/mips/include/asm/mach-ath25/dma-coherence.h b/arch/mips/include/asm/mach-ath25/dma-coherence.h
deleted file mode 100644
index 124755d4f079..000000000000
--- a/arch/mips/include/asm/mach-ath25/dma-coherence.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
- * Copyright (C) 2007  Felix Fietkau <nbd-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
- *
- */
-#ifndef __ASM_MACH_ATH25_DMA_COHERENCE_H
-#define __ASM_MACH_ATH25_DMA_COHERENCE_H
-
-#include <linux/device.h>
-
-/*
- * We need some arbitrary non-zero value to be programmed to the BAR1 register
- * of PCI host controller to enable DMA. The same value should be used as the
- * offset to calculate the physical address of DMA buffer for PCI devices.
- */
-#define AR2315_PCI_HOST_SDRAM_BASEADDR	0x20000000
-
-static inline dma_addr_t ath25_dev_offset(struct device *dev)
-{
-#ifdef CONFIG_PCI
-	extern struct bus_type pci_bus_type;
-
-	if (dev && dev->bus == &pci_bus_type)
-		return AR2315_PCI_HOST_SDRAM_BASEADDR;
-#endif
-	return 0;
-}
-
-static inline dma_addr_t
-plat_map_dma_mem(struct device *dev, void *addr, size_t size)
-{
-	return virt_to_phys(addr) + ath25_dev_offset(dev);
-}
-
-static inline dma_addr_t
-plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	return page_to_phys(page) + ath25_dev_offset(dev);
-}
-
-static inline unsigned long
-plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr - ath25_dev_offset(dev);
-}
-
-static inline void
-plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr, size_t size,
-		   enum dma_data_direction direction)
-{
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
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
-#endif /* __ASM_MACH_ATH25_DMA_COHERENCE_H */
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index b4fa6413c4e5..c539d0d2b0cf 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -149,6 +149,13 @@
 #define AR2315_PCI_HOST_SLOT	3
 #define AR2315_PCI_HOST_DEVID	((0xff18 << 16) | PCI_VENDOR_ID_ATHEROS)
 
+/*
+ * We need some arbitrary non-zero value to be programmed to the BAR1 register
+ * of PCI host controller to enable DMA. The same value should be used as the
+ * offset to calculate the physical address of DMA buffer for PCI devices.
+ */
+#define AR2315_PCI_HOST_SDRAM_BASEADDR	0x20000000
+
 /* ??? access BAR */
 #define AR2315_PCI_HOST_MBAR0		0x10000000
 /* RAM access BAR */
@@ -167,6 +174,23 @@ struct ar2315_pci_ctrl {
 	struct resource io_res;
 };
 
+static inline dma_addr_t ar2315_dev_offset(struct device *dev)
+{
+	if (dev && dev_is_pci(dev))
+		return AR2315_PCI_HOST_SDRAM_BASEADDR;
+	return 0;
+}
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr + ar2315_dev_offset(dev);
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr - ar2315_dev_offset(dev);
+}
+
 static inline struct ar2315_pci_ctrl *ar2315_pci_bus_to_apc(struct pci_bus *bus)
 {
 	struct pci_controller *hose = bus->sysdata;
-- 
2.17.0
