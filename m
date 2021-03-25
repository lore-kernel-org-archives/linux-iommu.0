Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36064C433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 20:49:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB07861A3C
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 20:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB07861A3C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 999CD83B0D;
	Thu, 25 Mar 2021 20:49:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 575ffUh75AiE; Thu, 25 Mar 2021 20:49:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 654A084942;
	Thu, 25 Mar 2021 20:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40602C000E;
	Thu, 25 Mar 2021 20:49:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 132B4C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 20:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8F166075F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 20:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="SaaNnsEp";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="v+vXCwq+"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2NpKjx_hSdKg for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 20:49:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3854960601
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 20:49:29 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 205C05807EA;
 Thu, 25 Mar 2021 16:49:28 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Thu, 25 Mar 2021 16:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=RVE8IE0PQw3LRkbXkLSvsCDLIzU6
 SlW3D0LFyfhKo1o=; b=SaaNnsEpxbvk6vNBMxp7WNllK/VE0eszxt1hptIS0OW3
 jOb842oZEGLE7BLMtVGi81FD1xN072drwgaN6lhS04GaL1JS23BGYR6j1gpCA/rK
 OOAOTZTrGxnKdcgTDJQAbtMUVrRDwZh4Egrhu/wWSY7r1llfGY6CudRn0F5pLsS1
 rl2vRVhLpblVgGw/yLKP0Ta01xMu7ahbgJw0/UGn1nrdDV9GS3b4aBXqd8YhZOtz
 2fiumBqUH3SGU65lEmAWExHsKBu5BngoWpm2ycX4j1scoPOYLslK/caNCi2gp4nN
 qbj2fGKJ7quViz2/NjpXVqf0yLHdPIlWSyKryDQWUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RVE8IE
 0PQw3LRkbXkLSvsCDLIzU6SlW3D0LFyfhKo1o=; b=v+vXCwq+I3B1JGW9+84YZ4
 /etee8mpzBxlXC5jbjGDs9gZfSAo4mdcXpuGAzL0XWv3FEeB3yeafs7IqMrsuSyX
 nX21xmvywilGXG+iT4cZuoJheq/Dfux/qiz0vLa8RyyhPRReAoUracJq3LYQp1Mp
 8+tjrw2OuK83asRF38nWMxc1CG6ojlOsZpV7G6iQ1+2k/L+4xGqEF3BQ6YZTpha+
 GxkaOZxB6jZ08JNBksAEkaCNOJa6bsLM5hm+WwNOaa5ZvZQjqrKWPiKNfVSdd2fq
 X7O9nH55Vomgc7wSteGn6U71olBnHQ51qQqT9a+QfWXdvlBdRMDcOr8BvOFiyhsA
 ==
X-ME-Sender: <xms:VvdcYEHUehT4pYLdyjpswxyPOlqN-Di8XFR20DgEzbEeeaL4PXKjtg>
 <xme:VvdcYNXh4GTOYzCFCSGoq5uOjCL0zpCY5Qp6Gu6EL-Bi_NL859m_lutOSH7QeR4ib
 lg5HCPdnfXaiLbnbKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehtddgudeghecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:VvdcYOLdYdxjpoGOpOT2ZdhQds8gNZ2mWe1b3wssoaY3XVYKnY4eQQ>
 <xmx:VvdcYGHxP5ApU7gKrZK0UDlWPhUh5iHpMZxCBu4e40TBGT8AgVBzgw>
 <xmx:VvdcYKWwxr1d3BqwZo72KhxWjhfLM78_D_1-86jEGcR7rY0naxM94A>
 <xmx:WPdcYBNupxRKaMhVpwq89tmTpEe_1d2DA8BGE6PrXVYdIt5IZUtkxSgJ8M4>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 812B551C005E; Thu, 25 Mar 2021 16:49:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <5e14eed2-fabf-4f28-b1e0-450803dd4b05@www.fastmail.com>
In-Reply-To: <33b3ce35-c42f-331a-79a2-e38917d588ef@arm.com>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
 <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <33b3ce35-c42f-331a-79a2-e38917d588ef@arm.com>
Date: Thu, 25 Mar 2021 21:49:07 +0100
To: "Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>,
 "Mark Kettenis" <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, marcan@marcan.st, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, mohamed.mediouni@caramail.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org, stan@corellium.com
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



On Thu, Mar 25, 2021, at 12:50, Robin Murphy wrote:
> On 2021-03-25 07:53, Sven Peter wrote:
> > 
> > 
> > On Tue, Mar 23, 2021, at 21:53, Rob Herring wrote:
> >> On Sun, Mar 21, 2021 at 05:00:50PM +0100, Mark Kettenis wrote:
> >>>
> >>> As I mentioned before, not all DARTs support the full 32-bit aperture.
> >>> In particular the PCIe DARTs support a smaller address-space.  It is
> >>> not clear whether this is a restriction of the PCIe host controller or
> >>> the DART, but the Apple Device Tree has "vm-base" and "vm-size"
> >>> properties that encode the base address and size of the aperture.
> >>> These single-cell properties which is probably why for the USB DARTs
> >>> only "vm-base" is given; since "vm-base" is 0, a 32-bit number
> >>> wouldn't be able to encode the full aperture size.  We could make them
> >>> 64-bit numbers in the Linux device tree though and always be explicit
> >>> about the size.  Older Sun SPARC machines used a single "virtual-dma"
> >>> property to encode the aperture.  We could do someting similar.  You
> >>> would use this property to initialize domain->geometry.aperture_start
> >>> and domain->geometry.aperture_end in diff 3/3 of this series.
> >>
> >> 'dma-ranges' is what should be used here.
> >>
> > 
> > The iommu binding documentation [1] mentions that
> > 
> >      The device tree node of the IOMMU device's parent bus must contain a valid
> >      "dma-ranges" property that describes how the physical address space of the
> >      IOMMU maps to memory. An empty "dma-ranges" property means that there is a
> >      1:1 mapping from IOMMU to memory.
> > 
> > which, if I understand this correctly, means that the 'dma-ranges' for the
> > parent bus of the iommu should be empty since the DART hardware can see the
> > full physical address space with a 1:1 mapping.
> > 
> > 
> > The documentation also mentions that
> > 
> >       When an "iommus" property is specified in a device tree node, the IOMMU
> >       will be used for address translation. If a "dma-ranges" property exists
> >       in the device's parent node it will be ignored.
> > 
> > which means that specifying a 'dma-ranges' in the parent bus of any devices
> > that use the iommu will just be ignored.
> 
> I think that's just wrong and wants updating (or at least clarifying). 
> The high-level view now is that we use "dma-ranges" to describe 
> limitations imposed by a bridge or interconnect segment, and that can 
> certainly happen upstream of an IOMMU. As it happens, I've just recently 
> sent a patch for precisely that case[1].
> 
> I guess what it might have been trying to say is that "dma-ranges" 
> *does* become irrelevant in terms of constraining what physical memory 
> is usable for DMA, but that shouldn't imply that its meaning doesn't 
> just shift to a different purpose.
> 

Okay, now it makes sense then!

> > As a concrete example, the PCIe DART IOMMU only allows translations from iovas
> > within 0x00100000...0x3ff00000 to the entire physical address space (though
> > realistically it will only map to 16GB RAM starting at 0x800000000 on the M1).
> > 
> > I'm probably just confused or maybe the documentation is outdated but I don't
> > see how I could specify "this device can only use DMA addresses from
> > 0x00100000...0x3ff00000 but can map these via the iommu to any physical
> > address" using 'dma-ranges'.
> > 
> > Could you maybe point me to the right direction or give me a small example?
> > That would help a lot!
> 
> PCI is easy, since it's already standard practice to use "dma-ranges" to 
> describe host bridge inbound windows. Even if the restriction is really 
> out in the host-side interconnect rather than in the bridge itself, to 
> all intents and purposes it's indistinguishable so can still be 
> described the same way.
> 
> The case of a standalone device having fewer address bits wired up than 
> both its output and the corresponding IOMMU input might expect is a 
> little more awkward, since that often *does* require adding an extra 
> level of "bus" to explicitly represent that interconnect link in the DT 
> model, e.g. [2].
> 

Nice, thanks! That's exactly what I was looking for :)


Best,

Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
