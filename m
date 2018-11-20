From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/dma: Use NUMA aware memory allocations in
	__iommu_dma_alloc_pages()
Date: Tue, 20 Nov 2018 10:19:22 +0000
Message-ID: <be6141f0-ae12-378c-9628-dee306f803cf@huawei.com>
References: <1541699709-25474-1-git-send-email-john.garry@huawei.com>
	<1e2b8689-dc1f-3ede-4eeb-4a91d3a3f63f@huawei.com>
	<CAKTKpr4S_v+Fm9K0F8xZTuwKSArZapXr-4Xo1YoNn8=X70H83g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKTKpr4S_v+Fm9K0F8xZTuwKSArZapXr-4Xo1YoNn8=X70H83g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ganapatrao Kulkarni <gklkml16-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 20/11/2018 10:09, Ganapatrao Kulkarni wrote:
> Hi John,
>
> On Tue, Nov 20, 2018 at 3:35 PM John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
>>
>> On 08/11/2018 17:55, John Garry wrote:
>>> Change function __iommu_dma_alloc_pages() to allocate memory/pages
>>> for DMA from respective device NUMA node.
>>>
>>
>> Ping.... a friendly reminder on this patch.
>>
>> Thanks
>>
>>> Originally-from: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>> Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>> ---
>>>
>>> This patch was originally posted by Ganapatrao in [1] *.
>>>
>>> However, after initial review, it was never reposted (due to lack of
>>> cycles, I think). In addition, the functionality in its sibling patches
>>> were merged through patches, as mentioned in [2]; this also refers to a
>>> discussion on device local allocations vs CPU local allocations for DMA
>>> pool, and which is better [3].
>>>
>>> However, as mentioned in [3], dma_alloc_coherent() uses the locality
>>> information from the device - as in direct DMA - so this patch is just
>>> applying this same policy.
>>>
>>> [1] https://lore.kernel.org/patchwork/patch/833004/
>>> [2] https://lkml.org/lkml/2018/8/22/391
>>> [3] https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1692998.html
>>>
>>> * Authorship on this updated patch may need to be fixed - I add not want to
>>>   add Ganapatrao's SOB without permission.
>
> thanks for taking this up. please feel free to add my SoB.

OK, I will also make you the author and repost.

Thanks,
John

>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index d1b0475..ada00bc 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -449,20 +449,17 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
>>>       kvfree(pages);
>>>  }
>>>
>>> -static struct page **__iommu_dma_alloc_pages(unsigned int count,
>>> -             unsigned long order_mask, gfp_t gfp)
>>> +static struct page **__iommu_dma_alloc_pages(struct device *dev,
>>> +             unsigned int count, unsigned long order_mask, gfp_t gfp)
>>>  {
>>>       struct page **pages;
>>> -     unsigned int i = 0, array_size = count * sizeof(*pages);
>>> +     unsigned int i = 0, nid = dev_to_node(dev);
>>>
>>>       order_mask &= (2U << MAX_ORDER) - 1;
>>>       if (!order_mask)
>>>               return NULL;
>>>
>>> -     if (array_size <= PAGE_SIZE)
>>> -             pages = kzalloc(array_size, GFP_KERNEL);
>>> -     else
>>> -             pages = vzalloc(array_size);
>>> +     pages = kvzalloc_node(count * sizeof(*pages), GFP_KERNEL, nid);
>>>       if (!pages)
>>>               return NULL;
>>>
>>> @@ -483,8 +480,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>>>                       unsigned int order = __fls(order_mask);
>>>
>>>                       order_size = 1U << order;
>>> -                     page = alloc_pages((order_mask - order_size) ?
>>> -                                        gfp | __GFP_NORETRY : gfp, order);
>>> +                     page = alloc_pages_node(nid,
>>> +                                             (order_mask - order_size) ?
>>> +                                             gfp | __GFP_NORETRY : gfp,
>>> +                                             order);
>>>                       if (!page)
>>>                               continue;
>>>                       if (!order)
>>> @@ -569,7 +568,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>>>               alloc_sizes = min_size;
>>>
>>>       count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>> -     pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
>>> +     pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
>>> +                                     gfp);
>>>       if (!pages)
>>>               return NULL;
>>>
>>>
>>
>>
>
> thanks
> Ganapat
>
> .
>
