From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] x86: make dma_alloc_coherent() return zeroed
	memory if CMA is enabled
Date: Mon, 3 Feb 2014 21:14:37 +0900
Message-ID: <CAC5umyiFfrfe2MVMi-PJW6g8SXJvAsLzdy7vX-VPKhPuXFSbcw@mail.gmail.com>
References: <1389708830-5841-1-git-send-email-akinobu.mita@gmail.com>
	<1389708830-5841-2-git-send-email-akinobu.mita@gmail.com>
	<52E66527.8010000@samsung.com>
	<20140127152342.GC20968@phenom.dumpdata.com>
	<CAC5umyjJfO9UyAkoG-bEX-vdO+X0fM_YD2dwj2AHT6T7hKgv0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAC5umyjJfO9UyAkoG-bEX-vdO+X0fM_YD2dwj2AHT6T7hKgv0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

2014-01-29 Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 2014-01-28 Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>:
>> On Mon, Jan 27, 2014 at 02:54:47PM +0100, Marek Szyprowski wrote:
>>> Hello,
>>>
>>> On 2014-01-14 15:13, Akinobu Mita wrote:
>>> >Calling dma_alloc_coherent() with __GFP_ZERO must return zeroed memory.
>>> >
>>> >But when the contiguous memory allocator (CMA) is enabled on x86 and
>>> >the memory region is allocated by dma_alloc_from_contiguous(), it
>>> >doesn't return zeroed memory.  Because dma_generic_alloc_coherent()
>>> >forgot to fill the memory region with zero if it was allocated by
>>> >dma_alloc_from_contiguous()
>>>
>>> I just wonder how it will work with high mem? I've didn't check the x86
>>> dma mapping code yet, but page_address() works only for pages, which comes
>>> from low memory. In other patches you have added an option to place CMA
>>> area anywhere in the memory. Is the x86 pci dma code ready for the case
>>> when cma area is put into high mem and direct mappings are not available?
>>
>> Yes and no. The swiotbl_bounce does have the code to take that into account.
>> But that is it - nothing else does - so I think you would run in the
>> possiblity of 'page_address' not providing an correct virtual address.
>
> Thanks for spotting the issue.  I haven't much tested on x86_32.
> I'll go through it and try to find the solution.

I have confirmed that locating CMA on highmem range with a
'cma=size@start-end' kernel parameter by this patch set caused the
issue on x86_32.

This can be fixed by limiting CMA area upto max_low_pfn to prevent
from locating it on highmem at arch/x86/kernel/setup.c:setup_arch()

-       dma_contiguous_reserve(0);
+       dma_contiguous_reserve(max_low_pfn << PAGE_SHIFT);

I'm going to inlcude this change in this patch set.
