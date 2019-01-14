From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/3] dma-mapping: don't BUG when calling dma_map_resource
 on RAM
Date: Mon, 14 Jan 2019 14:16:46 +0000
Message-ID: <f8f9e4f0-87fc-9f4f-37ea-39297acc8d31@arm.com>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111181731.11782-3-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 11/01/2019 18:17, Christoph Hellwig wrote:
> Use WARN_ON_ONCE to print a stack trace and return a proper error
> code instead.

I was racking my brain to remember the reasoning behind BUG_ON() being 
the only viable way to prevent errors getting through unhandled, but of 
course that was before we had a standardised DMA_MAPPING_ERROR that 
would work across all implementations.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-mapping.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d3087829a6df..91add0751aa5 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -353,7 +353,8 @@ static inline dma_addr_t dma_map_resource(struct device *dev,
>   	BUG_ON(!valid_dma_direction(dir));
>   
>   	/* Don't allow RAM to be mapped */

Ugh, I'm pretty sure that that "pfn_valid means RAM" misunderstanding 
originally came from me - it might be nice to have a less-misleading 
comment here, but off-hand I can't think of a succinct way to say "only 
for 'DMA' access to MMIO registers/SRAMs/etc. and not for anything the 
kernel knows as actual system/device memory" to better explain the WARN...

Either way, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> -	BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
> +	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> +		return DMA_MAPPING_ERROR;
>   
>   	if (dma_is_direct(ops))
>   		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
> 
