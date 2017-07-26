From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 2/2] iommu/dma: Use __GFP_NOWARN only for high-order
 allocations
Date: Wed, 26 Jul 2017 11:24:11 +0200
Message-ID: <20170726092411.GD15833@8bytes.org>
References: <20170704135556.21704-1-tfiga@chromium.org>
 <20170704135556.21704-2-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170704135556.21704-2-tfiga@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 04, 2017 at 10:55:56PM +0900, Tomasz Figa wrote:
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index bf23989b5158..6ed8c8f941d8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -433,6 +433,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  {
>  	struct page **pages;
>  	unsigned int i = 0, array_size = count * sizeof(*pages);
> +	const gfp_t high_order_gfp = __GFP_NOWARN | __GFP_NORETRY;
>  
>  	order_mask &= (2U << MAX_ORDER) - 1;
>  	if (!order_mask)
> @@ -452,8 +453,6 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  	if (!(gfp & (__GFP_DMA | __GFP_DMA32)))
>  		gfp |= __GFP_HIGHMEM;
>  
> -	gfp |= __GFP_NOWARN;
> -

Okay, so a warning should be there if allocation fails, independent of
what the allocation order is. So either this function prints a message
in case of allocation failure or we remove __GFP_NOWARN for all
allocation attempts.

Adding __GFP_NOWARN only makes sense when there is another fall-back in
case allocation fails anyway, which is not the case here.

>  	while (count) {
>  		struct page *page = NULL;
>  		unsigned int order_size;
> @@ -469,7 +468,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  
>  			order_size = 1U << order;
>  			page = alloc_pages((order_mask - order_size) ?
> -					   gfp | __GFP_NORETRY : gfp, order);
> +					   gfp | high_order_gfp : gfp, order);

Why does it specify __GFP_NORETRY at all? The alloc-routines in the
DMA-API don't need to be atomic.


	Joerg
