Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE74CC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 12:25:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22FA20659
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 12:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22FA20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7616B86D95;
	Mon,  8 Jun 2020 12:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lNHnPATWtYrj; Mon,  8 Jun 2020 12:25:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DC8CF86BC5;
	Mon,  8 Jun 2020 12:25:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEC1DC07FF;
	Mon,  8 Jun 2020 12:25:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF87FC016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 12:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 96CCE86D89
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 12:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZMq+miIS-lKc for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 12:25:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 747BC86BC5
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 12:25:15 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id k4so13524602oik.2
 for <iommu@lists.linux-foundation.org>; Mon, 08 Jun 2020 05:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tAGHOxBD5U35L+Ym8KTN1WsWz5xETmW1JZ5ES9tNCwg=;
 b=YjQtUVVDMAAbLOuOhT/pb4HRVPmpS7b4+sZfA/utZniPfqBZ3DeFCl8Kp6OP9TWdbc
 C2hbKzLAK06fgEtgO70N+Tu+xoIbpy5ETj9b8YBO1lVrjl2fluKjnT8sQm2AVn2HF3qf
 cf522K64kF2UstOSvdwqniSIXuDwK0DhkIkg9FnNWbgWwdpO3xTbMq40673UTvC4OtHy
 2Cfg9k268ao5TcDQ+drQxQmPuJdd/qX1qk9JXHffJHUyoCicE/CG2wvNJnTzE3LfLYD9
 A0d8POs4bS4yLpioOv2LmYrxNR5Dm+6UmsKd4qaKJS3cBLVWRHthksnUEB4MbjwTa4lq
 ObHQ==
X-Gm-Message-State: AOAM532Ry/MAvJT/KvHljm/gcdsagiVjhil2LKIMhKylF0Z5Fd0Qbr8h
 dPOGaPwBtyqftnnVMg250Mt4jvWfMH9f+xt5cLw=
X-Google-Smtp-Source: ABdhPJx2QuTZJlEyepsOlHlVT9XLDhjjIIeM7RFdPcPPbYEzN+LJuzI+N+F93TZ5wJhjAEdyn47WZ+CGkufrLca/zog=
X-Received: by 2002:aca:4255:: with SMTP id p82mr9919971oia.153.1591619114741; 
 Mon, 08 Jun 2020 05:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200608085231.8924-1-geert@linux-m68k.org>
 <92b53a24-2f1f-2add-6bea-eeda7317520f@arm.com>
In-Reply-To: <92b53a24-2f1f-2add-6bea-eeda7317520f@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Jun 2020 14:25:03 +0200
Message-ID: <CAMuHMdXxT5ZgcK5r0MWOk7vWVj63gmr6k3zgACe2Lew7Q4KC9w@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Fix too large DMA pools on medium systems
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Christoph Hellwig <hch@lst.de>
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

Hi Robin,

On Mon, Jun 8, 2020 at 2:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-06-08 09:52, Geert Uytterhoeven wrote:
> > On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
> > memory pools are much larger than intended (e.g. 2 MiB instead of 128
> > KiB on a 256 MiB system).
> >
> > Fix this by correcting the calculation of the number of GiBs of RAM in
> > the system.
> >
> > Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -175,8 +175,8 @@ static int __init dma_atomic_pool_init(void)
> >        * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
> >        */
> >       if (!atomic_pool_size) {
> > -             atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
> > -                                     SZ_128K;
> > +             unsigned long gigs = totalram_pages() >> (30 - PAGE_SHIFT);
> > +             atomic_pool_size = max(gigs, 1UL) * SZ_128K;
> >               atomic_pool_size = min_t(size_t, atomic_pool_size,
> >                                        1 << (PAGE_SHIFT + MAX_ORDER-1));
> >       }
>
> Nit: although this probably is right, it seems even less readable than

">> (x - PAGE_SHIFT)" is a commonly used construct in the kernel.

> the broken version (where at least some at-a-glance 'dimensional
> analysis' flags up "(number of pages) >> PAGE_SHIFT" as rather
> suspicious). How about a something a little more self-explanatory, e.g.:
>
>         unsigned long pages = totalram_pages() * SZ_128K / SZ_1GB;

That multiplication will overflow on 32-bit systems (perhaps even on
large 64-bit systems; any 47-bit addressing?).

        unsigned long pages = totalram_pages() / (SZ_1GB / SZ_128K);

>         atomic_pool_size = min(pages, MAX_ORDER_NR_PAGES) << PAGE_SHIFT;
>         atomic_pool_size = max_t(size_t, atomic_pool_size, SZ_128K);

I agree this part is an improvement.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
