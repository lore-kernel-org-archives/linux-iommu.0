Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B016C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 13:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D739F84022;
	Thu, 16 Jun 2022 13:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Flzi4k7n6x3X; Thu, 16 Jun 2022 13:49:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 78CF084018;
	Thu, 16 Jun 2022 13:49:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D35DC0032;
	Thu, 16 Jun 2022 13:49:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51291C002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 13:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39F7C84022
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 13:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1my7ghm2RHcD for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 13:49:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E38984018
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 13:49:48 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id w17so1961033wrg.7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=vMYX8vVEMVSTBnRO4T8a2iTEzySbI9JJmfib14Jv9h0=;
 b=oHZ/WlVy8bLQzX5XPSluY6fi8t4wrJHCh2DNNHWAK5yiyH5xZ9COwCQrs9ZfP+6ptJ
 93ySFOJe9wfCGwWXgHnar7m/6aGDnD0S1O+HxPC6xSk+cexyKjWkbP7CtFeceQJSn23R
 v1G63z1Dcox5wBclBjv9DRSavVbCjhO7hmFUmwX86Rnry/7oE4lazYOsHA8QrlPHgztj
 uR4PVch1A9250cKszi6i7e8YGVJtaKtiXz8JGxthLI1rLdfhbPsSKvbHGV5eoaEnr6rT
 Du4Tomd7n70SIuNSI7H8BbB7wi5Tzqpa8naYoVpfCcP1QttROIseu+D9zm/KshxSL+jU
 h+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vMYX8vVEMVSTBnRO4T8a2iTEzySbI9JJmfib14Jv9h0=;
 b=tpBvLyF2Ch7KlvsfYQjtm7RsiL2nem2iIA7PE3CyKTr2AS/54Ty50OFdzczP/+9kg6
 BODcXdnZ+on4eIvPFK/e2c+7FJwjOyzu7PZPOb8nXnydLC1/NkrComw9XkpZWwimHH0W
 6n7MCwChO8TnGjSyqCkZxgQOShLxBWJnbsQdbbjju8O6mYa8603vwakz03TRIK21e1tq
 jVHgTEffzcjsJOfzw7duRMb8Ec1ItZZwV9a2CLK97j4CW6r1keyNIzoHOdkGiKA6jroB
 1JlWVaCkkLRArForn2E2TC6RqdtPw6jVclVayKXzU4DEoCrATo54s16qCdt6ez53Ccoz
 WR1g==
X-Gm-Message-State: AJIora9yxga+408JKi72pBSkBKgvSnTENDx64Kbri/+o1b9rL1cmki3T
 qAmHbQSCgBHRIbshiSUZi7s=
X-Google-Smtp-Source: AGRyM1s9twy4XfOTRNf07Dn5/dC+PXKASOKIAn/okFRK8bJikDResr8hjVSbZIf2IlwH1J8fURxW2Q==
X-Received: by 2002:a05:6000:170e:b0:218:3fe0:7c72 with SMTP id
 n14-20020a056000170e00b002183fe07c72mr4971478wrc.572.1655387386601; 
 Thu, 16 Jun 2022 06:49:46 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a05600c4ed000b0039c5497deccsm13646132wmq.1.2022.06.16.06.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jun 2022 06:49:45 -0700 (PDT)
Message-ID: <22c40a7f-d759-5b4a-f554-cf679102d91f@gmail.com>
Date: Thu, 16 Jun 2022 15:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Add error path for loop of
 mm_dts_parse
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-3-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616054203.11365-3-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com, yf.wang@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Dan Carpenter <dan.carpenter@oracle.com>, Guenter Roeck <groeck@chromium.org>,
 mingyuan.ma@mediatek.com, linux-arm-kernel@lists.infradead.org,
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



On 16/06/2022 07:42, Yong Wu wrote:
> The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the i+1
> larb is parsed fail(return -EINVAL), we should of_node_put for the 0..i
> larbs. In the fail path, one of_node_put matches with of_parse_phandle in
> it.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 3b2489e8a6dd..ab24078938bf 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1071,12 +1071,12 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   

Don't we need to call the goto also on error case of:

larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);


Regards,
Matthias


>   		plarbdev = of_find_device_by_node(larbnode);
>   		if (!plarbdev) {
> -			of_node_put(larbnode);
> -			return -ENODEV;
> +			ret = -ENODEV;
> +			goto err_larbnode_put;
>   		}
>   		if (!plarbdev->dev.driver) {
> -			of_node_put(larbnode);
> -			return -EPROBE_DEFER;
> +			ret = -EPROBE_DEFER;
> +			goto err_larbnode_put;
>   		}
>   		data->larb_imu[id].dev = &plarbdev->dev;
>   
> @@ -1107,9 +1107,20 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
>   	if (!link) {
>   		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_larbnode_put;
>   	}
>   	return 0;
> +
> +err_larbnode_put:
> +	while (i--) {
> +		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
> +		if (larbnode && of_device_is_available(larbnode)) {
> +			of_node_put(larbnode);
> +			of_node_put(larbnode);
> +		}
> +	}
> +	return ret;
>   }
>   
>   static int mtk_iommu_probe(struct platform_device *pdev)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
