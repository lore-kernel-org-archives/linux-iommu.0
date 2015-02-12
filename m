From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: Kernel Oops: iommu related?
Date: Thu, 12 Feb 2015 14:37:34 -0500
Message-ID: <54DD00FE.2050009@compro.net>
References: <54DCE8A6.4000608@compro.net> <20150212180846.GD29106@8bytes.org>
	<54DCF024.30309@compro.net>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060204060603030300090106"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54DCF024.30309-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
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
--------------060204060603030300090106
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2015 01:25 PM, Mark Hounschell wrote:
> On 02/12/2015 01:08 PM, Joerg Roedel wrote:
>> On Thu, Feb 12, 2015 at 12:53:42PM -0500, Mark Hounschell wrote:
>>> This happens immediately after unloading one of our out of kernel GPL
>>> drivers.
>>> The driver has done NOTHING other than load at bootup.  I'm running a
>>> 3.18.7
>>> kernel (x86_64) on an AMD platform. I can't see anything obviously
>>> wrong in our
>>> driver. It works fine when the iommu is disabled. This particular
>>> machine has 7 of
>>> our cards in it. Four in one expansion rack and 3 in another. The 2
>>> PCI expansion
>>> racks use pci-e interface cards installed in the MB.
>>>
>>> Feb 12 10:47:15 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT
>>> device=0f:00.0 domain=0x0000 address=0x00000000000ae640 flags=0x0070]
>>> Feb 12 10:47:15 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT
>>> device=0f:00.0 domain=0x0000 address=0x00000000000ae660 flags=0x0070]
>>> Feb 12 10:47:15 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT
>>> device=0f:00.0 domain=0x0000 address=0x00000000000ae670 flags=0x0070]
>>> Feb 12 10:47:27 harley kernel: ------------[ cut here ]------------
>>> Feb 12 10:47:27 harley kernel: WARNING: CPU: 3 PID: 0 at
>>> drivers/iommu/amd_iommu.c:2637 dma_ops_domain_unmap.part.13+0x65/0x70()
>>
>> This warning indicates that some driver is unmapping a dma range that
>> was not mapped previously (meaning that a pte in the io-page-tables is
>> zeroed out).
>> The reason for this (and the IO_PAGE_FAULTs) you see are almost
>> certainly because some driver does not use the DMA-API correctly.
>>
>>
>
> I wonder what driver that could be. It certainly isn't the one that I
> just unloaded
> as it for sure has not done anything dma realated. I'm pretty sure I
> uninstalled all
> our other drivers but will go back and verify.
>

I've cleaned the machine of all our drivers and also the nvidia driver. 
If the problem is as you say, it is an in-kernel driver. I've attached a 
dmesg taken after it started. I used the dgap driver from the staging 
directory to unload and trigger this as I have one. That driver does NO 
dma. I know because I'm one of the maintainers and have done lots of 
work on it.

Thanks
Mark


--------------060204060603030300090106
Content-Type: text/plain; charset=UTF-8;
 name="d.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="d.dmesg"

[    0.000000] Linux version 3.18.7-lcrs (root@harley) (gcc version 4.8.3 20140627 [gcc-4_8-branch revision 212064] (SUSE Linux) ) #1 SMP PREEMPT Wed Feb 11 15:38:40 EST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.18.7-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G audit=0 nohz=on nohz_full=4,5,6,7 rcu_nocbs=4,5,6,7 3
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
[    0.000000] RAMDISK: [mem 0x370c8000-0x3785bfff]
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
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.18.7-lcrs root=/dev/disk/by-id/ata-ST3160815AS_6RACD7A6-part5 splash=verbose showopts video=1600x1200 noresume apm=off vmalloc=256M cma=64M@0-4G audit=0 nohz=on nohz_full=4,5,6,7 rcu_nocbs=4,5,6,7 3
[    0.000000] audit: disabled (until reboot)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] Memory: 16313024K/16753392K available (5924K kernel code, 705K rwdata, 2804K rodata, 964K init, 1176K bss, 440368K reserved)
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
[    0.000000] tsc: Detected 3616.850 MHz processor
[    0.000019] Calibrating delay loop (skipped), value calculated using timer frequency.. 7236.10 BogoMIPS (lpj=12056166)
[    0.000023] pid_max: default: 32768 minimum: 301
[    0.000028] ACPI: Core revision 20140926
[    0.003342] ACPI: All ACPI Tables successfully acquired
[    0.006243] Security Framework initialized
[    0.006277] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.006281] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.006532] CPU: Physical Processor ID: 0
[    0.006534] CPU: Processor Core ID: 0
[    0.006536] mce: CPU supports 7 MCE banks
[    0.006543] LVT offset 1 assigned for vector 0xf9
[    0.006547] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.006618] Freeing SMP alternatives memory: 24K (ffffffff80da3000 - ffffffff80da9000)
[    0.006992] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.039985] smpboot: CPU0: AMD FX(tm)-8150 Eight-Core Processor (fam: 15, model: 01, stepping: 02)
[    0.144042] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.144048] ... version:                0
[    0.144050] ... bit width:              48
[    0.144052] ... generic registers:      6
[    0.144054] ... value mask:             0000ffffffffffff
[    0.144056] ... max period:             00007fffffffffff
[    0.144058] ... fixed-purpose events:   0
[    0.144059] ... event mask:             000000000000003f
[    0.164102] x86: Booting SMP configuration:
[    0.164106] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.289017] x86: Booted up 1 node, 8 CPUs
[    0.289023] smpboot: Total of 8 processors activated (57892.83 BogoMIPS)
[    0.301410] devtmpfs: initialized
[    0.301615] PM: Registering ACPI NVS region [mem 0xaea39000-0xaee34fff] (4177920 bytes)
[    0.301662] PM: Registering ACPI NVS region [mem 0xaf156000-0xaf35bfff] (2121728 bytes)
[    0.302202] RTC time: 19:20:16, date: 02/12/15
[    0.303366] NET: Registered protocol family 16
[    0.307286] cpuidle: using governor ladder
[    0.313947] cpuidle: using governor menu
[    0.314026] ACPI: bus type PCI registered
[    0.314029] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.314083] PCI: Using configuration type 1 for base access
[    0.314085] PCI: Using configuration type 1 for extended access
[    0.320943] ACPI: Added _OSI(Module Device)
[    0.320946] ACPI: Added _OSI(Processor Device)
[    0.320949] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.320951] ACPI: Added _OSI(Processor Aggregator Device)
[    0.322596] ACPI: Executed 3 blocks of module-level executable AML code
[    0.331018] ACPI: Interpreter enabled
[    0.331025] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20140926/hwxface-580)
[    0.331031] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20140926/hwxface-580)
[    0.331045] ACPI: (supports S0 S3 S4 S5)
[    0.331048] ACPI: Using IOAPIC for interrupt routing
[    0.331201] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.393340] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.393347] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.393353] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.393817] PCI host bridge to bus 0000:00
[    0.393821] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.393824] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    0.393827] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    0.393830] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    0.393832] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.393835] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.393838] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.393841] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xdfffffff]
[    0.393852] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.393968] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    0.394069] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.394103] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.394151] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.394187] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.394222] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.394269] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.394308] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    0.394341] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.394387] pci 0000:00:09.0: System wakeup disabled by ACPI
[    0.394422] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    0.394454] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.394501] pci 0000:00:0a.0: System wakeup disabled by ACPI
[    0.394535] pci 0000:00:0b.0: [1002:5a1f] type 01 class 0x060400
[    0.394569] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
[    0.394615] pci 0000:00:0b.0: System wakeup disabled by ACPI
[    0.394660] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.394674] pci 0000:00:11.0: reg 0x10: [io  0xf090-0xf097]
[    0.394681] pci 0000:00:11.0: reg 0x14: [io  0xf080-0xf083]
[    0.394688] pci 0000:00:11.0: reg 0x18: [io  0xf070-0xf077]
[    0.394695] pci 0000:00:11.0: reg 0x1c: [io  0xf060-0xf063]
[    0.394702] pci 0000:00:11.0: reg 0x20: [io  0xf050-0xf05f]
[    0.394709] pci 0000:00:11.0: reg 0x24: [mem 0xd870b000-0xd870b3ff]
[    0.394812] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.394822] pci 0000:00:12.0: reg 0x10: [mem 0xd870a000-0xd870afff]
[    0.394904] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.394944] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.394958] pci 0000:00:12.2: reg 0x10: [mem 0xd8709000-0xd87090ff]
[    0.395019] pci 0000:00:12.2: supports D1 D2
[    0.395020] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.395068] pci 0000:00:12.2: System wakeup disabled by ACPI
[    0.395107] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.395117] pci 0000:00:13.0: reg 0x10: [mem 0xd8708000-0xd8708fff]
[    0.395200] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.395240] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.395254] pci 0000:00:13.2: reg 0x10: [mem 0xd8707000-0xd87070ff]
[    0.395315] pci 0000:00:13.2: supports D1 D2
[    0.395317] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.395363] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.395402] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.395514] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    0.395524] pci 0000:00:14.1: reg 0x10: [io  0xf040-0xf047]
[    0.395531] pci 0000:00:14.1: reg 0x14: [io  0xf030-0xf033]
[    0.395538] pci 0000:00:14.1: reg 0x18: [io  0xf020-0xf027]
[    0.395545] pci 0000:00:14.1: reg 0x1c: [io  0xf010-0xf013]
[    0.395552] pci 0000:00:14.1: reg 0x20: [io  0xf000-0xf00f]
[    0.395567] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.395570] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.395573] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.395575] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.395653] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.395669] pci 0000:00:14.2: reg 0x10: [mem 0xd8700000-0xd8703fff 64bit]
[    0.395719] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.395763] pci 0000:00:14.2: System wakeup disabled by ACPI
[    0.395798] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.395912] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.395978] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.396013] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.396023] pci 0000:00:14.5: reg 0x10: [mem 0xd8706000-0xd8706fff]
[    0.396105] pci 0000:00:14.5: System wakeup disabled by ACPI
[    0.396144] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
[    0.396200] pci 0000:00:15.0: supports D1 D2
[    0.396249] pci 0000:00:15.0: System wakeup disabled by ACPI
[    0.396286] pci 0000:00:15.1: [1002:43a1] type 01 class 0x060400
[    0.396342] pci 0000:00:15.1: supports D1 D2
[    0.396391] pci 0000:00:15.1: System wakeup disabled by ACPI
[    0.396429] pci 0000:00:15.2: [1002:43a2] type 01 class 0x060400
[    0.396486] pci 0000:00:15.2: supports D1 D2
[    0.396534] pci 0000:00:15.2: System wakeup disabled by ACPI
[    0.396572] pci 0000:00:15.3: [1002:43a3] type 01 class 0x060400
[    0.396628] pci 0000:00:15.3: supports D1 D2
[    0.396676] pci 0000:00:15.3: System wakeup disabled by ACPI
[    0.396714] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.396725] pci 0000:00:16.0: reg 0x10: [mem 0xd8705000-0xd8705fff]
[    0.396806] pci 0000:00:16.0: System wakeup disabled by ACPI
[    0.396847] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.396861] pci 0000:00:16.2: reg 0x10: [mem 0xd8704000-0xd87040ff]
[    0.396923] pci 0000:00:16.2: supports D1 D2
[    0.396924] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.396970] pci 0000:00:16.2: System wakeup disabled by ACPI
[    0.397010] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.397086] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.397157] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.397232] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.397306] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.397377] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.397496] pci 0000:01:00.0: [10de:0092] type 00 class 0x030000
[    0.397505] pci 0000:01:00.0: reg 0x10: [mem 0xda000000-0xdaffffff]
[    0.397513] pci 0000:01:00.0: reg 0x14: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.397521] pci 0000:01:00.0: reg 0x1c: [mem 0xd9000000-0xd9ffffff 64bit]
[    0.397527] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.397533] pci 0000:01:00.0: reg 0x30: [mem 0xdb000000-0xdb01ffff pref]
[    0.397601] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.397608] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.397612] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.397614] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.397617] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.397667] pci 0000:02:00.0: [104c:8231] type 01 class 0x060400
[    0.397761] pci 0000:02:00.0: supports D1 D2
[    0.397803] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.397811] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.397815] pci 0000:00:04.0:   bridge window [io  0x6000-0x7fff]
[    0.397817] pci 0000:00:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.397820] pci 0000:00:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.397896] pci 0000:03:04.0: [12d8:8150] type 01 class 0x060400
[    0.398062] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.398070] pci 0000:02:00.0:   bridge window [io  0x6000-0x7fff]
[    0.398074] pci 0000:02:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.398080] pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.398157] pci 0000:04:04.0: [10b5:0480] type 00 class 0x0e8000
[    0.398193] pci 0000:04:04.0: reg 0x10: [mem 0xdd909000-0xdd9093ff]
[    0.398209] pci 0000:04:04.0: reg 0x14: [mem 0xdd000000-0xdd7fffff]
[    0.398225] pci 0000:04:04.0: reg 0x18: [mem 0xdd908000-0xdd90800f]
[    0.398430] pci 0000:04:05.0: [10b5:0480] type 00 class 0x0e8000
[    0.398466] pci 0000:04:05.0: reg 0x10: [mem 0xdd907000-0xdd9073ff]
[    0.398482] pci 0000:04:05.0: reg 0x14: [mem 0xdc800000-0xdcffffff]
[    0.398498] pci 0000:04:05.0: reg 0x18: [mem 0xdd906000-0xdd90600f]
[    0.398703] pci 0000:04:06.0: [10b5:0480] type 00 class 0x0e8000
[    0.398739] pci 0000:04:06.0: reg 0x10: [mem 0xdd905000-0xdd9053ff]
[    0.398755] pci 0000:04:06.0: reg 0x14: [mem 0xdc000000-0xdc7fffff]
[    0.398771] pci 0000:04:06.0: reg 0x18: [mem 0xdd904000-0xdd90400f]
[    0.398982] pci 0000:04:07.0: [10b5:0480] type 00 class 0x0e8000
[    0.399018] pci 0000:04:07.0: reg 0x10: [mem 0xdd903000-0xdd9033ff]
[    0.399034] pci 0000:04:07.0: reg 0x14: [mem 0xdb800000-0xdbffffff]
[    0.399050] pci 0000:04:07.0: reg 0x18: [mem 0xdd902000-0xdd90200f]
[    0.399254] pci 0000:04:08.0: [3388:0022] type 01 class 0x060400
[    0.399406] pci 0000:04:08.0: supports D1 D2
[    0.399407] pci 0000:04:08.0: PME# supported from D0 D1 D2 D3hot
[    0.399463] pci 0000:04:09.0: [1090:4610] type 00 class 0xff0000
[    0.399483] pci 0000:04:09.0: reg 0x10: [io  0x7100-0x713f]
[    0.399498] pci 0000:04:09.0: reg 0x14: [mem 0xdd901000-0xdd901fff]
[    0.399614] pci 0000:04:0a.0: [1090:4360] type 00 class 0x058000
[    0.399636] pci 0000:04:0a.0: reg 0x10: [mem 0xdd900000-0xdd9000ff]
[    0.399652] pci 0000:04:0a.0: reg 0x14: [io  0x7000-0x70ff]
[    0.399667] pci 0000:04:0a.0: reg 0x18: [mem 0xc0000000-0xc3ffffff pref]
[    0.399726] pci 0000:04:0a.0: reg 0x30: [mem 0xdd90a000-0xdd90a7ff pref]
[    0.399812] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.399821] pci 0000:03:04.0:   bridge window [io  0x6000-0x7fff]
[    0.399825] pci 0000:03:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.399832] pci 0000:03:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.399912] pci 0000:05:00.0: [1090:0100] type 00 class 0xff0000
[    0.399938] pci 0000:05:00.0: reg 0x10: [mem 0xdd80a000-0xdd80afff]
[    0.399956] pci 0000:05:00.0: reg 0x14: [mem 0xdd808000-0xdd809fff]
[    0.399975] pci 0000:05:00.0: reg 0x18: [mem 0xdd800000-0xdd807fff]
[    0.400163] pci 0000:04:08.0: PCI bridge to [bus 05]
[    0.400174] pci 0000:04:08.0:   bridge window [io  0x6000-0x6fff]
[    0.400179] pci 0000:04:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.400255] pci 0000:06:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.400271] pci 0000:06:00.0: reg 0x10: [mem 0xde100000-0xde107fff 64bit]
[    0.400341] pci 0000:06:00.0: supports D1 D2
[    0.400342] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.403901] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.403907] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.403955] pci 0000:07:00.0: [1b4b:9172] type 00 class 0x010601
[    0.403965] pci 0000:07:00.0: reg 0x10: [io  0xd040-0xd047]
[    0.403972] pci 0000:07:00.0: reg 0x14: [io  0xd030-0xd033]
[    0.403978] pci 0000:07:00.0: reg 0x18: [io  0xd020-0xd027]
[    0.403984] pci 0000:07:00.0: reg 0x1c: [io  0xd010-0xd013]
[    0.403990] pci 0000:07:00.0: reg 0x20: [io  0xd000-0xd00f]
[    0.403996] pci 0000:07:00.0: reg 0x24: [mem 0xde010000-0xde0101ff]
[    0.404002] pci 0000:07:00.0: reg 0x30: [mem 0xde000000-0xde00ffff pref]
[    0.404036] pci 0000:07:00.0: PME# supported from D3hot
[    0.410561] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.410567] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
[    0.410569] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.410628] pci 0000:08:00.0: [10b5:8114] type 01 class 0x060400
[    0.410648] pci 0000:08:00.0: reg 0x10: [mem 0xddc00000-0xddc01fff]
[    0.410762] pci 0000:08:00.0: PME# supported from D0 D3hot
[    0.410828] pci 0000:08:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.410837] pci 0000:00:0b.0: PCI bridge to [bus 08-09]
[    0.410841] pci 0000:00:0b.0:   bridge window [io  0xc000-0xcfff]
[    0.410843] pci 0000:00:0b.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.410928] pci 0000:09:04.0: [9005:8017] type 00 class 0x010000
[    0.410955] pci 0000:09:04.0: reg 0x10: [io  0xc100-0xc1ff]
[    0.410972] pci 0000:09:04.0: reg 0x14: [mem 0xddb80000-0xddb81fff 64bit]
[    0.410984] pci 0000:09:04.0: reg 0x1c: [io  0xc000-0xc0ff]
[    0.411016] pci 0000:09:04.0: reg 0x30: [mem 0xddb00000-0xddb7ffff pref]
[    0.411150] pci 0000:08:00.0: PCI bridge to [bus 09]
[    0.411158] pci 0000:08:00.0:   bridge window [io  0xc000-0xcfff]
[    0.411162] pci 0000:08:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.411213] pci 0000:0a:06.0: [1090:4610] type 00 class 0xff0000
[    0.411226] pci 0000:0a:06.0: reg 0x10: [io  0xb000-0xb03f]
[    0.411236] pci 0000:0a:06.0: reg 0x14: [mem 0xddf00000-0xddf00fff]
[    0.411342] pci 0000:00:14.4: PCI bridge to [bus 0a] (subtractive decode)
[    0.411346] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.411349] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.411353] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    0.411354] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    0.411355] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    0.411357] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.411358] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.411360] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.411361] pci 0000:00:14.4:   bridge window [mem 0xb0000000-0xdfffffff] (subtractive decode)
[    0.411436] pci 0000:0b:00.0: [10ec:8168] type 00 class 0x020000
[    0.411453] pci 0000:0b:00.0: reg 0x10: [io  0xa000-0xa0ff]
[    0.411477] pci 0000:0b:00.0: reg 0x18: [mem 0xc6004000-0xc6004fff 64bit pref]
[    0.411493] pci 0000:0b:00.0: reg 0x20: [mem 0xc6000000-0xc6003fff 64bit pref]
[    0.411576] pci 0000:0b:00.0: supports D1 D2
[    0.411578] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.411612] pci 0000:0b:00.0: System wakeup disabled by ACPI
[    0.417231] pci 0000:00:15.0: PCI bridge to [bus 0b]
[    0.417237] pci 0000:00:15.0:   bridge window [io  0xa000-0xafff]
[    0.417243] pci 0000:00:15.0:   bridge window [mem 0xc6000000-0xc60fffff 64bit pref]
[    0.417310] pci 0000:0c:00.0: [1b6f:7023] type 00 class 0x0c0330
[    0.417332] pci 0000:0c:00.0: reg 0x10: [mem 0xdde00000-0xdde07fff 64bit]
[    0.417432] pci 0000:0c:00.0: supports D1 D2
[    0.417433] pci 0000:0c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.423892] pci 0000:00:15.1: PCI bridge to [bus 0c]
[    0.423899] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.423966] pci 0000:0d:00.0: [1b4b:9172] type 00 class 0x010601
[    0.423980] pci 0000:0d:00.0: reg 0x10: [io  0x9040-0x9047]
[    0.423988] pci 0000:0d:00.0: reg 0x14: [io  0x9030-0x9033]
[    0.423997] pci 0000:0d:00.0: reg 0x18: [io  0x9020-0x9027]
[    0.424005] pci 0000:0d:00.0: reg 0x1c: [io  0x9010-0x9013]
[    0.424014] pci 0000:0d:00.0: reg 0x20: [io  0x9000-0x900f]
[    0.424022] pci 0000:0d:00.0: reg 0x24: [mem 0xddd10000-0xddd101ff]
[    0.424031] pci 0000:0d:00.0: reg 0x30: [mem 0xddd00000-0xddd0ffff pref]
[    0.424077] pci 0000:0d:00.0: PME# supported from D3hot
[    0.430552] pci 0000:00:15.2: PCI bridge to [bus 0d]
[    0.430559] pci 0000:00:15.2:   bridge window [io  0x9000-0x9fff]
[    0.430562] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.430636] pci 0000:0e:00.0: [104c:8231] type 01 class 0x060400
[    0.430758] pci 0000:0e:00.0: supports D1 D2
[    0.430803] pci 0000:0e:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.430813] pci 0000:00:15.3: PCI bridge to [bus 0e-12]
[    0.430818] pci 0000:00:15.3:   bridge window [io  0x8000-0x8fff]
[    0.430821] pci 0000:00:15.3:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.430825] pci 0000:00:15.3:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.430920] pci 0000:0f:04.0: [12d8:8150] type 01 class 0x060400
[    0.431118] pci 0000:0e:00.0: PCI bridge to [bus 0f-12]
[    0.431126] pci 0000:0e:00.0:   bridge window [io  0x8000-0x8fff]
[    0.431131] pci 0000:0e:00.0:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.431138] pci 0000:0e:00.0:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.431222] pci 0000:10:04.0: [114a:5565] type 00 class 0x028000
[    0.431259] pci 0000:10:04.0: reg 0x10: [mem 0xd8643000-0xd86431ff]
[    0.431277] pci 0000:10:04.0: reg 0x14: [io  0x8100-0x81ff]
[    0.431295] pci 0000:10:04.0: reg 0x18: [mem 0xd8642000-0xd864203f]
[    0.431313] pci 0000:10:04.0: reg 0x1c: [mem 0xd0000000-0xd7ffffff]
[    0.431491] pci 0000:10:05.0: [10b7:9200] type 00 class 0x020000
[    0.431523] pci 0000:10:05.0: reg 0x10: [io  0x8200-0x827f]
[    0.431541] pci 0000:10:05.0: reg 0x14: [mem 0xd8641000-0xd864107f]
[    0.431625] pci 0000:10:05.0: reg 0x30: [mem 0xd8600000-0xd861ffff pref]
[    0.431681] pci 0000:10:05.0: supports D1 D2
[    0.431682] pci 0000:10:05.0: PME# supported from D0 D1 D2 D3hot
[    0.431755] pci 0000:10:07.0: [3388:0022] type 01 class 0x060400
[    0.431930] pci 0000:10:07.0: supports D1 D2
[    0.431932] pci 0000:10:07.0: PME# supported from D0 D1 D2 D3hot
[    0.432010] pci 0000:10:08.0: [3388:0022] type 01 class 0x060400
[    0.432186] pci 0000:10:08.0: supports D1 D2
[    0.432187] pci 0000:10:08.0: PME# supported from D0 D1 D2 D3hot
[    0.432250] pci 0000:10:09.0: [114f:0027] type 00 class 0x078000
[    0.432275] pci 0000:10:09.0: reg 0x10: [mem 0xd8000000-0xd83fffff]
[    0.432376] pci 0000:10:09.0: reg 0x30: [mem 0xd8630000-0xd863ffff pref]
[    0.432441] pci 0000:10:0a.0: [9004:3860] type 00 class 0x010000
[    0.432473] pci 0000:10:0a.0: reg 0x10: [io  0x8000-0x80ff]
[    0.432491] pci 0000:10:0a.0: reg 0x14: [mem 0xd8640000-0xd8640fff]
[    0.432575] pci 0000:10:0a.0: reg 0x30: [mem 0xd8620000-0xd862ffff pref]
[    0.432712] pci 0000:0f:04.0: PCI bridge to [bus 10-12]
[    0.432721] pci 0000:0f:04.0:   bridge window [io  0x8000-0x8fff]
[    0.432726] pci 0000:0f:04.0:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.432735] pci 0000:0f:04.0:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.432835] pci 0000:11:00.0: [1090:4710] type 00 class 0xff0000
[    0.432872] pci 0000:11:00.0: reg 0x10: [mem 0xd8500000-0xd85001ff]
[    0.432893] pci 0000:11:00.0: reg 0x14: [mem 0xc5000000-0xc5ffffff pref]
[    0.433167] pci 0000:10:07.0: PCI bridge to [bus 11]
[    0.433184] pci 0000:10:07.0:   bridge window [mem 0xd8500000-0xd85fffff]
[    0.433194] pci 0000:10:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.433295] pci 0000:12:00.0: [1090:4710] type 00 class 0xff0000
[    0.433333] pci 0000:12:00.0: reg 0x10: [mem 0xd8400000-0xd84001ff]
[    0.433353] pci 0000:12:00.0: reg 0x14: [mem 0xc4000000-0xc4ffffff pref]
[    0.433627] pci 0000:10:08.0: PCI bridge to [bus 12]
[    0.433644] pci 0000:10:08.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.433654] pci 0000:10:08.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.433744] pci_bus 0000:00: on NUMA node 0
[    0.434186] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.434258] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.434333] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.434407] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 11 14 15) *0
[    0.434467] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 10 11 14 15) *0
[    0.434515] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 10 11 14 15) *0
[    0.434562] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 10 11 14 15) *0
[    0.434609] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 10 11 14 15) *0
[    0.434769] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.434772] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.434780] vgaarb: loaded
[    0.434782] vgaarb: bridge control possible 0000:01:00.0
[    0.434837] SCSI subsystem initialized
[    0.434890] libata version 3.00 loaded.
[    0.434895] ACPI: bus type USB registered
[    0.434912] usbcore: registered new interface driver usbfs
[    0.434922] usbcore: registered new interface driver hub
[    0.434945] usbcore: registered new device driver usb
[    0.435048] PCI: Using ACPI for IRQ routing
[    0.435050] PCI: pci_cache_line_size set to 64 bytes
[    0.435208] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.435210] e820: reserve RAM buffer [mem 0xae47b000-0xafffffff]
[    0.435211] e820: reserve RAM buffer [mem 0xaf156000-0xafffffff]
[    0.435212] e820: reserve RAM buffer [mem 0xaf800000-0xafffffff]
[    0.435300] NetLabel: Initializing
[    0.435302] NetLabel:  domain hash size = 128
[    0.435304] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.435315] NetLabel:  unlabeled traffic allowed by default
[    0.435348] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.435352] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.437424] Switched to clocksource hpet
[    0.439574] pnp: PnP ACPI init
[    0.439688] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.439692] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.440025] system 00:01: [io  0x040b] has been reserved
[    0.440029] system 00:01: [io  0x04d6] has been reserved
[    0.440031] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.440034] system 00:01: [io  0x0c14] has been reserved
[    0.440037] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.440040] system 00:01: [io  0x0c52] has been reserved
[    0.440043] system 00:01: [io  0x0c6c] has been reserved
[    0.440045] system 00:01: [io  0x0c6f] has been reserved
[    0.440048] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.440051] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.440055] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.440058] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.440061] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.440063] system 00:01: [io  0x0800-0x089f] could not be reserved
[    0.440066] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.440069] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.440072] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.440075] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.440079] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.440082] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.440085] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.440088] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.440091] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.440095] system 00:01: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.440098] system 00:01: [mem 0xffc00000-0xffffffff] has been reserved
[    0.440101] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.440279] system 00:02: [io  0x0220-0x0227] has been reserved
[    0.440282] system 00:02: [io  0x0228-0x0237] has been reserved
[    0.440285] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    0.440289] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.440328] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.440591] pnp 00:04: [dma 0 disabled]
[    0.440629] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.440656] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.440731] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.440735] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.440785] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.440937] system 00:08: [mem 0xfeb20000-0xfeb23fff] has been reserved
[    0.440941] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.441071] system 00:09: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.441075] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.441182] pnp: PnP ACPI: found 10 devices
[    0.447905] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.447909] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.447913] pci 0000:00:02.0:   bridge window [mem 0xd9000000-0xdb0fffff]
[    0.447917] pci 0000:00:02.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.447922] pci 0000:04:08.0: PCI bridge to [bus 05]
[    0.447927] pci 0000:04:08.0:   bridge window [io  0x6000-0x6fff]
[    0.447936] pci 0000:04:08.0:   bridge window [mem 0xdd800000-0xdd8fffff]
[    0.447951] pci 0000:03:04.0: PCI bridge to [bus 04-05]
[    0.447955] pci 0000:03:04.0:   bridge window [io  0x6000-0x7fff]
[    0.447963] pci 0000:03:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.447969] pci 0000:03:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.447978] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.447981] pci 0000:02:00.0:   bridge window [io  0x6000-0x7fff]
[    0.447988] pci 0000:02:00.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.447993] pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.448000] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.448003] pci 0000:00:04.0:   bridge window [io  0x6000-0x7fff]
[    0.448007] pci 0000:00:04.0:   bridge window [mem 0xdb800000-0xdd9fffff]
[    0.448010] pci 0000:00:04.0:   bridge window [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.448014] pci 0000:00:09.0: PCI bridge to [bus 06]
[    0.448018] pci 0000:00:09.0:   bridge window [mem 0xde100000-0xde1fffff]
[    0.448023] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    0.448026] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
[    0.448029] pci 0000:00:0a.0:   bridge window [mem 0xde000000-0xde0fffff]
[    0.448034] pci 0000:08:00.0: PCI bridge to [bus 09]
[    0.448038] pci 0000:08:00.0:   bridge window [io  0xc000-0xcfff]
[    0.448046] pci 0000:08:00.0:   bridge window [mem 0xddb00000-0xddbfffff]
[    0.448059] pci 0000:00:0b.0: PCI bridge to [bus 08-09]
[    0.448062] pci 0000:00:0b.0:   bridge window [io  0xc000-0xcfff]
[    0.448066] pci 0000:00:0b.0:   bridge window [mem 0xddb00000-0xddcfffff]
[    0.448071] pci 0000:00:14.4: PCI bridge to [bus 0a]
[    0.448074] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.448079] pci 0000:00:14.4:   bridge window [mem 0xddf00000-0xddffffff]
[    0.448086] pci 0000:00:15.0: PCI bridge to [bus 0b]
[    0.448089] pci 0000:00:15.0:   bridge window [io  0xa000-0xafff]
[    0.448095] pci 0000:00:15.0:   bridge window [mem 0xc6000000-0xc60fffff 64bit pref]
[    0.448100] pci 0000:00:15.1: PCI bridge to [bus 0c]
[    0.448105] pci 0000:00:15.1:   bridge window [mem 0xdde00000-0xddefffff]
[    0.448111] pci 0000:00:15.2: PCI bridge to [bus 0d]
[    0.448114] pci 0000:00:15.2:   bridge window [io  0x9000-0x9fff]
[    0.448118] pci 0000:00:15.2:   bridge window [mem 0xddd00000-0xdddfffff]
[    0.448126] pci 0000:10:07.0: PCI bridge to [bus 11]
[    0.448135] pci 0000:10:07.0:   bridge window [mem 0xd8500000-0xd85fffff]
[    0.448143] pci 0000:10:07.0:   bridge window [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.448156] pci 0000:10:08.0: PCI bridge to [bus 12]
[    0.448166] pci 0000:10:08.0:   bridge window [mem 0xd8400000-0xd84fffff]
[    0.448174] pci 0000:10:08.0:   bridge window [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.448186] pci 0000:0f:04.0: PCI bridge to [bus 10-12]
[    0.448191] pci 0000:0f:04.0:   bridge window [io  0x8000-0x8fff]
[    0.448199] pci 0000:0f:04.0:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.448206] pci 0000:0f:04.0:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448216] pci 0000:0e:00.0: PCI bridge to [bus 0f-12]
[    0.448220] pci 0000:0e:00.0:   bridge window [io  0x8000-0x8fff]
[    0.448227] pci 0000:0e:00.0:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.448233] pci 0000:0e:00.0:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448242] pci 0000:00:15.3: PCI bridge to [bus 0e-12]
[    0.448245] pci 0000:00:15.3:   bridge window [io  0x8000-0x8fff]
[    0.448250] pci 0000:00:15.3:   bridge window [mem 0xd0000000-0xd86fffff]
[    0.448254] pci 0000:00:15.3:   bridge window [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448260] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    0.448261] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    0.448262] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    0.448264] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
[    0.448265] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    0.448267] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    0.448268] pci_bus 0000:00: resource 10 [mem 0xb0000000-0xdfffffff]
[    0.448270] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.448271] pci_bus 0000:01: resource 1 [mem 0xd9000000-0xdb0fffff]
[    0.448273] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.448274] pci_bus 0000:02: resource 0 [io  0x6000-0x7fff]
[    0.448276] pci_bus 0000:02: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.448277] pci_bus 0000:02: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.448279] pci_bus 0000:03: resource 0 [io  0x6000-0x7fff]
[    0.448280] pci_bus 0000:03: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.448281] pci_bus 0000:03: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.448283] pci_bus 0000:04: resource 0 [io  0x6000-0x7fff]
[    0.448284] pci_bus 0000:04: resource 1 [mem 0xdb800000-0xdd9fffff]
[    0.448286] pci_bus 0000:04: resource 2 [mem 0xc0000000-0xc3ffffff 64bit pref]
[    0.448287] pci_bus 0000:05: resource 0 [io  0x6000-0x6fff]
[    0.448289] pci_bus 0000:05: resource 1 [mem 0xdd800000-0xdd8fffff]
[    0.448290] pci_bus 0000:06: resource 1 [mem 0xde100000-0xde1fffff]
[    0.448292] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.448293] pci_bus 0000:07: resource 1 [mem 0xde000000-0xde0fffff]
[    0.448295] pci_bus 0000:08: resource 0 [io  0xc000-0xcfff]
[    0.448296] pci_bus 0000:08: resource 1 [mem 0xddb00000-0xddcfffff]
[    0.448297] pci_bus 0000:09: resource 0 [io  0xc000-0xcfff]
[    0.448299] pci_bus 0000:09: resource 1 [mem 0xddb00000-0xddbfffff]
[    0.448300] pci_bus 0000:0a: resource 0 [io  0xb000-0xbfff]
[    0.448302] pci_bus 0000:0a: resource 1 [mem 0xddf00000-0xddffffff]
[    0.448303] pci_bus 0000:0a: resource 4 [io  0x0000-0x03af]
[    0.448305] pci_bus 0000:0a: resource 5 [io  0x03e0-0x0cf7]
[    0.448306] pci_bus 0000:0a: resource 6 [io  0x03b0-0x03df]
[    0.448307] pci_bus 0000:0a: resource 7 [io  0x0d00-0xffff]
[    0.448309] pci_bus 0000:0a: resource 8 [mem 0x000a0000-0x000bffff]
[    0.448310] pci_bus 0000:0a: resource 9 [mem 0x000c0000-0x000dffff]
[    0.448312] pci_bus 0000:0a: resource 10 [mem 0xb0000000-0xdfffffff]
[    0.448313] pci_bus 0000:0b: resource 0 [io  0xa000-0xafff]
[    0.448315] pci_bus 0000:0b: resource 2 [mem 0xc6000000-0xc60fffff 64bit pref]
[    0.448316] pci_bus 0000:0c: resource 1 [mem 0xdde00000-0xddefffff]
[    0.448318] pci_bus 0000:0d: resource 0 [io  0x9000-0x9fff]
[    0.448319] pci_bus 0000:0d: resource 1 [mem 0xddd00000-0xdddfffff]
[    0.448320] pci_bus 0000:0e: resource 0 [io  0x8000-0x8fff]
[    0.448322] pci_bus 0000:0e: resource 1 [mem 0xd0000000-0xd86fffff]
[    0.448323] pci_bus 0000:0e: resource 2 [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448325] pci_bus 0000:0f: resource 0 [io  0x8000-0x8fff]
[    0.448326] pci_bus 0000:0f: resource 1 [mem 0xd0000000-0xd86fffff]
[    0.448328] pci_bus 0000:0f: resource 2 [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448329] pci_bus 0000:10: resource 0 [io  0x8000-0x8fff]
[    0.448330] pci_bus 0000:10: resource 1 [mem 0xd0000000-0xd86fffff]
[    0.448332] pci_bus 0000:10: resource 2 [mem 0xc4000000-0xc5ffffff 64bit pref]
[    0.448333] pci_bus 0000:11: resource 1 [mem 0xd8500000-0xd85fffff]
[    0.448335] pci_bus 0000:11: resource 2 [mem 0xc5000000-0xc5ffffff 64bit pref]
[    0.448336] pci_bus 0000:12: resource 1 [mem 0xd8400000-0xd84fffff]
[    0.448338] pci_bus 0000:12: resource 2 [mem 0xc4000000-0xc4ffffff 64bit pref]
[    0.448355] NET: Registered protocol family 2
[    0.448502] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.448708] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.448894] TCP: Hash tables configured (established 131072 bind 65536)
[    0.448924] TCP: reno registered
[    0.448928] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.448981] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.449070] NET: Registered protocol family 1
[    0.760773] pci 0000:01:00.0: Video device with shadowed ROM
[    0.760776] pci 0000:02:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.761022] pci 0000:0e:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled
[    0.761056] PCI: CLS 64 bytes, default 64
[    0.761100] Unpacking initramfs...
[    1.418899] microcode: updated early to new patch_level=0x0600063d
[    1.420563] Freeing initrd memory: 7760K (ffff8800370c8000 - ffff88003785c000)
[    1.496776] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.496788] pci 0000:00:00.2: irq 26 for MSI/MSI-X
[    1.506559] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.581738] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.581742] software IO TLB [mem 0xa6400000-0xaa400000] (64MB) mapped at [ffff8800a6400000-ffff8800aa3fffff]
[    1.582089] perf: AMD NB counters detected
[    1.582153] microcode: CPU0: patch_level=0x0600063d
[    1.582163] microcode: CPU1: patch_level=0x0600063d
[    1.582173] microcode: CPU2: patch_level=0x0600063d
[    1.582184] microcode: CPU3: patch_level=0x0600063d
[    1.582194] microcode: CPU4: patch_level=0x0600063d
[    1.582204] microcode: CPU5: patch_level=0x0600063d
[    1.582213] microcode: CPU6: patch_level=0x0600063d
[    1.582222] microcode: CPU7: patch_level=0x0600063d
[    1.582286] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    1.582296] LVT offset 0 assigned for vector 0x400
[    1.582316] perf: AMD IBS detected (0x000000ff)
[    1.582764] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    1.582817] Initialise system trusted keyring
[    1.583070] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.584377] zpool: loaded
[    1.584380] zbud: loaded
[    1.584524] VFS: Disk quotas dquot_6.5.2
[    1.584554] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.584837] msgmni has been set to 32004
[    1.585073] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.585078] io scheduler noop registered
[    1.585081] io scheduler deadline registered
[    1.585107] io scheduler cfq registered (default)
[    1.585785] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.585800] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.585841] vesafb: mode is 1280x1024x16, linelength=2560, pages=0
[    1.585844] vesafb: scrolling: redraw
[    1.585846] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    1.585860] vesafb: framebuffer at 0xb0000000, mapped to 0xffffc90000080000, using 2560k, total 2560k
[    1.601201] Console: switching to colour frame buffer device 160x64
[    1.616573] fb0: VESA VGA frame buffer device
[    1.616684] GHES: HEST is not enabled!
[    1.616777] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.637377] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.637951] Non-volatile memory driver v1.3
[    1.638024] Linux agpgart interface v0.103
[    1.638736] ahci 0000:00:11.0: version 3.0
[    1.638853] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    1.638995] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    1.639621] scsi host0: ahci
[    1.639769] scsi host1: ahci
[    1.639889] scsi host2: ahci
[    1.640008] scsi host3: ahci
[    1.640095] ata1: SATA max UDMA/133 abar m1024@0xd870b000 port 0xd870b100 irq 19
[    1.640228] ata2: SATA max UDMA/133 abar m1024@0xd870b000 port 0xd870b180 irq 19
[    1.640357] ata3: SATA max UDMA/133 abar m1024@0xd870b000 port 0xd870b200 irq 19
[    1.640486] ata4: SATA max UDMA/133 abar m1024@0xd870b000 port 0xd870b280 irq 19
[    1.640727] ahci 0000:07:00.0: irq 30 for MSI/MSI-X
[    1.640761] ahci 0000:07:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.640901] ahci 0000:07:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.641311] scsi host4: ahci
[    1.641434] scsi host5: ahci
[    1.641521] ata5: SATA max UDMA/133 abar m512@0xde010000 port 0xde010100 irq 30
[    1.641648] ata6: SATA max UDMA/133 abar m512@0xde010000 port 0xde010180 irq 30
[    1.641851] ahci 0000:0d:00.0: irq 31 for MSI/MSI-X
[    1.641888] ahci 0000:0d:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.642029] ahci 0000:0d:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.642447] scsi host6: ahci
[    1.642571] scsi host7: ahci
[    1.642657] ata7: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10100 irq 31
[    1.642785] ata8: SATA max UDMA/133 abar m512@0xddd10000 port 0xddd10180 irq 31
[    1.642939] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.643057] ehci-pci: EHCI PCI platform driver
[    1.643205] QUIRK: Enable AMD PLL fix
[    1.643225] ehci-pci 0000:00:12.2: EHCI Host Controller
[    1.643319] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    1.643450] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.643611] ehci-pci 0000:00:12.2: debug port 1
[    1.643717] ehci-pci 0000:00:12.2: irq 17, io mem 0xd8709000
[    1.653477] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.653616] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.653733] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.653857] usb usb1: Product: EHCI Host Controller
[    1.658236] usb usb1: Manufacturer: Linux 3.18.7-lcrs ehci_hcd
[    1.662582] usb usb1: SerialNumber: 0000:00:12.2
[    1.666982] hub 1-0:1.0: USB hub found
[    1.671274] hub 1-0:1.0: 5 ports detected
[    1.675734] ehci-pci 0000:00:13.2: EHCI Host Controller
[    1.680000] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    1.684288] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.688614] ehci-pci 0000:00:13.2: debug port 1
[    1.692949] ehci-pci 0000:00:13.2: irq 17, io mem 0xd8707000
[    1.706787] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.711111] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.715443] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.719756] usb usb2: Product: EHCI Host Controller
[    1.724014] usb usb2: Manufacturer: Linux 3.18.7-lcrs ehci_hcd
[    1.728298] usb usb2: SerialNumber: 0000:00:13.2
[    1.732666] hub 2-0:1.0: USB hub found
[    1.736961] hub 2-0:1.0: 5 ports detected
[    1.741406] ehci-pci 0000:00:16.2: EHCI Host Controller
[    1.745669] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 3
[    1.749945] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.754274] ehci-pci 0000:00:16.2: debug port 1
[    1.758578] ehci-pci 0000:00:16.2: irq 17, io mem 0xd8704000
[    1.770088] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    1.774333] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.778542] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.782740] usb usb3: Product: EHCI Host Controller
[    1.786938] usb usb3: Manufacturer: Linux 3.18.7-lcrs ehci_hcd
[    1.791132] usb usb3: SerialNumber: 0000:00:16.2
[    1.795347] hub 3-0:1.0: USB hub found
[    1.799437] hub 3-0:1.0: 4 ports detected
[    1.803616] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.807710] uhci_hcd: USB Universal Host Controller Interface driver
[    1.811828] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.815912] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.820286] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.824657] mousedev: PS/2 mouse device common for all mice
[    1.829099] rtc_cmos 00:05: RTC can wake from S4
[    1.833536] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.837965] rtc_cmos 00:05: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.843208] ledtrig-cpu: registered to indicate activity on CPUs
[    1.847800] hidraw: raw HID events driver (C) Jiri Kosina
[    1.852434] usbcore: registered new interface driver usbhid
[    1.856974] usbhid: USB HID core driver
[    1.861501] TCP: cubic registered
[    1.866041] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.870781] NET: Registered protocol family 10
[    1.875634] Key type dns_resolver registered
[    1.880646] Loading compiled-in X.509 certificates
[    1.885255] registered taskstats version 1
[    1.890572]   Magic number: 3:164:344
[    1.895176] tty tty61: hash matches
[    1.899778] rtc_cmos 00:05: setting system clock to 2015-02-12 19:20:17 UTC (1423768817)
[    1.953349] ata6: SATA link down (SStatus 0 SControl 300)
[    1.960006] ata5: SATA link down (SStatus 0 SControl 300)
[    2.119918] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.126579] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.126584] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.135692] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.135697] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.136890] ata8.00: ATA-6: ST3500320NS, SN04, max UDMA/133
[    2.136891] ata8.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.138468] ata8.00: configured for UDMA/133
[    2.155636] ata7.00: ATA-8: ST3500320NS, SN06, max UDMA/133
[    2.155637] ata7.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.166548] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.171010] ata4.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    2.175469] ata4.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.200068] ata7.00: configured for UDMA/133
[    2.215460] ata1.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[    2.219988] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.224519] ata3.00: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
[    2.229022] ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.233591] ata4.00: configured for UDMA/133
[    2.238160] ata2.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    2.242708] ata2.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.275017] ata3.00: configured for UDMA/133
[    2.282063] ata1.00: configured for UDMA/133
[    2.286607] scsi 0:0:0:0: Direct-Access     ATA      ST3160815AS      B    PQ: 0 ANSI: 5
[    2.291290] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.295923] sd 0:0:0:0: [sda] Write Protect is off
[    2.300536] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.300578] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.300592] ata2.00: configured for UDMA/133
[    2.313196] scsi 1:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.318060] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.318125] scsi 2:0:0:0: Direct-Access     ATA      ST3160811AS      E    PQ: 0 ANSI: 5
[    2.318245] sd 2:0:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.318280] sd 2:0:0:0: [sdc] Write Protect is off
[    2.318303] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.318332] scsi 3:0:0:0: Direct-Access     ATA      ST3160815AS      D    PQ: 0 ANSI: 5
[    2.318335] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.318554] scsi 6:0:0:0: Direct-Access     ATA      ST3500320NS      SN06 PQ: 0 ANSI: 5
[    2.318687] sd 6:0:0:0: [sde] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    2.318726] sd 6:0:0:0: [sde] Write Protect is off
[    2.318727] sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    2.318743] sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.318828] scsi 7:0:0:0: Direct-Access     ATA      ST3500320NS      SN04 PQ: 0 ANSI: 5
[    2.319019] sd 7:0:0:0: [sdf] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    2.319096] sd 7:0:0:0: [sdf] Write Protect is off
[    2.319098] sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    2.319147] sd 7:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.319172] sd 3:0:0:0: [sdd] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.319305] sd 3:0:0:0: [sdd] Write Protect is off
[    2.319306] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.319315] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.329275]  sdf: sdf1
[    2.329483] sd 7:0:0:0: [sdf] Attached SCSI disk
[    2.331061]  sde: sde1
[    2.331230] sd 6:0:0:0: [sde] Attached SCSI disk
[    2.384465]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
[    2.384859] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.401983]  sdd: sdd1 sdd2 sdd3 < sdd5 sdd6 sdd7 >
[    2.402393] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.408571]  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 >
[    2.409011] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.451791] sd 1:0:0:0: [sdb] Write Protect is off
[    2.456604] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.456619] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.542457]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 >
[    2.547641] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.553383] Freeing unused kernel memory: 964K (ffffffff80cb2000 - ffffffff80da3000)
[    2.558366] Write protecting the kernel read-only data: 10240k
[    2.563855] Freeing unused kernel memory: 208K (ffff8800007cc000 - ffff880000800000)
[    2.571466] Freeing unused kernel memory: 1292K (ffff880000abd000 - ffff880000c00000)
[    2.578061] random: systemd urandom read with 75 bits of entropy available
[    2.583013] tsc: Refined TSC clocksource calibration: 3616.529 MHz
[    2.588484] systemd[1]: systemd 210 running in system mode. (+PAM -LIBWRAP +AUDIT +SELINUX -IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ +SECCOMP +APPARMOR)
[    2.594213] systemd[1]: Detected architecture 'x86-64'.
[    2.599774] systemd[1]: Running in initial RAM disk.
[    2.622646] systemd[1]: Inserted module 'autofs4'
[    2.628352] systemd[1]: Set hostname to <harley>.
[    2.687554] systemd[1]: Expecting device dev-disk-by\x2did-ata\x2dST3160815AS_6RACD7A6\x2dpart5.device...
[    2.699090] systemd[1]: Starting Timers.
[    2.710551] systemd[1]: Reached target Timers.
[    2.716272] systemd[1]: Starting -.slice.
[    2.727567] systemd[1]: Created slice -.slice.
[    2.733196] systemd[1]: Starting udev Control Socket.
[    2.744450] systemd[1]: Listening on udev Control Socket.
[    2.750079] systemd[1]: Starting udev Kernel Socket.
[    2.761406] systemd[1]: Listening on udev Kernel Socket.
[    2.767045] systemd[1]: Starting Journal Socket.
[    2.778262] systemd[1]: Listening on Journal Socket.
[    2.783814] systemd[1]: Starting Sockets.
[    2.794763] systemd[1]: Reached target Sockets.
[    2.800191] systemd[1]: Starting System Slice.
[    2.810952] systemd[1]: Created slice System Slice.
[    2.816315] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    2.826975] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    2.832356] systemd[1]: Starting dracut cmdline hook...
[    2.843261] systemd[1]: Starting Load Kernel Modules...
[    2.854009] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    2.859534] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.859565] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    2.859591] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    2.859616] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    2.859641] sd 6:0:0:0: Attached scsi generic sg4 type 0
[    2.859665] sd 7:0:0:0: Attached scsi generic sg5 type 0
[    2.896910] systemd[1]: Starting Journal Service...
[    2.912896] systemd[1]: Started Journal Service.
[    3.165043] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    3.165243] ACPI: Power Button [PWRB]
[    3.165361] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    3.165515] ACPI: Power Button [PWRF]
[    3.207507] wmi: Mapper loaded
[    3.230729] ohci-pci: OHCI PCI platform driver
[    3.230959] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    3.231061] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[    3.231690] ohci-pci 0000:00:12.0: irq 18, io mem 0xd870a000
[    3.257374] random: nonblocking pool is initialized
[    3.286704] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.286824] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.286949] usb usb4: Product: OHCI PCI host controller
[    3.287038] usb usb4: Manufacturer: Linux 3.18.7-lcrs ohci_hcd
[    3.287138] usb usb4: SerialNumber: 0000:00:12.0
[    3.287344] hub 4-0:1.0: USB hub found
[    3.287417] hub 4-0:1.0: 5 ports detected
[    3.287717] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    3.287817] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
[    3.287960] ohci-pci 0000:00:13.0: irq 18, io mem 0xd8708000
[    3.343351] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.343471] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.343596] usb usb5: Product: OHCI PCI host controller
[    3.343685] usb usb5: Manufacturer: Linux 3.18.7-lcrs ohci_hcd
[    3.343785] usb usb5: SerialNumber: 0000:00:13.0
[    3.343962] hub 5-0:1.0: USB hub found
[    3.344032] hub 5-0:1.0: 5 ports detected
[    3.344325] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    3.344425] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
[    3.344573] ohci-pci 0000:00:14.5: irq 18, io mem 0xd8706000
[    3.399978] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    3.400098] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.400223] usb usb6: Product: OHCI PCI host controller
[    3.400313] usb usb6: Manufacturer: Linux 3.18.7-lcrs ohci_hcd
[    3.400413] usb usb6: SerialNumber: 0000:00:14.5
[    3.400593] hub 6-0:1.0: USB hub found
[    3.400663] hub 6-0:1.0: 2 ports detected
[    3.400909] ohci-pci 0000:00:16.0: OHCI PCI host controller
[    3.401020] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
[    3.401165] ohci-pci 0000:00:16.0: irq 18, io mem 0xd8705000
[    3.459954] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    3.460073] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.460198] usb usb7: Product: OHCI PCI host controller
[    3.460287] usb usb7: Manufacturer: Linux 3.18.7-lcrs ohci_hcd
[    3.460387] usb usb7: SerialNumber: 0000:00:16.0
[    3.460560] hub 7-0:1.0: USB hub found
[    3.460630] hub 7-0:1.0: 4 ports detected
[    3.462244] scsi host10: pata_atiixp
[    3.462395] scsi host11: pata_atiixp
[    3.462494] ata9: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
[    3.462624] ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
[    3.582561] Switched to clocksource tsc
[    3.619150] usb 4-3: new low-speed USB device number 2 using ohci-pci
[    3.632718] ata9.00: ATAPI: SONY    DVD RW AD-7260S, 1.61, max UDMA/100
[    3.633022] ata9.01: ATA-8: ST3500418AS, CC38, max UDMA/133
[    3.633118] ata9.01: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    3.633235] ata9.00: limited to UDMA/33 due to 40-wire cable
[    3.633332] ata9.01: limited to UDMA/33 due to 40-wire cable
[    3.646037] ata9.00: configured for UDMA/33
[    3.659548] ata9.01: configured for UDMA/33
[    3.661513] scsi 10:0:0:0: CD-ROM            SONY     DVD RW AD-7260S  1.61 PQ: 0 ANSI: 5
[    3.676655] scsi 10:0:0:0: Attached scsi generic sg6 type 5
[    3.681099] scsi 10:0:1:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5
[    3.685737] sd 10:0:1:0: [sdg] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    3.685768] sd 10:0:1:0: Attached scsi generic sg7 type 0
[    3.694592] sd 10:0:1:0: [sdg] Write Protect is off
[    3.698901] sd 10:0:1:0: [sdg] Mode Sense: 00 3a 00 00
[    3.698913] sd 10:0:1:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.715250]  sdg: sdg1
[    3.719719] sd 10:0:1:0: [sdg] Attached SCSI disk
[    3.737494] sr 10:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    3.741972] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.746641] sr 10:0:0:0: Attached scsi CD-ROM sr0
[    3.782414] usb 4-3: New USB device found, idVendor=046d, idProduct=c00e
[    3.786958] usb 4-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.791492] usb 4-3: Product: USB-PS/2 Optical Mouse
[    3.796057] usb 4-3: Manufacturer: Logitech
[    3.807637] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-3/4-3:1.0/0003:046D:C00E.0001/input/input3
[    3.812431] hid-generic 0003:046D:C00E.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:12.0-3/input0
[    8.336740] scsi host9: Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec 29320LPE PCIe Ultra320 SCSI adapter>
        aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133MHz, 512 SCBs
[   18.251676] scsi host8: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2930CU SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

[   20.373133] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
[   20.668264] systemd-journald[228]: Received SIGTERM from PID 1 (systemd).
[   22.812157] device-mapper: uevent: version 1.0.3
[   22.817602] device-mapper: ioctl: 4.28.0-ioctl (2014-09-17) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[   25.125044] EXT4-fs (sda5): re-mounted. Opts: acl,user_xattr
[   26.266615] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   26.270689] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[   26.399757] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   26.665729] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   26.956018] dgap: module is from the staging directory, the quality is unknown, you have been warned.
[   26.960342] dgap: dgap-1.3-16, Digi International Part Number 40002347_C
[   26.964437] dgap: For the tools package please visit http://www.digi.com
[   26.968723] dgap: dgap: board 0: AccelePort Xr920 8 port (rev 1), irq 16
[   27.057846] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   27.061955] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 8
[   27.066213] xhci_hcd 0000:06:00.0: irq 34 for MSI/MSI-X
[   27.066271] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[   27.070490] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   27.074731] usb usb8: Product: xHCI Host Controller
[   27.078975] usb usb8: Manufacturer: Linux 3.18.7-lcrs xhci-hcd
[   27.083258] usb usb8: SerialNumber: 0000:06:00.0
[   27.087694] hub 8-0:1.0: USB hub found
[   27.091857] hub 8-0:1.0: 2 ports detected
[   27.096166] xhci_hcd 0000:06:00.0: xHCI Host Controller
[   27.100344] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 9
[   27.104584] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[   27.108812] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   27.113034] usb usb9: Product: xHCI Host Controller
[   27.117180] usb usb9: Manufacturer: Linux 3.18.7-lcrs xhci-hcd
[   27.121290] usb usb9: SerialNumber: 0000:06:00.0
[   27.125443] hub 9-0:1.0: USB hub found
[   27.129537] hub 9-0:1.0: 2 ports detected
[   27.133724] xhci_hcd 0000:0c:00.0: xHCI Host Controller
[   27.137754] xhci_hcd 0000:0c:00.0: new USB bus registered, assigned bus number 10
[   27.141993] xhci_hcd 0000:0c:00.0: irq 35 for MSI/MSI-X
[   27.142056] usb usb10: New USB device found, idVendor=1d6b, idProduct=0002
[   27.146280] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   27.150558] usb usb10: Product: xHCI Host Controller
[   27.154881] usb usb10: Manufacturer: Linux 3.18.7-lcrs xhci-hcd
[   27.159282] usb usb10: SerialNumber: 0000:0c:00.0
[   27.163818] hub 10-0:1.0: USB hub found
[   27.168287] hub 10-0:1.0: 2 ports detected
[   27.172911] xhci_hcd 0000:0c:00.0: xHCI Host Controller
[   27.177492] xhci_hcd 0000:0c:00.0: new USB bus registered, assigned bus number 11
[   27.182206] usb usb11: New USB device found, idVendor=1d6b, idProduct=0003
[   27.186961] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   27.191778] usb usb11: Product: xHCI Host Controller
[   27.196647] usb usb11: Manufacturer: Linux 3.18.7-lcrs xhci-hcd
[   27.201442] usb usb11: SerialNumber: 0000:0c:00.0
[   27.206316] hub 11-0:1.0: USB hub found
[   27.211014] hub 11-0:1.0: 2 ports detected
[   27.726765] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   27.731876] r8169 0000:0b:00.0: can't disable ASPM; OS doesn't have ASPM control
[   27.737540] r8169 0000:0b:00.0: irq 36 for MSI/MSI-X
[   27.737732] r8169 0000:0b:00.0 eth0: RTL8168evl/8111evl at 0xffffc90000042000, 74:d4:35:1f:b2:9e, XID 0c900800 IRQ 36
[   27.743253] r8169 0000:0b:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   27.802725] EXT4-fs (sdf1): mounted filesystem with ordered data mode. Opts: (null)
[   27.886541] [drm] Initialized drm 1.1.0 20060810
[   27.946787] EXT4-fs (sdg1): mounting ext3 file system using the ext4 subsystem
[   27.965213] EXT4-fs (sdg1): mounted filesystem with ordered data mode. Opts: (null)
[   27.982629] EXT4-fs (sde1): mounting ext3 file system using the ext4 subsystem
[   28.021204] EXT4-fs (sde1): mounted filesystem with ordered data mode. Opts: (null)
[   28.183227] sound hdaudioC0D0: autoconfig: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   28.189368] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   28.195505] sound hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   28.201617] sound hdaudioC0D0:    mono: mono_out=0x0
[   28.207718] sound hdaudioC0D0:    dig-out=0x11/0x1e
[   28.213808] sound hdaudioC0D0:    inputs:
[   28.219847] sound hdaudioC0D0:      Front Mic=0x19
[   28.225863] sound hdaudioC0D0:      Rear Mic=0x18
[   28.231801] sound hdaudioC0D0:      Line=0x1a
[   28.251544] AVX version of gcm_enc/dec engaged.
[   28.257538] AES CTR mode by8 optimization enabled
[   28.265309] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input5
[   28.271410] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[   28.277576] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[   28.283766] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[   28.290002] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[   28.296284] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[   28.303149] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[   28.309500] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input12
[   28.803626] EXT4-fs (sdb5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   28.903265] Adding 8385532k swap on /dev/sda2.  Priority:-1 extents:1 across:8385532k FS
[   28.963172] EXT4-fs (sdb7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   28.994840] EXT4-fs (sdb6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   29.006537] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   29.016484] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   29.577692] EXT4-fs (sdc5): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   29.750385] EXT4-fs (sdc7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   29.793628] EXT4-fs (sdc6): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   29.820645] kvm: disabled by bios
[   29.826789] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[   29.839511] kvm: disabled by bios
[   29.849483] kvm: disabled by bios
[   29.859523] kvm: disabled by bios
[   29.876164] kvm: disabled by bios
[   29.892782] kvm: disabled by bios
[   29.909484] kvm: disabled by bios
[   29.913086] EXT4-fs (sda6): mounted filesystem with ordered data mode. Opts: (null)
[   29.932811] kvm: disabled by bios
[   30.002112] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: (null)
[   31.209739] 3c59x: Donald Becker and others.
[   31.215383] 0000:10:05.0: 3Com PCI 3c905C Tornado at ffffc90000044000.
[   32.227901] systemd-journald[454]: Received request to flush runtime journal from PID 1
[   37.848112] NET: Registered protocol family 17
[   38.219434] No iBFT detected.
[   38.466832] r8169 0000:0b:00.0 eth0: link down
[   38.466848] r8169 0000:0b:00.0 eth0: link down
[   38.475362] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   38.484247] eth1:  setting full-duplex.
[   40.011185] r8169 0000:0b:00.0 eth0: link up
[   40.015400] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  118.802375] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000078800 flags=0x0070]
[  118.807037] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000078820 flags=0x0070]
[  118.811770] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000078830 flags=0x0070]
[  121.653058] AMD-Vi: Event logged [
[  121.653084] ------------[ cut here ]------------
[  121.653089] WARNING: CPU: 7 PID: 0 at drivers/iommu/amd_iommu.c:2637 dma_ops_domain_unmap.part.13+0x65/0x70()
[  121.653090] Modules linked in:
[  121.653090]  iscsi_ibft
[  121.653091]  iscsi_boot_sysfs
[  121.653091]  af_packet
[  121.653091]  kvm
[  121.653092]  crc32_pclmul
[  121.653092]  crc32c_intel
[  121.653092]  aesni_intel
[  121.653093]  snd_hda_codec_realtek
[  121.653093]  snd_hda_codec_generic
[  121.653093]  aes_x86_64
[  121.653094]  glue_helper
[  121.653094]  drm
[  121.653094]  snd_hda_intel
[  121.653095]  snd_hda_controller
[  121.653095]  lrw
[  121.653095]  r8169
[  121.653096]  gf128mul
[  121.653096]  ablk_helper
[  121.653097]  3c59x
[  121.653098]  snd_hda_codec
[  121.653100]  snd_hwdep
[  121.653101]  snd_pcm
[  121.653101]  cryptd
[  121.653102]  mii
[  121.653102]  snd_timer
[  121.653102]  xhci_pci
[  121.653103]  xhci_hcd
[  121.653103]  shpchp
[  121.653104]  snd
[  121.653104]  pcspkr
[  121.653104]  serio_raw
[  121.653105]  fam15h_power
[  121.653105]  k10temp
[  121.653105]  i2c_piix4
[  121.653106]  soundcore
[  121.653106]  tpm_infineon
[  121.653107]  8250_fintek
[  121.653107]  tpm_tis
[  121.653108]  tpm
[  121.653108]  processor
[  121.653108]  thermal_sys
[  121.653109]  dm_mod
[  121.653109]  sr_mod
[  121.653109]  cdrom
[  121.653110]  ata_generic
[  121.653110]  mxm_wmi
[  121.653111]  aic7xxx
[  121.653111]  pata_atiixp
[  121.653111]  ohci_pci
[  121.653112]  aic79xx
[  121.653112]  scsi_transport_spi
[  121.653113]  wmi
[  121.653113]  button
[  121.653113]  sg
[  121.653114]  autofs4
[  121.653114]  [last unloaded: dgap]

[  121.653117] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G         C     3.18.7-lcrs #1
[  121.653119] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./990FXA-UD5, BIOS FB 01/23/2013
[  121.653120]  0000000000000009
[  121.653120]  ffff88044fdc3cb8
[  121.653120]  ffffffff807bde4d
[  121.653121]  0000000000007b7b

[  121.653121]  0000000000000000
[  121.653121]  ffff88044fdc3cf8
[  121.653122]  ffffffff8024cf7c
[  121.653122]  ffff88044fdc3cf8

[  121.653122]  ffff8800a635e3c8
[  121.653122]  0000000000000000
[  121.653123]  0000000000000600
[  121.653123]  00000000000792c0

[  121.653124] Call Trace:
[  121.653125]  <IRQ> 

[  121.653128]  [<ffffffff807bde4d>] dump_stack+0x4e/0x71

[  121.653131]  [<ffffffff8024cf7c>] warn_slowpath_common+0x7c/0xa0

[  121.653132]  [<ffffffff8024d045>] warn_slowpath_null+0x15/0x20

[  121.653134]  [<ffffffff806a47e5>] dma_ops_domain_unmap.part.13+0x65/0x70

[  121.653135]  [<ffffffff806a675b>] __unmap_single.isra.16+0x9b/0x100

[  121.653137]  [<ffffffff806a7198>] unmap_page+0x48/0x70

[  121.653140]  [<ffffffffa01e2373>] boomerang_rx+0x333/0x600 [3c59x]

[  121.653143]  [<ffffffffa01e284a>] boomerang_interrupt+0x16a/0x4f0 [3c59x]

[  121.653145]  [<ffffffff8029600e>] handle_irq_event_percpu+0x3e/0x1e0

[  121.653147]  [<ffffffff802961ec>] handle_irq_event+0x3c/0x60

[  121.653148]  [<ffffffff80298bfe>] handle_fasteoi_irq+0x7e/0x130

[  121.653149]  [<ffffffff8020543d>] handle_irq+0x1d/0x30

[  121.653150]  [<ffffffff80204cee>] do_IRQ+0x4e/0xf0

[  121.653152]  [<ffffffff807c596a>] common_interrupt+0x6a/0x6a
[  121.653152]  <EOI> 

[  121.653154]  [<ffffffff802a6e23>] ? hrtimer_start+0x13/0x20

[  121.653155]  [<ffffffff8020cad7>] ? default_idle+0x17/0x100

[  121.653157]  [<ffffffff8020d4ca>] arch_cpu_idle+0xa/0x10

[  121.653159]  [<ffffffff80281dda>] cpu_startup_entry+0x34a/0x380

[  121.653161]  [<ffffffff802b2cb3>] ? clockevents_register_device+0xe3/0x150

[  121.653163]  [<ffffffff80233857>] start_secondary+0x157/0x180
[  121.653163] ---[ end trace c4d567db7c061997 ]---
[  121.832866] IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000792c0 flags=0x0070]
[  121.843661] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000079300 flags=0x0070]
[  121.849280] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000079340 flags=0x0070]
[  121.854831] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x0000000000079380 flags=0x0070]
[  121.860277] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000793a0 flags=0x0070]
[  121.865621] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000793b0 flags=0x0070]
[  121.870866] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000793b0 flags=0x0070]
[  122.800511] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007a240 flags=0x0020]
[  122.805621] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007a270 flags=0x0020]
[  122.810648] AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0001 address=0x000000000007a260 flags=0x0020]

--------------060204060603030300090106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060204060603030300090106--
