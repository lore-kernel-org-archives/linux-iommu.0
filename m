Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730C3C433FE
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 12:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21AB060B52;
	Mon, 28 Feb 2022 12:20:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PwSmotjhg7p2; Mon, 28 Feb 2022 12:20:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0C73760ACD;
	Mon, 28 Feb 2022 12:20:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE66EC0033;
	Mon, 28 Feb 2022 12:20:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 000B1C001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E182C40275
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M2xQy1dRwVt4 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 12:20:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E986F40012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:20:46 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id b5so15197399wrr.2
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 04:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=O2NOZlmqA7RgvZF4C7hoJG5AVQ4LzwSODZXV8jIzeG0=;
 b=ZrWnP68mmzEBBgBVYEcIMymr/Sic0PyF33XFAz9HwOzwsBwZSOuL3daxzw192vv/yw
 u4w9FmdrHcw/PUi+GQ3t4PATV1xvnxjv6Smph9MQWR3lcWgSEnXcgJvVb/fBvB+TZfuj
 du1RNrmOYaQLwN04wqseYfnrJ0nmogX55HvCgjyKWKOdjqa3EzFBEzSj8N6vQi/Q8uTt
 ppPYhdQWebpq/I6OuDQR8QbhVSFigTg5a7FIvUlXnFaVWKGLtkhKF7dqKgJCRy7py8zV
 nDMJPSDcKTrDsx+Q3721fQSebTDT7LJHc8EIVL2qkjzOCzv2F14YcsZVXVhT5MdlZFvF
 5/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=O2NOZlmqA7RgvZF4C7hoJG5AVQ4LzwSODZXV8jIzeG0=;
 b=zNA+xFxQhaXiDgVxeIff/NzO5sDedV2qVMRKSwYDLNS+KkPNU/12GQVPRoY7mbN5L+
 W1btgciiWq0hxoRzwSuGDu/iWJhZfrlOKk5PuxDduXRmyY/2cPIfEhgszUxmMPFYgNjP
 OY45bjS+bZKTVHBA51ntWVx+faMqpwOA8edFeNgv8+PAwnHJcFSOQDHV6AslDHtm9snl
 HlEQ3qtbbftSOr1tDfItkKln2TOM1Idsc35ubN7/n4Q+ByR8rlJPq0tAKPwZy038kAlL
 JXaPTd8V86FemRLGbLznxAC3rr+fo/S3HldP6r7JT0C4U0FqprOtXrAhTYuHDvOWKSin
 k/Kg==
X-Gm-Message-State: AOAM533Ssm3RnrRU5gwFHb4L3H2wGxdKzxSnpCLNDDrwZTu6acgqyTt7
 pSb61pNXbvJHDbcxwCJ6KjE=
X-Google-Smtp-Source: ABdhPJwLaVfMPHuk8PUaO5u3HtsyXrViUDwFSuAZmGbc36/B95ADkzmeSzxSbvAicTIRVC/nO9f3Lg==
X-Received: by 2002:a5d:6d83:0:b0:1ef:d78a:41fb with SMTP id
 l3-20020a5d6d83000000b001efd78a41fbmr2817571wrs.355.1646050845207; 
 Mon, 28 Feb 2022 04:20:45 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net.
 [188.85.182.63]) by smtp.gmail.com with ESMTPSA id
 a3-20020adfe5c3000000b001e68a5e1c20sm10460233wrn.4.2022.02.28.04.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 04:20:44 -0800 (PST)
Message-ID: <d4c5b734-1a29-8359-e5fa-b53fc58dd3e5@gmail.com>
Date: Mon, 28 Feb 2022 13:20:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] iommu/mediatek: Add mt8186 iommu support
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
References: <20220223072402.17518-1-yong.wu@mediatek.com>
 <20220223072402.17518-3-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220223072402.17518-3-yong.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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



On 23/02/2022 08:24, Yong Wu wrote:
> Add mt8186 iommu supports.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index d9ca9ffe404c..174a2f3bd68a 100644
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
> @@ -1438,6 +1439,21 @@ static const struct mtk_iommu_plat_data mt8183_data = {
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
> @@ -1507,6 +1523,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
>   	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>   	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>   	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
> +	{ .compatible = "mediatek,mt8186-iommu-mm",    .data = &mt8186_data_mm}, /* mm: m4u */
>   	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
>   	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
>   	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
