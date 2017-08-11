From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 7/8] memory: mtk-smi: Rearrange some function position
 alphabetically
Date: Fri, 11 Aug 2017 19:09:17 +0100
Message-ID: <34e9e7ec-ff9b-caf9-09ac-a0d9e9d85fa5@arm.com>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
 <1502445377-26936-8-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502445377-26936-8-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Content-Language: en-GB
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/08/17 10:56, Yong Wu wrote:
> Only adjust some code position in Soc numerical order, from mt2701,
> mt2712 to mt8173.
> 
> Besides, 3 minor changes:
> 1) fix a coding style issue:
>     CHECK: Alignment should match open parenthesis
>     +               writel(reg_val,
>     +                       common->smi_ao_base
> 2) change from readl to readl_relaxed in gen1_config_port.
> 3) change the type "larbid" from "int" to "unsigned int" to meet
>    the requirement of of_property_read_u32.

If moving existing code around is really necessary, do it as a
preliminary patch *before* any material changes (and arguably separate
even from the whitespace and comment updates) - those diffs are usually
hard to review as-is, so being able to check you get binary-identical
object files before and after is reassuring. A "cleanup" patch shouldn't
need to touch code added in the same series, and it certainly shouldn't
have significant things like the readl_relaxed() change hidden in it.

Robin.

> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/memory/mtk-smi.c | 105 +++++++++++++++++++++++------------------------
>  1 file changed, 52 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index ec06d2b..ce27bdf 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -23,9 +23,6 @@
>  #include <soc/mediatek/smi.h>
>  #include <dt-bindings/memory/mt2701-larb-port.h>
>  
> -/* mt8173 */
> -#define SMI_LARB_MMU_EN		0xf00
> -
>  /* mt2701 */
>  #define REG_SMI_SECUR_CON_BASE		0x5c0
>  
> @@ -48,16 +45,19 @@
>  #define SMI_LARB_NONSEC_CON(id)	(0x380 + (id * 4))
>  #define F_MMU_EN		BIT(0)
>  
> +/* mt8173 */
> +#define SMI_LARB_MMU_EN		0xf00
> +
>  struct mtk_smi_larb_gen {
> -	bool need_larbid;
> -	int port_in_larb[MTK_LARB_NR_MAX + 1];
> -	void (*config_port)(struct device *);
> +	bool	need_larbid;
> +	int	port_in_larb[MTK_LARB_NR_MAX + 1];/* Only needed by smi gen1 */
> +	void	(*config_port)(struct device *);
>  };
>  
>  struct mtk_smi {
>  	struct device			*dev;
>  	struct clk			*clk_apb, *clk_smi;
> -	struct clk			*clk_async; /*only needed by mt2701*/
> +	struct clk			*clk_async; /*only needed by smi gen1*/
>  	void __iomem			*smi_ao_base;
>  };
>  
> @@ -66,7 +66,7 @@ struct mtk_smi_larb { /* larb: local arbiter */
>  	void __iomem			*base;
>  	struct device			*smi_common_dev;
>  	const struct mtk_smi_larb_gen	*larb_gen;
> -	int				larbid;
> +	unsigned int			larbid;
>  	u32				*mmu;
>  };
>  
> @@ -166,28 +166,16 @@ void mtk_smi_larb_put(struct device *larbdev)
>  	return -ENODEV;
>  }
>  
> -static void mtk_smi_larb_config_port_mt8173(struct device *dev)
> +static void
> +mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
>  {
> -	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> -
> -	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
> +	/* Do nothing as the iommu is always enabled. */
>  }
>  
> -static void mtk_smi_larb_config_port_mt2712(struct device *dev)
> -{
> -	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> -	u32 reg;
> -	int i;
> -
> -	for (i = 0; i < 32; i++) {
> -		if (*larb->mmu & BIT(i)) {
> -			reg = readl_relaxed(larb->base +
> -					    SMI_LARB_NONSEC_CON(i));
> -			reg |= F_MMU_EN;
> -			writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
> -		}
> -	}
> -}
> +static const struct component_ops mtk_smi_larb_component_ops = {
> +	.bind = mtk_smi_larb_bind,
> +	.unbind = mtk_smi_larb_unbind,
> +};
>  
>  static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  {
> @@ -209,36 +197,39 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  			/* do not need to enable m4u for this port */
>  			continue;
>  		}
> -		reg_val = readl(common->smi_ao_base
> +		reg_val = readl_relaxed(common->smi_ao_base
>  			+ REG_SMI_SECUR_CON_ADDR(m4u_port_id));
>  		reg_val &= SMI_SECUR_CON_VAL_MSK(m4u_port_id);
>  		reg_val |= sec_con_val;
>  		reg_val |= SMI_SECUR_CON_VAL_DOMAIN(m4u_port_id);
>  		writel(reg_val,
> -			common->smi_ao_base
> -			+ REG_SMI_SECUR_CON_ADDR(m4u_port_id));
> +		       common->smi_ao_base +
> +		       REG_SMI_SECUR_CON_ADDR(m4u_port_id));
>  	}
>  }
>  
> -static void
> -mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
> +static void mtk_smi_larb_config_port_mt2712(struct device *dev)
>  {
> -	/* Do nothing as the iommu is always enabled. */
> -}
> +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +	u32 reg;
> +	int i;
>  
> -static const struct component_ops mtk_smi_larb_component_ops = {
> -	.bind = mtk_smi_larb_bind,
> -	.unbind = mtk_smi_larb_unbind,
> -};
> +	for (i = 0; i < 32; i++) {
> +		if (*larb->mmu & BIT(i)) {
> +			reg = readl_relaxed(larb->base +
> +					    SMI_LARB_NONSEC_CON(i));
> +			reg |= F_MMU_EN;
> +			writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
> +		}
> +	}
> +}
>  
> -static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
> -	/* mt8173 do not need the port in larb */
> -	.config_port = mtk_smi_larb_config_port_mt8173,
> -};
> +static void mtk_smi_larb_config_port_mt8173(struct device *dev)
> +{
> +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
>  
> -static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
> -	.config_port = mtk_smi_larb_config_port_mt2712,
> -};
> +	writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
> +}
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
>  	.need_larbid = true,
> @@ -249,12 +240,16 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  	.config_port = mtk_smi_larb_config_port_gen1,
>  };
>  
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
> +	.config_port = mtk_smi_larb_config_port_mt2712,
> +};
> +
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
> +	.config_port = mtk_smi_larb_config_port_mt8173,
> +};
> +
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
>  	{
> -		.compatible = "mediatek,mt8173-smi-larb",
> -		.data = &mtk_smi_larb_mt8173
> -	},
> -	{
>  		.compatible = "mediatek,mt2701-smi-larb",
>  		.data = &mtk_smi_larb_mt2701
>  	},
> @@ -262,6 +257,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  		.compatible = "mediatek,mt2712-smi-larb",
>  		.data = &mtk_smi_larb_mt2712
>  	},
> +	{
> +		.compatible = "mediatek,mt8173-smi-larb",
> +		.data = &mtk_smi_larb_mt8173
> +	},
>  	{}
>  };
>  
> @@ -341,10 +340,6 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
>  	{
> -		.compatible = "mediatek,mt8173-smi-common",
> -		.data = (void *)MTK_SMI_GEN2
> -	},
> -	{
>  		.compatible = "mediatek,mt2701-smi-common",
>  		.data = (void *)MTK_SMI_GEN1
>  	},
> @@ -352,6 +347,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>  		.compatible = "mediatek,mt2712-smi-common",
>  		.data = (void *)MTK_SMI_GEN2
>  	},
> +	{
> +		.compatible = "mediatek,mt8173-smi-common",
> +		.data = (void *)MTK_SMI_GEN2
> +	},
>  	{}
>  };
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
