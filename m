Return-Path: <SRS0=z+Ry=HS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3F7C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 08:15:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518A664DC3
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 08:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518A664DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 07D0F87014;
	Tue, 16 Feb 2021 08:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YPoUIRx31HfA; Tue, 16 Feb 2021 08:15:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5754586FC0;
	Tue, 16 Feb 2021 08:15:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C03BC0174;
	Tue, 16 Feb 2021 08:15:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12722C013A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 08:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 01AAC87005
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 08:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uz3C-eE6uC52 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 08:15:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DF51286FC0
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 08:15:10 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id hs11so15192377ejc.1
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vzhTdPHbs48+KQ9HqL9TbcxPy1qXKHCXgtGLrYyU4FA=;
 b=SDYBzdh1dpId2B0EUuMVomU+ozCkhWpfs1MII9Mq81AfCJSc5faOJLTlj6CGDwNpnt
 T9dVAPZB1KagNR6cQdi/Dzj1kgnJrLp40S5cinUkqaayF2B49k70Rc+BiTzPMm8pmkaH
 LGPq1CT/uAiDDKllkdLKDHWgXS5omwWtay4p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vzhTdPHbs48+KQ9HqL9TbcxPy1qXKHCXgtGLrYyU4FA=;
 b=owyTQGuR4BuB+wEyrMKLZezzoRU3DAkVAsisaq2Hkak6ZsBi3pZ8unug2IkeeGmKH6
 XJS34n5T1nhyQDDNz9MImemAJSlfBqKID13gk1the23BQcnWSCj2OSs3vNLaSra0GmCQ
 qiz6LFe6cMh0ve14344FjQQHrZK9/6Bar8qxy/UTbphEzRXQeX7CBSyHAylW3nmSpTPZ
 QwYsuLiAd//KpXisZJuzh4d7JrnAM0GlnYAigsNj8P30jjOkApL1enmDIGc1heCmPEj4
 B8KbZNAJcrgKP0VEv2UsIwgndLPKzEHXzjWH95I8a+Dgh2cHVx84stCXOHQgBG7VeZVx
 PV9w==
X-Gm-Message-State: AOAM531pigP8gA3FyjTNjcqCv9QD8Rm7rA8OqXwkpxliqu7jWkwQkUfg
 lgUXmkf+rdUTSx7vYCwbGK88lzjBPUmf7+MG
X-Google-Smtp-Source: ABdhPJxLRNrI5K5E0rusSkUVm9/rVf56ySzqWTeUEKMQFwWlHWsUaSKe5ADMDI8NmdQ0pyE8M/slhg==
X-Received: by 2002:a17:906:494c:: with SMTP id
 f12mr5317962ejt.82.1613463309124; 
 Tue, 16 Feb 2021 00:15:09 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45])
 by smtp.gmail.com with ESMTPSA id f13sm12710695ejf.42.2021.02.16.00.15.07
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Feb 2021 00:15:07 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id n6so11876948wrv.8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 00:15:07 -0800 (PST)
X-Received: by 2002:adf:ea48:: with SMTP id j8mr22504831wrn.197.1613463306880; 
 Tue, 16 Feb 2021 00:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de>
 <20210202095110.1215346-7-hch@lst.de>
In-Reply-To: <20210202095110.1215346-7-hch@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 16 Feb 2021 17:14:55 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BXAWeB2h4RvqsF1q8ip-Rhew80c7y1_og22-x3rS8KOQ@mail.gmail.com>
Message-ID: <CAAFQd5BXAWeB2h4RvqsF1q8ip-Rhew80c7y1_og22-x3rS8KOQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] dma-iommu: implement ->alloc_noncontiguous
To: Christoph Hellwig <hch@lst.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
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

Hi Christoph


On Tue, Feb 2, 2021 at 6:51 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Implement support for allocating a non-contiguous DMA region.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/dma-iommu.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 85cb004d7a44c6..4e0b170d38d57a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -718,6 +718,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
>                 goto out_free_sg;
>
>         sgt->sgl->dma_address = iova;
> +       sgt->sgl->dma_length = size;
>         return pages;
>
>  out_free_sg:
> @@ -755,6 +756,36 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>         return NULL;
>  }
>
> +#ifdef CONFIG_DMA_REMAP
> +static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
> +               size_t size, enum dma_data_direction dir, gfp_t gfp)
> +{
> +       struct dma_sgt_handle *sh;
> +
> +       sh = kmalloc(sizeof(*sh), gfp);
> +       if (!sh)
> +               return NULL;
> +
> +       sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp,
> +                                                   PAGE_KERNEL, 0);

When working on the videobuf2 integration with Sergey I noticed that
we always pass 0 as DMA attrs here, which removes the ability for
drivers to use DMA_ATTR_ALLOC_SINGLE_PAGES.

It's quite important from a system stability point of view, because by
default the iommu_dma allocator would prefer big order allocations for
TLB locality reasons. For many devices, though, it doesn't really
affect the performance, because of random access patterns, so single
pages are good enough and reduce the risk of allocation failures or
latency due to fragmentation.

Do you think we could add the attrs parameter to the
dma_alloc_noncontiguous() API?

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
