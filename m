Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37031DDB1
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 14:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94606C433D2;
	Fri, 19 May 2023 14:02:27 +0000 (UTC)
Date: Fri, 19 May 2023 15:02:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 13/15] iommu/dma: Force bouncing if the size is not
 cacheline-aligned
Message-ID: <ZGeBcLVFKpLdTveZ@arm.com>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
 <20230518173403.1150549-14-catalin.marinas@arm.com>
 <9dc3e036-75cd-debf-7093-177ef6c7a3ae@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc3e036-75cd-debf-7093-177ef6c7a3ae@arm.com>

On Fri, May 19, 2023 at 01:29:38PM +0100, Robin Murphy wrote:
> On 2023-05-18 18:34, Catalin Marinas wrote:
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 7a9f0b0bddbd..ab1c1681c06e 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -956,7 +956,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
> >   	struct scatterlist *sg;
> >   	int i;
> > -	if (dev_use_swiotlb(dev))
> > +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
> >   		for_each_sg(sgl, sg, nelems, i)
> >   			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
> >   						      sg->length, dir);
> > @@ -972,7 +972,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
> >   	struct scatterlist *sg;
> >   	int i;
> > -	if (dev_use_swiotlb(dev))
> > +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
> >   		for_each_sg(sgl, sg, nelems, i)
> >   			iommu_dma_sync_single_for_device(dev,
> >   							 sg_dma_address(sg),
> > @@ -998,7 +998,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >   	 * If both the physical buffer start address and size are
> >   	 * page aligned, we don't need to use a bounce page.
> >   	 */
> > -	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
> > +	if ((dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) ||
> > +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
> >   		void *padding_start;
> >   		size_t padding_size, aligned_size;
> > @@ -1210,7 +1211,21 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >   			goto out;
> >   	}
> > -	if (dev_use_swiotlb(dev))
> > +	/*
> > +	 * If kmalloc() buffers are not DMA-safe for this device and
> > +	 * direction, check the individual lengths in the sg list. If one of
> > +	 * the buffers is deemed unsafe, follow the iommu_dma_map_sg_swiotlb()
> > +	 * path for potential bouncing.
> > +	 */
> > +	if (!dma_kmalloc_safe(dev, dir)) {
> > +		for_each_sg(sg, s, nents, i)
> > +			if (!dma_kmalloc_size_aligned(s->length)) {
> 
> Just to remind myself, we're not checking s->offset on the grounds that if
> anyone wants to DMA into an unaligned part of a larger allocation that
> remains at their own risk, is that right?

Right. That's the case currently as well and those users that were
relying on ARCH_KMALLOC_MINALIGN for this have either been migrated to
ARCH_DMA_MINALIGN in this series or the logic rewritten (as in the
crypto code).

> Do we care about the (probably theoretical) case where someone might build a
> scatterlist for multiple small allocations such that ones which happen to be
> adjacent might get combined into a single segment of apparently "safe"
> length but still at "unsafe" alignment?

I'd say that's theoretical only. One could write such code but normally
you'd go for an array rather than relying on the randomness of the
kmalloc pointers to figure out adjacent objects. It also only works if
the individual struct size is exactly one of the kmalloc cache sizes, so
not generic enough.

> > +				sg_dma_mark_bounced(sg);
> 
> I'd prefer to have iommu_dma_map_sg_swiotlb() mark the segments, since
> that's in charge of the actual bouncing. Then we can fold the alignment
> check into dev_use_swiotlb() (with the dev_is_untrusted() condition taking
> priority), and sync/unmap can simply rely on sg_is_dma_bounced() alone.

With this patch we only set the SG_DMA_BOUNCED on the first element of
the sglist. Do you want to set this flag only on individual elements
being bounced? It makes some sense in principle but the
iommu_dma_unmap_sg() path would need to scan the list again to decide
whether to go the swiotlb path.

If we keep the SG_DMA_BOUNCED flag only on the first element, I can
change it to your suggestion, assuming I understood it.

-- 
Catalin
