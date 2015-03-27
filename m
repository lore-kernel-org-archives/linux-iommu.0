From: AceLan Kao <acelan.kao-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: Any side effect if turn off amd_iommu
Date: Fri, 27 Mar 2015 08:48:22 +0800
Message-ID: <CAFv23QnUO+w0EXUx8DtgPx0W=fz37_R04EW6P-g+PF_y_U1dfA@mail.gmail.com>
References: <CAFv23QmxQ3vJnMEGN0TNR3vLAx1MN7ptB0y3QQLKciqfT3OBsQ@mail.gmail.com>
	<20150325140410.GS4441@8bytes.org>
	<CAFv23Qn93z4pE6RtURgoiBADpgCWZ6gfpMPn3akfJibudRi+Qg@mail.gmail.com>
	<20150326120547.GU4441@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d043c7e763fcaef05123a7dd4
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150326120547.GU4441-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

--f46d043c7e763fcaef05123a7dd4
Content-Type: text/plain; charset=UTF-8

Hi Joerg,

Very thanks for your time.
This is the log booting with kernel 4.0rc5 without fglrx loaded.
Thanks.

Best regards,
AceLan Kao.

2015-03-26 20:05 GMT+08:00 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>:
> The parameter is just called 'amd_iommu_dump'. But your dmesg contains
> the needed information from that parameter. Can you please try the same
> again with a recent upstream kernel and without any proprietary module
> loaded (means no fglrx)?
>
>
>         Joerg
>
> On Thu, Mar 26, 2015 at 10:26:53AM +0800, AceLan Kao wrote:
>> Hi Joerg,
>>
>> Here you are.
>> I've tried to add iommu_dump, amd_iommu_dump, and amd_iommu_dump=true
>> on kernel command line,
>> but didn't find anything useful.
>> The attached log uses "amd_iommu_dump=true"
>>
>> Best regards,
>> AceLan Kao.
>>
>> 2015-03-25 22:04 GMT+08:00 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>:
>> > On Wed, Mar 25, 2015 at 11:30:20AM +0800, AceLan Kao wrote:
>> >> We have some AMD machines(AMD cpu and graphics) that need to set
>> >> amd_iommu=off to work.
>> >> Some of them have wifi issue that it can't connect to any AP(no
>> >> interrupt)(can set noapic to workaround it, too),
>> >> and some of them have graphics issues.
>> >> The only workaround we found is to set amd_iommu=off, and it fixes both issues.
>> >>
>> >> I have 2 questions.
>> >> 1. What kind of these issues would be, are they a driver issue or a
>> >> BIOS issue? If it's a BIOS issue, what we should tell the BIOS
>> >> engineers, so that they know how to fix it?
>> >> 2. Some of the machines may not have the chance to get a BIOS update,
>> >> do you think it's okay to add a quirk in amd_iommu driver to blacklist
>> >> out those machines? Are there any side effects if we do so?
>> >
>> > Hard to tell what the issue is. Can you please boot the affected machine
>> > with AMD IOMMU enabled and amd_iommu_dump on the command line and send
>> > me dmesg of the machine after boot?
>> >
>> > Thanks,
>> >
>> >         Joerg
>> >
>
>> [    0.000000] Initializing cgroup subsys cpuset
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Initializing cgroup subsys cpuacct
>> [    0.000000] Linux version 3.13.0-45-generic (buildd@phianna) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #74-Ubuntu SMP Tue Jan 13 19:36:28 UTC 2015 (Ubuntu 3.13.0-45.74-generic 3.13.11-ckt13)
>> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.13.0-45-generic root=UUID=6224a1c4-824b-41b2-9077-700edb8586ad ro amd_iommu_dump=true quiet splash
>> [    0.000000] KERNEL supported cpus:
>> [    0.000000]   Intel GenuineIntel
>> [    0.000000]   AMD AuthenticAMD
>> [    0.000000]   Centaur CentaurHauls
>> [    0.000000] e820: BIOS-provided physical RAM map:
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
>> [    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005d9b5fff] usable
>> [    0.000000] BIOS-e820: [mem 0x000000005d9b6000-0x000000005e8b1fff] reserved
>> [    0.000000] BIOS-e820: [mem 0x000000005e8b2000-0x000000005efb1fff] ACPI NVS
>> [    0.000000] BIOS-e820: [mem 0x000000005efb2000-0x000000005effefff] ACPI data
>> [    0.000000] BIOS-e820: [mem 0x000000005efff000-0x000000005effffff] usable
>> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000025effffff] usable
>> [    0.000000] NX (Execute Disable) protection: active
>> [    0.000000] SMBIOS 2.7 present.
>> [    0.000000] DMI: Hewlett-Packard HP ProBook 445G2/2234, BIOS M75 Ver. 01.07 09/16/2014
>> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
>> [    0.000000] No AGP bridge found
>> [    0.000000] e820: last_pfn = 0x25f000 max_arch_pfn = 0x400000000
>> [    0.000000] MTRR default type: uncachable
>> [    0.000000] MTRR fixed ranges enabled:
>> [    0.000000]   00000-9FFFF write-back
>> [    0.000000]   A0000-BFFFF uncachable
>> [    0.000000]   C0000-DFFFF write-through
>> [    0.000000]   E0000-FFFFF write-protect
>> [    0.000000] MTRR variable ranges enabled:
>> [    0.000000]   0 base 000000000000 mask FFFFC0000000 write-back
>> [    0.000000]   1 base 000040000000 mask FFFFE0000000 write-back
>> [    0.000000]   2 base 0000FF800000 mask FFFFFF800000 write-protect
>> [    0.000000]   3 disabled
>> [    0.000000]   4 disabled
>> [    0.000000]   5 disabled
>> [    0.000000]   6 disabled
>> [    0.000000]   7 disabled
>> [    0.000000] TOM2: 000000025f000000 aka 9712M
>> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
>> [    0.000000] e820: last_pfn = 0x5f000 max_arch_pfn = 0x400000000
>> [    0.000000] Scanning 1 areas for low memory corruption
>> [    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
>> [    0.000000] Using GB pages for direct mapping
>> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
>> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
>> [    0.000000] BRK [0x01fe1000, 0x01fe1fff] PGTABLE
>> [    0.000000] BRK [0x01fe2000, 0x01fe2fff] PGTABLE
>> [    0.000000] BRK [0x01fe3000, 0x01fe3fff] PGTABLE
>> [    0.000000] init_memory_mapping: [mem 0x25ee00000-0x25effffff]
>> [    0.000000]  [mem 0x25ee00000-0x25effffff] page 2M
>> [    0.000000] BRK [0x01fe4000, 0x01fe4fff] PGTABLE
>> [    0.000000] init_memory_mapping: [mem 0x25c000000-0x25edfffff]
>> [    0.000000]  [mem 0x25c000000-0x25edfffff] page 2M
>> [    0.000000] init_memory_mapping: [mem 0x200000000-0x25bffffff]
>> [    0.000000]  [mem 0x200000000-0x23fffffff] page 1G
>> [    0.000000]  [mem 0x240000000-0x25bffffff] page 2M
>> [    0.000000] init_memory_mapping: [mem 0x00100000-0x5d9b5fff]
>> [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
>> [    0.000000]  [mem 0x00200000-0x5d7fffff] page 2M
>> [    0.000000]  [mem 0x5d800000-0x5d9b5fff] page 4k
>> [    0.000000] init_memory_mapping: [mem 0x5efff000-0x5effffff]
>> [    0.000000]  [mem 0x5efff000-0x5effffff] page 4k
>> [    0.000000] BRK [0x01fe5000, 0x01fe5fff] PGTABLE
>> [    0.000000] init_memory_mapping: [mem 0x100000000-0x1ffffffff]
>> [    0.000000]  [mem 0x100000000-0x1ffffffff] page 1G
>> [    0.000000] RAMDISK: [mem 0x342ee000-0x3616efff]
>> [    0.000000] ACPI: RSDP 00000000000f2f90 000024 (v02 HPQOEM)
>> [    0.000000] ACPI: XSDT 000000005effd0e8 00009C (v01 HPQOEM SLIC-MPC 00000003      01000013)
>> [    0.000000] ACPI: FACP 000000005effb000 00010C (v05 HPQOEM 180F     00000003 HP   00000001)
>> [    0.000000] ACPI: DSDT 000000005efd8000 01E7AD (v01 HPQOEM 180F     00000001 INTL 20130927)
>> [    0.000000] ACPI: FACS 000000005ed69000 000040
>> [    0.000000] ACPI: HPET 000000005effa000 000038 (v01 HPQOEM 180F     00000001 HP   00000001)
>> [    0.000000] ACPI: APIC 000000005eff9000 000090 (v01 HPQOEM 180F     00000001 HP   00000001)
>> [    0.000000] ACPI: MCFG 000000005eff8000 00003C (v01 HPQOEM 180F     00000001 HP   00000001)
>> [    0.000000] ACPI: TCPA 000000005eff7000 000032 (v02 HPQOEM 180F     00000000 HP   00000001)
>> [    0.000000] ACPI: FPDT 000000005efd5000 000044 (v01 HPQOEM 180F     00000001 HP   00000001)
>> [    0.000000] ACPI: BGRT 000000005efd4000 000038 (v00 HPQOEM 180F     00000001 HP   00000001)
>> [    0.000000] ACPI: SSDT 000000005efd3000 000B9C (v01 AMD    BALLINA  00000001 AMD  00000001)
>> [    0.000000] ACPI: SSDT 000000005efc9000 009399 (v02 AMD    BALLINA  00000002 MSFT 04000000)
>> [    0.000000] ACPI: IVRS 000000005efc8000 000078 (v02 AMD    BALLINA  00000001 AMD  00000000)
>> [    0.000000] ACPI: CRAT 000000005efc7000 000550 (v01 AMD    BALLINA  00000001 AMD  00000001)
>> [    0.000000] ACPI: SSDT 000000005efc6000 000789 (v01 HP     AMDSGTBL 00000001 INTL 20130927)
>> [    0.000000] ACPI: SSDT 000000005efc5000 000325 (v01 HP     HPZPODDT 00000001 INTL 20130927)
>> [    0.000000] ACPI: SSDT 000000005efc4000 00081B (v01    AMD CPMADPS4 00000001 INTL 20130927)
>> [    0.000000] ACPI: SSDT 000000005efc2000 001207 (v01    AMD   CPMCMN 00000001 INTL 20130927)
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] No NUMA configuration found
>> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000025effffff]
>> [    0.000000] Initmem setup node 0 [mem 0x00000000-0x25effffff]
>> [    0.000000]   NODE_DATA [mem 0x25eff9000-0x25effdfff]
>> [    0.000000]  [ffffea0000000000-ffffea00097fffff] PMD -> [ffff880257600000-ffff88025e5fffff] on node 0
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
>> [    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
>> [    0.000000]   Normal   [mem 0x100000000-0x25effffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
>> [    0.000000]   node   0: [mem 0x00100000-0x5d9b5fff]
>> [    0.000000]   node   0: [mem 0x5efff000-0x5effffff]
>> [    0.000000]   node   0: [mem 0x100000000-0x25effffff]
>> [    0.000000] On node 0 totalpages: 1821012
>> [    0.000000]   DMA zone: 64 pages used for memmap
>> [    0.000000]   DMA zone: 21 pages reserved
>> [    0.000000]   DMA zone: 3997 pages, LIFO batch:0
>> [    0.000000]   DMA32 zone: 5927 pages used for memmap
>> [    0.000000]   DMA32 zone: 379319 pages, LIFO batch:31
>> [    0.000000]   Normal zone: 22464 pages used for memmap
>> [    0.000000]   Normal zone: 1437696 pages, LIFO batch:31
>> [    0.000000] ACPI: PM-Timer IO Port: 0x408
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x10] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x11] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x12] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x13] enabled)
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
>> [    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
>> [    0.000000] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
>> [    0.000000] ACPI: IOAPIC (id[0x05] address[0xfec20000] gsi_base[24])
>> [    0.000000] IOAPIC[1]: apic_id 5, version 33, address 0xfec20000, GSI 24-55
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
>> [    0.000000] ACPI: IRQ0 used by override.
>> [    0.000000] ACPI: IRQ2 used by override.
>> [    0.000000] ACPI: IRQ9 used by override.
>> [    0.000000] Using ACPI (MADT) for SMP configuration information
>> [    0.000000] ACPI: HPET id: 0x43538301 base: 0xfed00000
>> [    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
>> [    0.000000] nr_irqs_gsi: 72
>> [    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x5d9b6000-0x5e8b1fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x5e8b2000-0x5efb1fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x5efb2000-0x5effefff]
>> [    0.000000] PM: Registered nosave memory: [mem 0x5f000000-0xdfffffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfed7ffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed80fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfed81000-0xfedfffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xff7fffff]
>> [    0.000000] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
>> [    0.000000] e820: [mem 0x5f000000-0xdfffffff] available for PCI devices
>> [    0.000000] Booting paravirtualized kernel on bare hardware
>> [    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
>> [    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88025ec00000 s82368 r8192 d24128 u524288
>> [    0.000000] pcpu-alloc: s82368 r8192 d24128 u524288 alloc=1*2097152
>> [    0.000000] pcpu-alloc: [0] 0 1 2 3
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1792536
>> [    0.000000] Policy zone: Normal
>> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.13.0-45-generic root=UUID=6224a1c4-824b-41b2-9077-700edb8586ad ro amd_iommu_dump=true quiet splash
>> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
>> [    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
>> [    0.000000] Checking aperture...
>> [    0.000000] No AGP bridge found
>> [    0.000000] Node 0: aperture @ 0 size 32 MB
>> [    0.000000] Your BIOS doesn't leave a aperture memory hole
>> [    0.000000] Please enable the IOMMU option in the BIOS setup
>> [    0.000000] This costs you 64 MB of RAM
>> [    0.000000] Mapping aperture over 65536 KB of RAM @ 54000000
>> [    0.000000] PM: Registered nosave memory: [mem 0x54000000-0x57ffffff]
>> [    0.000000] Memory: 6989436K/7284048K available (7383K kernel code, 1145K rwdata, 3408K rodata, 1336K init, 1444K bss, 294612K reserved)
>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000]        RCU dyntick-idle grace-period acceleration is enabled.
>> [    0.000000]        RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
>> [    0.000000]        Offload RCU callbacks from all CPUs
>> [    0.000000]        Offload RCU callbacks from CPUs: 0-3.
>> [    0.000000] NR_IRQS:16640 nr_irqs:1024 16
>> [    0.000000] spurious 8259A interrupt: IRQ7.
>> [    0.000000] Console: colour VGA+ 80x25
>> [    0.000000] console [tty0] enabled
>> [    0.000000] allocated 29360128 bytes of page_cgroup
>> [    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
>> [    0.000000] hpet clockevent registered
>> [    0.000000] tsc: Fast TSC calibration using PIT
>> [    0.004000] tsc: Detected 1896.472 MHz processor
>> [    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 3792.94 BogoMIPS (lpj=7585888)
>> [    0.000007] pid_max: default: 32768 minimum: 301
>> [    0.000040] Security Framework initialized
>> [    0.000064] AppArmor: AppArmor initialized
>> [    0.000065] Yama: becoming mindful.
>> [    0.000688] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
>> [    0.003568] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
>> [    0.004849] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
>> [    0.004863] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
>> [    0.005153] Initializing cgroup subsys memory
>> [    0.005163] Initializing cgroup subsys devices
>> [    0.005165] Initializing cgroup subsys freezer
>> [    0.005168] Initializing cgroup subsys blkio
>> [    0.005169] Initializing cgroup subsys perf_event
>> [    0.005172] Initializing cgroup subsys hugetlb
>> [    0.005199] tseg: 005f000000
>> [    0.005201] CPU: Physical Processor ID: 0
>> [    0.005203] CPU: Processor Core ID: 0
>> [    0.005205] mce: CPU supports 7 MCE banks
>> [    0.005212] LVT offset 1 assigned for vector 0xf9
>> [    0.005221] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
>> [    0.005221] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512
>> [    0.005221] tlb_flushall_shift: 5
>> [    0.005347] Freeing SMP alternatives memory: 32K (ffffffff81e6e000 - ffffffff81e76000)
>> [    0.006447] ACPI: Core revision 20131115
>> [    0.017553] ACPI: All ACPI Tables successfully acquired
>> [    0.056583] ftrace: allocating 28554 entries in 112 pages
>> [    0.072165] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b8 info 0000
>> [    0.072169] AMD-Vi:        mmio-addr: 00000000feb80000
>> [    0.072213] AMD-Vi:   DEV_SELECT_RANGE_START        devid: 00:01.0 flags: 00
>> [    0.072214] AMD-Vi:   DEV_RANGE_END                 devid: ff:1f.6
>> [    0.073260] AMD-Vi:   DEV_ALIAS_RANGE               devid: 05:00.0 flags: 00 devid_to: 00:14.4
>> [    0.073262] AMD-Vi:   DEV_RANGE_END                 devid: 05:1f.7
>> [    0.073272] AMD-Vi:   DEV_SPECIAL(HPET[0])         devid: 00:14.0
>> [    0.073274] AMD-Vi:   DEV_SPECIAL(IOAPIC[4])               devid: 00:14.0
>> [    0.073276] AMD-Vi:   DEV_SPECIAL(IOAPIC[5])               devid: 00:00.0
>> [    0.271580] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>> [    0.311273] smpboot: CPU0: AMD A10-7300 Radeon R6, 10 Compute Cores 4C+6G (fam: 15, model: 30, stepping: 01)
>> [    0.415445] Performance Events: Fam15h core perfctr, AMD PMU driver.
>> [    0.415452] ... version:                0
>> [    0.415454] ... bit width:              48
>> [    0.415456] ... generic registers:      6
>> [    0.415457] ... value mask:             0000ffffffffffff
>> [    0.415459] ... max period:             00007fffffffffff
>> [    0.415460] ... fixed-purpose events:   0
>> [    0.415461] ... event mask:             000000000000003f
>> [    0.417469] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
>> [    0.417572] x86: Booting SMP configuration:
>> [    0.417575] .... node  #0, CPUs:      #1 #2 #3
>> [    0.457291] x86: Booted up 1 node, 4 CPUs
>> [    0.457296] smpboot: Total of 4 processors activated (15171.77 BogoMIPS)
>> [    0.458465] devtmpfs: initialized
>> [    0.461887] EVM: security.selinux
>> [    0.461889] EVM: security.SMACK64
>> [    0.461891] EVM: security.ima
>> [    0.461893] EVM: security.capability
>> [    0.462005] PM: Registering ACPI NVS region [mem 0x5e8b2000-0x5efb1fff] (7340032 bytes)
>> [    0.463313] pinctrl core: initialized pinctrl subsystem
>> [    0.463397] regulator-dummy: no parameters
>> [    0.463495] RTC time:  2:13:19, date: 03/26/15
>> [    0.463544] NET: Registered protocol family 16
>> [    0.463711] cpuidle: using governor ladder
>> [    0.463713] cpuidle: using governor menu
>> [    0.463926] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
>> [    0.463928] ACPI: bus type PCI registered
>> [    0.463930] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
>> [    0.464081] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
>> [    0.464084] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
>> [    0.480530] PCI: Using configuration type 1 for base access
>> [    0.480781] mtrr: your CPUs had inconsistent fixed MTRR settings
>> [    0.480783] mtrr: your CPUs had inconsistent variable MTRR settings
>> [    0.480784] mtrr: probably your BIOS does not setup all CPUs.
>> [    0.480785] mtrr: corrected configuration.
>> [    0.482074] bio: create slab <bio-0> at 0
>> [    0.482299] ACPI: Added _OSI(Module Device)
>> [    0.482301] ACPI: Added _OSI(Processor Device)
>> [    0.482303] ACPI: Added _OSI(3.0 _SCP Extensions)
>> [    0.482304] ACPI: Added _OSI(Processor Aggregator Device)
>> [    3.128232] ACPI: Interpreter enabled
>> [    3.128255] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20131115/hwxface-580)
>> [    3.128263] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20131115/hwxface-580)
>> [    3.128291] ACPI: (supports S0 S3 S4 S5)
>> [    3.128294] ACPI: Using IOAPIC for interrupt routing
>> [    3.128639] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
>> [    3.128952] ACPI: No dock devices found.
>> [    3.134669] ACPI: Power Resource [APPR] (off)
>> [    3.146814] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
>> [    3.147339] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>> [    3.147349] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
>> [    3.147860] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
>> [    3.148084] acpi PNP0A08:00: ignoring host bridge window [mem 0x000cc000-0x000cffff] (conflicts with Video ROM [mem 0x000c0000-0x000cf5ff])
>> [    3.148088] acpi PNP0A08:00: ignoring host bridge window [mem 0x000d0000-0x000d3fff] (conflicts with Adapter ROM [mem 0x000cf800-0x000d07ff])
>> [    3.148407] PCI host bridge to bus 0000:00
>> [    3.148412] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    3.148414] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
>> [    3.148416] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
>> [    3.148418] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
>> [    3.148419] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff]
>> [    3.148421] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff]
>> [    3.148423] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff]
>> [    3.148424] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
>> [    3.148426] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
>> [    3.148428] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
>> [    3.148429] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
>> [    3.148431] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff]
>> [    3.148432] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff]
>> [    3.148434] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff]
>> [    3.148435] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff]
>> [    3.148437] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xdfffffff]
>> [    3.148439] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed3ffff]
>> [    3.148440] pci_bus 0000:00: root bus resource [mem 0xfed45000-0xfffdffff]
>> [    3.148448] pci 0000:00:00.0: [1022:1422] type 00 class 0x060000
>> [    3.148580] pci 0000:00:00.2: [1022:1423] type 00 class 0x080600
>> [    3.148737] pci 0000:00:01.0: [1002:130a] type 00 class 0x030000
>> [    3.148751] pci 0000:00:01.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
>> [    3.148761] pci 0000:00:01.0: reg 0x18: [mem 0xd0000000-0xd07fffff 64bit pref]
>> [    3.148767] pci 0000:00:01.0: reg 0x20: [io  0x6000-0x60ff]
>> [    3.148774] pci 0000:00:01.0: reg 0x24: [mem 0xd6900000-0xd693ffff]
>> [    3.148781] pci 0000:00:01.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
>> [    3.148815] pci 0000:00:01.0: supports D1 D2
>> [    3.148817] pci 0000:00:01.0: PME# supported from D1 D2 D3hot
>> [    3.148905] pci 0000:00:01.1: [1002:1308] type 00 class 0x040300
>> [    3.148917] pci 0000:00:01.1: reg 0x10: [mem 0xd6940000-0xd6943fff 64bit]
>> [    3.148975] pci 0000:00:01.1: supports D1 D2
>> [    3.149111] pci 0000:00:02.0: [1022:1424] type 00 class 0x060000
>> [    3.149199] pci 0000:00:02.1: [1022:1425] type 01 class 0x060400
>> [    3.149268] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
>> [    3.149421] pci 0000:00:03.0: [1022:1424] type 00 class 0x060000
>> [    3.149518] pci 0000:00:03.1: [1022:1426] type 01 class 0x060400
>> [    3.149587] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
>> [    3.149650] pci 0000:00:03.1: System wakeup disabled by ACPI
>> [    3.149683] pci 0000:00:03.2: [1022:1426] type 01 class 0x060400
>> [    3.149751] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
>> [    3.149809] pci 0000:00:03.2: System wakeup disabled by ACPI
>> [    3.149912] pci 0000:00:03.4: [1022:1426] type 01 class 0x060400
>> [    3.149980] pci 0000:00:03.4: PME# supported from D0 D3hot D3cold
>> [    3.150039] pci 0000:00:03.4: System wakeup disabled by ACPI
>> [    3.150132] pci 0000:00:04.0: [1022:1424] type 00 class 0x060000
>> [    3.150283] pci 0000:00:10.0: [1022:7814] type 00 class 0x0c0330
>> [    3.150307] pci 0000:00:10.0: reg 0x10: [mem 0xd6948000-0xd6949fff 64bit]
>> [    3.150417] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
>> [    3.150481] pci 0000:00:10.0: System wakeup disabled by ACPI
>> [    3.150555] pci 0000:00:11.0: [1022:7801] type 00 class 0x010601
>> [    3.150575] pci 0000:00:11.0: reg 0x10: [io  0x6118-0x611f]
>> [    3.150585] pci 0000:00:11.0: reg 0x14: [io  0x6124-0x6127]
>> [    3.150595] pci 0000:00:11.0: reg 0x18: [io  0x6110-0x6117]
>> [    3.150605] pci 0000:00:11.0: reg 0x1c: [io  0x6120-0x6123]
>> [    3.150615] pci 0000:00:11.0: reg 0x20: [io  0x6100-0x610f]
>> [    3.150626] pci 0000:00:11.0: reg 0x24: [mem 0xd694f000-0xd694f7ff]
>> [    3.150775] pci 0000:00:12.0: [1022:7807] type 00 class 0x0c0310
>> [    3.150789] pci 0000:00:12.0: reg 0x10: [mem 0xd694e000-0xd694efff]
>> [    3.150993] pci 0000:00:12.0: System wakeup disabled by ACPI
>> [    3.151076] pci 0000:00:12.2: [1022:7808] type 00 class 0x0c0320
>> [    3.151098] pci 0000:00:12.2: reg 0x10: [mem 0xd694d000-0xd694d0ff]
>> [    3.151188] pci 0000:00:12.2: supports D1 D2
>> [    3.151190] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot D3cold
>> [    3.151255] pci 0000:00:12.2: System wakeup disabled by ACPI
>> [    3.151327] pci 0000:00:13.0: [1022:7807] type 00 class 0x0c0310
>> [    3.151344] pci 0000:00:13.0: reg 0x10: [mem 0xd694c000-0xd694cfff]
>> [    3.151504] pci 0000:00:13.0: System wakeup disabled by ACPI
>> [    3.151547] pci 0000:00:13.2: [1022:7808] type 00 class 0x0c0320
>> [    3.151568] pci 0000:00:13.2: reg 0x10: [mem 0xd694b000-0xd694b0ff]
>> [    3.151657] pci 0000:00:13.2: supports D1 D2
>> [    3.151658] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot D3cold
>> [    3.151720] pci 0000:00:13.2: System wakeup disabled by ACPI
>> [    3.151791] pci 0000:00:14.0: [1022:780b] type 00 class 0x0c0500
>> [    3.151976] pci 0000:00:14.2: [1022:780d] type 00 class 0x040300
>> [    3.152001] pci 0000:00:14.2: reg 0x10: [mem 0xd6944000-0xd6947fff 64bit]
>> [    3.152072] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
>> [    3.152147] pci 0000:00:14.2: System wakeup disabled by ACPI
>> [    3.152217] pci 0000:00:14.3: [1022:780e] type 00 class 0x060100
>> [    3.152387] pci 0000:00:14.4: [1022:780f] type 01 class 0x060401
>> [    3.152516] pci 0000:00:14.5: [1022:7809] type 00 class 0x0c0310
>> [    3.152531] pci 0000:00:14.5: reg 0x10: [mem 0xd694a000-0xd694afff]
>> [    3.152688] pci 0000:00:18.0: [1022:141a] type 00 class 0x060000
>> [    3.152763] pci 0000:00:18.1: [1022:141b] type 00 class 0x060000
>> [    3.152831] pci 0000:00:18.2: [1022:141c] type 00 class 0x060000
>> [    3.152903] pci 0000:00:18.3: [1022:141d] type 00 class 0x060000
>> [    3.152977] pci 0000:00:18.4: [1022:141e] type 00 class 0x060000
>> [    3.153046] pci 0000:00:18.5: [1022:141f] type 00 class 0x060000
>> [    3.153281] pci 0000:01:00.0: [1002:6901] type 00 class 0x038000
>> [    3.153313] pci 0000:01:00.0: reg 0x10: [mem 0xa0000000-0xafffffff 64bit pref]
>> [    3.153337] pci 0000:01:00.0: reg 0x18: [mem 0xb0000000-0xb01fffff 64bit pref]
>> [    3.153353] pci 0000:01:00.0: reg 0x20: [io  0x5000-0x50ff]
>> [    3.153369] pci 0000:01:00.0: reg 0x24: [mem 0xd6800000-0xd683ffff]
>> [    3.153385] pci 0000:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
>> [    3.153482] pci 0000:01:00.0: supports D1 D2
>> [    3.161530] pci 0000:00:02.1: PCI bridge to [bus 01]
>> [    3.161540] pci 0000:00:02.1:   bridge window [io  0x5000-0x5fff]
>> [    3.161545] pci 0000:00:02.1:   bridge window [mem 0xd6800000-0xd68fffff]
>> [    3.161550] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb01fffff 64bit pref]
>> [    3.161711] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
>> [    3.161744] pci 0000:02:00.0: reg 0x10: [io  0x4000-0x40ff]
>> [    3.161780] pci 0000:02:00.0: reg 0x18: [mem 0xd5804000-0xd5804fff 64bit]
>> [    3.161801] pci 0000:02:00.0: reg 0x20: [mem 0xd5800000-0xd5803fff 64bit]
>> [    3.161887] pci 0000:02:00.0: supports D1 D2
>> [    3.161889] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    3.161950] pci 0000:02:00.0: System wakeup disabled by ACPI
>> [    3.168361] pci 0000:00:03.1: PCI bridge to [bus 02]
>> [    3.168372] pci 0000:00:03.1:   bridge window [io  0x4000-0x4fff]
>> [    3.168377] pci 0000:00:03.1:   bridge window [mem 0xd5800000-0xd67fffff]
>> [    3.168383] pci 0000:00:03.1:   bridge window [mem 0xd0800000-0xd17fffff 64bit pref]
>> [    3.168530] pci 0000:03:00.0: [168c:0032] type 00 class 0x028000
>> [    3.168556] pci 0000:03:00.0: reg 0x10: [mem 0xd4800000-0xd487ffff 64bit]
>> [    3.168606] pci 0000:03:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
>> [    3.168662] pci 0000:03:00.0: supports D1 D2
>> [    3.168664] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    3.177599] pci 0000:00:03.2: PCI bridge to [bus 03]
>> [    3.177610] pci 0000:00:03.2:   bridge window [io  0x3000-0x3fff]
>> [    3.177614] pci 0000:00:03.2:   bridge window [mem 0xd4800000-0xd57fffff]
>> [    3.177620] pci 0000:00:03.2:   bridge window [mem 0xd1800000-0xd27fffff 64bit pref]
>> [    3.177754] pci 0000:04:00.0: [10ec:5229] type 00 class 0xff0000
>> [    3.177779] pci 0000:04:00.0: reg 0x10: [mem 0xd3800000-0xd3800fff]
>> [    3.177906] pci 0000:04:00.0: supports D1 D2
>> [    3.177908] pci 0000:04:00.0: PME# supported from D1 D2 D3hot
>> [    3.184347] pci 0000:00:03.4: PCI bridge to [bus 04]
>> [    3.184358] pci 0000:00:03.4:   bridge window [io  0x2000-0x2fff]
>> [    3.184363] pci 0000:00:03.4:   bridge window [mem 0xd3800000-0xd47fffff]
>> [    3.184369] pci 0000:00:03.4:   bridge window [mem 0xd2800000-0xd37fffff 64bit pref]
>> [    3.184540] pci 0000:00:14.4: PCI bridge to [bus 05] (subtractive decode)
>> [    3.184551] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
>> [    3.184554] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
>> [    3.184556] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
>> [    3.184558] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000c3fff] (subtractive decode)
>> [    3.184560] pci 0000:00:14.4:   bridge window [mem 0x000c4000-0x000c7fff] (subtractive decode)
>> [    3.184562] pci 0000:00:14.4:   bridge window [mem 0x000c8000-0x000cbfff] (subtractive decode)
>> [    3.184564] pci 0000:00:14.4:   bridge window [mem 0x000d4000-0x000d7fff] (subtractive decode)
>> [    3.184566] pci 0000:00:14.4:   bridge window [mem 0x000d8000-0x000dbfff] (subtractive decode)
>> [    3.184568] pci 0000:00:14.4:   bridge window [mem 0x000dc000-0x000dffff] (subtractive decode)
>> [    3.184570] pci 0000:00:14.4:   bridge window [mem 0x000e0000-0x000e3fff] (subtractive decode)
>> [    3.184572] pci 0000:00:14.4:   bridge window [mem 0x000e4000-0x000e7fff] (subtractive decode)
>> [    3.184573] pci 0000:00:14.4:   bridge window [mem 0x000e8000-0x000ebfff] (subtractive decode)
>> [    3.184575] pci 0000:00:14.4:   bridge window [mem 0x000ec000-0x000effff] (subtractive decode)
>> [    3.184577] pci 0000:00:14.4:   bridge window [mem 0x000f0000-0x000fffff] (subtractive decode)
>> [    3.184579] pci 0000:00:14.4:   bridge window [mem 0xa0000000-0xdfffffff] (subtractive decode)
>> [    3.184581] pci 0000:00:14.4:   bridge window [mem 0xf0000000-0xfed3ffff] (subtractive decode)
>> [    3.184583] pci 0000:00:14.4:   bridge window [mem 0xfed45000-0xfffdffff] (subtractive decode)
>> [    3.184627] acpi PNP0A08:00: Disabling ASPM (FADT indicates it is unsupported)
>> [    3.185979] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15) *0
>> [    3.186077] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0
>> [    3.186174] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15) *0
>> [    3.186270] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15) *0
>> [    3.186346] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0
>> [    3.186407] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0
>> [    3.186467] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0
>> [    3.186527] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0
>> [    3.187408] ACPI: Enabled 2 GPEs in block 00 to 1F
>> [    3.187419] ACPI: \_SB_.PCI0: notify handler is installed
>> [    3.187533] Found 1 acpi root devices
>> [    3.187608] ACPI : EC: GPE = 0x3, I/O: command/status = 0x66, data = 0x62
>> [    3.187767] vgaarb: setting as boot device: PCI:0000:00:01.0
>> [    3.187770] vgaarb: device added: PCI:0000:00:01.0,decodes=io+mem,owns=io+mem,locks=none
>> [    3.187781] vgaarb: loaded
>> [    3.187783] vgaarb: bridge control possible 0000:00:01.0
>> [    3.188000] SCSI subsystem initialized
>> [    3.188135] libata version 3.00 loaded.
>> [    3.188180] ACPI: bus type USB registered
>> [    3.188204] usbcore: registered new interface driver usbfs
>> [    3.188215] usbcore: registered new interface driver hub
>> [    3.188252] usbcore: registered new device driver usb
>> [    3.188466] PCI: Using ACPI for IRQ routing
>> [    3.197688] PCI: pci_cache_line_size set to 64 bytes
>> [    3.197791] Expanded resource reserved due to conflict with PCI Bus 0000:00
>> [    3.197794] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
>> [    3.197797] e820: reserve RAM buffer [mem 0x5d9b6000-0x5fffffff]
>> [    3.197798] e820: reserve RAM buffer [mem 0x5f000000-0x5fffffff]
>> [    3.197800] e820: reserve RAM buffer [mem 0x25f000000-0x25fffffff]
>> [    3.197927] NetLabel: Initializing
>> [    3.197930] NetLabel:  domain hash size = 128
>> [    3.197931] NetLabel:  protocols = UNLABELED CIPSOv4
>> [    3.197946] NetLabel:  unlabeled traffic allowed by default
>> [    3.198213] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>> [    3.198218] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
>> [    3.200349] Switched to clocksource hpet
>> [    3.207979] AppArmor: AppArmor Filesystem Enabled
>> [    3.208013] pnp: PnP ACPI init
>> [    3.208029] ACPI: bus type PNP registered
>> [    3.208173] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
>> [    3.208176] system 00:00: [mem 0xfeb00000-0xfeb00fff] has been reserved
>> [    3.208178] system 00:00: [mem 0xfec00000-0xfec00fff] could not be reserved
>> [    3.208181] system 00:00: [mem 0xfec20000-0xfec20fff] could not be reserved
>> [    3.208183] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
>> [    3.208187] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
>> [    3.208434] pnp 00:01: [dma 4]
>> [    3.208458] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
>> [    3.208533] pnp 00:02: Plug and Play ACPI device, IDs PNP0c04 (active)
>> [    3.208560] pnp 00:03: Plug and Play ACPI device, IDs PNP0800 (active)
>> [    3.208660] system 00:04: [io  0x0400-0x04cf] could not be reserved
>> [    3.208662] system 00:04: [io  0x04d0-0x04d1] has been reserved
>> [    3.208664] system 00:04: [io  0x04d6] has been reserved
>> [    3.208666] system 00:04: [io  0x0680-0x06ff] has been reserved
>> [    3.208668] system 00:04: [io  0x077a] has been reserved
>> [    3.208670] system 00:04: [io  0x0c00-0x0c01] has been reserved
>> [    3.208672] system 00:04: [io  0x0c14] has been reserved
>> [    3.208674] system 00:04: [io  0x0c50-0x0c52] has been reserved
>> [    3.208675] system 00:04: [io  0x0c6c] has been reserved
>> [    3.208677] system 00:04: [io  0x0c6f] has been reserved
>> [    3.208679] system 00:04: [io  0x0cd0-0x0cdb] has been reserved
>> [    3.208681] system 00:04: [io  0x0220-0x0227] has been reserved
>> [    3.208683] system 00:04: [io  0x0260-0x0273] has been reserved
>> [    3.208685] system 00:04: [io  0x0800] has been reserved
>> [    3.208687] system 00:04: [io  0x0804] has been reserved
>> [    3.208688] system 00:04: [io  0x087f] has been reserved
>> [    3.208690] system 00:04: [io  0x0cdc-0x0cdf] has been reserved
>> [    3.208692] system 00:04: [io  0x0b00-0x0b0f] has been reserved
>> [    3.208695] system 00:04: [io  0x0200-0x027f] could not be reserved
>> [    3.208697] system 00:04: [io  0x1770-0x1777] has been reserved
>> [    3.208699] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
>> [    3.208779] system 00:05: [mem 0x00000000-0x0009ffff] could not be reserved
>> [    3.208782] system 00:05: [mem 0x00100000-0x9fffffff] could not be reserved
>> [    3.208784] system 00:05: [mem 0xffe00000-0xffffffff] could not be reserved
>> [    3.208786] system 00:05: Plug and Play ACPI device, IDs PNP0c01 (active)
>> [    3.208909] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
>> [    3.209037] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
>> [    3.209101] pnp 00:08: Plug and Play ACPI device, IDs HPQ8001 PNP0303 (active)
>> [    3.209136] pnp 00:09: Plug and Play ACPI device, IDs SYN301c SYN0100 SYN0002 PNP0f13 (active)
>> [    3.209337] pnp 00:0a: Plug and Play ACPI device, IDs HPQ6007 (active)
>> [    3.209556] pnp 00:0b: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
>> [    3.209795] pnp: PnP ACPI: found 12 devices
>> [    3.209796] ACPI: bus type PNP unregistered
>> [    3.217642] pci 0000:00:01.0: no compatible bridge window for [mem 0xfffe0000-0xffffffff pref]
>> [    3.217646] pci 0000:01:00.0: no compatible bridge window for [mem 0xfffe0000-0xffffffff pref]
>> [    3.217650] pci 0000:03:00.0: no compatible bridge window for [mem 0xffff0000-0xffffffff pref]
>> [    3.217724] pci 0000:00:01.0: BAR 6: assigned [mem 0xb0200000-0xb021ffff pref]
>> [    3.217728] pci 0000:01:00.0: BAR 6: assigned [mem 0xd6840000-0xd685ffff pref]
>> [    3.217731] pci 0000:00:02.1: PCI bridge to [bus 01]
>> [    3.217734] pci 0000:00:02.1:   bridge window [io  0x5000-0x5fff]
>> [    3.217738] pci 0000:00:02.1:   bridge window [mem 0xd6800000-0xd68fffff]
>> [    3.217741] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb01fffff 64bit pref]
>> [    3.217747] pci 0000:00:03.1: PCI bridge to [bus 02]
>> [    3.217750] pci 0000:00:03.1:   bridge window [io  0x4000-0x4fff]
>> [    3.217754] pci 0000:00:03.1:   bridge window [mem 0xd5800000-0xd67fffff]
>> [    3.217758] pci 0000:00:03.1:   bridge window [mem 0xd0800000-0xd17fffff 64bit pref]
>> [    3.217764] pci 0000:03:00.0: BAR 6: assigned [mem 0xd1800000-0xd180ffff pref]
>> [    3.217766] pci 0000:00:03.2: PCI bridge to [bus 03]
>> [    3.217768] pci 0000:00:03.2:   bridge window [io  0x3000-0x3fff]
>> [    3.217772] pci 0000:00:03.2:   bridge window [mem 0xd4800000-0xd57fffff]
>> [    3.217776] pci 0000:00:03.2:   bridge window [mem 0xd1800000-0xd27fffff 64bit pref]
>> [    3.217781] pci 0000:00:03.4: PCI bridge to [bus 04]
>> [    3.217783] pci 0000:00:03.4:   bridge window [io  0x2000-0x2fff]
>> [    3.217787] pci 0000:00:03.4:   bridge window [mem 0xd3800000-0xd47fffff]
>> [    3.217791] pci 0000:00:03.4:   bridge window [mem 0xd2800000-0xd37fffff 64bit pref]
>> [    3.217796] pci 0000:00:14.4: PCI bridge to [bus 05]
>> [    3.217839] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
>> [    3.217840] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
>> [    3.217842] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
>> [    3.217844] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff]
>> [    3.217846] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff]
>> [    3.217847] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff]
>> [    3.217849] pci_bus 0000:00: resource 10 [mem 0x000d4000-0x000d7fff]
>> [    3.217851] pci_bus 0000:00: resource 11 [mem 0x000d8000-0x000dbfff]
>> [    3.217852] pci_bus 0000:00: resource 12 [mem 0x000dc000-0x000dffff]
>> [    3.217854] pci_bus 0000:00: resource 13 [mem 0x000e0000-0x000e3fff]
>> [    3.217856] pci_bus 0000:00: resource 14 [mem 0x000e4000-0x000e7fff]
>> [    3.217857] pci_bus 0000:00: resource 15 [mem 0x000e8000-0x000ebfff]
>> [    3.217859] pci_bus 0000:00: resource 16 [mem 0x000ec000-0x000effff]
>> [    3.217860] pci_bus 0000:00: resource 17 [mem 0x000f0000-0x000fffff]
>> [    3.217862] pci_bus 0000:00: resource 18 [mem 0xa0000000-0xdfffffff]
>> [    3.217864] pci_bus 0000:00: resource 19 [mem 0xf0000000-0xfed3ffff]
>> [    3.217865] pci_bus 0000:00: resource 20 [mem 0xfed45000-0xfffdffff]
>> [    3.217868] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
>> [    3.217869] pci_bus 0000:01: resource 1 [mem 0xd6800000-0xd68fffff]
>> [    3.217871] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xb01fffff 64bit pref]
>> [    3.217873] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
>> [    3.217875] pci_bus 0000:02: resource 1 [mem 0xd5800000-0xd67fffff]
>> [    3.217876] pci_bus 0000:02: resource 2 [mem 0xd0800000-0xd17fffff 64bit pref]
>> [    3.217878] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
>> [    3.217880] pci_bus 0000:03: resource 1 [mem 0xd4800000-0xd57fffff]
>> [    3.217882] pci_bus 0000:03: resource 2 [mem 0xd1800000-0xd27fffff 64bit pref]
>> [    3.217883] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
>> [    3.217885] pci_bus 0000:04: resource 1 [mem 0xd3800000-0xd47fffff]
>> [    3.217887] pci_bus 0000:04: resource 2 [mem 0xd2800000-0xd37fffff 64bit pref]
>> [    3.217889] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
>> [    3.217890] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
>> [    3.217892] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
>> [    3.217894] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000c3fff]
>> [    3.217895] pci_bus 0000:05: resource 8 [mem 0x000c4000-0x000c7fff]
>> [    3.217897] pci_bus 0000:05: resource 9 [mem 0x000c8000-0x000cbfff]
>> [    3.217899] pci_bus 0000:05: resource 10 [mem 0x000d4000-0x000d7fff]
>> [    3.217900] pci_bus 0000:05: resource 11 [mem 0x000d8000-0x000dbfff]
>> [    3.217902] pci_bus 0000:05: resource 12 [mem 0x000dc000-0x000dffff]
>> [    3.217904] pci_bus 0000:05: resource 13 [mem 0x000e0000-0x000e3fff]
>> [    3.217905] pci_bus 0000:05: resource 14 [mem 0x000e4000-0x000e7fff]
>> [    3.217907] pci_bus 0000:05: resource 15 [mem 0x000e8000-0x000ebfff]
>> [    3.217908] pci_bus 0000:05: resource 16 [mem 0x000ec000-0x000effff]
>> [    3.217910] pci_bus 0000:05: resource 17 [mem 0x000f0000-0x000fffff]
>> [    3.217912] pci_bus 0000:05: resource 18 [mem 0xa0000000-0xdfffffff]
>> [    3.217913] pci_bus 0000:05: resource 19 [mem 0xf0000000-0xfed3ffff]
>> [    3.217915] pci_bus 0000:05: resource 20 [mem 0xfed45000-0xfffdffff]
>> [    3.217952] NET: Registered protocol family 2
>> [    3.218250] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
>> [    3.218529] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
>> [    3.218789] TCP: Hash tables configured (established 65536 bind 65536)
>> [    3.218826] TCP: reno registered
>> [    3.218843] UDP hash table entries: 4096 (order: 5, 131072 bytes)
>> [    3.218893] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
>> [    3.219011] NET: Registered protocol family 1
>> [    3.219032] pci 0000:00:01.0: Video device with shadowed ROM
>> [    3.333351] PCI: CLS mismatch (64 != 32), using 64 bytes
>> [    3.388911] Trying to unpack rootfs image as initramfs...
>> [    3.903592] Freeing initrd memory: 31236K (ffff8800342ee000 - ffff88003616f000)
>> [    3.903713] AMD-Vi: IOMMU performance counters supported
>> [    3.903958] pci 0000:00:00.2: can't derive routing for PCI INT A
>> [    3.903961] pci 0000:00:00.2: PCI INT A: no GSI - using ISA IRQ 11
>> [    3.904316] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
>> [    3.904318] AMD-Vi:  Extended features:  PPR GT IA PC
>> [    3.904323] AMD-Vi: Interrupt remapping enabled
>> [    3.904355] pci 0000:00:00.2: irq 72 for MSI/MSI-X
>> [    3.905664] AMD-Vi: Using passthrough domain for device 0000:00:01.0
>> [    3.919171] AMD-Vi: Using passthrough domain for device 0000:01:00.0
>> [    3.920903] AMD-Vi: Lazy IO/TLB flushing enabled
>> [    3.921444] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>> [    3.921448] software IO TLB [mem 0x599b6000-0x5d9b6000] (64MB) mapped at [ffff8800599b6000-ffff88005d9b5fff]
>> [    3.921781] perf: amd_iommu: Detected. (2 banks, 4 counters/bank)
>> [    3.921785] LVT offset 0 assigned for vector 0x400
>> [    3.921811] perf: AMD IBS detected (0x000001ff)
>> [    3.921868] microcode: CPU0: patch_level=0x06003106
>> [    3.921906] microcode: CPU1: patch_level=0x06003106
>> [    3.921921] microcode: CPU2: patch_level=0x06003106
>> [    3.921933] microcode: CPU3: patch_level=0x06003106
>> [    3.922025] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
>> [    3.922028] Scanning for low memory corruption every 60 seconds
>> [    3.922431] Initialise system trusted keyring
>> [    3.922482] audit: initializing netlink socket (disabled)
>> [    3.922497] type=2000 audit(1427336001.584:1): initialized
>> [    3.953477] HugeTLB registered 2 MB page size, pre-allocated 0 pages
>> [    3.955197] zbud: loaded
>> [    3.955429] VFS: Disk quotas dquot_6.5.2
>> [    3.955478] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>> [    3.956137] fuse init (API version 7.22)
>> [    3.956256] msgmni has been set to 13712
>> [    3.956315] Key type big_key registered
>> [    3.956997] Key type asymmetric registered
>> [    3.957003] Asymmetric key parser 'x509' registered
>> [    3.957078] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
>> [    3.957153] io scheduler noop registered
>> [    3.957155] io scheduler deadline registered (default)
>> [    3.957190] io scheduler cfq registered
>> [    3.957612] pcieport 0000:00:02.1: irq 73 for MSI/MSI-X
>> [    3.957974] pcieport 0000:00:03.1: irq 74 for MSI/MSI-X
>> [    3.958308] pcieport 0000:00:03.2: irq 75 for MSI/MSI-X
>> [    3.958646] pcieport 0000:00:03.4: irq 76 for MSI/MSI-X
>> [    3.958745] pcieport 0000:00:02.1: Signaling PME through PCIe PME interrupt
>> [    3.958748] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>> [    3.958752] pcie_pme 0000:00:02.1:pcie01: service driver pcie_pme loaded
>> [    3.958770] pcieport 0000:00:03.1: Signaling PME through PCIe PME interrupt
>> [    3.958772] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
>> [    3.958776] pcie_pme 0000:00:03.1:pcie01: service driver pcie_pme loaded
>> [    3.958795] pcieport 0000:00:03.2: Signaling PME through PCIe PME interrupt
>> [    3.958797] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
>> [    3.958801] pcie_pme 0000:00:03.2:pcie01: service driver pcie_pme loaded
>> [    3.958818] pcieport 0000:00:03.4: Signaling PME through PCIe PME interrupt
>> [    3.958820] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
>> [    3.958823] pcie_pme 0000:00:03.4:pcie01: service driver pcie_pme loaded
>> [    3.958839] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>> [    3.958973] pciehp 0000:00:02.1:pcie04: HPC vendor_id 1022 device_id 1425 ss_vid 1022 ss_did 1234
>> [    3.959075] pciehp 0000:00:02.1:pcie04: service driver pciehp loaded
>> [    3.959088] pciehp 0000:00:03.2:pcie04: HPC vendor_id 1022 device_id 1426 ss_vid 1022 ss_did 1234
>> [    3.959122] pciehp 0000:00:03.2:pcie04: service driver pciehp loaded
>> [    3.959133] pciehp 0000:00:03.4:pcie04: HPC vendor_id 1022 device_id 1426 ss_vid 1022 ss_did 1234
>> [    3.959163] pciehp 0000:00:03.4:pcie04: service driver pciehp loaded
>> [    3.959168] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
>> [    3.959229] ipmi message handler version 39.2
>> [    3.959489] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
>> [    3.959855] ACPI: AC Adapter [AC] (on-line)
>> [    3.959944] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input0
>> [    3.959948] ACPI: Sleep Button [SLPB]
>> [    3.959986] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
>> [    3.960014] ACPI: Lid Switch [LID]
>> [    3.960554] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
>> [    3.960557] ACPI: Power Button [PWRF]
>> [    3.960645] ACPI: acpi_idle registered with cpuidle
>> [    4.002619] thermal LNXTHERM:00: registered as thermal_zone0
>> [    4.002624] ACPI: Thermal Zone [CPUZ] (47 C)
>> [    4.042020] thermal LNXTHERM:01: registered as thermal_zone1
>> [    4.042025] ACPI: Thermal Zone [GFXZ] (0 C)
>> [    4.063006] thermal LNXTHERM:02: registered as thermal_zone2
>> [    4.063011] ACPI: Thermal Zone [EXTZ] (0 C)
>> [    4.085211] thermal LNXTHERM:03: registered as thermal_zone3
>> [    4.085216] ACPI: Thermal Zone [LOCZ] (0 C)
>> [    4.107594] thermal LNXTHERM:04: registered as thermal_zone4
>> [    4.107599] ACPI: Thermal Zone [BATZ] (21 C)
>> [    4.107699] GHES: HEST is not enabled!
>> [    4.107861] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>> [    4.109904] Linux agpgart interface v0.103
>> [    4.110057] tpm_tis 00:0b: 1.2 TPM (device-id 0x1A, rev-id 16)
>> [    4.137380] ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
>> [    4.137389] ACPI: Battery Slot [BAT0] (battery present)
>> [    4.410842] brd: module loaded
>> [    4.411976] loop: module loaded
>> [    4.412566] libphy: Fixed MDIO Bus: probed
>> [    4.412673] tun: Universal TUN/TAP device driver, 1.6
>> [    4.412675] tun: (C) 1999-2004 Max Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
>> [    4.412815] PPP generic driver version 2.4.2
>> [    4.412914] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> [    4.412927] ehci-pci: EHCI PCI platform driver
>> [    4.413264] QUIRK: Enable AMD PLL fix
>> [    4.413304] ehci-pci 0000:00:12.2: EHCI Host Controller
>> [    4.413312] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
>> [    4.413318] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
>> [    4.413331] ehci-pci 0000:00:12.2: debug port 1
>> [    4.413388] ehci-pci 0000:00:12.2: irq 17, io mem 0xd694d000
>> [    4.424672] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
>> [    4.424759] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
>> [    4.424762] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    4.424764] usb usb1: Product: EHCI Host Controller
>> [    4.424766] usb usb1: Manufacturer: Linux 3.13.0-45-generic ehci_hcd
>> [    4.424767] usb usb1: SerialNumber: 0000:00:12.2
>> [    4.425055] hub 1-0:1.0: USB hub found
>> [    4.425071] hub 1-0:1.0: 5 ports detected
>> [    4.425731] ehci-pci 0000:00:13.2: EHCI Host Controller
>> [    4.425739] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
>> [    4.425744] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
>> [    4.425757] ehci-pci 0000:00:13.2: debug port 1
>> [    4.425800] ehci-pci 0000:00:13.2: irq 17, io mem 0xd694b000
>> [    4.436701] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
>> [    4.436781] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
>> [    4.436783] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    4.436786] usb usb2: Product: EHCI Host Controller
>> [    4.436787] usb usb2: Manufacturer: Linux 3.13.0-45-generic ehci_hcd
>> [    4.436789] usb usb2: SerialNumber: 0000:00:13.2
>> [    4.437070] hub 2-0:1.0: USB hub found
>> [    4.437080] hub 2-0:1.0: 5 ports detected
>> [    4.437316] ehci-platform: EHCI generic platform driver
>> [    4.437331] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>> [    4.437333] ohci-pci: OHCI PCI platform driver
>> [    4.437698] ohci-pci 0000:00:12.0: OHCI PCI host controller
>> [    4.437706] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
>> [    4.437750] ohci-pci 0000:00:12.0: irq 18, io mem 0xd694e000
>> [    4.496756] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
>> [    4.496761] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    4.496763] usb usb3: Product: OHCI PCI host controller
>> [    4.496765] usb usb3: Manufacturer: Linux 3.13.0-45-generic ohci_hcd
>> [    4.496767] usb usb3: SerialNumber: 0000:00:12.0
>> [    4.497066] hub 3-0:1.0: USB hub found
>> [    4.497082] hub 3-0:1.0: 5 ports detected
>> [    4.497698] ohci-pci 0000:00:13.0: OHCI PCI host controller
>> [    4.497707] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 4
>> [    4.497730] ohci-pci 0000:00:13.0: irq 18, io mem 0xd694c000
>> [    4.556771] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
>> [    4.556776] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    4.556778] usb usb4: Product: OHCI PCI host controller
>> [    4.556780] usb usb4: Manufacturer: Linux 3.13.0-45-generic ohci_hcd
>> [    4.556782] usb usb4: SerialNumber: 0000:00:13.0
>> [    4.557074] hub 4-0:1.0: USB hub found
>> [    4.557091] hub 4-0:1.0: 5 ports detected
>> [    4.557556] ohci-pci 0000:00:14.5: OHCI PCI host controller
>> [    4.557564] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 5
>> [    4.557589] ohci-pci 0000:00:14.5: irq 18, io mem 0xd694a000
>> [    4.616755] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
>> [    4.616760] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    4.616763] usb usb5: Product: OHCI PCI host controller
>> [    4.616764] usb usb5: Manufacturer: Linux 3.13.0-45-generic ohci_hcd
>> [    4.616766] usb usb5: SerialNumber: 0000:00:14.5
>> [    4.617065] hub 5-0:1.0: USB hub found
>> [    4.617081] hub 5-0:1.0: 2 ports detected
>> [    4.617293] ohci-platform: OHCI generic platform driver
>> [    4.617309] uhci_hcd: USB Universal Host Controller Interface driver
>> [    4.617688] xhci_hcd 0000:00:10.0: xHCI Host Controller
>> [    4.617696] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
>> [    4.617975] xhci_hcd 0000:00:10.0: irq 77 for MSI/MSI-X
>> [    4.617985] xhci_hcd 0000:00:10.0: irq 78 for MSI/MSI-X
>> [    4.617997] xhci_hcd 0000:00:10.0: irq 79 for MSI/MSI-X
>> [    4.618006] xhci_hcd 0000:00:10.0: irq 80 for MSI/MSI-X
>> [    4.618014] xhci_hcd 0000:00:10.0: irq 81 for MSI/MSI-X
>> [    4.618166] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
>> [    4.618168] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    4.618170] usb usb6: Product: xHCI Host Controller
>> [    4.618172] usb usb6: Manufacturer: Linux 3.13.0-45-generic xhci_hcd
>> [    4.618173] usb usb6: SerialNumber: 0000:00:10.0
>> [    4.618351] hub 6-0:1.0: USB hub found
>> [    4.618394] hub 6-0:1.0: 2 ports detected
>> [    4.618621] xhci_hcd 0000:00:10.0: xHCI Host Controller
>> [    4.618625] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 7
>> [    4.621412] usb usb7: New USB device found, idVendor=1d6b, idProduct=0003
>> [    4.621414] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    4.621416] usb usb7: Product: xHCI Host Controller
>> [    4.621418] usb usb7: Manufacturer: Linux 3.13.0-45-generic xhci_hcd
>> [    4.621420] usb usb7: SerialNumber: 0000:00:10.0
>> [    4.621573] hub 7-0:1.0: USB hub found
>> [    4.621615] hub 7-0:1.0: 2 ports detected
>> [    4.633110] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>> [    4.635073] i8042: Detected active multiplexing controller, rev 1.1
>> [    4.636076] serio: i8042 KBD port at 0x60,0x64 irq 1
>> [    4.636090] serio: i8042 AUX0 port at 0x60,0x64 irq 12
>> [    4.636124] serio: i8042 AUX1 port at 0x60,0x64 irq 12
>> [    4.636148] serio: i8042 AUX2 port at 0x60,0x64 irq 12
>> [    4.636168] serio: i8042 AUX3 port at 0x60,0x64 irq 12
>> [    4.636414] mousedev: PS/2 mouse device common for all mice
>> [    4.636737] rtc_cmos 00:06: RTC can wake from S4
>> [    4.636892] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
>> [    4.636926] rtc_cmos 00:06: alarms up to one month, 114 bytes nvram, hpet irqs
>> [    4.637018] device-mapper: uevent: version 1.0.3
>> [    4.637120] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
>> [    4.637130] ledtrig-cpu: registered to indicate activity on CPUs
>> [    4.637249] TCP: cubic registered
>> [    4.637356] NET: Registered protocol family 10
>> [    4.637570] NET: Registered protocol family 17
>> [    4.637581] Key type dns_resolver registered
>> [    4.638291] Loading compiled-in X.509 certificates
>> [    4.639255] Loaded X.509 cert 'Magrathea: Glacier signing key: 34992139f3da40b620bd5517597ba85af5797c9a'
>> [    4.639315] registered taskstats version 1
>> [    4.642587] Key type trusted registered
>> [    4.644890] Key type encrypted registered
>> [    4.647127] AppArmor: AppArmor sha1 policy hashing enabled
>> [    4.661263] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
>> [    4.740749] usb 1-5: new high-speed USB device number 2 using ehci-pci
>> [    4.920681] tsc: Refined TSC clocksource calibration: 1896.456 MHz
>> [    4.958887] usb 1-5: New USB device found, idVendor=04ca, idProduct=7022
>> [    4.958892] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [    4.958894] usb 1-5: Product: HP HD Webcam
>> [    4.958896] usb 1-5: Manufacturer: DDZLD01G46C6VD
>> [    5.164915] usb 5-2: new full-speed USB device number 2 using ohci-pci
>> [    5.301416] regulator-dummy: disabling
>> [    5.301628]   Magic number: 7:312:208
>> [    5.301666] vc vcsa: hash matches
>> [    5.301773] rtc_cmos 00:06: setting system clock to 2015-03-26 02:13:24 UTC (1427336004)
>> [    5.302010] acpi-cpufreq: overriding BIOS provided _PSD data
>> [    5.302381] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
>> [    5.302383] EDD information not available.
>> [    5.302429] PM: Hibernation image not present or could not be loaded.
>> [    5.303793] Freeing unused kernel memory: 1336K (ffffffff81d20000 - ffffffff81e6e000)
>> [    5.303796] Write protecting the kernel read-only data: 12288k
>> [    5.307400] Freeing unused kernel memory: 796K (ffff880001739000 - ffff880001800000)
>> [    5.310568] Freeing unused kernel memory: 688K (ffff880001b54000 - ffff880001c00000)
>> [    5.330890] systemd-udevd[120]: starting version 204
>> [    5.333939] usb 5-2: New USB device found, idVendor=138a, idProduct=003f
>> [    5.333945] usb 5-2: New USB device strings: Mfr=0, Product=0, SerialNumber=1
>> [    5.333948] usb 5-2: SerialNumber: 00b0245f4c92
>> [    5.350932] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
>> [    5.362327] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
>> [    5.362343] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
>> [    5.364740] ahci 0000:00:11.0: version 3.0
>> [    5.382556] rtsx_pci 0000:04:00.0: irq 82 for MSI/MSI-X
>> [    5.382588] rtsx_pci 0000:04:00.0: rtsx_pci_acquire_irq: pcr->msi_en = 1, pci->irq = 82
>> [    5.384471] ahci 0000:00:11.0: irq 83 for MSI/MSI-X
>> [    5.384483] ahci 0000:00:11.0: irq 84 for MSI/MSI-X
>> [    5.384492] ahci 0000:00:11.0: irq 85 for MSI/MSI-X
>> [    5.384500] ahci 0000:00:11.0: irq 86 for MSI/MSI-X
>> [    5.384508] ahci 0000:00:11.0: irq 87 for MSI/MSI-X
>> [    5.384516] ahci 0000:00:11.0: irq 88 for MSI/MSI-X
>> [    5.384523] ahci 0000:00:11.0: irq 89 for MSI/MSI-X
>> [    5.384581] ahci 0000:00:11.0: irq 90 for MSI/MSI-X
>> [    5.384665] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
>> [    5.384671] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part
>> [    5.386691] wmi: Mapper loaded
>> [    5.389019] r8169 0000:02:00.0: irq 91 for MSI/MSI-X
>> [    5.389259] r8169 0000:02:00.0 eth0: RTL8168g/8111g at 0xffffc90000d82000, a0:2b:b8:33:f8:73, XID 10900800 IRQ 91
>> [    5.389264] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
>> [    5.390055] scsi0 : ahci
>> [    5.390217] scsi1 : ahci
>> [    5.390312] ata1: SATA max UDMA/133 abar m2048@0xd694f000 port 0xd694f100 irq 83
>> [    5.390317] ata2: SATA max UDMA/133 abar m2048@0xd694f000 port 0xd694f180 irq 84
>> [    5.413916] acpi device:01: registered as cooling_device4
>> [    5.414078] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input11
>> [    5.415565] ACPI: Video Device [DGFX] (multi-head: yes  rom: no  post: no)
>> [    5.417327] acpi device:0b: registered as cooling_device5
>> [    5.417475] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:0a/LNXVIDEO:01/input/input12
>> [    5.881505] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    5.881536] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>> [    5.884826] ata1.00: ATA-9: HGST HTS541010A9E680, JA0OA710, max UDMA/133
>> [    5.884832] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
>> [    5.886380] ata2.00: ATAPI: hp       DVDRW  SU208FB, HH01, max UDMA/100
>> [    5.886737] ata1.00: configured for UDMA/133
>> [    5.886919] scsi 0:0:0:0: Direct-Access     ATA      HGST HTS541010A9 JA0O PQ: 0 ANSI: 5
>> [    5.887165] sd 0:0:0:0: Attached scsi generic sg0 type 0
>> [    5.887186] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
>> [    5.887189] sd 0:0:0:0: [sda] 4096-byte physical blocks
>> [    5.887336] sd 0:0:0:0: [sda] Write Protect is off
>> [    5.887340] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [    5.887394] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>> [    5.889189] ata2.00: configured for UDMA/100
>> [    5.897466] scsi 1:0:0:0: CD-ROM            hp       DVDRW  SU208FB   HH01 PQ: 0 ANSI: 5
>> [    5.908816] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
>> [    5.908823] cdrom: Uniform CD-ROM driver Revision: 3.20
>> [    5.909057] sr 1:0:0:0: Attached scsi CD-ROM sr0
>> [    5.909180] sr 1:0:0:0: Attached scsi generic sg1 type 5
>> [    5.922094] Switched to clocksource tsc
>> [    5.967577]  sda: sda1 sda2 sda3
>> [    5.968354] sd 0:0:0:0: [sda] Attached SCSI disk
>> [    6.232351] psmouse serio3: synaptics: Touchpad model: 1, fw: 7.5, id: 0x1e0b1, caps: 0xf00173/0x640000/0xa2400, board id: 2653, fw id: 1481159
>> [    6.272050] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio3/input/input10
>> [    8.004756] raid6: sse2x1    5891 MB/s
>> [    8.072758] raid6: sse2x2    8250 MB/s
>> [    8.140768] raid6: sse2x4    9447 MB/s
>> [    8.140770] raid6: using algorithm sse2x4 (9447 MB/s)
>> [    8.140771] raid6: using ssse3x2 recovery algorithm
>> [    8.142436] xor: automatically using best checksumming function:
>> [    8.180873]    avx       :  8733.000 MB/sec
>> [    8.194646] bio: create slab <bio-1> at 1
>> [    8.195049] Btrfs loaded
>> [    8.252847] random: nonblocking pool is initialized
>> [    8.587973] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
>> [   18.861643] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
>> [   18.913009] Adding 7282684k swap on /dev/sda3.  Priority:-1 extents:1 across:7282684k FS
>> [   19.071730] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [   19.215239] systemd-udevd[390]: starting version 204
>> [   19.608140] lp: driver loaded but no devices found
>> [   19.627265] ppdev: user-space parallel port driver
>> [   19.627862] Initializing HPQ6001 module
>> [   19.627985] input: HP Wireless hotkeys as /devices/virtual/input/input14
>> [   19.643350] hp_accel: laptop model unknown, using default axes configuration
>> [   19.680011] AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
>> [   19.687318] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>> [   19.690260] fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
>> [   19.690266] Disabling lock debugging due to kernel taint
>> [   19.728330] ACPI Warning: 0x0000000000000b00-0x0000000000000b07 SystemIO conflicts with Region \_SB_.PCI0.SMBS.SMBO 1 (20131115/utaddress-251)
>> [   19.728340] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
>> [   19.768562] fglrx: module verification failed: signature and/or  required key missing - tainting kernel
>> [   19.773139] lis3lv02d: 8 bits 3DC sensor found
>> [   19.776807] cfg80211: Calling CRDA to update world regulatory domain
>> [   19.797615] <6>[fglrx] Maximum main memory to use for locked dma buffers: 6645 MBytes.
>> [   19.797828] <6>[fglrx]   vendor: 1002 device: 130a count: 1
>> [   19.798035] MCE: In-kernel MCE decoding enabled.
>> [   19.798729] <6>[fglrx]   vendor: 1002 device: 6901 count: 2
>> [   19.798909] <6>[fglrx] IOMMU is enabled, CrossFire are not supported on this platform
>> [   19.798912] <6>[fglrx] Disable IOMMU in BIOS options or kernel boot parameters to support CF
>> [   19.801933] EDAC MC: Ver: 3.0.0
>> [   19.807269] AMD64 EDAC driver v3.4.0
>> [   19.807328] EDAC amd64: DRAM ECC disabled.
>> [   19.807339] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
>> [   19.807339]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
>> [   19.807339]  (Note that use of the override may cause unknown side effects.)
>> [   19.808563] <6>[fglrx] ioport: bar 4, base 0x6000, size: 0x100
>> [   19.810011] <6>[fglrx] ioport: bar 4, base 0x5000, size: 0x100
>> [   19.810324] <6>[fglrx] Kernel PAT support is enabled
>> [   19.810371] <6>[fglrx] module loaded - fglrx 14.30.4 [Feb 27 2015] with 2 minors
>> [   19.828188] snd_hda_intel 0000:00:01.1: Probing card using HDA DKMS, version 0.201503121632~ubuntu14.04.1
>> [   19.828971] snd_hda_intel 0000:00:01.1: irq 92 for MSI/MSI-X
>> [   19.829085] snd_hda_intel 0000:00:14.2: Probing card using HDA DKMS, version 0.201503121632~ubuntu14.04.1
>> [   19.845203] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input15
>> [   19.856058] sound hdaudioC1D0: autoconfig for ALC3227: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
>> [   19.856072] sound hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>> [   19.856076] sound hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
>> [   19.856080] sound hdaudioC1D0:    mono: mono_out=0x0
>> [   19.856083] sound hdaudioC1D0:    inputs:
>> [   19.856087] sound hdaudioC1D0:      Mic=0x19
>> [   19.856090] sound hdaudioC1D0:      Internal Mic=0x12
>> [   19.868511] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:14.2/sound/card1/input17
>> [   19.879618] ath: phy0: Enable LNA combining
>> [   19.880803] ath: EEPROM regdomain: 0x60
>> [   19.880806] ath: EEPROM indicates we should expect a direct regpair map
>> [   19.880810] ath: Country alpha2 being used: 00
>> [   19.880812] ath: Regpair used: 0x60
>> [   19.892797] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>> [   19.893013] device-mapper: multipath: version 1.6.0 loaded
>> [   19.893403] ieee80211 phy0: Atheros AR9485 Rev:1 mem=0xffffc90011f00000, irq=36
>> [   19.936777] kvm: Nested Virtualization enabled
>> [   19.936783] kvm: Nested Paging enabled
>> [   19.954827] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:14.2/sound/card1/input16
>> [   19.956095] serio_raw serio3: raw access enabled on isa0060/serio3 (serio_raw0, minor 57)
>> [   20.124406] Bluetooth: Core ver 2.17
>> [   20.124431] NET: Registered protocol family 31
>> [   20.124434] Bluetooth: HCI device and connection manager initialized
>> [   20.124445] Bluetooth: HCI socket layer initialized
>> [   20.124448] Bluetooth: L2CAP socket layer initialized
>> [   20.124453] Bluetooth: SCO socket layer initialized
>> [   20.129080] Bluetooth: RFCOMM TTY layer initialized
>> [   20.129096] Bluetooth: RFCOMM socket layer initialized
>> [   20.129104] Bluetooth: RFCOMM ver 1.11
>> [   20.130702] type=1400 audit(1427336019.324:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=723 comm="apparmor_parser"
>> [   20.130711] type=1400 audit(1427336019.324:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=723 comm="apparmor_parser"
>> [   20.130718] type=1400 audit(1427336019.324:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=723 comm="apparmor_parser"
>> [   20.131283] type=1400 audit(1427336019.324:5): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=723 comm="apparmor_parser"
>> [   20.131292] type=1400 audit(1427336019.324:6): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=723 comm="apparmor_parser"
>> [   20.131393] type=1400 audit(1427336019.324:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/cups/backend/cups-pdf" pid=586 comm="apparmor_parser"
>> [   20.131404] type=1400 audit(1427336019.324:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cupsd" pid=586 comm="apparmor_parser"
>> [   20.131569] type=1400 audit(1427336019.324:9): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=723 comm="apparmor_parser"
>> [   20.131598] type=1400 audit(1427336019.324:10): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/sbin/dhclient" pid=727 comm="apparmor_parser"
>> [   20.131605] type=1400 audit(1427336019.324:11): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=727 comm="apparmor_parser"
>> [   20.214199] input: HP WMI hotkeys as /devices/virtual/input/input18
>> [   20.357194] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> [   20.357201] Bluetooth: BNEP filters: protocol multicast
>> [   20.357214] Bluetooth: BNEP socket layer initialized
>> [   20.386096] init: failsafe main process (749) killed by TERM signal
>> [   20.484775] init: cups main process (729) killed by HUP signal
>> [   20.484793] init: cups main process ended, respawning
>> [   20.681703] cfg80211: World regulatory domain updated:
>> [   20.681709] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
>> [   20.681712] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   20.681714] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   20.681716] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
>> [   20.681718] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   20.681719] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   21.336724] Linux video capture interface: v2.00
>> [   21.343710] uvcvideo: Found UVC 1.00 device HP HD Webcam (04ca:7022)
>> [   21.352224] input: HP HD Webcam as /devices/pci0000:00/0000:00:12.2/usb1/1-5/1-5:1.0/input/input19
>> [   21.352314] usbcore: registered new interface driver uvcvideo
>> [   21.352315] USB Video Class driver (1.1.1)
>> [   21.598069] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input20
>> [   21.924076] r8169 0000:02:00.0 eth0: link down
>> [   21.924176] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [   21.924702] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [   21.934849] AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:00.1 address=0x000000fdf80c0020 flags=0x0a00]
>> [   21.942180] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
>> [   21.945851] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
>> [   22.276988] thinkpad_ec: no ThinkPad embedded controller!
>> [   23.110635] wlan0: authenticate with 3c:ce:73:48:04:80
>> [   23.128143] wlan0: send auth to 3c:ce:73:48:04:80 (try 1/3)
>> [   24.142159] wlan0: send auth to 3c:ce:73:48:04:80 (try 2/3)
>> [   24.549478] fglrx_pci 0000:00:01.0: irq 93 for MSI/MSI-X
>> [   24.550294] <6>[fglrx] Firegl kernel thread PID: 1377
>> [   24.550423] <6>[fglrx] Firegl kernel thread PID: 1378
>> [   24.550505] <6>[fglrx] Firegl kernel thread PID: 1379
>> [   24.550622] <6>[fglrx] IRQ 93 Enabled
>> [   24.556703] <6>[fglrx] Reserved FB block: Shared offset:0, size:1000000
>> [   24.556707] <6>[fglrx] Reserved FB block: Unshared offset:fa38000, size:4000
>> [   24.556708] <6>[fglrx] Reserved FB block: Unshared offset:fa3c000, size:4c4000
>> [   24.556710] <6>[fglrx] Reserved FB block: Unshared offset:ff00000, size:100000
>> [   24.556711] <6>[fglrx] Reserved FB block: Unshared offset:3ffd7000, size:29000
>> [   24.583673] vgaarb: this pci device is not a vga device
>> [   24.799197] fglrx_pci 0000:01:00.0: irq 94 for MSI/MSI-X
>> [   24.799981] <6>[fglrx] Firegl kernel thread PID: 1382
>> [   24.800134] <6>[fglrx] Firegl kernel thread PID: 1383
>> [   24.800240] <6>[fglrx] Firegl kernel thread PID: 1384
>> [   24.800366] <6>[fglrx] IRQ 94 Enabled
>> [   24.814629] <6>[fglrx] Reserved FB block: Shared offset:0, size:1000000
>> [   24.814634] <6>[fglrx] Reserved FB block: Unshared offset:f7fa000, size:1000
>> [   24.814636] <6>[fglrx] Reserved FB block: Unshared offset:f7fb000, size:4000
>> [   24.814637] <6>[fglrx] Reserved FB block: Unshared offset:f7ff000, size:501000
>> [   24.814639] <6>[fglrx] Reserved FB block: Unshared offset:3ff5e000, size:a2000
>> [   24.845659] <6>[fglrx] ATIF platform detected with notification ID: 0xd0
>> [   24.848799] <6>[fglrx] ATIF platform detected with notification ID: 0xd0
>> [   25.082126] vgaarb: this pci device is not a vga device
>> [   25.133458] wlan0: authenticated
>> [   25.146376] wlan0: associate with 3c:ce:73:48:04:80 (try 1/3)
>> [   26.130537] wlan0: associate with 3c:ce:73:48:04:80 (try 2/3)
>> [   26.794642] init: plymouth-upstart-bridge main process ended, respawning
>> [   27.149671] wlan0: RX AssocResp from 3c:ce:73:48:04:80 (capab=0x431 status=0 aid=14)
>> [   27.149824] wlan0: associated
>> [   27.149841] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
>> [   27.149969] cfg80211: Calling CRDA for country: TW
>> [   27.150099] wlan0: deauthenticated from 3c:ce:73:48:04:80 (Reason: 23)
>> [   27.153547] ath: EEPROM regdomain: 0x809e
>> [   27.153554] ath: EEPROM indicates we should expect a country code
>> [   27.153556] ath: doing EEPROM country->regdmn map search
>> [   27.153558] ath: country maps to regdmn code: 0x50
>> [   27.153559] ath: Country alpha2 being used: TW
>> [   27.153560] ath: Regpair used: 0x50
>> [   27.153562] ath: regdomain 0x809e dynamically updated by country IE
>> [   27.153581] cfg80211: Regulatory domain changed to country: TW
>> [   27.153583] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
>> [   27.153584] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2700 mBm)
>> [   27.153586] cfg80211:   (5270000 KHz - 5330000 KHz @ 40000 KHz), (300 mBi, 1700 mBm)
>> [   27.153588] cfg80211:   (5735000 KHz - 5815000 KHz @ 40000 KHz), (300 mBi, 3000 mBm)
>> [   27.158961] cfg80211: Calling CRDA to update world regulatory domain
>> [   27.165685] cfg80211: World regulatory domain updated:
>> [   27.165692] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
>> [   27.165699] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   27.165701] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   27.165704] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
>> [   27.165706] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   27.165708] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   31.304710] wlan0: authenticate with 3c:ce:73:48:04:80
>> [   31.321349] wlan0: send auth to 3c:ce:73:48:04:80 (try 1/3)
>> [   32.130956] wlan0: send auth to 3c:ce:73:48:04:80 (try 2/3)
>> [   32.326073] wlan0: authenticated
>> [   32.339865] wlan0: associate with 3c:ce:73:48:04:80 (try 1/3)
>> [   33.143085] wlan0: associate with 3c:ce:73:48:04:80 (try 2/3)
>> [   34.119143] wlan0: associate with 3c:ce:73:48:04:80 (try 3/3)
>> [   34.342402] wlan0: RX AssocResp from 3c:ce:73:48:04:80 (capab=0x431 status=0 aid=14)
>> [   34.342565] wlan0: associated
>> [   34.342778] cfg80211: Calling CRDA for country: TW
>> [   34.342809] wlan0: deauthenticated from 3c:ce:73:48:04:80 (Reason: 23)
>> [   34.348160] ath: EEPROM regdomain: 0x809e
>> [   34.348167] ath: EEPROM indicates we should expect a country code
>> [   34.348169] ath: doing EEPROM country->regdmn map search
>> [   34.348171] ath: country maps to regdmn code: 0x50
>> [   34.348173] ath: Country alpha2 being used: TW
>> [   34.348175] ath: Regpair used: 0x50
>> [   34.348177] ath: regdomain 0x809e dynamically updated by country IE
>> [   34.348198] cfg80211: Regulatory domain changed to country: TW
>> [   34.348200] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
>> [   34.348202] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2700 mBm)
>> [   34.348205] cfg80211:   (5270000 KHz - 5330000 KHz @ 40000 KHz), (300 mBi, 1700 mBm)
>> [   34.348206] cfg80211:   (5735000 KHz - 5815000 KHz @ 40000 KHz), (300 mBi, 3000 mBm)
>> [   34.355440] cfg80211: Calling CRDA to update world regulatory domain
>> [   34.356156] wlan0: authenticate with 3c:ce:73:48:04:80
>> [   34.366285] wlan0: send auth to 3c:ce:73:48:04:80 (try 1/3)
>> [   34.366462] cfg80211: World regulatory domain updated:
>> [   34.366466] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
>> [   34.366468] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   34.366471] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   34.366473] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
>> [   34.366475] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   34.366477] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   35.155055] wlan0: send auth to 3c:ce:73:48:04:80 (try 2/3)
>> [   36.119366] wlan0: send auth to 3c:ce:73:48:04:80 (try 3/3)
>> [   36.370298] wlan0: authenticated
>> [   36.383351] wlan0: associate with 3c:ce:73:48:04:80 (try 1/3)
>> [   37.155284] wlan0: associate with 3c:ce:73:48:04:80 (try 2/3)
>> [   38.119556] wlan0: associate with 3c:ce:73:48:04:80 (try 3/3)
>> [   38.386778] wlan0: RX AssocResp from 3c:ce:73:48:04:80 (capab=0x431 status=0 aid=14)
>> [   38.386939] wlan0: associated
>> [   38.387061] cfg80211: Calling CRDA for country: TW
>> [   38.387213] wlan0: deauthenticated from 3c:ce:73:48:04:80 (Reason: 23)
>> [   38.392236] ath: EEPROM regdomain: 0x809e
>> [   38.392243] ath: EEPROM indicates we should expect a country code
>> [   38.392245] ath: doing EEPROM country->regdmn map search
>> [   38.392247] ath: country maps to regdmn code: 0x50
>> [   38.392249] ath: Country alpha2 being used: TW
>> [   38.392251] ath: Regpair used: 0x50
>> [   38.392253] ath: regdomain 0x809e dynamically updated by country IE
>> [   38.392274] cfg80211: Regulatory domain changed to country: TW
>> [   38.392276] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
>> [   38.392278] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2700 mBm)
>> [   38.392280] cfg80211:   (5270000 KHz - 5330000 KHz @ 40000 KHz), (300 mBi, 1700 mBm)
>> [   38.392282] cfg80211:   (5735000 KHz - 5815000 KHz @ 40000 KHz), (300 mBi, 3000 mBm)
>> [   38.404049] cfg80211: Calling CRDA to update world regulatory domain
>> [   38.411033] cfg80211: World regulatory domain updated:
>> [   38.411039] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
>> [   38.411041] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   38.411043] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   38.411045] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
>> [   38.411047] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   38.411049] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>> [   39.539948] systemd-hostnamed[1844]: Warning: nss-myhostname is not installed. Changing the local hostname might make it unresolveable. Please install nss-myhostname!
>

--f46d043c7e763fcaef05123a7dd4
Content-Type: text/x-log; charset=US-ASCII; name="dmesg_iommu_dump.log"
Content-Disposition: attachment; filename="dmesg_iommu_dump.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i7qve1k60

WyAgICAwLjAwMDAwMF0gSW5pdGlhbGl6aW5nIGNncm91cCBzdWJzeXMgY3B1c2V0ClsgICAgMC4w
MDAwMDBdIEluaXRpYWxpemluZyBjZ3JvdXAgc3Vic3lzIGNwdQpbICAgIDAuMDAwMDAwXSBJbml0
aWFsaXppbmcgY2dyb3VwIHN1YnN5cyBjcHVhY2N0ClsgICAgMC4wMDAwMDBdIExpbnV4IHZlcnNp
b24gNC4wLjAtMDQwMDAwcmM1LWdlbmVyaWMgKGtlcm5lbEBnb21laXNhKSAoZ2NjIHZlcnNpb24g
NC42LjMgKFVidW50dS9MaW5hcm8gNC42LjMtMXVidW50dTUpICkgIzIwMTUwMzIzMDAzNSBTTVAg
TW9uIE1hciAyMyAwNDozNjoyNiBVVEMgMjAxNQpbICAgIDAuMDAwMDAwXSBDb21tYW5kIGxpbmU6
IEJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51ei00LjAuMC0wNDAwMDByYzUtZ2VuZXJpYyByb290PVVV
SUQ9NjIyNGExYzQtODI0Yi00MWIyLTkwNzctNzAwZWRiODU4NmFkIHJvIGFtZF9pb21tdV9kdW1w
IHF1aWV0IHNwbGFzaApbICAgIDAuMDAwMDAwXSBLRVJORUwgc3VwcG9ydGVkIGNwdXM6ClsgICAg
MC4wMDAwMDBdICAgSW50ZWwgR2VudWluZUludGVsClsgICAgMC4wMDAwMDBdICAgQU1EIEF1dGhl
bnRpY0FNRApbICAgIDAuMDAwMDAwXSAgIENlbnRhdXIgQ2VudGF1ckhhdWxzClsgICAgMC4wMDAw
MDBdIHRzZWc6IDAwNWYwMDAwMDAKWyAgICAwLjAwMDAwMF0gZTgyMDogQklPUy1wcm92aWRlZCBw
aHlzaWNhbCBSQU0gbWFwOgpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAw
MDAwMDAwMDAwLTB4MDAwMDAwMDAwMDA5ZWJmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJT1Mt
ZTgyMDogW21lbSAweDAwMDAwMDAwMDAwOWVjMDAtMHgwMDAwMDAwMDAwMDlmZmZmXSByZXNlcnZl
ZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMGUwMDAwLTB4MDAw
MDAwMDAwMDBmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4
MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAwMDAwNWQ5YjVmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAw
XSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDVkOWI2MDAwLTB4MDAwMDAwMDA1ZThiMWZmZl0g
cmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA1ZThiMjAw
MC0weDAwMDAwMDAwNWVmYjFmZmZdIEFDUEkgTlZTClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDog
W21lbSAweDAwMDAwMDAwNWVmYjIwMDAtMHgwMDAwMDAwMDVlZmZlZmZmXSBBQ1BJIGRhdGEKWyAg
ICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA1ZWZmZjAwMC0weDAwMDAwMDAw
NWVmZmZmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAw
MGUwMDAwMDAwLTB4MDAwMDAwMDBlZmZmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklP
Uy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZWMwMDAwMC0weDAwMDAwMDAwZmVjMDBmZmZdIHJlc2Vy
dmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVjMTAwMDAtMHgw
MDAwMDAwMGZlYzEwZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMGZlZDgwMDAwLTB4MDAwMDAwMDBmZWQ4MGZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAw
MDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZWUwMDAwMC0weDAwMDAwMDAwZmVlMDBm
ZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmY4
MDAwMDAtMHgwMDAwMDAwMGZmZmZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4
MjA6IFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4MDAwMDAwMDI1ZWZmZmZmZl0gdXNhYmxlClsg
ICAgMC4wMDAwMDBdIE5YIChFeGVjdXRlIERpc2FibGUpIHByb3RlY3Rpb246IGFjdGl2ZQpbICAg
IDAuMDAwMDAwXSBTTUJJT1MgMi43IHByZXNlbnQuClsgICAgMC4wMDAwMDBdIERNSTogSGV3bGV0
dC1QYWNrYXJkIEhQIFByb0Jvb2sgNDQ1RzIvMjIzNCwgQklPUyBNNzUgVmVyLiAwMS4wNyAwOS8x
Ni8yMDE0ClsgICAgMC4wMDAwMDBdIGU4MjA6IHVwZGF0ZSBbbWVtIDB4MDAwMDAwMDAtMHgwMDAw
MGZmZl0gdXNhYmxlID09PiByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBlODIwOiByZW1vdmUgW21l
bSAweDAwMGEwMDAwLTB4MDAwZmZmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBBR1A6IE5vIEFH
UCBicmlkZ2UgZm91bmQKWyAgICAwLjAwMDAwMF0gZTgyMDogbGFzdF9wZm4gPSAweDI1ZjAwMCBt
YXhfYXJjaF9wZm4gPSAweDQwMDAwMDAwMApbICAgIDAuMDAwMDAwXSBNVFJSIGRlZmF1bHQgdHlw
ZTogdW5jYWNoYWJsZQpbICAgIDAuMDAwMDAwXSBNVFJSIGZpeGVkIHJhbmdlcyBlbmFibGVkOgpb
ICAgIDAuMDAwMDAwXSAgIDAwMDAwLTlGRkZGIHdyaXRlLWJhY2sKWyAgICAwLjAwMDAwMF0gICBB
MDAwMC1CRkZGRiB1bmNhY2hhYmxlClsgICAgMC4wMDAwMDBdICAgQzAwMDAtREZGRkYgd3JpdGUt
dGhyb3VnaApbICAgIDAuMDAwMDAwXSAgIEUwMDAwLUZGRkZGIHdyaXRlLXByb3RlY3QKWyAgICAw
LjAwMDAwMF0gTVRSUiB2YXJpYWJsZSByYW5nZXMgZW5hYmxlZDoKWyAgICAwLjAwMDAwMF0gICAw
IGJhc2UgMDAwMDAwMDAwMDAwIG1hc2sgRkZGRkMwMDAwMDAwIHdyaXRlLWJhY2sKWyAgICAwLjAw
MDAwMF0gICAxIGJhc2UgMDAwMDQwMDAwMDAwIG1hc2sgRkZGRkUwMDAwMDAwIHdyaXRlLWJhY2sK
WyAgICAwLjAwMDAwMF0gICAyIGJhc2UgMDAwMEZGODAwMDAwIG1hc2sgRkZGRkZGODAwMDAwIHdy
aXRlLXByb3RlY3QKWyAgICAwLjAwMDAwMF0gICAzIGRpc2FibGVkClsgICAgMC4wMDAwMDBdICAg
NCBkaXNhYmxlZApbICAgIDAuMDAwMDAwXSAgIDUgZGlzYWJsZWQKWyAgICAwLjAwMDAwMF0gICA2
IGRpc2FibGVkClsgICAgMC4wMDAwMDBdICAgNyBkaXNhYmxlZApbICAgIDAuMDAwMDAwXSBUT00y
OiAwMDAwMDAwMjVmMDAwMDAwIGFrYSA5NzEyTQpbICAgIDAuMDAwMDAwXSBQQVQgY29uZmlndXJh
dGlvbiBbMC03XTogV0IgIFdDICBVQy0gVUMgIFdCICBXQyAgVUMtIFVDICAKWyAgICAwLjAwMDAw
MF0gZTgyMDogbGFzdF9wZm4gPSAweDVmMDAwIG1heF9hcmNoX3BmbiA9IDB4NDAwMDAwMDAwClsg
ICAgMC4wMDAwMDBdIFNjYW5uaW5nIDEgYXJlYXMgZm9yIGxvdyBtZW1vcnkgY29ycnVwdGlvbgpb
ICAgIDAuMDAwMDAwXSBCYXNlIG1lbW9yeSB0cmFtcG9saW5lIGF0IFtmZmZmODgwMDAwMDk4MDAw
XSA5ODAwMCBzaXplIDI0NTc2ClsgICAgMC4wMDAwMDBdIFVzaW5nIEdCIHBhZ2VzIGZvciBkaXJl
Y3QgbWFwcGluZwpbICAgIDAuMDAwMDAwXSBpbml0X21lbW9yeV9tYXBwaW5nOiBbbWVtIDB4MDAw
MDAwMDAtMHgwMDBmZmZmZl0KWyAgICAwLjAwMDAwMF0gIFttZW0gMHgwMDAwMDAwMC0weDAwMGZm
ZmZmXSBwYWdlIDRrClsgICAgMC4wMDAwMDBdIEJSSyBbMHgwMWZjZDAwMCwgMHgwMWZjZGZmZl0g
UEdUQUJMRQpbICAgIDAuMDAwMDAwXSBCUksgWzB4MDFmY2UwMDAsIDB4MDFmY2VmZmZdIFBHVEFC
TEUKWyAgICAwLjAwMDAwMF0gQlJLIFsweDAxZmNmMDAwLCAweDAxZmNmZmZmXSBQR1RBQkxFClsg
ICAgMC4wMDAwMDBdIGluaXRfbWVtb3J5X21hcHBpbmc6IFttZW0gMHgyNWVlMDAwMDAtMHgyNWVm
ZmZmZmZdClsgICAgMC4wMDAwMDBdICBbbWVtIDB4MjVlZTAwMDAwLTB4MjVlZmZmZmZmXSBwYWdl
IDJNClsgICAgMC4wMDAwMDBdIEJSSyBbMHgwMWZkMDAwMCwgMHgwMWZkMGZmZl0gUEdUQUJMRQpb
ICAgIDAuMDAwMDAwXSBpbml0X21lbW9yeV9tYXBwaW5nOiBbbWVtIDB4MjQwMDAwMDAwLTB4MjVl
ZGZmZmZmXQpbICAgIDAuMDAwMDAwXSAgW21lbSAweDI0MDAwMDAwMC0weDI1ZWRmZmZmZl0gcGFn
ZSAyTQpbICAgIDAuMDAwMDAwXSBpbml0X21lbW9yeV9tYXBwaW5nOiBbbWVtIDB4MjIwMDAwMDAw
LTB4MjNmZmZmZmZmXQpbICAgIDAuMDAwMDAwXSAgW21lbSAweDIyMDAwMDAwMC0weDIzZmZmZmZm
Zl0gcGFnZSAxRwpbICAgIDAuMDAwMDAwXSBpbml0X21lbW9yeV9tYXBwaW5nOiBbbWVtIDB4MDAx
MDAwMDAtMHg1ZDliNWZmZl0KWyAgICAwLjAwMDAwMF0gIFttZW0gMHgwMDEwMDAwMC0weDAwMWZm
ZmZmXSBwYWdlIDRrClsgICAgMC4wMDAwMDBdICBbbWVtIDB4MDAyMDAwMDAtMHg1ZDdmZmZmZl0g
cGFnZSAyTQpbICAgIDAuMDAwMDAwXSAgW21lbSAweDVkODAwMDAwLTB4NWQ5YjVmZmZdIHBhZ2Ug
NGsKWyAgICAwLjAwMDAwMF0gaW5pdF9tZW1vcnlfbWFwcGluZzogW21lbSAweDVlZmZmMDAwLTB4
NWVmZmZmZmZdClsgICAgMC4wMDAwMDBdICBbbWVtIDB4NWVmZmYwMDAtMHg1ZWZmZmZmZl0gcGFn
ZSA0awpbICAgIDAuMDAwMDAwXSBCUksgWzB4MDFmZDEwMDAsIDB4MDFmZDFmZmZdIFBHVEFCTEUK
WyAgICAwLjAwMDAwMF0gaW5pdF9tZW1vcnlfbWFwcGluZzogW21lbSAweDEwMDAwMDAwMC0weDIx
ZmZmZmZmZl0KWyAgICAwLjAwMDAwMF0gIFttZW0gMHgxMDAwMDAwMDAtMHgyMWZmZmZmZmZdIHBh
Z2UgMUcKWyAgICAwLjAwMDAwMF0gUkFNRElTSzogW21lbSAweDMzZjRlMDAwLTB4MzVmOWVmZmZd
ClsgICAgMC4wMDAwMDBdIEFDUEk6IEVhcmx5IHRhYmxlIGNoZWNrc3VtIHZlcmlmaWNhdGlvbiBk
aXNhYmxlZApbICAgIDAuMDAwMDAwXSBBQ1BJOiBSU0RQIDB4MDAwMDAwMDAwMDBGMkY5MCAwMDAw
MjQgKHYwMiBIUFFPRU0pClsgICAgMC4wMDAwMDBdIEFDUEk6IFhTRFQgMHgwMDAwMDAwMDVFRkZE
MEU4IDAwMDA5QyAodjAxIEhQUU9FTSBTTElDLU1QQyAwMDAwMDAwMyAgICAgIDAxMDAwMDEzKQpb
ICAgIDAuMDAwMDAwXSBBQ1BJOiBGQUNQIDB4MDAwMDAwMDA1RUZGQjAwMCAwMDAxMEMgKHYwNSBI
UFFPRU0gMTgwRiAgICAgMDAwMDAwMDMgSFAgICAwMDAwMDAwMSkKWyAgICAwLjAwMDAwMF0gQUNQ
STogRFNEVCAweDAwMDAwMDAwNUVGRDgwMDAgMDFFN0FEICh2MDEgSFBRT0VNIDE4MEYgICAgIDAw
MDAwMDAxIElOVEwgMjAxMzA5MjcpClsgICAgMC4wMDAwMDBdIEFDUEk6IEZBQ1MgMHgwMDAwMDAw
MDVFRDY5MDAwIDAwMDA0MApbICAgIDAuMDAwMDAwXSBBQ1BJOiBIUEVUIDB4MDAwMDAwMDA1RUZG
QTAwMCAwMDAwMzggKHYwMSBIUFFPRU0gMTgwRiAgICAgMDAwMDAwMDEgSFAgICAwMDAwMDAwMSkK
WyAgICAwLjAwMDAwMF0gQUNQSTogQVBJQyAweDAwMDAwMDAwNUVGRjkwMDAgMDAwMDkwICh2MDEg
SFBRT0VNIDE4MEYgICAgIDAwMDAwMDAxIEhQICAgMDAwMDAwMDEpClsgICAgMC4wMDAwMDBdIEFD
UEk6IE1DRkcgMHgwMDAwMDAwMDVFRkY4MDAwIDAwMDAzQyAodjAxIEhQUU9FTSAxODBGICAgICAw
MDAwMDAwMSBIUCAgIDAwMDAwMDAxKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBUQ1BBIDB4MDAwMDAw
MDA1RUZGNzAwMCAwMDAwMzIgKHYwMiBIUFFPRU0gMTgwRiAgICAgMDAwMDAwMDAgSFAgICAwMDAw
MDAwMSkKWyAgICAwLjAwMDAwMF0gQUNQSTogRlBEVCAweDAwMDAwMDAwNUVGRDUwMDAgMDAwMDQ0
ICh2MDEgSFBRT0VNIDE4MEYgICAgIDAwMDAwMDAxIEhQICAgMDAwMDAwMDEpClsgICAgMC4wMDAw
MDBdIEFDUEk6IEJHUlQgMHgwMDAwMDAwMDVFRkQ0MDAwIDAwMDAzOCAodjAwIEhQUU9FTSAxODBG
ICAgICAwMDAwMDAwMSBIUCAgIDAwMDAwMDAxKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBTU0RUIDB4
MDAwMDAwMDA1RUZEMzAwMCAwMDBCOUMgKHYwMSBBTUQgICAgQkFMTElOQSAgMDAwMDAwMDEgQU1E
ICAwMDAwMDAwMSkKWyAgICAwLjAwMDAwMF0gQUNQSTogU1NEVCAweDAwMDAwMDAwNUVGQzkwMDAg
MDA5Mzk5ICh2MDIgQU1EICAgIEJBTExJTkEgIDAwMDAwMDAyIE1TRlQgMDQwMDAwMDApClsgICAg
MC4wMDAwMDBdIEFDUEk6IElWUlMgMHgwMDAwMDAwMDVFRkM4MDAwIDAwMDA3OCAodjAyIEFNRCAg
ICBCQUxMSU5BICAwMDAwMDAwMSBBTUQgIDAwMDAwMDAwKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBD
UkFUIDB4MDAwMDAwMDA1RUZDNzAwMCAwMDA1NTAgKHYwMSBBTUQgICAgQkFMTElOQSAgMDAwMDAw
MDEgQU1EICAwMDAwMDAwMSkKWyAgICAwLjAwMDAwMF0gQUNQSTogU1NEVCAweDAwMDAwMDAwNUVG
QzYwMDAgMDAwNzg5ICh2MDEgSFAgICAgIEFNRFNHVEJMIDAwMDAwMDAxIElOVEwgMjAxMzA5Mjcp
ClsgICAgMC4wMDAwMDBdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDVFRkM1MDAwIDAwMDMyNSAodjAx
IEhQICAgICBIUFpQT0REVCAwMDAwMDAwMSBJTlRMIDIwMTMwOTI3KQpbICAgIDAuMDAwMDAwXSBB
Q1BJOiBTU0RUIDB4MDAwMDAwMDA1RUZDNDAwMCAwMDA4MUIgKHYwMSBBTUQgICAgQ1BNQURQUzQg
MDAwMDAwMDEgSU5UTCAyMDEzMDkyNykKWyAgICAwLjAwMDAwMF0gQUNQSTogU1NEVCAweDAwMDAw
MDAwNUVGQzIwMDAgMDAxMjA3ICh2MDEgQU1EICAgIENQTUNNTiAgIDAwMDAwMDAxIElOVEwgMjAx
MzA5MjcpClsgICAgMC4wMDAwMDBdIEFDUEk6IExvY2FsIEFQSUMgYWRkcmVzcyAweGZlZTAwMDAw
ClsgICAgMC4wMDAwMDBdIE5vIE5VTUEgY29uZmlndXJhdGlvbiBmb3VuZApbICAgIDAuMDAwMDAw
XSBGYWtpbmcgYSBub2RlIGF0IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDI1ZWZm
ZmZmZl0KWyAgICAwLjAwMDAwMF0gTk9ERV9EQVRBKDApIGFsbG9jYXRlZCBbbWVtIDB4MjVlZmY5
MDAwLTB4MjVlZmZkZmZmXQpbICAgIDAuMDAwMDAwXSAgW2ZmZmZlYTAwMDAwMDAwMDAtZmZmZmVh
MDAwOTdmZmZmZl0gUE1EIC0+IFtmZmZmODgwMjU3NjAwMDAwLWZmZmY4ODAyNWU1ZmZmZmZdIG9u
IG5vZGUgMApbICAgIDAuMDAwMDAwXSBab25lIHJhbmdlczoKWyAgICAwLjAwMDAwMF0gICBETUEg
ICAgICBbbWVtIDB4MDAwMDAwMDAwMDAwMTAwMC0weDAwMDAwMDAwMDBmZmZmZmZdClsgICAgMC4w
MDAwMDBdICAgRE1BMzIgICAgW21lbSAweDAwMDAwMDAwMDEwMDAwMDAtMHgwMDAwMDAwMGZmZmZm
ZmZmXQpbICAgIDAuMDAwMDAwXSAgIE5vcm1hbCAgIFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4
MDAwMDAwMDI1ZWZmZmZmZl0KWyAgICAwLjAwMDAwMF0gTW92YWJsZSB6b25lIHN0YXJ0IGZvciBl
YWNoIG5vZGUKWyAgICAwLjAwMDAwMF0gRWFybHkgbWVtb3J5IG5vZGUgcmFuZ2VzClsgICAgMC4w
MDAwMDBdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAwMDAxMDAwLTB4MDAwMDAwMDAwMDA5
ZGZmZl0KWyAgICAwLjAwMDAwMF0gICBub2RlICAgMDogW21lbSAweDAwMDAwMDAwMDAxMDAwMDAt
MHgwMDAwMDAwMDVkOWI1ZmZmXQpbICAgIDAuMDAwMDAwXSAgIG5vZGUgICAwOiBbbWVtIDB4MDAw
MDAwMDA1ZWZmZjAwMC0weDAwMDAwMDAwNWVmZmZmZmZdClsgICAgMC4wMDAwMDBdICAgbm9kZSAg
IDA6IFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4MDAwMDAwMDI1ZWZmZmZmZl0KWyAgICAwLjAw
MDAwMF0gSW5pdG1lbSBzZXR1cCBub2RlIDAgW21lbSAweDAwMDAwMDAwMDAwMDEwMDAtMHgwMDAw
MDAwMjVlZmZmZmZmXQpbICAgIDAuMDAwMDAwXSBPbiBub2RlIDAgdG90YWxwYWdlczogMTgyMTAx
MgpbICAgIDAuMDAwMDAwXSAgIERNQSB6b25lOiA2NCBwYWdlcyB1c2VkIGZvciBtZW1tYXAKWyAg
ICAwLjAwMDAwMF0gICBETUEgem9uZTogMjEgcGFnZXMgcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0g
ICBETUEgem9uZTogMzk5NyBwYWdlcywgTElGTyBiYXRjaDowClsgICAgMC4wMDAwMDBdICAgRE1B
MzIgem9uZTogNTkyNyBwYWdlcyB1c2VkIGZvciBtZW1tYXAKWyAgICAwLjAwMDAwMF0gICBETUEz
MiB6b25lOiAzNzkzMTkgcGFnZXMsIExJRk8gYmF0Y2g6MzEKWyAgICAwLjAwMDAwMF0gICBOb3Jt
YWwgem9uZTogMjI0NjQgcGFnZXMgdXNlZCBmb3IgbWVtbWFwClsgICAgMC4wMDAwMDBdICAgTm9y
bWFsIHpvbmU6IDE0Mzc2OTYgcGFnZXMsIExJRk8gYmF0Y2g6MzEKWyAgICAwLjAwMDAwMF0gQUNQ
STogUE0tVGltZXIgSU8gUG9ydDogMHg0MDgKWyAgICAwLjAwMDAwMF0gQUNQSTogTG9jYWwgQVBJ
QyBhZGRyZXNzIDB4ZmVlMDAwMDAKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRb
MHgwMF0gbGFwaWNfaWRbMHgxMF0gZW5hYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMg
KGFjcGlfaWRbMHgwMV0gbGFwaWNfaWRbMHgxMV0gZW5hYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQ
STogTEFQSUMgKGFjcGlfaWRbMHgwMl0gbGFwaWNfaWRbMHgxMl0gZW5hYmxlZCkKWyAgICAwLjAw
MDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwM10gbGFwaWNfaWRbMHgxM10gZW5hYmxlZCkK
WyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDFdIGhpZ2ggZWRnZSBs
aW50WzB4MV0pClsgICAgMC4wMDAwMDBdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDAyXSBo
aWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlf
aWRbMHgwM10gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUNf
Tk1JIChhY3BpX2lkWzB4MDRdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4wMDAwMDBdIEFD
UEk6IElPQVBJQyAoaWRbMHgwNF0gYWRkcmVzc1sweGZlYzAwMDAwXSBnc2lfYmFzZVswXSkKWyAg
ICAwLjAwMDAwMF0gSU9BUElDWzBdOiBhcGljX2lkIDQsIHZlcnNpb24gMzMsIGFkZHJlc3MgMHhm
ZWMwMDAwMCwgR1NJIDAtMjMKWyAgICAwLjAwMDAwMF0gQUNQSTogSU9BUElDIChpZFsweDA1XSBh
ZGRyZXNzWzB4ZmVjMjAwMDBdIGdzaV9iYXNlWzI0XSkKWyAgICAwLjAwMDAwMF0gSU9BUElDWzFd
OiBhcGljX2lkIDUsIHZlcnNpb24gMzMsIGFkZHJlc3MgMHhmZWMyMDAwMCwgR1NJIDI0LTU1Clsg
ICAgMC4wMDAwMDBdIEFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJxIDAgZ2xvYmFsX2ly
cSAyIGRmbCBkZmwpClsgICAgMC4wMDAwMDBdIEFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNf
aXJxIDkgZ2xvYmFsX2lycSA5IGxvdyBsZXZlbCkKWyAgICAwLjAwMDAwMF0gQUNQSTogSVJRMCB1
c2VkIGJ5IG92ZXJyaWRlLgpbICAgIDAuMDAwMDAwXSBBQ1BJOiBJUlE5IHVzZWQgYnkgb3ZlcnJp
ZGUuClsgICAgMC4wMDAwMDBdIFVzaW5nIEFDUEkgKE1BRFQpIGZvciBTTVAgY29uZmlndXJhdGlv
biBpbmZvcm1hdGlvbgpbICAgIDAuMDAwMDAwXSBBQ1BJOiBIUEVUIGlkOiAweDQzNTM4MzAxIGJh
c2U6IDB4ZmVkMDAwMDAKWyAgICAwLjAwMDAwMF0gc21wYm9vdDogQWxsb3dpbmcgNCBDUFVzLCAw
IGhvdHBsdWcgQ1BVcwpbICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5
OiBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwMGZmZl0KWyAgICAwLjAwMDAwMF0gUE06IFJlZ2lzdGVy
ZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDAwMDllMDAwLTB4MDAwOWVmZmZdClsgICAgMC4wMDAw
MDBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHgwMDA5ZjAwMC0weDAwMDlm
ZmZmXQpbICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4
MDAwYTAwMDAtMHgwMDBkZmZmZl0KWyAgICAwLjAwMDAwMF0gUE06IFJlZ2lzdGVyZWQgbm9zYXZl
IG1lbW9yeTogW21lbSAweDAwMGUwMDAwLTB4MDAwZmZmZmZdClsgICAgMC4wMDAwMDBdIFBNOiBS
ZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg1ZDliNjAwMC0weDVlOGIxZmZmXQpbICAg
IDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4NWU4YjIwMDAt
MHg1ZWZiMWZmZl0KWyAgICAwLjAwMDAwMF0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTog
W21lbSAweDVlZmIyMDAwLTB4NWVmZmVmZmZdClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3RlcmVk
IG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg1ZjAwMDAwMC0weGRmZmZmZmZmXQpbICAgIDAuMDAwMDAw
XSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZm
Zl0KWyAgICAwLjAwMDAwMF0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGYw
MDAwMDAwLTB4ZmViZmZmZmZdClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBt
ZW1vcnk6IFttZW0gMHhmZWMwMDAwMC0weGZlYzAwZmZmXQpbICAgIDAuMDAwMDAwXSBQTTogUmVn
aXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZmVjMDEwMDAtMHhmZWMwZmZmZl0KWyAgICAw
LjAwMDAwMF0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlYzEwMDAwLTB4
ZmVjMTBmZmZdClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFtt
ZW0gMHhmZWMxMTAwMC0weGZlZDdmZmZmXQpbICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBu
b3NhdmUgbWVtb3J5OiBbbWVtIDB4ZmVkODAwMDAtMHhmZWQ4MGZmZl0KWyAgICAwLjAwMDAwMF0g
UE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlZDgxMDAwLTB4ZmVkZmZmZmZd
ClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZWUw
MDAwMC0weGZlZTAwZmZmXQpbICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVt
b3J5OiBbbWVtIDB4ZmVlMDEwMDAtMHhmZjdmZmZmZl0KWyAgICAwLjAwMDAwMF0gUE06IFJlZ2lz
dGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZmODAwMDAwLTB4ZmZmZmZmZmZdClsgICAgMC4w
MDAwMDBdIGU4MjA6IFttZW0gMHg1ZjAwMDAwMC0weGRmZmZmZmZmXSBhdmFpbGFibGUgZm9yIFBD
SSBkZXZpY2VzClsgICAgMC4wMDAwMDBdIEJvb3RpbmcgcGFyYXZpcnR1YWxpemVkIGtlcm5lbCBv
biBiYXJlIGhhcmR3YXJlClsgICAgMC4wMDAwMDBdIHNldHVwX3BlcmNwdTogTlJfQ1BVUzoyNTYg
bnJfY3B1bWFza19iaXRzOjI1NiBucl9jcHVfaWRzOjQgbnJfbm9kZV9pZHM6MQpbICAgIDAuMDAw
MDAwXSBQRVJDUFU6IEVtYmVkZGVkIDMyIHBhZ2VzL2NwdSBAZmZmZjg4MDI1ZWMwMDAwMCBzOTEw
MzIgcjgxOTIgZDMxODQ4IHU1MjQyODgKWyAgICAwLjAwMDAwMF0gcGNwdS1hbGxvYzogczkxMDMy
IHI4MTkyIGQzMTg0OCB1NTI0Mjg4IGFsbG9jPTEqMjA5NzE1MgpbICAgIDAuMDAwMDAwXSBwY3B1
LWFsbG9jOiBbMF0gMCAxIDIgMyAKWyAgICAwLjAwMDAwMF0gQnVpbHQgMSB6b25lbGlzdHMgaW4g
Tm9kZSBvcmRlciwgbW9iaWxpdHkgZ3JvdXBpbmcgb24uICBUb3RhbCBwYWdlczogMTc5MjUzNgpb
ICAgIDAuMDAwMDAwXSBQb2xpY3kgem9uZTogTm9ybWFsClsgICAgMC4wMDAwMDBdIEtlcm5lbCBj
b21tYW5kIGxpbmU6IEJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51ei00LjAuMC0wNDAwMDByYzUtZ2Vu
ZXJpYyByb290PVVVSUQ9NjIyNGExYzQtODI0Yi00MWIyLTkwNzctNzAwZWRiODU4NmFkIHJvIGFt
ZF9pb21tdV9kdW1wIHF1aWV0IHNwbGFzaApbICAgIDAuMDAwMDAwXSBQSUQgaGFzaCB0YWJsZSBl
bnRyaWVzOiA0MDk2IChvcmRlcjogMywgMzI3NjggYnl0ZXMpClsgICAgMC4wMDAwMDBdIHhzYXZl
OiBlbmFibGVkIHhzdGF0ZV9idiAweDcsIGNudHh0IHNpemUgMHgzNDAgdXNpbmcgc3RhbmRhcmQg
Zm9ybQpbICAgIDAuMDAwMDAwXSBBR1A6IENoZWNraW5nIGFwZXJ0dXJlLi4uClsgICAgMC4wMDAw
MDBdIEFHUDogTm8gQUdQIGJyaWRnZSBmb3VuZApbICAgIDAuMDAwMDAwXSBBR1A6IE5vZGUgMDog
YXBlcnR1cmUgW2J1cyBhZGRyIDB4MDAwMDAwMDAtMHgwMWZmZmZmZl0gKDMyTUIpClsgICAgMC4w
MDAwMDBdIEFHUDogWW91ciBCSU9TIGRvZXNuJ3QgbGVhdmUgYSBhcGVydHVyZSBtZW1vcnkgaG9s
ZQpbICAgIDAuMDAwMDAwXSBBR1A6IFBsZWFzZSBlbmFibGUgdGhlIElPTU1VIG9wdGlvbiBpbiB0
aGUgQklPUyBzZXR1cApbICAgIDAuMDAwMDAwXSBBR1A6IFRoaXMgY29zdHMgeW91IDY0TUIgb2Yg
UkFNClsgICAgMC4wMDAwMDBdIEFHUDogTWFwcGluZyBhcGVydHVyZSBvdmVyIFJBTSBbbWVtIDB4
NTQwMDAwMDAtMHg1N2ZmZmZmZl0gKDY1NTM2S0IpClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3Rl
cmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg1NDAwMDAwMC0weDU3ZmZmZmZmXQpbICAgIDAuMDAw
MDAwXSBNZW1vcnk6IDY5ODc1OTZLLzcyODQwNDhLIGF2YWlsYWJsZSAoODEzNEsga2VybmVsIGNv
ZGUsIDExMzZLIHJ3ZGF0YSwgMzkxMksgcm9kYXRhLCAxNDIwSyBpbml0LCAxMjkySyBic3MsIDI5
NjQ1MksgcmVzZXJ2ZWQsIDBLIGNtYS1yZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gU0xVQjogSFdh
bGlnbj02NCwgT3JkZXI9MC0zLCBNaW5PYmplY3RzPTAsIENQVXM9NCwgTm9kZXM9MQpbICAgIDAu
MDAwMDAwXSBIaWVyYXJjaGljYWwgUkNVIGltcGxlbWVudGF0aW9uLgpbICAgIDAuMDAwMDAwXSAJ
UkNVIGR5bnRpY2staWRsZSBncmFjZS1wZXJpb2QgYWNjZWxlcmF0aW9uIGlzIGVuYWJsZWQuClsg
ICAgMC4wMDAwMDBdIAlSQ1UgcmVzdHJpY3RpbmcgQ1BVcyBmcm9tIE5SX0NQVVM9MjU2IHRvIG5y
X2NwdV9pZHM9NC4KWyAgICAwLjAwMDAwMF0gUkNVOiBBZGp1c3RpbmcgZ2VvbWV0cnkgZm9yIHJj
dV9mYW5vdXRfbGVhZj0xNiwgbnJfY3B1X2lkcz00ClsgICAgMC4wMDAwMDBdIE5SX0lSUVM6MTY2
NDAgbnJfaXJxczoxMDAwIDE2ClsgICAgMC4wMDAwMDBdIAlPZmZsb2FkIFJDVSBjYWxsYmFja3Mg
ZnJvbSBhbGwgQ1BVcwpbICAgIDAuMDAwMDAwXSAJT2ZmbG9hZCBSQ1UgY2FsbGJhY2tzIGZyb20g
Q1BVczogMC0zLgpbICAgIDAuMDAwMDAwXSBzcHVyaW91cyA4MjU5QSBpbnRlcnJ1cHQ6IElSUTcu
ClsgICAgMC4wMDAwMDBdIENvbnNvbGU6IGNvbG91ciBWR0ErIDgweDI1ClsgICAgMC4wMDAwMDBd
IGNvbnNvbGUgW3R0eTBdIGVuYWJsZWQKWyAgICAwLjAwMDAwMF0gaHBldCBjbG9ja2V2ZW50IHJl
Z2lzdGVyZWQKWyAgICAwLjAwMDAwMF0gdHNjOiBGYXN0IFRTQyBjYWxpYnJhdGlvbiB1c2luZyBQ
SVQKWyAgICAwLjAwMDAwMF0gdHNjOiBEZXRlY3RlZCAxODk2LjQ2MCBNSHogcHJvY2Vzc29yClsg
ICAgMC4wMDAwMzJdIENhbGlicmF0aW5nIGRlbGF5IGxvb3AgKHNraXBwZWQpLCB2YWx1ZSBjYWxj
dWxhdGVkIHVzaW5nIHRpbWVyIGZyZXF1ZW5jeS4uIDM3OTIuOTIgQm9nb01JUFMgKGxwaj03NTg1
ODQwKQpbICAgIDAuMDAwMDM1XSBwaWRfbWF4OiBkZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAzMDEK
WyAgICAwLjAwMDA0Ml0gQUNQSTogQ29yZSByZXZpc2lvbiAyMDE1MDIwNApbICAgIDAuMDE4NzI4
XSBBQ1BJOiBBbGwgQUNQSSBUYWJsZXMgc3VjY2Vzc2Z1bGx5IGFjcXVpcmVkClsgICAgMC4wNTc0
OTNdIFNlY3VyaXR5IEZyYW1ld29yayBpbml0aWFsaXplZApbICAgIDAuMDU3NTIwXSBBcHBBcm1v
cjogQXBwQXJtb3IgaW5pdGlhbGl6ZWQKWyAgICAwLjA1NzUyMl0gWWFtYTogYmVjb21pbmcgbWlu
ZGZ1bC4KWyAgICAwLjA1ODM0OF0gRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTA0
ODU3NiAob3JkZXI6IDExLCA4Mzg4NjA4IGJ5dGVzKQpbICAgIDAuMDYxMzQ2XSBJbm9kZS1jYWNo
ZSBoYXNoIHRhYmxlIGVudHJpZXM6IDUyNDI4OCAob3JkZXI6IDEwLCA0MTk0MzA0IGJ5dGVzKQpb
ICAgIDAuMDYyNjY0XSBNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRl
cjogNSwgMTMxMDcyIGJ5dGVzKQpbICAgIDAuMDYyNjgwXSBNb3VudHBvaW50LWNhY2hlIGhhc2gg
dGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA1LCAxMzEwNzIgYnl0ZXMpClsgICAgMC4wNjMw
MDhdIEluaXRpYWxpemluZyBjZ3JvdXAgc3Vic3lzIGJsa2lvClsgICAgMC4wNjMwMTRdIEluaXRp
YWxpemluZyBjZ3JvdXAgc3Vic3lzIG1lbW9yeQpbICAgIDAuMDYzMDI1XSBJbml0aWFsaXppbmcg
Y2dyb3VwIHN1YnN5cyBkZXZpY2VzClsgICAgMC4wNjMwMzFdIEluaXRpYWxpemluZyBjZ3JvdXAg
c3Vic3lzIGZyZWV6ZXIKWyAgICAwLjA2MzAzNF0gSW5pdGlhbGl6aW5nIGNncm91cCBzdWJzeXMg
bmV0X2NscwpbICAgIDAuMDYzMDM4XSBJbml0aWFsaXppbmcgY2dyb3VwIHN1YnN5cyBwZXJmX2V2
ZW50ClsgICAgMC4wNjMwNDFdIEluaXRpYWxpemluZyBjZ3JvdXAgc3Vic3lzIG5ldF9wcmlvClsg
ICAgMC4wNjMwNDRdIEluaXRpYWxpemluZyBjZ3JvdXAgc3Vic3lzIGh1Z2V0bGIKWyAgICAwLjA2
MzA3Nl0gQ1BVOiBQaHlzaWNhbCBQcm9jZXNzb3IgSUQ6IDAKWyAgICAwLjA2MzA3N10gQ1BVOiBQ
cm9jZXNzb3IgQ29yZSBJRDogMApbICAgIDAuMDYzMDc5XSBtY2U6IENQVSBzdXBwb3J0cyA3IE1D
RSBiYW5rcwpbICAgIDAuMDYzMDg3XSBMVlQgb2Zmc2V0IDEgYXNzaWduZWQgZm9yIHZlY3RvciAw
eGY5ClsgICAgMC4wNjMwOTZdIExhc3QgbGV2ZWwgaVRMQiBlbnRyaWVzOiA0S0IgNTEyLCAyTUIg
MTAyNCwgNE1CIDUxMgpbICAgIDAuMDYzMDk4XSBMYXN0IGxldmVsIGRUTEIgZW50cmllczogNEtC
IDEwMjQsIDJNQiAxMDI0LCA0TUIgNTEyLCAxR0IgMApbICAgIDAuMDYzMjIyXSBGcmVlaW5nIFNN
UCBhbHRlcm5hdGl2ZXMgbWVtb3J5OiAyOEsgKGZmZmZmZmZmODFlODEwMDAgLSBmZmZmZmZmZjgx
ZTg4MDAwKQpbICAgIDAuMDY0NzE4XSBmdHJhY2U6IGFsbG9jYXRpbmcgMzMwOTMgZW50cmllcyBp
biAxMzAgcGFnZXMKWyAgICAwLjA4MDE3N10gQU1ELVZpOiBkZXZpY2U6IDAwOjAwLjIgY2FwOiAw
MDQwIHNlZzogMCBmbGFnczogYjggaW5mbyAwMDAwClsgICAgMC4wODAxODFdIEFNRC1WaTogICAg
ICAgIG1taW8tYWRkcjogMDAwMDAwMDBmZWI4MDAwMApbICAgIDAuMDgwMTk4XSBBTUQtVmk6ICAg
REVWX1NFTEVDVF9SQU5HRV9TVEFSVAkgZGV2aWQ6IDAwOjAxLjAgZmxhZ3M6IDAwClsgICAgMC4w
ODAyMDBdIEFNRC1WaTogICBERVZfUkFOR0VfRU5ECQkgZGV2aWQ6IGZmOjFmLjYKWyAgICAwLjA4
MTE5Ml0gQU1ELVZpOiAgIERFVl9BTElBU19SQU5HRQkJIGRldmlkOiAwNTowMC4wIGZsYWdzOiAw
MCBkZXZpZF90bzogMDA6MTQuNApbICAgIDAuMDgxMTk0XSBBTUQtVmk6ICAgREVWX1JBTkdFX0VO
RAkJIGRldmlkOiAwNToxZi43ClsgICAgMC4wODEyMDRdIEFNRC1WaTogICBERVZfU1BFQ0lBTChI
UEVUWzBdKQkJZGV2aWQ6IDAwOjE0LjAKWyAgICAwLjA4MTIwN10gQU1ELVZpOiAgIERFVl9TUEVD
SUFMKElPQVBJQ1s0XSkJCWRldmlkOiAwMDoxNC4wClsgICAgMC4wODEyMDhdIEFNRC1WaTogICBE
RVZfU1BFQ0lBTChJT0FQSUNbNV0pCQlkZXZpZDogMDA6MDAuMApbICAgIDAuMjc5NzcwXSAuLlRJ
TUVSOiB2ZWN0b3I9MHgzMCBhcGljMT0wIHBpbjE9MiBhcGljMj0tMSBwaW4yPS0xClsgICAgMC40
Mjc0NDRdIHNtcGJvb3Q6IENQVTA6IEFNRCBBMTAtNzMwMCBSYWRlb24gUjYsIDEwIENvbXB1dGUg
Q29yZXMgNEMrNkcgKGZhbTogMTUsIG1vZGVsOiAzMCwgc3RlcHBpbmc6IDAxKQpbICAgIDAuNDI3
NDgwXSBQZXJmb3JtYW5jZSBFdmVudHM6IEZhbTE1aCBjb3JlIHBlcmZjdHIsIEFNRCBQTVUgZHJp
dmVyLgpbICAgIDAuNDI3NDg3XSAuLi4gdmVyc2lvbjogICAgICAgICAgICAgICAgMApbICAgIDAu
NDI3NDg5XSAuLi4gYml0IHdpZHRoOiAgICAgICAgICAgICAgNDgKWyAgICAwLjQyNzQ5MF0gLi4u
IGdlbmVyaWMgcmVnaXN0ZXJzOiAgICAgIDYKWyAgICAwLjQyNzQ5Ml0gLi4uIHZhbHVlIG1hc2s6
ICAgICAgICAgICAgIDAwMDBmZmZmZmZmZmZmZmYKWyAgICAwLjQyNzQ5M10gLi4uIG1heCBwZXJp
b2Q6ICAgICAgICAgICAgIDAwMDA3ZmZmZmZmZmZmZmYKWyAgICAwLjQyNzQ5NF0gLi4uIGZpeGVk
LXB1cnBvc2UgZXZlbnRzOiAgIDAKWyAgICAwLjQyNzQ5NV0gLi4uIGV2ZW50IG1hc2s6ICAgICAg
ICAgICAgIDAwMDAwMDAwMDAwMDAwM2YKWyAgICAwLjQyODQxMF0gTk1JIHdhdGNoZG9nOiBlbmFi
bGVkIG9uIGFsbCBDUFVzLCBwZXJtYW5lbnRseSBjb25zdW1lcyBvbmUgaHctUE1VIGNvdW50ZXIu
ClsgICAgMC40Mjg1MzZdIHg4NjogQm9vdGluZyBTTVAgY29uZmlndXJhdGlvbjoKWyAgICAwLjQy
ODUzOF0gLi4uLiBub2RlICAjMCwgQ1BVczogICAgICAjMSAjMiAjMwpbICAgIDAuNDY4MzE2XSB4
ODY6IEJvb3RlZCB1cCAxIG5vZGUsIDQgQ1BVcwpbICAgIDAuNDY4MzIxXSBzbXBib290OiBUb3Rh
bCBvZiA0IHByb2Nlc3NvcnMgYWN0aXZhdGVkICgxNTE3MS42OCBCb2dvTUlQUykKWyAgICAwLjQ2
OTU3MV0gZGV2dG1wZnM6IGluaXRpYWxpemVkClsgICAgMC40Nzk2OTRdIGV2bTogc2VjdXJpdHku
c2VsaW51eApbICAgIDAuNDc5Njk2XSBldm06IHNlY3VyaXR5LlNNQUNLNjQKWyAgICAwLjQ3OTY5
OF0gZXZtOiBzZWN1cml0eS5TTUFDSzY0RVhFQwpbICAgIDAuNDc5NzAwXSBldm06IHNlY3VyaXR5
LlNNQUNLNjRUUkFOU01VVEUKWyAgICAwLjQ3OTcwMV0gZXZtOiBzZWN1cml0eS5TTUFDSzY0TU1B
UApbICAgIDAuNDc5NzAyXSBldm06IHNlY3VyaXR5LmltYQpbICAgIDAuNDc5NzA0XSBldm06IHNl
Y3VyaXR5LmNhcGFiaWxpdHkKWyAgICAwLjQ3OTkyOF0gUE06IFJlZ2lzdGVyaW5nIEFDUEkgTlZT
IHJlZ2lvbiBbbWVtIDB4NWU4YjIwMDAtMHg1ZWZiMWZmZl0gKDczNDAwMzIgYnl0ZXMpClsgICAg
MC40ODAzNDBdIHBpbmN0cmwgY29yZTogaW5pdGlhbGl6ZWQgcGluY3RybCBzdWJzeXN0ZW0KWyAg
ICAwLjQ4MDU2M10gUlRDIHRpbWU6ICAwOjQzOjIwLCBkYXRlOiAwMy8yNy8xNQpbICAgIDAuNDgw
NzQ2XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE2ClsgICAgMC40ODcwMzddIGNw
dWlkbGU6IHVzaW5nIGdvdmVybm9yIGxhZGRlcgpbICAgIDAuNDkxMDQwXSBjcHVpZGxlOiB1c2lu
ZyBnb3Zlcm5vciBtZW51ClsgICAgMC40OTEyODBdIEFDUEkgRkFEVCBkZWNsYXJlcyB0aGUgc3lz
dGVtIGRvZXNuJ3Qgc3VwcG9ydCBQQ0llIEFTUE0sIHNvIGRpc2FibGUgaXQKWyAgICAwLjQ5MTI4
M10gQUNQSTogYnVzIHR5cGUgUENJIHJlZ2lzdGVyZWQKWyAgICAwLjQ5MTI4Nl0gYWNwaXBocDog
QUNQSSBIb3QgUGx1ZyBQQ0kgQ29udHJvbGxlciBEcml2ZXIgdmVyc2lvbjogMC41ClsgICAgMC40
OTE0OTVdIFBDSTogTU1DT05GSUcgZm9yIGRvbWFpbiAwMDAwIFtidXMgMDAtZmZdIGF0IFttZW0g
MHhlMDAwMDAwMC0weGVmZmZmZmZmXSAoYmFzZSAweGUwMDAwMDAwKQpbICAgIDAuNDkxNDk5XSBQ
Q0k6IE1NQ09ORklHIGF0IFttZW0gMHhlMDAwMDAwMC0weGVmZmZmZmZmXSByZXNlcnZlZCBpbiBF
ODIwClsgICAgMC40OTE5NjNdIFBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0eXBlIDEgZm9yIGJh
c2UgYWNjZXNzClsgICAgMC40OTIzNDldIG10cnI6IHlvdXIgQ1BVcyBoYWQgaW5jb25zaXN0ZW50
IGZpeGVkIE1UUlIgc2V0dGluZ3MKWyAgICAwLjQ5MjM1MV0gbXRycjogeW91ciBDUFVzIGhhZCBp
bmNvbnNpc3RlbnQgdmFyaWFibGUgTVRSUiBzZXR0aW5ncwpbICAgIDAuNDkyMzUyXSBtdHJyOiBw
cm9iYWJseSB5b3VyIEJJT1MgZG9lcyBub3Qgc2V0dXAgYWxsIENQVXMuClsgICAgMC40OTIzNTNd
IG10cnI6IGNvcnJlY3RlZCBjb25maWd1cmF0aW9uLgpbICAgIDAuNDk5NTI1XSBBQ1BJOiBBZGRl
ZCBfT1NJKE1vZHVsZSBEZXZpY2UpClsgICAgMC40OTk1MzBdIEFDUEk6IEFkZGVkIF9PU0koUHJv
Y2Vzc29yIERldmljZSkKWyAgICAwLjQ5OTUzMl0gQUNQSTogQWRkZWQgX09TSSgzLjAgX1NDUCBF
eHRlbnNpb25zKQpbICAgIDAuNDk5NTM0XSBBQ1BJOiBBZGRlZCBfT1NJKFByb2Nlc3NvciBBZ2dy
ZWdhdG9yIERldmljZSkKWyAgICAzLjEwMDE5M10gQUNQSTogSW50ZXJwcmV0ZXIgZW5hYmxlZApb
ICAgIDMuMTAwMjE2XSBBQ1BJIEV4Y2VwdGlvbjogQUVfTk9UX0ZPVU5ELCBXaGlsZSBldmFsdWF0
aW5nIFNsZWVwIFN0YXRlIFtcX1MxX10gKDIwMTUwMjA0L2h3eGZhY2UtNTgwKQpbICAgIDMuMTAw
MjI0XSBBQ1BJIEV4Y2VwdGlvbjogQUVfTk9UX0ZPVU5ELCBXaGlsZSBldmFsdWF0aW5nIFNsZWVw
IFN0YXRlIFtcX1MyX10gKDIwMTUwMjA0L2h3eGZhY2UtNTgwKQpbICAgIDMuMTAwMjQ4XSBBQ1BJ
OiAoc3VwcG9ydHMgUzAgUzMgUzQgUzUpClsgICAgMy4xMDAyNTFdIEFDUEk6IFVzaW5nIElPQVBJ
QyBmb3IgaW50ZXJydXB0IHJvdXRpbmcKWyAgICAzLjEwMDYyMl0gUENJOiBVc2luZyBob3N0IGJy
aWRnZSB3aW5kb3dzIGZyb20gQUNQSTsgaWYgbmVjZXNzYXJ5LCB1c2UgInBjaT1ub2NycyIgYW5k
IHJlcG9ydCBhIGJ1ZwpbICAgIDMuMTA1MDA3XSBBQ1BJOiBQb3dlciBSZXNvdXJjZSBbQVBQUl0g
KG9mZikKWyAgICAzLjExMzc4Ml0gW0Zpcm13YXJlIEJ1Z106IEFDUEk6IEJJT1MgX09TSShMaW51
eCkgcXVlcnkgaWdub3JlZApbICAgIDMuMTE0Mjc2XSBBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2UgW1BD
STBdIChkb21haW4gMDAwMCBbYnVzIDAwLWZmXSkKWyAgICAzLjExNDI4NV0gYWNwaSBQTlAwQTA4
OjAwOiBfT1NDOiBPUyBzdXBwb3J0cyBbRXh0ZW5kZWRDb25maWcgQVNQTSBDbG9ja1BNIFNlZ21l
bnRzIE1TSV0KWyAgICAzLjExNDgyMF0gYWNwaSBQTlAwQTA4OjAwOiBfT1NDOiBPUyBub3cgY29u
dHJvbHMgW1BDSWVIb3RwbHVnIFBNRSBBRVIgUENJZUNhcGFiaWxpdHldClsgICAgMy4xMTQ5NjFd
IGFjcGkgUE5QMEEwODowMDogaWdub3JpbmcgaG9zdCBicmlkZ2Ugd2luZG93IFttZW0gMHgwMDBj
YzAwMC0weDAwMGNmZmZmIHdpbmRvd10gKGNvbmZsaWN0cyB3aXRoIFZpZGVvIFJPTSBbbWVtIDB4
MDAwYzAwMDAtMHgwMDBjZjVmZl0pClsgICAgMy4xMTQ5NjRdIGFjcGkgUE5QMEEwODowMDogaWdu
b3JpbmcgaG9zdCBicmlkZ2Ugd2luZG93IFttZW0gMHgwMDBkMDAwMC0weDAwMGQzZmZmIHdpbmRv
d10gKGNvbmZsaWN0cyB3aXRoIEFkYXB0ZXIgUk9NIFttZW0gMHgwMDBjZjgwMC0weDAwMGQwN2Zm
XSkKWyAgICAzLjExNTI1OF0gUENJIGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAwOjAwClsgICAgMy4x
MTUyNjJdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2J1cyAwMC1mZl0KWyAg
ICAzLjExNTI2NV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4MDAw
MC0weDBjZjcgd2luZG93XQpbICAgIDMuMTE1MjY3XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVz
IHJlc291cmNlIFtpbyAgMHgwZDAwLTB4ZmZmZiB3aW5kb3ddClsgICAgMy4xMTUyNjldIHBjaV9i
dXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweDAwMGEwMDAwLTB4MDAwYmZmZmYg
d2luZG93XQpbICAgIDMuMTE1MjcxXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNl
IFttZW0gMHgwMDBjMDAwMC0weDAwMGMzZmZmIHdpbmRvd10KWyAgICAzLjExNTI3M10gcGNpX2J1
cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4MDAwYzQwMDAtMHgwMDBjN2ZmZiB3
aW5kb3ddClsgICAgMy4xMTUyNzVdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2Ug
W21lbSAweDAwMGM4MDAwLTB4MDAwY2JmZmYgd2luZG93XQpbICAgIDMuMTE1Mjc3XSBwY2lfYnVz
IDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0gMHgwMDBkNDAwMC0weDAwMGQ3ZmZmIHdp
bmRvd10KWyAgICAzLjExNTI3OF0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBb
bWVtIDB4MDAwZDgwMDAtMHgwMDBkYmZmZiB3aW5kb3ddClsgICAgMy4xMTUyODBdIHBjaV9idXMg
MDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweDAwMGRjMDAwLTB4MDAwZGZmZmYgd2lu
ZG93XQpbICAgIDMuMTE1MjgyXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtt
ZW0gMHgwMDBlMDAwMC0weDAwMGUzZmZmIHdpbmRvd10KWyAgICAzLjExNTI4M10gcGNpX2J1cyAw
MDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4MDAwZTQwMDAtMHgwMDBlN2ZmZiB3aW5k
b3ddClsgICAgMy4xMTUyODVdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21l
bSAweDAwMGU4MDAwLTB4MDAwZWJmZmYgd2luZG93XQpbICAgIDMuMTE1Mjg3XSBwY2lfYnVzIDAw
MDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0gMHgwMDBlYzAwMC0weDAwMGVmZmZmIHdpbmRv
d10KWyAgICAzLjExNTI4OV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVt
IDB4MDAwZjAwMDAtMHgwMDBmZmZmZiB3aW5kb3ddClsgICAgMy4xMTUyOTBdIHBjaV9idXMgMDAw
MDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweGEwMDAwMDAwLTB4ZGZmZmZmZmYgd2luZG93
XQpbICAgIDMuMTE1MjkyXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0g
MHhmMDAwMDAwMC0weGZlZDNmZmZmIHdpbmRvd10KWyAgICAzLjExNTI5NF0gcGNpX2J1cyAwMDAw
OjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4ZmVkNDUwMDAtMHhmZmZkZmZmZiB3aW5kb3dd
ClsgICAgMy4xMTUzMDNdIHBjaSAwMDAwOjAwOjAwLjA6IFsxMDIyOjE0MjJdIHR5cGUgMDAgY2xh
c3MgMHgwNjAwMDAKWyAgICAzLjExNTQ4NF0gcGNpIDAwMDA6MDA6MDAuMjogWzEwMjI6MTQyM10g
dHlwZSAwMCBjbGFzcyAweDA4MDYwMApbICAgIDMuMTE1NzI1XSBwY2kgMDAwMDowMDowMS4wOiBb
MTAwMjoxMzBhXSB0eXBlIDAwIGNsYXNzIDB4MDMwMDAwClsgICAgMy4xMTU3NDFdIHBjaSAwMDAw
OjAwOjAxLjA6IHJlZyAweDEwOiBbbWVtIDB4YzAwMDAwMDAtMHhjZmZmZmZmZiA2NGJpdCBwcmVm
XQpbICAgIDMuMTE1NzUyXSBwY2kgMDAwMDowMDowMS4wOiByZWcgMHgxODogW21lbSAweGQwMDAw
MDAwLTB4ZDA3ZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAzLjExNTc1OV0gcGNpIDAwMDA6MDA6MDEu
MDogcmVnIDB4MjA6IFtpbyAgMHg2MDAwLTB4NjBmZl0KWyAgICAzLjExNTc2N10gcGNpIDAwMDA6
MDA6MDEuMDogcmVnIDB4MjQ6IFttZW0gMHhkNjkwMDAwMC0weGQ2OTNmZmZmXQpbICAgIDMuMTE1
Nzc0XSBwY2kgMDAwMDowMDowMS4wOiByZWcgMHgzMDogW21lbSAweGZmZmUwMDAwLTB4ZmZmZmZm
ZmYgcHJlZl0KWyAgICAzLjExNTgyNF0gcGNpIDAwMDA6MDA6MDEuMDogc3VwcG9ydHMgRDEgRDIK
WyAgICAzLjExNTgyNl0gcGNpIDAwMDA6MDA6MDEuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMSBE
MiBEM2hvdApbICAgIDMuMTE1OTQ3XSBwY2kgMDAwMDowMDowMS4xOiBbMTAwMjoxMzA4XSB0eXBl
IDAwIGNsYXNzIDB4MDQwMzAwClsgICAgMy4xMTU5NjJdIHBjaSAwMDAwOjAwOjAxLjE6IHJlZyAw
eDEwOiBbbWVtIDB4ZDY5NDAwMDAtMHhkNjk0M2ZmZiA2NGJpdF0KWyAgICAzLjExNjAzMF0gcGNp
IDAwMDA6MDA6MDEuMTogc3VwcG9ydHMgRDEgRDIKWyAgICAzLjExNjE4NV0gcGNpIDAwMDA6MDA6
MDIuMDogWzEwMjI6MTQyNF0gdHlwZSAwMCBjbGFzcyAweDA2MDAwMApbICAgIDMuMTE2MzAzXSBw
Y2kgMDAwMDowMDowMi4xOiBbMTAyMjoxNDI1XSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwClsgICAg
My4xMTYzODVdIHBjaSAwMDAwOjAwOjAyLjE6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3Qg
RDNjb2xkClsgICAgMy4xMTY1NjldIHBjaSAwMDAwOjAwOjAzLjA6IFsxMDIyOjE0MjRdIHR5cGUg
MDAgY2xhc3MgMHgwNjAwMDAKWyAgICAzLjExNjY5M10gcGNpIDAwMDA6MDA6MDMuMTogWzEwMjI6
MTQyNl0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMApbICAgIDMuMTE2NzcwXSBwY2kgMDAwMDowMDow
My4xOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDMuMTE2ODI2XSBw
Y2kgMDAwMDowMDowMy4xOiBTeXN0ZW0gd2FrZXVwIGRpc2FibGVkIGJ5IEFDUEkKWyAgICAzLjEx
Njg3Nl0gcGNpIDAwMDA6MDA6MDMuMjogWzEwMjI6MTQyNl0gdHlwZSAwMSBjbGFzcyAweDA2MDQw
MApbICAgIDMuMTE2OTUzXSBwY2kgMDAwMDowMDowMy4yOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQw
IEQzaG90IEQzY29sZApbICAgIDMuMTE3MDA4XSBwY2kgMDAwMDowMDowMy4yOiBTeXN0ZW0gd2Fr
ZXVwIGRpc2FibGVkIGJ5IEFDUEkKWyAgICAzLjExNzExOV0gcGNpIDAwMDA6MDA6MDMuNDogWzEw
MjI6MTQyNl0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMApbICAgIDMuMTE3MTk2XSBwY2kgMDAwMDow
MDowMy40OiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDMuMTE3MjUw
XSBwY2kgMDAwMDowMDowMy40OiBTeXN0ZW0gd2FrZXVwIGRpc2FibGVkIGJ5IEFDUEkKWyAgICAz
LjExNzM1Nl0gcGNpIDAwMDA6MDA6MDQuMDogWzEwMjI6MTQyNF0gdHlwZSAwMCBjbGFzcyAweDA2
MDAwMApbICAgIDMuMTE3NTI0XSBwY2kgMDAwMDowMDoxMC4wOiBbMTAyMjo3ODE0XSB0eXBlIDAw
IGNsYXNzIDB4MGMwMzMwClsgICAgMy4xMTc1NTBdIHBjaSAwMDAwOjAwOjEwLjA6IHJlZyAweDEw
OiBbbWVtIDB4ZDY5NDgwMDAtMHhkNjk0OWZmZiA2NGJpdF0KWyAgICAzLjExNzY2Nl0gcGNpIDAw
MDA6MDA6MTAuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAzLjEx
NzcyNV0gcGNpIDAwMDA6MDA6MTAuMDogU3lzdGVtIHdha2V1cCBkaXNhYmxlZCBieSBBQ1BJClsg
ICAgMy4xMTc4MTZdIHBjaSAwMDAwOjAwOjExLjA6IFsxMDIyOjc4MDFdIHR5cGUgMDAgY2xhc3Mg
MHgwMTA2MDEKWyAgICAzLjExNzgzN10gcGNpIDAwMDA6MDA6MTEuMDogcmVnIDB4MTA6IFtpbyAg
MHg2MTE4LTB4NjExZl0KWyAgICAzLjExNzg0N10gcGNpIDAwMDA6MDA6MTEuMDogcmVnIDB4MTQ6
IFtpbyAgMHg2MTI0LTB4NjEyN10KWyAgICAzLjExNzg3OF0gcGNpIDAwMDA6MDA6MTEuMDogcmVn
IDB4MTg6IFtpbyAgMHg2MTEwLTB4NjExN10KWyAgICAzLjExNzg4OV0gcGNpIDAwMDA6MDA6MTEu
MDogcmVnIDB4MWM6IFtpbyAgMHg2MTIwLTB4NjEyM10KWyAgICAzLjExNzg5OV0gcGNpIDAwMDA6
MDA6MTEuMDogcmVnIDB4MjA6IFtpbyAgMHg2MTAwLTB4NjEwZl0KWyAgICAzLjExNzkxMV0gcGNp
IDAwMDA6MDA6MTEuMDogcmVnIDB4MjQ6IFttZW0gMHhkNjk0ZjAwMC0weGQ2OTRmN2ZmXQpbICAg
IDMuMTE4MDg5XSBwY2kgMDAwMDowMDoxMi4wOiBbMTAyMjo3ODA3XSB0eXBlIDAwIGNsYXNzIDB4
MGMwMzEwClsgICAgMy4xMTgxMDVdIHBjaSAwMDAwOjAwOjEyLjA6IHJlZyAweDEwOiBbbWVtIDB4
ZDY5NGUwMDAtMHhkNjk0ZWZmZl0KWyAgICAzLjExODI3M10gcGNpIDAwMDA6MDA6MTIuMDogU3lz
dGVtIHdha2V1cCBkaXNhYmxlZCBieSBBQ1BJClsgICAgMy4xMTgzNjhdIHBjaSAwMDAwOjAwOjEy
LjI6IFsxMDIyOjc4MDhdIHR5cGUgMDAgY2xhc3MgMHgwYzAzMjAKWyAgICAzLjExODM5MF0gcGNp
IDAwMDA6MDA6MTIuMjogcmVnIDB4MTA6IFttZW0gMHhkNjk0ZDAwMC0weGQ2OTRkMGZmXQpbICAg
IDMuMTE4NDg0XSBwY2kgMDAwMDowMDoxMi4yOiBzdXBwb3J0cyBEMSBEMgpbICAgIDMuMTE4NDg2
XSBwY2kgMDAwMDowMDoxMi4yOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQxIEQyIEQzaG90IEQz
Y29sZApbICAgIDMuMTE4NTQ0XSBwY2kgMDAwMDowMDoxMi4yOiBTeXN0ZW0gd2FrZXVwIGRpc2Fi
bGVkIGJ5IEFDUEkKWyAgICAzLjExODYzM10gcGNpIDAwMDA6MDA6MTMuMDogWzEwMjI6NzgwN10g
dHlwZSAwMCBjbGFzcyAweDBjMDMxMApbICAgIDMuMTE4NjQ5XSBwY2kgMDAwMDowMDoxMy4wOiBy
ZWcgMHgxMDogW21lbSAweGQ2OTRjMDAwLTB4ZDY5NGNmZmZdClsgICAgMy4xMTg4MDhdIHBjaSAw
MDAwOjAwOjEzLjA6IFN5c3RlbSB3YWtldXAgZGlzYWJsZWQgYnkgQUNQSQpbICAgIDMuMTE4OTEy
XSBwY2kgMDAwMDowMDoxMy4yOiBbMTAyMjo3ODA4XSB0eXBlIDAwIGNsYXNzIDB4MGMwMzIwClsg
ICAgMy4xMTg5MzNdIHBjaSAwMDAwOjAwOjEzLjI6IHJlZyAweDEwOiBbbWVtIDB4ZDY5NGIwMDAt
MHhkNjk0YjBmZl0KWyAgICAzLjExOTAyM10gcGNpIDAwMDA6MDA6MTMuMjogc3VwcG9ydHMgRDEg
RDIKWyAgICAzLjExOTAyNV0gcGNpIDAwMDA6MDA6MTMuMjogUE1FIyBzdXBwb3J0ZWQgZnJvbSBE
MCBEMSBEMiBEM2hvdCBEM2NvbGQKWyAgICAzLjExOTA3NF0gcGNpIDAwMDA6MDA6MTMuMjogU3lz
dGVtIHdha2V1cCBkaXNhYmxlZCBieSBBQ1BJClsgICAgMy4xMTkxNTZdIHBjaSAwMDAwOjAwOjE0
LjA6IFsxMDIyOjc4MGJdIHR5cGUgMDAgY2xhc3MgMHgwYzA1MDAKWyAgICAzLjExOTM0Ml0gcGNp
IDAwMDA6MDA6MTQuMjogWzEwMjI6NzgwZF0gdHlwZSAwMCBjbGFzcyAweDA0MDMwMApbICAgIDMu
MTE5MzY2XSBwY2kgMDAwMDowMDoxNC4yOiByZWcgMHgxMDogW21lbSAweGQ2OTQ0MDAwLTB4ZDY5
NDdmZmYgNjRiaXRdClsgICAgMy4xMTk0MzhdIHBjaSAwMDAwOjAwOjE0LjI6IFBNRSMgc3VwcG9y
dGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMy4xMTk0ODddIHBjaSAwMDAwOjAwOjE0LjI6
IFN5c3RlbSB3YWtldXAgZGlzYWJsZWQgYnkgQUNQSQpbICAgIDMuMTE5NTg2XSBwY2kgMDAwMDow
MDoxNC4zOiBbMTAyMjo3ODBlXSB0eXBlIDAwIGNsYXNzIDB4MDYwMTAwClsgICAgMy4xMTk3ODBd
IHBjaSAwMDAwOjAwOjE0LjQ6IFsxMDIyOjc4MGZdIHR5cGUgMDEgY2xhc3MgMHgwNjA0MDEKWyAg
ICAzLjExOTkzNF0gcGNpIDAwMDA6MDA6MTQuNTogWzEwMjI6NzgwOV0gdHlwZSAwMCBjbGFzcyAw
eDBjMDMxMApbICAgIDMuMTE5OTQ5XSBwY2kgMDAwMDowMDoxNC41OiByZWcgMHgxMDogW21lbSAw
eGQ2OTRhMDAwLTB4ZDY5NGFmZmZdClsgICAgMy4xMjAxMzNdIHBjaSAwMDAwOjAwOjE4LjA6IFsx
MDIyOjE0MWFdIHR5cGUgMDAgY2xhc3MgMHgwNjAwMDAKWyAgICAzLjEyMDIzMV0gcGNpIDAwMDA6
MDA6MTguMTogWzEwMjI6MTQxYl0gdHlwZSAwMCBjbGFzcyAweDA2MDAwMApbICAgIDMuMTIwMzI4
XSBwY2kgMDAwMDowMDoxOC4yOiBbMTAyMjoxNDFjXSB0eXBlIDAwIGNsYXNzIDB4MDYwMDAwClsg
ICAgMy4xMjA0MjVdIHBjaSAwMDAwOjAwOjE4LjM6IFsxMDIyOjE0MWRdIHR5cGUgMDAgY2xhc3Mg
MHgwNjAwMDAKWyAgICAzLjEyMDUzN10gcGNpIDAwMDA6MDA6MTguNDogWzEwMjI6MTQxZV0gdHlw
ZSAwMCBjbGFzcyAweDA2MDAwMApbICAgIDMuMTIwNjM4XSBwY2kgMDAwMDowMDoxOC41OiBbMTAy
MjoxNDFmXSB0eXBlIDAwIGNsYXNzIDB4MDYwMDAwClsgICAgMy4xMjA5MTRdIHBjaSAwMDAwOjAx
OjAwLjA6IFsxMDAyOjY5MDFdIHR5cGUgMDAgY2xhc3MgMHgwMzgwMDAKWyAgICAzLjEyMDk1MF0g
cGNpIDAwMDA6MDE6MDAuMDogcmVnIDB4MTA6IFttZW0gMHhhMDAwMDAwMC0weGFmZmZmZmZmIDY0
Yml0IHByZWZdClsgICAgMy4xMjA5NzRdIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDE4OiBbbWVt
IDB4YjAwMDAwMDAtMHhiMDFmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDMuMTIwOTkwXSBwY2kgMDAw
MDowMTowMC4wOiByZWcgMHgyMDogW2lvICAweDUwMDAtMHg1MGZmXQpbICAgIDMuMTIxMDA3XSBw
Y2kgMDAwMDowMTowMC4wOiByZWcgMHgyNDogW21lbSAweGQ2ODAwMDAwLTB4ZDY4M2ZmZmZdClsg
ICAgMy4xMjEwMjNdIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDMwOiBbbWVtIDB4ZmZmZTAwMDAt
MHhmZmZmZmZmZiBwcmVmXQpbICAgIDMuMTIxMTU0XSBwY2kgMDAwMDowMTowMC4wOiBzdXBwb3J0
cyBEMSBEMgpbICAgIDMuMTI4NjE5XSBwY2kgMDAwMDowMDowMi4xOiBQQ0kgYnJpZGdlIHRvIFti
dXMgMDFdClsgICAgMy4xMjg2MzBdIHBjaSAwMDAwOjAwOjAyLjE6ICAgYnJpZGdlIHdpbmRvdyBb
aW8gIDB4NTAwMC0weDVmZmZdClsgICAgMy4xMjg2MzRdIHBjaSAwMDAwOjAwOjAyLjE6ICAgYnJp
ZGdlIHdpbmRvdyBbbWVtIDB4ZDY4MDAwMDAtMHhkNjhmZmZmZl0KWyAgICAzLjEyODY0MF0gcGNp
IDAwMDA6MDA6MDIuMTogICBicmlkZ2Ugd2luZG93IFttZW0gMHhhMDAwMDAwMC0weGIwMWZmZmZm
IDY0Yml0IHByZWZdClsgICAgMy4xMjg4MDldIHBjaSAwMDAwOjAyOjAwLjA6IFsxMGVjOjgxNjhd
IHR5cGUgMDAgY2xhc3MgMHgwMjAwMDAKWyAgICAzLjEyODgzOV0gcGNpIDAwMDA6MDI6MDAuMDog
cmVnIDB4MTA6IFtpbyAgMHg0MDAwLTB4NDBmZl0KWyAgICAzLjEyODg3MF0gcGNpIDAwMDA6MDI6
MDAuMDogcmVnIDB4MTg6IFttZW0gMHhkNTgwNDAwMC0weGQ1ODA0ZmZmIDY0Yml0XQpbICAgIDMu
MTI4ODkyXSBwY2kgMDAwMDowMjowMC4wOiByZWcgMHgyMDogW21lbSAweGQ1ODAwMDAwLTB4ZDU4
MDNmZmYgNjRiaXRdClsgICAgMy4xMjkwMTNdIHBjaSAwMDAwOjAyOjAwLjA6IHN1cHBvcnRzIEQx
IEQyClsgICAgMy4xMjkwMTVdIHBjaSAwMDAwOjAyOjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20g
RDAgRDEgRDIgRDNob3QgRDNjb2xkClsgICAgMy4xMjkwODBdIHBjaSAwMDAwOjAyOjAwLjA6IFN5
c3RlbSB3YWtldXAgZGlzYWJsZWQgYnkgQUNQSQpbICAgIDMuMTM2NjM5XSBwY2kgMDAwMDowMDow
My4xOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDJdClsgICAgMy4xMzY2NTBdIHBjaSAwMDAwOjAwOjAz
LjE6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4NDAwMC0weDRmZmZdClsgICAgMy4xMzY2NTVdIHBj
aSAwMDAwOjAwOjAzLjE6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZDU4MDAwMDAtMHhkNjdmZmZm
Zl0KWyAgICAzLjEzNjY2MV0gcGNpIDAwMDA6MDA6MDMuMTogICBicmlkZ2Ugd2luZG93IFttZW0g
MHhkMDgwMDAwMC0weGQxN2ZmZmZmIDY0Yml0IHByZWZdClsgICAgMy4xMzY4NDVdIHBjaSAwMDAw
OjAzOjAwLjA6IFsxNjhjOjAwMzJdIHR5cGUgMDAgY2xhc3MgMHgwMjgwMDAKWyAgICAzLjEzNjg3
NF0gcGNpIDAwMDA6MDM6MDAuMDogcmVnIDB4MTA6IFttZW0gMHhkNDgwMDAwMC0weGQ0ODdmZmZm
IDY0Yml0XQpbICAgIDMuMTM2OTIyXSBwY2kgMDAwMDowMzowMC4wOiByZWcgMHgzMDogW21lbSAw
eGZmZmYwMDAwLTB4ZmZmZmZmZmYgcHJlZl0KWyAgICAzLjEzNzAwMV0gcGNpIDAwMDA6MDM6MDAu
MDogc3VwcG9ydHMgRDEgRDIKWyAgICAzLjEzNzAwM10gcGNpIDAwMDA6MDM6MDAuMDogUE1FIyBz
dXBwb3J0ZWQgZnJvbSBEMCBEMSBEMiBEM2hvdCBEM2NvbGQKWyAgICAzLjE0NDYxNl0gcGNpIDAw
MDA6MDA6MDMuMjogUENJIGJyaWRnZSB0byBbYnVzIDAzXQpbICAgIDMuMTQ0NjI3XSBwY2kgMDAw
MDowMDowMy4yOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDMwMDAtMHgzZmZmXQpbICAgIDMuMTQ0
NjMyXSBwY2kgMDAwMDowMDowMy4yOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGQ0ODAwMDAwLTB4
ZDU3ZmZmZmZdClsgICAgMy4xNDQ2MzddIHBjaSAwMDAwOjAwOjAzLjI6ICAgYnJpZGdlIHdpbmRv
dyBbbWVtIDB4ZDE4MDAwMDAtMHhkMjdmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDMuMTQ0ODEzXSBw
Y2kgMDAwMDowNDowMC4wOiBbMTBlYzo1MjI5XSB0eXBlIDAwIGNsYXNzIDB4ZmYwMDAwClsgICAg
My4xNDQ4NTZdIHBjaSAwMDAwOjA0OjAwLjA6IHJlZyAweDEwOiBbbWVtIDB4ZDM4MDAwMDAtMHhk
MzgwMGZmZl0KWyAgICAzLjE0NTAwMl0gcGNpIDAwMDA6MDQ6MDAuMDogc3VwcG9ydHMgRDEgRDIK
WyAgICAzLjE0NTAwNF0gcGNpIDAwMDA6MDQ6MDAuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMSBE
MiBEM2hvdApbICAgIDMuMTUyNjI0XSBwY2kgMDAwMDowMDowMy40OiBQQ0kgYnJpZGdlIHRvIFti
dXMgMDRdClsgICAgMy4xNTI2MzVdIHBjaSAwMDAwOjAwOjAzLjQ6ICAgYnJpZGdlIHdpbmRvdyBb
aW8gIDB4MjAwMC0weDJmZmZdClsgICAgMy4xNTI2NDBdIHBjaSAwMDAwOjAwOjAzLjQ6ICAgYnJp
ZGdlIHdpbmRvdyBbbWVtIDB4ZDM4MDAwMDAtMHhkNDdmZmZmZl0KWyAgICAzLjE1MjY0Nl0gcGNp
IDAwMDA6MDA6MDMuNDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhkMjgwMDAwMC0weGQzN2ZmZmZm
IDY0Yml0IHByZWZdClsgICAgMy4xNTI4MjldIHBjaSAwMDAwOjAwOjE0LjQ6IFBDSSBicmlkZ2Ug
dG8gW2J1cyAwNV0gKHN1YnRyYWN0aXZlIGRlY29kZSkKWyAgICAzLjE1Mjg0MF0gcGNpIDAwMDA6
MDA6MTQuNDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgwMDAwLTB4MGNmNyB3aW5kb3ddIChzdWJ0
cmFjdGl2ZSBkZWNvZGUpClsgICAgMy4xNTI4NDJdIHBjaSAwMDAwOjAwOjE0LjQ6ICAgYnJpZGdl
IHdpbmRvdyBbaW8gIDB4MGQwMC0weGZmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpb
ICAgIDMuMTUyODQ0XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAw
MGEwMDAwLTB4MDAwYmZmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMuMTUy
ODQ2XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGMwMDAwLTB4
MDAwYzNmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMuMTUyODQ4XSBwY2kg
MDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGM0MDAwLTB4MDAwYzdmZmYg
d2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMuMTUyODUwXSBwY2kgMDAwMDowMDox
NC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGM4MDAwLTB4MDAwY2JmZmYgd2luZG93XSAo
c3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMuMTUyODUyXSBwY2kgMDAwMDowMDoxNC40OiAgIGJy
aWRnZSB3aW5kb3cgW21lbSAweDAwMGQ0MDAwLTB4MDAwZDdmZmYgd2luZG93XSAoc3VidHJhY3Rp
dmUgZGVjb2RlKQpbICAgIDMuMTUyODU0XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5k
b3cgW21lbSAweDAwMGQ4MDAwLTB4MDAwZGJmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2Rl
KQpbICAgIDMuMTUyODU2XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAw
eDAwMGRjMDAwLTB4MDAwZGZmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMu
MTUyODU3XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGUwMDAw
LTB4MDAwZTNmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMuMTUyODU5XSBw
Y2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGU0MDAwLTB4MDAwZTdm
ZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMuMTUyODYxXSBwY2kgMDAwMDow
MDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGU4MDAwLTB4MDAwZWJmZmYgd2luZG93
XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMuMTUyODYzXSBwY2kgMDAwMDowMDoxNC40OiAg
IGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGVjMDAwLTB4MDAwZWZmZmYgd2luZG93XSAoc3VidHJh
Y3RpdmUgZGVjb2RlKQpbICAgIDMuMTUyODY0XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3
aW5kb3cgW21lbSAweDAwMGYwMDAwLTB4MDAwZmZmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVj
b2RlKQpbICAgIDMuMTUyODY2XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21l
bSAweGEwMDAwMDAwLTB4ZGZmZmZmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAg
IDMuMTUyODY4XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGYwMDAw
MDAwLTB4ZmVkM2ZmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMuMTUyODcw
XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGZlZDQ1MDAwLTB4ZmZm
ZGZmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDMuMTUyOTIyXSBhY3BpIFBO
UDBBMDg6MDA6IERpc2FibGluZyBBU1BNIChGQURUIGluZGljYXRlcyBpdCBpcyB1bnN1cHBvcnRl
ZCkKWyAgICAzLjE1NDUzNF0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktBXSAoSVJRcyAz
IDQgNSA3IDEwIDExIDEyIDE0IDE1KSAqMApbICAgIDMuMTU0NjQ0XSBBQ1BJOiBQQ0kgSW50ZXJy
dXB0IExpbmsgW0xOS0JdIChJUlFzIDMgNCA1IDcgMTAgMTEgMTIgMTQgMTUpICowClsgICAgMy4x
NTQ3NTZdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQ10gKElSUXMgMyA0IDUgNyAxMCAx
MSAxMiAxNCAxNSkgKjAKWyAgICAzLjE1NDg2NV0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtM
TktEXSAoSVJRcyAzIDQgNSA3IDEwIDExIDEyIDE0IDE1KSAqMApbICAgIDMuMTU0OTkzXSBBQ1BJ
OiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0VdIChJUlFzIDMgNCA1IDcgMTAgMTEgMTIgMTQgMTUp
ICowClsgICAgMy4xNTUwNTJdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LRl0gKElSUXMg
MyA0IDUgNyAxMCAxMSAxMiAxNCAxNSkgKjAKWyAgICAzLjE1NTExM10gQUNQSTogUENJIEludGVy
cnVwdCBMaW5rIFtMTktHXSAoSVJRcyAzIDQgNSA3IDEwIDExIDEyIDE0IDE1KSAqMApbICAgIDMu
MTU1MTc2XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0hdIChJUlFzIDMgNCA1IDcgMTAg
MTEgMTIgMTQgMTUpICowClsgICAgMy4xNTU0NTFdIEFDUEk6IEVuYWJsZWQgMiBHUEVzIGluIGJs
b2NrIDAwIHRvIDFGClsgICAgMy4xNTU1NjJdIEFDUEkgOiBFQzogR1BFID0gMHgzLCBJL086IGNv
bW1hbmQvc3RhdHVzID0gMHg2NiwgZGF0YSA9IDB4NjIKWyAgICAzLjE1NTc2NV0gdmdhYXJiOiBz
ZXR0aW5nIGFzIGJvb3QgZGV2aWNlOiBQQ0k6MDAwMDowMDowMS4wClsgICAgMy4xNTU3NjhdIHZn
YWFyYjogZGV2aWNlIGFkZGVkOiBQQ0k6MDAwMDowMDowMS4wLGRlY29kZXM9aW8rbWVtLG93bnM9
aW8rbWVtLGxvY2tzPW5vbmUKWyAgICAzLjE1NTc4MF0gdmdhYXJiOiBsb2FkZWQKWyAgICAzLjE1
NTc4Ml0gdmdhYXJiOiBicmlkZ2UgY29udHJvbCBwb3NzaWJsZSAwMDAwOjAwOjAxLjAKWyAgICAz
LjE1NjE0NF0gU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQKWyAgICAzLjE1NjQyOF0gbGliYXRh
IHZlcnNpb24gMy4wMCBsb2FkZWQuClsgICAgMy4xNTY1MTBdIEFDUEk6IGJ1cyB0eXBlIFVTQiBy
ZWdpc3RlcmVkClsgICAgMy4xNTY1NDJdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFj
ZSBkcml2ZXIgdXNiZnMKWyAgICAzLjE1NjU1OV0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50
ZXJmYWNlIGRyaXZlciBodWIKWyAgICAzLjE1NjYwMl0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcg
ZGV2aWNlIGRyaXZlciB1c2IKWyAgICAzLjE1NjgzNV0gUENJOiBVc2luZyBBQ1BJIGZvciBJUlEg
cm91dGluZwpbICAgIDMuMTY1OTQxXSBQQ0k6IHBjaV9jYWNoZV9saW5lX3NpemUgc2V0IHRvIDY0
IGJ5dGVzClsgICAgMy4xNjYwNDhdIEV4cGFuZGVkIHJlc291cmNlIHJlc2VydmVkIGR1ZSB0byBj
b25mbGljdCB3aXRoIFBDSSBCdXMgMDAwMDowMApbICAgIDMuMTY2MDUxXSBlODIwOiByZXNlcnZl
IFJBTSBidWZmZXIgW21lbSAweDAwMDllYzAwLTB4MDAwOWZmZmZdClsgICAgMy4xNjYwNTNdIGU4
MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4NWQ5YjYwMDAtMHg1ZmZmZmZmZl0KWyAgICAz
LjE2NjA1NV0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHg1ZjAwMDAwMC0weDVmZmZm
ZmZmXQpbICAgIDMuMTY2MDU3XSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweDI1ZjAw
MDAwMC0weDI1ZmZmZmZmZl0KWyAgICAzLjE2NjIzOF0gTmV0TGFiZWw6IEluaXRpYWxpemluZwpb
ICAgIDMuMTY2MjQwXSBOZXRMYWJlbDogIGRvbWFpbiBoYXNoIHNpemUgPSAxMjgKWyAgICAzLjE2
NjI0Ml0gTmV0TGFiZWw6ICBwcm90b2NvbHMgPSBVTkxBQkVMRUQgQ0lQU092NApbICAgIDMuMTY2
MjU5XSBOZXRMYWJlbDogIHVubGFiZWxlZCB0cmFmZmljIGFsbG93ZWQgYnkgZGVmYXVsdApbICAg
IDMuMTY2NDQ4XSBocGV0MDogYXQgTU1JTyAweGZlZDAwMDAwLCBJUlFzIDIsIDgsIDAKWyAgICAz
LjE2NjQ1NF0gaHBldDA6IDMgY29tcGFyYXRvcnMsIDMyLWJpdCAxNC4zMTgxODAgTUh6IGNvdW50
ZXIKWyAgICAzLjE2ODcxM10gU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2UgaHBldApbICAgIDMuMTc3
OTIxXSBBcHBBcm1vcjogQXBwQXJtb3IgRmlsZXN5c3RlbSBFbmFibGVkClsgICAgMy4xNzgwMTVd
IHBucDogUG5QIEFDUEkgaW5pdApbICAgIDMuMTc4MTcyXSBzeXN0ZW0gMDA6MDA6IFttZW0gMHhl
MDAwMDAwMC0weGVmZmZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDMuMTc4MTc1XSBzeXN0
ZW0gMDA6MDA6IFttZW0gMHhmZWIwMDAwMC0weGZlYjAwZmZmXSBoYXMgYmVlbiByZXNlcnZlZApb
ICAgIDMuMTc4MTc4XSBzeXN0ZW0gMDA6MDA6IFttZW0gMHhmZWMwMDAwMC0weGZlYzAwZmZmXSBj
b3VsZCBub3QgYmUgcmVzZXJ2ZWQKWyAgICAzLjE3ODE4MF0gc3lzdGVtIDAwOjAwOiBbbWVtIDB4
ZmVjMjAwMDAtMHhmZWMyMGZmZl0gY291bGQgbm90IGJlIHJlc2VydmVkClsgICAgMy4xNzgxODJd
IHN5c3RlbSAwMDowMDogW21lbSAweGZlZTAwMDAwLTB4ZmVlMDBmZmZdIGhhcyBiZWVuIHJlc2Vy
dmVkClsgICAgMy4xNzgxODZdIHN5c3RlbSAwMDowMDogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmlj
ZSwgSURzIFBOUDBjMDIgKGFjdGl2ZSkKWyAgICAzLjE3ODUwOV0gc3lzdGVtIDAwOjAxOiBbaW8g
IDB4MDQwMC0weDA0Y2ZdIGNvdWxkIG5vdCBiZSByZXNlcnZlZApbICAgIDMuMTc4NTEyXSBzeXN0
ZW0gMDA6MDE6IFtpbyAgMHgwNGQwLTB4MDRkMV0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAzLjE3
ODUxNF0gc3lzdGVtIDAwOjAxOiBbaW8gIDB4MDRkNl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAz
LjE3ODUxNl0gc3lzdGVtIDAwOjAxOiBbaW8gIDB4MDY4MC0weDA2ZmZdIGhhcyBiZWVuIHJlc2Vy
dmVkClsgICAgMy4xNzg1MThdIHN5c3RlbSAwMDowMTogW2lvICAweDA3N2FdIGhhcyBiZWVuIHJl
c2VydmVkClsgICAgMy4xNzg1MjBdIHN5c3RlbSAwMDowMTogW2lvICAweDBjMDAtMHgwYzAxXSBo
YXMgYmVlbiByZXNlcnZlZApbICAgIDMuMTc4NTIyXSBzeXN0ZW0gMDA6MDE6IFtpbyAgMHgwYzE0
XSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDMuMTc4NTI0XSBzeXN0ZW0gMDA6MDE6IFtpbyAgMHgw
YzUwLTB4MGM1Ml0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAzLjE3ODUyNl0gc3lzdGVtIDAwOjAx
OiBbaW8gIDB4MGM2Y10gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAzLjE3ODUyN10gc3lzdGVtIDAw
OjAxOiBbaW8gIDB4MGM2Zl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAzLjE3ODUyOV0gc3lzdGVt
IDAwOjAxOiBbaW8gIDB4MGNkMC0weDBjZGJdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMy4xNzg1
MzFdIHN5c3RlbSAwMDowMTogW2lvICAweDAyMjAtMHgwMjI3XSBoYXMgYmVlbiByZXNlcnZlZApb
ICAgIDMuMTc4NTMzXSBzeXN0ZW0gMDA6MDE6IFtpbyAgMHgwMjYwLTB4MDI3M10gaGFzIGJlZW4g
cmVzZXJ2ZWQKWyAgICAzLjE3ODUzNV0gc3lzdGVtIDAwOjAxOiBbaW8gIDB4MDgwMF0gaGFzIGJl
ZW4gcmVzZXJ2ZWQKWyAgICAzLjE3ODUzN10gc3lzdGVtIDAwOjAxOiBbaW8gIDB4MDgwNF0gaGFz
IGJlZW4gcmVzZXJ2ZWQKWyAgICAzLjE3ODUzOV0gc3lzdGVtIDAwOjAxOiBbaW8gIDB4MDg3Zl0g
aGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAzLjE3ODU0MV0gc3lzdGVtIDAwOjAxOiBbaW8gIDB4MGNk
Yy0weDBjZGZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMy4xNzg1NDNdIHN5c3RlbSAwMDowMTog
W2lvICAweDBiMDAtMHgwYjBmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDMuMTc4NTQ1XSBzeXN0
ZW0gMDA6MDE6IFtpbyAgMHgwMjAwLTB4MDI3Zl0gY291bGQgbm90IGJlIHJlc2VydmVkClsgICAg
My4xNzg1NDddIHN5c3RlbSAwMDowMTogW2lvICAweDE3NzAtMHgxNzc3XSBoYXMgYmVlbiByZXNl
cnZlZApbICAgIDMuMTc4NTUwXSBzeXN0ZW0gMDA6MDE6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZp
Y2UsIElEcyBQTlAwYzAyIChhY3RpdmUpClsgICAgMy4xNzg2MzVdIHN5c3RlbSAwMDowMjogW21l
bSAweDAwMDAwMDAwLTB4MDAwOWZmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZlZApbICAgIDMuMTc4
NjM4XSBzeXN0ZW0gMDA6MDI6IFttZW0gMHgwMDEwMDAwMC0weDlmZmZmZmZmXSBjb3VsZCBub3Qg
YmUgcmVzZXJ2ZWQKWyAgICAzLjE3ODY0MF0gc3lzdGVtIDAwOjAyOiBbbWVtIDB4ZmZlMDAwMDAt
MHhmZmZmZmZmZl0gY291bGQgbm90IGJlIHJlc2VydmVkClsgICAgMy4xNzg2NDNdIHN5c3RlbSAw
MDowMjogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBjMDEgKGFjdGl2ZSkKWyAg
ICAzLjE3ODc3Ml0gcG5wIDAwOjAzOiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJRHMgUE5Q
MGIwMCAoYWN0aXZlKQpbICAgIDMuMTc4ODU0XSBwbnAgMDA6MDQ6IFBsdWcgYW5kIFBsYXkgQUNQ
SSBkZXZpY2UsIElEcyBIUFE4MDAxIFBOUDAzMDMgKGFjdGl2ZSkKWyAgICAzLjE3ODg5M10gcG5w
IDAwOjA1OiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJRHMgU1lOMzAxYyBTWU4wMTAwIFNZ
TjAwMDIgUE5QMGYxMyAoYWN0aXZlKQpbICAgIDMuMTc5MzA5XSBwbnAgMDA6MDY6IFBsdWcgYW5k
IFBsYXkgQUNQSSBkZXZpY2UsIElEcyBJRlgwMTAyIFBOUDBjMzEgKGFjdGl2ZSkKWyAgICAzLjE3
OTU0OF0gcG5wOiBQblAgQUNQSTogZm91bmQgNyBkZXZpY2VzClsgICAgMy4xODczMzZdIHBjaSAw
MDAwOjAwOjAxLjA6IGNhbid0IGNsYWltIEJBUiA2IFttZW0gMHhmZmZlMDAwMC0weGZmZmZmZmZm
IHByZWZdOiBubyBjb21wYXRpYmxlIGJyaWRnZSB3aW5kb3cKWyAgICAzLjE4NzM0MF0gcGNpIDAw
MDA6MDE6MDAuMDogY2FuJ3QgY2xhaW0gQkFSIDYgW21lbSAweGZmZmUwMDAwLTB4ZmZmZmZmZmYg
cHJlZl06IG5vIGNvbXBhdGlibGUgYnJpZGdlIHdpbmRvdwpbICAgIDMuMTg3MzQzXSBwY2kgMDAw
MDowMzowMC4wOiBjYW4ndCBjbGFpbSBCQVIgNiBbbWVtIDB4ZmZmZjAwMDAtMHhmZmZmZmZmZiBw
cmVmXTogbm8gY29tcGF0aWJsZSBicmlkZ2Ugd2luZG93ClsgICAgMy4xODc0MTldIHBjaSAwMDAw
OjAwOjAxLjA6IEJBUiA2OiBhc3NpZ25lZCBbbWVtIDB4YjAyMDAwMDAtMHhiMDIxZmZmZiBwcmVm
XQpbICAgIDMuMTg3NDIzXSBwY2kgMDAwMDowMTowMC4wOiBCQVIgNjogYXNzaWduZWQgW21lbSAw
eGQ2ODQwMDAwLTB4ZDY4NWZmZmYgcHJlZl0KWyAgICAzLjE4NzQyNl0gcGNpIDAwMDA6MDA6MDIu
MTogUENJIGJyaWRnZSB0byBbYnVzIDAxXQpbICAgIDMuMTg3NDMwXSBwY2kgMDAwMDowMDowMi4x
OiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDUwMDAtMHg1ZmZmXQpbICAgIDMuMTg3NDM0XSBwY2kg
MDAwMDowMDowMi4xOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGQ2ODAwMDAwLTB4ZDY4ZmZmZmZd
ClsgICAgMy4xODc0MzhdIHBjaSAwMDAwOjAwOjAyLjE6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4
YTAwMDAwMDAtMHhiMDFmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDMuMTg3NDQzXSBwY2kgMDAwMDow
MDowMy4xOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDJdClsgICAgMy4xODc0NDZdIHBjaSAwMDAwOjAw
OjAzLjE6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4NDAwMC0weDRmZmZdClsgICAgMy4xODc0NTBd
IHBjaSAwMDAwOjAwOjAzLjE6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZDU4MDAwMDAtMHhkNjdm
ZmZmZl0KWyAgICAzLjE4NzQ1NF0gcGNpIDAwMDA6MDA6MDMuMTogICBicmlkZ2Ugd2luZG93IFtt
ZW0gMHhkMDgwMDAwMC0weGQxN2ZmZmZmIDY0Yml0IHByZWZdClsgICAgMy4xODc0NjBdIHBjaSAw
MDAwOjAzOjAwLjA6IEJBUiA2OiBhc3NpZ25lZCBbbWVtIDB4ZDQ4ODAwMDAtMHhkNDg4ZmZmZiBw
cmVmXQpbICAgIDMuMTg3NDYyXSBwY2kgMDAwMDowMDowMy4yOiBQQ0kgYnJpZGdlIHRvIFtidXMg
MDNdClsgICAgMy4xODc0NjRdIHBjaSAwMDAwOjAwOjAzLjI6ICAgYnJpZGdlIHdpbmRvdyBbaW8g
IDB4MzAwMC0weDNmZmZdClsgICAgMy4xODc0NjhdIHBjaSAwMDAwOjAwOjAzLjI6ICAgYnJpZGdl
IHdpbmRvdyBbbWVtIDB4ZDQ4MDAwMDAtMHhkNTdmZmZmZl0KWyAgICAzLjE4NzQ3Ml0gcGNpIDAw
MDA6MDA6MDMuMjogICBicmlkZ2Ugd2luZG93IFttZW0gMHhkMTgwMDAwMC0weGQyN2ZmZmZmIDY0
Yml0IHByZWZdClsgICAgMy4xODc0NzddIHBjaSAwMDAwOjAwOjAzLjQ6IFBDSSBicmlkZ2UgdG8g
W2J1cyAwNF0KWyAgICAzLjE4NzQ3OV0gcGNpIDAwMDA6MDA6MDMuNDogICBicmlkZ2Ugd2luZG93
IFtpbyAgMHgyMDAwLTB4MmZmZl0KWyAgICAzLjE4NzQ4M10gcGNpIDAwMDA6MDA6MDMuNDogICBi
cmlkZ2Ugd2luZG93IFttZW0gMHhkMzgwMDAwMC0weGQ0N2ZmZmZmXQpbICAgIDMuMTg3NDg3XSBw
Y2kgMDAwMDowMDowMy40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGQyODAwMDAwLTB4ZDM3ZmZm
ZmYgNjRiaXQgcHJlZl0KWyAgICAzLjE4NzQ5Ml0gcGNpIDAwMDA6MDA6MTQuNDogUENJIGJyaWRn
ZSB0byBbYnVzIDA1XQpbICAgIDMuMTg3NTM2XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDQg
W2lvICAweDAwMDAtMHgwY2Y3IHdpbmRvd10KWyAgICAzLjE4NzUzOF0gcGNpX2J1cyAwMDAwOjAw
OiByZXNvdXJjZSA1IFtpbyAgMHgwZDAwLTB4ZmZmZiB3aW5kb3ddClsgICAgMy4xODc1NDBdIHBj
aV9idXMgMDAwMDowMDogcmVzb3VyY2UgNiBbbWVtIDB4MDAwYTAwMDAtMHgwMDBiZmZmZiB3aW5k
b3ddClsgICAgMy4xODc1NDJdIHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgNyBbbWVtIDB4MDAw
YzAwMDAtMHgwMDBjM2ZmZiB3aW5kb3ddClsgICAgMy4xODc1NDNdIHBjaV9idXMgMDAwMDowMDog
cmVzb3VyY2UgOCBbbWVtIDB4MDAwYzQwMDAtMHgwMDBjN2ZmZiB3aW5kb3ddClsgICAgMy4xODc1
NDVdIHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgOSBbbWVtIDB4MDAwYzgwMDAtMHgwMDBjYmZm
ZiB3aW5kb3ddClsgICAgMy4xODc1NDddIHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgMTAgW21l
bSAweDAwMGQ0MDAwLTB4MDAwZDdmZmYgd2luZG93XQpbICAgIDMuMTg3NTQ5XSBwY2lfYnVzIDAw
MDA6MDA6IHJlc291cmNlIDExIFttZW0gMHgwMDBkODAwMC0weDAwMGRiZmZmIHdpbmRvd10KWyAg
ICAzLjE4NzU1MF0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSAxMiBbbWVtIDB4MDAwZGMwMDAt
MHgwMDBkZmZmZiB3aW5kb3ddClsgICAgMy4xODc1NTJdIHBjaV9idXMgMDAwMDowMDogcmVzb3Vy
Y2UgMTMgW21lbSAweDAwMGUwMDAwLTB4MDAwZTNmZmYgd2luZG93XQpbICAgIDMuMTg3NTU0XSBw
Y2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDE0IFttZW0gMHgwMDBlNDAwMC0weDAwMGU3ZmZmIHdp
bmRvd10KWyAgICAzLjE4NzU1NV0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSAxNSBbbWVtIDB4
MDAwZTgwMDAtMHgwMDBlYmZmZiB3aW5kb3ddClsgICAgMy4xODc1NTddIHBjaV9idXMgMDAwMDow
MDogcmVzb3VyY2UgMTYgW21lbSAweDAwMGVjMDAwLTB4MDAwZWZmZmYgd2luZG93XQpbICAgIDMu
MTg3NTU5XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDE3IFttZW0gMHgwMDBmMDAwMC0weDAw
MGZmZmZmIHdpbmRvd10KWyAgICAzLjE4NzU2MF0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSAx
OCBbbWVtIDB4YTAwMDAwMDAtMHhkZmZmZmZmZiB3aW5kb3ddClsgICAgMy4xODc1NjJdIHBjaV9i
dXMgMDAwMDowMDogcmVzb3VyY2UgMTkgW21lbSAweGYwMDAwMDAwLTB4ZmVkM2ZmZmYgd2luZG93
XQpbICAgIDMuMTg3NTY0XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDIwIFttZW0gMHhmZWQ0
NTAwMC0weGZmZmRmZmZmIHdpbmRvd10KWyAgICAzLjE4NzU2Nl0gcGNpX2J1cyAwMDAwOjAxOiBy
ZXNvdXJjZSAwIFtpbyAgMHg1MDAwLTB4NWZmZl0KWyAgICAzLjE4NzU2N10gcGNpX2J1cyAwMDAw
OjAxOiByZXNvdXJjZSAxIFttZW0gMHhkNjgwMDAwMC0weGQ2OGZmZmZmXQpbICAgIDMuMTg3NTY5
XSBwY2lfYnVzIDAwMDA6MDE6IHJlc291cmNlIDIgW21lbSAweGEwMDAwMDAwLTB4YjAxZmZmZmYg
NjRiaXQgcHJlZl0KWyAgICAzLjE4NzU3MV0gcGNpX2J1cyAwMDAwOjAyOiByZXNvdXJjZSAwIFtp
byAgMHg0MDAwLTB4NGZmZl0KWyAgICAzLjE4NzU3M10gcGNpX2J1cyAwMDAwOjAyOiByZXNvdXJj
ZSAxIFttZW0gMHhkNTgwMDAwMC0weGQ2N2ZmZmZmXQpbICAgIDMuMTg3NTc0XSBwY2lfYnVzIDAw
MDA6MDI6IHJlc291cmNlIDIgW21lbSAweGQwODAwMDAwLTB4ZDE3ZmZmZmYgNjRiaXQgcHJlZl0K
WyAgICAzLjE4NzU3Nl0gcGNpX2J1cyAwMDAwOjAzOiByZXNvdXJjZSAwIFtpbyAgMHgzMDAwLTB4
M2ZmZl0KWyAgICAzLjE4NzU3OF0gcGNpX2J1cyAwMDAwOjAzOiByZXNvdXJjZSAxIFttZW0gMHhk
NDgwMDAwMC0weGQ1N2ZmZmZmXQpbICAgIDMuMTg3NTgwXSBwY2lfYnVzIDAwMDA6MDM6IHJlc291
cmNlIDIgW21lbSAweGQxODAwMDAwLTB4ZDI3ZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAzLjE4NzU4
MV0gcGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSAwIFtpbyAgMHgyMDAwLTB4MmZmZl0KWyAgICAz
LjE4NzU4M10gcGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSAxIFttZW0gMHhkMzgwMDAwMC0weGQ0
N2ZmZmZmXQpbICAgIDMuMTg3NTg1XSBwY2lfYnVzIDAwMDA6MDQ6IHJlc291cmNlIDIgW21lbSAw
eGQyODAwMDAwLTB4ZDM3ZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAzLjE4NzU4N10gcGNpX2J1cyAw
MDAwOjA1OiByZXNvdXJjZSA0IFtpbyAgMHgwMDAwLTB4MGNmNyB3aW5kb3ddClsgICAgMy4xODc1
ODldIHBjaV9idXMgMDAwMDowNTogcmVzb3VyY2UgNSBbaW8gIDB4MGQwMC0weGZmZmYgd2luZG93
XQpbICAgIDMuMTg3NTkwXSBwY2lfYnVzIDAwMDA6MDU6IHJlc291cmNlIDYgW21lbSAweDAwMGEw
MDAwLTB4MDAwYmZmZmYgd2luZG93XQpbICAgIDMuMTg3NTkyXSBwY2lfYnVzIDAwMDA6MDU6IHJl
c291cmNlIDcgW21lbSAweDAwMGMwMDAwLTB4MDAwYzNmZmYgd2luZG93XQpbICAgIDMuMTg3NTk0
XSBwY2lfYnVzIDAwMDA6MDU6IHJlc291cmNlIDggW21lbSAweDAwMGM0MDAwLTB4MDAwYzdmZmYg
d2luZG93XQpbICAgIDMuMTg3NTk2XSBwY2lfYnVzIDAwMDA6MDU6IHJlc291cmNlIDkgW21lbSAw
eDAwMGM4MDAwLTB4MDAwY2JmZmYgd2luZG93XQpbICAgIDMuMTg3NTk3XSBwY2lfYnVzIDAwMDA6
MDU6IHJlc291cmNlIDEwIFttZW0gMHgwMDBkNDAwMC0weDAwMGQ3ZmZmIHdpbmRvd10KWyAgICAz
LjE4NzU5OV0gcGNpX2J1cyAwMDAwOjA1OiByZXNvdXJjZSAxMSBbbWVtIDB4MDAwZDgwMDAtMHgw
MDBkYmZmZiB3aW5kb3ddClsgICAgMy4xODc2MDFdIHBjaV9idXMgMDAwMDowNTogcmVzb3VyY2Ug
MTIgW21lbSAweDAwMGRjMDAwLTB4MDAwZGZmZmYgd2luZG93XQpbICAgIDMuMTg3NjAyXSBwY2lf
YnVzIDAwMDA6MDU6IHJlc291cmNlIDEzIFttZW0gMHgwMDBlMDAwMC0weDAwMGUzZmZmIHdpbmRv
d10KWyAgICAzLjE4NzYwNF0gcGNpX2J1cyAwMDAwOjA1OiByZXNvdXJjZSAxNCBbbWVtIDB4MDAw
ZTQwMDAtMHgwMDBlN2ZmZiB3aW5kb3ddClsgICAgMy4xODc2MDZdIHBjaV9idXMgMDAwMDowNTog
cmVzb3VyY2UgMTUgW21lbSAweDAwMGU4MDAwLTB4MDAwZWJmZmYgd2luZG93XQpbICAgIDMuMTg3
NjA3XSBwY2lfYnVzIDAwMDA6MDU6IHJlc291cmNlIDE2IFttZW0gMHgwMDBlYzAwMC0weDAwMGVm
ZmZmIHdpbmRvd10KWyAgICAzLjE4NzYwOV0gcGNpX2J1cyAwMDAwOjA1OiByZXNvdXJjZSAxNyBb
bWVtIDB4MDAwZjAwMDAtMHgwMDBmZmZmZiB3aW5kb3ddClsgICAgMy4xODc2MTFdIHBjaV9idXMg
MDAwMDowNTogcmVzb3VyY2UgMTggW21lbSAweGEwMDAwMDAwLTB4ZGZmZmZmZmYgd2luZG93XQpb
ICAgIDMuMTg3NjEzXSBwY2lfYnVzIDAwMDA6MDU6IHJlc291cmNlIDE5IFttZW0gMHhmMDAwMDAw
MC0weGZlZDNmZmZmIHdpbmRvd10KWyAgICAzLjE4NzYxNF0gcGNpX2J1cyAwMDAwOjA1OiByZXNv
dXJjZSAyMCBbbWVtIDB4ZmVkNDUwMDAtMHhmZmZkZmZmZiB3aW5kb3ddClsgICAgMy4xODc2NTVd
IE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMgpbICAgIDMuMTg3OTE3XSBUQ1AgZXN0
YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDcsIDUyNDI4OCBieXRl
cykKWyAgICAzLjE4ODE5N10gVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3Jk
ZXI6IDgsIDEwNDg1NzYgYnl0ZXMpClsgICAgMy4xODg0NzNdIFRDUDogSGFzaCB0YWJsZXMgY29u
ZmlndXJlZCAoZXN0YWJsaXNoZWQgNjU1MzYgYmluZCA2NTUzNikKWyAgICAzLjE4ODUxM10gVENQ
OiByZW5vIHJlZ2lzdGVyZWQKWyAgICAzLjE4ODUzM10gVURQIGhhc2ggdGFibGUgZW50cmllczog
NDA5NiAob3JkZXI6IDUsIDEzMTA3MiBieXRlcykKWyAgICAzLjE4ODU4M10gVURQLUxpdGUgaGFz
aCB0YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogNSwgMTMxMDcyIGJ5dGVzKQpbICAgIDMuMTg4
NjkyXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEKWyAgICAzLjE4ODgwMF0gcGNp
IDAwMDA6MDA6MDEuMDogVmlkZW8gZGV2aWNlIHdpdGggc2hhZG93ZWQgUk9NClsgICAgMy4zMDE3
NjFdIFBDSTogQ0xTIG1pc21hdGNoICg2NCAhPSAzMiksIHVzaW5nIDY0IGJ5dGVzClsgICAgMy4z
NTczMzldIFRyeWluZyB0byB1bnBhY2sgcm9vdGZzIGltYWdlIGFzIGluaXRyYW1mcy4uLgpbICAg
IDMuOTAzMTYwXSBGcmVlaW5nIGluaXRyZCBtZW1vcnk6IDMzMDkySyAoZmZmZjg4MDAzM2Y0ZTAw
MCAtIGZmZmY4ODAwMzVmOWYwMDApClsgICAgMy45MDMxOTFdIEFNRC1WaTogSU9NTVUgcGVyZm9y
bWFuY2UgY291bnRlcnMgc3VwcG9ydGVkClsgICAgMy45MDM0OThdIHBjaSAwMDAwOjAwOjAwLjI6
IGNhbid0IGRlcml2ZSByb3V0aW5nIGZvciBQQ0kgSU5UIEEKWyAgICAzLjkwMzUwMV0gcGNpIDAw
MDA6MDA6MDAuMjogUENJIElOVCBBOiBubyBHU0kKWyAgICAzLjkwNDQ0Ml0gQU1ELVZpOiBGb3Vu
ZCBJT01NVSBhdCAwMDAwOjAwOjAwLjIgY2FwIDB4NDAKWyAgICAzLjkwNDQ0M10gQU1ELVZpOiAg
RXh0ZW5kZWQgZmVhdHVyZXM6ICBQUFIgR1QgSUEgUEMKWyAgICAzLjkwNDQ0OF0gQU1ELVZpOiBJ
bnRlcnJ1cHQgcmVtYXBwaW5nIGVuYWJsZWQKWyAgICAzLjkwNTg3Ml0gQU1ELVZpOiBVc2luZyBw
YXNzdGhyb3VnaCBkb21haW4gZm9yIGRldmljZSAwMDAwOjAwOjAxLjAKWyAgICAzLjkxODc5OF0g
QU1ELVZpOiBVc2luZyBwYXNzdGhyb3VnaCBkb21haW4gZm9yIGRldmljZSAwMDAwOjAxOjAwLjAK
WyAgICAzLjkyMDUzM10gQU1ELVZpOiBMYXp5IElPL1RMQiBmbHVzaGluZyBlbmFibGVkClsgICAg
My45MjExNTVdIFBDSS1ETUE6IFVzaW5nIHNvZnR3YXJlIGJvdW5jZSBidWZmZXJpbmcgZm9yIElP
IChTV0lPVExCKQpbICAgIDMuOTIxMTU5XSBzb2Z0d2FyZSBJTyBUTEIgW21lbSAweDU5OWI2MDAw
LTB4NWQ5YjYwMDBdICg2NE1CKSBtYXBwZWQgYXQgW2ZmZmY4ODAwNTk5YjYwMDAtZmZmZjg4MDA1
ZDliNWZmZl0KWyAgICAzLjkyMTY1N10gcGVyZjogYW1kX2lvbW11OiBEZXRlY3RlZC4gKDIgYmFu
a3MsIDQgY291bnRlcnMvYmFuaykKWyAgICAzLjkyMTc1N10gbWljcm9jb2RlOiBDUFUwOiBwYXRj
aF9sZXZlbD0weDA2MDAzMTA2ClsgICAgMy45MjE3NjNdIG1pY3JvY29kZTogQ1BVMTogcGF0Y2hf
bGV2ZWw9MHgwNjAwMzEwNgpbICAgIDMuOTIxNzc2XSBtaWNyb2NvZGU6IENQVTI6IHBhdGNoX2xl
dmVsPTB4MDYwMDMxMDYKWyAgICAzLjkyMTc5MF0gbWljcm9jb2RlOiBDUFUzOiBwYXRjaF9sZXZl
bD0weDA2MDAzMTA2ClsgICAgMy45MjE5MDRdIG1pY3JvY29kZTogTWljcm9jb2RlIFVwZGF0ZSBE
cml2ZXI6IHYyLjAwIDx0aWdyYW5AYWl2YXppYW4uZnNuZXQuY28udWs+LCBQZXRlciBPcnViYQpb
ICAgIDMuOTIxOTEwXSBMVlQgb2Zmc2V0IDAgYXNzaWduZWQgZm9yIHZlY3RvciAweDQwMApbICAg
IDMuOTIxOTI4XSBwZXJmOiBBTUQgSUJTIGRldGVjdGVkICgweDAwMDAwMWZmKQpbICAgIDMuOTIx
OTYxXSBTY2FubmluZyBmb3IgbG93IG1lbW9yeSBjb3JydXB0aW9uIGV2ZXJ5IDYwIHNlY29uZHMK
WyAgICAzLjkyMjUxNl0gZnV0ZXggaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRlcjogNCwg
NjU1MzYgYnl0ZXMpClsgICAgMy45MjI1NDFdIEluaXRpYWxpc2Ugc3lzdGVtIHRydXN0ZWQga2V5
cmluZwpbICAgIDMuOTIyNTY3XSBhdWRpdDogaW5pdGlhbGl6aW5nIG5ldGxpbmsgc3Vic3lzIChk
aXNhYmxlZCkKWyAgICAzLjkyMjU5OV0gYXVkaXQ6IHR5cGU9MjAwMCBhdWRpdCgxNDI3NDE3MDAy
LjU4NDoxKTogaW5pdGlhbGl6ZWQKWyAgICAzLjkyMzI5OF0gSHVnZVRMQiByZWdpc3RlcmVkIDEg
R0IgcGFnZSBzaXplLCBwcmUtYWxsb2NhdGVkIDAgcGFnZXMKWyAgICAzLjkyMzMwMF0gSHVnZVRM
QiByZWdpc3RlcmVkIDIgTUIgcGFnZSBzaXplLCBwcmUtYWxsb2NhdGVkIDAgcGFnZXMKWyAgICAz
LjkyNTg4NV0genBvb2w6IGxvYWRlZApbICAgIDMuOTI1ODg4XSB6YnVkOiBsb2FkZWQKWyAgICAz
LjkyNjMxN10gVkZTOiBEaXNrIHF1b3RhcyBkcXVvdF82LjUuMgpbICAgIDMuOTI2MzY5XSBWRlM6
IERxdW90LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTEyIChvcmRlciAwLCA0MDk2IGJ5dGVz
KQpbICAgIDMuOTI3MzQ3XSBmdXNlIGluaXQgKEFQSSB2ZXJzaW9uIDcuMjMpClsgICAgMy45Mjc1
ODFdIEtleSB0eXBlIGJpZ19rZXkgcmVnaXN0ZXJlZApbICAgIDMuOTI4MTQ0XSBLZXkgdHlwZSBh
c3ltbWV0cmljIHJlZ2lzdGVyZWQKWyAgICAzLjkyODE0OF0gQXN5bW1ldHJpYyBrZXkgcGFyc2Vy
ICd4NTA5JyByZWdpc3RlcmVkClsgICAgMy45MjgyMDJdIEJsb2NrIGxheWVyIFNDU0kgZ2VuZXJp
YyAoYnNnKSBkcml2ZXIgdmVyc2lvbiAwLjQgbG9hZGVkIChtYWpvciAyNTEpClsgICAgMy45Mjgy
ODddIGlvIHNjaGVkdWxlciBub29wIHJlZ2lzdGVyZWQKWyAgICAzLjkyODI5MV0gaW8gc2NoZWR1
bGVyIGRlYWRsaW5lIHJlZ2lzdGVyZWQgKGRlZmF1bHQpClsgICAgMy45MjgzMzldIGlvIHNjaGVk
dWxlciBjZnEgcmVnaXN0ZXJlZApbICAgIDMuOTI5ODU1XSBwY2llcG9ydCAwMDAwOjAwOjAyLjE6
IFNpZ25hbGluZyBQTUUgdGhyb3VnaCBQQ0llIFBNRSBpbnRlcnJ1cHQKWyAgICAzLjkyOTg1OF0g
cGNpIDAwMDA6MDE6MDAuMDogU2lnbmFsaW5nIFBNRSB0aHJvdWdoIFBDSWUgUE1FIGludGVycnVw
dApbICAgIDMuOTI5ODYzXSBwY2llX3BtZSAwMDAwOjAwOjAyLjE6cGNpZTAxOiBzZXJ2aWNlIGRy
aXZlciBwY2llX3BtZSBsb2FkZWQKWyAgICAzLjkyOTg4Ml0gcGNpZXBvcnQgMDAwMDowMDowMy4x
OiBTaWduYWxpbmcgUE1FIHRocm91Z2ggUENJZSBQTUUgaW50ZXJydXB0ClsgICAgMy45Mjk4ODVd
IHBjaSAwMDAwOjAyOjAwLjA6IFNpZ25hbGluZyBQTUUgdGhyb3VnaCBQQ0llIFBNRSBpbnRlcnJ1
cHQKWyAgICAzLjkyOTg4OV0gcGNpZV9wbWUgMDAwMDowMDowMy4xOnBjaWUwMTogc2VydmljZSBk
cml2ZXIgcGNpZV9wbWUgbG9hZGVkClsgICAgMy45Mjk5MDddIHBjaWVwb3J0IDAwMDA6MDA6MDMu
MjogU2lnbmFsaW5nIFBNRSB0aHJvdWdoIFBDSWUgUE1FIGludGVycnVwdApbICAgIDMuOTI5OTEw
XSBwY2kgMDAwMDowMzowMC4wOiBTaWduYWxpbmcgUE1FIHRocm91Z2ggUENJZSBQTUUgaW50ZXJy
dXB0ClsgICAgMy45Mjk5MTNdIHBjaWVfcG1lIDAwMDA6MDA6MDMuMjpwY2llMDE6IHNlcnZpY2Ug
ZHJpdmVyIHBjaWVfcG1lIGxvYWRlZApbICAgIDMuOTI5OTM2XSBwY2llcG9ydCAwMDAwOjAwOjAz
LjQ6IFNpZ25hbGluZyBQTUUgdGhyb3VnaCBQQ0llIFBNRSBpbnRlcnJ1cHQKWyAgICAzLjkyOTkz
OF0gcGNpIDAwMDA6MDQ6MDAuMDogU2lnbmFsaW5nIFBNRSB0aHJvdWdoIFBDSWUgUE1FIGludGVy
cnVwdApbICAgIDMuOTI5OTQyXSBwY2llX3BtZSAwMDAwOjAwOjAzLjQ6cGNpZTAxOiBzZXJ2aWNl
IGRyaXZlciBwY2llX3BtZSBsb2FkZWQKWyAgICAzLjkyOTk1MF0gcGNpX2hvdHBsdWc6IFBDSSBI
b3QgUGx1ZyBQQ0kgQ29yZSB2ZXJzaW9uOiAwLjUKWyAgICAzLjkzMDA5MV0gcGNpZWhwIDAwMDA6
MDA6MDIuMTpwY2llMDQ6IFNsb3QgIzAgQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5kLSBQd3JDdHJs
LSBNUkwtIEludGVybG9jay0gTm9Db21wbCsgTExBY3RSZXArClsgICAgMy45MzAxNjZdIHBjaWVo
cCAwMDAwOjAwOjAyLjE6cGNpZTA0OiBzZXJ2aWNlIGRyaXZlciBwY2llaHAgbG9hZGVkClsgICAg
My45MzAxNzZdIHBjaWVocCAwMDAwOjAwOjAzLjI6cGNpZTA0OiBTbG90ICMwIEF0dG5CdG4tIEF0
dG5JbmQtIFB3ckluZC0gUHdyQ3RybC0gTVJMLSBJbnRlcmxvY2stIE5vQ29tcGwrIExMQWN0UmVw
KwpbICAgIDMuOTMwMjA1XSBwY2llaHAgMDAwMDowMDowMy4yOnBjaWUwNDogc2VydmljZSBkcml2
ZXIgcGNpZWhwIGxvYWRlZApbICAgIDMuOTMwMjE2XSBwY2llaHAgMDAwMDowMDowMy40OnBjaWUw
NDogU2xvdCAjMCBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFB3ckN0cmwtIE1STC0gSW50ZXJs
b2NrLSBOb0NvbXBsKyBMTEFjdFJlcCsKWyAgICAzLjkzMDI0NV0gcGNpZWhwIDAwMDA6MDA6MDMu
NDpwY2llMDQ6IHNlcnZpY2UgZHJpdmVyIHBjaWVocCBsb2FkZWQKWyAgICAzLjkzMDI1Ml0gcGNp
ZWhwOiBQQ0kgRXhwcmVzcyBIb3QgUGx1ZyBDb250cm9sbGVyIERyaXZlciB2ZXJzaW9uOiAwLjQK
WyAgICAzLjkzMDk2M10gQUNQSTogQUMgQWRhcHRlciBbQUNdIChvbi1saW5lKQpbICAgIDMuOTMx
NTAyXSBpbnB1dDogU2xlZXAgQnV0dG9uIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVT
OjAwL1BOUDBDMEU6MDAvaW5wdXQvaW5wdXQwClsgICAgMy45MzE1MDddIEFDUEk6IFNsZWVwIEJ1
dHRvbiBbU0xQQl0KWyAgICAzLjkzMTU1N10gaW5wdXQ6IExpZCBTd2l0Y2ggYXMgL2RldmljZXMv
TE5YU1lTVE06MDAvTE5YU1lCVVM6MDAvUE5QMEMwRDowMC9pbnB1dC9pbnB1dDEKWyAgICAzLjkz
MTY0M10gQUNQSTogTGlkIFN3aXRjaCBbTElEXQpbICAgIDMuOTMxNjkyXSBpbnB1dDogUG93ZXIg
QnV0dG9uIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFBXUkJOOjAwL2lucHV0L2lucHV0Mgpb
ICAgIDMuOTMxNjk0XSBBQ1BJOiBQb3dlciBCdXR0b24gW1BXUkZdClsgICAgMy45MzE4MTJdIEFD
UEk6IGFjcGlfaWRsZSByZWdpc3RlcmVkIHdpdGggY3B1aWRsZQpbICAgIDMuOTc1NzY3XSB0aGVy
bWFsIExOWFRIRVJNOjAwOiByZWdpc3RlcmVkIGFzIHRoZXJtYWxfem9uZTAKWyAgICAzLjk3NTc3
M10gQUNQSTogVGhlcm1hbCBab25lIFtDUFVaXSAoNTAgQykKWyAgICA0LjAxNDgxOF0gdGhlcm1h
bCBMTlhUSEVSTTowMTogcmVnaXN0ZXJlZCBhcyB0aGVybWFsX3pvbmUxClsgICAgNC4wMTQ4MjRd
IEFDUEk6IFRoZXJtYWwgWm9uZSBbR0ZYWl0gKDAgQykKWyAgICA0LjAzNjA4NV0gdGhlcm1hbCBM
TlhUSEVSTTowMjogcmVnaXN0ZXJlZCBhcyB0aGVybWFsX3pvbmUyClsgICAgNC4wMzYwOTJdIEFD
UEk6IFRoZXJtYWwgWm9uZSBbRVhUWl0gKDAgQykKWyAgICA0LjA1ODM0OV0gdGhlcm1hbCBMTlhU
SEVSTTowMzogcmVnaXN0ZXJlZCBhcyB0aGVybWFsX3pvbmUzClsgICAgNC4wNTgzNTRdIEFDUEk6
IFRoZXJtYWwgWm9uZSBbTE9DWl0gKDAgQykKWyAgICA0LjA4NTI2OV0gdGhlcm1hbCBMTlhUSEVS
TTowNDogcmVnaXN0ZXJlZCBhcyB0aGVybWFsX3pvbmU0ClsgICAgNC4wODUyNzVdIEFDUEk6IFRo
ZXJtYWwgWm9uZSBbQkFUWl0gKDIyIEMpClsgICAgNC4wODUzODddIEdIRVM6IEhFU1QgaXMgbm90
IGVuYWJsZWQhClsgICAgNC4wODU2MDZdIFNlcmlhbDogODI1MC8xNjU1MCBkcml2ZXIsIDMyIHBv
cnRzLCBJUlEgc2hhcmluZyBlbmFibGVkClsgICAgNC4wODgzMTVdIExpbnV4IGFncGdhcnQgaW50
ZXJmYWNlIHYwLjEwMwpbICAgIDQuMTE1ODg1XSBBQ1BJOiBCYXR0ZXJ5IFNsb3QgW0JBVDBdIChi
YXR0ZXJ5IHByZXNlbnQpClsgICAgNC4xNDUwODVdIHRwbV90aXMgMDA6MDY6IDEuMiBUUE0gKGRl
dmljZS1pZCAweDFBLCByZXYtaWQgMTYpClsgICAgNC40NjI4MjJdIGJyZDogbW9kdWxlIGxvYWRl
ZApbICAgIDQuNDY0NjU5XSBsb29wOiBtb2R1bGUgbG9hZGVkClsgICAgNC40NjUwNjhdIGxpYnBo
eTogRml4ZWQgTURJTyBCdXM6IHByb2JlZApbICAgIDQuNDY1MDcyXSB0dW46IFVuaXZlcnNhbCBU
VU4vVEFQIGRldmljZSBkcml2ZXIsIDEuNgpbICAgIDQuNDY1MDc0XSB0dW46IChDKSAxOTk5LTIw
MDQgTWF4IEtyYXNueWFuc2t5IDxtYXhrQHF1YWxjb21tLmNvbT4KWyAgICA0LjQ2NTIxMl0gUFBQ
IGdlbmVyaWMgZHJpdmVyIHZlcnNpb24gMi40LjIKWyAgICA0LjQ2NTczMF0gUVVJUks6IEVuYWJs
ZSBBTUQgUExMIGZpeApbICAgIDQuNDY1NzYxXSB4aGNpX2hjZCAwMDAwOjAwOjEwLjA6IHhIQ0kg
SG9zdCBDb250cm9sbGVyClsgICAgNC40NjU3NzBdIHhoY2lfaGNkIDAwMDA6MDA6MTAuMDogbmV3
IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAxClsgICAgNC40NjU5OTFd
IHhoY2lfaGNkIDAwMDA6MDA6MTAuMDogaGNjIHBhcmFtcyAweDAxNDA0MGMzIGhjaSB2ZXJzaW9u
IDB4MTAwIHF1aXJrcyAweDAwMDAwNDE4ClsgICAgNC40NjYyMDhdIHVzYiB1c2IxOiBOZXcgVVNC
IGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2YiwgaWRQcm9kdWN0PTAwMDIKWyAgICA0LjQ2NjIx
MV0gdXNiIHVzYjE6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0zLCBQcm9kdWN0PTIsIFNl
cmlhbE51bWJlcj0xClsgICAgNC40NjYyMTNdIHVzYiB1c2IxOiBQcm9kdWN0OiB4SENJIEhvc3Qg
Q29udHJvbGxlcgpbICAgIDQuNDY2MjE2XSB1c2IgdXNiMTogTWFudWZhY3R1cmVyOiBMaW51eCA0
LjAuMC0wNDAwMDByYzUtZ2VuZXJpYyB4aGNpLWhjZApbICAgIDQuNDY2MjE4XSB1c2IgdXNiMTog
U2VyaWFsTnVtYmVyOiAwMDAwOjAwOjEwLjAKWyAgICA0LjQ2NjU5NV0gaHViIDEtMDoxLjA6IFVT
QiBodWIgZm91bmQKWyAgICA0LjQ2NjYzN10gaHViIDEtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQK
WyAgICA0LjQ2Njk2NF0geGhjaV9oY2QgMDAwMDowMDoxMC4wOiB4SENJIEhvc3QgQ29udHJvbGxl
cgpbICAgIDQuNDY2OTY4XSB4aGNpX2hjZCAwMDAwOjAwOjEwLjA6IG5ldyBVU0IgYnVzIHJlZ2lz
dGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMgpbICAgIDQuNDY5NDEwXSB1c2IgdXNiMjogTmV3
IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVjdD0wMDAzClsgICAgNC40
Njk0MTNdIHVzYiB1c2IyOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MywgUHJvZHVjdD0y
LCBTZXJpYWxOdW1iZXI9MQpbICAgIDQuNDY5NDE1XSB1c2IgdXNiMjogUHJvZHVjdDogeEhDSSBI
b3N0IENvbnRyb2xsZXIKWyAgICA0LjQ2OTQxN10gdXNiIHVzYjI6IE1hbnVmYWN0dXJlcjogTGlu
dXggNC4wLjAtMDQwMDAwcmM1LWdlbmVyaWMgeGhjaS1oY2QKWyAgICA0LjQ2OTQxOV0gdXNiIHVz
YjI6IFNlcmlhbE51bWJlcjogMDAwMDowMDoxMC4wClsgICAgNC40Njk2NThdIGh1YiAyLTA6MS4w
OiBVU0IgaHViIGZvdW5kClsgICAgNC40Njk2OTldIGh1YiAyLTA6MS4wOiAyIHBvcnRzIGRldGVj
dGVkClsgICAgNC40Njk5ODRdIGVoY2lfaGNkOiBVU0IgMi4wICdFbmhhbmNlZCcgSG9zdCBDb250
cm9sbGVyIChFSENJKSBEcml2ZXIKWyAgICA0LjQ2OTk5Ml0gZWhjaS1wY2k6IEVIQ0kgUENJIHBs
YXRmb3JtIGRyaXZlcgpbICAgIDQuNDcwMzQyXSBlaGNpLXBjaSAwMDAwOjAwOjEyLjI6IEVIQ0kg
SG9zdCBDb250cm9sbGVyClsgICAgNC40NzAzNDhdIGVoY2ktcGNpIDAwMDA6MDA6MTIuMjogbmV3
IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAzClsgICAgNC40NzAzNTNd
IGVoY2ktcGNpIDAwMDA6MDA6MTIuMjogYXBwbHlpbmcgQU1EIFNCNzAwL1NCODAwL0h1ZHNvbi0y
LzMgRUhDSSBkdW1teSBxaCB3b3JrYXJvdW5kClsgICAgNC40NzAzNjVdIGVoY2ktcGNpIDAwMDA6
MDA6MTIuMjogZGVidWcgcG9ydCAxClsgICAgNC40NzA0MDhdIGVoY2ktcGNpIDAwMDA6MDA6MTIu
MjogaXJxIDE3LCBpbyBtZW0gMHhkNjk0ZDAwMApbICAgIDQuNDgxMDU2XSBlaGNpLXBjaSAwMDAw
OjAwOjEyLjI6IFVTQiAyLjAgc3RhcnRlZCwgRUhDSSAxLjAwClsgICAgNC40ODExNTRdIHVzYiB1
c2IzOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2YiwgaWRQcm9kdWN0PTAwMDIK
WyAgICA0LjQ4MTE1N10gdXNiIHVzYjM6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0zLCBQ
cm9kdWN0PTIsIFNlcmlhbE51bWJlcj0xClsgICAgNC40ODExNjBdIHVzYiB1c2IzOiBQcm9kdWN0
OiBFSENJIEhvc3QgQ29udHJvbGxlcgpbICAgIDQuNDgxMTYxXSB1c2IgdXNiMzogTWFudWZhY3R1
cmVyOiBMaW51eCA0LjAuMC0wNDAwMDByYzUtZ2VuZXJpYyBlaGNpX2hjZApbICAgIDQuNDgxMTYz
XSB1c2IgdXNiMzogU2VyaWFsTnVtYmVyOiAwMDAwOjAwOjEyLjIKWyAgICA0LjQ4MTU1NV0gaHVi
IDMtMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgICA0LjQ4MTU2NF0gaHViIDMtMDoxLjA6IDUgcG9y
dHMgZGV0ZWN0ZWQKWyAgICA0LjQ4MjM0M10gZWhjaS1wY2kgMDAwMDowMDoxMy4yOiBFSENJIEhv
c3QgQ29udHJvbGxlcgpbICAgIDQuNDgyMzUzXSBlaGNpLXBjaSAwMDAwOjAwOjEzLjI6IG5ldyBV
U0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgNApbICAgIDQuNDgyMzYwXSBl
aGNpLXBjaSAwMDAwOjAwOjEzLjI6IGFwcGx5aW5nIEFNRCBTQjcwMC9TQjgwMC9IdWRzb24tMi8z
IEVIQ0kgZHVtbXkgcWggd29ya2Fyb3VuZApbICAgIDQuNDgyMzc1XSBlaGNpLXBjaSAwMDAwOjAw
OjEzLjI6IGRlYnVnIHBvcnQgMQpbICAgIDQuNDgyNDM1XSBlaGNpLXBjaSAwMDAwOjAwOjEzLjI6
IGlycSAxNywgaW8gbWVtIDB4ZDY5NGIwMDAKWyAgICA0LjQ5MzA2NF0gZWhjaS1wY2kgMDAwMDow
MDoxMy4yOiBVU0IgMi4wIHN0YXJ0ZWQsIEVIQ0kgMS4wMApbICAgIDQuNDkzMTQyXSB1c2IgdXNi
NDogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVjdD0wMDAyClsg
ICAgNC40OTMxNDVdIHVzYiB1c2I0OiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MywgUHJv
ZHVjdD0yLCBTZXJpYWxOdW1iZXI9MQpbICAgIDQuNDkzMTQ3XSB1c2IgdXNiNDogUHJvZHVjdDog
RUhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICA0LjQ5MzE0OV0gdXNiIHVzYjQ6IE1hbnVmYWN0dXJl
cjogTGludXggNC4wLjAtMDQwMDAwcmM1LWdlbmVyaWMgZWhjaV9oY2QKWyAgICA0LjQ5MzE1MV0g
dXNiIHVzYjQ6IFNlcmlhbE51bWJlcjogMDAwMDowMDoxMy4yClsgICAgNC40OTM1MjFdIGh1YiA0
LTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgNC40OTM1MzFdIGh1YiA0LTA6MS4wOiA1IHBvcnRz
IGRldGVjdGVkClsgICAgNC40OTM4NDldIGVoY2ktcGxhdGZvcm06IEVIQ0kgZ2VuZXJpYyBwbGF0
Zm9ybSBkcml2ZXIKWyAgICA0LjQ5Mzg3N10gb2hjaV9oY2Q6IFVTQiAxLjEgJ09wZW4nIEhvc3Qg
Q29udHJvbGxlciAoT0hDSSkgRHJpdmVyClsgICAgNC40OTM4ODZdIG9oY2ktcGNpOiBPSENJIFBD
SSBwbGF0Zm9ybSBkcml2ZXIKWyAgICA0LjQ5NDI3MF0gb2hjaS1wY2kgMDAwMDowMDoxMi4wOiBP
SENJIFBDSSBob3N0IGNvbnRyb2xsZXIKWyAgICA0LjQ5NDI4MF0gb2hjaS1wY2kgMDAwMDowMDox
Mi4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDUKWyAgICA0
LjQ5NDMzNV0gb2hjaS1wY2kgMDAwMDowMDoxMi4wOiBpcnEgMTgsIGlvIG1lbSAweGQ2OTRlMDAw
ClsgICAgNC41NTMxMzZdIHVzYiB1c2I1OiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9
MWQ2YiwgaWRQcm9kdWN0PTAwMDEKWyAgICA0LjU1MzE0Ml0gdXNiIHVzYjU6IE5ldyBVU0IgZGV2
aWNlIHN0cmluZ3M6IE1mcj0zLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0xClsgICAgNC41NTMx
NDRdIHVzYiB1c2I1OiBQcm9kdWN0OiBPSENJIFBDSSBob3N0IGNvbnRyb2xsZXIKWyAgICA0LjU1
MzE0Nl0gdXNiIHVzYjU6IE1hbnVmYWN0dXJlcjogTGludXggNC4wLjAtMDQwMDAwcmM1LWdlbmVy
aWMgb2hjaV9oY2QKWyAgICA0LjU1MzE0OF0gdXNiIHVzYjU6IFNlcmlhbE51bWJlcjogMDAwMDow
MDoxMi4wClsgICAgNC41NTM1MjVdIGh1YiA1LTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgNC41
NTM1NjhdIGh1YiA1LTA6MS4wOiA1IHBvcnRzIGRldGVjdGVkClsgICAgNC41NTQxODldIG9oY2kt
cGNpIDAwMDA6MDA6MTMuMDogT0hDSSBQQ0kgaG9zdCBjb250cm9sbGVyClsgICAgNC41NTQxOTld
IG9oY2ktcGNpIDAwMDA6MDA6MTMuMDogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQg
YnVzIG51bWJlciA2ClsgICAgNC41NTQyNDBdIG9oY2ktcGNpIDAwMDA6MDA6MTMuMDogaXJxIDE4
LCBpbyBtZW0gMHhkNjk0YzAwMApbICAgIDQuNjEzMTQwXSB1c2IgdXNiNjogTmV3IFVTQiBkZXZp
Y2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVjdD0wMDAxClsgICAgNC42MTMxNDZdIHVz
YiB1c2I2OiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MywgUHJvZHVjdD0yLCBTZXJpYWxO
dW1iZXI9MQpbICAgIDQuNjEzMTQ4XSB1c2IgdXNiNjogUHJvZHVjdDogT0hDSSBQQ0kgaG9zdCBj
b250cm9sbGVyClsgICAgNC42MTMxNTBdIHVzYiB1c2I2OiBNYW51ZmFjdHVyZXI6IExpbnV4IDQu
MC4wLTA0MDAwMHJjNS1nZW5lcmljIG9oY2lfaGNkClsgICAgNC42MTMxNTJdIHVzYiB1c2I2OiBT
ZXJpYWxOdW1iZXI6IDAwMDA6MDA6MTMuMApbICAgIDQuNjEzNzAyXSBodWIgNi0wOjEuMDogVVNC
IGh1YiBmb3VuZApbICAgIDQuNjEzNzQ3XSBodWIgNi0wOjEuMDogNSBwb3J0cyBkZXRlY3RlZApb
ICAgIDQuNjE0MzA2XSBvaGNpLXBjaSAwMDAwOjAwOjE0LjU6IE9IQ0kgUENJIGhvc3QgY29udHJv
bGxlcgpbICAgIDQuNjE0MzE0XSBvaGNpLXBjaSAwMDAwOjAwOjE0LjU6IG5ldyBVU0IgYnVzIHJl
Z2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgNwpbICAgIDQuNjE0MzYxXSBvaGNpLXBjaSAw
MDAwOjAwOjE0LjU6IGlycSAxOCwgaW8gbWVtIDB4ZDY5NGEwMDAKWyAgICA0LjY3MzE0NV0gdXNi
IHVzYjc6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xZDZiLCBpZFByb2R1Y3Q9MDAw
MQpbICAgIDQuNjczMTUxXSB1c2IgdXNiNzogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTMs
IFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTEKWyAgICA0LjY3MzE1M10gdXNiIHVzYjc6IFByb2R1
Y3Q6IE9IQ0kgUENJIGhvc3QgY29udHJvbGxlcgpbICAgIDQuNjczMTU1XSB1c2IgdXNiNzogTWFu
dWZhY3R1cmVyOiBMaW51eCA0LjAuMC0wNDAwMDByYzUtZ2VuZXJpYyBvaGNpX2hjZApbICAgIDQu
NjczMTU3XSB1c2IgdXNiNzogU2VyaWFsTnVtYmVyOiAwMDAwOjAwOjE0LjUKWyAgICA0LjY3Mzcw
OV0gaHViIDctMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgICA0LjY3Mzc1NV0gaHViIDctMDoxLjA6
IDIgcG9ydHMgZGV0ZWN0ZWQKWyAgICA0LjY3NDAyN10gb2hjaS1wbGF0Zm9ybTogT0hDSSBnZW5l
cmljIHBsYXRmb3JtIGRyaXZlcgpbICAgIDQuNjc0MDUyXSB1aGNpX2hjZDogVVNCIFVuaXZlcnNh
bCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlcgpbICAgIDQuNjc0MTU0XSBpODA0Mjog
UE5QOiBQUy8yIENvbnRyb2xsZXIgW1BOUDAzMDM6UFMySyxQTlAwZjEzOlBTMk1dIGF0IDB4NjAs
MHg2NCBpcnEgMSwxMgpbICAgIDQuNjc1OTk5XSBpODA0MjogRGV0ZWN0ZWQgYWN0aXZlIG11bHRp
cGxleGluZyBjb250cm9sbGVyLCByZXYgMS4xClsgICAgNC42NzY5OTBdIHNlcmlvOiBpODA0MiBL
QkQgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEKWyAgICA0LjY3Njk5N10gc2VyaW86IGk4MDQyIEFV
WDAgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEyClsgICAgNC42NzcwMzldIHNlcmlvOiBpODA0MiBB
VVgxIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxMgpbICAgIDQuNjc3MDY2XSBzZXJpbzogaTgwNDIg
QVVYMiBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMTIKWyAgICA0LjY3NzA5NF0gc2VyaW86IGk4MDQy
IEFVWDMgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEyClsgICAgNC42Nzc1MjRdIG1vdXNlZGV2OiBQ
Uy8yIG1vdXNlIGRldmljZSBjb21tb24gZm9yIGFsbCBtaWNlClsgICAgNC42Nzc4MDZdIHJ0Y19j
bW9zIDAwOjAzOiBSVEMgY2FuIHdha2UgZnJvbSBTNApbICAgIDQuNjc3OTU5XSBydGNfY21vcyAw
MDowMzogcnRjIGNvcmU6IHJlZ2lzdGVyZWQgcnRjX2Ntb3MgYXMgcnRjMApbICAgIDQuNjc3OTk3
XSBydGNfY21vcyAwMDowMzogYWxhcm1zIHVwIHRvIG9uZSBtb250aCwgMTE0IGJ5dGVzIG52cmFt
LCBocGV0IGlycXMKWyAgICA0LjY3ODAyOF0gaTJjIC9kZXYgZW50cmllcyBkcml2ZXIKWyAgICA0
LjY3ODExNl0gZGV2aWNlLW1hcHBlcjogdWV2ZW50OiB2ZXJzaW9uIDEuMC4zClsgICAgNC42Nzgy
NzZdIGRldmljZS1tYXBwZXI6IGlvY3RsOiA0LjMwLjAtaW9jdGwgKDIwMTQtMTItMjIpIGluaXRp
YWxpc2VkOiBkbS1kZXZlbEByZWRoYXQuY29tClsgICAgNC42NzgzMDRdIGxlZHRyaWctY3B1OiBy
ZWdpc3RlcmVkIHRvIGluZGljYXRlIGFjdGl2aXR5IG9uIENQVXMKWyAgICA0LjY3ODU2MF0gUEND
VCBoZWFkZXIgbm90IGZvdW5kLgpbICAgIDQuNjc4NjgyXSBUQ1A6IGN1YmljIHJlZ2lzdGVyZWQK
WyAgICA0LjY3ODg0Nl0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxMApbICAgIDQu
Njc5MTkzXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3ClsgICAgNC42NzkyMTFd
IEtleSB0eXBlIGRuc19yZXNvbHZlciByZWdpc3RlcmVkClsgICAgNC42ODAwNDhdIExvYWRpbmcg
Y29tcGlsZWQtaW4gWC41MDkgY2VydGlmaWNhdGVzClsgICAgNC42ODExNTRdIExvYWRlZCBYLjUw
OSBjZXJ0ICdNYWdyYXRoZWE6IEdsYWNpZXIgc2lnbmluZyBrZXk6IDUyZWEwZmQxMzY1YThiYjdj
ZmUzNWFhZmUxNTU5YWNiOWU1YmJlNTInClsgICAgNC42ODExNzhdIHJlZ2lzdGVyZWQgdGFza3N0
YXRzIHZlcnNpb24gMQpbICAgIDQuNjgzOTI4XSBLZXkgdHlwZSB0cnVzdGVkIHJlZ2lzdGVyZWQK
WyAgICA0LjY4ODUwNV0gS2V5IHR5cGUgZW5jcnlwdGVkIHJlZ2lzdGVyZWQKWyAgICA0LjY4ODUx
N10gQXBwQXJtb3I6IEFwcEFybW9yIHNoYTEgcG9saWN5IGhhc2hpbmcgZW5hYmxlZApbICAgIDQu
NzAzODUyXSBpbnB1dDogQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZCBhcyAvZGV2aWNlcy9w
bGF0Zm9ybS9pODA0Mi9zZXJpbzAvaW5wdXQvaW5wdXQzClsgICAgNC43OTMxMjZdIHVzYiAzLTU6
IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDIgdXNpbmcgZWhjaS1wY2kKWyAgICA0
LjkyMTExMV0gdHNjOiBSZWZpbmVkIFRTQyBjbG9ja3NvdXJjZSBjYWxpYnJhdGlvbjogMTg5Ni41
NzEgTUh6ClsgICAgNS4wMDkwNjJdIHVzYiA3LTI6IG5ldyBmdWxsLXNwZWVkIFVTQiBkZXZpY2Ug
bnVtYmVyIDIgdXNpbmcgb2hjaS1wY2kKWyAgICA1LjAxMzk5OF0gdXNiIDMtNTogTmV3IFVTQiBk
ZXZpY2UgZm91bmQsIGlkVmVuZG9yPTA0Y2EsIGlkUHJvZHVjdD03MDIyClsgICAgNS4wMTQwMDNd
IHVzYiAzLTU6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlh
bE51bWJlcj0wClsgICAgNS4wMTQwMDZdIHVzYiAzLTU6IFByb2R1Y3Q6IEhQIEhEIFdlYmNhbQpb
ICAgIDUuMDE0MDA4XSB1c2IgMy01OiBNYW51ZmFjdHVyZXI6IEREWkxEMDFHNDZDNlZEClsgICAg
NS4xNzk0MTRdIHVzYiA3LTI6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xMzhhLCBp
ZFByb2R1Y3Q9MDAzZgpbICAgIDUuMTc5NDIwXSB1c2IgNy0yOiBOZXcgVVNCIGRldmljZSBzdHJp
bmdzOiBNZnI9MCwgUHJvZHVjdD0wLCBTZXJpYWxOdW1iZXI9MQpbICAgIDUuMTc5NDIzXSB1c2Ig
Ny0yOiBTZXJpYWxOdW1iZXI6IDAwYjAyNDVmNGM5MgpbICAgIDUuMzQ1MjQ4XSBldm06IEhNQUMg
YXR0cnM6IDB4MQpbICAgIDUuMzQ2MTI4XSAgIE1hZ2ljIG51bWJlcjogNzo2OTA6NzA5ClsgICAg
NS4zNDYyNzZdIHJ0Y19jbW9zIDAwOjAzOiBzZXR0aW5nIHN5c3RlbSBjbG9jayB0byAyMDE1LTAz
LTI3IDAwOjQzOjI1IFVUQyAoMTQyNzQxNzAwNSkKWyAgICA1LjM0NjY5MF0gYWNwaS1jcHVmcmVx
OiBvdmVycmlkaW5nIEJJT1MgcHJvdmlkZWQgX1BTRCBkYXRhClsgICAgNS4zNDcwNjNdIEJJT1Mg
RUREIGZhY2lsaXR5IHYwLjE2IDIwMDQtSnVuLTI1LCAwIGRldmljZXMgZm91bmQKWyAgICA1LjM0
NzA2NF0gRUREIGluZm9ybWF0aW9uIG5vdCBhdmFpbGFibGUuClsgICAgNS4zNDcxNjldIFBNOiBI
aWJlcm5hdGlvbiBpbWFnZSBub3QgcHJlc2VudCBvciBjb3VsZCBub3QgYmUgbG9hZGVkLgpbICAg
IDUuMzQ3ODAxXSBGcmVlaW5nIHVudXNlZCBrZXJuZWwgbWVtb3J5OiAxNDIwSyAoZmZmZmZmZmY4
MWQxZTAwMCAtIGZmZmZmZmZmODFlODEwMDApClsgICAgNS4zNDc4MDRdIFdyaXRlIHByb3RlY3Rp
bmcgdGhlIGtlcm5lbCByZWFkLW9ubHkgZGF0YTogMTIyODhrClsgICAgNS4zNDgxNjVdIEZyZWVp
bmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDQ4SyAoZmZmZjg4MDAwMTdmNDAwMCAtIGZmZmY4ODAw
MDE4MDAwMDApClsgICAgNS4zNDgyODNdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDE4
NEsgKGZmZmY4ODAwMDFiZDIwMDAgLSBmZmZmODgwMDAxYzAwMDAwKQpbICAgIDUuMzcxNjQzXSBz
eXN0ZW1kLXVkZXZkWzEyNV06IHN0YXJ0aW5nIHZlcnNpb24gMjA0ClsgICAgNS4zODkwMDhdIEFD
UEk6IFZpZGVvIERldmljZSBbR0ZYMF0gKG11bHRpLWhlYWQ6IHllcyAgcm9tOiBubyAgcG9zdDog
bm8pClsgICAgNS4zOTYzODFdIGFjcGkgZGV2aWNlOjAwOiByZWdpc3RlcmVkIGFzIGNvb2xpbmdf
ZGV2aWNlNApbICAgIDUuMzk2NTcxXSBpbnB1dDogVmlkZW8gQnVzIGFzIC9kZXZpY2VzL0xOWFNZ
U1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBBMDg6MDAvTE5YVklERU86MDAvaW5wdXQvaW5wdXQ5Clsg
ICAgNS4zOTc4MDNdIEFDUEk6IFZpZGVvIERldmljZSBbREdGWF0gKG11bHRpLWhlYWQ6IHllcyAg
cm9tOiBubyAgcG9zdDogbm8pClsgICAgNS4zOTkyNTNdIGFjcGkgZGV2aWNlOjBhOiByZWdpc3Rl
cmVkIGFzIGNvb2xpbmdfZGV2aWNlNQpbICAgIDUuMzk5NDU5XSBpbnB1dDogVmlkZW8gQnVzIGFz
IC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBBMDg6MDAvZGV2aWNlOjA5L0xO
WFZJREVPOjAxL2lucHV0L2lucHV0MTAKWyAgICA1LjQwMTk3OF0gd21pOiBNYXBwZXIgbG9hZGVk
ClsgICAgNS40MDg0MDJdIHI4MTY5IEdpZ2FiaXQgRXRoZXJuZXQgZHJpdmVyIDIuM0xLLU5BUEkg
bG9hZGVkClsgICAgNS40MDg0MThdIHI4MTY5IDAwMDA6MDI6MDAuMDogY2FuJ3QgZGlzYWJsZSBB
U1BNOyBPUyBkb2Vzbid0IGhhdmUgQVNQTSBjb250cm9sClsgICAgNS40MDk5ODhdIHJ0c3hfcGNp
IDAwMDA6MDQ6MDAuMDogcnRzeF9wY2lfYWNxdWlyZV9pcnE6IHBjci0+bXNpX2VuID0gMSwgcGNp
LT5pcnEgPSAzNgpbICAgIDUuNDEyNjY3XSBhaGNpIDAwMDA6MDA6MTEuMDogdmVyc2lvbiAzLjAK
WyAgICA1LjQxMzI0NF0gYWhjaSAwMDAwOjAwOjExLjA6IEFIQ0kgMDAwMS4wMzAwIDMyIHNsb3Rz
IDIgcG9ydHMgNiBHYnBzIDB4MyBpbXBsIFNBVEEgbW9kZQpbICAgIDUuNDEzMjUwXSBhaGNpIDAw
MDA6MDA6MTEuMDogZmxhZ3M6IDY0Yml0IG5jcSBzbnRmIGlsY2sgcG0gbGVkIGNsbyBwbXAgcGlv
IHNsdW0gcGFydCAKWyAgICA1LjQxNTY1NF0gcjgxNjkgMDAwMDowMjowMC4wIGV0aDA6IFJUTDgx
NjhnLzgxMTFnIGF0IDB4ZmZmZmM5MDAwMGM4ZTAwMCwgYTA6MmI6Yjg6MzM6Zjg6NzMsIFhJRCAx
MDkwMDgwMCBJUlEgNDUKWyAgICA1LjQxNTY2MF0gcjgxNjkgMDAwMDowMjowMC4wIGV0aDA6IGp1
bWJvIGZlYXR1cmVzIFtmcmFtZXM6IDkyMDAgYnl0ZXMsIHR4IGNoZWNrc3VtbWluZzoga29dClsg
ICAgNS40MjExMDNdIHNjc2kgaG9zdDA6IGFoY2kKWyAgICA1LjQyMTQ0MF0gc2NzaSBob3N0MTog
YWhjaQpbICAgIDUuNDIxNjIyXSBhdGExOiBTQVRBIG1heCBVRE1BLzEzMyBhYmFyIG0yMDQ4QDB4
ZDY5NGYwMDAgcG9ydCAweGQ2OTRmMTAwIGlycSAzNwpbICAgIDUuNDIxNjI3XSBhdGEyOiBTQVRB
IG1heCBVRE1BLzEzMyBhYmFyIG0yMDQ4QDB4ZDY5NGYwMDAgcG9ydCAweGQ2OTRmMTgwIGlycSAz
OApbICAgIDUuOTEzMDg4XSBhdGEyOiBTQVRBIGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEz
IFNDb250cm9sIDMwMCkKWyAgICA1LjkxMzEzMF0gYXRhMTogU0FUQSBsaW5rIHVwIDYuMCBHYnBz
IChTU3RhdHVzIDEzMyBTQ29udHJvbCAzMDApClsgICAgNS45MTY1NDVdIGF0YTEuMDA6IEFUQS05
OiBIR1NUIEhUUzU0MTAxMEE5RTY4MCwgSkEwT0E3MTAsIG1heCBVRE1BLzEzMwpbICAgIDUuOTE2
NTUxXSBhdGExLjAwOiAxOTUzNTI1MTY4IHNlY3RvcnMsIG11bHRpIDE2OiBMQkE0OCBOQ1EgKGRl
cHRoIDMxLzMyKSwgQUEKWyAgICA1LjkxODIwOF0gYXRhMi4wMDogQVRBUEk6IGhwICAgICAgIERW
RFJXICBTVTIwOEZCLCBISDAxLCBtYXggVURNQS8xMDAKWyAgICA1LjkxODQyMV0gYXRhMS4wMDog
Y29uZmlndXJlZCBmb3IgVURNQS8xMzMKWyAgICA1LjkxODY2MF0gc2NzaSAwOjA6MDowOiBEaXJl
Y3QtQWNjZXNzICAgICBBVEEgICAgICBIR1NUIEhUUzU0MTAxMEE5IEE3MTAgUFE6IDAgQU5TSTog
NQpbICAgIDUuOTE4OTgzXSBzZCAwOjA6MDowOiBbc2RhXSAxOTUzNTI1MTY4IDUxMi1ieXRlIGxv
Z2ljYWwgYmxvY2tzOiAoMS4wMCBUQi85MzEgR2lCKQpbICAgIDUuOTE4OTg3XSBzZCAwOjA6MDow
OiBbc2RhXSA0MDk2LWJ5dGUgcGh5c2ljYWwgYmxvY2tzClsgICAgNS45MTkwMzNdIHNkIDA6MDow
OjA6IFtzZGFdIFdyaXRlIFByb3RlY3QgaXMgb2ZmClsgICAgNS45MTkwMzddIHNkIDA6MDowOjA6
IFtzZGFdIE1vZGUgU2Vuc2U6IDAwIDNhIDAwIDAwClsgICAgNS45MTkwNTddIHNkIDA6MDowOjA6
IFtzZGFdIFdyaXRlIGNhY2hlOiBlbmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBkb2Vzbid0
IHN1cHBvcnQgRFBPIG9yIEZVQQpbICAgIDUuOTE5MDcyXSBzZCAwOjA6MDowOiBBdHRhY2hlZCBz
Y3NpIGdlbmVyaWMgc2cwIHR5cGUgMApbICAgIDUuOTIxMjM2XSBTd2l0Y2hlZCB0byBjbG9ja3Nv
dXJjZSB0c2MKWyAgICA1LjkyNTMxNF0gYXRhMi4wMDogY29uZmlndXJlZCBmb3IgVURNQS8xMDAK
WyAgICA1LjkyOTI0Ml0gc2NzaSAxOjA6MDowOiBDRC1ST00gICAgICAgICAgICBocCAgICAgICBE
VkRSVyAgU1UyMDhGQiAgIEhIMDEgUFE6IDAgQU5TSTogNQpbICAgIDUuOTU2OTQxXSBzciAxOjA6
MDowOiBbc3IwXSBzY3NpMy1tbWMgZHJpdmU6IDI0eC8yNHggd3JpdGVyIGR2ZC1yYW0gY2Qvcncg
eGEvZm9ybTIgY2RkYSB0cmF5ClsgICAgNS45NTY5NjJdIGNkcm9tOiBVbmlmb3JtIENELVJPTSBk
cml2ZXIgUmV2aXNpb246IDMuMjAKWyAgICA1Ljk1NzI0N10gc3IgMTowOjA6MDogQXR0YWNoZWQg
c2NzaSBDRC1ST00gc3IwClsgICAgNS45NTc0MzVdIHNyIDE6MDowOjA6IEF0dGFjaGVkIHNjc2kg
Z2VuZXJpYyBzZzEgdHlwZSA1ClsgICAgNS45ODA2MDddICBzZGE6IHNkYTEgc2RhMiBzZGEzClsg
ICAgNS45ODEzMjJdIHNkIDA6MDowOjA6IFtzZGFdIEF0dGFjaGVkIFNDU0kgZGlzawpbICAgIDYu
MjA0NDcyXSBwc21vdXNlIHNlcmlvMzogc3luYXB0aWNzOiBxdWVyaWVkIG1heCBjb29yZGluYXRl
czogeCBbLi41NzQyXSwgeSBbLi41MDA0XQpbICAgIDYuMjQyMTUzXSBwc21vdXNlIHNlcmlvMzog
c3luYXB0aWNzOiBxdWVyaWVkIG1pbiBjb29yZGluYXRlczogeCBbMTE5OC4uXSwgeSBbOTcyLi5d
ClsgICAgNi4zMDgzNDldIHBzbW91c2Ugc2VyaW8zOiBzeW5hcHRpY3M6IFRvdWNocGFkIG1vZGVs
OiAxLCBmdzogNy41LCBpZDogMHgxZTBiMSwgY2FwczogMHhmMDAxNzMvMHg2NDAwMDAvMHhhMjQw
MCwgYm9hcmQgaWQ6IDI2NTMsIGZ3IGlkOiAxNDgxMTU5ClsgICAgNi4zNTA5MzVdIGlucHV0OiBT
eW5QUy8yIFN5bmFwdGljcyBUb3VjaFBhZCBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9pODA0Mi9zZXJp
bzMvaW5wdXQvaW5wdXQxMwpbICAgIDcuODM3MjQ2XSByYWlkNjogc3NlMngxICAgIDU2NzcgTUIv
cwpbICAgIDcuOTA1MjQyXSByYWlkNjogc3NlMngyICAgIDg0ODMgTUIvcwpbICAgIDcuOTczMjQ3
XSByYWlkNjogc3NlMng0ICAgIDk1NzcgTUIvcwpbICAgIDcuOTczMjQ4XSByYWlkNjogdXNpbmcg
YWxnb3JpdGhtIHNzZTJ4NCAoOTU3NyBNQi9zKQpbICAgIDcuOTczMjUwXSByYWlkNjogdXNpbmcg
c3NzZTN4MiByZWNvdmVyeSBhbGdvcml0aG0KWyAgICA3Ljk3NDczMl0geG9yOiBhdXRvbWF0aWNh
bGx5IHVzaW5nIGJlc3QgY2hlY2tzdW1taW5nIGZ1bmN0aW9uOgpbICAgIDguMDEzMjY3XSAgICBh
dnggICAgICAgOiAgOTEyMS4wMDAgTUIvc2VjClsgICAgOC4wMjkyNDVdIEJ0cmZzIGxvYWRlZApb
ICAgIDguMjI5MTM0XSByYW5kb206IG5vbmJsb2NraW5nIHBvb2wgaXMgaW5pdGlhbGl6ZWQKWyAg
ICA4LjM4Mjg0N10gRVhUNC1mcyAoc2RhMik6IG1vdW50ZWQgZmlsZXN5c3RlbSB3aXRoIG9yZGVy
ZWQgZGF0YSBtb2RlLiBPcHRzOiAobnVsbCkKWyAgIDE4LjU3MzY3M10gRVhUNC1mcyAoc2RhMik6
IHJlLW1vdW50ZWQuIE9wdHM6IGVycm9ycz1yZW1vdW50LXJvClsgICAxOC42MTAzNDFdIEFkZGlu
ZyA3MjgyNjg0ayBzd2FwIG9uIC9kZXYvc2RhMy4gIFByaW9yaXR5Oi0xIGV4dGVudHM6MSBhY3Jv
c3M6NzI4MjY4NGsgRlMKWyAgIDE4Ljg5Mzk4N10gc3lzdGVtZC11ZGV2ZFs0MDBdOiBzdGFydGlu
ZyB2ZXJzaW9uIDIwNApbICAgMTkuNDQxNTIxXSBJbml0aWFsaXppbmcgSFBRNjAwMSBtb2R1bGUK
WyAgIDE5LjQ0MTYwOV0gaW5wdXQ6IEhQIFdpcmVsZXNzIGhvdGtleXMgYXMgL2RldmljZXMvdmly
dHVhbC9pbnB1dC9pbnB1dDE1ClsgICAxOS41Mzk2MzFdIGhwX2FjY2VsOiBsYXB0b3AgbW9kZWwg
dW5rbm93biwgdXNpbmcgZGVmYXVsdCBheGVzIGNvbmZpZ3VyYXRpb24KWyAgIDE5LjYwNTcyNV0g
bHA6IGRyaXZlciBsb2FkZWQgYnV0IG5vIGRldmljZXMgZm91bmQKWyAgIDE5LjY2NjM1Ml0gbGlz
M2x2MDJkOiA4IGJpdHMgM0RDIHNlbnNvciBmb3VuZApbICAgMTkuNzU3MjgxXSBwcGRldjogdXNl
ci1zcGFjZSBwYXJhbGxlbCBwb3J0IGRyaXZlcgpbICAgMTkuNzc2OTU3XSBBQ1BJIFdhcm5pbmc6
IFN5c3RlbUlPIHJhbmdlIDB4MDAwMDAwMDAwMDAwMGIwMC0weDAwMDAwMDAwMDAwMDBiMDcgY29u
ZmxpY3RzIHdpdGggT3BSZWdpb24gMHgwMDAwMDAwMDAwMDAwYjAwLTB4MDAwMDAwMDAwMDAwMGIw
NiAoXF9TQl8uUENJMC5TTUJTLlNNQk8pICgyMDE1MDIwNC91dGFkZHJlc3MtMjU4KQpbICAgMTku
Nzc2OTY3XSBBQ1BJOiBJZiBhbiBBQ1BJIGRyaXZlciBpcyBhdmFpbGFibGUgZm9yIHRoaXMgZGV2
aWNlLCB5b3Ugc2hvdWxkIHVzZSBpdCBpbnN0ZWFkIG9mIHRoZSBuYXRpdmUgZHJpdmVyClsgICAx
OS44MTQ4OTVdIHNocGNocDogU3RhbmRhcmQgSG90IFBsdWcgUENJIENvbnRyb2xsZXIgRHJpdmVy
IHZlcnNpb246IDAuNApbICAgMTkuODQxNTY1XSBkZXZpY2UtbWFwcGVyOiBtdWx0aXBhdGg6IHZl
cnNpb24gMS44LjAgbG9hZGVkClsgICAxOS44NzM2OTNdIE1DRTogSW4ta2VybmVsIE1DRSBkZWNv
ZGluZyBlbmFibGVkLgpbICAgMTkuOTA3MTgxXSBzZXJpb19yYXcgc2VyaW8zOiByYXcgYWNjZXNz
IGVuYWJsZWQgb24gaXNhMDA2MC9zZXJpbzMgKHNlcmlvX3JhdzAsIG1pbm9yIDU2KQpbICAgMTku
OTE1NTg1XSBFREFDIE1DOiBWZXI6IDMuMC4wClsgICAxOS45MjMwMDRdIEFNRDY0IEVEQUMgZHJp
dmVyIHYzLjQuMApbICAgMTkuOTIzMDYyXSBFREFDIGFtZDY0OiBEUkFNIEVDQyBkaXNhYmxlZC4K
WyAgIDE5LjkyMzA3MV0gRURBQyBhbWQ2NDogRUNDIGRpc2FibGVkIGluIHRoZSBCSU9TIG9yIG5v
IEVDQyBjYXBhYmlsaXR5LCBtb2R1bGUgd2lsbCBub3QgbG9hZC4KWyAgIDE5LjkyMzA3MV0gIEVp
dGhlciBlbmFibGUgRUNDIGNoZWNraW5nIG9yIGZvcmNlIG1vZHVsZSBsb2FkaW5nIGJ5IHNldHRp
bmcgJ2VjY19lbmFibGVfb3ZlcnJpZGUnLgpbICAgMTkuOTIzMDcxXSAgKE5vdGUgdGhhdCB1c2Ug
b2YgdGhlIG92ZXJyaWRlIG1heSBjYXVzZSB1bmtub3duIHNpZGUgZWZmZWN0cy4pClsgICAyMC4x
NjY2NTRdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTQyNzQxNzAyMC4zMTI6Mik6IGFwcGFybW9y
PSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBuYW1lPSIvc2Jpbi9kaGNsaWVudCIg
cGlkPTU4NyBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAyMC4xNjY2NjJdIGF1ZGl0OiB0eXBl
PTE0MDAgYXVkaXQoMTQyNzQxNzAyMC4zMTI6Myk6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJhdGlv
bj0icHJvZmlsZV9sb2FkIiBuYW1lPSIvdXNyL2xpYi9OZXR3b3JrTWFuYWdlci9ubS1kaGNwLWNs
aWVudC5hY3Rpb24iIHBpZD01ODcgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgMjAuMTY2NjY2
XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE0Mjc0MTcwMjAuMzEyOjQpOiBhcHBhcm1vcj0iU1RB
VFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgbmFtZT0iL3Vzci9saWIvY29ubm1hbi9zY3Jp
cHRzL2RoY2xpZW50LXNjcmlwdCIgcGlkPTU4NyBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAy
MC4xNjcwODNdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTQyNzQxNzAyMC4zMTY6NSk6IGFwcGFy
bW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9yZXBsYWNlIiBuYW1lPSIvdXNyL2xpYi9O
ZXR3b3JrTWFuYWdlci9ubS1kaGNwLWNsaWVudC5hY3Rpb24iIHBpZD01ODcgY29tbT0iYXBwYXJt
b3JfcGFyc2VyIgpbICAgMjAuMTY3MDg5XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE0Mjc0MTcw
MjAuMzE2OjYpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfcmVwbGFjZSIg
bmFtZT0iL3Vzci9saWIvY29ubm1hbi9zY3JpcHRzL2RoY2xpZW50LXNjcmlwdCIgcGlkPTU4NyBj
b21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAyMC4xNjcyOTZdIGF1ZGl0OiB0eXBlPTE0MDAgYXVk
aXQoMTQyNzQxNzAyMC4zMTY6Nyk6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmls
ZV9yZXBsYWNlIiBuYW1lPSIvdXNyL2xpYi9jb25ubWFuL3NjcmlwdHMvZGhjbGllbnQtc2NyaXB0
IiBwaWQ9NTg3IGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDIwLjUyNzU1NV0gQVZYIHZlcnNp
b24gb2YgZ2NtX2VuYy9kZWMgZW5nYWdlZC4KWyAgIDIwLjUyNzU2MF0gQUVTIENUUiBtb2RlIGJ5
OCBvcHRpbWl6YXRpb24gZW5hYmxlZApbICAgMjAuNTI3NzgwXSBjZmc4MDIxMTogQ2FsbGluZyBD
UkRBIHRvIHVwZGF0ZSB3b3JsZCByZWd1bGF0b3J5IGRvbWFpbgpbICAgMjAuNTQxMzg3XSBCbHVl
dG9vdGg6IENvcmUgdmVyIDIuMjAKWyAgIDIwLjU0MTQxMF0gTkVUOiBSZWdpc3RlcmVkIHByb3Rv
Y29sIGZhbWlseSAzMQpbICAgMjAuNTQxNDEzXSBCbHVldG9vdGg6IEhDSSBkZXZpY2UgYW5kIGNv
bm5lY3Rpb24gbWFuYWdlciBpbml0aWFsaXplZApbICAgMjAuNTQxNDE5XSBCbHVldG9vdGg6IEhD
SSBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgIDIwLjU0MTQyNF0gQmx1ZXRvb3RoOiBMMkNB
UCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgIDIwLjU0MTQzNV0gQmx1ZXRvb3RoOiBTQ08g
c29ja2V0IGxheWVyIGluaXRpYWxpemVkClsgICAyMC41ODYyMzJdIEJsdWV0b290aDogQk5FUCAo
RXRoZXJuZXQgRW11bGF0aW9uKSB2ZXIgMS4zClsgICAyMC41ODYyMzhdIEJsdWV0b290aDogQk5F
UCBmaWx0ZXJzOiBwcm90b2NvbCBtdWx0aWNhc3QKWyAgIDIwLjU4NjI0Nl0gQmx1ZXRvb3RoOiBC
TkVQIHNvY2tldCBsYXllciBpbml0aWFsaXplZApbICAgMjAuNjc5MTUxXSBCbHVldG9vdGg6IFJG
Q09NTSBUVFkgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgIDIwLjY3OTE2N10gQmx1ZXRvb3RoOiBSRkNP
TU0gc29ja2V0IGxheWVyIGluaXRpYWxpemVkClsgICAyMC42NzkxNzVdIEJsdWV0b290aDogUkZD
T01NIHZlciAxLjExClsgICAyMC43MDA3NTJdIGlucHV0OiBIUCBXTUkgaG90a2V5cyBhcyAvZGV2
aWNlcy92aXJ0dWFsL2lucHV0L2lucHV0MTYKWyAgIDIwLjcwNDcwMF0gYXVkaXQ6IHR5cGU9MTQw
MCBhdWRpdCgxNDI3NDE3MDIwLjg1Mjo4KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJw
cm9maWxlX2xvYWQiIG5hbWU9Ii91c3IvbGliL2N1cHMvYmFja2VuZC9jdXBzLXBkZiIgcGlkPTc2
MiBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAyMC43MDQ3MDldIGF1ZGl0OiB0eXBlPTE0MDAg
YXVkaXQoMTQyNzQxNzAyMC44NTI6OSk6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJv
ZmlsZV9sb2FkIiBuYW1lPSIvdXNyL3NiaW4vY3Vwc2QiIHBpZD03NjIgY29tbT0iYXBwYXJtb3Jf
cGFyc2VyIgpbICAgMjAuNzA1MjA5XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE0Mjc0MTcwMjAu
ODUyOjEwKTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX3JlcGxhY2UiIG5h
bWU9Ii91c3Ivc2Jpbi9jdXBzZCIgcGlkPTc2MiBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAy
MC45ODkyNzVdIGluaXQ6IGZhaWxzYWZlIG1haW4gcHJvY2VzcyAoNjgyKSBraWxsZWQgYnkgVEVS
TSBzaWduYWwKWyAgIDIxLjAwMzI5Ml0gaW5wdXQ6IFNUIExJUzNMVjAyREwgQWNjZWxlcm9tZXRl
ciBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9saXMzbHYwMmQvaW5wdXQvaW5wdXQxNwpbICAgMjEuMDM1
MDE3XSBpbml0OiBjdXBzIG1haW4gcHJvY2VzcyAoNzY1KSBraWxsZWQgYnkgSFVQIHNpZ25hbApb
ICAgMjEuMDM1MDM0XSBpbml0OiBjdXBzIG1haW4gcHJvY2VzcyBlbmRlZCwgcmVzcGF3bmluZwpb
ICAgMjEuMTcyNzE0XSBpbnB1dDogSEQtQXVkaW8gR2VuZXJpYyBIRE1JL0RQLHBjbT0zIGFzIC9k
ZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowMS4xL3NvdW5kL2NhcmQwL2lucHV0MTgKWyAgIDIx
LjE3ODMwMl0gbWVkaWE6IExpbnV4IG1lZGlhIGludGVyZmFjZTogdjAuMTAKWyAgIDIxLjIzMTkw
M10gTGludXggdmlkZW8gY2FwdHVyZSBpbnRlcmZhY2U6IHYyLjAwClsgICAyMS4yNTg4NDVdIHNv
dW5kIGhkYXVkaW9DMUQwOiBhdXRvY29uZmlnIGZvciBBTEMzMjI3OiBsaW5lX291dHM9MSAoMHgx
NC8weDAvMHgwLzB4MC8weDApIHR5cGU6c3BlYWtlcgpbICAgMjEuMjU4ODUzXSBzb3VuZCBoZGF1
ZGlvQzFEMDogICAgc3BlYWtlcl9vdXRzPTAgKDB4MC8weDAvMHgwLzB4MC8weDApClsgICAyMS4y
NTg4NTZdIHNvdW5kIGhkYXVkaW9DMUQwOiAgICBocF9vdXRzPTEgKDB4MjEvMHgwLzB4MC8weDAv
MHgwKQpbICAgMjEuMjU4ODU4XSBzb3VuZCBoZGF1ZGlvQzFEMDogICAgbW9ubzogbW9ub19vdXQ9
MHgwClsgICAyMS4yNTg4NjBdIHNvdW5kIGhkYXVkaW9DMUQwOiAgICBpbnB1dHM6ClsgICAyMS4y
NTg4NjNdIHNvdW5kIGhkYXVkaW9DMUQwOiAgICAgIE1pYz0weDE5ClsgICAyMS4yNTg4NjZdIHNv
dW5kIGhkYXVkaW9DMUQwOiAgICAgIEludGVybmFsIE1pYz0weDEyClsgICAyMS4yNzA1NjNdIGlu
cHV0OiBIRC1BdWRpbyBHZW5lcmljIE1pYyBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6
MTQuMi9zb3VuZC9jYXJkMS9pbnB1dDE5ClsgICAyMS4yNzA3OTJdIGlucHV0OiBIRC1BdWRpbyBH
ZW5lcmljIEhlYWRwaG9uZSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTQuMi9zb3Vu
ZC9jYXJkMS9pbnB1dDIwClsgICAyMS4yODg5MjZdIGt2bTogTmVzdGVkIFZpcnR1YWxpemF0aW9u
IGVuYWJsZWQKWyAgIDIxLjI4ODkzNF0ga3ZtOiBOZXN0ZWQgUGFnaW5nIGVuYWJsZWQKWyAgIDIx
LjMzMzgyMF0gYXRoOiBwaHkwOiBFbmFibGUgTE5BIGNvbWJpbmluZwpbICAgMjEuMzM0OTI1XSBh
dGg6IEVFUFJPTSByZWdkb21haW46IDB4NjAKWyAgIDIxLjMzNDkyN10gYXRoOiBFRVBST00gaW5k
aWNhdGVzIHdlIHNob3VsZCBleHBlY3QgYSBkaXJlY3QgcmVncGFpciBtYXAKWyAgIDIxLjMzNDkz
MV0gYXRoOiBDb3VudHJ5IGFscGhhMiBiZWluZyB1c2VkOiAwMApbICAgMjEuMzM0OTMzXSBhdGg6
IFJlZ3BhaXIgdXNlZDogMHg2MApbICAgMjEuMzUwMjk4XSBjZmc4MDIxMTogV29ybGQgcmVndWxh
dG9yeSBkb21haW4gdXBkYXRlZDoKWyAgIDIxLjM1MDMwNV0gY2ZnODAyMTE6ICBERlMgTWFzdGVy
IHJlZ2lvbjogdW5zZXQKWyAgIDIxLjM1MDMwN10gY2ZnODAyMTE6ICAgKHN0YXJ0X2ZyZXEgLSBl
bmRfZnJlcSBAIGJhbmR3aWR0aCksIChtYXhfYW50ZW5uYV9nYWluLCBtYXhfZWlycCksIChkZnNf
Y2FjX3RpbWUpClsgICAyMS4zNTAzMTFdIGNmZzgwMjExOiAgICgyNDAyMDAwIEtIeiAtIDI0NzIw
MDAgS0h6IEAgNDAwMDAgS0h6KSwgKDMwMCBtQmksIDIwMDAgbUJtKSwgKE4vQSkKWyAgIDIxLjM1
MDMxM10gY2ZnODAyMTE6ICAgKDI0NTcwMDAgS0h6IC0gMjQ4MjAwMCBLSHogQCA0MDAwMCBLSHop
LCAoMzAwIG1CaSwgMjAwMCBtQm0pLCAoTi9BKQpbICAgMjEuMzUwMzE1XSBjZmc4MDIxMTogICAo
MjQ3NDAwMCBLSHogLSAyNDk0MDAwIEtIeiBAIDIwMDAwIEtIeiksICgzMDAgbUJpLCAyMDAwIG1C
bSksIChOL0EpClsgICAyMS4zNTAzMThdIGNmZzgwMjExOiAgICg1MTcwMDAwIEtIeiAtIDUyNTAw
MDAgS0h6IEAgNDAwMDAgS0h6KSwgKDMwMCBtQmksIDIwMDAgbUJtKSwgKE4vQSkKWyAgIDIxLjM1
MDMyMF0gY2ZnODAyMTE6ICAgKDU3MzUwMDAgS0h6IC0gNTgzNTAwMCBLSHogQCA0MDAwMCBLSHop
LCAoMzAwIG1CaSwgMjAwMCBtQm0pLCAoTi9BKQpbICAgMjEuNTYwNTIyXSBhdWRpdDogdHlwZT0x
NDAwIGF1ZGl0KDE0Mjc0MTcwMjEuNzA4OjExKTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9u
PSJwcm9maWxlX3JlcGxhY2UiIG5hbWU9Ii9zYmluL2RoY2xpZW50IiBwaWQ9OTE5IGNvbW09ImFw
cGFybW9yX3BhcnNlciIKWyAgIDIxLjc2NjQxMF0gaWVlZTgwMjExIHBoeTA6IFNlbGVjdGVkIHJh
dGUgY29udHJvbCBhbGdvcml0aG0gJ21pbnN0cmVsX2h0JwpbICAgMjEuNzY3MDI4XSBpZWVlODAy
MTEgcGh5MDogQXRoZXJvcyBBUjk0ODUgUmV2OjEgbWVtPTB4ZmZmZmM5MDAxMTI4MDAwMCwgaXJx
PTQ4ClsgICAyMS44OTIxNDVdIHV2Y3ZpZGVvOiBGb3VuZCBVVkMgMS4wMCBkZXZpY2UgSFAgSEQg
V2ViY2FtICgwNGNhOjcwMjIpClsgICAyMS45MDMwMDBdIGlucHV0OiBIUCBIRCBXZWJjYW0gYXMg
L2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjEyLjIvdXNiMy8zLTUvMy01OjEuMC9pbnB1dC9p
bnB1dDIxClsgICAyMS45MDMxNzhdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBk
cml2ZXIgdXZjdmlkZW8KWyAgIDIxLjkwMzE4MV0gVVNCIFZpZGVvIENsYXNzIGRyaXZlciAoMS4x
LjEpClsgICAyMi44MTkwOTddIHRoaW5rcGFkX2VjOiBtb2R1bGUgdmVyaWZpY2F0aW9uIGZhaWxl
ZDogc2lnbmF0dXJlIGFuZC9vciByZXF1aXJlZCBrZXkgbWlzc2luZyAtIHRhaW50aW5nIGtlcm5l
bApbICAgMjIuODE5NjUzXSB0aGlua3BhZF9lYzogbm8gVGhpbmtQYWQgZW1iZWRkZWQgY29udHJv
bGxlciEKWyAgIDIzLjUwNTc5MV0gcjgxNjkgMDAwMDowMjowMC4wIGV0aDA6IGxpbmsgZG93bgpb
ICAgMjMuNTA1ODYyXSBJUHY2OiBBRERSQ09ORihORVRERVZfVVApOiBldGgwOiBsaW5rIGlzIG5v
dCByZWFkeQpbICAgMjMuNTA1OTc3XSByODE2OSAwMDAwOjAyOjAwLjAgZXRoMDogbGluayBkb3du
ClsgICAyMy41MTUwNjNdIEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJTlZBTElEX0RFVklDRV9SRVFV
RVNUIGRldmljZT0wMDowMC4xIGFkZHJlc3M9MHgwMDAwMDBmZGY4MGMwMDIwIGZsYWdzPTB4MGEw
MF0KWyAgIDIzLjUyMjYwMl0gSVB2NjogQUREUkNPTkYoTkVUREVWX1VQKTogd2xhbjA6IGxpbmsg
aXMgbm90IHJlYWR5ClsgICAyNC43MDg1MjJdIHdsYW4wOiBhdXRoZW50aWNhdGUgd2l0aCAzYzpj
ZTo3Mzo0ODowNDo4MApbICAgMjQuNzIyNTkyXSB3bGFuMDogc2VuZCBhdXRoIHRvIDNjOmNlOjcz
OjQ4OjA0OjgwICh0cnkgMS8zKQpbICAgMjYuMTQ2MTI4XSByODE2OSAwMDAwOjAyOjAwLjAgZXRo
MDogbGluayB1cApbICAgMjYuMTQ2MTQ1XSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTog
ZXRoMDogbGluayBiZWNvbWVzIHJlYWR5ClsgICAyNi4xNTYyMDZdIHdsYW4wOiBzZW5kIGF1dGgg
dG8gM2M6Y2U6NzM6NDg6MDQ6ODAgKHRyeSAyLzMpClsgICAyNi41MTA0NTJdIGluaXQ6IHBseW1v
dXRoLXVwc3RhcnQtYnJpZGdlIG1haW4gcHJvY2VzcyBlbmRlZCwgcmVzcGF3bmluZwpbICAgMjYu
NTE3MjM3XSBpbml0OiBsaWdodGRtIG1haW4gcHJvY2VzcyAoMTM2NSkgdGVybWluYXRlZCB3aXRo
IHN0YXR1cyAxClsgICAyNi41MTc0NTBdIGluaXQ6IHBseW1vdXRoLXVwc3RhcnQtYnJpZGdlIG1h
aW4gcHJvY2VzcyAoMTQwNykgdGVybWluYXRlZCB3aXRoIHN0YXR1cyAxClsgICAyNi41MTc0NjJd
IGluaXQ6IHBseW1vdXRoLXVwc3RhcnQtYnJpZGdlIG1haW4gcHJvY2VzcyBlbmRlZCwgcmVzcGF3
bmluZwpbICAgMjYuNTQwODUzXSBpbml0OiBwbHltb3V0aC1yZWFkeSAoc3RhcnR1cCkgbWFpbiBw
cm9jZXNzICgyNjkpIHRlcm1pbmF0ZWQgd2l0aCBzdGF0dXMgMQpbICAgMjYuNzI3MzQ2XSB3bGFu
MDogYXV0aGVudGljYXRlZApbICAgMjYuNzU2MDc4XSB3bGFuMDogYXNzb2NpYXRlIHdpdGggM2M6
Y2U6NzM6NDg6MDQ6ODAgKHRyeSAxLzMpClsgICAyOC4xNDQzODldIHdsYW4wOiBhc3NvY2lhdGUg
d2l0aCAzYzpjZTo3Mzo0ODowNDo4MCAodHJ5IDIvMykKWyAgIDI4Ljc1OTY5NF0gd2xhbjA6IFJY
IEFzc29jUmVzcCBmcm9tIDNjOmNlOjczOjQ4OjA0OjgwIChjYXBhYj0weDQzMSBzdGF0dXM9MCBh
aWQ9MikKWyAgIDI4Ljc1OTgzMV0gd2xhbjA6IGFzc29jaWF0ZWQKWyAgIDI4Ljc1OTg0OF0gSVB2
NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IHdsYW4wOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAg
IDI4Ljc1OTk3MV0gY2ZnODAyMTE6IENhbGxpbmcgQ1JEQSBmb3IgY291bnRyeTogVFcKWyAgIDI4
Ljc2MDAwMV0gd2xhbjA6IGRlYXV0aGVudGljYXRlZCBmcm9tIDNjOmNlOjczOjQ4OjA0OjgwIChS
ZWFzb246IDIzPUlFRUU4MDIxWF9GQUlMRUQpClsgICAyOC43NjMxODBdIGF0aDogRUVQUk9NIHJl
Z2RvbWFpbjogMHg4MDllClsgICAyOC43NjMxODVdIGF0aDogRUVQUk9NIGluZGljYXRlcyB3ZSBz
aG91bGQgZXhwZWN0IGEgY291bnRyeSBjb2RlClsgICAyOC43NjMxODddIGF0aDogZG9pbmcgRUVQ
Uk9NIGNvdW50cnktPnJlZ2RtbiBtYXAgc2VhcmNoClsgICAyOC43NjMxODhdIGF0aDogY291bnRy
eSBtYXBzIHRvIHJlZ2RtbiBjb2RlOiAweDUwClsgICAyOC43NjMxOTBdIGF0aDogQ291bnRyeSBh
bHBoYTIgYmVpbmcgdXNlZDogVFcKWyAgIDI4Ljc2MzE5MV0gYXRoOiBSZWdwYWlyIHVzZWQ6IDB4
NTAKWyAgIDI4Ljc2MzE5M10gYXRoOiByZWdkb21haW4gMHg4MDllIGR5bmFtaWNhbGx5IHVwZGF0
ZWQgYnkgY291bnRyeSBJRQpbICAgMjguNzYzMjE2XSBjZmc4MDIxMTogUmVndWxhdG9yeSBkb21h
aW4gY2hhbmdlZCB0byBjb3VudHJ5OiBUVwpbICAgMjguNzYzMjE4XSBjZmc4MDIxMTogIERGUyBN
YXN0ZXIgcmVnaW9uOiB1bnNldApbICAgMjguNzYzMjE5XSBjZmc4MDIxMTogICAoc3RhcnRfZnJl
cSAtIGVuZF9mcmVxIEAgYmFuZHdpZHRoKSwgKG1heF9hbnRlbm5hX2dhaW4sIG1heF9laXJwKSwg
KGRmc19jYWNfdGltZSkKWyAgIDI4Ljc2MzIyMl0gY2ZnODAyMTE6ICAgKDI0MDIwMDAgS0h6IC0g
MjQ3MjAwMCBLSHogQCA0MDAwMCBLSHopLCAoMzAwIG1CaSwgMjcwMCBtQm0pLCAoTi9BKQpbICAg
MjguNzYzMjI0XSBjZmc4MDIxMTogICAoNTI3MDAwMCBLSHogLSA1MzMwMDAwIEtIeiBAIDQwMDAw
IEtIeiksICgzMDAgbUJpLCAxNzAwIG1CbSksICgwIHMpClsgICAyOC43NjMyMjZdIGNmZzgwMjEx
OiAgICg1NzM1MDAwIEtIeiAtIDU4MTUwMDAgS0h6IEAgNDAwMDAgS0h6KSwgKDMwMCBtQmksIDMw
MDAgbUJtKSwgKE4vQSkKWyAgIDI4Ljc4ODE0OF0gY2ZnODAyMTE6IENhbGxpbmcgQ1JEQSB0byB1
cGRhdGUgd29ybGQgcmVndWxhdG9yeSBkb21haW4KWyAgIDI4Ljc5MTAyM10gY2ZnODAyMTE6IFdv
cmxkIHJlZ3VsYXRvcnkgZG9tYWluIHVwZGF0ZWQ6ClsgICAyOC43OTEwMjhdIGNmZzgwMjExOiAg
REZTIE1hc3RlciByZWdpb246IHVuc2V0ClsgICAyOC43OTEwMzBdIGNmZzgwMjExOiAgIChzdGFy
dF9mcmVxIC0gZW5kX2ZyZXEgQCBiYW5kd2lkdGgpLCAobWF4X2FudGVubmFfZ2FpbiwgbWF4X2Vp
cnApLCAoZGZzX2NhY190aW1lKQpbICAgMjguNzkxMDMzXSBjZmc4MDIxMTogICAoMjQwMjAwMCBL
SHogLSAyNDcyMDAwIEtIeiBAIDQwMDAwIEtIeiksICgzMDAgbUJpLCAyMDAwIG1CbSksIChOL0Ep
ClsgICAyOC43OTEwMzVdIGNmZzgwMjExOiAgICgyNDU3MDAwIEtIeiAtIDI0ODIwMDAgS0h6IEAg
NDAwMDAgS0h6KSwgKDMwMCBtQmksIDIwMDAgbUJtKSwgKE4vQSkKWyAgIDI4Ljc5MTAzN10gY2Zn
ODAyMTE6ICAgKDI0NzQwMDAgS0h6IC0gMjQ5NDAwMCBLSHogQCAyMDAwMCBLSHopLCAoMzAwIG1C
aSwgMjAwMCBtQm0pLCAoTi9BKQpbICAgMjguNzkxMDM5XSBjZmc4MDIxMTogICAoNTE3MDAwMCBL
SHogLSA1MjUwMDAwIEtIeiBAIDQwMDAwIEtIeiksICgzMDAgbUJpLCAyMDAwIG1CbSksIChOL0Ep
ClsgICAyOC43OTEwNDFdIGNmZzgwMjExOiAgICg1NzM1MDAwIEtIeiAtIDU4MzUwMDAgS0h6IEAg
NDAwMDAgS0h6KSwgKDMwMCBtQmksIDIwMDAgbUJtKSwgKE4vQSkK
--f46d043c7e763fcaef05123a7dd4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--f46d043c7e763fcaef05123a7dd4--
