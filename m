From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 20/20] powerpc/dma: remove dma_nommu_mmap_coherent
Date: Thu, 09 Aug 2018 11:05:09 +1000
Message-ID: <0b6b08b001ca2f7998192cc4bb7b8e13a0758b43.camel@kernel.crashing.org>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-21-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180730163824.10064-21-hch-jcswGhMUV9g@public.gmane.org>
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
> The remaining implementation for coherent caches is functionally
> identical to the default provided in common code.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Acked-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>

> ---
>  arch/powerpc/include/asm/dma-mapping.h |  7 -------
>  arch/powerpc/kernel/dma-iommu.c        |  1 -
>  arch/powerpc/kernel/dma.c              | 13 -------------
>  arch/powerpc/platforms/pseries/vio.c   |  1 -
>  4 files changed, 22 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 879c4efba785..e62e23aa3714 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -18,13 +18,6 @@
>  #include <asm/io.h>
>  #include <asm/swiotlb.h>
>  
> -/* Some dma direct funcs must be visible for use in other dma_ops */
> -extern int dma_nommu_mmap_coherent(struct device *dev,
> -				    struct vm_area_struct *vma,
> -				    void *cpu_addr, dma_addr_t handle,
> -				    size_t size, unsigned long attrs);
> -
> -
>  static inline unsigned long device_to_mask(struct device *dev)
>  {
>  	if (dev->dma_mask && *dev->dma_mask)
> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
> index f9fe2080ceb9..bf5234e1f71b 100644
> --- a/arch/powerpc/kernel/dma-iommu.c
> +++ b/arch/powerpc/kernel/dma-iommu.c
> @@ -114,7 +114,6 @@ int dma_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  struct dma_map_ops dma_iommu_ops = {
>  	.alloc			= dma_iommu_alloc_coherent,
>  	.free			= dma_iommu_free_coherent,
> -	.mmap			= dma_nommu_mmap_coherent,
>  	.map_sg			= dma_iommu_map_sg,
>  	.unmap_sg		= dma_iommu_unmap_sg,
>  	.dma_supported		= dma_iommu_dma_supported,
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 08b12cbd7abf..5b71c9d1b8cc 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -70,18 +70,6 @@ static void dma_nommu_free_coherent(struct device *dev, size_t size,
>  	iommu_free_coherent(iommu, size, vaddr, dma_handle);
>  }
>  
> -int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
> -			     void *cpu_addr, dma_addr_t handle, size_t size,
> -			     unsigned long attrs)
> -{
> -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> -
> -	return remap_pfn_range(vma, vma->vm_start,
> -			       pfn + vma->vm_pgoff,
> -			       vma->vm_end - vma->vm_start,
> -			       vma->vm_page_prot);
> -}
> -
>  /* note: needs to be called arch_get_required_mask for dma-noncoherent.c */
>  u64 arch_get_required_mask(struct device *dev)
>  {
> @@ -98,7 +86,6 @@ u64 arch_get_required_mask(struct device *dev)
>  const struct dma_map_ops dma_nommu_ops = {
>  	.alloc				= dma_nommu_alloc_coherent,
>  	.free				= dma_nommu_free_coherent,
> -	.mmap				= dma_nommu_mmap_coherent,
>  	.map_sg				= dma_direct_map_sg,
>  	.map_page			= dma_direct_map_page,
>  	.get_required_mask		= arch_get_required_mask,
> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> index 49e04ec19238..51d564313bd0 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -618,7 +618,6 @@ static u64 vio_dma_get_required_mask(struct device *dev)
>  static const struct dma_map_ops vio_dma_mapping_ops = {
>  	.alloc             = vio_dma_iommu_alloc_coherent,
>  	.free              = vio_dma_iommu_free_coherent,
> -	.mmap		   = dma_nommu_mmap_coherent,
>  	.map_sg            = vio_dma_iommu_map_sg,
>  	.unmap_sg          = vio_dma_iommu_unmap_sg,
>  	.map_page          = vio_dma_iommu_map_page,
