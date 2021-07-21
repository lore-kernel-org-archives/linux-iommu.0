Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26791C6377A
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 20:13:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32F861279
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 20:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32F861279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 923608243B;
	Wed, 21 Jul 2021 20:13:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QOVRoRxNGtSJ; Wed, 21 Jul 2021 20:13:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3EC2382496;
	Wed, 21 Jul 2021 20:13:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12BBEC0010;
	Wed, 21 Jul 2021 20:13:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9353BC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 20:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7972060793
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 20:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DTO3LB_1G2Rm for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 20:13:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67FA6605F5
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 20:13:12 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 42-20020a9d012d0000b02904b98d90c82cso3218448otu.5
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lop2Mo3qaKZQHvdRq+YuqOoaPIzQiwDuhfWOgAOqAZ0=;
 b=PB5mPY5G2ota/+DFFfxv3JPi5/vJEoUikCFhR6GYPPynTWxryvDVQAjnTtQwa5NC5K
 8h+BmifA/rmTHaPIVlCdcglYRQYSXE0+fy4IZ+L5VDB9DeM5MDHAoqM6B0vhSYO3sKGx
 lHZX3keWuX9nc7XYdQ97FzDGY97MRBs2sYrar6FXMQRafku+SUf0KDpR8t6RDz/m9ME1
 7lFJyccSwSSiifWjfHMAIU3w72mDbgnkTh8gBqBut4/IjGpZoYqEydJ/FP68dicuDiq1
 6vu2iB76r8IUSdI6oEBE5OOZIzIe9emYP59IsOin4oGebtHd3WUzZX9p/V8zxSlAgbuB
 cfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lop2Mo3qaKZQHvdRq+YuqOoaPIzQiwDuhfWOgAOqAZ0=;
 b=glNbcBB1JReXmUb+GvUTb7NqI86vSgakwwuiswo9vpu9wILE/FE572ySP45Zn3JKFz
 Jig0O2QELlBQ04DgAmk/ZLcNijx+coFSQUtWtISdfO8AaNgSusitaLCAE8uqJRezi2jw
 bije98ysviNr2e3MPczVSDknhCT1Ua5VuwTUWhzC5tGi5/X8s3VhD33rUrQHu74qxe/T
 uaFWCbsYp6nXb+vl+dOoCPNMvOQ3Og61t0nTEu940drqnYIFVs8nBGDuacUOLyQYt+UK
 LViYnS0oNKpyKiaMfYirh9zCiiQAIAlu94RG2/7IdWwvEPBh0s5wgjHMkjrEhqQzfGK0
 hrzw==
X-Gm-Message-State: AOAM532V+AHv0lr+dezfR71zEcbCBc1L/uqBA5oeksrUKTPCDRldZvak
 fTQWncFz6pH4w2gXS6hh94Ykug==
X-Google-Smtp-Source: ABdhPJwsrm6tGosBeciWrtLHpuumSbtrzelppV5AbtxXUKRLSAIzmTPCqypzIK2PjWq0vIb4pcWAcw==
X-Received: by 2002:a05:6830:34a4:: with SMTP id
 c36mr14509757otu.57.1626898391420; 
 Wed, 21 Jul 2021 13:13:11 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id b2sm1732793otf.40.2021.07.21.13.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jul 2021 13:13:10 -0700 (PDT)
Date: Wed, 21 Jul 2021 15:13:08 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
Message-ID: <YPh/1IN1A9BixMrw@yoga>
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPJkF21ItYlKODyq@yoga>
 <CALAqxLUzTNiA7u=4_y9pkrh=Q_+vpPgFrhf_6F8-U0XPQU9crQ@mail.gmail.com>
 <YPXUI0VzpxYO56BU@yoga>
 <CAGETcx90xNFzEB9yfWvLg=X+ptrgNaQg9Ncxi-U_Z0vXHrUcgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx90xNFzEB9yfWvLg=X+ptrgNaQg9Ncxi-U_Z0vXHrUcgw@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon 19 Jul 16:53 CDT 2021, Saravana Kannan wrote:

> On Mon, Jul 19, 2021 at 12:36 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Mon 19 Jul 14:00 CDT 2021, John Stultz wrote:
> >
> > > On Fri, Jul 16, 2021 at 10:01 PM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > > On Tue 06 Jul 23:53 CDT 2021, John Stultz wrote:
> > > > > Allow the qcom_scm driver to be loadable as a permenent module.
> > > > >
> > > > > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > > > > ensure that drivers that call into the qcom_scm driver are
> > > > > also built as modules. While not ideal in some cases its the
> > > > > only safe way I can find to avoid build errors without having
> > > > > those drivers select QCOM_SCM and have to force it on (as
> > > > > QCOM_SCM=n can be valid for those drivers).
> > > > >
> > > > > Reviving this now that Saravana's fw_devlink defaults to on,
> > > > > which should avoid loading troubles seen before.
> > > > >
> > > >
> > > > Are you (in this last paragraph) saying that all those who have been
> > > > burnt by fw_devlink during the last months and therefor run with it
> > > > disabled will have a less fun experience once this is merged?
> > > >
> 
> Bjorn,
> 
> I jump in and help with any reports of issues with fw_devlink if I'm
> cc'ed. Please feel free to add me and I'll help fix any issues you
> have with fw_devlink=on.
> 

Thanks Saravana, unfortunately I've only heard these reports second hand
so far, not been able to reproduce them on my own. I appreciate your
support and will certainly reach out if I need some assistance.

> > >
> > > I guess potentially. So way back when this was originally submitted,
> > > some folks had trouble booting if it was set as a module due to it
> > > loading due to the deferred_probe_timeout expiring.
> > > My attempts to change the default timeout value to be larger ran into
> > > trouble, but Saravana's fw_devlink does manage to resolve things
> > > properly for this case.
> > >
> >
> > Unfortunately I see really weird things coming out of that, e.g. display
> > on my db845c is waiting for the USB hub on PCIe to load its firmware,
> > which typically times out after 60 seconds.
> >
> > I've stared at it quite a bit and I don't understand how they are
> > related.
> 
> Can you please add me to any email thread with the details? I'd be
> happy to help.
> 
> First step is to make sure all the devices probe as with
> fw_devlink=permissive. After that if you are still seeing issues, it's
> generally timing issues in the driver. But if the actual timing issue
> is identified (by you or whoever knows the driver seeing the issue),
> then I can help with fixes or suggestions for fixes.
> 
> > > But if folks are having issues w/ fw_devlink, and have it disabled,
> > > and set QCOM_SCM=m they could still trip over the issue with the
> > > timeout firing before it is loaded (especially if they are loading
> > > modules from late mounted storage rather than ramdisk).
> > >
> >
> > I guess we'll have to force QCOM_SCM=y in the defconfig and hope people
> > don't make it =m.
> >
> > > > (I'm picking this up, but I don't fancy the idea that some people are
> > > > turning the boot process into a lottery)
> > >
> > > Me neither, and I definitely think the deferred_probe_timeout logic is
> > > way too fragile, which is why I'm eager for fw_devlink as it's a much
> > > less racy approach to handling module loading dependencies.
> >
> > Right, deferred_probe_timeout is the main issue here. Without it we
> > might get some weird probe deferral runs, but either some driver is
> > missing or it settles eventually.
> >
> > With deferred_probe_timeout it's rather common for me to see things
> > end up probe out of order (even more now with fw_devlink finding cyclic
> > dependencies) and deferred_probe_timeout just breaking things.
> 
> Again, please CC me on these threads and I'd be happy to help.
> 
> >
> > > So if you
> > > want to hold on this, while any remaining fw_devlink issues get
> > > sorted, that's fine.  But I'd also not cast too much ire at
> > > fw_devlink, as the global probe timeout approach for handling optional
> > > links isn't great, and we need a better solution.
> > >
> >
> > There's no end to the possible and valid ways you can setup your
> > defconfig and run into the probe deferral issues, so I see no point in
> > holding this one back any longer. I just hope that one day it will be
> > possible to boot the upstream kernel in a reliable fashion.
> 
> Might not be believable, but I'm hoping fw_devlink helps you meet this goal :)
> 

Sounds good, I hope so too :)

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
