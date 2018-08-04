From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 3/8] iommu/tegra: gart: Clean up drivers module code
Date: Sat,  4 Aug 2018 17:29:58 +0300
Message-ID: <20180804143003.15817-4-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

GART driver is built-in, hence it can't be unloaded and the module removal
code is never used. This patch merely removes the dead code and makes
GART driver explicitly built-in by dropping the drivers bind/unbind sysfs
attributes. Lastly disallow to defer drivers probing, since it's a core
driver and actually nothing should cause the deferred probe.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index f8b653e25914..141ff0c79ee4 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -502,20 +502,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_gart_remove(struct platform_device *pdev)
-{
-	struct gart_device *gart = platform_get_drvdata(pdev);
-
-	iommu_device_unregister(&gart->iommu);
-	iommu_device_sysfs_remove(&gart->iommu);
-
-	writel(0, gart->regs + GART_CONFIG);
-	if (gart->savedata)
-		vfree(gart->savedata);
-	gart_handle = NULL;
-	return 0;
-}
-
 static const struct dev_pm_ops tegra_gart_pm_ops = {
 	.suspend	= tegra_gart_suspend,
 	.resume		= tegra_gart_resume,
@@ -529,26 +515,21 @@ MODULE_DEVICE_TABLE(of, tegra_gart_of_match);
 
 static struct platform_driver tegra_gart_driver = {
 	.probe		= tegra_gart_probe,
-	.remove		= tegra_gart_remove,
 	.driver = {
 		.name	= "tegra-gart",
 		.pm	= &tegra_gart_pm_ops,
 		.of_match_table = tegra_gart_of_match,
+		.suppress_bind_attrs = true,
 	},
+	.prevent_deferred_probe = true,
 };
 
-static int tegra_gart_init(void)
+static int __init tegra_gart_init(void)
 {
 	return platform_driver_register(&tegra_gart_driver);
 }
-
-static void __exit tegra_gart_exit(void)
-{
-	platform_driver_unregister(&tegra_gart_driver);
-}
-
 subsys_initcall(tegra_gart_init);
-module_exit(tegra_gart_exit);
+
 module_param(gart_debug, bool, 0644);
 
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
-- 
2.18.0
