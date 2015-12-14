From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v6 3/5] memory: mediatek: Add SMI driver
Date: Mon, 14 Dec 2015 19:18:41 +0100
Message-ID: <24171857.0SPpBlzoZl@linux-gy6r.site>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com> <1449568153-15643-4-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449568153-15643-4-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, p.zabel@pengutronix.de, yingjoe.chen@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Tuesday 08 Dec 2015 17:49:11 Yong Wu wrote:
> This patch add SMI(Smart Multimedia Interface) driver. This driver
> is responsible to enable/disable iommu and control the power domain
> and clocks of each local arbiter.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   Currently SMI offer mtk_smi_larb_get/put to enable the power-domain
> ,clocks and initialize the iommu configuration register for each a local
> arbiter, The reason is:
>   a) If a device would like to disable iommu, it also need call
> mtk_smi_larb_get/put to enable its power and clocks.
>   b) The iommu core don't support attach/detach a device within a
> iommu-group. So we cann't use iommu_attach_device(iommu_detach_device)
> instead
> of mtk_smi_larb_get/put.
> 
>  drivers/memory/Kconfig     |   8 ++
>  drivers/memory/Makefile    |   1 +
>  drivers/memory/mtk-smi.c   | 297
> +++++++++++++++++++++++++++++++++++++++++++++ include/soc/mediatek/smi.h | 
> 53 ++++++++
>  4 files changed, 359 insertions(+)
>  create mode 100644 drivers/memory/mtk-smi.c
>  create mode 100644 include/soc/mediatek/smi.h
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 6f31546..51d5cd2 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -114,6 +114,14 @@ config JZ4780_NEMC
>  	  the Ingenic JZ4780. This controller is used to handle external
>  	  memory devices such as NAND and SRAM.
> 
> +config MTK_SMI
> +	bool
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  This driver is for the Memory Controller module in MediaTek SoCs,
> +	  mainly help enable/disable iommu and control the power domain and
> +	  clocks for each local arbiter.
> +
>  source "drivers/memory/tegra/Kconfig"
> 
>  endif
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index 1c46af5..890bdf4 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -15,5 +15,6 @@ obj-$(CONFIG_FSL_IFC)		+= fsl_ifc.o
>  obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
>  obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
>  obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
> +obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
> 
>  obj-$(CONFIG_TEGRA_MC)		+= tegra/
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> new file mode 100644
> index 0000000..3562081
> --- /dev/null
> +++ b/drivers/memory/mtk-smi.c
> @@ -0,0 +1,297 @@
> +/*
> + * Copyright (c) 2014-2015 MediaTek Inc.
> + * Author: Yong Wu <yong.wu@mediatek.com>
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
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <soc/mediatek/smi.h>
> +
> +#define SMI_LARB_MMU_EN		0xf00
> +#define F_SMI_MMU_EN(port)	BIT(port)
> +
> +struct mtk_smi_common {
> +	struct device	*dev;
> +	struct clk	*clk_apb, *clk_smi;
> +};
> +
> +struct mtk_smi_larb { /* larb: local arbiter */
> +	struct device	*dev;
> +	void __iomem	*base;
> +	struct clk	*clk_apb, *clk_smi;
> +	struct device	*smi_common_dev;
> +	u32		mmu;
> +};
> +
> +static int
> +mtk_smi_enable(struct device *dev, struct clk *apb, struct clk *smi)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_prepare_enable(apb);
> +	if (ret)
> +		goto err_put_pm;
> +
> +	ret = clk_prepare_enable(smi);
> +	if (ret)
> +		goto err_disable_apb;
> +
> +	return 0;
> +
> +err_disable_apb:
> +	clk_disable_unprepare(apb);
> +err_put_pm:
> +	pm_runtime_put_sync(dev);
> +	return ret;
> +}
> +
> +static void
> +mtk_smi_disable(struct device *dev, struct clk *apb, struct clk *smi)
> +{
> +	clk_disable_unprepare(smi);
> +	clk_disable_unprepare(apb);
> +	pm_runtime_put_sync(dev);
> +}
> +
> +static int mtk_smi_common_enable(struct mtk_smi_common *common)
> +{
> +	return mtk_smi_enable(common->dev, common->clk_apb, common->clk_smi);
> +}
> +
> +static void mtk_smi_common_disable(struct mtk_smi_common *common)
> +{
> +	mtk_smi_disable(common->dev, common->clk_apb, common->clk_smi);
> +}
> +
> +static int mtk_smi_larb_enable(struct mtk_smi_larb *larb)
> +{
> +	return mtk_smi_enable(larb->dev, larb->clk_apb, larb->clk_smi);
> +}
> +
> +static void mtk_smi_larb_disable(struct mtk_smi_larb *larb)
> +{
> +	mtk_smi_disable(larb->dev, larb->clk_apb, larb->clk_smi);
> +}
> +

This is somehow over-engineered. Just use mtk_smi_enable and mtk_smi_disable 
instead of adding an extra indirection.

> +int mtk_smi_larb_get(struct device *larbdev)
> +{
> +	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> +	struct mtk_smi_common *common = dev_get_drvdata(larb->smi_common_dev);
> +	int ret;
> +
> +	ret = mtk_smi_common_enable(common);
> +	if (ret)
> +		return ret;
> +
> +	ret = mtk_smi_larb_enable(larb);
> +	if (ret)
> +		goto err_put_smi;
> +
> +	/* Configure the iommu info */
> +	writel_relaxed(larb->mmu, larb->base + SMI_LARB_MMU_EN);
> +
> +	return 0;
> +
> +err_put_smi:
> +	mtk_smi_common_disable(common);
> +	return ret;
> +}
> +
> +void mtk_smi_larb_put(struct device *larbdev)
> +{
> +	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> +	struct mtk_smi_common *common = dev_get_drvdata(larb->smi_common_dev);
> +
> +	writel_relaxed(0, larb->base + SMI_LARB_MMU_EN);
> +	mtk_smi_larb_disable(larb);
> +	mtk_smi_common_disable(common);
> +}
> +

Looks strange that you just disable all MMUs while you only enable some of 
them at runtime. Unfortunately the datasheet I have lacks the SMI part, so I 
can just guess how the HW is working.
>From the DTS it looks like as if a larb can be used by two different 
components (e.g. larb0 from ovl0 and rdma0). Wouldn't that produce a conflict?

Regards,
Matthias

> +void mtk_smi_config_port(struct device *larbdev, unsigned int larbportid,
> +			 bool enable)
> +{
> +	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> +
> +	dev_dbg(larbdev, "%s iommu port: %d\n",
> +		enable ? "enable" : "disable", larbportid);
> +
> +	/*
> +	 * Only record the iommu info here,
> +	 * and it will work after its power and clocks is enabled.
> +	 */
> +	if (enable)
> +		larb->mmu |= F_SMI_MMU_EN(larbportid);
> +	else
> +		larb->mmu &= ~F_SMI_MMU_EN(larbportid);
> +}
> +
> +static int
> +mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
> +{
> +	return 0;
> +}
> +
> +static void
> +mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
> +{
> +}
> +
> +static const struct component_ops mtk_smi_larb_component_ops = {
> +	.bind = mtk_smi_larb_bind,
> +	.unbind = mtk_smi_larb_unbind,
> +};
> +
> +static int mtk_smi_larb_probe(struct platform_device *pdev)
> +{
> +	struct mtk_smi_larb *larb;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *smi_node;
> +	struct platform_device *smi_pdev;
> +
> +	if (!dev->pm_domain)
> +		return -EPROBE_DEFER;
> +
> +	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
> +	if (!larb)
> +		return -ENOMEM;
> +	larb->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	larb->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(larb->base))
> +		return PTR_ERR(larb->base);
> +
> +	larb->clk_apb = devm_clk_get(dev, "apb");
> +	if (IS_ERR(larb->clk_apb))
> +		return PTR_ERR(larb->clk_apb);
> +
> +	larb->clk_smi = devm_clk_get(dev, "smi");
> +	if (IS_ERR(larb->clk_smi))
> +		return PTR_ERR(larb->clk_smi);
> +
> +	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
> +	if (!smi_node)
> +		return -EINVAL;
> +
> +	smi_pdev = of_find_device_by_node(smi_node);
> +	of_node_put(smi_node);
> +	if (smi_pdev) {
> +		larb->smi_common_dev = &smi_pdev->dev;
> +	} else {
> +		dev_err(dev, "Failed to get the smi_common device\n");
> +		return -EINVAL;
> +	}
> +
> +	pm_runtime_enable(dev);
> +	dev_set_drvdata(dev, larb);
> +	return component_add(dev, &mtk_smi_larb_component_ops);
> +}
> +
> +static int mtk_smi_larb_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	component_del(&pdev->dev, &mtk_smi_larb_component_ops);
> +	return 0;
> +}
> +
> +static const struct of_device_id mtk_smi_larb_of_ids[] = {
> +	{ .compatible = "mediatek,mt8173-smi-larb",},
> +	{}
> +};
> +
> +static struct platform_driver mtk_smi_larb_driver = {
> +	.probe	= mtk_smi_larb_probe,
> +	.remove = mtk_smi_larb_remove,
> +	.driver	= {
> +		.name = "mtk-smi-larb",
> +		.of_match_table = mtk_smi_larb_of_ids,
> +	}
> +};
> +
> +static int mtk_smi_common_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_smi_common *common;
> +
> +	if (!dev->pm_domain)
> +		return -EPROBE_DEFER;
> +
> +	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
> +	if (!common)
> +		return -ENOMEM;
> +	common->dev = dev;
> +
> +	common->clk_apb = devm_clk_get(dev, "apb");
> +	if (IS_ERR(common->clk_apb))
> +		return PTR_ERR(common->clk_apb);
> +
> +	common->clk_smi = devm_clk_get(dev, "smi");
> +	if (IS_ERR(common->clk_smi))
> +		return PTR_ERR(common->clk_smi);
> +
> +	pm_runtime_enable(dev);
> +	dev_set_drvdata(dev, common);
> +	return 0;
> +}
> +
> +static int mtk_smi_common_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id mtk_smi_common_of_ids[] = {
> +	{ .compatible = "mediatek,mt8173-smi-common", },
> +	{}
> +};
> +
> +static struct platform_driver mtk_smi_common_driver = {
> +	.probe	= mtk_smi_common_probe,
> +	.remove = mtk_smi_common_remove,
> +	.driver	= {
> +		.name = "mtk-smi-common",
> +		.of_match_table = mtk_smi_common_of_ids,
> +	}
> +};
> +
> +static int __init mtk_smi_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&mtk_smi_common_driver);
> +	if (ret != 0) {
> +		pr_err("Failed to register SMI driver\n");
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&mtk_smi_larb_driver);
> +	if (ret != 0) {
> +		pr_err("Failed to register SMI-LARB driver\n");
> +		goto err_unreg_smi;
> +	}
> +	return ret;
> +
> +err_unreg_smi:
> +	platform_driver_unregister(&mtk_smi_common_driver);
> +	return ret;
> +}
> +subsys_initcall(mtk_smi_init);
> diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> new file mode 100644
> index 0000000..6f41b2e
> --- /dev/null
> +++ b/include/soc/mediatek/smi.h
> @@ -0,0 +1,53 @@
> +/*
> + * Copyright (c) 2014-2015 MediaTek Inc.
> + * Author: Yong Wu <yong.wu@mediatek.com>
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
> +
> +#include <linux/device.h>
> +
> +#ifdef CONFIG_MTK_SMI
> +
> +/*
> + * Record the iommu info for each port in the local arbiter.
> + * It's only for iommu.
> + */
> +void mtk_smi_config_port(struct device *larbdev, unsigned int larbportid,
> +			 bool enable);
> +/*
> + * mtk_smi_larb_get: Enable the power domain and clocks for this local
> arbiter. + *                   It also initialize some basic setting(like
> iommu). + * mtk_smi_larb_put: Disable the power domain and clocks for this
> local arbiter. + * Both should be called in non-atomic context.
> + *
> + * Returns 0 if successful, negative on failure.
> + */
> +int mtk_smi_larb_get(struct device *larbdev);
> +void mtk_smi_larb_put(struct device *larbdev);
> +
> +#else
> +
> +static inline void
> +mtk_smi_config_port(struct device *larbdev, unsigned int larbportid,
> +		    bool enable) { }
> +
> +static inline int mtk_smi_larb_get(struct device *larbdev)
> +{
> +	return 0;
> +}
> +
> +static inline void mtk_smi_larb_put(struct device *larbdev) { }
> +
> +#endif
> +
> +#endif
