From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] dma-direct: do not allocate a single page from CMA
 area
Date: Mon, 4 Feb 2019 09:23:07 +0100
Message-ID: <20190204082307.GA5916@lst.de>
References: <20190115215140.1545-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115215140.1545-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, vdumpa@nvidia.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 15, 2019 at 01:51:40PM -0800, Nicolin Chen wrote:
> The addresses within a single page are always contiguous, so it's
> not so necessary to allocate one single page from CMA area. Since
> the CMA area has a limited predefined size of space, it might run
> out of space in some heavy use case, where there might be quite a
> lot CMA pages being allocated for single pages.
> 
> This patch tries to skip CMA allocations of single pages and lets
> them go through normal page allocations unless the allocation has
> a DMA_ATTR_FORCE_CONTIGUOUS attribute. This'd save some resources
> in the CMA area for further more CMA allocations, and it can also
> reduce CMA fragmentations resulted from trivial allocations.

That DMA_ATTR_FORCE_CONTIGUOUS flag does not make sense.  A single
page allocation is per defintion always contigous.

>  again:
> -	/* CMA can be used only in the context which permits sleeping */
> -	if (gfpflags_allow_blocking(gfp)) {
> +	/*
> +	 * CMA can be used only in the context which permits sleeping.
> +	 * Since addresses within one PAGE are always contiguous, skip
> +	 * CMA allocation for a single page to save CMA reserved space
> +	 * unless DMA_ATTR_FORCE_CONTIGUOUS is flagged.
> +	 */
> +	if (gfpflags_allow_blocking(gfp) &&
> +	    (count > 1 || attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {

And my other concern is that this skips allocating from the per-device
pool, which drivers might rely on.  To be honest I'm not sure there is
much of a point in the per-device CMA pool vs the traditional per-device
coherent pool, but I'd rather change that behavior in a clearly documented
commit with intentions rather as a side effect from a random optimization.
