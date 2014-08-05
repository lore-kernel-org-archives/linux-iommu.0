From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 18/29] iommu: exynos: remove unused functions
Date: Tue, 05 Aug 2014 12:47:46 +0200
Message-ID: <1407235677-26324-19-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch removes two unneeded functions, which are not a part of
generic IOMMU API and were never used by any other driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8927923..ec3c882 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -491,13 +491,6 @@ static int __exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable,
 	return ret;
 }
 
-int exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable)
-{
-	BUG_ON(!memblock_is_memory(pgtable));
-
-	return __exynos_sysmmu_enable(dev, pgtable, NULL);
-}
-
 static bool exynos_sysmmu_disable(struct device *dev)
 {
 	unsigned long flags;
@@ -589,30 +582,6 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 	spin_unlock_irqrestore(&data->lock, flags);
 }
 
-void exynos_sysmmu_tlb_invalidate(struct device *dev)
-{
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	unsigned long flags;
-	struct sysmmu_drvdata *data;
-
-	data = dev_get_drvdata(owner->sysmmu);
-
-	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data)) {
-		if (!IS_ERR(data->clk_master))
-			clk_enable(data->clk_master);
-		if (sysmmu_block(data->sfrbase)) {
-			__sysmmu_tlb_invalidate(data->sfrbase);
-			sysmmu_unblock(data->sfrbase);
-		}
-		if (!IS_ERR(data->clk_master))
-			clk_disable(data->clk_master);
-	} else {
-		dev_dbg(dev, "disabled. Skipping TLB invalidation\n");
-	}
-	spin_unlock_irqrestore(&data->lock, flags);
-}
-
 static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 {
 	int irq, ret;
-- 
1.9.2
