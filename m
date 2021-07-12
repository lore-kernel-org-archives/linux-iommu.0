Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74972C07E99
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 11:02:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F92060FF4
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 11:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F92060FF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C700240179;
	Mon, 12 Jul 2021 11:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I5Pi42j1c7QW; Mon, 12 Jul 2021 11:02:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1A93740140;
	Mon, 12 Jul 2021 11:02:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3350C0010;
	Mon, 12 Jul 2021 11:02:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C623EC000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 11:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A541E606D0
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 11:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="xwjCPhQd";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="ouodfEze"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XLLYvPVBatL1 for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 11:02:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1D83606B4
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 11:02:47 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 91254580AF9;
 Mon, 12 Jul 2021 07:02:46 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Mon, 12 Jul 2021 07:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=7XyyQqaPm43E+iSA6HEfleHFR36O
 XWaTALDg2LKUkgk=; b=xwjCPhQd0xWBFg4xsAE2OGMHZIACEIN1AJC4/+P1tGFa
 zFL9zncOUF+88bPV4qC+v3E7iAk/B35NTHUyEOSkRgG7DSSWNVNPahmq1x1xIyt8
 4izt0VYsxKGG+T46UjGfpIaKfZZ8Es+pEE3BrhqUGS7NrwHItHj7ziHDqLCk5yO5
 BX+j+ak2TQILZEpGSnmaTz8D8iZNqvD9hKOGjsXr++0eL8e/9vH9MZhsMLb6F3Lm
 b1N5B6ApWbQAr81c0TUy+atLA/e2NCg0RhEgz+5avim4jRUbr/EbCUjk7N5e5VHr
 LbbySTBnDLc9v/AOt3UjWzA4FeKCRsE0CDoOLA5yng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7XyyQq
 aPm43E+iSA6HEfleHFR36OXWaTALDg2LKUkgk=; b=ouodfEzeihWXi3YKhCGJZb
 3fslL+cRjTPE3SGqWePpDDraM1i8uBW7MNNt9ObldK51+CKThOEA+xoBsIwyrEOz
 rjcnOgpxvNKQlv3ZRKmqJFQk48dBEDdlzgnevSfYpdfNy6aEMRDbWeKHZsSjAQ6s
 zzOs35CsOfDIQkV0yIVkYU8lancSJLXt1Ih04iiN0+jJUGDELJWZBt2U3SEPFpVo
 CPYkW1LNkeKgY7ToNMwfWrbrZ7m+FSW29OqJsbsh/fVculWVsWOuhOxU/YTQEct2
 twiAkhSj+LxuB5iSs4FrpVv5wg5e+fzmMcb2oa8D/lNbjtCQkPA9oAJmqPF1Zu5Q
 ==
X-ME-Sender: <xms:VCHsYA9j-VSGyScKqbwUdt9sdp3bXneZd2nejh2qEDZXx_yH_9Kr-Q>
 <xme:VCHsYIvD-NiUWimqxHR6JGRvKR4Ve-vh7YB_JIQ94-X8N_1IXhakNvoTF2RNYB7_1
 GXYda5R1h4bdm7tqV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgdeffecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
 ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
 htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
 keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
 hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:VCHsYGB8HqcvOxogMoO8DO4BapMlpVjlA1jc7UMGbCFoZgbPXXqDmg>
 <xmx:VCHsYAehHLkhao02W5b4WQdO4XiqlfIM8Xdbv0TTx8E1nlu-w64Ufg>
 <xmx:VCHsYFOelErVvdihV7A_Wm3nrBKOp2eWiNgYaY8YmkuRRaOWE7af2w>
 <xmx:ViHsYGv8DWHIuMz381N0ZC19MlCwPID0_5WLnpeWGpRLhGqtQNZAHQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D489951C0060; Mon, 12 Jul 2021 07:02:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-531-g1160beca77-fm-20210705.001-g1160beca
Mime-Version: 1.0
Message-Id: <16ffb4ec-86a4-4300-b175-5d7a1fcbf994@www.fastmail.com>
In-Reply-To: <YNx2U4GPoKxV3PWd@maud>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev> <YNx2U4GPoKxV3PWd@maud>
Date: Mon, 12 Jul 2021 13:02:24 +0200
To: "Alyssa Rosenzweig" <alyssa@collabora.com>
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
Cc: devicetree@vger.kernel.org, Rouven Czerwinski <r.czerwinski@pengutronix.de>,
 Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Stan Skowronek <stan@corellium.com>
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


On Wed, Jun 30, 2021, at 15:49, Alyssa Rosenzweig wrote:
> Looks really good! Just a few minor comments. With them addressed,
> 
> 	Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Thanks!

> 
> > +	  Say Y here if you are using an Apple SoC with a DART IOMMU.
> 
> Nit: Do we need to spell out "with a DART IOMMU"? Don't all the apple
> socs need DART?

Good point, I'll remove it.

> 
> > +/*
> > + * This structure is used to identify a single stream attached to a domain.
> > + * It's used as a list inside that domain to be able to attach multiple
> > + * streams to a single domain. Since multiple devices can use a single stream
> > + * it additionally keeps track of how many devices are represented by this
> > + * stream. Once that number reaches zero it is detached from the IOMMU domain
> > + * and all translations from this stream are disabled.
> > + *
> > + * @dart: DART instance to which this stream belongs
> > + * @sid: stream id within the DART instance
> > + * @num_devices: count of devices attached to this stream
> > + * @stream_head: list head for the next stream
> > + */
> > +struct apple_dart_stream {
> > +	struct apple_dart *dart;
> > +	u32 sid;
> > +
> > +	u32 num_devices;
> > +
> > +	struct list_head stream_head;
> > +};
> 
> It wasn't obvious to me why we can get away without reference counting.
> Looking ahead it looks like we assert locks in each case. Maybe add
> that to the comment?

Sure, I'll add that to the comment.

> 
> ```
> > +static void apple_dart_hw_set_ttbr(struct apple_dart *dart, u16 sid, u16 idx,
> > +				   phys_addr_t paddr)
> > +{
> > +	writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
> > +	       dart->regs + DART_TTBR(sid, idx));
> > +}
> ```
> 
> Should we be checking alignment here? Something like
> 
>     BUG_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
> 

Sure, right now paddr will always be aligned but adding that
BUG_ON doesn't hurt :)



Best,

Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
