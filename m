From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 09/21] dma-iommu: refactor iommu_dma_get_sgtable
Date: Tue, 9 Apr 2019 16:49:30 +0100
Message-ID: <a42133a5-c88b-76c7-80fa-671cfbdd9759@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-10-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-10-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
> Move the vm_area handling into a new iommu_dma_get_sgtable_remap helper.
> 
> Inline __iommu_dma_get_sgtable_page into the main function to simplify
> the code flow a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 54 +++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 43bd3c7e0f6b..57f2d8621112 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -625,6 +625,18 @@ static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
>   	return ret;
>   }
>   
> +static int iommu_dma_get_sgtable_remap(struct sg_table *sgt, void *cpu_addr,
> +		size_t size)
> +{
> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +	if (WARN_ON(!area || !area->pages))
> +		return -ENXIO;
> +	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
> +			GFP_KERNEL);
> +}
> +

Is this complex enough to deserve being broken out? Really I'd prefer to 
keep get_sgtable() as small and consolidated as possible so that it's 
that much easier to delete in future :)

I guess there is a certain symmetry with mmap(), so if that's the angle 
you're dead set on, could we at least keep this guy down where 
__iommu_dma_get_sgtable_page() was?

Robin.

>   static void iommu_dma_sync_single_for_cpu(struct device *dev,
>   		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>   {
> @@ -1084,42 +1096,24 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   			vma_pages(vma) << PAGE_SHIFT, vma->vm_page_prot);
>   }
>   
> -static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
> -		size_t size)
> -{
> -	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> -
> -	if (!ret)
> -		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> -	return ret;
> -}
> -
>   static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs)
>   {
> -	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	struct vm_struct *area = find_vm_area(cpu_addr);
> -
> -	if (!is_vmalloc_addr(cpu_addr)) {
> -		struct page *page = virt_to_page(cpu_addr);
> -		return __iommu_dma_get_sgtable_page(sgt, page, size);
> -	}
> -
> -	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		/*
> -		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> -		 * hence in the vmalloc space.
> -		 */
> -		struct page *page = vmalloc_to_page(cpu_addr);
> -		return __iommu_dma_get_sgtable_page(sgt, page, size);
> -	}
> +	struct page *page;
> +	int ret;
>   
> -	if (WARN_ON(!area || !area->pages))
> -		return -ENXIO;
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
> +			return iommu_dma_get_sgtable_remap(sgt, cpu_addr, size);
> +		page = vmalloc_to_page(cpu_addr);
> +	} else
> +		page = virt_to_page(cpu_addr);
>   
> -	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
> -					 GFP_KERNEL);
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (!ret)
> +		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> +	return ret;
>   }
>   
>   static const struct dma_map_ops iommu_dma_ops = {
> 
