From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/4] iommu/pamu: Add support for generic iommu-device
Date: Wed, 23 Aug 2017 22:17:39 +1000
Message-ID: <878tiaxyu4.fsf@concordia.ellerman.id.au>
References: <1502290014-2890-1-git-send-email-joro@8bytes.org> <1502290014-2890-5-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502290014-2890-5-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: Varun.Sethi@freescale.com, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

Joerg Roedel <joro@8bytes.org> writes:

> From: Joerg Roedel <jroedel@suse.de>
>
> This patch adds a global iommu-handle to the pamu driver and
> initializes it at probe time. Also link devices added to the
> iommu to this handle.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/fsl_pamu.c        | 17 +++++++++++++++++
>  drivers/iommu/fsl_pamu.h        |  3 +++
>  drivers/iommu/fsl_pamu_domain.c |  5 ++++-
>  drivers/iommu/fsl_pamu_domain.h |  2 ++
>  4 files changed, 26 insertions(+), 1 deletion(-)

This seems to be causing my p5020ds to blow up with:

[    0.096728] Machine: fsl,P5020DS
[    0.096729] SoC family: QorIQ
[    0.096730] SoC ID: svr:0x82280020, Revision: 2.0
[    0.098143] Found FSL PCI host bridge at 0x0000000ffe200000. Firmware bus number: 0->0
[    0.098145] PCI host bridge /pcie@ffe200000  ranges:
[    0.098149]  MEM 0x0000000c00000000..0x0000000c1fffffff -> 0x00000000e0000000 
[    0.098151]   IO 0x0000000ff8000000..0x0000000ff800ffff -> 0x0000000000000000
[    0.098161] /pcie@ffe200000: PCICSRBAR @ 0xdf000000
[    0.098162] setup_pci_atmu: end of DRAM 100000000
[    0.098167] /pcie@ffe200000: Setup 64-bit PCI DMA window
[    0.098168] /pcie@ffe200000: DMA window size is 0xdf000000
[    0.098326] Found FSL PCI host bridge at 0x0000000ffe202000. Firmware bus number: 0->1
[    0.098327] PCI host bridge /pcie@ffe202000  ranges:
[    0.098330]  MEM 0x0000000c40000000..0x0000000c5fffffff -> 0x00000000e0000000 
[    0.098332]   IO 0x0000000ff8020000..0x0000000ff802ffff -> 0x0000000000000000
[    0.098340] /pcie@ffe202000: PCICSRBAR @ 0xdf000000
[    0.098340] setup_pci_atmu: end of DRAM 100000000
[    0.098345] /pcie@ffe202000: Setup 64-bit PCI DMA window
[    0.098346] /pcie@ffe202000: DMA window size is 0xdf000000
[    0.204289] iommu: Adding device ffe100300.dma to group 0
[    0.209606] Unable to handle kernel paging request for data at address 0x00000068
[    0.217059] Faulting instruction address: 0xc0000000002abe18
[    0.222703] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.228078] SMP NR_CPUS=24 
[    0.228080] CoreNet Generic
[    0.233634] Modules linked in:
[    0.236674] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc5-gcc-6.3.1-00004-g68a17f0be6fe #41
[    0.245613] task: c0000000f7168000 task.stack: c0000000f7170000
[    0.251515] NIP: c0000000002abe18 LR: c0000000002abf7c CTR: c000000000025dc8
[    0.258545] REGS: c0000000f7173400 TRAP: 0300   Not tainted  (4.13.0-rc5-gcc-6.3.1-00004-g68a17f0be6fe)
[    0.267919] MSR: 0000000080029000 <CE,EE,ME>
[    0.267924]   CR: 28adb242  XER: 20000000
[    0.276165] DEAR: 0000000000000068 ESR: 0000000000000000 SOFTE: 1 
[    0.276165] GPR00: c0000000002abf7c c0000000f7173680 c000000000fbf600 0000000000000000 
[    0.276165] GPR04: c000000000c6dc88 0000000000000000 c0000000f72e0190 0000000000000000 
[    0.276165] GPR08: c0000000f7168000 0000000000000000 0000000000000000 0000000000000038 
[    0.276165] GPR12: 0000000022adb444 c00000003fff5000 c000000000001b70 0000000000000000 
[    0.276165] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[    0.276165] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[    0.276165] GPR24: 0000000000000000 c000000000ef4f58 c000000000d3b408 c000000000c6dc88 
[    0.276165] GPR28: c000000000c6dc88 0000000000000000 0000000000000000 c000000000e3b658 
[    0.346218] NIP [c0000000002abe18] .kernfs_find_ns+0x30/0x148
[    0.351943] LR [c0000000002abf7c] .kernfs_find_and_get_ns+0x4c/0x7c
[    0.358192] Call Trace:
[    0.360624] [c0000000f7173680] [c0000000f7173710] 0xc0000000f7173710 (unreliable)
[    0.368088] [c0000000f7173710] [c0000000002abf7c] .kernfs_find_and_get_ns+0x4c/0x7c
[    0.375729] [c0000000f71737a0] [c0000000002b13c8] .sysfs_add_link_to_group+0x44/0x9c
[    0.383456] [c0000000f7173840] [c000000000591660] .iommu_device_link+0x70/0x144
[    0.390744] [c0000000f71738e0] [c0000000005942dc] .fsl_pamu_add_device+0x4c/0x80
[    0.398121] [c0000000f7173960] [c00000000058ce8c] .add_iommu_group+0x5c/0x9c
[    0.405153] [c0000000f71739e0] [c00000000059d6b8] .bus_for_each_dev+0x98/0xfc
[    0.412269] [c0000000f7173a80] [c00000000058f1a0] .bus_set_iommu+0xd8/0x11c
[    0.419218] [c0000000f7173b20] [c000000000d86998] .pamu_domain_init+0xb0/0xe0
[    0.426331] [c0000000f7173ba0] [c000000000d86864] .fsl_pamu_init+0xec/0x170
[    0.433276] [c0000000f7173c30] [c000000000001934] .do_one_initcall+0x68/0x1b8
[    0.440395] [c0000000f7173d00] [c000000000d440e4] .kernel_init_freeable+0x24c/0x324
[    0.448031] [c0000000f7173db0] [c000000000001b90] .kernel_init+0x20/0x140
[    0.454801] [c0000000f7173e30] [c0000000000009bc] .ret_from_kernel_thread+0x58/0x9c
[    0.462438] Instruction dump:
[    0.465390] 7c0802a6 fb81ffe0 f8010010 fba1ffe8 fbc1fff0 fbe1fff8 f821ff71 7c7e1b78 
[    0.473114] 7cbd2b78 7c9c2378 60000000 60000000 <a13e0068> 311dffff ebfe0048 552906b4 
[    0.481017] ---[ end trace 5d11d3e6c29380bd ]---


# first bad commit: [68a17f0be6feb8de1f5e26b93f49791031374c4c] iommu/pamu: Add support for generic iommu-device

commit 68a17f0be6feb8de1f5e26b93f49791031374c4c
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed Aug 9 16:36:00 2017 +0200
Commit:     Joerg Roedel <jroedel@suse.de>
CommitDate: Tue Aug 15 13:59:34 2017 +0200

    iommu/pamu: Add support for generic iommu-device
    
    This patch adds a global iommu-handle to the pamu driver and
    initializes it at probe time. Also link devices added to the
    iommu to this handle.
    
    Signed-off-by: Joerg Roedel <jroedel@suse.de>


cheers
