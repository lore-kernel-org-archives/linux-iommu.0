From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: PROBLEM: do_IRQ: [number] No irq handler for vector (irq -1)
Date: Thu, 16 Jan 2014 13:21:34 -0500
Message-ID: <20140116182134.GC9984@hmsreliant.think-freely.org>
References: <52D576E3.8050006@metrics.net>
	<1389844985.8705.45.camel@bling.home>
	<20140116121617.GA9984@hmsreliant.think-freely.org>
	<52D8120D.7090606@metrics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52D8120D.7090606-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anthony DeRobertis <aderobertis-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 16, 2014 at 12:08:29PM -0500, Anthony DeRobertis wrote:
> On 01/16/2014 07:16 AM, Neil Horman wrote:
> >Agreed, I'd like to see the full dmesg log from both a boot that has VT-D
> >enabled in the bios, and then again with it disabled in the bios.  I would also
> >be interested to know if enabling VT-D in the bios, and adding nointremap to the
> >kernel command line reproduces the problem.  What I read below indicates:
> Attached are the full dmesg (through boot, anyway) with it off an on
> in the BIOS. The "on" one is the current boot (which has my back-out
> patch applied, and is working fine...).
> 
> I assume you want me to test VT-d on in BIOS, without my back-out
> patch, and with the nointremap option? If so, I'll reboot to test
> that.

Yes, What I would like to see is your backout patch removed, and the the
following tests preformed:

1) VT-D off in bios 
2) VT-D on in bios and nointremap specified on the command line
3) VT-D on in bios and nointremap _not_ specified on the command line

If I could see the boot logs for all of those that would be helpful.  What would
be particularly helpful is to know if test (2) results in the problem
reproducing.  If it does that suggests our ability to disable interrupt
remapping in the kernel is somehow ineffective on your system.

Thanks
Neil

> [    0.000000] CPU0 microcode updated early to revision 0x19, date = 2013-06-21
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.13.0-rc8+ (anthony@Zia) (gcc version 4.8.2 (Debian 4.8.2-12) ) #1 SMP Mon Jan 13 13:06:25 EST 2014
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.13.0-rc8+ root=/dev/mapper/Zia-root ro verbose transparent_hugepage=always
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e2c00-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf797fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000bf798000-0x00000000bf7d9fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000bf7da000-0x00000000bfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000063fffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.5 present.
> [    0.000000] DMI: System manufacturer System Product Name/SABERTOOTH X58, BIOS 1402    08/09/2012
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] No AGP bridge found
> [    0.000000] e820: last_pfn = 0x640000 max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-DFFFF write-protect
> [    0.000000]   E0000-EBFFF write-through
> [    0.000000]   EC000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 000000000 mask C00000000 write-back
> [    0.000000]   1 base 400000000 mask E00000000 write-back
> [    0.000000]   2 base 600000000 mask FC0000000 write-back
> [    0.000000]   3 base 0C0000000 mask FC0000000 uncachable
> [    0.000000]   4 base 0BF800000 mask FFF800000 uncachable
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
> [    0.000000] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
> [    0.000000] e820: last_pfn = 0xbf780 max_arch_pfn = 0x400000000
> [    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [ffff8800000ff780]
> [    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> [    0.000000] BRK [0x01a9b000, 0x01a9bfff] PGTABLE
> [    0.000000] BRK [0x01a9c000, 0x01a9cfff] PGTABLE
> [    0.000000] BRK [0x01a9d000, 0x01a9dfff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x63fe00000-0x63fffffff]
> [    0.000000]  [mem 0x63fe00000-0x63fffffff] page 2M
> [    0.000000] BRK [0x01a9e000, 0x01a9efff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x63c000000-0x63fdfffff]
> [    0.000000]  [mem 0x63c000000-0x63fdfffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x600000000-0x63bffffff]
> [    0.000000]  [mem 0x600000000-0x63bffffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x00100000-0xbf77ffff]
> [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
> [    0.000000]  [mem 0x00200000-0xbf5fffff] page 2M
> [    0.000000]  [mem 0xbf600000-0xbf77ffff] page 4k
> [    0.000000] init_memory_mapping: [mem 0x100000000-0x5ffffffff]
> [    0.000000]  [mem 0x100000000-0x5ffffffff] page 2M
> [    0.000000] BRK [0x01a9f000, 0x01a9ffff] PGTABLE
> [    0.000000] BRK [0x01aa0000, 0x01aa0fff] PGTABLE
> [    0.000000] RAMDISK: [mem 0x362b2000-0x37150fff]
> [    0.000000] ACPI: RSDP 00000000000fb940 000024 (v02 ACPIAM)
> [    0.000000] ACPI: XSDT 00000000bf780100 000064 (v01 080912 XSDT1157 20120809 MSFT 00000097)
> [    0.000000] ACPI: FACP 00000000bf780290 0000F4 (v03 080912 FACP1157 20120809 MSFT 00000097)
> [    0.000000] ACPI: DSDT 00000000bf7804b0 00C469 (v01  A1682 A1682001 00000001 INTL 20060113)
> [    0.000000] ACPI: FACS 00000000bf798000 000040
> [    0.000000] ACPI: APIC 00000000bf780390 0000D8 (v01 080912 APIC1157 20120809 MSFT 00000097)
> [    0.000000] ACPI: MCFG 00000000bf780470 00003C (v01 080912 OEMMCFG  20120809 MSFT 00000097)
> [    0.000000] ACPI: OEMB 00000000bf798040 000072 (v01 080912 OEMB1157 20120809 MSFT 00000097)
> [    0.000000] ACPI: HPET 00000000bf78f4b0 000038 (v01 080912 OEMHPET  20120809 MSFT 00000097)
> [    0.000000] ACPI: ASPT 00000000bf798360 000034 (v06 080912 PerfTune 20120809 MSFT 00000097)
> [    0.000000] ACPI: OSFR 00000000bf78f4f0 0000B0 (v01 080912 OEMOSFR  20120809 MSFT 00000097)
> [    0.000000] ACPI: SSDT 00000000bf79a820 000363 (v01 DpgPmm    CpuPm 00000012 INTL 20060113)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000063fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x00000000-0x63fffffff]
> [    0.000000]   NODE_DATA [mem 0x63ffe6000-0x63ffeafff]
> [    0.000000]  [ffffea0000000000-ffffea0015dfffff] PMD -> [ffff880627600000-ffff88063c5fffff] on node 0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
> [    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
> [    0.000000]   Normal   [mem 0x100000000-0x63fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
> [    0.000000]   node   0: [mem 0x00100000-0xbf77ffff]
> [    0.000000]   node   0: [mem 0x100000000-0x63fffffff]
> [    0.000000] On node 0 totalpages: 6289181
> [    0.000000]   DMA zone: 56 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3997 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 10667 pages used for memmap
> [    0.000000]   DMA32 zone: 780160 pages, LIFO batch:31
> [    0.000000]   Normal zone: 75264 pages used for memmap
> [    0.000000]   Normal zone: 5505024 pages, LIFO batch:31
> [    0.000000] ACPI: PM-Timer IO Port: 0x808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)
> [    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec8a000] gsi_base[24])
> [    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec8a000, GSI 24-47
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ2 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
> [    0.000000] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
> [    0.000000] nr_irqs_gsi: 64
> [    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e2fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000e3000-0x000fffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf780000-0xbf797fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf798000-0xbf7d9fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf7da000-0xbfffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfedfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffdfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xffe00000-0xffffffff]
> [    0.000000] e820: [mem 0xc0000000-0xfedfffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:16 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88063fc00000 s85824 r8192 d20672 u131072
> [    0.000000] pcpu-alloc: s85824 r8192 d20672 u131072 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 6203173
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.13.0-rc8+ root=/dev/mapper/Zia-root ro verbose transparent_hugepage=always
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] Checking aperture...
> [    0.000000] No AGP bridge found
> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [    0.000000] Memory: 24718516K/25156724K available (4799K kernel code, 692K rwdata, 1592K rodata, 988K init, 952K bss, 438208K reserved)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=16.
> [    0.000000] NR_IRQS:33024 nr_irqs:1216 16
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] allocated 100663296 bytes of page_cgroup
> [    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
> [    0.000000] hpet clockevent registered
> [    0.000000] tsc: Fast TSC calibration failed
> [    0.008000] tsc: PIT calibration matches HPET. 1 loops
> [    0.008000] tsc: Detected 2806.429 MHz processor
> [    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 5612.85 BogoMIPS (lpj=11225716)
> [    0.000123] pid_max: default: 32768 minimum: 301
> [    0.000214] Security Framework initialized
> [    0.000274] AppArmor: AppArmor disabled by boot time parameter
> [    0.000334] Yama: becoming mindful.
> [    0.002282] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
> [    0.010408] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
> [    0.013786] Mount-cache hash table entries: 256
> [    0.014019] Initializing cgroup subsys memory
> [    0.014082] Initializing cgroup subsys devices
> [    0.014141] Initializing cgroup subsys freezer
> [    0.014200] Initializing cgroup subsys blkio
> [    0.014258] Initializing cgroup subsys perf_event
> [    0.014335] CPU: Physical Processor ID: 0
> [    0.014392] CPU: Processor Core ID: 0
> [    0.014453] mce: CPU supports 9 MCE banks
> [    0.014521] CPU0: Thermal monitoring enabled (TM1)
> [    0.014588] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
> [    0.014588] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
> [    0.014588] tlb_flushall_shift: 6
> [    0.014752] Freeing SMP alternatives memory: 20K (ffffffff819a6000 - ffffffff819ab000)
> [    0.015838] ACPI: Core revision 20131115
> [    0.019326] ACPI: All ACPI Tables successfully acquired
> [    0.063454] Switched APIC routing to physical flat.
> [    0.064022] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.103779] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz (fam: 06, model: 1a, stepping: 05)
> [    0.210022] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events, Intel PMU driver.
> [    0.210254] perf_event_intel: CPU erratum AAJ80 worked around
> [    0.210315] perf_event_intel: CPUID marked event: 'bus cycles' unavailable
> [    0.210379] ... version:                3
> [    0.210436] ... bit width:              48
> [    0.210494] ... generic registers:      4
> [    0.210551] ... value mask:             0000ffffffffffff
> [    0.210611] ... max period:             000000007fffffff
> [    0.210671] ... fixed-purpose events:   3
> [    0.210728] ... event mask:             000000070000000f
> [    0.211132] x86: Booting SMP configuration:
> [    0.221748] CPU1 microcode updated early to revision 0x19, date = 2013-06-21
> [    0.226142] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> [    0.236906] CPU2 microcode updated early to revision 0x19, date = 2013-06-21
> [    0.251246] CPU3 microcode updated early to revision 0x19, date = 2013-06-21
> [    0.211192] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
> [    0.315109] x86: Booted up 1 node, 8 CPUs
> [    0.315219] smpboot: Total of 8 processors activated (44902.86 BogoMIPS)
> [    0.319810] devtmpfs: initialized
> [    0.323612] PM: Registering ACPI NVS region [mem 0xbf798000-0xbf7d9fff] (270336 bytes)
> [    0.323837] NET: Registered protocol family 16
> [    0.323967] cpuidle: using governor ladder
> [    0.324025] cpuidle: using governor menu
> [    0.324103] ACPI: bus type PCI registered
> [    0.324161] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.324288] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    0.324368] PCI: not using MMCONFIG
> [    0.324425] PCI: Using configuration type 1 for base access
> [    0.328290] bio: create slab <bio-0> at 0
> [    0.328463] ACPI: Added _OSI(Module Device)
> [    0.328521] ACPI: Added _OSI(Processor Device)
> [    0.328580] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.328638] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.330317] ACPI: Executed 1 blocks of module-level executable AML code
> [    0.366096] ACPI: SSDT 00000000bf7983a0 001E1C (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
> [    0.366550] ACPI: Dynamic OEM Table Load:
> [    0.366681] ACPI: SSDT           (null) 001E1C (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
> [    0.366912] ACPI: SSDT 00000000bf79a1c0 000659 (v01  PmRef  P001Cst 00003001 INTL 20060113)
> [    0.367263] ACPI: Dynamic OEM Table Load:
> [    0.367395] ACPI: SSDT           (null) 000659 (v01  PmRef  P001Cst 00003001 INTL 20060113)
> [    0.367719] ACPI: Interpreter enabled
> [    0.367783] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20131115/hwxface-580)
> [    0.367945] ACPI: (supports S0 S1 S3 S4 S5)
> [    0.368003] ACPI: Using IOAPIC for interrupt routing
> [    0.368080] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    0.369019] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
> [    0.382810] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.383002] ACPI: No dock devices found.
> [    0.388966] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.389031] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.389112] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> [    0.389461] PCI host bridge to bus 0000:00
> [    0.389520] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.389580] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
> [    0.389642] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
> [    0.389703] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
> [    0.389766] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff]
> [    0.389828] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff]
> [    0.389891] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed8ffff]
> [    0.389962] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000
> [    0.390004] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [    0.390075] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
> [    0.390120] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    0.390165] pci 0000:00:01.0: System wakeup disabled by ACPI
> [    0.390251] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
> [    0.390295] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
> [    0.390339] pci 0000:00:02.0: System wakeup disabled by ACPI
> [    0.390424] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
> [    0.390468] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> [    0.390512] pci 0000:00:03.0: System wakeup disabled by ACPI
> [    0.390600] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
> [    0.390641] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
> [    0.390685] pci 0000:00:07.0: System wakeup disabled by ACPI
> [    0.390774] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
> [    0.392709] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
> [    0.392813] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
> [    0.392899] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
> [    0.392985] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
> [    0.393022] pci 0000:00:1a.0: reg 0x20: [io  0xa800-0xa81f]
> [    0.393111] pci 0000:00:1a.0: System wakeup disabled by ACPI
> [    0.393198] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
> [    0.393235] pci 0000:00:1a.1: reg 0x20: [io  0xa880-0xa89f]
> [    0.393317] pci 0000:00:1a.1: System wakeup disabled by ACPI
> [    0.393403] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
> [    0.393439] pci 0000:00:1a.2: reg 0x20: [io  0xac00-0xac1f]
> [    0.393520] pci 0000:00:1a.2: System wakeup disabled by ACPI
> [    0.393613] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
> [    0.393632] pci 0000:00:1a.7: reg 0x10: [mem 0xf9dff000-0xf9dff3ff]
> [    0.393711] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
> [    0.393758] pci 0000:00:1a.7: System wakeup disabled by ACPI
> [    0.393846] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300
> [    0.393859] pci 0000:00:1b.0: reg 0x10: [mem 0xf9df8000-0xf9dfbfff 64bit]
> [    0.393916] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.393983] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
> [    0.394041] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.394094] pci 0000:00:1c.0: System wakeup disabled by ACPI
> [    0.394182] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
> [    0.394241] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    0.394288] pci 0000:00:1c.4: System wakeup disabled by ACPI
> [    0.394375] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
> [    0.394411] pci 0000:00:1d.0: reg 0x20: [io  0xa080-0xa09f]
> [    0.394493] pci 0000:00:1d.0: System wakeup disabled by ACPI
> [    0.394579] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
> [    0.394616] pci 0000:00:1d.1: reg 0x20: [io  0xa400-0xa41f]
> [    0.394697] pci 0000:00:1d.1: System wakeup disabled by ACPI
> [    0.394783] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
> [    0.394819] pci 0000:00:1d.2: reg 0x20: [io  0xa480-0xa49f]
> [    0.394900] pci 0000:00:1d.2: System wakeup disabled by ACPI
> [    0.394995] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
> [    0.395013] pci 0000:00:1d.7: reg 0x10: [mem 0xf9dfe000-0xf9dfe3ff]
> [    0.395092] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> [    0.395138] pci 0000:00:1d.7: System wakeup disabled by ACPI
> [    0.395223] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
> [    0.395302] pci 0000:00:1e.0: System wakeup disabled by ACPI
> [    0.395389] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
> [    0.395458] pci 0000:00:1f.0: address space collision: [io  0x0800-0x087f] conflicts with ACPI CPU throttle [??? 0x00000810-0x00000815 flags 0x80000000]
> [    0.395548] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
> [    0.395612] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (mask 0003)
> [    0.395780] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
> [    0.395796] pci 0000:00:1f.2: reg 0x10: [io  0x9c00-0x9c07]
> [    0.395803] pci 0000:00:1f.2: reg 0x14: [io  0x9880-0x9883]
> [    0.395809] pci 0000:00:1f.2: reg 0x18: [io  0x9800-0x9807]
> [    0.395816] pci 0000:00:1f.2: reg 0x1c: [io  0x9480-0x9483]
> [    0.395822] pci 0000:00:1f.2: reg 0x20: [io  0x9400-0x941f]
> [    0.395829] pci 0000:00:1f.2: reg 0x24: [mem 0xf9dfc000-0xf9dfc7ff]
> [    0.395868] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.395936] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
> [    0.395949] pci 0000:00:1f.3: reg 0x10: [mem 0xf9dfd000-0xf9dfd0ff 64bit]
> [    0.395967] pci 0000:00:1f.3: reg 0x20: [io  0x1000-0x101f]
> [    0.396077] pci 0000:01:00.0: [1b4b:9123] type 00 class 0x010601
> [    0.396087] pci 0000:01:00.0: reg 0x10: [io  0xbc00-0xbc07]
> [    0.396093] pci 0000:01:00.0: reg 0x14: [io  0xb880-0xb883]
> [    0.396100] pci 0000:01:00.0: reg 0x18: [io  0xb800-0xb807]
> [    0.396106] pci 0000:01:00.0: reg 0x1c: [io  0xb480-0xb483]
> [    0.396112] pci 0000:01:00.0: reg 0x20: [io  0xb400-0xb40f]
> [    0.396119] pci 0000:01:00.0: reg 0x24: [mem 0xf9eff000-0xf9eff7ff]
> [    0.396125] pci 0000:01:00.0: reg 0x30: [mem 0xf9ee0000-0xf9eeffff pref]
> [    0.396153] pci 0000:01:00.0: PME# supported from D3hot
> [    0.402086] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.402150] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
> [    0.402156] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
> [    0.402207] pci 0000:02:00.0: [1033:0194] type 00 class 0x0c0330
> [    0.402222] pci 0000:02:00.0: reg 0x10: [mem 0xf9ffe000-0xf9ffffff 64bit]
> [    0.402292] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [    0.410107] pci 0000:00:02.0: PCI bridge to [bus 02]
> [    0.410177] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
> [    0.410238] pci 0000:03:00.0: [10de:0de0] type 00 class 0x030000
> [    0.410248] pci 0000:03:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
> [    0.410257] pci 0000:03:00.0: reg 0x14: [mem 0xd8000000-0xdfffffff 64bit pref]
> [    0.410266] pci 0000:03:00.0: reg 0x1c: [mem 0xd6000000-0xd7ffffff 64bit pref]
> [    0.410272] pci 0000:03:00.0: reg 0x24: [io  0xcc00-0xcc7f]
> [    0.410278] pci 0000:03:00.0: reg 0x30: [mem 0xfbc00000-0xfbc7ffff pref]
> [    0.410350] pci 0000:03:00.1: [10de:0bea] type 00 class 0x040300
> [    0.410358] pci 0000:03:00.1: reg 0x10: [mem 0xfbcfc000-0xfbcfffff]
> [    0.418116] pci 0000:00:03.0: PCI bridge to [bus 03]
> [    0.418184] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
> [    0.418186] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
> [    0.418190] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff 64bit pref]
> [    0.418237] pci 0000:00:07.0: PCI bridge to [bus 04]
> [    0.418342] pci 0000:00:1c.0: PCI bridge to [bus 06]
> [    0.418407] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff 64bit pref]
> [    0.418487] pci 0000:05:00.0: [197b:2362] type 00 class 0x010185
> [    0.418515] pci 0000:05:00.0: reg 0x10: [io  0xdc00-0xdc07]
> [    0.418527] pci 0000:05:00.0: reg 0x14: [io  0xd880-0xd883]
> [    0.418540] pci 0000:05:00.0: reg 0x18: [io  0xd800-0xd807]
> [    0.418552] pci 0000:05:00.0: reg 0x1c: [io  0xd480-0xd483]
> [    0.418565] pci 0000:05:00.0: reg 0x20: [io  0xd400-0xd40f]
> [    0.418577] pci 0000:05:00.0: reg 0x24: [mem 0xfbdff000-0xfbdff1ff]
> [    0.418590] pci 0000:05:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [    0.418640] pci 0000:05:00.0: PME# supported from D3hot
> [    0.426129] pci 0000:00:1c.4: PCI bridge to [bus 05]
> [    0.426196] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
> [    0.426200] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
> [    0.426255] pci 0000:07:01.0: [10ec:8167] type 00 class 0x020000
> [    0.426272] pci 0000:07:01.0: reg 0x10: [io  0xe800-0xe8ff]
> [    0.426281] pci 0000:07:01.0: reg 0x14: [mem 0xfbeff000-0xfbeff0ff]
> [    0.426316] pci 0000:07:01.0: reg 0x30: [mem 0xfbec0000-0xfbedffff pref]
> [    0.426349] pci 0000:07:01.0: supports D1 D2
> [    0.426350] pci 0000:07:01.0: PME# supported from D1 D2 D3hot D3cold
> [    0.426391] pci 0000:07:02.0: [1106:3044] type 00 class 0x0c0010
> [    0.426406] pci 0000:07:02.0: reg 0x10: [mem 0xfbefe000-0xfbefe7ff]
> [    0.426415] pci 0000:07:02.0: reg 0x14: [io  0xec00-0xec7f]
> [    0.426476] pci 0000:07:02.0: supports D2
> [    0.426477] pci 0000:07:02.0: PME# supported from D2 D3hot D3cold
> [    0.426534] pci 0000:00:1e.0: PCI bridge to [bus 07] (subtractive decode)
> [    0.426598] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
> [    0.426601] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
> [    0.426606] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
> [    0.426608] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
> [    0.426609] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
> [    0.426611] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff] (subtractive decode)
> [    0.426612] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff] (subtractive decode)
> [    0.426614] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff] (subtractive decode)
> [    0.427052] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12 14 15)
> [    0.427559] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 *10 11 12 14 15)
> [    0.428064] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12 *14 15)
> [    0.428569] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 6 7 10 11 12 14 15)
> [    0.429075] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 *15)
> [    0.429582] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14 15)
> [    0.430086] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *6 7 10 11 12 14 15)
> [    0.430596] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 *10 11 12 14 15)
> [    0.431139] ACPI: Enabled 3 GPEs in block 00 to 3F
> [    0.431277] ACPI: \_SB_.PCI0: notify handler is installed
> [    0.431307] Found 1 acpi root devices
> [    0.431378] vgaarb: device added: PCI:0000:03:00.0,decodes=io+mem,owns=io+mem,locks=none
> [    0.431457] vgaarb: loaded
> [    0.431511] vgaarb: bridge control possible 0000:03:00.0
> [    0.431601] PCI: Using ACPI for IRQ routing
> [    0.436874] PCI: Discovered peer bus ff
> [    0.436932] PCI: root bus ff: using default resources
> [    0.436933] PCI: Probing PCI hardware (bus ff)
> [    0.436950] PCI host bridge to bus 0000:ff
> [    0.437009] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
> [    0.437070] pci_bus 0000:ff: root bus resource [mem 0x00000000-0xfffffffff]
> [    0.437133] pci_bus 0000:ff: No busn resource found for root bus, will use [bus ff-ff]
> [    0.437213] pci 0000:ff:00.0: [8086:2c41] type 00 class 0x060000
> [    0.437244] pci 0000:ff:00.1: [8086:2c01] type 00 class 0x060000
> [    0.437274] pci 0000:ff:02.0: [8086:2c10] type 00 class 0x060000
> [    0.437302] pci 0000:ff:02.1: [8086:2c11] type 00 class 0x060000
> [    0.437331] pci 0000:ff:03.0: [8086:2c18] type 00 class 0x060000
> [    0.437359] pci 0000:ff:03.1: [8086:2c19] type 00 class 0x060000
> [    0.437388] pci 0000:ff:03.4: [8086:2c1c] type 00 class 0x060000
> [    0.437416] pci 0000:ff:04.0: [8086:2c20] type 00 class 0x060000
> [    0.437444] pci 0000:ff:04.1: [8086:2c21] type 00 class 0x060000
> [    0.437472] pci 0000:ff:04.2: [8086:2c22] type 00 class 0x060000
> [    0.437501] pci 0000:ff:04.3: [8086:2c23] type 00 class 0x060000
> [    0.437530] pci 0000:ff:05.0: [8086:2c28] type 00 class 0x060000
> [    0.437558] pci 0000:ff:05.1: [8086:2c29] type 00 class 0x060000
> [    0.437589] pci 0000:ff:05.2: [8086:2c2a] type 00 class 0x060000
> [    0.437618] pci 0000:ff:05.3: [8086:2c2b] type 00 class 0x060000
> [    0.437647] pci 0000:ff:06.0: [8086:2c30] type 00 class 0x060000
> [    0.437674] pci 0000:ff:06.1: [8086:2c31] type 00 class 0x060000
> [    0.437702] pci 0000:ff:06.2: [8086:2c32] type 00 class 0x060000
> [    0.437730] pci 0000:ff:06.3: [8086:2c33] type 00 class 0x060000
> [    0.437767] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
> [    0.437770] PCI: pci_cache_line_size set to 64 bytes
> [    0.437841] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
> [    0.437843] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
> [    0.437924] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
> [    0.437989] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [    0.438235] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
> [    0.440493] Switched to clocksource hpet
> [    0.443664] pnp: PnP ACPI init
> [    0.443730] ACPI: bus type PNP registered
> [    0.443843] system 00:00: [mem 0xfbf00000-0xfbffffff] has been reserved
> [    0.443906] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
> [    0.443969] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
> [    0.444031] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
> [    0.444094] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be reserved
> [    0.444156] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
> [    0.444219] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.444256] pnp 00:01: [dma 4]
> [    0.444271] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
> [    0.444296] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.444313] pnp 00:03: Plug and Play ACPI device, IDs PNP0800 (active)
> [    0.444334] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
> [    0.444411] system 00:05: [io  0x0290-0x029f] has been reserved
> [    0.444473] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.444658] system 00:06: [io  0x04d0-0x04d1] has been reserved
> [    0.444721] system 00:06: [io  0x0800-0x087f] could not be reserved
> [    0.444782] system 00:06: [io  0x0500-0x057f] could not be reserved
> [    0.444844] system 00:06: [io  0x0600-0x0607] has been reserved
> [    0.444906] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    0.444968] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.445030] system 00:06: [mem 0xfed40000-0xfed8ffff] has been reserved
> [    0.445092] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.445157] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
> [    0.445204] pnp 00:08: Plug and Play ACPI device, IDs INT0800 (active)
> [    0.445257] system 00:09: [mem 0xffc00000-0xffdfffff] has been reserved
> [    0.445320] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.445402] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    0.445465] system 00:0a: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.445528] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.445681] pnp 00:0b: [dma 0 disabled]
> [    0.445728] pnp 00:0b: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.445769] pnp 00:0c: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
> [    0.445829] system 00:0d: [mem 0xe0000000-0xefffffff] has been reserved
> [    0.445892] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.446044] system 00:0e: [mem 0x00000000-0x0009ffff] could not be reserved
> [    0.446107] system 00:0e: [mem 0x000c0000-0x000cffff] could not be reserved
> [    0.446170] system 00:0e: [mem 0x000e0000-0x000fffff] could not be reserved
> [    0.446233] system 00:0e: [mem 0x00100000-0xbfffffff] could not be reserved
> [    0.446296] system 00:0e: [mem 0xfed90000-0xffffffff] could not be reserved
> [    0.446359] system 00:0e: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.446457] pnp: PnP ACPI: found 15 devices
> [    0.446514] ACPI: bus type PNP unregistered
> [    0.452437] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 06] add_size 1000
> [    0.452439] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 06] add_size 400000
> [    0.452447] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x001fffff pref] to [bus 05] add_size 200000
> [    0.452459] pci 0000:00:1f.0: BAR 13: [io  0x0800-0x087f] has bogus alignment
> [    0.452527] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 400000
> [    0.452528] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x001fffff pref] get_res_add_size add_size 200000
> [    0.452530] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
> [    0.452533] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0000000-0xc03fffff]
> [    0.452596] pci 0000:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc06fffff pref]
> [    0.452673] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
> [    0.452735] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.452795] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
> [    0.452858] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
> [    0.452924] pci 0000:00:02.0: PCI bridge to [bus 02]
> [    0.452985] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
> [    0.453050] pci 0000:00:03.0: PCI bridge to [bus 03]
> [    0.453110] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
> [    0.453172] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
> [    0.453236] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff 64bit pref]
> [    0.453315] pci 0000:00:07.0: PCI bridge to [bus 04]
> [    0.453379] pci 0000:00:1c.0: PCI bridge to [bus 06]
> [    0.453439] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> [    0.453502] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc03fffff]
> [    0.453566] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff 64bit pref]
> [    0.453647] pci 0000:05:00.0: BAR 6: assigned [mem 0xc0400000-0xc040ffff pref]
> [    0.453723] pci 0000:00:1c.4: PCI bridge to [bus 05]
> [    0.453783] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
> [    0.453846] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
> [    0.453910] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc06fffff pref]
> [    0.453990] pci 0000:00:1e.0: PCI bridge to [bus 07]
> [    0.454049] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
> [    0.454113] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
> [    0.454180] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
> [    0.454181] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
> [    0.454183] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
> [    0.454184] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
> [    0.454186] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff]
> [    0.454187] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]
> [    0.454189] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
> [    0.454190] pci_bus 0000:01: resource 1 [mem 0xf9e00000-0xf9efffff]
> [    0.454192] pci_bus 0000:02: resource 1 [mem 0xf9f00000-0xf9ffffff]
> [    0.454193] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
> [    0.454195] pci_bus 0000:03: resource 1 [mem 0xfa000000-0xfbcfffff]
> [    0.454196] pci_bus 0000:03: resource 2 [mem 0xd6000000-0xdfffffff 64bit pref]
> [    0.454198] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
> [    0.454200] pci_bus 0000:06: resource 1 [mem 0xc0000000-0xc03fffff]
> [    0.454201] pci_bus 0000:06: resource 2 [mem 0xf8f00000-0xf8ffffff 64bit pref]
> [    0.454203] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
> [    0.454204] pci_bus 0000:05: resource 1 [mem 0xfbd00000-0xfbdfffff]
> [    0.454206] pci_bus 0000:05: resource 2 [mem 0xc0400000-0xc06fffff pref]
> [    0.454207] pci_bus 0000:07: resource 0 [io  0xe000-0xefff]
> [    0.454209] pci_bus 0000:07: resource 1 [mem 0xfbe00000-0xfbefffff]
> [    0.454210] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7]
> [    0.454212] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff]
> [    0.454213] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff]
> [    0.454215] pci_bus 0000:07: resource 7 [mem 0x000d0000-0x000dffff]
> [    0.454216] pci_bus 0000:07: resource 8 [mem 0xc0000000-0xdfffffff]
> [    0.454217] pci_bus 0000:07: resource 9 [mem 0xf0000000-0xfed8ffff]
> [    0.454220] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
> [    0.454222] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xfffffffff]
> [    0.454293] NET: Registered protocol family 2
> [    0.454610] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.455124] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [    0.455301] TCP: Hash tables configured (established 262144 bind 65536)
> [    0.455375] TCP: reno registered
> [    0.455457] UDP hash table entries: 16384 (order: 7, 524288 bytes)
> [    0.455621] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
> [    0.455838] NET: Registered protocol family 1
> [    0.459310] pci 0000:03:00.0: Boot video device
> [    0.459325] PCI: CLS mismatch (256 != 64), using 64 bytes
> [    0.459380] Unpacking initramfs...
> [    0.731380] Freeing initrd memory: 14972K (ffff8800362b2000 - ffff880037151000)
> [    0.731460] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.731522] software IO TLB [mem 0xbb780000-0xbf780000] (64MB) mapped at [ffff8800bb780000-ffff8800bf77ffff]
> [    0.731833] microcode: CPU0 sig=0x106a5, pf=0x2, revision=0x19
> [    0.731897] microcode: CPU1 sig=0x106a5, pf=0x2, revision=0x19
> [    0.731962] microcode: CPU2 sig=0x106a5, pf=0x2, revision=0x19
> [    0.732027] microcode: CPU3 sig=0x106a5, pf=0x2, revision=0x19
> [    0.732092] microcode: CPU4 sig=0x106a5, pf=0x2, revision=0x19
> [    0.732157] microcode: CPU5 sig=0x106a5, pf=0x2, revision=0x19
> [    0.732220] microcode: CPU6 sig=0x106a5, pf=0x2, revision=0x19
> [    0.732285] microcode: CPU7 sig=0x106a5, pf=0x2, revision=0x19
> [    0.732380] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
> [    0.732758] audit: initializing netlink socket (disabled)
> [    0.732825] type=2000 audit(1389638541.592:1): initialized
> [    0.747480] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    0.748301] VFS: Disk quotas dquot_6.5.2
> [    0.748386] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.748515] msgmni has been set to 32768
> [    0.749973] alg: No test for stdrng (krng)
> [    0.750051] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
> [    0.750162] io scheduler noop registered
> [    0.750219] io scheduler deadline registered
> [    0.750299] io scheduler cfq registered (default)
> [    0.750527] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
> [    0.750710] pcieport 0000:00:1c.0: irq 64 for MSI/MSI-X
> [    0.750851] pcieport 0000:00:1c.4: irq 65 for MSI/MSI-X
> [    0.750913] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    0.750983] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    0.751064] intel_idle: MWAIT substates: 0x1120
> [    0.751072] intel_idle: v0.4 model 0x1A
> [    0.751073] intel_idle: lapic_timer_reliable_states 0x2
> [    0.751234] GHES: HEST is not enabled!
> [    0.751330] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.775175] 00:0b: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    0.775570] Linux agpgart interface v0.103
> [    0.775723] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> [    0.775785] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> [    0.776346] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.776479] mousedev: PS/2 mouse device common for all mice
> [    0.776569] rtc_cmos 00:02: RTC can wake from S4
> [    0.776733] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
> [    0.776815] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    0.776899] AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> [    0.776961] AMD IOMMUv2 functionality not available on this system
> [    0.777093] TCP: cubic registered
> [    0.778630] NET: Registered protocol family 10
> [    0.779444] mip6: Mobile IPv6
> [    0.779501] NET: Registered protocol family 17
> [    0.779560] mpls_gso: MPLS GSO support
> [    0.779955] registered taskstats version 1
> [    0.781236] rtc_cmos 00:02: setting system clock to 2014-01-13 18:42:22 UTC (1389638542)
> [    0.781331] PM: Hibernation image not present or could not be loaded.
> [    0.782387] Freeing unused kernel memory: 988K (ffffffff818af000 - ffffffff819a6000)
> [    0.782465] Write protecting the kernel read-only data: 8192k
> [    0.785651] Freeing unused kernel memory: 1332K (ffff8800014b3000 - ffff880001600000)
> [    0.786939] Freeing unused kernel memory: 456K (ffff88000178e000 - ffff880001800000)
> [    0.801349] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    0.849653] systemd-udevd[95]: starting version 204
> [    0.870471] ACPI: bus type USB registered
> [    0.870549] usbcore: registered new interface driver usbfs
> [    0.870614] usbcore: registered new interface driver hub
> [    0.870974] SCSI subsystem initialized
> [    0.873746] usbcore: registered new device driver usb
> [    0.873907] libata version 3.00 loaded.
> [    0.874181] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    0.874621] uhci_hcd: USB Universal Host Controller Interface driver
> [    0.874850] uhci_hcd 0000:00:1a.0: UHCI Host Controller
> [    0.874853] xhci_hcd 0000:02:00.0: xHCI Host Controller
> [    0.874859] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
> [    0.874990] xhci_hcd 0000:02:00.0: irq 66 for MSI/MSI-X
> [    0.874996] xhci_hcd 0000:02:00.0: irq 67 for MSI/MSI-X
> [    0.875002] xhci_hcd 0000:02:00.0: irq 68 for MSI/MSI-X
> [    0.875008] xhci_hcd 0000:02:00.0: irq 69 for MSI/MSI-X
> [    0.875013] xhci_hcd 0000:02:00.0: irq 70 for MSI/MSI-X
> [    0.875018] xhci_hcd 0000:02:00.0: irq 71 for MSI/MSI-X
> [    0.875024] xhci_hcd 0000:02:00.0: irq 72 for MSI/MSI-X
> [    0.875030] xhci_hcd 0000:02:00.0: irq 73 for MSI/MSI-X
> [    0.875063] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 2
> [    0.875156] ehci-pci: EHCI PCI platform driver
> [    0.875163] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    0.875165] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.875166] usb usb1: Product: xHCI Host Controller
> [    0.875167] usb usb1: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
> [    0.875168] usb usb1: SerialNumber: 0000:02:00.0
> [    0.875180] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a800
> [    0.875328] hub 1-0:1.0: USB hub found
> [    0.875337] hub 1-0:1.0: 2 ports detected
> [    0.875430] xhci_hcd 0000:02:00.0: xHCI Host Controller
> [    0.875434] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 3
> [    0.876662] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.876727] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.876804] usb usb2: Product: UHCI Host Controller
> [    0.876864] usb usb2: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.876925] usb usb2: SerialNumber: 0000:00:1a.0
> [    0.877660] hub 2-0:1.0: USB hub found
> [    0.877727] hub 2-0:1.0: 2 ports detected
> [    0.878118] uhci_hcd 0000:00:1a.1: UHCI Host Controller
> [    0.878182] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
> [    0.878290] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
> [    0.878391] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.878455] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.878538] usb usb4: Product: UHCI Host Controller
> [    0.878598] usb usb4: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.878660] usb usb4: SerialNumber: 0000:00:1a.1
> [    0.878827] hub 4-0:1.0: USB hub found
> [    0.878894] hub 4-0:1.0: 2 ports detected
> [    0.879054] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003
> [    0.879120] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.879154] uhci_hcd 0000:00:1a.2: UHCI Host Controller
> [    0.879258] usb usb3: Product: xHCI Host Controller
> [    0.879319] usb usb3: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
> [    0.879382] usb usb3: SerialNumber: 0000:02:00.0
> [    0.879539] hub 3-0:1.0: USB hub found
> [    0.879608] hub 3-0:1.0: 2 ports detected
> [    0.879857] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
> [    0.879968] uhci_hcd 0000:00:1a.2: irq 19, io base 0x0000ac00
> [    0.880079] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.880144] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.880225] usb usb5: Product: UHCI Host Controller
> [    0.880289] usb usb5: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.880355] usb usb5: SerialNumber: 0000:00:1a.2
> [    0.880880] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    0.881011] r8169 0000:07:01.0 (unregistered net_device): not PCI Express
> [    0.881174] hub 5-0:1.0: USB hub found
> [    0.881244] hub 5-0:1.0: 2 ports detected
> [    0.881333] r8169 0000:07:01.0 eth0: RTL8169sc/8110sc at 0xffffc90003040000, 54:04:a6:49:30:b0, XID 18000000 IRQ 19
> [    0.881418] r8169 0000:07:01.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
> [    0.881507] uhci_hcd 0000:00:1d.0: UHCI Host Controller
> [    0.881576] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
> [    0.881686] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a080
> [    0.881795] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.881862] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.881942] usb usb6: Product: UHCI Host Controller
> [    0.882004] usb usb6: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.882068] usb usb6: SerialNumber: 0000:00:1d.0
> [    0.882235] hub 6-0:1.0: USB hub found
> [    0.882358] hub 6-0:1.0: 2 ports detected
> [    0.882571] uhci_hcd 0000:00:1d.1: UHCI Host Controller
> [    0.882639] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
> [    0.882738] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
> [    0.882829] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.882892] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.882969] usb usb7: Product: UHCI Host Controller
> [    0.883032] usb usb7: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.883096] usb usb7: SerialNumber: 0000:00:1d.1
> [    0.883252] hub 7-0:1.0: USB hub found
> [    0.883318] hub 7-0:1.0: 2 ports detected
> [    0.883807] ehci-pci 0000:00:1a.7: EHCI Host Controller
> [    0.883873] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 8
> [    0.883963] ehci-pci 0000:00:1a.7: debug port 1
> [    0.887915] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
> [    0.887921] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9dff000
> [    0.896701] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
> [    0.896789] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
> [    0.896852] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.896929] usb usb8: Product: EHCI Host Controller
> [    0.896989] usb usb8: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
> [    0.897050] usb usb8: SerialNumber: 0000:00:1a.7
> [    0.897203] hub 8-0:1.0: USB hub found
> [    0.897265] hub 8-0:1.0: 6 ports detected
> [    0.920854] hub 2-0:1.0: USB hub found
> [    0.920918] hub 2-0:1.0: 2 ports detected
> [    0.944839] hub 4-0:1.0: USB hub found
> [    0.944909] hub 4-0:1.0: 2 ports detected
> [    0.952836] firewire_ohci 0000:07:02.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x11
> [    0.968937] hub 5-0:1.0: USB hub found
> [    0.969000] hub 5-0:1.0: 2 ports detected
> [    0.969339] ehci-pci 0000:00:1d.7: EHCI Host Controller
> [    0.969403] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 9
> [    0.969488] ehci-pci 0000:00:1d.7: debug port 1
> [    0.973451] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
> [    0.973459] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9dfe000
> [    0.984891] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> [    0.984994] usb usb9: New USB device found, idVendor=1d6b, idProduct=0002
> [    0.985063] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.985139] usb usb9: Product: EHCI Host Controller
> [    0.985198] usb usb9: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
> [    0.985259] usb usb9: SerialNumber: 0000:00:1d.7
> [    0.985559] hub 9-0:1.0: USB hub found
> [    0.985626] hub 9-0:1.0: 6 ports detected
> [    1.008858] hub 6-0:1.0: USB hub found
> [    1.008928] hub 6-0:1.0: 2 ports detected
> [    1.032916] hub 7-0:1.0: USB hub found
> [    1.032981] hub 7-0:1.0: 2 ports detected
> [    1.034350] ahci 0000:00:1f.2: version 3.0
> [    1.034519] ahci 0000:00:1f.2: irq 74 for MSI/MSI-X
> [    1.034584] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
> [    1.034664] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ccc ems sxs 
> [    1.073365] scsi0 : ahci
> [    1.074147] scsi1 : ahci
> [    1.074398] scsi2 : ahci
> [    1.074658] scsi3 : ahci
> [    1.074884] scsi4 : ahci
> [    1.075139] scsi5 : ahci
> [    1.075258] ata1: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc100 irq 74
> [    1.075339] ata2: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc180 irq 74
> [    1.075416] ata3: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc200 irq 74
> [    1.075493] ata4: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc280 irq 74
> [    1.075570] ata5: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc300 irq 74
> [    1.075647] ata6: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc380 irq 74
> [    1.075798] ahci 0000:01:00.0: irq 75 for MSI/MSI-X
> [    1.075810] ahci 0000:01:00.0: controller can do FBS, turning on CAP_FBS
> [    1.075881] uhci_hcd 0000:00:1d.2: UHCI Host Controller
> [    1.075947] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 10
> [    1.076046] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a480
> [    1.076143] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001
> [    1.076207] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.076284] usb usb10: Product: UHCI Host Controller
> [    1.076344] usb usb10: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    1.076405] usb usb10: SerialNumber: 0000:00:1d.2
> [    1.076601] hub 10-0:1.0: USB hub found
> [    1.076665] hub 10-0:1.0: 2 ports detected
> [    1.092851] ahci 0000:01:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> [    1.092936] ahci 0000:01:00.0: flags: 64bit ncq fbs pio 
> [    1.093740] scsi6 : ahci
> [    1.094057] scsi7 : ahci
> [    1.094320] scsi8 : ahci
> [    1.094581] scsi9 : ahci
> [    1.094843] scsi10 : ahci
> [    1.095133] scsi11 : ahci
> [    1.095388] scsi12 : ahci
> [    1.095623] scsi13 : ahci
> [    1.095730] ata7: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff100 irq 75
> [    1.095810] ata8: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff180 irq 75
> [    1.095887] ata9: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff200 irq 75
> [    1.095964] ata10: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff280 irq 75
> [    1.096041] ata11: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff300 irq 75
> [    1.096118] ata12: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff380 irq 75
> [    1.096195] ata13: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff400 irq 75
> [    1.096272] ata14: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff480 irq 75
> [    1.096462] ahci 0000:05:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
> [    1.096541] ahci 0000:05:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
> [    1.096856] scsi14 : ahci
> [    1.097115] scsi15 : ahci
> [    1.097232] ata15: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff100 irq 16
> [    1.097313] ata16: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff180 irq 16
> [    1.412916] ata8: SATA link down (SStatus 0 SControl 300)
> [    1.413001] ata9: SATA link down (SStatus 0 SControl 300)
> [    1.416958] ata10: SATA link down (SStatus 0 SControl 300)
> [    1.417039] ata12: SATA link down (SStatus 0 SControl 300)
> [    1.417054] ata16: SATA link down (SStatus 0 SControl 300)
> [    1.417176] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.417255] ata11: SATA link down (SStatus 0 SControl 300)
> [    1.417362] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
> [    1.417648] ata14.00: configured for UDMA/66
> [    1.420870] ata13: SATA link down (SStatus 0 SControl 300)
> [    1.420883] ata15: SATA link down (SStatus 0 SControl 300)
> [    1.424964] ata7: SATA link down (SStatus 0 SControl 300)
> [    1.454190] firewire_core 0000:07:02.0: created device fw0: GUID 001fc600001acd8c, S400
> [    1.565063] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.565144] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.565218] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.565291] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.565363] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.565434] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.566336] ata3.00: ATA-8: ST31000528AS, CC38, max UDMA/133
> [    1.566410] ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.566494] ata6.00: ATA-8: ST31000528AS, CC38, max UDMA/133
> [    1.566556] ata6.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.566666] ata1.00: ATA-8: ST31000528AS, CC38, max UDMA/133
> [    1.566728] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.566796] ata4.00: ATA-8: ST31000528AS, CC38, max UDMA/133
> [    1.566859] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.566930] ata5.00: ATA-8: ST31000340AS, SD15, max UDMA/133
> [    1.566992] ata5.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.567713] ata2.00: ATAPI: TSSTcorpCD/DVDW SH-S183L, SB01, max UDMA/33
> [    1.567790] ata2.00: applying bridge limits
> [    1.568102] ata3.00: configured for UDMA/133
> [    1.568269] ata6.00: configured for UDMA/133
> [    1.570063] ata1.00: configured for UDMA/133
> [    1.570211] ata4.00: configured for UDMA/133
> [    1.570435] scsi 0:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
> [    1.570584] ata5.00: configured for UDMA/133
> [    1.572710] ata2.00: configured for UDMA/33
> [    1.574865] scsi 1:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183L SB01 PQ: 0 ANSI: 5
> [    1.575517] scsi 2:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
> [    1.575957] scsi 3:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
> [    1.576488] scsi 4:0:0:0: Direct-Access     ATA      ST31000340AS     SD15 PQ: 0 ANSI: 5
> [    1.576820] scsi 5:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
> [    1.577616] scsi 13:0:0:0: Processor         Marvell  91xx Config      1.01 PQ: 0 ANSI: 5
> [    1.583764] scsi 0:0:0:0: Attached scsi generic sg0 type 0
> [    1.583854] sr 1:0:0:0: Attached scsi generic sg1 type 5
> [    1.583938] scsi 2:0:0:0: Attached scsi generic sg2 type 0
> [    1.584056] scsi 3:0:0:0: Attached scsi generic sg3 type 0
> [    1.584162] scsi 4:0:0:0: Attached scsi generic sg4 type 0
> [    1.584258] scsi 5:0:0:0: Attached scsi generic sg5 type 0
> [    1.584356] scsi 13:0:0:0: Attached scsi generic sg6 type 3
> [    1.584583] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.584738] sd 0:0:0:0: [sda] Write Protect is off
> [    1.584799] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.584828] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.588821] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
> [    1.588909] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    1.589043] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [    1.589170] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.589179] sd 3:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.589208] sd 4:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.589226] sd 3:0:0:0: [sdc] Write Protect is off
> [    1.589227] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    1.589232] sd 5:0:0:0: [sde] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.589270] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.589281] sd 4:0:0:0: [sdd] Write Protect is off
> [    1.589283] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [    1.589317] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.589328] sd 5:0:0:0: [sde] Write Protect is off
> [    1.589330] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
> [    1.589354] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.589973] sd 2:0:0:0: [sdb] Write Protect is off
> [    1.590035] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    1.590062] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.594912]  sda: sda1 sda2 sda3
> [    1.595522] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.596944]  sde: sde1 sde2 sde3
> [    1.597674] sd 5:0:0:0: [sde] Attached SCSI disk
> [    1.597871]  sdc: sdc1 sdc2 sdc3
> [    1.598533] sd 3:0:0:0: [sdc] Attached SCSI disk
> [    1.598642]  sdd: sdd1 sdd2 sdd3
> [    1.599462] sd 4:0:0:0: [sdd] Attached SCSI disk
> [    1.603289]  sdb: sdb1 sdb2 sdb3
> [    1.603968] sd 2:0:0:0: [sdb] Attached SCSI disk
> [    1.728936] tsc: Refined TSC clocksource calibration: 2806.363 MHz
> [    1.797109] usb 10-1: new low-speed USB device number 2 using uhci_hcd
> [    1.862619] random: nonblocking pool is initialized
> [    1.974452] usb 10-1: New USB device found, idVendor=046d, idProduct=c01e
> [    1.974521] usb 10-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    1.974602] usb 10-1: Product: USB-PS/2 Optical Mouse
> [    1.974661] usb 10-1: Manufacturer: Logitech
> [    1.980969] hidraw: raw HID events driver (C) Jiri Kosina
> [    1.997580] usbcore: registered new interface driver usbhid
> [    1.997644] usbhid: USB HID core driver
> [    2.001421] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:1d.2/usb10/10-1/10-1:1.0/input/input1
> [    2.001597] hid-generic 0003:046D:C01E.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-1/input0
> [    2.054534] md: md127 stopped.
> [    2.057251] md: bind<sdc3>
> [    2.057496] md: bind<sdb3>
> [    2.057900] md: bind<sdd3>
> [    2.058172] md: bind<sde3>
> [    2.069225] md: bind<sda3>
> [    2.070712] md: raid10 personality registered for level 10
> [    2.071529] md/raid10:md127: active with 4 out of 4 devices
> [    2.071736] created bitmap (466 pages) for device md127
> [    2.112065] md127: bitmap initialized from disk: read 30 pages, set 0 of 953616 bits
> [    2.139112] md127: detected capacity change from 0 to 1999877701632
> [    2.139234] RAID10 conf printout:
> [    2.139235]  --- wd:4 rd:4
> [    2.139237]  disk 0, wo:0, o:1, dev:sda3
> [    2.139238]  disk 1, wo:0, o:1, dev:sdc3
> [    2.139240]  disk 2, wo:0, o:1, dev:sdb3
> [    2.139241]  disk 3, wo:0, o:1, dev:sdd3
> [    2.140652]  md127: unknown partition table
> [    2.175795] device-mapper: uevent: version 1.0.3
> [    2.175915] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> [    2.217251] usb 10-2: new low-speed USB device number 3 using uhci_hcd
> [    2.310294] bio: create slab <bio-1> at 1
> [    2.375244] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
> [    2.522645] usb 10-2: New USB device found, idVendor=051d, idProduct=0002
> [    2.522714] usb 10-2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> [    2.522794] usb 10-2: Product: Back-UPS RS 1500 FW:8.g9 .D USB FW:g9 
> [    2.522856] usb 10-2: Manufacturer: American Power Conversion
> [    2.522916] usb 10-2: SerialNumber: JB0539032829  
> [    2.731242] Switched to clocksource tsc
> [    3.593537] hid-generic 0003:051D:0002.0002: hiddev0,hidraw1: USB HID v1.10 Device [American Power Conversion Back-UPS RS 1500 FW:8.g9 .D USB FW:g9 ] on usb-0000:00:1d.2-2/input0
> [   13.839354] systemd-udevd[625]: starting version 204
> [   14.427591] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
> [   14.427673] ACPI: Power Button [PWRB]
> [   14.427763] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [   14.427840] ACPI: Power Button [PWRF]
> [   14.439625] ATK0110 ATK0110:00: Overriding interface detection
> [   14.460048] wmi: Mapper loaded
> [   14.464721] EDAC MC: Ver: 3.0.0
> [   14.477876] EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:ff:03.0 (POLLED)
> [   14.478006] EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)
> [   14.478097] EDAC i7core: Driver loaded, 1 memory controller(s) found.
> [   14.489458] systemd-udevd[686]: renamed network interface eth0 to lan
> [   14.501227] ACPI Warning: 0x0000000000000828-0x000000000000082f SystemIO conflicts with Region \PMRG 1 (20131115/utaddress-251)
> [   14.501388] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   14.501470] ACPI Warning: 0x0000000000000530-0x000000000000053f SystemIO conflicts with Region \GPS0 1 (20131115/utaddress-251)
> [   14.501627] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   14.501707] ACPI Warning: 0x0000000000000500-0x000000000000052f SystemIO conflicts with Region \GPS0 1 (20131115/utaddress-251)
> [   14.501864] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   14.501944] lpc_ich: Resource conflict(s) found affecting gpio_ich
> [   14.511300] [drm] Initialized drm 1.1.0 20060810
> [   14.536083] ACPI Warning: 0x0000000000001000-0x000000000000101f SystemIO conflicts with Region \SMRG 1 (20131115/utaddress-251)
> [   14.536244] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   14.555738] input: PC Speaker as /devices/platform/pcspkr/input/input4
> [   14.635305] iTCO_vendor_support: vendor-support=0
> [   14.680094] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
> [   14.680175] iTCO_wdt: Found a ICH10R TCO device (Version=2, TCOBASE=0x0860)
> [   14.680314] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=1)
> [   14.705616] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
> [   14.871767] nouveau: unknown parameter 'perflvl_wr' ignored
> [   14.871980] MXM: GUID detected in BIOS
> [   14.872267] nouveau  [  DEVICE][0000:03:00.0] BOOT0  : 0x0c1000a1
> [   14.872329] nouveau  [  DEVICE][0000:03:00.0] Chipset: GF108 (NVC1)
> [   14.872390] nouveau  [  DEVICE][0000:03:00.0] Family : NVC0
> [   14.873338] nouveau  [   VBIOS][0000:03:00.0] checking PRAMIN for image...
> [   14.892345] md: bind<sde1>
> [   14.938280] nouveau  [   VBIOS][0000:03:00.0] ... appears to be valid
> [   14.938344] nouveau  [   VBIOS][0000:03:00.0] using image from PRAMIN
> [   14.938506] nouveau  [   VBIOS][0000:03:00.0] BIT signature found
> [   14.938568] nouveau  [   VBIOS][0000:03:00.0] version 70.08.4d.00.00
> [   14.938844] nouveau 0000:03:00.0: irq 76 for MSI/MSI-X
> [   14.938852] nouveau  [     PMC][0000:03:00.0] MSI interrupts enabled
> [   14.938940] nouveau W[     PFB][0000:03:00.0][0x00000000][ffff88061d590000] reclocking of this ram type unsupported
> [   14.939052] nouveau  [     PFB][0000:03:00.0] RAM type: DDR3
> [   14.939139] nouveau  [     PFB][0000:03:00.0] RAM size: 512 MiB
> [   14.939227] nouveau  [     PFB][0000:03:00.0]    ZCOMP: 0 tags
> [   14.943231] snd_hda_intel 0000:00:1b.0: irq 77 for MSI/MSI-X
> [   14.947573] md: bind<sdc1>
> [   14.970337] nouveau  [  PTHERM][0000:03:00.0] FAN control: none / external
> [   14.970435] nouveau  [  PTHERM][0000:03:00.0] fan management: automatic
> [   14.970527] nouveau  [  PTHERM][0000:03:00.0] internal sensor: yes
> [   14.970641] nouveau  [     CLK][0000:03:00.0] 03: core 50 MHz memory 135 MHz 
> [   14.970733] nouveau  [     CLK][0000:03:00.0] 07: core 405 MHz memory 324 MHz 
> [   14.970840] nouveau  [     CLK][0000:03:00.0] 0f: core 810 MHz memory 900 MHz 
> [   14.971088] nouveau  [     CLK][0000:03:00.0] --: core 405 MHz memory 324 MHz 
> [   14.979269] [TTM] Zone  kernel: Available graphics memory: 12368142 kiB
> [   14.979359] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
> [   14.979448] [TTM] Initializing pool allocator
> [   14.979535] [TTM] Initializing DMA pool allocator
> [   14.979626] nouveau  [     DRM] VRAM: 512 MiB
> [   14.979712] nouveau  [     DRM] GART: 1048576 MiB
> [   14.979799] nouveau  [     DRM] TMDS table version 2.0
> [   14.979887] nouveau  [     DRM] DCB version 4.0
> [   14.979973] nouveau  [     DRM] DCB outp 00: 01000302 00020030
> [   14.980061] nouveau  [     DRM] DCB outp 01: 02000300 00000000
> [   14.980149] nouveau  [     DRM] DCB outp 02: 08011392 00020020
> [   14.980237] nouveau  [     DRM] DCB outp 03: 04022310 00000000
> [   14.980325] nouveau  [     DRM] DCB conn 00: 00001030
> [   14.980474] nouveau  [     DRM] DCB conn 01: 00002161
> [   14.980623] nouveau  [     DRM] DCB conn 02: 00000200
> [   14.981610] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   14.981700] [drm] No driver support for vblank timestamp query.
> [   14.996303] nouveau  [     DRM] MM: using COPY0 for buffer copies
> [   15.005413] md: bind<sdd1>
> [   15.008206] md: bind<sdb1>
> [   15.043483] input: HDA Intel Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
> [   15.043641] input: HDA Intel Line Out Side as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
> [   15.043787] input: HDA Intel Line Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
> [   15.043937] input: HDA Intel Line Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
> [   15.044083] input: HDA Intel Line Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
> [   15.044227] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
> [   15.044372] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
> [   15.044514] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
> [   15.090263] nouveau  [     DRM] allocated 1024x768 fb: 0x60000, bo ffff88061fbc5c00
> [   15.090414] fbcon: nouveaufb (fb0) is primary device
> [   15.096053] md: bind<sda1>
> [   15.142331] md: raid1 personality registered for level 1
> [   15.142630] md/raid1:md0: active with 5 out of 5 mirrors
> [   15.142756] created bitmap (16 pages) for device md0
> [   15.143289] md0: bitmap initialized from disk: read 2 pages, set 0 of 32096 bits
> [   15.158765] md0: detected capacity change from 0 to 131465216
> [   15.158830] RAID1 conf printout:
> [   15.158831]  --- wd:5 rd:5
> [   15.158832]  disk 0, wo:0, o:1, dev:sda1
> [   15.158834]  disk 1, wo:0, o:1, dev:sdc1
> [   15.158835]  disk 2, wo:0, o:1, dev:sdb1
> [   15.158836]  disk 3, wo:0, o:1, dev:sdd1
> [   15.158838]  disk 4, wo:0, o:1, dev:sde1
> [   15.161088]  md0: unknown partition table
> [   15.169957] Console: switching to colour frame buffer device 128x48
> [   15.171037] nouveau 0000:03:00.0: fb0: nouveaufb frame buffer device
> [   15.171049] nouveau 0000:03:00.0: registered panic notifier
> [   15.171065] [drm] Initialized nouveau 1.1.1 20120801 for 0000:03:00.0 on minor 0
> [   15.171158] hda_intel: Disabling MSI
> [   15.171178] hda-intel 0000:03:00.1: Handle VGA-switcheroo audio client
> [   15.985619] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/0000:03:00.1/sound/card1/input16
> [   15.985855] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/0000:03:00.1/sound/card1/input15
> [   15.986079] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/0000:03:00.1/sound/card1/input14
> [   15.986309] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/0000:03:00.1/sound/card1/input13
> [   16.618195] EXT4-fs (dm-0): re-mounted. Opts: (null)
> [   16.967621] RAID10 conf printout:
> [   16.967627]  --- wd:4 rd:4
> [   16.967631]  disk 0, wo:0, o:1, dev:sda3
> [   16.967634]  disk 1, wo:0, o:1, dev:sdc3
> [   16.967637]  disk 2, wo:0, o:1, dev:sdb3
> [   16.967640]  disk 3, wo:0, o:1, dev:sdd3
> [   17.082706] EXT4-fs (dm-0): re-mounted. Opts: user_xattr,errors=remount-ro
> [   17.492574] loop: module loaded
> [   18.896517] Adding 5857276k swap on /dev/mapper/Zia-swap_crypt.  Priority:-1 extents:1 across:5857276k 
> [   20.012569] EXT4-fs (md0): mounting ext2 file system using the ext4 subsystem
> [   20.059635] EXT4-fs (md0): mounted filesystem without journal. Opts: (null)
> [   20.128415] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: user_xattr
> [   20.135680] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: user_xattr
> [   20.244279] FAT-fs (sda2): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
> [   20.333238] FAT-fs (sdc2): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
> [   20.388560] FAT-fs (sdb2): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
> [   20.444331] FAT-fs (sdd2): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
> [   21.412118] Bridge firewalling registered
> [   21.415269] device lan entered promiscuous mode
> [   21.427959] r8169 0000:07:01.0 lan: link down
> [   21.427971] r8169 0000:07:01.0 lan: link down
> [   21.428481] IPv6: ADDRCONF(NETDEV_UP): lan: link is not ready
> [   21.430800] IPv6: ADDRCONF(NETDEV_UP): br0: link is not ready
> [   24.341372] r8169 0000:07:01.0 lan: link up
> [   24.341629] IPv6: ADDRCONF(NETDEV_CHANGE): lan: link becomes ready
> [   24.342533] br0: port 1(lan) entered forwarding state
> [   24.343999] br0: port 1(lan) entered forwarding state
> [   24.345446] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
> [   25.473310] RPC: Registered named UNIX socket transport module.
> [   25.473448] RPC: Registered udp transport module.
> [   25.473595] RPC: Registered tcp transport module.
> [   25.474057] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [   25.489622] FS-Cache: Loaded
> [   25.517937] FS-Cache: Netfs 'nfs' registered for caching
> [   25.565226] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
> [   26.137517] tun: Universal TUN/TAP device driver, 1.6
> [   26.137660] tun: (C) 1999-2004 Max Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
> [   26.344703] br0: port 1(lan) entered forwarding state
> [   37.114777] CacheFiles: Loaded
> [   38.078498] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> [   38.085722] NFSD: starting 90-second grace period (net ffffffff81885e00)
> [   38.947421] lp: driver loaded but no devices found
> [   38.968982] ppdev: user-space parallel port driver

> [    0.000000] CPU0 microcode updated early to revision 0x19, date = 2013-06-21
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.13.0-rc8+ (anthony@Zia) (gcc version 4.8.2 (Debian 4.8.2-12) ) #5 SMP Mon Jan 13 16:59:58 EST 2014
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.13.0-rc8+ root=/dev/mapper/Zia-root ro verbose transparent_hugepage=always
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e2c00-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf797fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000bf798000-0x00000000bf7d9fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000bf7da000-0x00000000bfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000063fffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.5 present.
> [    0.000000] DMI: System manufacturer System Product Name/SABERTOOTH X58, BIOS 1402    08/09/2012
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] No AGP bridge found
> [    0.000000] e820: last_pfn = 0x640000 max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-DFFFF write-protect
> [    0.000000]   E0000-EBFFF write-through
> [    0.000000]   EC000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 000000000 mask C00000000 write-back
> [    0.000000]   1 base 400000000 mask E00000000 write-back
> [    0.000000]   2 base 600000000 mask FC0000000 write-back
> [    0.000000]   3 base 0C0000000 mask FC0000000 uncachable
> [    0.000000]   4 base 0BF800000 mask FFF800000 uncachable
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
> [    0.000000] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
> [    0.000000] e820: last_pfn = 0xbf780 max_arch_pfn = 0x400000000
> [    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [ffff8800000ff780]
> [    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> [    0.000000] BRK [0x01a9b000, 0x01a9bfff] PGTABLE
> [    0.000000] BRK [0x01a9c000, 0x01a9cfff] PGTABLE
> [    0.000000] BRK [0x01a9d000, 0x01a9dfff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x63fe00000-0x63fffffff]
> [    0.000000]  [mem 0x63fe00000-0x63fffffff] page 2M
> [    0.000000] BRK [0x01a9e000, 0x01a9efff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x63c000000-0x63fdfffff]
> [    0.000000]  [mem 0x63c000000-0x63fdfffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x600000000-0x63bffffff]
> [    0.000000]  [mem 0x600000000-0x63bffffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x00100000-0xbf77ffff]
> [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
> [    0.000000]  [mem 0x00200000-0xbf5fffff] page 2M
> [    0.000000]  [mem 0xbf600000-0xbf77ffff] page 4k
> [    0.000000] init_memory_mapping: [mem 0x100000000-0x5ffffffff]
> [    0.000000]  [mem 0x100000000-0x5ffffffff] page 2M
> [    0.000000] BRK [0x01a9f000, 0x01a9ffff] PGTABLE
> [    0.000000] BRK [0x01aa0000, 0x01aa0fff] PGTABLE
> [    0.000000] RAMDISK: [mem 0x362b4000-0x37151fff]
> [    0.000000] ACPI: RSDP 00000000000fb940 000024 (v02 ACPIAM)
> [    0.000000] ACPI: XSDT 00000000bf780100 00006C (v01 080912 XSDT1157 20120809 MSFT 00000097)
> [    0.000000] ACPI: FACP 00000000bf780290 0000F4 (v03 080912 FACP1157 20120809 MSFT 00000097)
> [    0.000000] ACPI: DSDT 00000000bf7804b0 00C469 (v01  A1682 A1682001 00000001 INTL 20060113)
> [    0.000000] ACPI: FACS 00000000bf798000 000040
> [    0.000000] ACPI: APIC 00000000bf780390 0000D8 (v01 080912 APIC1157 20120809 MSFT 00000097)
> [    0.000000] ACPI: MCFG 00000000bf780470 00003C (v01 080912 OEMMCFG  20120809 MSFT 00000097)
> [    0.000000] ACPI: OEMB 00000000bf798040 000072 (v01 080912 OEMB1157 20120809 MSFT 00000097)
> [    0.000000] ACPI: HPET 00000000bf78f4b0 000038 (v01 080912 OEMHPET  20120809 MSFT 00000097)
> [    0.000000] ACPI: DMAR 00000000bf7980c0 000140 (v01    AMI  OEMDMAR 00000001 MSFT 00000097)
> [    0.000000] ACPI: ASPT 00000000bf7984b0 000034 (v06 080912 PerfTune 20120809 MSFT 00000097)
> [    0.000000] ACPI: OSFR 00000000bf78f4f0 0000B0 (v01 080912 OEMOSFR  20120809 MSFT 00000097)
> [    0.000000] ACPI: SSDT 00000000bf79a970 000363 (v01 DpgPmm    CpuPm 00000012 INTL 20060113)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000063fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x00000000-0x63fffffff]
> [    0.000000]   NODE_DATA [mem 0x63ffe6000-0x63ffeafff]
> [    0.000000]  [ffffea0000000000-ffffea0015dfffff] PMD -> [ffff880627600000-ffff88063c5fffff] on node 0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
> [    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
> [    0.000000]   Normal   [mem 0x100000000-0x63fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
> [    0.000000]   node   0: [mem 0x00100000-0xbf77ffff]
> [    0.000000]   node   0: [mem 0x100000000-0x63fffffff]
> [    0.000000] On node 0 totalpages: 6289181
> [    0.000000]   DMA zone: 56 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3997 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 10667 pages used for memmap
> [    0.000000]   DMA32 zone: 780160 pages, LIFO batch:31
> [    0.000000]   Normal zone: 75264 pages used for memmap
> [    0.000000]   Normal zone: 5505024 pages, LIFO batch:31
> [    0.000000] ACPI: PM-Timer IO Port: 0x808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)
> [    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec8a000] gsi_base[24])
> [    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec8a000, GSI 24-47
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ2 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
> [    0.000000] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
> [    0.000000] nr_irqs_gsi: 64
> [    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e2fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000e3000-0x000fffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf780000-0xbf797fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf798000-0xbf7d9fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf7da000-0xbfffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfedfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffdfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xffe00000-0xffffffff]
> [    0.000000] e820: [mem 0xc0000000-0xfedfffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:16 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88063fc00000 s85824 r8192 d20672 u131072
> [    0.000000] pcpu-alloc: s85824 r8192 d20672 u131072 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 6203173
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.13.0-rc8+ root=/dev/mapper/Zia-root ro verbose transparent_hugepage=always
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] Checking aperture...
> [    0.000000] No AGP bridge found
> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [    0.000000] Memory: 24718520K/25156724K available (4799K kernel code, 692K rwdata, 1592K rodata, 988K init, 952K bss, 438204K reserved)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=16.
> [    0.000000] NR_IRQS:33024 nr_irqs:1216 16
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] allocated 100663296 bytes of page_cgroup
> [    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
> [    0.000000] hpet clockevent registered
> [    0.000000] tsc: Fast TSC calibration failed
> [    0.016000] tsc: Unable to calibrate against PIT
> [    0.016000] tsc: using HPET reference calibration
> [    0.016000] tsc: Detected 2806.296 MHz processor
> [    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 5612.59 BogoMIPS (lpj=11225184)
> [    0.000125] pid_max: default: 32768 minimum: 301
> [    0.000218] Security Framework initialized
> [    0.000279] AppArmor: AppArmor disabled by boot time parameter
> [    0.000340] Yama: becoming mindful.
> [    0.002290] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
> [    0.008543] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
> [    0.013895] Mount-cache hash table entries: 256
> [    0.014116] Initializing cgroup subsys memory
> [    0.014179] Initializing cgroup subsys devices
> [    0.014239] Initializing cgroup subsys freezer
> [    0.014299] Initializing cgroup subsys blkio
> [    0.014358] Initializing cgroup subsys perf_event
> [    0.014435] CPU: Physical Processor ID: 0
> [    0.014494] CPU: Processor Core ID: 0
> [    0.014555] mce: CPU supports 9 MCE banks
> [    0.014623] CPU0: Thermal monitoring enabled (TM1)
> [    0.014692] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
> [    0.014692] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
> [    0.014692] tlb_flushall_shift: 6
> [    0.014858] Freeing SMP alternatives memory: 20K (ffffffff819a6000 - ffffffff819ab000)
> [    0.015945] ACPI: Core revision 20131115
> [    0.019435] ACPI: All ACPI Tables successfully acquired
> [    0.063692] dmar: Host address width 39
> [    0.063753] dmar: DRHD base: 0x000000fbfff000 flags: 0x0
> [    0.063820] dmar: IOMMU 0: reg_base_addr fbfff000 ver 1:0 cap c9008010e60262 ecap f0207a
> [    0.063900] dmar: DRHD base: 0x000000fbffe000 flags: 0x1
> [    0.063965] dmar: IOMMU 1: reg_base_addr fbffe000 ver 1:0 cap c90780106f0462 ecap f020fe
> [    0.064045] dmar: RMRR base: 0x000000000ec000 end: 0x000000000effff
> [    0.064108] dmar: RMRR base: 0x000000bf7ea000 end: 0x000000bf7fffff
> [    0.064171] dmar: ATSR flags: 0x0
> [    0.064324] This system BIOS has enabled interrupt remapping
> [    0.064324] on a chipset that contains an erratum making that
> [    0.064324] feature unstable.  To maintain system stability
> [    0.064324] interrupt remapping is being disabled.  Please
> [    0.064324] contact your BIOS vendor for an update
> [    0.064324] Ignoring and leaving enabled anyway!
> [    0.064500] IOAPIC id 8 under DRHD base  0xfbffe000 IOMMU 1
> [    0.064562] IOAPIC id 9 under DRHD base  0xfbffe000 IOMMU 1
> [    0.064800] Enabled IRQ remapping in xapic mode
> [    0.064862] Switched APIC routing to physical flat.
> [    0.065480] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.105236] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz (fam: 06, model: 1a, stepping: 05)
> [    0.213081] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events, Intel PMU driver.
> [    0.213315] perf_event_intel: CPU erratum AAJ80 worked around
> [    0.213377] perf_event_intel: CPUID marked event: 'bus cycles' unavailable
> [    0.213442] ... version:                3
> [    0.213501] ... bit width:              48
> [    0.213559] ... generic registers:      4
> [    0.213618] ... value mask:             0000ffffffffffff
> [    0.213678] ... max period:             000000007fffffff
> [    0.213739] ... fixed-purpose events:   3
> [    0.213797] ... event mask:             000000070000000f
> [    0.214203] x86: Booting SMP configuration:
> [    0.228684] CPU1 microcode updated early to revision 0x19, date = 2013-06-21
> [    0.230877] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> [    0.246258] CPU2 microcode updated early to revision 0x19, date = 2013-06-21
> [    0.262803] CPU3 microcode updated early to revision 0x19, date = 2013-06-21
> [    0.214264] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
> [    0.323264] x86: Booted up 1 node, 8 CPUs
> [    0.323376] smpboot: Total of 8 processors activated (44900.73 BogoMIPS)
> [    0.329758] devtmpfs: initialized
> [    0.333261] PM: Registering ACPI NVS region [mem 0xbf798000-0xbf7d9fff] (270336 bytes)
> [    0.333489] NET: Registered protocol family 16
> [    0.333619] cpuidle: using governor ladder
> [    0.333678] cpuidle: using governor menu
> [    0.333758] ACPI: bus type PCI registered
> [    0.333816] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.333946] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    0.334028] PCI: not using MMCONFIG
> [    0.334086] PCI: Using configuration type 1 for base access
> [    0.334869] bio: create slab <bio-0> at 0
> [    0.335037] ACPI: Added _OSI(Module Device)
> [    0.335097] ACPI: Added _OSI(Processor Device)
> [    0.335155] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.335215] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.336890] ACPI: Executed 1 blocks of module-level executable AML code
> [    0.369156] ACPI: SSDT 00000000bf7984f0 001E1C (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
> [    0.369601] ACPI: Dynamic OEM Table Load:
> [    0.369733] ACPI: SSDT           (null) 001E1C (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
> [    0.369960] ACPI: SSDT 00000000bf79a310 000659 (v01  PmRef  P001Cst 00003001 INTL 20060113)
> [    0.370313] ACPI: Dynamic OEM Table Load:
> [    0.370446] ACPI: SSDT           (null) 000659 (v01  PmRef  P001Cst 00003001 INTL 20060113)
> [    0.370768] ACPI: Interpreter enabled
> [    0.370833] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20131115/hwxface-580)
> [    0.370997] ACPI: (supports S0 S1 S3 S4 S5)
> [    0.371056] ACPI: Using IOAPIC for interrupt routing
> [    0.371133] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    0.372067] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
> [    0.386010] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.386201] ACPI: No dock devices found.
> [    0.394051] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.394118] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.394201] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> [    0.394556] PCI host bridge to bus 0000:00
> [    0.394616] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.394678] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
> [    0.394740] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
> [    0.394802] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
> [    0.394866] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff]
> [    0.394930] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff]
> [    0.394993] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed8ffff]
> [    0.395065] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000
> [    0.395108] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [    0.395176] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
> [    0.395220] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    0.395265] pci 0000:00:01.0: System wakeup disabled by ACPI
> [    0.395352] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
> [    0.395396] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
> [    0.395440] pci 0000:00:02.0: System wakeup disabled by ACPI
> [    0.395526] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
> [    0.395570] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> [    0.395614] pci 0000:00:03.0: System wakeup disabled by ACPI
> [    0.395704] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
> [    0.395744] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
> [    0.395788] pci 0000:00:07.0: System wakeup disabled by ACPI
> [    0.395879] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
> [    0.395969] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
> [    0.396058] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
> [    0.396144] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
> [    0.396230] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
> [    0.396267] pci 0000:00:1a.0: reg 0x20: [io  0xa800-0xa81f]
> [    0.396349] pci 0000:00:1a.0: System wakeup disabled by ACPI
> [    0.396436] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
> [    0.396475] pci 0000:00:1a.1: reg 0x20: [io  0xa880-0xa89f]
> [    0.396559] pci 0000:00:1a.1: System wakeup disabled by ACPI
> [    0.396646] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
> [    0.396682] pci 0000:00:1a.2: reg 0x20: [io  0xac00-0xac1f]
> [    0.396763] pci 0000:00:1a.2: System wakeup disabled by ACPI
> [    0.396857] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
> [    0.396876] pci 0000:00:1a.7: reg 0x10: [mem 0xf9dff000-0xf9dff3ff]
> [    0.396954] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
> [    0.397001] pci 0000:00:1a.7: System wakeup disabled by ACPI
> [    0.397090] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300
> [    0.397103] pci 0000:00:1b.0: reg 0x10: [mem 0xf9df8000-0xf9dfbfff 64bit]
> [    0.397163] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.397231] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
> [    0.397289] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.397336] pci 0000:00:1c.0: System wakeup disabled by ACPI
> [    0.397425] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
> [    0.397483] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    0.397529] pci 0000:00:1c.4: System wakeup disabled by ACPI
> [    0.397618] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
> [    0.397654] pci 0000:00:1d.0: reg 0x20: [io  0xa080-0xa09f]
> [    0.397736] pci 0000:00:1d.0: System wakeup disabled by ACPI
> [    0.397824] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
> [    0.397860] pci 0000:00:1d.1: reg 0x20: [io  0xa400-0xa41f]
> [    0.397941] pci 0000:00:1d.1: System wakeup disabled by ACPI
> [    0.398028] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
> [    0.398065] pci 0000:00:1d.2: reg 0x20: [io  0xa480-0xa49f]
> [    0.398146] pci 0000:00:1d.2: System wakeup disabled by ACPI
> [    0.398240] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
> [    0.398259] pci 0000:00:1d.7: reg 0x10: [mem 0xf9dfe000-0xf9dfe3ff]
> [    0.398337] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> [    0.398384] pci 0000:00:1d.7: System wakeup disabled by ACPI
> [    0.398469] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
> [    0.398548] pci 0000:00:1e.0: System wakeup disabled by ACPI
> [    0.398636] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
> [    0.398704] pci 0000:00:1f.0: address space collision: [io  0x0800-0x087f] conflicts with ACPI CPU throttle [??? 0x00000810-0x00000815 flags 0x80000000]
> [    0.398796] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
> [    0.398861] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (mask 0003)
> [    0.399031] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
> [    0.399047] pci 0000:00:1f.2: reg 0x10: [io  0x9c00-0x9c07]
> [    0.399054] pci 0000:00:1f.2: reg 0x14: [io  0x9880-0x9883]
> [    0.399060] pci 0000:00:1f.2: reg 0x18: [io  0x9800-0x9807]
> [    0.399067] pci 0000:00:1f.2: reg 0x1c: [io  0x9480-0x9483]
> [    0.399073] pci 0000:00:1f.2: reg 0x20: [io  0x9400-0x941f]
> [    0.399080] pci 0000:00:1f.2: reg 0x24: [mem 0xf9dfc000-0xf9dfc7ff]
> [    0.399119] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.399185] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
> [    0.399198] pci 0000:00:1f.3: reg 0x10: [mem 0xf9dfd000-0xf9dfd0ff 64bit]
> [    0.399216] pci 0000:00:1f.3: reg 0x20: [io  0x1000-0x101f]
> [    0.399325] pci 0000:01:00.0: [1b4b:9123] type 00 class 0x010601
> [    0.399334] pci 0000:01:00.0: reg 0x10: [io  0xbc00-0xbc07]
> [    0.399340] pci 0000:01:00.0: reg 0x14: [io  0xb880-0xb883]
> [    0.399347] pci 0000:01:00.0: reg 0x18: [io  0xb800-0xb807]
> [    0.399353] pci 0000:01:00.0: reg 0x1c: [io  0xb480-0xb483]
> [    0.399359] pci 0000:01:00.0: reg 0x20: [io  0xb400-0xb40f]
> [    0.399366] pci 0000:01:00.0: reg 0x24: [mem 0xf9eff000-0xf9eff7ff]
> [    0.399373] pci 0000:01:00.0: reg 0x30: [mem 0xf9ee0000-0xf9eeffff pref]
> [    0.399400] pci 0000:01:00.0: PME# supported from D3hot
> [    0.405140] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.405207] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
> [    0.405209] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
> [    0.405259] pci 0000:02:00.0: [1033:0194] type 00 class 0x0c0330
> [    0.405274] pci 0000:02:00.0: reg 0x10: [mem 0xf9ffe000-0xf9ffffff 64bit]
> [    0.405345] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [    0.413158] pci 0000:00:02.0: PCI bridge to [bus 02]
> [    0.413229] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
> [    0.413290] pci 0000:03:00.0: [10de:0de0] type 00 class 0x030000
> [    0.413299] pci 0000:03:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
> [    0.413308] pci 0000:03:00.0: reg 0x14: [mem 0xd8000000-0xdfffffff 64bit pref]
> [    0.413317] pci 0000:03:00.0: reg 0x1c: [mem 0xd6000000-0xd7ffffff 64bit pref]
> [    0.413323] pci 0000:03:00.0: reg 0x24: [io  0xcc00-0xcc7f]
> [    0.413330] pci 0000:03:00.0: reg 0x30: [mem 0xfbc00000-0xfbc7ffff pref]
> [    0.413400] pci 0000:03:00.1: [10de:0bea] type 00 class 0x040300
> [    0.413409] pci 0000:03:00.1: reg 0x10: [mem 0xfbcfc000-0xfbcfffff]
> [    0.421156] pci 0000:00:03.0: PCI bridge to [bus 03]
> [    0.421222] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
> [    0.421228] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
> [    0.421232] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff 64bit pref]
> [    0.421267] pci 0000:00:07.0: PCI bridge to [bus 04]
> [    0.421372] pci 0000:00:1c.0: PCI bridge to [bus 06]
> [    0.421439] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff 64bit pref]
> [    0.421518] pci 0000:05:00.0: [197b:2362] type 00 class 0x010185
> [    0.421545] pci 0000:05:00.0: reg 0x10: [io  0xdc00-0xdc07]
> [    0.421558] pci 0000:05:00.0: reg 0x14: [io  0xd880-0xd883]
> [    0.421570] pci 0000:05:00.0: reg 0x18: [io  0xd800-0xd807]
> [    0.421583] pci 0000:05:00.0: reg 0x1c: [io  0xd480-0xd483]
> [    0.421595] pci 0000:05:00.0: reg 0x20: [io  0xd400-0xd40f]
> [    0.421608] pci 0000:05:00.0: reg 0x24: [mem 0xfbdff000-0xfbdff1ff]
> [    0.421621] pci 0000:05:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [    0.421669] pci 0000:05:00.0: PME# supported from D3hot
> [    0.429177] pci 0000:00:1c.4: PCI bridge to [bus 05]
> [    0.429247] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
> [    0.429250] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
> [    0.429303] pci 0000:07:01.0: [10ec:8167] type 00 class 0x020000
> [    0.429321] pci 0000:07:01.0: reg 0x10: [io  0xe800-0xe8ff]
> [    0.429329] pci 0000:07:01.0: reg 0x14: [mem 0xfbeff000-0xfbeff0ff]
> [    0.429364] pci 0000:07:01.0: reg 0x30: [mem 0xfbec0000-0xfbedffff pref]
> [    0.429397] pci 0000:07:01.0: supports D1 D2
> [    0.429399] pci 0000:07:01.0: PME# supported from D1 D2 D3hot D3cold
> [    0.429440] pci 0000:07:02.0: [1106:3044] type 00 class 0x0c0010
> [    0.429455] pci 0000:07:02.0: reg 0x10: [mem 0xfbefe000-0xfbefe7ff]
> [    0.429464] pci 0000:07:02.0: reg 0x14: [io  0xec00-0xec7f]
> [    0.429525] pci 0000:07:02.0: supports D2
> [    0.429527] pci 0000:07:02.0: PME# supported from D2 D3hot D3cold
> [    0.429583] pci 0000:00:1e.0: PCI bridge to [bus 07] (subtractive decode)
> [    0.429648] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
> [    0.429651] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
> [    0.429656] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
> [    0.429657] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
> [    0.429659] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
> [    0.429661] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff] (subtractive decode)
> [    0.429662] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff] (subtractive decode)
> [    0.429664] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff] (subtractive decode)
> [    0.430102] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12 14 15)
> [    0.430611] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 *10 11 12 14 15)
> [    0.431120] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12 *14 15)
> [    0.431628] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 6 7 10 11 12 14 15)
> [    0.432135] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 *15)
> [    0.432644] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14 15)
> [    0.433152] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *6 7 10 11 12 14 15)
> [    0.433663] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 *10 11 12 14 15)
> [    0.434208] ACPI: Enabled 3 GPEs in block 00 to 3F
> [    0.434347] ACPI: \_SB_.PCI0: notify handler is installed
> [    0.434378] Found 1 acpi root devices
> [    0.434448] vgaarb: device added: PCI:0000:03:00.0,decodes=io+mem,owns=io+mem,locks=none
> [    0.434527] vgaarb: loaded
> [    0.434583] vgaarb: bridge control possible 0000:03:00.0
> [    0.434673] PCI: Using ACPI for IRQ routing
> [    0.441771] PCI: Discovered peer bus ff
> [    0.441832] PCI: root bus ff: using default resources
> [    0.441833] PCI: Probing PCI hardware (bus ff)
> [    0.441861] PCI host bridge to bus 0000:ff
> [    0.441921] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
> [    0.441983] pci_bus 0000:ff: root bus resource [mem 0x00000000-0xfffffffff]
> [    0.442047] pci_bus 0000:ff: No busn resource found for root bus, will use [bus ff-ff]
> [    0.442130] pci 0000:ff:00.0: [8086:2c41] type 00 class 0x060000
> [    0.442166] pci 0000:ff:00.1: [8086:2c01] type 00 class 0x060000
> [    0.442196] pci 0000:ff:02.0: [8086:2c10] type 00 class 0x060000
> [    0.442224] pci 0000:ff:02.1: [8086:2c11] type 00 class 0x060000
> [    0.442254] pci 0000:ff:03.0: [8086:2c18] type 00 class 0x060000
> [    0.442282] pci 0000:ff:03.1: [8086:2c19] type 00 class 0x060000
> [    0.442310] pci 0000:ff:03.4: [8086:2c1c] type 00 class 0x060000
> [    0.442339] pci 0000:ff:04.0: [8086:2c20] type 00 class 0x060000
> [    0.442368] pci 0000:ff:04.1: [8086:2c21] type 00 class 0x060000
> [    0.442396] pci 0000:ff:04.2: [8086:2c22] type 00 class 0x060000
> [    0.442424] pci 0000:ff:04.3: [8086:2c23] type 00 class 0x060000
> [    0.442453] pci 0000:ff:05.0: [8086:2c28] type 00 class 0x060000
> [    0.442481] pci 0000:ff:05.1: [8086:2c29] type 00 class 0x060000
> [    0.442514] pci 0000:ff:05.2: [8086:2c2a] type 00 class 0x060000
> [    0.442541] pci 0000:ff:05.3: [8086:2c2b] type 00 class 0x060000
> [    0.442570] pci 0000:ff:06.0: [8086:2c30] type 00 class 0x060000
> [    0.442598] pci 0000:ff:06.1: [8086:2c31] type 00 class 0x060000
> [    0.442625] pci 0000:ff:06.2: [8086:2c32] type 00 class 0x060000
> [    0.442653] pci 0000:ff:06.3: [8086:2c33] type 00 class 0x060000
> [    0.442689] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
> [    0.442693] PCI: pci_cache_line_size set to 64 bytes
> [    0.442765] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
> [    0.442767] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
> [    0.442855] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
> [    0.442921] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [    0.443167] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
> [    0.447119] Switched to clocksource hpet
> [    0.448454] pnp: PnP ACPI init
> [    0.448523] ACPI: bus type PNP registered
> [    0.448633] system 00:00: [mem 0xfbf00000-0xfbffffff] could not be reserved
> [    0.448698] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
> [    0.448761] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
> [    0.448824] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
> [    0.448888] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be reserved
> [    0.448951] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
> [    0.449015] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.449053] pnp 00:01: [dma 4]
> [    0.449067] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
> [    0.449095] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.449111] pnp 00:03: Plug and Play ACPI device, IDs PNP0800 (active)
> [    0.449134] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
> [    0.449219] system 00:05: [io  0x0290-0x029f] has been reserved
> [    0.449282] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.449459] system 00:06: [io  0x04d0-0x04d1] has been reserved
> [    0.449522] system 00:06: [io  0x0800-0x087f] could not be reserved
> [    0.449585] system 00:06: [io  0x0500-0x057f] could not be reserved
> [    0.449648] system 00:06: [io  0x0600-0x0607] has been reserved
> [    0.449710] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    0.449773] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.449837] system 00:06: [mem 0xfed40000-0xfed8ffff] has been reserved
> [    0.449900] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.449965] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
> [    0.450013] pnp 00:08: Plug and Play ACPI device, IDs INT0800 (active)
> [    0.450065] system 00:09: [mem 0xffc00000-0xffdfffff] has been reserved
> [    0.450130] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.450210] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    0.450275] system 00:0a: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.450338] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.450493] pnp 00:0b: [dma 0 disabled]
> [    0.450540] pnp 00:0b: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.450582] pnp 00:0c: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
> [    0.450642] system 00:0d: [mem 0xe0000000-0xefffffff] has been reserved
> [    0.450706] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.450857] system 00:0e: [mem 0x00000000-0x0009ffff] could not be reserved
> [    0.450922] system 00:0e: [mem 0x000c0000-0x000cffff] could not be reserved
> [    0.450986] system 00:0e: [mem 0x000e0000-0x000fffff] could not be reserved
> [    0.451050] system 00:0e: [mem 0x00100000-0xbfffffff] could not be reserved
> [    0.451114] system 00:0e: [mem 0xfed90000-0xffffffff] could not be reserved
> [    0.451183] system 00:0e: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.451281] pnp: PnP ACPI: found 15 devices
> [    0.451340] ACPI: bus type PNP unregistered
> [    0.458308] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 06] add_size 1000
> [    0.458312] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 06] add_size 400000
> [    0.458320] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x001fffff pref] to [bus 05] add_size 200000
> [    0.458334] pci 0000:00:1f.0: BAR 13: [io  0x0800-0x087f] has bogus alignment
> [    0.458400] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 400000
> [    0.458402] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x001fffff pref] get_res_add_size add_size 200000
> [    0.458404] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
> [    0.458407] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0000000-0xc03fffff]
> [    0.458471] pci 0000:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc06fffff pref]
> [    0.458550] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
> [    0.458613] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.458674] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
> [    0.458738] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
> [    0.458805] pci 0000:00:02.0: PCI bridge to [bus 02]
> [    0.458866] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
> [    0.458933] pci 0000:00:03.0: PCI bridge to [bus 03]
> [    0.458994] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
> [    0.459058] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
> [    0.459131] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff 64bit pref]
> [    0.459213] pci 0000:00:07.0: PCI bridge to [bus 04]
> [    0.459278] pci 0000:00:1c.0: PCI bridge to [bus 06]
> [    0.459339] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> [    0.459403] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc03fffff]
> [    0.459468] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff 64bit pref]
> [    0.459550] pci 0000:05:00.0: BAR 6: assigned [mem 0xc0400000-0xc040ffff pref]
> [    0.459628] pci 0000:00:1c.4: PCI bridge to [bus 05]
> [    0.459689] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
> [    0.459753] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
> [    0.459818] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc06fffff pref]
> [    0.459899] pci 0000:00:1e.0: PCI bridge to [bus 07]
> [    0.459960] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
> [    0.460024] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
> [    0.460092] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
> [    0.460094] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
> [    0.460095] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
> [    0.460096] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
> [    0.460098] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff]
> [    0.460099] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]
> [    0.460101] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
> [    0.460103] pci_bus 0000:01: resource 1 [mem 0xf9e00000-0xf9efffff]
> [    0.460104] pci_bus 0000:02: resource 1 [mem 0xf9f00000-0xf9ffffff]
> [    0.460106] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
> [    0.460107] pci_bus 0000:03: resource 1 [mem 0xfa000000-0xfbcfffff]
> [    0.460109] pci_bus 0000:03: resource 2 [mem 0xd6000000-0xdfffffff 64bit pref]
> [    0.460110] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
> [    0.460112] pci_bus 0000:06: resource 1 [mem 0xc0000000-0xc03fffff]
> [    0.460113] pci_bus 0000:06: resource 2 [mem 0xf8f00000-0xf8ffffff 64bit pref]
> [    0.460115] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
> [    0.460117] pci_bus 0000:05: resource 1 [mem 0xfbd00000-0xfbdfffff]
> [    0.460118] pci_bus 0000:05: resource 2 [mem 0xc0400000-0xc06fffff pref]
> [    0.460120] pci_bus 0000:07: resource 0 [io  0xe000-0xefff]
> [    0.460121] pci_bus 0000:07: resource 1 [mem 0xfbe00000-0xfbefffff]
> [    0.460123] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7]
> [    0.460124] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff]
> [    0.460126] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff]
> [    0.460127] pci_bus 0000:07: resource 7 [mem 0x000d0000-0x000dffff]
> [    0.460128] pci_bus 0000:07: resource 8 [mem 0xc0000000-0xdfffffff]
> [    0.460130] pci_bus 0000:07: resource 9 [mem 0xf0000000-0xfed8ffff]
> [    0.460133] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
> [    0.460135] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xfffffffff]
> [    0.460213] NET: Registered protocol family 2
> [    0.460539] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.461056] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [    0.461230] TCP: Hash tables configured (established 262144 bind 65536)
> [    0.461307] TCP: reno registered
> [    0.461389] UDP hash table entries: 16384 (order: 7, 524288 bytes)
> [    0.461556] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
> [    0.461774] NET: Registered protocol family 1
> [    0.464540] pci 0000:03:00.0: Boot video device
> [    0.464554] PCI: CLS mismatch (256 != 64), using 64 bytes
> [    0.464603] Unpacking initramfs...
> [    0.736646] Freeing initrd memory: 14968K (ffff8800362b4000 - ffff880037152000)
> [    0.736750] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.736813] software IO TLB [mem 0xbb780000-0xbf780000] (64MB) mapped at [ffff8800bb780000-ffff8800bf77ffff]
> [    0.737121] microcode: CPU0 sig=0x106a5, pf=0x2, revision=0x19
> [    0.737187] microcode: CPU1 sig=0x106a5, pf=0x2, revision=0x19
> [    0.737253] microcode: CPU2 sig=0x106a5, pf=0x2, revision=0x19
> [    0.737319] microcode: CPU3 sig=0x106a5, pf=0x2, revision=0x19
> [    0.737384] microcode: CPU4 sig=0x106a5, pf=0x2, revision=0x19
> [    0.737450] microcode: CPU5 sig=0x106a5, pf=0x2, revision=0x19
> [    0.737515] microcode: CPU6 sig=0x106a5, pf=0x2, revision=0x19
> [    0.737581] microcode: CPU7 sig=0x106a5, pf=0x2, revision=0x19
> [    0.737678] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
> [    0.738041] audit: initializing netlink socket (disabled)
> [    0.738109] type=2000 audit(1389652889.600:1): initialized
> [    0.752758] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    0.753588] VFS: Disk quotas dquot_6.5.2
> [    0.753674] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.753805] msgmni has been set to 32768
> [    0.754077] alg: No test for stdrng (krng)
> [    0.754157] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
> [    0.754270] io scheduler noop registered
> [    0.754328] io scheduler deadline registered
> [    0.754407] io scheduler cfq registered (default)
> [    0.754636] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
> [    0.754824] pcieport 0000:00:1c.0: irq 66 for MSI/MSI-X
> [    0.756806] pcieport 0000:00:1c.4: irq 67 for MSI/MSI-X
> [    0.756885] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    0.756957] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    0.757040] intel_idle: MWAIT substates: 0x1120
> [    0.757051] intel_idle: v0.4 model 0x1A
> [    0.757051] intel_idle: lapic_timer_reliable_states 0x2
> [    0.757218] GHES: HEST is not enabled!
> [    0.757327] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.779389] 00:0b: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    0.779781] Linux agpgart interface v0.103
> [    0.779936] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> [    0.779999] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> [    0.780559] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.780691] mousedev: PS/2 mouse device common for all mice
> [    0.780782] rtc_cmos 00:02: RTC can wake from S4
> [    0.780943] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
> [    0.781026] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    0.781111] AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> [    0.781174] AMD IOMMUv2 functionality not available on this system
> [    0.781307] TCP: cubic registered
> [    0.781544] NET: Registered protocol family 10
> [    0.781778] mip6: Mobile IPv6
> [    0.781835] NET: Registered protocol family 17
> [    0.781895] mpls_gso: MPLS GSO support
> [    0.782179] registered taskstats version 1
> [    0.783153] rtc_cmos 00:02: setting system clock to 2014-01-13 22:41:30 UTC (1389652890)
> [    0.783258] PM: Hibernation image not present or could not be loaded.
> [    0.783874] Freeing unused kernel memory: 988K (ffffffff818af000 - ffffffff819a6000)
> [    0.783953] Write protecting the kernel read-only data: 8192k
> [    0.787091] Freeing unused kernel memory: 1332K (ffff8800014b3000 - ffff880001600000)
> [    0.789984] Freeing unused kernel memory: 456K (ffff88000178e000 - ffff880001800000)
> [    0.803476] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    0.849769] systemd-udevd[95]: starting version 204
> [    0.865521] SCSI subsystem initialized
> [    0.868249] ACPI: bus type USB registered
> [    0.868332] usbcore: registered new interface driver usbfs
> [    0.868407] usbcore: registered new interface driver hub
> [    0.868501] usbcore: registered new device driver usb
> [    0.868960] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    0.869285] uhci_hcd: USB Universal Host Controller Interface driver
> [    0.869367] ehci-pci: EHCI PCI platform driver
> [    0.869516] uhci_hcd 0000:00:1a.0: UHCI Host Controller
> [    0.869586] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
> [    0.869705] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a800
> [    0.869815] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.869881] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.869963] usb usb1: Product: UHCI Host Controller
> [    0.870025] usb usb1: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.870090] usb usb1: SerialNumber: 0000:00:1a.0
> [    0.870269] hub 1-0:1.0: USB hub found
> [    0.870338] hub 1-0:1.0: 2 ports detected
> [    0.870451] libata version 3.00 loaded.
> [    0.870478] xhci_hcd 0000:02:00.0: xHCI Host Controller
> [    0.870553] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
> [    0.870627] uhci_hcd 0000:00:1a.1: UHCI Host Controller
> [    0.870632] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 3
> [    0.870669] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
> [    0.870720] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.870721] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.870723] usb usb3: Product: UHCI Host Controller
> [    0.870724] usb usb3: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.870725] usb usb3: SerialNumber: 0000:00:1a.1
> [    0.870818] hub 3-0:1.0: USB hub found
> [    0.870823] hub 3-0:1.0: 2 ports detected
> [    0.871021] uhci_hcd 0000:00:1a.2: UHCI Host Controller
> [    0.871027] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 4
> [    0.872850] uhci_hcd 0000:00:1a.2: irq 19, io base 0x0000ac00
> [    0.872906] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.872907] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.872909] usb usb4: Product: UHCI Host Controller
> [    0.872910] usb usb4: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.872911] usb usb4: SerialNumber: 0000:00:1a.2
> [    0.873086] hub 4-0:1.0: USB hub found
> [    0.873092] hub 4-0:1.0: 2 ports detected
> [    0.873310] uhci_hcd 0000:00:1d.0: UHCI Host Controller
> [    0.873314] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
> [    0.873348] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a080
> [    0.873449] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.873451] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.873452] usb usb5: Product: UHCI Host Controller
> [    0.873454] usb usb5: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.873455] usb usb5: SerialNumber: 0000:00:1d.0
> [    0.873540] hub 5-0:1.0: USB hub found
> [    0.873547] hub 5-0:1.0: 2 ports detected
> [    0.873741] uhci_hcd 0000:00:1d.1: UHCI Host Controller
> [    0.873746] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
> [    0.873770] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
> [    0.873815] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
> [    0.873817] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.873818] usb usb6: Product: UHCI Host Controller
> [    0.873819] usb usb6: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    0.873821] usb usb6: SerialNumber: 0000:00:1d.1
> [    0.873909] hub 6-0:1.0: USB hub found
> [    0.873916] hub 6-0:1.0: 2 ports detected
> [    0.875118] xhci_hcd 0000:02:00.0: irq 68 for MSI/MSI-X
> [    0.875128] xhci_hcd 0000:02:00.0: irq 69 for MSI/MSI-X
> [    0.875136] xhci_hcd 0000:02:00.0: irq 70 for MSI/MSI-X
> [    0.875144] xhci_hcd 0000:02:00.0: irq 71 for MSI/MSI-X
> [    0.875152] xhci_hcd 0000:02:00.0: irq 72 for MSI/MSI-X
> [    0.875160] xhci_hcd 0000:02:00.0: irq 73 for MSI/MSI-X
> [    0.875168] xhci_hcd 0000:02:00.0: irq 74 for MSI/MSI-X
> [    0.875176] xhci_hcd 0000:02:00.0: irq 75 for MSI/MSI-X
> [    0.875952] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
> [    0.876018] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.876096] usb usb2: Product: xHCI Host Controller
> [    0.876157] usb usb2: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
> [    0.876218] usb usb2: SerialNumber: 0000:02:00.0
> [    0.876407] hub 2-0:1.0: USB hub found
> [    0.876477] hub 2-0:1.0: 2 ports detected
> [    0.876608] xhci_hcd 0000:02:00.0: xHCI Host Controller
> [    0.876672] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 7
> [    0.876780] ehci-pci 0000:00:1a.7: EHCI Host Controller
> [    0.876844] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 8
> [    0.876932] ehci-pci 0000:00:1a.7: debug port 1
> [    0.878310] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    0.878439] r8169 0000:07:01.0 (unregistered net_device): not PCI Express
> [    0.878567] usb usb7: New USB device found, idVendor=1d6b, idProduct=0003
> [    0.878640] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.878721] usb usb7: Product: xHCI Host Controller
> [    0.878757] r8169 0000:07:01.0 eth0: RTL8169sc/8110sc at 0xffffc90003074000, 54:04:a6:49:30:b0, XID 18000000 IRQ 19
> [    0.878759] r8169 0000:07:01.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
> [    0.878953] usb usb7: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
> [    0.879019] usb usb7: SerialNumber: 0000:02:00.0
> [    0.879209] hub 7-0:1.0: USB hub found
> [    0.879296] hub 7-0:1.0: 2 ports detected
> [    0.880886] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
> [    0.880897] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9dff000
> [    0.891320] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
> [    0.891422] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
> [    0.891489] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.891571] usb usb8: Product: EHCI Host Controller
> [    0.891634] usb usb8: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
> [    0.891699] usb usb8: SerialNumber: 0000:00:1a.7
> [    0.891873] hub 8-0:1.0: USB hub found
> [    0.891943] hub 8-0:1.0: 6 ports detected
> [    0.915485] hub 1-0:1.0: USB hub found
> [    0.915550] hub 1-0:1.0: 2 ports detected
> [    0.939414] hub 3-0:1.0: USB hub found
> [    0.939480] hub 3-0:1.0: 2 ports detected
> [    0.951476] firewire_ohci 0000:07:02.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x11
> [    0.963469] hub 4-0:1.0: USB hub found
> [    0.963538] hub 4-0:1.0: 2 ports detected
> [    0.963877] ehci-pci 0000:00:1d.7: EHCI Host Controller
> [    0.963942] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 9
> [    0.964030] ehci-pci 0000:00:1d.7: debug port 1
> [    0.967976] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
> [    0.967982] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9dfe000
> [    0.979507] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> [    0.979599] usb usb9: New USB device found, idVendor=1d6b, idProduct=0002
> [    0.979674] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.979752] usb usb9: Product: EHCI Host Controller
> [    0.979812] usb usb9: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
> [    0.979874] usb usb9: SerialNumber: 0000:00:1d.7
> [    0.980177] hub 9-0:1.0: USB hub found
> [    0.980245] hub 9-0:1.0: 6 ports detected
> [    1.003473] hub 5-0:1.0: USB hub found
> [    1.003544] hub 5-0:1.0: 2 ports detected
> [    1.027516] hub 6-0:1.0: USB hub found
> [    1.027582] hub 6-0:1.0: 2 ports detected
> [    1.027914] uhci_hcd 0000:00:1d.2: UHCI Host Controller
> [    1.027982] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 10
> [    1.028084] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a480
> [    1.028179] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001
> [    1.028243] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.028321] usb usb10: Product: UHCI Host Controller
> [    1.028382] usb usb10: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
> [    1.028444] usb usb10: SerialNumber: 0000:00:1d.2
> [    1.028589] hub 10-0:1.0: USB hub found
> [    1.028653] hub 10-0:1.0: 2 ports detected
> [    1.028852] ahci 0000:00:1f.2: version 3.0
> [    1.029062] ahci 0000:00:1f.2: irq 76 for MSI/MSI-X
> [    1.029067] ahci 0000:00:1f.2: irq 77 for MSI/MSI-X
> [    1.029071] ahci 0000:00:1f.2: irq 78 for MSI/MSI-X
> [    1.029075] ahci 0000:00:1f.2: irq 79 for MSI/MSI-X
> [    1.029079] ahci 0000:00:1f.2: irq 80 for MSI/MSI-X
> [    1.029083] ahci 0000:00:1f.2: irq 81 for MSI/MSI-X
> [    1.029087] ahci 0000:00:1f.2: irq 82 for MSI/MSI-X
> [    1.029091] ahci 0000:00:1f.2: irq 83 for MSI/MSI-X
> [    1.029095] ahci 0000:00:1f.2: irq 84 for MSI/MSI-X
> [    1.029099] ahci 0000:00:1f.2: irq 85 for MSI/MSI-X
> [    1.029102] ahci 0000:00:1f.2: irq 86 for MSI/MSI-X
> [    1.029106] ahci 0000:00:1f.2: irq 87 for MSI/MSI-X
> [    1.029110] ahci 0000:00:1f.2: irq 88 for MSI/MSI-X
> [    1.029114] ahci 0000:00:1f.2: irq 89 for MSI/MSI-X
> [    1.029118] ahci 0000:00:1f.2: irq 90 for MSI/MSI-X
> [    1.029122] ahci 0000:00:1f.2: irq 91 for MSI/MSI-X
> [    1.029191] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
> [    1.029275] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ccc ems sxs 
> [    1.069168] scsi0 : ahci
> [    1.069556] scsi1 : ahci
> [    1.069809] scsi2 : ahci
> [    1.070035] scsi3 : ahci
> [    1.072090] scsi4 : ahci
> [    1.072341] scsi5 : ahci
> [    1.072462] ata1: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc100 irq 76
> [    1.072546] ata2: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc180 irq 77
> [    1.072625] ata3: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc200 irq 78
> [    1.072703] ata4: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc280 irq 79
> [    1.072782] ata5: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc300 irq 80
> [    1.072860] ata6: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc380 irq 81
> [    1.073026] ahci 0000:01:00.0: irq 92 for MSI/MSI-X
> [    1.073037] ahci 0000:01:00.0: controller can do FBS, turning on CAP_FBS
> [    1.088425] ahci 0000:01:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> [    1.088508] ahci 0000:01:00.0: flags: 64bit ncq fbs pio 
> [    1.089261] scsi6 : ahci
> [    1.089470] scsi7 : ahci
> [    1.089677] scsi8 : ahci
> [    1.089884] scsi9 : ahci
> [    1.090106] scsi10 : ahci
> [    1.090324] scsi11 : ahci
> [    1.090500] scsi12 : ahci
> [    1.090668] scsi13 : ahci
> [    1.090779] ata7: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff100 irq 92
> [    1.090863] ata8: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff180 irq 92
> [    1.090941] ata9: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff200 irq 92
> [    1.091020] ata10: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff280 irq 92
> [    1.091099] ata11: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff300 irq 92
> [    1.091177] ata12: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff380 irq 92
> [    1.091256] ata13: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff400 irq 92
> [    1.091341] ata14: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff480 irq 92
> [    1.091536] ahci 0000:05:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
> [    1.091618] ahci 0000:05:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
> [    1.091929] scsi14 : ahci
> [    1.092064] scsi15 : ahci
> [    1.092157] ata15: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff100 irq 16
> [    1.092238] ata16: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff180 irq 16
> [    1.411641] ata8: SATA link down (SStatus 0 SControl 300)
> [    1.411660] ata15: SATA link down (SStatus 0 SControl 300)
> [    1.411697] ata16: SATA link down (SStatus 0 SControl 300)
> [    1.411849] ata12: SATA link down (SStatus 0 SControl 300)
> [    1.411925] ata10: SATA link down (SStatus 0 SControl 300)
> [    1.412002] ata11: SATA link down (SStatus 0 SControl 300)
> [    1.412077] ata9: SATA link down (SStatus 0 SControl 300)
> [    1.412153] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.412230] ata13: SATA link down (SStatus 0 SControl 300)
> [    1.412303] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
> [    1.412589] ata14.00: configured for UDMA/66
> [    1.420153] ata7: SATA link down (SStatus 0 SControl 300)
> [    1.453411] firewire_core 0000:07:02.0: created device fw0: GUID 001fc600001acd8c, S400
> [    1.563698] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.563781] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.563855] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.563929] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.564002] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.565155] ata4.00: ATA-8: ST31000528AS, CC38, max UDMA/133
> [    1.565223] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.565341] ata1.00: ATA-8: ST31000528AS, CC38, max UDMA/133
> [    1.565405] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.565515] ata6.00: ATA-8: ST31000528AS, CC38, max UDMA/133
> [    1.565579] ata6.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.565737] ata3.00: ATA-8: ST31000528AS, CC38, max UDMA/133
> [    1.565840] ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.566642] ata2.00: ATAPI: TSSTcorpCD/DVDW SH-S183L, SB01, max UDMA/33
> [    1.566711] ata2.00: applying bridge limits
> [    1.566925] ata4.00: configured for UDMA/133
> [    1.567108] ata1.00: configured for UDMA/133
> [    1.567215] ata6.00: configured for UDMA/133
> [    1.567292] ata3.00: configured for UDMA/133
> [    1.567469] scsi 0:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
> [    1.567522] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.569960] ata5.00: ATA-8: ST31000340AS, SD15, max UDMA/133
> [    1.570027] ata5.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    1.570143] ata2.00: configured for UDMA/33
> [    1.572288] ata5.00: configured for UDMA/133
> [    1.572792] scsi 1:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183L SB01 PQ: 0 ANSI: 5
> [    1.573316] scsi 2:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
> [    1.573729] scsi 3:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
> [    1.574245] scsi 4:0:0:0: Direct-Access     ATA      ST31000340AS     SD15 PQ: 0 ANSI: 5
> [    1.574661] scsi 5:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
> [    1.575264] scsi 13:0:0:0: Processor         Marvell  91xx Config      1.01 PQ: 0 ANSI: 5
> [    1.580591] scsi 0:0:0:0: Attached scsi generic sg0 type 0
> [    1.580686] sr 1:0:0:0: Attached scsi generic sg1 type 5
> [    1.580780] scsi 2:0:0:0: Attached scsi generic sg2 type 0
> [    1.580873] scsi 3:0:0:0: Attached scsi generic sg3 type 0
> [    1.580982] scsi 4:0:0:0: Attached scsi generic sg4 type 0
> [    1.581077] scsi 5:0:0:0: Attached scsi generic sg5 type 0
> [    1.581167] scsi 13:0:0:0: Attached scsi generic sg6 type 3
> [    1.581468] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.581605] sd 0:0:0:0: [sda] Write Protect is off
> [    1.581667] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.581690] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.585973] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
> [    1.586054] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    1.586210] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [    1.586330] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.586356] sd 3:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.586368] sd 4:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.586387] sd 5:0:0:0: [sde] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
> [    1.586449] sd 3:0:0:0: [sdc] Write Protect is off
> [    1.586451] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    1.586465] sd 4:0:0:0: [sdd] Write Protect is off
> [    1.586467] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [    1.586475] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.586485] sd 5:0:0:0: [sde] Write Protect is off
> [    1.586487] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
> [    1.586497] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.586509] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.587245] sd 2:0:0:0: [sdb] Write Protect is off
> [    1.587307] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    1.587338] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.588698]  sdc: sdc1 sdc2 sdc3
> [    1.589496] sd 3:0:0:0: [sdc] Attached SCSI disk
> [    1.590906]  sda: sda1 sda2 sda3
> [    1.591865] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.593481]  sde: sde1 sde2 sde3
> [    1.594276]  sdd: sdd1 sdd2 sdd3
> [    1.594314] sd 5:0:0:0: [sde] Attached SCSI disk
> [    1.594932] sd 4:0:0:0: [sdd] Attached SCSI disk
> [    1.600418]  sdb: sdb1 sdb2 sdb3
> [    1.603051] sd 2:0:0:0: [sdb] Attached SCSI disk
> [    1.739569] tsc: Refined TSC clocksource calibration: 2806.362 MHz
> [    1.787798] usb 10-1: new low-speed USB device number 2 using uhci_hcd
> [    1.863838] random: nonblocking pool is initialized
> [    1.963523] usb 10-1: New USB device found, idVendor=046d, idProduct=c01e
> [    1.963594] usb 10-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    1.963682] usb 10-1: Product: USB-PS/2 Optical Mouse
> [    1.963743] usb 10-1: Manufacturer: Logitech
> [    1.969570] hidraw: raw HID events driver (C) Jiri Kosina
> [    1.985640] usbcore: registered new interface driver usbhid
> [    1.985704] usbhid: USB HID core driver
> [    1.988165] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:1d.2/usb10/10-1/10-1:1.0/input/input1
> [    1.988385] hid-generic 0003:046D:C01E.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-1/input0
> [    2.093913] md: md127 stopped.
> [    2.096877] md: bind<sdc3>
> [    2.100551] md: bind<sdb3>
> [    2.101002] md: bind<sdd3>
> [    2.101755] md: bind<sde3>
> [    2.103937] md: bind<sda3>
> [    2.105230] md: raid10 personality registered for level 10
> [    2.105640] md/raid10:md127: active with 4 out of 4 devices
> [    2.105963] created bitmap (466 pages) for device md127
> [    2.121928] md127: bitmap initialized from disk: read 30 pages, set 0 of 953616 bits
> [    2.149858] md127: detected capacity change from 0 to 1999877701632
> [    2.149959] RAID10 conf printout:
> [    2.149963]  --- wd:4 rd:4
> [    2.149966]  disk 0, wo:0, o:1, dev:sda3
> [    2.149977]  disk 1, wo:0, o:1, dev:sdc3
> [    2.149979]  disk 2, wo:0, o:1, dev:sdb3
> [    2.149981]  disk 3, wo:0, o:1, dev:sdd3
> [    2.151501]  md127: unknown partition table
> [    2.187645] device-mapper: uevent: version 1.0.3
> [    2.187777] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> [    2.203784] usb 10-2: new low-speed USB device number 3 using uhci_hcd
> [    2.256305] bio: create slab <bio-1> at 1
> [    2.324492] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
> [    2.509650] usb 10-2: New USB device found, idVendor=051d, idProduct=0002
> [    2.509718] usb 10-2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> [    2.509797] usb 10-2: Product: Back-UPS RS 1500 FW:8.g9 .D USB FW:g9 
> [    2.509860] usb 10-2: Manufacturer: American Power Conversion
> [    2.509922] usb 10-2: SerialNumber: JB0539032829  
> [    2.740221] Switched to clocksource tsc
> [    3.584325] hid-generic 0003:051D:0002.0002: hiddev0,hidraw1: USB HID v1.10 Device [American Power Conversion Back-UPS RS 1500 FW:8.g9 .D USB FW:g9 ] on usb-0000:00:1d.2-2/input0
> [   13.730195] systemd-udevd[634]: starting version 204
> [   14.230269] wmi: Mapper loaded
> [   14.268895] ATK0110 ATK0110:00: Overriding interface detection
> [   14.273171] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
> [   14.273254] ACPI: Power Button [PWRB]
> [   14.273340] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [   14.273419] ACPI: Power Button [PWRF]
> [   14.283478] EDAC MC: Ver: 3.0.0
> [   14.308356] EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:ff:03.0 (POLLED)
> [   14.308466] EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)
> [   14.308556] EDAC i7core: Driver loaded, 1 memory controller(s) found.
> [   14.312265] systemd-udevd[674]: renamed network interface eth0 to lan
> [   14.331814] ACPI Warning: 0x0000000000000828-0x000000000000082f SystemIO conflicts with Region \PMRG 1 (20131115/utaddress-251)
> [   14.331979] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   14.332129] ACPI Warning: 0x0000000000000530-0x000000000000053f SystemIO conflicts with Region \GPS0 1 (20131115/utaddress-251)
> [   14.332290] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   14.332373] ACPI Warning: 0x0000000000000500-0x000000000000052f SystemIO conflicts with Region \GPS0 1 (20131115/utaddress-251)
> [   14.332533] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   14.332618] lpc_ich: Resource conflict(s) found affecting gpio_ich
> [   14.364866] input: PC Speaker as /devices/platform/pcspkr/input/input4
> [   14.367777] ACPI Warning: 0x0000000000001000-0x000000000000101f SystemIO conflicts with Region \SMRG 1 (20131115/utaddress-251)
> [   14.367939] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   14.406498] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
> [   14.411325] [drm] Initialized drm 1.1.0 20060810
> [   14.518041] iTCO_vendor_support: vendor-support=0
> [   14.525770] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
> [   14.525857] iTCO_wdt: Found a ICH10R TCO device (Version=2, TCOBASE=0x0860)
> [   14.525998] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=1)
> [   14.625084] snd_hda_intel 0000:00:1b.0: irq 93 for MSI/MSI-X
> [   14.650248] input: HDA Intel Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
> [   14.650376] input: HDA Intel Line Out Side as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
> [   14.650493] input: HDA Intel Line Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
> [   14.650610] input: HDA Intel Line Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
> [   14.650726] input: HDA Intel Line Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
> [   14.650842] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
> [   14.650957] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
> [   14.651074] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
> [   14.651524] hda_intel: Disabling MSI
> [   14.651597] hda-intel 0000:03:00.1: Handle VGA-switcheroo audio client
> [   14.709942] nouveau: unknown parameter 'perflvl_wr' ignored
> [   14.710160] MXM: GUID detected in BIOS
> [   14.727614] md: bind<sde1>
> [   14.783015] md: bind<sdb1>
> [   14.789240] md: bind<sda1>
> [   14.794432] md: bind<sdc1>
> [   14.832790] md: bind<sdd1>
> [   14.849298] md: raid1 personality registered for level 1
> [   14.849563] md/raid1:md0: active with 5 out of 5 mirrors
> [   14.853347] created bitmap (16 pages) for device md0
> [   14.864496] md0: bitmap initialized from disk: read 2 pages, set 0 of 32096 bits
> [   14.877323] md0: detected capacity change from 0 to 131465216
> [   14.877458] RAID1 conf printout:
> [   14.877462]  --- wd:5 rd:5
> [   14.877465]  disk 0, wo:0, o:1, dev:sda1
> [   14.877467]  disk 1, wo:0, o:1, dev:sdc1
> [   14.877470]  disk 2, wo:0, o:1, dev:sdb1
> [   14.877472]  disk 3, wo:0, o:1, dev:sdd1
> [   14.877474]  disk 4, wo:0, o:1, dev:sde1
> [   14.880346]  md0: unknown partition table
> [   15.468103] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/0000:03:00.1/sound/card1/input16
> [   15.468394] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/0000:03:00.1/sound/card1/input15
> [   15.468665] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/0000:03:00.1/sound/card1/input14
> [   15.468937] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/0000:03:00.1/sound/card1/input13
> [   15.471500] nouveau  [  DEVICE][0000:03:00.0] BOOT0  : 0x0c1000a1
> [   15.471568] nouveau  [  DEVICE][0000:03:00.0] Chipset: GF108 (NVC1)
> [   15.471633] nouveau  [  DEVICE][0000:03:00.0] Family : NVC0
> [   15.474291] nouveau  [   VBIOS][0000:03:00.0] checking PRAMIN for image...
> [   15.540028] nouveau  [   VBIOS][0000:03:00.0] ... appears to be valid
> [   15.540098] nouveau  [   VBIOS][0000:03:00.0] using image from PRAMIN
> [   15.540347] nouveau  [   VBIOS][0000:03:00.0] BIT signature found
> [   15.540413] nouveau  [   VBIOS][0000:03:00.0] version 70.08.4d.00.00
> [   15.540890] nouveau 0000:03:00.0: irq 94 for MSI/MSI-X
> [   15.540903] nouveau  [     PMC][0000:03:00.0] MSI interrupts enabled
> [   15.541001] nouveau W[     PFB][0000:03:00.0][0x00000000][ffff88061bebc800] reclocking of this ram type unsupported
> [   15.541118] nouveau  [     PFB][0000:03:00.0] RAM type: DDR3
> [   15.541209] nouveau  [     PFB][0000:03:00.0] RAM size: 512 MiB
> [   15.541301] nouveau  [     PFB][0000:03:00.0]    ZCOMP: 0 tags
> [   15.574190] nouveau  [  PTHERM][0000:03:00.0] FAN control: none / external
> [   15.574286] nouveau  [  PTHERM][0000:03:00.0] fan management: automatic
> [   15.574379] nouveau  [  PTHERM][0000:03:00.0] internal sensor: yes
> [   15.574493] nouveau  [     CLK][0000:03:00.0] 03: core 50 MHz memory 135 MHz 
> [   15.574585] nouveau  [     CLK][0000:03:00.0] 07: core 405 MHz memory 324 MHz 
> [   15.574694] nouveau  [     CLK][0000:03:00.0] 0f: core 810 MHz memory 900 MHz 
> [   15.574943] nouveau  [     CLK][0000:03:00.0] --: core 405 MHz memory 324 MHz 
> [   15.586865] [TTM] Zone  kernel: Available graphics memory: 12368142 kiB
> [   15.586961] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
> [   15.587055] [TTM] Initializing pool allocator
> [   15.587144] [TTM] Initializing DMA pool allocator
> [   15.587236] nouveau  [     DRM] VRAM: 512 MiB
> [   15.587322] nouveau  [     DRM] GART: 1048576 MiB
> [   15.587411] nouveau  [     DRM] TMDS table version 2.0
> [   15.587498] nouveau  [     DRM] DCB version 4.0
> [   15.587585] nouveau  [     DRM] DCB outp 00: 01000302 00020030
> [   15.587674] nouveau  [     DRM] DCB outp 01: 02000300 00000000
> [   15.587763] nouveau  [     DRM] DCB outp 02: 08011392 00020020
> [   15.587852] nouveau  [     DRM] DCB outp 03: 04022310 00000000
> [   15.588002] nouveau  [     DRM] DCB conn 00: 00001030
> [   15.588154] nouveau  [     DRM] DCB conn 01: 00002161
> [   15.588303] nouveau  [     DRM] DCB conn 02: 00000200
> [   15.589281] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   15.589372] [drm] No driver support for vblank timestamp query.
> [   15.603932] nouveau  [     DRM] MM: using COPY0 for buffer copies
> [   15.688554] nouveau  [     DRM] allocated 1024x768 fb: 0x60000, bo ffff88061d20f000
> [   15.688759] fbcon: nouveaufb (fb0) is primary device
> [   15.767249] Console: switching to colour frame buffer device 128x48
> [   15.768248] nouveau 0000:03:00.0: fb0: nouveaufb frame buffer device
> [   15.768260] nouveau 0000:03:00.0: registered panic notifier
> [   15.768282] [drm] Initialized nouveau 1.1.1 20120801 for 0000:03:00.0 on minor 0
> [   16.284853] EXT4-fs (dm-0): re-mounted. Opts: (null)
> [   16.689360] RAID10 conf printout:
> [   16.689365]  --- wd:4 rd:4
> [   16.689368]  disk 0, wo:0, o:1, dev:sda3
> [   16.689371]  disk 1, wo:0, o:1, dev:sdc3
> [   16.689373]  disk 2, wo:0, o:1, dev:sdb3
> [   16.689375]  disk 3, wo:0, o:1, dev:sdd3
> [   16.797872] EXT4-fs (dm-0): re-mounted. Opts: user_xattr,errors=remount-ro
> [   17.249405] loop: module loaded
> [   18.977520] Adding 5857276k swap on /dev/mapper/Zia-swap_crypt.  Priority:-1 extents:1 across:5857276k 
> [   20.193879] EXT4-fs (md0): mounting ext2 file system using the ext4 subsystem
> [   20.249294] EXT4-fs (md0): mounted filesystem without journal. Opts: (null)
> [   20.317238] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: user_xattr
> [   20.354576] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: user_xattr
> [   20.447409] FAT-fs (sda2): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
> [   20.519785] FAT-fs (sdc2): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
> [   20.541961] FAT-fs (sdb2): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
> [   20.648313] FAT-fs (sdd2): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
> [   21.646283] Bridge firewalling registered
> [   21.649395] device lan entered promiscuous mode
> [   21.662557] r8169 0000:07:01.0 lan: link down
> [   21.662578] r8169 0000:07:01.0 lan: link down
> [   21.663016] IPv6: ADDRCONF(NETDEV_UP): lan: link is not ready
> [   21.665403] IPv6: ADDRCONF(NETDEV_UP): br0: link is not ready
> [   24.344231] r8169 0000:07:01.0 lan: link up
> [   24.344492] IPv6: ADDRCONF(NETDEV_CHANGE): lan: link becomes ready
> [   24.345355] br0: port 1(lan) entered forwarding state
> [   24.346969] br0: port 1(lan) entered forwarding state
> [   24.348426] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
> [   25.342865] RPC: Registered named UNIX socket transport module.
> [   25.343045] RPC: Registered udp transport module.
> [   25.343181] RPC: Registered tcp transport module.
> [   25.343600] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [   25.348079] FS-Cache: Loaded
> [   25.369779] FS-Cache: Netfs 'nfs' registered for caching
> [   25.421082] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
> [   25.790688] tun: Universal TUN/TAP device driver, 1.6
> [   25.790907] tun: (C) 1999-2004 Max Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
> [   26.351334] br0: port 1(lan) entered forwarding state
> [   38.117820] CacheFiles: Loaded
> [   39.175686] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> [   39.183577] NFSD: starting 90-second grace period (net ffffffff81885e00)
