Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B3AC433E1
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 05:42:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360BC20791
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 05:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360BC20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F167C8879A;
	Fri, 14 Aug 2020 05:42:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nyQLRPtYJT6Y; Fri, 14 Aug 2020 05:42:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C77518876B;
	Fri, 14 Aug 2020 05:42:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9635C07FF;
	Fri, 14 Aug 2020 05:42:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1FABC004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 05:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C7DB28879A
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 05:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQJ7dRiUKpzS for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 05:42:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5DB578876B
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 05:42:48 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 58BF068C7B; Fri, 14 Aug 2020 07:42:42 +0200 (CEST)
Date: Fri, 14 Aug 2020 07:42:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(), use
 rcu_read_lock()
Message-ID: <20200814054241.GA719@lst.de>
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
 <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Hugh Dickins <hughd@google.com>, iommu <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>
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

On Thu, Aug 13, 2020 at 12:02:41PM -0700, Linus Torvalds wrote:
> Yeah, that's ridiculously expensive, and serializes things for no good reason.
> 
> Your patch looks obviously correct to me (Christoph?),

It also looks correct to me.

> but it also
> makes me go "why are we doing this in the first place"?
> 
> Because it looks to me like
>  (a) the debug check is wrong
>  (b) this is left-over from early debugging
> 
> In particular, I don't see why we couldn't do a COW on a page that is
> under writeback at the same time. We're not changing the page that is
> doing DMA.

Yes.  We don't need to check for a DMA to the device, but a DMA from
the device while under DMA obviously is bogus.  But then again you'd
need to try really hard to do that.

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

The whole thing predates my involvement with the code, but I defintively
think the patch from Hugh is a major improvement.  But I would also
have no problem with just removing it entirely.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
