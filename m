Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD94C00A89
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 11:00:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8C12225E
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 11:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8C12225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 89DBF87378;
	Mon,  2 Nov 2020 11:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBFHVGVRaJHP; Mon,  2 Nov 2020 11:00:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3B5E18735C;
	Mon,  2 Nov 2020 11:00:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C834C0889;
	Mon,  2 Nov 2020 11:00:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37438C0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 11:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1D061203DE
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 11:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ljj+Gfny-Oyp for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 11:00:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by silver.osuosl.org (Postfix) with ESMTPS id EC8242035C
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 11:00:27 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id j14so1996779ots.1
 for <iommu@lists.linux-foundation.org>; Mon, 02 Nov 2020 03:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Est9z1fD3Li8EgxUfKLKw9jqrC1ujvYEuzVL+Qvht4A=;
 b=YCcix2dyBSW11Kdna+sdEVT8UatwPMJcOdlC1NIuduqx/ScOCCZCT9BM0sEd/6zB4+
 qIpb6Yw8SLGlbUgOiwwJ74AtWUIWLQbBOll6eEf336EIHvqAfDQcy//pNS82owOsAnU6
 kB9DVHgDhAIb/uvdh4H3fx3LVd0c8v7UNowiek4Ib/2XIk4a/5q1wCYl8t6CrotKitGi
 GRYFa3LpwC9EBtIo7Xv8LMPBQ0dELtBMzYYhBkr+xqcEkVWiEd6Uldz/aAQJ5KBrRgcN
 4ZeiWSPqqAfgQiPtTjzV9BYZqSVkVA05ZMKJeoIadwNqm9f3xrkiFgumYQtz+5gCQUHI
 pXyQ==
X-Gm-Message-State: AOAM532WqtOOrOwpacL2hbbK8NdSOJqsl3ibyUrQBRo+zYf5soSeHySV
 C97I474jNzaUNIUay8d9QbHbEICdfWmbF6/L77E=
X-Google-Smtp-Source: ABdhPJyBpL+PeeLUEXiVaPZCo+Jvm31VUCsN3zE+dXDJ1eFI4W9tfAA3CcQBA6aMvyEvrPeYxISX9Ot8L7tpC9vlADo=
X-Received: by 2002:a05:6830:210a:: with SMTP id
 i10mr11484382otc.145.1604314825756; 
 Mon, 02 Nov 2020 03:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20201031093823.GA453843@infradead.org>
 <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
In-Reply-To: <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Nov 2020 12:00:14 +0100
Message-ID: <CAMuHMdVyL7_VaqfVPxESmPBe=pntcRdB3_PEArU4JQasX0EBfA@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for 5.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Linus,

On Sat, Oct 31, 2020 at 8:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Oct 31, 2020 at 2:40 AM Christoph Hellwig <hch@infradead.org> wrote:
> > dma-mapping fix for 5.10:
> >
> >  - fix an integer overflow on 32-bit platforms in the new DMA range code
> >    (Geert Uytterhoeven)
>
> So this is just a stylistic nit, and has no impact on this pull (which
> I've done). But looking at the patch, it triggers one of my "this is
> wrong" patterns.
>
> In particular, this:
>
>         u64 dma_start = 0;
>         ...
>         for (dma_start = ~0ULL; r->size; r++) {
>
> is actually completely bogus in theory, and it's a horribly horribly
> bad pattern to have.
>
> The thing that I hate about that parttern is "~0ULL", which is simply wrong.
>
> The correct pattern for "all bits set" is ~0. NOTHING ELSE. No extra
> letters at the end.
>
> Why? Because using an unsigned type is wrong, and will not extend the
> bits up to a potentially bigger size.
>
> So adding that "ULL" is not just three extra characters to type, it
> actually _detracts_ from the code and makes it more fragile and
> potentially wrong.
>
> It so happens, that yes, in the kernel, "ull" us 64-bit, and you get
> the right results. So the code _works_. But it's wrong, and it now
> requires that the types match exactly (ie it would not be broken if
> somebody ever were to say "I want to use use 128-bit dma addresses and
> u128").

Thanks, you're right, the "ULL" suffix is not needed, and could cause
future issues.

> Another example is using "~0ul", which would give different results on
> a 32-bit kernel and a 64-bit kernel. Again: DON'T DO THAT.

Definitely.

> I repeat: the right thing to do for "all bits set" is just a plain ~0
> or -1. Either of those are fine (technically assumes a 2's complement
> machine, but let's just be honest: that's a perfectly fine assumption,
> and -1 might be preferred by some because it makes that sign extension
> behavior of the integer constant more obvious).

"-1" definitely causes warnings, depending on your compiler (not with
the gcc 9.3.0 I'm currently using, though).

> Don't try to do anything clever or anything else, because it's going
> to be strictly worse.
>
> The old code that that patch removed was "technically correct", but
> just pointless, and actually shows the problem:
>
>         for (dma_start = ~(dma_addr_t)0; r->size; r++) {
>
> the above is indeed a correct way to say "I want all bits set in a
> dma_addr_t", but while correct, it is - once again - strictly inferior
> to just using "~0".

Obviously I was misled by the old code, and instead of changing
the cast, I replaced the cast ("casts are evil") by a suffix. Doh.

Any, I've just sent a patch. Thanks!

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
