Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED925C433E3
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 21:05:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BF1206F4
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 21:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWNEV195"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BF1206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F86822618;
	Wed, 15 Jul 2020 21:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fe4CTvpG5uxi; Wed, 15 Jul 2020 21:05:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 714E8204DF;
	Wed, 15 Jul 2020 21:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52D93C07FF;
	Wed, 15 Jul 2020 21:05:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3A23C0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 21:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B1F878AD6B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 21:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XHa7DUQ2BZMd for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 21:05:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4FF488AD62
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 21:05:13 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id r12so4290062wrj.13
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pMuDrbc0LtOTxt86qt0VfuSZy3PKDlBe9oPpUULHnpQ=;
 b=LWNEV195GUHtZQQKtrKgYeYw564ys5wqPuzKby6I+EG2vKRI64TxxMI0m6hUiCxPQB
 mQIFx1x72NUgFFT5VNMUf4aEO6BU7UpLk8mO8/RThHUeIloAPOY8DoKeEYpE4e99ggn9
 /Ada4uJ6xsISkD+ZGasdyCHRTD6aKwbrCC9oNopCdrHMwZLd7hNaHMbgeZYJAgFf/bgq
 jlkD9/RKP1RkLSFK9NEJxFy1s4d8n+fmrn393DosB3MoexbZttOqRcZVvOgUauBXdWDB
 lp8ZmOXU27x4lvy6FsvFyuAlYOq9e83KLHViurD7r8dxd/2FnROG3HzYREUX6FA9aamV
 5XaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pMuDrbc0LtOTxt86qt0VfuSZy3PKDlBe9oPpUULHnpQ=;
 b=Kpog9Nb4ezqf97eC3MsLKm8hwf5uHfZhhWpyfWPPF/e5rhK+i/+J9Hx3U5nwJ4aYoZ
 zZGRkLi0ccXfo1l994q/E+Vq9CNqUQdGCFpGbDP6sZAMfk6c31s2pL1aLIgnjse+xoM3
 4VKfKJ2qgLYHTpRBEbPS9wKN5cQp+W3MlGKHaBboEQsDYAavbGcCMAPzOWcjrTfew4aR
 jddICxq4tIUbEbuj4Xjg5BdhYl8akWev6BKCw2Cnu4VNjqEU5BjpOluG8hJMDeV0lQcW
 oilIj1Sz7nEkn8A06J2+/7Hh/t0DYvJm5dyZKjjhGjV6+c2G+zdjRYCnAm4SMYpj2VCl
 sbDg==
X-Gm-Message-State: AOAM533ViSFymIbpuJm0lax4DEFDGKyQUr5eXs7DOWA2vRIoL0AyZs1M
 mpbB1GbFRqanRwDj1Ek8T7w=
X-Google-Smtp-Source: ABdhPJyMkIbuf0cWEq7Qews8ZNKgYCbSzRPQ6rJMKaHtnSYodbLUH8RRzfvvdkzlbxuBV2cr+ofKfQ==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr1424074wrq.184.1594847111602; 
 Wed, 15 Jul 2020 14:05:11 -0700 (PDT)
Received: from ziggy.stardust ([213.195.120.199])
 by smtp.gmail.com with ESMTPSA id y77sm5515281wmd.36.2020.07.15.14.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 14:05:10 -0700 (PDT)
Subject: Re: [PATCH 4/4] iommu/mediatek: check 4GB mode by reading infracfg
To: Miles Chen <miles.chen@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>
References: <20200702093721.6063-1-miles.chen@mediatek.com>
 <20200702093721.6063-4-miles.chen@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <84333997-735c-4a91-6d47-1dcb5c4a6078@gmail.com>
Date: Wed, 15 Jul 2020 23:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702093721.6063-4-miles.chen@mediatek.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, Christoph Hellwig <hch@lst.de>,
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



On 02/07/2020 11:37, Miles Chen wrote:
> In previous disscusion [1] and [2], we found that it is risky to
> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> 
> Check 4GB mode by reading infracfg register, remove the usage
> of the unexported symbol max_pfn.
> 
> [1] https://lkml.org/lkml/2020/6/3/733
> [2] https://lkml.org/lkml/2020/6/4/136
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2be96f1cdbd2..09be57bd8d74 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2015-2016 MediaTek Inc.
>    * Author: Yong Wu <yong.wu@mediatek.com>
>    */
> -#include <linux/memblock.h>
>   #include <linux/bug.h>
>   #include <linux/clk.h>
>   #include <linux/component.h>
> @@ -15,11 +14,13 @@
>   #include <linux/iommu.h>
>   #include <linux/iopoll.h>
>   #include <linux/list.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/of_address.h>
>   #include <linux/of_iommu.h>
>   #include <linux/of_irq.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <asm/barrier.h>
> @@ -91,6 +92,9 @@
>   #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
>   #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
>   
> +#define REG_INFRA_MISC				0xf00
> +#define F_DDR_4GB_SUPPORT_EN			BIT(13)
> +

As this is used for infracfg, I think it would be good to add it to 
include/linux/soc/mediatek/infracfg.h and include that file here.

>   #define MTK_PROTECT_PA_ALIGN			128
>   
>   /*
> @@ -599,8 +603,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	struct resource         *res;
>   	resource_size_t		ioaddr;
>   	struct component_match  *match = NULL;
> +	struct regmap		*infracfg_regmap;

Maybe call it just infracfg.

>   	void                    *protect;
>   	int                     i, larb_nr, ret;
> +	u32			val;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -614,10 +620,18 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>   
> -	/* Whether the current dram is over 4GB */
> -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> -	if (!data->plat_data->has_4gb_mode)
> +	if (data->plat_data->has_4gb_mode) {
> +		infracfg_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
> +				"mediatek,infracfg");
> +		if (IS_ERR(infracfg_regmap))
> +			return PTR_ERR(infracfg_regmap);

Do we need to error out, or could we be conservative and set endable_4GB = false?

> +		ret = regmap_read(infracfg_regmap, REG_INFRA_MISC, &val);
> +		if (ret)
> +			return ret;
> +		data->enable_4GB = !!(val & F_DDR_4GB_SUPPORT_EN);
> +	} else {
>   		data->enable_4GB = false;

Move that before the if() and update enable_4GB only in case of has_4gb_mode.

> +	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	data->base = devm_ioremap_resource(dev, res);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
