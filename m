Return-Path: <SRS0=cYM7=M6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50861C4338F
	for <iommu@archiver.kernel.org>; Sat,  7 Aug 2021 08:41:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABEF61158
	for <iommu@archiver.kernel.org>; Sat,  7 Aug 2021 08:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CABEF61158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 762CD606BA;
	Sat,  7 Aug 2021 08:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id epe3QN7GhE4y; Sat,  7 Aug 2021 08:41:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E26E9605F8;
	Sat,  7 Aug 2021 08:41:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3B49C001A;
	Sat,  7 Aug 2021 08:41:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D49EC000E
 for <iommu@lists.linux-foundation.org>; Sat,  7 Aug 2021 08:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67663403DE
 for <iommu@lists.linux-foundation.org>; Sat,  7 Aug 2021 08:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="KjQSVOoE";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="i8UfcPCc"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQBg7gevidTo for <iommu@lists.linux-foundation.org>;
 Sat,  7 Aug 2021 08:41:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A313403CF
 for <iommu@lists.linux-foundation.org>; Sat,  7 Aug 2021 08:41:34 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 4A7865C00E5;
 Sat,  7 Aug 2021 04:41:30 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Sat, 07 Aug 2021 04:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=bWVBCXm6xIo1clxwQws8ac98jkfS
 pMHbby7d8fcu2vU=; b=KjQSVOoE0yzmjolt48ZodMxb+g+yyNx0NMyxDVMQc8Un
 /NqcpFWwGlV5FvtXkrVzwJJ8djM/nq+mCPyXGuBuHfBwWFqylWDRoPsmKRWlY2cm
 u/XdxVJ7tz1RhYledSUYzlWOUQBiebrW+1pLw1FfLY3zh8VDaRkG6TuwkD0iHE6i
 531r7phK1hSc1Sq66sbOGWGZni+1UQ7utrbFFQxM/gjGdUjHomrdE0FnkqOX0NoB
 hswOBahnv/O1hpccowwX1btP1peAHqzNFPrpObnpNbGtJGVie9NSY7f31GTEB3Jn
 6bwa63Cyn3kWJqlfyYjaDK60zX1x4A2CH85CtFM8ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bWVBCX
 m6xIo1clxwQws8ac98jkfSpMHbby7d8fcu2vU=; b=i8UfcPCcPyCn3TJP3iQeh7
 /OxzAsl0ZXR85/yMhmdr2xNMT+R0PxHXpZIt7loljxXZyEU3tlrzY2drJOePayYj
 28igEWHt/K7pLjzmsmGhBmMucwm+9M4qhK3Lp/0IrRUgTb6AXFe50beR+lrwamQY
 3Mb7QO0n17hbWgcHoyjmB0oC02xoZvGSZ7D+cgJr8zT19gf7rIDaUjFDhVPAws1d
 HdRBFsTDgG/Lz2ae5LaDc5cVTj9jXl19fxHOltTXliRZ6DRENts9b1BNJiBN56so
 fwjRiYBsMzGsVVxM1uYxCJw1KjCOAILxHDVWvzRbaJUJyaifzYldbY7BpbVuiSBg
 ==
X-ME-Sender: <xms:OUcOYdiNDVGl5y16O30Z8c-LNvOI2WJ9_rwysxcBrreLid44VQ1qww>
 <xme:OUcOYSCRSwthlFa2Sdl18NF9M9cwIZ3SEpSqRo-zWspJdr8VCQD6H-nGH7Z4QGdbn
 gYXiVf1Df5lAtr4KaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgddtjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfufhvvghn
 ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
 htvghrnhepheejgfdttdefleefteejieefudeuheelkedtgedtjeehieetueelheeuhfeg
 heegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
 hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:OUcOYdHibzTdJGN2Jk7KYvTbMLRusZNHLfRE5C9yzDb1kTnaL2Ixig>
 <xmx:OUcOYSTF-nRnTNS7-jvpOX4bvfnCUuLWgrkPirnO-fdGnM9J-lQmJQ>
 <xmx:OUcOYawMWE37xSQTL6sw3KimXHTvQYjWmizK3cGD9uzBInr_VSicUg>
 <xmx:OkcOYRptpB1j-CdXT9r-pCmcmOBxKPsul9uzM_bJIW5f48G6C_wT0w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6F0E751C04D7; Sat,  7 Aug 2021 04:41:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-552-g2afffd2709-fm-20210805.001-g2afffd27
Mime-Version: 1.0
Message-Id: <4eb038a4-e47f-48b2-9359-2e65747170f8@www.fastmail.com>
In-Reply-To: <d289a555-9e3b-b948-1883-2ee4c915da4c@arm.com>
References: <20210806155523.50429-1-sven@svenpeter.dev>
 <20210806155523.50429-3-sven@svenpeter.dev>
 <d289a555-9e3b-b948-1883-2ee4c915da4c@arm.com>
Date: Sat, 07 Aug 2021 10:41:09 +0200
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

Thanks a lot for quick reply!

On Fri, Aug 6, 2021, at 20:04, Robin Murphy wrote:
> On 2021-08-06 16:55, Sven Peter via iommu wrote:
> > DMA IOMMU domains can support hardware where the IOMMU page size is
> > larger than the CPU page size.
> > Alignments need to be done with respect to both PAGE_SIZE and
> > iovad->granule. Additionally, the sg list optimization to use a single
> > IOVA allocation cannot be used in those cases since the physical
> > addresses will very likely not be aligned to the larger IOMMU page size.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >   drivers/iommu/dma-iommu.c | 87 ++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 77 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 6f0df629353f..e072d9030d9f 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -8,6 +8,7 @@
> >    * Copyright (C) 2000-2004 Russell King
> >    */
> >   
> > +#include <linux/align.h>
> >   #include <linux/acpi_iort.h>
> >   #include <linux/device.h>
> >   #include <linux/dma-map-ops.h>
> > @@ -51,6 +52,15 @@ struct iommu_dma_cookie {
> >   	struct iommu_domain		*fq_domain;
> >   };
> >   
> > +/* aligns size to CPU and IOMMU page size */
> > +static inline size_t iommu_page_align(struct device *dev, size_t size)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> > +
> > +	return iova_align(&cookie->iovad, PAGE_ALIGN(size));
> > +}
> > +
> >   static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> >   bool iommu_dma_forcedac __read_mostly;
> >   
> > @@ -647,6 +657,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
> >   /*
> >    * If size is less than PAGE_SIZE, then a full CPU page will be allocated,
> >    * but an IOMMU which supports smaller pages might not map the whole thing.
> > + * If the IOMMU page size is larger than the CPU page size, then the size
> > + * will be aligned to that granularity and some memory will be left unused.
> 
> Why do we need to increase the actual memory allocation? The point here 
> is that we allocate the smallest thing we can allocate and map the 
> smallest thing we can map - I think that still works the "wrong" way 
> round too, we should just need to start taking an IOVA offset into 
> account as in dma_map_page() if we can no longer assume it's 0 for a CPU 
> page. Sure we may expose some unrelated adjacent pages, but we'll 
> already be doing that to excess for streaming DMA so whoop de do.

I agree for trusted devices, but untrusted ones (Thunderbolt, and depending on your
risk tolerance possibly even the broadcom wifi) might also end up calling this.
For streaming DMA swiotlb will make sure that these won't see memory
they're not supposed to access.
But, at least as far as I understand it, no swiotlb is in the way to catch devices
who end up calling this function. That wasn't required because we used to get
PAGE_SIZE aligned allocation here and every IOMMU so far would be able to easily
map them without any spill overs.
But now we'll end up exposing three more unrelated pages if the allocation
is not increased.


> 
> >    */
> >   static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
> >   		size_t size, struct sg_table *sgt, gfp_t gfp, pgprot_t prot,
> > @@ -736,7 +748,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> >   
> >   out_unmap:
> >   	__iommu_dma_unmap(dev, *dma_handle, size);
> > -	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> > +	__iommu_dma_free_pages(pages, iommu_page_align(dev, size) >> PAGE_SHIFT);
> >   	return NULL;
> >   }
> >   
> > @@ -766,7 +778,8 @@ static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> >   	struct dma_sgt_handle *sh = sgt_handle(sgt);
> >   
> >   	__iommu_dma_unmap(dev, sgt->sgl->dma_address, size);
> > -	__iommu_dma_free_pages(sh->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> > +	__iommu_dma_free_pages(sh->pages,
> > +		iommu_page_align(dev, size) >> PAGE_SHIFT);
> >   	sg_free_table(&sh->sgt);
> >   	kfree(sh);
> >   }
> > @@ -1006,6 +1019,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >   	if (dev_is_untrusted(dev))
> >   		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
> >   
> > +	/*
> > +	 * If the IOMMU pagesize is larger than the CPU pagesize we will
> > +	 * very likely run into sgs with a physical address that is not aligned
> > +	 * to an IOMMU page boundary. Fall back to just mapping every entry
> > +	 * independently with __iommu_dma_map then.
> 
> Scatterlist segments often don't have nicely aligned ends, which is why 
> we already align things to IOVA granules in main loop here. I think in 
> principle we'd just need to move the non-IOVA-aligned part of the 
> address from sg->page to sg->offset in the temporary transformation for 
> the rest of the assumptions to hold. I don't blame you for being timid 
> about touching that, though - it took me 3 tries to get right when I 
> first wrote it...

I was a little bit afraid I'd get this exact reply :D
I'll try to modify the transformation again, but I'm sure it'll take me more than
3 tries to get it right :)

> 
> > +	 */
> > +	if (iovad->granule > PAGE_SIZE) {
> > +		for_each_sg(sg, s, nents, i) {
> > +			sg_dma_address(s) = __iommu_dma_map(dev, sg_phys(s),
> > +				s->length, prot, dma_get_mask(dev));
> > +			if (sg_dma_address(s) == DMA_MAPPING_ERROR)
> > +				break;
> > +			sg_dma_len(s) = s->length;
> > +		}
> > +
> > +		if (unlikely(i != nents)) {
> > +			nents = i;
> > +			for_each_sg(sg, s, nents, i)
> > +				__iommu_dma_unmap(dev, sg_dma_address(s), sg_dma_len(s));
> > +			return 0;
> > +		}
> > +
> > +		return nents;
> > +	}
> 
> Either way, NAK to having a *third* implementation of SG mapping in this 
> file which is fundamentally no different from the second one.

Good point. If for some reason I'm not able to modify the transformation correctly
I'll just fall back to iommu_dma_map_sg_swiotlb.

> 
> > +
> >   	/*
> >   	 * Work out how much IOVA space we need, and align the segments to
> >   	 * IOVA granules for the IOMMU driver to handle. With some clever
> > @@ -1068,6 +1106,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >   static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> >   		int nents, enum dma_data_direction dir, unsigned long attrs)
> >   {
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> > +	struct iova_domain *iovad = &cookie->iovad;
> >   	dma_addr_t start, end;
> >   	struct scatterlist *tmp;
> >   	int i;
> > @@ -1080,6 +1121,17 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> >   		return;
> >   	}
> >   
> > +	/*
> > +	 * If the IOMMU pagesize is larger than the CPU pagesize we mapped
> > +	 * every entry indepedently with __iommu_dma_map then. Let's do the
> > +	 * opposite here.
> > +	 */
> > +	if (iovad->granule > PAGE_SIZE) {
> > +		for_each_sg(sg, tmp, nents, i)
> > +			__iommu_dma_unmap(dev, sg_dma_address(tmp), sg_dma_len(tmp));
> > +		return;
> > +	}
> 
> As above, this is just __iommu_dma_unmap_sg_swiotlb() with fewer clothes on.
> 
> > +
> >   	/*
> >   	 * The scatterlist segments are mapped into a single
> >   	 * contiguous IOVA allocation, so this is incredibly easy.
> > @@ -1110,7 +1162,7 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> >   
> >   static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
> >   {
> > -	size_t alloc_size = PAGE_ALIGN(size);
> > +	size_t alloc_size = iommu_page_align(dev, size);
> >   	int count = alloc_size >> PAGE_SHIFT;
> >   	struct page *page = NULL, **pages = NULL;
> >   
> > @@ -1150,7 +1202,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
> >   		struct page **pagep, gfp_t gfp, unsigned long attrs)
> >   {
> >   	bool coherent = dev_is_dma_coherent(dev);
> > -	size_t alloc_size = PAGE_ALIGN(size);
> > +	size_t alloc_size = iommu_page_align(dev, size);
> >   	int node = dev_to_node(dev);
> >   	struct page *page = NULL;
> >   	void *cpu_addr;
> > @@ -1201,8 +1253,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
> >   
> >   	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> >   	    !gfpflags_allow_blocking(gfp) && !coherent)
> > -		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> > -					       gfp, NULL);
> > +		page = dma_alloc_from_pool(dev, iommu_page_align(dev, size),
> > +					       &cpu_addr, gfp, NULL);
> >   	else
> >   		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
> >   	if (!cpu_addr)
> > @@ -1253,6 +1305,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >   		unsigned long attrs)
> 
> Can we just not bother trying to support this? TBH I don't know exactly 
> how the interface is supposed to work - what you're doing here looks 
> like it's probably either too much or not enough, depending on whether 
> the address and size arguments are supposed to allow representing 
> partial buffers - and frankly I can't imagine you'll be needing to 
> support dma-buf exports from the USB/ethernet/wifi drivers any time soon...

I'm not really sure how this is going to work even before my changes.
Just from reading the code it looks like even then it might be doing too much
or too little.
But this will also be used for Thunderbolt and who knows what kind of devices
will be connected there. I'm fine with just not supporting this interface unless
something actually breaks for some user though.

> 
> >   {
> > +	size_t aligned_size = iommu_page_align(dev, size);
> >   	struct page *page;
> >   	int ret;
> >   
> > @@ -1261,7 +1314,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >   
> >   		if (pages) {
> >   			return sg_alloc_table_from_pages(sgt, pages,
> > -					PAGE_ALIGN(size) >> PAGE_SHIFT,
> > +					aligned_size >> PAGE_SHIFT,
> >   					0, size, GFP_KERNEL);
> >   		}
> >   
> > @@ -1272,7 +1325,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >   
> >   	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> >   	if (!ret)
> > -		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> > +		sg_set_page(sgt->sgl, page, aligned_size, 0);
> >   	return ret;
> >   }
> >   
> > @@ -1283,11 +1336,25 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> >   	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
> >   }
> >   
> > +static struct page *iommu_dma_alloc_aligned_pages(struct device *dev, size_t size,
> > +		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
> > +{
> > +	size = iommu_page_align(dev, size);
> > +	return dma_common_alloc_pages(dev, size, dma_handle, dir, gfp);
> > +}
> > +
> > +static void iommu_dma_free_aligned_pages(struct device *dev, size_t size, struct page *page,
> > +		dma_addr_t dma_handle, enum dma_data_direction dir)
> > +{
> > +	size = iommu_page_align(dev, size);
> > +	return dma_common_free_pages(dev, size, page, dma_handle, dir);
> > +}
> 
> Again, what's the point of these? iommu_dma_map_page() still has to cope 
> with whatever the caller provides, so there's no difference in the one 
> case when that caller happens to be dma_common_map_pages().

Same as above, untrusted devices.


Thanks,


Sven



-- 
Sven Peter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
