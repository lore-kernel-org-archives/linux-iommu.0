From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 14/20] powerpc/dma: replace dma_nommu_dma_supported with
	dma_direct_supported
Date: Thu, 09 Aug 2018 10:49:29 +1000
Message-ID: <59b0e0de78e10d6c96175825f2c7f6358acb106a.camel@kernel.crashing.org>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-15-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180730163824.10064-15-hch-jcswGhMUV9g@public.gmane.org>
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
> The ppc32 case of dma_nommu_dma_supported already was a no-op, and the
> 64-bit case came to the same conclusion as dma_direct_supported, so
> replace it with the generic version.

It's not at all equivalent (see my review on your earlier patch) or
am I missing something ?

 - ppc32 always return 1, but dma_direct_supported() will not for
devices with a <32-bit mask (and yes ppc32 isn't quite right to do
so, it should check against memory size, but in practice it worked
as the only limited devices we deal with on systems we still support
have a 31-bit limitation)

 - ppc64 needs to check against the end of DRAM as some devices will
fail the check, dma_direct_supported() doesn't seem to be doing that.

Also as I mentioned, I'm not sure about the business with ZONE_DMA,
and that arbitrary 24-bit limit since our entire memory is in ZONE_DMA
but that's a different can of worms I suppose.

> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>


> ---
>  arch/powerpc/Kconfig      |  1 +
>  arch/powerpc/kernel/dma.c | 28 +++-------------------------
>  2 files changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index f9cae7edd735..bbfa6a8df4da 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -158,6 +158,7 @@ config PPC
>  	select CLONE_BACKWARDS
>  	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
>  	select DYNAMIC_FTRACE			if FUNCTION_TRACER
> +	select DMA_DIRECT_OPS
>  	select EDAC_ATOMIC_SCRUB
>  	select EDAC_SUPPORT
>  	select GENERIC_ATOMIC64			if PPC32
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 3487de83bb37..511a4972560d 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -40,28 +40,6 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
>  	return pfn;
>  }
>  
> -static int dma_nommu_dma_supported(struct device *dev, u64 mask)
> -{
> -#ifdef CONFIG_PPC64
> -	u64 limit = phys_to_dma(dev, (memblock_end_of_DRAM() - 1));
> -
> -	/* Limit fits in the mask, we are good */
> -	if (mask >= limit)
> -		return 1;
> -
> -#ifdef CONFIG_FSL_SOC
> -	/* Freescale gets another chance via ZONE_DMA/ZONE_DMA32, however
> -	 * that will have to be refined if/when they support iommus
> -	 */
> -	return 1;
> -#endif
> -	/* Sorry ... */
> -	return 0;
> -#else
> -	return 1;
> -#endif
> -}
> -
>  #ifndef CONFIG_NOT_COHERENT_CACHE
>  void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
>  				  dma_addr_t *dma_handle, gfp_t flag,
> @@ -126,7 +104,7 @@ static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
>  	/* The coherent mask may be smaller than the real mask, check if
>  	 * we can really use the direct ops
>  	 */
> -	if (dma_nommu_dma_supported(dev, dev->coherent_dma_mask))
> +	if (dma_direct_supported(dev, dev->coherent_dma_mask))
>  		return __dma_nommu_alloc_coherent(dev, size, dma_handle,
>  						   flag, attrs);
>  
> @@ -148,7 +126,7 @@ static void dma_nommu_free_coherent(struct device *dev, size_t size,
>  	struct iommu_table *iommu;
>  
>  	/* See comments in dma_nommu_alloc_coherent() */
> -	if (dma_nommu_dma_supported(dev, dev->coherent_dma_mask))
> +	if (dma_direct_supported(dev, dev->coherent_dma_mask))
>  		return __dma_nommu_free_coherent(dev, size, vaddr, dma_handle,
>  						  attrs);
>  	/* Maybe we used an iommu ... */
> @@ -265,7 +243,7 @@ const struct dma_map_ops dma_nommu_ops = {
>  	.mmap				= dma_nommu_mmap_coherent,
>  	.map_sg				= dma_nommu_map_sg,
>  	.unmap_sg			= dma_nommu_unmap_sg,
> -	.dma_supported			= dma_nommu_dma_supported,
> +	.dma_supported			= dma_direct_supported,
>  	.map_page			= dma_nommu_map_page,
>  	.unmap_page			= dma_nommu_unmap_page,
>  	.get_required_mask		= dma_nommu_get_required_mask,
