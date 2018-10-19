From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
	swiotlb_map_sg_attrs
Date: Thu, 18 Oct 2018 20:33:08 -0400
Message-ID: <20181019003308.GH1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
	<20181008080246.20543-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-7-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 08, 2018 at 10:02:42AM +0200, Christoph Hellwig wrote:
> No need to duplicate the code - map_sg is equivalent to map_page
> for each page in the scatterlist.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Thank you!
> ---
>  kernel/dma/swiotlb.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 15335f3a1bf3..15755d7a5242 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -845,37 +845,27 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
>   * same here.
>   */
>  int
> -swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
> +swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
>  		     enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct scatterlist *sg;
>  	int i;
>  
> -	BUG_ON(dir == DMA_NONE);
> -
>  	for_each_sg(sgl, sg, nelems, i) {
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
>  		sg_dma_len(sg) = sg->length;
>  	}
> +
>  	return nelems;
> +
> +out_error:
> +	swiotlb_unmap_sg_attrs(dev, sgl, i, dir,
> +			attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_dma_len(sgl) = 0;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.19.0
> 
