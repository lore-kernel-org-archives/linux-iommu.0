From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/4] iommu/arm-smmu: make use of generic LPAE allocator
Date: Thu, 27 Nov 2014 11:51:18 +0000
Message-ID: <1417089078-22900-5-git-send-email-will.deacon@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417089078-22900-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Robin.Murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The ARM SMMU can walk LPAE page tables, so make use of the generic
allocator.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/Kconfig       |   1 -
 drivers/iommu/Kconfig    |   6 +-
 drivers/iommu/arm-smmu.c | 872 ++++++++++++++---------------------------------
 3 files changed, 252 insertions(+), 627 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9532f8d5857e..d2adb09c8f04 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -233,7 +233,6 @@ config ARM64_VA_BITS_42
 
 config ARM64_VA_BITS_48
 	bool "48-bit"
-	depends on !ARM_SMMU
 
 endchoice
 
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dde72d0990b0..7e1bc3262663 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -317,13 +317,13 @@ config SPAPR_TCE_IOMMU
 
 config ARM_SMMU
 	bool "ARM Ltd. System MMU (SMMU) Support"
-	depends on ARM64 || (ARM_LPAE && OF)
+	depends on ARM64 || ARM
 	select IOMMU_API
+	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
 	help
 	  Support for implementations of the ARM System MMU architecture
-	  versions 1 and 2. The driver supports both v7l and v8l table
-	  formats with 4k and 64k page sizes.
+	  versions 1 and 2.
 
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7a80f710ba2d..f9cfac2d8ae9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -23,8 +23,6 @@
  *	- Stream-matching and stream-indexing
  *	- v7/v8 long-descriptor format
  *	- Non-secure access to the SMMU
- *	- 4k and 64k pages, with contiguous pte hints.
- *	- Up to 48-bit addressing (dependent on VA_BITS)
  *	- Context fault reporting
  */
 
@@ -36,7 +34,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pci.h>
@@ -46,7 +43,7 @@
 
 #include <linux/amba/bus.h>
 
-#include <asm/pgalloc.h>
+#include "io-pgtable.h"
 
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
@@ -71,40 +68,6 @@
 		((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS)	\
 			? 0x400 : 0))
 
-/* Page table bits */
-#define ARM_SMMU_PTE_XN			(((pteval_t)3) << 53)
-#define ARM_SMMU_PTE_CONT		(((pteval_t)1) << 52)
-#define ARM_SMMU_PTE_AF			(((pteval_t)1) << 10)
-#define ARM_SMMU_PTE_SH_NS		(((pteval_t)0) << 8)
-#define ARM_SMMU_PTE_SH_OS		(((pteval_t)2) << 8)
-#define ARM_SMMU_PTE_SH_IS		(((pteval_t)3) << 8)
-#define ARM_SMMU_PTE_PAGE		(((pteval_t)3) << 0)
-
-#if PAGE_SIZE == SZ_4K
-#define ARM_SMMU_PTE_CONT_ENTRIES	16
-#elif PAGE_SIZE == SZ_64K
-#define ARM_SMMU_PTE_CONT_ENTRIES	32
-#else
-#define ARM_SMMU_PTE_CONT_ENTRIES	1
-#endif
-
-#define ARM_SMMU_PTE_CONT_SIZE		(PAGE_SIZE * ARM_SMMU_PTE_CONT_ENTRIES)
-#define ARM_SMMU_PTE_CONT_MASK		(~(ARM_SMMU_PTE_CONT_SIZE - 1))
-
-/* Stage-1 PTE */
-#define ARM_SMMU_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
-#define ARM_SMMU_PTE_AP_RDONLY		(((pteval_t)2) << 6)
-#define ARM_SMMU_PTE_ATTRINDX_SHIFT	2
-#define ARM_SMMU_PTE_nG			(((pteval_t)1) << 11)
-
-/* Stage-2 PTE */
-#define ARM_SMMU_PTE_HAP_FAULT		(((pteval_t)0) << 6)
-#define ARM_SMMU_PTE_HAP_READ		(((pteval_t)1) << 6)
-#define ARM_SMMU_PTE_HAP_WRITE		(((pteval_t)2) << 6)
-#define ARM_SMMU_PTE_MEMATTR_OIWB	(((pteval_t)0xf) << 2)
-#define ARM_SMMU_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
-#define ARM_SMMU_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
-
 /* Configuration registers */
 #define ARM_SMMU_GR0_sCR0		0x0
 #define sCR0_CLIENTPD			(1 << 0)
@@ -132,17 +95,11 @@
 #define ARM_SMMU_GR0_sGFSYNR0		0x50
 #define ARM_SMMU_GR0_sGFSYNR1		0x54
 #define ARM_SMMU_GR0_sGFSYNR2		0x58
-#define ARM_SMMU_GR0_PIDR0		0xfe0
-#define ARM_SMMU_GR0_PIDR1		0xfe4
-#define ARM_SMMU_GR0_PIDR2		0xfe8
 
 #define ID0_S1TS			(1 << 30)
 #define ID0_S2TS			(1 << 29)
 #define ID0_NTS				(1 << 28)
 #define ID0_SMS				(1 << 27)
-#define ID0_PTFS_SHIFT			24
-#define ID0_PTFS_MASK			0x2
-#define ID0_PTFS_V8_ONLY		0x2
 #define ID0_CTTW			(1 << 14)
 #define ID0_NUMIRPT_SHIFT		16
 #define ID0_NUMIRPT_MASK		0xff
@@ -169,9 +126,6 @@
 #define ID2_PTFS_16K			(1 << 13)
 #define ID2_PTFS_64K			(1 << 14)
 
-#define PIDR2_ARCH_SHIFT		4
-#define PIDR2_ARCH_MASK			0xf
-
 /* Global TLB invalidation */
 #define ARM_SMMU_GR0_STLBIALL		0x60
 #define ARM_SMMU_GR0_TLBIVMID		0x64
@@ -231,13 +185,18 @@
 #define ARM_SMMU_CB_TTBCR2		0x10
 #define ARM_SMMU_CB_TTBR0_LO		0x20
 #define ARM_SMMU_CB_TTBR0_HI		0x24
+#define ARM_SMMU_CB_TTBR1_LO		0x28
+#define ARM_SMMU_CB_TTBR1_HI		0x2c
 #define ARM_SMMU_CB_TTBCR		0x30
 #define ARM_SMMU_CB_S1_MAIR0		0x38
+#define ARM_SMMU_CB_S1_MAIR1		0x3c
 #define ARM_SMMU_CB_FSR			0x58
 #define ARM_SMMU_CB_FAR_LO		0x60
 #define ARM_SMMU_CB_FAR_HI		0x64
 #define ARM_SMMU_CB_FSYNR0		0x68
+#define ARM_SMMU_CB_S1_TLBIVA		0x600
 #define ARM_SMMU_CB_S1_TLBIASID		0x610
+#define ARM_SMMU_CB_S1_TLBIVAL		0x620
 
 #define SCTLR_S1_ASIDPNE		(1 << 12)
 #define SCTLR_CFCFG			(1 << 7)
@@ -252,44 +211,9 @@
 #define RESUME_RETRY			(0 << 0)
 #define RESUME_TERMINATE		(1 << 0)
 
-#define TTBCR_EAE			(1 << 31)
-
-#define TTBCR_PASIZE_SHIFT		16
-#define TTBCR_PASIZE_MASK		0x7
-
-#define TTBCR_TG0_4K			(0 << 14)
-#define TTBCR_TG0_64K			(1 << 14)
-
-#define TTBCR_SH0_SHIFT			12
-#define TTBCR_SH0_MASK			0x3
-#define TTBCR_SH_NS			0
-#define TTBCR_SH_OS			2
-#define TTBCR_SH_IS			3
-
-#define TTBCR_ORGN0_SHIFT		10
-#define TTBCR_IRGN0_SHIFT		8
-#define TTBCR_RGN_MASK			0x3
-#define TTBCR_RGN_NC			0
-#define TTBCR_RGN_WBWA			1
-#define TTBCR_RGN_WT			2
-#define TTBCR_RGN_WB			3
-
-#define TTBCR_SL0_SHIFT			6
-#define TTBCR_SL0_MASK			0x3
-#define TTBCR_SL0_LVL_2			0
-#define TTBCR_SL0_LVL_1			1
-
-#define TTBCR_T1SZ_SHIFT		16
-#define TTBCR_T0SZ_SHIFT		0
-#define TTBCR_SZ_MASK			0xf
-
 #define TTBCR2_SEP_SHIFT		15
 #define TTBCR2_SEP_MASK			0x7
 
-#define TTBCR2_PASIZE_SHIFT		0
-#define TTBCR2_PASIZE_MASK		0x7
-
-/* Common definitions for PASize and SEP fields */
 #define TTBCR2_ADDR_32			0
 #define TTBCR2_ADDR_36			1
 #define TTBCR2_ADDR_40			2
@@ -297,16 +221,7 @@
 #define TTBCR2_ADDR_44			4
 #define TTBCR2_ADDR_48			5
 
-#define TTBRn_HI_ASID_SHIFT		16
-
-#define MAIR_ATTR_SHIFT(n)		((n) << 3)
-#define MAIR_ATTR_MASK			0xff
-#define MAIR_ATTR_DEVICE		0x04
-#define MAIR_ATTR_NC			0x44
-#define MAIR_ATTR_WBRWA			0xff
-#define MAIR_ATTR_IDX_NC		0
-#define MAIR_ATTR_IDX_CACHE		1
-#define MAIR_ATTR_IDX_DEV		2
+#define TTBRn_HI_ASID_SHIFT            16
 
 #define FSR_MULTI			(1 << 31)
 #define FSR_SS				(1 << 30)
@@ -380,10 +295,9 @@ struct arm_smmu_device {
 	u32				num_mapping_groups;
 	DECLARE_BITMAP(smr_map, ARM_SMMU_MAX_SMRS);
 
-	unsigned long			s1_input_size;
-	unsigned long			s1_output_size;
-	unsigned long			s2_input_size;
-	unsigned long			s2_output_size;
+	unsigned long			va_size;
+	unsigned long			ipa_size;
+	unsigned long			pa_size;
 
 	u32				num_global_irqs;
 	u32				num_context_irqs;
@@ -397,7 +311,6 @@ struct arm_smmu_cfg {
 	u8				cbndx;
 	u8				irptndx;
 	u32				cbar;
-	pgd_t				*pgd;
 };
 #define INVALID_IRPTNDX			0xff
 
@@ -412,11 +325,15 @@ enum arm_smmu_domain_stage {
 
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
+	struct io_pgtable_ops		*pgtbl_ops;
+	spinlock_t			pgtbl_lock;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
-	spinlock_t			lock;
+	struct mutex			init_mutex; /* Protects smmu pointer */
 };
 
+static struct iommu_ops arm_smmu_ops;
+
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
 static LIST_HEAD(arm_smmu_devices);
 
@@ -597,7 +514,7 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 }
 
 /* Wait for any pending TLB invalidations to complete */
-static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
+static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
 	int count = 0;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
@@ -615,12 +532,19 @@ static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 	}
 }
 
-static void arm_smmu_tlb_inv_context(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_tlb_sync(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	__arm_smmu_tlb_sync(smmu_domain->smmu);
+}
+
+static void arm_smmu_tlb_inv_context(void *cookie)
 {
+	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	void __iomem *base = ARM_SMMU_GR0(smmu);
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
+	void __iomem *base;
 
 	if (stage1) {
 		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
@@ -632,9 +556,70 @@ static void arm_smmu_tlb_inv_context(struct arm_smmu_domain *smmu_domain)
 			       base + ARM_SMMU_GR0_TLBIVMID);
 	}
 
-	arm_smmu_tlb_sync(smmu);
+	__arm_smmu_tlb_sync(smmu);
+}
+
+static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
+					  bool leaf, void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
+	void __iomem *reg;
+
+	if (stage1) {
+		reg = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
+
+		if (!IS_ENABLED(CONFIG_64BIT) || smmu->version == ARM_SMMU_V1) {
+			iova &= ~12UL;
+			iova |= ARM_SMMU_CB_ASID(cfg);
+			writel_relaxed(iova, reg);
+#ifdef CONFIG_64BIT
+		} else {
+			iova >>= 12;
+			iova |= (u64)ARM_SMMU_CB_ASID(cfg) << 48;
+			writeq_relaxed(iova, reg);
+#endif
+		}
+	} else {
+		/* Invalidate by IPA is optional */
+		reg = ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_TLBIVMID;
+		writel_relaxed(ARM_SMMU_CB_VMID(cfg), reg);
+	}
 }
 
+static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
+
+
+	/* Ensure new page tables are visible to the hardware walker */
+	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
+		dsb(ishst);
+	} else {
+		/*
+		 * If the SMMU can't walk tables in the CPU caches, treat them
+		 * like non-coherent DMA since we need to flush the new entries
+		 * all the way out to memory. There's no possibility of
+		 * recursion here as the SMMU table walker will not be wired
+		 * through another SMMU.
+		 */
+		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
+			     DMA_TO_DEVICE);
+	}
+}
+
+static struct iommu_gather_ops arm_smmu_gather_ops = {
+	.tlb_flush_all	= arm_smmu_tlb_inv_context,
+	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
+	.tlb_sync	= arm_smmu_tlb_sync,
+	.flush_pgtable	= arm_smmu_flush_pgtable,
+};
+
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
 	int flags, ret;
@@ -712,29 +697,8 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
-				   size_t size)
-{
-	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
-
-
-	/* Ensure new page tables are visible to the hardware walker */
-	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
-		dsb(ishst);
-	} else {
-		/*
-		 * If the SMMU can't walk tables in the CPU caches, treat them
-		 * like non-coherent DMA since we need to flush the new entries
-		 * all the way out to memory. There's no possibility of
-		 * recursion here as the SMMU table walker will not be wired
-		 * through another SMMU.
-		 */
-		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
-				DMA_TO_DEVICE);
-	}
-}
-
-static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
+				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	u32 reg;
 	bool stage1;
@@ -771,124 +735,68 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 #else
 		reg = CBA2R_RW64_32BIT;
 #endif
-		writel_relaxed(reg,
-			       gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
-
-		/* TTBCR2 */
-		switch (smmu->s1_input_size) {
-		case 32:
-			reg = (TTBCR2_ADDR_32 << TTBCR2_SEP_SHIFT);
-			break;
-		case 36:
-			reg = (TTBCR2_ADDR_36 << TTBCR2_SEP_SHIFT);
-			break;
-		case 39:
-		case 40:
-			reg = (TTBCR2_ADDR_40 << TTBCR2_SEP_SHIFT);
-			break;
-		case 42:
-			reg = (TTBCR2_ADDR_42 << TTBCR2_SEP_SHIFT);
-			break;
-		case 44:
-			reg = (TTBCR2_ADDR_44 << TTBCR2_SEP_SHIFT);
-			break;
-		case 48:
-			reg = (TTBCR2_ADDR_48 << TTBCR2_SEP_SHIFT);
-			break;
-		}
-
-		switch (smmu->s1_output_size) {
-		case 32:
-			reg |= (TTBCR2_ADDR_32 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 36:
-			reg |= (TTBCR2_ADDR_36 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 39:
-		case 40:
-			reg |= (TTBCR2_ADDR_40 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 42:
-			reg |= (TTBCR2_ADDR_42 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 44:
-			reg |= (TTBCR2_ADDR_44 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 48:
-			reg |= (TTBCR2_ADDR_48 << TTBCR2_PASIZE_SHIFT);
-			break;
-		}
-
-		if (stage1)
-			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR2);
+		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
 	}
 
-	/* TTBR0 */
-	arm_smmu_flush_pgtable(smmu, cfg->pgd,
-			       PTRS_PER_PGD * sizeof(pgd_t));
-	reg = __pa(cfg->pgd);
-	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
-	reg = (phys_addr_t)__pa(cfg->pgd) >> 32;
-	if (stage1)
+	/* TTBRs */
+	if (stage1) {
+		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
+		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0] >> 32;
 		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
-	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
-
-	/*
-	 * TTBCR
-	 * We use long descriptor, with inner-shareable WBWA tables in TTBR0.
-	 */
-	if (smmu->version > ARM_SMMU_V1) {
-		if (PAGE_SIZE == SZ_4K)
-			reg = TTBCR_TG0_4K;
-		else
-			reg = TTBCR_TG0_64K;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
 
-		if (!stage1) {
-			reg |= (64 - smmu->s2_input_size) << TTBCR_T0SZ_SHIFT;
+		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
+		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1] >> 32;
+		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_HI);
+	} else {
+		reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
+		reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr >> 32;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
+	}
 
-			switch (smmu->s2_output_size) {
+	/* TTBCR */
+	if (stage1) {
+		reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
+		if (smmu->version > ARM_SMMU_V1) {
+			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
+			switch (smmu->va_size) {
 			case 32:
-				reg |= (TTBCR2_ADDR_32 << TTBCR_PASIZE_SHIFT);
+				reg |= (TTBCR2_ADDR_32 << TTBCR2_SEP_SHIFT);
 				break;
 			case 36:
-				reg |= (TTBCR2_ADDR_36 << TTBCR_PASIZE_SHIFT);
+				reg |= (TTBCR2_ADDR_36 << TTBCR2_SEP_SHIFT);
 				break;
 			case 40:
-				reg |= (TTBCR2_ADDR_40 << TTBCR_PASIZE_SHIFT);
+				reg |= (TTBCR2_ADDR_40 << TTBCR2_SEP_SHIFT);
 				break;
 			case 42:
-				reg |= (TTBCR2_ADDR_42 << TTBCR_PASIZE_SHIFT);
+				reg |= (TTBCR2_ADDR_42 << TTBCR2_SEP_SHIFT);
 				break;
 			case 44:
-				reg |= (TTBCR2_ADDR_44 << TTBCR_PASIZE_SHIFT);
+				reg |= (TTBCR2_ADDR_44 << TTBCR2_SEP_SHIFT);
 				break;
 			case 48:
-				reg |= (TTBCR2_ADDR_48 << TTBCR_PASIZE_SHIFT);
+				reg |= (TTBCR2_ADDR_48 << TTBCR2_SEP_SHIFT);
 				break;
 			}
-		} else {
-			reg |= (64 - smmu->s1_input_size) << TTBCR_T0SZ_SHIFT;
+			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR2);
 		}
 	} else {
-		reg = 0;
+		reg = pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
 	}
 
-	reg |= TTBCR_EAE |
-	      (TTBCR_SH_IS << TTBCR_SH0_SHIFT) |
-	      (TTBCR_RGN_WBWA << TTBCR_ORGN0_SHIFT) |
-	      (TTBCR_RGN_WBWA << TTBCR_IRGN0_SHIFT);
-
-	if (!stage1)
-		reg |= (TTBCR_SL0_LVL_1 << TTBCR_SL0_SHIFT);
-
-	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
-
-	/* MAIR0 (stage-1 only) */
+	/* MAIRs (stage-1 only) */
 	if (stage1) {
-		reg = (MAIR_ATTR_NC << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_NC)) |
-		      (MAIR_ATTR_WBRWA << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_CACHE)) |
-		      (MAIR_ATTR_DEVICE << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_DEV));
+		reg = pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
 		writel_relaxed(reg, cb_base + ARM_SMMU_CB_S1_MAIR0);
+		reg = pgtbl_cfg->arm_lpae_s1_cfg.mair[1];
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_S1_MAIR1);
 	}
 
 	/* SCTLR */
@@ -905,11 +813,14 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 					struct arm_smmu_device *smmu)
 {
 	int irq, start, ret = 0;
-	unsigned long flags;
+	unsigned long ias, oas;
+	struct io_pgtable_ops *pgtbl_ops;
+	struct io_pgtable_cfg pgtbl_cfg;
+	enum io_pgtable_fmt fmt;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 
-	spin_lock_irqsave(&smmu_domain->lock, flags);
+	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
@@ -940,6 +851,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	case ARM_SMMU_DOMAIN_S1:
 		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
 		start = smmu->num_s2_context_banks;
+		ias = smmu->va_size;
+		oas = smmu->ipa_size;
+		fmt = ARM_LPAE_S1;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 		/*
@@ -949,6 +863,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	case ARM_SMMU_DOMAIN_S2:
 		cfg->cbar = CBAR_TYPE_S2_TRANS;
 		start = 0;
+		ias = smmu->ipa_size;
+		oas = smmu->pa_size;
+		fmt = ARM_LPAE_S2;
 		break;
 	default:
 		ret = -EINVAL;
@@ -968,10 +885,30 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		cfg->irptndx = cfg->cbndx;
 	}
 
-	ACCESS_ONCE(smmu_domain->smmu) = smmu;
-	arm_smmu_init_context_bank(smmu_domain);
-	spin_unlock_irqrestore(&smmu_domain->lock, flags);
+	pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap	= arm_smmu_ops.pgsize_bitmap,
+		.ias		= ias,
+		.oas		= oas,
+		.tlb		= &arm_smmu_gather_ops,
+	};
 
+	smmu_domain->smmu = smmu;
+	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
+	if (!pgtbl_ops) {
+		ret = -ENOMEM;
+		goto out_clear_smmu;
+	}
+
+	/* Update our support page sizes to reflect the page table format */
+	arm_smmu_ops.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+
+	/* Initialise the context bank with our page table cfg */
+	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
+
+	/*
+	 * Request context fault interrupt. Do this last to avoid the
+	 * handler seeing a half-initialised domain state.
+	 */
 	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
 	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
 			  "arm-smmu-context-fault", domain);
@@ -981,10 +918,16 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		cfg->irptndx = INVALID_IRPTNDX;
 	}
 
+	mutex_unlock(&smmu_domain->init_mutex);
+
+	/* Publish page table ops for map/unmap */
+	smmu_domain->pgtbl_ops = pgtbl_ops;
 	return 0;
 
+out_clear_smmu:
+	smmu_domain->smmu = NULL;
 out_unlock:
-	spin_unlock_irqrestore(&smmu_domain->lock, flags);
+	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
 }
 
@@ -999,23 +942,27 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	if (!smmu)
 		return;
 
-	/* Disable the context bank and nuke the TLB before freeing it. */
+	/*
+	 * Disable the context bank and free the page tables before freeing
+	 * it.
+	 */
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
-	arm_smmu_tlb_inv_context(smmu_domain);
 
 	if (cfg->irptndx != INVALID_IRPTNDX) {
 		irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
 		free_irq(irq, domain);
 	}
 
+	if (smmu_domain->pgtbl_ops)
+		free_io_pgtable_ops(smmu_domain->pgtbl_ops);
+
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 }
 
 static int arm_smmu_domain_init(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain;
-	pgd_t *pgd;
 
 	/*
 	 * Allocate the domain and initialise some of its data structures.
@@ -1026,81 +973,10 @@ static int arm_smmu_domain_init(struct iommu_domain *domain)
 	if (!smmu_domain)
 		return -ENOMEM;
 
-	pgd = kcalloc(PTRS_PER_PGD, sizeof(pgd_t), GFP_KERNEL);
-	if (!pgd)
-		goto out_free_domain;
-	smmu_domain->cfg.pgd = pgd;
-
-	spin_lock_init(&smmu_domain->lock);
+	mutex_init(&smmu_domain->init_mutex);
+	spin_lock_init(&smmu_domain->pgtbl_lock);
 	domain->priv = smmu_domain;
 	return 0;
-
-out_free_domain:
-	kfree(smmu_domain);
-	return -ENOMEM;
-}
-
-static void arm_smmu_free_ptes(pmd_t *pmd)
-{
-	pgtable_t table = pmd_pgtable(*pmd);
-
-	__free_page(table);
-}
-
-static void arm_smmu_free_pmds(pud_t *pud)
-{
-	int i;
-	pmd_t *pmd, *pmd_base = pmd_offset(pud, 0);
-
-	pmd = pmd_base;
-	for (i = 0; i < PTRS_PER_PMD; ++i) {
-		if (pmd_none(*pmd))
-			continue;
-
-		arm_smmu_free_ptes(pmd);
-		pmd++;
-	}
-
-	pmd_free(NULL, pmd_base);
-}
-
-static void arm_smmu_free_puds(pgd_t *pgd)
-{
-	int i;
-	pud_t *pud, *pud_base = pud_offset(pgd, 0);
-
-	pud = pud_base;
-	for (i = 0; i < PTRS_PER_PUD; ++i) {
-		if (pud_none(*pud))
-			continue;
-
-		arm_smmu_free_pmds(pud);
-		pud++;
-	}
-
-	pud_free(NULL, pud_base);
-}
-
-static void arm_smmu_free_pgtables(struct arm_smmu_domain *smmu_domain)
-{
-	int i;
-	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	pgd_t *pgd, *pgd_base = cfg->pgd;
-
-	/*
-	 * Recursively free the page tables for this domain. We don't
-	 * care about speculative TLB filling because the tables should
-	 * not be active in any context bank at this point (SCTLR.M is 0).
-	 */
-	pgd = pgd_base;
-	for (i = 0; i < PTRS_PER_PGD; ++i) {
-		if (pgd_none(*pgd))
-			continue;
-		arm_smmu_free_puds(pgd);
-		pgd++;
-	}
-
-	kfree(pgd_base);
 }
 
 static void arm_smmu_domain_destroy(struct iommu_domain *domain)
@@ -1112,7 +988,6 @@ static void arm_smmu_domain_destroy(struct iommu_domain *domain)
 	 * already been detached.
 	 */
 	arm_smmu_destroy_domain_context(domain);
-	arm_smmu_free_pgtables(smmu_domain);
 	kfree(smmu_domain);
 }
 
@@ -1244,7 +1119,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_device *smmu, *dom_smmu;
+	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_cfg *cfg;
 
 	smmu = find_smmu_for_device(dev);
@@ -1258,21 +1133,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -EEXIST;
 	}
 
+	/* Ensure that the domain is finalised */
+	ret = arm_smmu_init_domain_context(domain, smmu);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
 	/*
 	 * Sanity check the domain. We don't support domains across
 	 * different SMMUs.
 	 */
-	dom_smmu = ACCESS_ONCE(smmu_domain->smmu);
-	if (!dom_smmu) {
-		/* Now that we have a master, we can finalise the domain */
-		ret = arm_smmu_init_domain_context(domain, smmu);
-		if (IS_ERR_VALUE(ret))
-			return ret;
-
-		dom_smmu = smmu_domain->smmu;
-	}
-
-	if (dom_smmu != smmu) {
+	if (smmu_domain->smmu != smmu) {
 		dev_err(dev,
 			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
 			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
@@ -1303,293 +1173,55 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 	arm_smmu_domain_remove_master(smmu_domain, cfg);
 }
 
-static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
-					     unsigned long end)
-{
-	return !(addr & ~ARM_SMMU_PTE_CONT_MASK) &&
-		(addr + ARM_SMMU_PTE_CONT_SIZE <= end);
-}
-
-static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
-				   unsigned long addr, unsigned long end,
-				   unsigned long pfn, int prot, int stage)
-{
-	pte_t *pte, *start;
-	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF;
-
-	if (pmd_none(*pmd)) {
-		/* Allocate a new set of tables */
-		pgtable_t table = alloc_page(GFP_ATOMIC|__GFP_ZERO);
-
-		if (!table)
-			return -ENOMEM;
-
-		arm_smmu_flush_pgtable(smmu, page_address(table), PAGE_SIZE);
-		pmd_populate(NULL, pmd, table);
-		arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
-	}
-
-	if (stage == 1) {
-		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
-		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
-			pteval |= ARM_SMMU_PTE_AP_RDONLY;
-
-		if (prot & IOMMU_CACHE)
-			pteval |= (MAIR_ATTR_IDX_CACHE <<
-				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
-	} else {
-		pteval |= ARM_SMMU_PTE_HAP_FAULT;
-		if (prot & IOMMU_READ)
-			pteval |= ARM_SMMU_PTE_HAP_READ;
-		if (prot & IOMMU_WRITE)
-			pteval |= ARM_SMMU_PTE_HAP_WRITE;
-		if (prot & IOMMU_CACHE)
-			pteval |= ARM_SMMU_PTE_MEMATTR_OIWB;
-		else
-			pteval |= ARM_SMMU_PTE_MEMATTR_NC;
-	}
-
-	if (prot & IOMMU_NOEXEC)
-		pteval |= ARM_SMMU_PTE_XN;
-
-	/* If no access, create a faulting entry to avoid TLB fills */
-	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
-		pteval &= ~ARM_SMMU_PTE_PAGE;
-
-	pteval |= ARM_SMMU_PTE_SH_IS;
-	start = pmd_page_vaddr(*pmd) + pte_index(addr);
-	pte = start;
-
-	/*
-	 * Install the page table entries. This is fairly complicated
-	 * since we attempt to make use of the contiguous hint in the
-	 * ptes where possible. The contiguous hint indicates a series
-	 * of ARM_SMMU_PTE_CONT_ENTRIES ptes mapping a physically
-	 * contiguous region with the following constraints:
-	 *
-	 *   - The region start is aligned to ARM_SMMU_PTE_CONT_SIZE
-	 *   - Each pte in the region has the contiguous hint bit set
-	 *
-	 * This complicates unmapping (also handled by this code, when
-	 * neither IOMMU_READ or IOMMU_WRITE are set) because it is
-	 * possible, yet highly unlikely, that a client may unmap only
-	 * part of a contiguous range. This requires clearing of the
-	 * contiguous hint bits in the range before installing the new
-	 * faulting entries.
-	 *
-	 * Note that re-mapping an address range without first unmapping
-	 * it is not supported, so TLB invalidation is not required here
-	 * and is instead performed at unmap and domain-init time.
-	 */
-	do {
-		int i = 1;
-
-		pteval &= ~ARM_SMMU_PTE_CONT;
-
-		if (arm_smmu_pte_is_contiguous_range(addr, end)) {
-			i = ARM_SMMU_PTE_CONT_ENTRIES;
-			pteval |= ARM_SMMU_PTE_CONT;
-		} else if (pte_val(*pte) &
-			   (ARM_SMMU_PTE_CONT | ARM_SMMU_PTE_PAGE)) {
-			int j;
-			pte_t *cont_start;
-			unsigned long idx = pte_index(addr);
-
-			idx &= ~(ARM_SMMU_PTE_CONT_ENTRIES - 1);
-			cont_start = pmd_page_vaddr(*pmd) + idx;
-			for (j = 0; j < ARM_SMMU_PTE_CONT_ENTRIES; ++j)
-				pte_val(*(cont_start + j)) &=
-					~ARM_SMMU_PTE_CONT;
-
-			arm_smmu_flush_pgtable(smmu, cont_start,
-					       sizeof(*pte) *
-					       ARM_SMMU_PTE_CONT_ENTRIES);
-		}
-
-		do {
-			*pte = pfn_pte(pfn, __pgprot(pteval));
-		} while (pte++, pfn++, addr += PAGE_SIZE, --i);
-	} while (addr != end);
-
-	arm_smmu_flush_pgtable(smmu, start, sizeof(*pte) * (pte - start));
-	return 0;
-}
-
-static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
-				   unsigned long addr, unsigned long end,
-				   phys_addr_t phys, int prot, int stage)
-{
-	int ret;
-	pmd_t *pmd;
-	unsigned long next, pfn = __phys_to_pfn(phys);
-
-#ifndef __PAGETABLE_PMD_FOLDED
-	if (pud_none(*pud)) {
-		pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
-		if (!pmd)
-			return -ENOMEM;
-
-		arm_smmu_flush_pgtable(smmu, pmd, PAGE_SIZE);
-		pud_populate(NULL, pud, pmd);
-		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
-
-		pmd += pmd_index(addr);
-	} else
-#endif
-		pmd = pmd_offset(pud, addr);
-
-	do {
-		next = pmd_addr_end(addr, end);
-		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, next, pfn,
-					      prot, stage);
-		phys += next - addr;
-		pfn = __phys_to_pfn(phys);
-	} while (pmd++, addr = next, addr < end);
-
-	return ret;
-}
-
-static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
-				   unsigned long addr, unsigned long end,
-				   phys_addr_t phys, int prot, int stage)
-{
-	int ret = 0;
-	pud_t *pud;
-	unsigned long next;
-
-#ifndef __PAGETABLE_PUD_FOLDED
-	if (pgd_none(*pgd)) {
-		pud = (pud_t *)get_zeroed_page(GFP_ATOMIC);
-		if (!pud)
-			return -ENOMEM;
-
-		arm_smmu_flush_pgtable(smmu, pud, PAGE_SIZE);
-		pgd_populate(NULL, pgd, pud);
-		arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
-
-		pud += pud_index(addr);
-	} else
-#endif
-		pud = pud_offset(pgd, addr);
-
-	do {
-		next = pud_addr_end(addr, end);
-		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
-					      prot, stage);
-		phys += next - addr;
-	} while (pud++, addr = next, addr < end);
-
-	return ret;
-}
-
-static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
-				   unsigned long iova, phys_addr_t paddr,
-				   size_t size, int prot)
-{
-	int ret, stage;
-	unsigned long end;
-	phys_addr_t input_mask, output_mask;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	pgd_t *pgd = cfg->pgd;
-	unsigned long flags;
-
-	if (cfg->cbar == CBAR_TYPE_S2_TRANS) {
-		stage = 2;
-		input_mask = (1ULL << smmu->s2_input_size) - 1;
-		output_mask = (1ULL << smmu->s2_output_size) - 1;
-	} else {
-		stage = 1;
-		input_mask = (1ULL << smmu->s1_input_size) - 1;
-		output_mask = (1ULL << smmu->s1_output_size) - 1;
-	}
-
-	if (!pgd)
-		return -EINVAL;
-
-	if (size & ~PAGE_MASK)
-		return -EINVAL;
-
-	if ((phys_addr_t)iova & ~input_mask)
-		return -ERANGE;
-
-	if (paddr & ~output_mask)
-		return -ERANGE;
-
-	spin_lock_irqsave(&smmu_domain->lock, flags);
-	pgd += pgd_index(iova);
-	end = iova + size;
-	do {
-		unsigned long next = pgd_addr_end(iova, end);
-
-		ret = arm_smmu_alloc_init_pud(smmu, pgd, iova, next, paddr,
-					      prot, stage);
-		if (ret)
-			goto out_unlock;
-
-		paddr += next - iova;
-		iova = next;
-	} while (pgd++, iova != end);
-
-out_unlock:
-	spin_unlock_irqrestore(&smmu_domain->lock, flags);
-
-	return ret;
-}
-
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
+	int ret;
+	unsigned long flags;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
 
-	if (!smmu_domain)
+	if (!ops)
 		return -ENODEV;
 
-	return arm_smmu_handle_mapping(smmu_domain, iova, paddr, size, prot);
+	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
+	ret = ops->map(ops, iova, paddr, size, prot);
+	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
+	return ret;
 }
 
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			     size_t size)
 {
-	int ret;
+	size_t ret;
+	unsigned long flags;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
+
+	if (!ops)
+		return 0;
 
-	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
-	arm_smmu_tlb_inv_context(smmu_domain);
-	return ret ? 0 : size;
+	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
+	ret = ops->unmap(ops, iova, size);
+	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
+	return ret;
 }
 
 static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 					 dma_addr_t iova)
 {
-	pgd_t *pgdp, pgd;
-	pud_t pud;
-	pmd_t pmd;
-	pte_t pte;
+	phys_addr_t ret;
+	unsigned long flags;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
 
-	pgdp = cfg->pgd;
-	if (!pgdp)
+	if (!ops)
 		return 0;
 
-	pgd = *(pgdp + pgd_index(iova));
-	if (pgd_none(pgd))
-		return 0;
-
-	pud = *pud_offset(&pgd, iova);
-	if (pud_none(pud))
-		return 0;
-
-	pmd = *pmd_offset(&pud, iova);
-	if (pmd_none(pmd))
-		return 0;
-
-	pte = *(pmd_page_vaddr(pmd) + pte_index(iova));
-	if (pte_none(pte))
-		return 0;
-
-	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
+	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
+	ret = ops->iova_to_phys(ops, iova);
+	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
+	return ret;
 }
 
 static bool arm_smmu_capable(enum iommu_cap cap)
@@ -1698,24 +1330,34 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr, void *data)
 {
+	int ret = 0;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 
+	mutex_lock(&smmu_domain->init_mutex);
+
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
-		if (smmu_domain->smmu)
-			return -EPERM;
+		if (smmu_domain->smmu) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
 		if (*(int *)data)
 			smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
 		else
 			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
-		return 0;
+		break;
 	default:
-		return -ENODEV;
+		ret = -ENODEV;
 	}
+
+out_unlock:
+	mutex_unlock(&smmu_domain->init_mutex);
+	return ret;
 }
 
-static const struct iommu_ops arm_smmu_ops = {
+static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_init		= arm_smmu_domain_init,
 	.domain_destroy		= arm_smmu_domain_destroy,
@@ -1728,9 +1370,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.remove_device		= arm_smmu_remove_device,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
-	.pgsize_bitmap		= (SECTION_SIZE |
-				   ARM_SMMU_PTE_CONT_SIZE |
-				   PAGE_SIZE),
+	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
@@ -1781,7 +1421,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	reg &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);
 
 	/* Push the button */
-	arm_smmu_tlb_sync(smmu);
+	__arm_smmu_tlb_sync(smmu);
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 }
 
@@ -1815,12 +1455,6 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/* ID0 */
 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID0);
-#ifndef CONFIG_64BIT
-	if (((id >> ID0_PTFS_SHIFT) & ID0_PTFS_MASK) == ID0_PTFS_V8_ONLY) {
-		dev_err(smmu->dev, "\tno v7 descriptor support!\n");
-		return -ENODEV;
-	}
-#endif
 
 	/* Restrict available stages based on module parameter */
 	if (force_stage == 1)
@@ -1893,16 +1527,14 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	smmu->pgshift = (id & ID1_PAGESIZE) ? 16 : 12;
 
 	/* Check for size mismatch of SMMU address space from mapped region */
-	size = 1 <<
-		(((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
+	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
 	size *= 2 << smmu->pgshift;
 	if (smmu->size != size)
 		dev_warn(smmu->dev,
 			"SMMU address space size (0x%lx) differs from mapped region size (0x%lx)!\n",
 			size, smmu->size);
 
-	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) &
-				      ID1_NUMS2CB_MASK;
+	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) & ID1_NUMS2CB_MASK;
 	smmu->num_context_banks = (id >> ID1_NUMCB_SHIFT) & ID1_NUMCB_MASK;
 	if (smmu->num_s2_context_banks > smmu->num_context_banks) {
 		dev_err(smmu->dev, "impossible number of S2 context banks!\n");
@@ -1914,46 +1546,40 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	/* ID2 */
 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID2);
 	size = arm_smmu_id_size_to_bits((id >> ID2_IAS_SHIFT) & ID2_IAS_MASK);
-	smmu->s1_output_size = min_t(unsigned long, PHYS_MASK_SHIFT, size);
+	smmu->ipa_size = size;
 
-	/* Stage-2 input size limited due to pgd allocation (PTRS_PER_PGD) */
-#ifdef CONFIG_64BIT
-	smmu->s2_input_size = min_t(unsigned long, VA_BITS, size);
-#else
-	smmu->s2_input_size = min(32UL, size);
-#endif
-
-	/* The stage-2 output mask is also applied for bypass */
+	/* The output mask is also applied for bypass */
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
-	smmu->s2_output_size = min_t(unsigned long, PHYS_MASK_SHIFT, size);
+	smmu->pa_size = size;
 
 	if (smmu->version == ARM_SMMU_V1) {
-		smmu->s1_input_size = 32;
+		smmu->va_size = smmu->ipa_size;
+		size = SZ_4K | SZ_2M | SZ_1G;
 	} else {
-#ifdef CONFIG_64BIT
 		size = (id >> ID2_UBS_SHIFT) & ID2_UBS_MASK;
-		size = min(VA_BITS, arm_smmu_id_size_to_bits(size));
-#else
-		size = 32;
+		smmu->va_size = arm_smmu_id_size_to_bits(size);
+#ifndef CONFIG_64BIT
+		smmu->va_size = min(32UL, smmu->va_size);
 #endif
-		smmu->s1_input_size = size;
-
-		if ((PAGE_SIZE == SZ_4K && !(id & ID2_PTFS_4K)) ||
-		    (PAGE_SIZE == SZ_64K && !(id & ID2_PTFS_64K)) ||
-		    (PAGE_SIZE != SZ_4K && PAGE_SIZE != SZ_64K)) {
-			dev_err(smmu->dev, "CPU page size 0x%lx unsupported\n",
-				PAGE_SIZE);
-			return -ENODEV;
-		}
+		size = 0;
+		if (id & ID2_PTFS_4K)
+			size |= SZ_4K | SZ_2M | SZ_1G;
+		if (id & ID2_PTFS_16K)
+			size |= SZ_16K | SZ_32M;
+		if (id & ID2_PTFS_64K)
+			size |= SZ_64K | SZ_512M;
 	}
 
+	arm_smmu_ops.pgsize_bitmap &= size;
+	dev_notice(smmu->dev, "\tSupported page sizes: 0x%08lx\n", size);
+
 	if (smmu->features & ARM_SMMU_FEAT_TRANS_S1)
 		dev_notice(smmu->dev, "\tStage-1: %lu-bit VA -> %lu-bit IPA\n",
-			   smmu->s1_input_size, smmu->s1_output_size);
+			   smmu->va_size, smmu->ipa_size);
 
 	if (smmu->features & ARM_SMMU_FEAT_TRANS_S2)
 		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
-			   smmu->s2_input_size, smmu->s2_output_size);
+			   smmu->ipa_size, smmu->pa_size);
 
 	return 0;
 }
-- 
2.1.1
