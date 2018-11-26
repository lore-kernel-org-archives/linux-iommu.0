From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Date: Mon, 26 Nov 2018 13:18:53 +0000
Message-ID: <7a3e53dc-9949-5b33-1282-54ae8ac1c62f@arm.com>
References: <20181115154950.GA27985@jordon-HP-15-Notebook-PC>
 <bbad42cb-4a76-a7e7-c385-db77f1cc588b@arm.com>
 <20181123213448.GW3065@bombadil.infradead.org>
 <CAFqt6zYmy5SdZY6_1BXFbY2pBQaNd+Z8R71wHEs6nKmxjht07A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFqt6zYmy5SdZY6_1BXFbY2pBQaNd+Z8R71wHEs6nKmxjht07A@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Souptick Joarder <jrdr.linux@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, joro@8bytes.org, Linux-MM <linux-mm@kvack.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 26/11/2018 06:44, Souptick Joarder wrote:
> On Sat, Nov 24, 2018 at 3:04 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Fri, Nov 23, 2018 at 05:23:06PM +0000, Robin Murphy wrote:
>>> On 15/11/2018 15:49, Souptick Joarder wrote:
>>>> Convert to use vm_insert_range() to map range of kernel
>>>> memory to user vma.
>>>>
>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>> Reviewed-by: Matthew Wilcox <willy@infradead.org>
>>>> ---
>>>>    drivers/iommu/dma-iommu.c | 12 ++----------
>>>>    1 file changed, 2 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>> index d1b0475..69c66b1 100644
>>>> --- a/drivers/iommu/dma-iommu.c
>>>> +++ b/drivers/iommu/dma-iommu.c
>>>> @@ -622,17 +622,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>>>>    int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>>>>    {
>>>> -   unsigned long uaddr = vma->vm_start;
>>>> -   unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>>> -   int ret = -ENXIO;
>>>> +   unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>>> -   for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
>>>> -           ret = vm_insert_page(vma, uaddr, pages[i]);
>>>> -           if (ret)
>>>> -                   break;
>>>> -           uaddr += PAGE_SIZE;
>>>> -   }
>>>> -   return ret;
>>>> +   return vm_insert_range(vma, vma->vm_start, pages, count);
>>>
>>> AFIACS, vm_insert_range() doesn't respect vma->vm_pgoff, so doesn't this
>>> break partial mmap()s of a large buffer? (which I believe can be a thing)
>>
>> Whoops.  That should have been:
>>
>> return vm_insert_range(vma, vma->vm_start, pages + vma->vm_pgoff, count);
> 
> I am unable to trace back where vma->vm_pgoff is set for this driver ? if any ?

This isn't a driver - it's a DMA API backend, so any caller of 
dma_mmap_*() could potentially end up here (similarly for patch 2/9).

Robin.

> If default value set to 0 then I think existing code is correct.
> 
>>
>> I suppose.
>>
> 
>> Although arguably we should respect vm_pgoff inside vm_insert_region()
>> and then callers automatically get support for vm_pgoff without having
>> to think about it ...
> 
> I assume, vm_insert_region() means vm_insert_range(). If we respect vm_pgoff
> inside vm_insert_range, for any uninitialized/ error value set for vm_pgoff from
> drivers will introduce a bug inside core mm which might be difficult
> to trace back.
> But when vm_pgoff set and passed from caller (drivers) it might be
> easy to figure out.
> 
>> although we should then also pass in the length
>> of the pages array to avoid pages being mapped in which aren't part of
>> the allocated array.
> 
> Mostly Partial mapping is done by starting from an index and mapped it till
> end of pages array. Calculating length of the pages array will have a small
> overhead for each drivers.
> 
> Please correct me if I am wrong.
> 
