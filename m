Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A7FC4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 20:00:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B32A6101D
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 20:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B32A6101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF19A403BA;
	Mon,  9 Aug 2021 20:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KmfXFTohHgSw; Mon,  9 Aug 2021 20:00:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B956400DF;
	Mon,  9 Aug 2021 20:00:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F2C0C001A;
	Mon,  9 Aug 2021 20:00:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 410B0C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 20:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2150540255
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 20:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="JoFHm6xV";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="Dibqg7J9"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hnLNxgvT7Nwd for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 20:00:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 438BB4020E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 20:00:40 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 6CFF75C0175;
 Mon,  9 Aug 2021 16:00:37 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Mon, 09 Aug 2021 16:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=NCzE+UNK0oHXikeDm9/TFSt0srWe
 0efxOGVKtt4tKPQ=; b=JoFHm6xVkVXR6bI7xK3QSW5dE725j8ukdIiepfPIBRII
 Ya0S0LwbYVGu+u0HYu2lIW1aGbRiXj2TZCHZXb+6tqqnY3MsD7W6aQqiBlTIc24f
 4QZA5Xvr3RCRAq6GJEK9ejEe1WRhwPBV0gV/1uzL8eaGXX5qXmQeDDRaJqyNqBZg
 zcb1knJ7JcI0brPK9abW7uGap6D1OlfwUTt4mXUfW0MA9ri5WOoC09d/0wNBz918
 5Z4YlLkBhsZQ7+BOzTkDaNUBRxKhAu8pX/KEw2KWbEm7f6QenWHcW28oDkqct9Qw
 oEc5YUJq+Z3/5t3l0DnkXeKkX7qCi9AnZb1xiLwNFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NCzE+U
 NK0oHXikeDm9/TFSt0srWe0efxOGVKtt4tKPQ=; b=Dibqg7J9kBt51Llrtu9B0u
 zTJeGNgqv05wMzjkmq3b29sfaKZJtuB47lav9fKwuwh6ZUy+/uuicjny1Of+zInb
 jsmuG31gv+S0lHeP/2A5uKS+e88hJvy0la4lWNICxD2E/nW58K0xd3nA35x1IsCM
 w8fVn2jvNvxnctkzdXERMX6LWlQHp9RTR4mSmubXbQHPW+34k4qnaeUOv6nbMQRz
 98C0OvuhPdtJyGUS8K0hEmPsEKCG4Bi+t8aT7sZJT581Xigky9G8w/SK06HKgGDy
 JRKrBbqDGofyVLUJ8euYFd0OzLbC3NKzd6x2R8wmDfGkx9wprSk1zD7bKd535JFw
 ==
X-ME-Sender: <xms:Y4kRYaGi-Bq88vve5Hd2siaL7u_eWtONeNwZOMjh0En5awTAhBhErQ>
 <xme:Y4kRYbUAXLAo6qwMs3WMlMxlZ6xeDdB5iDyqqcUa8GJ9LVSCsU6p9w1dCqGfWVAVe
 GH17ryEAZoZ_xekpdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgddugeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeehjefgtddtfeelfeetjeeifeduueehleektdegtdejheeiteeuleehuefh
 geehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Y4kRYUJDC1TSWFxeTyVqsNv4PKWHpswAeUlebOciyE2xd4svKYj_dQ>
 <xmx:Y4kRYUFb9GgEMDjJVWN2O4AwXgYwFMiaSbvt3B5Y-TfnMfVtxuohRg>
 <xmx:Y4kRYQUFN_R5WSTLSb1IYj-6dgmreyG5iiWzt5eqVHucDBf92jeY1A>
 <xmx:ZYkRYae4ucjBFYUHOHsgds8vVQ6lOmZfn940v_GE2HT2k_UnK-6e4Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 2904751C0060; Mon,  9 Aug 2021 16:00:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-552-g2afffd2709-fm-20210805.001-g2afffd27
Mime-Version: 1.0
Message-Id: <80e36f86-408d-48bf-8c7c-82c057f18cdb@www.fastmail.com>
In-Reply-To: <4842a557-c594-8258-6d68-465f4327e2c1@arm.com>
References: <20210806155523.50429-1-sven@svenpeter.dev>
 <20210806155523.50429-3-sven@svenpeter.dev>
 <d289a555-9e3b-b948-1883-2ee4c915da4c@arm.com>
 <4eb038a4-e47f-48b2-9359-2e65747170f8@www.fastmail.com>
 <4842a557-c594-8258-6d68-465f4327e2c1@arm.com>
Date: Mon, 09 Aug 2021 21:57:52 +0200
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

Hi,

On Mon, Aug 9, 2021, at 20:37, Robin Murphy wrote:
> On 2021-08-07 09:41, Sven Peter wrote:
> > Hi,
> > 
> > Thanks a lot for quick reply!
> > 
> > On Fri, Aug 6, 2021, at 20:04, Robin Murphy wrote:
> >> On 2021-08-06 16:55, Sven Peter via iommu wrote:
> >>> DMA IOMMU domains can support hardware where the IOMMU page size is
> >>> larger than the CPU page size.
> >>> Alignments need to be done with respect to both PAGE_SIZE and
> >>> iovad->granule. Additionally, the sg list optimization to use a single
> >>> IOVA allocation cannot be used in those cases since the physical
> >>> addresses will very likely not be aligned to the larger IOMMU page size.
> >>>
> >>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> >>> ---
> >>>    drivers/iommu/dma-iommu.c | 87 ++++++++++++++++++++++++++++++++++-----
> >>>    1 file changed, 77 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> >>> index 6f0df629353f..e072d9030d9f 100644
> >>> --- a/drivers/iommu/dma-iommu.c
> >>> +++ b/drivers/iommu/dma-iommu.c
> >>> @@ -8,6 +8,7 @@
> >>>     * Copyright (C) 2000-2004 Russell King
> >>>     */
> >>>    
> >>> +#include <linux/align.h>
> >>>    #include <linux/acpi_iort.h>
> >>>    #include <linux/device.h>
> >>>    #include <linux/dma-map-ops.h>
> >>> @@ -51,6 +52,15 @@ struct iommu_dma_cookie {
> >>>    	struct iommu_domain		*fq_domain;
> >>>    };
> >>>    
> >>> +/* aligns size to CPU and IOMMU page size */
> >>> +static inline size_t iommu_page_align(struct device *dev, size_t size)
> >>> +{
> >>> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> >>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >>> +
> >>> +	return iova_align(&cookie->iovad, PAGE_ALIGN(size));
> >>> +}
> >>> +
> >>>    static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> >>>    bool iommu_dma_forcedac __read_mostly;
> >>>    
> >>> @@ -647,6 +657,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
> >>>    /*
> >>>     * If size is less than PAGE_SIZE, then a full CPU page will be allocated,
> >>>     * but an IOMMU which supports smaller pages might not map the whole thing.
> >>> + * If the IOMMU page size is larger than the CPU page size, then the size
> >>> + * will be aligned to that granularity and some memory will be left unused.
> >>
> >> Why do we need to increase the actual memory allocation? The point here
> >> is that we allocate the smallest thing we can allocate and map the
> >> smallest thing we can map - I think that still works the "wrong" way
> >> round too, we should just need to start taking an IOVA offset into
> >> account as in dma_map_page() if we can no longer assume it's 0 for a CPU
> >> page. Sure we may expose some unrelated adjacent pages, but we'll
> >> already be doing that to excess for streaming DMA so whoop de do.
> > 
> > I agree for trusted devices, but untrusted ones (Thunderbolt, and depending on your
> > risk tolerance possibly even the broadcom wifi) might also end up calling this.
> 
> Oh, right, I hadn't considered actual untrusted device support at this 
> stage.


Me neither :-)
I did the alignment at first without thinking too much about it,
then read your reply, and only *then* realized that there are untrusted devices
for which this just happens to do the right thing (at the cost of wasting
memory for everyone else, but I'll fix that).

> 
> > For streaming DMA swiotlb will make sure that these won't see memory
> > they're not supposed to access.
> 
> I was slightly surprised to see that that does appear to work out OK, 
> but I guess SWIOTLB slots are already smaller than typical IOMMU pages, 
> so it falls out of that. Neat.
> 
> > But, at least as far as I understand it, no swiotlb is in the way to catch devices
> > who end up calling this function. That wasn't required because we used to get
> > PAGE_SIZE aligned allocation here and every IOMMU so far would be able to easily
> > map them without any spill overs.
> > But now we'll end up exposing three more unrelated pages if the allocation
> > is not increased.
> 
> Fair enough, but then why still waste memory in the (usual) cases where 
> it logically *isn't* necessary?

See above, didn't even consider this either.

I should be able to fix this by first allocating <= 3 pages to reach a
iovad->granule boundary (or just satisfy the full allocation length already),
adjust the DMA offset forward for this first allocation and then just keep
allocating iovad->granule blocks for the rest of the requested size.

The current code already does the second part and I think I'll just need
to add the first alignment part.

> 
> >>>     */
> >>>    static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
> >>>    		size_t size, struct sg_table *sgt, gfp_t gfp, pgprot_t prot,
> >>> @@ -736,7 +748,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> >>>    
> >>>    out_unmap:
> >>>    	__iommu_dma_unmap(dev, *dma_handle, size);
> >>> -	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> >>> +	__iommu_dma_free_pages(pages, iommu_page_align(dev, size) >> PAGE_SHIFT);
> >>>    	return NULL;
> >>>    }
> >>>    
> >>> @@ -766,7 +778,8 @@ static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> >>>    	struct dma_sgt_handle *sh = sgt_handle(sgt);
> >>>    
> >>>    	__iommu_dma_unmap(dev, sgt->sgl->dma_address, size);
> >>> -	__iommu_dma_free_pages(sh->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> >>> +	__iommu_dma_free_pages(sh->pages,
> >>> +		iommu_page_align(dev, size) >> PAGE_SHIFT);
> >>>    	sg_free_table(&sh->sgt);
> >>>    	kfree(sh);
> >>>    }
> >>> @@ -1006,6 +1019,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >>>    	if (dev_is_untrusted(dev))
> >>>    		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
> >>>    
> >>> +	/*
> >>> +	 * If the IOMMU pagesize is larger than the CPU pagesize we will
> >>> +	 * very likely run into sgs with a physical address that is not aligned
> >>> +	 * to an IOMMU page boundary. Fall back to just mapping every entry
> >>> +	 * independently with __iommu_dma_map then.
> >>
> >> Scatterlist segments often don't have nicely aligned ends, which is why
> >> we already align things to IOVA granules in main loop here. I think in
> >> principle we'd just need to move the non-IOVA-aligned part of the
> >> address from sg->page to sg->offset in the temporary transformation for
> >> the rest of the assumptions to hold. I don't blame you for being timid
> >> about touching that, though - it took me 3 tries to get right when I
> >> first wrote it...
> > 
> > I was a little bit afraid I'd get this exact reply :D
> > I'll try to modify the transformation again, but I'm sure it'll take me more than
> > 3 tries to get it right :)
> > 
> >>
> >>> +	 */
> >>> +	if (iovad->granule > PAGE_SIZE) {
> >>> +		for_each_sg(sg, s, nents, i) {
> >>> +			sg_dma_address(s) = __iommu_dma_map(dev, sg_phys(s),
> >>> +				s->length, prot, dma_get_mask(dev));
> >>> +			if (sg_dma_address(s) == DMA_MAPPING_ERROR)
> >>> +				break;
> >>> +			sg_dma_len(s) = s->length;
> >>> +		}
> >>> +
> >>> +		if (unlikely(i != nents)) {
> >>> +			nents = i;
> >>> +			for_each_sg(sg, s, nents, i)
> >>> +				__iommu_dma_unmap(dev, sg_dma_address(s), sg_dma_len(s));
> >>> +			return 0;
> >>> +		}
> >>> +
> >>> +		return nents;
> >>> +	}
> >>
> >> Either way, NAK to having a *third* implementation of SG mapping in this
> >> file which is fundamentally no different from the second one.
> > 
> > Good point. If for some reason I'm not able to modify the transformation correctly
> > I'll just fall back to iommu_dma_map_sg_swiotlb.
> > 
> >>
> >>> +
> >>>    	/*
> >>>    	 * Work out how much IOVA space we need, and align the segments to
> >>>    	 * IOVA granules for the IOMMU driver to handle. With some clever
> >>> @@ -1068,6 +1106,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >>>    static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> >>>    		int nents, enum dma_data_direction dir, unsigned long attrs)
> >>>    {
> >>> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> >>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >>> +	struct iova_domain *iovad = &cookie->iovad;
> >>>    	dma_addr_t start, end;
> >>>    	struct scatterlist *tmp;
> >>>    	int i;
> >>> @@ -1080,6 +1121,17 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> >>>    		return;
> >>>    	}
> >>>    
> >>> +	/*
> >>> +	 * If the IOMMU pagesize is larger than the CPU pagesize we mapped
> >>> +	 * every entry indepedently with __iommu_dma_map then. Let's do the
> >>> +	 * opposite here.
> >>> +	 */
> >>> +	if (iovad->granule > PAGE_SIZE) {
> >>> +		for_each_sg(sg, tmp, nents, i)
> >>> +			__iommu_dma_unmap(dev, sg_dma_address(tmp), sg_dma_len(tmp));
> >>> +		return;
> >>> +	}
> >>
> >> As above, this is just __iommu_dma_unmap_sg_swiotlb() with fewer clothes on.
> >>
> >>> +
> >>>    	/*
> >>>    	 * The scatterlist segments are mapped into a single
> >>>    	 * contiguous IOVA allocation, so this is incredibly easy.
> >>> @@ -1110,7 +1162,7 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> >>>    
> >>>    static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
> >>>    {
> >>> -	size_t alloc_size = PAGE_ALIGN(size);
> >>> +	size_t alloc_size = iommu_page_align(dev, size);
> >>>    	int count = alloc_size >> PAGE_SHIFT;
> >>>    	struct page *page = NULL, **pages = NULL;
> >>>    
> >>> @@ -1150,7 +1202,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
> >>>    		struct page **pagep, gfp_t gfp, unsigned long attrs)
> >>>    {
> >>>    	bool coherent = dev_is_dma_coherent(dev);
> >>> -	size_t alloc_size = PAGE_ALIGN(size);
> >>> +	size_t alloc_size = iommu_page_align(dev, size);
> >>>    	int node = dev_to_node(dev);
> >>>    	struct page *page = NULL;
> >>>    	void *cpu_addr;
> >>> @@ -1201,8 +1253,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
> >>>    
> >>>    	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> >>>    	    !gfpflags_allow_blocking(gfp) && !coherent)
> >>> -		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> >>> -					       gfp, NULL);
> >>> +		page = dma_alloc_from_pool(dev, iommu_page_align(dev, size),
> >>> +					       &cpu_addr, gfp, NULL);
> >>>    	else
> >>>    		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
> >>>    	if (!cpu_addr)
> >>> @@ -1253,6 +1305,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >>>    		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >>>    		unsigned long attrs)
> >>
> >> Can we just not bother trying to support this? TBH I don't know exactly
> >> how the interface is supposed to work - what you're doing here looks
> >> like it's probably either too much or not enough, depending on whether
> >> the address and size arguments are supposed to allow representing
> >> partial buffers - and frankly I can't imagine you'll be needing to
> >> support dma-buf exports from the USB/ethernet/wifi drivers any time soon...
> > 
> > I'm not really sure how this is going to work even before my changes.
> > Just from reading the code it looks like even then it might be doing too much
> > or too little.
> > But this will also be used for Thunderbolt and who knows what kind of devices
> > will be connected there. I'm fine with just not supporting this interface unless
> > something actually breaks for some user though.
> 
> I would bet that the set of random Thunderbolt-attachable devices which 
> participate in dma-buf exports and the set of media devices which expect 
> vb2_dma_contig to work for arbitrary user buffers have a non-empty 
> intersection. If you eat your cake you may subsequently discover that 
> you no longer have your cake ;)

:D

> 
> If we can't easily test it or reason about it, let's not pretend to 
> implement it. I'd rather somebody discovered the lack of working support 
> in a few years' time because it reliably and safely returned an error, 
> rather than because it ate their page cache. Besides, it's not like 
> people can't use a kernel built with the right PAGE_SIZE (which might 
> perform better anyway) and not have the problem in the first place.

Good points, I'll just add if (iovad->granule > PAGE_SIZE) return -ENXIO;
here which should be equivalent to having no get_sgtable in dma_map_ops.

> 
> >>>    {
> >>> +	size_t aligned_size = iommu_page_align(dev, size);
> >>>    	struct page *page;
> >>>    	int ret;
> >>>    
> >>> @@ -1261,7 +1314,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >>>    
> >>>    		if (pages) {
> >>>    			return sg_alloc_table_from_pages(sgt, pages,
> >>> -					PAGE_ALIGN(size) >> PAGE_SHIFT,
> >>> +					aligned_size >> PAGE_SHIFT,
> >>>    					0, size, GFP_KERNEL);
> >>>    		}
> >>>    
> >>> @@ -1272,7 +1325,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >>>    
> >>>    	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> >>>    	if (!ret)
> >>> -		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> >>> +		sg_set_page(sgt->sgl, page, aligned_size, 0);
> >>>    	return ret;
> >>>    }
> >>>    
> >>> @@ -1283,11 +1336,25 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> >>>    	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
> >>>    }
> >>>    
> >>> +static struct page *iommu_dma_alloc_aligned_pages(struct device *dev, size_t size,
> >>> +		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
> >>> +{
> >>> +	size = iommu_page_align(dev, size);
> >>> +	return dma_common_alloc_pages(dev, size, dma_handle, dir, gfp);
> >>> +}
> >>> +
> >>> +static void iommu_dma_free_aligned_pages(struct device *dev, size_t size, struct page *page,
> >>> +		dma_addr_t dma_handle, enum dma_data_direction dir)
> >>> +{
> >>> +	size = iommu_page_align(dev, size);
> >>> +	return dma_common_free_pages(dev, size, page, dma_handle, dir);
> >>> +}
> >>
> >> Again, what's the point of these? iommu_dma_map_page() still has to cope
> >> with whatever the caller provides, so there's no difference in the one
> >> case when that caller happens to be dma_common_map_pages().
> > 
> > Same as above, untrusted devices.
> 
> Again fair enough, but in that case do it for untrusted devices. Not for 
> the whole world for most of whom it still *is* a needless waste.

Yeah, agreed!

> 
> Robin.
> 


Best,

Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
