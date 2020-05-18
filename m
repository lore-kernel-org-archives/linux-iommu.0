Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6BEC433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:50:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0688207D8
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKIBsRZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0688207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 771E28691E;
	Mon, 18 May 2020 15:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x2v6L66iEyQa; Mon, 18 May 2020 15:50:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F042384A33;
	Mon, 18 May 2020 15:50:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2FB8C0888;
	Mon, 18 May 2020 15:50:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85A60C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8150587DB8
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:50:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W5tjErIyZWIw for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 15:50:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0A0DE87DC8
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:50:11 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id h16so8853865eds.5
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mam0jmHC79p3v1pPEObliIl7gHrMe1XbetijSP5zncI=;
 b=CKIBsRZpRkNM2DDbEI75O6uMEon9GctsfbkrnQTJSoogb19ygIStXRAshUF0c4I+Rn
 91ArQTPD46KbURQ22gY6qmEIkkhxJIZBohLJQEgroA0QMp9vHrbwpU3X4HHDs1l+gp4d
 4jSFDJXSyXFJhcVKJijVmZaQJ6m11lnzI/SVjZO/F52kjZiiHR3s2cc3ErKUJmndJ5N6
 CzwPDMSIJzeh6hdg7YX3FJIhhYTjLinSUYE7CnNVVQW7OV8bb2mV6F4qS8TjRbWS6oCm
 Y8wuubh8LckHgZANHBsAL2uW/BDjWb+XKejPT89jttAzED+dqYcVJOViqAL4g1yFeDyI
 Pqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mam0jmHC79p3v1pPEObliIl7gHrMe1XbetijSP5zncI=;
 b=rwTKvCkteuoLsJIdKSpggyr3pJ9UTcD/H4gu0NKzvG7EbafzLt41WU/CEYE8FbXNJ/
 HRfTvTSqA0/6QqRxxbjLKisRuRpLOz20x8F7PaU62KKbmT3+PaIP/TfoCjappKG9QMx/
 Sd26ATwwjFoDgHPbDVnluIropLg81aPqpef+ckH9Pk6+PPQvSimFyjbP+D3KTK/Z4Mg1
 H0KVek3kcXv3ZGBtpbCCZf1oSuEA/U9tcTIBtHibmPeOa4gGGEq72SW9nAK4I/w+D1hr
 wWLb2x20fmrEMjEzSNR66wYGyHPn3mJv5oAou/ZyhhYkDJVu9QQbA5W1+HxXt0VoIQFC
 ZYfg==
X-Gm-Message-State: AOAM5302dMiM7ukfjKlcn4xpINiXgC3Ko2nCo3tiVv9IXsQYrhP/L0+g
 dG8/9o2yxuKoYtGiY1zM52vzuJpCggMhIdjsZgM=
X-Google-Smtp-Source: ABdhPJwAak2gmrJ75fYqfKG002IIAJ3g+T9yn75xNxFIQ0i05jgSdssvyWPSh4oXD0jc4sg7my3h0ep4LvxCtfrPbVs=
X-Received: by 2002:aa7:c38f:: with SMTP id k15mr482553edq.7.1589817009296;
 Mon, 18 May 2020 08:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
 <1580249770-1088-3-git-send-email-jcrouse@codeaurora.org>
 <20200318224840.GA10796@willie-the-truck>
 <CAF6AEGu-hj6=3rsCe5XeBq_ffoq9VFmL+ycrQ8N=iv89DZf=8Q@mail.gmail.com>
 <20200518151838.GL32394@willie-the-truck>
In-Reply-To: <20200518151838.GL32394@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 18 May 2020 08:50:27 -0700
Message-ID: <CAF6AEGswv3ZaJyy_kYv6FKAjO5=_juDwEtK+VE9TcVMLGvrdwA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] arm/smmu: Add auxiliary domain support for
 arm-smmuv2
To: Will Deacon <will@kernel.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
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

On Mon, May 18, 2020 at 8:18 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Mar 18, 2020 at 04:43:07PM -0700, Rob Clark wrote:
> > On Wed, Mar 18, 2020 at 3:48 PM Will Deacon <will@kernel.org> wrote:
> > > On Tue, Jan 28, 2020 at 03:16:06PM -0700, Jordan Crouse wrote:
> > > > Support auxiliary domains for arm-smmu-v2 to initialize and support
> > > > multiple pagetables for a single SMMU context bank. Since the smmu-v2
> > > > hardware doesn't have any built in support for switching the pagetable
> > > > base it is left as an exercise to the caller to actually use the pagetable.
> > > >
> > > > Aux domains are supported if split pagetable (TTBR1) support has been
> > > > enabled on the master domain.  Each auxiliary domain will reuse the
> > > > configuration of the master domain. By default the a domain with TTBR1
> > > > support will have the TTBR0 region disabled so the first attached aux
> > > > domain will enable the TTBR0 region in the hardware and conversely the
> > > > last domain to be detached will disable TTBR0 translations.  All subsequent
> > > > auxiliary domains create a pagetable but not touch the hardware.
> > > >
> > > > The leaf driver will be able to query the physical address of the
> > > > pagetable with the DOMAIN_ATTR_PTBASE attribute so that it can use the
> > > > address with whatever means it has to switch the pagetable base.
> > > >
> > > > Following is a pseudo code example of how a domain can be created
> > > >
> > > >  /* Check to see if aux domains are supported */
> > > >  if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
> > > >        iommu = iommu_domain_alloc(...);
> > > >
> > > >        if (iommu_aux_attach_device(domain, dev))
> > > >                return FAIL;
> > > >
> > > >       /* Save the base address of the pagetable for use by the driver
> > > >       iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
> > > >  }
> > >
> > > I'm not really understanding what the pagetable base gets used for here and,
> > > to be honest with you, the whole thing feels like a huge layering violation
> > > with the way things are structured today. Why doesn't the caller just
> > > interface with io-pgtable directly?
> > >
> > > Finally, if we need to support context-switching TTBR0 for a live domain
> > > then that code really needs to live inside the SMMU driver because the
> > > ASID and TLB management necessary to do that safely doesn't belong anywhere
> > > else.
> >
> > We do in fact need live domain switching, that is really the whole
> > point.  The GPU CP (command processor/parser) is directly updating
> > TTBR0 and triggering TLB flush, asynchronously from the CPU.
> >
> > And I think the answer about ASID is easy (on current hw).. it must be zero[*].
>
> Using ASID zero is really bad, because it means that you will end up sharing
> TLB entries with whichever device is using context bank 0.
>
> Is the SMMU only used by the GPU in your SoC?
>

yes, the snapdragon SoCs have two SMMU instances, one used by the GPU,
where ASID0/cb0 is the gpu itself, and another cb is the GMU
(basically power control for the gpu), and the second SMMU is
everything else.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
