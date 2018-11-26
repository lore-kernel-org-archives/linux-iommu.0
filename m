From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH 7/9] iommu: tegra-gart: make it explicitly non-modular
Date: Mon, 26 Nov 2018 17:31:36 -0500
Message-ID: <1543271498-28966-8-git-send-email-paul.gortmaker@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1543271498-28966-1-git-send-email-paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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

Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
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
+ * Author: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
-MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
-MODULE_ALIAS("platform:tegra-gart");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4
