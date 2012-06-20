From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] iommu/tegra: gart: Remove unnecessary cleanup with devm_*()
Date: Wed, 20 Jun 2012 10:04:32 +0300
Message-ID: <1340175873-12531-1-git-send-email-hdoyu@nvidia.com>
References: <1340054045.1367.31.camel@tellur>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340054045.1367.31.camel@tellur>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Remove unnecessary cleanup procedures with devm_*().

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
---
 drivers/iommu/tegra-gart.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 0c0a377..33a23b6 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -345,7 +345,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	struct gart_device *gart;
 	struct resource *res, *res_remap;
 	void __iomem *gart_regs;
-	int err;
 	struct device *dev = &pdev->dev;
 
 	if (gart_handle)
@@ -370,8 +369,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart_regs = devm_ioremap(dev, res->start, resource_size(res));
 	if (!gart_regs) {
 		dev_err(dev, "failed to remap GART registers\n");
-		err = -ENXIO;
-		goto fail;
+		return -ENXIO;
 	}
 
 	gart->dev = &pdev->dev;
@@ -385,8 +383,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->savedata = vmalloc(sizeof(u32) * gart->page_count);
 	if (!gart->savedata) {
 		dev_err(dev, "failed to allocate context save area\n");
-		err = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(pdev, gart);
@@ -394,27 +391,14 @@ static int tegra_gart_probe(struct platform_device *pdev)
 
 	gart_handle = gart;
 	return 0;
-
-fail:
-	if (gart_regs)
-		devm_iounmap(dev, gart_regs);
-	if (gart && gart->savedata)
-		vfree(gart->savedata);
-	devm_kfree(dev, gart);
-	return err;
 }
 
 static int tegra_gart_remove(struct platform_device *pdev)
 {
 	struct gart_device *gart = platform_get_drvdata(pdev);
-	struct device *dev = gart->dev;
 
 	writel(0, gart->regs + GART_CONFIG);
-	if (gart->savedata)
-		vfree(gart->savedata);
-	if (gart->regs)
-		devm_iounmap(dev, gart->regs);
-	devm_kfree(dev, gart);
+	vfree(gart->savedata);
 	gart_handle = NULL;
 	return 0;
 }
-- 
1.7.5.4
