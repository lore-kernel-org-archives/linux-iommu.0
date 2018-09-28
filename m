From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Use fast DMA domain lookup
Date: Fri, 28 Sep 2018 15:26:03 +0200
Message-ID: <20180928132605eucas1p1d39fedc3be3e4e2c16035c01a40cfab6~Ykz2Rax6e0538205382eucas1p17@eucas1p1.samsung.com>
References: <cover.1536764440.git.robin.murphy@arm.com>
	<CGME20180912152438epcas5p175098b44c3f7232302e10b087279bd3c@epcas5p1.samsung.com>
	<e42771992a73620f23128c0479b2ae91b3e177bf.1536764440.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e42771992a73620f23128c0479b2ae91b3e177bf.1536764440.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, =?UTF-8?B?64yA7J246riw?= <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi All,

On 2018-09-12 17:24, Robin Murphy wrote:
> Most parts of iommu-dma already assume they are operating on a default
> domain set up by iommu_dma_init_domain(), and can be converted straight
> over to avoid the refcounting bottleneck. MSI page mappings may be in
> an unmanaged domain with an explicit MSI-only cookie, so retain the
> non-specific lookup, but that's OK since they're far from a contended
> fast path either way.
>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

This breaks Exynos DRM driver with Exynos IOMMU on ARM64 (Exynos5433).
Exynos DRM creates it's own domain, attach all devices which performs
DMA access (typically CRTC devices) to it and uses standard DMA-mapping
calls to allocate/map buffers. This way it can use the same one DMA
address for each buffer regardless of the CRTC/display/processing
device.

This no longer works with this patch. The simplest solution to fix this
is add API to change default_domain to the one allocated by the Exynos
DRM driver.

> ---
>   drivers/iommu/dma-iommu.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 511ff9a1d6d9..320f9ea82f3f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -491,7 +491,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>   void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
>   		dma_addr_t *handle)
>   {
> -	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle, size);
> +	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
>   	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
>   	*handle = IOMMU_MAPPING_ERROR;
>   }
> @@ -518,7 +518,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   		unsigned long attrs, int prot, dma_addr_t *handle,
>   		void (*flush_page)(struct device *, const void *, phys_addr_t))
>   {
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct page **pages;
> @@ -606,9 +606,8 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>   }
>   
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> -		size_t size, int prot)
> +		size_t size, int prot, struct iommu_domain *domain)
>   {
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	size_t iova_off = 0;
>   	dma_addr_t iova;
> @@ -632,13 +631,14 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>   dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   		unsigned long offset, size_t size, int prot)
>   {
> -	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot);
> +	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
> +			iommu_get_dma_domain(dev));
>   }
>   
>   void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
> -	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle, size);
> +	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
>   }
>   
>   /*
> @@ -726,7 +726,7 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
>   int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		int nents, int prot)
>   {
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct scatterlist *s, *prev = NULL;
> @@ -811,20 +811,21 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		sg = tmp;
>   	}
>   	end = sg_dma_address(sg) + sg_dma_len(sg);
> -	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), start, end - start);
> +	__iommu_dma_unmap(iommu_get_dma_domain(dev), start, end - start);
>   }
>   
>   dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	return __iommu_dma_map(dev, phys, size,
> -			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
> +			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
> +			iommu_get_dma_domain(dev));
>   }
>   
>   void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle, size);
> +	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
>   }
>   
>   int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> @@ -850,7 +851,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   	if (!msi_page)
>   		return NULL;
>   
> -	iova = __iommu_dma_map(dev, msi_addr, size, prot);
> +	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
>   	if (iommu_dma_mapping_error(dev, iova))
>   		goto out_free_page;
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
