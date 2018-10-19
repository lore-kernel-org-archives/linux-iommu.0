From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 09/10] swiotlb: add support for non-coherent DMA
Date: Thu, 18 Oct 2018 20:49:43 -0400
Message-ID: <20181019004943.GK1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-10-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-10-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 08, 2018 at 10:02:45AM +0200, Christoph Hellwig wrote:
> Handle architectures that are not cache coherent directly in the main
> swiotlb code by calling arch_sync_dma_for_{device,cpu} in all the right
> places from the various dma_map/unmap/sync methods when the device is
> non-coherent.
> 
> Because swiotlb now uses dma_direct_alloc for the coherent allocation
> that side is already taken care of by the dma-direct code calling into
> arch_dma_{alloc,free} for devices that are non-coherent.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  kernel/dma/swiotlb.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 475a41eff3dc..52885b274368 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -21,6 +21,7 @@
>  
>  #include <linux/cache.h>
>  #include <linux/dma-direct.h>
> +#include <linux/dma-noncoherent.h>
>  #include <linux/mm.h>
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
> @@ -677,6 +678,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
>  	}
>  
> +	if (!dev_is_dma_coherent(dev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +		arch_sync_dma_for_device(dev, phys, size, dir);
> +
>  	return dma_addr;
>  }
>  
> @@ -696,6 +701,10 @@ void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  
>  	BUG_ON(dir == DMA_NONE);
>  
> +	if (!dev_is_dma_coherent(hwdev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
> +
>  	if (is_swiotlb_buffer(paddr)) {
>  		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
>  		return;
> @@ -732,15 +741,17 @@ swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
>  
>  	BUG_ON(dir == DMA_NONE);
>  
> -	if (is_swiotlb_buffer(paddr)) {
> +	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_CPU)
> +		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
> +
> +	if (is_swiotlb_buffer(paddr))
>  		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
> -		return;
> -	}
>  
> -	if (dir != DMA_FROM_DEVICE)
> -		return;
> +	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_DEVICE)
> +		arch_sync_dma_for_device(hwdev, paddr, size, dir);
>  
> -	dma_mark_clean(phys_to_virt(paddr), size);
> +	if (!is_swiotlb_buffer(paddr) && dir == DMA_FROM_DEVICE)
> +		dma_mark_clean(phys_to_virt(paddr), size);
>  }
>  
>  void
> -- 
> 2.19.0
> 
