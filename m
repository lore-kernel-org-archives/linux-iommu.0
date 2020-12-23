Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC7FC433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:56:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBF3206D6
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBF3206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 56A8185CAA;
	Wed, 23 Dec 2020 08:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fppajUvq4QHQ; Wed, 23 Dec 2020 08:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C736B85485;
	Wed, 23 Dec 2020 08:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE6DFC1787;
	Wed, 23 Dec 2020 08:56:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C443C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 559AD87241
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZBquio04Qx4 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A96A38723B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:56:14 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id i7so10206963pgc.8
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6K+sLQbds6lT1EQKsvW+QH4EoaymFe0n2zEViQ0TTtE=;
 b=cVvERGAR9ZDjsCLfMz6MESVacPIuLG8icEg0rKSPWxT7+6NFoAASq2s3H/KmoVuUl4
 9f59HEeGpHfRj9NFe22Y+kqk8O+bpnzFwnzCkvgfvLgrlr6USEUjIHm3Tc8UerarnDSX
 fp5cTKX4HJLd7AWU7MtYsQS7UU4xel2Z1eh3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6K+sLQbds6lT1EQKsvW+QH4EoaymFe0n2zEViQ0TTtE=;
 b=CfTM1UYDJNNtDftdAPcEKEUe8kKAMRuwyAZMaqZfdvpx3LNxC7sVbGT0YDYI487WM/
 KlUdHVKp3ODHHIWRmH8BUDSr5/4l7D/0T1IVm/sq7XPWq3PFF2qEF5cs8VYyHdXzOvs9
 +FAPyMCRB3aszZUmo3LP/woPAexTC5qTRD41AXJEjMwJ8L5gxkd/+9lUxAcPR0j7yt6H
 dG+nSeKv0Slye41DLOo4VtQRiCkY9/U0EMpmLfxSt+2JASYWxeykzc/CSQZpGyytvlM4
 EzQyKd/GsT9m0pNkvAY1NSfw3pdeOEoYexzzvccKBwngbuJnbKSpaQSwl2e1vvKeLbww
 ar8w==
X-Gm-Message-State: AOAM532LiGecoKpQRM6WnyV9unokPdWVeiQH0Y3X/TB3chwj9Gcg7464
 R4tsQFqg3aP3CBAV46JcyuAd5w==
X-Google-Smtp-Source: ABdhPJzQmPns0kBAA60ayRdmhDvciIE9lgEoYhfBVgerB6EDy1NMQs0Tx7MT1YRWXh23VK7AIUSXHQ==
X-Received: by 2002:a63:4c5d:: with SMTP id m29mr24117617pgl.368.1608713774304; 
 Wed, 23 Dec 2020 00:56:14 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
 by smtp.gmail.com with ESMTPSA id c10sm23942098pfj.54.2020.12.23.00.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 00:56:13 -0800 (PST)
Date: Wed, 23 Dec 2020 17:56:08 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
Message-ID: <X+MGKBYKdmPNz7VL@chromium.org>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201216103607.23050-7-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel-team@android.com, Greg Kroah-Hartman <gregkh@google.com>,
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

On Wed, Dec 16, 2020 at 06:36:06PM +0800, Yong Wu wrote:
> In current iommu_unmap, this code is:
> 
> 	iommu_iotlb_gather_init(&iotlb_gather);
> 	ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
> 	iommu_iotlb_sync(domain, &iotlb_gather);
> 
> We could gather the whole iova range in __iommu_unmap, and then do tlb
> synchronization in the iommu_iotlb_sync.
> 
> This patch implement this, Gather the range in mtk_iommu_unmap.
> then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
> we don't call iommu_iotlb_gather_add_page since our tlb synchronization
> could be regardless of granule size.
> 
> In this way, gather->start is impossible ULONG_MAX, remove the checking.
> 
> This patch aims to do tlb synchronization *once* in the iommu_unmap.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index db7d43adb06b..89cec51405cd 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -506,7 +506,12 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>  			      struct iommu_iotlb_gather *gather)
>  {
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	unsigned long long end = iova + size;
>  
> +	if (gather->start > iova)
> +		gather->start = iova;
> +	if (gather->end < end)
> +		gather->end = end;

I don't know how common the case is, but what happens if
gather->start...gather->end is a disjoint range from iova...end? E.g.

 | gather      | ..XXX... | iova |
 |             |          |      |
 gather->start |          iova   |
               gather->end       end

We would also end up invalidating the TLB for the XXX area, which could
affect the performance.

Also, why is the existing code in __arm_v7s_unmap() not enough? It seems
to call io_pgtable_tlb_add_page() already, so it should be batching the
flushes.

>  	return dom->iop->unmap(dom->iop, iova, size, gather);
>  }
>  
> @@ -523,9 +528,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>  	size_t length = gather->end - gather->start;
>  
> -	if (gather->start == ULONG_MAX)
> -		return;
> -
>  	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
>  				       dom->data);
>  }
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
