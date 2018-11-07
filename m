From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Date: Tue, 6 Nov 2018 16:11:49 -0800
Message-ID: <20181107001148.GB11429@Asurada-Nvidia.nvidia.com>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
 <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
 <d232ee7a-40de-5b32-39ab-222b773e9bb2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d232ee7a-40de-5b32-39ab-222b773e9bb2@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tue, Nov 06, 2018 at 06:27:39PM +0000, Robin Murphy wrote:
> > I re-ran the test to get some accuracy within the function and got:
> > 1) pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
> >     // reduced from 422 usec to 56 usec == 366 usec less
> > 2) if (!(prot & IOMMU_CACHE)) {...}	//flush routine
> >     // reduced from 439 usec to 236 usec == 203 usec less
> > Note: new memset takes about 164 usec, resulting in 400 usec diff
> >        for the entire iommu_dma_alloc() function call.
> > 
> > It looks like this might be more than the diff between clear_page
> > and memset, and might be related to mapping and cache. Any idea?
> 
> Hmm, I guess it might not be so much clear_page() itself as all the gubbins
> involved in getting there from prep_new_page(). I could perhaps make some
> vague guesses about how the A57 cores might get tickled by the different
> code patterns, but the Denver cores are well beyond my ability to reason
> about. Out of even further curiosity, how does the quick hack below compare?

I tried out that change. And the results are as followings:
a. Routine (1) reduced from 422 usec to 55 usec
b. Routine (2) increased from 441 usec to 833 usec
c. Overall, it seems to remain the same: 900+ usec

> > > > @@ -581,6 +593,12 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> > > >    	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> > > >    		goto out_free_iova;
> > > > +	if (gfp_zero) {
> > > > +		/* Now zero all the pages in the scatterlist */
> > > > +		for_each_sg(sgt.sgl, s, sgt.orig_nents, i)
> > > > +			memset(sg_virt(s), 0, s->length);
> > > 
> > > What if the pages came from highmem? I know that doesn't happen on arm64
> > > today, but the point of this code *is* to be generic, and other users will
> > > arrive eventually.
> > 
> > Hmm, so it probably should use sg_miter_start/stop() too? Looking
> > at the flush routine doing in PAGE_SIZE for each iteration, would
> > be possible to map and memset contiguous pages together? Actually
> > the flush routine might be also optimized if we can map contiguous
> > pages.
> 
> I suppose the ideal point at which to do it would be after the remapping
> when we have the entire buffer contiguous in vmalloc space and can make best
> use of prefetchers etc. - DMA_ATTR_NO_KERNEL_MAPPING is a bit of a spanner
> in the works, but we could probably accommodate a special case for that. As
> Christoph points out, this isn't really the place to be looking for
> performance anyway (unless it's pathologically bad as per the

I would understand the point. So probably it'd be more plausible
to have the change if it reflects on some practical benchmark. I
might need to re-run some tests with heavier use cases.

> DMA_ATTR_ALLOC_SINGLE_PAGES fun), but if we're looking at pulling the
> remapping out of the arch code, maybe we could aim to rework the zeroing
> completely as part of that.

That'd be nice. I believe it'd be good to have.

Thanks
Nicolin
