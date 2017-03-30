From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS mmaping
	code
Date: Thu, 30 Mar 2017 11:44:00 +0100
Message-ID: <41097b2c-9bbc-31e4-d17d-8c3f638ec1a6@arm.com>
References: <CGME20170329100540eucas1p22d428e33aa678cbef0a24dd249820451@eucas1p2.samsung.com>
	<1490781926-6209-1-git-send-email-a.hajda@samsung.com>
	<15b1be13-625f-db74-d213-ad1df86f7eb5@arm.com>
	<073f1feb-d6da-c93f-8e67-0910befec27b@samsung.com>
	<c13f6475-f503-238f-c101-4f9cdf1b0ae2@arm.com>
	<45fde94b-9487-c28e-9d4e-3b36c4b4a934@samsung.com>
	<CAMuHMdWkOdAD=d0DAy7cJTHcQc7oq5HVDvTNtjfQETMynx1_+g@mail.gmail.com>
	<8dcbb0b3-dd13-d2b3-90f5-64b900d67778@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8dcbb0b3-dd13-d2b3-90f5-64b900d67778-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 30/03/17 09:30, Andrzej Hajda wrote:
> On 30.03.2017 09:40, Geert Uytterhoeven wrote:
>> Hi Andrzej,
>>
>> On Thu, Mar 30, 2017 at 8:51 AM, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>>> On 29.03.2017 17:33, Robin Murphy wrote:
>>>> On 29/03/17 16:12, Andrzej Hajda wrote:
>>>>> On 29.03.2017 14:55, Robin Murphy wrote:
>>>>>> On 29/03/17 11:05, Andrzej Hajda wrote:
>>>>>>> In case of DMA_ATTR_FORCE_CONTIGUOUS allocations vm_area->pages
>>>>>>> is invalid. __iommu_mmap_attrs and __iommu_get_sgtable cannot use
>>>>>>> it. In first case temporary pages array is passed to iommu_dma_mmap,
>>>>>>> in 2nd case single entry sg table is created directly instead
>>>>>>> of calling helper.
>>>>>>>
>>>>>>> Fixes: 44176bb ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
>>>>>>> Signed-off-by: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>>>> ---
>>>>>>> Hi,
>>>>>>>
>>>>>>> I am not familiar with this framework so please don't be too cruel ;)
>>>>>>> Alternative solution I see is to always create vm_area->pages,
>>>>>>> I do not know which approach is preferred.
>>>>>>>
>>>>>>> Regards
>>>>>>> Andrzej
>>>>>>> ---
>>>>>>>  arch/arm64/mm/dma-mapping.c | 40 ++++++++++++++++++++++++++++++++++++++--
>>>>>>>  1 file changed, 38 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>>>>>>> index f7b5401..bba2bc8 100644
>>>>>>> --- a/arch/arm64/mm/dma-mapping.c
>>>>>>> +++ b/arch/arm64/mm/dma-mapping.c
>>>>>>> @@ -704,7 +704,30 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>>>>>>>            return ret;
>>>>>>>
>>>>>>>    area = find_vm_area(cpu_addr);
>>>>>>> -  if (WARN_ON(!area || !area->pages))
>>>>>>> +  if (WARN_ON(!area))
>>>>>> >From the look of things, it doesn't seem strictly necessary to change
>>>>>> this, but whether that's a good thing is another matter. I'm not sure
>>>>>> that dma_common_contiguous_remap() should really be leaving a dangling
>>>>>> pointer in area->pages as it apparently does... :/
>>>>>>
>>>>>>> +          return -ENXIO;
>>>>>>> +
>>>>>>> +  if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
>>>>>>> +          struct page *page = vmalloc_to_page(cpu_addr);
>>>>>>> +          unsigned int count = size >> PAGE_SHIFT;
>>>>>>> +          struct page **pages;
>>>>>>> +          unsigned long pfn;
>>>>>>> +          int i;
>>>>>>> +
>>>>>>> +          pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL);
>>>>>>> +          if (!pages)
>>>>>>> +                  return -ENOMEM;
>>>>>>> +
>>>>>>> +          for (i = 0, pfn = page_to_pfn(page); i < count; i++)
>>>>>>> +                  pages[i] = pfn_to_page(pfn + i);
>>>>>>> +
>>>>>>> +          ret = iommu_dma_mmap(pages, size, vma);
>>>>>> /**
>>>>>>  * iommu_dma_mmap - Map a buffer into provided user VMA
>>>>>>  * @pages: Array representing buffer from iommu_dma_alloc()
>>>>>>    ...
>>>>>>
>>>>>> In this case, the buffer has not come from iommu_dma_alloc(), so passing
>>>>>> into iommu_dma_mmap() is wrong by contract, even if having to fake up a
>>>>>> page array wasn't enough of a red flag. Given that a FORCE_CONTIGUOUS
>>>>>> allocation is essentially the same as for the non-IOMMU case, I think it
>>>>>> should be sufficient to defer to that path, i.e.:
>>>>>>
>>>>>>     if (attrs & DMA_ATTR_FORCE_CONTIGUOUS)
>>>>>>             return __swiotlb_mmap(dev, vma, cpu_addr,
>>>>>>                             phys_to_dma(virt_to_phys(cpu_addr)),
>>>>>>                             size, attrs);
>>>>> Maybe I have make mistake somewhere but it does not work, here and below
>>>>> (hangs or crashes). I suppose it can be due to different address
>>>>> translations, my patch uses
>>>>>     page = vmalloc_to_page(cpu_addr).
>>>>> And here we have:
>>>>>     handle = phys_to_dma(dev, virt_to_phys(cpu_addr)); // in
>>>>> __iommu_mmap_attrs
>>>>>     page = phys_to_page(dma_to_phys(dev, handle)); // in
>>>>> __swiotlb_get_sgtable
>>>>> I guess it is similarly in __swiotlb_mmap.
>>>>>
>>>>> Are these translations equivalent?
>>>> Ah, my mistake, sorry - I managed to forget that cpu_addr is always
>>>> remapped for FORCE_CONTIGUOUS (*and* somehow overlook the use of
>>>> vmalloc_to_page() in the patch itself), so the virt_to_phys() part of my
>>>> example is indeed bogus. The general point still stands, though.
>>> I guess Geert's proposition to create pages permanently is also not
>>> acceptable[2]. So how to fix crashes which appeared after patch adding
>> If I'm not mistaken, creating the pages permanently is what the
>> !DMA_ATTR_FORCE_CONTIGUOUS does? The only difference is where
>> the underlying memory is allocated from.
>>
>> Am I missing something?
> 
> Quoting Robin from his response:
>> in general is is not
>> safe to assume a coherent allocation is backed by struct pages at all
> 
> As I said before I am not familiar with the subject, so it is possible I
> misunderstood something.

That's from the perspective of external callers of
dma_alloc_coherent()/dma_alloc_attrs(), wherein
dma_alloc_from_coherent() may have returned device-specific memory
without calling into the arch dma_map_ops implementation. Internal to
the arm64 implementation, however, everything *we* allocate comes from
either CMA or the normal page allocator, so should always be backed by
real kernel pages.

Robin.

> Regards
> Andrzej
> 
> 
>>
>> Thanks!
>>
>>> support to DMA_ATTR_FORCE_CONTIGUOUS in IOMMU on arm64 [1]?
>>> Maybe temporary solution is to drop the patch until proper handling of
>>> mmapping is proposed, without it the patch looks incomplete and causes
>>> regression.
>>> Moreover __iommu_alloc_attrs uses also dma_common_contiguous_remap which
>>> also assumes existence of struct pages.
>>>
>>> [1]: https://patchwork.kernel.org/patch/9609551/
>>> [2]: https://www.spinics.net/lists/arm-kernel/msg572688.html
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                 -- Linus Torvalds
>>
>>
>>
> 
