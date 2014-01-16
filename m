From: Anthony DeRobertis <aderobertis-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
Subject: Re: PROBLEM: do_IRQ: [number] No irq handler for vector (irq -1)
Date: Thu, 16 Jan 2014 15:07:21 -0500
Message-ID: <52D83BF9.7040502@metrics.net>
References: <52D576E3.8050006@metrics.net>
	<1389844985.8705.45.camel@bling.home>
	<20140116121617.GA9984@hmsreliant.think-freely.org>
	<52D8120D.7090606@metrics.net>
	<20140116182134.GC9984@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140116182134.GC9984-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/16/2014 01:21 PM, Neil Horman wrote:
> Yes, What I would like to see is your backout patch removed, and the the
> following tests preformed:
>
> 1) VT-D off in bios
> 2) VT-D on in bios and nointremap specified on the command line
> 3) VT-D on in bios and nointremap _not_ specified on the command line
>
> If I could see the boot logs for all of those that would be helpful.  Wha=
t would
> be particularly helpful is to know if test (2) results in the problem
> reproducing.  If it does that suggests our ability to disable interrupt
> remapping in the kernel is somehow ineffective on your system.

(2) results in the problem reproducing. To be clear, all three tests =

have been done without my patch applied. They were built from:

master          a6da83f Merge branch 'merge' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/benh/powerpc


To get the dmesg for (1) and (3), I booted into single user, and didn't =

go any further. (2) I first booted to single user, but then continued =

on=97that's why you'll see the much later timestamp loading tun, etc.



**** VT-d=3DOFF (1)

[    0.000000] CPU0 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.13.0-rc8+ (anthony@Zia) (gcc version 4.8.2 (=
Debian 4.8.2-12) ) #7 SMP Thu Jan 16 12:36:44 EST 2014
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.13.0-rc8+ root=3D/dev/=
mapper/Zia-root ro single verbose
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e2c00-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf797fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000bf798000-0x00000000bf7d9fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf7da000-0x00000000bfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000063fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: System manufacturer System Product Name/SABERTOOTH X58,=
 BIOS 1402    08/09/2012
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x640000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EBFFF write-through
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask C00000000 write-back
[    0.000000]   1 base 400000000 mask E00000000 write-back
[    0.000000]   2 base 600000000 mask FC0000000 write-back
[    0.000000]   3 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   4 base 0BF800000 mask FFF800000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820: update [mem 0xbf800000-0xffffffff] usable =3D=3D> rese=
rved
[    0.000000] e820: last_pfn =3D 0xbf780 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at =
[ffff8800000ff780]
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01a9b000, 0x01a9bfff] PGTABLE
[    0.000000] BRK [0x01a9c000, 0x01a9cfff] PGTABLE
[    0.000000] BRK [0x01a9d000, 0x01a9dfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x63fe00000-0x63fffffff]
[    0.000000]  [mem 0x63fe00000-0x63fffffff] page 2M
[    0.000000] BRK [0x01a9e000, 0x01a9efff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x63c000000-0x63fdfffff]
[    0.000000]  [mem 0x63c000000-0x63fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x600000000-0x63bffffff]
[    0.000000]  [mem 0x600000000-0x63bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xbf77ffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0xbf5fffff] page 2M
[    0.000000]  [mem 0xbf600000-0xbf77ffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x5ffffffff]
[    0.000000]  [mem 0x100000000-0x5ffffffff] page 2M
[    0.000000] BRK [0x01a9f000, 0x01a9ffff] PGTABLE
[    0.000000] BRK [0x01aa0000, 0x01aa0fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x362b2000-0x37150fff]
[    0.000000] ACPI: RSDP 00000000000fb940 000024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 00000000bf780100 000064 (v01 080912 XSDT1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000bf780290 0000F4 (v03 080912 FACP1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: DSDT 00000000bf7804b0 00C469 (v01  A1682 A1682001 0000=
0001 INTL 20060113)
[    0.000000] ACPI: FACS 00000000bf798000 000040
[    0.000000] ACPI: APIC 00000000bf780390 0000D8 (v01 080912 APIC1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000bf780470 00003C (v01 080912 OEMMCFG  2012=
0809 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000bf798040 000072 (v01 080912 OEMB1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000bf78f4b0 000038 (v01 080912 OEMHPET  2012=
0809 MSFT 00000097)
[    0.000000] ACPI: ASPT 00000000bf798360 000034 (v06 080912 PerfTune 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: OSFR 00000000bf78f4f0 0000B0 (v01 080912 OEMOSFR  2012=
0809 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000bf79a820 000363 (v01 DpgPmm    CpuPm 0000=
0012 INTL 20060113)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000063fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x63fffffff]
[    0.000000]   NODE_DATA [mem 0x63ffe6000-0x63ffeafff]
[    0.000000]  [ffffea0000000000-ffffea0015dfffff] PMD -> [ffff88062760000=
0-ffff88063c5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x63fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xbf77ffff]
[    0.000000]   node   0: [mem 0x100000000-0x63fffffff]
[    0.000000] On node 0 totalpages: 6289181
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 10667 pages used for memmap
[    0.000000]   DMA32 zone: 780160 pages, LIFO batch:31
[    0.000000]   Normal zone: 75264 pages used for memmap
[    0.000000]   Normal zone: 5505024 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec8a000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec8a000, GSI 24=
-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
[    0.000000] nr_irqs_gsi: 64
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e2fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e3000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf780000-0xbf797fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf798000-0xbf7d9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf7da000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffdfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffe00000-0xffffffff]
[    0.000000] e820: [mem 0xc0000000-0xfedfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:16 =
nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88063fc00000 s85824 r8192=
 d20672 u131072
[    0.000000] pcpu-alloc: s85824 r8192 d20672 u131072 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14=
 15
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 6203173
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-3.13.0-rc8+ root=
=3D/dev/mapper/Zia-root ro single verbose
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 24718516K/25156724K available (4799K kernel code, 69=
2K rwdata, 1592K rodata, 988K init, 952K bss, 438208K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=3D16.
[    0.000000] NR_IRQS:33024 nr_irqs:1216 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 100663296 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration failed
[    0.008000] tsc: PIT calibration matches HPET. 1 loops
[    0.008000] tsc: Detected 2806.444 MHz processor
[    0.000003] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5612.88 BogoMIPS (lpj=3D11225776)
[    0.000124] pid_max: default: 32768 minimum: 301
[    0.000217] Security Framework initialized
[    0.000278] AppArmor: AppArmor disabled by boot time parameter
[    0.000339] Yama: becoming mindful.
[    0.002279] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes)
[    0.010485] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes)
[    0.013870] Mount-cache hash table entries: 256
[    0.014090] Initializing cgroup subsys memory
[    0.014154] Initializing cgroup subsys devices
[    0.014213] Initializing cgroup subsys freezer
[    0.014273] Initializing cgroup subsys blkio
[    0.014332] Initializing cgroup subsys perf_event
[    0.014410] CPU: Physical Processor ID: 0
[    0.014468] CPU: Processor Core ID: 0
[    0.014529] mce: CPU supports 9 MCE banks
[    0.014597] CPU0: Thermal monitoring enabled (TM1)
[    0.014666] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.014666] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
[    0.014666] tlb_flushall_shift: 6
[    0.014832] Freeing SMP alternatives memory: 20K (ffffffff819a6000 - fff=
fffff819ab000)
[    0.015928] ACPI: Core revision 20131115
[    0.019468] ACPI: All ACPI Tables successfully acquired
[    0.065646] Switched APIC routing to physical flat.
[    0.066214] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.105972] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         930  @ 2.80G=
Hz (fam: 06, model: 1a, stepping: 05)
[    0.211879] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events,=
 Intel PMU driver.
[    0.212111] perf_event_intel: CPU erratum AAJ80 worked around
[    0.212173] perf_event_intel: CPUID marked event: 'bus cycles' unavailab=
le
[    0.212238] ... version:                3
[    0.212297] ... bit width:              48
[    0.212355] ... generic registers:      4
[    0.212413] ... value mask:             0000ffffffffffff
[    0.212474] ... max period:             000000007fffffff
[    0.212534] ... fixed-purpose events:   3
[    0.212593] ... event mask:             000000070000000f
[    0.213000] x86: Booting SMP configuration:
[    0.227448] CPU1 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.229644] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    0.244025] CPU2 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.260581] CPU3 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.213060] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.322375] x86: Booted up 1 node, 8 CPUs
[    0.322488] smpboot: Total of 8 processors activated (44903.10 BogoMIPS)
[    0.327080] devtmpfs: initialized
[    0.330516] PM: Registering ACPI NVS region [mem 0xbf798000-0xbf7d9fff] =
(270336 bytes)
[    0.330743] NET: Registered protocol family 16
[    0.330872] cpuidle: using governor ladder
[    0.330931] cpuidle: using governor menu
[    0.331008] ACPI: bus type PCI registered
[    0.331067] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.331195] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.331276] PCI: not using MMCONFIG
[    0.331334] PCI: Using configuration type 1 for base access
[    0.333282] bio: create slab  at 0
[    0.333451] ACPI: Added _OSI(Module Device)
[    0.333510] ACPI: Added _OSI(Processor Device)
[    0.333569] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.333628] ACPI: Added _OSI(Processor Aggregator Device)
[    0.335304] ACPI: Executed 1 blocks of module-level executable AML code
[    0.371960] ACPI: SSDT 00000000bf7983a0 001E1C (v01 DpgPmm  P001Ist 0000=
0011 INTL 20060113)
[    0.372415] ACPI: Dynamic OEM Table Load:
[    0.372548] ACPI: SSDT           (null) 001E1C (v01 DpgPmm  P001Ist 0000=
0011 INTL 20060113)
[    0.372780] ACPI: SSDT 00000000bf79a1c0 000659 (v01  PmRef  P001Cst 0000=
3001 INTL 20060113)
[    0.373132] ACPI: Dynamic OEM Table Load:
[    0.373264] ACPI: SSDT           (null) 000659 (v01  PmRef  P001Cst 0000=
3001 INTL 20060113)
[    0.373590] ACPI: Interpreter enabled
[    0.373654] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S2_] (20131115/hwxface-580)
[    0.373818] ACPI: (supports S0 S1 S3 S4 S5)
[    0.373876] ACPI: Using IOAPIC for interrupt routing
[    0.373954] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.374894] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACP=
I motherboard resources
[    0.388690] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.388882] ACPI: No dock devices found.
[    0.394846] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.394912] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    0.394994] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.395343] PCI host bridge to bus 0000:00
[    0.395403] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.395463] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.395525] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.395588] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f]
[    0.395651] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dfff=
f]
[    0.395715] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdffffff=
f]
[    0.395778] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed8fff=
f]
[    0.395850] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000
[    0.395892] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.395965] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    0.396009] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.396054] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.396140] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
[    0.396184] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.396228] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.396314] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    0.396358] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.396402] pci 0000:00:03.0: System wakeup disabled by ACPI
[    0.396490] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    0.396531] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.396575] pci 0000:00:07.0: System wakeup disabled by ACPI
[    0.396666] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    0.396757] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    0.396846] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    0.396933] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
[    0.397019] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    0.397056] pci 0000:00:1a.0: reg 0x20: [io  0xa800-0xa81f]
[    0.397138] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.397224] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    0.397261] pci 0000:00:1a.1: reg 0x20: [io  0xa880-0xa89f]
[    0.397343] pci 0000:00:1a.1: System wakeup disabled by ACPI
[    0.397430] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
[    0.397466] pci 0000:00:1a.2: reg 0x20: [io  0xac00-0xac1f]
[    0.397547] pci 0000:00:1a.2: System wakeup disabled by ACPI
[    0.397642] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    0.397660] pci 0000:00:1a.7: reg 0x10: [mem 0xf9dff000-0xf9dff3ff]
[    0.397739] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.397786] pci 0000:00:1a.7: System wakeup disabled by ACPI
[    0.397875] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300
[    0.397888] pci 0000:00:1b.0: reg 0x10: [mem 0xf9df8000-0xf9dfbfff 64bit]
[    0.397945] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.398012] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    0.398071] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.398119] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.398207] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    0.398266] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.398314] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    0.398402] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    0.398439] pci 0000:00:1d.0: reg 0x20: [io  0xa080-0xa09f]
[    0.398520] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.398608] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    0.398644] pci 0000:00:1d.1: reg 0x20: [io  0xa400-0xa41f]
[    0.398725] pci 0000:00:1d.1: System wakeup disabled by ACPI
[    0.398812] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    0.398848] pci 0000:00:1d.2: reg 0x20: [io  0xa480-0xa49f]
[    0.398929] pci 0000:00:1d.2: System wakeup disabled by ACPI
[    0.399024] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    0.399043] pci 0000:00:1d.7: reg 0x10: [mem 0xf9dfe000-0xf9dfe3ff]
[    0.399121] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.399168] pci 0000:00:1d.7: System wakeup disabled by ACPI
[    0.399254] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.399333] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    0.399420] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
[    0.399489] pci 0000:00:1f.0: address space collision: [io  0x0800-0x087=
f] conflicts with ACPI CPU throttle [??? 0x00000810-0x00000815 flags 0x8000=
0000]
[    0.399580] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6=
 GPIO
[    0.399645] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (=
mask 0003)
[    0.399815] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
[    0.399831] pci 0000:00:1f.2: reg 0x10: [io  0x9c00-0x9c07]
[    0.399838] pci 0000:00:1f.2: reg 0x14: [io  0x9880-0x9883]
[    0.399844] pci 0000:00:1f.2: reg 0x18: [io  0x9800-0x9807]
[    0.399851] pci 0000:00:1f.2: reg 0x1c: [io  0x9480-0x9483]
[    0.399857] pci 0000:00:1f.2: reg 0x20: [io  0x9400-0x941f]
[    0.399864] pci 0000:00:1f.2: reg 0x24: [mem 0xf9dfc000-0xf9dfc7ff]
[    0.399903] pci 0000:00:1f.2: PME# supported from D3hot
[    0.399974] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    0.399987] pci 0000:00:1f.3: reg 0x10: [mem 0xf9dfd000-0xf9dfd0ff 64bit]
[    0.400004] pci 0000:00:1f.3: reg 0x20: [io  0x1000-0x101f]
[    0.400114] pci 0000:01:00.0: [1b4b:9123] type 00 class 0x010601
[    0.400123] pci 0000:01:00.0: reg 0x10: [io  0xbc00-0xbc07]
[    0.400130] pci 0000:01:00.0: reg 0x14: [io  0xb880-0xb883]
[    0.400136] pci 0000:01:00.0: reg 0x18: [io  0xb800-0xb807]
[    0.400142] pci 0000:01:00.0: reg 0x1c: [io  0xb480-0xb483]
[    0.400149] pci 0000:01:00.0: reg 0x20: [io  0xb400-0xb40f]
[    0.400155] pci 0000:01:00.0: reg 0x24: [mem 0xf9eff000-0xf9eff7ff]
[    0.400162] pci 0000:01:00.0: reg 0x30: [mem 0xf9ee0000-0xf9eeffff pref]
[    0.400189] pci 0000:01:00.0: PME# supported from D3hot
[    0.407954] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.408024] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    0.408026] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
[    0.408088] pci 0000:02:00.0: [1033:0194] type 00 class 0x0c0330
[    0.408103] pci 0000:02:00.0: reg 0x10: [mem 0xf9ffe000-0xf9ffffff 64bit]
[    0.408175] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.415952] pci 0000:00:02.0: PCI bridge to [bus 02]
[    0.416020] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    0.416067] pci 0000:03:00.0: [10de:0de0] type 00 class 0x030000
[    0.416076] pci 0000:03:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
[    0.416085] pci 0000:03:00.0: reg 0x14: [mem 0xd8000000-0xdfffffff 64bit=
 pref]
[    0.416094] pci 0000:03:00.0: reg 0x1c: [mem 0xd6000000-0xd7ffffff 64bit=
 pref]
[    0.416100] pci 0000:03:00.0: reg 0x24: [io  0xcc00-0xcc7f]
[    0.416106] pci 0000:03:00.0: reg 0x30: [mem 0xfbc00000-0xfbc7ffff pref]
[    0.416173] pci 0000:03:00.1: [10de:0bea] type 00 class 0x040300
[    0.416182] pci 0000:03:00.1: reg 0x10: [mem 0xfbcfc000-0xfbcfffff]
[    0.423978] pci 0000:00:03.0: PCI bridge to [bus 03]
[    0.424046] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.424049] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
[    0.424053] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff=
 64bit pref]
[    0.424099] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.424206] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.424272] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff=
 64bit pref]
[    0.424351] pci 0000:05:00.0: [197b:2362] type 00 class 0x010185
[    0.424380] pci 0000:05:00.0: reg 0x10: [io  0xdc00-0xdc07]
[    0.424392] pci 0000:05:00.0: reg 0x14: [io  0xd880-0xd883]
[    0.424405] pci 0000:05:00.0: reg 0x18: [io  0xd800-0xd807]
[    0.424417] pci 0000:05:00.0: reg 0x1c: [io  0xd480-0xd483]
[    0.424430] pci 0000:05:00.0: reg 0x20: [io  0xd400-0xd40f]
[    0.424442] pci 0000:05:00.0: reg 0x24: [mem 0xfbdff000-0xfbdff1ff]
[    0.424455] pci 0000:05:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.424505] pci 0000:05:00.0: PME# supported from D3hot
[    0.431975] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.432043] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.432046] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.432087] pci 0000:07:01.0: [10ec:8167] type 00 class 0x020000
[    0.432104] pci 0000:07:01.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.432113] pci 0000:07:01.0: reg 0x14: [mem 0xfbeff000-0xfbeff0ff]
[    0.432148] pci 0000:07:01.0: reg 0x30: [mem 0xfbec0000-0xfbedffff pref]
[    0.432180] pci 0000:07:01.0: supports D1 D2
[    0.432182] pci 0000:07:01.0: PME# supported from D1 D2 D3hot D3cold
[    0.432219] pci 0000:07:02.0: [1106:3044] type 00 class 0x0c0010
[    0.432234] pci 0000:07:02.0: reg 0x10: [mem 0xfbefe000-0xfbefe7ff]
[    0.432243] pci 0000:07:02.0: reg 0x14: [io  0xec00-0xec7f]
[    0.432304] pci 0000:07:02.0: supports D2
[    0.432306] pci 0000:07:02.0: PME# supported from D2 D3hot D3cold
[    0.432362] pci 0000:00:1e.0: PCI bridge to [bus 07] (subtractive decode)
[    0.432427] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.432430] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.432435] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtr=
active decode)
[    0.432436] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtr=
active decode)
[    0.432438] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff=
] (subtractive decode)
[    0.432439] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff=
] (subtractive decode)
[    0.432441] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff=
] (subtractive decode)
[    0.432442] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff=
] (subtractive decode)
[    0.432875] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12 14 1=
5)
[    0.433385] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 *10 11 12 14 1=
5)
[    0.433892] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12 *14 1=
5)
[    0.434401] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 6 7 10 11 12 14 1=
5)
[    0.434908] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 *1=
5)
[    0.435416] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14 1=
5)
[    0.437769] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *6 7 10 11 12 14 1=
5)
[    0.438277] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 *10 11 12 14 1=
5)
[    0.438832] ACPI: Enabled 3 GPEs in block 00 to 3F
[    0.438971] ACPI: \_SB_.PCI0: notify handler is installed
[    0.439016] Found 1 acpi root devices
[    0.439092] vgaarb: device added: PCI:0000:03:00.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.439172] vgaarb: loaded
[    0.439227] vgaarb: bridge control possible 0000:03:00.0
[    0.439318] PCI: Using ACPI for IRQ routing
[    0.444657] PCI: Discovered peer bus ff
[    0.444715] PCI: root bus ff: using default resources
[    0.444716] PCI: Probing PCI hardware (bus ff)
[    0.444735] PCI host bridge to bus 0000:ff
[    0.444796] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
[    0.444858] pci_bus 0000:ff: root bus resource [mem 0x00000000-0xfffffff=
ff]
[    0.444921] pci_bus 0000:ff: No busn resource found for root bus, will u=
se [bus ff-ff]
[    0.445004] pci 0000:ff:00.0: [8086:2c41] type 00 class 0x060000
[    0.445038] pci 0000:ff:00.1: [8086:2c01] type 00 class 0x060000
[    0.445068] pci 0000:ff:02.0: [8086:2c10] type 00 class 0x060000
[    0.445096] pci 0000:ff:02.1: [8086:2c11] type 00 class 0x060000
[    0.445125] pci 0000:ff:03.0: [8086:2c18] type 00 class 0x060000
[    0.445153] pci 0000:ff:03.1: [8086:2c19] type 00 class 0x060000
[    0.445182] pci 0000:ff:03.4: [8086:2c1c] type 00 class 0x060000
[    0.445210] pci 0000:ff:04.0: [8086:2c20] type 00 class 0x060000
[    0.445238] pci 0000:ff:04.1: [8086:2c21] type 00 class 0x060000
[    0.445266] pci 0000:ff:04.2: [8086:2c22] type 00 class 0x060000
[    0.445295] pci 0000:ff:04.3: [8086:2c23] type 00 class 0x060000
[    0.445324] pci 0000:ff:05.0: [8086:2c28] type 00 class 0x060000
[    0.445352] pci 0000:ff:05.1: [8086:2c29] type 00 class 0x060000
[    0.445383] pci 0000:ff:05.2: [8086:2c2a] type 00 class 0x060000
[    0.445412] pci 0000:ff:05.3: [8086:2c2b] type 00 class 0x060000
[    0.445441] pci 0000:ff:06.0: [8086:2c30] type 00 class 0x060000
[    0.445468] pci 0000:ff:06.1: [8086:2c31] type 00 class 0x060000
[    0.445496] pci 0000:ff:06.2: [8086:2c32] type 00 class 0x060000
[    0.445524] pci 0000:ff:06.3: [8086:2c33] type 00 class 0x060000
[    0.445561] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
[    0.445565] PCI: pci_cache_line_size set to 64 bytes
[    0.445637] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    0.445638] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
[    0.445718] HPET: 4 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.445784] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.446029] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.449293] Switched to clocksource hpet
[    0.450619] pnp: PnP ACPI init
[    0.450681] ACPI: bus type PNP registered
[    0.450780] system 00:00: [mem 0xfbf00000-0xfbffffff] has been reserved
[    0.450844] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    0.450908] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    0.450971] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
[    0.451034] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be reser=
ved
[    0.451097] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
[    0.451160] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.451189] pnp 00:01: [dma 4]
[    0.451204] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.451229] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.451246] pnp 00:03: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.451267] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.451342] system 00:05: [io  0x0290-0x029f] has been reserved
[    0.451405] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.451581] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.451645] system 00:06: [io  0x0800-0x087f] could not be reserved
[    0.451707] system 00:06: [io  0x0500-0x057f] could not be reserved
[    0.451770] system 00:06: [io  0x0600-0x0607] has been reserved
[    0.451832] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.451896] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.451959] system 00:06: [mem 0xfed40000-0xfed8ffff] has been reserved
[    0.452030] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.452095] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.452141] pnp 00:08: Plug and Play ACPI device, IDs INT0800 (active)
[    0.454038] system 00:09: [mem 0xffc00000-0xffdfffff] has been reserved
[    0.454107] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.454225] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    0.454289] system 00:0a: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.454353] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.454509] pnp 00:0b: [dma 0 disabled]
[    0.454557] pnp 00:0b: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.454598] pnp 00:0c: Plug and Play ACPI device, IDs PNP0303 PNP030b (a=
ctive)
[    0.454657] system 00:0d: [mem 0xe0000000-0xefffffff] has been reserved
[    0.454722] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.454875] system 00:0e: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.454939] system 00:0e: [mem 0x000c0000-0x000cffff] could not be reser=
ved
[    0.455003] system 00:0e: [mem 0x000e0000-0x000fffff] could not be reser=
ved
[    0.455067] system 00:0e: [mem 0x00100000-0xbfffffff] could not be reser=
ved
[    0.455131] system 00:0e: [mem 0xfed90000-0xffffffff] could not be reser=
ved
[    0.455195] system 00:0e: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.455294] pnp: PnP ACPI: found 15 devices
[    0.455352] ACPI: bus type PNP unregistered
[    0.461286] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
06] add_size 1000
[    0.461289] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 06] add_size 400000
[    0.461300] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x001fffff p=
ref] to [bus 05] add_size 200000
[    0.461312] pci 0000:00:1f.0: BAR 13: [io  0x0800-0x087f] has bogus alig=
nment
[    0.461377] pci 0000:00:1c.0: res[14]=3D[mem 0x00100000-0x000fffff] get_=
res_add_size add_size 400000
[    0.461378] pci 0000:00:1c.4: res[15]=3D[mem 0x00100000-0x001fffff pref]=
 get_res_add_size add_size 200000
[    0.461380] pci 0000:00:1c.0: res[13]=3D[io  0x1000-0x0fff] get_res_add_=
size add_size 1000
[    0.461383] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0000000-0xc03ffff=
f]
[    0.461447] pci 0000:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc06ffff=
f pref]
[    0.461526] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.461589] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.461650] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    0.461713] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
[    0.461780] pci 0000:00:02.0: PCI bridge to [bus 02]
[    0.461841] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    0.461908] pci 0000:00:03.0: PCI bridge to [bus 03]
[    0.461969] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.462032] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
[    0.462097] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff=
 64bit pref]
[    0.462177] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.462243] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.462303] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.462368] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc03fffff]
[    0.462432] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff=
 64bit pref]
[    0.462515] pci 0000:05:00.0: BAR 6: assigned [mem 0xc0400000-0xc040ffff=
 pref]
[    0.462592] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.462653] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.462717] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.462781] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc06fffff=
 pref]
[    0.462862] pci 0000:00:1e.0: PCI bridge to [bus 07]
[    0.462923] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.462987] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.463055] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.463057] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.463058] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.463060] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
[    0.463061] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff]
[    0.463063] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]
[    0.463064] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    0.463066] pci_bus 0000:01: resource 1 [mem 0xf9e00000-0xf9efffff]
[    0.463067] pci_bus 0000:02: resource 1 [mem 0xf9f00000-0xf9ffffff]
[    0.463069] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.463071] pci_bus 0000:03: resource 1 [mem 0xfa000000-0xfbcfffff]
[    0.463072] pci_bus 0000:03: resource 2 [mem 0xd6000000-0xdfffffff 64bit=
 pref]
[    0.463074] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
[    0.463075] pci_bus 0000:06: resource 1 [mem 0xc0000000-0xc03fffff]
[    0.463077] pci_bus 0000:06: resource 2 [mem 0xf8f00000-0xf8ffffff 64bit=
 pref]
[    0.463078] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    0.463080] pci_bus 0000:05: resource 1 [mem 0xfbd00000-0xfbdfffff]
[    0.463081] pci_bus 0000:05: resource 2 [mem 0xc0400000-0xc06fffff pref]
[    0.463083] pci_bus 0000:07: resource 0 [io  0xe000-0xefff]
[    0.463084] pci_bus 0000:07: resource 1 [mem 0xfbe00000-0xfbefffff]
[    0.463086] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7]
[    0.463087] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff]
[    0.463089] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff]
[    0.463090] pci_bus 0000:07: resource 7 [mem 0x000d0000-0x000dffff]
[    0.463092] pci_bus 0000:07: resource 8 [mem 0xc0000000-0xdfffffff]
[    0.463093] pci_bus 0000:07: resource 9 [mem 0xf0000000-0xfed8ffff]
[    0.463096] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
[    0.463097] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xfffffffff]
[    0.463171] NET: Registered protocol family 2
[    0.463488] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes)
[    0.464003] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.464181] TCP: Hash tables configured (established 262144 bind 65536)
[    0.464257] TCP: reno registered
[    0.464339] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    0.464504] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    0.464721] NET: Registered protocol family 1
[    0.466283] pci 0000:03:00.0: Boot video device
[    0.466296] PCI: CLS mismatch (256 !=3D 64), using 64 bytes
[    0.466340] Unpacking initramfs...
[    0.740141] Freeing initrd memory: 14972K (ffff8800362b2000 - ffff880037=
151000)
[    0.740222] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.740286] software IO TLB [mem 0xbb780000-0xbf780000] (64MB) mapped at=
 [ffff8800bb780000-ffff8800bf77ffff]
[    0.740597] microcode: CPU0 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.740663] microcode: CPU1 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.740728] microcode: CPU2 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.740794] microcode: CPU3 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.740859] microcode: CPU4 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.740925] microcode: CPU5 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.740990] microcode: CPU6 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.741054] microcode: CPU7 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.741152] microcode: Microcode Update Driver: v2.00, Peter Oruba
[    0.741534] audit: initializing netlink socket (disabled)
[    0.741601] type=3D2000 audit(1389901199.596:1): initialized
[    0.756261] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.757090] VFS: Disk quotas dquot_6.5.2
[    0.757175] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.757306] msgmni has been set to 32768
[    0.758625] alg: No test for stdrng (krng)
[    0.758703] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    0.758819] io scheduler noop registered
[    0.758877] io scheduler deadline registered
[    0.758957] io scheduler cfq registered (default)
[    0.759186] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.759369] pcieport 0000:00:1c.0: irq 64 for MSI/MSI-X
[    0.759511] pcieport 0000:00:1c.4: irq 65 for MSI/MSI-X
[    0.759573] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.759644] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.759727] intel_idle: MWAIT substates: 0x1120
[    0.759737] intel_idle: v0.4 model 0x1A
[    0.759738] intel_idle: lapic_timer_reliable_states 0x2
[    0.759895] GHES: HEST is not enabled!
[    0.759992] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.782094] 00:0b: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    0.782514] Linux agpgart interface v0.103
[    0.782667] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.782730] i8042: PNP: PS/2 appears to have AUX port disabled, if this =
is incorrect please boot with i8042.nopnp
[    0.783288] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.783422] mousedev: PS/2 mouse device common for all mice
[    0.783512] rtc_cmos 00:02: RTC can wake from S4
[    0.783673] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.783757] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram=
, hpet irqs
[    0.783842] AMD IOMMUv2 driver by Joerg Roedel
[    0.785646] AMD IOMMUv2 functionality not available on this system
[    0.785791] TCP: cubic registered
[    0.787327] NET: Registered protocol family 10
[    0.788065] mip6: Mobile IPv6
[    0.788122] NET: Registered protocol family 17
[    0.788182] mpls_gso: MPLS GSO support
[    0.788553] registered taskstats version 1
[    0.789904] rtc_cmos 00:02: setting system clock to 2014-01-16 19:40:00 =
UTC (1389901200)
[    0.790000] PM: Hibernation image not present or could not be loaded.
[    0.790974] Freeing unused kernel memory: 988K (ffffffff818af000 - fffff=
fff819a6000)
[    0.791053] Write protecting the kernel read-only data: 8192k
[    0.794298] Freeing unused kernel memory: 1332K (ffff8800014b3000 - ffff=
880001600000)
[    0.795572] Freeing unused kernel memory: 456K (ffff88000178e000 - ffff8=
80001800000)
[    0.807675] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    0.857845] systemd-udevd[95]: starting version 204
[    0.874192] ACPI: bus type USB registered
[    0.874277] usbcore: registered new interface driver usbfs
[    0.874349] usbcore: registered new interface driver hub
[    0.874975] SCSI subsystem initialized
[    0.875218] usbcore: registered new device driver usb
[    0.875999] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.876068] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 1
[    0.876281] libata version 3.00 loaded.
[    0.876284] xhci_hcd 0000:02:00.0: irq 66 for MSI/MSI-X
[    0.876291] xhci_hcd 0000:02:00.0: irq 67 for MSI/MSI-X
[    0.876298] xhci_hcd 0000:02:00.0: irq 68 for MSI/MSI-X
[    0.876304] xhci_hcd 0000:02:00.0: irq 69 for MSI/MSI-X
[    0.876308] xhci_hcd 0000:02:00.0: irq 70 for MSI/MSI-X
[    0.876313] xhci_hcd 0000:02:00.0: irq 71 for MSI/MSI-X
[    0.876317] xhci_hcd 0000:02:00.0: irq 72 for MSI/MSI-X
[    0.876321] xhci_hcd 0000:02:00.0: irq 73 for MSI/MSI-X
[    0.876421] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    0.876485] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.876565] usb usb1: Product: xHCI Host Controller
[    0.876630] usb usb1: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
[    0.876696] usb usb1: SerialNumber: 0000:02:00.0
[    0.876863] hub 1-0:1.0: USB hub found
[    0.876935] hub 1-0:1.0: 2 ports detected
[    0.877112] ahci 0000:00:1f.2: version 3.0
[    0.877151] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.877218] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 2
[    0.877268] ahci 0000:00:1f.2: irq 74 for MSI/MSI-X
[    0.877331] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x=
3f impl SATA mode
[    0.877415] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp=
 pio slum part ccc ems sxs
[    0.879590] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.879825] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    0.879892] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.879975] usb usb2: Product: xHCI Host Controller
[    0.880039] usb usb2: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
[    0.880105] usb usb2: SerialNumber: 0000:02:00.0
[    0.880179] ehci-pci: EHCI PCI platform driver
[    0.880180] uhci_hcd: USB Universal Host Controller Interface driver
[    0.880270] hub 2-0:1.0: USB hub found
[    0.880277] hub 2-0:1.0: 2 ports detected
[    0.883123] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    0.883270] r8169 0000:07:01.0 (unregistered net_device): not PCI Express
[    0.885421] r8169 0000:07:01.0 eth0: RTL8169sc/8110sc at 0xffffc9000307e=
000, 54:04:a6:49:30:b0, XID 18000000 IRQ 19
[    0.885534] r8169 0000:07:01.0 eth0: jumbo features [frames: 7152 bytes,=
 tx checksumming: ok]
[    0.918863] scsi0 : ahci
[    0.919220] scsi1 : ahci
[    0.919432] scsi2 : ahci
[    0.919597] scsi3 : ahci
[    0.919756] scsi4 : ahci
[    0.919908] scsi5 : ahci
[    0.919990] ata1: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc10=
0 irq 74
[    0.920069] ata2: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc18=
0 irq 74
[    0.920147] ata3: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc20=
0 irq 74
[    0.920225] ata4: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc28=
0 irq 74
[    0.920303] ata5: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc30=
0 irq 74
[    0.920381] ata6: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc38=
0 irq 74
[    0.920547] ahci 0000:01:00.0: irq 75 for MSI/MSI-X
[    0.920561] ahci 0000:01:00.0: controller can do FBS, turning on CAP_FBS
[    0.920620] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.920624] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus =
number 3
[    0.920661] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a800
[    0.920713] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.920715] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.920716] usb usb3: Product: UHCI Host Controller
[    0.920717] usb usb3: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.920718] usb usb3: SerialNumber: 0000:00:1a.0
[    0.920845] hub 3-0:1.0: USB hub found
[    0.920850] hub 3-0:1.0: 2 ports detected
[    0.921056] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.921060] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus =
number 4
[    0.921095] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
[    0.921144] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.921146] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.921147] usb usb4: Product: UHCI Host Controller
[    0.921148] usb usb4: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.921148] usb usb4: SerialNumber: 0000:00:1a.1
[    0.921244] hub 4-0:1.0: USB hub found
[    0.921248] hub 4-0:1.0: 2 ports detected
[    0.921453] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.921458] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus =
number 5
[    0.921496] uhci_hcd 0000:00:1a.2: irq 19, io base 0x0000ac00
[    0.921546] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.921547] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.921548] usb usb5: Product: UHCI Host Controller
[    0.921549] usb usb5: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.921550] usb usb5: SerialNumber: 0000:00:1a.2
[    0.921644] hub 5-0:1.0: USB hub found
[    0.921650] hub 5-0:1.0: 2 ports detected
[    0.921840] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.921845] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus =
number 6
[    0.921880] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a080
[    0.921930] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.921932] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.921933] usb usb6: Product: UHCI Host Controller
[    0.921935] usb usb6: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.921936] usb usb6: SerialNumber: 0000:00:1d.0
[    0.922018] hub 6-0:1.0: USB hub found
[    0.922023] hub 6-0:1.0: 2 ports detected
[    0.922221] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.922225] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus =
number 7
[    0.922252] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
[    0.922297] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.922299] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.922300] usb usb7: Product: UHCI Host Controller
[    0.922301] usb usb7: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.922302] usb usb7: SerialNumber: 0000:00:1d.1
[    0.922389] hub 7-0:1.0: USB hub found
[    0.922395] hub 7-0:1.0: 2 ports detected
[    0.922577] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.922581] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus =
number 8
[    0.922605] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a480
[    0.922652] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.922654] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.922655] usb usb8: Product: UHCI Host Controller
[    0.922656] usb usb8: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.922657] usb usb8: SerialNumber: 0000:00:1d.2
[    0.922745] hub 8-0:1.0: USB hub found
[    0.922750] hub 8-0:1.0: 2 ports detected
[    0.923125] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.923129] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus =
number 9
[    0.923140] ehci-pci 0000:00:1a.7: debug port 1
[    0.927035] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    0.927044] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9dff000
[    0.937486] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.937515] ahci 0000:01:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0x=
ff impl SATA mode
[    0.937517] ahci 0000:01:00.0: flags: 64bit ncq fbs pio
[    0.937713] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    0.937776] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.937854] usb usb9: Product: EHCI Host Controller
[    0.937914] usb usb9: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
[    0.937976] usb usb9: SerialNumber: 0000:00:1a.7
[    0.938180] hub 9-0:1.0: USB hub found
[    0.938208] scsi6 : ahci
[    0.938299] hub 9-0:1.0: 6 ports detected
[    0.938349] scsi7 : ahci
[    0.938473] scsi8 : ahci
[    0.938629] scsi9 : ahci
[    0.938815] scsi10 : ahci
[    0.938964] scsi11 : ahci
[    0.939120] scsi12 : ahci
[    0.939277] scsi13 : ahci
[    0.939361] ata7: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff10=
0 irq 75
[    0.939439] ata8: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff18=
0 irq 75
[    0.939517] ata9: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff20=
0 irq 75
[    0.939596] ata10: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff2=
80 irq 75
[    0.939674] ata11: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff3=
00 irq 75
[    0.939753] ata12: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff3=
80 irq 75
[    0.939831] ata13: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff4=
00 irq 75
[    0.939909] ata14: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff4=
80 irq 75
[    0.940100] ahci 0000:05:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x=
3 impl SATA mode
[    0.940182] ahci 0000:05:00.0: flags: 64bit ncq pm led clo pmp pio slum =
part
[    0.940472] scsi14 : ahci
[    0.940586] scsi15 : ahci
[    0.940674] ata15: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff10=
0 irq 16
[    0.940754] ata16: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff18=
0 irq 16
[    0.957676] firewire_ohci 0000:07:02.0: added OHCI v1.10 device as card =
0, 4 IR + 8 IT contexts, quirks 0x11
[    0.961649] hub 3-0:1.0: USB hub found
[    0.961719] hub 3-0:1.0: 2 ports detected
[    0.985590] hub 4-0:1.0: USB hub found
[    0.985660] hub 4-0:1.0: 2 ports detected
[    1.009642] hub 5-0:1.0: USB hub found
[    1.009708] hub 5-0:1.0: 2 ports detected
[    1.010104] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.010168] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus =
number 10
[    1.010258] ehci-pci 0000:00:1d.7: debug port 1
[    1.014216] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    1.014222] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9dfe000
[    1.025591] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.025687] usb usb10: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.025751] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    1.025829] usb usb10: Product: EHCI Host Controller
[    1.025889] usb usb10: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
[    1.025950] usb usb10: SerialNumber: 0000:00:1d.7
[    1.026309] hub 10-0:1.0: USB hub found
[    1.026377] hub 10-0:1.0: 6 ports detected
[    1.051054] hub 6-0:1.0: USB hub found
[    1.051120] hub 6-0:1.0: 2 ports detected
[    1.073673] hub 7-0:1.0: USB hub found
[    1.073743] hub 7-0:1.0: 2 ports detected
[    1.097672] hub 8-0:1.0: USB hub found
[    1.097745] hub 8-0:1.0: 2 ports detected
[    1.257759] ata10: SATA link down (SStatus 0 SControl 300)
[    1.257788] ata15: SATA link down (SStatus 0 SControl 300)
[    1.257904] ata13: SATA link down (SStatus 0 SControl 300)
[    1.257980] ata12: SATA link down (SStatus 0 SControl 300)
[    1.258056] ata9: SATA link down (SStatus 0 SControl 300)
[    1.258070] ata16: SATA link down (SStatus 0 SControl 300)
[    1.258193] ata8: SATA link down (SStatus 0 SControl 300)
[    1.258269] ata11: SATA link down (SStatus 0 SControl 300)
[    1.258344] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.258533] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
[    1.258827] ata14.00: configured for UDMA/66
[    1.266639] ata7: SATA link down (SStatus 0 SControl 300)
[    1.409816] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.409900] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.409975] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.410050] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.410124] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.410198] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.411015] ata4.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.411093] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.411360] ata1.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.411427] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.411500] ata6.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.411576] ata6.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.411647] ata5.00: ATA-8: ST31000340AS, SD15, max UDMA/133
[    1.411710] ata5.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.411784] ata3.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.411847] ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.412562] ata2.00: ATAPI: TSSTcorpCD/DVDW SH-S183L, SB01, max UDMA/33
[    1.412631] ata2.00: applying bridge limits
[    1.412847] ata1.00: configured for UDMA/133
[    1.412922] ata4.00: configured for UDMA/133
[    1.413127] ata6.00: configured for UDMA/133
[    1.413207] ata3.00: configured for UDMA/133
[    1.413256] scsi 0:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.413773] ata5.00: configured for UDMA/133
[    1.415948] ata2.00: configured for UDMA/33
[    1.417930] scsi 1:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183L SB=
01 PQ: 0 ANSI: 5
[    1.418198] scsi 2:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.418453] scsi 3:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.418690] scsi 4:0:0:0: Direct-Access     ATA      ST31000340AS     SD=
15 PQ: 0 ANSI: 5
[    1.418954] scsi 5:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.419344] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.419371] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.419414] sd 2:0:0:0: [sdb] Write Protect is off
[    1.419416] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.419435] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.419596] sd 3:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.419617] sd 5:0:0:0: [sde] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.419621] sd 4:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.419674] sd 5:0:0:0: [sde] Write Protect is off
[    1.419676] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    1.419711] sd 3:0:0:0: [sdc] Write Protect is off
[    1.419712] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.419714] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    1.419722] sd 4:0:0:0: [sdd] Write Protect is off
[    1.419724] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    1.419740] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.419786] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.420390] sd 0:0:0:0: [sda] Write Protect is off
[    1.420453] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.420480] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.420490] scsi 13:0:0:0: Processor         Marvell  91xx Config      1=
.01 PQ: 0 ANSI: 5
[    1.421132] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.421228] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    1.421318] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    1.421410] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    1.421501] sd 4:0:0:0: Attached scsi generic sg4 type 0
[    1.421589] sd 5:0:0:0: Attached scsi generic sg5 type 0
[    1.421688] scsi 13:0:0:0: Attached scsi generic sg6 type 3
[    1.425550]  sda: sda1 sda2 sda3
[    1.425885] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    1.425951] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.426024] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.426174] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.434266]  sde: sde1 sde2 sde3
[    1.435114] sd 5:0:0:0: [sde] Attached SCSI disk
[    1.435477]  sdd: sdd1 sdd2 sdd3
[    1.435558]  sdb: sdb1 sdb2 sdb3
[    1.435946] sd 4:0:0:0: [sdd] Attached SCSI disk
[    1.435985] sd 2:0:0:0: [sdb] Attached SCSI disk
[    1.449048]  sdc: sdc1 sdc2 sdc3
[    1.449800] sd 3:0:0:0: [sdc] Attached SCSI disk
[    1.457782] firewire_core 0000:07:02.0: created device fw0: GUID 001fc60=
0001acd8c, S400
[    1.723574] random: nonblocking pool is initialized
[    1.737725] tsc: Refined TSC clocksource calibration: 2806.363 MHz
[    1.782713] md: md127 stopped.
[    1.785412] md: bind
[    1.785653] md: bind
[    1.786465] md: bind
[    1.792633] md: bind
[    1.792886] md: bind
[    1.794330] md: raid10 personality registered for level 10
[    1.794987] md/raid10:md127: active with 4 out of 4 devices
[    1.795221] created bitmap (466 pages) for device md127
[    1.808717] md127: bitmap initialized from disk: read 30 pages, set 0 of=
 953616 bits
[    1.833843] usb 8-1: new low-speed USB device number 2 using uhci_hcd
[    1.839039] md127: detected capacity change from 0 to 1999877701632
[    1.839176] RAID10 conf printout:
[    1.839177]  --- wd:4 rd:4
[    1.839178]  disk 0, wo:0, o:1, dev:sda3
[    1.839180]  disk 1, wo:0, o:1, dev:sdc3
[    1.839182]  disk 2, wo:0, o:1, dev:sdb3
[    1.839183]  disk 3, wo:0, o:1, dev:sdd3
[    1.840591]  md127: unknown partition table
[    1.876071] device-mapper: uevent: version 1.0.3
[    1.876194] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised:=
 dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    1.923759] bio: create slab  at 1
[    1.998427] EXT4-fs (dm-0): INFO: recovery required on readonly filesyst=
em
[    1.998493] EXT4-fs (dm-0): write access will be enabled during recovery
[    2.010915] usb 8-1: New USB device found, idVendor=3D046d, idProduct=3D=
c01e
[    2.010979] usb 8-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.011043] usb 8-1: Product: USB-PS/2 Optical Mouse
[    2.011103] usb 8-1: Manufacturer: Logitech
[    2.017732] hidraw: raw HID events driver (C) Jiri Kosina
[    2.034182] usbcore: registered new interface driver usbhid
[    2.034246] usbhid: USB HID core driver
[    2.036312] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:0=
0/0000:00:1d.2/usb8/8-1/8-1:1.0/input/input1
[    2.036682] hid-generic 0003:046D:C01E.0001: input,hidraw0: USB HID v1.1=
0 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-1/input0
[    2.182901] RAID10 conf printout:
[    2.182906]  --- wd:4 rd:4
[    2.182909]  disk 0, wo:0, o:1, dev:sda3
[    2.182912]  disk 1, wo:0, o:1, dev:sdc3
[    2.182914]  disk 2, wo:0, o:1, dev:sdb3
[    2.182916]  disk 3, wo:0, o:1, dev:sdd3
[    2.253955] usb 8-2: new low-speed USB device number 3 using uhci_hcd
[    2.564146] usb 8-2: New USB device found, idVendor=3D051d, idProduct=3D=
0002
[    2.564212] usb 8-2: New USB device strings: Mfr=3D3, Product=3D1, Seria=
lNumber=3D2
[    2.564276] usb 8-2: Product: Back-UPS RS 1500 FW:8.g9 .D USB FW:g9
[    2.564338] usb 8-2: Manufacturer: American Power Conversion
[    2.564399] usb 8-2: SerialNumber: JB0539032829
[    2.738444] Switched to clocksource tsc
[    2.826648] EXT4-fs (dm-0): recovery complete
[    2.832962] EXT4-fs (dm-0): mounted filesystem with ordered data mode. O=
pts: (null)
[    3.638785] hid-generic 0003:051D:0002.0002: hiddev0,hidraw1: USB HID v1=
.10 Device [American Power Conversion Back-UPS RS 1500 FW:8.g9 .D USB FW:g9=
 ] on usb-0000:00:1d.2-2/input0
[   16.436731] systemd-udevd[601]: starting version 204
[   17.122658] ACPI Warning: 0x0000000000000828-0x000000000000082f SystemIO=
 conflicts with Region \PMRG 1 (20131115/utaddress-251)
[   17.122835] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   17.122919] ACPI Warning: 0x0000000000000530-0x000000000000053f SystemIO=
 conflicts with Region \GPS0 1 (20131115/utaddress-251)
[   17.123078] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   17.123160] ACPI Warning: 0x0000000000000500-0x000000000000052f SystemIO=
 conflicts with Region \GPS0 1 (20131115/utaddress-251)
[   17.123319] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   17.123400] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   17.135153] ACPI Warning: 0x0000000000001000-0x000000000000101f SystemIO=
 conflicts with Region \SMRG 1 (20131115/utaddress-251)
[   17.135316] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   17.140636] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input2
[   17.140720] ACPI: Power Button [PWRB]
[   17.140811] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[   17.140889] ACPI: Power Button [PWRF]
[   17.146076] EDAC MC: Ver: 3.0.0
[   17.161008] wmi: Mapper loaded
[   17.161416] EDAC MC0: Giving out device to module i7core_edac.c controll=
er i7 core #0: DEV 0000:ff:03.0 (POLLED)
[   17.161542] EDAC PCI0: Giving out device to module i7core_edac controlle=
r EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)
[   17.161635] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   17.187751] ATK0110 ATK0110:00: Overriding interface detection
[   17.208448] [drm] Initialized drm 1.1.0 20060810
[   17.258795] systemd-udevd[641]: renamed network interface eth0 to lan
[   17.348444] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   17.390538] md: bind
[   17.454823] md: bind
[   17.457909] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work proper=
ly. Using workaround
[   17.471002] md: bind
[   17.481909] iTCO_vendor_support: vendor-support=3D0
[   17.494984] md: bind
[   17.506609] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[   17.506701] iTCO_wdt: Found a ICH10R TCO device (Version=3D2, TCOBASE=3D=
0x0860)
[   17.506934] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D1)
[   17.521259] md: bind
[   17.546721] nouveau: unknown parameter 'perflvl_wr' ignored
[   17.546976] MXM: GUID detected in BIOS
[   17.547289] nouveau  [  DEVICE][0000:03:00.0] BOOT0  : 0x0c1000a1
[   17.547352] nouveau  [  DEVICE][0000:03:00.0] Chipset: GF108 (NVC1)
[   17.547414] nouveau  [  DEVICE][0000:03:00.0] Family : NVC0
[   17.548355] nouveau  [   VBIOS][0000:03:00.0] checking PRAMIN for image.=
..
[   17.613840] nouveau  [   VBIOS][0000:03:00.0] ... appears to be valid
[   17.613904] nouveau  [   VBIOS][0000:03:00.0] using image from PRAMIN
[   17.614062] nouveau  [   VBIOS][0000:03:00.0] BIT signature found
[   17.614124] nouveau  [   VBIOS][0000:03:00.0] version 70.08.4d.00.00
[   17.614478] nouveau 0000:03:00.0: irq 76 for MSI/MSI-X
[   17.614486] nouveau  [     PMC][0000:03:00.0] MSI interrupts enabled
[   17.614599] nouveau W[     PFB][0000:03:00.0][0x00000000][ffff88061e5638=
00] reclocking of this ram type unsupported
[   17.614723] nouveau  [     PFB][0000:03:00.0] RAM type: DDR3
[   17.614813] nouveau  [     PFB][0000:03:00.0] RAM size: 512 MiB
[   17.614905] nouveau  [     PFB][0000:03:00.0]    ZCOMP: 0 tags
[   17.626916] md: raid1 personality registered for level 1
[   17.627251] md/raid1:md0: active with 5 out of 5 mirrors
[   17.635869] created bitmap (16 pages) for device md0
[   17.644661] md0: bitmap initialized from disk: read 2 pages, set 0 of 32=
096 bits
[   17.646103] nouveau  [  PTHERM][0000:03:00.0] FAN control: none / extern=
al
[   17.646214] nouveau  [  PTHERM][0000:03:00.0] fan management: automatic
[   17.646307] nouveau  [  PTHERM][0000:03:00.0] internal sensor: yes
[   17.646423] nouveau  [     CLK][0000:03:00.0] 03: core 50 MHz memory 135=
 MHz
[   17.646516] nouveau  [     CLK][0000:03:00.0] 07: core 405 MHz memory 32=
4 MHz
[   17.646624] nouveau  [     CLK][0000:03:00.0] 0f: core 810 MHz memory 90=
0 MHz
[   17.646883] nouveau  [     CLK][0000:03:00.0] --: core 405 MHz memory 32=
4 MHz
[   17.656891] [TTM] Zone  kernel: Available graphics memory: 12368142 kiB
[   17.656984] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   17.657075] [TTM] Initializing pool allocator
[   17.657165] [TTM] Initializing DMA pool allocator
[   17.657259] nouveau  [     DRM] VRAM: 512 MiB
[   17.657346] nouveau  [     DRM] GART: 1048576 MiB
[   17.657435] nouveau  [     DRM] TMDS table version 2.0
[   17.657523] nouveau  [     DRM] DCB version 4.0
[   17.657611] nouveau  [     DRM] DCB outp 00: 01000302 00020030
[   17.657700] nouveau  [     DRM] DCB outp 01: 02000300 00000000
[   17.657789] nouveau  [     DRM] DCB outp 02: 08011392 00020020
[   17.657878] nouveau  [     DRM] DCB outp 03: 04022310 00000000
[   17.657968] nouveau  [     DRM] DCB conn 00: 00001030
[   17.658129] nouveau  [     DRM] DCB conn 01: 00002161
[   17.658281] nouveau  [     DRM] DCB conn 02: 00000200
[   17.659044] md0: detected capacity change from 0 to 131465216
[   17.659181] RAID1 conf printout:
[   17.659184]  --- wd:5 rd:5
[   17.659186]  disk 0, wo:0, o:1, dev:sda1
[   17.659188]  disk 1, wo:0, o:1, dev:sdc1
[   17.659190]  disk 2, wo:0, o:1, dev:sdb1
[   17.659192]  disk 3, wo:0, o:1, dev:sdd1
[   17.659194]  disk 4, wo:0, o:1, dev:sde1
[   17.659321] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   17.659412] [drm] No driver support for vblank timestamp query.
[   17.660722]  md0: unknown partition table
[   17.672199] snd_hda_intel 0000:00:1b.0: irq 77 for MSI/MSI-X
[   17.674214] nouveau  [     DRM] MM: using COPY0 for buffer copies
[   17.706907] input: HDA Intel Front Headphone as /devices/pci0000:00/0000=
:00:1b.0/sound/card0/input12
[   17.707078] input: HDA Intel Line Out Side as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input11
[   17.707232] input: HDA Intel Line Out CLFE as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input10
[   17.707383] input: HDA Intel Line Out Surround as /devices/pci0000:00/00=
00:00:1b.0/sound/card0/input9
[   17.707629] input: HDA Intel Line Out Front as /devices/pci0000:00/0000:=
00:1b.0/sound/card0/input8
[   17.707847] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/so=
und/card0/input7
[   17.708059] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.=
0/sound/card0/input6
[   17.708274] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b=
.0/sound/card0/input5
[   17.760922] nouveau  [     DRM] allocated 1024x768 fb: 0x60000, bo ffff8=
8061c846400
[   17.761352] fbcon: nouveaufb (fb0) is primary device
[   17.839459] Console: switching to colour frame buffer device 128x48
[   17.840460] nouveau 0000:03:00.0: fb0: nouveaufb frame buffer device
[   17.840472] nouveau 0000:03:00.0: registered panic notifier
[   17.840487] [drm] Initialized nouveau 1.1.1 20120801 for 0000:03:00.0 on=
 minor 0
[   17.840578] hda_intel: Disabling MSI
[   17.840600] hda-intel 0000:03:00.1: Handle VGA-switcheroo audio client
[   18.659216] input: HDA NVidia HDMI/DP,pcm=3D9 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input16
[   18.659450] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input15
[   18.659655] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input14
[   18.659873] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input13
[   19.290563] EXT4-fs (dm-0): re-mounted. Opts: (null)
[   19.750641] EXT4-fs (dm-0): re-mounted. Opts: user_xattr,errors=3Dremoun=
t-ro
[   20.131119] loop: module loaded
[   21.421068] Adding 5857276k swap on /dev/mapper/Zia-swap_crypt.  Priorit=
y:-1 extents:1 across:5857276k
[   23.426672] EXT4-fs (md0): mounting ext2 file system using the ext4 subs=
ystem
[   23.477651] EXT4-fs (md0): mounted filesystem without journal. Opts: (nu=
ll)
[   23.532841] EXT4-fs (dm-3): mounted filesystem with ordered data mode. O=
pts: user_xattr
[   23.549520] EXT4-fs (dm-2): mounted filesystem with ordered data mode. O=
pts: user_xattr
[   23.617604] FAT-fs (sda2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   23.652195] FAT-fs (sda2): Volume was not properly unmounted. Some data =
may be corrupt. Please run fsck.
[   23.667139] FAT-fs (sdc2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   23.673819] FAT-fs (sdc2): Volume was not properly unmounted. Some data =
may be corrupt. Please run fsck.
[   23.724106] FAT-fs (sdb2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   23.735226] FAT-fs (sdb2): Volume was not properly unmounted. Some data =
may be corrupt. Please run fsck.
[   23.797771] FAT-fs (sdd2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   23.809288] FAT-fs (sdd2): Volume was not properly unmounted. Some data =
may be corrupt. Please run fsck.
[   24.796457] Bridge firewalling registered
[   24.801378] device lan entered promiscuous mode
[   24.813799] r8169 0000:07:01.0 lan: link down
[   24.813827] r8169 0000:07:01.0 lan: link down
[   24.816340] IPv6: ADDRCONF(NETDEV_UP): lan: link is not ready
[   24.819397] IPv6: ADDRCONF(NETDEV_UP): br0: link is not ready
[   27.837495] r8169 0000:07:01.0 lan: link up
[   27.837767] IPv6: ADDRCONF(NETDEV_CHANGE): lan: link becomes ready
[   27.838706] br0: port 1(lan) entered forwarding state
[   27.840323] br0: port 1(lan) entered forwarding state
[   27.841969] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[   28.805597] RPC: Registered named UNIX socket transport module.
[   28.805823] RPC: Registered udp transport module.
[   28.806081] RPC: Registered tcp transport module.
[   28.806552] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   28.815636] FS-Cache: Loaded
[   28.830140] FS-Cache: Netfs 'nfs' registered for caching
[   28.886841] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
[   29.842611] br0: port 1(lan) entered forwarding state



**** VT-d=3DON (3)

[    0.000000] CPU0 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.13.0-rc8+ (anthony@Zia) (gcc version 4.8.2 (=
Debian 4.8.2-12) ) #7 SMP Thu Jan 16 12:36:44 EST 2014
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.13.0-rc8+ root=3D/dev/=
mapper/Zia-root ro single verbose
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e2c00-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf797fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000bf798000-0x00000000bf7d9fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf7da000-0x00000000bfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000063fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: System manufacturer System Product Name/SABERTOOTH X58,=
 BIOS 1402    08/09/2012
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x640000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EBFFF write-through
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask C00000000 write-back
[    0.000000]   1 base 400000000 mask E00000000 write-back
[    0.000000]   2 base 600000000 mask FC0000000 write-back
[    0.000000]   3 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   4 base 0BF800000 mask FFF800000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820: update [mem 0xbf800000-0xffffffff] usable =3D=3D> rese=
rved
[    0.000000] e820: last_pfn =3D 0xbf780 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at =
[ffff8800000ff780]
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01a9b000, 0x01a9bfff] PGTABLE
[    0.000000] BRK [0x01a9c000, 0x01a9cfff] PGTABLE
[    0.000000] BRK [0x01a9d000, 0x01a9dfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x63fe00000-0x63fffffff]
[    0.000000]  [mem 0x63fe00000-0x63fffffff] page 2M
[    0.000000] BRK [0x01a9e000, 0x01a9efff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x63c000000-0x63fdfffff]
[    0.000000]  [mem 0x63c000000-0x63fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x600000000-0x63bffffff]
[    0.000000]  [mem 0x600000000-0x63bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xbf77ffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0xbf5fffff] page 2M
[    0.000000]  [mem 0xbf600000-0xbf77ffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x5ffffffff]
[    0.000000]  [mem 0x100000000-0x5ffffffff] page 2M
[    0.000000] BRK [0x01a9f000, 0x01a9ffff] PGTABLE
[    0.000000] BRK [0x01aa0000, 0x01aa0fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x362b2000-0x37150fff]
[    0.000000] ACPI: RSDP 00000000000fb940 000024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 00000000bf780100 00006C (v01 080912 XSDT1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000bf780290 0000F4 (v03 080912 FACP1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: DSDT 00000000bf7804b0 00C469 (v01  A1682 A1682001 0000=
0001 INTL 20060113)
[    0.000000] ACPI: FACS 00000000bf798000 000040
[    0.000000] ACPI: APIC 00000000bf780390 0000D8 (v01 080912 APIC1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000bf780470 00003C (v01 080912 OEMMCFG  2012=
0809 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000bf798040 000072 (v01 080912 OEMB1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000bf78f4b0 000038 (v01 080912 OEMHPET  2012=
0809 MSFT 00000097)
[    0.000000] ACPI: DMAR 00000000bf7980c0 000140 (v01    AMI  OEMDMAR 0000=
0001 MSFT 00000097)
[    0.000000] ACPI: ASPT 00000000bf7984b0 000034 (v06 080912 PerfTune 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: OSFR 00000000bf78f4f0 0000B0 (v01 080912 OEMOSFR  2012=
0809 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000bf79a970 000363 (v01 DpgPmm    CpuPm 0000=
0012 INTL 20060113)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000063fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x63fffffff]
[    0.000000]   NODE_DATA [mem 0x63ffe6000-0x63ffeafff]
[    0.000000]  [ffffea0000000000-ffffea0015dfffff] PMD -> [ffff88062760000=
0-ffff88063c5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x63fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xbf77ffff]
[    0.000000]   node   0: [mem 0x100000000-0x63fffffff]
[    0.000000] On node 0 totalpages: 6289181
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 10667 pages used for memmap
[    0.000000]   DMA32 zone: 780160 pages, LIFO batch:31
[    0.000000]   Normal zone: 75264 pages used for memmap
[    0.000000]   Normal zone: 5505024 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec8a000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec8a000, GSI 24=
-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
[    0.000000] nr_irqs_gsi: 64
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e2fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e3000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf780000-0xbf797fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf798000-0xbf7d9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf7da000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffdfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffe00000-0xffffffff]
[    0.000000] e820: [mem 0xc0000000-0xfedfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:16 =
nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88063fc00000 s85824 r8192=
 d20672 u131072
[    0.000000] pcpu-alloc: s85824 r8192 d20672 u131072 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14=
 15
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 6203173
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-3.13.0-rc8+ root=
=3D/dev/mapper/Zia-root ro single verbose
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 24718516K/25156724K available (4799K kernel code, 69=
2K rwdata, 1592K rodata, 988K init, 952K bss, 438208K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=3D16.
[    0.000000] NR_IRQS:33024 nr_irqs:1216 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 100663296 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration failed
[    0.008000] tsc: PIT calibration matches HPET. 1 loops
[    0.008000] tsc: Detected 2806.421 MHz processor
[    0.000003] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5612.84 BogoMIPS (lpj=3D11225684)
[    0.000124] pid_max: default: 32768 minimum: 301
[    0.000216] Security Framework initialized
[    0.000276] AppArmor: AppArmor disabled by boot time parameter
[    0.000338] Yama: becoming mindful.
[    0.002286] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes)
[    0.010492] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes)
[    0.013884] Mount-cache hash table entries: 256
[    0.014106] Initializing cgroup subsys memory
[    0.014170] Initializing cgroup subsys devices
[    0.014229] Initializing cgroup subsys freezer
[    0.014289] Initializing cgroup subsys blkio
[    0.014348] Initializing cgroup subsys perf_event
[    0.014427] CPU: Physical Processor ID: 0
[    0.014485] CPU: Processor Core ID: 0
[    0.014546] mce: CPU supports 9 MCE banks
[    0.014615] CPU0: Thermal monitoring enabled (TM1)
[    0.014683] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.014683] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
[    0.014683] tlb_flushall_shift: 6
[    0.014848] Freeing SMP alternatives memory: 20K (ffffffff819a6000 - fff=
fffff819ab000)
[    0.015935] ACPI: Core revision 20131115
[    0.019433] ACPI: All ACPI Tables successfully acquired
[    0.065638] dmar: Host address width 39
[    0.065699] dmar: DRHD base: 0x000000fbfff000 flags: 0x0
[    0.065766] dmar: IOMMU 0: reg_base_addr fbfff000 ver 1:0 cap c9008010e6=
0262 ecap f0207a
[    0.065846] dmar: DRHD base: 0x000000fbffe000 flags: 0x1
[    0.065911] dmar: IOMMU 1: reg_base_addr fbffe000 ver 1:0 cap c90780106f=
0462 ecap f020fe
[    0.065990] dmar: RMRR base: 0x000000000ec000 end: 0x000000000effff
[    0.066053] dmar: RMRR base: 0x000000bf7ea000 end: 0x000000bf7fffff
[    0.066115] dmar: ATSR flags: 0x0
[    0.066268] This system BIOS has enabled interrupt remapping
[    0.066268] on a chipset that contains an erratum making that
[    0.066268] feature unstable.  To maintain system stability
[    0.066268] interrupt remapping is being disabled.  Please
[    0.066268] contact your BIOS vendor for an update
[    0.066483] Switched APIC routing to physical flat.
[    0.067047] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.109736] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         930  @ 2.80G=
Hz (fam: 06, model: 1a, stepping: 05)
[    0.216477] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events,=
 Intel PMU driver.
[    0.216711] perf_event_intel: CPU erratum AAJ80 worked around
[    0.216772] perf_event_intel: CPUID marked event: 'bus cycles' unavailab=
le
[    0.216838] ... version:                3
[    0.216896] ... bit width:              48
[    0.216954] ... generic registers:      4
[    0.217013] ... value mask:             0000ffffffffffff
[    0.217073] ... max period:             000000007fffffff
[    0.217134] ... fixed-purpose events:   3
[    0.217192] ... event mask:             000000070000000f
[    0.217597] x86: Booting SMP configuration:
[    0.231397] CPU1 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.233588] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    0.247954] CPU2 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.265504] CPU3 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.217657] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.329621] x86: Booted up 1 node, 8 CPUs
[    0.329733] smpboot: Total of 8 processors activated (44902.73 BogoMIPS)
[    0.334335] devtmpfs: initialized
[    0.337892] PM: Registering ACPI NVS region [mem 0xbf798000-0xbf7d9fff] =
(270336 bytes)
[    0.338118] NET: Registered protocol family 16
[    0.338247] cpuidle: using governor ladder
[    0.338305] cpuidle: using governor menu
[    0.338382] ACPI: bus type PCI registered
[    0.338440] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.338568] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.338649] PCI: not using MMCONFIG
[    0.338706] PCI: Using configuration type 1 for base access
[    0.339488] bio: create slab  at 0
[    0.339656] ACPI: Added _OSI(Module Device)
[    0.339715] ACPI: Added _OSI(Processor Device)
[    0.339774] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.339833] ACPI: Added _OSI(Processor Aggregator Device)
[    0.343827] ACPI: Executed 1 blocks of module-level executable AML code
[    0.376569] ACPI: SSDT 00000000bf7984f0 001E1C (v01 DpgPmm  P001Ist 0000=
0011 INTL 20060113)
[    0.377025] ACPI: Dynamic OEM Table Load:
[    0.377157] ACPI: SSDT           (null) 001E1C (v01 DpgPmm  P001Ist 0000=
0011 INTL 20060113)
[    0.377389] ACPI: SSDT 00000000bf79a310 000659 (v01  PmRef  P001Cst 0000=
3001 INTL 20060113)
[    0.377742] ACPI: Dynamic OEM Table Load:
[    0.377874] ACPI: SSDT           (null) 000659 (v01  PmRef  P001Cst 0000=
3001 INTL 20060113)
[    0.378199] ACPI: Interpreter enabled
[    0.378263] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S2_] (20131115/hwxface-580)
[    0.378427] ACPI: (supports S0 S1 S3 S4 S5)
[    0.378485] ACPI: Using IOAPIC for interrupt routing
[    0.378563] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.379504] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACP=
I motherboard resources
[    0.393443] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.393635] ACPI: No dock devices found.
[    0.399594] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.399660] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    0.399741] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.400091] PCI host bridge to bus 0000:00
[    0.400151] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.400212] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.400274] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.400336] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f]
[    0.400400] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dfff=
f]
[    0.400462] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdffffff=
f]
[    0.400528] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed8fff=
f]
[    0.400599] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000
[    0.400642] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.400710] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    0.400755] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.400800] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.400886] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
[    0.400930] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.400974] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.401060] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    0.401104] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.401148] pci 0000:00:03.0: System wakeup disabled by ACPI
[    0.401236] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    0.401277] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.401322] pci 0000:00:07.0: System wakeup disabled by ACPI
[    0.401413] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    0.401503] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    0.401592] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    0.401679] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
[    0.401765] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    0.401801] pci 0000:00:1a.0: reg 0x20: [io  0xa800-0xa81f]
[    0.401883] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.401970] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    0.402006] pci 0000:00:1a.1: reg 0x20: [io  0xa880-0xa89f]
[    0.402088] pci 0000:00:1a.1: System wakeup disabled by ACPI
[    0.402174] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
[    0.402211] pci 0000:00:1a.2: reg 0x20: [io  0xac00-0xac1f]
[    0.402292] pci 0000:00:1a.2: System wakeup disabled by ACPI
[    0.402385] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    0.402404] pci 0000:00:1a.7: reg 0x10: [mem 0xf9dff000-0xf9dff3ff]
[    0.402482] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.402529] pci 0000:00:1a.7: System wakeup disabled by ACPI
[    0.402618] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300
[    0.402631] pci 0000:00:1b.0: reg 0x10: [mem 0xf9df8000-0xf9dfbfff 64bit]
[    0.402688] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.402754] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    0.402813] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.402860] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.402949] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    0.403008] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.403054] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    0.403142] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    0.403178] pci 0000:00:1d.0: reg 0x20: [io  0xa080-0xa09f]
[    0.403261] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.403347] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    0.403384] pci 0000:00:1d.1: reg 0x20: [io  0xa400-0xa41f]
[    0.403464] pci 0000:00:1d.1: System wakeup disabled by ACPI
[    0.403551] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    0.403587] pci 0000:00:1d.2: reg 0x20: [io  0xa480-0xa49f]
[    0.403668] pci 0000:00:1d.2: System wakeup disabled by ACPI
[    0.403763] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    0.403782] pci 0000:00:1d.7: reg 0x10: [mem 0xf9dfe000-0xf9dfe3ff]
[    0.403860] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.403907] pci 0000:00:1d.7: System wakeup disabled by ACPI
[    0.403991] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.404071] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    0.404158] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
[    0.404227] pci 0000:00:1f.0: address space collision: [io  0x0800-0x087=
f] conflicts with ACPI CPU throttle [??? 0x00000810-0x00000815 flags 0x8000=
0000]
[    0.404318] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6=
 GPIO
[    0.404383] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (=
mask 0003)
[    0.404555] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
[    0.404572] pci 0000:00:1f.2: reg 0x10: [io  0x9c00-0x9c07]
[    0.404578] pci 0000:00:1f.2: reg 0x14: [io  0x9880-0x9883]
[    0.404585] pci 0000:00:1f.2: reg 0x18: [io  0x9800-0x9807]
[    0.404591] pci 0000:00:1f.2: reg 0x1c: [io  0x9480-0x9483]
[    0.404598] pci 0000:00:1f.2: reg 0x20: [io  0x9400-0x941f]
[    0.404604] pci 0000:00:1f.2: reg 0x24: [mem 0xf9dfc000-0xf9dfc7ff]
[    0.404643] pci 0000:00:1f.2: PME# supported from D3hot
[    0.404711] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    0.404724] pci 0000:00:1f.3: reg 0x10: [mem 0xf9dfd000-0xf9dfd0ff 64bit]
[    0.404741] pci 0000:00:1f.3: reg 0x20: [io  0x1000-0x101f]
[    0.404851] pci 0000:01:00.0: [1b4b:9123] type 00 class 0x010601
[    0.404861] pci 0000:01:00.0: reg 0x10: [io  0xbc00-0xbc07]
[    0.404867] pci 0000:01:00.0: reg 0x14: [io  0xb880-0xb883]
[    0.404874] pci 0000:01:00.0: reg 0x18: [io  0xb800-0xb807]
[    0.404880] pci 0000:01:00.0: reg 0x1c: [io  0xb480-0xb483]
[    0.404886] pci 0000:01:00.0: reg 0x20: [io  0xb400-0xb40f]
[    0.404893] pci 0000:01:00.0: reg 0x24: [mem 0xf9eff000-0xf9eff7ff]
[    0.404899] pci 0000:01:00.0: reg 0x30: [mem 0xf9ee0000-0xf9eeffff pref]
[    0.404927] pci 0000:01:00.0: PME# supported from D3hot
[    0.412553] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.412622] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    0.412625] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
[    0.412687] pci 0000:02:00.0: [1033:0194] type 00 class 0x0c0330
[    0.412702] pci 0000:02:00.0: reg 0x10: [mem 0xf9ffe000-0xf9ffffff 64bit]
[    0.412774] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.420551] pci 0000:00:02.0: PCI bridge to [bus 02]
[    0.420617] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    0.420667] pci 0000:03:00.0: [10de:0de0] type 00 class 0x030000
[    0.420676] pci 0000:03:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
[    0.420685] pci 0000:03:00.0: reg 0x14: [mem 0xd8000000-0xdfffffff 64bit=
 pref]
[    0.420694] pci 0000:03:00.0: reg 0x1c: [mem 0xd6000000-0xd7ffffff 64bit=
 pref]
[    0.420700] pci 0000:03:00.0: reg 0x24: [io  0xcc00-0xcc7f]
[    0.420706] pci 0000:03:00.0: reg 0x30: [mem 0xfbc00000-0xfbc7ffff pref]
[    0.420774] pci 0000:03:00.1: [10de:0bea] type 00 class 0x040300
[    0.420782] pci 0000:03:00.1: reg 0x10: [mem 0xfbcfc000-0xfbcfffff]
[    0.428572] pci 0000:00:03.0: PCI bridge to [bus 03]
[    0.428641] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.428644] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
[    0.428648] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff=
 64bit pref]
[    0.428694] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.428801] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.428867] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff=
 64bit pref]
[    0.428946] pci 0000:05:00.0: [197b:2362] type 00 class 0x010185
[    0.428975] pci 0000:05:00.0: reg 0x10: [io  0xdc00-0xdc07]
[    0.428987] pci 0000:05:00.0: reg 0x14: [io  0xd880-0xd883]
[    0.429000] pci 0000:05:00.0: reg 0x18: [io  0xd800-0xd807]
[    0.429012] pci 0000:05:00.0: reg 0x1c: [io  0xd480-0xd483]
[    0.429025] pci 0000:05:00.0: reg 0x20: [io  0xd400-0xd40f]
[    0.429037] pci 0000:05:00.0: reg 0x24: [mem 0xfbdff000-0xfbdff1ff]
[    0.429050] pci 0000:05:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.429100] pci 0000:05:00.0: PME# supported from D3hot
[    0.436570] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.436637] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.436640] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.436682] pci 0000:07:01.0: [10ec:8167] type 00 class 0x020000
[    0.436699] pci 0000:07:01.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.436707] pci 0000:07:01.0: reg 0x14: [mem 0xfbeff000-0xfbeff0ff]
[    0.436743] pci 0000:07:01.0: reg 0x30: [mem 0xfbec0000-0xfbedffff pref]
[    0.436774] pci 0000:07:01.0: supports D1 D2
[    0.436776] pci 0000:07:01.0: PME# supported from D1 D2 D3hot D3cold
[    0.436812] pci 0000:07:02.0: [1106:3044] type 00 class 0x0c0010
[    0.436828] pci 0000:07:02.0: reg 0x10: [mem 0xfbefe000-0xfbefe7ff]
[    0.436837] pci 0000:07:02.0: reg 0x14: [io  0xec00-0xec7f]
[    0.436898] pci 0000:07:02.0: supports D2
[    0.436899] pci 0000:07:02.0: PME# supported from D2 D3hot D3cold
[    0.436956] pci 0000:00:1e.0: PCI bridge to [bus 07] (subtractive decode)
[    0.437021] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.437024] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.437029] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtr=
active decode)
[    0.437031] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtr=
active decode)
[    0.437032] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff=
] (subtractive decode)
[    0.437034] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff=
] (subtractive decode)
[    0.437035] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff=
] (subtractive decode)
[    0.437037] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff=
] (subtractive decode)
[    0.437470] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12 14 1=
5)
[    0.437978] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 *10 11 12 14 1=
5)
[    0.438485] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12 *14 1=
5)
[    0.438991] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 6 7 10 11 12 14 1=
5)
[    0.439500] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 *1=
5)
[    0.441842] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14 1=
5)
[    0.442350] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *6 7 10 11 12 14 1=
5)
[    0.442857] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 *10 11 12 14 1=
5)
[    0.443410] ACPI: Enabled 3 GPEs in block 00 to 3F
[    0.443549] ACPI: \_SB_.PCI0: notify handler is installed
[    0.443593] Found 1 acpi root devices
[    0.443669] vgaarb: device added: PCI:0000:03:00.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.443749] vgaarb: loaded
[    0.443805] vgaarb: bridge control possible 0000:03:00.0
[    0.443895] PCI: Using ACPI for IRQ routing
[    0.449202] PCI: Discovered peer bus ff
[    0.449260] PCI: root bus ff: using default resources
[    0.449261] PCI: Probing PCI hardware (bus ff)
[    0.449280] PCI host bridge to bus 0000:ff
[    0.449339] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
[    0.449401] pci_bus 0000:ff: root bus resource [mem 0x00000000-0xfffffff=
ff]
[    0.449464] pci_bus 0000:ff: No busn resource found for root bus, will u=
se [bus ff-ff]
[    0.449547] pci 0000:ff:00.0: [8086:2c41] type 00 class 0x060000
[    0.449581] pci 0000:ff:00.1: [8086:2c01] type 00 class 0x060000
[    0.449611] pci 0000:ff:02.0: [8086:2c10] type 00 class 0x060000
[    0.449640] pci 0000:ff:02.1: [8086:2c11] type 00 class 0x060000
[    0.449669] pci 0000:ff:03.0: [8086:2c18] type 00 class 0x060000
[    0.449697] pci 0000:ff:03.1: [8086:2c19] type 00 class 0x060000
[    0.449725] pci 0000:ff:03.4: [8086:2c1c] type 00 class 0x060000
[    0.449754] pci 0000:ff:04.0: [8086:2c20] type 00 class 0x060000
[    0.449782] pci 0000:ff:04.1: [8086:2c21] type 00 class 0x060000
[    0.449810] pci 0000:ff:04.2: [8086:2c22] type 00 class 0x060000
[    0.449839] pci 0000:ff:04.3: [8086:2c23] type 00 class 0x060000
[    0.449868] pci 0000:ff:05.0: [8086:2c28] type 00 class 0x060000
[    0.449896] pci 0000:ff:05.1: [8086:2c29] type 00 class 0x060000
[    0.449927] pci 0000:ff:05.2: [8086:2c2a] type 00 class 0x060000
[    0.449955] pci 0000:ff:05.3: [8086:2c2b] type 00 class 0x060000
[    0.449984] pci 0000:ff:06.0: [8086:2c30] type 00 class 0x060000
[    0.450012] pci 0000:ff:06.1: [8086:2c31] type 00 class 0x060000
[    0.450040] pci 0000:ff:06.2: [8086:2c32] type 00 class 0x060000
[    0.450068] pci 0000:ff:06.3: [8086:2c33] type 00 class 0x060000
[    0.450104] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
[    0.450108] PCI: pci_cache_line_size set to 64 bytes
[    0.450180] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    0.450181] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
[    0.450261] HPET: 4 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.450327] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.450571] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.453831] Switched to clocksource hpet
[    0.455153] pnp: PnP ACPI init
[    0.455216] ACPI: bus type PNP registered
[    0.455315] system 00:00: [mem 0xfbf00000-0xfbffffff] could not be reser=
ved
[    0.455380] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    0.455443] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    0.455506] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
[    0.455569] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be reser=
ved
[    0.455633] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
[    0.455696] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.455725] pnp 00:01: [dma 4]
[    0.455739] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.455764] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.455781] pnp 00:03: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.455802] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.455877] system 00:05: [io  0x0290-0x029f] has been reserved
[    0.455941] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.457978] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.458045] system 00:06: [io  0x0800-0x087f] could not be reserved
[    0.458107] system 00:06: [io  0x0500-0x057f] could not be reserved
[    0.458170] system 00:06: [io  0x0600-0x0607] has been reserved
[    0.458233] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.458297] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.458360] system 00:06: [mem 0xfed40000-0xfed8ffff] has been reserved
[    0.458424] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.458503] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.458551] pnp 00:08: Plug and Play ACPI device, IDs INT0800 (active)
[    0.458607] system 00:09: [mem 0xffc00000-0xffdfffff] has been reserved
[    0.458671] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.458753] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    0.458818] system 00:0a: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.458881] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.459036] pnp 00:0b: [dma 0 disabled]
[    0.459084] pnp 00:0b: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.459125] pnp 00:0c: Plug and Play ACPI device, IDs PNP0303 PNP030b (a=
ctive)
[    0.459184] system 00:0d: [mem 0xe0000000-0xefffffff] has been reserved
[    0.459248] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.459399] system 00:0e: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.459464] system 00:0e: [mem 0x000c0000-0x000cffff] could not be reser=
ved
[    0.459528] system 00:0e: [mem 0x000e0000-0x000fffff] could not be reser=
ved
[    0.459591] system 00:0e: [mem 0x00100000-0xbfffffff] could not be reser=
ved
[    0.459655] system 00:0e: [mem 0xfed90000-0xffffffff] could not be reser=
ved
[    0.459719] system 00:0e: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.459816] pnp: PnP ACPI: found 15 devices
[    0.459875] ACPI: bus type PNP unregistered
[    0.465807] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
06] add_size 1000
[    0.465810] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 06] add_size 400000
[    0.465817] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x001fffff p=
ref] to [bus 05] add_size 200000
[    0.465829] pci 0000:00:1f.0: BAR 13: [io  0x0800-0x087f] has bogus alig=
nment
[    0.465898] pci 0000:00:1c.0: res[14]=3D[mem 0x00100000-0x000fffff] get_=
res_add_size add_size 400000
[    0.465900] pci 0000:00:1c.4: res[15]=3D[mem 0x00100000-0x001fffff pref]=
 get_res_add_size add_size 200000
[    0.465902] pci 0000:00:1c.0: res[13]=3D[io  0x1000-0x0fff] get_res_add_=
size add_size 1000
[    0.465904] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0000000-0xc03ffff=
f]
[    0.465968] pci 0000:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc06ffff=
f pref]
[    0.466047] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.466110] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.466171] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    0.466235] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
[    0.466301] pci 0000:00:02.0: PCI bridge to [bus 02]
[    0.466363] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    0.466430] pci 0000:00:03.0: PCI bridge to [bus 03]
[    0.466490] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.466553] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
[    0.466618] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff=
 64bit pref]
[    0.466698] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.466763] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.466824] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.466888] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc03fffff]
[    0.466953] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff=
 64bit pref]
[    0.467035] pci 0000:05:00.0: BAR 6: assigned [mem 0xc0400000-0xc040ffff=
 pref]
[    0.467113] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.467173] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.467237] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.467301] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc06fffff=
 pref]
[    0.467382] pci 0000:00:1e.0: PCI bridge to [bus 07]
[    0.467443] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.467507] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.467575] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.467576] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.467578] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.467579] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
[    0.467581] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff]
[    0.467582] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]
[    0.467584] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    0.467585] pci_bus 0000:01: resource 1 [mem 0xf9e00000-0xf9efffff]
[    0.467587] pci_bus 0000:02: resource 1 [mem 0xf9f00000-0xf9ffffff]
[    0.467588] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.467590] pci_bus 0000:03: resource 1 [mem 0xfa000000-0xfbcfffff]
[    0.467591] pci_bus 0000:03: resource 2 [mem 0xd6000000-0xdfffffff 64bit=
 pref]
[    0.467593] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
[    0.467594] pci_bus 0000:06: resource 1 [mem 0xc0000000-0xc03fffff]
[    0.467596] pci_bus 0000:06: resource 2 [mem 0xf8f00000-0xf8ffffff 64bit=
 pref]
[    0.467598] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    0.467599] pci_bus 0000:05: resource 1 [mem 0xfbd00000-0xfbdfffff]
[    0.467600] pci_bus 0000:05: resource 2 [mem 0xc0400000-0xc06fffff pref]
[    0.467602] pci_bus 0000:07: resource 0 [io  0xe000-0xefff]
[    0.467603] pci_bus 0000:07: resource 1 [mem 0xfbe00000-0xfbefffff]
[    0.467605] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7]
[    0.467606] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff]
[    0.467608] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff]
[    0.467609] pci_bus 0000:07: resource 7 [mem 0x000d0000-0x000dffff]
[    0.467611] pci_bus 0000:07: resource 8 [mem 0xc0000000-0xdfffffff]
[    0.467612] pci_bus 0000:07: resource 9 [mem 0xf0000000-0xfed8ffff]
[    0.467615] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
[    0.467616] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xfffffffff]
[    0.467691] NET: Registered protocol family 2
[    0.468009] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes)
[    0.468524] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.468702] TCP: Hash tables configured (established 262144 bind 65536)
[    0.468778] TCP: reno registered
[    0.468861] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    0.469025] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    0.469241] NET: Registered protocol family 1
[    0.470801] pci 0000:03:00.0: Boot video device
[    0.470814] PCI: CLS mismatch (256 !=3D 64), using 64 bytes
[    0.470859] Unpacking initramfs...
[    0.744728] Freeing initrd memory: 14972K (ffff8800362b2000 - ffff880037=
151000)
[    0.744817] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.744879] software IO TLB [mem 0xbb780000-0xbf780000] (64MB) mapped at=
 [ffff8800bb780000-ffff8800bf77ffff]
[    0.746248] microcode: CPU0 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.746313] microcode: CPU1 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.746379] microcode: CPU2 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.746445] microcode: CPU3 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.746510] microcode: CPU4 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.746576] microcode: CPU5 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.746640] microcode: CPU6 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.746705] microcode: CPU7 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.746801] microcode: Microcode Update Driver: v2.00, Peter Oruba
[    0.747163] audit: initializing netlink socket (disabled)
[    0.747230] type=3D2000 audit(1389900967.604:1): initialized
[    0.761880] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.762712] VFS: Disk quotas dquot_6.5.2
[    0.762797] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.762926] msgmni has been set to 32768
[    0.763212] alg: No test for stdrng (krng)
[    0.763292] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    0.763405] io scheduler noop registered
[    0.763463] io scheduler deadline registered
[    0.763541] io scheduler cfq registered (default)
[    0.763770] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.763951] pcieport 0000:00:1c.0: irq 64 for MSI/MSI-X
[    0.764092] pcieport 0000:00:1c.4: irq 65 for MSI/MSI-X
[    0.764155] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.764225] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.764307] intel_idle: MWAIT substates: 0x1120
[    0.764316] intel_idle: v0.4 model 0x1A
[    0.764317] intel_idle: lapic_timer_reliable_states 0x2
[    0.764475] GHES: HEST is not enabled!
[    0.764574] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.785995] 00:0b: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    0.786382] Linux agpgart interface v0.103
[    0.786535] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.786597] i8042: PNP: PS/2 appears to have AUX port disabled, if this =
is incorrect please boot with i8042.nopnp
[    0.787155] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.787286] mousedev: PS/2 mouse device common for all mice
[    0.787376] rtc_cmos 00:02: RTC can wake from S4
[    0.787535] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.787619] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram=
, hpet irqs
[    0.787704] AMD IOMMUv2 driver by Joerg Roedel
[    0.787766] AMD IOMMUv2 functionality not available on this system
[    0.789650] TCP: cubic registered
[    0.791236] NET: Registered protocol family 10
[    0.791992] mip6: Mobile IPv6
[    0.792049] NET: Registered protocol family 17
[    0.792109] mpls_gso: MPLS GSO support
[    0.792466] registered taskstats version 1
[    0.793732] rtc_cmos 00:02: setting system clock to 2014-01-16 19:36:08 =
UTC (1389900968)
[    0.793829] PM: Hibernation image not present or could not be loaded.
[    0.794832] Freeing unused kernel memory: 988K (ffffffff818af000 - fffff=
fff819a6000)
[    0.794910] Write protecting the kernel read-only data: 8192k
[    0.798119] Freeing unused kernel memory: 1332K (ffff8800014b3000 - ffff=
880001600000)
[    0.799470] Freeing unused kernel memory: 456K (ffff88000178e000 - ffff8=
80001800000)
[    0.811544] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    0.861561] systemd-udevd[95]: starting version 204
[    0.876900] ACPI: bus type USB registered
[    0.876988] usbcore: registered new interface driver usbfs
[    0.877062] usbcore: registered new interface driver hub
[    0.877655] usbcore: registered new device driver usb
[    0.878338] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.878408] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 1
[    0.878620] xhci_hcd 0000:02:00.0: irq 66 for MSI/MSI-X
[    0.878628] xhci_hcd 0000:02:00.0: irq 67 for MSI/MSI-X
[    0.878635] xhci_hcd 0000:02:00.0: irq 68 for MSI/MSI-X
[    0.878643] xhci_hcd 0000:02:00.0: irq 69 for MSI/MSI-X
[    0.878649] xhci_hcd 0000:02:00.0: irq 70 for MSI/MSI-X
[    0.878656] xhci_hcd 0000:02:00.0: irq 71 for MSI/MSI-X
[    0.878662] xhci_hcd 0000:02:00.0: irq 72 for MSI/MSI-X
[    0.878669] xhci_hcd 0000:02:00.0: irq 73 for MSI/MSI-X
[    0.878885] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    0.878953] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.879036] usb usb1: Product: xHCI Host Controller
[    0.879099] usb usb1: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
[    0.879166] usb usb1: SerialNumber: 0000:02:00.0
[    0.879237] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.879558] uhci_hcd: USB Universal Host Controller Interface driver
[    0.879764] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.879858] hub 1-0:1.0: USB hub found
[    0.879928] hub 1-0:1.0: 2 ports detected
[    0.880080] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.880147] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 2
[    0.880907] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus =
number 3
[    0.881019] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a800
[    0.881126] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.881190] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.881270] usb usb3: Product: UHCI Host Controller
[    0.881331] usb usb3: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.881393] usb usb3: SerialNumber: 0000:00:1a.0
[    0.881476] ehci-pci: EHCI PCI platform driver
[    0.881550] hub 3-0:1.0: USB hub found
[    0.881616] hub 3-0:1.0: 2 ports detected
[    0.881738] SCSI subsystem initialized
[    0.881887] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.881952] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus =
number 4
[    0.882077] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
[    0.882086] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    0.882088] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.882089] usb usb2: Product: xHCI Host Controller
[    0.882090] usb usb2: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
[    0.882091] usb usb2: SerialNumber: 0000:02:00.0
[    0.882199] hub 2-0:1.0: USB hub found
[    0.882207] hub 2-0:1.0: 2 ports detected
[    0.882684] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.882752] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.882834] usb usb4: Product: UHCI Host Controller
[    0.882898] usb usb4: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.882964] usb usb4: SerialNumber: 0000:00:1a.1
[    0.883283] hub 4-0:1.0: USB hub found
[    0.883352] hub 4-0:1.0: 2 ports detected
[    0.883623] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.883691] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus =
number 5
[    0.883802] uhci_hcd 0000:00:1a.2: irq 19, io base 0x0000ac00
[    0.883914] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.883982] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.884019] libata version 3.00 loaded.
[    0.884065] usb usb5: Product: UHCI Host Controller
[    0.884129] usb usb5: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.884194] usb usb5: SerialNumber: 0000:00:1a.2
[    0.884347] hub 5-0:1.0: USB hub found
[    0.884415] hub 5-0:1.0: 2 ports detected
[    0.884678] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.884746] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus =
number 6
[    0.884858] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a080
[    0.884967] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.885035] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.885117] usb usb6: Product: UHCI Host Controller
[    0.885180] usb usb6: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.885244] usb usb6: SerialNumber: 0000:00:1d.0
[    0.885393] hub 6-0:1.0: USB hub found
[    0.885460] hub 6-0:1.0: 2 ports detected
[    0.885722] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.885788] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus =
number 7
[    0.885893] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
[    0.886013] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.886080] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.886161] usb usb7: Product: UHCI Host Controller
[    0.886223] usb usb7: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.886287] usb usb7: SerialNumber: 0000:00:1d.1
[    0.886439] hub 7-0:1.0: USB hub found
[    0.886505] hub 7-0:1.0: 2 ports detected
[    0.886767] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.886834] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus =
number 8
[    0.886944] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a480
[    0.887038] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.887101] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.887179] usb usb8: Product: UHCI Host Controller
[    0.887240] usb usb8: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.889046] usb usb8: SerialNumber: 0000:00:1d.2
[    0.889230] hub 8-0:1.0: USB hub found
[    0.889297] hub 8-0:1.0: 2 ports detected
[    0.889824] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.889893] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus =
number 9
[    0.889995] ehci-pci 0000:00:1a.7: debug port 1
[    0.892853] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    0.892990] r8169 0000:07:01.0 (unregistered net_device): not PCI Express
[    0.893298] r8169 0000:07:01.0 eth0: RTL8169sc/8110sc at 0xffffc9000304c=
000, 54:04:a6:49:30:b0, XID 18000000 IRQ 19
[    0.893383] r8169 0000:07:01.0 eth0: jumbo features [frames: 7152 bytes,=
 tx checksumming: ok]
[    0.893957] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    0.893965] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9dff000
[    0.906027] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.906118] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    0.906183] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.906264] usb usb9: Product: EHCI Host Controller
[    0.906326] usb usb9: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
[    0.907404] usb usb9: SerialNumber: 0000:00:1a.7
[    0.907599] hub 9-0:1.0: USB hub found
[    0.907665] hub 9-0:1.0: 6 ports detected
[    0.930118] hub 3-0:1.0: USB hub found
[    0.930186] hub 3-0:1.0: 2 ports detected
[    0.955448] hub 4-0:1.0: USB hub found
[    0.955512] hub 4-0:1.0: 2 ports detected
[    0.966142] firewire_ohci 0000:07:02.0: added OHCI v1.10 device as card =
0, 4 IR + 8 IT contexts, quirks 0x11
[    0.978217] hub 5-0:1.0: USB hub found
[    0.978286] hub 5-0:1.0: 2 ports detected
[    0.978731] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    0.978796] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus =
number 10
[    0.978885] ehci-pci 0000:00:1d.7: debug port 1
[    0.982846] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    0.982851] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9dfe000
[    0.994076] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.994193] usb usb10: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    0.994257] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    0.994335] usb usb10: Product: EHCI Host Controller
[    0.994395] usb usb10: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
[    0.994456] usb usb10: SerialNumber: 0000:00:1d.7
[    0.994773] hub 10-0:1.0: USB hub found
[    0.994841] hub 10-0:1.0: 6 ports detected
[    1.018177] hub 6-0:1.0: USB hub found
[    1.018248] hub 6-0:1.0: 2 ports detected
[    1.042161] hub 7-0:1.0: USB hub found
[    1.042231] hub 7-0:1.0: 2 ports detected
[    1.066287] hub 8-0:1.0: USB hub found
[    1.066351] hub 8-0:1.0: 2 ports detected
[    1.066538] ahci 0000:00:1f.2: version 3.0
[    1.066697] ahci 0000:00:1f.2: irq 74 for MSI/MSI-X
[    1.066763] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x=
3f impl SATA mode
[    1.066845] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp=
 pio slum part ccc ems sxs
[    1.106777] scsi0 : ahci
[    1.107563] scsi1 : ahci
[    1.107890] scsi2 : ahci
[    1.108201] scsi3 : ahci
[    1.108491] scsi4 : ahci
[    1.108735] scsi5 : ahci
[    1.108847] ata1: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc10=
0 irq 74
[    1.108930] ata2: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc18=
0 irq 74
[    1.109008] ata3: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc20=
0 irq 74
[    1.109086] ata4: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc28=
0 irq 74
[    1.109164] ata5: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc30=
0 irq 74
[    1.109243] ata6: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc38=
0 irq 74
[    1.109391] ahci 0000:01:00.0: irq 75 for MSI/MSI-X
[    1.109403] ahci 0000:01:00.0: controller can do FBS, turning on CAP_FBS
[    1.122131] ahci 0000:01:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0x=
ff impl SATA mode
[    1.122218] ahci 0000:01:00.0: flags: 64bit ncq fbs pio
[    1.122985] scsi6 : ahci
[    1.123267] scsi7 : ahci
[    1.123529] scsi8 : ahci
[    1.123803] scsi9 : ahci
[    1.124006] scsi10 : ahci
[    1.124219] scsi11 : ahci
[    1.124431] scsi12 : ahci
[    1.124647] scsi13 : ahci
[    1.124754] ata7: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff10=
0 irq 75
[    1.124834] ata8: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff18=
0 irq 75
[    1.124912] ata9: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff20=
0 irq 75
[    1.124990] ata10: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff2=
80 irq 75
[    1.125068] ata11: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff3=
00 irq 75
[    1.125147] ata12: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff3=
80 irq 75
[    1.125224] ata13: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff4=
00 irq 75
[    1.125302] ata14: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff4=
80 irq 75
[    1.125490] ahci 0000:05:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x=
3 impl SATA mode
[    1.125571] ahci 0000:05:00.0: flags: 64bit ncq pm led clo pmp pio slum =
part
[    1.125830] scsi14 : ahci
[    1.126012] scsi15 : ahci
[    1.126143] ata15: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff10=
0 irq 16
[    1.126226] ata16: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff18=
0 irq 16
[    1.438307] ata10: SATA link down (SStatus 0 SControl 300)
[    1.442314] ata9: SATA link down (SStatus 0 SControl 300)
[    1.442398] ata12: SATA link down (SStatus 0 SControl 300)
[    1.442474] ata8: SATA link down (SStatus 0 SControl 300)
[    1.446352] ata13: SATA link down (SStatus 0 SControl 300)
[    1.446383] ata15: SATA link down (SStatus 0 SControl 300)
[    1.446422] ata16: SATA link down (SStatus 0 SControl 300)
[    1.446559] ata11: SATA link down (SStatus 0 SControl 300)
[    1.446636] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.446825] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
[    1.447117] ata14.00: configured for UDMA/66
[    1.450360] ata7: SATA link down (SStatus 0 SControl 300)
[    1.466465] firewire_core 0000:07:02.0: created device fw0: GUID 001fc60=
0001acd8c, S400
[    1.594452] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.595627] ata4.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.595694] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.597075] ata4.00: configured for UDMA/133
[    1.598303] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.598382] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.598461] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.599583] ata3.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.599650] ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.599720] ata1.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.599782] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.602226] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.602311] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.602382] ata2.00: ATAPI: TSSTcorpCD/DVDW SH-S183L, SB01, max UDMA/33
[    1.602474] ata2.00: applying bridge limits
[    1.602539] ata3.00: configured for UDMA/133
[    1.602607] ata1.00: configured for UDMA/133
[    1.602965] scsi 0:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.603468] ata6.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.603539] ata6.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.603849] ata5.00: ATA-8: ST31000340AS, SD15, max UDMA/133
[    1.603913] ata5.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.604868] ata6.00: configured for UDMA/133
[    1.605602] ata2.00: configured for UDMA/33
[    1.605844] ata5.00: configured for UDMA/133
[    1.607687] scsi 1:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183L SB=
01 PQ: 0 ANSI: 5
[    1.608132] scsi 2:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.608538] scsi 3:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.609060] scsi 4:0:0:0: Direct-Access     ATA      ST31000340AS     SD=
15 PQ: 0 ANSI: 5
[    1.609439] scsi 5:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.610174] scsi 13:0:0:0: Processor         Marvell  91xx Config      1=
.01 PQ: 0 ANSI: 5
[    1.616220] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[    1.616332] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    1.616446] scsi 2:0:0:0: Attached scsi generic sg2 type 0
[    1.616560] scsi 3:0:0:0: Attached scsi generic sg3 type 0
[    1.616673] scsi 4:0:0:0: Attached scsi generic sg4 type 0
[    1.616781] scsi 5:0:0:0: Attached scsi generic sg5 type 0
[    1.616901] scsi 13:0:0:0: Attached scsi generic sg6 type 3
[    1.618823] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.618965] sd 0:0:0:0: [sda] Write Protect is off
[    1.619026] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.619061] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.621436] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    1.621516] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.621649] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.621760] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.621786] sd 3:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.621829] sd 4:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.621854] sd 5:0:0:0: [sde] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.621875] sd 3:0:0:0: [sdc] Write Protect is off
[    1.621877] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    1.621894] sd 4:0:0:0: [sdd] Write Protect is off
[    1.621896] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    1.621900] sd 5:0:0:0: [sde] Write Protect is off
[    1.621902] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    1.621908] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.621920] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.621922] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.622590] sd 2:0:0:0: [sdb] Write Protect is off
[    1.622651] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.622673] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.623811]  sdc: sdc1 sdc2 sdc3
[    1.624194] sd 3:0:0:0: [sdc] Attached SCSI disk
[    1.625441]  sda: sda1 sda2 sda3
[    1.627161] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.637058]  sdb: sdb1 sdb2 sdb3
[    1.637822] sd 2:0:0:0: [sdb] Attached SCSI disk
[    1.637925]  sdd: sdd1 sdd2 sdd3
[    1.638454]  sde: sde1 sde2 sde3
[    1.638573] sd 4:0:0:0: [sdd] Attached SCSI disk
[    1.638931] sd 5:0:0:0: [sde] Attached SCSI disk
[    1.746302] tsc: Refined TSC clocksource calibration: 2806.363 MHz
[    1.802305] usb 8-1: new low-speed USB device number 2 using uhci_hcd
[    1.898833] random: nonblocking pool is initialized
[    1.978588] usb 8-1: New USB device found, idVendor=3D046d, idProduct=3D=
c01e
[    1.978658] usb 8-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.978726] usb 8-1: Product: USB-PS/2 Optical Mouse
[    1.978785] usb 8-1: Manufacturer: Logitech
[    1.985316] hidraw: raw HID events driver (C) Jiri Kosina
[    2.001690] usbcore: registered new interface driver usbhid
[    2.001753] usbhid: USB HID core driver
[    2.003384] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:0=
0/0000:00:1d.2/usb8/8-1/8-1:1.0/input/input1
[    2.003551] hid-generic 0003:046D:C01E.0001: input,hidraw0: USB HID v1.1=
0 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-1/input0
[    2.039117] md: md127 stopped.
[    2.046723] md: bind
[    2.046988] md: bind
[    2.047418] md: bind
[    2.047645] md: bind
[    2.047889] md: bind
[    2.050849] md: raid10 personality registered for level 10
[    2.051265] md/raid10:md127: active with 4 out of 4 devices
[    2.051469] created bitmap (466 pages) for device md127
[    2.064483] md127: bitmap initialized from disk: read 30 pages, set 0 of=
 953616 bits
[    2.095159] md127: detected capacity change from 0 to 1999877701632
[    2.095267] RAID10 conf printout:
[    2.095268]  --- wd:4 rd:4
[    2.095270]  disk 0, wo:0, o:1, dev:sda3
[    2.095271]  disk 1, wo:0, o:1, dev:sdc3
[    2.095273]  disk 2, wo:0, o:1, dev:sdb3
[    2.095276]  disk 3, wo:0, o:1, dev:sdd3
[    2.096861]  md127: unknown partition table
[    2.134608] device-mapper: uevent: version 1.0.3
[    2.134738] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised:=
 dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    2.176145] bio: create slab  at 1
[    2.218604] usb 8-2: new low-speed USB device number 3 using uhci_hcd
[    2.267969] EXT4-fs (dm-0): mounted filesystem with ordered data mode. O=
pts: (null)
[    2.526755] usb 8-2: New USB device found, idVendor=3D051d, idProduct=3D=
0002
[    2.526825] usb 8-2: New USB device strings: Mfr=3D3, Product=3D1, Seria=
lNumber=3D2
[    2.526892] usb 8-2: Product: Back-UPS RS 1500 FW:8.g9 .D USB FW:g9
[    2.526954] usb 8-2: Manufacturer: American Power Conversion
[    2.527015] usb 8-2: SerialNumber: JB0539032829
[    2.746992] Switched to clocksource tsc
[    3.597312] hid-generic 0003:051D:0002.0002: hiddev0,hidraw1: USB HID v1=
.10 Device [American Power Conversion Back-UPS RS 1500 FW:8.g9 .D USB FW:g9=
 ] on usb-0000:00:1d.2-2/input0
[   13.741963] systemd-udevd[626]: starting version 204
[   14.299462] ACPI Warning: 0x0000000000000828-0x000000000000082f SystemIO=
 conflicts with Region \PMRG 1 (20131115/utaddress-251)
[   14.299639] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   14.299723] ACPI Warning: 0x0000000000000530-0x000000000000053f SystemIO=
 conflicts with Region \GPS0 1 (20131115/utaddress-251)
[   14.299881] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   14.299964] ACPI Warning: 0x0000000000000500-0x000000000000052f SystemIO=
 conflicts with Region \GPS0 1 (20131115/utaddress-251)
[   14.300123] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   14.300205] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   14.407460] EDAC MC: Ver: 3.0.0
[   14.429438] ACPI Warning: 0x0000000000001000-0x000000000000101f SystemIO=
 conflicts with Region \SMRG 1 (20131115/utaddress-251)
[   14.429602] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   14.448825] EDAC MC0: Giving out device to module i7core_edac.c controll=
er i7 core #0: DEV 0000:ff:03.0 (POLLED)
[   14.448936] EDAC PCI0: Giving out device to module i7core_edac controlle=
r EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)
[   14.449026] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   14.490131] [drm] Initialized drm 1.1.0 20060810
[   14.502643] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input2
[   14.502727] ACPI: Power Button [PWRB]
[   14.502817] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[   14.502896] ACPI: Power Button [PWRF]
[   14.522247] wmi: Mapper loaded
[   14.542412] systemd-udevd[683]: renamed network interface eth0 to lan
[   14.552317] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   14.563209] ATK0110 ATK0110:00: Overriding interface detection
[   14.595486] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work proper=
ly. Using workaround
[   14.635604] md: bind
[   14.694890] md: bind
[   14.725937] md: bind
[   14.758685] md: bind
[   14.774799] nouveau: unknown parameter 'perflvl_wr' ignored
[   14.775139] MXM: GUID detected in BIOS
[   14.775498] nouveau  [  DEVICE][0000:03:00.0] BOOT0  : 0x0c1000a1
[   14.775562] nouveau  [  DEVICE][0000:03:00.0] Chipset: GF108 (NVC1)
[   14.775624] nouveau  [  DEVICE][0000:03:00.0] Family : NVC0
[   14.776552] iTCO_vendor_support: vendor-support=3D0
[   14.776594] nouveau  [   VBIOS][0000:03:00.0] checking PRAMIN for image.=
..
[   14.790387] md: bind
[   14.793534] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[   14.793619] iTCO_wdt: Found a ICH10R TCO device (Version=3D2, TCOBASE=3D=
0x0860)
[   14.793757] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D1)
[   14.841699] nouveau  [   VBIOS][0000:03:00.0] ... appears to be valid
[   14.841764] nouveau  [   VBIOS][0000:03:00.0] using image from PRAMIN
[   14.841922] nouveau  [   VBIOS][0000:03:00.0] BIT signature found
[   14.841984] nouveau  [   VBIOS][0000:03:00.0] version 70.08.4d.00.00
[   14.842288] nouveau 0000:03:00.0: irq 76 for MSI/MSI-X
[   14.842295] nouveau  [     PMC][0000:03:00.0] MSI interrupts enabled
[   14.842489] nouveau W[     PFB][0000:03:00.0][0x00000000][ffff88061eff70=
00] reclocking of this ram type unsupported
[   14.842606] nouveau  [     PFB][0000:03:00.0] RAM type: DDR3
[   14.842694] nouveau  [     PFB][0000:03:00.0] RAM size: 512 MiB
[   14.842783] nouveau  [     PFB][0000:03:00.0]    ZCOMP: 0 tags
[   14.873936] nouveau  [  PTHERM][0000:03:00.0] FAN control: none / extern=
al
[   14.874033] nouveau  [  PTHERM][0000:03:00.0] fan management: automatic
[   14.874126] nouveau  [  PTHERM][0000:03:00.0] internal sensor: yes
[   14.874240] nouveau  [     CLK][0000:03:00.0] 03: core 50 MHz memory 135=
 MHz
[   14.874332] nouveau  [     CLK][0000:03:00.0] 07: core 405 MHz memory 32=
4 MHz
[   14.874450] nouveau  [     CLK][0000:03:00.0] 0f: core 810 MHz memory 90=
0 MHz
[   14.874699] nouveau  [     CLK][0000:03:00.0] --: core 405 MHz memory 32=
4 MHz
[   14.879935] md: raid1 personality registered for level 1
[   14.880230] md/raid1:md0: active with 5 out of 5 mirrors
[   14.880573] created bitmap (16 pages) for device md0
[   14.881371] md0: bitmap initialized from disk: read 2 pages, set 0 of 32=
096 bits
[   14.882919] [TTM] Zone  kernel: Available graphics memory: 12368142 kiB
[   14.883011] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   14.883100] [TTM] Initializing pool allocator
[   14.883188] [TTM] Initializing DMA pool allocator
[   14.883281] nouveau  [     DRM] VRAM: 512 MiB
[   14.883367] nouveau  [     DRM] GART: 1048576 MiB
[   14.883455] nouveau  [     DRM] TMDS table version 2.0
[   14.883543] nouveau  [     DRM] DCB version 4.0
[   14.883630] nouveau  [     DRM] DCB outp 00: 01000302 00020030
[   14.883719] nouveau  [     DRM] DCB outp 01: 02000300 00000000
[   14.883807] nouveau  [     DRM] DCB outp 02: 08011392 00020020
[   14.883896] nouveau  [     DRM] DCB outp 03: 04022310 00000000
[   14.883985] nouveau  [     DRM] DCB conn 00: 00001030
[   14.884134] nouveau  [     DRM] DCB conn 01: 00002161
[   14.884283] nouveau  [     DRM] DCB conn 02: 00000200
[   14.887065] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   14.887158] [drm] No driver support for vblank timestamp query.
[   14.900084] nouveau  [     DRM] MM: using COPY0 for buffer copies
[   14.902739] md0: detected capacity change from 0 to 131465216
[   14.902846] RAID1 conf printout:
[   14.902849]  --- wd:5 rd:5
[   14.902851]  disk 0, wo:0, o:1, dev:sda1
[   14.902852]  disk 1, wo:0, o:1, dev:sdc1
[   14.902854]  disk 2, wo:0, o:1, dev:sdb1
[   14.902856]  disk 3, wo:0, o:1, dev:sdd1
[   14.902857]  disk 4, wo:0, o:1, dev:sde1
[   14.904780]  md0: unknown partition table
[   14.928803] snd_hda_intel 0000:00:1b.0: irq 77 for MSI/MSI-X
[   14.959707] input: HDA Intel Front Headphone as /devices/pci0000:00/0000=
:00:1b.0/sound/card0/input12
[   14.959907] input: HDA Intel Line Out Side as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input11
[   14.960109] input: HDA Intel Line Out CLFE as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input10
[   14.960308] input: HDA Intel Line Out Surround as /devices/pci0000:00/00=
00:00:1b.0/sound/card0/input9
[   14.960508] input: HDA Intel Line Out Front as /devices/pci0000:00/0000:=
00:1b.0/sound/card0/input8
[   14.960689] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/so=
und/card0/input7
[   14.962628] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.=
0/sound/card0/input6
[   14.962807] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b=
.0/sound/card0/input5
[   14.990343] nouveau  [     DRM] allocated 1024x768 fb: 0x60000, bo ffff8=
8003703b000
[   14.990658] fbcon: nouveaufb (fb0) is primary device
[   15.066348] Console: switching to colour frame buffer device 128x48
[   15.068737] nouveau 0000:03:00.0: fb0: nouveaufb frame buffer device
[   15.068745] nouveau 0000:03:00.0: registered panic notifier
[   15.068768] [drm] Initialized nouveau 1.1.1 20120801 for 0000:03:00.0 on=
 minor 0
[   15.068973] hda_intel: Disabling MSI
[   15.068993] hda-intel 0000:03:00.1: Handle VGA-switcheroo audio client
[   15.878936] input: HDA NVidia HDMI/DP,pcm=3D9 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input16
[   15.879171] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input15
[   15.879383] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input14
[   15.881428] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input13
[   16.469425] EXT4-fs (dm-0): re-mounted. Opts: (null)
[   16.834273] RAID10 conf printout:
[   16.834281]  --- wd:4 rd:4
[   16.834284]  disk 0, wo:0, o:1, dev:sda3
[   16.834287]  disk 1, wo:0, o:1, dev:sdc3
[   16.834289]  disk 2, wo:0, o:1, dev:sdb3
[   16.834291]  disk 3, wo:0, o:1, dev:sdd3
[   16.965953] EXT4-fs (dm-0): re-mounted. Opts: user_xattr,errors=3Dremoun=
t-ro
[   17.478143] loop: module loaded
[   18.780774] Adding 5857276k swap on /dev/mapper/Zia-swap_crypt.  Priorit=
y:-1 extents:1 across:5857276k
[   19.769993] EXT4-fs (md0): mounting ext2 file system using the ext4 subs=
ystem
[   19.898051] EXT4-fs (md0): mounted filesystem without journal. Opts: (nu=
ll)
[   19.964800] EXT4-fs (dm-3): mounted filesystem with ordered data mode. O=
pts: user_xattr
[   19.972941] EXT4-fs (dm-2): mounted filesystem with ordered data mode. O=
pts: user_xattr
[   20.047164] FAT-fs (sda2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   20.091017] FAT-fs (sdc2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   20.129998] FAT-fs (sdb2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   20.169096] FAT-fs (sdd2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   21.175365] Bridge firewalling registered
[   21.178143] device lan entered promiscuous mode
[   21.189135] r8169 0000:07:01.0 lan: link down
[   21.189150] r8169 0000:07:01.0 lan: link down
[   21.189582] IPv6: ADDRCONF(NETDEV_UP): lan: link is not ready
[   21.191974] IPv6: ADDRCONF(NETDEV_UP): br0: link is not ready
[   24.037322] r8169 0000:07:01.0 lan: link up
[   24.037580] IPv6: ADDRCONF(NETDEV_CHANGE): lan: link becomes ready
[   24.038513] br0: port 1(lan) entered forwarding state
[   24.041839] br0: port 1(lan) entered forwarding state
[   24.043288] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[   25.226276] RPC: Registered named UNIX socket transport module.
[   25.226508] RPC: Registered udp transport module.
[   25.226729] RPC: Registered tcp transport module.
[   25.227109] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   25.236203] FS-Cache: Loaded
[   25.253009] FS-Cache: Netfs 'nfs' registered for caching
[   25.281657] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
[   26.047541] br0: port 1(lan) entered forwarding state



**** VT-d=3DON, nointremap (2)

[    0.000000] CPU0 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.13.0-rc8+ (anthony@Zia) (gcc version 4.8.2 (=
Debian 4.8.2-12) ) #7 SMP Thu Jan 16 12:36:44 EST 2014
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.13.0-rc8+ root=3D/dev/=
mapper/Zia-root ro single verbose nointremap
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e2c00-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf797fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000bf798000-0x00000000bf7d9fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf7da000-0x00000000bfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000063fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: System manufacturer System Product Name/SABERTOOTH X58,=
 BIOS 1402    08/09/2012
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x640000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EBFFF write-through
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask C00000000 write-back
[    0.000000]   1 base 400000000 mask E00000000 write-back
[    0.000000]   2 base 600000000 mask FC0000000 write-back
[    0.000000]   3 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   4 base 0BF800000 mask FFF800000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820: update [mem 0xbf800000-0xffffffff] usable =3D=3D> rese=
rved
[    0.000000] e820: last_pfn =3D 0xbf780 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at =
[ffff8800000ff780]
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01a9b000, 0x01a9bfff] PGTABLE
[    0.000000] BRK [0x01a9c000, 0x01a9cfff] PGTABLE
[    0.000000] BRK [0x01a9d000, 0x01a9dfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x63fe00000-0x63fffffff]
[    0.000000]  [mem 0x63fe00000-0x63fffffff] page 2M
[    0.000000] BRK [0x01a9e000, 0x01a9efff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x63c000000-0x63fdfffff]
[    0.000000]  [mem 0x63c000000-0x63fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x600000000-0x63bffffff]
[    0.000000]  [mem 0x600000000-0x63bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xbf77ffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0xbf5fffff] page 2M
[    0.000000]  [mem 0xbf600000-0xbf77ffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x5ffffffff]
[    0.000000]  [mem 0x100000000-0x5ffffffff] page 2M
[    0.000000] BRK [0x01a9f000, 0x01a9ffff] PGTABLE
[    0.000000] BRK [0x01aa0000, 0x01aa0fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x362b2000-0x37150fff]
[    0.000000] ACPI: RSDP 00000000000fb940 000024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 00000000bf780100 00006C (v01 080912 XSDT1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000bf780290 0000F4 (v03 080912 FACP1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: DSDT 00000000bf7804b0 00C469 (v01  A1682 A1682001 0000=
0001 INTL 20060113)
[    0.000000] ACPI: FACS 00000000bf798000 000040
[    0.000000] ACPI: APIC 00000000bf780390 0000D8 (v01 080912 APIC1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000bf780470 00003C (v01 080912 OEMMCFG  2012=
0809 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000bf798040 000072 (v01 080912 OEMB1157 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000bf78f4b0 000038 (v01 080912 OEMHPET  2012=
0809 MSFT 00000097)
[    0.000000] ACPI: DMAR 00000000bf7980c0 000140 (v01    AMI  OEMDMAR 0000=
0001 MSFT 00000097)
[    0.000000] ACPI: ASPT 00000000bf7984b0 000034 (v06 080912 PerfTune 2012=
0809 MSFT 00000097)
[    0.000000] ACPI: OSFR 00000000bf78f4f0 0000B0 (v01 080912 OEMOSFR  2012=
0809 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000bf79a970 000363 (v01 DpgPmm    CpuPm 0000=
0012 INTL 20060113)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000063fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x63fffffff]
[    0.000000]   NODE_DATA [mem 0x63ffe6000-0x63ffeafff]
[    0.000000]  [ffffea0000000000-ffffea0015dfffff] PMD -> [ffff88062760000=
0-ffff88063c5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x63fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xbf77ffff]
[    0.000000]   node   0: [mem 0x100000000-0x63fffffff]
[    0.000000] On node 0 totalpages: 6289181
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 10667 pages used for memmap
[    0.000000]   DMA32 zone: 780160 pages, LIFO batch:31
[    0.000000]   Normal zone: 75264 pages used for memmap
[    0.000000]   Normal zone: 5505024 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec8a000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec8a000, GSI 24=
-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
[    0.000000] nr_irqs_gsi: 64
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e2fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e3000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf780000-0xbf797fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf798000-0xbf7d9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf7da000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffdfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffe00000-0xffffffff]
[    0.000000] e820: [mem 0xc0000000-0xfedfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:16 =
nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88063fc00000 s85824 r8192=
 d20672 u131072
[    0.000000] pcpu-alloc: s85824 r8192 d20672 u131072 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14=
 15
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 6203173
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-3.13.0-rc8+ root=
=3D/dev/mapper/Zia-root ro single verbose nointremap
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 24718516K/25156724K available (4799K kernel code, 69=
2K rwdata, 1592K rodata, 988K init, 952K bss, 438208K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=3D16.
[    0.000000] NR_IRQS:33024 nr_irqs:1216 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 100663296 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration failed
[    0.004000] tsc: PIT calibration matches HPET. 1 loops
[    0.004000] tsc: Detected 2806.439 MHz processor
[    0.000003] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5612.87 BogoMIPS (lpj=3D11225756)
[    0.000122] pid_max: default: 32768 minimum: 301
[    0.000214] Security Framework initialized
[    0.000274] AppArmor: AppArmor disabled by boot time parameter
[    0.000334] Yama: becoming mindful.
[    0.002275] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes)
[    0.010481] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes)
[    0.013876] Mount-cache hash table entries: 256
[    0.014097] Initializing cgroup subsys memory
[    0.014160] Initializing cgroup subsys devices
[    0.014218] Initializing cgroup subsys freezer
[    0.014277] Initializing cgroup subsys blkio
[    0.014336] Initializing cgroup subsys perf_event
[    0.014413] CPU: Physical Processor ID: 0
[    0.014470] CPU: Processor Core ID: 0
[    0.014530] mce: CPU supports 9 MCE banks
[    0.014598] CPU0: Thermal monitoring enabled (TM1)
[    0.014666] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.014666] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
[    0.014666] tlb_flushall_shift: 6
[    0.014828] Freeing SMP alternatives memory: 20K (ffffffff819a6000 - fff=
fffff819ab000)
[    0.015927] ACPI: Core revision 20131115
[    0.019466] ACPI: All ACPI Tables successfully acquired
[    0.065675] dmar: Host address width 39
[    0.065736] dmar: DRHD base: 0x000000fbfff000 flags: 0x0
[    0.065801] dmar: IOMMU 0: reg_base_addr fbfff000 ver 1:0 cap c9008010e6=
0262 ecap f0207a
[    0.065880] dmar: DRHD base: 0x000000fbffe000 flags: 0x1
[    0.065944] dmar: IOMMU 1: reg_base_addr fbffe000 ver 1:0 cap c90780106f=
0462 ecap f020fe
[    0.066022] dmar: RMRR base: 0x000000000ec000 end: 0x000000000effff
[    0.066084] dmar: RMRR base: 0x000000bf7ea000 end: 0x000000bf7fffff
[    0.066145] dmar: ATSR flags: 0x0
[    0.066358] Switched APIC routing to physical flat.
[    0.066922] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.108291] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         930  @ 2.80G=
Hz (fam: 06, model: 1a, stepping: 05)
[    0.215847] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events,=
 Intel PMU driver.
[    0.216079] perf_event_intel: CPU erratum AAJ80 worked around
[    0.216140] perf_event_intel: CPUID marked event: 'bus cycles' unavailab=
le
[    0.216204] ... version:                3
[    0.216261] ... bit width:              48
[    0.216318] ... generic registers:      4
[    0.216376] ... value mask:             0000ffffffffffff
[    0.216436] ... max period:             000000007fffffff
[    0.216495] ... fixed-purpose events:   3
[    0.216552] ... event mask:             000000070000000f
[    0.216959] x86: Booting SMP configuration:
[    0.231268] CPU1 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.233459] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    0.247832] CPU2 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.260653] CPU3 microcode updated early to revision 0x19, date =3D 2013=
-06-21
[    0.217018] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.323852] x86: Booted up 1 node, 8 CPUs
[    0.323965] smpboot: Total of 8 processors activated (44903.02 BogoMIPS)
[    0.331504] devtmpfs: initialized
[    0.334938] PM: Registering ACPI NVS region [mem 0xbf798000-0xbf7d9fff] =
(270336 bytes)
[    0.335161] NET: Registered protocol family 16
[    0.335291] cpuidle: using governor ladder
[    0.335349] cpuidle: using governor menu
[    0.335428] ACPI: bus type PCI registered
[    0.335486] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.335612] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.335692] PCI: not using MMCONFIG
[    0.335748] PCI: Using configuration type 1 for base access
[    0.336533] bio: create slab  at 0
[    0.336700] ACPI: Added _OSI(Module Device)
[    0.336758] ACPI: Added _OSI(Processor Device)
[    0.336815] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.336874] ACPI: Added _OSI(Processor Aggregator Device)
[    0.338547] ACPI: Executed 1 blocks of module-level executable AML code
[    0.375923] ACPI: SSDT 00000000bf7984f0 001E1C (v01 DpgPmm  P001Ist 0000=
0011 INTL 20060113)
[    0.376366] ACPI: Dynamic OEM Table Load:
[    0.376498] ACPI: SSDT           (null) 001E1C (v01 DpgPmm  P001Ist 0000=
0011 INTL 20060113)
[    0.376723] ACPI: SSDT 00000000bf79a310 000659 (v01  PmRef  P001Cst 0000=
3001 INTL 20060113)
[    0.377074] ACPI: Dynamic OEM Table Load:
[    0.377205] ACPI: SSDT           (null) 000659 (v01  PmRef  P001Cst 0000=
3001 INTL 20060113)
[    0.377525] ACPI: Interpreter enabled
[    0.377589] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S2_] (20131115/hwxface-580)
[    0.377752] ACPI: (supports S0 S1 S3 S4 S5)
[    0.377809] ACPI: Using IOAPIC for interrupt routing
[    0.377885] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.378821] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACP=
I motherboard resources
[    0.392756] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.392945] ACPI: No dock devices found.
[    0.400793] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.400859] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    0.400939] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.401291] PCI host bridge to bus 0000:00
[    0.401349] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.401410] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.401471] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.401532] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f]
[    0.401594] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dfff=
f]
[    0.401656] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdffffff=
f]
[    0.401719] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed8fff=
f]
[    0.401789] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000
[    0.401831] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.401900] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    0.401944] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.401989] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.402074] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
[    0.402118] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.402162] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.402247] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    0.402291] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.402335] pci 0000:00:03.0: System wakeup disabled by ACPI
[    0.402422] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    0.402463] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.402508] pci 0000:00:07.0: System wakeup disabled by ACPI
[    0.402598] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    0.402688] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    0.402777] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    0.402863] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
[    0.402949] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    0.402986] pci 0000:00:1a.0: reg 0x20: [io  0xa800-0xa81f]
[    0.403068] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.403153] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    0.403190] pci 0000:00:1a.1: reg 0x20: [io  0xa880-0xa89f]
[    0.403272] pci 0000:00:1a.1: System wakeup disabled by ACPI
[    0.403357] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
[    0.403394] pci 0000:00:1a.2: reg 0x20: [io  0xac00-0xac1f]
[    0.403476] pci 0000:00:1a.2: System wakeup disabled by ACPI
[    0.403570] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    0.403588] pci 0000:00:1a.7: reg 0x10: [mem 0xf9dff000-0xf9dff3ff]
[    0.403667] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.403714] pci 0000:00:1a.7: System wakeup disabled by ACPI
[    0.403802] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300
[    0.403815] pci 0000:00:1b.0: reg 0x10: [mem 0xf9df8000-0xf9dfbfff 64bit]
[    0.403873] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.403943] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    0.404002] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.404049] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.404136] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    0.404195] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.404241] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    0.404328] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    0.404365] pci 0000:00:1d.0: reg 0x20: [io  0xa080-0xa09f]
[    0.404447] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.404532] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    0.404568] pci 0000:00:1d.1: reg 0x20: [io  0xa400-0xa41f]
[    0.404650] pci 0000:00:1d.1: System wakeup disabled by ACPI
[    0.404737] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    0.404773] pci 0000:00:1d.2: reg 0x20: [io  0xa480-0xa49f]
[    0.404854] pci 0000:00:1d.2: System wakeup disabled by ACPI
[    0.404948] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    0.404967] pci 0000:00:1d.7: reg 0x10: [mem 0xf9dfe000-0xf9dfe3ff]
[    0.405046] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.405092] pci 0000:00:1d.7: System wakeup disabled by ACPI
[    0.405177] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.405256] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    0.405343] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
[    0.405412] pci 0000:00:1f.0: address space collision: [io  0x0800-0x087=
f] conflicts with ACPI CPU throttle [??? 0x00000810-0x00000815 flags 0x8000=
0000]
[    0.405501] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6=
 GPIO
[    0.405565] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (=
mask 0003)
[    0.405733] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
[    0.405749] pci 0000:00:1f.2: reg 0x10: [io  0x9c00-0x9c07]
[    0.405755] pci 0000:00:1f.2: reg 0x14: [io  0x9880-0x9883]
[    0.405762] pci 0000:00:1f.2: reg 0x18: [io  0x9800-0x9807]
[    0.405768] pci 0000:00:1f.2: reg 0x1c: [io  0x9480-0x9483]
[    0.405775] pci 0000:00:1f.2: reg 0x20: [io  0x9400-0x941f]
[    0.405781] pci 0000:00:1f.2: reg 0x24: [mem 0xf9dfc000-0xf9dfc7ff]
[    0.405821] pci 0000:00:1f.2: PME# supported from D3hot
[    0.405888] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    0.405901] pci 0000:00:1f.3: reg 0x10: [mem 0xf9dfd000-0xf9dfd0ff 64bit]
[    0.405918] pci 0000:00:1f.3: reg 0x20: [io  0x1000-0x101f]
[    0.406028] pci 0000:01:00.0: [1b4b:9123] type 00 class 0x010601
[    0.406038] pci 0000:01:00.0: reg 0x10: [io  0xbc00-0xbc07]
[    0.406044] pci 0000:01:00.0: reg 0x14: [io  0xb880-0xb883]
[    0.406050] pci 0000:01:00.0: reg 0x18: [io  0xb800-0xb807]
[    0.406057] pci 0000:01:00.0: reg 0x1c: [io  0xb480-0xb483]
[    0.406063] pci 0000:01:00.0: reg 0x20: [io  0xb400-0xb40f]
[    0.406070] pci 0000:01:00.0: reg 0x24: [mem 0xf9eff000-0xf9eff7ff]
[    0.406076] pci 0000:01:00.0: reg 0x30: [mem 0xf9ee0000-0xf9eeffff pref]
[    0.406104] pci 0000:01:00.0: PME# supported from D3hot
[    0.411907] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.411972] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    0.411975] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
[    0.412025] pci 0000:02:00.0: [1033:0194] type 00 class 0x0c0330
[    0.412040] pci 0000:02:00.0: reg 0x10: [mem 0xf9ffe000-0xf9ffffff 64bit]
[    0.412110] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.419926] pci 0000:00:02.0: PCI bridge to [bus 02]
[    0.419996] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    0.420057] pci 0000:03:00.0: [10de:0de0] type 00 class 0x030000
[    0.420066] pci 0000:03:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
[    0.420075] pci 0000:03:00.0: reg 0x14: [mem 0xd8000000-0xdfffffff 64bit=
 pref]
[    0.420084] pci 0000:03:00.0: reg 0x1c: [mem 0xd6000000-0xd7ffffff 64bit=
 pref]
[    0.420091] pci 0000:03:00.0: reg 0x24: [io  0xcc00-0xcc7f]
[    0.420097] pci 0000:03:00.0: reg 0x30: [mem 0xfbc00000-0xfbc7ffff pref]
[    0.420168] pci 0000:03:00.1: [10de:0bea] type 00 class 0x040300
[    0.420177] pci 0000:03:00.1: reg 0x10: [mem 0xfbcfc000-0xfbcfffff]
[    0.427923] pci 0000:00:03.0: PCI bridge to [bus 03]
[    0.427988] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.427991] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
[    0.427995] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff=
 64bit pref]
[    0.428029] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.428134] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.428199] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff=
 64bit pref]
[    0.428278] pci 0000:05:00.0: [197b:2362] type 00 class 0x010185
[    0.428306] pci 0000:05:00.0: reg 0x10: [io  0xdc00-0xdc07]
[    0.428318] pci 0000:05:00.0: reg 0x14: [io  0xd880-0xd883]
[    0.428331] pci 0000:05:00.0: reg 0x18: [io  0xd800-0xd807]
[    0.428343] pci 0000:05:00.0: reg 0x1c: [io  0xd480-0xd483]
[    0.428356] pci 0000:05:00.0: reg 0x20: [io  0xd400-0xd40f]
[    0.428368] pci 0000:05:00.0: reg 0x24: [mem 0xfbdff000-0xfbdff1ff]
[    0.428381] pci 0000:05:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.428430] pci 0000:05:00.0: PME# supported from D3hot
[    0.435944] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.436012] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.436015] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.436070] pci 0000:07:01.0: [10ec:8167] type 00 class 0x020000
[    0.436088] pci 0000:07:01.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.436096] pci 0000:07:01.0: reg 0x14: [mem 0xfbeff000-0xfbeff0ff]
[    0.436132] pci 0000:07:01.0: reg 0x30: [mem 0xfbec0000-0xfbedffff pref]
[    0.436164] pci 0000:07:01.0: supports D1 D2
[    0.436166] pci 0000:07:01.0: PME# supported from D1 D2 D3hot D3cold
[    0.436206] pci 0000:07:02.0: [1106:3044] type 00 class 0x0c0010
[    0.436222] pci 0000:07:02.0: reg 0x10: [mem 0xfbefe000-0xfbefe7ff]
[    0.436230] pci 0000:07:02.0: reg 0x14: [io  0xec00-0xec7f]
[    0.436292] pci 0000:07:02.0: supports D2
[    0.436293] pci 0000:07:02.0: PME# supported from D2 D3hot D3cold
[    0.436350] pci 0000:00:1e.0: PCI bridge to [bus 07] (subtractive decode)
[    0.436414] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.436417] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.436422] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtr=
active decode)
[    0.436423] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtr=
active decode)
[    0.436425] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff=
] (subtractive decode)
[    0.436426] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff=
] (subtractive decode)
[    0.436428] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff=
] (subtractive decode)
[    0.436429] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff=
] (subtractive decode)
[    0.436867] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12 14 1=
5)
[    0.437376] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 *10 11 12 14 1=
5)
[    0.437882] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12 *14 1=
5)
[    0.438388] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 6 7 10 11 12 14 1=
5)
[    0.438896] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 *1=
5)
[    0.439403] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14 1=
5)
[    0.439912] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *6 7 10 11 12 14 1=
5)
[    0.440422] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 *10 11 12 14 1=
5)
[    0.440968] ACPI: Enabled 3 GPEs in block 00 to 3F
[    0.441105] ACPI: \_SB_.PCI0: notify handler is installed
[    0.441135] Found 1 acpi root devices
[    0.441206] vgaarb: device added: PCI:0000:03:00.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.441284] vgaarb: loaded
[    0.441339] vgaarb: bridge control possible 0000:03:00.0
[    0.441428] PCI: Using ACPI for IRQ routing
[    0.448584] PCI: Discovered peer bus ff
[    0.448643] PCI: root bus ff: using default resources
[    0.448644] PCI: Probing PCI hardware (bus ff)
[    0.448673] PCI host bridge to bus 0000:ff
[    0.448732] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
[    0.448794] pci_bus 0000:ff: root bus resource [mem 0x00000000-0xfffffff=
ff]
[    0.448856] pci_bus 0000:ff: No busn resource found for root bus, will u=
se [bus ff-ff]
[    0.448937] pci 0000:ff:00.0: [8086:2c41] type 00 class 0x060000
[    0.448973] pci 0000:ff:00.1: [8086:2c01] type 00 class 0x060000
[    0.449003] pci 0000:ff:02.0: [8086:2c10] type 00 class 0x060000
[    0.449031] pci 0000:ff:02.1: [8086:2c11] type 00 class 0x060000
[    0.449060] pci 0000:ff:03.0: [8086:2c18] type 00 class 0x060000
[    0.449088] pci 0000:ff:03.1: [8086:2c19] type 00 class 0x060000
[    0.449117] pci 0000:ff:03.4: [8086:2c1c] type 00 class 0x060000
[    0.449145] pci 0000:ff:04.0: [8086:2c20] type 00 class 0x060000
[    0.449173] pci 0000:ff:04.1: [8086:2c21] type 00 class 0x060000
[    0.449201] pci 0000:ff:04.2: [8086:2c22] type 00 class 0x060000
[    0.449230] pci 0000:ff:04.3: [8086:2c23] type 00 class 0x060000
[    0.449259] pci 0000:ff:05.0: [8086:2c28] type 00 class 0x060000
[    0.449287] pci 0000:ff:05.1: [8086:2c29] type 00 class 0x060000
[    0.449320] pci 0000:ff:05.2: [8086:2c2a] type 00 class 0x060000
[    0.449348] pci 0000:ff:05.3: [8086:2c2b] type 00 class 0x060000
[    0.449377] pci 0000:ff:06.0: [8086:2c30] type 00 class 0x060000
[    0.449405] pci 0000:ff:06.1: [8086:2c31] type 00 class 0x060000
[    0.449433] pci 0000:ff:06.2: [8086:2c32] type 00 class 0x060000
[    0.449461] pci 0000:ff:06.3: [8086:2c33] type 00 class 0x060000
[    0.449497] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
[    0.449501] PCI: pci_cache_line_size set to 64 bytes
[    0.449574] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    0.449575] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
[    0.449663] HPET: 4 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.449728] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.449973] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.452252] Switched to clocksource hpet
[    0.453573] pnp: PnP ACPI init
[    0.453635] ACPI: bus type PNP registered
[    0.453740] system 00:00: [mem 0xfbf00000-0xfbffffff] could not be reser=
ved
[    0.453804] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    0.453865] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    0.453928] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
[    0.453989] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be reser=
ved
[    0.454052] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
[    0.454115] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.454151] pnp 00:01: [dma 4]
[    0.454166] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.454191] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.454209] pnp 00:03: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.454229] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.454306] system 00:05: [io  0x0290-0x029f] has been reserved
[    0.454369] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.454544] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.454608] system 00:06: [io  0x0800-0x087f] could not be reserved
[    0.454669] system 00:06: [io  0x0500-0x057f] could not be reserved
[    0.454731] system 00:06: [io  0x0600-0x0607] has been reserved
[    0.454792] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.454854] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.454917] system 00:06: [mem 0xfed40000-0xfed8ffff] has been reserved
[    0.454979] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.455043] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.455090] pnp 00:08: Plug and Play ACPI device, IDs INT0800 (active)
[    0.455143] system 00:09: [mem 0xffc00000-0xffdfffff] has been reserved
[    0.455206] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.455288] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    0.455351] system 00:0a: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.455413] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.455571] pnp 00:0b: [dma 0 disabled]
[    0.455619] pnp 00:0b: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.455660] pnp 00:0c: Plug and Play ACPI device, IDs PNP0303 PNP030b (a=
ctive)
[    0.455719] system 00:0d: [mem 0xe0000000-0xefffffff] has been reserved
[    0.455783] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.455942] system 00:0e: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.456006] system 00:0e: [mem 0x000c0000-0x000cffff] could not be reser=
ved
[    0.456069] system 00:0e: [mem 0x000e0000-0x000fffff] could not be reser=
ved
[    0.456131] system 00:0e: [mem 0x00100000-0xbfffffff] could not be reser=
ved
[    0.456194] system 00:0e: [mem 0xfed90000-0xffffffff] could not be reser=
ved
[    0.456261] system 00:0e: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.456360] pnp: PnP ACPI: found 15 devices
[    0.456418] ACPI: bus type PNP unregistered
[    0.463834] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus =
06] add_size 1000
[    0.463837] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 06] add_size 400000
[    0.463845] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x001fffff p=
ref] to [bus 05] add_size 200000
[    0.463860] pci 0000:00:1f.0: BAR 13: [io  0x0800-0x087f] has bogus alig=
nment
[    0.463924] pci 0000:00:1c.0: res[14]=3D[mem 0x00100000-0x000fffff] get_=
res_add_size add_size 400000
[    0.463926] pci 0000:00:1c.4: res[15]=3D[mem 0x00100000-0x001fffff pref]=
 get_res_add_size add_size 200000
[    0.463928] pci 0000:00:1c.0: res[13]=3D[io  0x1000-0x0fff] get_res_add_=
size add_size 1000
[    0.463931] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0000000-0xc03ffff=
f]
[    0.463994] pci 0000:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc06ffff=
f pref]
[    0.464071] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.464133] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.464193] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    0.464265] pci 0000:00:01.0:   bridge window [mem 0xf9e00000-0xf9efffff]
[    0.464331] pci 0000:00:02.0: PCI bridge to [bus 02]
[    0.464392] pci 0000:00:02.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    0.464458] pci 0000:00:03.0: PCI bridge to [bus 03]
[    0.464517] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.464580] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfbcfffff]
[    0.464643] pci 0000:00:03.0:   bridge window [mem 0xd6000000-0xdfffffff=
 64bit pref]
[    0.464722] pci 0000:00:07.0: PCI bridge to [bus 04]
[    0.464786] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.464846] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.464908] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc03fffff]
[    0.464972] pci 0000:00:1c.0:   bridge window [mem 0xf8f00000-0xf8ffffff=
 64bit pref]
[    0.465053] pci 0000:05:00.0: BAR 6: assigned [mem 0xc0400000-0xc040ffff=
 pref]
[    0.465130] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    0.465190] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.465253] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.465317] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc06fffff=
 pref]
[    0.465396] pci 0000:00:1e.0: PCI bridge to [bus 07]
[    0.465455] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.465518] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.465585] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.465586] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.465588] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.465589] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
[    0.465591] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff]
[    0.465592] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]
[    0.465594] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    0.465595] pci_bus 0000:01: resource 1 [mem 0xf9e00000-0xf9efffff]
[    0.465597] pci_bus 0000:02: resource 1 [mem 0xf9f00000-0xf9ffffff]
[    0.465599] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.465600] pci_bus 0000:03: resource 1 [mem 0xfa000000-0xfbcfffff]
[    0.465602] pci_bus 0000:03: resource 2 [mem 0xd6000000-0xdfffffff 64bit=
 pref]
[    0.465603] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
[    0.465605] pci_bus 0000:06: resource 1 [mem 0xc0000000-0xc03fffff]
[    0.465606] pci_bus 0000:06: resource 2 [mem 0xf8f00000-0xf8ffffff 64bit=
 pref]
[    0.465608] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    0.465609] pci_bus 0000:05: resource 1 [mem 0xfbd00000-0xfbdfffff]
[    0.465611] pci_bus 0000:05: resource 2 [mem 0xc0400000-0xc06fffff pref]
[    0.465612] pci_bus 0000:07: resource 0 [io  0xe000-0xefff]
[    0.465614] pci_bus 0000:07: resource 1 [mem 0xfbe00000-0xfbefffff]
[    0.465615] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7]
[    0.465617] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff]
[    0.465618] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff]
[    0.465620] pci_bus 0000:07: resource 7 [mem 0x000d0000-0x000dffff]
[    0.465621] pci_bus 0000:07: resource 8 [mem 0xc0000000-0xdfffffff]
[    0.465623] pci_bus 0000:07: resource 9 [mem 0xf0000000-0xfed8ffff]
[    0.465626] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
[    0.465627] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xfffffffff]
[    0.465707] NET: Registered protocol family 2
[    0.466032] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes)
[    0.466546] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.466723] TCP: Hash tables configured (established 262144 bind 65536)
[    0.466797] TCP: reno registered
[    0.466879] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    0.467043] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    0.467258] NET: Registered protocol family 1
[    0.468833] pci 0000:03:00.0: Boot video device
[    0.468846] PCI: CLS mismatch (256 !=3D 64), using 64 bytes
[    0.468896] Unpacking initramfs...
[    0.740554] Freeing initrd memory: 14972K (ffff8800362b2000 - ffff880037=
151000)
[    0.740650] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.740712] software IO TLB [mem 0xbb780000-0xbf780000] (64MB) mapped at=
 [ffff8800bb780000-ffff8800bf77ffff]
[    0.741015] microcode: CPU0 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.741079] microcode: CPU1 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.741144] microcode: CPU2 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.741209] microcode: CPU3 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.742235] microcode: CPU4 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.742300] microcode: CPU5 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.742364] microcode: CPU6 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.742428] microcode: CPU7 sig=3D0x106a5, pf=3D0x2, revision=3D0x19
[    0.742524] microcode: Microcode Update Driver: v2.00, Peter Oruba
[    0.742887] audit: initializing netlink socket (disabled)
[    0.742953] type=3D2000 audit(1389901435.592:1): initialized
[    0.757603] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.758432] VFS: Disk quotas dquot_6.5.2
[    0.758518] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.758646] msgmni has been set to 32768
[    0.758928] alg: No test for stdrng (krng)
[    0.759007] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    0.759119] io scheduler noop registered
[    0.759177] io scheduler deadline registered
[    0.759255] io scheduler cfq registered (default)
[    0.759483] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.759665] pcieport 0000:00:1c.0: irq 64 for MSI/MSI-X
[    0.759806] pcieport 0000:00:1c.4: irq 65 for MSI/MSI-X
[    0.759869] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.759939] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.760020] intel_idle: MWAIT substates: 0x1120
[    0.760029] intel_idle: v0.4 model 0x1A
[    0.760030] intel_idle: lapic_timer_reliable_states 0x2
[    0.760189] GHES: HEST is not enabled!
[    0.760288] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.783901] 00:0b: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    0.784298] Linux agpgart interface v0.103
[    0.784458] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.784520] i8042: PNP: PS/2 appears to have AUX port disabled, if this =
is incorrect please boot with i8042.nopnp
[    0.785077] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.785211] mousedev: PS/2 mouse device common for all mice
[    0.785300] rtc_cmos 00:02: RTC can wake from S4
[    0.785459] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.785542] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram=
, hpet irqs
[    0.785626] AMD IOMMUv2 driver by Joerg Roedel
[    0.785686] AMD IOMMUv2 functionality not available on this system
[    0.785818] TCP: cubic registered
[    0.787353] NET: Registered protocol family 10
[    0.788078] mip6: Mobile IPv6
[    0.788135] NET: Registered protocol family 17
[    0.788194] mpls_gso: MPLS GSO support
[    0.788591] registered taskstats version 1
[    0.789850] rtc_cmos 00:02: setting system clock to 2014-01-16 19:43:56 =
UTC (1389901436)
[    0.789945] PM: Hibernation image not present or could not be loaded.
[    0.790847] Freeing unused kernel memory: 988K (ffffffff818af000 - fffff=
fff819a6000)
[    0.790924] Write protecting the kernel read-only data: 8192k
[    0.795913] Freeing unused kernel memory: 1332K (ffff8800014b3000 - ffff=
880001600000)
[    0.797252] Freeing unused kernel memory: 456K (ffff88000178e000 - ffff8=
80001800000)
[    0.809128] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    0.857903] systemd-udevd[95]: starting version 204
[    0.872833] SCSI subsystem initialized
[    0.873275] ACPI: bus type USB registered
[    0.873358] usbcore: registered new interface driver usbfs
[    0.873431] usbcore: registered new interface driver hub
[    0.873686] usbcore: registered new device driver usb
[    0.874038] libata version 3.00 loaded.
[    0.874549] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.874619] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 1
[    0.874768] ahci 0000:00:1f.2: version 3.0
[    0.874826] xhci_hcd 0000:02:00.0: irq 66 for MSI/MSI-X
[    0.874836] xhci_hcd 0000:02:00.0: irq 67 for MSI/MSI-X
[    0.874843] xhci_hcd 0000:02:00.0: irq 68 for MSI/MSI-X
[    0.874851] xhci_hcd 0000:02:00.0: irq 69 for MSI/MSI-X
[    0.874857] xhci_hcd 0000:02:00.0: irq 70 for MSI/MSI-X
[    0.874863] xhci_hcd 0000:02:00.0: irq 71 for MSI/MSI-X
[    0.874870] xhci_hcd 0000:02:00.0: irq 72 for MSI/MSI-X
[    0.874877] xhci_hcd 0000:02:00.0: irq 73 for MSI/MSI-X
[    0.874903] ahci 0000:00:1f.2: irq 74 for MSI/MSI-X
[    0.874968] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x=
3f impl SATA mode
[    0.875009] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    0.875011] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.875012] usb usb1: Product: xHCI Host Controller
[    0.875013] usb usb1: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
[    0.875015] usb usb1: SerialNumber: 0000:02:00.0
[    0.875113] hub 1-0:1.0: USB hub found
[    0.875122] hub 1-0:1.0: 2 ports detected
[    0.875210] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.875214] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 2
[    0.875628] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp=
 pio slum part ccc ems sxs
[    0.875724] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.876022] uhci_hcd: USB Universal Host Controller Interface driver
[    0.878403] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[    0.878472] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.878552] usb usb2: Product: xHCI Host Controller
[    0.878614] usb usb2: Manufacturer: Linux 3.13.0-rc8+ xhci_hcd
[    0.878677] usb usb2: SerialNumber: 0000:02:00.0
[    0.878852] hub 2-0:1.0: USB hub found
[    0.878919] hub 2-0:1.0: 2 ports detected
[    0.883308] ehci-pci: EHCI PCI platform driver
[    0.888522] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    0.888664] r8169 0000:07:01.0 (unregistered net_device): not PCI Express
[    0.888950] r8169 0000:07:01.0 eth0: RTL8169sc/8110sc at 0xffffc90003052=
000, 54:04:a6:49:30:b0, XID 18000000 IRQ 19
[    0.889033] r8169 0000:07:01.0 eth0: jumbo features [frames: 7152 bytes,=
 tx checksumming: ok]
[    0.912926] scsi0 : ahci
[    0.913497] scsi1 : ahci
[    0.913635] scsi2 : ahci
[    0.913781] scsi3 : ahci
[    0.913927] scsi4 : ahci
[    0.914074] scsi5 : ahci
[    0.914155] ata1: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc10=
0 irq 74
[    0.914231] ata2: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc18=
0 irq 74
[    0.914308] ata3: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc20=
0 irq 74
[    0.914385] ata4: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc28=
0 irq 74
[    0.914462] ata5: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc30=
0 irq 74
[    0.914539] ata6: SATA max UDMA/133 abar m2048@0xf9dfc000 port 0xf9dfc38=
0 irq 74
[    0.914689] ahci 0000:01:00.0: irq 75 for MSI/MSI-X
[    0.914701] ahci 0000:01:00.0: controller can do FBS, turning on CAP_FBS
[    0.914781] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.914848] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus =
number 3
[    0.914961] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a800
[    0.915058] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.915120] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.915197] usb usb3: Product: UHCI Host Controller
[    0.915255] usb usb3: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.915315] usb usb3: SerialNumber: 0000:00:1a.0
[    0.915533] hub 3-0:1.0: USB hub found
[    0.915598] hub 3-0:1.0: 2 ports detected
[    0.915808] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.915870] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus =
number 4
[    0.915973] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
[    0.916063] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.916125] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.916201] usb usb4: Product: UHCI Host Controller
[    0.916260] usb usb4: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.916320] usb usb4: SerialNumber: 0000:00:1a.1
[    0.916564] hub 4-0:1.0: USB hub found
[    0.916628] hub 4-0:1.0: 2 ports detected
[    0.916830] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.916893] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus =
number 5
[    0.916995] uhci_hcd 0000:00:1a.2: irq 19, io base 0x0000ac00
[    0.917085] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.917147] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.917224] usb usb5: Product: UHCI Host Controller
[    0.917282] usb usb5: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.917342] usb usb5: SerialNumber: 0000:00:1a.2
[    0.917533] hub 5-0:1.0: USB hub found
[    0.917598] hub 5-0:1.0: 2 ports detected
[    0.917803] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.917865] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus =
number 6
[    0.917968] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a080
[    0.918059] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.918122] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.918198] usb usb6: Product: UHCI Host Controller
[    0.918256] usb usb6: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.918316] usb usb6: SerialNumber: 0000:00:1d.0
[    0.918509] hub 6-0:1.0: USB hub found
[    0.918574] hub 6-0:1.0: 2 ports detected
[    0.918781] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.918843] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus =
number 7
[    0.918938] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
[    0.919028] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.919091] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.919167] usb usb7: Product: UHCI Host Controller
[    0.919226] usb usb7: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.919286] usb usb7: SerialNumber: 0000:00:1d.1
[    0.919521] hub 7-0:1.0: USB hub found
[    0.919587] hub 7-0:1.0: 2 ports detected
[    0.919789] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.919852] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus =
number 8
[    0.919947] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a480
[    0.920037] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.921054] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.921130] usb usb8: Product: UHCI Host Controller
[    0.921188] usb usb8: Manufacturer: Linux 3.13.0-rc8+ uhci_hcd
[    0.921249] usb usb8: SerialNumber: 0000:00:1d.2
[    0.921408] hub 8-0:1.0: USB hub found
[    0.921471] hub 8-0:1.0: 2 ports detected
[    0.921948] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.922014] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus =
number 9
[    0.922106] ehci-pci 0000:00:1a.7: debug port 1
[    0.926059] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    0.926065] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9dff000
[    0.928509] ahci 0000:01:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0x=
ff impl SATA mode
[    0.928594] ahci 0000:01:00.0: flags: 64bit ncq fbs pio
[    0.929285] scsi6 : ahci
[    0.929439] scsi7 : ahci
[    0.929589] scsi8 : ahci
[    0.929740] scsi9 : ahci
[    0.929894] scsi10 : ahci
[    0.930050] scsi11 : ahci
[    0.930203] scsi12 : ahci
[    0.930357] scsi13 : ahci
[    0.930442] ata7: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff10=
0 irq 75
[    0.930520] ata8: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff18=
0 irq 75
[    0.930596] ata9: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff20=
0 irq 75
[    0.930673] ata10: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff2=
80 irq 75
[    0.930749] ata11: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff3=
00 irq 75
[    0.930826] ata12: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff3=
80 irq 75
[    0.930903] ata13: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff4=
00 irq 75
[    0.930980] ata14: SATA max UDMA/133 abar m2048@0xf9eff000 port 0xf9eff4=
80 irq 75
[    0.931172] ahci 0000:05:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x=
3 impl SATA mode
[    0.931252] ahci 0000:05:00.0: flags: 64bit ncq pm led clo pmp pio slum =
part
[    0.931545] scsi14 : ahci
[    0.931666] scsi15 : ahci
[    0.931753] ata15: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff10=
0 irq 16
[    0.931831] ata16: SATA max UDMA/133 abar m512@0xfbdff000 port 0xfbdff18=
0 irq 16
[    0.936417] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.936550] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    0.936614] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.936690] usb usb9: Product: EHCI Host Controller
[    0.936749] usb usb9: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
[    0.936809] usb usb9: SerialNumber: 0000:00:1a.7
[    0.936967] hub 9-0:1.0: USB hub found
[    0.937032] hub 9-0:1.0: 6 ports detected
[    0.961290] firewire_ohci 0000:07:02.0: added OHCI v1.10 device as card =
0, 4 IR + 8 IT contexts, quirks 0x11
[    0.961312] hub 3-0:1.0: USB hub found
[    0.961318] hub 3-0:1.0: 2 ports detected
[    0.984579] hub 4-0:1.0: USB hub found
[    0.984644] hub 4-0:1.0: 2 ports detected
[    1.008655] hub 5-0:1.0: USB hub found
[    1.008719] hub 5-0:1.0: 2 ports detected
[    1.009100] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.009164] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus =
number 10
[    1.010960] ehci-pci 0000:00:1d.7: debug port 1
[    1.014920] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    1.014926] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9dfe000
[    1.024573] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.024664] usb usb10: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.024731] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    1.024807] usb usb10: Product: EHCI Host Controller
[    1.024866] usb usb10: Manufacturer: Linux 3.13.0-rc8+ ehci_hcd
[    1.024927] usb usb10: SerialNumber: 0000:00:1d.7
[    1.025223] hub 10-0:1.0: USB hub found
[    1.025288] hub 10-0:1.0: 6 ports detected
[    1.048618] hub 6-0:1.0: USB hub found
[    1.048686] hub 6-0:1.0: 2 ports detected
[    1.072616] hub 7-0:1.0: USB hub found
[    1.072685] hub 7-0:1.0: 2 ports detected
[    1.096632] hub 8-0:1.0: USB hub found
[    1.096704] hub 8-0:1.0: 2 ports detected
[    1.248708] ata12: SATA link down (SStatus 0 SControl 300)
[    1.248746] ata16: SATA link down (SStatus 0 SControl 300)
[    1.248789] ata15: SATA link down (SStatus 0 SControl 300)
[    1.248914] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.248991] ata13: SATA link down (SStatus 0 SControl 300)
[    1.249096] ata8: SATA link down (SStatus 0 SControl 300)
[    1.249169] ata11: SATA link down (SStatus 0 SControl 300)
[    1.249239] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
[    1.249523] ata14.00: configured for UDMA/66
[    1.252598] ata9: SATA link down (SStatus 0 SControl 300)
[    1.252679] ata10: SATA link down (SStatus 0 SControl 300)
[    1.256664] ata7: SATA link down (SStatus 0 SControl 300)
[    1.404717] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.404802] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.404875] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.404948] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.405021] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.406100] ata6.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.406177] ata6.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.406251] ata1.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.406318] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.406390] ata4.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.406452] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.406519] ata5.00: ATA-8: ST31000340AS, SD15, max UDMA/133
[    1.406581] ata5.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.409065] ata2.00: ATAPI: TSSTcorpCD/DVDW SH-S183L, SB01, max UDMA/33
[    1.409132] ata2.00: applying bridge limits
[    1.409387] ata1.00: configured for UDMA/133
[    1.409462] ata4.00: configured for UDMA/133
[    1.409535] ata6.00: configured for UDMA/133
[    1.409638] ata5.00: configured for UDMA/133
[    1.409758] scsi 0:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.412266] ata2.00: configured for UDMA/33
[    1.412633] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.413843] ata3.00: ATA-8: ST31000528AS, CC38, max UDMA/133
[    1.413905] ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.414261] scsi 1:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183L SB=
01 PQ: 0 ANSI: 5
[    1.415240] ata3.00: configured for UDMA/133
[    1.415390] scsi 2:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.415417] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.415490] sd 0:0:0:0: [sda] Write Protect is off
[    1.415491] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.415523] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.415809] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.415916] scsi 3:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.415951] sd 2:0:0:0: [sdb] Write Protect is off
[    1.415952] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.415973] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.416245] sd 3:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.416329] scsi 4:0:0:0: Direct-Access     ATA      ST31000340AS     SD=
15 PQ: 0 ANSI: 5
[    1.416407] sd 3:0:0:0: [sdc] Write Protect is off
[    1.416409] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    1.416440] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.416646] sd 4:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.416759] scsi 5:0:0:0: Direct-Access     ATA      ST31000528AS     CC=
38 PQ: 0 ANSI: 5
[    1.416799] sd 4:0:0:0: [sdd] Write Protect is off
[    1.416800] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    1.416827] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.417102] sd 5:0:0:0: [sde] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[    1.417272] sd 5:0:0:0: [sde] Write Protect is off
[    1.417331] scsi 13:0:0:0: Processor         Marvell  91xx Config      1=
.01 PQ: 0 ANSI: 5
[    1.417414] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    1.417415]  sdc: sdc1 sdc2 sdc3
[    1.417514] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.417676] sd 3:0:0:0: [sdc] Attached SCSI disk
[    1.418576] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.418668] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    1.418758] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    1.418846] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    1.418935] sd 4:0:0:0: Attached scsi generic sg4 type 0
[    1.419028] sd 5:0:0:0: Attached scsi generic sg5 type 0
[    1.419113] scsi 13:0:0:0: Attached scsi generic sg6 type 3
[    1.421889]  sda: sda1 sda2 sda3
[    1.422019] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 =
cdda tray
[    1.422099] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.422249] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.422280] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.429983]  sdb: sdb1 sdb2 sdb3
[    1.430782] sd 2:0:0:0: [sdb] Attached SCSI disk
[    1.431761]  sdd: sdd1 sdd2 sdd3
[    1.432367] sd 4:0:0:0: [sdd] Attached SCSI disk
[    1.442578]  sde: sde1 sde2 sde3
[    1.443252] sd 5:0:0:0: [sde] Attached SCSI disk
[    1.460705] firewire_core 0000:07:02.0: created device fw0: GUID 001fc60=
0001acd8c, S400
[    1.740715] tsc: Refined TSC clocksource calibration: 2806.361 MHz
[    1.743010] random: nonblocking pool is initialized
[    1.836374] md: md127 stopped.
[    1.836717] usb 8-1: new low-speed USB device number 2 using uhci_hcd
[    1.840810] md: bind
[    1.841257] md: bind
[    1.841670] md: bind
[    1.841899] md: bind
[    1.846963] md: bind
[    1.848319] md: raid10 personality registered for level 10
[    1.848729] md/raid10:md127: active with 4 out of 4 devices
[    1.848930] created bitmap (466 pages) for device md127
[    1.862800] md127: bitmap initialized from disk: read 30 pages, set 0 of=
 953616 bits
[    1.891778] md127: detected capacity change from 0 to 1999877701632
[    1.891864] RAID10 conf printout:
[    1.891867]  --- wd:4 rd:4
[    1.891869]  disk 0, wo:0, o:1, dev:sda3
[    1.891875]  disk 1, wo:0, o:1, dev:sdc3
[    1.891876]  disk 2, wo:0, o:1, dev:sdb3
[    1.891877]  disk 3, wo:0, o:1, dev:sdd3
[    1.893251]  md127: unknown partition table
[    1.928165] device-mapper: uevent: version 1.0.3
[    1.928285] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised:=
 dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    1.970135] bio: create slab  at 1
[    2.014894] usb 8-1: New USB device found, idVendor=3D046d, idProduct=3D=
c01e
[    2.014963] usb 8-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.015030] usb 8-1: Product: USB-PS/2 Optical Mouse
[    2.015088] usb 8-1: Manufacturer: Logitech
[    2.020000] hidraw: raw HID events driver (C) Jiri Kosina
[    2.035997] usbcore: registered new interface driver usbhid
[    2.036059] usbhid: USB HID core driver
[    2.039750] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:0=
0/0000:00:1d.2/usb8/8-1/8-1:1.0/input/input1
[    2.039966] hid-generic 0003:046D:C01E.0001: input,hidraw0: USB HID v1.1=
0 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-1/input0
[    2.069935] EXT4-fs (dm-0): mounted filesystem with ordered data mode. O=
pts: (null)
[    2.256949] usb 8-2: new low-speed USB device number 3 using uhci_hcd
[    2.567106] usb 8-2: New USB device found, idVendor=3D051d, idProduct=3D=
0002
[    2.567175] usb 8-2: New USB device strings: Mfr=3D3, Product=3D1, Seria=
lNumber=3D2
[    2.567242] usb 8-2: Product: Back-UPS RS 1500 FW:8.g9 .D USB FW:g9
[    2.567304] usb 8-2: Manufacturer: American Power Conversion
[    2.567364] usb 8-2: SerialNumber: JB0539032829
[    2.741406] Switched to clocksource tsc
[    3.639622] hid-generic 0003:051D:0002.0002: hiddev0,hidraw1: USB HID v1=
.10 Device [American Power Conversion Back-UPS RS 1500 FW:8.g9 .D USB FW:g9=
 ] on usb-0000:00:1d.2-2/input0
[   12.992509] systemd-udevd[605]: starting version 204
[   13.526865] ACPI Warning: 0x0000000000000828-0x000000000000082f SystemIO=
 conflicts with Region \PMRG 1 (20131115/utaddress-251)
[   13.527040] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   13.527122] ACPI Warning: 0x0000000000000530-0x000000000000053f SystemIO=
 conflicts with Region \GPS0 1 (20131115/utaddress-251)
[   13.527280] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   13.527360] ACPI Warning: 0x0000000000000500-0x000000000000052f SystemIO=
 conflicts with Region \GPS0 1 (20131115/utaddress-251)
[   13.527517] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   13.527597] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   13.543090] EDAC MC: Ver: 3.0.0
[   13.550602] EDAC MC0: Giving out device to module i7core_edac.c controll=
er i7 core #0: DEV 0000:ff:03.0 (POLLED)
[   13.550710] EDAC PCI0: Giving out device to module i7core_edac controlle=
r EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)
[   13.550798] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   13.565571] ACPI Warning: 0x0000000000001000-0x000000000000101f SystemIO=
 conflicts with Region \SMRG 1 (20131115/utaddress-251)
[   13.565733] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   13.587366] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input2
[   13.587450] ACPI: Power Button [PWRB]
[   13.587551] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[   13.587630] ACPI: Power Button [PWRF]
[   13.589599] [drm] Initialized drm 1.1.0 20060810
[   13.701591] wmi: Mapper loaded
[   13.726166] systemd-udevd[651]: renamed network interface eth0 to lan
[   13.754012] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   13.760019] ATK0110 ATK0110:00: Overriding interface detection
[   13.820541] iTCO_vendor_support: vendor-support=3D0
[   13.845409] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[   13.847237] iTCO_wdt: Found a ICH10R TCO device (Version=3D2, TCOBASE=3D=
0x0860)
[   13.847381] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D1)
[   13.860321] nouveau: unknown parameter 'perflvl_wr' ignored
[   13.860587] MXM: GUID detected in BIOS
[   13.860876] nouveau  [  DEVICE][0000:03:00.0] BOOT0  : 0x0c1000a1
[   13.860938] nouveau  [  DEVICE][0000:03:00.0] Chipset: GF108 (NVC1)
[   13.860999] nouveau  [  DEVICE][0000:03:00.0] Family : NVC0
[   13.861940] nouveau  [   VBIOS][0000:03:00.0] checking PRAMIN for image.=
..
[   13.927768] nouveau  [   VBIOS][0000:03:00.0] ... appears to be valid
[   13.927832] nouveau  [   VBIOS][0000:03:00.0] using image from PRAMIN
[   13.927989] nouveau  [   VBIOS][0000:03:00.0] BIT signature found
[   13.928050] nouveau  [   VBIOS][0000:03:00.0] version 70.08.4d.00.00
[   13.928328] nouveau 0000:03:00.0: irq 76 for MSI/MSI-X
[   13.928335] nouveau  [     PMC][0000:03:00.0] MSI interrupts enabled
[   13.930142] nouveau W[     PFB][0000:03:00.0][0x00000000][ffff88061e6318=
00] reclocking of this ram type unsupported
[   13.930260] nouveau  [     PFB][0000:03:00.0] RAM type: DDR3
[   13.930349] nouveau  [     PFB][0000:03:00.0] RAM size: 512 MiB
[   13.930443] nouveau  [     PFB][0000:03:00.0]    ZCOMP: 0 tags
[   13.960704] nouveau  [  PTHERM][0000:03:00.0] FAN control: none / extern=
al
[   13.960802] nouveau  [  PTHERM][0000:03:00.0] fan management: automatic
[   13.960896] nouveau  [  PTHERM][0000:03:00.0] internal sensor: yes
[   13.961013] nouveau  [     CLK][0000:03:00.0] 03: core 50 MHz memory 135=
 MHz
[   13.961105] nouveau  [     CLK][0000:03:00.0] 07: core 405 MHz memory 32=
4 MHz
[   13.961216] nouveau  [     CLK][0000:03:00.0] 0f: core 810 MHz memory 90=
0 MHz
[   13.961474] nouveau  [     CLK][0000:03:00.0] --: core 405 MHz memory 32=
4 MHz
[   13.965856] md: bind
[   13.971577] [TTM] Zone  kernel: Available graphics memory: 12368142 kiB
[   13.971671] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   13.971762] [TTM] Initializing pool allocator
[   13.971854] [TTM] Initializing DMA pool allocator
[   13.971953] nouveau  [     DRM] VRAM: 512 MiB
[   13.972043] nouveau  [     DRM] GART: 1048576 MiB
[   13.972132] nouveau  [     DRM] TMDS table version 2.0
[   13.972221] nouveau  [     DRM] DCB version 4.0
[   13.972308] nouveau  [     DRM] DCB outp 00: 01000302 00020030
[   13.972398] nouveau  [     DRM] DCB outp 01: 02000300 00000000
[   13.972488] nouveau  [     DRM] DCB outp 02: 08011392 00020020
[   13.972582] nouveau  [     DRM] DCB outp 03: 04022310 00000000
[   13.972674] nouveau  [     DRM] DCB conn 00: 00001030
[   13.972826] nouveau  [     DRM] DCB conn 01: 00002161
[   13.972977] nouveau  [     DRM] DCB conn 02: 00000200
[   13.974024] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   13.974114] [drm] No driver support for vblank timestamp query.
[   13.988791] nouveau  [     DRM] MM: using COPY0 for buffer copies
[   14.024814] md: bind
[   14.046952] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work proper=
ly. Using workaround
[   14.073508] snd_hda_intel 0000:00:1b.0: irq 77 for MSI/MSI-X
[   14.079696] nouveau  [     DRM] allocated 1024x768 fb: 0x60000, bo ffff8=
8061d8c2800
[   14.079890] fbcon: nouveaufb (fb0) is primary device
[   14.098104] md: bind
[   14.127062] input: HDA Intel Front Headphone as /devices/pci0000:00/0000=
:00:1b.0/sound/card0/input12
[   14.127111] input: HDA Intel Line Out Side as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input11
[   14.127151] input: HDA Intel Line Out CLFE as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input10
[   14.127190] input: HDA Intel Line Out Surround as /devices/pci0000:00/00=
00:00:1b.0/sound/card0/input9
[   14.127231] input: HDA Intel Line Out Front as /devices/pci0000:00/0000:=
00:1b.0/sound/card0/input8
[   14.127270] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/so=
und/card0/input7
[   14.127309] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.=
0/sound/card0/input6
[   14.127349] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b=
.0/sound/card0/input5
[   14.150927] md: bind
[   14.157534] Console: switching to colour frame buffer device 128x48
[   14.158695] nouveau 0000:03:00.0: fb0: nouveaufb frame buffer device
[   14.158708] nouveau 0000:03:00.0: registered panic notifier
[   14.158722] [drm] Initialized nouveau 1.1.1 20120801 for 0000:03:00.0 on=
 minor 0
[   14.158875] hda_intel: Disabling MSI
[   14.158905] hda-intel 0000:03:00.1: Handle VGA-switcheroo audio client
[   14.190837] md: bind
[   14.215740] md: raid1 personality registered for level 1
[   14.216101] md/raid1:md0: active with 5 out of 5 mirrors
[   14.218657] created bitmap (16 pages) for device md0
[   14.219260] md0: bitmap initialized from disk: read 2 pages, set 0 of 32=
096 bits
[   14.231555] md0: detected capacity change from 0 to 131465216
[   14.231664] RAID1 conf printout:
[   14.231668]  --- wd:5 rd:5
[   14.231671]  disk 0, wo:0, o:1, dev:sda1
[   14.231673]  disk 1, wo:0, o:1, dev:sdc1
[   14.231675]  disk 2, wo:0, o:1, dev:sdb1
[   14.231677]  disk 3, wo:0, o:1, dev:sdd1
[   14.231679]  disk 4, wo:0, o:1, dev:sde1
[   14.234020]  md0: unknown partition table
[   14.965054] input: HDA NVidia HDMI/DP,pcm=3D9 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input16
[   14.965520] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input15
[   14.965964] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input14
[   14.966411] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/000=
0:00:03.0/0000:03:00.1/sound/card1/input13
[   15.496666] EXT4-fs (dm-0): re-mounted. Opts: (null)
[   15.905182] RAID10 conf printout:
[   15.905188]  --- wd:4 rd:4
[   15.905193]  disk 0, wo:0, o:1, dev:sda3
[   15.905196]  disk 1, wo:0, o:1, dev:sdc3
[   15.905199]  disk 2, wo:0, o:1, dev:sdb3
[   15.905202]  disk 3, wo:0, o:1, dev:sdd3
[   16.033206] EXT4-fs (dm-0): re-mounted. Opts: user_xattr,errors=3Dremoun=
t-ro
[   16.465027] loop: module loaded
[   17.806651] Adding 5857276k swap on /dev/mapper/Zia-swap_crypt.  Priorit=
y:-1 extents:1 across:5857276k
[   18.813884] EXT4-fs (md0): mounting ext2 file system using the ext4 subs=
ystem
[   18.955306] EXT4-fs (md0): mounted filesystem without journal. Opts: (nu=
ll)
[   19.063331] EXT4-fs (dm-3): mounted filesystem with ordered data mode. O=
pts: user_xattr
[   19.072942] EXT4-fs (dm-2): mounted filesystem with ordered data mode. O=
pts: user_xattr
[   19.140589] FAT-fs (sda2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   19.164405] FAT-fs (sda2): Volume was not properly unmounted. Some data =
may be corrupt. Please run fsck.
[   19.195524] FAT-fs (sdc2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   19.208240] FAT-fs (sdc2): Volume was not properly unmounted. Some data =
may be corrupt. Please run fsck.
[   19.221636] FAT-fs (sdb2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   19.223272] FAT-fs (sdb2): Volume was not properly unmounted. Some data =
may be corrupt. Please run fsck.
[   19.250690] FAT-fs (sdd2): utf8 is not a recommended IO charset for FAT =
filesystems, filesystem will be case sensitive!
[   19.262259] FAT-fs (sdd2): Volume was not properly unmounted. Some data =
may be corrupt. Please run fsck.
[   20.136642] Bridge firewalling registered
[   20.139914] device lan entered promiscuous mode
[   20.155416] r8169 0000:07:01.0 lan: link down
[   20.155475] r8169 0000:07:01.0 lan: link down
[   20.156173] IPv6: ADDRCONF(NETDEV_UP): lan: link is not ready
[   20.159615] IPv6: ADDRCONF(NETDEV_UP): br0: link is not ready
[   22.966015] r8169 0000:07:01.0 lan: link up
[   22.966286] IPv6: ADDRCONF(NETDEV_CHANGE): lan: link becomes ready
[   22.969072] br0: port 1(lan) entered forwarding state
[   22.970674] br0: port 1(lan) entered forwarding state
[   22.972315] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[   23.802549] RPC: Registered named UNIX socket transport module.
[   23.802703] RPC: Registered udp transport module.
[   23.802988] RPC: Registered tcp transport module.
[   23.803432] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   23.812593] FS-Cache: Loaded
[   23.826837] FS-Cache: Netfs 'nfs' registered for caching
[   23.986609] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
[   24.972021] br0: port 1(lan) entered forwarding state
[  191.606562] tun: Universal TUN/TAP device driver, 1.6
[  191.606773] tun: (C) 1999-2004 Max Krasnyansky
[  201.333408] CacheFiles: Loaded
[  201.919717] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recov=
ery directory
[  201.964146] NFSD: starting 90-second grace period (net ffffffff81885e00)
[  202.731250] lp: driver loaded but no devices found
[  202.733483] ppdev: user-space parallel port driver
[  205.260548] FS-Cache: Cache "mycache" added (type cachefiles)
[  205.260554] CacheFiles: File cache on dm-0 registered
[  209.909484] Ebtables v2.0 registered
[  209.951359] ip_tables: (C) 2000-2006 Netfilter Core Team
[  209.969159] ip6_tables: (C) 2000-2006 Netfilter Core Team
[  216.478120] postgres (6026): /proc/6026/oom_adj is deprecated, please us=
e /proc/6026/oom_score_adj instead.
[  223.000968] watchdog watchdog0: nowayout prevents watchdog being stopped!
[  223.000972] watchdog watchdog0: watchdog did not stop!
[  236.339128] type=3D1006 audit(1389901671.250:2): pid=3D5071 uid=3D0 old =
auid=3D4294967295 new auid=3D1000 old ses=3D4294967295 new ses=3D1 res=3D1
[  431.281434] do_IRQ: 0.196 No irq handler for vector (irq -1)
