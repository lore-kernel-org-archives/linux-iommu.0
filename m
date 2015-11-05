From: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 4/7] mfd: hi655x: Add hi665x pmic driver
Date: Thu, 5 Nov 2015 21:34:45 +0800
Message-ID: <1446730488-31930-5-git-send-email-puck.chen@hisilicon.com>
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

Add pmic driver to support hisilicon hi665x pmic.

Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Fei Wang <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/mfd/Kconfig             |   9 ++
 drivers/mfd/Makefile            |   1 +
 drivers/mfd/hi655x-pmic.c       | 315 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/hi655x-pmic.h |  50 +++++++
 4 files changed, 375 insertions(+)
 create mode 100644 drivers/mfd/hi655x-pmic.c
 create mode 100644 include/linux/mfd/hi655x-pmic.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 99d6367..c805071 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -273,6 +273,15 @@ config MFD_HI6421_PMIC
 	  menus in order to enable them.
 	  We communicate with the Hi6421 via memory-mapped I/O.
 
+config MFD_HI655X_PMIC
+        bool "HiSilicon Hi655X series PMU/Codec IC"
+        depends on ARCH_HISI
+        depends on OF
+        select MFD_CORE
+        select REGMAP_MMIO
+        help
+          Select this option to enable Hisilicon hi655x series pmic driver.
+
 config HTC_EGPIO
 	bool "HTC EGPIO support"
 	depends on GPIOLIB && ARM
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a59e3fc..11ec427 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -185,6 +185,7 @@ obj-$(CONFIG_MFD_STW481X)	+= stw481x.o
 obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
+obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
 obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
new file mode 100644
index 0000000..942f96e
--- /dev/null
+++ b/drivers/mfd/hi655x-pmic.c
@@ -0,0 +1,315 @@
+/*
+ * Device driver for PMIC DRIVER in HI655X IC
+ *
+ * Copyright (c) 2015 Hisilicon Co. Ltd
+ *
+ * Fei Wang  <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
+ * Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
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
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/hardirq.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/irqdomain.h>
+#include <linux/mfd/hi655x-pmic.h>
+#include <linux/regmap.h>
+
+static const struct of_device_id of_hi655x_pmic_child_match_tbl[] = {
+	{ .compatible = "hisilicon,hi655x-regulator-pmic", },
+	{},
+};
+
+static const struct of_device_id of_hi655x_pmic_match_tbl[] = {
+	{ .compatible = "hisilicon,hi655x-pmic-driver", },
+	{},
+};
+
+static unsigned int hi655x_pmic_get_version(struct hi655x_pmic *pmic)
+{
+	u32 val;
+
+	regmap_read(pmic->regmap,
+		    HI655X_REG_TO_BUS_ADDR(HI655X_VER_REG), &val);
+
+	return val;
+}
+
+static irqreturn_t hi655x_pmic_irq_handler(int irq, void *data)
+{
+	struct hi655x_pmic *pmic = (struct hi655x_pmic *)data;
+	u32 pending;
+	u32 ret = IRQ_NONE;
+	unsigned long offset;
+	int i;
+
+	for (i = 0; i < HI655X_IRQ_ARRAY; i++) {
+		regmap_read(pmic->regmap,
+			    HI655X_REG_TO_BUS_ADDR(i + HI655X_IRQ_STAT_BASE),
+			    &pending);
+		if (pending)
+			pr_debug("pending[%d]=0x%x\n\r", i, pending);
+
+		/* clear pmic-sub-interrupt */
+		regmap_write(pmic->regmap,
+			     HI655X_REG_TO_BUS_ADDR(i + HI655X_IRQ_STAT_BASE),
+			     pending);
+
+		if (pending) {
+			for_each_set_bit(offset, (unsigned long *)&pending,
+					 HI655X_BITS)
+				generic_handle_irq(pmic->irqs[offset +
+						   i * HI655X_BITS]);
+			ret = IRQ_HANDLED;
+		}
+	}
+	return ret;
+}
+
+static void hi655x_pmic_irq_mask(struct irq_data *d)
+{
+	u32 data, offset;
+	unsigned long pmic_spin_flag = 0;
+	struct hi655x_pmic *pmic = irq_data_get_irq_chip_data(d);
+
+	offset = ((irqd_to_hwirq(d) >> 3) + HI655X_IRQ_MASK_BASE);
+	spin_lock_irqsave(&pmic->ssi_hw_lock, pmic_spin_flag);
+	regmap_read(pmic->regmap, HI655X_REG_TO_BUS_ADDR(offset), &data);
+	data |= (1 << (irqd_to_hwirq(d) & 0x07));
+	regmap_write(pmic->regmap, HI655X_REG_TO_BUS_ADDR(offset), data);
+	spin_unlock_irqrestore(&pmic->ssi_hw_lock, pmic_spin_flag);
+}
+
+static void hi655x_pmic_irq_unmask(struct irq_data *d)
+{
+	u32 data, offset;
+	unsigned long pmic_spin_flag = 0;
+	struct hi655x_pmic *pmic = irq_data_get_irq_chip_data(d);
+
+	offset = ((irqd_to_hwirq(d) >> 3) + HI655X_IRQ_MASK_BASE);
+	spin_lock_irqsave(&pmic->ssi_hw_lock, pmic_spin_flag);
+	regmap_read(pmic->regmap, HI655X_REG_TO_BUS_ADDR(offset), &data);
+	data &= ~(1 << (irqd_to_hwirq(d) & 0x07));
+	regmap_write(pmic->regmap, HI655X_REG_TO_BUS_ADDR(offset), data);
+	spin_unlock_irqrestore(&pmic->ssi_hw_lock, pmic_spin_flag);
+}
+
+static struct irq_chip hi655x_pmic_irqchip = {
+	.name		= "hisi-hi655x-pmic-irqchip",
+	.irq_mask	= hi655x_pmic_irq_mask,
+	.irq_unmask	= hi655x_pmic_irq_unmask,
+};
+
+static int hi655x_pmic_irq_map(struct irq_domain *d, unsigned int virq,
+			       irq_hw_number_t hw)
+{
+	struct hi655x_pmic *pmic = d->host_data;
+
+	irq_set_chip_and_handler_name(virq, &hi655x_pmic_irqchip,
+				      handle_simple_irq,
+				      "hisi-hi655x-pmic-irqchip");
+	irq_set_chip_data(virq, pmic);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static struct irq_domain_ops hi655x_domain_ops = {
+	.map	= hi655x_pmic_irq_map,
+	.xlate	= irq_domain_xlate_twocell,
+};
+
+static inline void hi655x_pmic_clear_int(struct hi655x_pmic *pmic)
+{
+	int addr;
+
+	for (addr = HI655X_IRQ_STAT_BASE;
+	     addr < (HI655X_IRQ_STAT_BASE + HI655X_IRQ_ARRAY);
+	     addr++) {
+		regmap_write(pmic->regmap,
+			     HI655X_REG_TO_BUS_ADDR(addr), HI655X_IRQ_CLR);
+	}
+}
+
+static inline void hi655x_pmic_mask_int(struct hi655x_pmic *pmic)
+{
+	int addr;
+
+	for (addr = HI655X_IRQ_MASK_BASE;
+	     addr < (HI655X_IRQ_MASK_BASE + HI655X_IRQ_ARRAY);
+	     addr++) {
+		regmap_write(pmic->regmap,
+			     HI655X_REG_TO_BUS_ADDR(addr), HI655X_IRQ_MASK);
+	}
+}
+
+static struct regmap_config hi655x_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 8,
+	.max_register = HI655X_REG_TO_BUS_ADDR(HI655X_REG_MAX),
+};
+
+static int hi655x_pmic_irq_init(struct platform_device *pdev,
+				struct hi655x_pmic *pmic)
+{
+	enum of_gpio_flags gpio_flags;
+	struct device_node *np = (&pdev->dev)->of_node;
+	struct device_node *gpio_np = NULL;
+	unsigned int virq = 0;
+	int i, ret = 0;
+
+	pmic->ver = hi655x_pmic_get_version(pmic);
+	if ((pmic->ver < PMU_VER_START) || (pmic->ver > PMU_VER_END)) {
+		dev_warn(&pdev->dev, "it is wrong pmu version\n");
+		return -EINVAL;
+	}
+
+	regmap_write(pmic->regmap, HI655X_REG_TO_BUS_ADDR(ANA_IRQM_REG0), 0xff);
+
+	gpio_np = of_parse_phandle(np, "pmic-gpios", 0);
+	if (!gpio_np) {
+		dev_err(&pdev->dev, "can't parse property\n");
+		return -ENOENT;
+	}
+	pmic->gpio = of_get_gpio_flags(gpio_np, 0, &gpio_flags);
+	if (pmic->gpio < 0) {
+		dev_err(&pdev->dev,
+			"failed to of_get_gpio_flags %d\n", pmic->gpio);
+		return  pmic->gpio;
+	}
+	if (!gpio_is_valid(pmic->gpio)) {
+		dev_err(&pdev->dev, "it is invalid gpio %d\n", pmic->gpio);
+		return -EINVAL;
+	}
+	ret = gpio_request_one(pmic->gpio, GPIOF_IN, "hi655x_pmic_irq");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request gpio %d  ret = %d\n",
+			pmic->gpio, ret);
+		return ret;
+	}
+	pmic->irq = gpio_to_irq(pmic->gpio);
+
+	hi655x_pmic_clear_int(pmic);
+	hi655x_pmic_mask_int(pmic);
+	pmic->domain = irq_domain_add_simple(np,
+			HI655X_NR_IRQ, 0, &hi655x_domain_ops, pmic);
+	if (!pmic->domain) {
+		dev_err(&pdev->dev, "failed irq domain add simple!\n");
+		ret = -ENODEV;
+		goto irq_domain_add_simple;
+	}
+
+	for (i = 0; i < HI655X_NR_IRQ; i++) {
+		virq = irq_create_mapping(pmic->domain, i);
+		if (!virq) {
+			dev_err(&pdev->dev, "Failed mapping hwirq\n");
+			ret = -ENOSPC;
+			goto irq_create_mapping;
+		}
+		pmic->irqs[i] = virq;
+	}
+
+	ret = request_threaded_irq(pmic->irq, hi655x_pmic_irq_handler,
+				   NULL, IRQF_TRIGGER_LOW |
+				   IRQF_SHARED | IRQF_NO_SUSPEND,
+				   "hi655x-pmic-irq", pmic);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not claim pmic %d\n", ret);
+		ret = -ENODEV;
+		goto request_threaded_irq;
+	}
+	return 0;
+
+irq_domain_add_simple:
+irq_create_mapping:
+request_threaded_irq:
+	free_irq(pmic->irq, pmic);
+	gpio_free(pmic->gpio);
+	return ret;
+}
+
+static int hi655x_pmic_probe(struct platform_device *pdev)
+{
+	struct device_node *np = (&pdev->dev)->of_node;
+	struct hi655x_pmic *pmic = NULL;
+	void __iomem *base;
+	int ret;
+
+	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
+	if (!pmic)
+		return -ENOMEM;
+
+	spin_lock_init(&pmic->ssi_hw_lock);
+	pmic->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, pmic->res);
+	if (!base)
+		return -ENOMEM;
+
+	pmic->regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
+						 &hi655x_regmap_config);
+	ret = hi655x_pmic_irq_init(pdev, pmic);
+	if (ret) {
+		dev_err(&pdev->dev, "pmic irq init failed: %d\n", ret);
+		return ret;
+	}
+
+	pmic->dev = &pdev->dev;
+	platform_set_drvdata(pdev, pmic);
+	of_platform_populate(np, of_hi655x_pmic_child_match_tbl,
+			     NULL, &pdev->dev);
+
+	return 0;
+}
+
+static int hi655x_pmic_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hi655x_pmic *pmic = platform_get_drvdata(pdev);
+
+	free_irq(pmic->irq, pmic);
+	gpio_free(pmic->gpio);
+	devm_release_mem_region(dev, pmic->res->start,
+				resource_size(pmic->res));
+	devm_kfree(dev, pmic);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver hi655x_pmic_driver = {
+	.driver	= {
+		.name =	"hisi,hi655x-pmic",
+		.owner = THIS_MODULE,
+		.of_match_table = of_hi655x_pmic_match_tbl,
+	},
+	.probe  = hi655x_pmic_probe,
+	.remove	= hi655x_pmic_remove,
+};
+module_platform_driver(hi655x_pmic_driver);
+
+MODULE_AUTHOR("Fei Wang <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("Hisi hi655x pmic driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/hi655x-pmic.h b/include/linux/mfd/hi655x-pmic.h
new file mode 100644
index 0000000..b303fb6
--- /dev/null
+++ b/include/linux/mfd/hi655x-pmic.h
@@ -0,0 +1,50 @@
+/*
+ * Head file for hi655x pmic
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
+#ifndef __HI655X_PMIC_H
+#define __HI655X_PMIC_H
+
+/* Hi655x registers are mapped to memory bus in 4 bytes stride */
+#define HI655X_REG_TO_BUS_ADDR(x)        ((x) << 2)
+
+#define HI655X_BITS                      (8)
+
+/*numb of sub-interrupt*/
+#define HI655X_NR_IRQ                    (32)
+
+#define HI655X_IRQ_STAT_BASE             (0x003)
+#define HI655X_IRQ_MASK_BASE             (0x007)
+#define HI655X_IRQ_ARRAY                 (4)
+#define HI655X_IRQ_MASK                  (0x0ff)
+#define HI655X_IRQ_CLR                   (0x0ff)
+#define HI655X_VER_REG                   (0x000)
+#define HI655X_VER_REG                   (0x000)
+#define HI655X_REG_MAX                   (0x000)
+
+#define PMU_VER_START                    (0x010)
+#define PMU_VER_END                      (0x038)
+#define ANA_IRQM_REG0                    (0x1b5)
+
+struct hi655x_pmic {
+	struct resource *res;
+	struct device *dev;
+	struct regmap *regmap;
+	spinlock_t ssi_hw_lock;
+	struct clk *clk;
+	struct irq_domain *domain;
+	int irq;
+	int gpio;
+	unsigned int irqs[HI655X_NR_IRQ];
+	unsigned int ver;
+};
+#endif
-- 
1.9.1
