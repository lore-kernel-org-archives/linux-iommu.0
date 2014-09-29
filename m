From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/5] enhance DMA CMA on x86
Date: Mon, 29 Sep 2014 23:32:55 +0900
Message-ID: <CAC5umyjP4OscSC8igVLYPEm-6gqiXt9md46sLu77Vut5UiPb=g@mail.gmail.com>
References: <1397567329-3771-1-git-send-email-akinobu.mita@gmail.com>
	<5426CA0A.7000806@hurleysoftware.com>
	<CAC5umyhgs8---HZLa7_DOSbqW0uPbLgqTfBweScZSR9oWbG9xg@mail.gmail.com>
	<54294C0B.1060705@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54294C0B.1060705-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
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

2014-09-29 21:09 GMT+09:00 Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>:
> On 09/27/2014 08:31 PM, Akinobu Mita wrote:
>> 2014-09-27 23:30 GMT+09:00 Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>:
>>> On 04/15/2014 09:08 AM, Akinobu Mita wrote:
>>>> This patch set enhances the DMA Contiguous Memory Allocator on x86.
>
> [...]
>
>>> What this patchset does is restrict all iommu configurations which can
>>> map all of system memory to one _very_ small physical region, thus disabling
>>> the whole point of an iommu.
>>>
>>> Now I know why my GPU is causing paging to disk! And why my RAID controller
>>> stalls for ages when I do a git log at the same time as a kernel build!
>>
>> The solution I have for this is that instead of trying to
>> dma_alloc_from_contiguous() firstly, call alloc_pages() in dma_alloc_coherent().
>> dma_alloc_from_contiguous() should be called only when alloc_pages() is failed
>> or DMA_ATTR_FORCE_CONTIGUOUS is specified in dma_attr.
>
> Why is all this extra complexity being added when there are no X86 users
> of DMA_ATTR_FORCE_CONTIGUOUS?

I misunderstood DMA_ATTR_FORCE_CONTIGUOUS.  It is specified to request
that underlaying DMA mapping span physically contiguous with IOMMU.
But current alloc_dma_coherent() for intel-iommu always returns
physically contiguous memory, so it is ignored on x86.

>>> And the apparent goal of this patchset is to enable DMA allocation below
>>> 4GB, which is already supported in the existing page allocator with the
>>> GFP_DMA32 flag?!
>>
>> The goal of this patchset is to enable huge DMA allocation which
>> alloc_pages() can't (> MAX_ORDER) for the devices that require it.
>
> What x86 devices need > MAX_ORDER DMA allocation and why can't they allocate
> directly from dma_alloc_from_contiguous()?

I need this for UFS unified memory extension which is apparently not in
mainline for now.
http://www.jedec.org/standards-documents/docs/jesd220-1
http://www.jedec.org/sites/default/files/T_Fujisawa_MF_2013.pdf

But there must be some other use cases on x86, too.  Because I have
received several emails privately from developers who care its status.

And allocating directly from dma_alloc_from_contiguous() in the driver
doesn't work with IOMMU, as it just returns memory regoin and doesn't
create DMA mapping.
