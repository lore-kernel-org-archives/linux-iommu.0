Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF14AC388F7
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 05:54:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257EC22282
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 05:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qbp/oUp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257EC22282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9B6AE20337;
	Wed, 28 Oct 2020 05:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbDWgSDTy0kr; Wed, 28 Oct 2020 05:54:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 47E641FE0A;
	Wed, 28 Oct 2020 05:54:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2920AC0859;
	Wed, 28 Oct 2020 05:54:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67989C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 05:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3FC7920337
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 05:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UOP8xArfGy3Y for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 05:54:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 9377B1FE0A
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 05:54:00 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id c72so3837413oig.9
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 22:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cyg6GxQ7aGb81qvbCIMAVMxTggeWanr2R08/4sn6t1o=;
 b=Qbp/oUp5QTY96Xl+9fGyEj7BDD8Ntl3OjFgxZOrUkX+HGGHN3+g8so2aa8C+yTl9oz
 GR6wK5vCSeupCfxmYnLAWXGnx+32aVMYvvIrOCpLZso2axKsw447co85OgvtdWMpbe8L
 3PEWfGhaSIiWG00RKHUXD7qqCwzpjcIgMydaZU274pRjaR219g+su48SCT1RT3C6bdPw
 of0InmDrAk8osDU7hXLCtd3Cw2RqlDp6sFnUjo+dq/USuWq8RP+lsDVpLSZezfphvbhs
 z1APFV/clS1r7+0FcV+R8Hr1g8mUYDkL7XozwDB1DaqjUhXiWO6DQWxm+u2bDmiqrXfo
 AMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cyg6GxQ7aGb81qvbCIMAVMxTggeWanr2R08/4sn6t1o=;
 b=dEKpdUiC8hfJzjr5QDN7HbryGG3cqEJTiW9z3QMVLW3MRHt1K6KoURUJAe7knDUTDn
 J8lo2pxe8frPb+6IBaWaX+DI3D6/pc8Uwl8Thvq7PwGm/5zjWh1vErXiv+shRJQfWrKd
 5s2ubUCvpFbqxcM0+sM4JFKIRkWccBp4vtiQuBq8pVM9QewviGkNf/FQR2XQCgYEmMOQ
 zhaz8iQ16QOcc0e/52bJaAUTXkmW0rwcB8DJGN37RY4nNL7hU5CcQMQiStyhidPqPLBk
 B0C3ThlCKFal10mSfslFPO7nPQIeu07oecI+u/1Nk0PAWr61DDBh7kIcoIPqo2GVmXV9
 hFyg==
X-Gm-Message-State: AOAM533u+7lJNX89VqdL+4rTBMBrED190FlhPYD50fsk4vMPUtHoLEJS
 DjSnzkQePcgvA2OMXUUATdPAuCz2mGTlp6UGYKNwwQ==
X-Google-Smtp-Source: ABdhPJwFK6CsnkmHO+BIuvRK/KRVa2t3oQuVylL8YPWfyyIxfJPnOIDKRcTsPvp8IeE3+sA/i60PwxYpTSJ7+yq2PVI=
X-Received: by 2002:a05:6808:9b8:: with SMTP id
 e24mr4180101oig.97.1603864439722; 
 Tue, 27 Oct 2020 22:53:59 -0700 (PDT)
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
Date: Tue, 27 Oct 2020 22:53:47 -0700
Message-ID: <CALAqxLUDVEq4ds2Wbic6uaK3=dELKKO4eGQxjHFFz19GeUFd_w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: Will Deacon <will@kernel.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
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

Hey Will,
  Sorry to dredge up this old thread. I've been off busy with other
things and didn't get around to trying to rework this until now.

Unfortunately I'm still having some trouble coming up with a better
solution. Initially I figured I'd rework the qcom_scm driver to, so
that we have the various qcom_scm_* as inline functions, which call
out to function pointers that the qcom_scm driver would register when
the module loaded (Oof, and unfortunately there are a *ton* qcom_scm_*
functions so its a bunch of churn).

The trouble I realized with that approach is that if the ARM_SMMU code
is built in, then it may try to use the qcom_scm code before the
module loads and sets those function pointers. So while it would build
ok, the issue would be when the arm_smmu_device_reset() is done by
done on arm_smmu_device_probe(), it wouldn't actually call the right
code.  There isn't a really good way to deal with the module loading
at some random time after arm_smmu_device_probe() completes.

This is the benefit of the module symbol dependency tracking: If the
arm_smmu.ko calls symbols in qcom_scm.ko then qcom_scm.ko has to load
first.
But if arm_smmu is built in, I haven't found a clear mechanism to
force qcom_scm to load before we probe, if it's configured as a
module.

I also looked into the idea of reworking the arm-smmu-impl code to be
modular instead, and while it does provide a similar method of using
function pointers to minimize the amount of symbols the arm-smmu code
needs to know about, the initialization call path is
arm_smmu_device_probe -> arm_smmu_impl_init -> qcom_smmu_impl_init. So
it doesn't really allow for dynamic registration of implementation
modules at runtime.

So I'm sort of stewing on maybe trying to rework the directionality,
so the arm-smmu-qcom.o code probes and calls arm_smmu_impl_init and
that is what initializes the arm_smmu_device_probe logic?

Alternatively, I'm considering trying to switch the module dependency
annotation so that the CONFIG_QCOM_SCM modularity depends on ARM_SMMU
being a module. But that is sort of putting the restriction on the
callee instead of the caller (sort of flipping the meaning of the
depends), which feels prone to later trouble (and with multiple users
of CONFIG_QCOM_SCM needing similar treatment, it would make it
difficult to discover the right combination of configs needed to allow
it to be a module).

Anyway, I wanted to reach out to see if you had any further ideas
here. Sorry for letting such a large time gap pass!

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
