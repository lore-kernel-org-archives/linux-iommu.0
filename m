Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C467C433B4
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 16:55:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB27610CC
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 16:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB27610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89F7A606DC;
	Fri,  9 Apr 2021 16:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CE5u-A8a7EYi; Fri,  9 Apr 2021 16:55:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61267607A5;
	Fri,  9 Apr 2021 16:55:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 385E9C000B;
	Fri,  9 Apr 2021 16:55:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06673C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE4D5401B7
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="oJSw7fpF";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="q0+PBkhK"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cuXm9TP7tHqZ for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:55:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6289400E4
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:55:33 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id C26D7580808;
 Fri,  9 Apr 2021 12:55:32 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Fri, 09 Apr 2021 12:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=jYj5qvbwgmmkBYNCveC+eU/VVcmT
 6Bj1WrUhMKoMsMs=; b=oJSw7fpFBxT1PQLtxpcv93MJGLdN0f8VkoGM1qznRFAt
 jJ7SF0W/whqyxBT5X+0Nl+1ORs7kqiQbCBgYV9ucCmpanua8tZPNHC5zZt4d4vZy
 tmk9+atDIhU3XSoY1NIR4iRwZSWtoJj+53UYZ41HI1mOtSgRhdr7U8RUXijel5uO
 p1DADMrwONja3O7/Vh08+csjDtLImoyXf4KH0hFGfFE3nGbt/l/Z0zlEu+biXNJt
 3SGXvLRBgCBGTZZiqo9ctmJi8Vy7kDl41rXfRoDKM0r5oylRHjvPK59wycmWJ4wh
 UdRpbdAicWmckyf8LwqBqJwXvxcbCtDj2JM0B1LMNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jYj5qv
 bwgmmkBYNCveC+eU/VVcmT6Bj1WrUhMKoMsMs=; b=q0+PBkhKraoZSc1tbs61wK
 un2MfHcx9PJOW2q4KwF1wNUHjCSxpbyMtGCGtg0CSphD3QqUi+QV+akyZ857xU/A
 /KEsqBBbM0Ypbk2WcgxIYgZr9LbZiGxAbjQbNI6buHNmQVgLt3llEbAXMXi2OaH2
 o9R6/QQEONqiKcfZnk+brI28C5AWNTpg6zHkjEpsWZC5aj+40nsVfyUlAzLADylo
 3N05qJ4cHa0CGWEEq0xCvorK5mobzPj2wfJasY5LIs7CwC+Te5SOBPiQXZ+H+Roj
 oVgJ2NkXUFnLUYNme7337vGkiOFV4IbHcYZWPNecYyFWWREvqNS4+1icQVNYRMJg
 ==
X-ME-Sender: <xms:AYdwYPKZzaMyDxJ0euK7AJqmk_zIpotvhENdy0Q9IDJ3BdIbqvq1Ww>
 <xme:AYdwYDIU6IWfdekhn34O99KYU3Ed9XD9Y2Su3CpW86b3dRBlJGQaXMTrWORcRpK_S
 kbc1b3BkoixoV1wmPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddguddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepfffhieeftedvffekfeefieejtdekjeehudfgueevfeefgeehgeegtedt
 ledtgeffnecuffhomhgrihhnpeifhhhithgvqhhurghrkhdrohhrghenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgv
 thgvrhdruggvvh
X-ME-Proxy: <xmx:AYdwYHvdbXdfDlTUiN_GIp9FzNqtFR33A4QbwBQUcNF4iBuvULDWyQ>
 <xmx:AYdwYIY7C6tdZ4FE3UerGPYVroptvgjaywbTK2Pmx156ZSYN1Z_MHw>
 <xmx:AYdwYGaADjvFcZ2bbWgK66RqO40GreEftYZY0Xk0ih7YlrSZpQC5QQ>
 <xmx:A4dwYIBun1w5sBMu-nATvtYzxdDA41guOP8tQic0IVFtJ3CXDVolJ93VhK4>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 44A1351C0061; Fri,  9 Apr 2021 12:55:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <e0d9af36-fc6c-4470-a87c-61b9161bdf8f@www.fastmail.com>
In-Reply-To: <20210407104425.GB15173@willie-the-truck>
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-2-sven@svenpeter.dev>
 <20210407104425.GB15173@willie-the-truck>
Date: Fri, 09 Apr 2021 18:55:07 +0200
To: "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Hector Martin" <marcan@marcan.st>
Subject: Re: [PATCH v2 1/3] iommu: io-pgtable: add DART pagetable format
Cc: devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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



On Wed, Apr 7, 2021, at 12:44, Will Deacon wrote:
> On Sun, Mar 28, 2021 at 09:40:07AM +0200, Sven Peter wrote:
[...]
> >  
> > +static struct io_pgtable *
> > +apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > +{
> > +	struct arm_lpae_io_pgtable *data;
> > +
> > +	if (cfg->ias > 36)
> > +		return NULL;
> > +	if (cfg->oas > 36)
> > +		return NULL;
> > +
> > +	if (!cfg->coherent_walk)
> > +		return NULL;
> 
> This all feels like IOMMU-specific limitations leaking into the page-table
> code here; it doesn't feel so unlikely that future implementations of this
> IP might have greater addressing capabilities, for example, and so I don't
> see why the page-table code needs to police this.

That's true, this really doesn't belong here.
I'll fix it for the next version and make sure to keep iommu-specific
limitations inside the driver itself.


> 
> > +	cfg->pgsize_bitmap &= SZ_16K;
> > +	if (!cfg->pgsize_bitmap)
> > +		return NULL;
> 
> This is worrying (and again, I don't think this belongs here). How is this
> thing supposed to work if the CPU is using 4k pages?

This SoC is just full of fun surprises!
I didn't even think about that case since I've always been using 16k pages so far.

I've checked again and wasn't able to find any way to configure the pagesize
of the IOMMU. There seem to be variants of this IP in older iPhones which
support a 4k pagesize but to the best of my knowledge this is hard wired
and not configurable in software.

When booting with 4k pages I hit the BUG_ON in iova.c that ensures that the
iommu pagesize has to be <= the cpu page size.

I see two options here and I'm not sure I like either of them:

1) Just don't support 4k CPU pages together with IOMMU translations and only
   allow full bypass mode there.
   This would however mean that PCIe (i.e. ethernet, usb ports on the Mac
   mini) and possibly Thunderbolt support would not be possible since these
   devices don't seem to like iommu bypass mode at all.

2) I've had a brief discussion on IRC with Arnd about this [1] and he pointed
   out that the dma_map_sg API doesn't make any guarantees about the returned
   iovas and that it might be possible to make this work at least for devices
   that go through the normal DMA API.

   I've then replaced the page size check with a WARN_ON in iova.c just to see
   what happens. At least normal devices that go through the DMA API seem to
   work with my configuration. iommu_dma_alloc took the iommu_dma_alloc_remap
   path which was called with the cpu page size but then used
   domain->pgsize_bitmap to increase that to 16k. So this kinda works out, but
   there are other functions in dma-iommu.c that I believe rely on the fact that
   the iommu can map single cpu pages. This feels very fragile right now and
   would probably require some rather invasive changes.

   Any driver that tries to use the iommu API directly could be trouble
   as well if they make similar assumptions.

   Is this something you would even want to support in the iommu subsytem
   and is it even possible to do this in a sane way?


Best,


Sven


[1] https://freenode.irclog.whitequark.org/asahi/2021-04-07#29609786;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
