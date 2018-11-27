From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 2/2] swiotlb: Skip cache maintenance on map error
Date: Tue, 27 Nov 2018 12:38:49 -0800 (PST)
Message-ID: <alpine.DEB.2.10.1811271238290.4577@sstabellini-ThinkPad-X260>
References: <cover.1542812807.git.robin.murphy@arm.com> <cc6d91acc357235cbd6e0e134382c58caa188801.1542812807.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cc6d91acc357235cbd6e0e134382c58caa188801.1542812807.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, konrad.wilk@oracle.com, m.szyprowski@samsung.com, john.stultz@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sstabellini@kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 21 Nov 2018, Robin Murphy wrote:
> If swiotlb_bounce_page() failed, calling arch_sync_dma_for_device() may
> lead to such delights as performing cache maintenance on whatever
> address phys_to_virt(SWIOTLB_MAP_ERROR) looks like, which is typically
> outside the kernel memory map and goes about as well as expected.
> 
> Don't do that.
> 
> Fixes: a4a4330db46a ("swiotlb: add support for non-coherent DMA")
> Tested-by: John Stultz <john.stultz@linaro.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
> 
> v2: Collect tags
> 
>  kernel/dma/swiotlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 5731daa09a32..045930e32c0e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -679,7 +679,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  	}
>  
>  	if (!dev_is_dma_coherent(dev) &&
> -	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0 &&
> +	    dev_addr != DIRECT_MAPPING_ERROR)
>  		arch_sync_dma_for_device(dev, phys, size, dir);
>  
>  	return dev_addr;
> -- 
> 2.19.1.dirty
> 
