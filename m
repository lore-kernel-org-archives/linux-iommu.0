From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/4] iommu: Implement common IOMMU ops for DMA mapping
Date: Wed, 15 Jul 2015 16:50:08 +0100
Message-ID: <55A68130.8010306@arm.com>
References: <cover.1436552949.git.robin.murphy@arm.com>
	<d1a97aaee42f30370b58b3f7ed6a3559633010ad.1436552949.git.robin.murphy@arm.com>
	<20150714171640.GJ13555@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150714171640.GJ13555-M2fw3Uu6cmfZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Catalin,

Thanks for the review.

On 14/07/15 18:16, Catalin Marinas wrote:
> On Fri, Jul 10, 2015 at 08:19:33PM +0100, Robin Murphy wrote:
>> +/*
>> + * IOVAs are IOMMU _input_ addresses, so there still exists the possibility
>> + * for static bus translation between device output and IOMMU input (yuck).
>> + */
>> +static inline dma_addr_t dev_dma_addr(struct device *dev, dma_addr_t addr)
>> +{
>> +	dma_addr_t offset = (dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT;
>> +
>> +	BUG_ON(addr < offset);
>> +	return addr - offset;
>> +}
>
> Are these just theoretical or you expect to see some at some point? I
> think the dma_limit in __alloc_iova() may also need to take the offset
> into account (or just ignore them altogether for now).

Right now I'm not aware of any platform which has both DMA offsets and 
an IOMMU on the same bus, and I would really hope it stays that way. 
This is just extra complication out of attempting to cover every 
possibility, and you're right about the alloc_iova oversight. I'll rip 
it out for simplicity, and remain hopeful that nobody ever builds 
anything mad enough to need it put back.

>> +
>> +/**
>> + * dma_direction_to_prot - Translate DMA API directions to IOMMU API page flags
>> + * @dir: Direction of DMA transfer
>> + * @coherent: Is the DMA master cache-coherent?
>> + *
>> + * Return: corresponding IOMMU API page protection flags
>> + */
>> +int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
>> +{
>> +	int prot = coherent ? IOMMU_CACHE : 0;
>> +
>> +	switch (dir) {
>> +	case DMA_BIDIRECTIONAL:
>> +		return prot | IOMMU_READ | IOMMU_WRITE;
>> +	case DMA_TO_DEVICE:
>> +		return prot | IOMMU_READ;
>> +	case DMA_FROM_DEVICE:
>> +		return prot | IOMMU_WRITE;
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +static struct iova *__alloc_iova(struct device *dev, size_t size, bool coherent)
>> +{
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +	struct iova_domain *iovad = domain->dma_api_cookie;
>> +	unsigned long shift = iova_shift(iovad);
>> +	unsigned long length = iova_align(iovad, size) >> shift;
>> +	u64 dma_limit = coherent ? dev->coherent_dma_mask : dma_get_mask(dev);
>
> "coherent" and "coherent_dma_mask" have related meanings here. As I can
> see in patch 3, the coherent information passed all the way to this
> function states whether the device is cache coherent or not (and whether
> cache maintenance is needed). The coherent_dma_mask refers to an
> allocation mask for the dma_alloc_coherent() API but that doesn't
> necessarily mean that the device is cache coherent. Similarly, dma_mask
> is used for streaming DMA.
>
> You can rename it to coherent_api or simply pass a u64 dma_mask
> directly.

Bleh, it seems that at some point along the way I got confused and 
started mistakenly thinking the DMA masks were about the device's 
ability to issue coherent/non-coherent transactions. I'll clean up the 
mess...

> [...]
>> +/**
>> + * iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
>> + * @dev: Device to allocate memory for. Must be a real device
>> + *	 attached to an iommu_dma_domain
>> + * @size: Size of buffer in bytes
>> + * @gfp: Allocation flags
>> + * @prot: IOMMU mapping flags
>> + * @coherent: Which dma_mask to base IOVA allocation on
>> + * @handle: Out argument for allocated DMA handle
>> + * @flush_page: Arch callback to flush a single page from caches as
>> + *		necessary. May be NULL for coherent allocations
>> + *
>> + * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
>> + * but an IOMMU which supports smaller pages might not map the whole thing.
>> + * For now, the buffer is unconditionally zeroed for compatibility
>> + *
>> + * Return: Array of struct page pointers describing the buffer,
>> + *	   or NULL on failure.
>> + */
>> +struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>> +		int prot, bool coherent, dma_addr_t *handle,
>> +		void (*flush_page)(const void *, phys_addr_t))
>
> So for this function, coherent should always be true since this is only
> used with the coherent DMA API AFAICT.

Indeed.

>> +{
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +	struct iova_domain *iovad = domain->dma_api_cookie;
>> +	struct iova *iova;
>> +	struct page **pages;
>> +	struct sg_table sgt;
>> +	struct sg_mapping_iter miter;
>> +	dma_addr_t dma_addr;
>> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +
>> +	*handle = DMA_ERROR_CODE;
>> +
>> +	pages = __iommu_dma_alloc_pages(count, gfp);
>> +	if (!pages)
>> +		return NULL;
>> +
>> +	iova = __alloc_iova(dev, size, coherent);
>
> And here just __alloc_iova(dev, size, true);

In fact, everything it wanted dev for is now available at all the 
callsites, so I'll rejig the whole interface.

Robin.

> [...]
>> +dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>> +		unsigned long offset, size_t size, int prot, bool coherent)
>> +{
>> +	dma_addr_t dma_addr;
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +	struct iova_domain *iovad = domain->dma_api_cookie;
>> +	phys_addr_t phys = page_to_phys(page) + offset;
>> +	size_t iova_off = iova_offset(iovad, phys);
>> +	size_t len = iova_align(iovad, size + iova_off);
>> +	struct iova *iova = __alloc_iova(dev, len, coherent);
>
> Here __alloc_iova(dev, len, false);
>
> [...]
>> +/*
>> + * The DMA API client is passing in a scatterlist which could describe
>> + * any old buffer layout, but the IOMMU API requires everything to be
>> + * aligned to IOMMU pages. Hence the need for this complicated bit of
>> + * impedance-matching, to be able to hand off a suitably-aligned list,
>> + * but still preserve the original offsets and sizes for the caller.
>> + */
>> +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>> +		int nents, int prot, bool coherent)
>> +{
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +	struct iova_domain *iovad = domain->dma_api_cookie;
>> +	struct iova *iova;
>> +	struct scatterlist *s;
>> +	dma_addr_t dma_addr;
>> +	size_t iova_len = 0;
>> +	int i;
>> +
>> +	/*
>> +	 * Work out how much IOVA space we need, and align the segments to
>> +	 * IOVA granules for the IOMMU driver to handle. With some clever
>> +	 * trickery we can modify the list in-place, but reversibly, by
>> +	 * hiding the original data in the as-yet-unused DMA fields.
>> +	 */
>> +	for_each_sg(sg, s, nents, i) {
>> +		size_t s_offset = iova_offset(iovad, s->offset);
>> +		size_t s_length = s->length;
>> +
>> +		sg_dma_address(s) = s->offset;
>> +		sg_dma_len(s) = s_length;
>> +		s->offset -= s_offset;
>> +		s_length = iova_align(iovad, s_length + s_offset);
>> +		s->length = s_length;
>> +
>> +		iova_len += s_length;
>> +	}
>> +
>> +	iova = __alloc_iova(dev, iova_len, coherent);
>
> __alloc_iova(dev, iova_len, false);
>
