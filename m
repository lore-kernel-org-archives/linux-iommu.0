Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A9FC3A59F
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 18:12:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E01B21721
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 18:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHoRmO8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E01B21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3F17ECA8;
	Fri, 16 Aug 2019 18:12:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4910CC7D
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 18:12:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7BC9889D
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 18:12:42 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id s15so5917378edx.0
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=rrnKHz7hxP2DwOGHD0Zkrb/6rHKyYs+A28YWIo2Nxdg=;
	b=tHoRmO8YMkuQimp7U/0w6Ao45sJdzXUA0qhbqIfxI2Ac3O9EA6aGBN50AZbuCN6+jD
	QZNAat18MEWCj4BMIeAYxEsxZjTT2xYtzPXy/CvKJio14Uc0KgctAbhF8LqwQd9wjOHV
	DS1xJOaedakFbaU1vOqkz1FDVa0eWYn8rbAA8cEMGvp5isgfBH1Rj7ZsCJKxqm12kcSv
	O+S8Mi8ijKzUmmNecXo7eU1s/eSyRuxjK3mI7R+/YrZGdgc6Fe7A9/ucNU11diVypPvS
	BB1EB/ukrqGaaiQdimlRCIOqrtZ3MyRyqrf/+FoXA13t1kjC9qInNTsoUUnBsq4PI8tg
	Xegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=rrnKHz7hxP2DwOGHD0Zkrb/6rHKyYs+A28YWIo2Nxdg=;
	b=E5XlH7hQj6Ev4buFbnQF6bRSt6sPIgUv1ZXK6PiM3NaXR7nj5N83eqM4lgE6GMvzQC
	JhkXejlyhI0KRJqPvnyWM8F54v0dNybMo1Ok2ZCd4nJ0UT1Q/awijkVCJNnKPgWVoQHX
	zGHk5YW2x4aq/bIeVK2wQhG57ogPRcku3pZKAffwVfIftsT9SCa1oGHwSfnGIaxF9sLx
	FV80eTMhf2l/HIuqco7lfFSFkiKxet4PW94ooTmHLvHS+N7oTNms/nRhOzjgnDVdWek7
	x1afKUh/3ycGRs30YK2M+JuUerwhOH3/+cFCOQB8T0k0UOmBzGtR7wD77rbZp0qQE6yy
	IjNg==
X-Gm-Message-State: APjAAAUEFdmspKVs3XwB5IfPdiQWOEcnsFa8lXJKc0s1tPNs3isPo4Cr
	Un5U4hPgRHJzumpAqRDn/BO1lPLgvWtpymsiNu0=
X-Google-Smtp-Source: APXvYqycYnyBI0HviQih16yhnRuqQe3/IufQePKUqf+IYM1GYJmMHbrpl2hyJIRBxdySXtfDgBpBM3UEAuL6o0X49PU=
X-Received: by 2002:a50:86c7:: with SMTP id 7mr12351442edu.264.1565979161038; 
	Fri, 16 Aug 2019 11:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <1565216500-28506-1-git-send-email-jcrouse@codeaurora.org>
	<20190815153304.GD28465@jcrouse1-lnx.qualcomm.com>
	<ac248f33-2528-c1d4-17ed-17e92e6ed5ad@arm.com>
In-Reply-To: <ac248f33-2528-c1d4-17ed-17e92e6ed5ad@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 16 Aug 2019 11:12:29 -0700
Message-ID: <CAF6AEGujjF+MQFw45g799i+2QE4X=eRZdDSsD_F3y3mfbc6UPw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v3 0/2] iommu/arm-smmu: Split pagetable support
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh@kernel.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	freedreno <freedreno@lists.freedesktop.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

On Fri, Aug 16, 2019 at 9:58 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Jordan,
>
> On 15/08/2019 16:33, Jordan Crouse wrote:
> > On Wed, Aug 07, 2019 at 04:21:38PM -0600, Jordan Crouse wrote:
> >> (Sigh, resend. I freaked out my SMTP server)
> >>
> >> This is part of an ongoing evolution for enabling split pagetable support for
> >> arm-smmu. Previous versions can be found [1].
> >>
> >> In the discussion for v2 Robin pointed out that this is a very Adreno specific
> >> use case and that is exactly true. Not only do we want to configure and use a
> >> pagetable in the TTBR1 space, we also want to configure the TTBR0 region but
> >> not allocate a pagetable for it or touch it until the GPU hardware does so. As
> >> much as I want it to be a generic concept it really isn't.
> >>
> >> This revision leans into that idea. Most of the same io-pgtable code is there
> >> but now it is wrapped as an Adreno GPU specific format that is selected by the
> >> compatible string in the arm-smmu device.
> >>
> >> Additionally, per Robin's suggestion we are skipping creating a TTBR0 pagetable
> >> to save on wasted memory.
> >>
> >> This isn't as clean as I would like it to be but I think that this is a better
> >> direction than trying to pretend that the generic format would work.
> >>
> >> I'm tempting fate by posting this and then taking some time off, but I wanted
> >> to try to kick off a conversation or at least get some flames so I can try to
> >> refine this again next week. Please take a look and give some advice on the
> >> direction.
> >
> > Will, Robin -
> >
> > Modulo the impl changes from Robin, do you think that using a dedicated
> > pagetable format is the right approach for supporting split pagetables for the
> > Adreno GPU?
>
> How many different Adreno drivers would benefit from sharing it?

Hypothetically everything back to a3xx, so I *could* see usefulness of
this in qcom_iommu (or maybe even msm-iommu).  OTOH maybe with
"modularizing" arm-smmu we could re-combine qcom_iommu and arm-smmu.
And as a practical matter, I'm not sure if anyone will get around to
backporting per-context pagetables as far back as a3xx.

BR,
-R

> The more I come back to this, the more I'm convinced that io-pgtable
> should focus on the heavy lifting of pagetable management - the code
> that nobody wants to have to write at all, let alone more than once -
> and any subtleties which aren't essential to that should be pushed back
> into whichever callers actually care. Consider that already, literally
> no caller actually uses an unmodified stage 1 TCR value as provided in
> the io_pgtable_cfg.
>
> I feel it would be most productive to elaborate further in the form of
> patches, so let me get right on that and try to bash something out
> before I go home tonight...
>
> Robin.
>
> > If so, then is adding the changes to io-pgtable-arm.c possible for 5.4 and then
> > add the implementation specific code on top of Robin's stack later or do you
> > feel they should come as part of a package deal?
> >
> > Jordan
> >
> >> Jordan Crouse (2):
> >>    iommu/io-pgtable-arm: Add support for ARM_ADRENO_GPU_LPAE io-pgtable
> >>      format
> >>    iommu/arm-smmu: Add support for Adreno GPU pagetable formats
> >>
> >>   drivers/iommu/arm-smmu.c       |   8 +-
> >>   drivers/iommu/io-pgtable-arm.c | 214 ++++++++++++++++++++++++++++++++++++++---
> >>   drivers/iommu/io-pgtable.c     |   1 +
> >>   include/linux/io-pgtable.h     |   2 +
> >>   4 files changed, 209 insertions(+), 16 deletions(-)
> >>
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> Freedreno mailing list
> >> Freedreno@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/freedreno
> >
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
