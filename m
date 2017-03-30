From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS mmaping
	code
Date: Thu, 30 Mar 2017 15:10:16 +0100
Message-ID: <f81eeedd-4de7-3a71-5199-63bc32495a7a@arm.com>
References: <CGME20170329100540eucas1p22d428e33aa678cbef0a24dd249820451@eucas1p2.samsung.com>
	<1490781926-6209-1-git-send-email-a.hajda@samsung.com>
	<15b1be13-625f-db74-d213-ad1df86f7eb5@arm.com>
	<073f1feb-d6da-c93f-8e67-0910befec27b@samsung.com>
	<c13f6475-f503-238f-c101-4f9cdf1b0ae2@arm.com>
	<45fde94b-9487-c28e-9d4e-3b36c4b4a934@samsung.com>
	<CAMuHMdWkOdAD=d0DAy7cJTHcQc7oq5HVDvTNtjfQETMynx1_+g@mail.gmail.com>
	<8dcbb0b3-dd13-d2b3-90f5-64b900d67778@samsung.com>
	<41097b2c-9bbc-31e4-d17d-8c3f638ec1a6@arm.com>
	<bd77ea57-96a8-bbc4-8184-9ddfd443f3c6@samsung.com>
	<868d0c3c-6b85-0709-1686-66b484ede46d@arm.com>
	<CAMuHMdUp3-pdZ+w+Y-GRfHbkdnjHbP=+H=A_ukTwDD5q_WMi1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdUp3-pdZ+w+Y-GRfHbkdnjHbP=+H=A_ukTwDD5q_WMi1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 30/03/17 12:53, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Thu, Mar 30, 2017 at 1:46 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 30/03/17 12:16, Andrzej Hajda wrote:
>> [...]
>>>>>>> I guess Geert's proposition to create pages permanently is also not
>>>>>>> acceptable[2]. So how to fix crashes which appeared after patch adding
>>>>>> If I'm not mistaken, creating the pages permanently is what the
>>>>>> !DMA_ATTR_FORCE_CONTIGUOUS does? The only difference is where
>>>>>> the underlying memory is allocated from.
>>>>>>
>>>>>> Am I missing something?
>>>>> Quoting Robin from his response:
>>>>>> in general is is not
>>>>>> safe to assume a coherent allocation is backed by struct pages at all
>>>>> As I said before I am not familiar with the subject, so it is possible I
>>>>> misunderstood something.
>>>> That's from the perspective of external callers of
>>>> dma_alloc_coherent()/dma_alloc_attrs(), wherein
>>>> dma_alloc_from_coherent() may have returned device-specific memory
>>>> without calling into the arch dma_map_ops implementation. Internal to
>>>> the arm64 implementation, however, everything *we* allocate comes from
>>>> either CMA or the normal page allocator, so should always be backed by
>>>> real kernel pages.
>>>>
>>>> Robin.
>>>
>>> OK, so what do you exactly mean by "The general point still stands", my
>>> patch fixes handling of allocations made internally?
>>
>> That since FORCE_CONTIGUOUS allocations always come from CMA, you can
>> let the existing CMA-based implementations handle them just by fixing up
>> dma_addr appropriately.
>>
>>> Anyway as I understand approach "creating the pages permanently" in
>>> __iommu_alloc_attrs is OK. Is it worth to create patch adding it? It
>>> should solve the issue as well and also looks saner (for me).
>>
>> Sure, you *could* - there's nothing technically wrong with that other
>> than violating a strict interpretation of the iommu-dma API
>> documentation if you pass it into iommu_dma_mmap() - it's just that the
>> only point of using the pages array here in the first place is to cover
>> the general case where an allocation might not be physically contiguous.
>> If you have a guarantee that a given allocation definitely *is* both
>> physically and virtually contiguous, then that's a bunch of extra work
>> you simply have no need to do.
> 
> The same can be said for dma_common_contiguous_remap() below...

Indeed it can. See if you can spot anything I've said in defence of that
particular function ;)

>> If you do want to go down that route, then I would much rather we fix
>> dma_common_contiguous_remap() to leave a valid array in area->pages in
>> the first place, than be temporarily faking them up around individual calls.
> 
> The only point of using the pages array here in the first place is to cover
> the general case in dma_common_pages_remap().
>
> Providing a contiguous variant of map_vm_area() could resolve that.

Isn't that what remap_pfn_range() already is? iommu_dma_mmap() had to
exist specifically because the likes of dma_common_mmap() *are* using
that on the assumption of physically contiguous ranges. I don't really
have the time or inclination to go digging into this myself, but there's
almost certainly room for some improvement and/or cleanup in the common
code too (and as I said, if something can be done there than I would
rather it were tackled head-on than worked around with point fixes in
the arch code).

Robin.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
