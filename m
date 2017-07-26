From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] iommu/dma: Use __GFP_NOWARN only for high-order
	allocations
Date: Wed, 26 Jul 2017 18:29:37 +0900
Message-ID: <CAAFQd5Bwti0SCC+bjWap94FWe3uqA6DMckLjkV7Q=0Ez-zT22A@mail.gmail.com>
References: <20170704135556.21704-1-tfiga@chromium.org>
	<20170704135556.21704-2-tfiga@chromium.org>
	<20170726092411.GD15833@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170726092411.GD15833-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Wed, Jul 26, 2017 at 6:24 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jul 04, 2017 at 10:55:56PM +0900, Tomasz Figa wrote:
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index bf23989b5158..6ed8c8f941d8 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -433,6 +433,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>>  {
>>       struct page **pages;
>>       unsigned int i = 0, array_size = count * sizeof(*pages);
>> +     const gfp_t high_order_gfp = __GFP_NOWARN | __GFP_NORETRY;
>>
>>       order_mask &= (2U << MAX_ORDER) - 1;
>>       if (!order_mask)
>> @@ -452,8 +453,6 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>>       if (!(gfp & (__GFP_DMA | __GFP_DMA32)))
>>               gfp |= __GFP_HIGHMEM;
>>
>> -     gfp |= __GFP_NOWARN;
>> -
>
> Okay, so a warning should be there if allocation fails, independent of
> what the allocation order is.

The allocation fails only if the order drops to the lowest possible
fallback order.

> So either this function prints a message
> in case of allocation failure or we remove __GFP_NOWARN for all
> allocation attempts.
>
> Adding __GFP_NOWARN only makes sense when there is another fall-back in
> case allocation fails anyway, which is not the case here.

There is fall back here. The loop tries allocating with higher order
and then falls back to a lower order if it fails and so on, until the
lowest acceptable order is reached.

>
>>       while (count) {
>>               struct page *page = NULL;
>>               unsigned int order_size;
>> @@ -469,7 +468,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>>
>>                       order_size = 1U << order;
>>                       page = alloc_pages((order_mask - order_size) ?
>> -                                        gfp | __GFP_NORETRY : gfp, order);
>> +                                        gfp | high_order_gfp : gfp, order);
>
> Why does it specify __GFP_NORETRY at all? The alloc-routines in the
> DMA-API don't need to be atomic.

This doesn't have anything to do with being atomic. __GFP_NORETRY here
is to avoid the page allocator retrying indefinitely and actually
triggering OOM for high order allocation, if we can safely fall back
to lower order.

Best regards,
Tomasz
