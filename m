From: <honghui.zhang@mediatek.com>
Subject: [PATCH] memory: mtk-smi: Use of_device_get_match_data helper
Date: Wed, 26 Jul 2017 17:52:05 +0800
Message-ID: <1501062725-8571-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, matthias.bgg@gmail.com, robh@kernel.org, robin.murphy@arm.com
Cc: srv_heupstream@mediatek.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com, erin.lo@mediatek.com, Honghui Zhang <honghui.zhang@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Replace custom code with generic helper to retrieve driver data.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 4afbc41..69249f5 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -240,20 +240,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
-	const struct of_device_id *of_id;
 
 	if (!dev->pm_domain)
 		return -EPROBE_DEFER;
 
-	of_id = of_match_node(mtk_smi_larb_of_ids, pdev->dev.of_node);
-	if (!of_id)
-		return -EINVAL;
-
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
 	if (!larb)
 		return -ENOMEM;
 
-	larb->larb_gen = of_id->data;
+	larb->larb_gen = of_device_get_match_data(dev);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	larb->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(larb->base))
@@ -319,7 +314,6 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_smi *common;
 	struct resource *res;
-	const struct of_device_id *of_id;
 	enum mtk_smi_gen smi_gen;
 
 	if (!dev->pm_domain)
@@ -338,17 +332,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	if (IS_ERR(common->clk_smi))
 		return PTR_ERR(common->clk_smi);
 
-	of_id = of_match_node(mtk_smi_common_of_ids, pdev->dev.of_node);
-	if (!of_id)
-		return -EINVAL;
-
 	/*
 	 * for mtk smi gen 1, we need to get the ao(always on) base to config
 	 * m4u port, and we need to enable the aync clock for transform the smi
 	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
 	 * base.
 	 */
-	smi_gen = (enum mtk_smi_gen)of_id->data;
+	smi_gen = of_device_get_match_data(dev);
 	if (smi_gen == MTK_SMI_GEN1) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		common->smi_ao_base = devm_ioremap_resource(dev, res);
-- 
2.6.4
