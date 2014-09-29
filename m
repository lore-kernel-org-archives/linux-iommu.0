From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] x86: don't unnecessarily call
	dma_alloc_from_contiguous()
Date: Mon, 29 Sep 2014 22:21:18 +0900
Message-ID: <CAC5umygE3R6WwtG0P+LN7NV1Fn=DZ8+p41rG5hCJrWs64Yrr_A@mail.gmail.com>
References: <1411919524-3666-1-git-send-email-akinobu.mita@gmail.com>
	<20140928154525.76cc5464@as>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140928154525.76cc5464@as>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Chuck Ebbert <cebbert.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

2014-09-29 5:45 GMT+09:00 Chuck Ebbert <cebbert.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Mon, 29 Sep 2014 00:52:03 +0900
> Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> If CONFIG_DMA_CMA is enabled, dma_generic_alloc_coherent() tries to
>> allocate memory region by dma_alloc_from_contiguous() before trying to
>> use alloc_pages().
>>
>> This wastes CMA region by small DMA-coherent buffers which can be
>> allocated by alloc_pages().  And it also causes performance degradation,
>> as this is trying to drive _all_ dma mapping allocations through a
>> _very_ small window, reported by Peter Hurley.
>>
>> This fixes it by trying to allocate by alloc_pages() first in
>> dma_generic_alloc_coherent() as dma_alloc_from_contiguous should be
>> called only for huge allocation.
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Reported-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
>> Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
>> Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>> Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>> Cc: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>> Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
>> Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
>> Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> ---
>>  arch/x86/kernel/pci-dma.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
>> index a25e202..0402266 100644
>> --- a/arch/x86/kernel/pci-dma.c
>> +++ b/arch/x86/kernel/pci-dma.c
>> @@ -99,20 +99,20 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
>>
>>       flag &= ~__GFP_ZERO;
>>  again:
>> -     page = NULL;
>> +     page = alloc_pages_node(dev_to_node(dev), flag | __GFP_NOWARN,
>> +                             get_order(size));
>
> Only try small allocs here, like when order < PAGE_ALLOC_COSTLY_ORDER ?
>
>>       /* CMA can be used only in the context which permits sleeping */
>> -     if (flag & __GFP_WAIT) {
>> +     if (!page && (flag & __GFP_WAIT)) {
>>               page = dma_alloc_from_contiguous(dev, count, get_order(size));
>>               if (page && page_to_phys(page) + size > dma_mask) {
>>                       dma_release_from_contiguous(dev, page, count);
>>                       page = NULL;
>>               }
>>       }
>> -     /* fallback */
>> -     if (!page)
>> -             page = alloc_pages_node(dev_to_node(dev), flag, get_order(size));
>
> (I forgot to add this in my first reply). I think it should try for a
> small alloc without CMA first, then try CMA, and then this final
> fallback for larger allocs.

I'm concerned with the performance problem reported by Peter Hurley.
This could be a solution, but I would like to hear Peter's opinion.

For now, I prefer the solution by this patch because it gives less
impact on CONFIG_DMA_CMA enabled.  But it can be improved later on.
