From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] memory: mtk-smi: Use of_device_get_match_data helper
Date: Wed, 2 Aug 2017 10:02:50 +0800
Message-ID: <1501639370.5572.8.camel@mtksdaap41>
References: <1501072660-10435-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1501072660-10435-1-git-send-email-honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2017-07-26 at 20:37 +0800, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> Replace custom code with generic helper to retrieve driver data.

Hi, Joerg, would you please take this one, because my last
patch[1]([patch v2 0/3] Add larbid init routine for mediatek's gen1 smi
larb driver) was base on this patch. Or should I put this one together
with the last patchset[1] and resend it with Matthias's reviewed-by
tag[2]?

[1]https://www.spinics.net/lists/arm-kernel/msg596629.html
[2]https://lkml.org/lkml/2017/7/31/197

thanks
> 
> Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/memory/mtk-smi.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 4afbc41..2b798bb4 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -240,20 +240,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *smi_node;
>  	struct platform_device *smi_pdev;
> -	const struct of_device_id *of_id;
>  
>  	if (!dev->pm_domain)
>  		return -EPROBE_DEFER;
>  
> -	of_id = of_match_node(mtk_smi_larb_of_ids, pdev->dev.of_node);
> -	if (!of_id)
> -		return -EINVAL;
> -
>  	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
>  	if (!larb)
>  		return -ENOMEM;
>  
> -	larb->larb_gen = of_id->data;
> +	larb->larb_gen = of_device_get_match_data(dev);
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	larb->base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(larb->base))
> @@ -319,7 +314,6 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_smi *common;
>  	struct resource *res;
> -	const struct of_device_id *of_id;
>  	enum mtk_smi_gen smi_gen;
>  
>  	if (!dev->pm_domain)
> @@ -338,17 +332,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	if (IS_ERR(common->clk_smi))
>  		return PTR_ERR(common->clk_smi);
>  
> -	of_id = of_match_node(mtk_smi_common_of_ids, pdev->dev.of_node);
> -	if (!of_id)
> -		return -EINVAL;
> -
>  	/*
>  	 * for mtk smi gen 1, we need to get the ao(always on) base to config
>  	 * m4u port, and we need to enable the aync clock for transform the smi
>  	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
>  	 * base.
>  	 */
> -	smi_gen = (enum mtk_smi_gen)of_id->data;
> +	smi_gen = (enum mtk_smi_gen)of_device_get_match_data(dev);
>  	if (smi_gen == MTK_SMI_GEN1) {
>  		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  		common->smi_ao_base = devm_ioremap_resource(dev, res);
