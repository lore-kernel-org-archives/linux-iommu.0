From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 12/18] memory: mtk-smi: Invoke pm runtime_callback to
	enable clocks
Date: Sat, 8 Dec 2018 16:39:25 +0800
Message-ID: <1544258371-4600-13-git-send-email-yong.wu@mediatek.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1544258371-4600-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch only move the clk_prepare_enable and config_port into the
runtime suspend/resume callback. It doesn't change the code content
and sequence.

This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
(SMI_BUS_SEL need to be restored after smi-common resume every time.)
Also it gives a chance to get rid of mtk_smi_larb_get/put which could
be a next topic.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/memory/mtk-smi.c | 113 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 41 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index bced778..ee6165e 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -86,17 +86,13 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	u32				*mmu;
 };
 
-static int mtk_smi_enable(const struct mtk_smi *smi)
+static int mtk_smi_clk_enable(const struct mtk_smi *smi)
 {
 	int ret;
 
-	ret = pm_runtime_get_sync(smi->dev);
-	if (ret < 0)
-		return ret;
-
 	ret = clk_prepare_enable(smi->clk_apb);
 	if (ret)
-		goto err_put_pm;
+		return ret;
 
 	ret = clk_prepare_enable(smi->clk_smi);
 	if (ret)
@@ -118,59 +114,28 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 	clk_disable_unprepare(smi->clk_smi);
 err_disable_apb:
 	clk_disable_unprepare(smi->clk_apb);
-err_put_pm:
-	pm_runtime_put_sync(smi->dev);
 	return ret;
 }
 
-static void mtk_smi_disable(const struct mtk_smi *smi)
+static void mtk_smi_clk_disable(const struct mtk_smi *smi)
 {
 	clk_disable_unprepare(smi->clk_gals1);
 	clk_disable_unprepare(smi->clk_gals0);
 	clk_disable_unprepare(smi->clk_smi);
 	clk_disable_unprepare(smi->clk_apb);
-	pm_runtime_put_sync(smi->dev);
 }
 
 int mtk_smi_larb_get(struct device *larbdev)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
-	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
-	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
-	int ret;
+	int ret = pm_runtime_get_sync(larbdev);
 
-	/* Enable the smi-common's power and clocks */
-	ret = mtk_smi_enable(common);
-	if (ret)
-		return ret;
-
-	/* Enable the larb's power and clocks */
-	ret = mtk_smi_enable(&larb->smi);
-	if (ret) {
-		mtk_smi_disable(common);
-		return ret;
-	}
-
-	/* Configure the iommu info for this larb */
-	larb_gen->config_port(larbdev);
-
-	return 0;
+	return (ret < 0) ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
 
 void mtk_smi_larb_put(struct device *larbdev)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
-	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
-
-	/*
-	 * Don't de-configure the iommu info for this larb since there may be
-	 * several modules in this larb.
-	 * The iommu info will be reset after power off.
-	 */
-
-	mtk_smi_disable(&larb->smi);
-	mtk_smi_disable(common);
+	pm_runtime_put_sync(larbdev);
 }
 EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
 
@@ -384,12 +349,52 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
+	int ret;
+
+	/* Power on smi-common. */
+	ret = pm_runtime_get_sync(larb->smi_common_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
+		return ret;
+	}
+
+	ret = mtk_smi_clk_enable(&larb->smi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable clock(%d).\n", ret);
+		pm_runtime_put_sync(larb->smi_common_dev);
+		return ret;
+	}
+
+	/* Configure the basic setting for this larb */
+	larb_gen->config_port(dev);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	mtk_smi_clk_disable(&larb->smi);
+	pm_runtime_put_sync(larb->smi_common_dev);
+	return 0;
+}
+
+static const struct dev_pm_ops smi_larb_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
+};
+
 static struct platform_driver mtk_smi_larb_driver = {
 	.probe	= mtk_smi_larb_probe,
 	.remove	= mtk_smi_larb_remove,
 	.driver	= {
 		.name = "mtk-smi-larb",
 		.of_match_table = mtk_smi_larb_of_ids,
+		.pm             = &smi_larb_pm_ops,
 	}
 };
 
@@ -488,12 +493,38 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_smi_common_resume(struct device *dev)
+{
+	struct mtk_smi *common = dev_get_drvdata(dev);
+	int ret;
+
+	ret = mtk_smi_clk_enable(common);
+	if (ret) {
+		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
+{
+	struct mtk_smi *common = dev_get_drvdata(dev);
+
+	mtk_smi_clk_disable(common);
+	return 0;
+}
+
+static const struct dev_pm_ops smi_common_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
+};
+
 static struct platform_driver mtk_smi_common_driver = {
 	.probe	= mtk_smi_common_probe,
 	.remove = mtk_smi_common_remove,
 	.driver	= {
 		.name = "mtk-smi-common",
 		.of_match_table = mtk_smi_common_of_ids,
+		.pm             = &smi_common_pm_ops,
 	}
 };
 
-- 
1.9.1
