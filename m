Return-Path: <SRS0=+HXC=BZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E19C433E1
	for <iommu@archiver.kernel.org>; Sat, 15 Aug 2020 00:59:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB7522E03
	for <iommu@archiver.kernel.org>; Sat, 15 Aug 2020 00:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GViAih0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB7522E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8772686FD5;
	Sat, 15 Aug 2020 00:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A1SS_yBkHhSS; Sat, 15 Aug 2020 00:59:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF80A85641;
	Sat, 15 Aug 2020 00:59:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF588C013C;
	Sat, 15 Aug 2020 00:59:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A233C004D
 for <iommu@lists.linux-foundation.org>; Sat, 15 Aug 2020 00:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1F09988793
 for <iommu@lists.linux-foundation.org>; Sat, 15 Aug 2020 00:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6qB0vX3eQmZK for <iommu@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 00:59:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1A3ED886CD
 for <iommu@lists.linux-foundation.org>; Sat, 15 Aug 2020 00:59:25 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id m22so11729263ljj.5
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 17:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x5V/+PBSBblwToTAxIaWCU/QUA1O6ispz0B5966qT9o=;
 b=GViAih0/p9oLbkxsH0zRUETk2BWc6utJvJ2zieuBFpItMZ5Q/d+XoOIJE3UmtmDW9d
 PfB7oAxIVJBUbDF/z38G7nHCI1AuDI/Wa5eZncLuwEofl1Tgh5gbUZms7q6RUinORQm5
 atVm6Nom3LD276TzkMMR7WITDnfy6UtyUb83E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x5V/+PBSBblwToTAxIaWCU/QUA1O6ispz0B5966qT9o=;
 b=lWHY1QCR7S+2IxFXok/OQXZ0z6dSoLfyj3OXjx2Hq8H8d+JRw73XrJhrftJQTESFD6
 N41Q09HoD4aDxN8FykVOqSmBrUo1wUW61jiYR0WBGwnYutHIO7SyQ9G/AN10/7qqTyN0
 Q3AeyFiuM5PiAFY032V+fB4KWzSMka4cFbBSn325M7GArmir70H3JFB3g+qQzJbPGR5W
 hs9SpstrlZbwe8hzknjrGag8H2E7Vg7+5af/QbgUOsrxeZ1HQ184p96f85w1qP9VbCqN
 LDfdT6dZFqoUJ67S+2g58k0jqE5pkBL7lvfHptzilEkj0fONbFhj5G7XEyyc+O38b63M
 QvnA==
X-Gm-Message-State: AOAM531OA1vbdToJjryrd3cA9aM2tzGxMLx+gQGAaO5wDP2i3jeYechP
 vvZ4LnkhNip32AVRVp9iM1eq0otKnNOOzKgf
X-Google-Smtp-Source: ABdhPJzkwMQ2kb690u5x91hyYa4slGxLa6HhfA1j55YkClVwj8I8jA3I7iWWfQclpAmonpOoE7QbiA==
X-Received: by 2002:a2e:5018:: with SMTP id e24mr2634168ljb.261.1597453162359; 
 Fri, 14 Aug 2020 17:59:22 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49])
 by smtp.gmail.com with ESMTPSA id t27sm2051093ljd.101.2020.08.14.17.59.21
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 17:59:21 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m15so5690845lfp.7
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 17:59:21 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id
 v23mr2382329lfp.10.1597453160630; 
 Fri, 14 Aug 2020 17:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
 <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
 <20200814054241.GA719@lst.de>
 <CAHk-=wifNX6U28sjPay+1ZJ5BmxRG8Bac7W1sP_Ft1yTqLj+GA@mail.gmail.com>
 <alpine.LSU.2.11.2008141642260.18762@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008141642260.18762@eggly.anvils>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Aug 2020 17:59:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw3QcceKCdYS2ktCPQ96m8Ysyek+w4ny0ygvy7z-_2rw@mail.gmail.com>
Message-ID: <CAHk-=whw3QcceKCdYS2ktCPQ96m8Ysyek+w4ny0ygvy7z-_2rw@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(),
 use rcu_read_lock()
To: Hugh Dickins <hughd@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>,
 Linux-MM <linux-mm@kvack.org>, iommu <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Aug 14, 2020 at 5:26 PM Hugh Dickins <hughd@google.com> wrote:
>
> We used to rely on page count there, and on trylock_page() only; but
> there was at least one user whose app went wrong when occasionally we
> COWed the page, just because something else momentarily took a reference
> to it, or locked it.  Around 2006, bug report from 2004: I did look up
> the history a week ago, but was interrupted before taking notes.

I actually think you may be talking about the exact problem that that
debug patch from Dan was originally created for:

  0abdd7a81b7e dma-debug: introduce debug_dma_assert_idle()
  77873803363c net_dma: mark broken

and your memory sounds exactly like that net_dma case (and the timing
matches roughly too - the NET_DMA code was merged in 2006, but I think
people had been playing trial games with it before that).

IOW, net_dma was horribly broken, and just couldn't deal with COW
because it did things wrong.

The thing is, doing extra COW's really shouldn't matter in _any_
half-way correct situation. There's a few cases:

 - user space writing to it, so we COW.

   This is the "simple" case that is obvious and we've always done the
same thing. User space will get the new copy, and there's no possible
situation when that can be wrong.

 - get_user_pages() for reading.

   This is the one we actually used to get wrong, and when another
user *didn't* cow, the data that was read might not match what the
original get_uiser_pages() case expected.

    But in this case, the bug only happened when we didn't cow
aggressively enough.

 - get_user_pages() for writing

   This is another 'simple" case, because it does the COW at
get_user_pages() time and gets it's own copy (which is also installed
in the thread that does the GUP, of course, so a subsequent fork an
danother write can obviously cause *further* COW action).

But in no case should an extra COW matter. Except if somebody uses
get_user_pages() to write to the page, and the COW "hides" that write
by giving a new copy to whoever expected to see it, but that's exactly
the case that Dan's patch was supposed to notice.

And since it never triggered outside of that invalid net_dma case, I
don't think any other case really ever existed.

Yes, I can well imagine that some people loved the concept of that TCP
receive copy offload, but it really was broken, and was removed
entirely by Dan in commit 7bced397510a ("net_dma: simple removal") a
year after being marked broken (the author date makes it look like
it's just a couple of weeks after being marked broken, but the commit
date for that removal is September 2014).

So I don't think that the trylock and checking page counts is a
correctness issue.

It had better not be, because anybody that writes to a shared-cow page
 without breaking COW is simply broken.

No, I really think that the real worry about doing more aggressive
copying is that it doesn't steal back the KSM page or the swap cache
page, so it will leave those pages around, and while they should then
be really easy for the VM to reclaim, I really worry that we have a
couple of decades of VM reclaim tuning with that swap cache reuse
behavior (KSM, not so much).

And while it works fine on my machine, I currently have 40GB or RAM
free, because honestly, the stuff I do doesn't need all that much
memory, and I ridiculously overspecced my new machine RAM'wise. So
nothing I will do would show any problems.

                Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
