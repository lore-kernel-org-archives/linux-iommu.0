From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 2/4] iommu: Implement common IOMMU ops for DMA mapping
Date: Tue, 28 Jul 2015 17:45:27 +0100
Message-ID: <20150728164526.GA536@e104818-lin.cambridge.arm.com>
References: <cover.1437070995.git.robin.murphy@arm.com>
	<00fb13713dc8a69dc32b859f9311e70d78fb0c7a.1437070995.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <00fb13713dc8a69dc32b859f9311e70d78fb0c7a.1437070995.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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

On Thu, Jul 16, 2015 at 07:40:13PM +0100, Robin Murphy wrote:
> +/**
> + * iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
> + * @dev: Device to allocate memory for. Must be a real device
> + *	 attached to an iommu_dma_domain
> + * @size: Size of buffer in bytes
> + * @gfp: Allocation flags
> + * @prot: IOMMU mapping flags
> + * @handle: Out argument for allocated DMA handle
> + * @flush_page: Arch callback to flush a single page from all caches to
> + *		ensure DMA visibility of __GFP_ZERO. May be NULL if not
> + *		required.
> + *
> + * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
> + * but an IOMMU which supports smaller pages might not map the whole thing.
> + *
> + * Return: Array of struct page pointers describing the buffer,
> + *	   or NULL on failure.
> + */
> +struct page **iommu_dma_alloc(struct device *dev, size_t size,
> +		gfp_t gfp, int prot, dma_addr_t *handle,
> +		void (*flush_page)(const void *, phys_addr_t))
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iova_domain *iovad = domain->dma_api_cookie;
> +	struct iova *iova;
> +	struct page **pages;
> +	struct sg_table sgt;
> +	dma_addr_t dma_addr;
> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +
> +	*handle = DMA_ERROR_CODE;
> +
> +	pages = __iommu_dma_alloc_pages(count, gfp);
> +	if (!pages)
> +		return NULL;
> +
> +	iova = __alloc_iova(iovad, size, dev->coherent_dma_mask);
> +	if (!iova)
> +		goto out_free_pages;
> +
> +	size = iova_align(iovad, size);
> +	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> +		goto out_free_iova;
> +
> +	if (gfp & __GFP_ZERO) {
> +		struct sg_mapping_iter miter;
> +		/*
> +		 * The flushing provided by the SG_MITER_TO_SG flag only
> +		 * applies to highmem pages, so it won't do the job here.
> +		 */

The comment here is slightly wrong. The SG_MITER_FROM_SG flushing is
done by calling flush_kernel_dcache_page(). This function can be no-op
even on architectures implementing highmem. For example, on arm32 it
only does some flushing if there is a potential D-cache alias with user
space. The flush that you call below is for DMA operations, something
entirely different.

> +		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
> +		while (sg_miter_next(&miter)) {
> +			memset(miter.addr, 0, PAGE_SIZE);

Isn't __GFP_ZERO already honoured by alloc_pages in
__iommu_dma_alloc_pages?

> +			if (flush_page)
> +				flush_page(miter.addr, page_to_phys(miter.page));

Could you instead do the check as !(prot & IOMEM_CACHE) so that it saves
architecture code from passing NULL when coherent?

I'm still not convinced we need this flushing here but I'll follow up in
patch 3/4.

-- 
Catalin
