From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] iommu/exynos: Use proper readl/writel register interface
Date: Mon, 29 Feb 2016 13:42:57 +0100
Message-ID: <1456749777-8998-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Drivers should use generic readl/writel calls to access HW registers, so
replace all __raw_readl/writel with generic version.

Suggested-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b066504..20fe443 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -268,18 +268,18 @@ static bool is_sysmmu_active(struct sysmmu_drvdata *data)
 
 static void sysmmu_unblock(struct sysmmu_drvdata *data)
 {
-	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
+	writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 }
 
 static bool sysmmu_block(struct sysmmu_drvdata *data)
 {
 	int i = 120;
 
-	__raw_writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
-	while ((i > 0) && !(__raw_readl(data->sfrbase + REG_MMU_STATUS) & 1))
+	writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
+	while ((i > 0) && !(readl(data->sfrbase + REG_MMU_STATUS) & 1))
 		--i;
 
-	if (!(__raw_readl(data->sfrbase + REG_MMU_STATUS) & 1)) {
+	if (!(readl(data->sfrbase + REG_MMU_STATUS) & 1)) {
 		sysmmu_unblock(data);
 		return false;
 	}
@@ -290,9 +290,9 @@ static bool sysmmu_block(struct sysmmu_drvdata *data)
 static void __sysmmu_tlb_invalidate(struct sysmmu_drvdata *data)
 {
 	if (MMU_MAJ_VER(data->version) < 5)
-		__raw_writel(0x1, data->sfrbase + REG_MMU_FLUSH);
+		writel(0x1, data->sfrbase + REG_MMU_FLUSH);
 	else
-		__raw_writel(0x1, data->sfrbase + REG_V5_MMU_FLUSH_ALL);
+		writel(0x1, data->sfrbase + REG_V5_MMU_FLUSH_ALL);
 }
 
 static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
@@ -302,10 +302,10 @@ static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 
 	for (i = 0; i < num_inv; i++) {
 		if (MMU_MAJ_VER(data->version) < 5)
-			__raw_writel((iova & SPAGE_MASK) | 1,
+			writel((iova & SPAGE_MASK) | 1,
 				     data->sfrbase + REG_MMU_FLUSH_ENTRY);
 		else
-			__raw_writel((iova & SPAGE_MASK) | 1,
+			writel((iova & SPAGE_MASK) | 1,
 				     data->sfrbase + REG_V5_MMU_FLUSH_ENTRY);
 		iova += SPAGE_SIZE;
 	}
@@ -314,9 +314,9 @@ static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 {
 	if (MMU_MAJ_VER(data->version) < 5)
-		__raw_writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
+		writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
 	else
-		__raw_writel(pgd >> PAGE_SHIFT,
+		writel(pgd >> PAGE_SHIFT,
 			     data->sfrbase + REG_V5_PT_BASE_PFN);
 
 	__sysmmu_tlb_invalidate(data);
@@ -331,7 +331,7 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 	clk_enable(data->pclk);
 	clk_enable(data->aclk);
 
-	ver = __raw_readl(data->sfrbase + REG_MMU_VERSION);
+	ver = readl(data->sfrbase + REG_MMU_VERSION);
 
 	/* controllers on some SoCs don't report proper version */
 	if (ver == 0x80000001u)
@@ -392,7 +392,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	clk_enable(data->clk_master);
 
-	itype = __ffs(__raw_readl(data->sfrbase + reg_status));
+	itype = __ffs(readl(data->sfrbase + reg_status));
 	for (i = 0; i < n; i++, finfo++)
 		if (finfo->bit == itype)
 			break;
@@ -400,7 +400,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	BUG_ON(i == n);
 
 	/* print debug message */
-	fault_addr = __raw_readl(data->sfrbase + finfo->addr_reg);
+	fault_addr = readl(data->sfrbase + finfo->addr_reg);
 	show_fault_information(data, finfo, fault_addr);
 
 	if (data->domain)
@@ -409,7 +409,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	/* fault is not recovered by fault handler */
 	BUG_ON(ret != 0);
 
-	__raw_writel(1 << itype, data->sfrbase + reg_clear);
+	writel(1 << itype, data->sfrbase + reg_clear);
 
 	sysmmu_unblock(data);
 
@@ -424,8 +424,8 @@ static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
 {
 	clk_enable(data->clk_master);
 
-	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
-	__raw_writel(0, data->sfrbase + REG_MMU_CFG);
+	writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
+	writel(0, data->sfrbase + REG_MMU_CFG);
 
 	clk_disable(data->aclk);
 	clk_disable(data->pclk);
@@ -470,7 +470,7 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 	else
 		cfg = CFG_QOS(15) | CFG_FLPDCACHE | CFG_ACGEN;
 
-	__raw_writel(cfg, data->sfrbase + REG_MMU_CFG);
+	writel(cfg, data->sfrbase + REG_MMU_CFG);
 }
 
 static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
@@ -480,13 +480,13 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 	clk_enable(data->pclk);
 	clk_enable(data->aclk);
 
-	__raw_writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
+	writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
 
 	__sysmmu_init_config(data);
 
 	__sysmmu_set_ptbase(data, data->pgtable);
 
-	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
+	writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
 	clk_disable(data->clk_master);
 }
-- 
1.9.2
