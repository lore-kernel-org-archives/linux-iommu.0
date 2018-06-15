From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 03/25] MIPS: remove CONFIG_DMA_COHERENT
Date: Fri, 15 Jun 2018 13:08:32 +0200
Message-ID: <20180615110854.19253-4-hch@lst.de>
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

We can just check for !CONFIG_DMA_NONCOHERENT instead and simplify things
a lot.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Reviewed-by: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
---
 arch/mips/Kconfig                            | 16 ----------------
 arch/mips/include/asm/dma-coherence.h        |  6 +++---
 arch/mips/include/asm/mach-generic/kmalloc.h |  3 +--
 arch/mips/mti-malta/malta-setup.c            |  4 ++--
 arch/mips/sibyte/Kconfig                     |  1 -
 5 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3f9deec70b92..89be9f97da4e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -665,7 +665,6 @@ config SGI_IP27
 	select FW_ARC64
 	select BOOT_ELF64
 	select DEFAULT_SGI_PARTITION
-	select DMA_COHERENT
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
 	select NR_CPUS_DEFAULT_64
@@ -742,7 +741,6 @@ config SGI_IP32
 config SIBYTE_CRHINE
 	bool "Sibyte BCM91120C-CRhine"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -752,7 +750,6 @@ config SIBYTE_CRHINE
 config SIBYTE_CARMEL
 	bool "Sibyte BCM91120x-Carmel"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -762,7 +759,6 @@ config SIBYTE_CARMEL
 config SIBYTE_CRHONE
 	bool "Sibyte BCM91125C-CRhone"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_BCM1125
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -773,7 +769,6 @@ config SIBYTE_CRHONE
 config SIBYTE_RHONE
 	bool "Sibyte BCM91125E-Rhone"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_BCM1125H
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -783,7 +778,6 @@ config SIBYTE_RHONE
 config SIBYTE_SWARM
 	bool "Sibyte BCM91250A-SWARM"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select HAVE_PATA_PLATFORM
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
@@ -796,7 +790,6 @@ config SIBYTE_SWARM
 config SIBYTE_LITTLESUR
 	bool "Sibyte BCM91250C2-LittleSur"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select HAVE_PATA_PLATFORM
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
@@ -808,7 +801,6 @@ config SIBYTE_LITTLESUR
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -818,7 +810,6 @@ config SIBYTE_SENTOSA
 config SIBYTE_BIGSUR
 	bool "Sibyte BCM91480B-BigSur"
 	select BOOT_ELF32
-	select DMA_COHERENT
 	select NR_CPUS_DEFAULT_4
 	select SIBYTE_BCM1x80
 	select SWAP_IO_SPACE
@@ -895,7 +886,6 @@ config CAVIUM_OCTEON_SOC
 	select CEVT_R4K
 	select ARCH_HAS_PHYS_TO_DMA
 	select PHYS_ADDR_T_64BIT
-	select DMA_COHERENT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select EDAC_SUPPORT
@@ -944,7 +934,6 @@ config NLM_XLR_BOARD
 	select PHYS_ADDR_T_64BIT
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
-	select DMA_COHERENT
 	select NR_CPUS_DEFAULT_32
 	select CEVT_R4K
 	select CSRC_R4K
@@ -972,7 +961,6 @@ config NLM_XLP_BOARD
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
-	select DMA_COHERENT
 	select NR_CPUS_DEFAULT_32
 	select CEVT_R4K
 	select CSRC_R4K
@@ -991,7 +979,6 @@ config MIPS_PARAVIRT
 	bool "Para-Virtualized guest system"
 	select CEVT_R4K
 	select CSRC_R4K
-	select DMA_COHERENT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -1117,9 +1104,6 @@ config DMA_PERDEV_COHERENT
 	bool
 	select DMA_MAYBE_COHERENT
 
-config DMA_COHERENT
-	bool
-
 config DMA_NONCOHERENT
 	bool
 	select NEED_DMA_MAP_STATE
diff --git a/arch/mips/include/asm/dma-coherence.h b/arch/mips/include/asm/dma-coherence.h
index 72d0eab02afc..8eda48748ed5 100644
--- a/arch/mips/include/asm/dma-coherence.h
+++ b/arch/mips/include/asm/dma-coherence.h
@@ -21,10 +21,10 @@ enum coherent_io_user_state {
 extern enum coherent_io_user_state coherentio;
 extern int hw_coherentio;
 #else
-#ifdef CONFIG_DMA_COHERENT
-#define coherentio	IO_COHERENCE_ENABLED
-#else
+#ifdef CONFIG_DMA_NONCOHERENT
 #define coherentio	IO_COHERENCE_DISABLED
+#else
+#define coherentio	IO_COHERENCE_ENABLED
 #endif
 #define hw_coherentio	0
 #endif /* CONFIG_DMA_MAYBE_COHERENT */
diff --git a/arch/mips/include/asm/mach-generic/kmalloc.h b/arch/mips/include/asm/mach-generic/kmalloc.h
index 74207c7bd00d..649a98338886 100644
--- a/arch/mips/include/asm/mach-generic/kmalloc.h
+++ b/arch/mips/include/asm/mach-generic/kmalloc.h
@@ -2,8 +2,7 @@
 #ifndef __ASM_MACH_GENERIC_KMALLOC_H
 #define __ASM_MACH_GENERIC_KMALLOC_H
 
-
-#ifndef CONFIG_DMA_COHERENT
+#ifdef CONFIG_DMA_NONCOHERENT
 /*
  * Total overkill for most systems but need as a safe default.
  * Set this one if any device in the system might do non-coherent DMA.
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 7b63914d2e58..4d5cdfeee3db 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -227,7 +227,7 @@ static void __init bonito_quirks_setup(void)
 	} else
 		BONITO_BONGENCFG &= ~BONITO_BONGENCFG_DEBUGMODE;
 
-#ifdef CONFIG_DMA_COHERENT
+#ifndef CONFIG_DMA_NONCOHERENT
 	if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
 		BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
 		pr_info("Enabled Bonito CPU coherency\n");
@@ -279,7 +279,7 @@ void __init plat_mem_setup(void)
 	 */
 	enable_dma(4);
 
-#ifdef CONFIG_DMA_COHERENT
+#ifndef CONFIG_DMA_NONCOHERENT
 	if (mips_revision_sconid != MIPS_REVISION_SCON_BONITO)
 		panic("Hardware DMA cache coherency not supported");
 #endif
diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index f4dbce25bc6a..7ec278d72096 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -70,7 +70,6 @@ config SIBYTE_BCM1x55
 
 config SIBYTE_SB1xxx_SOC
 	bool
-	select DMA_COHERENT
 	select IRQ_MIPS_CPU
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_32BIT_KERNEL
-- 
2.17.1
