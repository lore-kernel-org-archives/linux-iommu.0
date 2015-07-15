From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 3/4] arm64: Add IOMMU dma_ops
Date: Wed, 15 Jul 2015 10:31:29 +0100
Message-ID: <20150715093128.GA20186@e104818-lin.cambridge.arm.com>
References: <cover.1436552949.git.robin.murphy@arm.com>
	<a074dfeffc8c8168bef2668de2499f072fdcfac7.1436552949.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a074dfeffc8c8168bef2668de2499f072fdcfac7.1436552949.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 10, 2015 at 08:19:34PM +0100, Robin Murphy wrote:
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index d16a1ce..ccadfd4 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -526,3 +526,426 @@ static int __init dma_debug_do_init(void)
>  	return 0;
>  }
>  fs_initcall(dma_debug_do_init);
> +
> +
> +#ifdef CONFIG_IOMMU_DMA
> +#include <linux/dma-iommu.h>
> +#include <linux/platform_device.h>
> +#include <linux/amba/bus.h>
> +
> +/* Thankfully, all cache ops are by VA so we can ignore phys here */
> +static void flush_page(const void *virt, phys_addr_t phys)
> +{
> +	__dma_flush_range(virt, virt + PAGE_SIZE);
> +}
> +
> +static void *__iommu_alloc_attrs(struct device *dev, size_t size,
> +				 dma_addr_t *handle, gfp_t gfp,
> +				 struct dma_attrs *attrs)
> +{
> +	bool coherent = is_device_dma_coherent(dev);
> +	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
> +	void *addr;
> +
> +	if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
> +		return NULL;
> +
> +	if (gfp & __GFP_WAIT) {
> +		struct page **pages;
> +		pgprot_t pgprot = coherent ? __pgprot(PROT_NORMAL) :
> +					     __pgprot(PROT_NORMAL_NC);
> +
> +		pgprot = __get_dma_pgprot(attrs, pgprot, coherent);
> +		pages = iommu_dma_alloc(dev, size, gfp, ioprot,	coherent,
> +					handle, coherent ? NULL : flush_page);

As I replied already on the other patch, the "coherent" argument here
should always be true.

BTW, why do we need to call flush_page via iommu_dma_alloc() and not
flush the buffer directly in the arch __iommu_alloc_attrs()? We already
have the pointer and size after remapping in the CPU address space), it
would keep the iommu_dma_alloc() simpler.

> +		if (!pages)
> +			return NULL;
> +
> +		addr = dma_common_pages_remap(pages, size, VM_USERMAP, pgprot,
> +					      __builtin_return_address(0));
> +		if (!addr)
> +			iommu_dma_free(dev, pages, size, handle);
> +	} else {
> +		struct page *page;
> +		/*
> +		 * In atomic context we can't remap anything, so we'll only
> +		 * get the virtually contiguous buffer we need by way of a
> +		 * physically contiguous allocation.
> +		 */
> +		if (coherent) {
> +			page = alloc_pages(gfp, get_order(size));
> +			addr = page ? page_address(page) : NULL;

We could even use __get_free_pages(gfp & ~__GFP_HIGHMEM) since we don't
have/need highmem on arm64.

> +		} else {
> +			addr = __alloc_from_pool(size, &page, gfp);
> +		}
> +		if (addr) {
> +			*handle = iommu_dma_map_page(dev, page, 0, size,
> +						     ioprot, false);

Why coherent == false?

> +			if (iommu_dma_mapping_error(dev, *handle)) {
> +				if (coherent)
> +					__free_pages(page, get_order(size));
> +				else
> +					__free_from_pool(addr, size);
> +				addr = NULL;
> +			}
> +		}
> +	}
> +	return addr;
> +}

In the second case here (!__GFP_WAIT), do we do any cache maintenance? I
can't see it and it's needed for the !coherent case.

> +static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> +			       dma_addr_t handle, struct dma_attrs *attrs)
> +{
> +	/*
> +	 * @cpu_addr will be one of 3 things depending on how it was allocated:
> +	 * - A remapped array of pages from iommu_dma_alloc(), for all
> +	 *   non-atomic allocations.
> +	 * - A non-cacheable alias from the atomic pool, for atomic
> +	 *   allocations by non-coherent devices.
> +	 * - A normal lowmem address, for atomic allocations by
> +	 *   coherent devices.
> +	 * Hence how dodgy the below logic looks...
> +	 */
> +	if (__free_from_pool(cpu_addr, size)) {
> +		iommu_dma_unmap_page(dev, handle, size, 0, NULL);
> +	} else if (is_vmalloc_addr(cpu_addr)){
> +		struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +		if (WARN_ON(!area || !area->pages))
> +			return;
> +		iommu_dma_free(dev, area->pages, size, &handle);
> +		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
> +	} else {
> +		__free_pages(virt_to_page(cpu_addr), get_order(size));
> +		iommu_dma_unmap_page(dev, handle, size, 0, NULL);

Just slightly paranoid but it's better to unmap the page from the iommu
space before freeing (in case there is some rogue device still accessing
it).

-- 
Catalin
