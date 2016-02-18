From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 08/13] iommu: exynos: unify code for fldp cache invalidation
Date: Thu, 18 Feb 2016 15:12:55 +0100
Message-ID: <1455804780-9616-9-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch simplifies the code for handling of flpdcache invalidation.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 15787a177a16..e42a76cc9674 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -440,13 +440,6 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
 	return ret;
 }
 
-static void __sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
-					      sysmmu_iova_t iova)
-{
-	if (data->version == MAKE_MMU_VER(3, 3))
-		__raw_writel(iova | 0x1, data->sfrbase + REG_MMU_FLUSH_ENTRY);
-}
-
 static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 					    sysmmu_iova_t iova)
 {
@@ -455,8 +448,10 @@ static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 	clk_enable(data->clk_master);
 
 	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data))
-		__sysmmu_tlb_invalidate_flpdcache(data, iova);
+	if (is_sysmmu_active(data)) {
+		if (data->version >= MAKE_MMU_VER(3, 3))
+			__sysmmu_tlb_invalidate_entry(data, iova, 1);
+	}
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	clk_disable(data->clk_master);
-- 
1.9.2
