From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Any side effect if turn off amd_iommu
Date: Thu, 26 Mar 2015 13:05:47 +0100
Message-ID: <20150326120547.GU4441@8bytes.org>
References: <CAFv23QmxQ3vJnMEGN0TNR3vLAx1MN7ptB0y3QQLKciqfT3OBsQ@mail.gmail.com>
	<20150325140410.GS4441@8bytes.org>
	<CAFv23Qn93z4pE6RtURgoiBADpgCWZ6gfpMPn3akfJibudRi+Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFv23Qn93z4pE6RtURgoiBADpgCWZ6gfpMPn3akfJibudRi+Qg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: AceLan Kao <acelan.kao-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The parameter is just called 'amd_iommu_dump'. But your dmesg contains
the needed information from that parameter. Can you please try the same
again with a recent upstream kernel and without any proprietary module
loaded (means no fglrx)?


	Joerg

On Thu, Mar 26, 2015 at 10:26:53AM +0800, AceLan Kao wrote:
> Hi Joerg,
> 
> Here you are.
> I've tried to add iommu_dump, amd_iommu_dump, and amd_iommu_dump=true
> on kernel command line,
> but didn't find anything useful.
> The attached log uses "amd_iommu_dump=true"
> 
> Best regards,
> AceLan Kao.
> 
> 2015-03-25 22:04 GMT+08:00 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>:
> > On Wed, Mar 25, 2015 at 11:30:20AM +0800, AceLan Kao wrote:
> >> We have some AMD machines(AMD cpu and graphics) that need to set
> >> amd_iommu=off to work.
> >> Some of them have wifi issue that it can't connect to any AP(no
> >> interrupt)(can set noapic to workaround it, too),
> >> and some of them have graphics issues.
> >> The only workaround we found is to set amd_iommu=off, and it fixes both issues.
> >>
> >> I have 2 questions.
> >> 1. What kind of these issues would be, are they a driver issue or a
> >> BIOS issue? If it's a BIOS issue, what we should tell the BIOS
> >> engineers, so that they know how to fix it?
> >> 2. Some of the machines may not have the chance to get a BIOS update,
> >> do you think it's okay to add a quirk in amd_iommu driver to blacklist
> >> out those machines? Are there any side effects if we do so?
> >
> > Hard to tell what the issue is. Can you please boot the affected machine
> > with AMD IOMMU enabled and amd_iommu_dump on the command line and send
> > me dmesg of the machine after boot?
> >
> > Thanks,
> >
> >         Joerg
> >

> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.13.0-45-generic (buildd@phianna) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #74-Ubuntu SMP Tue Jan 13 19:36:28 UTC 2015 (Ubuntu 3.13.0-45.74-generic 3.13.11-ckt13)
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.13.0-45-generic root=UUID=6224a1c4-824b-41b2-9077-700edb8586ad ro amd_iommu_dump=true quiet splash
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Centaur CentaurHauls
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005d9b5fff] usable
> [    0.000000] BIOS-e820: [mem 0x000000005d9b6000-0x000000005e8b1fff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000005e8b2000-0x000000005efb1fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000005efb2000-0x000000005effefff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000005efff000-0x000000005effffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000025effffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.7 present.
> [    0.000000] DMI: Hewlett-Packard HP ProBook 445G2/2234, BIOS M75 Ver. 01.07 09/16/2014
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] No AGP bridge found
> [    0.000000] e820: last_pfn = 0x25f000 max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-DFFFF write-through
> [    0.000000]   E0000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 000000000000 mask FFFFC0000000 write-back
> [    0.000000]   1 base 000040000000 mask FFFFE0000000 write-back
> [    0.000000]   2 base 0000FF800000 mask FFFFFF800000 write-protect
> [    0.000000]   3 disabled
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000] TOM2: 000000025f000000 aka 9712M
> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
> [    0.000000] e820: last_pfn = 0x5f000 max_arch_pfn = 0x400000000
> [    0.000000] Scanning 1 areas for low memory corruption
> [    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
> [    0.000000] Using GB pages for direct mapping
> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> [    0.000000] BRK [0x01fe1000, 0x01fe1fff] PGTABLE
> [    0.000000] BRK [0x01fe2000, 0x01fe2fff] PGTABLE
> [    0.000000] BRK [0x01fe3000, 0x01fe3fff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x25ee00000-0x25effffff]
> [    0.000000]  [mem 0x25ee00000-0x25effffff] page 2M
> [    0.000000] BRK [0x01fe4000, 0x01fe4fff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x25c000000-0x25edfffff]
> [    0.000000]  [mem 0x25c000000-0x25edfffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x200000000-0x25bffffff]
> [    0.000000]  [mem 0x200000000-0x23fffffff] page 1G
> [    0.000000]  [mem 0x240000000-0x25bffffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x00100000-0x5d9b5fff]
> [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
> [    0.000000]  [mem 0x00200000-0x5d7fffff] page 2M
> [    0.000000]  [mem 0x5d800000-0x5d9b5fff] page 4k
> [    0.000000] init_memory_mapping: [mem 0x5efff000-0x5effffff]
> [    0.000000]  [mem 0x5efff000-0x5effffff] page 4k
> [    0.000000] BRK [0x01fe5000, 0x01fe5fff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x100000000-0x1ffffffff]
> [    0.000000]  [mem 0x100000000-0x1ffffffff] page 1G
> [    0.000000] RAMDISK: [mem 0x342ee000-0x3616efff]
> [    0.000000] ACPI: RSDP 00000000000f2f90 000024 (v02 HPQOEM)
> [    0.000000] ACPI: XSDT 000000005effd0e8 00009C (v01 HPQOEM SLIC-MPC 00000003      01000013)
> [    0.000000] ACPI: FACP 000000005effb000 00010C (v05 HPQOEM 180F     00000003 HP   00000001)
> [    0.000000] ACPI: DSDT 000000005efd8000 01E7AD (v01 HPQOEM 180F     00000001 INTL 20130927)
> [    0.000000] ACPI: FACS 000000005ed69000 000040
> [    0.000000] ACPI: HPET 000000005effa000 000038 (v01 HPQOEM 180F     00000001 HP   00000001)
> [    0.000000] ACPI: APIC 000000005eff9000 000090 (v01 HPQOEM 180F     00000001 HP   00000001)
> [    0.000000] ACPI: MCFG 000000005eff8000 00003C (v01 HPQOEM 180F     00000001 HP   00000001)
> [    0.000000] ACPI: TCPA 000000005eff7000 000032 (v02 HPQOEM 180F     00000000 HP   00000001)
> [    0.000000] ACPI: FPDT 000000005efd5000 000044 (v01 HPQOEM 180F     00000001 HP   00000001)
> [    0.000000] ACPI: BGRT 000000005efd4000 000038 (v00 HPQOEM 180F     00000001 HP   00000001)
> [    0.000000] ACPI: SSDT 000000005efd3000 000B9C (v01 AMD    BALLINA  00000001 AMD  00000001)
> [    0.000000] ACPI: SSDT 000000005efc9000 009399 (v02 AMD    BALLINA  00000002 MSFT 04000000)
> [    0.000000] ACPI: IVRS 000000005efc8000 000078 (v02 AMD    BALLINA  00000001 AMD  00000000)
> [    0.000000] ACPI: CRAT 000000005efc7000 000550 (v01 AMD    BALLINA  00000001 AMD  00000001)
> [    0.000000] ACPI: SSDT 000000005efc6000 000789 (v01 HP     AMDSGTBL 00000001 INTL 20130927)
> [    0.000000] ACPI: SSDT 000000005efc5000 000325 (v01 HP     HPZPODDT 00000001 INTL 20130927)
> [    0.000000] ACPI: SSDT 000000005efc4000 00081B (v01    AMD CPMADPS4 00000001 INTL 20130927)
> [    0.000000] ACPI: SSDT 000000005efc2000 001207 (v01    AMD   CPMCMN 00000001 INTL 20130927)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000025effffff]
> [    0.000000] Initmem setup node 0 [mem 0x00000000-0x25effffff]
> [    0.000000]   NODE_DATA [mem 0x25eff9000-0x25effdfff]
> [    0.000000]  [ffffea0000000000-ffffea00097fffff] PMD -> [ffff880257600000-ffff88025e5fffff] on node 0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
> [    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
> [    0.000000]   Normal   [mem 0x100000000-0x25effffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
> [    0.000000]   node   0: [mem 0x00100000-0x5d9b5fff]
> [    0.000000]   node   0: [mem 0x5efff000-0x5effffff]
> [    0.000000]   node   0: [mem 0x100000000-0x25effffff]
> [    0.000000] On node 0 totalpages: 1821012
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3997 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 5927 pages used for memmap
> [    0.000000]   DMA32 zone: 379319 pages, LIFO batch:31
> [    0.000000]   Normal zone: 22464 pages used for memmap
> [    0.000000]   Normal zone: 1437696 pages, LIFO batch:31
> [    0.000000] ACPI: PM-Timer IO Port: 0x408
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x10] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x11] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x12] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x13] enabled)
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: IOAPIC (id[0x05] address[0xfec20000] gsi_base[24])
> [    0.000000] IOAPIC[1]: apic_id 5, version 33, address 0xfec20000, GSI 24-55
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ2 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x43538301 base: 0xfed00000
> [    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [    0.000000] nr_irqs_gsi: 72
> [    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x5d9b6000-0x5e8b1fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x5e8b2000-0x5efb1fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x5efb2000-0x5effefff]
> [    0.000000] PM: Registered nosave memory: [mem 0x5f000000-0xdfffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfed7ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed80fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfed81000-0xfedfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xff7fffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
> [    0.000000] e820: [mem 0x5f000000-0xdfffffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88025ec00000 s82368 r8192 d24128 u524288
> [    0.000000] pcpu-alloc: s82368 r8192 d24128 u524288 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 0 1 2 3 
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1792536
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.13.0-45-generic root=UUID=6224a1c4-824b-41b2-9077-700edb8586ad ro amd_iommu_dump=true quiet splash
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
> [    0.000000] Checking aperture...
> [    0.000000] No AGP bridge found
> [    0.000000] Node 0: aperture @ 0 size 32 MB
> [    0.000000] Your BIOS doesn't leave a aperture memory hole
> [    0.000000] Please enable the IOMMU option in the BIOS setup
> [    0.000000] This costs you 64 MB of RAM
> [    0.000000] Mapping aperture over 65536 KB of RAM @ 54000000
> [    0.000000] PM: Registered nosave memory: [mem 0x54000000-0x57ffffff]
> [    0.000000] Memory: 6989436K/7284048K available (7383K kernel code, 1145K rwdata, 3408K rodata, 1336K init, 1444K bss, 294612K reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
> [    0.000000] 	Offload RCU callbacks from all CPUs
> [    0.000000] 	Offload RCU callbacks from CPUs: 0-3.
> [    0.000000] NR_IRQS:16640 nr_irqs:1024 16
> [    0.000000] spurious 8259A interrupt: IRQ7.
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] allocated 29360128 bytes of page_cgroup
> [    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
> [    0.000000] hpet clockevent registered
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.004000] tsc: Detected 1896.472 MHz processor
> [    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 3792.94 BogoMIPS (lpj=7585888)
> [    0.000007] pid_max: default: 32768 minimum: 301
> [    0.000040] Security Framework initialized
> [    0.000064] AppArmor: AppArmor initialized
> [    0.000065] Yama: becoming mindful.
> [    0.000688] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> [    0.003568] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> [    0.004849] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
> [    0.004863] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
> [    0.005153] Initializing cgroup subsys memory
> [    0.005163] Initializing cgroup subsys devices
> [    0.005165] Initializing cgroup subsys freezer
> [    0.005168] Initializing cgroup subsys blkio
> [    0.005169] Initializing cgroup subsys perf_event
> [    0.005172] Initializing cgroup subsys hugetlb
> [    0.005199] tseg: 005f000000
> [    0.005201] CPU: Physical Processor ID: 0
> [    0.005203] CPU: Processor Core ID: 0
> [    0.005205] mce: CPU supports 7 MCE banks
> [    0.005212] LVT offset 1 assigned for vector 0xf9
> [    0.005221] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
> [    0.005221] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512
> [    0.005221] tlb_flushall_shift: 5
> [    0.005347] Freeing SMP alternatives memory: 32K (ffffffff81e6e000 - ffffffff81e76000)
> [    0.006447] ACPI: Core revision 20131115
> [    0.017553] ACPI: All ACPI Tables successfully acquired
> [    0.056583] ftrace: allocating 28554 entries in 112 pages
> [    0.072165] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b8 info 0000
> [    0.072169] AMD-Vi:        mmio-addr: 00000000feb80000
> [    0.072213] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:01.0 flags: 00
> [    0.072214] AMD-Vi:   DEV_RANGE_END		 devid: ff:1f.6
> [    0.073260] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 05:00.0 flags: 00 devid_to: 00:14.4
> [    0.073262] AMD-Vi:   DEV_RANGE_END		 devid: 05:1f.7
> [    0.073272] AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
> [    0.073274] AMD-Vi:   DEV_SPECIAL(IOAPIC[4])		devid: 00:14.0
> [    0.073276] AMD-Vi:   DEV_SPECIAL(IOAPIC[5])		devid: 00:00.0
> [    0.271580] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.311273] smpboot: CPU0: AMD A10-7300 Radeon R6, 10 Compute Cores 4C+6G (fam: 15, model: 30, stepping: 01)
> [    0.415445] Performance Events: Fam15h core perfctr, AMD PMU driver.
> [    0.415452] ... version:                0
> [    0.415454] ... bit width:              48
> [    0.415456] ... generic registers:      6
> [    0.415457] ... value mask:             0000ffffffffffff
> [    0.415459] ... max period:             00007fffffffffff
> [    0.415460] ... fixed-purpose events:   0
> [    0.415461] ... event mask:             000000000000003f
> [    0.417469] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> [    0.417572] x86: Booting SMP configuration:
> [    0.417575] .... node  #0, CPUs:      #1 #2 #3
> [    0.457291] x86: Booted up 1 node, 4 CPUs
> [    0.457296] smpboot: Total of 4 processors activated (15171.77 BogoMIPS)
> [    0.458465] devtmpfs: initialized
> [    0.461887] EVM: security.selinux
> [    0.461889] EVM: security.SMACK64
> [    0.461891] EVM: security.ima
> [    0.461893] EVM: security.capability
> [    0.462005] PM: Registering ACPI NVS region [mem 0x5e8b2000-0x5efb1fff] (7340032 bytes)
> [    0.463313] pinctrl core: initialized pinctrl subsystem
> [    0.463397] regulator-dummy: no parameters
> [    0.463495] RTC time:  2:13:19, date: 03/26/15
> [    0.463544] NET: Registered protocol family 16
> [    0.463711] cpuidle: using governor ladder
> [    0.463713] cpuidle: using governor menu
> [    0.463926] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.463928] ACPI: bus type PCI registered
> [    0.463930] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.464081] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    0.464084] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
> [    0.480530] PCI: Using configuration type 1 for base access
> [    0.480781] mtrr: your CPUs had inconsistent fixed MTRR settings
> [    0.480783] mtrr: your CPUs had inconsistent variable MTRR settings
> [    0.480784] mtrr: probably your BIOS does not setup all CPUs.
> [    0.480785] mtrr: corrected configuration.
> [    0.482074] bio: create slab <bio-0> at 0
> [    0.482299] ACPI: Added _OSI(Module Device)
> [    0.482301] ACPI: Added _OSI(Processor Device)
> [    0.482303] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.482304] ACPI: Added _OSI(Processor Aggregator Device)
> [    3.128232] ACPI: Interpreter enabled
> [    3.128255] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20131115/hwxface-580)
> [    3.128263] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20131115/hwxface-580)
> [    3.128291] ACPI: (supports S0 S3 S4 S5)
> [    3.128294] ACPI: Using IOAPIC for interrupt routing
> [    3.128639] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    3.128952] ACPI: No dock devices found.
> [    3.134669] ACPI: Power Resource [APPR] (off)
> [    3.146814] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
> [    3.147339] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    3.147349] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    3.147860] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> [    3.148084] acpi PNP0A08:00: ignoring host bridge window [mem 0x000cc000-0x000cffff] (conflicts with Video ROM [mem 0x000c0000-0x000cf5ff])
> [    3.148088] acpi PNP0A08:00: ignoring host bridge window [mem 0x000d0000-0x000d3fff] (conflicts with Adapter ROM [mem 0x000cf800-0x000d07ff])
> [    3.148407] PCI host bridge to bus 0000:00
> [    3.148412] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    3.148414] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
> [    3.148416] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
> [    3.148418] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
> [    3.148419] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff]
> [    3.148421] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff]
> [    3.148423] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff]
> [    3.148424] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
> [    3.148426] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
> [    3.148428] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
> [    3.148429] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
> [    3.148431] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff]
> [    3.148432] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff]
> [    3.148434] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff]
> [    3.148435] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff]
> [    3.148437] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xdfffffff]
> [    3.148439] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed3ffff]
> [    3.148440] pci_bus 0000:00: root bus resource [mem 0xfed45000-0xfffdffff]
> [    3.148448] pci 0000:00:00.0: [1022:1422] type 00 class 0x060000
> [    3.148580] pci 0000:00:00.2: [1022:1423] type 00 class 0x080600
> [    3.148737] pci 0000:00:01.0: [1002:130a] type 00 class 0x030000
> [    3.148751] pci 0000:00:01.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
> [    3.148761] pci 0000:00:01.0: reg 0x18: [mem 0xd0000000-0xd07fffff 64bit pref]
> [    3.148767] pci 0000:00:01.0: reg 0x20: [io  0x6000-0x60ff]
> [    3.148774] pci 0000:00:01.0: reg 0x24: [mem 0xd6900000-0xd693ffff]
> [    3.148781] pci 0000:00:01.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
> [    3.148815] pci 0000:00:01.0: supports D1 D2
> [    3.148817] pci 0000:00:01.0: PME# supported from D1 D2 D3hot
> [    3.148905] pci 0000:00:01.1: [1002:1308] type 00 class 0x040300
> [    3.148917] pci 0000:00:01.1: reg 0x10: [mem 0xd6940000-0xd6943fff 64bit]
> [    3.148975] pci 0000:00:01.1: supports D1 D2
> [    3.149111] pci 0000:00:02.0: [1022:1424] type 00 class 0x060000
> [    3.149199] pci 0000:00:02.1: [1022:1425] type 01 class 0x060400
> [    3.149268] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
> [    3.149421] pci 0000:00:03.0: [1022:1424] type 00 class 0x060000
> [    3.149518] pci 0000:00:03.1: [1022:1426] type 01 class 0x060400
> [    3.149587] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
> [    3.149650] pci 0000:00:03.1: System wakeup disabled by ACPI
> [    3.149683] pci 0000:00:03.2: [1022:1426] type 01 class 0x060400
> [    3.149751] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
> [    3.149809] pci 0000:00:03.2: System wakeup disabled by ACPI
> [    3.149912] pci 0000:00:03.4: [1022:1426] type 01 class 0x060400
> [    3.149980] pci 0000:00:03.4: PME# supported from D0 D3hot D3cold
> [    3.150039] pci 0000:00:03.4: System wakeup disabled by ACPI
> [    3.150132] pci 0000:00:04.0: [1022:1424] type 00 class 0x060000
> [    3.150283] pci 0000:00:10.0: [1022:7814] type 00 class 0x0c0330
> [    3.150307] pci 0000:00:10.0: reg 0x10: [mem 0xd6948000-0xd6949fff 64bit]
> [    3.150417] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
> [    3.150481] pci 0000:00:10.0: System wakeup disabled by ACPI
> [    3.150555] pci 0000:00:11.0: [1022:7801] type 00 class 0x010601
> [    3.150575] pci 0000:00:11.0: reg 0x10: [io  0x6118-0x611f]
> [    3.150585] pci 0000:00:11.0: reg 0x14: [io  0x6124-0x6127]
> [    3.150595] pci 0000:00:11.0: reg 0x18: [io  0x6110-0x6117]
> [    3.150605] pci 0000:00:11.0: reg 0x1c: [io  0x6120-0x6123]
> [    3.150615] pci 0000:00:11.0: reg 0x20: [io  0x6100-0x610f]
> [    3.150626] pci 0000:00:11.0: reg 0x24: [mem 0xd694f000-0xd694f7ff]
> [    3.150775] pci 0000:00:12.0: [1022:7807] type 00 class 0x0c0310
> [    3.150789] pci 0000:00:12.0: reg 0x10: [mem 0xd694e000-0xd694efff]
> [    3.150993] pci 0000:00:12.0: System wakeup disabled by ACPI
> [    3.151076] pci 0000:00:12.2: [1022:7808] type 00 class 0x0c0320
> [    3.151098] pci 0000:00:12.2: reg 0x10: [mem 0xd694d000-0xd694d0ff]
> [    3.151188] pci 0000:00:12.2: supports D1 D2
> [    3.151190] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot D3cold
> [    3.151255] pci 0000:00:12.2: System wakeup disabled by ACPI
> [    3.151327] pci 0000:00:13.0: [1022:7807] type 00 class 0x0c0310
> [    3.151344] pci 0000:00:13.0: reg 0x10: [mem 0xd694c000-0xd694cfff]
> [    3.151504] pci 0000:00:13.0: System wakeup disabled by ACPI
> [    3.151547] pci 0000:00:13.2: [1022:7808] type 00 class 0x0c0320
> [    3.151568] pci 0000:00:13.2: reg 0x10: [mem 0xd694b000-0xd694b0ff]
> [    3.151657] pci 0000:00:13.2: supports D1 D2
> [    3.151658] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot D3cold
> [    3.151720] pci 0000:00:13.2: System wakeup disabled by ACPI
> [    3.151791] pci 0000:00:14.0: [1022:780b] type 00 class 0x0c0500
> [    3.151976] pci 0000:00:14.2: [1022:780d] type 00 class 0x040300
> [    3.152001] pci 0000:00:14.2: reg 0x10: [mem 0xd6944000-0xd6947fff 64bit]
> [    3.152072] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
> [    3.152147] pci 0000:00:14.2: System wakeup disabled by ACPI
> [    3.152217] pci 0000:00:14.3: [1022:780e] type 00 class 0x060100
> [    3.152387] pci 0000:00:14.4: [1022:780f] type 01 class 0x060401
> [    3.152516] pci 0000:00:14.5: [1022:7809] type 00 class 0x0c0310
> [    3.152531] pci 0000:00:14.5: reg 0x10: [mem 0xd694a000-0xd694afff]
> [    3.152688] pci 0000:00:18.0: [1022:141a] type 00 class 0x060000
> [    3.152763] pci 0000:00:18.1: [1022:141b] type 00 class 0x060000
> [    3.152831] pci 0000:00:18.2: [1022:141c] type 00 class 0x060000
> [    3.152903] pci 0000:00:18.3: [1022:141d] type 00 class 0x060000
> [    3.152977] pci 0000:00:18.4: [1022:141e] type 00 class 0x060000
> [    3.153046] pci 0000:00:18.5: [1022:141f] type 00 class 0x060000
> [    3.153281] pci 0000:01:00.0: [1002:6901] type 00 class 0x038000
> [    3.153313] pci 0000:01:00.0: reg 0x10: [mem 0xa0000000-0xafffffff 64bit pref]
> [    3.153337] pci 0000:01:00.0: reg 0x18: [mem 0xb0000000-0xb01fffff 64bit pref]
> [    3.153353] pci 0000:01:00.0: reg 0x20: [io  0x5000-0x50ff]
> [    3.153369] pci 0000:01:00.0: reg 0x24: [mem 0xd6800000-0xd683ffff]
> [    3.153385] pci 0000:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
> [    3.153482] pci 0000:01:00.0: supports D1 D2
> [    3.161530] pci 0000:00:02.1: PCI bridge to [bus 01]
> [    3.161540] pci 0000:00:02.1:   bridge window [io  0x5000-0x5fff]
> [    3.161545] pci 0000:00:02.1:   bridge window [mem 0xd6800000-0xd68fffff]
> [    3.161550] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb01fffff 64bit pref]
> [    3.161711] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
> [    3.161744] pci 0000:02:00.0: reg 0x10: [io  0x4000-0x40ff]
> [    3.161780] pci 0000:02:00.0: reg 0x18: [mem 0xd5804000-0xd5804fff 64bit]
> [    3.161801] pci 0000:02:00.0: reg 0x20: [mem 0xd5800000-0xd5803fff 64bit]
> [    3.161887] pci 0000:02:00.0: supports D1 D2
> [    3.161889] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    3.161950] pci 0000:02:00.0: System wakeup disabled by ACPI
> [    3.168361] pci 0000:00:03.1: PCI bridge to [bus 02]
> [    3.168372] pci 0000:00:03.1:   bridge window [io  0x4000-0x4fff]
> [    3.168377] pci 0000:00:03.1:   bridge window [mem 0xd5800000-0xd67fffff]
> [    3.168383] pci 0000:00:03.1:   bridge window [mem 0xd0800000-0xd17fffff 64bit pref]
> [    3.168530] pci 0000:03:00.0: [168c:0032] type 00 class 0x028000
> [    3.168556] pci 0000:03:00.0: reg 0x10: [mem 0xd4800000-0xd487ffff 64bit]
> [    3.168606] pci 0000:03:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
> [    3.168662] pci 0000:03:00.0: supports D1 D2
> [    3.168664] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    3.177599] pci 0000:00:03.2: PCI bridge to [bus 03]
> [    3.177610] pci 0000:00:03.2:   bridge window [io  0x3000-0x3fff]
> [    3.177614] pci 0000:00:03.2:   bridge window [mem 0xd4800000-0xd57fffff]
> [    3.177620] pci 0000:00:03.2:   bridge window [mem 0xd1800000-0xd27fffff 64bit pref]
> [    3.177754] pci 0000:04:00.0: [10ec:5229] type 00 class 0xff0000
> [    3.177779] pci 0000:04:00.0: reg 0x10: [mem 0xd3800000-0xd3800fff]
> [    3.177906] pci 0000:04:00.0: supports D1 D2
> [    3.177908] pci 0000:04:00.0: PME# supported from D1 D2 D3hot
> [    3.184347] pci 0000:00:03.4: PCI bridge to [bus 04]
> [    3.184358] pci 0000:00:03.4:   bridge window [io  0x2000-0x2fff]
> [    3.184363] pci 0000:00:03.4:   bridge window [mem 0xd3800000-0xd47fffff]
> [    3.184369] pci 0000:00:03.4:   bridge window [mem 0xd2800000-0xd37fffff 64bit pref]
> [    3.184540] pci 0000:00:14.4: PCI bridge to [bus 05] (subtractive decode)
> [    3.184551] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
> [    3.184554] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
> [    3.184556] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
> [    3.184558] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000c3fff] (subtractive decode)
> [    3.184560] pci 0000:00:14.4:   bridge window [mem 0x000c4000-0x000c7fff] (subtractive decode)
> [    3.184562] pci 0000:00:14.4:   bridge window [mem 0x000c8000-0x000cbfff] (subtractive decode)
> [    3.184564] pci 0000:00:14.4:   bridge window [mem 0x000d4000-0x000d7fff] (subtractive decode)
> [    3.184566] pci 0000:00:14.4:   bridge window [mem 0x000d8000-0x000dbfff] (subtractive decode)
> [    3.184568] pci 0000:00:14.4:   bridge window [mem 0x000dc000-0x000dffff] (subtractive decode)
> [    3.184570] pci 0000:00:14.4:   bridge window [mem 0x000e0000-0x000e3fff] (subtractive decode)
> [    3.184572] pci 0000:00:14.4:   bridge window [mem 0x000e4000-0x000e7fff] (subtractive decode)
> [    3.184573] pci 0000:00:14.4:   bridge window [mem 0x000e8000-0x000ebfff] (subtractive decode)
> [    3.184575] pci 0000:00:14.4:   bridge window [mem 0x000ec000-0x000effff] (subtractive decode)
> [    3.184577] pci 0000:00:14.4:   bridge window [mem 0x000f0000-0x000fffff] (subtractive decode)
> [    3.184579] pci 0000:00:14.4:   bridge window [mem 0xa0000000-0xdfffffff] (subtractive decode)
> [    3.184581] pci 0000:00:14.4:   bridge window [mem 0xf0000000-0xfed3ffff] (subtractive decode)
> [    3.184583] pci 0000:00:14.4:   bridge window [mem 0xfed45000-0xfffdffff] (subtractive decode)
> [    3.184627] acpi PNP0A08:00: Disabling ASPM (FADT indicates it is unsupported)
> [    3.185979] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15) *0
> [    3.186077] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0
> [    3.186174] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15) *0
> [    3.186270] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15) *0
> [    3.186346] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0
> [    3.186407] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0
> [    3.186467] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0
> [    3.186527] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0
> [    3.187408] ACPI: Enabled 2 GPEs in block 00 to 1F
> [    3.187419] ACPI: \_SB_.PCI0: notify handler is installed
> [    3.187533] Found 1 acpi root devices
> [    3.187608] ACPI : EC: GPE = 0x3, I/O: command/status = 0x66, data = 0x62
> [    3.187767] vgaarb: setting as boot device: PCI:0000:00:01.0
> [    3.187770] vgaarb: device added: PCI:0000:00:01.0,decodes=io+mem,owns=io+mem,locks=none
> [    3.187781] vgaarb: loaded
> [    3.187783] vgaarb: bridge control possible 0000:00:01.0
> [    3.188000] SCSI subsystem initialized
> [    3.188135] libata version 3.00 loaded.
> [    3.188180] ACPI: bus type USB registered
> [    3.188204] usbcore: registered new interface driver usbfs
> [    3.188215] usbcore: registered new interface driver hub
> [    3.188252] usbcore: registered new device driver usb
> [    3.188466] PCI: Using ACPI for IRQ routing
> [    3.197688] PCI: pci_cache_line_size set to 64 bytes
> [    3.197791] Expanded resource reserved due to conflict with PCI Bus 0000:00
> [    3.197794] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
> [    3.197797] e820: reserve RAM buffer [mem 0x5d9b6000-0x5fffffff]
> [    3.197798] e820: reserve RAM buffer [mem 0x5f000000-0x5fffffff]
> [    3.197800] e820: reserve RAM buffer [mem 0x25f000000-0x25fffffff]
> [    3.197927] NetLabel: Initializing
> [    3.197930] NetLabel:  domain hash size = 128
> [    3.197931] NetLabel:  protocols = UNLABELED CIPSOv4
> [    3.197946] NetLabel:  unlabeled traffic allowed by default
> [    3.198213] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    3.198218] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [    3.200349] Switched to clocksource hpet
> [    3.207979] AppArmor: AppArmor Filesystem Enabled
> [    3.208013] pnp: PnP ACPI init
> [    3.208029] ACPI: bus type PNP registered
> [    3.208173] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
> [    3.208176] system 00:00: [mem 0xfeb00000-0xfeb00fff] has been reserved
> [    3.208178] system 00:00: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    3.208181] system 00:00: [mem 0xfec20000-0xfec20fff] could not be reserved
> [    3.208183] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
> [    3.208187] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    3.208434] pnp 00:01: [dma 4]
> [    3.208458] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
> [    3.208533] pnp 00:02: Plug and Play ACPI device, IDs PNP0c04 (active)
> [    3.208560] pnp 00:03: Plug and Play ACPI device, IDs PNP0800 (active)
> [    3.208660] system 00:04: [io  0x0400-0x04cf] could not be reserved
> [    3.208662] system 00:04: [io  0x04d0-0x04d1] has been reserved
> [    3.208664] system 00:04: [io  0x04d6] has been reserved
> [    3.208666] system 00:04: [io  0x0680-0x06ff] has been reserved
> [    3.208668] system 00:04: [io  0x077a] has been reserved
> [    3.208670] system 00:04: [io  0x0c00-0x0c01] has been reserved
> [    3.208672] system 00:04: [io  0x0c14] has been reserved
> [    3.208674] system 00:04: [io  0x0c50-0x0c52] has been reserved
> [    3.208675] system 00:04: [io  0x0c6c] has been reserved
> [    3.208677] system 00:04: [io  0x0c6f] has been reserved
> [    3.208679] system 00:04: [io  0x0cd0-0x0cdb] has been reserved
> [    3.208681] system 00:04: [io  0x0220-0x0227] has been reserved
> [    3.208683] system 00:04: [io  0x0260-0x0273] has been reserved
> [    3.208685] system 00:04: [io  0x0800] has been reserved
> [    3.208687] system 00:04: [io  0x0804] has been reserved
> [    3.208688] system 00:04: [io  0x087f] has been reserved
> [    3.208690] system 00:04: [io  0x0cdc-0x0cdf] has been reserved
> [    3.208692] system 00:04: [io  0x0b00-0x0b0f] has been reserved
> [    3.208695] system 00:04: [io  0x0200-0x027f] could not be reserved
> [    3.208697] system 00:04: [io  0x1770-0x1777] has been reserved
> [    3.208699] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    3.208779] system 00:05: [mem 0x00000000-0x0009ffff] could not be reserved
> [    3.208782] system 00:05: [mem 0x00100000-0x9fffffff] could not be reserved
> [    3.208784] system 00:05: [mem 0xffe00000-0xffffffff] could not be reserved
> [    3.208786] system 00:05: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    3.208909] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    3.209037] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
> [    3.209101] pnp 00:08: Plug and Play ACPI device, IDs HPQ8001 PNP0303 (active)
> [    3.209136] pnp 00:09: Plug and Play ACPI device, IDs SYN301c SYN0100 SYN0002 PNP0f13 (active)
> [    3.209337] pnp 00:0a: Plug and Play ACPI device, IDs HPQ6007 (active)
> [    3.209556] pnp 00:0b: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
> [    3.209795] pnp: PnP ACPI: found 12 devices
> [    3.209796] ACPI: bus type PNP unregistered
> [    3.217642] pci 0000:00:01.0: no compatible bridge window for [mem 0xfffe0000-0xffffffff pref]
> [    3.217646] pci 0000:01:00.0: no compatible bridge window for [mem 0xfffe0000-0xffffffff pref]
> [    3.217650] pci 0000:03:00.0: no compatible bridge window for [mem 0xffff0000-0xffffffff pref]
> [    3.217724] pci 0000:00:01.0: BAR 6: assigned [mem 0xb0200000-0xb021ffff pref]
> [    3.217728] pci 0000:01:00.0: BAR 6: assigned [mem 0xd6840000-0xd685ffff pref]
> [    3.217731] pci 0000:00:02.1: PCI bridge to [bus 01]
> [    3.217734] pci 0000:00:02.1:   bridge window [io  0x5000-0x5fff]
> [    3.217738] pci 0000:00:02.1:   bridge window [mem 0xd6800000-0xd68fffff]
> [    3.217741] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb01fffff 64bit pref]
> [    3.217747] pci 0000:00:03.1: PCI bridge to [bus 02]
> [    3.217750] pci 0000:00:03.1:   bridge window [io  0x4000-0x4fff]
> [    3.217754] pci 0000:00:03.1:   bridge window [mem 0xd5800000-0xd67fffff]
> [    3.217758] pci 0000:00:03.1:   bridge window [mem 0xd0800000-0xd17fffff 64bit pref]
> [    3.217764] pci 0000:03:00.0: BAR 6: assigned [mem 0xd1800000-0xd180ffff pref]
> [    3.217766] pci 0000:00:03.2: PCI bridge to [bus 03]
> [    3.217768] pci 0000:00:03.2:   bridge window [io  0x3000-0x3fff]
> [    3.217772] pci 0000:00:03.2:   bridge window [mem 0xd4800000-0xd57fffff]
> [    3.217776] pci 0000:00:03.2:   bridge window [mem 0xd1800000-0xd27fffff 64bit pref]
> [    3.217781] pci 0000:00:03.4: PCI bridge to [bus 04]
> [    3.217783] pci 0000:00:03.4:   bridge window [io  0x2000-0x2fff]
> [    3.217787] pci 0000:00:03.4:   bridge window [mem 0xd3800000-0xd47fffff]
> [    3.217791] pci 0000:00:03.4:   bridge window [mem 0xd2800000-0xd37fffff 64bit pref]
> [    3.217796] pci 0000:00:14.4: PCI bridge to [bus 05]
> [    3.217839] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
> [    3.217840] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
> [    3.217842] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
> [    3.217844] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff]
> [    3.217846] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff]
> [    3.217847] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff]
> [    3.217849] pci_bus 0000:00: resource 10 [mem 0x000d4000-0x000d7fff]
> [    3.217851] pci_bus 0000:00: resource 11 [mem 0x000d8000-0x000dbfff]
> [    3.217852] pci_bus 0000:00: resource 12 [mem 0x000dc000-0x000dffff]
> [    3.217854] pci_bus 0000:00: resource 13 [mem 0x000e0000-0x000e3fff]
> [    3.217856] pci_bus 0000:00: resource 14 [mem 0x000e4000-0x000e7fff]
> [    3.217857] pci_bus 0000:00: resource 15 [mem 0x000e8000-0x000ebfff]
> [    3.217859] pci_bus 0000:00: resource 16 [mem 0x000ec000-0x000effff]
> [    3.217860] pci_bus 0000:00: resource 17 [mem 0x000f0000-0x000fffff]
> [    3.217862] pci_bus 0000:00: resource 18 [mem 0xa0000000-0xdfffffff]
> [    3.217864] pci_bus 0000:00: resource 19 [mem 0xf0000000-0xfed3ffff]
> [    3.217865] pci_bus 0000:00: resource 20 [mem 0xfed45000-0xfffdffff]
> [    3.217868] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
> [    3.217869] pci_bus 0000:01: resource 1 [mem 0xd6800000-0xd68fffff]
> [    3.217871] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xb01fffff 64bit pref]
> [    3.217873] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
> [    3.217875] pci_bus 0000:02: resource 1 [mem 0xd5800000-0xd67fffff]
> [    3.217876] pci_bus 0000:02: resource 2 [mem 0xd0800000-0xd17fffff 64bit pref]
> [    3.217878] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
> [    3.217880] pci_bus 0000:03: resource 1 [mem 0xd4800000-0xd57fffff]
> [    3.217882] pci_bus 0000:03: resource 2 [mem 0xd1800000-0xd27fffff 64bit pref]
> [    3.217883] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
> [    3.217885] pci_bus 0000:04: resource 1 [mem 0xd3800000-0xd47fffff]
> [    3.217887] pci_bus 0000:04: resource 2 [mem 0xd2800000-0xd37fffff 64bit pref]
> [    3.217889] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
> [    3.217890] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
> [    3.217892] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
> [    3.217894] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000c3fff]
> [    3.217895] pci_bus 0000:05: resource 8 [mem 0x000c4000-0x000c7fff]
> [    3.217897] pci_bus 0000:05: resource 9 [mem 0x000c8000-0x000cbfff]
> [    3.217899] pci_bus 0000:05: resource 10 [mem 0x000d4000-0x000d7fff]
> [    3.217900] pci_bus 0000:05: resource 11 [mem 0x000d8000-0x000dbfff]
> [    3.217902] pci_bus 0000:05: resource 12 [mem 0x000dc000-0x000dffff]
> [    3.217904] pci_bus 0000:05: resource 13 [mem 0x000e0000-0x000e3fff]
> [    3.217905] pci_bus 0000:05: resource 14 [mem 0x000e4000-0x000e7fff]
> [    3.217907] pci_bus 0000:05: resource 15 [mem 0x000e8000-0x000ebfff]
> [    3.217908] pci_bus 0000:05: resource 16 [mem 0x000ec000-0x000effff]
> [    3.217910] pci_bus 0000:05: resource 17 [mem 0x000f0000-0x000fffff]
> [    3.217912] pci_bus 0000:05: resource 18 [mem 0xa0000000-0xdfffffff]
> [    3.217913] pci_bus 0000:05: resource 19 [mem 0xf0000000-0xfed3ffff]
> [    3.217915] pci_bus 0000:05: resource 20 [mem 0xfed45000-0xfffdffff]
> [    3.217952] NET: Registered protocol family 2
> [    3.218250] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
> [    3.218529] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [    3.218789] TCP: Hash tables configured (established 65536 bind 65536)
> [    3.218826] TCP: reno registered
> [    3.218843] UDP hash table entries: 4096 (order: 5, 131072 bytes)
> [    3.218893] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
> [    3.219011] NET: Registered protocol family 1
> [    3.219032] pci 0000:00:01.0: Video device with shadowed ROM
> [    3.333351] PCI: CLS mismatch (64 != 32), using 64 bytes
> [    3.388911] Trying to unpack rootfs image as initramfs...
> [    3.903592] Freeing initrd memory: 31236K (ffff8800342ee000 - ffff88003616f000)
> [    3.903713] AMD-Vi: IOMMU performance counters supported
> [    3.903958] pci 0000:00:00.2: can't derive routing for PCI INT A
> [    3.903961] pci 0000:00:00.2: PCI INT A: no GSI - using ISA IRQ 11
> [    3.904316] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
> [    3.904318] AMD-Vi:  Extended features:  PPR GT IA PC
> [    3.904323] AMD-Vi: Interrupt remapping enabled
> [    3.904355] pci 0000:00:00.2: irq 72 for MSI/MSI-X
> [    3.905664] AMD-Vi: Using passthrough domain for device 0000:00:01.0
> [    3.919171] AMD-Vi: Using passthrough domain for device 0000:01:00.0
> [    3.920903] AMD-Vi: Lazy IO/TLB flushing enabled
> [    3.921444] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    3.921448] software IO TLB [mem 0x599b6000-0x5d9b6000] (64MB) mapped at [ffff8800599b6000-ffff88005d9b5fff]
> [    3.921781] perf: amd_iommu: Detected. (2 banks, 4 counters/bank)
> [    3.921785] LVT offset 0 assigned for vector 0x400
> [    3.921811] perf: AMD IBS detected (0x000001ff)
> [    3.921868] microcode: CPU0: patch_level=0x06003106
> [    3.921906] microcode: CPU1: patch_level=0x06003106
> [    3.921921] microcode: CPU2: patch_level=0x06003106
> [    3.921933] microcode: CPU3: patch_level=0x06003106
> [    3.922025] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
> [    3.922028] Scanning for low memory corruption every 60 seconds
> [    3.922431] Initialise system trusted keyring
> [    3.922482] audit: initializing netlink socket (disabled)
> [    3.922497] type=2000 audit(1427336001.584:1): initialized
> [    3.953477] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    3.955197] zbud: loaded
> [    3.955429] VFS: Disk quotas dquot_6.5.2
> [    3.955478] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    3.956137] fuse init (API version 7.22)
> [    3.956256] msgmni has been set to 13712
> [    3.956315] Key type big_key registered
> [    3.956997] Key type asymmetric registered
> [    3.957003] Asymmetric key parser 'x509' registered
> [    3.957078] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
> [    3.957153] io scheduler noop registered
> [    3.957155] io scheduler deadline registered (default)
> [    3.957190] io scheduler cfq registered
> [    3.957612] pcieport 0000:00:02.1: irq 73 for MSI/MSI-X
> [    3.957974] pcieport 0000:00:03.1: irq 74 for MSI/MSI-X
> [    3.958308] pcieport 0000:00:03.2: irq 75 for MSI/MSI-X
> [    3.958646] pcieport 0000:00:03.4: irq 76 for MSI/MSI-X
> [    3.958745] pcieport 0000:00:02.1: Signaling PME through PCIe PME interrupt
> [    3.958748] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    3.958752] pcie_pme 0000:00:02.1:pcie01: service driver pcie_pme loaded
> [    3.958770] pcieport 0000:00:03.1: Signaling PME through PCIe PME interrupt
> [    3.958772] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
> [    3.958776] pcie_pme 0000:00:03.1:pcie01: service driver pcie_pme loaded
> [    3.958795] pcieport 0000:00:03.2: Signaling PME through PCIe PME interrupt
> [    3.958797] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
> [    3.958801] pcie_pme 0000:00:03.2:pcie01: service driver pcie_pme loaded
> [    3.958818] pcieport 0000:00:03.4: Signaling PME through PCIe PME interrupt
> [    3.958820] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
> [    3.958823] pcie_pme 0000:00:03.4:pcie01: service driver pcie_pme loaded
> [    3.958839] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    3.958973] pciehp 0000:00:02.1:pcie04: HPC vendor_id 1022 device_id 1425 ss_vid 1022 ss_did 1234
> [    3.959075] pciehp 0000:00:02.1:pcie04: service driver pciehp loaded
> [    3.959088] pciehp 0000:00:03.2:pcie04: HPC vendor_id 1022 device_id 1426 ss_vid 1022 ss_did 1234
> [    3.959122] pciehp 0000:00:03.2:pcie04: service driver pciehp loaded
> [    3.959133] pciehp 0000:00:03.4:pcie04: HPC vendor_id 1022 device_id 1426 ss_vid 1022 ss_did 1234
> [    3.959163] pciehp 0000:00:03.4:pcie04: service driver pciehp loaded
> [    3.959168] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    3.959229] ipmi message handler version 39.2
> [    3.959489] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
> [    3.959855] ACPI: AC Adapter [AC] (on-line)
> [    3.959944] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input0
> [    3.959948] ACPI: Sleep Button [SLPB]
> [    3.959986] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
> [    3.960014] ACPI: Lid Switch [LID]
> [    3.960554] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [    3.960557] ACPI: Power Button [PWRF]
> [    3.960645] ACPI: acpi_idle registered with cpuidle
> [    4.002619] thermal LNXTHERM:00: registered as thermal_zone0
> [    4.002624] ACPI: Thermal Zone [CPUZ] (47 C)
> [    4.042020] thermal LNXTHERM:01: registered as thermal_zone1
> [    4.042025] ACPI: Thermal Zone [GFXZ] (0 C)
> [    4.063006] thermal LNXTHERM:02: registered as thermal_zone2
> [    4.063011] ACPI: Thermal Zone [EXTZ] (0 C)
> [    4.085211] thermal LNXTHERM:03: registered as thermal_zone3
> [    4.085216] ACPI: Thermal Zone [LOCZ] (0 C)
> [    4.107594] thermal LNXTHERM:04: registered as thermal_zone4
> [    4.107599] ACPI: Thermal Zone [BATZ] (21 C)
> [    4.107699] GHES: HEST is not enabled!
> [    4.107861] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    4.109904] Linux agpgart interface v0.103
> [    4.110057] tpm_tis 00:0b: 1.2 TPM (device-id 0x1A, rev-id 16)
> [    4.137380] ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
> [    4.137389] ACPI: Battery Slot [BAT0] (battery present)
> [    4.410842] brd: module loaded
> [    4.411976] loop: module loaded
> [    4.412566] libphy: Fixed MDIO Bus: probed
> [    4.412673] tun: Universal TUN/TAP device driver, 1.6
> [    4.412675] tun: (C) 1999-2004 Max Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
> [    4.412815] PPP generic driver version 2.4.2
> [    4.412914] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    4.412927] ehci-pci: EHCI PCI platform driver
> [    4.413264] QUIRK: Enable AMD PLL fix
> [    4.413304] ehci-pci 0000:00:12.2: EHCI Host Controller
> [    4.413312] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
> [    4.413318] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    4.413331] ehci-pci 0000:00:12.2: debug port 1
> [    4.413388] ehci-pci 0000:00:12.2: irq 17, io mem 0xd694d000
> [    4.424672] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
> [    4.424759] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    4.424762] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.424764] usb usb1: Product: EHCI Host Controller
> [    4.424766] usb usb1: Manufacturer: Linux 3.13.0-45-generic ehci_hcd
> [    4.424767] usb usb1: SerialNumber: 0000:00:12.2
> [    4.425055] hub 1-0:1.0: USB hub found
> [    4.425071] hub 1-0:1.0: 5 ports detected
> [    4.425731] ehci-pci 0000:00:13.2: EHCI Host Controller
> [    4.425739] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
> [    4.425744] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    4.425757] ehci-pci 0000:00:13.2: debug port 1
> [    4.425800] ehci-pci 0000:00:13.2: irq 17, io mem 0xd694b000
> [    4.436701] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
> [    4.436781] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
> [    4.436783] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.436786] usb usb2: Product: EHCI Host Controller
> [    4.436787] usb usb2: Manufacturer: Linux 3.13.0-45-generic ehci_hcd
> [    4.436789] usb usb2: SerialNumber: 0000:00:13.2
> [    4.437070] hub 2-0:1.0: USB hub found
> [    4.437080] hub 2-0:1.0: 5 ports detected
> [    4.437316] ehci-platform: EHCI generic platform driver
> [    4.437331] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    4.437333] ohci-pci: OHCI PCI platform driver
> [    4.437698] ohci-pci 0000:00:12.0: OHCI PCI host controller
> [    4.437706] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
> [    4.437750] ohci-pci 0000:00:12.0: irq 18, io mem 0xd694e000
> [    4.496756] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
> [    4.496761] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.496763] usb usb3: Product: OHCI PCI host controller
> [    4.496765] usb usb3: Manufacturer: Linux 3.13.0-45-generic ohci_hcd
> [    4.496767] usb usb3: SerialNumber: 0000:00:12.0
> [    4.497066] hub 3-0:1.0: USB hub found
> [    4.497082] hub 3-0:1.0: 5 ports detected
> [    4.497698] ohci-pci 0000:00:13.0: OHCI PCI host controller
> [    4.497707] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 4
> [    4.497730] ohci-pci 0000:00:13.0: irq 18, io mem 0xd694c000
> [    4.556771] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
> [    4.556776] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.556778] usb usb4: Product: OHCI PCI host controller
> [    4.556780] usb usb4: Manufacturer: Linux 3.13.0-45-generic ohci_hcd
> [    4.556782] usb usb4: SerialNumber: 0000:00:13.0
> [    4.557074] hub 4-0:1.0: USB hub found
> [    4.557091] hub 4-0:1.0: 5 ports detected
> [    4.557556] ohci-pci 0000:00:14.5: OHCI PCI host controller
> [    4.557564] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 5
> [    4.557589] ohci-pci 0000:00:14.5: irq 18, io mem 0xd694a000
> [    4.616755] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
> [    4.616760] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.616763] usb usb5: Product: OHCI PCI host controller
> [    4.616764] usb usb5: Manufacturer: Linux 3.13.0-45-generic ohci_hcd
> [    4.616766] usb usb5: SerialNumber: 0000:00:14.5
> [    4.617065] hub 5-0:1.0: USB hub found
> [    4.617081] hub 5-0:1.0: 2 ports detected
> [    4.617293] ohci-platform: OHCI generic platform driver
> [    4.617309] uhci_hcd: USB Universal Host Controller Interface driver
> [    4.617688] xhci_hcd 0000:00:10.0: xHCI Host Controller
> [    4.617696] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
> [    4.617975] xhci_hcd 0000:00:10.0: irq 77 for MSI/MSI-X
> [    4.617985] xhci_hcd 0000:00:10.0: irq 78 for MSI/MSI-X
> [    4.617997] xhci_hcd 0000:00:10.0: irq 79 for MSI/MSI-X
> [    4.618006] xhci_hcd 0000:00:10.0: irq 80 for MSI/MSI-X
> [    4.618014] xhci_hcd 0000:00:10.0: irq 81 for MSI/MSI-X
> [    4.618166] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
> [    4.618168] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.618170] usb usb6: Product: xHCI Host Controller
> [    4.618172] usb usb6: Manufacturer: Linux 3.13.0-45-generic xhci_hcd
> [    4.618173] usb usb6: SerialNumber: 0000:00:10.0
> [    4.618351] hub 6-0:1.0: USB hub found
> [    4.618394] hub 6-0:1.0: 2 ports detected
> [    4.618621] xhci_hcd 0000:00:10.0: xHCI Host Controller
> [    4.618625] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 7
> [    4.621412] usb usb7: New USB device found, idVendor=1d6b, idProduct=0003
> [    4.621414] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.621416] usb usb7: Product: xHCI Host Controller
> [    4.621418] usb usb7: Manufacturer: Linux 3.13.0-45-generic xhci_hcd
> [    4.621420] usb usb7: SerialNumber: 0000:00:10.0
> [    4.621573] hub 7-0:1.0: USB hub found
> [    4.621615] hub 7-0:1.0: 2 ports detected
> [    4.633110] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    4.635073] i8042: Detected active multiplexing controller, rev 1.1
> [    4.636076] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    4.636090] serio: i8042 AUX0 port at 0x60,0x64 irq 12
> [    4.636124] serio: i8042 AUX1 port at 0x60,0x64 irq 12
> [    4.636148] serio: i8042 AUX2 port at 0x60,0x64 irq 12
> [    4.636168] serio: i8042 AUX3 port at 0x60,0x64 irq 12
> [    4.636414] mousedev: PS/2 mouse device common for all mice
> [    4.636737] rtc_cmos 00:06: RTC can wake from S4
> [    4.636892] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
> [    4.636926] rtc_cmos 00:06: alarms up to one month, 114 bytes nvram, hpet irqs
> [    4.637018] device-mapper: uevent: version 1.0.3
> [    4.637120] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> [    4.637130] ledtrig-cpu: registered to indicate activity on CPUs
> [    4.637249] TCP: cubic registered
> [    4.637356] NET: Registered protocol family 10
> [    4.637570] NET: Registered protocol family 17
> [    4.637581] Key type dns_resolver registered
> [    4.638291] Loading compiled-in X.509 certificates
> [    4.639255] Loaded X.509 cert 'Magrathea: Glacier signing key: 34992139f3da40b620bd5517597ba85af5797c9a'
> [    4.639315] registered taskstats version 1
> [    4.642587] Key type trusted registered
> [    4.644890] Key type encrypted registered
> [    4.647127] AppArmor: AppArmor sha1 policy hashing enabled
> [    4.661263] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
> [    4.740749] usb 1-5: new high-speed USB device number 2 using ehci-pci
> [    4.920681] tsc: Refined TSC clocksource calibration: 1896.456 MHz
> [    4.958887] usb 1-5: New USB device found, idVendor=04ca, idProduct=7022
> [    4.958892] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    4.958894] usb 1-5: Product: HP HD Webcam
> [    4.958896] usb 1-5: Manufacturer: DDZLD01G46C6VD
> [    5.164915] usb 5-2: new full-speed USB device number 2 using ohci-pci
> [    5.301416] regulator-dummy: disabling
> [    5.301628]   Magic number: 7:312:208
> [    5.301666] vc vcsa: hash matches
> [    5.301773] rtc_cmos 00:06: setting system clock to 2015-03-26 02:13:24 UTC (1427336004)
> [    5.302010] acpi-cpufreq: overriding BIOS provided _PSD data
> [    5.302381] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
> [    5.302383] EDD information not available.
> [    5.302429] PM: Hibernation image not present or could not be loaded.
> [    5.303793] Freeing unused kernel memory: 1336K (ffffffff81d20000 - ffffffff81e6e000)
> [    5.303796] Write protecting the kernel read-only data: 12288k
> [    5.307400] Freeing unused kernel memory: 796K (ffff880001739000 - ffff880001800000)
> [    5.310568] Freeing unused kernel memory: 688K (ffff880001b54000 - ffff880001c00000)
> [    5.330890] systemd-udevd[120]: starting version 204
> [    5.333939] usb 5-2: New USB device found, idVendor=138a, idProduct=003f
> [    5.333945] usb 5-2: New USB device strings: Mfr=0, Product=0, SerialNumber=1
> [    5.333948] usb 5-2: SerialNumber: 00b0245f4c92
> [    5.350932] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [    5.362327] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    5.362343] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
> [    5.364740] ahci 0000:00:11.0: version 3.0
> [    5.382556] rtsx_pci 0000:04:00.0: irq 82 for MSI/MSI-X
> [    5.382588] rtsx_pci 0000:04:00.0: rtsx_pci_acquire_irq: pcr->msi_en = 1, pci->irq = 82
> [    5.384471] ahci 0000:00:11.0: irq 83 for MSI/MSI-X
> [    5.384483] ahci 0000:00:11.0: irq 84 for MSI/MSI-X
> [    5.384492] ahci 0000:00:11.0: irq 85 for MSI/MSI-X
> [    5.384500] ahci 0000:00:11.0: irq 86 for MSI/MSI-X
> [    5.384508] ahci 0000:00:11.0: irq 87 for MSI/MSI-X
> [    5.384516] ahci 0000:00:11.0: irq 88 for MSI/MSI-X
> [    5.384523] ahci 0000:00:11.0: irq 89 for MSI/MSI-X
> [    5.384581] ahci 0000:00:11.0: irq 90 for MSI/MSI-X
> [    5.384665] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> [    5.384671] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
> [    5.386691] wmi: Mapper loaded
> [    5.389019] r8169 0000:02:00.0: irq 91 for MSI/MSI-X
> [    5.389259] r8169 0000:02:00.0 eth0: RTL8168g/8111g at 0xffffc90000d82000, a0:2b:b8:33:f8:73, XID 10900800 IRQ 91
> [    5.389264] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [    5.390055] scsi0 : ahci
> [    5.390217] scsi1 : ahci
> [    5.390312] ata1: SATA max UDMA/133 abar m2048@0xd694f000 port 0xd694f100 irq 83
> [    5.390317] ata2: SATA max UDMA/133 abar m2048@0xd694f000 port 0xd694f180 irq 84
> [    5.413916] acpi device:01: registered as cooling_device4
> [    5.414078] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input11
> [    5.415565] ACPI: Video Device [DGFX] (multi-head: yes  rom: no  post: no)
> [    5.417327] acpi device:0b: registered as cooling_device5
> [    5.417475] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:0a/LNXVIDEO:01/input/input12
> [    5.881505] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    5.881536] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    5.884826] ata1.00: ATA-9: HGST HTS541010A9E680, JA0OA710, max UDMA/133
> [    5.884832] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
> [    5.886380] ata2.00: ATAPI: hp       DVDRW  SU208FB, HH01, max UDMA/100
> [    5.886737] ata1.00: configured for UDMA/133
> [    5.886919] scsi 0:0:0:0: Direct-Access     ATA      HGST HTS541010A9 JA0O PQ: 0 ANSI: 5
> [    5.887165] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    5.887186] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    5.887189] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [    5.887336] sd 0:0:0:0: [sda] Write Protect is off
> [    5.887340] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    5.887394] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    5.889189] ata2.00: configured for UDMA/100
> [    5.897466] scsi 1:0:0:0: CD-ROM            hp       DVDRW  SU208FB   HH01 PQ: 0 ANSI: 5
> [    5.908816] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
> [    5.908823] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    5.909057] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [    5.909180] sr 1:0:0:0: Attached scsi generic sg1 type 5
> [    5.922094] Switched to clocksource tsc
> [    5.967577]  sda: sda1 sda2 sda3
> [    5.968354] sd 0:0:0:0: [sda] Attached SCSI disk
> [    6.232351] psmouse serio3: synaptics: Touchpad model: 1, fw: 7.5, id: 0x1e0b1, caps: 0xf00173/0x640000/0xa2400, board id: 2653, fw id: 1481159
> [    6.272050] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio3/input/input10
> [    8.004756] raid6: sse2x1    5891 MB/s
> [    8.072758] raid6: sse2x2    8250 MB/s
> [    8.140768] raid6: sse2x4    9447 MB/s
> [    8.140770] raid6: using algorithm sse2x4 (9447 MB/s)
> [    8.140771] raid6: using ssse3x2 recovery algorithm
> [    8.142436] xor: automatically using best checksumming function:
> [    8.180873]    avx       :  8733.000 MB/sec
> [    8.194646] bio: create slab <bio-1> at 1
> [    8.195049] Btrfs loaded
> [    8.252847] random: nonblocking pool is initialized
> [    8.587973] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
> [   18.861643] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
> [   18.913009] Adding 7282684k swap on /dev/sda3.  Priority:-1 extents:1 across:7282684k FS
> [   19.071730] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   19.215239] systemd-udevd[390]: starting version 204
> [   19.608140] lp: driver loaded but no devices found
> [   19.627265] ppdev: user-space parallel port driver
> [   19.627862] Initializing HPQ6001 module
> [   19.627985] input: HP Wireless hotkeys as /devices/virtual/input/input14
> [   19.643350] hp_accel: laptop model unknown, using default axes configuration
> [   19.680011] AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> [   19.687318] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [   19.690260] fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
> [   19.690266] Disabling lock debugging due to kernel taint
> [   19.728330] ACPI Warning: 0x0000000000000b00-0x0000000000000b07 SystemIO conflicts with Region \_SB_.PCI0.SMBS.SMBO 1 (20131115/utaddress-251)
> [   19.728340] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   19.768562] fglrx: module verification failed: signature and/or  required key missing - tainting kernel
> [   19.773139] lis3lv02d: 8 bits 3DC sensor found
> [   19.776807] cfg80211: Calling CRDA to update world regulatory domain
> [   19.797615] <6>[fglrx] Maximum main memory to use for locked dma buffers: 6645 MBytes.
> [   19.797828] <6>[fglrx]   vendor: 1002 device: 130a count: 1
> [   19.798035] MCE: In-kernel MCE decoding enabled.
> [   19.798729] <6>[fglrx]   vendor: 1002 device: 6901 count: 2
> [   19.798909] <6>[fglrx] IOMMU is enabled, CrossFire are not supported on this platform
> [   19.798912] <6>[fglrx] Disable IOMMU in BIOS options or kernel boot parameters to support CF
> [   19.801933] EDAC MC: Ver: 3.0.0
> [   19.807269] AMD64 EDAC driver v3.4.0
> [   19.807328] EDAC amd64: DRAM ECC disabled.
> [   19.807339] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
> [   19.807339]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
> [   19.807339]  (Note that use of the override may cause unknown side effects.)
> [   19.808563] <6>[fglrx] ioport: bar 4, base 0x6000, size: 0x100
> [   19.810011] <6>[fglrx] ioport: bar 4, base 0x5000, size: 0x100
> [   19.810324] <6>[fglrx] Kernel PAT support is enabled
> [   19.810371] <6>[fglrx] module loaded - fglrx 14.30.4 [Feb 27 2015] with 2 minors
> [   19.828188] snd_hda_intel 0000:00:01.1: Probing card using HDA DKMS, version 0.201503121632~ubuntu14.04.1
> [   19.828971] snd_hda_intel 0000:00:01.1: irq 92 for MSI/MSI-X
> [   19.829085] snd_hda_intel 0000:00:14.2: Probing card using HDA DKMS, version 0.201503121632~ubuntu14.04.1
> [   19.845203] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input15
> [   19.856058] sound hdaudioC1D0: autoconfig for ALC3227: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   19.856072] sound hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   19.856076] sound hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [   19.856080] sound hdaudioC1D0:    mono: mono_out=0x0
> [   19.856083] sound hdaudioC1D0:    inputs:
> [   19.856087] sound hdaudioC1D0:      Mic=0x19
> [   19.856090] sound hdaudioC1D0:      Internal Mic=0x12
> [   19.868511] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:14.2/sound/card1/input17
> [   19.879618] ath: phy0: Enable LNA combining
> [   19.880803] ath: EEPROM regdomain: 0x60
> [   19.880806] ath: EEPROM indicates we should expect a direct regpair map
> [   19.880810] ath: Country alpha2 being used: 00
> [   19.880812] ath: Regpair used: 0x60
> [   19.892797] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> [   19.893013] device-mapper: multipath: version 1.6.0 loaded
> [   19.893403] ieee80211 phy0: Atheros AR9485 Rev:1 mem=0xffffc90011f00000, irq=36
> [   19.936777] kvm: Nested Virtualization enabled
> [   19.936783] kvm: Nested Paging enabled
> [   19.954827] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:14.2/sound/card1/input16
> [   19.956095] serio_raw serio3: raw access enabled on isa0060/serio3 (serio_raw0, minor 57)
> [   20.124406] Bluetooth: Core ver 2.17
> [   20.124431] NET: Registered protocol family 31
> [   20.124434] Bluetooth: HCI device and connection manager initialized
> [   20.124445] Bluetooth: HCI socket layer initialized
> [   20.124448] Bluetooth: L2CAP socket layer initialized
> [   20.124453] Bluetooth: SCO socket layer initialized
> [   20.129080] Bluetooth: RFCOMM TTY layer initialized
> [   20.129096] Bluetooth: RFCOMM socket layer initialized
> [   20.129104] Bluetooth: RFCOMM ver 1.11
> [   20.130702] type=1400 audit(1427336019.324:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=723 comm="apparmor_parser"
> [   20.130711] type=1400 audit(1427336019.324:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=723 comm="apparmor_parser"
> [   20.130718] type=1400 audit(1427336019.324:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=723 comm="apparmor_parser"
> [   20.131283] type=1400 audit(1427336019.324:5): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=723 comm="apparmor_parser"
> [   20.131292] type=1400 audit(1427336019.324:6): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=723 comm="apparmor_parser"
> [   20.131393] type=1400 audit(1427336019.324:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/cups/backend/cups-pdf" pid=586 comm="apparmor_parser"
> [   20.131404] type=1400 audit(1427336019.324:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cupsd" pid=586 comm="apparmor_parser"
> [   20.131569] type=1400 audit(1427336019.324:9): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=723 comm="apparmor_parser"
> [   20.131598] type=1400 audit(1427336019.324:10): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/sbin/dhclient" pid=727 comm="apparmor_parser"
> [   20.131605] type=1400 audit(1427336019.324:11): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=727 comm="apparmor_parser"
> [   20.214199] input: HP WMI hotkeys as /devices/virtual/input/input18
> [   20.357194] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   20.357201] Bluetooth: BNEP filters: protocol multicast
> [   20.357214] Bluetooth: BNEP socket layer initialized
> [   20.386096] init: failsafe main process (749) killed by TERM signal
> [   20.484775] init: cups main process (729) killed by HUP signal
> [   20.484793] init: cups main process ended, respawning
> [   20.681703] cfg80211: World regulatory domain updated:
> [   20.681709] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
> [   20.681712] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   20.681714] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   20.681716] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
> [   20.681718] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   20.681719] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   21.336724] Linux video capture interface: v2.00
> [   21.343710] uvcvideo: Found UVC 1.00 device HP HD Webcam (04ca:7022)
> [   21.352224] input: HP HD Webcam as /devices/pci0000:00/0000:00:12.2/usb1/1-5/1-5:1.0/input/input19
> [   21.352314] usbcore: registered new interface driver uvcvideo
> [   21.352315] USB Video Class driver (1.1.1)
> [   21.598069] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input20
> [   21.924076] r8169 0000:02:00.0 eth0: link down
> [   21.924176] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   21.924702] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   21.934849] AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:00.1 address=0x000000fdf80c0020 flags=0x0a00]
> [   21.942180] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [   21.945851] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [   22.276988] thinkpad_ec: no ThinkPad embedded controller!
> [   23.110635] wlan0: authenticate with 3c:ce:73:48:04:80
> [   23.128143] wlan0: send auth to 3c:ce:73:48:04:80 (try 1/3)
> [   24.142159] wlan0: send auth to 3c:ce:73:48:04:80 (try 2/3)
> [   24.549478] fglrx_pci 0000:00:01.0: irq 93 for MSI/MSI-X
> [   24.550294] <6>[fglrx] Firegl kernel thread PID: 1377
> [   24.550423] <6>[fglrx] Firegl kernel thread PID: 1378
> [   24.550505] <6>[fglrx] Firegl kernel thread PID: 1379
> [   24.550622] <6>[fglrx] IRQ 93 Enabled
> [   24.556703] <6>[fglrx] Reserved FB block: Shared offset:0, size:1000000 
> [   24.556707] <6>[fglrx] Reserved FB block: Unshared offset:fa38000, size:4000 
> [   24.556708] <6>[fglrx] Reserved FB block: Unshared offset:fa3c000, size:4c4000 
> [   24.556710] <6>[fglrx] Reserved FB block: Unshared offset:ff00000, size:100000 
> [   24.556711] <6>[fglrx] Reserved FB block: Unshared offset:3ffd7000, size:29000 
> [   24.583673] vgaarb: this pci device is not a vga device
> [   24.799197] fglrx_pci 0000:01:00.0: irq 94 for MSI/MSI-X
> [   24.799981] <6>[fglrx] Firegl kernel thread PID: 1382
> [   24.800134] <6>[fglrx] Firegl kernel thread PID: 1383
> [   24.800240] <6>[fglrx] Firegl kernel thread PID: 1384
> [   24.800366] <6>[fglrx] IRQ 94 Enabled
> [   24.814629] <6>[fglrx] Reserved FB block: Shared offset:0, size:1000000 
> [   24.814634] <6>[fglrx] Reserved FB block: Unshared offset:f7fa000, size:1000 
> [   24.814636] <6>[fglrx] Reserved FB block: Unshared offset:f7fb000, size:4000 
> [   24.814637] <6>[fglrx] Reserved FB block: Unshared offset:f7ff000, size:501000 
> [   24.814639] <6>[fglrx] Reserved FB block: Unshared offset:3ff5e000, size:a2000 
> [   24.845659] <6>[fglrx] ATIF platform detected with notification ID: 0xd0
> [   24.848799] <6>[fglrx] ATIF platform detected with notification ID: 0xd0
> [   25.082126] vgaarb: this pci device is not a vga device
> [   25.133458] wlan0: authenticated
> [   25.146376] wlan0: associate with 3c:ce:73:48:04:80 (try 1/3)
> [   26.130537] wlan0: associate with 3c:ce:73:48:04:80 (try 2/3)
> [   26.794642] init: plymouth-upstart-bridge main process ended, respawning
> [   27.149671] wlan0: RX AssocResp from 3c:ce:73:48:04:80 (capab=0x431 status=0 aid=14)
> [   27.149824] wlan0: associated
> [   27.149841] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [   27.149969] cfg80211: Calling CRDA for country: TW
> [   27.150099] wlan0: deauthenticated from 3c:ce:73:48:04:80 (Reason: 23)
> [   27.153547] ath: EEPROM regdomain: 0x809e
> [   27.153554] ath: EEPROM indicates we should expect a country code
> [   27.153556] ath: doing EEPROM country->regdmn map search
> [   27.153558] ath: country maps to regdmn code: 0x50
> [   27.153559] ath: Country alpha2 being used: TW
> [   27.153560] ath: Regpair used: 0x50
> [   27.153562] ath: regdomain 0x809e dynamically updated by country IE
> [   27.153581] cfg80211: Regulatory domain changed to country: TW
> [   27.153583] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
> [   27.153584] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2700 mBm)
> [   27.153586] cfg80211:   (5270000 KHz - 5330000 KHz @ 40000 KHz), (300 mBi, 1700 mBm)
> [   27.153588] cfg80211:   (5735000 KHz - 5815000 KHz @ 40000 KHz), (300 mBi, 3000 mBm)
> [   27.158961] cfg80211: Calling CRDA to update world regulatory domain
> [   27.165685] cfg80211: World regulatory domain updated:
> [   27.165692] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
> [   27.165699] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   27.165701] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   27.165704] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
> [   27.165706] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   27.165708] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   31.304710] wlan0: authenticate with 3c:ce:73:48:04:80
> [   31.321349] wlan0: send auth to 3c:ce:73:48:04:80 (try 1/3)
> [   32.130956] wlan0: send auth to 3c:ce:73:48:04:80 (try 2/3)
> [   32.326073] wlan0: authenticated
> [   32.339865] wlan0: associate with 3c:ce:73:48:04:80 (try 1/3)
> [   33.143085] wlan0: associate with 3c:ce:73:48:04:80 (try 2/3)
> [   34.119143] wlan0: associate with 3c:ce:73:48:04:80 (try 3/3)
> [   34.342402] wlan0: RX AssocResp from 3c:ce:73:48:04:80 (capab=0x431 status=0 aid=14)
> [   34.342565] wlan0: associated
> [   34.342778] cfg80211: Calling CRDA for country: TW
> [   34.342809] wlan0: deauthenticated from 3c:ce:73:48:04:80 (Reason: 23)
> [   34.348160] ath: EEPROM regdomain: 0x809e
> [   34.348167] ath: EEPROM indicates we should expect a country code
> [   34.348169] ath: doing EEPROM country->regdmn map search
> [   34.348171] ath: country maps to regdmn code: 0x50
> [   34.348173] ath: Country alpha2 being used: TW
> [   34.348175] ath: Regpair used: 0x50
> [   34.348177] ath: regdomain 0x809e dynamically updated by country IE
> [   34.348198] cfg80211: Regulatory domain changed to country: TW
> [   34.348200] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
> [   34.348202] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2700 mBm)
> [   34.348205] cfg80211:   (5270000 KHz - 5330000 KHz @ 40000 KHz), (300 mBi, 1700 mBm)
> [   34.348206] cfg80211:   (5735000 KHz - 5815000 KHz @ 40000 KHz), (300 mBi, 3000 mBm)
> [   34.355440] cfg80211: Calling CRDA to update world regulatory domain
> [   34.356156] wlan0: authenticate with 3c:ce:73:48:04:80
> [   34.366285] wlan0: send auth to 3c:ce:73:48:04:80 (try 1/3)
> [   34.366462] cfg80211: World regulatory domain updated:
> [   34.366466] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
> [   34.366468] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   34.366471] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   34.366473] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
> [   34.366475] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   34.366477] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   35.155055] wlan0: send auth to 3c:ce:73:48:04:80 (try 2/3)
> [   36.119366] wlan0: send auth to 3c:ce:73:48:04:80 (try 3/3)
> [   36.370298] wlan0: authenticated
> [   36.383351] wlan0: associate with 3c:ce:73:48:04:80 (try 1/3)
> [   37.155284] wlan0: associate with 3c:ce:73:48:04:80 (try 2/3)
> [   38.119556] wlan0: associate with 3c:ce:73:48:04:80 (try 3/3)
> [   38.386778] wlan0: RX AssocResp from 3c:ce:73:48:04:80 (capab=0x431 status=0 aid=14)
> [   38.386939] wlan0: associated
> [   38.387061] cfg80211: Calling CRDA for country: TW
> [   38.387213] wlan0: deauthenticated from 3c:ce:73:48:04:80 (Reason: 23)
> [   38.392236] ath: EEPROM regdomain: 0x809e
> [   38.392243] ath: EEPROM indicates we should expect a country code
> [   38.392245] ath: doing EEPROM country->regdmn map search
> [   38.392247] ath: country maps to regdmn code: 0x50
> [   38.392249] ath: Country alpha2 being used: TW
> [   38.392251] ath: Regpair used: 0x50
> [   38.392253] ath: regdomain 0x809e dynamically updated by country IE
> [   38.392274] cfg80211: Regulatory domain changed to country: TW
> [   38.392276] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
> [   38.392278] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2700 mBm)
> [   38.392280] cfg80211:   (5270000 KHz - 5330000 KHz @ 40000 KHz), (300 mBi, 1700 mBm)
> [   38.392282] cfg80211:   (5735000 KHz - 5815000 KHz @ 40000 KHz), (300 mBi, 3000 mBm)
> [   38.404049] cfg80211: Calling CRDA to update world regulatory domain
> [   38.411033] cfg80211: World regulatory domain updated:
> [   38.411039] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
> [   38.411041] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   38.411043] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   38.411045] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
> [   38.411047] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   38.411049] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> [   39.539948] systemd-hostnamed[1844]: Warning: nss-myhostname is not installed. Changing the local hostname might make it unresolveable. Please install nss-myhostname!
