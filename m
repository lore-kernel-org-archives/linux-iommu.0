From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
Date: Tue, 20 Nov 2018 10:20:10 +0100
Message-ID: <20181120092010.GA7270@lst.de>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com> <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com> <20181102063542.GA17073@lst.de> <20181105224050.GA10411@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105224050.GA10411@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vdumpa@nvidia.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 05, 2018 at 02:40:51PM -0800, Nicolin Chen wrote:
> > > In general, this seems to make sense to me. It does represent a theoretical 
> > > change in behaviour for devices which have their own CMA area somewhere 
> > > other than kernel memory, and only ever make non-atomic allocations, but 
> > > I'm not sure whether that's a realistic or common enough case to really 
> > > worry about.
> > 
> > Yes, I think we should make the decision in dma_alloc_from_contiguous
> > based on having a per-dev CMA area or not.  There is a lot of cruft in
> 
> It seems that cma_alloc() already has a CMA area check? Would it
> be duplicated to have a similar one in dma_alloc_from_contiguous?

It isn't duplicate if it serves a different purpose.

> > this area that should be cleaned up while we're at it, like always
> > falling back to the normal page allocator if there is no CMA area or
> > nothing suitable found in dma_alloc_from_contiguous instead of
> > having to duplicate all that in the caller.
> 
> Am I supposed to clean up things that's mentioned above by moving
> the fallback allocator into dma_alloc_from_contiguous, or to just
> move my change (the count check) into dma_alloc_from_contiguous?
> 
> I understand that'd be great to have a cleanup, yet feel it could
> be done separately as this patch isn't really a cleanup change.

I can take care of any cleanups.  I've been trying to dust up that
area anyway.
