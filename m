From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/5] soc: mediatek: Add SMI driver
Date: Mon, 9 Mar 2015 15:51:59 +0800
Message-ID: <CAGS+omA9_HP8K6PpCsTjUjSseVVXK0V56R_1i6FPTptHHPTNhg@mail.gmail.com>
References: <1425638270-24903-1-git-send-email-yong.wu@mediatek.com>
	<1425638270-24903-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425638270-24903-2-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yong,

On Fri, Mar 6, 2015 at 6:37 PM,  <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>
>     This patch add SMI(Smart Multimedia Interface) driver. This driver
> is responsible to enable/disable iommu and control the clocks of each
> local arbiter.

High-level:
Is there more to the smi (or smi-larb) driver, or is it always just a
1:1 wrapper for a particular m4u consumer?
In other words, instead of a separate driver, is it possible to move
this functionality into the m4u driver and/or the m4u consumers
directly?

>
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/soc/mediatek/Kconfig      |   7 ++
>  drivers/soc/mediatek/Makefile     |   1 +
>  drivers/soc/mediatek/mt8173-smi.c | 143 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mtk-smi.h           |  40 +++++++++++
>  4 files changed, 191 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mt8173-smi.c
>  create mode 100644 include/linux/mtk-smi.h
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 729f93e..27fb26c 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -20,3 +20,10 @@ config MT8173_PMIC_WRAP
>           PMIC wrapper is a proprietary hardware in MT8173 to make
>           communication protocols to access PMIC device.
>           This driver implement access protocols for MT8173.
> +
> +config MTK_SMI
> +        bool
> +       help
> +         Smi help enable/disable iommu in mt8173 and control the
> +         clock of each local arbiter.
> +         It should be true while MTK_IOMMU enable.
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 9b5709b..cdfe95c 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_MT8135_PMIC_WRAP)         += mt8135-pmic-wrap.o
>  obj-$(CONFIG_MT8173_PMIC_WRAP)         += mt8173-pmic-wrap.o
> +obj-$(CONFIG_MTK_SMI)                   += mt8173-smi.o
> diff --git a/drivers/soc/mediatek/mt8173-smi.c b/drivers/soc/mediatek/mt8173-smi.c
> new file mode 100644
> index 0000000..4e3fab9
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8173-smi.c
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright (c) 2014-2015 MediaTek Inc.
> + * Author: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/mm.h>
> +
> +#define SMI_LARB_MMU_EN                 (0xf00)
> +#define F_SMI_MMU_EN(port)              (1 << (port))
> +
> +struct mtk_smi_larb {
> +       void __iomem *larb_base;
> +       struct clk *larb_clk[3];/* each larb has 3 clk at most */
> +};
> +
> +static const char * const mtk_smi_clk_name[] = {
> +       "larb_sub0", "larb_sub1", "larb_sub2"
> +};

The order and meaning of these clocks do not seem particularly important.
It seems a bit awkward to use these arbitrary names just so we can use
devm_clk_get() to get a variably sized array of clocks from .dts.
Can we eliminate the "clock-names" property, and just use a single
.dts proprety that lists an array of clocks?
Then you would also get an explicit clock count, and can remove the
NULL checking when iterating.
An example of a clock list without names is:

Clock list in .dts:
  https://lkml.org/lkml/2014/11/17/115
Filling in the clocks from .dts:
  https://lkml.org/lkml/2014/11/17/114

Unfortunately, those patches never made it out of list discussion into
a maintainer tree.

> +
> +static const struct of_device_id mtk_smi_of_ids[] = {
> +       { .compatible = "mediatek,mt8173-smi-larb",
> +       },
> +       {}
> +};

I find it a bit redundant to call the struct "mtk_smi_larb", and then
to prepend "larb_" to all of the fields.
In fact this whole driver is a bit confusing because it isn't clear if
this is an "smi" driver (of which only larb control has been
implemented) or is this an "smi_larb" driver (and potentially there
are other smi drivers).

Perhaps we can just call this an "smi_larb" driver, rename this file
to mt8173-smi-larb.c, and then doing something like:

struct mtk_smi_larb {
  void __iomem *base;
  struct clk *clk[3];    /* each smi_larb has at most 3 clocks */
};

static const struct of_device_id mtk_smi_larb_of_ids[] = {
       { .compatible = "mediatek,mt8173-smi-larb" },
       {}
};


> +
> +int mtk_smi_larb_get(struct platform_device *plarbdev)

Is there any reason to use "struct platform_device" here instead of
just "struct device"?

> +{
> +       struct mtk_smi_larb *larbpriv = dev_get_drvdata(&plarbdev->dev);
> +       int i, ret = 0;
> +
> +       for (i = 0; i < 3; i++)
> +               if (larbpriv->larb_clk[i]) {
> +                       ret = clk_prepare_enable(larbpriv->larb_clk[i]);

I think it is slightly nicer to prepare() all of these clocks in
probe(), and just do enable/disable at runtime.
That would allow these get/put routines to be called in atomic context.

> +                       if (ret) {
> +                               dev_err(&plarbdev->dev,
> +                                       "failed to enable larbclk%d:%d\n",
> +                                       i, ret);

Please disable any clocks on the error path that were previously enabled.

> +                               break;
> +                       }
> +               }
> +       return ret;
> +}
> +
> +void mtk_smi_larb_put(struct platform_device *plarbdev)
> +{
> +       struct mtk_smi_larb *larbpriv = dev_get_drvdata(&plarbdev->dev);
> +       int i;
> +
> +       for (i = 2; i >= 0; i--)
> +               if (larbpriv->larb_clk[i])
> +                       clk_disable_unprepare(larbpriv->larb_clk[i]);
> +}
> +
> +int mtk_smi_config_port(struct platform_device *plarbdev,
> +                       unsigned int larbportid)
> +{
> +       struct mtk_smi_larb *larbpriv = dev_get_drvdata(&plarbdev->dev);
> +       int ret;
> +       u32 reg;
> +
> +       ret = mtk_smi_larb_get(plarbdev);
> +       if (ret)
> +               return ret;
> +
> +       reg = readl(larbpriv->larb_base + SMI_LARB_MMU_EN);
> +       reg &= ~F_SMI_MMU_EN(larbportid);
> +       reg |= F_SMI_MMU_EN(larbportid);
> +       writel(reg, larbpriv->larb_base + SMI_LARB_MMU_EN);
> +
> +       mtk_smi_larb_put(plarbdev);
> +
> +       return 0;
> +}
> +
> +static int mtk_smi_probe(struct platform_device *pdev)
> +{
> +       struct mtk_smi_larb *larbpriv;
> +       struct resource *res;
> +       struct device *dev = &pdev->dev;
> +       unsigned int i;
> +
> +       larbpriv = devm_kzalloc(dev, sizeof(struct mtk_smi_larb), GFP_KERNEL);
> +       if (!larbpriv)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       larbpriv->larb_base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(larbpriv->larb_base)) {
> +               dev_err(dev, "larbbase %p err\n", larbpriv->larb_base);
> +               return PTR_ERR(larbpriv->larb_base);
> +       }
> +
> +       for (i = 0; i < 3; i++) {
> +               larbpriv->larb_clk[i] = devm_clk_get(dev, mtk_smi_clk_name[i]);
> +
> +               if (IS_ERR(larbpriv->larb_clk[i])) {
> +                       if (i == 2) {/* some larb may have only 2 clock */
> +                               larbpriv->larb_clk[i] = NULL;

The assumption "any error on the third clock means this larb has only
2 clocks" is incorrect.
Please explicitly handle the case where a larb has less than 3 clocks
and not rely on any error from devm_clk_get.
Hopefully this can be handled more cleanly by using an array property
as described above.

> +                       } else {
> +                               dev_err(dev, "clock-%d err: %p\n", i,
> +                                       larbpriv->larb_clk[i]);
> +                               return PTR_ERR(larbpriv->larb_clk[i]);
> +                       }
> +               }
> +       }
> +       dev_set_drvdata(dev, larbpriv);
> +       return 0;
> +}
> +
> +static int mtk_smi_remove(struct platform_device *pdev)

I think you can just remove the empty remove handler (or unprepare the
clocks here).

Ok, that's it for now!

-Dan

> +{
> +       return 0;
> +}
> +
> +static struct platform_driver mtk_smi_driver = {
> +       .probe  = mtk_smi_probe,
> +       .remove = mtk_smi_remove,
> +       .driver = {
> +               .name = "mtksmi",
> +               .of_match_table = mtk_smi_of_ids,
> +       }
> +};
> +
> +static int __init mtk_smi_init(void)
> +{
> +       return platform_driver_register(&mtk_smi_driver);
> +}
> +
> +subsys_initcall(mtk_smi_init);
> +
> diff --git a/include/linux/mtk-smi.h b/include/linux/mtk-smi.h
> new file mode 100644
> index 0000000..1411f7b
> --- /dev/null
> +++ b/include/linux/mtk-smi.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (c) 2014-2015 MediaTek Inc.
> + * Author: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifndef MTK_IOMMU_SMI_H
> +#define MTK_IOMMU_SMI_H
> +#include <linux/platform_device.h>
> +
> +/*
> + * Enable iommu for each port, it is only for iommu.
> + *
> + * Returns 0 if successfully, others if failed.
> + */
> +int mtk_smi_config_port(struct platform_device *pdev,
> +                       unsigned int larbportid);
> +
> +/*
> + * The multimedia module should call the two function below
> + * which help open/close the clock of the larb.
> + * so the client dtsi should add the larb like "larb = <&larb0>"
> + * to get platform_device.
> + *
> + * mtk_smi_larb_get should be called before the multimedia h/w work.
> + * mtk_smi_larb_put should be called after h/w done.
> + *
> + * Returns 0 if successfully, others if failed.
> + */
> +int mtk_smi_larb_get(struct platform_device *plarbdev);
> +void mtk_smi_larb_put(struct platform_device *plarbdev);
> +
> +#endif
> --
> 1.8.1.1.dirty
