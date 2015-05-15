From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v2 4/6] soc: mediatek: Add SMI driver
Date: Fri, 15 May 2015 17:43:27 +0800
Message-ID: <1431683009-18158-5-git-send-email-yong.wu@mediatek.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, k.zhang@mediatek.com, youhua.li@mediatek.com, Yong Wu <yong.wu@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

    This patch add SMI(Smart Multimedia Interface) driver. This driver is
responsible to enable/disable iommu and control the clocks of each local arbiter.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/soc/mediatek/Kconfig      |   6 +
 drivers/soc/mediatek/Makefile     |   1 +
 drivers/soc/mediatek/mt8173-smi.c | 298 ++++++++++++++++++++++++++++++++++++++
 include/linux/mtk-smi.h           |  39 +++++
 4 files changed, 344 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8173-smi.c
 create mode 100644 include/linux/mtk-smi.h

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 1d34819..5935ead 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -15,3 +15,9 @@ config MTK_SCPSYS
 	help
 	  Say yes here to add support for the MediaTek SCPSYS power domain
 	  driver.
+
+config MTK_SMI
+	bool
+	help
+	  Smi help enable/disable iommu in MediaTek SoCs and control the clock
+	  for each local arbiter.
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index ce88693..c086261 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
+obj-$(CONFIG_MTK_SMI) += mt8173-smi.o
diff --git a/drivers/soc/mediatek/mt8173-smi.c b/drivers/soc/mediatek/mt8173-smi.c
new file mode 100644
index 0000000..67bccec
--- /dev/null
+++ b/drivers/soc/mediatek/mt8173-smi.c
@@ -0,0 +1,298 @@
+/*
+ * Copyright (c) 2014-2015 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
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
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/mm.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/mtk-smi.h>
+
+#define SMI_LARB_MMU_EN		(0xf00)
+#define F_SMI_MMU_EN(port)	(1 << (port))
+
+enum {
+	MTK_CLK_APB,
+	MTK_CLK_SMI,
+	MTK_CLK_MAX,
+};
+
+struct mtk_smi_common {
+	void __iomem		*base;
+	struct clk		*clk[MTK_CLK_MAX];
+};
+
+struct mtk_smi_larb {
+	void __iomem		*base;
+	spinlock_t		portlock; /* lock for config port */
+	struct clk		*clk[MTK_CLK_MAX];
+	struct device		*smi;
+};
+
+static const char * const mtk_smi_clk_name[MTK_CLK_MAX] = {
+	"apb", "smi"
+};
+
+static int mtk_smi_common_get(struct device *smidev)
+{
+	struct mtk_smi_common *smipriv = dev_get_drvdata(smidev);
+	int i, ret;
+
+	for (i = MTK_CLK_APB; i < MTK_CLK_MAX; i++) {
+		ret = clk_enable(smipriv->clk[i]);
+		if (ret) {
+			dev_err(smidev,
+				"Failed to enable the clock of smi_common\n");
+			goto err_smi_clk;
+		}
+	}
+	return ret;
+
+err_smi_clk:
+	if (i == MTK_CLK_SMI)
+		clk_disable(smipriv->clk[MTK_CLK_APB]);
+	return ret;
+}
+
+static void mtk_smi_common_put(struct device *smidev)
+{
+	struct mtk_smi_common *smipriv = dev_get_drvdata(smidev);
+	int i;
+
+	for (i = MTK_CLK_SMI; i >= MTK_CLK_APB; i--)
+		clk_disable(smipriv->clk[i]);
+}
+
+int mtk_smi_larb_get(struct device *larbdev)
+{
+	struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
+	int i, ret = 0;
+
+	ret = mtk_smi_common_get(larbpriv->smi);
+	if (ret)
+		return ret;
+
+	for (i = MTK_CLK_APB; i < MTK_CLK_MAX; i++) {
+		ret = clk_enable(larbpriv->clk[i]);
+		if (ret) {
+			dev_err(larbdev,
+				"Failed to enable larb clock%d. ret 0x%x\n",
+				i, ret);
+			goto err_larb_clk;
+		}
+	}
+
+	return ret;
+
+err_larb_clk:
+	if (i == MTK_CLK_SMI)
+		clk_disable(larbpriv->clk[MTK_CLK_APB]);
+	mtk_smi_common_put(larbpriv->smi);
+	return ret;
+}
+
+void mtk_smi_larb_put(struct device *larbdev)
+{
+	struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
+	int i;
+
+	for (i = MTK_CLK_SMI; i >= MTK_CLK_APB; i--)
+		clk_disable(larbpriv->clk[i]);
+
+	mtk_smi_common_put(larbpriv->smi);
+}
+
+int mtk_smi_config_port(struct device *larbdev,	unsigned int larbportid,
+			bool iommuen)
+{
+	struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
+	unsigned long flags;
+	int ret;
+	u32 reg;
+
+	ret = mtk_smi_larb_get(larbdev);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&larbpriv->portlock, flags);
+	reg = readl(larbpriv->base + SMI_LARB_MMU_EN);
+	reg &= ~F_SMI_MMU_EN(larbportid);
+	if (iommuen)
+		reg |= F_SMI_MMU_EN(larbportid);
+	writel(reg, larbpriv->base + SMI_LARB_MMU_EN);
+	spin_unlock_irqrestore(&larbpriv->portlock, flags);
+
+	mtk_smi_larb_put(larbdev);
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
+	int i, ret;
+
+	larbpriv = devm_kzalloc(dev, sizeof(struct mtk_smi_larb), GFP_KERNEL);
+	if (!larbpriv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	larbpriv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(larbpriv->base)) {
+		dev_err(dev, "Failed to get the larbbase (0x%lx)\n",
+			PTR_ERR(larbpriv->base));
+		return PTR_ERR(larbpriv->base);
+	}
+
+	for (i = MTK_CLK_APB; i < MTK_CLK_MAX; i++) {
+		larbpriv->clk[i] = devm_clk_get(dev, mtk_smi_clk_name[i]);
+
+		if (IS_ERR(larbpriv->clk[i])) {
+			ret = PTR_ERR(larbpriv->clk[i]);
+			dev_err(dev, "Failed to get larb%d clock (0x%x)\n",
+				i, ret);
+			goto fail_larb_clk;
+		} else {
+			ret = clk_prepare(larbpriv->clk[i]);
+			if (ret) {
+				dev_err(dev, "Failed to prepare larb clock%d (0x%x)\n",
+					i, ret);
+				goto fail_larb_clk;
+			}
+		}
+	}
+
+	smi_node = of_parse_phandle(dev->of_node, "smi", 0);
+	if (!smi_node) {
+		dev_err(dev, "Failed to get smi node\n");
+		ret = -EINVAL;
+		goto fail_larb_clk;
+	}
+
+	smi_pdev = of_find_device_by_node(smi_node);
+	of_node_put(smi_node);
+	if (smi_pdev) {
+		larbpriv->smi = &smi_pdev->dev;
+	} else {
+		dev_err(dev, "Failed to get the smi_common device\n");
+		ret = -EINVAL;
+		goto fail_larb_clk;
+	}
+
+	spin_lock_init(&larbpriv->portlock);
+	dev_set_drvdata(dev, larbpriv);
+	return 0;
+
+fail_larb_clk:
+	while (--i >= MTK_CLK_APB)
+		clk_unprepare(larbpriv->clk[i]);
+	return ret;
+}
+
+static const struct of_device_id mtk_smi_larb_of_ids[] = {
+	{ .compatible = "mediatek,mt8173-smi-larb",
+	},
+	{}
+};
+
+static struct platform_driver mtk_smi_larb_driver = {
+	.probe	= mtk_smi_larb_probe,
+	.driver	= {
+		.name = "mtksmilarb",
+		.of_match_table = mtk_smi_larb_of_ids,
+	}
+};
+
+static int mtk_smi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_smi_common *smipriv;
+	int ret, i;
+
+	smipriv = devm_kzalloc(dev, sizeof(*smipriv), GFP_KERNEL);
+	if (!smipriv)
+		return -ENOMEM;
+
+	for (i = MTK_CLK_APB; i < MTK_CLK_MAX; i++) {
+		smipriv->clk[i] = devm_clk_get(dev, mtk_smi_clk_name[i]);
+
+		if (IS_ERR(smipriv->clk[i])) {
+			ret = PTR_ERR(smipriv->clk[i]);
+			dev_err(dev, "Failed to get smi-%s clock (0x%x)\n",
+				mtk_smi_clk_name[i], ret);
+			goto fail_smi_clk;
+		} else {
+			ret = clk_prepare(smipriv->clk[i]);
+			if (ret) {
+				dev_err(dev, "Failed to prepare smi%d clock 0x%x\n",
+					i, ret);
+				goto fail_smi_clk;
+			}
+		}
+	}
+
+	dev_set_drvdata(dev, smipriv);
+	return ret;
+
+fail_smi_clk:
+	if (i == MTK_CLK_SMI)
+		clk_unprepare(smipriv->clk[MTK_CLK_APB]);
+	return ret;
+}
+
+static const struct of_device_id mtk_smi_of_ids[] = {
+	{ .compatible = "mediatek,mt8173-smi",
+	},
+	{}
+};
+
+static struct platform_driver mtk_smi_driver = {
+	.probe	= mtk_smi_probe,
+	.driver	= {
+		.name = "mtksmi",
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
+		goto fail_smi_larb;
+	}
+	return ret;
+
+fail_smi_larb:
+	platform_driver_unregister(&mtk_smi_driver);
+	return ret;
+}
+
+subsys_initcall(mtk_smi_init);
+
diff --git a/include/linux/mtk-smi.h b/include/linux/mtk-smi.h
new file mode 100644
index 0000000..ad07e6a
--- /dev/null
+++ b/include/linux/mtk-smi.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2014-2015 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
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
+#include <linux/device.h>
+
+/*
+ * Enable iommu for each port, it is only for iommu.
+ *
+ * Returns 0 if successfully, others if failed.
+ */
+int mtk_smi_config_port(struct device *larbdev,	unsigned int larbportid,
+			bool iommuen);
+/*
+ * The multimedia module should call the two function below
+ * which help open/close the clock of the larb.
+ * so the client dtsi should add the larb like "larb = <&larb0>"
+ * to get platform_device.
+ *
+ * mtk_smi_larb_get should be called before the multimedia h/w work.
+ * mtk_smi_larb_put should be called after h/w done.
+ *
+ * Returns 0 if successfully, others if failed.
+ */
+int mtk_smi_larb_get(struct device *plarbdev);
+void mtk_smi_larb_put(struct device *plarbdev);
+
+#endif
-- 
1.8.1.1.dirty
