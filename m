From: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 5/7] regulator: add driver for mtcmos voltage regulator on
	hi6220 SoC
Date: Thu, 5 Nov 2015 21:34:46 +0800
Message-ID: <1446730488-31930-6-git-send-email-puck.chen@hisilicon.com>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446730488-31930-1-git-send-email-puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, xuyiping-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, yudongbin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, weidong2-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, saberlily.xia-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, haojian.zhuang-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, peter.panshilin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, qijiwen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add driver to support mtcmos on hi6220

Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Fei Wang <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/regulator/hi6220-mtcmos.c | 245 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)
 create mode 100644 drivers/regulator/hi6220-mtcmos.c

diff --git a/drivers/regulator/hi6220-mtcmos.c b/drivers/regulator/hi6220-mtcmos.c
new file mode 100644
index 0000000..c79ffc0
--- /dev/null
+++ b/drivers/regulator/hi6220-mtcmos.c
@@ -0,0 +1,245 @@
+/*
+ * Device driver for regulators in hi6220 mtcmos
+ *
+ * Copyright (c) 2015 Hisilicon.
+ *
+ * Fei Wang <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
+ * Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/sizes.h>
+
+enum {
+	HI6220_MTCMOS1,
+	HI6220_MTCMOS2,
+	HI6220_RG_MAX,
+};
+
+struct hi6220_mtcmos_ctrl_regs {
+	unsigned int enable_reg;
+	unsigned int disable_reg;
+	unsigned int status_reg;
+};
+
+struct hi6220_mtcmos_ctrl_data {
+	int shift;
+	unsigned int mask;
+};
+
+struct hi6220_mtcmos_info {
+	struct regulator_desc rdesc;
+	struct hi6220_mtcmos_ctrl_regs ctrl_regs;
+	struct hi6220_mtcmos_ctrl_data ctrl_data;
+};
+
+struct hi6220_mtcmos {
+	struct regulator_dev *rdev[HI6220_RG_MAX];
+	void __iomem *sc_on_regs;
+};
+
+static int hi6220_mtcmos_is_on(struct hi6220_mtcmos *mtcmos,
+			       unsigned int regs, unsigned int mask, int shift)
+{
+	unsigned int ret;
+
+	ret = readl(mtcmos->sc_on_regs + regs);
+	ret &= (mask << shift);
+
+	return ret;
+}
+
+static int hi6220_mtcmos_is_enabled(struct regulator_dev *rdev)
+{
+	int ret;
+	struct hi6220_mtcmos_info *sreg = rdev_get_drvdata(rdev);
+	struct platform_device *pdev =
+		container_of(rdev->dev.parent, struct platform_device, dev);
+	struct hi6220_mtcmos *mtcmos = platform_get_drvdata(pdev);
+	struct hi6220_mtcmos_ctrl_regs *ctrl_regs = &sreg->ctrl_regs;
+	struct hi6220_mtcmos_ctrl_data *ctrl_data = &sreg->ctrl_data;
+
+	ret = hi6220_mtcmos_is_on(mtcmos, ctrl_regs->status_reg,
+				  ctrl_data->mask, ctrl_data->shift);
+	return ret;
+}
+
+static int hi6220_mtcmos_op(struct hi6220_mtcmos *mtcmos,
+		      unsigned int regs, unsigned int mask, int shift)
+{
+	writel(mask << shift, mtcmos->sc_on_regs + regs);
+
+	return 0;
+}
+
+static int hi6220_mtcmos_enable(struct regulator_dev *rdev)
+{
+	int ret;
+	struct hi6220_mtcmos_info *sreg = rdev_get_drvdata(rdev);
+	struct platform_device *pdev =
+		container_of(rdev->dev.parent, struct platform_device, dev);
+	struct hi6220_mtcmos *mtcmos = platform_get_drvdata(pdev);
+	struct hi6220_mtcmos_ctrl_regs *ctrl_regs = &sreg->ctrl_regs;
+	struct hi6220_mtcmos_ctrl_data *ctrl_data = &sreg->ctrl_data;
+
+	hi6220_mtcmos_op(mtcmos, ctrl_regs->enable_reg,
+			 ctrl_data->mask, ctrl_data->shift);
+	ret =  hi6220_mtcmos_is_on(mtcmos, ctrl_regs->status_reg,
+				   ctrl_data->mask, ctrl_data->shift)
+	return ret;
+}
+
+static int hi6220_mtcmos_disable(struct regulator_dev *rdev)
+{
+	int ret;
+	struct hi6220_mtcmos_info *sreg = rdev_get_drvdata(rdev);
+	struct platform_device *pdev =
+		container_of(rdev->dev.parent, struct platform_device, dev);
+	struct hi6220_mtcmos *mtcmos = platform_get_drvdata(pdev);
+	struct hi6220_mtcmos_ctrl_regs  *ctrl_regs = &sreg->ctrl_regs;
+	struct hi6220_mtcmos_ctrl_data  *ctrl_data = &sreg->ctrl_data;
+
+	ret = hi6220_mtcmos_op(mtcmos, ctrl_regs->disable_reg,
+			       ctrl_data->mask, ctrl_data->shift);
+
+	return ret;
+}
+
+static struct regulator_ops hi6220_mtcmos_mtcmos_rops = {
+	.is_enabled = hi6220_mtcmos_is_enabled,
+	.enable = hi6220_mtcmos_enable,
+	.disable = hi6220_mtcmos_disable,
+};
+
+#define HI6220_MTCMOS(vreg) \
+{								\
+	.rdesc = {					\
+		.name = #vreg,			\
+		.ops	= &hi6220_mtcmos_mtcmos_rops, \
+		.type = REGULATOR_VOLTAGE,			\
+		.owner = THIS_MODULE,		\
+	},							\
+}
+
+static struct hi6220_mtcmos_info hi6220_mtcmos_info[] = {
+	HI6220_MTCMOS(MTCMOS1),
+	HI6220_MTCMOS(MTCMOS2),
+};
+
+static struct of_regulator_match hi6220_mtcmos_matches[] = {
+	{ .name = "mtcmos1",
+		.driver_data = &hi6220_mtcmos_info[HI6220_MTCMOS1], },
+	{ .name = "mtcmos2",
+		.driver_data = &hi6220_mtcmos_info[HI6220_MTCMOS2], },
+};
+
+static int hi6220_mtcmos_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct hi6220_mtcmos *mtcmos;
+	const __be32 *sc_on_regs = NULL;
+	void __iomem	*regs;
+	struct device *dev;
+	struct device_node *np, *child;
+	int i;
+	struct regulator_config config = { };
+	struct regulator_init_data *init_data;
+	struct hi6220_mtcmos_info *sreg;
+	u32 off_on_delay = 0;
+
+	dev = &pdev->dev;
+	np = dev->of_node;
+	mtcmos = devm_kzalloc(dev, sizeof(struct hi6220_mtcmos), GFP_KERNEL);
+	if (!mtcmos)
+		return -ENOMEM;
+
+	sc_on_regs = of_get_property(np, "hisilicon,mtcmos-sc-on-base", NULL);
+	if (sc_on_regs) {
+		regs = ioremap(be32_to_cpu(*sc_on_regs), SZ_4K);
+		mtcmos->sc_on_regs = regs;
+	} else
+		return -ENODEV;
+	of_property_read_u32(np, "hisilicon,mtcmos-steady-us", &off_on_delay);
+
+	for (i = 0; i < HI6220_RG_MAX; i++) {
+		init_data = hi6220_mtcmos_matches[i].init_data;
+		if (!init_data)
+			continue;
+		sreg = hi6220_mtcmos_matches[i].driver_data;
+		sreg->rdesc.off_on_delay = off_on_delay;
+		config.dev = &pdev->dev;
+		config.init_data = init_data;
+		config.driver_data = sreg;
+		config.of_node = hi6220_mtcmos_matches[i].of_node;
+		child = config.of_node;
+
+		ret = of_property_read_u32_array(child, "hisilicon,ctrl-regs",
+						 (u32 *)(&sreg->ctrl_regs),
+						 0x3);
+		ret = of_property_read_u32_array(child, "hisilicon,ctrl-data",
+						 (u32 *)(&sreg->ctrl_data),
+						 0x2);
+
+		mtcmos->rdev[i] = regulator_register(&sreg->rdesc, &config);
+		if (IS_ERR(mtcmos->rdev[i])) {
+			ret = PTR_ERR(mtcmos->rdev[i]);
+			dev_err(&pdev->dev, "failed to register mtcmos %s\n",
+				sreg->rdesc.name);
+			while (--i >= 0)
+				regulator_unregister(mtcmos->rdev[i]);
+
+			return ret;
+		}
+	}
+
+	platform_set_drvdata(pdev, mtcmos);
+
+	return 0;
+}
+
+static const struct of_device_id of_hi6220_mtcmos_match_tbl[] = {
+	{ .compatible = "hisilicon,hi6220-mtcmos-driver", },
+	{}
+};
+
+static struct platform_driver mtcmos_driver = {
+	.driver = {
+		.name = "hisi_hi6220_mtcmos",
+		.owner = THIS_MODULE,
+		.of_match_table = of_hi6220_mtcmos_match_tbl,
+	},
+	.probe = hi6220_mtcmos_probe,
+};
+
+static int __init hi6220_mtcmos_init(void)
+{
+	return platform_driver_register(&mtcmos_driver);
+}
+
+static void __exit hi6220_mtcmos_exit(void)
+{
+	platform_driver_unregister(&mtcmos_driver);
+}
+
+fs_initcall(hi6220_mtcmos_init);
+module_exit(hi6220_mtcmos_exit);
+
+MODULE_AUTHOR("Fei Wang <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("Hi6220 mtcmos interface driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
