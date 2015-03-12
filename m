From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
Date: Thu, 12 Mar 2015 13:50:42 +0100
Message-ID: <55018BA2.4000401@samsung.com>
References: <cover.1423226542.git.robin.murphy@arm.com>
	<058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Robin,

On 2015-02-06 15:55, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>   arch/arm64/include/asm/device.h      |   3 +
>   arch/arm64/include/asm/dma-mapping.h |  17 ++
>   arch/arm64/mm/dma-mapping.c          | 320 +++++++++++++++++++++++++++++++++++
>   3 files changed, 340 insertions(+)
>
> diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
> index 243ef25..510cee1 100644
> --- a/arch/arm64/include/asm/device.h
> +++ b/arch/arm64/include/asm/device.h
> @@ -20,6 +20,9 @@ struct dev_archdata {
>   	struct dma_map_ops *dma_ops;
>   #ifdef CONFIG_IOMMU_API
>   	void *iommu;			/* private IOMMU data */
> +#ifdef CONFIG_IOMMU_DMA
> +	struct iommu_dma_domain *dma_domain;
> +#endif
>   #endif
>   	bool dma_coherent;
>   };
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 6932bb5..c1b271f 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -62,13 +62,30 @@ static inline bool is_device_dma_coherent(struct device *dev)
>   
>   #include <asm-generic/dma-mapping-common.h>
>   
> +#ifdef CONFIG_IOMMU_DMA
> +static inline struct iommu_dma_domain *get_dma_domain(struct device *dev)
> +{
> +	return dev->archdata.dma_domain;
> +}
> +
> +static inline void set_dma_domain(struct device *dev,
> +				  struct iommu_dma_domain *dma_domain)
> +{
> +	dev->archdata.dma_domain = dma_domain;
> +}
> +#endif
> +
>   static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>   {
> +	if (WARN_ON(dev && get_dma_domain(dev)))
> +		return DMA_ERROR_CODE;
>   	return (dma_addr_t)paddr;
>   }
>   
>   static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>   {
> +	if (WARN_ON(dev && get_dma_domain(dev)))
> +		return 0;
>   	return (phys_addr_t)dev_addr;
>   }
>   
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 0a24b9b..28e771c 100644
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
> @@ -426,6 +427,7 @@ static int __init arm64_dma_init(void)
>   
>   	ret |= swiotlb_late_init();
>   	ret |= atomic_pool_init();
> +	ret |= iommu_dma_init();
>   
>   	return ret;
>   }
> @@ -439,3 +441,321 @@ static int __init dma_debug_do_init(void)
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
> +				 dma_addr_t *handle, gfp_t gfp,
> +				 struct dma_attrs *attrs)
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
> +	 * FIXME: This isn't even true any more!
> +	 *
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
> +static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
> +			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +			      struct dma_attrs *attrs)
> +{
> +	unsigned long uaddr = vma->vm_start;
> +	unsigned long usize = vma->vm_end - vma->vm_start;
> +	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
> +	int ret;
> +
> +	if (!pages)
> +		return -ENXIO;
> +
> +	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
> +					     is_device_dma_coherent(dev));
> +
> +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> +		return ret;
> +
> +	do {
> +		ret = vm_insert_page(vma, uaddr, *pages++);
> +		if (ret) {
> +			pr_err("Remapping memory failed: %d\n", ret);
> +			return ret;
> +		}
> +		uaddr += PAGE_SIZE;
> +		usize -= PAGE_SIZE;
> +	} while (usize > 0);
> +
> +	return 0;
> +}
> +
> +static void __iommu_sync_single_for_cpu(struct device *dev,
> +					dma_addr_t dev_addr, size_t size,
> +					enum dma_data_direction dir)
> +{
> +	if (!is_device_dma_coherent(dev) && (dev_addr != DMA_ERROR_CODE)) {
> +		struct iommu_dma_domain *dma_domain = get_dma_domain(dev);
> +		struct iommu_domain *domain = iommu_dma_raw_domain(dma_domain);
> +		phys_addr_t phys = iommu_iova_to_phys(domain, dev_addr);
> +
> +		__dma_unmap_area(phys_to_virt(phys), size, dir);
> +	}
> +}
> +
> +static void __iommu_sync_single_for_device(struct device *dev,
> +					   dma_addr_t dev_addr, size_t size,
> +					   enum dma_data_direction dir)
> +{
> +	if (!is_device_dma_coherent(dev) && (dev_addr != DMA_ERROR_CODE)) {
> +		struct iommu_dma_domain *dma_domain = get_dma_domain(dev);
> +		struct iommu_domain *domain = iommu_dma_raw_domain(dma_domain);
> +		phys_addr_t phys = iommu_iova_to_phys(domain, dev_addr);
> +
> +		__dma_map_area(phys_to_virt(phys), size, dir);
> +	}
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
> +
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
> +	for_each_sg(sgl, sg, nelems, i)
> +		__dma_unmap_area(sg_virt(sg), sg->length, dir);
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
> +	for_each_sg(sgl, sg, nelems, i)
> +		__dma_map_area(sg_virt(sg), sg->length, dir);
> +}
> +
> +static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
> +				int nelems, enum dma_data_direction dir,
> +				struct dma_attrs *attrs)
> +{
> +	if (is_device_dma_coherent(dev))
> +		return iommu_dma_coherent_map_sg(dev, sgl, nelems, dir, attrs);
> +
> +	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
> +
> +	return iommu_dma_map_sg(dev, sgl, nelems, dir, attrs);
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

Could you also add the following function to make the implementation 
complete?

static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
                                void *cpu_addr, dma_addr_t dma_addr,
                                size_t size, struct dma_attrs *attrs)
{
         unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
         struct page **pages = __iommu_get_pages(cpu_addr, attrs);

         if (!pages)
                 return -ENXIO;

         return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
                                          GFP_KERNEL);
}

> +static struct dma_map_ops iommu_dma_ops = {
> +	.alloc = __iommu_alloc_attrs,
> +	.free = __iommu_free_attrs,
> +	.mmap = __iommu_mmap_attrs,
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
> +};
> +
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				  const struct iommu_ops *ops)
> +{
> +	struct iommu_dma_domain *dma_domain;
> +
> +	if (!ops)
> +		return;
> +
> +	dma_domain = iommu_dma_create_domain(ops, dma_base, size);
> +	if (!dma_domain) {
> +		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> +				size, dev_name(dev));
> +		return;
> +	}
> +
> +	if (iommu_dma_attach_device(dev, dma_domain))
> +		pr_warn("Failed to attach device %s to IOMMU mapping\n",
> +				dev_name(dev));
> +	else
> +		dev->archdata.dma_ops = &iommu_dma_ops;
> +
> +	/* drop the initial mapping refcount */
> +	iommu_dma_release_domain(dma_domain);
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
