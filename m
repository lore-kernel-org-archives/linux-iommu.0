Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3729C433F5
	for <iommu@archiver.kernel.org>; Thu, 27 Jan 2022 11:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59D70402FD;
	Thu, 27 Jan 2022 11:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bqD0ezBKAuK3; Thu, 27 Jan 2022 11:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 457F8402BE;
	Thu, 27 Jan 2022 11:28:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2700BC001A;
	Thu, 27 Jan 2022 11:28:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17006C000B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2C88402F7
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UrM2YONe6ihC for <iommu@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 11:28:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 389B8402BE
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:28:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 934561F44D11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1643282889;
 bh=tRSGAn+K5lE0jIyL6d10FGdtoQ5plQ6Gd8gK6e70TDc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QMQ2KMFmQ8Muyj4PD+nsEkDusL+3Le1HAf+PyV0B5LaEpDOS9yuBN3tX3/48jgh51
 1vVHJTkxsWlTJZhgAudQo4NlkD0l03EmQTjY7XoljShFAx7/ZtKCEjqFsaPwIN8Y43
 uiiHLXbvldGhLSNdoKCATEHwKiQjiTc6mX2qIG/srxslY9lfO4p92sRAUbPik7+OKt
 +LykDgTGRNu4x3XaexjayQpkIA8EKtXIvKhfqYpC0TWe7RbYSBLPBhLQiGyJIORepk
 L0F0/Bq+k+o5W5QZRWnvkGqZNHd4wBG6B6bAQm8kmR3j5O9brpuBlNzKDY/T/XkWb0
 ozfpATJ5aBJtg==
Subject: Re: [PATCH 2/2] iommu/mediatek: Add mt8186 iommu support
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220125093244.18230-1-yong.wu@mediatek.com>
 <20220125093244.18230-3-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <b52a1df8-58f4-baa2-cfb6-9c56244caa0f@collabora.com>
Date: Thu, 27 Jan 2022 12:28:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125093244.18230-3-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 25/01/22 10:32, Yong Wu ha scritto:
> Add mt8186 iommu supports.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index be36e73e4bcc..a3124f48f9e1 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -160,6 +160,7 @@ enum mtk_iommu_plat {
>   	M4U_MT8167,
>   	M4U_MT8173,
>   	M4U_MT8183,
> +	M4U_MT8186,
>   	M4U_MT8192,
>   	M4U_MT8195,
>   };
> @@ -1401,6 +1402,21 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>   	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
>   };
>   
> +static const struct mtk_iommu_plat_data mt8186_data_mm = {
> +	.m4u_plat       = M4U_MT8186,
> +	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
> +			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE |
> +			  MTK_IOMMU_TYPE_MM,
> +	.larbid_remap   = {{0}, {1, MTK_INVALID_LARBID, 8}, {4}, {7}, {2}, {9, 11, 19, 20},
> +			   {MTK_INVALID_LARBID, 14, 16},
> +			   {MTK_INVALID_LARBID, 13, MTK_INVALID_LARBID, 17}},
> +	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
> +	.banks_num      = 1,
> +	.banks_enable   = {true},
> +	.iova_region    = mt8192_multi_dom,
> +	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
> +};
> +
>   static const struct mtk_iommu_plat_data mt8192_data = {
>   	.m4u_plat       = M4U_MT8192,
>   	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
> @@ -1470,6 +1486,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
>   	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>   	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>   	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
> +	{ .compatible = "mediatek,mt8186-iommu-mm", .data = &mt8186_data_mm},

Hello!

Is there any particular reason why this compatible is not "mediatek,mt8186-m4u"?

Thanks,
Angelo

>   	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
>   	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
>   	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
