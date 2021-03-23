Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92335C433DB
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 21:05:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033ED619A5
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 21:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033ED619A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1CDE40524;
	Tue, 23 Mar 2021 21:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id td6HokCAx8SP; Tue, 23 Mar 2021 21:05:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47D8940447;
	Tue, 23 Mar 2021 21:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D349C000D;
	Tue, 23 Mar 2021 21:05:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3996C000A
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 21:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9304240447
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 21:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SbbcejCStX_E for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 21:05:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2B4440444
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 21:05:31 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 869E65808F8;
 Tue, 23 Mar 2021 17:05:28 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Tue, 23 Mar 2021 17:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=7AwKQ20yTUlj5ILOqFiSR0NWHgZy
 DvHCZx+iOwKTD9A=; b=33vdjbL9sLaxm4AVMCxAQw5cEedmH7+oy/Fol1wpmhlj
 KdbaZ6dLGDLHYxj6iX6SCtu7c6rgc/fZ/I/6st7CLWfCeM+kQ4Qs3YTS/VZ4gLpx
 0c2qsGmGZAOVGdQw/3mLVJ0SzX18hvoTGg60spR3+6A59D8wcoXHAB7OI56wzTVL
 9MsRSi/+3NNH+YSeak3vpzpGZe545A5O3vnz0GXTsSn7EarKaOX+U4H9PgVMOaJf
 RT3gTktsyPdWLhnGjG1Vw8fh5URfj9u8WeovTGLk1cOzIScIoAN+2N6gZdQfMtFe
 RNY9jl5HcdkWZ6f+p8CfwwlvlfNzkTg/kjxObDoEfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7AwKQ2
 0yTUlj5ILOqFiSR0NWHgZyDvHCZx+iOwKTD9A=; b=PVMsmS///9y5o8YHEheE21
 Ehga8Q/Dd7zacqoBBQsG7g05XKAjstaEXqWdfvEq+y2wiU/RfJtTCR80j6M5EqtZ
 pT4k96c5LTlTpM8DhSyb9gX3AN6dnX2QjQ3/Noftpaaof+2bX2ALJhsvllnWxacS
 Z3wIm/j3W4TnyingfrbcOtBBmvzB4j2q3V4GGmNl07PJ1el7p2bp44PLhqdndp43
 0fL/oBYye5E9Lj/1n4SYNYjmmdUhQfi8TCCHZNndfnF5KJw5SnKLhvP7qb4k0Pp5
 P5HlkGIYXwnjtjMGMc2FKAWqx33tgAqiJ2uFsUNODZMch2Q5hLJ4nJay+y8gsdgg
 ==
X-ME-Sender: <xms:FlhaYCbdxiCd3Xy-QRdw1eFowKJpQjPqM_2gyz0bSSZtoKH2xwIGBg>
 <xme:FlhaYFZpWroX_2mhT2wHqTBJ7TOOsKlW3xax4OoEmqxEckesCbX_vcR2vbm-MIPVI
 wc9r6SJ0k1oyOWgJxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegiedgudegiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:FlhaYM91yjkKujZIiGQXQwr4p0AzmHmCl4Y15vufH5r-wMXDO3xcLw>
 <xmx:FlhaYEqPw-LOLHpPTlOLJWFp0IMDzhSVOezJZ8_rSBVA4CwcyyHvkA>
 <xmx:FlhaYNpCfMBJ-mlHOLKLkuMZOH_YS14lW5PhOK6Ut9Hnm_ToFHeTxg>
 <xmx:GFhaYOQSV0XszcUHR0EH4S7HdHZdWCw1IEnnt2PPdxowpn5ZQsDhkkHU8QQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 30D0E51C005F; Tue, 23 Mar 2021 17:05:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <1a2da66b-221a-404f-a0af-d2b247ced0b0@www.fastmail.com>
In-Reply-To: <c1bcca33753f71d3@bloch.sibelius.xs4all.nl>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
 <c1bcc0be8ae6e500@bloch.sibelius.xs4all.nl>
 <d280843b-77e3-4fa8-9452-5a2f8a45052e@www.fastmail.com>
 <c1bcca33753f71d3@bloch.sibelius.xs4all.nl>
Date: Tue, 23 Mar 2021 22:03:45 +0100
To: "Mark Kettenis" <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 will@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 Marc Zyngier <maz@kernel.org>, mohamed.mediouni@caramail.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stan@corellium.com
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

Hi Mark,

On Tue, Mar 23, 2021, at 21:00, Mark Kettenis wrote:
> The problem with both #1 and #2 is that you end up with two references
> to (effectively) different iommu's in the dwc3 device node.  I don't
> see how that is compatible with the idea of using a single translation
> table for both sub-DARTs.

I don't have a strong opinion about this fwiw.
Option #1 and #2 seem to have precedence in the already existing
iommu bindings though [1,2,3].
I just want to make sure we've thought through all options and understand
their advantages/disadvantages before we take a decision.


I've been reading some more Linux iommu code and here's how I understand
it now / how I could implement at least #1 with a single shared pagetable.
This might also be possible for option #2, but I'll need to think that through
in more detail.

An iommu domain is a collection of devices that share a virtual address space.
During domain allocation I can just allocate a single DART pagetable and
not have anything point to it for now.

A stream identifies the smallest unit the iommu hardware can differentiate.
For the DART we have 16 of these with a single TCR + the four TTBR register
for each stream.

A device is assigned to individual streams using the "iommus" property. When
a device is attached to a domain we now simply setup the TTBR registers to
point to the iommu domain pagetable. It doesn't matter here if it's a single
stream or multiple ones or even multiple devices sharing a single stream as
long as they're attached to the same domain.

All operations (map, unmap, etc.) now simply first modify the domain
pagetable and then issue the TLB maintenance operations for attached streams.


> 
> If you no longer think that is desirable, you'll still have the
> problem that you'll need to modify the dwc3 driver code such that it
> uses the right IOMMU to do its DMA address translation.  Given what
> you write above that sounds really ugly and confusing.  I would
> certainly want to avoid doing that in OpenBSD.

Yeah, I absolutely don't want to hack on the dwc3 code at all.
That will end up being *very* ugly.



Best,

Sven


[1] Documentation/devicetree/bindings/iommu/iommu.txt "Multiple-master IOMMU"
[2] Documentation/devicetree/bindings/qcom,iommu.txt last example
[3] Documentation/devicetree/bindings/arm,smmu.yaml first example
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
