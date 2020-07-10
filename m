Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1BAC433EA
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 22:22:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2CB207BB
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 22:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGWgrEwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2CB207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7ED5E2048D;
	Fri, 10 Jul 2020 22:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pAIYAee7OWkk; Fri, 10 Jul 2020 22:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C9D332DF58;
	Fri, 10 Jul 2020 22:22:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA320C077B;
	Fri, 10 Jul 2020 22:22:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 627B9C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 22:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 518BE88AE5
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 22:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eB19AfvIvZbr for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 22:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 693A38896A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 22:22:07 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id t4so6042194oij.9
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 15:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sfPk1+u61DN4Dz/z2Pu4rTndUdKhPwDaWZtZBaUU1jg=;
 b=CGWgrEwlpWSxGS28p+B9aKE3dWl38zgj4StlTqSCg3W9KgUJXjeDSaY6Jwx8i9lwRi
 9UpvDUF7JWYl638DQLAuqEazgzf8DbZZ9YxsBc+6s4pA0JeV/ASd0IAshGRT8qT4BX0S
 xxqg9moE+lu34pnF6PLPa3mQs1nK4VYFyAzoCRitXkydtj0aNPoPsnzkeIETzFjSHGPb
 shBuYBhaTugM1OgtxES7TxTi/SzCN3mS/hMPilaBmHk0TAg8MoF64kvJ+n7z+8WllDhx
 AAW0+zB1xhT0lObKRKFabhrxJAJ+RjvomcYh6bFq6juanWOudCq7LiXglEaxQI7fxDia
 slHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sfPk1+u61DN4Dz/z2Pu4rTndUdKhPwDaWZtZBaUU1jg=;
 b=U2+9GcZMUzhW+kG97M7VdlEg9R+5sPpTypB1qqyQagDFsTrSmUTYMSwbocnI1tCoc0
 lnPSdP63rbx1pqKJsHJ7ECWO9l5/ymfguN+0mUrGTJyhn6rn0AtL5J13sjqEW5Bu9Hj7
 b36XUAmokJn7zNnEfBg4uhBeawYdiGlEkZvxnnHToUVh2nztDg5I5A2+O7RJ30c4nkRS
 IlReom1IGS25LOSjprF0G3Q4YgqLd1fhmKmivit35z5jA7DDgehzXQKsrPapxGNpnSX0
 6f3URGZbpXrkKTUw9G80kj6kGI1iIx6zLbaoGeeiviKXzh0MUHkOgmSeQmRUxBX4U6pM
 CySA==
X-Gm-Message-State: AOAM531vcI6duGJEK6DuTj2FRvHopaDD0/Y1JGj2Z3S/IOppT6PfUY1A
 PkLritZsdJbRofrm1kaaCq2mShMZL+QUbDmbuArCbA==
X-Google-Smtp-Source: ABdhPJxLt4Cehy4m7wD0RYUwN5jq18bgpscixR8K5qySY9mHffzEWL0hF8baUYqT7R4HfV0LqTJoVtMk95ufKZmESKg=
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr5976661oif.10.1594419726479; 
 Fri, 10 Jul 2020 15:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-6-john.stultz@linaro.org>
 <20200702141825.GA16941@willie-the-truck>
 <CALAqxLVZ2EhutYjOt7Be1RgnYwHT6-4m6DxA-t1wuxuSy=6yDQ@mail.gmail.com>
 <20200710075411.GA30011@willie-the-truck>
In-Reply-To: <20200710075411.GA30011@willie-the-truck>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 10 Jul 2020 15:21:53 -0700
Message-ID: <CALAqxLWadLrxckRHRAR0Q417RnFKquQJbRfO_DLEVH56cykRow@mail.gmail.com>
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

On Fri, Jul 10, 2020 at 12:54 AM Will Deacon <will@kernel.org> wrote:
> On Thu, Jul 09, 2020 at 08:28:45PM -0700, John Stultz wrote:
> > On Thu, Jul 2, 2020 at 7:18 AM Will Deacon <will@kernel.org> wrote:
> > > On Thu, Jun 25, 2020 at 12:10:39AM +0000, John Stultz wrote:
> > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > index b510f67dfa49..714893535dd2 100644
> > > > --- a/drivers/iommu/Kconfig
> > > > +++ b/drivers/iommu/Kconfig
> > > > @@ -381,6 +381,7 @@ config SPAPR_TCE_IOMMU
> > > >  config ARM_SMMU
> > > >       tristate "ARM Ltd. System MMU (SMMU) Support"
> > > >       depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) && MMU
> > > > +     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> > > >       select IOMMU_API
> > > >       select IOMMU_IO_PGTABLE_LPAE
> > > >       select ARM_DMA_USE_IOMMU if ARM
> > >
> > > This looks like a giant hack. Is there another way to handle this?
> >
> > Sorry for the slow response here.
> >
> > So, I agree the syntax looks strange (requiring a comment obviously
> > isn't a good sign), but it's a fairly common way to ensure drivers
> > don't get built in if they optionally depend on another driver that
> > can be built as a module.
> >   See "RFKILL || !RFKILL", "EXTCON || !EXTCON", or "USB_GADGET ||
> > !USB_GADGET" in various Kconfig files.
> >
> > I'm open to using a different method, and in a different thread you
> > suggested using something like symbol_get(). I need to look into it
> > more, but that approach looks even more messy and prone to runtime
> > failures. Blocking the unwanted case at build time seems a bit cleaner
> > to me, even if the syntax is odd.
>
> Maybe just split it out then, so that the ARM_SMMU entry doesn't have this,
> as that driver _really_ doesn't care about SoC details like this. In other
> words, add a new entry along the lines of:
>
>         config ARM_SMMU_QCOM_IMPL
>         default y
>         #if QCOM_SCM=m this can't be =y
>         depends on ARM_SMMU & (QCOM_SCM || !QCOM_SCM)
>
> and then have arm-smmu.h provide a static inline qcom_smmu_impl_init()
> which returns -ENODEV if CONFIG_ARM_SMMU_QCOM_IMPL=n and hack the Makefile
> so that we don't bother to compile arm-smmu-qcom.o in that case.
>
> Would that work?

I think this proposal still has problems with the directionality of the call.

The arm-smmu-impl.o calls to arm-smmu-qcom.o which calls qcom_scm.o
So if qcom_scm.o is part of a module, the calling code in
arm-smmu-qcom.o also needs to be a module, which means CONFIG_ARM_SMMU
needs to be a module.

I know you said the arm-smmu driver doesn't care about SoC details,
but the trouble is that currently the arm-smmu driver does directly
call the qcom-scm code. So it is a real dependency. However, if
QCOM_SCM is not configured, it calls stubs and that's ok.  In that
way, the "depends on QCOM_SCM || !QCOM_SCM" line actually makes sense.
It looks terrible because we're used to boolean logic, but it's
ternary.

Maybe can have the ARM_SMMU_QCOM_IMPL approach you suggest above, but
that just holds the issue out at arms length, because we're still
going to need to have:
  depends on ARM_SMMU_QCOM_IMPL || !ARM_SMMU_QCOM_IMPL
in the ARM_SMMU definition, which I suspect you're wanting to avoid.

Otherwise the only thing I can think of is a deeper reworking of the
arm-smmu-impl code so that the arm-smmu-qcom code probes itself and
registers its hooks with the arm-smmu core.
That way the arm-smmu driver would not directly call any SoC specific
code (and thus have no dependencies outward). But it's probably a fair
amount of churn vs the extra depends string.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
