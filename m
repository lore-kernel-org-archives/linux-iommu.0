From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 1/3] iommu: Implement common IOMMU ops for DMA mapping
Date: Fri, 07 Aug 2015 14:38:39 +0100
Message-ID: <55C4B4DF.4040608@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
	<6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
	<20150807084228.GU14980@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150807084228.GU14980-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Thanks for taking a look,

On 07/08/15 09:42, Joerg Roedel wrote:
> On Fri, Jul 31, 2015 at 06:18:27PM +0100, Robin Murphy wrote:
>> +int iommu_get_dma_cookie(struct iommu_domain *domain)
>> +{
>> +	struct iova_domain *iovad;
>> +
>> +	if (domain->dma_api_cookie)
>> +		return -EEXIST;
>
> Why do you call that dma_api_cookie? It is just a pointer to an iova
> allocator, you can just name it as such, like domain->iova.

Sure, it was more the case that since it had to be in the top-level 
generic domain structure, I didn't want it to be too 
implementation-specific. I figured this was a reasonable compromise that 
wouldn't be a waste of space for implementations with different 
per-domain DMA API data - e.g. the AMD IOMMU driver could then make use 
of protection_domain->domain->dma_api_cookie instead of having 
protection_domain->priv, but that's a patch that wouldn't belong in this 
series anyway.

If you really hate that idea, then yeah, let's just call it iova and 
consider if factoring out redundancy is still applicable later.

>> +static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
>> +		dma_addr_t dma_limit)
>
> I think you also need a struct device here to take segment boundary and
> dma_mask into account.

To the best of my understanding, those limits are only relevant when 
actually handing off a scatterlist to a client device doing hardware 
scatter-gather operations, so it's not so much the IOVA allocation that 
matters, but where the segments lie within it when handling dma_map_sg.

However, you do raise a good point - in the current "map everything 
consecutively" approach, if there is a non-power-of-2-sized segment in 
the middle of a scatterlist, then subsequent segments could possibly end 
up inadvertently straddling a boundary. That needs handling in 
iommu_dma_map_sg; I'll fix it appropriately.

>> +/* The IOVA allocator knows what we mapped, so just unmap whatever that was */
>> +static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
>> +{
>> +	struct iova_domain *iovad = domain->dma_api_cookie;
>> +	unsigned long shift = iova_shift(iovad);
>> +	unsigned long pfn = dma_addr >> shift;
>> +	struct iova *iova = find_iova(iovad, pfn);
>> +	size_t size = iova_size(iova) << shift;
>> +
>> +	/* ...and if we can't, then something is horribly, horribly wrong */
>> +	BUG_ON(iommu_unmap(domain, pfn << shift, size) < size);
>
> This is a WARN_ON at most, not a BUG_ON condition, especially since this
> type of bug is also catched with the dma-api debugging code.

Indeed, DMA_DEBUG will check that a driver is making DMA API calls to 
the arch code in the right way; this is a different check, to catch 
things like the arch code passing the wrong domain into this layer, or 
someone else having messed directly with the domain via the IOMMU API. 
If the iommu_unmap doesn't match the IOVA region we looked up, that 
means the IOMMU page tables have somehow become inconsistent with the 
IOVA allocator, so we are in an unrecoverable situation where we can no 
longer be sure what devices have access to. That's bad.

>> +static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
>> +{
>> +	struct page **pages;
>> +	unsigned int i = 0, array_size = count * sizeof(*pages);
>> +
>> +	if (array_size <= PAGE_SIZE)
>> +		pages = kzalloc(array_size, GFP_KERNEL);
>> +	else
>> +		pages = vzalloc(array_size);
>> +	if (!pages)
>> +		return NULL;
>> +
>> +	/* IOMMU can map any pages, so himem can also be used here */
>> +	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>> +
>> +	while (count) {
>> +		struct page *page = NULL;
>> +		int j, order = __fls(count);
>> +
>> +		/*
>> +		 * Higher-order allocations are a convenience rather
>> +		 * than a necessity, hence using __GFP_NORETRY until
>> +		 * falling back to single-page allocations.
>> +		 */
>> +		for (order = min(order, MAX_ORDER); order > 0; order--) {
>> +			page = alloc_pages(gfp | __GFP_NORETRY, order);
>> +			if (!page)
>> +				continue;
>> +			if (PageCompound(page)) {
>> +				if (!split_huge_page(page))
>> +					break;
>> +				__free_pages(page, order);
>> +			} else {
>> +				split_page(page, order);
>> +				break;
>> +			}
>> +		}
>> +		if (!page)
>> +			page = alloc_page(gfp);
>> +		if (!page) {
>> +			__iommu_dma_free_pages(pages, i);
>> +			return NULL;
>> +		}
>> +		j = 1 << order;
>> +		count -= j;
>> +		while (j--)
>> +			pages[i++] = page++;
>> +	}
>> +	return pages;
>> +}
>
> Hmm, most dma-api implementation just try to allocate a big enough
> region from the page-alloctor. Is it implemented different here to avoid
> the use of CMA?

AFAIK, yes (this is just a slight tidyup of the existing code that 
32-bit Exynos/Tegra/Rockchip/etc. devices are already using) - the 
display guys want increasingly massive contiguous allocations for 
framebuffers, layers, etc., so having IOMMU magic deal with that saves 
CMA for non-IOMMU devices that really need it.

Robin.
