From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] x86: make dma_alloc_coherent() return zeroed
	memory if CMA is enabled
Date: Wed, 29 Jan 2014 08:20:45 +0900
Message-ID: <CAC5umyjJfO9UyAkoG-bEX-vdO+X0fM_YD2dwj2AHT6T7hKgv0A@mail.gmail.com>
References: <1389708830-5841-1-git-send-email-akinobu.mita@gmail.com>
	<1389708830-5841-2-git-send-email-akinobu.mita@gmail.com>
	<52E66527.8010000@samsung.com>
	<20140127152342.GC20968@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140127152342.GC20968-6K5HmflnPlqSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

2014-01-28 Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>:
> On Mon, Jan 27, 2014 at 02:54:47PM +0100, Marek Szyprowski wrote:
>> Hello,
>>
>> On 2014-01-14 15:13, Akinobu Mita wrote:
>> >Calling dma_alloc_coherent() with __GFP_ZERO must return zeroed memory.
>> >
>> >But when the contiguous memory allocator (CMA) is enabled on x86 and
>> >the memory region is allocated by dma_alloc_from_contiguous(), it
>> >doesn't return zeroed memory.  Because dma_generic_alloc_coherent()
>> >forgot to fill the memory region with zero if it was allocated by
>> >dma_alloc_from_contiguous()
>>
>> I just wonder how it will work with high mem? I've didn't check the x86
>> dma mapping code yet, but page_address() works only for pages, which comes
>> from low memory. In other patches you have added an option to place CMA
>> area anywhere in the memory. Is the x86 pci dma code ready for the case
>> when cma area is put into high mem and direct mappings are not available?
>
> Yes and no. The swiotbl_bounce does have the code to take that into account.
> But that is it - nothing else does - so I think you would run in the
> possiblity of 'page_address' not providing an correct virtual address.

Thanks for spotting the issue.  I haven't much tested on x86_32.
I'll go through it and try to find the solution.

>>
>> >Most implementations of dma_alloc_coherent() return zeroed memory
>> >regardless of whether __GFP_ZERO is specified.  So this fixes it by
>> >unconditionally zeroing the allocated memory region.
>> >
>> >Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> >Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>> >Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>> >Cc: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> >Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>> >Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> >Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
>> >Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
>> >Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>> >Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> >Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >---
>> >New patch from this version
>> >
>> >  arch/x86/kernel/pci-dma.c | 3 +--
>> >  1 file changed, 1 insertion(+), 2 deletions(-)
>> >
>> >diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
>> >index 872079a..9644405 100644
>> >--- a/arch/x86/kernel/pci-dma.c
>> >+++ b/arch/x86/kernel/pci-dma.c
>> >@@ -97,7 +97,6 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
>> >     dma_mask = dma_alloc_coherent_mask(dev, flag);
>> >-    flag |= __GFP_ZERO;
>> >  again:
>> >     page = NULL;
>> >     if (!(flag & GFP_ATOMIC))
>> >@@ -118,7 +117,7 @@ again:
>> >             return NULL;
>> >     }
>> >-
>> >+    memset(page_address(page), 0, size);
>> >     *dma_addr = addr;
>> >     return page_address(page);
>> >  }
>>
>> Best regards
>> --
>> Marek Szyprowski, PhD
>> Samsung R&D Institute Poland
>>
