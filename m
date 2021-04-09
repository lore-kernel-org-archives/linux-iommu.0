Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35667C43460
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 16:50:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE63610CF
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 16:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE63610CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88935405EF;
	Fri,  9 Apr 2021 16:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i62zjAytF-cM; Fri,  9 Apr 2021 16:50:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EAC6404DF;
	Fri,  9 Apr 2021 16:50:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C082C000B;
	Fri,  9 Apr 2021 16:50:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D952C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78F74402C6
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="XP2D2yQF";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="fKdpTyCV"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4M9wAeR_GJxA for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:50:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 769D14027C
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:50:36 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1C619580820;
 Fri,  9 Apr 2021 12:50:35 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Fri, 09 Apr 2021 12:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=/tRhd4nT96NN65qLLACQUONSZaU+
 voT8hPuzE7VOEXA=; b=XP2D2yQFBRFN02eCaNV2a07K3M2o+2oBMkj1QyvJAra1
 WrpX9oq0AK/fq4Eh/oOs0efnMlq3X0LCunwT0AlAF9fmTQAzWqG7dm0AFPtDhvPf
 FWoHuCV7WOrQvanTfX+A4LuGv+Qi4Vv5q/H3hsHR2SrM3q+ANrix6HXA9g0J/A/8
 OPYtttP5BO6ahW7+ajD2zn1HWE+2isEynKRm4Q58t+YXKK+ENr2RPziPcjieml1O
 qX44MNnyWFJGYCEAF9pZI2CvgB/iJpuUfWLusFqHnC5FcDCwC14mboTkfJiZP2cB
 ELHNOyN88GlLRpHiRupCN01Ssbh6yaeIEfZnei+ckA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/tRhd4
 nT96NN65qLLACQUONSZaU+voT8hPuzE7VOEXA=; b=fKdpTyCVED5ZL/nDo3qtjx
 cxxnVfcDhmb5dsQx/UkmoK3kaD7OLAcaVeNzEj88nnpVmea/AXmGadD1XDO7XZUD
 qORAlRfKF3QAdR0T0LPDHL19riADbdObzl1XCDCZ5gCjULuS2oji+40pmrGh1dUR
 Zoi3ADyUc6ftO7HrkXZhn8+RXUeCLsZv6JK0qF1wwOO1KWQHSXIELMC1y0wz9V8j
 5Inc41ppRlt8S4wXNk7fKogNC7O35vBrUzW85TuPdyO+PRS4GhGMu0Bkn95mXusr
 fylOHcoeDt2H2HbGob54d3XUZi/w/URPxg4VAs7/xxMWw4U+yvOe3ug9Wc1moRzg
 ==
X-ME-Sender: <xms:2IVwYOOk5XRZ55prkxAaNTjwW9Vsk2tOF5KdDgthBhf1ZnoKPcaMeA>
 <xme:2IVwYM9CJTuvJ9StwIc2smBzfOajvxjFtzfjhAT93DXCg_inWtq9GCJPgrGJJ5XKZ
 Ju7K4aHwjztYpkwq0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepvedvgeevuddvvedvgfelfeegiedvgeehieeutdelvedvieevveeljeef
 vedtleehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
 uggvvh
X-ME-Proxy: <xmx:2IVwYFTEF7kV4WJeiCo771usTqOs9a9XFHC09UgIxex6EHSAh1YacQ>
 <xmx:2IVwYOt71UPl6yW2GPFfcuYSDiDKCZaxyaT8ozF26nw2B0huJc_kQA>
 <xmx:2IVwYGepIvLkYsmlUTQ7Z64EOiXYLfhhEndUOtAFe0nomUJsLZyskg>
 <xmx:2oVwYC1_KexD6Azt8i1PxNbWuaQ7r6733tn-FOSsWvUjAhWbEORzUlU3PyQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D740651C005F; Fri,  9 Apr 2021 12:50:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <10040e18-6e49-432b-b85c-bcc1345a5e18@www.fastmail.com>
In-Reply-To: <20210407104209.GA15173@willie-the-truck>
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-4-sven@svenpeter.dev>
 <20210407104209.GA15173@willie-the-truck>
Date: Fri, 09 Apr 2021 18:50:12 +0200
To: "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH v2 3/3] iommu: dart: Add DART iommu driver
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
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



On Wed, Apr 7, 2021, at 12:42, Will Deacon wrote:
> On Sun, Mar 28, 2021 at 09:40:09AM +0200, Sven Peter wrote:
> > Apple's new SoCs use iommus for almost all peripherals. These Device
> > Address Resolution Tables must be setup before these peripherals can
> > act as DMA masters.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >  MAINTAINERS                      |   1 +
> >  drivers/iommu/Kconfig            |  14 +
> >  drivers/iommu/Makefile           |   1 +
> >  drivers/iommu/apple-dart-iommu.c | 858 +++++++++++++++++++++++++++++++
> >  4 files changed, 874 insertions(+)
> >  create mode 100644 drivers/iommu/apple-dart-iommu.c
> 
> [...]
> 
> > +/* must be called with held domain->lock */
> > +static int apple_dart_attach_stream(struct apple_dart_domain *domain,
> > +				    struct apple_dart *dart, u32 sid)
> > +{
> > +	unsigned long flags;
> > +	struct apple_dart_stream *stream;
> > +	struct io_pgtable_cfg *pgtbl_cfg;
> > +	int ret;
> > +
> > +	list_for_each_entry(stream, &domain->streams, stream_head) {
> > +		if (stream->dart == dart && stream->sid == sid) {
> > +			stream->num_devices++;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	spin_lock_irqsave(&dart->lock, flags);
> > +
> > +	if (WARN_ON(dart->used_sids & BIT(sid))) {
> > +		ret = -EINVAL;
> > +		goto error;
> > +	}
> > +
> > +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> > +	if (!stream) {
> > +		ret = -ENOMEM;
> > +		goto error;
> > +	}
> 
> Just in case you missed it, a cocci bot noticed that you're using GFP_KERNEL
> to allocate while holding a spinlock here:
> 
> https://lore.kernel.org/r/alpine.DEB.2.22.394.2104041724340.2958@hadrien
> 

Thanks for the reminder!
I haven't replied yet because that one was found later when the bot picked up
a (slightly earlier) version that Marc was using to bring up pcie I believe.
I'll fix it for the next version.


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
