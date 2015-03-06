From: <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/5] soc: mediatek: Add SMI driver
Date: Fri, 6 Mar 2015 18:37:46 +0800
Message-ID: <1425638270-24903-2-git-send-email-yong.wu@mediatek.com>
References: <1425638270-24903-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425638270-24903-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

    This patch add SMI(Smart Multimedia Interface) driver. This driver 
is responsible to enable/disable iommu and control the clocks of each 
local arbiter.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/soc/mediatek/Kconfig      |   7 ++
 drivers/soc/mediatek/Makefile     |   1 +
 drivers/soc/mediatek/mt8173-smi.c | 143 ++++++++++++++++++++++++++++++++++++++
 include/linux/mtk-smi.h           |  40 +++++++++++
 4 files changed, 191 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8173-smi.c
 create mode 100644 include/linux/mtk-smi.h

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 729f93e..27fb26c 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -20,3 +20,10 @@ config MT8173_PMIC_WRAP
 	  PMIC wrapper is a proprietary hardware in MT8173 to make
 	  communication protocols to access PMIC device.
 	  This driver implement access protocols for MT8173.
+
+config MTK_SMI
+        bool
+	help
+	  Smi help enable/disable iommu in mt8173 and control the
+	  clock of each local arbiter.
+	  It should be true while MTK_IOMMU enable.
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 9b5709b..cdfe95c 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MT8135_PMIC_WRAP)		+= mt8135-pmic-wrap.o
 obj-$(CONFIG_MT8173_PMIC_WRAP)		+= mt8173-pmic-wrap.o
+obj-$(CONFIG_MTK_SMI)                   += mt8173-smi.o
diff --git a/drivers/soc/mediatek/mt8173-smi.c b/drivers/soc/mediatek/mt8173-smi.c
new file mode 100644
index 0000000..4e3fab9
--- /dev/null
+++ b/drivers/soc/mediatek/mt8173-smi.c
@@ -0,0 +1,143 @@
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
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/mm.h>
+
+#define SMI_LARB_MMU_EN                 (0xf00)
+#define F_SMI_MMU_EN(port)              (1 << (port))
+
+struct mtk_smi_larb {
+	void __iomem *larb_base;
+	struct clk *larb_clk[3];/* each larb has 3 clk at most */
+};
+
+static const char * const mtk_smi_clk_name[] = {
+	"larb_sub0", "larb_sub1", "larb_sub2"
+};
+
+static const struct of_device_id mtk_smi_of_ids[] = {
+	{ .compatible = "mediatek,mt8173-smi-larb",
+	},
+	{}
+};
+
+int mtk_smi_larb_get(struct platform_device *plarbdev)
+{
+	struct mtk_smi_larb *larbpriv = dev_get_drvdata(&plarbdev->dev);
+	int i, ret = 0;
+
+	for (i = 0; i < 3; i++)
+		if (larbpriv->larb_clk[i]) {
+			ret = clk_prepare_enable(larbpriv->larb_clk[i]);
+			if (ret) {
+				dev_err(&plarbdev->dev,
+					"failed to enable larbclk%d:%d\n",
+					i, ret);
+				break;
+			}
+		}
+	return ret;
+}
+
+void mtk_smi_larb_put(struct platform_device *plarbdev)
+{
+	struct mtk_smi_larb *larbpriv = dev_get_drvdata(&plarbdev->dev);
+	int i;
+
+	for (i = 2; i >= 0; i--)
+		if (larbpriv->larb_clk[i])
+			clk_disable_unprepare(larbpriv->larb_clk[i]);
+}
+
+int mtk_smi_config_port(struct platform_device *plarbdev,
+			unsigned int larbportid)
+{
+	struct mtk_smi_larb *larbpriv = dev_get_drvdata(&plarbdev->dev);
+	int ret;
+	u32 reg;
+
+	ret = mtk_smi_larb_get(plarbdev);
+	if (ret)
+		return ret;
+
+	reg = readl(larbpriv->larb_base + SMI_LARB_MMU_EN);
+	reg &= ~F_SMI_MMU_EN(larbportid);
+	reg |= F_SMI_MMU_EN(larbportid);
+	writel(reg, larbpriv->larb_base + SMI_LARB_MMU_EN);
+
+	mtk_smi_larb_put(plarbdev);
+
+	return 0;
+}
+
+static int mtk_smi_probe(struct platform_device *pdev)
+{
+	struct mtk_smi_larb *larbpriv;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	unsigned int i;
+
+	larbpriv = devm_kzalloc(dev, sizeof(struct mtk_smi_larb), GFP_KERNEL);
+	if (!larbpriv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	larbpriv->larb_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(larbpriv->larb_base)) {
+		dev_err(dev, "larbbase %p err\n", larbpriv->larb_base);
+		return PTR_ERR(larbpriv->larb_base);
+	}
+
+	for (i = 0; i < 3; i++) {
+		larbpriv->larb_clk[i] = devm_clk_get(dev, mtk_smi_clk_name[i]);
+
+		if (IS_ERR(larbpriv->larb_clk[i])) {
+			if (i == 2) {/* some larb may have only 2 clock */
+				larbpriv->larb_clk[i] = NULL;
+			} else {
+				dev_err(dev, "clock-%d err: %p\n", i,
+					larbpriv->larb_clk[i]);
+				return PTR_ERR(larbpriv->larb_clk[i]);
+			}
+		}
+	}
+	dev_set_drvdata(dev, larbpriv);
+	return 0;
+}
+
+static int mtk_smi_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver mtk_smi_driver = {
+	.probe	= mtk_smi_probe,
+	.remove	= mtk_smi_remove,
+	.driver	= {
+		.name = "mtksmi",
+		.of_match_table = mtk_smi_of_ids,
+	}
+};
+
+static int __init mtk_smi_init(void)
+{
+	return platform_driver_register(&mtk_smi_driver);
+}
+
+subsys_initcall(mtk_smi_init);
+
diff --git a/include/linux/mtk-smi.h b/include/linux/mtk-smi.h
new file mode 100644
index 0000000..1411f7b
--- /dev/null
+++ b/include/linux/mtk-smi.h
@@ -0,0 +1,40 @@
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
+#include <linux/platform_device.h>
+
+/*
+ * Enable iommu for each port, it is only for iommu.
+ *
+ * Returns 0 if successfully, others if failed.
+ */
+int mtk_smi_config_port(struct platform_device *pdev,
+			unsigned int larbportid);
+
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
+int mtk_smi_larb_get(struct platform_device *plarbdev);
+void mtk_smi_larb_put(struct platform_device *plarbdev);
+
+#endif
-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
