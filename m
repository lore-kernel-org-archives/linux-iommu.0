From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 08/10] swiotlb: don't dip into swiotlb pool for coherent
	allocations
Date: Thu, 18 Oct 2018 20:40:44 -0400
Message-ID: <20181019004044.GJ1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
	<20181008080246.20543-9-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-9-hch-jcswGhMUV9g@public.gmane.org>
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

On Mon, Oct 08, 2018 at 10:02:44AM +0200, Christoph Hellwig wrote:
> All architectures that support swiotlb also have a zone that backs up
> these less than full addressing allocations (usually ZONE_DMA32).
> 
> Because of that it is rather pointless to fall back to the global swiotlb
> buffer if the normal dma direct allocation failed - the only thing this
> will do is to eat up bounce buffers that would be more useful to serve
> streaming mappings.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Thank you!
> ---
>  arch/arm64/mm/dma-mapping.c |   6 +--
>  include/linux/swiotlb.h     |   5 --
>  kernel/dma/swiotlb.c        | 105 +-----------------------------------
>  3 files changed, 5 insertions(+), 111 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 8d91b927e09e..eee6cfcfde9e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -112,7 +112,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>  		return addr;
>  	}
>  
> -	ptr = swiotlb_alloc(dev, size, dma_handle, flags, attrs);
> +	ptr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
>  	if (!ptr)
>  		goto no_mem;
>  
> @@ -133,7 +133,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>  	return coherent_ptr;
>  
>  no_map:
> -	swiotlb_free(dev, size, ptr, *dma_handle, attrs);
> +	dma_direct_free_pages(dev, size, ptr, *dma_handle, attrs);
>  no_mem:
>  	return NULL;
>  }
> @@ -151,7 +151,7 @@ static void __dma_free(struct device *dev, size_t size,
>  			return;
>  		vunmap(vaddr);
>  	}
> -	swiotlb_free(dev, size, swiotlb_addr, dma_handle, attrs);
> +	dma_direct_free_pages(dev, size, swiotlb_addr, dma_handle, attrs);
>  }
>  
>  static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index f847c1b265c4..a387b59640a4 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -67,11 +67,6 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
>  
>  /* Accessory functions. */
>  
> -void *swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t flags, unsigned long attrs);
> -void swiotlb_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_addr, unsigned long attrs);
> -
>  extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  				   unsigned long offset, size_t size,
>  				   enum dma_data_direction dir,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4d7a4d85d71e..475a41eff3dc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -622,78 +622,6 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
>  	}
>  }
>  
> -static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
> -		size_t size)
> -{
> -	u64 mask = DMA_BIT_MASK(32);
> -
> -	if (dev && dev->coherent_dma_mask)
> -		mask = dev->coherent_dma_mask;
> -	return addr + size - 1 <= mask;
> -}
> -
> -static void *
> -swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		unsigned long attrs)
> -{
> -	phys_addr_t phys_addr;
> -
> -	if (swiotlb_force == SWIOTLB_NO_FORCE)
> -		goto out_warn;
> -
> -	phys_addr = swiotlb_tbl_map_single(dev,
> -			__phys_to_dma(dev, io_tlb_start),
> -			0, size, DMA_FROM_DEVICE, attrs);
> -	if (phys_addr == SWIOTLB_MAP_ERROR)
> -		goto out_warn;
> -
> -	*dma_handle = __phys_to_dma(dev, phys_addr);
> -	if (!dma_coherent_ok(dev, *dma_handle, size))
> -		goto out_unmap;
> -
> -	memset(phys_to_virt(phys_addr), 0, size);
> -	return phys_to_virt(phys_addr);
> -
> -out_unmap:
> -	dev_warn(dev, "hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
> -		(unsigned long long)dev->coherent_dma_mask,
> -		(unsigned long long)*dma_handle);
> -
> -	/*
> -	 * DMA_TO_DEVICE to avoid memcpy in unmap_single.
> -	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
> -	 */
> -	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
> -			DMA_ATTR_SKIP_CPU_SYNC);
> -out_warn:
> -	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
> -		dev_warn(dev,
> -			"swiotlb: coherent allocation failed, size=%zu\n",
> -			size);
> -		dump_stack();
> -	}
> -	return NULL;
> -}
> -
> -static bool swiotlb_free_buffer(struct device *dev, size_t size,
> -		dma_addr_t dma_addr)
> -{
> -	phys_addr_t phys_addr = dma_to_phys(dev, dma_addr);
> -
> -	WARN_ON_ONCE(irqs_disabled());
> -
> -	if (!is_swiotlb_buffer(phys_addr))
> -		return false;
> -
> -	/*
> -	 * DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single.
> -	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
> -	 */
> -	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
> -				 DMA_ATTR_SKIP_CPU_SYNC);
> -	return true;
> -}
> -
>  static dma_addr_t swiotlb_bounce_page(struct device *dev, phys_addr_t *phys,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> @@ -928,39 +856,10 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
>  }
>  
> -void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t gfp, unsigned long attrs)
> -{
> -	void *vaddr;
> -
> -	/* temporary workaround: */
> -	if (gfp & __GFP_NOWARN)
> -		attrs |= DMA_ATTR_NO_WARN;
> -
> -	/*
> -	 * Don't print a warning when the first allocation attempt fails.
> -	 * swiotlb_alloc_coherent() will print a warning when the DMA memory
> -	 * allocation ultimately failed.
> -	 */
> -	gfp |= __GFP_NOWARN;
> -
> -	vaddr = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
> -	if (!vaddr)
> -		vaddr = swiotlb_alloc_buffer(dev, size, dma_handle, attrs);
> -	return vaddr;
> -}
> -
> -void swiotlb_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_addr, unsigned long attrs)
> -{
> -	if (!swiotlb_free_buffer(dev, size, dma_addr))
> -		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
> -}
> -
>  const struct dma_map_ops swiotlb_dma_ops = {
>  	.mapping_error		= dma_direct_mapping_error,
> -	.alloc			= swiotlb_alloc,
> -	.free			= swiotlb_free,
> +	.alloc			= dma_direct_alloc,
> +	.free			= dma_direct_free,
>  	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
>  	.sync_single_for_device	= swiotlb_sync_single_for_device,
>  	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
> -- 
> 2.19.0
> 
