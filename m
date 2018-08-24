From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] kernel/dma/direct: take DMA offset into account in
	dma_direct_supported
Date: Fri, 24 Aug 2018 12:11:23 +0100
Message-ID: <0e95df80-38f7-7970-ef74-419567f13fdc@arm.com>
References: <20180824065324.654-1-hch@lst.de> <20180824065324.654-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180824065324.654-2-hch-jcswGhMUV9g@public.gmane.org>
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
> When a device has a DMA offset the dma capable result will change due
> to the difference between the physical and DMA address.  Take that into
> account.

The "phys_to_dma(..., DMA_BIT_MASK(...))" idiom always looks like a 
glaring error at first glance, but this whole function is fairly 
unintuitive anyway, and ultimately I think the change does work out to 
be correct.

It might be nicer if we could reference max_zone_pfns[] for a bit more 
clarity, but I guess that's not arch-independent.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Reviewed-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> ---
>   kernel/dma/direct.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 1c35b7b945d0..de87b0282e74 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -168,7 +168,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   int dma_direct_supported(struct device *dev, u64 mask)
>   {
>   #ifdef CONFIG_ZONE_DMA
> -	if (mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> +	if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
>   		return 0;
>   #else
>   	/*
> @@ -177,7 +177,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>   	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
>   	 * architecture needs to use an IOMMU instead of the direct mapping.
>   	 */
> -	if (mask < DMA_BIT_MASK(32))
> +	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
>   		return 0;
>   #endif
>   	/*
> 
