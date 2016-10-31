From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] swiotlb: Add swiotlb=nobounce debug option
Date: Mon, 31 Oct 2016 19:20:50 +0100
Message-ID: <CAMuHMdVJC6SF-66t0A1zUKQLeprjLD6X27r5iA7+6F3ii=ZBzQ@mail.gmail.com>
References: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
 <1477928704-10611-3-git-send-email-geert+renesas@glider.be> <86c57a18-cb28-8aee-9edb-96da73d4f829@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86c57a18-cb28-8aee-9edb-96da73d4f829@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Mon, Oct 31, 2016 at 6:41 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 31/10/16 15:45, Geert Uytterhoeven wrote:
>> On architectures like arm64, swiotlb is tied intimately to the core
>> architecture DMA support. In addition, ZONE_DMA cannot be disabled.
>
> To be fair, that only takes a single-character change in
> arch/arm64/Kconfig - in fact, I'm amused to see my stupid patch to fix
> the build if you do just that (86a5906e4d1d) has just had its birthday ;)

Unfortunately it's not that simple. Using a small patch (based on Mark Salter's
"arm64: make CONFIG_ZONE_DMA user settable"), it appears to work. However:
  - With CONFIG_ZONE_DMA=n and memory present over 4G, swiotlb_init() is
    not called.
    This will lead to a NULL pointer dereference later, when
    dma_map_single() calls into an unitialized SWIOTLB subsystem through
    swiotlb_tbl_map_single().
  - With CONFIG_ZONE_DMA=n and no memory present over 4G, swiotlb_init()
    is also not called, but RAVB works fine.
Disabling CONFIG_SWIOTLB is non-trivial, as the arm64 DMA core always
uses swiotlb_dma_ops, and its operations depend a lot on SWIOTLB
helpers.

So that's why I went for this option.

>> To aid debugging and catch devices not supporting DMA to memory outside
>> the 32-bit address space, add a kernel command line option
>> "swiotlb=nobounce", which disables the use of bounce buffers.
>> If specified, trying to map memory that cannot be used with DMA will
>> fail, and a warning will be printed (rate-limited).
>
> This rationale seems questionable - how useful is non-deterministic
> behaviour for debugging really? What you end up with is DMA sometimes
> working or sometimes not depending on whether allocations happen to
> naturally fall below 4GB or not. In my experience, that in itself can be
> a pain in the arse to debug.

It immediately triggered for me, though:

    rcar-dmac e7300000.dma-controller: Cannot do DMA to address
0x000000067a9b7000
    ravb e6800000.ethernet: Cannot do DMA to address 0x000000067aa07780

> Most of the things you might then do to make things more deterministic
> again (like making the default DMA mask tiny or hacking out all the
> system's 32-bit addressable RAM) are also generally sufficient to make
> DMA fail earlier and make this option moot anyway. What's the specific
> use case motivating this?

My use case is finding which drivers and DMA engines do not support 64-bit
memory. There's more info in my series "[PATCH/RFC 0/5] arm64: r8a7796: 64-bit
Memory and Ethernet Prototype"
(https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg08393.html)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
