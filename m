From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/5] enhance DMA CMA on x86
Date: Sun, 28 Sep 2014 09:31:50 +0900
Message-ID: <CAC5umyhgs8---HZLa7_DOSbqW0uPbLgqTfBweScZSR9oWbG9xg@mail.gmail.com>
References: <1397567329-3771-1-git-send-email-akinobu.mita@gmail.com>
	<5426CA0A.7000806@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5426CA0A.7000806-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

2014-09-27 23:30 GMT+09:00 Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>:
> On 04/15/2014 09:08 AM, Akinobu Mita wrote:
>> This patch set enhances the DMA Contiguous Memory Allocator on x86.
>>
>> Currently the DMA CMA is only supported with pci-nommu dma_map_ops
>> and furthermore it can't be enabled on x86_64.  But I would like to
>> allocate big contiguous memory with dma_alloc_coherent() and tell it
>> to the device that requires it, regardless of which dma mapping
>> implementation is actually used in the system.
>>
>> So this makes it work with swiotlb and intel-iommu dma_map_ops, too.
>> And this also extends "cma=" kernel parameter to specify placement
>> constraint by the physical address range of memory allocations.  For
>> example, CMA allocates memory below 4GB by "cma=64M@0-4G", it is
>> required for the devices only supporting 32-bit addressing on 64-bit
>> systems without iommu.
>>
>> * Changes from v2
>> - Rebased on current Linus tree
>> - Add Acked-by line
>> - Fix gfp flags check for __GFP_ATOMIC, reported by Marek Szyprowski
>> - Avoid CMA area on highmem with cma= option, reported by Marek Szyprowski
>>
>> * Changes from v1
>> - fix dma_alloc_coherent() with __GFP_ZERO
>> - add placement specifier for "cma=" kernel parameter
>>
>> Akinobu Mita (5):
>>   x86: make dma_alloc_coherent() return zeroed memory if CMA is enabled
>>   x86: enable DMA CMA with swiotlb
>>   intel-iommu: integrate DMA CMA
>>   memblock: introduce memblock_alloc_range()
>>   cma: add placement specifier for "cma=" kernel parameter
>
> This patchset breaks every x86 iommu configuration when CONFIG_DMA_CMA is
> on, which is the base configuration for Ubuntu x86 and amd64 distro kernels.
>
> Granted, the patchset leveraged existing code from the nommu configuration,
> but that base (ie., calling dma_alloc_from_contiguous() in
> dma_generic_alloc_config()) was an ill-conceived test configuration designed
> to allow ARM developers to validate the CMA allocator on x86 boxen and
> KVM guests, not as a general-purpose replacement for the existing page
> allocator. The test code should have had a separate CONFIG_ knob.
>
> What this patchset does is restrict all iommu configurations which can
> map all of system memory to one _very_ small physical region, thus disabling
> the whole point of an iommu.
>
> Now I know why my GPU is causing paging to disk! And why my RAID controller
> stalls for ages when I do a git log at the same time as a kernel build!

The solution I have for this is that instead of trying to
dma_alloc_from_contiguous() firstly, call alloc_pages() in dma_alloc_coherent().
dma_alloc_from_contiguous() should be called only when alloc_pages() is failed
or DMA_ATTR_FORCE_CONTIGUOUS is specified in dma_attr.

> And the apparent goal of this patchset is to enable DMA allocation below
> 4GB, which is already supported in the existing page allocator with the
> GFP_DMA32 flag?!

The goal of this patchset is to enable huge DMA allocation which
alloc_pages() can't (> MAX_ORDER) for the devices that require it.

Thanks for the notification.  I'll prepare a patch described above.
