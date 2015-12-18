From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v7 3/5] memory: mediatek: Add SMI driver
Date: Fri, 18 Dec 2015 16:09:41 +0800
Message-ID: <1450426183-1571-4-git-send-email-yong.wu@mediatek.com>
References: <1450426183-1571-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450426183-1571-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch add SMI(Smart Multimedia Interface) driver. This driver
is responsible to enable/disable iommu and control the power domain
and clocks of each local arbiter.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/memory/Kconfig     |   8 ++
 drivers/memory/Makefile    |   1 +
 drivers/memory/mtk-smi.c   | 268 +++++++++++++++++++++++++++++++++++++++++++++
 include/soc/mediatek/smi.h |  58 ++++++++++
 4 files changed, 335 insertions(+)
 create mode 100644 drivers/memory/mtk-smi.c
 create mode 100644 include/soc/mediatek/smi.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 6f31546..51d5cd2 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -114,6 +114,14 @@ config JZ4780_NEMC
 	  the Ingenic JZ4780. This controller is used to handle external
 	  memory devices such as NAND and SRAM.
 
+config MTK_SMI
+	bool
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  This driver is for the Memory Controller module in MediaTek SoCs,
+	  mainly help enable/disable iommu and control the power domain and
+	  clocks for each local arbiter.
+
 source "drivers/memory/tegra/Kconfig"
 
 endif
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 1c46af5..890bdf4 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -15,5 +15,6 @@ obj-$(CONFIG_FSL_IFC)		+= fsl_ifc.o
 obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
 obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
+obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
 
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
new file mode 100644
index 0000000..3714f604
--- /dev/null
+++ b/drivers/memory/mtk-smi.c
@@ -0,0 +1,268 @@
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
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <soc/mediatek/smi.h>
+
+#define SMI_LARB_MMU_EN		0xf00
+
+struct mtk_smi {
+	struct device	*dev;
+	struct clk	*clk_apb, *clk_smi;
+};
+
+struct mtk_smi_larb { /* larb: local arbiter */
+	struct mtk_smi  smi;
+	void __iomem	*base;
+	struct device	*smi_common_dev;
+	u32		*mmu;
+};
+
+static int mtk_smi_enable(const struct mtk_smi *smi)
+{
+	int ret;
+
+	ret = pm_runtime_get_sync(smi->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_prepare_enable(smi->clk_apb);
+	if (ret)
+		goto err_put_pm;
+
+	ret = clk_prepare_enable(smi->clk_smi);
+	if (ret)
+		goto err_disable_apb;
+
+	return 0;
+
+err_disable_apb:
+	clk_disable_unprepare(smi->clk_apb);
+err_put_pm:
+	pm_runtime_put_sync(smi->dev);
+	return ret;
+}
+
+static void mtk_smi_disable(const struct mtk_smi *smi)
+{
+	clk_disable_unprepare(smi->clk_smi);
+	clk_disable_unprepare(smi->clk_apb);
+	pm_runtime_put_sync(smi->dev);
+}
+
+int mtk_smi_larb_get(struct device *larbdev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
+	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
+	int ret;
+
+	/* Enable the smi-common's power and clocks */
+	ret = mtk_smi_enable(common);
+	if (ret)
+		return ret;
+
+	/* Enable the larb's power and clocks */
+	ret = mtk_smi_enable(&larb->smi);
+	if (ret) {
+		mtk_smi_disable(common);
+		return ret;
+	}
+
+	/* Configure the iommu info */
+	if (larb->mmu)
+		writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
+
+	return 0;
+}
+
+void mtk_smi_larb_put(struct device *larbdev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
+	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
+
+	mtk_smi_disable(&larb->smi);
+	mtk_smi_disable(common);
+}
+
+static int
+mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	struct mtk_smi_iommu *smi_iommu = data;
+	unsigned int         i;
+
+	for (i = 0; i < smi_iommu->larb_nr; i++) {
+		if (dev == smi_iommu->larb_imu[i].dev) {
+			larb->mmu = &smi_iommu->larb_imu[i].mmu;
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
+
+static void
+mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	larb->mmu = NULL;
+}
+
+static const struct component_ops mtk_smi_larb_component_ops = {
+	.bind = mtk_smi_larb_bind,
+	.unbind = mtk_smi_larb_unbind,
+};
+
+static int mtk_smi_larb_probe(struct platform_device *pdev)
+{
+	struct mtk_smi_larb *larb;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct device_node *smi_node;
+	struct platform_device *smi_pdev;
+
+	if (!dev->pm_domain)
+		return -EPROBE_DEFER;
+
+	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
+	if (!larb)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	larb->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(larb->base))
+		return PTR_ERR(larb->base);
+
+	larb->smi.clk_apb = devm_clk_get(dev, "apb");
+	if (IS_ERR(larb->smi.clk_apb))
+		return PTR_ERR(larb->smi.clk_apb);
+
+	larb->smi.clk_smi = devm_clk_get(dev, "smi");
+	if (IS_ERR(larb->smi.clk_smi))
+		return PTR_ERR(larb->smi.clk_smi);
+	larb->smi.dev = dev;
+
+	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
+	if (!smi_node)
+		return -EINVAL;
+
+	smi_pdev = of_find_device_by_node(smi_node);
+	of_node_put(smi_node);
+	if (smi_pdev) {
+		larb->smi_common_dev = &smi_pdev->dev;
+	} else {
+		dev_err(dev, "Failed to get the smi_common device\n");
+		return -EINVAL;
+	}
+
+	pm_runtime_enable(dev);
+	platform_set_drvdata(pdev, larb);
+	return component_add(dev, &mtk_smi_larb_component_ops);
+}
+
+static int mtk_smi_larb_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	component_del(&pdev->dev, &mtk_smi_larb_component_ops);
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
+static int mtk_smi_common_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_smi *common;
+
+	if (!dev->pm_domain)
+		return -EPROBE_DEFER;
+
+	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
+	if (!common)
+		return -ENOMEM;
+	common->dev = dev;
+
+	common->clk_apb = devm_clk_get(dev, "apb");
+	if (IS_ERR(common->clk_apb))
+		return PTR_ERR(common->clk_apb);
+
+	common->clk_smi = devm_clk_get(dev, "smi");
+	if (IS_ERR(common->clk_smi))
+		return PTR_ERR(common->clk_smi);
+
+	pm_runtime_enable(dev);
+	platform_set_drvdata(pdev, common);
+	return 0;
+}
+
+static int mtk_smi_common_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id mtk_smi_common_of_ids[] = {
+	{ .compatible = "mediatek,mt8173-smi-common", },
+	{}
+};
+
+static struct platform_driver mtk_smi_common_driver = {
+	.probe	= mtk_smi_common_probe,
+	.remove = mtk_smi_common_remove,
+	.driver	= {
+		.name = "mtk-smi-common",
+		.of_match_table = mtk_smi_common_of_ids,
+	}
+};
+
+static int __init mtk_smi_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mtk_smi_common_driver);
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
+	platform_driver_unregister(&mtk_smi_common_driver);
+	return ret;
+}
+subsys_initcall(mtk_smi_init);
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
new file mode 100644
index 0000000..6ab11fa
--- /dev/null
+++ b/include/soc/mediatek/smi.h
@@ -0,0 +1,58 @@
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
+#include <linux/bitops.h>
+#include <linux/device.h>
+
+#ifdef CONFIG_MTK_SMI
+
+#define MTK_LARB_NR_MAX		8
+
+#define MTK_SMI_MMU_EN(port)	BIT(port)
+
+struct mtk_smi_larb_iommu {
+	struct device *dev;
+	unsigned int   mmu;
+};
+
+struct mtk_smi_iommu {
+	unsigned int larb_nr;
+	struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
+};
+
+/*
+ * mtk_smi_larb_get: Enable the power domain and clocks for this local arbiter.
+ *                   It also initialize some basic setting(like iommu).
+ * mtk_smi_larb_put: Disable the power domain and clocks for this local arbiter.
+ * Both should be called in non-atomic context.
+ *
+ * Returns 0 if successful, negative on failure.
+ */
+int mtk_smi_larb_get(struct device *larbdev);
+void mtk_smi_larb_put(struct device *larbdev);
+
+#else
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
