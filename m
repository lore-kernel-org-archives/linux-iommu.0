From: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 6/7] regulator: hisilicon: Add hi655x pmic voltage regulator
	driver
Date: Thu, 5 Nov 2015 21:34:47 +0800
Message-ID: <1446730488-31930-7-git-send-email-puck.chen@hisilicon.com>
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

Add driver support for HiSilicon Hi655x voltage regulators.

Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Fei Wang <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/regulator/Kconfig                  |  13 ++
 drivers/regulator/Makefile                 |   2 +
 drivers/regulator/hi655x-regulator.c       | 246 +++++++++++++++++++++++++++++
 include/linux/regulator/hi655x-regulator.h |  63 ++++++++
 4 files changed, 324 insertions(+)
 create mode 100644 drivers/regulator/hi655x-regulator.c
 create mode 100644 include/linux/regulator/hi655x-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 64bccff..9bbd43c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -261,6 +261,19 @@ config REGULATOR_HI6421
 	  21 general purpose LDOs, 3 dedicated LDOs, and 5 BUCKs. All
 	  of them come with support to either ECO (idle) or sleep mode.
 
+config REGULATOR_HI6220_MTCMOS
+        bool "Hisilicon Hi6220 mtcmos support"
+        depends on ARCH_HISI
+        help
+          This driver provides support for the mtcmos regulators of Hi6220 Soc.
+
+config REGULATOR_HI655X
+        bool "HiSilicon Hi655x PMIC voltage regulator support"
+        depends on ARCH_HISI
+        help
+	  This driver provides support for the voltage regulators on the
+	  HiSilicon hi655x PMIC.
+
 config REGULATOR_ISL9305
 	tristate "Intersil ISL9305 regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 0f81749..7345d43 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -34,6 +34,8 @@ obj-$(CONFIG_REGULATOR_DB8500_PRCMU) += db8500-prcmu.o
 obj-$(CONFIG_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_REGULATOR_HI6421) += hi6421-regulator.o
+obj-$(CONFIG_REGULATOR_HI6220_MTCMOS) += hi6220-mtcmos.o
+obj-$(CONFIG_REGULATOR_HI655X) += hi655x-regulator.o
 obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 obj-$(CONFIG_REGULATOR_ISL9305) += isl9305.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
new file mode 100644
index 0000000..b06c810
--- /dev/null
+++ b/drivers/regulator/hi655x-regulator.c
@@ -0,0 +1,246 @@
+/*
+ * Device driver for regulators in hi655x IC
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
+#include <linux/delay.h>
+#include <linux/time.h>
+#include <linux/regulator/hi655x-regulator.h>
+#include <linux/mfd/hi655x-pmic.h>
+#include <linux/regmap.h>
+#include <linux/bitops.h>
+
+static int hi655x_is_enabled(struct regulator_dev *rdev)
+{
+	unsigned int value = 0;
+
+	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
+	struct hi655x_regulator_ctrl_regs *ctrl_regs = &regulator->ctrl_regs;
+
+	regmap_read(rdev->regmap, ctrl_regs->status_reg, &value);
+	return (value & BIT(regulator->ctrl_mask));
+}
+
+static int hi655x_enable(struct regulator_dev *rdev)
+{
+	int ret = 0;
+	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
+	struct hi655x_regulator_ctrl_regs *ctrl_regs = &regulator->ctrl_regs;
+
+	ret = regmap_update_bits(rdev->regmap, ctrl_regs->enable_reg,
+				 regulator->ctrl_mask, regulator->ctrl_mask);
+	return ret;
+}
+
+static int hi655x_disable(struct regulator_dev *rdev)
+{
+	int ret = 0;
+	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
+
+	if (!regulator) {
+		pr_err("get driver data error!\n");
+		return -ENODEV;
+	}
+	struct hi655x_regulator_ctrl_regs *ctrl_regs = &regulator->ctrl_regs;
+
+	ret = regmap_update_bits(rdev->regmap, ctrl_regs->disable_reg,
+				 regulator->ctrl_mask, regulator->ctrl_mask);
+	return ret;
+}
+
+static int hi655x_get_voltage(struct regulator_dev *rdev)
+{
+	unsigned int value = 0;
+	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
+
+	if (!regulator) {
+		pr_err("get driver data error!\n");
+		return -ENODEV;
+	}
+	struct hi655x_regulator_vset_regs *vset_regs = &regulator->vset_regs;
+
+	regmap_read(rdev->regmap, vset_regs->vset_reg, &value);
+
+	return regulator->vset_table[value];
+}
+
+static int hi655x_set_voltage(struct regulator_dev *rdev,
+			      int min_uV, int max_uV, unsigned *selector)
+{
+	int i = 0;
+	int ret = 0;
+	int vol = 0;
+	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
+
+	if (!regulator) {
+		pr_err("get driver data error!\n");
+		return -ENODEV;
+	}
+
+	struct hi655x_regulator_vset_regs *vset_regs = &regulator->vset_regs;
+
+	/**
+	 * search the matched vol and get its index
+	 */
+	for (i = 0; i < regulator->vol_numb; i++) {
+		vol = regulator->vset_table[i];
+		if ((vol >= min_uV) && (vol <= max_uV))
+			break;
+	}
+
+	if (i == regulator->vol_numb)
+		return -1;
+
+	regmap_update_bits(rdev->regmap, vset_regs->vset_reg,
+			   regulator->vset_mask, i);
+	*selector = i;
+
+	return ret;
+}
+
+static unsigned int hi655x_map_mode(unsigned int mode)
+{
+	/* hi655x pmic on hi6220 SoC only support normal mode */
+	if (mode == REGULATOR_MODE_NORMAL)
+		return REGULATOR_MODE_NORMAL;
+	else
+		return -EINVAL;
+}
+
+static int hi655x_set_mode(struct regulator_dev *rdev,
+			   unsigned int mode)
+
+{
+	if (mode == REGULATOR_MODE_NORMAL)
+		return 0;
+	else
+		return -EINVAL;
+}
+
+static struct regulator_ops hi655x_regulator_ops = {
+	.is_enabled = hi655x_is_enabled,
+	.enable = hi655x_enable,
+	.disable = hi655x_disable,
+	.list_voltage = regulator_list_voltage_table,
+	.get_voltage = hi655x_get_voltage,
+	.set_voltage = hi655x_set_voltage,
+	.set_mode = hi655x_set_mode,
+};
+
+static const struct of_device_id of_hi655x_regulator_match_tbl[] = {
+	{
+		.compatible = "hisilicon,hi655x-regulator-pmic",
+	},
+};
+MODULE_DEVICE_TABLE(of, of_hi655x_regulator_match_tbl);
+
+/**
+ * get the hi655x specific data from dt node.
+ */
+static void of_get_hi655x_ctr(struct hi655x_regulator *regulator,
+			      struct device *dev, struct device_node *np)
+{
+	unsigned int *vset_table = NULL;
+
+	of_property_read_u32_array(np, "regulator-ctrl-regs",
+				   (u32 *)&regulator->ctrl_regs, 0x3);
+	of_property_read_u32(np, "regulator-ctrl-mask", &regulator->ctrl_mask);
+	of_property_read_u32(np, "regulator-vset-regs",
+			     (u32 *)&regulator->vset_regs);
+	of_property_read_u32(np, "regulator-vset-mask", &regulator->vset_mask);
+	of_property_read_u32(np, "regulator-n-vol", &regulator->vol_numb);
+	of_property_read_u32(np, "regulator-off-on-delay",
+			     &regulator->rdesc.off_on_delay);
+
+	vset_table = devm_kzalloc(dev, regulator->vol_numb * sizeof(int),
+				  GFP_KERNEL);
+
+	of_property_read_u32_array(np, "regulator-vset-table",
+				   vset_table,
+				   regulator->vol_numb);
+	regulator->vset_table = vset_table;
+	regulator->rdesc.volt_table = vset_table;
+	regulator->rdesc.n_voltages = regulator->vol_numb;
+}
+
+static int hi655x_regulator_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct hi655x_regulator *regulator;
+	struct hi655x_pmic *pmic;
+	struct regulator_init_data *init_data;
+	struct regulator_config config = { };
+	struct device_node *np = pdev->dev.of_node;
+
+	pmic = dev_get_drvdata(pdev->dev.parent);
+	if (!pmic) {
+		pr_err("no pmic in the regulator parent node\n");
+		return -ENODEV;
+	}
+
+	regulator = devm_kzalloc(&pdev->dev, sizeof(*regulator), GFP_KERNEL);
+	if (!regulator)
+		return -ENOMEM;
+	of_get_hi655x_ctr(regulator, &pdev->dev, np);
+
+	regulator->rdesc.name = dev_name(&pdev->dev);
+	regulator->rdesc.type = REGULATOR_VOLTAGE;
+	regulator->rdesc.owner = THIS_MODULE;
+	regulator->rdesc.of_map_mode = hi655x_map_mode;
+	regulator->rdesc.ops = &hi655x_regulator_ops;
+	init_data = of_get_regulator_init_data(&pdev->dev, pdev->dev.of_node,
+					       &regulator->rdesc);
+	if (!init_data) {
+		pr_err("get init data from dts error!\n");
+		return -EINVAL;
+	}
+	config.dev = &pdev->dev;
+	config.init_data = init_data;
+	config.driver_data = regulator;
+	config.regmap = pmic->regmap;
+
+	regulator->regdev = devm_regulator_register(&pdev->dev,
+						    &regulator->rdesc,
+						    &config);
+	if (IS_ERR(regulator->regdev)) {
+		pr_err("register regulator to system error!\n");
+		return PTR_ERR(regulator->regdev);
+	}
+
+	platform_set_drvdata(pdev, regulator);
+	return 0;
+}
+
+static struct platform_driver hi655x_regulator_driver = {
+	.driver = {
+		.name	= "hi655x_regulator",
+		.of_match_table = of_hi655x_regulator_match_tbl,
+	},
+	.probe	= hi655x_regulator_probe,
+};
+module_platform_driver(hi655x_regulator_driver);
+
+MODULE_AUTHOR("Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>");
+MODULE_DESCRIPTION("Hisi hi655x regulator driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regulator/hi655x-regulator.h b/include/linux/regulator/hi655x-regulator.h
new file mode 100644
index 0000000..4a32095
--- /dev/null
+++ b/include/linux/regulator/hi655x-regulator.h
@@ -0,0 +1,63 @@
+/*
+ * Device driver for regulators in HI6553 IC
+ *
+ * Copyright (c) 2015 Hisilicon.
+ *
+ * Fei Wang  <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
+ * Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
+ *
+ * this regulator's probe function will be called lots of times,,
+ * because of there are lots of regulator nodes in dtb.
+ * so,that's say, the driver must be inited before the regulator nodes
+ * registor to system.
+ *
+ * Makefile have proved my guess, please refor to the makefile.
+ * when the code is rebuild i hope we can build pmu sub_system.
+ * init order can not base on compile
+ */
+
+#ifndef __HISI_HI655X_REGULATOR_H__
+#define __HISI_HI655X_REGULATOR_H__
+
+enum hi655x_regulator_type {
+	PMIC_BUCK_TYPE = 0,
+	PMIC_LDO_TYPE = 1,
+	PMIC_LVS_TYPE = 2,
+	PMIC_BOOST_TYPE = 3,
+	MTCMOS_SC_ON_TYPE = 4,
+	MTCMOS_ACPU_ON_TYPE = 5,
+	SCHARGE_TYPE = 6,
+};
+
+struct hi655x_regulator_ctrl_regs {
+	unsigned int  enable_reg;
+	unsigned int  disable_reg;
+	unsigned int  status_reg;
+};
+
+struct hi655x_regulator_vset_regs {
+	unsigned int vset_reg;
+};
+
+struct hi655x_regulator_ctrl_data {
+	int          shift;
+	unsigned int val;
+};
+
+struct hi655x_regulator_vset_data {
+	int          shift;
+	unsigned int mask;
+};
+
+struct hi655x_regulator {
+	struct hi655x_regulator_ctrl_regs ctrl_regs;
+	struct hi655x_regulator_vset_regs vset_regs;
+	u32 ctrl_mask;
+	u32 vset_mask;
+	u32 vol_numb;
+	u32 *vset_table;
+	struct regulator_desc rdesc;
+	struct regulator_dev *regdev;
+};
+
+#endif
-- 
1.9.1
