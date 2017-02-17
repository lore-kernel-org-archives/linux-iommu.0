From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4] arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to
 IOMMU
Date: Fri, 17 Feb 2017 12:09:35 +0000
Message-ID: <d5bc031c-e6c1-d0a1-b77a-2ef2b6e22bf5@arm.com>
References: <1486481916-1892-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1486481916-1892-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 07/02/17 15:38, Geert Uytterhoeven wrote:
> Add support for allocating physically contiguous DMA buffers on arm64
> systems with an IOMMU.  This can be useful when two or more devices
> with different memory requirements are involved in buffer sharing.
> 
> Note that as this uses the CMA allocator, setting the
> DMA_ATTR_FORCE_CONTIGUOUS attribute has a runtime-dependency on
> CONFIG_DMA_CMA, just like on arm32.
> 
> For arm64 systems using swiotlb, no changes are needed to support the
> allocation of physically contiguous DMA buffers:
>   - swiotlb always uses physically contiguous buffers (up to
>     IO_TLB_SEGSIZE = 128 pages),
>   - arm64's __dma_alloc_coherent() already calls
>     dma_alloc_from_contiguous() when CMA is available.

I think this looks about as good as it ever could now :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v4:
>   - Replace dma_to_phys()/phys_to_page() by vmalloc_to_page(), to pass
>     the correct page pointer to dma_release_from_contiguous().
>     Note that the latter doesn't scream when passed a wrong pointer, but
>     just returns false.  While this makes life easier for callers who
>     may want to call another deallocator, it makes it harder catching
>     bugs.
> 
> v3:
>   - Add Acked-by,
>   - Update comment to "one of _4_ things",
>   - Call dma_alloc_from_contiguous() and iommu_dma_map_page() directly,
>     as suggested by Robin Murphy,
> 
> v2:
>   - New, handle dispatching in the arch (arm64) code, as requested by
>     Robin Murphy.
> ---
>  arch/arm64/mm/dma-mapping.c | 63 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 351f7595cb3ebdb9..fb76e82c90edd514 100644
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
> +						 get_order(size));
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
> +		if (!addr) {
> +			iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
> +			dma_release_from_contiguous(dev, page,
> +						    size >> PAGE_SHIFT);
> +		}
> +	} else {
> +		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
> +		struct page **pages;
> +
> +		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
> +					handle, flush_page);
> +		if (!pages)
> +			return NULL;
> +
> +		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
> +					      __builtin_return_address(0));
> +		if (!addr)
> +			iommu_dma_free(dev, pages, iosize, handle);
>  	}
>  	return addr;
>  }
> @@ -632,7 +658,8 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>  
>  	size = PAGE_ALIGN(size);
>  	/*
> -	 * @cpu_addr will be one of 3 things depending on how it was allocated:
> +	 * @cpu_addr will be one of 4 things depending on how it was allocated:
> +	 * - A remapped array of pages for contiguous allocations.
>  	 * - A remapped array of pages from iommu_dma_alloc(), for all
>  	 *   non-atomic allocations.
>  	 * - A non-cacheable alias from the atomic pool, for atomic
> @@ -644,6 +671,12 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>  	if (__in_atomic_pool(cpu_addr, size)) {
>  		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
>  		__free_from_pool(cpu_addr, size);
> +	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> +		struct page *page = vmalloc_to_page(cpu_addr);
> +
> +		iommu_dma_unmap_page(dev, handle, iosize, 0, attrs);
> +		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
> +		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>  	} else if (is_vmalloc_addr(cpu_addr)){
>  		struct vm_struct *area = find_vm_area(cpu_addr);
>  
> 
