Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095DFC433E4
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 00:24:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DB62075E
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 00:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f20JUufv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DB62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A59FE86388;
	Wed, 26 Aug 2020 00:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-WJ1fPgjzsr; Wed, 26 Aug 2020 00:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DDDF9861E7;
	Wed, 26 Aug 2020 00:24:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2CEFC016F;
	Wed, 26 Aug 2020 00:24:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBE49C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 00:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DA4E28574A
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 00:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S30XQO4YVPkV for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 00:24:39 +0000 (UTC)
X-Greylist: delayed 02:09:14 by SQLgrey-1.7.6
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com
 [209.85.221.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6A3DD85701
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 00:24:39 +0000 (UTC)
Received: by mail-vk1-f195.google.com with SMTP id 186so40268vkx.4
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LKNYZxdd9GnzF09d9hnsszm0hfjYWuDgd4/PlOEGld8=;
 b=f20JUufvss7xZL/HrjKmsqIQ5mWiEbA4xg5ZmZzrqMVH5q/i+AUHRaJOwlrs3zIU71
 zulan3xrqqX8mQS8GSGYsutdfDf1SRCSRvmcfE+20/9POjON2tF2SG9k0QZ+ponsIO25
 o1PHju9rH05o/4XewhDwdlfjBvY5fZC6yoroI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LKNYZxdd9GnzF09d9hnsszm0hfjYWuDgd4/PlOEGld8=;
 b=Z93TP7ejwHMa5V3bz8bP1eTqfmcRPzjlAzi5O3YWxkTqVUqM284zK1rTA6TRvaUJg+
 6XICQhUYkaWODAp0oOXelkEcrOD2wxjNVhe8yT2pVvTI+QNELTqdKaPSpfvpsBPcB6SU
 P9A7p38Pl3vvWCCgo4OYveUnq0LI5HHH7b2W2wg/C7nE1fuNK9W7kHTnpZBdcchfAxo6
 3IQj0g3mPf83UNjepmEhjgFRy9TOljtAqDlg7mlNbtRMmN4/0GKIbVEtS5tU4BSUQwYo
 F64eRHcddZ/41d8v1M0tV4ISd0Zh75v+Ow8it8uz5WYDflEcJLnYjbnE0xbr59iuJYV9
 2tIw==
X-Gm-Message-State: AOAM530cHf/sPn66OK9iOOovPo0HICaSMYaXn4G4TYlBeC090KTm6bpj
 AysgapnI3N/iWpi8ehEwQ3N8HprRAS2DqA==
X-Google-Smtp-Source: ABdhPJz6VxwctjFKmyzKEqHfYa66GviLyytl3XTzGV9TihsesNlcVXTV+mrHBAX7z8kZ5DbLTPEX+A==
X-Received: by 2002:a05:6122:793:: with SMTP id
 k19mr6332351vkr.55.1598401477699; 
 Tue, 25 Aug 2020 17:24:37 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com.
 [209.85.217.45])
 by smtp.gmail.com with ESMTPSA id j15sm129942vki.8.2020.08.25.17.24.36
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 17:24:36 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id e14so48804vsa.9
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 17:24:36 -0700 (PDT)
X-Received: by 2002:a67:bc08:: with SMTP id t8mr8111843vsn.44.1598401476047;
 Tue, 25 Aug 2020 17:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=XK3Xa3rRWvuSA_jA+5_1XYBmHEX2B2XSb8h3oOe1PHLw@mail.gmail.com>
 <3df7edd53ebca00be288e69b92b8d4b9@codeaurora.org>
 <CAD=FV=X=3Jae7_gXN_05EsmZjrM1bN=TMZ0qoGKz=UaNrthzAg@mail.gmail.com>
 <CAF6AEGsuusnGaN-H9geFa+jwX_hkvMHGZCWvwk5-MDGQ7cBsbQ@mail.gmail.com>
In-Reply-To: <CAF6AEGsuusnGaN-H9geFa+jwX_hkvMHGZCWvwk5-MDGQ7cBsbQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Aug 2020 17:24:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyL3ttE_F3YJJxOWAJANeNueqH0gO3phu8q5F4NP809g@mail.gmail.com>
Message-ID: <CAD=FV=WyL3ttE_F3YJJxOWAJANeNueqH0gO3phu8q5F4NP809g@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add support to filter non-strict/lazy mode based
 on device names
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Aug 25, 2020 at 3:54 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 3:23 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Aug 25, 2020 at 12:01 PM Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> > >
> > > Hi,
> > >
> > > On 2020-08-25 21:40, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Tue, Aug 25, 2020 at 8:43 AM Sai Prakash Ranjan
> > > > <saiprakash.ranjan@codeaurora.org> wrote:
> > > >>
> > > >> Currently the non-strict or lazy mode of TLB invalidation can only be
> > > >> set
> > > >> for all or no domains. This works well for development platforms where
> > > >> setting to non-strict/lazy mode is fine for performance reasons but on
> > > >> production devices, we need a more fine grained control to allow only
> > > >> certain peripherals to support this mode where we can be sure that it
> > > >> is
> > > >> safe. So add support to filter non-strict/lazy mode based on the
> > > >> device
> > > >> names that are passed via cmdline parameter "iommu.nonstrict_device".
> > > >>
> > > >> Example:
> > > >> iommu.nonstrict_device="7c4000.sdhci,a600000.dwc3,6048000.etr"
> >
> > Just curious: are device names like this really guaranteed to be
> > stable across versions?
> >
> >
> > > > I have an inherent dislike of jamming things like this onto the
> > > > command line.  IMHO the command line is the last resort for specifying
> > > > configuration and generally should be limited to some specialized
> > > > debug options and cases where the person running the kernel needs to
> > > > override a config that was set by the person (or company) compiling
> > > > the kernel.  Specifically, having a long/unwieldy command line makes
> > > > it harder to use for the case when an end user actually wants to use
> > > > it to override something.  It's also just another place to look for
> > > > config.
> > > >
> > >
> > > Good thing about command line parameters are that they are optional,
> > > they do
> > > not specify any default behaviour (I mean they are not mandatory to be
> > > set
> > > for the system to be functional), so I would like to view it as an
> > > optional
> > > config. And this command line parameter (nonstrict_device) is strictly
> > > optional
> > > with default being strict already set in the driver.
> > >
> > > They can be passed from the bootloader via chosen node for DT platforms
> > > or choose
> > > a new *bootconfig* as a way to pass the cmdline but finally it does boil
> > > down to
> > > just another config.
> >
> > Never looked at bootconfig.  Unfortunately it seems to require
> > initramfs so that pretty much means it's out for my usage.  :(
> >
> >
> > > I agree with general boolean or single value command line parameters
> > > being just
> > > more messy which could just be Kconfigs instead but for multiple value
> > > parameters
> > > like these do not fit in Kconfig.
> > >
> > > As you might already know, command line also gives an advantage to the
> > > end user
> > > to configure system without building kernel, for this specific command
> > > line its
> > > very useful because the performance bump is quite noticeable when the
> > > iommu.strict
> > > is off. Now for end user who would not be interested in building entire
> > > kernel(majority)
> > > and just cares about good speeds or throughput can find this very
> > > beneficial.
> > > I am not talking about one specific OS usecase here but more in general
> > > term.
> > >
> > > > The other problem is that this doesn't necessarily scale very well.
> > > > While it works OK for embedded cases it doesn't work terribly well for
> > > > distributions.  I know that in an out-of-band thread you indicated
> > > > that it doesn't break anything that's not already broken (AKA this
> > > > doesn't fix the distro case but it doesn't make it worse), it would be
> > > > better to come up with a more universal solution.
> > > >
> > >
> > > Is the universal solution here referring to fix all the command line
> > > parameters
> > > in the kernel or this specific command line? Are we going to remove any
> > > more
> > > addition to the cmdline ;)
> >
> > There are very few cases where a kernel command line parameter is the
> > only way to configure something.  Most of the time it's just there to
> > override a config.  I wouldn't suggest removing those.  I just don't
> > want a kernel command line parameter to be the primary way to enable
> > something.
> >
> >
> > > So possible other solution is the *bootconfig* which is again just
> > > another place
> > > to look for a config. So thing is that this universal solution would
> > > result in
> > > just more new fancy ways of passing configs or adding such configs to
> > > the drivers
> > > or subsystems in kernel which is pretty much similar to implementing
> > > policy in
> > > kernel which I think is frowned upon and mentioned in the other thread.
> > >
> > > > Ideally it feels like we should figure out how to tag devices in a
> > > > generic manner automatically (hardcode at the driver or in the device
> > > > tree).  I think the out-of-band discussions talked about "external
> > > > facing" and the like.  We could also, perhaps, tag devices that have
> > > > "binary blob" firmware if we wanted.  Then we'd have a policy (set by
> > > > Kconfig, perhaps overridable via commandline) that indicated the
> > > > strictness level for the various classes of devices.  So policy would
> > > > be decided by KConfig and/or command line.
> > > >
> > >
> > > How is tagging in driver or device tree better than the simple command
> > > line
> > > approach to pass the same list of devices which otherwise you would
> > > hardcode
> > > in the corresponding drivers and device tree all over the kernel other
> > > than
> > > the scalability part for command line? IMHO it is too much churn.
> >
> > It's better because it doesn't require keeping track and updating
> > these per-board (or per machine) arguments for each and every
> > board/machine you maintain.  If, for instance, we start out by
> > allowing HW video decoder to use non-strict.  So:
> >
> > On one board, we add in "aa00000.video-codec" to the command line.
> > On some other board, maybe we add in "1d00000.video-codec" to the command line.
> > On some other board, maybe we add in "90400000.video-codec" to the command line.
> >
> > Now we realize that there's some problem and we have to remove it, so
> > we need to go through and remove this from our command line
> > everywhere.  Worse is that we have to proactively notice it and remove
> > it.
> >
> > Instead, let's imagine that we set a policy at a bit of a higher
> > level.  Different ideas:
> >
> > a) We could have a CONFIG_ option for the video codec that's something
> > like "CONFIG_VIDEOCODEC_DEFAULT_NONSTRICT".  If this was set then if
> > there is no "iommu.strict" command line argument then this device
> > would be mapped as non-strict.  If "iommu.strict=0" or
> > "iommu.strict=1" is on the command line then it would override all of
> > these defaults.  Probably the existence (or maybe the default value)
> > of this CONFIG option implies that there are no known/expected
> > exploits related to it.
>
> jumping in a bit late so might have missed some of the background, but
> shouldn't the driver decide strict vs non-strict?  It should be the
> one that knows if non-strict is safe or not?

Part of the problem is that we need some way for the driver to know if
the connected device is external or not.  A soldered-down storage
device connected via an internal PCIe bus is probably OK to use w/
non-strict.  An exposed PCIe port that anyone could plug anything into
is probably not OK to use with non-strict.  Right now the kernel
doesn't have this info.

Part of the problem is also trying to describe the risk level that
you're OK with and/or which risks you're willing to take and which
ones you're not willing to take.  Right now there's a binary: "accept
all the risk so I can get the best performance" and "accept none of
the risk".  ...but what if you want to accept some risks and not
others?  Maybe you're compiling the firmware for the video decoder
yourself and you're very convinced that it really sanitizes all input
and can't be compromised (or, if it is, you can quickly patch the
compromise).  You might be willing to run this video codec in "non
strict mode".  ...but if you give the video decoder firmware to
someone else as a binary blob they might not be willing to trust you
and might want to run the same firmware as "non-strict".



> BR,
> -R
>
> >
> > b) We could find some way to tag the video codec and then set
> > non-strictness on certain classes of devices, then we could have a
> > policy to disable strictness on certain classes of devices.
> >
> > The nice thing about the above is that you could imagine someone
> > pushing a change to the stable trees that would fix everyone affected.
> > Nobody would need to go around and adjust command line options, they'd
> > just get the newest stable and it could cause devices to move into
> > strict mode if there was a known exploit.  I suppose with your
> > proposal stable trees could have a "blacklist" where the commandline
> > is ignored for exploited devices, but that seems ugly.
> >
> >
> > > Device tree could be used but then we have a problem with it being for
> > > only
> > > describing hardware and it doesn't work for ACPI based systems.
> > >
> > > Command line approach works for all systems (both DT and ACPI) without
> > > having
> > > to add too much churn to drivers. Lastly, I think we can have both
> > > options, it
> > > doesn't hurt to add command line parameter since it is optional.
> >
> > I'm not opposed to something existing that lets you override this on
> > the command line, but I'm just not a fan of it being the primary way.
> >
> > -Doug
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
