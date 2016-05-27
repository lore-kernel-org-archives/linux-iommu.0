From: <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 3/5] memory/mediatek: add support for mt2701
Date: Fri, 27 May 2016 16:56:38 +0800
Message-ID: <1464339400-22559-4-git-send-email-honghui.zhang@mediatek.com>
References: <1464339400-22559-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464339400-22559-1-git-send-email-honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Mediatek SMI has two generations of HW architecture, mt8173 uses the
second generation of SMI HW while mt2701 uses the first generation
HW of SMI.

There's slight differences between the two generations, for generation 2,
the register which control the iommu port access PA or IOVA is at each
larb's register base. But for generation 1, the register is at smi ao
base(smi always on register base).
Besides that, the smi async clock should be prepared and enabled for SMI
generation 1 HW to transform the smi clock into emi clock domain, but is
not needed for SMI generation 2.

This patch add SMI driver for mt2701 which use generation 1 SMI HW.

Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/memory/mtk-smi.c | 168 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 149 insertions(+), 19 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 089091f..0a47382 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -21,19 +21,50 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <soc/mediatek/smi.h>
+#include <dt-bindings/memory/mt2701-larb-port.h>
 
 #define SMI_LARB_MMU_EN		0xf00
+#define REG_SMI_SECUR_CON_BASE		0x5c0
+
+/* every register control 8 port, register offset 0x4 */
+#define REG_SMI_SECUR_CON_OFFSET(id)	(((id) >> 3) << 2)
+#define REG_SMI_SECUR_CON_ADDR(id)	\
+	(REG_SMI_SECUR_CON_BASE + REG_SMI_SECUR_CON_OFFSET(id))
+
+/*
+ * every port have 4 bit to control, bit[port + 3] control virtual or physical,
+ * bit[port + 2 : port + 1] control the domain, bit[port] control the security
+ * or non-security.
+ */
+#define SMI_SECUR_CON_VAL_MSK(id)	(~(0xf << (((id) & 0x7) << 2)))
+#define SMI_SECUR_CON_VAL_VIRT(id)	BIT((((id) & 0x7) << 2) + 3)
+/* mt2701 domain should be set to 3 */
+#define SMI_SECUR_CON_VAL_DOMAIN(id)	(0x3 << ((((id) & 0x7) << 2) + 1))
+
+struct mtk_smi_larb_gen {
+	int port_in_larb[MTK_LARB_NR_MAX + 1];
+	void (*config_port)(struct device *);
+};
 
 struct mtk_smi {
-	struct device	*dev;
-	struct clk	*clk_apb, *clk_smi;
+	struct device			*dev;
+	struct clk			*clk_apb, *clk_smi;
+	struct clk			*clk_async; /*only needed by mt2701*/
+	void __iomem			*smi_ao_base;
 };
 
 struct mtk_smi_larb { /* larb: local arbiter */
-	struct mtk_smi  smi;
-	void __iomem	*base;
-	struct device	*smi_common_dev;
-	u32		*mmu;
+	struct mtk_smi			smi;
+	void __iomem			*base;
+	struct device			*smi_common_dev;
+	const struct mtk_smi_larb_gen	*larb_gen;
+	int				larbid;
+	u32				*mmu;
+};
+
+enum mtk_smi_gen {
+	MTK_SMI_GEN1,
+	MTK_SMI_GEN2
 };
 
 static int mtk_smi_enable(const struct mtk_smi *smi)
@@ -71,6 +102,7 @@ static void mtk_smi_disable(const struct mtk_smi *smi)
 int mtk_smi_larb_get(struct device *larbdev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
+	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
 	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
 	int ret;
 
@@ -87,8 +119,7 @@ int mtk_smi_larb_get(struct device *larbdev)
 	}
 
 	/* Configure the iommu info for this larb */
-	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
-
+	larb_gen->config_port(larbdev);
 	return 0;
 }
 
@@ -124,6 +155,45 @@ mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 	return -ENODEV;
 }
 
+static void mtk_smi_larb_config_port(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
+}
+
+
+static void mtk_smi_larb_config_port_gen1(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
+	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
+	int i, m4u_port_id, larb_port_num;
+	u32 sec_con_val, reg_val;
+
+	m4u_port_id = larb_gen->port_in_larb[larb->larbid];
+	larb_port_num = larb_gen->port_in_larb[larb->larbid + 1]
+			- larb_gen->port_in_larb[larb->larbid];
+
+	for (i = 0; i < larb_port_num; i++, m4u_port_id++) {
+		if (*larb->mmu & BIT(i)) {
+			/* bit[port + 3] controls the virtual or physical */
+			sec_con_val = SMI_SECUR_CON_VAL_VIRT(m4u_port_id);
+		} else {
+			/* do not need to enable m4u for this port */
+			continue;
+		}
+		reg_val = readl(common->smi_ao_base
+			+ REG_SMI_SECUR_CON_ADDR(m4u_port_id));
+		reg_val &= SMI_SECUR_CON_VAL_MSK(m4u_port_id);
+		reg_val |= sec_con_val;
+		reg_val |= SMI_SECUR_CON_VAL_DOMAIN(m4u_port_id);
+		writel(reg_val,
+			common->smi_ao_base
+			+ REG_SMI_SECUR_CON_ADDR(m4u_port_id));
+	}
+}
+
 static void
 mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
 {
@@ -135,6 +205,31 @@ static const struct component_ops mtk_smi_larb_component_ops = {
 	.unbind = mtk_smi_larb_unbind,
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
+	/* mt8173 do not need the port in larb */
+	.config_port = mtk_smi_larb_config_port,
+};
+
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
+	.port_in_larb = {
+		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
+		LARB2_PORT_OFFSET, LARB3_PORT_OFFSET
+	},
+	.config_port = mtk_smi_larb_config_port_gen1,
+};
+
+static const struct of_device_id mtk_smi_larb_of_ids[] = {
+	{
+		.compatible = "mediatek,mt8173-smi-larb",
+		.data = &mtk_smi_larb_mt8173
+	},
+	{
+		.compatible = "mediatek,mt2701-smi-larb",
+		.data = &mtk_smi_larb_mt2701
+	},
+	{}
+};
+
 static int mtk_smi_larb_probe(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb;
@@ -142,14 +237,20 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
+	const struct of_device_id *of_id;
 
 	if (!dev->pm_domain)
 		return -EPROBE_DEFER;
 
+	of_id = of_match_node(mtk_smi_larb_of_ids, pdev->dev.of_node);
+	if (!of_id)
+		return -EINVAL;
+
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
 	if (!larb)
 		return -ENOMEM;
 
+	larb->larb_gen = of_id->data;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	larb->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(larb->base))
@@ -189,24 +290,34 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtk_smi_larb_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-smi-larb",},
-	{}
-};
-
 static struct platform_driver mtk_smi_larb_driver = {
 	.probe	= mtk_smi_larb_probe,
-	.remove = mtk_smi_larb_remove,
+	.remove	= mtk_smi_larb_remove,
 	.driver	= {
 		.name = "mtk-smi-larb",
 		.of_match_table = mtk_smi_larb_of_ids,
 	}
 };
 
+static const struct of_device_id mtk_smi_common_of_ids[] = {
+	{
+		.compatible = "mediatek,mt8173-smi-common",
+		.data = (void *)MTK_SMI_GEN2
+	},
+	{
+		.compatible = "mediatek,mt2701-smi-common",
+		.data = (void *)MTK_SMI_GEN1
+	},
+	{}
+};
+
 static int mtk_smi_common_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_smi *common;
+	struct resource *res;
+	const struct of_device_id *of_id;
+	enum mtk_smi_gen smi_gen;
 
 	if (!dev->pm_domain)
 		return -EPROBE_DEFER;
@@ -224,6 +335,29 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	if (IS_ERR(common->clk_smi))
 		return PTR_ERR(common->clk_smi);
 
+	of_id = of_match_node(mtk_smi_common_of_ids, pdev->dev.of_node);
+	if (!of_id)
+		return -EINVAL;
+
+	/*
+	 * for mtk smi gen 1, we need to get the ao(always on) base to config
+	 * m4u port, and we need to enable the aync clock for transform the smi
+	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
+	 * base.
+	 */
+	smi_gen = (enum mtk_smi_gen)of_id->data;
+	if (smi_gen == MTK_SMI_GEN1) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		common->smi_ao_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(common->smi_ao_base))
+			return PTR_ERR(common->smi_ao_base);
+
+		common->clk_async = devm_clk_get(dev, "async");
+		if (IS_ERR(common->clk_async))
+			return PTR_ERR(common->clk_async);
+
+		clk_prepare_enable(common->clk_async);
+	}
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, common);
 	return 0;
@@ -235,11 +369,6 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtk_smi_common_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-smi-common", },
-	{}
-};
-
 static struct platform_driver mtk_smi_common_driver = {
 	.probe	= mtk_smi_common_probe,
 	.remove = mtk_smi_common_remove,
@@ -270,4 +399,5 @@ err_unreg_smi:
 	platform_driver_unregister(&mtk_smi_common_driver);
 	return ret;
 }
+
 subsys_initcall(mtk_smi_init);
-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
