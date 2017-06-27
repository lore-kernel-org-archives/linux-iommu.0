From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/dma: Respect __GFP_DMA and __GFP_DMA32 in
	incoming GFP flags
Date: Tue, 27 Jun 2017 13:26:12 +0100
Message-ID: <0a6dceb1-ffe6-b213-eb98-fd897b62febd@arm.com>
References: <20170627072812.15316-1-tfiga@chromium.org>
	<ca273ece-b501-e853-aa84-bd1153086fe9@arm.com>
	<CAAFQd5DUXtNpQ82TDE16Tzxhd0iNMQoPKMnWUoabAKOOSGrTWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5DUXtNpQ82TDE16Tzxhd0iNMQoPKMnWUoabAKOOSGrTWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 27/06/17 12:17, Tomasz Figa wrote:
> On Tue, Jun 27, 2017 at 8:01 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 27/06/17 08:28, Tomasz Figa wrote:
>>> Current implementation of __iommu_dma_alloc_pages() keeps adding
>>> __GFP_HIGHMEM to GFP flags regardless of whether other zone flags are
>>> already included in the incoming flags. If __GFP_DMA or __GFP_DMA32 is
>>> set at the same time as __GFP_HIGHMEM, the allocation fails due to
>>> invalid zone flag combination.
>>>
>>> Fix this by checking for __GFP_DMA and __GFP_DMA32 in incoming GFP flags
>>> and adding __GFP_HIGHMEM only if they are not present.
>>
>> Wouldn't it make more sense to strip off the ZONE_DMA* related flags,
>> since the whole point here is that we don't care where the pages come from?
> 
> I guess for my use case it wouldn't break things, as I strip them in
> my DMA mapping implementation right now (+/- one minor detail below).
> 
> However I recall existing IOMMUs that could only use pages from within
> the 32-bit address space (e.g. Tegra X1).

In general, iommu-dma can't really support IOMMUs which can't reach the
entirety of kernel memory - there's no easy way to determine what such a
limit is if it exists, nor necessarily enforce it, and either way the
streaming API callbacks are pretty much dead in the water.

> Also the IOMMU I'm working
> on is a part of a PCI device and it might actually prefer 32-bit
> addressable memory as well (to avoid DAC addressing; I still need to
> evaluate this). With this said, maybe it could actually make sense to
> leave the choice to the DMA mapping implementation?

I think you're right - we're just not in a position to make any decision
at this level, so we probably do have to do this for robustness. I would
like to fix the longstanding dodgy comment, though, to clarify that
"IOMMU can map any pages" is only an assumption, and particularly one
which is invalidated by the presence of GFP_DMA flags.

Robin.

> 
> Best regards,
> Tomasz
> 
>>
>> Robin.
>>
>>> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>> ---
>>>  drivers/iommu/dma-iommu.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 9d1cebe7f6cb..29965a092a69 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -445,8 +445,14 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>>>       if (!pages)
>>>               return NULL;
>>>
>>> -     /* IOMMU can map any pages, so himem can also be used here */
>>> -     gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>>> +     /*
>>> +      * IOMMU can map any pages, so himem can also be used here,
>>> +      * unless another DMA zone is explicitly requested.
>>> +      */
>>> +     if (!(gfp & (__GFP_DMA | __GFP_DMA32)))
>>> +             gfp |= __GFP_HIGHMEM;
>>> +
>>> +     gfp |= __GFP_NOWARN;
>>>
>>>       while (count) {
>>>               struct page *page = NULL;
>>>
>>
