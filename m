From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
Date: Fri, 1 Feb 2019 15:24:45 +0000
Message-ID: <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114094159.27326-4-hch@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> Directly iterating over the pages makes the code a bit simpler and
> prepares for the following changes.

It also defeats the whole purpose of __iommu_dma_alloc_pages(), so I'm 
not really buying the simplification angle - you've *seen* that code, 
right? ;)

If you want simple, get rid of the pages array entirely. However, as 
I've touched on previously, it's all there for a reason, because making 
the individual iommu_map() calls as large as possible gives significant 
performance/power benefits in many cases which I'm not too keen to 
regress. In fact I still have the spark of an idea to sort the filled 
pages array for optimal physical layout, I've just never had the free 
time to play with it. FWIW, since iommu_map_sg() was new and promising 
at the time, using sg_alloc_table_from_pages() actually *was* the 
simplification over copying arch/arm's __iommu_create_mapping() logic.

Robin.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 40 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d19f3d6b43c1..4f5546a103d8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -30,6 +30,7 @@
>   #include <linux/mm.h>
>   #include <linux/pci.h>
>   #include <linux/scatterlist.h>
> +#include <linux/highmem.h>
>   #include <linux/vmalloc.h>
>   
>   struct iommu_dma_msi_page {
> @@ -549,9 +550,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct page **pages;
> -	struct sg_table sgt;
>   	dma_addr_t iova;
> -	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
> +	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap, i;
> +	size_t mapped = 0;
>   
>   	*handle = DMA_MAPPING_ERROR;
>   
> @@ -576,32 +577,25 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	if (!iova)
>   		goto out_free_pages;
>   
> -	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> -		goto out_free_iova;
> +	for (i = 0; i < count; i++) {
> +		phys_addr_t phys = page_to_phys(pages[i]);
>   
> -	if (!(prot & IOMMU_CACHE)) {
> -		struct sg_mapping_iter miter;
> -		/*
> -		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
> -		 * sufficient here, so skip it by using the "wrong" direction.
> -		 */
> -		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
> -		while (sg_miter_next(&miter))
> -			flush_page(dev, miter.addr, page_to_phys(miter.page));
> -		sg_miter_stop(&miter);
> -	}
> +		if (!(prot & IOMMU_CACHE)) {
> +			void *vaddr = kmap_atomic(pages[i]);
>   
> -	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
> -			< size)
> -		goto out_free_sg;
> +			flush_page(dev, vaddr, phys);
> +			kunmap_atomic(vaddr);
> +		}
> +
> +		if (iommu_map(domain, iova + mapped, phys, PAGE_SIZE, prot))
> +			goto out_unmap;
> +		mapped += PAGE_SIZE;
> +	}
>   
>   	*handle = iova;
> -	sg_free_table(&sgt);
>   	return pages;
> -
> -out_free_sg:
> -	sg_free_table(&sgt);
> -out_free_iova:
> +out_unmap:
> +	iommu_unmap(domain, iova, mapped);
>   	iommu_dma_free_iova(cookie, iova, size);
>   out_free_pages:
>   	__iommu_dma_free_pages(pages, count);
> 
