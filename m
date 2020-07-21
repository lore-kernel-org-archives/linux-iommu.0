Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3439C433E4
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 09:40:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989DD20672
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 09:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7ygYoSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989DD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 654092632A;
	Tue, 21 Jul 2020 09:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NSujrSP6lO0Y; Tue, 21 Jul 2020 09:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AAE85262D2;
	Tue, 21 Jul 2020 09:40:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F3FBC088E;
	Tue, 21 Jul 2020 09:40:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACD6AC016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 09:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A54AB2632A
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 09:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gwecWiEDxSqb for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 09:40:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id A717F262D2
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 09:40:45 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id o8so2137310wmh.4
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rCxIL+rHjym7zqqOLzszCPAKBEVgacDmz2OZWqCIgDo=;
 b=d7ygYoSU9BwJvXFBjfOzjT3xC1XvPBSJ78cKJk0f30A59kcnNZf8/m6jU2QFc4v7U2
 laXUPKM8zkow1EO7JaeNQQwBZsjAE8DjUyh/gRlUj4kQYtl9CxnDAIV64EqyslAVtHnI
 UE/IIO8bQnvoA1JuSwhtRcIF/vEy4e3fvuKp0mrucjS/EJ3pruXS9KpX8SSBg0HqquB4
 BSqXAj/r1cyM47IfNrsHQ4DVFCptzi08AtEWCl7DMaXgpDGNkqP9krSKEmD05fDP3ATN
 2NK+jnUP99/bPs8+Vkw2035Fnf87azVz8jRxgxskHTie0jBqKXA2pvdj34md/yNIH33U
 5htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rCxIL+rHjym7zqqOLzszCPAKBEVgacDmz2OZWqCIgDo=;
 b=bS4PTYWbvs2Ji5i3GQTwTTKc7zmQ6NtWuZk7mLZ4i3adEgXkOU78CdKAgzXXH2o+z7
 N/u9PognDqdYkgPydf4IRZ32ZlPi0ROi6OkCUow6ch4/swLS717jDU9xRyS8XCiYrpCZ
 mN4ox2U4SjhMrn33t/sMOjese5fQz7fgKpgWiNphq+ASYi7Lb6WRVGQB2XHGOI0NvJbb
 LkKnVUO0JTEGARLaYj28AYqNK4Jiq6CwXN6P68l66G0BNEkefSBWwLmuLcQvnnrnAA6T
 wzZb4ldVZY1WIy3aJQ3kbDWn9mAbDIxbBAPjSCpe7SQsnUNnG7BzvvvFgkAL634rKgvY
 sPUw==
X-Gm-Message-State: AOAM533S846tCHGucfE6G/nu43LzJbi5fCEAEiB2qtbYjpxvHlQQwkRa
 JHGM/SKC2XMw4nSnvRzD+MQ=
X-Google-Smtp-Source: ABdhPJwuugwNgvo79Cj+BQrID56nD2Y7XD53afgdNWdzMsthSvIH6suVNQ+ocUsmuhrOHqTBwCORbw==
X-Received: by 2002:a1c:964d:: with SMTP id y74mr3395716wmd.80.1595324443879; 
 Tue, 21 Jul 2020 02:40:43 -0700 (PDT)
Received: from ziggy.stardust ([213.195.120.199])
 by smtp.gmail.com with ESMTPSA id r11sm2637848wmh.1.2020.07.21.02.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 02:40:43 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
To: Miles Chen <miles.chen@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
Date: Tue, 21 Jul 2020 11:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200721021619.25575-1-miles.chen@mediatek.com>
Content-Language: en-US
Cc: wsd_upstream@mediatek.com, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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



On 21/07/2020 04:16, Miles Chen wrote:
> In previous discussion [1] and [2], we found that it is risky to
> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> 
> Check 4GB mode by reading infracfg register, remove the usage
> of the un-exported symbol max_pfn.
> 
> This is a step towards building mtk_iommu as a kernel module.
> 
> Change since v1:
> 1. remove the phandle usage, search for infracfg instead [3]
> 2. use infracfg instead of infracfg_regmap
> 3. move infracfg definitaions to linux/soc/mediatek/infracfg.h
> 4. update enable_4GB only when has_4gb_mode
> 
> [1] https://lkml.org/lkml/2020/6/3/733
> [2] https://lkml.org/lkml/2020/6/4/136
> [3] https://lkml.org/lkml/2020/7/15/1147
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Chao Hao <chao.hao@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c             | 26 +++++++++++++++++++++-----
>   include/linux/soc/mediatek/infracfg.h |  3 +++
>   2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2be96f1cdbd2..16765f532853 100644
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
> @@ -15,13 +14,16 @@
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
> +#include <linux/soc/mediatek/infracfg.h>
>   #include <asm/barrier.h>
>   #include <soc/mediatek/smi.h>
>   
> @@ -599,8 +601,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	struct resource         *res;
>   	resource_size_t		ioaddr;
>   	struct component_match  *match = NULL;
> +	struct regmap		*infracfg;
>   	void                    *protect;
>   	int                     i, larb_nr, ret;
> +	u32			val;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -614,10 +618,22 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>   
> -	/* Whether the current dram is over 4GB */
> -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> -	if (!data->plat_data->has_4gb_mode)
> -		data->enable_4GB = false;
> +	data->enable_4GB = false;
> +	if (data->plat_data->has_4gb_mode) {
> +		infracfg = syscon_regmap_lookup_by_compatible(
> +				"mediatek,mt8173-infracfg");
> +		if (IS_ERR(infracfg)) {
> +			infracfg = syscon_regmap_lookup_by_compatible(
> +					"mediatek,mt2712-infracfg");
> +			if (IS_ERR(infracfg))
> +				return PTR_ERR(infracfg);

I think we should check m4u_plat instead to decide which compatible we have to 
look for.
Another option would be to add a general compatible something like 
"mtk-infracfg" and search for that. That would need an update of all DTS having 
a infracfg compatible right now. After thinking twice, this would break newer 
kernel with older device tree, so maybe it's better to go with m4u_plat switch 
statement.

Regards,
Matthias

> +
> +		}
> +		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
> +		if (ret)
> +			return ret;
> +		data->enable_4GB = !!(val & F_DDR_4GB_SUPPORT_EN);
> +	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	data->base = devm_ioremap_resource(dev, res);
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index fd25f0148566..233463d789c6 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -32,6 +32,9 @@
>   #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
>   						 BIT(7) | BIT(8))
>   
> +#define REG_INFRA_MISC				0xf00
> +#define F_DDR_4GB_SUPPORT_EN			BIT(13)
> +
>   int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
>   		bool reg_update);
>   int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
