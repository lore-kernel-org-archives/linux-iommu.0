Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B5C433E1
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 22:23:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1A12075E
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 22:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="niL1Qg0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1A12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8CFAF227F8;
	Tue, 25 Aug 2020 22:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KwFKcofR9I91; Tue, 25 Aug 2020 22:23:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AC98B22622;
	Tue, 25 Aug 2020 22:23:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D79DC016F;
	Tue, 25 Aug 2020 22:23:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C9D5C0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 22:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 75D1187CEE
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 22:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8J8RZKxYp8EU for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 22:23:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
 [209.85.217.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 542F487C63
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 22:23:38 +0000 (UTC)
Received: by mail-vs1-f67.google.com with SMTP id a13so232275vso.12
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ROZvaej7i4MvUNguJxNCsU5mPZczXdg0qLUtT7tzMtY=;
 b=niL1Qg0UelJ7RrXdjiGrDGw1ga0r/nvZoNg0HANhhLMAqFq5G8e1yrpriO8yO7RZZ+
 u+hZ+PG7tm3GCWUuSddvjokyYIg074YXM6mxnd8infxxRXLDI4dPUrv9BcVcLI/oviG5
 QSmznmeKp9VlA53Tqqd8NUOh0KAMmpv43WmkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ROZvaej7i4MvUNguJxNCsU5mPZczXdg0qLUtT7tzMtY=;
 b=bTuG9EgFzkSQYcSFgLYbpmsJKy62eURukUd6RTzIRNh/qxGdpKeJWVRyey8qAdThmD
 ep4MuA1mdEhO7Ds0W2rx2x3FwDBBH8Qepcr4n0I7XBlio9q7WQAaYyYE3a0FTvOHExBO
 VDf54wSFCBc20eAdAOg6RXA3Tvq5vkJGHBhuxoNe7235w4BtC/YS+Ub5KQLmFJppcq3f
 bdh9CISblmCpXXaX35fiVgU3RNG9DwjY8/JsoaKwQa6hc3DgrGhfMeMj5+7l1aKVcHfU
 pBa6w8ftJ/c+wvREgLuqNj2tcLEyAA90E82FnDMHSj+iDxahz9dvZc6Eyz0I4uNKD+jS
 NkBA==
X-Gm-Message-State: AOAM532wYryiwCXTU21x2A+bwpLvhotvLKeWUTJ+kz7sLJCsbe6Vk1dj
 k+r3XIWL4iK1HmoL7mcIRmjacGyH9HeP5Q==
X-Google-Smtp-Source: ABdhPJyn9w1H/XJukP2TjnFUlHbYWHbRorYCZqAiPx9o3fEd3QntDmF4pQfOAuy7IqtEGvRvGScMug==
X-Received: by 2002:a1f:e641:: with SMTP id d62mr7146762vkh.30.1598393723738; 
 Tue, 25 Aug 2020 15:15:23 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com.
 [209.85.221.175])
 by smtp.gmail.com with ESMTPSA id b205sm70627vkf.54.2020.08.25.15.15.22
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 15:15:22 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id s81so109334vkb.3
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 15:15:22 -0700 (PDT)
X-Received: by 2002:a1f:c10b:: with SMTP id r11mr7125248vkf.70.1598393722180; 
 Tue, 25 Aug 2020 15:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=XK3Xa3rRWvuSA_jA+5_1XYBmHEX2B2XSb8h3oOe1PHLw@mail.gmail.com>
 <3df7edd53ebca00be288e69b92b8d4b9@codeaurora.org>
In-Reply-To: <3df7edd53ebca00be288e69b92b8d4b9@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Aug 2020 15:15:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=3Jae7_gXN_05EsmZjrM1bN=TMZ0qoGKz=UaNrthzAg@mail.gmail.com>
Message-ID: <CAD=FV=X=3Jae7_gXN_05EsmZjrM1bN=TMZ0qoGKz=UaNrthzAg@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add support to filter non-strict/lazy mode based
 on device names
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Aug 25, 2020 at 12:01 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi,
>
> On 2020-08-25 21:40, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Aug 25, 2020 at 8:43 AM Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> >>
> >> Currently the non-strict or lazy mode of TLB invalidation can only be
> >> set
> >> for all or no domains. This works well for development platforms where
> >> setting to non-strict/lazy mode is fine for performance reasons but on
> >> production devices, we need a more fine grained control to allow only
> >> certain peripherals to support this mode where we can be sure that it
> >> is
> >> safe. So add support to filter non-strict/lazy mode based on the
> >> device
> >> names that are passed via cmdline parameter "iommu.nonstrict_device".
> >>
> >> Example:
> >> iommu.nonstrict_device="7c4000.sdhci,a600000.dwc3,6048000.etr"

Just curious: are device names like this really guaranteed to be
stable across versions?


> > I have an inherent dislike of jamming things like this onto the
> > command line.  IMHO the command line is the last resort for specifying
> > configuration and generally should be limited to some specialized
> > debug options and cases where the person running the kernel needs to
> > override a config that was set by the person (or company) compiling
> > the kernel.  Specifically, having a long/unwieldy command line makes
> > it harder to use for the case when an end user actually wants to use
> > it to override something.  It's also just another place to look for
> > config.
> >
>
> Good thing about command line parameters are that they are optional,
> they do
> not specify any default behaviour (I mean they are not mandatory to be
> set
> for the system to be functional), so I would like to view it as an
> optional
> config. And this command line parameter (nonstrict_device) is strictly
> optional
> with default being strict already set in the driver.
>
> They can be passed from the bootloader via chosen node for DT platforms
> or choose
> a new *bootconfig* as a way to pass the cmdline but finally it does boil
> down to
> just another config.

Never looked at bootconfig.  Unfortunately it seems to require
initramfs so that pretty much means it's out for my usage.  :(


> I agree with general boolean or single value command line parameters
> being just
> more messy which could just be Kconfigs instead but for multiple value
> parameters
> like these do not fit in Kconfig.
>
> As you might already know, command line also gives an advantage to the
> end user
> to configure system without building kernel, for this specific command
> line its
> very useful because the performance bump is quite noticeable when the
> iommu.strict
> is off. Now for end user who would not be interested in building entire
> kernel(majority)
> and just cares about good speeds or throughput can find this very
> beneficial.
> I am not talking about one specific OS usecase here but more in general
> term.
>
> > The other problem is that this doesn't necessarily scale very well.
> > While it works OK for embedded cases it doesn't work terribly well for
> > distributions.  I know that in an out-of-band thread you indicated
> > that it doesn't break anything that's not already broken (AKA this
> > doesn't fix the distro case but it doesn't make it worse), it would be
> > better to come up with a more universal solution.
> >
>
> Is the universal solution here referring to fix all the command line
> parameters
> in the kernel or this specific command line? Are we going to remove any
> more
> addition to the cmdline ;)

There are very few cases where a kernel command line parameter is the
only way to configure something.  Most of the time it's just there to
override a config.  I wouldn't suggest removing those.  I just don't
want a kernel command line parameter to be the primary way to enable
something.


> So possible other solution is the *bootconfig* which is again just
> another place
> to look for a config. So thing is that this universal solution would
> result in
> just more new fancy ways of passing configs or adding such configs to
> the drivers
> or subsystems in kernel which is pretty much similar to implementing
> policy in
> kernel which I think is frowned upon and mentioned in the other thread.
>
> > Ideally it feels like we should figure out how to tag devices in a
> > generic manner automatically (hardcode at the driver or in the device
> > tree).  I think the out-of-band discussions talked about "external
> > facing" and the like.  We could also, perhaps, tag devices that have
> > "binary blob" firmware if we wanted.  Then we'd have a policy (set by
> > Kconfig, perhaps overridable via commandline) that indicated the
> > strictness level for the various classes of devices.  So policy would
> > be decided by KConfig and/or command line.
> >
>
> How is tagging in driver or device tree better than the simple command
> line
> approach to pass the same list of devices which otherwise you would
> hardcode
> in the corresponding drivers and device tree all over the kernel other
> than
> the scalability part for command line? IMHO it is too much churn.

It's better because it doesn't require keeping track and updating
these per-board (or per machine) arguments for each and every
board/machine you maintain.  If, for instance, we start out by
allowing HW video decoder to use non-strict.  So:

On one board, we add in "aa00000.video-codec" to the command line.
On some other board, maybe we add in "1d00000.video-codec" to the command line.
On some other board, maybe we add in "90400000.video-codec" to the command line.

Now we realize that there's some problem and we have to remove it, so
we need to go through and remove this from our command line
everywhere.  Worse is that we have to proactively notice it and remove
it.

Instead, let's imagine that we set a policy at a bit of a higher
level.  Different ideas:

a) We could have a CONFIG_ option for the video codec that's something
like "CONFIG_VIDEOCODEC_DEFAULT_NONSTRICT".  If this was set then if
there is no "iommu.strict" command line argument then this device
would be mapped as non-strict.  If "iommu.strict=0" or
"iommu.strict=1" is on the command line then it would override all of
these defaults.  Probably the existence (or maybe the default value)
of this CONFIG option implies that there are no known/expected
exploits related to it.

b) We could find some way to tag the video codec and then set
non-strictness on certain classes of devices, then we could have a
policy to disable strictness on certain classes of devices.

The nice thing about the above is that you could imagine someone
pushing a change to the stable trees that would fix everyone affected.
Nobody would need to go around and adjust command line options, they'd
just get the newest stable and it could cause devices to move into
strict mode if there was a known exploit.  I suppose with your
proposal stable trees could have a "blacklist" where the commandline
is ignored for exploited devices, but that seems ugly.


> Device tree could be used but then we have a problem with it being for
> only
> describing hardware and it doesn't work for ACPI based systems.
>
> Command line approach works for all systems (both DT and ACPI) without
> having
> to add too much churn to drivers. Lastly, I think we can have both
> options, it
> doesn't hurt to add command line parameter since it is optional.

I'm not opposed to something existing that lets you override this on
the command line, but I'm just not a fan of it being the primary way.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
