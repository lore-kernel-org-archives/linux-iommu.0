From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 13/15] memory: mtk-smi: Get rid of need_larbid
Date: Mon, 3 Dec 2018 00:04:43 +0100
Message-ID: <21767ceb-1db5-045f-06ac-29c57f1a74a5@gmail.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
 <1542422142-30688-14-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542422142-30688-14-git-send-email-yong.wu@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: iommu@lists.linux-foundation.org



On 17/11/2018 03:35, Yong Wu wrote:
> The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> It's no need to parse it again in SMI driver. Only clean some codes.
> This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> and mt8183.

I'm trying to understand why we need the mediatek,larb-id at all. From what I
understand as long as the mediatek larbs described in the iommu are ordered
(larb0, larb1, larb2, etc) we actually get the same value as defined by
mediatek,larb-id. At least this holds for all present implementations.

On the other hand I don't see where the mtk_iommu_v1 driver actually parses the
larb-id, can you please help to understand:

1) why we need the larb-id at all
2) how this will work if we do not parse the larb-id for v1 iommu at all

Thanks a lot,
Matthias

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e4daabb..e0265fe 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
>  };
>  
>  struct mtk_smi_larb_gen {
> -	bool need_larbid;
>  	int port_in_larb[MTK_LARB_NR_MAX + 1];
>  	void (*config_port)(struct device *);
>  	unsigned int larb_special_mask; /* The special larbs mask. */
> @@ -152,18 +151,9 @@ void mtk_smi_larb_put(struct device *larbdev)
>  	struct mtk_smi_iommu *smi_iommu = data;
>  	unsigned int         i;
>  
> -	if (larb->larb_gen->need_larbid) {
> -		larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> -		return 0;
> -	}
> -
> -	/*
> -	 * If there is no larbid property, Loop to find the corresponding
> -	 * iommu information.
> -	 */
> -	for (i = 0; i < smi_iommu->larb_nr; i++) {
> +	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
>  		if (dev == smi_iommu->larb_imu[i].dev) {
> -			/* The 'mmu' may be updated in iommu-attach/detach. */
> +			larb->larbid = i;
>  			larb->mmu = &smi_iommu->larb_imu[i].mmu;
>  			return 0;
>  		}
> @@ -242,7 +232,6 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  };
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
> -	.need_larbid = true,
>  	.port_in_larb = {
>  		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
>  		LARB2_PORT_OFFSET, LARB3_PORT_OFFSET
> @@ -251,13 +240,11 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  };
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
> -	.need_larbid = true,
>  	.config_port = mtk_smi_larb_config_port_gen2_general,
>  	.larb_special_mask = BIT(8) | BIT(9), /* bdpsys */
>  };
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> -	.need_larbid = true,
>  	.config_port = mtk_smi_larb_config_port_gen2_general,
>  	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
>  };
> @@ -289,7 +276,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *smi_node;
>  	struct platform_device *smi_pdev;
> -	int err;
>  
>  	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
>  	if (!larb)
> @@ -316,15 +302,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  		return PTR_ERR(larb->smi.clk_gals0);
>  	larb->smi.dev = dev;
>  
> -	if (larb->larb_gen->need_larbid) {
> -		err = of_property_read_u32(dev->of_node, "mediatek,larb-id",
> -					   &larb->larbid);
> -		if (err) {
> -			dev_err(dev, "missing larbid property\n");
> -			return err;
> -		}
> -	}
> -
>  	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
>  	if (!smi_node)
>  		return -EINVAL;
> 
