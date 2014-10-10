From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: [PATCH] iommu: use dev_get_platdata()
Date: Fri, 10 Oct 2014 19:01:10 +0530
Message-ID: <1412947870-10033-1-git-send-email-kiran.padwal@smartplayin.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kiran Padwal <kiran.padwal@smartplayin.com>
List-Id: iommu@lists.linux-foundation.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
 drivers/iommu/msm_iommu_dev.c |    4 ++--
 drivers/iommu/omap-iommu.c    |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev.c
index 61def7cb..6b16c5c 100644
--- a/drivers/iommu/msm_iommu_dev.c
+++ b/drivers/iommu/msm_iommu_dev.c
@@ -131,7 +131,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	struct clk *iommu_clk;
 	struct clk *iommu_pclk;
 	struct msm_iommu_drvdata *drvdata;
-	struct msm_iommu_dev *iommu_dev = pdev->dev.platform_data;
+	struct msm_iommu_dev *iommu_dev = dev_get_platdata(&pdev->dev);
 	void __iomem *regs_base;
 	int ret, irq, par;
 
@@ -264,7 +264,7 @@ static int msm_iommu_remove(struct platform_device *pdev)
 
 static int msm_iommu_ctx_probe(struct platform_device *pdev)
 {
-	struct msm_iommu_ctx_dev *c = pdev->dev.platform_data;
+	struct msm_iommu_ctx_dev *c = dev_get_platdata(&pdev->dev);
 	struct msm_iommu_drvdata *drvdata;
 	struct msm_iommu_ctx_drvdata *ctx_drvdata;
 	int i, ret;
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3627887..fb9ab86 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -151,7 +151,7 @@ static int iommu_enable(struct omap_iommu *obj)
 {
 	int err;
 	struct platform_device *pdev = to_platform_device(obj->dev);
-	struct iommu_platform_data *pdata = pdev->dev.platform_data;
+	struct iommu_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (!arch_iommu)
 		return -ENODEV;
@@ -174,7 +174,7 @@ static int iommu_enable(struct omap_iommu *obj)
 static void iommu_disable(struct omap_iommu *obj)
 {
 	struct platform_device *pdev = to_platform_device(obj->dev);
-	struct iommu_platform_data *pdata = pdev->dev.platform_data;
+	struct iommu_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	arch_iommu->disable(obj);
 
@@ -934,7 +934,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	int irq;
 	struct omap_iommu *obj;
 	struct resource *res;
-	struct iommu_platform_data *pdata = pdev->dev.platform_data;
+	struct iommu_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *of = pdev->dev.of_node;
 
 	obj = devm_kzalloc(&pdev->dev, sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
-- 
1.7.9.5
