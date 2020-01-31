Return-Path: <SRS0=FJ9b=3U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE576C3F68F
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 00:18:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8066D2063A
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 00:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LEMVWagj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8066D2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4633C87456;
	Fri, 31 Jan 2020 00:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3K-pbhMPJQuB; Fri, 31 Jan 2020 00:18:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7186B86762;
	Fri, 31 Jan 2020 00:18:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C12C0178;
	Fri, 31 Jan 2020 00:18:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE20DC0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 00:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A42CB87AF4
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 00:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VfkAXlJI9hof for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 00:18:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com
 [209.85.219.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B506B87A15
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 00:18:04 +0000 (UTC)
Received: by mail-yb1-f194.google.com with SMTP id x191so2341951ybg.12
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 16:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hF2uri2aH+78mejNdKG+rVcZv1FZ9AQQm5DHda9hg3Y=;
 b=LEMVWagjq9IHsRT1N0YSQld0Z9pg/FWjOVQTVDm0DCgkz6rN6RJnt/Wx4NmoLjvMsX
 qlfO2naQ+BxZd6O36bK4trB+Pwy2LAQoJRiZZjSlqlfiYI551etXcJfCOhBktx+VeJkB
 oNoBfx7XcF0yagmyOWlMfhG7DWsPz+UhQsipxQ20UMNRoktF37WDBf+fP8vq2ocY2Ck/
 /BTfRI+qIXouLpv+wvG1Y6c9UC2BEMpOI5l5V80rJIWmjE7JuQ3DwHYXiWQdzs8pkgCp
 25VDee8OzEChxWLgmIBw+DIBEaV38wmUWHqv5Ubwc+8qlMpqGI3JiiHzfejl/82UZrL6
 Cs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hF2uri2aH+78mejNdKG+rVcZv1FZ9AQQm5DHda9hg3Y=;
 b=qRzdn2Il845GDl/dfUkFYqpGS7rCcylLOD8apVXR4GWdAUiR4XjpdZdsBo/VmMO+Se
 mVX2uiWtQVWzlF2rcR3/GvzLDimheJDvS+l75xeTtruDQnGBwTQl+mDRyi4PkE8Rig8F
 JRpmXJEeFYCsplEofgs7Nqf8tTwFl7yxjuWO3lILXP67gfPl107rCuHUKjz+6CKkd3x7
 42GtzXLW2PE80JJ11Ph2pxcxP0yI/MESdNv9yks3r4Sg2LXElkJpNDzwrIKZToE9/Vk/
 5OITXosOSz0/RIBjbqqW8ELnnwsIrvG4FFfo2M0xTBg9Lja6bOhhgHPIWnnJhjwG0/mU
 s+ZA==
X-Gm-Message-State: APjAAAXb66RIuFElQCU46GYtQcc9TKLC6qfJAxbFDCvX+ewwZJnVvPHN
 7A0HqcvMCnzrCimH4TZU8RYxhTL8ylgiIy45P3/jZA==
X-Google-Smtp-Source: APXvYqzo9mVJlQvwbEO7uIevXdJw+eKYxmptR5iiO+YkOAIycZb4Mzajmi+oa0jsmoRB5D7mRvzmqrWLB8+2qh7u4y8=
X-Received: by 2002:a5b:489:: with SMTP id n9mr5859875ybp.395.1580429883367;
 Thu, 30 Jan 2020 16:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20200130191049.190569-1-edumazet@google.com>
 <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
In-Reply-To: <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
Date: Thu, 30 Jan 2020 16:17:52 -0800
Message-ID: <CANn89i+fRqeSAz9eH8f2ujzBWSLUXw0eTT=tK=eNj8hL71MiFQ@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: dynamic allocation of hash table
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>, Eric Dumazet <eric.dumazet@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>
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
From: Eric Dumazet via iommu <iommu@lists.linux-foundation.org>
Reply-To: Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jan 30, 2020 at 3:46 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Eric,
>
> On 2020-01-30 7:10 pm, Eric Dumazet via iommu wrote:
> > Increasing the size of dma_entry_hash size by 327680 bytes
> > has reached some bootloaders limitations.
>
> [ That might warrant some further explanation - I don't quite follow how
> this would relate to a bootloader specifically :/ ]

I had no details, please look at the prior thread where this has been discussed.

https://www.spinics.net/lists/linux-renesas-soc/msg46157.html


>
> > Simply use dynamic allocations instead, and take
> > this opportunity to increase the hash table to 65536
> > buckets. Finally my 40Gbit mlx4 NIC can sustain
> > line rate with CONFIG_DMA_API_DEBUG=y.
>
> That's pretty cool, but I can't help but wonder if making the table
> bigger caused a problem in the first place, whether making it bigger yet
> again in the name of a fix is really the wisest move. How might this
> impact DMA debugging on 32-bit embedded systems with limited vmalloc
> space and even less RAM, for instance? More to the point, does vmalloc()
> even work for !CONFIG_MMU builds? Obviously we don't want things to be
> *needlessly* slow if avoidable, but is there a genuine justification for
> needing to optimise what is fundamentally an invasive heavyweight
> correctness check - e.g. has it helped expose race conditions that were
> otherwise masked?

Not sure what you are saying.

vmalloc() _is_ supported by all arches, even !CONFIG_MMU

I can not test all platforms, and this is a debugging
feature no one uses in production.

>
> That said, by moving to dynamic allocation maybe there's room to be
> cleverer and make HASH_SIZE scale with, say, system memory size? (I
> assume from the context it's not something we can expand on-demand like
> we did for the dma_debug_entry pool)
>

How memory size can serve as a proxy of the number of entries ?
Current 10Gbit NIC need about 256,000 entries in the table.
Needless to say, the prior hash size was unusable.

As I suggested one month ago, HASH_SIZE can be tuned by a developper
eager to use this facility.

65536 slots are 768 KB on 32bit platforms.

> Robin.
>
> > Fixes: 5e76f564572b ("dma-debug: increase HASH_SIZE")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > ---
> >   kernel/dma/debug.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index 2031ed1ad7fa109bb8a8c290bbbc5f825362baba..a310dbb1515e92c081f8f3f9a7290dd5e53fc889 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -27,7 +27,7 @@
> >
> >   #include <asm/sections.h>
> >
> > -#define HASH_SIZE       16384ULL
> > +#define HASH_SIZE       65536ULL
> >   #define HASH_FN_SHIFT   13
> >   #define HASH_FN_MASK    (HASH_SIZE - 1)
> >
> > @@ -90,7 +90,8 @@ struct hash_bucket {
> >   };
> >
> >   /* Hash list to save the allocated dma addresses */
> > -static struct hash_bucket dma_entry_hash[HASH_SIZE];
> > +static struct hash_bucket *dma_entry_hash __read_mostly;
> > +
> >   /* List of pre-allocated dma_debug_entry's */
> >   static LIST_HEAD(free_entries);
> >   /* Lock for the list above */
> > @@ -934,6 +935,10 @@ static int dma_debug_init(void)
> >       if (global_disable)
> >               return 0;
> >
> > +     dma_entry_hash = vmalloc(HASH_SIZE * sizeof(*dma_entry_hash));
> > +     if (!dma_entry_hash)
> > +             goto err;
> > +
> >       for (i = 0; i < HASH_SIZE; ++i) {
> >               INIT_LIST_HEAD(&dma_entry_hash[i].list);
> >               spin_lock_init(&dma_entry_hash[i].lock);
> > @@ -950,6 +955,7 @@ static int dma_debug_init(void)
> >               pr_warn("%d debug entries requested but only %d allocated\n",
> >                       nr_prealloc_entries, nr_total_entries);
> >       } else {
> > +err:
> >               pr_err("debugging out of memory error - disabled\n");
> >               global_disable = true;
> >
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
