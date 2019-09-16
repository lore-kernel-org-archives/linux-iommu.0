Return-Path: <SRS0=3WiH=XL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02D5C49ED7
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 18:01:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD3320650
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 18:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTJdMMxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD3320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 45C051AE0;
	Mon, 16 Sep 2019 18:01:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 798E51ADC
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 18:00:27 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0743A81A
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 18:00:27 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C557C20830;
	Mon, 16 Sep 2019 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568656826;
	bh=0MuDEueeqiW3vBqPYXeawD+yH0V26W4id32WaUlsst8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTJdMMxm4MH8Vuo2SfpSVaRsGtN9mRmFfEkuKRy89OdziWXWiCDgbMK6SKY/k+ecA
	Kh5+WeWNxsaNtIYz1MwWr9JBUepq1Ardm/RHCa8v8DGRbwqRGFdkYBHL0diVMaYfVc
	Nag18aTsDUASPnJo0glomtDEik/z0OHcN5oc5IaA=
Date: Mon, 16 Sep 2019 19:00:22 +0100
From: Will Deacon <will@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iommu/arm-smmu: Report USF more clearly
Message-ID: <20190916180021.cp2onwou7pbsrygd@willie-the-truck>
References: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
	<CAD=FV=XPi+DCwg2DWbZkXQGTpxWy=vWa1LQR=zHZr93WKjCmzA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=XPi+DCwg2DWbZkXQGTpxWy=vWa1LQR=zHZr93WKjCmzA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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

On Fri, Sep 13, 2019 at 03:44:12PM -0700, Doug Anderson wrote:
> On Fri, Sep 13, 2019 at 4:48 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > Although CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is a welcome tool
> > for smoking out inadequate firmware, the failure mode is non-obvious
> > and can be confusing for end users. Add some special-case reporting of
> > Unidentified Stream Faults to help clarify this particular symptom.
> >
> > CC: Douglas Anderson <dianders@chromium.org>
> 
> nit that I believe that "Cc" (lowercase 2nd c) is correct.
> 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/iommu/arm-smmu.c | 5 +++++
> >  drivers/iommu/arm-smmu.h | 2 ++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index b7cf24402a94..76ac8c180695 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -499,6 +499,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
> >         dev_err_ratelimited(smmu->dev,
> >                 "\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
> >                 gfsr, gfsynr0, gfsynr1, gfsynr2);
> > +       if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> > +           (gfsr & sGFSR_USF))
> > +               dev_err_ratelimited(smmu->dev,
> > +                       "Stream ID %hu may not be described by firmware, try booting with \"arm-smmu.disable_bypass=0\"\n",
> > +                       (u16)gfsynr1);
> 
> In general it seems like a sane idea to surface an error like this.  I
> guess a few nits:
> 
> 1. "By firmware" might be a bit misleading.  In most cases I'm aware
> of the problem is in the device tree that was bundled together with
> the kernel.  If there are actually cases where firmware has baked in a
> device tree and it got this wrong then we might want to spend time
> figuring out what to do about it.

I thought that was usually the way UEFI systems worked, where the kernel
is updated independently of the device-tree? Either way, that should be
what we're aiming for, even if many platforms require the two to be tied
together.

> 2. Presumably booting with "arm-smmu.disable_bypass=0" is in most
> cases the least desirable option available.  I always consider kernel
> command line parameters as something of a last resort for
> configuration and would only be something that and end user might do
> if they were given a kernel compiled by someone else (like if someone
> where taking a prebuilt Linux distro and trying to install it onto a
> generic PC).  Are you seeing cases where this is happening?  If people
> are compiling their own kernel I'd argue that telling them to set
> "CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT" to "no" is much better
> than trying to jam a command line option on.  Command line options
> don't scale well.

Hmm. Recompiling seems like even more of a last resort to me!

> 3. Any chance you could make it more obvious that this change is
> undesirable and a last resort?  AKA:
> 
> "Stream ID x blocked for security reasons; allow anyway by booting
> with arm-smmu.disable_bypass=0"

How about:

  "Blocked transaction from unknown Stream ID x; boot with
   \"arm-smmu.disable_bypass=0\" to allow these transactions, although this
   may have security implications."

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
