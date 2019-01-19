From: Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] arm64/xen: fix xen-swiotlb cache flushing
Date: Fri, 18 Jan 2019 16:44:23 -0800 (PST)
Message-ID: <alpine.DEB.2.10.1901181612150.18561@sstabellini-ThinkPad-X260>
References: <20190117171842.26173-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190117171842.26173-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: jgross-IBi9RG/b67k@public.gmane.org, sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 17 Jan 2019, Christoph Hellwig wrote:
> Xen-swiotlb hooks into the arm/arm64 arch code through a copy of the
> DMA mapping operations stored in the struct device arch data.
> 
> Switching arm64 to use the direct calls for the merged DMA direct /
> swiotlb code broke this scheme.  Replace the indirect calls with
> direct-calls in xen-swiotlb as well to fix this problem.
> 
> Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")
> Reported-by: Julien Grall <julien.grall-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/arm/include/asm/xen/page-coherent.h   | 94 +++++++++++++++++++++
>  arch/arm64/include/asm/device.h            |  3 -
>  arch/arm64/include/asm/xen/page-coherent.h | 76 +++++++++++++++++
>  arch/arm64/mm/dma-mapping.c                |  4 +-
>  drivers/xen/swiotlb-xen.c                  |  4 +-
>  include/xen/arm/page-coherent.h            | 97 +---------------------
>  6 files changed, 176 insertions(+), 102 deletions(-)
> 
> diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
> index b3ef061d8b74..2c403e7c782d 100644
> --- a/arch/arm/include/asm/xen/page-coherent.h
> +++ b/arch/arm/include/asm/xen/page-coherent.h
> @@ -1 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM_XEN_PAGE_COHERENT_H
> +#define _ASM_ARM_XEN_PAGE_COHERENT_H
> +
> +#include <linux/dma-mapping.h>
> +#include <asm/page.h>
>  #include <xen/arm/page-coherent.h>
> +
> +static inline const struct dma_map_ops *xen_get_dma_ops(struct device *dev)
> +{
> +	if (dev && dev->archdata.dev_dma_ops)
> +		return dev->archdata.dev_dma_ops;
> +	return get_arch_dma_ops(NULL);
> +}
> +
> +static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
> +{
> +	return xen_get_dma_ops(hwdev)->alloc(hwdev, size, dma_handle, flags, attrs);
> +}
> +
> +static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
> +		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
> +{
> +	xen_get_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
> +}
> +
> +static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> +	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> +	     enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long page_pfn = page_to_xen_pfn(page);
> +	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> +	unsigned long compound_pages =
> +		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> +	bool local = (page_pfn <= dev_pfn) &&
> +		(dev_pfn - page_pfn < compound_pages);
> +
> +	/*
> +	 * Dom0 is mapped 1:1, while the Linux page can span across
> +	 * multiple Xen pages, it's not possible for it to contain a
> +	 * mix of local and foreign Xen pages. So if the first xen_pfn
> +	 * == mfn the page is local otherwise it's a foreign page
> +	 * grant-mapped in dom0. If the page is local we can safely
> +	 * call the native dma_ops function, otherwise we call the xen
> +	 * specific function.
> +	 */
> +	if (local)
> +		xen_get_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
> +	else
> +		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> +}
> +
> +static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	/*
> +	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
> +	 * multiple Xen page, it's not possible to have a mix of local and
> +	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
> +	 * foreign mfn will always return false. If the page is local we can
> +	 * safely call the native dma_ops function, otherwise we call the xen
> +	 * specific function.
> +	 */
> +	if (pfn_valid(pfn)) {
> +		if (xen_get_dma_ops(hwdev)->unmap_page)
> +			xen_get_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
> +	} else
> +		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
> +}
> +
> +static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	if (pfn_valid(pfn)) {
> +		if (xen_get_dma_ops(hwdev)->sync_single_for_cpu)
> +			xen_get_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
> +	} else
> +		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
> +}
> +
> +static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	if (pfn_valid(pfn)) {
> +		if (xen_get_dma_ops(hwdev)->sync_single_for_device)
> +			xen_get_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
> +	} else
> +		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
> +}
> +
> +#endif /* _ASM_ARM_XEN_PAGE_COHERENT_H */
> diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
> index 3dd3d664c5c5..4658c937e173 100644
> --- a/arch/arm64/include/asm/device.h
> +++ b/arch/arm64/include/asm/device.h
> @@ -20,9 +20,6 @@ struct dev_archdata {
>  #ifdef CONFIG_IOMMU_API
>  	void *iommu;			/* private IOMMU data */
>  #endif
> -#ifdef CONFIG_XEN
> -	const struct dma_map_ops *dev_dma_ops;
> -#endif
>  };
>  
>  struct pdev_archdata {
> diff --git a/arch/arm64/include/asm/xen/page-coherent.h b/arch/arm64/include/asm/xen/page-coherent.h
> index b3ef061d8b74..77e36decc50c 100644
> --- a/arch/arm64/include/asm/xen/page-coherent.h
> +++ b/arch/arm64/include/asm/xen/page-coherent.h
> @@ -1 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_XEN_PAGE_COHERENT_H
> +#define _ASM_ARM64_XEN_PAGE_COHERENT_H
> +
> +#include <linux/dma-mapping.h>
> +#include <asm/page.h>
>  #include <xen/arm/page-coherent.h>
> +
> +static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
> +{
> +	return dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
> +}
> +
> +static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
> +		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
> +{
> +	dma_direct_free(hwdev, size, cpu_addr, dma_handle, attrs);
> +}
> +
> +static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +
> +	if (pfn_valid(pfn))
> +		dma_direct_sync_single_for_cpu(hwdev, handle, size, dir);
> +	else
> +		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
> +}
> +
> +static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	if (pfn_valid(pfn))
> +		dma_direct_sync_single_for_device(hwdev, handle, size, dir);
> +	else
> +		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
> +}
> +
> +static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> +	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> +	     enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long page_pfn = page_to_xen_pfn(page);
> +	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> +	unsigned long compound_pages =
> +		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> +	bool local = (page_pfn <= dev_pfn) &&
> +		(dev_pfn - page_pfn < compound_pages);
> +
> +	if (pfn_valid(pfn))
> +		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
> +	else
> +		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> +}
> +
> +static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	/*
> +	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
> +	 * multiple Xen page, it's not possible to have a mix of local and
> +	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
> +	 * foreign mfn will always return false. If the page is local we can
> +	 * safely call the native dma_ops function, otherwise we call the xen
> +	 * specific function.
> +	 */
> +	if (pfn_valid(pfn))
> +		dma_direct_unmap_page(hwdev, handle, size, dir, attrs);
> +	else
> +		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
> +}
> +
> +#endif /* _ASM_ARM64_XEN_PAGE_COHERENT_H */
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index fb0908456a1f..78c0a72f822c 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -466,9 +466,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
>  
>  #ifdef CONFIG_XEN
> -	if (xen_initial_domain()) {
> -		dev->archdata.dev_dma_ops = dev->dma_ops;
> +	if (xen_initial_domain())
>  		dev->dma_ops = xen_dma_ops;
> -	}
>  #endif
>  }

This is an optional suggestion, but it would be nice to add a check on
dev->dma_ops being unset here, something like:

  #ifdef CONFIG_XEN
  if (xen_initial_domain()) {
      if (dev->dma_ops != NULL)
          warning/error
      dev->dma_ops = xen_dma_ops;
  }

Does it make sense?

In any case:

Reviewed-by: Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>


> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 989cf872b98c..bb7888429be6 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -645,7 +645,7 @@ xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>  		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		     unsigned long attrs)
>  {
> -#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +#ifdef CONFIG_ARM
>  	if (xen_get_dma_ops(dev)->mmap)
>  		return xen_get_dma_ops(dev)->mmap(dev, vma, cpu_addr,
>  						    dma_addr, size, attrs);
> @@ -662,7 +662,7 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
>  			void *cpu_addr, dma_addr_t handle, size_t size,
>  			unsigned long attrs)
>  {
> -#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +#ifdef CONFIG_ARM
>  	if (xen_get_dma_ops(dev)->get_sgtable) {
>  #if 0
>  	/*
> diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
> index 59a260712a56..2ca9164a79bf 100644
> --- a/include/xen/arm/page-coherent.h
> +++ b/include/xen/arm/page-coherent.h
> @@ -1,17 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_ARM_XEN_PAGE_COHERENT_H
> -#define _ASM_ARM_XEN_PAGE_COHERENT_H
> -
> -#include <asm/page.h>
> -#include <asm/dma-mapping.h>
> -#include <linux/dma-mapping.h>
> -
> -static inline const struct dma_map_ops *xen_get_dma_ops(struct device *dev)
> -{
> -	if (dev && dev->archdata.dev_dma_ops)
> -		return dev->archdata.dev_dma_ops;
> -	return get_arch_dma_ops(NULL);
> -}
> +#ifndef _XEN_ARM_PAGE_COHERENT_H
> +#define _XEN_ARM_PAGE_COHERENT_H
>  
>  void __xen_dma_map_page(struct device *hwdev, struct page *page,
>  	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> @@ -21,87 +10,7 @@ void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
>  		unsigned long attrs);
>  void __xen_dma_sync_single_for_cpu(struct device *hwdev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir);
> -
>  void __xen_dma_sync_single_for_device(struct device *hwdev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir);
>  
> -static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
> -{
> -	return xen_get_dma_ops(hwdev)->alloc(hwdev, size, dma_handle, flags, attrs);
> -}
> -
> -static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
> -		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	xen_get_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
> -}
> -
> -static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> -	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> -	     enum dma_data_direction dir, unsigned long attrs)
> -{
> -	unsigned long page_pfn = page_to_xen_pfn(page);
> -	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> -	unsigned long compound_pages =
> -		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> -	bool local = (page_pfn <= dev_pfn) &&
> -		(dev_pfn - page_pfn < compound_pages);
> -
> -	/*
> -	 * Dom0 is mapped 1:1, while the Linux page can span across
> -	 * multiple Xen pages, it's not possible for it to contain a
> -	 * mix of local and foreign Xen pages. So if the first xen_pfn
> -	 * == mfn the page is local otherwise it's a foreign page
> -	 * grant-mapped in dom0. If the page is local we can safely
> -	 * call the native dma_ops function, otherwise we call the xen
> -	 * specific function.
> -	 */
> -	if (local)
> -		xen_get_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
> -	else
> -		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> -}
> -
> -static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -	/*
> -	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
> -	 * multiple Xen page, it's not possible to have a mix of local and
> -	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
> -	 * foreign mfn will always return false. If the page is local we can
> -	 * safely call the native dma_ops function, otherwise we call the xen
> -	 * specific function.
> -	 */
> -	if (pfn_valid(pfn)) {
> -		if (xen_get_dma_ops(hwdev)->unmap_page)
> -			xen_get_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
> -	} else
> -		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
> -}
> -
> -static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -	if (pfn_valid(pfn)) {
> -		if (xen_get_dma_ops(hwdev)->sync_single_for_cpu)
> -			xen_get_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
> -	} else
> -		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
> -}
> -
> -static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -	if (pfn_valid(pfn)) {
> -		if (xen_get_dma_ops(hwdev)->sync_single_for_device)
> -			xen_get_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
> -	} else
> -		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
> -}
> -
> -#endif /* _ASM_ARM_XEN_PAGE_COHERENT_H */
> +#endif /* _XEN_ARM_PAGE_COHERENT_H */
> -- 
> 2.20.1
> 
