From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] arm64: add IOMMU dma_ops
Date: Thu, 05 Mar 2015 15:31:57 +0100
Message-ID: <54F868DD.9040009@samsung.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
	<aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <aa7de3b1dd189c31eb8b14d0c0eea699183f8a2c.1421086706.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-01-12 21:48, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>   arch/arm64/include/asm/device.h      |   3 +
>   arch/arm64/include/asm/dma-mapping.h |  12 ++
>   arch/arm64/mm/dma-mapping.c          | 297 +++++++++++++++++++++++++++++++++++
>   3 files changed, 312 insertions(+)
>
> diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
> index 243ef25..c17f100 100644
> --- a/arch/arm64/include/asm/device.h
> +++ b/arch/arm64/include/asm/device.h
> @@ -20,6 +20,9 @@ struct dev_archdata {
>   	struct dma_map_ops *dma_ops;
>   #ifdef CONFIG_IOMMU_API
>   	void *iommu;			/* private IOMMU data */
> +#ifdef CONFIG_IOMMU_DMA
> +	struct iommu_dma_mapping *mapping;
> +#endif
>   #endif
>   	bool dma_coherent;
>   };
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 6932bb5..82082c4 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -64,11 +64,23 @@ static inline bool is_device_dma_coherent(struct device *dev)
>   
>   static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>   {
> +#ifdef CONFIG_IOMMU_DMA
> +	/* We don't have an easy way of dealing with this... */
> +	BUG_ON(dev->archdata.mapping);
> +#endif
>   	return (dma_addr_t)paddr;
>   }
>   
> +#ifdef CONFIG_IOMMU_DMA
> +phys_addr_t iova_to_phys(struct device *dev, dma_addr_t dev_addr);
> +#endif
> +
>   static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>   {
> +#ifdef CONFIG_IOMMU_DMA
> +	if (dev->archdata.mapping)
> +		return iova_to_phys(dev, dev_addr);
> +#endif
>   	return (phys_addr_t)dev_addr;
>   }
>   
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 0a24b9b..8e449a7 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -23,6 +23,7 @@
>   #include <linux/genalloc.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/dma-contiguous.h>
> +#include <linux/dma-iommu.h>
>   #include <linux/vmalloc.h>
>   #include <linux/swiotlb.h>
>   
> @@ -426,6 +427,9 @@ static int __init arm64_dma_init(void)
>   
>   	ret |= swiotlb_late_init();
>   	ret |= atomic_pool_init();
> +#ifdef CONFIG_IOMMU_DMA
> +	ret |= iommu_dma_init();
> +#endif
>   
>   	return ret;
>   }
> @@ -439,3 +443,296 @@ static int __init dma_debug_do_init(void)
>   	return 0;
>   }
>   fs_initcall(dma_debug_do_init);
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
> +
> +	pages = iommu_dma_alloc_buffer(dev, size, gfp, attrs,
> +			__dma_clear_buffer);
> +	if (!pages)
> +		return NULL;
> +
> +	*handle = iommu_dma_create_iova_mapping(dev, pages, size, coherent);
> +	if (*handle == DMA_ERROR_CODE)
> +		goto err_mapping;
> +
> +	addr = dma_common_pages_remap(pages, size, VM_USERMAP,
> +				      __get_dma_pgprot(attrs, prot, coherent),
> +				      __builtin_return_address(0));
> +	if (addr)
> +		return addr;
> +
> +	iommu_dma_release_iova_mapping(dev, *handle, size);
> +err_mapping:
> +	iommu_dma_free_buffer(dev, pages, size, attrs);
> +	return NULL;
> +}
> +
> +static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> +			       dma_addr_t handle, struct dma_attrs *attrs)
> +{
> +	struct page **pages;
> +
> +	size = PAGE_ALIGN(size);
> +	if (__in_atomic_pool(cpu_addr, size)) {
> +		__iommu_free_atomic(dev, cpu_addr, handle, size);
> +		return;
> +	}
> +
> +	pages = __iommu_get_pages(cpu_addr, attrs);
> +	if (!pages) {
> +		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
> +		return;
> +	}
> +
> +	dma_common_free_remap(cpu_addr, size, VM_USERMAP);
> +
> +	iommu_dma_release_iova_mapping(dev, handle, size);
> +	iommu_dma_free_buffer(dev, pages, size, attrs);
> +}
> +
> +static inline void *iova_to_virt(struct device *dev, dma_addr_t dev_addr)
> +{
> +	if (dev_addr == DMA_ERROR_CODE)
> +		return NULL;
> +	return phys_to_virt(iova_to_phys(dev, dev_addr));
> +}
> +
> +static void __iommu_sync_single_for_cpu(struct device *dev,
> +					dma_addr_t dev_addr, size_t size,
> +					enum dma_data_direction dir)
> +{
> +	if (!is_device_dma_coherent(dev))
> +		__dma_unmap_area(iova_to_virt(dev, dev_addr), size, dir);
> +}
> +
> +static void __iommu_sync_single_for_device(struct device *dev,
> +					   dma_addr_t dev_addr, size_t size,
> +					   enum dma_data_direction dir)
> +{
> +	if (!is_device_dma_coherent(dev))
> +		__dma_map_area(iova_to_virt(dev, dev_addr), size, dir);
> +}
> +
> +static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
> +				   unsigned long offset, size_t size,
> +				   enum dma_data_direction dir,
> +				   struct dma_attrs *attrs)
> +{
> +	dma_addr_t dev_addr;
> +
> +	if (is_device_dma_coherent(dev))
> +		return iommu_dma_coherent_map_page(dev, page, offset, size,
> +				dir, attrs);
> +
> +	dev_addr = iommu_dma_map_page(dev, page, offset, size, dir, attrs);
> +	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +		__iommu_sync_single_for_device(dev, dev_addr, size, dir);
> +
> +	return dev_addr;
> +}
> +
> +static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
> +			       size_t size, enum dma_data_direction dir,
> +			       struct dma_attrs *attrs)
> +{
> +	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
> +
> +	iommu_dma_unmap_page(dev, dev_addr, size, dir, attrs);
> +}
> +
> +static void __iommu_sync_sg_for_cpu(struct device *dev,
> +				    struct scatterlist *sgl, int nelems,
> +				    enum dma_data_direction dir)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	if (is_device_dma_coherent(dev))
> +		return;
> +
> +	for_each_sg(sgl, sg, nelems, i) {
> +		unsigned int len = sg_dma_len(sg);
> +		void *virt = iova_to_virt(dev, sg_dma_address(sg));
> +
> +		if (virt && len)
> +			__dma_unmap_area(virt, len, dir);
> +	}

The above loop is not correct. You should iterate over memory page 
chunks not the
dma address chunks. There is no guarantee that single dma chunk matches 
respective
chunk in memory. The following version is correct:

for_each_sg(sgl, sg, nelems, i) {
       void *virt = phys_to_virt(page_to_phys(sg_page(sg))) + sg->offset;
       __dma_unmap_area(virt, sg->length, dir);
}

> +}
> +
> +static void __iommu_sync_sg_for_device(struct device *dev,
> +				       struct scatterlist *sgl, int nelems,
> +				       enum dma_data_direction dir)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	if (is_device_dma_coherent(dev))
> +		return;
> +
> +	for_each_sg(sgl, sg, nelems, i) {
> +		unsigned int len = sg_dma_len(sg);
> +		void *virt = iova_to_virt(dev, sg_dma_address(sg));
> +
> +		if (virt && len)
> +			__dma_map_area(virt, len, dir);
> +	}

Same as for __iommu_sync_sg_for_cpu().

> +}
> +
> +static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
> +				int nelems, enum dma_data_direction dir,
> +				struct dma_attrs *attrs)
> +{
> +	int count;
> +
> +	if (is_device_dma_coherent(dev))
> +		return iommu_dma_coherent_map_sg(dev, sgl, nelems, dir, attrs);
> +
> +	count = iommu_dma_map_sg(dev, sgl, nelems, dir, attrs);
> +	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +		__iommu_sync_sg_for_device(dev, sgl, count, dir);
> +
> +	return count;
> +}
> +
> +static void __iommu_unmap_sg_attrs(struct device *dev,
> +				   struct scatterlist *sgl, int nelems,
> +				   enum dma_data_direction dir,
> +				   struct dma_attrs *attrs)
> +{
> +	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
> +
> +	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
> +}
> +
> +static struct dma_map_ops iommu_dma_ops = {
> +	.alloc = __iommu_alloc_attrs,
> +	.free = __iommu_free_attrs,
> +	.mmap = __swiotlb_mmap,

This one is definitely not correct and it will cause kernel ops/bus 
error. Please
refer to arch/arm iommu_mmap() implementation.

> +	.map_page = __iommu_map_page,
> +	.unmap_page = __iommu_unmap_page,
> +	.map_sg = __iommu_map_sg_attrs,
> +	.unmap_sg = __iommu_unmap_sg_attrs,
> +	.sync_single_for_cpu = __iommu_sync_single_for_cpu,
> +	.sync_single_for_device = __iommu_sync_single_for_device,
> +	.sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
> +	.sync_sg_for_device = __iommu_sync_sg_for_device,
> +	.dma_supported = iommu_dma_supported,
> +	.mapping_error = iommu_dma_mapping_error,

.get_sgtable is missing and it is definitely needed for the iommu based 
implementation.

> +};
> +
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				  struct iommu_ops *ops)
> +{
> +	struct iommu_dma_mapping *mapping;
> +
> +	if (!ops)
> +		return;
> +
> +	mapping = iommu_dma_create_mapping(ops, dma_base, size);
> +	if (!mapping) {
> +		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> +				size, dev_name(dev));
> +		return;
> +	}
> +
> +	if (iommu_dma_attach_device(dev, mapping))
> +		pr_warn("Failed to attach device %s to IOMMU mapping\n",
> +				dev_name(dev));
> +	else
> +		dev->archdata.dma_ops = &iommu_dma_ops;
> +
> +	/* drop the initial mapping refcount */
> +	iommu_dma_release_mapping(mapping);
> +}
> +
> +#else
> +
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				  struct iommu_ops *iommu)
> +{ }
> +
> +#endif  /* CONFIG_IOMMU_DMA */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
