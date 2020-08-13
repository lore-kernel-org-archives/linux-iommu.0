Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D18C433E3
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 23:37:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F338207DA
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 23:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wT9av0mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F338207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3360388A08;
	Thu, 13 Aug 2020 23:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pBt3rwa4rsT8; Thu, 13 Aug 2020 23:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 89BBA88A00;
	Thu, 13 Aug 2020 23:37:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F2C8C013C;
	Thu, 13 Aug 2020 23:37:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 859E5C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 23:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7BA318890A
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 23:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VIdbNvKSGNQe for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 23:37:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8CF41887B5
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 23:37:41 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id p24so8015559ejf.13
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=608qNLHC5/4osjXyTeWl015DQW4m7Dc2t3DShU7YJe0=;
 b=wT9av0mbZ1q5xaMLNh0532iGn6upLZ8tbnSY+oa8bj1AUaRnxl4mj2HgbqZ9zzCL/q
 WXU14AgUuY89PCDZzKvDXTsX9uMR1mr9Fl2fKh1kOu+rBKwk2UKaxZOdTfeP32iYuQyG
 vpqjlVk+8245L7AmSDXKv3dpb7pTpGa/qY5GNElF+ggw60/QodN15ToWL19U1GsUk2N9
 QODItuWKoDQXNuQ+nvxhzcQJxnazMa2b1+1TlQ1Xk60piGbGRcXskOkeqA2Ysep3tmxq
 xF5HuCDuslwRdKXMQA1NcKB2KYzJSsMGBKQBjmvugFSduD7M6Zl2ZlFrzIVouseF8sum
 J4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=608qNLHC5/4osjXyTeWl015DQW4m7Dc2t3DShU7YJe0=;
 b=thJB0YkkvCB1N3jiAIbiIJAaom9sn9K1hsmQ6g8DtwNoU72aQHZyX2Kh4NXJHuuN5q
 8djeQWQekqhR/3nPVm7ZO7QgNsYP8wrdll2IiQ1s2yvhDDXUTA6j6+bmKpzRbs+d0cGB
 4xbIO5PE7sxqS5LH6negJIXNCL2epPYfA8m2OxSIpobxez4DylX/Xg2IxwBqHLl+slA5
 uv9o4xhkJJ+ysPUOay99Y0zn1mQfsFIp9PsjzqNBpaRONetVR2Xnv3zvMjYxeLi4GYpM
 stDUzUvjJD5shf7C79zrcjYe9/1JXV7hPl5nInPtRvvenb+qB+PRRkFWvHfxGswQwHwI
 B5eQ==
X-Gm-Message-State: AOAM5315O1ysukLTdZ/uN4jup7mP5bwWx4ChGt48lFM1OoxQlLY1W59y
 NZsH5O4ByalqeSZaiEVsJu8Q2ClBQw868pQrVi/QsQ==
X-Google-Smtp-Source: ABdhPJz/N/QhGvrjNkKDJBnq7G6b2eeC8exYaKf58GjxIDjquW/9Kwm9ycvqMLAOa+c6qDW9G/snY9ypTomL5/irUMQ=
X-Received: by 2002:a17:906:413:: with SMTP id
 d19mr7407867eja.523.1597361859855; 
 Thu, 13 Aug 2020 16:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
 <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
In-Reply-To: <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Aug 2020 16:37:28 -0700
Message-ID: <CAPcyv4jfcXJtCQRXLNxhEoQseMyUxgZxhgz5EaEE9sVjFaqHLg@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(),
 use rcu_read_lock()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, Eric Dumazet <edumazet@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, iommu <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
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

On Thu, Aug 13, 2020 at 12:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 12, 2020 at 8:17 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Since commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
> > improved unlock_page(), it has become more noticeable how cow_user_page()
> > in a kernel with CONFIG_DMA_API_DEBUG=y can create and suffer from heavy
> > contention on DMA debug's radix_lock in debug_dma_assert_idle().
>
> Ooh.
>
> Yeah, that's ridiculously expensive, and serializes things for no good reason.
>
> Your patch looks obviously correct to me (Christoph?), but it also
> makes me go "why are we doing this in the first place"?
>
> Because it looks to me like
>  (a) the debug check is wrong
>  (b) this is left-over from early debugging
>
> In particular, I don't see why we couldn't do a COW on a page that is
> under writeback at the same time. We're not changing the page that is
> doing DMA.
>
> In fact, the whole "COW with DMA" makes me feel like the real bug may
> have been due that whole "ambiguous COW" thing, which was fixed in
> 17839856fd58 ("gup: document and work around "COW can break either
> way" issue")
>
> That debug thing goes back almost 7 years, and I don't think it has
> caught anything in those seven years, but I could be wrong.
>
> The commit that adds it does talk about a bug, but that code was
> removed entirely eventually. And google shows no hits for
> debug_dma_assert_idle() since - until your email.
>
> So my gut feel is that we should remove the check entirely, although
> your patch does seem like a big improvement.
>
> Christoph?
>
> (And Dan too, of course, in case he happens to be relaxing in front of
> the computer away from a newborn baby ;)
>

I can at least confirm that it has not caught anything in a long while
except a false positive that needed a fix up.

https://lore.kernel.org/lkml/CAPcyv4hy_nNe8G0o8sMrz9A8HcdRzAuKgXmvdjKusAAA3Fow4g@mail.gmail.com/

Part of me says it's not doing anything worthwhile upstream, but I
wonder if it is keeping some people from submitting patches that play
these page reference shenanigans? I know they're out there. The land
of gup and truncate is where questionable kernel changes go to die.

Outside of that, Hugh's patch looks like a definite improvement so I'd
be inclined to run with that, but rip the whole facility out at the
next sign of a false positive.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
