From: "G. Richard Bellamy" <rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org>
Subject: Re: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:14.0
	address=0x000000fdf9103300 flags=0x0600]
Date: Wed, 14 Oct 2015 09:05:05 -0700
Message-ID: <CADw2B2MzAMhNX5x9kZ5MN0mAh24ttDu=23EGVLy2aq6Paik4tQ@mail.gmail.com>
References: <CADw2B2Mzo2DbMMiyTVjBGVc4-f6Koa6sWQjoLmfX7NZ3B4+saA@mail.gmail.com>
	<20151014090649.GI27420@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5725101990678900342=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151014090649.GI27420-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

--===============5725101990678900342==
Content-Type: multipart/alternative; boundary=001a11c3e9accae47a052212b957

--001a11c3e9accae47a052212b957
Content-Type: text/plain; charset=UTF-8

When I have "iommu=1 iommu=pt amd_iommu_dump=1" on my Kernel command line,
the messages spam the log so much neither dmesg nor the journal can keep up.

In the journal, I see "systemd-journal[427]: Missed 1131 kernel messages"
and the dmesg buffer is full of the INVALID_DEVICE_REQUEST messages.

I then tried just "amd_iommu_dump=1" (without the other iommu parameters).
That produced the following (which doesn't seem to have the dump you asked
for). If it doesn't have what you asked for, what should I do next to make
sure I can get it to you?

-- Logs begin at Fri 2014-04-04 16:19:07 PDT, end at Wed 2015-10-14
08:56:58 PDT. --
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys cpuset
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys cpu
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys cpuacct
Oct 14 08:55:02 eanna kernel: Linux version 4.2.2-1-ARCH
(builduser@tobias) (gcc version 5.2.0 (GCC) ) #1 SMP PREEMPT Tue Sep
29 22:21:33 CEST 2015
Oct 14 08:55:02 eanna kernel: Command line:
BOOT_IMAGE=/__system/ROOT/boot/vmlinuz-linux
root=UUID=06acfd0f-314d-457f-ba00-f96bf5b94a02 rw
rootflags=subvol=__system/ROOT quiet acpi_osi=Linux amd_iommu_dump=1
transparent_hugepage=never
Oct 14 08:55:02 eanna kernel: tseg: 00bff00000
Oct 14 08:55:02 eanna kernel: x86/fpu: xstate_offset[2]: 0240,
xstate_sizes[2]: 0100
Oct 14 08:55:02 eanna kernel: x86/fpu: Supporting XSAVE feature 0x01:
'x87 floating point registers'
Oct 14 08:55:02 eanna kernel: x86/fpu: Supporting XSAVE feature 0x02:
'SSE registers'
Oct 14 08:55:02 eanna kernel: x86/fpu: Supporting XSAVE feature 0x04:
'AVX registers'
Oct 14 08:55:02 eanna kernel: x86/fpu: Enabled xstate features 0x7,
context size is 0x340 bytes, using 'standard' format.
Oct 14 08:55:02 eanna kernel: x86/fpu: Using 'lazy' FPU context switches.
Oct 14 08:55:02 eanna kernel: e820: BIOS-provided physical RAM map:
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x0000000000000000-0x00000000000947ff] usable
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x0000000000094800-0x000000000009ffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x00000000000e6000-0x00000000000fffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x0000000000100000-0x00000000bfe7ffff] usable
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x00000000bfe8e000-0x00000000bfe8ffff] type 9
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x00000000bfe90000-0x00000000bfeb3fff] ACPI data
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x00000000bfeb4000-0x00000000bfedffff] ACPI NVS
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x00000000bfee0000-0x00000000bfffffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x00000000e0000000-0x00000000efffffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x00000000ffe00000-0x00000000ffffffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem
0x0000000100000000-0x000000103effffff] usable
Oct 14 08:55:02 eanna kernel: NX (Execute Disable) protection: active
Oct 14 08:55:02 eanna kernel: SMBIOS 2.6 present.
Oct 14 08:55:02 eanna kernel: DMI: Supermicro H8DG6/H8DGi/H8DG6/H8DGi,
BIOS 3.5        11/25/2013
Oct 14 08:55:02 eanna kernel: e820: update [mem 0x00000000-0x00000fff]
usable ==> reserved
Oct 14 08:55:02 eanna kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Oct 14 08:55:02 eanna kernel: AGP: No AGP bridge found
Oct 14 08:55:02 eanna kernel: e820: last_pfn = 0x103f000 max_arch_pfn
= 0x400000000
Oct 14 08:55:02 eanna kernel: MTRR default type: uncachable
Oct 14 08:55:02 eanna kernel: MTRR fixed ranges enabled:
Oct 14 08:55:02 eanna kernel:   00000-9FFFF write-back
Oct 14 08:55:02 eanna kernel:   A0000-EFFFF uncachable
Oct 14 08:55:02 eanna kernel:   F0000-FFFFF write-protect
Oct 14 08:55:02 eanna kernel: MTRR variable ranges enabled:
Oct 14 08:55:02 eanna kernel:   0 base 000000000000 mask FFFF80000000 write-back
Oct 14 08:55:02 eanna kernel:   1 base 000080000000 mask FFFFC0000000 write-back
Oct 14 08:55:02 eanna kernel:   2 disabled
Oct 14 08:55:02 eanna kernel:   3 disabled
Oct 14 08:55:02 eanna kernel:   4 disabled
Oct 14 08:55:02 eanna kernel:   5 disabled
Oct 14 08:55:02 eanna kernel:   6 disabled
Oct 14 08:55:02 eanna kernel:   7 disabled
Oct 14 08:55:02 eanna kernel: TOM2: 000000103f000000 aka 66544M
Oct 14 08:55:02 eanna kernel: x86/PAT: Configuration [0-7]: WB  WC
UC- UC  WB  WC  UC- WT
Oct 14 08:55:02 eanna kernel: e820: update [mem 0xc0000000-0xffffffff]
usable ==> reserved
Oct 14 08:55:02 eanna kernel: e820: last_pfn = 0xbfe80 max_arch_pfn =
0x400000000
Oct 14 08:55:02 eanna kernel: found SMP MP-table at [mem
0x000ff780-0x000ff78f] mapped at [ffff8800000ff780]
Oct 14 08:55:02 eanna kernel: Scanning 1 areas for low memory corruption
Oct 14 08:55:02 eanna kernel: Base memory trampoline at
[ffff88000008e000] 8e000 size 24576
Oct 14 08:55:02 eanna kernel: Using GB pages for direct mapping
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem 0x00000000-0x000fffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x00000000-0x000fffff] page 4k
Oct 14 08:55:02 eanna kernel: BRK [0x01b36000, 0x01b36fff] PGTABLE
Oct 14 08:55:02 eanna kernel: BRK [0x01b37000, 0x01b37fff] PGTABLE
Oct 14 08:55:02 eanna kernel: BRK [0x01b38000, 0x01b38fff] PGTABLE
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem
0x103ee00000-0x103effffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x103ee00000-0x103effffff] page 2M
Oct 14 08:55:02 eanna kernel: BRK [0x01b39000, 0x01b39fff] PGTABLE
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem
0x1020000000-0x103edfffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x1020000000-0x103edfffff] page 2M
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem
0x1000000000-0x101fffffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x1000000000-0x101fffffff] page 2M
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem 0x00100000-0xbfe7ffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x00100000-0x001fffff] page 4k
Oct 14 08:55:02 eanna kernel:  [mem 0x00200000-0x3fffffff] page 2M
Oct 14 08:55:02 eanna kernel:  [mem 0x40000000-0x7fffffff] page 1G
Oct 14 08:55:02 eanna kernel:  [mem 0x80000000-0xbfdfffff] page 2M
Oct 14 08:55:02 eanna kernel:  [mem 0xbfe00000-0xbfe7ffff] page 4k
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem 0x100000000-0xfffffffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x100000000-0xfffffffff] page 1G
Oct 14 08:55:02 eanna kernel: RAMDISK: [mem 0x377de000-0x37be6fff]
Oct 14 08:55:02 eanna kernel: ACPI: Early table checksum verification disabled
Oct 14 08:55:02 eanna kernel: ACPI: RSDP 0x00000000000FA650 000024 (v02 ACPIAM)
Oct 14 08:55:02 eanna kernel: ACPI: XSDT 0x00000000BFE90100 00008C
(v01 SMCI            20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: FACP 0x00000000BFE90290 0000F4
(v04 112513 FACP1100 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI BIOS Warning (bug): 32/64X length
mismatch in FADT/Gpe0Block: 64/32 (20150619/tbfadt-623)
Oct 14 08:55:02 eanna kernel: ACPI: DSDT 0x00000000BFE906C0 006ACE
(v02 1BC11  1BC11000 00000000 INTL 20051117)
Oct 14 08:55:02 eanna kernel: ACPI: FACS 0x00000000BFEB4000 000040
Oct 14 08:55:02 eanna kernel: ACPI: FACS 0x00000000BFEB4000 000040
Oct 14 08:55:02 eanna kernel: ACPI: APIC 0x00000000BFE90390 000170
(v02 112513 APIC1100 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: MCFG 0x00000000BFE90500 00003C
(v01 112513 OEMMCFG  20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: OEMB 0x00000000BFEB4040 0000BC
(v01 112513 OEMB1100 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: HPET 0x00000000BFE9A6C0 000038
(v01 112513 OEMHPET  20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: IVRS 0x00000000BFE9A700 000100
(v01 AMD    RD890S   00202031 AMD  00000000)
Oct 14 08:55:02 eanna kernel: ACPI: SRAT 0x00000000BFE9A800 000250
(v02 AMD    AGESA    00000001 AMD  00000001)
Oct 14 08:55:02 eanna kernel: ACPI: SLIT 0x00000000BFE9AA50 00003C
(v01 AMD    AGESA    00000001 AMD  00000001)
Oct 14 08:55:02 eanna kernel: ACPI: SSDT 0x00000000BFE9AA90 0044F4
(v01 A M I  POWERNOW 00000001 AMD  00000001)
Oct 14 08:55:02 eanna kernel: ACPI: EINJ 0x00000000BFE9EF90 000130
(v01 AMIER  AMI_EINJ 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: BERT 0x00000000BFE9F120 000030
(v01 AMIER  AMI_BERT 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: ERST 0x00000000BFE9F150 000210
(v01 AMIER  AMI_ERST 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: HEST 0x00000000BFE9F360 0000A8
(v01 AMIER  ABC_HEST 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: Local APIC address 0xfee00000
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -> APIC 0x20 -> Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -> APIC 0x21 -> Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -> APIC 0x22 -> Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -> APIC 0x23 -> Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -> APIC 0x24 -> Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -> APIC 0x25 -> Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -> APIC 0x26 -> Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -> APIC 0x27 -> Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -> APIC 0x28 -> Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -> APIC 0x29 -> Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -> APIC 0x2a -> Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -> APIC 0x2b -> Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -> APIC 0x40 -> Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -> APIC 0x41 -> Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -> APIC 0x42 -> Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -> APIC 0x43 -> Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -> APIC 0x44 -> Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -> APIC 0x45 -> Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -> APIC 0x46 -> Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -> APIC 0x47 -> Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -> APIC 0x48 -> Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -> APIC 0x49 -> Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -> APIC 0x4a -> Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -> APIC 0x4b -> Node 3
Oct 14 08:55:02 eanna kernel: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
Oct 14 08:55:02 eanna kernel: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
Oct 14 08:55:02 eanna kernel: SRAT: Node 0 PXM 0 [mem 0x100000000-0x83fffffff]
Oct 14 08:55:02 eanna kernel: SRAT: Node 2 PXM 2 [mem 0x840000000-0x103effffff]
Oct 14 08:55:02 eanna kernel: NUMA: Initialized distance table, cnt=4
Oct 14 08:55:02 eanna kernel: NUMA: Node 0 [mem 0x00000000-0x0009ffff]
+ [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
Oct 14 08:55:02 eanna kernel: NUMA: Node 0 [mem 0x00000000-0xbfffffff]
+ [mem 0x100000000-0x83fffffff] -> [mem 0x00000000-0x83fffffff]
Oct 14 08:55:02 eanna kernel: NODE_DATA(0) allocated [mem
0x83fffc000-0x83fffffff]
Oct 14 08:55:02 eanna kernel: NODE_DATA(2) allocated [mem
0x103eff9000-0x103effcfff]
Oct 14 08:55:02 eanna kernel:  [ffffea0000000000-ffffea0020ffffff] PMD
-> [ffff88081fe00000-ffff88083fdfffff] on node 0
Oct 14 08:55:02 eanna kernel:  [ffffea0021000000-ffffea0040ffffff] PMD
-> [ffff88101e600000-ffff88103e5fffff] on node 2
Oct 14 08:55:02 eanna kernel: Zone ranges:
Oct 14 08:55:02 eanna kernel:   DMA      [mem
0x0000000000001000-0x0000000000ffffff]
Oct 14 08:55:02 eanna kernel:   DMA32    [mem
0x0000000001000000-0x00000000ffffffff]
Oct 14 08:55:02 eanna kernel:   Normal   [mem
0x0000000100000000-0x000000103effffff]
Oct 14 08:55:02 eanna kernel: Movable zone start for each node
Oct 14 08:55:02 eanna kernel: Early memory node ranges
Oct 14 08:55:02 eanna kernel:   node   0: [mem
0x0000000000001000-0x0000000000093fff]
Oct 14 08:55:02 eanna kernel:   node   0: [mem
0x0000000000100000-0x00000000bfe7ffff]
Oct 14 08:55:02 eanna kernel:   node   0: [mem
0x0000000100000000-0x000000083fffffff]
Oct 14 08:55:02 eanna kernel:   node   2: [mem
0x0000000840000000-0x000000103effffff]
Oct 14 08:55:02 eanna kernel: Initmem setup node 0 [mem
0x0000000000001000-0x000000083fffffff]
Oct 14 08:55:02 eanna kernel: On node 0 totalpages: 8388115
Oct 14 08:55:02 eanna kernel:   DMA zone: 64 pages used for memmap
Oct 14 08:55:02 eanna kernel:   DMA zone: 21 pages reserved
Oct 14 08:55:02 eanna kernel:   DMA zone: 3987 pages, LIFO batch:0
Oct 14 08:55:02 eanna kernel:   DMA32 zone: 12218 pages used for memmap
Oct 14 08:55:02 eanna kernel:   DMA32 zone: 781952 pages, LIFO batch:31
Oct 14 08:55:02 eanna kernel:   Normal zone: 118784 pages used for memmap
Oct 14 08:55:02 eanna kernel:   Normal zone: 7602176 pages, LIFO batch:31
Oct 14 08:55:02 eanna kernel: Initmem setup node 2 [mem
0x0000000840000000-0x000000103effffff]
Oct 14 08:55:02 eanna kernel: On node 2 totalpages: 8384512
Oct 14 08:55:02 eanna kernel:   Normal zone: 131008 pages used for memmap
Oct 14 08:55:02 eanna kernel:   Normal zone: 8384512 pages, LIFO batch:31
Oct 14 08:55:02 eanna kernel: ACPI: PM-Timer IO Port: 0x808
Oct 14 08:55:02 eanna kernel: ACPI: Local APIC address 0xfee00000
Oct 14 08:55:02 eanna kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Oct 14 08:55:02 eanna kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge
lint[0x1])
Oct 14 08:55:02 eanna kernel: IOAPIC[0]: apic_id 0, version 33,
address 0xfec00000, GSI 0-23
Oct 14 08:55:02 eanna kernel: IOAPIC[1]: apic_id 1, version 33,
address 0xfec20000, GSI 24-55
Oct 14 08:55:02 eanna kernel: IOAPIC[2]: apic_id 2, version 33,
address 0xda000000, GSI 56-87
Oct 14 08:55:02 eanna kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
Oct 14 08:55:02 eanna kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 low level)
Oct 14 08:55:02 eanna kernel: ACPI: IRQ0 used by override.
Oct 14 08:55:02 eanna kernel: ACPI: IRQ9 used by override.
Oct 14 08:55:02 eanna kernel: Using ACPI (MADT) for SMP configuration
information
Oct 14 08:55:02 eanna kernel: ACPI: HPET id: 0x8300 base: 0xfed00000
Oct 14 08:55:02 eanna kernel: smpboot: Allowing 32 CPUs, 8 hotplug CPUs
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0x00000000-0x00000fff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0x00094000-0x00094fff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0x00095000-0x0009ffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0x000a0000-0x000e5fff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0x000e6000-0x000fffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xbfe80000-0xbfe8dfff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xbfe8e000-0xbfe8ffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xbfe90000-0xbfeb3fff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xbfeb4000-0xbfedffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xbfee0000-0xbfffffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xc0000000-0xdfffffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xe0000000-0xefffffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xf0000000-0xffdfffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xffe00000-0xffffffff]
Oct 14 08:55:02 eanna kernel: e820: [mem 0xc0000000-0xdfffffff]
available for PCI devices
Oct 14 08:55:02 eanna kernel: Booting paravirtualized kernel on bare hardware
Oct 14 08:55:02 eanna kernel: clocksource: refined-jiffies: mask:
0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
Oct 14 08:55:02 eanna kernel: setup_percpu: NR_CPUS:128
nr_cpumask_bits:128 nr_cpu_ids:32 nr_node_ids:4
Oct 14 08:55:02 eanna kernel: PERCPU: Embedded 32 pages/cpu
@ffff88081f800000 s91480 r8192 d31400 u262144
Oct 14 08:55:02 eanna kernel: pcpu-alloc: s91480 r8192 d31400 u262144
alloc=1*2097152
Oct 14 08:55:02 eanna kernel: pcpu-alloc: [0] 00 01 02 03 04 05 06 07
[0] 08 09 10 11 18 19 20 21
Oct 14 08:55:02 eanna kernel: pcpu-alloc: [0] 22 23 24 26 28 30 -- --
[1] 12 13 14 15 16 17 25 27
Oct 14 08:55:02 eanna kernel: pcpu-alloc: [1] 29 31 -- -- -- -- -- --
Oct 14 08:55:02 eanna kernel: Built 2 zonelists in Node order,
mobility grouping on.  Total pages: 16510532
Oct 14 08:55:02 eanna kernel: Policy zone: Normal
Oct 14 08:55:02 eanna kernel: Kernel command line:
BOOT_IMAGE=/__system/ROOT/boot/vmlinuz-linux
root=UUID=06acfd0f-314d-457f-ba00-f96bf5b94a02 rw
rootflags=subvol=__system/ROOT quiet acpi_osi=Linux amd_iommu_dump=1
transparent_hugepage=never
Oct 14 08:55:02 eanna kernel: PID hash table entries: 4096 (order: 3,
32768 bytes)
Oct 14 08:55:02 eanna kernel: AGP: Checking aperture...
Oct 14 08:55:02 eanna kernel: AGP: No AGP bridge found
Oct 14 08:55:02 eanna kernel: AGP: Node 0: aperture [bus addr
0x00000000-0x01ffffff] (32MB)
Oct 14 08:55:02 eanna kernel: AGP: Your BIOS doesn't leave an aperture
memory hole
Oct 14 08:55:02 eanna kernel: AGP: Please enable the IOMMU option in
the BIOS setup
Oct 14 08:55:02 eanna kernel: AGP: This costs you 64MB of RAM
Oct 14 08:55:02 eanna kernel: AGP: Mapping aperture over RAM [mem
0xb4000000-0xb7ffffff] (65536KB)
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem
0xb4000000-0xb7ffffff]
Oct 14 08:55:02 eanna kernel: Memory: 65890116K/67090508K available
(5591K kernel code, 922K rwdata, 1764K rodata, 1180K init, 1152K bss,
1200392K reserved, 0K cma-reserved)
Oct 14 08:55:02 eanna kernel: SLUB: HWalign=64, Order=0-3,
MinObjects=0, CPUs=32, Nodes=4
Oct 14 08:55:02 eanna kernel: Preemptible hierarchical RCU implementation.
Oct 14 08:55:02 eanna kernel:         Build-time adjustment of leaf
fanout to 64.
Oct 14 08:55:02 eanna kernel:         RCU restricting CPUs from
NR_CPUS=128 to nr_cpu_ids=32.
Oct 14 08:55:02 eanna kernel: RCU: Adjusting geometry for
rcu_fanout_leaf=64, nr_cpu_ids=32
Oct 14 08:55:02 eanna kernel: NR_IRQS:8448 nr_irqs:1768 16
Oct 14 08:55:02 eanna kernel: spurious 8259A interrupt: IRQ7.
Oct 14 08:55:02 eanna kernel: Console: colour dummy device 80x25
Oct 14 08:55:02 eanna kernel: console [tty0] enabled
Oct 14 08:55:02 eanna kernel: mempolicy: Enabling automatic NUMA
balancing. Configure with numa_balancing= or the kernel.numa_balancing
sysctl
Oct 14 08:55:02 eanna kernel: clocksource: hpet: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
Oct 14 08:55:02 eanna kernel: hpet clockevent registered
Oct 14 08:55:02 eanna kernel: tsc: Fast TSC calibration using PIT
Oct 14 08:55:02 eanna kernel: tsc: Detected 2800.266 MHz processor
Oct 14 08:55:02 eanna kernel: Calibrating delay loop (skipped), value
calculated using timer frequency.. 5602.88 BogoMIPS (lpj=9334220)
Oct 14 08:55:02 eanna kernel: pid_max: default: 32768 minimum: 301
Oct 14 08:55:02 eanna kernel: ACPI: Core revision 20150619
Oct 14 08:55:02 eanna kernel: ACPI: All ACPI Tables successfully acquired
Oct 14 08:55:02 eanna kernel: Security Framework initialized
Oct 14 08:55:02 eanna kernel: Yama: becoming mindful.
Oct 14 08:55:02 eanna kernel: Dentry cache hash table entries: 8388608
(order: 14, 67108864 bytes)
Oct 14 08:55:02 eanna kernel: Inode-cache hash table entries: 4194304
(order: 13, 33554432 bytes)
Oct 14 08:55:02 eanna kernel: Mount-cache hash table entries: 131072
(order: 8, 1048576 bytes)
Oct 14 08:55:02 eanna kernel: Mountpoint-cache hash table entries:
131072 (order: 8, 1048576 bytes)
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys blkio
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys memory
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys devices
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys freezer
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys net_cls
Oct 14 08:55:02 eanna kernel: CPU: Physical Processor ID: 0
Oct 14 08:55:02 eanna kernel: CPU: Processor Core ID: 0
Oct 14 08:55:02 eanna kernel: mce: CPU supports 7 MCE banks
Oct 14 08:55:02 eanna kernel: LVT offset 1 assigned for vector 0xf9
Oct 14 08:55:02 eanna kernel: Last level iTLB entries: 4KB 512, 2MB
1024, 4MB 512
Oct 14 08:55:02 eanna kernel: Last level dTLB entries: 4KB 1024, 2MB
1024, 4MB 512, 1GB 0
Oct 14 08:55:02 eanna kernel: Freeing SMP alternatives memory: 20K
(ffffffff81a0f000 - ffffffff81a14000)
Oct 14 08:55:02 eanna kernel: ftrace: allocating 22094 entries in 87 pages
Oct 14 08:55:02 eanna kernel: AMD-Vi: device: 00:00.2 cap: 0040 seg: 0
flags: 3e info 1300
Oct 14 08:55:02 eanna kernel: AMD-Vi:        mmio-addr: 00000000f6000000
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START
devid: 00:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END
devid: 00:00.2
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 00:04.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 05:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_ALIAS_RANGE
 devid: 06:01.0 flags: 00 devid_to: 06:00.0
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END
devid: 06:1f.7
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 00:0c.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 04:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 00:0d.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START
devid: 02:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END
devid: 02:1f.7
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 00:11.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START
devid: 00:12.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END
devid: 00:12.2
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START
devid: 00:13.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END
devid: 00:13.2
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 00:14.0 flags: d7
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 00:14.3 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 00:14.4 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_ALIAS_RANGE
 devid: 01:00.0 flags: 00 devid_to: 00:14.4
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END
devid: 01:1f.7
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 00:14.5 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SPECIAL(IOAPIC[0])
       devid: 00:14.0
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SPECIAL(HPET[0])
     devid: 00:14.0
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SPECIAL(IOAPIC[1])
       devid: 00:00.1
Oct 14 08:55:02 eanna kernel: AMD-Vi: device: 40:00.2 cap: 0040 seg: 0
flags: 3e info 1300
Oct 14 08:55:02 eanna kernel: AMD-Vi:        mmio-addr: 00000000da010000
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START
devid: 40:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END
devid: 40:00.2
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 40:02.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START
devid: 42:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END
devid: 42:00.1
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 40:04.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT
    devid: 41:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SPECIAL(IOAPIC[2])
       devid: 40:00.1
Oct 14 08:55:02 eanna kernel: Switched APIC routing to physical flat.
Oct 14 08:55:02 eanna kernel: ..TIMER: vector=0x30 apic1=0 pin1=2
apic2=-1 pin2=-1
Oct 14 08:55:02 eanna kernel: smpboot: CPU0: AMD Opteron(tm) Processor
6348 (fam: 15, model: 02, stepping: 00)
Oct 14 08:55:02 eanna kernel: Performance Events: Fam15h core perfctr,
AMD PMU driver.
Oct 14 08:55:02 eanna kernel: ... version:                0
Oct 14 08:55:02 eanna kernel: ... bit width:              48
Oct 14 08:55:02 eanna kernel: ... generic registers:      6
Oct 14 08:55:02 eanna kernel: ... value mask:             0000ffffffffffff
Oct 14 08:55:02 eanna kernel: ... max period:             00007fffffffffff
Oct 14 08:55:02 eanna kernel: ... fixed-purpose events:   0
Oct 14 08:55:02 eanna kernel: ... event mask:             000000000000003f
Oct 14 08:55:02 eanna kernel: NMI watchdog: enabled on all CPUs,
permanently consumes one hw-PMU counter.
Oct 14 08:55:02 eanna kernel: x86: Booting SMP configuration:
Oct 14 08:55:02 eanna kernel: .... node  #0, CPUs:        #1  #2  #3
#4  #5  #6  #7  #8  #9 #10 #11
Oct 14 08:55:02 eanna kernel: .... node  #2, CPUs:   #12 #13 #14 #15 #16 #17
Oct 14 08:55:02 eanna kernel: .... node  #0, CPUs:   #18 #19 #20 #21 #22 #23
Oct 14 08:55:02 eanna kernel: x86: Booted up 2 nodes, 24 CPUs
Oct 14 08:55:02 eanna kernel: smpboot: Total of 24 processors
activated (134458.90 BogoMIPS)
Oct 14 08:55:02 eanna kernel: devtmpfs: initialized
Oct 14 08:55:02 eanna kernel: memory block size : 128MB
Oct 14 08:55:02 eanna kernel: PM: Registering ACPI NVS region [mem
0xbfeb4000-0xbfedffff] (180224 bytes)
Oct 14 08:55:02 eanna kernel: clocksource: jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
Oct 14 08:55:02 eanna kernel: pinctrl core: initialized pinctrl subsystem
Oct 14 08:55:02 eanna kernel: RTC time: 15:54:51, date: 10/14/15
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 16
Oct 14 08:55:02 eanna kernel: cpuidle: using governor ladder
Oct 14 08:55:02 eanna kernel: cpuidle: using governor menu
Oct 14 08:55:02 eanna kernel: ACPI: bus type PCI registered
Oct 14 08:55:02 eanna kernel: acpiphp: ACPI Hot Plug PCI Controller
Driver version: 0.5
Oct 14 08:55:02 eanna kernel: PCI: MMCONFIG for domain 0000 [bus
00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Oct 14 08:55:02 eanna kernel: PCI: MMCONFIG at [mem
0xe0000000-0xefffffff] reserved in E820
Oct 14 08:55:02 eanna kernel: PCI: Using configuration type 1 for base access
Oct 14 08:55:02 eanna kernel: mtrr: your CPUs had inconsistent
variable MTRR settings
Oct 14 08:55:02 eanna kernel: mtrr: probably your BIOS does not setup all CPUs.
Oct 14 08:55:02 eanna kernel: mtrr: corrected configuration.
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(Module Device)
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(Processor Device)
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(Processor Aggregator Device)
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(Linux)
Oct 14 08:55:02 eanna kernel: ACPI: Executed 2 blocks of module-level
executable AML code
Oct 14 08:55:02 eanna kernel: ACPI: Interpreter enabled
Oct 14 08:55:02 eanna kernel: ACPI Exception: AE_NOT_FOUND, While
evaluating Sleep State [\_S2_] (20150619/hwxface-580)
Oct 14 08:55:02 eanna kernel: ACPI Exception: AE_NOT_FOUND, While
evaluating Sleep State [\_S3_] (20150619/hwxface-580)
Oct 14 08:55:02 eanna kernel: ACPI: (supports S0 S1 S4 S5)
Oct 14 08:55:02 eanna kernel: ACPI: Using IOAPIC for interrupt routing
Oct 14 08:55:02 eanna kernel: HEST: Table parsing has been initialized.
Oct 14 08:55:02 eanna kernel: PCI: Using host bridge windows from
ACPI; if necessary, use "pci=nocrs" and report a bug
Oct 14 08:55:02 eanna kernel: ACPI: PCI Root Bridge [PCI0] (domain
0000 [bus 00-06])
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:00: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI]
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:00: _OSC failed
(AE_NOT_FOUND); disabling ASPM
Oct 14 08:55:02 eanna kernel: PCI host bridge to bus 0000:00
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [bus 00-06]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [io
0x0000-0x03af window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [io
0x03e0-0x0cf7 window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [io
0x03c0-0x03df window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [io
0x0d00-0xffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem
0x000d0000-0x000dffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem
0xdd000000-0xdfffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem
0xdc000000-0xdcffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem
0xfed40000-0xfed44fff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:00.0: [1002:5a10] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:00.2: [1002:5a23] type 00
class 0x080600
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: [1002:5a18] type 01
class 0x060400
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: PME# supported from D0
D3hot D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: [1002:5a20] type 01
class 0x060400
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: PME# supported from D0
D3hot D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: [1002:5a1e] type 01
class 0x060400
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: PME# supported from D0
D3hot D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: [1002:4391] type 00
class 0x010601
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x10: [io  0xa000-0xa007]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x14: [io  0x9000-0x9003]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x18: [io  0x8000-0x8007]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x1c: [io  0x7000-0x7003]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x20: [io  0x6000-0x600f]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x24: [mem
0xdf5f8400-0xdf5f87ff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.0: [1002:4397] type 00
class 0x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.0: reg 0x10: [mem
0xdf5f7000-0xdf5f7fff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.0: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.1: [1002:4398] type 00
class 0x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.1: reg 0x10: [mem
0xdf5f6000-0xdf5f6fff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.1: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: [1002:4396] type 00
class 0x0c0320
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: reg 0x10: [mem
0xdf5f8800-0xdf5f88ff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: PME# supported from D0
D1 D2 D3hot
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.0: [1002:4397] type 00
class 0x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.0: reg 0x10: [mem
0xdf5fa000-0xdf5fafff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.0: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.1: [1002:4398] type 00
class 0x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.1: reg 0x10: [mem
0xdf5f9000-0xdf5f9fff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.1: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: [1002:4396] type 00
class 0x0c0320
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: reg 0x10: [mem
0xdf5f8c00-0xdf5f8cff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: PME# supported from D0
D1 D2 D3hot
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.0: [1002:4385] type 00
class 0x0c0500
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.3: [1002:439d] type 00
class 0x060100
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4: [1002:4384] type 01
class 0x060401
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.5: [1002:4399] type 00
class 0x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.5: reg 0x10: [mem
0xdf5fb000-0xdf5fbfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.5: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.0: [1022:1600] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.1: [1022:1601] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.2: [1022:1602] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.3: [1022:1603] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.4: [1022:1604] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.5: [1022:1605] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.0: [1022:1600] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.1: [1022:1601] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.2: [1022:1602] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.3: [1022:1603] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.4: [1022:1604] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.5: [1022:1605] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.0: [1022:1600] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.1: [1022:1601] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.2: [1022:1602] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.3: [1022:1603] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.4: [1022:1604] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.5: [1022:1605] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.0: [1022:1600] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.1: [1022:1601] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.2: [1022:1602] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.3: [1022:1603] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.4: [1022:1604] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.5: [1022:1605] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: [1b21:1080] type 01
class 0x060400
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: PME# supported from D0
D1 D2 D3hot D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: PCI bridge to [bus 05-06]
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0:   bridge window [io
0xd000-0xdfff]
Oct 14 08:55:02 eanna kernel: pci 0000:06:00.0: [13f6:8788] type 00
class 0x040100
Oct 14 08:55:02 eanna kernel: pci 0000:06:00.0: reg 0x10: [io  0xd800-0xd8ff]
Oct 14 08:55:02 eanna kernel: pci 0000:06:00.0: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: PCI bridge to [bus 06]
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0:   bridge window [io
0xd000-0xdfff]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: [1000:0072] type 00
class 0x010700
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x10: [io  0xc000-0xc0ff]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x14: [mem
0xdff3c000-0xdff3ffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x1c: [mem
0xdff40000-0xdff7ffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x30: [mem
0xdff80000-0xdfffffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x174: [mem
0xdfec0000-0xdfec3fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: VF(n) BAR0 space: [mem
0xdfec0000-0xdfefffff 64bit] (contains BAR0 for 16 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x17c: [mem
0xdf800000-0xdf83ffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: VF(n) BAR2 space: [mem
0xdf800000-0xdfbfffff 64bit] (contains BAR2 for 16 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: PCI bridge to [bus 04]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0:   bridge window [io
0xc000-0xcfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0:   bridge window [mem
0xdf800000-0xdfffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: [8086:10c9] type 00
class 0x020000
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x10: [mem
0xdf7e0000-0xdf7fffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x14: [mem
0xdf7c0000-0xdf7dffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x18: [io  0xb800-0xb81f]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x1c: [mem
0xdf79c000-0xdf79ffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x30: [mem
0xdf7a0000-0xdf7bffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: PME# supported from D0
D3hot D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x184: [mem
0xdf760000-0xdf763fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: VF(n) BAR0 space: [mem
0xdf760000-0xdf77ffff 64bit] (contains BAR0 for 8 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x190: [mem
0xdf740000-0xdf743fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: VF(n) BAR3 space: [mem
0xdf740000-0xdf75ffff 64bit] (contains BAR3 for 8 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: [8086:10c9] type 00
class 0x020000
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x10: [mem
0xdf720000-0xdf73ffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x14: [mem
0xdf700000-0xdf71ffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x18: [io  0xb400-0xb41f]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x1c: [mem
0xdf6dc000-0xdf6dffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x30: [mem
0xdf6e0000-0xdf6fffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: PME# supported from D0
D3hot D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x184: [mem
0xdf6a0000-0xdf6a3fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: VF(n) BAR0 space: [mem
0xdf6a0000-0xdf6bffff 64bit] (contains BAR0 for 8 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x190: [mem
0xdf680000-0xdf683fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: VF(n) BAR3 space: [mem
0xdf680000-0xdf69ffff 64bit] (contains BAR3 for 8 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: PCI bridge to [bus 02-03]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0:   bridge window [io
0xb000-0xbfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0:   bridge window [mem
0xdf600000-0xdf7fffff]
Oct 14 08:55:02 eanna kernel: pci 0000:01:04.0: [102b:0532] type 00
class 0x030000
Oct 14 08:55:02 eanna kernel: pci 0000:01:04.0: reg 0x10: [mem
0xdc000000-0xdcffffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:01:04.0: reg 0x14: [mem
0xde7fc000-0xde7fffff]
Oct 14 08:55:02 eanna kernel: pci 0000:01:04.0: reg 0x18: [mem
0xde800000-0xdeffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4: PCI bridge to [bus 01]
(subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem
0xde700000-0xdeffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem
0xdc000000-0xdcffffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [io
0x0000-0x03af window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [io
0x03e0-0x0cf7 window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [io
0x03c0-0x03df window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [io
0x0d00-0xffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem
0x000a0000-0x000bffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem
0x000d0000-0x000dffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem
0xdd000000-0xdfffffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem
0xdc000000-0xdcffffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem
0xfed40000-0xfed44fff] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: on NUMA node 0
Oct 14 08:55:02 eanna kernel: ACPI: PCI Root Bridge [PC40] (domain
0000 [bus 40-42])
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:01: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI]
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:01: _OSC: OS now controls
[PCIeHotplug PME AER PCIeCapability]
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:01: [Firmware Bug]: no
_PXM; falling back to node 2 from hardware (may be inconsistent with
ACPI node numbers)
Oct 14 08:55:02 eanna kernel: PCI host bridge to bus 0000:40
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [bus 40-42]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [io
0xe000-0xefff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [io
0x03b0-0x03bb window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [io
0x03c0-0x03df window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [mem
0x000a0000-0x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [mem
0xda000000-0xdbffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [mem
0xc0000000-0xd9ffffff window]
Oct 14 08:55:02 eanna kernel: pci 0000:40:00.0: [1002:5a10] type 00
class 0x060000
Oct 14 08:55:02 eanna kernel: pci 0000:40:00.2: [1002:5a23] type 00
class 0x080600
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: [1002:5a16] type 01
class 0x060400
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: PME# supported from D0
D3hot D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: [1002:5a18] type 01
class 0x060400
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: PME# supported from D0
D3hot D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: System wakeup disabled by ACPI
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: [1002:679a] type 00
class 0x030000
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: reg 0x10: [mem
0xc0000000-0xcfffffff 64bit pref]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: reg 0x18: [mem
0xdbfc0000-0xdbffffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: reg 0x20: [io  0xe000-0xe0ff]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: reg 0x30: [mem
0xdbfa0000-0xdbfbffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: PME# supported from D1 D2 D3hot
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.1: [1002:aaa0] type 00
class 0x040300
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.1: reg 0x10: [mem
0xdbf9c000-0xdbf9ffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.1: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: PCI bridge to [bus 42]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [io
0xe000-0xefff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [mem
0xdbf00000-0xdbffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [mem
0xc0000000-0xcfffffff 64bit pref]
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: [1b73:1100] type 00
class 0x0c0330
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: reg 0x10: [mem
0xdbef0000-0xdbefffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: reg 0x18: [mem
0xdbeef000-0xdbeeffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: reg 0x20: [mem
0xdbeee000-0xdbeeefff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: supports D1
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: PME# supported from D0 D1 D3hot
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: PCI bridge to [bus 41]
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0:   bridge window [mem
0xdbe00000-0xdbefffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: on NUMA node 2
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 4
7 10 11 12 14 *15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 4
7 10 *11 12 14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 4
7 10 11 12 *14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 4
7 *10 11 12 14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 4
7 10 *11 12 14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 4
7 10 11 12 14 15) *0, disabled.
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 4
7 *10 11 12 14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 4
7 10 11 12 14 15) *0, disabled.
Oct 14 08:55:02 eanna kernel: vgaarb: device added:
PCI:0000:01:04.0,decodes=io+mem,owns=none,locks=none
Oct 14 08:55:02 eanna kernel: vgaarb: setting as boot device: PCI:0000:42:00.0
Oct 14 08:55:02 eanna kernel: vgaarb: device added:
PCI:0000:42:00.0,decodes=io+mem,owns=io+mem,locks=none
Oct 14 08:55:02 eanna kernel: vgaarb: loaded
Oct 14 08:55:02 eanna kernel: vgaarb: bridge control possible 0000:42:00.0
Oct 14 08:55:02 eanna kernel: vgaarb: bridge control possible 0000:01:04.0
Oct 14 08:55:02 eanna kernel: PCI: Using ACPI for IRQ routing
Oct 14 08:55:02 eanna kernel: PCI: pci_cache_line_size set to 64 bytes
Oct 14 08:55:02 eanna kernel: e820: reserve RAM buffer [mem
0x00094800-0x0009ffff]
Oct 14 08:55:02 eanna kernel: e820: reserve RAM buffer [mem
0xbfe80000-0xbfffffff]
Oct 14 08:55:02 eanna kernel: e820: reserve RAM buffer [mem
0x103f000000-0x103fffffff]
Oct 14 08:55:02 eanna kernel: NetLabel: Initializing
Oct 14 08:55:02 eanna kernel: NetLabel:  domain hash size = 128
Oct 14 08:55:02 eanna kernel: NetLabel:  protocols = UNLABELED CIPSOv4
Oct 14 08:55:02 eanna kernel: NetLabel:  unlabeled traffic allowed by default
Oct 14 08:55:02 eanna kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
Oct 14 08:55:02 eanna kernel: hpet0: 4 comparators, 32-bit 14.318180 MHz counter
Oct 14 08:55:02 eanna kernel: clocksource: Switched to clocksource hpet
Oct 14 08:55:02 eanna kernel: pnp: PnP ACPI init
Oct 14 08:55:02 eanna kernel: system 00:00: [mem
0xfec20000-0xfec200ff] could not be reserved
Oct 14 08:55:02 eanna kernel: system 00:00: Plug and Play ACPI device,
IDs PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:01: [mem
0xf6000000-0xf6003fff] could not be reserved
Oct 14 08:55:02 eanna kernel: system 00:01: Plug and Play ACPI device,
IDs PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: pnp 00:02: Plug and Play ACPI device,
IDs PNP0b00 (active)
Oct 14 08:55:02 eanna kernel: system 00:03: [mem
0xfec00000-0xfec00fff] could not be reserved
Oct 14 08:55:02 eanna kernel: system 00:03: [mem
0xfee00000-0xfee00fff] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:03: Plug and Play ACPI device,
IDs PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0ca2-0x0ca3] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0550-0x0551] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x04d0-0x04d1] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x040b] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x04d6] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c00-0x0c01] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c14] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c50-0x0c51] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c52] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c6c] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c6f] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd0-0x0cd1] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd2-0x0cd3] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd4-0x0cd5] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd6-0x0cd7] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd8-0x0cdf] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0800-0x089f] could
not be reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0b00-0x0b0f] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0b20-0x0b3f] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0900-0x090f] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0910-0x091f] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0xfe00-0xfefe] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [mem
0xffb80000-0xffbfffff] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [mem
0xfec10000-0xfec1001f] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [mem
0xffe50000-0xffe5e05f] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: Plug and Play ACPI device,
IDs PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: pnp 00:05: [dma 0 disabled]
Oct 14 08:55:02 eanna kernel: pnp 00:05: Plug and Play ACPI device,
IDs PNP0501 (active)
Oct 14 08:55:02 eanna kernel: pnp 00:06: [dma 0 disabled]
Oct 14 08:55:02 eanna kernel: pnp 00:06: Plug and Play ACPI device,
IDs PNP0501 (active)
Oct 14 08:55:02 eanna kernel: system 00:07: [io  0x0a00-0x0a0f] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:07: [io  0x0a10-0x0a1f] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:07: Plug and Play ACPI device,
IDs PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: pnp 00:08: [dma 0 disabled]
Oct 14 08:55:02 eanna kernel: pnp 00:08: Plug and Play ACPI device,
IDs PNP0501 (active)
Oct 14 08:55:02 eanna kernel: system 00:09: [io  0x164e-0x164f] has
been reserved
Oct 14 08:55:02 eanna kernel: system 00:09: Plug and Play ACPI device,
IDs PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:0a: [mem
0xe0000000-0xefffffff] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:0a: Plug and Play ACPI device,
IDs PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:0b: [mem
0x000c0000-0x000cffff] could not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0b: [mem
0x000e0000-0x000fffff] could not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0b: [mem
0xfec00000-0xffffffff] could not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0b: Plug and Play ACPI device,
IDs PNP0c01 (active)
Oct 14 08:55:02 eanna kernel: system 00:0c: [mem
0xda000000-0xda0000ff] could not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0c: Plug and Play ACPI device,
IDs PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:0d: [mem
0xda010000-0xda013fff] could not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0d: Plug and Play ACPI device,
IDs PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: pnp: PnP ACPI: found 14 devices
Oct 14 08:55:02 eanna kernel: clocksource: acpi_pm: mask: 0xffffff
max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: PCI bridge to [bus 06]
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0:   bridge window [io
0xd000-0xdfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: PCI bridge to [bus 05-06]
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0:   bridge window [io
0xd000-0xdfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: PCI bridge to [bus 04]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0:   bridge window [io
0xc000-0xcfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0:   bridge window [mem
0xdf800000-0xdfffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: PCI bridge to [bus 02-03]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0:   bridge window [io
0xb000-0xbfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0:   bridge window [mem
0xdf600000-0xdf7fffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4: PCI bridge to [bus 01]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem
0xde700000-0xdeffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem
0xdc000000-0xdcffffff pref]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 4 [io
0x0000-0x03af window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 5 [io
0x03e0-0x0cf7 window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 6 [io
0x03c0-0x03df window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 7 [io
0x0d00-0xffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 8 [mem
0x000a0000-0x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 9 [mem
0x000d0000-0x000dffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 10 [mem
0xdd000000-0xdfffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 11 [mem
0xdc000000-0xdcffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 12 [mem
0xfed40000-0xfed44fff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:06: resource 0 [io  0xd000-0xdfff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:04: resource 0 [io  0xc000-0xcfff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:04: resource 1 [mem
0xdf800000-0xdfffffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:02: resource 1 [mem
0xdf600000-0xdf7fffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 1 [mem
0xde700000-0xdeffffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 2 [mem
0xdc000000-0xdcffffff pref]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 4 [io
0x0000-0x03af window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 5 [io
0x03e0-0x0cf7 window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 6 [io
0x03c0-0x03df window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 7 [io
0x0d00-0xffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 8 [mem
0x000a0000-0x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 9 [mem
0x000d0000-0x000dffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 10 [mem
0xdd000000-0xdfffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 11 [mem
0xdc000000-0xdcffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 12 [mem
0xfed40000-0xfed44fff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: PCI bridge to [bus 42]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [io
0xe000-0xefff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [mem
0xdbf00000-0xdbffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [mem
0xc0000000-0xcfffffff 64bit pref]
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: PCI bridge to [bus 41]
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0:   bridge window [mem
0xdbe00000-0xdbefffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 4 [io
0xe000-0xefff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 5 [io
0x03b0-0x03bb window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 6 [io
0x03c0-0x03df window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 7 [mem
0x000a0000-0x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 8 [mem
0xda000000-0xdbffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 9 [mem
0xc0000000-0xd9ffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:42: resource 0 [io  0xe000-0xefff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:42: resource 1 [mem
0xdbf00000-0xdbffffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:42: resource 2 [mem
0xc0000000-0xcfffffff 64bit pref]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:41: resource 1 [mem
0xdbe00000-0xdbefffff]
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 2
Oct 14 08:55:02 eanna kernel: TCP established hash table entries:
524288 (order: 10, 4194304 bytes)
Oct 14 08:55:02 eanna kernel: TCP bind hash table entries: 65536
(order: 8, 1048576 bytes)
Oct 14 08:55:02 eanna kernel: TCP: Hash tables configured (established
524288 bind 65536)
Oct 14 08:55:02 eanna kernel: UDP hash table entries: 32768 (order: 8,
1048576 bytes)
Oct 14 08:55:02 eanna kernel: UDP-Lite hash table entries: 32768
(order: 8, 1048576 bytes)
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 1
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: Video device with shadowed ROM
Oct 14 08:55:02 eanna kernel: PCI: CLS 64 bytes, default 64
Oct 14 08:55:02 eanna kernel: Unpacking initramfs...
Oct 14 08:55:02 eanna kernel: Freeing initrd memory: 4132K
(ffff8800377de000 - ffff880037be7000)
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:00.0 to group 0
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:04.0 to group 1
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:0c.0 to group 2
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:0d.0 to group 3
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:11.0 to group 4
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:12.0 to group 5
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:12.1 to group 5
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:12.2 to group 5
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:13.0 to group 6
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:13.1 to group 6
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:13.2 to group 6
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:14.0 to group 7
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:14.3 to group 8
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:14.4 to group 9
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:14.5 to group 10
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:05:00.0 to group 11
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:06:00.0 to group 11
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:04:00.0 to group 12
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:02:00.0 to group 13
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:02:00.1 to group 14
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:01:04.0 to group 9
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:40:00.0 to group 15
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:40:02.0 to group 16
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:40:04.0 to group 17
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:42:00.0 to group 18
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:42:00.1 to group 18
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:41:00.0 to group 19
Oct 14 08:55:02 eanna kernel: AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
Oct 14 08:55:02 eanna kernel: AMD-Vi: Found IOMMU at 0000:40:00.2 cap 0x40
Oct 14 08:55:02 eanna kernel: AMD-Vi: Interrupt remapping enabled
Oct 14 08:55:02 eanna kernel: AMD-Vi: Lazy IO/TLB flushing enabled
Oct 14 08:55:02 eanna kernel: perf: AMD NB counters detected
Oct 14 08:55:02 eanna kernel: microcode: CPU0: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU1: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU2: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU3: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU4: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU5: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU6: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU7: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU8: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU9: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU10: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU11: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU12: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU13: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU14: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU15: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU16: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU17: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU18: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU19: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU20: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU21: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU22: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU23: patch_level=0x06000822
Oct 14 08:55:02 eanna kernel: microcode: Microcode Update Driver:
v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
Oct 14 08:55:02 eanna kernel: LVT offset 0 assigned for vector 0x400
Oct 14 08:55:02 eanna kernel: perf: AMD IBS detected (0x000000ff)
Oct 14 08:55:02 eanna kernel: Scanning for low memory corruption every
60 seconds
Oct 14 08:55:02 eanna kernel: futex hash table entries: 8192 (order:
7, 524288 bytes)
Oct 14 08:55:02 eanna kernel: Initialise system trusted keyring
Oct 14 08:55:02 eanna kernel: HugeTLB registered 2 MB page size,
pre-allocated 0 pages
Oct 14 08:55:02 eanna kernel: zpool: loaded
Oct 14 08:55:02 eanna kernel: zbud: loaded
Oct 14 08:55:02 eanna kernel: VFS: Disk quotas dquot_6.6.0
Oct 14 08:55:02 eanna kernel: VFS: Dquot-cache hash table entries: 512
(order 0, 4096 bytes)
Oct 14 08:55:02 eanna kernel: Key type big_key registered
Oct 14 08:55:02 eanna kernel: Block layer SCSI generic (bsg) driver
version 0.4 loaded (major 250)
Oct 14 08:55:02 eanna kernel: io scheduler noop registered
Oct 14 08:55:02 eanna kernel: io scheduler deadline registered
Oct 14 08:55:02 eanna kernel: io scheduler cfq registered (default)
Oct 14 08:55:02 eanna kernel: pcieport 0000:40:02.0: Signaling PME
through PCIe PME interrupt
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: Signaling PME through
PCIe PME interrupt
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.1: Signaling PME through
PCIe PME interrupt
Oct 14 08:55:02 eanna kernel: pcie_pme 0000:40:02.0:pcie01: service
driver pcie_pme loaded
Oct 14 08:55:02 eanna kernel: pcieport 0000:40:04.0: Signaling PME
through PCIe PME interrupt
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: Signaling PME through
PCIe PME interrupt
Oct 14 08:55:02 eanna kernel: pcie_pme 0000:40:04.0:pcie01: service
driver pcie_pme loaded
Oct 14 08:55:02 eanna kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Oct 14 08:55:02 eanna kernel: pciehp: PCI Express Hot Plug Controller
Driver version: 0.4
Oct 14 08:55:02 eanna kernel: vesafb: mode is 1920x1080x32,
linelength=7680, pages=0
Oct 14 08:55:02 eanna kernel: vesafb: scrolling: redraw
Oct 14 08:55:02 eanna kernel: vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
Oct 14 08:55:02 eanna kernel: vesafb: framebuffer at 0xc0000000,
mapped to 0xffffc90007000000, using 8128k, total 8128k
Oct 14 08:55:02 eanna kernel: Console: switching to colour frame
buffer device 240x67
Oct 14 08:55:02 eanna kernel: fb0: VESA VGA frame buffer device
Oct 14 08:55:02 eanna kernel: ERST: Can not request [mem
0xbfe8e000-0xbfe8ffff] for ERST.
Oct 14 08:55:02 eanna kernel: GHES: APEI firmware first mode is
enabled by APEI bit and WHEA _OSC.
Oct 14 08:55:02 eanna kernel: Serial: 8250/16550 driver, 4 ports, IRQ
sharing disabled
Oct 14 08:55:02 eanna kernel: 00:05: ttyS0 at I/O 0x3f8 (irq = 4,
base_baud = 115200) is a 16550A
Oct 14 08:55:02 eanna kernel: 00:06: ttyS1 at I/O 0x2f8 (irq = 3,
base_baud = 115200) is a 16550A
Oct 14 08:55:02 eanna kernel: 00:08: ttyS2 at I/O 0x3e8 (irq = 7,
base_baud = 115200) is a 16550A
Oct 14 08:55:02 eanna kernel: Linux agpgart interface v0.103
Oct 14 08:55:02 eanna kernel: rtc_cmos 00:02: RTC can wake from S4
Oct 14 08:55:02 eanna kernel: rtc_cmos 00:02: rtc core: registered
rtc_cmos as rtc0
Oct 14 08:55:02 eanna kernel: rtc_cmos 00:02: alarms up to one month,
y3k, 114 bytes nvram, hpet irqs
Oct 14 08:55:02 eanna kernel: ledtrig-cpu: registered to indicate
activity on CPUs
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 10
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 17
Oct 14 08:55:02 eanna kernel: Loading compiled-in X.509 certificates
Oct 14 08:55:02 eanna kernel: registered taskstats version 1
Oct 14 08:55:02 eanna kernel: zswap: loading zswap
Oct 14 08:55:02 eanna kernel: zswap: using zbud pool
Oct 14 08:55:02 eanna kernel: zswap: using lzo compressor
Oct 14 08:55:02 eanna kernel:   Magic number: 3:558:942
Oct 14 08:55:02 eanna kernel: memory memory365: hash matches
Oct 14 08:55:02 eanna kernel: rtc_cmos 00:02: setting system clock to
2015-10-14 15:54:52 UTC (1444838092)
Oct 14 08:55:02 eanna kernel: PM: Hibernation image not present or
could not be loaded.
Oct 14 08:55:02 eanna kernel: Freeing unused kernel memory: 1180K
(ffffffff818e8000 - ffffffff81a0f000)
Oct 14 08:55:02 eanna kernel: Write protecting the kernel read-only data: 8192k
Oct 14 08:55:02 eanna kernel: Freeing unused kernel memory: 544K
(ffff880001578000 - ffff880001600000)
Oct 14 08:55:02 eanna kernel: Freeing unused kernel memory: 284K
(ffff8800017b9000 - ffff880001800000)
Oct 14 08:55:02 eanna kernel: random: systemd-tmpfile urandom read
with 1 bits of entropy available
Oct 14 08:55:02 eanna kernel: i8042: PNP: No PS/2 controller found.
Probing ports directly.
Oct 14 08:55:02 eanna kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 14 08:55:02 eanna kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 14 08:55:02 eanna kernel: SCSI subsystem initialized
Oct 14 08:55:02 eanna kernel: ACPI: bus type USB registered
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver usbfs
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver hub
Oct 14 08:55:02 eanna kernel: usbcore: registered new device driver usb
Oct 14 08:55:02 eanna kernel: ehci_hcd: USB 2.0 'Enhanced' Host
Controller (EHCI) Driver
Oct 14 08:55:02 eanna kernel: mpt2sas version 20.100.00.00 loaded
Oct 14 08:55:02 eanna kernel: mpt2sas0: 64 BIT PCI BUS DMA ADDRESSING
SUPPORTED, total mem (65962228 kB)
Oct 14 08:55:02 eanna kernel: ohci_hcd: USB 1.1 'Open' Host Controller
(OHCI) Driver
Oct 14 08:55:02 eanna kernel: ehci-pci: EHCI PCI platform driver
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: EHCI Host Controller
Oct 14 08:55:02 eanna kernel: libata version 3.00 loaded.
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: new USB bus
registered, assigned bus number 1
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: debug port 1
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: irq 17, io mem 0xdf5f8800
Oct 14 08:55:02 eanna kernel: ohci-pci: OHCI PCI platform driver
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
Oct 14 08:55:02 eanna kernel: hub 1-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 1-0:1.0: 6 ports detected
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: xHCI Host Controller
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: new USB bus
registered, assigned bus number 2
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: hcc params
0x200071a1 hci version 0x100 quirks 0x00000010
Oct 14 08:55:02 eanna kernel: hub 2-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 2-0:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: xHCI Host Controller
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: new USB bus
registered, assigned bus number 3
Oct 14 08:55:02 eanna kernel: usb usb3: We don't know the algorithms
for LPM for this host, disabling LPM.
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: EHCI Host Controller
Oct 14 08:55:02 eanna kernel: hub 3-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 3-0:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: new USB bus
registered, assigned bus number 4
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: debug port 1
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: irq 19, io mem 0xdf5f8c00
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
Oct 14 08:55:02 eanna kernel: hub 4-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 4-0:1.0: 6 ports detected
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.0: OHCI PCI host controller
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.0: new USB bus
registered, assigned bus number 5
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.0: irq 16, io mem 0xdf5f7000
Oct 14 08:55:02 eanna kernel: hub 5-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 5-0:1.0: 3 ports detected
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.1: OHCI PCI host controller
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.1: new USB bus
registered, assigned bus number 6
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.1: irq 16, io mem 0xdf5f6000
Oct 14 08:55:02 eanna kernel: hub 6-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 6-0:1.0: 3 ports detected
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.0: OHCI PCI host controller
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.0: new USB bus
registered, assigned bus number 7
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.0: irq 18, io mem 0xdf5fa000
Oct 14 08:55:02 eanna kernel: hub 7-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 7-0:1.0: 3 ports detected
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.1: OHCI PCI host controller
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.1: new USB bus
registered, assigned bus number 8
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.1: irq 18, io mem 0xdf5f9000
Oct 14 08:55:02 eanna kernel: mpt2sas0: MSI-X vectors supported: 1, no
of cores: 24, max_msix_vectors: 8
Oct 14 08:55:02 eanna kernel: mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 43
Oct 14 08:55:02 eanna kernel: mpt2sas0: iomem(0x00000000dff3c000),
mapped(0xffffc90006a00000), size(16384)
Oct 14 08:55:02 eanna kernel: mpt2sas0: ioport(0x000000000000c000), size(256)
Oct 14 08:55:02 eanna kernel: hub 8-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 8-0:1.0: 3 ports detected
Oct 14 08:55:02 eanna kernel: usb 3-3: new SuperSpeed USB device
number 2 using xhci_hcd
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:14.5: OHCI PCI host controller
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:14.5: new USB bus
registered, assigned bus number 9
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:14.5: irq 18, io mem 0xdf5fb000
Oct 14 08:55:02 eanna kernel: hub 9-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 9-0:1.0: 2 ports detected
Oct 14 08:55:02 eanna kernel: ahci 0000:00:11.0: version 3.0
Oct 14 08:55:02 eanna kernel: ahci 0000:00:11.0: AHCI 0001.0100 32
slots 6 ports 3 Gbps 0x3f impl SATA mode
Oct 14 08:55:02 eanna kernel: ahci 0000:00:11.0: flags: 64bit ncq sntf
ilck pm led clo pmp pio slum part ccc
Oct 14 08:55:02 eanna kernel: scsi host1: ahci
Oct 14 08:55:02 eanna kernel: scsi host2: ahci
Oct 14 08:55:02 eanna kernel: scsi host3: ahci
Oct 14 08:55:02 eanna kernel: scsi host4: ahci
Oct 14 08:55:02 eanna kernel: scsi host5: ahci
Oct 14 08:55:02 eanna kernel: scsi host6: ahci
Oct 14 08:55:02 eanna kernel: ata1: SATA max UDMA/133 abar
m1024@0xdf5f8400 port 0xdf5f8500 irq 22
Oct 14 08:55:02 eanna kernel: ata2: SATA max UDMA/133 abar
m1024@0xdf5f8400 port 0xdf5f8580 irq 22
Oct 14 08:55:02 eanna kernel: ata3: SATA max UDMA/133 abar
m1024@0xdf5f8400 port 0xdf5f8600 irq 22
Oct 14 08:55:02 eanna kernel: ata4: SATA max UDMA/133 abar
m1024@0xdf5f8400 port 0xdf5f8680 irq 22
Oct 14 08:55:02 eanna kernel: ata5: SATA max UDMA/133 abar
m1024@0xdf5f8400 port 0xdf5f8700 irq 22
Oct 14 08:55:02 eanna kernel: ata6: SATA max UDMA/133 abar
m1024@0xdf5f8400 port 0xdf5f8780 irq 22
Oct 14 08:55:02 eanna kernel: usb 2-3: new high-speed USB device
number 2 using xhci_hcd
Oct 14 08:55:02 eanna kernel: hub 3-3:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 3-3:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: mpt2sas0: Allocated physical memory: size(3927 kB)
Oct 14 08:55:02 eanna kernel: mpt2sas0: Current Controller Queue
Depth(1723), Max Controller Queue Depth(1952)
Oct 14 08:55:02 eanna kernel: mpt2sas0: Scatter Gather Elements per IO(128)
Oct 14 08:55:02 eanna kernel: hub 2-3:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 2-3:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: usb 5-1: new full-speed USB device
number 2 using ohci-pci
Oct 14 08:55:02 eanna kernel: mpt2sas0: LSISAS2008:
FWVersion(11.00.00.00), ChipRevision(0x03), BiosVersion(07.21.00.00)
Oct 14 08:55:02 eanna kernel: mpt2sas0: Protocol=(Initiator),
Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set
Full,NCQ)
Oct 14 08:55:02 eanna kernel: scsi host0: Fusion MPT SAS Host
Oct 14 08:55:02 eanna kernel: mpt2sas0: sending port enable !!
Oct 14 08:55:02 eanna kernel: ata3: SATA link down (SStatus 0 SControl 300)
Oct 14 08:55:02 eanna kernel: ata4: SATA link down (SStatus 0 SControl 300)
Oct 14 08:55:02 eanna kernel: ata5: SATA link down (SStatus 0 SControl 300)
Oct 14 08:55:02 eanna kernel: usb 9-1: new full-speed USB device
number 2 using ohci-pci
Oct 14 08:55:02 eanna kernel: hub 5-1:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 5-1:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: tsc: Refined TSC clocksource
calibration: 2800.000 MHz
Oct 14 08:55:02 eanna kernel: clocksource: tsc: mask:
0xffffffffffffffff max_cycles: 0x285c40e2248, max_idle_ns:
440795340634 ns
Oct 14 08:55:02 eanna kernel: ata6: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Oct 14 08:55:02 eanna kernel: ata2: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Oct 14 08:55:02 eanna kernel: ata1: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Oct 14 08:55:02 eanna kernel: ata1.00: READ LOG DMA EXT failed, trying unqueued
Oct 14 08:55:02 eanna kernel: ata2.00: READ LOG DMA EXT failed, trying unqueued
Oct 14 08:55:02 eanna kernel: ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
Oct 14 08:55:02 eanna kernel: ata1.00: ATA-9: Samsung SSD 840 PRO
Series, DXM05B0Q, max UDMA/133
Oct 14 08:55:02 eanna kernel: ata1.00: 1000215216 sectors, multi 16:
LBA48 NCQ (depth 31/32), AA
Oct 14 08:55:02 eanna kernel: ata2.00: failed to get NCQ Send/Recv Log Emask 0x1
Oct 14 08:55:02 eanna kernel: ata2.00: ATA-9: Samsung SSD 840 PRO
Series, DXM05B0Q, max UDMA/133
Oct 14 08:55:02 eanna kernel: ata2.00: 1000215216 sectors, multi 16:
LBA48 NCQ (depth 31/32), AA
Oct 14 08:55:02 eanna kernel: ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
Oct 14 08:55:02 eanna kernel: ata2.00: failed to get NCQ Send/Recv Log Emask 0x1
Oct 14 08:55:02 eanna kernel: ata1.00: configured for UDMA/133
Oct 14 08:55:02 eanna kernel: ata2.00: configured for UDMA/133
Oct 14 08:55:02 eanna kernel: scsi: waiting for bus probes to complete ...
Oct 14 08:55:02 eanna kernel: ata6.00: ATAPI: ATAPI   iHAS124   W,
HL0A, max UDMA/100
Oct 14 08:55:02 eanna kernel: ata6.00: configured for UDMA/100
Oct 14 08:55:02 eanna kernel: hidraw: raw HID events driver (C) Jiri Kosina
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver usbhid
Oct 14 08:55:02 eanna kernel: usbhid: USB HID core driver
Oct 14 08:55:02 eanna kernel: input: Winbond Electronics Corp Hermon
USB hidmouse Device as
/devices/pci0000:00/0000:00:14.5/usb9/9-1/9-1:1.0/0003:0557:2221.0001/input/input2
Oct 14 08:55:02 eanna kernel: hid-generic 0003:0557:2221.0001:
input,hidraw0: USB HID v1.00 Mouse [Winbond Electronics Corp Hermon
USB hidmouse Device] on usb-0000:00:14.5-1/input0
Oct 14 08:55:02 eanna kernel: input: Winbond Electronics Corp Hermon
USB hidmouse Device as
/devices/pci0000:00/0000:00:14.5/usb9/9-1/9-1:1.1/0003:0557:2221.0002/input/input3
Oct 14 08:55:02 eanna kernel: usb 2-3.3: new full-speed USB device
number 3 using xhci_hcd
Oct 14 08:55:02 eanna kernel: hid-generic 0003:0557:2221.0002:
input,hidraw1: USB HID v1.00 Keyboard [Winbond Electronics Corp Hermon
USB hidmouse Device] on usb-0000:00:14.5-1/input1
Oct 14 08:55:02 eanna kernel: usb 6-3: new full-speed USB device
number 2 using ohci-pci
Oct 14 08:55:02 eanna kernel: usb 2-3.3: ep 0x81 - rounding interval
to 512 microframes, ep desc says 800 microframes
Oct 14 08:55:02 eanna kernel: hid-generic 0003:051D:0002.0003:
hiddev0,hidraw2: USB HID v1.00 Device [American Power Conversion
Back-UPS BX1500G FW:866.L5 .D USB FW:L5 ] on
usb-0000:41:00.0-3.3/input0
Oct 14 08:55:02 eanna kernel: usb 5-2: new low-speed USB device number
3 using ohci-pci
Oct 14 08:55:02 eanna kernel: usb 2-3.4: new high-speed USB device
number 4 using xhci_hcd
Oct 14 08:55:02 eanna kernel: input: Kensington      Kensington Expert
Mouse as /devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2:1.0/0003:047D:1020.0004/input/input4
Oct 14 08:55:02 eanna kernel: hid-generic 0003:047D:1020.0004:
input,hidraw3: USB HID v1.10 Mouse [Kensington      Kensington Expert
Mouse] on usb-0000:00:12.0-2/input0
Oct 14 08:55:02 eanna kernel: usb 5-1.2: new full-speed USB device
number 4 using ohci-pci
Oct 14 08:55:02 eanna kernel: input: HID 05f3:0007 as
/devices/pci0000:00/0000:00:12.0/usb5/5-1/5-1.2/5-1.2:1.0/0003:05F3:0007.0005/input/input5
Oct 14 08:55:02 eanna kernel: hid-generic 0003:05F3:0007.0005:
input,hidraw4: USB HID v1.00 Keyboard [HID 05f3:0007] on
usb-0000:00:12.0-1.2/input0
Oct 14 08:55:02 eanna kernel: input: HID 05f3:0007 as
/devices/pci0000:00/0000:00:12.0/usb5/5-1/5-1.2/5-1.2:1.1/0003:05F3:0007.0006/input/input6
Oct 14 08:55:02 eanna kernel: hid-generic 0003:05F3:0007.0006:
input,hidraw5: USB HID v1.00 Device [HID 05f3:0007] on
usb-0000:00:12.0-1.2/input1
Oct 14 08:55:02 eanna kernel: usb 5-1.4: new full-speed USB device
number 5 using ohci-pci
Oct 14 08:55:02 eanna kernel: usb 5-1.4: not running at top speed;
connect to a high speed hub
Oct 14 08:55:02 eanna kernel: hub 5-1.4:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 5-1.4:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: clocksource: Switched to clocksource tsc
Oct 14 08:55:02 eanna kernel: usb 5-1.4.1: new full-speed USB device
number 6 using ohci-pci
Oct 14 08:55:02 eanna kernel: usb 5-1.4.1: not running at top speed;
connect to a high speed hub
Oct 14 08:55:02 eanna kernel: mpt2sas0: host_add: handle(0x0001),
sas_addr(0x500304800bc18b00), phys(8)
Oct 14 08:55:02 eanna kernel: mpt2sas0: port enable: SUCCESS
Oct 14 08:55:02 eanna kernel: scsi 0:0:0:0: Direct-Access     ATA
Crucial_CT512M55 MU01 PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:0:0: SATA: handle(0x0009),
sas_addr(0x4433221100000000), phy(0), device_name(0x500a07510cc2b7d0)
Oct 14 08:55:02 eanna kernel: scsi 0:0:0:0: SATA:
enclosure_logical_id(0x500304800bc18b00), slot(0)
Oct 14 08:55:02 eanna kernel: scsi 0:0:0:0: atapi(n), ncq(y),
asyn_notify(n), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:1:0: Direct-Access     ATA
Crucial_CT512M55 MU01 PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:1:0: SATA: handle(0x000a),
sas_addr(0x4433221101000000), phy(1), device_name(0x500a07510cc6d954)
Oct 14 08:55:02 eanna kernel: scsi 0:0:1:0: SATA:
enclosure_logical_id(0x500304800bc18b00), slot(1)
Oct 14 08:55:02 eanna kernel: scsi 0:0:1:0: atapi(n), ncq(y),
asyn_notify(n), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:2:0: Direct-Access     ATA
Samsung SSD 840  6B0Q PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:2:0: SATA: handle(0x000b),
sas_addr(0x4433221104000000), phy(4), device_name(0x50025385a02ab540)
Oct 14 08:55:02 eanna kernel: scsi 0:0:2:0: SATA:
enclosure_logical_id(0x500304800bc18b00), slot(4)
Oct 14 08:55:02 eanna kernel: scsi 0:0:2:0: atapi(n), ncq(y),
asyn_notify(n), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:3:0: Direct-Access     ATA
Samsung SSD 840  6B0Q PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:3:0: SATA: handle(0x000c),
sas_addr(0x4433221105000000), phy(5), device_name(0x50025385a02ab564)
Oct 14 08:55:02 eanna kernel: scsi 0:0:3:0: SATA:
enclosure_logical_id(0x500304800bc18b00), slot(5)
Oct 14 08:55:02 eanna kernel: scsi 0:0:3:0: atapi(n), ncq(y),
asyn_notify(n), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:4:0: Direct-Access     ATA
Crucial_CT512M55 MU01 PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:4:0: SATA: handle(0x000d),
sas_addr(0x4433221102000000), phy(2), device_name(0x500a07510cc6e0d5)
Oct 14 08:55:02 eanna kernel: scsi 0:0:4:0: SATA:
enclosure_logical_id(0x500304800bc18b00), slot(2)
Oct 14 08:55:02 eanna kernel: scsi 0:0:4:0: atapi(n), ncq(y),
asyn_notify(n), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:5:0: Direct-Access     ATA
Samsung SSD 840  6B0Q PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:5:0: SATA: handle(0x000e),
sas_addr(0x4433221106000000), phy(6), device_name(0x50025385a02591d0)
Oct 14 08:55:02 eanna kernel: scsi 0:0:5:0: SATA:
enclosure_logical_id(0x500304800bc18b00), slot(6)
Oct 14 08:55:02 eanna kernel: scsi 0:0:5:0: atapi(n), ncq(y),
asyn_notify(n), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 1:0:0:0: Direct-Access     ATA
Samsung SSD 840  5B0Q PQ: 0 ANSI: 5
Oct 14 08:55:02 eanna kernel: scsi 2:0:0:0: Direct-Access     ATA
Samsung SSD 840  5B0Q PQ: 0 ANSI: 5
Oct 14 08:55:02 eanna kernel: scsi 6:0:0:0: CD-ROM            ATAPI
iHAS124   W      HL0A PQ: 0 ANSI: 5
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] physical block
alignment offset: 4096
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] 1000215216 512-byte
logical blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] 4096-byte physical blocks
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] physical block
alignment offset: 4096
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] 1000215216 512-byte
logical blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] 4096-byte physical blocks
Oct 14 08:55:02 eanna kernel: ata1.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] 1000215216 512-byte
logical blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] physical block
alignment offset: 4096
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] 1000215216 512-byte
logical blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] 4096-byte physical blocks
Oct 14 08:55:02 eanna kernel: ata2.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] 1000215216 512-byte
logical blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] Mode Sense: 00 3a 00 00
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] 1000215216 512-byte
logical blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] 1000215216 512-byte
logical blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: ata1.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: ata2.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] 1000215216 512-byte
logical blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel:  sdg:
Oct 14 08:55:02 eanna kernel: ata1.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] Attached SCSI disk
Oct 14 08:55:02 eanna kernel:  sdh:
Oct 14 08:55:02 eanna kernel: ata2.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sr 6:0:0:0: [sr0] scsi3-mmc drive:
188x/125x writer dvd-ram cd/rw xa/form2 cdda tray
Oct 14 08:55:02 eanna kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Oct 14 08:55:02 eanna kernel: sr 6:0:0:0: Attached scsi CD-ROM sr0
Oct 14 08:55:02 eanna kernel: raid6: sse2x1   gen()  5479 MB/s
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Oct 14 08:55:02 eanna kernel: raid6: sse2x1   xor()  3665 MB/s
Oct 14 08:55:02 eanna kernel: raid6: sse2x2   gen()  8838 MB/s
Oct 14 08:55:02 eanna kernel: raid6: sse2x2   xor()  5941 MB/s
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: raid6: sse2x4   gen() 10414 MB/s
Oct 14 08:55:02 eanna kernel: raid6: sse2x4   xor()  3761 MB/s
Oct 14 08:55:02 eanna kernel: raid6: using algorithm sse2x4 gen() 10414 MB/s
Oct 14 08:55:02 eanna kernel: raid6: .... xor() 3761 MB/s, rmw enabled
Oct 14 08:55:02 eanna kernel: raid6: using ssse3x2 recovery algorithm
Oct 14 08:55:02 eanna kernel: xor: automatically using best
checksumming function:
Oct 14 08:55:02 eanna kernel:    avx       :  3436.800 MB/sec
Oct 14 08:55:02 eanna kernel: Btrfs loaded
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 4 transid
344148 /dev/sdc
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 2 transid
344148 /dev/sdb
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 3 transid
344148 /dev/sde
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 1 transid
344148 /dev/sda
Oct 14 08:55:02 eanna kernel: BTRFS: device label system devid 1
transid 988898 /dev/sdg
Oct 14 08:55:02 eanna kernel: BTRFS: device label system devid 2
transid 988898 /dev/sdh
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 6 transid
344148 /dev/sdf
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 5 transid
344148 /dev/sdd
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdh): disk space
caching is enabled
Oct 14 08:55:02 eanna kernel: BTRFS: detected SSD devices, enabling SSD mode
Oct 14 08:55:02 eanna kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Oct 14 08:55:02 eanna systemd[1]: systemd 226 running in system mode.
(+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID -ELFUTILS
+KMOD +IDN)
Oct 14 08:55:02 eanna systemd[1]: Detected architecture x86-64.
Oct 14 08:55:02 eanna systemd[1]: Set hostname to <eanna>.
Oct 14 08:55:02 eanna systemd[1]: Configuration file
/etc/systemd/system/updatedb.service.d/updatedb.conf is marked
world-inaccessible. This has no effect as configuration data is
accessible via APIs without restrictions. Proceeding anyway.
Oct 14 08:55:02 eanna systemd[1]: Configuration file
/etc/systemd/system/sysstat-collect.service.d/sysstat-collect.conf is
marked world-inaccessible. This has no effect as configuration data is
accessible via APIs without restrictions. Proceeding anyway.
Oct 14 08:55:02 eanna systemd[1]: Reached target Login Prompts.
Oct 14 08:55:02 eanna systemd[1]: Listening on Journal Socket.
Oct 14 08:55:02 eanna systemd[1]: Reached target Encrypted Volumes.
Oct 14 08:55:02 eanna systemd[1]: Listening on udev Control Socket.
Oct 14 08:55:02 eanna systemd[1]: Listening on /dev/initctl
Compatibility Named Pipe.
Oct 14 08:55:02 eanna systemd[1]: Reached target Swap.
Oct 14 08:55:02 eanna systemd[1]: Created slice User and Session Slice.
Oct 14 08:55:02 eanna systemd[1]: Listening on udev Kernel Socket.
Oct 14 08:55:02 eanna systemd[1]: Created slice System Slice.
Oct 14 08:55:02 eanna systemd[1]: Mounting Debug File System...
Oct 14 08:55:02 eanna systemd[1]: Starting Load Kernel Modules...
Oct 14 08:55:02 eanna systemd[1]: Starting Remount Root and Kernel
File Systems...
Oct 14 08:55:02 eanna systemd[1]: Mounting Huge Pages File System...
Oct 14 08:55:02 eanna systemd[1]: Mounting POSIX Message Queue File System...
Oct 14 08:55:02 eanna systemd[1]: Mounting Temporary Directory...
Oct 14 08:55:02 eanna systemd[1]: Starting Create list of required
static device nodes for the current kernel...
Oct 14 08:55:02 eanna systemd[1]: Reached target Remote File Systems.
Oct 14 08:55:02 eanna systemd[1]: Starting Setup Virtual Console...
Oct 14 08:55:02 eanna systemd[1]: Created slice system-getty.slice.
Oct 14 08:55:02 eanna systemd[1]: Reached target Host and Network Name Lookups.
Oct 14 08:55:02 eanna systemd[1]: Created slice system-insync.slice.
Oct 14 08:55:02 eanna systemd[1]: Reached target RPC Port Mapper.
Oct 14 08:55:02 eanna systemd[1]: Set up automount Arbitrary
Executable File Formats File System Automount Point.
Oct 14 08:55:02 eanna systemd[1]: Starting Set Up Additional Binary Formats...
Oct 14 08:55:02 eanna systemd[1]: Started Dispatch Password Requests
to Console Directory Watch.
Oct 14 08:55:02 eanna systemd[1]: Listening on Journal Socket (/dev/log).
Oct 14 08:55:02 eanna systemd[1]: Listening on Device-mapper event daemon FIFOs.
Oct 14 08:55:02 eanna systemd[1]: Listening on LVM2 metadata daemon socket.
Oct 14 08:55:02 eanna systemd[1]: Started Forward Password Requests to
Wall Directory Watch.
Oct 14 08:55:02 eanna systemd[1]: Reached target Slices.
Oct 14 08:55:02 eanna systemd[1]: Starting Journal Service...
Oct 14 08:55:02 eanna systemd[1]: Mounting NFSD configuration filesystem...
Oct 14 08:55:02 eanna kernel: ipmi message handler version 39.2
Oct 14 08:55:02 eanna systemd[1]: Started Create list of required
static device nodes for the current kernel.
Oct 14 08:55:02 eanna systemd[1]: proc-sys-fs-binfmt_misc.automount:
Got automount request for /proc/sys/fs/binfmt_misc, triggered by 426
(systemd-binfmt)
Oct 14 08:55:02 eanna systemd[1]: Mounting Arbitrary Executable File
Formats File System...
Oct 14 08:55:02 eanna kernel: ipmi device interface
Oct 14 08:55:02 eanna kernel: IPMI System Interface driver.
Oct 14 08:55:02 eanna kernel: ipmi_si: probing via SMBIOS
Oct 14 08:55:02 eanna kernel: ipmi_si: SMBIOS: io 0xca2 regsize 1
spacing 1 irq 0
Oct 14 08:55:02 eanna kernel: ipmi_si: Adding SMBIOS-specified kcs state machine
Oct 14 08:55:02 eanna kernel: ipmi_si: Trying SMBIOS-specified kcs
state machine at i/o address 0xca2, slave address 0x0, irq 0
Oct 14 08:55:02 eanna systemd[1]: Mounted Arbitrary Executable File
Formats File System.
Oct 14 08:55:02 eanna systemd[1]: Mounted Debug File System.
Oct 14 08:55:02 eanna systemd[1]: Mounted POSIX Message Queue File System.
Oct 14 08:55:02 eanna systemd[1]: Mounted Temporary Directory.
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdh): enabling auto defrag
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdh): enabling inode
map caching
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdh): disk space
caching is enabled
Oct 14 08:55:02 eanna systemd[1]: Started Remount Root and Kernel File Systems.
Oct 14 08:55:02 eanna systemd[1]: Mounted Huge Pages File System.
Oct 14 08:55:02 eanna systemd[1]: Started Set Up Additional Binary Formats.
Oct 14 08:55:02 eanna systemd[1]: Starting Create Static Device Nodes in /dev...
Oct 14 08:55:02 eanna systemd[1]: Starting udev Coldplug all Devices...
Oct 14 08:55:02 eanna kernel: RPC: Registered named UNIX socket
transport module.
Oct 14 08:55:02 eanna kernel: RPC: Registered udp transport module.
Oct 14 08:55:02 eanna kernel: RPC: Registered tcp transport module.
Oct 14 08:55:02 eanna kernel: RPC: Registered tcp NFSv4.1 backchannel
transport module.
Oct 14 08:55:02 eanna kernel: Installing knfsd (copyright (C) 1996
okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
Oct 14 08:55:02 eanna systemd[1]: Mounted NFSD configuration filesystem.
Oct 14 08:55:02 eanna systemd[1]: Started Create Static Device Nodes in /dev.
Oct 14 08:55:02 eanna systemd[1]: Starting udev Kernel Device Manager...
Oct 14 08:55:02 eanna systemd[1]: Reached target Local File Systems (Pre).
Oct 14 08:55:02 eanna systemd[1]: Mounting /.bind...
Oct 14 08:55:02 eanna systemd[1]: Mounted /.bind.
Oct 14 08:55:02 eanna systemd[1]: Started Setup Virtual Console.
Oct 14 08:55:02 eanna systemd[1]: Started Journal Service.
Oct 14 08:55:02 eanna kernel: ipmi_si: The BMC does not support
clearing the recv irq bit, compensating, but the BMC needs to be
fixed.
Oct 14 08:55:02 eanna kernel: ACPI: acpi_idle registered with cpuidle
Oct 14 08:55:02 eanna kernel: shpchp: Standard Hot Plug PCI Controller
Driver version: 0.4
Oct 14 08:55:02 eanna kernel: input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input7
Oct 14 08:55:02 eanna kernel: ACPI: Power Button [PWRB]
Oct 14 08:55:02 eanna kernel: input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input8
Oct 14 08:55:02 eanna kernel: ACPI: Power Button [PWRF]
Oct 14 08:55:02 eanna kernel: acpi-cpufreq: overriding BIOS provided _PSD data
Oct 14 08:55:02 eanna kernel: MCE: In-kernel MCE decoding enabled.
Oct 14 08:55:02 eanna kernel: dca service started, version 1.12.1
Oct 14 08:55:02 eanna kernel: pps_core: LinuxPPS API ver. 1 registered
Oct 14 08:55:02 eanna kernel: pps_core: Software ver. 5.3.6 -
Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Oct 14 08:55:02 eanna kernel: piix4_smbus 0000:00:14.0: SMBus Host
Controller at 0xb00, revision 0
Oct 14 08:55:02 eanna kernel: piix4_smbus 0000:00:14.0: Auxiliary
SMBus Host Controller at 0xb20
Oct 14 08:55:02 eanna kernel: PTP clock support registered
Oct 14 08:55:02 eanna kernel: EDAC MC: Ver: 3.0.0
Oct 14 08:55:02 eanna kernel: input: PC Speaker as
/devices/platform/pcspkr/input/input9
Oct 14 08:55:02 eanna kernel: AMD64 EDAC driver v3.4.0
Oct 14 08:55:02 eanna kernel: EDAC amd64: DRAM ECC enabled.
Oct 14 08:55:02 eanna kernel: EDAC amd64: F15h detected (node 0).
Oct 14 08:55:02 eanna kernel: EDAC MC: DCT0 chip selects:
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 0:     0MB 1:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 2:  8192MB 3:  8192MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 4:     0MB 5:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 6:     0MB 7:     0MB
Oct 14 08:55:02 eanna kernel: EDAC MC: DCT1 chip selects:
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 0:     0MB 1:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 2:  8192MB 3:  8192MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 4:     0MB 5:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 6:     0MB 7:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: using x8 syndromes.
Oct 14 08:55:02 eanna kernel: EDAC amd64: MCT channel count: 2
Oct 14 08:55:02 eanna kernel: sp5100_tco: SP5100/SB800 TCO WatchDog
Timer Driver v0.05
Oct 14 08:55:02 eanna kernel: sp5100_tco: PCI Revision ID: 0x3d
Oct 14 08:55:02 eanna kernel: sp5100_tco: failed to find MMIO address,
giving up.
Oct 14 08:55:02 eanna kernel: EDAC MC0: Giving out device to module
amd64_edac controller F15h: DEV 0000:00:18.2 (INTERRUPT)
Oct 14 08:55:02 eanna kernel: EDAC amd64: DRAM ECC disabled.
Oct 14 08:55:02 eanna kernel: EDAC amd64: ECC disabled in the BIOS or
no ECC capability, module will not load.
                               Either enable ECC checking or force
module loading by setting 'ecc_enable_override'.
                               (Note that use of the override may
cause unknown side effects.)
Oct 14 08:55:02 eanna kernel: EDAC amd64: DRAM ECC enabled.
Oct 14 08:55:02 eanna kernel: EDAC amd64: F15h detected (node 2).
Oct 14 08:55:02 eanna kernel: EDAC MC: DCT0 chip selects:
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 0:     0MB 1:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 2:  8192MB 3:  8192MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 4:     0MB 5:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 6:     0MB 7:     0MB
Oct 14 08:55:02 eanna kernel: EDAC MC: DCT1 chip selects:
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 0:     0MB 1:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 2:  8192MB 3:  8192MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 4:     0MB 5:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 6:     0MB 7:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: using x8 syndromes.
Oct 14 08:55:02 eanna kernel: EDAC amd64: MCT channel count: 2
Oct 14 08:55:02 eanna kernel: EDAC MC2: Giving out device to module
amd64_edac controller F15h: DEV 0000:00:1a.2 (INTERRUPT)
Oct 14 08:55:02 eanna kernel: EDAC amd64: DRAM ECC disabled.
Oct 14 08:55:02 eanna kernel: EDAC amd64: ECC disabled in the BIOS or
no ECC capability, module will not load.
                               Either enable ECC checking or force
module loading by setting 'ecc_enable_override'.
                               (Note that use of the override may
cause unknown side effects.)
Oct 14 08:55:02 eanna kernel: EDAC PCI0: Giving out device to module
amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
Oct 14 08:55:02 eanna kernel: igb: Intel(R) Gigabit Ethernet Network
Driver - version 5.2.18-k
Oct 14 08:55:02 eanna kernel: igb: Copyright (c) 2007-2014 Intel Corporation.
Oct 14 08:55:02 eanna kernel: [drm] Initialized drm 1.1.0 20060810
Oct 14 08:55:02 eanna kernel: snd_hda_intel 0000:42:00.1: Handle
VGA-switcheroo audio client
Oct 14 08:55:02 eanna kernel: snd_hda_intel 0000:42:00.1: Force to
non-snoop mode
Oct 14 08:55:02 eanna kernel: AVX version of gcm_enc/dec engaged.
Oct 14 08:55:02 eanna kernel: AES CTR mode by8 optimization enabled
Oct 14 08:55:02 eanna kernel: [drm] radeon kernel modesetting enabled.
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver usbserial
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver
usbserial_generic
Oct 14 08:55:02 eanna kernel: usbserial: USB Serial support registered
for generic
Oct 14 08:55:02 eanna kernel: mousedev: PS/2 mouse device common for all mice
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=3 as
/devices/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input11
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=7 as
/devices/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input12
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=8 as
/devices/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input13
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=9 as
/devices/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input14
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=10 as
/devices/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input15
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=11 as
/devices/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input16
Oct 14 08:55:02 eanna kernel: AMD IOMMUv2 driver by Joerg Roedel
<jroedel-l3A5Bk7waGM@public.gmane.org>
Oct 14 08:55:02 eanna kernel: AMD IOMMUv2 functionality not available
on this system
Oct 14 08:55:02 eanna kernel: kvm: Nested Virtualization enabled
Oct 14 08:55:02 eanna kernel: kvm: Nested Paging enabled
Oct 14 08:55:02 eanna kernel: CRAT table not found
Oct 14 08:55:02 eanna kernel: Finished initializing topology ret=0
Oct 14 08:55:02 eanna kernel: kfd kfd: Initialized module
Oct 14 08:55:02 eanna kernel: checking generic (c0000000 7f0000) vs hw
(c0000000 10000000)
Oct 14 08:55:02 eanna kernel: fb: switching to radeondrmfb from VESA VGA
Oct 14 08:55:02 eanna kernel: Console: switching to colour dummy device 80x25
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver cp210x
Oct 14 08:55:02 eanna kernel: usbserial: USB Serial support registered
for cp210x
Oct 14 08:55:02 eanna kernel: cp210x 6-3:1.0: cp210x converter detected
Oct 14 08:55:02 eanna kernel: usb 6-3: cp210x converter now attached to ttyUSB0
Oct 14 08:55:02 eanna kernel: [drm] initializing kernel modesetting
(TAHITI 0x1002:0x679A 0x103C:0x6617).
Oct 14 08:55:02 eanna kernel: [drm] register mmio base: 0xDBFC0000
Oct 14 08:55:02 eanna kernel: [drm] register mmio size: 262144
Oct 14 08:55:02 eanna kernel: media: Linux media interface: v0.10
Oct 14 08:55:02 eanna kernel: ATOM BIOS: Tahiti
Oct 14 08:55:02 eanna kernel: [drm] Changing default dispclk from
500Mhz to 600Mhz
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: VRAM: 3072M
0x0000000000000000 - 0x00000000BFFFFFFF (3072M used)
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: GTT: 2048M
0x00000000C0000000 - 0x000000013FFFFFFF
Oct 14 08:55:02 eanna kernel: [drm] Detected VRAM RAM=3072M, BAR=256M
Oct 14 08:55:02 eanna kernel: [drm] RAM width 384bits DDR
Oct 14 08:55:02 eanna kernel: [TTM] Zone  kernel: Available graphics
memory: 32981114 kiB
Oct 14 08:55:02 eanna kernel: [TTM] Zone   dma32: Available graphics
memory: 2097152 kiB
Oct 14 08:55:02 eanna kernel: [TTM] Initializing pool allocator
Oct 14 08:55:02 eanna kernel: [TTM] Initializing DMA pool allocator
Oct 14 08:55:02 eanna kernel: [drm] radeon: 3072M of VRAM memory ready
Oct 14 08:55:02 eanna kernel: [drm] radeon: 2048M of GTT memory ready.
Oct 14 08:55:02 eanna kernel: [drm] Loading tahiti Microcode
Oct 14 08:55:02 eanna kernel: Linux video capture interface: v2.00
Oct 14 08:55:02 eanna kernel: [drm] Internal thermal controller with fan control
Oct 14 08:55:02 eanna kernel: [drm] probing gen 2 caps for device
1002:5a16 = 31cd02/0
Oct 14 08:55:02 eanna kernel: [drm] radeon: dpm initialized
Oct 14 08:55:02 eanna kernel: [drm] Found VCE firmware/feedback
version 50.0.1 / 17!
Oct 14 08:55:02 eanna kernel: [drm] GART: num cpu pages 524288, num
gpu pages 524288
Oct 14 08:55:02 eanna kernel: uvcvideo: Found UVC 1.00 device HD Pro
Webcam C920 (046d:082d)
Oct 14 08:55:02 eanna kernel: [drm] probing gen 2 caps for device
1002:5a16 = 31cd02/0
Oct 14 08:55:02 eanna kernel: [drm] PCIE gen 2 link speeds already enabled
Oct 14 08:55:02 eanna kernel: input: HD Pro Webcam C920 as
/devices/pci0000:40/0000:40:04.0/0000:41:00.0/usb2/2-3/2-3.4/2-3.4:1.0/input/input17
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver uvcvideo
Oct 14 08:55:02 eanna kernel: USB Video Class driver (1.1.1)
Oct 14 08:55:02 eanna kernel: [drm] PCIE GART of 2048M enabled (table
at 0x00000000002E8000).
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: WB enabled
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on
ring 0 use gpu addr 0x00000000c0000c00 and cpu addr 0xffff8810133dac00
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on
ring 1 use gpu addr 0x00000000c0000c04 and cpu addr 0xffff8810133dac04
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on
ring 2 use gpu addr 0x00000000c0000c08 and cpu addr 0xffff8810133dac08
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on
ring 3 use gpu addr 0x00000000c0000c0c and cpu addr 0xffff8810133dac0c
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on
ring 4 use gpu addr 0x00000000c0000c10 and cpu addr 0xffff8810133dac10
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on
ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0xffffc90007035a18
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on
ring 6 use gpu addr 0x00000000c0000c18 and cpu addr 0xffff8810133dac18
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on
ring 7 use gpu addr 0x00000000c0000c1c and cpu addr 0xffff8810133dac1c
Oct 14 08:55:02 eanna kernel: [drm] Supports vblank timestamp caching
Rev 2 (21.10.2013).
Oct 14 08:55:02 eanna kernel: [drm] Driver supports precise vblank
timestamp query.
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: radeon: MSI limited to 32-bit
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: radeon: using MSI.
Oct 14 08:55:02 eanna kernel: [drm] radeon: irq initialized.
Oct 14 08:55:02 eanna kernel: ipmi_si ipmi_si.0: Found new BMC
(man_id: 0x00b980, prod_id: 0xbc11, dev_id: 0x20)
Oct 14 08:55:02 eanna kernel: ipmi_si ipmi_si.0: IPMI kcs interface initialized
Oct 14 08:55:02 eanna kernel: FS-Cache: Loaded
Oct 14 08:55:02 eanna kernel: FS-Cache: Netfs 'nfs' registered for caching
Oct 14 08:55:02 eanna kernel: usb 5-1.4.1: reset full-speed USB device
number 6 using ohci-pci
Oct 14 08:55:02 eanna kernel: input: Xonar DSX Headphone as
/devices/pci0000:00/0000:00:04.0/0000:05:00.0/0000:06:00.0/sound/card0/input18
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdd): enabling auto defrag
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdd): use ssd allocation scheme
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdd): enabling inode
map caching
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdd): disk space
caching is enabled
Oct 14 08:55:02 eanna kernel: BTRFS: has skinny extents
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver
snd-usb-audio
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: added PHC on eth0
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: Intel(R) Gigabit
Ethernet Network Connection
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: eth0:
(PCIe:2.5Gb/s:Width x4) 00:25:90:ad:a3:bc
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: eth0: PBA No: Unknown
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: Using MSI-X
interrupts. 8 rx queue(s), 8 tx queue(s)
Oct 14 08:55:02 eanna kernel: [drm] ring test on 0 succeeded in 1 usecs
Oct 14 08:55:02 eanna kernel: [drm] ring test on 1 succeeded in 1 usecs
Oct 14 08:55:02 eanna kernel: [drm] ring test on 2 succeeded in 1 usecs
Oct 14 08:55:02 eanna kernel: [drm] ring test on 3 succeeded in 3 usecs
Oct 14 08:55:02 eanna kernel: [drm] ring test on 4 succeeded in 3 usecs
Oct 14 08:55:02 eanna kernel: ieee80211 phy0: rt2x00_set_rt: Info - RT
chipset 3070, rev 0201 detected
Oct 14 08:55:02 eanna kernel: [drm] ring test on 5 succeeded in 2 usecs
Oct 14 08:55:02 eanna kernel: [drm] UVD initialized successfully.
Oct 14 08:55:03 eanna kernel: [drm] ring test on 6 succeeded in 18 usecs
Oct 14 08:55:03 eanna kernel: [drm] ring test on 7 succeeded in 4 usecs
Oct 14 08:55:03 eanna kernel: [drm] VCE initialized successfully.
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 0 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 1 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 2 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 3 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 4 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: added PHC on eth1
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: Intel(R) Gigabit
Ethernet Network Connection
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: eth1:
(PCIe:2.5Gb/s:Width x4) 00:25:90:ad:a3:bd
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: eth1: PBA No: Unknown
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: Using MSI-X
interrupts. 8 rx queue(s), 8 tx queue(s)
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1 enp2s0f1: renamed from eth1
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.0 enp2s0f0: renamed from eth0
Oct 14 08:55:03 eanna kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF
chipset 0005 detected
Oct 14 08:55:03 eanna kernel: ieee80211 phy0: Selected rate control
algorithm 'minstrel_ht'
Oct 14 08:55:03 eanna kernel: usbcore: registered new interface driver rt2800usb
Oct 14 08:55:03 eanna kernel: rt2800usb 5-1.4.1:1.0 wlp0s18f0u1u4u1:
renamed from wlan0
Oct 14 08:55:03 eanna kernel: microcode: CPU0: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU2: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU4: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU6: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU8: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU10: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU12: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU14: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU16: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU18: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU20: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU22: new patch_level=0x06000832
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 5 succeeded
Oct 14 08:55:03 eanna kernel: random: nonblocking pool is initialized
Oct 14 08:55:03 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): enp2s0f1:
link is not ready
Oct 14 08:55:04 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): enp2s0f1:
link is not ready
Oct 14 08:55:04 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): enp2s0f0:
link is not ready
Oct 14 08:55:04 eanna kernel: [drm] ib test on ring 6 succeeded
Oct 14 08:55:04 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): enp2s0f0:
link is not ready
Oct 14 08:55:04 eanna kernel: IPv6: ADDRCONF(NETDEV_UP):
wlp0s18f0u1u4u1: link is not ready
Oct 14 08:55:04 eanna kernel: [drm] ib test on ring 7 succeeded
Oct 14 08:55:04 eanna kernel: [drm] Radeon Display Connectors
Oct 14 08:55:04 eanna kernel: [drm] Connector 0:
Oct 14 08:55:04 eanna kernel: [drm]   DP-1
Oct 14 08:55:04 eanna kernel: [drm]   HPD5
Oct 14 08:55:04 eanna kernel: [drm]   DDC: 0x6530 0x6530 0x6534 0x6534
0x6538 0x6538 0x653c 0x653c
Oct 14 08:55:04 eanna kernel: [drm]   Encoders:
Oct 14 08:55:04 eanna kernel: [drm]     DFP1: INTERNAL_UNIPHY2
Oct 14 08:55:04 eanna kernel: [drm] Connector 1:
Oct 14 08:55:04 eanna kernel: [drm]   DP-2
Oct 14 08:55:04 eanna kernel: [drm]   HPD4
Oct 14 08:55:04 eanna kernel: [drm]   DDC: 0x6540 0x6540 0x6544 0x6544
0x6548 0x6548 0x654c 0x654c
Oct 14 08:55:04 eanna kernel: [drm]   Encoders:
Oct 14 08:55:04 eanna kernel: [drm]     DFP2: INTERNAL_UNIPHY2
Oct 14 08:55:04 eanna kernel: [drm] Connector 2:
Oct 14 08:55:04 eanna kernel: [drm]   HDMI-A-1
Oct 14 08:55:04 eanna kernel: [drm]   HPD1
Oct 14 08:55:04 eanna kernel: [drm]   DDC: 0x6560 0x6560 0x6564 0x6564
0x6568 0x6568 0x656c 0x656c
Oct 14 08:55:04 eanna kernel: [drm]   Encoders:
Oct 14 08:55:04 eanna kernel: [drm]     DFP3: INTERNAL_UNIPHY1
Oct 14 08:55:04 eanna kernel: [drm] Connector 3:
Oct 14 08:55:04 eanna kernel: [drm]   DVI-I-1
Oct 14 08:55:04 eanna kernel: [drm]   HPD3
Oct 14 08:55:04 eanna kernel: [drm]   DDC: 0x6580 0x6580 0x6584 0x6584
0x6588 0x6588 0x658c 0x658c
Oct 14 08:55:04 eanna kernel: [drm]   Encoders:
Oct 14 08:55:04 eanna kernel: [drm]     DFP4: INTERNAL_UNIPHY
Oct 14 08:55:04 eanna kernel: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Oct 14 08:55:04 eanna kernel: traps: gnome-shell[799] trap int3
ip:7f8318c2364b sp:7ffe75fa77c0 error:0
Oct 14 08:55:04 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI
ATI/AMD: no speaker allocation for ELD
Oct 14 08:55:04 eanna kernel: fuse init (API version 7.23)
Oct 14 08:55:04 eanna kernel: [drm] fb mappable at 0xC06EA000
Oct 14 08:55:04 eanna kernel: [drm] vram apper at 0xC0000000
Oct 14 08:55:04 eanna kernel: [drm] size 8294400
Oct 14 08:55:04 eanna kernel: [drm] fb depth is 24
Oct 14 08:55:04 eanna kernel: [drm]    pitch is 7680
Oct 14 08:55:04 eanna kernel: fbcon: radeondrmfb (fb0) is primary device
Oct 14 08:55:05 eanna kernel: Console: switching to colour frame
buffer device 240x67
Oct 14 08:55:05 eanna kernel: radeon 0000:42:00.0: fb0: radeondrmfb
frame buffer device
Oct 14 08:55:05 eanna kernel: radeon 0000:42:00.0: registered panic notifier
Oct 14 08:55:05 eanna kernel: [drm] Initialized radeon 2.43.0 20080528
for 0000:42:00.0 on minor 0
Oct 14 08:55:05 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI
ATI/AMD: no speaker allocation for ELD
Oct 14 08:55:05 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI
ATI/AMD: no speaker allocation for ELD
Oct 14 08:55:05 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI
ATI/AMD: no speaker allocation for ELD
Oct 14 08:55:06 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI
ATI/AMD: no speaker allocation for ELD
Oct 14 08:55:06 eanna kernel: igb 0000:02:00.1 enp2s0f1: igb: enp2s0f1
NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
Oct 14 08:55:06 eanna kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f1:
link becomes ready
Oct 14 08:55:08 eanna kernel: usb 2-3.4: reset high-speed USB device
number 4 using xhci_hcd
Oct 14 08:55:11 eanna kernel: NFSD: starting 90-second grace period
(net ffffffff818aed80)
Oct 14 08:55:12 eanna kernel: ip6_tables: (C) 2000-2006 Netfilter Core Team
Oct 14 08:55:12 eanna kernel: Ebtables v2.0 registered
Oct 14 08:55:12 eanna kernel: bridge: automatic filtering via
arp/ip/ip6tables has been deprecated. Update your scripts to load
br_netfilter if you need this.
Oct 14 08:55:12 eanna kernel: tun: Universal TUN/TAP device driver, 1.6
Oct 14 08:55:12 eanna kernel: tun: (C) 1999-2004 Max Krasnyansky
<maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
Oct 14 08:55:12 eanna kernel: device virbr0-nic entered promiscuous mode
Oct 14 08:55:12 eanna kernel: nf_conntrack version 0.5.0 (65536
buckets, 262144 max)
Oct 14 08:55:13 eanna kernel: virbr0: port 1(virbr0-nic) entered listening state
Oct 14 08:55:13 eanna kernel: virbr0: port 1(virbr0-nic) entered listening state
Oct 14 08:55:13 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): virbr0: link
is not ready
Oct 14 08:55:13 eanna kernel: virbr0: port 1(virbr0-nic) entered disabled state
Oct 14 08:55:13 eanna kernel: device vnet0 entered promiscuous mode
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered listening state
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered listening state
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered disabled state
Oct 14 08:55:13 eanna kernel: device vnet0 left promiscuous mode
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered disabled state
Oct 14 08:55:13 eanna kernel: device vnet0 entered promiscuous mode
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered listening state
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered listening state
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered disabled state
Oct 14 08:55:13 eanna kernel: device vnet0 left promiscuous mode
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered disabled state
Oct 14 08:55:18 eanna kernel: usb 2-3.4: reset high-speed USB device
number 4 using xhci_hcd




On Wed, Oct 14, 2015 at 2:06 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Sat, Oct 03, 2015 at 05:19:25PM -0700, G. Richard Bellamy wrote:
> > What happens: Kernel logs message to journal, kvm VMs no longer work.
> Kernel messages spew at a rate of ~660/sec.
>
> The problem is that device 00:14.0 is trying to write to the system
> management area and is forbidden to do so by the IOMMU. Can you please
> boot with amd_iommu_dump on the kernel command line and send me dmesg?
>
>
> Thanks,
>
>         Joerg
>
>

--001a11c3e9accae47a052212b957
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">When I have &quot;iommu=3D1 iommu=3Dpt amd_iommu_dump=3D1&quot;=
 on my Kernel command line, the messages spam the log so much neither dmesg=
 nor the journal can keep up.<br><br></div><div class=3D"gmail_default" sty=
le=3D"font-family:verdana,sans-serif">In the journal, I see &quot;systemd-j=
ournal[427]: Missed 1131 kernel messages&quot; and the dmesg buffer is full=
 of the INVALID_DEVICE_REQUEST messages.<br><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:verdana,sans-serif">I then tried just &quot;am=
d_iommu_dump=3D1&quot; (without the other iommu parameters). That produced =
the following (which doesn&#39;t seem to have the dump you asked for). If i=
t doesn&#39;t have what you asked for, what should I do next to make sure I=
 can get it to you?<br><br><pre style=3D"color:rgb(0,0,0);font-style:normal=
;font-variant:normal;font-weight:normal;letter-spacing:normal;line-height:n=
ormal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px=
;word-wrap:break-word;white-space:pre-wrap">-- Logs begin at Fri 2014-04-04=
 16:19:07 PDT, end at Wed 2015-10-14 08:56:58 PDT. --
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys cpuset
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys cpu
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys cpuacct
Oct 14 08:55:02 eanna kernel: Linux version 4.2.2-1-ARCH (builduser@tobias)=
 (gcc version 5.2.0 (GCC) ) #1 SMP PREEMPT Tue Sep 29 22:21:33 CEST 2015
Oct 14 08:55:02 eanna kernel: Command line: BOOT_IMAGE=3D/__system/ROOT/boo=
t/vmlinuz-linux root=3DUUID=3D06acfd0f-314d-457f-ba00-f96bf5b94a02 rw rootf=
lags=3Dsubvol=3D__system/ROOT quiet acpi_osi=3DLinux amd_iommu_dump=3D1 tra=
nsparent_hugepage=3Dnever
Oct 14 08:55:02 eanna kernel: tseg: 00bff00000
Oct 14 08:55:02 eanna kernel: x86/fpu: xstate_offset[2]: 0240, xstate_sizes=
[2]: 0100
Oct 14 08:55:02 eanna kernel: x86/fpu: Supporting XSAVE feature 0x01: &#39;=
x87 floating point registers&#39;
Oct 14 08:55:02 eanna kernel: x86/fpu: Supporting XSAVE feature 0x02: &#39;=
SSE registers&#39;
Oct 14 08:55:02 eanna kernel: x86/fpu: Supporting XSAVE feature 0x04: &#39;=
AVX registers&#39;
Oct 14 08:55:02 eanna kernel: x86/fpu: Enabled xstate features 0x7, context=
 size is 0x340 bytes, using &#39;standard&#39; format.
Oct 14 08:55:02 eanna kernel: x86/fpu: Using &#39;lazy&#39; FPU context swi=
tches.
Oct 14 08:55:02 eanna kernel: e820: BIOS-provided physical RAM map:
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x0000000000000000-0x00000000=
000947ff] usable
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x0000000000094800-0x00000000=
0009ffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x00000000000e6000-0x00000000=
000fffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000=
bfe7ffff] usable
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x00000000bfe8e000-0x00000000=
bfe8ffff] type 9
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x00000000bfe90000-0x00000000=
bfeb3fff] ACPI data
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x00000000bfeb4000-0x00000000=
bfedffff] ACPI NVS
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x00000000bfee0000-0x00000000=
bfffffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x00000000e0000000-0x00000000=
efffffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x00000000ffe00000-0x00000000=
ffffffff] reserved
Oct 14 08:55:02 eanna kernel: BIOS-e820: [mem 0x0000000100000000-0x00000010=
3effffff] usable
Oct 14 08:55:02 eanna kernel: NX (Execute Disable) protection: active
Oct 14 08:55:02 eanna kernel: SMBIOS 2.6 present.
Oct 14 08:55:02 eanna kernel: DMI: Supermicro H8DG6/H8DGi/H8DG6/H8DGi, BIOS=
 3.5        11/25/2013
Oct 14 08:55:02 eanna kernel: e820: update [mem 0x00000000-0x00000fff] usab=
le =3D=3D&gt; reserved
Oct 14 08:55:02 eanna kernel: e820: remove [mem 0x000a0000-0x000fffff] usab=
le
Oct 14 08:55:02 eanna kernel: AGP: No AGP bridge found
Oct 14 08:55:02 eanna kernel: e820: last_pfn =3D 0x103f000 max_arch_pfn =3D=
 0x400000000
Oct 14 08:55:02 eanna kernel: MTRR default type: uncachable
Oct 14 08:55:02 eanna kernel: MTRR fixed ranges enabled:
Oct 14 08:55:02 eanna kernel:   00000-9FFFF write-back
Oct 14 08:55:02 eanna kernel:   A0000-EFFFF uncachable
Oct 14 08:55:02 eanna kernel:   F0000-FFFFF write-protect
Oct 14 08:55:02 eanna kernel: MTRR variable ranges enabled:
Oct 14 08:55:02 eanna kernel:   0 base 000000000000 mask FFFF80000000 write=
-back
Oct 14 08:55:02 eanna kernel:   1 base 000080000000 mask FFFFC0000000 write=
-back
Oct 14 08:55:02 eanna kernel:   2 disabled
Oct 14 08:55:02 eanna kernel:   3 disabled
Oct 14 08:55:02 eanna kernel:   4 disabled
Oct 14 08:55:02 eanna kernel:   5 disabled
Oct 14 08:55:02 eanna kernel:   6 disabled
Oct 14 08:55:02 eanna kernel:   7 disabled
Oct 14 08:55:02 eanna kernel: TOM2: 000000103f000000 aka 66544M
Oct 14 08:55:02 eanna kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC =
 WB  WC  UC- WT =20
Oct 14 08:55:02 eanna kernel: e820: update [mem 0xc0000000-0xffffffff] usab=
le =3D=3D&gt; reserved
Oct 14 08:55:02 eanna kernel: e820: last_pfn =3D 0xbfe80 max_arch_pfn =3D 0=
x400000000
Oct 14 08:55:02 eanna kernel: found SMP MP-table at [mem 0x000ff780-0x000ff=
78f] mapped at [ffff8800000ff780]
Oct 14 08:55:02 eanna kernel: Scanning 1 areas for low memory corruption
Oct 14 08:55:02 eanna kernel: Base memory trampoline at [ffff88000008e000] =
8e000 size 24576
Oct 14 08:55:02 eanna kernel: Using GB pages for direct mapping
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem 0x00000000-0x000fff=
ff]
Oct 14 08:55:02 eanna kernel:  [mem 0x00000000-0x000fffff] page 4k
Oct 14 08:55:02 eanna kernel: BRK [0x01b36000, 0x01b36fff] PGTABLE
Oct 14 08:55:02 eanna kernel: BRK [0x01b37000, 0x01b37fff] PGTABLE
Oct 14 08:55:02 eanna kernel: BRK [0x01b38000, 0x01b38fff] PGTABLE
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem 0x103ee00000-0x103e=
ffffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x103ee00000-0x103effffff] page 2M
Oct 14 08:55:02 eanna kernel: BRK [0x01b39000, 0x01b39fff] PGTABLE
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem 0x1020000000-0x103e=
dfffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x1020000000-0x103edfffff] page 2M
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem 0x1000000000-0x101f=
ffffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x1000000000-0x101fffffff] page 2M
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem 0x00100000-0xbfe7ff=
ff]
Oct 14 08:55:02 eanna kernel:  [mem 0x00100000-0x001fffff] page 4k
Oct 14 08:55:02 eanna kernel:  [mem 0x00200000-0x3fffffff] page 2M
Oct 14 08:55:02 eanna kernel:  [mem 0x40000000-0x7fffffff] page 1G
Oct 14 08:55:02 eanna kernel:  [mem 0x80000000-0xbfdfffff] page 2M
Oct 14 08:55:02 eanna kernel:  [mem 0xbfe00000-0xbfe7ffff] page 4k
Oct 14 08:55:02 eanna kernel: init_memory_mapping: [mem 0x100000000-0xfffff=
ffff]
Oct 14 08:55:02 eanna kernel:  [mem 0x100000000-0xfffffffff] page 1G
Oct 14 08:55:02 eanna kernel: RAMDISK: [mem 0x377de000-0x37be6fff]
Oct 14 08:55:02 eanna kernel: ACPI: Early table checksum verification disab=
led
Oct 14 08:55:02 eanna kernel: ACPI: RSDP 0x00000000000FA650 000024 (v02 ACP=
IAM)
Oct 14 08:55:02 eanna kernel: ACPI: XSDT 0x00000000BFE90100 00008C (v01 SMC=
I            20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: FACP 0x00000000BFE90290 0000F4 (v04 112=
513 FACP1100 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI BIOS Warning (bug): 32/64X length mismat=
ch in FADT/Gpe0Block: 64/32 (20150619/tbfadt-623)
Oct 14 08:55:02 eanna kernel: ACPI: DSDT 0x00000000BFE906C0 006ACE (v02 1BC=
11  1BC11000 00000000 INTL 20051117)
Oct 14 08:55:02 eanna kernel: ACPI: FACS 0x00000000BFEB4000 000040
Oct 14 08:55:02 eanna kernel: ACPI: FACS 0x00000000BFEB4000 000040
Oct 14 08:55:02 eanna kernel: ACPI: APIC 0x00000000BFE90390 000170 (v02 112=
513 APIC1100 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: MCFG 0x00000000BFE90500 00003C (v01 112=
513 OEMMCFG  20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: OEMB 0x00000000BFEB4040 0000BC (v01 112=
513 OEMB1100 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: HPET 0x00000000BFE9A6C0 000038 (v01 112=
513 OEMHPET  20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: IVRS 0x00000000BFE9A700 000100 (v01 AMD=
    RD890S   00202031 AMD  00000000)
Oct 14 08:55:02 eanna kernel: ACPI: SRAT 0x00000000BFE9A800 000250 (v02 AMD=
    AGESA    00000001 AMD  00000001)
Oct 14 08:55:02 eanna kernel: ACPI: SLIT 0x00000000BFE9AA50 00003C (v01 AMD=
    AGESA    00000001 AMD  00000001)
Oct 14 08:55:02 eanna kernel: ACPI: SSDT 0x00000000BFE9AA90 0044F4 (v01 A M=
 I  POWERNOW 00000001 AMD  00000001)
Oct 14 08:55:02 eanna kernel: ACPI: EINJ 0x00000000BFE9EF90 000130 (v01 AMI=
ER  AMI_EINJ 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: BERT 0x00000000BFE9F120 000030 (v01 AMI=
ER  AMI_BERT 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: ERST 0x00000000BFE9F150 000210 (v01 AMI=
ER  AMI_ERST 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: HEST 0x00000000BFE9F360 0000A8 (v01 AMI=
ER  ABC_HEST 20131125 MSFT 00000097)
Oct 14 08:55:02 eanna kernel: ACPI: Local APIC address 0xfee00000
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -&gt; APIC 0x20 -&gt; Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -&gt; APIC 0x21 -&gt; Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -&gt; APIC 0x22 -&gt; Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -&gt; APIC 0x23 -&gt; Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -&gt; APIC 0x24 -&gt; Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 0 -&gt; APIC 0x25 -&gt; Node 0
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -&gt; APIC 0x26 -&gt; Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -&gt; APIC 0x27 -&gt; Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -&gt; APIC 0x28 -&gt; Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -&gt; APIC 0x29 -&gt; Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -&gt; APIC 0x2a -&gt; Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 1 -&gt; APIC 0x2b -&gt; Node 1
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -&gt; APIC 0x40 -&gt; Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -&gt; APIC 0x41 -&gt; Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -&gt; APIC 0x42 -&gt; Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -&gt; APIC 0x43 -&gt; Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -&gt; APIC 0x44 -&gt; Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 2 -&gt; APIC 0x45 -&gt; Node 2
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -&gt; APIC 0x46 -&gt; Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -&gt; APIC 0x47 -&gt; Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -&gt; APIC 0x48 -&gt; Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -&gt; APIC 0x49 -&gt; Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -&gt; APIC 0x4a -&gt; Node 3
Oct 14 08:55:02 eanna kernel: SRAT: PXM 3 -&gt; APIC 0x4b -&gt; Node 3
Oct 14 08:55:02 eanna kernel: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff=
]
Oct 14 08:55:02 eanna kernel: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff=
]
Oct 14 08:55:02 eanna kernel: SRAT: Node 0 PXM 0 [mem 0x100000000-0x83fffff=
ff]
Oct 14 08:55:02 eanna kernel: SRAT: Node 2 PXM 2 [mem 0x840000000-0x103efff=
fff]
Oct 14 08:55:02 eanna kernel: NUMA: Initialized distance table, cnt=3D4
Oct 14 08:55:02 eanna kernel: NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [m=
em 0x00100000-0xbfffffff] -&gt; [mem 0x00000000-0xbfffffff]
Oct 14 08:55:02 eanna kernel: NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [m=
em 0x100000000-0x83fffffff] -&gt; [mem 0x00000000-0x83fffffff]
Oct 14 08:55:02 eanna kernel: NODE_DATA(0) allocated [mem 0x83fffc000-0x83f=
ffffff]
Oct 14 08:55:02 eanna kernel: NODE_DATA(2) allocated [mem 0x103eff9000-0x10=
3effcfff]
Oct 14 08:55:02 eanna kernel:  [ffffea0000000000-ffffea0020ffffff] PMD -&gt=
; [ffff88081fe00000-ffff88083fdfffff] on node 0
Oct 14 08:55:02 eanna kernel:  [ffffea0021000000-ffffea0040ffffff] PMD -&gt=
; [ffff88101e600000-ffff88103e5fffff] on node 2
Oct 14 08:55:02 eanna kernel: Zone ranges:
Oct 14 08:55:02 eanna kernel:   DMA      [mem 0x0000000000001000-0x00000000=
00ffffff]
Oct 14 08:55:02 eanna kernel:   DMA32    [mem 0x0000000001000000-0x00000000=
ffffffff]
Oct 14 08:55:02 eanna kernel:   Normal   [mem 0x0000000100000000-0x00000010=
3effffff]
Oct 14 08:55:02 eanna kernel: Movable zone start for each node
Oct 14 08:55:02 eanna kernel: Early memory node ranges
Oct 14 08:55:02 eanna kernel:   node   0: [mem 0x0000000000001000-0x0000000=
000093fff]
Oct 14 08:55:02 eanna kernel:   node   0: [mem 0x0000000000100000-0x0000000=
0bfe7ffff]
Oct 14 08:55:02 eanna kernel:   node   0: [mem 0x0000000100000000-0x0000000=
83fffffff]
Oct 14 08:55:02 eanna kernel:   node   2: [mem 0x0000000840000000-0x0000001=
03effffff]
Oct 14 08:55:02 eanna kernel: Initmem setup node 0 [mem 0x0000000000001000-=
0x000000083fffffff]
Oct 14 08:55:02 eanna kernel: On node 0 totalpages: 8388115
Oct 14 08:55:02 eanna kernel:   DMA zone: 64 pages used for memmap
Oct 14 08:55:02 eanna kernel:   DMA zone: 21 pages reserved
Oct 14 08:55:02 eanna kernel:   DMA zone: 3987 pages, LIFO batch:0
Oct 14 08:55:02 eanna kernel:   DMA32 zone: 12218 pages used for memmap
Oct 14 08:55:02 eanna kernel:   DMA32 zone: 781952 pages, LIFO batch:31
Oct 14 08:55:02 eanna kernel:   Normal zone: 118784 pages used for memmap
Oct 14 08:55:02 eanna kernel:   Normal zone: 7602176 pages, LIFO batch:31
Oct 14 08:55:02 eanna kernel: Initmem setup node 2 [mem 0x0000000840000000-=
0x000000103effffff]
Oct 14 08:55:02 eanna kernel: On node 2 totalpages: 8384512
Oct 14 08:55:02 eanna kernel:   Normal zone: 131008 pages used for memmap
Oct 14 08:55:02 eanna kernel:   Normal zone: 8384512 pages, LIFO batch:31
Oct 14 08:55:02 eanna kernel: ACPI: PM-Timer IO Port: 0x808
Oct 14 08:55:02 eanna kernel: ACPI: Local APIC address 0xfee00000
Oct 14 08:55:02 eanna kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0=
x1])
Oct 14 08:55:02 eanna kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint=
[0x1])
Oct 14 08:55:02 eanna kernel: IOAPIC[0]: apic_id 0, version 33, address 0xf=
ec00000, GSI 0-23
Oct 14 08:55:02 eanna kernel: IOAPIC[1]: apic_id 1, version 33, address 0xf=
ec20000, GSI 24-55
Oct 14 08:55:02 eanna kernel: IOAPIC[2]: apic_id 2, version 33, address 0xd=
a000000, GSI 56-87
Oct 14 08:55:02 eanna kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq=
 2 dfl dfl)
Oct 14 08:55:02 eanna kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq=
 9 low level)
Oct 14 08:55:02 eanna kernel: ACPI: IRQ0 used by override.
Oct 14 08:55:02 eanna kernel: ACPI: IRQ9 used by override.
Oct 14 08:55:02 eanna kernel: Using ACPI (MADT) for SMP configuration infor=
mation
Oct 14 08:55:02 eanna kernel: ACPI: HPET id: 0x8300 base: 0xfed00000
Oct 14 08:55:02 eanna kernel: smpboot: Allowing 32 CPUs, 8 hotplug CPUs
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0x00000000=
-0x00000fff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0x00094000=
-0x00094fff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0x00095000=
-0x0009ffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0x000a0000=
-0x000e5fff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0x000e6000=
-0x000fffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xbfe80000=
-0xbfe8dfff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xbfe8e000=
-0xbfe8ffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xbfe90000=
-0xbfeb3fff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xbfeb4000=
-0xbfedffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xbfee0000=
-0xbfffffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xc0000000=
-0xdfffffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xe0000000=
-0xefffffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xf0000000=
-0xffdfffff]
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xffe00000=
-0xffffffff]
Oct 14 08:55:02 eanna kernel: e820: [mem 0xc0000000-0xdfffffff] available f=
or PCI devices
Oct 14 08:55:02 eanna kernel: Booting paravirtualized kernel on bare hardwa=
re
Oct 14 08:55:02 eanna kernel: clocksource: refined-jiffies: mask: 0xfffffff=
f max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
Oct 14 08:55:02 eanna kernel: setup_percpu: NR_CPUS:128 nr_cpumask_bits:128=
 nr_cpu_ids:32 nr_node_ids:4
Oct 14 08:55:02 eanna kernel: PERCPU: Embedded 32 pages/cpu @ffff88081f8000=
00 s91480 r8192 d31400 u262144
Oct 14 08:55:02 eanna kernel: pcpu-alloc: s91480 r8192 d31400 u262144 alloc=
=3D1*2097152
Oct 14 08:55:02 eanna kernel: pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 0=
8 09 10 11 18 19 20 21=20
Oct 14 08:55:02 eanna kernel: pcpu-alloc: [0] 22 23 24 26 28 30 -- -- [1] 1=
2 13 14 15 16 17 25 27=20
Oct 14 08:55:02 eanna kernel: pcpu-alloc: [1] 29 31 -- -- -- -- -- --=20
Oct 14 08:55:02 eanna kernel: Built 2 zonelists in Node order, mobility gro=
uping on.  Total pages: 16510532
Oct 14 08:55:02 eanna kernel: Policy zone: Normal
Oct 14 08:55:02 eanna kernel: Kernel command line: BOOT_IMAGE=3D/__system/R=
OOT/boot/vmlinuz-linux root=3DUUID=3D06acfd0f-314d-457f-ba00-f96bf5b94a02 r=
w rootflags=3Dsubvol=3D__system/ROOT quiet acpi_osi=3DLinux amd_iommu_dump=
=3D1 transparent_hugepage=3Dnever
Oct 14 08:55:02 eanna kernel: PID hash table entries: 4096 (order: 3, 32768=
 bytes)
Oct 14 08:55:02 eanna kernel: AGP: Checking aperture...
Oct 14 08:55:02 eanna kernel: AGP: No AGP bridge found
Oct 14 08:55:02 eanna kernel: AGP: Node 0: aperture [bus addr 0x00000000-0x=
01ffffff] (32MB)
Oct 14 08:55:02 eanna kernel: AGP: Your BIOS doesn&#39;t leave an aperture =
memory hole
Oct 14 08:55:02 eanna kernel: AGP: Please enable the IOMMU option in the BI=
OS setup
Oct 14 08:55:02 eanna kernel: AGP: This costs you 64MB of RAM
Oct 14 08:55:02 eanna kernel: AGP: Mapping aperture over RAM [mem 0xb400000=
0-0xb7ffffff] (65536KB)
Oct 14 08:55:02 eanna kernel: PM: Registered nosave memory: [mem 0xb4000000=
-0xb7ffffff]
Oct 14 08:55:02 eanna kernel: Memory: 65890116K/67090508K available (5591K =
kernel code, 922K rwdata, 1764K rodata, 1180K init, 1152K bss, 1200392K res=
erved, 0K cma-reserved)
Oct 14 08:55:02 eanna kernel: SLUB: HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D32, Nodes=3D4
Oct 14 08:55:02 eanna kernel: Preemptible hierarchical RCU implementation.
Oct 14 08:55:02 eanna kernel:         Build-time adjustment of leaf fanout =
to 64.
Oct 14 08:55:02 eanna kernel:         RCU restricting CPUs from NR_CPUS=3D1=
28 to nr_cpu_ids=3D32.
Oct 14 08:55:02 eanna kernel: RCU: Adjusting geometry for rcu_fanout_leaf=
=3D64, nr_cpu_ids=3D32
Oct 14 08:55:02 eanna kernel: NR_IRQS:8448 nr_irqs:1768 16
Oct 14 08:55:02 eanna kernel: spurious 8259A interrupt: IRQ7.
Oct 14 08:55:02 eanna kernel: Console: colour dummy device 80x25
Oct 14 08:55:02 eanna kernel: console [tty0] enabled
Oct 14 08:55:02 eanna kernel: mempolicy: Enabling automatic NUMA balancing.=
 Configure with numa_balancing=3D or the kernel.numa_balancing sysctl
Oct 14 08:55:02 eanna kernel: clocksource: hpet: mask: 0xffffffff max_cycle=
s: 0xffffffff, max_idle_ns: 133484873504 ns
Oct 14 08:55:02 eanna kernel: hpet clockevent registered
Oct 14 08:55:02 eanna kernel: tsc: Fast TSC calibration using PIT
Oct 14 08:55:02 eanna kernel: tsc: Detected 2800.266 MHz processor
Oct 14 08:55:02 eanna kernel: Calibrating delay loop (skipped), value calcu=
lated using timer frequency.. 5602.88 BogoMIPS (lpj=3D9334220)
Oct 14 08:55:02 eanna kernel: pid_max: default: 32768 minimum: 301
Oct 14 08:55:02 eanna kernel: ACPI: Core revision 20150619
Oct 14 08:55:02 eanna kernel: ACPI: All ACPI Tables successfully acquired
Oct 14 08:55:02 eanna kernel: Security Framework initialized
Oct 14 08:55:02 eanna kernel: Yama: becoming mindful.
Oct 14 08:55:02 eanna kernel: Dentry cache hash table entries: 8388608 (ord=
er: 14, 67108864 bytes)
Oct 14 08:55:02 eanna kernel: Inode-cache hash table entries: 4194304 (orde=
r: 13, 33554432 bytes)
Oct 14 08:55:02 eanna kernel: Mount-cache hash table entries: 131072 (order=
: 8, 1048576 bytes)
Oct 14 08:55:02 eanna kernel: Mountpoint-cache hash table entries: 131072 (=
order: 8, 1048576 bytes)
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys blkio
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys memory
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys devices
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys freezer
Oct 14 08:55:02 eanna kernel: Initializing cgroup subsys net_cls
Oct 14 08:55:02 eanna kernel: CPU: Physical Processor ID: 0
Oct 14 08:55:02 eanna kernel: CPU: Processor Core ID: 0
Oct 14 08:55:02 eanna kernel: mce: CPU supports 7 MCE banks
Oct 14 08:55:02 eanna kernel: LVT offset 1 assigned for vector 0xf9
Oct 14 08:55:02 eanna kernel: Last level iTLB entries: 4KB 512, 2MB 1024, 4=
MB 512
Oct 14 08:55:02 eanna kernel: Last level dTLB entries: 4KB 1024, 2MB 1024, =
4MB 512, 1GB 0
Oct 14 08:55:02 eanna kernel: Freeing SMP alternatives memory: 20K (fffffff=
f81a0f000 - ffffffff81a14000)
Oct 14 08:55:02 eanna kernel: ftrace: allocating 22094 entries in 87 pages
Oct 14 08:55:02 eanna kernel: AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flag=
s: 3e info 1300
Oct 14 08:55:02 eanna kernel: AMD-Vi:        mmio-addr: 00000000f6000000
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START         devi=
d: 00:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END                 devid=
: 00:00.2
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 00:04.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 05:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_ALIAS_RANGE                 dev=
id: 06:01.0 flags: 00 devid_to: 06:00.0
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END                 devid=
: 06:1f.7
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 00:0c.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 04:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 00:0d.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START         devi=
d: 02:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END                 devid=
: 02:1f.7
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 00:11.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START         devi=
d: 00:12.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END                 devid=
: 00:12.2
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START         devi=
d: 00:13.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END                 devid=
: 00:13.2
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 00:14.0 flags: d7
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 00:14.3 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 00:14.4 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_ALIAS_RANGE                 dev=
id: 01:00.0 flags: 00 devid_to: 00:14.4
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END                 devid=
: 01:1f.7
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 00:14.5 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SPECIAL(IOAPIC[0])             =
   devid: 00:14.0
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SPECIAL(HPET[0])               =
 devid: 00:14.0
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SPECIAL(IOAPIC[1])             =
   devid: 00:00.1
Oct 14 08:55:02 eanna kernel: AMD-Vi: device: 40:00.2 cap: 0040 seg: 0 flag=
s: 3e info 1300
Oct 14 08:55:02 eanna kernel: AMD-Vi:        mmio-addr: 00000000da010000
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START         devi=
d: 40:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END                 devid=
: 40:00.2
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 40:02.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT_RANGE_START         devi=
d: 42:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_RANGE_END                 devid=
: 42:00.1
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 40:04.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SELECT                         =
devid: 41:00.0 flags: 00
Oct 14 08:55:02 eanna kernel: AMD-Vi:   DEV_SPECIAL(IOAPIC[2])             =
   devid: 40:00.1
Oct 14 08:55:02 eanna kernel: Switched APIC routing to physical flat.
Oct 14 08:55:02 eanna kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 api=
c2=3D-1 pin2=3D-1
Oct 14 08:55:02 eanna kernel: smpboot: CPU0: AMD Opteron(tm) Processor 6348=
 (fam: 15, model: 02, stepping: 00)
Oct 14 08:55:02 eanna kernel: Performance Events: Fam15h core perfctr, AMD =
PMU driver.
Oct 14 08:55:02 eanna kernel: ... version:                0
Oct 14 08:55:02 eanna kernel: ... bit width:              48
Oct 14 08:55:02 eanna kernel: ... generic registers:      6
Oct 14 08:55:02 eanna kernel: ... value mask:             0000ffffffffffff
Oct 14 08:55:02 eanna kernel: ... max period:             00007fffffffffff
Oct 14 08:55:02 eanna kernel: ... fixed-purpose events:   0
Oct 14 08:55:02 eanna kernel: ... event mask:             000000000000003f
Oct 14 08:55:02 eanna kernel: NMI watchdog: enabled on all CPUs, permanentl=
y consumes one hw-PMU counter.
Oct 14 08:55:02 eanna kernel: x86: Booting SMP configuration:
Oct 14 08:55:02 eanna kernel: .... node  #0, CPUs:        #1  #2  #3  #4  #=
5  #6  #7  #8  #9 #10 #11
Oct 14 08:55:02 eanna kernel: .... node  #2, CPUs:   #12 #13 #14 #15 #16 #1=
7
Oct 14 08:55:02 eanna kernel: .... node  #0, CPUs:   #18 #19 #20 #21 #22 #2=
3
Oct 14 08:55:02 eanna kernel: x86: Booted up 2 nodes, 24 CPUs
Oct 14 08:55:02 eanna kernel: smpboot: Total of 24 processors activated (13=
4458.90 BogoMIPS)
Oct 14 08:55:02 eanna kernel: devtmpfs: initialized
Oct 14 08:55:02 eanna kernel: memory block size : 128MB
Oct 14 08:55:02 eanna kernel: PM: Registering ACPI NVS region [mem 0xbfeb40=
00-0xbfedffff] (180224 bytes)
Oct 14 08:55:02 eanna kernel: clocksource: jiffies: mask: 0xffffffff max_cy=
cles: 0xffffffff, max_idle_ns: 6370867519511994 ns
Oct 14 08:55:02 eanna kernel: pinctrl core: initialized pinctrl subsystem
Oct 14 08:55:02 eanna kernel: RTC time: 15:54:51, date: 10/14/15
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 16
Oct 14 08:55:02 eanna kernel: cpuidle: using governor ladder
Oct 14 08:55:02 eanna kernel: cpuidle: using governor menu
Oct 14 08:55:02 eanna kernel: ACPI: bus type PCI registered
Oct 14 08:55:02 eanna kernel: acpiphp: ACPI Hot Plug PCI Controller Driver =
version: 0.5
Oct 14 08:55:02 eanna kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at =
[mem 0xe0000000-0xefffffff] (base 0xe0000000)
Oct 14 08:55:02 eanna kernel: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] =
reserved in E820
Oct 14 08:55:02 eanna kernel: PCI: Using configuration type 1 for base acce=
ss
Oct 14 08:55:02 eanna kernel: mtrr: your CPUs had inconsistent variable MTR=
R settings
Oct 14 08:55:02 eanna kernel: mtrr: probably your BIOS does not setup all C=
PUs.
Oct 14 08:55:02 eanna kernel: mtrr: corrected configuration.
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(Module Device)
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(Processor Device)
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(Processor Aggregator Device)
Oct 14 08:55:02 eanna kernel: ACPI: Added _OSI(Linux)
Oct 14 08:55:02 eanna kernel: ACPI: Executed 2 blocks of module-level execu=
table AML code
Oct 14 08:55:02 eanna kernel: ACPI: Interpreter enabled
Oct 14 08:55:02 eanna kernel: ACPI Exception: AE_NOT_FOUND, While evaluatin=
g Sleep State [\_S2_] (20150619/hwxface-580)
Oct 14 08:55:02 eanna kernel: ACPI Exception: AE_NOT_FOUND, While evaluatin=
g Sleep State [\_S3_] (20150619/hwxface-580)
Oct 14 08:55:02 eanna kernel: ACPI: (supports S0 S1 S4 S5)
Oct 14 08:55:02 eanna kernel: ACPI: Using IOAPIC for interrupt routing
Oct 14 08:55:02 eanna kernel: HEST: Table parsing has been initialized.
Oct 14 08:55:02 eanna kernel: PCI: Using host bridge windows from ACPI; if =
necessary, use &quot;pci=3Dnocrs&quot; and report a bug
Oct 14 08:55:02 eanna kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bu=
s 00-06])
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedC=
onfig ASPM ClockPM Segments MSI]
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); =
disabling ASPM
Oct 14 08:55:02 eanna kernel: PCI host bridge to bus 0000:00
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [bus 00-06=
]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [io  0x000=
0-0x03af window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [io  0x03e=
0-0x0cf7 window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [io  0x03c=
0-0x03df window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [io  0x0d0=
0-0xffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem 0x000=
a0000-0x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem 0x000=
d0000-0x000dffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem 0xdd0=
00000-0xdfffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem 0xdc0=
00000-0xdcffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: root bus resource [mem 0xfed=
40000-0xfed44fff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:00.0: [1002:5a10] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:00.2: [1002:5a23] type 00 class 0=
x080600
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: [1002:5a18] type 01 class 0=
x060400
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: PME# supported from D0 D3ho=
t D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: [1002:5a20] type 01 class 0=
x060400
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: PME# supported from D0 D3ho=
t D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: [1002:5a1e] type 01 class 0=
x060400
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: PME# supported from D0 D3ho=
t D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: [1002:4391] type 00 class 0=
x010601
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x10: [io  0xa000-0xa00=
7]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x14: [io  0x9000-0x900=
3]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x18: [io  0x8000-0x800=
7]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x1c: [io  0x7000-0x700=
3]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x20: [io  0x6000-0x600=
f]
Oct 14 08:55:02 eanna kernel: pci 0000:00:11.0: reg 0x24: [mem 0xdf5f8400-0=
xdf5f87ff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.0: [1002:4397] type 00 class 0=
x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.0: reg 0x10: [mem 0xdf5f7000-0=
xdf5f7fff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.0: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.1: [1002:4398] type 00 class 0=
x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.1: reg 0x10: [mem 0xdf5f6000-0=
xdf5f6fff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.1: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: [1002:4396] type 00 class 0=
x0c0320
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: reg 0x10: [mem 0xdf5f8800-0=
xdf5f88ff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: PME# supported from D0 D1 D=
2 D3hot
Oct 14 08:55:02 eanna kernel: pci 0000:00:12.2: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.0: [1002:4397] type 00 class 0=
x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.0: reg 0x10: [mem 0xdf5fa000-0=
xdf5fafff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.0: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.1: [1002:4398] type 00 class 0=
x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.1: reg 0x10: [mem 0xdf5f9000-0=
xdf5f9fff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.1: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: [1002:4396] type 00 class 0=
x0c0320
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: reg 0x10: [mem 0xdf5f8c00-0=
xdf5f8cff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: PME# supported from D0 D1 D=
2 D3hot
Oct 14 08:55:02 eanna kernel: pci 0000:00:13.2: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.0: [1002:4385] type 00 class 0=
x0c0500
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.3: [1002:439d] type 00 class 0=
x060100
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4: [1002:4384] type 01 class 0=
x060401
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.5: [1002:4399] type 00 class 0=
x0c0310
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.5: reg 0x10: [mem 0xdf5fb000-0=
xdf5fbfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.5: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.0: [1022:1600] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.1: [1022:1601] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.2: [1022:1602] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.3: [1022:1603] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.4: [1022:1604] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:18.5: [1022:1605] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.0: [1022:1600] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.1: [1022:1601] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.2: [1022:1602] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.3: [1022:1603] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.4: [1022:1604] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:19.5: [1022:1605] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.0: [1022:1600] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.1: [1022:1601] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.2: [1022:1602] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.3: [1022:1603] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.4: [1022:1604] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1a.5: [1022:1605] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.0: [1022:1600] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.1: [1022:1601] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.2: [1022:1602] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.3: [1022:1603] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.4: [1022:1604] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:00:1b.5: [1022:1605] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: [1b21:1080] type 01 class 0=
x060400
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: PME# supported from D0 D1 D=
2 D3hot D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: PCI bridge to [bus 05-06]
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0:   bridge window [io  0xd000=
-0xdfff]
Oct 14 08:55:02 eanna kernel: pci 0000:06:00.0: [13f6:8788] type 00 class 0=
x040100
Oct 14 08:55:02 eanna kernel: pci 0000:06:00.0: reg 0x10: [io  0xd800-0xd8f=
f]
Oct 14 08:55:02 eanna kernel: pci 0000:06:00.0: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: PCI bridge to [bus 06]
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0:   bridge window [io  0xd000=
-0xdfff]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: [1000:0072] type 00 class 0=
x010700
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x10: [io  0xc000-0xc0f=
f]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x14: [mem 0xdff3c000-0=
xdff3ffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x1c: [mem 0xdff40000-0=
xdff7ffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x30: [mem 0xdff80000-0=
xdfffffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x174: [mem 0xdfec0000-=
0xdfec3fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: VF(n) BAR0 space: [mem 0xdf=
ec0000-0xdfefffff 64bit] (contains BAR0 for 16 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: reg 0x17c: [mem 0xdf800000-=
0xdf83ffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:04:00.0: VF(n) BAR2 space: [mem 0xdf=
800000-0xdfbfffff 64bit] (contains BAR2 for 16 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: PCI bridge to [bus 04]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0:   bridge window [io  0xc000=
-0xcfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0:   bridge window [mem 0xdf80=
0000-0xdfffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: [8086:10c9] type 00 class 0=
x020000
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x10: [mem 0xdf7e0000-0=
xdf7fffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x14: [mem 0xdf7c0000-0=
xdf7dffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x18: [io  0xb800-0xb81=
f]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x1c: [mem 0xdf79c000-0=
xdf79ffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x30: [mem 0xdf7a0000-0=
xdf7bffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: PME# supported from D0 D3ho=
t D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x184: [mem 0xdf760000-=
0xdf763fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: VF(n) BAR0 space: [mem 0xdf=
760000-0xdf77ffff 64bit] (contains BAR0 for 8 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: reg 0x190: [mem 0xdf740000-=
0xdf743fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.0: VF(n) BAR3 space: [mem 0xdf=
740000-0xdf75ffff 64bit] (contains BAR3 for 8 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: [8086:10c9] type 00 class 0=
x020000
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x10: [mem 0xdf720000-0=
xdf73ffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x14: [mem 0xdf700000-0=
xdf71ffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x18: [io  0xb400-0xb41=
f]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x1c: [mem 0xdf6dc000-0=
xdf6dffff]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x30: [mem 0xdf6e0000-0=
xdf6fffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: PME# supported from D0 D3ho=
t D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x184: [mem 0xdf6a0000-=
0xdf6a3fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: VF(n) BAR0 space: [mem 0xdf=
6a0000-0xdf6bffff 64bit] (contains BAR0 for 8 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: reg 0x190: [mem 0xdf680000-=
0xdf683fff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:02:00.1: VF(n) BAR3 space: [mem 0xdf=
680000-0xdf69ffff 64bit] (contains BAR3 for 8 VFs)
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: PCI bridge to [bus 02-03]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0:   bridge window [io  0xb000=
-0xbfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0:   bridge window [mem 0xdf60=
0000-0xdf7fffff]
Oct 14 08:55:02 eanna kernel: pci 0000:01:04.0: [102b:0532] type 00 class 0=
x030000
Oct 14 08:55:02 eanna kernel: pci 0000:01:04.0: reg 0x10: [mem 0xdc000000-0=
xdcffffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:01:04.0: reg 0x14: [mem 0xde7fc000-0=
xde7fffff]
Oct 14 08:55:02 eanna kernel: pci 0000:01:04.0: reg 0x18: [mem 0xde800000-0=
xdeffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4: PCI bridge to [bus 01] (sub=
tractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem 0xde70=
0000-0xdeffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem 0xdc00=
0000-0xdcffffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [io  0x0000=
-0x03af window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [io  0x03e0=
-0x0cf7 window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [io  0x03c0=
-0x03df window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [io  0x0d00=
-0xffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem 0x000a=
0000-0x000bffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem 0x000d=
0000-0x000dffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem 0xdd00=
0000-0xdfffffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem 0xdc00=
0000-0xdcffffff window] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem 0xfed4=
0000-0xfed44fff] (subtractive decode)
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: on NUMA node 0
Oct 14 08:55:02 eanna kernel: ACPI: PCI Root Bridge [PC40] (domain 0000 [bu=
s 40-42])
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:01: _OSC: OS supports [ExtendedC=
onfig ASPM ClockPM Segments MSI]
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:01: _OSC: OS now controls [PCIeH=
otplug PME AER PCIeCapability]
Oct 14 08:55:02 eanna kernel: acpi PNP0A08:01: [Firmware Bug]: no _PXM; fal=
ling back to node 2 from hardware (may be inconsistent with ACPI node numbe=
rs)
Oct 14 08:55:02 eanna kernel: PCI host bridge to bus 0000:40
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [bus 40-42=
]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [io  0xe00=
0-0xefff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [io  0x03b=
0-0x03bb window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [io  0x03c=
0-0x03df window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [mem 0x000=
a0000-0x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [mem 0xda0=
00000-0xdbffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: root bus resource [mem 0xc00=
00000-0xd9ffffff window]
Oct 14 08:55:02 eanna kernel: pci 0000:40:00.0: [1002:5a10] type 00 class 0=
x060000
Oct 14 08:55:02 eanna kernel: pci 0000:40:00.2: [1002:5a23] type 00 class 0=
x080600
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: [1002:5a16] type 01 class 0=
x060400
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: PME# supported from D0 D3ho=
t D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: [1002:5a18] type 01 class 0=
x060400
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: PME# supported from D0 D3ho=
t D3cold
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: System wakeup disabled by A=
CPI
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: [1002:679a] type 00 class 0=
x030000
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: reg 0x10: [mem 0xc0000000-0=
xcfffffff 64bit pref]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: reg 0x18: [mem 0xdbfc0000-0=
xdbffffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: reg 0x20: [io  0xe000-0xe0f=
f]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: reg 0x30: [mem 0xdbfa0000-0=
xdbfbffff pref]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: PME# supported from D1 D2 D=
3hot
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.1: [1002:aaa0] type 00 class 0=
x040300
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.1: reg 0x10: [mem 0xdbf9c000-0=
xdbf9ffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.1: supports D1 D2
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: PCI bridge to [bus 42]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [io  0xe000=
-0xefff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [mem 0xdbf0=
0000-0xdbffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [mem 0xc000=
0000-0xcfffffff 64bit pref]
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: [1b73:1100] type 00 class 0=
x0c0330
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: reg 0x10: [mem 0xdbef0000-0=
xdbefffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: reg 0x18: [mem 0xdbeef000-0=
xdbeeffff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: reg 0x20: [mem 0xdbeee000-0=
xdbeeefff 64bit]
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: supports D1
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: PME# supported from D0 D1 D=
3hot
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: PCI bridge to [bus 41]
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0:   bridge window [mem 0xdbe0=
0000-0xdbefffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: on NUMA node 2
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 =
11 12 14 *15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 =
*11 12 14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 =
11 12 *14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 *10=
 11 12 14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 =
*11 12 14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 =
11 12 14 15) *0, disabled.
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 *10=
 11 12 14 15)
Oct 14 08:55:02 eanna kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 =
11 12 14 15) *0, disabled.
Oct 14 08:55:02 eanna kernel: vgaarb: device added: PCI:0000:01:04.0,decode=
s=3Dio+mem,owns=3Dnone,locks=3Dnone
Oct 14 08:55:02 eanna kernel: vgaarb: setting as boot device: PCI:0000:42:0=
0.0
Oct 14 08:55:02 eanna kernel: vgaarb: device added: PCI:0000:42:00.0,decode=
s=3Dio+mem,owns=3Dio+mem,locks=3Dnone
Oct 14 08:55:02 eanna kernel: vgaarb: loaded
Oct 14 08:55:02 eanna kernel: vgaarb: bridge control possible 0000:42:00.0
Oct 14 08:55:02 eanna kernel: vgaarb: bridge control possible 0000:01:04.0
Oct 14 08:55:02 eanna kernel: PCI: Using ACPI for IRQ routing
Oct 14 08:55:02 eanna kernel: PCI: pci_cache_line_size set to 64 bytes
Oct 14 08:55:02 eanna kernel: e820: reserve RAM buffer [mem 0x00094800-0x00=
09ffff]
Oct 14 08:55:02 eanna kernel: e820: reserve RAM buffer [mem 0xbfe80000-0xbf=
ffffff]
Oct 14 08:55:02 eanna kernel: e820: reserve RAM buffer [mem 0x103f000000-0x=
103fffffff]
Oct 14 08:55:02 eanna kernel: NetLabel: Initializing
Oct 14 08:55:02 eanna kernel: NetLabel:  domain hash size =3D 128
Oct 14 08:55:02 eanna kernel: NetLabel:  protocols =3D UNLABELED CIPSOv4
Oct 14 08:55:02 eanna kernel: NetLabel:  unlabeled traffic allowed by defau=
lt
Oct 14 08:55:02 eanna kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
Oct 14 08:55:02 eanna kernel: hpet0: 4 comparators, 32-bit 14.318180 MHz co=
unter
Oct 14 08:55:02 eanna kernel: clocksource: Switched to clocksource hpet
Oct 14 08:55:02 eanna kernel: pnp: PnP ACPI init
Oct 14 08:55:02 eanna kernel: system 00:00: [mem 0xfec20000-0xfec200ff] cou=
ld not be reserved
Oct 14 08:55:02 eanna kernel: system 00:00: Plug and Play ACPI device, IDs =
PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:01: [mem 0xf6000000-0xf6003fff] cou=
ld not be reserved
Oct 14 08:55:02 eanna kernel: system 00:01: Plug and Play ACPI device, IDs =
PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: pnp 00:02: Plug and Play ACPI device, IDs PNP=
0b00 (active)
Oct 14 08:55:02 eanna kernel: system 00:03: [mem 0xfec00000-0xfec00fff] cou=
ld not be reserved
Oct 14 08:55:02 eanna kernel: system 00:03: [mem 0xfee00000-0xfee00fff] has=
 been reserved
Oct 14 08:55:02 eanna kernel: system 00:03: Plug and Play ACPI device, IDs =
PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0ca2-0x0ca3] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0550-0x0551] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x04d0-0x04d1] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x040b] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x04d6] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c00-0x0c01] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c14] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c50-0x0c51] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c52] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c6c] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0c6f] has been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd0-0x0cd1] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd2-0x0cd3] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd4-0x0cd5] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd6-0x0cd7] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0cd8-0x0cdf] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0800-0x089f] could not b=
e reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0b00-0x0b0f] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0b20-0x0b3f] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0900-0x090f] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0x0910-0x091f] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [io  0xfe00-0xfefe] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:04: [mem 0xffb80000-0xffbfffff] has=
 been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [mem 0xfec10000-0xfec1001f] has=
 been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: [mem 0xffe50000-0xffe5e05f] has=
 been reserved
Oct 14 08:55:02 eanna kernel: system 00:04: Plug and Play ACPI device, IDs =
PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: pnp 00:05: [dma 0 disabled]
Oct 14 08:55:02 eanna kernel: pnp 00:05: Plug and Play ACPI device, IDs PNP=
0501 (active)
Oct 14 08:55:02 eanna kernel: pnp 00:06: [dma 0 disabled]
Oct 14 08:55:02 eanna kernel: pnp 00:06: Plug and Play ACPI device, IDs PNP=
0501 (active)
Oct 14 08:55:02 eanna kernel: system 00:07: [io  0x0a00-0x0a0f] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:07: [io  0x0a10-0x0a1f] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:07: Plug and Play ACPI device, IDs =
PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: pnp 00:08: [dma 0 disabled]
Oct 14 08:55:02 eanna kernel: pnp 00:08: Plug and Play ACPI device, IDs PNP=
0501 (active)
Oct 14 08:55:02 eanna kernel: system 00:09: [io  0x164e-0x164f] has been re=
served
Oct 14 08:55:02 eanna kernel: system 00:09: Plug and Play ACPI device, IDs =
PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:0a: [mem 0xe0000000-0xefffffff] has=
 been reserved
Oct 14 08:55:02 eanna kernel: system 00:0a: Plug and Play ACPI device, IDs =
PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:0b: [mem 0x000c0000-0x000cffff] cou=
ld not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0b: [mem 0x000e0000-0x000fffff] cou=
ld not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0b: [mem 0xfec00000-0xffffffff] cou=
ld not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0b: Plug and Play ACPI device, IDs =
PNP0c01 (active)
Oct 14 08:55:02 eanna kernel: system 00:0c: [mem 0xda000000-0xda0000ff] cou=
ld not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0c: Plug and Play ACPI device, IDs =
PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: system 00:0d: [mem 0xda010000-0xda013fff] cou=
ld not be reserved
Oct 14 08:55:02 eanna kernel: system 00:0d: Plug and Play ACPI device, IDs =
PNP0c02 (active)
Oct 14 08:55:02 eanna kernel: pnp: PnP ACPI: found 14 devices
Oct 14 08:55:02 eanna kernel: clocksource: acpi_pm: mask: 0xffffff max_cycl=
es: 0xffffff, max_idle_ns: 2085701024 ns
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0: PCI bridge to [bus 06]
Oct 14 08:55:02 eanna kernel: pci 0000:05:00.0:   bridge window [io  0xd000=
-0xdfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0: PCI bridge to [bus 05-06]
Oct 14 08:55:02 eanna kernel: pci 0000:00:04.0:   bridge window [io  0xd000=
-0xdfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0: PCI bridge to [bus 04]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0:   bridge window [io  0xc000=
-0xcfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0c.0:   bridge window [mem 0xdf80=
0000-0xdfffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0: PCI bridge to [bus 02-03]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0:   bridge window [io  0xb000=
-0xbfff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:0d.0:   bridge window [mem 0xdf60=
0000-0xdf7fffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4: PCI bridge to [bus 01]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem 0xde70=
0000-0xdeffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:00:14.4:   bridge window [mem 0xdc00=
0000-0xdcffffff pref]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x03a=
f window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf=
7 window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 6 [io  0x03c0-0x03d=
f window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 7 [io  0x0d00-0xfff=
f window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 8 [mem 0x000a0000-0=
x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 9 [mem 0x000d0000-0=
x000dffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 10 [mem 0xdd000000-=
0xdfffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 11 [mem 0xdc000000-=
0xdcffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:00: resource 12 [mem 0xfed40000-=
0xfed44fff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:05: resource 0 [io  0xd000-0xdff=
f]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:06: resource 0 [io  0xd000-0xdff=
f]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:04: resource 0 [io  0xc000-0xcff=
f]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:04: resource 1 [mem 0xdf800000-0=
xdfffffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:02: resource 0 [io  0xb000-0xbff=
f]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:02: resource 1 [mem 0xdf600000-0=
xdf7fffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 1 [mem 0xde700000-0=
xdeffffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 2 [mem 0xdc000000-0=
xdcffffff pref]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 4 [io  0x0000-0x03a=
f window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 5 [io  0x03e0-0x0cf=
7 window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 6 [io  0x03c0-0x03d=
f window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 7 [io  0x0d00-0xfff=
f window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 8 [mem 0x000a0000-0=
x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 9 [mem 0x000d0000-0=
x000dffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 10 [mem 0xdd000000-=
0xdfffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 11 [mem 0xdc000000-=
0xdcffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:01: resource 12 [mem 0xfed40000-=
0xfed44fff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0: PCI bridge to [bus 42]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [io  0xe000=
-0xefff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [mem 0xdbf0=
0000-0xdbffffff]
Oct 14 08:55:02 eanna kernel: pci 0000:40:02.0:   bridge window [mem 0xc000=
0000-0xcfffffff 64bit pref]
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0: PCI bridge to [bus 41]
Oct 14 08:55:02 eanna kernel: pci 0000:40:04.0:   bridge window [mem 0xdbe0=
0000-0xdbefffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 4 [io  0xe000-0xeff=
f window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 5 [io  0x03b0-0x03b=
b window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 6 [io  0x03c0-0x03d=
f window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 7 [mem 0x000a0000-0=
x000bffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 8 [mem 0xda000000-0=
xdbffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:40: resource 9 [mem 0xc0000000-0=
xd9ffffff window]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:42: resource 0 [io  0xe000-0xeff=
f]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:42: resource 1 [mem 0xdbf00000-0=
xdbffffff]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:42: resource 2 [mem 0xc0000000-0=
xcfffffff 64bit pref]
Oct 14 08:55:02 eanna kernel: pci_bus 0000:41: resource 1 [mem 0xdbe00000-0=
xdbefffff]
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 2
Oct 14 08:55:02 eanna kernel: TCP established hash table entries: 524288 (o=
rder: 10, 4194304 bytes)
Oct 14 08:55:02 eanna kernel: TCP bind hash table entries: 65536 (order: 8,=
 1048576 bytes)
Oct 14 08:55:02 eanna kernel: TCP: Hash tables configured (established 5242=
88 bind 65536)
Oct 14 08:55:02 eanna kernel: UDP hash table entries: 32768 (order: 8, 1048=
576 bytes)
Oct 14 08:55:02 eanna kernel: UDP-Lite hash table entries: 32768 (order: 8,=
 1048576 bytes)
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 1
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: Video device with shadowed =
ROM
Oct 14 08:55:02 eanna kernel: PCI: CLS 64 bytes, default 64
Oct 14 08:55:02 eanna kernel: Unpacking initramfs...
Oct 14 08:55:02 eanna kernel: Freeing initrd memory: 4132K (ffff8800377de00=
0 - ffff880037be7000)
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:00.0 to group 0
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:04.0 to group 1
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:0c.0 to group 2
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:0d.0 to group 3
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:11.0 to group 4
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:12.0 to group 5
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:12.1 to group 5
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:12.2 to group 5
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:13.0 to group 6
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:13.1 to group 6
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:13.2 to group 6
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:14.0 to group 7
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:14.3 to group 8
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:14.4 to group 9
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:00:14.5 to group 10
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:05:00.0 to group 11
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:06:00.0 to group 11
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:04:00.0 to group 12
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:02:00.0 to group 13
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:02:00.1 to group 14
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:01:04.0 to group 9
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:40:00.0 to group 15
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:40:02.0 to group 16
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:40:04.0 to group 17
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:42:00.0 to group 18
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:42:00.1 to group 18
Oct 14 08:55:02 eanna kernel: iommu: Adding device 0000:41:00.0 to group 19
Oct 14 08:55:02 eanna kernel: AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
Oct 14 08:55:02 eanna kernel: AMD-Vi: Found IOMMU at 0000:40:00.2 cap 0x40
Oct 14 08:55:02 eanna kernel: AMD-Vi: Interrupt remapping enabled
Oct 14 08:55:02 eanna kernel: AMD-Vi: Lazy IO/TLB flushing enabled
Oct 14 08:55:02 eanna kernel: perf: AMD NB counters detected
Oct 14 08:55:02 eanna kernel: microcode: CPU0: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU1: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU2: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU3: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU4: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU5: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU6: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU7: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU8: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU9: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU10: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU11: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU12: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU13: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU14: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU15: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU16: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU17: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU18: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU19: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU20: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU21: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU22: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: CPU23: patch_level=3D0x06000822
Oct 14 08:55:02 eanna kernel: microcode: Microcode Update Driver: v2.00 &lt=
;<a href=3D"mailto:tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org">tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org=
</a>&gt;, Peter Oruba
Oct 14 08:55:02 eanna kernel: LVT offset 0 assigned for vector 0x400
Oct 14 08:55:02 eanna kernel: perf: AMD IBS detected (0x000000ff)
Oct 14 08:55:02 eanna kernel: Scanning for low memory corruption every 60 s=
econds
Oct 14 08:55:02 eanna kernel: futex hash table entries: 8192 (order: 7, 524=
288 bytes)
Oct 14 08:55:02 eanna kernel: Initialise system trusted keyring
Oct 14 08:55:02 eanna kernel: HugeTLB registered 2 MB page size, pre-alloca=
ted 0 pages
Oct 14 08:55:02 eanna kernel: zpool: loaded
Oct 14 08:55:02 eanna kernel: zbud: loaded
Oct 14 08:55:02 eanna kernel: VFS: Disk quotas dquot_6.6.0
Oct 14 08:55:02 eanna kernel: VFS: Dquot-cache hash table entries: 512 (ord=
er 0, 4096 bytes)
Oct 14 08:55:02 eanna kernel: Key type big_key registered
Oct 14 08:55:02 eanna kernel: Block layer SCSI generic (bsg) driver version=
 0.4 loaded (major 250)
Oct 14 08:55:02 eanna kernel: io scheduler noop registered
Oct 14 08:55:02 eanna kernel: io scheduler deadline registered
Oct 14 08:55:02 eanna kernel: io scheduler cfq registered (default)
Oct 14 08:55:02 eanna kernel: pcieport 0000:40:02.0: Signaling PME through =
PCIe PME interrupt
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.0: Signaling PME through PCIe =
PME interrupt
Oct 14 08:55:02 eanna kernel: pci 0000:42:00.1: Signaling PME through PCIe =
PME interrupt
Oct 14 08:55:02 eanna kernel: pcie_pme 0000:40:02.0:pcie01: service driver =
pcie_pme loaded
Oct 14 08:55:02 eanna kernel: pcieport 0000:40:04.0: Signaling PME through =
PCIe PME interrupt
Oct 14 08:55:02 eanna kernel: pci 0000:41:00.0: Signaling PME through PCIe =
PME interrupt
Oct 14 08:55:02 eanna kernel: pcie_pme 0000:40:04.0:pcie01: service driver =
pcie_pme loaded
Oct 14 08:55:02 eanna kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0=
.5
Oct 14 08:55:02 eanna kernel: pciehp: PCI Express Hot Plug Controller Drive=
r version: 0.4
Oct 14 08:55:02 eanna kernel: vesafb: mode is 1920x1080x32, linelength=3D76=
80, pages=3D0
Oct 14 08:55:02 eanna kernel: vesafb: scrolling: redraw
Oct 14 08:55:02 eanna kernel: vesafb: Truecolor: size=3D0:8:8:8, shift=3D0:=
16:8:0
Oct 14 08:55:02 eanna kernel: vesafb: framebuffer at 0xc0000000, mapped to =
0xffffc90007000000, using 8128k, total 8128k
Oct 14 08:55:02 eanna kernel: Console: switching to colour frame buffer dev=
ice 240x67
Oct 14 08:55:02 eanna kernel: fb0: VESA VGA frame buffer device
Oct 14 08:55:02 eanna kernel: ERST: Can not request [mem 0xbfe8e000-0xbfe8f=
fff] for ERST.
Oct 14 08:55:02 eanna kernel: GHES: APEI firmware first mode is enabled by =
APEI bit and WHEA _OSC.
Oct 14 08:55:02 eanna kernel: Serial: 8250/16550 driver, 4 ports, IRQ shari=
ng disabled
Oct 14 08:55:02 eanna kernel: 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_ba=
ud =3D 115200) is a 16550A
Oct 14 08:55:02 eanna kernel: 00:06: ttyS1 at I/O 0x2f8 (irq =3D 3, base_ba=
ud =3D 115200) is a 16550A
Oct 14 08:55:02 eanna kernel: 00:08: ttyS2 at I/O 0x3e8 (irq =3D 7, base_ba=
ud =3D 115200) is a 16550A
Oct 14 08:55:02 eanna kernel: Linux agpgart interface v0.103
Oct 14 08:55:02 eanna kernel: rtc_cmos 00:02: RTC can wake from S4
Oct 14 08:55:02 eanna kernel: rtc_cmos 00:02: rtc core: registered rtc_cmos=
 as rtc0
Oct 14 08:55:02 eanna kernel: rtc_cmos 00:02: alarms up to one month, y3k, =
114 bytes nvram, hpet irqs
Oct 14 08:55:02 eanna kernel: ledtrig-cpu: registered to indicate activity =
on CPUs
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 10
Oct 14 08:55:02 eanna kernel: NET: Registered protocol family 17
Oct 14 08:55:02 eanna kernel: Loading compiled-in X.509 certificates
Oct 14 08:55:02 eanna kernel: registered taskstats version 1
Oct 14 08:55:02 eanna kernel: zswap: loading zswap
Oct 14 08:55:02 eanna kernel: zswap: using zbud pool
Oct 14 08:55:02 eanna kernel: zswap: using lzo compressor
Oct 14 08:55:02 eanna kernel:   Magic number: 3:558:942
Oct 14 08:55:02 eanna kernel: memory memory365: hash matches
Oct 14 08:55:02 eanna kernel: rtc_cmos 00:02: setting system clock to 2015-=
10-14 15:54:52 UTC (1444838092)
Oct 14 08:55:02 eanna kernel: PM: Hibernation image not present or could no=
t be loaded.
Oct 14 08:55:02 eanna kernel: Freeing unused kernel memory: 1180K (ffffffff=
818e8000 - ffffffff81a0f000)
Oct 14 08:55:02 eanna kernel: Write protecting the kernel read-only data: 8=
192k
Oct 14 08:55:02 eanna kernel: Freeing unused kernel memory: 544K (ffff88000=
1578000 - ffff880001600000)
Oct 14 08:55:02 eanna kernel: Freeing unused kernel memory: 284K (ffff88000=
17b9000 - ffff880001800000)
Oct 14 08:55:02 eanna kernel: random: systemd-tmpfile urandom read with 1 b=
its of entropy available
Oct 14 08:55:02 eanna kernel: i8042: PNP: No PS/2 controller found. Probing=
 ports directly.
Oct 14 08:55:02 eanna kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 14 08:55:02 eanna kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 14 08:55:02 eanna kernel: SCSI subsystem initialized
Oct 14 08:55:02 eanna kernel: ACPI: bus type USB registered
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver usbf=
s
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver hub
Oct 14 08:55:02 eanna kernel: usbcore: registered new device driver usb
Oct 14 08:55:02 eanna kernel: ehci_hcd: USB 2.0 &#39;Enhanced&#39; Host Con=
troller (EHCI) Driver
Oct 14 08:55:02 eanna kernel: mpt2sas version 20.100.00.00 loaded
Oct 14 08:55:02 eanna kernel: mpt2sas0: 64 BIT PCI BUS DMA ADDRESSING SUPPO=
RTED, total mem (65962228 kB)
Oct 14 08:55:02 eanna kernel: ohci_hcd: USB 1.1 &#39;Open&#39; Host Control=
ler (OHCI) Driver
Oct 14 08:55:02 eanna kernel: ehci-pci: EHCI PCI platform driver
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: EHCI Host Controller
Oct 14 08:55:02 eanna kernel: libata version 3.00 loaded.
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: new USB bus registered=
, assigned bus number 1
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: applying AMD SB700/SB8=
00/Hudson-2/3 EHCI dummy qh workaround
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: debug port 1
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: irq 17, io mem 0xdf5f8=
800
Oct 14 08:55:02 eanna kernel: ohci-pci: OHCI PCI platform driver
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:12.2: USB 2.0 started, EHCI =
1.00
Oct 14 08:55:02 eanna kernel: hub 1-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 1-0:1.0: 6 ports detected
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: xHCI Host Controller
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: new USB bus registered=
, assigned bus number 2
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: hcc params 0x200071a1 =
hci version 0x100 quirks 0x00000010
Oct 14 08:55:02 eanna kernel: hub 2-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 2-0:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: xHCI Host Controller
Oct 14 08:55:02 eanna kernel: xhci_hcd 0000:41:00.0: new USB bus registered=
, assigned bus number 3
Oct 14 08:55:02 eanna kernel: usb usb3: We don&#39;t know the algorithms fo=
r LPM for this host, disabling LPM.
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: EHCI Host Controller
Oct 14 08:55:02 eanna kernel: hub 3-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 3-0:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: new USB bus registered=
, assigned bus number 4
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: applying AMD SB700/SB8=
00/Hudson-2/3 EHCI dummy qh workaround
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: debug port 1
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: irq 19, io mem 0xdf5f8=
c00
Oct 14 08:55:02 eanna kernel: ehci-pci 0000:00:13.2: USB 2.0 started, EHCI =
1.00
Oct 14 08:55:02 eanna kernel: hub 4-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 4-0:1.0: 6 ports detected
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.0: OHCI PCI host controll=
er
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.0: new USB bus registered=
, assigned bus number 5
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.0: irq 16, io mem 0xdf5f7=
000
Oct 14 08:55:02 eanna kernel: hub 5-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 5-0:1.0: 3 ports detected
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.1: OHCI PCI host controll=
er
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.1: new USB bus registered=
, assigned bus number 6
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:12.1: irq 16, io mem 0xdf5f6=
000
Oct 14 08:55:02 eanna kernel: hub 6-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 6-0:1.0: 3 ports detected
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.0: OHCI PCI host controll=
er
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.0: new USB bus registered=
, assigned bus number 7
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.0: irq 18, io mem 0xdf5fa=
000
Oct 14 08:55:02 eanna kernel: hub 7-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 7-0:1.0: 3 ports detected
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.1: OHCI PCI host controll=
er
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.1: new USB bus registered=
, assigned bus number 8
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:13.1: irq 18, io mem 0xdf5f9=
000
Oct 14 08:55:02 eanna kernel: mpt2sas0: MSI-X vectors supported: 1, no of c=
ores: 24, max_msix_vectors: 8
Oct 14 08:55:02 eanna kernel: mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 43
Oct 14 08:55:02 eanna kernel: mpt2sas0: iomem(0x00000000dff3c000), mapped(0=
xffffc90006a00000), size(16384)
Oct 14 08:55:02 eanna kernel: mpt2sas0: ioport(0x000000000000c000), size(25=
6)
Oct 14 08:55:02 eanna kernel: hub 8-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 8-0:1.0: 3 ports detected
Oct 14 08:55:02 eanna kernel: usb 3-3: new SuperSpeed USB device number 2 u=
sing xhci_hcd
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:14.5: OHCI PCI host controll=
er
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:14.5: new USB bus registered=
, assigned bus number 9
Oct 14 08:55:02 eanna kernel: ohci-pci 0000:00:14.5: irq 18, io mem 0xdf5fb=
000
Oct 14 08:55:02 eanna kernel: hub 9-0:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 9-0:1.0: 2 ports detected
Oct 14 08:55:02 eanna kernel: ahci 0000:00:11.0: version 3.0
Oct 14 08:55:02 eanna kernel: ahci 0000:00:11.0: AHCI 0001.0100 32 slots 6 =
ports 3 Gbps 0x3f impl SATA mode
Oct 14 08:55:02 eanna kernel: ahci 0000:00:11.0: flags: 64bit ncq sntf ilck=
 pm led clo pmp pio slum part ccc=20
Oct 14 08:55:02 eanna kernel: scsi host1: ahci
Oct 14 08:55:02 eanna kernel: scsi host2: ahci
Oct 14 08:55:02 eanna kernel: scsi host3: ahci
Oct 14 08:55:02 eanna kernel: scsi host4: ahci
Oct 14 08:55:02 eanna kernel: scsi host5: ahci
Oct 14 08:55:02 eanna kernel: scsi host6: ahci
Oct 14 08:55:02 eanna kernel: ata1: SATA max UDMA/133 abar m1024@0xdf5f8400=
 port 0xdf5f8500 irq 22
Oct 14 08:55:02 eanna kernel: ata2: SATA max UDMA/133 abar m1024@0xdf5f8400=
 port 0xdf5f8580 irq 22
Oct 14 08:55:02 eanna kernel: ata3: SATA max UDMA/133 abar m1024@0xdf5f8400=
 port 0xdf5f8600 irq 22
Oct 14 08:55:02 eanna kernel: ata4: SATA max UDMA/133 abar m1024@0xdf5f8400=
 port 0xdf5f8680 irq 22
Oct 14 08:55:02 eanna kernel: ata5: SATA max UDMA/133 abar m1024@0xdf5f8400=
 port 0xdf5f8700 irq 22
Oct 14 08:55:02 eanna kernel: ata6: SATA max UDMA/133 abar m1024@0xdf5f8400=
 port 0xdf5f8780 irq 22
Oct 14 08:55:02 eanna kernel: usb 2-3: new high-speed USB device number 2 u=
sing xhci_hcd
Oct 14 08:55:02 eanna kernel: hub 3-3:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 3-3:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: mpt2sas0: Allocated physical memory: size(392=
7 kB)
Oct 14 08:55:02 eanna kernel: mpt2sas0: Current Controller Queue Depth(1723=
), Max Controller Queue Depth(1952)
Oct 14 08:55:02 eanna kernel: mpt2sas0: Scatter Gather Elements per IO(128)
Oct 14 08:55:02 eanna kernel: hub 2-3:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 2-3:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: usb 5-1: new full-speed USB device number 2 u=
sing ohci-pci
Oct 14 08:55:02 eanna kernel: mpt2sas0: LSISAS2008: FWVersion(11.00.00.00),=
 ChipRevision(0x03), BiosVersion(07.21.00.00)
Oct 14 08:55:02 eanna kernel: mpt2sas0: Protocol=3D(Initiator), Capabilitie=
s=3D(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
Oct 14 08:55:02 eanna kernel: scsi host0: Fusion MPT SAS Host
Oct 14 08:55:02 eanna kernel: mpt2sas0: sending port enable !!
Oct 14 08:55:02 eanna kernel: ata3: SATA link down (SStatus 0 SControl 300)
Oct 14 08:55:02 eanna kernel: ata4: SATA link down (SStatus 0 SControl 300)
Oct 14 08:55:02 eanna kernel: ata5: SATA link down (SStatus 0 SControl 300)
Oct 14 08:55:02 eanna kernel: usb 9-1: new full-speed USB device number 2 u=
sing ohci-pci
Oct 14 08:55:02 eanna kernel: hub 5-1:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 5-1:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: tsc: Refined TSC clocksource calibration: 280=
0.000 MHz
Oct 14 08:55:02 eanna kernel: clocksource: tsc: mask: 0xffffffffffffffff ma=
x_cycles: 0x285c40e2248, max_idle_ns: 440795340634 ns
Oct 14 08:55:02 eanna kernel: ata6: SATA link up 1.5 Gbps (SStatus 113 SCon=
trol 300)
Oct 14 08:55:02 eanna kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SCon=
trol 300)
Oct 14 08:55:02 eanna kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SCon=
trol 300)
Oct 14 08:55:02 eanna kernel: ata1.00: READ LOG DMA EXT failed, trying unqu=
eued
Oct 14 08:55:02 eanna kernel: ata2.00: READ LOG DMA EXT failed, trying unqu=
eued
Oct 14 08:55:02 eanna kernel: ata1.00: failed to get NCQ Send/Recv Log Emas=
k 0x1
Oct 14 08:55:02 eanna kernel: ata1.00: ATA-9: Samsung SSD 840 PRO Series, D=
XM05B0Q, max UDMA/133
Oct 14 08:55:02 eanna kernel: ata1.00: 1000215216 sectors, multi 16: LBA48 =
NCQ (depth 31/32), AA
Oct 14 08:55:02 eanna kernel: ata2.00: failed to get NCQ Send/Recv Log Emas=
k 0x1
Oct 14 08:55:02 eanna kernel: ata2.00: ATA-9: Samsung SSD 840 PRO Series, D=
XM05B0Q, max UDMA/133
Oct 14 08:55:02 eanna kernel: ata2.00: 1000215216 sectors, multi 16: LBA48 =
NCQ (depth 31/32), AA
Oct 14 08:55:02 eanna kernel: ata1.00: failed to get NCQ Send/Recv Log Emas=
k 0x1
Oct 14 08:55:02 eanna kernel: ata2.00: failed to get NCQ Send/Recv Log Emas=
k 0x1
Oct 14 08:55:02 eanna kernel: ata1.00: configured for UDMA/133
Oct 14 08:55:02 eanna kernel: ata2.00: configured for UDMA/133
Oct 14 08:55:02 eanna kernel: scsi: waiting for bus probes to complete ...
Oct 14 08:55:02 eanna kernel: ata6.00: ATAPI: ATAPI   iHAS124   W, HL0A, ma=
x UDMA/100
Oct 14 08:55:02 eanna kernel: ata6.00: configured for UDMA/100
Oct 14 08:55:02 eanna kernel: hidraw: raw HID events driver (C) Jiri Kosina
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver usbh=
id
Oct 14 08:55:02 eanna kernel: usbhid: USB HID core driver
Oct 14 08:55:02 eanna kernel: input: Winbond Electronics Corp Hermon USB hi=
dmouse Device as /devices/pci0000:00/0000:00:14.5/usb9/9-1/9-1:1.0/0003:055=
7:2221.0001/input/input2
Oct 14 08:55:02 eanna kernel: hid-generic 0003:0557:2221.0001: input,hidraw=
0: USB HID v1.00 Mouse [Winbond Electronics Corp Hermon USB hidmouse Device=
] on usb-0000:00:14.5-1/input0
Oct 14 08:55:02 eanna kernel: input: Winbond Electronics Corp Hermon USB hi=
dmouse Device as /devices/pci0000:00/0000:00:14.5/usb9/9-1/9-1:1.1/0003:055=
7:2221.0002/input/input3
Oct 14 08:55:02 eanna kernel: usb 2-3.3: new full-speed USB device number 3=
 using xhci_hcd
Oct 14 08:55:02 eanna kernel: hid-generic 0003:0557:2221.0002: input,hidraw=
1: USB HID v1.00 Keyboard [Winbond Electronics Corp Hermon USB hidmouse Dev=
ice] on usb-0000:00:14.5-1/input1
Oct 14 08:55:02 eanna kernel: usb 6-3: new full-speed USB device number 2 u=
sing ohci-pci
Oct 14 08:55:02 eanna kernel: usb 2-3.3: ep 0x81 - rounding interval to 512=
 microframes, ep desc says 800 microframes
Oct 14 08:55:02 eanna kernel: hid-generic 0003:051D:0002.0003: hiddev0,hidr=
aw2: USB HID v1.00 Device [American Power Conversion Back-UPS BX1500G FW:86=
6.L5 .D USB FW:L5 ] on usb-0000:41:00.0-3.3/input0
Oct 14 08:55:02 eanna kernel: usb 5-2: new low-speed USB device number 3 us=
ing ohci-pci
Oct 14 08:55:02 eanna kernel: usb 2-3.4: new high-speed USB device number 4=
 using xhci_hcd
Oct 14 08:55:02 eanna kernel: input: Kensington      Kensington Expert Mous=
e as /devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2:1.0/0003:047D:1020.0004/=
input/input4
Oct 14 08:55:02 eanna kernel: hid-generic 0003:047D:1020.0004: input,hidraw=
3: USB HID v1.10 Mouse [Kensington      Kensington Expert Mouse] on usb-000=
0:00:12.0-2/input0
Oct 14 08:55:02 eanna kernel: usb 5-1.2: new full-speed USB device number 4=
 using ohci-pci
Oct 14 08:55:02 eanna kernel: input: HID 05f3:0007 as /devices/pci0000:00/0=
000:00:12.0/usb5/5-1/5-1.2/5-1.2:1.0/0003:05F3:0007.0005/input/input5
Oct 14 08:55:02 eanna kernel: hid-generic 0003:05F3:0007.0005: input,hidraw=
4: USB HID v1.00 Keyboard [HID 05f3:0007] on usb-0000:00:12.0-1.2/input0
Oct 14 08:55:02 eanna kernel: input: HID 05f3:0007 as /devices/pci0000:00/0=
000:00:12.0/usb5/5-1/5-1.2/5-1.2:1.1/0003:05F3:0007.0006/input/input6
Oct 14 08:55:02 eanna kernel: hid-generic 0003:05F3:0007.0006: input,hidraw=
5: USB HID v1.00 Device [HID 05f3:0007] on usb-0000:00:12.0-1.2/input1
Oct 14 08:55:02 eanna kernel: usb 5-1.4: new full-speed USB device number 5=
 using ohci-pci
Oct 14 08:55:02 eanna kernel: usb 5-1.4: not running at top speed; connect =
to a high speed hub
Oct 14 08:55:02 eanna kernel: hub 5-1.4:1.0: USB hub found
Oct 14 08:55:02 eanna kernel: hub 5-1.4:1.0: 4 ports detected
Oct 14 08:55:02 eanna kernel: clocksource: Switched to clocksource tsc
Oct 14 08:55:02 eanna kernel: usb 5-1.4.1: new full-speed USB device number=
 6 using ohci-pci
Oct 14 08:55:02 eanna kernel: usb 5-1.4.1: not running at top speed; connec=
t to a high speed hub
Oct 14 08:55:02 eanna kernel: mpt2sas0: host_add: handle(0x0001), sas_addr(=
0x500304800bc18b00), phys(8)
Oct 14 08:55:02 eanna kernel: mpt2sas0: port enable: SUCCESS
Oct 14 08:55:02 eanna kernel: scsi 0:0:0:0: Direct-Access     ATA      Cruc=
ial_CT512M55 MU01 PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:0:0: SATA: handle(0x0009), sas_addr(=
0x4433221100000000), phy(0), device_name(0x500a07510cc2b7d0)
Oct 14 08:55:02 eanna kernel: scsi 0:0:0:0: SATA: enclosure_logical_id(0x50=
0304800bc18b00), slot(0)
Oct 14 08:55:02 eanna kernel: scsi 0:0:0:0: atapi(n), ncq(y), asyn_notify(n=
), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:1:0: Direct-Access     ATA      Cruc=
ial_CT512M55 MU01 PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:1:0: SATA: handle(0x000a), sas_addr(=
0x4433221101000000), phy(1), device_name(0x500a07510cc6d954)
Oct 14 08:55:02 eanna kernel: scsi 0:0:1:0: SATA: enclosure_logical_id(0x50=
0304800bc18b00), slot(1)
Oct 14 08:55:02 eanna kernel: scsi 0:0:1:0: atapi(n), ncq(y), asyn_notify(n=
), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:2:0: Direct-Access     ATA      Sams=
ung SSD 840  6B0Q PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:2:0: SATA: handle(0x000b), sas_addr(=
0x4433221104000000), phy(4), device_name(0x50025385a02ab540)
Oct 14 08:55:02 eanna kernel: scsi 0:0:2:0: SATA: enclosure_logical_id(0x50=
0304800bc18b00), slot(4)
Oct 14 08:55:02 eanna kernel: scsi 0:0:2:0: atapi(n), ncq(y), asyn_notify(n=
), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:3:0: Direct-Access     ATA      Sams=
ung SSD 840  6B0Q PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:3:0: SATA: handle(0x000c), sas_addr(=
0x4433221105000000), phy(5), device_name(0x50025385a02ab564)
Oct 14 08:55:02 eanna kernel: scsi 0:0:3:0: SATA: enclosure_logical_id(0x50=
0304800bc18b00), slot(5)
Oct 14 08:55:02 eanna kernel: scsi 0:0:3:0: atapi(n), ncq(y), asyn_notify(n=
), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:4:0: Direct-Access     ATA      Cruc=
ial_CT512M55 MU01 PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:4:0: SATA: handle(0x000d), sas_addr(=
0x4433221102000000), phy(2), device_name(0x500a07510cc6e0d5)
Oct 14 08:55:02 eanna kernel: scsi 0:0:4:0: SATA: enclosure_logical_id(0x50=
0304800bc18b00), slot(2)
Oct 14 08:55:02 eanna kernel: scsi 0:0:4:0: atapi(n), ncq(y), asyn_notify(n=
), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 0:0:5:0: Direct-Access     ATA      Sams=
ung SSD 840  6B0Q PQ: 0 ANSI: 6
Oct 14 08:55:02 eanna kernel: scsi 0:0:5:0: SATA: handle(0x000e), sas_addr(=
0x4433221106000000), phy(6), device_name(0x50025385a02591d0)
Oct 14 08:55:02 eanna kernel: scsi 0:0:5:0: SATA: enclosure_logical_id(0x50=
0304800bc18b00), slot(6)
Oct 14 08:55:02 eanna kernel: scsi 0:0:5:0: atapi(n), ncq(y), asyn_notify(n=
), smart(y), fua(y), sw_preserve(y)
Oct 14 08:55:02 eanna kernel: scsi 1:0:0:0: Direct-Access     ATA      Sams=
ung SSD 840  5B0Q PQ: 0 ANSI: 5
Oct 14 08:55:02 eanna kernel: scsi 2:0:0:0: Direct-Access     ATA      Sams=
ung SSD 840  5B0Q PQ: 0 ANSI: 5
Oct 14 08:55:02 eanna kernel: scsi 6:0:0:0: CD-ROM            ATAPI    iHAS=
124   W      HL0A PQ: 0 ANSI: 5
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] physical block alignment of=
fset: 4096
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] 1000215216 512-byte logical=
 blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] 4096-byte physical blocks
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] physical block alignment of=
fset: 4096
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] 1000215216 512-byte logical=
 blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] 4096-byte physical blocks
Oct 14 08:55:02 eanna kernel: ata1.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] 1000215216 512-byte logical=
 blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] physical block alignment of=
fset: 4096
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] 1000215216 512-byte logical=
 blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] 4096-byte physical blocks
Oct 14 08:55:02 eanna kernel: ata2.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] 1000215216 512-byte logical=
 blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] Write cache: enabled, read =
cache: enabled, doesn&#39;t support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] Mode Sense: 00 3a 00 00
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] 1000215216 512-byte logical=
 blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] Write cache: enabled, read =
cache: enabled, doesn&#39;t support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] 1000215216 512-byte logical=
 blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel: ata1.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: ata2.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] 1000215216 512-byte logical=
 blocks: (512 GB/476 GiB)
Oct 14 08:55:02 eanna kernel:  sdg:
Oct 14 08:55:02 eanna kernel: ata1.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 1:0:0:0: [sdg] Attached SCSI disk
Oct 14 08:55:02 eanna kernel:  sdh:
Oct 14 08:55:02 eanna kernel: ata2.00: Enabling discard_zeroes_data
Oct 14 08:55:02 eanna kernel: sd 2:0:0:0: [sdh] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] Write cache: enabled, read =
cache: enabled, doesn&#39;t support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] Write cache: enabled, read =
cache: enabled, doesn&#39;t support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] Write cache: enabled, read =
cache: enabled, doesn&#39;t support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:2:0: [sdc] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:3:0: [sdd] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:5:0: [sdf] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sr 6:0:0:0: [sr0] scsi3-mmc drive: 188x/125x =
writer dvd-ram cd/rw xa/form2 cdda tray
Oct 14 08:55:02 eanna kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Oct 14 08:55:02 eanna kernel: sr 6:0:0:0: Attached scsi CD-ROM sr0
Oct 14 08:55:02 eanna kernel: raid6: sse2x1   gen()  5479 MB/s
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] Write cache: enabled, read =
cache: enabled, doesn&#39;t support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] Write cache: enabled, read =
cache: enabled, doesn&#39;t support DPO or FUA
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] Write Protect is off
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] Mode Sense: 7f 00 00 08
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] Write cache: enabled, read =
cache: enabled, doesn&#39;t support DPO or FUA
Oct 14 08:55:02 eanna kernel: raid6: sse2x1   xor()  3665 MB/s
Oct 14 08:55:02 eanna kernel: raid6: sse2x2   gen()  8838 MB/s
Oct 14 08:55:02 eanna kernel: raid6: sse2x2   xor()  5941 MB/s
Oct 14 08:55:02 eanna kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:4:0: [sde] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: sd 0:0:1:0: [sdb] Attached SCSI disk
Oct 14 08:55:02 eanna kernel: raid6: sse2x4   gen() 10414 MB/s
Oct 14 08:55:02 eanna kernel: raid6: sse2x4   xor()  3761 MB/s
Oct 14 08:55:02 eanna kernel: raid6: using algorithm sse2x4 gen() 10414 MB/=
s
Oct 14 08:55:02 eanna kernel: raid6: .... xor() 3761 MB/s, rmw enabled
Oct 14 08:55:02 eanna kernel: raid6: using ssse3x2 recovery algorithm
Oct 14 08:55:02 eanna kernel: xor: automatically using best checksumming fu=
nction:
Oct 14 08:55:02 eanna kernel:    avx       :  3436.800 MB/sec
Oct 14 08:55:02 eanna kernel: Btrfs loaded
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 4 transid 3441=
48 /dev/sdc
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 2 transid 3441=
48 /dev/sdb
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 3 transid 3441=
48 /dev/sde
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 1 transid 3441=
48 /dev/sda
Oct 14 08:55:02 eanna kernel: BTRFS: device label system devid 1 transid 98=
8898 /dev/sdg
Oct 14 08:55:02 eanna kernel: BTRFS: device label system devid 2 transid 98=
8898 /dev/sdh
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 6 transid 3441=
48 /dev/sdf
Oct 14 08:55:02 eanna kernel: BTRFS: device label data devid 5 transid 3441=
48 /dev/sdd
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdh): disk space caching i=
s enabled
Oct 14 08:55:02 eanna kernel: BTRFS: detected SSD devices, enabling SSD mod=
e
Oct 14 08:55:02 eanna kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Oct 14 08:55:02 eanna systemd[1]: systemd 226 running in system mode. (+PAM=
 -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRY=
PT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN)
Oct 14 08:55:02 eanna systemd[1]: Detected architecture x86-64.
Oct 14 08:55:02 eanna systemd[1]: Set hostname to &lt;eanna&gt;.
Oct 14 08:55:02 eanna systemd[1]: Configuration file /etc/systemd/system/up=
datedb.service.d/updatedb.conf is marked world-inaccessible. This has no ef=
fect as configuration data is accessible via APIs without restrictions. Pro=
ceeding anyway.
Oct 14 08:55:02 eanna systemd[1]: Configuration file /etc/systemd/system/sy=
sstat-collect.service.d/sysstat-collect.conf is marked world-inaccessible. =
This has no effect as configuration data is accessible via APIs without res=
trictions. Proceeding anyway.
Oct 14 08:55:02 eanna systemd[1]: Reached target Login Prompts.
Oct 14 08:55:02 eanna systemd[1]: Listening on Journal Socket.
Oct 14 08:55:02 eanna systemd[1]: Reached target Encrypted Volumes.
Oct 14 08:55:02 eanna systemd[1]: Listening on udev Control Socket.
Oct 14 08:55:02 eanna systemd[1]: Listening on /dev/initctl Compatibility N=
amed Pipe.
Oct 14 08:55:02 eanna systemd[1]: Reached target Swap.
Oct 14 08:55:02 eanna systemd[1]: Created slice User and Session Slice.
Oct 14 08:55:02 eanna systemd[1]: Listening on udev Kernel Socket.
Oct 14 08:55:02 eanna systemd[1]: Created slice System Slice.
Oct 14 08:55:02 eanna systemd[1]: Mounting Debug File System...
Oct 14 08:55:02 eanna systemd[1]: Starting Load Kernel Modules...
Oct 14 08:55:02 eanna systemd[1]: Starting Remount Root and Kernel File Sys=
tems...
Oct 14 08:55:02 eanna systemd[1]: Mounting Huge Pages File System...
Oct 14 08:55:02 eanna systemd[1]: Mounting POSIX Message Queue File System.=
..
Oct 14 08:55:02 eanna systemd[1]: Mounting Temporary Directory...
Oct 14 08:55:02 eanna systemd[1]: Starting Create list of required static d=
evice nodes for the current kernel...
Oct 14 08:55:02 eanna systemd[1]: Reached target Remote File Systems.
Oct 14 08:55:02 eanna systemd[1]: Starting Setup Virtual Console...
Oct 14 08:55:02 eanna systemd[1]: Created slice system-getty.slice.
Oct 14 08:55:02 eanna systemd[1]: Reached target Host and Network Name Look=
ups.
Oct 14 08:55:02 eanna systemd[1]: Created slice system-insync.slice.
Oct 14 08:55:02 eanna systemd[1]: Reached target RPC Port Mapper.
Oct 14 08:55:02 eanna systemd[1]: Set up automount Arbitrary Executable Fil=
e Formats File System Automount Point.
Oct 14 08:55:02 eanna systemd[1]: Starting Set Up Additional Binary Formats=
...
Oct 14 08:55:02 eanna systemd[1]: Started Dispatch Password Requests to Con=
sole Directory Watch.
Oct 14 08:55:02 eanna systemd[1]: Listening on Journal Socket (/dev/log).
Oct 14 08:55:02 eanna systemd[1]: Listening on Device-mapper event daemon F=
IFOs.
Oct 14 08:55:02 eanna systemd[1]: Listening on LVM2 metadata daemon socket.
Oct 14 08:55:02 eanna systemd[1]: Started Forward Password Requests to Wall=
 Directory Watch.
Oct 14 08:55:02 eanna systemd[1]: Reached target Slices.
Oct 14 08:55:02 eanna systemd[1]: Starting Journal Service...
Oct 14 08:55:02 eanna systemd[1]: Mounting NFSD configuration filesystem...
Oct 14 08:55:02 eanna kernel: ipmi message handler version 39.2
Oct 14 08:55:02 eanna systemd[1]: Started Create list of required static de=
vice nodes for the current kernel.
Oct 14 08:55:02 eanna systemd[1]: proc-sys-fs-binfmt_misc.automount: Got au=
tomount request for /proc/sys/fs/binfmt_misc, triggered by 426 (systemd-bin=
fmt)
Oct 14 08:55:02 eanna systemd[1]: Mounting Arbitrary Executable File Format=
s File System...
Oct 14 08:55:02 eanna kernel: ipmi device interface
Oct 14 08:55:02 eanna kernel: IPMI System Interface driver.
Oct 14 08:55:02 eanna kernel: ipmi_si: probing via SMBIOS
Oct 14 08:55:02 eanna kernel: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1=
 irq 0
Oct 14 08:55:02 eanna kernel: ipmi_si: Adding SMBIOS-specified kcs state ma=
chine
Oct 14 08:55:02 eanna kernel: ipmi_si: Trying SMBIOS-specified kcs state ma=
chine at i/o address 0xca2, slave address 0x0, irq 0
Oct 14 08:55:02 eanna systemd[1]: Mounted Arbitrary Executable File Formats=
 File System.
Oct 14 08:55:02 eanna systemd[1]: Mounted Debug File System.
Oct 14 08:55:02 eanna systemd[1]: Mounted POSIX Message Queue File System.
Oct 14 08:55:02 eanna systemd[1]: Mounted Temporary Directory.
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdh): enabling auto defrag
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdh): enabling inode map c=
aching
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdh): disk space caching i=
s enabled
Oct 14 08:55:02 eanna systemd[1]: Started Remount Root and Kernel File Syst=
ems.
Oct 14 08:55:02 eanna systemd[1]: Mounted Huge Pages File System.
Oct 14 08:55:02 eanna systemd[1]: Started Set Up Additional Binary Formats.
Oct 14 08:55:02 eanna systemd[1]: Starting Create Static Device Nodes in /d=
ev...
Oct 14 08:55:02 eanna systemd[1]: Starting udev Coldplug all Devices...
Oct 14 08:55:02 eanna kernel: RPC: Registered named UNIX socket transport m=
odule.
Oct 14 08:55:02 eanna kernel: RPC: Registered udp transport module.
Oct 14 08:55:02 eanna kernel: RPC: Registered tcp transport module.
Oct 14 08:55:02 eanna kernel: RPC: Registered tcp NFSv4.1 backchannel trans=
port module.
Oct 14 08:55:02 eanna kernel: Installing knfsd (copyright (C) 1996 <a href=
=3D"mailto:okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org">okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org</a>).
Oct 14 08:55:02 eanna systemd[1]: Mounted NFSD configuration filesystem.
Oct 14 08:55:02 eanna systemd[1]: Started Create Static Device Nodes in /de=
v.
Oct 14 08:55:02 eanna systemd[1]: Starting udev Kernel Device Manager...
Oct 14 08:55:02 eanna systemd[1]: Reached target Local File Systems (Pre).
Oct 14 08:55:02 eanna systemd[1]: Mounting /.bind...
Oct 14 08:55:02 eanna systemd[1]: Mounted /.bind.
Oct 14 08:55:02 eanna systemd[1]: Started Setup Virtual Console.
Oct 14 08:55:02 eanna systemd[1]: Started Journal Service.
Oct 14 08:55:02 eanna kernel: ipmi_si: The BMC does not support clearing th=
e recv irq bit, compensating, but the BMC needs to be fixed.
Oct 14 08:55:02 eanna kernel: ACPI: acpi_idle registered with cpuidle
Oct 14 08:55:02 eanna kernel: shpchp: Standard Hot Plug PCI Controller Driv=
er version: 0.4
Oct 14 08:55:02 eanna kernel: input: Power Button as /devices/LNXSYSTM:00/L=
NXSYBUS:00/PNP0C0C:00/input/input7
Oct 14 08:55:02 eanna kernel: ACPI: Power Button [PWRB]
Oct 14 08:55:02 eanna kernel: input: Power Button as /devices/LNXSYSTM:00/L=
NXPWRBN:00/input/input8
Oct 14 08:55:02 eanna kernel: ACPI: Power Button [PWRF]
Oct 14 08:55:02 eanna kernel: acpi-cpufreq: overriding BIOS provided _PSD d=
ata
Oct 14 08:55:02 eanna kernel: MCE: In-kernel MCE decoding enabled.
Oct 14 08:55:02 eanna kernel: dca service started, version 1.12.1
Oct 14 08:55:02 eanna kernel: pps_core: LinuxPPS API ver. 1 registered
Oct 14 08:55:02 eanna kernel: pps_core: Software ver. 5.3.6 - Copyright 200=
5-2007 Rodolfo Giometti &lt;<a href=3D"mailto:giometti-k2GhghHVRtY@public.gmane.org">giometti@l=
inux.it</a>&gt;
Oct 14 08:55:02 eanna kernel: piix4_smbus 0000:00:14.0: SMBus Host Controll=
er at 0xb00, revision 0
Oct 14 08:55:02 eanna kernel: piix4_smbus 0000:00:14.0: Auxiliary SMBus Hos=
t Controller at 0xb20
Oct 14 08:55:02 eanna kernel: PTP clock support registered
Oct 14 08:55:02 eanna kernel: EDAC MC: Ver: 3.0.0
Oct 14 08:55:02 eanna kernel: input: PC Speaker as /devices/platform/pcspkr=
/input/input9
Oct 14 08:55:02 eanna kernel: AMD64 EDAC driver v3.4.0
Oct 14 08:55:02 eanna kernel: EDAC amd64: DRAM ECC enabled.
Oct 14 08:55:02 eanna kernel: EDAC amd64: F15h detected (node 0).
Oct 14 08:55:02 eanna kernel: EDAC MC: DCT0 chip selects:
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 0:     0MB 1:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 2:  8192MB 3:  8192MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 4:     0MB 5:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 6:     0MB 7:     0MB
Oct 14 08:55:02 eanna kernel: EDAC MC: DCT1 chip selects:
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 0:     0MB 1:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 2:  8192MB 3:  8192MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 4:     0MB 5:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 6:     0MB 7:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: using x8 syndromes.
Oct 14 08:55:02 eanna kernel: EDAC amd64: MCT channel count: 2
Oct 14 08:55:02 eanna kernel: sp5100_tco: SP5100/SB800 TCO WatchDog Timer D=
river v0.05
Oct 14 08:55:02 eanna kernel: sp5100_tco: PCI Revision ID: 0x3d
Oct 14 08:55:02 eanna kernel: sp5100_tco: failed to find MMIO address, givi=
ng up.
Oct 14 08:55:02 eanna kernel: EDAC MC0: Giving out device to module amd64_e=
dac controller F15h: DEV 0000:00:18.2 (INTERRUPT)
Oct 14 08:55:02 eanna kernel: EDAC amd64: DRAM ECC disabled.
Oct 14 08:55:02 eanna kernel: EDAC amd64: ECC disabled in the BIOS or no EC=
C capability, module will not load.
                               Either enable ECC checking or force module l=
oading by setting &#39;ecc_enable_override&#39;.
                               (Note that use of the override may cause unk=
nown side effects.)
Oct 14 08:55:02 eanna kernel: EDAC amd64: DRAM ECC enabled.
Oct 14 08:55:02 eanna kernel: EDAC amd64: F15h detected (node 2).
Oct 14 08:55:02 eanna kernel: EDAC MC: DCT0 chip selects:
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 0:     0MB 1:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 2:  8192MB 3:  8192MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 4:     0MB 5:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 6:     0MB 7:     0MB
Oct 14 08:55:02 eanna kernel: EDAC MC: DCT1 chip selects:
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 0:     0MB 1:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 2:  8192MB 3:  8192MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 4:     0MB 5:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: MC: 6:     0MB 7:     0MB
Oct 14 08:55:02 eanna kernel: EDAC amd64: using x8 syndromes.
Oct 14 08:55:02 eanna kernel: EDAC amd64: MCT channel count: 2
Oct 14 08:55:02 eanna kernel: EDAC MC2: Giving out device to module amd64_e=
dac controller F15h: DEV 0000:00:1a.2 (INTERRUPT)
Oct 14 08:55:02 eanna kernel: EDAC amd64: DRAM ECC disabled.
Oct 14 08:55:02 eanna kernel: EDAC amd64: ECC disabled in the BIOS or no EC=
C capability, module will not load.
                               Either enable ECC checking or force module l=
oading by setting &#39;ecc_enable_override&#39;.
                               (Note that use of the override may cause unk=
nown side effects.)
Oct 14 08:55:02 eanna kernel: EDAC PCI0: Giving out device to module amd64_=
edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
Oct 14 08:55:02 eanna kernel: igb: Intel(R) Gigabit Ethernet Network Driver=
 - version 5.2.18-k
Oct 14 08:55:02 eanna kernel: igb: Copyright (c) 2007-2014 Intel Corporatio=
n.
Oct 14 08:55:02 eanna kernel: [drm] Initialized drm 1.1.0 20060810
Oct 14 08:55:02 eanna kernel: snd_hda_intel 0000:42:00.1: Handle VGA-switch=
eroo audio client
Oct 14 08:55:02 eanna kernel: snd_hda_intel 0000:42:00.1: Force to non-snoo=
p mode
Oct 14 08:55:02 eanna kernel: AVX version of gcm_enc/dec engaged.
Oct 14 08:55:02 eanna kernel: AES CTR mode by8 optimization enabled
Oct 14 08:55:02 eanna kernel: [drm] radeon kernel modesetting enabled.
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver usbs=
erial
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver usbs=
erial_generic
Oct 14 08:55:02 eanna kernel: usbserial: USB Serial support registered for =
generic
Oct 14 08:55:02 eanna kernel: mousedev: PS/2 mouse device common for all mi=
ce
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devic=
es/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input11
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devic=
es/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input12
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devic=
es/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input13
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devic=
es/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input14
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devi=
ces/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input15
Oct 14 08:55:02 eanna kernel: input: HDA ATI HDMI HDMI/DP,pcm=3D11 as /devi=
ces/pci0000:40/0000:40:02.0/0000:42:00.1/sound/card1/input16
Oct 14 08:55:02 eanna kernel: AMD IOMMUv2 driver by Joerg Roedel &lt;<a hre=
f=3D"mailto:jroedel-l3A5Bk7waGM@public.gmane.org">jroedel-l3A5Bk7waGM@public.gmane.org</a>&gt;
Oct 14 08:55:02 eanna kernel: AMD IOMMUv2 functionality not available on th=
is system
Oct 14 08:55:02 eanna kernel: kvm: Nested Virtualization enabled
Oct 14 08:55:02 eanna kernel: kvm: Nested Paging enabled
Oct 14 08:55:02 eanna kernel: CRAT table not found
Oct 14 08:55:02 eanna kernel: Finished initializing topology ret=3D0
Oct 14 08:55:02 eanna kernel: kfd kfd: Initialized module
Oct 14 08:55:02 eanna kernel: checking generic (c0000000 7f0000) vs hw (c00=
00000 10000000)
Oct 14 08:55:02 eanna kernel: fb: switching to radeondrmfb from VESA VGA
Oct 14 08:55:02 eanna kernel: Console: switching to colour dummy device 80x=
25
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver cp21=
0x
Oct 14 08:55:02 eanna kernel: usbserial: USB Serial support registered for =
cp210x
Oct 14 08:55:02 eanna kernel: cp210x 6-3:1.0: cp210x converter detected
Oct 14 08:55:02 eanna kernel: usb 6-3: cp210x converter now attached to tty=
USB0
Oct 14 08:55:02 eanna kernel: [drm] initializing kernel modesetting (TAHITI=
 0x1002:0x679A 0x103C:0x6617).
Oct 14 08:55:02 eanna kernel: [drm] register mmio base: 0xDBFC0000
Oct 14 08:55:02 eanna kernel: [drm] register mmio size: 262144
Oct 14 08:55:02 eanna kernel: media: Linux media interface: v0.10
Oct 14 08:55:02 eanna kernel: ATOM BIOS: Tahiti
Oct 14 08:55:02 eanna kernel: [drm] Changing default dispclk from 500Mhz to=
 600Mhz
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: VRAM: 3072M 0x0000000000=
000000 - 0x00000000BFFFFFFF (3072M used)
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: GTT: 2048M 0x00000000C00=
00000 - 0x000000013FFFFFFF
Oct 14 08:55:02 eanna kernel: [drm] Detected VRAM RAM=3D3072M, BAR=3D256M
Oct 14 08:55:02 eanna kernel: [drm] RAM width 384bits DDR
Oct 14 08:55:02 eanna kernel: [TTM] Zone  kernel: Available graphics memory=
: 32981114 kiB
Oct 14 08:55:02 eanna kernel: [TTM] Zone   dma32: Available graphics memory=
: 2097152 kiB
Oct 14 08:55:02 eanna kernel: [TTM] Initializing pool allocator
Oct 14 08:55:02 eanna kernel: [TTM] Initializing DMA pool allocator
Oct 14 08:55:02 eanna kernel: [drm] radeon: 3072M of VRAM memory ready
Oct 14 08:55:02 eanna kernel: [drm] radeon: 2048M of GTT memory ready.
Oct 14 08:55:02 eanna kernel: [drm] Loading tahiti Microcode
Oct 14 08:55:02 eanna kernel: Linux video capture interface: v2.00
Oct 14 08:55:02 eanna kernel: [drm] Internal thermal controller with fan co=
ntrol
Oct 14 08:55:02 eanna kernel: [drm] probing gen 2 caps for device 1002:5a16=
 =3D 31cd02/0
Oct 14 08:55:02 eanna kernel: [drm] radeon: dpm initialized
Oct 14 08:55:02 eanna kernel: [drm] Found VCE firmware/feedback version 50.=
0.1 / 17!
Oct 14 08:55:02 eanna kernel: [drm] GART: num cpu pages 524288, num gpu pag=
es 524288
Oct 14 08:55:02 eanna kernel: uvcvideo: Found UVC 1.00 device HD Pro Webcam=
 C920 (046d:082d)
Oct 14 08:55:02 eanna kernel: [drm] probing gen 2 caps for device 1002:5a16=
 =3D 31cd02/0
Oct 14 08:55:02 eanna kernel: [drm] PCIE gen 2 link speeds already enabled
Oct 14 08:55:02 eanna kernel: input: HD Pro Webcam C920 as /devices/pci0000=
:40/0000:40:04.0/0000:41:00.0/usb2/2-3/2-3.4/2-3.4:1.0/input/input17
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver uvcv=
ideo
Oct 14 08:55:02 eanna kernel: USB Video Class driver (1.1.1)
Oct 14 08:55:02 eanna kernel: [drm] PCIE GART of 2048M enabled (table at 0x=
00000000002E8000).
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: WB enabled
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on ring 0 u=
se gpu addr 0x00000000c0000c00 and cpu addr 0xffff8810133dac00
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on ring 1 u=
se gpu addr 0x00000000c0000c04 and cpu addr 0xffff8810133dac04
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on ring 2 u=
se gpu addr 0x00000000c0000c08 and cpu addr 0xffff8810133dac08
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on ring 3 u=
se gpu addr 0x00000000c0000c0c and cpu addr 0xffff8810133dac0c
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on ring 4 u=
se gpu addr 0x00000000c0000c10 and cpu addr 0xffff8810133dac10
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on ring 5 u=
se gpu addr 0x0000000000075a18 and cpu addr 0xffffc90007035a18
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on ring 6 u=
se gpu addr 0x00000000c0000c18 and cpu addr 0xffff8810133dac18
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: fence driver on ring 7 u=
se gpu addr 0x00000000c0000c1c and cpu addr 0xffff8810133dac1c
Oct 14 08:55:02 eanna kernel: [drm] Supports vblank timestamp caching Rev 2=
 (21.10.2013).
Oct 14 08:55:02 eanna kernel: [drm] Driver supports precise vblank timestam=
p query.
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: radeon: MSI limited to 3=
2-bit
Oct 14 08:55:02 eanna kernel: radeon 0000:42:00.0: radeon: using MSI.
Oct 14 08:55:02 eanna kernel: [drm] radeon: irq initialized.
Oct 14 08:55:02 eanna kernel: ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0=
0b980, prod_id: 0xbc11, dev_id: 0x20)
Oct 14 08:55:02 eanna kernel: ipmi_si ipmi_si.0: IPMI kcs interface initial=
ized
Oct 14 08:55:02 eanna kernel: FS-Cache: Loaded
Oct 14 08:55:02 eanna kernel: FS-Cache: Netfs &#39;nfs&#39; registered for =
caching
Oct 14 08:55:02 eanna kernel: usb 5-1.4.1: reset full-speed USB device numb=
er 6 using ohci-pci
Oct 14 08:55:02 eanna kernel: input: Xonar DSX Headphone as /devices/pci000=
0:00/0000:00:04.0/0000:05:00.0/0000:06:00.0/sound/card0/input18
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdd): enabling auto defrag
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdd): use ssd allocation s=
cheme
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdd): enabling inode map c=
aching
Oct 14 08:55:02 eanna kernel: BTRFS info (device sdd): disk space caching i=
s enabled
Oct 14 08:55:02 eanna kernel: BTRFS: has skinny extents
Oct 14 08:55:02 eanna kernel: usbcore: registered new interface driver snd-=
usb-audio
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: added PHC on eth0
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: Intel(R) Gigabit Ethernet N=
etwork Connection
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: eth0: (PCIe:2.5Gb/s:Width x=
4) 00:25:90:ad:a3:bc
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: eth0: PBA No: Unknown
Oct 14 08:55:02 eanna kernel: igb 0000:02:00.0: Using MSI-X interrupts. 8 r=
x queue(s), 8 tx queue(s)
Oct 14 08:55:02 eanna kernel: [drm] ring test on 0 succeeded in 1 usecs
Oct 14 08:55:02 eanna kernel: [drm] ring test on 1 succeeded in 1 usecs
Oct 14 08:55:02 eanna kernel: [drm] ring test on 2 succeeded in 1 usecs
Oct 14 08:55:02 eanna kernel: [drm] ring test on 3 succeeded in 3 usecs
Oct 14 08:55:02 eanna kernel: [drm] ring test on 4 succeeded in 3 usecs
Oct 14 08:55:02 eanna kernel: ieee80211 phy0: rt2x00_set_rt: Info - RT chip=
set 3070, rev 0201 detected
Oct 14 08:55:02 eanna kernel: [drm] ring test on 5 succeeded in 2 usecs
Oct 14 08:55:02 eanna kernel: [drm] UVD initialized successfully.
Oct 14 08:55:03 eanna kernel: [drm] ring test on 6 succeeded in 18 usecs
Oct 14 08:55:03 eanna kernel: [drm] ring test on 7 succeeded in 4 usecs
Oct 14 08:55:03 eanna kernel: [drm] VCE initialized successfully.
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 0 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 1 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 2 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 3 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 4 succeeded in 0 usecs
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: added PHC on eth1
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: Intel(R) Gigabit Ethernet N=
etwork Connection
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: eth1: (PCIe:2.5Gb/s:Width x=
4) 00:25:90:ad:a3:bd
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: eth1: PBA No: Unknown
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1: Using MSI-X interrupts. 8 r=
x queue(s), 8 tx queue(s)
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.1 enp2s0f1: renamed from eth1
Oct 14 08:55:03 eanna kernel: igb 0000:02:00.0 enp2s0f0: renamed from eth0
Oct 14 08:55:03 eanna kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chip=
set 0005 detected
Oct 14 08:55:03 eanna kernel: ieee80211 phy0: Selected rate control algorit=
hm &#39;minstrel_ht&#39;
Oct 14 08:55:03 eanna kernel: usbcore: registered new interface driver rt28=
00usb
Oct 14 08:55:03 eanna kernel: rt2800usb 5-1.4.1:1.0 wlp0s18f0u1u4u1: rename=
d from wlan0
Oct 14 08:55:03 eanna kernel: microcode: CPU0: new patch_level=3D0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU2: new patch_level=3D0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU4: new patch_level=3D0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU6: new patch_level=3D0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU8: new patch_level=3D0x06000832
Oct 14 08:55:03 eanna kernel: microcode: CPU10: new patch_level=3D0x0600083=
2
Oct 14 08:55:03 eanna kernel: microcode: CPU12: new patch_level=3D0x0600083=
2
Oct 14 08:55:03 eanna kernel: microcode: CPU14: new patch_level=3D0x0600083=
2
Oct 14 08:55:03 eanna kernel: microcode: CPU16: new patch_level=3D0x0600083=
2
Oct 14 08:55:03 eanna kernel: microcode: CPU18: new patch_level=3D0x0600083=
2
Oct 14 08:55:03 eanna kernel: microcode: CPU20: new patch_level=3D0x0600083=
2
Oct 14 08:55:03 eanna kernel: microcode: CPU22: new patch_level=3D0x0600083=
2
Oct 14 08:55:03 eanna kernel: [drm] ib test on ring 5 succeeded
Oct 14 08:55:03 eanna kernel: random: nonblocking pool is initialized
Oct 14 08:55:03 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): enp2s0f1: link is =
not ready
Oct 14 08:55:04 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): enp2s0f1: link is =
not ready
Oct 14 08:55:04 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): enp2s0f0: link is =
not ready
Oct 14 08:55:04 eanna kernel: [drm] ib test on ring 6 succeeded
Oct 14 08:55:04 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): enp2s0f0: link is =
not ready
Oct 14 08:55:04 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): wlp0s18f0u1u4u1: l=
ink is not ready
Oct 14 08:55:04 eanna kernel: [drm] ib test on ring 7 succeeded
Oct 14 08:55:04 eanna kernel: [drm] Radeon Display Connectors
Oct 14 08:55:04 eanna kernel: [drm] Connector 0:
Oct 14 08:55:04 eanna kernel: [drm]   DP-1
Oct 14 08:55:04 eanna kernel: [drm]   HPD5
Oct 14 08:55:04 eanna kernel: [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x65=
38 0x6538 0x653c 0x653c
Oct 14 08:55:04 eanna kernel: [drm]   Encoders:
Oct 14 08:55:04 eanna kernel: [drm]     DFP1: INTERNAL_UNIPHY2
Oct 14 08:55:04 eanna kernel: [drm] Connector 1:
Oct 14 08:55:04 eanna kernel: [drm]   DP-2
Oct 14 08:55:04 eanna kernel: [drm]   HPD4
Oct 14 08:55:04 eanna kernel: [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x65=
48 0x6548 0x654c 0x654c
Oct 14 08:55:04 eanna kernel: [drm]   Encoders:
Oct 14 08:55:04 eanna kernel: [drm]     DFP2: INTERNAL_UNIPHY2
Oct 14 08:55:04 eanna kernel: [drm] Connector 2:
Oct 14 08:55:04 eanna kernel: [drm]   HDMI-A-1
Oct 14 08:55:04 eanna kernel: [drm]   HPD1
Oct 14 08:55:04 eanna kernel: [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x65=
68 0x6568 0x656c 0x656c
Oct 14 08:55:04 eanna kernel: [drm]   Encoders:
Oct 14 08:55:04 eanna kernel: [drm]     DFP3: INTERNAL_UNIPHY1
Oct 14 08:55:04 eanna kernel: [drm] Connector 3:
Oct 14 08:55:04 eanna kernel: [drm]   DVI-I-1
Oct 14 08:55:04 eanna kernel: [drm]   HPD3
Oct 14 08:55:04 eanna kernel: [drm]   DDC: 0x6580 0x6580 0x6584 0x6584 0x65=
88 0x6588 0x658c 0x658c
Oct 14 08:55:04 eanna kernel: [drm]   Encoders:
Oct 14 08:55:04 eanna kernel: [drm]     DFP4: INTERNAL_UNIPHY
Oct 14 08:55:04 eanna kernel: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Oct 14 08:55:04 eanna kernel: traps: gnome-shell[799] trap int3 ip:7f8318c2=
364b sp:7ffe75fa77c0 error:0
Oct 14 08:55:04 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD:=
 no speaker allocation for ELD
Oct 14 08:55:04 eanna kernel: fuse init (API version 7.23)
Oct 14 08:55:04 eanna kernel: [drm] fb mappable at 0xC06EA000
Oct 14 08:55:04 eanna kernel: [drm] vram apper at 0xC0000000
Oct 14 08:55:04 eanna kernel: [drm] size 8294400
Oct 14 08:55:04 eanna kernel: [drm] fb depth is 24
Oct 14 08:55:04 eanna kernel: [drm]    pitch is 7680
Oct 14 08:55:04 eanna kernel: fbcon: radeondrmfb (fb0) is primary device
Oct 14 08:55:05 eanna kernel: Console: switching to colour frame buffer dev=
ice 240x67
Oct 14 08:55:05 eanna kernel: radeon 0000:42:00.0: fb0: radeondrmfb frame b=
uffer device
Oct 14 08:55:05 eanna kernel: radeon 0000:42:00.0: registered panic notifie=
r
Oct 14 08:55:05 eanna kernel: [drm] Initialized radeon 2.43.0 20080528 for =
0000:42:00.0 on minor 0
Oct 14 08:55:05 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD:=
 no speaker allocation for ELD
Oct 14 08:55:05 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD:=
 no speaker allocation for ELD
Oct 14 08:55:05 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD:=
 no speaker allocation for ELD
Oct 14 08:55:06 eanna kernel: snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD:=
 no speaker allocation for ELD
Oct 14 08:55:06 eanna kernel: igb 0000:02:00.1 enp2s0f1: igb: enp2s0f1 NIC =
Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
Oct 14 08:55:06 eanna kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f1: link=
 becomes ready
Oct 14 08:55:08 eanna kernel: usb 2-3.4: reset high-speed USB device number=
 4 using xhci_hcd
Oct 14 08:55:11 eanna kernel: NFSD: starting 90-second grace period (net ff=
ffffff818aed80)
Oct 14 08:55:12 eanna kernel: ip6_tables: (C) 2000-2006 Netfilter Core Team
Oct 14 08:55:12 eanna kernel: Ebtables v2.0 registered
Oct 14 08:55:12 eanna kernel: bridge: automatic filtering via arp/ip/ip6tab=
les has been deprecated. Update your scripts to load br_netfilter if you ne=
ed this.
Oct 14 08:55:12 eanna kernel: tun: Universal TUN/TAP device driver, 1.6
Oct 14 08:55:12 eanna kernel: tun: (C) 1999-2004 Max Krasnyansky &lt;<a hre=
f=3D"mailto:maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org">maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org</a>&gt;
Oct 14 08:55:12 eanna kernel: device virbr0-nic entered promiscuous mode
Oct 14 08:55:12 eanna kernel: nf_conntrack version 0.5.0 (65536 buckets, 26=
2144 max)
Oct 14 08:55:13 eanna kernel: virbr0: port 1(virbr0-nic) entered listening =
state
Oct 14 08:55:13 eanna kernel: virbr0: port 1(virbr0-nic) entered listening =
state
Oct 14 08:55:13 eanna kernel: IPv6: ADDRCONF(NETDEV_UP): virbr0: link is no=
t ready
Oct 14 08:55:13 eanna kernel: virbr0: port 1(virbr0-nic) entered disabled s=
tate
Oct 14 08:55:13 eanna kernel: device vnet0 entered promiscuous mode
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered listening state
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered listening state
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered disabled state
Oct 14 08:55:13 eanna kernel: device vnet0 left promiscuous mode
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered disabled state
Oct 14 08:55:13 eanna kernel: device vnet0 entered promiscuous mode
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered listening state
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered listening state
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered disabled state
Oct 14 08:55:13 eanna kernel: device vnet0 left promiscuous mode
Oct 14 08:55:13 eanna kernel: virbr0: port 2(vnet0) entered disabled state
Oct 14 08:55:18 eanna kernel: usb 2-3.4: reset high-speed USB device number=
 4 using xhci_hcd
</pre><br class=3D""><br></div></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Wed, Oct 14, 2015 at 2:06 AM, Joerg Roedel <span dir=
=3D"ltr">&lt;<a href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" target=3D"_blank">joro@8byt=
es.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On Sat, Oct 03, 2015 at 05:19:25PM -0700, G. Richard Bellamy wrote:<b=
r>
&gt; What happens: Kernel logs message to journal, kvm VMs no longer work. =
Kernel messages spew at a rate of ~660/sec.<br>
<br>
</span>The problem is that device 00:14.0 is trying to write to the system<=
br>
management area and is forbidden to do so by the IOMMU. Can you please<br>
boot with amd_iommu_dump on the kernel command line and send me dmesg?<br>
<br>
<br>
Thanks,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Joerg<br>
<br>
</blockquote></div><br></div>

--001a11c3e9accae47a052212b957--

--===============5725101990678900342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5725101990678900342==--
