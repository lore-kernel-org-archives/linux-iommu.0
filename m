From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 04/11] iommu: exynos: simplify master clock operations
Date: Tue, 16 Feb 2016 15:56:57 +0100
Message-ID: <1455634624-18130-5-git-send-email-m.szyprowski@samsung.com>
References: <1455634624-18130-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1455634624-18130-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

All clock API function can be called on NULL clock, so simplify code avoid
checking of master clock presence.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8c8a7f7..bf6b826 100644
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
