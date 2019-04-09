From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 11/21] dma-iommu: refactor page array remap helpers
Date: Tue, 9 Apr 2019 17:38:59 +0100
Message-ID: <9fe28aa4-3b7c-ee98-3f73-f10271f06c3a@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-12-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-12-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
> Move the call to dma_common_pages_remap / dma_common_free_remap  into
> __iommu_dma_alloc / __iommu_dma_free and rename those functions to
> better describe what they do.  This keeps the functionality that
> allocates and remaps a non-contigous array of pages nicely abstracted
> out from the calling code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 75 +++++++++++++++++++--------------------
>   1 file changed, 36 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4d46beeea5b7..2013c650718a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -524,51 +524,57 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   }
>   
>   /**
> - * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
> + * iommu_dma_free_remap - Free a buffer allocated by iommu_dma_alloc_remap

Unmap and free a buffer allocated by iommu_dma_alloc_remap()

>    * @dev: Device which owns this buffer
> - * @pages: Array of buffer pages as returned by __iommu_dma_alloc()
>    * @size: Size of buffer in bytes
> + * @cpu_address: Virtual address of the buffer
>    * @handle: DMA address of buffer

@dma_handle

>    *
>    * Frees both the pages associated with the buffer, and the array
>    * describing them

and removes the CPU mapping.

>    */
> -static void __iommu_dma_free(struct device *dev, struct page **pages,
> -		size_t size, dma_addr_t *handle)
> +static void iommu_dma_free_remap(struct device *dev, size_t size,
> +		void *cpu_addr, dma_addr_t dma_handle)
>   {
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
> -	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> -	*handle = DMA_MAPPING_ERROR;
> +	struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +	if (WARN_ON(!area || !area->pages))
> +		return;
> +	__iommu_dma_unmap(iommu_get_dma_domain(dev), dma_handle, size);
> +	__iommu_dma_free_pages(area->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> +	dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
>   }
>   
>   /**
> - * __iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
> + * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space

I'm not sure of a succinct way to update that one :(

Other than kerneldoc nits, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>    * @dev: Device to allocate memory for. Must be a real device
>    *	 attached to an iommu_dma_domain
>    * @size: Size of buffer in bytes
> + * @dma_handle: Out argument for allocated DMA handle
>    * @gfp: Allocation flags
>    * @attrs: DMA attributes for this allocation
> - * @prot: IOMMU mapping flags
> - * @handle: Out argument for allocated DMA handle
>    *
>    * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
>    * but an IOMMU which supports smaller pages might not map the whole thing.
>    *
> - * Return: Array of struct page pointers describing the buffer,
> - *	   or NULL on failure.
> + * Return: Mapped virtual address, or NULL on failure.
>    */
> -static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
> -		gfp_t gfp, unsigned long attrs, int prot, dma_addr_t *handle)
> +static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
> +	bool coherent = dev_is_dma_coherent(dev);
> +	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
> +	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
> +	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
>   	struct page **pages;
>   	struct sg_table sgt;
>   	dma_addr_t iova;
> -	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
> +	void *vaddr;
>   
> -	*handle = DMA_MAPPING_ERROR;
> +	*dma_handle = DMA_MAPPING_ERROR;
>   
>   	min_size = alloc_sizes & -alloc_sizes;
>   	if (min_size < PAGE_SIZE) {
> @@ -594,7 +600,7 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
>   	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
>   		goto out_free_iova;
>   
> -	if (!(prot & IOMMU_CACHE)) {
> +	if (!(ioprot & IOMMU_CACHE)) {
>   		struct scatterlist *sg;
>   		int i;
>   
> @@ -602,14 +608,21 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
>   			arch_dma_prep_coherent(sg_page(sg), sg->length);
>   	}
>   
> -	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
> +	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, ioprot)
>   			< size)
>   		goto out_free_sg;
>   
> -	*handle = iova;
> +	vaddr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
> +			__builtin_return_address(0));
> +	if (!vaddr)
> +		goto out_unmap;
> +
> +	*dma_handle = iova;
>   	sg_free_table(&sgt);
> -	return pages;
> +	return vaddr;
>   
> +out_unmap:
> +	__iommu_dma_unmap(domain, iova, size);
>   out_free_sg:
>   	sg_free_table(&sgt);
>   out_free_iova:
> @@ -1013,18 +1026,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   						    size >> PAGE_SHIFT);
>   		}
>   	} else {
> -		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
> -		struct page **pages;
> -
> -		pages = __iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
> -					handle);
> -		if (!pages)
> -			return NULL;
> -
> -		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
> -					      __builtin_return_address(0));
> -		if (!addr)
> -			__iommu_dma_free(dev, pages, iosize, handle);
> +		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
>   	}
>   	return addr;
>   }
> @@ -1038,7 +1040,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   	/*
>   	 * @cpu_addr will be one of 4 things depending on how it was allocated:
>   	 * - A remapped array of pages for contiguous allocations.
> -	 * - A remapped array of pages from __iommu_dma_alloc(), for all
> +	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
>   	 *   non-atomic allocations.
>   	 * - A non-cacheable alias from the atomic pool, for atomic
>   	 *   allocations by non-coherent devices.
> @@ -1056,12 +1058,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
>   		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>   	} else if (is_vmalloc_addr(cpu_addr)){
> -		struct vm_struct *area = find_vm_area(cpu_addr);
> -
> -		if (WARN_ON(!area || !area->pages))
> -			return;
> -		__iommu_dma_free(dev, area->pages, iosize, &handle);
> -		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
> +		iommu_dma_free_remap(dev, iosize, cpu_addr, handle);
>   	} else {
>   		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
>   		__free_pages(virt_to_page(cpu_addr), get_order(size));
> 
