Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA30C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 13:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3156B40AA7;
	Thu, 16 Jun 2022 13:28:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RH5Mv2Gcb-Mh; Thu, 16 Jun 2022 13:28:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38FF740492;
	Thu, 16 Jun 2022 13:28:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10E07C0032;
	Thu, 16 Jun 2022 13:28:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA97CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 13:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C73EF60A69
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 13:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sv1Gz7o4f2bz for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 13:28:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 157D5605E0
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 13:28:37 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id v14so1894020wra.5
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=8h+FpcXrrgVVoUz/iXyZW+h/bqUW6xveKHdamK/cuQc=;
 b=a998jYD2CZKZZJVPrXyeBC/bJFux5MWHfso4bLTv11q7pyesMZCgv6WDOku9YPqUvN
 FDO7eR32YMlOe5kqaNv2yHLYNYJoiH6vO2OsGb8ebqOlPhV7cgdAwR1XqfKuhU6XIxMC
 PbYddJwmRfjU352RIVPwrjRL0TvqL9DkN3gq9ORZzp2kx06lrCfYe4G1JqzzvCf9MtJ2
 IIf+uhCuWz9ReVq4LmWp8OK/fNqP6QpLWUJtZKS4JxpCMjvqewjRX21/4VV938rWiKhr
 2IErU1R/CFnngTA39KwYkqVv+idN2Xl0GNfF2QS4Up29Yg8c753g4dUoRGvuNYzYhcgp
 qy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8h+FpcXrrgVVoUz/iXyZW+h/bqUW6xveKHdamK/cuQc=;
 b=CexX8k8Qe+KeQ1oYV/WJQSdKtdO0JxtiGDDKCee+3gXnyGqDzb9LRDgxf7sehJwhSp
 U+CwTdVbl/6QMcMIKKqLqtxcx0y0Jqk/L0z49Cx9247XYZNvgL0pitFbzx1PmiRfNGiZ
 GLcf/iTNwXEUNj8qsaz8O2s5pCH5s+RJVhlDj4fX7G34gpM06hRF+lqWKF2gSilpCNX5
 lbwsAbTWeuQkrdaQiY3xllJgE1uNg0xJST65y57dwMiPwf4V51bfO3vTTCIvUPlkI4Hr
 ksKhmIGGp9VeHcvdEud1GHNu9RqGz/JFPuqNySV9BzXAgBJIrmDaQmCj3uDOFkV+ezkW
 EsjA==
X-Gm-Message-State: AJIora8qBpDtfpz02ODw0YKBKDkajxxq/i21f6C+GQlSTiga9PpNs7/X
 tZobrOKrdeO8PtPRrYS6Zrc=
X-Google-Smtp-Source: AGRyM1unnhtSqt7GBcBXkXPGLTuYxnFiOMYFOgsWaPoDEka0FPVYkml3TItU5PtGNRR2Jfz0hmT2dg==
X-Received: by 2002:adf:fe90:0:b0:210:7e22:186e with SMTP id
 l16-20020adffe90000000b002107e22186emr4837864wrr.321.1655386115274; 
 Thu, 16 Jun 2022 06:28:35 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
 by smtp.gmail.com with ESMTPSA id
 bg27-20020a05600c3c9b00b003974d0d981dsm6360986wmb.35.2022.06.16.06.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jun 2022 06:28:34 -0700 (PDT)
Message-ID: <085be77f-3833-628e-b76a-b2b888db3b78@gmail.com>
Date: Thu, 16 Jun 2022 15:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/5] iommu/mediatek: Use dev_err_probe to mute
 probe_defer err log
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-2-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616054203.11365-2-yong.wu@mediatek.com>
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



On 16/06/2022 07:41, Yong Wu wrote:
> Mute the probe defer log:
> 
> [    2.654806] mtk-iommu 14018000.iommu: mm dts parse fail(-517).
> [    2.656168] mtk-iommu 1c01f000.iommu: mm dts parse fail(-517).
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bb9dd92c9898..3b2489e8a6dd 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1204,7 +1204,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
>   		ret = mtk_iommu_mm_dts_parse(dev, &match, data);
>   		if (ret) {
> -			dev_err(dev, "mm dts parse fail(%d).", ret);
> +			dev_err_probe(dev, ret, "mm dts parse fail.");
>   			goto out_runtime_disable;
>   		}
>   	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
