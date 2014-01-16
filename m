From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/5] x86: enable DMA CMA with swiotlb
Date: Fri, 17 Jan 2014 08:32:09 +0900
Message-ID: <CAC5umyitWHvWiWn9B3wtTNBhbO7Rz_ghqmxhwu9caq40msnfAA@mail.gmail.com>
References: <1389708830-5841-1-git-send-email-akinobu.mita@gmail.com>
	<1389708830-5841-3-git-send-email-akinobu.mita@gmail.com>
	<20140115201224.GD5201@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140115201224.GD5201-6K5HmflnPlqSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
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

2014/1/16 Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>:
> On Tue, Jan 14, 2014 at 11:13:47PM +0900, Akinobu Mita wrote:
>> The DMA Contiguous Memory Allocator support on x86 is disabled when
>> swiotlb config option is enabled.  So DMA CMA is always disabled on
>> x86_64 because swiotlb is always enabled.  This attempts to support
>> for DMA CMA with enabling swiotlb config option.
>>
>> The contiguous memory allocator on x86 is integrated in the function
>> dma_generic_alloc_coherent() which is .alloc callback in nommu_dma_ops
>> for dma_alloc_coherent().
>>
>> x86_swiotlb_alloc_coherent() which is .alloc callback in swiotlb_dma_ops
>> tries to allocate with dma_generic_alloc_coherent() firstly and then
>> swiotlb_alloc_coherent() is called as a fallback.
>>
>> The main part of supporting DMA CMA with swiotlb is that changing
>> x86_swiotlb_free_coherent() which is .free callback in swiotlb_dma_ops
>> for dma_free_coherent() so that it can distinguish memory allocated by
>> dma_generic_alloc_coherent() from one allocated by swiotlb_alloc_coherent()
>> and release it with dma_generic_free_coherent() which can handle contiguous
>> memory.  This change requires making is_swiotlb_buffer() global function.
>>
>> This also needs to change .free callback in the dma_map_ops for amd_gart
>> and sta2x11, because these dma_ops are also using
>> dma_generic_alloc_coherent().
>>
>> Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>> Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>> Cc: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>> Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
>> Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
>> Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>> No change from the previous version
>>
>>  arch/x86/Kconfig               | 2 +-
>>  arch/x86/include/asm/swiotlb.h | 7 +++++++
>>  arch/x86/kernel/amd_gart_64.c  | 2 +-
>>  arch/x86/kernel/pci-swiotlb.c  | 9 ++++++---
>>  arch/x86/pci/sta2x11-fixup.c   | 6 ++----
>>  include/linux/swiotlb.h        | 2 ++
>>  lib/swiotlb.c                  | 2 +-
>
> It looks reasonable from my perspective (as swiotlb maintainer).
>
> Not too thrilled about the  'is_swiotlb_buffer' but that code is
> quite small so it should be fast enough.

Thanks.  Can I get your Acked-by for this patch?
