Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F062C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 20:20:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1C36104F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 20:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC1C36104F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92DA060798;
	Wed, 11 Aug 2021 20:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pzmmkOcU1HnS; Wed, 11 Aug 2021 20:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33F0F6072F;
	Wed, 11 Aug 2021 20:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C23AC001A;
	Wed, 11 Aug 2021 20:20:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 002C2C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 20:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D038140502
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 20:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="b64xL5cJ";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="FF5wqQcI"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wt47LmLCJzoy for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:20:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 558F54048C
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 20:20:48 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 2154C5C010B;
 Wed, 11 Aug 2021 16:20:47 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Wed, 11 Aug 2021 16:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=7fkPLfKbxa0wqLdybdh/2UwMGYWz
 xlG6ejMw/dsNXA8=; b=b64xL5cJEbMyETJPKEuIv/c0I5VUqYrLOWWxhOB7Y50d
 0nWdjRvYWPmmB0fQzjZvZLYsMMIPa8znN950HlcZ8B5pi1XmRaN/zE+tFAdmHMyU
 Xq3Ux/Bx5gRvdzOksoDaZuM8BwfWIPhY2GFtiVgFW7xh89vqB/xS4fy5D3kgnfTC
 UWAK9WlfeGqGU2XNnwVHk1HD9T6OBFizl9Qv7bFDXx9e5sV/wYuT7JQDy+YHptbE
 X/lR0S1gJAX+RXajd6VyrRLhzP79jCcsUJ1YMb6LAQqmP5cG7v7WtxDz94MqoaFS
 L1r+NIUYqc4fII1LewIMFuMe2bBz8/vAdOCQuSlRqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7fkPLf
 Kbxa0wqLdybdh/2UwMGYWzxlG6ejMw/dsNXA8=; b=FF5wqQcIrKApBju5rQgaU7
 0edML8se30kYJsySEZZ87j46ObiGFnRzygXNRLP6gVA90f7lZg3GVOmwLSOIQlRu
 jvoIlznlI03ytfK/kCAQbB5AgZ+elfFHb+QymbpmUqdIXlM341Vu0+meyYK+Rlq3
 rFK9z/YivuT4hriAJv5+4Me9/lMtPdHp9cETzbVdT+1rJGWioGQmkD3BbaMezJT0
 8PMkh8ONSLCJQBLXD602XzG22wpnY72vvL92HkCo+sW1rFT7duWgSzbYlpVhNfnH
 UIJzqnzBIhvPJS4JN4x2uGuhDNapBbHuaOnyxQmxb8CvdZsKIEI6gGM9yBcN1Lnw
 ==
X-ME-Sender: <xms:HTEUYYlsll1W9rHzc5NNLoPtmatzsTRwQF1nYOzA7wmbzvMQ6WQBng>
 <xme:HTEUYX1o0SIK22yEjgmtOUGDviHZ_3e3fBRCNiz1pwr4cAaFpLmh7cX3aD5qQQ5rw
 LTD4vQO965qla9nNNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugddugeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeehjefgtddtfeelfeetjeeifeduueehleektdegtdejheeiteeuleehuefh
 geehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:HTEUYWojpqdY3hOcCqlqIx00enxUGVM2LWUmdR9VkRhRwNnnFlih3A>
 <xmx:HTEUYUm8KXyp7cc4Qxup3rG-4YxNA7YLH7tSnlrQzCwGNxo44P_j6Q>
 <xmx:HTEUYW2FfnoT0iAaz4pwZdUQOUjEsy0HNs8586MYvsF1mCwwjkq7tg>
 <xmx:HzEUYS_Lh86PqaZHvI5j6HmZp-OYmdhdzDvJW0JMJ7olK2FiTSoMIw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 3A46251C0060; Wed, 11 Aug 2021 16:20:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <7b6cf00c-86ea-43c4-861f-f1cc32d5852d@www.fastmail.com>
In-Reply-To: <a721f8e3-4c1d-afb2-3ae2-eb1360e1eaca@arm.com>
References: <20210806155523.50429-1-sven@svenpeter.dev>
 <20210806155523.50429-3-sven@svenpeter.dev>
 <d289a555-9e3b-b948-1883-2ee4c915da4c@arm.com>
 <dadbd8b0-171a-4008-8a2e-f68abfed9285@www.fastmail.com>
 <5002ed91-416c-d7ee-b1ab-a50c590749c2@arm.com>
 <cf78f795-1e75-45c9-a759-018f17cfaed9@www.fastmail.com>
 <a721f8e3-4c1d-afb2-3ae2-eb1360e1eaca@arm.com>
Date: Wed, 11 Aug 2021 22:18:32 +0200
To: "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux-foundation.org
Subject: =?UTF-8?Q?Re:_[RFC_PATCH_2/3]_iommu/dma-iommu:_Support_iovad->granule_>_?=
 =?UTF-8?Q?PAGE=5FSIZE?=
Cc: Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Will Deacon <will@kernel.org>
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



On Tue, Aug 10, 2021, at 11:51, Robin Murphy wrote:
> On 2021-08-09 21:45, Sven Peter wrote:
> > 
> > 
> > On Mon, Aug 9, 2021, at 19:41, Robin Murphy wrote:
> >> On 2021-08-07 12:47, Sven Peter via iommu wrote:
> >>>
> >>>
> >>> On Fri, Aug 6, 2021, at 20:04, Robin Murphy wrote:
> >>>> On 2021-08-06 16:55, Sven Peter via iommu wrote:
> >>>>> @@ -1006,6 +1019,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >>>>>     	if (dev_is_untrusted(dev))
> >>>>>     		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
> >>>>>     
> >>>>> +	/*
> >>>>> +	 * If the IOMMU pagesize is larger than the CPU pagesize we will
> >>>>> +	 * very likely run into sgs with a physical address that is not aligned
> >>>>> +	 * to an IOMMU page boundary. Fall back to just mapping every entry
> >>>>> +	 * independently with __iommu_dma_map then.
> >>>>
> >>>> Scatterlist segments often don't have nicely aligned ends, which is why
> >>>> we already align things to IOVA granules in main loop here. I think in
> >>>> principle we'd just need to move the non-IOVA-aligned part of the
> >>>> address from sg->page to sg->offset in the temporary transformation for
> >>>> the rest of the assumptions to hold. I don't blame you for being timid
> >>>> about touching that, though - it took me 3 tries to get right when I
> >>>> first wrote it...
> >>>>
> >>>
> >>>
> >>> I've spent some time with that code now and I think we cannot use it
> >>> but have to fall back to iommu_dma_map_sg_swiotlb (even though that swiotlb
> >>> part is a lie then):
> >>>
> >>> When we have sg_phys(s) = 0x802e65000 with s->offset = 0 the paddr
> >>> is aligned to PAGE_SIZE but has an offset of 0x1000 from something
> >>> the IOMMU can map.
> >>> Now this would result in s->offset = -0x1000 which is already weird
> >>> enough.
> >>> Offset is unsigned (and 32bit) so this will actually look like
> >>> s->offset = 0xfffff000 then, which isn't much better.
> >>> And then sg_phys(s) = 0x902e64000 (instead of 0x802e64000) and
> >>> we'll map some random memory in iommu_map_sg_atomic and a little bit later
> >>> everything explodes.
> >>>
> >>> Now I could probably adjust the phys addr backwards and make sure offset is
> >>> always positive (and possibly larger than PAGE_SIZE) and later restore it
> >>> in __finalise_sg then but I feel like that's pushing this a little bit too far.
> >>
> >> Yes, that's what I meant. At a quick guess, something like the
> >> completely untested diff below.
> > 
> > That unfortunately results in unaligned mappings
> 
> You mean it even compiles!? :D

I was more impressed that it already almost worked correctly :)

> 
> > [    9.630334] iommu: unaligned: iova 0xbff40000 pa 0x0000000801a3b000 size 0x4000 min_pagesz 0x4000
> > 
> > I'll take a closer look later this week and see if I can fix it.
> 
> On reflection, "s->offset ^ s_iova_off" is definitely wrong, that more 
> likely wants to be "s->offset & ~s_iova_off".
> 
> Robin.
> 


If I change

		sg_set_page(s, phys_to_page(sg_phys(s)), s_length,
			    s_iova_off & ~PAGE_MASK);

in __finalise_sg (and the same thing in __invalidate_sg) to

		sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
			    s_iova_off & ~PAGE_MASK);

then it also restores the original fields correctly.


What is the proper way to credit you for coming up with this?
Do you create the commit and I apply it to my local tree and
include it in my submission once I have fixed the other
issues? Or do I create the commit and put a Suggested-by
in the message?


Either way, here's the patch that I have right now:

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7ce74476699d..ba31dc59566d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -907,8 +907,8 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_iova_len = s->length;

-		s->offset += s_iova_off;
-		s->length = s_length;
+		sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
+			    s_iova_off & ~PAGE_MASK);
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;

@@ -952,10 +952,11 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	int i;

 	for_each_sg(sg, s, nents, i) {
-		if (sg_dma_address(s) != DMA_MAPPING_ERROR)
-			s->offset += sg_dma_address(s);
 		if (sg_dma_len(s))
-			s->length = sg_dma_len(s);
+			sg_set_page(s,
+				    phys_to_page(sg_phys(s) + sg_dma_address(s)),
+				    sg_dma_len(s),
+				    sg_dma_address(s) & ~PAGE_MASK);
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 	}
@@ -1031,15 +1032,16 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	 * stashing the unaligned parts in the as-yet-unused DMA fields.
 	 */
 	for_each_sg(sg, s, nents, i) {
-		size_t s_iova_off = iova_offset(iovad, s->offset);
+		phys_addr_t s_phys = sg_phys(s);
+		size_t s_iova_off = iova_offset(iovad, s_phys);
 		size_t s_length = s->length;
 		size_t pad_len = (mask - iova_len + 1) & mask;

 		sg_dma_address(s) = s_iova_off;
 		sg_dma_len(s) = s_length;
-		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
-		s->length = s_length;
+		sg_set_page(s, phys_to_page(s_phys - s_iova_off),
+			    s_length, s->offset & ~s_iova_off);

 		/*
 		 * Due to the alignment of our single IOVA allocation, we can





Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
