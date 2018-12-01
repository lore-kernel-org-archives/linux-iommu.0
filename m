From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 7/9] iommu/tegra: Make it explicitly non-modular
Date: Sat, 1 Dec 2018 14:19:15 -0500
Message-ID: <1543691957-17608-8-git-send-email-paul.gortmaker@windriver.com>
References: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The Kconfig currently controlling compilation of this code is:

drivers/iommu/Kconfig:config TEGRA_IOMMU_GART
drivers/iommu/Kconfig:  bool "Tegra GART IOMMU Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We replace module.h with moduleparam.h since the file does actually
declare some module_param() and the easiest way to keep back
compatibility with existing use cases is to leave it as-is for now.

The init function was missing an __init annotation, so it was added.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-tegra@vger.kernel.org
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/tegra-gart.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 7b1361d57a17..da6a4e357b2b 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -3,6 +3,8 @@
  *
  * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
  *
+ * Author: Hiroshi DOYU <hdoyu@nvidia.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -19,7 +21,8 @@
 
 #define pr_fmt(fmt)	"%s(): " fmt, __func__
 
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -478,20 +481,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
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
@@ -501,34 +490,22 @@ static const struct of_device_id tegra_gart_of_match[] = {
 	{ .compatible = "nvidia,tegra20-gart", },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, tegra_gart_of_match);
 
 static struct platform_driver tegra_gart_driver = {
 	.probe		= tegra_gart_probe,
-	.remove		= tegra_gart_remove,
 	.driver = {
 		.name	= "tegra-gart",
 		.pm	= &tegra_gart_pm_ops,
 		.of_match_table = tegra_gart_of_match,
+		.suppress_bind_attrs = true,
 	},
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
-module_param(gart_debug, bool, 0644);
 
+module_param(gart_debug, bool, 0644);
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
-MODULE_DESCRIPTION("IOMMU API for GART in Tegra20");
-MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
-MODULE_ALIAS("platform:tegra-gart");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4
