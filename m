Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864E7C433E4
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 14:10:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD4E207DD
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 14:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/oY63OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD4E207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1D75822865;
	Thu, 16 Jul 2020 14:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sUA2hYzLOVgc; Thu, 16 Jul 2020 14:10:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DE0572264C;
	Thu, 16 Jul 2020 14:10:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2930C0893;
	Thu, 16 Jul 2020 14:10:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D118C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 14:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2665D8885E
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 14:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rqNUBeLMrXSW for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 14:10:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 989EF888EE
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 14:10:12 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id p20so6664123ejd.13
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UgByZr2tdGXMxqTrpo6Qkdxy8e0b0j8qrLrKzyPeff4=;
 b=p/oY63OM+jm2WcLptMiuLRuvaLTNDJmdQ/usKdVo5BQ2xnnssf+08/52kx3SBxP7Y3
 I47BFQ3ap6TYnx/2SbzKSeaghmr1JlKhjgMB2gECCOTUXVuRqY3qYqlFDpx63eV9Kd9v
 k+yZoMOvct+w+jptYyDvwmFbIfP5gXFnp+bAG8MaeZvMVxGZpqG8vZ2obkaDb8nu+nHm
 kBYZtuaFIGRbH/GkbGUfwFWXsCtYIV3RxDWgSFlSmtAH6OXNgsvRF5d4RqklcxD092Gw
 vrF7juWcsMx/odaCP1UN3JQWRXNWhAP5y16WC13irLPuEXdTsRf1ehSNCrxLTT9+ogdJ
 6oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UgByZr2tdGXMxqTrpo6Qkdxy8e0b0j8qrLrKzyPeff4=;
 b=tjMp9IcugtCsCIY/Ott5oPHoZPWfJOAypwERruCYYgF9irqNc0gGG6gjzAD4ZAABN4
 KeDFy8XOK1zgBkgEo8R0BTmarVYdNHqIpOj3V07QnhuaMfqE0XMEBDqDpbGe9QGDKdfs
 e4YJfrnoo4J5mfwJjKzc59ZWPCVIlrHMepFaFlHFR4IyDkwt41x1s/kW/nEJFRvj56Vr
 zF5plb0PdBNSnJ978paUk7zr0OGC+KAmn7SB022W4yD/ChrV1b2TDZkm3Yv8ryMQ57x6
 fsChU2Y9uTHCo5TOVOLiKIV2pm5ltDmsfMDUoZkwPlRXmJU4donpXxO3cRNYnE4vPdMK
 ew8g==
X-Gm-Message-State: AOAM533UhlUTEgR4cESV6JF7SNnQ0uUu2ruS9e6tKg8DSyOIGwm9MVeO
 HnSKPX9h6xfeH1p1d8Iht/kUEQaRBBZgBHaNQAo=
X-Google-Smtp-Source: ABdhPJyz8imIlovqA4rnHstW4ckjKTIH95Kru8h/9+b4cY5spXHzvx8IM2dpEFBVY9OsnhnhxXdZW6/cN3g6oedlr7k=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr3973061ejw.71.1594908610972; 
 Thu, 16 Jul 2020 07:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
 <20200626200042.13713-5-jcrouse@codeaurora.org>
 <20200713150901.GA3072@willie-the-truck>
 <20200713171917.GA3815@jcrouse1-lnx.qualcomm.com>
 <20200716085053.GB6771@willie-the-truck>
In-Reply-To: <20200716085053.GB6771@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 16 Jul 2020 07:10:43 -0700
Message-ID: <CAF6AEGtf2Ts5_S-3DDA0i_ega-MjJK5tyy=peW6ar0c1ZD72Rw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v9 4/7] iommu/arm-smmu: Add a pointer to the
 attached device to smmu_domain
To: Will Deacon <will@kernel.org>
Cc: freedreno <freedreno@lists.freedesktop.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 John Stultz <john.stultz@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Thu, Jul 16, 2020 at 1:51 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jul 13, 2020 at 11:19:17AM -0600, Jordan Crouse wrote:
> > On Mon, Jul 13, 2020 at 04:09:02PM +0100, Will Deacon wrote:
> > > On Fri, Jun 26, 2020 at 02:00:38PM -0600, Jordan Crouse wrote:
> > > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > > index 5f2de20e883b..d33cfe26b2f5 100644
> > > > --- a/drivers/iommu/arm-smmu.h
> > > > +++ b/drivers/iommu/arm-smmu.h
> > > > @@ -345,6 +345,7 @@ struct arm_smmu_domain {
> > > >   struct mutex                    init_mutex; /* Protects smmu pointer */
> > > >   spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
> > > >   struct iommu_domain             domain;
> > > > + struct device                   *dev;   /* Device attached to this domain */
> > >
> > > This really doesn't feel right to me -- you can generally have multiple
> > > devices attached to a domain and they can come and go without the domain
> > > being destroyed. Perhaps you could instead identify the GPU during
> > > cfg_probe() and squirrel that information away somewhere?
> >
> > I need some help here. The SMMU device (qcom,adreno-smmu) will have at least two
> > stream ids from two different platform devices (GPU and GMU) and I need to
> > configure split-pagetable and stall/terminate differently on the two domains.
>
> Hmm. How does the GPU driver know which context bank is assigned to the GPU
> and which one is assigned to the GMU? I assume it needs this information so
> that it can play its nasty tricks with the TTBR registers?
>
> I ask because if we need to guarantee stability of the context-bank
> assignment, then you could match on that in the ->init_context() callback,
> but now I worry that it currently works by luck :/

Yeah, it is basically by luck right now.. some sort of impl callback
which was passed the dev into impl->init_context() might do the trick
(ie. then the impl could match on compat string)

BR,
-R

> Do we need to add an extra callback to allocate the context bank?
>
> Will
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
