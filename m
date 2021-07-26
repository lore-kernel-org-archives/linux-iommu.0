Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DADC432BE
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 21:53:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DC260FE4
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 21:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07DC260FE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA1AB400F0;
	Mon, 26 Jul 2021 21:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Ed2ImQylE1L; Mon, 26 Jul 2021 21:53:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9957040162;
	Mon, 26 Jul 2021 21:53:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 681CFC001A;
	Mon, 26 Jul 2021 21:53:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C8B9C000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 21:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 036C440162
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 21:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMvyQIAUO8dH for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 21:53:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFD7B400F0
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 21:53:11 +0000 (UTC)
Received: by mail-yb1-xb35.google.com with SMTP id z18so17279497ybg.8
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6kBp8vg6yrbqOVIKTerlcVAvXP0g+WzVUYrd5yH/+QE=;
 b=XA6S+wcg4qscUKPhrHfs9id0ov3mJw7DOLhvASuXhtr999Q3C6XmfJvxjMDGwtF5yP
 /ROSFbhTi6Bo2WJ7XqA7thr54ZyRRqBxFGPRUUpQDwu5dtF1UF2mNn2XKy0/k6KPL5HO
 BWQQP5EMcW2boq2BtlUyF+Cwh1u74WAo1zqdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6kBp8vg6yrbqOVIKTerlcVAvXP0g+WzVUYrd5yH/+QE=;
 b=ZlXwRXhoH6JRFsqay9Mpg2FJUQS9cE7hY1x+fdoXFoEUZR1hPHikp6QmOhH4Irjbf8
 UwyIetQi6aPvVDMEhtZ0MHP3g6XiHdj0Tm+rFIzhA/CvafWabN5Nb3uxm6VInysft2z7
 hqiBlzOgRAOLuQCzWKPWc41YB2UkVd7gZ3riGYOt6Oa9eR1VSiga83edpCIL+IYviT/U
 5czrp2pus54Z50PPOdPiXee1B0eunOyWHkrbNdvuJiIGDnFOzVjX/c8PqEFMGtLUTB/y
 sz835yblj3kBuOSf/p5P6ncGMDgBKmewjqAI1NmdOBcrMrZ4MIutCzeGC6GebE9+qqW+
 b1YQ==
X-Gm-Message-State: AOAM531sB0VGaJGVAc5PlyZUtGrgvBNtNC4PUQzU3vz1qxGRJaKule1a
 HJdYKylWR3Hsa7qhsxjMnxxnbRcB5W9B+fdlPNyW
X-Google-Smtp-Source: ABdhPJw1sNKFekdI1Ln5GFGtrd+fGGKvAqudNs0O/HZL6Z2vY9+JbXh7u0IWSx+tE6iFXOzqgaQ/prFDh7B5VuUxCDI=
X-Received: by 2002:a25:d015:: with SMTP id h21mr25548749ybg.202.1627336390145; 
 Mon, 26 Jul 2021 14:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com>
 <20210723214031.3251801-2-atish.patra@wdc.com>
 <20210726065657.GA9035@lst.de>
In-Reply-To: <20210726065657.GA9035@lst.de>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 26 Jul 2021 14:52:59 -0700
Message-ID: <CAOnJCUJFOZsqC2F9sqJqYw5bLJK0fQS+w=Rp6PeM2ih=75Cxag@mail.gmail.com>
Subject: Re: [RFC 1/5] RISC-V: Implement arch_sync_dma* functions
To: Christoph Hellwig <hch@lst.de>
Cc: devicetree <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@linux.alibaba.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
 Atish Patra <atish.patra@wdc.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Tobias Klauser <tklauser@distanz.ch>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>
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

On Sun, Jul 25, 2021 at 11:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> > +struct riscv_dma_cache_sync {
> > +     void (*cache_invalidate)(phys_addr_t paddr, size_t size);
> > +     void (*cache_clean)(phys_addr_t paddr, size_t size);
> > +     void (*cache_flush)(phys_addr_t paddr, size_t size);
> > +};
> > +
> > +void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops);
> > +#endif
>
> As told a bunch of times before: doing indirect calls here is a
> performance nightmare.  Use something that actually does perform
> horribly like alternatives.  Or even delay implementing that until
> we need it and do a plain direct call for now.
>

I was initially planning to replace this with alternatives in the
future versions. But there is no point in doing it
until we have CMO spec finalized. We also don't have any other
platform using these apart from sifive l2
cache controllers for now.

I will change these to direct for now.

> static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +     if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
> > +             dma_cache_sync->cache_invalidate(paddr, size);
> > +     else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
> > +             dma_cache_sync->cache_clean(paddr, size);
> > +     else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
> > +             dma_cache_sync->cache_flush(paddr, size);
> > +}
>
> The seletion of flush types is completely broken.  Take a look at the
> comment in arch/arc/mm/dma.c above arch_sync_dma_for_device for a good
> explanation.
>

Thanks. I will fix it.

> > +void arch_dma_prep_coherent(struct page *page, size_t size)
> > +{
> > +     void *flush_addr = page_address(page);
> > +
> > +     memset(flush_addr, 0, size);
>
> arch_dma_prep_coherent is not supposed to modify the content of
> the data.

Sorry. This was a leftover from some experimental code. It shouldn't
have been included.

> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
Regards,
Atish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
