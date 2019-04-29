From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 11/26] iommu/dma: Factor out remapped pages lookup
Date: Mon, 29 Apr 2019 14:05:46 +0100
Message-ID: <f8c04947-0ddb-17c5-8918-5859aabc220c@arm.com>
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-12-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422175942.18788-12-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Since we duplicate the find_vm_area() logic a few times in places where
> we only care aboute the pages, factor out a helper to abstract it.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [hch: don't warn when not finding a region, as we'll rely on that later]

Yeah, I did think about that and the things which it might make a little 
easier, but preserved it as-is for the sake of keeping my modifications 
quick and simple. TBH I'm now feeling more inclined to drop the WARNs 
entirely at this point, since it's not like there's ever been any 
general guarantee that freeing the wrong thing shouldn't just crash, but 
that's something we can easily come back to later if need be.

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index b52c5d6be7b4..8e2d9733113e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -525,6 +525,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   	return pages;
>   }
>   
> +static struct page **__iommu_dma_get_pages(void *cpu_addr)
> +{
> +	struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +	if (!area || !area->pages)
> +		return NULL;
> +	return area->pages;
> +}
> +
>   /**
>    * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
>    * @dev: Device which owns this buffer
> @@ -1023,11 +1032,11 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
>   		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>   	} else if (is_vmalloc_addr(cpu_addr)){
> -		struct vm_struct *area = find_vm_area(cpu_addr);
> +		struct page **pages = __iommu_dma_get_pages(cpu_addr);
>   
> -		if (WARN_ON(!area || !area->pages))
> +		if (WARN_ON(!pages))
>   			return;
> -		__iommu_dma_free(dev, area->pages, iosize, &handle);
> +		__iommu_dma_free(dev, pages, iosize, &handle);
>   		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>   	} else {
>   		__iommu_dma_unmap(dev, handle, iosize);
> @@ -1049,7 +1058,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   {
>   	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	unsigned long off = vma->vm_pgoff;
> -	struct vm_struct *area;
> +	struct page **pages;
>   	int ret;
>   
>   	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -1074,11 +1083,10 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   		return __iommu_dma_mmap_pfn(vma, pfn, size);
>   	}
>   
> -	area = find_vm_area(cpu_addr);
> -	if (WARN_ON(!area || !area->pages))
> +	pages = __iommu_dma_get_pages(cpu_addr);
> +	if (WARN_ON_ONCE(!pages))
>   		return -ENXIO;
> -
> -	return __iommu_dma_mmap(area->pages, size, vma);
> +	return __iommu_dma_mmap(pages, size, vma);
>   }
>   
>   static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
> @@ -1096,7 +1104,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   		unsigned long attrs)
>   {
>   	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	struct vm_struct *area = find_vm_area(cpu_addr);
> +	struct page **pages;
>   
>   	if (!is_vmalloc_addr(cpu_addr)) {
>   		struct page *page = virt_to_page(cpu_addr);
> @@ -1112,10 +1120,10 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   		return __iommu_dma_get_sgtable_page(sgt, page, size);
>   	}
>   
> -	if (WARN_ON(!area || !area->pages))
> +	pages = __iommu_dma_get_pages(cpu_addr);
> +	if (WARN_ON_ONCE(!pages))
>   		return -ENXIO;
> -
> -	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
> +	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
>   					 GFP_KERNEL);
>   }
>   
> 
