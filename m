Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E28C433E2
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 07:54:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3032078D
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 07:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUWC9jE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3032078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 899F9898D7;
	Fri, 10 Jul 2020 07:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rTnHKJ8ZRQml; Fri, 10 Jul 2020 07:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 016E888DA6;
	Fri, 10 Jul 2020 07:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2D84C077B;
	Fri, 10 Jul 2020 07:54:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2969CC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 07:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0FBAB894A9
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 07:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MIdapeS9yDwr for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 07:54:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8974788DA6
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 07:54:18 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A68C2077D;
 Fri, 10 Jul 2020 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594367658;
 bh=+CLcnOoiP11vbaLWEE7x8Qo9XjfxI8bf98D7jhYvsTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sUWC9jE9AeBrFenvWyUJ08C2OMyYdCth41lSdl+CQ2V8fdS58LUZAE5I1XadKMOEA
 keKID3B78XHkVhh2GKuELnZE3cw3xCKznbwgYEWS5MBQv6Uy9xrKR+Pp2oPgoouL2v
 gC+YoTwxB9rnjYdo2Ut08PPTzS7aCibv0NhI0Xe8=
Date: Fri, 10 Jul 2020 08:54:12 +0100
From: Will Deacon <will@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2 5/5] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
Message-ID: <20200710075411.GA30011@willie-the-truck>
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-6-john.stultz@linaro.org>
 <20200702141825.GA16941@willie-the-truck>
 <CALAqxLVZ2EhutYjOt7Be1RgnYwHT6-4m6DxA-t1wuxuSy=6yDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALAqxLVZ2EhutYjOt7Be1RgnYwHT6-4m6DxA-t1wuxuSy=6yDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Thu, Jul 09, 2020 at 08:28:45PM -0700, John Stultz wrote:
> On Thu, Jul 2, 2020 at 7:18 AM Will Deacon <will@kernel.org> wrote:
> > On Thu, Jun 25, 2020 at 12:10:39AM +0000, John Stultz wrote:
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index b510f67dfa49..714893535dd2 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -381,6 +381,7 @@ config SPAPR_TCE_IOMMU
> > >  config ARM_SMMU
> > >       tristate "ARM Ltd. System MMU (SMMU) Support"
> > >       depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) && MMU
> > > +     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> > >       select IOMMU_API
> > >       select IOMMU_IO_PGTABLE_LPAE
> > >       select ARM_DMA_USE_IOMMU if ARM
> >
> > This looks like a giant hack. Is there another way to handle this?
> 
> Sorry for the slow response here.
> 
> So, I agree the syntax looks strange (requiring a comment obviously
> isn't a good sign), but it's a fairly common way to ensure drivers
> don't get built in if they optionally depend on another driver that
> can be built as a module.
>   See "RFKILL || !RFKILL", "EXTCON || !EXTCON", or "USB_GADGET ||
> !USB_GADGET" in various Kconfig files.
> 
> I'm open to using a different method, and in a different thread you
> suggested using something like symbol_get(). I need to look into it
> more, but that approach looks even more messy and prone to runtime
> failures. Blocking the unwanted case at build time seems a bit cleaner
> to me, even if the syntax is odd.

Maybe just split it out then, so that the ARM_SMMU entry doesn't have this,
as that driver _really_ doesn't care about SoC details like this. In other
words, add a new entry along the lines of:

	config ARM_SMMU_QCOM_IMPL
	default y
	#if QCOM_SCM=m this can't be =y
	depends on ARM_SMMU & (QCOM_SCM || !QCOM_SCM)

and then have arm-smmu.h provide a static inline qcom_smmu_impl_init()
which returns -ENODEV if CONFIG_ARM_SMMU_QCOM_IMPL=n and hack the Makefile
so that we don't bother to compile arm-smmu-qcom.o in that case.

Would that work?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
