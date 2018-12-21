From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 10/18] iommu/mediatek: Add mt8183 IOMMU support
Date: Fri, 21 Dec 2018 19:31:49 +0100
Message-ID: <07f6276d-e7b5-ef82-9c38-1fa0af0cd9f3@gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
	<1544258371-4600-11-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1544258371-4600-11-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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



On 08/12/2018 09:39, Yong Wu wrote:
> The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> the ARM Short-descriptor like mt8173, and most of the HW registers
> are the same.
> 
> Here list main differences between mt8183 and mt8173/mt2712:
> 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> mode".
> 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> the bit[33:32] in the physical address of the pgtable base, But the
> standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> we add a mask.
> 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> 6) the larb-id in smi-common is remapped. M4U should enable
> larbid_remapped support.
> 
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/mtk_iommu.c | 31 ++++++++++++++++++++++---------
>  drivers/iommu/mtk_iommu.h |  1 +
>  drivers/memory/mtk-smi.c  | 19 +++++++++++++++++++
>  3 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8ab3b69..d91a554 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -36,6 +36,7 @@
>  #include "mtk_iommu.h"
>  
>  #define REG_MMU_PT_BASE_ADDR			0x000
> +#define MMU_PT_ADDR_MASK			GENMASK(31, 7)
>  
>  #define REG_MMU_INVALIDATE			0x020
>  #define F_ALL_INVLD				0x2
> @@ -54,7 +55,7 @@
>  #define REG_MMU_CTRL_REG			0x110
>  #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
>  #define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
> -	((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
> +	((data)->plat_data->m4u_plat == M4U_MT8173 ? 5 : 4)
>  /* It's named by F_MMU_TF_PROT_SEL in mt2712. */
>  #define F_MMU_TF_PROTECT_SEL(prot, data) \
>  	(((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
> @@ -347,7 +348,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  	/* Update the pgtable base address register of the M4U HW */
>  	if (!data->m4u_dom) {
>  		data->m4u_dom = dom;
> -		writel(dom->cfg.arm_v7s_cfg.ttbr[0],
> +		writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
>  		       data->base + REG_MMU_PT_BASE_ADDR);
>  	}
>  
> @@ -510,6 +511,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  
>  static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  {
> +	enum mtk_iommu_plat m4u_plat = data->plat_data->m4u_plat;
>  	u32 regval;
>  	int ret;
>  
> @@ -520,7 +522,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  	}
>  
>  	regval = F_MMU_TF_PROTECT_SEL(2, data);
> -	if (data->plat_data->m4u_plat == M4U_MT8173)
> +	if (m4u_plat == M4U_MT8173)
>  		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
>  	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
>  
> @@ -541,14 +543,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
>  	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
>  
> -	if (data->plat_data->m4u_plat == M4U_MT8173)
> +	if (m4u_plat == M4U_MT8173)
>  		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
>  	else
>  		regval = lower_32_bits(data->protect_base) |
>  			 upper_32_bits(data->protect_base);
>  	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
>  
> -	if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> +	if (data->enable_4GB && m4u_plat == M4U_MT2712) {
>  		/*
>  		 * If 4GB mode is enabled, the validate PA range is from
>  		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> @@ -558,8 +560,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  	}
>  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>  
> -	/* It's MISC control register whose default value is ok except mt8173.*/
> -	if (data->plat_data->m4u_plat == M4U_MT8173)
> +	/*
> +	 * It's MISC control register whose default value is ok
> +	 * except mt8173 and mt8183.
> +	 */
> +	if (m4u_plat == M4U_MT8173 || m4u_plat == M4U_MT8183)
>  		writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
>  
>  	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> @@ -713,6 +718,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  {
>  	struct mtk_iommu_data *data = dev_get_drvdata(dev);
>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
> +	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
>  	void __iomem *base = data->base;
>  	int ret;
>  
> @@ -728,8 +734,8 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
>  	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
>  	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
> -	if (data->m4u_dom)
> -		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
> +	if (m4u_dom)
> +		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
>  		       base + REG_MMU_PT_BASE_ADDR);
>  	return 0;
>  }
> @@ -750,9 +756,16 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  	.has_bclk     = true,
>  };
>  
> +static const struct mtk_iommu_plat_data mt8183_data = {
> +	.m4u_plat            = M4U_MT8183,
> +	.larbid_remap_enable = true,
> +	.larbid_remapped     = {0, 4, 5, 6, 7, 2, 3, 1},

Aren't we reinventing the wheel here?
Why can't we use larb-id to get the correct id insteaf of providing another data
structure for the remapping?

Regards,
Matthias

> +};
> +
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
>  	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
> +	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
>  	{}
>  };
>  
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 3877050..6385dec 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -39,6 +39,7 @@ enum mtk_iommu_plat {
>  	M4U_MT2701,
>  	M4U_MT2712,
>  	M4U_MT8173,
> +	M4U_MT8183,
>  };
>  
>  struct mtk_iommu_plat_data {
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 3720c77..bced778 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -285,6 +285,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  	.larb_special_mask = BIT(8) | BIT(9),          /* bdpsys */
>  };
>  
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> +	.has_gals          = true,
> +	.config_port       = mtk_smi_larb_config_port_gen2_general,
> +	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
> +};
> +
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
>  	{
>  		.compatible = "mediatek,mt8173-smi-larb",
> @@ -298,6 +304,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
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
> @@ -391,6 +401,11 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>  	.gen = MTK_SMI_GEN2,
>  };
>  
> +static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
> +	.gen      = MTK_SMI_GEN2,
> +	.has_gals = true,
> +};
> +
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
>  	{
>  		.compatible = "mediatek,mt8173-smi-common",
> @@ -404,6 +419,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>  		.compatible = "mediatek,mt2712-smi-common",
>  		.data = &mtk_smi_common_gen2,
>  	},
> +	{
> +		.compatible = "mediatek,mt8183-smi-common",
> +		.data = &mtk_smi_common_mt8183,
> +	},
>  	{}
>  };
>  
> 
