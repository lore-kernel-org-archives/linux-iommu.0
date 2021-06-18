Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8515C48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 22:10:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD15610C7
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 22:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD15610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B87D83D30;
	Fri, 18 Jun 2021 22:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KdfrbyTwYN9Y; Fri, 18 Jun 2021 22:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B708F83B18;
	Fri, 18 Jun 2021 22:10:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70FA2C000D;
	Fri, 18 Jun 2021 22:10:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEB83C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 22:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B66CF83B1F
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 22:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e8b3wsP557Tz for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 22:10:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A90E083B18
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 22:10:03 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id j184so14568744qkd.6
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w4YiW4egPKdJECyPLrd6+VyczjYedyk/bEQ3LwbFh40=;
 b=kmgSmV1OQ5ftiq3+FvkzWjJQjPfeXPWXuZKSvT4MZJG4eugkNddA22USVB2l1Oscfa
 +w0Icj+IBTHRwhBa4kuvqXd97RFLazXj0fzsDSxeymKntKOlLCU+ClW68Gx8OVE4K4TR
 qLvxc2MGZKOKgfdqWSVacIeOAPQn4TwoKY/V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w4YiW4egPKdJECyPLrd6+VyczjYedyk/bEQ3LwbFh40=;
 b=n5Uq97s8X7CFBILkgKHcXBvA3QLqbFDG+zno2lNkQOHfaJkrTZsJPHjZbpQkN21Mgz
 37rC3AASw1xzUI2qt2JrzApXE1Vcok1qYkbjuX5Q27EErWr1Qp28hRB4osAQsqQ28aoA
 3afZ8vUYG/Y2zP00bWXmcvNaD7qTKFOXzORX5gEsp5mE0H0gwOT21lPeO1mH/E9FYtjz
 HFTZJKqsY5pMS7HAG9ZvMUSDbv1AJ7spEKtLrmXoDzsdGwHnziE2k6Ri3cJUCqsclM+k
 jjs9ISnyGLn5KK2zkywN/G+atdzE+b0nmnCxb8vTMpgaKm6t5n+42rZHB1M6R3dxTR0a
 mG0w==
X-Gm-Message-State: AOAM5321DdpWuBPpedYJYSJREIzpZEtCyV2Rlo8cN5wxj/+VdSERtSMf
 TkpNl+32JeGjbA7H3yKkcZlTVLAzhzukSw==
X-Google-Smtp-Source: ABdhPJywtrAKgMZr0emROkIZc1ghcYVAuESFPQiCgcmKrfX0gFhfkio404gQxhuGBozF9al1ARwsOw==
X-Received: by 2002:a37:485:: with SMTP id 127mr11406687qke.277.1624054201850; 
 Fri, 18 Jun 2021 15:10:01 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com.
 [209.85.222.176])
 by smtp.gmail.com with ESMTPSA id h7sm4449575qko.81.2021.06.18.15.10.00
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jun 2021 15:10:00 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id w21so809486qkb.9
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 15:10:00 -0700 (PDT)
X-Received: by 2002:a25:bcb:: with SMTP id 194mr17381339ybl.32.1624054200300; 
 Fri, 18 Jun 2021 15:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623981933.git.saiprakash.ranjan@codeaurora.org>
 <150fc7ab1c7f9b70a95dae1f4bc3b9018c0f9e04.1623981933.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <150fc7ab1c7f9b70a95dae1f4bc3b9018c0f9e04.1623981933.git.saiprakash.ranjan@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jun 2021 15:09:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WA_mBnxv-D3YOYUkDAAcYgktFgnw2zeTkMneqFxBg=yg@mail.gmail.com>
Message-ID: <CAD=FV=WA_mBnxv-D3YOYUkDAAcYgktFgnw2zeTkMneqFxBg=yg@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] iommu/io-pgtable: Optimize partial walk flush for
 large scatter-gather list
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi,

On Thu, Jun 17, 2021 at 7:51 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Currently for iommu_unmap() of large scatter-gather list with page size
> elements, the majority of time is spent in flushing of partial walks in
> __arm_lpae_unmap() which is a VA based TLB invalidation invalidating
> page-by-page on iommus like arm-smmu-v2 (TLBIVA) which do not support
> range based invalidations like on arm-smmu-v3.2.
>
> For example: to unmap a 32MB scatter-gather list with page size elements
> (8192 entries), there are 16->2MB buffer unmaps based on the pgsize (2MB
> for 4K granule) and each of 2MB will further result in 512 TLBIVAs (2MB/4K)
> resulting in a total of 8192 TLBIVAs (512*16) for 16->2MB causing a huge
> overhead.
>
> So instead use tlb_flush_all() callback (TLBIALL/TLBIASID) to invalidate
> the entire context for partial walk flush on select few platforms where
> cost of over-invalidation is less than unmap latency

It would probably be worth punching this description up a little bit.
Elsewhere you said in more detail why this over-invalidation is less
of a big deal for the Qualcomm SMMU. It's probably worth saying
something like that here, too. Like this bit paraphrased from your
other email:

On qcom impl, we have several performance improvements for TLB cache
invalidations in HW like wait-for-safe (for realtime clients such as
camera and display) and few others to allow for cache lookups/updates
when TLBI is in progress for the same context bank.


> using the newly
> introduced quirk IO_PGTABLE_QUIRK_TLB_INV_ALL. We also do this for
> non-strict mode given its all about over-invalidation saving time on
> individual unmaps and non-deterministic generally.

As per usual I'm mostly clueless, but I don't quite understand why you
want this new behavior for non-strict mode. To me it almost seems like
the opposite? Specifically, non-strict mode is already outside the
critical path today and so there's no need to optimize it. I'm
probably not explaining myself clearly, but I guess i'm thinking:

a) today for strict, unmap is in the critical path and it's important
to get it out of there. Getting it out of the critical path is so
important that we're willing to over-invalidate to speed up the
critical path.

b) today for non-strict, unmap is not in the critical path.

So I would almost expect your patch to _disable_ your new feature for
non-strict mappings, not auto-enable your new feature for non-strict
mappings.

If I'm babbling, feel free to ignore. ;-) Looking back, I guess Robin
was the one that suggested the behavior you're implementing, so it's
more likely he's right than I am. ;-)


-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
