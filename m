Return-Path: <SRS0=5Tlr=PG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD32C4332F
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 15:42:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7046F60EFE
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 15:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7046F60EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E59740426;
	Mon, 18 Oct 2021 15:42:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L1yLmhJuSxbR; Mon, 18 Oct 2021 15:42:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B85D240427;
	Mon, 18 Oct 2021 15:42:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EF7BC0020;
	Mon, 18 Oct 2021 15:42:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 871BDC000D
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 15:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 802764020C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 15:42:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n1clkvHE2s7H for <iommu@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 15:42:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 702BC400FB
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634571751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7mw1O+Bt5c0sQ6lX8KPW8uaz0FCUii8T8NQx68gypg=;
 b=jCv1vSRNDI5cPqqV7eikL0qMmeCpCbaIzUDUlnN9MQrV/YeTIcuIXLsmTjPnLO9CiLBiFD
 mWcfGpLfyKuTEpmAlcMbQmh1uHjJnjqe7Sz4BMV8d46/q736eZjleZe2U5477l61D6ajdN
 VpAwHtNWYENTRGPSauXp9k0xUbElTd8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-LoqEjo4RPVWOKewvQAM3Gg-1; Mon, 18 Oct 2021 11:42:30 -0400
X-MC-Unique: LoqEjo4RPVWOKewvQAM3Gg-1
Received: by mail-wm1-f71.google.com with SMTP id
 v10-20020a1cf70a000000b00318203a6bd1so135485wmh.6
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 08:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r7mw1O+Bt5c0sQ6lX8KPW8uaz0FCUii8T8NQx68gypg=;
 b=6wAWHergMquHeDUXv9vL1DBdqMurhj9e91bhZLufDqDIBikbJYEsqCgCZ6vvlu/H0u
 EVivBdaaIceqEYhx6l9w5oQukr9SjPWaJQD6cZ7JdVGfvXTfiTvLFN7C1pa4QuHZO3rf
 vHtgsVutnYPbb0321LhXvCyWeDzf0bBDT9oNLWo1ARkJMRXyBVV1JHQGQjfL2Zki2Oq+
 nXsykY9KX9Q2Q456mdnlQj8rRr+9AB/mZIdES3afHxu2MuqUk7BStjCaRBBpZt5QFEPT
 7KA3khKwFbzRfKwVx7/Niy5xLbxcTTkjq6Mk99tsHD0nNEUKyNYz3fmTM7Kpg722uIvx
 PvQw==
X-Gm-Message-State: AOAM5313jYLSwUSfLODqnuVIq97+YR2buUZ3jY1zuMywvbyf0565JZ4w
 xncYB2F9GnJN0ZP80jWmTWj69sBcragWK3PE5Y55iD7jE/cqSiswWnuUOmg+aBKPxWnFjjs+JpQ
 e92tdsHVKphPWMI8uPndn/tkiDuzrAA==
X-Received: by 2002:adf:e292:: with SMTP id v18mr35186384wri.369.1634571749027; 
 Mon, 18 Oct 2021 08:42:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBSOSiWq21d1Yw7khQZe7v4MbUWpxK1TCoqbBEOQYqnf+rf+Nc44g+h+f4t+6eFrbtQZTAiw==
X-Received: by 2002:adf:e292:: with SMTP id v18mr35186353wri.369.1634571748802; 
 Mon, 18 Oct 2021 08:42:28 -0700 (PDT)
Received: from redhat.com ([2.55.19.190])
 by smtp.gmail.com with ESMTPSA id l124sm19136758wml.8.2021.10.18.08.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 08:42:27 -0700 (PDT)
Date: Mon, 18 Oct 2021 11:42:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into
 alloc_iova_fast()
Message-ID: <20211018114215-mutt-send-email-mst@kernel.org>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1632477717-5254-2-git-send-email-john.garry@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: will@kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, jasowang@redhat.com
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

On Fri, Sep 24, 2021 at 06:01:53PM +0800, John Garry wrote:
> It really is a property of the IOVA rcache code that we need to alloc a
> power-of-2 size, so relocate the functionality to resize into
> alloc_iova_fast(), rather than the callsites.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

for vdpa code:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/iommu/dma-iommu.c            | 8 --------
>  drivers/iommu/iova.c                 | 9 +++++++++
>  drivers/vdpa/vdpa_user/iova_domain.c | 8 --------
>  3 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 896bea04c347..a99b3445fef8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -444,14 +444,6 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  
>  	shift = iova_shift(iovad);
>  	iova_len = size >> shift;
> -	/*
> -	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -	 * will come back to bite us badly, so we have to waste a bit of space
> -	 * rounding up anything cacheable to make sure that can't happen. The
> -	 * order of the unadjusted size will still match upon freeing.
> -	 */
> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -		iova_len = roundup_pow_of_two(iova_len);
>  
>  	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>  
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 9e8bc802ac05..ff567cbc42f7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -497,6 +497,15 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>  	unsigned long iova_pfn;
>  	struct iova *new_iova;
>  
> +	/*
> +	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> +	 * will come back to bite us badly, so we have to waste a bit of space
> +	 * rounding up anything cacheable to make sure that can't happen. The
> +	 * order of the unadjusted size will still match upon freeing.
> +	 */
> +	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +		size = roundup_pow_of_two(size);
> +
>  	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
>  	if (iova_pfn)
>  		return iova_pfn;
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 1daae2608860..2b1143f11d8f 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -292,14 +292,6 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
>  	unsigned long iova_len = iova_align(iovad, size) >> shift;
>  	unsigned long iova_pfn;
>  
> -	/*
> -	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -	 * will come back to bite us badly, so we have to waste a bit of space
> -	 * rounding up anything cacheable to make sure that can't happen. The
> -	 * order of the unadjusted size will still match upon freeing.
> -	 */
> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -		iova_len = roundup_pow_of_two(iova_len);
>  	iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
>  
>  	return iova_pfn << shift;
> -- 
> 2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
