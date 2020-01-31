Return-Path: <SRS0=FJ9b=3U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE34C35240
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF26214D8
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="f51xeAjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF26214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C09A286AE9;
	Fri, 31 Jan 2020 17:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lMAZF6z9lKYJ; Fri, 31 Jan 2020 17:46:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 43D7A86AE6;
	Fri, 31 Jan 2020 17:46:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E7ACC0178;
	Fri, 31 Jan 2020 17:46:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68C88C0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 17:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 544F886C66
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 17:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ju1IPjqQX4X for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 17:46:19 +0000 (UTC)
X-Greylist: delayed 03:03:38 by SQLgrey-1.7.6
Received: from mail-yw1-f66.google.com (mail-yw1-f66.google.com
 [209.85.161.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4851386BB4
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 17:46:19 +0000 (UTC)
Received: by mail-yw1-f66.google.com with SMTP id t141so5495518ywc.11
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 09:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3ITIYxvjdW6ILwWjvX2q5KM4Bzin3GdLXvp+v9lOz74=;
 b=f51xeAjbaVVP2IVpMfik9MTfen2NXpvClIXLVLIYOetotxF5htPYc8GsLV1l/I5hVp
 h0sKKB3M+TCM7FVtW72qf1cOVYbmBmDXaCwnFbym4AaJ/y/70JMvqkhcXASMoYkLRW0/
 JbFS1nKPC1Eqpl/YYUJ4B+onY7flQFuZ97rn+SBEB581DzfbKOF0CrMAsERj15kREJsW
 NIraCl9smResGaW8WxnirUxmCdDw5y3+JNUPlwY5TIuP5MSVCmMtVY7EUeX/N07K4SSF
 RTAIMP713WAlZEP30cl668OM5afd43ncdPfNTOqDv+M96mI+hDI4d432MwZ4ZnEFhLTv
 A8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3ITIYxvjdW6ILwWjvX2q5KM4Bzin3GdLXvp+v9lOz74=;
 b=nT1CpSERFIT/tbcz49QAOHV2FK7nWbuzNnFnXH6QYT9tDikZSfOQYpTLz0UsACnxpF
 8KYqKDl+9nzYiov2yf3/if2ojGoU8vQnuNwnzlys5ZX00pyTauT7vx62drkfEuWZ3lAy
 a7TSYHzLnkzQhd7GI+2P8VQs1Njjvzsq3Bic23RJMdlNqOoKpqHzmicC4bAWbk5VopWP
 Iq9znQypTs18votchdJTVTgZGV6HVCZXjkCPHr2crqnaRNemkV7U5wEKQA8zExqnoI6E
 +4M497DEEJ7XFIZYIb1CjVXbvayy2ET2W0NIAs4vPs/5WbatjAAuNZsC6cjTeiVRg0Y8
 RbPA==
X-Gm-Message-State: APjAAAUwCrq53nhJpHnzBHd1bTe+yTETu8GtMXGGujYlZKMK3FxAqDqb
 3fLIKShxbsmRbh2tMzerVy/WNVVLDTck3LdFdkDROw==
X-Google-Smtp-Source: APXvYqxqvZ9Xc7xE+6WNWw3wmhWcDmQC9NooOnMpVI4gHyQgeHuUh2qykrD9sDt6rtakTAB7lfETi0K2DHa5eBJtjpc=
X-Received: by 2002:a25:d9d4:: with SMTP id q203mr1615912ybg.274.1580492777976; 
 Fri, 31 Jan 2020 09:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20200130191049.190569-1-edumazet@google.com>
 <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
 <CANn89i+fRqeSAz9eH8f2ujzBWSLUXw0eTT=tK=eNj8hL71MiFQ@mail.gmail.com>
 <f870ae85-995f-7866-ebbd-95b89ca28dc5@arm.com>
 <CANn89iKfA+yPHiL4R7-jkewwhDgM6jkwhW5o9H=VL9CnyBikhw@mail.gmail.com>
 <62e1ee46-ad9e-988f-a2a3-8fd217e28f24@arm.com>
In-Reply-To: <62e1ee46-ad9e-988f-a2a3-8fd217e28f24@arm.com>
Date: Fri, 31 Jan 2020 09:46:06 -0800
Message-ID: <CANn89iKmFMiOStfcRdKXe=mks65dhkXPTawqevY8YwyUbfSjhg@mail.gmail.com>
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

On Fri, Jan 31, 2020 at 9:43 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 31/01/2020 2:42 pm, Eric Dumazet wrote:
> > On Fri, Jan 31, 2020 at 4:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> ...and when that represents ~5% of the total system RAM it is a *lot*
> >> less reasonable than even 12KB. As I said, it's great to make a debug
> >> option more efficient such that what it observes is more representative
> >> of the non-debug behaviour, but it mustn't come at the cost of making
> >> the entire option unworkable for other users.
> >>
> >
> > Then I suggest you send a patch to reduce PREALLOC_DMA_DEBUG_ENTRIES
> > because having 65536 preallocated entries consume 4 MB of memory.
>
> ...unless it's overridden on the command-line ;)
>
> > Actually this whole attempt to re-implement slab allocations in this
> > file is suspect.
>
> Again that's a matter of expected usage patterns - typically the
> "reasonable default" or user-defined preallocation should still be
> enough (as it *had* to be before), and the kind of systems that can
> sustain so many live mappings as to regularly hit the dynamic expansion
> path are also likely to have enough memory not to care that later-unused
> entries never get 'properly' freed back to the kernel (plus as you've
> observed, many workloads tend to reach a steady state where entries are
> mostly only transiently free anyway). The reasoning for the exact
> implementation details is there in the commit logs.
>
> > Do not get me wrong, but if you really want to run linux on a 16MB host,
> > I guess you need to add CONFIG_BASE_SMALL all over the places,
> > not only in this kernel/dma/debug.c file.
>
> Right, nobody's suggesting that defconfig should "just work" on your
> router/watch/IoT shoelaces/whatever, I'm just saying that tuning any
> piece of common code for datacenter behemoths, for quality-of-life
> rather than functional necessity, and leaving no way to adjust it other
> than hacking the source, would represent an unnecessary degree of
> short-sightedness that we can and should avoid.
>
> Taking a closer look at the code, it appears fairly straightforward to
> make the hash size variable, and in fact making it self-adjusting
> doesn't seem too big a jump from there. I'm happy to have a go at that
> myself if you like.


Sure, go ahead, I have no plan implementing changes for 20 years old platforms.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
