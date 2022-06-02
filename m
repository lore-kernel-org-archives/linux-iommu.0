Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D58C43334
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 06:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A79CB60B12;
	Thu,  2 Jun 2022 06:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yBSnS7IXxN_s; Thu,  2 Jun 2022 06:18:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08ADC60B73;
	Thu,  2 Jun 2022 06:18:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F55AC0080;
	Thu,  2 Jun 2022 06:18:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E76AC002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 06:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1E6982BE5
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 06:18:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bPV-TE9i9cdE for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 06:18:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD75982BC0
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 06:18:38 +0000 (UTC)
X-UUID: 1eed4d444bfe48c5abd146ff8529dfa1-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:ed063c35-6848-45de-8eb4-a1723bfda1ba, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:-5
X-CID-META: VersionHash:2a19b09, CLOUDID:2050920d-3a0d-4bbe-9d72-0e5d26d57423,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,QS:0,BEC:nil
X-UUID: 1eed4d444bfe48c5abd146ff8529dfa1-20220602
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 428153746; Thu, 02 Jun 2022 14:18:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Thu, 2 Jun 2022 14:18:29 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 14:18:29 +0800
Message-ID: <e970f47d462b0cca9bc6107843721b6b0aabd73a.camel@mediatek.com>
Subject: Re: [PATCH 2/3] iommu: mtk_iommu: add support for 6-bit encoded
 port IDs
To: Fabien Parent <fparent@baylibre.com>
Date: Thu, 2 Jun 2022 14:18:29 +0800
In-Reply-To: <20220530180328.845692-2-fparent@baylibre.com>
References: <20220530180328.845692-1-fparent@baylibre.com>
 <20220530180328.845692-2-fparent@baylibre.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

Hi Fabien,

Thanks for very much for this patch.

Retitle to iommu/mediatek: Xxx

On Mon, 2022-05-30 at 20:03 +0200, Fabien Parent wrote:
> Until now the port ID was always encoded as a 5-bit data. On MT8365,
> the port ID is encoded as a 6-bit data. This requires to rework the
> macros F_MMU_INT_ID_LARB_ID, and F_MMU_INT_ID_PORT_ID in order
> to support 5-bit and 6-bit encoded port IDs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/iommu/mtk_iommu.c | 17 +++++++++++++----
>  drivers/iommu/mtk_iommu.h |  1 +
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6fd75a60abd6..b692347d8d56 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -103,8 +103,10 @@
>  #define REG_MMU1_INT_ID				0x154
>  #define F_MMU_INT_ID_COMM_ID(a)			(((a) >> 9) &
> 0x7)
>  #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
> -#define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) &
> 0x7)
> -#define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) &
> 0x1f)
> +#define F_MMU_INT_ID_LARB_ID(a, port_width)	\
> +				((a) >> ((port_width + 2) & 0x7))
> +#define F_MMU_INT_ID_PORT_ID(a, port_width)	\
> +				(((a) >> 2) & GENMASK(port_width - 1,
> 0))

Add () for port_width.

>  
>  #define MTK_PROTECT_PA_ALIGN			256
>  
> @@ -291,12 +293,13 @@ static irqreturn_t mtk_iommu_isr(int irq, void
> *dev_id)
>  		fault_pa |= (u64)pa34_32 << 32;
>  	}
>  
> -	fault_port = F_MMU_INT_ID_PORT_ID(regval);
> +	fault_port = F_MMU_INT_ID_PORT_ID(regval, data->plat_data-
> >port_width);
>  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM)) {
>  		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
>  		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
>  	} else {
> -		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
> +		fault_larb = F_MMU_INT_ID_LARB_ID(regval,
> +						  data->plat_data-
> >port_width);
>  	}
>  	fault_larb = data->plat_data-
> >larbid_remap[fault_larb][sub_comm];
>  
> @@ -1034,6 +1037,7 @@ static const struct mtk_iommu_plat_data
> mt2712_data = {
>  	.iova_region  = single_domain,
>  	.iova_region_nr = ARRAY_SIZE(single_domain),
>  	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
> +	.port_width   = 5,
>  };
>  
>  static const struct mtk_iommu_plat_data mt6779_data = {
> @@ -1043,6 +1047,7 @@ static const struct mtk_iommu_plat_data
> mt6779_data = {
>  	.iova_region   = single_domain,
>  	.iova_region_nr = ARRAY_SIZE(single_domain),
>  	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
> +	.port_width    = 5,
>  };
>  
>  static const struct mtk_iommu_plat_data mt8167_data = {
> @@ -1052,6 +1057,7 @@ static const struct mtk_iommu_plat_data
> mt8167_data = {
>  	.iova_region  = single_domain,
>  	.iova_region_nr = ARRAY_SIZE(single_domain),
>  	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
> +	.port_width   = 5,
>  };
>  
>  static const struct mtk_iommu_plat_data mt8173_data = {
> @@ -1062,6 +1068,7 @@ static const struct mtk_iommu_plat_data
> mt8173_data = {
>  	.iova_region  = single_domain,
>  	.iova_region_nr = ARRAY_SIZE(single_domain),
>  	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear
> mapping. */
> +	.port_width   = 5,
>  };
>  
>  static const struct mtk_iommu_plat_data mt8183_data = {
> @@ -1071,6 +1078,7 @@ static const struct mtk_iommu_plat_data
> mt8183_data = {
>  	.iova_region  = single_domain,
>  	.iova_region_nr = ARRAY_SIZE(single_domain),
>  	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
> +	.port_width   = 5,
>  };
>  
>  static const struct mtk_iommu_plat_data mt8192_data = {
> @@ -1082,6 +1090,7 @@ static const struct mtk_iommu_plat_data
> mt8192_data = {
>  	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
>  	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
>  			   {0, 14, 16}, {0, 13, 18, 17}},
> +	.port_width     = 5,
>  };
>  
>  static const struct of_device_id mtk_iommu_of_ids[] = {
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index b742432220c5..84cecaf6d61c 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -54,6 +54,7 @@ struct mtk_iommu_plat_data {
>  	enum mtk_iommu_plat m4u_plat;
>  	u32                 flags;
>  	u32                 inv_sel_reg;
> +	u8                  port_width;

Please help rename to int_id_port_width for more detailed from the
register name (REG_MMU0_INT_ID).

>  
>  	unsigned int				iova_region_nr;
>  	const struct mtk_iommu_iova_region	*iova_region;
> -- 
> 2.36.1
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
