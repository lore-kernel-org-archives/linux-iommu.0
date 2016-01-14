From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Thu, 14 Jan 2016 09:04:08 -0500
Message-ID: <5697AAD8.1000105@compro.net>
References: <56957209.1080202@compro.net>
	<20160113030950.GB11902@dhcp-128-28.nay.redhat.com>
	<56966244.80700@compro.net> <20160114000520.GA2449@x1.redhat.com>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160114000520.GA2449-ejN7fcUYdH/by3iVrkZq2A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/13/2016 07:05 PM, Baoquan He wrote:
> On 01/13/16 at 09:42am, Mark Hounschell wrote:
>> First, attached are the 2 lspci outputs you asked for.
>>
>> After the patch I was still unable to bring the system up but it was
>> much better. 2 of the 8 Sata disks do not come up. If I remove those
>> from my fstab the box comes up with the patch.
>>
>> This MB has 8 internal Sata ports. Six hanging off the South-Bridge
>> (SB950) and two more hanging off  Marvell 88SE9172 chips connected
>> to the 990FX chipset.  I'm pretty sure the 2 disks that don't come
>> up are the 2 hanging off the Marvell chips. I will have to take the
>> box apart to verify and will if you need me to. And again, all works
>> fine with the IOMMU disabled in the BIOS.
> 
> OK, it means the alias dev table entry is correctly set. I checked the
> boot log again and found some interrupt related info. Can you paste the
> boot log which 2 of the 8 sata disks didn't come up with my patch
> applied. And could you tell the pci id of those 2 sata disks, then I
> don't need to find them one by one.
> 

OK, I verified the 2 disks are hanging off the Marvel chips. 
Here is the dmesg from booting with your patch and the 2 
disks not showing up.

[    0.000000] Linux version 4.4.0-lcrs (root@harley) (gcc version 4.8.3 20140627 [gcc-4_8-branch revision 212064] (SUSE Linux) ) #3 SMP PREEMPT Wed Jan 13 08:23:17 EST 2016
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.4.0-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G audit=0 amd_iommu_dump
[    0.000000] tseg: 00af800000
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'lazy' FPU context switches.
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
[    0.000000] BRK [0x010f4000, 0x010f4fff] PGTABLE
[    0.000000] BRK [0x010f5000, 0x010f5fff] PGTABLE
[    0.000000] BRK [0x010f6000, 0x010f6fff] PGTABLE
[    0.000000] BRK [0x010f7000, 0x010f7fff] PGTABLE
[    0.000000] BRK [0x010f8000, 0x010f8fff] PGTABLE
[    0.000000] BRK [0x010f9000, 0x010f9fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x370a0000-0x37847fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000AEE1F070 000064 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000AEE25880 0000F4 (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20150930/tbfadt-654)
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
[    0.000000] PERCPU: Embedded 32 pages/cpu @ffff88044fc00000 s91608 r8192 d31272 u262144
[    0.000000] pcpu-alloc: s91608 r8192 d31272 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4119292
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.4.0-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G audit=0 amd_iommu_dump
[    0.000000] audit: disabled (until reboot)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Memory: 16310604K/16753368K available (6207K kernel code, 822K rwdata, 2964K rodata, 984K init, 1180K bss, 377228K reserved, 65536K cma-reserved)
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
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3616.851 MHz processor
[    0.000021] Calibrating delay loop (skipped), value calculated using timer frequency.. 7233.70 BogoMIPS (lpj=3616851)
[    0.000027] pid_max: default: 32768 minimum: 301
[    0.000033] ACPI: Core revision 20150930
[    0.003791] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.003808] Security Framework initialized
[    0.003836] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.003840] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.004077] Initializing cgroup subsys memory
[    0.004085] Initializing cgroup subsys hugetlb
[    0.004089] Initializing cgroup subsys pids
[    0.004110] CPU: Physical Processor ID: 0
[    0.004113] CPU: Processor Core ID: 0
[    0.004116] mce: CPU supports 7 MCE banks
[    0.004123] LVT offset 1 assigned for vector 0xf9
[    0.004128] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.004131] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.004338] Freeing SMP alternatives memory: 24K (ffffffff80fc5000 - ffffffff80fcb000)
[    0.007598] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.119090] smpboot: CPU0: AMD FX(tm)-8150 Eight-Core Processor (family: 0x15, model: 0x1, stepping: 0x2)
[    0.119109] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.119115] ... version:                0
[    0.119118] ... bit width:              48
[    0.119120] ... generic registers:      6
[    0.119123] ... value mask:             0000ffffffffffff
[    0.119126] ... max period:             00007fffffffffff
[    0.119128] ... fixed-purpose events:   0
[    0.119131] ... event mask:             000000000000003f
[    0.128131] x86: Booting SMP configuration:
[    0.128135] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.184905] x86: Booted up 1 node, 8 CPUs
[    0.184912] smpboot: Total of 8 processors activated (57869.61 BogoMIPS)
[    0.197264] devtmpfs: initialized
[    0.197478] PM: Registering ACPI NVS region [mem 0xaea33000-0xaee2efff] (4177920 bytes)
[    0.197528] PM: Registering ACPI NVS region [mem 0xaf156000-0xaf35bfff] (2121728 bytes)
[    0.197636] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.198000] pinctrl core: initialized pinctrl subsystem
[    0.198034] RTC time: 13:06:12, date: 01/14/16
[    0.199056] NET: Registered protocol family 16
[    0.200959] cpuidle: using governor ladder
[    0.202957] cpuidle: using governor menu
[    0.203028] ACPI: bus type PCI registered
[    0.203031] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.203088] PCI: Using configuration type 1 for base access
[    0.203091] PCI: Using configuration type 1 for extended access
[    0.206249] ACPI: Added _OSI(Module Device)
[    0.206253] ACPI: Added _OSI(Processor Device)
[    0.206256] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.206259] ACPI: Added _OSI(Processor Aggregator Device)
[    0.207983] ACPI: Executed 3 blocks of module-level executable AML code
[    0.210700] ACPI: Interpreter enabled
[    0.210707] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150930/hwxface-580)
[    0.210715] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150930/hwxface-580)
[    0.210730] ACPI: (supports S0 S3 S4 S5)
[    0.210733] ACPI: Using IOAPIC for interrupt routing
[    0.210900] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.217343] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.217350] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.217358] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.217729] PCI host bridge to bus 0000:00
[    0.217733] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.217737] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.217741] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.217745] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.217748] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.217753] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.217758] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xdfffffff window]
[    0.217763] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.217773] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.217885] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    0.217994] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.218026] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.218085] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.218122] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.218152] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.218207] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.218247] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    0.218277] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.218332] pci 0000:00:09.0: System wakeup disabled by ACPI
[    0.218368] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    0.218398] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.218452] pci 0000:00:0a.0: System wakeup disabled by ACPI
[    0.218488] pci 0000:00:0b.0: [1002:5a1f] type 01 class 0x060400
[    0.218519] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
[    0.218574] pci 0000:00:0b.0: System wakeup disabled by ACPI
[    0.218612] pci 0000:00:0d.0: [1002:5a1e] type 01 class 0x060400
[    0.218643] pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
[    0.218697] pci 0000:00:0d.0: System wakeup disabled by ACPI
[    0.218739] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.218758] pci 0000:00:11.0: reg 0x10: [io  0xf090-0xf097]
[    0.218765] pci 0000:00:11.0: reg 0x14: [io  0xf080-0xf083]
[    0.218772] pci 0000:00:11.0: reg 0x18: [io  0xf070-0xf077]
[    0.218779] pci 0000:00:11.0: reg 0x1c: [io  0xf060-0xf063]
[    0.218786] pci 0000:00:11.0: reg 0x20: [io  0xf050-0xf05f]
[    0.218793] pci 0000:00:11.0: reg 0x24: [mem 0xd880b000-0xd880b3ff]
[    0.218893] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.218904] pci 0000:00:12.0: reg 0x10: [mem 0xd880a000-0xd880afff]
[    0.218995] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.219035] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.219054] pci 0000:00:12.2: reg 0x10: [mem 0xd8809000-0xd88090ff]
[    0.219107] pci 0000:00:12.2: supports D1 D2
[    0.219109] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.219162] pci 0000:00:12.2: System wakeup disabled by ACPI
[    0.219203] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.219214] pci 0000:00:13.0: reg 0x10: [mem 0xd8808000-0xd8808fff]
[    0.219303] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.219344] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.219362] pci 0000:00:13.2: reg 0x10: [mem 0xd8807000-0xd88070ff]
[    0.219414] pci 0000:00:13.2: supports D1 D2
[    0.219415] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.219467] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.219510] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.219630] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    0.219642] pci 0000:00:14.1: reg 0x10: [io  0xf040-0xf047]
[    0.219649] pci 0000:00:14.1: reg 0x14: [io  0xf030-0xf033]
[    0.219656] pci 0000:00:14.1: reg 0x18: [io  0xf020-0xf027]
[    0.219663] pci 0000:00:14.1: reg 0x1c: [io  0xf010-0xf013]
[    0.219670] pci 0000:00:14.1: reg 0x20: [io  0xf000-0xf00f]
[    0.219685] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.219688] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.219692] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.219695] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.219778] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.219798] pci 0000:00:14.2: reg 0x10: [mem 0xd8800000-0xd8803fff 64bit]
[    0.219842] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.219893] pci 0000:00:14.2: System wakeup disabled by ACPI
[    0.219928] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.220053] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.220129] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.220165] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.220177] pci 0000:00:14.5: reg 0x10: [mem 0xd8806000-0xd8806fff]
[    0.220265] pci 0000:00:14.5: System wakeup disabled by ACPI
[    0.220305] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
[    0.220356] pci 0000:00:15.0: supports D1 D2
[    0.220410] pci 0000:00:15.0: System wakeup disabled by ACPI
[    0.220448] pci 0000:00:15.1: [1002:43a1] type 01 class 0x060400
[    0.220498] pci 0000:00:15.1: supports D1 D2
[    0.220553] pci 0000:00:15.1: System wakeup disabled by ACPI
[    0.220592] pci 0000:00:15.2: [1002:43a2] type 01 class 0x060400
[    0.220643] pci 0000:00:15.2: supports D1 D2
[    0.220697] pci 0000:00:15.2: System wakeup disabled by ACPI
[    0.220737] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.220749] pci 0000:00:16.0: reg 0x10: [mem 0xd8805000-0xd8805fff]
[    0.220837] pci 0000:00:16.0: System wakeup disabled by ACPI
[    0.220878] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.220896] pci 0000:00:16.2: reg 0x10: [mem 0xd8804000-0xd88040ff]
[    0.220949] pci 0000:00:16.2: supports D1 D2
[    0.220951] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.221002] pci 0000:00:16.2: System wakeup disabled by ACPI
[    0.221043] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.221126] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.221203] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.221281] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.221361] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.221438] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.221567] pci 0000:01:00.0: [10de:0092] type 00 class 0x030000
[    0.221583] pci 0000:01:00.0: reg 0x10: [mem 0xda000000-0xdaffffff]
[    0.221592] pci 0000:01:00.0: reg 0x14: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.221600] pci 0000:01:00.0: reg 0x1c: [mem 0xd9000000-0xd9ffffff 64bit]
[    0.221605] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.221611] pci 0000:01:00.0: reg 0x30: [mem 0xdb000000-0xdb01ffff pref]
[    0.221672] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.221681] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.221686] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.221688] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.221690] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.221732] pci 0000:02:00.0: [104c:8231] type 01 class 0x060400
[    0.221818] pci 0000:02:00.0: supports D1 D2
[    0.221862] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.221871] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.221876] pci 0000:00:04.0:   bridge window [io  0x6000-0x7fff]
[    0.221878] pci 0000:00:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.221881] pci 0000:00:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.221943] pci 0000:03:04.0: [12d8:8150] type 01 class 0x060400
[    0.222097] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.222105] pci 0000:02:00.0:   bridge window [io  0x6000-0x7fff]
[    0.222109] pci 0000:02:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.222115] pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.222178] pci 0000:04:04.0: [10b5:0480] type 00 class 0x0e8000
[    0.222227] pci 0000:04:04.0: reg 0x10: [mem 0xdd909000-0xdd9093ff]
[    0.222243] pci 0000:04:04.0: reg 0x14: [mem 0xdd000000-0xdd7fffff]
[    0.222259] pci 0000:04:04.0: reg 0x18: [mem 0xdd908000-0xdd90800f]
[    0.222413] pci 0000:04:05.0: [10b5:0480] type 00 class 0x0e8000
[    0.222462] pci 0000:04:05.0: reg 0x10: [mem 0xdd907000-0xdd9073ff]
[    0.222478] pci 0000:04:05.0: reg 0x14: [mem 0xdc800000-0xdcffffff]
[    0.222494] pci 0000:04:05.0: reg 0x18: [mem 0xdd906000-0xdd90600f]
[    0.222649] pci 0000:04:06.0: [10b5:0480] type 00 class 0x0e8000
[    0.222698] pci 0000:04:06.0: reg 0x10: [mem 0xdd905000-0xdd9053ff]
[    0.222714] pci 0000:04:06.0: reg 0x14: [mem 0xdc000000-0xdc7fffff]
[    0.222730] pci 0000:04:06.0: reg 0x18: [mem 0xdd904000-0xdd90400f]
[    0.222885] pci 0000:04:07.0: [10b5:0480] type 00 class 0x0e8000
[    0.222934] pci 0000:04:07.0: reg 0x10: [mem 0xdd903000-0xdd9033ff]
[    0.222951] pci 0000:04:07.0: reg 0x14: [mem 0xdb800000-0xdbffffff]
[    0.222967] pci 0000:04:07.0: reg 0x18: [mem 0xdd902000-0xdd90200f]
[    0.223122] pci 0000:04:08.0: [3388:0022] type 01 class 0x060400
[    0.223248] pci 0000:04:08.0: supports D1 D2
[    0.223249] pci 0000:04:08.0: PME# supported from D0 D1 D2 D3hot
[    0.223304] pci 0000:04:09.0: [10b5:9030] type 00 class 0x070002
[    0.223331] pci 0000:04:09.0: reg 0x10: [mem 0xdd901000-0xdd90107f]
[    0.223347] pci 0000:04:09.0: reg 0x14: [io  0x7180-0x71ff]
[    0.223362] pci 0000:04:09.0: reg 0x18: [io  0x7100-0x717f]
[    0.223470] pci 0000:04:0a.0: [1090:4360] type 00 class 0x058000
[    0.223496] pci 0000:04:0a.0: reg 0x10: [mem 0xdd900000-0xdd9000ff]
[    0.223512] pci 0000:04:0a.0: reg 0x14: [io  0x7000-0x70ff]
[    0.223528] pci 0000:04:0a.0: reg 0x18: [mem 0xc0000000-0xc3ffffff pref]
[    0.223586] pci 0000:04:0a.0: reg 0x30: [mem 0xdd90a000-0xdd90a7ff pref]
[    0.223671] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.223680] pci 0000:03:04.0:   bridge window [io  0x6000-0x7fff]
[    0.223684] pci 0000:03:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.223691] pci 0000:03:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.223753] pci 0000:05:00.0: [1090:0100] type 00 class 0xff0000
[    0.223783] pci 0000:05:00.0: reg 0x10: [mem 0xdd80a000-0xdd80afff]
[    0.223801] pci 0000:05:00.0: reg 0x14: [mem 0xdd808000-0xdd809fff]
[    0.223820] pci 0000:05:00.0: reg 0x18: [mem 0xdd800000-0xdd807fff]
[    0.224006] pci 0000:04:08.0: PCI bridge to [bus 05]
[    0.224017] pci 0000:04:08.0:   bridge window [io  0x6000-0x6fff]
[    0.224023] pci 0000:04:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.224095] pci 0000:06:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.224120] pci 0000:06:00.0: reg 0x10: [mem 0xde100000-0xde107fff 64bit]
[    0.224179] pci 0000:06:00.0: supports D1 D2
[    0.224181] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.226080] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.226086] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.226128] pci 0000:07:00.0: [1b4b:9172] type 00 class 0x010601
[    0.226146] pci 0000:07:00.0: reg 0x10: [io  0xd040-0xd047]
[    0.226152] pci 0000:07:00.0: reg 0x14: [io  0xd030-0xd033]
[    0.226158] pci 0000:07:00.0: reg 0x18: [io  0xd020-0xd027]
[    0.226164] pci 0000:07:00.0: reg 0x1c: [io  0xd010-0xd013]
[    0.226170] pci 0000:07:00.0: reg 0x20: [io  0xd000-0xd00f]
[    0.226176] pci 0000:07:00.0: reg 0x24: [mem 0xde010000-0xde0101ff]
[    0.226182] pci 0000:07:00.0: reg 0x30: [mem 0xde000000-0xde00ffff pref]
[    0.226207] pci 0000:07:00.0: PME# supported from D3hot
[    0.228076] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.228082] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
[    0.228084] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.228132] pci 0000:08:00.0: [104c:8231] type 01 class 0x060400
[    0.228224] pci 0000:08:00.0: supports D1 D2
[    0.228271] pci 0000:08:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.228281] pci 0000:00:0b.0: PCI bridge to [bus 08-0d]
[    0.228285] pci 0000:00:0b.0:   bridge window [io  0xc000-0xcfff]
[    0.228288] pci 0000:00:0b.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.228290] pci 0000:00:0b.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.228353] pci 0000:09:04.0: [12d8:8150] type 01 class 0x060400
[    0.228510] pci 0000:08:00.0: PCI bridge to [bus 09-0d]
[    0.228518] pci 0000:08:00.0:   bridge window [io  0xc000-0xcfff]
[    0.228522] pci 0000:08:00.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.228529] pci 0000:08:00.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.228592] pci 0000:0a:04.0: [10b7:9200] type 00 class 0x020000
[    0.228631] pci 0000:0a:04.0: reg 0x10: [io  0xc200-0xc27f]
[    0.228647] pci 0000:0a:04.0: reg 0x14: [mem 0xd8743000-0xd874307f]
[    0.228721] pci 0000:0a:04.0: reg 0x30: [mem 0xd8700000-0xd871ffff pref]
[    0.228756] pci 0000:0a:04.0: supports D1 D2
[    0.228758] pci 0000:0a:04.0: PME# supported from D0 D1 D2 D3hot
[    0.228815] pci 0000:0a:05.0: [114a:5565] type 00 class 0x028000
[    0.228859] pci 0000:0a:05.0: reg 0x10: [mem 0xd8742000-0xd87421ff]
[    0.228875] pci 0000:0a:05.0: reg 0x14: [io  0xc100-0xc1ff]
[    0.228891] pci 0000:0a:05.0: reg 0x18: [mem 0xd8741000-0xd874103f]
[    0.228907] pci 0000:0a:05.0: reg 0x1c: [mem 0xd0000000-0xd7ffffff]
[    0.229042] pci 0000:0a:06.0: [3388:0022] type 01 class 0x060400
[    0.229174] pci 0000:0a:06.0: supports D1 D2
[    0.229175] pci 0000:0a:06.0: PME# supported from D0 D1 D2 D3hot
[    0.229238] pci 0000:0a:07.0: [3388:0022] type 01 class 0x060400
[    0.229367] pci 0000:0a:07.0: supports D1 D2
[    0.229368] pci 0000:0a:07.0: PME# supported from D0 D1 D2 D3hot
[    0.229430] pci 0000:0a:08.0: [3388:0022] type 01 class 0x060400
[    0.229559] pci 0000:0a:08.0: supports D1 D2
[    0.229560] pci 0000:0a:08.0: PME# supported from D0 D1 D2 D3hot
[    0.229614] pci 0000:0a:09.0: [114f:0027] type 00 class 0x078000
[    0.229641] pci 0000:0a:09.0: reg 0x10: [mem 0xd8000000-0xd83fffff]
[    0.229729] pci 0000:0a:09.0: reg 0x30: [mem 0xd8730000-0xd873ffff pref]
[    0.229785] pci 0000:0a:0a.0: [9004:3860] type 00 class 0x010000
[    0.229823] pci 0000:0a:0a.0: reg 0x10: [io  0xc000-0xc0ff]
[    0.229839] pci 0000:0a:0a.0: reg 0x14: [mem 0xd8740000-0xd8740fff]
[    0.229913] pci 0000:0a:0a.0: reg 0x30: [mem 0xd8720000-0xd872ffff pref]
[    0.230023] pci 0000:09:04.0: PCI bridge to [bus 0a-0d]
[    0.230033] pci 0000:09:04.0:   bridge window [io  0xc000-0xcfff]
[    0.230037] pci 0000:09:04.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.230045] pci 0000:09:04.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.230115] pci 0000:0b:00.0: [1090:4710] type 00 class 0xff0000
[    0.230161] pci 0000:0b:00.0: reg 0x10: [mem 0xd8600000-0xd86001ff]
[    0.230179] pci 0000:0b:00.0: reg 0x14: [mem 0xc6000000-0xc6ffffff pref]
[    0.230410] pci 0000:0a:06.0: PCI bridge to [bus 0b]
[    0.230425] pci 0000:0a:06.0:   bridge window [mem 0xd8600000-0xd86fffff]
[    0.230435] pci 0000:0a:06.0:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
[    0.230505] pci 0000:0c:00.0: [1090:4710] type 00 class 0xff0000
[    0.230550] pci 0000:0c:00.0: reg 0x10: [mem 0xd8500000-0xd85001ff]
[    0.230569] pci 0000:0c:00.0: reg 0x14: [mem 0xc5000000-0xc5ffffff pref]
[    0.230799] pci 0000:0a:07.0: PCI bridge to [bus 0c]
[    0.230814] pci 0000:0a:07.0:   bridge window [mem 0xd8500000-0xd85fffff]
[    0.230824] pci 0000:0a:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.230896] pci 0000:0d:00.0: [1090:4710] type 00 class 0xff0000
[    0.230942] pci 0000:0d:00.0: reg 0x10: [mem 0xd8400000-0xd84001ff]
[    0.230961] pci 0000:0d:00.0: reg 0x14: [mem 0xc4000000-0xc4ffffff pref]
[    0.231194] pci 0000:0a:08.0: PCI bridge to [bus 0d]
[    0.231210] pci 0000:0a:08.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.231219] pci 0000:0a:08.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.231305] pci 0000:0e:00.0: [10b5:8114] type 01 class 0x060400
[    0.231340] pci 0000:0e:00.0: reg 0x10: [mem 0xddc00000-0xddc01fff]
[    0.231425] pci 0000:0e:00.0: PME# supported from D0 D3hot
[    0.231496] pci 0000:0e:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.231507] pci 0000:00:0d.0: PCI bridge to [bus 0e-0f]
[    0.231511] pci 0000:00:0d.0:   bridge window [io  0xb000-0xbfff]
[    0.231513] pci 0000:00:0d.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.231578] pci 0000:0f:04.0: [9005:8017] type 00 class 0x010000
[    0.231617] pci 0000:0f:04.0: reg 0x10: [io  0xb100-0xb1ff]
[    0.231634] pci 0000:0f:04.0: reg 0x14: [mem 0xddb80000-0xddb81fff 64bit]
[    0.231645] pci 0000:0f:04.0: reg 0x1c: [io  0xb000-0xb0ff]
[    0.231676] pci 0000:0f:04.0: reg 0x30: [mem 0xddb00000-0xddb7ffff pref]
[    0.231781] pci 0000:0e:00.0: PCI bridge to [bus 0f]
[    0.231790] pci 0000:0e:00.0:   bridge window [io  0xb000-0xbfff]
[    0.231794] pci 0000:0e:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.231845] pci 0000:10:06.0: [1090:4610] type 00 class 0xff0000
[    0.231860] pci 0000:10:06.0: reg 0x10: [io  0xa000-0xa03f]
[    0.231870] pci 0000:10:06.0: reg 0x14: [mem 0xddf00000-0xddf00fff]
[    0.231976] pci 0000:00:14.4: PCI bridge to [bus 10] (subtractive decode)
[    0.231982] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
[    0.231985] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.231988] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.231989] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.231991] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.231992] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.231994] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.231995] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.231997] pci 0000:00:14.4:   bridge window [mem 0xb0000000-0xdfffffff window] (subtractive decode)
[    0.232058] pci 0000:11:00.0: [10ec:8168] type 00 class 0x020000
[    0.232095] pci 0000:11:00.0: reg 0x10: [io  0x9000-0x90ff]
[    0.232120] pci 0000:11:00.0: reg 0x18: [mem 0xc7004000-0xc7004fff 64bit pref]
[    0.232135] pci 0000:11:00.0: reg 0x20: [mem 0xc7000000-0xc7003fff 64bit pref]
[    0.232198] pci 0000:11:00.0: supports D1 D2
[    0.232200] pci 0000:11:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.232241] pci 0000:11:00.0: System wakeup disabled by ACPI
[    0.234080] pci 0000:00:15.0: PCI bridge to [bus 11]
[    0.234086] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
[    0.234092] pci 0000:00:15.0:   bridge window [mem 0xc7000000-0xc70fffff 64bit pref]
[    0.234146] pci 0000:12:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.234181] pci 0000:12:00.0: reg 0x10: [mem 0xdde00000-0xdde07fff 64bit]
[    0.234265] pci 0000:12:00.0: supports D1 D2
[    0.234267] pci 0000:12:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.236079] pci 0000:00:15.1: PCI bridge to [bus 12]
[    0.236087] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.236142] pci 0000:13:00.0: [1b4b:9172] type 00 class 0x010601
[    0.236167] pci 0000:13:00.0: reg 0x10: [io  0x8040-0x8047]
[    0.236176] pci 0000:13:00.0: reg 0x14: [io  0x8030-0x8033]
[    0.236184] pci 0000:13:00.0: reg 0x18: [io  0x8020-0x8027]
[    0.236192] pci 0000:13:00.0: reg 0x1c: [io  0x8010-0x8013]
[    0.236201] pci 0000:13:00.0: reg 0x20: [io  0x8000-0x800f]
[    0.236209] pci 0000:13:00.0: reg 0x24: [mem 0xddd10000-0xddd101ff]
[    0.236218] pci 0000:13:00.0: reg 0x30: [mem 0xddd00000-0xddd0ffff pref]
[    0.236251] pci 0000:13:00.0: PME# supported from D3hot
[    0.238076] pci 0000:00:15.2: PCI bridge to [bus 13]
[    0.238083] pci 0000:00:15.2:   bridge window [io  0x8000-0x8fff]
[    0.238086] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.238122] pci_bus 0000:00: on NUMA node 0
[    0.238618] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.238697] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.238778] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.238859] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 11 14 15) *0
[    0.238925] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 10 11 14 15) *0
[    0.238980] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 10 11 14 15) *0
[    0.239032] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 10 11 14 15) *0
[    0.239088] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 10 11 14 15) *0
[    0.239257] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.239261] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.239271] vgaarb: loaded
[    0.239273] vgaarb: bridge control possible 0000:01:00.0
[    0.239346] SCSI subsystem initialized
[    0.239399] libata version 3.00 loaded.
[    0.239403] ACPI: bus type USB registered
[    0.239420] usbcore: registered new interface driver usbfs
[    0.239430] usbcore: registered new interface driver hub
[    0.239451] usbcore: registered new device driver usb
[    0.239562] PCI: Using ACPI for IRQ routing
[    0.239566] PCI: pci_cache_line_size set to 64 bytes
[    0.239726] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.239728] e820: reserve RAM buffer [mem 0xae475000-0xafffffff]
[    0.239729] e820: reserve RAM buffer [mem 0xaf156000-0xafffffff]
[    0.239730] e820: reserve RAM buffer [mem 0xaf800000-0xafffffff]
[    0.239822] NetLabel: Initializing
[    0.239825] NetLabel:  domain hash size = 128
[    0.239828] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.239838] NetLabel:  unlabeled traffic allowed by default
[    0.239876] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.239881] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.241947] clocksource: Switched to clocksource hpet
[    0.244815] pnp: PnP ACPI init
[    0.244930] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.244941] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.245296] system 00:01: [io  0x040b] has been reserved
[    0.245300] system 00:01: [io  0x04d6] has been reserved
[    0.245304] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.245307] system 00:01: [io  0x0c14] has been reserved
[    0.245311] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.245314] system 00:01: [io  0x0c52] has been reserved
[    0.245318] system 00:01: [io  0x0c6c] has been reserved
[    0.245321] system 00:01: [io  0x0c6f] has been reserved
[    0.245324] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.245328] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.245332] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.245335] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.245339] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.245342] system 00:01: [io  0x0800-0x089f] could not be reserved
[    0.245346] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.245350] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.245353] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.245357] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.245361] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.245365] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.245369] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.245372] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.245376] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.245380] system 00:01: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.245384] system 00:01: [mem 0xffc00000-0xffffffff] has been reserved
[    0.245389] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.245571] system 00:02: [io  0x0220-0x0227] has been reserved
[    0.245575] system 00:02: [io  0x0228-0x0237] has been reserved
[    0.245578] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    0.245583] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.245629] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.245901] pnp 00:04: [dma 0 disabled]
[    0.245946] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.245972] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.246053] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.246058] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.246111] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.246278] system 00:08: [mem 0xfeb20000-0xfeb23fff] has been reserved
[    0.246283] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.246425] system 00:09: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.246430] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.246549] pnp: PnP ACPI: found 10 devices
[    0.253194] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.253328] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.253333] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.253338] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.253342] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.253350] pci 0000:04:08.0: PCI bridge to [bus 05]
[    0.253355] pci 0000:04:08.0:   bridge window [io  0x6000-0x6fff]
[    0.253365] pci 0000:04:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.253381] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.253386] pci 0000:03:04.0:   bridge window [io  0x6000-0x7fff]
[    0.253394] pci 0000:03:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.253400] pci 0000:03:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.253411] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.253415] pci 0000:02:00.0:   bridge window [io  0x6000-0x7fff]
[    0.253422] pci 0000:02:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.253428] pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.253437] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.253440] pci 0000:00:04.0:   bridge window [io  0x6000-0x7fff]
[    0.253445] pci 0000:00:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.253449] pci 0000:00:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.253455] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.253459] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.253465] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.253468] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
[    0.253473] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.253479] pci 0000:0a:06.0: PCI bridge to [bus 0b]
[    0.253489] pci 0000:0a:06.0:   bridge window [mem 0xd8600000-0xd86fffff]
[    0.253497] pci 0000:0a:06.0:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
[    0.253510] pci 0000:0a:07.0: PCI bridge to [bus 0c]
[    0.253520] pci 0000:0a:07.0:   bridge window [mem 0xd8500000-0xd85fffff]
[    0.253528] pci 0000:0a:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.253541] pci 0000:0a:08.0: PCI bridge to [bus 0d]
[    0.253551] pci 0000:0a:08.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.253558] pci 0000:0a:08.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.253572] pci 0000:09:04.0: PCI bridge to [bus 0a-0d]
[    0.253576] pci 0000:09:04.0:   bridge window [io  0xc000-0xcfff]
[    0.253584] pci 0000:09:04.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.253591] pci 0000:09:04.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.253602] pci 0000:08:00.0: PCI bridge to [bus 09-0d]
[    0.253606] pci 0000:08:00.0:   bridge window [io  0xc000-0xcfff]
[    0.253613] pci 0000:08:00.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.253619] pci 0000:08:00.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.253628] pci 0000:00:0b.0: PCI bridge to [bus 08-0d]
[    0.253632] pci 0000:00:0b.0:   bridge window [io  0xc000-0xcfff]
[    0.253636] pci 0000:00:0b.0:   bridge window [mem 0xd0000000-0xd87fffff]
[    0.253640] pci 0000:00:0b.0:   bridge window [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.253646] pci 0000:0e:00.0: PCI bridge to [bus 0f]
[    0.253651] pci 0000:0e:00.0:   bridge window [io  0xb000-0xbfff]
[    0.253660] pci 0000:0e:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.253674] pci 0000:00:0d.0: PCI bridge to [bus 0e-0f]
[    0.253677] pci 0000:00:0d.0:   bridge window [io  0xb000-0xbfff]
[    0.253681] pci 0000:00:0d.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.253687] pci 0000:00:14.4: PCI bridge to [bus 10]
[    0.253691] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
[    0.253697] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.253705] pci 0000:00:15.0: PCI bridge to [bus 11]
[    0.253709] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
[    0.253716] pci 0000:00:15.0:   bridge window [mem 0xc7000000-0xc70fffff 64bit pref]
[    0.253723] pci 0000:00:15.1: PCI bridge to [bus 12]
[    0.253728] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.253736] pci 0000:00:15.2: PCI bridge to [bus 13]
[    0.253739] pci 0000:00:15.2:   bridge window [io  0x8000-0x8fff]
[    0.253745] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.253753] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.253754] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.253756] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.253757] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.253759] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.253760] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.253762] pci_bus 0000:00: resource 10 [mem 0xb0000000-0xdfffffff window]
[    0.253763] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.253765] pci_bus 0000:01: resource 1 [mem 0xd9000000-0xdb0fffff]
[    0.253766] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.253768] pci_bus 0000:02: resource 0 [io  0x6000-0x7fff]
[    0.253769] pci_bus 0000:02: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.253770] pci_bus 0000:02: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.253772] pci_bus 0000:03: resource 0 [io  0x6000-0x7fff]
[    0.253773] pci_bus 0000:03: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.253775] pci_bus 0000:03: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.253776] pci_bus 0000:04: resource 0 [io  0x6000-0x7fff]
[    0.253777] pci_bus 0000:04: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.253779] pci_bus 0000:04: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.253780] pci_bus 0000:05: resource 0 [io  0x6000-0x6fff]
[    0.253782] pci_bus 0000:05: resource 1 [mem 0xdd800000-0xdd8fffff]
[    0.253783] pci_bus 0000:06: resource 1 [mem 0xde100000-0xde1fffff]
[    0.253785] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.253786] pci_bus 0000:07: resource 1 [mem 0xde000000-0xde0fffff]
[    0.253787] pci_bus 0000:08: resource 0 [io  0xc000-0xcfff]
[    0.253789] pci_bus 0000:08: resource 1 [mem 0xd0000000-0xd87fffff]
[    0.253790] pci_bus 0000:08: resource 2 [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.253792] pci_bus 0000:09: resource 0 [io  0xc000-0xcfff]
[    0.253793] pci_bus 0000:09: resource 1 [mem 0xd0000000-0xd87fffff]
[    0.253794] pci_bus 0000:09: resource 2 [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.253796] pci_bus 0000:0a: resource 0 [io  0xc000-0xcfff]
[    0.253797] pci_bus 0000:0a: resource 1 [mem 0xd0000000-0xd87fffff]
[    0.253799] pci_bus 0000:0a: resource 2 [mem 0xc4000000-0xc6ffffff 64bit pref]
[    0.253800] pci_bus 0000:0b: resource 1 [mem 0xd8600000-0xd86fffff]
[    0.253802] pci_bus 0000:0b: resource 2 [mem 0xc6000000-0xc6ffffff 64bit pref]
[    0.253803] pci_bus 0000:0c: resource 1 [mem 0xd8500000-0xd85fffff]
[    0.253804] pci_bus 0000:0c: resource 2 [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.253806] pci_bus 0000:0d: resource 1 [mem 0xd8400000-0xd84fffff]
[    0.253807] pci_bus 0000:0d: resource 2 [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.253809] pci_bus 0000:0e: resource 0 [io  0xb000-0xbfff]
[    0.253810] pci_bus 0000:0e: resource 1 [mem 0xddb00000-0xddcfffff]
[    0.253811] pci_bus 0000:0f: resource 0 [io  0xb000-0xbfff]
[    0.253813] pci_bus 0000:0f: resource 1 [mem 0xddb00000-0xddbfffff]
[    0.253814] pci_bus 0000:10: resource 0 [io  0xa000-0xafff]
[    0.253816] pci_bus 0000:10: resource 1 [mem 0xddf00000-0xddffffff]
[    0.253817] pci_bus 0000:10: resource 4 [io  0x0000-0x03af window]
[    0.253819] pci_bus 0000:10: resource 5 [io  0x03e0-0x0cf7 window]
[    0.253820] pci_bus 0000:10: resource 6 [io  0x03b0-0x03df window]
[    0.253822] pci_bus 0000:10: resource 7 [io  0x0d00-0xffff window]
[    0.253823] pci_bus 0000:10: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.253824] pci_bus 0000:10: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.253826] pci_bus 0000:10: resource 10 [mem 0xb0000000-0xdfffffff window]
[    0.253827] pci_bus 0000:11: resource 0 [io  0x9000-0x9fff]
[    0.253829] pci_bus 0000:11: resource 2 [mem 0xc7000000-0xc70fffff 64bit pref]
[    0.253830] pci_bus 0000:12: resource 1 [mem 0xdde00000-0xddefffff]
[    0.253832] pci_bus 0000:13: resource 0 [io  0x8000-0x8fff]
[    0.253833] pci_bus 0000:13: resource 1 [mem 0xddd00000-0xdddfffff]
[    0.253853] NET: Registered protocol family 2
[    0.254005] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.254222] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.254405] TCP: Hash tables configured (established 131072 bind 65536)
[    0.254436] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.254490] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.254581] NET: Registered protocol family 1
[    0.550961] pci 0000:01:00.0: Video device with shadowed ROM
[    0.550964] pci 0000:02:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.551018] pci 0000:08:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.551092] PCI: CLS 64 bytes, default 64
[    0.551138] Unpacking initramfs...
[    1.216602] microcode: microcode: updated early to new patch_level=0x0600063d
[    1.218243] Freeing initrd memory: 7840K (ffff8800370a0000 - ffff880037848000)
[    1.218323] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: 3e info 1300
[    1.218327] AMD-Vi:        mmio-addr: 00000000feb20000
[    1.218348] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:00.0 flags: 00
[    1.218351] AMD-Vi:   DEV_RANGE_END		 devid: 00:00.2
[    1.218355] AMD-Vi:   DEV_SELECT			 devid: 00:02.0 flags: 00
[    1.218357] AMD-Vi:   DEV_SELECT			 devid: 01:00.0 flags: 00
[    1.218360] AMD-Vi:   DEV_SELECT			 devid: 00:04.0 flags: 00
[    1.218363] AMD-Vi:   DEV_SELECT			 devid: 02:00.0 flags: 00
[    1.218366] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 03:01.0 flags: 00 devid_to: 03:00.0
[    1.218371] AMD-Vi:   DEV_RANGE_END		 devid: 05:1f.7
[    1.218385] AMD-Vi:   DEV_SELECT			 devid: 00:09.0 flags: 00
[    1.218388] AMD-Vi:   DEV_SELECT			 devid: 06:00.0 flags: 00
[    1.218391] AMD-Vi:   DEV_SELECT			 devid: 00:0a.0 flags: 00
[    1.218394] AMD-Vi:   DEV_SELECT			 devid: 07:00.0 flags: 00
[    1.218397] AMD-Vi:   DEV_SELECT			 devid: 00:0b.0 flags: 00
[    1.218399] AMD-Vi:   DEV_SELECT			 devid: 08:00.0 flags: 00
[    1.218402] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 09:01.0 flags: 00 devid_to: 09:00.0
[    1.218407] AMD-Vi:   DEV_RANGE_END		 devid: 0d:1f.7
[    1.218429] AMD-Vi:   DEV_SELECT			 devid: 00:0d.0 flags: 00
[    1.218432] AMD-Vi:   DEV_SELECT			 devid: 0e:00.0 flags: 00
[    1.218435] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 0f:01.0 flags: 00 devid_to: 0f:00.0
[    1.218440] AMD-Vi:   DEV_RANGE_END		 devid: 0f:1f.7
[    1.218446] AMD-Vi:   DEV_SELECT			 devid: 00:11.0 flags: 00
[    1.218449] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:12.0 flags: 00
[    1.218452] AMD-Vi:   DEV_RANGE_END		 devid: 00:12.2
[    1.218455] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:13.0 flags: 00
[    1.218457] AMD-Vi:   DEV_RANGE_END		 devid: 00:13.2
[    1.218460] AMD-Vi:   DEV_SELECT			 devid: 00:14.0 flags: d7
[    1.218463] AMD-Vi:   DEV_SELECT			 devid: 00:14.1 flags: 00
[    1.218466] AMD-Vi:   DEV_SELECT			 devid: 00:14.2 flags: 00
[    1.218469] AMD-Vi:   DEV_SELECT			 devid: 00:14.3 flags: 00
[    1.218471] AMD-Vi:   DEV_SELECT			 devid: 00:14.4 flags: 00
[    1.218474] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 10:00.0 flags: 00 devid_to: 00:14.4
[    1.218479] AMD-Vi:   DEV_RANGE_END		 devid: 10:1f.7
[    1.218485] AMD-Vi:   DEV_SELECT			 devid: 00:14.5 flags: 00
[    1.218488] AMD-Vi:   DEV_SELECT			 devid: 00:15.0 flags: 00
[    1.218491] AMD-Vi:   DEV_SELECT			 devid: 11:00.0 flags: 00
[    1.218494] AMD-Vi:   DEV_SELECT			 devid: 00:15.1 flags: 00
[    1.218497] AMD-Vi:   DEV_SELECT			 devid: 12:00.0 flags: 00
[    1.218499] AMD-Vi:   DEV_SELECT			 devid: 00:15.2 flags: 00
[    1.218502] AMD-Vi:   DEV_SELECT			 devid: 13:00.0 flags: 00
[    1.218505] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:16.0 flags: 00
[    1.218508] AMD-Vi:   DEV_RANGE_END		 devid: 00:16.2
[    1.218511] AMD-Vi:   DEV_SPECIAL(IOAPIC[9])		devid: 00:14.0
[    1.218514] AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
[    1.218517] AMD-Vi:   DEV_SPECIAL(IOAPIC[10])		devid: 00:00.1
[    1.362776] iommu: Adding device 0000:00:00.0 to group 0
[    1.363161] iommu: Adding device 0000:00:02.0 to group 1
[    1.363539] iommu: Adding device 0000:00:04.0 to group 2
[    1.363922] iommu: Adding device 0000:00:09.0 to group 3
[    1.364304] iommu: Adding device 0000:00:0a.0 to group 4
[    1.364684] iommu: Adding device 0000:00:0b.0 to group 5
[    1.365067] iommu: Adding device 0000:00:0d.0 to group 6
[    1.365446] iommu: Adding device 0000:00:11.0 to group 7
[    1.365848] iommu: Adding device 0000:00:12.0 to group 8
[    1.365869] iommu: Adding device 0000:00:12.2 to group 8
[    1.366267] iommu: Adding device 0000:00:13.0 to group 9
[    1.366289] iommu: Adding device 0000:00:13.2 to group 9
[    1.366670] iommu: Adding device 0000:00:14.0 to group 10
[    1.367056] iommu: Adding device 0000:00:14.1 to group 11
[    1.367435] iommu: Adding device 0000:00:14.2 to group 12
[    1.367813] iommu: Adding device 0000:00:14.3 to group 13
[    1.368229] iommu: Adding device 0000:00:14.4 to group 14
[    1.368609] iommu: Adding device 0000:00:14.5 to group 15
[    1.369024] iommu: Adding device 0000:00:15.0 to group 16
[    1.369049] iommu: Adding device 0000:00:15.1 to group 16
[    1.369075] iommu: Adding device 0000:00:15.2 to group 16
[    1.369473] iommu: Adding device 0000:00:16.0 to group 17
[    1.369497] iommu: Adding device 0000:00:16.2 to group 17
[    1.369887] iommu: Adding device 0000:01:00.0 to group 18
[    1.370270] iommu: Adding device 0000:02:00.0 to group 19
[    1.370280] iommu: Adding device 0000:03:04.0 to group 19
[    1.370290] iommu: Adding device 0000:04:04.0 to group 19
[    1.370300] iommu: Adding device 0000:04:05.0 to group 19
[    1.370311] iommu: Adding device 0000:04:06.0 to group 19
[    1.370321] iommu: Adding device 0000:04:07.0 to group 19
[    1.370331] iommu: Adding device 0000:04:08.0 to group 19
[    1.370342] iommu: Adding device 0000:04:09.0 to group 19
[    1.370352] iommu: Adding device 0000:04:0a.0 to group 19
[    1.370362] iommu: Adding device 0000:05:00.0 to group 19
[    1.370745] iommu: Adding device 0000:06:00.0 to group 20
[    1.371132] iommu: Adding device 0000:07:00.0 to group 21
[    1.371514] iommu: Adding device 0000:08:00.0 to group 22
[    1.371525] iommu: Adding device 0000:09:04.0 to group 22
[    1.371535] iommu: Adding device 0000:0a:04.0 to group 22
[    1.371546] iommu: Adding device 0000:0a:05.0 to group 22
[    1.371556] iommu: Adding device 0000:0a:06.0 to group 22
[    1.371566] iommu: Adding device 0000:0a:07.0 to group 22
[    1.371576] iommu: Adding device 0000:0a:08.0 to group 22
[    1.371586] iommu: Adding device 0000:0a:09.0 to group 22
[    1.371596] iommu: Adding device 0000:0a:0a.0 to group 22
[    1.371607] iommu: Adding device 0000:0b:00.0 to group 22
[    1.371617] iommu: Adding device 0000:0c:00.0 to group 22
[    1.371628] iommu: Adding device 0000:0d:00.0 to group 22
[    1.372019] iommu: Adding device 0000:0e:00.0 to group 23
[    1.372029] iommu: Adding device 0000:0f:04.0 to group 23
[    1.372039] iommu: Adding device 0000:10:06.0 to group 14
[    1.372054] iommu: Adding device 0000:11:00.0 to group 16
[    1.372067] iommu: Adding device 0000:12:00.0 to group 16
[    1.372079] iommu: Adding device 0000:13:00.0 to group 16
[    1.372082] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.372156] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.374178] perf: AMD NB counters detected
[    1.374237] LVT offset 0 assigned for vector 0x400
[    1.374256] perf: AMD IBS detected (0x000000ff)
[    1.374831] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    1.375048] Initialise system trusted keyring
[    1.375177] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    1.375180] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.376574] zbud: loaded
[    1.376743] VFS: Disk quotas dquot_6.6.0
[    1.376775] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.377435] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.377442] io scheduler noop registered
[    1.377445] io scheduler deadline registered
[    1.377471] io scheduler cfq registered (default)
[    1.378254] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.378262] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.378286] vesafb: mode is 1280x1024x16, linelength=2560, pages=0
[    1.378289] vesafb: scrolling: redraw
[    1.378293] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    1.378300] pmd_set_huge: Cannot satisfy [mem 0xb0000000-0xb0200000] with a huge-page mapping due to MTRR override.
[    1.378311] vesafb: framebuffer at 0xb0000000, mapped to 0xffffc90000400000, using 2560k, total 2560k
[    1.393756] Console: switching to colour frame buffer device 160x64
[    1.409171] fb0: VESA VGA frame buffer device
[    1.409284] GHES: HEST is not enabled!
[    1.409387] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.429996] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.430790] Non-volatile memory driver v1.3
[    1.430897] Linux agpgart interface v0.103
[    1.433893] ahci 0000:00:11.0: version 3.0
[    1.433964] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    1.434106] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    1.434741] scsi host0: ahci
[    1.434883] scsi host1: ahci
[    1.435010] scsi host2: ahci
[    1.435137] scsi host3: ahci
[    1.435225] ata1: SATA max UDMA/133 abar m1024@0xd880b000 port 0xd880b100 irq 19
[    1.435354] ata2: SATA max UDMA/133 abar m1024@0xd880b000 port 0xd880b180 irq 19
[    1.435483] ata3: SATA max UDMA/133 abar m1024@0xd880b000 port 0xd880b200 irq 19
[    1.435612] ata4: SATA max UDMA/133 abar m1024@0xd880b000 port 0xd880b280 irq 19
[    1.435932] ahci 0000:07:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.436073] ahci 0000:07:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.436500] scsi host4: ahci
[    1.436635] scsi host5: ahci
[    1.436724] ata5: SATA max UDMA/133 abar m512@0xde010000 port 0xde010100 irq 29
[    1.436857] ata6: SATA max UDMA/133 abar m512@0xde010000 port 0xde010180 irq 29
[    1.437119] ahci 0000:13:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.437259] ahci 0000:13:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.437696] scsi host6: ahci
[    1.437836] scsi host7: ahci
[    1.437926] ata7: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10100 irq 28
[    1.438054] ata8: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10180 irq 28
[    1.438195] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.438311] ehci-pci: EHCI PCI platform driver
[    1.438461] QUIRK: Enable AMD PLL fix
[    1.438483] ehci-pci 0000:00:12.2: EHCI Host Controller
[    1.438576] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    1.438705] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.438873] ehci-pci 0000:00:12.2: debug port 1
[    1.438977] ehci-pci 0000:00:12.2: irq 17, io mem 0xd8809000
[    1.444849] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.444995] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.445112] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.445236] usb usb1: Product: EHCI Host Controller
[    1.449637] usb usb1: Manufacturer: Linux 4.4.0-lcrs ehci_hcd
[    1.454052] usb usb1: SerialNumber: 0000:00:12.2
[    1.458552] hub 1-0:1.0: USB hub found
[    1.462919] hub 1-0:1.0: 5 ports detected
[    1.467431] ehci-pci 0000:00:13.2: EHCI Host Controller
[    1.471758] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    1.476179] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.480641] ehci-pci 0000:00:13.2: debug port 1
[    1.485090] ehci-pci 0000:00:13.2: irq 17, io mem 0xd8807000
[    1.494844] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.499225] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.503595] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.507986] usb usb2: Product: EHCI Host Controller
[    1.512391] usb usb2: Manufacturer: Linux 4.4.0-lcrs ehci_hcd
[    1.516836] usb usb2: SerialNumber: 0000:00:13.2
[    1.521341] hub 2-0:1.0: USB hub found
[    1.525719] hub 2-0:1.0: 5 ports detected
[    1.530229] ehci-pci 0000:00:16.2: EHCI Host Controller
[    1.534571] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 3
[    1.538955] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.543365] ehci-pci 0000:00:16.2: debug port 1
[    1.547697] ehci-pci 0000:00:16.2: irq 17, io mem 0xd8804000
[    1.557838] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    1.562056] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.566268] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.570493] usb usb3: Product: EHCI Host Controller
[    1.574691] usb usb3: Manufacturer: Linux 4.4.0-lcrs ehci_hcd
[    1.578885] usb usb3: SerialNumber: 0000:00:16.2
[    1.583113] hub 3-0:1.0: USB hub found
[    1.587207] hub 3-0:1.0: 4 ports detected
[    1.591391] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.595485] uhci_hcd: USB Universal Host Controller Interface driver
[    1.599603] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.603686] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.608061] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.612455] mousedev: PS/2 mouse device common for all mice
[    1.617935] rtc_cmos 00:05: RTC can wake from S4
[    1.622397] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.626828] rtc_cmos 00:05: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.631491] ledtrig-cpu: registered to indicate activity on CPUs
[    1.636083] hidraw: raw HID events driver (C) Jiri Kosina
[    1.640729] usbcore: registered new interface driver usbhid
[    1.645264] usbhid: USB HID core driver
[    1.649938] NET: Registered protocol family 10
[    1.654508] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.659354] Key type dns_resolver registered
[    1.664373] microcode: CPU0: patch_level=0x0600063d
[    1.669015] microcode: CPU1: patch_level=0x0600063d
[    1.673584] microcode: CPU2: patch_level=0x0600063d
[    1.678074] microcode: CPU3: patch_level=0x0600063d
[    1.682568] microcode: CPU4: patch_level=0x0600063d
[    1.686971] microcode: CPU5: patch_level=0x0600063d
[    1.691378] microcode: CPU6: patch_level=0x0600063d
[    1.695690] microcode: CPU7: patch_level=0x0600063d
[    1.699965] microcode: Microcode Update Driver: v2.01 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    1.704473] registered taskstats version 1
[    1.708818] Loading compiled-in X.509 certificates
[    1.713159] zswap: loaded using pool lzo/zbud
[    1.718128]   Magic number: 0:463:129
[    1.722447] acpi PNP0C02:01: hash matches
[    1.726758] acpi device:04: hash matches
[    1.731065] rtc_cmos 00:05: setting system clock to 2016-01-14 13:06:14 UTC (1452776774)
[    1.741833] ata5: SATA link down (SStatus 0 SControl 300)
[    1.746199] ata6: SATA link down (SStatus 0 SControl 300)
[    1.894815] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.898828] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.898854] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.899572] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[    1.911979] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.916312] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.920559] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.960222] ata1.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[    1.964394] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.968627] ata4.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    1.972830] ata4.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.977067] ata3.00: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
[    1.981278] ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    1.985547] ata2.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    1.989809] ata2.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.024777] ata2.00: configured for UDMA/133
[    2.029109] ata1.00: configured for UDMA/133
[    2.033382] ata4.00: configured for UDMA/133
[    2.033493] scsi 0:0:0:0: Direct-Access     ATA      ST3160815AS      B    PQ: 0 ANSI: 5
[    2.033644] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.033681] sd 0:0:0:0: [sda] Write Protect is off
[    2.033685] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.033710] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.033769] scsi 1:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.033918] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.033965] sd 1:0:0:0: [sdb] Write Protect is off
[    2.033967] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.033984] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.072228] ata3.00: configured for UDMA/133
[    2.076746] scsi 2:0:0:0: Direct-Access     ATA      ST3160811AS      E    PQ: 0 ANSI: 5
[    2.081378] sd 2:0:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.085990] sd 2:0:0:0: [sdc] Write Protect is off
[    2.086085] scsi 3:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.086205] sd 3:0:0:0: [sdd] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.086228] sd 3:0:0:0: [sdd] Write Protect is off
[    2.086229] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.086238] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.108681] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.108693] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.129298]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
[    2.130134]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 >
[    2.136084] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.142833] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.177760]  sdd: sdd1 sdd2 sdd3 < sdd5 sdd6 sdd7 >
[    2.182356] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.207025]  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 >
[    2.211616] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.373764] tsc: Refined TSC clocksource calibration: 3616.531 MHz
[    2.377998] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x342153952fd, max_idle_ns: 440795386796 ns
[    3.381741] clocksource: Switched to clocksource tsc
[    6.898365] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[    7.360326] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.364839] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.369344] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[    7.373948] ata8: limiting SATA link speed to 1.5 Gbps
[   12.363887] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   12.368673] ata7: limiting SATA link speed to 1.5 Gbps
[   12.832841] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   12.837682] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   12.842392] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   17.836405] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   18.299357] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   18.304107] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   18.315036] Freeing unused kernel memory: 984K (ffffffff80ecf000 - ffffffff80fc5000)
[   18.319835] Write protecting the kernel read-only data: 12288k
[   18.325175] Freeing unused kernel memory: 1972K (ffff880000813000 - ffff880000a00000)
[   18.332104] Freeing unused kernel memory: 1132K (ffff880000ce5000 - ffff880000e00000)
[   18.338382] random: systemd urandom read with 88 bits of entropy available
[   18.343479] systemd[1]: systemd 210 running in system mode. (+PAM -LIBWRAP +AUDIT +SELINUX -IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ +SECCOMP +APPARMOR)
[   18.348811] systemd[1]: Detected architecture 'x86-64'.
[   18.353984] systemd[1]: Running in initial RAM disk.
[   18.375285] systemd[1]: Inserted module 'autofs4'
[   18.380634] systemd[1]: Set hostname to <harley>.
[   18.418283] systemd[1]: Expecting device dev-disk-by\x2did-ata\x2dST3160815AS_6RACD7A6\x2dpart5.device...
[   18.429155] systemd[1]: Starting Timers.
[   18.439954] systemd[1]: Reached target Timers.
[   18.445334] systemd[1]: Starting -.slice.
[   18.463505] systemd[1]: Created slice -.slice.
[   18.468885] systemd[1]: Starting udev Control Socket.
[   18.479746] systemd[1]: Listening on udev Control Socket.
[   18.485151] systemd[1]: Starting udev Kernel Socket.
[   18.495904] systemd[1]: Listening on udev Kernel Socket.
[   18.501240] systemd[1]: Starting Journal Socket.
[   18.511831] systemd[1]: Listening on Journal Socket.
[   18.517109] systemd[1]: Starting Sockets.
[   18.527460] systemd[1]: Reached target Sockets.
[   18.532590] systemd[1]: Starting System Slice.
[   18.542817] systemd[1]: Created slice System Slice.
[   18.547874] systemd[1]: Starting system-systemd\x2dfsck.slice.
[   18.558060] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   18.563284] systemd[1]: Starting dracut cmdline hook...
[   18.579499] systemd[1]: Starting Load Kernel Modules...
[   18.590210] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[   18.596162] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   18.596194] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   18.596224] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   18.596254] sd 3:0:0:0: Attached scsi generic sg3 type 0
[   18.622681] systemd[1]: Starting Journal Service...
[   18.633159] systemd[1]: Starting Slices.
[   18.643389] systemd[1]: Reached target Slices.
[   18.648454] systemd[1]: Starting Setup Virtual Console...
[   18.662414] systemd[1]: Starting Swap.
[   18.672303] systemd[1]: Reached target Swap.
[   18.677295] systemd[1]: Starting Local File Systems.
[   18.687321] systemd[1]: Reached target Local File Systems.
[   18.712760] systemd[1]: Started Journal Service.
[   18.827417] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[   18.833635] ACPI: Power Button [PWRB]
[   18.838236] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   18.838331] ohci-pci: OHCI PCI platform driver
[   18.838588] ACPI: Power Button [PWRF]
[   18.839015] ohci-pci 0000:00:12.0: OHCI PCI host controller
[   18.839027] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[   18.839061] ohci-pci 0000:00:12.0: irq 18, io mem 0xd880a000
[   18.841810] wmi: Mapper loaded
[   18.868305] random: nonblocking pool is initialized
[   18.893734] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[   18.893736] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.893737] usb usb4: Product: OHCI PCI host controller
[   18.893738] usb usb4: Manufacturer: Linux 4.4.0-lcrs ohci_hcd
[   18.893738] usb usb4: SerialNumber: 0000:00:12.0
[   18.893848] hub 4-0:1.0: USB hub found
[   18.893857] hub 4-0:1.0: 5 ports detected
[   18.895080] scsi host9: pata_atiixp
[   18.895162] scsi host10: pata_atiixp
[   18.895203] ata9: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
[   18.895203] ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
[   18.895387] ohci-pci 0000:00:13.0: OHCI PCI host controller
[   18.895392] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
[   18.895412] ohci-pci 0000:00:13.0: irq 18, io mem 0xd8808000
[   18.950454] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[   18.950455] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.950456] usb usb5: Product: OHCI PCI host controller
[   18.950457] usb usb5: Manufacturer: Linux 4.4.0-lcrs ohci_hcd
[   18.950457] usb usb5: SerialNumber: 0000:00:13.0
[   18.950566] hub 5-0:1.0: USB hub found
[   18.950574] hub 5-0:1.0: 5 ports detected
[   18.950770] ohci-pci 0000:00:14.5: OHCI PCI host controller
[   18.950774] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
[   18.950792] ohci-pci 0000:00:14.5: irq 18, io mem 0xd8806000
[   19.006777] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[   19.011355] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.011357] usb usb6: Product: OHCI PCI host controller
[   19.011358] usb usb6: Manufacturer: Linux 4.4.0-lcrs ohci_hcd
[   19.011359] usb usb6: SerialNumber: 0000:00:14.5
[   19.011490] hub 6-0:1.0: USB hub found
[   19.011499] hub 6-0:1.0: 2 ports detected
[   19.011702] ohci-pci 0000:00:16.0: OHCI PCI host controller
[   19.011707] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
[   19.011728] ohci-pci 0000:00:16.0: irq 18, io mem 0xd8805000
[   19.064525] ata9.00: ATAPI: SONY    DVD RW AD-7260S, 1.61, max UDMA/100
[   19.066370] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[   19.066372] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   19.066373] usb usb7: Product: OHCI PCI host controller
[   19.066374] usb usb7: Manufacturer: Linux 4.4.0-lcrs ohci_hcd
[   19.066375] usb usb7: SerialNumber: 0000:00:16.0
[   19.066506] hub 7-0:1.0: USB hub found
[   19.066515] hub 7-0:1.0: 4 ports detected
[   19.102028] ata9.01: ATA-8: ST3500418AS, CC38, max UDMA/133
[   19.102029] ata9.01: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   19.102032] ata9.00: limited to UDMA/33 due to 40-wire cable
[   19.102033] ata9.01: limited to UDMA/33 due to 40-wire cable
[   19.107708] ata9.00: configured for UDMA/33
[   19.113926] ata9.01: configured for UDMA/33
[   19.115895] scsi 9:0:0:0: CD-ROM            SONY     DVD RW AD-7260S  1.61 PQ: 0 ANSI: 5
[   19.127122] scsi 9:0:0:0: Attached scsi generic sg4 type 5
[   19.127324] scsi 9:0:1:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5
[   19.127581] sd 9:0:1:0: [sde] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[   19.127598] sd 9:0:1:0: Attached scsi generic sg5 type 0
[   19.127830] sd 9:0:1:0: [sde] Write Protect is off
[   19.127913] sd 9:0:1:0: [sde] Mode Sense: 00 3a 00 00
[   19.127925] sd 9:0:1:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   19.152969]  sde: sde1
[   19.153171] sd 9:0:1:0: [sde] Attached SCSI disk
[   19.166953] sr 9:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   19.167105] cdrom: Uniform CD-ROM driver Revision: 3.20
[   19.167402] sr 9:0:0:0: Attached scsi CD-ROM sr0
[   19.216280] usb 4-4: new low-speed USB device number 2 using ohci-pci
[   19.367287] usb 4-4: New USB device found, idVendor=046d, idProduct=c00e
[   19.367420] usb 4-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   19.367544] usb 4-4: Product: USB-PS/2 Optical Mouse
[   19.367645] usb 4-4: Manufacturer: Logitech
[   19.375520] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-4/4-4:1.0/0003:046D:C00E.0001/input/input3
[   19.375835] hid-generic 0003:046D:C00E.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:12.0-4/input0
[   23.971856] scsi host11: Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec 29320LPE PCIe Ultra320 SCSI adapter>
        aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133MHz, 512 SCBs
[   23.981503] scsi 11:0:0:0: Direct-Access     SEAGATE  ST15150N         5055 PQ: 0 ANSI: 2
[   23.981648] scsi target11:0:0: asynchronous
[   23.981720] scsi11:A:0:0: Tagged Queuing enabled.  Depth 32
[   23.981821] scsi target11:0:0: Beginning Domain Validation
[   24.002049] scsi target11:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   24.016356] scsi target11:0:0: Domain Validation skipping write tests
[   24.016469] scsi target11:0:0: Ending Domain Validation
[   24.016756] sd 11:0:0:0: Attached scsi generic sg6 type 0
[   24.035140] sd 11:0:0:0: [sdf] Unsupported sector size 768.
[   24.035240] sd 11:0:0:0: [sdf] 0 512-byte logical blocks: (0 B/0 B)
[   24.035348] sd 11:0:0:0: [sdf] 768-byte physical blocks
[   24.041675] sd 11:0:0:0: [sdf] Write Protect is off
[   24.041760] sd 11:0:0:0: [sdf] Mode Sense: ab 00 10 08
[   24.042324] scsi 11:0:1:0: Direct-Access     SEAGATE  ST15150N         5055 PQ: 0 ANSI: 2
[   24.042468] scsi target11:0:1: asynchronous
[   24.042540] scsi11:A:1:0: Tagged Queuing enabled.  Depth 32
[   24.042640] scsi target11:0:1: Beginning Domain Validation
[   24.049153] sd 11:0:0:0: [sdf] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   24.058670] sd 11:0:0:0: [sdf] Unsupported sector size 768.
[   24.063581] scsi target11:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   24.075190] sd 11:0:0:0: [sdf] Attached SCSI disk
[   24.078969] scsi target11:0:1: Domain Validation skipping write tests
[   24.079082] scsi target11:0:1: Ending Domain Validation
[   24.079357] sd 11:0:1:0: Attached scsi generic sg7 type 0
[   24.353428] sd 11:0:1:0: [sdg] Unsupported sector size 768.
[   24.353527] sd 11:0:1:0: [sdg] 0 512-byte logical blocks: (0 B/0 B)
[   24.353635] sd 11:0:1:0: [sdg] 768-byte physical blocks
[   24.355324] scsi 11:0:3:0: Sequential-Access SONY     SDT-10000        0110 PQ: 0 ANSI: 2
[   24.355469] scsi target11:0:3: asynchronous
[   24.355542] scsi target11:0:3: Beginning Domain Validation
[   24.363006] sd 11:0:1:0: [sdg] Write Protect is off
[   24.363091] sd 11:0:1:0: [sdg] Mode Sense: ab 00 10 08
[   24.363672] scsi target11:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
[   24.369079] scsi target11:0:3: Domain Validation skipping write tests
[   24.369191] scsi target11:0:3: Ending Domain Validation
[   24.373365] sd 11:0:1:0: [sdg] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   24.379770] scsi 11:0:3:0: Attached scsi generic sg8 type 1
[   24.383305] sd 11:0:1:0: [sdg] Unsupported sector size 768.
[   25.677812] sd 11:0:1:0: [sdg] Attached SCSI disk
[   33.873980] scsi host8: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2930CU SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

[   34.162432] scsi 8:0:1:0: Sequential-Access HP       88780            A674 PQ: 0 ANSI: 1 CCS
[   34.167929] scsi target8:0:1: Beginning Domain Validation
[   34.191636] scsi target8:0:1: Ending Domain Validation
[   34.197183] scsi 8:0:1:0: Attached scsi generic sg9 type 1
[   35.818480] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
[   36.099734] systemd-journald[229]: Received SIGTERM from PID 1 (systemd).
[   38.297819] device-mapper: uevent: version 1.0.3
[   38.302869] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[   39.585739] systemd-readahead[511]: Bumped block_nr parameter of 8:0 to 20480. This is a temporary hack and should be removed one day.
[   40.870793] EXT4-fs (sda5): re-mounted. Opts: acl,user_xattr
[   42.021407] Warning: Processor Platform Limit event detected, but not handled.
[   42.024952] Consider compiling CPUfreq support into your kernel.
[   42.165701] AVX version of gcm_enc/dec engaged.
[   42.169285] AES CTR mode by8 optimization enabled
[   43.177315] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   43.265686] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   43.269465] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[   43.646754] FUJITSU Extended Socket Network Device Driver - version 1.0 - Copyright (c) 2015 FUJITSU LIMITED
[   43.680651] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   44.587474] EXT4-fs (sde1): mounting ext3 file system using the ext4 subsystem
[   44.611755] EXT4-fs (sde1): mounted filesystem with ordered data mode. Opts: (null)
[   44.693187] dgap: module is from the staging directory, the quality is unknown, you have been warned.
[   44.698166] dgap: dgap-1.3-16, Digi International Part Number 40002347_C
[   44.703033] dgap: For the tools package please visit http://www.digi.com
[   44.708252] dgap: dgap: board 0: AccelePort Xr920 8 port (rev 1), irq 32
[   44.784136] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   44.784142] r8169 0000:11:00.0: can't disable ASPM; OS doesn't have ASPM control
[   44.784645] r8169 0000:11:00.0 eth0: RTL8168evl/8111evl at 0xffffc90000046000, 74:d4:35:1f:b2:9e, XID 0c900800 IRQ 33
[   44.784646] r8169 0000:11:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   44.809104] st: Version 20101219, fixed bufsize 32768, s/g segs 256
[   44.816231] st 11:0:3:0: Attached scsi tape st0
[   44.816233] st 11:0:3:0: st0: try direct i/o: yes (alignment 4 B)
[   44.816555] st 8:0:1:0: Attached scsi tape st1
[   44.816556] st 8:0:1:0: st1: try direct i/o: yes (alignment 4 B)
[   44.962632] EXT4-fs (sdd5): mounting ext3 file system using the ext4 subsystem
[   45.016009] EXT4-fs (sdd5): mounted filesystem with ordered data mode. Opts: (null)
[   45.282613] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   45.288615] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 8
[   45.294721] xhci_hcd 0000:06:00.0: hcc params 0x040050af hci version 0x100 quirks 0x00080490
[   45.301051] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[   45.307572] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   45.313760] usb usb8: Product: xHCI Host Controller
[   45.319753] usb usb8: Manufacturer: Linux 4.4.0-lcrs xhci-hcd
[   45.325741] usb usb8: SerialNumber: 0000:06:00.0
[   45.331771] hub 8-0:1.0: USB hub found
[   45.337651] hub 8-0:1.0: 2 ports detected
[   45.343520] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   45.349243] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 9
[   45.354979] usb usb9: We don't know the algorithms for LPM for this host, disabling LPM.
[   45.360718] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[   45.366396] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   45.366397] usb usb9: Product: xHCI Host Controller
[   45.366398] usb usb9: Manufacturer: Linux 4.4.0-lcrs xhci-hcd
[   45.366399] usb usb9: SerialNumber: 0000:06:00.0
[   45.366510] hub 9-0:1.0: USB hub found
[   45.366518] hub 9-0:1.0: 2 ports detected
[   45.366681] xhci_hcd 0000:12:00.0: xHCI Host Controller
[   45.366685] xhci_hcd 0000:12:00.0: new USB bus registered, assigned bus number 10
[   45.366841] xhci_hcd 0000:12:00.0: hcc params 0x040050af hci version 0x100 quirks 0x00080490
[   45.367004] usb usb10: New USB device found, idVendor=1d6b, idProduct=0002
[   45.367005] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   45.367006] usb usb10: Product: xHCI Host Controller
[   45.367007] usb usb10: Manufacturer: Linux 4.4.0-lcrs xhci-hcd
[   45.367007] usb usb10: SerialNumber: 0000:12:00.0
[   45.367137] hub 10-0:1.0: USB hub found
[   45.367145] hub 10-0:1.0: 2 ports detected
[   45.367274] xhci_hcd 0000:12:00.0: xHCI Host Controller
[   45.367276] xhci_hcd 0000:12:00.0: new USB bus registered, assigned bus number 11
[   45.367291] usb usb11: We don't know the algorithms for LPM for this host, disabling LPM.
[   45.367306] usb usb11: New USB device found, idVendor=1d6b, idProduct=0003
[   45.367307] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   45.367308] usb usb11: Product: xHCI Host Controller
[   45.367308] usb usb11: Manufacturer: Linux 4.4.0-lcrs xhci-hcd
[   45.367309] usb usb11: SerialNumber: 0000:12:00.0
[   45.367406] hub 11-0:1.0: USB hub found
[   45.367415] hub 11-0:1.0: 2 ports detected
[   45.460280] EXT4-fs (sdb5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   45.519952] osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.1.1.1 2016/01/12 18:56:18 markh Exp $
[   45.810117] EXT4-fs (sdb6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   45.832284] EXT4-fs (sdd6): mounting ext3 file system using the ext4 subsystem
[   45.882432] EXT4-fs (sdd6): mounted filesystem with ordered data mode. Opts: (null)
[   45.887471] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   45.959823] EXT4-fs (sdb7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   46.074975] EXT4-fs (sdc5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   46.158993] EXT4-fs (sdd1): mounting ext3 file system using the ext4 subsystem
[   46.194815] EXT4-fs (sdd1): mounted filesystem with ordered data mode. Opts: (null)
[   46.377048] [drm] Initialized drm 1.1.0 20060810
[   46.404829] EXT4-fs (sdc7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   46.439118] EXT4-fs (sdd7): mounting ext3 file system using the ext4 subsystem
[   46.469830] EXT4-fs (sdc6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   46.504297] EXT4-fs (sdd7): mounted filesystem with ordered data mode. Opts: (null)
[   46.521607] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   46.918466] Adding 8385532k swap on /dev/sda2.  Priority:-1 extents:1 across:8385532k FS
[   47.300886] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC889: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   47.306818] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   47.312776] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   47.318683] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   47.324611] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[   47.330449] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   47.336187] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   47.341875] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   47.347495] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   47.371456] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input5
[   47.371692] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[   47.371756] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[   47.371823] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[   47.371886] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[   47.371949] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[   47.372011] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[   47.372072] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input12
[   48.396793] EXT4-fs (sda6): mounted filesystem with ordered data mode. Opts: (null)
[   48.668346] kvm: disabled by bios
[   48.680039] kvm: disabled by bios
[   48.695049] kvm: disabled by bios
[   48.710038] kvm: disabled by bios
[   48.722018] kvm: disabled by bios
[   48.740014] kvm: disabled by bios
[   48.763021] kvm: disabled by bios
[   48.781011] kvm: disabled by bios
[   49.425702] 3c59x: Donald Becker and others.
[   49.431265] 0000:0a:04.0: 3Com PCI 3c905C Tornado at ffffc9000003a000.
[   49.437073] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: (null)
[   49.805426] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[  129.698358] systemd-journald[514]: Received request to flush runtime journal from PID 1
[  130.808424] systemd[1]: Unit apparmor.service entered failed state.
[  130.831389] systemd[1]: Received SIGRTMIN+21 from PID 355 (plymouthd).

These appear to be the 2 failing disks
#dmesg | grep -i fail 
[    1.899572] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[    6.898365] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[    7.369344] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   12.363887] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   12.842392] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   17.836405] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)

Here are the pci-ids of the Marvel chips
#lspci | grep -i marvel
07:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 12)
13:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 12)

Regards
Mark
                                                                                                                                                                                                      
 
