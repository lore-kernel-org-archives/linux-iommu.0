From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] swiotlb: swiotlb_{alloc,free}_buffer should depend on
	CONFIG_DMA_DIRECT_OPS
Date: Fri, 23 Mar 2018 14:57:07 -0400
Message-ID: <20180323185707.GD25533@char.us.oracle.com>
References: <20180323174930.17767-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180323174930.17767-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 23, 2018 at 06:49:30PM +0100, Christoph Hellwig wrote:
> Otherwise we might get unused symbol warnings for configs that built
> swiotlb.c only for use by xen-swiotlb.c and that don't otherwise select
> CONFIG_DMA_DIRECT_OPS, which is possible on arm.
> 
> Fixes: 16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")
> Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>


Alternatively could we set the Kconfig to slect DMA_DIRECT_OPS?

> ---
>  lib/swiotlb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 15954b86f09e..47aeb04c1997 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -692,6 +692,7 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
>  	}
>  }
>  
> +#ifdef CONFIG_DMA_DIRECT_OPS
>  static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
>  		size_t size)
>  {
> @@ -763,6 +764,7 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
>  				 DMA_ATTR_SKIP_CPU_SYNC);
>  	return true;
>  }
> +#endif
>  
>  static void
>  swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
> -- 
> 2.14.2
> 
