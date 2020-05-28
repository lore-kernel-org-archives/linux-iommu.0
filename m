Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBBC433E0
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 07:23:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B88207D3
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 07:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InkK/rSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B88207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E8A288902;
	Thu, 28 May 2020 07:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cjMyoDD1+425; Thu, 28 May 2020 07:23:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9B419888F8;
	Thu, 28 May 2020 07:23:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C52CC07FF;
	Thu, 28 May 2020 07:23:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21172C016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0FD7386F27
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wwbnEJFslfaZ for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 07:23:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0B6FB86CFC
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:23:20 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c3so22501323wru.12
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=InMY+h5ju9g703H9YoEbGSFTkbcU+ukgyE+S56GkWPQ=;
 b=InkK/rSxsKaXdelob3M9cLlDBs0rBgXO01aMVn+eolm1ZVjzSM/VFqFf0BEklasJ/r
 GhCYSaB7q6gUmorWkhp7TKZJWqFYVTgS6U9J4RREm6EqNDN3fyDSdJwGebDOdSZ1Ohx9
 U8xQ4T0y5f2immgl9HESQWs6lGorq59FvI9mf7psfXQ4yXdvyBwsygNgnJcnOQgwwu4X
 HAXlYvBmywIc4RPS3wu2xVkQjUFpyyWnqnTVHxPL1kys/V/pNFZasZ9CY8hWpBaNaU26
 n7MHfb4aMwxtUKNWuWc+6WFRvIOND8W9m+ZUUs8uH7lqLZIBp6P6c1rJrn9kXp6n0Dsi
 g5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=InMY+h5ju9g703H9YoEbGSFTkbcU+ukgyE+S56GkWPQ=;
 b=jXHs30OUhbCPujtiXQfisep1uENSfz9VhNOFkBzBsvMpjbaEuOhdYP6U8rU03Ke1jS
 67MwOZmqDXqJtYiZbXTB2+QPkESMH19aqseVEsxx1PT75brFsLWl+8wQSqEIRDwUiLEl
 9pUbr2qZPv4zuRQ2A9PnMXvc5MdMqDqLqyjsNLcpha0ZfNJTHWtMV6WJqfvUhK/cB5WM
 LL2r94KRozYdmxZuK0zW7sE1i6hcEh0QeAcJSs66T9vJZR9Rfn2pra7e9yrUPdlT4E+L
 VXfW682NYezXw77uUzcRyrQntY0XVZboPUlpQH72usvqrKvJKsm9nhNknQpLiUUABySV
 +T5A==
X-Gm-Message-State: AOAM532jCGePj4/DYDGwYWtpuItkiddY0UOYkYMJVcI/COYH7mZ62dAL
 nd2ZVNIie7S2laFW4wwpjZFkUQ==
X-Google-Smtp-Source: ABdhPJzbxhctxMitxiFf0Xa9UQ0ZNCLBt5Yq1k8xkh8j+rzSxQW9LrEIGrMpovuh+jBZfCOXmELMRg==
X-Received: by 2002:adf:c391:: with SMTP id p17mr2036035wrf.243.1590650598769; 
 Thu, 28 May 2020 00:23:18 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id j18sm5243997wrn.59.2020.05.28.00.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 00:23:18 -0700 (PDT)
Date: Thu, 28 May 2020 09:23:08 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova
 address
Message-ID: <20200528072308.GA414784@myrica>
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
 <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
 <CABe79T7WwD2AyWp2e5pAi8TO2r5=-v5gPb2Gjtf8EhHOn3dogQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABe79T7WwD2AyWp2e5pAi8TO2r5=-v5gPb2Gjtf8EhHOn3dogQ@mail.gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Thu, May 28, 2020 at 10:45:14AM +0530, Srinath Mannam wrote:
> On Wed, May 27, 2020 at 11:00 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> Thanks Robin for your quick response.
> > On 2020-05-27 17:03, Srinath Mannam wrote:
> > > This patch gives the provision to change default value of MSI IOVA base
> > > to platform's suitable IOVA using module parameter. The present
> > > hardcoded MSI IOVA base may not be the accessible IOVA ranges of platform.
> >
> > That in itself doesn't seem entirely unreasonable; IIRC the current
> > address is just an arbitrary choice to fit nicely into Qemu's memory
> > map, and there was always the possibility that it wouldn't suit everything.
> >
> > > Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible
> > > DMA address"), inaccessible IOVA address ranges parsed from dma-ranges
> > > property are reserved.

I don't understand why we only reserve the PCIe windows for DMA domains.
Shouldn't VFIO also prevent userspace from mapping them?  If they were
part of the common reserved regions then we could have VFIO choose a
SW_MSI region among the remaining free space. It would just need a
different way of asking the IOMMU driver if a SW_MSI is needed, for
example with a domain attribute.

Thanks,
Jean

> >
> > That, however, doesn't seem to fit here; iommu-dma maps MSI doorbells
> > dynamically, so they aren't affected by reserved regions any more than
> > regular DMA pages are. In fact, it explicitly ignores the software MSI
> > region, since as the comment says, it *is* the software that manages those.
> Yes you are right, we don't see any issues with kernel drivers(PCI EP) because
> MSI IOVA allocated dynamically by honouring reserved regions same as DMA pages.
> >
> > The MSI_IOVA_BASE region exists for VFIO, precisely because in that case
> > the kernel *doesn't* control the address space, but still needs some way
> > to steal a bit of it for MSIs that the guest doesn't necessarily know
> > about, and give userspace a fighting chance of knowing what it's taken.
> > I think at the time we discussed the idea of adding something to the
> > VFIO uapi such that userspace could move this around if it wanted or
> > needed to, but decided we could live without that initially. Perhaps now
> > the time has come?
> Yes, we see issues only with user-space drivers(DPDK) in which MSI_IOVA_BASE
> region is considered to map MSI registers. This patch helps us to fix the issue.
> 
> Thanks,
> Srinath.
> >
> > Robin.
> >
> > > If any platform has the limitaion to access default MSI IOVA, then it can
> > > be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
> > >
> > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > ---
> > >   drivers/iommu/arm-smmu.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index 4f1a350..5e59c9d 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -72,6 +72,9 @@ static bool disable_bypass =
> > >   module_param(disable_bypass, bool, S_IRUGO);
> > >   MODULE_PARM_DESC(disable_bypass,
> > >       "Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> > > +static unsigned long msi_iova_base = MSI_IOVA_BASE;
> > > +module_param(msi_iova_base, ulong, S_IRUGO);
> > > +MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
> > >
> > >   struct arm_smmu_s2cr {
> > >       struct iommu_group              *group;
> > > @@ -1566,7 +1569,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
> > >       struct iommu_resv_region *region;
> > >       int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > >
> > > -     region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> > > +     region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
> > >                                        prot, IOMMU_RESV_SW_MSI);
> > >       if (!region)
> > >               return;
> > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
