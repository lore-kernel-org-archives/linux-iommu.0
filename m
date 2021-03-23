Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6BAC433DB
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 20:00:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FDA619C8
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 20:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FDA619C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2164284136;
	Tue, 23 Mar 2021 20:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6DNBUK91-Qql; Tue, 23 Mar 2021 20:00:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE39C84121;
	Tue, 23 Mar 2021 20:00:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3B78C000D;
	Tue, 23 Mar 2021 20:00:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8CE8C000A
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 20:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB02540527
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 20:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVzdjhymsU7L for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 20:00:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from sibelius.xs4all.nl (sibelius.xs4all.nl [83.163.83.176])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52BD440516
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 20:00:17 +0000 (UTC)
Received: from localhost (bloch.sibelius.xs4all.nl [local])
 by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 7e6c98e9;
 Tue, 23 Mar 2021 21:00:12 +0100 (CET)
Date: Tue, 23 Mar 2021 21:00:12 +0100 (CET)
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: "Sven Peter" <sven@svenpeter.dev>
In-Reply-To: <d280843b-77e3-4fa8-9452-5a2f8a45052e@www.fastmail.com>
 (sven@svenpeter.dev)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
 <c1bcc0be8ae6e500@bloch.sibelius.xs4all.nl>
 <d280843b-77e3-4fa8-9452-5a2f8a45052e@www.fastmail.com>
Message-ID: <c1bcca33753f71d3@bloch.sibelius.xs4all.nl>
Cc: arnd@kernel.org, devicetree@vger.kernel.org, will@kernel.org,
 marcan@marcan.st, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, maz@kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> Date: Mon, 22 Mar 2021 23:17:31 +0100
> From: "Sven Peter" <sven@svenpeter.dev>
> 
> Hi Mark,
> 
> On Sun, Mar 21, 2021, at 19:35, Mark Kettenis wrote:
> >
> > Guess we do need to understand a little bit better how the USB DART
> > actually works.  My hypothesis (based on our discussion on #asahi) is
> > that the XHCI host controller and the peripheral controller of the
> > DWC3 block use different DMA "streams" that are handled by the
> > different sub-DARTs.
> 
> I've done some more experiments and the situation is unfortunately more
> complicated: Most DMA transfers are translated with the first DART.
> But sometimes (and I have not been able to figure out the exact conditions)
> transfers instead have to go through the second DART. 
> This happens e.g. with one of my USB keyboards after a stop EP command
> is issued: Suddenly the xhci_ep_ctx struct must be translated through the
> second DART.
> 
> What this likely means is that we'll need to point both DARTs
> to the same pagetables and just issue the TLB maintenance operations
> as a group.
> 
> > 
> > The Corellium folks use a DART + sub-DART model in their driver and a
> > single node in the device tree that represents both.  That might sense
> > since the error registers and interrupts are shared.  Maybe it would
> > make sense to select the appropriate sub-DART based on the DMA stream
> > ID?
> 
> dwc3 specifically seems to require stream id #1 from the DART
> at <0x5 0x02f00000> and stream id #0 from the DART at <0x5 0x02f80000>.
> Both of these only share a IRQ line but are otherwise completely independent.
> Each has their own error registers, etc. and we need some way to
> specify these two DARTs + the appropriate stream ID.
> 
> Essentially we have three options to represent this now:
> 
> 1) Add both DARTs as separate regs, use #iommu-cells = <2> and have the
>    first cell select the DART and the second one the stream ID.
>    We could allow #iommu-cells = <1> in case only one reg is specified
>    for the PCIe DART:
> 
>    usb_dart1@502f00000 {
>      compatible = "apple,t8103-dart";
>      reg = <0x5 0x02f00000 0x0 0x4000>, <0x5 0x02f80000 0x0 0x4000>;
>      #iommu-cells = <2>;
>      ...
>    };
> 
>    usb1 {
>      iommus = <&usb_dart1 0 1>, <&usb_dart1 1 0>;
>      ...
>    };
> 
>    I prefer this option because we fully describe the DART in a single
>    device node here. It also feels natural to group them like this because
>    they need to share some properties (like dma-window and the interrupt)
>    anyway. 
> 
> 2) Create two DART nodes which share the same IRQ line and attach them
>    both to the master node:
> 
>    usb_dart1a@502f00000 {
>      compatible = "apple,t8103-dart";
>      reg = <0x5 0x02f00000 0x0 0x4000>;
>      #iommu-cells = <1>;
>      ...
>    };
>    usb_dart1b@502f80000 {
>      compatible = "apple,t8103-dart";
>      reg = <0x5 0x02f80000 0x0 0x4000>;
>      #iommu-cells = <1>;
>      ...
>    };
> 
>    usb1 {
>      iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
>      ...
>    };
> 
>    I dislike this one because attaching those two DARTs to a single device
>    seems rather unusual. We'd also have to duplicate the dma-window setting,
>    make sure it's the same for both DARTs and there are probably even more
>    complications I can't think of right now. It seems like this would also
>    make the device tree very verbose and the implementation itself more
>    complicated.
> 
> 3) Introduce another property and let the DART driver take care of
>    mirroring the pagetables. I believe this would be similar to
>    the sid-remap property:
> 
>    usb_dart1@502f00000 {
>      compatible = "apple,t8103-dart";
>      reg = <0x5 0x02f00000 0x0 0x4000>, <0x5 0x02f80000 0x0 0x4000>;
>      #iommu-cells = <1>;
>      sid-remap = <0 1>;
>    };
>    usb1 {
>      iommus = <&usb_dart1 0>;
>    };
> 
>    I slightly dislike this one because we now specify which stream id 
>    to use in two places: Once in the device node and another time in the
>    new property in the DART node. I also don't think the binding is much
>    simpler than the first one.

Hi Sven,

The problem with both #1 and #2 is that you end up with two references
to (effectively) different iommu's in the dwc3 device node.  I don't
see how that is compatible with the idea of using a single translation
table for both sub-DARTs.

If you no longer think that is desirable, you'll still have the
problem that you'll need to modify the dwc3 driver code such that it
uses the right IOMMU to do its DMA address translation.  Given what
you write above that sounds really ugly and confusing.  I would
certainly want to avoid doing that in OpenBSD.

So I think #3 is the only realistic option here.  In my opinion it is
perfectly fine for the devicetree to present a workable model of the
hardware instead of a 100% accurate model.

> > > where #dma-address-cells and #dma-size-cells default to
> > > #address-cells and #size-cells respectively if I understand
> > > the code correctly. That way we could also just always use
> > > a 64bit address and size in the DT, e.g.
> > > 
> > >   pcie_dart {
> > >       [ ... ]
> > >       dma-window = <0 0x100000 0 0x3fe00000>;
> > >       [ ... ]
> > >   };
> > 
> > That sounds like a serious contender to me!  Hopefully one of the
> > Linux kernel developers can give this some sort of blessing.
> > 
> > I think it would make sense for us to just rely on the #address-cells
> > and #size-cells defaults for the M1 device tree.
> >
> 
> Agreed.
> 
> 
> Best,
> 
> Sven
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
