From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] Fix incorrect warning from dma-debug
Date: Mon, 9 May 2016 10:37:15 +0100
Message-ID: <57305A4B.70401@arm.com>
References: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org
Cc: joro@8bytes.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Niklas,

On 08/05/16 11:59, Niklas S=C3=B6derlund wrote:
> Hi,
>
> While using CONFIG_DMA_API_DEBUG i came across this warning which I
> think is a false positive. As shown dma_sync_single_for_device() are
> called from the dma_map_single() call path. This triggers the warning
> since the dma-debug code have not yet been made aware of the mapping.

Almost right ;) The thing being mapped (the SPI device's buffer) and th=
e=20
thing being synced (the IOMMU's PTE) are entirely unrelated. Due to the=
=20
current of_iommu_init() setup, the IOMMU is probed long before=20
dma_debug_init() gets called, therefore DMA debug is missing entries fo=
r=20
some of the initial page table mappings and gets confused when we updat=
e=20
them later.

> I try to solve this by introducing __dma_sync_single_for_device() whi=
ch
> do not call into the dma-debug code. I'm no expert and this might be =
a
> bad way of solving the problem but it allowed me to keep working.

The simple fix should be to just call dma_debug_init() from a=20
sufficiently earlier initcall level. The best would be to sort out a=20
proper device dependency order to avoid the whole early-IOMMU-creation=20
thing entirely.

Robin.

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at lib/dma-debug.c:1209 check_sync+0x154/0x5e4
> ipmmu-vmsa e6740000.mmu: DMA-API: device driver tries to sync DMA mem=
ory it has not allocated [device address=3D0x000000006e89b008] [size=3D=
8 bytes]
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc5-00012-g52e78c1-di=
rty #1
> Hardware name: Generic R8A7791 (Flattened Device Tree)
> Backtrace:
> [<c020a0a4>] (dump_backtrace) from [<c020a250>] (show_stack+0x18/0x1c=
)
>   r7:c03ebad0 r6:00000009 r5:60000093 r4:00000000
> [<c020a238>] (show_stack) from [<c03cb7e4>] (dump_stack+0x84/0xa4)
> [<c03cb760>] (dump_stack) from [<c021e3ac>] (__warn+0xd0/0x100)
>   r5:00000000 r4:ef05dac8
> [<c021e2dc>] (__warn) from [<c021e41c>] (warn_slowpath_fmt+0x40/0x48)
>   r9:00010000 r8:00000000 r7:c0c69c40 r6:c0c02754 r5:ef05db78 r4:ef22=
2810
> [<c021e3e0>] (warn_slowpath_fmt) from [<c03ebad0>] (check_sync+0x154/=
0x5e4)
>   r3:c0945b6f r2:c0936e85
> [<c03eb97c>] (check_sync) from [<c03ed594>] (debug_dma_sync_single_fo=
r_device+0x64/0x70)
>   r10:00000009 r9:0000000c r8:ee89b008 r7:00000000 r6:6e89b008 r5:000=
00000
>   r4:6e89b008
> [<c03ed530>] (debug_dma_sync_single_for_device) from [<c0465298>] (__=
arm_lpae_set_pte.part.0+0x80/0x8c)
>   r5:00000001 r4:ef222810
> [<c0465218>] (__arm_lpae_set_pte.part.0) from [<c046553c>] (__arm_lpa=
e_map+0x298/0x2f0)
>   r7:00000008 r6:ef25e000 r4:ee898500
> [<c04652a4>] (__arm_lpae_map) from [<c0465b18>] (arm_lpae_map+0xcc/0x=
e4)
>   r10:c0465f40 r9:00001000 r8:40000000 r7:00000000 r6:6f25c000 r5:000=
00000
>   r4:000008c0
> [<c0465a4c>] (arm_lpae_map) from [<c0465f78>] (ipmmu_map+0x38/0x40)
>   r7:40000000 r6:00000000 r5:00001000 r4:c0465a4c
> [<c0465f40>] (ipmmu_map) from [<c0463d90>] (iommu_map+0xf8/0x15c)
>   r4:ee895608
> [<c0463c98>] (iommu_map) from [<c0213524>] (arm_coherent_iommu_map_pa=
ge+0x1d4/0x2d4)
>   r10:ef386940 r9:00001000 r8:00000000 r7:00000000 r6:40000000 r5:000=
00000
>   r4:00000000
> [<c0213350>] (arm_coherent_iommu_map_page) from [<c0213690>] (arm_iom=
mu_map_page+0x6c/0x74)
>   r10:c0c61f44 r9:ef19d210 r8:00000001 r7:00001000 r6:00000000 r5:ec5=
ddb80
>   r4:00000000
> [<c0213624>] (arm_iommu_map_page) from [<c04f7d64>] (sh_msiof_spi_pro=
be+0x430/0x7b0)
>   r9:00000000 r8:c0213624 r7:ef19d210 r6:ef242800 r5:ef1b4010 r4:ef24=
2af0
> [<c04f7934>] (sh_msiof_spi_probe) from [<c049fd3c>] (platform_drv_pro=
be+0x58/0xa8)
>   r10:00000000 r9:00000000 r8:c0c1f8d4 r7:c0c7e910 r6:c0c1f8d4 r5:ef1=
b4010
>   r4:c04f7934
> [<c049fce4>] (platform_drv_probe) from [<c049e788>] (driver_probe_dev=
ice+0x13c/0x2a4)
>   r7:c0c7e910 r6:00000000 r5:c0c7e900 r4:ef1b4010
> [<c049e64c>] (driver_probe_device) from [<c049e978>] (__driver_attach=
+0x88/0xac)
>   r9:c0c34000 r8:c0a3c010 r7:c0c1cf08 r6:c0c1f8d4 r5:ef1b4044 r4:ef1b=
4010
> [<c049e8f0>] (__driver_attach) from [<c049ce44>] (bus_for_each_dev+0x=
74/0x98)
>   r7:c0c1cf08 r6:c049e8f0 r5:c0c1f8d4 r4:00000000
> [<c049cdd0>] (bus_for_each_dev) from [<c049ebd0>] (driver_attach+0x20=
/0x28)
>   r6:ef1cc200 r5:00000000 r4:c0c1f8d4
> [<c049ebb0>] (driver_attach) from [<c049d5d8>] (bus_add_driver+0xd4/0=
x1e4)
> [<c049d504>] (bus_add_driver) from [<c049f2dc>] (driver_register+0xa4=
/0xe8)
>   r7:c0a3c010 r6:00000000 r5:c0a1e400 r4:c0c1f8d4
> [<c049f238>] (driver_register) from [<c04a0778>] (__platform_driver_r=
egister+0x38/0x4c)
>   r5:c0a1e400 r4:ee958fc0
> [<c04a0740>] (__platform_driver_register) from [<c0a1e418>] (sh_msiof=
_spi_drv_init+0x18/0x20)
> [<c0a1e400>] (sh_msiof_spi_drv_init) from [<c0a00e1c>] (do_one_initca=
ll+0x10c/0x1c0)
> [<c0a00d10>] (do_one_initcall) from [<c0a00ff8>] (kernel_init_freeabl=
e+0x128/0x1f4)
>   r9:c0c34000 r8:c0c34000 r7:c0a47e60 r6:c0a3c83c r5:000000bd r4:0000=
0006
> [<c0a00ed0>] (kernel_init_freeable) from [<c071067c>] (kernel_init+0x=
10/0x118)
>   r9:00000000[    1.879529] ata1: link resume succeeded after 1 retri=
es
>   r8:00000000 r7:00000000 r6:00000000 r5:c071066c r4:00000000
> [<c071066c>] (kernel_init) from [<c0206e08>] (ret_from_fork+0x14/0x2c=
)
>   r5:c071066c r4:00000000
> ---[ end trace 6eb9a3df3009d491 ]---
>
> Niklas S=C3=B6derlund (2):
>    dma-mapping: add __dma_sync_single_for_device()
>    iommu/io-pgtable-arm: use __dma_sync_single_for_device()
>
>   drivers/iommu/io-pgtable-arm.c | 2 +-
>   include/linux/dma-mapping.h    | 9 ++++++++-
>   2 files changed, 9 insertions(+), 2 deletions(-)
>
> --
> 2.8.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
