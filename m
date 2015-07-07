From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 2/4] iommu: Implement common IOMMU ops for DMA mapping
Date: Tue, 7 Jul 2015 15:37:58 +0800
Message-ID: <1436254678.18552.7.camel@mhfsdcap03>
References: <cover.1434036796.git.robin.murphy@arm.com>
	<bf63d80c36533aa4dcc401b5a4b312ba00237e1c.1434036796.git.robin.murphy@arm.com>
	<1435915649.21346.11.camel@mhfsdcap03> <5596BBD3.1040708@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5596BBD3.1040708-5wv7dgnIgG8@public.gmane.org>
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
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-07-03 at 17:44 +0100, Robin Murphy wrote:
> On 03/07/15 10:27, Yong Wu wrote:
> [...]
> >> +/**
> >> + * iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
> >> + * @dev: Device to allocate memory for. Must be a real device
> >> + *	 attached to an iommu_dma_domain
> >> + * @size: Size of buffer in bytes
> >> + * @gfp: Allocation flags
> >> + * @prot: IOMMU mapping flags
> >> + * @coherent: Which dma_mask to base IOVA allocation on
> >> + * @handle: Out argument for allocated DMA handle
> >> + * @flush_page: Arch callback to flush a single page from caches as
> >> + *		necessary. May be NULL for coherent allocations
> >> + *
> >> + * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
> >> + * but an IOMMU which supports smaller pages might not map the whole thing.
> >> + * For now, the buffer is unconditionally zeroed for compatibility
> >> + *
> >> + * Return: Array of struct page pointers describing the buffer,
> >> + *	   or NULL on failure.
> >> + */
> >> +struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >> +		int prot, bool coherent, dma_addr_t *handle,
> >> +		void (*flush_page)(const void *, phys_addr_t))
> >> +{
> >> +	struct iommu_dma_domain *dom = arch_get_dma_domain(dev);
> >> +	struct iova_domain *iovad = dom->iovad;
> >> +	struct iova *iova;
> >> +	struct page **pages;
> >> +	struct sg_table sgt;
> >> +	struct sg_mapping_iter miter;
> >> +	dma_addr_t dma_addr;
> >> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >> +
> >> +	*handle = DMA_ERROR_CODE;
> >
> > Hi Robin,
> >
> >    Compare with the dma before, You delete this line here.
> >
> >            size = PAGE_ALIGN(size);
> >
> >    Do you expect the user should make sure the size must be aligned?
> >
> >    so do __iommu_free_attrs.
> 
> Yeah, there is an oversight here due to some back-and-forth refactoring 
> - both the page allocation and the IOVA allocation do get suitably 
> aligned as they should, but the segments of the temporary scatterlist 
> don't. Somehow I managed not to hit an iommu_map_sg failure due to that 
> until some time after this posting (it seems most of the drivers I test 
> with only make page-sized allocations...)
> 
> I've currently got the fixup below waiting for the next posting.
> 
> Robin.

Hi Robin,
    Could we know the status and ETA of the DMA next version.
    We are preparing the mtk-iommu next patch as our project request.
    We could help test it if you send the new patch.
    Thanks.

> 
> >> +
> >> +	/* IOMMU can map any pages, so himem can also be used here */
> >> +	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
> >> +	pages = __iommu_dma_alloc_pages(count, gfp);
> >> +	if (!pages)
> >> +		return NULL;
> >> +
> >> +	iova = __alloc_iova(dev, size, coherent);
> >> +	if (!iova)
> >> +		goto out_free_pages;
> >> +
> 
> +	size = iova_align(iovad, size);
> 
> >> +	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> >> +		goto out_free_iova;
> >> +
> >> +	dma_addr = iova_dma_addr(iovad, iova);
> >> +	if (iommu_map_sg(dom->domain, dma_addr, sgt.sgl, sgt.orig_nents, prot)
> >> +			< size)
> >> +		goto out_free_sg;
> >> +
> >> +	/* Using the non-flushing flag since we're doing our own */
> >> +	sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
> >> +	while (sg_miter_next(&miter)) {
> >> +		memset(miter.addr, 0, PAGE_SIZE);
> >> +		if (flush_page)
> >> +			flush_page(miter.addr, page_to_phys(miter.page));
> >> +	}
> >> +	sg_miter_stop(&miter);
> >> +	sg_free_table(&sgt);
> >> +
> >> +	*handle = dma_addr;
> >> +	return pages;
> >> +
> >> +out_free_sg:
> >> +	sg_free_table(&sgt);
> >> +out_free_iova:
> >> +	__free_iova(iovad, iova);
> >> +out_free_pages:
> >> +	__iommu_dma_free_pages(pages, count);
> >> +	return NULL;
> >> +}
> >> +
> > [...]
> >> +
> >> +#endif	/* __KERNEL__ */
> >> +#endif	/* __DMA_IOMMU_H */
> >
> >
> 
