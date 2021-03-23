Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCF8C433DB
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 20:53:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DCD619BF
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 20:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DCD619BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 603AE8414E;
	Tue, 23 Mar 2021 20:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5BDnUfXbroe1; Tue, 23 Mar 2021 20:53:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B6C784119;
	Tue, 23 Mar 2021 20:53:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 152DCC000E;
	Tue, 23 Mar 2021 20:53:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66016C000A
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 20:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F0AF6059D
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 20:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f7Lf38yqXQzk for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 20:53:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com
 [209.85.166.182])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D3E860661
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 20:53:49 +0000 (UTC)
Received: by mail-il1-f182.google.com with SMTP id y17so7778786ila.6
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 13:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PHYJdMOhlozVGJVh1oALPNAZWOy/E29w1l72RoruR20=;
 b=Mmcb8LAOqb2eRLblBUCSjXZal5nItBuiriluXxBXVRjnduGpkgNe1vLzSraT2LJtut
 7gCE0JqwIl2OrWEKg3tPjgK+gQ5gztXUdj8CUVDy4u8voTWcjpQE2DtWCWewDgopQaRK
 abxLWn6H4VMFhnvE80Hejnak7GG+6eOn9FeyH6t+QsGQHoDCs+c4B84DE1Rc0/ZKt2hU
 M+kBa9PytMhsC7F56AFnIDCEM3DVInMDSLb4QAnTh15BZfC+UPHnzxu1krLF2sEGOeNu
 X6w0Jib41hbmOgdRW5qbvohOFDXbIXHWdahiUpuOq4SPMff6sF1Bqc/J6y9knf7reOqW
 2bxg==
X-Gm-Message-State: AOAM533wbT2jvbacOkCl6XbQwEmiTjdYIEQCn5JLcgkk0piHUMjUiOTb
 JMWZ2q2MEJPfeMOtQU5+mw==
X-Google-Smtp-Source: ABdhPJwAkhqmMD7d8QqODSssQ97V2pFypdhqwqehElXuGTHngBGyJOmgjnNRf8y1zQyPvSz1qRMvEA==
X-Received: by 2002:a05:6e02:158c:: with SMTP id
 m12mr75161ilu.121.1616532828308; 
 Tue, 23 Mar 2021 13:53:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id d3sm11345ilo.32.2021.03.23.13.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Mar 2021 13:53:47 -0700 (PDT)
Received: (nullmailer pid 1302881 invoked by uid 1000);
 Tue, 23 Mar 2021 20:53:46 -0000
Date: Tue, 23 Mar 2021 14:53:46 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Message-ID: <20210323205346.GA1283560@robh.at.kernel.org>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
Cc: arnd@kernel.org, Sven Peter <sven@svenpeter.dev>,
 devicetree@vger.kernel.org, will@kernel.org, marcan@marcan.st,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, maz@kernel.org,
 mohamed.mediouni@caramail.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, stan@corellium.com
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

On Sun, Mar 21, 2021 at 05:00:50PM +0100, Mark Kettenis wrote:
> > Date: Sat, 20 Mar 2021 15:19:33 +0000
> > From: Sven Peter <sven@svenpeter.dev>
> > 
> > Hi,
> > 
> > After Hector's initial work [1] to bring up Linux on Apple's M1 it's time to
> > bring up more devices. Most peripherals connected to the SoC are behind a iommu
> > which Apple calls "Device Address Resolution Table", or DART for short [2].
> > Unfortunately, it only shares the name with PowerPC's DART.
> > Configuring this iommu is mandatory if these peripherals require DMA access.
> > 
> > This patchset implements initial support for this iommu. The hardware itself
> > uses a pagetable format that's very similar to the one already implement in
> > io-pgtable.c. There are some minor modifications, namely some details of the
> > PTE format and that there are always three pagetable levels, which I've
> > implement as a new format variant.
> > 
> > I have mainly tested this with the USB controller in device mode which is
> > compatible with Linux's dwc3 driver. Some custom PHY initialization (which is
> > not yet ready or fully understood) is required though to bring up the ports,
> > see e.g. my patches to our m1n1 bootloader [3,4]. If you want to test the same
> > setup you will probably need that branch for now and add the nodes from
> > the DT binding specification example to your device tree.
> > 
> > Even though each DART instances could support up to 16 devices usually only
> > a single device is actually connected. Different devices generally just use
> > an entirely separate DART instance with a seperate MMIO range, IRQ, etc.
> > 
> > I have just noticed today though that at least the USB DWC3 controller in host
> > mode uses *two* darts at the same time. I'm not sure yet which parts seem to
> > require which DART instance.
> > 
> > This means that we might need to support devices attached to two iommus
> > simultaneously and just create the same iova mappings. Currently this only
> > seems to be required for USB according to Apple's Device Tree.
> > 
> > I see two options for this and would like to get feedback before
> > I implement either one:
> > 
> >     1) Change #iommu-cells = <1>; to #iommu-cells = <2>; and use the first cell
> >        to identify the DART and the second one to identify the master.
> >        The DART DT node would then also take two register ranges that would
> >        correspond to the two DARTs. Both instances use the same IRQ and the
> >        same clocks according to Apple's device tree and my experiments.
> >        This would keep a single device node and the DART driver would then
> >        simply map iovas in both DARTs if required.
> > 
> >     2) Keep #iommu-cells as-is but support
> >             iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
> >        instead.
> >        This would then require two devices nodes for the two DART instances and
> >        some housekeeping in the DART driver to support mapping iovas in both
> >        DARTs.
> >        I believe omap-iommu.c supports this setup but I will have to read
> >        more code to understand the details there and figure out how to implement
> >        this in a sane way.
> > 
> > I currently prefer the first option but I don't understand enough details of
> > the iommu system to actually make an informed decision.

Please don't mix what does the h/w look like and what's easy to 
implement in Linux's IOMMU subsytem. It's pretty clear (at least 
from the description here) that option 2 reflects the h/w. 

> > I'm obviously also open to more options :-)
> 
> Hi Sven,
> 
> I don't think the first option is going to work for PCIe.  PCIe
> devices will have to use "iommu-map" properties to map PCI devices to
> the right iommu, and the currently implementation seems to assume that
> #iommu-cells = <1>.  The devictree binding[1] doesn't explicitly state
> that it relies on #iommu-cells = <1>, but it isn't clear how the
> rid-base to iommu-base mapping mechanism would work when that isn't
> the case.
> 
> Now the PCIe DARTs are simpler and seem to have only one "instance"
> per DART.  So if we keep #iommu-cells = <1> for those, you'd still be
> fine using the first approach.
> 
> As I mentioned before, not all DARTs support the full 32-bit aperture.
> In particular the PCIe DARTs support a smaller address-space.  It is
> not clear whether this is a restriction of the PCIe host controller or
> the DART, but the Apple Device Tree has "vm-base" and "vm-size"
> properties that encode the base address and size of the aperture.
> These single-cell properties which is probably why for the USB DARTs
> only "vm-base" is given; since "vm-base" is 0, a 32-bit number
> wouldn't be able to encode the full aperture size.  We could make them
> 64-bit numbers in the Linux device tree though and always be explicit
> about the size.  Older Sun SPARC machines used a single "virtual-dma"
> property to encode the aperture.  We could do someting similar.  You
> would use this property to initialize domain->geometry.aperture_start
> and domain->geometry.aperture_end in diff 3/3 of this series.

'dma-ranges' is what should be used here.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
