From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 15/20] powerpc/dma: remove the unused unmap_page and
	unmap_sg methods
Date: Thu, 09 Aug 2018 10:49:57 +1000
Message-ID: <1c1a9507fef0a06843bedd91de8bfbe6d27e8beb.camel@kernel.crashing.org>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-16-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180730163824.10064-16-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2018-07-30 at 18:38 +0200, Christoph Hellwig wrote:
> These methods are optional to start with, no need to implement no-op
> versions.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Acked-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>

> ---
>  arch/powerpc/kernel/dma.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 511a4972560d..2cfc45acbb52 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -178,12 +178,6 @@ static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
>  	return nents;
>  }
>  
> -static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sg,
> -				int nents, enum dma_data_direction direction,
> -				unsigned long attrs)
> -{
> -}
> -
>  static u64 dma_nommu_get_required_mask(struct device *dev)
>  {
>  	u64 end, mask;
> @@ -209,14 +203,6 @@ static inline dma_addr_t dma_nommu_map_page(struct device *dev,
>  	return phys_to_dma(dev, page_to_phys(page)) + offset;
>  }
>  
> -static inline void dma_nommu_unmap_page(struct device *dev,
> -					 dma_addr_t dma_address,
> -					 size_t size,
> -					 enum dma_data_direction direction,
> -					 unsigned long attrs)
> -{
> -}
> -
>  #ifdef CONFIG_NOT_COHERENT_CACHE
>  static inline void dma_nommu_sync_sg(struct device *dev,
>  		struct scatterlist *sgl, int nents,
> @@ -242,10 +228,8 @@ const struct dma_map_ops dma_nommu_ops = {
>  	.free				= dma_nommu_free_coherent,
>  	.mmap				= dma_nommu_mmap_coherent,
>  	.map_sg				= dma_nommu_map_sg,
> -	.unmap_sg			= dma_nommu_unmap_sg,
>  	.dma_supported			= dma_direct_supported,
>  	.map_page			= dma_nommu_map_page,
> -	.unmap_page			= dma_nommu_unmap_page,
>  	.get_required_mask		= dma_nommu_get_required_mask,
>  #ifdef CONFIG_NOT_COHERENT_CACHE
>  	.sync_single_for_cpu 		= dma_nommu_sync_single,
