Return-Path: <SRS0=4X9E=EG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE04CC388F7
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 19:51:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F069206E5
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 19:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SFd38h0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F069206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B4F272A0D9;
	Sat, 31 Oct 2020 19:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rWCl-P29yGar; Sat, 31 Oct 2020 19:51:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8F939276D4;
	Sat, 31 Oct 2020 19:51:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61E05C088B;
	Sat, 31 Oct 2020 19:51:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01AF7C0051
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 19:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DF89586E00
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 19:51:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BScFIKqlC77Q for <iommu@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 19:51:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 72EFD85D21
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 19:51:04 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id v6so12177893lfa.13
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LiakrPlGp3igHM/6fphDsdHN4n1+gIPlYP0eHS2J38c=;
 b=SFd38h0YaAG3EVDBMFA8YIEBKo1Whx1Fuoqa5Z1RwOcinbEUBfuT5ib+oz2EUbWXQt
 SPktpQcp30PqY2Ni8wgEZYWrGyBja5NxjglfpeIAdx6NpxhOJXtSOHlPEu5RfT1OAG7r
 /VitCVlOWSEFQRU/6GHFAOb2b6dy1k04HEDuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LiakrPlGp3igHM/6fphDsdHN4n1+gIPlYP0eHS2J38c=;
 b=BJ9jA/tO0qvpm29pYQRPETbP0hB2MX+tgsbkoIW5Qcq9TJW34Y5b/gTLecqoRsKrOY
 vTUpMjT1RhYVbI1eykBv6oaRXxc2IeGhxSyjqi5uQ2Sw050f115se8l+O72vASZEBlxO
 cF5tVddl7Z8u0VWe2D6+9i9eYbHtNLYjeoKbZsr5mth7Qu7ZVKOUto7wKt3bnZox+jjO
 9st1hYnhIjB9Uoz51JsPsXN5hWvhshDYztDSdR5+K0dY9eoOVQ0r3BOm/AQCUrE8AuCl
 mUy5pV5L1sWzv+0BJHpen3YO7QPri0226KSAOtWdRqkhUajpLP+5m0nh4tv2/PG+UsY5
 Y8wg==
X-Gm-Message-State: AOAM5320ZGgEqj79rFHewGGlpVv4BYYAzFu+tFKGr4Dkb/4BjzX+X/B2
 N98VI4ZaJHQpqN3ifA7XLv5Hf+J7rz/vvftX
X-Google-Smtp-Source: ABdhPJxLMon5F7t0OolT/KOzEmKw/fWOtbu4O/77g2BaudTxcOUWHWmIIJAHhLc3I+c1s5mSlDXR8w==
X-Received: by 2002:a05:6512:3202:: with SMTP id
 d2mr3335279lfe.250.1604173862115; 
 Sat, 31 Oct 2020 12:51:02 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id d6sm1227988lja.63.2020.10.31.12.51.00
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2020 12:51:01 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id x6so10655021ljd.3
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 12:51:00 -0700 (PDT)
X-Received: by 2002:a2e:3e1a:: with SMTP id l26mr3610904lja.285.1604173860298; 
 Sat, 31 Oct 2020 12:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201031093823.GA453843@infradead.org>
In-Reply-To: <20201031093823.GA453843@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 31 Oct 2020 12:50:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
Message-ID: <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for 5.10
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu <iommu@lists.linux-foundation.org>,
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

On Sat, Oct 31, 2020 at 2:40 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> dma-mapping fix for 5.10:
>
>  - fix an integer overflow on 32-bit platforms in the new DMA range code
>    (Geert Uytterhoeven)

So this is just a stylistic nit, and has no impact on this pull (which
I've done). But looking at the patch, it triggers one of my "this is
wrong" patterns.

In particular, this:

        u64 dma_start = 0;
        ...
        for (dma_start = ~0ULL; r->size; r++) {

is actually completely bogus in theory, and it's a horribly horribly
bad pattern to have.

The thing that I hate about that parttern is "~0ULL", which is simply wrong.

The correct pattern for "all bits set" is ~0. NOTHING ELSE. No extra
letters at the end.

Why? Because using an unsigned type is wrong, and will not extend the
bits up to a potentially bigger size.

So adding that "ULL" is not just three extra characters to type, it
actually _detracts_ from the code and makes it more fragile and
potentially wrong.

It so happens, that yes, in the kernel, "ull" us 64-bit, and you get
the right results. So the code _works_. But it's wrong, and it now
requires that the types match exactly (ie it would not be broken if
somebody ever were to say "I want to use use 128-bit dma addresses and
u128").

Another example is using "~0ul", which would give different results on
a 32-bit kernel and a 64-bit kernel. Again: DON'T DO THAT.

I repeat: the right thing to do for "all bits set" is just a plain ~0
or -1. Either of those are fine (technically assumes a 2's complement
machine, but let's just be honest: that's a perfectly fine assumption,
and -1 might be preferred by some because it makes that sign extension
behavior of the integer constant more obvious).

Don't try to do anything clever or anything else, because it's going
to be strictly worse.

The old code that that patch removed was "technically correct", but
just pointless, and actually shows the problem:

        for (dma_start = ~(dma_addr_t)0; r->size; r++) {

the above is indeed a correct way to say "I want all bits set in a
dma_addr_t", but while correct, it is - once again - strictly inferior
to just using "~0".

Why? Because "~0" works regardless of type. IOW, exactly *because*
people used the wrong pattern for "all bits set", that patch was now
(a) bigger than necessary and (b) much more ilkely to cause bugs (ie I
could have imagined people changing just the type of the variable
without changing the initialization).

So in that tiny three-line patch there were actually several examples
of why "~0" is the right pattern to use for "all bits set". Because it
JustWorks(tm) in ways other patterns do not.

And if you have a compiler that complains about assigning -1 or ~0 to
an unsigned variable, get rid of that piece of garbage. You're almost
certainly either using some warning flag that you shouldn't be using,
or the compiler writer didn't know what they were doing.

            Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
