From: Meelis Roos <mroos@linux.ee>
Subject: IOMMU+DMAR causing NMIs-s (was: 4.7-rc6: NMI in intel_idle on HP
 Proliant G6)
Date: Wed, 13 Jul 2016 10:17:59 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1607130855210.11080@math.ut.ee>
References: <alpine.LRH.2.20.1607121445020.2088@math.ut.ee> <alpine.LRH.2.20.1607121525060.2088@math.ut.ee> <5630546.0MIYeGNSYG@vostro.rjw.lan> <alpine.LRH.2.20.1607121654490.2088@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.20.1607121654490.2088@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

> > > > On HP Proliant DL360 G6, Debian unstable 4.6 kernel runs fine but 
> > > > selfcompiled 4.7-rc6 and 4.7-rc7 sometimes crash with NMI from 
> > > > intel_idle. Sometimes it boots fine. With intel_idle disabled, it has 
> > > > booted successful so far in 2 tries, one with rc6 and one with rc7.
> > > 
> > > More testing shows it can NMI on acpi_idle too, not just intel_idle.
> > > 
> > > > Screenshot with some backtrace: 
> > > > http://kodu.ut.ee/~mroos/intel-idle-NMI.png
> > > 
> > > http://kodu.ut.ee/~mroos/acpi-idle-NMI.png
> > 
> > There were almost no changes in the ACPI idle driver between 4.6 and
> > 4.7-rc, so the reason is somewhere else.
> > 
> > Have you tried any earlier 4.7-rc?
> 
> I tried selfcompiled 4.6.0 now with the same conf that 4.7-rc's have and 
> after multiple tries I got the same NMI out of 4.6 too, from kernfs 
> lookup (that seems to just a random victim).
> 
> So this is not a 4.7 regression and probably not idle-releated.
> 
> Seems my kernel config is causing NMI-s for some reason. I was suprised 
> to see the kernel recommend to see HP ILO logs on HP but there was 
> nothing in the logs.

Bisecting kernel configs shows that it's DMAR+IOMMU. When it is 
activated, there is high probability of NMI-s in random places.

So it is no longer relevant to linux-pm and intel-idle, dropped CC-s and 
added iommu related mails.


Full dmesg from successful boot with IOMMU enabled is below.

> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> CONFIG_INTEL_IDMA64=m
> CONFIG_INTEL_IOATDMA=m
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> # CONFIG_DW_DMAC is not set
> # CONFIG_DW_DMAC_PCI is not set
> CONFIG_HSU_DMA=y
[...]

> #
> # Generic IOMMU Pagetable Support
> #
> CONFIG_IOMMU_IOVA=y
> # CONFIG_AMD_IOMMU is not set
> CONFIG_DMAR_TABLE=y
> CONFIG_INTEL_IOMMU=y
> CONFIG_INTEL_IOMMU_SVM=y
> CONFIG_INTEL_IOMMU_DEFAULT_ON=y

CONFIG_INTEL_IOMMU_DEFAULT_ON=y is the setting that switches the 
instability on and off.

> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> CONFIG_IRQ_REMAP=y

[    0.000000] Linux version 4.6.0 (mroos@dl360g6) (gcc version 5.4.0 20160609 (Debian 5.4.0-6) ) #9 SMP Wed Jul 13 01:00:26 EEST 2016
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.6.0 root=/dev/sda1 ro
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000df61efff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df61f000-0x00000000df62bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000df62c000-0x00000000df62cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df62d000-0x00000000e3ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fee0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000061fffefff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: HP ProLiant DL360 G6, BIOS P64 01/22/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x61ffff max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00E0000000 mask FFE0000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: last_pfn = 0xdf62d max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f4f80-0x000f4f8f] mapped at [ffff8800000f4f80]
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] BRK [0x01d35000, 0x01d35fff] PGTABLE
[    0.000000] BRK [0x01d36000, 0x01d36fff] PGTABLE
[    0.000000] BRK [0x01d37000, 0x01d37fff] PGTABLE
[    0.000000] BRK [0x01d38000, 0x01d38fff] PGTABLE
[    0.000000] BRK [0x01d39000, 0x01d39fff] PGTABLE
[    0.000000] BRK [0x01d3a000, 0x01d3afff] PGTABLE
[    0.000000] RAMDISK: [mem 0x21572000-0x2cab0fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F4F00 000024 (v02 HP    )
[    0.000000] ACPI: XSDT 0x00000000DF620140 0000B4 (v01 HP     ProLiant 00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI: FACP 0x00000000DF620240 0000F4 (v03 HP     ProLiant 00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aControlBlock: 32, using default 16 (20160108/tbfadt-704)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm2ControlBlock: 32, using default 8 (20160108/tbfadt-704)
[    0.000000] ACPI: DSDT 0x00000000DF620340 00206D (v01 HP     DSDT     00000001 INTL 20030228)
[    0.000000] ACPI: FACS 0x00000000DF61F100 000040
[    0.000000] ACPI: FACS 0x00000000DF61F100 000040
[    0.000000] ACPI: SPCR 0x00000000DF61F140 000050 (v01 HP     SPCRRBSU 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: MCFG 0x00000000DF61F1C0 00003C (v01 HP     ProLiant 00000001      00000000)
[    0.000000] ACPI: HPET 0x00000000DF61F200 000038 (v01 HP     ProLiant 00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI: FFFF 0x00000000DF61F240 000064 (v02 HP     ProLiant 00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI: SPMI 0x00000000DF61F2C0 000040 (v05 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: ERST 0x00000000DF61F300 0001D0 (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: APIC 0x00000000DF61F500 00015E (v01 HP     ProLiant 00000002      00000000)
[    0.000000] ACPI: SRAT 0x00000000DF61F680 000570 (v01 HP     Proliant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: FFFF 0x00000000DF61FC00 000176 (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: BERT 0x00000000DF61FD80 000030 (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: HEST 0x00000000DF61FDC0 0000BC (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: DMAR 0x00000000DF61FE80 000164 (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: SSDT 0x00000000DF6223C0 000125 (v03 HP     CRSPCI0  00000002 HP   00000001)
[    0.000000] ACPI: SSDT 0x00000000DF622500 0001CF (v03 HP     riser1a  00000002 INTL 20061109)
[    0.000000] ACPI: SSDT 0x00000000DF622700 0003BB (v01 HP     pcc      00000001 INTL 20090625)
[    0.000000] ACPI: SSDT 0x00000000DF622AC0 000377 (v01 HP     pmab     00000001 INTL 20090625)
[    0.000000] ACPI: SSDT 0x00000000DF622E40 002B64 (v01 INTEL  PPM RCM  00000001 INTL 20061109)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x10 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x11 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x12 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x13 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x14 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x15 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x16 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x17 -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0xdfffffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x100000000-0x31fffffff]
[    0.000000] SRAT: Node 1 PXM 1 [mem 0x320000000-0x61fffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0xdfffffff] + [mem 0x100000000-0x31fffffff] -> [mem 0x00000000-0x31fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x31fffb000-0x31fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x61fffa000-0x61fffefff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000061fffefff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000df61efff]
[    0.000000]   node   0: [mem 0x00000000df62c000-0x00000000df62cfff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000031fffffff]
[    0.000000]   node   1: [mem 0x0000000320000000-0x000000061fffefff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000031fffffff]
[    0.000000] On node 0 totalpages: 3143102
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14233 pages used for memmap
[    0.000000]   DMA32 zone: 910880 pages, LIFO batch:31
[    0.000000]   Normal zone: 34816 pages used for memmap
[    0.000000]   Normal zone: 2228224 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000000320000000-0x000000061fffefff]
[    0.000000] On node 1 totalpages: 3145727
[    0.000000]   Normal zone: 49152 pages used for memmap
[    0.000000]   Normal zone: 3145727 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x908
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 0, version 32, address 0xfec80000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 32 CPUs, 16 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf61f000-0xdf62bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf62d000-0xe3ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe4000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfee0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee10000-0xff7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
[    0.000000] e820: [mem 0xe4000000-0xfebfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:32 nr_node_ids:2
[    0.000000] percpu: Embedded 32 pages/cpu @ffff880313c00000 s93720 r8192 d29160 u131072
[    0.000000] pcpu-alloc: s93720 r8192 d29160 u131072 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 02 04 06 08 10 12 14 16 18 20 22 24 26 28 30 
[    0.000000] pcpu-alloc: [1] 01 03 05 07 09 11 13 15 17 19 21 23 25 27 29 31 
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 6190543
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.6.0 root=/dev/sda1 ro
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 126976 bytes
[    0.000000] log_buf_len min size: 131072 bytes
[    0.000000] log_buf_len: 262144 bytes
[    0.000000] early log buf free: 120396(91%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 24491988K/25155316K available (5930K kernel code, 1090K rwdata, 2668K rodata, 1332K init, 824K bss, 663328K reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=32.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=32
[    0.000000] NR_IRQS:33024 nr_irqs:1088 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] mempolicy: Disabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2533.284 MHz processor
[    0.000033] Calibrating delay loop (skipped), value calculated using timer frequency.. 5066.56 BogoMIPS (lpj=10133136)
[    0.000249] pid_max: default: 32768 minimum: 301
[    0.000389] ACPI: Core revision 20160108
[    0.004722] ACPI: 6 ACPI AML tables successfully acquired and loaded

[    0.005083] Security Framework initialized
[    0.005185] Yama: becoming mindful.
[    0.005288] AppArmor: AppArmor disabled by boot time parameter
[    0.007519] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.015271] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.018329] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.018485] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.019141] CPU: Physical Processor ID: 0
[    0.019242] CPU: Processor Core ID: 0
[    0.019344] mce: CPU supports 9 MCE banks
[    0.019452] CPU0: Thermal monitoring enabled (TM1)
[    0.019562] process: using mwait in idle threads
[    0.019668] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.019776] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.020162] Freeing SMP alternatives memory: 24K (ffffffff81c5f000 - ffffffff81c65000)
[    0.021789] ftrace: allocating 24365 entries in 96 pages
[    0.031607] smpboot: Max logical packages: 8
[    0.031710] smpboot: APIC(0) Converting physical 0 to logical package 0
[    0.031826] smpboot: APIC(10) Converting physical 1 to logical package 1
[    0.031948] DMAR-IR: This system BIOS has enabled interrupt remapping
               on a chipset that contains an erratum making that
               feature unstable.  To maintain system stability
               interrupt remapping is being disabled.  Please
               contact your BIOS vendor for an update
[    0.032362] Switched APIC routing to physical flat.
[    0.032994] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.178326] smpboot: CPU0: Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz (family: 0x6, model: 0x1a, stepping: 0x5)
[    0.178620] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events, Broken BIOS detected, complain to your hardware vendor.
[    0.182527] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR 38d is 330)
[    0.182693] Intel PMU driver.
[    0.182786] core: CPU erratum AAJ80 worked around
[    0.182889] core: CPUID marked event: 'bus cycles' unavailable
[    0.183001] ... version:                3
[    0.183101] ... bit width:              48
[    0.183202] ... generic registers:      4
[    0.183301] ... value mask:             0000ffffffffffff
[    0.183408] ... max period:             000000007fffffff
[    0.183516] ... fixed-purpose events:   3
[    0.183615] ... event mask:             000000070000000f
[    0.185092] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.185434] x86: Booting SMP configuration:
[    0.185536] .... node  #1, CPUs:        #1
[    0.282761] .... node  #0, CPUs:    #2
[    0.364734] .... node  #1, CPUs:    #3
[    0.444656] .... node  #0, CPUs:    #4
[    0.524650] .... node  #1, CPUs:    #5
[    0.604639] .... node  #0, CPUs:    #6
[    0.684654] .... node  #1, CPUs:    #7
[    0.764689] .... node  #0, CPUs:    #8
[    0.844674] .... node  #1, CPUs:    #9
[    0.924650] .... node  #0, CPUs:   #10
[    1.004666] .... node  #1, CPUs:   #11
[    1.084621] .... node  #0, CPUs:   #12
[    1.164662] .... node  #1, CPUs:   #13
[    1.244623] .... node  #0, CPUs:   #14
[    1.324674] .... node  #1, CPUs:   #15
[    1.404438] x86: Booted up 2 nodes, 16 CPUs
[    1.404622] smpboot: Total of 16 processors activated (81067.45 BogoMIPS)
[    1.418740] devtmpfs: initialized
[    1.418945] x86/mm: Memory block size: 128MB
[    1.424245] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.424568] pinctrl core: initialized pinctrl subsystem
[    1.424864] NET: Registered protocol family 16
[    1.434379] cpuidle: using governor ladder
[    1.446382] cpuidle: using governor menu
[    1.446532] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    1.446696] ACPI: bus type PCI registered
[    1.446795] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.447012] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000-0xe3ffffff] (base 0xe0000000)
[    1.447189] PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] reserved in E820
[    1.447309] PCI: Using configuration type 1 for base access
[    1.447420] PCI: HP ProLiant DL360 detected, enabling pci=bfsort.
[    1.458608] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.459195] ACPI: Added _OSI(Module Device)
[    1.459298] ACPI: Added _OSI(Processor Device)
[    1.459400] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.459505] ACPI: Added _OSI(Processor Aggregator Device)
[    1.463617] ACPI: Interpreter enabled
[    1.463731] ACPI: (supports S0 S4 S5)
[    1.463830] ACPI: Using IOAPIC for interrupt routing
[    1.463961] HEST: Table parsing has been initialized.
[    1.464069] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.468790] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-0f])
[    1.468909] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.469082] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.469220] acpi PNP0A08:00: host bridge window expanded to [mem 0xfed00000-0xfed44fff window]; [mem 0xfed00000-0xfed44fff window] ignored
[    1.469567] PCI host bridge to bus 0000:00
[    1.469670] pci_bus 0000:00: root bus resource [mem 0xe7000000-0xfbffffff window]
[    1.469836] pci_bus 0000:00: root bus resource [io  0x1000-0x6fff window]
[    1.469953] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    1.470071] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    1.470189] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
[    1.470307] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfed44fff window]
[    1.470473] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    1.470590] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    1.470708] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.470873] pci_bus 0000:00: root bus resource [bus 00-0f]
[    1.470994] pci 0000:00:00.0: [8086:3406] type 00 class 0x060000
[    1.471053] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.471144] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    1.471200] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.471294] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
[    1.471348] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.471440] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    1.471495] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.471587] pci 0000:00:04.0: [8086:340b] type 01 class 0x060400
[    1.471640] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    1.471731] pci 0000:00:05.0: [8086:340c] type 01 class 0x060400
[    1.471785] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    1.471875] pci 0000:00:06.0: [8086:340d] type 01 class 0x060400
[    1.471929] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    1.472024] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    1.472079] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    1.472171] pci 0000:00:08.0: [8086:340f] type 01 class 0x060400
[    1.472225] pci 0000:00:08.0: PME# supported from D0 D3hot D3cold
[    1.472316] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
[    1.472370] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    1.472471] pci 0000:00:0a.0: [8086:3411] type 01 class 0x060400
[    1.472525] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    1.472619] pci 0000:00:0d.0: [8086:343a] type 00 class 0x060000
[    1.472736] pci 0000:00:0d.1: [8086:343b] type 00 class 0x060000
[    1.472851] pci 0000:00:0d.2: [8086:343c] type 00 class 0x060000
[    1.472964] pci 0000:00:0d.3: [8086:343d] type 00 class 0x060000
[    1.473076] pci 0000:00:0d.4: [8086:3418] type 00 class 0x060000
[    1.473189] pci 0000:00:0d.5: [8086:3419] type 00 class 0x060000
[    1.473303] pci 0000:00:0d.6: [8086:341a] type 00 class 0x060000
[    1.473418] pci 0000:00:0e.0: [8086:341c] type 00 class 0x060000
[    1.473530] pci 0000:00:0e.1: [8086:341d] type 00 class 0x060000
[    1.473644] pci 0000:00:0e.2: [8086:341e] type 00 class 0x060000
[    1.473755] pci 0000:00:0e.3: [8086:341f] type 00 class 0x060000
[    1.473870] pci 0000:00:0e.4: [8086:3439] type 00 class 0x060000
[    1.473985] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    1.474099] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    1.474211] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    1.474339] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    1.474404] pci 0000:00:1d.0: reg 0x20: [io  0x1000-0x101f]
[    1.474532] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    1.474597] pci 0000:00:1d.1: reg 0x20: [io  0x1020-0x103f]
[    1.474725] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    1.474790] pci 0000:00:1d.2: reg 0x20: [io  0x1040-0x105f]
[    1.474916] pci 0000:00:1d.3: [8086:3a39] type 00 class 0x0c0300
[    1.474965] pci 0000:00:1d.3: reg 0x20: [io  0x1060-0x107f]
[    1.475094] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    1.475112] pci 0000:00:1d.7: reg 0x10: [mem 0xf5df0000-0xf5df03ff]
[    1.475195] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    1.475274] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    1.475396] pci 0000:00:1f.0: [8086:3a18] type 00 class 0x060100
[    1.475565] pci 0000:00:1f.2: [8086:3a20] type 00 class 0x01018f
[    1.475579] pci 0000:00:1f.2: reg 0x10: [io  0x1080-0x1087]
[    1.475587] pci 0000:00:1f.2: reg 0x14: [io  0x1088-0x108b]
[    1.475595] pci 0000:00:1f.2: reg 0x18: [io  0x1090-0x1097]
[    1.475602] pci 0000:00:1f.2: reg 0x1c: [io  0x1098-0x109b]
[    1.475610] pci 0000:00:1f.2: reg 0x20: [io  0x10a0-0x10af]
[    1.475617] pci 0000:00:1f.2: reg 0x24: [io  0x10b0-0x10bf]
[    1.475771] pci 0000:03:00.0: [103c:323a] type 00 class 0x010400
[    1.475787] pci 0000:03:00.0: reg 0x10: [mem 0xfbc00000-0xfbdfffff 64bit]
[    1.475798] pci 0000:03:00.0: reg 0x18: [mem 0xfbbf0000-0xfbbf0fff 64bit]
[    1.475805] pci 0000:03:00.0: reg 0x20: [io  0x4000-0x40ff]
[    1.475819] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.475860] pci 0000:03:00.0: PME# supported from D0
[    1.484437] pci 0000:00:01.0: PCI bridge to [bus 03]
[    1.484500] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    1.484503] pci 0000:00:01.0:   bridge window [mem 0xfbb00000-0xfbdfffff]
[    1.484554] pci 0000:00:02.0: PCI bridge to [bus 0a]
[    1.484753] pci 0000:07:00.0: [1077:2432] type 00 class 0x0c0400
[    1.484769] pci 0000:07:00.0: reg 0x10: [io  0x6000-0x60ff]
[    1.484783] pci 0000:07:00.0: reg 0x14: [mem 0xfbff0000-0xfbff3fff 64bit]
[    1.484815] pci 0000:07:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    1.484961] pci 0000:07:00.1: [1077:2432] type 00 class 0x0c0400
[    1.484977] pci 0000:07:00.1: reg 0x10: [io  0x6400-0x64ff]
[    1.484991] pci 0000:07:00.1: reg 0x14: [mem 0xfbfe0000-0xfbfe3fff 64bit]
[    1.485023] pci 0000:07:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    1.492444] pci 0000:00:03.0: PCI bridge to [bus 07-09]
[    1.492556] pci 0000:00:03.0:   bridge window [io  0x6000-0x6fff]
[    1.492560] pci 0000:00:03.0:   bridge window [mem 0xfbf00000-0xfbffffff]
[    1.492608] pci 0000:00:04.0: PCI bridge to [bus 0b]
[    1.492763] pci 0000:00:05.0: PCI bridge to [bus 0c]
[    1.492918] pci 0000:00:06.0: PCI bridge to [bus 0d]
[    1.493072] pci 0000:00:07.0: PCI bridge to [bus 0e]
[    1.493236] pci 0000:02:00.0: [14e4:1639] type 00 class 0x020000
[    1.493253] pci 0000:02:00.0: reg 0x10: [mem 0xf8000000-0xf9ffffff 64bit]
[    1.493286] pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.493345] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.493426] pci 0000:02:00.1: [14e4:1639] type 00 class 0x020000
[    1.493443] pci 0000:02:00.1: reg 0x10: [mem 0xf6000000-0xf7ffffff 64bit]
[    1.493476] pci 0000:02:00.1: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.493534] pci 0000:02:00.1: PME# supported from D0 D3hot D3cold
[    1.500447] pci 0000:00:08.0: PCI bridge to [bus 02]
[    1.500558] pci 0000:00:08.0:   bridge window [mem 0xf6000000-0xf9ffffff]
[    1.500704] pci 0000:04:00.0: [8086:105e] type 00 class 0x020000
[    1.500719] pci 0000:04:00.0: reg 0x10: [mem 0xfbee0000-0xfbefffff]
[    1.500728] pci 0000:04:00.0: reg 0x14: [mem 0xfbec0000-0xfbedffff]
[    1.500737] pci 0000:04:00.0: reg 0x18: [io  0x5000-0x501f]
[    1.500767] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.500813] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    1.500912] pci 0000:04:00.1: [8086:105e] type 00 class 0x020000
[    1.500926] pci 0000:04:00.1: reg 0x10: [mem 0xfbea0000-0xfbebffff]
[    1.500935] pci 0000:04:00.1: reg 0x14: [mem 0xfbe80000-0xfbe9ffff]
[    1.500944] pci 0000:04:00.1: reg 0x18: [io  0x5020-0x503f]
[    1.500974] pci 0000:04:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.501020] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
[    1.508452] pci 0000:00:09.0: PCI bridge to [bus 04-06]
[    1.508563] pci 0000:00:09.0:   bridge window [io  0x5000-0x5fff]
[    1.508566] pci 0000:00:09.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.508617] pci 0000:00:0a.0: PCI bridge to [bus 0f]
[    1.508790] pci 0000:01:03.0: [1002:515e] type 00 class 0x030000
[    1.508808] pci 0000:01:03.0: reg 0x10: [mem 0xe8000000-0xefffffff pref]
[    1.508818] pci 0000:01:03.0: reg 0x14: [io  0x3000-0x30ff]
[    1.508828] pci 0000:01:03.0: reg 0x18: [mem 0xf5ff0000-0xf5ffffff]
[    1.508864] pci 0000:01:03.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.508895] pci 0000:01:03.0: supports D1 D2
[    1.508950] pci 0000:01:04.0: [0e11:b203] type 00 class 0x088000
[    1.508967] pci 0000:01:04.0: reg 0x10: [io  0x2800-0x28ff]
[    1.508977] pci 0000:01:04.0: reg 0x14: [mem 0xf5fe0000-0xf5fe01ff]
[    1.509049] pci 0000:01:04.0: PME# supported from D0 D3hot D3cold
[    1.509120] pci 0000:01:04.2: [0e11:b204] type 00 class 0x088000
[    1.509138] pci 0000:01:04.2: reg 0x10: [io  0x3400-0x34ff]
[    1.509150] pci 0000:01:04.2: reg 0x14: [mem 0xf5fd0000-0xf5fd07ff]
[    1.509161] pci 0000:01:04.2: reg 0x18: [mem 0xf5fc0000-0xf5fc3fff]
[    1.509172] pci 0000:01:04.2: reg 0x1c: [mem 0xf5f00000-0xf5f7ffff]
[    1.509202] pci 0000:01:04.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.509236] pci 0000:01:04.2: PME# supported from D0 D3hot D3cold
[    1.509301] pci 0000:01:04.4: [103c:3300] type 00 class 0x0c0300
[    1.509355] pci 0000:01:04.4: reg 0x20: [io  0x3800-0x381f]
[    1.509408] pci 0000:01:04.4: PME# supported from D0 D3hot D3cold
[    1.509471] pci 0000:01:04.6: [103c:3302] type 00 class 0x0c0701
[    1.509487] pci 0000:01:04.6: reg 0x10: [mem 0xf5ef0000-0xf5ef00ff]
[    1.509568] pci 0000:01:04.6: PME# supported from D0 D3hot D3cold
[    1.509653] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive decode)
[    1.509772] pci 0000:00:1e.0:   bridge window [io  0x2000-0x3fff]
[    1.509776] pci 0000:00:1e.0:   bridge window [mem 0xf5e00000-0xf5ffffff]
[    1.509781] pci 0000:00:1e.0:   bridge window [mem 0xe8000000-0xefffffff 64bit pref]
[    1.509784] pci 0000:00:1e.0:   bridge window [mem 0xe7000000-0xfbffffff window] (subtractive decode)
[    1.509786] pci 0000:00:1e.0:   bridge window [io  0x1000-0x6fff window] (subtractive decode)
[    1.509788] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    1.509790] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    1.509792] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x0fff window] (subtractive decode)
[    1.509794] pci 0000:00:1e.0:   bridge window [mem 0xfed00000-0xfed44fff window] (subtractive decode)
[    1.509796] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
[    1.509798] pci 0000:00:1e.0:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
[    1.509800] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    1.510231] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *7 10 11)
[    1.510599] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
[    1.510966] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 10 11) *0, disabled.
[    1.511405] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 10 11) *0, disabled.
[    1.511843] ACPI: PCI Interrupt Link [LNKE] (IRQs *5 7 10 11)
[    1.512208] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 *10 11)
[    1.512580] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 7 *10 11)
[    1.512946] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 *7 10 11)
[    1.513502] vgaarb: setting as boot device: PCI:0000:01:03.0
[    1.513618] vgaarb: device added: PCI:0000:01:03.0,decodes=io+mem,owns=io+mem,locks=none
[    1.513786] vgaarb: loaded
[    1.513879] vgaarb: bridge control possible 0000:01:03.0
[    1.514112] PCI: Using ACPI for IRQ routing
[    1.515448] PCI: Discovered peer bus 3e
[    1.515548] PCI: root bus 3e: using default resources
[    1.515551] PCI: Probing PCI hardware (bus 3e)
[    1.515600] ACPI: \: failed to evaluate _DSM (0x1001)
[    1.515707] PCI host bridge to bus 0000:3e
[    1.515809] pci_bus 0000:3e: root bus resource [io  0x0000-0xffff]
[    1.515924] pci_bus 0000:3e: root bus resource [mem 0x00000000-0xffffffffff]
[    1.516043] pci_bus 0000:3e: No busn resource found for root bus, will use [bus 3e-ff]
[    1.516214] pci 0000:3e:00.0: [8086:2c40] type 00 class 0x060000
[    1.516276] pci 0000:3e:00.1: [8086:2c01] type 00 class 0x060000
[    1.516335] pci 0000:3e:02.0: [8086:2c10] type 00 class 0x060000
[    1.516392] pci 0000:3e:02.1: [8086:2c11] type 00 class 0x060000
[    1.516454] pci 0000:3e:02.4: [8086:2c14] type 00 class 0x060000
[    1.516512] pci 0000:3e:02.5: [8086:2c15] type 00 class 0x060000
[    1.516569] pci 0000:3e:03.0: [8086:2c18] type 00 class 0x060000
[    1.516624] pci 0000:3e:03.1: [8086:2c19] type 00 class 0x060000
[    1.516680] pci 0000:3e:03.2: [8086:2c1a] type 00 class 0x060000
[    1.516736] pci 0000:3e:03.4: [8086:2c1c] type 00 class 0x060000
[    1.516793] pci 0000:3e:04.0: [8086:2c20] type 00 class 0x060000
[    1.516849] pci 0000:3e:04.1: [8086:2c21] type 00 class 0x060000
[    1.516905] pci 0000:3e:04.2: [8086:2c22] type 00 class 0x060000
[    1.516960] pci 0000:3e:04.3: [8086:2c23] type 00 class 0x060000
[    1.517018] pci 0000:3e:05.0: [8086:2c28] type 00 class 0x060000
[    1.517074] pci 0000:3e:05.1: [8086:2c29] type 00 class 0x060000
[    1.517129] pci 0000:3e:05.2: [8086:2c2a] type 00 class 0x060000
[    1.517186] pci 0000:3e:05.3: [8086:2c2b] type 00 class 0x060000
[    1.517243] pci 0000:3e:06.0: [8086:2c30] type 00 class 0x060000
[    1.517299] pci 0000:3e:06.1: [8086:2c31] type 00 class 0x060000
[    1.517354] pci 0000:3e:06.2: [8086:2c32] type 00 class 0x060000
[    1.517410] pci 0000:3e:06.3: [8086:2c33] type 00 class 0x060000
[    1.517480] pci_bus 0000:3e: busn_res: [bus 3e-ff] end is updated to 3e
[    1.517487] PCI: Discovered peer bus 3f
[    1.517587] PCI: root bus 3f: using default resources
[    1.517589] PCI: Probing PCI hardware (bus 3f)
[    1.517629] ACPI: \: failed to evaluate _DSM (0x1001)
[    1.517736] PCI host bridge to bus 0000:3f
[    1.517838] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    1.517952] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xffffffffff]
[    1.518071] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    1.518190] pci 0000:3f:00.0: [8086:2c40] type 00 class 0x060000
[    1.518247] pci 0000:3f:00.1: [8086:2c01] type 00 class 0x060000
[    1.518303] pci 0000:3f:02.0: [8086:2c10] type 00 class 0x060000
[    1.518357] pci 0000:3f:02.1: [8086:2c11] type 00 class 0x060000
[    1.518411] pci 0000:3f:02.4: [8086:2c14] type 00 class 0x060000
[    1.518465] pci 0000:3f:02.5: [8086:2c15] type 00 class 0x060000
[    1.518518] pci 0000:3f:03.0: [8086:2c18] type 00 class 0x060000
[    1.518572] pci 0000:3f:03.1: [8086:2c19] type 00 class 0x060000
[    1.518627] pci 0000:3f:03.2: [8086:2c1a] type 00 class 0x060000
[    1.518680] pci 0000:3f:03.4: [8086:2c1c] type 00 class 0x060000
[    1.518734] pci 0000:3f:04.0: [8086:2c20] type 00 class 0x060000
[    1.518787] pci 0000:3f:04.1: [8086:2c21] type 00 class 0x060000
[    1.518840] pci 0000:3f:04.2: [8086:2c22] type 00 class 0x060000
[    1.518892] pci 0000:3f:04.3: [8086:2c23] type 00 class 0x060000
[    1.518947] pci 0000:3f:05.0: [8086:2c28] type 00 class 0x060000
[    1.519000] pci 0000:3f:05.1: [8086:2c29] type 00 class 0x060000
[    1.519053] pci 0000:3f:05.2: [8086:2c2a] type 00 class 0x060000
[    1.519107] pci 0000:3f:05.3: [8086:2c2b] type 00 class 0x060000
[    1.519162] pci 0000:3f:06.0: [8086:2c30] type 00 class 0x060000
[    1.519217] pci 0000:3f:06.1: [8086:2c31] type 00 class 0x060000
[    1.519271] pci 0000:3f:06.2: [8086:2c32] type 00 class 0x060000
[    1.519325] pci 0000:3f:06.3: [8086:2c33] type 00 class 0x060000
[    1.519390] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    1.519397] PCI: pci_cache_line_size set to 64 bytes
[    1.519527] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    1.519529] e820: reserve RAM buffer [mem 0xdf61f000-0xdfffffff]
[    1.519531] e820: reserve RAM buffer [mem 0xdf62d000-0xdfffffff]
[    1.519532] e820: reserve RAM buffer [mem 0x61ffff000-0x61fffffff]
[    1.519808] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    1.519932] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    1.520205] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    1.522975] clocksource: Switched to clocksource hpet
[    1.531331] VFS: Disk quotas dquot_6.6.0
[    1.531502] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.531803] pnp: PnP ACPI init
[    1.532219] system 00:00: [io  0x0408-0x040f] has been reserved
[    1.532334] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    1.532448] system 00:00: [io  0x0700-0x071f] has been reserved
[    1.532561] system 00:00: [io  0x0880-0x08ff] has been reserved
[    1.532674] system 00:00: [io  0x0900-0x097f] has been reserved
[    1.532787] system 00:00: [io  0x0c80-0x0c83] has been reserved
[    1.532900] system 00:00: [io  0x0cd4-0x0cd7] has been reserved
[    1.533013] system 00:00: [io  0x0f50-0x0f58] has been reserved
[    1.533126] system 00:00: [io  0x0ca0-0x0ca1] has been reserved
[    1.533239] system 00:00: [io  0x0ca4-0x0ca5] has been reserved
[    1.533352] system 00:00: [io  0x02f8-0x02ff] has been reserved
[    1.533466] system 00:00: [mem 0xe0000000-0xe3ffffff] has been reserved
[    1.533583] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
[    1.533700] system 00:00: [mem 0xe7ffe000-0xe7ffffff] has been reserved
[    1.533818] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.533886] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.533926] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    1.534170] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    1.534252] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.534438] pnp: PnP ACPI: found 5 devices
[    1.541942] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.542188] pci 0000:03:00.0: BAR 6: assigned [mem 0xfbb00000-0xfbb7ffff pref]
[    1.542352] pci 0000:00:01.0: PCI bridge to [bus 03]
[    1.542460] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    1.542577] pci 0000:00:01.0:   bridge window [mem 0xfbb00000-0xfbdfffff]
[    1.542699] pci 0000:00:02.0: PCI bridge to [bus 0a]
[    1.542813] pci 0000:07:00.0: BAR 6: assigned [mem 0xfbf00000-0xfbf3ffff pref]
[    1.542982] pci 0000:07:00.1: BAR 6: assigned [mem 0xfbf40000-0xfbf7ffff pref]
[    1.543146] pci 0000:00:03.0: PCI bridge to [bus 07-09]
[    1.543255] pci 0000:00:03.0:   bridge window [io  0x6000-0x6fff]
[    1.543371] pci 0000:00:03.0:   bridge window [mem 0xfbf00000-0xfbffffff]
[    1.543493] pci 0000:00:04.0: PCI bridge to [bus 0b]
[    1.543606] pci 0000:00:05.0: PCI bridge to [bus 0c]
[    1.543719] pci 0000:00:06.0: PCI bridge to [bus 0d]
[    1.543832] pci 0000:00:07.0: PCI bridge to [bus 0e]
[    1.543946] pci 0000:02:00.0: BAR 6: no space for [mem size 0x00010000 pref]
[    1.544066] pci 0000:02:00.0: BAR 6: failed to assign [mem size 0x00010000 pref]
[    1.544231] pci 0000:02:00.1: BAR 6: no space for [mem size 0x00010000 pref]
[    1.544350] pci 0000:02:00.1: BAR 6: failed to assign [mem size 0x00010000 pref]
[    1.544516] pci 0000:00:08.0: PCI bridge to [bus 02]
[    1.544625] pci 0000:00:08.0:   bridge window [mem 0xf6000000-0xf9ffffff]
[    1.544748] pci 0000:04:00.0: BAR 6: assigned [mem 0xfbe00000-0xfbe1ffff pref]
[    1.544911] pci 0000:04:00.1: BAR 6: assigned [mem 0xfbe20000-0xfbe3ffff pref]
[    1.545074] pci 0000:00:09.0: PCI bridge to [bus 04-06]
[    1.545182] pci 0000:00:09.0:   bridge window [io  0x5000-0x5fff]
[    1.545297] pci 0000:00:09.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.545420] pci 0000:00:0a.0: PCI bridge to [bus 0f]
[    1.545536] pci 0000:01:03.0: BAR 6: assigned [mem 0xf5e00000-0xf5e1ffff pref]
[    1.545700] pci 0000:01:04.2: BAR 6: assigned [mem 0xf5e20000-0xf5e2ffff pref]
[    1.549461] pci 0000:00:1e.0: PCI bridge to [bus 01]
[    1.549569] pci 0000:00:1e.0:   bridge window [io  0x2000-0x3fff]
[    1.549686] pci 0000:00:1e.0:   bridge window [mem 0xf5e00000-0xf5ffffff]
[    1.549806] pci 0000:00:1e.0:   bridge window [mem 0xe8000000-0xefffffff 64bit pref]
[    1.549977] pci_bus 0000:00: resource 4 [mem 0xe7000000-0xfbffffff window]
[    1.549979] pci_bus 0000:00: resource 5 [io  0x1000-0x6fff window]
[    1.549981] pci_bus 0000:00: resource 6 [io  0x0000-0x03af window]
[    1.549983] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7 window]
[    1.549985] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff window]
[    1.549987] pci_bus 0000:00: resource 9 [mem 0xfed00000-0xfed44fff window]
[    1.549989] pci_bus 0000:00: resource 10 [io  0x03b0-0x03bb window]
[    1.549991] pci_bus 0000:00: resource 11 [io  0x03c0-0x03df window]
[    1.549993] pci_bus 0000:00: resource 12 [mem 0x000a0000-0x000bffff window]
[    1.549995] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    1.549997] pci_bus 0000:03: resource 1 [mem 0xfbb00000-0xfbdfffff]
[    1.549999] pci_bus 0000:07: resource 0 [io  0x6000-0x6fff]
[    1.550001] pci_bus 0000:07: resource 1 [mem 0xfbf00000-0xfbffffff]
[    1.550004] pci_bus 0000:02: resource 1 [mem 0xf6000000-0xf9ffffff]
[    1.550006] pci_bus 0000:04: resource 0 [io  0x5000-0x5fff]
[    1.550007] pci_bus 0000:04: resource 1 [mem 0xfbe00000-0xfbefffff]
[    1.550010] pci_bus 0000:01: resource 0 [io  0x2000-0x3fff]
[    1.550012] pci_bus 0000:01: resource 1 [mem 0xf5e00000-0xf5ffffff]
[    1.550013] pci_bus 0000:01: resource 2 [mem 0xe8000000-0xefffffff 64bit pref]
[    1.550015] pci_bus 0000:01: resource 4 [mem 0xe7000000-0xfbffffff window]
[    1.550017] pci_bus 0000:01: resource 5 [io  0x1000-0x6fff window]
[    1.550019] pci_bus 0000:01: resource 6 [io  0x0000-0x03af window]
[    1.550021] pci_bus 0000:01: resource 7 [io  0x03e0-0x0cf7 window]
[    1.550023] pci_bus 0000:01: resource 8 [io  0x0d00-0x0fff window]
[    1.550025] pci_bus 0000:01: resource 9 [mem 0xfed00000-0xfed44fff window]
[    1.550026] pci_bus 0000:01: resource 10 [io  0x03b0-0x03bb window]
[    1.550028] pci_bus 0000:01: resource 11 [io  0x03c0-0x03df window]
[    1.550030] pci_bus 0000:01: resource 12 [mem 0x000a0000-0x000bffff window]
[    1.550035] pci_bus 0000:3e: resource 4 [io  0x0000-0xffff]
[    1.550037] pci_bus 0000:3e: resource 5 [mem 0x00000000-0xffffffffff]
[    1.550042] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    1.550044] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xffffffffff]
[    1.550177] NET: Registered protocol family 2
[    1.550742] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    1.551491] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.551794] TCP: Hash tables configured (established 262144 bind 65536)
[    1.551972] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    1.552226] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    1.552637] NET: Registered protocol family 1
[    1.567123] pci 0000:01:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.568094] PCI: CLS 64 bytes, default 64
[    1.568159] Unpacking initramfs...
[    4.615627] Freeing initrd memory: 185596K (ffff880021572000 - ffff88002cab1000)
[    4.615732] DMAR: Host address width 39
[    4.615786] DMAR: DRHD base: 0x000000e7ffe000 flags: 0x1
[    4.615859] DMAR: dmar0: reg_base_addr e7ffe000 ver 1:0 cap c90780106f0462 ecap f0207e
[    4.615934] DMAR: RMRR base: 0x000000df7fc000 end: 0x000000df7fdfff
[    4.615991] DMAR: RMRR base: 0x000000df7f5000 end: 0x000000df7fafff
[    4.616049] DMAR: RMRR base: 0x000000df63e000 end: 0x000000df63ffff
[    4.616106] DMAR: ATSR flags: 0x0
[    4.616373] DMAR: dmar0: Using Queued invalidation
[    4.616445] DMAR: Setting RMRR:
[    4.616519] DMAR: Setting identity map for device 0000:01:04.0 [0xdf63e000 - 0xdf63ffff]
[    4.616611] DMAR: Setting identity map for device 0000:01:04.2 [0xdf63e000 - 0xdf63ffff]
[    4.616701] DMAR: Setting identity map for device 0000:03:00.0 [0xdf63e000 - 0xdf63ffff]
[    4.616806] DMAR: Setting identity map for device 0000:04:00.0 [0xdf63e000 - 0xdf63ffff]
[    4.616905] DMAR: Setting identity map for device 0000:04:00.1 [0xdf63e000 - 0xdf63ffff]
[    4.617009] DMAR: Setting identity map for device 0000:07:00.0 [0xdf63e000 - 0xdf63ffff]
[    4.617111] DMAR: Setting identity map for device 0000:07:00.1 [0xdf63e000 - 0xdf63ffff]
[    4.617209] DMAR: Setting identity map for device 0000:00:1d.0 [0xdf7f5000 - 0xdf7fafff]
[    4.617306] DMAR: Setting identity map for device 0000:00:1d.1 [0xdf7f5000 - 0xdf7fafff]
[    4.617404] DMAR: Setting identity map for device 0000:00:1d.2 [0xdf7f5000 - 0xdf7fafff]
[    4.617501] DMAR: Setting identity map for device 0000:00:1d.3 [0xdf7f5000 - 0xdf7fafff]
[    4.617592] DMAR: Setting identity map for device 0000:01:04.0 [0xdf7f5000 - 0xdf7fafff]
[    4.617667] DMAR: Setting identity map for device 0000:01:04.2 [0xdf7f5000 - 0xdf7fafff]
[    4.617743] DMAR: Setting identity map for device 0000:01:04.4 [0xdf7f5000 - 0xdf7fafff]
[    4.617825] DMAR: Setting identity map for device 0000:00:1d.7 [0xdf7fc000 - 0xdf7fdfff]
[    4.617916] DMAR: Prepare 0-16MiB unity mapping for LPC
[    4.617979] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    4.618199] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    4.618317] iommu: Adding device 0000:00:00.0 to group 0
[    4.618395] iommu: Adding device 0000:00:01.0 to group 1
[    4.618468] iommu: Adding device 0000:00:02.0 to group 2
[    4.618541] iommu: Adding device 0000:00:03.0 to group 3
[    4.618613] iommu: Adding device 0000:00:04.0 to group 4
[    4.618686] iommu: Adding device 0000:00:05.0 to group 5
[    4.618758] iommu: Adding device 0000:00:06.0 to group 6
[    4.618830] iommu: Adding device 0000:00:07.0 to group 7
[    4.618902] iommu: Adding device 0000:00:08.0 to group 8
[    4.618974] iommu: Adding device 0000:00:09.0 to group 9
[    4.619046] iommu: Adding device 0000:00:0a.0 to group 10
[    4.619218] iommu: Adding device 0000:00:0d.0 to group 11
[    4.619291] iommu: Adding device 0000:00:0d.1 to group 11
[    4.619363] iommu: Adding device 0000:00:0d.2 to group 11
[    4.619435] iommu: Adding device 0000:00:0d.3 to group 11
[    4.619507] iommu: Adding device 0000:00:0d.4 to group 11
[    4.619579] iommu: Adding device 0000:00:0d.5 to group 11
[    4.619651] iommu: Adding device 0000:00:0d.6 to group 11
[    4.619767] iommu: Adding device 0000:00:0e.0 to group 12
[    4.619839] iommu: Adding device 0000:00:0e.1 to group 12
[    4.619911] iommu: Adding device 0000:00:0e.2 to group 12
[    4.619983] iommu: Adding device 0000:00:0e.3 to group 12
[    4.620055] iommu: Adding device 0000:00:0e.4 to group 12
[    4.620153] iommu: Adding device 0000:00:14.0 to group 13
[    4.620225] iommu: Adding device 0000:00:14.1 to group 13
[    4.620297] iommu: Adding device 0000:00:14.2 to group 13
[    4.620411] iommu: Adding device 0000:00:1d.0 to group 14
[    4.620483] iommu: Adding device 0000:00:1d.1 to group 14
[    4.620554] iommu: Adding device 0000:00:1d.2 to group 14
[    4.620626] iommu: Adding device 0000:00:1d.3 to group 14
[    4.620698] iommu: Adding device 0000:00:1d.7 to group 14
[    4.620771] iommu: Adding device 0000:00:1e.0 to group 15
[    4.620860] iommu: Adding device 0000:00:1f.0 to group 16
[    4.620933] iommu: Adding device 0000:00:1f.2 to group 16
[    4.620994] iommu: Adding device 0000:01:03.0 to group 15
[    4.621054] iommu: Adding device 0000:01:04.0 to group 15
[    4.621114] iommu: Adding device 0000:01:04.2 to group 15
[    4.621175] iommu: Adding device 0000:01:04.4 to group 15
[    4.621235] iommu: Adding device 0000:01:04.6 to group 15
[    4.621331] iommu: Adding device 0000:02:00.0 to group 17
[    4.621411] iommu: Adding device 0000:02:00.1 to group 17
[    4.621483] iommu: Adding device 0000:03:00.0 to group 18
[    4.621557] iommu: Adding device 0000:04:00.0 to group 19
[    4.621631] iommu: Adding device 0000:04:00.1 to group 20
[    4.621726] iommu: Adding device 0000:07:00.0 to group 21
[    4.621805] iommu: Adding device 0000:07:00.1 to group 21
[    4.621894] iommu: Adding device 0000:3e:00.0 to group 22
[    4.621967] iommu: Adding device 0000:3e:00.1 to group 22
[    4.622073] iommu: Adding device 0000:3e:02.0 to group 23
[    4.622147] iommu: Adding device 0000:3e:02.1 to group 23
[    4.622220] iommu: Adding device 0000:3e:02.4 to group 23
[    4.622294] iommu: Adding device 0000:3e:02.5 to group 23
[    4.622399] iommu: Adding device 0000:3e:03.0 to group 24
[    4.622473] iommu: Adding device 0000:3e:03.1 to group 24
[    4.622546] iommu: Adding device 0000:3e:03.2 to group 24
[    4.622621] iommu: Adding device 0000:3e:03.4 to group 24
[    4.622726] iommu: Adding device 0000:3e:04.0 to group 25
[    4.622801] iommu: Adding device 0000:3e:04.1 to group 25
[    4.622875] iommu: Adding device 0000:3e:04.2 to group 25
[    4.622950] iommu: Adding device 0000:3e:04.3 to group 25
[    4.623056] iommu: Adding device 0000:3e:05.0 to group 26
[    4.623131] iommu: Adding device 0000:3e:05.1 to group 26
[    4.623215] iommu: Adding device 0000:3e:05.2 to group 26
[    4.623290] iommu: Adding device 0000:3e:05.3 to group 26
[    4.623397] iommu: Adding device 0000:3e:06.0 to group 27
[    4.623472] iommu: Adding device 0000:3e:06.1 to group 27
[    4.623548] iommu: Adding device 0000:3e:06.2 to group 27
[    4.623623] iommu: Adding device 0000:3e:06.3 to group 27
[    4.623711] iommu: Adding device 0000:3f:00.0 to group 28
[    4.623787] iommu: Adding device 0000:3f:00.1 to group 28
[    4.623892] iommu: Adding device 0000:3f:02.0 to group 29
[    4.623968] iommu: Adding device 0000:3f:02.1 to group 29
[    4.624044] iommu: Adding device 0000:3f:02.4 to group 29
[    4.624120] iommu: Adding device 0000:3f:02.5 to group 29
[    4.624225] iommu: Adding device 0000:3f:03.0 to group 30
[    4.624302] iommu: Adding device 0000:3f:03.1 to group 30
[    4.624377] iommu: Adding device 0000:3f:03.2 to group 30
[    4.624454] iommu: Adding device 0000:3f:03.4 to group 30
[    4.624559] iommu: Adding device 0000:3f:04.0 to group 31
[    4.624636] iommu: Adding device 0000:3f:04.1 to group 31
[    4.624712] iommu: Adding device 0000:3f:04.2 to group 31
[    4.624788] iommu: Adding device 0000:3f:04.3 to group 31
[    4.624893] iommu: Adding device 0000:3f:05.0 to group 32
[    4.624970] iommu: Adding device 0000:3f:05.1 to group 32
[    4.625046] iommu: Adding device 0000:3f:05.2 to group 32
[    4.625123] iommu: Adding device 0000:3f:05.3 to group 32
[    4.625228] iommu: Adding device 0000:3f:06.0 to group 33
[    4.625307] iommu: Adding device 0000:3f:06.1 to group 33
[    4.625384] iommu: Adding device 0000:3f:06.2 to group 33
[    4.625462] iommu: Adding device 0000:3f:06.3 to group 33
[    4.628717] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    4.628925] audit: initializing netlink subsys (disabled)
[    4.629005] audit: type=2000 audit(1468389348.496:1): initialized
[    4.629776] Initialise system trusted keyring
[    4.630052] workingset: timestamp_bits=37 max_order=23 bucket_order=0
[    4.630152] zbud: loaded
[    4.678208] Key type asymmetric registered
[    4.678268] Asymmetric key parser 'x509' registered
[    4.678373] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    4.678517] io scheduler noop registered
[    4.678575] io scheduler deadline registered
[    4.678670] io scheduler cfq registered (default)
[    4.679388] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    4.679458] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    4.679546] intel_idle: MWAIT substates: 0x1120
[    4.679548] intel_idle: v0.4.1 model 0x1A
[    4.680471] intel_idle: lapic_timer_reliable_states 0x2
[    4.680528] ERST: Failed to get Error Log Address Range.
[    4.680720] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    4.680908] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.701393] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    4.722095] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    4.723023] Linux agpgart interface v0.103
[    4.723321] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    4.723380] AMD IOMMUv2 functionality not available on this system
[    4.726100] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[    4.731569] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.731644] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.732228] mousedev: PS/2 mouse device common for all mice
[    4.732363] rtc_cmos 00:04: RTC can wake from S4
[    4.732651] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    4.732739] rtc_cmos 00:04: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    4.732861] ledtrig-cpu: registered to indicate activity on CPUs
[    4.738038] NET: Registered protocol family 10
[    4.738555] mip6: Mobile IPv6
[    4.738614] NET: Registered protocol family 17
[    4.738676] mpls_gso: MPLS GSO support
[    4.739612] microcode: CPU0 sig=0x106a5, pf=0x1, revision=0x19
[    4.739679] microcode: CPU1 sig=0x106a5, pf=0x1, revision=0x19
[    4.739777] microcode: CPU2 sig=0x106a5, pf=0x1, revision=0x19
[    4.739921] microcode: CPU3 sig=0x106a5, pf=0x1, revision=0x19
[    4.740037] microcode: CPU4 sig=0x106a5, pf=0x1, revision=0x19
[    4.740142] microcode: CPU5 sig=0x106a5, pf=0x1, revision=0x19
[    4.740258] microcode: CPU6 sig=0x106a5, pf=0x1, revision=0x19
[    4.740395] microcode: CPU7 sig=0x106a5, pf=0x1, revision=0x19
[    4.740515] microcode: CPU8 sig=0x106a5, pf=0x1, revision=0x19
[    4.740589] microcode: CPU9 sig=0x106a5, pf=0x1, revision=0x19
[    4.740691] microcode: CPU10 sig=0x106a5, pf=0x1, revision=0x19
[    4.740827] microcode: CPU11 sig=0x106a5, pf=0x1, revision=0x19
[    4.740950] microcode: CPU12 sig=0x106a5, pf=0x1, revision=0x19
[    4.741085] microcode: CPU13 sig=0x106a5, pf=0x1, revision=0x19
[    4.741199] microcode: CPU14 sig=0x106a5, pf=0x1, revision=0x19
[    4.741305] microcode: CPU15 sig=0x106a5, pf=0x1, revision=0x19
[    4.741464] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    4.742050] registered taskstats version 1
[    4.742124] Loading compiled-in X.509 certificates
[    4.742230] zswap: loaded using pool lzo/zbud
[    4.744450] rtc_cmos 00:04: setting system clock to 2016-07-13 05:55:49 UTC (1468389349)
[    4.744628] PM: Hibernation image not present or could not be loaded.
[    4.748362] Freeing unused kernel memory: 1332K (ffffffff81b12000 - ffffffff81c5f000)
[    4.748481] Write protecting the kernel read-only data: 10240k
[    4.751438] Freeing unused kernel memory: 200K (ffff8800015ce000 - ffff880001600000)
[    4.758016] Freeing unused kernel memory: 1428K (ffff88000189b000 - ffff880001a00000)
[    4.771493] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    4.771522] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.792978] random: systemd-udevd urandom read with 2 bits of entropy available
[    4.852475] fjes: module verification failed: signature and/or required key missing - tainting kernel
[    4.853093] FUJITSU Extended Socket Network Device Driver - version 1.0 - Copyright (c) 2015 FUJITSU LIMITED
[    4.855436] thermal LNXTHERM:00: registered as thermal_zone0
[    4.855501] ACPI: Thermal Zone [THM0] (8 C)
[    4.856500] Floppy drive(s): fd0 is 1.44M
[    4.861402] SCSI subsystem initialized
[    4.861537] bnx2: QLogic bnx2 Gigabit Ethernet Driver v2.2.6 (January 29, 2014)
[    4.861815] pps_core: LinuxPPS API ver. 1 registered
[    4.861877] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.862555] bnx2 0000:02:00.0 eth0: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem f8000000, IRQ 25, node addr 00:26:55:1a:e8:90
[    4.862922] PTP clock support registered
[    4.863643] bnx2 0000:02:00.1 eth1: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem f6000000, IRQ 26, node addr 00:26:55:1a:e8:92
[    4.864128] HP HPSA Driver (v 3.4.14-0)
[    4.864207] hpsa 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    4.864407] hpsa 0000:03:00.0: MSI-X capable controller
[    4.864689] hpsa 0000:03:00.0: Logical aborts not supported
[    4.864754] hpsa 0000:03:00.0: HP SSD Smart Path aborts not supported
[    4.868976] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    4.869047] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.869422] e1000e 0000:04:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    4.874380] ACPI: bus type USB registered
[    4.874495] usbcore: registered new interface driver usbfs
[    4.874569] usbcore: registered new interface driver hub
[    4.874685] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 8.07.00.33-k.
[    4.874719] usbcore: registered new device driver usb
[    4.875022] qla2xxx [0000:07:00.0]-001d: : Found an ISP2432 irq 46 iobase 0xffffc900035ce000.
[    4.875339] qla2xxx [0000:07:00.0]-0034:0: MSI-X: Unsupported ISP 2432 SSVID/SSDID (0x103C,0x7041).
[    4.875763] libata version 3.00 loaded.
[    4.876627] ata_piix 0000:00:1f.2: version 2.13
[    4.876845] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    4.877116] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.877969] ehci-pci: EHCI PCI platform driver
[    4.878346] uhci_hcd: USB Universal Host Controller Interface driver
[    4.895193] scsi host1: hpsa
[    4.906454] hpsa 0000:03:00.0: scsi 1:0:0:0: added RAID              HP       P410i            controller SSDSmartPathCap- En- Exp=1
[    4.906547] hpsa 0000:03:00.0: scsi 1:0:1:0: masked Direct-Access     HP       DH072ABAA6       PHYS DRV SSDSmartPathCap- En- Exp=0
[    4.906634] hpsa 0000:03:00.0: scsi 1:0:2:0: masked Direct-Access     HP       DH072ABAA6       PHYS DRV SSDSmartPathCap- En- Exp=0
[    4.906723] hpsa 0000:03:00.0: scsi 1:0:3:0: masked Direct-Access     HP       DH072ABAA6       PHYS DRV SSDSmartPathCap- En- Exp=0
[    4.906816] hpsa 0000:03:00.0: scsi 1:0:4:0: masked Direct-Access     HP       DH072ABAA6       PHYS DRV SSDSmartPathCap- En- Exp=0
[    4.906907] hpsa 0000:03:00.0: scsi 1:0:5:0: masked Enclosure         PMCSIERA  SRC 8x6G        enclosure SSDSmartPathCap- En- Exp=0
[    4.906999] hpsa 0000:03:00.0: scsi 1:1:0:0: added Direct-Access     HP       LOGICAL VOLUME   RAID-1(+0) SSDSmartPathCap- En- Exp=1
[    4.908244] scsi 1:0:0:0: RAID              HP       P410i            6.64 PQ: 0 ANSI: 5
[    4.951155] bnx2 0000:02:00.0 enp2s0f0: renamed from eth0
[    4.972354] bnx2 0000:02:00.1 enp2s0f1: renamed from eth1
[    4.992396] scsi 1:1:0:0: Direct-Access     HP       LOGICAL VOLUME   6.64 PQ: 0 ANSI: 5
[    5.032489] scsi host2: ata_piix
[    5.033081] scsi host3: ata_piix
[    5.033214] ata1: SATA max UDMA/133 cmd 0x1080 ctl 0x1088 bmdma 0x10a0 irq 17
[    5.033279] ata2: SATA max UDMA/133 cmd 0x1090 ctl 0x1098 bmdma 0x10a8 irq 17
[    5.033680] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    5.033749] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    5.033840] ehci-pci 0000:00:1d.7: debug port 1
[    5.037811] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    5.037827] ehci-pci 0000:00:1d.7: irq 20, io mem 0xf5df0000
[    5.040430] e1000e 0000:04:00.0 eth0: (PCI Express:2.5GT/s:Width x4) 00:1b:78:59:c4:e6
[    5.040513] e1000e 0000:04:00.0 eth0: Intel(R) PRO/1000 Network Connection
[    5.040649] e1000e 0000:04:00.0 eth0: MAC: 0, PHY: 4, PBA No: D51930-003
[    5.040892] e1000e 0000:04:00.1: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    5.047502] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    5.047624] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    5.047685] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.047761] usb usb1: Product: EHCI Host Controller
[    5.047818] usb usb1: Manufacturer: Linux 4.6.0 ehci_hcd
[    5.047876] usb usb1: SerialNumber: 0000:00:1d.7
[    5.048274] hub 1-0:1.0: USB hub found
[    5.048341] hub 1-0:1.0: 8 ports detected
[    5.048816] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    5.048884] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    5.048968] uhci_hcd 0000:00:1d.0: detected 2 ports
[    5.049046] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001000
[    5.049184] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    5.049247] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.049325] usb usb2: Product: UHCI Host Controller
[    5.049387] usb usb2: Manufacturer: Linux 4.6.0 uhci_hcd
[    5.049447] usb usb2: SerialNumber: 0000:00:1d.0
[    5.049768] hub 2-0:1.0: USB hub found
[    5.049834] hub 2-0:1.0: 2 ports detected
[    5.050201] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    5.050269] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    5.050352] uhci_hcd 0000:00:1d.1: detected 2 ports
[    5.050439] uhci_hcd 0000:00:1d.1: irq 23, io base 0x00001020
[    5.050579] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    5.050643] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.050722] usb usb3: Product: UHCI Host Controller
[    5.050781] usb usb3: Manufacturer: Linux 4.6.0 uhci_hcd
[    5.050841] usb usb3: SerialNumber: 0000:00:1d.1
[    5.051136] hub 3-0:1.0: USB hub found
[    5.051291] hub 3-0:1.0: 2 ports detected
[    5.051698] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    5.051765] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    5.051848] uhci_hcd 0000:00:1d.2: detected 2 ports
[    5.051933] uhci_hcd 0000:00:1d.2: irq 22, io base 0x00001040
[    5.052077] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    5.052143] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.052223] usb usb4: Product: UHCI Host Controller
[    5.052282] usb usb4: Manufacturer: Linux 4.6.0 uhci_hcd
[    5.052340] usb usb4: SerialNumber: 0000:00:1d.2
[    5.052686] hub 4-0:1.0: USB hub found
[    5.052752] hub 4-0:1.0: 2 ports detected
[    5.053065] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    5.053131] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    5.053211] uhci_hcd 0000:00:1d.3: detected 2 ports
[    5.053286] uhci_hcd 0000:00:1d.3: irq 23, io base 0x00001060
[    5.056900] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    5.056962] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.057037] usb usb5: Product: UHCI Host Controller
[    5.057094] usb usb5: Manufacturer: Linux 4.6.0 uhci_hcd
[    5.057152] usb usb5: SerialNumber: 0000:00:1d.3
[    5.057542] hub 5-0:1.0: USB hub found
[    5.057607] hub 5-0:1.0: 2 ports detected
[    5.057868] uhci_hcd 0000:01:04.4: UHCI Host Controller
[    5.057933] uhci_hcd 0000:01:04.4: new USB bus registered, assigned bus number 6
[    5.058019] uhci_hcd 0000:01:04.4: detected 8 ports
[    5.058076] uhci_hcd 0000:01:04.4: port count misdetected? forcing to 2 ports
[    5.058879] uhci_hcd 0000:01:04.4: irq 22, io base 0x00003800
[    5.059190] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    5.059258] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.059333] usb usb6: Product: UHCI Host Controller
[    5.059390] usb usb6: Manufacturer: Linux 4.6.0 uhci_hcd
[    5.059448] usb usb6: SerialNumber: 0000:01:04.4
[    5.059820] hub 6-0:1.0: USB hub found
[    5.059886] hub 6-0:1.0: 2 ports detected
[    5.216147] e1000e 0000:04:00.1 eth1: (PCI Express:2.5GT/s:Width x4) 00:1b:78:59:c4:e7
[    5.216228] e1000e 0000:04:00.1 eth1: Intel(R) PRO/1000 Network Connection
[    5.216365] e1000e 0000:04:00.1 eth1: MAC: 0, PHY: 4, PBA No: D51930-003
[    5.220638] e1000e 0000:04:00.1 ens1f1: renamed from eth1
[    5.247769] scsi host0: qla2xxx
[    5.247814] e1000e 0000:04:00.0 ens1f0: renamed from eth0
[    5.248939] qla2xxx [0000:07:00.0]-00fb:0: QLogic HPAE312A - PCI-Express Dual Port 4Gb Fibre Channel HBA.
[    5.249028] qla2xxx [0000:07:00.0]-00fc:0: ISP2432: PCIe (2.5GT/s x4) @ 0000:07:00.0 hdma+ host#=0 fw=8.03.00 (9496).
[    5.249238] qla2xxx [0000:07:00.1]-001d: : Found an ISP2432 irq 49 iobase 0xffffc900035c8000.
[    5.249821] qla2xxx [0000:07:00.1]-0034:4: MSI-X: Unsupported ISP 2432 SSVID/SSDID (0x103C,0x7041).
[    5.371350] usb 6-1: new full-speed USB device number 2 using uhci_hcd
[    5.518884] usb 6-1: New USB device found, idVendor=03f0, idProduct=1027
[    5.518948] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.519010] usb 6-1: Product: Virtual Keyboard
[    5.519066] usb 6-1: Manufacturer: HP
[    5.537069] hidraw: raw HID events driver (C) Jiri Kosina
[    5.552823] usbcore: registered new interface driver usbhid
[    5.552884] usbhid: USB HID core driver
[    5.560611] input: HP Virtual Keyboard as /devices/pci0000:00/0000:00:1e.0/0000:01:04.4/usb6/6-1/6-1:1.0/0003:03F0:1027.0001/input/input3
[    5.615726] hid-generic 0003:03F0:1027.0001: input,hidraw0: USB HID v1.01 Keyboard [HP Virtual Keyboard] on usb-0000:01:04.4-1/input0
[    5.615970] input: HP Virtual Keyboard as /devices/pci0000:00/0000:00:1e.0/0000:01:04.4/usb6/6-1/6-1:1.1/0003:03F0:1027.0002/input/input4
[    5.616389] hid-generic 0003:03F0:1027.0002: input,hidraw1: USB HID v1.01 Mouse [HP Virtual Keyboard] on usb-0000:01:04.4-1/input1
[    5.619582] scsi host4: qla2xxx
[    5.620597] qla2xxx [0000:07:00.1]-00fb:4: QLogic HPAE312A - PCI-Express Dual Port 4Gb Fibre Channel HBA.
[    5.620694] qla2xxx [0000:07:00.1]-00fc:4: ISP2432: PCIe (2.5GT/s x4) @ 0000:07:00.1 hdma+ host#=4 fw=8.03.00 (9496).
[    5.627705] tsc: Refined TSC clocksource calibration: 2533.422 MHz
[    5.627769] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x24848ea16a3, max_idle_ns: 440795313972 ns
[    5.658565] ata2.00: SATA link down (SStatus 4 SControl 300)
[    5.658639] ata2.01: SATA link down (SStatus 4 SControl 300)
[    5.803427] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.803500] ata1.01: SATA link down (SStatus 4 SControl 300)
[    5.803568] ata1.01: link offline, clearing class 3 to NONE
[    5.806115] ata1.00: ATAPI: DV-28S-V, C.0F, max UDMA/100
[    5.839514] ata1.00: configured for UDMA/100
[    5.860415] scsi: waiting for bus probes to complete ...
[    6.627817] clocksource: Switched to clocksource tsc
[    7.875610] floppy0: no floppy controllers found
[    7.875678] work still pending
[   10.658831] scsi 2:0:0:0: CD-ROM            TEAC     DV-28S-V         C.0F PQ: 0 ANSI: 5
[   10.699905] sd 1:1:0:0: [sda] 286615665 512-byte logical blocks: (147 GB/137 GiB)
[   10.700281] sd 1:1:0:0: [sda] Write Protect is off
[   10.700358] sd 1:1:0:0: [sda] Mode Sense: 6b 00 00 08
[   10.700541] sd 1:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   10.709053]  sda: sda1 sda2 < sda5 >
[   10.710056] sd 1:1:0:0: [sda] Attached SCSI disk
[   10.771358] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[   10.771436] cdrom: Uniform CD-ROM driver Revision: 3.20
[   10.772134] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   11.034492] PM: Starting manual resume from disk
[   11.034568] PM: Hibernation image partition 8:5 present
[   11.034570] PM: Looking for hibernation image.
[   11.034924] PM: Image not found (code -22)
[   11.034926] PM: Hibernation image not present or could not be loaded.
[   11.184788] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   11.993494] systemd[1]: systemd 230 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   11.994062] systemd[1]: Detected architecture x86-64.
[   12.000160] systemd[1]: Set hostname to <dl360g6>.
[   12.332842] systemd[1]: Listening on udev Control Socket.
[   12.333277] systemd[1]: Listening on fsck to fsckd communication Socket.
[   12.333656] systemd[1]: Listening on Journal Socket (/dev/log).
[   12.334031] systemd[1]: Listening on Journal Socket.
[   12.334493] systemd[1]: Created slice User and Session Slice.
[   12.334836] systemd[1]: Reached target Encrypted Volumes.
[   12.335212] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   12.335738] systemd[1]: Created slice System Slice.
[   12.355896] systemd[1]: Starting Load Kernel Modules...
[   12.368092] systemd[1]: Starting Set the console keyboard layout...
[   12.368968] systemd[1]: Starting Remount Root and Kernel File Systems...
[   12.369265] systemd[1]: Reached target Slices.
[   12.369698] systemd[1]: Listening on Journal Audit Socket.
[   12.370072] systemd[1]: Listening on Syslog Socket.
[   12.371001] systemd[1]: Mounting POSIX Message Queue File System...
[   12.371407] systemd[1]: Created slice system-getty.slice.
[   12.371951] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   12.373499] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[   12.373863] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   12.374248] systemd[1]: Reached target Remote File Systems (Pre).
[   12.374592] systemd[1]: Reached target Remote File Systems.
[   12.375536] systemd[1]: Mounting Huge Pages File System...
[   12.375966] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   12.376369] systemd[1]: Listening on udev Kernel Socket.
[   12.377304] systemd[1]: Starting Journal Service...
[   12.377585] systemd[1]: Reached target Paths.
[   12.378523] systemd[1]: Mounting Debug File System...
[   12.380639] systemd[1]: Started Load Kernel Modules.
[   12.382049] systemd[1]: Starting Apply Kernel Variables...
[   12.398940] systemd[1]: Started Create list of required static device nodes for the current kernel.
[   12.400127] systemd[1]: Starting Create Static Device Nodes in /dev...
[   12.431240] random: nonblocking pool is initialized
[   12.501619] systemd[1]: Started Apply Kernel Variables.
[   12.541706] systemd[1]: Started Journal Service.
[   12.593777] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   12.714237] systemd-journald[1106]: Received request to flush runtime journal from PID 1
[   13.203149] EDAC MC: Ver: 3.0.0
[   13.276080] ACPI Warning: SystemIO range 0x0000000000000928-0x000000000000092F conflicts with OpRegion 0x0000000000000920-0x000000000000092F (\SGPE) (20160108/utaddress-255)
[   13.276259] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   13.276378] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   13.294896] EDAC MC1: Giving out device to module i7core_edac.c controller i7 core #1: DEV 0000:3e:03.0 (POLLED)
[   13.295018] EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:3e:03.0 (POLLED)
[   13.295402] EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:3f:03.0 (POLLED)
[   13.295514] EDAC PCI1: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:3f:03.0 (POLLED)
[   13.295607] EDAC i7core: Driver loaded, 2 memory controller(s) found.
[   13.328304] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1600 MHz, 2533 MHz
[   13.328402] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.328678] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.329062] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.329409] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.329744] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.330086] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.330418] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.330785] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.331109] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.331493] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.331877] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.332230] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.332617] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.332980] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.333325] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.333666] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[   13.398081] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   13.419153] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[   13.419234] ACPI: Power Button [PWRF]
[   13.460100] Floppy drive(s): fd0 is 1.44M
[   13.466421] power_meter ACPI000D:00: Found ACPI power meter.
[   13.466502] power_meter ACPI000D:00: Ignoring unsafe software power cap!
[   13.479515] ipmi message handler version 39.2
[   13.545126] hpwdt 0000:01:04.0: HPE Watchdog Timer Driver: NMI decoding initialized, allow kernel dump: ON (default = 1/ON)
[   13.545266] hpwdt 0000:01:04.0: HPE Watchdog Timer Driver: 1.3.3, timer margin: 30 seconds (nowayout=0).
[   13.630184] iTCO_vendor_support: vendor-support=0
[   13.671610] scsi 1:0:0:0: Attached scsi generic sg0 type 12
[   13.671729] sd 1:1:0:0: Attached scsi generic sg1 type 0
[   13.671820] sr 2:0:0:0: Attached scsi generic sg2 type 5
[   13.683350] input: PC Speaker as /devices/platform/pcspkr/input/input6
[   13.859533] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   13.859628] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   13.875828] ipmi_si IPI0001:00: ipmi_si: probing via ACPI
[   13.875918] ipmi_si IPI0001:00: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
[   13.875977] ipmi_si: Adding ACPI-specified kcs state machine
[   13.876085] IPMI System Interface driver.
[   13.876161] ipmi_si 0000:01:04.6: probing via PCI
[   13.876286] ipmi_si 0000:01:04.6: [mem 0xf5ef0000-0xf5ef00ff] regsize 1 spacing 1 irq 21
[   13.876361] ipmi_si: Adding PCI-specified kcs state machine
[   13.876475] ipmi_si: probing via SMBIOS
[   13.876528] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   13.876584] ipmi_si: Adding SMBIOS-specified kcs state machine duplicate interface
[   13.876704] ipmi_si: probing via SPMI
[   13.876757] ipmi_si: SPMI: io 0xca2 regsize 2 spacing 2 irq 0
[   13.876813] ipmi_si: Adding SPMI-specified kcs state machine duplicate interface
[   13.876918] ipmi_si: Trying PCI-specified kcs state machine at mem address 0xf5ef0000, slave address 0x0, irq 21
[   13.956383] [drm] Initialized drm 1.1.0 20060810
[   14.327861] ipmi_si 0000:01:04.6: Using irq 21
[   14.350313] ipmi_si 0000:01:04.6: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x11)
[   14.350402] ipmi_si 0000:01:04.6: IPMI kcs interface initialized
[   14.395427] Error: Driver 'pcspkr' is already registered, aborting...
[   14.519788] [drm] radeon kernel modesetting enabled.
[   14.596389] CRAT table not found
[   14.596449] Finished initializing topology ret=0
[   14.596645] kfd kfd: Initialized module
[   14.598795] [drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[   14.598892] [drm] register mmio base: 0xF5FF0000
[   14.598964] [drm] register mmio size: 65536
[   14.599091] radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
[   14.599167] radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[   14.599250] [drm] Detected VRAM RAM=128M, BAR=128M
[   14.599306] [drm] RAM width 16bits DDR
[   14.599428] [TTM] Zone  kernel: Available graphics memory: 12373260 kiB
[   14.599487] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   14.599544] [TTM] Initializing pool allocator
[   14.599603] [TTM] Initializing DMA pool allocator
[   14.599680] [drm] radeon: 64M of VRAM memory ready
[   14.599744] [drm] radeon: 512M of GTT memory ready.
[   14.599831] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   14.620864] [drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
[   14.620955] radeon 0000:01:03.0: WB disabled
[   14.621011] radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800da2c9000
[   14.621090] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   14.621148] [drm] Driver supports precise vblank timestamp query.
[   14.621215] [drm] radeon: irq initialized.
[   14.621283] [drm] Loading R100 Microcode
[   14.641490] [drm] radeon: ring at 0x00000000C8001000
[   14.641571] [drm] ring test succeeded in 1 usecs
[   14.773520] Adding 25153532k swap on /dev/sda5.  Priority:-1 extents:1 across:25153532k FS
[   14.862823] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[   15.139926] [drm] ib test succeeded in 0 usecs
[   15.140361] [drm] No TV DAC info found in BIOS
[   15.140451] [drm] Radeon Display Connectors
[   15.140505] [drm] Connector 0:
[   15.140556] [drm]   VGA-1
[   15.140607] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[   15.140666] [drm]   Encoders:
[   15.140717] [drm]     CRT1: INTERNAL_DAC1
[   15.140770] [drm] Connector 1:
[   15.140821] [drm]   VGA-2
[   15.140891] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
[   15.140947] [drm]   Encoders:
[   15.140997] [drm]     CRT2: INTERNAL_DAC2
[   15.215945] [drm] fb mappable at 0xE8040000
[   15.216001] [drm] vram apper at 0xE8000000
[   15.216056] [drm] size 1310720
[   15.216107] [drm] fb depth is 8
[   15.216158] [drm]    pitch is 1280
[   15.216407] fbcon: radeondrmfb (fb0) is primary device
[   15.381434] Console: switching to colour frame buffer device 160x64
[   15.394964] radeon 0000:01:03.0: fb0: radeondrmfb frame buffer device
[   15.404175] [drm] Initialized radeon 2.43.0 20080528 for 0000:01:03.0 on minor 0
[   15.420112] CE: hpet increased min_delta_ns to 20115 nsec
[   15.917861] bnx2 0000:02:00.0 enp2s0f0: using MSIX
[   15.918074] IPv6: ADDRCONF(NETDEV_UP): enp2s0f0: link is not ready
[   16.260585] systemd[1]: apt-daily.timer: Adding 7min 36.807444s random time.
[   16.483942] floppy0: no floppy controllers found
[   17.513274] bnx2 0000:02:00.0 enp2s0f0: NIC Copper Link is Up, 100 Mbps full duplex
[   17.513388] , receive & transmit flow control ON
[   17.513572] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f0: link becomes ready
[   24.212833] systemd[1]: apt-daily.timer: Adding 8h 51min 24.767715s random time.
[   24.342465] systemd[1]: apt-daily.timer: Adding 8h 48min 7.565788s random time.
[   26.412465] qla2xxx [0000:07:00.0]-8038:0: Cable is unplugged...
[   26.780480] qla2xxx [0000:07:00.1]-8038:4: Cable is unplugged...

-- 
Meelis Roos (mroos@linux.ee)
