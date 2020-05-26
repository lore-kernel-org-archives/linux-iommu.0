Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B7DC433E0
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 20:35:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2440208A7
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 20:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqBfuJzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2440208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9569E869E3;
	Tue, 26 May 2020 20:35:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AjZfaDNc8fk6; Tue, 26 May 2020 20:35:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0113B8698F;
	Tue, 26 May 2020 20:34:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3A6EC0888;
	Tue, 26 May 2020 20:34:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B753C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 20:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 18F14885DE
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 20:34:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aZJ3ldGUN3HE for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 20:34:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 48CB2885DB
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 20:34:57 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id o13so17457650otl.5
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xlg1WEt/1KpzYv+/vA9j7Mf3YWi1IPnXCFcohcpUSKM=;
 b=vqBfuJzMnCts3H+g3tzxBLb3DHdb9u8YAPd1Lr4hpr9zPYnd/hQ9htQE4e+QzEUmjl
 7ZrK+oEdm0wLIE7MuIMmiI71OhNKS8oqoG5svb2EehG6CFlmnhdeq9cw6Vf2tq/axJ2H
 ssZdHqJcXZVSLkR/cPGAeFiJSasA4lSnrLDZRpKXHynba/SmCOYCvHWd2hPTm3NCdn4r
 BNzmOO0gWoq0pD+6uFTBvcgyL6jgx7zvs2rGaMsCKa11K7bwAsrXJaOHz3GnLa3znOG5
 YZJKlEQz0ZUmv6xTUjr2n7E5cvEvNuf9zyblA43KWchCM+klzpd5j7n4bXULce1BXFzm
 8BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xlg1WEt/1KpzYv+/vA9j7Mf3YWi1IPnXCFcohcpUSKM=;
 b=WI7qsDne9xawCMSX50T7ikSE9mFKl/PFSc+T5m0binOmoYPFY+BSy0xv+8rQPBK0GR
 xl5VCA7HVlVOiiNSUZJf23CgtgAtePyMNVb1GCms2b3dbdtsUbfqChCAmjtGp1OHedcC
 vAKiDsTrAc4F3+M/fy2FQB1TZ3iJ0bYXfdrmt8o4MYXRxDalHpJBPZof+ZJ22/uK8CKQ
 vNeQPxHftmzE2u5+4tMWH7TcrzHF2itImdR8dgfxObdyMzQhZuDYrUx/cuz6c9m65FoV
 4iSlYZk0V2r2xVt8l/D1mxjMhkaCkriGT/rltC4CC/nalutSex9YwqZu7qt4b5IN30dx
 G+1A==
X-Gm-Message-State: AOAM532DA63FsgoZVIwL9HoZ3RG2H/UbDyuCItS96x9dlmGIfx3me4UW
 MXNbDnV0ltZ//akHjJSaQoABVkY3fmJ9RQrtAceIXg==
X-Google-Smtp-Source: ABdhPJwRnLRczAXOAB9YCm7o1K0N3H8lb7+2jzEf7cyls1IaN/ZEhrkFXvBSwAYhJHpTTYYnVbUBS2F8yL7vvHUmhEs=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr2072353oth.221.1590525296383;
 Tue, 26 May 2020 13:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200228025700.GA856087@builder> <20200514193249.GE279327@builder.lan>
In-Reply-To: <20200514193249.GE279327@builder.lan>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 26 May 2020 13:34:45 -0700
Message-ID: <CALAqxLVmomdKJCwh=e-PX+8-seDX0RXA81FzmG4sEyJmbXBh9A@mail.gmail.com>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Thu, May 14, 2020 at 12:34 PM <bjorn.andersson@linaro.org> wrote:
>
> On Thu 27 Feb 18:57 PST 2020, Bjorn Andersson wrote:
>
> Rob, Will, we're reaching the point where upstream has enough
> functionality that this is becoming a critical issue for us.
>
> E.g. Lenovo Yoga C630 is lacking this and a single dts patch to boot
> mainline with display, GPU, WiFi and audio working and the story is
> similar on several devboards.
>
> As previously described, the only thing I want is the stream mapping
> related to the display controller in place, either with the CB with
> translation disabled or possibly with a way to specify the framebuffer
> region (although this turns out to mess things up in the display
> driver...)
>
> I did pick this up again recently and concluded that by omitting the
> streams for the USB controllers causes an instability issue seen on one
> of the controller to disappear. So I would prefer if we somehow could
> have a mechanism to only pick the display streams and the context
> allocation for this.
>
>
> Can you please share some pointers/insights/wishes for how we can
> conclude on this subject?

Ping? I just wanted to follow up on this discussion as this small
series is crucial for booting mainline on the Dragonboard 845c
devboard. It would be really valuable to be able to get some solution
upstream so we can test mainline w/o adding additional patches.

The rest of the db845c series has been moving forward smoothly, but
this set seems to be very stuck with no visible progress since Dec.

Are there any pointers for what folks would prefer to see?

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
