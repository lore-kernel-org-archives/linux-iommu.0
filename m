From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 22/26] iommu/dma: Refactor iommu_dma_mmap
Date: Mon, 29 Apr 2019 15:04:08 +0100
Message-ID: <a185d782-acf4-2a29-a84f-d912de13c09c@arm.com>
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-23-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422175942.18788-23-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> Inline __iommu_dma_mmap_pfn into the main function, and use the
> fact that __iommu_dma_get_pages return NULL for remapped contigous
> allocations to simplify the code flow a bit.

...and later we can squash __iommu_dma_mmap() once the dust settles on 
vm_map_pages() - seems good to me.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 36 +++++++++++-------------------------
>   1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 138b85e675c8..8fc6098c1eeb 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1025,21 +1025,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   	return cpu_addr;
>   }
>   
> -static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
> -			      unsigned long pfn, size_t size)
> -{
> -	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> -			       vma->vm_end - vma->vm_start,
> -			       vma->vm_page_prot);
> -}
> -
>   static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs)
>   {
>   	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long off = vma->vm_pgoff;
> -	struct page **pages;
> +	unsigned long pfn, off = vma->vm_pgoff;
>   	int ret;
>   
>   	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -1050,24 +1041,19 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
>   		return -ENXIO;
>   
> -	if (!is_vmalloc_addr(cpu_addr)) {
> -		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> -		return __iommu_dma_mmap_pfn(vma, pfn, size);
> -	}
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		struct page **pages = __iommu_dma_get_pages(cpu_addr);
>   
> -	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		/*
> -		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> -		 * hence in the vmalloc space.
> -		 */
> -		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
> -		return __iommu_dma_mmap_pfn(vma, pfn, size);
> +		if (pages)
> +			return __iommu_dma_mmap(pages, size, vma);
> +		pfn = vmalloc_to_pfn(cpu_addr);
> +	} else {
> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
>   	}
>   
> -	pages = __iommu_dma_get_pages(cpu_addr);
> -	if (WARN_ON_ONCE(!pages))
> -		return -ENXIO;
> -	return __iommu_dma_mmap(pages, size, vma);
> +	return remap_pfn_range(vma, vma->vm_start, pfn + off,
> +			       vma->vm_end - vma->vm_start,
> +			       vma->vm_page_prot);
>   }
>   
>   static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> 
