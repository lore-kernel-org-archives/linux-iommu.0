From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: [PATCH] msm: iommu: use dev_get_platdata()
Date: Thu, 30 Oct 2014 11:55:11 +0530
Message-ID: <1414650311-24211-1-git-send-email-kiran.padwal@smartplayin.com>
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
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev.c
index 9574d21..b6d01f9 100644
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
 
@@ -263,7 +263,7 @@ static int msm_iommu_remove(struct platform_device *pdev)
 
 static int msm_iommu_ctx_probe(struct platform_device *pdev)
 {
-	struct msm_iommu_ctx_dev *c = pdev->dev.platform_data;
+	struct msm_iommu_ctx_dev *c = dev_get_platdata(&pdev->dev);
 	struct msm_iommu_drvdata *drvdata;
 	struct msm_iommu_ctx_drvdata *ctx_drvdata;
 	int i, ret;
-- 
1.7.9.5
