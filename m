From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 06/19] dma-iommu: fix and refactor iommu_dma_mmap
Date: Tue, 5 Feb 2019 15:02:23 +0000
Message-ID: <7c2b6aaa-3a19-a411-1d40-0c787205b0fc@arm.com>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114094159.27326-7-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> The current iommu_dma_mmap code does not properly handle memory from the
> page allocator that hasn't been remapped, which can happen in the rare
> case of allocations for a coherent device that aren't allowed to block.
> 
> Fix this by replacing iommu_dma_mmap with a slightly tweaked copy of
> dma_common_mmap with special handling for the remapped array of
> pages allocated from __iommu_dma_alloc.

If there's an actual bugfix here, can we make that before all of the 
other code movement? If it's at all related to other reports of weird 
mmap behaviour it might warrant backporting, and either way I'm finding 
it needlessly tough to follow what's going on in this patch :(

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 59 +++++++++++++++------------------------
>   1 file changed, 23 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e0ffe22775ac..26f479d49103 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -592,23 +592,27 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
>   }
>   
>   /**
> - * __iommu_dma_mmap - Map a buffer into provided user VMA
> - * @pages: Array representing buffer from __iommu_dma_alloc()
> + * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
> + * @cpu_addr: virtual address of the memory to be remapped
>    * @size: Size of buffer in bytes
>    * @vma: VMA describing requested userspace mapping
>    *
> - * Maps the pages of the buffer in @pages into @vma. The caller is responsible
> + * Maps the pages pointed to by @cpu_addr into @vma. The caller is responsible
>    * for verifying the correct size and protection of @vma beforehand.
>    */
> -static int __iommu_dma_mmap(struct page **pages, size_t size,
> +static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
>   		struct vm_area_struct *vma)
>   {
> +	struct vm_struct *area = find_vm_area(cpu_addr);
>   	unsigned long uaddr = vma->vm_start;
>   	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	int ret = -ENXIO;
>   
> +	if (WARN_ON(!area || !area->pages))
> +		return -ENXIO;
> +
>   	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -		ret = vm_insert_page(vma, uaddr, pages[i]);
> +		ret = vm_insert_page(vma, uaddr, area->pages[i]);
>   		if (ret)
>   			break;
>   		uaddr += PAGE_SIZE;
> @@ -1047,29 +1051,14 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   	}
>   }
>   
> -static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
> -			      unsigned long pfn, size_t size)
> -{
> -	int ret = -ENXIO;
> -	unsigned long nr_vma_pages = vma_pages(vma);
> -	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long off = vma->vm_pgoff;
> -
> -	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
> -		ret = remap_pfn_range(vma, vma->vm_start,
> -				      pfn + off,
> -				      vma->vm_end - vma->vm_start,
> -				      vma->vm_page_prot);
> -	}
> -
> -	return ret;
> -}
> -
>   static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs)
>   {
> -	struct vm_struct *area;
> +	unsigned long user_count = vma_pages(vma);
> +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long off = vma->vm_pgoff;
> +	unsigned long pfn;
>   	int ret;
>   
>   	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -1077,20 +1066,18 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>   		return ret;
>   
> -	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		/*
> -		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> -		 * hence in the vmalloc space.
> -		 */
> -		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
> -		return __iommu_dma_mmap_pfn(vma, pfn, size);
> -	}
> -
> -	area = find_vm_area(cpu_addr);
> -	if (WARN_ON(!area || !area->pages))
> +	if (off >= count || user_count > count - off)
>   		return -ENXIO;
>   
> -	return __iommu_dma_mmap(area->pages, size, vma);
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
> +			return iommu_dma_mmap_remap(cpu_addr, size, vma);
> +		pfn = vmalloc_to_pfn(cpu_addr);
> +	} else
> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
> +
> +	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> +			user_count << PAGE_SHIFT, vma->vm_page_prot);
>   }
>   
>   static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
> 
