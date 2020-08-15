Return-Path: <SRS0=+HXC=BZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C61C433E3
	for <iommu@archiver.kernel.org>; Sat, 15 Aug 2020 00:26:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443DC2074D
	for <iommu@archiver.kernel.org>; Sat, 15 Aug 2020 00:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tixNdcgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443DC2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D84A887BE;
	Sat, 15 Aug 2020 00:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nf0YUi1gjnDX; Sat, 15 Aug 2020 00:26:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 643DC887B0;
	Sat, 15 Aug 2020 00:26:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48A20C013C;
	Sat, 15 Aug 2020 00:26:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48696C004D
 for <iommu@lists.linux-foundation.org>; Sat, 15 Aug 2020 00:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 30BDC86EC7
 for <iommu@lists.linux-foundation.org>; Sat, 15 Aug 2020 00:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tLsW0ccyxAld for <iommu@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 00:26:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6E28286EBA
 for <iommu@lists.linux-foundation.org>; Sat, 15 Aug 2020 00:26:53 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id x24so8990822otp.3
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 17:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=56XdHRbo9k+Mqiix3oE2+ajX+BG6DMvqPZZGvyF8s0g=;
 b=tixNdcgK+4b42rbbV1u0RJNtmfxWXYFPXMmEtuiTZoiPVRNhfK63NLNQNItaKKt0qU
 irDv56YmHRUkovanDxgxt9TpyrJ5gDu0dGMI4NpuLAkysQ9jaeJYN5e/oeWpzpU6TWjZ
 4hwkVXbKR07KaB16uuzIspvIAimunf7B1eBOfHICpX2UFs+cKR1A3pcch50aSd8d4ucU
 obkFk/4BOnRLaQUep841rCZ/dsBjIAazO49rnZoxnVe26X/NHcdVXAB2hBJ/dD9ZrNSV
 7gL2TYIZpzckSVxb3pGJiNhJJpRLTgukoByesVlSN4fV8ZctLVz2Ymz2dLqufO5Q/MAx
 Qeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=56XdHRbo9k+Mqiix3oE2+ajX+BG6DMvqPZZGvyF8s0g=;
 b=nrhkRGRxkJ4cIrlve+/Fo8kGVAphJsaMtPWKuI0I1b2ec2aZPKNvY3+DnEQ/y4LN4n
 +ZFhN14osrUuQsHeAXI3JWazn0JqlKy9ssr2V2bU/rRDRSXuisYHTfifkhbgrIqW2eKa
 K08KClSRz+T/UzHGI55fyFl+KJV3fxDkig5H6wkXZoR2W/jA1GlOP4LiQboXbdj3TU3f
 xlOHC4abTCta9tgtMyNtw8uNMZTvxHGHO3E84ybky3gOpRtcRYhs+O3OvLfAytCzcRS2
 tRNHQTO3Ay4EyVewnLh7HI71grr4KvwTNYx2uVV2b+77uiUpAP8as9Yh0s1Lf/9/u2xw
 lQdQ==
X-Gm-Message-State: AOAM532qIiUQtA3loCvrSxbEFjSPs99xi8GbFXRGR+nOPUUSTfTPqfsI
 mRCqjrlcROLU8Uby/D/isWY3XQ==
X-Google-Smtp-Source: ABdhPJz1ULd9mf33Zk0GkTOi/uDvlRsoh0xCiJzx5JrH5jIYaNNXpeR1yTqNoUjKIOV3Iujqr8p++A==
X-Received: by 2002:a05:6830:11:: with SMTP id
 c17mr3709955otp.287.1597451212070; 
 Fri, 14 Aug 2020 17:26:52 -0700 (PDT)
Received: from eggly.attlocal.net
 (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
 by smtp.gmail.com with ESMTPSA id z17sm1982367oop.15.2020.08.14.17.26.50
 (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
 Fri, 14 Aug 2020 17:26:50 -0700 (PDT)
Date: Fri, 14 Aug 2020 17:26:28 -0700 (PDT)
X-X-Sender: hugh@eggly.anvils
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(), use
 rcu_read_lock()
In-Reply-To: <CAHk-=wifNX6U28sjPay+1ZJ5BmxRG8Bac7W1sP_Ft1yTqLj+GA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2008141642260.18762@eggly.anvils>
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
 <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
 <20200814054241.GA719@lst.de>
 <CAHk-=wifNX6U28sjPay+1ZJ5BmxRG8Bac7W1sP_Ft1yTqLj+GA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
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
From: Hugh Dickins via iommu <iommu@lists.linux-foundation.org>
Reply-To: Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 14 Aug 2020, Linus Torvalds wrote:
> On Thu, Aug 13, 2020 at 10:42 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The whole thing predates my involvement with the code, but I defintively
> > think the patch from Hugh is a major improvement.  But I would also
> > have no problem with just removing it entirely.
> 
> I decided to just do both, since neither you nor Dan seemed to really object.
> 
> I applied Hugh's RCU read locking patch as a clear improvement, and
> then I did a second patch that just removed this function entirely.
> That sounds a bit odd, perhaps, but in case people decide to resurrect
> the debugging code, I didn't want us to lose sight of Hugh's
> improvement just because I then decided that we might as well go one
> step further and just remove it entirely.

That's ideal, thanks - exactly the sequence I was hoping for.

(Another shortcoming in debug_dma_assert_idle(), that I hadn't wanted
to distract us by mentioning, is that it assumed that the mapping is
contained within one small page, whereas I believe one or more of the
DMA mapping functions take a size_t argument, that could in theory span
small pages - I guess more plausible inside a compound page; yet it
looked like only an initial entry would be put into the radix-tree.)

> 
> And the only real reason I care is that this whole COW and page lock
> thing has showed up lately, and I like removing code.
> 
> I'm _very_ tempted to just apply my COW simplification patch that gets
> rid of all the complex try-to-share cases entirely (and would also
> obviate the whole forced-cow patch). I suspect it would effectively
> remove almost all of the [un[lock_page() bottlenecks entirely, but
> that code has decades of history and I suspect it's a bit too drastic
> wrt KSM and the swap cache pages.

Yes, you're right to hold back.

I'd been looking there too (but backed off while speeding up the
fork was causing the "Hugh load" to "fail": it's the exit that now
wants speeding up, to please that test).  I think it could well avoid
getting into page locking when mapcount is quickly seen to be high
(> 1? > 2? > bigger? I never did the logic), but the page locking
becomes important when mapcount looks low, yet swap might be involved.

We used to rely on page count there, and on trylock_page() only; but
there was at least one user whose app went wrong when occasionally we
COWed the page, just because something else momentarily took a reference
to it, or locked it.  Around 2006, bug report from 2004: I did look up
the history a week ago, but was interrupted before taking notes.

> 
> It would be lovely if the main source of page locking would really be
> about just IO, but the page lock has also become the thing that
> serializes almost everything related to page state. Which is why you
> find it in contexts that are really not IO-related at all (not just
> COW - page migration is the other one that has shown up a lot under
> "heavy CPU loads" without really necessarily any IO component to it).
> 
>                          Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
