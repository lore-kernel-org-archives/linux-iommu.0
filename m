From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 4/6] memory: mediatek: Add SMI driver
Date: Mon, 3 Aug 2015 18:21:17 +0800
Message-ID: <1438597279-2937-5-git-send-email-yong.wu@mediatek.com>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438597279-2937-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch add SMI(Smart Multimedia Interface) driver. This driver
is responsible to enable/disable iommu and control the clocks of each
local arbiter

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/memory/Kconfig     |   8 ++
 drivers/memory/Makefile    |   1 +
 drivers/memory/mtk-smi.c   | 285 +++++++++++++++++++++++++++++++++++++++++++++
 include/soc/mediatek/smi.h |  60 ++++++++++
 4 files changed, 354 insertions(+)
 create mode 100644 drivers/memory/mtk-smi.c
 create mode 100644 include/soc/mediatek/smi.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 8406c668..c0e1607 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -100,6 +100,14 @@ config JZ4780_NEMC
 	  the Ingenic JZ4780. This controller is used to handle external
 	  memory devices such as NAND and SRAM.
 
+config MTK_SMI
+	bool
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  This driver is for the Memory Controller module in MediaTek SoCs,
+	  mainly help enable/disable iommu and control the clock for each
+	  local arbiter.
+
 source "drivers/memory/tegra/Kconfig"
 
 endif
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index b670441..f854e40 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_FSL_IFC)		+= fsl_ifc.o
 obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
 obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
+obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
 
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
new file mode 100644
index 0000000..e62cceb
--- /dev/null
+++ b/drivers/memory/mtk-smi.c
@@ -0,0 +1,285 @@
+/*
+ * Copyright (c) 2014-2015 MediaTek Inc.
+ * Author: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <soc/mediatek/smi.h>
+
+#define SMI_LARB_MMU_EN		0xf00
+#define F_SMI_MMU_EN(port)	BIT(port)
+
+struct mtk_smi_common {
+	struct clk		*clk_apb;
+	struct clk		*clk_smi;
+};
+
+struct mtk_smi_larb {
+	void __iomem		*base;
+	struct clk		*clk_apb;
+	struct clk		*clk_smi;
+	struct device		*smi;
+};
+
+struct mtk_larb_mmu {
+	u32			mmu;
+};
+
+static int mtk_smi_common_get(struct device *smidev)
+{
+	struct mtk_smi_common *smipriv = dev_get_drvdata(smidev);
+	int ret;
+
+	ret = pm_runtime_get_sync(smidev);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_prepare_enable(smipriv->clk_apb);
+	if (ret) {
+		dev_err(smidev, "Failed to enable the apb clock\n");
+		goto err_put_pm;
+	}
+	ret = clk_prepare_enable(smipriv->clk_smi);
+	if (ret) {
+		dev_err(smidev, "Failed to enable the smi clock\n");
+		goto err_disable_apb;
+	}
+	return ret;
+
+err_disable_apb:
+	clk_disable_unprepare(smipriv->clk_apb);
+err_put_pm:
+	pm_runtime_put(smidev);
+	return ret;
+}
+
+static void mtk_smi_common_put(struct device *smidev)
+{
+	struct mtk_smi_common *smipriv = dev_get_drvdata(smidev);
+
+	clk_disable_unprepare(smipriv->clk_smi);
+	clk_disable_unprepare(smipriv->clk_apb);
+	pm_runtime_put(smidev);
+}
+
+int mtk_smi_larb_get(struct device *larbdev)
+{
+	struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
+	struct mtk_larb_mmu *mmucfg = larbdev->archdata.iommu;
+	int ret;
+
+	ret = mtk_smi_common_get(larbpriv->smi);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_get_sync(larbdev);
+	if (ret < 0)
+		goto err_put_smicommon;
+
+	ret = clk_prepare_enable(larbpriv->clk_apb);
+	if (ret) {
+		dev_err(larbdev, "Failed to enable the apb clock\n");
+		goto err_put_pm;
+	}
+
+	ret = clk_prepare_enable(larbpriv->clk_smi);
+	if (ret) {
+		dev_err(larbdev, "Failed to enable the smi clock\n");
+		goto err_disable_apb;
+	}
+
+	/* config iommu */
+	writel_relaxed(mmucfg->mmu, larbpriv->base + SMI_LARB_MMU_EN);
+
+	return ret;
+
+err_disable_apb:
+	clk_disable_unprepare(larbpriv->clk_apb);
+err_put_pm:
+	pm_runtime_put(larbdev);
+err_put_smicommon:
+	mtk_smi_common_put(larbpriv->smi);
+	return ret;
+}
+
+void mtk_smi_larb_put(struct device *larbdev)
+{
+	struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
+
+	clk_disable_unprepare(larbpriv->clk_smi);
+	clk_disable_unprepare(larbpriv->clk_apb);
+	pm_runtime_put(larbdev);
+	mtk_smi_common_put(larbpriv->smi);
+}
+
+int mtk_smi_config_port(struct device *larbdev, unsigned int larbportid,
+			bool enable)
+{
+	struct mtk_larb_mmu *mmucfg = larbdev->archdata.iommu;
+
+	if (!mmucfg) {
+		mmucfg = kzalloc(sizeof(*mmucfg), GFP_KERNEL);
+		if (!mmucfg)
+			return -ENOMEM;
+		larbdev->archdata.iommu = mmucfg;
+	}
+
+	dev_dbg(larbdev, "%s iommu port id %d\n",
+		enable ? "enable" : "disable", larbportid);
+
+	if (enable)
+		mmucfg->mmu |= F_SMI_MMU_EN(larbportid);
+	else
+		mmucfg->mmu &= ~F_SMI_MMU_EN(larbportid);
+
+	return 0;
+}
+
+static int mtk_smi_larb_probe(struct platform_device *pdev)
+{
+	struct mtk_smi_larb *larbpriv;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct device_node *smi_node;
+	struct platform_device *smi_pdev;
+
+	larbpriv = devm_kzalloc(dev, sizeof(*larbpriv), GFP_KERNEL);
+	if (!larbpriv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	larbpriv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(larbpriv->base))
+		return PTR_ERR(larbpriv->base);
+
+	larbpriv->clk_apb = devm_clk_get(dev, "apb");
+	if (IS_ERR(larbpriv->clk_apb))
+		return PTR_ERR(larbpriv->clk_apb);
+
+	larbpriv->clk_smi = devm_clk_get(dev, "smi");
+	if (IS_ERR(larbpriv->clk_smi))
+		return PTR_ERR(larbpriv->clk_smi);
+
+	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
+	if (!smi_node)
+		return -EINVAL;
+
+	smi_pdev = of_find_device_by_node(smi_node);
+	of_node_put(smi_node);
+	if (smi_pdev) {
+		larbpriv->smi = &smi_pdev->dev;
+	} else {
+		dev_err(dev, "Failed to get the smi_common device\n");
+		return -EINVAL;
+	}
+
+	pm_runtime_enable(dev);
+	dev_set_drvdata(dev, larbpriv);
+	return 0;
+}
+
+static int mtk_smi_larb_remove(struct platform_device *pdev)
+{
+	struct mtk_larb_mmu *mmucfg = pdev->dev.archdata.iommu;
+
+	kfree(mmucfg);
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id mtk_smi_larb_of_ids[] = {
+	{ .compatible = "mediatek,mt8173-smi-larb",},
+	{}
+};
+
+static struct platform_driver mtk_smi_larb_driver = {
+	.probe	= mtk_smi_larb_probe,
+	.remove = mtk_smi_larb_remove,
+	.driver	= {
+		.name = "mtk-smi-larb",
+		.of_match_table = mtk_smi_larb_of_ids,
+	}
+};
+
+static int mtk_smi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_smi_common *smipriv;
+	int ret;
+
+	smipriv = devm_kzalloc(dev, sizeof(*smipriv), GFP_KERNEL);
+	if (!smipriv)
+		return -ENOMEM;
+
+	smipriv->clk_apb = devm_clk_get(dev, "apb");
+	if (IS_ERR(smipriv->clk_apb))
+		return PTR_ERR(smipriv->clk_apb);
+
+	smipriv->clk_smi = devm_clk_get(dev, "smi");
+	if (IS_ERR(smipriv->clk_smi))
+		return PTR_ERR(smipriv->clk_smi);
+
+	pm_runtime_enable(dev);
+	dev_set_drvdata(dev, smipriv);
+	return ret;
+}
+
+static int mtk_smi_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id mtk_smi_of_ids[] = {
+	{ .compatible = "mediatek,mt8173-smi",},
+	{}
+};
+
+static struct platform_driver mtk_smi_driver = {
+	.probe	= mtk_smi_probe,
+	.remove = mtk_smi_remove,
+	.driver	= {
+		.name = "mtk-smi",
+		.of_match_table = mtk_smi_of_ids,
+	}
+};
+
+static int __init mtk_smi_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mtk_smi_driver);
+	if (ret != 0) {
+		pr_err("Failed to register SMI driver\n");
+		return ret;
+	}
+
+	ret = platform_driver_register(&mtk_smi_larb_driver);
+	if (ret != 0) {
+		pr_err("Failed to register SMI-LARB driver\n");
+		goto err_unreg_smi;
+	}
+	return ret;
+
+err_unreg_smi:
+	platform_driver_unregister(&mtk_smi_driver);
+	return ret;
+}
+
+subsys_initcall(mtk_smi_init);
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
new file mode 100644
index 0000000..189d575
--- /dev/null
+++ b/include/soc/mediatek/smi.h
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) 2014-2015 MediaTek Inc.
+ * Author: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef MTK_IOMMU_SMI_H
+#define MTK_IOMMU_SMI_H
+
+#include <linux/device.h>
+
+#ifdef CONFIG_MTK_SMI
+
+/*
+ * Record the iommu info for each port in the local arbiter.
+ * It is only for iommu.
+ *
+ * Returns 0 if successfully, others if failed.
+ */
+int mtk_smi_config_port(struct device *larbdev, unsigned int larbportid,
+			bool enable);
+/*
+ * The two function below config iommu and enable/disable the clock
+ * for the larb.
+ *
+ * mtk_smi_larb_get must be called before the multimedia HW work.
+ * mtk_smi_larb_put must be called after HW done.
+ * Both should be called in non-atomic context.
+ *
+ * Returns 0 if successfully, others if failed.
+ */
+int mtk_smi_larb_get(struct device *larbdev);
+void mtk_smi_larb_put(struct device *larbdev);
+
+#else
+
+static int
+mtk_smi_config_port(struct device *larbdev, unsigned int larbportid,
+		    bool enable)
+{
+	return 0;
+}
+
+static inline int mtk_smi_larb_get(struct device *larbdev)
+{
+	return 0;
+}
+
+static inline void mtk_smi_larb_put(struct device *larbdev) { }
+
+#endif
+
+#endif
-- 
1.8.1.1.dirty
