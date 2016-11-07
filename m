From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] swiotlb: Add swiotlb=nobounce debug option
Date: Mon, 7 Nov 2016 17:18:27 +0000
Message-ID: <88790a4d-3287-3feb-d6f5-ec43ccaf9aed@arm.com>
References: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
	<1477928704-10611-3-git-send-email-geert+renesas@glider.be>
	<86c57a18-cb28-8aee-9edb-96da73d4f829@arm.com>
	<CAMuHMdVJC6SF-66t0A1zUKQLeprjLD6X27r5iA7+6F3ii=ZBzQ@mail.gmail.com>
	<967ca71a-61c5-5585-16e7-990409088fa6@arm.com>
	<CAMuHMdUiVuZFG8T3US3D5EzBbXgW5VCoYypzAsQJEk4DgtyH5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdUiVuZFG8T3US3D5EzBbXgW5VCoYypzAsQJEk4DgtyH5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On 07/11/16 15:41, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Tue, Nov 1, 2016 at 12:46 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>>>>> To aid debugging and catch devices not supporting DMA to memory outside
>>>>> the 32-bit address space, add a kernel command line option
>>>>> "swiotlb=nobounce", which disables the use of bounce buffers.
>>>>> If specified, trying to map memory that cannot be used with DMA will
>>>>> fail, and a warning will be printed (rate-limited).
>>>>
>>>> This rationale seems questionable - how useful is non-deterministic
>>>> behaviour for debugging really? What you end up with is DMA sometimes
>>>> working or sometimes not depending on whether allocations happen to
>>>> naturally fall below 4GB or not. In my experience, that in itself can be
>>>> a pain in the arse to debug.
>>>
>>> It immediately triggered for me, though:
>>>
>>>     rcar-dmac e7300000.dma-controller: Cannot do DMA to address
>>> 0x000000067a9b7000
>>>     ravb e6800000.ethernet: Cannot do DMA to address 0x000000067aa07780
>>>
>>>> Most of the things you might then do to make things more deterministic
>>>> again (like making the default DMA mask tiny or hacking out all the
>>>> system's 32-bit addressable RAM) are also generally sufficient to make
>>>> DMA fail earlier and make this option moot anyway. What's the specific
>>>> use case motivating this?
>>>
>>> My use case is finding which drivers and DMA engines do not support 64-bit
>>> memory. There's more info in my series "[PATCH/RFC 0/5] arm64: r8a7796: 64-bit
>>> Memory and Ethernet Prototype"
>>> (https://www.mail-archive.com/linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg08393.html)
>>
>> Thanks for the context. I've done very similar things in the past, and
>> my first instinct would be to change the default DMA mask in
>> of_dma_configure() to something which can't reach RAM (e.g. <30 bits),
>> then instrument dma_set_mask() to catch cleverer drivers. That's a
>> straightforward way to get 100% coverage - the problem with simply
>> disabling bounce buffering is that whilst statistically it almost
>> certainly will catch >95% of cases, there will always be some that it
>> won't; if some driver only ever does a single dma_alloc_coherent() early
>> enough that allocations are still fairly deterministic, and always
>> happens to get a 32-bit address on that platform, it's likely to slip
>> through the net.
>>
>> I'm not against the idea of SWIOTLB growing a runtime-disable option,
>> I'm just not sure what situation it's actually the best solution for.
> 
> If I set the DMA mask to a small value, DMA is never used, and SWIOTLB
> always falls back to bounce buffers (and DMAing from the small pool)?

Not quite - I meant setting the default mask to a value small enough
that any attempt to allocate or map within it (whether bounced or
otherwise) cannot possibly succeed. Of course, if you have RAM right
down to address 0 this becomes trickier - I'm not entirely certain that
going to extremes (DMA_BIT_MASK(1), say) wouldn't end up going wrong
somewhere for misleadingly unrelated reasons - but I got the impression
from the mainline DT that RAM on your platform starts at 0x40000000,
hence the 30-bit suggestion.

At that point, you can instantly tell for certain that any driver for
which DMA starts failing is relying on the default mask and definitely
needs looking at for 64-bit support, and anything that doesn't just
needs a simple check of what it's passing to dma_set_*mask*().

Alternatively, the really bulletproof option is to get the firmware to
load the kernel into the >4GB area(s) of RAM (or hack dram_base in
handle_kernel_image() in arch/arm64/kernel/efi-stub.c) and simply remove
any 32-bit-addressable areas from the DT entirely (assuming the EFI
memory map isn't hard-coded). Then SWIOTLB becomes moot as there's
nowhere it can even allocate a usable bounce buffer.

> That's the inverse of what I want to achieve: I want to avoid using the
> bounce feature, to make sure the DMA engine is always used with whatever
> kind of memory.

As I said, it's that "always" that's the problem - there is already a
no-op path through the SWIOTLB code if the buffer happens to lie within
the device's DMA mask to start with, so just making SWIOTLB a no-op does
nothing to reveal anything sufficiently lucky to always hit that path on
current platforms.

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
