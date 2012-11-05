From: Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] iommu: exynos: add support for dt based instantiation for
	iommu devices
Date: Mon, 05 Nov 2012 20:52:50 +0530
Message-ID: <1352128970-4791-1-git-send-email-rahul.sharma@samsung.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.shirish-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds supports DT based intantiation of sysmmu devices.
It also removes dependency on CONFIG_EXYNOS_DEV_SYSMMU which is
primarily meant for nont-dt platforms.

This patch is based on "arm/exynos" branch at
http://git.kernel.org/?p=linux/kernel/git/joro/iommu.git

This patch is having dependency on  linux-samsung-soc patchset posted at
http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/13556

Signed-off-by: Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/Kconfig        |    2 +-
 drivers/iommu/exynos-iommu.c |   28 +++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 9f69b56..52dc41f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -168,7 +168,7 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
+	depends on ARCH_EXYNOS
 	select IOMMU_API
 	help
 	  Support for the IOMMU(System MMU) of Samsung Exynos application
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7fe44f8..64a7392 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/memblock.h>
 #include <linux/export.h>
+#include <linux/of_platform.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
@@ -576,6 +577,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	int i, ret;
 	struct device *dev;
 	struct sysmmu_drvdata *data;
+	struct sysmmu_platform_data *platdata;
 
 	dev = &pdev->dev;
 
@@ -634,9 +636,21 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (dev->of_node) {
+		platdata = devm_kzalloc(dev, sizeof(*platdata), GFP_KERNEL);
+		if (!platdata) {
+			dev_dbg(dev, "memory allocation for pdata failed\n");
+			goto err_irq;
+		}
+
+		platdata->clockname = SYSMMU_CLOCK_NAME;
+		platdata->dbgname = (char *)dev->of_node->name;
+		dev->platform_data = platdata;
+	}
+
 	if (dev_get_platdata(dev)) {
 		char *deli, *beg;
-		struct sysmmu_platform_data *platdata = dev_get_platdata(dev);
+		platdata = dev_get_platdata(dev);
 
 		beg = platdata->clockname;
 
@@ -670,8 +684,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	__set_fault_handler(data, &default_fault_handler);
 
-	if (dev->parent)
-		pm_runtime_enable(dev);
+	pm_runtime_enable(dev);
 
 	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
 	return 0;
@@ -693,11 +706,20 @@ err_alloc:
 	return ret;
 }
 
+static struct of_device_id iommu_match_types[] = {
+	{
+		.compatible = "samsung,exynos5-sysmmu",
+	}, {
+		/* end node */
+	}
+};
+
 static struct platform_driver exynos_sysmmu_driver = {
 	.probe		= exynos_sysmmu_probe,
 	.driver		= {
 		.owner		= THIS_MODULE,
 		.name		= "exynos-sysmmu",
+		.of_match_table = iommu_match_types,
 	}
 };
 
-- 
1.7.0.4
