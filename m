Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2E2C433E1
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 09:53:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97C3207CD
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 09:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/Iiqx0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97C3207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 86F3985BB5;
	Thu, 27 Aug 2020 09:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TxgwcKoJHMxG; Thu, 27 Aug 2020 09:53:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BFB548598E;
	Thu, 27 Aug 2020 09:53:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9968CC016F;
	Thu, 27 Aug 2020 09:53:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEB54C0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A1BB08815E
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id boQMl52O4u8T for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 09:53:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6F2E088031
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:53:16 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id y3so4743413wrl.4
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3S2ltGK2B4ahfxRE0OqRsWU+E5mMz97vYPSClpVkEpw=;
 b=j/Iiqx0CIhx0nsty8bj+dxZr7X5let9JMzxAJtte6vf0GUcfyJn+kxd/lKo8+1aVU3
 LEoLd1clGvpkQaBGLO6T22hrbWW3S8KWsahbXmqEp1+sSwllynNwQsbtOpuZrOnwGvqM
 XCJCrMkGqxNCg1Y8mYDi07x+C2FsgXBF6bYz4iIeEkgH+T+4h7v2X6kT+DzKQ9btHwm4
 b1WQKZKh48+9ZASVFD0W+dA+aGB6ZsGDeLi+EZEbtUJddD07+SrIXiriWuVFqaKfZhks
 oUl1IkoQfBshCWgRjZvV1DId5tUXKSI25nx9fubmMDQDS7yn7DPzcIWVgP3PXaLAg7vu
 Y6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3S2ltGK2B4ahfxRE0OqRsWU+E5mMz97vYPSClpVkEpw=;
 b=apQ1y7weCbTYTUqhQLqUGeQ69A/wxQlv9vRqrsLmVepxDB2AHkTnKWP4ZV+e8IRrvh
 dGPJzSrxGE980y8rmUxZnfHDFra2ySUiXZpVeeUMNrs6gPtzFnjEYah2pBFZ6XWJvTUz
 ULf4Slglkm7SqJtLhwW+cayzykZJ2oHtpM0J5uwratF+7C+0+MdCnt283d9tKaVsQBAZ
 qJ2des5n3f3hDoxF6oGkF2kiiCu1Iu3Yonpr/GYZ2hu+/GVNyEZIgmQhmSwipNb8i1Es
 wWc8fWLzu7EHfJUJSCvYhgpzj3JNb5Yr5TTn19D2S/GVJ3xeSIneJFMHhIc/sAL7v/R0
 owjw==
X-Gm-Message-State: AOAM531CJjUZ8bINTbFaV1tuCJCrfkp501dz6OQJmNL/dlirSCzj8eok
 WidKRnQvD4Ld88l4eSxFTd8=
X-Google-Smtp-Source: ABdhPJxCQib2nyRWJhQUT1arhmXoAnRcByD/McQ+QvDCu5PGTRgjO4PCrkOK/qYUpcMj1POZM32MmA==
X-Received: by 2002:a05:6000:1248:: with SMTP id
 j8mr106089wrx.292.1598521994965; 
 Thu, 27 Aug 2020 02:53:14 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.187])
 by smtp.gmail.com with ESMTPSA id s8sm3707553wmc.1.2020.08.27.02.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 02:53:14 -0700 (PDT)
Subject: Re: [RESEND PATCH v4] iommu/mediatek: check 4GB mode by reading
 infracfg
To: Miles Chen <miles.chen@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>
References: <20200826085618.2889-1-miles.chen@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <0d1a4c6d-03ce-a5c4-d17b-26f5203e899a@gmail.com>
Date: Thu, 27 Aug 2020 11:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826085618.2889-1-miles.chen@mediatek.com>
Content-Language: en-US
Cc: wsd_upstream@mediatek.com, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
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



On 26/08/2020 10:56, Miles Chen wrote:
> In previous discussion [1] and [2], we found that it is risky to
> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> 
> Check 4GB mode by reading infracfg register, remove the usage
> of the un-exported symbol max_pfn.
> 
> This is a step towards building mtk_iommu as a kernel module.
> 
> [1] https://lore.kernel.org/lkml/20200603161132.2441-1-miles.chen@mediatek.com/
> [2] https://lore.kernel.org/lkml/20200604080120.2628-1-miles.chen@mediatek.com/
> [3] https://lore.kernel.org/lkml/20200715205120.GA778876@bogus/
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> ---
> 
> Change since v3
> - use lore.kernel.org links
> - move "change since..." after "---"
> 
> Change since v2:
> - determine compatible string by m4u_plat
> - rebase to next-20200720
> - add "---"
> 
> Change since v1:
> - remove the phandle usage, search for infracfg instead [3]
> - use infracfg instead of infracfg_regmap
> - move infracfg definitaions to linux/soc/mediatek/infracfg.h
> - update enable_4GB only when has_4gb_mode
> ---
>   drivers/iommu/mtk_iommu.c             | 34 +++++++++++++++++++++++----
>   include/linux/soc/mediatek/infracfg.h |  3 +++
>   2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 785b228d39a6..adc350150492 100644
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
> @@ -640,8 +642,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	struct resource         *res;
>   	resource_size_t		ioaddr;
>   	struct component_match  *match = NULL;
> +	struct regmap		*infracfg;
>   	void                    *protect;
>   	int                     i, larb_nr, ret;
> +	u32			val;
> +	char                    *p;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -655,10 +660,29 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>   
> -	/* Whether the current dram is over 4GB */
> -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> -	if (!MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
> -		data->enable_4GB = false;
> +	data->enable_4GB = false;
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> +		switch (data->plat_data->m4u_plat) {
> +		case M4U_MT2712:
> +			p = "mediatek,mt2712-infracfg";
> +			break;
> +		case M4U_MT8173:
> +			p = "mediatek,mt8173-infracfg";
> +			break;
> +		default:
> +			p = NULL;
> +		}
> +
> +		infracfg = syscon_regmap_lookup_by_compatible(p);
> +
> +		if (IS_ERR(infracfg))
> +			return PTR_ERR(infracfg);
> +
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
