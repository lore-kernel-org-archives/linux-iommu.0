Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF4AC43467
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 09:14:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA12222275
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 09:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/486wn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA12222275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A09EF86FFD;
	Fri,  9 Oct 2020 09:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pfYyPhOsYx0G; Fri,  9 Oct 2020 09:14:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0CB2986FD8;
	Fri,  9 Oct 2020 09:14:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6234C07FF;
	Fri,  9 Oct 2020 09:14:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22405C0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 09:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0811E876AB
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 09:14:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TfLv4Kk8EhV9 for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 09:14:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 498AF87692
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 09:14:12 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 69DE22227F
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602234851;
 bh=0xH+3LrVqUAaaEwCGyYfsfSUdLpvBCZVWsK1tE5NulE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=b/486wn4gBcqVkVots0e1b2L+moNIL/1+BXGuO/KVA2c1nU2ZuC88JGlLNaWjJ6sd
 py5WNrCgwnoTKUq8xBFyxcU6bjegoWARdpvc4j6Ilu9NPWQK7AMjzPbr5odMlJ3zZN
 vhbojmUv+g+eO3hAsRhMY4BtupcVeNyroVyw9cJU=
Received: by mail-oi1-f173.google.com with SMTP id 16so9482085oix.9
 for <iommu@lists.linux-foundation.org>; Fri, 09 Oct 2020 02:14:11 -0700 (PDT)
X-Gm-Message-State: AOAM532l9V31F+HTHHUfi7p6uX4dvCzRjVZ7kB4Za75cMcaMsHIS//PI
 wraKfVxjZuaJZXhjKzJoliwGHjwb8GKdyXXTTf0=
X-Google-Smtp-Source: ABdhPJyR9YP0v5UuAP6vU7yHLB6OtKX/56Pzuzvc/9hj/0kWVSLN+YUS2NmoZGSpJCDKUxf48Uz5elkd4zugoHvx1CE=
X-Received: by 2002:aca:d845:: with SMTP id p66mr1705863oig.47.1602234850502; 
 Fri, 09 Oct 2020 02:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de> <20201001171500.GN21544@gaia>
 <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia>
 <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de>
 <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
 <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
In-Reply-To: <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Oct 2020 11:13:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
Message-ID: <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, 9 Oct 2020 at 10:36, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Fri, 2020-10-09 at 09:37 +0200, Ard Biesheuvel wrote:
> > On Fri, 9 Oct 2020 at 09:11, Christoph Hellwig <hch@lst.de> wrote:
> > > On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
> > > > Sadly I just realised that the series is incomplete, we have RPi4 users that
> > > > want to boot unsing ACPI, and this series would break things for them. I'll
> > > > have a word with them to see what we can do for their use-case.
> > >
> > > Stupid question:  why do these users insist on a totally unsuitable
> > > interface? And why would we as Linux developers care to support such
> > > a aims?
> >
> > The point is really whether we want to revert changes in Linux that
> > made both DT and ACPI boot work without quirks on RPi4.
>
> Well, and broke a big amount of devices that were otherwise fine.
>

Yeah that was unfortunate.

> > Having to check the RPi4 compatible string or OEM id in core init code is
> > awful, regardless of whether you boot via ACPI or via DT.
> >
> > The problem with this hardware is that it uses a DMA mask which is
> > narrower than 32, and the arm64 kernel is simply not set up to deal
> > with that at all. On DT, we have DMA ranges properties and the likes
> > to describe such limitations, on ACPI we have _DMA methods as well as
> > DMA range attributes in the IORT, both of which are now handled
> > correctly. So all the information is there, we just have to figure out
> > how to consume it early on.
>
> Is it worth the effort just for a single board? I don't know about ACPI but
> parsing dma-ranges that early at boot time is not trivial. My intuition tells
> me that it'd be even harder for ACPI, being a more complex data structure.
>

Yes, it will be harder, especially for the _DMA methods.

> > Interestingly, this limitation always existed in the SoC, but it
> > wasn't until they started shipping it with more than 1 GB of DRAM that
> > it became a problem. This means issues like this could resurface in
> > the future with existing SoCs when they get shipped with more memory,
> > and so I would prefer fixing this in a generic way.
>
> Actually what I proposed here is pretty generic. Specially from arm64's
> perspective. We call early_init_dt_scan(), which sets up zone_dma_bits based on
> whatever it finds in DT. Both those operations are architecture independent.
> arm64 arch code doesn't care about the logic involved in ascertaining
> zone_dma_bits. I get that the last step isn't generic. But it's all setup so as
> to make it as such whenever it's worth the effort.
>

The problem is that, while we are providing a full description of the
SoC's capabilities, we short circuit this by inserting knowledge into
the code (that is shared between all DT architectures) that
"brcm,bcm2711" is special, and needs a DMA zone override.

I think for ACPI boot, we might be able to work around this by cold
plugging the memory above 1 GB, but I have to double check whether it
won't get pulled into ZONE_DMA32 anyway (unless anyone can answer that
for me here from the top of their head)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
