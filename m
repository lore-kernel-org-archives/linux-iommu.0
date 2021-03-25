Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE575C433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 07:59:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0E5619FB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 07:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0E5619FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9245160751;
	Thu, 25 Mar 2021 07:59:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oPiuFunhmF1R; Thu, 25 Mar 2021 07:59:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EC41606D4;
	Thu, 25 Mar 2021 07:59:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 453BFC0011;
	Thu, 25 Mar 2021 07:59:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51F43C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 07:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40D7060751
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 07:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DCIftJcCJMic for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 07:58:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DBEE606D4
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 07:58:57 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 91068580A76;
 Thu, 25 Mar 2021 03:58:56 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Thu, 25 Mar 2021 03:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=+T7CqVyoWdNN8bzlePUROPAX6ed7
 sRoD/m/fHmI9qo4=; b=LpbxgVCzrqQ9ltk79TitEh6KZ0xv+/E3QIvusbwQguuN
 RJLWtkF7PuJQnsag4PYsVCIkM83ZhZniDcWqK4pj4MqlOx0sPD/sIxgaXUH5WHeN
 0M+TFrnbDvMFrxIiU8NuFbFzRERTkTD2fYqmXFPVN6c3bBqxaN2jRd3zxXlHXsoc
 GDT+pXcOB4oR7zn6T90E0iGX8IPIA0RzLQKkoDMmdPbdLHc+ftJJ2pThrVwR9Ptn
 4QvmlA3AyUuaOO1N11IzIesXf4RWryEwT7lx8byZhdQbv4cbPCOmevWbFp9h+5ck
 a5HYr61KhiPlAujeYERIxz/Cavcb8fZM24AJIP802A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+T7CqV
 yoWdNN8bzlePUROPAX6ed7sRoD/m/fHmI9qo4=; b=hCyXTtepAEJYQhogfMllqO
 jQxW0FyZbsaIAaGo6XADIRxGbO2rcoJy7LqQUcEVoBJpYEAF55gs5tNV2jnGKRO5
 M9fnE2Lnxwpr5qHqqNAFNIK5s6j2Ngomuk4/d9p0P7qym2HJTO8u5FiHi4+u1YNR
 1oDRoS7oOjIVQHUcGUSvqZ3ex56WRYy8q3jOltcf59b1WDwsIIq6f33HvMbqAxjV
 PpfOQ7YF0DU8aj6uGzFwcnQDws2AwuEk0Otdf/EQrWQ0XSL/5LDa+zN0QcspfX8g
 h6vHf3q80gomzUv+WlsADLvmek5wvca77JCOwoh+mBYWhT2qkYvmxNGYVa94N8PQ
 ==
X-ME-Sender: <xms:v0JcYArC25zHz2V26Ua7EqGjVk7-5p3h7rvzBq2onaRw7MXuY8viHQ>
 <xme:v0JcYGq2FA_YmyvHTlvCFbmVPR1Fkkk-t9XNzeVKfpYEFgc9oltPKQm8Ox6bnY1hZ
 SfJQKWNNEA9ohnz4wM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegledguddufecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:v0JcYFM_zRQhKUXd3JaCDMcGtfUZoM7DDDYFrbEP_m3GQ5MkKktVOg>
 <xmx:v0JcYH70r-HSbiG5uFjLNuVhJCAUSFZ8d2dJ3Wmtd2-onZ1PgkNpaA>
 <xmx:v0JcYP4RABId_lUiZScL_EZ5aIKOuy4DwNz9Lg3DCRti39X3-G6zLw>
 <xmx:wEJcYDjaRy8l2GQ-99NYJlF457U5BixsylPCdCPBuPmttvyxNZ21Q-C5iwY>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0FBF751C005E; Thu, 25 Mar 2021 03:58:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <b05337f3-a4bf-4add-a68d-b9f5c9b8b10d@www.fastmail.com>
In-Reply-To: <9b9d771a-f6d4-2d27-7516-f5b8315909ed@arm.com>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <9b9d771a-f6d4-2d27-7516-f5b8315909ed@arm.com>
Date: Thu, 25 Mar 2021 08:58:16 +0100
To: "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,


On Wed, Mar 24, 2021, at 16:29, Robin Murphy wrote:
> On 2021-03-20 15:19, Sven Peter wrote:
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
> >      1) Change #iommu-cells = <1>; to #iommu-cells = <2>; and use the first cell
> >         to identify the DART and the second one to identify the master.
> >         The DART DT node would then also take two register ranges that would
> >         correspond to the two DARTs. Both instances use the same IRQ and the
> >         same clocks according to Apple's device tree and my experiments.
> >         This would keep a single device node and the DART driver would then
> >         simply map iovas in both DARTs if required.
> 
> This is broadly similar to the approach used by rockchip-iommu and the 
> special arm-smmu-nvidia implementation, where there are multiple 
> instances which require programming identically, that are abstracted 
> behind a single "device". Your case is a little different since you're 
> not programming both *entirely* identically, although maybe that's a 
> possibility if each respective ID isn't used by anything else on the 
> "other" DART?

That would be possible. The only difference is that I need to
program ID 0 of the first DART and ID 1 of the second one. Both
of these IDs are only connected to the same USB controller.


> 
> Overall I tend to view this approach as a bit of a hack because it's not 
> really describing the hardware truthfully - just because two distinct 
> functional blocks have their IRQ lines wired together doesn't suddenly 
> make them a single monolithic block with multiple interfaces - and tends 
> to be done for the sake of making the driver implementation easier in 
> terms of the Linux IOMMU API (which, note, hasn't evolved all that far 
> from its PCI-centric origins and isn't exactly great for arbitrary SoC 
> topologies).

Yes, the easier driver implementation was my reason to favour this option.

> 
> >      2) Keep #iommu-cells as-is but support
> >              iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
> >         instead.
> >         This would then require two devices nodes for the two DART instances and
> >         some housekeeping in the DART driver to support mapping iovas in both
> >         DARTs.
> >         I believe omap-iommu.c supports this setup but I will have to read
> >         more code to understand the details there and figure out how to implement
> >         this in a sane way.
> 
> This approach is arguably the most honest, and more robust in terms of 
> making fewer assumptions, and is used by at least exynos-iommu and 
> omap-iommu. In Linux it currently takes a little bit more housekeeping 
> to keep track of linked instances within the driver since the IOMMU API 
> holds the notion that any given client device is associated with "an 
> IOMMU", but that's always free to change at any time, unlike the design 
> of a DT binding.

Sounds good. I'll read those drivers and give it a try for v2.


Thanks,


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
