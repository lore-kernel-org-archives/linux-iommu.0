From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 11/13] iommu: exynos: add support for v5 SYSMMU
Date: Thu, 18 Feb 2016 15:12:58 +0100
Message-ID: <1455804780-9616-12-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds support for v5 of SYSMMU controller, found in Samsung
Exynos 5433 SoCs. The main difference of v5 is support for 36-bit physical
address space and some changes in register layout and core clocks hanging.
This patch also adds support for ARM64 architecture, which is used by
Exynos 5433 SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |   5 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/exynos-iommu.c                       | 187 +++++++++++++++------
 3 files changed, 143 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
index f61ca25ca136..85f068805dd8 100644
--- a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
@@ -35,9 +35,10 @@ Required properties:
 - interrupts: An interrupt specifier for interrupt signal of System MMU,
 	      according to the format defined by a particular interrupt
 	      controller.
-- clock-names: Should be "sysmmu" if the System MMU is needed to gate its clock.
+- clock-names: Should be "sysmmu" or a pair of "aclk" and "pclk" to gate
+	       SYSMMU core clocks.
 	       Optional "master" if the clock to the System MMU is gated by
-	       another gate clock other than "sysmmu" (usually main gate clock
+	       another gate clock other core  (usually main gate clock
 	       of peripheral device this SYSMMU belongs to).
 - clocks: Phandles for respective clocks described by clock-names.
 - power-domains: Required if the System MMU is needed to gate its power.
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index a1e75cba18e0..1674de1cfed0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -243,7 +243,7 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS && ARM && MMU
+	depends on ARCH_EXYNOS && MMU
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
 	help
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8e289e2a05fb..9c8ce951158d 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1,6 +1,5 @@
-/* linux/drivers/iommu/exynos_iommu.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+/*
+ * Copyright (c) 2011,2016 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * This program is free software; you can redistribute it and/or modify
@@ -55,17 +54,25 @@ typedef u32 sysmmu_pte_t;
 #define lv2ent_small(pent) ((*(pent) & 2) == 2)
 #define lv2ent_large(pent) ((*(pent) & 3) == 1)
 
-static u32 sysmmu_page_offset(sysmmu_iova_t iova, u32 size)
-{
-	return iova & (size - 1);
-}
-
-#define section_phys(sent) (*(sent) & SECT_MASK)
-#define section_offs(iova) sysmmu_page_offset((iova), SECT_SIZE)
-#define lpage_phys(pent) (*(pent) & LPAGE_MASK)
-#define lpage_offs(iova) sysmmu_page_offset((iova), LPAGE_SIZE)
-#define spage_phys(pent) (*(pent) & SPAGE_MASK)
-#define spage_offs(iova) sysmmu_page_offset((iova), SPAGE_SIZE)
+/*
+ * v1.x - v3.x SYSMMU supports 32bit physical and 32bit virtual address spaces
+ * v5.0 introduced support for 36bit physical address space by shifting
+ * all page entry values by 4 bits.
+ * All SYSMMU controllers in the system support the address spaces of the same
+ * size, so PG_ENT_SHIFT can be initialized on first SYSMMU probe to proper
+ * value (0 or 4).
+ */
+static short PG_ENT_SHIFT = -1;
+#define SYSMMU_PG_ENT_SHIFT 0
+#define SYSMMU_V5_PG_ENT_SHIFT 4
+
+#define sect_to_phys(ent) (((phys_addr_t) ent) << PG_ENT_SHIFT)
+#define section_phys(sent) (sect_to_phys(*(sent)) & SECT_MASK)
+#define section_offs(iova) (iova & (SECT_SIZE - 1))
+#define lpage_phys(pent) (sect_to_phys(*(pent)) & LPAGE_MASK)
+#define lpage_offs(iova) (iova & (LPAGE_SIZE - 1))
+#define spage_phys(pent) (sect_to_phys(*(pent)) & SPAGE_MASK)
+#define spage_offs(iova) (iova & (SPAGE_SIZE - 1))
 
 #define NUM_LV1ENTRIES 4096
 #define NUM_LV2ENTRIES (SECT_SIZE / SPAGE_SIZE)
@@ -84,13 +91,12 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define LV2TABLE_SIZE (NUM_LV2ENTRIES * sizeof(sysmmu_pte_t))
 
 #define SPAGES_PER_LPAGE (LPAGE_SIZE / SPAGE_SIZE)
+#define lv2table_base(sent) (sect_to_phys(*(sent) & 0xFFFFFFC0))
 
-#define lv2table_base(sent) (*(sent) & 0xFFFFFC00)
-
-#define mk_lv1ent_sect(pa) ((pa) | 2)
-#define mk_lv1ent_page(pa) ((pa) | 1)
-#define mk_lv2ent_lpage(pa) ((pa) | 1)
-#define mk_lv2ent_spage(pa) ((pa) | 2)
+#define mk_lv1ent_sect(pa) ((pa >> PG_ENT_SHIFT) | 2)
+#define mk_lv1ent_page(pa) ((pa >> PG_ENT_SHIFT) | 1)
+#define mk_lv2ent_lpage(pa) ((pa >> PG_ENT_SHIFT) | 1)
+#define mk_lv2ent_spage(pa) ((pa >> PG_ENT_SHIFT) | 2)
 
 #define CTRL_ENABLE	0x5
 #define CTRL_BLOCK	0x7
@@ -98,14 +104,23 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 
 #define CFG_LRU		0x1
 #define CFG_QOS(n)	((n & 0xF) << 7)
-#define CFG_MASK	0x0150FFFF /* Selecting bit 0-15, 20, 22 and 24 */
 #define CFG_ACGEN	(1 << 24) /* System MMU 3.3 only */
 #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
 #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
 
+/* common registers */
 #define REG_MMU_CTRL		0x000
 #define REG_MMU_CFG		0x004
 #define REG_MMU_STATUS		0x008
+#define REG_MMU_VERSION		0x034
+
+#define MMU_MAJ_VER(val)	((val) >> 7)
+#define MMU_MIN_VER(val)	((val) & 0x7F)
+#define MMU_RAW_VER(reg)	(((reg) >> 21) & ((1 << 11) - 1)) /* 11 bits */
+
+#define MAKE_MMU_VER(maj, min)	((((maj) & 0xF) << 7) | ((min) & 0x7F))
+
+/* v1.x - v3.x registers */
 #define REG_MMU_FLUSH		0x00C
 #define REG_MMU_FLUSH_ENTRY	0x010
 #define REG_PT_BASE_ADDR	0x014
@@ -117,18 +132,14 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_AR_FAULT_ADDR	0x02C
 #define REG_DEFAULT_SLAVE_ADDR	0x030
 
-#define REG_MMU_VERSION		0x034
-
-#define MMU_MAJ_VER(val)	((val) >> 7)
-#define MMU_MIN_VER(val)	((val) & 0x7F)
-#define MMU_RAW_VER(reg)	(((reg) >> 21) & ((1 << 11) - 1)) /* 11 bits */
-
-#define MAKE_MMU_VER(maj, min)	((((maj) & 0xF) << 7) | ((min) & 0x7F))
-
-#define REG_PB0_SADDR		0x04C
-#define REG_PB0_EADDR		0x050
-#define REG_PB1_SADDR		0x054
-#define REG_PB1_EADDR		0x058
+/* v5.x registers */
+#define REG_V5_PT_BASE_PFN	0x00C
+#define REG_V5_MMU_FLUSH_ALL	0x010
+#define REG_V5_MMU_FLUSH_ENTRY	0x014
+#define REG_V5_INT_STATUS	0x060
+#define REG_V5_INT_CLEAR	0x064
+#define REG_V5_FAULT_AR_VA	0x070
+#define REG_V5_FAULT_AW_VA	0x080
 
 #define has_sysmmu(dev)		(dev->archdata.iommu != NULL)
 
@@ -169,6 +180,19 @@ static const struct sysmmu_fault_info sysmmu_faults[] = {
 	{ 7, REG_AW_FAULT_ADDR, "AW ACCESS PROTECTION", IOMMU_FAULT_WRITE },
 };
 
+static const struct sysmmu_fault_info sysmmu_v5_faults[] = {
+	{ 0, REG_V5_FAULT_AR_VA, "AR PTW", IOMMU_FAULT_READ },
+	{ 1, REG_V5_FAULT_AR_VA, "AR PAGE", IOMMU_FAULT_READ },
+	{ 2, REG_V5_FAULT_AR_VA, "AR MULTI-HIT", IOMMU_FAULT_READ },
+	{ 3, REG_V5_FAULT_AR_VA, "AR ACCESS PROTECTION", IOMMU_FAULT_READ },
+	{ 4, REG_V5_FAULT_AR_VA, "AR SECURITY PROTECTION", IOMMU_FAULT_READ },
+	{ 16, REG_V5_FAULT_AW_VA, "AW PTW", IOMMU_FAULT_WRITE },
+	{ 17, REG_V5_FAULT_AW_VA, "AW PAGE", IOMMU_FAULT_WRITE },
+	{ 18, REG_V5_FAULT_AW_VA, "AW MULTI-HIT", IOMMU_FAULT_WRITE },
+	{ 19, REG_V5_FAULT_AW_VA, "AW ACCESS PROTECTION", IOMMU_FAULT_WRITE },
+	{ 20, REG_V5_FAULT_AW_VA, "AW SECURITY PROTECTION", IOMMU_FAULT_WRITE },
+};
+
 /*
  * This structure is attached to dev.archdata.iommu of the master device
  * on device add, contains a list of SYSMMU controllers defined by device tree,
@@ -205,6 +229,8 @@ struct sysmmu_drvdata {
 	struct device *master;		/* master device (owner) */
 	void __iomem *sfrbase;		/* our registers */
 	struct clk *clk;		/* SYSMMU's clock */
+	struct clk *aclk;		/* SYSMMU's aclk clock */
+	struct clk *pclk;		/* SYSMMU's pclk clock */
 	struct clk *clk_master;		/* master's device clock */
 	int activations;		/* number of calls to sysmmu_enable */
 	spinlock_t lock;		/* lock for modyfying state */
@@ -262,7 +288,10 @@ static bool sysmmu_block(struct sysmmu_drvdata *data)
 
 static void __sysmmu_tlb_invalidate(struct sysmmu_drvdata *data)
 {
-	__raw_writel(0x1, data->sfrbase + REG_MMU_FLUSH);
+	if (MMU_MAJ_VER(data->version) < 5)
+		__raw_writel(0x1, data->sfrbase + REG_MMU_FLUSH);
+	else
+		__raw_writel(0x1, data->sfrbase + REG_V5_MMU_FLUSH_ALL);
 }
 
 static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
@@ -271,15 +300,23 @@ static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 	unsigned int i;
 
 	for (i = 0; i < num_inv; i++) {
-		__raw_writel((iova & SPAGE_MASK) | 1,
-				data->sfrbase + REG_MMU_FLUSH_ENTRY);
+		if (MMU_MAJ_VER(data->version) < 5)
+			__raw_writel((iova & SPAGE_MASK) | 1,
+				     data->sfrbase + REG_MMU_FLUSH_ENTRY);
+		else
+			__raw_writel((iova & SPAGE_MASK) | 1,
+				     data->sfrbase + REG_V5_MMU_FLUSH_ENTRY);
 		iova += SPAGE_SIZE;
 	}
 }
 
 static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 {
-	__raw_writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
+	if (MMU_MAJ_VER(data->version) < 5)
+		__raw_writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
+	else
+		__raw_writel(pgd >> PAGE_SHIFT,
+			     data->sfrbase + REG_V5_PT_BASE_PFN);
 
 	__sysmmu_tlb_invalidate(data);
 }
@@ -290,6 +327,8 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 
 	clk_enable(data->clk_master);
 	clk_enable(data->clk);
+	clk_enable(data->pclk);
+	clk_enable(data->aclk);
 
 	ver = __raw_readl(data->sfrbase + REG_MMU_VERSION);
 
@@ -302,6 +341,8 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
 		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
 
+	clk_disable(data->aclk);
+	clk_disable(data->pclk);
 	clk_disable(data->clk);
 	clk_disable(data->clk_master);
 }
@@ -326,19 +367,31 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 {
 	/* SYSMMU is in blocked state when interrupt occurred. */
 	struct sysmmu_drvdata *data = dev_id;
-	const struct sysmmu_fault_info *finfo = sysmmu_faults;
-	int i, n = ARRAY_SIZE(sysmmu_faults);
-	unsigned int itype;
+	const struct sysmmu_fault_info *finfo;
+	unsigned int i, n, itype;
 	sysmmu_iova_t fault_addr = -1;
+	unsigned short reg_status, reg_clear;
 	int ret = -ENOSYS;
 
 	WARN_ON(!is_sysmmu_active(data));
 
+	if (MMU_MAJ_VER(data->version) < 5) {
+		reg_status = REG_INT_STATUS;
+		reg_clear = REG_INT_CLEAR;
+		finfo = sysmmu_faults;
+		n = ARRAY_SIZE(sysmmu_faults);
+	} else {
+		reg_status = REG_V5_INT_STATUS;
+		reg_clear = REG_V5_INT_CLEAR;
+		finfo = sysmmu_v5_faults;
+		n = ARRAY_SIZE(sysmmu_v5_faults);
+	}
+
 	spin_lock(&data->lock);
 
 	clk_enable(data->clk_master);
 
-	itype = __ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
+	itype = __ffs(__raw_readl(data->sfrbase + reg_status));
 	for (i = 0; i < n; i++, finfo++)
 		if (finfo->bit == itype)
 			break;
@@ -355,7 +408,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	/* fault is not recovered by fault handler */
 	BUG_ON(ret != 0);
 
-	__raw_writel(1 << itype, data->sfrbase + REG_INT_CLEAR);
+	__raw_writel(1 << itype, data->sfrbase + reg_clear);
 
 	sysmmu_unblock(data);
 
@@ -373,6 +426,8 @@ static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
 	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 	__raw_writel(0, data->sfrbase + REG_MMU_CFG);
 
+	clk_disable(data->aclk);
+	clk_disable(data->pclk);
 	clk_disable(data->clk);
 	clk_disable(data->clk_master);
 }
@@ -421,6 +476,8 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 {
 	clk_enable(data->clk_master);
 	clk_enable(data->clk);
+	clk_enable(data->pclk);
+	clk_enable(data->aclk);
 
 	__raw_writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
 
@@ -544,22 +601,47 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	data->clk = devm_clk_get(dev, "sysmmu");
-	if (IS_ERR(data->clk)) {
-		dev_err(dev, "Failed to get clock!\n");
-		return PTR_ERR(data->clk);
-	} else  {
+	if (!IS_ERR(data->clk)) {
 		ret = clk_prepare(data->clk);
 		if (ret) {
 			dev_err(dev, "Failed to prepare clk\n");
 			return ret;
 		}
+	} else {
+		data->clk = NULL;
+	}
+
+	data->aclk = devm_clk_get(dev, "aclk");
+	if (!IS_ERR(data->aclk)) {
+		ret = clk_prepare(data->aclk);
+		if (ret) {
+			dev_err(dev, "Failed to prepare aclk\n");
+			return ret;
+		}
+	} else {
+		data->aclk = NULL;
+	}
+
+	data->pclk = devm_clk_get(dev, "pclk");
+	if (!IS_ERR(data->pclk)) {
+		ret = clk_prepare(data->pclk);
+		if (ret) {
+			dev_err(dev, "Failed to prepare pclk\n");
+			return ret;
+		}
+	} else {
+		data->pclk = NULL;
+	}
+
+	if (!data->clk && (!data->aclk || !data->pclk)) {
+		dev_err(dev, "Failed to get device clock(s)!\n");
+		return -ENOSYS;
 	}
 
 	data->clk_master = devm_clk_get(dev, "master");
 	if (!IS_ERR(data->clk_master)) {
 		ret = clk_prepare(data->clk_master);
 		if (ret) {
-			clk_unprepare(data->clk);
 			dev_err(dev, "Failed to prepare master's clk\n");
 			return ret;
 		}
@@ -573,6 +655,13 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	__sysmmu_get_version(data);
+	if (PG_ENT_SHIFT < 0) {
+		if (MMU_MAJ_VER(data->version) < 5)
+			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
+		else
+			PG_ENT_SHIFT = SYSMMU_V5_PG_ENT_SHIFT;
+	}
+
 	pm_runtime_enable(dev);
 
 	return 0;
@@ -637,6 +726,8 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 	dma_addr_t handle;
 	int i;
 
+	/* Check if correct PTE offsets are initialized */
+	BUG_ON(PG_ENT_SHIFT < 0 || !dma_dev);
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
@@ -816,7 +907,7 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 		bool need_flush_flpd_cache = lv1ent_zero(sent);
 
 		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
-		BUG_ON((unsigned int)pent & (LV2TABLE_SIZE - 1));
+		BUG_ON((phys_addr_t)pent & (LV2TABLE_SIZE - 1));
 		if (!pent)
 			return ERR_PTR(-ENOMEM);
 
-- 
1.9.2
