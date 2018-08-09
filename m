From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 13/20] powerpc/dma: remove get_dma_offset
Date: Thu, 09 Aug 2018 10:45:22 +1000
Message-ID: <65b4dfcc38a7ace49f3bcac95cf9e2d3ef544650.camel@kernel.crashing.org>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-14-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180730163824.10064-14-hch-jcswGhMUV9g@public.gmane.org>
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
> Just fold the calculation into __phys_to_dma/__dma_to_phys as those are
> the only places that should know about it.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Acked-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>

> ---
>  arch/powerpc/include/asm/dma-direct.h  |  8 ++++++--
>  arch/powerpc/include/asm/dma-mapping.h | 16 ----------------
>  2 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
> index 7702875aabb7..0fba19445ae8 100644
> --- a/arch/powerpc/include/asm/dma-direct.h
> +++ b/arch/powerpc/include/asm/dma-direct.h
> @@ -19,11 +19,15 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  
>  static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
> -	return paddr + get_dma_offset(dev);
> +	if (!dev)
> +		return paddr + PCI_DRAM_OFFSET;
> +	return paddr + dev->archdata.dma_offset;
>  }
>  
>  static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
>  {
> -	return daddr - get_dma_offset(dev);
> +	if (!dev)
> +		return daddr - PCI_DRAM_OFFSET;
> +	return daddr - dev->archdata.dma_offset;
>  }
>  #endif /* ASM_POWERPC_DMA_DIRECT_H */
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index dacd0f93f2b2..f0bf7ac2686c 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -80,22 +80,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>  	return NULL;
>  }
>  
> -/*
> - * get_dma_offset()
> - *
> - * Get the dma offset on configurations where the dma address can be determined
> - * from the physical address by looking at a simple offset.  Direct dma and
> - * swiotlb use this function, but it is typically not used by implementations
> - * with an iommu.
> - */
> -static inline dma_addr_t get_dma_offset(struct device *dev)
> -{
> -	if (dev)
> -		return dev->archdata.dma_offset;
> -
> -	return PCI_DRAM_OFFSET;
> -}
> -
>  static inline void set_dma_offset(struct device *dev, dma_addr_t off)
>  {
>  	if (dev)
