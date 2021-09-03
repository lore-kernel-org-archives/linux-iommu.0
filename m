Return-Path: <SRS0=hF+p=NZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A2CC433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 15:17:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B613A610E6
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 15:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B613A610E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F9FD83EB3;
	Fri,  3 Sep 2021 15:17:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VFGrRRaljhzz; Fri,  3 Sep 2021 15:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 257F283EB5;
	Fri,  3 Sep 2021 15:17:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 004E1C001A;
	Fri,  3 Sep 2021 15:17:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEDD4C000E
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 15:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A14176064B
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 15:17:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="Al+OlNyj";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="nNeNU1Kk"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DNXPfr8u1SEM for <iommu@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 15:17:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 934CB6059F
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 15:17:22 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 416075C00BA;
 Fri,  3 Sep 2021 11:17:21 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Fri, 03 Sep 2021 11:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=7HxKkmdQoZbptZHjwlVg1na/5FWb
 mQRLU/ylsEHPIr0=; b=Al+OlNyjlZk0HR4z3iqgOKAt8Md2Vq78p5Ux7wxA4yai
 3bjGrhLs8qhu30BaspGBBS+vQCeY+Vvl1+LeMBzoBh5lFfj/cbXM2aUZHtJ+O+ti
 6JV9AKi6nQ9Q4uuam+QPpMWdOwwsjc3RDKJkpFmmhWIfn3p9JT5LeTwhRaZmUOlW
 q/hIoE+6edG3jKCfpws7rdJOUrgXYKYg5l7r4LOkq3ozGwFAZJPU5ARjEe6MCA++
 c3RkYhxHHObk3rdhcEeJhS38xzYBPRAZwxaSiUaND2xFBLd1OHBGa30qexBzD5vF
 7OLtHIfPluUQY9yq0zSgfpGfgixhg7OX5/IhLQVf6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7HxKkm
 dQoZbptZHjwlVg1na/5FWbmQRLU/ylsEHPIr0=; b=nNeNU1Kkgq5QyUiuNp2Sqr
 fC2MDYOMWtzM7IRfQGIziC7iQSD3Rq1VQlCtO3A6rOiDmGQPrWcrcSt0uS3KvA2Q
 EHNeYFaFWp5jhAZqhnOOfe+PnOy9bJkqkCfldEbpHbojLZEVstNIYEygTE/evtLp
 6mdwgTXEkK162GhlVFGMpcnSDKZSuW6m/YQhfPax9Bqayiv4vDDpetha6Jo0qRUN
 fqh9k/Su4JPcc/37GYIJ4d5ZNuvxNjYi5lRrF9r90GtKZZnKd+ME2kxgH93HCOQT
 EqjbEUc3xUx+gUzPqYAttK0NggcFeHDStnpdLjlq7e51NiqBqROeL0N1vdIa9AXg
 ==
X-ME-Sender: <xms:fzwyYUZGuz-xbuGrJTGnc1EDJnENI2zEfX7jYr_ZZRBJ3trlobROzg>
 <xme:fzwyYfbrXSgGeGSFd40_5Vd2I_K5kAEpgvCYcYkYrMmWdWS2DrP4YAntVeYLvnoRj
 IfO6CFlkjWse_kVr-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgkeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeehjefgtddtfeelfeetjeeifeduueehleektdegtdejheeiteeuleehuefh
 geehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:fzwyYe_TJGR0guxiT47JSDvvt5fXynPypoGz_zOF95pw9abtIHVJ_w>
 <xmx:fzwyYepiTqFtGX191mbfXLXGV5ncgsF-M9Kf3MmaExsQ6B164HVLIQ>
 <xmx:fzwyYfodOnP-0On5Uge6pVTRbEC_d8PCTVc4PSRnedIaLurQDJtRcw>
 <xmx:gTwyYbJfkhl09-_3VGT2XkcTuk7qN9-34_Z1qZ0PN8Bsaln7ahnAAg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B854051C0026; Fri,  3 Sep 2021 11:17:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <989af5a3-8c84-4796-adb6-af9426d68b76@www.fastmail.com>
In-Reply-To: <74621c69-ef68-c12a-3770-319cb7a0db73@arm.com>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-4-sven@svenpeter.dev> <YS6fasuqPURbmC6X@sunset>
 <c8bc7f77-3b46-4675-a642-76871fcec963@www.fastmail.com>
 <YS/sMckPUJRMYwYq@sunset>
 <ac34e920-d1b4-4044-a8fe-5172d5ebfa9c@www.fastmail.com>
 <74621c69-ef68-c12a-3770-319cb7a0db73@arm.com>
Date: Fri, 03 Sep 2021 17:16:59 +0200
To: "Robin Murphy" <robin.murphy@arm.com>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_3/8]_iommu/dma:_Disable_get=5Fsgtable_for_granul?=
 =?UTF-8?Q?e_>_PAGE=5FSIZE?=
Cc: Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Sven Peter <iommu@lists.linux-foundation.org>,
 Alexander Graf <graf@amazon.com>,
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



On Thu, Sep 2, 2021, at 21:42, Robin Murphy wrote:
> On 2021-09-02 19:19, Sven Peter wrote:
> > 
> > 
> > On Wed, Sep 1, 2021, at 23:10, Alyssa Rosenzweig wrote:
> >>> My biggest issue is that I do not understand how this function is supposed
> >>> to be used correctly. It would work fine as-is if it only ever gets passed buffers
> >>> allocated by the coherent API but there's not way to check or guarantee that.
> >>> There may also be callers making assumptions that no longer hold when
> >>> iovad->granule > PAGE_SIZE.
> >>>
> >>> Regarding your case: I'm not convinced the function is meant to be used there.
> >>> If I understand it correctly, your code first allocates memory with dma_alloc_coherent
> >>> (which possibly creates a sgt internally and then maps it with iommu_map_sg),
> >>> then coerces that back into a sgt with dma_get_sgtable, and then maps that sgt to
> >>> another iommu domain with dma_map_sg while assuming that the result will be contiguous
> >>> in IOVA space. It'll work out because dma_alloc_coherent is the very thing
> >>> meant to allocate pages that can be mapped into kernel and device VA space
> >>> as a single contiguous block and because both of your IOMMUs are different
> >>> instances of the same HW block. Anything allocated by dma_alloc_coherent for the
> >>> first IOMMU will have the right shape that will allow it to be mapped as
> >>> a single contiguous block for the second IOMMU.
> >>>
> >>> What could be done in your case is to instead use the IOMMU API,
> >>> allocate the pages yourself (while ensuring the sgt your create is made up
> >>> of blocks with size and physaddr aligned to max(domain_a->granule, domain_b->granule))
> >>> and then just use iommu_map_sg for both domains which actually comes with the
> >>> guarantee that the result will be a single contiguous block in IOVA space and
> >>> doesn't required the sgt roundtrip.
> >>
> >> In principle I agree. I am getting the sense this function can't be used
> >> correctly in general, and yet is the function that's meant to be used.
> >> If my interpretation of prior LKML discussion holds, the problems are
> >> far deeper than my code or indeed page size problems...
> > 
> > Right, which makes reasoning about this function and its behavior if the
> > IOMMU pages size is unexpected very hard for me. I'm not opposed to just
> > keeping this function as-is when there's a mismatch between PAGE_SIZE and
> > the IOMMU page size (and it will probably work that way) but I'd like to
> > be sure that won't introduce unexpected behavior.
> > 
> >>
> >> If the right way to handle this is with the IOMMU and IOVA APIs, I really wish
> >> that dance were wrapped up in a safe helper function instead of open
> >> coding it in every driver that does cross device sharing.
> >>
> >> We might even call that helper... hmm... dma_map_sg.... *ducks*
> >>
> > 
> > There might be another way to do this correctly. I'm likely just a little
> > bit biased because I've spent the past weeks wrapping my head around the
> > IOMMU and DMA APIs and when all you have is a hammer everything looks like
> > a nail.
> > 
> > But dma_map_sg operates at the DMA API level and at that point the dma-ops
> > for two different devices could be vastly different.
> > In the worst case one of them could be behind an IOMMU that can easily map
> > non-contiguous pages while the other one is directly connected to the bus and
> > can't even access >4G pages without swiotlb support.
> > It's really only possible to guarantee that it will map N buffers to <= N
> > DMA-addressable buffers (possibly by using an IOMMU or swiotlb internally) at
> > that point.
> > 
> > On the IOMMU API level you have much more information available about the actual
> > hardware and can prepare the buffers in a way that makes both devices happy.
> > That's why iommu_map_sgtable combined with iovad->granule aligned sgt entries
> > can actually guarantee to map the entire list to a single contiguous IOVA block.
> 
> Essentially there are two reasonable options, and doing pretend dma-buf 
> export/import between two devices effectively owned by the same driver 
> is neither of them. Handily, DRM happens to be exactly where all the 
> precedent is, too; unsurprisingly this is not a new concern.
> 
> One is to go full IOMMU API, like rockchip or tegra, attaching the 
> relevant devices to your own unmanaged domain(s) and mapping pages 
> exactly where you choose. You still make dma_map/dma_unmap calls for the 
> sake of cache maintenance and other housekeeping on the underlying 
> memory, but you ignore the provided DMA addresses in favour of your own 
> IOVAs when it comes to programming the devices.
> 
> The lazier option if you can rely on all relevant devices having equal 
> DMA and IOMMU capabilities is to follow exynos, and herd the devices 
> into a common default domain. Instead of allocating you own domain, you 
> grab the current domain for one device (which will be its default 
> domain) and manually attach the other devices to that. Then you forget 
> all about IOMMUs but make sure to do all your regular DMA API calls 
> using that first device, and the DMA addresses which come back should be 
> magically valid for the other devices too. It was a bit of a cheeky hack 
> TBH, but I'd still much prefer more of that over any usage of 
> get_sgtable outside of actual dma-buf...
> 
> Note that where multiple IOMMU instances are involved, the latter 
> approach does depend on the IOMMU driver being able to support sharing a 
> single domain across them; I think that might sort-of-work for DART 
> already, but may need a little more attention.

It'll work for two streams inside the same DART but needs some
attention for streams from two separate DARTs.

Then there's also this amazing "feature" that the display controller DART
pagetable pointer register is read-only so that we have to reuse the memory
Apple configured for first level table. That needs some changes anyway
but might make adding multiple devices from different groups more complex.



Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
