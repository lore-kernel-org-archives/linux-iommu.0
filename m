From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 12/25] MIPS: loongson: untangle dma implementations
Date: Fri, 25 May 2018 11:20:58 +0200
Message-ID: <20180525092111.18516-13-hch@lst.de>
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

Only loongson-3 is DMA coherent and uses swiotlb.  So move the dma
address translations stubs directly to the loongson-3 code, and remove
a few Kconfig indirections.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/Kconfig                                |  2 +-
 arch/mips/loongson64/Kconfig                     |  5 -----
 arch/mips/loongson64/common/Makefile             |  5 -----
 arch/mips/loongson64/loongson-3/Makefile         |  2 +-
 .../{common/dma-swiotlb.c => loongson-3/dma.c}   | 16 ++++------------
 5 files changed, 6 insertions(+), 24 deletions(-)
 rename arch/mips/loongson64/{common/dma-swiotlb.c => loongson-3/dma.c} (68%)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 92cc7943d940..24cc20ea60b9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -448,7 +448,6 @@ config MACH_LOONGSON32
 
 config MACH_LOONGSON64
 	bool "Loongson-2/3 family of machines"
-	select ARCH_HAS_PHYS_TO_DMA
 	select SYS_SUPPORTS_ZBOOT
 	help
 	  This enables the support of Loongson-2/3 family of machines.
@@ -1383,6 +1382,7 @@ choice
 config CPU_LOONGSON3
 	bool "Loongson 3 CPU"
 	depends on SYS_HAS_CPU_LOONGSON3
+	select ARCH_HAS_PHYS_TO_DMA
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index dbd2a9f9f9a9..a785bf8da3f3 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -93,7 +93,6 @@ config LOONGSON_MACH3X
 	select LOONGSON_MC146818
 	select ZONE_DMA32
 	select LEFI_FIRMWARE_INTERFACE
-	select PHYS48_TO_HT40
 	help
 		Generic Loongson 3 family machines utilize the 3A/3B revision
 		of Loongson processor and RS780/SBX00 chipset.
@@ -132,10 +131,6 @@ config LOONGSON_UART_BASE
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
 
-config PHYS48_TO_HT40
-	bool
-	default y if CPU_LOONGSON3
-
 config LOONGSON_MC146818
 	bool
 	default n
diff --git a/arch/mips/loongson64/common/Makefile b/arch/mips/loongson64/common/Makefile
index 8235ac7eac95..684624f61f5a 100644
--- a/arch/mips/loongson64/common/Makefile
+++ b/arch/mips/loongson64/common/Makefile
@@ -25,8 +25,3 @@ obj-$(CONFIG_CS5536) += cs5536/
 #
 
 obj-$(CONFIG_SUSPEND) += pm.o
-
-#
-# Big Memory (SWIOTLB) Support
-#
-obj-$(CONFIG_SWIOTLB) += dma-swiotlb.o
diff --git a/arch/mips/loongson64/loongson-3/Makefile b/arch/mips/loongson64/loongson-3/Makefile
index 44bc1482158b..b5a0c2fa5446 100644
--- a/arch/mips/loongson64/loongson-3/Makefile
+++ b/arch/mips/loongson64/loongson-3/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for Loongson-3 family machines
 #
-obj-y			+= irq.o cop2-ex.o platform.o acpi_init.o
+obj-y			+= irq.o cop2-ex.o platform.o acpi_init.o dma.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/loongson-3/dma.c
similarity index 68%
rename from arch/mips/loongson64/common/dma-swiotlb.c
rename to arch/mips/loongson64/loongson-3/dma.c
index a4f554bf1232..5e86635f71db 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/loongson-3/dma.c
@@ -5,26 +5,18 @@
 
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	long nid;
-#ifdef CONFIG_PHYS48_TO_HT40
 	/* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
 	 * Loongson-3's 48bit address space and embed it into 40bit */
-	nid = (paddr >> 44) & 0x3;
-	paddr = ((nid << 44) ^ paddr) | (nid << 37);
-#endif
-	return paddr;
+	long nid = (paddr >> 44) & 0x3;
+	return ((nid << 44) ^ paddr) | (nid << 37);
 }
 
 phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	long nid;
-#ifdef CONFIG_PHYS48_TO_HT40
 	/* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
 	 * Loongson-3's 48bit address space and embed it into 40bit */
-	nid = (daddr >> 37) & 0x3;
-	daddr = ((nid << 37) ^ daddr) | (nid << 44);
-#endif
-	return daddr;
+	long nid = (daddr >> 37) & 0x3;
+	return ((nid << 37) ^ daddr) | (nid << 44);
 }
 
 void __init plat_swiotlb_setup(void)
-- 
2.17.0
