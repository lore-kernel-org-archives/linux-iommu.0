Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76189C433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:21:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0161A207B6
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0161A207B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A56E28723A;
	Wed, 23 Dec 2020 08:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXhMtnvxb5RC; Wed, 23 Dec 2020 08:21:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0AC84870C7;
	Wed, 23 Dec 2020 08:21:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E32D0C1787;
	Wed, 23 Dec 2020 08:21:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 266F3C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 19EC287164
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id my1fYffE12kc for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:21:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 19DCA8723A
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:21:06 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id c12so9932909pfo.10
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yCs+PY9Jy4cJoFYJpIvFxqIHuHMCQdFNyYUz6uJ1sAQ=;
 b=d/9+nZaV1qO/0LfciBy5aYtvWgjbBI/NXmbljXsW42Yuo0HoyAAN+f7JEXSaxp/DYD
 JgGpEkBJYVZVLRYpbowwg3x0k9d+eowvXvHIkRU7X6kNcKJF1t2aoaPAlvcKEDoG1nYw
 RNgJnKSuqF8euK21HV5k+yUKAeNycY7f61my8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yCs+PY9Jy4cJoFYJpIvFxqIHuHMCQdFNyYUz6uJ1sAQ=;
 b=eqndOkWphknx2H/qZKISEo/gxu3txMMlQe/1cWLtXsvZLOpunY+nZoCP19ZH9ZZbZb
 wTGpmtoXqBP36CowU6Z0XAPdLhtXijMrWE0R+5An2ZUTwpMSQEOLhZNbvbhDKiVvYChF
 +pMIz9ii1cXx/tvMm8qCZxjvp9AhWOwZ3T8vejgtFu3DcMg92dkgtR+jJB7y2uR2xd6n
 ZtTgoXw+OMA+x59+kuVeRntG7OH8aXvXrjM0xZDgJbYbWvOLwB/YnwnSKz13MZfW00wJ
 Yoehzc7fdKoFtkf5y8d9Uun9w894tyW8B3blq/8wxGUDoEdUtsan79cDjyo9DQCwCuaV
 hxPA==
X-Gm-Message-State: AOAM530o6Ztd7jjHgbm2JwryglY6sNSDWzfmJNN5i2pdVhqexzIHAenV
 teslYAaUnF4QKeidqdg1RQaUrw==
X-Google-Smtp-Source: ABdhPJxiFDxtXVQfHOA/peW0Rqkubb2VRH7OvGhUiOyyazKhYhYGQY/mwvl4Aox+RLd0Y+RD2ZEmHA==
X-Received: by 2002:a62:fc4f:0:b029:19d:d060:27ca with SMTP id
 e76-20020a62fc4f0000b029019dd06027camr22818371pfh.66.1608711665713; 
 Wed, 23 Dec 2020 00:21:05 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
 by smtp.gmail.com with ESMTPSA id gb9sm7480288pjb.40.2020.12.23.00.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 00:21:05 -0800 (PST)
Date: Wed, 23 Dec 2020 17:20:58 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 09/27] iommu/io-pgtable-arm-v7s: Extend PA34 for
 MediaTek
Message-ID: <X+L96uZU2aZWfjSP@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-10-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-10-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Dec 09, 2020 at 04:00:44PM +0800, Yong Wu wrote:
> MediaTek extend the bit5 in lvl1 and lvl2 descriptor as PA34.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 9 +++++++--
>  drivers/iommu/mtk_iommu.c          | 2 +-
>  include/linux/io-pgtable.h         | 4 ++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index e880745ab1e8..4d0aa079470f 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -112,9 +112,10 @@
>  #define ARM_V7S_TEX_MASK		0x7
>  #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
>  
> -/* MediaTek extend the two bits for PA 32bit/33bit */
> +/* MediaTek extend the bits below for PA 32bit/33bit/34bit */
>  #define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
>  #define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
> +#define ARM_V7S_ATTR_MTK_PA_BIT34	BIT(5)
>  
>  /* *well, except for TEX on level 2 large pages, of course :( */
>  #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
> @@ -194,6 +195,8 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
>  		pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
>  	if (paddr & BIT_ULL(33))
>  		pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> +	if (paddr & BIT_ULL(34))
> +		pte |= ARM_V7S_ATTR_MTK_PA_BIT34;
>  	return pte;
>  }
>  
> @@ -218,6 +221,8 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>  		paddr |= BIT_ULL(32);
>  	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
>  		paddr |= BIT_ULL(33);
> +	if (pte & ARM_V7S_ATTR_MTK_PA_BIT34)
> +		paddr |= BIT_ULL(34);
>  	return paddr;
>  }
>  
> @@ -754,7 +759,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  	if (cfg->ias > ARM_V7S_ADDR_BITS)
>  		return NULL;
>  
> -	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
> +	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 35 : ARM_V7S_ADDR_BITS))
>  		return NULL;
>  
>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6451d83753e1..ec3c87d4b172 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -320,7 +320,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
>  			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
>  		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
>  		.ias = 32,
> -		.oas = 34,
> +		.oas = 35,

Shouldn't this be set according to the real hardware capabilities,
instead of always setting it to 35?

Best regards,
Tomasz

>  		.tlb = &mtk_iommu_flush_ops,
>  		.iommu_dev = data->dev,
>  	};
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 4cde111e425b..1ae0757f4f94 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -77,8 +77,8 @@ struct io_pgtable_cfg {
>  	 *	TLB maintenance when mapping as well as when unmapping.
>  	 *
>  	 * IO_PGTABLE_QUIRK_ARM_MTK_EXT: (ARM v7s format) MediaTek IOMMUs extend
> -	 *	to support up to 34 bits PA where the bit32 and bit33 are
> -	 *	encoded in the bit9 and bit4 of the PTE respectively.
> +	 *	to support up to 35 bits PA where the bit32, bit33 and bit34 are
> +	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
>  	 *
>  	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
>  	 *	on unmap, for DMA domains using the flush queue mechanism for
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
