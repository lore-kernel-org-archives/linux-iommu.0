From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] iommu/tegra: Add device tree support for SMMU
Date: Fri, 13 Apr 2012 12:23:31 +0200
Message-ID: <20120413.132331.971155172093927884.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add device tree support for Tegra30 IOMMU(SMMU).

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index eb93c82..d4c7963 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -30,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/iommu.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
@@ -1005,6 +1006,13 @@ const struct dev_pm_ops tegra_smmu_pm_ops = {
 	.resume		= tegra_smmu_resume,
 };
 
+#ifdef CONFIG_OF
+static struct of_device_id tegra_smmu_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra30-smmu", },
+	{ },
+};
+#endif
+
 static struct platform_driver tegra_smmu_driver = {
 	.probe		= tegra_smmu_probe,
 	.remove		= tegra_smmu_remove,
@@ -1012,6 +1020,7 @@ static struct platform_driver tegra_smmu_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "tegra-smmu",
 		.pm	= &tegra_smmu_pm_ops,
+		.of_match_table = of_match_ptr(tegra_smmu_of_match),
 	},
 };
 
@@ -1031,4 +1040,5 @@ module_exit(tegra_smmu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra30");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
+MODULE_ALIAS("platform:tegra-smmu");
 MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
