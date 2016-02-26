From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Fri, 26 Feb 2016 14:20:05 -0500
Message-ID: <56D0A565.8080406@compro.net>
References: <569FB013.4050709@compro.net> <20160120161904.GI18805@8bytes.org>
	<569FCFC8.2000606@compro.net> <20160120182602.GJ18805@8bytes.org>
	<56A0F03C.8010109@compro.net> <56A0F221.10502@compro.net>
	<20160121223958.GL18805@8bytes.org> <56B0CFF7.80907@compro.net>
	<20160216162455.GX18805@8bytes.org> <56C35D1A.9080307@compro.net>
	<20160226162319.GH22747@8bytes.org>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160226162319.GH22747-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/26/2016 11:23 AM, Joerg Roedel wrote:
> Can you please boot a v4.5-rc5 kernel with iommu enabled and
> 'amd_iommu_dump' on the kernel command line and send me dmesg after
> boot again?
> 
> 

Here ya go Joerg,
 
See ata7 and ata8 failure messages. These are the 2 disks that don't come up. They are hanging off one of these two Marvell chips.

07:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 12)
13:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 12)

One of these is for 2 internal ports (the ones I use) and the other is for two external ports not in use.

Regards
Mark


[    0.000000] Linux version 4.5.0-rc5 (root@harley) (gcc version 4.8.3 20140627 [gcc-4_8-branch revision 212064] (SUSE Linux) ) #1 SMP PREEMPT Fri Feb 26 13:48:57 EST 2016
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.5.0-rc5 root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G amd_iommu_dump
[    0.000000] tseg: 00af800000
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000ae474fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ae475000-0x00000000aea32fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000aea33000-0x00000000aee2efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000aee2f000-0x00000000af154fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000af155000-0x00000000af155fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000af156000-0x00000000af35bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000af35c000-0x00000000af7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed61000-0x00000000fed70fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100001000-0x000000044fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x450000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-EBFFF uncachable
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000AF800000 mask FFFFFF800000 uncachable
[    0.000000]   3 base 0000B0000000 mask FFFFF0000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000450000000 aka 17664M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: update [mem 0xaf800000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xaf800 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fd9a0-0x000fd9af] mapped at [ffff8800000fd9a0]
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x010ff000, 0x010fffff] PGTABLE
[    0.000000] BRK [0x01100000, 0x01100fff] PGTABLE
[    0.000000] BRK [0x01101000, 0x01101fff] PGTABLE
[    0.000000] BRK [0x01102000, 0x01102fff] PGTABLE
[    0.000000] BRK [0x01103000, 0x01103fff] PGTABLE
[    0.000000] BRK [0x01104000, 0x01104fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3709c000-0x37845fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000AEE1F070 000064 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000AEE25880 0000F4 (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20160108/tbfadt-654)
[    0.000000] ACPI: DSDT 0x00000000AEE1F170 00670F (v02 ALASKA A M I    00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000AEE29F80 000040
[    0.000000] ACPI: APIC 0x00000000AEE25978 00009E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000AEE25A18 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000AEE25A60 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000AEE25AA0 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: MATS 0x00000000AEE25AD8 000034 (v02 ALASKA A M I    00000002 w?x2 00000000)
[    0.000000] ACPI: IVRS 0x00000000AEE25B10 000120 (v01 AMD    RD890S   00202031 AMD  00000000)
[    0.000000] ACPI: BGRT 0x00000000AEE25C30 000038 (v00 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] cma: Reserved 64 MiB at 0x00000000aa400000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000044fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000ae474fff]
[    0.000000]   node   0: [mem 0x00000000af155000-0x00000000af155fff]
[    0.000000]   node   0: [mem 0x00000000af35c000-0x00000000af7fffff]
[    0.000000]   node   0: [mem 0x0000000100001000-0x000000044fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000044fffffff]
[    0.000000] On node 0 totalpages: 4188342
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 3605 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11109 pages used for memmap
[    0.000000]   DMA32 zone: 710938 pages, LIFO batch:31
[    0.000000]   Normal zone: 54272 pages used for memmap
[    0.000000]   Normal zone: 3473407 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 10, version 33, address 0xfec20000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xae475000-0xaea32fff]
[    0.000000] PM: Registered nosave memory: [mem 0xaea33000-0xaee2efff]
[    0.000000] PM: Registered nosave memory: [mem 0xaee2f000-0xaf154fff]
[    0.000000] PM: Registered nosave memory: [mem 0xaf156000-0xaf35bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xaf800000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfec1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec20000-0xfec20fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec21000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed60fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed61000-0xfed70fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed71000-0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfeefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfef00000-0xffffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x100000000-0x100000fff]
[    0.000000] e820: [mem 0xaf800000-0xf7ffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 32 pages/cpu @ffff88044fc00000 s91736 r8192 d31144 u262144
[    0.000000] pcpu-alloc: s91736 r8192 d31144 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4119292
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.5.0-rc5 root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G amd_iommu_dump
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Memory: 16310552K/16753368K available (6373K kernel code, 854K rwdata, 3024K rodata, 996K init, 1180K bss, 377280K reserved, 65536K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=8.
[    0.000000] 	RCU kthread priority: 1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS:8448 nr_irqs:1032 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-7.
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] tsc: PIT calibration matches HPET. 1 loops
[    0.000000] tsc: Detected 3616.493 MHz processor
[    0.000021] Calibrating delay loop (skipped), value calculated using timer frequency.. 7232.98 BogoMIPS (lpj=3616493)
[    0.000028] pid_max: default: 32768 minimum: 301
[    0.000038] ACPI: Core revision 20160108
[    0.003684] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.003706] Security Framework initialized
[    0.003735] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.003740] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.003998] CPU: Physical Processor ID: 0
[    0.004001] CPU: Processor Core ID: 0
[    0.004005] mce: CPU supports 7 MCE banks
[    0.004013] LVT offset 1 assigned for vector 0xf9
[    0.004019] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.004022] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.004232] Freeing SMP alternatives memory: 24K (ffffffff80fd0000 - ffffffff80fd6000)
[    0.008062] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.119110] smpboot: CPU0: AMD FX(tm)-8150 Eight-Core Processor (family: 0x15, model: 0x1, stepping: 0x2)
[    0.119130] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.119138] ... version:                0
[    0.119141] ... bit width:              48
[    0.119144] ... generic registers:      6
[    0.119147] ... value mask:             0000ffffffffffff
[    0.119150] ... max period:             00007fffffffffff
[    0.119153] ... fixed-purpose events:   0
[    0.119156] ... event mask:             000000000000003f
[    0.128153] x86: Booting SMP configuration:
[    0.128157] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.190938] x86: Booted up 1 node, 8 CPUs
[    0.190946] smpboot: Total of 8 processors activated (57863.88 BogoMIPS)
[    0.203277] devtmpfs: initialized
[    0.203487] PM: Registering ACPI NVS region [mem 0xaea33000-0xaee2efff] (4177920 bytes)
[    0.203538] PM: Registering ACPI NVS region [mem 0xaf156000-0xaf35bfff] (2121728 bytes)
[    0.203640] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.203987] pinctrl core: initialized pinctrl subsystem
[    0.204019] RTC time: 19:00:17, date: 02/26/16
[    0.205149] NET: Registered protocol family 16
[    0.207256] cpuidle: using governor ladder
[    0.209255] cpuidle: using governor menu
[    0.209323] ACPI: bus type PCI registered
[    0.209327] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.209380] PCI: Using configuration type 1 for base access
[    0.209383] PCI: Using configuration type 1 for extended access
[    0.212341] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.212345] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.212570] ACPI: Added _OSI(Module Device)
[    0.212574] ACPI: Added _OSI(Processor Device)
[    0.212578] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.212581] ACPI: Added _OSI(Processor Aggregator Device)
[    0.213747] ACPI: Executed 3 blocks of module-level executable AML code
[    0.216444] ACPI: Interpreter enabled
[    0.216462] ACPI: (supports S0 S3 S4 S5)
[    0.216466] ACPI: Using IOAPIC for interrupt routing
[    0.216631] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.223030] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.223037] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.223046] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.223417] PCI host bridge to bus 0000:00
[    0.223422] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.223426] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.223430] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.223434] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.223438] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.223443] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.223449] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xdfffffff window]
[    0.223455] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.223465] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.223575] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    0.223679] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.223711] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.223766] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.223803] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.223833] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.223885] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.223936] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    0.223966] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.224020] pci 0000:00:09.0: System wakeup disabled by ACPI
[    0.224057] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    0.224086] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.224142] pci 0000:00:0a.0: System wakeup disabled by ACPI
[    0.224179] pci 0000:00:0b.0: [1002:5a1f] type 01 class 0x060400
[    0.224209] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
[    0.224264] pci 0000:00:0b.0: System wakeup disabled by ACPI
[    0.224301] pci 0000:00:0d.0: [1002:5a1e] type 01 class 0x060400
[    0.224331] pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
[    0.224384] pci 0000:00:0d.0: System wakeup disabled by ACPI
[    0.224426] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.224438] pci 0000:00:11.0: reg 0x10: [io  0xf090-0xf097]
[    0.224445] pci 0000:00:11.0: reg 0x14: [io  0xf080-0xf083]
[    0.224452] pci 0000:00:11.0: reg 0x18: [io  0xf070-0xf077]
[    0.224459] pci 0000:00:11.0: reg 0x1c: [io  0xf060-0xf063]
[    0.224466] pci 0000:00:11.0: reg 0x20: [io  0xf050-0xf05f]
[    0.224473] pci 0000:00:11.0: reg 0x24: [mem 0xd880b000-0xd880b3ff]
[    0.224576] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.224586] pci 0000:00:12.0: reg 0x10: [mem 0xd880a000-0xd880afff]
[    0.224676] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.224715] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.224728] pci 0000:00:12.2: reg 0x10: [mem 0xd8809000-0xd88090ff]
[    0.224786] pci 0000:00:12.2: supports D1 D2
[    0.224787] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.224838] pci 0000:00:12.2: System wakeup disabled by ACPI
[    0.224880] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.224889] pci 0000:00:13.0: reg 0x10: [mem 0xd8808000-0xd8808fff]
[    0.224980] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.225020] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.225032] pci 0000:00:13.2: reg 0x10: [mem 0xd8807000-0xd88070ff]
[    0.225090] pci 0000:00:13.2: supports D1 D2
[    0.225092] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.225145] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.225185] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.225307] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    0.225317] pci 0000:00:14.1: reg 0x10: [io  0xf040-0xf047]
[    0.225324] pci 0000:00:14.1: reg 0x14: [io  0xf030-0xf033]
[    0.225330] pci 0000:00:14.1: reg 0x18: [io  0xf020-0xf027]
[    0.225337] pci 0000:00:14.1: reg 0x1c: [io  0xf010-0xf013]
[    0.225344] pci 0000:00:14.1: reg 0x20: [io  0xf000-0xf00f]
[    0.225359] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.225363] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.225366] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.225370] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.225453] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.225468] pci 0000:00:14.2: reg 0x10: [mem 0xd8800000-0xd8803fff 64bit]
[    0.225517] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.225568] pci 0000:00:14.2: System wakeup disabled by ACPI
[    0.225604] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.225727] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.225800] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.225835] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.225845] pci 0000:00:14.5: reg 0x10: [mem 0xd8806000-0xd8806fff]
[    0.225934] pci 0000:00:14.5: System wakeup disabled by ACPI
[    0.225975] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
[    0.226026] pci 0000:00:15.0: supports D1 D2
[    0.226079] pci 0000:00:15.0: System wakeup disabled by ACPI
[    0.226120] pci 0000:00:15.1: [1002:43a1] type 01 class 0x060400
[    0.226171] pci 0000:00:15.1: supports D1 D2
[    0.226226] pci 0000:00:15.1: System wakeup disabled by ACPI
[    0.226264] pci 0000:00:15.2: [1002:43a2] type 01 class 0x060400
[    0.226315] pci 0000:00:15.2: supports D1 D2
[    0.226368] pci 0000:00:15.2: System wakeup disabled by ACPI
[    0.226409] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.226419] pci 0000:00:16.0: reg 0x10: [mem 0xd8805000-0xd8805fff]
[    0.226508] pci 0000:00:16.0: System wakeup disabled by ACPI
[    0.226548] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.226560] pci 0000:00:16.2: reg 0x10: [mem 0xd8804000-0xd88040ff]
[    0.226618] pci 0000:00:16.2: supports D1 D2
[    0.226620] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.226671] pci 0000:00:16.2: System wakeup disabled by ACPI
[    0.226711] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.226791] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.226868] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.226947] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.227028] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.227107] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.227226] pci 0000:01:00.0: [10de:0092] type 00 class 0x030000
[    0.227235] pci 0000:01:00.0: reg 0x10: [mem 0xda000000-0xdaffffff]
[    0.227243] pci 0000:01:00.0: reg 0x14: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.227251] pci 0000:01:00.0: reg 0x1c: [mem 0xd9000000-0xd9ffffff 64bit]
[    0.227257] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.227262] pci 0000:01:00.0: reg 0x30: [mem 0xdb000000-0xdb01ffff pref]
[    0.227328] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.227338] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.227343] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.227345] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.227348] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.227389] pci 0000:02:00.0: [104c:8231] type 01 class 0x060400
[    0.227476] pci 0000:02:00.0: supports D1 D2
[    0.227520] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.227531] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.227536] pci 0000:00:04.0:   bridge window [io  0x6000-0x7fff]
[    0.227538] pci 0000:00:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.227541] pci 0000:00:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.227601] pci 0000:03:04.0: [12d8:8150] type 01 class 0x060400
[    0.227754] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.227762] pci 0000:02:00.0:   bridge window [io  0x6000-0x7fff]
[    0.227766] pci 0000:02:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.227772] pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.227835] pci 0000:04:04.0: [10b5:0480] type 00 class 0x0e8000
[    0.227866] pci 0000:04:04.0: reg 0x10: [mem 0xdd909000-0xdd9093ff]
[    0.227882] pci 0000:04:04.0: reg 0x14: [mem 0xdd000000-0xdd7fffff]
[    0.227897] pci 0000:04:04.0: reg 0x18: [mem 0xdd908000-0xdd90800f]
[    0.228076] pci 0000:04:05.0: [10b5:0480] type 00 class 0x0e8000
[    0.228108] pci 0000:04:05.0: reg 0x10: [mem 0xdd907000-0xdd9073ff]
[    0.228123] pci 0000:04:05.0: reg 0x14: [mem 0xdc800000-0xdcffffff]
[    0.228139] pci 0000:04:05.0: reg 0x18: [mem 0xdd906000-0xdd90600f]
[    0.228315] pci 0000:04:06.0: [10b5:0480] type 00 class 0x0e8000
[    0.228345] pci 0000:04:06.0: reg 0x10: [mem 0xdd905000-0xdd9053ff]
[    0.228361] pci 0000:04:06.0: reg 0x14: [mem 0xdc000000-0xdc7fffff]
[    0.228377] pci 0000:04:06.0: reg 0x18: [mem 0xdd904000-0xdd90400f]
[    0.228554] pci 0000:04:07.0: [10b5:0480] type 00 class 0x0e8000
[    0.228584] pci 0000:04:07.0: reg 0x10: [mem 0xdd903000-0xdd9033ff]
[    0.228600] pci 0000:04:07.0: reg 0x14: [mem 0xdb800000-0xdbffffff]
[    0.228616] pci 0000:04:07.0: reg 0x18: [mem 0xdd902000-0xdd90200f]
[    0.228791] pci 0000:04:08.0: [3388:0022] type 01 class 0x060400
[    0.228918] pci 0000:04:08.0: supports D1 D2
[    0.228919] pci 0000:04:08.0: PME# supported from D0 D1 D2 D3hot
[    0.228974] pci 0000:04:09.0: [10b5:9030] type 00 class 0x070002
[    0.228996] pci 0000:04:09.0: reg 0x10: [mem 0xdd901000-0xdd90107f]
[    0.229012] pci 0000:04:09.0: reg 0x14: [io  0x7180-0x71ff]
[    0.229027] pci 0000:04:09.0: reg 0x18: [io  0x7100-0x717f]
[    0.229141] pci 0000:04:0a.0: [1090:4360] type 00 class 0x058000
[    0.229163] pci 0000:04:0a.0: reg 0x10: [mem 0xdd900000-0xdd9000ff]
[    0.229178] pci 0000:04:0a.0: reg 0x14: [io  0x7000-0x70ff]
[    0.229194] pci 0000:04:0a.0: reg 0x18: [mem 0xc0000000-0xc3ffffff pref]
[    0.229252] pci 0000:04:0a.0: reg 0x30: [mem 0xdd90a000-0xdd90a7ff pref]
[    0.229341] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.229351] pci 0000:03:04.0:   bridge window [io  0x6000-0x7fff]
[    0.229355] pci 0000:03:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.229362] pci 0000:03:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.229426] pci 0000:05:00.0: [1090:0100] type 00 class 0xff0000
[    0.229452] pci 0000:05:00.0: reg 0x10: [mem 0xdd80a000-0xdd80afff]
[    0.229470] pci 0000:05:00.0: reg 0x14: [mem 0xdd808000-0xdd809fff]
[    0.229489] pci 0000:05:00.0: reg 0x18: [mem 0xdd800000-0xdd807fff]
[    0.229680] pci 0000:04:08.0: PCI bridge to [bus 05]
[    0.229692] pci 0000:04:08.0:   bridge window [io  0x6000-0x6fff]
[    0.229697] pci 0000:04:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.229766] pci 0000:06:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.229781] pci 0000:06:00.0: reg 0x10: [mem 0xde100000-0xde107fff 64bit]
[    0.229850] pci 0000:06:00.0: supports D1 D2
[    0.229851] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.231110] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.231117] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.231158] pci 0000:07:00.0: [1b4b:9172] type 00 class 0x010601
[    0.231168] pci 0000:07:00.0: reg 0x10: [io  0xd040-0xd047]
[    0.231174] pci 0000:07:00.0: reg 0x14: [io  0xd030-0xd033]
[    0.231180] pci 0000:07:00.0: reg 0x18: [io  0xd020-0xd027]
[    0.231186] pci 0000:07:00.0: reg 0x1c: [io  0xd010-0xd013]
[    0.231192] pci 0000:07:00.0: reg 0x20: [io  0xd000-0xd00f]
[    0.231198] pci 0000:07:00.0: reg 0x24: [mem 0xde010000-0xde0101ff]
[    0.231204] pci 0000:07:00.0: reg 0x30: [mem 0xde000000-0xde00ffff pref]
[    0.231235] pci 0000:07:00.0: PME# supported from D3hot
[    0.233107] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.233113] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
[    0.233115] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.233163] pci 0000:08:00.0: [104c:8231] type 01 class 0x060400
[    0.233255] pci 0000:08:00.0: supports D1 D2
[    0.233301] pci 0000:08:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.233311] pci 0000:00:0b.0: PCI bridge to [bus 08-0d]
[    0.233317] pci 0000:00:0b.0:   bridge window [io  0xc000-0xcfff]
[    0.233319] pci 0000:00:0b.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.233321] pci 0000:00:0b.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.233383] pci 0000:09:04.0: [12d8:8150] type 01 class 0x060400
[    0.233540] pci 0000:08:00.0: PCI bridge to [bus 09-0d]
[    0.233549] pci 0000:08:00.0:   bridge window [io  0xc000-0xcfff]
[    0.233553] pci 0000:08:00.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.233559] pci 0000:08:00.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.233619] pci 0000:0a:04.0: [10b7:9200] type 00 class 0x020000
[    0.233645] pci 0000:0a:04.0: reg 0x10: [io  0xc200-0xc27f]
[    0.233662] pci 0000:0a:04.0: reg 0x14: [mem 0xd8743000-0xd874307f]
[    0.233735] pci 0000:0a:04.0: reg 0x30: [mem 0xd8700000-0xd871ffff pref]
[    0.233783] pci 0000:0a:04.0: supports D1 D2
[    0.233784] pci 0000:0a:04.0: PME# supported from D0 D1 D2 D3hot
[    0.233841] pci 0000:0a:05.0: [114a:5565] type 00 class 0x028000
[    0.233869] pci 0000:0a:05.0: reg 0x10: [mem 0xd8742000-0xd87421ff]
[    0.233885] pci 0000:0a:05.0: reg 0x14: [io  0xc100-0xc1ff]
[    0.233901] pci 0000:0a:05.0: reg 0x18: [mem 0xd8741000-0xd874103f]
[    0.233917] pci 0000:0a:05.0: reg 0x1c: [mem 0xd0000000-0xd7ffffff]
[    0.234068] pci 0000:0a:06.0: [3388:0022] type 01 class 0x060400
[    0.234198] pci 0000:0a:06.0: supports D1 D2
[    0.234200] pci 0000:0a:06.0: PME# supported from D0 D1 D2 D3hot
[    0.234262] pci 0000:0a:07.0: [3388:0022] type 01 class 0x060400
[    0.234391] pci 0000:0a:07.0: supports D1 D2
[    0.234392] pci 0000:0a:07.0: PME# supported from D0 D1 D2 D3hot
[    0.234454] pci 0000:0a:08.0: [3388:0022] type 01 class 0x060400
[    0.234583] pci 0000:0a:08.0: supports D1 D2
[    0.234585] pci 0000:0a:08.0: PME# supported from D0 D1 D2 D3hot
[    0.234639] pci 0000:0a:09.0: [114f:0027] type 00 class 0x078000
[    0.234661] pci 0000:0a:09.0: reg 0x10: [mem 0xd8000000-0xd83fffff]
[    0.234749] pci 0000:0a:09.0: reg 0x30: [mem 0xd8730000-0xd873ffff pref]
[    0.234809] pci 0000:0a:0a.0: [9004:3860] type 00 class 0x010000
[    0.234836] pci 0000:0a:0a.0: reg 0x10: [io  0xc000-0xc0ff]
[    0.234852] pci 0000:0a:0a.0: reg 0x14: [mem 0xd8740000-0xd8740fff]
[    0.234926] pci 0000:0a:0a.0: reg 0x30: [mem 0xd8720000-0xd872ffff pref]
[    0.235048] pci 0000:09:04.0: PCI bridge to [bus 0a-0d]
[    0.235058] pci 0000:09:04.0:   bridge window [io  0xc000-0xcfff]
[    0.235062] pci 0000:09:04.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.235069] pci 0000:09:04.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.235139] pci 0000:0b:00.0: [1090:4710] type 00 class 0xff0000
[    0.235170] pci 0000:0b:00.0: reg 0x10: [mem 0xd8600000-0xd86001ff]
[    0.235188] pci 0000:0b:00.0: reg 0x14: [mem 0xc6000000-0xc6ffffff pref]
[    0.235432] pci 0000:0a:06.0: PCI bridge to [bus 0b]
[    0.235448] pci 0000:0a:06.0:   bridge window [mem 0xd8600000-0xd86fffff]
[    0.235458] pci 0000:0a:06.0:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
[    0.235529] pci 0000:0c:00.0: [1090:4710] type 00 class 0xff0000
[    0.235560] pci 0000:0c:00.0: reg 0x10: [mem 0xd8500000-0xd85001ff]
[    0.235578] pci 0000:0c:00.0: reg 0x14: [mem 0xc5000000-0xc5ffffff pref]
[    0.235824] pci 0000:0a:07.0: PCI bridge to [bus 0c]
[    0.235840] pci 0000:0a:07.0:   bridge window [mem 0xd8500000-0xd85fffff]
[    0.235850] pci 0000:0a:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.235920] pci 0000:0d:00.0: [1090:4710] type 00 class 0xff0000
[    0.235954] pci 0000:0d:00.0: reg 0x10: [mem 0xd8400000-0xd84001ff]
[    0.235974] pci 0000:0d:00.0: reg 0x14: [mem 0xc4000000-0xc4ffffff pref]
[    0.236221] pci 0000:0a:08.0: PCI bridge to [bus 0d]
[    0.236237] pci 0000:0a:08.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.236246] pci 0000:0a:08.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.236331] pci 0000:0e:00.0: [10b5:8114] type 01 class 0x060400
[    0.236350] pci 0000:0e:00.0: reg 0x10: [mem 0xddc00000-0xddc01fff]
[    0.236451] pci 0000:0e:00.0: PME# supported from D0 D3hot
[    0.236521] pci 0000:0e:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.236533] pci 0000:00:0d.0: PCI bridge to [bus 0e-0f]
[    0.236538] pci 0000:00:0d.0:   bridge window [io  0xb000-0xbfff]
[    0.236540] pci 0000:00:0d.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.236606] pci 0000:0f:04.0: [9005:8017] type 00 class 0x010000
[    0.236629] pci 0000:0f:04.0: reg 0x10: [io  0xb100-0xb1ff]
[    0.236646] pci 0000:0f:04.0: reg 0x14: [mem 0xddb80000-0xddb81fff 64bit]
[    0.236657] pci 0000:0f:04.0: reg 0x1c: [io  0xb000-0xb0ff]
[    0.236688] pci 0000:0f:04.0: reg 0x30: [mem 0xddb00000-0xddb7ffff pref]
[    0.236808] pci 0000:0e:00.0: PCI bridge to [bus 0f]
[    0.236817] pci 0000:0e:00.0:   bridge window [io  0xb000-0xbfff]
[    0.236821] pci 0000:0e:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.236870] pci 0000:10:06.0: [1090:4610] type 00 class 0xff0000
[    0.236883] pci 0000:10:06.0: reg 0x10: [io  0xa000-0xa03f]
[    0.236892] pci 0000:10:06.0: reg 0x14: [mem 0xddf00000-0xddf00fff]
[    0.237002] pci 0000:00:14.4: PCI bridge to [bus 10] (subtractive decode)
[    0.237008] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
[    0.237011] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.237014] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.237015] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.237017] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.237018] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.237019] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.237021] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.237022] pci 0000:00:14.4:   bridge window [mem 0xb0000000-0xdfffffff window] (subtractive decode)
[    0.237085] pci 0000:11:00.0: [10ec:8168] type 00 class 0x020000
[    0.237104] pci 0000:11:00.0: reg 0x10: [io  0x9000-0x90ff]
[    0.237128] pci 0000:11:00.0: reg 0x18: [mem 0xc7004000-0xc7004fff 64bit pref]
[    0.237143] pci 0000:11:00.0: reg 0x20: [mem 0xc7000000-0xc7003fff 64bit pref]
[    0.237224] pci 0000:11:00.0: supports D1 D2
[    0.237225] pci 0000:11:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.237267] pci 0000:11:00.0: System wakeup disabled by ACPI
[    0.239111] pci 0000:00:15.0: PCI bridge to [bus 11]
[    0.239119] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
[    0.239124] pci 0000:00:15.0:   bridge window [mem 0xc7000000-0xc70fffff 64bit pref]
[    0.239179] pci 0000:12:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.239201] pci 0000:12:00.0: reg 0x10: [mem 0xdde00000-0xdde07fff 64bit]
[    0.239298] pci 0000:12:00.0: supports D1 D2
[    0.239299] pci 0000:12:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.241110] pci 0000:00:15.1: PCI bridge to [bus 12]
[    0.241119] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.241173] pci 0000:13:00.0: [1b4b:9172] type 00 class 0x010601
[    0.241187] pci 0000:13:00.0: reg 0x10: [io  0x8040-0x8047]
[    0.241196] pci 0000:13:00.0: reg 0x14: [io  0x8030-0x8033]
[    0.241204] pci 0000:13:00.0: reg 0x18: [io  0x8020-0x8027]
[    0.241213] pci 0000:13:00.0: reg 0x1c: [io  0x8010-0x8013]
[    0.241221] pci 0000:13:00.0: reg 0x20: [io  0x8000-0x800f]
[    0.241229] pci 0000:13:00.0: reg 0x24: [mem 0xddd10000-0xddd101ff]
[    0.241238] pci 0000:13:00.0: reg 0x30: [mem 0xddd00000-0xddd0ffff pref]
[    0.241282] pci 0000:13:00.0: PME# supported from D3hot
[    0.243108] pci 0000:00:15.2: PCI bridge to [bus 13]
[    0.243115] pci 0000:00:15.2:   bridge window [io  0x8000-0x8fff]
[    0.243118] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.243154] pci_bus 0000:00: on NUMA node 0
[    0.243640] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.243719] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.243801] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.243881] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 11 14 15) *0
[    0.243948] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 10 11 14 15) *0
[    0.244002] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 10 11 14 15) *0
[    0.244054] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 10 11 14 15) *0
[    0.244109] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 10 11 14 15) *0
[    0.244279] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.244283] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.244293] vgaarb: loaded
[    0.244297] vgaarb: bridge control possible 0000:01:00.0
[    0.244373] SCSI subsystem initialized
[    0.244414] libata version 3.00 loaded.
[    0.244418] ACPI: bus type USB registered
[    0.244435] usbcore: registered new interface driver usbfs
[    0.244447] usbcore: registered new interface driver hub
[    0.244473] usbcore: registered new device driver usb
[    0.244580] PCI: Using ACPI for IRQ routing
[    0.244585] PCI: pci_cache_line_size set to 64 bytes
[    0.244746] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.244748] e820: reserve RAM buffer [mem 0xae475000-0xafffffff]
[    0.244749] e820: reserve RAM buffer [mem 0xaf156000-0xafffffff]
[    0.244750] e820: reserve RAM buffer [mem 0xaf800000-0xafffffff]
[    0.244844] NetLabel: Initializing
[    0.244847] NetLabel:  domain hash size = 128
[    0.244850] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.244861] NetLabel:  unlabeled traffic allowed by default
[    0.244892] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.244897] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.246973] clocksource: Switched to clocksource hpet
[    0.250078] VFS: Disk quotas dquot_6.6.0
[    0.250093] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.250180] pnp: PnP ACPI init
[    0.250295] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.250301] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.250662] system 00:01: [io  0x040b] has been reserved
[    0.250667] system 00:01: [io  0x04d6] has been reserved
[    0.250671] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.250675] system 00:01: [io  0x0c14] has been reserved
[    0.250679] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.250683] system 00:01: [io  0x0c52] has been reserved
[    0.250688] system 00:01: [io  0x0c6c] has been reserved
[    0.250692] system 00:01: [io  0x0c6f] has been reserved
[    0.250696] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.250700] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.250704] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.250708] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.250712] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.250716] system 00:01: [io  0x0800-0x089f] could not be reserved
[    0.250720] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.250724] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.250728] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.250733] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.250737] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.250742] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.250746] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.250750] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.250755] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.250759] system 00:01: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.250763] system 00:01: [mem 0xffc00000-0xffffffff] has been reserved
[    0.250768] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.250968] system 00:02: [io  0x0220-0x0227] has been reserved
[    0.250973] system 00:02: [io  0x0228-0x0237] has been reserved
[    0.250977] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    0.250982] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.251028] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.251298] pnp 00:04: [dma 0 disabled]
[    0.251337] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.251363] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.251453] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.251458] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.251521] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.251693] system 00:08: [mem 0xfeb20000-0xfeb23fff] has been reserved
[    0.251699] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.251848] system 00:09: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.251853] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.251974] pnp: PnP ACPI: found 10 devices
[    0.258598] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.258731] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.258736] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.258741] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.258746] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.258755] pci 0000:04:08.0: PCI bridge to [bus 05]
[    0.258760] pci 0000:04:08.0:   bridge window [io  0x6000-0x6fff]
[    0.258771] pci 0000:04:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.258787] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.258793] pci 0000:03:04.0:   bridge window [io  0x6000-0x7fff]
[    0.258801] pci 0000:03:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.258808] pci 0000:03:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.258820] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.258824] pci 0000:02:00.0:   bridge window [io  0x6000-0x7fff]
[    0.258832] pci 0000:02:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.258838] pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.258848] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.258852] pci 0000:00:04.0:   bridge window [io  0x6000-0x7fff]
[    0.258857] pci 0000:00:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.258862] pci 0000:00:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.258869] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.258873] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.258879] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.258883] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
[    0.258888] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.258895] pci 0000:0a:06.0: PCI bridge to [bus 0b]
[    0.258905] pci 0000:0a:06.0:   bridge window [mem 0xd8600000-0xd86fffff]
[    0.258913] pci 0000:0a:06.0:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
[    0.258928] pci 0000:0a:07.0: PCI bridge to [bus 0c]
[    0.258938] pci 0000:0a:07.0:   bridge window [mem 0xd8500000-0xd85fffff]
[    0.258946] pci 0000:0a:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.258965] pci 0000:0a:08.0: PCI bridge to [bus 0d]
[    0.258975] pci 0000:0a:08.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.258983] pci 0000:0a:08.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.258997] pci 0000:09:04.0: PCI bridge to [bus 0a-0d]
[    0.259003] pci 0000:09:04.0:   bridge window [io  0xc000-0xcfff]
[    0.259011] pci 0000:09:04.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.259018] pci 0000:09:04.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.259030] pci 0000:08:00.0: PCI bridge to [bus 09-0d]
[    0.259034] pci 0000:08:00.0:   bridge window [io  0xc000-0xcfff]
[    0.259042] pci 0000:08:00.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.259048] pci 0000:08:00.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.259058] pci 0000:00:0b.0: PCI bridge to [bus 08-0d]
[    0.259062] pci 0000:00:0b.0:   bridge window [io  0xc000-0xcfff]
[    0.259067] pci 0000:00:0b.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.259071] pci 0000:00:0b.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.259079] pci 0000:0e:00.0: PCI bridge to [bus 0f]
[    0.259084] pci 0000:0e:00.0:   bridge window [io  0xb000-0xbfff]
[    0.259093] pci 0000:0e:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.259107] pci 0000:00:0d.0: PCI bridge to [bus 0e-0f]
[    0.259111] pci 0000:00:0d.0:   bridge window [io  0xb000-0xbfff]
[    0.259116] pci 0000:00:0d.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.259122] pci 0000:00:14.4: PCI bridge to [bus 10]
[    0.259127] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
[    0.259133] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.259141] pci 0000:00:15.0: PCI bridge to [bus 11]
[    0.259145] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
[    0.259152] pci 0000:00:15.0:   bridge window [mem 0xc7000000-0xc70fffff 64bit pref]
[    0.259161] pci 0000:00:15.1: PCI bridge to [bus 12]
[    0.259166] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.259174] pci 0000:00:15.2: PCI bridge to [bus 13]
[    0.259178] pci 0000:00:15.2:   bridge window [io  0x8000-0x8fff]
[    0.259184] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.259192] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.259193] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.259195] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.259196] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.259197] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.259199] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.259200] pci_bus 0000:00: resource 10 [mem 0xb0000000-0xdfffffff window]
[    0.259201] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.259203] pci_bus 0000:01: resource 1 [mem 0xd9000000-0xdb0fffff]
[    0.259204] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.259206] pci_bus 0000:02: resource 0 [io  0x6000-0x7fff]
[    0.259207] pci_bus 0000:02: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.259208] pci_bus 0000:02: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.259210] pci_bus 0000:03: resource 0 [io  0x6000-0x7fff]
[    0.259211] pci_bus 0000:03: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.259212] pci_bus 0000:03: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.259213] pci_bus 0000:04: resource 0 [io  0x6000-0x7fff]
[    0.259215] pci_bus 0000:04: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.259216] pci_bus 0000:04: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.259217] pci_bus 0000:05: resource 0 [io  0x6000-0x6fff]
[    0.259219] pci_bus 0000:05: resource 1 [mem 0xdd800000-0xdd8fffff]
[    0.259220] pci_bus 0000:06: resource 1 [mem 0xde100000-0xde1fffff]
[    0.259222] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.259223] pci_bus 0000:07: resource 1 [mem 0xde000000-0xde0fffff]
[    0.259224] pci_bus 0000:08: resource 0 [io  0xc000-0xcfff]
[    0.259226] pci_bus 0000:08: resource 1 [mem 0xd0000000-0xd87fffff]
[    0.259227] pci_bus 0000:08: resource 2 [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.259228] pci_bus 0000:09: resource 0 [io  0xc000-0xcfff]
[    0.259229] pci_bus 0000:09: resource 1 [mem 0xd0000000-0xd87fffff]
[    0.259231] pci_bus 0000:09: resource 2 [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.259232] pci_bus 0000:0a: resource 0 [io  0xc000-0xcfff]
[    0.259233] pci_bus 0000:0a: resource 1 [mem 0xd0000000-0xd87fffff]
[    0.259235] pci_bus 0000:0a: resource 2 [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.259236] pci_bus 0000:0b: resource 1 [mem 0xd8600000-0xd86fffff]
[    0.259238] pci_bus 0000:0b: resource 2 [mem 0xc6000000-0xc6ffffff 64bit pref]
[    0.259239] pci_bus 0000:0c: resource 1 [mem 0xd8500000-0xd85fffff]
[    0.259240] pci_bus 0000:0c: resource 2 [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.259242] pci_bus 0000:0d: resource 1 [mem 0xd8400000-0xd84fffff]
[    0.259243] pci_bus 0000:0d: resource 2 [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.259244] pci_bus 0000:0e: resource 0 [io  0xb000-0xbfff]
[    0.259246] pci_bus 0000:0e: resource 1 [mem 0xddb00000-0xddcfffff]
[    0.259247] pci_bus 0000:0f: resource 0 [io  0xb000-0xbfff]
[    0.259248] pci_bus 0000:0f: resource 1 [mem 0xddb00000-0xddbfffff]
[    0.259250] pci_bus 0000:10: resource 0 [io  0xa000-0xafff]
[    0.259251] pci_bus 0000:10: resource 1 [mem 0xddf00000-0xddffffff]
[    0.259252] pci_bus 0000:10: resource 4 [io  0x0000-0x03af window]
[    0.259253] pci_bus 0000:10: resource 5 [io  0x03e0-0x0cf7 window]
[    0.259255] pci_bus 0000:10: resource 6 [io  0x03b0-0x03df window]
[    0.259256] pci_bus 0000:10: resource 7 [io  0x0d00-0xffff window]
[    0.259257] pci_bus 0000:10: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.259259] pci_bus 0000:10: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.259260] pci_bus 0000:10: resource 10 [mem 0xb0000000-0xdfffffff window]
[    0.259261] pci_bus 0000:11: resource 0 [io  0x9000-0x9fff]
[    0.259263] pci_bus 0000:11: resource 2 [mem 0xc7000000-0xc70fffff 64bit pref]
[    0.259264] pci_bus 0000:12: resource 1 [mem 0xdde00000-0xddefffff]
[    0.259265] pci_bus 0000:13: resource 0 [io  0x8000-0x8fff]
[    0.259267] pci_bus 0000:13: resource 1 [mem 0xddd00000-0xdddfffff]
[    0.259287] NET: Registered protocol family 2
[    0.259434] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.259678] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.259867] TCP: Hash tables configured (established 131072 bind 65536)
[    0.259898] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.259953] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.260053] NET: Registered protocol family 1
[    0.556016] pci 0000:01:00.0: Video device with shadowed ROM
[    0.556019] pci 0000:02:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.556075] pci 0000:08:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.556151] PCI: CLS 64 bytes, default 64
[    0.556198] Unpacking initramfs...
[    1.215070] microcode: microcode: updated early to new patch_level=0x0600063d
[    1.216708] Freeing initrd memory: 7848K (ffff88003709c000 - ffff880037846000)
[    1.216791] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: 3e info 1300
[    1.216795] AMD-Vi:        mmio-addr: 00000000feb20000
[    1.216816] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:00.0 flags: 00
[    1.216820] AMD-Vi:   DEV_RANGE_END		 devid: 00:00.2
[    1.216824] AMD-Vi:   DEV_SELECT			 devid: 00:02.0 flags: 00
[    1.216827] AMD-Vi:   DEV_SELECT			 devid: 01:00.0 flags: 00
[    1.216831] AMD-Vi:   DEV_SELECT			 devid: 00:04.0 flags: 00
[    1.216834] AMD-Vi:   DEV_SELECT			 devid: 02:00.0 flags: 00
[    1.216838] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 03:01.0 flags: 00 devid_to: 03:00.0
[    1.216843] AMD-Vi:   DEV_RANGE_END		 devid: 05:1f.7
[    1.216857] AMD-Vi:   DEV_SELECT			 devid: 00:09.0 flags: 00
[    1.216860] AMD-Vi:   DEV_SELECT			 devid: 06:00.0 flags: 00
[    1.216864] AMD-Vi:   DEV_SELECT			 devid: 00:0a.0 flags: 00
[    1.216867] AMD-Vi:   DEV_SELECT			 devid: 07:00.0 flags: 00
[    1.216870] AMD-Vi:   DEV_SELECT			 devid: 00:0b.0 flags: 00
[    1.216873] AMD-Vi:   DEV_SELECT			 devid: 08:00.0 flags: 00
[    1.216877] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 09:01.0 flags: 00 devid_to: 09:00.0
[    1.216882] AMD-Vi:   DEV_RANGE_END		 devid: 0d:1f.7
[    1.216904] AMD-Vi:   DEV_SELECT			 devid: 00:0d.0 flags: 00
[    1.216907] AMD-Vi:   DEV_SELECT			 devid: 0e:00.0 flags: 00
[    1.216911] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 0f:01.0 flags: 00 devid_to: 0f:00.0
[    1.216916] AMD-Vi:   DEV_RANGE_END		 devid: 0f:1f.7
[    1.216922] AMD-Vi:   DEV_SELECT			 devid: 00:11.0 flags: 00
[    1.216926] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:12.0 flags: 00
[    1.216929] AMD-Vi:   DEV_RANGE_END		 devid: 00:12.2
[    1.216933] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:13.0 flags: 00
[    1.216936] AMD-Vi:   DEV_RANGE_END		 devid: 00:13.2
[    1.216939] AMD-Vi:   DEV_SELECT			 devid: 00:14.0 flags: d7
[    1.216942] AMD-Vi:   DEV_SELECT			 devid: 00:14.1 flags: 00
[    1.216946] AMD-Vi:   DEV_SELECT			 devid: 00:14.2 flags: 00
[    1.216949] AMD-Vi:   DEV_SELECT			 devid: 00:14.3 flags: 00
[    1.216952] AMD-Vi:   DEV_SELECT			 devid: 00:14.4 flags: 00
[    1.216956] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 10:00.0 flags: 00 devid_to: 00:14.4
[    1.216961] AMD-Vi:   DEV_RANGE_END		 devid: 10:1f.7
[    1.216968] AMD-Vi:   DEV_SELECT			 devid: 00:14.5 flags: 00
[    1.216986] AMD-Vi:   DEV_SELECT			 devid: 00:15.0 flags: 00
[    1.216990] AMD-Vi:   DEV_SELECT			 devid: 11:00.0 flags: 00
[    1.216993] AMD-Vi:   DEV_SELECT			 devid: 00:15.1 flags: 00
[    1.216996] AMD-Vi:   DEV_SELECT			 devid: 12:00.0 flags: 00
[    1.217000] AMD-Vi:   DEV_SELECT			 devid: 00:15.2 flags: 00
[    1.217003] AMD-Vi:   DEV_SELECT			 devid: 13:00.0 flags: 00
[    1.217006] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:16.0 flags: 00
[    1.217010] AMD-Vi:   DEV_RANGE_END		 devid: 00:16.2
[    1.217013] AMD-Vi:   DEV_SPECIAL(IOAPIC[9])		devid: 00:14.0
[    1.217017] AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
[    1.217021] AMD-Vi:   DEV_SPECIAL(IOAPIC[10])		devid: 00:00.1
[    1.362037] iommu: Adding device 0000:00:00.0 to group 0
[    1.362415] iommu: Adding device 0000:00:02.0 to group 1
[    1.362796] iommu: Adding device 0000:00:04.0 to group 2
[    1.363179] iommu: Adding device 0000:00:09.0 to group 3
[    1.363561] iommu: Adding device 0000:00:0a.0 to group 4
[    1.363938] iommu: Adding device 0000:00:0b.0 to group 5
[    1.364321] iommu: Adding device 0000:00:0d.0 to group 6
[    1.364696] iommu: Adding device 0000:00:11.0 to group 7
[    1.365101] iommu: Adding device 0000:00:12.0 to group 8
[    1.365123] iommu: Adding device 0000:00:12.2 to group 8
[    1.365518] iommu: Adding device 0000:00:13.0 to group 9
[    1.365542] iommu: Adding device 0000:00:13.2 to group 9
[    1.365921] iommu: Adding device 0000:00:14.0 to group 10
[    1.366303] iommu: Adding device 0000:00:14.1 to group 11
[    1.366684] iommu: Adding device 0000:00:14.2 to group 12
[    1.367065] iommu: Adding device 0000:00:14.3 to group 13
[    1.367445] iommu: Adding device 0000:00:14.4 to group 14
[    1.367822] iommu: Adding device 0000:00:14.5 to group 15
[    1.368239] iommu: Adding device 0000:00:15.0 to group 16
[    1.368265] iommu: Adding device 0000:00:15.1 to group 16
[    1.368293] iommu: Adding device 0000:00:15.2 to group 16
[    1.368690] iommu: Adding device 0000:00:16.0 to group 17
[    1.368715] iommu: Adding device 0000:00:16.2 to group 17
[    1.369103] iommu: Adding device 0000:01:00.0 to group 18
[    1.369483] iommu: Adding device 0000:02:00.0 to group 19
[    1.369494] iommu: Adding device 0000:03:04.0 to group 19
[    1.369505] iommu: Adding device 0000:04:04.0 to group 19
[    1.369516] iommu: Adding device 0000:04:05.0 to group 19
[    1.369527] iommu: Adding device 0000:04:06.0 to group 19
[    1.369539] iommu: Adding device 0000:04:07.0 to group 19
[    1.369549] iommu: Adding device 0000:04:08.0 to group 19
[    1.369560] iommu: Adding device 0000:04:09.0 to group 19
[    1.369570] iommu: Adding device 0000:04:0a.0 to group 19
[    1.369581] iommu: Adding device 0000:05:00.0 to group 19
[    1.369965] iommu: Adding device 0000:06:00.0 to group 20
[    1.370350] iommu: Adding device 0000:07:00.0 to group 21
[    1.370733] iommu: Adding device 0000:08:00.0 to group 22
[    1.370744] iommu: Adding device 0000:09:04.0 to group 22
[    1.370755] iommu: Adding device 0000:0a:04.0 to group 22
[    1.370765] iommu: Adding device 0000:0a:05.0 to group 22
[    1.370776] iommu: Adding device 0000:0a:06.0 to group 22
[    1.370787] iommu: Adding device 0000:0a:07.0 to group 22
[    1.370797] iommu: Adding device 0000:0a:08.0 to group 22
[    1.370809] iommu: Adding device 0000:0a:09.0 to group 22
[    1.370820] iommu: Adding device 0000:0a:0a.0 to group 22
[    1.370830] iommu: Adding device 0000:0b:00.0 to group 22
[    1.370841] iommu: Adding device 0000:0c:00.0 to group 22
[    1.370852] iommu: Adding device 0000:0d:00.0 to group 22
[    1.371242] iommu: Adding device 0000:0e:00.0 to group 23
[    1.371253] iommu: Adding device 0000:0f:04.0 to group 23
[    1.371264] iommu: Adding device 0000:10:06.0 to group 14
[    1.371280] iommu: Adding device 0000:11:00.0 to group 16
[    1.371294] iommu: Adding device 0000:12:00.0 to group 16
[    1.371306] iommu: Adding device 0000:13:00.0 to group 16
[    1.371310] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.371390] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.373394] perf: AMD NB counters detected
[    1.373454] LVT offset 0 assigned for vector 0x400
[    1.373473] perf: AMD IBS detected (0x000000ff)
[    1.374058] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    1.374096] audit: initializing netlink subsys (disabled)
[    1.374112] audit: type=2000 audit(1456513218.252:1): initialized
[    1.374292] Initialise system trusted keyring
[    1.375971] zbud: loaded
[    1.376790] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.376797] io scheduler noop registered
[    1.376802] io scheduler deadline registered
[    1.376830] io scheduler cfq registered (default)
[    1.377621] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.377630] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.377656] vesafb: mode is 1280x1024x16, linelength=2560, pages=0
[    1.377660] vesafb: scrolling: redraw
[    1.377663] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    1.377671] pmd_set_huge: Cannot satisfy [mem 0xb0000000-0xb0200000] with a huge-page mapping due to MTRR override.
[    1.377684] vesafb: framebuffer at 0xb0000000, mapped to 0xffffc90000400000, using 2560k, total 2560k
[    1.393195] Console: switching to colour frame buffer device 160x64
[    1.408658] fb0: VESA VGA frame buffer device
[    1.408768] GHES: HEST is not enabled!
[    1.408873] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.429485] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.430304] Non-volatile memory driver v1.3
[    1.430408] Linux agpgart interface v0.103
[    1.433408] ahci 0000:00:11.0: version 3.0
[    1.433491] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    1.433633] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    1.434284] scsi host0: ahci
[    1.434416] scsi host1: ahci
[    1.434543] scsi host2: ahci
[    1.434679] scsi host3: ahci
[    1.434766] ata1: SATA max UDMA/133 abar m1024@0xd880b000 port 0xd880b100 irq 19
[    1.434895] ata2: SATA max UDMA/133 abar m1024@0xd880b000 port 0xd880b180 irq 19
[    1.435029] ata3: SATA max UDMA/133 abar m1024@0xd880b000 port 0xd880b200 irq 19
[    1.435158] ata4: SATA max UDMA/133 abar m1024@0xd880b000 port 0xd880b280 irq 19
[    1.435469] ahci 0000:07:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.435610] ahci 0000:07:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.437069] scsi host4: ahci
[    1.437231] scsi host5: ahci
[    1.437319] ata5: SATA max UDMA/133 abar m512@0xde010000 port 0xde010100 irq 29
[    1.437447] ata6: SATA max UDMA/133 abar m512@0xde010000 port 0xde010180 irq 29
[    1.437729] ahci 0000:13:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.437870] ahci 0000:13:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.438303] scsi host6: ahci
[    1.438438] scsi host7: ahci
[    1.438524] ata7: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10100 irq 28
[    1.438653] ata8: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10180 irq 28
[    1.438793] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.438909] ehci-pci: EHCI PCI platform driver
[    1.439076] QUIRK: Enable AMD PLL fix
[    1.439096] ehci-pci 0000:00:12.2: EHCI Host Controller
[    1.439190] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    1.439320] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.439477] ehci-pci 0000:00:12.2: debug port 1
[    1.439580] ehci-pci 0000:00:12.2: irq 17, io mem 0xd8809000
[    1.444991] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.445139] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.445256] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.445381] usb usb1: Product: EHCI Host Controller
[    1.449823] usb usb1: Manufacturer: Linux 4.5.0-rc5 ehci_hcd
[    1.454286] usb usb1: SerialNumber: 0000:00:12.2
[    1.458840] hub 1-0:1.0: USB hub found
[    1.463281] hub 1-0:1.0: 5 ports detected
[    1.467882] ehci-pci 0000:00:13.2: EHCI Host Controller
[    1.472301] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    1.476742] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.481230] ehci-pci 0000:00:13.2: debug port 1
[    1.485668] ehci-pci 0000:00:13.2: irq 17, io mem 0xd8807000
[    1.495995] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.500402] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.504800] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.509215] usb usb2: Product: EHCI Host Controller
[    1.513643] usb usb2: Manufacturer: Linux 4.5.0-rc5 ehci_hcd
[    1.518110] usb usb2: SerialNumber: 0000:00:13.2
[    1.522638] hub 2-0:1.0: USB hub found
[    1.527039] hub 2-0:1.0: 5 ports detected
[    1.531572] ehci-pci 0000:00:16.2: EHCI Host Controller
[    1.535933] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 3
[    1.540340] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.544775] ehci-pci 0000:00:16.2: debug port 1
[    1.549132] ehci-pci 0000:00:16.2: irq 17, io mem 0xd8804000
[    1.558995] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    1.563239] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.567501] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.571727] usb usb3: Product: EHCI Host Controller
[    1.575952] usb usb3: Manufacturer: Linux 4.5.0-rc5 ehci_hcd
[    1.580174] usb usb3: SerialNumber: 0000:00:16.2
[    1.584429] hub 3-0:1.0: USB hub found
[    1.588547] hub 3-0:1.0: 4 ports detected
[    1.592754] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.596873] uhci_hcd: USB Universal Host Controller Interface driver
[    1.601024] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.605136] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.609538] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.613962] mousedev: PS/2 mouse device common for all mice
[    1.619477] rtc_cmos 00:05: RTC can wake from S4
[    1.623956] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.628413] rtc_cmos 00:05: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.633100] ledtrig-cpu: registered to indicate activity on CPUs
[    1.637720] hidraw: raw HID events driver (C) Jiri Kosina
[    1.642392] usbcore: registered new interface driver usbhid
[    1.646963] usbhid: USB HID core driver
[    1.651500] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.656416] NET: Registered protocol family 10
[    1.661268] Key type dns_resolver registered
[    1.666324] microcode: CPU0: patch_level=0x0600063d
[    1.671005] microcode: CPU1: patch_level=0x0600063d
[    1.675612] microcode: CPU2: patch_level=0x0600063d
[    1.680129] microcode: CPU3: patch_level=0x0600063d
[    1.684664] microcode: CPU4: patch_level=0x0600063d
[    1.689101] microcode: CPU5: patch_level=0x0600063d
[    1.693540] microcode: CPU6: patch_level=0x0600063d
[    1.697886] microcode: CPU7: patch_level=0x0600063d
[    1.702190] microcode: Microcode Update Driver: v2.01 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    1.706736] registered taskstats version 1
[    1.711115] Loading compiled-in X.509 certificates
[    1.715493] zswap: loaded using pool lzo/zbud
[    1.720481]   Magic number: 4:905:41
[    1.724880] rtc_cmos 00:05: setting system clock to 2016-02-26 19:00:19 UTC (1456513219)
[    1.742735] ata5: SATA link down (SStatus 0 SControl 300)
[    1.747195] ata6: SATA link down (SStatus 0 SControl 300)
[    1.891003] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.895394] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.896020] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.897569] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[    1.908338] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.912744] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.962276] ata2.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    1.966602] ata2.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.970941] ata3.00: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
[    1.975253] ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.979629] ata4.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    1.984024] ata4.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.988427] ata1.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[    1.992824] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.028905] ata2.00: configured for UDMA/133
[    2.033301] ata3.00: configured for UDMA/133
[    2.037651] ata4.00: configured for UDMA/133
[    2.041946] ata1.00: configured for UDMA/133
[    2.046327] scsi 0:0:0:0: Direct-Access     ATA      ST3160815AS      B    PQ: 0 ANSI: 5
[    2.056128] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.056260] scsi 1:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.064945] sd 0:0:0:0: [sda] Write Protect is off
[    2.069285] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.069295] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.076116] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.076257] scsi 2:0:0:0: Direct-Access     ATA      ST3160811AS      E    PQ: 0 ANSI: 5
[    2.085152] sd 1:0:0:0: [sdb] Write Protect is off
[    2.089633] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.089644] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.097129] sd 2:0:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.101764] sd 2:0:0:0: [sdc] Write Protect is off
[    2.106333] scsi 3:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.110975] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.110990] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.120134] sd 3:0:0:0: [sdd] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.124906] sd 3:0:0:0: [sdd] Write Protect is off
[    2.129592] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.129602] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.151748]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
[    2.156781] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.175906]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 >
[    2.180837] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.206207]  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 >
[    2.211133] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.215702]  sdd: sdd1 sdd2 sdd3 < sdd5 sdd6 sdd7 >
[    2.220543] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.375001] tsc: Refined TSC clocksource calibration: 3616.533 MHz
[    2.379546] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x34215592ba9, max_idle_ns: 440795323316 ns
[    3.384077] clocksource: Switched to clocksource tsc
[    6.896070] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.902551] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   12.154112] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   12.160310] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   12.165064] ata7: limiting SATA link speed to 1.5 Gbps
[   17.311169] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   17.316793] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   17.321791] ata8: limiting SATA link speed to 1.5 Gbps
[   22.569229] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   22.575908] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   27.727284] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   27.733274] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   32.986342] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   33.189344] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   33.195244] Freeing unused kernel memory: 996K (ffffffff80ed7000 - ffffffff80fd0000)
[   33.200505] Write protecting the kernel read-only data: 12288k
[   33.206263] Freeing unused kernel memory: 1808K (ffff88000083c000 - ffff880000a00000)
[   33.213547] Freeing unused kernel memory: 1072K (ffff880000cf4000 - ffff880000e00000)
[   33.220301] random: systemd urandom read with 91 bits of entropy available
[   33.226340] systemd[1]: systemd 210 running in system mode. (+PAM -LIBWRAP +AUDIT +SELINUX -IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ +SECCOMP +APPARMOR)
[   33.232147] systemd[1]: Detected architecture 'x86-64'.
[   33.237788] systemd[1]: Running in initial RAM disk.
[   33.260880] systemd[1]: Inserted module 'autofs4'
[   33.266626] systemd[1]: Set hostname to <harley>.
[   33.304019] systemd[1]: Expecting device dev-disk-by\x2did-ata\x2dST3160815AS_6RACD7A6\x2dpart5.device...
[   33.315719] systemd[1]: Starting Timers.
[   33.327297] systemd[1]: Reached target Timers.
[   33.333065] systemd[1]: Starting -.slice.
[   33.352072] systemd[1]: Created slice -.slice.
[   33.357920] systemd[1]: Starting udev Control Socket.
[   33.369707] systemd[1]: Listening on udev Control Socket.
[   33.375579] systemd[1]: Starting udev Kernel Socket.
[   33.387203] systemd[1]: Listening on udev Kernel Socket.
[   33.393006] systemd[1]: Starting Journal Socket.
[   33.404482] systemd[1]: Listening on Journal Socket.
[   33.410188] systemd[1]: Starting Sockets.
[   33.421438] systemd[1]: Reached target Sockets.
[   33.427040] systemd[1]: Starting System Slice.
[   33.438154] systemd[1]: Created slice System Slice.
[   33.443637] systemd[1]: Starting system-systemd\x2dfsck.slice.
[   33.454676] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   33.460217] systemd[1]: Starting dracut cmdline hook...
[   33.474534] systemd[1]: Starting Load Kernel Modules...
[   33.485939] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[   33.491754] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   33.491786] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   33.491817] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   33.491848] sd 3:0:0:0: Attached scsi generic sg3 type 0
[   33.523464] systemd[1]: Starting Journal Service...
[   33.534892] systemd[1]: Starting Slices.
[   33.545952] systemd[1]: Reached target Slices.
[   33.551403] systemd[1]: Starting Setup Virtual Console...
[   33.568502] systemd[1]: Starting Swap.
[   33.579198] systemd[1]: Reached target Swap.
[   33.579207] systemd[1]: Starting Local File Systems.
[   33.595128] systemd[1]: Reached target Local File Systems.
[   33.621350] systemd[1]: Started Journal Service.
[   33.742352] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[   33.747773] ACPI: Power Button [PWRB]
[   33.748508] wmi: Mapper loaded
[   33.757428] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   33.757548] ohci-pci: OHCI PCI platform driver
[   33.757735] ohci-pci 0000:00:12.0: OHCI PCI host controller
[   33.757741] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[   33.757779] ohci-pci 0000:00:12.0: irq 18, io mem 0xd880a000
[   33.758297] ACPI: Power Button [PWRF]
[   33.772522] random: nonblocking pool is initialized
[   33.812432] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[   33.812433] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   33.812434] usb usb4: Product: OHCI PCI host controller
[   33.812435] usb usb4: Manufacturer: Linux 4.5.0-rc5 ohci_hcd
[   33.812436] usb usb4: SerialNumber: 0000:00:12.0
[   33.812555] hub 4-0:1.0: USB hub found
[   33.812564] hub 4-0:1.0: 5 ports detected
[   33.814893] scsi host9: pata_atiixp
[   33.814988] scsi host10: pata_atiixp
[   33.815028] ata9: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
[   33.815029] ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
[   33.815141] ohci-pci 0000:00:13.0: OHCI PCI host controller
[   33.815146] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
[   33.815189] ohci-pci 0000:00:13.0: irq 18, io mem 0xd8808000
[   33.869503] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[   33.869505] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   33.869505] usb usb5: Product: OHCI PCI host controller
[   33.869506] usb usb5: Manufacturer: Linux 4.5.0-rc5 ohci_hcd
[   33.869507] usb usb5: SerialNumber: 0000:00:13.0
[   33.869747] hub 5-0:1.0: USB hub found
[   33.869756] hub 5-0:1.0: 5 ports detected
[   33.869965] ohci-pci 0000:00:14.5: OHCI PCI host controller
[   33.869969] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
[   33.869990] ohci-pci 0000:00:14.5: irq 18, io mem 0xd8806000
[   33.924983] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[   33.924984] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   33.924985] usb usb6: Product: OHCI PCI host controller
[   33.924986] usb usb6: Manufacturer: Linux 4.5.0-rc5 ohci_hcd
[   33.924987] usb usb6: SerialNumber: 0000:00:14.5
[   33.925099] hub 6-0:1.0: USB hub found
[   33.925108] hub 6-0:1.0: 2 ports detected
[   33.925282] ohci-pci 0000:00:16.0: OHCI PCI host controller
[   33.925286] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
[   33.925305] ohci-pci 0000:00:16.0: irq 18, io mem 0xd8805000
[   33.979447] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[   33.979448] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   33.979449] usb usb7: Product: OHCI PCI host controller
[   33.979450] usb usb7: Manufacturer: Linux 4.5.0-rc5 ohci_hcd
[   33.979451] usb usb7: SerialNumber: 0000:00:16.0
[   33.979554] hub 7-0:1.0: USB hub found
[   33.979563] hub 7-0:1.0: 4 ports detected
[   33.982031] ata9.00: ATAPI: SONY    DVD RW AD-7260S, 1.61, max UDMA/100
[   33.982255] ata9.01: ATA-8: ST3500418AS, CC38, max UDMA/133
[   33.982256] ata9.01: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   33.982259] ata9.00: limited to UDMA/33 due to 40-wire cable
[   33.982260] ata9.01: limited to UDMA/33 due to 40-wire cable
[   33.987159] ata9.00: configured for UDMA/33
[   33.992227] ata9.01: configured for UDMA/33
[   33.994157] scsi 9:0:0:0: CD-ROM            SONY     DVD RW AD-7260S  1.61 PQ: 0 ANSI: 5
[   34.005986] scsi 9:0:0:0: Attached scsi generic sg4 type 5
[   34.006082] scsi 9:0:1:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5
[   34.044691] sd 9:0:1:0: [sde] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[   34.044713] sd 9:0:1:0: Attached scsi generic sg5 type 0
[   34.044721] sd 9:0:1:0: [sde] Write Protect is off
[   34.044723] sd 9:0:1:0: [sde] Mode Sense: 00 3a 00 00
[   34.044790] sd 9:0:1:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   34.048632]  sde: sde1
[   34.048833] sd 9:0:1:0: [sde] Attached SCSI disk
[   34.106367] sr 9:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   34.110823] cdrom: Uniform CD-ROM driver Revision: 3.20
[   34.110982] sr 9:0:0:0: Attached scsi CD-ROM sr0
[   34.134359] usb 4-4: new low-speed USB device number 2 using ohci-pci
[   34.285369] usb 4-4: New USB device found, idVendor=046d, idProduct=c00e
[   34.285491] usb 4-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   34.285615] usb 4-4: Product: USB-PS/2 Optical Mouse
[   34.285700] usb 4-4: Manufacturer: Logitech
[   34.293611] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-4/4-4:1.0/0003:046D:C00E.0001/input/input3
[   34.293937] hid-generic 0003:046D:C00E.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:12.0-4/input0
[   38.886407] scsi host11: Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec 29320LPE PCIe Ultra320 SCSI adapter>
        aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133MHz, 512 SCBs
[   38.897049] scsi 11:0:0:0: Direct-Access     SEAGATE  ST15150N         5055 PQ: 0 ANSI: 2
[   38.897196] scsi target11:0:0: asynchronous
[   38.897268] scsi11:A:0:0: Tagged Queuing enabled.  Depth 32
[   38.897369] scsi target11:0:0: Beginning Domain Validation
[   38.917564] scsi target11:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   38.931872] scsi target11:0:0: Domain Validation skipping write tests
[   38.931985] scsi target11:0:0: Ending Domain Validation
[   38.932262] sd 11:0:0:0: Attached scsi generic sg6 type 0
[   38.950667] sd 11:0:0:0: [sdf] Unsupported sector size 768.
[   38.950767] sd 11:0:0:0: [sdf] 0 512-byte logical blocks: (0 B/0 B)
[   38.950876] sd 11:0:0:0: [sdf] 768-byte physical blocks
[   38.957206] sd 11:0:0:0: [sdf] Write Protect is off
[   38.957292] sd 11:0:0:0: [sdf] Mode Sense: ab 00 10 08
[   38.957886] scsi 11:0:1:0: Direct-Access     SEAGATE  ST15150N         5055 PQ: 0 ANSI: 2
[   38.958031] scsi target11:0:1: asynchronous
[   38.958103] scsi11:A:1:0: Tagged Queuing enabled.  Depth 32
[   38.958203] scsi target11:0:1: Beginning Domain Validation
[   38.964716] sd 11:0:0:0: [sdf] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   38.974234] sd 11:0:0:0: [sdf] Unsupported sector size 768.
[   38.979133] scsi target11:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   38.990752] sd 11:0:0:0: [sdf] Attached SCSI disk
[   38.994524] scsi target11:0:1: Domain Validation skipping write tests
[   38.994637] scsi target11:0:1: Ending Domain Validation
[   38.994898] sd 11:0:1:0: Attached scsi generic sg7 type 0
[   39.268971] sd 11:0:1:0: [sdg] Unsupported sector size 768.
[   39.269070] sd 11:0:1:0: [sdg] 0 512-byte logical blocks: (0 B/0 B)
[   39.269178] sd 11:0:1:0: [sdg] 768-byte physical blocks
[   39.271598] scsi 11:0:3:0: Sequential-Access SONY     SDT-10000        0110 PQ: 0 ANSI: 2
[   39.271743] scsi target11:0:3: asynchronous
[   39.271816] scsi target11:0:3: Beginning Domain Validation
[   39.277726] sd 11:0:1:0: [sdg] Write Protect is off
[   39.277813] sd 11:0:1:0: [sdg] Mode Sense: ab 00 10 08
[   39.279988] scsi target11:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
[   39.285396] scsi target11:0:3: Domain Validation skipping write tests
[   39.285509] scsi target11:0:3: Ending Domain Validation
[   39.285749] scsi 11:0:3:0: Attached scsi generic sg8 type 1
[   39.544775] sd 11:0:1:0: [sdg] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   40.576612] sd 11:0:1:0: [sdg] Unsupported sector size 768.
[   41.608429] sd 11:0:1:0: [sdg] Attached SCSI disk
[   48.798522] scsi host8: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2930CU SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

[   49.066033] scsi 8:0:1:0: Sequential-Access HP       88780            A674 PQ: 0 ANSI: 1 CCS
[   49.066186] scsi target8:0:1: Beginning Domain Validation
[   49.084705] scsi target8:0:1: Ending Domain Validation
[   49.084974] scsi 8:0:1:0: Attached scsi generic sg9 type 1
[   50.688280] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
[   50.961279] systemd-journald[229]: Received SIGTERM from PID 1 (systemd).
[   53.059782] device-mapper: uevent: version 1.0.3
[   53.064825] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[   54.631927] systemd-readahead[492]: Bumped block_nr parameter of 8:0 to 20480. This is a temporary hack and should be removed one day.
[   56.015949] EXT4-fs (sda5): re-mounted. Opts: acl,user_xattr
[   58.514365] FUJITSU Extended Socket Network Device Driver - version 1.0 - Copyright (c) 2015 FUJITSU LIMITED
[   58.628877] Warning: Processor Platform Limit event detected, but not handled.
[   58.632609] Consider compiling CPUfreq support into your kernel.
[   58.850517] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   59.140090] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   59.513680] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   59.517741] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[   59.591929] st: Version 20101219, fixed bufsize 32768, s/g segs 256
[   59.596202] st 11:0:3:0: Attached scsi tape st0
[   59.600109] st 11:0:3:0: st0: try direct i/o: yes (alignment 4 B)
[   59.604265] st 8:0:1:0: Attached scsi tape st1
[   59.608039] st 8:0:1:0: st1: try direct i/o: yes (alignment 4 B)
[   60.077996] EXT4-fs (sde1): mounting ext3 file system using the ext4 subsystem
[   60.109689] EXT4-fs (sde1): mounted filesystem with ordered data mode. Opts: (null)
[   60.392450] EXT4-fs (sdb5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   60.473189] dgap: module is from the staging directory, the quality is unknown, you have been warned.
[   60.479168] dgap: dgap-1.3-16, Digi International Part Number 40002347_C
[   60.484884] dgap: For the tools package please visit http://www.digi.com
[   60.490958] dgap: dgap: board 0: AccelePort Xr920 8 port (rev 1), irq 32
[   60.549949] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   60.555677] r8169 0000:11:00.0: can't disable ASPM; OS doesn't have ASPM control
[   60.562045] r8169 0000:11:00.0 eth0: RTL8168evl/8111evl at 0xffffc90000044000, 74:d4:35:1f:b2:9e, XID 0c900800 IRQ 33
[   60.567956] r8169 0000:11:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   60.749358] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   60.847989] AVX version of gcm_enc/dec engaged.
[   60.853960] AES CTR mode by8 optimization enabled
[   60.875022] osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[   60.946919] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   60.952650] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 8
[   60.958489] xhci_hcd 0000:06:00.0: hcc params 0x040050af hci version 0x100 quirks 0x00080490
[   60.964383] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[   60.970170] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   60.975975] usb usb8: Product: xHCI Host Controller
[   60.981768] usb usb8: Manufacturer: Linux 4.5.0-rc5 xhci-hcd
[   60.987558] usb usb8: SerialNumber: 0000:06:00.0
[   60.993414] hub 8-0:1.0: USB hub found
[   60.999069] hub 8-0:1.0: 2 ports detected
[   61.004736] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   61.010271] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 9
[   61.015794] usb usb9: We don't know the algorithms for LPM for this host, disabling LPM.
[   61.021350] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[   61.026825] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   61.026826] usb usb9: Product: xHCI Host Controller
[   61.026829] usb usb9: Manufacturer: Linux 4.5.0-rc5 xhci-hcd
[   61.026832] usb usb9: SerialNumber: 0000:06:00.0
[   61.026941] hub 9-0:1.0: USB hub found
[   61.026949] hub 9-0:1.0: 2 ports detected
[   61.027114] xhci_hcd 0000:12:00.0: xHCI Host Controller
[   61.027118] xhci_hcd 0000:12:00.0: new USB bus registered, assigned bus number 10
[   61.027277] xhci_hcd 0000:12:00.0: hcc params 0x040050af hci version 0x100 quirks 0x00080490
[   61.027419] usb usb10: New USB device found, idVendor=1d6b, idProduct=0002
[   61.027420] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   61.027420] usb usb10: Product: xHCI Host Controller
[   61.027421] usb usb10: Manufacturer: Linux 4.5.0-rc5 xhci-hcd
[   61.027422] usb usb10: SerialNumber: 0000:12:00.0
[   61.027555] hub 10-0:1.0: USB hub found
[   61.027564] hub 10-0:1.0: 2 ports detected
[   61.027667] xhci_hcd 0000:12:00.0: xHCI Host Controller
[   61.027670] xhci_hcd 0000:12:00.0: new USB bus registered, assigned bus number 11
[   61.027686] usb usb11: We don't know the algorithms for LPM for this host, disabling LPM.
[   61.027701] usb usb11: New USB device found, idVendor=1d6b, idProduct=0003
[   61.027701] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   61.027702] usb usb11: Product: xHCI Host Controller
[   61.027703] usb usb11: Manufacturer: Linux 4.5.0-rc5 xhci-hcd
[   61.027704] usb usb11: SerialNumber: 0000:12:00.0
[   61.027802] hub 11-0:1.0: USB hub found
[   61.027810] hub 11-0:1.0: 2 ports detected
[   61.172487] EXT4-fs (sdc5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   61.364169] EXT4-fs (sdc6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   61.441858] EXT4-fs (sdb7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   61.455572] EXT4-fs (sdc7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   61.471972] EXT4-fs (sdb6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   61.481472] EXT4-fs (sdd5): mounting ext3 file system using the ext4 subsystem
[   61.513728] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   61.526358] EXT4-fs (sdd5): mounted filesystem with ordered data mode. Opts: (null)
[   61.623213] EXT4-fs (sdd7): mounting ext3 file system using the ext4 subsystem
[   61.790290] EXT4-fs (sdd7): mounted filesystem with ordered data mode. Opts: (null)
[   61.805504] EXT4-fs (sdd1): mounting ext3 file system using the ext4 subsystem
[   61.855621] EXT4-fs (sdd1): mounted filesystem with ordered data mode. Opts: (null)
[   62.157341] EXT4-fs (sdd6): mounting ext3 file system using the ext4 subsystem
[   62.217942] EXT4-fs (sdd6): mounted filesystem with ordered data mode. Opts: (null)
[   63.380246] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC889: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   63.386219] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   63.392213] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   63.398192] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   63.404138] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[   63.410053] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   63.415873] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   63.421631] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   63.422286] Adding 8385532k swap on /dev/sda2.  Priority:-1 extents:1 across:8385532k FS
[   63.433156] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   63.456766] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input5
[   63.456857] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[   63.456944] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[   63.457062] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[   63.457154] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[   63.457226] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[   63.457286] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[   63.457344] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input12
[   64.326730] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   64.571376] 3c59x: Donald Becker and others.
[   64.577836] 0000:0a:04.0: 3Com PCI 3c905C Tornado at ffffc90000040000.
[   64.584424] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: (null)
[   64.758883] EXT4-fs (sda6): mounted filesystem with ordered data mode. Opts: (null)
[   66.915309] kvm: disabled by bios
[   66.927126] kvm: disabled by bios
[   66.942117] kvm: disabled by bios
[   66.957163] kvm: disabled by bios
[   66.969120] kvm: disabled by bios
[   66.984171] kvm: disabled by bios
[   66.996110] kvm: disabled by bios
[   67.014101] kvm: disabled by bios
[  144.690953] systemd-journald[495]: Received request to flush runtime journal from PID 1
[  145.667553] audit: type=1305 audit(1456513363.440:2): audit_pid=919 old=0 auid=4294967295 ses=4294967295 res=1
[  145.837626] systemd[1]: Received SIGRTMIN+21 from PID 337 (plymouthd).
