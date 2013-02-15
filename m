From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 1/2] iommu/tegra: assume CONFIG_OF in gart driver
Date: Fri, 15 Feb 2013 15:01:06 -0700
Message-ID: <1360965667-19699-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Tegra only supports, and always enables, device tree. Remove all ifdefs
for DT support from the driver.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-gart.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 8219f1d..8643757 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -430,13 +430,11 @@ const struct dev_pm_ops tegra_gart_pm_ops = {
 	.resume		= tegra_gart_resume,
 };
 
-#ifdef CONFIG_OF
 static struct of_device_id tegra_gart_of_match[] = {
 	{ .compatible = "nvidia,tegra20-gart", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_gart_of_match);
-#endif
 
 static struct platform_driver tegra_gart_driver = {
 	.probe		= tegra_gart_probe,
@@ -445,7 +443,7 @@ static struct platform_driver tegra_gart_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "tegra-gart",
 		.pm	= &tegra_gart_pm_ops,
-		.of_match_table = of_match_ptr(tegra_gart_of_match),
+		.of_match_table = tegra_gart_of_match,
 	},
 };
 
-- 
1.7.10.4
