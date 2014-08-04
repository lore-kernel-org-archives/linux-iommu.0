From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH] iommu/msm: Switch to using managed resources
Date: Mon,  4 Aug 2014 17:37:37 +0530
Message-ID: <1407154057-25440-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, Joerg Roedel <joro@8bytes.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

This switches the driver to using managed resources to simplify error
handling and to do away with remove function.

CC: Stepan Moskovchenko <stepanm@codeaurora.org>
CC: Joerg Roedel <joro@8bytes.org>
CC: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/iommu/msm_iommu_dev.c |   76 +++++++++++------------------------------
 1 file changed, 19 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev.c
index 61def7cb..38a538f 100644
--- a/drivers/iommu/msm_iommu_dev.c
+++ b/drivers/iommu/msm_iommu_dev.c
@@ -140,39 +140,29 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		return 0;
 	}
 
-	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
-
-	if (!drvdata) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!iommu_dev)
+		return -ENOMEM;
 
-	if (!iommu_dev) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
 
-	iommu_pclk = clk_get(NULL, "smmu_pclk");
-	if (IS_ERR(iommu_pclk)) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	iommu_pclk = devm_clk_get(&pdev->dev, "smmu_pclk");
+	if (IS_ERR(iommu_pclk))
+		return -ENODEV;
 
 	ret = clk_prepare_enable(iommu_pclk);
 	if (ret)
-		goto fail_enable;
-
-	iommu_clk = clk_get(&pdev->dev, "iommu_clk");
+		return ret;
 
+	iommu_clk = devm_clk_get(&pdev->dev, "iommu_clk");
 	if (!IS_ERR(iommu_clk))	{
 		if (clk_get_rate(iommu_clk) == 0)
 			clk_set_rate(iommu_clk, 1);
 
 		ret = clk_prepare_enable(iommu_clk);
-		if (ret) {
-			clk_put(iommu_clk);
+		if (ret)
 			goto fail_pclk;
-		}
 	} else
 		iommu_clk = NULL;
 
@@ -205,14 +195,13 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		goto fail_clk;
 	}
 
-	ret = request_irq(irq, msm_iommu_fault_handler, 0,
+	ret = devm_request_irq(&pdev->dev, irq, msm_iommu_fault_handler, 0,
 			"msm_iommu_secure_irpt_handler", drvdata);
 	if (ret) {
 		pr_err("Request IRQ %d failed with ret=%d\n", irq, ret);
 		goto fail_clk;
 	}
 
-
 	drvdata->pclk = iommu_pclk;
 	drvdata->clk = iommu_clk;
 	drvdata->base = regs_base;
@@ -231,16 +220,10 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	return 0;
 fail_clk:
-	if (iommu_clk) {
+	if (iommu_clk)
 		clk_disable(iommu_clk);
-		clk_put(iommu_clk);
-	}
 fail_pclk:
 	clk_disable_unprepare(iommu_pclk);
-fail_enable:
-	clk_put(iommu_pclk);
-fail:
-	kfree(drvdata);
 	return ret;
 }
 
@@ -250,14 +233,9 @@ static int msm_iommu_remove(struct platform_device *pdev)
 
 	drv = platform_get_drvdata(pdev);
 	if (drv) {
-		if (drv->clk) {
+		if (drv->clk)
 			clk_unprepare(drv->clk);
-			clk_put(drv->clk);
-		}
 		clk_unprepare(drv->pclk);
-		clk_put(drv->pclk);
-		memset(drv, 0, sizeof(*drv));
-		kfree(drv);
 	}
 	return 0;
 }
@@ -276,7 +254,8 @@ static int msm_iommu_ctx_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENODEV;
 
-	ctx_drvdata = kzalloc(sizeof(*ctx_drvdata), GFP_KERNEL);
+	ctx_drvdata = devm_kzalloc(&pdev->dev, sizeof(*ctx_drvdata),
+				   GFP_KERNEL);
 	if (!ctx_drvdata)
 		return -ENOMEM;
 
@@ -288,14 +267,12 @@ static int msm_iommu_ctx_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(drvdata->pclk);
 	if (ret)
-		goto fail;
+		return ret;
 
 	if (drvdata->clk) {
 		ret = clk_prepare_enable(drvdata->clk);
-		if (ret) {
+		if (ret)
 			clk_disable_unprepare(drvdata->pclk);
-			goto fail;
-		}
 	}
 
 	/* Program the M2V tables for this context */
@@ -329,20 +306,6 @@ static int msm_iommu_ctx_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "context %s using bank %d\n", c->name, c->num);
 	return 0;
-fail:
-	kfree(ctx_drvdata);
-	return ret;
-}
-
-static int msm_iommu_ctx_remove(struct platform_device *pdev)
-{
-	struct msm_iommu_ctx_drvdata *drv = NULL;
-	drv = platform_get_drvdata(pdev);
-	if (drv) {
-		memset(drv, 0, sizeof(struct msm_iommu_ctx_drvdata));
-		kfree(drv);
-	}
-	return 0;
 }
 
 static struct platform_driver msm_iommu_driver = {
@@ -350,7 +313,7 @@ static struct platform_driver msm_iommu_driver = {
 		.name	= "msm_iommu",
 	},
 	.probe		= msm_iommu_probe,
-	.remove		= msm_iommu_remove,
+	.remove         = msm_iommu_remove,
 };
 
 static struct platform_driver msm_iommu_ctx_driver = {
@@ -358,7 +321,6 @@ static struct platform_driver msm_iommu_ctx_driver = {
 		.name	= "msm_iommu_ctx",
 	},
 	.probe		= msm_iommu_ctx_probe,
-	.remove		= msm_iommu_ctx_remove,
 };
 
 static int __init msm_iommu_driver_init(void)
-- 
1.7.9.5
