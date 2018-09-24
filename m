From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 10/14] memory: mtk-smi: Add bus_sel for mt8183
Date: Mon, 24 Sep 2018 16:58:50 +0800
Message-ID: <1537779534-23575-11-git-send-email-yong.wu@mediatek.com>
References: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1537779534-23575-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
mmu0 or mmu1 to balance the bandwidth via the smi-common register
SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).

In mt8183, For better performance, we switch larb1/2/3/7 to enter
mmu1 while the others still keep enter mmu0.

In mt8173 and mt2712, we don't get the performance issue,
Keep its default value(0x0), that means all the larbs enter mmu0.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/memory/mtk-smi.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 3e6e0a8..e4daabb 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -49,6 +49,12 @@
 #define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
 #define F_MMU_EN		BIT(0)
 
+/* SMI COMMON */
+#define SMI_BUS_SEL			0x220
+#define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
+/* All are MMU0 defaultly. Only specialize mmu1 here. */
+#define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
+
 enum mtk_smi_gen {
 	MTK_SMI_GEN1,
 	MTK_SMI_GEN2
@@ -56,6 +62,8 @@ enum mtk_smi_gen {
 
 struct mtk_smi_common_plat {
 	enum mtk_smi_gen gen;
+
+	u32 bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
 };
 
 struct mtk_smi_larb_gen {
@@ -70,8 +78,8 @@ struct mtk_smi {
 	struct clk			*clk_apb, *clk_smi;
 	struct clk			*clk_gals0, *clk_gals1;
 	struct clk			*clk_async; /*only needed by mt2701*/
-	void __iomem			*smi_ao_base;
-
+	void __iomem			*smi_ao_base; /* only for gen1 */
+	void __iomem			*base;	      /* only for gen2 */
 	const struct mtk_smi_common_plat *plat;
 };
 
@@ -401,6 +409,12 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 	.gen = MTK_SMI_GEN2,
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
+	.gen = MTK_SMI_GEN2,
+	.bus_sel = F_MMU1_LARB(1) | F_MMU1_LARB(3) | F_MMU1_LARB(4) |
+		   F_MMU1_LARB(7),
+};
+
 static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{
 		.compatible = "mediatek,mt8173-smi-common",
@@ -416,7 +430,7 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 	},
 	{
 		.compatible = "mediatek,mt8183-smi-common",
-		.data = &mtk_smi_common_gen2,
+		.data = &mtk_smi_common_mt8183,
 	},
 	{}
 };
@@ -473,6 +487,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(common->clk_async);
 		if (ret)
 			return ret;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		common->base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(common->base))
+			return PTR_ERR(common->base);
 	}
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, common);
@@ -488,6 +507,7 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 {
 	struct mtk_smi *common = dev_get_drvdata(dev);
+	u32 bus_sel = common->plat->bus_sel;
 	int ret;
 
 	ret = mtk_smi_clk_enable(common);
@@ -495,6 +515,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
 		return ret;
 	}
+
+	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
+		writel(bus_sel, common->base + SMI_BUS_SEL);
 	return 0;
 }
 
-- 
1.9.1
