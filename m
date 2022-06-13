Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BABC43334
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 05:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B13E415FB;
	Mon, 13 Jun 2022 05:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IyJDXsA21TtA; Mon, 13 Jun 2022 05:32:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01144415F8;
	Mon, 13 Jun 2022 05:32:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA289C0039;
	Mon, 13 Jun 2022 05:32:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13167C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 05:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E790082AA9
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 05:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2bhwe8TzFD-6 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 05:32:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 590C982A95
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 05:32:20 +0000 (UTC)
X-UUID: 9ee67c5fe89c49fc8f7ab112d626839a-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:1c75e76a-1de9-419b-8628-4e8cf355f994, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:2a19b09, CLOUDID:1e5157c6-12ba-4305-bfdf-9aefbdc32516,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,QS:0,BEC:nil
X-UUID: 9ee67c5fe89c49fc8f7ab112d626839a-20220613
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 910888798; Mon, 13 Jun 2022 13:32:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Mon, 13 Jun 2022 13:32:12 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 13 Jun 2022 13:32:11 +0800
Message-ID: <db422fe4d0b5391ee2aacae989d7e48209e1095f.camel@mediatek.com>
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Mon, 13 Jun 2022 13:32:11 +0800
In-Reply-To: <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
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

On Thu, 2022-06-09 at 12:08 +0200, AngeloGioacchino Del Regno wrote:
> On some SoCs (of which only MT8195 is supported at the time of
> writing),
> the "R" and "W" (I/O) enable bits for the IOMMUs are in the
> pericfg_ao
> register space and not in the IOMMU space: as it happened already
> with
> infracfg, it is expected that this list will grow.

Currently I don't see the list will grow. As commented before, In the
lastest SoC, The IOMMU enable bits for IOMMU will be in ATF, rather
than in this pericfg register region. In this case, Is this patch
unnecessary? or we could add this patch when there are 2 SoCs use this
setting at least?  what's your opinion?

> 
> Instead of specifying pericfg compatibles on a per-SoC basis,
> following
> what was done with infracfg, let's lookup the syscon by phandle
> instead.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/mtk_iommu.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 90685946fcbe..0ea0848581e9 100644
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
> @@ -1218,14 +1219,16 @@ static int mtk_iommu_probe(struct
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
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data,
> HAS_PERI_IOMMU1_REG)) {
> +		data->pericfg = syscon_regmap_lookup_by_phandle(dev-
> >of_node, "mediatek,pericfg");
> +		if (IS_ERR(data->pericfg)) {
> +			p = "mediatek,mt8195-pericfg_ao";
> +			data->pericfg =
> syscon_regmap_lookup_by_compatible(p);

Upstream doesn't have the mt8195 iommu node currently, thus We don't
need to recover for the previous dts case. right?

> +			if (IS_ERR(data->pericfg)) {
> +				ret = PTR_ERR(data->pericfg);
> +				goto out_runtime_disable;
> +			}
>  		}
> -
> -		data->pericfg = infracfg;
>  	}
>  
>  	platform_set_drvdata(pdev, data);
> @@ -1484,8 +1487,8 @@ static const struct mtk_iommu_plat_data
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
