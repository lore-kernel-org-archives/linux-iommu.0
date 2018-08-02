From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm64: remove dummy_dma_ops
Date: Thu, 2 Aug 2018 13:32:17 +0100
Message-ID: <bbb22836-8f2f-5b2f-4801-342643fd9c1b@arm.com>
References: <20180802121318.5785-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180802121318.5785-1-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/08/18 13:13, Christoph Hellwig wrote:
> Returning NULL from get_arch_dma_ops makes all DMA mapping routines
> retourn sensible errors, so remove the dummy ops.

Does it? AFAICS all of the non-optional callbacks will still either 
BUG_ON(!ops) or blindly dereference the null pointer. Have I lost track 
of another cleanup patch somewhere?

FWIW the point of dummy_dma_ops is to fail safe when the ACPI tables 
fail to specify _CCA for a device - of course that *should* be caught 
during firmware development, but if something does slip through because 
the firmware developer used an older kernel (or never tested device x at 
all), then the difference to the end user between "device x can't do 
DMA" and "new kernel blows up" is pretty significant.

Robin.

> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>   arch/arm64/include/asm/dma-mapping.h |  4 +-
>   arch/arm64/mm/dma-mapping.c          | 92 ----------------------------
>   2 files changed, 1 insertion(+), 95 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index b7847eb8a7bb7..3dd7c10efc745 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -24,15 +24,13 @@
>   #include <xen/xen.h>
>   #include <asm/xen/hypervisor.h>
>   
> -extern const struct dma_map_ops dummy_dma_ops;
> -
>   static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>   {
>   	/*
>   	 * We expect no ISA devices, and all other DMA masters are expected to
>   	 * have someone call arch_setup_dma_ops at device creation time.
>   	 */
> -	return &dummy_dma_ops;
> +	return NULL;
>   }
>   
>   void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 072c51fb07d73..4fdce2db6f12d 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -406,98 +406,6 @@ static int __init atomic_pool_init(void)
>   	return -ENOMEM;
>   }
>   
> -/********************************************
> - * The following APIs are for dummy DMA ops *
> - ********************************************/
> -
> -static void *__dummy_alloc(struct device *dev, size_t size,
> -			   dma_addr_t *dma_handle, gfp_t flags,
> -			   unsigned long attrs)
> -{
> -	return NULL;
> -}
> -
> -static void __dummy_free(struct device *dev, size_t size,
> -			 void *vaddr, dma_addr_t dma_handle,
> -			 unsigned long attrs)
> -{
> -}
> -
> -static int __dummy_mmap(struct device *dev,
> -			struct vm_area_struct *vma,
> -			void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -			unsigned long attrs)
> -{
> -	return -ENXIO;
> -}
> -
> -static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
> -				   unsigned long offset, size_t size,
> -				   enum dma_data_direction dir,
> -				   unsigned long attrs)
> -{
> -	return 0;
> -}
> -
> -static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
> -			       size_t size, enum dma_data_direction dir,
> -			       unsigned long attrs)
> -{
> -}
> -
> -static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
> -			  int nelems, enum dma_data_direction dir,
> -			  unsigned long attrs)
> -{
> -	return 0;
> -}
> -
> -static void __dummy_unmap_sg(struct device *dev,
> -			     struct scatterlist *sgl, int nelems,
> -			     enum dma_data_direction dir,
> -			     unsigned long attrs)
> -{
> -}
> -
> -static void __dummy_sync_single(struct device *dev,
> -				dma_addr_t dev_addr, size_t size,
> -				enum dma_data_direction dir)
> -{
> -}
> -
> -static void __dummy_sync_sg(struct device *dev,
> -			    struct scatterlist *sgl, int nelems,
> -			    enum dma_data_direction dir)
> -{
> -}
> -
> -static int __dummy_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
> -{
> -	return 1;
> -}
> -
> -static int __dummy_dma_supported(struct device *hwdev, u64 mask)
> -{
> -	return 0;
> -}
> -
> -const struct dma_map_ops dummy_dma_ops = {
> -	.alloc                  = __dummy_alloc,
> -	.free                   = __dummy_free,
> -	.mmap                   = __dummy_mmap,
> -	.map_page               = __dummy_map_page,
> -	.unmap_page             = __dummy_unmap_page,
> -	.map_sg                 = __dummy_map_sg,
> -	.unmap_sg               = __dummy_unmap_sg,
> -	.sync_single_for_cpu    = __dummy_sync_single,
> -	.sync_single_for_device = __dummy_sync_single,
> -	.sync_sg_for_cpu        = __dummy_sync_sg,
> -	.sync_sg_for_device     = __dummy_sync_sg,
> -	.mapping_error          = __dummy_mapping_error,
> -	.dma_supported          = __dummy_dma_supported,
> -};
> -EXPORT_SYMBOL(dummy_dma_ops);
> -
>   static int __init arm64_dma_init(void)
>   {
>   	if (swiotlb_force == SWIOTLB_FORCE ||
> 
