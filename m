Return-Path: <SRS0=mXGD=IT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA6AC433E0
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 19:38:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330FD6192C
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 19:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330FD6192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E25E7605AC;
	Sun, 21 Mar 2021 19:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HUkh6KNSEW7W; Sun, 21 Mar 2021 19:38:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D73D60586;
	Sun, 21 Mar 2021 19:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C394C000A;
	Sun, 21 Mar 2021 19:38:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36538C0001
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 16:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15B1D403D8
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 16:07:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6zyrrVz2CNJ1 for <iommu@lists.linux-foundation.org>;
 Sun, 21 Mar 2021 16:07:35 +0000 (UTC)
X-Greylist: delayed 00:06:38 by SQLgrey-1.8.0
Received: from sibelius.xs4all.nl (sibelius.xs4all.nl [83.163.83.176])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5D2C403D0
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 16:07:33 +0000 (UTC)
Received: from localhost (bloch.sibelius.xs4all.nl [local])
 by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 94fcbf52;
 Sun, 21 Mar 2021 17:00:50 +0100 (CET)
Date: Sun, 21 Mar 2021 17:00:50 +0100 (CET)
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Sven Peter <sven@svenpeter.dev>
In-Reply-To: <20210320151903.60759-1-sven@svenpeter.dev> (message from Sven
 Peter on Sat, 20 Mar 2021 15:19:33 +0000)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
References: <20210320151903.60759-1-sven@svenpeter.dev>
Message-ID: <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
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

> Date: Sat, 20 Mar 2021 15:19:33 +0000
> From: Sven Peter <sven@svenpeter.dev>
> 
> Hi,
> 
> After Hector's initial work [1] to bring up Linux on Apple's M1 it's time to
> bring up more devices. Most peripherals connected to the SoC are behind a iommu
> which Apple calls "Device Address Resolution Table", or DART for short [2].
> Unfortunately, it only shares the name with PowerPC's DART.
> Configuring this iommu is mandatory if these peripherals require DMA access.
> 
> This patchset implements initial support for this iommu. The hardware itself
> uses a pagetable format that's very similar to the one already implement in
> io-pgtable.c. There are some minor modifications, namely some details of the
> PTE format and that there are always three pagetable levels, which I've
> implement as a new format variant.
> 
> I have mainly tested this with the USB controller in device mode which is
> compatible with Linux's dwc3 driver. Some custom PHY initialization (which is
> not yet ready or fully understood) is required though to bring up the ports,
> see e.g. my patches to our m1n1 bootloader [3,4]. If you want to test the same
> setup you will probably need that branch for now and add the nodes from
> the DT binding specification example to your device tree.
> 
> Even though each DART instances could support up to 16 devices usually only
> a single device is actually connected. Different devices generally just use
> an entirely separate DART instance with a seperate MMIO range, IRQ, etc.
> 
> I have just noticed today though that at least the USB DWC3 controller in host
> mode uses *two* darts at the same time. I'm not sure yet which parts seem to
> require which DART instance.
> 
> This means that we might need to support devices attached to two iommus
> simultaneously and just create the same iova mappings. Currently this only
> seems to be required for USB according to Apple's Device Tree.
> 
> I see two options for this and would like to get feedback before
> I implement either one:
> 
>     1) Change #iommu-cells = <1>; to #iommu-cells = <2>; and use the first cell
>        to identify the DART and the second one to identify the master.
>        The DART DT node would then also take two register ranges that would
>        correspond to the two DARTs. Both instances use the same IRQ and the
>        same clocks according to Apple's device tree and my experiments.
>        This would keep a single device node and the DART driver would then
>        simply map iovas in both DARTs if required.
> 
>     2) Keep #iommu-cells as-is but support
>             iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
>        instead.
>        This would then require two devices nodes for the two DART instances and
>        some housekeeping in the DART driver to support mapping iovas in both
>        DARTs.
>        I believe omap-iommu.c supports this setup but I will have to read
>        more code to understand the details there and figure out how to implement
>        this in a sane way.
> 
> I currently prefer the first option but I don't understand enough details of
> the iommu system to actually make an informed decision.
> I'm obviously also open to more options :-)

Hi Sven,

I don't think the first option is going to work for PCIe.  PCIe
devices will have to use "iommu-map" properties to map PCI devices to
the right iommu, and the currently implementation seems to assume that
#iommu-cells = <1>.  The devictree binding[1] doesn't explicitly state
that it relies on #iommu-cells = <1>, but it isn't clear how the
rid-base to iommu-base mapping mechanism would work when that isn't
the case.

Now the PCIe DARTs are simpler and seem to have only one "instance"
per DART.  So if we keep #iommu-cells = <1> for those, you'd still be
fine using the first approach.

As I mentioned before, not all DARTs support the full 32-bit aperture.
In particular the PCIe DARTs support a smaller address-space.  It is
not clear whether this is a restriction of the PCIe host controller or
the DART, but the Apple Device Tree has "vm-base" and "vm-size"
properties that encode the base address and size of the aperture.
These single-cell properties which is probably why for the USB DARTs
only "vm-base" is given; since "vm-base" is 0, a 32-bit number
wouldn't be able to encode the full aperture size.  We could make them
64-bit numbers in the Linux device tree though and always be explicit
about the size.  Older Sun SPARC machines used a single "virtual-dma"
property to encode the aperture.  We could do someting similar.  You
would use this property to initialize domain->geometry.aperture_start
and domain->geometry.aperture_end in diff 3/3 of this series.

I think it would make sense to include this in this series, as this
would make adding support for PCIe very easy, and PCIe gives you
aupport for network (both wired and wireless) and the type-A USB ports
on the mini.

Cheers,

Mark

[1] Documentation/devicetree/bindings/pci/pci-iommu.txt
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
