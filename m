From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] swiotlb: Add swiotlb=nobounce debug option
Date: Tue, 1 Nov 2016 11:46:59 +0000
Message-ID: <967ca71a-61c5-5585-16e7-990409088fa6@arm.com>
References: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
 <1477928704-10611-3-git-send-email-geert+renesas@glider.be>
 <86c57a18-cb28-8aee-9edb-96da73d4f829@arm.com>
 <CAMuHMdVJC6SF-66t0A1zUKQLeprjLD6X27r5iA7+6F3ii=ZBzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVJC6SF-66t0A1zUKQLeprjLD6X27r5iA7+6F3ii=ZBzQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 31/10/16 18:20, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Mon, Oct 31, 2016 at 6:41 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 31/10/16 15:45, Geert Uytterhoeven wrote:
>>> On architectures like arm64, swiotlb is tied intimately to the core
>>> architecture DMA support. In addition, ZONE_DMA cannot be disabled.
>>
>> To be fair, that only takes a single-character change in
>> arch/arm64/Kconfig - in fact, I'm amused to see my stupid patch to fix
>> the build if you do just that (86a5906e4d1d) has just had its birthday ;)
> 
> Unfortunately it's not that simple. Using a small patch (based on Mark Salter's
> "arm64: make CONFIG_ZONE_DMA user settable"), it appears to work. However:
>   - With CONFIG_ZONE_DMA=n and memory present over 4G, swiotlb_init() is
>     not called.
>     This will lead to a NULL pointer dereference later, when
>     dma_map_single() calls into an unitialized SWIOTLB subsystem through
>     swiotlb_tbl_map_single().
>   - With CONFIG_ZONE_DMA=n and no memory present over 4G, swiotlb_init()
>     is also not called, but RAVB works fine.
> Disabling CONFIG_SWIOTLB is non-trivial, as the arm64 DMA core always
> uses swiotlb_dma_ops, and its operations depend a lot on SWIOTLB
> helpers.
> 
> So that's why I went for this option.

OK, that's new to me - I guess this behaviour was introduced by
b67a8b29df7e ("arm64: mm: only initialize swiotlb when necessary").
Regardless of this patch, that check probably wants fixing to still do
the appropriate thing if arm64_dma_phys_limit is above 4GB (or just
depend on ZONE_DMA). Disabling ZONE_DMA for development doesn't seem
that unreasonable a thing to do, especially if there are ready-made
patches floating around already, so having it crash the kernel in ways
it didn't before isn't ideal.

>>> To aid debugging and catch devices not supporting DMA to memory outside
>>> the 32-bit address space, add a kernel command line option
>>> "swiotlb=nobounce", which disables the use of bounce buffers.
>>> If specified, trying to map memory that cannot be used with DMA will
>>> fail, and a warning will be printed (rate-limited).
>>
>> This rationale seems questionable - how useful is non-deterministic
>> behaviour for debugging really? What you end up with is DMA sometimes
>> working or sometimes not depending on whether allocations happen to
>> naturally fall below 4GB or not. In my experience, that in itself can be
>> a pain in the arse to debug.
> 
> It immediately triggered for me, though:
> 
>     rcar-dmac e7300000.dma-controller: Cannot do DMA to address
> 0x000000067a9b7000
>     ravb e6800000.ethernet: Cannot do DMA to address 0x000000067aa07780
> 
>> Most of the things you might then do to make things more deterministic
>> again (like making the default DMA mask tiny or hacking out all the
>> system's 32-bit addressable RAM) are also generally sufficient to make
>> DMA fail earlier and make this option moot anyway. What's the specific
>> use case motivating this?
> 
> My use case is finding which drivers and DMA engines do not support 64-bit
> memory. There's more info in my series "[PATCH/RFC 0/5] arm64: r8a7796: 64-bit
> Memory and Ethernet Prototype"
> (https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg08393.html)

Thanks for the context. I've done very similar things in the past, and
my first instinct would be to change the default DMA mask in
of_dma_configure() to something which can't reach RAM (e.g. <30 bits),
then instrument dma_set_mask() to catch cleverer drivers. That's a
straightforward way to get 100% coverage - the problem with simply
disabling bounce buffering is that whilst statistically it almost
certainly will catch >95% of cases, there will always be some that it
won't; if some driver only ever does a single dma_alloc_coherent() early
enough that allocations are still fairly deterministic, and always
happens to get a 32-bit address on that platform, it's likely to slip
through the net.

I'm not against the idea of SWIOTLB growing a runtime-disable option,
I'm just not sure what situation it's actually the best solution for.

Robin.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

