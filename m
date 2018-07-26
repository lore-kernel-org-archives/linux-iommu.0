From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 0/7] Stop losing firmware-set DMA masks
Date: Thu, 26 Jul 2018 18:45:57 -0500
Message-ID: <c73bc8d2-b745-ff31-1949-7a59ab04ede6@ti.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1532382222.git.robin.murphy@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de, m.szyprowski@samsung.com
Cc: lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org



On 07/23/2018 05:16 PM, Robin Murphy wrote:
> Whilst the common firmware code invoked by dma_configure() initialises
> devices' DMA masks according to limitations described by the respective
> properties ("dma-ranges" for OF and _DMA/IORT for ACPI), the nature of
> the dma_set_mask() API leads to that information getting lost when
> well-behaved drivers probe and set a 64-bit mask, since in general
> there's no way to tell the difference between a firmware-described mask
> (which should be respected) and whatever default may have come from the
> bus code (which should be replaced outright). This can break DMA on
> systems with certain IOMMU topologies (e.g. [1]) where the IOMMU driver
> only knows its maximum supported address size, not how many of those
> address bits might actually be wired up between any of its input
> interfaces and the associated DMA master devices. Similarly, some PCIe
> root complexes only have a 32-bit native interface on their host bridge,
> which leads to the same DMA-address-truncation problem in systems with a
> larger physical memory map and RAM above 4GB (e.g. [2]).
> 
> These patches attempt to deal with this in the simplest way possible by
> generalising the specific quirk for 32-bit bridges into an arbitrary
> mask which can then also be plumbed into the firmware code. In the
> interest of being minimally invasive, I've only included a point fix
> for the IOMMU issue as seen on arm64 - there may be further tweaks
> needed in DMA ops (e.g. in arch/arm/ and other OF users) to catch all
> possible incarnations of this problem, but at least any that I'm not
> fixing here have always been broken. It is also noteworthy that
> of_dma_get_range() has never worked properly for the way PCI host
> bridges are passed into of_dma_configure() - I'll be working on
> further patches to sort that out once this part is done.
> 
> Changes since v1 (RFC):
> - Pull in patch #1 (previously sent separately) to avoid conflicts
> - Fix up comment and silly build-breaking typo in patch #2
> - Add patches #6 and #7 since fiddling with coherent masks no longer
>    serves a reasonable purpose
> 
> Robin.
> 
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580804.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474443.html
> 
> Robin Murphy (7):
>    ACPI/IORT: Support address size limit for root complexes
>    dma-mapping: Generalise dma_32bit_limit flag
>    ACPI/IORT: Set bus DMA mask as appropriate
>    of/device: Set bus DMA mask as appropriate
>    iommu/dma: Respect bus DMA limit for IOVAs
>    ACPI/IORT: Don't set default coherent DMA mask
>    OF: Don't set default coherent DMA mask
> 
>   arch/x86/kernel/pci-dma.c |  2 +-
>   drivers/acpi/arm64/iort.c | 50 ++++++++++++++++++++++++++++-----------
>   drivers/iommu/dma-iommu.c |  3 +++
>   drivers/of/device.c       | 21 ++++++++--------
>   include/linux/device.h    |  6 ++---
>   kernel/dma/direct.c       |  6 ++---
>   6 files changed, 57 insertions(+), 31 deletions(-)
> 

With this series applied I can't boot TI ARM32 am574x-idk any more.

And log output is full of "DMA mask not set" - 
nobody sets dma_mask for platform bus in case of OF boot :(

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.18.0-rc6-00159-g0509411 (a0226610local@uda0226610) (gcc version 6.2.1 20161016 (Linaro GCC 6.2-2016.11)) #33 SMP PREEMPT Thu Jul 26 18:27:16 CDT 2018
[    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: TI AM5748 IDK
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] OMAP4: Map 0xffd00000 to (ptrval) for dram barrier
[    0.000000] DRA762 ES1.0
[    0.000000] random: get_random_bytes called from start_kernel+0xa4/0x44c with crng_init=0
[    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s36300 r8192 d21044 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522047
[    0.000000] Kernel command line: console=ttyO2,115200n8 root=PARTUUID=00028e44-02 rw rootfstype=ext4 rootwait
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 2062464K/2095100K available (8192K kernel code, 389K rwdata, 3008K rodata, 1024K init, 280K bss, 32636K reserved, 0K cma-reserved, 1308668K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (9184 kB)
[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 390 kB)
[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 281 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Tasks RCU enabled.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] OMAP clockevent source: timer1 at 32786 Hz
[    0.000000] arch_timer: cp15 timer(s) running at 6.14MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x16af5adb9, max_idle_ns: 440795202250 ns
[    0.000005] sched_clock: 56 bits at 6MHz, resolution 162ns, wraps every 4398046511023ns
[    0.000018] Switching to timer-based delay loop, resolution 162ns
[    0.000511] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000521] OMAP clocksource: 32k_counter at 32768 Hz
[    0.001182] Console: colour dummy device 80x30
[    0.001201] WARNING: Your 'console=ttyO2' has been replaced by 'ttyS2'
[    0.001210] This ensures that you still see kernel messages. Please
[    0.001217] update your kernel commandline.
[    0.001240] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.29 BogoMIPS (lpj=61475)
[    0.001256] pid_max: default: 32768 minimum: 301
[    0.001376] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001391] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001939] CPU: Testing write buffer coherency: ok
[    0.001979] CPU0: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.002199] /cpus/cpu@0 missing clock-frequency property
[    0.002219] /cpus/cpu@1 missing clock-frequency property
[    0.002232] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.059947] Setting up static identity map for 0x80100000 - 0x80100060
[    0.079947] Hierarchical SRCU implementation.
[    0.100678] EFI services will not be available.
[    0.120006] smp: Bringing up secondary CPUs ...
[    0.200303] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.200309] CPU1: Spectre v2: using ICIALLU workaround
[    0.200417] smp: Brought up 1 node, 2 CPUs
[    0.200429] SMP: Total of 2 processors activated (24.59 BogoMIPS).
[    0.200437] CPU: All CPU(s) started in HYP mode.
[    0.200444] CPU: Virtualization extensions available.
[    0.201571] devtmpfs: initialized
[    0.215574] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.215826] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.215844] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.215997] pinctrl core: initialized pinctrl subsystem
[    0.216497] DMI not present or invalid.
[    0.216771] NET: Registered protocol family 16
[    0.216974] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.217735] omap_hwmod: l3_main_2 using broken dt data from ocp
[    0.392284] cpuidle: using governor ladder
[    0.392343] cpuidle: using governor menu
[    0.393465] omap_l3_noc 44000000.ocp: DMA mask not set
[    0.399061] sram 40300000.ocmcram: DMA mask not set
[    0.401448] omap_gpio 4ae10000.gpio: DMA mask not set
[    0.401823] OMAP GPIO hardware version 0.1
[    0.402208] omap_gpio 48055000.gpio: DMA mask not set
[    0.402886] omap_gpio 48057000.gpio: DMA mask not set
[    0.403564] omap_gpio 48059000.gpio: DMA mask not set
[    0.404254] omap_gpio 4805b000.gpio: DMA mask not set
[    0.404936] omap_gpio 4805d000.gpio: DMA mask not set
[    0.405623] omap_gpio 48051000.gpio: DMA mask not set
[    0.406310] omap_gpio 48053000.gpio: DMA mask not set
[    0.420354] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.420366] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.420826] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    0.420838] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    0.421371] OMAP DMA hardware revision 0.0
[    0.421700] ti-dma-crossbar 4a002b78.dma-router: DMA mask not set
[    0.421802] ti-dma-crossbar 4a002c78.dma-router: DMA mask not set
[    0.431810] edma3-tptc 43400000.tptc: DMA mask not set
[    0.431901] edma3-tptc 43500000.tptc: DMA mask not set
[    0.432144] edma 43300000.edma: DMA mask not set
[    0.432412] edma 43300000.edma: memcpy is disabled
[    0.435720] edma 43300000.edma: TI EDMA DMA engine driver
[    0.436011] omap-dma-engine 4a056000.dma-controller: DMA mask not set
[    0.442720] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine driver (LinkedList1/2/3 supported)
[    0.443091] reg-fixed-voltage fixedregulator-vmain: DMA mask not set
[    0.443337] reg-fixed-voltage fixedregulator-v3_3d: DMA mask not set
[    0.443581] reg-fixed-voltage fixedregulator-vtt: DMA mask not set
[    0.445820] vgaarb: loaded
[    0.446189] SCSI subsystem initialized
[    0.446385] usbcore: registered new interface driver usbfs
[    0.446431] usbcore: registered new interface driver hub
[    0.446507] usbcore: registered new device driver usb
[    0.446937] omap_i2c 48070000.i2c: DMA mask not set
[    0.447598] palmas 0-0058: Irq flag is 0x00000004
[    0.472293] palmas 0-0058: Muxing GPIO 2f, PWM 0, LED 0
[    0.472601] palmas-pmic 48070000.i2c:tps659038@58:tps659038_pmic: DMA mask not set
[    0.474022] SMPS12: supplied by regulator-dummy
[    0.475755] SMPS3: supplied by VMAIN
[    0.477344] SMPS45: supplied by regulator-dummy
[    0.479225] SMPS6: supplied by VMAIN
[    0.480958] SMPS7: supplied by VMAIN
[    0.482836] SMPS8: supplied by VMAIN
[    0.484101] SMPS9: supplied by VMAIN
[    0.485083] LDO1: supplied by VMAIN
[    0.491108] random: fast init done
[    0.491263] LDO2: supplied by VMAIN
[    0.501109] LDO3: supplied by VMAIN
[    0.511114] LDO4: supplied by VMAIN
[    0.521143] LDO5: supplied by regulator-dummy
[    0.521843] LDO6: supplied by regulator-dummy
[    0.522527] LDO7: supplied by regulator-dummy
[    0.523213] LDO8: supplied by regulator-dummy
[    0.523897] LDO9: supplied by VMAIN
[    0.531479] LDOLN: supplied by VMAIN
[    0.541163] LDOUSB: supplied by VMAIN
[    0.553102] palmas-gpio 48070000.i2c:tps659038@58:tps659038_gpio: DMA mask not set
[    0.553691] omap_i2c 48070000.i2c: bus 0 rev0.12 at 400 kHz
[    0.554326] pps_core: LinuxPPS API ver. 1 registered
[    0.554335] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.554357] PTP clock support registered
[    0.554390] EDAC MC: Ver: 3.0.0
[    0.561084] omap-mailbox 48840000.mailbox: DMA mask not set
[    0.561294] omap-mailbox 48840000.mailbox: omap mailbox rev 0x400
[    0.561355] omap-mailbox 48842000.mailbox: DMA mask not set
[    0.561544] omap-mailbox 48842000.mailbox: omap mailbox rev 0x400
[    0.562538] clocksource: Switched to clocksource arch_sys_counter
[    0.570174] NET: Registered protocol family 2
[    0.570753] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
[    0.570782] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.570846] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.570973] TCP: Hash tables configured (established 8192 bind 8192)
[    0.571042] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.571076] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.571220] NET: Registered protocol family 1
[    0.591632] RPC: Registered named UNIX socket transport module.
[    0.591642] RPC: Registered udp transport module.
[    0.591651] RPC: Registered tcp transport module.
[    0.591659] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.592486] armv7-pmu pmu: DMA mask not set
[    0.592596] hw perfevents: no interrupt-affinity property for /pmu, guessing.
[    0.592799] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
[    0.595801] Initialise system trusted keyrings
[    0.595951] workingset: timestamp_bits=14 max_order=19 bucket_order=5
[    0.600094] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.600562] NFS: Registering the id_resolver key type
[    0.600592] Key type id_resolver registered
[    0.600601] Key type id_legacy registered
[    0.600639] ntfs: driver 2.1.32 [Flags: R/O].
[    0.600959] pstore: using deflate compression
[    2.241627] Key type asymmetric registered
[    2.241639] Asymmetric key parser 'x509' registered
[    2.241688] bounce: pool size: 64 pages
[    2.241746] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    2.241756] io scheduler noop registered
[    2.241765] io scheduler deadline registered
[    2.241925] io scheduler cfq registered (default)
[    2.241935] io scheduler mq-deadline registered
[    2.241945] io scheduler kyber registered
[    2.242270] omap-ocp2scp 4a090000.ocp2scp: DMA mask not set
[    2.242944] omap-ocp2scp 4a080000.ocp2scp: DMA mask not set
[    2.244311] ti-sysc 4a0dd038.target-module: DMA mask not set
[    2.244524] ti-sysc 4a0d9038.target-module: DMA mask not set
[    2.245282] omap-usb2 4a084000.phy: DMA mask not set
[    2.245810] omap-usb2 4a085000.phy: DMA mask not set
[    2.246549] ti-pipe3 4a096000.phy: DMA mask not set
[    2.246819] ti-pipe3 4a094000.pciephy: DMA mask not set
[    2.247283] ti-pipe3 4a084400.phy: DMA mask not set
[    2.247819] pinctrl-single 4a003400.pinmux: DMA mask not set
[    2.248335] pinctrl-single 4a003400.pinmux: 282 pins, size 1128
[    2.248829] ti-iodelay 4844a000.padconf: DMA mask not set
[    2.251593] dra7-pcie 51000000.pcie: DMA mask not set
[    2.251689] dra7-pcie 51000000.pcie: Linked as a consumer to phy-4a094000.pciephy.3
[    2.252065] dra7-pcie 51000000.pcie: Dropping the link to phy-4a094000.pciephy.3
[    2.255022] pbias-regulator 4a002e00.pbias_regulator: DMA mask not set
[    2.255243] V3_3D: supplied by smps9
[    2.255471] vtt_fixed: supplied by V3_3D
[    2.256033] ti_abb 4ae07ddc.regulator-abb-mpu: DMA mask not set
[    2.256335] ti_abb 4ae07e34.regulator-abb-ivahd: DMA mask not set
[    2.256625] ti_abb 4ae07e30.regulator-abb-dspeve: DMA mask not set
[    2.256901] ti_abb 4ae07de4.regulator-abb-gpu: DMA mask not set
[    2.298418] Serial: 8250/16550 driver, 10 ports, IRQ sharing enabled
[    2.301353] omap8250 48020000.serial: DMA mask not set
[    2.301973] 48020000.serial: ttyS2 at MMIO 0x48020000 (irq = 45, base_baud = 3000000) is a 8250
[    3.417323] console [ttyS2] enabled
[    3.421960] SuperH (H)SCI(F) driver initialized
[    3.426922] STM32 USART driver initialized
[    3.431660] omap_rng 48090000.rng: DMA mask not set
[    3.437010] omap_rng 48090000.rng: Random Number Generator ver. 20
[    3.452407] brd: module loaded
[    3.461634] loop: module loaded
[    3.466842] omap2_mcspi 480b8000.spi: DMA mask not set
[    3.472851] ti-qspi 4b300000.qspi: DMA mask not set
[    3.477852] ------------[ cut here ]------------
[    3.482502] WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 ti_qspi_probe+0x4a4/0x50c
[    3.491446] Modules linked in:
[    3.494540] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc6-00159-g0509411 #33
[    3.502232] Hardware name: Generic DRA74X (Flattened Device Tree)
[    3.508352] Backtrace: 
[    3.510820] [<c010c990>] (dump_backtrace) from [<c010cc60>] (show_stack+0x18/0x1c)
[    3.518425]  r7:00000009 r6:60000013 r5:00000000 r4:c0d5ea78
[    3.524117] [<c010cc48>] (show_stack) from [<c08a22a8>] (dump_stack+0x8c/0xa0)
[    3.531377] [<c08a221c>] (dump_stack) from [<c01304c0>] (__warn+0x104/0x11c)
[    3.538460]  r7:00000009 r6:c0b0dfa0 r5:00000000 r4:00000000
[    3.544151] [<c01303bc>] (__warn) from [<c01305f4>] (warn_slowpath_null+0x48/0x50)
[    3.551756]  r8:c0d04c48 r7:ee29da10 r6:c0609c74 r5:00000204 r4:c0b0dfa0
[    3.558492] [<c01305ac>] (warn_slowpath_null) from [<c0609c74>] (ti_qspi_probe+0x4a4/0x50c)
[    3.566881]  r6:ee29da10 r5:ee7e1b28 r4:ee7e1800
[    3.571525] [<c06097d0>] (ti_qspi_probe) from [<c0581f2c>] (platform_drv_probe+0x50/0xa4)
[    3.579741]  r10:00000000 r9:c0d47278 r8:00000000 r7:00000000 r6:c0d47278 r5:00000000
[    3.587605]  r4:ee29da10
[    3.590154] [<c0581edc>] (platform_drv_probe) from [<c0580234>] (driver_probe_device+0x24c/0x328)
[    3.599067]  r7:00000000 r6:c0d9d86c r5:c0d9d868 r4:ee29da10
[    3.604756] [<c057ffe8>] (driver_probe_device) from [<c05803f4>] (__driver_attach+0xe4/0xe8)
[    3.613232]  r10:00000007 r9:c0d04c48 r8:ffffe000 r7:c0d04c48 r6:ee29da44 r5:c0d47278
[    3.621099]  r4:ee29da10 r3:00000000
[    3.624698] [<c0580310>] (__driver_attach) from [<c057e320>] (bus_for_each_dev+0x70/0xbc)
[    3.632913]  r7:c0d04c48 r6:c0580310 r5:c0d47278 r4:00000000
[    3.638603] [<c057e2b0>] (bus_for_each_dev) from [<c057fb7c>] (driver_attach+0x24/0x28)
[    3.646644]  r7:00000000 r6:c0d42a38 r5:ed000700 r4:c0d47278
[    3.652331] [<c057fb58>] (driver_attach) from [<c057f530>] (bus_add_driver+0x108/0x214)
[    3.660372] [<c057f428>] (bus_add_driver) from [<c0580dfc>] (driver_register+0x80/0x114)
[    3.668499]  r7:00000000 r6:c0c2d5f4 r5:c0d617c0 r4:c0d47278
[    3.674187] [<c0580d7c>] (driver_register) from [<c0581e90>] (__platform_driver_register+0x48/0x50)
[    3.683271]  r5:c0d617c0 r4:c0d42a38
[    3.686868] [<c0581e48>] (__platform_driver_register) from [<c0c2d610>] (ti_qspi_driver_init+0x1c/0x20)
[    3.696300]  r5:c0d617c0 r4:c0d617c0
[    3.699894] [<c0c2d5f4>] (ti_qspi_driver_init) from [<c01026f0>] (do_one_initcall+0x5c/0x1a0)
[    3.708461] [<c0102694>] (do_one_initcall) from [<c0c00ff0>] (kernel_init_freeable+0x1cc/0x264)
[    3.717200]  r9:c0c00634 r8:000000ec r7:c0c4b834 r6:c0c66294 r5:c0d617c0 r4:c0d617c0
[    3.724981] [<c0c00e24>] (kernel_init_freeable) from [<c08b77c0>] (kernel_init+0x10/0x118)
[    3.733283]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c08b77b0
[    3.741144]  r4:00000000
[    3.743692] [<c08b77b0>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    3.751294] Exception stack(0xee083fb0 to 0xee083ff8)
[    3.756368] 3fa0:                                     00000000 00000000 00000000 00000000
[    3.764584] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.772797] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    3.779440]  r5:c08b77b0 r4:00000000
[    3.783063] ---[ end trace f28cf01bf78d8bab ]---
[    3.787705] ti-qspi 4b300000.qspi: coherent DMA mask is unset
[    3.793493] ti-qspi 4b300000.qspi: dma_alloc_coherent failed, using PIO mode
[    3.801088] Unable to handle kernel NULL pointer dereference at virtual address 00000080
[    3.809215] pgd = (ptrval)
[    3.811934] [00000080] *pgd=00000000
[    3.815531] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
[    3.821039] Modules linked in:
[    3.824114] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         4.18.0-rc6-00159-g0509411 #33
[    3.833197] Hardware name: Generic DRA74X (Flattened Device Tree)
[    3.839323] PC is at omap_dma_write+0x44/0x64
[    3.843702] LR is at omap_dma_start_desc+0x78/0x150
[    3.848601] pc : [<c04d87e8>]    lr : [<c04d8dc0>]    psr: 60000093
[    3.854895] sp : ee083570  ip : ee083580  fp : ee08357c
[    3.860141] r10: c0d04c48  r9 : ed002780  r8 : 00000000
[    3.865390] r7 : 00000010  r6 : ed000880  r5 : ed0008a8  r4 : ee2bdd00
[    3.871946] r3 : c0902038  r2 : 00000080  r1 : 00000003  r0 : 00005000
[    3.878502] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    3.885756] Control: 10c5387d  Table: 8000406a  DAC: 00000051
[    3.891527] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
[    3.897559] Stack: (0xee083570 to 0xee084000)
[    3.901936] 3560:                                     ee0835a4 ee083580 c04d8dc0 c04d87b0
[    3.910154] 3580: ee2bdd00 ee2bdd4c ee2bdd00 00000010 00000000 ed002780 ee0835c4 ee0835a8
[    3.918371] 35a0: c04d9028 c04d8d54 ee7e1b28 20000013 ee7e1b28 00000000 ee0835ec ee0835c8
[    3.926587] 35c0: c0608d1c c04d8fa4 00000003 c0604f78 ee7e1b28 00000000 00000001 00000010
[    3.934804] 35e0: ee08364c ee0835f0 c06090b0 c0608c9c 00000000 00000000 00000000 8afdf36c
[    3.943021] 3600: c01585e4 ee0837b8 ed002710 ee7e1b38 ed002780 00000001 00000001 8afdf36c
[    3.951237] 3620: ee08364c ee0837b8 c0d04c48 ed002710 ee7e1800 ee7e19d0 00000001 ee7e19b8
[    3.959453] 3640: ee0837b4 ee083650 c0606608 c0608dd8 c01741c4 c0173f5c 00000000 00000000
[    3.967670] 3660: ee08368c ee083670 c0174e98 c08bd740 ee7e1800 00000000 ee0837e4 ee7e1a34
[    3.975887] 3680: ee08369c ee083690 c0603808 c0174e58 ee0836c4 00000000 00000000 00000000
[    3.984103] 36a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.992319] 36c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.000534] 36e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.008750] 3700: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.016966] 3720: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.025181] 3740: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.033397] 3760: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.041613] 3780: 00000000 8afdf36c ee083784 00000010 ee7e2010 c0d04c48 00000010 8afdf36c
[    4.049831] 37a0: 00000000 00000000 ee083814 ee0837b8 c05d6f14 c0606574 ed005a01 ee0837e4
[    4.058047] 37c0: 00000103 00000000 00000000 00000000 c0600101 c0237801 00000000 00000010
[    4.066264] 37e0: ed002740 ee083850 ee08388c 8afdf36c 00000000 00000010 ed002740 ee7e2018
[    4.074481] 3800: 00000000 00000000 ee08384c ee083818 c05ed1bc c05d6e88 00000010 ed002740
[    4.082698] 3820: c0238614 00000010 ed002740 ee7e2018 ee083898 00000000 c09b0370 c09b0370
[    4.090914] 3840: ee083874 ee083850 c05ed750 c05ed150 ee083a00 c0d04c48 ee7e2018 0001008b
[    4.099131] 3860: eedec484 c09b0370 ee0839e4 ee083878 c05ed970 c05ed714 00000000 00000000
[    4.107346] 3880: 00000000 c05ef40c 00000100 ee7e1c00 ee083850 00000000 00000000 00000000
[    4.115563] 38a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.123778] 38c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.131994] 38e0: 00000000 00000000 02000000 00000000 00000100 0001008b 00030000 00010101
[    4.140210] 3900: 000b0800 00010101 00000000 00000000 003b0800 00010102 00000000 00000000
[    4.148427] 3920: 00000000 00000000 00000000 00000000 006b0800 00010104 00000000 00000000
[    4.156644] 3940: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.164859] 3960: 00000000 00000000 00000000 00000000 00000002 00010101 00000000 00000000
[    4.173075] 3980: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.181292] 39a0: 00000000 00000000 c05ef40c 00000000 80014d19 8afdf36c c07296b8 ee7e2018
[    4.189507] 39c0: ee7e1dac c0d04c48 ee7e1c00 eedec484 c09b0370 c09b0370 ee083afc ee0839e8
[    4.197724] 39e0: c05ee5a8 c05ed788 c07296b8 c08b1e64 eedf12b8 ee083b08 ee083a14 ee083a08
[    4.205941] 3a00: 02000000 00000000 00000100 0001008b 00030000 00010101 000b0800 00010101
[    4.214157] 3a20: 00000000 00000000 003b0800 00010102 00000000 00000000 00000000 00000000
[    4.222373] 3a40: 00000000 00000000 006b0800 00010104 00000000 00000000 00000000 00000000
[    4.230589] 3a60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.238805] 3a80: 00000000 00000000 00000002 00010101 00000000 00000000 00000000 00000000
[    4.247021] 3aa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.255237] 3ac0: c05ef40c 00000000 c0d04c48 8afdf36c 00000000 ee7e2010 ee7e1dac c0d04c48
[    4.263453] 3ae0: ed002710 00000000 ee7e2018 00000000 ee083b34 ee083b00 c05d7110 c05ee4a8
[    4.271670] 3b00: 00000000 00000000 00010083 8afdf36c ee7e1c00 c0d457cc c0d457bc 00000000
[    4.279886] 3b20: 00000000 c0d457cc ee083b4c ee083b38 c060699c c05d6f8c 00000000 ee7e1c00
[    4.288103] 3b40: ee083b6c ee083b50 c0603220 c060696c ee7e1c00 c0d9d868 c0d9d86c 00000000
[    4.296319] 3b60: ee083b9c ee083b70 c0580234 c060319c 00000000 c0d457cc ee083bf4 ee7e1c00
[    4.304536] 3b80: c0d04c48 00000001 c0d9d844 00000000 ee083bbc ee083ba0 c0580498 c057fff4
[    4.312753] 3ba0: 00000000 ee083bf4 c05803f8 c0d04c48 ee083bec ee083bc0 c057e40c c0580404
[    4.320969] 3bc0: ee083bec ee1b8a6c ed0001b8 8afdf36c ee7e1c00 c0d04c48 ee7e1c34 ee7e1c00
[    4.329185] 3be0: ee083c24 ee083bf0 c057fec0 c057e39c c08a7ec8 ee7e1c00 00000001 8afdf36c
[    4.337402] 3c00: c0d9d844 ee7e1c08 ee7e1c00 c0d46c6c ee7e1c00 c0d04c48 ee083c34 ee083c28
[    4.345619] 3c20: c0580518 c057fdf4 ee083c54 ee083c38 c057f320 c0580510 ee7e1c08 ee7e1800
[    4.353836] 3c40: 00000000 ee7e1c00 ee083ca4 ee083c58 c057d308 c057f2a0 ee083c84 00000000
[    4.362052] 3c60: c0609764 c058bfb0 c06096a8 ee7e1c00 00000000 8afdf36c ee083ca4 ee7e1c00
[    4.370268] 3c80: ee7e1800 00000000 ee29da10 ee7e1800 00000000 ee29da10 ee083cc4 ee083ca8
[    4.378485] 3ca0: c0603c88 c057cf6c ee7e1c00 eedec484 00000001 c0d04c48 ee083cfc ee083cc8
[    4.386702] 3cc0: c0604308 c0603bf0 00000000 00000000 05b8d800 8afdf36c ee7e1800 eedec484
[    4.394918] 3ce0: c0d04c48 00000000 eedec4d4 c0b6fe68 ee083d44 ee083d00 c0604920 c06040e8
[    4.403135] 3d00: ed002500 c0239b60 c0604598 00000000 00000063 8afdf36c c0d04c48 ed0024d0
[    4.411351] 3d20: ee7e1800 ee29da10 ee29da10 c0d04c48 c0116dd8 ee28b1a0 ee083d64 ee083d48
[    4.419567] 3d40: c0604c8c c0604654 ee7e1800 ee7e1b28 ee29da10 ee29da10 ee083dbc ee083d68
[    4.427784] 3d60: c0609b38 c0604c58 00000000 c0b582b0 00000001 ee7e1b74 ee083dac 05b8d800
[    4.436001] 3d80: 00000004 c02b87e8 00000001 8afdf36c 00000000 ee29da10 00000000 c0d47278
[    4.444218] 3da0: 00000000 00000000 c0d47278 00000000 ee083ddc ee083dc0 c0581f2c c06097dc
[    4.452434] 3dc0: ee29da10 c0d9d868 c0d9d86c 00000000 ee083e0c ee083de0 c0580234 c0581ee8
[    4.460651] 3de0: 00000000 ee29da10 c0d47278 ee29da44 c0d04c48 ffffe000 c0d04c48 00000007
[    4.468868] 3e00: ee083e2c ee083e10 c05803f4 c057fff4 00000000 c0d47278 c0580310 c0d04c48
[    4.477085] 3e20: ee083e5c ee083e30 c057e320 c058031c ee083e68 ee068158 ee28b234 8afdf36c
[    4.485299] 3e40: c0d47278 ed000700 c0d42a38 00000000 ee083e6c ee083e60 c057fb7c c057e2bc
[    4.493515] 3e60: ee083e94 ee083e70 c057f530 c057fb64 c0b70644 ee083e80 c0d47278 c0d617c0
[    4.501729] 3e80: c0c2d5f4 00000000 ee083eac ee083e98 c0580dfc c057f434 c0d42a38 c0d617c0
[    4.509946] 3ea0: ee083ec4 ee083eb0 c0581e90 c0580d88 c0d617c0 c0d617c0 ee083ed4 ee083ec8
[    4.518161] 3ec0: c0c2d610 c0581e54 ee083f4c ee083ed8 c01026f0 c0c2d600 00000000 c0d04c48
[    4.526377] 3ee0: c0b09430 c0b09400 c0b0945c c0b093e8 c0b34ce4 00000006 00000006 00000000
[    4.534592] 3f00: c0c00634 00000000 c0bee844 c0b80a58 ee083f34 efffc644 00000000 8afdf36c
[    4.542809] 3f20: 00000000 8afdf36c c0d617c0 c0d617c0 c0c66294 c0c4b834 000000ec c0c00634
[    4.551024] 3f40: ee083f94 ee083f50 c0c00ff0 c01026a0 00000006 00000006 00000000 c0c00634
[    4.559239] 3f60: 00000000 c0bee844 00000000 00000000 c08b77b0 00000000 00000000 00000000
[    4.567453] 3f80: 00000000 00000000 ee083fac ee083f98 c08b77c0 c0c00e30 00000000 c08b77b0
[    4.575669] 3fa0: 00000000 ee083fb0 c01010e8 c08b77bc 00000000 00000000 00000000 00000000
[    4.583883] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.592098] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    4.600308] Backtrace: 
[    4.602777] [<c04d87a4>] (omap_dma_write) from [<c04d8dc0>] (omap_dma_start_desc+0x78/0x150)
[    4.611258] [<c04d8d48>] (omap_dma_start_desc) from [<c04d9028>] (omap_dma_issue_pending+0x90/0x98)
[    4.620347]  r9:ed002780 r8:00000000 r7:00000010 r6:ee2bdd00 r5:ee2bdd4c r4:ee2bdd00
[    4.628130] [<c04d8f98>] (omap_dma_issue_pending) from [<c0608d1c>] (ti_qspi_dma_xfer+0x8c/0x13c)
[    4.637039]  r5:00000000 r4:ee7e1b28
[    4.640636] [<c0608c90>] (ti_qspi_dma_xfer) from [<c06090b0>] (ti_qspi_exec_mem_op+0x2e4/0x32c)
[    4.649373]  r7:00000010 r6:00000001 r5:00000000 r4:ee7e1b28
[    4.655061] [<c0608dcc>] (ti_qspi_exec_mem_op) from [<c0606608>] (spi_mem_exec_op+0xa0/0x3b4)
[    4.663625]  r10:ee7e19b8 r9:00000001 r8:ee7e19d0 r7:ee7e1800 r6:ed002710 r5:c0d04c48
[    4.671489]  r4:ee0837b8
[    4.674040] [<c0606568>] (spi_mem_exec_op) from [<c05d6f14>] (m25p80_read+0x98/0x104)
[    4.681906]  r10:00000000 r9:00000000 r8:8afdf36c r7:00000010 r6:c0d04c48 r5:ee7e2010
[    4.689768]  r4:00000010
[    4.692321] [<c05d6e7c>] (m25p80_read) from [<c05ed1bc>] (spi_nor_read_sfdp+0x78/0xbc)
[    4.700273]  r8:00000000 r7:00000000 r6:ee7e2018 r5:ed002740 r4:00000010
[    4.707009] [<c05ed144>] (spi_nor_read_sfdp) from [<c05ed750>] (spi_nor_read_sfdp_dma_unsafe+0x48/0x74)
[    4.716445]  r10:c09b0370 r9:c09b0370 r8:00000000 r7:ee083898 r6:ee7e2018 r5:ed002740
[    4.724307]  r4:00000010
[    4.726858] [<c05ed708>] (spi_nor_read_sfdp_dma_unsafe) from [<c05ed970>] (spi_nor_init_params+0x1f4/0x6cc)
[    4.736643]  r9:c09b0370 r8:eedec484 r7:0001008b r6:ee7e2018 r5:c0d04c48 r4:ee083a00
[    4.744426] [<c05ed77c>] (spi_nor_init_params) from [<c05ee5a8>] (spi_nor_scan+0x10c/0x784)
[    4.752816]  r10:c09b0370 r9:c09b0370 r8:eedec484 r7:ee7e1c00 r6:c0d04c48 r5:ee7e1dac
[    4.760678]  r4:ee7e2018
[    4.763227] [<c05ee49c>] (spi_nor_scan) from [<c05d7110>] (m25p_probe+0x190/0x1c8)
[    4.770832]  r10:00000000 r9:ee7e2018 r8:00000000 r7:ed002710 r6:c0d04c48 r5:ee7e1dac
[    4.778694]  r4:ee7e2010
[    4.781245] [<c05d6f80>] (m25p_probe) from [<c060699c>] (spi_mem_probe+0x3c/0x48)
[    4.788763]  r9:c0d457cc r8:00000000 r7:00000000 r6:c0d457bc r5:c0d457cc r4:ee7e1c00
[    4.796547] [<c0606960>] (spi_mem_probe) from [<c0603220>] (spi_drv_probe+0x90/0xa8)
[    4.804323]  r5:ee7e1c00 r4:00000000
[    4.807920] [<c0603190>] (spi_drv_probe) from [<c0580234>] (driver_probe_device+0x24c/0x328)
[    4.816396]  r7:00000000 r6:c0d9d86c r5:c0d9d868 r4:ee7e1c00
[    4.822084] [<c057ffe8>] (driver_probe_device) from [<c0580498>] (__device_attach_driver+0xa0/0xd4)
[    4.831172]  r10:00000000 r9:c0d9d844 r8:00000001 r7:c0d04c48 r6:ee7e1c00 r5:ee083bf4
[    4.839034]  r4:c0d457cc r3:00000000
[    4.842631] [<c05803f8>] (__device_attach_driver) from [<c057e40c>] (bus_for_each_drv+0x7c/0xc0)
[    4.851453]  r7:c0d04c48 r6:c05803f8 r5:ee083bf4 r4:00000000
[    4.857144] [<c057e390>] (bus_for_each_drv) from [<c057fec0>] (__device_attach+0xd8/0x140)
[    4.865445]  r7:ee7e1c00 r6:ee7e1c34 r5:c0d04c48 r4:ee7e1c00
[    4.871132] [<c057fde8>] (__device_attach) from [<c0580518>] (device_initial_probe+0x14/0x18)
[    4.879694]  r8:c0d04c48 r7:ee7e1c00 r6:c0d46c6c r5:ee7e1c00 r4:ee7e1c08
[    4.886427] [<c0580504>] (device_initial_probe) from [<c057f320>] (bus_probe_device+0x8c/0x94)
[    4.895081] [<c057f294>] (bus_probe_device) from [<c057d308>] (device_add+0x3a8/0x5c8)
[    4.903034]  r7:ee7e1c00 r6:00000000 r5:ee7e1800 r4:ee7e1c08
[    4.908723] [<c057cf60>] (device_add) from [<c0603c88>] (spi_add_device+0xa4/0x13c)
[    4.916416]  r10:ee29da10 r9:00000000 r8:ee7e1800 r7:ee29da10 r6:00000000 r5:ee7e1800
[    4.924277]  r4:ee7e1c00
[    4.926825] [<c0603be4>] (spi_add_device) from [<c0604308>] (of_register_spi_device+0x22c/0x33c)
[    4.935648]  r7:c0d04c48 r6:00000001 r5:eedec484 r4:ee7e1c00
[    4.941335] [<c06040dc>] (of_register_spi_device) from [<c0604920>] (spi_register_controller+0x2d8/0x604)
[    4.950946]  r9:c0b6fe68 r8:eedec4d4 r7:00000000 r6:c0d04c48 r5:eedec484 r4:ee7e1800
[    4.958727] [<c0604648>] (spi_register_controller) from [<c0604c8c>] (devm_spi_register_controller+0x40/0x78)
[    4.968685]  r10:ee28b1a0 r9:c0116dd8 r8:c0d04c48 r7:ee29da10 r6:ee29da10 r5:ee7e1800
[    4.976547]  r4:ed0024d0
[    4.979093] [<c0604c4c>] (devm_spi_register_controller) from [<c0609b38>] (ti_qspi_probe+0x368/0x50c)
[    4.988353]  r7:ee29da10 r6:ee29da10 r5:ee7e1b28 r4:ee7e1800
[    4.994042] [<c06097d0>] (ti_qspi_probe) from [<c0581f2c>] (platform_drv_probe+0x50/0xa4)
[    5.002257]  r10:00000000 r9:c0d47278 r8:00000000 r7:00000000 r6:c0d47278 r5:00000000
[    5.010121]  r4:ee29da10
[    5.012669] [<c0581edc>] (platform_drv_probe) from [<c0580234>] (driver_probe_device+0x24c/0x328)
[    5.021582]  r7:00000000 r6:c0d9d86c r5:c0d9d868 r4:ee29da10
[    5.027269] [<c057ffe8>] (driver_probe_device) from [<c05803f4>] (__driver_attach+0xe4/0xe8)
[    5.035746]  r10:00000007 r9:c0d04c48 r8:ffffe000 r7:c0d04c48 r6:ee29da44 r5:c0d47278
[    5.043610]  r4:ee29da10 r3:00000000
[    5.047203] [<c0580310>] (__driver_attach) from [<c057e320>] (bus_for_each_dev+0x70/0xbc)
[    5.055418]  r7:c0d04c48 r6:c0580310 r5:c0d47278 r4:00000000
[    5.061105] [<c057e2b0>] (bus_for_each_dev) from [<c057fb7c>] (driver_attach+0x24/0x28)
[    5.069145]  r7:00000000 r6:c0d42a38 r5:ed000700 r4:c0d47278
[    5.074832] [<c057fb58>] (driver_attach) from [<c057f530>] (bus_add_driver+0x108/0x214)
[    5.082874] [<c057f428>] (bus_add_driver) from [<c0580dfc>] (driver_register+0x80/0x114)
[    5.091001]  r7:00000000 r6:c0c2d5f4 r5:c0d617c0 r4:c0d47278
[    5.096690] [<c0580d7c>] (driver_register) from [<c0581e90>] (__platform_driver_register+0x48/0x50)
[    5.105774]  r5:c0d617c0 r4:c0d42a38
[    5.109371] [<c0581e48>] (__platform_driver_register) from [<c0c2d610>] (ti_qspi_driver_init+0x1c/0x20)
[    5.118803]  r5:c0d617c0 r4:c0d617c0
[    5.122399] [<c0c2d5f4>] (ti_qspi_driver_init) from [<c01026f0>] (do_one_initcall+0x5c/0x1a0)
[    5.130965] [<c0102694>] (do_one_initcall) from [<c0c00ff0>] (kernel_init_freeable+0x1cc/0x264)
[    5.139704]  r9:c0c00634 r8:000000ec r7:c0c4b834 r6:c0c66294 r5:c0d617c0 r4:c0d617c0
[    5.147484] [<c0c00e24>] (kernel_init_freeable) from [<c08b77c0>] (kernel_init+0x10/0x118)
[    5.155786]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c08b77b0
[    5.163648]  r4:00000000
[    5.166196] [<c08b77b0>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    5.173799] Exception stack(0xee083fb0 to 0xee083ff8)
[    5.178875] 3fa0:                                     00000000 00000000 00000000 00000000
[    5.187090] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.195307] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.201948]  r5:c08b77b0 r4:00000000
[    5.205542] Code: e89da800 e6ff0070 e1c200b0 e89da800 (e5820000) 
[    5.211665] ---[ end trace f28cf01bf78d8bac ]---
[    5.216347] note: swapper/0[1] exited with preempt_count 1
[    5.221901] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    5.221901] 
[    5.231086] CPU1: stopping
[    5.233811] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D W         4.18.0-rc6-00159-g0509411 #33
[    5.242897] Hardware name: Generic DRA74X (Flattened Device Tree)
[    5.249016] Backtrace: 
[    5.251481] [<c010c990>] (dump_backtrace) from [<c010cc60>] (show_stack+0x18/0x1c)
[    5.259087]  r7:ee0bdf10 r6:60000193 r5:00000000 r4:c0d5ea78
[    5.264778] [<c010cc48>] (show_stack) from [<c08a22a8>] (dump_stack+0x8c/0xa0)
[    5.272039] [<c08a221c>] (dump_stack) from [<c0110178>] (handle_IPI+0x17c/0x190)
[    5.279470]  r7:ee0bdf10 r6:00000000 r5:00000001 r4:c0c6ed00
[    5.285165] [<c010fffc>] (handle_IPI) from [<c044a6dc>] (gic_handle_irq+0x7c/0x80)
[    5.292768]  r7:fa212000 r6:ee0bdf10 r5:fa21200c r4:c0d050f4
[    5.298455] [<c044a660>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0xa8)
[    5.305970] Exception stack(0xee0bdf10 to 0xee0bdf58)
[    5.311045] df00:                                     00000000 000003b0 eedb454c c011afa0
[    5.319261] df20: ee0bc000 c0d04c74 c0d04cc4 00000002 00000000 c0c6e4f0 00000000 ee0bdf6c
[    5.327477] df40: ee0bdf70 ee0bdf60 c01091e8 c01091ec 60000013 ffffffff
[    5.334122]  r9:ee0bc000 r8:00000000 r7:ee0bdf44 r6:ffffffff r5:60000013 r4:c01091ec
[    5.341909] [<c01091ac>] (arch_cpu_idle) from [<c08bd2b4>] (default_idle_call+0x28/0x34)
[    5.350043] [<c08bd28c>] (default_idle_call) from [<c015d1f4>] (do_idle+0x1d0/0x2a0)
[    5.357827] [<c015d024>] (do_idle) from [<c015d5b0>] (cpu_startup_entry+0x20/0x28)
[    5.365433]  r10:00000000 r9:412fc0f2 r8:8000406a r7:c0d61a10 r6:00000001 r5:ee0bc000
[    5.373294]  r4:00000085
[    5.375845] [<c015d590>] (cpu_startup_entry) from [<c010fd40>] (secondary_start_kernel+0x16c/0x178)
[    5.384934] [<c010fbd4>] (secondary_start_kernel) from [<8010246c>] (0x8010246c)
[    5.392363]  r7:c0d61a10 r6:10c0387d r5:00000051 r4:ae0a806a
[    5.398057] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    5.398057]  ]---


-- 
regards,
-grygorii
