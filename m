From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 05/13] iommu: exynos: refactor code (no direct register
 access)
Date: Thu, 18 Feb 2016 15:12:52 +0100
Message-ID: <1455804780-9616-6-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch changes some internal functions to have access to the state of
sysmmu device instead of having only it's registers. This will make the
code ready for future extensions.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index bf6b826b1d8b..4275222cead3 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -254,50 +254,49 @@ static bool is_sysmmu_active(struct sysmmu_drvdata *data)
 	return data->activations > 0;
 }
 
-static void sysmmu_unblock(void __iomem *sfrbase)
+static void sysmmu_unblock(struct sysmmu_drvdata *data)
 {
-	__raw_writel(CTRL_ENABLE, sfrbase + REG_MMU_CTRL);
+	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 }
 
-static bool sysmmu_block(void __iomem *sfrbase)
+static bool sysmmu_block(struct sysmmu_drvdata *data)
 {
 	int i = 120;
 
-	__raw_writel(CTRL_BLOCK, sfrbase + REG_MMU_CTRL);
-	while ((i > 0) && !(__raw_readl(sfrbase + REG_MMU_STATUS) & 1))
+	__raw_writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
+	while ((i > 0) && !(__raw_readl(data->sfrbase + REG_MMU_STATUS) & 1))
 		--i;
 
-	if (!(__raw_readl(sfrbase + REG_MMU_STATUS) & 1)) {
-		sysmmu_unblock(sfrbase);
+	if (!(__raw_readl(data->sfrbase + REG_MMU_STATUS) & 1)) {
+		sysmmu_unblock(data);
 		return false;
 	}
 
 	return true;
 }
 
-static void __sysmmu_tlb_invalidate(void __iomem *sfrbase)
+static void __sysmmu_tlb_invalidate(struct sysmmu_drvdata *data)
 {
-	__raw_writel(0x1, sfrbase + REG_MMU_FLUSH);
+	__raw_writel(0x1, data->sfrbase + REG_MMU_FLUSH);
 }
 
-static void __sysmmu_tlb_invalidate_entry(void __iomem *sfrbase,
+static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 				sysmmu_iova_t iova, unsigned int num_inv)
 {
 	unsigned int i;
 
 	for (i = 0; i < num_inv; i++) {
 		__raw_writel((iova & SPAGE_MASK) | 1,
-				sfrbase + REG_MMU_FLUSH_ENTRY);
+				data->sfrbase + REG_MMU_FLUSH_ENTRY);
 		iova += SPAGE_SIZE;
 	}
 }
 
-static void __sysmmu_set_ptbase(void __iomem *sfrbase,
-				       phys_addr_t pgd)
+static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 {
-	__raw_writel(pgd, sfrbase + REG_PT_BASE_ADDR);
+	__raw_writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
 
-	__sysmmu_tlb_invalidate(sfrbase);
+	__sysmmu_tlb_invalidate(data);
 }
 
 static void show_fault_information(const char *name,
@@ -363,7 +362,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	__raw_writel(1 << itype, data->sfrbase + REG_INT_CLEAR);
 
-	sysmmu_unblock(data->sfrbase);
+	sysmmu_unblock(data);
 
 	clk_disable(data->clk_master);
 
@@ -440,7 +439,7 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 
 	__sysmmu_init_config(data);
 
-	__sysmmu_set_ptbase(data->sfrbase, data->pgtable);
+	__sysmmu_set_ptbase(data, data->pgtable);
 
 	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
@@ -521,10 +520,9 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 		if (MMU_MAJ_VER(data->version) == 2)
 			num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
 
-		if (sysmmu_block(data->sfrbase)) {
-			__sysmmu_tlb_invalidate_entry(
-				data->sfrbase, iova, num_inv);
-			sysmmu_unblock(data->sfrbase);
+		if (sysmmu_block(data)) {
+			__sysmmu_tlb_invalidate_entry(data, iova, num_inv);
+			sysmmu_unblock(data);
 		}
 		clk_disable(data->clk_master);
 	} else {
-- 
1.9.2
