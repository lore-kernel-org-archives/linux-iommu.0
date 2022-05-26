Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4DBC433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 08:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9714D8452F;
	Thu, 26 May 2022 08:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ZfW1oNsoPLZ; Thu, 26 May 2022 08:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 70E2D8174D;
	Thu, 26 May 2022 08:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5ABFEC0039;
	Thu, 26 May 2022 08:22:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE67FC002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDB1D8452F
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fp0NopM3rTxF for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:22:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4F268174D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:22:36 +0000 (UTC)
X-UUID: cca026dc720b4357a7fd5e82a9abd24f-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:6d0ff8da-95d9-42a5-b1b0-56d4e6acc1d3, OB:10,
 L
 OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:45
X-CID-INFO: VERSION:1.1.5, REQID:6d0ff8da-95d9-42a5-b1b0-56d4e6acc1d3, OB:10,
 LOB
 :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:45
X-CID-META: VersionHash:2a19b09, CLOUDID:8f9653b8-3c45-407b-8f66-25095432a27a,
 C
 OID:22bc0917443f,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,QS:0,BEC:nil
X-UUID: cca026dc720b4357a7fd5e82a9abd24f-20220526
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1728256351; Thu, 26 May 2022 16:22:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Thu, 26 May 2022 16:22:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 26 May 2022 16:22:29 +0800
Message-ID: <e3202c3ea259329faf9401b7545c7f83191d6fb7.camel@mediatek.com>
Subject: Re: [PATCH v2 3/7] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Thu, 26 May 2022 16:22:28 +0800
In-Reply-To: <20220518100503.37279-4-angelogioacchino.delregno@collabora.com>
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
 <20220518100503.37279-4-angelogioacchino.delregno@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 2022-05-18 at 12:04 +0200, AngeloGioacchino Del Regno wrote:
> On some SoCs (of which only MT8195 is supported at the time of
> writing),
> the "R" and "W" (I/O) enable bits for the IOMMUs are in the
> pericfg_ao
> register space and not in the IOMMU space: as it happened already
> with
> infracfg, it is expected that this list will grow.
> 
> Instead of specifying pericfg compatibles on a per-SoC basis,
> following
> what was done with infracfg, let's lookup the syscon by phandle
> instead.
> Also following the previous infracfg change, add a warning for
> outdated
> devicetrees, in hope that the user will take action.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/mtk_iommu.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index d16b95e71ded..090cf6e15f85 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -138,6 +138,8 @@
>  /* PM and clock always on. e.g. infra iommu */
>  #define PM_CLK_AO			BIT(15)
>  #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> +/* IOMMU I/O (r/w) is enabled using PERICFG_IOMMU_1 register */
> +#define HAS_PERI_IOMMU1_REG		BIT(17)
>  
>  #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>  				((((pdata)->flags) & (mask)) == (_x))
> @@ -187,7 +189,6 @@ struct mtk_iommu_plat_data {
>  	u32			flags;
>  	u32			inv_sel_reg;
>  
> -	char			*pericfg_comp_str;
>  	struct list_head	*hw_list;
>  	unsigned int		iova_region_nr;
>  	const struct mtk_iommu_iova_region	*iova_region;
> @@ -1214,14 +1215,19 @@ static int mtk_iommu_probe(struct
> platform_device *pdev)
>  			goto out_runtime_disable;
>  		}
>  	} else if (MTK_IOMMU_IS_TYPE(data->plat_data,
> MTK_IOMMU_TYPE_INFRA) &&
> -		   data->plat_data->pericfg_comp_str) {
> -		infracfg = syscon_regmap_lookup_by_compatible(data-
> >plat_data->pericfg_comp_str);
> -		if (IS_ERR(infracfg)) {
> -			ret = PTR_ERR(infracfg);
> -			goto out_runtime_disable;
> -		}
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data,
> HAS_PERI_IOMMU1_REG)) {
> +		data->pericfg = syscon_regmap_lookup_by_phandle(dev-
> >of_node, "mediatek,pericfg");

I'm not keen to add this property. Currently only mt8195 use this
setting. In the lastest SoC, we move this setting to ATF. thus I think
we could keep the current way, no need add a new DT property only for
mt8195.

> +		if (IS_ERR(data->pericfg)) {
> +			dev_info(dev, "Cannot find phandle to
> mediatek,pericfg:"
> +				      " Please update your
> devicetree.\n");
>  
> -		data->pericfg = infracfg;
> +			p = "mediatek,mt8195-pericfg_ao";
> +			data->pericfg =
> syscon_regmap_lookup_by_compatible(p);
> +			if (IS_ERR(data->pericfg)) {
> +				ret = PTR_ERR(data->pericfg);
> +				goto out_runtime_disable;
> +			}
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, data);
> @@ -1480,8 +1486,8 @@ static const struct mtk_iommu_plat_data
> mt8192_data = {
>  static const struct mtk_iommu_plat_data mt8195_data_infra = {
>  	.m4u_plat	  = M4U_MT8195,
>  	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE |
> PM_CLK_AO |
> -			    MTK_IOMMU_TYPE_INFRA |
> IFA_IOMMU_PCIE_SUPPORT,
> -	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
> +			    HAS_PERI_IOMMU1_REG | MTK_IOMMU_TYPE_INFRA
> |
> +			    IFA_IOMMU_PCIE_SUPPORT,
>  	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
>  	.banks_num	  = 5,
>  	.banks_enable     = {true, false, false, false, true},

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
