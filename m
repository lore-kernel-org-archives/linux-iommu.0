Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AD9C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 15:07:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0D92078A
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 15:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ikiywTJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0D92078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 866A086AFE;
	Wed, 26 Aug 2020 15:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hlTypl1f1okG; Wed, 26 Aug 2020 15:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9440586AB6;
	Wed, 26 Aug 2020 15:07:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A07BC07FF;
	Wed, 26 Aug 2020 15:07:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63C2DC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 15:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 525A487C11
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 15:07:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HzGGdtfBhyDY for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 15:07:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
 [209.85.222.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7A92D87BFF
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 15:07:46 +0000 (UTC)
Received: by mail-ua1-f68.google.com with SMTP id g11so663950ual.2
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 08:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uCHfqt376JxFgHX9UXwwv2S+UaAdW2ySAIyzZLYkbq8=;
 b=ikiywTJw5XY4hdhfD8BEmtd4hfBBE1CdYMlFhd5fcS4hFo2MVh9XW1+LCdTG5TpE/6
 V4M+Zbb/jdM9ajawXCXmdVa4tey3tcm70KX3uWKYYrVqgSgfLfadNjcSo2pQPYCfTffR
 kjT6ROxXMbcTK8veOuw7mDMspOCnoVuGMQNw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uCHfqt376JxFgHX9UXwwv2S+UaAdW2ySAIyzZLYkbq8=;
 b=ZlY6cfYYaRfphTMk/Q0eeBeQatabOA0JnzHdYUv+N9VpQ/LGFMnr8hs5glbrMskwwd
 zN6aeEAP3lcMfabT9UEcJevBCA1UzhGtXAa5IY9zfo0Btox97inhQ7h6noZYqK3U66pk
 JXoRPqZBY7FrfiiKtSPjmjiZsThRrKpOtobv1kQGrba8nonu+LXDOlBRNmOfkGz2JbtU
 Mfmp6BY9hPsSmIFAXDEjf7ub5xmu/jRZjTA79N06RA1WvMv2nQJJ1w3/qTPNiYLJPwJJ
 yaWghy9h2Vljd606b5AV/E0SGAkJb7T8qJRIWI+ZOlb8uHLXfkvFfr3IG7dQwIxdUDRt
 EkaA==
X-Gm-Message-State: AOAM530XSvqRp7oCLE/3le9+y2WQenLZV5Lh1glUEuGUksaa5OGPfOme
 VCoeFJ79+HtD9gLc01ckJwPOtLGuLyuufw==
X-Google-Smtp-Source: ABdhPJw1veZjeW2PM/dP+ZHCHbS8rRhLF5mbpwCP3eq7MBAFPqinJvB7GzQgCklLKpP3UHeFgcTuzg==
X-Received: by 2002:ab0:6943:: with SMTP id c3mr5146756uas.44.1598454464961;
 Wed, 26 Aug 2020 08:07:44 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com.
 [209.85.221.182])
 by smtp.gmail.com with ESMTPSA id h8sm274290uab.13.2020.08.26.08.07.44
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 08:07:44 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id o2so493237vke.13
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 08:07:44 -0700 (PDT)
X-Received: by 2002:a1f:c10b:: with SMTP id r11mr9195774vkf.70.1598454463470; 
 Wed, 26 Aug 2020 08:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
 <e3e4da33-a44f-0a07-9e2e-0f806875ab0b@arm.com>
 <d9b1f1b614057d87279c26e13cbbb1f5@codeaurora.org>
 <a03ce8f0-cab5-2782-ac50-930cf94b7dcd@arm.com>
 <f8ac8f57bcf10b2218b4795197efb854@codeaurora.org>
In-Reply-To: <f8ac8f57bcf10b2218b4795197efb854@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 26 Aug 2020 08:07:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFC4ciHanaPe_=9Rb75Sz3Lzosd15ehuovZiNPOtbgYQ@mail.gmail.com>
Message-ID: <CAD=FV=UFC4ciHanaPe_=9Rb75Sz3Lzosd15ehuovZiNPOtbgYQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add support to filter non-strict/lazy mode based
 on device names
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <will@kernel.org>,
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

On Wed, Aug 26, 2020 at 8:01 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> On 2020-08-26 19:21, Robin Murphy wrote:
> > On 2020-08-26 13:17, Sai Prakash Ranjan wrote:
> >> On 2020-08-26 17:07, Robin Murphy wrote:
> >>> On 2020-08-25 16:42, Sai Prakash Ranjan wrote:
> >>>> Currently the non-strict or lazy mode of TLB invalidation can only
> >>>> be set
> >>>> for all or no domains. This works well for development platforms
> >>>> where
> >>>> setting to non-strict/lazy mode is fine for performance reasons but
> >>>> on
> >>>> production devices, we need a more fine grained control to allow
> >>>> only
> >>>> certain peripherals to support this mode where we can be sure that
> >>>> it is
> >>>> safe. So add support to filter non-strict/lazy mode based on the
> >>>> device
> >>>> names that are passed via cmdline parameter
> >>>> "iommu.nonstrict_device".
> >>>
> >>> There seems to be considerable overlap here with both the existing
> >>> patches for per-device default domain control [1], and the broader
> >>> ongoing development on how to define, evaluate and handle "trusted"
> >>> vs. "untrusted" devices (e.g. [2],[3]). I'd rather see work done to
> >>> make sure those integrate properly together and work well for
> >>> everyone's purposes, than add more disjoint mechanisms that only
> >>> address small pieces of the overall issue.
> >>>
> >>> Robin.
> >>>
> >>> [1]
> >>> https://lore.kernel.org/linux-iommu/20200824051726.7xaJRTTszJuzdFWGJ8YNsshCtfNR0BNeMrlILAyqt_0@z/
> >>> [2]
> >>> https://lore.kernel.org/linux-iommu/20200630044943.3425049-1-rajatja@google.com/
> >>> [3]
> >>> https://lore.kernel.org/linux-iommu/20200626002710.110200-2-rajatja@google.com/
> >>
> >> Thanks for the links, [1] definitely sounds interesting, I was under
> >> the impression
> >> that changing such via sysfs is late, but seems like other Sai has got
> >> it working
> >> for the default domain type. So we can extend that and add a strict
> >> attribute as well,
> >> we should be definitely OK with system booting with default strict
> >> mode for all
> >> peripherals as long as we have an option to change that later, Doug?
> >
> > Right, IIRC there was initially a proposal of a command line option
> > there too, and it faced the same criticism around not being very
> > generic or scalable. I believe sysfs works as a reasonable compromise
> > since in many cases it can be tweaked relatively early from an initrd,
> > and non-essential devices can effectively be switched at any time by
> > removing and reprobing their driver.
> >
>
> Ah I see, so the catch is that device must not be bound to the driver
> and won't work for the internal devices or builtin drivers probed early.

Hrm, that wouldn't work so well for us for eMMC.  I don't think I'm
going to manage to convince folks that we need an initrd just for
this.  I'm probably being naive and I haven't looked at the code, but
it does seem a little weird that this isn't the kind of thing that
could just be tweaked for transfers going forward...


> > As for a general approach for internal devices where you do believe
> > the hardware is honest but don't necessarily trust whatever firmware
> > it happens to be running, I'm pretty sure that's come up already, but
> > I'll be sure to mention it at Rajat's imminent LPC talk if nobody else
> > does.

I'll at least attend.  We'll see how useful my contributions are
since, as per usual, I'm wandering into an area I'm not an expert in
here.  ;-)

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
