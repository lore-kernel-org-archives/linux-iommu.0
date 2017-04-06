From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: Re: [RESEND,1/3] iommu/dma: Convert to address-based allocation
Date: Thu, 6 Apr 2017 13:11:11 -0500 (CDT)
Message-ID: <alpine.DEB.2.20.1704061248560.4602@lazy>
References: <c48bc9bfcd18f1a89da02d5894323b890d97d5bb.1490971180.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c48bc9bfcd18f1a89da02d5894323b890d97d5bb.1490971180.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 31 Mar 2017, Robin Murphy wrote:

> In preparation for some IOVA allocation improvements, clean up all the
> explicit struct iova usage such that all our mapping, unmapping and
> cleanup paths deal exclusively with addresses rather than implementation
> details. In the process, a few of the things we're touching get renamed
> for the sake of internal consistency.
>
> Reviewed-by: Nate Watterson <nwatters@codeaurora.org>
> Tested-by: Nate Watterson <nwatters@codeaurora.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> drivers/iommu/dma-iommu.c | 119 ++++++++++++++++++++++++++--------------------
> 1 file changed, 67 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 85652110c8ff..8e0b684da1ba 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -365,12 +365,12 @@ int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
> 	}
> }
>
> -static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
> -		dma_addr_t dma_limit, struct device *dev)
> +static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
> +		size_t size, dma_addr_t dma_limit, struct device *dev)
> {
> 	struct iova_domain *iovad = cookie_iovad(domain);
> 	unsigned long shift = iova_shift(iovad);
> -	unsigned long length = iova_align(iovad, size) >> shift;
> +	unsigned long iova_len = size >> shift;
> 	struct iova *iova = NULL;
>
> 	if (domain->geometry.force_aperture)
> @@ -378,35 +378,42 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
>
> 	/* Try to get PCI devices a SAC address */
> 	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
> -		iova = alloc_iova(iovad, length, DMA_BIT_MASK(32) >> shift,
> +		iova = alloc_iova(iovad, iova_len, DMA_BIT_MASK(32) >> shift,
> 				  true);
> 	/*
> 	 * Enforce size-alignment to be safe - there could perhaps be an
> 	 * attribute to control this per-device, or at least per-domain...
> 	 */
> 	if (!iova)
> -		iova = alloc_iova(iovad, length, dma_limit >> shift, true);
> +		iova = alloc_iova(iovad, iova_len, dma_limit >> shift, true);
>
> -	return iova;
> +	return (dma_addr_t)iova->pfn_lo << shift;
> }
>
> -/* The IOVA allocator knows what we mapped, so just unmap whatever that was */
> -static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
> +static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
> +		dma_addr_t iova, size_t size)
> {
> -	struct iova_domain *iovad = cookie_iovad(domain);
> -	unsigned long shift = iova_shift(iovad);
> -	unsigned long pfn = dma_addr >> shift;
> -	struct iova *iova = find_iova(iovad, pfn);
> -	size_t size;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova *iova_rbnode;
>
> -	if (WARN_ON(!iova))
> +	iova_rbnode = find_iova(iovad, iova_pfn(iovad, iova));
> +	if (WARN_ON(!iova_rbnode))
> 		return;
>
> -	size = iova_size(iova) << shift;
> -	size -= iommu_unmap(domain, pfn << shift, size);
> -	/* ...and if we can't, then something is horribly, horribly wrong */
> -	WARN_ON(size > 0);
> -	__free_iova(iovad, iova);
> +	__free_iova(iovad, iova_rbnode);
> +}
> +
> +static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
> +		size_t size)
> +{
> +	struct iova_domain *iovad = cookie_iovad(domain);
> +	size_t iova_off = iova_offset(iovad, dma_addr);
> +
> +	dma_addr -= iova_off;
> +	size = iova_align(iovad, size + iova_off);
> +
> +	WARN_ON(iommu_unmap(domain, dma_addr, size) != size);
> +	iommu_dma_free_iova(domain->iova_cookie, dma_addr, size);
> }
>
> static void __iommu_dma_free_pages(struct page **pages, int count)
> @@ -488,7 +495,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
> void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
> 		dma_addr_t *handle)
> {
> -	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle);
> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle, size);
> 	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> 	*handle = DMA_ERROR_CODE;
> }
> @@ -516,11 +523,11 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> 		void (*flush_page)(struct device *, const void *, phys_addr_t))
> {
> 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct iova_domain *iovad = cookie_iovad(domain);
> -	struct iova *iova;
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> 	struct page **pages;
> 	struct sg_table sgt;
> -	dma_addr_t dma_addr;
> +	dma_addr_t iova;
> 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
>
> 	*handle = DMA_ERROR_CODE;
> @@ -540,11 +547,11 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> 	if (!pages)
> 		return NULL;
>
> -	iova = __alloc_iova(domain, size, dev->coherent_dma_mask, dev);
> +	size = iova_align(iovad, size);
> +	iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
> 	if (!iova)
> 		goto out_free_pages;
>
> -	size = iova_align(iovad, size);
> 	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> 		goto out_free_iova;
>
> @@ -560,19 +567,18 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> 		sg_miter_stop(&miter);
> 	}
>
> -	dma_addr = iova_dma_addr(iovad, iova);
> -	if (iommu_map_sg(domain, dma_addr, sgt.sgl, sgt.orig_nents, prot)
> +	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
> 			< size)
> 		goto out_free_sg;
>
> -	*handle = dma_addr;
> +	*handle = iova;
> 	sg_free_table(&sgt);
> 	return pages;
>
> out_free_sg:
> 	sg_free_table(&sgt);
> out_free_iova:
> -	__free_iova(iovad, iova);
> +	iommu_dma_free_iova(cookie, iova, size);
> out_free_pages:
> 	__iommu_dma_free_pages(pages, count);
> 	return NULL;
> @@ -606,22 +612,22 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
> static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> 		size_t size, int prot)
> {
> -	dma_addr_t dma_addr;
> 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct iova_domain *iovad = cookie_iovad(domain);
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> 	size_t iova_off = iova_offset(iovad, phys);
> -	size_t len = iova_align(iovad, size + iova_off);
> -	struct iova *iova = __alloc_iova(domain, len, dma_get_mask(dev), dev);
> +	dma_addr_t iova;
>
> +	size = iova_align(iovad, size + iova_off);
> +	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> 	if (!iova)
> 		return DMA_ERROR_CODE;
>
> -	dma_addr = iova_dma_addr(iovad, iova);
> -	if (iommu_map(domain, dma_addr, phys - iova_off, len, prot)) {
> -		__free_iova(iovad, iova);
> +	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
> +		iommu_dma_free_iova(cookie, iova, size);
> 		return DMA_ERROR_CODE;
> 	}
> -	return dma_addr + iova_off;
> +	return iova + iova_off;
> }
>
> dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> @@ -633,7 +639,7 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
> 		enum dma_data_direction dir, unsigned long attrs)
> {
> -	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle, size);
> }
>
> /*
> @@ -722,10 +728,10 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> 		int nents, int prot)
> {
> 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct iova_domain *iovad = cookie_iovad(domain);
> -	struct iova *iova;
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> 	struct scatterlist *s, *prev = NULL;
> -	dma_addr_t dma_addr;
> +	dma_addr_t iova;
> 	size_t iova_len = 0;
> 	unsigned long mask = dma_get_seg_boundary(dev);
> 	int i;
> @@ -769,7 +775,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> 		prev = s;
> 	}
>
> -	iova = __alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
> +	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
> 	if (!iova)
> 		goto out_restore_sg;
>
> @@ -777,14 +783,13 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> 	 * We'll leave any physical concatenation to the IOMMU driver's
> 	 * implementation - it knows better than we do.
> 	 */
> -	dma_addr = iova_dma_addr(iovad, iova);
> -	if (iommu_map_sg(domain, dma_addr, sg, nents, prot) < iova_len)
> +	if (iommu_map_sg(domain, iova, sg, nents, prot) < iova_len)
> 		goto out_free_iova;
>
> -	return __finalise_sg(dev, sg, nents, dma_addr);
> +	return __finalise_sg(dev, sg, nents, iova);
>
> out_free_iova:
> -	__free_iova(iovad, iova);
> +	iommu_dma_free_iova(cookie, iova, iova_len);
> out_restore_sg:
> 	__invalidate_sg(sg, nents);
> 	return 0;
> @@ -793,11 +798,21 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> 		enum dma_data_direction dir, unsigned long attrs)
> {
> +	dma_addr_t start, end;
> +	struct scatterlist *tmp;
> +	int i;
> 	/*
> 	 * The scatterlist segments are mapped into a single
> 	 * contiguous IOVA allocation, so this is incredibly easy.
> 	 */
> -	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), sg_dma_address(sg));
> +	start = sg_dma_address(sg);
> +	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
> +		if (sg_dma_len(tmp) == 0)
> +			break;
> +		sg = tmp;
> +	}
> +	end = sg_dma_address(sg) + sg_dma_len(sg);
> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), start, end - start);
> }
>
> dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> @@ -810,7 +825,7 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> 		size_t size, enum dma_data_direction dir, unsigned long attrs)
> {
> -	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle, size);
> }
>
> int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> @@ -824,7 +839,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
> 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> 	struct iommu_dma_msi_page *msi_page;
> 	struct iova_domain *iovad = cookie_iovad(domain);
> -	struct iova *iova;
> +	dma_addr_t iova;
> 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> 	size_t size = cookie_msi_granule(cookie);
>
> @@ -839,10 +854,10 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>
> 	msi_page->phys = msi_addr;
> 	if (iovad) {
> -		iova = __alloc_iova(domain, size, dma_get_mask(dev), dev);
> +		iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> 		if (!iova)
> 			goto out_free_page;
> -		msi_page->iova = iova_dma_addr(iovad, iova);
> +		msi_page->iova = iova;
> 	} else {
> 		msi_page->iova = cookie->msi_iova;
> 		cookie->msi_iova += size;
> @@ -857,7 +872,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>
> out_free_iova:
> 	if (iovad)
> -		__free_iova(iovad, iova);
> +		iommu_dma_free_iova(cookie, iova, size);
> 	else
> 		cookie->msi_iova -= size;
> out_free_page:
>

This patch series helps to resolve the Ubuntu bug, where we see the Ubuntu 
Zesty (4.10 based) kernel reporting multi cpu soft lockups on QDF2400 SDP. 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1680549

This patch series along with the following cherry-picks from Linus's tree
dddd632b072f iommu/dma: Implement PCI allocation optimisation
de84f5f049d9 iommu/dma: Stop getting dma_32bit_pfn wrong

were applied to Ubuntu Zesty 4.10 kernel (Ubuntu-4.10.0-18.20) and tested 
on a QDF2400 SDP.

Tested-by: Manoj Iyer <manoj.iyer@canonical.com>

--
============================
Manoj Iyer
Ubuntu/Canonical
ARM Servers - Cloud
============================
