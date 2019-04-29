From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/26] arm64/iommu: improve mmap bounds checking
Date: Mon, 29 Apr 2019 13:35:46 +0100
Message-ID: <306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com>
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422175942.18788-3-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> The nr_pages checks should be done for all mmap requests, not just those
> using remap_pfn_range.

I think it probably makes sense now to just squash this with #22 one way 
or the other, but if you really really still want to keep it as a 
separate patch with a misleading commit message then I'm willing to keep 
my complaints to myself :)

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/mm/dma-mapping.c | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 674860e3e478..604c638b2787 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -73,19 +73,9 @@ static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
>   static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
>   			      unsigned long pfn, size_t size)
>   {
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
> +	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> +			      vma->vm_end - vma->vm_start,
> +			      vma->vm_page_prot);
>   }
>   #endif /* CONFIG_IOMMU_DMA */
>   
> @@ -241,6 +231,8 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   			      unsigned long attrs)
>   {
> +	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long off = vma->vm_pgoff;
>   	struct vm_struct *area;
>   	int ret;
>   
> @@ -249,6 +241,9 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>   		return ret;
>   
> +	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
> +		return -ENXIO;
> +
>   	if (!is_vmalloc_addr(cpu_addr)) {
>   		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
>   		return __swiotlb_mmap_pfn(vma, pfn, size);
> 
