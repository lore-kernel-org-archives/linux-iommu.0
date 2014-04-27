From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Subject: [PATCH v12 12/31] iommu/exynos: support for device tree
Date: Sun, 27 Apr 2014 13:07:44 +0530
Message-ID: <1398584283-22846-13-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: kgene.kim@samsung.com, tomasz.figa@gmail.com, pullip.cho@samsung.com, a.motakis@virtualopensystems.com, grundler@chromium.org, joro@8bytes.org, prathyush.k@samsung.com, rahul.sharma@samsung.com, sachin.kamat@linaro.org, supash.ramaswamy@linaro.org, Varun.Sethi@freescale.com, s.nawrocki@samsung.com, t.figa@samsung.com, joshi@samsung.com, Shaik Ameer Basha <shaik.ameer@samsung.com>
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho@samsung.com>

This commit adds device tree support for System MMU.
It also enables iommu support for ARCH_EXYNOS.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 arch/arm/Kconfig             |    2 ++
 drivers/iommu/Kconfig        |    8 +++-----
 drivers/iommu/exynos-iommu.c |   19 +++++++++++++++----
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab438cb..19689e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -834,6 +834,8 @@ config ARCH_EXYNOS
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SPARSEMEM_ENABLE
+	select ARM_AMBA
+	select ARM_DMA_USE_IOMMU
 	select ARM_GIC
 	select COMMON_CLK
 	select CPU_V7
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index df56e4c..5feadb8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -178,16 +178,14 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
+	depends on ARCH_EXYNOS
 	select IOMMU_API
 	help
-	  Support for the IOMMU(System MMU) of Samsung Exynos application
-	  processor family. This enables H/W multimedia accellerators to see
+	  Support for the IOMMU (System MMU) of Samsung Exynos application
+	  processor family. This enables H/W multimedia accelerators to see
 	  non-linear physical memory chunks as a linear memory in their
 	  address spaces
 
-	  If unsure, say N here.
-
 config EXYNOS_IOMMU_DEBUG
 	bool "Debugging log for Exynos IOMMU"
 	depends on EXYNOS_IOMMU
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0f1d3f0..cbb9b67 100755
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/memblock.h>
 #include <linux/export.h>
+#include <linux/of.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
@@ -494,7 +495,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 	read_unlock_irqrestore(&data->lock, flags);
 }
 
-static int exynos_sysmmu_probe(struct platform_device *pdev)
+static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 {
 	int irq, ret;
 	struct device *dev = &pdev->dev;
@@ -548,11 +549,21 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver exynos_sysmmu_driver = {
-	.probe		= exynos_sysmmu_probe,
-	.driver		= {
+static const struct of_device_id sysmmu_of_match[] __initconst = {
+	{ .compatible	= "samsung,sysmmu-v1", },
+	{ .compatible	= "samsung,sysmmu-v2", },
+	{ .compatible	= "samsung,sysmmu-v3.1", },
+	{ .compatible	= "samsung,sysmmu-v3.2", },
+	{ .compatible	= "samsung,sysmmu-v3.3", },
+	{ },
+};
+
+static struct platform_driver exynos_sysmmu_driver __refdata = {
+	.probe	= exynos_sysmmu_probe,
+	.driver	= {
 		.owner		= THIS_MODULE,
 		.name		= "exynos-sysmmu",
+		.of_match_table	= sysmmu_of_match,
 	}
 };
 
-- 
1.7.9.5
