From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 5/9] dma-mapping: support highmem in the generic remap
 allocator
Date: Fri, 30 Nov 2018 19:05:33 +0000
Message-ID: <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105121931.13481-6-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> By using __dma_direct_alloc_pages we can deal entirely with struct page
> instead of having to derive a kernel virtual address.

Simple enough :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/remap.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index bc42766f52df..8f1fca34b894 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -196,7 +196,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t flags, unsigned long attrs)
>   {
>   	struct page *page = NULL;
> -	void *ret, *kaddr;
> +	void *ret;
>   
>   	size = PAGE_ALIGN(size);
>   
> @@ -208,10 +208,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		return ret;
>   	}
>   
> -	kaddr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> -	if (!kaddr)
> +	page = __dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> +	if (!page)
>   		return NULL;
> -	page = virt_to_page(kaddr);
>   
>   	/* remove any dirty cache lines on the kernel alias */
>   	arch_dma_prep_coherent(page, size);
> @@ -221,7 +220,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
>   			__builtin_return_address(0));
>   	if (!ret)
> -		dma_direct_free_pages(dev, size, kaddr, *dma_handle, attrs);
> +		__dma_direct_free_pages(dev, size, page);
>   	return ret;
>   }
>   
> @@ -229,10 +228,11 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>   		dma_addr_t dma_handle, unsigned long attrs)
>   {
>   	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
> -		void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
> +		phys_addr_t phys = dma_to_phys(dev, dma_handle);
> +		struct page *page = pfn_to_page(__phys_to_pfn(phys));
>   
>   		vunmap(vaddr);
> -		dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
> +		__dma_direct_free_pages(dev, size, page);
>   	}
>   }
>   
> 
