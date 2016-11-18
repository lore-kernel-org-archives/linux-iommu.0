From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: BUG at drivers/iommu/amd_iommu.c:1436!
Date: Fri, 18 Nov 2016 09:04:05 -0500
Message-ID: <b8260bfd-55c9-c029-1af1-e1ccc719dd3a@compro.net>
References: <838275de-6cac-93d8-ca04-54b06a24b3d4@compro.net>
	<20161117214141.GC2078@8bytes.org>
	<f4ababc2-64bf-fd0e-1d18-cb5963d23eb1@compro.net>
	<20161117220045.GD2078@8bytes.org>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------5FA726993E3A80BB147C3DB5"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161117220045.GD2078-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------5FA726993E3A80BB147C3DB5
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/2016 05:00 PM, Joerg Roedel wrote:
> On Thu, Nov 17, 2016 at 04:53:24PM -0500, Mark Hounschell wrote:
>> On 11/17/2016 04:41 PM, Joerg Roedel wrote:
>>> Hi Mark,
>>>
>>> On Thu, Nov 17, 2016 at 02:13:59PM -0500, Mark Hounschell wrote:
>>>> Kernel version is 4.8.0. No failure when the IOMMU is disabled. This
>>>> is an out of tree GPL driver using
>>>> pci_alloc_consistent/pci_free_consistent. The free causes this.
>>>
>>> Can you please run the driver with dma-api debugging enabled? Does it
>>> trigger any warnings?
>>>
>>
>> It's been a while since I've done that for ya. Kernel config
>> options? Kernel cmd line you want?
>
> Just enable CONFIG_DMA_API_DEBUG and boot the resulting kernel. Please
> send me full dmesg when the issue happens again.
>

OK. It's attached.

Mark


--------------5FA726993E3A80BB147C3DB5
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Linux version 4.8.7-lcrs (markh@harley) (gcc version 4.8.3 20140627 [gcc-4_8-branch revision 212064] (SUSE Linux) ) #1 SMP PREEMPT Fri Nov 18 08:19:32 EST 2016
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.8.7-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M audit=0 rcu_nocbs=1,2,3,4,5,6,7 3
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
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
[    0.000000] found SMP MP-table at [mem 0x000fd990-0x000fd99f] mapped at [ffff8800000fd990]
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x01113000, 0x01113fff] PGTABLE
[    0.000000] BRK [0x01114000, 0x01114fff] PGTABLE
[    0.000000] BRK [0x01115000, 0x01115fff] PGTABLE
[    0.000000] BRK [0x01116000, 0x01116fff] PGTABLE
[    0.000000] BRK [0x01117000, 0x01117fff] PGTABLE
[    0.000000] BRK [0x01118000, 0x01118fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3709c000-0x37845fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000AEE1F070 000064 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000AEE25880 0000F4 (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20160422/tbfadt-658)
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
[    0.000000] percpu: Embedded 34 pages/cpu @ffff88044fc00000 s102104 r8192 d28968 u262144
[    0.000000] pcpu-alloc: s102104 r8192 d28968 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4119292
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.8.7-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M audit=0 rcu_nocbs=1,2,3,4,5,6,7 3
[    0.000000] audit: disabled (until reboot)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Memory: 16375944K/16753368K available (6592K kernel code, 941K rwdata, 2900K rodata, 1040K init, 1124K bss, 377424K reserved, 0K cma-reserved)
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
[    0.000000] tsc: Detected 3616.268 MHz processor
[    0.000017] Calibrating delay loop (skipped), value calculated using timer frequency.. 7232.53 BogoMIPS (lpj=3616268)
[    0.000023] pid_max: default: 32768 minimum: 301
[    0.000032] ACPI: Core revision 20160422
[    0.003787] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.003808] Security Framework initialized
[    0.003836] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.003841] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.004095] CPU: Physical Processor ID: 0
[    0.004103] CPU: Processor Core ID: 0
[    0.004107] mce: CPU supports 7 MCE banks
[    0.004113] LVT offset 1 assigned for vector 0xf9
[    0.004120] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.004123] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.004352] Freeing SMP alternatives memory: 28K (ffffffff80ff1000 - ffffffff80ff8000)
[    0.007297] smpboot: APIC(10) Converting physical 1 to logical package 0
[    0.007301] smpboot: Max logical packages: 2
[    0.007630] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.119111] smpboot: CPU0: AMD FX(tm)-8150 Eight-Core Processor (family: 0x15, model: 0x1, stepping: 0x2)
[    0.119118] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.119124] ... version:                0
[    0.119127] ... bit width:              48
[    0.119129] ... generic registers:      6
[    0.119132] ... value mask:             0000ffffffffffff
[    0.119135] ... max period:             00007fffffffffff
[    0.119137] ... fixed-purpose events:   0
[    0.119140] ... event mask:             000000000000003f
[    0.131157] x86: Booting SMP configuration:
[    0.131161] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.607154] x86: Booted up 1 node, 8 CPUs
[    0.607161] smpboot: Total of 8 processors activated (57858.50 BogoMIPS)
[    0.619805] devtmpfs: initialized
[    0.619992] PM: Registering ACPI NVS region [mem 0xaea33000-0xaee2efff] (4177920 bytes)
[    0.620038] PM: Registering ACPI NVS region [mem 0xaf156000-0xaf35bfff] (2121728 bytes)
[    0.620134] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.620173] pinctrl core: initialized pinctrl subsystem
[    0.620206] RTC time: 13:44:56, date: 11/18/16
[    0.621232] NET: Registered protocol family 16
[    0.624141] cpuidle: using governor ladder
[    0.626140] cpuidle: using governor menu
[    0.626194] ACPI: bus type PCI registered
[    0.626198] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.626245] PCI: Using configuration type 1 for base access
[    0.626248] PCI: Using configuration type 1 for extended access
[    0.630248] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.630253] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.630462] ACPI: Added _OSI(Module Device)
[    0.630465] ACPI: Added _OSI(Processor Device)
[    0.630468] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.630471] ACPI: Added _OSI(Processor Aggregator Device)
[    0.630863] ACPI: Executed 3 blocks of module-level executable AML code
[    0.634471] ACPI: Interpreter enabled
[    0.634489] ACPI: (supports S0 S3 S4 S5)
[    0.634492] ACPI: Using IOAPIC for interrupt routing
[    0.634656] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.641223] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.641230] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.641238] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.641616] PCI host bridge to bus 0000:00
[    0.641620] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.641624] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.641628] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.641631] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.641635] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.641639] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.641644] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xdfffffff window]
[    0.641649] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.641659] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.641773] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    0.641881] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.641912] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.641970] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.642006] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.642036] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.642095] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.642147] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    0.642177] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.642234] pci 0000:00:09.0: System wakeup disabled by ACPI
[    0.642268] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    0.642298] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.642356] pci 0000:00:0a.0: System wakeup disabled by ACPI
[    0.642391] pci 0000:00:0b.0: [1002:5a1f] type 01 class 0x060400
[    0.642421] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
[    0.642477] pci 0000:00:0b.0: System wakeup disabled by ACPI
[    0.642514] pci 0000:00:0d.0: [1002:5a1e] type 01 class 0x060400
[    0.642544] pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
[    0.642601] pci 0000:00:0d.0: System wakeup disabled by ACPI
[    0.642641] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.642653] pci 0000:00:11.0: reg 0x10: [io  0xf090-0xf097]
[    0.642660] pci 0000:00:11.0: reg 0x14: [io  0xf080-0xf083]
[    0.642666] pci 0000:00:11.0: reg 0x18: [io  0xf070-0xf077]
[    0.642673] pci 0000:00:11.0: reg 0x1c: [io  0xf060-0xf063]
[    0.642679] pci 0000:00:11.0: reg 0x20: [io  0xf050-0xf05f]
[    0.642686] pci 0000:00:11.0: reg 0x24: [mem 0xd860b000-0xd860b3ff]
[    0.642793] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.642802] pci 0000:00:12.0: reg 0x10: [mem 0xd860a000-0xd860afff]
[    0.642895] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.642934] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.642946] pci 0000:00:12.2: reg 0x10: [mem 0xd8609000-0xd86090ff]
[    0.643004] pci 0000:00:12.2: supports D1 D2
[    0.643005] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.643059] pci 0000:00:12.2: System wakeup disabled by ACPI
[    0.643102] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.643111] pci 0000:00:13.0: reg 0x10: [mem 0xd8608000-0xd8608fff]
[    0.643210] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.643249] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.643260] pci 0000:00:13.2: reg 0x10: [mem 0xd8607000-0xd86070ff]
[    0.643318] pci 0000:00:13.2: supports D1 D2
[    0.643319] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.643374] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.643413] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.643536] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    0.643546] pci 0000:00:14.1: reg 0x10: [io  0xf040-0xf047]
[    0.643552] pci 0000:00:14.1: reg 0x14: [io  0xf030-0xf033]
[    0.643559] pci 0000:00:14.1: reg 0x18: [io  0xf020-0xf027]
[    0.643565] pci 0000:00:14.1: reg 0x1c: [io  0xf010-0xf013]
[    0.643572] pci 0000:00:14.1: reg 0x20: [io  0xf000-0xf00f]
[    0.643586] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.643590] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.643593] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.643597] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.643683] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.643698] pci 0000:00:14.2: reg 0x10: [mem 0xd8600000-0xd8603fff 64bit]
[    0.643746] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.643800] pci 0000:00:14.2: System wakeup disabled by ACPI
[    0.643834] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.643959] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.644036] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.644071] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.644081] pci 0000:00:14.5: reg 0x10: [mem 0xd8606000-0xd8606fff]
[    0.644182] pci 0000:00:14.5: System wakeup disabled by ACPI
[    0.644221] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
[    0.644272] pci 0000:00:15.0: supports D1 D2
[    0.644328] pci 0000:00:15.0: System wakeup disabled by ACPI
[    0.644366] pci 0000:00:15.1: [1002:43a1] type 01 class 0x060400
[    0.644417] pci 0000:00:15.1: supports D1 D2
[    0.644473] pci 0000:00:15.1: System wakeup disabled by ACPI
[    0.644511] pci 0000:00:15.2: [1002:43a2] type 01 class 0x060400
[    0.644561] pci 0000:00:15.2: supports D1 D2
[    0.644618] pci 0000:00:15.2: System wakeup disabled by ACPI
[    0.644658] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.644668] pci 0000:00:16.0: reg 0x10: [mem 0xd8605000-0xd8605fff]
[    0.644760] pci 0000:00:16.0: System wakeup disabled by ACPI
[    0.644799] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.644811] pci 0000:00:16.2: reg 0x10: [mem 0xd8604000-0xd86040ff]
[    0.644869] pci 0000:00:16.2: supports D1 D2
[    0.644870] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.644924] pci 0000:00:16.2: System wakeup disabled by ACPI
[    0.644964] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.645047] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.645139] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.645219] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.645302] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.645381] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.645500] pci 0000:01:00.0: [10de:0092] type 00 class 0x030000
[    0.645509] pci 0000:01:00.0: reg 0x10: [mem 0xda000000-0xdaffffff]
[    0.645516] pci 0000:01:00.0: reg 0x14: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.645524] pci 0000:01:00.0: reg 0x1c: [mem 0xd9000000-0xd9ffffff 64bit]
[    0.645529] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.645534] pci 0000:01:00.0: reg 0x30: [mem 0xdb000000-0xdb01ffff pref]
[    0.645602] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.645610] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.645615] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.645617] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.645619] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.645660] pci 0000:02:00.0: [104c:8231] type 01 class 0x060400
[    0.645746] pci 0000:02:00.0: supports D1 D2
[    0.645790] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.645799] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.645804] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.645806] pci 0000:00:04.0:   bridge window [mem 0xd0000000-0xd85fffff]
[    0.645808] pci 0000:00:04.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.645867] pci 0000:03:04.0: [12d8:8150] type 01 class 0x060400
[    0.646019] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.646027] pci 0000:02:00.0:   bridge window [io  0xd000-0xdfff]
[    0.646030] pci 0000:02:00.0:   bridge window [mem 0xd0000000-0xd85fffff]
[    0.646036] pci 0000:02:00.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.646096] pci 0000:04:04.0: [10b7:9200] type 00 class 0x020000
[    0.646127] pci 0000:04:04.0: reg 0x10: [io  0xd200-0xd27f]
[    0.646142] pci 0000:04:04.0: reg 0x14: [mem 0xd8544000-0xd854407f]
[    0.646214] pci 0000:04:04.0: reg 0x30: [mem 0xd8500000-0xd851ffff pref]
[    0.646261] pci 0000:04:04.0: supports D1 D2
[    0.646262] pci 0000:04:04.0: PME# supported from D0 D1 D2 D3hot
[    0.646318] pci 0000:04:05.0: [114a:5565] type 00 class 0x028000
[    0.646346] pci 0000:04:05.0: reg 0x10: [mem 0xd8543000-0xd85431ff]
[    0.646361] pci 0000:04:05.0: reg 0x14: [io  0xd100-0xd1ff]
[    0.646377] pci 0000:04:05.0: reg 0x18: [mem 0xd8542000-0xd854203f]
[    0.646392] pci 0000:04:05.0: reg 0x1c: [mem 0xd0000000-0xd7ffffff]
[    0.646539] pci 0000:04:06.0: [3388:0022] type 01 class 0x060400
[    0.646666] pci 0000:04:06.0: supports D1 D2
[    0.646667] pci 0000:04:06.0: PME# supported from D0 D1 D2 D3hot
[    0.646718] pci 0000:04:07.0: [13c0:0080] type 00 class 0x078000
[    0.646740] pci 0000:04:07.0: reg 0x10: [mem 0xd8541000-0xd85410ff]
[    0.646881] pci 0000:04:09.0: [114f:0027] type 00 class 0x078000
[    0.646903] pci 0000:04:09.0: reg 0x10: [mem 0xd8000000-0xd83fffff]
[    0.646989] pci 0000:04:09.0: reg 0x30: [mem 0xd8530000-0xd853ffff pref]
[    0.647047] pci 0000:04:0a.0: [9004:3860] type 00 class 0x010000
[    0.647072] pci 0000:04:0a.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.647089] pci 0000:04:0a.0: reg 0x14: [mem 0xd8540000-0xd8540fff]
[    0.647163] pci 0000:04:0a.0: reg 0x30: [mem 0xd8520000-0xd852ffff pref]
[    0.647281] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.647291] pci 0000:03:04.0:   bridge window [io  0xd000-0xdfff]
[    0.647295] pci 0000:03:04.0:   bridge window [mem 0xd0000000-0xd85fffff]
[    0.647301] pci 0000:03:04.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.647368] pci 0000:05:00.0: [1090:4710] type 00 class 0xff0000
[    0.647398] pci 0000:05:00.0: reg 0x10: [mem 0xd8400000-0xd84001ff]
[    0.647416] pci 0000:05:00.0: reg 0x14: [mem 0xc4000000-0xc4ffffff pref]
[    0.647655] pci 0000:04:06.0: PCI bridge to [bus 05]
[    0.647671] pci 0000:04:06.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.647680] pci 0000:04:06.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.647740] pci 0000:06:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.647755] pci 0000:06:00.0: reg 0x10: [mem 0xde100000-0xde107fff 64bit]
[    0.647824] pci 0000:06:00.0: supports D1 D2
[    0.647825] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.650106] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.650112] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.650156] pci 0000:07:00.0: [1b4b:9172] type 00 class 0x010601
[    0.650166] pci 0000:07:00.0: reg 0x10: [io  0xc040-0xc047]
[    0.650171] pci 0000:07:00.0: reg 0x14: [io  0xc030-0xc033]
[    0.650177] pci 0000:07:00.0: reg 0x18: [io  0xc020-0xc027]
[    0.650182] pci 0000:07:00.0: reg 0x1c: [io  0xc010-0xc013]
[    0.650188] pci 0000:07:00.0: reg 0x20: [io  0xc000-0xc00f]
[    0.650193] pci 0000:07:00.0: reg 0x24: [mem 0xde010000-0xde0101ff]
[    0.650199] pci 0000:07:00.0: reg 0x30: [mem 0xde000000-0xde00ffff pref]
[    0.650207] pci 0000:07:00.0: Enabling fixed DMA alias to 00.1
[    0.650235] pci 0000:07:00.0: PME# supported from D3hot
[    0.653103] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.653109] pci 0000:00:0a.0:   bridge window [io  0xc000-0xcfff]
[    0.653115] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.653168] pci 0000:08:00.0: [104c:8231] type 01 class 0x060400
[    0.653261] pci 0000:08:00.0: supports D1 D2
[    0.653305] pci 0000:08:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.653315] pci 0000:00:0b.0: PCI bridge to [bus 08-0b]
[    0.653320] pci 0000:00:0b.0:   bridge window [io  0x6000-0x7fff]
[    0.653322] pci 0000:00:0b.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.653324] pci 0000:00:0b.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.653386] pci 0000:09:04.0: [12d8:8150] type 01 class 0x060400
[    0.653541] pci 0000:08:00.0: PCI bridge to [bus 09-0b]
[    0.653549] pci 0000:08:00.0:   bridge window [io  0x6000-0x7fff]
[    0.653553] pci 0000:08:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.653559] pci 0000:08:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.653623] pci 0000:0a:04.0: [10b5:0480] type 00 class 0x0e8000
[    0.653654] pci 0000:0a:04.0: reg 0x10: [mem 0xdd909000-0xdd9093ff]
[    0.653669] pci 0000:0a:04.0: reg 0x14: [mem 0xdd000000-0xdd7fffff]
[    0.653685] pci 0000:0a:04.0: reg 0x18: [mem 0xdd908000-0xdd90800f]
[    0.653863] pci 0000:0a:05.0: [10b5:0480] type 00 class 0x0e8000
[    0.653894] pci 0000:0a:05.0: reg 0x10: [mem 0xdd907000-0xdd9073ff]
[    0.653909] pci 0000:0a:05.0: reg 0x14: [mem 0xdc800000-0xdcffffff]
[    0.653925] pci 0000:0a:05.0: reg 0x18: [mem 0xdd906000-0xdd90600f]
[    0.654105] pci 0000:0a:06.0: [10b5:0480] type 00 class 0x0e8000
[    0.654137] pci 0000:0a:06.0: reg 0x10: [mem 0xdd905000-0xdd9053ff]
[    0.654153] pci 0000:0a:06.0: reg 0x14: [mem 0xdc000000-0xdc7fffff]
[    0.654169] pci 0000:0a:06.0: reg 0x18: [mem 0xdd904000-0xdd90400f]
[    0.654347] pci 0000:0a:07.0: [10b5:0480] type 00 class 0x0e8000
[    0.654377] pci 0000:0a:07.0: reg 0x10: [mem 0xdd903000-0xdd9033ff]
[    0.654393] pci 0000:0a:07.0: reg 0x14: [mem 0xdb800000-0xdbffffff]
[    0.654409] pci 0000:0a:07.0: reg 0x18: [mem 0xdd902000-0xdd90200f]
[    0.654586] pci 0000:0a:08.0: [3388:0022] type 01 class 0x060400
[    0.654715] pci 0000:0a:08.0: supports D1 D2
[    0.654716] pci 0000:0a:08.0: PME# supported from D0 D1 D2 D3hot
[    0.654768] pci 0000:0a:09.0: [10b5:9030] type 00 class 0x070002
[    0.654790] pci 0000:0a:09.0: reg 0x10: [mem 0xdd901000-0xdd90107f]
[    0.654806] pci 0000:0a:09.0: reg 0x14: [io  0x7180-0x71ff]
[    0.654821] pci 0000:0a:09.0: reg 0x18: [io  0x7100-0x717f]
[    0.654934] pci 0000:0a:0a.0: [1090:4360] type 00 class 0x058000
[    0.654956] pci 0000:0a:0a.0: reg 0x10: [mem 0xdd900000-0xdd9000ff]
[    0.654971] pci 0000:0a:0a.0: reg 0x14: [io  0x7000-0x70ff]
[    0.654987] pci 0000:0a:0a.0: reg 0x18: [mem 0xc0000000-0xc3ffffff pref]
[    0.655046] pci 0000:0a:0a.0: reg 0x30: [mem 0xdd90a000-0xdd90a7ff pref]
[    0.655138] pci 0000:09:04.0: PCI bridge to [bus 0a-0b]
[    0.655148] pci 0000:09:04.0:   bridge window [io  0x6000-0x7fff]
[    0.655152] pci 0000:09:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.655159] pci 0000:09:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.655222] pci 0000:0b:00.0: [1090:0100] type 00 class 0xff0000
[    0.655247] pci 0000:0b:00.0: reg 0x10: [mem 0xdd80a000-0xdd80afff]
[    0.655266] pci 0000:0b:00.0: reg 0x14: [mem 0xdd808000-0xdd809fff]
[    0.655284] pci 0000:0b:00.0: reg 0x18: [mem 0xdd800000-0xdd807fff]
[    0.655477] pci 0000:0a:08.0: PCI bridge to [bus 0b]
[    0.655488] pci 0000:0a:08.0:   bridge window [io  0x6000-0x6fff]
[    0.655493] pci 0000:0a:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.655569] pci 0000:0c:00.0: [10b5:8114] type 01 class 0x060400
[    0.655588] pci 0000:0c:00.0: reg 0x10: [mem 0xddc00000-0xddc01fff]
[    0.655688] pci 0000:0c:00.0: PME# supported from D0 D3hot
[    0.655758] pci 0000:0c:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.655768] pci 0000:00:0d.0: PCI bridge to [bus 0c-0d]
[    0.655773] pci 0000:00:0d.0:   bridge window [io  0xb000-0xbfff]
[    0.655775] pci 0000:00:0d.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.655838] pci 0000:0d:04.0: [9005:8017] type 00 class 0x010000
[    0.655860] pci 0000:0d:04.0: reg 0x10: [io  0xb100-0xb1ff]
[    0.655877] pci 0000:0d:04.0: reg 0x14: [mem 0xddb80000-0xddb81fff 64bit]
[    0.655888] pci 0000:0d:04.0: reg 0x1c: [io  0xb000-0xb0ff]
[    0.655918] pci 0000:0d:04.0: reg 0x30: [mem 0xddb00000-0xddb7ffff pref]
[    0.656037] pci 0000:0c:00.0: PCI bridge to [bus 0d]
[    0.656046] pci 0000:0c:00.0:   bridge window [io  0xb000-0xbfff]
[    0.656050] pci 0000:0c:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.656100] pci 0000:0e:06.0: [1090:4610] type 00 class 0xff0000
[    0.656112] pci 0000:0e:06.0: reg 0x10: [io  0xa000-0xa03f]
[    0.656123] pci 0000:0e:06.0: reg 0x14: [mem 0xddf00000-0xddf00fff]
[    0.656231] pci 0000:00:14.4: PCI bridge to [bus 0e] (subtractive decode)
[    0.656236] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
[    0.656239] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.656242] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.656243] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.656243] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.656244] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.656245] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.656246] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.656247] pci 0000:00:14.4:   bridge window [mem 0xb0000000-0xdfffffff window] (subtractive decode)
[    0.656309] pci 0000:0f:00.0: [10ec:8168] type 00 class 0x020000
[    0.656325] pci 0000:0f:00.0: reg 0x10: [io  0x9000-0x90ff]
[    0.656349] pci 0000:0f:00.0: reg 0x18: [mem 0xc5004000-0xc5004fff 64bit pref]
[    0.656364] pci 0000:0f:00.0: reg 0x20: [mem 0xc5000000-0xc5003fff 64bit pref]
[    0.656444] pci 0000:0f:00.0: supports D1 D2
[    0.656445] pci 0000:0f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.656487] pci 0000:0f:00.0: System wakeup disabled by ACPI
[    0.659107] pci 0000:00:15.0: PCI bridge to [bus 0f]
[    0.659120] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
[    0.659125] pci 0000:00:15.0:   bridge window [mem 0xc5000000-0xc50fffff 64bit pref]
[    0.659179] pci 0000:10:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.659200] pci 0000:10:00.0: reg 0x10: [mem 0xdde00000-0xdde07fff 64bit]
[    0.659297] pci 0000:10:00.0: supports D1 D2
[    0.659298] pci 0000:10:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.662106] pci 0000:00:15.1: PCI bridge to [bus 10]
[    0.662116] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.662171] pci 0000:11:00.0: [1b4b:9172] type 00 class 0x010601
[    0.662185] pci 0000:11:00.0: reg 0x10: [io  0x8040-0x8047]
[    0.662193] pci 0000:11:00.0: reg 0x14: [io  0x8030-0x8033]
[    0.662201] pci 0000:11:00.0: reg 0x18: [io  0x8020-0x8027]
[    0.662209] pci 0000:11:00.0: reg 0x1c: [io  0x8010-0x8013]
[    0.662217] pci 0000:11:00.0: reg 0x20: [io  0x8000-0x800f]
[    0.662225] pci 0000:11:00.0: reg 0x24: [mem 0xddd10000-0xddd101ff]
[    0.662233] pci 0000:11:00.0: reg 0x30: [mem 0xddd00000-0xddd0ffff pref]
[    0.662242] pci 0000:11:00.0: Enabling fixed DMA alias to 00.1
[    0.662280] pci 0000:11:00.0: PME# supported from D3hot
[    0.665104] pci 0000:00:15.2: PCI bridge to [bus 11]
[    0.665111] pci 0000:00:15.2:   bridge window [io  0x8000-0x8fff]
[    0.665117] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.665156] pci_bus 0000:00: on NUMA node 0
[    0.665648] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.665727] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.665810] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.665892] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 11 14 15) *0
[    0.665959] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 10 11 14 15) *0
[    0.666012] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 10 11 14 15) *0
[    0.666065] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 10 11 14 15) *0
[    0.666123] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 10 11 14 15) *0
[    0.666303] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.666307] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.666315] vgaarb: loaded
[    0.666318] vgaarb: bridge control possible 0000:01:00.0
[    0.666383] SCSI subsystem initialized
[    0.666426] libata version 3.00 loaded.
[    0.666428] ACPI: bus type USB registered
[    0.666445] usbcore: registered new interface driver usbfs
[    0.666456] usbcore: registered new interface driver hub
[    0.666482] usbcore: registered new device driver usb
[    0.666577] PCI: Using ACPI for IRQ routing
[    0.666581] PCI: pci_cache_line_size set to 64 bytes
[    0.666725] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.666726] e820: reserve RAM buffer [mem 0xae475000-0xafffffff]
[    0.666727] e820: reserve RAM buffer [mem 0xaf156000-0xafffffff]
[    0.666728] e820: reserve RAM buffer [mem 0xaf800000-0xafffffff]
[    0.666809] NetLabel: Initializing
[    0.666812] NetLabel:  domain hash size = 128
[    0.666815] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.666827] NetLabel:  unlabeled traffic allowed by default
[    0.666862] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.666867] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.668935] clocksource: Switched to clocksource hpet
[    0.672035] VFS: Disk quotas dquot_6.6.0
[    0.672050] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.672110] pnp: PnP ACPI init
[    0.672222] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.672228] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.672578] system 00:01: [io  0x040b] has been reserved
[    0.672582] system 00:01: [io  0x04d6] has been reserved
[    0.672586] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.672589] system 00:01: [io  0x0c14] has been reserved
[    0.672593] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.672596] system 00:01: [io  0x0c52] has been reserved
[    0.672599] system 00:01: [io  0x0c6c] has been reserved
[    0.672603] system 00:01: [io  0x0c6f] has been reserved
[    0.672606] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.672609] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.672613] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.672616] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.672620] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.672623] system 00:01: [io  0x0800-0x089f] has been reserved
[    0.672627] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.672630] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.672634] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.672638] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.672642] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.672645] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.672649] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.672653] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.672657] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.672660] system 00:01: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.672664] system 00:01: [mem 0xffc00000-0xffffffff] has been reserved
[    0.672669] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.672854] system 00:02: [io  0x0220-0x0227] has been reserved
[    0.672858] system 00:02: [io  0x0228-0x0237] has been reserved
[    0.672861] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    0.672865] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.672911] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.673191] pnp 00:04: [dma 0 disabled]
[    0.673229] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.673255] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.673335] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.673340] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.673394] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.673561] system 00:08: [mem 0xfeb20000-0xfeb23fff] has been reserved
[    0.673566] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.673707] system 00:09: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.673712] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.673831] pnp: PnP ACPI: found 10 devices
[    0.680491] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.680598] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.680602] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.680606] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.680611] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.680618] pci 0000:04:06.0: PCI bridge to [bus 05]
[    0.680628] pci 0000:04:06.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.680636] pci 0000:04:06.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.680649] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.680653] pci 0000:03:04.0:   bridge window [io  0xd000-0xdfff]
[    0.680661] pci 0000:03:04.0:   bridge window [mem 0xd0000000-0xd85fffff]
[    0.680668] pci 0000:03:04.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.680678] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.680683] pci 0000:02:00.0:   bridge window [io  0xd000-0xdfff]
[    0.680689] pci 0000:02:00.0:   bridge window [mem 0xd0000000-0xd85fffff]
[    0.680695] pci 0000:02:00.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.680704] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.680708] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.680712] pci 0000:00:04.0:   bridge window [mem 0xd0000000-0xd85fffff]
[    0.680716] pci 0000:00:04.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.680722] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.680726] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.680731] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.680735] pci 0000:00:0a.0:   bridge window [io  0xc000-0xcfff]
[    0.680739] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.680745] pci 0000:0a:08.0: PCI bridge to [bus 0b]
[    0.680751] pci 0000:0a:08.0:   bridge window [io  0x6000-0x6fff]
[    0.680760] pci 0000:0a:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.680777] pci 0000:09:04.0: PCI bridge to [bus 0a-0b]
[    0.680781] pci 0000:09:04.0:   bridge window [io  0x6000-0x7fff]
[    0.680789] pci 0000:09:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.680796] pci 0000:09:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.680806] pci 0000:08:00.0: PCI bridge to [bus 09-0b]
[    0.680811] pci 0000:08:00.0:   bridge window [io  0x6000-0x7fff]
[    0.680817] pci 0000:08:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.680823] pci 0000:08:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.680832] pci 0000:00:0b.0: PCI bridge to [bus 08-0b]
[    0.680836] pci 0000:00:0b.0:   bridge window [io  0x6000-0x7fff]
[    0.680840] pci 0000:00:0b.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.680844] pci 0000:00:0b.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.680850] pci 0000:0c:00.0: PCI bridge to [bus 0d]
[    0.680855] pci 0000:0c:00.0:   bridge window [io  0xb000-0xbfff]
[    0.680863] pci 0000:0c:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.680877] pci 0000:00:0d.0: PCI bridge to [bus 0c-0d]
[    0.680880] pci 0000:00:0d.0:   bridge window [io  0xb000-0xbfff]
[    0.680885] pci 0000:00:0d.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.680890] pci 0000:00:14.4: PCI bridge to [bus 0e]
[    0.680894] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
[    0.680900] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.680908] pci 0000:00:15.0: PCI bridge to [bus 0f]
[    0.680912] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
[    0.680918] pci 0000:00:15.0:   bridge window [mem 0xc5000000-0xc50fffff 64bit pref]
[    0.680925] pci 0000:00:15.1: PCI bridge to [bus 10]
[    0.680930] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.680942] pci 0000:00:15.2: PCI bridge to [bus 11]
[    0.680946] pci 0000:00:15.2:   bridge window [io  0x8000-0x8fff]
[    0.680951] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.680959] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.680960] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.680961] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.680962] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.680963] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.680964] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.680965] pci_bus 0000:00: resource 10 [mem 0xb0000000-0xdfffffff window]
[    0.680966] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.680967] pci_bus 0000:01: resource 1 [mem 0xd9000000-0xdb0fffff]
[    0.680968] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.680969] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.680970] pci_bus 0000:02: resource 1 [mem 0xd0000000-0xd85fffff]
[    0.680971] pci_bus 0000:02: resource 2 [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.680972] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
[    0.680973] pci_bus 0000:03: resource 1 [mem 0xd0000000-0xd85fffff]
[    0.680974] pci_bus 0000:03: resource 2 [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.680975] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
[    0.680975] pci_bus 0000:04: resource 1 [mem 0xd0000000-0xd85fffff]
[    0.680976] pci_bus 0000:04: resource 2 [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.680977] pci_bus 0000:05: resource 1 [mem 0xd8400000-0xd84fffff]
[    0.680978] pci_bus 0000:05: resource 2 [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.680979] pci_bus 0000:06: resource 1 [mem 0xde100000-0xde1fffff]
[    0.680980] pci_bus 0000:07: resource 0 [io  0xc000-0xcfff]
[    0.680981] pci_bus 0000:07: resource 1 [mem 0xde000000-0xde0fffff]
[    0.680982] pci_bus 0000:08: resource 0 [io  0x6000-0x7fff]
[    0.680983] pci_bus 0000:08: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.680984] pci_bus 0000:08: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.680985] pci_bus 0000:09: resource 0 [io  0x6000-0x7fff]
[    0.680986] pci_bus 0000:09: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.680986] pci_bus 0000:09: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.680987] pci_bus 0000:0a: resource 0 [io  0x6000-0x7fff]
[    0.680988] pci_bus 0000:0a: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.680989] pci_bus 0000:0a: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.680990] pci_bus 0000:0b: resource 0 [io  0x6000-0x6fff]
[    0.680991] pci_bus 0000:0b: resource 1 [mem 0xdd800000-0xdd8fffff]
[    0.680992] pci_bus 0000:0c: resource 0 [io  0xb000-0xbfff]
[    0.680993] pci_bus 0000:0c: resource 1 [mem 0xddb00000-0xddcfffff]
[    0.680994] pci_bus 0000:0d: resource 0 [io  0xb000-0xbfff]
[    0.680995] pci_bus 0000:0d: resource 1 [mem 0xddb00000-0xddbfffff]
[    0.680996] pci_bus 0000:0e: resource 0 [io  0xa000-0xafff]
[    0.680997] pci_bus 0000:0e: resource 1 [mem 0xddf00000-0xddffffff]
[    0.680998] pci_bus 0000:0e: resource 4 [io  0x0000-0x03af window]
[    0.680998] pci_bus 0000:0e: resource 5 [io  0x03e0-0x0cf7 window]
[    0.680999] pci_bus 0000:0e: resource 6 [io  0x03b0-0x03df window]
[    0.681000] pci_bus 0000:0e: resource 7 [io  0x0d00-0xffff window]
[    0.681001] pci_bus 0000:0e: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.681002] pci_bus 0000:0e: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.681003] pci_bus 0000:0e: resource 10 [mem 0xb0000000-0xdfffffff window]
[    0.681004] pci_bus 0000:0f: resource 0 [io  0x9000-0x9fff]
[    0.681005] pci_bus 0000:0f: resource 2 [mem 0xc5000000-0xc50fffff 64bit pref]
[    0.681006] pci_bus 0000:10: resource 1 [mem 0xdde00000-0xddefffff]
[    0.681007] pci_bus 0000:11: resource 0 [io  0x8000-0x8fff]
[    0.681008] pci_bus 0000:11: resource 1 [mem 0xddd00000-0xdddfffff]
[    0.681025] NET: Registered protocol family 2
[    0.681164] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.681459] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.681636] TCP: Hash tables configured (established 131072 bind 65536)
[    0.681665] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.681715] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.681799] NET: Registered protocol family 1
[    0.988154] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.988162] pci 0000:02:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.988295] pci 0000:08:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.988445] PCI: CLS 64 bytes, default 64
[    0.988479] Unpacking initramfs...
[    1.647930] Freeing initrd memory: 7848K (ffff88003709c000 - ffff880037846000)
[    1.652563] DMA-API: preallocated 65536 debug entries
[    1.652569] DMA-API: debugging enabled by kernel config
[    1.725222] iommu: Adding device 0000:00:00.0 to group 0
[    1.725296] iommu: Adding device 0000:00:02.0 to group 1
[    1.725370] iommu: Adding device 0000:00:04.0 to group 2
[    1.725443] iommu: Adding device 0000:00:09.0 to group 3
[    1.725515] iommu: Adding device 0000:00:0a.0 to group 4
[    1.725587] iommu: Adding device 0000:00:0b.0 to group 5
[    1.725661] iommu: Adding device 0000:00:0d.0 to group 6
[    1.725735] iommu: Adding device 0000:00:11.0 to group 7
[    1.725827] iommu: Adding device 0000:00:12.0 to group 8
[    1.725847] iommu: Adding device 0000:00:12.2 to group 8
[    1.725958] iommu: Adding device 0000:00:13.0 to group 9
[    1.725979] iommu: Adding device 0000:00:13.2 to group 9
[    1.726061] iommu: Adding device 0000:00:14.0 to group 10
[    1.726138] iommu: Adding device 0000:00:14.1 to group 11
[    1.726213] iommu: Adding device 0000:00:14.2 to group 12
[    1.726288] iommu: Adding device 0000:00:14.3 to group 13
[    1.726364] iommu: Adding device 0000:00:14.4 to group 14
[    1.726441] iommu: Adding device 0000:00:14.5 to group 15
[    1.726546] iommu: Adding device 0000:00:15.0 to group 16
[    1.726569] iommu: Adding device 0000:00:15.1 to group 16
[    1.726594] iommu: Adding device 0000:00:15.2 to group 16
[    1.726688] iommu: Adding device 0000:00:16.0 to group 17
[    1.726710] iommu: Adding device 0000:00:16.2 to group 17
[    1.726790] iommu: Adding device 0000:01:00.0 to group 18
[    1.726869] iommu: Adding device 0000:02:00.0 to group 19
[    1.726879] iommu: Adding device 0000:03:04.0 to group 19
[    1.726889] iommu: Adding device 0000:04:04.0 to group 19
[    1.726899] iommu: Adding device 0000:04:05.0 to group 19
[    1.726909] iommu: Adding device 0000:04:06.0 to group 19
[    1.726918] iommu: Adding device 0000:04:07.0 to group 19
[    1.726928] iommu: Adding device 0000:04:09.0 to group 19
[    1.726938] iommu: Adding device 0000:04:0a.0 to group 19
[    1.726947] iommu: Adding device 0000:05:00.0 to group 19
[    1.727035] iommu: Adding device 0000:06:00.0 to group 20
[    1.727116] iommu: Adding device 0000:07:00.0 to group 21
[    1.727197] iommu: Adding device 0000:08:00.0 to group 22
[    1.727207] iommu: Adding device 0000:09:04.0 to group 22
[    1.727217] iommu: Adding device 0000:0a:04.0 to group 22
[    1.727226] iommu: Adding device 0000:0a:05.0 to group 22
[    1.727235] iommu: Adding device 0000:0a:06.0 to group 22
[    1.727245] iommu: Adding device 0000:0a:07.0 to group 22
[    1.727254] iommu: Adding device 0000:0a:08.0 to group 22
[    1.727265] iommu: Adding device 0000:0a:09.0 to group 22
[    1.727275] iommu: Adding device 0000:0a:0a.0 to group 22
[    1.727284] iommu: Adding device 0000:0b:00.0 to group 22
[    1.727368] iommu: Adding device 0000:0c:00.0 to group 23
[    1.727378] iommu: Adding device 0000:0d:04.0 to group 23
[    1.727388] iommu: Adding device 0000:0e:06.0 to group 14
[    1.727403] iommu: Adding device 0000:0f:00.0 to group 16
[    1.727415] iommu: Adding device 0000:10:00.0 to group 16
[    1.727428] iommu: Adding device 0000:11:00.0 to group 16
[    1.799673] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.799760] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.801269] perf: AMD NB counters detected
[    1.801448] LVT offset 0 assigned for vector 0x400
[    1.801533] perf: AMD IBS detected (0x000000ff)
[    1.802150] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    1.802409] Initialise system trusted keyrings
[    1.802516] workingset: timestamp_bits=46 max_order=22 bucket_order=0
[    1.803999] zbud: loaded
[    1.804741] Key type asymmetric registered
[    1.804771] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.804776] io scheduler noop registered
[    1.804778] io scheduler deadline registered
[    1.804786] io scheduler cfq registered (default)
[    1.805441] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.805448] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.805469] vesafb: mode is 1280x1024x16, linelength=2560, pages=0
[    1.805473] vesafb: scrolling: redraw
[    1.805476] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    1.805483] pmd_set_huge: Cannot satisfy [mem 0xb0000000-0xb0200000] with a huge-page mapping due to MTRR override.
[    1.805493] vesafb: framebuffer at 0xb0000000, mapped to 0xffffc90000400000, using 2560k, total 2560k
[    1.820997] Console: switching to colour frame buffer device 160x64
[    1.836495] fb0: VESA VGA frame buffer device
[    1.836598] GHES: HEST is not enabled!
[    1.836702] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.857308] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.858099] Non-volatile memory driver v1.3
[    1.858200] Linux agpgart interface v0.103
[    1.859365] ahci 0000:00:11.0: version 3.0
[    1.859481] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    1.859623] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    1.860314] scsi host0: ahci
[    1.860458] scsi host1: ahci
[    1.860595] scsi host2: ahci
[    1.860732] scsi host3: ahci
[    1.860817] ata1: SATA max UDMA/133 abar m1024@0xd860b000 port 0xd860b100 irq 19
[    1.860947] ata2: SATA max UDMA/133 abar m1024@0xd860b000 port 0xd860b180 irq 19
[    1.861081] ata3: SATA max UDMA/133 abar m1024@0xd860b000 port 0xd860b200 irq 19
[    1.861210] ata4: SATA max UDMA/133 abar m1024@0xd860b000 port 0xd860b280 irq 19
[    1.861450] ahci 0000:07:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.861591] ahci 0000:07:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.862026] scsi host4: ahci
[    1.862163] scsi host5: ahci
[    1.862251] ata5: SATA max UDMA/133 abar m512@0xde010000 port 0xde010100 irq 30
[    1.862379] ata6: SATA max UDMA/133 abar m512@0xde010000 port 0xde010180 irq 30
[    1.862612] ahci 0000:11:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.862753] ahci 0000:11:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.863203] scsi host6: ahci
[    1.863337] scsi host7: ahci
[    1.863424] ata7: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10100 irq 31
[    1.863552] ata8: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10180 irq 31
[    1.863690] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.863805] ehci-pci: EHCI PCI platform driver
[    1.863952] QUIRK: Enable AMD PLL fix
[    1.863969] ehci-pci 0000:00:12.2: EHCI Host Controller
[    1.864069] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    1.864199] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.864356] ehci-pci 0000:00:12.2: debug port 1
[    1.864469] ehci-pci 0000:00:12.2: irq 17, io mem 0xd8609000
[    1.871041] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.871179] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.871297] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.871422] usb usb1: Product: EHCI Host Controller
[    1.875886] usb usb1: Manufacturer: Linux 4.8.7-lcrs ehci_hcd
[    1.880368] usb usb1: SerialNumber: 0000:00:12.2
[    1.884935] hub 1-0:1.0: USB hub found
[    1.889384] hub 1-0:1.0: 5 ports detected
[    1.894006] ehci-pci 0000:00:13.2: EHCI Host Controller
[    1.898440] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    1.902898] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.907393] ehci-pci 0000:00:13.2: debug port 1
[    1.911841] ehci-pci 0000:00:13.2: irq 17, io mem 0xd8607000
[    1.923044] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.927452] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.931845] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.936258] usb usb2: Product: EHCI Host Controller
[    1.940687] usb usb2: Manufacturer: Linux 4.8.7-lcrs ehci_hcd
[    1.945156] usb usb2: SerialNumber: 0000:00:13.2
[    1.949686] hub 2-0:1.0: USB hub found
[    1.954081] hub 2-0:1.0: 5 ports detected
[    1.958621] ehci-pci 0000:00:16.2: EHCI Host Controller
[    1.962981] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 3
[    1.967385] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.971815] ehci-pci 0000:00:16.2: debug port 1
[    1.976178] ehci-pci 0000:00:16.2: irq 17, io mem 0xd8604000
[    1.987048] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    1.991291] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.995524] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.999747] usb usb3: Product: EHCI Host Controller
[    2.003996] usb usb3: Manufacturer: Linux 4.8.7-lcrs ehci_hcd
[    2.008216] usb usb3: SerialNumber: 0000:00:16.2
[    2.012480] hub 3-0:1.0: USB hub found
[    2.016594] hub 3-0:1.0: 4 ports detected
[    2.020806] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.024924] uhci_hcd: USB Universal Host Controller Interface driver
[    2.029069] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    2.033175] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    2.037575] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.041997] mousedev: PS/2 mouse device common for all mice
[    2.046495] rtc_cmos 00:05: RTC can wake from S4
[    2.050957] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    2.055411] rtc_cmos 00:05: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.060056] ledtrig-cpu: registered to indicate activity on CPUs
[    2.064677] hidraw: raw HID events driver (C) Jiri Kosina
[    2.069336] usbcore: registered new interface driver usbhid
[    2.073890] usbhid: USB HID core driver
[    2.075892] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    2.083268] NET: Registered protocol family 10
[    2.088146] Key type dns_resolver registered
[    2.093149] microcode: microcode updated early to new patch_level=0x0600063d
[    2.097914] microcode: CPU0: patch_level=0x0600063d
[    2.102619] microcode: CPU1: patch_level=0x0600063d
[    2.107241] microcode: CPU2: patch_level=0x0600063d
[    2.111860] microcode: CPU3: patch_level=0x0600063d
[    2.116398] microcode: CPU4: patch_level=0x0600063d
[    2.120931] microcode: CPU5: patch_level=0x0600063d
[    2.125371] microcode: CPU6: patch_level=0x0600063d
[    2.129746] microcode: CPU7: patch_level=0x0600063d
[    2.134105] microcode: Microcode Update Driver: v2.01 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    2.138674] registered taskstats version 1
[    2.143065] Loading compiled-in X.509 certificates
[    2.147454] zswap: loaded using pool lzo/zbud
[    2.152599]   Magic number: 8:446:736
[    2.157076] rtc_cmos 00:05: setting system clock to 2016-11-18 13:44:57 UTC (1479476697)
[    2.177851] ata6: SATA link down (SStatus 0 SControl 300)
[    2.182390] ata5: SATA link down (SStatus 0 SControl 300)
[    2.321080] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.325532] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.345080] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.349436] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.350199] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.358022] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.358392] ata8.00: ATA-6: ST3500320NS, SN04, max UDMA/133
[    2.358393] ata8.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.359991] ata8.00: configured for UDMA/133
[    2.374744] ata2.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    2.378958] ata2.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.383203] ata1.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[    2.387432] ata7.00: ATA-8: ST3500320NS, SN06, max UDMA/133
[    2.387433] ata7.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.395814] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.427015] ata4.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    2.429872] ata7.00: configured for UDMA/133
[    2.435396] ata4.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.439655] ata3.00: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
[    2.443908] ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.448182] ata1.00: configured for UDMA/133
[    2.452413] ata2.00: configured for UDMA/133
[    2.462584] scsi 0:0:0:0: Direct-Access     ATA      ST3160815AS      B    PQ: 0 ANSI: 5
[    2.474220] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.478602] scsi 1:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.482961] sd 0:0:0:0: [sda] Write Protect is off
[    2.485326] ata4.00: configured for UDMA/133
[    2.491517] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.491528] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.495948] ata3.00: configured for UDMA/133
[    2.504204] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.508753] sd 1:0:0:0: [sdb] Write Protect is off
[    2.510536] scsi 2:0:0:0: Direct-Access     ATA      ST3160811AS      E    PQ: 0 ANSI: 5
[    2.517770] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.517782] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.530232] sd 2:0:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.534876] scsi 3:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.539428] sd 2:0:0:0: [sdc] Write Protect is off
[    2.543909] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.543919] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.556225] sd 3:0:0:0: [sdd] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.560899] sd 3:0:0:0: [sdd] Write Protect is off
[    2.560999] scsi 6:0:0:0: Direct-Access     ATA      ST3500320NS      SN06 PQ: 0 ANSI: 5
[    2.570024] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.570037] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.582238] sd 6:0:0:0: [sde] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    2.582871]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
[    2.583270] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.591597] scsi 7:0:0:0: Direct-Access     ATA      ST3500320NS      SN04 PQ: 0 ANSI: 5
[    2.600671] sd 6:0:0:0: [sde] Write Protect is off
[    2.604845]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 >
[    2.605265] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.614232] sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    2.614244] sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.626206] sd 7:0:0:0: [sdf] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    2.627318]  sde: sde1
[    2.627473] sd 6:0:0:0: [sde] Attached SCSI removable disk
[    2.640524] sd 7:0:0:0: [sdf] Write Protect is off
[    2.645099]  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 >
[    2.645491] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.653098]  sdd: sdd1 sdd2 sdd3 < sdd5 sdd6 sdd7 >
[    2.653466] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.665068] sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    2.665086] sd 7:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.671462]  sdf: sdf1
[    2.676534] sd 7:0:0:0: [sdf] Attached SCSI removable disk
[    2.682287] Freeing unused kernel memory: 1040K (ffffffff80eed000 - ffffffff80ff1000)
[    2.687311] Write protecting the kernel read-only data: 12288k
[    2.692798] Freeing unused kernel memory: 1580K (ffff880000875000 - ffff880000a00000)
[    2.700218] Freeing unused kernel memory: 1196K (ffff880000cd5000 - ffff880000e00000)
[    2.706752] random: systemd: uninitialized urandom read (16 bytes read)
[    2.720429] systemd[1]: systemd 210 running in system mode. (+PAM -LIBWRAP +AUDIT +SELINUX -IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ +SECCOMP +APPARMOR)
[    2.726120] systemd[1]: Detected architecture 'x86-64'.
[    2.731619] systemd[1]: Running in initial RAM disk.
[    2.754770] systemd[1]: Inserted module 'autofs4'
[    2.760503] systemd[1]: Set hostname to <harley>.
[    2.797449] random: systemd: uninitialized urandom read (16 bytes read)
[    2.803154] random: systemd: uninitialized urandom read (16 bytes read)
[    2.809285] random: systemd: uninitialized urandom read (16 bytes read)
[    2.816687] random: systemd: uninitialized urandom read (16 bytes read)
[    2.822244] random: systemd: uninitialized urandom read (16 bytes read)
[    2.827913] random: systemd: uninitialized urandom read (16 bytes read)
[    2.833311] random: systemd: uninitialized urandom read (16 bytes read)
[    2.838655] random: systemd: uninitialized urandom read (16 bytes read)
[    2.843928] tsc: Refined TSC clocksource calibration: 3616.535 MHz
[    2.843939] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x34215790458, max_idle_ns: 440795259836 ns
[    2.854799] random: systemd: uninitialized urandom read (16 bytes read)
[    2.860374] systemd[1]: Expecting device dev-disk-by\x2did-ata\x2dST3160815AS_6RACD7A6\x2dpart5.device...
[    2.871654] systemd[1]: Starting Timers.
[    2.882802] systemd[1]: Reached target Timers.
[    2.888335] systemd[1]: Starting -.slice.
[    2.908602] systemd[1]: Created slice -.slice.
[    2.961259] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.961309] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.961354] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    2.961400] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    2.961448] sd 6:0:0:0: Attached scsi generic sg4 type 0
[    2.961493] sd 7:0:0:0: Attached scsi generic sg5 type 0
[    3.145650] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    3.149933] ACPI: Power Button [PWRB]
[    3.154448] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    3.154534] ACPI: Power Button [PWRF]
[    3.154601] wmi: Mapper loaded
[    3.170957] ohci-pci: OHCI PCI platform driver
[    3.175354] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    3.175362] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[    3.175409] ohci-pci 0000:00:12.0: irq 18, io mem 0xd860a000
[    3.200536] random: crng init done
[    3.231222] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.231224] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.231225] usb usb4: Product: OHCI PCI host controller
[    3.231225] usb usb4: Manufacturer: Linux 4.8.7-lcrs ohci_hcd
[    3.231226] usb usb4: SerialNumber: 0000:00:12.0
[    3.231368] hub 4-0:1.0: USB hub found
[    3.231379] hub 4-0:1.0: 5 ports detected
[    3.231633] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    3.231636] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
[    3.231661] ohci-pci 0000:00:13.0: irq 18, io mem 0xd8608000
[    3.287242] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.287363] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.287489] usb usb5: Product: OHCI PCI host controller
[    3.287580] usb usb5: Manufacturer: Linux 4.8.7-lcrs ohci_hcd
[    3.287679] usb usb5: SerialNumber: 0000:00:13.0
[    3.287868] hub 5-0:1.0: USB hub found
[    3.287940] hub 5-0:1.0: 5 ports detected
[    3.288252] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    3.288352] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
[    3.288508] ohci-pci 0000:00:14.5: irq 18, io mem 0xd8606000
[    3.344296] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    3.344418] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.344543] usb usb6: Product: OHCI PCI host controller
[    3.344664] usb usb6: Manufacturer: Linux 4.8.7-lcrs ohci_hcd
[    3.344763] usb usb6: SerialNumber: 0000:00:14.5
[    3.344962] hub 6-0:1.0: USB hub found
[    3.345032] hub 6-0:1.0: 2 ports detected
[    3.345371] ohci-pci 0000:00:16.0: OHCI PCI host controller
[    3.345502] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
[    3.345654] ohci-pci 0000:00:16.0: irq 18, io mem 0xd8605000
[    3.401224] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    3.401344] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.401470] usb usb7: Product: OHCI PCI host controller
[    3.401559] usb usb7: Manufacturer: Linux 4.8.7-lcrs ohci_hcd
[    3.401658] usb usb7: SerialNumber: 0000:00:16.0
[    3.401904] hub 7-0:1.0: USB hub found
[    3.401975] hub 7-0:1.0: 4 ports detected
[    3.403668] scsi host10: pata_atiixp
[    3.403838] scsi host11: pata_atiixp
[    3.403946] ata9: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
[    3.404067] ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
[    3.567166] usb 4-3: new full-speed USB device number 2 using ohci-pci
[    3.574835] ata9.00: ATAPI: SONY    DVD RW AD-7260S, 1.61, max UDMA/100
[    3.575157] ata9.01: ATA-8: ST3500418AS, CC38, max UDMA/133
[    3.575255] ata9.01: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    3.575373] ata9.00: limited to UDMA/33 due to 40-wire cable
[    3.575687] ata9.01: limited to UDMA/33 due to 40-wire cable
[    3.580432] ata9.00: configured for UDMA/33
[    3.585420] ata9.01: configured for UDMA/33
[    3.587547] scsi 10:0:0:0: CD-ROM            SONY     DVD RW AD-7260S  1.61 PQ: 0 ANSI: 5
[    3.600017] scsi 10:0:0:0: Attached scsi generic sg6 type 5
[    3.600249] scsi 10:0:1:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5
[    3.638340] sd 10:0:1:0: [sdg] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    3.638508] sd 10:0:1:0: [sdg] Write Protect is off
[    3.638592] sd 10:0:1:0: [sdg] Mode Sense: 00 3a 00 00
[    3.638607] sd 10:0:1:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.638824] sd 10:0:1:0: Attached scsi generic sg7 type 0
[    3.646641]  sdg: sdg1
[    3.646868] sd 10:0:1:0: [sdg] Attached SCSI disk
[    3.661851] sr 10:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    3.662005] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.662295] sr 10:0:0:0: Attached scsi CD-ROM sr0
[    3.742218] usb 4-3: New USB device found, idVendor=12cf, idProduct=0155
[    3.746741] usb 4-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.751261] usb 4-3: Product: CM STORM SENTINEL GAMING MOUSE
[    3.755803] usb 4-3: Manufacturer: DEXIN Corporation
[    3.765503] input: DEXIN Corporation CM STORM SENTINEL GAMING MOUSE as /devices/pci0000:00/0000:00:12.0/usb4/4-3/4-3:1.0/0003:12CF:0155.0001/input/input3
[    3.770645] hid-generic 0003:12CF:0155.0001: input,hidraw0: USB HID v1.11 Mouse [DEXIN Corporation CM STORM SENTINEL GAMING MOUSE] on usb-0000:00:12.0-3/input0
[    3.786348] input: DEXIN Corporation CM STORM SENTINEL GAMING MOUSE as /devices/pci0000:00/0000:00:12.0/usb4/4-3/4-3:1.1/0003:12CF:0155.0002/input/input4
[    3.843280] hid-generic 0003:12CF:0155.0002: input,hidraw1: USB HID v1.11 Keyboard [DEXIN Corporation CM STORM SENTINEL GAMING MOUSE] on usb-0000:00:12.0-3/input1
[    3.854008] clocksource: Switched to clocksource tsc
[    8.793553] scsi host9: Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec 29320LPE PCIe Ultra320 SCSI adapter>
        aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133MHz, 512 SCBs
[    8.819447] scsi 9:0:0:0: Direct-Access     SEAGATE  ST15150N         5055 PQ: 0 ANSI: 2
[    8.825045] scsi target9:0:0: asynchronous
[    8.830589] scsi9:A:0:0: Tagged Queuing enabled.  Depth 32
[    8.836179] scsi target9:0:0: Beginning Domain Validation
[    8.861744] scsi target9:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[    8.881582] scsi target9:0:0: Domain Validation skipping write tests
[    8.887259] scsi target9:0:0: Ending Domain Validation
[    8.893210] sd 9:0:0:0: Attached scsi generic sg8 type 0
[    8.908455] sd 9:0:0:0: [sdh] Unsupported sector size 768.
[    8.914045] sd 9:0:0:0: [sdh] 0 512-byte logical blocks: (0 B/0 B)
[    8.919633] sd 9:0:0:0: [sdh] 768-byte physical blocks
[    8.926551] scsi 9:0:1:0: Direct-Access     IMPRIMIS 94601-15         4614 PQ: 0 ANSI: 1 CCS
[    8.931361] sd 9:0:0:0: [sdh] Write Protect is off
[    8.931363] sd 9:0:0:0: [sdh] Mode Sense: ab 00 10 08
[    8.937788] scsi target9:0:1: asynchronous
[    8.938460] sd 9:0:0:0: [sdh] Write cache: disabled, read cache: enabled, supports DPO and FUA
[    8.947444] sd 9:0:0:0: [sdh] Unsupported sector size 768.
[    8.955183] scsi target9:0:1: Beginning Domain Validation
[    8.963732] scsi target9:0:1: Ending Domain Validation
[    8.964268] sd 9:0:0:0: [sdh] Attached SCSI disk
[    8.975381] sd 9:0:1:0: Attached scsi generic sg9 type 0
[    8.977578] sd 9:0:1:0: [sdi] Unsupported sector size 256.
[    8.977580] sd 9:0:1:0: [sdi] 0 512-byte logical blocks: (0 B/0 B)
[    8.977581] sd 9:0:1:0: [sdi] 256-byte physical blocks
[    8.978405] sd 9:0:1:0: [sdi] Write Protect is off
[    8.978406] sd 9:0:1:0: [sdi] Mode Sense: 5b 00 00 08
[    8.979821] sd 9:0:1:0: [sdi] Incomplete mode parameter data
[    8.979822] sd 9:0:1:0: [sdi] Assuming drive cache: write through
[    8.983542] sd 9:0:1:0: [sdi] Unsupported sector size 256.
[    8.986898] sd 9:0:1:0: [sdi] Attached SCSI disk
[    9.286764] scsi 9:0:3:0: Sequential-Access SONY     SDT-10000        0110 PQ: 0 ANSI: 2
[    9.292463] scsi target9:0:3: asynchronous
[    9.298064] scsi target9:0:3: Beginning Domain Validation
[    9.311991] scsi target9:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
[    9.322794] scsi target9:0:3: Domain Validation skipping write tests
[    9.328378] scsi target9:0:3: Ending Domain Validation
[    9.334109] scsi 9:0:3:0: Attached scsi generic sg10 type 1
[   18.522268] scsi host8: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2930CU SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

[   20.765144] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
[   21.031272] systemd-journald[234]: Received SIGTERM from PID 1 (systemd).
[   21.285499] systemd: 28 output lines suppressed due to ratelimiting
[   23.412696] device-mapper: uevent: version 1.0.3
[   23.417593] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[   25.386096] EXT4-fs (sda5): re-mounted. Opts: acl,user_xattr
[   26.306765] Warning: Processor Platform Limit event detected, but not handled.
[   26.310423] Consider compiling CPUfreq support into your kernel.
[   26.420004] FUJITSU Extended Socket Network Device Driver - version 1.1 - Copyright (c) 2015 FUJITSU LIMITED
[   26.866034] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   27.081882] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   27.085736] piix4_smbus 0000:00:14.0: Using register 0x2c for SMBus port selection
[   27.089856] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[   27.394485] hdlc: HDLC support module revision 1.22
[   27.562919] input: PC Speaker as /devices/platform/pcspkr/input/input5
[   27.651136] 3c59x: Donald Becker and others.
[   27.655049] 0000:04:04.0: 3Com PCI 3c905C Tornado at ffffc90000044000.
[   27.781987] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   27.786339] st 9:0:3:0: Attached scsi tape st0
[   27.790554] st 9:0:3:0: st0: try direct i/o: yes (alignment 4 B)
[   27.836946] HDLC line discipline maxframe=65535
[   27.840909] N_HDLC line discipline registered.
[   27.908235] dgap: module is from the staging directory, the quality is unknown, you have been warned.
[   27.912529] dgap: dgap-1.3-16, Digi International Part Number 40002347_C
[   27.916713] dgap: For the tools package please visit http://www.digi.com
[   27.920911] dgap: dgap: board 0: AccelePort Xr920 8 port (rev 1), irq 35
[   28.193987] SyncLink GT
[   28.198072] SyncLink GT, tty major#247
[   28.328493] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   28.332549] r8169 0000:0f:00.0: can't disable ASPM; OS doesn't have ASPM control
[   28.337354] r8169 0000:0f:00.0 eth1: RTL8168evl/8111evl at 0xffffc9000004a000, 74:d4:35:1f:b2:9e, XID 0c900800 IRQ 36
[   28.341707] r8169 0000:0f:00.0 eth1: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   28.363648] osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.1.1.1 2016/10/04 17:52:20 markh Exp $
[   28.388592] gpiohsd: loading out-of-tree module taints kernel.
[   28.388595] gpiohsd: loading out-of-tree module taints kernel.
[   28.398130] gpiohsd: board 0 PCI BUS 5 SLOT 0 PCI HSD 471 Revision A
[   28.458503] 3c59x 0000:04:04.0 rename2: renamed from eth0
[   28.991244] r8169 0000:0f:00.0 eth0: renamed from eth1
[   29.030985] 3c59x 0000:04:04.0 eth1: renamed from rename2
[   29.276412] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   29.281386] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 8
[   29.286827] xhci_hcd 0000:06:00.0: hcc params 0x040050af hci version 0x100 quirks 0x00080490
[   29.292067] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[   29.297441] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   29.302723] usb usb8: Product: xHCI Host Controller
[   29.307946] usb usb8: Manufacturer: Linux 4.8.7-lcrs xhci-hcd
[   29.313199] usb usb8: SerialNumber: 0000:06:00.0
[   29.313341] gpiohsd: board 1 PCI BUS a SLOT 4 PCI HSD 462 Revision U
[   29.323740] hub 8-0:1.0: USB hub found
[   29.328884] hub 8-0:1.0: 2 ports detected
[   29.334058] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   29.334061] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 9
[   29.334076] usb usb9: We don't know the algorithms for LPM for this host, disabling LPM.
[   29.334096] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[   29.334097] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   29.334098] usb usb9: Product: xHCI Host Controller
[   29.334098] usb usb9: Manufacturer: Linux 4.8.7-lcrs xhci-hcd
[   29.334099] usb usb9: SerialNumber: 0000:06:00.0
[   29.334218] hub 9-0:1.0: USB hub found
[   29.334226] hub 9-0:1.0: 2 ports detected
[   29.334395] xhci_hcd 0000:10:00.0: xHCI Host Controller
[   29.334399] xhci_hcd 0000:10:00.0: new USB bus registered, assigned bus number 10
[   29.334654] xhci_hcd 0000:10:00.0: hcc params 0x040050af hci version 0x100 quirks 0x00080490
[   29.334796] usb usb10: New USB device found, idVendor=1d6b, idProduct=0002
[   29.334797] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   29.334798] usb usb10: Product: xHCI Host Controller
[   29.334799] usb usb10: Manufacturer: Linux 4.8.7-lcrs xhci-hcd
[   29.334799] usb usb10: SerialNumber: 0000:10:00.0
[   29.334885] hub 10-0:1.0: USB hub found
[   29.334894] hub 10-0:1.0: 2 ports detected
[   29.334985] xhci_hcd 0000:10:00.0: xHCI Host Controller
[   29.334987] xhci_hcd 0000:10:00.0: new USB bus registered, assigned bus number 11
[   29.335003] usb usb11: We don't know the algorithms for LPM for this host, disabling LPM.
[   29.335022] usb usb11: New USB device found, idVendor=1d6b, idProduct=0003
[   29.335023] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   29.335023] usb usb11: Product: xHCI Host Controller
[   29.335024] usb usb11: Manufacturer: Linux 4.8.7-lcrs xhci-hcd
[   29.335025] usb usb11: SerialNumber: 0000:10:00.0
[   29.335149] hub 11-0:1.0: USB hub found
[   29.335158] hub 11-0:1.0: 2 ports detected
[   29.623434] gpiohsd: brd 1: PCI HSD FLASH Mar 18 2015 18:01:29
[   29.623563] gpiohsd: board 2 PCI BUS a SLOT 5 PCI HSD 462 Revision U
[   29.708449] EXT4-fs (sdf1): mounted filesystem with ordered data mode. Opts: (null)
[   29.839968] EXT4-fs (sdg1): mounting ext3 file system using the ext4 subsystem
[   29.861010] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC889: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   29.866191] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   29.867358] EXT4-fs (sdg1): mounted filesystem with ordered data mode. Opts: (null)
[   29.876581] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   29.881760] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   29.886913] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[   29.892015] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   29.897155] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   29.902678] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   29.907650] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   29.931879] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[   29.932224] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[   29.932400] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[   29.932500] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[   29.932621] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[   29.933338] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[   29.933644] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input12
[   29.934071] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input13
[   29.957318] gpiohsd: brd 2: PCI HSD FLASH Mar 18 2015 18:01:29
[   29.957424] gpiohsd: board 3 PCI BUS a SLOT 6 PCI HSD 462 Revision U
[   30.013185] EXT4-fs (sde1): mounting ext3 file system using the ext4 subsystem
[   30.060858] EXT4-fs (sde1): mounted filesystem with ordered data mode. Opts: (null)
[   30.256074] gpiohsd: brd 3: PCI HSD FLASH Mar 18 2015 18:01:29
[   30.256184] gpiohsd: board 4 PCI BUS a SLOT 7 PCI HSD 462 Revision U
[   30.578484] gpiohsd: brd 4: PCI HSD FLASH Mar 18 2015 18:01:29
[   30.650193] AVX version of gcm_enc/dec engaged.
[   30.655428] AES CTR mode by8 optimization enabled
[   30.788607] EXT4-fs (sdb5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   30.840077] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   30.967839] EXT4-fs (sdc5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   31.238662] EXT4-fs (sdb6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   31.276868] EXT4-fs (sdd5): mounting ext3 file system using the ext4 subsystem
[   31.288185] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   31.319672] EXT4-fs (sdd5): mounted filesystem with ordered data mode. Opts: (null)
[   31.330101] EXT4-fs (sdb7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   31.418265] Adding 8385532k swap on /dev/sda2.  Priority:-1 extents:1 across:8385532k FS
[   31.422041] EXT4-fs (sdc7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   31.487026] EXT4-fs (sdc6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   31.508166] EXT4-fs (sdd7): mounting ext3 file system using the ext4 subsystem
[   31.538798] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   31.555464] EXT4-fs (sda6): mounted filesystem with ordered data mode. Opts: (null)
[   31.608612] EXT4-fs (sdd7): mounted filesystem with ordered data mode. Opts: (null)
[   31.619604] EXT4-fs (sdd6): mounting ext3 file system using the ext4 subsystem
[   31.661413] EXT4-fs (sdd6): mounted filesystem with ordered data mode. Opts: (null)
[   31.673827] EXT4-fs (sdd1): mounting ext3 file system using the ext4 subsystem
[   31.707287] EXT4-fs (sdd1): mounted filesystem with ordered data mode. Opts: (null)
[   32.063581] kvm: disabled by bios
[   32.085712] kvm: disabled by bios
[   32.103694] kvm: disabled by bios
[   32.121793] kvm: disabled by bios
[   32.135716] kvm: disabled by bios
[   32.149699] kvm: disabled by bios
[   32.162702] kvm: disabled by bios
[   32.177752] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: (null)
[   32.183636] kvm: disabled by bios
[   32.340205] SyncLink GT4 ttySLG0 IO=d8541000 IRQ=29 MaxFrameSize=65535
[   32.345614] SyncLink GT4 ttySLG1 IO=d8541000 IRQ=29 MaxFrameSize=65535
[   32.350876] SyncLink GT4 ttySLG2 IO=d8541000 IRQ=29 MaxFrameSize=65535
[   32.356014] SyncLink GT4 ttySLG3 IO=d8541000 IRQ=29 MaxFrameSize=65535
[   33.315241] systemd-journald[524]: Received request to flush runtime journal from PID 1
[   34.322436] systemd[1]: Unit apparmor.service entered failed state.
[   37.764700] systemd[1]: Received SIGRTMIN+21 from PID 341 (plymouthd).
[   40.882286] No iBFT detected.
[   41.216228] eth1:  setting full-duplex.
[   41.376136] r8169 0000:0f:00.0 eth0: link down
[   41.376139] r8169 0000:0f:00.0 eth0: link down
[   41.384645] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   43.688240] r8169 0000:0f:00.0 eth0: link up
[   43.691988] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   44.008447] NET: Registered protocol family 17
[   45.029905] ------------[ cut here ]------------
[   45.033715] WARNING: CPU: 0 PID: 0 at lib/dma-debug.c:1158 check_unmap+0x4ef/0x990
[   45.037651] 3c59x 0000:04:04.0: DMA-API: device driver failed to check map error[device address=0x00000000ffedf840] [size=1536 bytes] [mapped as single]
[   45.037889] Modules linked in:
[   45.041925]  af_packet iscsi_ibft iscsi_boot_sysfs kvm irqbypass crc32_pclmul crc32c_intel aesni_intel aes_x86_64 snd_hda_codec_realtek glue_helper lrw snd_hda_codec_generic gf128mul xhci_pci snd_hda_intel snd_hda_codec ablk_helper snd_hda_core snd_hwdep snd_pcm xhci_hcd rfm2g(O) snd_timer cryptd joydev snd gpiohsd(O) osst input_leds r8169 synclink_gt tpm_infineon dgap(C) n_hdlc st 3c59x soundcore serio_raw pcspkr tpm_tis hdlc mii tpm_tis_core i2c_piix4 k10temp fam15h_power tpm shpchp fjes processor dm_mod sr_mod cdrom ata_generic mxm_wmi pata_atiixp aic79xx ohci_pci aic7xxx scsi_transport_spi wmi button sg autofs4
[   45.065652] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C O    4.8.7-lcrs #1
[   45.070660] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
[   45.075745]  0000000000000000 ffff88044fc03c00 ffffffff80510274 ffff88044fc03c50
[   45.080935]  0000000000000000 ffff88044fc03c40 ffffffff80259c0c 000004863dbc0218
[   45.086160]  ffff88043d3b0540 ffff88043d1f7360 ffffffff810f3e10 0000000000000006
[   45.091439] Call Trace:
[   45.096720]  <IRQ>  [<ffffffff80510274>] dump_stack+0x4d/0x69
[   45.102134]  [<ffffffff80259c0c>] __warn+0xcc/0xf0
[   45.107533]  [<ffffffff80259c7a>] warn_slowpath_fmt+0x4a/0x50
[   45.112945]  [<ffffffff8053eeef>] check_unmap+0x4ef/0x990
[   45.118348]  [<ffffffff8053f3fd>] debug_dma_unmap_page+0x6d/0x80
[   45.123760]  [<ffffffffa011dc0d>] boomerang_rx+0x35d/0x6b0 [3c59x]
[   45.129211]  [<ffffffffa011e152>] boomerang_interrupt+0x152/0x620 [3c59x]
[   45.134686]  [<ffffffff80518d89>] ? timerqueue_add+0x59/0xb0
[   45.140190]  [<ffffffff802a7f97>] __handle_irq_event_percpu+0x37/0x1c0
[   45.145689]  [<ffffffff802a813e>] handle_irq_event_percpu+0x1e/0x50
[   45.151157]  [<ffffffff802a81a4>] handle_irq_event+0x34/0x60
[   45.156618]  [<ffffffff802ab1ca>] handle_fasteoi_irq+0x8a/0x150
[   45.162061]  [<ffffffff8021cfe8>] handle_irq+0x18/0x30
[   45.167484]  [<ffffffff8021c838>] do_IRQ+0x48/0xd0
[   45.172880]  [<ffffffff8086c87f>] common_interrupt+0x7f/0x7f
[   45.178288]  <EOI>  [<ffffffff80223eb6>] ? default_idle+0x16/0x100
[   45.183738]  [<ffffffff802246ea>] arch_cpu_idle+0xa/0x10
[   45.189191]  [<ffffffff80292ab7>] default_idle_call+0x27/0x30
[   45.194651]  [<ffffffff80292db5>] cpu_startup_entry+0x2f5/0x380
[   45.200106]  [<ffffffff80865eea>] rest_init+0x7a/0x80
[   45.205546]  [<ffffffff80f0709c>] start_kernel+0x48d/0x49a
[   45.210911]  [<ffffffff80f069fd>] ? set_init_arg+0x55/0x55
[   45.216200]  [<ffffffff80f0659a>] x86_64_start_reservations+0x38/0x3a
[   45.221507]  [<ffffffff80f06686>] x86_64_start_kernel+0xea/0xed
[   45.226729] ---[ end trace 666af9a0a95e4827 ]---
[   45.231901] Mapped at:
[   45.237058]  [<ffffffff8053de46>] debug_dma_map_page+0x86/0x140
[   45.242304]  [<ffffffffa011ce97>] vortex_open+0x107/0x320 [3c59x]
[   45.247556]  [<ffffffff80778e3c>] __dev_open+0xac/0x120
[   45.252789]  [<ffffffff80779118>] __dev_change_flags+0x98/0x160
[   45.258015]  [<ffffffff80779204>] dev_change_flags+0x24/0x60
[  221.598354] ------------[ cut here ]------------
[  221.603749] kernel BUG at drivers/iommu/amd_iommu.c:1436!
[  221.609220] invalid opcode: 0000 [#1] PREEMPT SMP
[  221.614744] Modules linked in: af_packet iscsi_ibft iscsi_boot_sysfs kvm irqbypass crc32_pclmul crc32c_intel aesni_intel aes_x86_64 snd_hda_codec_realtek glue_helper lrw snd_hda_codec_generic gf128mul xhci_pci snd_hda_intel snd_hda_codec ablk_helper snd_hda_core snd_hwdep snd_pcm xhci_hcd rfm2g(O) snd_timer cryptd joydev snd gpiohsd(O) osst input_leds r8169 synclink_gt tpm_infineon dgap(C) n_hdlc st 3c59x soundcore serio_raw pcspkr tpm_tis hdlc mii tpm_tis_core i2c_piix4 k10temp fam15h_power tpm shpchp fjes processor dm_mod sr_mod cdrom ata_generic mxm_wmi pata_atiixp aic79xx ohci_pci aic7xxx scsi_transport_spi wmi button sg autofs4
[  221.645000] CPU: 3 PID: 1993 Comm: trusim1a Tainted: G        WC O    4.8.7-lcrs #1
[  221.651291] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
[  221.657767] task: ffff88042bdc5400 task.stack: ffff88043b988000
[  221.664238] RIP: 0010:[<ffffffff80622043>]  [<ffffffff80622043>] iommu_unmap_page+0xd3/0xe0
[  221.670798] RSP: 0018:ffff88043b98bb60  EFLAGS: 00010286
[  221.677325] RAX: ffff88043b98bbff RBX: 0000000000001000 RCX: 0000000000000027
[  221.683883] RDX: 000077fbc4674400 RSI: ffff88043a5520a0 RDI: 0000000000000000
[  221.690439] RBP: ffff88043b98bb90 R08: 0000000000000000 R09: 0000000000000000
[  221.696949] R10: ffffffffffec5000 R11: 0000000000001000 R12: ffff88043a5520a0
[  221.703305] R13: ffff88043a552000 R14: ffff88043b98bc00 R15: fffffffffffcfc00
[  221.709531] FS:  00007f2181c7a700(0000) GS:ffff88044fcc0000(0000) knlGS:0000000000000000
[  221.715679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  221.721656] CR2: 00007f218112d490 CR3: 0000000439382000 CR4: 00000000000406e0
[  221.727517] Stack:
[  221.733159]  ffff88043b98bc00 0000000000000001 ffffffffffec6000 0000000000000001
[  221.738813]  ffff88043a552000 ffffffffffec5000 ffff88043b98bbd0 ffffffff806236e8
[  221.744399]  ffff88043d2480a0 0000000000001000 ffff88043d2480a0 ffffffffffec5000
[  221.749894] Call Trace:
[  221.755354]  [<ffffffff806236e8>] __unmap_single.isra.23+0x58/0x1b0
[  221.760905]  [<ffffffff80623eb6>] free_coherent+0x76/0xc0
[  221.766399]  [<ffffffffa0227e76>] ehsd_set_signal+0x3b6/0x640 [gpiohsd]
[  221.771899]  [<ffffffff8027c563>] ? finish_task_switch+0x73/0x1e0
[  221.777375]  [<ffffffffa022c729>] ehsd_ioctl+0xde9/0x182b [gpiohsd]
[  221.782870]  [<ffffffff8024ef40>] ? pat_enabled+0x20/0x20
[  221.788354]  [<ffffffff802607c0>] ? walk_system_ram_range+0x70/0xc0
[  221.793856]  [<ffffffff80374068>] ? unmap_page_range+0x698/0x8a0
[  221.799349]  [<ffffffff80525159>] ? find_next_bit+0x19/0x20
[  221.804836]  [<ffffffff805100dc>] ? cpumask_any_but+0x2c/0x40
[  221.810306]  [<ffffffff80251bac>] ? flush_tlb_mm_range+0x4c/0x1a0
[  221.815767]  [<ffffffff80372a17>] ? tlb_finish_mmu+0x17/0x50
[  221.821211]  [<ffffffff8037a480>] ? unmap_region+0xe0/0x110
[  221.826667]  [<ffffffff805166d8>] ? __rb_erase_color+0x138/0x280
[  221.832145]  [<ffffffff803d08ef>] do_vfs_ioctl+0x8f/0x5a0
[  221.837624]  [<ffffffff8037c7fd>] ? do_munmap+0x27d/0x370
[  221.843106]  [<ffffffff803d0e74>] SyS_ioctl+0x74/0x80
[  221.848580]  [<ffffffff8086bf1f>] entry_SYSCALL_64_fastpath+0x17/0x93
[  221.854071] Code: d7 49 01 c7 4c 39 f3 77 89 4d 85 f6 75 14 48 83 c4 08 4c 89 f0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 49 8d 46 ff 4c 85 f0 74 e3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 8b 57 7c 48 89 f0 85 d2 
[  221.865676] RIP  [<ffffffff80622043>] iommu_unmap_page+0xd3/0xe0
[  221.871445]  RSP <ffff88043b98bb60>
[  221.877253] ---[ end trace 666af9a0a95e4828 ]---

--------------5FA726993E3A80BB147C3DB5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------5FA726993E3A80BB147C3DB5--
