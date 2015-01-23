From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] arm64: add IOMMU dma_ops
Date: Fri, 23 Jan 2015 15:26:05 +0000
Message-ID: <20150123152605.GA31460@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
	<aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 12, 2015 at 08:48:56PM +0000, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm64/include/asm/device.h      |   3 +
>  arch/arm64/include/asm/dma-mapping.h |  12 ++
>  arch/arm64/mm/dma-mapping.c          | 297 +++++++++++++++++++++++++++++++++++
>  3 files changed, 312 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
> index 243ef25..c17f100 100644
> --- a/arch/arm64/include/asm/device.h
> +++ b/arch/arm64/include/asm/device.h
> @@ -20,6 +20,9 @@ struct dev_archdata {
>  	struct dma_map_ops *dma_ops;
>  #ifdef CONFIG_IOMMU_API
>  	void *iommu;			/* private IOMMU data */
> +#ifdef CONFIG_IOMMU_DMA
> +	struct iommu_dma_mapping *mapping;
> +#endif
>  #endif
>  	bool dma_coherent;
>  };
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 6932bb5..82082c4 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -64,11 +64,23 @@ static inline bool is_device_dma_coherent(struct device *dev)
>  
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
> +#ifdef CONFIG_IOMMU_DMA
> +	/* We don't have an easy way of dealing with this... */
> +	BUG_ON(dev->archdata.mapping);
> +#endif
>  	return (dma_addr_t)paddr;
>  }
>  
> +#ifdef CONFIG_IOMMU_DMA
> +phys_addr_t iova_to_phys(struct device *dev, dma_addr_t dev_addr);

I think this name is a bit too generic, especially as we already have an
iommu_iova_to_phys function in drivers/iommu/iommu.c

In fact, can't you just make CONFIG_IOMMU_DMA depend on IOMMU_API and then
use iommu_iova_to_phys instead?

> +#endif
> +
>  static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>  {
> +#ifdef CONFIG_IOMMU_DMA
> +	if (dev->archdata.mapping)
> +		return iova_to_phys(dev, dev_addr);
> +#endif
>  	return (phys_addr_t)dev_addr;
>  }

It would be cleaner just to define these functions twice; with and without
the CONFIG_IOMMU_DMA case.

> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 0a24b9b..8e449a7 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -23,6 +23,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dma-contiguous.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/vmalloc.h>
>  #include <linux/swiotlb.h>
>  
> @@ -426,6 +427,9 @@ static int __init arm64_dma_init(void)
>  
>  	ret |= swiotlb_late_init();
>  	ret |= atomic_pool_init();
> +#ifdef CONFIG_IOMMU_DMA
> +	ret |= iommu_dma_init();
> +#endif

Same here, just make an empty iommu_dma_init if !CONFIG_IOMMU_DMA.

>  	return ret;
>  }
> @@ -439,3 +443,296 @@ static int __init dma_debug_do_init(void)
>  	return 0;
>  }
>  fs_initcall(dma_debug_do_init);
> +
> +
> +#ifdef CONFIG_IOMMU_DMA
> +
> +static struct page **__atomic_get_pages(void *addr)
> +{
> +	struct page *page;
> +	phys_addr_t phys;
> +
> +	phys = gen_pool_virt_to_phys(atomic_pool, (unsigned long)addr);
> +	page = phys_to_page(phys);
> +
> +	return (struct page **)page;
> +}
> +
> +static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
> +{
> +	struct vm_struct *area;
> +
> +	if (__in_atomic_pool(cpu_addr, PAGE_SIZE))
> +		return __atomic_get_pages(cpu_addr);
> +
> +	area = find_vm_area(cpu_addr);
> +	if (!area)
> +		return NULL;
> +
> +	return area->pages;
> +}
> +
> +static void *__iommu_alloc_atomic(struct device *dev, size_t size,
> +				  dma_addr_t *handle, bool coherent)
> +{
> +	struct page *page;
> +	void *addr;
> +
> +	addr = __alloc_from_pool(size, &page);
> +	if (!addr)
> +		return NULL;
> +
> +	*handle = iommu_dma_create_iova_mapping(dev, &page, size, coherent);
> +	if (*handle == DMA_ERROR_CODE) {
> +		__free_from_pool(addr, size);
> +		return NULL;
> +	}
> +	return addr;
> +}
> +
> +static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
> +				dma_addr_t handle, size_t size)
> +{
> +	iommu_dma_release_iova_mapping(dev, handle, size);
> +	__free_from_pool(cpu_addr, size);
> +}
> +
> +static void __dma_clear_buffer(struct page *page, size_t size)
> +{
> +	void *ptr = page_address(page);
> +
> +	memset(ptr, 0, size);
> +	__dma_flush_range(ptr, ptr + size);
> +}
> +
> +static void *__iommu_alloc_attrs(struct device *dev, size_t size,
> +	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
> +{
> +	bool coherent = is_device_dma_coherent(dev);
> +	pgprot_t prot = coherent ? __pgprot(PROT_NORMAL) :
> +				   __pgprot(PROT_NORMAL_NC);
> +	struct page **pages;
> +	void *addr = NULL;
> +
> +	*handle = DMA_ERROR_CODE;
> +	size = PAGE_ALIGN(size);
> +
> +	if (!(gfp & __GFP_WAIT))
> +		return __iommu_alloc_atomic(dev, size, handle, coherent);
> +	/*
> +	 * Following is a work-around (a.k.a. hack) to prevent pages
> +	 * with __GFP_COMP being passed to split_page() which cannot
> +	 * handle them.  The real problem is that this flag probably
> +	 * should be 0 on ARM as it is not supported on this
> +	 * platform; see CONFIG_HUGETLBFS.
> +	 */
> +	gfp &= ~(__GFP_COMP);

This comment seems to have been copied from avr32 to arm to arm64 and has
the assumption that the architecture in question doesn't support hugepages.
That's not a valid assumption on LPAE ARM or arm64, so I'd like to get to
the bottom of this.

Will
