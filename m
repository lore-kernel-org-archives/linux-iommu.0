Return-Path: <SRS0=3WiH=XL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FBFC49ED7
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 18:20:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0324206A4
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 18:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0eRIK47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0324206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A8D3C1B09;
	Mon, 16 Sep 2019 18:20:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7D5FB1B09
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 18:20:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D800081A
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 18:20:03 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id k5so1314164iol.5
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=F8iJAzTwJcB9/VDgjOQxGqsdGMfHTEdp0fXQRcootLk=;
	b=d0eRIK47tVV0Nh4b3yo8EWyAwwANodOqCfZADY4AnIkR/Tqu7PVsGDnwMPK3tvJbYA
	ZY0/JglYkHm31l66Ne4RbPXoZT8CPP+YM7uyY4pQuXRnxCeFxXfTXNpPUs/+UEa1ZvG+
	x2KNW/iZRpIDiywTCLc7cxv9EiXQ+j+4V00os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=F8iJAzTwJcB9/VDgjOQxGqsdGMfHTEdp0fXQRcootLk=;
	b=mkYbUhRIspFsmt/G+dnYdkht6mknGPxXVL6lqJaA1ze22SD4O4sGMChyJMmz4xN9+Y
	TwmXCjAqSRK1KpiHaLsx8F0Y5EBtsNq6yLBm4prmj9tEPNEtGf9M3QyYQN8vGoOJia7o
	H/Fz1722+yU37Og5G0CkfugnhxJndAe3I7wO5iFr61PTY8CrHxhdfmCO2nNqWQp70dxC
	wN4HxXqT/OU7RJoSeoyYxYYg5mlldB65d3EMGRl3J1jdFdlHQQA3nlPUXWeQUfCSHPIp
	TZ+qWQ4LXR/RqeBMMKoLrgn9Jdt/39/M2Ntc2tnVXb9CJargw4Shmqutr9ov6b8tL9Gb
	/x4A==
X-Gm-Message-State: APjAAAWz/gteV3j/yVsXAi+emreDsR7QiJtVNo66idArtqidIjh9D9er
	QBCFESe98tbm2WswYd1YVfRWti61Lqg=
X-Google-Smtp-Source: APXvYqyvszeeq2KDAYL9sHF4GSZ6FPyNc+zRHuEGgwbzxkaepL7wqvHH/k+/fSzNL+6YVycz4iL2PA==
X-Received: by 2002:a5d:814d:: with SMTP id f13mr1356987ioo.162.1568658002985; 
	Mon, 16 Sep 2019 11:20:02 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com.
	[209.85.166.50]) by smtp.gmail.com with ESMTPSA id
	v15sm1031176ios.88.2019.09.16.11.20.02
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Mon, 16 Sep 2019 11:20:02 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id b136so1348172iof.3
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 11:20:02 -0700 (PDT)
X-Received: by 2002:a6b:b445:: with SMTP id d66mr1312024iof.269.1568658001789; 
	Mon, 16 Sep 2019 11:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
	<CAD=FV=XPi+DCwg2DWbZkXQGTpxWy=vWa1LQR=zHZr93WKjCmzA@mail.gmail.com>
	<20190916180021.cp2onwou7pbsrygd@willie-the-truck>
In-Reply-To: <20190916180021.cp2onwou7pbsrygd@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 16 Sep 2019 11:19:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wx7zSqGSABfnG9B0yAcZvimub+hMcPRfUoFxr-FJeFew@mail.gmail.com>
Message-ID: <CAD=FV=Wx7zSqGSABfnG9B0yAcZvimub+hMcPRfUoFxr-FJeFew@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Report USF more clearly
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On Mon, Sep 16, 2019 at 11:00 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Sep 13, 2019 at 03:44:12PM -0700, Doug Anderson wrote:
> > On Fri, Sep 13, 2019 at 4:48 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > Although CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is a welcome tool
> > > for smoking out inadequate firmware, the failure mode is non-obvious
> > > and can be confusing for end users. Add some special-case reporting of
> > > Unidentified Stream Faults to help clarify this particular symptom.
> > >
> > > CC: Douglas Anderson <dianders@chromium.org>
> >
> > nit that I believe that "Cc" (lowercase 2nd c) is correct.
> >
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >  drivers/iommu/arm-smmu.c | 5 +++++
> > >  drivers/iommu/arm-smmu.h | 2 ++
> > >  2 files changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index b7cf24402a94..76ac8c180695 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -499,6 +499,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
> > >         dev_err_ratelimited(smmu->dev,
> > >                 "\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
> > >                 gfsr, gfsynr0, gfsynr1, gfsynr2);
> > > +       if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> > > +           (gfsr & sGFSR_USF))
> > > +               dev_err_ratelimited(smmu->dev,
> > > +                       "Stream ID %hu may not be described by firmware, try booting with \"arm-smmu.disable_bypass=0\"\n",
> > > +                       (u16)gfsynr1);
> >
> > In general it seems like a sane idea to surface an error like this.  I
> > guess a few nits:
> >
> > 1. "By firmware" might be a bit misleading.  In most cases I'm aware
> > of the problem is in the device tree that was bundled together with
> > the kernel.  If there are actually cases where firmware has baked in a
> > device tree and it got this wrong then we might want to spend time
> > figuring out what to do about it.
>
> I thought that was usually the way UEFI systems worked, where the kernel
> is updated independently of the device-tree? Either way, that should be
> what we're aiming for, even if many platforms require the two to be tied
> together.

It's my opinion that until there is a place in the kernel to "fixup"
broken device trees that were baked in firmware that it's a bad idea
to ship device trees separate from the kernel except if the device
trees are exceedingly simple.  We'll run into too many problems
otherwise, either because the kernel the device tree was written for
had downstream patches or someone just made a mistake in them and
nobody noticed.  I know device trees are supposed to be ABI, but
people make mistakes and we need a way to fix them up.

...but that's getting pretty far afield from Robin's patch.


> > 2. Presumably booting with "arm-smmu.disable_bypass=0" is in most
> > cases the least desirable option available.  I always consider kernel
> > command line parameters as something of a last resort for
> > configuration and would only be something that and end user might do
> > if they were given a kernel compiled by someone else (like if someone
> > where taking a prebuilt Linux distro and trying to install it onto a
> > generic PC).  Are you seeing cases where this is happening?  If people
> > are compiling their own kernel I'd argue that telling them to set
> > "CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT" to "no" is much better
> > than trying to jam a command line option on.  Command line options
> > don't scale well.
>
> Hmm. Recompiling seems like even more of a last resort to me!

Depends on what you're doing.  If you're not in the habit of compiling
a kernel and you're just trying to make one work then the command line
is great.  If you're trying to manage configuration for a whole bunch
of different hardware products then the command line is a terrible
place to store config.

...but I guess the summary is that we wouldn't want someone to
actually ship a kernel with this option on anyway.  ;-)


> > 3. Any chance you could make it more obvious that this change is
> > undesirable and a last resort?  AKA:
> >
> > "Stream ID x blocked for security reasons; allow anyway by booting
> > with arm-smmu.disable_bypass=0"
>
> How about:
>
>   "Blocked transaction from unknown Stream ID x; boot with
>    \"arm-smmu.disable_bypass=0\" to allow these transactions, although this
>    may have security implications."

Fine with me if it's not too long for an error message.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
