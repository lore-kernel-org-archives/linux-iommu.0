Return-Path: <SRS0=zuxH=IW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DIET_1,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A299C433C1
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 15:29:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBEC61992
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 15:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBEC61992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CFCC84965;
	Wed, 24 Mar 2021 15:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7giJ-T0emsUB; Wed, 24 Mar 2021 15:29:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BDF184957;
	Wed, 24 Mar 2021 15:29:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40DA0C000E;
	Wed, 24 Mar 2021 15:29:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CE8EC000A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 15:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35D5A4011B
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 15:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dEYCvl5E61X4 for <iommu@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 15:29:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id E36FC400A4
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 15:29:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC90D6E;
 Wed, 24 Mar 2021 08:29:45 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3053F7D7;
 Wed, 24 Mar 2021 08:29:42 -0700 (PDT)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
To: Sven Peter <sven@svenpeter.dev>, iommu@lists.linux-foundation.org
References: <20210320151903.60759-1-sven@svenpeter.dev>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9b9d771a-f6d4-2d27-7516-f5b8315909ed@arm.com>
Date: Wed, 24 Mar 2021 15:29:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210320151903.60759-1-sven@svenpeter.dev>
Content-Language: en-GB
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Kettenis <mark.kettenis@xs4all.nl>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-03-20 15:19, Sven Peter wrote:
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
>      1) Change #iommu-cells = <1>; to #iommu-cells = <2>; and use the first cell
>         to identify the DART and the second one to identify the master.
>         The DART DT node would then also take two register ranges that would
>         correspond to the two DARTs. Both instances use the same IRQ and the
>         same clocks according to Apple's device tree and my experiments.
>         This would keep a single device node and the DART driver would then
>         simply map iovas in both DARTs if required.

This is broadly similar to the approach used by rockchip-iommu and the 
special arm-smmu-nvidia implementation, where there are multiple 
instances which require programming identically, that are abstracted 
behind a single "device". Your case is a little different since you're 
not programming both *entirely* identically, although maybe that's a 
possibility if each respective ID isn't used by anything else on the 
"other" DART?

Overall I tend to view this approach as a bit of a hack because it's not 
really describing the hardware truthfully - just because two distinct 
functional blocks have their IRQ lines wired together doesn't suddenly 
make them a single monolithic block with multiple interfaces - and tends 
to be done for the sake of making the driver implementation easier in 
terms of the Linux IOMMU API (which, note, hasn't evolved all that far 
from its PCI-centric origins and isn't exactly great for arbitrary SoC 
topologies).

>      2) Keep #iommu-cells as-is but support
>              iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
>         instead.
>         This would then require two devices nodes for the two DART instances and
>         some housekeeping in the DART driver to support mapping iovas in both
>         DARTs.
>         I believe omap-iommu.c supports this setup but I will have to read
>         more code to understand the details there and figure out how to implement
>         this in a sane way.

This approach is arguably the most honest, and more robust in terms of 
making fewer assumptions, and is used by at least exynos-iommu and 
omap-iommu. In Linux it currently takes a little bit more housekeeping 
to keep track of linked instances within the driver since the IOMMU API 
holds the notion that any given client device is associated with "an 
IOMMU", but that's always free to change at any time, unlike the design 
of a DT binding.

There's also the funky "root" and "leaf" devices thing that ipmmu-vmsa 
does, although I believe that represents genuine hardware differences 
where the leaves are more like extra TLBs rather than fully-functional 
IOMMU blocks in their own right, so that may not be a relevant model here.

Robin.

> I currently prefer the first option but I don't understand enough details of
> the iommu system to actually make an informed decision.
> I'm obviously also open to more options :-)
> 
> 
> Best regards,
> 
> 
> Sven
> 
> [1] https://lore.kernel.org/linux-arch/20210304213902.83903-1-marcan@marcan.st/
> [2] https://developer.apple.com/library/archive/documentation/DeviceDrivers/Conceptual/IOKitFundamentals/DataMgmt/DataMgmt.html
> [3] https://github.com/svenpeter42/m1n1/commit/1e2661abf5ea2c820297b3ff591235c408d19a34
> [4] https://github.com/svenpeter42/m1n1/tree/usb-uartproxy-console-wip
> 
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
