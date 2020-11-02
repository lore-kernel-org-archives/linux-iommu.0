Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF2C388F9
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 07:26:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749E922277
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 07:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQsDUxSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749E922277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 10E6A8733C;
	Mon,  2 Nov 2020 07:26:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VqZxLTOyXtji; Mon,  2 Nov 2020 07:26:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 31E01859B1;
	Mon,  2 Nov 2020 07:26:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E6E9C0889;
	Mon,  2 Nov 2020 07:26:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7E28C0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 07:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C5A77872C3
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 07:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pgUCQbI0nkmz for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 07:26:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 635F6872A3
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 07:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=y0f6ILCwtq4G+l9+dzGcdDEE6zW8nF1rcA+SQ7hGP2Q=; b=YQsDUxSNrCxLMQfAwGNAx8h0Lz
 20Q6eFBq0hAyPnbv3ZshQgTuK1gvnKRVX/9BKvWhHOA4xxqCQOsH6TwtgnHv2qCIaJ4s56naO746z
 j15kmyIT2hVeA+t8BKYDVu36OqN5btYOJBh0Nz6S0+1MZt12GgAoOdwTLJmiGEZyKSQQOucpXxNXL
 2lvZx8QC7PxWI3ID9DJXVzhKPmMKUcrboFoB67/ieTfz05Y+JrXNW6SXpCLQgKm9CGp18YwneIvWI
 chHRncwkGJ0vynewQaS1y1ZjnnoH9f22fTMymFov4OzDvjl8PzQLpbsNJwDBU8Udz2hd7WLJRd5Ox
 njkGa95A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kZUE2-0004Ct-O8; Mon, 02 Nov 2020 07:25:58 +0000
Date: Mon, 2 Nov 2020 07:25:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] dma-mapping fix for 5.10
Message-ID: <20201102072558.GA12588@infradead.org>
References: <20201031093823.GA453843@infradead.org>
 <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wgetKKWar8M0VW4mXBY4p5_oCMH=nvU001pkozEgsMEKg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
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

On Sat, Oct 31, 2020 at 12:50:44PM -0700, Linus Torvalds wrote:
> So this is just a stylistic nit, and has no impact on this pull (which
> I've done). But looking at the patch, it triggers one of my "this is
> wrong" patterns.

Adding the author and maintainer of that code so that they can sort it
out.

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
> 
> Another example is using "~0ul", which would give different results on
> a 32-bit kernel and a 64-bit kernel. Again: DON'T DO THAT.
> 
> I repeat: the right thing to do for "all bits set" is just a plain ~0
> or -1. Either of those are fine (technically assumes a 2's complement
> machine, but let's just be honest: that's a perfectly fine assumption,
> and -1 might be preferred by some because it makes that sign extension
> behavior of the integer constant more obvious).
> 
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
> 
> Why? Because "~0" works regardless of type. IOW, exactly *because*
> people used the wrong pattern for "all bits set", that patch was now
> (a) bigger than necessary and (b) much more ilkely to cause bugs (ie I
> could have imagined people changing just the type of the variable
> without changing the initialization).
> 
> So in that tiny three-line patch there were actually several examples
> of why "~0" is the right pattern to use for "all bits set". Because it
> JustWorks(tm) in ways other patterns do not.
> 
> And if you have a compiler that complains about assigning -1 or ~0 to
> an unsigned variable, get rid of that piece of garbage. You're almost
> certainly either using some warning flag that you shouldn't be using,
> or the compiler writer didn't know what they were doing.
> 
>             Linus
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
