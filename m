From: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Subject: zalon scsi WARNINGs at kernel/dma/mapping.c:290
	dma_free_attrs+0x5c/0x84
Date: Tue, 19 Feb 2019 00:57:18 +0200
Message-ID: <f7cf6b8f-671b-e01f-fa1f-6ca82c4af819@linux.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: et-EE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I tried latest Linux on HP A180C (32-bit pa-risc). It works but the Zalon SCSI driver barfs warnings for GSC addon differential scsi board.

The warnings seem to be DMA API related. Packaged 4.19 and self-compiled 5.0.0-rc7 exhibit the same problem.

[    0.000000] Linux version 5.0.0-rc7-00010-g301e361072e5 (mroos@rp3440) (gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)) #1 Mon Feb 18 23:04:37 EET 2019
[    0.000000] FP[0] enabled: Rev 1 Model 15
[    0.000000] The 32-bit Kernel has started...
[    0.000000] Kernel default page size is 4 KB. Huge pages disabled.
[    0.000000] printk: bootconsole [ttyB0] enabled
[    0.000000] Initialized PDC Console for debugging.
[    0.000000] Determining PDC firmware type: System Map.
[    0.000000] model 00005160 00000481 00000000 00000000 7750aa9b 100000f0 00000004 000000ba 000000ba
[    0.000000] vers  00000018
[    0.000000] CPUID vers 15 rev 24 (0x000001f8)
[    0.000000] model 9000/800/A180c
[    0.000000] Memory Ranges:
[    0.000000]  0) Start 0x0000000000000000 End 0x000000000fffffff Size    256 MB
[    0.000000] Total Memory: 256 MB
[    0.000000] PDT: Firmware does not provide any page deallocation information.
[    0.000000] On node 0 totalpages: 65536
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65536 pages, LIFO batch:15
[    0.000000] LED display at f0190001 registered
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: root=/dev/sda5 HOME=/ console=ttyS0 TERM=vt102 palo_kernel=2/vmlinux
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 253612K/262144K available (4216K kernel code, 567K rwdata, 536K rodata, 256K init, 384K bss, 8532K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 96
[    0.000044] sched_clock: 32 bits at 180MHz, resolution 5ns, wraps every 11930464253ns
[    0.084054] Console: colour dummy device 160x64
[    0.124622] Calibrating delay loop... 119.29 BogoMIPS (lpj=238592)
[    0.233202] pid_max: default: 32768 minimum: 301
[    0.275427] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.342213] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.421916] devtmpfs: initialized
[    0.448862] random: get_random_u32 called from bucket_table_alloc.isra.7+0x94/0x1d4 with crng_init=0
[    0.547811] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.653888] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.714958] NET: Registered protocol family 16
[    0.755539] Searching for devices...
[    0.789348] Two devices have hardware path [8].  IODC data for second device: 50500007000000
                Rearranging GSC cards sometimes helps
[    1.156945] Found devices:
[    1.174507] 1. Phantom PseudoBC GSC+ Port at 0x4290772992 [8] { 7, 0x0, 0x504, 0x00000 }
[    1.259789] 2. Bluefish Add-on FW-SCSI at 0x4294459392 [8/4] { 4, 0x1, 0x013, 0x00089 }
[    1.343972] 3. HP HSC-PCI Cards at 0x4294475776 [8/8] { 4, 0x0, 0x004, 0x0009d }
[    1.420505] 4. Staccato 180 Lasi at 0x4291821568 [8/16] { 11, 0x0, 0x05f, 0x00081 }, additional addresses: 0xffd0c000 0xffc00000
[    1.550587] 5. Staccato 180 Core LAN RS-232 at 0x4291842048 [8/16/4] { 10, 0x0, 0x05f, 0x0008c }
[    1.644603] 6. Staccato 180 Core SCSI at 0x4291846144 [8/16/5] { 10, 0x0, 0x05f, 0x00082 }
[    1.732063] 7. Dino PCI Bridge at 0x4294443008 [8/0] { 13, 0x3, 0x680, 0x0000a }, additional addresses: 0xf1800000
[    1.846843] 8. Staccato L2 180 (A Class 180) at 0x4294696960 [62] { 0, 0x0, 0x516, 0x00004 }
[    1.936483] 9. Memory at 0x4294701056 [63] { 1, 0x0, 0x08b, 0x00009 }
[    2.001002] 10. Dino PS/2 Port at 0x4294447104 [1] { 10, 0x0, 0x007, 0x00096 }
[    2.075348] 11. Dino RS-232 at 0x4294455296 [3] { 10, 0x0, 0x007, 0x0008c }
[    2.146410] Enabling regular chassis codes support v0.05
[    2.285659] CPU(s): 1 x PA7300LC (PCX-L2) at 180.000000 MHz
[    2.339638] alternatives: applied 147 out of 160 patches
[    2.394261] Whole cache flush 9407 cycles, flushing 5840896 bytes 665415 cycles
[    2.394286] Cache flush threshold set to 5 KiB
[    2.434063] Whole TLB flush 695 cycles, Range flush 5840896 bytes 63066 cycles
[    2.508419] Calculated TLB flush threshold 64 KiB
[    2.551066] TLB flush threshold set to 64 KiB
[    2.589448] Lasi version 0 at 0xffd00000 found.
[    2.630599] Dino version 3.x (card mode) found at 0xfff88000
[    2.736018] dino 8:8: PCI host bridge to bus 0000:00
[    2.781991] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    2.843257] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.895856] pci 0000:00:01.0: [1011:0009] type 00 class 0x020000
[    2.895935] pci 0000:00:01.0: reg 0x10: [io  0x0080-0x00ff]
[    2.896032] pci 0000:00:01.0: reg 0x14: [mem 0xf0800000-0xf080007f]
[    2.896100] pci 0000:00:01.0: reg 0x30: [mem 0x76900000-0x7693ffff pref]
[    2.896727] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    2.896787] pci 0000:00:01.0: BAR 0: assigned [io  0x0080-0x00ff]
[    2.957000] pci 0000:00:01.0: BAR 1: assigned [mem 0xf0800000-0xf080007f]
[    3.026057] Dino version 3.1 found at 0xfff80000
[    3.068310] dino 8:0: PCI host bridge to bus 0000:01
[    3.114322] pci_bus 0000:01: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
[    3.210535] pci_bus 0000:01: root bus resource [mem 0xf1800000-0xf1ffffff]
[    3.280531] pci_bus 0000:01: root bus resource [bus 01-ff]
[    3.333163] pci 0000:01:14.0: [1011:0019] type 00 class 0x020000
[    3.333232] pci 0000:01:14.0: reg 0x10: [io  0x1ff00-0x1ff7f]
[    3.333275] pci 0000:01:14.0: reg 0x14: [mem 0xf1fff000-0xf1fff3ff]
[    3.333355] pci 0000:01:14.0: reg 0x30: [mem 0xf1f80000-0xf1fbffff pref]
[    3.333865] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    3.333924] pci 0000:01:14.0: BAR 1: assigned [mem 0xf1800000-0xf18003ff]
[    3.402868] pci 0000:01:14.0: BAR 0: assigned [io  0x10000-0x1007f]
[    3.465884] powersw: Soft power switch at 0xf0140000 enabled.
[    3.532603] vgaarb: loaded
[    3.551104] SCSI subsystem initialized
[    3.608410] NET: Registered protocol family 2
[    3.649272] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
[    3.729183] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    3.800385] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    3.863906] TCP: Hash tables configured (established 2048 bind 2048)
[    3.927957] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    3.984927] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    4.047813] NET: Registered protocol family 1
[    4.086211] PCI: CLS 16 bytes
[    4.086732] clocksource: cr16: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 10618113593 ns
[    4.184063] clocksource: Switched to clocksource cr16
[    4.231613] Enabling PDC chassis warnings support v0.05
[    4.283024] workingset: timestamp_bits=30 max_order=16 bucket_order=0
[    4.376748] fuse init (API version 7.28)
[    4.412795] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    4.489427] io scheduler mq-deadline registered
[    4.532386] PDC Stable Storage facility v0.30
[    4.605483] STI GSC/PCI core graphics driver Version 0.9b
[    4.658241] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    4.725178] printk: console [ttyS0] disabled
[    4.782751] 8:16:4: ttyS0 at MMIO 0xffd05800 (irq = 16, base_baud = 454545) is a 16550A
[    4.866995] printk: console [ttyS0] enabled
[    4.937314] printk: bootconsole [ttyB0] disabled
[    5.018982] serial 3: Serial: device 0xfff83000 not configured.
                Enable support for Wax, Lasi, Asp or Dino.
[    5.120463] zalon_probe: Zalon version 1, IRQ 68
[    5.159950] ncr53c720-0: rev 0xf irq 68
[    5.191811] ncr53c720-0: ID 7, Fast-10, Parity Checking, Differential
[    5.256182] ncr53c720-0: suspicious SCSI data while resetting the BUS.
[    5.318318] ncr53c720-0: dp1,d15-8,dp0,d7-0,rst,req,ack,bsy,sel,atn,msg,c/d,i/o = 0x190, expecting 0x100
[    5.415596] ncr53c720-0: FATAL ERROR: CHECK SCSI BUS - CABLES, TERMINATION, DEVICE POWER etc.!
[    5.502579] ncr53c720-0: detaching...
[    5.530709] WARNING: CPU: 0 PID: 1 at kernel/dma/mapping.c:290 dma_free_attrs+0x5c/0x84
[    5.610482] CPU: 0 PID: 1 Comm: swapper Not tainted 5.0.0-rc7-00010-g301e361072e5 #1
[    5.687146] Hardware name: 9000/800/A180c

[    5.721501]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[    5.761941] PSW: 00000000000001001111111100001110 Not tainted
[    5.814799] r00-03  0004ff0e 1062f000 10404c94 1f972120
[    5.861455] r04-07  1f972000 1f970000 0000802c 00000000
[    5.908116] r08-11  105d5800 0000000f 00000002 00000002
[    5.954786] r12-15  00000001 0f981458 000000fd f0100000
[    6.001449] r16-19  f0000908 f00000bc 0fffffe0 0000000e
[    6.048112] r20-23  00018000 10690c88 10404c1c 0f980000
[    6.094780] r24-27  00018000 00002000 1f869e98 1062f000
[    6.141443] r28-31  00000000 00000000 1f830780 10404778
[    6.188098] sr00-03  00000000 00000000 00000000 00000000
[    6.235792] sr04-07  00000000 00000000 00000000 00000000

[    6.285651] IASQ: 00000000 00000000 IAOQ: 101964b8 101964bc
[    6.336435]  IIR: 03ffe01f    ISR: 00000000  IOR: 101964bc
[    6.386185]  CPU:        0   CR30: 1f830000 CR31: f0102970
[    6.435925]  ORIG_R28: 1f8308c0
[    6.457768]  IAOQ[0]: dma_free_attrs+0x5c/0x84
[    6.495130]  IAOQ[1]: dma_free_attrs+0x60/0x84
[    6.532504]  RP(r2): ___dma_freep+0x78/0xb8
[    6.566748] Backtrace:
[    6.579297]  [<10404c94>] ___dma_freep+0x78/0xb8
[    6.618750]  [<10404778>] __m_free+0x94/0xa0
[    6.654060]  [<10404834>] __m_free_dma+0x40/0x7c
[    6.693531]  [<101162c0>] ncr_attach+0xed8/0xf70
[    6.732981]  [<10114bd8>] zalon_probe+0x14c/0x210
[    6.773473]  [<1014c754>] parisc_driver_probe+0x24/0x40
[    6.820170]  [<103e83a0>] really_probe+0x1d0/0x2d8
[    6.861684]  [<103e8e24>] __driver_attach+0xe4/0xe8
[    6.904229]  [<103e6710>] bus_for_each_dev+0x6c/0xb0
[    6.947813]  [<103e8f58>] driver_attach+0x20/0x2c
[    6.988294]  [<103e7178>] bus_add_driver+0x12c/0x20c
[    7.031878]  [<103e965c>] driver_register+0x74/0x12c
[    7.075464]  [<1014ce0c>] register_parisc_driver+0x44/0x90
[    7.125253]  [<10114cc0>] zalon7xx_init+0x24/0x44
[    7.165737]  [<10102154>] do_one_initcall+0x7c/0x180
[    7.209320]  [<101023e0>] kernel_init_freeable+0x188/0x240
[    7.259108]  [<10557d78>] kernel_init+0x10/0x12c
[    7.298555]  [<1014701c>] ret_from_kernel_thread+0x1c/0x24

[    7.350485] ---[ end trace 79aea6098273eec5 ]---
[    7.389979] WARNING: CPU: 0 PID: 1 at kernel/dma/mapping.c:290 dma_free_attrs+0x5c/0x84
[    7.469746] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.0.0-rc7-00010-g301e361072e5 #1
[    7.562937] Hardware name: 9000/800/A180c

[    7.597290]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[    7.637729] PSW: 00000000000001000000001100001110 Tainted: G        W
[    7.707136] r00-03  0004030e 1062f000 10404c94 1f972110
[    7.753794] r04-07  1f972000 1f970000 0000802c 00000000
[    7.800452] r08-11  105d5800 0000000f 00000002 00000002
[    7.847108] r12-15  00000001 0f981458 000000fd f0100000
[    7.893779] r16-19  f0000908 f00000bc 0fffffe0 0000000e
[    7.940442] r20-23  00010000 00011000 10404c1c 0f97e000
[    7.987080] random: fast init done
[    8.012038] r24-27  00010000 00002000 1f869e98 1062f000
[    8.058697] r28-31  00000000 000000fc 1f830780 10404778
[    8.105354] sr00-03  00000000 00000000 00000000 00000000
[    8.153047] sr04-07  00000000 00000000 00000000 00000000

[    8.202875] IASQ: 00000000 00000000 IAOQ: 101964b8 101964bc
[    8.253668]  IIR: 03ffe01f    ISR: 00000000  IOR: 101964bc
[    8.303427]  CPU:        0   CR30: 1f830000 CR31: f0102970
[    8.353176]  ORIG_R28: 1f8308c0
[    8.375021]  IAOQ[0]: dma_free_attrs+0x5c/0x84
[    8.412383]  IAOQ[1]: dma_free_attrs+0x60/0x84
[    8.449772]  RP(r2): ___dma_freep+0x78/0xb8
[    8.484017] Backtrace:
[    8.496547]  [<10404c94>] ___dma_freep+0x78/0xb8
[    8.535993]  [<10404778>] __m_free+0x94/0xa0
[    8.571298]  [<10404834>] __m_free_dma+0x40/0x7c
[    8.610754]  [<101162dc>] ncr_attach+0xef4/0xf70
[    8.650203]  [<10114bd8>] zalon_probe+0x14c/0x210
[    8.690686]  [<1014c754>] parisc_driver_probe+0x24/0x40
[    8.737369]  [<103e83a0>] really_probe+0x1d0/0x2d8
[    8.778885]  [<103e8e24>] __driver_attach+0xe4/0xe8
[    8.821432]  [<103e6710>] bus_for_each_dev+0x6c/0xb0
[    8.865008]  [<103e8f58>] driver_attach+0x20/0x2c
[    8.905483]  [<103e7178>] bus_add_driver+0x12c/0x20c
[    8.949062]  [<103e965c>] driver_register+0x74/0x12c
[    8.992661]  [<1014ce0c>] register_parisc_driver+0x44/0x90
[    9.042461]  [<10114cc0>] zalon7xx_init+0x24/0x44
[    9.082932]  [<10102154>] do_one_initcall+0x7c/0x180
[    9.126519]  [<101023e0>] kernel_init_freeable+0x188/0x240
[    9.176303]  [<10557d78>] kernel_init+0x10/0x12c
[    9.215750]  [<1014701c>] ret_from_kernel_thread+0x1c/0x24

[    9.267664] ---[ end trace 79aea6098273eec6 ]---
[    9.307143] WARNING: CPU: 0 PID: 1 at kernel/dma/mapping.c:290 dma_free_attrs+0x5c/0x84
[    9.386908] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.0.0-rc7-00010-g301e361072e5 #1
[    9.480096] Hardware name: 9000/800/A180c

[    9.514412]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[    9.554856] PSW: 00000000000001000000000000001110 Tainted: G        W
[    9.624265] r00-03  0004000e 1062f000 10404c94 1f972100
[    9.670925] r04-07  1f972000 1f970000 0000802c 00000000
[    9.717582] r08-11  105d5800 0000000f 00000002 00000002
[    9.764241] r12-15  00000001 0f981458 000000fd f0100000
[    9.810903] r16-19  f0000908 f00000bc 0fffffe0 0000000e
[    9.857561] r20-23  00008000 00009000 10404c1c 0f97c000
[    9.904220] r24-27  00008000 00002000 1f869e98 1062f000
[    9.950880] r28-31  00000000 00000024 1f830780 10404778
[    9.997541] sr00-03  00000000 00000000 00000000 00000000
[   10.045237] sr04-07  00000000 00000000 00000000 00000000

[   10.095064] IASQ: 00000000 00000000 IAOQ: 101964b8 101964bc
[   10.145853]  IIR: 03ffe01f    ISR: 00000000  IOR: 101964bc
[   10.195607]  CPU:        0   CR30: 1f830000 CR31: f0102970
[   10.245355]  ORIG_R28: 1f8308c0
[   10.267201]  IAOQ[0]: dma_free_attrs+0x5c/0x84
[   10.304563]  IAOQ[1]: dma_free_attrs+0x60/0x84
[   10.341923]  RP(r2): ___dma_freep+0x78/0xb8
[   10.376165] Backtrace:
[   10.388703]  [<10404c94>] ___dma_freep+0x78/0xb8
[   10.428135]  [<10404778>] __m_free+0x94/0xa0
[   10.463442]  [<10404834>] __m_free_dma+0x40/0x7c
[   10.502892]  [<1011630c>] ncr_attach+0xf24/0xf70
[   10.542347]  [<10114bd8>] zalon_probe+0x14c/0x210
[   10.582831]  [<1014c754>] parisc_driver_probe+0x24/0x40
[   10.629515]  [<103e83a0>] really_probe+0x1d0/0x2d8
[   10.671029]  [<103e8e24>] __driver_attach+0xe4/0xe8
[   10.713576]  [<103e6710>] bus_for_each_dev+0x6c/0xb0
[   10.757154]  [<103e8f58>] driver_attach+0x20/0x2c
[   10.797632]  [<103e7178>] bus_add_driver+0x12c/0x20c
[   10.841213]  [<103e965c>] driver_register+0x74/0x12c
[   10.884797]  [<1014ce0c>] register_parisc_driver+0x44/0x90
[   10.934587]  [<10114cc0>] zalon7xx_init+0x24/0x44
[   10.975059]  [<10102154>] do_one_initcall+0x7c/0x180
[   11.018645]  [<101023e0>] kernel_init_freeable+0x188/0x240
[   11.068431]  [<10557d78>] kernel_init+0x10/0x12c
[   11.107874]  [<1014701c>] ret_from_kernel_thread+0x1c/0x24

[   11.159782] ---[ end trace 79aea6098273eec7 ]---
[   11.202179] 53c700: Version 2.8 By James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org
[   11.266506] scsi0: 53c710 rev 2
[   12.290278] scsi host0: LASI SCSI 53c700
[   12.328381] scsi 0:0:0:0: Direct-Access     QUANTUM  VIKING II 4.5WLS 4110 PQ: 0 ANSI: 2
[   12.409356] scsi target0:0:0: Beginning Domain Validation
[   12.458243] scsi 0:0:0:0: tag#34 Enabling Tag Command Queuing
[   12.511347] scsi target0:0:0: asynchronous
[   12.548810] scsi target0:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
[   12.617969] scsi target0:0:0: Domain Validation skipping write tests
[   12.678124] scsi target0:0:0: Ending Domain Validation
[   12.727687] scsi 0:0:0:1: tag#41 Disabling Tag Command Queuing
[   14.370848] scsi 0:0:6:0: CD-ROM            PLEXTOR  CD-R   PX-W1210S 1.00 PQ: 0 ANSI: 2
[   14.451823] scsi target0:0:6: Beginning Domain Validation
[   14.500876] scsi target0:0:6: asynchronous
[   14.538365] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
[   14.607613] scsi target0:0:6: Domain Validation skipping write tests
[   14.667782] scsi target0:0:6: Ending Domain Validation
[   14.722578] sr 0:0:6:0: [sr0] scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   14.801456] cdrom: Uniform CD-ROM driver Revision: 3.20
[   14.849498] sd 0:0:0:0: [sda] 8910423 512-byte logical blocks: (4.56 GB/4.25 GiB)
[   14.924277] sr 0:0:6:0: Attached scsi CD-ROM sr0
[   14.925222] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   14.973927] sd 0:0:0:0: [sda] Write Protect is off
[   15.015501] sd 0:0:0:0: [sda] Mode Sense: b3 00 00 08
[   15.015895] sr 0:0:6:0: Attached scsi generic sg1 type 5
[   15.064126] Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
[   15.121196] tulip 0000:00:01.0: enabling device (0000 -> 0003)
[   15.175125] tulip 0000:00:01.0: enabling SERR and PARITY (0003 -> 0143)
[   15.238787] tulip 0000:00:01.0: cache line size of 16 is not supported
[   15.244947] tulip0:  MII transceiver #1 config 3100 status 7849 advertising 01e1
[   15.323091] net eth0: GSC DS21140 Tulip rev 34 at MMIO 0xf0800000, 00:60:b0:f9:ba:9d, IRQ 18
[   15.412716] tulip1: no phy info, aborting mtable build
[   15.458738] tulip1:  MII transceiver #1 config 1000 status 782d advertising 01e1
[   15.536726] net eth1: Digital DS21142/43 Tulip rev 65 at MMIO 0xf1800000, 00:10:83:b9:61:b1, IRQ 19
[   15.630454] rtc-generic rtc-generic: registered as rtc0
[   15.681257] NET: Registered protocol family 10
[   15.720718] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   15.817440] Segment Routing with IPv6
[   15.845902] NET: Registered protocol family 17
[   15.887704] rtc-generic rtc-generic: setting system clock to 2019-02-18T21:36:09 UTC (1550525769)
[   16.019658]  sda: sda1 sda2 sda3 < sda5 sda6 >
[   16.069375] sd 0:0:0:0: [sda] Attached SCSI disk
[   16.181446] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
[   16.257215] VFS: Mounted root (ext4 filesystem) readonly on device 8:5.
[   16.357097] devtmpfs: mounted
[   16.380379] Freeing unused kernel memory: 256K
[   16.418899] Write protecting the kernel read-only data: 536k
[   16.470794] Run /sbin/init as init process
[   19.352851] systemd[1]: systemd 240 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[   19.592485] systemd[1]: Detected architecture parisc.
[   19.759854] systemd[1]: Set hostname to <a180c>.
[   20.134682] random: crng init done
[   22.582219] systemd[1]: File /lib/systemd/system/systemd-journald.service:12 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[   22.769766] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[   25.041166] systemd[1]: Listening on Journal Socket.
[   25.163093] systemd[1]: Condition check resulted in Huge Pages File System being skipped.
[   25.247734] systemd[1]: Listening on Journal Socket (/dev/log).
[   25.393893] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   25.547073] systemd[1]: Listening on udev Control Socket.
[   25.673718] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   25.887180] systemd[1]: Starting Load Kernel Modules...
[   26.026639] systemd[1]: Listening on udev Kernel Socket.
[   26.201190] systemd[1]: Reached target Remote File Systems.
[   26.328911] systemd[1]: Condition check resulted in Create list of required static device nodes for the current kernel being skipped.
[   29.588404] EXT4-fs (sda5): re-mounted. Opts: errors=remount-ro
[   30.169138] systemd[1]: Starting Create System Users...
[   30.506681] systemd[1]: Started Journal Service.
[   31.896650] systemd-journald[47]: Received request to flush runtime journal from PID 1
[   34.295026] tulip 0000:01:14.0 enp1s20: renamed from eth1
[   34.611006] tulip 0000:00:01.0 enp0s1: renamed from eth0
[   35.835421] sr 0:0:6:0: [sr0] tag#46 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
[   35.918389] sr 0:0:6:0: [sr0] tag#46 Sense Key : 0x3 [current]
[   35.973370] sr 0:0:6:0: [sr0] tag#46 ASC=0x6 ASCQ=0x0
[   36.019042] sr 0:0:6:0: [sr0] tag#46 CDB: opcode=0x28 28 00 00 01 9c 2c 00 00 02 00
[   36.094680] print_req_error: I/O error, dev sr0, sector 422064 flags 80700
[   36.164130] attempt to access beyond end of device
[   36.205653] sr0: rw=0, want=422072, limit=422064
[   36.245094] Buffer I/O error on dev sr0, logical block 52758, async page read
[   41.541503] Adding 317436k swap on /dev/sda6.  Priority:-2 extents:1 across:317436k
[   42.498466] EXT4-fs (sda2): mounting ext2 file system using the ext4 subsystem
[   42.616954] EXT4-fs (sda2): mounted filesystem without journal. Opts: (null)
[   48.096449] net enp1s20: Setting full-duplex based on MII#1 link partner capability of 45e1
