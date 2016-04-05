From: Tomasz Golinski <tomaszg-FRiIMV821htubak7+UBa2Q@public.gmane.org>
Subject: Re: AMD-Vi regression with PCIe/PCI bridges in 4.4
Date: Tue, 5 Apr 2016 14:39:15 +0200
Message-ID: <5703B1F3.6000505@math.uwb.edu.pl>
References: <5700BF69.2080102@ladisch.de> <57038D1F.7040205@ladisch.de>
	<20160405101530.GA4203@suse.de> <5703AEE6.4010304@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030708000100070204010801"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5703AEE6.4010304-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, martin <haiden.tracking-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bellamorte42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------030708000100070204010801
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 05.04.2016 14:26, Clemens Ladisch wrote:
> Martin/Tomasz, could we get the amd_iommu_dump dmesg output for an
> earlier kernel?
> 

It's for 4.1.15. Both kernels were built with Gentoo patches but I don't
think they added anything in related areas. I can build vanilla kernels
if it would be better.

Best,
Tomasz

--------------030708000100070204010801
Content-Type: text/x-log;
 name="dmesg-old.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-old.log"

[    0.000000] Linux version 4.1.15-gentoo-r1 (root@wafel) (gcc version 4.9.3 (Gentoo 4.9.3 p1.2, pie-0.6.3) ) #1 SMP PREEMPT Thu Feb 4 20:49:42 CET 2016
[    0.000000] Command line: BOOT_IMAGE=Gentoo4.1.15 ro root=801 amd_iommu_dump
[    0.000000] tseg: 00bf800000
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bd710fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bd711000-0x00000000bd9f1fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bd9f2000-0x00000000bdd4dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bdd4e000-0x00000000be9e0fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000be9e1000-0x00000000be9e1fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000be9e2000-0x00000000bebe7fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bebe8000-0x00000000bf04ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf050000-0x00000000bf7e0fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bf7e1000-0x00000000bf7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100001000-0x000000043effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A85XM-D3H, BIOS F3 04/08/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x43f000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-CEFFF write-protect
[    0.000000]   CF000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000BF800000 mask FFFFFF800000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000043f000000 aka 17392M
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xbf800 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x0170d000, 0x0170dfff] PGTABLE
[    0.000000] BRK [0x0170e000, 0x0170efff] PGTABLE
[    0.000000] BRK [0x0170f000, 0x0170ffff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x43ee00000-0x43effffff]
[    0.000000]  [mem 0x43ee00000-0x43effffff] page 2M
[    0.000000] BRK [0x01710000, 0x01710fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x420000000-0x43edfffff]
[    0.000000]  [mem 0x420000000-0x43edfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x400000000-0x41fffffff]
[    0.000000]  [mem 0x400000000-0x41fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xbd710fff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0x7fffffff] page 1G
[    0.000000]  [mem 0x80000000-0xbd5fffff] page 2M
[    0.000000]  [mem 0xbd600000-0xbd710fff] page 4k
[    0.000000] init_memory_mapping: [mem 0xbe9e1000-0xbe9e1fff]
[    0.000000]  [mem 0xbe9e1000-0xbe9e1fff] page 4k
[    0.000000] BRK [0x01711000, 0x01711fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xbebe8000-0xbf04ffff]
[    0.000000]  [mem 0xbebe8000-0xbebfffff] page 4k
[    0.000000]  [mem 0xbec00000-0xbeffffff] page 2M
[    0.000000]  [mem 0xbf000000-0xbf04ffff] page 4k
[    0.000000] BRK [0x01712000, 0x01712fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xbf7e1000-0xbf7fffff]
[    0.000000]  [mem 0xbf7e1000-0xbf7fffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100001000-0x3ffffffff]
[    0.000000]  [mem 0x100001000-0x1001fffff] page 4k
[    0.000000]  [mem 0x100200000-0x13fffffff] page 2M
[    0.000000]  [mem 0x140000000-0x3ffffffff] page 1G
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000BDD35080 00007C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000BDD3B110 0000F4 (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20150410/tbfadt-654)
[    0.000000] ACPI: DSDT 0x00000000BDD35190 005F80 (v02 ALASKA A M I    00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000BDD44E80 000040
[    0.000000] ACPI: APIC 0x00000000BDD3B208 000072 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000BDD3B280 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000BDD3B2C8 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000BDD3B308 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: IFEU 0x00000000BDD3B340 000042 (v01 ALASKA A M I    01072009      00000000)
[    0.000000] ACPI: IVRS 0x00000000BDD3B388 000070 (v02 AMD    ANNAPURN 00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x00000000BDD3B3F8 000D40 (v01 AMD    ANNAPURN 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000BDD3C138 0004B7 (v02 AMD    ANNAPURN 00000001 MSFT 04000000)
[    0.000000] ACPI: CRAT 0x00000000BDD3C5F0 0002F8 (v01 AMD    ANNAPURN 00000001 AMD  00000001)
[    0.000000] ACPI: BGRT 0x00000000BDD3C8E8 000038 (v00 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0010ffffff] PMD -> [ffff88042e600000-ffff88043e5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000043effffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bd710fff]
[    0.000000]   node   0: [mem 0x00000000be9e1000-0x00000000be9e1fff]
[    0.000000]   node   0: [mem 0x00000000bebe8000-0x00000000bf04ffff]
[    0.000000]   node   0: [mem 0x00000000bf7e1000-0x00000000bf7fffff]
[    0.000000]   node   0: [mem 0x0000000100001000-0x000000043effffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000043effffff]
[    0.000000] On node 0 totalpages: 4180789
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 12079 pages used for memmap
[    0.000000]   DMA32 zone: 773017 pages, LIFO batch:31
[    0.000000]   Normal zone: 53184 pages used for memmap
[    0.000000]   Normal zone: 3403775 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 5, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0xbf800000-0xfebfffff] available for PCI devices
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 31 pages/cpu @ffff88043ec00000 s88472 r8192 d30312 u524288
[    0.000000] pcpu-alloc: s88472 r8192 d30312 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4115441
[    0.000000] Kernel command line: BOOT_IMAGE=Gentoo4.1.15 ro root=801 amd_iommu_dump
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] Memory: 16362380K/16723156K available (4196K kernel code, 373K rwdata, 1328K rodata, 792K init, 488K bss, 360776K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU kthread priority: 1.
[    0.000000] NR_IRQS:4352 nr_irqs:456 16
[    0.000000] Console: colour VGA+ 80x50
[    0.000000] console [tty0] enabled
[    0.000000] clocksource hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3399.992 MHz processor
[    0.000017] Calibrating delay loop (skipped), value calculated using timer frequency.. 6799.98 BogoMIPS (lpj=3399992)
[    0.000337] pid_max: default: 32768 minimum: 301
[    0.000498] ACPI: Core revision 20150410
[    0.002944] ACPI: All ACPI Tables successfully acquired
[    0.003198] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.003360] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.003847] CPU: Physical Processor ID: 0
[    0.004010] CPU: Processor Core ID: 0
[    0.004169] mce: CPU supports 7 MCE banks
[    0.004335] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.004495] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.004872] Freeing SMP alternatives memory: 20K (ffffffff8168d000 - ffffffff81692000)
[    0.005725] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.116855] smpboot: CPU0: AMD Athlon(tm) X4 750K Quad Core Processor (fam: 15, model: 10, stepping: 01)
[    0.117257] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.117532] ... version:                0
[    0.117691] ... bit width:              48
[    0.117849] ... generic registers:      6
[    0.118009] ... value mask:             0000ffffffffffff
[    0.118168] ... max period:             00007fffffffffff
[    0.118326] ... fixed-purpose events:   0
[    0.118484] ... event mask:             000000000000003f
[    0.125998] x86: Booting SMP configuration:
[    0.126160] .... node  #0, CPUs:      #1 #2 #3
[    0.169135] x86: Booted up 1 node, 4 CPUs
[    0.169458] smpboot: Total of 4 processors activated (27199.93 BogoMIPS)
[    0.170204] devtmpfs: initialized
[    0.170568] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.171023] NET: Registered protocol family 16
[    0.175896] cpuidle: using governor ladder
[    0.181428] cpuidle: using governor menu
[    0.181647] ACPI: bus type PCI registered
[    0.181821] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.182101] PCI: not using MMCONFIG
[    0.182271] PCI: Using configuration type 1 for base access
[    0.182439] PCI: Using configuration type 1 for extended access
[    0.183642] ACPI: Added _OSI(Module Device)
[    0.183802] ACPI: Added _OSI(Processor Device)
[    0.183961] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.184123] ACPI: Added _OSI(Processor Aggregator Device)
[    0.185575] ACPI: Executed 1 blocks of module-level executable AML code
[    0.187514] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.188045] ACPI: Interpreter enabled
[    0.188209] ACPI: (supports S0 S5)
[    0.188383] ACPI: Using IOAPIC for interrupt routing
[    0.188650] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.188955] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.189466] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.193650] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.193822] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.194269] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.200425] PCI host bridge to bus 0000:00
[    0.200586] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.200747] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.200908] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.201069] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.201231] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.201397] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.201676] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.201954] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
[    0.202239] pci 0000:00:00.0: [1022:1410] type 00 class 0x060000
[    0.202310] pci 0000:00:00.2: [1022:1419] type 00 class 0x080600
[    0.202411] pci 0000:00:02.0: [1022:1412] type 01 class 0x060400
[    0.202444] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.202498] pci 0000:00:04.0: [1022:1414] type 01 class 0x060400
[    0.202529] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.202600] pci 0000:00:10.0: [1022:7812] type 00 class 0x0c0330
[    0.202620] pci 0000:00:10.0: reg 0x10: [mem 0xfe106000-0xfe107fff 64bit]
[    0.202700] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    0.202767] pci 0000:00:10.1: [1022:7812] type 00 class 0x0c0330
[    0.202795] pci 0000:00:10.1: reg 0x10: [mem 0xfe104000-0xfe105fff 64bit]
[    0.202874] pci 0000:00:10.1: PME# supported from D0 D3hot D3cold
[    0.202941] pci 0000:00:11.0: [1022:7801] type 00 class 0x010601
[    0.202954] pci 0000:00:11.0: reg 0x10: [io  0xf040-0xf047]
[    0.202961] pci 0000:00:11.0: reg 0x14: [io  0xf030-0xf033]
[    0.202969] pci 0000:00:11.0: reg 0x18: [io  0xf020-0xf027]
[    0.202976] pci 0000:00:11.0: reg 0x1c: [io  0xf010-0xf013]
[    0.202984] pci 0000:00:11.0: reg 0x20: [io  0xf000-0xf00f]
[    0.202991] pci 0000:00:11.0: reg 0x24: [mem 0xfe10d000-0xfe10d7ff]
[    0.203071] pci 0000:00:12.0: [1022:7807] type 00 class 0x0c0310
[    0.203081] pci 0000:00:12.0: reg 0x10: [mem 0xfe10c000-0xfe10cfff]
[    0.203180] pci 0000:00:12.2: [1022:7808] type 00 class 0x0c0320
[    0.203193] pci 0000:00:12.2: reg 0x10: [mem 0xfe10b000-0xfe10b0ff]
[    0.203252] pci 0000:00:12.2: supports D1 D2
[    0.203254] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.203312] pci 0000:00:13.0: [1022:7807] type 00 class 0x0c0310
[    0.203324] pci 0000:00:13.0: reg 0x10: [mem 0xfe10a000-0xfe10afff]
[    0.203425] pci 0000:00:13.2: [1022:7808] type 00 class 0x0c0320
[    0.203438] pci 0000:00:13.2: reg 0x10: [mem 0xfe109000-0xfe1090ff]
[    0.203497] pci 0000:00:13.2: supports D1 D2
[    0.203498] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.203557] pci 0000:00:14.0: [1022:780b] type 00 class 0x0c0500
[    0.203656] pci 0000:00:14.2: [1022:780d] type 00 class 0x040300
[    0.203672] pci 0000:00:14.2: reg 0x10: [mem 0xfe100000-0xfe103fff 64bit]
[    0.203722] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.203773] pci 0000:00:14.3: [1022:780e] type 00 class 0x060100
[    0.203878] pci 0000:00:14.4: [1022:780f] type 01 class 0x060401
[    0.203953] pci 0000:00:14.5: [1022:7809] type 00 class 0x0c0310
[    0.203963] pci 0000:00:14.5: reg 0x10: [mem 0xfe108000-0xfe108fff]
[    0.204062] pci 0000:00:15.0: [1022:43a0] type 01 class 0x060400
[    0.204115] pci 0000:00:15.0: supports D1 D2
[    0.204168] pci 0000:00:18.0: [1022:1400] type 00 class 0x060000
[    0.204223] pci 0000:00:18.1: [1022:1401] type 00 class 0x060000
[    0.204276] pci 0000:00:18.2: [1022:1402] type 00 class 0x060000
[    0.204348] pci 0000:00:18.3: [1022:1403] type 00 class 0x060000
[    0.204412] pci 0000:00:18.4: [1022:1404] type 00 class 0x060000
[    0.204466] pci 0000:00:18.5: [1022:1405] type 00 class 0x060000
[    0.204559] pci 0000:01:00.0: [10de:1401] type 00 class 0x030000
[    0.204571] pci 0000:01:00.0: reg 0x10: [mem 0xfd000000-0xfdffffff]
[    0.204582] pci 0000:01:00.0: reg 0x14: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.204593] pci 0000:01:00.0: reg 0x1c: [mem 0xd0000000-0xd1ffffff 64bit pref]
[    0.204600] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.204608] pci 0000:01:00.0: reg 0x30: [mem 0xfe000000-0xfe07ffff pref]
[    0.204688] pci 0000:01:00.1: [10de:0fba] type 00 class 0x040300
[    0.204699] pci 0000:01:00.1: reg 0x10: [mem 0xfe080000-0xfe083fff]
[    0.206190] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.206364] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.206367] pci 0000:00:02.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.206371] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.206439] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
[    0.206455] pci 0000:02:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.206475] pci 0000:02:00.0: reg 0x18: [mem 0xd2104000-0xd2104fff 64bit pref]
[    0.206487] pci 0000:02:00.0: reg 0x20: [mem 0xd2100000-0xd2103fff 64bit pref]
[    0.206549] pci 0000:02:00.0: supports D1 D2
[    0.206550] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.208180] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.208358] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.208363] pci 0000:00:04.0:   bridge window [mem 0xd2100000-0xd21fffff 64bit pref]
[    0.208454] pci 0000:00:14.4: PCI bridge to [bus 03] (subtractive decode)
[    0.208621] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.208623] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.208624] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.208626] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.208627] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.208629] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.208630] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xffffffff window] (subtractive decode)
[    0.208688] pci 0000:04:00.0: [10b5:8112] type 01 class 0x060400
[    0.208860] pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.209145] pci 0000:00:15.0: PCI bridge to [bus 04-05]
[    0.209307] pci 0000:00:15.0:   bridge window [io  0xc000-0xcfff]
[    0.209414] pci 0000:05:04.0: [13f6:8788] type 00 class 0x040100
[    0.209444] pci 0000:05:04.0: reg 0x10: [io  0xc000-0xc0ff]
[    0.209583] pci 0000:05:04.0: supports D1 D2
[    0.209669] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.209833] pci 0000:04:00.0:   bridge window [io  0xc000-0xcfff]
[    0.209877] pci_bus 0000:00: on NUMA node 0
[    0.210298] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.210893] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.211489] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.212080] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.212668] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.213241] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.213818] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.214400] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.215075] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.215237] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.215521] vgaarb: loaded
[    0.215679] vgaarb: bridge control possible 0000:01:00.0
[    0.215880] SCSI subsystem initialized
[    0.216052] libata version 3.00 loaded.
[    0.216054] ACPI: bus type USB registered
[    0.216233] usbcore: registered new interface driver usbfs
[    0.216404] usbcore: registered new interface driver hub
[    0.216589] usbcore: registered new device driver usb
[    0.216793] Advanced Linux Sound Architecture Driver Initialized.
[    0.216954] PCI: Using ACPI for IRQ routing
[    0.223902] PCI: pci_cache_line_size set to 64 bytes
[    0.223955] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.223957] e820: reserve RAM buffer [mem 0xbd711000-0xbfffffff]
[    0.223958] e820: reserve RAM buffer [mem 0xbe9e2000-0xbfffffff]
[    0.223959] e820: reserve RAM buffer [mem 0xbf050000-0xbfffffff]
[    0.223960] e820: reserve RAM buffer [mem 0xbf800000-0xbfffffff]
[    0.223961] e820: reserve RAM buffer [mem 0x43f000000-0x43fffffff]
[    0.224066] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.224386] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.227588] Switched to clocksource hpet
[    0.229590] pnp: PnP ACPI init
[    0.229808] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.229970] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.230020] system 00:01: [mem 0x030b7e40-0xbfffffff] could not be reserved
[    0.230182] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.230236] system 00:02: [mem 0xfeb80000-0xfebfffff] has been reserved
[    0.230397] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.230592] system 00:03: [io  0x04d0-0x04d1] has been reserved
[    0.230753] system 00:03: [io  0x040b] has been reserved
[    0.230913] system 00:03: [io  0x04d6] has been reserved
[    0.231073] system 00:03: [io  0x0c00-0x0c01] has been reserved
[    0.231233] system 00:03: [io  0x0c14] has been reserved
[    0.231393] system 00:03: [io  0x0c50-0x0c51] has been reserved
[    0.231553] system 00:03: [io  0x0c52] has been reserved
[    0.231716] system 00:03: [io  0x0c6c] has been reserved
[    0.231876] system 00:03: [io  0x0c6f] has been reserved
[    0.232036] system 00:03: [io  0x0cd0-0x0cd1] has been reserved
[    0.232195] system 00:03: [io  0x0cd2-0x0cd3] has been reserved
[    0.232355] system 00:03: [io  0x0cd4-0x0cd5] has been reserved
[    0.232516] system 00:03: [io  0x0cd6-0x0cd7] has been reserved
[    0.232680] system 00:03: [io  0x0cd8-0x0cdf] has been reserved
[    0.232840] system 00:03: [io  0x0800-0x089f] could not be reserved
[    0.233001] system 00:03: [io  0x0b20-0x0b3f] has been reserved
[    0.233160] system 00:03: [io  0x0900-0x090f] has been reserved
[    0.233320] system 00:03: [io  0x0910-0x091f] has been reserved
[    0.233480] system 00:03: [io  0xfe00-0xfefe] has been reserved
[    0.233644] system 00:03: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.233806] system 00:03: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.233966] system 00:03: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.234127] system 00:03: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.234288] system 00:03: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.234449] system 00:03: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.234614] system 00:03: [mem 0xff000000-0xffffffff] has been reserved
[    0.234775] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.234881] system 00:04: [io  0x0220-0x0227] has been reserved
[    0.235042] system 00:04: [io  0x0228-0x0237] has been reserved
[    0.235202] system 00:04: [io  0x0a20-0x0a2f] has been reserved
[    0.235362] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.235391] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.235555] pnp 00:06: [dma 0 disabled]
[    0.235594] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.235701] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.235723] pnp 00:08: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.235760] system 00:09: [io  0x04d0-0x04d1] has been reserved
[    0.235921] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.236033] pnp: PnP ACPI: found 10 devices
[    0.240726] clocksource acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.241026] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.241187] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.241349] pci 0000:00:02.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.241510] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.241794] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.241954] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.242116] pci 0000:00:04.0:   bridge window [mem 0xd2100000-0xd21fffff 64bit pref]
[    0.242395] pci 0000:00:14.4: PCI bridge to [bus 03]
[    0.242562] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.242727] pci 0000:04:00.0:   bridge window [io  0xc000-0xcfff]
[    0.242905] pci 0000:00:15.0: PCI bridge to [bus 04-05]
[    0.243066] pci 0000:00:15.0:   bridge window [io  0xc000-0xcfff]
[    0.243232] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.243234] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.243235] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.243236] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.243238] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.243239] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.243241] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xffffffff window]
[    0.243242] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.243244] pci_bus 0000:01: resource 1 [mem 0xfd000000-0xfe0fffff]
[    0.243245] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.243246] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.243248] pci_bus 0000:02: resource 2 [mem 0xd2100000-0xd21fffff 64bit pref]
[    0.243249] pci_bus 0000:03: resource 4 [io  0x0000-0x03af window]
[    0.243251] pci_bus 0000:03: resource 5 [io  0x03e0-0x0cf7 window]
[    0.243252] pci_bus 0000:03: resource 6 [io  0x03b0-0x03df window]
[    0.243253] pci_bus 0000:03: resource 7 [io  0x0d00-0xffff window]
[    0.243254] pci_bus 0000:03: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.243256] pci_bus 0000:03: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.243257] pci_bus 0000:03: resource 10 [mem 0xc0000000-0xffffffff window]
[    0.243258] pci_bus 0000:04: resource 0 [io  0xc000-0xcfff]
[    0.243260] pci_bus 0000:05: resource 0 [io  0xc000-0xcfff]
[    0.243276] NET: Registered protocol family 2
[    0.243533] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.244041] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.244401] TCP: Hash tables configured (established 131072 bind 65536)
[    0.244606] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.244819] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.245072] NET: Registered protocol family 1
[    0.245369] RPC: Registered named UNIX socket transport module.
[    0.245530] RPC: Registered udp transport module.
[    0.245705] RPC: Registered tcp transport module.
[    0.245866] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.484644] pci 0000:01:00.0: Video device with shadowed ROM
[    0.484661] PCI: CLS 64 bytes, default 64
[    0.485109] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: fe info 1300
[    0.485272] AMD-Vi:        mmio-addr: 00000000feb80000
[    0.485459] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:01.0 flags: 00
[    0.485620] AMD-Vi:   DEV_RANGE_END		 devid: ff:1f.6
[    0.486324] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 03:00.0 flags: 00 devid_to: 00:14.4
[    0.486611] AMD-Vi:   DEV_RANGE_END		 devid: 03:1f.7
[    0.486774] AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
[    0.486934] AMD-Vi:   DEV_SPECIAL(IOAPIC[5])		devid: 00:14.0
[    0.569054] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    0.569216] AMD-Vi:  Extended features:  PreF PPR GT IA
[    0.578330] AMD-Vi: Lazy IO/TLB flushing enabled
[    0.578903] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.579067] software IO TLB [mem 0xb9711000-0xbd711000] (64MB) mapped at [ffff8800b9711000-ffff8800bd710fff]
[    0.579404] perf: AMD NB counters detected
[    0.579662] LVT offset 0 assigned for vector 0x400
[    0.579834] perf: AMD IBS detected (0x000000ff)
[    0.580181] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.582497] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
[    0.583006] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.583294] io scheduler noop registered
[    0.583518] io scheduler cfq registered
[    0.583700] io scheduler bfq registered (default)
[    0.583859] BFQ I/O-scheduler: v7r8
[    0.584303] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    0.584636] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.584797] pci 0000:01:00.1: Signaling PME through PCIe PME interrupt
[    0.584959] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
[    0.584971] pcieport 0000:00:04.0: Signaling PME through PCIe PME interrupt
[    0.585132] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    0.585294] pcie_pme 0000:00:04.0:pcie01: service driver pcie_pme loaded
[    0.585307] pcieport 0000:00:15.0: Signaling PME through PCIe PME interrupt
[    0.585496] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
[    0.585656] pci 0000:05:04.0: Signaling PME through PCIe PME interrupt
[    0.585818] pcie_pme 0000:00:15.0:pcie01: service driver pcie_pme loaded
[    0.586022] ACPI: acpi_idle registered with cpuidle
[    0.586479] ahci 0000:00:11.0: version 3.0
[    0.586666] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[    0.586953] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part sxs 
[    0.588151] scsi host0: ahci
[    0.588458] scsi host1: ahci
[    0.588708] scsi host2: ahci
[    0.588955] scsi host3: ahci
[    0.589200] scsi host4: ahci
[    0.589467] scsi host5: ahci
[    0.589713] scsi host6: ahci
[    0.589957] scsi host7: ahci
[    0.590153] ata1: SATA max UDMA/133 abar m2048@0xfe10d000 port 0xfe10d100 irq 28
[    0.590450] ata2: SATA max UDMA/133 abar m2048@0xfe10d000 port 0xfe10d180 irq 28
[    0.596583] ata3: SATA max UDMA/133 abar m2048@0xfe10d000 port 0xfe10d200 irq 28
[    0.596862] ata4: SATA max UDMA/133 abar m2048@0xfe10d000 port 0xfe10d280 irq 28
[    0.597140] ata5: SATA max UDMA/133 abar m2048@0xfe10d000 port 0xfe10d300 irq 28
[    0.597464] ata6: SATA max UDMA/133 abar m2048@0xfe10d000 port 0xfe10d380 irq 28
[    0.597743] ata7: SATA max UDMA/133 abar m2048@0xfe10d000 port 0xfe10d400 irq 28
[    0.598021] ata8: SATA max UDMA/133 abar m2048@0xfe10d000 port 0xfe10d480 irq 28
[    0.598364] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    0.599046] r8169 0000:02:00.0 eth0: RTL8168evl/8111evl at 0xffffc9000003e000, 94:de:80:c7:16:b7, XID 0c900800 IRQ 29
[    0.599334] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    0.599653] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.599824] ehci-pci: EHCI PCI platform driver
[    0.600065] QUIRK: Enable AMD PLL fix
[    0.600079] ehci-pci 0000:00:12.2: EHCI Host Controller
[    0.600242] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    0.600582] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    0.600868] ehci-pci 0000:00:12.2: debug port 1
[    0.601054] ehci-pci 0000:00:12.2: irq 17, io mem 0xfe10b000
[    0.606454] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    0.606670] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.606831] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.607108] usb usb1: Product: EHCI Host Controller
[    0.607267] usb usb1: Manufacturer: Linux 4.1.15-gentoo-r1 ehci_hcd
[    0.607432] usb usb1: SerialNumber: 0000:00:12.2
[    0.607768] hub 1-0:1.0: USB hub found
[    0.607932] hub 1-0:1.0: 5 ports detected
[    0.608288] ehci-pci 0000:00:13.2: EHCI Host Controller
[    0.608470] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    0.608757] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    0.609042] ehci-pci 0000:00:13.2: debug port 1
[    0.609223] ehci-pci 0000:00:13.2: irq 17, io mem 0xfe109000
[    0.614464] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    0.614656] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    0.614817] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.615095] usb usb2: Product: EHCI Host Controller
[    0.615254] usb usb2: Manufacturer: Linux 4.1.15-gentoo-r1 ehci_hcd
[    0.615420] usb usb2: SerialNumber: 0000:00:13.2
[    0.615757] hub 2-0:1.0: USB hub found
[    0.615918] hub 2-0:1.0: 5 ports detected
[    0.616201] usbcore: registered new interface driver usb-storage
[    0.616393] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.616561] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.616965] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.617262] mousedev: PS/2 mouse device common for all mice
[    0.617470] rtc_cmos 00:08: RTC can wake from S4
[    0.617786] rtc_cmos 00:08: rtc core: registered rtc_cmos as rtc0
[    0.617965] rtc_cmos 00:08: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.618269] hidraw: raw HID events driver (C) Jiri Kosina
[    0.618462] usbcore: registered new interface driver usbhid
[    0.618622] usbhid: USB HID core driver
[    0.618926] NET: Registered protocol family 17
[    0.619509] registered taskstats version 1
[    0.620067] rtc_cmos 00:08: setting system clock to 2016-04-05 14:32:55 UTC (1459866775)
[    0.620448] acpi-cpufreq: overriding BIOS provided _PSD data
[    0.620898] ALSA device list:
[    0.621056]   No soundcards found.
[    0.645132] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.903309] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.903516] ata4: SATA link down (SStatus 0 SControl 300)
[    0.903719] ata6: SATA link down (SStatus 0 SControl 300)
[    0.903925] ata7: SATA link down (SStatus 0 SControl 300)
[    0.904122] ata3: SATA link down (SStatus 0 SControl 300)
[    0.904334] ata5: SATA link down (SStatus 0 SControl 300)
[    0.904539] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.904743] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.905311] ata2.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    0.905487] ata2.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    0.905847] ata1.00: ATA-9: OCZ-VERTEX4, 1.5, max UDMA/133
[    0.906029] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    0.906480] ata8.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    0.906660] ata8.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    0.907170] ata1.00: configured for UDMA/133
[    0.907562] scsi 0:0:0:0: Direct-Access     ATA      OCZ-VERTEX4      1.5  PQ: 0 ANSI: 5
[    0.907947] ata2.00: configured for UDMA/133
[    0.908319] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    0.908446] ata8.00: configured for UDMA/133
[    0.908488] scsi 1:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 ABB0 PQ: 0 ANSI: 5
[    0.908722] sd 1:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    0.908725] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    0.908856] sd 1:0:0:0: [sdb] Write Protect is off
[    0.908860] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.908917] scsi 7:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 ABB0 PQ: 0 ANSI: 5
[    0.908922] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.909210] sd 7:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    0.909213] sd 7:0:0:0: [sdc] 4096-byte physical blocks
[    0.909302] sd 7:0:0:0: [sdc] Write Protect is off
[    0.909305] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    0.909361] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.911469] sd 0:0:0:0: [sda] Write Protect is off
[    0.911635] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.911652] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.912289]  sda: sda1
[    0.912739] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.944632]  sdc: sdc1
[    0.945327] sd 7:0:0:0: [sdc] Attached SCSI disk
[    0.946520]  sdb: sdb1
[    0.947141] sd 1:0:0:0: [sdb] Attached SCSI disk
[    0.947541] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
[    0.948020] EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
[    0.952103] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    0.952435] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    0.952975] Freeing unused kernel memory: 792K (ffffffff815c7000 - ffffffff8168d000)
[    1.568602] random: systemd-udevd urandom read with 87 bits of entropy available
[    1.578813] tsc: Refined TSC clocksource calibration: 3399.999 MHz
[    1.578816] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x31024d9464a, max_idle_ns: 440795287124 ns
[    1.646520] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.646864] Linux agpgart interface v0.103
[    1.646986] ohci-pci: OHCI PCI platform driver
[    1.647134] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    1.647141] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
[    1.647165] ohci-pci 0000:00:12.0: irq 18, io mem 0xfe10c000
[    1.662958] [drm] Initialized drm 1.1.0 20060810
[    1.676350] microcode: CPU0: patch_level=0x06001119
[    1.681752] microcode: CPU1: patch_level=0x06001119
[    1.681766] microcode: CPU2: patch_level=0x06001119
[    1.681773] microcode: CPU3: patch_level=0x06001119
[    1.681818] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    1.701900] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    1.701905] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.701907] usb usb3: Product: OHCI PCI host controller
[    1.701909] usb usb3: Manufacturer: Linux 4.1.15-gentoo-r1 ohci_hcd
[    1.701911] usb usb3: SerialNumber: 0000:00:12.0
[    1.702083] hub 3-0:1.0: USB hub found
[    1.702094] hub 3-0:1.0: 5 ports detected
[    1.702402] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    1.702409] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 4
[    1.702424] ohci-pci 0000:00:13.0: irq 18, io mem 0xfe10a000
[    1.710752] random: nonblocking pool is initialized
[    1.722866] nvidia: module license 'NVIDIA' taints kernel.
[    1.722870] Disabling lock debugging due to kernel taint
[    1.733184] vgaarb: device changed decodes: PCI:0000:01:00.0,olddecodes=io+mem,decodes=none:owns=io+mem
[    1.733306] nvidia-nvlink: Nvlink Core is being initialized, major device number 251
[    1.733324] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  364.12  Wed Mar 16 21:11:26 PDT 2016
[    1.738452] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  364.12  Wed Mar 16 20:44:12 PDT 2016
[    1.739666] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    1.756896] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    1.756907] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.756913] usb usb4: Product: OHCI PCI host controller
[    1.756919] usb usb4: Manufacturer: Linux 4.1.15-gentoo-r1 ohci_hcd
[    1.756920] usb usb4: SerialNumber: 0000:00:13.0
[    1.757304] hub 4-0:1.0: USB hub found
[    1.757330] hub 4-0:1.0: 5 ports detected
[    1.757982] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    1.758010] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 5
[    1.758049] ohci-pci 0000:00:14.5: irq 18, io mem 0xfe108000
[    1.812786] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    1.812793] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.812799] usb usb5: Product: OHCI PCI host controller
[    1.812804] usb usb5: Manufacturer: Linux 4.1.15-gentoo-r1 ohci_hcd
[    1.812807] usb usb5: SerialNumber: 0000:00:14.5
[    1.813121] hub 5-0:1.0: USB hub found
[    1.813137] hub 5-0:1.0: 2 ports detected
[    1.813622] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.813644] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
[    1.813951] xhci_hcd 0000:00:10.0: hcc params 0x014042c3 hci version 0x96 quirks 0x00000608
[    1.814267] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
[    1.814275] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.814280] usb usb6: Product: xHCI Host Controller
[    1.814284] usb usb6: Manufacturer: Linux 4.1.15-gentoo-r1 xhci-hcd
[    1.814288] usb usb6: SerialNumber: 0000:00:10.0
[    1.814557] hub 6-0:1.0: USB hub found
[    1.814576] hub 6-0:1.0: 2 ports detected
[    1.814778] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.814786] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 7
[    1.817336] usb usb7: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.817354] usb usb7: New USB device found, idVendor=1d6b, idProduct=0003
[    1.817356] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.817357] usb usb7: Product: xHCI Host Controller
[    1.817359] usb usb7: Manufacturer: Linux 4.1.15-gentoo-r1 xhci-hcd
[    1.817361] usb usb7: SerialNumber: 0000:00:10.0
[    1.817447] hub 7-0:1.0: USB hub found
[    1.817458] hub 7-0:1.0: 2 ports detected
[    1.817698] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    1.817706] snd_hda_intel 0000:01:00.1: Disabling MSI
[    1.817755] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    1.817943] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    1.817949] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 8
[    1.818210] xhci_hcd 0000:00:10.1: hcc params 0x014042c3 hci version 0x96 quirks 0x00000608
[    1.818542] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[    1.818544] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.818546] usb usb8: Product: xHCI Host Controller
[    1.818548] usb usb8: Manufacturer: Linux 4.1.15-gentoo-r1 xhci-hcd
[    1.818550] usb usb8: SerialNumber: 0000:00:10.1
[    1.818648] hub 8-0:1.0: USB hub found
[    1.818673] hub 8-0:1.0: 2 ports detected
[    1.818759] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    1.818762] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 9
[    1.821591] usb usb9: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.821622] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[    1.821624] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.821626] usb usb9: Product: xHCI Host Controller
[    1.821628] usb usb9: Manufacturer: Linux 4.1.15-gentoo-r1 xhci-hcd
[    1.821630] usb usb9: SerialNumber: 0000:00:10.1
[    1.821757] hub 9-0:1.0: USB hub found
[    1.821769] hub 9-0:1.0: 2 ports detected
[    1.845196] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    1.845200] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    1.845202] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    1.845203] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    1.845204] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x11/0x1e
[    1.845206] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    1.845208] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[    1.845209] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
[    1.845210] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[    1.845212] snd_hda_codec_realtek hdaudioC1D0:      CD=0x1c
[    1.925693] snd_hda_codec_generic hdaudioC2D0: ignore pin 0x6, too many assigned pins
[    1.928698] snd_hda_codec_generic hdaudioC2D0: ignore pin 0x7, too many assigned pins
[    1.928708] snd_hda_codec_generic hdaudioC2D0: autoconfig for ID 72: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
[    1.928713] snd_hda_codec_generic hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    1.928718] snd_hda_codec_generic hdaudioC2D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    1.928721] snd_hda_codec_generic hdaudioC2D0:    mono: mono_out=0x0
[    1.928724] snd_hda_codec_generic hdaudioC2D0:    dig-out=0x4/0x5
[    1.928727] snd_hda_codec_generic hdaudioC2D0:    inputs:
[    2.024619] usb 3-2: new full-speed USB device number 2 using ohci-pci
[    2.120584] usb 8-1: new high-speed USB device number 2 using xhci_hcd
[    2.170648] usb 3-2: New USB device found, idVendor=0c45, idProduct=613b
[    2.170650] usb 3-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.170655] usb 3-2: Product: USB camera
[    2.238680] usb 8-1: New USB device found, idVendor=413c, idProduct=b112
[    2.238683] usb 8-1: New USB device strings: Mfr=2, Product=3, SerialNumber=4
[    2.238686] usb 8-1: Product: Android
[    2.238688] usb 8-1: Manufacturer: Android
[    2.238690] usb 8-1: SerialNumber: DellVenue8000078236
[    2.295396] usb 3-3: new low-speed USB device number 3 using ohci-pci
[    2.447494] usb 3-3: New USB device found, idVendor=046d, idProduct=c069
[    2.447501] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.447506] usb 3-3: Product: USB Laser Mouse
[    2.447509] usb 3-3: Manufacturer: Logitech
[    2.458890] input: Logitech USB Laser Mouse as /devices/pci0000:00/0000:00:12.0/usb3/3-3/3-3:1.0/0003:046D:C069.0001/input/input1
[    2.459072] hid-generic 0003:046D:C069.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB Laser Mouse] on usb-0000:00:12.0-3/input0
[    2.487657] Linux video capture interface: v2.00
[    2.489830] gspca_main: v2.14.0 registered
[    2.491633] gspca_main: sonixj-2.14.0 probing 0c45:613b
[    2.503718] input: sonixj as /devices/pci0000:00/0000:00:12.0/usb3/3-2/input/input2
[    2.503871] usbcore: registered new interface driver sonixj
[    2.578396] Switched to clocksource tsc
[    4.033928] it87: Found IT8728F chip at 0x228, revision 1
[    4.033945] it87: Beeping is supported
[    4.215571] EXT4-fs (sda1): re-mounted. Opts: discard
[    4.371899] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[    4.425657] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[    5.015847] r8169 0000:02:00.0 eth0: link down
[    5.016358] r8169 0000:02:00.0 eth0: link down
[    7.159161] r8169 0000:02:00.0 eth0: link up
[    8.082323] nvidia-modeset: Allocated GPU:0 (GPU-fd29ea7b-1ee9-7166-84c9-91131f1f10f0) @ PCI:0000:01:00.0

--------------030708000100070204010801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030708000100070204010801--
