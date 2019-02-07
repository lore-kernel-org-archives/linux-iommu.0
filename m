From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] dma-direct: do not allocate a single page from CMA
 area
Date: Wed, 6 Feb 2019 18:28:49 -0800
Message-ID: <20190207022848.GA5581@Asurada-Nvidia.nvidia.com>
References: <20190115215140.1545-1-nicoleotsuka@gmail.com>
 <20190204082307.GA5916@lst.de>
 <20190205230514.GA21515@Asurada-Nvidia.nvidia.com>
 <20190206070726.GE23392@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206070726.GE23392@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, vdumpa@nvidia.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Wed, Feb 06, 2019 at 08:07:26AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 03:05:30PM -0800, Nicolin Chen wrote:
> > > And my other concern is that this skips allocating from the per-device
> > > pool, which drivers might rely on.
> > 
> > Actually Robin had the same concern at v1 and suggested that we could
> > always use DMA_ATTR_FORCE_CONTIGUOUS to enforce into per-device pool.
> 
> That is both against the documented behavior of DMA_ATTR_FORCE_CONTIGUOUS
> and doesn't help existing drivers that specify their CMA area in DT.

OK. I will drop it.

> > > To be honest I'm not sure there is
> > > much of a point in the per-device CMA pool vs the traditional per-device
> > > coherent pool, but I'd rather change that behavior in a clearly documented
> > > commit with intentions rather as a side effect from a random optimization.
> > 
> > Hmm..sorry, I don't really follow this suggestion. Is it possible for
> > you to make it clear that what should I do for the change?
> 
> Something like this (plus proper comments):
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index b2a87905846d..789d734f0f77 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -192,10 +192,19 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>  struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>  				       unsigned int align, bool no_warn)
>  {
> +	struct cma *cma;
> +
>  	if (align > CONFIG_CMA_ALIGNMENT)
>  		align = CONFIG_CMA_ALIGNMENT;
>  
> -	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
> +	if (dev && dev->cma_area)
> +		cma = dev->cma_area;
> +	else if (count > PAGE_SIZE)
> +		cma = dma_contiguous_default_area;
> +	else
> +		return NULL;

So we will keep allocating single pages in dev->cma_area if it's
present, in order to address your previous concern?

Thanks
Nicolin
