From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 06/15] iommu/mediatek: Add mt8183 IOMMU support
Date: Mon, 3 Dec 2018 00:56:13 +0100
Message-ID: <f8528e80-e816-7901-a56a-581f88b29c83@gmail.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
	<1542422142-30688-7-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1542422142-30688-7-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 17/11/2018 03:35, Yong Wu wrote:
> The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> the ARM Short-descriptor like mt8173, and most of the HW registers
> are the same.
> 
> Here list main changes in mt8183:
> 1) mt8183 has only one M4U HW like mt8173.

That's a change?

> 2) mt8183 don't have its "bclk" clock, the M4U use the EMI clock
> which has already been enabled before kernel.
> 3) mt8183 can support the dram over 4GB, but it don't call this "4GB
> mode".
> 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> the bit[33:32] in the physical address of the pgtable base, But the
> standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> we add a mask.
> 5) mt8183 HW has a GALS modules, the SMI should add "gals" clock
> support.
> 6) the larb-id in smi-common has been remapped. This means the
> larb-id reported in the mtk_iommu_isr is not the real larb-id, here
> is the remapping relationship of mt8183:

This whole list is an indicator that you will need several enhancements to the
existing code before you can add mt8183 support.
Please do so in independent patches (e.g. gals modules, remap logic)
Regarding making bclk optional, I think it would be better to set it to NULL for
mt8183 otherwise the driver will work with a broken device tree on systems that
actually need the bclk. Same holds for gals0 and gals1.

>                        M4U
>                         |
> ---------------------------------------------
> |               SMI common                  |
> -0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
>  |     |     |     |     |     |      |     |
> larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
> disp  vdec  img   cam   venc  img    cam
> As above, larb0 connects with the id 0 in smi-common.
>           larb1 connects with the id 7 in smi-common.
>           ...
> Take a example, if the larb-id reported in the mtk_iommu_isr is 7,
> actually it is larb1(vdec).
> 
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/mtk_iommu.c | 38 ++++++++++++++++++++++++++++----------
>  drivers/iommu/mtk_iommu.h |  5 +++++
>  drivers/memory/mtk-smi.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+), 10 deletions(-)
> 

[...]

> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index a243047..e5fd8ee 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -39,11 +39,16 @@ enum mtk_iommu_plat {
>  	M4U_MT2701,
>  	M4U_MT2712,
>  	M4U_MT8173,
> +	M4U_MT8183,
>  };
>  
>  struct mtk_iommu_plat_data {
>  	enum mtk_iommu_plat m4u_plat;
>  	bool has_4gb_mode;
> +
> +	/* The larb-id may be remapped in the smi-common. */
> +	bool larbid_remap_enable;
> +	unsigned int larbid_remapped[MTK_LARB_NR_MAX];

Please add new features to the driver as single patches. Don't add this kind of
things in the patch where you enable a new SoC.

>  };
>  
>  struct mtk_iommu_domain;
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e37e54b..979153b 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -59,6 +59,7 @@ struct mtk_smi_larb_gen {
>  struct mtk_smi {
>  	struct device			*dev;
>  	struct clk			*clk_apb, *clk_smi;
> +	struct clk			*clk_gals0, *clk_gals1;
>  	struct clk			*clk_async; /*only needed by mt2701*/
>  	void __iomem			*smi_ao_base;
>  };
> @@ -93,8 +94,20 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>  	if (ret)
>  		goto err_disable_apb;
>  
> +	ret = clk_prepare_enable(smi->clk_gals0);
> +	if (ret)
> +		goto err_disable_smi;
> +
> +	ret = clk_prepare_enable(smi->clk_gals1);
> +	if (ret)
> +		goto err_disable_gals0;
> +>  	return 0;
>  
> +err_disable_gals0:
> +	clk_disable_unprepare(smi->clk_gals0);
> +err_disable_smi:
> +	clk_disable_unprepare(smi->clk_smi);
>  err_disable_apb:
>  	clk_disable_unprepare(smi->clk_apb);
>  err_put_pm:
> @@ -104,6 +117,8 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>  
>  static void mtk_smi_disable(const struct mtk_smi *smi)
>  {
> +	clk_disable_unprepare(smi->clk_gals1);
> +	clk_disable_unprepare(smi->clk_gals0);
>  	clk_disable_unprepare(smi->clk_smi);
>  	clk_disable_unprepare(smi->clk_apb);
>  	pm_runtime_put_sync(smi->dev);
> @@ -262,6 +277,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  	.larb_special_mask = BIT(8) | BIT(9), /* bdpsys */
>  };
>  
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> +	.need_larbid = true,
> +	.config_port = mtk_smi_larb_config_port_gen2_general,
> +	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
> +};
> +
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
>  	{
>  		.compatible = "mediatek,mt8173-smi-larb",
> @@ -275,6 +296,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  		.compatible = "mediatek,mt2712-smi-larb",
>  		.data = &mtk_smi_larb_mt2712
>  	},
> +	{
> +		.compatible = "mediatek,mt8183-smi-larb",
> +		.data = &mtk_smi_larb_mt8183
> +	},
>  	{}
>  };
>  
> @@ -304,6 +329,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	larb->smi.clk_smi = devm_clk_get(dev, "smi");
>  	if (IS_ERR(larb->smi.clk_smi))
>  		return PTR_ERR(larb->smi.clk_smi);
> +
> +	larb->smi.clk_gals0 = devm_clk_get(dev, "gals");> +	if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
> +		larb->smi.clk_gals0 = NULL;
> +	else if (IS_ERR(larb->smi.clk_gals0))
> +		return PTR_ERR(larb->smi.clk_gals0);
>  	larb->smi.dev = dev;
>  
>  	if (larb->larb_gen->need_larbid) {
> @@ -364,6 +395,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>  		.compatible = "mediatek,mt2712-smi-common",
>  		.data = (void *)MTK_SMI_GEN2
>  	},
> +	{
> +		.compatible = "mediatek,mt8183-smi-common",
> +		.data = (void *)MTK_SMI_GEN2
> +	},
>  	{}
>  };
>  
> @@ -388,6 +423,18 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	if (IS_ERR(common->clk_smi))
>  		return PTR_ERR(common->clk_smi);
>  
> +	common->clk_gals0 = devm_clk_get(dev, "gals0");
> +	if (PTR_ERR(common->clk_gals0) == -ENOENT)
> +		common->clk_gals0 = NULL;
> +	else if (IS_ERR(common->clk_gals0))
> +		return PTR_ERR(common->clk_gals0);
> +
> +	common->clk_gals1 = devm_clk_get(dev, "gals1");
> +	if (PTR_ERR(common->clk_gals1) == -ENOENT)
> +		common->clk_gals1 = NULL;
> +	else if (IS_ERR(common->clk_gals1))
> +		return PTR_ERR(common->clk_gals1);
> +

I'd prefer to check for clk_gals[01] for SoCs that need this clocks instead of
making them optional.

Regards,
Matthias
