From: Dheeraj CVR <cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUGREPORT] Intel X58 Boards don't boot after "iommu/vt-d: Make
	root entry visible for hardware right after allocation"
Date: Fri, 29 Apr 2016 16:41:23 +0400
Message-ID: <CAH-=PyTaR-xH7D4eOnFkB-7gojdZW08yHEPP2Gw2-0GjWTA4dw@mail.gmail.com>
References: <CAH-=PyRpjuKf0XJNyzkVLpggaaYq163AfA84SZ5=DQH2Ys5Lkw@mail.gmail.com>
	<CAH-=PyR-6sY1vuzQSfJyh35Q+WqZKD70Ev7vDns+02h8j=m18Q@mail.gmail.com>
	<20160425110151.GE17926@8bytes.org>
	<CAH-=PyTGF76sq7LvQH0-28DoK1dXGUOdnCF6z9shF_CWosWYwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0503143382996010530=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAH-=PyTGF76sq7LvQH0-28DoK1dXGUOdnCF6z9shF_CWosWYwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0503143382996010530==
Content-Type: multipart/alternative; boundary=047d7b10d1abec28fa05319ef53d

--047d7b10d1abec28fa05319ef53d
Content-Type: text/plain; charset=UTF-8

Hi Joerg,

Did you find time to have a look at the dmesg that I have sent to you in
the earlier email? Please let me know if you need any more debugging info
to diagnose this issue.

On Mon, Apr 25, 2016 at 3:31 PM, Dheeraj CVR <cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> The dmesg below is with kernel 4.6.0-rc4 built from mainline source with
> "iommu/vt-d: Make root entry visible for hardware right after allocation"
> reverted. Please let me know if you need a dmesg with 4.1 kernel too.
>
> [    0.000000] Linux version 4.6.0-rc4-3697330 (dhiru1602@ScaRage) (gcc
> version 5.3.0 (GCC) ) #1 SMP PREEMPT Mon Apr 25 15:11:55 GST 2016
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-linux-git
> root=UUID=80dfd13f-1755-4c83-b110-84282a777964 rw intel_iommu=on quiet
> [    0.000000] x86/fpu: Legacy x87 FPU detected.
> [    0.000000] x86/fpu: Using 'eager' FPU context switches.
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cfff]
> usable
> [    0.000000] BIOS-e820: [mem 0x000000000009d000-0x000000000009ffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff]
> usable
> [    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf78dfff] ACPI
> data
> [    0.000000] BIOS-e820: [mem 0x00000000bf78e000-0x00000000bf7cffff] ACPI
> NVS
> [    0.000000] BIOS-e820: [mem 0x00000000bf7d0000-0x00000000bf7dffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000bf7e8000-0x00000000bfffffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043fffffff]
> usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.6 present.
> [    0.000000] DMI: MSI MS-7666/Big Bang-XPower (MS-7666), BIOS V1.7
> 07/27/2012
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] e820: last_pfn = 0x440000 max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-D3FFF write-protect
> [    0.000000]   D4000-DFFFF uncachable
> [    0.000000]   E0000-E3FFF write-protect
> [    0.000000]   E4000-EFFFF write-through
> [    0.000000]   F0000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 0000000000 mask FC00000000 write-back
> [    0.000000]   1 base 0400000000 mask FFC0000000 write-back
> [    0.000000]   2 base 00C0000000 mask FFC0000000 uncachable
> [    0.000000]   3 base 00BF800000 mask FFFF800000 uncachable
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000]   8 disabled
> [    0.000000]   9 disabled
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC-
> WT
> [    0.000000] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
> [    0.000000] e820: last_pfn = 0xbf780 max_arch_pfn = 0x400000000
> [    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at
> [ffff8800000ff780]
> [    0.000000] Scanning 1 areas for low memory corruption
> [    0.000000] Base memory trampoline at [ffff880000097000] 97000 size
> 24576
> [    0.000000] Using GB pages for direct mapping
> [    0.000000] BRK [0x01b4f000, 0x01b4ffff] PGTABLE
> [    0.000000] BRK [0x01b50000, 0x01b50fff] PGTABLE
> [    0.000000] BRK [0x01b51000, 0x01b51fff] PGTABLE
> [    0.000000] RAMDISK: [mem 0x3779e000-0x37bc6fff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000FA5A0 000014 (v00 ACPIAM)
> [    0.000000] ACPI: RSDT 0x00000000BF780000 000040 (v01 7666MS A7666100
> 20120727 MSFT 00000097)
> [    0.000000] ACPI: FACP 0x00000000BF780200 000084 (v01 7666MS A7666100
> 20120727 MSFT 00000097)
> [    0.000000] ACPI: DSDT 0x00000000BF780600 006CF8 (v01 A7666  A7666100
> 00000100 INTL 20051117)
> [    0.000000] ACPI: FACS 0x00000000BF78E000 000040
> [    0.000000] ACPI: APIC 0x00000000BF780390 0000AC (v01 7666MS A7666100
> 20120727 MSFT 00000097)
> [    0.000000] ACPI: MCFG 0x00000000BF780440 00003C (v01 7666MS OEMMCFG
>  20120727 MSFT 00000097)
> [    0.000000] ACPI: OEMB 0x00000000BF78E040 000082 (v01 7666MS A7666100
> 20120727 MSFT 00000097)
> [    0.000000] ACPI: DMAR 0x00000000BF78E0D0 000150 (v01 AMI    OEMDMAR
>  00000001 MSFT 00000097)
> [    0.000000] ACPI: HPET 0x00000000BF78A600 000038 (v01 7666MS OEMHPET
>  20120727 MSFT 00000097)
> [    0.000000] ACPI: SSDT 0x00000000BF790F40 000363 (v01 DpgPmm CpuPm
>  00000012 INTL 20051117)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000043fffffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x43fffa000-0x43fffdfff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000043fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bf77ffff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x000000043fffffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000000000001000-0x000000043fffffff]
> [    0.000000] On node 0 totalpages: 4192028
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3996 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 12190 pages used for memmap
> [    0.000000]   DMA32 zone: 780160 pages, LIFO batch:31
> [    0.000000]   Normal zone: 53248 pages used for memmap
> [    0.000000]   Normal zone: 3407872 pages, LIFO batch:31
> [    0.000000] ACPI: PM-Timer IO Port: 0x808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] IOAPIC[0]: apic_id 6, version 32, address 0xfec00000, GSI
> 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0xffffffff base: 0xfed00000
> [    0.000000] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf780000-0xbf78dfff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf78e000-0xbf7cffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf7d0000-0xbf7dffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf7e0000-0xbf7e7fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf7e8000-0xbfffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfedfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffbfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
> [    0.000000] e820: [mem 0xc0000000-0xfedfffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 6370452778343963 ns
> [    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:12
> nr_node_ids:1
> [    0.000000] percpu: Embedded 32 pages/cpu @ffff88043fc00000 s93528
> r8192 d29352 u131072
> [    0.000000] pcpu-alloc: s93528 r8192 d29352 u131072 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 -- --
> -- --
> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.
> Total pages: 4126505
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux-git
> root=UUID=80dfd13f-1755-4c83-b110-84282a777964 rw intel_iommu=on quiet
> [    0.000000] DMAR: IOMMU enabled
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA -
> bailing!
> [    0.000000] Memory: 16422160K/16768112K available (5928K kernel code,
> 974K rwdata, 1800K rodata, 1224K init, 1152K bss, 345952K reserved, 0K
> cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] Build-time adjustment of leaf fanout to 64.
> [    0.000000] RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=12.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64,
> nr_cpu_ids=12
> [    0.000000] NR_IRQS:8448 nr_irqs:520 16
> [    0.000000] Console: colour dummy device 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 133484882848 ns
> [    0.000000] hpet clockevent registered
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 4399.822 MHz processor
> [    0.000021] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 8803.29 BogoMIPS (lpj=14666073)
> [    0.000023] pid_max: default: 32768 minimum: 301
> [    0.000028] ACPI: Core revision 20160108
> [    0.003295] ACPI: 2 ACPI AML tables successfully acquired and loaded
>
> [    0.003313] Security Framework initialized
> [    0.003315] Yama: becoming mindful.
> [    0.003986] Dentry cache hash table entries: 2097152 (order: 12,
> 16777216 bytes)
> [    0.006358] Inode-cache hash table entries: 1048576 (order: 11, 8388608
> bytes)
> [    0.007416] Mount-cache hash table entries: 32768 (order: 6, 262144
> bytes)
> [    0.007428] Mountpoint-cache hash table entries: 32768 (order: 6,
> 262144 bytes)
> [    0.007643] CPU: Physical Processor ID: 0
> [    0.007644] CPU: Processor Core ID: 0
> [    0.007651] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.007651] ENERGY_PERF_BIAS: View and update with
> x86_energy_perf_policy(8)
> [    0.007653] mce: CPU supports 9 MCE banks
> [    0.007663] CPU0: Thermal monitoring enabled (TM1)
> [    0.007669] process: using mwait in idle threads
> [    0.007672] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
> [    0.007672] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
> [    0.007848] Freeing SMP alternatives memory: 24K (ffffffff81a27000 -
> ffffffff81a2d000)
> [    0.030823] ftrace: allocating 23549 entries in 92 pages
> [    0.037549] smpboot: Max logical packages: 2
> [    0.037551] smpboot: APIC(0) Converting physical 0 to logical package 0
> [    0.037554] DMAR-IR: This system BIOS has enabled interrupt remapping
>                on a chipset that contains an erratum making that
>                feature unstable.  To maintain system stability
>                interrupt remapping is being disabled.  Please
>                contact your BIOS vendor for an update
> [    0.037557] Switched APIC routing to physical flat.
> [    0.037916] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.176482] smpboot: CPU0: Intel(R) Xeon(R) CPU           X5670  @
> 2.93GHz (family: 0x6, model: 0x2c, stepping: 0x2)
> [    0.176490] Performance Events: PEBS fmt1+, 16-deep LBR, Westmere
> events, Intel PMU driver.
> [    0.176501] core: CPUID marked event: 'bus cycles' unavailable
> [    0.176502] ... version:                3
> [    0.176503] ... bit width:              48
> [    0.176503] ... generic registers:      4
> [    0.176504] ... value mask:             0000ffffffffffff
> [    0.176505] ... max period:             000000007fffffff
> [    0.176505] ... fixed-purpose events:   3
> [    0.176506] ... event mask:             000000070000000f
> [    0.177053] NMI watchdog: enabled on all CPUs, permanently consumes one
> hw-PMU counter.
> [    0.177124] x86: Booting SMP configuration:
> [    0.177125] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8
>  #9 #10 #11
> [    1.111878] x86: Booted up 1 node, 12 CPUs
> [    1.111880] smpboot: Total of 12 processors activated (105640.36
> BogoMIPS)
> [    1.122157] devtmpfs: initialized
> [    1.122194] x86/mm: Memory block size: 128MB
> [    1.124262] PM: Registering ACPI NVS region [mem 0xbf78e000-0xbf7cffff]
> (270336 bytes)
> [    1.124316] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 6370867519511994 ns
> [    1.124356] pinctrl core: initialized pinctrl subsystem
> [    1.124390] RTC time: 11:20:20, date: 04/25/16
> [    1.125298] NET: Registered protocol family 16
> [    1.136507] cpuidle: using governor ladder
> [    1.149841] cpuidle: using governor menu
> [    1.149882] ACPI: bus type PCI registered
> [    1.149886] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    1.149927] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
> 0xe0000000-0xefffffff] (base 0xe0000000)
> [    1.149928] PCI: not using MMCONFIG
> [    1.149929] PCI: Using configuration type 1 for base access
> [    1.163263] HugeTLB registered 1 GB page size, pre-allocated 0 pages
> [    1.163264] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    1.163413] ACPI: Added _OSI(Module Device)
> [    1.163414] ACPI: Added _OSI(Processor Device)
> [    1.163415] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    1.163416] ACPI: Added _OSI(Processor Aggregator Device)
> [    1.163618] ACPI: Executed 1 blocks of module-level executable AML code
> [    1.165471] ACPI: Dynamic OEM Table Load:
> [    1.165480] ACPI: SSDT 0xFFFF88042CDE8000 002D18 (v01 DpgPmm P001Ist
>  00000011 INTL 20051117)
> [    1.165914] ACPI: Interpreter enabled
> [    1.165923] ACPI: (supports S0 S1 S4 S5)
> [    1.165924] ACPI: Using IOAPIC for interrupt routing
> [    1.165940] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
> 0xe0000000-0xefffffff] (base 0xe0000000)
> [    1.166245] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in
> ACPI motherboard resources
> [    1.166248] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000]
> with a huge-page mapping due to MTRR override.
> [    1.166548] PCI: Using host bridge windows from ACPI; if necessary, use
> "pci=nocrs" and report a bug
> [    1.169965] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    1.169968] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> ClockPM Segments MSI]
> [    1.170058] acpi PNP0A08:00: _OSC: platform does not support
> [PCIeCapability]
> [    1.170101] acpi PNP0A08:00: _OSC: not requesting control; platform
> does not support [PCIeCapability]
> [    1.170103] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME AER
> PCIeCapability]
> [    1.170104] acpi PNP0A08:00: _OSC: platform willing to grant
> [PCIeHotplug PME AER]
> [    1.170105] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
> [    1.170259] PCI host bridge to bus 0000:00
> [    1.170261] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7
> window]
> [    1.170262] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff
> window]
> [    1.170263] pci_bus 0000:00: root bus resource [mem
> 0x000a0000-0x000bffff window]
> [    1.170264] pci_bus 0000:00: root bus resource [mem
> 0x000d0000-0x000dffff window]
> [    1.170265] pci_bus 0000:00: root bus resource [mem
> 0xc0000000-0xdfffffff window]
> [    1.170266] pci_bus 0000:00: root bus resource [mem
> 0xf0000000-0xfed8ffff window]
> [    1.170267] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.170274] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000
> [    1.170313] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [    1.170367] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
> [    1.170406] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    1.170439] pci 0000:00:01.0: System wakeup disabled by ACPI
> [    1.170463] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
> [    1.170500] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
> [    1.170532] pci 0000:00:02.0: System wakeup disabled by ACPI
> [    1.170555] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
> [    1.170593] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> [    1.170625] pci 0000:00:03.0: System wakeup disabled by ACPI
> [    1.170649] pci 0000:00:05.0: [8086:340c] type 01 class 0x060400
> [    1.170683] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
> [    1.170714] pci 0000:00:05.0: System wakeup disabled by ACPI
> [    1.170737] pci 0000:00:06.0: [8086:340d] type 01 class 0x060400
> [    1.170771] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
> [    1.170802] pci 0000:00:06.0: System wakeup disabled by ACPI
> [    1.170825] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
> [    1.170863] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
> [    1.170895] pci 0000:00:07.0: System wakeup disabled by ACPI
> [    1.170918] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
> [    1.170952] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
> [    1.170983] pci 0000:00:09.0: System wakeup disabled by ACPI
> [    1.171006] pci 0000:00:0a.0: [8086:3411] type 01 class 0x060400
> [    1.171040] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
> [    1.171072] pci 0000:00:0a.0: System wakeup disabled by ACPI
> [    1.171097] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
> [    1.171169] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
> [    1.171239] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
> [    1.171307] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
> [    1.171375] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
> [    1.171407] pci 0000:00:1a.0: reg 0x20: [io  0x5400-0x541f]
> [    1.171467] pci 0000:00:1a.0: System wakeup disabled by ACPI
> [    1.171491] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
> [    1.171523] pci 0000:00:1a.1: reg 0x20: [io  0x5480-0x549f]
> [    1.171584] pci 0000:00:1a.1: System wakeup disabled by ACPI
> [    1.171607] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
> [    1.171639] pci 0000:00:1a.2: reg 0x20: [io  0x5800-0x581f]
> [    1.171700] pci 0000:00:1a.2: System wakeup disabled by ACPI
> [    1.171728] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
> [    1.171742] pci 0000:00:1a.7: reg 0x10: [mem 0xf9af8000-0xf9af83ff]
> [    1.171809] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
> [    1.171838] pci 0000:00:1a.7: System wakeup disabled by ACPI
> [    1.171863] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300
> [    1.171876] pci 0000:00:1b.0: reg 0x10: [mem 0xf9af4000-0xf9af7fff
> 64bit]
> [    1.171931] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    1.171984] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
> [    1.172038] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    1.172071] pci 0000:00:1c.0: System wakeup disabled by ACPI
> [    1.172095] pci 0000:00:1c.1: [8086:3a42] type 01 class 0x060400
> [    1.172148] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    1.172182] pci 0000:00:1c.1: System wakeup disabled by ACPI
> [    1.172205] pci 0000:00:1c.2: [8086:3a44] type 01 class 0x060400
> [    1.172259] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> [    1.172291] pci 0000:00:1c.2: System wakeup disabled by ACPI
> [    1.172315] pci 0000:00:1c.3: [8086:3a46] type 01 class 0x060400
> [    1.172368] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> [    1.172401] pci 0000:00:1c.3: System wakeup disabled by ACPI
> [    1.172424] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
> [    1.172477] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    1.172509] pci 0000:00:1c.4: System wakeup disabled by ACPI
> [    1.172534] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
> [    1.172568] pci 0000:00:1d.0: reg 0x20: [io  0x5880-0x589f]
> [    1.172630] pci 0000:00:1d.0: System wakeup disabled by ACPI
> [    1.172654] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
> [    1.172686] pci 0000:00:1d.1: reg 0x20: [io  0x5c00-0x5c1f]
> [    1.172746] pci 0000:00:1d.1: System wakeup disabled by ACPI
> [    1.172770] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
> [    1.172802] pci 0000:00:1d.2: reg 0x20: [io  0x6000-0x601f]
> [    1.172861] pci 0000:00:1d.2: System wakeup disabled by ACPI
> [    1.172891] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
> [    1.172904] pci 0000:00:1d.7: reg 0x10: [mem 0xf9afa000-0xf9afa3ff]
> [    1.172971] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> [    1.173000] pci 0000:00:1d.7: System wakeup disabled by ACPI
> [    1.173023] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
> [    1.173077] pci 0000:00:1e.0: System wakeup disabled by ACPI
> [    1.173101] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
> [    1.173165] pci 0000:00:1f.0: can't claim BAR 13 [io  0x0800-0x087f]:
> address conflict with ACPI CPU throttle [io  0x0810-0x0815]
> [    1.173168] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by
> ICH6 GPIO
> [    1.173171] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0a00
> (mask 00ff)
> [    1.173175] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0a00
> (mask 0017)
> [    1.173178] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 4700
> (mask 00ff)
> [    1.173245] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
> [    1.173256] pci 0000:00:1f.2: reg 0x10: [io  0x6880-0x6887]
> [    1.173261] pci 0000:00:1f.2: reg 0x14: [io  0x6800-0x6803]
> [    1.173267] pci 0000:00:1f.2: reg 0x18: [io  0x6480-0x6487]
> [    1.173272] pci 0000:00:1f.2: reg 0x1c: [io  0x6400-0x6403]
> [    1.173277] pci 0000:00:1f.2: reg 0x20: [io  0x6080-0x609f]
> [    1.173283] pci 0000:00:1f.2: reg 0x24: [mem 0xf9afc000-0xf9afc7ff]
> [    1.173314] pci 0000:00:1f.2: PME# supported from D3hot
> [    1.173360] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
> [    1.173371] pci 0000:00:1f.3: reg 0x10: [mem 0xf9afe000-0xf9afe0ff
> 64bit]
> [    1.173387] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
> [    1.173472] pci 0000:0e:00.0: [1033:0194] type 00 class 0x0c0330
> [    1.173486] pci 0000:0e:00.0: reg 0x10: [mem 0xfbefe000-0xfbefffff
> 64bit]
> [    1.173556] pci 0000:0e:00.0: PME# supported from D0 D3hot D3cold
> [    1.179851] pci 0000:00:01.0: PCI bridge to [bus 0e]
> [    1.179856] pci 0000:00:01.0:   bridge window [mem
> 0xfbe00000-0xfbefffff]
> [    1.179900] pci 0000:0d:00.0: [1b4b:9123] type 00 class 0x010601
> [    1.179908] pci 0000:0d:00.0: reg 0x10: [io  0xe080-0xe087]
> [    1.179914] pci 0000:0d:00.0: reg 0x14: [io  0xe000-0xe003]
> [    1.179919] pci 0000:0d:00.0: reg 0x18: [io  0xdc00-0xdc07]
> [    1.179924] pci 0000:0d:00.0: reg 0x1c: [io  0xd880-0xd883]
> [    1.179929] pci 0000:0d:00.0: reg 0x20: [io  0xd800-0xd80f]
> [    1.179935] pci 0000:0d:00.0: reg 0x24: [mem 0xfbddf800-0xfbddffff]
> [    1.179940] pci 0000:0d:00.0: reg 0x30: [mem 0xfbdc0000-0xfbdcffff pref]
> [    1.179967] pci 0000:0d:00.0: PME# supported from D3hot
> [    1.186515] pci 0000:00:02.0: PCI bridge to [bus 0d]
> [    1.186519] pci 0000:00:02.0:   bridge window [io  0xd000-0xefff]
> [    1.186522] pci 0000:00:02.0:   bridge window [mem
> 0xfbd00000-0xfbdfffff]
> [    1.186563] pci 0000:0c:00.0: [10de:1080] type 00 class 0x030000
> [    1.186572] pci 0000:0c:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
> [    1.186579] pci 0000:0c:00.0: reg 0x14: [mem 0xd8000000-0xdfffffff
> 64bit pref]
> [    1.186586] pci 0000:0c:00.0: reg 0x1c: [mem 0xd6000000-0xd7ffffff
> 64bit pref]
> [    1.186591] pci 0000:0c:00.0: reg 0x24: [io  0xcc00-0xcc7f]
> [    1.186596] pci 0000:0c:00.0: reg 0x30: [mem 0xf9f80000-0xf9ffffff pref]
> [    1.186660] pci 0000:0c:00.1: [10de:0e09] type 00 class 0x040300
> [    1.186668] pci 0000:0c:00.1: reg 0x10: [mem 0xfbcfc000-0xfbcfffff]
> [    1.193184] pci 0000:00:03.0: PCI bridge to [bus 0c]
> [    1.193188] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
> [    1.193191] pci 0000:00:03.0:   bridge window [mem
> 0xf9f00000-0xfbcfffff]
> [    1.193195] pci 0000:00:03.0:   bridge window [mem
> 0xd6000000-0xdfffffff 64bit pref]
> [    1.193226] pci 0000:00:05.0: PCI bridge to [bus 0b]
> [    1.193254] pci 0000:00:06.0: PCI bridge to [bus 0a]
> [    1.193286] pci 0000:09:00.0: [10de:0622] type 00 class 0x030000
> [    1.193294] pci 0000:09:00.0: reg 0x10: [mem 0xf8000000-0xf8ffffff]
> [    1.193300] pci 0000:09:00.0: reg 0x14: [mem 0xc0000000-0xcfffffff
> 64bit pref]
> [    1.193306] pci 0000:09:00.0: reg 0x1c: [mem 0xf6000000-0xf7ffffff
> 64bit]
> [    1.193310] pci 0000:09:00.0: reg 0x24: [io  0xbc00-0xbc7f]
> [    1.193314] pci 0000:09:00.0: reg 0x30: [mem 0xf5f80000-0xf5ffffff pref]
> [    1.199848] pci 0000:00:07.0: PCI bridge to [bus 09]
> [    1.199852] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
> [    1.199854] pci 0000:00:07.0:   bridge window [mem
> 0xf5f00000-0xf8ffffff]
> [    1.199859] pci 0000:00:07.0:   bridge window [mem
> 0xc0000000-0xcfffffff 64bit pref]
> [    1.199892] pci 0000:00:09.0: PCI bridge to [bus 08]
> [    1.199919] pci 0000:00:0a.0: PCI bridge to [bus 07]
> [    1.199962] pci 0000:06:00.0: [10ec:8168] type 00 class 0x020000
> [    1.199978] pci 0000:06:00.0: reg 0x10: [io  0xa800-0xa8ff]
> [    1.200002] pci 0000:06:00.0: reg 0x18: [mem 0xf3fff000-0xf3ffffff
> 64bit pref]
> [    1.200016] pci 0000:06:00.0: reg 0x20: [mem 0xf3ff8000-0xf3ffbfff
> 64bit pref]
> [    1.200026] pci 0000:06:00.0: reg 0x30: [mem 0xf9ee0000-0xf9efffff pref]
> [    1.200094] pci 0000:06:00.0: supports D1 D2
> [    1.200095] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    1.206521] pci 0000:00:1c.0: PCI bridge to [bus 06]
> [    1.206525] pci 0000:00:1c.0:   bridge window [io  0xa000-0xafff]
> [    1.206528] pci 0000:00:1c.0:   bridge window [mem
> 0xf9e00000-0xf9efffff]
> [    1.206533] pci 0000:00:1c.0:   bridge window [mem
> 0xf3f00000-0xf3ffffff 64bit pref]
> [    1.206581] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
> [    1.206597] pci 0000:05:00.0: reg 0x10: [io  0x9800-0x98ff]
> [    1.206620] pci 0000:05:00.0: reg 0x18: [mem 0xf3eff000-0xf3efffff
> 64bit pref]
> [    1.206634] pci 0000:05:00.0: reg 0x20: [mem 0xf3ef8000-0xf3efbfff
> 64bit pref]
> [    1.206644] pci 0000:05:00.0: reg 0x30: [mem 0xf9de0000-0xf9dfffff pref]
> [    1.206712] pci 0000:05:00.0: supports D1 D2
> [    1.206713] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    1.213187] pci 0000:00:1c.1: PCI bridge to [bus 05]
> [    1.213191] pci 0000:00:1c.1:   bridge window [io  0x9000-0x9fff]
> [    1.213194] pci 0000:00:1c.1:   bridge window [mem
> 0xf9d00000-0xf9dfffff]
> [    1.213199] pci 0000:00:1c.1:   bridge window [mem
> 0xf3e00000-0xf3efffff 64bit pref]
> [    1.213248] pci 0000:04:00.0: [1106:3403] type 00 class 0x0c0010
> [    1.213269] pci 0000:04:00.0: reg 0x10: [mem 0xf9cff800-0xf9cfffff
> 64bit]
> [    1.213279] pci 0000:04:00.0: reg 0x18: [io  0x8800-0x88ff]
> [    1.213366] pci 0000:04:00.0: supports D2
> [    1.213367] pci 0000:04:00.0: PME# supported from D2 D3hot D3cold
> [    1.219853] pci 0000:00:1c.2: PCI bridge to [bus 04]
> [    1.219857] pci 0000:00:1c.2:   bridge window [io  0x8000-0x8fff]
> [    1.219860] pci 0000:00:1c.2:   bridge window [mem
> 0xf9c00000-0xf9cfffff]
> [    1.219919] pci 0000:03:00.0: [197b:2362] type 00 class 0x010601
> [    1.219948] pci 0000:03:00.0: reg 0x10: [io  0x7c00-0x7c07]
> [    1.219959] pci 0000:03:00.0: reg 0x14: [io  0x7880-0x7883]
> [    1.219971] pci 0000:03:00.0: reg 0x18: [io  0x7800-0x7807]
> [    1.219982] pci 0000:03:00.0: reg 0x1c: [io  0x7480-0x7483]
> [    1.219993] pci 0000:03:00.0: reg 0x20: [io  0x7400-0x740f]
> [    1.220005] pci 0000:03:00.0: reg 0x24: [mem 0xf9bffc00-0xf9bffdff]
> [    1.220016] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [    1.220066] pci 0000:03:00.0: PME# supported from D3hot
> [    1.226520] pci 0000:00:1c.3: PCI bridge to [bus 03]
> [    1.226524] pci 0000:00:1c.3:   bridge window [io  0x7000-0x7fff]
> [    1.226527] pci 0000:00:1c.3:   bridge window [mem
> 0xf9b00000-0xf9bfffff]
> [    1.226579] pci 0000:02:00.0: [1102:000b] type 00 class 0x040300
> [    1.226603] pci 0000:02:00.0: reg 0x10: [mem 0xf5ef0000-0xf5efffff
> 64bit]
> [    1.226620] pci 0000:02:00.0: reg 0x18: [mem 0xf5c00000-0xf5dfffff
> 64bit]
> [    1.226636] pci 0000:02:00.0: reg 0x20: [mem 0xf4000000-0xf4ffffff
> 64bit]
> [    1.233186] pci 0000:00:1c.4: PCI bridge to [bus 02]
> [    1.233192] pci 0000:00:1c.4:   bridge window [mem
> 0xf4000000-0xf5efffff]
> [    1.233256] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive
> decode)
> [    1.233262] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7
> window] (subtractive decode)
> [    1.233263] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff
> window] (subtractive decode)
> [    1.233264] pci 0000:00:1e.0:   bridge window [mem
> 0x000a0000-0x000bffff window] (subtractive decode)
> [    1.233265] pci 0000:00:1e.0:   bridge window [mem
> 0x000d0000-0x000dffff window] (subtractive decode)
> [    1.233266] pci 0000:00:1e.0:   bridge window [mem
> 0xc0000000-0xdfffffff window] (subtractive decode)
> [    1.233267] pci 0000:00:1e.0:   bridge window [mem
> 0xf0000000-0xfed8ffff window] (subtractive decode)
> [    1.233544] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11 12 14
> *15)
> [    1.233574] ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
> [    1.233601] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12 14
> 15)
> [    1.233629] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 *10 11 12 14
> 15)
> [    1.233657] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14
> 15) *0, disabled.
> [    1.233686] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14
> 15)
> [    1.233713] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 6 7 10 11 12 14
> 15)
> [    1.233741] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 11 12 *14
> 15)
> [    1.233771] ACPI: Enabled 1 GPEs in block 00 to 3F
> [    1.233826] vgaarb: setting as boot device: PCI:0000:0c:00.0
> [    1.233827] vgaarb: device added:
> PCI:0000:0c:00.0,decodes=io+mem,owns=io+mem,locks=none
> [    1.233829] vgaarb: device added:
> PCI:0000:09:00.0,decodes=io+mem,owns=none,locks=none
> [    1.233830] vgaarb: loaded
> [    1.233831] vgaarb: bridge control possible 0000:09:00.0
> [    1.233831] vgaarb: bridge control possible 0000:0c:00.0
> [    1.233876] PCI: Using ACPI for IRQ routing
> [    1.238422] PCI: Discovered peer bus ff
> [    1.238423] PCI: root bus ff: using default resources
> [    1.238423] PCI: Probing PCI hardware (bus ff)
> [    1.238439] ACPI: \: failed to evaluate _DSM (0x1001)
> [    1.238440] PCI host bridge to bus 0000:ff
> [    1.238441] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
> [    1.238442] pci_bus 0000:ff: root bus resource [mem
> 0x00000000-0xffffffffff]
> [    1.238443] pci_bus 0000:ff: No busn resource found for root bus, will
> use [bus ff-ff]
> [    1.238444] pci_bus 0000:ff: busn_res: can not insert [bus ff] under
> domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
> [    1.238447] pci 0000:ff:00.0: [8086:2c70] type 00 class 0x060000
> [    1.238473] pci 0000:ff:00.1: [8086:2d81] type 00 class 0x060000
> [    1.238498] pci 0000:ff:02.0: [8086:2d90] type 00 class 0x060000
> [    1.238521] pci 0000:ff:02.1: [8086:2d91] type 00 class 0x060000
> [    1.238546] pci 0000:ff:02.2: [8086:2d92] type 00 class 0x060000
> [    1.238570] pci 0000:ff:02.3: [8086:2d93] type 00 class 0x060000
> [    1.238593] pci 0000:ff:02.4: [8086:2d94] type 00 class 0x060000
> [    1.238616] pci 0000:ff:02.5: [8086:2d95] type 00 class 0x060000
> [    1.238639] pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000
> [    1.238663] pci 0000:ff:03.1: [8086:2d99] type 00 class 0x060000
> [    1.238686] pci 0000:ff:03.2: [8086:2d9a] type 00 class 0x060000
> [    1.238709] pci 0000:ff:03.4: [8086:2d9c] type 00 class 0x060000
> [    1.238733] pci 0000:ff:04.0: [8086:2da0] type 00 class 0x060000
> [    1.238757] pci 0000:ff:04.1: [8086:2da1] type 00 class 0x060000
> [    1.238780] pci 0000:ff:04.2: [8086:2da2] type 00 class 0x060000
> [    1.238803] pci 0000:ff:04.3: [8086:2da3] type 00 class 0x060000
> [    1.238827] pci 0000:ff:05.0: [8086:2da8] type 00 class 0x060000
> [    1.238851] pci 0000:ff:05.1: [8086:2da9] type 00 class 0x060000
> [    1.238874] pci 0000:ff:05.2: [8086:2daa] type 00 class 0x060000
> [    1.238897] pci 0000:ff:05.3: [8086:2dab] type 00 class 0x060000
> [    1.238923] pci 0000:ff:06.0: [8086:2db0] type 00 class 0x060000
> [    1.238946] pci 0000:ff:06.1: [8086:2db1] type 00 class 0x060000
> [    1.238969] pci 0000:ff:06.2: [8086:2db2] type 00 class 0x060000
> [    1.238992] pci 0000:ff:06.3: [8086:2db3] type 00 class 0x060000
> [    1.239023] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
> [    1.239024] pci_bus 0000:ff: busn_res: can not insert [bus ff] under
> domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
> [    1.239028] PCI: pci_cache_line_size set to 64 bytes
> [    1.239106] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
> [    1.239107] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
> [    1.239172] NetLabel: Initializing
> [    1.239173] NetLabel:  domain hash size = 128
> [    1.239173] NetLabel:  protocols = UNLABELED CIPSOv4
> [    1.239180] NetLabel:  unlabeled traffic allowed by default
> [    1.239213] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [    1.239215] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
> [    1.241237] clocksource: Switched to clocksource hpet
> [    1.244563] VFS: Disk quotas dquot_6.6.0
> [    1.244580] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
> bytes)
> [    1.244637] pnp: PnP ACPI init
> [    1.244678] system 00:00: [mem 0xfbf00000-0xfbffffff] has been reserved
> [    1.244679] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
> [    1.244680] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
> [    1.244681] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
> [    1.244682] system 00:00: [mem 0xfec8a000-0xfec8afff] has been reserved
> [    1.244683] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
> [    1.244686] system 00:00: Plug and Play ACPI device, IDs PNP0c01
> (active)
> [    1.244714] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    1.244798] system 00:02: [io  0x0a00-0x0adf] has been reserved
> [    1.244800] system 00:02: [io  0x0ae0-0x0aef] has been reserved
> [    1.244802] system 00:02: Plug and Play ACPI device, IDs PNP0c02
> (active)
> [    1.244901] system 00:03: [io  0x04d0-0x04d1] has been reserved
> [    1.244902] system 00:03: [io  0x0800-0x087f] could not be reserved
> [    1.244903] system 00:03: [io  0x0500-0x057f] could not be reserved
> [    1.244905] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    1.244906] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    1.244907] system 00:03: [mem 0xfed45000-0xfed89fff] has been reserved
> [    1.244908] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    1.244909] system 00:03: [mem 0xfed40000-0xfed8ffff] could not be
> reserved
> [    1.244911] system 00:03: Plug and Play ACPI device, IDs PNP0c02
> (active)
> [    1.244989] system 00:04: [mem 0xfec00000-0xfec00fff] could not be
> reserved
> [    1.244990] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
> [    1.244992] system 00:04: Plug and Play ACPI device, IDs PNP0c02
> (active)
> [    1.245040] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
> [    1.245042] system 00:05: Plug and Play ACPI device, IDs PNP0c02
> (active)
> [    1.245146] system 00:06: [mem 0x00000000-0x0009ffff] could not be
> reserved
> [    1.245147] system 00:06: [mem 0x000c0000-0x000cffff] could not be
> reserved
> [    1.245149] system 00:06: [mem 0x000e0000-0x000fffff] could not be
> reserved
> [    1.245150] system 00:06: [mem 0x00100000-0xbfffffff] could not be
> reserved
> [    1.245151] system 00:06: [mem 0xfed90000-0xffffffff] could not be
> reserved
> [    1.245153] system 00:06: Plug and Play ACPI device, IDs PNP0c01
> (active)
> [    1.245216] pnp: PnP ACPI: found 7 devices
> [    1.250843] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
> max_idle_ns: 2085701024 ns
> [    1.250887] pci 0000:00:1c.2: bridge window [mem 0x00100000-0x000fffff
> 64bit pref] to [bus 04] add_size 200000 add_align 100000
> [    1.250893] pci 0000:00:1c.3: bridge window [mem 0x00100000-0x000fffff
> 64bit pref] to [bus 03] add_size 200000 add_align 100000
> [    1.250898] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus
> 02] add_size 1000
> [    1.250899] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff
> 64bit pref] to [bus 02] add_size 200000 add_align 100000
> [    1.250908] pci 0000:00:1f.0: BAR 13: [io  size 0x0080] has bogus
> alignment
> [    1.250910] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x000fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
> [    1.250911] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x002fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
> [    1.250912] pci 0000:00:1c.3: res[15]=[mem 0x00100000-0x000fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
> [    1.250913] pci 0000:00:1c.3: res[15]=[mem 0x00100000-0x002fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
> [    1.250914] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x000fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
> [    1.250915] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x002fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
> [    1.250916] pci 0000:00:1c.4: res[13]=[io  0x1000-0x0fff]
> res_to_dev_res add_size 1000 min_align 1000
> [    1.250917] pci 0000:00:1c.4: res[13]=[io  0x1000-0x1fff]
> res_to_dev_res add_size 1000 min_align 1000
> [    1.250921] pci 0000:00:1c.2: BAR 15: assigned [mem
> 0xd0000000-0xd01fffff 64bit pref]
> [    1.250924] pci 0000:00:1c.3: BAR 15: assigned [mem
> 0xd0200000-0xd03fffff 64bit pref]
> [    1.250926] pci 0000:00:1c.4: BAR 15: assigned [mem
> 0xd0400000-0xd05fffff 64bit pref]
> [    1.250927] pci 0000:00:1c.4: BAR 13: assigned [io  0x1000-0x1fff]
> [    1.250929] pci 0000:00:01.0: PCI bridge to [bus 0e]
> [    1.250931] pci 0000:00:01.0:   bridge window [mem
> 0xfbe00000-0xfbefffff]
> [    1.250935] pci 0000:00:02.0: PCI bridge to [bus 0d]
> [    1.250937] pci 0000:00:02.0:   bridge window [io  0xd000-0xefff]
> [    1.250939] pci 0000:00:02.0:   bridge window [mem
> 0xfbd00000-0xfbdfffff]
> [    1.250943] pci 0000:00:03.0: PCI bridge to [bus 0c]
> [    1.250944] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
> [    1.250946] pci 0000:00:03.0:   bridge window [mem
> 0xf9f00000-0xfbcfffff]
> [    1.250948] pci 0000:00:03.0:   bridge window [mem
> 0xd6000000-0xdfffffff 64bit pref]
> [    1.250951] pci 0000:00:05.0: PCI bridge to [bus 0b]
> [    1.250956] pci 0000:00:06.0: PCI bridge to [bus 0a]
> [    1.250962] pci 0000:00:07.0: PCI bridge to [bus 09]
> [    1.250963] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
> [    1.250965] pci 0000:00:07.0:   bridge window [mem
> 0xf5f00000-0xf8ffffff]
> [    1.250967] pci 0000:00:07.0:   bridge window [mem
> 0xc0000000-0xcfffffff 64bit pref]
> [    1.250970] pci 0000:00:09.0: PCI bridge to [bus 08]
> [    1.250975] pci 0000:00:0a.0: PCI bridge to [bus 07]
> [    1.250981] pci 0000:00:1c.0: PCI bridge to [bus 06]
> [    1.250982] pci 0000:00:1c.0:   bridge window [io  0xa000-0xafff]
> [    1.250985] pci 0000:00:1c.0:   bridge window [mem
> 0xf9e00000-0xf9efffff]
> [    1.250987] pci 0000:00:1c.0:   bridge window [mem
> 0xf3f00000-0xf3ffffff 64bit pref]
> [    1.250991] pci 0000:00:1c.1: PCI bridge to [bus 05]
> [    1.250993] pci 0000:00:1c.1:   bridge window [io  0x9000-0x9fff]
> [    1.250995] pci 0000:00:1c.1:   bridge window [mem
> 0xf9d00000-0xf9dfffff]
> [    1.250998] pci 0000:00:1c.1:   bridge window [mem
> 0xf3e00000-0xf3efffff 64bit pref]
> [    1.251001] pci 0000:00:1c.2: PCI bridge to [bus 04]
> [    1.251003] pci 0000:00:1c.2:   bridge window [io  0x8000-0x8fff]
> [    1.251006] pci 0000:00:1c.2:   bridge window [mem
> 0xf9c00000-0xf9cfffff]
> [    1.251008] pci 0000:00:1c.2:   bridge window [mem
> 0xd0000000-0xd01fffff 64bit pref]
> [    1.251012] pci 0000:03:00.0: BAR 6: assigned [mem
> 0xf9b00000-0xf9b0ffff pref]
> [    1.251013] pci 0000:00:1c.3: PCI bridge to [bus 03]
> [    1.251015] pci 0000:00:1c.3:   bridge window [io  0x7000-0x7fff]
> [    1.251018] pci 0000:00:1c.3:   bridge window [mem
> 0xf9b00000-0xf9bfffff]
> [    1.251020] pci 0000:00:1c.3:   bridge window [mem
> 0xd0200000-0xd03fffff 64bit pref]
> [    1.251023] pci 0000:00:1c.4: PCI bridge to [bus 02]
> [    1.251025] pci 0000:00:1c.4:   bridge window [io  0x1000-0x1fff]
> [    1.251028] pci 0000:00:1c.4:   bridge window [mem
> 0xf4000000-0xf5efffff]
> [    1.251030] pci 0000:00:1c.4:   bridge window [mem
> 0xd0400000-0xd05fffff 64bit pref]
> [    1.251034] pci 0000:00:1e.0: PCI bridge to [bus 01]
> [    1.251041] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    1.251042] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    1.251043] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff
> window]
> [    1.251044] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff
> window]
> [    1.251045] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff
> window]
> [    1.251046] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff
> window]
> [    1.251047] pci_bus 0000:0e: resource 1 [mem 0xfbe00000-0xfbefffff]
> [    1.251048] pci_bus 0000:0d: resource 0 [io  0xd000-0xefff]
> [    1.251049] pci_bus 0000:0d: resource 1 [mem 0xfbd00000-0xfbdfffff]
> [    1.251050] pci_bus 0000:0c: resource 0 [io  0xc000-0xcfff]
> [    1.251051] pci_bus 0000:0c: resource 1 [mem 0xf9f00000-0xfbcfffff]
> [    1.251052] pci_bus 0000:0c: resource 2 [mem 0xd6000000-0xdfffffff
> 64bit pref]
> [    1.251053] pci_bus 0000:09: resource 0 [io  0xb000-0xbfff]
> [    1.251054] pci_bus 0000:09: resource 1 [mem 0xf5f00000-0xf8ffffff]
> [    1.251055] pci_bus 0000:09: resource 2 [mem 0xc0000000-0xcfffffff
> 64bit pref]
> [    1.251056] pci_bus 0000:06: resource 0 [io  0xa000-0xafff]
> [    1.251057] pci_bus 0000:06: resource 1 [mem 0xf9e00000-0xf9efffff]
> [    1.251058] pci_bus 0000:06: resource 2 [mem 0xf3f00000-0xf3ffffff
> 64bit pref]
> [    1.251058] pci_bus 0000:05: resource 0 [io  0x9000-0x9fff]
> [    1.251059] pci_bus 0000:05: resource 1 [mem 0xf9d00000-0xf9dfffff]
> [    1.251060] pci_bus 0000:05: resource 2 [mem 0xf3e00000-0xf3efffff
> 64bit pref]
> [    1.251061] pci_bus 0000:04: resource 0 [io  0x8000-0x8fff]
> [    1.251062] pci_bus 0000:04: resource 1 [mem 0xf9c00000-0xf9cfffff]
> [    1.251063] pci_bus 0000:04: resource 2 [mem 0xd0000000-0xd01fffff
> 64bit pref]
> [    1.251064] pci_bus 0000:03: resource 0 [io  0x7000-0x7fff]
> [    1.251065] pci_bus 0000:03: resource 1 [mem 0xf9b00000-0xf9bfffff]
> [    1.251066] pci_bus 0000:03: resource 2 [mem 0xd0200000-0xd03fffff
> 64bit pref]
> [    1.251067] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
> [    1.251068] pci_bus 0000:02: resource 1 [mem 0xf4000000-0xf5efffff]
> [    1.251069] pci_bus 0000:02: resource 2 [mem 0xd0400000-0xd05fffff
> 64bit pref]
> [    1.251070] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7 window]
> [    1.251071] pci_bus 0000:01: resource 5 [io  0x0d00-0xffff window]
> [    1.251072] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff
> window]
> [    1.251073] pci_bus 0000:01: resource 7 [mem 0x000d0000-0x000dffff
> window]
> [    1.251073] pci_bus 0000:01: resource 8 [mem 0xc0000000-0xdfffffff
> window]
> [    1.251074] pci_bus 0000:01: resource 9 [mem 0xf0000000-0xfed8ffff
> window]
> [    1.251077] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
> [    1.251078] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xffffffffff]
> [    1.251094] NET: Registered protocol family 2
> [    1.251222] TCP established hash table entries: 131072 (order: 8,
> 1048576 bytes)
> [    1.251386] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [    1.251483] TCP: Hash tables configured (established 131072 bind 65536)
> [    1.251507] UDP hash table entries: 8192 (order: 6, 262144 bytes)
> [    1.251543] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
> [    1.251605] NET: Registered protocol family 1
> [    1.252637] pci 0000:0c:00.0: Video device with shadowed ROM at [mem
> 0x000c0000-0x000dffff]
> [    1.252672] PCI: CLS 256 bytes, default 64
> [    1.252700] Unpacking initramfs...
> [    1.289259] Freeing initrd memory: 4260K (ffff88003779e000 -
> ffff880037bc7000)
> [    1.289271] DMAR: Host address width 39
> [    1.289272] DMAR: DRHD base: 0x000000fbfff000 flags: 0x0
> [    1.289282] DMAR: dmar0: reg_base_addr fbfff000 ver 1:0 cap
> c9008010e60262 ecap f020f2
> [    1.289283] DMAR: DRHD base: 0x000000fbffe000 flags: 0x1
> [    1.289287] DMAR: dmar1: reg_base_addr fbffe000 ver 1:0 cap
> c9078010ef0462 ecap f020f6
> [    1.289288] DMAR: RMRR base: 0x000000000ec000 end: 0x000000000f3fff
> [    1.289289] DMAR: RMRR base: 0x000000bf7e8000 end: 0x000000bf7fffff
> [    1.289290] DMAR: ATSR flags: 0x0
> [    1.289420] DMAR: dmar0: Using Queued invalidation
> [    1.289427] DMAR: dmar1: Using Queued invalidation
> [    1.289434] DMAR: Recommended TLB entries for ISOCH unit is 16; your
> BIOS set 20
> [    1.289435] DMAR: Setting RMRR:
> [    1.289449] DMAR: Setting identity map for device 0000:00:1a.0
> [0xbf7e8000 - 0xbf7fffff]
> [    1.289468] DMAR: Setting identity map for device 0000:00:1a.1
> [0xbf7e8000 - 0xbf7fffff]
> [    1.289486] DMAR: Setting identity map for device 0000:00:1a.2
> [0xbf7e8000 - 0xbf7fffff]
> [    1.289506] DMAR: Setting identity map for device 0000:00:1a.7
> [0xbf7e8000 - 0xbf7fffff]
> [    1.289524] DMAR: Setting identity map for device 0000:00:1d.0
> [0xbf7e8000 - 0xbf7fffff]
> [    1.289542] DMAR: Setting identity map for device 0000:00:1d.1
> [0xbf7e8000 - 0xbf7fffff]
> [    1.289560] DMAR: Setting identity map for device 0000:00:1d.2
> [0xbf7e8000 - 0xbf7fffff]
> [    1.289578] DMAR: Setting identity map for device 0000:00:1d.7
> [0xbf7e8000 - 0xbf7fffff]
> [    1.289589] DMAR: Setting identity map for device 0000:00:1a.0 [0xec000
> - 0xf3fff]
> [    1.289597] DMAR: Setting identity map for device 0000:00:1a.1 [0xec000
> - 0xf3fff]
> [    1.289605] DMAR: Setting identity map for device 0000:00:1a.2 [0xec000
> - 0xf3fff]
> [    1.289612] DMAR: Setting identity map for device 0000:00:1a.7 [0xec000
> - 0xf3fff]
> [    1.289620] DMAR: Setting identity map for device 0000:00:1d.0 [0xec000
> - 0xf3fff]
> [    1.289628] DMAR: Setting identity map for device 0000:00:1d.1 [0xec000
> - 0xf3fff]
> [    1.289636] DMAR: Setting identity map for device 0000:00:1d.2 [0xec000
> - 0xf3fff]
> [    1.289644] DMAR: Setting identity map for device 0000:00:1d.7 [0xec000
> - 0xf3fff]
> [    1.289652] DMAR: Prepare 0-16MiB unity mapping for LPC
> [    1.289660] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 -
> 0xffffff]
> [    1.289768] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [    1.289808] iommu: Adding device 0000:00:00.0 to group 0
> [    1.289816] iommu: Adding device 0000:00:01.0 to group 1
> [    1.289825] iommu: Adding device 0000:00:02.0 to group 2
> [    1.289833] iommu: Adding device 0000:00:03.0 to group 3
> [    1.289841] iommu: Adding device 0000:00:05.0 to group 4
> [    1.289849] iommu: Adding device 0000:00:06.0 to group 5
> [    1.289858] iommu: Adding device 0000:00:07.0 to group 6
> [    1.289867] iommu: Adding device 0000:00:09.0 to group 7
> [    1.289874] iommu: Adding device 0000:00:0a.0 to group 8
> [    1.289901] iommu: Adding device 0000:00:14.0 to group 9
> [    1.289910] iommu: Adding device 0000:00:14.1 to group 9
> [    1.289919] iommu: Adding device 0000:00:14.2 to group 9
> [    1.289928] iommu: Adding device 0000:00:14.3 to group 9
> [    1.289953] iommu: Adding device 0000:00:1a.0 to group 10
> [    1.289961] iommu: Adding device 0000:00:1a.1 to group 10
> [    1.289969] iommu: Adding device 0000:00:1a.2 to group 10
> [    1.289977] iommu: Adding device 0000:00:1a.7 to group 10
> [    1.289985] iommu: Adding device 0000:00:1b.0 to group 11
> [    1.290021] iommu: Adding device 0000:00:1c.0 to group 12
> [    1.290032] iommu: Adding device 0000:00:1c.1 to group 12
> [    1.290043] iommu: Adding device 0000:00:1c.2 to group 12
> [    1.290054] iommu: Adding device 0000:00:1c.3 to group 12
> [    1.290065] iommu: Adding device 0000:00:1c.4 to group 12
> [    1.290090] iommu: Adding device 0000:00:1d.0 to group 13
> [    1.290099] iommu: Adding device 0000:00:1d.1 to group 13
> [    1.290107] iommu: Adding device 0000:00:1d.2 to group 13
> [    1.290116] iommu: Adding device 0000:00:1d.7 to group 13
> [    1.290125] iommu: Adding device 0000:00:1e.0 to group 14
> [    1.290145] iommu: Adding device 0000:00:1f.0 to group 15
> [    1.290155] iommu: Adding device 0000:00:1f.2 to group 15
> [    1.290164] iommu: Adding device 0000:00:1f.3 to group 15
> [    1.290173] iommu: Adding device 0000:0e:00.0 to group 16
> [    1.290184] iommu: Adding device 0000:0d:00.0 to group 17
> [    1.290205] iommu: Adding device 0000:0c:00.0 to group 18
> [    1.290218] iommu: Adding device 0000:0c:00.1 to group 18
> [    1.290228] iommu: Adding device 0000:09:00.0 to group 19
> [    1.290232] iommu: Adding device 0000:06:00.0 to group 12
> [    1.290236] iommu: Adding device 0000:05:00.0 to group 12
> [    1.290240] iommu: Adding device 0000:04:00.0 to group 12
> [    1.290244] iommu: Adding device 0000:03:00.0 to group 12
> [    1.290248] iommu: Adding device 0000:02:00.0 to group 12
> [    1.290265] iommu: Adding device 0000:ff:00.0 to group 20
> [    1.290275] iommu: Adding device 0000:ff:00.1 to group 20
> [    1.290308] iommu: Adding device 0000:ff:02.0 to group 21
> [    1.290318] iommu: Adding device 0000:ff:02.1 to group 21
> [    1.290328] iommu: Adding device 0000:ff:02.2 to group 21
> [    1.290337] iommu: Adding device 0000:ff:02.3 to group 21
> [    1.290347] iommu: Adding device 0000:ff:02.4 to group 21
> [    1.290357] iommu: Adding device 0000:ff:02.5 to group 21
> [    1.290382] iommu: Adding device 0000:ff:03.0 to group 22
> [    1.290392] iommu: Adding device 0000:ff:03.1 to group 22
> [    1.290402] iommu: Adding device 0000:ff:03.2 to group 22
> [    1.290413] iommu: Adding device 0000:ff:03.4 to group 22
> [    1.290437] iommu: Adding device 0000:ff:04.0 to group 23
> [    1.290448] iommu: Adding device 0000:ff:04.1 to group 23
> [    1.290458] iommu: Adding device 0000:ff:04.2 to group 23
> [    1.290469] iommu: Adding device 0000:ff:04.3 to group 23
> [    1.290494] iommu: Adding device 0000:ff:05.0 to group 24
> [    1.290505] iommu: Adding device 0000:ff:05.1 to group 24
> [    1.290515] iommu: Adding device 0000:ff:05.2 to group 24
> [    1.290526] iommu: Adding device 0000:ff:05.3 to group 24
> [    1.290550] iommu: Adding device 0000:ff:06.0 to group 25
> [    1.290561] iommu: Adding device 0000:ff:06.1 to group 25
> [    1.290572] iommu: Adding device 0000:ff:06.2 to group 25
> [    1.290585] iommu: Adding device 0000:ff:06.3 to group 25
> [    1.291620] Scanning for low memory corruption every 60 seconds
> [    1.291846] futex hash table entries: 4096 (order: 6, 262144 bytes)
> [    1.292086] Initialise system trusted keyring
> [    1.292188] workingset: timestamp_bits=38 max_order=22 bucket_order=0
> [    1.293112] zbud: loaded
> [    1.293257] Key type big_key registered
> [    1.293467] Block layer SCSI generic (bsg) driver version 0.4 loaded
> (major 249)
> [    1.293501] io scheduler noop registered
> [    1.293503] io scheduler deadline registered
> [    1.293522] io scheduler cfq registered (default)
> [    1.294187] pcieport 0000:00:1c.4: enabling device (0106 -> 0107)
> [    1.294298] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    1.294303] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    1.294313] vesafb: mode is 1280x1024x32, linelength=5120, pages=0
> [    1.294313] vesafb: scrolling: redraw
> [    1.294315] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    1.294325] vesafb: framebuffer at 0xd7000000, mapped to
> 0xffffc90002000000, using 5120k, total 5120k
> [    1.431634] Console: switching to colour frame buffer device 160x64
> [    1.568738] fb0: VESA VGA frame buffer device
> [    1.568751] intel_idle: MWAIT substates: 0x1120
> [    1.568752] intel_idle: v0.4.1 model 0x2C
> [    1.568968] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    1.569119] GHES: HEST is not enabled!
> [    1.569162] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    1.569407] Linux agpgart interface v0.103
> [    1.569925] rtc_cmos 00:01: RTC can wake from S4
> [    1.570012] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
> [    1.570031] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes
> nvram, hpet irqs
> [    1.570040] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.570284] NET: Registered protocol family 10
> [    1.570432] NET: Registered protocol family 17
> [    1.570687] microcode: CPU0 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570729] microcode: CPU1 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570735] microcode: CPU2 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570758] microcode: CPU3 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570800] microcode: CPU4 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570845] microcode: CPU5 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570877] microcode: CPU6 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570909] microcode: CPU7 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570911] microcode: CPU8 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570937] microcode: CPU9 sig=0x206c2, pf=0x1, revision=0x13
> [    1.570980] microcode: CPU10 sig=0x206c2, pf=0x1, revision=0x13
> [    1.571013] microcode: CPU11 sig=0x206c2, pf=0x1, revision=0x13
> [    1.571065] microcode: Microcode Update Driver: v2.01 <
> tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
> [    1.571182] registered taskstats version 1
> [    1.571189] Loading compiled-in X.509 certificates
> [    1.571203] zswap: loaded using pool lzo/zbud
> [    1.571782]   Magic number: 12:303:328
> [    1.572148] rtc_cmos 00:01: setting system clock to 2016-04-25 11:20:20
> UTC (1461583220)
> [    1.572176] PM: Hibernation image not present or could not be loaded.
> [    1.573427] Freeing unused kernel memory: 1224K (ffffffff818f5000 -
> ffffffff81a27000)
> [    1.573428] Write protecting the kernel read-only data: 8192k
> [    1.574235] Freeing unused kernel memory: 200K (ffff8800015ce000 -
> ffff880001600000)
> [    1.575136] Freeing unused kernel memory: 248K (ffff8800017c2000 -
> ffff880001800000)
> [    1.579510] random: systemd-tmpfile urandom read with 1 bits of entropy
> available
> [    1.599421] i8042: PNP: No PS/2 controller found. Probing ports
> directly.
> [    1.599752] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.599774] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    1.603040] ACPI: bus type USB registered
> [    1.603061] usbcore: registered new interface driver usbfs
> [    1.603070] usbcore: registered new interface driver hub
> [    1.603071] SCSI subsystem initialized
> [    1.603109] usbcore: registered new device driver usb
> [    1.603545] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.604018] ehci-pci: EHCI PCI platform driver
> [    1.604171] ehci-pci 0000:00:1a.7: EHCI Host Controller
> [    1.604175] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus
> number 1
> [    1.604188] ehci-pci 0000:00:1a.7: debug port 1
> [    1.604283] uhci_hcd: USB Universal Host Controller Interface driver
> [    1.605330] libata version 3.00 loaded.
> [    1.608100] ehci-pci 0000:00:1a.7: cache line size of 256 is not
> supported
> [    1.608104] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9af8000
> [    1.617951] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
> [    1.618056] hub 1-0:1.0: USB hub found
> [    1.618061] hub 1-0:1.0: 6 ports detected
> [    1.618162] xhci_hcd 0000:0e:00.0: xHCI Host Controller
> [    1.618168] xhci_hcd 0000:0e:00.0: new USB bus registered, assigned bus
> number 2
> [    1.618304] xhci_hcd 0000:0e:00.0: hcc params 0x014042cb hci version
> 0x96 quirks 0x00000004
> [    1.618533] hub 2-0:1.0: USB hub found
> [    1.618538] hub 2-0:1.0: 2 ports detected
> [    1.618593] xhci_hcd 0000:0e:00.0: xHCI Host Controller
> [    1.618596] xhci_hcd 0000:0e:00.0: new USB bus registered, assigned bus
> number 3
> [    1.618606] ehci-pci 0000:00:1d.7: EHCI Host Controller
> [    1.618611] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus
> number 4
> [    1.618620] ehci-pci 0000:00:1d.7: debug port 1
> [    1.621645] usb usb3: We don't know the algorithms for LPM for this
> host, disabling LPM.
> [    1.621735] hub 3-0:1.0: USB hub found
> [    1.621745] hub 3-0:1.0: 2 ports detected
> [    1.622536] ehci-pci 0000:00:1d.7: cache line size of 256 is not
> supported
> [    1.622544] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9afa000
> [    1.634695] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> [    1.634805] hub 4-0:1.0: USB hub found
> [    1.634809] hub 4-0:1.0: 6 ports detected
> [    1.635019] uhci_hcd 0000:00:1a.0: UHCI Host Controller
> [    1.635024] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus
> number 5
> [    1.635029] uhci_hcd 0000:00:1a.0: detected 2 ports
> [    1.635048] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00005400
> [    1.635164] hub 5-0:1.0: USB hub found
> [    1.635170] hub 5-0:1.0: 2 ports detected
> [    1.635325] uhci_hcd 0000:00:1a.1: UHCI Host Controller
> [    1.635329] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus
> number 6
> [    1.635334] uhci_hcd 0000:00:1a.1: detected 2 ports
> [    1.635352] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00005480
> [    1.635464] hub 6-0:1.0: USB hub found
> [    1.635470] hub 6-0:1.0: 2 ports detected
> [    1.635601] uhci_hcd 0000:00:1a.2: UHCI Host Controller
> [    1.635606] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus
> number 7
> [    1.635610] uhci_hcd 0000:00:1a.2: detected 2 ports
> [    1.635628] uhci_hcd 0000:00:1a.2: irq 19, io base 0x00005800
> [    1.635739] hub 7-0:1.0: USB hub found
> [    1.635745] hub 7-0:1.0: 2 ports detected
> [    1.635863] uhci_hcd 0000:00:1d.0: UHCI Host Controller
> [    1.635867] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus
> number 8
> [    1.635871] uhci_hcd 0000:00:1d.0: detected 2 ports
> [    1.635885] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00005880
> [    1.636012] hub 8-0:1.0: USB hub found
> [    1.636017] hub 8-0:1.0: 2 ports detected
> [    1.636135] uhci_hcd 0000:00:1d.1: UHCI Host Controller
> [    1.636139] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus
> number 9
> [    1.636143] uhci_hcd 0000:00:1d.1: detected 2 ports
> [    1.636158] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00005c00
> [    1.636297] hub 9-0:1.0: USB hub found
> [    1.636302] hub 9-0:1.0: 2 ports detected
> [    1.636422] uhci_hcd 0000:00:1d.2: UHCI Host Controller
> [    1.636425] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus
> number 10
> [    1.636429] uhci_hcd 0000:00:1d.2: detected 2 ports
> [    1.636445] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00006000
> [    1.636603] hub 10-0:1.0: USB hub found
> [    1.636609] hub 10-0:1.0: 2 ports detected
> [    1.636670] ahci 0000:00:1f.2: version 3.0
> [    1.636792] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
> [    1.636829] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps
> 0x3f impl SATA mode
> [    1.636831] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo
> pio slum part ccc ems sxs
> [    1.658051] firewire_ohci 0000:04:00.0: added OHCI v1.10 device as card
> 0, 4 IR + 8 IT contexts, quirks 0x10
> [    1.668325] scsi host0: ahci
> [    1.668501] scsi host1: ahci
> [    1.668706] scsi host2: ahci
> [    1.668828] scsi host3: ahci
> [    1.668972] scsi host4: ahci
> [    1.669119] scsi host5: ahci
> [    1.669155] ata1: SATA max UDMA/133 abar m2048@0xf9afc000 port
> 0xf9afc100 irq 39
> [    1.669156] ata2: SATA max UDMA/133 abar m2048@0xf9afc000 port
> 0xf9afc180 irq 39
> [    1.669158] ata3: SATA max UDMA/133 abar m2048@0xf9afc000 port
> 0xf9afc200 irq 39
> [    1.669159] ata4: SATA max UDMA/133 abar m2048@0xf9afc000 port
> 0xf9afc280 irq 39
> [    1.669160] ata5: SATA max UDMA/133 abar m2048@0xf9afc000 port
> 0xf9afc300 irq 39
> [    1.669161] ata6: SATA max UDMA/133 abar m2048@0xf9afc000 port
> 0xf9afc380 irq 39
> [    1.669198] ahci 0000:0d:00.0: controller can do FBS, turning on CAP_FBS
> [    1.679340] ahci 0000:0d:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps
> 0xff impl SATA mode
> [    1.679342] ahci 0000:0d:00.0: flags: 64bit ncq fbs pio
> [    1.679933] scsi host6: ahci
> [    1.680082] scsi host7: ahci
> [    1.680264] scsi host8: ahci
> [    1.680367] scsi host9: ahci
> [    1.680484] scsi host10: ahci
> [    1.680623] scsi host11: ahci
> [    1.680719] scsi host12: ahci
> [    1.680824] scsi host13: ahci
> [    1.680859] ata7: SATA max UDMA/133 abar m2048@0xfbddf800 port
> 0xfbddf900 irq 40
> [    1.680861] ata8: SATA max UDMA/133 abar m2048@0xfbddf800 port
> 0xfbddf980 irq 40
> [    1.680862] ata9: SATA max UDMA/133 abar m2048@0xfbddf800 port
> 0xfbddfa00 irq 40
> [    1.680863] ata10: SATA max UDMA/133 abar m2048@0xfbddf800 port
> 0xfbddfa80 irq 40
> [    1.680864] ata11: SATA max UDMA/133 abar m2048@0xfbddf800 port
> 0xfbddfb00 irq 40
> [    1.680866] ata12: SATA max UDMA/133 abar m2048@0xfbddf800 port
> 0xfbddfb80 irq 40
> [    1.680867] ata13: SATA max UDMA/133 abar m2048@0xfbddf800 port
> 0xfbddfc00 irq 40
> [    1.680868] ata14: SATA max UDMA/133 abar m2048@0xfbddf800 port
> 0xfbddfc80 irq 40
> [    1.680959] ahci 0000:03:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps
> 0x3 impl SATA mode
> [    1.680960] ahci 0000:03:00.0: flags: 64bit ncq led clo pmp pio
> [    1.681169] scsi host14: ahci
> [    1.681241] scsi host15: ahci
> [    1.681282] ata15: SATA max UDMA/133 abar m512@0xf9bffc00 port
> 0xf9bffd00 irq 19
> [    1.681285] ata16: SATA max UDMA/133 abar m512@0xf9bffc00 port
> 0xf9bffd80 irq 19
> [    1.978532] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.979732] ata1.00: ATA-8: ST31000524AS, JC45, max UDMA/133
> [    1.979735] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth
> 31/32)
> [    1.981148] ata1.00: configured for UDMA/133
> [    1.981411] scsi 0:0:0:0: Direct-Access     ATA      ST31000524AS
> JC45 PQ: 0 ANSI: 5
> [    1.991794] ata11: SATA link down (SStatus 0 SControl 300)
> [    1.991813] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.991830] ata9: SATA link down (SStatus 0 SControl 300)
> [    1.991847] ata12: SATA link down (SStatus 0 SControl 300)
> [    1.991871] ata10: SATA link down (SStatus 0 SControl 300)
> [    1.991881] ata16: SATA link down (SStatus 0 SControl 300)
> [    1.992108] ata15: SATA link down (SStatus 0 SControl 300)
> [    1.992122] ata13: SATA link down (SStatus 0 SControl 300)
> [    1.992140] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    2.100542] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
> [    2.100754] ata14.00: configured for UDMA/66
> [    2.102002] ata8.00: ATA-9: INTEL SSDSC2BW180A3H, LCSi, max UDMA/133
> [    2.102005] ata8.00: 351651888 sectors, multi 16: LBA48 NCQ (depth
> 31/32), AA
> [    2.111976] ata8.00: configured for UDMA/133
> [    2.121333] usb 8-1: new full-speed USB device number 2 using uhci_hcd
> [    2.151338] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    2.158321] firewire_core 0000:04:00.0: created device fw0: GUID
> 0010dc0001c88900, S400
> [    2.162537] ata7.00: ATA-9: INTEL SSDSC2CT180A3, 300i, max UDMA/133
> [    2.162540] ata7.00: 351651888 sectors, multi 16: LBA48 NCQ (depth
> 31/32), AA
> [    2.172515] ata7.00: configured for UDMA/133
> [    2.197996] usb 4-4: new high-speed USB device number 3 using ehci-pci
> [    2.297979] tsc: Refined TSC clocksource calibration: 4399.972 MHz
> [    2.297983] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
> 0x3f6c4aff662, max_idle_ns: 440795220849 ns
> [    2.318379] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.319174] ata2.00: ATA-9: ST1000DM003-1CH162, CC47, max UDMA/133
> [    2.319176] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth
> 31/32), AA
> [    2.320042] ata2.00: configured for UDMA/133
> [    2.320416] scsi 1:0:0:0: Direct-Access     ATA      ST1000DM003-1CH1
> CC47 PQ: 0 ANSI: 5
> [    2.325174] usb-storage 4-4:1.0: USB Mass Storage device detected
> [    2.325337] scsi host16: usb-storage 4-4:1.0
> [    2.325376] usbcore: registered new interface driver usb-storage
> [    2.325749] usbcore: registered new interface driver uas
> [    2.608015] usb 10-1: new full-speed USB device number 2 using uhci_hcd
> [    2.665289] ata3: SATA link down (SStatus 0 SControl 300)
> [    2.788083] hidraw: raw HID events driver (C) Jiri Kosina
> [    2.794165] usbcore: registered new interface driver usbhid
> [    2.794167] usbhid: USB HID core driver
> [    2.796080] input: DEXIN Corp. Tt eSPORTS BLACK Element as
> /devices/pci0000:00/0000:00:1d.2/usb10/10-1/10-1:1.0/0003:12CF:0182.0001/input/input2
> [    2.796140] hid-generic 0003:12CF:0182.0001: input,hidraw0: USB HID
> v1.11 Mouse [DEXIN Corp. Tt eSPORTS BLACK Element] on
> usb-0000:00:1d.2-1/input0
> [    2.796269] input: DEXIN Corp. Tt eSPORTS BLACK Element as
> /devices/pci0000:00/0000:00:1d.2/usb10/10-1/10-1:1.1/0003:12CF:0182.0002/input/input3
> [    2.848034] hid-generic 0003:12CF:0182.0002: input,hidraw1: USB HID
> v1.11 Keyboard [DEXIN Corp. Tt eSPORTS BLACK Element] on
> usb-0000:00:1d.2-1/input1
> [    2.975134] ata4: SATA link down (SStatus 0 SControl 300)
> [    3.214692] usb 10-2: new low-speed USB device number 3 using uhci_hcd
> [    3.285142] ata5: SATA link down (SStatus 0 SControl 300)
> [    3.294919] clocksource: Switched to clocksource tsc
> [    3.333614] scsi 16:0:0:0: Direct-Access     WD       Ext HDD 1021
> 2002 PQ: 0 ANSI: 4
> [    3.335607] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks:
> (1.00 TB/932 GiB)
> [    3.335631] sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks:
> (1.00 TB/932 GiB)
> [    3.335632] sd 1:0:0:0: [sdb] 4096-byte physical blocks
> [    3.335675] sd 0:0:0:0: [sda] Write Protect is off
> [    3.335677] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    3.335694] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    3.335712] sd 1:0:0:0: [sdb] Write Protect is off
> [    3.335714] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    3.335729] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    3.336265] sd 16:0:0:0: [sdc] 1953519616 512-byte logical blocks:
> (1.00 TB/932 GiB)
> [    3.337291] sd 16:0:0:0: [sdc] Test WP failed, assume Write Enabled
> [    3.338337] sd 16:0:0:0: [sdc] Asking for cache data failed
> [    3.339198] sd 16:0:0:0: [sdc] Assuming drive cache: write through
> [    3.351235]  sda: sda1 sda2
> [    3.351591] sd 0:0:0:0: [sda] Attached SCSI disk
> [    3.353383]  sdb: sdb2
> [    3.353844] sd 1:0:0:0: [sdb] Attached SCSI disk
> [    3.595059] ata6: SATA link down (SStatus 0 SControl 300)
> [    3.595498] scsi 6:0:0:0: Direct-Access     ATA      INTEL SSDSC2CT18
> 300i PQ: 0 ANSI: 5
> [    3.628268] sd 6:0:0:0: [sdd] 351651888 512-byte logical blocks: (180
> GB/168 GiB)
> [    3.628445] scsi 7:0:0:0: Direct-Access     ATA      INTEL SSDSC2BW18
> LCSi PQ: 0 ANSI: 5
> [    3.628565] sd 6:0:0:0: [sdd] Write Protect is off
> [    3.628569] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [    3.628650] sd 6:0:0:0: [sdd] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    3.630443]  sdd: sdd1 sdd2
> [    3.630815] sd 6:0:0:0: [sdd] Attached SCSI disk
> [    3.633258] input: HID 04d9:1203 as
> /devices/pci0000:00/0000:00:1d.2/usb10/10-2/10-2:1.0/0003:04D9:1203.0003/input/input4
> [    3.654811] sd 7:0:0:0: [sde] 351651888 512-byte logical blocks: (180
> GB/168 GiB)
> [    3.654932] sd 7:0:0:0: [sde] Write Protect is off
> [    3.654934] sd 7:0:0:0: [sde] Mode Sense: 00 3a 00 00
> [    3.654954] scsi 13:0:0:0: Processor         Marvell  91xx Config
>  1.01 PQ: 0 ANSI: 5
> [    3.654978] sd 7:0:0:0: [sde] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    3.656572]  sde: sde1
> [    3.656783] sd 7:0:0:0: [sde] Attached SCSI disk
> [    3.684842] hid-generic 0003:04D9:1203.0003: input,hidraw2: USB HID
> v1.11 Keyboard [HID 04d9:1203] on usb-0000:00:1d.2-2/input0
> [    3.741441] input: HID 04d9:1203 as
> /devices/pci0000:00/0000:00:1d.2/usb10/10-2/10-2:1.1/0003:04D9:1203.0004/input/input5
> [    3.758750]  sdc: sdc1
> [    3.762344] sd 16:0:0:0: [sdc] Attached SCSI disk
> [    3.798096] hid-generic 0003:04D9:1203.0004: input,hidraw3: USB HID
> v1.11 Device [HID 04d9:1203] on usb-0000:00:1d.2-2/input1
> [    4.247409] EXT4-fs (sdd1): mounted filesystem with ordered data mode.
> Opts: (null)
> [    4.731108] ip_tables: (C) 2000-2006 Netfilter Core Team
> [    4.752924] systemd[1]: systemd 229 running in system mode. (+PAM
> -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP
> +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
> [    4.753057] systemd[1]: Detected architecture x86-64.
> [    4.754040] systemd[1]: Set hostname to <ScaRage>.
> [    5.298401] systemd[1]: Started Forward Password Requests to Wall
> Directory Watch.
> [    5.301761] systemd[1]: Listening on udev Control Socket.
> [    5.301773] systemd[1]: Reached target Encrypted Volumes.
> [    5.301783] systemd[1]: Reached target Login Prompts.
> [    5.301805] systemd[1]: Listening on LVM2 metadata daemon socket.
> [    5.301816] systemd[1]: Listening on udev Kernel Socket.
> [    5.301837] systemd[1]: Listening on Journal Socket.
> [    5.301846] systemd[1]: Reached target Remote File Systems.
> [    5.301859] systemd[1]: Listening on Journal Socket (/dev/log).
> [    5.302331] systemd[1]: Listening on Process Core Dump Socket.
> [    5.302494] systemd[1]: Created slice User and Session Slice.
> [    5.302513] systemd[1]: Listening on Device-mapper event daemon FIF
>
> On Mon, Apr 25, 2016 at 3:01 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>
>> On Mon, Apr 25, 2016 at 07:19:52AM +0400, Dheeraj CVR wrote:
>> > I have tried to grab details about the kernel panic stack trace to make
>> it
>> > easier for Joerg to identify and fix the issue. I have downloaded the
>> latest
>> > Kubuntu Live ISO image which is based on kernel 4.2.0. I have changed
>> the boot
>> > parameters to boot with intel_iommu=on. I was able to capture the
>> kernel panic
>> > with slow motion video recording. The hard lockup appears to occur when
>> calling
>> > "flush_context".
>>
>> Can you please send me the dmesg output of a kernel that works right
>> after boot?
>>
>>
>> Thanks,
>>
>>         Joerg
>>
>>
>
>
> --
> Regards,
> Dheeraj CVR.
>



-- 
Regards,
Dheeraj CVR.

--047d7b10d1abec28fa05319ef53d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0<span style=3D"font-size:12.8px">Joerg,</span><div=
><span style=3D"font-size:12.8px"><br></span></div><div><span style=3D"font=
-size:12.8px">Did you find time to have a look at the dmesg that I have sen=
t to you in the earlier email? Please let me know if you need any more debu=
gging info to diagnose this issue.</span></div></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Apr 25, 2016 at 3:31 PM, Dheera=
j CVR <span dir=3D"ltr">&lt;<a href=3D"mailto:cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"ltr">The dmesg below is with kernel 4.6.0-rc4 bu=
ilt from mainline source with &quot;iommu/vt-d: Make root entry visible for=
 hardware right after allocation&quot; reverted. Please let me know if you =
need a dmesg with 4.1 kernel too.<div><br></div><div><div>[ =C2=A0 =C2=A00.=
000000] Linux version 4.6.0-rc4-3697330 (dhiru1602@ScaRage) (gcc version 5.=
3.0 (GCC) ) #1 SMP PREEMPT Mon Apr 25 15:11:55 GST 2016</div><div>[ =C2=A0 =
=C2=A00.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-linux-git root=3DU=
UID=3D80dfd13f-1755-4c83-b110-84282a777964 rw intel_iommu=3Don quiet</div><=
div>[ =C2=A0 =C2=A00.000000] x86/fpu: Legacy x87 FPU detected.</div><div>[ =
=C2=A0 =C2=A00.000000] x86/fpu: Using &#39;eager&#39; FPU context switches.=
</div><div>[ =C2=A0 =C2=A00.000000] e820: BIOS-provided physical RAM map:</=
div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x0000000000000000-0x0000=
00000009cfff] usable</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x0=
00000000009d000-0x000000000009ffff] reserved</div><div>[ =C2=A0 =C2=A00.000=
000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved</div><=
div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b=
f77ffff] usable</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x000000=
00bf780000-0x00000000bf78dfff] ACPI data</div><div>[ =C2=A0 =C2=A00.000000]=
 BIOS-e820: [mem 0x00000000bf78e000-0x00000000bf7cffff] ACPI NVS</div><div>=
[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000bf7d0000-0x00000000bf7df=
fff] reserved</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000=
bf7e8000-0x00000000bfffffff] reserved</div><div>[ =C2=A0 =C2=A00.000000] BI=
OS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved</div><div>[ =
=C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000fffffff=
f] reserved</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x0000000100=
000000-0x000000043fffffff] usable</div><div>[ =C2=A0 =C2=A00.000000] NX (Ex=
ecute Disable) protection: active</div><div>[ =C2=A0 =C2=A00.000000] SMBIOS=
 2.6 present.</div><div>[ =C2=A0 =C2=A00.000000] DMI: MSI MS-7666/Big Bang-=
XPower (MS-7666), BIOS V1.7 07/27/2012</div><div>[ =C2=A0 =C2=A00.000000] e=
820: update [mem 0x00000000-0x00000fff] usable =3D=3D&gt; reserved</div><di=
v>[ =C2=A0 =C2=A00.000000] e820: remove [mem 0x000a0000-0x000fffff] usable<=
/div><div>[ =C2=A0 =C2=A00.000000] e820: last_pfn =3D 0x440000 max_arch_pfn=
 =3D 0x400000000</div><div>[ =C2=A0 =C2=A00.000000] MTRR default type: unca=
chable</div><div>[ =C2=A0 =C2=A00.000000] MTRR fixed ranges enabled:</div><=
div>[ =C2=A0 =C2=A00.000000] =C2=A0 00000-9FFFF write-back</div><div>[ =C2=
=A0 =C2=A00.000000] =C2=A0 A0000-BFFFF uncachable</div><div>[ =C2=A0 =C2=A0=
0.000000] =C2=A0 C0000-D3FFF write-protect</div><div>[ =C2=A0 =C2=A00.00000=
0] =C2=A0 D4000-DFFFF uncachable</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 =
E0000-E3FFF write-protect</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 E4000-E=
FFFF write-through</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 F0000-FFFFF wr=
ite-protect</div><div>[ =C2=A0 =C2=A00.000000] MTRR variable ranges enabled=
:</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 0 base 0000000000 mask FC000000=
00 write-back</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 1 base 0400000000 m=
ask FFC0000000 write-back</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 2 base =
00C0000000 mask FFC0000000 uncachable</div><div>[ =C2=A0 =C2=A00.000000] =
=C2=A0 3 base 00BF800000 mask FFFF800000 uncachable</div><div>[ =C2=A0 =C2=
=A00.000000] =C2=A0 4 disabled</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 5 =
disabled</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 6 disabled</div><div>[ =
=C2=A0 =C2=A00.000000] =C2=A0 7 disabled</div><div>[ =C2=A0 =C2=A00.000000]=
 =C2=A0 8 disabled</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 9 disabled</di=
v><div>[ =C2=A0 =C2=A00.000000] x86/PAT: Configuration [0-7]: WB =C2=A0WC =
=C2=A0UC- UC =C2=A0WB =C2=A0WC =C2=A0UC- WT =C2=A0</div><div>[ =C2=A0 =C2=
=A00.000000] e820: update [mem 0xbf800000-0xffffffff] usable =3D=3D&gt; res=
erved</div><div>[ =C2=A0 =C2=A00.000000] e820: last_pfn =3D 0xbf780 max_arc=
h_pfn =3D 0x400000000</div><div>[ =C2=A0 =C2=A00.000000] found SMP MP-table=
 at [mem 0x000ff780-0x000ff78f] mapped at [ffff8800000ff780]</div><div>[ =
=C2=A0 =C2=A00.000000] Scanning 1 areas for low memory corruption</div><div=
>[ =C2=A0 =C2=A00.000000] Base memory trampoline at [ffff880000097000] 9700=
0 size 24576</div><div>[ =C2=A0 =C2=A00.000000] Using GB pages for direct m=
apping</div><div>[ =C2=A0 =C2=A00.000000] BRK [0x01b4f000, 0x01b4ffff] PGTA=
BLE</div><div>[ =C2=A0 =C2=A00.000000] BRK [0x01b50000, 0x01b50fff] PGTABLE=
</div><div>[ =C2=A0 =C2=A00.000000] BRK [0x01b51000, 0x01b51fff] PGTABLE</d=
iv><div>[ =C2=A0 =C2=A00.000000] RAMDISK: [mem 0x3779e000-0x37bc6fff]</div>=
<div>[ =C2=A0 =C2=A00.000000] ACPI: Early table checksum verification disab=
led</div><div>[ =C2=A0 =C2=A00.000000] ACPI: RSDP 0x00000000000FA5A0 000014=
 (v00 ACPIAM)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: RSDT 0x00000000BF780=
000 000040 (v01 7666MS A7666100 20120727 MSFT 00000097)</div><div>[ =C2=A0 =
=C2=A00.000000] ACPI: FACP 0x00000000BF780200 000084 (v01 7666MS A7666100 2=
0120727 MSFT 00000097)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: DSDT 0x0000=
0000BF780600 006CF8 (v01 A7666 =C2=A0A7666100 00000100 INTL 20051117)</div>=
<div>[ =C2=A0 =C2=A00.000000] ACPI: FACS 0x00000000BF78E000 000040</div><di=
v>[ =C2=A0 =C2=A00.000000] ACPI: APIC 0x00000000BF780390 0000AC (v01 7666MS=
 A7666100 20120727 MSFT 00000097)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: =
MCFG 0x00000000BF780440 00003C (v01 7666MS OEMMCFG =C2=A020120727 MSFT 0000=
0097)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: OEMB 0x00000000BF78E040 0000=
82 (v01 7666MS A7666100 20120727 MSFT 00000097)</div><div>[ =C2=A0 =C2=A00.=
000000] ACPI: DMAR 0x00000000BF78E0D0 000150 (v01 AMI =C2=A0 =C2=A0OEMDMAR =
=C2=A000000001 MSFT 00000097)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: HPET=
 0x00000000BF78A600 000038 (v01 7666MS OEMHPET =C2=A020120727 MSFT 00000097=
)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: SSDT 0x00000000BF790F40 000363 (=
v01 DpgPmm CpuPm =C2=A0 =C2=A000000012 INTL 20051117)</div><div>[ =C2=A0 =
=C2=A00.000000] ACPI: Local APIC address 0xfee00000</div><div>[ =C2=A0 =C2=
=A00.000000] No NUMA configuration found</div><div>[ =C2=A0 =C2=A00.000000]=
 Faking a node at [mem 0x0000000000000000-0x000000043fffffff]</div><div>[ =
=C2=A0 =C2=A00.000000] NODE_DATA(0) allocated [mem 0x43fffa000-0x43fffdfff]=
</div><div>[ =C2=A0 =C2=A00.000000] Zone ranges:</div><div>[ =C2=A0 =C2=A00=
.000000] =C2=A0 DMA =C2=A0 =C2=A0 =C2=A0[mem 0x0000000000001000-0x000000000=
0ffffff]</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA32 =C2=A0 =C2=A0[mem =
0x0000000001000000-0x00000000ffffffff]</div><div>[ =C2=A0 =C2=A00.000000] =
=C2=A0 Normal =C2=A0 [mem 0x0000000100000000-0x000000043fffffff]</div><div>=
[ =C2=A0 =C2=A00.000000] Movable zone start for each node</div><div>[ =C2=
=A0 =C2=A00.000000] Early memory node ranges</div><div>[ =C2=A0 =C2=A00.000=
000] =C2=A0 node =C2=A0 0: [mem 0x0000000000001000-0x000000000009cfff]</div=
><div>[ =C2=A0 =C2=A00.000000] =C2=A0 node =C2=A0 0: [mem 0x000000000010000=
0-0x00000000bf77ffff]</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 node =C2=A0=
 0: [mem 0x0000000100000000-0x000000043fffffff]</div><div>[ =C2=A0 =C2=A00.=
000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000043fffffff]</d=
iv><div>[ =C2=A0 =C2=A00.000000] On node 0 totalpages: 4192028</div><div>[ =
=C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 64 pages used for memmap</div><div>=
[ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 21 pages reserved</div><div>[ =C2=
=A0 =C2=A00.000000] =C2=A0 DMA zone: 3996 pages, LIFO batch:0</div><div>[ =
=C2=A0 =C2=A00.000000] =C2=A0 DMA32 zone: 12190 pages used for memmap</div>=
<div>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA32 zone: 780160 pages, LIFO batch:3=
1</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 Normal zone: 53248 pages used f=
or memmap</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 Normal zone: 3407872 pa=
ges, LIFO batch:31</div><div>[ =C2=A0 =C2=A00.000000] ACPI: PM-Timer IO Por=
t: 0x808</div><div>[ =C2=A0 =C2=A00.000000] ACPI: Local APIC address 0xfee0=
0000</div><div>[ =C2=A0 =C2=A00.000000] IOAPIC[0]: apic_id 6, version 32, a=
ddress 0xfec00000, GSI 0-23</div><div>[ =C2=A0 =C2=A00.000000] ACPI: INT_SR=
C_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)</div><div>[ =C2=A0 =C2=A00.000=
000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)</div><div>=
[ =C2=A0 =C2=A00.000000] ACPI: IRQ0 used by override.</div><div>[ =C2=A0 =
=C2=A00.000000] ACPI: IRQ9 used by override.</div><div>[ =C2=A0 =C2=A00.000=
000] Using ACPI (MADT) for SMP configuration information</div><div>[ =C2=A0=
 =C2=A00.000000] ACPI: HPET id: 0xffffffff base: 0xfed00000</div><div>[ =C2=
=A0 =C2=A00.000000] smpboot: Allowing 12 CPUs, 0 hotplug CPUs</div><div>[ =
=C2=A0 =C2=A00.000000] PM: Registered nosave memory: [mem 0x00000000-0x0000=
0fff]</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: [mem=
 0x0009d000-0x0009ffff]</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered n=
osave memory: [mem 0x000a0000-0x000dffff]</div><div>[ =C2=A0 =C2=A00.000000=
] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]</div><div>[ =C2=
=A0 =C2=A00.000000] PM: Registered nosave memory: [mem 0xbf780000-0xbf78dff=
f]</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: [mem 0x=
bf78e000-0xbf7cffff]</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosa=
ve memory: [mem 0xbf7d0000-0xbf7dffff]</div><div>[ =C2=A0 =C2=A00.000000] P=
M: Registered nosave memory: [mem 0xbf7e0000-0xbf7e7fff]</div><div>[ =C2=A0=
 =C2=A00.000000] PM: Registered nosave memory: [mem 0xbf7e8000-0xbfffffff]<=
/div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: [mem 0xc00=
00000-0xfedfffff]</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosave =
memory: [mem 0xfee00000-0xfee00fff]</div><div>[ =C2=A0 =C2=A00.000000] PM: =
Registered nosave memory: [mem 0xfee01000-0xffbfffff]</div><div>[ =C2=A0 =
=C2=A00.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]</=
div><div>[ =C2=A0 =C2=A00.000000] e820: [mem 0xc0000000-0xfedfffff] availab=
le for PCI devices</div><div>[ =C2=A0 =C2=A00.000000] Booting paravirtualiz=
ed kernel on bare hardware</div><div>[ =C2=A0 =C2=A00.000000] clocksource: =
refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370=
452778343963 ns</div><div>[ =C2=A0 =C2=A00.000000] setup_percpu: NR_CPUS:12=
8 nr_cpumask_bits:128 nr_cpu_ids:12 nr_node_ids:1</div><div>[ =C2=A0 =C2=A0=
0.000000] percpu: Embedded 32 pages/cpu @ffff88043fc00000 s93528 r8192 d293=
52 u131072</div><div>[ =C2=A0 =C2=A00.000000] pcpu-alloc: s93528 r8192 d293=
52 u131072 alloc=3D1*2097152</div><div>[ =C2=A0 =C2=A00.000000] pcpu-alloc:=
 [0] 00 01 02 03 04 05 06 07 08 09 10 11 -- -- -- --=C2=A0</div><div>[ =C2=
=A0 =C2=A00.000000] Built 1 zonelists in Node order, mobility grouping on.=
=C2=A0 Total pages: 4126505</div><div>[ =C2=A0 =C2=A00.000000] Policy zone:=
 Normal</div><div>[ =C2=A0 =C2=A00.000000] Kernel command line: BOOT_IMAGE=
=3D/boot/vmlinuz-linux-git root=3DUUID=3D80dfd13f-1755-4c83-b110-84282a7779=
64 rw intel_iommu=3Don quiet</div><div>[ =C2=A0 =C2=A00.000000] DMAR: IOMMU=
 enabled</div><div>[ =C2=A0 =C2=A00.000000] PID hash table entries: 4096 (o=
rder: 3, 32768 bytes)</div><div>[ =C2=A0 =C2=A00.000000] Calgary: detecting=
 Calgary via BIOS EBDA area</div><div>[ =C2=A0 =C2=A00.000000] Calgary: Una=
ble to locate Rio Grande table in EBDA - bailing!</div><div>[ =C2=A0 =C2=A0=
0.000000] Memory: 16422160K/16768112K available (5928K kernel code, 974K rw=
data, 1800K rodata, 1224K init, 1152K bss, 345952K reserved, 0K cma-reserve=
d)</div><div>[ =C2=A0 =C2=A00.000000] SLUB: HWalign=3D64, Order=3D0-3, MinO=
bjects=3D0, CPUs=3D12, Nodes=3D1</div><div>[ =C2=A0 =C2=A00.000000] Preempt=
ible hierarchical RCU implementation.</div><div>[ =C2=A0 =C2=A00.000000] <s=
pan style=3D"white-space:pre-wrap">	</span>Build-time adjustment of leaf fa=
nout to 64.</div><div>[ =C2=A0 =C2=A00.000000] <span style=3D"white-space:p=
re-wrap">	</span>RCU restricting CPUs from NR_CPUS=3D128 to nr_cpu_ids=3D12=
.</div><div>[ =C2=A0 =C2=A00.000000] RCU: Adjusting geometry for rcu_fanout=
_leaf=3D64, nr_cpu_ids=3D12</div><div>[ =C2=A0 =C2=A00.000000] NR_IRQS:8448=
 nr_irqs:520 16</div><div>[ =C2=A0 =C2=A00.000000] Console: colour dummy de=
vice 80x25</div><div>[ =C2=A0 =C2=A00.000000] console [tty0] enabled</div><=
div>[ =C2=A0 =C2=A00.000000] clocksource: hpet: mask: 0xffffffff max_cycles=
: 0xffffffff, max_idle_ns: 133484882848 ns</div><div>[ =C2=A0 =C2=A00.00000=
0] hpet clockevent registered</div><div>[ =C2=A0 =C2=A00.000000] tsc: Fast =
TSC calibration using PIT</div><div>[ =C2=A0 =C2=A00.000000] tsc: Detected =
4399.822 MHz processor</div><div>[ =C2=A0 =C2=A00.000021] Calibrating delay=
 loop (skipped), value calculated using timer frequency.. 8803.29 BogoMIPS =
(lpj=3D14666073)</div><div>[ =C2=A0 =C2=A00.000023] pid_max: default: 32768=
 minimum: 301</div><div>[ =C2=A0 =C2=A00.000028] ACPI: Core revision 201601=
08</div><div>[ =C2=A0 =C2=A00.003295] ACPI: 2 ACPI AML tables successfully =
acquired and loaded</div><div><br></div><div>[ =C2=A0 =C2=A00.003313] Secur=
ity Framework initialized</div><div>[ =C2=A0 =C2=A00.003315] Yama: becoming=
 mindful.</div><div>[ =C2=A0 =C2=A00.003986] Dentry cache hash table entrie=
s: 2097152 (order: 12, 16777216 bytes)</div><div>[ =C2=A0 =C2=A00.006358] I=
node-cache hash table entries: 1048576 (order: 11, 8388608 bytes)</div><div=
>[ =C2=A0 =C2=A00.007416] Mount-cache hash table entries: 32768 (order: 6, =
262144 bytes)</div><div>[ =C2=A0 =C2=A00.007428] Mountpoint-cache hash tabl=
e entries: 32768 (order: 6, 262144 bytes)</div><div>[ =C2=A0 =C2=A00.007643=
] CPU: Physical Processor ID: 0</div><div>[ =C2=A0 =C2=A00.007644] CPU: Pro=
cessor Core ID: 0</div><div>[ =C2=A0 =C2=A00.007651] ENERGY_PERF_BIAS: Set =
to &#39;normal&#39;, was &#39;performance&#39;</div><div>[ =C2=A0 =C2=A00.0=
07651] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)</di=
v><div>[ =C2=A0 =C2=A00.007653] mce: CPU supports 9 MCE banks</div><div>[ =
=C2=A0 =C2=A00.007663] CPU0: Thermal monitoring enabled (TM1)</div><div>[ =
=C2=A0 =C2=A00.007669] process: using mwait in idle threads</div><div>[ =C2=
=A0 =C2=A00.007672] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7</div><di=
v>[ =C2=A0 =C2=A00.007672] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32=
, 1GB 0</div><div>[ =C2=A0 =C2=A00.007848] Freeing SMP alternatives memory:=
 24K (ffffffff81a27000 - ffffffff81a2d000)</div><div>[ =C2=A0 =C2=A00.03082=
3] ftrace: allocating 23549 entries in 92 pages</div><div>[ =C2=A0 =C2=A00.=
037549] smpboot: Max logical packages: 2</div><div>[ =C2=A0 =C2=A00.037551]=
 smpboot: APIC(0) Converting physical 0 to logical package 0</div><div>[ =
=C2=A0 =C2=A00.037554] DMAR-IR: This system BIOS has enabled interrupt rema=
pping</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0on a=
 chipset that contains an erratum making that</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0feature unstable.=C2=A0 To maintain s=
ystem stability</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0interrupt remapping is being disabled.=C2=A0 Please</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0contact your BIOS vendor fo=
r an update</div><div>[ =C2=A0 =C2=A00.037557] Switched APIC routing to phy=
sical flat.</div><div>[ =C2=A0 =C2=A00.037916] ..TIMER: vector=3D0x30 apic1=
=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1</div><div>[ =C2=A0 =C2=A00.176482] smpbo=
ot: CPU0: Intel(R) Xeon(R) CPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X5670 =C2=
=A0@ 2.93GHz (family: 0x6, model: 0x2c, stepping: 0x2)</div><div>[ =C2=A0 =
=C2=A00.176490] Performance Events: PEBS fmt1+, 16-deep LBR, Westmere event=
s, Intel PMU driver.</div><div>[ =C2=A0 =C2=A00.176501] core: CPUID marked =
event: &#39;bus cycles&#39; unavailable</div><div>[ =C2=A0 =C2=A00.176502] =
... version: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03</div>=
<div>[ =C2=A0 =C2=A00.176503] ... bit width: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A048</div><div>[ =C2=A0 =C2=A00.176503] ... generic regis=
ters: =C2=A0 =C2=A0 =C2=A04</div><div>[ =C2=A0 =C2=A00.176504] ... value ma=
sk: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0000ffffffffffff</div><div>[ =
=C2=A0 =C2=A00.176505] ... max period: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 000000007fffffff</div><div>[ =C2=A0 =C2=A00.176505] ... fixed-purpos=
e events: =C2=A0 3</div><div>[ =C2=A0 =C2=A00.176506] ... event mask: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 000000070000000f</div><div>[ =C2=A0 =
=C2=A00.177053] NMI watchdog: enabled on all CPUs, permanently consumes one=
 hw-PMU counter.</div><div>[ =C2=A0 =C2=A00.177124] x86: Booting SMP config=
uration:</div><div>[ =C2=A0 =C2=A00.177125] .... node =C2=A0#0, CPUs: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0#1 =C2=A0#2 =C2=A0#3 =C2=A0#4 =C2=A0#5 =C2=A0#6 =C2=
=A0#7 =C2=A0#8 =C2=A0#9 #10 #11</div><div>[ =C2=A0 =C2=A01.111878] x86: Boo=
ted up 1 node, 12 CPUs</div><div>[ =C2=A0 =C2=A01.111880] smpboot: Total of=
 12 processors activated (105640.36 BogoMIPS)</div><div>[ =C2=A0 =C2=A01.12=
2157] devtmpfs: initialized</div><div>[ =C2=A0 =C2=A01.122194] x86/mm: Memo=
ry block size: 128MB</div><div>[ =C2=A0 =C2=A01.124262] PM: Registering ACP=
I NVS region [mem 0xbf78e000-0xbf7cffff] (270336 bytes)</div><div>[ =C2=A0 =
=C2=A01.124316] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 6370867519511994 ns</div><div>[ =C2=A0 =C2=A01.124356] pin=
ctrl core: initialized pinctrl subsystem</div><div>[ =C2=A0 =C2=A01.124390]=
 RTC time: 11:20:20, date: 04/25/16</div><div>[ =C2=A0 =C2=A01.125298] NET:=
 Registered protocol family 16</div><div>[ =C2=A0 =C2=A01.136507] cpuidle: =
using governor ladder</div><div>[ =C2=A0 =C2=A01.149841] cpuidle: using gov=
ernor menu</div><div>[ =C2=A0 =C2=A01.149882] ACPI: bus type PCI registered=
</div><div>[ =C2=A0 =C2=A01.149886] acpiphp: ACPI Hot Plug PCI Controller D=
river version: 0.5</div><div>[ =C2=A0 =C2=A01.149927] PCI: MMCONFIG for dom=
ain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)</div>=
<div>[ =C2=A0 =C2=A01.149928] PCI: not using MMCONFIG</div><div>[ =C2=A0 =
=C2=A01.149929] PCI: Using configuration type 1 for base access</div><div>[=
 =C2=A0 =C2=A01.163263] HugeTLB registered 1 GB page size, pre-allocated 0 =
pages</div><div>[ =C2=A0 =C2=A01.163264] HugeTLB registered 2 MB page size,=
 pre-allocated 0 pages</div><div>[ =C2=A0 =C2=A01.163413] ACPI: Added _OSI(=
Module Device)</div><div>[ =C2=A0 =C2=A01.163414] ACPI: Added _OSI(Processo=
r Device)</div><div>[ =C2=A0 =C2=A01.163415] ACPI: Added _OSI(3.0 _SCP Exte=
nsions)</div><div>[ =C2=A0 =C2=A01.163416] ACPI: Added _OSI(Processor Aggre=
gator Device)</div><div>[ =C2=A0 =C2=A01.163618] ACPI: Executed 1 blocks of=
 module-level executable AML code</div><div>[ =C2=A0 =C2=A01.165471] ACPI: =
Dynamic OEM Table Load:</div><div>[ =C2=A0 =C2=A01.165480] ACPI: SSDT 0xFFF=
F88042CDE8000 002D18 (v01 DpgPmm P001Ist =C2=A000000011 INTL 20051117)</div=
><div>[ =C2=A0 =C2=A01.165914] ACPI: Interpreter enabled</div><div>[ =C2=A0=
 =C2=A01.165923] ACPI: (supports S0 S1 S4 S5)</div><div>[ =C2=A0 =C2=A01.16=
5924] ACPI: Using IOAPIC for interrupt routing</div><div>[ =C2=A0 =C2=A01.1=
65940] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xeffff=
fff] (base 0xe0000000)</div><div>[ =C2=A0 =C2=A01.166245] PCI: MMCONFIG at =
[mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources</div><di=
v>[ =C2=A0 =C2=A01.166248] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe=
0200000] with a huge-page mapping due to MTRR override.</div><div>[ =C2=A0 =
=C2=A01.166548] PCI: Using host bridge windows from ACPI; if necessary, use=
 &quot;pci=3Dnocrs&quot; and report a bug</div><div>[ =C2=A0 =C2=A01.169965=
] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])</div><div>[ =C2=A0=
 =C2=A01.169968] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]</div><div>[ =C2=A0 =C2=A01.170058] acpi PNP0A08:00: _OS=
C: platform does not support [PCIeCapability]</div><div>[ =C2=A0 =C2=A01.17=
0101] acpi PNP0A08:00: _OSC: not requesting control; platform does not supp=
ort [PCIeCapability]</div><div>[ =C2=A0 =C2=A01.170103] acpi PNP0A08:00: _O=
SC: OS requested [PCIeHotplug PME AER PCIeCapability]</div><div>[ =C2=A0 =
=C2=A01.170104] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotpl=
ug PME AER]</div><div>[ =C2=A0 =C2=A01.170105] acpi PNP0A08:00: _OSC failed=
 (AE_SUPPORT); disabling ASPM</div><div>[ =C2=A0 =C2=A01.170259] PCI host b=
ridge to bus 0000:00</div><div>[ =C2=A0 =C2=A01.170261] pci_bus 0000:00: ro=
ot bus resource [io =C2=A00x0000-0x0cf7 window]</div><div>[ =C2=A0 =C2=A01.=
170262] pci_bus 0000:00: root bus resource [io =C2=A00x0d00-0xffff window]<=
/div><div>[ =C2=A0 =C2=A01.170263] pci_bus 0000:00: root bus resource [mem =
0x000a0000-0x000bffff window]</div><div>[ =C2=A0 =C2=A01.170264] pci_bus 00=
00:00: root bus resource [mem 0x000d0000-0x000dffff window]</div><div>[ =C2=
=A0 =C2=A01.170265] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdf=
ffffff window]</div><div>[ =C2=A0 =C2=A01.170266] pci_bus 0000:00: root bus=
 resource [mem 0xf0000000-0xfed8ffff window]</div><div>[ =C2=A0 =C2=A01.170=
267] pci_bus 0000:00: root bus resource [bus 00-ff]</div><div>[ =C2=A0 =C2=
=A01.170274] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000</div><div=
>[ =C2=A0 =C2=A01.170313] pci 0000:00:00.0: PME# supported from D0 D3hot D3=
cold</div><div>[ =C2=A0 =C2=A01.170367] pci 0000:00:01.0: [8086:3408] type =
01 class 0x060400</div><div>[ =C2=A0 =C2=A01.170406] pci 0000:00:01.0: PME#=
 supported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.170439] pci 0000=
:00:01.0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.170463]=
 pci 0000:00:02.0: [8086:3409] type 01 class 0x060400</div><div>[ =C2=A0 =
=C2=A01.170500] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold</div>=
<div>[ =C2=A0 =C2=A01.170532] pci 0000:00:02.0: System wakeup disabled by A=
CPI</div><div>[ =C2=A0 =C2=A01.170555] pci 0000:00:03.0: [8086:340a] type 0=
1 class 0x060400</div><div>[ =C2=A0 =C2=A01.170593] pci 0000:00:03.0: PME# =
supported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.170625] pci 0000:=
00:03.0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.170649] =
pci 0000:00:05.0: [8086:340c] type 01 class 0x060400</div><div>[ =C2=A0 =C2=
=A01.170683] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold</div><di=
v>[ =C2=A0 =C2=A01.170714] pci 0000:00:05.0: System wakeup disabled by ACPI=
</div><div>[ =C2=A0 =C2=A01.170737] pci 0000:00:06.0: [8086:340d] type 01 c=
lass 0x060400</div><div>[ =C2=A0 =C2=A01.170771] pci 0000:00:06.0: PME# sup=
ported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.170802] pci 0000:00:=
06.0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.170825] pci=
 0000:00:07.0: [8086:340e] type 01 class 0x060400</div><div>[ =C2=A0 =C2=A0=
1.170863] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold</div><div>[=
 =C2=A0 =C2=A01.170895] pci 0000:00:07.0: System wakeup disabled by ACPI</d=
iv><div>[ =C2=A0 =C2=A01.170918] pci 0000:00:09.0: [8086:3410] type 01 clas=
s 0x060400</div><div>[ =C2=A0 =C2=A01.170952] pci 0000:00:09.0: PME# suppor=
ted from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.170983] pci 0000:00:09.=
0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.171006] pci 00=
00:00:0a.0: [8086:3411] type 01 class 0x060400</div><div>[ =C2=A0 =C2=A01.1=
71040] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold</div><div>[ =
=C2=A0 =C2=A01.171072] pci 0000:00:0a.0: System wakeup disabled by ACPI</di=
v><div>[ =C2=A0 =C2=A01.171097] pci 0000:00:14.0: [8086:342e] type 00 class=
 0x080000</div><div>[ =C2=A0 =C2=A01.171169] pci 0000:00:14.1: [8086:3422] =
type 00 class 0x080000</div><div>[ =C2=A0 =C2=A01.171239] pci 0000:00:14.2:=
 [8086:3423] type 00 class 0x080000</div><div>[ =C2=A0 =C2=A01.171307] pci =
0000:00:14.3: [8086:3438] type 00 class 0x080000</div><div>[ =C2=A0 =C2=A01=
.171375] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300</div><div>[ =
=C2=A0 =C2=A01.171407] pci 0000:00:1a.0: reg 0x20: [io =C2=A00x5400-0x541f]=
</div><div>[ =C2=A0 =C2=A01.171467] pci 0000:00:1a.0: System wakeup disable=
d by ACPI</div><div>[ =C2=A0 =C2=A01.171491] pci 0000:00:1a.1: [8086:3a38] =
type 00 class 0x0c0300</div><div>[ =C2=A0 =C2=A01.171523] pci 0000:00:1a.1:=
 reg 0x20: [io =C2=A00x5480-0x549f]</div><div>[ =C2=A0 =C2=A01.171584] pci =
0000:00:1a.1: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.171=
607] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300</div><div>[ =C2=
=A0 =C2=A01.171639] pci 0000:00:1a.2: reg 0x20: [io =C2=A00x5800-0x581f]</d=
iv><div>[ =C2=A0 =C2=A01.171700] pci 0000:00:1a.2: System wakeup disabled b=
y ACPI</div><div>[ =C2=A0 =C2=A01.171728] pci 0000:00:1a.7: [8086:3a3c] typ=
e 00 class 0x0c0320</div><div>[ =C2=A0 =C2=A01.171742] pci 0000:00:1a.7: re=
g 0x10: [mem 0xf9af8000-0xf9af83ff]</div><div>[ =C2=A0 =C2=A01.171809] pci =
0000:00:1a.7: PME# supported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A0=
1.171838] pci 0000:00:1a.7: System wakeup disabled by ACPI</div><div>[ =C2=
=A0 =C2=A01.171863] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300</d=
iv><div>[ =C2=A0 =C2=A01.171876] pci 0000:00:1b.0: reg 0x10: [mem 0xf9af400=
0-0xf9af7fff 64bit]</div><div>[ =C2=A0 =C2=A01.171931] pci 0000:00:1b.0: PM=
E# supported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.171984] pci 00=
00:00:1c.0: [8086:3a40] type 01 class 0x060400</div><div>[ =C2=A0 =C2=A01.1=
72038] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold</div><div>[ =
=C2=A0 =C2=A01.172071] pci 0000:00:1c.0: System wakeup disabled by ACPI</di=
v><div>[ =C2=A0 =C2=A01.172095] pci 0000:00:1c.1: [8086:3a42] type 01 class=
 0x060400</div><div>[ =C2=A0 =C2=A01.172148] pci 0000:00:1c.1: PME# support=
ed from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.172182] pci 0000:00:1c.1=
: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.172205] pci 000=
0:00:1c.2: [8086:3a44] type 01 class 0x060400</div><div>[ =C2=A0 =C2=A01.17=
2259] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold</div><div>[ =C2=
=A0 =C2=A01.172291] pci 0000:00:1c.2: System wakeup disabled by ACPI</div><=
div>[ =C2=A0 =C2=A01.172315] pci 0000:00:1c.3: [8086:3a46] type 01 class 0x=
060400</div><div>[ =C2=A0 =C2=A01.172368] pci 0000:00:1c.3: PME# supported =
from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.172401] pci 0000:00:1c.3: S=
ystem wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.172424] pci 0000:0=
0:1c.4: [8086:3a48] type 01 class 0x060400</div><div>[ =C2=A0 =C2=A01.17247=
7] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold</div><div>[ =C2=A0=
 =C2=A01.172509] pci 0000:00:1c.4: System wakeup disabled by ACPI</div><div=
>[ =C2=A0 =C2=A01.172534] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0=
300</div><div>[ =C2=A0 =C2=A01.172568] pci 0000:00:1d.0: reg 0x20: [io =C2=
=A00x5880-0x589f]</div><div>[ =C2=A0 =C2=A01.172630] pci 0000:00:1d.0: Syst=
em wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.172654] pci 0000:00:1=
d.1: [8086:3a35] type 00 class 0x0c0300</div><div>[ =C2=A0 =C2=A01.172686] =
pci 0000:00:1d.1: reg 0x20: [io =C2=A00x5c00-0x5c1f]</div><div>[ =C2=A0 =C2=
=A01.172746] pci 0000:00:1d.1: System wakeup disabled by ACPI</div><div>[ =
=C2=A0 =C2=A01.172770] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300=
</div><div>[ =C2=A0 =C2=A01.172802] pci 0000:00:1d.2: reg 0x20: [io =C2=A00=
x6000-0x601f]</div><div>[ =C2=A0 =C2=A01.172861] pci 0000:00:1d.2: System w=
akeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.172891] pci 0000:00:1d.7:=
 [8086:3a3a] type 00 class 0x0c0320</div><div>[ =C2=A0 =C2=A01.172904] pci =
0000:00:1d.7: reg 0x10: [mem 0xf9afa000-0xf9afa3ff]</div><div>[ =C2=A0 =C2=
=A01.172971] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold</div><di=
v>[ =C2=A0 =C2=A01.173000] pci 0000:00:1d.7: System wakeup disabled by ACPI=
</div><div>[ =C2=A0 =C2=A01.173023] pci 0000:00:1e.0: [8086:244e] type 01 c=
lass 0x060401</div><div>[ =C2=A0 =C2=A01.173077] pci 0000:00:1e.0: System w=
akeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.173101] pci 0000:00:1f.0:=
 [8086:3a16] type 00 class 0x060100</div><div>[ =C2=A0 =C2=A01.173165] pci =
0000:00:1f.0: can&#39;t claim BAR 13 [io =C2=A00x0800-0x087f]: address conf=
lict with ACPI CPU throttle [io =C2=A00x0810-0x0815]</div><div>[ =C2=A0 =C2=
=A01.173168] pci 0000:00:1f.0: quirk: [io =C2=A00x0500-0x053f] claimed by I=
CH6 GPIO</div><div>[ =C2=A0 =C2=A01.173171] pci 0000:00:1f.0: ICH7 LPC Gene=
ric IO decode 1 PIO at 0a00 (mask 00ff)</div><div>[ =C2=A0 =C2=A01.173175] =
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0a00 (mask 0017)</div=
><div>[ =C2=A0 =C2=A01.173178] pci 0000:00:1f.0: ICH7 LPC Generic IO decode=
 3 PIO at 4700 (mask 00ff)</div><div>[ =C2=A0 =C2=A01.173245] pci 0000:00:1=
f.2: [8086:3a22] type 00 class 0x010601</div><div>[ =C2=A0 =C2=A01.173256] =
pci 0000:00:1f.2: reg 0x10: [io =C2=A00x6880-0x6887]</div><div>[ =C2=A0 =C2=
=A01.173261] pci 0000:00:1f.2: reg 0x14: [io =C2=A00x6800-0x6803]</div><div=
>[ =C2=A0 =C2=A01.173267] pci 0000:00:1f.2: reg 0x18: [io =C2=A00x6480-0x64=
87]</div><div>[ =C2=A0 =C2=A01.173272] pci 0000:00:1f.2: reg 0x1c: [io =C2=
=A00x6400-0x6403]</div><div>[ =C2=A0 =C2=A01.173277] pci 0000:00:1f.2: reg =
0x20: [io =C2=A00x6080-0x609f]</div><div>[ =C2=A0 =C2=A01.173283] pci 0000:=
00:1f.2: reg 0x24: [mem 0xf9afc000-0xf9afc7ff]</div><div>[ =C2=A0 =C2=A01.1=
73314] pci 0000:00:1f.2: PME# supported from D3hot</div><div>[ =C2=A0 =C2=
=A01.173360] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500</div><div=
>[ =C2=A0 =C2=A01.173371] pci 0000:00:1f.3: reg 0x10: [mem 0xf9afe000-0xf9a=
fe0ff 64bit]</div><div>[ =C2=A0 =C2=A01.173387] pci 0000:00:1f.3: reg 0x20:=
 [io =C2=A00x0400-0x041f]</div><div>[ =C2=A0 =C2=A01.173472] pci 0000:0e:00=
.0: [1033:0194] type 00 class 0x0c0330</div><div>[ =C2=A0 =C2=A01.173486] p=
ci 0000:0e:00.0: reg 0x10: [mem 0xfbefe000-0xfbefffff 64bit]</div><div>[ =
=C2=A0 =C2=A01.173556] pci 0000:0e:00.0: PME# supported from D0 D3hot D3col=
d</div><div>[ =C2=A0 =C2=A01.179851] pci 0000:00:01.0: PCI bridge to [bus 0=
e]</div><div>[ =C2=A0 =C2=A01.179856] pci 0000:00:01.0: =C2=A0 bridge windo=
w [mem 0xfbe00000-0xfbefffff]</div><div>[ =C2=A0 =C2=A01.179900] pci 0000:0=
d:00.0: [1b4b:9123] type 00 class 0x010601</div><div>[ =C2=A0 =C2=A01.17990=
8] pci 0000:0d:00.0: reg 0x10: [io =C2=A00xe080-0xe087]</div><div>[ =C2=A0 =
=C2=A01.179914] pci 0000:0d:00.0: reg 0x14: [io =C2=A00xe000-0xe003]</div><=
div>[ =C2=A0 =C2=A01.179919] pci 0000:0d:00.0: reg 0x18: [io =C2=A00xdc00-0=
xdc07]</div><div>[ =C2=A0 =C2=A01.179924] pci 0000:0d:00.0: reg 0x1c: [io =
=C2=A00xd880-0xd883]</div><div>[ =C2=A0 =C2=A01.179929] pci 0000:0d:00.0: r=
eg 0x20: [io =C2=A00xd800-0xd80f]</div><div>[ =C2=A0 =C2=A01.179935] pci 00=
00:0d:00.0: reg 0x24: [mem 0xfbddf800-0xfbddffff]</div><div>[ =C2=A0 =C2=A0=
1.179940] pci 0000:0d:00.0: reg 0x30: [mem 0xfbdc0000-0xfbdcffff pref]</div=
><div>[ =C2=A0 =C2=A01.179967] pci 0000:0d:00.0: PME# supported from D3hot<=
/div><div>[ =C2=A0 =C2=A01.186515] pci 0000:00:02.0: PCI bridge to [bus 0d]=
</div><div>[ =C2=A0 =C2=A01.186519] pci 0000:00:02.0: =C2=A0 bridge window =
[io =C2=A00xd000-0xefff]</div><div>[ =C2=A0 =C2=A01.186522] pci 0000:00:02.=
0: =C2=A0 bridge window [mem 0xfbd00000-0xfbdfffff]</div><div>[ =C2=A0 =C2=
=A01.186563] pci 0000:0c:00.0: [10de:1080] type 00 class 0x030000</div><div=
>[ =C2=A0 =C2=A01.186572] pci 0000:0c:00.0: reg 0x10: [mem 0xfa000000-0xfaf=
fffff]</div><div>[ =C2=A0 =C2=A01.186579] pci 0000:0c:00.0: reg 0x14: [mem =
0xd8000000-0xdfffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.186586] pci 00=
00:0c:00.0: reg 0x1c: [mem 0xd6000000-0xd7ffffff 64bit pref]</div><div>[ =
=C2=A0 =C2=A01.186591] pci 0000:0c:00.0: reg 0x24: [io =C2=A00xcc00-0xcc7f]=
</div><div>[ =C2=A0 =C2=A01.186596] pci 0000:0c:00.0: reg 0x30: [mem 0xf9f8=
0000-0xf9ffffff pref]</div><div>[ =C2=A0 =C2=A01.186660] pci 0000:0c:00.1: =
[10de:0e09] type 00 class 0x040300</div><div>[ =C2=A0 =C2=A01.186668] pci 0=
000:0c:00.1: reg 0x10: [mem 0xfbcfc000-0xfbcfffff]</div><div>[ =C2=A0 =C2=
=A01.193184] pci 0000:00:03.0: PCI bridge to [bus 0c]</div><div>[ =C2=A0 =
=C2=A01.193188] pci 0000:00:03.0: =C2=A0 bridge window [io =C2=A00xc000-0xc=
fff]</div><div>[ =C2=A0 =C2=A01.193191] pci 0000:00:03.0: =C2=A0 bridge win=
dow [mem 0xf9f00000-0xfbcfffff]</div><div>[ =C2=A0 =C2=A01.193195] pci 0000=
:00:03.0: =C2=A0 bridge window [mem 0xd6000000-0xdfffffff 64bit pref]</div>=
<div>[ =C2=A0 =C2=A01.193226] pci 0000:00:05.0: PCI bridge to [bus 0b]</div=
><div>[ =C2=A0 =C2=A01.193254] pci 0000:00:06.0: PCI bridge to [bus 0a]</di=
v><div>[ =C2=A0 =C2=A01.193286] pci 0000:09:00.0: [10de:0622] type 00 class=
 0x030000</div><div>[ =C2=A0 =C2=A01.193294] pci 0000:09:00.0: reg 0x10: [m=
em 0xf8000000-0xf8ffffff]</div><div>[ =C2=A0 =C2=A01.193300] pci 0000:09:00=
.0: reg 0x14: [mem 0xc0000000-0xcfffffff 64bit pref]</div><div>[ =C2=A0 =C2=
=A01.193306] pci 0000:09:00.0: reg 0x1c: [mem 0xf6000000-0xf7ffffff 64bit]<=
/div><div>[ =C2=A0 =C2=A01.193310] pci 0000:09:00.0: reg 0x24: [io =C2=A00x=
bc00-0xbc7f]</div><div>[ =C2=A0 =C2=A01.193314] pci 0000:09:00.0: reg 0x30:=
 [mem 0xf5f80000-0xf5ffffff pref]</div><div>[ =C2=A0 =C2=A01.199848] pci 00=
00:00:07.0: PCI bridge to [bus 09]</div><div>[ =C2=A0 =C2=A01.199852] pci 0=
000:00:07.0: =C2=A0 bridge window [io =C2=A00xb000-0xbfff]</div><div>[ =C2=
=A0 =C2=A01.199854] pci 0000:00:07.0: =C2=A0 bridge window [mem 0xf5f00000-=
0xf8ffffff]</div><div>[ =C2=A0 =C2=A01.199859] pci 0000:00:07.0: =C2=A0 bri=
dge window [mem 0xc0000000-0xcfffffff 64bit pref]</div><div>[ =C2=A0 =C2=A0=
1.199892] pci 0000:00:09.0: PCI bridge to [bus 08]</div><div>[ =C2=A0 =C2=
=A01.199919] pci 0000:00:0a.0: PCI bridge to [bus 07]</div><div>[ =C2=A0 =
=C2=A01.199962] pci 0000:06:00.0: [10ec:8168] type 00 class 0x020000</div><=
div>[ =C2=A0 =C2=A01.199978] pci 0000:06:00.0: reg 0x10: [io =C2=A00xa800-0=
xa8ff]</div><div>[ =C2=A0 =C2=A01.200002] pci 0000:06:00.0: reg 0x18: [mem =
0xf3fff000-0xf3ffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.200016] pci 00=
00:06:00.0: reg 0x20: [mem 0xf3ff8000-0xf3ffbfff 64bit pref]</div><div>[ =
=C2=A0 =C2=A01.200026] pci 0000:06:00.0: reg 0x30: [mem 0xf9ee0000-0xf9efff=
ff pref]</div><div>[ =C2=A0 =C2=A01.200094] pci 0000:06:00.0: supports D1 D=
2</div><div>[ =C2=A0 =C2=A01.200095] pci 0000:06:00.0: PME# supported from =
D0 D1 D2 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.206521] pci 0000:00:1c.0: =
PCI bridge to [bus 06]</div><div>[ =C2=A0 =C2=A01.206525] pci 0000:00:1c.0:=
 =C2=A0 bridge window [io =C2=A00xa000-0xafff]</div><div>[ =C2=A0 =C2=A01.2=
06528] pci 0000:00:1c.0: =C2=A0 bridge window [mem 0xf9e00000-0xf9efffff]</=
div><div>[ =C2=A0 =C2=A01.206533] pci 0000:00:1c.0: =C2=A0 bridge window [m=
em 0xf3f00000-0xf3ffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.206581] pci=
 0000:05:00.0: [10ec:8168] type 00 class 0x020000</div><div>[ =C2=A0 =C2=A0=
1.206597] pci 0000:05:00.0: reg 0x10: [io =C2=A00x9800-0x98ff]</div><div>[ =
=C2=A0 =C2=A01.206620] pci 0000:05:00.0: reg 0x18: [mem 0xf3eff000-0xf3efff=
ff 64bit pref]</div><div>[ =C2=A0 =C2=A01.206634] pci 0000:05:00.0: reg 0x2=
0: [mem 0xf3ef8000-0xf3efbfff 64bit pref]</div><div>[ =C2=A0 =C2=A01.206644=
] pci 0000:05:00.0: reg 0x30: [mem 0xf9de0000-0xf9dfffff pref]</div><div>[ =
=C2=A0 =C2=A01.206712] pci 0000:05:00.0: supports D1 D2</div><div>[ =C2=A0 =
=C2=A01.206713] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold=
</div><div>[ =C2=A0 =C2=A01.213187] pci 0000:00:1c.1: PCI bridge to [bus 05=
]</div><div>[ =C2=A0 =C2=A01.213191] pci 0000:00:1c.1: =C2=A0 bridge window=
 [io =C2=A00x9000-0x9fff]</div><div>[ =C2=A0 =C2=A01.213194] pci 0000:00:1c=
.1: =C2=A0 bridge window [mem 0xf9d00000-0xf9dfffff]</div><div>[ =C2=A0 =C2=
=A01.213199] pci 0000:00:1c.1: =C2=A0 bridge window [mem 0xf3e00000-0xf3eff=
fff 64bit pref]</div><div>[ =C2=A0 =C2=A01.213248] pci 0000:04:00.0: [1106:=
3403] type 00 class 0x0c0010</div><div>[ =C2=A0 =C2=A01.213269] pci 0000:04=
:00.0: reg 0x10: [mem 0xf9cff800-0xf9cfffff 64bit]</div><div>[ =C2=A0 =C2=
=A01.213279] pci 0000:04:00.0: reg 0x18: [io =C2=A00x8800-0x88ff]</div><div=
>[ =C2=A0 =C2=A01.213366] pci 0000:04:00.0: supports D2</div><div>[ =C2=A0 =
=C2=A01.213367] pci 0000:04:00.0: PME# supported from D2 D3hot D3cold</div>=
<div>[ =C2=A0 =C2=A01.219853] pci 0000:00:1c.2: PCI bridge to [bus 04]</div=
><div>[ =C2=A0 =C2=A01.219857] pci 0000:00:1c.2: =C2=A0 bridge window [io =
=C2=A00x8000-0x8fff]</div><div>[ =C2=A0 =C2=A01.219860] pci 0000:00:1c.2: =
=C2=A0 bridge window [mem 0xf9c00000-0xf9cfffff]</div><div>[ =C2=A0 =C2=A01=
.219919] pci 0000:03:00.0: [197b:2362] type 00 class 0x010601</div><div>[ =
=C2=A0 =C2=A01.219948] pci 0000:03:00.0: reg 0x10: [io =C2=A00x7c00-0x7c07]=
</div><div>[ =C2=A0 =C2=A01.219959] pci 0000:03:00.0: reg 0x14: [io =C2=A00=
x7880-0x7883]</div><div>[ =C2=A0 =C2=A01.219971] pci 0000:03:00.0: reg 0x18=
: [io =C2=A00x7800-0x7807]</div><div>[ =C2=A0 =C2=A01.219982] pci 0000:03:0=
0.0: reg 0x1c: [io =C2=A00x7480-0x7483]</div><div>[ =C2=A0 =C2=A01.219993] =
pci 0000:03:00.0: reg 0x20: [io =C2=A00x7400-0x740f]</div><div>[ =C2=A0 =C2=
=A01.220005] pci 0000:03:00.0: reg 0x24: [mem 0xf9bffc00-0xf9bffdff]</div><=
div>[ =C2=A0 =C2=A01.220016] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x=
0000ffff pref]</div><div>[ =C2=A0 =C2=A01.220066] pci 0000:03:00.0: PME# su=
pported from D3hot</div><div>[ =C2=A0 =C2=A01.226520] pci 0000:00:1c.3: PCI=
 bridge to [bus 03]</div><div>[ =C2=A0 =C2=A01.226524] pci 0000:00:1c.3: =
=C2=A0 bridge window [io =C2=A00x7000-0x7fff]</div><div>[ =C2=A0 =C2=A01.22=
6527] pci 0000:00:1c.3: =C2=A0 bridge window [mem 0xf9b00000-0xf9bfffff]</d=
iv><div>[ =C2=A0 =C2=A01.226579] pci 0000:02:00.0: [1102:000b] type 00 clas=
s 0x040300</div><div>[ =C2=A0 =C2=A01.226603] pci 0000:02:00.0: reg 0x10: [=
mem 0xf5ef0000-0xf5efffff 64bit]</div><div>[ =C2=A0 =C2=A01.226620] pci 000=
0:02:00.0: reg 0x18: [mem 0xf5c00000-0xf5dfffff 64bit]</div><div>[ =C2=A0 =
=C2=A01.226636] pci 0000:02:00.0: reg 0x20: [mem 0xf4000000-0xf4ffffff 64bi=
t]</div><div>[ =C2=A0 =C2=A01.233186] pci 0000:00:1c.4: PCI bridge to [bus =
02]</div><div>[ =C2=A0 =C2=A01.233192] pci 0000:00:1c.4: =C2=A0 bridge wind=
ow [mem 0xf4000000-0xf5efffff]</div><div>[ =C2=A0 =C2=A01.233256] pci 0000:=
00:1e.0: PCI bridge to [bus 01] (subtractive decode)</div><div>[ =C2=A0 =C2=
=A01.233262] pci 0000:00:1e.0: =C2=A0 bridge window [io =C2=A00x0000-0x0cf7=
 window] (subtractive decode)</div><div>[ =C2=A0 =C2=A01.233263] pci 0000:0=
0:1e.0: =C2=A0 bridge window [io =C2=A00x0d00-0xffff window] (subtractive d=
ecode)</div><div>[ =C2=A0 =C2=A01.233264] pci 0000:00:1e.0: =C2=A0 bridge w=
indow [mem 0x000a0000-0x000bffff window] (subtractive decode)</div><div>[ =
=C2=A0 =C2=A01.233265] pci 0000:00:1e.0: =C2=A0 bridge window [mem 0x000d00=
00-0x000dffff window] (subtractive decode)</div><div>[ =C2=A0 =C2=A01.23326=
6] pci 0000:00:1e.0: =C2=A0 bridge window [mem 0xc0000000-0xdfffffff window=
] (subtractive decode)</div><div>[ =C2=A0 =C2=A01.233267] pci 0000:00:1e.0:=
 =C2=A0 bridge window [mem 0xf0000000-0xfed8ffff window] (subtractive decod=
e)</div><div>[ =C2=A0 =C2=A01.233544] ACPI: PCI Interrupt Link [LNKA] (IRQs=
 3 4 6 7 10 11 12 14 *15)</div><div>[ =C2=A0 =C2=A01.233574] ACPI: PCI Inte=
rrupt Link [LNKB] (IRQs *5)</div><div>[ =C2=A0 =C2=A01.233601] ACPI: PCI In=
terrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12 14 15)</div><div>[ =C2=A0 =C2=
=A01.233629] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 *10 11 12 14 15)=
</div><div>[ =C2=A0 =C2=A01.233657] ACPI: PCI Interrupt Link [LNKE] (IRQs 3=
 4 6 7 10 11 12 14 15) *0, disabled.</div><div>[ =C2=A0 =C2=A01.233686] ACP=
I: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14 15)</div><div>[ =C2=
=A0 =C2=A01.233713] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 6 7 10 11 12=
 14 15)</div><div>[ =C2=A0 =C2=A01.233741] ACPI: PCI Interrupt Link [LNKH] =
(IRQs 3 4 6 7 10 11 12 *14 15)</div><div>[ =C2=A0 =C2=A01.233771] ACPI: Ena=
bled 1 GPEs in block 00 to 3F</div><div>[ =C2=A0 =C2=A01.233826] vgaarb: se=
tting as boot device: PCI:0000:0c:00.0</div><div>[ =C2=A0 =C2=A01.233827] v=
gaarb: device added: PCI:0000:0c:00.0,decodes=3Dio+mem,owns=3Dio+mem,locks=
=3Dnone</div><div>[ =C2=A0 =C2=A01.233829] vgaarb: device added: PCI:0000:0=
9:00.0,decodes=3Dio+mem,owns=3Dnone,locks=3Dnone</div><div>[ =C2=A0 =C2=A01=
.233830] vgaarb: loaded</div><div>[ =C2=A0 =C2=A01.233831] vgaarb: bridge c=
ontrol possible 0000:09:00.0</div><div>[ =C2=A0 =C2=A01.233831] vgaarb: bri=
dge control possible 0000:0c:00.0</div><div>[ =C2=A0 =C2=A01.233876] PCI: U=
sing ACPI for IRQ routing</div><div>[ =C2=A0 =C2=A01.238422] PCI: Discovere=
d peer bus ff</div><div>[ =C2=A0 =C2=A01.238423] PCI: root bus ff: using de=
fault resources</div><div>[ =C2=A0 =C2=A01.238423] PCI: Probing PCI hardwar=
e (bus ff)</div><div>[ =C2=A0 =C2=A01.238439] ACPI: \: failed to evaluate _=
DSM (0x1001)</div><div>[ =C2=A0 =C2=A01.238440] PCI host bridge to bus 0000=
:ff</div><div>[ =C2=A0 =C2=A01.238441] pci_bus 0000:ff: root bus resource [=
io =C2=A00x0000-0xffff]</div><div>[ =C2=A0 =C2=A01.238442] pci_bus 0000:ff:=
 root bus resource [mem 0x00000000-0xffffffffff]</div><div>[ =C2=A0 =C2=A01=
.238443] pci_bus 0000:ff: No busn resource found for root bus, will use [bu=
s ff-ff]</div><div>[ =C2=A0 =C2=A01.238444] pci_bus 0000:ff: busn_res: can =
not insert [bus ff] under domain [bus 00-ff] (conflicts with (null) [bus 00=
-ff])</div><div>[ =C2=A0 =C2=A01.238447] pci 0000:ff:00.0: [8086:2c70] type=
 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.238473] pci 0000:ff:00.1: [80=
86:2d81] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.238498] pci 0000=
:ff:02.0: [8086:2d90] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.238=
521] pci 0000:ff:02.1: [8086:2d91] type 00 class 0x060000</div><div>[ =C2=
=A0 =C2=A01.238546] pci 0000:ff:02.2: [8086:2d92] type 00 class 0x060000</d=
iv><div>[ =C2=A0 =C2=A01.238570] pci 0000:ff:02.3: [8086:2d93] type 00 clas=
s 0x060000</div><div>[ =C2=A0 =C2=A01.238593] pci 0000:ff:02.4: [8086:2d94]=
 type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.238616] pci 0000:ff:02.5=
: [8086:2d95] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.238639] pci=
 0000:ff:03.0: [8086:2d98] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A0=
1.238663] pci 0000:ff:03.1: [8086:2d99] type 00 class 0x060000</div><div>[ =
=C2=A0 =C2=A01.238686] pci 0000:ff:03.2: [8086:2d9a] type 00 class 0x060000=
</div><div>[ =C2=A0 =C2=A01.238709] pci 0000:ff:03.4: [8086:2d9c] type 00 c=
lass 0x060000</div><div>[ =C2=A0 =C2=A01.238733] pci 0000:ff:04.0: [8086:2d=
a0] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.238757] pci 0000:ff:0=
4.1: [8086:2da1] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.238780] =
pci 0000:ff:04.2: [8086:2da2] type 00 class 0x060000</div><div>[ =C2=A0 =C2=
=A01.238803] pci 0000:ff:04.3: [8086:2da3] type 00 class 0x060000</div><div=
>[ =C2=A0 =C2=A01.238827] pci 0000:ff:05.0: [8086:2da8] type 00 class 0x060=
000</div><div>[ =C2=A0 =C2=A01.238851] pci 0000:ff:05.1: [8086:2da9] type 0=
0 class 0x060000</div><div>[ =C2=A0 =C2=A01.238874] pci 0000:ff:05.2: [8086=
:2daa] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.238897] pci 0000:f=
f:05.3: [8086:2dab] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.23892=
3] pci 0000:ff:06.0: [8086:2db0] type 00 class 0x060000</div><div>[ =C2=A0 =
=C2=A01.238946] pci 0000:ff:06.1: [8086:2db1] type 00 class 0x060000</div><=
div>[ =C2=A0 =C2=A01.238969] pci 0000:ff:06.2: [8086:2db2] type 00 class 0x=
060000</div><div>[ =C2=A0 =C2=A01.238992] pci 0000:ff:06.3: [8086:2db3] typ=
e 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.239023] pci_bus 0000:ff: bus=
n_res: [bus ff] end is updated to ff</div><div>[ =C2=A0 =C2=A01.239024] pci=
_bus 0000:ff: busn_res: can not insert [bus ff] under domain [bus 00-ff] (c=
onflicts with (null) [bus 00-ff])</div><div>[ =C2=A0 =C2=A01.239028] PCI: p=
ci_cache_line_size set to 64 bytes</div><div>[ =C2=A0 =C2=A01.239106] e820:=
 reserve RAM buffer [mem 0x0009d000-0x0009ffff]</div><div>[ =C2=A0 =C2=A01.=
239107] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]</div><div>[ =
=C2=A0 =C2=A01.239172] NetLabel: Initializing</div><div>[ =C2=A0 =C2=A01.23=
9173] NetLabel: =C2=A0domain hash size =3D 128</div><div>[ =C2=A0 =C2=A01.2=
39173] NetLabel: =C2=A0protocols =3D UNLABELED CIPSOv4</div><div>[ =C2=A0 =
=C2=A01.239180] NetLabel: =C2=A0unlabeled traffic allowed by default</div><=
div>[ =C2=A0 =C2=A01.239213] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0</di=
v><div>[ =C2=A0 =C2=A01.239215] hpet0: 4 comparators, 64-bit 14.318180 MHz =
counter</div><div>[ =C2=A0 =C2=A01.241237] clocksource: Switched to clockso=
urce hpet</div><div>[ =C2=A0 =C2=A01.244563] VFS: Disk quotas dquot_6.6.0</=
div><div>[ =C2=A0 =C2=A01.244580] VFS: Dquot-cache hash table entries: 512 =
(order 0, 4096 bytes)</div><div>[ =C2=A0 =C2=A01.244637] pnp: PnP ACPI init=
</div><div>[ =C2=A0 =C2=A01.244678] system 00:00: [mem 0xfbf00000-0xfbfffff=
f] has been reserved</div><div>[ =C2=A0 =C2=A01.244679] system 00:00: [mem =
0xfc000000-0xfcffffff] has been reserved</div><div>[ =C2=A0 =C2=A01.244680]=
 system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved</div><div>[ =
=C2=A0 =C2=A01.244681] system 00:00: [mem 0xfe000000-0xfebfffff] has been r=
eserved</div><div>[ =C2=A0 =C2=A01.244682] system 00:00: [mem 0xfec8a000-0x=
fec8afff] has been reserved</div><div>[ =C2=A0 =C2=A01.244683] system 00:00=
: [mem 0xfed10000-0xfed10fff] has been reserved</div><div>[ =C2=A0 =C2=A01.=
244686] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)</div>=
<div>[ =C2=A0 =C2=A01.244714] pnp 00:01: Plug and Play ACPI device, IDs PNP=
0b00 (active)</div><div>[ =C2=A0 =C2=A01.244798] system 00:02: [io =C2=A00x=
0a00-0x0adf] has been reserved</div><div>[ =C2=A0 =C2=A01.244800] system 00=
:02: [io =C2=A00x0ae0-0x0aef] has been reserved</div><div>[ =C2=A0 =C2=A01.=
244802] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)</div>=
<div>[ =C2=A0 =C2=A01.244901] system 00:03: [io =C2=A00x04d0-0x04d1] has be=
en reserved</div><div>[ =C2=A0 =C2=A01.244902] system 00:03: [io =C2=A00x08=
00-0x087f] could not be reserved</div><div>[ =C2=A0 =C2=A01.244903] system =
00:03: [io =C2=A00x0500-0x057f] could not be reserved</div><div>[ =C2=A0 =
=C2=A01.244905] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved=
</div><div>[ =C2=A0 =C2=A01.244906] system 00:03: [mem 0xfed20000-0xfed3fff=
f] has been reserved</div><div>[ =C2=A0 =C2=A01.244907] system 00:03: [mem =
0xfed45000-0xfed89fff] has been reserved</div><div>[ =C2=A0 =C2=A01.244908]=
 system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved</div><div>[ =
=C2=A0 =C2=A01.244909] system 00:03: [mem 0xfed40000-0xfed8ffff] could not =
be reserved</div><div>[ =C2=A0 =C2=A01.244911] system 00:03: Plug and Play =
ACPI device, IDs PNP0c02 (active)</div><div>[ =C2=A0 =C2=A01.244989] system=
 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved</div><div>[ =C2=
=A0 =C2=A01.244990] system 00:04: [mem 0xfee00000-0xfee00fff] has been rese=
rved</div><div>[ =C2=A0 =C2=A01.244992] system 00:04: Plug and Play ACPI de=
vice, IDs PNP0c02 (active)</div><div>[ =C2=A0 =C2=A01.245040] system 00:05:=
 [mem 0xe0000000-0xefffffff] has been reserved</div><div>[ =C2=A0 =C2=A01.2=
45042] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)</div><=
div>[ =C2=A0 =C2=A01.245146] system 00:06: [mem 0x00000000-0x0009ffff] coul=
d not be reserved</div><div>[ =C2=A0 =C2=A01.245147] system 00:06: [mem 0x0=
00c0000-0x000cffff] could not be reserved</div><div>[ =C2=A0 =C2=A01.245149=
] system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved</div><div=
>[ =C2=A0 =C2=A01.245150] system 00:06: [mem 0x00100000-0xbfffffff] could n=
ot be reserved</div><div>[ =C2=A0 =C2=A01.245151] system 00:06: [mem 0xfed9=
0000-0xffffffff] could not be reserved</div><div>[ =C2=A0 =C2=A01.245153] s=
ystem 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)</div><div>[ =
=C2=A0 =C2=A01.245216] pnp: PnP ACPI: found 7 devices</div><div>[ =C2=A0 =
=C2=A01.250843] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, =
max_idle_ns: 2085701024 ns</div><div>[ =C2=A0 =C2=A01.250887] pci 0000:00:1=
c.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_s=
ize 200000 add_align 100000</div><div>[ =C2=A0 =C2=A01.250893] pci 0000:00:=
1c.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_=
size 200000 add_align 100000</div><div>[ =C2=A0 =C2=A01.250898] pci 0000:00=
:1c.4: bridge window [io =C2=A00x1000-0x0fff] to [bus 02] add_size 1000</di=
v><div>[ =C2=A0 =C2=A01.250899] pci 0000:00:1c.4: bridge window [mem 0x0010=
0000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000</d=
iv><div>[ =C2=A0 =C2=A01.250908] pci 0000:00:1f.0: BAR 13: [io =C2=A0size 0=
x0080] has bogus alignment</div><div>[ =C2=A0 =C2=A01.250910] pci 0000:00:1=
c.2: res[15]=3D[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_si=
ze 200000 min_align 100000</div><div>[ =C2=A0 =C2=A01.250911] pci 0000:00:1=
c.2: res[15]=3D[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_si=
ze 200000 min_align 100000</div><div>[ =C2=A0 =C2=A01.250912] pci 0000:00:1=
c.3: res[15]=3D[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_si=
ze 200000 min_align 100000</div><div>[ =C2=A0 =C2=A01.250913] pci 0000:00:1=
c.3: res[15]=3D[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_si=
ze 200000 min_align 100000</div><div>[ =C2=A0 =C2=A01.250914] pci 0000:00:1=
c.4: res[15]=3D[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_si=
ze 200000 min_align 100000</div><div>[ =C2=A0 =C2=A01.250915] pci 0000:00:1=
c.4: res[15]=3D[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_si=
ze 200000 min_align 100000</div><div>[ =C2=A0 =C2=A01.250916] pci 0000:00:1=
c.4: res[13]=3D[io =C2=A00x1000-0x0fff] res_to_dev_res add_size 1000 min_al=
ign 1000</div><div>[ =C2=A0 =C2=A01.250917] pci 0000:00:1c.4: res[13]=3D[io=
 =C2=A00x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000</div><div=
>[ =C2=A0 =C2=A01.250921] pci 0000:00:1c.2: BAR 15: assigned [mem 0xd000000=
0-0xd01fffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.250924] pci 0000:00:1c.=
3: BAR 15: assigned [mem 0xd0200000-0xd03fffff 64bit pref]</div><div>[ =C2=
=A0 =C2=A01.250926] pci 0000:00:1c.4: BAR 15: assigned [mem 0xd0400000-0xd0=
5fffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.250927] pci 0000:00:1c.4: BAR=
 13: assigned [io =C2=A00x1000-0x1fff]</div><div>[ =C2=A0 =C2=A01.250929] p=
ci 0000:00:01.0: PCI bridge to [bus 0e]</div><div>[ =C2=A0 =C2=A01.250931] =
pci 0000:00:01.0: =C2=A0 bridge window [mem 0xfbe00000-0xfbefffff]</div><di=
v>[ =C2=A0 =C2=A01.250935] pci 0000:00:02.0: PCI bridge to [bus 0d]</div><d=
iv>[ =C2=A0 =C2=A01.250937] pci 0000:00:02.0: =C2=A0 bridge window [io =C2=
=A00xd000-0xefff]</div><div>[ =C2=A0 =C2=A01.250939] pci 0000:00:02.0: =C2=
=A0 bridge window [mem 0xfbd00000-0xfbdfffff]</div><div>[ =C2=A0 =C2=A01.25=
0943] pci 0000:00:03.0: PCI bridge to [bus 0c]</div><div>[ =C2=A0 =C2=A01.2=
50944] pci 0000:00:03.0: =C2=A0 bridge window [io =C2=A00xc000-0xcfff]</div=
><div>[ =C2=A0 =C2=A01.250946] pci 0000:00:03.0: =C2=A0 bridge window [mem =
0xf9f00000-0xfbcfffff]</div><div>[ =C2=A0 =C2=A01.250948] pci 0000:00:03.0:=
 =C2=A0 bridge window [mem 0xd6000000-0xdfffffff 64bit pref]</div><div>[ =
=C2=A0 =C2=A01.250951] pci 0000:00:05.0: PCI bridge to [bus 0b]</div><div>[=
 =C2=A0 =C2=A01.250956] pci 0000:00:06.0: PCI bridge to [bus 0a]</div><div>=
[ =C2=A0 =C2=A01.250962] pci 0000:00:07.0: PCI bridge to [bus 09]</div><div=
>[ =C2=A0 =C2=A01.250963] pci 0000:00:07.0: =C2=A0 bridge window [io =C2=A0=
0xb000-0xbfff]</div><div>[ =C2=A0 =C2=A01.250965] pci 0000:00:07.0: =C2=A0 =
bridge window [mem 0xf5f00000-0xf8ffffff]</div><div>[ =C2=A0 =C2=A01.250967=
] pci 0000:00:07.0: =C2=A0 bridge window [mem 0xc0000000-0xcfffffff 64bit p=
ref]</div><div>[ =C2=A0 =C2=A01.250970] pci 0000:00:09.0: PCI bridge to [bu=
s 08]</div><div>[ =C2=A0 =C2=A01.250975] pci 0000:00:0a.0: PCI bridge to [b=
us 07]</div><div>[ =C2=A0 =C2=A01.250981] pci 0000:00:1c.0: PCI bridge to [=
bus 06]</div><div>[ =C2=A0 =C2=A01.250982] pci 0000:00:1c.0: =C2=A0 bridge =
window [io =C2=A00xa000-0xafff]</div><div>[ =C2=A0 =C2=A01.250985] pci 0000=
:00:1c.0: =C2=A0 bridge window [mem 0xf9e00000-0xf9efffff]</div><div>[ =C2=
=A0 =C2=A01.250987] pci 0000:00:1c.0: =C2=A0 bridge window [mem 0xf3f00000-=
0xf3ffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.250991] pci 0000:00:1c.1:=
 PCI bridge to [bus 05]</div><div>[ =C2=A0 =C2=A01.250993] pci 0000:00:1c.1=
: =C2=A0 bridge window [io =C2=A00x9000-0x9fff]</div><div>[ =C2=A0 =C2=A01.=
250995] pci 0000:00:1c.1: =C2=A0 bridge window [mem 0xf9d00000-0xf9dfffff]<=
/div><div>[ =C2=A0 =C2=A01.250998] pci 0000:00:1c.1: =C2=A0 bridge window [=
mem 0xf3e00000-0xf3efffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.251001] pc=
i 0000:00:1c.2: PCI bridge to [bus 04]</div><div>[ =C2=A0 =C2=A01.251003] p=
ci 0000:00:1c.2: =C2=A0 bridge window [io =C2=A00x8000-0x8fff]</div><div>[ =
=C2=A0 =C2=A01.251006] pci 0000:00:1c.2: =C2=A0 bridge window [mem 0xf9c000=
00-0xf9cfffff]</div><div>[ =C2=A0 =C2=A01.251008] pci 0000:00:1c.2: =C2=A0 =
bridge window [mem 0xd0000000-0xd01fffff 64bit pref]</div><div>[ =C2=A0 =C2=
=A01.251012] pci 0000:03:00.0: BAR 6: assigned [mem 0xf9b00000-0xf9b0ffff p=
ref]</div><div>[ =C2=A0 =C2=A01.251013] pci 0000:00:1c.3: PCI bridge to [bu=
s 03]</div><div>[ =C2=A0 =C2=A01.251015] pci 0000:00:1c.3: =C2=A0 bridge wi=
ndow [io =C2=A00x7000-0x7fff]</div><div>[ =C2=A0 =C2=A01.251018] pci 0000:0=
0:1c.3: =C2=A0 bridge window [mem 0xf9b00000-0xf9bfffff]</div><div>[ =C2=A0=
 =C2=A01.251020] pci 0000:00:1c.3: =C2=A0 bridge window [mem 0xd0200000-0xd=
03fffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.251023] pci 0000:00:1c.4: PC=
I bridge to [bus 02]</div><div>[ =C2=A0 =C2=A01.251025] pci 0000:00:1c.4: =
=C2=A0 bridge window [io =C2=A00x1000-0x1fff]</div><div>[ =C2=A0 =C2=A01.25=
1028] pci 0000:00:1c.4: =C2=A0 bridge window [mem 0xf4000000-0xf5efffff]</d=
iv><div>[ =C2=A0 =C2=A01.251030] pci 0000:00:1c.4: =C2=A0 bridge window [me=
m 0xd0400000-0xd05fffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.251034] pci =
0000:00:1e.0: PCI bridge to [bus 01]</div><div>[ =C2=A0 =C2=A01.251041] pci=
_bus 0000:00: resource 4 [io =C2=A00x0000-0x0cf7 window]</div><div>[ =C2=A0=
 =C2=A01.251042] pci_bus 0000:00: resource 5 [io =C2=A00x0d00-0xffff window=
]</div><div>[ =C2=A0 =C2=A01.251043] pci_bus 0000:00: resource 6 [mem 0x000=
a0000-0x000bffff window]</div><div>[ =C2=A0 =C2=A01.251044] pci_bus 0000:00=
: resource 7 [mem 0x000d0000-0x000dffff window]</div><div>[ =C2=A0 =C2=A01.=
251045] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff window]</div=
><div>[ =C2=A0 =C2=A01.251046] pci_bus 0000:00: resource 9 [mem 0xf0000000-=
0xfed8ffff window]</div><div>[ =C2=A0 =C2=A01.251047] pci_bus 0000:0e: reso=
urce 1 [mem 0xfbe00000-0xfbefffff]</div><div>[ =C2=A0 =C2=A01.251048] pci_b=
us 0000:0d: resource 0 [io =C2=A00xd000-0xefff]</div><div>[ =C2=A0 =C2=A01.=
251049] pci_bus 0000:0d: resource 1 [mem 0xfbd00000-0xfbdfffff]</div><div>[=
 =C2=A0 =C2=A01.251050] pci_bus 0000:0c: resource 0 [io =C2=A00xc000-0xcfff=
]</div><div>[ =C2=A0 =C2=A01.251051] pci_bus 0000:0c: resource 1 [mem 0xf9f=
00000-0xfbcfffff]</div><div>[ =C2=A0 =C2=A01.251052] pci_bus 0000:0c: resou=
rce 2 [mem 0xd6000000-0xdfffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.251=
053] pci_bus 0000:09: resource 0 [io =C2=A00xb000-0xbfff]</div><div>[ =C2=
=A0 =C2=A01.251054] pci_bus 0000:09: resource 1 [mem 0xf5f00000-0xf8ffffff]=
</div><div>[ =C2=A0 =C2=A01.251055] pci_bus 0000:09: resource 2 [mem 0xc000=
0000-0xcfffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.251056] pci_bus 0000=
:06: resource 0 [io =C2=A00xa000-0xafff]</div><div>[ =C2=A0 =C2=A01.251057]=
 pci_bus 0000:06: resource 1 [mem 0xf9e00000-0xf9efffff]</div><div>[ =C2=A0=
 =C2=A01.251058] pci_bus 0000:06: resource 2 [mem 0xf3f00000-0xf3ffffff 64b=
it pref]</div><div>[ =C2=A0 =C2=A01.251058] pci_bus 0000:05: resource 0 [io=
 =C2=A00x9000-0x9fff]</div><div>[ =C2=A0 =C2=A01.251059] pci_bus 0000:05: r=
esource 1 [mem 0xf9d00000-0xf9dfffff]</div><div>[ =C2=A0 =C2=A01.251060] pc=
i_bus 0000:05: resource 2 [mem 0xf3e00000-0xf3efffff 64bit pref]</div><div>=
[ =C2=A0 =C2=A01.251061] pci_bus 0000:04: resource 0 [io =C2=A00x8000-0x8ff=
f]</div><div>[ =C2=A0 =C2=A01.251062] pci_bus 0000:04: resource 1 [mem 0xf9=
c00000-0xf9cfffff]</div><div>[ =C2=A0 =C2=A01.251063] pci_bus 0000:04: reso=
urce 2 [mem 0xd0000000-0xd01fffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.25=
1064] pci_bus 0000:03: resource 0 [io =C2=A00x7000-0x7fff]</div><div>[ =C2=
=A0 =C2=A01.251065] pci_bus 0000:03: resource 1 [mem 0xf9b00000-0xf9bfffff]=
</div><div>[ =C2=A0 =C2=A01.251066] pci_bus 0000:03: resource 2 [mem 0xd020=
0000-0xd03fffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.251067] pci_bus 0000=
:02: resource 0 [io =C2=A00x1000-0x1fff]</div><div>[ =C2=A0 =C2=A01.251068]=
 pci_bus 0000:02: resource 1 [mem 0xf4000000-0xf5efffff]</div><div>[ =C2=A0=
 =C2=A01.251069] pci_bus 0000:02: resource 2 [mem 0xd0400000-0xd05fffff 64b=
it pref]</div><div>[ =C2=A0 =C2=A01.251070] pci_bus 0000:01: resource 4 [io=
 =C2=A00x0000-0x0cf7 window]</div><div>[ =C2=A0 =C2=A01.251071] pci_bus 000=
0:01: resource 5 [io =C2=A00x0d00-0xffff window]</div><div>[ =C2=A0 =C2=A01=
.251072] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff window]</di=
v><div>[ =C2=A0 =C2=A01.251073] pci_bus 0000:01: resource 7 [mem 0x000d0000=
-0x000dffff window]</div><div>[ =C2=A0 =C2=A01.251073] pci_bus 0000:01: res=
ource 8 [mem 0xc0000000-0xdfffffff window]</div><div>[ =C2=A0 =C2=A01.25107=
4] pci_bus 0000:01: resource 9 [mem 0xf0000000-0xfed8ffff window]</div><div=
>[ =C2=A0 =C2=A01.251077] pci_bus 0000:ff: resource 4 [io =C2=A00x0000-0xff=
ff]</div><div>[ =C2=A0 =C2=A01.251078] pci_bus 0000:ff: resource 5 [mem 0x0=
0000000-0xffffffffff]</div><div>[ =C2=A0 =C2=A01.251094] NET: Registered pr=
otocol family 2</div><div>[ =C2=A0 =C2=A01.251222] TCP established hash tab=
le entries: 131072 (order: 8, 1048576 bytes)</div><div>[ =C2=A0 =C2=A01.251=
386] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)</div><div=
>[ =C2=A0 =C2=A01.251483] TCP: Hash tables configured (established 131072 b=
ind 65536)</div><div>[ =C2=A0 =C2=A01.251507] UDP hash table entries: 8192 =
(order: 6, 262144 bytes)</div><div>[ =C2=A0 =C2=A01.251543] UDP-Lite hash t=
able entries: 8192 (order: 6, 262144 bytes)</div><div>[ =C2=A0 =C2=A01.2516=
05] NET: Registered protocol family 1</div><div>[ =C2=A0 =C2=A01.252637] pc=
i 0000:0c:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dfff=
f]</div><div>[ =C2=A0 =C2=A01.252672] PCI: CLS 256 bytes, default 64</div><=
div>[ =C2=A0 =C2=A01.252700] Unpacking initramfs...</div><div>[ =C2=A0 =C2=
=A01.289259] Freeing initrd memory: 4260K (ffff88003779e000 - ffff880037bc7=
000)</div><div>[ =C2=A0 =C2=A01.289271] DMAR: Host address width 39</div><d=
iv>[ =C2=A0 =C2=A01.289272] DMAR: DRHD base: 0x000000fbfff000 flags: 0x0</d=
iv><div>[ =C2=A0 =C2=A01.289282] DMAR: dmar0: reg_base_addr fbfff000 ver 1:=
0 cap c9008010e60262 ecap f020f2</div><div>[ =C2=A0 =C2=A01.289283] DMAR: D=
RHD base: 0x000000fbffe000 flags: 0x1</div><div>[ =C2=A0 =C2=A01.289287] DM=
AR: dmar1: reg_base_addr fbffe000 ver 1:0 cap c9078010ef0462 ecap f020f6</d=
iv><div>[ =C2=A0 =C2=A01.289288] DMAR: RMRR base: 0x000000000ec000 end: 0x0=
00000000f3fff</div><div>[ =C2=A0 =C2=A01.289289] DMAR: RMRR base: 0x000000b=
f7e8000 end: 0x000000bf7fffff</div><div>[ =C2=A0 =C2=A01.289290] DMAR: ATSR=
 flags: 0x0</div><div>[ =C2=A0 =C2=A01.289420] DMAR: dmar0: Using Queued in=
validation</div><div>[ =C2=A0 =C2=A01.289427] DMAR: dmar1: Using Queued inv=
alidation</div><div>[ =C2=A0 =C2=A01.289434] DMAR: Recommended TLB entries =
for ISOCH unit is 16; your BIOS set 20</div><div>[ =C2=A0 =C2=A01.289435] D=
MAR: Setting RMRR:</div><div>[ =C2=A0 =C2=A01.289449] DMAR: Setting identit=
y map for device 0000:00:1a.0 [0xbf7e8000 - 0xbf7fffff]</div><div>[ =C2=A0 =
=C2=A01.289468] DMAR: Setting identity map for device 0000:00:1a.1 [0xbf7e8=
000 - 0xbf7fffff]</div><div>[ =C2=A0 =C2=A01.289486] DMAR: Setting identity=
 map for device 0000:00:1a.2 [0xbf7e8000 - 0xbf7fffff]</div><div>[ =C2=A0 =
=C2=A01.289506] DMAR: Setting identity map for device 0000:00:1a.7 [0xbf7e8=
000 - 0xbf7fffff]</div><div>[ =C2=A0 =C2=A01.289524] DMAR: Setting identity=
 map for device 0000:00:1d.0 [0xbf7e8000 - 0xbf7fffff]</div><div>[ =C2=A0 =
=C2=A01.289542] DMAR: Setting identity map for device 0000:00:1d.1 [0xbf7e8=
000 - 0xbf7fffff]</div><div>[ =C2=A0 =C2=A01.289560] DMAR: Setting identity=
 map for device 0000:00:1d.2 [0xbf7e8000 - 0xbf7fffff]</div><div>[ =C2=A0 =
=C2=A01.289578] DMAR: Setting identity map for device 0000:00:1d.7 [0xbf7e8=
000 - 0xbf7fffff]</div><div>[ =C2=A0 =C2=A01.289589] DMAR: Setting identity=
 map for device 0000:00:1a.0 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01=
.289597] DMAR: Setting identity map for device 0000:00:1a.1 [0xec000 - 0xf3=
fff]</div><div>[ =C2=A0 =C2=A01.289605] DMAR: Setting identity map for devi=
ce 0000:00:1a.2 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01.289612] DMAR=
: Setting identity map for device 0000:00:1a.7 [0xec000 - 0xf3fff]</div><di=
v>[ =C2=A0 =C2=A01.289620] DMAR: Setting identity map for device 0000:00:1d=
.0 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01.289628] DMAR: Setting ide=
ntity map for device 0000:00:1d.1 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =
=C2=A01.289636] DMAR: Setting identity map for device 0000:00:1d.2 [0xec000=
 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01.289644] DMAR: Setting identity map f=
or device 0000:00:1d.7 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01.28965=
2] DMAR: Prepare 0-16MiB unity mapping for LPC</div><div>[ =C2=A0 =C2=A01.2=
89660] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]<=
/div><div>[ =C2=A0 =C2=A01.289768] DMAR: Intel(R) Virtualization Technology=
 for Directed I/O</div><div>[ =C2=A0 =C2=A01.289808] iommu: Adding device 0=
000:00:00.0 to group 0</div><div>[ =C2=A0 =C2=A01.289816] iommu: Adding dev=
ice 0000:00:01.0 to group 1</div><div>[ =C2=A0 =C2=A01.289825] iommu: Addin=
g device 0000:00:02.0 to group 2</div><div>[ =C2=A0 =C2=A01.289833] iommu: =
Adding device 0000:00:03.0 to group 3</div><div>[ =C2=A0 =C2=A01.289841] io=
mmu: Adding device 0000:00:05.0 to group 4</div><div>[ =C2=A0 =C2=A01.28984=
9] iommu: Adding device 0000:00:06.0 to group 5</div><div>[ =C2=A0 =C2=A01.=
289858] iommu: Adding device 0000:00:07.0 to group 6</div><div>[ =C2=A0 =C2=
=A01.289867] iommu: Adding device 0000:00:09.0 to group 7</div><div>[ =C2=
=A0 =C2=A01.289874] iommu: Adding device 0000:00:0a.0 to group 8</div><div>=
[ =C2=A0 =C2=A01.289901] iommu: Adding device 0000:00:14.0 to group 9</div>=
<div>[ =C2=A0 =C2=A01.289910] iommu: Adding device 0000:00:14.1 to group 9<=
/div><div>[ =C2=A0 =C2=A01.289919] iommu: Adding device 0000:00:14.2 to gro=
up 9</div><div>[ =C2=A0 =C2=A01.289928] iommu: Adding device 0000:00:14.3 t=
o group 9</div><div>[ =C2=A0 =C2=A01.289953] iommu: Adding device 0000:00:1=
a.0 to group 10</div><div>[ =C2=A0 =C2=A01.289961] iommu: Adding device 000=
0:00:1a.1 to group 10</div><div>[ =C2=A0 =C2=A01.289969] iommu: Adding devi=
ce 0000:00:1a.2 to group 10</div><div>[ =C2=A0 =C2=A01.289977] iommu: Addin=
g device 0000:00:1a.7 to group 10</div><div>[ =C2=A0 =C2=A01.289985] iommu:=
 Adding device 0000:00:1b.0 to group 11</div><div>[ =C2=A0 =C2=A01.290021] =
iommu: Adding device 0000:00:1c.0 to group 12</div><div>[ =C2=A0 =C2=A01.29=
0032] iommu: Adding device 0000:00:1c.1 to group 12</div><div>[ =C2=A0 =C2=
=A01.290043] iommu: Adding device 0000:00:1c.2 to group 12</div><div>[ =C2=
=A0 =C2=A01.290054] iommu: Adding device 0000:00:1c.3 to group 12</div><div=
>[ =C2=A0 =C2=A01.290065] iommu: Adding device 0000:00:1c.4 to group 12</di=
v><div>[ =C2=A0 =C2=A01.290090] iommu: Adding device 0000:00:1d.0 to group =
13</div><div>[ =C2=A0 =C2=A01.290099] iommu: Adding device 0000:00:1d.1 to =
group 13</div><div>[ =C2=A0 =C2=A01.290107] iommu: Adding device 0000:00:1d=
.2 to group 13</div><div>[ =C2=A0 =C2=A01.290116] iommu: Adding device 0000=
:00:1d.7 to group 13</div><div>[ =C2=A0 =C2=A01.290125] iommu: Adding devic=
e 0000:00:1e.0 to group 14</div><div>[ =C2=A0 =C2=A01.290145] iommu: Adding=
 device 0000:00:1f.0 to group 15</div><div>[ =C2=A0 =C2=A01.290155] iommu: =
Adding device 0000:00:1f.2 to group 15</div><div>[ =C2=A0 =C2=A01.290164] i=
ommu: Adding device 0000:00:1f.3 to group 15</div><div>[ =C2=A0 =C2=A01.290=
173] iommu: Adding device 0000:0e:00.0 to group 16</div><div>[ =C2=A0 =C2=
=A01.290184] iommu: Adding device 0000:0d:00.0 to group 17</div><div>[ =C2=
=A0 =C2=A01.290205] iommu: Adding device 0000:0c:00.0 to group 18</div><div=
>[ =C2=A0 =C2=A01.290218] iommu: Adding device 0000:0c:00.1 to group 18</di=
v><div>[ =C2=A0 =C2=A01.290228] iommu: Adding device 0000:09:00.0 to group =
19</div><div>[ =C2=A0 =C2=A01.290232] iommu: Adding device 0000:06:00.0 to =
group 12</div><div>[ =C2=A0 =C2=A01.290236] iommu: Adding device 0000:05:00=
.0 to group 12</div><div>[ =C2=A0 =C2=A01.290240] iommu: Adding device 0000=
:04:00.0 to group 12</div><div>[ =C2=A0 =C2=A01.290244] iommu: Adding devic=
e 0000:03:00.0 to group 12</div><div>[ =C2=A0 =C2=A01.290248] iommu: Adding=
 device 0000:02:00.0 to group 12</div><div>[ =C2=A0 =C2=A01.290265] iommu: =
Adding device 0000:ff:00.0 to group 20</div><div>[ =C2=A0 =C2=A01.290275] i=
ommu: Adding device 0000:ff:00.1 to group 20</div><div>[ =C2=A0 =C2=A01.290=
308] iommu: Adding device 0000:ff:02.0 to group 21</div><div>[ =C2=A0 =C2=
=A01.290318] iommu: Adding device 0000:ff:02.1 to group 21</div><div>[ =C2=
=A0 =C2=A01.290328] iommu: Adding device 0000:ff:02.2 to group 21</div><div=
>[ =C2=A0 =C2=A01.290337] iommu: Adding device 0000:ff:02.3 to group 21</di=
v><div>[ =C2=A0 =C2=A01.290347] iommu: Adding device 0000:ff:02.4 to group =
21</div><div>[ =C2=A0 =C2=A01.290357] iommu: Adding device 0000:ff:02.5 to =
group 21</div><div>[ =C2=A0 =C2=A01.290382] iommu: Adding device 0000:ff:03=
.0 to group 22</div><div>[ =C2=A0 =C2=A01.290392] iommu: Adding device 0000=
:ff:03.1 to group 22</div><div>[ =C2=A0 =C2=A01.290402] iommu: Adding devic=
e 0000:ff:03.2 to group 22</div><div>[ =C2=A0 =C2=A01.290413] iommu: Adding=
 device 0000:ff:03.4 to group 22</div><div>[ =C2=A0 =C2=A01.290437] iommu: =
Adding device 0000:ff:04.0 to group 23</div><div>[ =C2=A0 =C2=A01.290448] i=
ommu: Adding device 0000:ff:04.1 to group 23</div><div>[ =C2=A0 =C2=A01.290=
458] iommu: Adding device 0000:ff:04.2 to group 23</div><div>[ =C2=A0 =C2=
=A01.290469] iommu: Adding device 0000:ff:04.3 to group 23</div><div>[ =C2=
=A0 =C2=A01.290494] iommu: Adding device 0000:ff:05.0 to group 24</div><div=
>[ =C2=A0 =C2=A01.290505] iommu: Adding device 0000:ff:05.1 to group 24</di=
v><div>[ =C2=A0 =C2=A01.290515] iommu: Adding device 0000:ff:05.2 to group =
24</div><div>[ =C2=A0 =C2=A01.290526] iommu: Adding device 0000:ff:05.3 to =
group 24</div><div>[ =C2=A0 =C2=A01.290550] iommu: Adding device 0000:ff:06=
.0 to group 25</div><div>[ =C2=A0 =C2=A01.290561] iommu: Adding device 0000=
:ff:06.1 to group 25</div><div>[ =C2=A0 =C2=A01.290572] iommu: Adding devic=
e 0000:ff:06.2 to group 25</div><div>[ =C2=A0 =C2=A01.290585] iommu: Adding=
 device 0000:ff:06.3 to group 25</div><div>[ =C2=A0 =C2=A01.291620] Scannin=
g for low memory corruption every 60 seconds</div><div>[ =C2=A0 =C2=A01.291=
846] futex hash table entries: 4096 (order: 6, 262144 bytes)</div><div>[ =
=C2=A0 =C2=A01.292086] Initialise system trusted keyring</div><div>[ =C2=A0=
 =C2=A01.292188] workingset: timestamp_bits=3D38 max_order=3D22 bucket_orde=
r=3D0</div><div>[ =C2=A0 =C2=A01.293112] zbud: loaded</div><div>[ =C2=A0 =
=C2=A01.293257] Key type big_key registered</div><div>[ =C2=A0 =C2=A01.2934=
67] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)</d=
iv><div>[ =C2=A0 =C2=A01.293501] io scheduler noop registered</div><div>[ =
=C2=A0 =C2=A01.293503] io scheduler deadline registered</div><div>[ =C2=A0 =
=C2=A01.293522] io scheduler cfq registered (default)</div><div>[ =C2=A0 =
=C2=A01.294187] pcieport 0000:00:1c.4: enabling device (0106 -&gt; 0107)</d=
iv><div>[ =C2=A0 =C2=A01.294298] pci_hotplug: PCI Hot Plug PCI Core version=
: 0.5</div><div>[ =C2=A0 =C2=A01.294303] pciehp: PCI Express Hot Plug Contr=
oller Driver version: 0.4</div><div>[ =C2=A0 =C2=A01.294313] vesafb: mode i=
s 1280x1024x32, linelength=3D5120, pages=3D0</div><div>[ =C2=A0 =C2=A01.294=
313] vesafb: scrolling: redraw</div><div>[ =C2=A0 =C2=A01.294315] vesafb: T=
ruecolor: size=3D8:8:8:8, shift=3D24:16:8:0</div><div>[ =C2=A0 =C2=A01.2943=
25] vesafb: framebuffer at 0xd7000000, mapped to 0xffffc90002000000, using =
5120k, total 5120k</div><div>[ =C2=A0 =C2=A01.431634] Console: switching to=
 colour frame buffer device 160x64</div><div>[ =C2=A0 =C2=A01.568738] fb0: =
VESA VGA frame buffer device</div><div>[ =C2=A0 =C2=A01.568751] intel_idle:=
 MWAIT substates: 0x1120</div><div>[ =C2=A0 =C2=A01.568752] intel_idle: v0.=
4.1 model 0x2C</div><div>[ =C2=A0 =C2=A01.568968] intel_idle: lapic_timer_r=
eliable_states 0xffffffff</div><div>[ =C2=A0 =C2=A01.569119] GHES: HEST is =
not enabled!</div><div>[ =C2=A0 =C2=A01.569162] Serial: 8250/16550 driver, =
4 ports, IRQ sharing disabled</div><div>[ =C2=A0 =C2=A01.569407] Linux agpg=
art interface v0.103</div><div>[ =C2=A0 =C2=A01.569925] rtc_cmos 00:01: RTC=
 can wake from S4</div><div>[ =C2=A0 =C2=A01.570012] rtc_cmos 00:01: rtc co=
re: registered rtc_cmos as rtc0</div><div>[ =C2=A0 =C2=A01.570031] rtc_cmos=
 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs</div><div>[=
 =C2=A0 =C2=A01.570040] ledtrig-cpu: registered to indicate activity on CPU=
s</div><div>[ =C2=A0 =C2=A01.570284] NET: Registered protocol family 10</di=
v><div>[ =C2=A0 =C2=A01.570432] NET: Registered protocol family 17</div><di=
v>[ =C2=A0 =C2=A01.570687] microcode: CPU0 sig=3D0x206c2, pf=3D0x1, revisio=
n=3D0x13</div><div>[ =C2=A0 =C2=A01.570729] microcode: CPU1 sig=3D0x206c2, =
pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.570735] microcode: CPU=
2 sig=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.57075=
8] microcode: CPU3 sig=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=
=A0 =C2=A01.570800] microcode: CPU4 sig=3D0x206c2, pf=3D0x1, revision=3D0x1=
3</div><div>[ =C2=A0 =C2=A01.570845] microcode: CPU5 sig=3D0x206c2, pf=3D0x=
1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.570877] microcode: CPU6 sig=
=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.570909] mi=
crocode: CPU7 sig=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =
=C2=A01.570911] microcode: CPU8 sig=3D0x206c2, pf=3D0x1, revision=3D0x13</d=
iv><div>[ =C2=A0 =C2=A01.570937] microcode: CPU9 sig=3D0x206c2, pf=3D0x1, r=
evision=3D0x13</div><div>[ =C2=A0 =C2=A01.570980] microcode: CPU10 sig=3D0x=
206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.571013] microco=
de: CPU11 sig=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=
=A01.571065] microcode: Microcode Update Driver: v2.01 &lt;<a href=3D"mailt=
o:tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org" target=3D"_blank">tigran-ppwZ4lME3+KI6QP4U9MhSUkxwOvcTxT8@public.gmane.org=
k</a>&gt;, Peter Oruba</div><div>[ =C2=A0 =C2=A01.571182] registered taskst=
ats version 1</div><div>[ =C2=A0 =C2=A01.571189] Loading compiled-in X.509 =
certificates</div><div>[ =C2=A0 =C2=A01.571203] zswap: loaded using pool lz=
o/zbud</div><div>[ =C2=A0 =C2=A01.571782] =C2=A0 Magic number: 12:303:328</=
div><div>[ =C2=A0 =C2=A01.572148] rtc_cmos 00:01: setting system clock to 2=
016-04-25 11:20:20 UTC (1461583220)</div><div>[ =C2=A0 =C2=A01.572176] PM: =
Hibernation image not present or could not be loaded.</div><div>[ =C2=A0 =
=C2=A01.573427] Freeing unused kernel memory: 1224K (ffffffff818f5000 - fff=
fffff81a27000)</div><div>[ =C2=A0 =C2=A01.573428] Write protecting the kern=
el read-only data: 8192k</div><div>[ =C2=A0 =C2=A01.574235] Freeing unused =
kernel memory: 200K (ffff8800015ce000 - ffff880001600000)</div><div>[ =C2=
=A0 =C2=A01.575136] Freeing unused kernel memory: 248K (ffff8800017c2000 - =
ffff880001800000)</div><div>[ =C2=A0 =C2=A01.579510] random: systemd-tmpfil=
e urandom read with 1 bits of entropy available</div><div>[ =C2=A0 =C2=A01.=
599421] i8042: PNP: No PS/2 controller found. Probing ports directly.</div>=
<div>[ =C2=A0 =C2=A01.599752] serio: i8042 KBD port at 0x60,0x64 irq 1</div=
><div>[ =C2=A0 =C2=A01.599774] serio: i8042 AUX port at 0x60,0x64 irq 12</d=
iv><div>[ =C2=A0 =C2=A01.603040] ACPI: bus type USB registered</div><div>[ =
=C2=A0 =C2=A01.603061] usbcore: registered new interface driver usbfs</div>=
<div>[ =C2=A0 =C2=A01.603070] usbcore: registered new interface driver hub<=
/div><div>[ =C2=A0 =C2=A01.603071] SCSI subsystem initialized</div><div>[ =
=C2=A0 =C2=A01.603109] usbcore: registered new device driver usb</div><div>=
[ =C2=A0 =C2=A01.603545] ehci_hcd: USB 2.0 &#39;Enhanced&#39; Host Controll=
er (EHCI) Driver</div><div>[ =C2=A0 =C2=A01.604018] ehci-pci: EHCI PCI plat=
form driver</div><div>[ =C2=A0 =C2=A01.604171] ehci-pci 0000:00:1a.7: EHCI =
Host Controller</div><div>[ =C2=A0 =C2=A01.604175] ehci-pci 0000:00:1a.7: n=
ew USB bus registered, assigned bus number 1</div><div>[ =C2=A0 =C2=A01.604=
188] ehci-pci 0000:00:1a.7: debug port 1</div><div>[ =C2=A0 =C2=A01.604283]=
 uhci_hcd: USB Universal Host Controller Interface driver</div><div>[ =C2=
=A0 =C2=A01.605330] libata version 3.00 loaded.</div><div>[ =C2=A0 =C2=A01.=
608100] ehci-pci 0000:00:1a.7: cache line size of 256 is not supported</div=
><div>[ =C2=A0 =C2=A01.608104] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9af=
8000</div><div>[ =C2=A0 =C2=A01.617951] ehci-pci 0000:00:1a.7: USB 2.0 star=
ted, EHCI 1.00</div><div>[ =C2=A0 =C2=A01.618056] hub 1-0:1.0: USB hub foun=
d</div><div>[ =C2=A0 =C2=A01.618061] hub 1-0:1.0: 6 ports detected</div><di=
v>[ =C2=A0 =C2=A01.618162] xhci_hcd 0000:0e:00.0: xHCI Host Controller</div=
><div>[ =C2=A0 =C2=A01.618168] xhci_hcd 0000:0e:00.0: new USB bus registere=
d, assigned bus number 2</div><div>[ =C2=A0 =C2=A01.618304] xhci_hcd 0000:0=
e:00.0: hcc params 0x014042cb hci version 0x96 quirks 0x00000004</div><div>=
[ =C2=A0 =C2=A01.618533] hub 2-0:1.0: USB hub found</div><div>[ =C2=A0 =C2=
=A01.618538] hub 2-0:1.0: 2 ports detected</div><div>[ =C2=A0 =C2=A01.61859=
3] xhci_hcd 0000:0e:00.0: xHCI Host Controller</div><div>[ =C2=A0 =C2=A01.6=
18596] xhci_hcd 0000:0e:00.0: new USB bus registered, assigned bus number 3=
</div><div>[ =C2=A0 =C2=A01.618606] ehci-pci 0000:00:1d.7: EHCI Host Contro=
ller</div><div>[ =C2=A0 =C2=A01.618611] ehci-pci 0000:00:1d.7: new USB bus =
registered, assigned bus number 4</div><div>[ =C2=A0 =C2=A01.618620] ehci-p=
ci 0000:00:1d.7: debug port 1</div><div>[ =C2=A0 =C2=A01.621645] usb usb3: =
We don&#39;t know the algorithms for LPM for this host, disabling LPM.</div=
><div>[ =C2=A0 =C2=A01.621735] hub 3-0:1.0: USB hub found</div><div>[ =C2=
=A0 =C2=A01.621745] hub 3-0:1.0: 2 ports detected</div><div>[ =C2=A0 =C2=A0=
1.622536] ehci-pci 0000:00:1d.7: cache line size of 256 is not supported</d=
iv><div>[ =C2=A0 =C2=A01.622544] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9=
afa000</div><div>[ =C2=A0 =C2=A01.634695] ehci-pci 0000:00:1d.7: USB 2.0 st=
arted, EHCI 1.00</div><div>[ =C2=A0 =C2=A01.634805] hub 4-0:1.0: USB hub fo=
und</div><div>[ =C2=A0 =C2=A01.634809] hub 4-0:1.0: 6 ports detected</div><=
div>[ =C2=A0 =C2=A01.635019] uhci_hcd 0000:00:1a.0: UHCI Host Controller</d=
iv><div>[ =C2=A0 =C2=A01.635024] uhci_hcd 0000:00:1a.0: new USB bus registe=
red, assigned bus number 5</div><div>[ =C2=A0 =C2=A01.635029] uhci_hcd 0000=
:00:1a.0: detected 2 ports</div><div>[ =C2=A0 =C2=A01.635048] uhci_hcd 0000=
:00:1a.0: irq 16, io base 0x00005400</div><div>[ =C2=A0 =C2=A01.635164] hub=
 5-0:1.0: USB hub found</div><div>[ =C2=A0 =C2=A01.635170] hub 5-0:1.0: 2 p=
orts detected</div><div>[ =C2=A0 =C2=A01.635325] uhci_hcd 0000:00:1a.1: UHC=
I Host Controller</div><div>[ =C2=A0 =C2=A01.635329] uhci_hcd 0000:00:1a.1:=
 new USB bus registered, assigned bus number 6</div><div>[ =C2=A0 =C2=A01.6=
35334] uhci_hcd 0000:00:1a.1: detected 2 ports</div><div>[ =C2=A0 =C2=A01.6=
35352] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00005480</div><div>[ =C2=A0=
 =C2=A01.635464] hub 6-0:1.0: USB hub found</div><div>[ =C2=A0 =C2=A01.6354=
70] hub 6-0:1.0: 2 ports detected</div><div>[ =C2=A0 =C2=A01.635601] uhci_h=
cd 0000:00:1a.2: UHCI Host Controller</div><div>[ =C2=A0 =C2=A01.635606] uh=
ci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 7</div><di=
v>[ =C2=A0 =C2=A01.635610] uhci_hcd 0000:00:1a.2: detected 2 ports</div><di=
v>[ =C2=A0 =C2=A01.635628] uhci_hcd 0000:00:1a.2: irq 19, io base 0x0000580=
0</div><div>[ =C2=A0 =C2=A01.635739] hub 7-0:1.0: USB hub found</div><div>[=
 =C2=A0 =C2=A01.635745] hub 7-0:1.0: 2 ports detected</div><div>[ =C2=A0 =
=C2=A01.635863] uhci_hcd 0000:00:1d.0: UHCI Host Controller</div><div>[ =C2=
=A0 =C2=A01.635867] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned=
 bus number 8</div><div>[ =C2=A0 =C2=A01.635871] uhci_hcd 0000:00:1d.0: det=
ected 2 ports</div><div>[ =C2=A0 =C2=A01.635885] uhci_hcd 0000:00:1d.0: irq=
 23, io base 0x00005880</div><div>[ =C2=A0 =C2=A01.636012] hub 8-0:1.0: USB=
 hub found</div><div>[ =C2=A0 =C2=A01.636017] hub 8-0:1.0: 2 ports detected=
</div><div>[ =C2=A0 =C2=A01.636135] uhci_hcd 0000:00:1d.1: UHCI Host Contro=
ller</div><div>[ =C2=A0 =C2=A01.636139] uhci_hcd 0000:00:1d.1: new USB bus =
registered, assigned bus number 9</div><div>[ =C2=A0 =C2=A01.636143] uhci_h=
cd 0000:00:1d.1: detected 2 ports</div><div>[ =C2=A0 =C2=A01.636158] uhci_h=
cd 0000:00:1d.1: irq 19, io base 0x00005c00</div><div>[ =C2=A0 =C2=A01.6362=
97] hub 9-0:1.0: USB hub found</div><div>[ =C2=A0 =C2=A01.636302] hub 9-0:1=
.0: 2 ports detected</div><div>[ =C2=A0 =C2=A01.636422] uhci_hcd 0000:00:1d=
.2: UHCI Host Controller</div><div>[ =C2=A0 =C2=A01.636425] uhci_hcd 0000:0=
0:1d.2: new USB bus registered, assigned bus number 10</div><div>[ =C2=A0 =
=C2=A01.636429] uhci_hcd 0000:00:1d.2: detected 2 ports</div><div>[ =C2=A0 =
=C2=A01.636445] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00006000</div><div=
>[ =C2=A0 =C2=A01.636603] hub 10-0:1.0: USB hub found</div><div>[ =C2=A0 =
=C2=A01.636609] hub 10-0:1.0: 2 ports detected</div><div>[ =C2=A0 =C2=A01.6=
36670] ahci 0000:00:1f.2: version 3.0</div><div>[ =C2=A0 =C2=A01.636792] ah=
ci 0000:00:1f.2: SSS flag set, parallel bus scan disabled</div><div>[ =C2=
=A0 =C2=A01.636829] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gb=
ps 0x3f impl SATA mode</div><div>[ =C2=A0 =C2=A01.636831] ahci 0000:00:1f.2=
: flags: 64bit ncq sntf stag pm led clo pio slum part ccc ems sxs=C2=A0</di=
v><div>[ =C2=A0 =C2=A01.658051] firewire_ohci 0000:04:00.0: added OHCI v1.1=
0 device as card 0, 4 IR + 8 IT contexts, quirks 0x10</div><div>[ =C2=A0 =
=C2=A01.668325] scsi host0: ahci</div><div>[ =C2=A0 =C2=A01.668501] scsi ho=
st1: ahci</div><div>[ =C2=A0 =C2=A01.668706] scsi host2: ahci</div><div>[ =
=C2=A0 =C2=A01.668828] scsi host3: ahci</div><div>[ =C2=A0 =C2=A01.668972] =
scsi host4: ahci</div><div>[ =C2=A0 =C2=A01.669119] scsi host5: ahci</div><=
div>[ =C2=A0 =C2=A01.669155] ata1: SATA max UDMA/133 abar m2048@0xf9afc000 =
port 0xf9afc100 irq 39</div><div>[ =C2=A0 =C2=A01.669156] ata2: SATA max UD=
MA/133 abar m2048@0xf9afc000 port 0xf9afc180 irq 39</div><div>[ =C2=A0 =C2=
=A01.669158] ata3: SATA max UDMA/133 abar m2048@0xf9afc000 port 0xf9afc200 =
irq 39</div><div>[ =C2=A0 =C2=A01.669159] ata4: SATA max UDMA/133 abar m204=
8@0xf9afc000 port 0xf9afc280 irq 39</div><div>[ =C2=A0 =C2=A01.669160] ata5=
: SATA max UDMA/133 abar m2048@0xf9afc000 port 0xf9afc300 irq 39</div><div>=
[ =C2=A0 =C2=A01.669161] ata6: SATA max UDMA/133 abar m2048@0xf9afc000 port=
 0xf9afc380 irq 39</div><div>[ =C2=A0 =C2=A01.669198] ahci 0000:0d:00.0: co=
ntroller can do FBS, turning on CAP_FBS</div><div>[ =C2=A0 =C2=A01.679340] =
ahci 0000:0d:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0xff impl SATA mo=
de</div><div>[ =C2=A0 =C2=A01.679342] ahci 0000:0d:00.0: flags: 64bit ncq f=
bs pio=C2=A0</div><div>[ =C2=A0 =C2=A01.679933] scsi host6: ahci</div><div>=
[ =C2=A0 =C2=A01.680082] scsi host7: ahci</div><div>[ =C2=A0 =C2=A01.680264=
] scsi host8: ahci</div><div>[ =C2=A0 =C2=A01.680367] scsi host9: ahci</div=
><div>[ =C2=A0 =C2=A01.680484] scsi host10: ahci</div><div>[ =C2=A0 =C2=A01=
.680623] scsi host11: ahci</div><div>[ =C2=A0 =C2=A01.680719] scsi host12: =
ahci</div><div>[ =C2=A0 =C2=A01.680824] scsi host13: ahci</div><div>[ =C2=
=A0 =C2=A01.680859] ata7: SATA max UDMA/133 abar m2048@0xfbddf800 port 0xfb=
ddf900 irq 40</div><div>[ =C2=A0 =C2=A01.680861] ata8: SATA max UDMA/133 ab=
ar m2048@0xfbddf800 port 0xfbddf980 irq 40</div><div>[ =C2=A0 =C2=A01.68086=
2] ata9: SATA max UDMA/133 abar m2048@0xfbddf800 port 0xfbddfa00 irq 40</di=
v><div>[ =C2=A0 =C2=A01.680863] ata10: SATA max UDMA/133 abar m2048@0xfbddf=
800 port 0xfbddfa80 irq 40</div><div>[ =C2=A0 =C2=A01.680864] ata11: SATA m=
ax UDMA/133 abar m2048@0xfbddf800 port 0xfbddfb00 irq 40</div><div>[ =C2=A0=
 =C2=A01.680866] ata12: SATA max UDMA/133 abar m2048@0xfbddf800 port 0xfbdd=
fb80 irq 40</div><div>[ =C2=A0 =C2=A01.680867] ata13: SATA max UDMA/133 aba=
r m2048@0xfbddf800 port 0xfbddfc00 irq 40</div><div>[ =C2=A0 =C2=A01.680868=
] ata14: SATA max UDMA/133 abar m2048@0xfbddf800 port 0xfbddfc80 irq 40</di=
v><div>[ =C2=A0 =C2=A01.680959] ahci 0000:03:00.0: AHCI 0001.0100 32 slots =
2 ports 3 Gbps 0x3 impl SATA mode</div><div>[ =C2=A0 =C2=A01.680960] ahci 0=
000:03:00.0: flags: 64bit ncq led clo pmp pio=C2=A0</div><div>[ =C2=A0 =C2=
=A01.681169] scsi host14: ahci</div><div>[ =C2=A0 =C2=A01.681241] scsi host=
15: ahci</div><div>[ =C2=A0 =C2=A01.681282] ata15: SATA max UDMA/133 abar m=
512@0xf9bffc00 port 0xf9bffd00 irq 19</div><div>[ =C2=A0 =C2=A01.681285] at=
a16: SATA max UDMA/133 abar m512@0xf9bffc00 port 0xf9bffd80 irq 19</div><di=
v>[ =C2=A0 =C2=A01.978532] ata1: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)</div><div>[ =C2=A0 =C2=A01.979732] ata1.00: ATA-8: ST31000524AS, JC4=
5, max UDMA/133</div><div>[ =C2=A0 =C2=A01.979735] ata1.00: <a href=3D"tel:=
1953525168" value=3D"+911953525168" target=3D"_blank">1953525168</a> sector=
s, multi 0: LBA48 NCQ (depth 31/32)</div><div>[ =C2=A0 =C2=A01.981148] ata1=
.00: configured for UDMA/133</div><div>[ =C2=A0 =C2=A01.981411] scsi 0:0:0:=
0: Direct-Access =C2=A0 =C2=A0 ATA =C2=A0 =C2=A0 =C2=A0ST31000524AS =C2=A0 =
=C2=A0 JC45 PQ: 0 ANSI: 5</div><div>[ =C2=A0 =C2=A01.991794] ata11: SATA li=
nk down (SStatus 0 SControl 300)</div><div>[ =C2=A0 =C2=A01.991813] ata14: =
SATA link up 1.5 Gbps (SStatus 113 SControl 300)</div><div>[ =C2=A0 =C2=A01=
.991830] ata9: SATA link down (SStatus 0 SControl 300)</div><div>[ =C2=A0 =
=C2=A01.991847] ata12: SATA link down (SStatus 0 SControl 300)</div><div>[ =
=C2=A0 =C2=A01.991871] ata10: SATA link down (SStatus 0 SControl 300)</div>=
<div>[ =C2=A0 =C2=A01.991881] ata16: SATA link down (SStatus 0 SControl 300=
)</div><div>[ =C2=A0 =C2=A01.992108] ata15: SATA link down (SStatus 0 SCont=
rol 300)</div><div>[ =C2=A0 =C2=A01.992122] ata13: SATA link down (SStatus =
0 SControl 300)</div><div>[ =C2=A0 =C2=A01.992140] ata8: SATA link up 6.0 G=
bps (SStatus 133 SControl 300)</div><div>[ =C2=A0 =C2=A02.100542] ata14.00:=
 ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66</div><div>[ =C2=A0 =C2=A02.1007=
54] ata14.00: configured for UDMA/66</div><div>[ =C2=A0 =C2=A02.102002] ata=
8.00: ATA-9: INTEL SSDSC2BW180A3H, LCSi, max UDMA/133</div><div>[ =C2=A0 =
=C2=A02.102005] ata8.00: 351651888 sectors, multi 16: LBA48 NCQ (depth 31/3=
2), AA</div><div>[ =C2=A0 =C2=A02.111976] ata8.00: configured for UDMA/133<=
/div><div>[ =C2=A0 =C2=A02.121333] usb 8-1: new full-speed USB device numbe=
r 2 using uhci_hcd</div><div>[ =C2=A0 =C2=A02.151338] ata7: SATA link up 6.=
0 Gbps (SStatus 133 SControl 300)</div><div>[ =C2=A0 =C2=A02.158321] firewi=
re_core 0000:04:00.0: created device fw0: GUID 0010dc0001c88900, S400</div>=
<div>[ =C2=A0 =C2=A02.162537] ata7.00: ATA-9: INTEL SSDSC2CT180A3, 300i, ma=
x UDMA/133</div><div>[ =C2=A0 =C2=A02.162540] ata7.00: 351651888 sectors, m=
ulti 16: LBA48 NCQ (depth 31/32), AA</div><div>[ =C2=A0 =C2=A02.172515] ata=
7.00: configured for UDMA/133</div><div>[ =C2=A0 =C2=A02.197996] usb 4-4: n=
ew high-speed USB device number 3 using ehci-pci</div><div>[ =C2=A0 =C2=A02=
.297979] tsc: Refined TSC clocksource calibration: 4399.972 MHz</div><div>[=
 =C2=A0 =C2=A02.297983] clocksource: tsc: mask: 0xffffffffffffffff max_cycl=
es: 0x3f6c4aff662, max_idle_ns: 440795220849 ns</div><div>[ =C2=A0 =C2=A02.=
318379] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)</div><div>[ =
=C2=A0 =C2=A02.319174] ata2.00: ATA-9: ST1000DM003-1CH162, CC47, max UDMA/1=
33</div><div>[ =C2=A0 =C2=A02.319176] ata2.00: <a href=3D"tel:1953525168" v=
alue=3D"+911953525168" target=3D"_blank">1953525168</a> sectors, multi 0: L=
BA48 NCQ (depth 31/32), AA</div><div>[ =C2=A0 =C2=A02.320042] ata2.00: conf=
igured for UDMA/133</div><div>[ =C2=A0 =C2=A02.320416] scsi 1:0:0:0: Direct=
-Access =C2=A0 =C2=A0 ATA =C2=A0 =C2=A0 =C2=A0ST1000DM003-1CH1 CC47 PQ: 0 A=
NSI: 5</div><div>[ =C2=A0 =C2=A02.325174] usb-storage 4-4:1.0: USB Mass Sto=
rage device detected</div><div>[ =C2=A0 =C2=A02.325337] scsi host16: usb-st=
orage 4-4:1.0</div><div>[ =C2=A0 =C2=A02.325376] usbcore: registered new in=
terface driver usb-storage</div><div>[ =C2=A0 =C2=A02.325749] usbcore: regi=
stered new interface driver uas</div><div>[ =C2=A0 =C2=A02.608015] usb 10-1=
: new full-speed USB device number 2 using uhci_hcd</div><div>[ =C2=A0 =C2=
=A02.665289] ata3: SATA link down (SStatus 0 SControl 300)</div><div>[ =C2=
=A0 =C2=A02.788083] hidraw: raw HID events driver (C) Jiri Kosina</div><div=
>[ =C2=A0 =C2=A02.794165] usbcore: registered new interface driver usbhid</=
div><div>[ =C2=A0 =C2=A02.794167] usbhid: USB HID core driver</div><div>[ =
=C2=A0 =C2=A02.796080] input: DEXIN Corp. Tt eSPORTS BLACK Element as /devi=
ces/pci0000:00/0000:00:1d.2/usb10/10-1/10-1:1.0/0003:12CF:0182.0001/input/i=
nput2</div><div>[ =C2=A0 =C2=A02.796140] hid-generic 0003:12CF:0182.0001: i=
nput,hidraw0: USB HID v1.11 Mouse [DEXIN Corp. Tt eSPORTS BLACK Element] on=
 usb-0000:00:1d.2-1/input0</div><div>[ =C2=A0 =C2=A02.796269] input: DEXIN =
Corp. Tt eSPORTS BLACK Element as /devices/pci0000:00/0000:00:1d.2/usb10/10=
-1/10-1:1.1/0003:12CF:0182.0002/input/input3</div><div>[ =C2=A0 =C2=A02.848=
034] hid-generic 0003:12CF:0182.0002: input,hidraw1: USB HID v1.11 Keyboard=
 [DEXIN Corp. Tt eSPORTS BLACK Element] on usb-0000:00:1d.2-1/input1</div><=
div>[ =C2=A0 =C2=A02.975134] ata4: SATA link down (SStatus 0 SControl 300)<=
/div><div>[ =C2=A0 =C2=A03.214692] usb 10-2: new low-speed USB device numbe=
r 3 using uhci_hcd</div><div>[ =C2=A0 =C2=A03.285142] ata5: SATA link down =
(SStatus 0 SControl 300)</div><div>[ =C2=A0 =C2=A03.294919] clocksource: Sw=
itched to clocksource tsc</div><div>[ =C2=A0 =C2=A03.333614] scsi 16:0:0:0:=
 Direct-Access =C2=A0 =C2=A0 WD =C2=A0 =C2=A0 =C2=A0 Ext HDD 1021 =C2=A0 =
=C2=A0 2002 PQ: 0 ANSI: 4</div><div>[ =C2=A0 =C2=A03.335607] sd 0:0:0:0: [s=
da] <a href=3D"tel:1953525168" value=3D"+911953525168" target=3D"_blank">19=
53525168</a> 512-byte logical blocks: (1.00 TB/932 GiB)</div><div>[ =C2=A0 =
=C2=A03.335631] sd 1:0:0:0: [sdb] <a href=3D"tel:1953525168" value=3D"+9119=
53525168" target=3D"_blank">1953525168</a> 512-byte logical blocks: (1.00 T=
B/932 GiB)</div><div>[ =C2=A0 =C2=A03.335632] sd 1:0:0:0: [sdb] 4096-byte p=
hysical blocks</div><div>[ =C2=A0 =C2=A03.335675] sd 0:0:0:0: [sda] Write P=
rotect is off</div><div>[ =C2=A0 =C2=A03.335677] sd 0:0:0:0: [sda] Mode Sen=
se: 00 3a 00 00</div><div>[ =C2=A0 =C2=A03.335694] sd 0:0:0:0: [sda] Write =
cache: enabled, read cache: enabled, doesn&#39;t support DPO or FUA</div><d=
iv>[ =C2=A0 =C2=A03.335712] sd 1:0:0:0: [sdb] Write Protect is off</div><di=
v>[ =C2=A0 =C2=A03.335714] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00</div><=
div>[ =C2=A0 =C2=A03.335729] sd 1:0:0:0: [sdb] Write cache: enabled, read c=
ache: enabled, doesn&#39;t support DPO or FUA</div><div>[ =C2=A0 =C2=A03.33=
6265] sd 16:0:0:0: [sdc] <a href=3D"tel:1953519616" value=3D"+911953519616"=
 target=3D"_blank">1953519616</a> 512-byte logical blocks: (1.00 TB/932 GiB=
)</div><div>[ =C2=A0 =C2=A03.337291] sd 16:0:0:0: [sdc] Test WP failed, ass=
ume Write Enabled</div><div>[ =C2=A0 =C2=A03.338337] sd 16:0:0:0: [sdc] Ask=
ing for cache data failed</div><div>[ =C2=A0 =C2=A03.339198] sd 16:0:0:0: [=
sdc] Assuming drive cache: write through</div><div>[ =C2=A0 =C2=A03.351235]=
 =C2=A0sda: sda1 sda2</div><div>[ =C2=A0 =C2=A03.351591] sd 0:0:0:0: [sda] =
Attached SCSI disk</div><div>[ =C2=A0 =C2=A03.353383] =C2=A0sdb: sdb2</div>=
<div>[ =C2=A0 =C2=A03.353844] sd 1:0:0:0: [sdb] Attached SCSI disk</div><di=
v>[ =C2=A0 =C2=A03.595059] ata6: SATA link down (SStatus 0 SControl 300)</d=
iv><div>[ =C2=A0 =C2=A03.595498] scsi 6:0:0:0: Direct-Access =C2=A0 =C2=A0 =
ATA =C2=A0 =C2=A0 =C2=A0INTEL SSDSC2CT18 300i PQ: 0 ANSI: 5</div><div>[ =C2=
=A0 =C2=A03.628268] sd 6:0:0:0: [sdd] 351651888 512-byte logical blocks: (1=
80 GB/168 GiB)</div><div>[ =C2=A0 =C2=A03.628445] scsi 7:0:0:0: Direct-Acce=
ss =C2=A0 =C2=A0 ATA =C2=A0 =C2=A0 =C2=A0INTEL SSDSC2BW18 LCSi PQ: 0 ANSI: =
5</div><div>[ =C2=A0 =C2=A03.628565] sd 6:0:0:0: [sdd] Write Protect is off=
</div><div>[ =C2=A0 =C2=A03.628569] sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 =
00</div><div>[ =C2=A0 =C2=A03.628650] sd 6:0:0:0: [sdd] Write cache: enable=
d, read cache: enabled, doesn&#39;t support DPO or FUA</div><div>[ =C2=A0 =
=C2=A03.630443] =C2=A0sdd: sdd1 sdd2</div><div>[ =C2=A0 =C2=A03.630815] sd =
6:0:0:0: [sdd] Attached SCSI disk</div><div>[ =C2=A0 =C2=A03.633258] input:=
 HID 04d9:1203 as /devices/pci0000:00/0000:00:1d.2/usb10/10-2/10-2:1.0/0003=
:04D9:1203.0003/input/input4</div><div>[ =C2=A0 =C2=A03.654811] sd 7:0:0:0:=
 [sde] 351651888 512-byte logical blocks: (180 GB/168 GiB)</div><div>[ =C2=
=A0 =C2=A03.654932] sd 7:0:0:0: [sde] Write Protect is off</div><div>[ =C2=
=A0 =C2=A03.654934] sd 7:0:0:0: [sde] Mode Sense: 00 3a 00 00</div><div>[ =
=C2=A0 =C2=A03.654954] scsi 13:0:0:0: Processor =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Marvell =C2=A091xx Config =C2=A0 =C2=A0 =C2=A01.01 PQ: 0 ANSI: 5</div><div=
>[ =C2=A0 =C2=A03.654978] sd 7:0:0:0: [sde] Write cache: enabled, read cach=
e: enabled, doesn&#39;t support DPO or FUA</div><div>[ =C2=A0 =C2=A03.65657=
2] =C2=A0sde: sde1</div><div>[ =C2=A0 =C2=A03.656783] sd 7:0:0:0: [sde] Att=
ached SCSI disk</div><div>[ =C2=A0 =C2=A03.684842] hid-generic 0003:04D9:12=
03.0003: input,hidraw2: USB HID v1.11 Keyboard [HID 04d9:1203] on usb-0000:=
00:1d.2-2/input0</div><div>[ =C2=A0 =C2=A03.741441] input: HID 04d9:1203 as=
 /devices/pci0000:00/0000:00:1d.2/usb10/10-2/10-2:1.1/0003:04D9:1203.0004/i=
nput/input5</div><div>[ =C2=A0 =C2=A03.758750] =C2=A0sdc: sdc1</div><div>[ =
=C2=A0 =C2=A03.762344] sd 16:0:0:0: [sdc] Attached SCSI disk</div><div>[ =
=C2=A0 =C2=A03.798096] hid-generic 0003:04D9:1203.0004: input,hidraw3: USB =
HID v1.11 Device [HID 04d9:1203] on usb-0000:00:1d.2-2/input1</div><div>[ =
=C2=A0 =C2=A04.247409] EXT4-fs (sdd1): mounted filesystem with ordered data=
 mode. Opts: (null)</div><div>[ =C2=A0 =C2=A04.731108] ip_tables: (C) 2000-=
2006 Netfilter Core Team</div><div>[ =C2=A0 =C2=A04.752924] systemd[1]: sys=
temd 229 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMAC=
K -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BL=
KID +ELFUTILS +KMOD +IDN)</div><div>[ =C2=A0 =C2=A04.753057] systemd[1]: De=
tected architecture x86-64.</div><div>[ =C2=A0 =C2=A04.754040] systemd[1]: =
Set hostname to &lt;ScaRage&gt;.</div><div>[ =C2=A0 =C2=A05.298401] systemd=
[1]: Started Forward Password Requests to Wall Directory Watch.</div><div>[=
 =C2=A0 =C2=A05.301761] systemd[1]: Listening on udev Control Socket.</div>=
<div>[ =C2=A0 =C2=A05.301773] systemd[1]: Reached target Encrypted Volumes.=
</div><div>[ =C2=A0 =C2=A05.301783] systemd[1]: Reached target Login Prompt=
s.</div><div>[ =C2=A0 =C2=A05.301805] systemd[1]: Listening on LVM2 metadat=
a daemon socket.</div><div>[ =C2=A0 =C2=A05.301816] systemd[1]: Listening o=
n udev Kernel Socket.</div><div>[ =C2=A0 =C2=A05.301837] systemd[1]: Listen=
ing on Journal Socket.</div><div>[ =C2=A0 =C2=A05.301846] systemd[1]: Reach=
ed target Remote File Systems.</div><div>[ =C2=A0 =C2=A05.301859] systemd[1=
]: Listening on Journal Socket (/dev/log).</div><div>[ =C2=A0 =C2=A05.30233=
1] systemd[1]: Listening on Process Core Dump Socket.</div><div>[ =C2=A0 =
=C2=A05.302494] systemd[1]: Created slice User and Session Slice.</div><div=
>[ =C2=A0 =C2=A05.302513] systemd[1]: Listening on Device-mapper event daem=
on FIF</div></div></div><div class=3D"gmail_extra"><div><div class=3D"h5"><=
br><div class=3D"gmail_quote">On Mon, Apr 25, 2016 at 3:01 PM, Joerg Roedel=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" target=3D"_blank"=
>joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><s=
pan>On Mon, Apr 25, 2016 at 07:19:52AM +0400, Dheeraj CVR wrote:<br>
&gt; I have tried to grab details about the kernel panic stack trace to mak=
e it<br>
&gt; easier for Joerg to identify and fix the issue. I have downloaded the =
latest<br>
&gt; Kubuntu Live ISO image which is based on kernel 4.2.0. I have changed =
the boot<br>
&gt; parameters to boot with intel_iommu=3Don. I was able to capture the ke=
rnel panic<br>
&gt; with slow motion video recording. The hard lockup appears to occur whe=
n calling<br>
&gt; &quot;flush_context&quot;.<br>
<br>
</span>Can you please send me the dmesg output of a kernel that works right=
<br>
after boot?<br>
<br>
<br>
Thanks,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Joerg<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div></div></div><span c=
lass=3D"HOEnZb"><font color=3D"#888888">-- <br><div><div dir=3D"ltr">Regard=
s,<br>Dheeraj CVR.<br></div></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr">Regards,<br>Dheeraj CVR.<br></div></d=
iv>
</div>

--047d7b10d1abec28fa05319ef53d--

--===============0503143382996010530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0503143382996010530==--
