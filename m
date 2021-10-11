Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE112C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 02:07:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6207B60ED7
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 02:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6207B60ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A60B401D5;
	Mon, 11 Oct 2021 02:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aKlM4Jml8Gc9; Mon, 11 Oct 2021 02:07:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B6390401D1;
	Mon, 11 Oct 2021 02:07:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98A2BC0011;
	Mon, 11 Oct 2021 02:07:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00E9CC000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 02:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D63DD40385
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 02:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BpFJ5DLu1NK0 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:07:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12037402A2
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 02:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633918023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENeVT4EJ4HhfdzKw1adhLhObafui60u3kBaV6BSYZzQ=;
 b=C/2IW8LLS+sXyKCV+RSDxigaQqHO8wFvXb9Da9YNTXfXiO9khvDjcS9+aC1JNxS+pygMNJ
 rLM2mbmbTV+gqopNKagvJ3fp+bnB4R9PIdxbUfoZUn58b4NCOuarTQAUrzNO1HQ+P5xCpz
 Qg72mgUA6XfihXvetWBDoGBjgAt1lv0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-enq6BtesOAOXc5O5ht5Bpg-1; Sun, 10 Oct 2021 22:07:01 -0400
X-MC-Unique: enq6BtesOAOXc5O5ht5Bpg-1
Received: by mail-lf1-f72.google.com with SMTP id
 x33-20020a0565123fa100b003fcfd99073dso11473040lfa.6
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 19:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ENeVT4EJ4HhfdzKw1adhLhObafui60u3kBaV6BSYZzQ=;
 b=2YeJU23h7wHiYNczP3+H32RlQyYrX9D2LH5MiqJUWmSQGsV06oBYDNrJ1Dnzf65qVX
 148g3Ck0U9a/m79fU3/zAh8zLlsl5EyRFVIM57bWBPL5QiIMTaEh/knZqGauQFx+xvyV
 yJCyxaMN9leLAayBD8H5yy9ZtFWy9pRhTiyvD643q46vkdoTrqGtS2kkHtyqUDdy2oAd
 FiYyhsNEuN972Qa98LkSEkZmMYF0fAPGy+sNtiWt4uY1uqQNNAmEhpmLqDEIf9FfDLVC
 rtp9hfYxIy8HShDVpJMq6DXRheU/Eh1bBqlj5Fea24uYWEHuc41kRZdb+ED0WJMWoqie
 Wh2Q==
X-Gm-Message-State: AOAM531usMNXv9O0U8SQWDikIwPUefZZ+fzxYGk+pixoHCUUVWl+LjwB
 KtBEJMITj1RqEOK+oVK5bT5Sssq1/adib/9AMGkjqcTjgpFAVo/qLL0VndmWVm5TNJmoXYAZA+V
 HkPTcRAMWmylnC3g322rCp9vrEoV1y6Z0FUK6S3dKWGQgUw==
X-Received: by 2002:a05:6512:3d29:: with SMTP id
 d41mr12508884lfv.481.1633918020081; 
 Sun, 10 Oct 2021 19:07:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz14BTo20ifNpNLBzaLU+yNKHq7V7P/zv03+clH5xHZcu/iFJWoObufgdo9Yiy21rVk+IBUQO3NHQ409rBQPsA=
X-Received: by 2002:a05:6512:3d29:: with SMTP id
 d41mr12508845lfv.481.1633918019761; 
 Sun, 10 Oct 2021 19:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1632477717-5254-2-git-send-email-john.garry@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Oct 2021 10:06:48 +0800
Message-ID: <CACGkMEt8FcoJ4zMXFZzmrFjm=ynWfr5yLfvSHCckawpa3FvhkA@mail.gmail.com>
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into
 alloc_iova_fast()
To: John Garry <john.garry@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Will Deacon <will@kernel.org>, linuxarm@huawei.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, Sep 24, 2021 at 6:07 PM John Garry <john.garry@huawei.com> wrote:
>
> It really is a property of the IOVA rcache code that we need to alloc a
> power-of-2 size, so relocate the functionality to resize into
> alloc_iova_fast(), rather than the callsites.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

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
>         shift = iova_shift(iovad);
>         iova_len = size >> shift;
> -       /*
> -        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -        * will come back to bite us badly, so we have to waste a bit of space
> -        * rounding up anything cacheable to make sure that can't happen. The
> -        * order of the unadjusted size will still match upon freeing.
> -        */
> -       if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -               iova_len = roundup_pow_of_two(iova_len);
>
>         dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 9e8bc802ac05..ff567cbc42f7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -497,6 +497,15 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>         unsigned long iova_pfn;
>         struct iova *new_iova;
>
> +       /*
> +        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> +        * will come back to bite us badly, so we have to waste a bit of space
> +        * rounding up anything cacheable to make sure that can't happen. The
> +        * order of the unadjusted size will still match upon freeing.
> +        */
> +       if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +               size = roundup_pow_of_two(size);
> +
>         iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
>         if (iova_pfn)
>                 return iova_pfn;
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 1daae2608860..2b1143f11d8f 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -292,14 +292,6 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
>         unsigned long iova_len = iova_align(iovad, size) >> shift;
>         unsigned long iova_pfn;
>
> -       /*
> -        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -        * will come back to bite us badly, so we have to waste a bit of space
> -        * rounding up anything cacheable to make sure that can't happen. The
> -        * order of the unadjusted size will still match upon freeing.
> -        */
> -       if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -               iova_len = roundup_pow_of_two(iova_len);
>         iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
>
>         return iova_pfn << shift;
> --
> 2.26.2
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
