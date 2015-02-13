From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: Kernel Oops: iommu related?
Date: Fri, 13 Feb 2015 09:19:06 -0500
Message-ID: <54DE07DA.9050703@compro.net>
References: <54DCE8A6.4000608@compro.net> <20150212180846.GD29106@8bytes.org>
	<54DCF024.30309@compro.net> <54DD00FE.2050009@compro.net>
	<20150212211340.GF29106@8bytes.org>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010902090405020809060707"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150212211340.GF29106-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------010902090405020809060707
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2015 04:13 PM, Joerg Roedel wrote:
> On Thu, Feb 12, 2015 at 02:37:34PM -0500, Mark Hounschell wrote:
>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.18.7-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G audit=0 nohz=on nohz_full=4,5,6,7 rcu_nocbs=4,5,6,7 3
>
> Oh, and can you please boot with 'amd_iommu_dump' on the kernel command
> line and send me dmesg after boot?
>
> Thanks,
>

OK. Attached. BTW when I blacklist the aic7xxx driver [last unloaded: 
aic7xxx] I can load and unload any module all  day long.

Thanks
Mark



--------------010902090405020809060707
Content-Type: text/plain; charset=UTF-8;
 name="d.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="d.dmesg"

[    0.000000] Linux version 3.18.7-lcrs (root@harley) (gcc version 4.8.3 20140627 [gcc-4_8-branch revision 212064] (SUSE Linux) ) #1 SMP PREEMPT Wed Feb 11 15:38:40 EST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.18.7-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G audit=0 nohz=on nohz_full=4,5,6,7 rcu_nocbs=4,5,6,7 3 amd_iommu_dump
[    0.000000] tseg: 00af800000
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000ae47afff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ae47b000-0x00000000aea38fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000aea39000-0x00000000aee34fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000aee35000-0x00000000af154fff] reserved
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
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820: update [mem 0xaf800000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xaf800 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fd9a0-0x000fd9af] mapped at [ffff8800000fd9a0]
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x00ed1000, 0x00ed1fff] PGTABLE
[    0.000000] BRK [0x00ed2000, 0x00ed2fff] PGTABLE
[    0.000000] BRK [0x00ed3000, 0x00ed3fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x44fe00000-0x44fffffff]
[    0.000000]  [mem 0x44fe00000-0x44fffffff] page 2M
[    0.000000] BRK [0x00ed4000, 0x00ed4fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x44c000000-0x44fdfffff]
[    0.000000]  [mem 0x44c000000-0x44fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x400000000-0x44bffffff]
[    0.000000]  [mem 0x400000000-0x43fffffff] page 1G
[    0.000000]  [mem 0x440000000-0x44bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xae47afff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0x7fffffff] page 1G
[    0.000000]  [mem 0x80000000-0xae3fffff] page 2M
[    0.000000]  [mem 0xae400000-0xae47afff] page 4k
[    0.000000] init_memory_mapping: [mem 0xaf155000-0xaf155fff]
[    0.000000]  [mem 0xaf155000-0xaf155fff] page 4k
[    0.000000] BRK [0x00ed5000, 0x00ed5fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xaf35c000-0xaf7fffff]
[    0.000000]  [mem 0xaf35c000-0xaf3fffff] page 4k
[    0.000000]  [mem 0xaf400000-0xaf7fffff] page 2M
[    0.000000] BRK [0x00ed6000, 0x00ed6fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x100001000-0x3ffffffff]
[    0.000000]  [mem 0x100001000-0x1001fffff] page 4k
[    0.000000]  [mem 0x100200000-0x13fffffff] page 2M
[    0.000000]  [mem 0x140000000-0x3ffffffff] page 1G
[    0.000000] RAMDISK: [mem 0x37106000-0x3787afff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000AEE25070 000064 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000AEE2B880 0000F4 (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20140926/tbfadt-649)
[    0.000000] ACPI: DSDT 0x00000000AEE25170 00670F (v02 ALASKA A M I    00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000AEE2FF80 000040
[    0.000000] ACPI: APIC 0x00000000AEE2B978 00009E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000AEE2BA18 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000AEE2BA60 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000AEE2BAA0 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: MATS 0x00000000AEE2BAD8 000034 (v02 ALASKA A M I    00000002 w?x2 00000000)
[    0.000000] ACPI: IVRS 0x00000000AEE2BB10 000120 (v01 AMD    RD890S   00202031 AMD  00000000)
[    0.000000] ACPI: BGRT 0x00000000AEE2BC30 000038 (v00 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] cma: Reserved 64 MiB at 0x00000000aa400000
[    0.000000]  [ffffea0000000000-ffffea00113fffff] PMD -> [ffff88043f600000-ffff88044f5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x44fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xae47afff]
[    0.000000]   node   0: [mem 0xaf155000-0xaf155fff]
[    0.000000]   node   0: [mem 0xaf35c000-0xaf7fffff]
[    0.000000]   node   0: [mem 0x100001000-0x44fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x44fffffff]
[    0.000000] On node 0 totalpages: 4188348
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 3308 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11109 pages used for memmap
[    0.000000]   DMA32 zone: 710944 pages, LIFO batch:31
[    0.000000]   Normal zone: 54272 pages used for memmap
[    0.000000]   Normal zone: 3473407 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x10] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x11] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x13] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x14] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x15] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x16] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x17] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x0a] address[0xfec20000] gsi_base[24])
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
[    0.000000] PM: Registered nosave memory: [mem 0xae47b000-0xaea38fff]
[    0.000000] PM: Registered nosave memory: [mem 0xaea39000-0xaee34fff]
[    0.000000] PM: Registered nosave memory: [mem 0xaee35000-0xaf154fff]
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
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88044fc00000 s76544 r8192 d29952 u262144
[    0.000000] pcpu-alloc: s76544 r8192 d29952 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4119595
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.18.7-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G audit=0 nohz=on nohz_full=4,5,6,7 rcu_nocbs=4,5,6,7 3 amd_iommu_dump
[    0.000000] audit: disabled (until reboot)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] Memory: 16313148K/16753392K available (5924K kernel code, 705K rwdata, 2804K rodata, 964K init, 1176K bss, 440244K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS:8448 nr_irqs:1032 0
[    0.000000] NO_HZ: Full dynticks CPUs: 4-7.
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-7.
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3616.301 MHz processor
[    0.000019] Calibrating delay loop (skipped), value calculated using timer frequency.. 7235.96 BogoMIPS (lpj=12054336)
[    0.000024] pid_max: default: 32768 minimum: 301
[    0.000029] ACPI: Core revision 20140926
[    0.003341] ACPI: All ACPI Tables successfully acquired
[    0.006254] Security Framework initialized
[    0.006289] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.006292] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.006545] CPU: Physical Processor ID: 0
[    0.006547] CPU: Processor Core ID: 0
[    0.006550] mce: CPU supports 7 MCE banks
[    0.006556] LVT offset 1 assigned for vector 0xf9
[    0.006561] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.006632] Freeing SMP alternatives memory: 24K (ffffffff80da3000 - ffffffff80da9000)
[    0.007008] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.039995] smpboot: CPU0: AMD FX(tm)-8150 Eight-Core Processor (fam: 15, model: 01, stepping: 02)
[    0.144041] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.144048] ... version:                0
[    0.144050] ... bit width:              48
[    0.144051] ... generic registers:      6
[    0.144053] ... value mask:             0000ffffffffffff
[    0.144055] ... max period:             00007fffffffffff
[    0.144057] ... fixed-purpose events:   0
[    0.144059] ... event mask:             000000000000003f
[    0.164103] x86: Booting SMP configuration:
[    0.164106] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.289014] x86: Booted up 1 node, 8 CPUs
[    0.289020] smpboot: Total of 8 processors activated (57883.68 BogoMIPS)
[    0.301410] devtmpfs: initialized
[    0.301619] PM: Registering ACPI NVS region [mem 0xaea39000-0xaee34fff] (4177920 bytes)
[    0.301666] PM: Registering ACPI NVS region [mem 0xaf156000-0xaf35bfff] (2121728 bytes)
[    0.302208] RTC time: 13:51:51, date: 02/13/15
[    0.303376] NET: Registered protocol family 16
[    0.307285] cpuidle: using governor ladder
[    0.313946] cpuidle: using governor menu
[    0.314028] ACPI: bus type PCI registered
[    0.314031] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.314085] PCI: Using configuration type 1 for base access
[    0.314087] PCI: Using configuration type 1 for extended access
[    0.320944] ACPI: Added _OSI(Module Device)
[    0.320947] ACPI: Added _OSI(Processor Device)
[    0.320949] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.320952] ACPI: Added _OSI(Processor Aggregator Device)
[    0.322600] ACPI: Executed 3 blocks of module-level executable AML code
[    0.331017] ACPI: Interpreter enabled
[    0.331024] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20140926/hwxface-580)
[    0.331030] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20140926/hwxface-580)
[    0.331044] ACPI: (supports S0 S3 S4 S5)
[    0.331047] ACPI: Using IOAPIC for interrupt routing
[    0.331202] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.393324] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.393331] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.393338] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.393797] PCI host bridge to bus 0000:00
[    0.393801] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.393804] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    0.393807] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    0.393810] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    0.393812] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.393815] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.393818] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.393821] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xdfffffff]
[    0.393832] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.393949] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    0.394050] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.394085] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.394133] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.394168] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.394202] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.394250] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.394288] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    0.394321] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.394367] pci 0000:00:09.0: System wakeup disabled by ACPI
[    0.394402] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    0.394435] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.394481] pci 0000:00:0a.0: System wakeup disabled by ACPI
[    0.394515] pci 0000:00:0b.0: [1002:5a1f] type 01 class 0x060400
[    0.394549] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
[    0.394595] pci 0000:00:0b.0: System wakeup disabled by ACPI
[    0.394640] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.394654] pci 0000:00:11.0: reg 0x10: [io  0xf090-0xf097]
[    0.394661] pci 0000:00:11.0: reg 0x14: [io  0xf080-0xf083]
[    0.394668] pci 0000:00:11.0: reg 0x18: [io  0xf070-0xf077]
[    0.394675] pci 0000:00:11.0: reg 0x1c: [io  0xf060-0xf063]
[    0.394682] pci 0000:00:11.0: reg 0x20: [io  0xf050-0xf05f]
[    0.394689] pci 0000:00:11.0: reg 0x24: [mem 0xd870b000-0xd870b3ff]
[    0.394792] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.394802] pci 0000:00:12.0: reg 0x10: [mem 0xd870a000-0xd870afff]
[    0.394884] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.394923] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.394937] pci 0000:00:12.2: reg 0x10: [mem 0xd8709000-0xd87090ff]
[    0.394998] pci 0000:00:12.2: supports D1 D2
[    0.395000] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.395047] pci 0000:00:12.2: System wakeup disabled by ACPI
[    0.395086] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.395096] pci 0000:00:13.0: reg 0x10: [mem 0xd8708000-0xd8708fff]
[    0.395180] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.395220] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.395234] pci 0000:00:13.2: reg 0x10: [mem 0xd8707000-0xd87070ff]
[    0.395295] pci 0000:00:13.2: supports D1 D2
[    0.395296] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.395343] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.395382] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.395495] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    0.395505] pci 0000:00:14.1: reg 0x10: [io  0xf040-0xf047]
[    0.395512] pci 0000:00:14.1: reg 0x14: [io  0xf030-0xf033]
[    0.395519] pci 0000:00:14.1: reg 0x18: [io  0xf020-0xf027]
[    0.395526] pci 0000:00:14.1: reg 0x1c: [io  0xf010-0xf013]
[    0.395533] pci 0000:00:14.1: reg 0x20: [io  0xf000-0xf00f]
[    0.395548] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.395551] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.395553] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.395556] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.395639] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.395654] pci 0000:00:14.2: reg 0x10: [mem 0xd8700000-0xd8703fff 64bit]
[    0.395704] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.395748] pci 0000:00:14.2: System wakeup disabled by ACPI
[    0.395783] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.395897] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.395963] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.395998] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.396008] pci 0000:00:14.5: reg 0x10: [mem 0xd8706000-0xd8706fff]
[    0.396090] pci 0000:00:14.5: System wakeup disabled by ACPI
[    0.396129] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
[    0.396185] pci 0000:00:15.0: supports D1 D2
[    0.396234] pci 0000:00:15.0: System wakeup disabled by ACPI
[    0.396271] pci 0000:00:15.1: [1002:43a1] type 01 class 0x060400
[    0.396327] pci 0000:00:15.1: supports D1 D2
[    0.396376] pci 0000:00:15.1: System wakeup disabled by ACPI
[    0.396414] pci 0000:00:15.2: [1002:43a2] type 01 class 0x060400
[    0.396470] pci 0000:00:15.2: supports D1 D2
[    0.396519] pci 0000:00:15.2: System wakeup disabled by ACPI
[    0.396556] pci 0000:00:15.3: [1002:43a3] type 01 class 0x060400
[    0.396612] pci 0000:00:15.3: supports D1 D2
[    0.396661] pci 0000:00:15.3: System wakeup disabled by ACPI
[    0.396699] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.396709] pci 0000:00:16.0: reg 0x10: [mem 0xd8705000-0xd8705fff]
[    0.396790] pci 0000:00:16.0: System wakeup disabled by ACPI
[    0.396831] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.396845] pci 0000:00:16.2: reg 0x10: [mem 0xd8704000-0xd87040ff]
[    0.396906] pci 0000:00:16.2: supports D1 D2
[    0.396908] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.396954] pci 0000:00:16.2: System wakeup disabled by ACPI
[    0.396993] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.397069] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.397140] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.397212] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.397289] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.397360] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.397478] pci 0000:01:00.0: [10de:0092] type 00 class 0x030000
[    0.397488] pci 0000:01:00.0: reg 0x10: [mem 0xda000000-0xdaffffff]
[    0.397496] pci 0000:01:00.0: reg 0x14: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.397504] pci 0000:01:00.0: reg 0x1c: [mem 0xd9000000-0xd9ffffff 64bit]
[    0.397510] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.397515] pci 0000:01:00.0: reg 0x30: [mem 0xdb000000-0xdb01ffff pref]
[    0.397584] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.397592] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.397596] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.397598] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.397601] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.397651] pci 0000:02:00.0: [104c:8231] type 01 class 0x060400
[    0.397745] pci 0000:02:00.0: supports D1 D2
[    0.397787] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.397795] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.397799] pci 0000:00:04.0:   bridge window [io  0x6000-0x7fff]
[    0.397801] pci 0000:00:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.397804] pci 0000:00:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.397880] pci 0000:03:04.0: [12d8:8150] type 01 class 0x060400
[    0.398046] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.398054] pci 0000:02:00.0:   bridge window [io  0x6000-0x7fff]
[    0.398058] pci 0000:02:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.398064] pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.398142] pci 0000:04:04.0: [10b5:0480] type 00 class 0x0e8000
[    0.398178] pci 0000:04:04.0: reg 0x10: [mem 0xdd909000-0xdd9093ff]
[    0.398194] pci 0000:04:04.0: reg 0x14: [mem 0xdd000000-0xdd7fffff]
[    0.398210] pci 0000:04:04.0: reg 0x18: [mem 0xdd908000-0xdd90800f]
[    0.398415] pci 0000:04:05.0: [10b5:0480] type 00 class 0x0e8000
[    0.398451] pci 0000:04:05.0: reg 0x10: [mem 0xdd907000-0xdd9073ff]
[    0.398467] pci 0000:04:05.0: reg 0x14: [mem 0xdc800000-0xdcffffff]
[    0.398483] pci 0000:04:05.0: reg 0x18: [mem 0xdd906000-0xdd90600f]
[    0.398690] pci 0000:04:06.0: [10b5:0480] type 00 class 0x0e8000
[    0.398726] pci 0000:04:06.0: reg 0x10: [mem 0xdd905000-0xdd9053ff]
[    0.398742] pci 0000:04:06.0: reg 0x14: [mem 0xdc000000-0xdc7fffff]
[    0.398758] pci 0000:04:06.0: reg 0x18: [mem 0xdd904000-0xdd90400f]
[    0.398968] pci 0000:04:07.0: [10b5:0480] type 00 class 0x0e8000
[    0.399004] pci 0000:04:07.0: reg 0x10: [mem 0xdd903000-0xdd9033ff]
[    0.399021] pci 0000:04:07.0: reg 0x14: [mem 0xdb800000-0xdbffffff]
[    0.399036] pci 0000:04:07.0: reg 0x18: [mem 0xdd902000-0xdd90200f]
[    0.399241] pci 0000:04:08.0: [3388:0022] type 01 class 0x060400
[    0.399393] pci 0000:04:08.0: supports D1 D2
[    0.399394] pci 0000:04:08.0: PME# supported from D0 D1 D2 D3hot
[    0.399450] pci 0000:04:09.0: [1090:4610] type 00 class 0xff0000
[    0.399471] pci 0000:04:09.0: reg 0x10: [io  0x7100-0x713f]
[    0.399485] pci 0000:04:09.0: reg 0x14: [mem 0xdd901000-0xdd901fff]
[    0.399601] pci 0000:04:0a.0: [1090:4360] type 00 class 0x058000
[    0.399623] pci 0000:04:0a.0: reg 0x10: [mem 0xdd900000-0xdd9000ff]
[    0.399639] pci 0000:04:0a.0: reg 0x14: [io  0x7000-0x70ff]
[    0.399654] pci 0000:04:0a.0: reg 0x18: [mem 0xc0000000-0xc3ffffff pref]
[    0.399713] pci 0000:04:0a.0: reg 0x30: [mem 0xdd90a000-0xdd90a7ff pref]
[    0.399799] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.399808] pci 0000:03:04.0:   bridge window [io  0x6000-0x7fff]
[    0.399812] pci 0000:03:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.399819] pci 0000:03:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.399899] pci 0000:05:00.0: [1090:0100] type 00 class 0xff0000
[    0.399925] pci 0000:05:00.0: reg 0x10: [mem 0xdd80a000-0xdd80afff]
[    0.399943] pci 0000:05:00.0: reg 0x14: [mem 0xdd808000-0xdd809fff]
[    0.399962] pci 0000:05:00.0: reg 0x18: [mem 0xdd800000-0xdd807fff]
[    0.400151] pci 0000:04:08.0: PCI bridge to [bus 05]
[    0.400162] pci 0000:04:08.0:   bridge window [io  0x6000-0x6fff]
[    0.400167] pci 0000:04:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.400243] pci 0000:06:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.400258] pci 0000:06:00.0: reg 0x10: [mem 0xde100000-0xde107fff 64bit]
[    0.400329] pci 0000:06:00.0: supports D1 D2
[    0.400330] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.403901] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.403907] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.403955] pci 0000:07:00.0: [1b4b:9172] type 00 class 0x010601
[    0.403965] pci 0000:07:00.0: reg 0x10: [io  0xd040-0xd047]
[    0.403971] pci 0000:07:00.0: reg 0x14: [io  0xd030-0xd033]
[    0.403977] pci 0000:07:00.0: reg 0x18: [io  0xd020-0xd027]
[    0.403983] pci 0000:07:00.0: reg 0x1c: [io  0xd010-0xd013]
[    0.403989] pci 0000:07:00.0: reg 0x20: [io  0xd000-0xd00f]
[    0.403995] pci 0000:07:00.0: reg 0x24: [mem 0xde010000-0xde0101ff]
[    0.404001] pci 0000:07:00.0: reg 0x30: [mem 0xde000000-0xde00ffff pref]
[    0.404035] pci 0000:07:00.0: PME# supported from D3hot
[    0.410561] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.410566] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
[    0.410568] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.410628] pci 0000:08:00.0: [10b5:8114] type 01 class 0x060400
[    0.410648] pci 0000:08:00.0: reg 0x10: [mem 0xddc00000-0xddc01fff]
[    0.410762] pci 0000:08:00.0: PME# supported from D0 D3hot
[    0.410828] pci 0000:08:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.410837] pci 0000:00:0b.0: PCI bridge to [bus 08-09]
[    0.410841] pci 0000:00:0b.0:   bridge window [io  0xc000-0xcfff]
[    0.410843] pci 0000:00:0b.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.410928] pci 0000:09:04.0: [9005:8017] type 00 class 0x010000
[    0.410954] pci 0000:09:04.0: reg 0x10: [io  0xc100-0xc1ff]
[    0.410972] pci 0000:09:04.0: reg 0x14: [mem 0xddb80000-0xddb81fff 64bit]
[    0.410984] pci 0000:09:04.0: reg 0x1c: [io  0xc000-0xc0ff]
[    0.411016] pci 0000:09:04.0: reg 0x30: [mem 0xddb00000-0xddb7ffff pref]
[    0.411149] pci 0000:08:00.0: PCI bridge to [bus 09]
[    0.411158] pci 0000:08:00.0:   bridge window [io  0xc000-0xcfff]
[    0.411162] pci 0000:08:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.411212] pci 0000:0a:06.0: [1090:4610] type 00 class 0xff0000
[    0.411225] pci 0000:0a:06.0: reg 0x10: [io  0xb000-0xb03f]
[    0.411234] pci 0000:0a:06.0: reg 0x14: [mem 0xddf00000-0xddf00fff]
[    0.411341] pci 0000:00:14.4: PCI bridge to [bus 0a] (subtractive decode)
[    0.411345] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.411348] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.411352] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    0.411353] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    0.411355] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    0.411356] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.411357] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.411359] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.411360] pci 0000:00:14.4:   bridge window [mem 0xb0000000-0xdfffffff] (subtractive decode)
[    0.411435] pci 0000:0b:00.0: [10ec:8168] type 00 class 0x020000
[    0.411452] pci 0000:0b:00.0: reg 0x10: [io  0xa000-0xa0ff]
[    0.411477] pci 0000:0b:00.0: reg 0x18: [mem 0xc6004000-0xc6004fff 64bit pref]
[    0.411493] pci 0000:0b:00.0: reg 0x20: [mem 0xc6000000-0xc6003fff 64bit pref]
[    0.411576] pci 0000:0b:00.0: supports D1 D2
[    0.411577] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.411612] pci 0000:0b:00.0: System wakeup disabled by ACPI
[    0.417230] pci 0000:00:15.0: PCI bridge to [bus 0b]
[    0.417237] pci 0000:00:15.0:   bridge window [io  0xa000-0xafff]
[    0.417242] pci 0000:00:15.0:   bridge window [mem 0xc6000000-0xc60fffff 64bit pref]
[    0.417309] pci 0000:0c:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.417330] pci 0000:0c:00.0: reg 0x10: [mem 0xdde00000-0xdde07fff 64bit]
[    0.417430] pci 0000:0c:00.0: supports D1 D2
[    0.417431] pci 0000:0c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.423891] pci 0000:00:15.1: PCI bridge to [bus 0c]
[    0.423899] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.423965] pci 0000:0d:00.0: [1b4b:9172] type 00 class 0x010601
[    0.423979] pci 0000:0d:00.0: reg 0x10: [io  0x9040-0x9047]
[    0.423988] pci 0000:0d:00.0: reg 0x14: [io  0x9030-0x9033]
[    0.423996] pci 0000:0d:00.0: reg 0x18: [io  0x9020-0x9027]
[    0.424004] pci 0000:0d:00.0: reg 0x1c: [io  0x9010-0x9013]
[    0.424013] pci 0000:0d:00.0: reg 0x20: [io  0x9000-0x900f]
[    0.424021] pci 0000:0d:00.0: reg 0x24: [mem 0xddd10000-0xddd101ff]
[    0.424030] pci 0000:0d:00.0: reg 0x30: [mem 0xddd00000-0xddd0ffff pref]
[    0.424076] pci 0000:0d:00.0: PME# supported from D3hot
[    0.430552] pci 0000:00:15.2: PCI bridge to [bus 0d]
[    0.430558] pci 0000:00:15.2:   bridge window [io  0x9000-0x9fff]
[    0.430561] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.430636] pci 0000:0e:00.0: [104c:8231] type 01 class 0x060400
[    0.430758] pci 0000:0e:00.0: supports D1 D2
[    0.430803] pci 0000:0e:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.430813] pci 0000:00:15.3: PCI bridge to [bus 0e-12]
[    0.430818] pci 0000:00:15.3:   bridge window [io  0x8000-0x8fff]
[    0.430821] pci 0000:00:15.3:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.430825] pci 0000:00:15.3:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.430921] pci 0000:0f:04.0: [12d8:8150] type 01 class 0x060400
[    0.431118] pci 0000:0e:00.0: PCI bridge to [bus 0f-12]
[    0.431127] pci 0000:0e:00.0:   bridge window [io  0x8000-0x8fff]
[    0.431131] pci 0000:0e:00.0:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.431139] pci 0000:0e:00.0:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.431223] pci 0000:10:04.0: [114a:5565] type 00 class 0x028000
[    0.431260] pci 0000:10:04.0: reg 0x10: [mem 0xd8643000-0xd86431ff]
[    0.431278] pci 0000:10:04.0: reg 0x14: [io  0x8100-0x81ff]
[    0.431296] pci 0000:10:04.0: reg 0x18: [mem 0xd8642000-0xd864203f]
[    0.431314] pci 0000:10:04.0: reg 0x1c: [mem 0xd0000000-0xd7ffffff]
[    0.431492] pci 0000:10:05.0: [10b7:9200] type 00 class 0x020000
[    0.431525] pci 0000:10:05.0: reg 0x10: [io  0x8200-0x827f]
[    0.431543] pci 0000:10:05.0: reg 0x14: [mem 0xd8641000-0xd864107f]
[    0.431627] pci 0000:10:05.0: reg 0x30: [mem 0xd8600000-0xd861ffff pref]
[    0.431683] pci 0000:10:05.0: supports D1 D2
[    0.431684] pci 0000:10:05.0: PME# supported from D0 D1 D2 D3hot
[    0.431757] pci 0000:10:07.0: [3388:0022] type 01 class 0x060400
[    0.431933] pci 0000:10:07.0: supports D1 D2
[    0.431934] pci 0000:10:07.0: PME# supported from D0 D1 D2 D3hot
[    0.432012] pci 0000:10:08.0: [3388:0022] type 01 class 0x060400
[    0.432188] pci 0000:10:08.0: supports D1 D2
[    0.432190] pci 0000:10:08.0: PME# supported from D0 D1 D2 D3hot
[    0.432253] pci 0000:10:09.0: [114f:0027] type 00 class 0x078000
[    0.432281] pci 0000:10:09.0: reg 0x10: [mem 0xd8000000-0xd83fffff]
[    0.432382] pci 0000:10:09.0: reg 0x30: [mem 0xd8630000-0xd863ffff pref]
[    0.432450] pci 0000:10:0a.0: [9004:3860] type 00 class 0x010000
[    0.432482] pci 0000:10:0a.0: reg 0x10: [io  0x8000-0x80ff]
[    0.432500] pci 0000:10:0a.0: reg 0x14: [mem 0xd8640000-0xd8640fff]
[    0.432585] pci 0000:10:0a.0: reg 0x30: [mem 0xd8620000-0xd862ffff pref]
[    0.432721] pci 0000:0f:04.0: PCI bridge to [bus 10-12]
[    0.432731] pci 0000:0f:04.0:   bridge window [io  0x8000-0x8fff]
[    0.432736] pci 0000:0f:04.0:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.432745] pci 0000:0f:04.0:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.432845] pci 0000:11:00.0: [1090:4710] type 00 class 0xff0000
[    0.432882] pci 0000:11:00.0: reg 0x10: [mem 0xd8500000-0xd85001ff]
[    0.432903] pci 0000:11:00.0: reg 0x14: [mem 0xc5000000-0xc5ffffff pref]
[    0.433177] pci 0000:10:07.0: PCI bridge to [bus 11]
[    0.433193] pci 0000:10:07.0:   bridge window [mem 0xd8500000-0xd85fffff]
[    0.433204] pci 0000:10:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.433305] pci 0000:12:00.0: [1090:4710] type 00 class 0xff0000
[    0.433342] pci 0000:12:00.0: reg 0x10: [mem 0xd8400000-0xd84001ff]
[    0.433363] pci 0000:12:00.0: reg 0x14: [mem 0xc4000000-0xc4ffffff pref]
[    0.433637] pci 0000:10:08.0: PCI bridge to [bus 12]
[    0.433654] pci 0000:10:08.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.433664] pci 0000:10:08.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.433754] pci_bus 0000:00: on NUMA node 0
[    0.434197] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.434270] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.434345] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.434419] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 11 14 15) *0
[    0.434479] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 10 11 14 15) *0
[    0.434527] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 10 11 14 15) *0
[    0.434574] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 10 11 14 15) *0
[    0.434621] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 10 11 14 15) *0
[    0.434782] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.434786] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.434793] vgaarb: loaded
[    0.434795] vgaarb: bridge control possible 0000:01:00.0
[    0.434849] SCSI subsystem initialized
[    0.434903] libata version 3.00 loaded.
[    0.434908] ACPI: bus type USB registered
[    0.434925] usbcore: registered new interface driver usbfs
[    0.434935] usbcore: registered new interface driver hub
[    0.434958] usbcore: registered new device driver usb
[    0.435060] PCI: Using ACPI for IRQ routing
[    0.435063] PCI: pci_cache_line_size set to 64 bytes
[    0.435220] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.435222] e820: reserve RAM buffer [mem 0xae47b000-0xafffffff]
[    0.435223] e820: reserve RAM buffer [mem 0xaf156000-0xafffffff]
[    0.435224] e820: reserve RAM buffer [mem 0xaf800000-0xafffffff]
[    0.435313] NetLabel: Initializing
[    0.435315] NetLabel:  domain hash size = 128
[    0.435317] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.435327] NetLabel:  unlabeled traffic allowed by default
[    0.435364] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.435368] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.437434] Switched to clocksource hpet
[    0.439562] pnp: PnP ACPI init
[    0.439670] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.439674] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.440014] system 00:01: [io  0x040b] has been reserved
[    0.440018] system 00:01: [io  0x04d6] has been reserved
[    0.440021] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.440023] system 00:01: [io  0x0c14] has been reserved
[    0.440026] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.440029] system 00:01: [io  0x0c52] has been reserved
[    0.440031] system 00:01: [io  0x0c6c] has been reserved
[    0.440034] system 00:01: [io  0x0c6f] has been reserved
[    0.440037] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.440039] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.440042] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.440045] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.440048] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.440051] system 00:01: [io  0x0800-0x089f] could not be reserved
[    0.440054] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.440057] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.440059] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.440063] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.440066] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.440069] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.440072] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.440075] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.440078] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.440081] system 00:01: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.440085] system 00:01: [mem 0xffc00000-0xffffffff] has been reserved
[    0.440088] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.440267] system 00:02: [io  0x0220-0x0227] has been reserved
[    0.440270] system 00:02: [io  0x0228-0x0237] has been reserved
[    0.440273] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    0.440276] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.440317] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.440586] pnp 00:04: [dma 0 disabled]
[    0.440625] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.440651] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.440728] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.440732] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.440791] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.440944] system 00:08: [mem 0xfeb20000-0xfeb23fff] has been reserved
[    0.440948] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.441081] system 00:09: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.441085] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.441192] pnp: PnP ACPI: found 10 devices
[    0.447817] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.447822] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.447826] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.447830] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.447835] pci 0000:04:08.0: PCI bridge to [bus 05]
[    0.447840] pci 0000:04:08.0:   bridge window [io  0x6000-0x6fff]
[    0.447849] pci 0000:04:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.447864] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.447869] pci 0000:03:04.0:   bridge window [io  0x6000-0x7fff]
[    0.447876] pci 0000:03:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.447882] pci 0000:03:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.447891] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.447895] pci 0000:02:00.0:   bridge window [io  0x6000-0x7fff]
[    0.447901] pci 0000:02:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.447906] pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.447914] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.447917] pci 0000:00:04.0:   bridge window [io  0x6000-0x7fff]
[    0.447921] pci 0000:00:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.447924] pci 0000:00:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.447929] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.447932] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.447937] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.447940] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
[    0.447943] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.447948] pci 0000:08:00.0: PCI bridge to [bus 09]
[    0.447952] pci 0000:08:00.0:   bridge window [io  0xc000-0xcfff]
[    0.447960] pci 0000:08:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.447973] pci 0000:00:0b.0: PCI bridge to [bus 08-09]
[    0.447976] pci 0000:00:0b.0:   bridge window [io  0xc000-0xcfff]
[    0.447980] pci 0000:00:0b.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.447985] pci 0000:00:14.4: PCI bridge to [bus 0a]
[    0.447988] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.447993] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.448000] pci 0000:00:15.0: PCI bridge to [bus 0b]
[    0.448003] pci 0000:00:15.0:   bridge window [io  0xa000-0xafff]
[    0.448009] pci 0000:00:15.0:   bridge window [mem 0xc6000000-0xc60fffff 64bit pref]
[    0.448015] pci 0000:00:15.1: PCI bridge to [bus 0c]
[    0.448019] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.448025] pci 0000:00:15.2: PCI bridge to [bus 0d]
[    0.448029] pci 0000:00:15.2:   bridge window [io  0x9000-0x9fff]
[    0.448033] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.448040] pci 0000:10:07.0: PCI bridge to [bus 11]
[    0.448050] pci 0000:10:07.0:   bridge window [mem 0xd8500000-0xd85fffff]
[    0.448058] pci 0000:10:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.448071] pci 0000:10:08.0: PCI bridge to [bus 12]
[    0.448081] pci 0000:10:08.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.448089] pci 0000:10:08.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.448102] pci 0000:0f:04.0: PCI bridge to [bus 10-12]
[    0.448106] pci 0000:0f:04.0:   bridge window [io  0x8000-0x8fff]
[    0.448114] pci 0000:0f:04.0:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.448121] pci 0000:0f:04.0:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448132] pci 0000:0e:00.0: PCI bridge to [bus 0f-12]
[    0.448136] pci 0000:0e:00.0:   bridge window [io  0x8000-0x8fff]
[    0.448143] pci 0000:0e:00.0:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.448149] pci 0000:0e:00.0:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448158] pci 0000:00:15.3: PCI bridge to [bus 0e-12]
[    0.448161] pci 0000:00:15.3:   bridge window [io  0x8000-0x8fff]
[    0.448166] pci 0000:00:15.3:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.448170] pci 0000:00:15.3:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448176] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    0.448177] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    0.448179] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    0.448180] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
[    0.448182] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    0.448183] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    0.448185] pci_bus 0000:00: resource 10 [mem 0xb0000000-0xdfffffff]
[    0.448186] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.448188] pci_bus 0000:01: resource 1 [mem 0xd9000000-0xdb0fffff]
[    0.448189] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.448191] pci_bus 0000:02: resource 0 [io  0x6000-0x7fff]
[    0.448192] pci_bus 0000:02: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.448194] pci_bus 0000:02: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.448195] pci_bus 0000:03: resource 0 [io  0x6000-0x7fff]
[    0.448197] pci_bus 0000:03: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.448198] pci_bus 0000:03: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.448200] pci_bus 0000:04: resource 0 [io  0x6000-0x7fff]
[    0.448201] pci_bus 0000:04: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.448203] pci_bus 0000:04: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.448204] pci_bus 0000:05: resource 0 [io  0x6000-0x6fff]
[    0.448206] pci_bus 0000:05: resource 1 [mem 0xdd800000-0xdd8fffff]
[    0.448207] pci_bus 0000:06: resource 1 [mem 0xde100000-0xde1fffff]
[    0.448209] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.448210] pci_bus 0000:07: resource 1 [mem 0xde000000-0xde0fffff]
[    0.448212] pci_bus 0000:08: resource 0 [io  0xc000-0xcfff]
[    0.448213] pci_bus 0000:08: resource 1 [mem 0xddb00000-0xddcfffff]
[    0.448215] pci_bus 0000:09: resource 0 [io  0xc000-0xcfff]
[    0.448216] pci_bus 0000:09: resource 1 [mem 0xddb00000-0xddbfffff]
[    0.448218] pci_bus 0000:0a: resource 0 [io  0xb000-0xbfff]
[    0.448219] pci_bus 0000:0a: resource 1 [mem 0xddf00000-0xddffffff]
[    0.448221] pci_bus 0000:0a: resource 4 [io  0x0000-0x03af]
[    0.448222] pci_bus 0000:0a: resource 5 [io  0x03e0-0x0cf7]
[    0.448223] pci_bus 0000:0a: resource 6 [io  0x03b0-0x03df]
[    0.448225] pci_bus 0000:0a: resource 7 [io  0x0d00-0xffff]
[    0.448226] pci_bus 0000:0a: resource 8 [mem 0x000a0000-0x000bffff]
[    0.448228] pci_bus 0000:0a: resource 9 [mem 0x000c0000-0x000dffff]
[    0.448229] pci_bus 0000:0a: resource 10 [mem 0xb0000000-0xdfffffff]
[    0.448231] pci_bus 0000:0b: resource 0 [io  0xa000-0xafff]
[    0.448232] pci_bus 0000:0b: resource 2 [mem 0xc6000000-0xc60fffff 64bit pref]
[    0.448234] pci_bus 0000:0c: resource 1 [mem 0xdde00000-0xddefffff]
[    0.448235] pci_bus 0000:0d: resource 0 [io  0x9000-0x9fff]
[    0.448237] pci_bus 0000:0d: resource 1 [mem 0xddd00000-0xdddfffff]
[    0.448238] pci_bus 0000:0e: resource 0 [io  0x8000-0x8fff]
[    0.448240] pci_bus 0000:0e: resource 1 [mem 0xd0000000-0xd86fffff]
[    0.448241] pci_bus 0000:0e: resource 2 [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448243] pci_bus 0000:0f: resource 0 [io  0x8000-0x8fff]
[    0.448244] pci_bus 0000:0f: resource 1 [mem 0xd0000000-0xd86fffff]
[    0.448246] pci_bus 0000:0f: resource 2 [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448247] pci_bus 0000:10: resource 0 [io  0x8000-0x8fff]
[    0.448249] pci_bus 0000:10: resource 1 [mem 0xd0000000-0xd86fffff]
[    0.448250] pci_bus 0000:10: resource 2 [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448252] pci_bus 0000:11: resource 1 [mem 0xd8500000-0xd85fffff]
[    0.448253] pci_bus 0000:11: resource 2 [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.448255] pci_bus 0000:12: resource 1 [mem 0xd8400000-0xd84fffff]
[    0.448256] pci_bus 0000:12: resource 2 [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.448272] NET: Registered protocol family 2
[    0.448418] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.448621] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.448805] TCP: Hash tables configured (established 131072 bind 65536)
[    0.448833] TCP: reno registered
[    0.448837] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.448890] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.448982] NET: Registered protocol family 1
[    0.757451] pci 0000:01:00.0: Video device with shadowed ROM
[    0.757455] pci 0000:02:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.757700] pci 0000:0e:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.757734] PCI: CLS 64 bytes, default 64
[    0.757774] Unpacking initramfs...
[    1.403911] microcode: updated early to new patch_level=0x0600063d
[    1.405520] Freeing initrd memory: 7636K (ffff880037106000 - ffff88003787b000)
[    1.405601] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: 3e info 1300
[    1.405603] AMD-Vi:        mmio-addr: 00000000feb20000
[    1.405623] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:00.0 flags: 00
[    1.405626] AMD-Vi:   DEV_RANGE_END		 devid: 00:00.2
[    1.405628] AMD-Vi:   DEV_SELECT			 devid: 00:02.0 flags: 00
[    1.405630] AMD-Vi:   DEV_SELECT			 devid: 01:00.0 flags: 00
[    1.405632] AMD-Vi:   DEV_SELECT			 devid: 00:04.0 flags: 00
[    1.405634] AMD-Vi:   DEV_SELECT			 devid: 02:00.0 flags: 00
[    1.405637] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 03:01.0 flags: 00 devid_to: 03:00.0
[    1.405639] AMD-Vi:   DEV_RANGE_END		 devid: 05:1f.7
[    1.405652] AMD-Vi:   DEV_SELECT			 devid: 00:09.0 flags: 00
[    1.405654] AMD-Vi:   DEV_SELECT			 devid: 06:00.0 flags: 00
[    1.405656] AMD-Vi:   DEV_SELECT			 devid: 00:0a.0 flags: 00
[    1.405658] AMD-Vi:   DEV_SELECT			 devid: 07:00.0 flags: 00
[    1.405660] AMD-Vi:   DEV_SELECT			 devid: 00:0b.0 flags: 00
[    1.405662] AMD-Vi:   DEV_SELECT			 devid: 08:00.0 flags: 00
[    1.405664] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 09:01.0 flags: 00 devid_to: 09:00.0
[    1.405667] AMD-Vi:   DEV_RANGE_END		 devid: 09:1f.7
[    1.405672] AMD-Vi:   DEV_SELECT			 devid: 00:11.0 flags: 00
[    1.405674] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:12.0 flags: 00
[    1.405677] AMD-Vi:   DEV_RANGE_END		 devid: 00:12.2
[    1.405679] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:13.0 flags: 00
[    1.405681] AMD-Vi:   DEV_RANGE_END		 devid: 00:13.2
[    1.405683] AMD-Vi:   DEV_SELECT			 devid: 00:14.0 flags: d7
[    1.405685] AMD-Vi:   DEV_SELECT			 devid: 00:14.1 flags: 00
[    1.405687] AMD-Vi:   DEV_SELECT			 devid: 00:14.2 flags: 00
[    1.405689] AMD-Vi:   DEV_SELECT			 devid: 00:14.3 flags: 00
[    1.405691] AMD-Vi:   DEV_SELECT			 devid: 00:14.4 flags: 00
[    1.405693] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 0a:00.0 flags: 00 devid_to: 00:14.4
[    1.405696] AMD-Vi:   DEV_RANGE_END		 devid: 0a:1f.7
[    1.405701] AMD-Vi:   DEV_SELECT			 devid: 00:14.5 flags: 00
[    1.405703] AMD-Vi:   DEV_SELECT			 devid: 00:15.0 flags: 00
[    1.405705] AMD-Vi:   DEV_SELECT			 devid: 0b:00.0 flags: 00
[    1.405707] AMD-Vi:   DEV_SELECT			 devid: 00:15.1 flags: 00
[    1.405709] AMD-Vi:   DEV_SELECT			 devid: 0c:00.0 flags: 00
[    1.405711] AMD-Vi:   DEV_SELECT			 devid: 00:15.2 flags: 00
[    1.405713] AMD-Vi:   DEV_SELECT			 devid: 0d:00.0 flags: 00
[    1.405715] AMD-Vi:   DEV_SELECT			 devid: 00:15.3 flags: 00
[    1.405717] AMD-Vi:   DEV_SELECT			 devid: 0e:00.0 flags: 00
[    1.405719] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 0f:01.0 flags: 00 devid_to: 0f:00.0
[    1.405722] AMD-Vi:   DEV_RANGE_END		 devid: 12:1f.7
[    1.405739] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:16.0 flags: 00
[    1.405741] AMD-Vi:   DEV_RANGE_END		 devid: 00:16.2
[    1.405743] AMD-Vi:   DEV_SPECIAL(IOAPIC[9])		devid: 00:14.0
[    1.405746] AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
[    1.405748] AMD-Vi:   DEV_SPECIAL(IOAPIC[10])		devid: 00:00.1
[    1.481658] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.481669] pci 0000:00:00.2: irq 26 for MSI/MSI-X
[    1.491436] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.566095] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.566099] software IO TLB [mem 0xa6400000-0xaa400000] (64MB) mapped at [ffff8800a6400000-ffff8800aa3fffff]
[    1.566447] perf: AMD NB counters detected
[    1.566510] microcode: CPU0: patch_level=0x0600063d
[    1.566517] microcode: CPU1: patch_level=0x0600063d
[    1.566529] microcode: CPU2: patch_level=0x0600063d
[    1.566541] microcode: CPU3: patch_level=0x0600063d
[    1.566550] microcode: CPU4: patch_level=0x0600063d
[    1.566561] microcode: CPU5: patch_level=0x0600063d
[    1.566570] microcode: CPU6: patch_level=0x0600063d
[    1.566581] microcode: CPU7: patch_level=0x0600063d
[    1.566641] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    1.566649] LVT offset 0 assigned for vector 0x400
[    1.566669] perf: AMD IBS detected (0x000000ff)
[    1.567117] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    1.567149] Initialise system trusted keyring
[    1.567386] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.568684] zpool: loaded
[    1.568686] zbud: loaded
[    1.568828] VFS: Disk quotas dquot_6.5.2
[    1.568858] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.569146] msgmni has been set to 32004
[    1.569393] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.569398] io scheduler noop registered
[    1.569401] io scheduler deadline registered
[    1.569425] io scheduler cfq registered (default)
[    1.570111] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.570126] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.570168] vesafb: mode is 1280x1024x16, linelength=2560, pages=0
[    1.570170] vesafb: scrolling: redraw
[    1.570173] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    1.570199] vesafb: framebuffer at 0xb0000000, mapped to 0xffffc90000080000, using 2560k, total 2560k
[    1.585562] Console: switching to colour frame buffer device 160x64
[    1.600966] fb0: VESA VGA frame buffer device
[    1.601078] GHES: HEST is not enabled!
[    1.601171] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.621762] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.622336] Non-volatile memory driver v1.3
[    1.622408] Linux agpgart interface v0.103
[    1.623117] ahci 0000:00:11.0: version 3.0
[    1.623234] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    1.623375] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    1.624008] scsi host0: ahci
[    1.624156] scsi host1: ahci
[    1.624276] scsi host2: ahci
[    1.624395] scsi host3: ahci
[    1.624482] ata1: SATA max UDMA/133 abar m1024@0xd870b000 port 0xd870b100 irq 19
[    1.624611] ata2: SATA max UDMA/133 abar m1024@0xd870b000 port 0xd870b180 irq 19
[    1.624740] ata3: SATA max UDMA/133 abar m1024@0xd870b000 port 0xd870b200 irq 19
[    1.624869] ata4: SATA max UDMA/133 abar m1024@0xd870b000 port 0xd870b280 irq 19
[    1.625099] ahci 0000:07:00.0: irq 30 for MSI/MSI-X
[    1.625135] ahci 0000:07:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.625277] ahci 0000:07:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.625686] scsi host4: ahci
[    1.625807] scsi host5: ahci
[    1.625894] ata5: SATA max UDMA/133 abar m512@0xde010000 port 0xde010100 irq 30
[    1.626022] ata6: SATA max UDMA/133 abar m512@0xde010000 port 0xde010180 irq 30
[    1.626224] ahci 0000:0d:00.0: irq 31 for MSI/MSI-X
[    1.626261] ahci 0000:0d:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.626402] ahci 0000:0d:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.626831] scsi host6: ahci
[    1.626954] scsi host7: ahci
[    1.627041] ata7: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10100 irq 31
[    1.627169] ata8: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10180 irq 31
[    1.627323] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.627440] ehci-pci: EHCI PCI platform driver
[    1.627589] QUIRK: Enable AMD PLL fix
[    1.627608] ehci-pci 0000:00:12.2: EHCI Host Controller
[    1.627702] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    1.627833] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.627991] ehci-pci 0000:00:12.2: debug port 1
[    1.628096] ehci-pci 0000:00:12.2: irq 17, io mem 0xd8709000
[    1.636836] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.636974] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.637091] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.637216] usb usb1: Product: EHCI Host Controller
[    1.641608] usb usb1: Manufacturer: Linux 3.18.7-lcrs ehci_hcd
[    1.645967] usb usb1: SerialNumber: 0000:00:12.2
[    1.650377] hub 1-0:1.0: USB hub found
[    1.654685] hub 1-0:1.0: 5 ports detected
[    1.659156] ehci-pci 0000:00:13.2: EHCI Host Controller
[    1.663435] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    1.667741] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.672085] ehci-pci 0000:00:13.2: debug port 1
[    1.676441] ehci-pci 0000:00:13.2: irq 17, io mem 0xd8707000
[    1.690147] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.694487] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.698831] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.703157] usb usb2: Product: EHCI Host Controller
[    1.707432] usb usb2: Manufacturer: Linux 3.18.7-lcrs ehci_hcd
[    1.711731] usb usb2: SerialNumber: 0000:00:13.2
[    1.716112] hub 2-0:1.0: USB hub found
[    1.720420] hub 2-0:1.0: 5 ports detected
[    1.724876] ehci-pci 0000:00:16.2: EHCI Host Controller
[    1.729150] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 3
[    1.733441] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.737784] ehci-pci 0000:00:16.2: debug port 1
[    1.742100] ehci-pci 0000:00:16.2: irq 17, io mem 0xd8704000
[    1.753448] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    1.757711] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.761938] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.766157] usb usb3: Product: EHCI Host Controller
[    1.770374] usb usb3: Manufacturer: Linux 3.18.7-lcrs ehci_hcd
[    1.774590] usb usb3: SerialNumber: 0000:00:16.2
[    1.778827] hub 3-0:1.0: USB hub found
[    1.782935] hub 3-0:1.0: 4 ports detected
[    1.787137] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.791248] uhci_hcd: USB Universal Host Controller Interface driver
[    1.795386] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.799488] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.803880] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.808266] mousedev: PS/2 mouse device common for all mice
[    1.812730] rtc_cmos 00:05: RTC can wake from S4
[    1.817188] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.821637] rtc_cmos 00:05: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.826719] ledtrig-cpu: registered to indicate activity on CPUs
[    1.831335] hidraw: raw HID events driver (C) Jiri Kosina
[    1.835988] usbcore: registered new interface driver usbhid
[    1.840546] usbhid: USB HID core driver
[    1.845094] TCP: cubic registered
[    1.849658] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.854424] NET: Registered protocol family 10
[    1.859304] Key type dns_resolver registered
[    1.864349] Loading compiled-in X.509 certificates
[    1.868980] registered taskstats version 1
[    1.874284]   Magic number: 3:668:887
[    1.878909] graphics fb0: hash matches
[    1.883528] rtc_cmos 00:05: setting system clock to 2015-02-13 13:51:53 UTC (1423835513)
[    1.936692] ata6: SATA link down (SStatus 0 SControl 300)
[    1.943397] ata5: SATA link down (SStatus 0 SControl 300)
[    2.106608] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.109951] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.111150] ata8.00: ATA-6: ST3500320NS, SN04, max UDMA/133
[    2.111152] ata8.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.123278] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.124394] ata8.00: configured for UDMA/133
[    2.134313] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.138976] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.143597] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.152316] ata7.00: ATA-8: ST3500320NS, SN06, max UDMA/133
[    2.156840] ata7.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.187648] ata4.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    2.192226] ata4.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.196881] ata2.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    2.201530] ata2.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.203761] ata7.00: configured for UDMA/133
[    2.210847] ata1.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[    2.215473] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.220166] ata3.00: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
[    2.224881] ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.259166] ata3.00: configured for UDMA/133
[    2.263860] ata2.00: configured for UDMA/133
[    2.268472] ata1.00: configured for UDMA/133
[    2.273039] ata4.00: configured for UDMA/133
[    2.273097] scsi 0:0:0:0: Direct-Access     ATA      ST3160815AS      B    PQ: 0 ANSI: 5
[    2.273274] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.273331] scsi 1:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.273474] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.273523] sd 0:0:0:0: [sda] Write Protect is off
[    2.273524] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.273533] sd 1:0:0:0: [sdb] Write Protect is off
[    2.273534] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.273559] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.273590] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.279888] scsi 2:0:0:0: Direct-Access     ATA      ST3160811AS      E    PQ: 0 ANSI: 5
[    2.280021] sd 2:0:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.280070] sd 2:0:0:0: [sdc] Write Protect is off
[    2.280071] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.280080] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.346529] scsi 3:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.351423] sd 3:0:0:0: [sdd] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.356284] sd 3:0:0:0: [sdd] Write Protect is off
[    2.356296] scsi 6:0:0:0: Direct-Access     ATA      ST3500320NS      SN06 PQ: 0 ANSI: 5
[    2.356480] sd 6:0:0:0: [sde] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    2.356524] sd 6:0:0:0: [sde] Write Protect is off
[    2.356526] sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    2.356543] sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.365408]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 >
[    2.365739] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.365779] scsi 7:0:0:0: Direct-Access     ATA      ST3500320NS      SN04 PQ: 0 ANSI: 5
[    2.365915] sd 7:0:0:0: [sdf] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    2.365955] sd 7:0:0:0: [sdf] Write Protect is off
[    2.365956] sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    2.365973] sd 7:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.366136]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
[    2.366442] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.368453]  sde: sde1
[    2.368613] sd 6:0:0:0: [sde] Attached SCSI disk
[    2.375043]  sdf: sdf1
[    2.375206] sd 7:0:0:0: [sdf] Attached SCSI disk
[    2.376073]  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 >
[    2.376351] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.447327] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.447345] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.538476]  sdd: sdd1 sdd2 sdd3 < sdd5 sdd6 sdd7 >
[    2.543528] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.549125] Freeing unused kernel memory: 964K (ffffffff80cb2000 - ffffffff80da3000)
[    2.553976] Write protecting the kernel read-only data: 10240k
[    2.559328] Freeing unused kernel memory: 208K (ffff8800007cc000 - ffff880000800000)
[    2.566356] tsc: Refined TSC clocksource calibration: 3616.533 MHz
[    2.571582] Freeing unused kernel memory: 1292K (ffff880000abd000 - ffff880000c00000)
[    2.578219] random: systemd urandom read with 73 bits of entropy available
[    2.583435] systemd[1]: systemd 210 running in system mode. (+PAM -LIBWRAP +AUDIT +SELINUX -IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ +SECCOMP +APPARMOR)
[    2.589005] systemd[1]: Detected architecture 'x86-64'.
[    2.594310] systemd[1]: Running in initial RAM disk.
[    2.616347] systemd[1]: Inserted module 'autofs4'
[    2.621888] systemd[1]: Set hostname to <harley>.
[    2.681022] systemd[1]: Expecting device dev-disk-by\x2did-ata\x2dST3160815AS_6RACD7A6\x2dpart5.device...
[    2.692186] systemd[1]: Starting Timers.
[    2.703356] systemd[1]: Reached target Timers.
[    2.708894] systemd[1]: Starting -.slice.
[    2.719907] systemd[1]: Created slice -.slice.
[    2.725380] systemd[1]: Starting udev Control Socket.
[    2.736302] systemd[1]: Listening on udev Control Socket.
[    2.741833] systemd[1]: Starting udev Kernel Socket.
[    2.753058] systemd[1]: Listening on udev Kernel Socket.
[    2.758696] systemd[1]: Starting Journal Socket.
[    2.769870] systemd[1]: Listening on Journal Socket.
[    2.775401] systemd[1]: Starting Sockets.
[    2.786438] systemd[1]: Reached target Sockets.
[    2.791971] systemd[1]: Starting System Slice.
[    2.803092] systemd[1]: Created slice System Slice.
[    2.808586] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    2.819630] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    2.825197] systemd[1]: Starting dracut cmdline hook...
[    2.836430] systemd[1]: Starting Load Kernel Modules...
[    2.847576] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    2.853309] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.853349] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.853378] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    2.853404] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    2.853435] sd 6:0:0:0: Attached scsi generic sg4 type 0
[    2.853468] sd 7:0:0:0: Attached scsi generic sg5 type 0
[    2.891166] systemd[1]: Starting Journal Service...
[    2.906853] systemd[1]: Started Journal Service.
[    3.187764] wmi: Mapper loaded
[    3.188257] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    3.188465] ACPI: Power Button [PWRB]
[    3.188601] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    3.188810] ACPI: Power Button [PWRF]
[    3.198439] ohci-pci: OHCI PCI platform driver
[    3.198650] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    3.198760] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[    3.198924] ohci-pci 0000:00:12.0: irq 18, io mem 0xd870a000
[    3.230152] random: nonblocking pool is initialized
[    3.256759] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.256879] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.257004] usb usb4: Product: OHCI PCI host controller
[    3.257093] usb usb4: Manufacturer: Linux 3.18.7-lcrs ohci_hcd
[    3.257193] usb usb4: SerialNumber: 0000:00:12.0
[    3.257404] hub 4-0:1.0: USB hub found
[    3.257476] hub 4-0:1.0: 5 ports detected
[    3.257782] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    3.257882] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
[    3.258026] ohci-pci 0000:00:13.0: irq 18, io mem 0xd8708000
[    3.313417] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.313538] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.313663] usb usb5: Product: OHCI PCI host controller
[    3.313753] usb usb5: Manufacturer: Linux 3.18.7-lcrs ohci_hcd
[    3.313853] usb usb5: SerialNumber: 0000:00:13.0
[    3.314053] hub 5-0:1.0: USB hub found
[    3.314127] hub 5-0:1.0: 5 ports detected
[    3.314426] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    3.314526] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
[    3.314672] ohci-pci 0000:00:14.5: irq 18, io mem 0xd8706000
[    3.370005] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    3.370125] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.370250] usb usb6: Product: OHCI PCI host controller
[    3.370340] usb usb6: Manufacturer: Linux 3.18.7-lcrs ohci_hcd
[    3.370440] usb usb6: SerialNumber: 0000:00:14.5
[    3.370615] hub 6-0:1.0: USB hub found
[    3.370684] hub 6-0:1.0: 2 ports detected
[    3.370924] ohci-pci 0000:00:16.0: OHCI PCI host controller
[    3.371024] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
[    3.371167] ohci-pci 0000:00:16.0: irq 18, io mem 0xd8705000
[    3.426651] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    3.426770] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.426895] usb usb7: Product: OHCI PCI host controller
[    3.426985] usb usb7: Manufacturer: Linux 3.18.7-lcrs ohci_hcd
[    3.427085] usb usb7: SerialNumber: 0000:00:16.0
[    3.427258] hub 7-0:1.0: USB hub found
[    3.427328] hub 7-0:1.0: 4 ports detected
[    3.429097] scsi host8: pata_atiixp
[    3.429841] scsi host9: pata_atiixp
[    3.429940] ata9: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
[    3.430060] ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
[    3.569259] Switched to clocksource tsc
[    3.593328] usb 4-3: new low-speed USB device number 2 using ohci-pci
[    3.606074] ata9.00: ATAPI: SONY    DVD RW AD-7260S, 1.61, max UDMA/100
[    3.606440] ata9.01: ATA-8: ST3500418AS, CC38, max UDMA/133
[    3.606536] ata9.01: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    3.606653] ata9.00: limited to UDMA/33 due to 40-wire cable
[    3.606751] ata9.01: limited to UDMA/33 due to 40-wire cable
[    3.619395] ata9.00: configured for UDMA/33
[    3.632916] ata9.01: configured for UDMA/33
[    3.634868] scsi 8:0:0:0: CD-ROM            SONY     DVD RW AD-7260S  1.61 PQ: 0 ANSI: 5
[    3.650083] scsi 8:0:0:0: Attached scsi generic sg6 type 5
[    3.654543] scsi 8:0:1:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5
[    3.659218] sd 8:0:1:0: [sdg] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    3.663787] sd 8:0:1:0: [sdg] Write Protect is off
[    3.668290] sd 8:0:1:0: Attached scsi generic sg7 type 0
[    3.668483] sd 8:0:1:0: [sdg] Mode Sense: 00 3a 00 00
[    3.668497] sd 8:0:1:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.676980]  sdg: sdg1
[    3.677122] sd 8:0:1:0: [sdg] Attached SCSI disk
[    3.697442] sr 8:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    3.701947] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.706611] sr 8:0:0:0: Attached scsi CD-ROM sr0
[    3.755464] usb 4-3: New USB device found, idVendor=046d, idProduct=c00e
[    3.760058] usb 4-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.764610] usb 4-3: Product: USB-PS/2 Optical Mouse
[    3.769181] usb 4-3: Manufacturer: Logitech
[    3.780678] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-3/4-3:1.0/0003:046D:C00E.0001/input/input3
[    3.786111] hid-generic 0003:046D:C00E.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:12.0-3/input0
[    4.351204] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
[    4.646387] systemd-journald[224]: Received SIGTERM from PID 1 (systemd).
[    6.948374] device-mapper: uevent: version 1.0.3
[    6.953588] device-mapper: ioctl: 4.28.0-ioctl (2014-09-17) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    8.976691] EXT4-fs (sda5): re-mounted. Opts: acl,user_xattr
[   10.019230] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   10.078143] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   10.082238] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[   10.494425] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   10.644444] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   10.648424] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 8
[   10.652513] xhci_hcd 0000:06:00.0: irq 33 for MSI/MSI-X
[   10.652583] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[   10.656611] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.660634] usb usb8: Product: xHCI Host Controller
[   10.664639] usb usb8: Manufacturer: Linux 3.18.7-lcrs xhci-hcd
[   10.668675] usb usb8: SerialNumber: 0000:06:00.0
[   10.672900] hub 8-0:1.0: USB hub found
[   10.676949] hub 8-0:1.0: 2 ports detected
[   10.681098] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   10.681121] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   10.681124] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 9
[   10.681169] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[   10.681170] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.681171] usb usb9: Product: xHCI Host Controller
[   10.681172] usb usb9: Manufacturer: Linux 3.18.7-lcrs xhci-hcd
[   10.681173] usb usb9: SerialNumber: 0000:06:00.0
[   10.681259] hub 9-0:1.0: USB hub found
[   10.681269] hub 9-0:1.0: 2 ports detected
[   10.681421] xhci_hcd 0000:0c:00.0: xHCI Host Controller
[   10.681424] xhci_hcd 0000:0c:00.0: new USB bus registered, assigned bus number 10
[   10.681612] xhci_hcd 0000:0c:00.0: irq 34 for MSI/MSI-X
[   10.681709] usb usb10: New USB device found, idVendor=1d6b, idProduct=0002
[   10.681710] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.681711] usb usb10: Product: xHCI Host Controller
[   10.681711] usb usb10: Manufacturer: Linux 3.18.7-lcrs xhci-hcd
[   10.681712] usb usb10: SerialNumber: 0000:0c:00.0
[   10.681796] hub 10-0:1.0: USB hub found
[   10.681806] hub 10-0:1.0: 2 ports detected
[   10.681906] xhci_hcd 0000:0c:00.0: xHCI Host Controller
[   10.681908] xhci_hcd 0000:0c:00.0: new USB bus registered, assigned bus number 11
[   10.681953] usb usb11: New USB device found, idVendor=1d6b, idProduct=0003
[   10.681954] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.681955] usb usb11: Product: xHCI Host Controller
[   10.681956] usb usb11: Manufacturer: Linux 3.18.7-lcrs xhci-hcd
[   10.681957] usb usb11: SerialNumber: 0000:0c:00.0
[   10.682036] hub 11-0:1.0: USB hub found
[   10.682045] hub 11-0:1.0: 2 ports detected
[   10.796854] r8169 0000:0b:00.0: can't disable ASPM; OS doesn't have ASPM control
[   10.801702] r8169 0000:0b:00.0: irq 35 for MSI/MSI-X
[   10.801918] r8169 0000:0b:00.0 eth0: RTL8168evl/8111evl at 0xffffc90000044000, 74:d4:35:1f:b2:9e, XID 0c900800 IRQ 35
[   10.806546] r8169 0000:0b:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   11.050494] 3c59x: Donald Becker and others.
[   11.055167] 0000:10:05.0: 3Com PCI 3c905C Tornado at ffffc9000004a000.
[   11.789520] [drm] Initialized drm 1.1.0 20060810
[   12.019598] sound hdaudioC0D0: autoconfig: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   12.024484] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   12.029356] sound hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   12.034171] sound hdaudioC0D0:    mono: mono_out=0x0
[   12.038928] sound hdaudioC0D0:    dig-out=0x11/0x1e
[   12.043645] sound hdaudioC0D0:    inputs:
[   12.048317] sound hdaudioC0D0:      Front Mic=0x19
[   12.052929] sound hdaudioC0D0:      Rear Mic=0x18
[   12.057479] sound hdaudioC0D0:      Line=0x1a
[   12.062181] AVX version of gcm_enc/dec engaged.
[   12.066682] AES CTR mode by8 optimization enabled
[   12.087224] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input5
[   12.092726] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[   12.097442] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[   12.102206] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[   12.107001] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[   12.111790] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[   12.116560] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[   12.121257] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input12
[   12.313291] EXT4-fs (sdf1): mounted filesystem with ordered data mode. Opts: (null)
[   12.416169] EXT4-fs (sdg1): mounting ext3 file system using the ext4 subsystem
[   12.435483] EXT4-fs (sdg1): mounted filesystem with ordered data mode. Opts: (null)
[   12.510026] EXT4-fs (sde1): mounting ext3 file system using the ext4 subsystem
[   12.536456] EXT4-fs (sde1): mounted filesystem with ordered data mode. Opts: (null)
[   13.290856] EXT4-fs (sdb5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   13.365675] kvm: disabled by bios
[   13.508498] EXT4-fs (sdb7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   13.536957] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   13.590142] EXT4-fs (sdb6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   13.748840] Adding 8385532k swap on /dev/sda2.  Priority:-1 extents:1 across:8385532k FS
[   14.001222] EXT4-fs (sdc5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   14.106905] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   14.146653] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: (null)
[   14.165657] EXT4-fs (sdc7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   14.208877] EXT4-fs (sdc6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   14.241853] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   14.290739] EXT4-fs (sda6): mounted filesystem with ordered data mode. Opts: (null)
[   16.542579] scsi host11: Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec 29320LPE PCIe Ultra320 SCSI adapter>
        aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133MHz, 512 SCBs
[   26.450866] scsi host10: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2930CU SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

[   29.668466] systemd-journald[451]: Received request to flush runtime journal from PID 1
[   40.267446] NET: Registered protocol family 17
[   40.547239] No iBFT detected.
[   40.838962] r8169 0000:0b:00.0 eth0: link down
[   40.838976] r8169 0000:0b:00.0 eth0: link down
[   40.847080] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   40.856056] eth1:  setting full-duplex.
[   42.354652] r8169 0000:0b:00.0 eth0: link up
[   42.358677] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  106.355752] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000073980 flags=0x0070]
[  106.358732] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000739a0 flags=0x0070]
[  106.361870] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000739b0 flags=0x0070]
[  112.352950] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000074d00 flags=0x0070]
[  112.356057] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000074d20 flags=0x0070]
[  112.359142] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000074d30 flags=0x0070]
[  126.588896] AMD-Vi: Using protection domain 1 for device 0000:10:05.0
[  126.591992] ------------[ cut here ]------------
[  126.595107] WARNING: CPU: 4 PID: 0 at drivers/iommu/amd_iommu.c:2637 dma_ops_domain_unmap.part.13+0x65/0x70()
[  126.598408] Modules linked in: iscsi_ibft iscsi_boot_sysfs af_packet kvm crc32_pclmul crc32c_intel aesni_intel snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_controller snd_hda_codec aes_x86_64 drm snd_hwdep snd_pcm glue_helper lrw aic79xx gf128mul ablk_helper cryptd snd_timer 3c59x scsi_transport_spi snd r8169 xhci_pci xhci_hcd serio_raw pcspkr mii tpm_infineon tpm_tis fam15h_power k10temp i2c_piix4 processor thermal_sys shpchp tpm soundcore 8250_fintek dm_mod sr_mod cdrom ata_generic mxm_wmi pata_atiixp ohci_pci wmi button sg autofs4 [last unloaded: aic7xxx]
[  126.613992] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 3.18.7-lcrs #1
[  126.618146] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
[  126.622456]  0000000000000009 ffff88044fd03cb8 ffffffff807bde4d 0000000000000000
[  126.626815]  0000000000000000 ffff88044fd03cf8 ffffffff8024cf7c ffff88044fd03cf8
[  126.631172]  ffff88043cdbc380 0000000000000000 0000000000000600 00000000000702c0
[  126.635504] Call Trace:
[  126.639703]  <IRQ>  [<ffffffff807bde4d>] dump_stack+0x4e/0x71
[  126.644003]  [<ffffffff8024cf7c>] warn_slowpath_common+0x7c/0xa0
[  126.648335]  [<ffffffff8024d045>] warn_slowpath_null+0x15/0x20
[  126.652632]  [<ffffffff806a47e5>] dma_ops_domain_unmap.part.13+0x65/0x70
[  126.656919]  [<ffffffff806a675b>] __unmap_single.isra.16+0x9b/0x100
[  126.661242]  [<ffffffff806a7198>] unmap_page+0x48/0x70
[  126.665572]  [<ffffffffa0157373>] boomerang_rx+0x333/0x600 [3c59x]
[  126.669968]  [<ffffffffa015784a>] boomerang_interrupt+0x16a/0x4f0 [3c59x]
[  126.674400]  [<ffffffff8029600e>] handle_irq_event_percpu+0x3e/0x1e0
[  126.678860]  [<ffffffff802961ec>] handle_irq_event+0x3c/0x60
[  126.683298]  [<ffffffff80298bfe>] handle_fasteoi_irq+0x7e/0x130
[  126.687732]  [<ffffffff8020543d>] handle_irq+0x1d/0x30
[  126.692164]  [<ffffffff80204cee>] do_IRQ+0x4e/0xf0
[  126.696577]  [<ffffffff807c596a>] common_interrupt+0x6a/0x6a
[  126.700873]  <EOI>  [<ffffffff802a6e23>] ? hrtimer_start+0x13/0x20
[  126.705107]  [<ffffffff8020cad7>] ? default_idle+0x17/0x100
[  126.709386]  [<ffffffff8020d4ca>] arch_cpu_idle+0xa/0x10
[  126.713685]  [<ffffffff80281dda>] cpu_startup_entry+0x34a/0x380
[  126.718010]  [<ffffffff80281a91>] ? cpu_startup_entry+0x1/0x380
[  126.722361]  [<ffffffff80233857>] start_secondary+0x157/0x180
[  126.726731] ---[ end trace ace20602a5302afb ]---
[  128.557546] ------------[ cut here ]------------
[  128.560501] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x00000000000766c0 flags=0x0020]
[  128.560502] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076700 flags=0x0020]
[  128.560503] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076740 flags=0x0020]
[  128.560504] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076780 flags=0x0020]
[  128.560505] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076800 flags=0x0020]
[  128.560506] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x00000000000767c0 flags=0x0020]
[  128.560506] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x00000000000768c0 flags=0x0020]
[  128.560507] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076880 flags=0x0020]
[  128.560508] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076840 flags=0x0020]
[  128.560508] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076900 flags=0x0020]
[  128.560509] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076940 flags=0x0020]
[  128.560510] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076980 flags=0x0020]
[  128.560511] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x00000000000769c0 flags=0x0020]
[  128.560511] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076a00 flags=0x0020]
[  128.560512] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076a40 flags=0x0020]
[  128.560513] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076a80 flags=0x0020]
[  128.560513] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076ac0 flags=0x0020]
[  128.560514] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076b40 flags=0x0020]
[  128.560515] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076b00 flags=0x0020]
[  128.560516] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076b60 flags=0x0020]
[  128.560516] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076b70 flags=0x0020]
[  128.560517] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000076b70 flags=0x0020]
[  128.658489] WARNING: CPU: 5 PID: 0 at drivers/iommu/amd_iommu.c:2637 dma_ops_domain_unmap.part.13+0x65/0x70()
[  128.662613] Modules linked in: iscsi_ibft iscsi_boot_sysfs af_packet kvm crc32_pclmul crc32c_intel aesni_intel snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_controller snd_hda_codec aes_x86_64 drm snd_hwdep snd_pcm glue_helper lrw aic79xx gf128mul ablk_helper cryptd snd_timer 3c59x scsi_transport_spi snd r8169 xhci_pci xhci_hcd serio_raw pcspkr mii tpm_infineon tpm_tis fam15h_power k10temp i2c_piix4 processor thermal_sys shpchp tpm soundcore 8250_fintek dm_mod sr_mod cdrom ata_generic mxm_wmi pata_atiixp ohci_pci wmi button sg autofs4 [last unloaded: aic7xxx]
[  128.680917] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W      3.18.7-lcrs #1
[  128.685830] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
[  128.690782]  0000000000000009 ffff88044fd43cb8 ffffffff807bde4d 0000000000000000
[  128.695763]  0000000000000000 ffff88044fd43cf8 ffffffff8024cf7c ffff88043b0ed800
[  128.700633]  ffff88043cdbc0c0 0000000000000000 0000000000000600 0000000000018840
[  128.705378] Call Trace:
[  128.709897]  <IRQ>  [<ffffffff807bde4d>] dump_stack+0x4e/0x71
[  128.714327]  [<ffffffff8024cf7c>] warn_slowpath_common+0x7c/0xa0
[  128.718614]  [<ffffffff8024d045>] warn_slowpath_null+0x15/0x20
[  128.722783]  [<ffffffff806a47e5>] dma_ops_domain_unmap.part.13+0x65/0x70
[  128.726897]  [<ffffffff806a675b>] __unmap_single.isra.16+0x9b/0x100
[  128.730921]  [<ffffffff806a7198>] unmap_page+0x48/0x70
[  128.734950]  [<ffffffffa0157373>] boomerang_rx+0x333/0x600 [3c59x]
[  128.738959]  [<ffffffffa015784a>] boomerang_interrupt+0x16a/0x4f0 [3c59x]
[  128.742926]  [<ffffffff8029600e>] handle_irq_event_percpu+0x3e/0x1e0
[  128.746880]  [<ffffffff802961ec>] handle_irq_event+0x3c/0x60
[  128.750781]  [<ffffffff80298bfe>] handle_fasteoi_irq+0x7e/0x130
[  128.754693]  [<ffffffff8020543d>] handle_irq+0x1d/0x30
[  128.758567]  [<ffffffff80204cee>] do_IRQ+0x4e/0xf0
[  128.762413]  [<ffffffff807c596a>] common_interrupt+0x6a/0x6a
[  128.766265]  <EOI>  [<ffffffff802a6e23>] ? hrtimer_start+0x13/0x20
[  128.770160]  [<ffffffff8020cad7>] ? default_idle+0x17/0x100
[  128.774066]  [<ffffffff8020d4ca>] arch_cpu_idle+0xa/0x10
[  128.777943]  [<ffffffff80281dda>] cpu_startup_entry+0x34a/0x380
[  128.781847]  [<ffffffff802b2cb3>] ? clockevents_register_device+0xe3/0x150
[  128.785796]  [<ffffffff80233857>] start_secondary+0x157/0x180
[  128.789749] ---[ end trace ace20602a5302afc ]---
[  128.793719] ------------[ cut here ]------------
[  128.797684] WARNING: CPU: 5 PID: 0 at drivers/iommu/amd_iommu.c:2637 dma_ops_domain_unmap.part.13+0x65/0x70()
[  128.801802] Modules linked in: iscsi_ibft iscsi_boot_sysfs af_packet kvm crc32_pclmul crc32c_intel aesni_intel snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_controller snd_hda_codec aes_x86_64 drm snd_hwdep snd_pcm glue_helper lrw aic79xx gf128mul ablk_helper cryptd snd_timer 3c59x scsi_transport_spi snd r8169 xhci_pci xhci_hcd serio_raw pcspkr mii tpm_infineon tpm_tis fam15h_power k10temp i2c_piix4 processor thermal_sys shpchp tpm soundcore 8250_fintek dm_mod sr_mod cdrom ata_generic mxm_wmi pata_atiixp ohci_pci wmi button sg autofs4 [last unloaded: aic7xxx]
[  128.820266] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W      3.18.7-lcrs #1
[  128.825113] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
[  128.830069]  0000000000000009 ffff88044fd43cb8 ffffffff807bde4d 0000000000000000
[  128.835083]  0000000000000000 ffff88044fd43cf8 ffffffff8024cf7c 0000000000000600
[  128.839959]  ffff88043cdbc3b0 0000000000000000 0000000000000600 00000000000766c0
[  128.844908] Call Trace:
[  128.849859]  <IRQ>  [<ffffffff807bde4d>] dump_stack+0x4e/0x71
[  128.854950]  [<ffffffff8024cf7c>] warn_slowpath_common+0x7c/0xa0
[  128.860112]  [<ffffffff8024d045>] warn_slowpath_null+0x15/0x20
[  128.865305]  [<ffffffff806a47e5>] dma_ops_domain_unmap.part.13+0x65/0x70
[  128.870579]  [<ffffffff806a675b>] __unmap_single.isra.16+0x9b/0x100
[  128.875909]  [<ffffffff806a7198>] unmap_page+0x48/0x70
[  128.881275]  [<ffffffffa0157373>] boomerang_rx+0x333/0x600 [3c59x]
[  128.886716]  [<ffffffffa015784a>] boomerang_interrupt+0x16a/0x4f0 [3c59x]
[  128.892218]  [<ffffffff8029600e>] handle_irq_event_percpu+0x3e/0x1e0
[  128.897779]  [<ffffffff802961ec>] handle_irq_event+0x3c/0x60
[  128.903360]  [<ffffffff80298bfe>] handle_fasteoi_irq+0x7e/0x130
[  128.908988]  [<ffffffff8020543d>] handle_irq+0x1d/0x30
[  128.914645]  [<ffffffff80204cee>] do_IRQ+0x4e/0xf0
[  128.920336]  [<ffffffff807c596a>] common_interrupt+0x6a/0x6a
[  128.926092]  <EOI>  [<ffffffff802a6e23>] ? hrtimer_start+0x13/0x20
[  128.931943]  [<ffffffff8020cad7>] ? default_idle+0x17/0x100
[  128.937858]  [<ffffffff8020d4ca>] arch_cpu_idle+0xa/0x10
[  128.943815]  [<ffffffff80281dda>] cpu_startup_entry+0x34a/0x380
[  128.949832]  [<ffffffff802b2cb3>] ? clockevents_register_device+0xe3/0x150
[  128.955935]  [<ffffffff80233857>] start_secondary+0x157/0x180
[  128.961925] ---[ end trace ace20602a5302afd ]---
[  130.344563] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000077240 flags=0x0020]
[  130.350437] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000077260 flags=0x0020]
[  130.356094] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000077270 flags=0x0020]
[  132.343625] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000078a00 flags=0x0020]
[  132.349137] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000078a20 flags=0x0020]
[  132.349138] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000078a30 flags=0x0020]
[  134.342698] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000079cc0 flags=0x0020]
[  134.348385] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000079ce0 flags=0x0020]
[  134.354179] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x0000000000079cf0 flags=0x0020]
[  136.341761] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007be40 flags=0x0020]
[  136.347463] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007be70 flags=0x0020]
[  136.353100] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007be60 flags=0x0020]
[  138.340828] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007d9c0 flags=0x0020]
[  138.346589] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007d9e0 flags=0x0020]
[  138.352461] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007d9f0 flags=0x0020]

--------------010902090405020809060707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010902090405020809060707--
