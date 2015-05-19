From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/6] soc: mediatek: Add SMI driver
Date: Tue, 19 May 2015 13:14:24 +0200
Message-ID: <CABuKBeJvh2PGi3i6O0uu-7ggdBzKMb3tPE_XKhT1i-+tkKc5gg@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
	<1431683009-18158-5-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1431683009-18158-5-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

2015-05-15 11:43 GMT+02:00 Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
>     This patch add SMI(Smart Multimedia Interface) driver. This driver is
> responsible to enable/disable iommu and control the clocks of each local arbiter.
>
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/soc/mediatek/Kconfig      |   6 +
>  drivers/soc/mediatek/Makefile     |   1 +
>  drivers/soc/mediatek/mt8173-smi.c | 298 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mtk-smi.h           |  39 +++++
>  4 files changed, 344 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mt8173-smi.c
>  create mode 100644 include/linux/mtk-smi.h
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 1d34819..5935ead 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -15,3 +15,9 @@ config MTK_SCPSYS
>         help
>           Say yes here to add support for the MediaTek SCPSYS power domain
>           driver.
> +
> +config MTK_SMI
> +       bool
> +       help
> +         Smi help enable/disable iommu in MediaTek SoCs and control the clock
> +         for each local arbiter.
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index ce88693..c086261 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> +obj-$(CONFIG_MTK_SMI) += mt8173-smi.o
> diff --git a/drivers/soc/mediatek/mt8173-smi.c b/drivers/soc/mediatek/mt8173-smi.c
> new file mode 100644
> index 0000000..67bccec
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8173-smi.c
> @@ -0,0 +1,298 @@
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
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/mtk-smi.h>
> +
> +#define SMI_LARB_MMU_EN                (0xf00)
> +#define F_SMI_MMU_EN(port)     (1 << (port))
> +
> +enum {
> +       MTK_CLK_APB,
> +       MTK_CLK_SMI,
> +       MTK_CLK_MAX,

Maybe add something like:
MTK_CLK_FIRST = MTK_CLK_APB,
to make the for loops better readable.

> +};
> +
> +struct mtk_smi_common {
> +       void __iomem            *base;

That seems to be never used. Please delete it.

> +       struct clk              *clk[MTK_CLK_MAX];
> +};
> +
> +struct mtk_smi_larb {
> +       void __iomem            *base;
> +       spinlock_t              portlock; /* lock for config port */
> +       struct clk              *clk[MTK_CLK_MAX];
> +       struct device           *smi;
> +};
> +
> +static const char * const mtk_smi_clk_name[MTK_CLK_MAX] = {
> +       "apb", "smi"
> +};
> +
> +static int mtk_smi_common_get(struct device *smidev)
> +{
> +       struct mtk_smi_common *smipriv = dev_get_drvdata(smidev);
> +       int i, ret;
> +
> +       for (i = MTK_CLK_APB; i < MTK_CLK_MAX; i++) {
> +               ret = clk_enable(smipriv->clk[i]);
> +               if (ret) {
> +                       dev_err(smidev,
> +                               "Failed to enable the clock of smi_common\n");
> +                       goto err_smi_clk;
> +               }
> +       }
> +       return ret;
> +
> +err_smi_clk:
> +       if (i == MTK_CLK_SMI)
> +               clk_disable(smipriv->clk[MTK_CLK_APB]);
> +       return ret;
> +}
> +
> +static void mtk_smi_common_put(struct device *smidev)
> +{
> +       struct mtk_smi_common *smipriv = dev_get_drvdata(smidev);
> +       int i;
> +
> +       for (i = MTK_CLK_SMI; i >= MTK_CLK_APB; i--)
> +               clk_disable(smipriv->clk[i]);
> +}
> +
> +int mtk_smi_larb_get(struct device *larbdev)
> +{
> +       struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
> +       int i, ret = 0;
> +
> +       ret = mtk_smi_common_get(larbpriv->smi);
> +       if (ret)
> +               return ret;
> +
> +       for (i = MTK_CLK_APB; i < MTK_CLK_MAX; i++) {
> +               ret = clk_enable(larbpriv->clk[i]);
> +               if (ret) {
> +                       dev_err(larbdev,
> +                               "Failed to enable larb clock%d. ret 0x%x\n",
> +                               i, ret);
> +                       goto err_larb_clk;
> +               }
> +       }
> +
> +       return ret;
> +
> +err_larb_clk:
> +       if (i == MTK_CLK_SMI)
> +               clk_disable(larbpriv->clk[MTK_CLK_APB]);
> +       mtk_smi_common_put(larbpriv->smi);
> +       return ret;
> +}
> +
> +void mtk_smi_larb_put(struct device *larbdev)

You can pass mtk_smi_larb as parameter instead of struct device

> +{
> +       struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
> +       int i;
> +
> +       for (i = MTK_CLK_SMI; i >= MTK_CLK_APB; i--)
> +               clk_disable(larbpriv->clk[i]);
> +
> +       mtk_smi_common_put(larbpriv->smi);
> +}
> +
> +int mtk_smi_config_port(struct device *larbdev,        unsigned int larbportid,
> +                       bool iommuen)
> +{
> +       struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
> +       unsigned long flags;
> +       int ret;
> +       u32 reg;
> +
> +       ret = mtk_smi_larb_get(larbdev);
> +       if (ret)
> +               return ret;
> +
> +       spin_lock_irqsave(&larbpriv->portlock, flags);
> +       reg = readl(larbpriv->base + SMI_LARB_MMU_EN);
> +       reg &= ~F_SMI_MMU_EN(larbportid);
> +       if (iommuen)
> +               reg |= F_SMI_MMU_EN(larbportid);
> +       writel(reg, larbpriv->base + SMI_LARB_MMU_EN);
> +       spin_unlock_irqrestore(&larbpriv->portlock, flags);
> +
> +       mtk_smi_larb_put(larbdev);
> +
> +       return 0;
> +}
> +
> +static int mtk_smi_larb_probe(struct platform_device *pdev)
> +{
> +       struct mtk_smi_larb *larbpriv;
> +       struct resource *res;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *smi_node;
> +       struct platform_device *smi_pdev;
> +       int i, ret;
> +
> +       larbpriv = devm_kzalloc(dev, sizeof(struct mtk_smi_larb), GFP_KERNEL);
> +       if (!larbpriv)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       larbpriv->base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(larbpriv->base)) {
> +               dev_err(dev, "Failed to get the larbbase (0x%lx)\n",
> +                       PTR_ERR(larbpriv->base));
> +               return PTR_ERR(larbpriv->base);
> +       }
> +
> +       for (i = MTK_CLK_APB; i < MTK_CLK_MAX; i++) {
> +               larbpriv->clk[i] = devm_clk_get(dev, mtk_smi_clk_name[i]);
> +
> +               if (IS_ERR(larbpriv->clk[i])) {

Please delete the blank line before the if.

> +                       ret = PTR_ERR(larbpriv->clk[i]);
> +                       dev_err(dev, "Failed to get larb%d clock (0x%x)\n",
> +                               i, ret);
> +                       goto fail_larb_clk;
> +               } else {
> +                       ret = clk_prepare(larbpriv->clk[i]);
> +                       if (ret) {
> +                               dev_err(dev, "Failed to prepare larb clock%d (0x%x)\n",
> +                                       i, ret);
> +                               goto fail_larb_clk;
> +                       }
> +               }
> +       }
> +
> +       smi_node = of_parse_phandle(dev->of_node, "smi", 0);
> +       if (!smi_node) {
> +               dev_err(dev, "Failed to get smi node\n");
> +               ret = -EINVAL;
> +               goto fail_larb_clk;
> +       }
> +
> +       smi_pdev = of_find_device_by_node(smi_node);
> +       of_node_put(smi_node);
> +       if (smi_pdev) {
> +               larbpriv->smi = &smi_pdev->dev;
> +       } else {
> +               dev_err(dev, "Failed to get the smi_common device\n");
> +               ret = -EINVAL;
> +               goto fail_larb_clk;
> +       }
> +
> +       spin_lock_init(&larbpriv->portlock);
> +       dev_set_drvdata(dev, larbpriv);
> +       return 0;
> +
> +fail_larb_clk:
> +       while (--i >= MTK_CLK_APB)
> +               clk_unprepare(larbpriv->clk[i]);
> +       return ret;
> +}
> +
> +static const struct of_device_id mtk_smi_larb_of_ids[] = {
> +       { .compatible = "mediatek,mt8173-smi-larb",
> +       },
> +       {}
> +};
> +
> +static struct platform_driver mtk_smi_larb_driver = {
> +       .probe  = mtk_smi_larb_probe,
> +       .driver = {
> +               .name = "mtksmilarb",

Huh, what about something more readable like mtk-smi-larb?

> +               .of_match_table = mtk_smi_larb_of_ids,
> +       }
> +};
> +
> +static int mtk_smi_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct mtk_smi_common *smipriv;
> +       int ret, i;
> +
> +       smipriv = devm_kzalloc(dev, sizeof(*smipriv), GFP_KERNEL);
> +       if (!smipriv)
> +               return -ENOMEM;
> +
> +       for (i = MTK_CLK_APB; i < MTK_CLK_MAX; i++) {
> +               smipriv->clk[i] = devm_clk_get(dev, mtk_smi_clk_name[i]);
> +
> +               if (IS_ERR(smipriv->clk[i])) {
> +                       ret = PTR_ERR(smipriv->clk[i]);
> +                       dev_err(dev, "Failed to get smi-%s clock (0x%x)\n",
> +                               mtk_smi_clk_name[i], ret);
> +                       goto fail_smi_clk;
> +               } else {
> +                       ret = clk_prepare(smipriv->clk[i]);
> +                       if (ret) {
> +                               dev_err(dev, "Failed to prepare smi%d clock 0x%x\n",
> +                                       i, ret);
> +                               goto fail_smi_clk;
> +                       }
> +               }
> +       }
> +
> +       dev_set_drvdata(dev, smipriv);
> +       return ret;
> +
> +fail_smi_clk:
> +       if (i == MTK_CLK_SMI)
> +               clk_unprepare(smipriv->clk[MTK_CLK_APB]);
> +       return ret;
> +}
> +
> +static const struct of_device_id mtk_smi_of_ids[] = {
> +       { .compatible = "mediatek,mt8173-smi",
> +       },
> +       {}
> +};
> +
> +static struct platform_driver mtk_smi_driver = {
> +       .probe  = mtk_smi_probe,
> +       .driver = {
> +               .name = "mtksmi",

Same here.

Thanks,
Matthias
