Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B139CC433F5
	for <iommu@archiver.kernel.org>; Sun, 27 Mar 2022 19:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52D0581B98;
	Sun, 27 Mar 2022 19:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-hooU0zh3mv; Sun, 27 Mar 2022 19:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E76C081B3E;
	Sun, 27 Mar 2022 19:29:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7A9FC002C;
	Sun, 27 Mar 2022 19:29:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4819C0012
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 19:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFC4760EE2
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 19:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g-Aeh32GoHta for <iommu@lists.linux-foundation.org>;
 Sun, 27 Mar 2022 19:29:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC09E60D59
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 19:29:07 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id q14so16538283ljc.12
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=81R8ObTvU5bcOjgPkhjrVdYMQgLpHwwmsUh10DuWTXw=;
 b=QVswRSXvuEFhZlnuaBAnMB1TOMg78uyn8mRLwSOZtWi/86mVxTdWeJmg8H09RYWcp4
 O6lvIOKP0C2OxXUCyV3ffNy61gxSdcLR6Kl9jGUx2xgYt16l8oVTj7BEMInCe8aUUdRF
 U28WrmitywInVLFpJqv3NSZNOfcB3kKShK/cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=81R8ObTvU5bcOjgPkhjrVdYMQgLpHwwmsUh10DuWTXw=;
 b=atLLoX2XrmiGZF3FTJVHjG/l/MmIsk0/QERirWfTqxdTTxE7UAdM2kKHNv+DvQXGaF
 iq5yQ23Gbdv3Bxh/7Okiz5cuEhju7bEOqUMlxJHbdtqwEn0ajdzb8AAUPEzpblSsPlia
 QKJNCLZpTVwJxCQLwEkazyYh5VKwasgOMDvWTbsCXfrzIYj8iNFfSjPa5MHBIG6gRpXz
 K+T9tTzjIe+OiClMYCg0ljMKHIg2GtRLrPJ+sOYwW1v1vTeu2m2XW57k7XxDTXTMkEDp
 m36EY4k4XGOUoQGitepLSuhGW7jaeAzx/48Sy8qkubquRB9RQ/QeIdjPxYIBbMEKbsnQ
 cU3A==
X-Gm-Message-State: AOAM533apT6UaeDoRdQP1M2e9iBk6PzMMGPXyes6MTP8/y3YnwlavPFk
 jH4Pp15AS7EAYYUWFMzPrD2JTRI4rC+lfuuDWibO1w==
X-Google-Smtp-Source: ABdhPJw0YuHjdpYUEp51CwvbVBcB66pJu0GGdCz3G2fQLJ3OEY/SFgy8kBUGWFnMk3lZUfyMvdED8w==
X-Received: by 2002:a05:651c:1594:b0:247:dce8:b0ec with SMTP id
 h20-20020a05651c159400b00247dce8b0ecmr17408399ljq.404.1648409345160; 
 Sun, 27 Mar 2022 12:29:05 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182]) by smtp.gmail.com with ESMTPSA id
 h7-20020ac25d67000000b0044836d7c475sm1435276lft.147.2022.03.27.12.29.04
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Mar 2022 12:29:04 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id q14so16538214ljc.12
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 12:29:04 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr17499555lja.443.1648409031649; Sun, 27
 Mar 2022 12:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <20220327054848.1a545b12.pasic@linux.ibm.com>
 <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
 <CAHk-=wgUx5CVF_1aEkhhEiRGXHgKzUdKiyctBKcHAxkxPpbiaw@mail.gmail.com>
 <0745b44456d44d1e9fc364e5a3780d9a@AcuMS.aculab.com>
In-Reply-To: <0745b44456d44d1e9fc364e5a3780d9a@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Mar 2022 12:23:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLyqNJx=bb8=o0Nk5U8gMnf0-=qx53ShLEb3V=Yrt8fw@mail.gmail.com>
Message-ID: <CAHk-=wgLyqNJx=bb8=o0Nk5U8gMnf0-=qx53ShLEb3V=Yrt8fw@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: David Laight <David.Laight@aculab.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

On Sun, Mar 27, 2022 at 8:24 AM David Laight <David.Laight@aculab.com> wrote:
>
> Aren't bounce buffers just a more extreme case on non-coherent
> memory accesses?

No.

In fact, this whoe change came about exactly because bounce buffers
are different.

The difference is that bounce buffers have that (wait for it) bounce
buffer, which can have stale contents.

> They just need explicit memory copies rather than just cache
> writeback and invalidate operations.

That's the thing - the memory copies introduce entirely new issues.

I really think that instead of making up abstract rules ("ownership"
or "bounce buffers are just extreme cases of non-coherency") we should
make the rules very much practical and down to earth, and write out
exactly what they *do*.

The whole "sync DMA" is odd and abstract enough as a concept on its
own, we shouldn't then make the rules for it odd and abstract. We
should make them very very practical.

So I will propose that we really make it very much about practical
concerns, and we document things as

 (a) the "sync" operation has by definition a "whose _future_ access
do we sync for" notion.

     So "dma_sync_single_for_cpu()" says that the future accesses to
this dma area is for the CPU.

     Note how it does *NOT* say that the "CPU owns the are". That's
bullsh*t, and we now know it's BS.

 (b) but the sync operation also has a "who wrote the data we're syncing"

     Note that this is *not* "who accessed or owned it last", because
that's nonsensical: if we're syncing for the CPU, then the only reason
to do so is because we expect that the last access was by the device,
so specifying that separately would just be redundant and stupid.

     But specifying who *wrote* to the area is meaningful and matters.
It matters for the non-coherent cache case (because of writeback
issues), but it also matters for the bounce buffer case (becasue it
determines which way we should copy).

Note how this makes sense: a "sync" operation is clearly about taking
some past state, and making it palatable for a future use. The past
state is pretty much defined by who wrote the data, and then we can
use that and the "the next thing to access it" to determine what we
need to do about the sync.

It is *NOT* about "ownership".

So let's go through the cases, and I'm going to ignore the "CPU caches
are coherent with device DMA" case because that's always going to be a
no-op wrt data movement (but it will still generally need a memory
barrier, which I will mention here and then ignore going forward).

Syncing for *CPU* accesses (ie dma_sync_single_for_cpu()) has four
choices I can see:

 - nobody wrote the data at all (aka DMA_NONE).

   This is nonsensical and should warn. If nobody wrote to it, why
would the CPU ever validly access it?

   Maybe you should have written "memset(buffer, 0, size)" instead?

 - the CPU wrote the data in the first place (aka DMA_TO_DEVICE)

   This is a no-op (possibly a memory barrier), because even stale CPU
caches are fine, and even if it was in a bounce buffer, the original
CPU-side data is fine.

 - the device wrote the data (aka DMA_FROM_DEVICE)

   This is just the regular case of a device having written something,
and the CPU wants to see it.

   It obviously needs real work, but it's simple and straightforward.

   For non-coherent caches, it needs a cache invalidate. For a bounce
buffer, it needs a copy from the bounce buffer to the "real" buffer.

 - it's not clear who write the data (aka DMA_BIDIRECTIONAL)

   This is not really doable for a bounce buffer - we just don't know
which buffer contents are valid.

   I think it's very very questionable for non-coherent caches too,
but "writeback and invalidate" probably can't hurt.

   So probably warn about it, and do whatever we used to do historically.

Syncing for device accesses (ie dma_sync_single_for_device()) also has
the same four choices I can see, but obviously does different things:

 - nobody wrote the data at all (aka DMA_NONE)

   This sounds as nonsensical as the CPU case, but maybe isn't.

   We may not have any previous explicit writes, but we *do* have that
"insecure and possibly stale buffer contents" bounce buffer thing on
the device side.

   So with a bounce buffer, it's actually somewhat sane to say
"initialize the bounce buffer to a known state".

   Because bounce buffers *are* special. Unlike even the "noncoherent
caches" issue, they have that entirely *other* hidden state in the
form of the bounce buffer itself.

   Discuss.

 - the CPU wrote the data in the first place (aka DMA_TO_DEVICE).

   This is the regular and common case of "we have data on the CPU
side that is written to the device".

   Again, needs work, but is simple and straightforward.

   For non-coherent caches, we need a writeback on the CPU. For a
bounce buffer, we need to copy from the regular buffer to the bounce
buffer.

 - the device wrote the data in the first place (aka DMA_FROM_DEVICE)

   This is the case that we hit on ath9k. It's *not* obvious, but when
we write this out this way, I really think the semantics are pretty
clear.

   For non-coherent caches, we may need an "invalidate". For a bounce
buffer, it's a no-op (because the bounce buffer already contains the
data)

 - it's not clear who write the data (aka DMA_BIDIRECTIONAL)

   This is again not really doable for a bounce buffer. We don't know
which buffer contains the right data, we should warn about it and do
whatever we used to do historically.

   Again, it's very questionable for non-coherent caches too, but
"writeback and invalidate" probably at least can't hurt.

So hey, that's my thinking. The whole "ownership"  model is, I think,
obviously untenable.

But just going through and listing the different cases and making them
explicit I think explains exactly what the different situations are,
and that then makes it fairly clear what the different combinations
should do.

No?

           Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
