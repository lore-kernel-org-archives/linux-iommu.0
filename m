From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/10] swiotlb: do not panic on mapping failures
Date: Thu, 11 Oct 2018 19:06:31 +0100
Message-ID: <ff847d0d-a2a1-65ba-ed18-aa71f632194d@arm.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008080246.20543-4-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 08/10/18 09:02, Christoph Hellwig wrote:
> All properly written drivers now have error handling in the
> dma_map_single / dma_map_page callers.  As swiotlb_tbl_map_single already
> prints a useful warning when running out of swiotlb pool swace we can
> also remove swiotlb_full entirely as it serves no purpose now.

$ git grep -l 'dma_map_\(page\|single\)' drivers/ | wc -l
385
$ git grep -l dma_mapping_error drivers/ | wc -l
396

Close enough, to first approximation :D

I agree the other (non-fatal) warning seems sufficient, and frankly the 
panic can be a bit of a pain for development sometimes.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 33 +--------------------------------
>   1 file changed, 1 insertion(+), 32 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 26d3af52956f..69bf305ee5f8 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -761,34 +761,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
>   	return true;
>   }
>   
> -static void
> -swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
> -	     int do_panic)
> -{
> -	if (swiotlb_force == SWIOTLB_NO_FORCE)
> -		return;
> -
> -	/*
> -	 * Ran out of IOMMU space for this operation. This is very bad.
> -	 * Unfortunately the drivers cannot handle this operation properly.
> -	 * unless they check for dma_mapping_error (most don't)
> -	 * When the mapping is small enough return a static buffer to limit
> -	 * the damage, or panic when the transfer is too big.
> -	 */
> -	dev_err_ratelimited(dev, "DMA: Out of SW-IOMMU space for %zu bytes\n",
> -			    size);
> -
> -	if (size <= io_tlb_overflow || !do_panic)
> -		return;
> -
> -	if (dir == DMA_BIDIRECTIONAL)
> -		panic("DMA: Random memory could be DMA accessed\n");
> -	if (dir == DMA_FROM_DEVICE)
> -		panic("DMA: Random memory could be DMA written\n");
> -	if (dir == DMA_TO_DEVICE)
> -		panic("DMA: Random memory could be DMA read\n");
> -}
> -
>   /*
>    * Map a single buffer of the indicated size for DMA in streaming mode.  The
>    * physical address to use is returned.
> @@ -817,10 +789,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>   
>   	/* Oh well, have to allocate and map a bounce buffer. */
>   	map = map_single(dev, phys, size, dir, attrs);
> -	if (map == SWIOTLB_MAP_ERROR) {
> -		swiotlb_full(dev, size, dir, 1);
> +	if (map == SWIOTLB_MAP_ERROR)
>   		return __phys_to_dma(dev, io_tlb_overflow_buffer);
> -	}
>   
>   	dev_addr = __phys_to_dma(dev, map);
>   
> @@ -948,7 +918,6 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
>   			if (map == SWIOTLB_MAP_ERROR) {
>   				/* Don't panic here, we expect map_sg users
>   				   to do proper error handling. */
> -				swiotlb_full(hwdev, sg->length, dir, 0);
>   				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>   				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
>   						       attrs);
> 
