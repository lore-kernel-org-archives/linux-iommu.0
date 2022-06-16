Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D04C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 13:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4849160B59;
	Thu, 16 Jun 2022 13:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o5p41rj0E7lF; Thu, 16 Jun 2022 13:03:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 355FA607C7;
	Thu, 16 Jun 2022 13:03:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D511C0039;
	Thu, 16 Jun 2022 13:03:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8064C002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 13:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7C34408C4
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 13:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wuGdpOUnDN3U for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 13:03:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE758408A4
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 13:03:48 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id m24so1787459wrb.10
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:content-language:to:cc
 :references:from:subject:in-reply-to:content-transfer-encoding;
 bh=1dVwRcvX/zX2ZvyZyllNzIEz5OjgRw64ZDWPHeywZC8=;
 b=NLgcwNvhdW5LkWEv0Uj6WMcBuQS0Z1MM6opxaEO69IsazSgL5o/21eqAo114sQwXs2
 ZkXtQWXYFdjoNejhiOflb2NYwFTOrZCmVk+R4LosZsDdyZD9GX1+SdXppbuI+3Pl4Dwj
 oZ8LDWShTIDXYFrDt/VL60KBQZskZjrfS9Ujd846ylIsSkNqoYV821AlLBcV1M9k4Uni
 hvgWGjpA7tm8/uhmXNgYXzdZOlb/YAz+dFGZZ3YQFjV1IgK0SCNKEgtcekb73M/l0LwD
 Ea1mOJ4TPFkQ1t9gp7J5SSIcpPoZBufsHPVIxTtW0SXqdT9uP7HfY8MR7wZZT1DYNsT9
 tDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:subject:in-reply-to
 :content-transfer-encoding;
 bh=1dVwRcvX/zX2ZvyZyllNzIEz5OjgRw64ZDWPHeywZC8=;
 b=cm0re0dyc112jrhO/Ai2XN/zRUpYuwFP1CeoxnWZ7JRWzwq9/nvgY1s16DJuK6T+AA
 K4K4OUsMvLwGlVBj5mGnMA5Us1rFyfmn2JnEpAx0D7ya62MtNCMZvFpe+1u1SPg5FFQo
 jPdXb7dQeIuLTIlvu8E/ZmcPwGWtipfMBaSkT0Atk6RxZ6CJPTiZlqGtW7Lc/SjlWgf1
 KIjP5tpAacdS4NRWWKwhGTGRMlJu0PwCsXv3Ud5nK4OIrAvweF/DMT2FeCSh5bF155Q+
 EiQTZtkGtbchlLk+1TpXp5z8ytVaOq8v6CuQuxHt116dP6PMB9TuwvWABaHfsn8IZFwZ
 ls2Q==
X-Gm-Message-State: AJIora+J1fx3dOj+ptK+V7DZW6ltCpxWByG3OI+0p5QxNFEbKEQnHE5Z
 1c2YdMjtdi1ZJMK90NwUaDE=
X-Google-Smtp-Source: AGRyM1sv4JO3boUQn0I7JKR24E8LVGw6lqUPTDh/dIC/Y2zXeT22ejoujCVHN0znkQkj4DjGS0zThA==
X-Received: by 2002:a05:6000:a0b:b0:219:f87e:86b with SMTP id
 co11-20020a0560000a0b00b00219f87e086bmr4647358wrb.570.1655384627020; 
 Thu, 16 Jun 2022 06:03:47 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c4f4f00b0039748be12dbsm6319155wmq.47.2022.06.16.06.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jun 2022 06:03:46 -0700 (PDT)
Message-ID: <f47513f3-e1a9-1764-9954-cdf6931281a9@gmail.com>
Date: Thu, 16 Jun 2022 15:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
 <20220616110830.26037-6-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 5/5] iommu/mediatek: Cleanup pericfg lookup flow
In-Reply-To: <20220616110830.26037-6-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, miles.chen@mediatek.com, will@kernel.org,
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



On 16/06/2022 13:08, AngeloGioacchino Del Regno wrote:
> Since only the INFRA type IOMMU needs to modify register(s) in the
> pericfg iospace, it's safe to drop the pericfg_comp_str NULL check;
> also, directly assign the regmap handle to data->pericfg instead of
> to the infracfg variable to improve code readability.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 90685946fcbe..b2ae84046249 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1217,15 +1217,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			dev_err(dev, "mm dts parse fail(%d).", ret);
>   			goto out_runtime_disable;
>   		}
> -	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> -		   data->plat_data->pericfg_comp_str) {
> -		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
> -		if (IS_ERR(infracfg)) {
> -			ret = PTR_ERR(infracfg);
> +	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
> +		p = data->plat_data->pericfg_comp_str;
> +		data->pericfg = syscon_regmap_lookup_by_compatible(p);
> +		if (IS_ERR(data->pericfg)) {
> +			ret = PTR_ERR(data->pericfg);
>   			goto out_runtime_disable;
>   		}
> -
> -		data->pericfg = infracfg;
>   	}
>   
>   	platform_set_drvdata(pdev, data);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
