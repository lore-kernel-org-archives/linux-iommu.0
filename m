From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] iommu/dma: Use NUMA aware memory allocations in
	__iommu_dma_alloc_pages()
Date: Tue, 20 Nov 2018 15:42:16 +0000
Message-ID: <c8b9ae20-215c-4778-c3ca-cb27b6b27dff@huawei.com>
References: <1542721320-233109-1-git-send-email-john.garry@huawei.com>
	<f9a91b43-ae77-ced5-3afc-57366e5126cb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f9a91b43-ae77-ced5-3afc-57366e5126cb-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 20/11/2018 14:20, Robin Murphy wrote:
> On 20/11/2018 13:42, John Garry wrote:
>> From: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> Change function __iommu_dma_alloc_pages() to allocate memory/pages
>> for DMA from respective device NUMA node.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> [JPG:  Modifed to use kvzalloc() and fixed indentation]
>> Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>> Difference v1->v2:
>> - Add Ganapatrao's tag and change author
>>
>> This patch was originally posted by Ganapatrao in [1].
>>
>> However, after initial review, it was never reposted (due to lack of
>> cycles, I think). In addition, the functionality in its sibling patches
>> were merged through patches, as mentioned in [2]; this also refers to a
>> discussion on device local allocations vs CPU local allocations for DMA
>> pool, and which is better [3].
>>
>> However, as mentioned in [3], dma_alloc_coherent() uses the locality
>> information from the device - as in direct DMA - so this patch is just
>> applying this same policy.
>>
>> [1] https://lore.kernel.org/patchwork/patch/833004/
>> [2] https://lkml.org/lkml/2018/8/22/391
>> [3]
>> https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1692998.html
>>
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index d1b0475..ada00bc 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -449,20 +449,17 @@ static void __iommu_dma_free_pages(struct page
>> **pages, int count)
>>       kvfree(pages);
>>   }
>>   -static struct page **__iommu_dma_alloc_pages(unsigned int count,
>> -        unsigned long order_mask, gfp_t gfp)
>> +static struct page **__iommu_dma_alloc_pages(struct device *dev,
>> +        unsigned int count, unsigned long order_mask, gfp_t gfp)
>>   {
>>       struct page **pages;
>> -    unsigned int i = 0, array_size = count * sizeof(*pages);
>> +    unsigned int i = 0, nid = dev_to_node(dev);
>>         order_mask &= (2U << MAX_ORDER) - 1;
>>       if (!order_mask)
>>           return NULL;
>>   -    if (array_size <= PAGE_SIZE)
>> -        pages = kzalloc(array_size, GFP_KERNEL);
>> -    else
>> -        pages = vzalloc(array_size);
>> +    pages = kvzalloc_node(count * sizeof(*pages), GFP_KERNEL, nid);
>
> The pages array is only accessed by the CPU servicing the
> iommu_dma_alloc() call, and is usually freed again before that call even
> returns. It's certainly never touched by the device, so forcing it to a
> potentially non-local node doesn't make a great deal of sense.

Right, it seems sensible to not make this allocation include the 
device-locality requirement, so can leave as is. However modifying to 
use kvzalloc() would seem ok.

>
>>       if (!pages)
>>           return NULL;
>>   @@ -483,8 +480,10 @@ static struct page
>> **__iommu_dma_alloc_pages(unsigned int count,
>>               unsigned int order = __fls(order_mask);
>>                 order_size = 1U << order;
>> -            page = alloc_pages((order_mask - order_size) ?
>> -                       gfp | __GFP_NORETRY : gfp, order);
>> +            page = alloc_pages_node(nid,
>> +                        (order_mask - order_size) ?
>> +                        gfp | __GFP_NORETRY : gfp,
>> +                        order);
>
> If we're touching this, can we sort out that horrendous ternary? FWIW I
> found I have a local version of the original patch which I tweaked at
> the time, and apparently I reworked this hunk as below, which does seem
> somewhat nicer for the same diffstat.
>
> Robin.
>
>
> @@ -446,10 +443,12 @@ static struct page
> **__iommu_dma_alloc_pages(unsigned int count,
>                 for (order_mask &= (2U << __fls(count)) - 1;
>                      order_mask; order_mask &= ~order_size) {
>                         unsigned int order = __fls(order_mask);
> +                       gfp_t alloc_flags = gfp;
>
>                         order_size = 1U << order;
> -                       page = alloc_pages((order_mask - order_size) ?
> -                                          gfp | __GFP_NORETRY : gfp,
> order);
> +                       if (order_size < order_mask)
> +                               alloc_flags |= __GFP_NORETRY;

Sure, this can be included

> +                       page = alloc_pages_node(nid, alloc_flags, order);
>                         if (!page)
>                                 continue;
>                         if (!order)
>
> .
>


Cheers,
John
