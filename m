Return-Path: <SRS0=maFY=IS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D693AC433DB
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 16:05:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A79C61967
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 16:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A79C61967
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC53860763;
	Sat, 20 Mar 2021 16:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6U1w1ALAyPD6; Sat, 20 Mar 2021 16:05:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A8F660633;
	Sat, 20 Mar 2021 16:05:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24B82C0012;
	Sat, 20 Mar 2021 16:05:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C70BBC0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0B7E40345
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gyGMthYzdPvB for <iommu@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 15:29:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2972B40344
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:29:50 +0000 (UTC)
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com
 [51.89.119.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-41104.protonmail.ch (Postfix) with ESMTPS id 4F2kvn02Gtz4xn8V
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:19:48 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev
 header.b="RkCqzYsp"
Date: Sat, 20 Mar 2021 15:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 s=protonmail3; t=1616253575;
 bh=rRb0CjHmraJyeX+g9eakf9Qm7lh28jtpNuhNTu/RlwY=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=RkCqzYspbvUCMMsy777eroY/bnpCj4qZJg+IEZvKlr2YFE7M6Hdw+mZpZWo5GcI7w
 9x6vrc7I+OieqMiQ7QsdsLk3jQuSUSHY3Rn7JbcexUXVt4NCn/PsmjoXGH34vkQNkk
 0CkWJHu8Yf6ztHIPbQU4AK4eqM3TCr4iUkDvbBM8HJAKYnHyVunlMDX0ZS9j56lRnw
 JURq8ktUnC6bscDInomvcHgpZdUpgqHFNMCxnP9ZqJDHd5bgllEDop1SXjEyQyeTdh
 Upi3/K2G3ZeBRcxeDz5irK1VM7VXyb7mWD77l++lETMSNooQXJyEuvcGwiURyqzls0
 6Mn0vD7ohrQtw==
To: iommu@lists.linux-foundation.org
Subject: [PATCH 0/3] Apple M1 DART IOMMU driver
Message-ID: <20210320151903.60759-1-sven@svenpeter.dev>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 20 Mar 2021 16:05:05 +0000
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, Robin Murphy <robin.murphy@arm.com>,
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

After Hector's initial work [1] to bring up Linux on Apple's M1 it's time to
bring up more devices. Most peripherals connected to the SoC are behind a iommu
which Apple calls "Device Address Resolution Table", or DART for short [2].
Unfortunately, it only shares the name with PowerPC's DART.
Configuring this iommu is mandatory if these peripherals require DMA access.

This patchset implements initial support for this iommu. The hardware itself
uses a pagetable format that's very similar to the one already implement in
io-pgtable.c. There are some minor modifications, namely some details of the
PTE format and that there are always three pagetable levels, which I've
implement as a new format variant.

I have mainly tested this with the USB controller in device mode which is
compatible with Linux's dwc3 driver. Some custom PHY initialization (which is
not yet ready or fully understood) is required though to bring up the ports,
see e.g. my patches to our m1n1 bootloader [3,4]. If you want to test the same
setup you will probably need that branch for now and add the nodes from
the DT binding specification example to your device tree.

Even though each DART instances could support up to 16 devices usually only
a single device is actually connected. Different devices generally just use
an entirely separate DART instance with a seperate MMIO range, IRQ, etc.

I have just noticed today though that at least the USB DWC3 controller in host
mode uses *two* darts at the same time. I'm not sure yet which parts seem to
require which DART instance.

This means that we might need to support devices attached to two iommus
simultaneously and just create the same iova mappings. Currently this only
seems to be required for USB according to Apple's Device Tree.

I see two options for this and would like to get feedback before
I implement either one:

    1) Change #iommu-cells = <1>; to #iommu-cells = <2>; and use the first cell
       to identify the DART and the second one to identify the master.
       The DART DT node would then also take two register ranges that would
       correspond to the two DARTs. Both instances use the same IRQ and the
       same clocks according to Apple's device tree and my experiments.
       This would keep a single device node and the DART driver would then
       simply map iovas in both DARTs if required.

    2) Keep #iommu-cells as-is but support
            iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
       instead.
       This would then require two devices nodes for the two DART instances and
       some housekeeping in the DART driver to support mapping iovas in both
       DARTs.
       I believe omap-iommu.c supports this setup but I will have to read
       more code to understand the details there and figure out how to implement
       this in a sane way.

I currently prefer the first option but I don't understand enough details of
the iommu system to actually make an informed decision.
I'm obviously also open to more options :-)


Best regards,


Sven

[1] https://lore.kernel.org/linux-arch/20210304213902.83903-1-marcan@marcan.st/
[2] https://developer.apple.com/library/archive/documentation/DeviceDrivers/Conceptual/IOKitFundamentals/DataMgmt/DataMgmt.html
[3] https://github.com/svenpeter42/m1n1/commit/1e2661abf5ea2c820297b3ff591235c408d19a34
[4] https://github.com/svenpeter42/m1n1/tree/usb-uartproxy-console-wip



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
