Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3B5C433F5
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 18:19:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC5361057
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 18:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFC5361057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8B8FD40151;
	Thu,  2 Sep 2021 18:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1qe2xq-ZjgFj; Thu,  2 Sep 2021 18:19:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6FC8940104;
	Thu,  2 Sep 2021 18:19:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55B8DC001A;
	Thu,  2 Sep 2021 18:19:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5999C000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 18:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B317840151
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 18:19:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LEu5J0iMwl-A for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 18:19:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C89B40104
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 18:19:39 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 5AB1B5C01ED;
 Thu,  2 Sep 2021 14:19:36 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Thu, 02 Sep 2021 14:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=rWeCfc9VwEpivgH3ElxeF4AP9Em0
 hx7fi+pEfHiMVP4=; b=AuInL9tN1I1ovcXm4oG4VDeb5jtx8G5LKfAsBPLTi6Lf
 dnZAs/tBmxQBlex49291A2gqYLEcepIl5T7llHDUrBvJkRRHWXY/SfqfFloLxwUM
 fIWQ7LmoGv4Oc+uxNQH5TsXifPiY0sCO/gAzY3z6DSKJYEsExMZXbII69AoqY22l
 Bm4dJHFQn+YRHScbkKXtHyqBVhE1P083J6RZhUYPNFyud+JSzRNV++MHS+iEk6ci
 PoERh7wq7dUbh0ygvb39am+89kbKIdeFfolYAB6G/oh3vd6oYLY4aAM2PBRWZE0S
 iMm1hfgO+/YQjr5E8Ih5NkA0H4Gza0XUDW5QzQizVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rWeCfc
 9VwEpivgH3ElxeF4AP9Em0hx7fi+pEfHiMVP4=; b=G2ACLst9n6EmcBeuB8t9Cn
 UBicpUedbICpaGir/glrW/F8YtEdsTQdUGbkupVVEgEt0yxShv1Zx/tW5wZK944B
 IzbJZxfsh6km8yo1bOllE/K/D9CXaqHmRIoWOcwMybF7ZNwCJ4VbyKpPkQw32AwD
 /mpI5FdyNtBjj8tlCMVR4SeT1+DnkjkWVWyhuVSWnbfRfHbtYhSlYcaLPzkVgEI9
 0fm7ydZz79dAdthQ8FdjXtgz5r9JVZCM9SXVoDXdj7VzrfdMR/smQne6fQ6A9qRA
 oEZXqavnx4GHO8CDDelMs03dJf7ZngDiWXGHoPDH8ZX56gyWWE2qSEIjkf5Xqofw
 ==
X-ME-Sender: <xms:thUxYVZuhxZYcoe_qdFU0FdyQ4gCxYPYbOaeeJlRqbKTPEYbZjrmUA>
 <xme:thUxYcZaCdjbboWop334Ue9vAs-H740nzRJW12JLCekcEGHoQbH6l2fCasjsD1-42
 zkeS9TE3tgzcLuj8d8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvhedguddvgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepheejgfdttdefleefteejieefudeuheelkedtgedtjeehieetueelheeu
 hfegheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:thUxYX_icb1Yp-gID7QAuwGMOImvvcuh6gjHKsc6OX1BV5lXF3Ifxg>
 <xmx:thUxYTr28i5ympL4m7VJYC9L6G7dTTPSozfvQEfsZ6b3izsU5zyvuw>
 <xmx:thUxYQq3ZszLDwtsPx25SdK5ff4GnVjVRxdxzyQ2Vw8C8cH9Drpn4Q>
 <xmx:uBUxYYIiN0F8L85rZKUf0uGrySzkqfGJkE9RfT4WvNi65pZzcH7qGg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 8810451C0060; Thu,  2 Sep 2021 14:19:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <ac34e920-d1b4-4044-a8fe-5172d5ebfa9c@www.fastmail.com>
In-Reply-To: <YS/sMckPUJRMYwYq@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-4-sven@svenpeter.dev> <YS6fasuqPURbmC6X@sunset>
 <c8bc7f77-3b46-4675-a642-76871fcec963@www.fastmail.com>
 <YS/sMckPUJRMYwYq@sunset>
Date: Thu, 02 Sep 2021 20:19:14 +0200
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_3/8]_iommu/dma:_Disable_get=5Fsgtable_for_granul?=
 =?UTF-8?Q?e_>_PAGE=5FSIZE?=
Cc: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 Sven Peter <iommu@lists.linux-foundation.org>,
 Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>
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



On Wed, Sep 1, 2021, at 23:10, Alyssa Rosenzweig wrote:
> > My biggest issue is that I do not understand how this function is supposed
> > to be used correctly. It would work fine as-is if it only ever gets passed buffers
> > allocated by the coherent API but there's not way to check or guarantee that.
> > There may also be callers making assumptions that no longer hold when
> > iovad->granule > PAGE_SIZE.
> > 
> > Regarding your case: I'm not convinced the function is meant to be used there.
> > If I understand it correctly, your code first allocates memory with dma_alloc_coherent
> > (which possibly creates a sgt internally and then maps it with iommu_map_sg),
> > then coerces that back into a sgt with dma_get_sgtable, and then maps that sgt to
> > another iommu domain with dma_map_sg while assuming that the result will be contiguous
> > in IOVA space. It'll work out because dma_alloc_coherent is the very thing
> > meant to allocate pages that can be mapped into kernel and device VA space
> > as a single contiguous block and because both of your IOMMUs are different
> > instances of the same HW block. Anything allocated by dma_alloc_coherent for the
> > first IOMMU will have the right shape that will allow it to be mapped as
> > a single contiguous block for the second IOMMU.
> > 
> > What could be done in your case is to instead use the IOMMU API,
> > allocate the pages yourself (while ensuring the sgt your create is made up
> > of blocks with size and physaddr aligned to max(domain_a->granule, domain_b->granule))
> > and then just use iommu_map_sg for both domains which actually comes with the
> > guarantee that the result will be a single contiguous block in IOVA space and
> > doesn't required the sgt roundtrip.
> 
> In principle I agree. I am getting the sense this function can't be used
> correctly in general, and yet is the function that's meant to be used.
> If my interpretation of prior LKML discussion holds, the problems are
> far deeper than my code or indeed page size problems...

Right, which makes reasoning about this function and its behavior if the
IOMMU pages size is unexpected very hard for me. I'm not opposed to just
keeping this function as-is when there's a mismatch between PAGE_SIZE and
the IOMMU page size (and it will probably work that way) but I'd like to
be sure that won't introduce unexpected behavior. 

> 
> If the right way to handle this is with the IOMMU and IOVA APIs, I really wish
> that dance were wrapped up in a safe helper function instead of open
> coding it in every driver that does cross device sharing.
> 
> We might even call that helper... hmm... dma_map_sg.... *ducks*
> 

There might be another way to do this correctly. I'm likely just a little
bit biased because I've spent the past weeks wrapping my head around the
IOMMU and DMA APIs and when all you have is a hammer everything looks like
a nail.

But dma_map_sg operates at the DMA API level and at that point the dma-ops
for two different devices could be vastly different. 
In the worst case one of them could be behind an IOMMU that can easily map
non-contiguous pages while the other one is directly connected to the bus and
can't even access >4G pages without swiotlb support.
It's really only possible to guarantee that it will map N buffers to <= N
DMA-addressable buffers (possibly by using an IOMMU or swiotlb internally) at
that point.

On the IOMMU API level you have much more information available about the actual
hardware and can prepare the buffers in a way that makes both devices happy.
That's why iommu_map_sgtable combined with iovad->granule aligned sgt entries
can actually guarantee to map the entire list to a single contiguous IOVA block.


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
