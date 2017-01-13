From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_FORCE_CONTIGUOUS
Date: Fri, 13 Jan 2017 11:32:59 +0000
Message-ID: <d336ef3b-4fe6-5ebb-9fed-071fa79028df@arm.com>
References: <1484305674-15018-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484305674-15018-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 13/01/17 11:07, Geert Uytterhoeven wrote:
> Add support for DMA_ATTR_FORCE_CONTIGUOUS to the generic IOMMU DMA code.
> This allows to allocate physically contiguous DMA buffers on arm64
> systems with an IOMMU.

Can anyone explain what this attribute is actually used for? I've never
quite figured it out.

> Note that as this uses the CMA allocator, setting this attribute has a
> runtime-dependency on CONFIG_DMA_CMA, just like on arm32.
> 
> For arm64 systems using swiotlb, no changes are needed to support the
> allocation of physically contiguous DMA buffers:
>   - swiotlb always uses physically contiguous buffers (up to
>     IO_TLB_SEGSIZE = 128 pages),
>   - arm64's __dma_alloc_coherent() already calls
>     dma_alloc_from_contiguous() when CMA is available.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
>  arch/arm64/mm/dma-mapping.c |  4 ++--
>  drivers/iommu/dma-iommu.c   | 44 ++++++++++++++++++++++++++++++++++----------
>  include/linux/dma-iommu.h   |  2 +-
>  3 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 1d7d5d2881db7c19..5fba14a21163e41f 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -589,7 +589,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
>  					      __builtin_return_address(0));
>  		if (!addr)
> -			iommu_dma_free(dev, pages, iosize, handle);
> +			iommu_dma_free(dev, pages, iosize, handle, attrs);
>  	} else {
>  		struct page *page;
>  		/*
> @@ -642,7 +642,7 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>  
>  		if (WARN_ON(!area || !area->pages))
>  			return;
> -		iommu_dma_free(dev, area->pages, iosize, &handle);
> +		iommu_dma_free(dev, area->pages, iosize, &handle, attrs);
>  		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>  	} else {
>  		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2db0d641cf4505b5..b991e8dcbbbb35c5 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -30,6 +30,7 @@
>  #include <linux/pci.h>
>  #include <linux/scatterlist.h>
>  #include <linux/vmalloc.h>
> +#include <linux/dma-contiguous.h>
>  
>  struct iommu_dma_msi_page {
>  	struct list_head	list;
> @@ -238,15 +239,21 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
>  	__free_iova(iovad, iova);
>  }
>  
> -static void __iommu_dma_free_pages(struct page **pages, int count)
> +static void __iommu_dma_free_pages(struct device *dev, struct page **pages,
> +				   int count, unsigned long attrs)
>  {
> -	while (count--)
> -		__free_page(pages[count]);
> +	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> +		dma_release_from_contiguous(dev, pages[0], count);
> +	} else {
> +		while (count--)
> +			__free_page(pages[count]);
> +	}
>  	kvfree(pages);
>  }
>  
> -static struct page **__iommu_dma_alloc_pages(unsigned int count,
> -		unsigned long order_mask, gfp_t gfp)
> +static struct page **__iommu_dma_alloc_pages(struct device *dev,
> +		unsigned int count, unsigned long order_mask, gfp_t gfp,
> +		unsigned long attrs)
>  {
>  	struct page **pages;
>  	unsigned int i = 0, array_size = count * sizeof(*pages);
> @@ -265,6 +272,20 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  	/* IOMMU can map any pages, so himem can also be used here */
>  	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>  
> +	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> +		int order = get_order(count << PAGE_SHIFT);
> +		struct page *page;
> +
> +		page = dma_alloc_from_contiguous(dev, count, order);
> +		if (!page)
> +			return NULL;
> +
> +		while (count--)
> +			pages[i++] = page++;
> +
> +		return pages;
> +	}
> +

This is really yuck. Plus it's entirely pointless to go through the
whole page array/scatterlist dance when we know the buffer is going to
be physically contiguous - it should just be allocate, map, done. I'd
much rather see standalone iommu_dma_{alloc,free}_contiguous()
functions, and let the arch code handle dispatching appropriately.

Robin.

>  	while (count) {
>  		struct page *page = NULL;
>  		unsigned int order_size;
> @@ -294,7 +315,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  			__free_pages(page, order);
>  		}
>  		if (!page) {
> -			__iommu_dma_free_pages(pages, i);
> +			__iommu_dma_free_pages(dev, pages, i, attrs);
>  			return NULL;
>  		}
>  		count -= order_size;
> @@ -310,15 +331,17 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>   * @pages: Array of buffer pages as returned by iommu_dma_alloc()
>   * @size: Size of buffer in bytes
>   * @handle: DMA address of buffer
> + * @attrs: DMA attributes used for allocation of this buffer
>   *
>   * Frees both the pages associated with the buffer, and the array
>   * describing them
>   */
>  void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
> -		dma_addr_t *handle)
> +		dma_addr_t *handle, unsigned long attrs)
>  {
>  	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle);
> -	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> +	__iommu_dma_free_pages(dev, pages, PAGE_ALIGN(size) >> PAGE_SHIFT,
> +			       attrs);
>  	*handle = DMA_ERROR_CODE;
>  }
>  
> @@ -365,7 +388,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  		alloc_sizes = min_size;
>  
>  	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
> +	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
> +					gfp, attrs);
>  	if (!pages)
>  		return NULL;
>  
> @@ -403,7 +427,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  out_free_iova:
>  	__free_iova(iovad, iova);
>  out_free_pages:
> -	__iommu_dma_free_pages(pages, count);
> +	__iommu_dma_free_pages(dev, pages, count, attrs);
>  	return NULL;
>  }
>  
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 7f7e9a7e3839966c..35fa6b7f9bac9b35 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -44,7 +44,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  		unsigned long attrs, int prot, dma_addr_t *handle,
>  		void (*flush_page)(struct device *, const void *, phys_addr_t));
>  void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
> -		dma_addr_t *handle);
> +		dma_addr_t *handle, unsigned long attrs);
>  
>  int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma);
>  
> 
