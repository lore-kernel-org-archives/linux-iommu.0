From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Date: Fri, 2 Nov 2018 16:36:13 -0700
Message-ID: <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 02, 2018 at 04:54:07PM +0000, Robin Murphy wrote:
> On 01/11/2018 21:35, Nicolin Chen wrote:
> > The __GFP_ZERO will be passed down to the generic page allocation
> > routine which zeros everything page by page. This is safe to be a
> > generic way but not efficient for iommu allocation that organizes
> > contiguous pages using scatterlist.
> > 
> > So this changes drops __GFP_ZERO from the flag, and adds a manual
> > memset after page/sg allocations, using the length of scatterlist.
> > 
> > My test result of a 2.5MB size allocation shows iommu_dma_alloc()
> > takes 46% less time, reduced from averagely 925 usec to 500 usec.
> 
> Assuming this is for arm64, I'm somewhat surprised that memset() could be
> that much faster than clear_page(), since they should effectively amount to
> the same thing (a DC ZVA loop). What hardware is this on? Profiling to try

I am running with tegra186-p2771-0000.dtb so it's arm64 yes.

> and see exactly where the extra time goes would be interesting too.

I re-ran the test to get some accuracy within the function and got:
1) pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
   // reduced from 422 usec to 56 usec == 366 usec less
2) if (!(prot & IOMMU_CACHE)) {...}	//flush routine
   // reduced from 439 usec to 236 usec == 203 usec less
Note: new memset takes about 164 usec, resulting in 400 usec diff
      for the entire iommu_dma_alloc() function call.

It looks like this might be more than the diff between clear_page
and memset, and might be related to mapping and cache. Any idea?

> > @@ -568,6 +571,15 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >   	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
> >   		alloc_sizes = min_size;
> > +	/*
> > +	 * The generic zeroing in a length of one page size is slow,
> > +	 * so do it manually in a length of scatterlist size instead
> > +	 */
> > +	if (gfp & __GFP_ZERO) {
> > +		gfp &= ~__GFP_ZERO;
> > +		gfp_zero = true;
> > +	}
> 
> Or just mask it out in __iommu_dma_alloc_pages()?

Yea, the change here would be neater then.

> > @@ -581,6 +593,12 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >   	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> >   		goto out_free_iova;
> > +	if (gfp_zero) {
> > +		/* Now zero all the pages in the scatterlist */
> > +		for_each_sg(sgt.sgl, s, sgt.orig_nents, i)
> > +			memset(sg_virt(s), 0, s->length);
> 
> What if the pages came from highmem? I know that doesn't happen on arm64
> today, but the point of this code *is* to be generic, and other users will
> arrive eventually.

Hmm, so it probably should use sg_miter_start/stop() too? Looking
at the flush routine doing in PAGE_SIZE for each iteration, would
be possible to map and memset contiguous pages together? Actually
the flush routine might be also optimized if we can map contiguous
pages.

Thank you
Nicolin
