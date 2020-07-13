Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF59CC433E5
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 20:48:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95A62077D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 20:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSChuGC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95A62077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 92503204DD;
	Mon, 13 Jul 2020 20:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njJ8EFZgrlk7; Mon, 13 Jul 2020 20:48:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B87B52040F;
	Mon, 13 Jul 2020 20:48:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92B73C088E;
	Mon, 13 Jul 2020 20:48:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4473C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 20:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C297A8A023
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 20:48:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ZoIS5IYju2n for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 20:48:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DDC8D8A01E
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 20:48:40 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id a21so10643301otq.8
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lh221sZMEzUwu+YkumvRaKYqnEn8mE4Ip8GmS9KXxVg=;
 b=OSChuGC7pSQQ/bJlgydK0ADw9GvoUXuvT90prm9gM0Cw5HnXeeBbGpWTISeAUDtyfY
 8NWSstNPyc0j3sRyNZSqMoTpyFqwGZvcCTm6iA6ni1f6Qx/pcOO3DscgLa/zWB8Oaqkv
 Ku+NZmXt4FPKqF3r7TAqgG/zBcC9K1l/G6lOU+yIKh2l5/7zIzxTz7jGOPILinNI/AOq
 K50ZacpLUVPLV3Ir0ZUyEITsvg6TkE0ElG84vHO3+Yf/grx5v3AGgKKLyLgUfQ2WJgWD
 o5Nr6AEl+TsYsFneyN3RyzJWH8m9mSrjU/8m4g9IUNhVxapN2eG75uAUQUJDesJTqLlD
 4/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lh221sZMEzUwu+YkumvRaKYqnEn8mE4Ip8GmS9KXxVg=;
 b=ZoDdOtoYTXSSpYQ+VMN/e3taDSm80FdtV9U2B9wXiQku52sJVq58HS28tn6GTP4akX
 NKUZRqZFqcK1nkMFyhYEDAG+Zdt2ob0Ws8NrEh2sVb3FgPeE9QvPkPSVD9daBNk4lLW5
 /SzkDiN78t9bxbLq1hUoYt5kQOiWIE9uqOR/nMPuxDmV+23V3rME5cGWk2aq50I1G3GA
 2judOU3TGdlmWfSAVbP3D4WNelzH/VkYzzllfsx/Ug88XLLmUe/o65rNlb7UZ8tMWBQx
 QYiCWF2dxO8s/6Hj5w/6nx8k7qegcBhskbfyWBzZLQMUa/MnvrFkUG4FzxZ+YN4Jp8VV
 g7xA==
X-Gm-Message-State: AOAM5314l2KU5wxoFrxt0mTrTzYIDmvYOho6NCkiCvLbFvHa9XbD2ElI
 q0OT3rSyCgl5YDUC6VqO49dk4p7L9bUdt1FTx4aDQg==
X-Google-Smtp-Source: ABdhPJy9C2Om36y+PsKBCgaQym7s/MdG28IdH6HbTh4AdwgaQh3TIVhuMIJqa0h9wiOoK7uSCd2oiaqiq2jjsDnYL9s=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr1212486otk.221.1594673320007; 
 Mon, 13 Jul 2020 13:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-6-john.stultz@linaro.org>
 <20200702141825.GA16941@willie-the-truck>
 <CALAqxLVZ2EhutYjOt7Be1RgnYwHT6-4m6DxA-t1wuxuSy=6yDQ@mail.gmail.com>
 <20200710075411.GA30011@willie-the-truck>
 <CALAqxLWadLrxckRHRAR0Q417RnFKquQJbRfO_DLEVH56cykRow@mail.gmail.com>
 <20200713204133.GA3731@willie-the-truck>
In-Reply-To: <20200713204133.GA3731@willie-the-truck>
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 13 Jul 2020 13:48:29 -0700
Message-ID: <CALAqxLXDVRzWDfuAS78EFwyYs3yr3QrPF3Tze0KAW1fo9c7M2A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: Will Deacon <will@kernel.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Todd Kjos <tkjos@google.com>
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

On Mon, Jul 13, 2020 at 1:41 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jul 10, 2020 at 03:21:53PM -0700, John Stultz wrote:
> > On Fri, Jul 10, 2020 at 12:54 AM Will Deacon <will@kernel.org> wrote:
> > > On Thu, Jul 09, 2020 at 08:28:45PM -0700, John Stultz wrote:
> > > > On Thu, Jul 2, 2020 at 7:18 AM Will Deacon <will@kernel.org> wrote:
> > > > > On Thu, Jun 25, 2020 at 12:10:39AM +0000, John Stultz wrote:
> > > > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > > > index b510f67dfa49..714893535dd2 100644
> > > > > > --- a/drivers/iommu/Kconfig
> > > > > > +++ b/drivers/iommu/Kconfig
> > > > > > @@ -381,6 +381,7 @@ config SPAPR_TCE_IOMMU
> > > > > >  config ARM_SMMU
> > > > > >       tristate "ARM Ltd. System MMU (SMMU) Support"
> > > > > >       depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) && MMU
> > > > > > +     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> > > > > >       select IOMMU_API
> > > > > >       select IOMMU_IO_PGTABLE_LPAE
> > > > > >       select ARM_DMA_USE_IOMMU if ARM
> > > > >
> > > > > This looks like a giant hack. Is there another way to handle this?
> > > >
> > > > Sorry for the slow response here.
> > > >
> > > > So, I agree the syntax looks strange (requiring a comment obviously
> > > > isn't a good sign), but it's a fairly common way to ensure drivers
> > > > don't get built in if they optionally depend on another driver that
> > > > can be built as a module.
> > > >   See "RFKILL || !RFKILL", "EXTCON || !EXTCON", or "USB_GADGET ||
> > > > !USB_GADGET" in various Kconfig files.
> > > >
> > > > I'm open to using a different method, and in a different thread you
> > > > suggested using something like symbol_get(). I need to look into it
> > > > more, but that approach looks even more messy and prone to runtime
> > > > failures. Blocking the unwanted case at build time seems a bit cleaner
> > > > to me, even if the syntax is odd.
> > >
> > > Maybe just split it out then, so that the ARM_SMMU entry doesn't have this,
> > > as that driver _really_ doesn't care about SoC details like this. In other
> > > words, add a new entry along the lines of:
> > >
> > >         config ARM_SMMU_QCOM_IMPL
> > >         default y
> > >         #if QCOM_SCM=m this can't be =y
> > >         depends on ARM_SMMU & (QCOM_SCM || !QCOM_SCM)
> > >
> > > and then have arm-smmu.h provide a static inline qcom_smmu_impl_init()
> > > which returns -ENODEV if CONFIG_ARM_SMMU_QCOM_IMPL=n and hack the Makefile
> > > so that we don't bother to compile arm-smmu-qcom.o in that case.
> > >
> > > Would that work?
> >
> > I think this proposal still has problems with the directionality of the call.
> >
> > The arm-smmu-impl.o calls to arm-smmu-qcom.o which calls qcom_scm.o
> > So if qcom_scm.o is part of a module, the calling code in
> > arm-smmu-qcom.o also needs to be a module, which means CONFIG_ARM_SMMU
> > needs to be a module.
> >
> > I know you said the arm-smmu driver doesn't care about SoC details,
> > but the trouble is that currently the arm-smmu driver does directly
> > call the qcom-scm code. So it is a real dependency. However, if
> > QCOM_SCM is not configured, it calls stubs and that's ok.  In that
> > way, the "depends on QCOM_SCM || !QCOM_SCM" line actually makes sense.
> > It looks terrible because we're used to boolean logic, but it's
> > ternary.
>
> Yes, it looks ugly, but the part I really have issues with is that building
> QCOM_SCM=m and ARM_SMMU=y is perfectly fine if you don't run on an SoC
> with the qcom implementation. I don't see why we need to enforce things
> here beyond making sure that all selectable permutations _build_ and
> fail gracefully at runtime on the qcom SoC if SCM isn't available.

Ok. Thanks, that context/rationale makes sense to me now!  I'll dig in
and see if I can figure out the runtime get_symbol handling you
suggested for the scm callout.

Thanks again for the feedback!
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
