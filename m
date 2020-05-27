Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A42C433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 11:03:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C33208B8
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 11:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbfNZeW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C33208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 560E987DF2;
	Wed, 27 May 2020 11:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lI0pXG+2pkCo; Wed, 27 May 2020 11:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3E98987DEB;
	Wed, 27 May 2020 11:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10670C0881;
	Wed, 27 May 2020 11:03:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29682C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0163A204A2
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lxEv-HygJ495 for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 11:03:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 87E8E2042A
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:03:49 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B215620888;
 Wed, 27 May 2020 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590577429;
 bh=/5q5E35lU26NZlVnSFPENEc5BsWu8IjTiBALwIZ+uzs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NbfNZeW+B0WTiDGlfacsC6E9Wr035a/Lzp1aENZVzeT/hupGv9jVz+/Z5dhwCjfuC
 ch5GYgNGK1XTPaZR4oZfyz+rAlw8WVBuD+1QzCKSDYyxp5PcxeEJcrGjF04zxdzFnj
 lR1wIthcC/zwvgE5kOC9uxpFWZYTs0A7lQAEEQW4=
Date: Wed, 27 May 2020 12:03:44 +0100
From: Will Deacon <will@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200527110343.GD11111@willie-the-truck>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200228025700.GA856087@builder>
 <20200514193249.GE279327@builder.lan>
 <CALAqxLVmomdKJCwh=e-PX+8-seDX0RXA81FzmG4sEyJmbXBh9A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALAqxLVmomdKJCwh=e-PX+8-seDX0RXA81FzmG4sEyJmbXBh9A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
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

Hi John, Bjorn,

On Tue, May 26, 2020 at 01:34:45PM -0700, John Stultz wrote:
> On Thu, May 14, 2020 at 12:34 PM <bjorn.andersson@linaro.org> wrote:
> >
> > On Thu 27 Feb 18:57 PST 2020, Bjorn Andersson wrote:
> >
> > Rob, Will, we're reaching the point where upstream has enough
> > functionality that this is becoming a critical issue for us.
> >
> > E.g. Lenovo Yoga C630 is lacking this and a single dts patch to boot
> > mainline with display, GPU, WiFi and audio working and the story is
> > similar on several devboards.
> >
> > As previously described, the only thing I want is the stream mapping
> > related to the display controller in place, either with the CB with
> > translation disabled or possibly with a way to specify the framebuffer
> > region (although this turns out to mess things up in the display
> > driver...)
> >
> > I did pick this up again recently and concluded that by omitting the
> > streams for the USB controllers causes an instability issue seen on one
> > of the controller to disappear. So I would prefer if we somehow could
> > have a mechanism to only pick the display streams and the context
> > allocation for this.
> >
> >
> > Can you please share some pointers/insights/wishes for how we can
> > conclude on this subject?
> 
> Ping? I just wanted to follow up on this discussion as this small
> series is crucial for booting mainline on the Dragonboard 845c
> devboard. It would be really valuable to be able to get some solution
> upstream so we can test mainline w/o adding additional patches.

Sorry, it's been insanely busy recently and I haven't had a chance to think
about this on top of everything else. We're also carrying a hack in Android
for you :)

> The rest of the db845c series has been moving forward smoothly, but
> this set seems to be very stuck with no visible progress since Dec.
> 
> Are there any pointers for what folks would prefer to see?

I've had a chat with Robin about this. Originally, I was hoping that
people would all work together towards an idyllic future where firmware
would be able to describe arbitrary pre-existing mappings for devices,
irrespective of the IOMMU through which they master and Linux could
inherit this configuration. However, that hasn't materialised (there was
supposed to be an IORT update, but I don't know what happened to that)
and, in actual fact, the problem that you have on db845 is /far/ more
restricted than the general problem.

Could you please try hacking something along the following lines and see
how you get on? You may need my for-joerg/arm-smmu/updates branch for
all the pieces:

  1. Use the ->cfg_probe() callback to reserve the SMR/S2CRs you need
     "pinning" and configure for bypass.

  2. Use the ->def_domain_type() callback to return IOMMU_DOMAIN_IDENTITY
     for the display controller

I /think/ that's sufficient, but note that it differs from the current
approach because we don't end up reserving a CB -- bypass is configured
in the S2CR instead. Some invalidation might therefore be needed in
->cfg_probe() after unhooking the CB.

Thanks, and please yell if you run into problems with this approach.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
