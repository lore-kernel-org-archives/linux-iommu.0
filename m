Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E09AC433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 05:14:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C9123B98
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 05:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C9123B98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2E52A204CA;
	Thu, 10 Dec 2020 05:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ndukpkThNTtl; Thu, 10 Dec 2020 05:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C6CA7204A7;
	Thu, 10 Dec 2020 05:14:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4D28C0893;
	Thu, 10 Dec 2020 05:14:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4F21C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 05:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AC05685F09
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 05:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4AokxkNq8wMB for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 05:14:21 +0000 (UTC)
X-Greylist: delayed 00:05:50 by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B58CC85EBE
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 05:14:20 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id r5so4110944eda.12
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 21:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zIfFQBOsh+7ls9naclLfM4tNpPscvjI/PilgL+vju80=;
 b=OJwNzSYc2vCkYXbkQd7LaHDTEMYMM5zXanNUx+E3D/B5JMCvXpeln9sFRbAtrO0NNr
 Izz7NOcf8psUjJddvGEXsi13gr9RKws2ogr0RKU/WmwdiD/UcxAep/TcH7HnZ2LkzsgN
 lp6FPFsI3g81m6nM8MV7t4CUPWDM12b8EnOx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zIfFQBOsh+7ls9naclLfM4tNpPscvjI/PilgL+vju80=;
 b=d19C4h7ZY3tFoU89yZPCnwE+AeKpUOF95QobuG+0yemkCfOn8fZhXWdMM0XpSsC8z8
 E3yMqCzJ/0ZxFwWM1ZbuaI8/6nRjG+6gkgQYZlSrexB8lSqLHEA38VW9n+zC30EfHxIp
 b0JTptg6C3zMyQTcvE0LkZJX7JjCgG+ilHPLbDLhbVVnur85vz6UCA7qCmyTQ0esUabf
 YIDti4AVEZjVXU9azMsZzK0o1eUP+kYcDHoS6wkQ5FNRe0zSsAYwSQx5ylWATfCWz42D
 6A47sm6ICIfU2rmO8rYCNwqH3ugVkiEX314Nm0s9qCzYu5Y1Km87VLVcrSRsT34WNd/C
 ukaQ==
X-Gm-Message-State: AOAM530lnmf9hVPTzSyv4tx+918HYQFEAIIHrzJU5op+xYvc3MwIPh7d
 iMLuyxN+er2GRjVbeuxaJufRxkWvwOsMfD0h
X-Google-Smtp-Source: ABdhPJyv8ALwUMclnmKELPrZpTAoZgcRbrbbjxE0pcSlRCgS9fFX2Q0FIPwAaGjnYcNoudVq6RREpQ==
X-Received: by 2002:a05:6402:1765:: with SMTP id
 da5mr5186686edb.27.1607576908677; 
 Wed, 09 Dec 2020 21:08:28 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com.
 [209.85.128.43])
 by smtp.gmail.com with ESMTPSA id d4sm3848241edq.36.2020.12.09.21.08.25
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 21:08:25 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id w206so2057434wma.0
 for <iommu@lists.linux-foundation.org>; Wed, 09 Dec 2020 21:08:25 -0800 (PST)
X-Received: by 2002:a1c:5447:: with SMTP id p7mr6054359wmi.116.1607576905237; 
 Wed, 09 Dec 2020 21:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20201125221917.150463-1-ribalda@chromium.org>
 <20201130083410.GD32234@lst.de>
 <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
 <20201209111235.GA22806@lst.de> <6b34596d-34c4-bd99-c5a7-5a4742c5b886@arm.com>
In-Reply-To: <6b34596d-34c4-bd99-c5a7-5a4742c5b886@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 10 Dec 2020 14:08:14 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CJreyn7KSn-kphPzC5v18qCuBq5yGwW+ushrg=azJGRg@mail.gmail.com>
Message-ID: <CAAFQd5CJreyn7KSn-kphPzC5v18qCuBq5yGwW+ushrg=azJGRg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
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

On Wed, Dec 9, 2020 at 10:05 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-12-09 11:12, Christoph Hellwig wrote:
> > On Tue, Dec 08, 2020 at 01:54:00PM +0900, Tomasz Figa wrote:
> >> >From the media perspective, it would be good to have the vmap
> >> optional, similarly to the DMA_ATTR_NO_KERNEL_MAPPING attribute for
> >> coherent allocations. Actually, in the media drivers, the need to have
> >> a kernel mapping of the DMA buffers corresponds to a minority of the
> >> drivers. Most of them only need to map them to the userspace.
> >>
> >> Nevertheless, that minority actually happens to be quite widely used,
> >> e.g. the uvcvideo driver, so we can't go to the other extreme and just
> >> drop the vmap at all.
> >
> > My main problem is that the DMA_ATTR_NO_KERNEL_MAPPING makes a mess
> > of an API.  I'd much rather have low-level API that returns the
> > discontiguous allocations and another one that vmaps them rather
> > than starting to overload arguments like in dma_alloc_attrs with
> > DMA_ATTR_NO_KERNEL_MAPPING.

Okay, makes sense. Actually, a separate mapping function makes it
possible to defer creating the mapping to when (and if) it is really
needed.

>
> Agreed - if iommu-dma's dma_alloc_coherent() ends up as little more than
> a thin wrapper around those two functions I think that would be a good
> sign. It also seems like it might be a good idea for this API to use
> scatterlists rather than page arrays as it's fundamental format, to help
> reduce impedance with dma-buf -

True.

> if we can end up with a wider redesign
> that also gets rid of dma_get_sgtable(), all the better!

That would also require taking care of the old dma_alloc_attrs() API.
I guess it could return an already mapped sgtable, with only 1 mapped
entry and as many following entries as needed to describe the physical
pages. To be honest, I'd say this is far out of scope of this
discussion, though.

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
