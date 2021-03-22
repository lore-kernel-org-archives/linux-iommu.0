Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6ECC433C1
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 22:18:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF979619A5
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 22:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF979619A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 764C440442;
	Mon, 22 Mar 2021 22:18:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21I4V8V5rAkS; Mon, 22 Mar 2021 22:18:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFAF040440;
	Mon, 22 Mar 2021 22:18:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3A19C000A;
	Mon, 22 Mar 2021 22:18:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5747C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 22:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E64A40330
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 22:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="FTv+4Fla";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="jYDkRuJq"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ujfHc4NgmpXj for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 22:17:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DAF14032D
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 22:17:57 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 685E45804DD;
 Mon, 22 Mar 2021 18:17:54 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Mon, 22 Mar 2021 18:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=ZWi4GtAKz6MJnR4YgJPLnmK6aRpu
 RQjPkHSWuDbn2hw=; b=FTv+4FlaBI3nXkxsa7BojoAkYJrOjRcOzmC3RGEeEswA
 zcn8SGPQ5MDiSZvzFOoQaHhYWjY5Zfu8w6RbXJIlX/lkeoihJehq7b3DmVqRdgei
 Kc31ki6aj6L015JQbET5Eo+gfJ7zO7PslknCI2/93BWPjgsxaLRbjE1bW3T7mVBR
 zrqQ9K5WjwtmcJBrjd5qLVRW85hTHBXmKYntfSL6+AJkRc0qmIUPWUq4hZlJjpbf
 r1ruGJJJChwjGlb0/NQb8Opdu7Mq8uLmMy0F1VqyKPl5RfAjj/NVnueqQrE7PzM1
 lU3fIxS5Wo9wPleZ1Sm+QuIck8u4mVcse0bDVuFM5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZWi4Gt
 AKz6MJnR4YgJPLnmK6aRpuRQjPkHSWuDbn2hw=; b=jYDkRuJqLc1gQX1YIg6lJR
 EsuKs8DlVizuIL6jBEDPwauOF4v77Kf+sA44eeK22O9inufF2Le8r+aQUVL7fEtH
 +nQvt9LISbklUqPjiIyJfcQajHG4NmUSYBDewSwt57lE8KoxivY8N7SV0jO+Pl6Q
 HXb3wzkG9q6sPDM3NPQlw/BYj/iX0pNPAzIYQDckl2qN52KbgZQyKAVuVdbhvbzy
 o4jvi2muKlUsKldoEMnLCgtvPzIIjr/Tt2zIG9NVAU/5DKsyXQqrx7DUF0lhjM/u
 CYCZpRIfrXF3/mWtyx6EB6Q2wswoZY4f5xEnolb9K48m3Jq+WRcvY37Db8IlkOaw
 ==
X-ME-Sender: <xms:kBdZYNZa_zfBQyNVqg09XWG6y_omDyN7S6Hvrsx8qMyDD4TFPPNKfA>
 <xme:kBdZYEYNlNxESbTnoJGMgIF6hSh_bxnzoFNENRh0y4wTcKfFAkxk-UaC0XN3dVazd
 nBK6VLtV0Dy9crO_H4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedgudehlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:kBdZYP_i3tbdtKRRVGfAidaUBrJnQ0ERc1r6toG6BtKRdzoY2EmZiA>
 <xmx:kBdZYLosz2ZP4J8_IYekp6RhbP_T-TOe8aNKqDu9Ba2iqYePJKy8DQ>
 <xmx:kBdZYIrrIKxv0MGFn75u8QDj-K-S7v1xpZwhrzL4eJ_vaKdBK_pOsw>
 <xmx:khdZYNShY084XZvHOtsreFHxtDtzB6GQOSOVksjUZj2QLQvb6XLGLNuk4ys>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 811F851C005E; Mon, 22 Mar 2021 18:17:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-271-g88286cf463-fm-20210318.001-g88286cf4
Mime-Version: 1.0
Message-Id: <d280843b-77e3-4fa8-9452-5a2f8a45052e@www.fastmail.com>
In-Reply-To: <c1bcc0be8ae6e500@bloch.sibelius.xs4all.nl>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
 <c1bcc0be8ae6e500@bloch.sibelius.xs4all.nl>
Date: Mon, 22 Mar 2021 23:17:31 +0100
To: "Mark Kettenis" <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


Hi Mark,

On Sun, Mar 21, 2021, at 19:35, Mark Kettenis wrote:
>
> Guess we do need to understand a little bit better how the USB DART
> actually works.  My hypothesis (based on our discussion on #asahi) is
> that the XHCI host controller and the peripheral controller of the
> DWC3 block use different DMA "streams" that are handled by the
> different sub-DARTs.

I've done some more experiments and the situation is unfortunately more
complicated: Most DMA transfers are translated with the first DART.
But sometimes (and I have not been able to figure out the exact conditions)
transfers instead have to go through the second DART. 
This happens e.g. with one of my USB keyboards after a stop EP command
is issued: Suddenly the xhci_ep_ctx struct must be translated through the
second DART.

What this likely means is that we'll need to point both DARTs
to the same pagetables and just issue the TLB maintenance operations
as a group.

> 
> The Corellium folks use a DART + sub-DART model in their driver and a
> single node in the device tree that represents both.  That might sense
> since the error registers and interrupts are shared.  Maybe it would
> make sense to select the appropriate sub-DART based on the DMA stream
> ID?

dwc3 specifically seems to require stream id #1 from the DART
at <0x5 0x02f00000> and stream id #0 from the DART at <0x5 0x02f80000>.
Both of these only share a IRQ line but are otherwise completely independent.
Each has their own error registers, etc. and we need some way to
specify these two DARTs + the appropriate stream ID.

Essentially we have three options to represent this now:

1) Add both DARTs as separate regs, use #iommu-cells = <2> and have the
   first cell select the DART and the second one the stream ID.
   We could allow #iommu-cells = <1> in case only one reg is specified
   for the PCIe DART:

   usb_dart1@502f00000 {
     compatible = "apple,t8103-dart";
     reg = <0x5 0x02f00000 0x0 0x4000>, <0x5 0x02f80000 0x0 0x4000>;
     #iommu-cells = <2>;
     ...
   };

   usb1 {
     iommus = <&usb_dart1 0 1>, <&usb_dart1 1 0>;
     ...
   };

   I prefer this option because we fully describe the DART in a single
   device node here. It also feels natural to group them like this because
   they need to share some properties (like dma-window and the interrupt)
   anyway. 

2) Create two DART nodes which share the same IRQ line and attach them
   both to the master node:

   usb_dart1a@502f00000 {
     compatible = "apple,t8103-dart";
     reg = <0x5 0x02f00000 0x0 0x4000>;
     #iommu-cells = <1>;
     ...
   };
   usb_dart1b@502f80000 {
     compatible = "apple,t8103-dart";
     reg = <0x5 0x02f80000 0x0 0x4000>;
     #iommu-cells = <1>;
     ...
   };

   usb1 {
     iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
     ...
   };

   I dislike this one because attaching those two DARTs to a single device
   seems rather unusual. We'd also have to duplicate the dma-window setting,
   make sure it's the same for both DARTs and there are probably even more
   complications I can't think of right now. It seems like this would also
   make the device tree very verbose and the implementation itself more
   complicated.

3) Introduce another property and let the DART driver take care of
   mirroring the pagetables. I believe this would be similar to
   the sid-remap property:

   usb_dart1@502f00000 {
     compatible = "apple,t8103-dart";
     reg = <0x5 0x02f00000 0x0 0x4000>, <0x5 0x02f80000 0x0 0x4000>;
     #iommu-cells = <1>;
     sid-remap = <0 1>;
   };
   usb1 {
     iommus = <&usb_dart1 0>;
   };

   I slightly dislike this one because we now specify which stream id 
   to use in two places: Once in the device node and another time in the
   new property in the DART node. I also don't think the binding is much
   simpler than the first one.


> > where #dma-address-cells and #dma-size-cells default to
> > #address-cells and #size-cells respectively if I understand
> > the code correctly. That way we could also just always use
> > a 64bit address and size in the DT, e.g.
> > 
> >   pcie_dart {
> >       [ ... ]
> >       dma-window = <0 0x100000 0 0x3fe00000>;
> >       [ ... ]
> >   };
> 
> That sounds like a serious contender to me!  Hopefully one of the
> Linux kernel developers can give this some sort of blessing.
> 
> I think it would make sense for us to just rely on the #address-cells
> and #size-cells defaults for the M1 device tree.
>

Agreed.


Best,

Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
