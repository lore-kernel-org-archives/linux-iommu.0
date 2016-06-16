From: Dheeraj CVR <cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUGREPORT] Intel X58 Boards don't boot after "iommu/vt-d: Make
	root entry visible for hardware right after allocation"
Date: Thu, 16 Jun 2016 20:11:29 +0400
Message-ID: <CAH-=PyREixkSp59v_ErYK6rn0X8KLS29XxVCd9u51Yy6+r2tKg@mail.gmail.com>
References: <CAH-=PyRpjuKf0XJNyzkVLpggaaYq163AfA84SZ5=DQH2Ys5Lkw@mail.gmail.com>
	<CAH-=PyR-6sY1vuzQSfJyh35Q+WqZKD70Ev7vDns+02h8j=m18Q@mail.gmail.com>
	<20160425110151.GE17926@8bytes.org>
	<CAH-=PyTGF76sq7LvQH0-28DoK1dXGUOdnCF6z9shF_CWosWYwQ@mail.gmail.com>
	<CAH-=PyTaR-xH7D4eOnFkB-7gojdZW08yHEPP2Gw2-0GjWTA4dw@mail.gmail.com>
	<20160615161149.GJ13971@8bytes.org>
	<CAH-=PyRBZU95f0XPLZQXyaKLPx+K5iNsQs3ucQRj6BPfj9ERBA@mail.gmail.com>
	<20160616102914.GA11432@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1433967562164089587=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160616102914.GA11432-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

--===============1433967562164089587==
Content-Type: multipart/alternative; boundary=001a11352f02b887d60535677dff

--001a11352f02b887d60535677dff
Content-Type: text/plain; charset=UTF-8

I have applied your patch to 4.7.0-rc3 mainline kernel and the machine
successfully boots with intel_iommu=on. Thank you so much for your time and
effort.

Please find the attached dmesg of successful boot with iommu enabled.

[    0.000000] Linux version 4.7.0-rc3-8d8a5ff (dhiru1602@ScaRage) (gcc
version 6.1.1 20160602 (GCC) ) #1 SMP PREEMPT Thu Jun 16 19:37:34 GST 2016
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-linux-git
root=UUID=80dfd13f-1755-4c83-b110-84282a777964 rw quiet intel_iommu=on
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x000000000009ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf780000-0x00000000bf78dfff] ACPI
data
[    0.000000] BIOS-e820: [mem 0x00000000bf78e000-0x00000000bf7cffff] ACPI
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf7d0000-0x00000000bf7dffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bf7e8000-0x00000000bfffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: MSI MS-7666/Big Bang-XPower (MS-7666), BIOS V1.7
07/27/2012
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x440000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D3FFF write-protect
[    0.000000]   D4000-DFFFF uncachable
[    0.000000]   E0000-E3FFF write-protect
[    0.000000]   E4000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask FC00000000 write-back
[    0.000000]   1 base 0400000000 mask FFC0000000 write-back
[    0.000000]   2 base 00C0000000 mask FFC0000000 uncachable
[    0.000000]   3 base 00BF800000 mask FFFF800000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT

[    0.000000] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xbf780 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at
[ffff8800000ff780]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x01b58000, 0x01b58fff] PGTABLE
[    0.000000] BRK [0x01b59000, 0x01b59fff] PGTABLE
[    0.000000] BRK [0x01b5a000, 0x01b5afff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3779e000-0x37bc6fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FA5A0 000014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 0x00000000BF780000 000040 (v01 7666MS A7666100
20120727 MSFT 00000097)
[    0.000000] ACPI: FACP 0x00000000BF780200 000084 (v01 7666MS A7666100
20120727 MSFT 00000097)
[    0.000000] ACPI: DSDT 0x00000000BF780600 006CF8 (v01 A7666  A7666100
00000100 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000BF78E000 000040
[    0.000000] ACPI: APIC 0x00000000BF780390 0000AC (v01 7666MS A7666100
20120727 MSFT 00000097)
[    0.000000] ACPI: MCFG 0x00000000BF780440 00003C (v01 7666MS OEMMCFG
 20120727 MSFT 00000097)
[    0.000000] ACPI: OEMB 0x00000000BF78E040 000082 (v01 7666MS A7666100
20120727 MSFT 00000097)
[    0.000000] ACPI: DMAR 0x00000000BF78E0D0 000150 (v01 AMI    OEMDMAR
 00000001 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000BF78A600 000038 (v01 7666MS OEMHPET
 20120727 MSFT 00000097)
[    0.000000] ACPI: SSDT 0x00000000BF790F40 000363 (v01 DpgPmm CpuPm
 00000012 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000043fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x43fffa000-0x43fffdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000043fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bf77ffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000043fffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000000001000-0x000000043fffffff]
[    0.000000] On node 0 totalpages: 4192028
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 12190 pages used for memmap
[    0.000000]   DMA32 zone: 780160 pages, LIFO batch:31
[    0.000000]   Normal zone: 53248 pages used for memmap
[    0.000000]   Normal zone: 3407872 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 6, version 32, address 0xfec00000, GSI
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0xffffffff base: 0xfed00000
[    0.000000] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf780000-0xbf78dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf78e000-0xbf7cffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf7d0000-0xbf7dffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf7e0000-0xbf7e7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf7e8000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffbfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
[    0.000000] e820: [mem 0xc0000000-0xfedfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:12
nr_node_ids:1
[    0.000000] percpu: Embedded 33 pages/cpu @ffff88042f200000 s97944 r8192
d29032 u262144
[    0.000000] pcpu-alloc: s97944 r8192 d29032 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 --
-- -- --
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 4126505
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux-git
root=UUID=80dfd13f-1755-4c83-b110-84282a777964 rw quiet intel_iommu=on
[    0.000000] DMAR: IOMMU enabled
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 16422076K/16768112K available (6003K kernel code,
978K rwdata, 1836K rodata, 1244K init, 1164K bss, 346036K reserved, 0K
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] Build-time adjustment of leaf fanout to 64.
[    0.000000] RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=12.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=12
[    0.000000] NR_IRQS:8448 nr_irqs:520 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 4399.618 MHz processor
[    0.000018] Calibrating delay loop (skipped), value calculated using
timer frequency.. 8802.87 BogoMIPS (lpj=14665393)
[    0.000020] pid_max: default: 32768 minimum: 301
[    0.000025] ACPI: Core revision 20160422
[    0.000054] Security Framework initialized
[    0.000055] Yama: becoming mindful.
[    0.000665] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes)
[    0.003136] Inode-cache hash table entries: 1048576 (order: 11, 8388608
bytes)
[    0.004202] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes)
[    0.004214] Mountpoint-cache hash table entries: 32768 (order: 6, 262144
bytes)
[    0.004425] CPU: Physical Processor ID: 0
[    0.004426] CPU: Processor Core ID: 0
[    0.004432] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.004433] ENERGY_PERF_BIAS: View and update with
x86_energy_perf_policy(8)
[    0.004435] mce: CPU supports 9 MCE banks
[    0.004441] CPU0: Thermal monitoring enabled (TM1)
[    0.004451] process: using mwait in idle threads
[    0.004453] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.004454] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.004644] Freeing SMP alternatives memory: 24K (ffffffff81a2d000 -
ffffffff81a33000)
[    0.027646] ftrace: allocating 23795 entries in 93 pages
[    0.034374] smpboot: Max logical packages: 2
[    0.034375] smpboot: APIC(0) Converting physical 0 to logical package 0
[    0.034378] DMAR-IR: This system BIOS has enabled interrupt remapping
               on a chipset that contains an erratum making that
               feature unstable.  To maintain system stability
               interrupt remapping is being disabled.  Please
               contact your BIOS vendor for an update
[    0.034381] Switched APIC routing to physical flat.
[    0.034740] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.173157] smpboot: CPU0: Intel(R) Xeon(R) CPU           X5670  @
2.93GHz (family: 0x6, model: 0x2c, stepping: 0x2)
[    0.173159] Performance Events: PEBS fmt1+, 16-deep LBR, Westmere
events, Intel PMU driver.
[    0.173171] core: CPUID marked event: 'bus cycles' unavailable
[    0.173173] ... version:                3
[    0.173173] ... bit width:              48
[    0.173174] ... generic registers:      4
[    0.173175] ... value mask:             0000ffffffffffff
[    0.173175] ... max period:             000000007fffffff
[    0.173176] ... fixed-purpose events:   3
[    0.173176] ... event mask:             000000070000000f
[    0.196723] NMI watchdog: enabled on all CPUs, permanently consumes one
hw-PMU counter.
[    0.213168] x86: Booting SMP configuration:
[    0.213170] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8
 #9 #10 #11
[    1.265245] x86: Booted up 1 node, 12 CPUs
[    1.265248] smpboot: Total of 12 processors activated (105638.67
BogoMIPS)
[    1.275873] devtmpfs: initialized
[    1.275910] x86/mm: Memory block size: 128MB
[    1.277838] PM: Registering ACPI NVS region [mem 0xbf78e000-0xbf7cffff]
(270336 bytes)
[    1.277881] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 6370867519511994 ns
[    1.277909] pinctrl core: initialized pinctrl subsystem
[    1.277939] RTC time: 15:59:07, date: 06/16/16
[    1.278840] NET: Registered protocol family 16
[    1.289878] cpuidle: using governor ladder
[    1.299879] cpuidle: using governor menu
[    1.299902] ACPI: bus type PCI registered
[    1.299904] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.299952] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    1.299953] PCI: not using MMCONFIG
[    1.299954] PCI: Using configuration type 1 for base access
[    1.313292] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    1.313293] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.313419] ACPI: Added _OSI(Module Device)
[    1.313420] ACPI: Added _OSI(Processor Device)
[    1.313421] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.313422] ACPI: Added _OSI(Processor Aggregator Device)
[    1.315189] ACPI: Executed 1 blocks of module-level executable AML code
[    1.315317] ACPI: 2 ACPI AML tables successfully acquired and loaded

[    1.317263] ACPI: Dynamic OEM Table Load:
[    1.317272] ACPI: SSDT 0xFFFF88042C9EC000 002D18 (v01 DpgPmm P001Ist
 00000011 INTL 20051117)
[    1.317765] ACPI: Interpreter enabled
[    1.317774] ACPI: (supports S0 S1 S4 S5)
[    1.317775] ACPI: Using IOAPIC for interrupt routing
[    1.317791] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    1.318097] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in
ACPI motherboard resources
[    1.318099] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000]
with a huge-page mapping due to MTRR override.
[    1.318390] PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug
[    1.321824] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.321828] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    1.321919] acpi PNP0A08:00: _OSC: platform does not support
[PCIeCapability]
[    1.321963] acpi PNP0A08:00: _OSC: not requesting control; platform does
not support [PCIeCapability]
[    1.321964] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME AER
PCIeCapability]
[    1.321965] acpi PNP0A08:00: _OSC: platform willing to grant
[PCIeHotplug PME AER]
[    1.321966] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    1.322120] PCI host bridge to bus 0000:00
[    1.322122] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.322123] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.322124] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    1.322125] pci_bus 0000:00: root bus resource [mem
0x000d0000-0x000dffff window]
[    1.322126] pci_bus 0000:00: root bus resource [mem
0xc0000000-0xdfffffff window]
[    1.322127] pci_bus 0000:00: root bus resource [mem
0xf0000000-0xfed8ffff window]
[    1.322128] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.322135] pci 0000:00:00.0: [8086:3405] type 00 class 0x060000
[    1.322175] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.322229] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    1.322267] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.322301] pci 0000:00:01.0: System wakeup disabled by ACPI
[    1.322325] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
[    1.322362] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.322394] pci 0000:00:02.0: System wakeup disabled by ACPI
[    1.322417] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    1.322455] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.322488] pci 0000:00:03.0: System wakeup disabled by ACPI
[    1.322511] pci 0000:00:05.0: [8086:340c] type 01 class 0x060400
[    1.322545] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    1.322576] pci 0000:00:05.0: System wakeup disabled by ACPI
[    1.322599] pci 0000:00:06.0: [8086:340d] type 01 class 0x060400
[    1.322633] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    1.322665] pci 0000:00:06.0: System wakeup disabled by ACPI
[    1.322687] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    1.322722] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    1.322754] pci 0000:00:07.0: System wakeup disabled by ACPI
[    1.322776] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
[    1.322810] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    1.322841] pci 0000:00:09.0: System wakeup disabled by ACPI
[    1.322864] pci 0000:00:0a.0: [8086:3411] type 01 class 0x060400
[    1.322898] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    1.322929] pci 0000:00:0a.0: System wakeup disabled by ACPI
[    1.322954] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    1.323026] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    1.323096] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    1.323164] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
[    1.323233] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    1.323265] pci 0000:00:1a.0: reg 0x20: [io  0x6400-0x641f]
[    1.323328] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    1.323351] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    1.323383] pci 0000:00:1a.1: reg 0x20: [io  0x6480-0x649f]
[    1.323443] pci 0000:00:1a.1: System wakeup disabled by ACPI
[    1.323467] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
[    1.323499] pci 0000:00:1a.2: reg 0x20: [io  0x6800-0x681f]
[    1.323559] pci 0000:00:1a.2: System wakeup disabled by ACPI
[    1.323588] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    1.323602] pci 0000:00:1a.7: reg 0x10: [mem 0xfb8f8000-0xfb8f83ff]
[    1.323669] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    1.323697] pci 0000:00:1a.7: System wakeup disabled by ACPI
[    1.323722] pci 0000:00:1b.0: [8086:3a3e] type 00 class 0x040300
[    1.323735] pci 0000:00:1b.0: reg 0x10: [mem 0xfb8f4000-0xfb8f7fff 64bit]
[    1.323790] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.323842] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    1.323895] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.323928] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    1.323952] pci 0000:00:1c.1: [8086:3a42] type 01 class 0x060400
[    1.324005] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.324037] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    1.324060] pci 0000:00:1c.2: [8086:3a44] type 01 class 0x060400
[    1.324114] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.324146] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    1.324169] pci 0000:00:1c.3: [8086:3a46] type 01 class 0x060400
[    1.324222] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.324254] pci 0000:00:1c.3: System wakeup disabled by ACPI
[    1.324278] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    1.324331] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.324364] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    1.324389] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    1.324421] pci 0000:00:1d.0: reg 0x20: [io  0x6880-0x689f]
[    1.324481] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    1.324505] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    1.324537] pci 0000:00:1d.1: reg 0x20: [io  0x6c00-0x6c1f]
[    1.324597] pci 0000:00:1d.1: System wakeup disabled by ACPI
[    1.324621] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    1.324653] pci 0000:00:1d.2: reg 0x20: [io  0x7000-0x701f]
[    1.324713] pci 0000:00:1d.2: System wakeup disabled by ACPI
[    1.324742] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    1.324756] pci 0000:00:1d.7: reg 0x10: [mem 0xfb8fa000-0xfb8fa3ff]
[    1.324823] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    1.324852] pci 0000:00:1d.7: System wakeup disabled by ACPI
[    1.324874] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    1.324929] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    1.324952] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
[    1.325016] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by ICH6
ACPI/GPIO/TCO
[    1.325019] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6
GPIO
[    1.325021] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0a00
(mask 00ff)
[    1.325023] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0a00
(mask 0017)
[    1.325025] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 4700
(mask 00ff)
[    1.325091] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
[    1.325102] pci 0000:00:1f.2: reg 0x10: [io  0x7880-0x7887]
[    1.325107] pci 0000:00:1f.2: reg 0x14: [io  0x7800-0x7803]
[    1.325113] pci 0000:00:1f.2: reg 0x18: [io  0x7480-0x7487]
[    1.325118] pci 0000:00:1f.2: reg 0x1c: [io  0x7400-0x7403]
[    1.325124] pci 0000:00:1f.2: reg 0x20: [io  0x7080-0x709f]
[    1.325129] pci 0000:00:1f.2: reg 0x24: [mem 0xfb8fc000-0xfb8fc7ff]
[    1.325160] pci 0000:00:1f.2: PME# supported from D3hot
[    1.325206] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    1.325217] pci 0000:00:1f.3: reg 0x10: [mem 0xfb8fe000-0xfb8fe0ff 64bit]
[    1.325233] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
[    1.325320] pci 0000:0e:00.0: [1033:0194] type 00 class 0x0c0330
[    1.325334] pci 0000:0e:00.0: reg 0x10: [mem 0xfbefe000-0xfbefffff 64bit]
[    1.325404] pci 0000:0e:00.0: PME# supported from D0 D3hot D3cold
[    1.329889] pci 0000:00:01.0: PCI bridge to [bus 0e]
[    1.329894] pci 0000:00:01.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.329938] pci 0000:0d:00.0: [1b4b:9123] type 00 class 0x010601
[    1.329947] pci 0000:0d:00.0: reg 0x10: [io  0xe080-0xe087]
[    1.329952] pci 0000:0d:00.0: reg 0x14: [io  0xe000-0xe003]
[    1.329957] pci 0000:0d:00.0: reg 0x18: [io  0xdc00-0xdc07]
[    1.329962] pci 0000:0d:00.0: reg 0x1c: [io  0xd880-0xd883]
[    1.329968] pci 0000:0d:00.0: reg 0x20: [io  0xd800-0xd80f]
[    1.329973] pci 0000:0d:00.0: reg 0x24: [mem 0xfbddf800-0xfbddffff]
[    1.329978] pci 0000:0d:00.0: reg 0x30: [mem 0xfbdc0000-0xfbdcffff pref]
[    1.329985] pci 0000:0d:00.0: Enabling fixed DMA alias to 00.1
[    1.330006] pci 0000:0d:00.0: PME# supported from D3hot
[    1.336553] pci 0000:00:02.0: PCI bridge to [bus 0d]
[    1.336557] pci 0000:00:02.0:   bridge window [io  0xd000-0xefff]
[    1.336560] pci 0000:00:02.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    1.336604] pci 0000:0c:00.0: [10de:0622] type 00 class 0x030000
[    1.336612] pci 0000:0c:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
[    1.336620] pci 0000:0c:00.0: reg 0x14: [mem 0xd0000000-0xdfffffff 64bit
pref]
[    1.336628] pci 0000:0c:00.0: reg 0x1c: [mem 0xf8000000-0xf9ffffff 64bit]
[    1.336633] pci 0000:0c:00.0: reg 0x24: [io  0xcc00-0xcc7f]
[    1.336638] pci 0000:0c:00.0: reg 0x30: [mem 0xf7f80000-0xf7ffffff pref]
[    1.343220] pci 0000:00:03.0: PCI bridge to [bus 0c]
[    1.343224] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    1.343226] pci 0000:00:03.0:   bridge window [mem 0xf7f00000-0xfaffffff]
[    1.343231] pci 0000:00:03.0:   bridge window [mem 0xd0000000-0xdfffffff
64bit pref]
[    1.343264] pci 0000:00:05.0: PCI bridge to [bus 0b]
[    1.343291] pci 0000:00:06.0: PCI bridge to [bus 0a]
[    1.343317] pci 0000:00:07.0: PCI bridge to [bus 09]
[    1.343343] pci 0000:00:09.0: PCI bridge to [bus 08]
[    1.343369] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    1.343412] pci 0000:06:00.0: [10ec:8168] type 00 class 0x020000
[    1.343428] pci 0000:06:00.0: reg 0x10: [io  0xb800-0xb8ff]
[    1.343451] pci 0000:06:00.0: reg 0x18: [mem 0xf5fff000-0xf5ffffff 64bit
pref]
[    1.343466] pci 0000:06:00.0: reg 0x20: [mem 0xf5ff8000-0xf5ffbfff 64bit
pref]
[    1.343475] pci 0000:06:00.0: reg 0x30: [mem 0xfbce0000-0xfbcfffff pref]
[    1.343543] pci 0000:06:00.0: supports D1 D2
[    1.343544] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.349891] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    1.349896] pci 0000:00:1c.0:   bridge window [io  0xb000-0xbfff]
[    1.349899] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    1.349904] pci 0000:00:1c.0:   bridge window [mem 0xf5f00000-0xf5ffffff
64bit pref]
[    1.349951] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
[    1.349967] pci 0000:05:00.0: reg 0x10: [io  0xa800-0xa8ff]
[    1.349990] pci 0000:05:00.0: reg 0x18: [mem 0xf5eff000-0xf5efffff 64bit
pref]
[    1.350005] pci 0000:05:00.0: reg 0x20: [mem 0xf5ef8000-0xf5efbfff 64bit
pref]
[    1.350014] pci 0000:05:00.0: reg 0x30: [mem 0xfbbe0000-0xfbbfffff pref]
[    1.350082] pci 0000:05:00.0: supports D1 D2
[    1.350083] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.356558] pci 0000:00:1c.1: PCI bridge to [bus 05]
[    1.356562] pci 0000:00:1c.1:   bridge window [io  0xa000-0xafff]
[    1.356566] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    1.356571] pci 0000:00:1c.1:   bridge window [mem 0xf5e00000-0xf5efffff
64bit pref]
[    1.356618] pci 0000:04:00.0: [1106:3403] type 00 class 0x0c0010
[    1.356639] pci 0000:04:00.0: reg 0x10: [mem 0xfbaff800-0xfbafffff 64bit]
[    1.356649] pci 0000:04:00.0: reg 0x18: [io  0x9800-0x98ff]
[    1.356737] pci 0000:04:00.0: supports D2
[    1.356738] pci 0000:04:00.0: PME# supported from D2 D3hot D3cold
[    1.363225] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    1.363229] pci 0000:00:1c.2:   bridge window [io  0x9000-0x9fff]
[    1.363233] pci 0000:00:1c.2:   bridge window [mem 0xfba00000-0xfbafffff]
[    1.363291] pci 0000:03:00.0: [197b:2362] type 00 class 0x010601
[    1.363320] pci 0000:03:00.0: reg 0x10: [io  0x8c00-0x8c07]
[    1.363331] pci 0000:03:00.0: reg 0x14: [io  0x8880-0x8883]
[    1.363342] pci 0000:03:00.0: reg 0x18: [io  0x8800-0x8807]
[    1.363354] pci 0000:03:00.0: reg 0x1c: [io  0x8480-0x8483]
[    1.363365] pci 0000:03:00.0: reg 0x20: [io  0x8400-0x840f]
[    1.363377] pci 0000:03:00.0: reg 0x24: [mem 0xfb9ffc00-0xfb9ffdff]
[    1.363388] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.363438] pci 0000:03:00.0: PME# supported from D3hot
[    1.369892] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    1.369896] pci 0000:00:1c.3:   bridge window [io  0x8000-0x8fff]
[    1.369900] pci 0000:00:1c.3:   bridge window [mem 0xfb900000-0xfb9fffff]
[    1.369953] pci 0000:02:00.0: [1102:000b] type 00 class 0x040300
[    1.369977] pci 0000:02:00.0: reg 0x10: [mem 0xf7ef0000-0xf7efffff 64bit]
[    1.369993] pci 0000:02:00.0: reg 0x18: [mem 0xf7c00000-0xf7dfffff 64bit]
[    1.370010] pci 0000:02:00.0: reg 0x20: [mem 0xf6000000-0xf6ffffff 64bit]
[    1.376559] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    1.376564] pci 0000:00:1c.4:   bridge window [mem 0xf6000000-0xf7efffff]
[    1.376627] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive decode)
[    1.376634] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window]
(subtractive decode)
[    1.376635] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window]
(subtractive decode)
[    1.376636] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff
window] (subtractive decode)
[    1.376637] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff
window] (subtractive decode)
[    1.376638] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff
window] (subtractive decode)
[    1.376639] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff
window] (subtractive decode)
[    1.376915] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11 12 14
*15)
[    1.376944] ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
[    1.376972] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12 14
15)
[    1.377000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 *10 11 12 14
15)
[    1.377029] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14
15) *0, disabled.
[    1.377058] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14
15)
[    1.377086] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 6 7 10 11 12 14
15)
[    1.377115] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 11 12 *14
15)
[    1.377144] ACPI: Enabled 1 GPEs in block 00 to 3F
[    1.377190] vgaarb: setting as boot device: PCI:0000:0c:00.0
[    1.377191] vgaarb: device added:
PCI:0000:0c:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.377192] vgaarb: loaded
[    1.377193] vgaarb: bridge control possible 0000:0c:00.0
[    1.377234] PCI: Using ACPI for IRQ routing
[    1.381779] PCI: Discovered peer bus ff
[    1.381781] PCI: root bus ff: using default resources
[    1.381782] PCI: Probing PCI hardware (bus ff)
[    1.381804] ACPI: \: failed to evaluate _DSM (0x1001)
[    1.381804] PCI host bridge to bus 0000:ff
[    1.381806] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
[    1.381807] pci_bus 0000:ff: root bus resource [mem
0x00000000-0xffffffffff]
[    1.381808] pci_bus 0000:ff: No busn resource found for root bus, will
use [bus ff-ff]
[    1.381809] pci_bus 0000:ff: busn_res: can not insert [bus ff] under
domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    1.381812] pci 0000:ff:00.0: [8086:2c70] type 00 class 0x060000
[    1.381839] pci 0000:ff:00.1: [8086:2d81] type 00 class 0x060000
[    1.381863] pci 0000:ff:02.0: [8086:2d90] type 00 class 0x060000
[    1.381886] pci 0000:ff:02.1: [8086:2d91] type 00 class 0x060000
[    1.381912] pci 0000:ff:02.2: [8086:2d92] type 00 class 0x060000
[    1.381936] pci 0000:ff:02.3: [8086:2d93] type 00 class 0x060000
[    1.381958] pci 0000:ff:02.4: [8086:2d94] type 00 class 0x060000
[    1.381981] pci 0000:ff:02.5: [8086:2d95] type 00 class 0x060000
[    1.382005] pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000
[    1.382027] pci 0000:ff:03.1: [8086:2d99] type 00 class 0x060000
[    1.382050] pci 0000:ff:03.2: [8086:2d9a] type 00 class 0x060000
[    1.382073] pci 0000:ff:03.4: [8086:2d9c] type 00 class 0x060000
[    1.382096] pci 0000:ff:04.0: [8086:2da0] type 00 class 0x060000
[    1.382119] pci 0000:ff:04.1: [8086:2da1] type 00 class 0x060000
[    1.382142] pci 0000:ff:04.2: [8086:2da2] type 00 class 0x060000
[    1.382165] pci 0000:ff:04.3: [8086:2da3] type 00 class 0x060000
[    1.382189] pci 0000:ff:05.0: [8086:2da8] type 00 class 0x060000
[    1.382212] pci 0000:ff:05.1: [8086:2da9] type 00 class 0x060000
[    1.382235] pci 0000:ff:05.2: [8086:2daa] type 00 class 0x060000
[    1.382258] pci 0000:ff:05.3: [8086:2dab] type 00 class 0x060000
[    1.382282] pci 0000:ff:06.0: [8086:2db0] type 00 class 0x060000
[    1.382306] pci 0000:ff:06.1: [8086:2db1] type 00 class 0x060000
[    1.382328] pci 0000:ff:06.2: [8086:2db2] type 00 class 0x060000
[    1.382351] pci 0000:ff:06.3: [8086:2db3] type 00 class 0x060000
[    1.382382] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
[    1.382383] pci_bus 0000:ff: busn_res: can not insert [bus ff] under
domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    1.382387] PCI: pci_cache_line_size set to 64 bytes
[    1.382463] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    1.382464] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
[    1.382523] NetLabel: Initializing
[    1.382524] NetLabel:  domain hash size = 128
[    1.382524] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.382531] NetLabel:  unlabeled traffic allowed by default
[    1.382561] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    1.382563] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    1.384581] clocksource: Switched to clocksource hpet
[    1.387741] VFS: Disk quotas dquot_6.6.0
[    1.387753] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    1.387794] pnp: PnP ACPI init
[    1.387834] system 00:00: [mem 0xfbf00000-0xfbffffff] has been reserved
[    1.387836] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    1.387837] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    1.387838] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
[    1.387839] system 00:00: [mem 0xfec8a000-0xfec8afff] has been reserved
[    1.387840] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
[    1.387842] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.387873] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.387966] system 00:02: [io  0x0a00-0x0adf] has been reserved
[    1.387968] system 00:02: [io  0x0ae0-0x0aef] has been reserved
[    1.387969] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.388067] system 00:03: [io  0x04d0-0x04d1] has been reserved
[    1.388068] system 00:03: [io  0x0800-0x087f] has been reserved
[    1.388069] system 00:03: [io  0x0500-0x057f] could not be reserved
[    1.388071] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.388072] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.388073] system 00:03: [mem 0xfed45000-0xfed89fff] has been reserved
[    1.388074] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.388076] system 00:03: [mem 0xfed40000-0xfed8ffff] could not be
reserved
[    1.388077] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.388154] system 00:04: [mem 0xfec00000-0xfec00fff] could not be
reserved
[    1.388156] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.388158] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.388206] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    1.388208] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.388312] system 00:06: [mem 0x00000000-0x0009ffff] could not be
reserved
[    1.388314] system 00:06: [mem 0x000c0000-0x000cffff] could not be
reserved
[    1.388315] system 00:06: [mem 0x000e0000-0x000fffff] could not be
reserved
[    1.388316] system 00:06: [mem 0x00100000-0xbfffffff] could not be
reserved
[    1.388317] system 00:06: [mem 0xfed90000-0xffffffff] could not be
reserved
[    1.388319] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.388382] pnp: PnP ACPI: found 7 devices
[    1.393990] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
[    1.394033] pci 0000:00:1c.2: bridge window [mem 0x00100000-0x000fffff
64bit pref] to [bus 04] add_size 200000 add_align 100000
[    1.394038] pci 0000:00:1c.3: bridge window [mem 0x00100000-0x000fffff
64bit pref] to [bus 03] add_size 200000 add_align 100000
[    1.394044] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus
02] add_size 1000
[    1.394045] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff
64bit pref] to [bus 02] add_size 200000 add_align 100000
[    1.394056] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x000fffff 64bit
pref] res_to_dev_res add_size 200000 min_align 100000
[    1.394058] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x002fffff 64bit
pref] res_to_dev_res add_size 200000 min_align 100000
[    1.394059] pci 0000:00:1c.3: res[15]=[mem 0x00100000-0x000fffff 64bit
pref] res_to_dev_res add_size 200000 min_align 100000
[    1.394060] pci 0000:00:1c.3: res[15]=[mem 0x00100000-0x002fffff 64bit
pref] res_to_dev_res add_size 200000 min_align 100000
[    1.394061] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x000fffff 64bit
pref] res_to_dev_res add_size 200000 min_align 100000
[    1.394062] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x002fffff 64bit
pref] res_to_dev_res add_size 200000 min_align 100000
[    1.394063] pci 0000:00:1c.4: res[13]=[io  0x1000-0x0fff] res_to_dev_res
add_size 1000 min_align 1000
[    1.394064] pci 0000:00:1c.4: res[13]=[io  0x1000-0x1fff] res_to_dev_res
add_size 1000 min_align 1000
[    1.394068] pci 0000:00:1c.2: BAR 15: assigned [mem
0xc0000000-0xc01fffff 64bit pref]
[    1.394071] pci 0000:00:1c.3: BAR 15: assigned [mem
0xc0200000-0xc03fffff 64bit pref]
[    1.394073] pci 0000:00:1c.4: BAR 15: assigned [mem
0xc0400000-0xc05fffff 64bit pref]
[    1.394074] pci 0000:00:1c.4: BAR 13: assigned [io  0x1000-0x1fff]
[    1.394076] pci 0000:00:01.0: PCI bridge to [bus 0e]
[    1.394079] pci 0000:00:01.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.394083] pci 0000:00:02.0: PCI bridge to [bus 0d]
[    1.394084] pci 0000:00:02.0:   bridge window [io  0xd000-0xefff]
[    1.394087] pci 0000:00:02.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    1.394090] pci 0000:00:03.0: PCI bridge to [bus 0c]
[    1.394092] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    1.394094] pci 0000:00:03.0:   bridge window [mem 0xf7f00000-0xfaffffff]
[    1.394096] pci 0000:00:03.0:   bridge window [mem 0xd0000000-0xdfffffff
64bit pref]
[    1.394099] pci 0000:00:05.0: PCI bridge to [bus 0b]
[    1.394104] pci 0000:00:06.0: PCI bridge to [bus 0a]
[    1.394109] pci 0000:00:07.0: PCI bridge to [bus 09]
[    1.394114] pci 0000:00:09.0: PCI bridge to [bus 08]
[    1.394120] pci 0000:00:0a.0: PCI bridge to [bus 07]
[    1.394125] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    1.394127] pci 0000:00:1c.0:   bridge window [io  0xb000-0xbfff]
[    1.394130] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    1.394132] pci 0000:00:1c.0:   bridge window [mem 0xf5f00000-0xf5ffffff
64bit pref]
[    1.394136] pci 0000:00:1c.1: PCI bridge to [bus 05]
[    1.394137] pci 0000:00:1c.1:   bridge window [io  0xa000-0xafff]
[    1.394140] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    1.394142] pci 0000:00:1c.1:   bridge window [mem 0xf5e00000-0xf5efffff
64bit pref]
[    1.394146] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    1.394147] pci 0000:00:1c.2:   bridge window [io  0x9000-0x9fff]
[    1.394150] pci 0000:00:1c.2:   bridge window [mem 0xfba00000-0xfbafffff]
[    1.394153] pci 0000:00:1c.2:   bridge window [mem 0xc0000000-0xc01fffff
64bit pref]
[    1.394157] pci 0000:03:00.0: BAR 6: assigned [mem 0xfb900000-0xfb90ffff
pref]
[    1.394158] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    1.394159] pci 0000:00:1c.3:   bridge window [io  0x8000-0x8fff]
[    1.394162] pci 0000:00:1c.3:   bridge window [mem 0xfb900000-0xfb9fffff]
[    1.394164] pci 0000:00:1c.3:   bridge window [mem 0xc0200000-0xc03fffff
64bit pref]
[    1.394168] pci 0000:00:1c.4: PCI bridge to [bus 02]
[    1.394170] pci 0000:00:1c.4:   bridge window [io  0x1000-0x1fff]
[    1.394173] pci 0000:00:1c.4:   bridge window [mem 0xf6000000-0xf7efffff]
[    1.394175] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc05fffff
64bit pref]
[    1.394179] pci 0000:00:1e.0: PCI bridge to [bus 01]
[    1.394186] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.394187] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.394188] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff
window]
[    1.394189] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff
window]
[    1.394190] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff
window]
[    1.394191] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff
window]
[    1.394192] pci_bus 0000:0e: resource 1 [mem 0xfbe00000-0xfbefffff]
[    1.394193] pci_bus 0000:0d: resource 0 [io  0xd000-0xefff]
[    1.394194] pci_bus 0000:0d: resource 1 [mem 0xfbd00000-0xfbdfffff]
[    1.394195] pci_bus 0000:0c: resource 0 [io  0xc000-0xcfff]
[    1.394196] pci_bus 0000:0c: resource 1 [mem 0xf7f00000-0xfaffffff]
[    1.394197] pci_bus 0000:0c: resource 2 [mem 0xd0000000-0xdfffffff 64bit
pref]
[    1.394198] pci_bus 0000:06: resource 0 [io  0xb000-0xbfff]
[    1.394199] pci_bus 0000:06: resource 1 [mem 0xfbc00000-0xfbcfffff]
[    1.394200] pci_bus 0000:06: resource 2 [mem 0xf5f00000-0xf5ffffff 64bit
pref]
[    1.394201] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
[    1.394202] pci_bus 0000:05: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    1.394203] pci_bus 0000:05: resource 2 [mem 0xf5e00000-0xf5efffff 64bit
pref]
[    1.394204] pci_bus 0000:04: resource 0 [io  0x9000-0x9fff]
[    1.394204] pci_bus 0000:04: resource 1 [mem 0xfba00000-0xfbafffff]
[    1.394205] pci_bus 0000:04: resource 2 [mem 0xc0000000-0xc01fffff 64bit
pref]
[    1.394206] pci_bus 0000:03: resource 0 [io  0x8000-0x8fff]
[    1.394207] pci_bus 0000:03: resource 1 [mem 0xfb900000-0xfb9fffff]
[    1.394208] pci_bus 0000:03: resource 2 [mem 0xc0200000-0xc03fffff 64bit
pref]
[    1.394209] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
[    1.394210] pci_bus 0000:02: resource 1 [mem 0xf6000000-0xf7efffff]
[    1.394211] pci_bus 0000:02: resource 2 [mem 0xc0400000-0xc05fffff 64bit
pref]
[    1.394212] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7 window]
[    1.394213] pci_bus 0000:01: resource 5 [io  0x0d00-0xffff window]
[    1.394214] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff
window]
[    1.394215] pci_bus 0000:01: resource 7 [mem 0x000d0000-0x000dffff
window]
[    1.394216] pci_bus 0000:01: resource 8 [mem 0xc0000000-0xdfffffff
window]
[    1.394217] pci_bus 0000:01: resource 9 [mem 0xf0000000-0xfed8ffff
window]
[    1.394219] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
[    1.394220] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xffffffffff]
[    1.394235] NET: Registered protocol family 2
[    1.394354] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[    1.394502] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.394607] TCP: Hash tables configured (established 131072 bind 65536)
[    1.394629] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    1.394661] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    1.394719] NET: Registered protocol family 1
[    1.395763] pci 0000:0c:00.0: Video device with shadowed ROM at [mem
0x000c0000-0x000dffff]
[    1.395789] PCI: CLS 256 bytes, default 64
[    1.395814] Unpacking initramfs...
[    1.432267] Freeing initrd memory: 4260K (ffff88003779e000 -
ffff880037bc7000)
[    1.432279] DMAR: Host address width 39
[    1.432281] DMAR: DRHD base: 0x000000fbfff000 flags: 0x0
[    1.432292] DMAR: dmar0: reg_base_addr fbfff000 ver 1:0 cap
c9008010e60262 ecap f020f2
[    1.432293] DMAR: DRHD base: 0x000000fbffe000 flags: 0x1
[    1.432297] DMAR: dmar1: reg_base_addr fbffe000 ver 1:0 cap
c9078010ef0462 ecap f020f6
[    1.432298] DMAR: RMRR base: 0x000000000ec000 end: 0x000000000f3fff
[    1.432299] DMAR: RMRR base: 0x000000bf7e8000 end: 0x000000bf7fffff
[    1.432299] DMAR: ATSR flags: 0x0
[    1.433425] DMAR: dmar0: Using Queued invalidation
[    1.433435] DMAR: dmar1: Using Queued invalidation
[    1.433449] DMAR: Recommended TLB entries for ISOCH unit is 16; your
BIOS set 20
[    1.433450] DMAR: Setting RMRR:
[    1.433500] DMAR: Setting identity map for device 0000:00:1a.0
[0xbf7e8000 - 0xbf7fffff]
[    1.433555] DMAR: Setting identity map for device 0000:00:1a.1
[0xbf7e8000 - 0xbf7fffff]
[    1.433606] DMAR: Setting identity map for device 0000:00:1a.2
[0xbf7e8000 - 0xbf7fffff]
[    1.433658] DMAR: Setting identity map for device 0000:00:1a.7
[0xbf7e8000 - 0xbf7fffff]
[    1.433711] DMAR: Setting identity map for device 0000:00:1d.0
[0xbf7e8000 - 0xbf7fffff]
[    1.433765] DMAR: Setting identity map for device 0000:00:1d.1
[0xbf7e8000 - 0xbf7fffff]
[    1.433819] DMAR: Setting identity map for device 0000:00:1d.2
[0xbf7e8000 - 0xbf7fffff]
[    1.433874] DMAR: Setting identity map for device 0000:00:1d.7
[0xbf7e8000 - 0xbf7fffff]
[    1.433886] DMAR: Setting identity map for device 0000:00:1a.0 [0xec000
- 0xf3fff]
[    1.433894] DMAR: Setting identity map for device 0000:00:1a.1 [0xec000
- 0xf3fff]
[    1.433902] DMAR: Setting identity map for device 0000:00:1a.2 [0xec000
- 0xf3fff]
[    1.433909] DMAR: Setting identity map for device 0000:00:1a.7 [0xec000
- 0xf3fff]
[    1.433917] DMAR: Setting identity map for device 0000:00:1d.0 [0xec000
- 0xf3fff]
[    1.433925] DMAR: Setting identity map for device 0000:00:1d.1 [0xec000
- 0xf3fff]
[    1.433933] DMAR: Setting identity map for device 0000:00:1d.2 [0xec000
- 0xf3fff]
[    1.433940] DMAR: Setting identity map for device 0000:00:1d.7 [0xec000
- 0xf3fff]
[    1.433949] DMAR: Prepare 0-16MiB unity mapping for LPC
[    1.433995] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 -
0xffffff]
[    1.434096] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    1.434139] iommu: Adding device 0000:00:00.0 to group 0
[    1.434148] iommu: Adding device 0000:00:01.0 to group 1
[    1.434156] iommu: Adding device 0000:00:02.0 to group 2
[    1.434164] iommu: Adding device 0000:00:03.0 to group 3
[    1.434173] iommu: Adding device 0000:00:05.0 to group 4
[    1.434182] iommu: Adding device 0000:00:06.0 to group 5
[    1.434190] iommu: Adding device 0000:00:07.0 to group 6
[    1.434198] iommu: Adding device 0000:00:09.0 to group 7
[    1.434205] iommu: Adding device 0000:00:0a.0 to group 8
[    1.434232] iommu: Adding device 0000:00:14.0 to group 9
[    1.434241] iommu: Adding device 0000:00:14.1 to group 9
[    1.434249] iommu: Adding device 0000:00:14.2 to group 9
[    1.434257] iommu: Adding device 0000:00:14.3 to group 9
[    1.434282] iommu: Adding device 0000:00:1a.0 to group 10
[    1.434290] iommu: Adding device 0000:00:1a.1 to group 10
[    1.434298] iommu: Adding device 0000:00:1a.2 to group 10
[    1.434306] iommu: Adding device 0000:00:1a.7 to group 10
[    1.434314] iommu: Adding device 0000:00:1b.0 to group 11
[    1.434349] iommu: Adding device 0000:00:1c.0 to group 12
[    1.434360] iommu: Adding device 0000:00:1c.1 to group 12
[    1.434370] iommu: Adding device 0000:00:1c.2 to group 12
[    1.434381] iommu: Adding device 0000:00:1c.3 to group 12
[    1.434392] iommu: Adding device 0000:00:1c.4 to group 12
[    1.434416] iommu: Adding device 0000:00:1d.0 to group 13
[    1.434425] iommu: Adding device 0000:00:1d.1 to group 13
[    1.434433] iommu: Adding device 0000:00:1d.2 to group 13
[    1.434441] iommu: Adding device 0000:00:1d.7 to group 13
[    1.434450] iommu: Adding device 0000:00:1e.0 to group 14
[    1.434470] iommu: Adding device 0000:00:1f.0 to group 15
[    1.434479] iommu: Adding device 0000:00:1f.2 to group 15
[    1.434488] iommu: Adding device 0000:00:1f.3 to group 15
[    1.434497] iommu: Adding device 0000:0e:00.0 to group 16
[    1.434507] iommu: Adding device 0000:0d:00.0 to group 17
[    1.434517] iommu: Adding device 0000:0c:00.0 to group 18
[    1.434521] iommu: Adding device 0000:06:00.0 to group 12
[    1.434525] iommu: Adding device 0000:05:00.0 to group 12
[    1.434529] iommu: Adding device 0000:04:00.0 to group 12
[    1.434533] iommu: Adding device 0000:03:00.0 to group 12
[    1.434537] iommu: Adding device 0000:02:00.0 to group 12
[    1.434553] iommu: Adding device 0000:ff:00.0 to group 19
[    1.434562] iommu: Adding device 0000:ff:00.1 to group 19
[    1.434625] iommu: Adding device 0000:ff:02.0 to group 20
[    1.434636] iommu: Adding device 0000:ff:02.1 to group 20
[    1.434646] iommu: Adding device 0000:ff:02.2 to group 20
[    1.434655] iommu: Adding device 0000:ff:02.3 to group 20
[    1.434665] iommu: Adding device 0000:ff:02.4 to group 20
[    1.434675] iommu: Adding device 0000:ff:02.5 to group 20
[    1.434699] iommu: Adding device 0000:ff:03.0 to group 21
[    1.434710] iommu: Adding device 0000:ff:03.1 to group 21
[    1.434719] iommu: Adding device 0000:ff:03.2 to group 21
[    1.434729] iommu: Adding device 0000:ff:03.4 to group 21
[    1.434753] iommu: Adding device 0000:ff:04.0 to group 22
[    1.434763] iommu: Adding device 0000:ff:04.1 to group 22
[    1.434773] iommu: Adding device 0000:ff:04.2 to group 22
[    1.434784] iommu: Adding device 0000:ff:04.3 to group 22
[    1.434808] iommu: Adding device 0000:ff:05.0 to group 23
[    1.434819] iommu: Adding device 0000:ff:05.1 to group 23
[    1.434829] iommu: Adding device 0000:ff:05.2 to group 23
[    1.434839] iommu: Adding device 0000:ff:05.3 to group 23
[    1.434863] iommu: Adding device 0000:ff:06.0 to group 24
[    1.434874] iommu: Adding device 0000:ff:06.1 to group 24
[    1.434885] iommu: Adding device 0000:ff:06.2 to group 24
[    1.434895] iommu: Adding device 0000:ff:06.3 to group 24
[    1.435770] Scanning for low memory corruption every 60 seconds
[    1.435989] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    1.436302] workingset: timestamp_bits=38 max_order=22 bucket_order=0
[    1.437194] zbud: loaded
[    1.437330] Key type big_key registered
[    1.437492] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 249)
[    1.437521] io scheduler noop registered
[    1.437522] io scheduler deadline registered
[    1.437539] io scheduler cfq registered (default)
[    1.438235] pcieport 0000:00:1c.4: enabling device (0106 -> 0107)
[    1.438346] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.438349] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.438357] vesafb: mode is 1280x1024x32, linelength=5120, pages=0
[    1.438358] vesafb: scrolling: redraw
[    1.438359] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.438371] vesafb: framebuffer at 0xf9000000, mapped to
0xffffc90002000000, using 5120k, total 5120k
[    1.575681] Console: switching to colour frame buffer device 160x64
[    1.712788] fb0: VESA VGA frame buffer device
[    1.712798] intel_idle: MWAIT substates: 0x1120
[    1.712799] intel_idle: v0.4.1 model 0x2C
[    1.713017] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.713161] GHES: HEST is not enabled!
[    1.713196] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.713431] Linux agpgart interface v0.103
[    1.713932] rtc_cmos 00:01: RTC can wake from S4
[    1.714018] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    1.714037] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes
nvram, hpet irqs
[    1.714045] ledtrig-cpu: registered to indicate activity on CPUs
[    1.714256] NET: Registered protocol family 10
[    1.714388] NET: Registered protocol family 17
[    1.714643] microcode: CPU0 sig=0x206c2, pf=0x1, revision=0x13
[    1.714690] microcode: CPU1 sig=0x206c2, pf=0x1, revision=0x13
[    1.714695] microcode: CPU2 sig=0x206c2, pf=0x1, revision=0x13
[    1.714719] microcode: CPU3 sig=0x206c2, pf=0x1, revision=0x13
[    1.714755] microcode: CPU4 sig=0x206c2, pf=0x1, revision=0x13
[    1.714799] microcode: CPU5 sig=0x206c2, pf=0x1, revision=0x13
[    1.714841] microcode: CPU6 sig=0x206c2, pf=0x1, revision=0x13
[    1.714883] microcode: CPU7 sig=0x206c2, pf=0x1, revision=0x13
[    1.714886] microcode: CPU8 sig=0x206c2, pf=0x1, revision=0x13
[    1.714890] microcode: CPU9 sig=0x206c2, pf=0x1, revision=0x13
[    1.714924] microcode: CPU10 sig=0x206c2, pf=0x1, revision=0x13
[    1.714967] microcode: CPU11 sig=0x206c2, pf=0x1, revision=0x13
[    1.714991] microcode: Microcode Update Driver: v2.01 <
tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    1.715149] registered taskstats version 1
[    1.715161] zswap: loaded using pool lzo/zbud
[    1.716530]   Magic number: 4:236:993
[    1.716533] machinecheck machinecheck6: hash matches
[    1.716569] memory memory36: hash matches
[    1.716842] rtc_cmos 00:01: setting system clock to 2016-06-16 15:59:07
UTC (1466092747)
[    1.716863] PM: Hibernation image not present or could not be loaded.
[    1.718128] Freeing unused kernel memory: 1244K (ffffffff818f6000 -
ffffffff81a2d000)
[    1.718129] Write protecting the kernel read-only data: 8192k
[    1.718748] Freeing unused kernel memory: 124K (ffff8800015e1000 -
ffff880001600000)
[    1.719254] Freeing unused kernel memory: 212K (ffff8800017cb000 -
ffff880001800000)
[    1.723477] random: systemd-tmpfile urandom read with 1 bits of entropy
available
[    1.742833] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    1.743166] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.743169] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.746399] ACPI: bus type USB registered

On Thu, Jun 16, 2016 at 2:29 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Thu, Jun 16, 2016 at 10:26:20AM +0400, Dheeraj CVR wrote:
> > I have added some debugging code to see where exactly the hang happens.
> The
> > set_root_entry call works fine without any issues as you have expected.
> > However, the hang happens when calling flush_context.
> >
> > flush_context -> qi_flush_context -> qi_submit_sync
> >
> > The loop "while (qi->desc_status[wait_index] != QI_DONE) {}" in
> > "qi_submit_sync" executes indefinitely and the control doesn't break.
> Hence, "
> > iommu->flush.flush_context()" never returns.
> >
> > Tested on 2 X58 Motherboards and both hang at the same place with
> intel_iommu=
> > on.
> >
> > Hope this helps.
>
> Hmm, okay. Yesterday I tried to reproduce the problem on a box in our
> test-lab which has the same chipset. The bug didn't show up there, and
> one difference to your machine is that is only has one iommu instead of
> two.
>
> This brought me to another difference the patch made: Before the patch
> QI was enabled on all iommus before the root entry was set and the
> caches flushed. With the patch QI is enabled in the same loop that sets
> the root entry and tries to flush. Maybe that is the problem on this
> chipset.
>
> Can you please try the attached diff? It is just a guess, but maybe that
> is the problem.
>
> Thanks,
>
>         Joerg
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a644d0c..0ddbb6a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3222,11 +3222,6 @@ static int __init init_dmars(void)
>                         }
>                 }
>
> -               iommu_flush_write_buffer(iommu);
> -               iommu_set_root_entry(iommu);
> -               iommu->flush.flush_context(iommu, 0, 0, 0,
> DMA_CCMD_GLOBAL_INVL);
> -               iommu->flush.flush_iotlb(iommu, 0, 0, 0,
> DMA_TLB_GLOBAL_FLUSH);
> -
>                 if (!ecap_pass_through(iommu->ecap))
>                         hw_pass_through = 0;
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> @@ -3235,6 +3230,17 @@ static int __init init_dmars(void)
>  #endif
>         }
>
> +       /*
> +        * Now that qi is enabled on all iommus, set the root entry and
> flush
> +        * caches.
> +        */
> +       for_each_active_iommu(iommu, drhd) {
> +               iommu_flush_write_buffer(iommu);
> +               iommu_set_root_entry(iommu);
> +               iommu->flush.flush_context(iommu, 0, 0, 0,
> DMA_CCMD_GLOBAL_INVL);
> +               iommu->flush.flush_iotlb(iommu, 0, 0, 0,
> DMA_TLB_GLOBAL_FLUSH);
> +       }
> +
>         if (iommu_pass_through)
>                 iommu_identity_mapping |= IDENTMAP_ALL;
>
>
>


-- 
Regards,
Dheeraj CVR.

--001a11352f02b887d60535677dff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have applied your patch to 4.7.0-rc3 mainline kernel and=
 the machine successfully boots with intel_iommu=3Don. Thank you so much fo=
r your time and effort.<div><br></div><div>Please find the attached dmesg o=
f successful boot with iommu enabled.<br><div><br></div><div><div>[ =C2=A0 =
=C2=A00.000000] Linux version 4.7.0-rc3-8d8a5ff (dhiru1602@ScaRage) (gcc ve=
rsion 6.1.1 20160602 (GCC) ) #1 SMP PREEMPT Thu Jun 16 19:37:34 GST 2016</d=
iv><div>[ =C2=A0 =C2=A00.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-l=
inux-git root=3DUUID=3D80dfd13f-1755-4c83-b110-84282a777964 rw quiet intel_=
iommu=3Don</div><div>[ =C2=A0 =C2=A00.000000] x86/fpu: Legacy x87 FPU detec=
ted.</div><div>[ =C2=A0 =C2=A00.000000] x86/fpu: Using &#39;eager&#39; FPU =
context switches.</div><div>[ =C2=A0 =C2=A00.000000] e820: BIOS-provided ph=
ysical RAM map:</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x000000=
0000000000-0x000000000009cfff] usable</div><div>[ =C2=A0 =C2=A00.000000] BI=
OS-e820: [mem 0x000000000009d000-0x000000000009ffff] reserved</div><div>[ =
=C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000ffff=
f] reserved</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x0000000000=
100000-0x00000000bf77ffff] usable</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e=
820: [mem 0x00000000bf780000-0x00000000bf78dfff] ACPI data</div><div>[ =C2=
=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000bf78e000-0x00000000bf7cffff] =
ACPI NVS</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000bf7d0=
000-0x00000000bf7dffff] reserved</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e8=
20: [mem 0x00000000bf7e8000-0x00000000bfffffff] reserved</div><div>[ =C2=A0=
 =C2=A00.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] res=
erved</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000ffc00000=
-0x00000000ffffffff] reserved</div><div>[ =C2=A0 =C2=A00.000000] BIOS-e820:=
 [mem 0x0000000100000000-0x000000043fffffff] usable</div><div>[ =C2=A0 =C2=
=A00.000000] NX (Execute Disable) protection: active</div><div>[ =C2=A0 =C2=
=A00.000000] SMBIOS 2.6 present.</div><div>[ =C2=A0 =C2=A00.000000] DMI: MS=
I MS-7666/Big Bang-XPower (MS-7666), BIOS V1.7 07/27/2012</div><div>[ =C2=
=A0 =C2=A00.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D&=
gt; reserved</div><div>[ =C2=A0 =C2=A00.000000] e820: remove [mem 0x000a000=
0-0x000fffff] usable</div><div>[ =C2=A0 =C2=A00.000000] e820: last_pfn =3D =
0x440000 max_arch_pfn =3D 0x400000000</div><div>[ =C2=A0 =C2=A00.000000] MT=
RR default type: uncachable</div><div>[ =C2=A0 =C2=A00.000000] MTRR fixed r=
anges enabled:</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 00000-9FFFF write-=
back</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 A0000-BFFFF uncachable</div>=
<div>[ =C2=A0 =C2=A00.000000] =C2=A0 C0000-D3FFF write-protect</div><div>[ =
=C2=A0 =C2=A00.000000] =C2=A0 D4000-DFFFF uncachable</div><div>[ =C2=A0 =C2=
=A00.000000] =C2=A0 E0000-E3FFF write-protect</div><div>[ =C2=A0 =C2=A00.00=
0000] =C2=A0 E4000-EFFFF write-through</div><div>[ =C2=A0 =C2=A00.000000] =
=C2=A0 F0000-FFFFF write-protect</div><div>[ =C2=A0 =C2=A00.000000] MTRR va=
riable ranges enabled:</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 0 base 000=
0000000 mask FC00000000 write-back</div><div>[ =C2=A0 =C2=A00.000000] =C2=
=A0 1 base 0400000000 mask FFC0000000 write-back</div><div>[ =C2=A0 =C2=A00=
.000000] =C2=A0 2 base 00C0000000 mask FFC0000000 uncachable</div><div>[ =
=C2=A0 =C2=A00.000000] =C2=A0 3 base 00BF800000 mask FFFF800000 uncachable<=
/div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 4 disabled</div><div>[ =C2=A0 =C2=
=A00.000000] =C2=A0 5 disabled</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 6 =
disabled</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 7 disabled</div><div>[ =
=C2=A0 =C2=A00.000000] =C2=A0 8 disabled</div><div>[ =C2=A0 =C2=A00.000000]=
 =C2=A0 9 disabled</div><div>[ =C2=A0 =C2=A00.000000] x86/PAT: Configuratio=
n [0-7]: WB =C2=A0WC =C2=A0UC- UC =C2=A0WB =C2=A0WC =C2=A0UC- WT =C2=A0</di=
v><div>[ =C2=A0 =C2=A00.000000] e820: update [mem 0xbf800000-0xffffffff] us=
able =3D=3D&gt; reserved</div><div>[ =C2=A0 =C2=A00.000000] e820: last_pfn =
=3D 0xbf780 max_arch_pfn =3D 0x400000000</div><div>[ =C2=A0 =C2=A00.000000]=
 found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [ffff8800000ff=
780]</div><div>[ =C2=A0 =C2=A00.000000] Scanning 1 areas for low memory cor=
ruption</div><div>[ =C2=A0 =C2=A00.000000] Base memory trampoline at [ffff8=
80000097000] 97000 size 24576</div><div>[ =C2=A0 =C2=A00.000000] Using GB p=
ages for direct mapping</div><div>[ =C2=A0 =C2=A00.000000] BRK [0x01b58000,=
 0x01b58fff] PGTABLE</div><div>[ =C2=A0 =C2=A00.000000] BRK [0x01b59000, 0x=
01b59fff] PGTABLE</div><div>[ =C2=A0 =C2=A00.000000] BRK [0x01b5a000, 0x01b=
5afff] PGTABLE</div><div>[ =C2=A0 =C2=A00.000000] RAMDISK: [mem 0x3779e000-=
0x37bc6fff]</div><div>[ =C2=A0 =C2=A00.000000] ACPI: Early table checksum v=
erification disabled</div><div>[ =C2=A0 =C2=A00.000000] ACPI: RSDP 0x000000=
00000FA5A0 000014 (v00 ACPIAM)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: RSD=
T 0x00000000BF780000 000040 (v01 7666MS A7666100 20120727 MSFT 00000097)</d=
iv><div>[ =C2=A0 =C2=A00.000000] ACPI: FACP 0x00000000BF780200 000084 (v01 =
7666MS A7666100 20120727 MSFT 00000097)</div><div>[ =C2=A0 =C2=A00.000000] =
ACPI: DSDT 0x00000000BF780600 006CF8 (v01 A7666 =C2=A0A7666100 00000100 INT=
L 20051117)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: FACS 0x00000000BF78E00=
0 000040</div><div>[ =C2=A0 =C2=A00.000000] ACPI: APIC 0x00000000BF780390 0=
000AC (v01 7666MS A7666100 20120727 MSFT 00000097)</div><div>[ =C2=A0 =C2=
=A00.000000] ACPI: MCFG 0x00000000BF780440 00003C (v01 7666MS OEMMCFG =C2=
=A020120727 MSFT 00000097)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: OEMB 0x=
00000000BF78E040 000082 (v01 7666MS A7666100 20120727 MSFT 00000097)</div><=
div>[ =C2=A0 =C2=A00.000000] ACPI: DMAR 0x00000000BF78E0D0 000150 (v01 AMI =
=C2=A0 =C2=A0OEMDMAR =C2=A000000001 MSFT 00000097)</div><div>[ =C2=A0 =C2=
=A00.000000] ACPI: HPET 0x00000000BF78A600 000038 (v01 7666MS OEMHPET =C2=
=A020120727 MSFT 00000097)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: SSDT 0x=
00000000BF790F40 000363 (v01 DpgPmm CpuPm =C2=A0 =C2=A000000012 INTL 200511=
17)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: Local APIC address 0xfee00000<=
/div><div>[ =C2=A0 =C2=A00.000000] No NUMA configuration found</div><div>[ =
=C2=A0 =C2=A00.000000] Faking a node at [mem 0x0000000000000000-0x000000043=
fffffff]</div><div>[ =C2=A0 =C2=A00.000000] NODE_DATA(0) allocated [mem 0x4=
3fffa000-0x43fffdfff]</div><div>[ =C2=A0 =C2=A00.000000] Zone ranges:</div>=
<div>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA =C2=A0 =C2=A0 =C2=A0[mem 0x0000000=
000001000-0x0000000000ffffff]</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA=
32 =C2=A0 =C2=A0[mem 0x0000000001000000-0x00000000ffffffff]</div><div>[ =C2=
=A0 =C2=A00.000000] =C2=A0 Normal =C2=A0 [mem 0x0000000100000000-0x00000004=
3fffffff]</div><div>[ =C2=A0 =C2=A00.000000] Movable zone start for each no=
de</div><div>[ =C2=A0 =C2=A00.000000] Early memory node ranges</div><div>[ =
=C2=A0 =C2=A00.000000] =C2=A0 node =C2=A0 0: [mem 0x0000000000001000-0x0000=
00000009cfff]</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 node =C2=A0 0: [mem=
 0x0000000000100000-0x00000000bf77ffff]</div><div>[ =C2=A0 =C2=A00.000000] =
=C2=A0 node =C2=A0 0: [mem 0x0000000100000000-0x000000043fffffff]</div><div=
>[ =C2=A0 =C2=A00.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00=
0000043fffffff]</div><div>[ =C2=A0 =C2=A00.000000] On node 0 totalpages: 41=
92028</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 64 pages used for=
 memmap</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 21 pages reserv=
ed</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA zone: 3996 pages, LIFO bat=
ch:0</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA32 zone: 12190 pages used=
 for memmap</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 DMA32 zone: 780160 pa=
ges, LIFO batch:31</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 Normal zone: 5=
3248 pages used for memmap</div><div>[ =C2=A0 =C2=A00.000000] =C2=A0 Normal=
 zone: 3407872 pages, LIFO batch:31</div><div>[ =C2=A0 =C2=A00.000000] ACPI=
: PM-Timer IO Port: 0x808</div><div>[ =C2=A0 =C2=A00.000000] ACPI: Local AP=
IC address 0xfee00000</div><div>[ =C2=A0 =C2=A00.000000] IOAPIC[0]: apic_id=
 6, version 32, address 0xfec00000, GSI 0-23</div><div>[ =C2=A0 =C2=A00.000=
000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)</div><div>[ =
=C2=A0 =C2=A00.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)</div><div>[ =C2=A0 =C2=A00.000000] ACPI: IRQ0 used by override.</di=
v><div>[ =C2=A0 =C2=A00.000000] ACPI: IRQ9 used by override.</div><div>[ =
=C2=A0 =C2=A00.000000] Using ACPI (MADT) for SMP configuration information<=
/div><div>[ =C2=A0 =C2=A00.000000] ACPI: HPET id: 0xffffffff base: 0xfed000=
00</div><div>[ =C2=A0 =C2=A00.000000] smpboot: Allowing 12 CPUs, 0 hotplug =
CPUs</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: [mem =
0x00000000-0x00000fff]</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered no=
save memory: [mem 0x0009d000-0x0009ffff]</div><div>[ =C2=A0 =C2=A00.000000]=
 PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]</div><div>[ =C2=
=A0 =C2=A00.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000ffff=
f]</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: [mem 0x=
bf780000-0xbf78dfff]</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosa=
ve memory: [mem 0xbf78e000-0xbf7cffff]</div><div>[ =C2=A0 =C2=A00.000000] P=
M: Registered nosave memory: [mem 0xbf7d0000-0xbf7dffff]</div><div>[ =C2=A0=
 =C2=A00.000000] PM: Registered nosave memory: [mem 0xbf7e0000-0xbf7e7fff]<=
/div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: [mem 0xbf7=
e8000-0xbfffffff]</div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosave =
memory: [mem 0xc0000000-0xfedfffff]</div><div>[ =C2=A0 =C2=A00.000000] PM: =
Registered nosave memory: [mem 0xfee00000-0xfee00fff]</div><div>[ =C2=A0 =
=C2=A00.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffbfffff]</=
div><div>[ =C2=A0 =C2=A00.000000] PM: Registered nosave memory: [mem 0xffc0=
0000-0xffffffff]</div><div>[ =C2=A0 =C2=A00.000000] e820: [mem 0xc0000000-0=
xfedfffff] available for PCI devices</div><div>[ =C2=A0 =C2=A00.000000] Boo=
ting paravirtualized kernel on bare hardware</div><div>[ =C2=A0 =C2=A00.000=
000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff,=
 max_idle_ns: 6370452778343963 ns</div><div>[ =C2=A0 =C2=A00.000000] setup_=
percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:12 nr_node_ids:1</div><d=
iv>[ =C2=A0 =C2=A00.000000] percpu: Embedded 33 pages/cpu @ffff88042f200000=
 s97944 r8192 d29032 u262144</div><div>[ =C2=A0 =C2=A00.000000] pcpu-alloc:=
 s97944 r8192 d29032 u262144 alloc=3D1*2097152</div><div>[ =C2=A0 =C2=A00.0=
00000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -- -- --=
=C2=A0</div><div>[ =C2=A0 =C2=A00.000000] Built 1 zonelists in Node order, =
mobility grouping on.=C2=A0 Total pages: 4126505</div><div>[ =C2=A0 =C2=A00=
.000000] Policy zone: Normal</div><div>[ =C2=A0 =C2=A00.000000] Kernel comm=
and line: BOOT_IMAGE=3D/boot/vmlinuz-linux-git root=3DUUID=3D80dfd13f-1755-=
4c83-b110-84282a777964 rw quiet intel_iommu=3Don</div><div>[ =C2=A0 =C2=A00=
.000000] DMAR: IOMMU enabled</div><div>[ =C2=A0 =C2=A00.000000] PID hash ta=
ble entries: 4096 (order: 3, 32768 bytes)</div><div>[ =C2=A0 =C2=A00.000000=
] Calgary: detecting Calgary via BIOS EBDA area</div><div>[ =C2=A0 =C2=A00.=
000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!</div>=
<div>[ =C2=A0 =C2=A00.000000] Memory: 16422076K/16768112K available (6003K =
kernel code, 978K rwdata, 1836K rodata, 1244K init, 1164K bss, 346036K rese=
rved, 0K cma-reserved)</div><div>[ =C2=A0 =C2=A00.000000] SLUB: HWalign=3D6=
4, Order=3D0-3, MinObjects=3D0, CPUs=3D12, Nodes=3D1</div><div>[ =C2=A0 =C2=
=A00.000000] Preemptible hierarchical RCU implementation.</div><div>[ =C2=
=A0 =C2=A00.000000] <span class=3D"" style=3D"white-space:pre">	</span>Buil=
d-time adjustment of leaf fanout to 64.</div><div>[ =C2=A0 =C2=A00.000000] =
<span class=3D"" style=3D"white-space:pre">	</span>RCU restricting CPUs fro=
m NR_CPUS=3D128 to nr_cpu_ids=3D12.</div><div>[ =C2=A0 =C2=A00.000000] RCU:=
 Adjusting geometry for rcu_fanout_leaf=3D64, nr_cpu_ids=3D12</div><div>[ =
=C2=A0 =C2=A00.000000] NR_IRQS:8448 nr_irqs:520 16</div><div>[ =C2=A0 =C2=
=A00.000000] Console: colour dummy device 80x25</div><div>[ =C2=A0 =C2=A00.=
000000] console [tty0] enabled</div><div>[ =C2=A0 =C2=A00.000000] clocksour=
ce: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 13348488284=
8 ns</div><div>[ =C2=A0 =C2=A00.000000] hpet clockevent registered</div><di=
v>[ =C2=A0 =C2=A00.000000] tsc: Fast TSC calibration using PIT</div><div>[ =
=C2=A0 =C2=A00.000000] tsc: Detected 4399.618 MHz processor</div><div>[ =C2=
=A0 =C2=A00.000018] Calibrating delay loop (skipped), value calculated usin=
g timer frequency.. 8802.87 BogoMIPS (lpj=3D14665393)</div><div>[ =C2=A0 =
=C2=A00.000020] pid_max: default: 32768 minimum: 301</div><div>[ =C2=A0 =C2=
=A00.000025] ACPI: Core revision 20160422</div><div>[ =C2=A0 =C2=A00.000054=
] Security Framework initialized</div><div>[ =C2=A0 =C2=A00.000055] Yama: b=
ecoming mindful.</div><div>[ =C2=A0 =C2=A00.000665] Dentry cache hash table=
 entries: 2097152 (order: 12, 16777216 bytes)</div><div>[ =C2=A0 =C2=A00.00=
3136] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)</d=
iv><div>[ =C2=A0 =C2=A00.004202] Mount-cache hash table entries: 32768 (ord=
er: 6, 262144 bytes)</div><div>[ =C2=A0 =C2=A00.004214] Mountpoint-cache ha=
sh table entries: 32768 (order: 6, 262144 bytes)</div><div>[ =C2=A0 =C2=A00=
.004425] CPU: Physical Processor ID: 0</div><div>[ =C2=A0 =C2=A00.004426] C=
PU: Processor Core ID: 0</div><div>[ =C2=A0 =C2=A00.004432] ENERGY_PERF_BIA=
S: Set to &#39;normal&#39;, was &#39;performance&#39;</div><div>[ =C2=A0 =
=C2=A00.004433] ENERGY_PERF_BIAS: View and update with x86_energy_perf_poli=
cy(8)</div><div>[ =C2=A0 =C2=A00.004435] mce: CPU supports 9 MCE banks</div=
><div>[ =C2=A0 =C2=A00.004441] CPU0: Thermal monitoring enabled (TM1)</div>=
<div>[ =C2=A0 =C2=A00.004451] process: using mwait in idle threads</div><di=
v>[ =C2=A0 =C2=A00.004453] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7</=
div><div>[ =C2=A0 =C2=A00.004454] Last level dTLB entries: 4KB 512, 2MB 32,=
 4MB 32, 1GB 0</div><div>[ =C2=A0 =C2=A00.004644] Freeing SMP alternatives =
memory: 24K (ffffffff81a2d000 - ffffffff81a33000)</div><div>[ =C2=A0 =C2=A0=
0.027646] ftrace: allocating 23795 entries in 93 pages</div><div>[ =C2=A0 =
=C2=A00.034374] smpboot: Max logical packages: 2</div><div>[ =C2=A0 =C2=A00=
.034375] smpboot: APIC(0) Converting physical 0 to logical package 0</div><=
div>[ =C2=A0 =C2=A00.034378] DMAR-IR: This system BIOS has enabled interrup=
t remapping</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0on a chipset that contains an erratum making that</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0feature unstable.=C2=A0 To mai=
ntain system stability</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0interrupt remapping is being disabled.=C2=A0 Please</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0contact your BIOS ve=
ndor for an update</div><div>[ =C2=A0 =C2=A00.034381] Switched APIC routing=
 to physical flat.</div><div>[ =C2=A0 =C2=A00.034740] ..TIMER: vector=3D0x3=
0 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1</div><div>[ =C2=A0 =C2=A00.173157=
] smpboot: CPU0: Intel(R) Xeon(R) CPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X5=
670 =C2=A0@ 2.93GHz (family: 0x6, model: 0x2c, stepping: 0x2)</div><div>[ =
=C2=A0 =C2=A00.173159] Performance Events: PEBS fmt1+, 16-deep LBR, Westmer=
e events, Intel PMU driver.</div><div>[ =C2=A0 =C2=A00.173171] core: CPUID =
marked event: &#39;bus cycles&#39; unavailable</div><div>[ =C2=A0 =C2=A00.1=
73173] ... version: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
3</div><div>[ =C2=A0 =C2=A00.173173] ... bit width: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A048</div><div>[ =C2=A0 =C2=A00.173174] ... generi=
c registers: =C2=A0 =C2=A0 =C2=A04</div><div>[ =C2=A0 =C2=A00.173175] ... v=
alue mask: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0000ffffffffffff</div>=
<div>[ =C2=A0 =C2=A00.173175] ... max period: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 000000007fffffff</div><div>[ =C2=A0 =C2=A00.173176] ... fixed=
-purpose events: =C2=A0 3</div><div>[ =C2=A0 =C2=A00.173176] ... event mask=
: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 000000070000000f</div><div>[ =
=C2=A0 =C2=A00.196723] NMI watchdog: enabled on all CPUs, permanently consu=
mes one hw-PMU counter.</div><div>[ =C2=A0 =C2=A00.213168] x86: Booting SMP=
 configuration:</div><div>[ =C2=A0 =C2=A00.213170] .... node =C2=A0#0, CPUs=
: =C2=A0 =C2=A0 =C2=A0 =C2=A0#1 =C2=A0#2 =C2=A0#3 =C2=A0#4 =C2=A0#5 =C2=A0#=
6 =C2=A0#7 =C2=A0#8 =C2=A0#9 #10 #11</div><div>[ =C2=A0 =C2=A01.265245] x86=
: Booted up 1 node, 12 CPUs</div><div>[ =C2=A0 =C2=A01.265248] smpboot: Tot=
al of 12 processors activated (105638.67 BogoMIPS)</div><div>[ =C2=A0 =C2=
=A01.275873] devtmpfs: initialized</div><div>[ =C2=A0 =C2=A01.275910] x86/m=
m: Memory block size: 128MB</div><div>[ =C2=A0 =C2=A01.277838] PM: Register=
ing ACPI NVS region [mem 0xbf78e000-0xbf7cffff] (270336 bytes)</div><div>[ =
=C2=A0 =C2=A01.277881] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370867519511994 ns</div><div>[ =C2=A0 =C2=A01.2779=
09] pinctrl core: initialized pinctrl subsystem</div><div>[ =C2=A0 =C2=A01.=
277939] RTC time: 15:59:07, date: 06/16/16</div><div>[ =C2=A0 =C2=A01.27884=
0] NET: Registered protocol family 16</div><div>[ =C2=A0 =C2=A01.289878] cp=
uidle: using governor ladder</div><div>[ =C2=A0 =C2=A01.299879] cpuidle: us=
ing governor menu</div><div>[ =C2=A0 =C2=A01.299902] ACPI: bus type PCI reg=
istered</div><div>[ =C2=A0 =C2=A01.299904] acpiphp: ACPI Hot Plug PCI Contr=
oller Driver version: 0.5</div><div>[ =C2=A0 =C2=A01.299952] PCI: MMCONFIG =
for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000=
)</div><div>[ =C2=A0 =C2=A01.299953] PCI: not using MMCONFIG</div><div>[ =
=C2=A0 =C2=A01.299954] PCI: Using configuration type 1 for base access</div=
><div>[ =C2=A0 =C2=A01.313292] HugeTLB registered 1 GB page size, pre-alloc=
ated 0 pages</div><div>[ =C2=A0 =C2=A01.313293] HugeTLB registered 2 MB pag=
e size, pre-allocated 0 pages</div><div>[ =C2=A0 =C2=A01.313419] ACPI: Adde=
d _OSI(Module Device)</div><div>[ =C2=A0 =C2=A01.313420] ACPI: Added _OSI(P=
rocessor Device)</div><div>[ =C2=A0 =C2=A01.313421] ACPI: Added _OSI(3.0 _S=
CP Extensions)</div><div>[ =C2=A0 =C2=A01.313422] ACPI: Added _OSI(Processo=
r Aggregator Device)</div><div>[ =C2=A0 =C2=A01.315189] ACPI: Executed 1 bl=
ocks of module-level executable AML code</div><div>[ =C2=A0 =C2=A01.315317]=
 ACPI: 2 ACPI AML tables successfully acquired and loaded</div><div><br></d=
iv><div>[ =C2=A0 =C2=A01.317263] ACPI: Dynamic OEM Table Load:</div><div>[ =
=C2=A0 =C2=A01.317272] ACPI: SSDT 0xFFFF88042C9EC000 002D18 (v01 DpgPmm P00=
1Ist =C2=A000000011 INTL 20051117)</div><div>[ =C2=A0 =C2=A01.317765] ACPI:=
 Interpreter enabled</div><div>[ =C2=A0 =C2=A01.317774] ACPI: (supports S0 =
S1 S4 S5)</div><div>[ =C2=A0 =C2=A01.317775] ACPI: Using IOAPIC for interru=
pt routing</div><div>[ =C2=A0 =C2=A01.317791] PCI: MMCONFIG for domain 0000=
 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)</div><div>[ =
=C2=A0 =C2=A01.318097] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserve=
d in ACPI motherboard resources</div><div>[ =C2=A0 =C2=A01.318099] pmd_set_=
huge: Cannot satisfy [mem 0xe0000000-0xe0200000] with a huge-page mapping d=
ue to MTRR override.</div><div>[ =C2=A0 =C2=A01.318390] PCI: Using host bri=
dge windows from ACPI; if necessary, use &quot;pci=3Dnocrs&quot; and report=
 a bug</div><div>[ =C2=A0 =C2=A01.321824] ACPI: PCI Root Bridge [PCI0] (dom=
ain 0000 [bus 00-ff])</div><div>[ =C2=A0 =C2=A01.321828] acpi PNP0A08:00: _=
OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]</div><div>[ =C2=
=A0 =C2=A01.321919] acpi PNP0A08:00: _OSC: platform does not support [PCIeC=
apability]</div><div>[ =C2=A0 =C2=A01.321963] acpi PNP0A08:00: _OSC: not re=
questing control; platform does not support [PCIeCapability]</div><div>[ =
=C2=A0 =C2=A01.321964] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME=
 AER PCIeCapability]</div><div>[ =C2=A0 =C2=A01.321965] acpi PNP0A08:00: _O=
SC: platform willing to grant [PCIeHotplug PME AER]</div><div>[ =C2=A0 =C2=
=A01.321966] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM</div=
><div>[ =C2=A0 =C2=A01.322120] PCI host bridge to bus 0000:00</div><div>[ =
=C2=A0 =C2=A01.322122] pci_bus 0000:00: root bus resource [io =C2=A00x0000-=
0x0cf7 window]</div><div>[ =C2=A0 =C2=A01.322123] pci_bus 0000:00: root bus=
 resource [io =C2=A00x0d00-0xffff window]</div><div>[ =C2=A0 =C2=A01.322124=
] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]</di=
v><div>[ =C2=A0 =C2=A01.322125] pci_bus 0000:00: root bus resource [mem 0x0=
00d0000-0x000dffff window]</div><div>[ =C2=A0 =C2=A01.322126] pci_bus 0000:=
00: root bus resource [mem 0xc0000000-0xdfffffff window]</div><div>[ =C2=A0=
 =C2=A01.322127] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed8f=
fff window]</div><div>[ =C2=A0 =C2=A01.322128] pci_bus 0000:00: root bus re=
source [bus 00-ff]</div><div>[ =C2=A0 =C2=A01.322135] pci 0000:00:00.0: [80=
86:3405] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.322175] pci 0000=
:00:00.0: PME# supported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.32=
2229] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400</div><div>[ =C2=
=A0 =C2=A01.322267] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold</=
div><div>[ =C2=A0 =C2=A01.322301] pci 0000:00:01.0: System wakeup disabled =
by ACPI</div><div>[ =C2=A0 =C2=A01.322325] pci 0000:00:02.0: [8086:3409] ty=
pe 01 class 0x060400</div><div>[ =C2=A0 =C2=A01.322362] pci 0000:00:02.0: P=
ME# supported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.322394] pci 0=
000:00:02.0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.3224=
17] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400</div><div>[ =C2=A0=
 =C2=A01.322455] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold</div=
><div>[ =C2=A0 =C2=A01.322488] pci 0000:00:03.0: System wakeup disabled by =
ACPI</div><div>[ =C2=A0 =C2=A01.322511] pci 0000:00:05.0: [8086:340c] type =
01 class 0x060400</div><div>[ =C2=A0 =C2=A01.322545] pci 0000:00:05.0: PME#=
 supported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.322576] pci 0000=
:00:05.0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.322599]=
 pci 0000:00:06.0: [8086:340d] type 01 class 0x060400</div><div>[ =C2=A0 =
=C2=A01.322633] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold</div>=
<div>[ =C2=A0 =C2=A01.322665] pci 0000:00:06.0: System wakeup disabled by A=
CPI</div><div>[ =C2=A0 =C2=A01.322687] pci 0000:00:07.0: [8086:340e] type 0=
1 class 0x060400</div><div>[ =C2=A0 =C2=A01.322722] pci 0000:00:07.0: PME# =
supported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.322754] pci 0000:=
00:07.0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.322776] =
pci 0000:00:09.0: [8086:3410] type 01 class 0x060400</div><div>[ =C2=A0 =C2=
=A01.322810] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold</div><di=
v>[ =C2=A0 =C2=A01.322841] pci 0000:00:09.0: System wakeup disabled by ACPI=
</div><div>[ =C2=A0 =C2=A01.322864] pci 0000:00:0a.0: [8086:3411] type 01 c=
lass 0x060400</div><div>[ =C2=A0 =C2=A01.322898] pci 0000:00:0a.0: PME# sup=
ported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.322929] pci 0000:00:=
0a.0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.322954] pci=
 0000:00:14.0: [8086:342e] type 00 class 0x080000</div><div>[ =C2=A0 =C2=A0=
1.323026] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000</div><div>[ =
=C2=A0 =C2=A01.323096] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000=
</div><div>[ =C2=A0 =C2=A01.323164] pci 0000:00:14.3: [8086:3438] type 00 c=
lass 0x080000</div><div>[ =C2=A0 =C2=A01.323233] pci 0000:00:1a.0: [8086:3a=
37] type 00 class 0x0c0300</div><div>[ =C2=A0 =C2=A01.323265] pci 0000:00:1=
a.0: reg 0x20: [io =C2=A00x6400-0x641f]</div><div>[ =C2=A0 =C2=A01.323328] =
pci 0000:00:1a.0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01=
.323351] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300</div><div>[ =
=C2=A0 =C2=A01.323383] pci 0000:00:1a.1: reg 0x20: [io =C2=A00x6480-0x649f]=
</div><div>[ =C2=A0 =C2=A01.323443] pci 0000:00:1a.1: System wakeup disable=
d by ACPI</div><div>[ =C2=A0 =C2=A01.323467] pci 0000:00:1a.2: [8086:3a39] =
type 00 class 0x0c0300</div><div>[ =C2=A0 =C2=A01.323499] pci 0000:00:1a.2:=
 reg 0x20: [io =C2=A00x6800-0x681f]</div><div>[ =C2=A0 =C2=A01.323559] pci =
0000:00:1a.2: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.323=
588] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320</div><div>[ =C2=
=A0 =C2=A01.323602] pci 0000:00:1a.7: reg 0x10: [mem 0xfb8f8000-0xfb8f83ff]=
</div><div>[ =C2=A0 =C2=A01.323669] pci 0000:00:1a.7: PME# supported from D=
0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.323697] pci 0000:00:1a.7: System =
wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.323722] pci 0000:00:1b.0=
: [8086:3a3e] type 00 class 0x040300</div><div>[ =C2=A0 =C2=A01.323735] pci=
 0000:00:1b.0: reg 0x10: [mem 0xfb8f4000-0xfb8f7fff 64bit]</div><div>[ =C2=
=A0 =C2=A01.323790] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold</=
div><div>[ =C2=A0 =C2=A01.323842] pci 0000:00:1c.0: [8086:3a40] type 01 cla=
ss 0x060400</div><div>[ =C2=A0 =C2=A01.323895] pci 0000:00:1c.0: PME# suppo=
rted from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.323928] pci 0000:00:1c=
.0: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.323952] pci 0=
000:00:1c.1: [8086:3a42] type 01 class 0x060400</div><div>[ =C2=A0 =C2=A01.=
324005] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold</div><div>[ =
=C2=A0 =C2=A01.324037] pci 0000:00:1c.1: System wakeup disabled by ACPI</di=
v><div>[ =C2=A0 =C2=A01.324060] pci 0000:00:1c.2: [8086:3a44] type 01 class=
 0x060400</div><div>[ =C2=A0 =C2=A01.324114] pci 0000:00:1c.2: PME# support=
ed from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.324146] pci 0000:00:1c.2=
: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.324169] pci 000=
0:00:1c.3: [8086:3a46] type 01 class 0x060400</div><div>[ =C2=A0 =C2=A01.32=
4222] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold</div><div>[ =C2=
=A0 =C2=A01.324254] pci 0000:00:1c.3: System wakeup disabled by ACPI</div><=
div>[ =C2=A0 =C2=A01.324278] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x=
060400</div><div>[ =C2=A0 =C2=A01.324331] pci 0000:00:1c.4: PME# supported =
from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.324364] pci 0000:00:1c.4: S=
ystem wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.324389] pci 0000:0=
0:1d.0: [8086:3a34] type 00 class 0x0c0300</div><div>[ =C2=A0 =C2=A01.32442=
1] pci 0000:00:1d.0: reg 0x20: [io =C2=A00x6880-0x689f]</div><div>[ =C2=A0 =
=C2=A01.324481] pci 0000:00:1d.0: System wakeup disabled by ACPI</div><div>=
[ =C2=A0 =C2=A01.324505] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c03=
00</div><div>[ =C2=A0 =C2=A01.324537] pci 0000:00:1d.1: reg 0x20: [io =C2=
=A00x6c00-0x6c1f]</div><div>[ =C2=A0 =C2=A01.324597] pci 0000:00:1d.1: Syst=
em wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.324621] pci 0000:00:1=
d.2: [8086:3a36] type 00 class 0x0c0300</div><div>[ =C2=A0 =C2=A01.324653] =
pci 0000:00:1d.2: reg 0x20: [io =C2=A00x7000-0x701f]</div><div>[ =C2=A0 =C2=
=A01.324713] pci 0000:00:1d.2: System wakeup disabled by ACPI</div><div>[ =
=C2=A0 =C2=A01.324742] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320=
</div><div>[ =C2=A0 =C2=A01.324756] pci 0000:00:1d.7: reg 0x10: [mem 0xfb8f=
a000-0xfb8fa3ff]</div><div>[ =C2=A0 =C2=A01.324823] pci 0000:00:1d.7: PME# =
supported from D0 D3hot D3cold</div><div>[ =C2=A0 =C2=A01.324852] pci 0000:=
00:1d.7: System wakeup disabled by ACPI</div><div>[ =C2=A0 =C2=A01.324874] =
pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401</div><div>[ =C2=A0 =C2=
=A01.324929] pci 0000:00:1e.0: System wakeup disabled by ACPI</div><div>[ =
=C2=A0 =C2=A01.324952] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100=
</div><div>[ =C2=A0 =C2=A01.325016] pci 0000:00:1f.0: quirk: [io =C2=A00x08=
00-0x087f] claimed by ICH6 ACPI/GPIO/TCO</div><div>[ =C2=A0 =C2=A01.325019]=
 pci 0000:00:1f.0: quirk: [io =C2=A00x0500-0x053f] claimed by ICH6 GPIO</di=
v><div>[ =C2=A0 =C2=A01.325021] pci 0000:00:1f.0: ICH7 LPC Generic IO decod=
e 1 PIO at 0a00 (mask 00ff)</div><div>[ =C2=A0 =C2=A01.325023] pci 0000:00:=
1f.0: ICH7 LPC Generic IO decode 2 PIO at 0a00 (mask 0017)</div><div>[ =C2=
=A0 =C2=A01.325025] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 4=
700 (mask 00ff)</div><div>[ =C2=A0 =C2=A01.325091] pci 0000:00:1f.2: [8086:=
3a22] type 00 class 0x010601</div><div>[ =C2=A0 =C2=A01.325102] pci 0000:00=
:1f.2: reg 0x10: [io =C2=A00x7880-0x7887]</div><div>[ =C2=A0 =C2=A01.325107=
] pci 0000:00:1f.2: reg 0x14: [io =C2=A00x7800-0x7803]</div><div>[ =C2=A0 =
=C2=A01.325113] pci 0000:00:1f.2: reg 0x18: [io =C2=A00x7480-0x7487]</div><=
div>[ =C2=A0 =C2=A01.325118] pci 0000:00:1f.2: reg 0x1c: [io =C2=A00x7400-0=
x7403]</div><div>[ =C2=A0 =C2=A01.325124] pci 0000:00:1f.2: reg 0x20: [io =
=C2=A00x7080-0x709f]</div><div>[ =C2=A0 =C2=A01.325129] pci 0000:00:1f.2: r=
eg 0x24: [mem 0xfb8fc000-0xfb8fc7ff]</div><div>[ =C2=A0 =C2=A01.325160] pci=
 0000:00:1f.2: PME# supported from D3hot</div><div>[ =C2=A0 =C2=A01.325206]=
 pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500</div><div>[ =C2=A0 =
=C2=A01.325217] pci 0000:00:1f.3: reg 0x10: [mem 0xfb8fe000-0xfb8fe0ff 64bi=
t]</div><div>[ =C2=A0 =C2=A01.325233] pci 0000:00:1f.3: reg 0x20: [io =C2=
=A00x0400-0x041f]</div><div>[ =C2=A0 =C2=A01.325320] pci 0000:0e:00.0: [103=
3:0194] type 00 class 0x0c0330</div><div>[ =C2=A0 =C2=A01.325334] pci 0000:=
0e:00.0: reg 0x10: [mem 0xfbefe000-0xfbefffff 64bit]</div><div>[ =C2=A0 =C2=
=A01.325404] pci 0000:0e:00.0: PME# supported from D0 D3hot D3cold</div><di=
v>[ =C2=A0 =C2=A01.329889] pci 0000:00:01.0: PCI bridge to [bus 0e]</div><d=
iv>[ =C2=A0 =C2=A01.329894] pci 0000:00:01.0: =C2=A0 bridge window [mem 0xf=
be00000-0xfbefffff]</div><div>[ =C2=A0 =C2=A01.329938] pci 0000:0d:00.0: [1=
b4b:9123] type 00 class 0x010601</div><div>[ =C2=A0 =C2=A01.329947] pci 000=
0:0d:00.0: reg 0x10: [io =C2=A00xe080-0xe087]</div><div>[ =C2=A0 =C2=A01.32=
9952] pci 0000:0d:00.0: reg 0x14: [io =C2=A00xe000-0xe003]</div><div>[ =C2=
=A0 =C2=A01.329957] pci 0000:0d:00.0: reg 0x18: [io =C2=A00xdc00-0xdc07]</d=
iv><div>[ =C2=A0 =C2=A01.329962] pci 0000:0d:00.0: reg 0x1c: [io =C2=A00xd8=
80-0xd883]</div><div>[ =C2=A0 =C2=A01.329968] pci 0000:0d:00.0: reg 0x20: [=
io =C2=A00xd800-0xd80f]</div><div>[ =C2=A0 =C2=A01.329973] pci 0000:0d:00.0=
: reg 0x24: [mem 0xfbddf800-0xfbddffff]</div><div>[ =C2=A0 =C2=A01.329978] =
pci 0000:0d:00.0: reg 0x30: [mem 0xfbdc0000-0xfbdcffff pref]</div><div>[ =
=C2=A0 =C2=A01.329985] pci 0000:0d:00.0: Enabling fixed DMA alias to 00.1</=
div><div>[ =C2=A0 =C2=A01.330006] pci 0000:0d:00.0: PME# supported from D3h=
ot</div><div>[ =C2=A0 =C2=A01.336553] pci 0000:00:02.0: PCI bridge to [bus =
0d]</div><div>[ =C2=A0 =C2=A01.336557] pci 0000:00:02.0: =C2=A0 bridge wind=
ow [io =C2=A00xd000-0xefff]</div><div>[ =C2=A0 =C2=A01.336560] pci 0000:00:=
02.0: =C2=A0 bridge window [mem 0xfbd00000-0xfbdfffff]</div><div>[ =C2=A0 =
=C2=A01.336604] pci 0000:0c:00.0: [10de:0622] type 00 class 0x030000</div><=
div>[ =C2=A0 =C2=A01.336612] pci 0000:0c:00.0: reg 0x10: [mem 0xfa000000-0x=
faffffff]</div><div>[ =C2=A0 =C2=A01.336620] pci 0000:0c:00.0: reg 0x14: [m=
em 0xd0000000-0xdfffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.336628] pci=
 0000:0c:00.0: reg 0x1c: [mem 0xf8000000-0xf9ffffff 64bit]</div><div>[ =C2=
=A0 =C2=A01.336633] pci 0000:0c:00.0: reg 0x24: [io =C2=A00xcc00-0xcc7f]</d=
iv><div>[ =C2=A0 =C2=A01.336638] pci 0000:0c:00.0: reg 0x30: [mem 0xf7f8000=
0-0xf7ffffff pref]</div><div>[ =C2=A0 =C2=A01.343220] pci 0000:00:03.0: PCI=
 bridge to [bus 0c]</div><div>[ =C2=A0 =C2=A01.343224] pci 0000:00:03.0: =
=C2=A0 bridge window [io =C2=A00xc000-0xcfff]</div><div>[ =C2=A0 =C2=A01.34=
3226] pci 0000:00:03.0: =C2=A0 bridge window [mem 0xf7f00000-0xfaffffff]</d=
iv><div>[ =C2=A0 =C2=A01.343231] pci 0000:00:03.0: =C2=A0 bridge window [me=
m 0xd0000000-0xdfffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.343264] pci =
0000:00:05.0: PCI bridge to [bus 0b]</div><div>[ =C2=A0 =C2=A01.343291] pci=
 0000:00:06.0: PCI bridge to [bus 0a]</div><div>[ =C2=A0 =C2=A01.343317] pc=
i 0000:00:07.0: PCI bridge to [bus 09]</div><div>[ =C2=A0 =C2=A01.343343] p=
ci 0000:00:09.0: PCI bridge to [bus 08]</div><div>[ =C2=A0 =C2=A01.343369] =
pci 0000:00:0a.0: PCI bridge to [bus 07]</div><div>[ =C2=A0 =C2=A01.343412]=
 pci 0000:06:00.0: [10ec:8168] type 00 class 0x020000</div><div>[ =C2=A0 =
=C2=A01.343428] pci 0000:06:00.0: reg 0x10: [io =C2=A00xb800-0xb8ff]</div><=
div>[ =C2=A0 =C2=A01.343451] pci 0000:06:00.0: reg 0x18: [mem 0xf5fff000-0x=
f5ffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.343466] pci 0000:06:00.0: r=
eg 0x20: [mem 0xf5ff8000-0xf5ffbfff 64bit pref]</div><div>[ =C2=A0 =C2=A01.=
343475] pci 0000:06:00.0: reg 0x30: [mem 0xfbce0000-0xfbcfffff pref]</div><=
div>[ =C2=A0 =C2=A01.343543] pci 0000:06:00.0: supports D1 D2</div><div>[ =
=C2=A0 =C2=A01.343544] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot=
 D3cold</div><div>[ =C2=A0 =C2=A01.349891] pci 0000:00:1c.0: PCI bridge to =
[bus 06]</div><div>[ =C2=A0 =C2=A01.349896] pci 0000:00:1c.0: =C2=A0 bridge=
 window [io =C2=A00xb000-0xbfff]</div><div>[ =C2=A0 =C2=A01.349899] pci 000=
0:00:1c.0: =C2=A0 bridge window [mem 0xfbc00000-0xfbcfffff]</div><div>[ =C2=
=A0 =C2=A01.349904] pci 0000:00:1c.0: =C2=A0 bridge window [mem 0xf5f00000-=
0xf5ffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.349951] pci 0000:05:00.0:=
 [10ec:8168] type 00 class 0x020000</div><div>[ =C2=A0 =C2=A01.349967] pci =
0000:05:00.0: reg 0x10: [io =C2=A00xa800-0xa8ff]</div><div>[ =C2=A0 =C2=A01=
.349990] pci 0000:05:00.0: reg 0x18: [mem 0xf5eff000-0xf5efffff 64bit pref]=
</div><div>[ =C2=A0 =C2=A01.350005] pci 0000:05:00.0: reg 0x20: [mem 0xf5ef=
8000-0xf5efbfff 64bit pref]</div><div>[ =C2=A0 =C2=A01.350014] pci 0000:05:=
00.0: reg 0x30: [mem 0xfbbe0000-0xfbbfffff pref]</div><div>[ =C2=A0 =C2=A01=
.350082] pci 0000:05:00.0: supports D1 D2</div><div>[ =C2=A0 =C2=A01.350083=
] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold</div><div>[ =
=C2=A0 =C2=A01.356558] pci 0000:00:1c.1: PCI bridge to [bus 05]</div><div>[=
 =C2=A0 =C2=A01.356562] pci 0000:00:1c.1: =C2=A0 bridge window [io =C2=A00x=
a000-0xafff]</div><div>[ =C2=A0 =C2=A01.356566] pci 0000:00:1c.1: =C2=A0 br=
idge window [mem 0xfbb00000-0xfbbfffff]</div><div>[ =C2=A0 =C2=A01.356571] =
pci 0000:00:1c.1: =C2=A0 bridge window [mem 0xf5e00000-0xf5efffff 64bit pre=
f]</div><div>[ =C2=A0 =C2=A01.356618] pci 0000:04:00.0: [1106:3403] type 00=
 class 0x0c0010</div><div>[ =C2=A0 =C2=A01.356639] pci 0000:04:00.0: reg 0x=
10: [mem 0xfbaff800-0xfbafffff 64bit]</div><div>[ =C2=A0 =C2=A01.356649] pc=
i 0000:04:00.0: reg 0x18: [io =C2=A00x9800-0x98ff]</div><div>[ =C2=A0 =C2=
=A01.356737] pci 0000:04:00.0: supports D2</div><div>[ =C2=A0 =C2=A01.35673=
8] pci 0000:04:00.0: PME# supported from D2 D3hot D3cold</div><div>[ =C2=A0=
 =C2=A01.363225] pci 0000:00:1c.2: PCI bridge to [bus 04]</div><div>[ =C2=
=A0 =C2=A01.363229] pci 0000:00:1c.2: =C2=A0 bridge window [io =C2=A00x9000=
-0x9fff]</div><div>[ =C2=A0 =C2=A01.363233] pci 0000:00:1c.2: =C2=A0 bridge=
 window [mem 0xfba00000-0xfbafffff]</div><div>[ =C2=A0 =C2=A01.363291] pci =
0000:03:00.0: [197b:2362] type 00 class 0x010601</div><div>[ =C2=A0 =C2=A01=
.363320] pci 0000:03:00.0: reg 0x10: [io =C2=A00x8c00-0x8c07]</div><div>[ =
=C2=A0 =C2=A01.363331] pci 0000:03:00.0: reg 0x14: [io =C2=A00x8880-0x8883]=
</div><div>[ =C2=A0 =C2=A01.363342] pci 0000:03:00.0: reg 0x18: [io =C2=A00=
x8800-0x8807]</div><div>[ =C2=A0 =C2=A01.363354] pci 0000:03:00.0: reg 0x1c=
: [io =C2=A00x8480-0x8483]</div><div>[ =C2=A0 =C2=A01.363365] pci 0000:03:0=
0.0: reg 0x20: [io =C2=A00x8400-0x840f]</div><div>[ =C2=A0 =C2=A01.363377] =
pci 0000:03:00.0: reg 0x24: [mem 0xfb9ffc00-0xfb9ffdff]</div><div>[ =C2=A0 =
=C2=A01.363388] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref=
]</div><div>[ =C2=A0 =C2=A01.363438] pci 0000:03:00.0: PME# supported from =
D3hot</div><div>[ =C2=A0 =C2=A01.369892] pci 0000:00:1c.3: PCI bridge to [b=
us 03]</div><div>[ =C2=A0 =C2=A01.369896] pci 0000:00:1c.3: =C2=A0 bridge w=
indow [io =C2=A00x8000-0x8fff]</div><div>[ =C2=A0 =C2=A01.369900] pci 0000:=
00:1c.3: =C2=A0 bridge window [mem 0xfb900000-0xfb9fffff]</div><div>[ =C2=
=A0 =C2=A01.369953] pci 0000:02:00.0: [1102:000b] type 00 class 0x040300</d=
iv><div>[ =C2=A0 =C2=A01.369977] pci 0000:02:00.0: reg 0x10: [mem 0xf7ef000=
0-0xf7efffff 64bit]</div><div>[ =C2=A0 =C2=A01.369993] pci 0000:02:00.0: re=
g 0x18: [mem 0xf7c00000-0xf7dfffff 64bit]</div><div>[ =C2=A0 =C2=A01.370010=
] pci 0000:02:00.0: reg 0x20: [mem 0xf6000000-0xf6ffffff 64bit]</div><div>[=
 =C2=A0 =C2=A01.376559] pci 0000:00:1c.4: PCI bridge to [bus 02]</div><div>=
[ =C2=A0 =C2=A01.376564] pci 0000:00:1c.4: =C2=A0 bridge window [mem 0xf600=
0000-0xf7efffff]</div><div>[ =C2=A0 =C2=A01.376627] pci 0000:00:1e.0: PCI b=
ridge to [bus 01] (subtractive decode)</div><div>[ =C2=A0 =C2=A01.376634] p=
ci 0000:00:1e.0: =C2=A0 bridge window [io =C2=A00x0000-0x0cf7 window] (subt=
ractive decode)</div><div>[ =C2=A0 =C2=A01.376635] pci 0000:00:1e.0: =C2=A0=
 bridge window [io =C2=A00x0d00-0xffff window] (subtractive decode)</div><d=
iv>[ =C2=A0 =C2=A01.376636] pci 0000:00:1e.0: =C2=A0 bridge window [mem 0x0=
00a0000-0x000bffff window] (subtractive decode)</div><div>[ =C2=A0 =C2=A01.=
376637] pci 0000:00:1e.0: =C2=A0 bridge window [mem 0x000d0000-0x000dffff w=
indow] (subtractive decode)</div><div>[ =C2=A0 =C2=A01.376638] pci 0000:00:=
1e.0: =C2=A0 bridge window [mem 0xc0000000-0xdfffffff window] (subtractive =
decode)</div><div>[ =C2=A0 =C2=A01.376639] pci 0000:00:1e.0: =C2=A0 bridge =
window [mem 0xf0000000-0xfed8ffff window] (subtractive decode)</div><div>[ =
=C2=A0 =C2=A01.376915] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11 =
12 14 *15)</div><div>[ =C2=A0 =C2=A01.376944] ACPI: PCI Interrupt Link [LNK=
B] (IRQs *5)</div><div>[ =C2=A0 =C2=A01.376972] ACPI: PCI Interrupt Link [L=
NKC] (IRQs 3 4 6 7 10 *11 12 14 15)</div><div>[ =C2=A0 =C2=A01.377000] ACPI=
: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 *10 11 12 14 15)</div><div>[ =C2=
=A0 =C2=A01.377029] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 =
14 15) *0, disabled.</div><div>[ =C2=A0 =C2=A01.377058] ACPI: PCI Interrupt=
 Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14 15)</div><div>[ =C2=A0 =C2=A01.3770=
86] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 6 7 10 11 12 14 15)</div><di=
v>[ =C2=A0 =C2=A01.377115] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10=
 11 12 *14 15)</div><div>[ =C2=A0 =C2=A01.377144] ACPI: Enabled 1 GPEs in b=
lock 00 to 3F</div><div>[ =C2=A0 =C2=A01.377190] vgaarb: setting as boot de=
vice: PCI:0000:0c:00.0</div><div>[ =C2=A0 =C2=A01.377191] vgaarb: device ad=
ded: PCI:0000:0c:00.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone</div><div=
>[ =C2=A0 =C2=A01.377192] vgaarb: loaded</div><div>[ =C2=A0 =C2=A01.377193]=
 vgaarb: bridge control possible 0000:0c:00.0</div><div>[ =C2=A0 =C2=A01.37=
7234] PCI: Using ACPI for IRQ routing</div><div>[ =C2=A0 =C2=A01.381779] PC=
I: Discovered peer bus ff</div><div>[ =C2=A0 =C2=A01.381781] PCI: root bus =
ff: using default resources</div><div>[ =C2=A0 =C2=A01.381782] PCI: Probing=
 PCI hardware (bus ff)</div><div>[ =C2=A0 =C2=A01.381804] ACPI: \: failed t=
o evaluate _DSM (0x1001)</div><div>[ =C2=A0 =C2=A01.381804] PCI host bridge=
 to bus 0000:ff</div><div>[ =C2=A0 =C2=A01.381806] pci_bus 0000:ff: root bu=
s resource [io =C2=A00x0000-0xffff]</div><div>[ =C2=A0 =C2=A01.381807] pci_=
bus 0000:ff: root bus resource [mem 0x00000000-0xffffffffff]</div><div>[ =
=C2=A0 =C2=A01.381808] pci_bus 0000:ff: No busn resource found for root bus=
, will use [bus ff-ff]</div><div>[ =C2=A0 =C2=A01.381809] pci_bus 0000:ff: =
busn_res: can not insert [bus ff] under domain [bus 00-ff] (conflicts with =
(null) [bus 00-ff])</div><div>[ =C2=A0 =C2=A01.381812] pci 0000:ff:00.0: [8=
086:2c70] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.381839] pci 000=
0:ff:00.1: [8086:2d81] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.38=
1863] pci 0000:ff:02.0: [8086:2d90] type 00 class 0x060000</div><div>[ =C2=
=A0 =C2=A01.381886] pci 0000:ff:02.1: [8086:2d91] type 00 class 0x060000</d=
iv><div>[ =C2=A0 =C2=A01.381912] pci 0000:ff:02.2: [8086:2d92] type 00 clas=
s 0x060000</div><div>[ =C2=A0 =C2=A01.381936] pci 0000:ff:02.3: [8086:2d93]=
 type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.381958] pci 0000:ff:02.4=
: [8086:2d94] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.381981] pci=
 0000:ff:02.5: [8086:2d95] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A0=
1.382005] pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000</div><div>[ =
=C2=A0 =C2=A01.382027] pci 0000:ff:03.1: [8086:2d99] type 00 class 0x060000=
</div><div>[ =C2=A0 =C2=A01.382050] pci 0000:ff:03.2: [8086:2d9a] type 00 c=
lass 0x060000</div><div>[ =C2=A0 =C2=A01.382073] pci 0000:ff:03.4: [8086:2d=
9c] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.382096] pci 0000:ff:0=
4.0: [8086:2da0] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.382119] =
pci 0000:ff:04.1: [8086:2da1] type 00 class 0x060000</div><div>[ =C2=A0 =C2=
=A01.382142] pci 0000:ff:04.2: [8086:2da2] type 00 class 0x060000</div><div=
>[ =C2=A0 =C2=A01.382165] pci 0000:ff:04.3: [8086:2da3] type 00 class 0x060=
000</div><div>[ =C2=A0 =C2=A01.382189] pci 0000:ff:05.0: [8086:2da8] type 0=
0 class 0x060000</div><div>[ =C2=A0 =C2=A01.382212] pci 0000:ff:05.1: [8086=
:2da9] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.382235] pci 0000:f=
f:05.2: [8086:2daa] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.38225=
8] pci 0000:ff:05.3: [8086:2dab] type 00 class 0x060000</div><div>[ =C2=A0 =
=C2=A01.382282] pci 0000:ff:06.0: [8086:2db0] type 00 class 0x060000</div><=
div>[ =C2=A0 =C2=A01.382306] pci 0000:ff:06.1: [8086:2db1] type 00 class 0x=
060000</div><div>[ =C2=A0 =C2=A01.382328] pci 0000:ff:06.2: [8086:2db2] typ=
e 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.382351] pci 0000:ff:06.3: [8=
086:2db3] type 00 class 0x060000</div><div>[ =C2=A0 =C2=A01.382382] pci_bus=
 0000:ff: busn_res: [bus ff] end is updated to ff</div><div>[ =C2=A0 =C2=A0=
1.382383] pci_bus 0000:ff: busn_res: can not insert [bus ff] under domain [=
bus 00-ff] (conflicts with (null) [bus 00-ff])</div><div>[ =C2=A0 =C2=A01.3=
82387] PCI: pci_cache_line_size set to 64 bytes</div><div>[ =C2=A0 =C2=A01.=
382463] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]</div><div>[ =
=C2=A0 =C2=A01.382464] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]=
</div><div>[ =C2=A0 =C2=A01.382523] NetLabel: Initializing</div><div>[ =C2=
=A0 =C2=A01.382524] NetLabel: =C2=A0domain hash size =3D 128</div><div>[ =
=C2=A0 =C2=A01.382524] NetLabel: =C2=A0protocols =3D UNLABELED CIPSOv4</div=
><div>[ =C2=A0 =C2=A01.382531] NetLabel: =C2=A0unlabeled traffic allowed by=
 default</div><div>[ =C2=A0 =C2=A01.382561] hpet0: at MMIO 0xfed00000, IRQs=
 2, 8, 0, 0</div><div>[ =C2=A0 =C2=A01.382563] hpet0: 4 comparators, 64-bit=
 14.318180 MHz counter</div><div>[ =C2=A0 =C2=A01.384581] clocksource: Swit=
ched to clocksource hpet</div><div>[ =C2=A0 =C2=A01.387741] VFS: Disk quota=
s dquot_6.6.0</div><div>[ =C2=A0 =C2=A01.387753] VFS: Dquot-cache hash tabl=
e entries: 512 (order 0, 4096 bytes)</div><div>[ =C2=A0 =C2=A01.387794] pnp=
: PnP ACPI init</div><div>[ =C2=A0 =C2=A01.387834] system 00:00: [mem 0xfbf=
00000-0xfbffffff] has been reserved</div><div>[ =C2=A0 =C2=A01.387836] syst=
em 00:00: [mem 0xfc000000-0xfcffffff] has been reserved</div><div>[ =C2=A0 =
=C2=A01.387837] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved=
</div><div>[ =C2=A0 =C2=A01.387838] system 00:00: [mem 0xfe000000-0xfebffff=
f] has been reserved</div><div>[ =C2=A0 =C2=A01.387839] system 00:00: [mem =
0xfec8a000-0xfec8afff] has been reserved</div><div>[ =C2=A0 =C2=A01.387840]=
 system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved</div><div>[ =
=C2=A0 =C2=A01.387842] system 00:00: Plug and Play ACPI device, IDs PNP0c01=
 (active)</div><div>[ =C2=A0 =C2=A01.387873] pnp 00:01: Plug and Play ACPI =
device, IDs PNP0b00 (active)</div><div>[ =C2=A0 =C2=A01.387966] system 00:0=
2: [io =C2=A00x0a00-0x0adf] has been reserved</div><div>[ =C2=A0 =C2=A01.38=
7968] system 00:02: [io =C2=A00x0ae0-0x0aef] has been reserved</div><div>[ =
=C2=A0 =C2=A01.387969] system 00:02: Plug and Play ACPI device, IDs PNP0c02=
 (active)</div><div>[ =C2=A0 =C2=A01.388067] system 00:03: [io =C2=A00x04d0=
-0x04d1] has been reserved</div><div>[ =C2=A0 =C2=A01.388068] system 00:03:=
 [io =C2=A00x0800-0x087f] has been reserved</div><div>[ =C2=A0 =C2=A01.3880=
69] system 00:03: [io =C2=A00x0500-0x057f] could not be reserved</div><div>=
[ =C2=A0 =C2=A01.388071] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been=
 reserved</div><div>[ =C2=A0 =C2=A01.388072] system 00:03: [mem 0xfed20000-=
0xfed3ffff] has been reserved</div><div>[ =C2=A0 =C2=A01.388073] system 00:=
03: [mem 0xfed45000-0xfed89fff] has been reserved</div><div>[ =C2=A0 =C2=A0=
1.388074] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved</div>=
<div>[ =C2=A0 =C2=A01.388076] system 00:03: [mem 0xfed40000-0xfed8ffff] cou=
ld not be reserved</div><div>[ =C2=A0 =C2=A01.388077] system 00:03: Plug an=
d Play ACPI device, IDs PNP0c02 (active)</div><div>[ =C2=A0 =C2=A01.388154]=
 system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved</div><div>=
[ =C2=A0 =C2=A01.388156] system 00:04: [mem 0xfee00000-0xfee00fff] has been=
 reserved</div><div>[ =C2=A0 =C2=A01.388158] system 00:04: Plug and Play AC=
PI device, IDs PNP0c02 (active)</div><div>[ =C2=A0 =C2=A01.388206] system 0=
0:05: [mem 0xe0000000-0xefffffff] has been reserved</div><div>[ =C2=A0 =C2=
=A01.388208] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)<=
/div><div>[ =C2=A0 =C2=A01.388312] system 00:06: [mem 0x00000000-0x0009ffff=
] could not be reserved</div><div>[ =C2=A0 =C2=A01.388314] system 00:06: [m=
em 0x000c0000-0x000cffff] could not be reserved</div><div>[ =C2=A0 =C2=A01.=
388315] system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved</di=
v><div>[ =C2=A0 =C2=A01.388316] system 00:06: [mem 0x00100000-0xbfffffff] c=
ould not be reserved</div><div>[ =C2=A0 =C2=A01.388317] system 00:06: [mem =
0xfed90000-0xffffffff] could not be reserved</div><div>[ =C2=A0 =C2=A01.388=
319] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)</div><di=
v>[ =C2=A0 =C2=A01.388382] pnp: PnP ACPI: found 7 devices</div><div>[ =C2=
=A0 =C2=A01.393990] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffff=
ff, max_idle_ns: 2085701024 ns</div><div>[ =C2=A0 =C2=A01.394033] pci 0000:=
00:1c.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] a=
dd_size 200000 add_align 100000</div><div>[ =C2=A0 =C2=A01.394038] pci 0000=
:00:1c.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] =
add_size 200000 add_align 100000</div><div>[ =C2=A0 =C2=A01.394044] pci 000=
0:00:1c.4: bridge window [io =C2=A00x1000-0x0fff] to [bus 02] add_size 1000=
</div><div>[ =C2=A0 =C2=A01.394045] pci 0000:00:1c.4: bridge window [mem 0x=
00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 10000=
0</div><div>[ =C2=A0 =C2=A01.394056] pci 0000:00:1c.2: res[15]=3D[mem 0x001=
00000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 10000=
0</div><div>[ =C2=A0 =C2=A01.394058] pci 0000:00:1c.2: res[15]=3D[mem 0x001=
00000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 10000=
0</div><div>[ =C2=A0 =C2=A01.394059] pci 0000:00:1c.3: res[15]=3D[mem 0x001=
00000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 10000=
0</div><div>[ =C2=A0 =C2=A01.394060] pci 0000:00:1c.3: res[15]=3D[mem 0x001=
00000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 10000=
0</div><div>[ =C2=A0 =C2=A01.394061] pci 0000:00:1c.4: res[15]=3D[mem 0x001=
00000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 10000=
0</div><div>[ =C2=A0 =C2=A01.394062] pci 0000:00:1c.4: res[15]=3D[mem 0x001=
00000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 10000=
0</div><div>[ =C2=A0 =C2=A01.394063] pci 0000:00:1c.4: res[13]=3D[io =C2=A0=
0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000</div><div>[ =C2=
=A0 =C2=A01.394064] pci 0000:00:1c.4: res[13]=3D[io =C2=A00x1000-0x1fff] re=
s_to_dev_res add_size 1000 min_align 1000</div><div>[ =C2=A0 =C2=A01.394068=
] pci 0000:00:1c.2: BAR 15: assigned [mem 0xc0000000-0xc01fffff 64bit pref]=
</div><div>[ =C2=A0 =C2=A01.394071] pci 0000:00:1c.3: BAR 15: assigned [mem=
 0xc0200000-0xc03fffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.394073] pci 0=
000:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc05fffff 64bit pref]</div><=
div>[ =C2=A0 =C2=A01.394074] pci 0000:00:1c.4: BAR 13: assigned [io =C2=A00=
x1000-0x1fff]</div><div>[ =C2=A0 =C2=A01.394076] pci 0000:00:01.0: PCI brid=
ge to [bus 0e]</div><div>[ =C2=A0 =C2=A01.394079] pci 0000:00:01.0: =C2=A0 =
bridge window [mem 0xfbe00000-0xfbefffff]</div><div>[ =C2=A0 =C2=A01.394083=
] pci 0000:00:02.0: PCI bridge to [bus 0d]</div><div>[ =C2=A0 =C2=A01.39408=
4] pci 0000:00:02.0: =C2=A0 bridge window [io =C2=A00xd000-0xefff]</div><di=
v>[ =C2=A0 =C2=A01.394087] pci 0000:00:02.0: =C2=A0 bridge window [mem 0xfb=
d00000-0xfbdfffff]</div><div>[ =C2=A0 =C2=A01.394090] pci 0000:00:03.0: PCI=
 bridge to [bus 0c]</div><div>[ =C2=A0 =C2=A01.394092] pci 0000:00:03.0: =
=C2=A0 bridge window [io =C2=A00xc000-0xcfff]</div><div>[ =C2=A0 =C2=A01.39=
4094] pci 0000:00:03.0: =C2=A0 bridge window [mem 0xf7f00000-0xfaffffff]</d=
iv><div>[ =C2=A0 =C2=A01.394096] pci 0000:00:03.0: =C2=A0 bridge window [me=
m 0xd0000000-0xdfffffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.394099] pci =
0000:00:05.0: PCI bridge to [bus 0b]</div><div>[ =C2=A0 =C2=A01.394104] pci=
 0000:00:06.0: PCI bridge to [bus 0a]</div><div>[ =C2=A0 =C2=A01.394109] pc=
i 0000:00:07.0: PCI bridge to [bus 09]</div><div>[ =C2=A0 =C2=A01.394114] p=
ci 0000:00:09.0: PCI bridge to [bus 08]</div><div>[ =C2=A0 =C2=A01.394120] =
pci 0000:00:0a.0: PCI bridge to [bus 07]</div><div>[ =C2=A0 =C2=A01.394125]=
 pci 0000:00:1c.0: PCI bridge to [bus 06]</div><div>[ =C2=A0 =C2=A01.394127=
] pci 0000:00:1c.0: =C2=A0 bridge window [io =C2=A00xb000-0xbfff]</div><div=
>[ =C2=A0 =C2=A01.394130] pci 0000:00:1c.0: =C2=A0 bridge window [mem 0xfbc=
00000-0xfbcfffff]</div><div>[ =C2=A0 =C2=A01.394132] pci 0000:00:1c.0: =C2=
=A0 bridge window [mem 0xf5f00000-0xf5ffffff 64bit pref]</div><div>[ =C2=A0=
 =C2=A01.394136] pci 0000:00:1c.1: PCI bridge to [bus 05]</div><div>[ =C2=
=A0 =C2=A01.394137] pci 0000:00:1c.1: =C2=A0 bridge window [io =C2=A00xa000=
-0xafff]</div><div>[ =C2=A0 =C2=A01.394140] pci 0000:00:1c.1: =C2=A0 bridge=
 window [mem 0xfbb00000-0xfbbfffff]</div><div>[ =C2=A0 =C2=A01.394142] pci =
0000:00:1c.1: =C2=A0 bridge window [mem 0xf5e00000-0xf5efffff 64bit pref]</=
div><div>[ =C2=A0 =C2=A01.394146] pci 0000:00:1c.2: PCI bridge to [bus 04]<=
/div><div>[ =C2=A0 =C2=A01.394147] pci 0000:00:1c.2: =C2=A0 bridge window [=
io =C2=A00x9000-0x9fff]</div><div>[ =C2=A0 =C2=A01.394150] pci 0000:00:1c.2=
: =C2=A0 bridge window [mem 0xfba00000-0xfbafffff]</div><div>[ =C2=A0 =C2=
=A01.394153] pci 0000:00:1c.2: =C2=A0 bridge window [mem 0xc0000000-0xc01ff=
fff 64bit pref]</div><div>[ =C2=A0 =C2=A01.394157] pci 0000:03:00.0: BAR 6:=
 assigned [mem 0xfb900000-0xfb90ffff pref]</div><div>[ =C2=A0 =C2=A01.39415=
8] pci 0000:00:1c.3: PCI bridge to [bus 03]</div><div>[ =C2=A0 =C2=A01.3941=
59] pci 0000:00:1c.3: =C2=A0 bridge window [io =C2=A00x8000-0x8fff]</div><d=
iv>[ =C2=A0 =C2=A01.394162] pci 0000:00:1c.3: =C2=A0 bridge window [mem 0xf=
b900000-0xfb9fffff]</div><div>[ =C2=A0 =C2=A01.394164] pci 0000:00:1c.3: =
=C2=A0 bridge window [mem 0xc0200000-0xc03fffff 64bit pref]</div><div>[ =C2=
=A0 =C2=A01.394168] pci 0000:00:1c.4: PCI bridge to [bus 02]</div><div>[ =
=C2=A0 =C2=A01.394170] pci 0000:00:1c.4: =C2=A0 bridge window [io =C2=A00x1=
000-0x1fff]</div><div>[ =C2=A0 =C2=A01.394173] pci 0000:00:1c.4: =C2=A0 bri=
dge window [mem 0xf6000000-0xf7efffff]</div><div>[ =C2=A0 =C2=A01.394175] p=
ci 0000:00:1c.4: =C2=A0 bridge window [mem 0xc0400000-0xc05fffff 64bit pref=
]</div><div>[ =C2=A0 =C2=A01.394179] pci 0000:00:1e.0: PCI bridge to [bus 0=
1]</div><div>[ =C2=A0 =C2=A01.394186] pci_bus 0000:00: resource 4 [io =C2=
=A00x0000-0x0cf7 window]</div><div>[ =C2=A0 =C2=A01.394187] pci_bus 0000:00=
: resource 5 [io =C2=A00x0d00-0xffff window]</div><div>[ =C2=A0 =C2=A01.394=
188] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]</div><d=
iv>[ =C2=A0 =C2=A01.394189] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x0=
00dffff window]</div><div>[ =C2=A0 =C2=A01.394190] pci_bus 0000:00: resourc=
e 8 [mem 0xc0000000-0xdfffffff window]</div><div>[ =C2=A0 =C2=A01.394191] p=
ci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff window]</div><div>[ =
=C2=A0 =C2=A01.394192] pci_bus 0000:0e: resource 1 [mem 0xfbe00000-0xfbefff=
ff]</div><div>[ =C2=A0 =C2=A01.394193] pci_bus 0000:0d: resource 0 [io =C2=
=A00xd000-0xefff]</div><div>[ =C2=A0 =C2=A01.394194] pci_bus 0000:0d: resou=
rce 1 [mem 0xfbd00000-0xfbdfffff]</div><div>[ =C2=A0 =C2=A01.394195] pci_bu=
s 0000:0c: resource 0 [io =C2=A00xc000-0xcfff]</div><div>[ =C2=A0 =C2=A01.3=
94196] pci_bus 0000:0c: resource 1 [mem 0xf7f00000-0xfaffffff]</div><div>[ =
=C2=A0 =C2=A01.394197] pci_bus 0000:0c: resource 2 [mem 0xd0000000-0xdfffff=
ff 64bit pref]</div><div>[ =C2=A0 =C2=A01.394198] pci_bus 0000:06: resource=
 0 [io =C2=A00xb000-0xbfff]</div><div>[ =C2=A0 =C2=A01.394199] pci_bus 0000=
:06: resource 1 [mem 0xfbc00000-0xfbcfffff]</div><div>[ =C2=A0 =C2=A01.3942=
00] pci_bus 0000:06: resource 2 [mem 0xf5f00000-0xf5ffffff 64bit pref]</div=
><div>[ =C2=A0 =C2=A01.394201] pci_bus 0000:05: resource 0 [io =C2=A00xa000=
-0xafff]</div><div>[ =C2=A0 =C2=A01.394202] pci_bus 0000:05: resource 1 [me=
m 0xfbb00000-0xfbbfffff]</div><div>[ =C2=A0 =C2=A01.394203] pci_bus 0000:05=
: resource 2 [mem 0xf5e00000-0xf5efffff 64bit pref]</div><div>[ =C2=A0 =C2=
=A01.394204] pci_bus 0000:04: resource 0 [io =C2=A00x9000-0x9fff]</div><div=
>[ =C2=A0 =C2=A01.394204] pci_bus 0000:04: resource 1 [mem 0xfba00000-0xfba=
fffff]</div><div>[ =C2=A0 =C2=A01.394205] pci_bus 0000:04: resource 2 [mem =
0xc0000000-0xc01fffff 64bit pref]</div><div>[ =C2=A0 =C2=A01.394206] pci_bu=
s 0000:03: resource 0 [io =C2=A00x8000-0x8fff]</div><div>[ =C2=A0 =C2=A01.3=
94207] pci_bus 0000:03: resource 1 [mem 0xfb900000-0xfb9fffff]</div><div>[ =
=C2=A0 =C2=A01.394208] pci_bus 0000:03: resource 2 [mem 0xc0200000-0xc03fff=
ff 64bit pref]</div><div>[ =C2=A0 =C2=A01.394209] pci_bus 0000:02: resource=
 0 [io =C2=A00x1000-0x1fff]</div><div>[ =C2=A0 =C2=A01.394210] pci_bus 0000=
:02: resource 1 [mem 0xf6000000-0xf7efffff]</div><div>[ =C2=A0 =C2=A01.3942=
11] pci_bus 0000:02: resource 2 [mem 0xc0400000-0xc05fffff 64bit pref]</div=
><div>[ =C2=A0 =C2=A01.394212] pci_bus 0000:01: resource 4 [io =C2=A00x0000=
-0x0cf7 window]</div><div>[ =C2=A0 =C2=A01.394213] pci_bus 0000:01: resourc=
e 5 [io =C2=A00x0d00-0xffff window]</div><div>[ =C2=A0 =C2=A01.394214] pci_=
bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff window]</div><div>[ =C2=
=A0 =C2=A01.394215] pci_bus 0000:01: resource 7 [mem 0x000d0000-0x000dffff =
window]</div><div>[ =C2=A0 =C2=A01.394216] pci_bus 0000:01: resource 8 [mem=
 0xc0000000-0xdfffffff window]</div><div>[ =C2=A0 =C2=A01.394217] pci_bus 0=
000:01: resource 9 [mem 0xf0000000-0xfed8ffff window]</div><div>[ =C2=A0 =
=C2=A01.394219] pci_bus 0000:ff: resource 4 [io =C2=A00x0000-0xffff]</div><=
div>[ =C2=A0 =C2=A01.394220] pci_bus 0000:ff: resource 5 [mem 0x00000000-0x=
ffffffffff]</div><div>[ =C2=A0 =C2=A01.394235] NET: Registered protocol fam=
ily 2</div><div>[ =C2=A0 =C2=A01.394354] TCP established hash table entries=
: 131072 (order: 8, 1048576 bytes)</div><div>[ =C2=A0 =C2=A01.394502] TCP b=
ind hash table entries: 65536 (order: 8, 1048576 bytes)</div><div>[ =C2=A0 =
=C2=A01.394607] TCP: Hash tables configured (established 131072 bind 65536)=
</div><div>[ =C2=A0 =C2=A01.394629] UDP hash table entries: 8192 (order: 6,=
 262144 bytes)</div><div>[ =C2=A0 =C2=A01.394661] UDP-Lite hash table entri=
es: 8192 (order: 6, 262144 bytes)</div><div>[ =C2=A0 =C2=A01.394719] NET: R=
egistered protocol family 1</div><div>[ =C2=A0 =C2=A01.395763] pci 0000:0c:=
00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]</div><d=
iv>[ =C2=A0 =C2=A01.395789] PCI: CLS 256 bytes, default 64</div><div>[ =C2=
=A0 =C2=A01.395814] Unpacking initramfs...</div><div>[ =C2=A0 =C2=A01.43226=
7] Freeing initrd memory: 4260K (ffff88003779e000 - ffff880037bc7000)</div>=
<div>[ =C2=A0 =C2=A01.432279] DMAR: Host address width 39</div><div>[ =C2=
=A0 =C2=A01.432281] DMAR: DRHD base: 0x000000fbfff000 flags: 0x0</div><div>=
[ =C2=A0 =C2=A01.432292] DMAR: dmar0: reg_base_addr fbfff000 ver 1:0 cap c9=
008010e60262 ecap f020f2</div><div>[ =C2=A0 =C2=A01.432293] DMAR: DRHD base=
: 0x000000fbffe000 flags: 0x1</div><div>[ =C2=A0 =C2=A01.432297] DMAR: dmar=
1: reg_base_addr fbffe000 ver 1:0 cap c9078010ef0462 ecap f020f6</div><div>=
[ =C2=A0 =C2=A01.432298] DMAR: RMRR base: 0x000000000ec000 end: 0x000000000=
f3fff</div><div>[ =C2=A0 =C2=A01.432299] DMAR: RMRR base: 0x000000bf7e8000 =
end: 0x000000bf7fffff</div><div>[ =C2=A0 =C2=A01.432299] DMAR: ATSR flags: =
0x0</div><div>[ =C2=A0 =C2=A01.433425] DMAR: dmar0: Using Queued invalidati=
on</div><div>[ =C2=A0 =C2=A01.433435] DMAR: dmar1: Using Queued invalidatio=
n</div><div>[ =C2=A0 =C2=A01.433449] DMAR: Recommended TLB entries for ISOC=
H unit is 16; your BIOS set 20</div><div>[ =C2=A0 =C2=A01.433450] DMAR: Set=
ting RMRR:</div><div>[ =C2=A0 =C2=A01.433500] DMAR: Setting identity map fo=
r device 0000:00:1a.0 [0xbf7e8000 - 0xbf7fffff]</div><div>[ =C2=A0 =C2=A01.=
433555] DMAR: Setting identity map for device 0000:00:1a.1 [0xbf7e8000 - 0x=
bf7fffff]</div><div>[ =C2=A0 =C2=A01.433606] DMAR: Setting identity map for=
 device 0000:00:1a.2 [0xbf7e8000 - 0xbf7fffff]</div><div>[ =C2=A0 =C2=A01.4=
33658] DMAR: Setting identity map for device 0000:00:1a.7 [0xbf7e8000 - 0xb=
f7fffff]</div><div>[ =C2=A0 =C2=A01.433711] DMAR: Setting identity map for =
device 0000:00:1d.0 [0xbf7e8000 - 0xbf7fffff]</div><div>[ =C2=A0 =C2=A01.43=
3765] DMAR: Setting identity map for device 0000:00:1d.1 [0xbf7e8000 - 0xbf=
7fffff]</div><div>[ =C2=A0 =C2=A01.433819] DMAR: Setting identity map for d=
evice 0000:00:1d.2 [0xbf7e8000 - 0xbf7fffff]</div><div>[ =C2=A0 =C2=A01.433=
874] DMAR: Setting identity map for device 0000:00:1d.7 [0xbf7e8000 - 0xbf7=
fffff]</div><div>[ =C2=A0 =C2=A01.433886] DMAR: Setting identity map for de=
vice 0000:00:1a.0 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01.433894] DM=
AR: Setting identity map for device 0000:00:1a.1 [0xec000 - 0xf3fff]</div><=
div>[ =C2=A0 =C2=A01.433902] DMAR: Setting identity map for device 0000:00:=
1a.2 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01.433909] DMAR: Setting i=
dentity map for device 0000:00:1a.7 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =
=C2=A01.433917] DMAR: Setting identity map for device 0000:00:1d.0 [0xec000=
 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01.433925] DMAR: Setting identity map f=
or device 0000:00:1d.1 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01.43393=
3] DMAR: Setting identity map for device 0000:00:1d.2 [0xec000 - 0xf3fff]</=
div><div>[ =C2=A0 =C2=A01.433940] DMAR: Setting identity map for device 000=
0:00:1d.7 [0xec000 - 0xf3fff]</div><div>[ =C2=A0 =C2=A01.433949] DMAR: Prep=
are 0-16MiB unity mapping for LPC</div><div>[ =C2=A0 =C2=A01.433995] DMAR: =
Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]</div><div>[ =
=C2=A0 =C2=A01.434096] DMAR: Intel(R) Virtualization Technology for Directe=
d I/O</div><div>[ =C2=A0 =C2=A01.434139] iommu: Adding device 0000:00:00.0 =
to group 0</div><div>[ =C2=A0 =C2=A01.434148] iommu: Adding device 0000:00:=
01.0 to group 1</div><div>[ =C2=A0 =C2=A01.434156] iommu: Adding device 000=
0:00:02.0 to group 2</div><div>[ =C2=A0 =C2=A01.434164] iommu: Adding devic=
e 0000:00:03.0 to group 3</div><div>[ =C2=A0 =C2=A01.434173] iommu: Adding =
device 0000:00:05.0 to group 4</div><div>[ =C2=A0 =C2=A01.434182] iommu: Ad=
ding device 0000:00:06.0 to group 5</div><div>[ =C2=A0 =C2=A01.434190] iomm=
u: Adding device 0000:00:07.0 to group 6</div><div>[ =C2=A0 =C2=A01.434198]=
 iommu: Adding device 0000:00:09.0 to group 7</div><div>[ =C2=A0 =C2=A01.43=
4205] iommu: Adding device 0000:00:0a.0 to group 8</div><div>[ =C2=A0 =C2=
=A01.434232] iommu: Adding device 0000:00:14.0 to group 9</div><div>[ =C2=
=A0 =C2=A01.434241] iommu: Adding device 0000:00:14.1 to group 9</div><div>=
[ =C2=A0 =C2=A01.434249] iommu: Adding device 0000:00:14.2 to group 9</div>=
<div>[ =C2=A0 =C2=A01.434257] iommu: Adding device 0000:00:14.3 to group 9<=
/div><div>[ =C2=A0 =C2=A01.434282] iommu: Adding device 0000:00:1a.0 to gro=
up 10</div><div>[ =C2=A0 =C2=A01.434290] iommu: Adding device 0000:00:1a.1 =
to group 10</div><div>[ =C2=A0 =C2=A01.434298] iommu: Adding device 0000:00=
:1a.2 to group 10</div><div>[ =C2=A0 =C2=A01.434306] iommu: Adding device 0=
000:00:1a.7 to group 10</div><div>[ =C2=A0 =C2=A01.434314] iommu: Adding de=
vice 0000:00:1b.0 to group 11</div><div>[ =C2=A0 =C2=A01.434349] iommu: Add=
ing device 0000:00:1c.0 to group 12</div><div>[ =C2=A0 =C2=A01.434360] iomm=
u: Adding device 0000:00:1c.1 to group 12</div><div>[ =C2=A0 =C2=A01.434370=
] iommu: Adding device 0000:00:1c.2 to group 12</div><div>[ =C2=A0 =C2=A01.=
434381] iommu: Adding device 0000:00:1c.3 to group 12</div><div>[ =C2=A0 =
=C2=A01.434392] iommu: Adding device 0000:00:1c.4 to group 12</div><div>[ =
=C2=A0 =C2=A01.434416] iommu: Adding device 0000:00:1d.0 to group 13</div><=
div>[ =C2=A0 =C2=A01.434425] iommu: Adding device 0000:00:1d.1 to group 13<=
/div><div>[ =C2=A0 =C2=A01.434433] iommu: Adding device 0000:00:1d.2 to gro=
up 13</div><div>[ =C2=A0 =C2=A01.434441] iommu: Adding device 0000:00:1d.7 =
to group 13</div><div>[ =C2=A0 =C2=A01.434450] iommu: Adding device 0000:00=
:1e.0 to group 14</div><div>[ =C2=A0 =C2=A01.434470] iommu: Adding device 0=
000:00:1f.0 to group 15</div><div>[ =C2=A0 =C2=A01.434479] iommu: Adding de=
vice 0000:00:1f.2 to group 15</div><div>[ =C2=A0 =C2=A01.434488] iommu: Add=
ing device 0000:00:1f.3 to group 15</div><div>[ =C2=A0 =C2=A01.434497] iomm=
u: Adding device 0000:0e:00.0 to group 16</div><div>[ =C2=A0 =C2=A01.434507=
] iommu: Adding device 0000:0d:00.0 to group 17</div><div>[ =C2=A0 =C2=A01.=
434517] iommu: Adding device 0000:0c:00.0 to group 18</div><div>[ =C2=A0 =
=C2=A01.434521] iommu: Adding device 0000:06:00.0 to group 12</div><div>[ =
=C2=A0 =C2=A01.434525] iommu: Adding device 0000:05:00.0 to group 12</div><=
div>[ =C2=A0 =C2=A01.434529] iommu: Adding device 0000:04:00.0 to group 12<=
/div><div>[ =C2=A0 =C2=A01.434533] iommu: Adding device 0000:03:00.0 to gro=
up 12</div><div>[ =C2=A0 =C2=A01.434537] iommu: Adding device 0000:02:00.0 =
to group 12</div><div>[ =C2=A0 =C2=A01.434553] iommu: Adding device 0000:ff=
:00.0 to group 19</div><div>[ =C2=A0 =C2=A01.434562] iommu: Adding device 0=
000:ff:00.1 to group 19</div><div>[ =C2=A0 =C2=A01.434625] iommu: Adding de=
vice 0000:ff:02.0 to group 20</div><div>[ =C2=A0 =C2=A01.434636] iommu: Add=
ing device 0000:ff:02.1 to group 20</div><div>[ =C2=A0 =C2=A01.434646] iomm=
u: Adding device 0000:ff:02.2 to group 20</div><div>[ =C2=A0 =C2=A01.434655=
] iommu: Adding device 0000:ff:02.3 to group 20</div><div>[ =C2=A0 =C2=A01.=
434665] iommu: Adding device 0000:ff:02.4 to group 20</div><div>[ =C2=A0 =
=C2=A01.434675] iommu: Adding device 0000:ff:02.5 to group 20</div><div>[ =
=C2=A0 =C2=A01.434699] iommu: Adding device 0000:ff:03.0 to group 21</div><=
div>[ =C2=A0 =C2=A01.434710] iommu: Adding device 0000:ff:03.1 to group 21<=
/div><div>[ =C2=A0 =C2=A01.434719] iommu: Adding device 0000:ff:03.2 to gro=
up 21</div><div>[ =C2=A0 =C2=A01.434729] iommu: Adding device 0000:ff:03.4 =
to group 21</div><div>[ =C2=A0 =C2=A01.434753] iommu: Adding device 0000:ff=
:04.0 to group 22</div><div>[ =C2=A0 =C2=A01.434763] iommu: Adding device 0=
000:ff:04.1 to group 22</div><div>[ =C2=A0 =C2=A01.434773] iommu: Adding de=
vice 0000:ff:04.2 to group 22</div><div>[ =C2=A0 =C2=A01.434784] iommu: Add=
ing device 0000:ff:04.3 to group 22</div><div>[ =C2=A0 =C2=A01.434808] iomm=
u: Adding device 0000:ff:05.0 to group 23</div><div>[ =C2=A0 =C2=A01.434819=
] iommu: Adding device 0000:ff:05.1 to group 23</div><div>[ =C2=A0 =C2=A01.=
434829] iommu: Adding device 0000:ff:05.2 to group 23</div><div>[ =C2=A0 =
=C2=A01.434839] iommu: Adding device 0000:ff:05.3 to group 23</div><div>[ =
=C2=A0 =C2=A01.434863] iommu: Adding device 0000:ff:06.0 to group 24</div><=
div>[ =C2=A0 =C2=A01.434874] iommu: Adding device 0000:ff:06.1 to group 24<=
/div><div>[ =C2=A0 =C2=A01.434885] iommu: Adding device 0000:ff:06.2 to gro=
up 24</div><div>[ =C2=A0 =C2=A01.434895] iommu: Adding device 0000:ff:06.3 =
to group 24</div><div>[ =C2=A0 =C2=A01.435770] Scanning for low memory corr=
uption every 60 seconds</div><div>[ =C2=A0 =C2=A01.435989] futex hash table=
 entries: 4096 (order: 6, 262144 bytes)</div><div>[ =C2=A0 =C2=A01.436302] =
workingset: timestamp_bits=3D38 max_order=3D22 bucket_order=3D0</div><div>[=
 =C2=A0 =C2=A01.437194] zbud: loaded</div><div>[ =C2=A0 =C2=A01.437330] Key=
 type big_key registered</div><div>[ =C2=A0 =C2=A01.437492] Block layer SCS=
I generic (bsg) driver version 0.4 loaded (major 249)</div><div>[ =C2=A0 =
=C2=A01.437521] io scheduler noop registered</div><div>[ =C2=A0 =C2=A01.437=
522] io scheduler deadline registered</div><div>[ =C2=A0 =C2=A01.437539] io=
 scheduler cfq registered (default)</div><div>[ =C2=A0 =C2=A01.438235] pcie=
port 0000:00:1c.4: enabling device (0106 -&gt; 0107)</div><div>[ =C2=A0 =C2=
=A01.438346] pci_hotplug: PCI Hot Plug PCI Core version: 0.5</div><div>[ =
=C2=A0 =C2=A01.438349] pciehp: PCI Express Hot Plug Controller Driver versi=
on: 0.4</div><div>[ =C2=A0 =C2=A01.438357] vesafb: mode is 1280x1024x32, li=
nelength=3D5120, pages=3D0</div><div>[ =C2=A0 =C2=A01.438358] vesafb: scrol=
ling: redraw</div><div>[ =C2=A0 =C2=A01.438359] vesafb: Truecolor: size=3D8=
:8:8:8, shift=3D24:16:8:0</div><div>[ =C2=A0 =C2=A01.438371] vesafb: frameb=
uffer at 0xf9000000, mapped to 0xffffc90002000000, using 5120k, total 5120k=
</div><div>[ =C2=A0 =C2=A01.575681] Console: switching to colour frame buff=
er device 160x64</div><div>[ =C2=A0 =C2=A01.712788] fb0: VESA VGA frame buf=
fer device</div><div>[ =C2=A0 =C2=A01.712798] intel_idle: MWAIT substates: =
0x1120</div><div>[ =C2=A0 =C2=A01.712799] intel_idle: v0.4.1 model 0x2C</di=
v><div>[ =C2=A0 =C2=A01.713017] intel_idle: lapic_timer_reliable_states 0xf=
fffffff</div><div>[ =C2=A0 =C2=A01.713161] GHES: HEST is not enabled!</div>=
<div>[ =C2=A0 =C2=A01.713196] Serial: 8250/16550 driver, 4 ports, IRQ shari=
ng disabled</div><div>[ =C2=A0 =C2=A01.713431] Linux agpgart interface v0.1=
03</div><div>[ =C2=A0 =C2=A01.713932] rtc_cmos 00:01: RTC can wake from S4<=
/div><div>[ =C2=A0 =C2=A01.714018] rtc_cmos 00:01: rtc core: registered rtc=
_cmos as rtc0</div><div>[ =C2=A0 =C2=A01.714037] rtc_cmos 00:01: alarms up =
to one month, y3k, 114 bytes nvram, hpet irqs</div><div>[ =C2=A0 =C2=A01.71=
4045] ledtrig-cpu: registered to indicate activity on CPUs</div><div>[ =C2=
=A0 =C2=A01.714256] NET: Registered protocol family 10</div><div>[ =C2=A0 =
=C2=A01.714388] NET: Registered protocol family 17</div><div>[ =C2=A0 =C2=
=A01.714643] microcode: CPU0 sig=3D0x206c2, pf=3D0x1, revision=3D0x13</div>=
<div>[ =C2=A0 =C2=A01.714690] microcode: CPU1 sig=3D0x206c2, pf=3D0x1, revi=
sion=3D0x13</div><div>[ =C2=A0 =C2=A01.714695] microcode: CPU2 sig=3D0x206c=
2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.714719] microcode: =
CPU3 sig=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.71=
4755] microcode: CPU4 sig=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =
=C2=A0 =C2=A01.714799] microcode: CPU5 sig=3D0x206c2, pf=3D0x1, revision=3D=
0x13</div><div>[ =C2=A0 =C2=A01.714841] microcode: CPU6 sig=3D0x206c2, pf=
=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.714883] microcode: CPU7 =
sig=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.714886]=
 microcode: CPU8 sig=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=
=A0 =C2=A01.714890] microcode: CPU9 sig=3D0x206c2, pf=3D0x1, revision=3D0x1=
3</div><div>[ =C2=A0 =C2=A01.714924] microcode: CPU10 sig=3D0x206c2, pf=3D0=
x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.714967] microcode: CPU11 sig=
=3D0x206c2, pf=3D0x1, revision=3D0x13</div><div>[ =C2=A0 =C2=A01.714991] mi=
crocode: Microcode Update Driver: v2.01 &lt;<a href=3D"mailto:tigran@aivazi=
an.fsnet.co.uk">tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org</a>&gt;, Peter Oruba</div><div>=
[ =C2=A0 =C2=A01.715149] registered taskstats version 1</div><div>[ =C2=A0 =
=C2=A01.715161] zswap: loaded using pool lzo/zbud</div><div>[ =C2=A0 =C2=A0=
1.716530] =C2=A0 Magic number: 4:236:993</div><div>[ =C2=A0 =C2=A01.716533]=
 machinecheck machinecheck6: hash matches</div><div>[ =C2=A0 =C2=A01.716569=
] memory memory36: hash matches</div><div>[ =C2=A0 =C2=A01.716842] rtc_cmos=
 00:01: setting system clock to 2016-06-16 15:59:07 UTC (1466092747)</div><=
div>[ =C2=A0 =C2=A01.716863] PM: Hibernation image not present or could not=
 be loaded.</div><div>[ =C2=A0 =C2=A01.718128] Freeing unused kernel memory=
: 1244K (ffffffff818f6000 - ffffffff81a2d000)</div><div>[ =C2=A0 =C2=A01.71=
8129] Write protecting the kernel read-only data: 8192k</div><div>[ =C2=A0 =
=C2=A01.718748] Freeing unused kernel memory: 124K (ffff8800015e1000 - ffff=
880001600000)</div><div>[ =C2=A0 =C2=A01.719254] Freeing unused kernel memo=
ry: 212K (ffff8800017cb000 - ffff880001800000)</div><div>[ =C2=A0 =C2=A01.7=
23477] random: systemd-tmpfile urandom read with 1 bits of entropy availabl=
e</div><div>[ =C2=A0 =C2=A01.742833] i8042: PNP: No PS/2 controller found. =
Probing ports directly.</div><div>[ =C2=A0 =C2=A01.743166] serio: i8042 KBD=
 port at 0x60,0x64 irq 1</div><div>[ =C2=A0 =C2=A01.743169] serio: i8042 AU=
X port at 0x60,0x64 irq 12</div><div>[ =C2=A0 =C2=A01.746399] ACPI: bus typ=
e USB registered</div></div></div></div><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote">On Thu, Jun 16, 2016 at 2:29 PM, Joerg Roedel <span =
dir=3D"ltr">&lt;<a href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" target=3D"_blank">joro@8=
bytes.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On Thu, Jun 16, 2016 at 10:26:20AM +0400, Dheeraj CVR wrote:<br>
&gt; I have added some debugging code to see where exactly the hang happens=
. The=C2=A0<br>
&gt; set_root_entry call works fine without any issues as you have expected=
.<br>
&gt; However, the hang happens when calling flush_context.<br>
&gt;<br>
&gt; flush_context -&gt; qi_flush_context -&gt; qi_submit_sync<br>
&gt;<br>
&gt; The loop &quot;while (qi-&gt;desc_status[wait_index] !=3D QI_DONE) {}&=
quot; in<br>
&gt; &quot;qi_submit_sync&quot; executes indefinitely and the control doesn=
&#39;t break. Hence, &quot;<br>
&gt; iommu-&gt;flush.flush_context()&quot; never returns.<br>
&gt;<br>
&gt; Tested on 2 X58 Motherboards and both hang at the same place with inte=
l_iommu=3D<br>
&gt; on.<br>
&gt;<br>
&gt; Hope this helps.<br>
<br>
</span>Hmm, okay. Yesterday I tried to reproduce the problem on a box in ou=
r<br>
test-lab which has the same chipset. The bug didn&#39;t show up there, and<=
br>
one difference to your machine is that is only has one iommu instead of<br>
two.<br>
<br>
This brought me to another difference the patch made: Before the patch<br>
QI was enabled on all iommus before the root entry was set and the<br>
caches flushed. With the patch QI is enabled in the same loop that sets<br>
the root entry and tries to flush. Maybe that is the problem on this<br>
chipset.<br>
<br>
Can you please try the attached diff? It is just a guess, but maybe that<br=
>
is the problem.<br>
<br>
Thanks,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Joerg<br>
<br>
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br>
index a644d0c..0ddbb6a 100644<br>
--- a/drivers/iommu/intel-iommu.c<br>
+++ b/drivers/iommu/intel-iommu.c<br>
@@ -3222,11 +3222,6 @@ static int __init init_dmars(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_flush_write_b=
uffer(iommu);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_set_root_entr=
y(iommu);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;flush.flu=
sh_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;flush.flu=
sh_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ecap_pass_thro=
ugh(iommu-&gt;ecap))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 hw_pass_through =3D 0;<br>
=C2=A0#ifdef CONFIG_INTEL_IOMMU_SVM<br>
@@ -3235,6 +3230,17 @@ static int __init init_dmars(void)<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Now that qi is enabled on all iommus, set th=
e root entry and flush<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * caches.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_active_iommu(iommu, drhd) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_flush_write_b=
uffer(iommu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_set_root_entr=
y(iommu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;flush.flu=
sh_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;flush.flu=
sh_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iommu_pass_through)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iommu_identity_mapp=
ing |=3D IDENTMAP_ALL;<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Re=
gards,<br>Dheeraj CVR.<br></div></div>
</div>

--001a11352f02b887d60535677dff--

--===============1433967562164089587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1433967562164089587==--
