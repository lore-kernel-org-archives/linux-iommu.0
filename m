Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31181C11D0C
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 19:50:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B27206F4
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 19:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B27206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D92F187D73;
	Thu, 20 Feb 2020 19:50:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kf9SdzIcULPg; Thu, 20 Feb 2020 19:50:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 430C987D65;
	Thu, 20 Feb 2020 19:50:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32A73C1D88;
	Thu, 20 Feb 2020 19:50:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 704D8C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 19:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 584A687D73
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 19:50:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jM6-MjyBCi8t for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 19:50:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 15CA887D65
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 19:50:23 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id g6so1961367plt.2
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 11:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KktWaA20cRZDutlgvoO1nRHN/e/oQ4YYrqk4PqmRjNc=;
 b=jjRFqOYiSjoiOgGJ6s6tPCTxbTZChd1pmuiUZDiywv6ahTdkTVXolQNkzgkMCk2xfP
 lfnzwVh0bPkV1u4U4wjNY4KJcFTbx/KjQp/ZQKHaFKG+0HWk1JZiDsIXZtvxP5CE6Dz3
 bueOo2FPlixFQ4RzS/aWXfTujflHwKON06eu6zPH8zVTh5sf/8H0DNGdm/FNYWYrABZP
 mY68qSYjrVUZs/q7R/Y160Y7FIF8b+jdBtFsyhvKs23ReP7UUk02N0iPKh9bYxBW2Rn3
 3nCxtkss3ee6XozwjyRlwWBzfFMr1CoAPqw3Bza5PlFhU1wtP44/EscdFr1n6cQ3G+OR
 epFg==
X-Gm-Message-State: APjAAAWZ0qOYYSnO/PLLwRxfzplJuq6qkYB5m/Z+j9GFvC+HX2+ciQQ7
 KgqmO8+vM0iMehkLV5ZM66g=
X-Google-Smtp-Source: APXvYqz0q/gU3204XY9FOMh0frYACvr+WP0LQnb8eVTBz+fO1CTlKX9eeuh1Eax9MRnpy/1Qsf416g==
X-Received: by 2002:a17:902:8546:: with SMTP id
 d6mr32968958plo.193.1582228222418; 
 Thu, 20 Feb 2020 11:50:22 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
 by smtp.gmail.com with ESMTPSA id 70sm375556pfw.140.2020.02.20.11.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 11:50:21 -0800 (PST)
Date: Thu, 20 Feb 2020 11:50:20 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Yonghyun Hwang <yonghyun@google.com>
Subject: Re: [PATCH v2] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys()
 for huge page
Message-ID: <20200220195020.GA1193@epycbox.lan>
References: <20200220194431.169629-1-yonghyun@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200220194431.169629-1-yonghyun@google.com>
Cc: linux-kernel@vger.kernel.org, Havard Skinnemoen <hskinnemoen@google.com>,
 iommu@lists.linux-foundation.org, Deepa Dinamani <deepadinamani@google.com>,
 Moritz Fischer <mdf@kernel.org>, David Woodhouse <dwmw2@infradead.org>
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

Hi Yonghyun,

On Thu, Feb 20, 2020 at 11:44:31AM -0800, Yonghyun Hwang wrote:
> intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
> page onto its corresponding physical address. This commit fixes the bug by
> accomodating the level of page entry for the IOVA and adds IOVA's lower
> address to the physical address.
> 
D'oh I meant to add a Cc: stable@vger.kernel.org here ... :)
> Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
> ---
> 
> Changes from v1:
> - level cannot be 0. So, the condition, "if (level > 1)", is removed, which results in a simple code.
> - a macro, BIT_MASK, is used to have a bit mask
> 
> ---
>  drivers/iommu/intel-iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 932267f49f9a..4fd5c6287b6d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5554,7 +5554,9 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>  
>  	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
>  	if (pte)
> -		phys = dma_pte_addr(pte);
> +		phys = dma_pte_addr(pte) +
> +			(iova & (BIT_MASK(level_to_offset_bits(level) +
> +						VTD_PAGE_SHIFT) - 1));
>  
>  	return phys;
>  }
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 

Cheers,
Moritz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
