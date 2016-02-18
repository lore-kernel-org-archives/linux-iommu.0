From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 04/13] iommu: exynos: simplify master clock operations
Date: Thu, 18 Feb 2016 15:12:51 +0100
Message-ID: <1455804780-9616-5-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

All clock API function can be called on NULL clock, so simplify code avoid
checking of master clock presence.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8c8a7f7968d1..bf6b826b1d8b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -333,8 +333,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	spin_lock(&data->lock);
 
-	if (!IS_ERR(data->clk_master))
-		clk_enable(data->clk_master);
+	clk_enable(data->clk_master);
 
 	itype = (enum exynos_sysmmu_inttype)
 		__ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
@@ -366,8 +365,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	sysmmu_unblock(data->sfrbase);
 
-	if (!IS_ERR(data->clk_master))
-		clk_disable(data->clk_master);
+	clk_disable(data->clk_master);
 
 	spin_unlock(&data->lock);
 
@@ -376,15 +374,13 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
 {
-	if (!IS_ERR(data->clk_master))
-		clk_enable(data->clk_master);
+	clk_enable(data->clk_master);
 
 	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 	__raw_writel(0, data->sfrbase + REG_MMU_CFG);
 
 	clk_disable(data->clk);
-	if (!IS_ERR(data->clk_master))
-		clk_disable(data->clk_master);
+	clk_disable(data->clk_master);
 }
 
 static bool __sysmmu_disable(struct sysmmu_drvdata *data)
@@ -437,8 +433,7 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 
 static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 {
-	if (!IS_ERR(data->clk_master))
-		clk_enable(data->clk_master);
+	clk_enable(data->clk_master);
 	clk_enable(data->clk);
 
 	__raw_writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
@@ -449,8 +444,7 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 
 	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
-	if (!IS_ERR(data->clk_master))
-		clk_disable(data->clk_master);
+	clk_disable(data->clk_master);
 }
 
 static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
@@ -493,16 +487,14 @@ static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 {
 	unsigned long flags;
 
-	if (!IS_ERR(data->clk_master))
-		clk_enable(data->clk_master);
+	clk_enable(data->clk_master);
 
 	spin_lock_irqsave(&data->lock, flags);
 	if (is_sysmmu_active(data))
 		__sysmmu_tlb_invalidate_flpdcache(data, iova);
 	spin_unlock_irqrestore(&data->lock, flags);
 
-	if (!IS_ERR(data->clk_master))
-		clk_disable(data->clk_master);
+	clk_disable(data->clk_master);
 }
 
 static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
@@ -514,8 +506,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 	if (is_sysmmu_active(data)) {
 		unsigned int num_inv = 1;
 
-		if (!IS_ERR(data->clk_master))
-			clk_enable(data->clk_master);
+		clk_enable(data->clk_master);
 
 		/*
 		 * L2TLB invalidation required
@@ -535,8 +526,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 				data->sfrbase, iova, num_inv);
 			sysmmu_unblock(data->sfrbase);
 		}
-		if (!IS_ERR(data->clk_master))
-			clk_disable(data->clk_master);
+		clk_disable(data->clk_master);
 	} else {
 		dev_dbg(data->master,
 			"disabled. Skipping TLB invalidation @ %#x\n", iova);
@@ -593,6 +583,8 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to prepare master's clk\n");
 			return ret;
 		}
+	} else {
+		data->clk_master = NULL;
 	}
 
 	data->sysmmu = dev;
-- 
1.9.2
