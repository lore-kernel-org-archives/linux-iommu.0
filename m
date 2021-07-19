Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5648C07E95
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 21:54:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306B261002
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 21:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306B261002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E81EC834D5;
	Mon, 19 Jul 2021 21:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rRw_x8P1qk4C; Mon, 19 Jul 2021 21:54:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D18438344C;
	Mon, 19 Jul 2021 21:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92633C001A;
	Mon, 19 Jul 2021 21:54:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C178C000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 21:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D10F83365
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 21:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yLlYfA7nOIzG for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 21:54:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 50E5A8333F
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 21:54:25 +0000 (UTC)
Received: by mail-yb1-xb2e.google.com with SMTP id g5so29983049ybu.10
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mgewm5mjx+FRnoLmab+NYqOB950vpM/jLC7o5sa2XM8=;
 b=l0R7mPgHhU+9/Prsowfdj7Q2tQ1PxSoUyzKyHKVvNc724HS7Q2DlFv99s3OP2TG/Zq
 lwEOjLRSF21f2rIl6xbmlp+HtCrfmG/rtgg50IMgNNhdd7MvHme0UH+zssIKkD4DysIV
 9n03+QQKXy8uuwmkJD8Mr+uOSE/yA0i2iVtHLv/9GUxl+FSGRkhTePgD8pYCukp4Dyz7
 nqQ6P12jnkTl+CUhabJGja6HSNCHhD9KeRBFuzhgnM8w1DbZ2CXLE0Q7Ci39eg+sf+vv
 GsJnL5QEKafmdGXCglA+rJ9522ssx6xe5cbdRqM+wnuZ2Iz4xFxlQvezVkADeXN2P62Z
 xTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mgewm5mjx+FRnoLmab+NYqOB950vpM/jLC7o5sa2XM8=;
 b=Ikep/V70gkWMR1c//UV7AR0syEadhhAISy/xA6DxePxrpR8UoEkv7MkGGzU1iPn2qY
 FntfepnAP20KuUU1rX1+i0FclLFjtzgRBZWKQUT3EVGe7H/yUkZC606QS8qFWBRIER0H
 8fsIDulLTJNPiKraqGpUrudg7812lN29z2slvWsKIgyXnaUfCfOYHDzx3udFbKTv+Dfr
 ZSe0UvOxOTsRmrQdJKx2BnzeQx1nbCufSe86N7NjLQioQUkywdSxQunapiV0KSO1iaPh
 hYOsfJ6fP/YvauKV4B7SGq9b7sOWlHVKXZrL/X5oTHdQQR0zq+26vrqcav8XWbfFKb6l
 9Bvw==
X-Gm-Message-State: AOAM530iFoyipynt0xWm2lI8XF9x2M+mk60iRQZnHm7xMaXT5VLUA79l
 jVWqK6QFhMThgg9Q7ZPqfRozqSmAA8enBsCJ+Nxaqg==
X-Google-Smtp-Source: ABdhPJzzk8LrlzrvE22blW8gQTFo/PFlSTmtqN8jtyX4Dwh9d+eIRQ31WAGLf0IV9Ru2kTwRL7h6I1jaXreQrxJjSnI=
X-Received: by 2002:a25:8b91:: with SMTP id j17mr33097786ybl.228.1626731663924; 
 Mon, 19 Jul 2021 14:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPJkF21ItYlKODyq@yoga>
 <CALAqxLUzTNiA7u=4_y9pkrh=Q_+vpPgFrhf_6F8-U0XPQU9crQ@mail.gmail.com>
 <YPXUI0VzpxYO56BU@yoga>
In-Reply-To: <YPXUI0VzpxYO56BU@yoga>
Date: Mon, 19 Jul 2021 14:53:47 -0700
Message-ID: <CAGETcx90xNFzEB9yfWvLg=X+ptrgNaQg9Ncxi-U_Z0vXHrUcgw@mail.gmail.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>,
 Android Kernel Team <kernel-team@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 John Stultz <john.stultz@linaro.org>, Marc Zyngier <maz@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jul 19, 2021 at 12:36 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 19 Jul 14:00 CDT 2021, John Stultz wrote:
>
> > On Fri, Jul 16, 2021 at 10:01 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > > On Tue 06 Jul 23:53 CDT 2021, John Stultz wrote:
> > > > Allow the qcom_scm driver to be loadable as a permenent module.
> > > >
> > > > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > > > ensure that drivers that call into the qcom_scm driver are
> > > > also built as modules. While not ideal in some cases its the
> > > > only safe way I can find to avoid build errors without having
> > > > those drivers select QCOM_SCM and have to force it on (as
> > > > QCOM_SCM=n can be valid for those drivers).
> > > >
> > > > Reviving this now that Saravana's fw_devlink defaults to on,
> > > > which should avoid loading troubles seen before.
> > > >
> > >
> > > Are you (in this last paragraph) saying that all those who have been
> > > burnt by fw_devlink during the last months and therefor run with it
> > > disabled will have a less fun experience once this is merged?
> > >

Bjorn,

I jump in and help with any reports of issues with fw_devlink if I'm
cc'ed. Please feel free to add me and I'll help fix any issues you
have with fw_devlink=on.

> >
> > I guess potentially. So way back when this was originally submitted,
> > some folks had trouble booting if it was set as a module due to it
> > loading due to the deferred_probe_timeout expiring.
> > My attempts to change the default timeout value to be larger ran into
> > trouble, but Saravana's fw_devlink does manage to resolve things
> > properly for this case.
> >
>
> Unfortunately I see really weird things coming out of that, e.g. display
> on my db845c is waiting for the USB hub on PCIe to load its firmware,
> which typically times out after 60 seconds.
>
> I've stared at it quite a bit and I don't understand how they are
> related.

Can you please add me to any email thread with the details? I'd be
happy to help.

First step is to make sure all the devices probe as with
fw_devlink=permissive. After that if you are still seeing issues, it's
generally timing issues in the driver. But if the actual timing issue
is identified (by you or whoever knows the driver seeing the issue),
then I can help with fixes or suggestions for fixes.

> > But if folks are having issues w/ fw_devlink, and have it disabled,
> > and set QCOM_SCM=m they could still trip over the issue with the
> > timeout firing before it is loaded (especially if they are loading
> > modules from late mounted storage rather than ramdisk).
> >
>
> I guess we'll have to force QCOM_SCM=y in the defconfig and hope people
> don't make it =m.
>
> > > (I'm picking this up, but I don't fancy the idea that some people are
> > > turning the boot process into a lottery)
> >
> > Me neither, and I definitely think the deferred_probe_timeout logic is
> > way too fragile, which is why I'm eager for fw_devlink as it's a much
> > less racy approach to handling module loading dependencies.
>
> Right, deferred_probe_timeout is the main issue here. Without it we
> might get some weird probe deferral runs, but either some driver is
> missing or it settles eventually.
>
> With deferred_probe_timeout it's rather common for me to see things
> end up probe out of order (even more now with fw_devlink finding cyclic
> dependencies) and deferred_probe_timeout just breaking things.

Again, please CC me on these threads and I'd be happy to help.

>
> > So if you
> > want to hold on this, while any remaining fw_devlink issues get
> > sorted, that's fine.  But I'd also not cast too much ire at
> > fw_devlink, as the global probe timeout approach for handling optional
> > links isn't great, and we need a better solution.
> >
>
> There's no end to the possible and valid ways you can setup your
> defconfig and run into the probe deferral issues, so I see no point in
> holding this one back any longer. I just hope that one day it will be
> possible to boot the upstream kernel in a reliable fashion.

Might not be believable, but I'm hoping fw_devlink helps you meet this goal :)

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
