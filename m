From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Tue, 13 Sep 2016 14:14:34 +0200
Message-ID: <92f27a6b-9752-516d-3924-c552fc6a5ace@redhat.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------81B67B7836AB8634AE86F2DB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1473695704.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------81B67B7836AB8634AE86F2DB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi Robin

On 12/09/2016 18:13, Robin Murphy wrote:
> Hi all,
> 
> To any more confusing fixups and crazily numbered extra patches, here's
> a quick v7 with everything rebased into the right order. The significant
> change this time is to implement iommu_fwspec properly from the start,
> which ends up being far simpler and more robust than faffing about
> introducing it somewhere 'less intrusive' to move toward core code later.
> 
> New branch in the logical place:
> 
> git://linux-arm.org/linux-rm iommu/generic-v7
I just tested your branch on AMD overdrive *without* updating the device
tree description according to the new syntax and I get a kernel oops.
See logs attached. Continuing my investigations ...

Best Regards

Eric
> 
> Robin.
> 
> Mark Rutland (1):
>   Docs: dt: add PCI IOMMU map bindings
> 
> Robin Murphy (21):
>   of/irq: Break out msi-map lookup (again)
>   iommu/of: Handle iommu-map property for PCI
>   iommu: Introduce iommu_fwspec
>   Docs: dt: document ARM SMMUv3 generic binding usage
>   iommu/arm-smmu: Fall back to global bypass
>   iommu/arm-smmu: Implement of_xlate() for SMMUv3
>   iommu/arm-smmu: Support non-PCI devices with SMMUv3
>   iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
>   iommu/arm-smmu: Handle stream IDs more dynamically
>   iommu/arm-smmu: Consolidate stream map entry state
>   iommu/arm-smmu: Keep track of S2CR state
>   iommu/arm-smmu: Refactor mmu-masters handling
>   iommu/arm-smmu: Streamline SMMU data lookups
>   iommu/arm-smmu: Add a stream map entry iterator
>   iommu/arm-smmu: Intelligent SMR allocation
>   iommu/arm-smmu: Convert to iommu_fwspec
>   Docs: dt: document ARM SMMU generic binding usage
>   iommu/arm-smmu: Wire up generic configuration support
>   iommu/arm-smmu: Set domain geometry
>   iommu/dma: Add support for mapping MSIs
>   iommu/dma: Avoid PCI host bridge windows
> 
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   8 +-
>  .../devicetree/bindings/iommu/arm,smmu.txt         |  63 +-
>  .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++
>  arch/arm64/mm/dma-mapping.c                        |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_iommu.h          |   2 +-
>  drivers/iommu/Kconfig                              |   2 +-
>  drivers/iommu/arm-smmu-v3.c                        | 386 +++++----
>  drivers/iommu/arm-smmu.c                           | 962 ++++++++++-----------
>  drivers/iommu/dma-iommu.c                          | 161 +++-
>  drivers/iommu/iommu.c                              |  56 ++
>  drivers/iommu/of_iommu.c                           |  52 +-
>  drivers/irqchip/irq-gic-v2m.c                      |   3 +
>  drivers/irqchip/irq-gic-v3-its.c                   |   3 +
>  drivers/of/irq.c                                   |  78 +-
>  drivers/of/of_pci.c                                | 102 +++
>  include/linux/device.h                             |   3 +
>  include/linux/dma-iommu.h                          |  12 +-
>  include/linux/iommu.h                              |  38 +
>  include/linux/of_pci.h                             |  10 +
>  19 files changed, 1323 insertions(+), 791 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
> 




--------------81B67B7836AB8634AE86F2DB
Content-Type: text/plain; charset=UTF-8;
 name="robin2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="robin2.txt"

[    3.185447] CPU features: detected feature: 32-bit EL0 Support
[    3.185455] CPU: All CPU(s) started at EL2
[    3.185475] alternatives: patching kernel code
[    3.188549] devtmpfs: initialized
[    3.189484] SMBIOS 3.0.0 present.
[    3.189570] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    3.189750] pinctrl core: initialized pinctrl subsystem
[    3.190113] NET: Registered protocol family 16
[    3.205134] cpuidle: using governor menu
[    3.205292] arm-smmu: deprecated "mmu-masters" DT property in use; DMA API support unavailable
[    3.205319] arm-smmu e0600000.smmu: probing hardware configuration...
[    3.205326] arm-smmu e0600000.smmu: SMMUv1 with:
[    3.205334] arm-smmu e0600000.smmu: 	stage 2 translation
[    3.205341] arm-smmu e0600000.smmu: 	non-coherent table walk
[    3.205348] arm-smmu e0600000.smmu: 	(IDR0.CTTW overridden by dma-coherent property)
[    3.205358] arm-smmu e0600000.smmu: 	stream matching with 32 register groups, mask 0x7fff
[    3.205369] arm-smmu e0600000.smmu: 	8 context banks (8 stage-2 only)
[    3.205377] arm-smmu e0600000.smmu: 	Supported page sizes: 0x60211000
[    3.205384] arm-smmu e0600000.smmu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    3.205489] arm-smmu: deprecated "mmu-masters" DT property in use; DMA API support unavailable
[    3.205512] arm-smmu e0800000.smmu: probing hardware configuration...
[    3.205519] arm-smmu e0800000.smmu: SMMUv1 with:
[    3.205525] arm-smmu e0800000.smmu: 	stage 2 translation
[    3.205533] arm-smmu e0800000.smmu: 	non-coherent table walk
[    3.205539] arm-smmu e0800000.smmu: 	(IDR0.CTTW overridden by dma-coherent property)
[    3.205550] arm-smmu e0800000.smmu: 	stream matching with 32 register groups, mask 0x7fff
[    3.205560] arm-smmu e0800000.smmu: 	8 context banks (8 stage-2 only)
[    3.205567] arm-smmu e0800000.smmu: 	Supported page sizes: 0x60211000
[    3.205574] arm-smmu e0800000.smmu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    3.205670] arm-smmu: deprecated "mmu-masters" DT property in use; DMA API support unavailable
[    3.205692] arm-smmu e0a00000.smmu: probing hardware configuration...
[    3.205699] arm-smmu e0a00000.smmu: SMMUv1 with:
[    3.205705] arm-smmu e0a00000.smmu: 	stage 2 translation
[    3.205712] arm-smmu e0a00000.smmu: 	non-coherent table walk
[    3.205719] arm-smmu e0a00000.smmu: 	(IDR0.CTTW overridden by dma-coherent property)
[    3.205729] arm-smmu e0a00000.smmu: 	stream matching with 32 register groups, mask 0x7fff
[    3.205738] arm-smmu e0a00000.smmu: 	8 context banks (8 stage-2 only)
[    3.205745] arm-smmu e0a00000.smmu: 	Supported page sizes: 0x60211000
[    3.205752] arm-smmu e0a00000.smmu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    3.205801] vdso: 2 pages (1 code @ ffff0000088c6000, 1 data @ ffff000008dd4000)
[    3.205814] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    3.206098] DMA: preallocated 256 KiB pool for atomic allocations
[    3.206186] Serial: AMBA PL011 UART driver
[    3.207040] e1010000.serial: ttyAMA0 at MMIO 0xe1010000 (irq = 20, base_baud = 0) is a PL011 rev3
[    3.995110] console [ttyAMA0] enabled
[    3.999198] OF: amba_device_add() failed (-19) for /smb/gpio@e0020000
[    4.006287] iommu: Adding device e0700000.xgmac to group 0
[    4.027943] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    4.034596] ACPI: Interpreter disabled.
[    4.038537] Unable to handle kernel paging request at virtual address ffffff8030010000
[    4.046452] pgd = ffff000008f61000
[    4.049845] [ffffff8030010000] *pgd=0000000000000000
[    4.054807] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    4.060371] Modules linked in:
[    4.063419] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc4-26782-g83cf8c5 #14
[    4.070982] Hardware name: Default string Default string/Default string, BIOS WOD5527X 05/25/2015
[    4.079846] task: ffff8003ec108000 task.stack: ffff8003ec110000
[    4.085761] PC is at __arm_v7s_map+0x1cc/0x378
[    4.090196] LR is at __arm_v7s_map+0xb4/0x378
[    4.094543] pc : [<ffff000008522604>] lr : [<ffff0000085224ec>] pstate: 20000045
[    4.101931] sp : ffff8003ec113bf0
[    4.105236] x29: ffff8003ec113bf0 x28: 0000000000001000 
[    4.110543] x27: ffffff8030010000 x26: ffff8003eb47e518 
[    4.115850] x25: 0000000000000001 x24: ffffff8030010004 
[    4.121155] x23: 000000000000000c x22: ffff8003eb47e500 
[    4.126461] x21: 0000000000001000 x20: 0000000000000000 
[    4.131767] x19: ffffff8030010000 x18: 000000000000000e 
[    4.137072] x17: 00000000000040ff x16: 0000000000000000 
[    4.142379] x15: 000000000000008c x14: 0000000000000006 
[    4.147684] x13: 0000000000000007 x12: 0000000000000020 
[    4.152990] x11: 0000000000000003 x10: ffff000008dd6000 
[    4.158295] x9 : 0000000000000004 x8 : 0000000000000e71 
[    4.163601] x7 : ffffff8030010000 x6 : ffffff8030010000 
[    4.168907] x5 : 0000000000000002 x4 : 0000000000000000 
[    4.174212] x3 : 0000000000000001 x2 : 0000000000000001 
[    4.179518] x1 : 0000000000000e7d x0 : 0000000000000004 
[    4.184824] 
[    4.186306] Process swapper/0 (pid: 1, stack limit = 0xffff8003ec110020)
[    4.192998] Stack: (0xffff8003ec113bf0 to 0xffff8003ec114000)
[    4.198735] 3be0:                                   ffff8003ec113c70 ffff0000085224ec
[    4.206558] 3c00: 0000000000001000 0000000000000000 0000000000000000 ffff8003eb47e500
[    4.214381] 3c20: 0000000000000014 0000000000001000 0000000000000000 ffff8003eb47e518
[    4.222203] 3c40: ffff800030008000 0000000000001000 0000000000000000 ffff8003eb47e518
[    4.230026] 3c60: ffff8003ec113c70 ffffff8030010000 ffff8003ec113cf0 ffff0000085227f8
[    4.237848] 3c80: ffff8003eb47e568 0000000000001000 0000000000000000 000000000000002a
[    4.245671] 3ca0: 0000000000000001 0000000000001000 0000000000000001 ffff8003ec113d88
[    4.253493] 3cc0: ffff8003ec113d80 0000000000001000 0000000000000002 000000000000000f
[    4.261315] 3ce0: ffff800030010000 ffff000008bc2520 ffff8003ec113d20 ffff000008d0036c
[    4.269137] 3d00: ffff8003eb47e568 000000000000000c 0000000000000000 000000000000002a
[    4.276960] 3d20: ffff8003ec113dd0 ffff00000808335c ffff000008d0019c ffff8003ec110000
[    4.284782] 3d40: 0000000000000000 ffff000008f1c000 ffff000008cc0498 ffff000008cad0a0
[    4.292605] 3d60: ffff000008d2ab20 ffff000008f1c000 0000000000000109 0000000000000000
[    4.300427] 3d80: 0000000000000001 0000000001111000 0000002000000020 ffff000008e750b0
[    4.308249] 3da0: 0000000000000000 000000003000806a 4000400000000020 00000000800b8204
[    4.316072] 3dc0: 0000000000000000 0000000000000000 ffff8003ec113e40 ffff000008cc0d54
[    4.323894] 3de0: ffff000008d95df0 ffff000008d2aa70 0000000000000004 ffff000008f1c000
[    4.331717] 3e00: ffff8003ec113e00 ffff000008ef8f38 0000000000000000 0000000400000004
[    4.339539] 3e20: ffff000008ef8ec0 0000000000000000 ffff000008cc0498 ffff000008cad0a0
[    4.347361] 3e40: ffff8003ec113ea0 ffff0000088a7f88 ffff0000088a7f78 0000000000000000
[    4.355183] 3e60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.363006] 3e80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.370828] 3ea0: 0000000000000000 ffff000008082e90 ffff0000088a7f78 0000000000000000
[    4.378650] 3ec0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.386473] 3ee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.394295] 3f00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.402117] 3f20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.409940] 3f40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.417762] 3f60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.425584] 3f80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.433406] 3fa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.441229] 3fc0: 0000000000000000 0000000000000005 0000000000000000 0000000000000000
[    4.449051] 3fe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    4.456873] Call trace:
[    4.459310] Exception stack(0xffff8003ec113a20 to 0xffff8003ec113b50)
[    4.465742] 3a20: ffffff8030010000 0001000000000000 ffff8003ec113bf0 ffff000008522604
[    4.473565] 3a40: 0000000002088021 ffff8003eb47e518 ffff8003fff4db00 ffff8003ffe81400
[    4.481388] 3a60: ffff000008dd5000 0208802100008001 0000000000000000 0000000000000000
[    4.489210] 3a80: ffff8003ec113b80 ffff00000820247c 0000000000000040 0000000000000000
[    4.497032] 3aa0: ffff8003ec110000 0000000000000003 0000000002088021 ffff000008521cbc
[    4.504854] 3ac0: 0000000000000004 0000000000000e7d 0000000000000001 0000000000000001
[    4.512677] 3ae0: 0000000000000000 0000000000000002 ffffff8030010000 ffffff8030010000
[    4.520499] 3b00: 0000000000000e71 0000000000000004 ffff000008dd6000 0000000000000003
[    4.528321] 3b20: 0000000000000020 0000000000000007 0000000000000006 000000000000008c
[    4.536143] 3b40: 0000000000000000 00000000000040ff
[    4.541012] [<ffff000008522604>] __arm_v7s_map+0x1cc/0x378
[    4.546489] [<ffff0000085224ec>] __arm_v7s_map+0xb4/0x378
[    4.551879] [<ffff0000085227f8>] arm_v7s_map+0x48/0xc4
[    4.557010] [<ffff000008d0036c>] arm_v7s_do_selftests+0x1d0/0x4b4
[    4.563096] [<ffff00000808335c>] do_one_initcall+0x38/0x12c
[    4.568662] [<ffff000008cc0d54>] kernel_init_freeable+0x1a8/0x24c
[    4.574748] [<ffff0000088a7f88>] kernel_init+0x10/0xfc
[    4.579878] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[    4.585181] Code: aa1b03f3 8b180378 f9003fa7 710004bf (b9400266) 
[    4.591280] ---[ end trace d091d1618c2826ea ]---
[    4.595897] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    4.595897] 
[    4.605024] SMP: stopping secondary CPUs
[    4.608942] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    4.608942] 


--------------81B67B7836AB8634AE86F2DB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
