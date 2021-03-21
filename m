Return-Path: <SRS0=mXGD=IT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04172C433C1
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 19:38:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C7D6192B
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 19:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C7D6192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1688040284;
	Sun, 21 Mar 2021 19:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T5UFrVUMJb_F; Sun, 21 Mar 2021 19:38:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDDAD40285;
	Sun, 21 Mar 2021 19:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85D60C0011;
	Sun, 21 Mar 2021 19:38:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 271B0C0001
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 18:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06CCC40392
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 18:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 77ZN3gRP_ojI for <iommu@lists.linux-foundation.org>;
 Sun, 21 Mar 2021 18:35:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from sibelius.xs4all.nl (sibelius.xs4all.nl [83.163.83.176])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63265402F3
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 18:35:08 +0000 (UTC)
Received: from localhost (bloch.sibelius.xs4all.nl [local])
 by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 8ad311f2;
 Sun, 21 Mar 2021 19:35:04 +0100 (CET)
Date: Sun, 21 Mar 2021 19:35:04 +0100 (CET)
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: "Sven Peter" <sven@svenpeter.dev>
In-Reply-To: <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
 (sven@svenpeter.dev)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
Message-ID: <c1bcc0be8ae6e500@bloch.sibelius.xs4all.nl>
X-Mailman-Approved-At: Sun, 21 Mar 2021 19:38:46 +0000
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

> Date: Sun, 21 Mar 2021 18:22:15 +0100
> From: "Sven Peter" <sven@svenpeter.dev>
> 
> Hi Mark,
> 
>  On 21. Mar 2021, at 17:00, Mark Kettenis <mark.kettenis@xs4all.nl>
>  wrote:
> 
>  I don't think the first option is going to work for PCIe.  PCIe
>  devices will have to use "iommu-map" properties to map PCI devices to
>  the right iommu, and the currently implementation seems to assume that
>  #iommu-cells = <1>.  The devictree binding[1] doesn't explicitly state
>  that it relies on #iommu-cells = <1>, but it isn't clear how the
>  rid-base to iommu-base mapping mechanism would work when that isn't
>  the case.
> 
>  Now the PCIe DARTs are simpler and seem to have only one "instance"
>  per DART.  So if we keep #iommu-cells = <1> for those, you'd still be
>  fine using the first approach.
> 
> Good point, I guess that only leaves option two for now then.
> Having some DARTs use cells = <1> and others <2> sounds confusing to me.

Guess we do need to understand a little bit better how the USB DART
actually works.  My hypothesis (based on our discussion on #asahi) is
that the XHCI host controller and the peripheral controller of the
DWC3 block use different DMA "streams" that are handled by the
different sub-DARTs.

The Corellium folks use a DART + sub-DART model in their driver and a
single node in the device tree that represents both.  That might sense
since the error registers and interrupts are shared.  Maybe it would
make sense to select the appropriate sub-DART based on the DMA stream
ID?

>  As I mentioned before, not all DARTs support the full 32-bit aperture.
>  In particular the PCIe DARTs support a smaller address-space.  It is
>  not clear whether this is a restriction of the PCIe host controller or
>  the DART, but the Apple Device Tree has "vm-base" and "vm-size"
>  properties that encode the base address and size of the aperture.
>  These single-cell properties which is probably why for the USB DARTs
>  only "vm-base" is given; since "vm-base" is 0, a 32-bit number
>  wouldn't be able to encode the full aperture size.  We could make them
>  64-bit numbers in the Linux device tree though and always be explicit
>  about the size.  Older Sun SPARC machines used a single "virtual-dma"
>  property to encode the aperture.  We could do someting similar.  You
>  would use this property to initialize domain->geometry.aperture_start
>  and domain->geometry.aperture_end in diff 3/3 of this series.
> 
>  I think it would make sense to include this in this series, as this
>  would make adding support for PCIe very easy, and PCIe gives you
>  aupport for network (both wired and wireless) and the type-A USB ports
>  on the mini.
> 
> Agreed, I'd ideally like to converge on a device tree binding
> that won't have to change in the near future.
> 
> I've tried to use an address space larger than 32bit and that seems to
> work for parts of the dwc3 controller but breaks for the xhci parts because
> the upper lines don't seem to be connected there (e.g. if xhci tries to
> use <0x1 0xffff0000> I get a fault for <0 0xffff0000>).
> 
> Looking at other iommu drivers I have found the following two similar
> bindings:

Ah, missed those.

> qcom uses a ranges property with a 64bit address and 32 bit size [1]
> 
>   apps_iommu: iommu@1e20000 {
>       ...
>       ranges = <0 0x1e20000 0x40000>;
>       ...
>   };

Doesn't sound like a very good idea to me to repurpose "ranges" for
this...

> 
> and tegra seems to support a dma-window property with 32bit address
> and size [2]
> 
>   smmu {
>           [...]
>           dma-window = <0 0x40000000>;    /* IOVA start & length */
>           [...]
>   };
> 
> I believe there already is of_get_dma_window to handle parsing this
> in the common iommu code [3] but I can't find any place using it.
> It's a little bit more complex that we need since it allows to specify the
> number of cells for both the address and the size but it should allow us to
> express all possible configurations:
> 
>   usb_dart {
>       [ ... ]
>       #dma-address-cells = <1>;
>       #dma-size-cells = <2>;
>       dma-window = <0 0x1 0x0>;
>       [ ... ]
>   };
>   pcie_dart {
>       [ ... ]
>       #dma-address-cells = <1>;
>       #dma-size-cells = <1>;
>       dma-window = <0x100000 0x3fe00000>;
>       [ ... ]
>   };
> 
> where #dma-address-cells and #dma-size-cells default to
> #address-cells and #size-cells respectively if I understand
> the code correctly. That way we could also just always use
> a 64bit address and size in the DT, e.g.
> 
>   pcie_dart {
>       [ ... ]
>       dma-window = <0 0x100000 0 0x3fe00000>;
>       [ ... ]
>   };

That sounds like a serious contender to me!  Hopefully one of the
Linux kernel developers can give this some sort of blessing.

I think it would make sense for us to just rely on the #address-cells
and #size-cells defaults for the M1 device tree.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
