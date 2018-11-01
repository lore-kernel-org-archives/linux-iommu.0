From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
Date: Thu, 1 Nov 2018 13:22:01 -0700
Message-ID: <20181101202200.GA30950@Asurada-Nvidia.nvidia.com>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
 <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
 <20181101180439.GA4746@Asurada-Nvidia.nvidia.com>
 <58e3d16e-837c-0610-9e1c-0562babcdd82@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58e3d16e-837c-0610-9e1c-0562babcdd82@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vdumpa@nvidia.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 01, 2018 at 07:32:39PM +0000, Robin Murphy wrote:

> > On Thu, Nov 01, 2018 at 02:07:55PM +0000, Robin Murphy wrote:
> > > On 31/10/2018 20:03, Nicolin Chen wrote:
> > > > The addresses within a single page are always contiguous, so it's
> > > > not so necessary to allocate one single page from CMA area. Since
> > > > the CMA area has a limited predefined size of space, it might run
> > > > out of space in some heavy use case, where there might be quite a
> > > > lot CMA pages being allocated for single pages.
> > > > 
> > > > This patch tries to skip CMA allocations of single pages and lets
> > > > them go through normal page allocations. This would save resource
> > > > in the CMA area for further more CMA allocations.
> > > 
> > > In general, this seems to make sense to me. It does represent a theoretical
> > > change in behaviour for devices which have their own CMA area somewhere
> > > other than kernel memory, and only ever make non-atomic allocations, but I'm
> > > not sure whether that's a realistic or common enough case to really worry
> > > about.
> > 
> > Hmm..I don't quite understand the part of worrying its realisticness.
> > Would you mind elaborating a bit?
> 
> I only mean the case where a driver previously happened to get single pages
> allocated from a per-device CMA area, would now always get them fulfilled
> from regular kernel memory instead, and actually cares about the difference.

I see. I think that's a good question.

> As I say, that's a contrived case that I doubt is honestly a significant
> concern, but it's not *entirely* inconceivable. I've just been bitten before
> by drivers relying on specific DMA API implementation behaviour which was
> never guaranteed or even necessarily correct by the terms of the API itself,
> so I'm naturally wary of the corner cases ;)

I also have a vague concern that CMA pages might turn out to be
special so this change would make some differences in stability
or performance for those who actually rely on actual CMA pages,
though I ain't sure if it can be true or realistic as you said.

> On second thought, however, I suppose we could always key this off
> DMA_ATTR_FORCE_CONTIGUOUS as well if we really want - technically it has a
> more general meaning than "only ever allocate from CMA", but in practice if
> that's the behaviour a driver wants, then that flag is already the only way
> it can even hope to get dma_alloc_coherent() to comply anywhere near
> reliably.

That is a good input. Would you prefer to have it in condition
check now with this patch?

> > As I tested this change on Tegra186
> > board, and saw some single-page allocations have been directed to the
> > normal allocation; and the "CmaFree" size reported from /proc/meminfo
> > is also increased. Does this mean it's realistic?
> 
> Indeed - I happen to have CMA debug enabled for no good reason in my current
> development config, and on my relatively unexciting Juno board single-page
> allocations turn out to be the majority by number, even if not by total
> consumption:
> 
> [    0.519663] cma: cma_alloc(cma (____ptrval____), count 64, align 6)
> [    0.527508] cma: cma_alloc(): returned (____ptrval____)
> [    3.768066] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    3.774566] cma: cma_alloc(): returned (____ptrval____)
> [    3.860097] cma: cma_alloc(cma (____ptrval____), count 1875, align 8)
> [    3.867150] cma: cma_alloc(): returned (____ptrval____)
> [    3.920796] cma: cma_alloc(cma (____ptrval____), count 31, align 5)
> [    3.927093] cma: cma_alloc(): returned (____ptrval____)
> [    3.932326] cma: cma_alloc(cma (____ptrval____), count 31, align 5)
> [    3.938643] cma: cma_alloc(): returned (____ptrval____)
> [    4.022188] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    4.028415] cma: cma_alloc(): returned (____ptrval____)
> [    4.033600] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    4.039786] cma: cma_alloc(): returned (____ptrval____)
> [    4.044968] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    4.051150] cma: cma_alloc(): returned (____ptrval____)
> [    4.113556] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    4.119785] cma: cma_alloc(): returned (____ptrval____)
> [    5.012654] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    5.019047] cma: cma_alloc(): returned (____ptrval____)
> [   11.485179] cma: cma_alloc(cma 000000009dd074ee, count 1, align 0)
> [   11.492096] cma: cma_alloc(): returned 000000009264a86c
> [   12.269355] cma: cma_alloc(cma 000000009dd074ee, count 1875, align 8)
> [   12.277535] cma: cma_alloc(): returned 00000000d7bb9ae5
> [   12.286110] cma: cma_alloc(cma 000000009dd074ee, count 4, align 2)
> [   12.292507] cma: cma_alloc(): returned 0000000007ba7a39
> 
> I don't have any exciting peripherals to really exercise the coherent
> allocator, but I imagine that fragmentation is probably just as good a
> reason as total CMA usage for avoiding trivial allocations by default.

I will also add to the commit message fragmentation reduction.

Thanks
Nicolin
