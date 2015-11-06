From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 4/7] mfd: hi655x: Add hi665x pmic driver
Date: Fri, 6 Nov 2015 22:21:54 +0200
Message-ID: <CAHp75Ve4AftT2B2TaTVi26o40xt5r-cqgykaxOvU+p44gV0wrQ@mail.gmail.com>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
	<1446730488-31930-5-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446730488-31930-5-git-send-email-puck.chen@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Feng <puck.chen@hisilicon.com>
Cc: w.f@huawei.com, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, joro@8bytes.org, iommu@lists.linux-foundation.org, haojian.zhuang@linaro.org, devicetree <devicetree@vger.kernel.org>, xuwei5@hisilicon.com, xuyiping@hisilicon.com, kong.kongxinwei@hisilicon.com, z.liuxinliang@hisilicon.com, yudongbin@hisilicon.com, weidong2@hisilicon.com, saberlily.xia@hisilicon.com, haojian.zhuang@outlook.com, leo.yan@linaro.org, linuxarm@huawei.com, dan.zhao@hisilicon.com, peter.panshilin@hisilicon.com, qijiwen@hisilicon.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 5, 2015 at 3:34 PM, Chen Feng <puck.chen@hisilicon.com> wro=
te:
> Add pmic driver to support hisilicon hi665x pmic.

> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/slab.h>
> +#include <linux/ioport.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/gpio.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/hardirq.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/irqdomain.h>
> +#include <linux/mfd/hi655x-pmic.h>
> +#include <linux/regmap.h>

Do you need all of those?

> +static irqreturn_t hi655x_pmic_irq_handler(int irq, void *data)
> +{
> +       struct hi655x_pmic *pmic =3D (struct hi655x_pmic *)data;

No need to explicitly cast from or to void *.

> +       u32 pending;

unsigned long?

> +       u32 ret =3D IRQ_NONE;

irqreturn_t ret =E2=80=A6

> +       unsigned long offset;
> +       int i;
> +
> +       for (i =3D 0; i < HI655X_IRQ_ARRAY; i++) {
> +               regmap_read(pmic->regmap,
> +                           HI655X_REG_TO_BUS_ADDR(i + HI655X_IRQ_STA=
T_BASE),
> +                           &pending);
> +               if (pending)
> +                       pr_debug("pending[%d]=3D0x%x\n\r", i, pending=
);

Why not move below?

> +
> +               /* clear pmic-sub-interrupt */

"Clear =E2=80=A6"

> +               regmap_write(pmic->regmap,
> +                            HI655X_REG_TO_BUS_ADDR(i + HI655X_IRQ_ST=
AT_BASE),
> +                            pending);
> +
> +               if (pending) {
> +                       for_each_set_bit(offset, (unsigned long *)&pe=
nding,

If pending is unsigned long no need to cast.

> +                                        HI655X_BITS)
> +                               generic_handle_irq(pmic->irqs[offset =
+
> +                                                  i * HI655X_BITS]);
> +                       ret =3D IRQ_HANDLED;
> +               }
> +       }
> +       return ret;
> +}
> +
> +static void hi655x_pmic_irq_mask(struct irq_data *d)
> +{
> +       u32 data, offset;
> +       unsigned long pmic_spin_flag =3D 0;

Why not more shorter flags?
Redundant assignment btw.

> +       struct hi655x_pmic *pmic =3D irq_data_get_irq_chip_data(d);
> +
> +       offset =3D ((irqd_to_hwirq(d) >> 3) + HI655X_IRQ_MASK_BASE);

External parens are not needed.

> +       spin_lock_irqsave(&pmic->ssi_hw_lock, pmic_spin_flag);
> +       regmap_read(pmic->regmap, HI655X_REG_TO_BUS_ADDR(offset), &da=
ta);
> +       data |=3D (1 << (irqd_to_hwirq(d) & 0x07));

Ditto.

> +       regmap_write(pmic->regmap, HI655X_REG_TO_BUS_ADDR(offset), da=
ta);
> +       spin_unlock_irqrestore(&pmic->ssi_hw_lock, pmic_spin_flag);
> +}
> +
> +static void hi655x_pmic_irq_unmask(struct irq_data *d)
> +{
> +       u32 data, offset;
> +       unsigned long pmic_spin_flag =3D 0;

Same comments as above.

> +       struct hi655x_pmic *pmic =3D irq_data_get_irq_chip_data(d);
> +
> +       offset =3D ((irqd_to_hwirq(d) >> 3) + HI655X_IRQ_MASK_BASE);

Same comments as above.

> +       spin_lock_irqsave(&pmic->ssi_hw_lock, pmic_spin_flag);
> +       regmap_read(pmic->regmap, HI655X_REG_TO_BUS_ADDR(offset), &da=
ta);
> +       data &=3D ~(1 << (irqd_to_hwirq(d) & 0x07));

> +       regmap_write(pmic->regmap, HI655X_REG_TO_BUS_ADDR(offset), da=
ta);
> +       spin_unlock_irqrestore(&pmic->ssi_hw_lock, pmic_spin_flag);
> +}
> +
> +static struct irq_chip hi655x_pmic_irqchip =3D {
> +       .name           =3D "hisi-hi655x-pmic-irqchip",
> +       .irq_mask       =3D hi655x_pmic_irq_mask,
> +       .irq_unmask     =3D hi655x_pmic_irq_unmask,
> +};
> +
> +static int hi655x_pmic_irq_map(struct irq_domain *d, unsigned int vi=
rq,
> +                              irq_hw_number_t hw)
> +{
> +       struct hi655x_pmic *pmic =3D d->host_data;
> +
> +       irq_set_chip_and_handler_name(virq, &hi655x_pmic_irqchip,
> +                                     handle_simple_irq,
> +                                     "hisi-hi655x-pmic-irqchip");
> +       irq_set_chip_data(virq, pmic);
> +       irq_set_irq_type(virq, IRQ_TYPE_NONE);
> +
> +       return 0;
> +}
> +
> +static struct irq_domain_ops hi655x_domain_ops =3D {
> +       .map    =3D hi655x_pmic_irq_map,
> +       .xlate  =3D irq_domain_xlate_twocell,
> +};
> +
> +static inline void hi655x_pmic_clear_int(struct hi655x_pmic *pmic)
> +{
> +       int addr;
> +
> +       for (addr =3D HI655X_IRQ_STAT_BASE;
> +            addr < (HI655X_IRQ_STAT_BASE + HI655X_IRQ_ARRAY);
> +            addr++) {
> +               regmap_write(pmic->regmap,
> +                            HI655X_REG_TO_BUS_ADDR(addr), HI655X_IRQ=
_CLR);
> +       }

int addr =3D =E2=80=A6;

do {
} while (++addr < =E2=80=A6);

looks simpler.

> +}
> +
> +static inline void hi655x_pmic_mask_int(struct hi655x_pmic *pmic)
> +{
> +       int addr;
> +
> +       for (addr =3D HI655X_IRQ_MASK_BASE;
> +            addr < (HI655X_IRQ_MASK_BASE + HI655X_IRQ_ARRAY);
> +            addr++) {
> +               regmap_write(pmic->regmap,
> +                            HI655X_REG_TO_BUS_ADDR(addr), HI655X_IRQ=
_MASK);
> +       }

Ditto.

> +}
> +
> +static struct regmap_config hi655x_regmap_config =3D {
> +       .reg_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .val_bits =3D 8,
> +       .max_register =3D HI655X_REG_TO_BUS_ADDR(HI655X_REG_MAX),
> +};
> +
> +static int hi655x_pmic_irq_init(struct platform_device *pdev,
> +                               struct hi655x_pmic *pmic)
> +{
> +       enum of_gpio_flags gpio_flags;
> +       struct device_node *np =3D (&pdev->dev)->of_node;

Why not dot?

Of course you may do
 struct device *dev =3D &pdev->dev;
and use it here and below.

> +       struct device_node *gpio_np =3D NULL;

Redundant assignment?

> +       unsigned int virq =3D 0;

> +       int i, ret =3D 0;

Ditto.

Btw unsigned int i;

> +
> +       pmic->ver =3D hi655x_pmic_get_version(pmic);
> +       if ((pmic->ver < PMU_VER_START) || (pmic->ver > PMU_VER_END))=
 {
> +               dev_warn(&pdev->dev, "it is wrong pmu version\n");
> +               return -EINVAL;
> +       }
> +
> +       regmap_write(pmic->regmap, HI655X_REG_TO_BUS_ADDR(ANA_IRQM_RE=
G0), 0xff);
> +
> +       gpio_np =3D of_parse_phandle(np, "pmic-gpios", 0);
> +       if (!gpio_np) {
> +               dev_err(&pdev->dev, "can't parse property\n");
> +               return -ENOENT;
> +       }
> +       pmic->gpio =3D of_get_gpio_flags(gpio_np, 0, &gpio_flags);
> +       if (pmic->gpio < 0) {
> +               dev_err(&pdev->dev,
> +                       "failed to of_get_gpio_flags %d\n", pmic->gpi=
o);
> +               return  pmic->gpio;
> +       }
> +       if (!gpio_is_valid(pmic->gpio)) {
> +               dev_err(&pdev->dev, "it is invalid gpio %d\n", pmic->=
gpio);
> +               return -EINVAL;
> +       }

I think you may join this and above one.

> +       ret =3D gpio_request_one(pmic->gpio, GPIOF_IN, "hi655x_pmic_i=
rq");
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to request gpio %d  ret =3D=
 %d\n",
> +                       pmic->gpio, ret);
> +               return ret;
> +       }
> +       pmic->irq =3D gpio_to_irq(pmic->gpio);
> +
> +       hi655x_pmic_clear_int(pmic);
> +       hi655x_pmic_mask_int(pmic);
> +       pmic->domain =3D irq_domain_add_simple(np,
> +                       HI655X_NR_IRQ, 0, &hi655x_domain_ops, pmic);
> +       if (!pmic->domain) {
> +               dev_err(&pdev->dev, "failed irq domain add simple!\n"=
);
> +               ret =3D -ENODEV;
> +               goto irq_domain_add_simple;
> +       }
> +
> +       for (i =3D 0; i < HI655X_NR_IRQ; i++) {
> +               virq =3D irq_create_mapping(pmic->domain, i);
> +               if (!virq) {
> +                       dev_err(&pdev->dev, "Failed mapping hwirq\n")=
;
> +                       ret =3D -ENOSPC;
> +                       goto irq_create_mapping;
> +               }
> +               pmic->irqs[i] =3D virq;
> +       }
> +
> +       ret =3D request_threaded_irq(pmic->irq, hi655x_pmic_irq_handl=
er,
> +                                  NULL, IRQF_TRIGGER_LOW |
> +                                  IRQF_SHARED | IRQF_NO_SUSPEND,
> +                                  "hi655x-pmic-irq", pmic);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "could not claim pmic %d\n", ret)=
;
> +               ret =3D -ENODEV;

Why replace actual error?

> +               goto request_threaded_irq;
> +       }
> +       return 0;
> +
> +irq_domain_add_simple:
> +irq_create_mapping:
> +request_threaded_irq:

Looks strange. Either one label, or put them in proper places.

> +       free_irq(pmic->irq, pmic);
> +       gpio_free(pmic->gpio);
> +       return ret;
> +}
> +
> +static int hi655x_pmic_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np =3D (&pdev->dev)->of_node;

Why not dot?

> +       struct hi655x_pmic *pmic =3D NULL;

Redundant assignment.

> +       void __iomem *base;
> +       int ret;
> +
> +       pmic =3D devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
> +       if (!pmic)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&pmic->ssi_hw_lock);
> +       pmic->res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(&pdev->dev, pmic->res);
> +       if (!base)
> +               return -ENOMEM;
> +
> +       pmic->regmap =3D devm_regmap_init_mmio_clk(&pdev->dev, NULL, =
base,
> +                                                &hi655x_regmap_confi=
g);
> +       ret =3D hi655x_pmic_irq_init(pdev, pmic);
> +       if (ret) {
> +               dev_err(&pdev->dev, "pmic irq init failed: %d\n", ret=
);
> +               return ret;
> +       }
> +
> +       pmic->dev =3D &pdev->dev;
> +       platform_set_drvdata(pdev, pmic);
> +       of_platform_populate(np, of_hi655x_pmic_child_match_tbl,
> +                            NULL, &pdev->dev);
> +
> +       return 0;
> +}
> +
> +static int hi655x_pmic_remove(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct hi655x_pmic *pmic =3D platform_get_drvdata(pdev);
> +
> +       free_irq(pmic->irq, pmic);
> +       gpio_free(pmic->gpio);
> +       devm_release_mem_region(dev, pmic->res->start,
> +                               resource_size(pmic->res));

> +       devm_kfree(dev, pmic);

Why?


> +       platform_set_drvdata(pdev, NULL);
> +       return 0;
> +}
> +
> +static struct platform_driver hi655x_pmic_driver =3D {
> +       .driver =3D {
> +               .name =3D "hisi,hi655x-pmic",
> +               .owner =3D THIS_MODULE,
> +               .of_match_table =3D of_hi655x_pmic_match_tbl,
> +       },
> +       .probe  =3D hi655x_pmic_probe,
> +       .remove =3D hi655x_pmic_remove,
> +};
> +module_platform_driver(hi655x_pmic_driver);
> +
> +MODULE_AUTHOR("Fei Wang <w.f@huawei.com>");
> +MODULE_DESCRIPTION("Hisi hi655x pmic driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/hi655x-pmic.h b/include/linux/mfd/hi65=
5x-pmic.h
> new file mode 100644
> index 0000000..b303fb6
> --- /dev/null
> +++ b/include/linux/mfd/hi655x-pmic.h
> @@ -0,0 +1,50 @@
> +/*
> + * Head file for hi655x pmic
> + *
> + * Copyright (c) 2015 Hisilicon.
> + *
> + * Fei Wang <w.f@huawei.com>
> + * Chen Feng <puck.chen@hisilicon.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __HI655X_PMIC_H
> +#define __HI655X_PMIC_H
> +
> +/* Hi655x registers are mapped to memory bus in 4 bytes stride */
> +#define HI655X_REG_TO_BUS_ADDR(x)        ((x) << 2)
> +
> +#define HI655X_BITS                      (8)
> +
> +/*numb of sub-interrupt*/
> +#define HI655X_NR_IRQ                    (32)
> +
> +#define HI655X_IRQ_STAT_BASE             (0x003)
> +#define HI655X_IRQ_MASK_BASE             (0x007)
> +#define HI655X_IRQ_ARRAY                 (4)
> +#define HI655X_IRQ_MASK                  (0x0ff)
> +#define HI655X_IRQ_CLR                   (0x0ff)
> +#define HI655X_VER_REG                   (0x000)
> +#define HI655X_VER_REG                   (0x000)
> +#define HI655X_REG_MAX                   (0x000)
> +
> +#define PMU_VER_START                    (0x010)
> +#define PMU_VER_END                      (0x038)
> +#define ANA_IRQM_REG0                    (0x1b5)
> +
> +struct hi655x_pmic {
> +       struct resource *res;
> +       struct device *dev;
> +       struct regmap *regmap;
> +       spinlock_t ssi_hw_lock;

Just lock as a name.

> +       struct clk *clk;
> +       struct irq_domain *domain;
> +       int irq;
> +       int gpio;
> +       unsigned int irqs[HI655X_NR_IRQ];
> +       unsigned int ver;
> +};
> +#endif
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--=20
With Best Regards,
Andy Shevchenko
