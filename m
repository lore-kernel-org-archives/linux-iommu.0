From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] memory: mtk-smi: add larbid handle routine
Date: Mon, 31 Jul 2017 11:32:01 +0200
Message-ID: <18e1c24a-529d-85ef-0027-90c491927d6b@gmail.com>
References: <1501239343-9190-1-git-send-email-honghui.zhang@mediatek.com>
	<1501239343-9190-2-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1501239343-9190-2-git-send-email-honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
To: honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xinping.qian-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 07/28/2017 12:55 PM, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
> the larb->larbid was added but not initialized.
> Mediatek's gen1 smi need this hardware larbid information to get the
> register offset which controls whether enable iommu for this larb.
> This patch add the initialize routine for larbid.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>   drivers/memory/mtk-smi.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 2b798bb4..8f75aaa 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -42,6 +42,7 @@
>   #define SMI_SECUR_CON_VAL_DOMAIN(id)	(0x3 << ((((id) & 0x7) << 2) + 1))
>   
>   struct mtk_smi_larb_gen {
> +	bool need_larbid;
>   	int port_in_larb[MTK_LARB_NR_MAX + 1];
>   	void (*config_port)(struct device *);
>   };
> @@ -214,6 +215,7 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
>   };
>   
>   static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
> +	.need_larbid = true,
>   	.port_in_larb = {
>   		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
>   		LARB2_PORT_OFFSET, LARB3_PORT_OFFSET
> @@ -240,6 +242,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *smi_node;
>   	struct platform_device *smi_pdev;
> +	int err;
>   
>   	if (!dev->pm_domain)
>   		return -EPROBE_DEFER;
> @@ -263,6 +266,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>   		return PTR_ERR(larb->smi.clk_smi);
>   	larb->smi.dev = dev;
>   
> +	if (larb->larb_gen->need_larbid) {
> +		err = of_property_read_u32(dev->of_node, "mediatek,larbid",
> +					   &larb->larbid);
> +		if (err) {
> +			dev_err(dev, "missing larbid property\n");
> +			return err;
> +		}
> +	}
> +
>   	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
>   	if (!smi_node)
>   		return -EINVAL;
> 
