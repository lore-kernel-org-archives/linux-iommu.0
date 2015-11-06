From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/7] regulator: hisilicon: Add hi655x pmic voltage
 regulator driver
Date: Fri, 6 Nov 2015 23:29:40 +0200
Message-ID: <CAHp75VeFdSWOxgKGEdyeRWqK2JSZ_Nw+AkaXXPnGFU-kuoazPQ@mail.gmail.com>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
	<1446730488-31930-7-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446730488-31930-7-git-send-email-puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, ijc+devicetree <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, xuyiping-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, yudongbin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, weidong2-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, saberlily.xia-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, haojian.zhuang-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, peter.panshilin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, qijiwen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 5, 2015 at 3:34 PM, Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org> wrote:
> Add driver support for HiSilicon Hi655x voltage regulators.

> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/delay.h>
> +#include <linux/time.h>
> +#include <linux/regulator/hi655x-regulator.h>
> +#include <linux/mfd/hi655x-pmic.h>
> +#include <linux/regmap.h>
> +#include <linux/bitops.h>
> +
> +static int hi655x_is_enabled(struct regulator_dev *rdev)
> +{
> +       unsigned int value = 0;
> +
> +       struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
> +       struct hi655x_regulator_ctrl_regs *ctrl_regs = &regulator->ctrl_regs;
> +
> +       regmap_read(rdev->regmap, ctrl_regs->status_reg, &value);
> +       return (value & BIT(regulator->ctrl_mask));
> +}
> +
> +static int hi655x_enable(struct regulator_dev *rdev)
> +{
> +       int ret = 0;
> +       struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
> +       struct hi655x_regulator_ctrl_regs *ctrl_regs = &regulator->ctrl_regs;
> +
> +       ret = regmap_update_bits(rdev->regmap, ctrl_regs->enable_reg,
> +                                regulator->ctrl_mask, regulator->ctrl_mask);
> +       return ret;
> +}
> +
> +static int hi655x_disable(struct regulator_dev *rdev)
> +{
> +       int ret = 0;
> +       struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
> +
> +       if (!regulator) {
> +               pr_err("get driver data error!\n");
> +               return -ENODEV;
> +       }
> +       struct hi655x_regulator_ctrl_regs *ctrl_regs = &regulator->ctrl_regs;
> +
> +       ret = regmap_update_bits(rdev->regmap, ctrl_regs->disable_reg,
> +                                regulator->ctrl_mask, regulator->ctrl_mask);
> +       return ret;
> +}
> +
> +static int hi655x_get_voltage(struct regulator_dev *rdev)
> +{
> +       unsigned int value = 0;
> +       struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
> +
> +       if (!regulator) {
> +               pr_err("get driver data error!\n");
> +               return -ENODEV;
> +       }
> +       struct hi655x_regulator_vset_regs *vset_regs = &regulator->vset_regs;
> +
> +       regmap_read(rdev->regmap, vset_regs->vset_reg, &value);
> +
> +       return regulator->vset_table[value];
> +}
> +
> +static int hi655x_set_voltage(struct regulator_dev *rdev,
> +                             int min_uV, int max_uV, unsigned *selector)
> +{
> +       int i = 0;
> +       int ret = 0;
> +       int vol = 0;
> +       struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
> +
> +       if (!regulator) {
> +               pr_err("get driver data error!\n");
> +               return -ENODEV;
> +       }
> +
> +       struct hi655x_regulator_vset_regs *vset_regs = &regulator->vset_regs;
> +
> +       /**
> +        * search the matched vol and get its index
> +        */
> +       for (i = 0; i < regulator->vol_numb; i++) {
> +               vol = regulator->vset_table[i];
> +               if ((vol >= min_uV) && (vol <= max_uV))
> +                       break;
> +       }
> +
> +       if (i == regulator->vol_numb)
> +               return -1;
> +
> +       regmap_update_bits(rdev->regmap, vset_regs->vset_reg,
> +                          regulator->vset_mask, i);
> +       *selector = i;
> +
> +       return ret;
> +}
> +
> +static unsigned int hi655x_map_mode(unsigned int mode)
> +{
> +       /* hi655x pmic on hi6220 SoC only support normal mode */
> +       if (mode == REGULATOR_MODE_NORMAL)
> +               return REGULATOR_MODE_NORMAL;
> +       else
> +               return -EINVAL;
> +}
> +
> +static int hi655x_set_mode(struct regulator_dev *rdev,
> +                          unsigned int mode)
> +
> +{
> +       if (mode == REGULATOR_MODE_NORMAL)
> +               return 0;
> +       else
> +               return -EINVAL;
> +}
> +
> +static struct regulator_ops hi655x_regulator_ops = {
> +       .is_enabled = hi655x_is_enabled,
> +       .enable = hi655x_enable,
> +       .disable = hi655x_disable,
> +       .list_voltage = regulator_list_voltage_table,
> +       .get_voltage = hi655x_get_voltage,
> +       .set_voltage = hi655x_set_voltage,
> +       .set_mode = hi655x_set_mode,
> +};
> +
> +static const struct of_device_id of_hi655x_regulator_match_tbl[] = {
> +       {
> +               .compatible = "hisilicon,hi655x-regulator-pmic",
> +       },
> +};
> +MODULE_DEVICE_TABLE(of, of_hi655x_regulator_match_tbl);
> +
> +/**
> + * get the hi655x specific data from dt node.
> + */
> +static void of_get_hi655x_ctr(struct hi655x_regulator *regulator,
> +                             struct device *dev, struct device_node *np)
> +{
> +       unsigned int *vset_table = NULL;
> +
> +       of_property_read_u32_array(np, "regulator-ctrl-regs",

device property API?

> +                                  (u32 *)&regulator->ctrl_regs, 0x3);
> +       of_property_read_u32(np, "regulator-ctrl-mask", &regulator->ctrl_mask);
> +       of_property_read_u32(np, "regulator-vset-regs",
> +                            (u32 *)&regulator->vset_regs);
> +       of_property_read_u32(np, "regulator-vset-mask", &regulator->vset_mask);
> +       of_property_read_u32(np, "regulator-n-vol", &regulator->vol_numb);
> +       of_property_read_u32(np, "regulator-off-on-delay",
> +                            &regulator->rdesc.off_on_delay);
> +
> +       vset_table = devm_kzalloc(dev, regulator->vol_numb * sizeof(int),
> +                                 GFP_KERNEL);
> +
> +       of_property_read_u32_array(np, "regulator-vset-table",
> +                                  vset_table,
> +                                  regulator->vol_numb);
> +       regulator->vset_table = vset_table;
> +       regulator->rdesc.volt_table = vset_table;
> +       regulator->rdesc.n_voltages = regulator->vol_numb;
> +}
> +
> +static int hi655x_regulator_probe(struct platform_device *pdev)
> +{
> +       int ret = 0;

Is it used?

make W=1

> +       struct hi655x_regulator *regulator;
> +       struct hi655x_pmic *pmic;
> +       struct regulator_init_data *init_data;
> +       struct regulator_config config = { };
> +       struct device_node *np = pdev->dev.of_node;
> +
> +       pmic = dev_get_drvdata(pdev->dev.parent);
> +       if (!pmic) {
> +               pr_err("no pmic in the regulator parent node\n");

pr_err -> dev_err. Here and in other places.

> +               return -ENODEV;
> +       }
> +
> +       regulator = devm_kzalloc(&pdev->dev, sizeof(*regulator), GFP_KERNEL);
> +       if (!regulator)
> +               return -ENOMEM;
> +       of_get_hi655x_ctr(regulator, &pdev->dev, np);
> +
> +       regulator->rdesc.name = dev_name(&pdev->dev);
> +       regulator->rdesc.type = REGULATOR_VOLTAGE;
> +       regulator->rdesc.owner = THIS_MODULE;
> +       regulator->rdesc.of_map_mode = hi655x_map_mode;
> +       regulator->rdesc.ops = &hi655x_regulator_ops;
> +       init_data = of_get_regulator_init_data(&pdev->dev, pdev->dev.of_node,
> +                                              &regulator->rdesc);
> +       if (!init_data) {
> +               pr_err("get init data from dts error!\n");
> +               return -EINVAL;
> +       }
> +       config.dev = &pdev->dev;
> +       config.init_data = init_data;
> +       config.driver_data = regulator;
> +       config.regmap = pmic->regmap;
> +
> +       regulator->regdev = devm_regulator_register(&pdev->dev,
> +                                                   &regulator->rdesc,
> +                                                   &config);
> +       if (IS_ERR(regulator->regdev)) {
> +               pr_err("register regulator to system error!\n");
> +               return PTR_ERR(regulator->regdev);
> +       }
> +
> +       platform_set_drvdata(pdev, regulator);
> +       return 0;
> +}
> +
> +static struct platform_driver hi655x_regulator_driver = {
> +       .driver = {
> +               .name   = "hi655x_regulator",
> +               .of_match_table = of_hi655x_regulator_match_tbl,
> +       },
> +       .probe  = hi655x_regulator_probe,
> +};
> +module_platform_driver(hi655x_regulator_driver);
> +
> +MODULE_AUTHOR("Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>");
> +MODULE_DESCRIPTION("Hisi hi655x regulator driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/regulator/hi655x-regulator.h b/include/linux/regulator/hi655x-regulator.h
> new file mode 100644
> index 0000000..4a32095
> --- /dev/null
> +++ b/include/linux/regulator/hi655x-regulator.h
> @@ -0,0 +1,63 @@
> +/*
> + * Device driver for regulators in HI6553 IC
> + *
> + * Copyright (c) 2015 Hisilicon.
> + *
> + * Fei Wang  <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> + * Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> + *
> + * this regulator's probe function will be called lots of times,,
> + * because of there are lots of regulator nodes in dtb.
> + * so,that's say, the driver must be inited before the regulator nodes
> + * registor to system.

Something with spelling is broken here.

> + *
> + * Makefile have proved my guess, please refor to the makefile.
> + * when the code is rebuild i hope we can build pmu sub_system.
> + * init order can not base on compile

And here.




-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
