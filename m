From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] kernel/dma/direct: refine dma_direct_alloc zone
	selection
Date: Fri, 24 Aug 2018 12:38:01 +0100
Message-ID: <bfba5bae-a88c-f777-ba1f-f0db310904dc@arm.com>
References: <20180824065324.654-1-hch@lst.de> <20180824065324.654-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180824065324.654-3-hch-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 24/08/18 07:53, Christoph Hellwig wrote:
> We need to take the DMA offset and encryption bit into account when selecting
> a zone.  Add a helper that takes those into account and use it.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>   kernel/dma/direct.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index de87b0282e74..3f8b596ea393 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -58,6 +58,14 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>   	return addr + size - 1 <= dev->coherent_dma_mask;
>   }
>   
> +static bool dma_coherent_below(struct device *dev, u64 mask)
> +{
> +	dma_addr_t addr = force_dma_unencrypted() ?
> +		__phys_to_dma(dev, mask) : phys_to_dma(dev, mask);
> +
> +	return dev->coherent_dma_mask <= addr;
> +}
> +
>   void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t gfp, unsigned long attrs)
>   {
> @@ -70,9 +78,9 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   	gfp &= ~__GFP_ZERO;
>   
>   	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> -	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> +	if (dma_coherent_below(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
>   		gfp |= GFP_DMA;
> -	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
> +	if (dma_coherent_below(dev, DMA_BIT_MASK(32) && !(gfp & GFP_DMA)))
>   		gfp |= GFP_DMA32;
>   
>   again:
> @@ -93,14 +101,14 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		page = NULL;
>   
>   		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> -		    dev->coherent_dma_mask < DMA_BIT_MASK(64) &&

We're effectively changing the "<" into a "<="...

> +		    dma_coherent_below(dev, DMA_BIT_MASK(64)) &&

...which I think means this check now *always* returns true...

>   		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
>   			gfp |= GFP_DMA32;
>   			goto again;
>   		}
>   
>   		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
> -		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
> +		    dma_coherent_below(dev, DMA_BIT_MASK(32)) &&

...and this one subtly changes WRT ZONE_DMA32, but I can't quite figure 
out how much that matters :/

Robin.

>   		    !(gfp & GFP_DMA)) {
>   			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
>   			goto again;
> 
