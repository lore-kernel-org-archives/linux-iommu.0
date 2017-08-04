From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] iommu/exynos: Remove custom platform device registration code
Date: Fri, 04 Aug 2017 12:28:33 +0200
Message-ID: <1501842513-23180-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170804102843eucas1p1fb17da4f86044a8ad78cc1684aa6e321@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Commit 09515ef5ddad ("of/acpi: Configure dma operations at probe time for
platform/amba/pci bus devices") postponed the moment of attaching IOMMU
controller to its device, so there is no need to register IOMMU controllers
very early, before all other devices in the system. This change gives us an
opportunity to use standard platform device registration method also for
Exynos SYSMMU controllers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2395478dde75..76436d4ff4d1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -659,6 +659,13 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * use the first registered sysmmu device for performing
+	 * dma mapping operations on iommu page tables (cpu cache flush)
+	 */
+	if (!dma_dev)
+		dma_dev = &pdev->dev;
+
 	pm_runtime_enable(dev);
 
 	return 0;
@@ -1339,8 +1346,6 @@ static int exynos_iommu_of_xlate(struct device *dev,
 	.of_xlate = exynos_iommu_of_xlate,
 };
 
-static bool init_done;
-
 static int __init exynos_iommu_init(void)
 {
 	int ret;
@@ -1373,8 +1378,6 @@ static int __init exynos_iommu_init(void)
 		goto err_set_iommu;
 	}
 
-	init_done = true;
-
 	return 0;
 err_set_iommu:
 	kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
@@ -1384,27 +1387,6 @@ static int __init exynos_iommu_init(void)
 	kmem_cache_destroy(lv2table_kmem_cache);
 	return ret;
 }
+core_initcall(exynos_iommu_init);
 
-static int __init exynos_iommu_of_setup(struct device_node *np)
-{
-	struct platform_device *pdev;
-
-	if (!init_done)
-		exynos_iommu_init();
-
-	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
-	if (!pdev)
-		return -ENODEV;
-
-	/*
-	 * use the first registered sysmmu device for performing
-	 * dma mapping operations on iommu page tables (cpu cache flush)
-	 */
-	if (!dma_dev)
-		dma_dev = &pdev->dev;
-
-	return 0;
-}
-
-IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu",
-		 exynos_iommu_of_setup);
+IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu", NULL);
-- 
1.9.1
