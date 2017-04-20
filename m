From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5] arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to
 IOMMU
Date: Thu, 20 Apr 2017 18:59:06 +0100
Message-ID: <20170420175905.GB755@e104818-lin.cambridge.arm.com>
References: <1488908612-22522-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488908612-22522-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Catching up with these threads, so replying to a patch I already
applied.

On Tue, Mar 07, 2017 at 06:43:32PM +0100, Geert Uytterhoeven wrote:
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -584,20 +584,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  	 */
>  	gfp |= __GFP_ZERO;
>  
> -	if (gfpflags_allow_blocking(gfp)) {
> -		struct page **pages;
> -		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
> -
> -		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
> -					handle, flush_page);
> -		if (!pages)
> -			return NULL;
> -
> -		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
> -					      __builtin_return_address(0));
> -		if (!addr)
> -			iommu_dma_free(dev, pages, iosize, handle);
> -	} else {
> +	if (!gfpflags_allow_blocking(gfp)) {
>  		struct page *page;
>  		/*
>  		 * In atomic context we can't remap anything, so we'll only
> @@ -621,6 +608,45 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  				__free_from_pool(addr, size);
>  			addr = NULL;
>  		}
> +	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> +		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
> +		struct page *page;
> +
> +		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
> +						 get_order(size), gfp);
> +		if (!page)
> +			return NULL;
> +
> +		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
> +		if (iommu_dma_mapping_error(dev, *handle)) {
> +			dma_release_from_contiguous(dev, page,
> +						    size >> PAGE_SHIFT);
> +			return NULL;
> +		}
> +		if (!coherent)
> +			__dma_flush_area(page_to_virt(page), iosize);
> +
> +		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
> +						   prot,
> +						   __builtin_return_address(0));

Do we need to call dma_common_pages_remap() if the allocation is
coherent? In the __dma_alloc() case we don't do it but simply use
page_address(page) as returned by __dma_alloc_coherent().

(note that my comment is not meant to fix the issue reported by Andrzej
Hajda but I just spotted it)

-- 
Catalin
