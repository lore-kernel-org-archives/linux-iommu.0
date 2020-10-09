Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2701C43467
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 16:23:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D5722280
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 16:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHzil1eZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D5722280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ECAAD8779E;
	Fri,  9 Oct 2020 16:23:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uU0-LAqdVcJB; Fri,  9 Oct 2020 16:23:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EF50D87756;
	Fri,  9 Oct 2020 16:23:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2A28C016F;
	Fri,  9 Oct 2020 16:23:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4000C0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AC7FE873F4
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uTVPIVyg9seH for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 16:23:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 03207873E6
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:23:18 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9BCBC22276
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602260598;
 bh=rcWPntVjqZSc5hJ15zFPyq+jUVkmYuHDgZvOJEQF/FM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gHzil1eZAhZHldUU3uMMLfFFX4VZoKF3w57p0hZ2WvNmYleNR3PKCr9/3KeHeF8qW
 X3JFVGt2Ft4xJ3lAGJDGpbHTAv10cvFt8z6oEVl34uJStLJuKZ4gWei5pfvTXcL46d
 MzGwhkDOcps3C3Au9oADB2PG28zx+a3NsUCZROMw=
Received: by mail-ot1-f47.google.com with SMTP id q21so9481113ota.8
 for <iommu@lists.linux-foundation.org>; Fri, 09 Oct 2020 09:23:18 -0700 (PDT)
X-Gm-Message-State: AOAM530VPLnkM0h/2RdELEZ04MXx2Gu46k9ov4+G8OuffibyW5WU59yj
 KBYnAbEtNBpGAl01PtKrbh+zThpPIZfn6hKfhY4=
X-Google-Smtp-Source: ABdhPJxEUPxLcPLTHNLZzaEqR9po2Cnlj1wMEbpvsUQ41ZfzOV12+IuP6fH3DpAWfaLTRJi7lCtulLnW33hOJJ5vW0E=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr9911291otq.77.1602260597965;
 Fri, 09 Oct 2020 09:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201001161740.29064-2-nsaenzjulienne@suse.de>
 <20201001171500.GN21544@gaia> <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia>
 <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de>
 <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
 <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
 <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
 <20201009152433.GA19953@e121166-lin.cambridge.arm.com>
In-Reply-To: <20201009152433.GA19953@e121166-lin.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Oct 2020 18:23:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuqw3qNRAB78OzvMws+t7=B6L8pASA36D2fxXobbvpUA@mail.gmail.com>
Message-ID: <CAMj1kXFuqw3qNRAB78OzvMws+t7=B6L8pASA36D2fxXobbvpUA@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
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

On Fri, 9 Oct 2020 at 17:24, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Oct 09, 2020 at 11:13:59AM +0200, Ard Biesheuvel wrote:
> > On Fri, 9 Oct 2020 at 10:36, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > >
> > > On Fri, 2020-10-09 at 09:37 +0200, Ard Biesheuvel wrote:
> > > > On Fri, 9 Oct 2020 at 09:11, Christoph Hellwig <hch@lst.de> wrote:
> > > > > On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
> > > > > > Sadly I just realised that the series is incomplete, we have RPi4 users that
> > > > > > want to boot unsing ACPI, and this series would break things for them. I'll
> > > > > > have a word with them to see what we can do for their use-case.
> > > > >
> > > > > Stupid question:  why do these users insist on a totally unsuitable
> > > > > interface? And why would we as Linux developers care to support such
> > > > > a aims?
> > > >
> > > > The point is really whether we want to revert changes in Linux that
> > > > made both DT and ACPI boot work without quirks on RPi4.
> > >
> > > Well, and broke a big amount of devices that were otherwise fine.
> > >
> >
> > Yeah that was unfortunate.
> >
> > > > Having to check the RPi4 compatible string or OEM id in core init code is
> > > > awful, regardless of whether you boot via ACPI or via DT.
> > > >
> > > > The problem with this hardware is that it uses a DMA mask which is
> > > > narrower than 32, and the arm64 kernel is simply not set up to deal
> > > > with that at all. On DT, we have DMA ranges properties and the likes
> > > > to describe such limitations, on ACPI we have _DMA methods as well as
> > > > DMA range attributes in the IORT, both of which are now handled
> > > > correctly. So all the information is there, we just have to figure out
> > > > how to consume it early on.
> > >
> > > Is it worth the effort just for a single board? I don't know about ACPI but
> > > parsing dma-ranges that early at boot time is not trivial. My intuition tells
> > > me that it'd be even harder for ACPI, being a more complex data structure.
> > >
> >
> > Yes, it will be harder, especially for the _DMA methods.
> >
> > > > Interestingly, this limitation always existed in the SoC, but it
> > > > wasn't until they started shipping it with more than 1 GB of DRAM that
> > > > it became a problem. This means issues like this could resurface in
> > > > the future with existing SoCs when they get shipped with more memory,
> > > > and so I would prefer fixing this in a generic way.
> > >
> > > Actually what I proposed here is pretty generic. Specially from arm64's
> > > perspective. We call early_init_dt_scan(), which sets up zone_dma_bits based on
> > > whatever it finds in DT. Both those operations are architecture independent.
> > > arm64 arch code doesn't care about the logic involved in ascertaining
> > > zone_dma_bits. I get that the last step isn't generic. But it's all setup so as
> > > to make it as such whenever it's worth the effort.
> > >
> >
> > The problem is that, while we are providing a full description of the
> > SoC's capabilities, we short circuit this by inserting knowledge into
> > the code (that is shared between all DT architectures) that
> > "brcm,bcm2711" is special, and needs a DMA zone override.
> >
> > I think for ACPI boot, we might be able to work around this by cold
> > plugging the memory above 1 GB, but I have to double check whether it
> > won't get pulled into ZONE_DMA32 anyway (unless anyone can answer that
> > for me here from the top of their head)
>
> Is this information that we can infer from IORT nodes and make it
> generic (ie make a DMA limit out of all IORT nodes allowed ranges) ?
>

Yes, that seems feasible.

> We can move this check to IORT code and call it from arm64 if it
> can be made to work.
>

Finding the smallest value in the IORT, and assigning it to
zone_dma_bits if it is < 32 should be easy. But as I understand it,
having these separate DMA and DMA32 zones is what breaks kdump, no? So
how is this going to fix the underlying issue?

Nicolas, were there any other reported regressions caused by the
introduction of ZONE_DMA?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
