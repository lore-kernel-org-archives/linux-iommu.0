From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] iommu/tegra-gart: Staticize tegra_gart_pm_ops
Date: Tue,  8 Oct 2013 16:21:03 +0530
Message-ID: <1381229464-28017-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

'tegra_gart_pm_ops' is local to this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/tegra-gart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index f75483a..dba1a9f 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -411,7 +411,7 @@ static int tegra_gart_remove(struct platform_device *pdev)
 	return 0;
 }
 
-const struct dev_pm_ops tegra_gart_pm_ops = {
+static const struct dev_pm_ops tegra_gart_pm_ops = {
 	.suspend	= tegra_gart_suspend,
 	.resume		= tegra_gart_resume,
 };
-- 
1.7.9.5
