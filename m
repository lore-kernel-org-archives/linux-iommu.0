From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [RFC v2 2/5] tps6586x: Add device tree support
Date: Wed, 25 Apr 2012 11:44:59 +0200
Message-ID: <1335347102-14905-3-git-send-email-thierry.reding@avionic-design.de>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1335347102-14905-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This commit adds device tree support for the TPS6586x regulator.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 .../devicetree/bindings/regulator/tps6586x.txt     |   97 ++++++++++++++++++
 drivers/mfd/tps6586x.c                             |  105 ++++++++++++++++++++
 drivers/regulator/tps6586x-regulator.c             |    1 +
 include/linux/mfd/tps6586x.h                       |    1 +
 4 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/tps6586x.txt

diff --git a/Documentation/devicetree/bindings/regulator/tps6586x.txt b/Documentation/devicetree/bindings/regulator/tps6586x.txt
new file mode 100644
index 0000000..0fcabaa3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/tps6586x.txt
@@ -0,0 +1,97 @@
+TPS6586x family of regulators
+
+Required properties:
+- compatible: "ti,tps6586x"
+- reg: I2C slave address
+- interrupts: the interrupt outputs of the controller
+- #gpio-cells: number of cells to describe a GPIO
+- gpio-controller: mark the device as a GPIO controller
+- regulators: list of regulators provided by this controller, must be named
+  after their hardware counterparts: sm[0-2], ldo[0-9] and ldo_rtc
+
+Each regulator is defined using the standard binding for regulators.
+
+Example:
+
+	pmu: tps6586x@34 {
+		compatible = "ti,tps6586x";
+		reg = <0x34>;
+		interrupts = <0 88 0x4>;
+
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		regulators {
+			sm0_reg: sm0 {
+				regulator-min-microvolt = < 725000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sm1_reg: sm1 {
+				regulator-min-microvolt = < 725000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sm2_reg: sm2 {
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <4550000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo0_reg: ldo0 {
+				regulator-name = "PCIE CLK";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-min-microvolt = < 725000>;
+				regulator-max-microvolt = <1500000>;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-min-microvolt = < 725000>;
+				regulator-max-microvolt = <1500000>;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <2475000>;
+			};
+
+			ldo5_reg: ldo5 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo6_reg: ldo6 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo7_reg: ldo7 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo8_reg: ldo8 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo9_reg: ldo9 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index a5ddf31..7614b1b 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/regulator/of_regulator.h>
 
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps6586x.h>
@@ -460,6 +461,7 @@ static int __devinit tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
+		pdev->dev.of_node = subdev->of_node;
 
 		ret = platform_device_add(pdev);
 		if (ret) {
@@ -474,6 +476,105 @@ failed:
 	return ret;
 }
 
+#ifdef CONFIG_OF
+static struct {
+	const char *name;
+	int id;
+} tps6586x_id_map[] = {
+	{ "sm0", TPS6586X_ID_SM_0 },
+	{ "sm1", TPS6586X_ID_SM_1 },
+	{ "sm2", TPS6586X_ID_SM_2 },
+	{ "ldo0", TPS6586X_ID_LDO_0 },
+	{ "ldo1", TPS6586X_ID_LDO_1 },
+	{ "ldo2", TPS6586X_ID_LDO_2 },
+	{ "ldo3", TPS6586X_ID_LDO_3 },
+	{ "ldo4", TPS6586X_ID_LDO_4 },
+	{ "ldo5", TPS6586X_ID_LDO_5 },
+	{ "ldo6", TPS6586X_ID_LDO_6 },
+	{ "ldo7", TPS6586X_ID_LDO_7 },
+	{ "ldo8", TPS6586X_ID_LDO_8 },
+	{ "ldo9", TPS6586X_ID_LDO_9 },
+	{ "ldo_rtc", TPS6586X_ID_LDO_RTC },
+};
+
+static int tps6586x_lookup_id(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tps6586x_id_map); i++)
+		if (strcmp(name, tps6586x_id_map[i].name) == 0)
+			return tps6586x_id_map[i].id;
+
+	return -1;
+}
+
+static struct tps6586x_platform_data *tps6586x_parse_dt(struct i2c_client *client)
+{
+	struct device_node *np = client->dev.of_node;
+	struct tps6586x_platform_data *pdata;
+	struct tps6586x_subdev_info *devs;
+	struct device_node *regulators;
+	struct device_node *child;
+	unsigned int num = 0;
+
+	regulators = of_find_node_by_name(np, "regulators");
+
+	for_each_child_of_node(regulators, child)
+		num++;
+
+	devs = devm_kzalloc(&client->dev, num * sizeof(*devs), GFP_KERNEL);
+	if (!devs)
+		return NULL;
+
+	num = 0;
+
+	for_each_child_of_node(regulators, child) {
+		struct regulator_init_data *init_data;
+		int id;
+
+		id = tps6586x_lookup_id(child->name);
+		if (id < 0) {
+			dev_err(&client->dev, "invalid regulator name: %s\n",
+				child->name);
+			continue;
+		}
+
+		init_data = of_get_regulator_init_data(&client->dev, child);
+		if (!init_data)
+			dev_err(&client->dev,
+				"failed to parse DT for regulator %s\n",
+				child->name);
+
+		devs[num].name = "tps6586x-regulator";
+		devs[num].platform_data = init_data;
+		devs[num].of_node = child;
+		devs[num].id = id;
+		num++;
+	}
+
+	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->num_subdevs = num;
+	pdata->subdevs = devs;
+	pdata->gpio_base = -1;
+	pdata->irq_base = -1;
+
+	return pdata;
+}
+
+static struct of_device_id tps6586x_of_match[] = {
+	{ .compatible = "ti,tps6586x", },
+	{ },
+};
+#else
+static struct tps6586x_platform_data *tps6586x_parse_dt(struct i2c_client *client)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit tps6586x_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
@@ -481,6 +582,9 @@ static int __devinit tps6586x_i2c_probe(struct i2c_client *client,
 	struct tps6586x *tps6586x;
 	int ret;
 
+	if (!pdata && client->dev.of_node)
+		pdata = tps6586x_parse_dt(client);
+
 	if (!pdata) {
 		dev_err(&client->dev, "tps6586x requires platform data\n");
 		return -ENOTSUPP;
@@ -573,6 +677,7 @@ static struct i2c_driver tps6586x_driver = {
 	.driver	= {
 		.name	= "tps6586x",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(tps6586x_of_match),
 	},
 	.probe		= tps6586x_i2c_probe,
 	.remove		= __devexit_p(tps6586x_i2c_remove),
diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 9a4029a..c0a2145 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -363,6 +363,7 @@ static int __devinit tps6586x_regulator_probe(struct platform_device *pdev)
 		return err;
 
 	config.dev = &pdev->dev;
+	config.of_node = pdev->dev.of_node;
 	config.init_data = pdev->dev.platform_data;
 	config.driver_data = ri;
 
diff --git a/include/linux/mfd/tps6586x.h b/include/linux/mfd/tps6586x.h
index b19176e..f350fd0 100644
--- a/include/linux/mfd/tps6586x.h
+++ b/include/linux/mfd/tps6586x.h
@@ -68,6 +68,7 @@ struct tps6586x_subdev_info {
 	int		id;
 	const char	*name;
 	void		*platform_data;
+	struct device_node *of_node;
 };
 
 struct tps6586x_platform_data {
-- 
1.7.10
