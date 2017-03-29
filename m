From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS mmaping
	code
Date: Wed, 29 Mar 2017 16:33:38 +0100
Message-ID: <c13f6475-f503-238f-c101-4f9cdf1b0ae2@arm.com>
References: <CGME20170329100540eucas1p22d428e33aa678cbef0a24dd249820451@eucas1p2.samsung.com>
	<1490781926-6209-1-git-send-email-a.hajda@samsung.com>
	<15b1be13-625f-db74-d213-ad1df86f7eb5@arm.com>
	<073f1feb-d6da-c93f-8e67-0910befec27b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <073f1feb-d6da-c93f-8e67-0910befec27b-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 29/03/17 16:12, Andrzej Hajda wrote:
> On 29.03.2017 14:55, Robin Murphy wrote:
>> On 29/03/17 11:05, Andrzej Hajda wrote:
>>> In case of DMA_ATTR_FORCE_CONTIGUOUS allocations vm_area->pages
>>> is invalid. __iommu_mmap_attrs and __iommu_get_sgtable cannot use
>>> it. In first case temporary pages array is passed to iommu_dma_mmap,
>>> in 2nd case single entry sg table is created directly instead
>>> of calling helper.
>>>
>>> Fixes: 44176bb ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
>>> Signed-off-by: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>> ---
>>> Hi,
>>>
>>> I am not familiar with this framework so please don't be too cruel ;)
>>> Alternative solution I see is to always create vm_area->pages,
>>> I do not know which approach is preferred.
>>>
>>> Regards
>>> Andrzej
>>> ---
>>>  arch/arm64/mm/dma-mapping.c | 40 ++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 38 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>>> index f7b5401..bba2bc8 100644
>>> --- a/arch/arm64/mm/dma-mapping.c
>>> +++ b/arch/arm64/mm/dma-mapping.c
>>> @@ -704,7 +704,30 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>>>  		return ret;
>>>  
>>>  	area = find_vm_area(cpu_addr);
>>> -	if (WARN_ON(!area || !area->pages))
>>> +	if (WARN_ON(!area))
>> >From the look of things, it doesn't seem strictly necessary to change
>> this, but whether that's a good thing is another matter. I'm not sure
>> that dma_common_contiguous_remap() should really be leaving a dangling
>> pointer in area->pages as it apparently does... :/
>>
>>> +		return -ENXIO;
>>> +
>>> +	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
>>> +		struct page *page = vmalloc_to_page(cpu_addr);
>>> +		unsigned int count = size >> PAGE_SHIFT;
>>> +		struct page **pages;
>>> +		unsigned long pfn;
>>> +		int i;
>>> +
>>> +		pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL);
>>> +		if (!pages)
>>> +			return -ENOMEM;
>>> +
>>> +		for (i = 0, pfn = page_to_pfn(page); i < count; i++)
>>> +			pages[i] = pfn_to_page(pfn + i);
>>> +
>>> +		ret = iommu_dma_mmap(pages, size, vma);
>> /**
>>  * iommu_dma_mmap - Map a buffer into provided user VMA
>>  * @pages: Array representing buffer from iommu_dma_alloc()
>>    ...
>>
>> In this case, the buffer has not come from iommu_dma_alloc(), so passing
>> into iommu_dma_mmap() is wrong by contract, even if having to fake up a
>> page array wasn't enough of a red flag. Given that a FORCE_CONTIGUOUS
>> allocation is essentially the same as for the non-IOMMU case, I think it
>> should be sufficient to defer to that path, i.e.:
>>
>> 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS)
>> 		return __swiotlb_mmap(dev, vma, cpu_addr,
>> 				phys_to_dma(virt_to_phys(cpu_addr)),
>> 				size, attrs);
> 
> Maybe I have make mistake somewhere but it does not work, here and below
> (hangs or crashes). I suppose it can be due to different address
> translations, my patch uses
>     page = vmalloc_to_page(cpu_addr).
> And here we have:
>     handle = phys_to_dma(dev, virt_to_phys(cpu_addr)); // in
> __iommu_mmap_attrs
>     page = phys_to_page(dma_to_phys(dev, handle)); // in
> __swiotlb_get_sgtable
> I guess it is similarly in __swiotlb_mmap.
> 
> Are these translations equivalent?

Ah, my mistake, sorry - I managed to forget that cpu_addr is always
remapped for FORCE_CONTIGUOUS (*and* somehow overlook the use of
vmalloc_to_page() in the patch itself), so the virt_to_phys() part of my
example is indeed bogus. The general point still stands, though.

Robin.

> 
> 
> Regards
> Andrzej
> 
>>> +		kfree(pages);
>>> +
>>> +		return ret;
>>> +	}
>>> +
>>> +	if (WARN_ON(!area->pages))
>>>  		return -ENXIO;
>>>  
>>>  	return iommu_dma_mmap(area->pages, size, vma);
>>> @@ -717,7 +740,20 @@ static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
>>>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>>  	struct vm_struct *area = find_vm_area(cpu_addr);
>>>  
>>> -	if (WARN_ON(!area || !area->pages))
>>> +	if (WARN_ON(!area))
>>> +		return -ENXIO;
>>> +
>>> +	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
>>> +		int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>>> +
>>> +		if (!ret)
>>> +			sg_set_page(sgt->sgl, vmalloc_to_page(cpu_addr),
>>> +				PAGE_ALIGN(size), 0);
>>> +
>>> +		return ret;
>>> +	}
>> As above, this may as well just go straight to the non-IOMMU version,
>> although I agree with Russell's concerns[1] that in general is is not
>> safe to assume a coherent allocation is backed by struct pages at all.
>>
>> Robin.
>>
>> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/496068.html
>>
>>> +
>>> +	if (WARN_ON(!area->pages))
>>>  		return -ENXIO;
>>>  
>>>  	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
>>>
>>
>>
>>
> 
