From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
Date: Tue, 10 Feb 2015 15:40:22 +0000
Message-ID: <54DA2666.9030003@arm.com>
References: <cover.1423226542.git.robin.murphy@arm.com>
	<058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>
	<20150209060224.GG13969@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150209060224.GG13969-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/02/15 06:02, Will Deacon wrote:
> On Fri, Feb 06, 2015 at 02:55:14PM +0000, Robin Murphy wrote:
>> Taking some inspiration from the arch/arm code, implement the
>> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>
> Is anybody looking at porting arch/arm/ over to this?

If not, future me from once-there-are-no-more-major-changes-to-patch-1 
will be.

>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   arch/arm64/include/asm/device.h      |   3 +
>>   arch/arm64/include/asm/dma-mapping.h |  17 ++
>>   arch/arm64/mm/dma-mapping.c          | 320 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 340 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
>> index 243ef25..510cee1 100644
>> --- a/arch/arm64/include/asm/device.h
>> +++ b/arch/arm64/include/asm/device.h
>> @@ -20,6 +20,9 @@ struct dev_archdata {
>>   	struct dma_map_ops *dma_ops;
>>   #ifdef CONFIG_IOMMU_API
>>   	void *iommu;			/* private IOMMU data */
>> +#ifdef CONFIG_IOMMU_DMA
>> +	struct iommu_dma_domain *dma_domain;
>> +#endif
>>   #endif
>>   	bool dma_coherent;
>>   };
>> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
>> index 6932bb5..c1b271f 100644
>> --- a/arch/arm64/include/asm/dma-mapping.h
>> +++ b/arch/arm64/include/asm/dma-mapping.h
>> @@ -62,13 +62,30 @@ static inline bool is_device_dma_coherent(struct device *dev)
>>
>>   #include <asm-generic/dma-mapping-common.h>
>>
>> +#ifdef CONFIG_IOMMU_DMA
>> +static inline struct iommu_dma_domain *get_dma_domain(struct device *dev)
>> +{
>> +	return dev->archdata.dma_domain;
>> +}
>
> You use this function in patch 1, so you probably need to reorder the series
> slightly.

Good point. I need to introduce the dummy stubs unconditionally first, 
then configure them out here.

>> +static inline void set_dma_domain(struct device *dev,
>> +				  struct iommu_dma_domain *dma_domain)
>> +{
>> +	dev->archdata.dma_domain = dma_domain;
>> +}
>> +#endif
>> +
>>   static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>>   {
>> +	if (WARN_ON(dev && get_dma_domain(dev)))
>> +		return DMA_ERROR_CODE;
>>   	return (dma_addr_t)paddr;
>>   }
>>
>>   static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>>   {
>> +	if (WARN_ON(dev && get_dma_domain(dev)))
>> +		return 0;
>>   	return (phys_addr_t)dev_addr;
>>   }
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index 0a24b9b..28e771c 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/genalloc.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/dma-contiguous.h>
>> +#include <linux/dma-iommu.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/swiotlb.h>
>>
>> @@ -426,6 +427,7 @@ static int __init arm64_dma_init(void)
>>
>>   	ret |= swiotlb_late_init();
>>   	ret |= atomic_pool_init();
>> +	ret |= iommu_dma_init();
>>
>>   	return ret;
>>   }
>> @@ -439,3 +441,321 @@ static int __init dma_debug_do_init(void)
>>   	return 0;
>>   }
>>   fs_initcall(dma_debug_do_init);
>> +
>> +
>> +#ifdef CONFIG_IOMMU_DMA
>> +
>> +static struct page **__atomic_get_pages(void *addr)
>> +{
>> +	struct page *page;
>> +	phys_addr_t phys;
>> +
>> +	phys = gen_pool_virt_to_phys(atomic_pool, (unsigned long)addr);
>> +	page = phys_to_page(phys);
>> +
>> +	return (struct page **)page;
>> +}
>> +
>> +static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
>> +{
>> +	struct vm_struct *area;
>> +
>> +	if (__in_atomic_pool(cpu_addr, PAGE_SIZE))
>> +		return __atomic_get_pages(cpu_addr);
>> +
>> +	area = find_vm_area(cpu_addr);
>> +	if (!area)
>> +		return NULL;
>> +
>> +	return area->pages;
>> +}
>> +
>> +static void *__iommu_alloc_atomic(struct device *dev, size_t size,
>> +				  dma_addr_t *handle, bool coherent)
>> +{
>> +	struct page *page;
>> +	void *addr;
>> +
>> +	addr = __alloc_from_pool(size, &page);
>> +	if (!addr)
>> +		return NULL;
>> +
>> +	*handle = iommu_dma_create_iova_mapping(dev, &page, size, coherent);
>> +	if (*handle == DMA_ERROR_CODE) {
>> +		__free_from_pool(addr, size);
>> +		return NULL;
>> +	}
>> +	return addr;
>> +}
>> +
>> +static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
>> +				dma_addr_t handle, size_t size)
>> +{
>> +	iommu_dma_release_iova_mapping(dev, handle, size);
>> +	__free_from_pool(cpu_addr, size);
>> +}
>
> Up until this point, I don't get why things need to be arch-specific. Surely
> we should only care about cache and MMU management in the arch code?

I agree, but the atomic pool implementation being private got in the 
way. However, the idea of replacing the _get_pages() stuff with 
scatterlists makes me think I can clean this up too.

>> +static void __dma_clear_buffer(struct page *page, size_t size)
>> +{
>> +	void *ptr = page_address(page);
>> +
>> +	memset(ptr, 0, size);
>> +	__dma_flush_range(ptr, ptr + size);
>> +}
>> +
>> +static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>> +				 dma_addr_t *handle, gfp_t gfp,
>> +				 struct dma_attrs *attrs)
>> +{
>> +	bool coherent = is_device_dma_coherent(dev);
>> +	pgprot_t prot = coherent ? __pgprot(PROT_NORMAL) :
>> +				   __pgprot(PROT_NORMAL_NC);
>> +	struct page **pages;
>> +	void *addr = NULL;
>> +
>> +	*handle = DMA_ERROR_CODE;
>> +	size = PAGE_ALIGN(size);
>> +
>> +	if (!(gfp & __GFP_WAIT))
>> +		return __iommu_alloc_atomic(dev, size, handle, coherent);
>> +	/*
>> +	 * FIXME: This isn't even true any more!
>> +	 *
>> +	 * Following is a work-around (a.k.a. hack) to prevent pages
>> +	 * with __GFP_COMP being passed to split_page() which cannot
>> +	 * handle them.  The real problem is that this flag probably
>> +	 * should be 0 on ARM as it is not supported on this
>> +	 * platform; see CONFIG_HUGETLBFS.
>> +	 */
>> +	gfp &= ~(__GFP_COMP);
>
> We should fix this... is it not just a case of calling split_huge_page
> for compond pages?

I've been reading up on the matter and so far I'd concur, but I'm 
starting to wonder if we really need to do half of this at all. AFAICT 
the only real reason for splitting pages is so the mmap() implementation 
can use vm_insert_page() - if that was changed to use remap_pfn_range() 
instead would the need go away entirely? (SWIOTLB doesn't seem to worry 
about any of this stuff)

Robin.
