Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170F7C433FE
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 08:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9C8C81BC6;
	Tue,  3 May 2022 08:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n2X588iLgMqb; Tue,  3 May 2022 08:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 982268275A;
	Tue,  3 May 2022 08:54:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 390F5C0032;
	Tue,  3 May 2022 08:54:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D221C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 08:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5505581BC6
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 08:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e4xAjCk8er0d for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 08:53:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6961B8266D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 08:53:55 +0000 (UTC)
X-UUID: 3c2efbe4fa264e4b9cfaf02165c9a960-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:3ac4fcfd-5f2d-4bad-aa59-9ee3058359d0, OB:0,
 LO
 B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:-12
X-CID-META: VersionHash:faefae9, CLOUDID:f3664ec7-85ee-4ac1-ac05-bd3f1e72e732,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 3c2efbe4fa264e4b9cfaf02165c9a960-20220503
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 874287507; Tue, 03 May 2022 16:53:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Tue, 3 May 2022 16:53:45 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 3 May 2022 16:53:44 +0800
Message-ID: <015b314d693ec66429d1b5516cf9c5621665eea2.camel@mediatek.com>
Subject: Re: [PATCH 2/2] iommu/mediatek: Enable allocating page table in
 normal memory
To: <yf.wang@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, "open
 list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>, "moderated
 list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>, "moderated
 list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, "open
 list" <linux-kernel@vger.kernel.org>
Date: Tue, 3 May 2022 16:53:44 +0800
In-Reply-To: <20220429143411.7640-3-yf.wang@mediatek.com>
References: <20220429143411.7640-1-yf.wang@mediatek.com>
 <20220429143411.7640-3-yf.wang@mediatek.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: Ning Li <ning.li@mediatek.com>, stable@vger.kernel.org,
 Libo Kang <Libo.Kang@mediatek.com>, wsd_upstream@mediatek.com
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

Hi YF,

Thanks very much for this patch. Nearly all the lastest SoC like
mt8192/mt8195 support this.

On Fri, 2022-04-29 at 22:34 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Add the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT support, so that
> level 2 page table can allocate in normal memory.

Could you help comment more detailedly here and in the title?, this
patch just allows the level 2 pgtable PA up to 35bits, not only in
ZONE_DMA32(GFP_DMA32).

> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> Cc: <stable@vger.kernel.org> # 5.10.*

If you add this for stable, Which commit do you need for "Fixes:" tag?

It looks you add a new feature, rather than fixing a bug of the current
kernel. I didn't get a issue report for this. If this is a bug, we need
more information like under which condition/SoC the error will occur.

The code is ok for me.

Thanks.

> ---
>  drivers/iommu/mtk_iommu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6fd75a60abd6..27481f562df7 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -118,6 +118,7 @@
>  #define WR_THROT_EN			BIT(6)
>  #define HAS_LEGACY_IVRP_PADDR		BIT(7)
>  #define IOVA_34_EN			BIT(8)
> +#define PGTABLE_L2_PA_35_EN		BIT(9)
>  
>  #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>  		((((pdata)->flags) & (_x)) == (_x))
> @@ -401,6 +402,9 @@ static int mtk_iommu_domain_finalise(struct
> mtk_iommu_domain *dom,
>  		.iommu_dev = data->dev,
>  	};
>  
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_L2_PA_35_EN))
> +		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT;
> +
>  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
>  		dom->cfg.oas = data->enable_4GB ? 33 : 32;
>  	else
> @@ -1038,7 +1042,8 @@ static const struct mtk_iommu_plat_data
> mt2712_data = {
>  
>  static const struct mtk_iommu_plat_data mt6779_data = {
>  	.m4u_plat      = M4U_MT6779,
> -	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN,
> +	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN |
> +			 PGTABLE_L2_PA_35_EN,
>  	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
>  	.iova_region   = single_domain,
>  	.iova_region_nr = ARRAY_SIZE(single_domain),

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
