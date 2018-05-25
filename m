From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 09/25] MIPS: make the default mips dma implementation optional
Date: Fri, 25 May 2018 11:20:55 +0200
Message-ID: <20180525092111.18516-10-hch@lst.de>
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

Octeon and loonson64 already don't use it at all, and we're going to
migrate more plaforms away from it.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/Kconfig                   | 40 +++++++++++++++++++++++++++++
 arch/mips/include/asm/dma-mapping.h |  4 ++-
 arch/mips/jazz/Kconfig              |  3 +++
 arch/mips/loongson32/Kconfig        |  2 ++
 arch/mips/loongson64/Kconfig        |  2 ++
 arch/mips/mm/Makefile               |  3 ++-
 arch/mips/pic32/Kconfig             |  1 +
 arch/mips/txx9/Kconfig              |  1 +
 arch/mips/vr41xx/Kconfig            |  5 ++++
 9 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 43bb037301f6..92cc7943d940 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -71,6 +71,9 @@ config MIPS
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
 
+config MIPS_DMA_DEFAULT
+	bool
+
 menu "Machine selection"
 
 choice
@@ -92,6 +95,7 @@ config MIPS_GENERIC
 	select IRQ_MIPS_CPU
 	select LIBFDT
 	select MIPS_CPU_SCACHE
+	select MIPS_DMA_DEFAULT
 	select MIPS_GIC
 	select MIPS_L1_CACHE_SHIFT_7
 	select NO_EXCEPT_FILL
@@ -135,6 +139,7 @@ config MIPS_ALCHEMY
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select DMA_MAYBE_COHERENT	# Au1000,1500,1100 aren't, rest is
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -150,6 +155,7 @@ config AR7
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select NO_EXCEPT_FILL
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
@@ -172,6 +178,7 @@ config ATH25
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
 	select IRQ_DOMAIN
+	select MIPS_DMA_DEFAULT
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -191,6 +198,7 @@ config ATH79
 	select COMMON_CLK
 	select CLKDEV_LOOKUP
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select MIPS_MACHINE
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_EARLY_PRINTK
@@ -217,6 +225,7 @@ config BMIPS_GENERIC
 	select BCM7120_L2_IRQ
 	select BRCMSTB_L2_IRQ
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -247,6 +256,7 @@ config BCM47XX
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
 	select SYS_HAS_CPU_MIPS32_R1
+	select MIPS_DMA_DEFAULT
 	select NO_EXCEPT_FILL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -270,6 +280,7 @@ config BCM63XX
 	select SYNC_R4K
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
@@ -292,6 +303,7 @@ config MIPS_COBALT
 	select I8259
 	select IRQ_MIPS_CPU
 	select IRQ_GT641XX
+	select MIPS_DMA_DEFAULT
 	select PCI_GT64XXX_PCI0
 	select PCI
 	select SYS_HAS_CPU_NEVADA
@@ -312,6 +324,7 @@ config MACH_DECSTATION
 	select CPU_R4000_WORKAROUNDS if 64BIT
 	select CPU_R4400_WORKAROUNDS if 64BIT
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select NO_IOPORT_MAP
 	select IRQ_MIPS_CPU
 	select SYS_HAS_CPU_R3000
@@ -371,6 +384,7 @@ config MACH_INGENIC
 	select SYS_SUPPORTS_ZBOOT_UART16550
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select PINCTRL
 	select GPIOLIB
 	select COMMON_CLK
@@ -385,6 +399,7 @@ config LANTIQ
 	select IRQ_MIPS_CPU
 	select CEVT_R4K
 	select CSRC_R4K
+	select MIPS_DMA_DEFAULT
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -412,6 +427,7 @@ config LASAT
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select PCI_GT64XXX_PCI0
 	select MIPS_NILE4
 	select R5000_CPU_SCACHE
@@ -458,6 +474,7 @@ config MACH_PISTACHIO
 	select LIBFDT
 	select MFD_SYSCON
 	select MIPS_CPU_SCACHE
+	select MIPS_DMA_DEFAULT
 	select MIPS_GIC
 	select PINCTRL
 	select REGULATOR
@@ -490,6 +507,7 @@ config MIPS_MALTA
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select MIPS_GIC
 	select HW_HAS_PCI
 	select I8253
@@ -546,6 +564,7 @@ config NEC_MARKEINS
 	bool "NEC EMMA2RH Mark-eins board"
 	select SOC_EMMA2RH
 	select HW_HAS_PCI
+	select MIPS_DMA_DEFAULT
 	help
 	  This enables support for the NEC Electronics Mark-eins boards.
 
@@ -559,12 +578,14 @@ config MACH_VR41XX
 
 config NXP_STB220
 	bool "NXP STB220 board"
+	select MIPS_DMA_DEFAULT
 	select SOC_PNX833X
 	help
 	 Support for NXP Semiconductors STB220 Development Board.
 
 config NXP_STB225
 	bool "NXP 225 board"
+	select MIPS_DMA_DEFAULT
 	select SOC_PNX833X
 	select SOC_PNX8335
 	help
@@ -584,6 +605,7 @@ config PMC_MSP
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select SERIAL_8250
 	select SERIAL_8250_CONSOLE
 	select USB_EHCI_BIG_ENDIAN_MMIO
@@ -601,6 +623,7 @@ config RALINK
 	select BOOT_RAW
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select USE_OF
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
@@ -627,6 +650,7 @@ config SGI_IP22
 	select I8259
 	select IP22_CPU_SCACHE
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select SGI_HAS_I8042
 	select SGI_HAS_INDYDOG
@@ -660,6 +684,7 @@ config SGI_IP27
 	select FW_ARC64
 	select BOOT_ELF64
 	select DEFAULT_SGI_PARTITION
+	select MIPS_DMA_DEFAULT
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
 	select NR_CPUS_DEFAULT_64
@@ -686,6 +711,7 @@ config SGI_IP28
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select HW_HAS_EISA
 	select I8253
 	select I8259
@@ -722,6 +748,7 @@ config SGI_IP32
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select R5000_CPU_SCACHE
 	select RM7000_CPU_SCACHE
 	select SYS_HAS_CPU_R5000
@@ -736,6 +763,7 @@ config SGI_IP32
 config SIBYTE_CRHINE
 	bool "Sibyte BCM91120C-CRhine"
 	select BOOT_ELF32
+	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -745,6 +773,7 @@ config SIBYTE_CRHINE
 config SIBYTE_CARMEL
 	bool "Sibyte BCM91120x-Carmel"
 	select BOOT_ELF32
+	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -754,6 +783,7 @@ config SIBYTE_CARMEL
 config SIBYTE_CRHONE
 	bool "Sibyte BCM91125C-CRhone"
 	select BOOT_ELF32
+	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1125
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -764,6 +794,7 @@ config SIBYTE_CRHONE
 config SIBYTE_RHONE
 	bool "Sibyte BCM91125E-Rhone"
 	select BOOT_ELF32
+	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1125H
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -774,6 +805,7 @@ config SIBYTE_SWARM
 	bool "Sibyte BCM91250A-SWARM"
 	select BOOT_ELF32
 	select HAVE_PATA_PLATFORM
+	select MIPS_DMA_DEFAULT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -786,6 +818,7 @@ config SIBYTE_LITTLESUR
 	bool "Sibyte BCM91250C2-LittleSur"
 	select BOOT_ELF32
 	select HAVE_PATA_PLATFORM
+	select MIPS_DMA_DEFAULT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -796,6 +829,7 @@ config SIBYTE_LITTLESUR
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
 	select BOOT_ELF32
+	select MIPS_DMA_DEFAULT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -805,6 +839,7 @@ config SIBYTE_SENTOSA
 config SIBYTE_BIGSUR
 	bool "Sibyte BCM91480B-BigSur"
 	select BOOT_ELF32
+	select MIPS_DMA_DEFAULT
 	select NR_CPUS_DEFAULT_4
 	select SIBYTE_BCM1x80
 	select SWAP_IO_SPACE
@@ -835,6 +870,7 @@ config SNI_RM
 	select I8253
 	select I8259
 	select ISA
+	select MIPS_DMA_DEFAULT
 	select SWAP_IO_SPACE if CPU_BIG_ENDIAN
 	select SYS_HAS_CPU_R4X00
 	select SYS_HAS_CPU_R5000
@@ -865,6 +901,7 @@ config MIKROTIK_RB532
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
+	select MIPS_DMA_DEFAULT
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -923,6 +960,7 @@ config NLM_XLR_BOARD
 	select SYS_HAS_CPU_XLR
 	select SYS_SUPPORTS_SMP
 	select HW_HAS_PCI
+	select MIPS_DMA_DEFAULT
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
@@ -949,6 +987,7 @@ config NLM_XLP_BOARD
 	select SYS_HAS_CPU_XLP
 	select SYS_SUPPORTS_SMP
 	select HW_HAS_PCI
+	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select PHYS_ADDR_T_64BIT
@@ -974,6 +1013,7 @@ config MIPS_PARAVIRT
 	bool "Para-Virtualized guest system"
 	select CEVT_R4K
 	select CSRC_R4K
+	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index f24b052ec740..eaf3d9054104 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -17,8 +17,10 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #ifdef CONFIG_SWIOTLB
 	return &mips_swiotlb_ops;
-#else
+#elif defined(CONFIG_MIPS_DMA_DEFAULT)
 	return &mips_default_dma_map_ops;
+#else
+	return NULL;
 #endif
 }
 
diff --git a/arch/mips/jazz/Kconfig b/arch/mips/jazz/Kconfig
index 06838f80a5d7..d3ae3e0356f6 100644
--- a/arch/mips/jazz/Kconfig
+++ b/arch/mips/jazz/Kconfig
@@ -3,6 +3,7 @@ config ACER_PICA_61
 	bool "Support for Acer PICA 1 chipset"
 	depends on MACH_JAZZ
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  This is a machine with a R4400 133/150 MHz CPU. To compile a Linux
@@ -14,6 +15,7 @@ config MIPS_MAGNUM_4000
 	bool "Support for MIPS Magnum 4000"
 	depends on MACH_JAZZ
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
@@ -26,6 +28,7 @@ config OLIVETTI_M700
 	bool "Support for Olivetti M700-10"
 	depends on MACH_JAZZ
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  This is a machine with a R4000 100 MHz CPU. To compile a Linux
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 462b126f45aa..7a69a6c0ce22 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -10,6 +10,7 @@ config LOONGSON1_LS1B
 	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
 	select SYS_HAS_CPU_LOONGSON1B
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select BOOT_ELF32
 	select IRQ_MIPS_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -26,6 +27,7 @@ config LOONGSON1_LS1C
 	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
 	select SYS_HAS_CPU_LOONGSON1C
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select BOOT_ELF32
 	select IRQ_MIPS_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index c79e6a565572..dbd2a9f9f9a9 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -13,6 +13,7 @@ config LEMOTE_FULOONG2E
 	select CSRC_R4K
 	select SYS_HAS_CPU_LOONGSON2E
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select BOOT_ELF32
 	select BOARD_SCACHE
 	select HW_HAS_PCI
@@ -44,6 +45,7 @@ config LEMOTE_MACH2F
 	select CS5536
 	select CSRC_R4K if ! MIPS_EXTERNAL_TIMER
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select HAVE_CLK
 	select HW_HAS_PCI
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index b87e4258fd78..038bfed34946 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux/MIPS-specific parts of the memory manager.
 #
 
-obj-y				+= cache.o dma-default.o extable.o fault.o \
+obj-y				+= cache.o extable.o fault.o \
 				   gup.o init.o mmap.o page.o page-funcs.o \
 				   pgtable.o tlbex.o tlbex-fault.o tlb-funcs.o
 
@@ -17,6 +17,7 @@ obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
+obj-$(CONFIG_MIPS_DMA_DEFAULT)	+= dma-default.o
 obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
 obj-$(CONFIG_CPU_R4K_CACHE_TLB) += c-r4k.o cex-gen.o tlb-r4k.o
diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
index e284e89183cc..7feb7359b05b 100644
--- a/arch/mips/pic32/Kconfig
+++ b/arch/mips/pic32/Kconfig
@@ -11,6 +11,7 @@ config PIC32MZDA
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index d2509c93f0ee..9dfda3e90348 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -16,6 +16,7 @@ config MACH_TX49XX
 config MACH_TXX9
 	bool
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select SWAP_IO_SPACE
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/vr41xx/Kconfig b/arch/mips/vr41xx/Kconfig
index 992c988b83b0..cc69b2f663fa 100644
--- a/arch/mips/vr41xx/Kconfig
+++ b/arch/mips/vr41xx/Kconfig
@@ -9,6 +9,7 @@ config CASIO_E55
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select ISA
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -19,6 +20,7 @@ config IBM_WORKPAD
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select ISA
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -29,6 +31,7 @@ config TANBAC_TB022X
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -45,6 +48,7 @@ config VICTOR_MPC30X
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select HW_HAS_PCI
 	select PCI_VR41XX
@@ -56,6 +60,7 @@ config ZAO_CAPCELLA
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
+	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select HW_HAS_PCI
 	select PCI_VR41XX
-- 
2.17.0
