From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
	swiotlb_map_sg_attrs
Date: Thu, 18 Oct 2018 18:53:07 +0100
Message-ID: <3ffc4e16-979c-7d04-2d6c-f784be583b70@arm.com>
References: <20181008080246.20543-1-hch@lst.de>
	<20181008080246.20543-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181008080246.20543-7-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 08/10/18 09:02, Christoph Hellwig wrote:
> No need to duplicate the code - map_sg is equivalent to map_page
> for each page in the scatterlist.

Even better, this will also make map_sg actually fire the tracepoint 
(which I've certainly found handy in the past for debugging a mask 
cockup that led to excessive bouncing).

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>   kernel/dma/swiotlb.c | 34 ++++++++++++----------------------
>   1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 15335f3a1bf3..15755d7a5242 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -845,37 +845,27 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
>    * same here.
>    */
>   int
> -swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
> +swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
>   		     enum dma_data_direction dir, unsigned long attrs)
>   {
>   	struct scatterlist *sg;
>   	int i;
>   
> -	BUG_ON(dir == DMA_NONE);
> -
>   	for_each_sg(sgl, sg, nelems, i) {
> -		phys_addr_t paddr = sg_phys(sg);
> -		dma_addr_t dev_addr = phys_to_dma(hwdev, paddr);
> -
> -		if (swiotlb_force == SWIOTLB_FORCE ||
> -		    !dma_capable(hwdev, dev_addr, sg->length)) {
> -			phys_addr_t map = map_single(hwdev, sg_phys(sg),
> -						     sg->length, dir, attrs);
> -			if (map == SWIOTLB_MAP_ERROR) {
> -				/* Don't panic here, we expect map_sg users
> -				   to do proper error handling. */
> -				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> -				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
> -						       attrs);
> -				sg_dma_len(sgl) = 0;
> -				return 0;
> -			}
> -			sg->dma_address = __phys_to_dma(hwdev, map);
> -		} else
> -			sg->dma_address = dev_addr;
> +		sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
> +				sg->length, dir, attrs);
> +		if (sg->dma_address == DIRECT_MAPPING_ERROR)
> +			goto out_error;
>   		sg_dma_len(sg) = sg->length;
>   	}
> +
>   	return nelems;
> +
> +out_error:
> +	swiotlb_unmap_sg_attrs(dev, sgl, i, dir,
> +			attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_dma_len(sgl) = 0;
> +	return 0;
>   }
>   
>   /*
> 
