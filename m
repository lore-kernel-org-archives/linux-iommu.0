From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] dma-direct: document the zone selection logic
Date: Mon, 1 Oct 2018 13:22:11 -0700
Message-ID: <4e9fd184-2ee4-1971-dcd9-34bfb8c05f65@infradead.org>
References: <20181001201016.32639-1-hch@lst.de>
 <20181001201016.32639-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001201016.32639-2-hch@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 10/1/18 1:10 PM, Christoph Hellwig wrote:
> What we are doing here isn't quite obvious, so add a comment explaining
> it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ba6f5956a291..14b966e2349a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -84,7 +84,14 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
>  	else
>  		*phys_mask = dma_to_phys(dev, dma_mask);
>  
> -	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> +	/*
> +	 * Optimistically try the zone that the physicall address mask falls

	                                        physical

> +	 * into first.  If that returns memory that isn't actually addressable
> +	 * we will fallback to the next lower zone and try again.
> +	 *
> +	 * Note that GFP_DMA32 and GFP_DMA are no ops without the corresponding
> +	 * zones.
> +	 */
>  	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
>  		return GFP_DMA;
>  	if (*phys_mask <= DMA_BIT_MASK(32))
> 

thanks for the documentation.

-- 
~Randy
