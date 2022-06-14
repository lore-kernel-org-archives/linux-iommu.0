Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD325C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 15:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55AE7832D0;
	Tue, 14 Jun 2022 15:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Odm7ZXbCGbb2; Tue, 14 Jun 2022 15:15:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F13D832BF;
	Tue, 14 Jun 2022 15:15:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 129CDC0032;
	Tue, 14 Jun 2022 15:15:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50DCCC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 15:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3195E832D0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 15:15:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2TAUAeFlIqC for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 15:15:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69545832BF
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 15:15:02 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id c21so11759483wrb.1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=IXuDe0y1N7g0HQ+gRNGCz3TLBK6SHrrUtGI9qXS70nI=;
 b=pNE5vPgqmLRxJYRUwLn2HygBM6ytJdDox1fo8PavsqAlLYbvUXKHMA7QW/EKefImgn
 vCsmD6HVBAt1GjEMoJvYBgbfgyAcZBE9j+BAjgaRHWxosTq/rTgYCpc81ougivQSnSdo
 MQrnA/hMkYQ0J3u4SGpJxbsKjp0OZpX3yjrZ0xGxhZPOG3Ltop5iqtB9VcRT1Wy3GfK9
 IEQarUkCk6Or41YYY1+vKUsT2qQLqaMG2LJXsL0baMqYWDGHgxxz1wjVelA8DEq+YcTf
 0iNIa9bByS4Ue98OyUC31rOtmb+CHhqr3S9W3EGxGkxx/V85oRMN2Mrdp9DUCwhFAhYe
 MP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=IXuDe0y1N7g0HQ+gRNGCz3TLBK6SHrrUtGI9qXS70nI=;
 b=W6hXETQcm0ayUU2S9qZWwyDxhWPT2i1uOVD3dpuA19FcizWNUPwPWJTyjiWPjnCjT2
 pc2z607Oyq7NpfcIOdtcYk3jmRzIb6AW1L15KPpZd1+40HE+cxPRrE7xiEZ7IBhP8soS
 NMjyEItlUDKSatI7CbnH2Lq586bxcAVM/4BSkMZ6jQSDU7JTraK+eLuf7cuzbu7CsSnt
 OuRiG6S+/nBJl3CaWn58MTHxV7ZH8OC+ptRQitrOGbqBahb7MS1hgPJKrayhH7MbhEfe
 9/B/+nLDINdwdxYDaCPi3i6F1D3qjXG8EmzkKy/xOUQHOIH6OZkzW5RZpoNdQn2d/Emv
 t5Vg==
X-Gm-Message-State: AJIora+KtllZBF2vRiYI+2Kox0PSZt2oEdg0jgWrAEehbZjLXUPBPxbP
 mgt7JAd2l8SU/Cj9Iz4UM6k=
X-Google-Smtp-Source: AGRyM1vbq7YuSWWy21Fn37KJrbY6DIxBAJG8TbMUpC1uDPhvtrmHbIIb6r7vg7XBmdrSGnOv4jXjCw==
X-Received: by 2002:a5d:40c7:0:b0:210:3135:e662 with SMTP id
 b7-20020a5d40c7000000b002103135e662mr5240739wrq.280.1655219700487; 
 Tue, 14 Jun 2022 08:15:00 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
 by smtp.gmail.com with ESMTPSA id
 h206-20020a1c21d7000000b0039746638d6esm13745526wmh.33.2022.06.14.08.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jun 2022 08:14:59 -0700 (PDT)
Message-ID: <da05a10b-dd4d-6d93-0cd3-e4695d9b767e@gmail.com>
Date: Tue, 14 Jun 2022 17:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to infracfg
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-3-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220609100802.54513-3-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, will@kernel.org,
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



On 09/06/2022 12:07, AngeloGioacchino Del Regno wrote:
> This driver will get support for more SoCs and the list of infracfg
> compatibles is expected to grow: in order to prevent getting this
> situation out of control and see a long list of compatible strings,
> add support to retrieve a handle to infracfg's regmap through a
> new "mediatek,infracfg" phandle.
> 
> In order to keep retrocompatibility with older devicetrees, the old
> way is kept in place.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bb9dd92c9898..90685946fcbe 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1140,22 +1140,32 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>   
>   	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> -		switch (data->plat_data->m4u_plat) {
> -		case M4U_MT2712:
> -			p = "mediatek,mt2712-infracfg";
> -			break;
> -		case M4U_MT8173:
> -			p = "mediatek,mt8173-infracfg";
> -			break;
> -		default:
> -			p = NULL;
> +		infracfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,infracfg");
> +		if (IS_ERR(infracfg)) {
> +			/*
> +			 * Legacy devicetrees will not specify a phandle to
> +			 * mediatek,infracfg: in that case, we use the older
> +			 * way to retrieve a syscon to infra.
> +			 *
> +			 * This is for retrocompatibility purposes only, hence
> +			 * no more compatibles shall be added to this.
> +			 */
> +			switch (data->plat_data->m4u_plat) {
> +			case M4U_MT2712:
> +				p = "mediatek,mt2712-infracfg";
> +				break;
> +			case M4U_MT8173:
> +				p = "mediatek,mt8173-infracfg";
> +				break;
> +			default:
> +				p = NULL;
> +			}
> +
> +			infracfg = syscon_regmap_lookup_by_compatible(p);
> +			if (IS_ERR(infracfg))
> +				return PTR_ERR(infracfg);
>   		}
>   
> -		infracfg = syscon_regmap_lookup_by_compatible(p);
> -
> -		if (IS_ERR(infracfg))
> -			return PTR_ERR(infracfg);
> -
>   		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
>   		if (ret)
>   			return ret;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
