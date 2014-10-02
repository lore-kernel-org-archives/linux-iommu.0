From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 0/5] enhance DMA CMA on x86
Date: Thu, 02 Oct 2014 18:03:08 -0400
Message-ID: <542DCB9C.4020703@hurleysoftware.com>
References: <1397567329-3771-1-git-send-email-akinobu.mita@gmail.com>
	<5426CA0A.7000806@hurleysoftware.com>
	<CAC5umyhgs8---HZLa7_DOSbqW0uPbLgqTfBweScZSR9oWbG9xg@mail.gmail.com>
	<54294C0B.1060705@hurleysoftware.com>
	<CAC5umyjP4OscSC8igVLYPEm-6gqiXt9md46sLu77Vut5UiPb=g@mail.gmail.com>
	<542ABF77.1020402@hurleysoftware.com>
	<alpine.DEB.2.11.1410010131380.4455@nanos>
	<542B5DC2.8020806@hurleysoftware.com>
	<20141002164121.GF1715@laptop.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141002164121.GF1715-0iZWjJA6G8GSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
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
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/02/2014 12:41 PM, Konrad Rzeszutek Wilk wrote:
> On Tue, Sep 30, 2014 at 09:49:54PM -0400, Peter Hurley wrote:
>> On 09/30/2014 07:45 PM, Thomas Gleixner wrote:
>>> Whether the proposed patchset is the correct solution to support it is
>>> a completely different question.
>>
>> This patchset has been in mainline since 3.16 and has already caused
>> regressions, so the question of whether this is the correct solution has
>> already been answered.
>>
>>> So either you stop this right now and help Akinobu to find the proper
>>> solution 
>>
>> If this is only a test platform for ARM parts then I don't think it
>> unreasonable to suggest forking x86 swiotlb support into a iommu=cma
> 
> Not sure what you mean by 'forking x86 swiotlb' ? As in have SWIOTLB
> work under ARM?

No, that's not what I meant.

>> selector that gets DMA mapping working for this test platform and doesn't
>> cause a bunch of breakage.
> 
> I think you might want to take a look at the IOMMU_DETECT macros
> and enable CMA there only if the certain devices are available.
> 
> That way the normal flow of detecting which IOMMU to use is still present
> and will turn of CMA if there is no device that would use it.
> 
>>
>> Which is different than if the plan is to ship production units for x86;
>> then a general purpose solution will be required.
>>
>> As to the good design of a general purpose solution for allocating and
>> mapping huge order pages, you are certainly more qualified to help Akinobu
>> than I am.

What Akinobu's patches intend to support is:

	phys_addr = dma_alloc_coherent(dev, 64 * 1024 * 1024, &bus_addr, GFP_KERNEL);

which raises three issues:

1. Where do coherent blocks of this size come from?
2. How to prevent fragmentation of these reserved blocks over time by
   existing DMA users?
3. Is this support generically required across all iommu implementations on x86?

Questions 1 and 2 are non-trivial, in the general case, otherwise the page
allocator would already do this. Simply dropping in the contiguous memory
allocator doesn't work because CMA does not have the same policy and performance
as the page allocator, and is already causing performance regressions even
in the absence of huge page allocations.

So that's why I raised question 3; is making the necessary compromises to support
64MB coherent DMA allocations across all x86 iommu implementations actually
required?

Prior to Akinobu's patches, the use of CMA by x86 iommu configurations was
designed to be limited to testing configurations, as the introductory
commit states:

commit 0a2b9a6ea93650b8a00f9fd5ee8fdd25671e2df6
Author: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Date:   Thu Dec 29 13:09:51 2011 +0100

    X86: integrate CMA with DMA-mapping subsystem
    
    This patch adds support for CMA to dma-mapping subsystem for x86
    architecture that uses common pci-dma/pci-nommu implementation. This
    allows to test CMA on KVM/QEMU and a lot of common x86 boxes.
    
    Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
    Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
    CC: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
    Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>


Which brings me to my suggestion: if support for huge coherent DMA is
required only for a special test platform, then could not this support
be specific to a new iommu configuration, namely iommu=cma, which would
get initialized much the same way that iommu=calgary is now.

The code for such a iommu configuration would mostly duplicate
arch/x86/kernel/pci-swiotlb.c and the CMA support would get removed from
the other x86 iommu implementations.

Regards,
Peter Hurley
