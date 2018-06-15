From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 14/25] MIPS: use dma_direct_ops for coherent I/O
Date: Fri, 15 Jun 2018 13:08:43 +0200
Message-ID: <20180615110854.19253-15-hch@lst.de>
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

Switch the simple cache coherent architectures that don't require any
DMA address translation to dma_direct_ops.

We'll soon use at least parts of the direct DMA ops implementation for
all platforms, so select the symbol globally.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/Kconfig                   | 15 +--------------
 arch/mips/include/asm/dma-mapping.h |  2 +-
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index aae92a7b6a9c..6247bb7f8244 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -16,6 +16,7 @@ config MIPS
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select CPU_PM if CPU_IDLE
+	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
@@ -568,7 +569,6 @@ config NEC_MARKEINS
 	bool "NEC EMMA2RH Mark-eins board"
 	select SOC_EMMA2RH
 	select HW_HAS_PCI
-	select MIPS_DMA_DEFAULT
 	help
 	  This enables support for the NEC Electronics Mark-eins boards.
 
@@ -582,14 +582,12 @@ config MACH_VR41XX
 
 config NXP_STB220
 	bool "NXP STB220 board"
-	select MIPS_DMA_DEFAULT
 	select SOC_PNX833X
 	help
 	 Support for NXP Semiconductors STB220 Development Board.
 
 config NXP_STB225
 	bool "NXP 225 board"
-	select MIPS_DMA_DEFAULT
 	select SOC_PNX833X
 	select SOC_PNX8335
 	help
@@ -767,7 +765,6 @@ config SGI_IP32
 config SIBYTE_CRHINE
 	bool "Sibyte BCM91120C-CRhine"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -777,7 +774,6 @@ config SIBYTE_CRHINE
 config SIBYTE_CARMEL
 	bool "Sibyte BCM91120x-Carmel"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -787,7 +783,6 @@ config SIBYTE_CARMEL
 config SIBYTE_CRHONE
 	bool "Sibyte BCM91125C-CRhone"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1125
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -798,7 +793,6 @@ config SIBYTE_CRHONE
 config SIBYTE_RHONE
 	bool "Sibyte BCM91125E-Rhone"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_BCM1125H
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -809,7 +803,6 @@ config SIBYTE_SWARM
 	bool "Sibyte BCM91250A-SWARM"
 	select BOOT_ELF32
 	select HAVE_PATA_PLATFORM
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -822,7 +815,6 @@ config SIBYTE_LITTLESUR
 	bool "Sibyte BCM91250C2-LittleSur"
 	select BOOT_ELF32
 	select HAVE_PATA_PLATFORM
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -833,7 +825,6 @@ config SIBYTE_LITTLESUR
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -843,7 +834,6 @@ config SIBYTE_SENTOSA
 config SIBYTE_BIGSUR
 	bool "Sibyte BCM91480B-BigSur"
 	select BOOT_ELF32
-	select MIPS_DMA_DEFAULT
 	select NR_CPUS_DEFAULT_4
 	select SIBYTE_BCM1x80
 	select SWAP_IO_SPACE
@@ -964,7 +954,6 @@ config NLM_XLR_BOARD
 	select SYS_HAS_CPU_XLR
 	select SYS_SUPPORTS_SMP
 	select HW_HAS_PCI
-	select MIPS_DMA_DEFAULT
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
@@ -991,7 +980,6 @@ config NLM_XLP_BOARD
 	select SYS_HAS_CPU_XLP
 	select SYS_SUPPORTS_SMP
 	select HW_HAS_PCI
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select PHYS_ADDR_T_64BIT
@@ -1017,7 +1005,6 @@ config MIPS_PARAVIRT
 	bool "Para-Virtualized guest system"
 	select CEVT_R4K
 	select CSRC_R4K
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index eaf3d9054104..7c0d4f0ccaa0 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -20,7 +20,7 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 #elif defined(CONFIG_MIPS_DMA_DEFAULT)
 	return &mips_default_dma_map_ops;
 #else
-	return NULL;
+	return &dma_direct_ops;
 #endif
 }
 
-- 
2.17.1
