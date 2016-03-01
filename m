From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 1/3] iommu/io-pgtable: Add ARMv7 short descriptor support
Date: Tue, 1 Mar 2016 13:01:39 +0100
Message-ID: <CAMuHMdUH-_pxzjR2r7NAtv=Dc3SKGoy1L9UqETFD_6bXWMpKfg@mail.gmail.com>
References: <cover.1453723096.git.robin.murphy@arm.com>
	<066c4af0e29c9cc658bd5e48edc5e2d7ba7140a1.1453723096.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <066c4af0e29c9cc658bd5e48edc5e2d7ba7140a1.1453723096.git.robin.murphy@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, yong.wu@mediatek.com, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tue, Jan 26, 2016 at 6:13 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Add a nearly-complete ARMv7 short descriptor implementation, omitting
> only a few legacy and CPU-centric aspects which shouldn't be necessary
> for IOMMU API use anyway.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/Kconfig              |  19 +
>  drivers/iommu/Makefile             |   1 +
>  drivers/iommu/io-pgtable-arm-v7s.c | 849 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c         |   3 +
>  drivers/iommu/io-pgtable.h         |  14 +-
>  5 files changed, 885 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index a1e75cb..dc1aaa5 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -39,6 +39,25 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
>
>           If unsure, say N here.
>
> +config IOMMU_IO_PGTABLE_ARMV7S
> +       bool "ARMv7/v8 Short Descriptor Format"
> +       select IOMMU_IO_PGTABLE
> +       depends on HAS_DMA && (ARM || ARM64 || COMPILE_TEST)
> +       help
> +         Enable support for the ARM Short-descriptor pagetable format.
> +         This supports 32-bit virtual and physical addresses mapped using
> +         2-level tables with 4KB pages/1MB sections, and contiguous entries
> +         for 64KB pages/16MB supersections if indicated by the IOMMU driver.
> +
> +config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
> +       bool "ARMv7s selftests"
> +       depends on IOMMU_IO_PGTABLE_ARMV7S
> +       help
> +         Enable self-tests for ARMv7s page table allocator. This performs
> +         a series of page-table consistency checks during boot.
> +
> +         If unsure, say N here.
> +

When enabling IOMMU_IO_PGTABLE_ARMV7S_SELFTEST on r8a7791 (dual Cortex A15),
the kernel crashes with:

kernel BUG at mm/slab.c:2536!
Internal error: Oops - BUG: 0 [#1] SMP ARM
Modules linked in:[    1.299311] Modules linked in:

CPU: 1 PID: 1 Comm: swapper/0 Not tainted
4.5.0-rc6-koelsch-05892-ge7e45ad53ab6795e #2270
Hardware name: Generic R8A7791 (Flattened Device Tree)
task: ef422040 ti: ef442000 task.ti: ef442000
PC is at cache_alloc_refill+0x2a0/0x530
LR is at _raw_spin_unlock+0x8/0xc
pc : [<c02c6928>]    lr : [<c067f97c>]    psr: 00000093
sp : ef443d88  ip : d0a7b1f0  fp : 02000020
r10: 00000010  r9 : 00000000  r8 : 02088020
r7 : 00000000  r6 : ef5172c0  r5 : 00000000  r4 : ef5d7f40
r3 : 00004001  r2 : 00000001  r1 : 00020001  r0 : ef5172c0
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 30c5387d  Table: 40003000  DAC: 55555555
Process swapper/0 (pid: 1, stack limit = 0xef442210)
Stack: (0xef443d88 to 0xef444000)
3d80:                   ef48b4c0 00000000 ef5172d0 c0e38280 00000000 00001000
3da0: 02088020 60000013 ef5d7f40 c0445010 00000000 ef517340 00001000 c02c6630
3dc0: 00000008 00001000 00000000 00000400 00000002 c04444bc 00000000 00000000
3de0: 024000c0 ef517340 00000000 00004000 00000001 00000001 c0e3b000 ef517340
3e00: 00000000 00001000 00000000 ef5f8000 ef517340 c0445010 00000000 0000000f
3e20: 00001000 c0444e1c 00000000 00000000 ef517350 00000000 ef520f15 ef517340
3e40: ef443ea0 ef517390 00000000 00000000 00001000 c0445010 00000000 ef517390
3e60: 00001000 c0445044 00001000 0000000f ef5f8000 ef443ea0 c0e92a00 c0e92a00
3e80: 00000000 00000000 0000000c c0c18ee4 00001000 0000000f 00000001 00000014
3ea0: 00000001 01111000 00000020 00000020 c0e25bc8 00000000 6f5f806a 00000000
3ec0: 00000020 40004000 800b8204 00000000 00000000 00000000 00000000 00000000
3ee0: c0c3ce94 ef520f00 c0c18da4 00000000 c0e05550 c0e05550 c0e3b000 c0c2d848
3f00: 00000000 c0201760 ef5036c0 c0804b44 c0e5fdd0 00000000 c0e0be00 c0e0be7c
3f20: 00000000 60000013 00000000 efffec51 efffec59 c023893c c09dc204 00000004
3f40: 00000004 c09dce98 000000a0 c09dce98 c0e09e78 00000004 c0c2d834 00000004
3f60: c0c2d838 000000a1 c0c3ce94 c0e3b000 c0e3b000 c0c00d4c 00000004 00000004
3f80: 00000000 c0c0058c 00000000 c067a35c 00000000 00000000 00000000 00000000
3fa0: 00000000 c067a364 00000000 c0206b68 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ef443ff4 00000000
[<c02c6928>] (cache_alloc_refill) from [<c02c6630>] (kmem_cache_alloc+0x7c/0xd4)
[<c02c6630>] (kmem_cache_alloc) from [<c04444bc>]
(__arm_v7s_alloc_table+0x5c/0x278)
[<c04444bc>] (__arm_v7s_alloc_table) from [<c0444e1c>]
(__arm_v7s_map.constprop.6+0x68/0x25c)
[<c0444e1c>] (__arm_v7s_map.constprop.6) from [<c0445044>]
(arm_v7s_map+0x34/0xa4)
[<c0445044>] (arm_v7s_map) from [<c0c18ee4>] (arm_v7s_do_selftests+0x140/0x418)
[<c0c18ee4>] (arm_v7s_do_selftests) from [<c0201760>]
(do_one_initcall+0x100/0x1b4)
[<c0201760>] (do_one_initcall) from [<c0c00d4c>]
(kernel_init_freeable+0x120/0x1e8)
[<c0c00d4c>] (kernel_init_freeable) from [<c067a364>] (kernel_init+0x8/0xec)
[<c067a364>] (kernel_init) from [<c0206b68>] (ret_from_fork+0x14/0x2c)
Code: 1a000003 e7f001f2 e3130001 0a000000 (e7f001f2)
---[ end trace 190f6f6b84352efd ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

I don't know if r8a7791 supports v7s. Still, I don't expect a crash.
The LPAE selftest runs fine.

On r8a7795 (arm64), both the LPAE and V7S selftests run fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
