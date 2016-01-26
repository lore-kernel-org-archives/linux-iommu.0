From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v3 00/12] Fix AMD IOMMU faults in kdump kernel
Date: Tue, 26 Jan 2016 18:48:54 +0800
Message-ID: <20160126104854.GA18314@dhcp-128-28.nay.redhat.com>
References: <1453804166-25646-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453804166-25646-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached are boot log of 1st kernel and kdump kernel, the output of
'lspci -tv' and 'lspci -vvv'. Patches are based on kernel v4.5-rc1.



--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amd.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 4.5.0-rc1+ (root-U2nCED00ozjD7sV1v1AExoa7Q5UgA9LkuPsksrO3nyI@public.gmane.org=
om) (gcc version 5.3.1 20151207 (Red Hat 5.3.1-2) (GCC) ) #3 SMP Tue Jan 26=
 04:50:54 EST 2016
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-4.5.0-rc1+ root=3D/dev/m=
apper/fedora_amd--dinar--02-root ro rd.lvm.lv=3Dfedora_amd-dinar-02/root rd=
=2Elvm.lv=3Dfedora_amd-dinar-02/swap console=3DttyS0,115200n81 LANG=3Den_US=
=2EUTF-8 crashkernel=3D256M
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point =
registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000097fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000098000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000d2000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c7eaffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c7eb0000-0x00000000c7ec0fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000c7ec1000-0x00000000c7ec2fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000c7ec3000-0x00000000c7efefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000c7f00000-0x00000000c7ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000236ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] e820: last_pfn =3D 0x237000 max_arch_pfn =3D 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT=
 =20
[    0.000000] e820: last_pfn =3D 0xc7eb0 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f7b40-0x000f7b4f] mapped at =
[ffff8800000f7b40]
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x35807000-0x36bfbfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F7B10 000024 (v02 PTLTD )
[    0.000000] ACPI: XSDT 0x00000000C7EB3B22 00009C (v01 PTLTD  ? XSDT   06=
040000  LTP 00000000)
[    0.000000] ACPI: FACP 0x00000000C7EBA50B 0000F4 (v03 AMD    Dinar    06=
040000 AMD  000F4240)
[    0.000000] ACPI: DSDT 0x00000000C7EB3BBE 00694D (v02 AMD    SB700    06=
040000 MSFT 03000001)
[    0.000000] ACPI: FACS 0x00000000C7EC2FC0 000040
[    0.000000] ACPI: FACS 0x00000000C7EC2FC0 000040
[    0.000000] ACPI: TCPA 0x00000000C7EBA673 000032 (v02 AMD             06=
040000 PTEC 00000000)
[    0.000000] ACPI: IVRS 0x00000000C7EBA6A5 0000A8 (v01 AMD    RD890S   06=
040000 AMD  00000000)
[    0.000000] ACPI: EINJ 0x00000000C7EBA74D 0001B0 (v01 PTL    WHEAPTL  06=
040000 PTL  00000001)
[    0.000000] ACPI: HEST 0x00000000C7EBA8FD 00031C (v01 PTL    WHEAPTL  06=
040000 PTL  00000001)
[    0.000000] ACPI: BERT 0x00000000C7EBAC19 000030 (v01 PTL    WHEAPTL  06=
040000 PTL  00000001)
[    0.000000] ACPI: SSDT 0x00000000C7EBAC49 0000F0 (v01 wheaos wheaosc  06=
040000 INTL 20090625)
[    0.000000] ACPI: ERST 0x00000000C7EBAD39 000270 (v01 PTL    WHEAPTL  06=
040000 PTL  00000001)
[    0.000000] ACPI: SSDT 0x00000000C7EBAFA9 005984 (v01 AMD    POWERNOW 06=
040000 AMD  00000001)
[    0.000000] ACPI: SLIT 0x00000000C7EC092D 00003C (v01 AMD    AGESA    06=
040000 AMD  00000001)
[    0.000000] ACPI: SRAT 0x00000000C7EC0969 000320 (v02 AMD    AGESA    06=
040000 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000C7EC0C89 0000F5 (v01 AMD-K8 AMD-ACPI 06=
040000  AMD 00000001)
[    0.000000] ACPI: APIC 0x00000000C7EC0D7E 00020E (v01 PTLTD  ? APIC   06=
040000  LTP 00000000)
[    0.000000] ACPI: MCFG 0x00000000C7EC0F8C 00003C (v01 PTLTD    MCFG   06=
040000  LTP 00000000)
[    0.000000] ACPI: HPET 0x00000000C7EC0FC8 000038 (v01 PTLTD  HPETTBL  06=
040000  LTP 00000001)
[    0.000000] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x24 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x25 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x26 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x27 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x28 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x29 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2a -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2b -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2c -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2d -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2e -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2f -> Node 1
[    0.000000] SRAT: PXM 2 -> APIC 0x40 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x41 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x42 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x43 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x44 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x45 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x46 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x47 -> Node 2
[    0.000000] SRAT: PXM 3 -> APIC 0x48 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x49 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4a -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4b -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4c -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4d -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4e -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4f -> Node 3
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
[    0.000000] SRAT: Node 1 PXM 1 [mem 0x80000000-0xc7ffffff]
[    0.000000] SRAT: Node 1 PXM 1 [mem 0x100000000-0x137ffffff]
[    0.000000] SRAT: Node 2 PXM 2 [mem 0x138000000-0x1b7ffffff]
[    0.000000] SRAT: Node 3 PXM 3 [mem 0x1b8000000-0x236ffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0=
x7fffffff] -> [mem 0x00000000-0x7fffffff]
[    0.000000] NUMA: Node 1 [mem 0x80000000-0xc7ffffff] + [mem 0x100000000-=
0x137ffffff] -> [mem 0x80000000-0x137ffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x7ffee000-0x7fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x137fee000-0x137ffffff]
[    0.000000] NODE_DATA(2) allocated [mem 0x1b7fee000-0x1b7ffffff]
[    0.000000] NODE_DATA(3) allocated [mem 0x236feb000-0x236ffcfff]
[    0.000000] Reserving 256MB of memory at 592MB for crashkernel (System R=
AM: 8174MB)
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000236ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000097fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007fffffff]
[    0.000000]   node   1: [mem 0x0000000080000000-0x00000000c7eaffff]
[    0.000000]   node   1: [mem 0x0000000100000000-0x0000000137ffffff]
[    0.000000]   node   2: [mem 0x0000000138000000-0x00000001b7ffffff]
[    0.000000]   node   3: [mem 0x00000001b8000000-0x0000000236ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffff=
fff]
[    0.000000] Initmem setup node 1 [mem 0x0000000080000000-0x0000000137fff=
fff]
[    0.000000] Initmem setup node 2 [mem 0x0000000138000000-0x00000001b7fff=
fff]
[    0.000000] Initmem setup node 3 [mem 0x00000001b8000000-0x0000000236fff=
fff]
[    0.000000] ACPI: PM-Timer IO Port: 0x2008
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-=
23
[    0.000000] IOAPIC[1]: apic_id 1, version 33, address 0xc8000000, GSI 24=
-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 low level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x43538301 base: 0xfed00000
[    0.000000] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00098000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000d1fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000d2000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc7eb0000-0xc7ec0fff]
[    0.000000] PM: Registered nosave memory: [mem 0xc7ec1000-0xc7ec2fff]
[    0.000000] PM: Registered nosave memory: [mem 0xc7ec3000-0xc7efefff]
[    0.000000] PM: Registered nosave memory: [mem 0xc7eff000-0xc7efffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc7f00000-0xc7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc8000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfff00000-0xffffffff]
[    0.000000] e820: [mem 0xc8000000-0xfebfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:32 nr=
_node_ids:4
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88007dc00000 s98648 r8192=
 d32424 u262144
[    0.000000] Built 4 zonelists in Node order, mobility grouping on.  Tota=
l pages: 2059895
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-4.5.0-rc1+ root=
=3D/dev/mapper/fedora_amd--dinar--02-root ro rd.lvm.lv=3Dfedora_amd-dinar-0=
2/root rd.lvm.lv=3Dfedora_amd-dinar-02/swap console=3DttyS0,115200n81 LANG=
=3Den_US.UTF-8 crashkernel=3D256M
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 7868840K/8370460K available (7848K kernel code, 1297=
K rwdata, 3452K rodata, 1520K init, 1472K bss, 501620K reserved, 0K cma-res=
erved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D32, =
Nodes=3D4
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=3D32.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_cpu_ids=
=3D32
[    0.000000] NR_IRQS:4352 nr_irqs:1224 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-31.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with=
 numa_balancing=3D or the kernel.numa_balancing sysctl
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2793.036 MHz processor
[    0.000032] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5586.07 BogoMIPS (lpj=3D2793036)
[    0.010623] pid_max: default: 32768 minimum: 301
[    0.015254] ACPI: Core revision 20160108
[    0.023757] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    0.030140]=20
[    0.031700] Security Framework initialized
[    0.035823] Yama: becoming mindful.
[    0.039304] SELinux:  Initializing.
[    0.043537] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.053773] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.062179] Mount-cache hash table entries: 16384 (order: 5, 131072 byte=
s)
[    0.069046] Mountpoint-cache hash table entries: 16384 (order: 5, 131072=
 bytes)
[    0.076727] CPU: Physical Processor ID: 0
[    0.080757] CPU: Processor Core ID: 0
[    0.084408] mce: CPU supports 7 MCE banks
[    0.088412] LVT offset 1 assigned for vector 0xf9
[    0.093105] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.099006] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.105900] Freeing SMP alternatives memory: 32K (ffffffff81ec2000 - fff=
fffff81eca000)
[    0.146632] ftrace: allocating 29513 entries in 116 pages
[    0.238924] Switched APIC routing to physical flat.
[    0.244416] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.361509] smpboot: CPU0: AMD Opteron(tm) Processor 6386 SE (family: 0x=
15, model: 0x2, stepping: 0x0)
[    0.370839] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.377203] ... version:                0
[    0.381195] ... bit width:              48
[    0.385273] ... generic registers:      6
[    0.389265] ... value mask:             0000ffffffffffff
[    0.394555] ... max period:             00007fffffffffff
[    0.399846] ... fixed-purpose events:   0
[    0.403839] ... event mask:             000000000000003f
[    0.410089] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    0.418197] x86: Booting SMP configuration:
[    0.422397] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.493551] .... node  #1, CPUs:    #8  #9 #10 #11 #12 #13 #14 #15
[    0.582499] .... node  #2, CPUs:   #16 #17 #18 #19 #20 #21 #22 #23
[    0.749445] .... node  #3, CPUs:   #24 #25 #26 #27 #28 #29 #30 #31
[    0.838396] x86: Booted up 4 nodes, 32 CPUs
[    0.842750] smpboot: Total of 32 processors activated (178742.11 BogoMIP=
S)
[    0.903018] devtmpfs: initialized
[    0.909990] PM: Registering ACPI NVS region [mem 0xc7ec1000-0xc7ec2fff] =
(8192 bytes)
[    0.917917] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.927866] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[    0.934837] pinctrl core: initialized pinctrl subsystem
[    0.940092] RTC time:  4:58:08, date: 01/26/16
[    0.946068] NET: Registered protocol family 16
[    0.953426] cpuidle: using governor menu
[    0.957607] ACPI: bus type PCI registered
[    0.961635] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.968194] PCI: MMCONFIG for domain 0000 [bus 00-01] at [mem 0xe0000000=
-0xe01fffff] (base 0xe0000000)
[    0.977468] PCI: not using MMCONFIG
[    0.980943] PCI: Using configuration type 1 for base access
[    0.986495] PCI: Using configuration type 1 for extended access
[    0.997285] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.004330] ACPI: Added _OSI(Module Device)
[    1.008535] ACPI: Added _OSI(Processor Device)
[    1.012962] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.017647] ACPI: Added _OSI(Processor Aggregator Device)
[    1.028808] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    1.035824] ACPI: Interpreter enabled
[    1.039522] ACPI: (supports S0 S3 S5)
[    1.043169] ACPI: Using IOAPIC for interrupt routing
[    1.048175] PCI: MMCONFIG for domain 0000 [bus 00-01] at [mem 0xe0000000=
-0xe01fffff] (base 0xe0000000)
[    1.057843] PCI: MMCONFIG at [mem 0xe0000000-0xe01fffff] reserved in ACP=
I motherboard resources
[    1.066559] HEST: Table parsing has been initialized.
[    1.071624] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    1.088163] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-bf])
[    1.094326] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    1.102827] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER =
PCIeCapability]
[    1.110813] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [=
bus 00-01] only partially covers this bridge
[    1.122140] acpi PNP0A08:00: host bridge window expanded to [io  0x03e0-=
0x0cf7]; [io  0x03e0-0x0cf7 window] ignored
[    1.132764] PCI host bridge to bus 0000:00
[    1.136845] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    1.143608] pci_bus 0000:00: root bus resource [io  0x0d00-0x3fff window]
[    1.150370] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    1.157824] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xd7fffff=
f window]
[    1.165280] pci_bus 0000:00: root bus resource [mem 0xc8000000-0xce0ffff=
f window]
[    1.172735] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    1.178892] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000caff=
f window]
[    1.186351] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4500=
0 window]
[    1.193807] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    1.200570] pci_bus 0000:00: root bus resource [bus 00-bf]
[    1.206363] pci 0000:00:04.0: System wakeup disabled by ACPI
[    1.212399] pci 0000:00:12.0: System wakeup disabled by ACPI
[    1.218189] pci 0000:00:12.1: System wakeup disabled by ACPI
[    1.224017] pci 0000:00:12.2: System wakeup disabled by ACPI
[    1.229819] pci 0000:00:13.0: System wakeup disabled by ACPI
[    1.235612] pci 0000:00:13.1: System wakeup disabled by ACPI
[    1.241489] pci 0000:00:13.2: System wakeup disabled by ACPI
[    1.247419] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    1.254528] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.261033] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    1.268143] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.275019] pci 0000:00:14.4: System wakeup disabled by ACPI
[    1.280811] pci 0000:00:14.5: System wakeup disabled by ACPI
[    1.290558] pci 0000:00:04.0: PCI bridge to [bus 01]
[    1.295781] pci 0000:00:14.4: PCI bridge to [bus 02] (subtractive decode)
[    1.302882] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
[    1.309496] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
[    1.316110] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
[    1.322721] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
[    1.329330] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
[    1.335941] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
[    1.342548] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
[    1.349157] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
[    1.356140] ACPI: PCI Interrupt Link [LN24] (IRQs *24)
[    1.361355] ACPI: PCI Interrupt Link [LN25] (IRQs *25)
[    1.366538] ACPI: PCI Interrupt Link [LN26] (IRQs *26)
[    1.371719] ACPI: PCI Interrupt Link [LN27] (IRQs *27)
[    1.376897] ACPI: PCI Interrupt Link [LN28] (IRQs *28)
[    1.382080] ACPI: PCI Interrupt Link [LN29] (IRQs *29)
[    1.387257] ACPI: PCI Interrupt Link [LN30] (IRQs *30)
[    1.392439] ACPI: PCI Interrupt Link [LN31] (IRQs *31)
[    1.397616] ACPI: PCI Interrupt Link [LN32] (IRQs *32)
[    1.402793] ACPI: PCI Interrupt Link [LN33] (IRQs *33)
[    1.407973] ACPI: PCI Interrupt Link [LN34] (IRQs *34)
[    1.413149] ACPI: PCI Interrupt Link [LN35] (IRQs *35)
[    1.418331] ACPI: PCI Interrupt Link [LN36] (IRQs *36)
[    1.423510] ACPI: PCI Interrupt Link [LN37] (IRQs *37)
[    1.428688] ACPI: PCI Interrupt Link [LN38] (IRQs *38)
[    1.433867] ACPI: PCI Interrupt Link [LN39] (IRQs *39)
[    1.439046] ACPI: PCI Interrupt Link [LN40] (IRQs *40)
[    1.444223] ACPI: PCI Interrupt Link [LN41] (IRQs *41)
[    1.449407] ACPI: PCI Interrupt Link [LN42] (IRQs *42)
[    1.454588] ACPI: PCI Interrupt Link [LN43] (IRQs *43)
[    1.459767] ACPI: PCI Interrupt Link [LN44] (IRQs *44)
[    1.464948] ACPI: PCI Interrupt Link [LN45] (IRQs *45)
[    1.470127] ACPI: PCI Interrupt Link [LN46] (IRQs *46)
[    1.475305] ACPI: PCI Interrupt Link [LN47] (IRQs *47)
[    1.480480] ACPI: PCI Interrupt Link [LN48] (IRQs *48)
[    1.485660] ACPI: PCI Interrupt Link [LN49] (IRQs *49)
[    1.490839] ACPI: PCI Interrupt Link [LN50] (IRQs *50)
[    1.496020] ACPI: PCI Interrupt Link [LN51] (IRQs *51)
[    1.501196] ACPI: PCI Interrupt Link [LN52] (IRQs *52)
[    1.506372] ACPI: PCI Interrupt Link [LN53] (IRQs *53)
[    1.511550] ACPI: PCI Interrupt Link [LN54] (IRQs *54)
[    1.516727] ACPI: PCI Interrupt Link [LN55] (IRQs *55)
[    1.521919] ACPI: Enabled 2 GPEs in block 00 to 1F
[    1.526872] vgaarb: setting as boot device: PCI:0000:02:06.0
[    1.532508] vgaarb: device added: PCI:0000:02:06.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    1.540570] vgaarb: loaded
[    1.543267] vgaarb: bridge control possible 0000:02:06.0
[    1.548693] SCSI subsystem initialized
[    1.552588] ACPI: bus type USB registered
[    1.556633] usbcore: registered new interface driver usbfs
[    1.562106] usbcore: registered new interface driver hub
[    1.567505] usbcore: registered new device driver usb
[    1.572810] PCI: Using ACPI for IRQ routing
[    1.577223] NetLabel: Initializing
[    1.580611] NetLabel:  domain hash size =3D 128
[    1.584949] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    1.589906] NetLabel:  unlabeled traffic allowed by default
[    1.595512] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    1.600683] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    1.608684] clocksource: Switched to clocksource hpet
[    1.624234] VFS: Disk quotas dquot_6.6.0
[    1.628226] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    1.635271] pnp: PnP ACPI init
[    1.638611] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    1.645241] system 00:00: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    1.652181] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.658776] system 00:00: [mem 0xc8000000-0xc8007fff] could not be reser=
ved
[    1.666209] system 00:04: [io  0x0220-0x022f] has been reserved
[    1.672146] system 00:04: [io  0x040b] has been reserved
[    1.677442] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    1.683343] system 00:04: [io  0x04d6] has been reserved
[    1.688639] system 00:04: [io  0x0530-0x0537] has been reserved
[    1.694540] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    1.700441] system 00:04: [io  0x0c14] has been reserved
[    1.705736] system 00:04: [io  0x0c50-0x0c52] has been reserved
[    1.711637] system 00:04: [io  0x0c6c] has been reserved
[    1.716933] system 00:04: [io  0x0c6f] has been reserved
[    1.722229] system 00:04: [io  0x0ca0-0x0caf] has been reserved
[    1.728131] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
[    1.734034] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
[    1.739935] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
[    1.745838] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
[    1.751739] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    1.757640] system 00:04: [io  0x2000-0x205f] could not be reserved
[    1.763889] system 00:04: [io  0x2100-0x21ff window] has been reserved
[    1.770397] system 00:04: [io  0x2200-0x22ff window] has been reserved
[    1.776906] system 00:04: [io  0x0f40-0x0f47] has been reserved
[    1.782807] system 00:04: [io  0x087f] has been reserved
[    1.788188] system 00:05: [mem 0x000e0000-0x000fffff] could not be reser=
ved
[    1.795162] system 00:05: [mem 0xfff00000-0xffffffff] has been reserved
[    1.801757] system 00:05: [mem 0xfec10000-0xfec1001f] has been reserved
[    1.808811] pnp: PnP ACPI: found 7 devices
[    1.820457] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    1.829331] pci 0000:01:00.0: BAR 6: no space for [mem size 0x00020000 p=
ref]
[    1.836360] pci 0000:01:00.0: BAR 6: failed to assign [mem size 0x000200=
00 pref]
[    1.843732] pci 0000:01:00.1: BAR 6: no space for [mem size 0x00020000 p=
ref]
[    1.850760] pci 0000:01:00.1: BAR 6: failed to assign [mem size 0x000200=
00 pref]
[    1.858133] pci 0000:00:04.0: PCI bridge to [bus 01]
[    1.863084] pci 0000:00:04.0:   bridge window [mem 0xca000000-0xcdffffff]
[    1.869858] pci 0000:02:06.0: BAR 6: assigned [mem 0xce020000-0xce03ffff=
 pref]
[    1.877058] pci 0000:00:14.4: PCI bridge to [bus 02]
[    1.882008] pci 0000:00:14.4:   bridge window [io  0x3000-0x3fff]
[    1.888088] pci 0000:00:14.4:   bridge window [mem 0xce000000-0xce0fffff]
[    1.894858] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xd7ffffff=
 pref]
[    1.902204] NET: Registered protocol family 2
[    1.906976] TCP established hash table entries: 65536 (order: 7, 524288 =
bytes)
[    1.914442] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.921426] TCP: Hash tables configured (established 65536 bind 65536)
[    1.928027] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.934147] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.940863] NET: Registered protocol family 1
[    1.945557] Unpacking initramfs...
[    2.323107] microcode: microcode: updated early to new patch_level=3D0x0=
6000832
[    2.336246] Freeing initrd memory: 20436K (ffff880035807000 - ffff880036=
bfc000)
[    2.453278]  amd_iommu_add_device: 0000:00:00.0 ***=20
[    2.458305] allocated domain->id: 1 ***
[    2.462673]  amd_iommu_attach_device: 0000:00:00.0 ***=20
[    2.467882] set_dte_entry  devid: 00:00.0, domain->id:1 ***=20
[    2.473527] iommu: Adding device 0000:00:00.0 to group 0
[    2.478822]  amd_iommu_add_device: 0000:00:00.2 ***=20
[    2.483772]  amd_iommu_add_device: 0000:00:04.0 ***=20
[    2.488734] allocated domain->id: 2 ***
[    2.493048]  amd_iommu_attach_device: 0000:00:04.0 ***=20
[    2.498290] set_dte_entry  devid: 00:04.0, domain->id:2 ***=20
[    2.503934] iommu: Adding device 0000:00:04.0 to group 1
[    2.509229]  amd_iommu_add_device: 0000:00:11.0 ***=20
[    2.514192] allocated domain->id: 3 ***
[    2.518469]  amd_iommu_attach_device: 0000:00:11.0 ***=20
[    2.523711] set_dte_entry  devid: 00:11.0, domain->id:3 ***=20
[    2.529354] iommu: Adding device 0000:00:11.0 to group 2
[    2.534648]  amd_iommu_add_device: 0000:00:12.0 ***=20
[    2.539629] allocated domain->id: 4 ***
[    2.543940]  amd_iommu_attach_device: 0000:00:12.0 ***=20
[    2.549148] set_dte_entry  devid: 00:12.0, domain->id:4 ***=20
[    2.554792] iommu: Adding device 0000:00:12.0 to group 3
[    2.560089]  amd_iommu_add_device: 0000:00:12.1 ***=20
[    2.565050]  amd_iommu_attach_device: 0000:00:12.1 ***=20
[    2.570258] set_dte_entry  devid: 00:12.1, domain->id:4 ***=20
[    2.575902] iommu: Adding device 0000:00:12.1 to group 3
[    2.581197]  amd_iommu_add_device: 0000:00:12.2 ***=20
[    2.586159]  amd_iommu_attach_device: 0000:00:12.2 ***=20
[    2.591367] set_dte_entry  devid: 00:12.2, domain->id:4 ***=20
[    2.597010] iommu: Adding device 0000:00:12.2 to group 3
[    2.602304]  amd_iommu_add_device: 0000:00:13.0 ***=20
[    2.607284] allocated domain->id: 5 ***
[    2.611560]  amd_iommu_attach_device: 0000:00:13.0 ***=20
[    2.616803] set_dte_entry  devid: 00:13.0, domain->id:5 ***=20
[    2.622447] iommu: Adding device 0000:00:13.0 to group 4
[    2.627741]  amd_iommu_add_device: 0000:00:13.1 ***=20
[    2.632703]  amd_iommu_attach_device: 0000:00:13.1 ***=20
[    2.637911] set_dte_entry  devid: 00:13.1, domain->id:5 ***=20
[    2.643554] iommu: Adding device 0000:00:13.1 to group 4
[    2.648848]  amd_iommu_add_device: 0000:00:13.2 ***=20
[    2.653810]  amd_iommu_attach_device: 0000:00:13.2 ***=20
[    2.659018] set_dte_entry  devid: 00:13.2, domain->id:5 ***=20
[    2.664661] iommu: Adding device 0000:00:13.2 to group 4
[    2.669956]  amd_iommu_add_device: 0000:00:14.0 ***=20
[    2.674919] allocated domain->id: 6 ***
[    2.679196]  amd_iommu_attach_device: 0000:00:14.0 ***=20
[    2.684439] set_dte_entry  devid: 00:14.0, domain->id:6 ***=20
[    2.690083] iommu: Adding device 0000:00:14.0 to group 5
[    2.695378]  amd_iommu_add_device: 0000:00:14.1 ***=20
[    2.700339] allocated domain->id: 7 ***
[    2.704613]  amd_iommu_attach_device: 0000:00:14.1 ***=20
[    2.709856] set_dte_entry  devid: 00:14.1, domain->id:7 ***=20
[    2.715499] iommu: Adding device 0000:00:14.1 to group 6
[    2.720794]  amd_iommu_add_device: 0000:00:14.3 ***=20
[    2.725756] allocated domain->id: 8 ***
[    2.730075]  amd_iommu_attach_device: 0000:00:14.3 ***=20
[    2.735316] set_dte_entry  devid: 00:14.3, domain->id:8 ***=20
[    2.740961] iommu: Adding device 0000:00:14.3 to group 7
[    2.746254]  amd_iommu_add_device: 0000:00:14.4 ***=20
[    2.751216] allocated domain->id: 9 ***
[    2.755487]  amd_iommu_attach_device: 0000:00:14.4 ***=20
[    2.760729] set_dte_entry  devid: 00:14.4, domain->id:9 ***=20
[    2.766373] iommu: Adding device 0000:00:14.4 to group 8
[    2.771667]  amd_iommu_add_device: 0000:00:14.5 ***=20
[    2.776634] allocated domain->id: 10 ***
[    2.781040]  amd_iommu_attach_device: 0000:00:14.5 ***=20
[    2.786282] set_dte_entry  devid: 00:14.5, domain->id:10 ***=20
[    2.792012] iommu: Adding device 0000:00:14.5 to group 9
[    2.797306]  amd_iommu_add_device: 0000:00:18.0 ***=20
[    2.802255]  amd_iommu_add_device: 0000:00:18.1 ***=20
[    2.807204]  amd_iommu_add_device: 0000:00:18.2 ***=20
[    2.812153]  amd_iommu_add_device: 0000:00:18.3 ***=20
[    2.817102]  amd_iommu_add_device: 0000:00:18.4 ***=20
[    2.822052]  amd_iommu_add_device: 0000:00:18.5 ***=20
[    2.827002]  amd_iommu_add_device: 0000:00:19.0 ***=20
[    2.831951]  amd_iommu_add_device: 0000:00:19.1 ***=20
[    2.836900]  amd_iommu_add_device: 0000:00:19.2 ***=20
[    2.841849]  amd_iommu_add_device: 0000:00:19.3 ***=20
[    2.846798]  amd_iommu_add_device: 0000:00:19.4 ***=20
[    2.851746]  amd_iommu_add_device: 0000:00:19.5 ***=20
[    2.856695]  amd_iommu_add_device: 0000:00:1a.0 ***=20
[    2.861644]  amd_iommu_add_device: 0000:00:1a.1 ***=20
[    2.866593]  amd_iommu_add_device: 0000:00:1a.2 ***=20
[    2.871542]  amd_iommu_add_device: 0000:00:1a.3 ***=20
[    2.876491]  amd_iommu_add_device: 0000:00:1a.4 ***=20
[    2.881440]  amd_iommu_add_device: 0000:00:1a.5 ***=20
[    2.886389]  amd_iommu_add_device: 0000:00:1b.0 ***=20
[    2.891338]  amd_iommu_add_device: 0000:00:1b.1 ***=20
[    2.896287]  amd_iommu_add_device: 0000:00:1b.2 ***=20
[    2.901236]  amd_iommu_add_device: 0000:00:1b.3 ***=20
[    2.906185]  amd_iommu_add_device: 0000:00:1b.4 ***=20
[    2.911134]  amd_iommu_add_device: 0000:00:1b.5 ***=20
[    2.916083]  amd_iommu_add_device: 0000:01:00.0 ***=20
[    2.921067] allocated domain->id: 11 ***
[    2.925427]  amd_iommu_attach_device: 0000:01:00.0 ***=20
[    2.930669] set_dte_entry  devid: 01:00.0, domain->id:11 ***=20
[    2.936399] iommu: Adding device 0000:01:00.0 to group 10
[    2.941781]  amd_iommu_add_device: 0000:01:00.1 ***=20
[    2.946760]  amd_iommu_attach_device: 0000:01:00.1 ***=20
[    2.951971] set_dte_entry  devid: 01:00.1, domain->id:11 ***=20
[    2.957701] iommu: Adding device 0000:01:00.1 to group 10
[    2.963084]  amd_iommu_add_device: 0000:02:06.0 ***=20
[    2.968037]  amd_iommu_attach_device: 0000:02:06.0 ***=20
[    2.973245] set_dte_entry  devid: 02:06.0, domain->id:9 ***=20
[    2.978881] set_dte_entry  devid: 00:14.4, domain->id:9 ***=20
[    2.984525] iommu: Adding device 0000:02:06.0 to group 8
[    2.989819] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    2.995113] AMD-Vi: Interrupt remapping enabled
[    2.999818] AMD-Vi: Lazy IO/TLB flushing enabled
[    3.007256] perf: AMD NB counters detected
[    3.011668] LVT offset 0 assigned for vector 0x400
[    3.016539] perf: AMD IBS detected (0x000000ff)
[    3.024350] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    3.030777] audit: initializing netlink subsys (disabled)
[    3.036224] audit: type=3D2000 audit(1453784287.535:1): initialized
[    3.042620] Initialise system trusted keyring
[    3.049763] zbud: loaded
[    3.053099] Key type big_key registered
[    3.065934] NET: Registered protocol family 38
[    3.070379] Key type asymmetric registered
[    3.074467] Asymmetric key parser 'x509' registered
[    3.079400] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 250)
[    3.087010] io scheduler noop registered
[    3.090928] io scheduler deadline registered
[    3.095245] io scheduler cfq registered (default)
[    3.100265] ACPI: PCI Interrupt Link [LN52] enabled at IRQ 52
[    3.106436] pcieport 0000:00:04.0: Signaling PME through PCIe PME interr=
upt
[    3.113414] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    3.119921] pci 0000:01:00.1: Signaling PME through PCIe PME interrupt
[    3.126437] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    3.131999] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    3.138716] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    3.147076] ACPI: Power Button [PWRB]
[    3.150777] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    3.158183] ACPI: Power Button [PWRF]
[    3.166526] ERST: Can not request [mem 0xc7eff000-0xc7efffff] for ERST.
[    3.173771] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    3.180170] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.207233] 00:06: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    3.216876] Non-volatile memory driver v1.3
[    3.221099] Linux agpgart interface v0.103
[    3.228517] ACPI: PCI Interrupt Link [LN44] enabled at IRQ 44
[    3.234439] ACPI: PCI Interrupt Link [LN45] enabled at IRQ 45
[    3.245462]  amd_iommu_dma_supported: 0000:00:11.0 ***=20
[    3.250732] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x=
3f impl SATA mode
[    3.258884] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led clo pmp pi=
o slum part ccc=20
[    3.266956]  alloc_coherent: 0000:00:11.0 ***=20
[    3.271405]  dma_addr: 20000, size=3D17000 ***=20
[    3.275764]  alloc_coherent: 0000:00:11.0 ***=20
[    3.280213]  dma_addr: 40000, size=3D17000 ***=20
[    3.284571]  alloc_coherent: 0000:00:11.0 ***=20
[    3.289021]  dma_addr: 60000, size=3D17000 ***=20
[    3.293378]  alloc_coherent: 0000:00:11.0 ***=20
[    3.297827]  dma_addr: 80000, size=3D17000 ***=20
[    3.302185]  alloc_coherent: 0000:00:11.0 ***=20
[    3.306647]  dma_addr: a0000, size=3D17000 ***=20
[    3.311004]  alloc_coherent: 0000:00:11.0 ***=20
[    3.315454]  dma_addr: c0000, size=3D17000 ***=20
[    3.320568] scsi host0: ahci
[    3.323696] scsi host1: ahci
[    3.326813] scsi host2: ahci
[    3.329917] scsi host3: ahci
[    3.333027] scsi host4: ahci
[    3.336138] scsi host5: ahci
[    3.339095] ata1: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801410=
0 irq 22
[    3.346468] ata2: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801418=
0 irq 22
[    3.353842] ata3: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801420=
0 irq 22
[    3.361215] ata4: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801428=
0 irq 22
[    3.368587] ata5: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801430=
0 irq 22
[    3.375960] ata6: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801438=
0 irq 22
[    3.383485] libphy: Fixed MDIO Bus: probed
[    3.387914] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.394426] ehci-pci: EHCI PCI platform driver
[    3.399041] ehci-pci 0000:00:12.2: EHCI Host Controller
[    3.404473] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus =
number 1
[    3.411850] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    3.420527] ehci-pci 0000:00:12.2: debug port 1
[    3.425049]  alloc_coherent: 0000:00:12.2 ***=20
[    3.429480]  dma_addr: 1000, size=3D1000 ***=20
[    3.433649]  alloc_coherent: 0000:00:12.2 ***=20
[    3.438078]  dma_addr: 2000, size=3D1000 ***=20
[    3.442247]  alloc_coherent: 0000:00:12.2 ***=20
[    3.446676]  dma_addr: 3000, size=3D1000 ***=20
[    3.450873] ehci-pci 0000:00:12.2: irq 17, io mem 0xc8014400
[    3.461814] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    3.467583] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.474395] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.481593] usb usb1: Product: EHCI Host Controller
[    3.486455] usb usb1: Manufacturer: Linux 4.5.0-rc1+ ehci_hcd
[    3.492183] usb usb1: SerialNumber: 0000:00:12.2
[    3.497100] hub 1-0:1.0: USB hub found
[    3.500880] hub 1-0:1.0: 6 ports detected
[    3.505506] ehci-pci 0000:00:13.2: EHCI Host Controller
[    3.510925] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus =
number 2
[    3.518299] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    3.526976] ehci-pci 0000:00:13.2: debug port 1
[    3.531497]  alloc_coherent: 0000:00:13.2 ***=20
[    3.535928]  dma_addr: 1000, size=3D1000 ***=20
[    3.540097]  alloc_coherent: 0000:00:13.2 ***=20
[    3.544526]  dma_addr: 2000, size=3D1000 ***=20
[    3.548695]  alloc_coherent: 0000:00:13.2 ***=20
[    3.553124]  dma_addr: 3000, size=3D1000 ***=20
[    3.557321] ehci-pci 0000:00:13.2: irq 19, io mem 0xc8014800
[    3.568812] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    3.574576] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.581344] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.588543] usb usb2: Product: EHCI Host Controller
[    3.593407] usb usb2: Manufacturer: Linux 4.5.0-rc1+ ehci_hcd
[    3.599135] usb usb2: SerialNumber: 0000:00:13.2
[    3.604037] hub 2-0:1.0: USB hub found
[    3.607816] hub 2-0:1.0: 6 ports detected
[    3.612135] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.618320] ohci-pci: OHCI PCI platform driver
[    3.623050] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    3.628851] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus =
number 3
[    3.636232]  alloc_coherent: 0000:00:12.0 ***=20
[    3.640664]  dma_addr: 4000, size=3D1000 ***=20
[    3.644858] ohci-pci 0000:00:12.0: irq 16, io mem 0xc8015000
[    3.690384] ata2: SATA link down (SStatus 0 SControl 300)
[    3.695806] ata3: SATA link down (SStatus 0 SControl 300)
[    3.701222] ata1: SATA link down (SStatus 0 SControl 300)
[    3.704965] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.704967] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.704968] usb usb3: Product: OHCI PCI host controller
[    3.704968] usb usb3: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    3.704969] usb usb3: SerialNumber: 0000:00:12.0
[    3.705347] hub 3-0:1.0: USB hub found
[    3.705355] hub 3-0:1.0: 3 ports detected
[    3.705750] ohci-pci 0000:00:12.1: OHCI PCI host controller
[    3.705933] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus =
number 4
[    3.705941]  alloc_coherent: 0000:00:12.1 ***=20
[    3.705943]  dma_addr: 5000, size=3D1000 ***=20
[    3.705954] ohci-pci 0000:00:12.1: irq 16, io mem 0xc8016000
[    3.760881] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.760882] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.760883] usb usb4: Product: OHCI PCI host controller
[    3.760884] usb usb4: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    3.760885] usb usb4: SerialNumber: 0000:00:12.1
[    3.761247] hub 4-0:1.0: USB hub found
[    3.761256] hub 4-0:1.0: 3 ports detected
[    3.761659] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    3.761912] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus =
number 5
[    3.761921]  alloc_coherent: 0000:00:13.0 ***=20
[    3.761924]  dma_addr: 4000, size=3D1000 ***=20
[    3.761955] ohci-pci 0000:00:13.0: irq 18, io mem 0xc8017000
[    3.816871] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.816873] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.816874] usb usb5: Product: OHCI PCI host controller
[    3.816875] usb usb5: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    3.816875] usb usb5: SerialNumber: 0000:00:13.0
[    3.817242] hub 5-0:1.0: USB hub found
[    3.817252] hub 5-0:1.0: 3 ports detected
[    3.817628] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    3.817903] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus =
number 6
[    3.817912]  alloc_coherent: 0000:00:13.1 ***=20
[    3.817915]  dma_addr: 5000, size=3D1000 ***=20
[    3.817924] ohci-pci 0000:00:13.1: irq 18, io mem 0xc8018000
[    3.872874] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.872876] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.872877] usb usb6: Product: OHCI PCI host controller
[    3.872878] usb usb6: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    3.872879] usb usb6: SerialNumber: 0000:00:13.1
[    3.873235] hub 6-0:1.0: USB hub found
[    3.873243] hub 6-0:1.0: 3 ports detected
[    3.873636] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    3.873896] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus =
number 7
[    3.873905]  alloc_coherent: 0000:00:14.5 ***=20
[    3.873908]  dma_addr: 1000, size=3D1000 ***=20
[    3.873918] ohci-pci 0000:00:14.5: irq 18, io mem 0xc8019000
[    3.928879] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    3.928881] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.928882] usb usb7: Product: OHCI PCI host controller
[    3.928883] usb usb7: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    3.928884] usb usb7: SerialNumber: 0000:00:14.5
[    3.929246] hub 7-0:1.0: USB hub found
[    3.929254] hub 7-0:1.0: 2 ports detected
[    3.929494] uhci_hcd: USB Universal Host Controller Interface driver
[    3.929571] usbcore: registered new interface driver usbserial
[    3.929578] usbcore: registered new interface driver usbserial_generic
[    3.929585] usbserial: USB Serial support registered for generic
[    3.929654] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0=
x60,0x64 irq 1,12
[    4.006854] tsc: Refined TSC clocksource calibration: 2793.090 MHz
[    4.006856] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x284=
2c0f619c, max_idle_ns: 440795286808 ns
[    4.050776] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.057137] ata5: SATA link down (SStatus 0 SControl 300)
[    4.062584] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.068870] ata4.00: ATA-8: WDC WD5001AALS-00L3B2, 01.03B01, max UDMA/133
[    4.075648] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)=
, AA
[    4.082690] ata6.00: ATAPI: Optiarc DVD RW AD-7240S, 1.01, max UDMA/100
[    4.090299] ata4.00: configured for UDMA/133
[    4.094600] ata6.00: configured for UDMA/100
[    4.095348] scsi 3:0:0:0: Direct-Access     ATA      WDC WD5001AALS-0 3B=
01 PQ: 0 ANSI: 5
[    4.113632] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    4.113658] sd 3:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB=
/466 GiB)
[    4.113684] sd 3:0:0:0: [sda] Write Protect is off
[    4.113696] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.119886]  sda: sda1 sda2
[    4.120387] sd 3:0:0:0: [sda] Attached SCSI disk
[    4.149671] scsi 5:0:0:0: CD-ROM            Optiarc  DVD RW AD-7240S  1.=
01 PQ: 0 ANSI: 5
[    4.180363] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.182352] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd=
/rw xa/form2 cdda tray
[    4.182353] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.182587] sr 5:0:0:0: Attached scsi generic sg1 type 5
[    4.204673] mousedev: PS/2 mouse device common for all mice
[    4.211013] rtc_cmos 00:01: RTC can wake from S4
[    4.215925] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    4.222053] rtc_cmos 00:01: alarms up to one month, 114 bytes nvram, hpe=
t irqs
[    4.229316] device-mapper: uevent: version 1.0.3
[    4.234645] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised:=
 dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    4.244132] hidraw: raw HID events driver (C) Jiri Kosina
[    4.249593] usbcore: registered new interface driver usbhid
[    4.255187] usbhid: USB HID core driver
[    4.259328] drop_monitor: Initializing network drop monitor service
[    4.265681] ip_tables: (C) 2000-2006 Netfilter Core Team
[    4.271593] Initializing XFRM netlink socket
[    4.276091] NET: Registered protocol family 10
[    4.281176] mip6: Mobile IPv6
[    4.284140] NET: Registered protocol family 17
[    4.293394] microcode: CPU0: patch_level=3D0x06000832
[    4.298263] microcode: CPU1: patch_level=3D0x06000832
[    4.303279] microcode: CPU2: patch_level=3D0x06000832
[    4.308146] microcode: CPU3: patch_level=3D0x06000832
[    4.313170] microcode: CPU4: patch_level=3D0x06000832
[    4.318036] microcode: CPU5: patch_level=3D0x06000832
[    4.323059] microcode: CPU6: patch_level=3D0x06000832
[    4.327927] microcode: CPU7: patch_level=3D0x06000832
[    4.332798] microcode: CPU8: patch_level=3D0x06000832
[    4.337665] microcode: CPU9: patch_level=3D0x06000832
[    4.342653] microcode: CPU10: patch_level=3D0x06000832
[    4.347608] microcode: CPU11: patch_level=3D0x06000832
[    4.352567] microcode: CPU12: patch_level=3D0x06000832
[    4.357521] microcode: CPU13: patch_level=3D0x06000832
[    4.362469] microcode: CPU14: patch_level=3D0x06000832
[    4.367425] microcode: CPU15: patch_level=3D0x06000832
[    4.372531] microcode: CPU16: patch_level=3D0x06000832
[    4.377484] microcode: CPU17: patch_level=3D0x06000832
[    4.382588] microcode: CPU18: patch_level=3D0x06000832
[    4.387542] microcode: CPU19: patch_level=3D0x06000832
[    4.392643] microcode: CPU20: patch_level=3D0x06000832
[    4.397597] microcode: CPU21: patch_level=3D0x06000832
[    4.402666] microcode: CPU22: patch_level=3D0x06000832
[    4.407639] microcode: CPU23: patch_level=3D0x06000832
[    4.412596] microcode: CPU24: patch_level=3D0x06000832
[    4.417551] microcode: CPU25: patch_level=3D0x06000832
[    4.422655] microcode: CPU26: patch_level=3D0x06000832
[    4.427613] microcode: CPU27: patch_level=3D0x06000832
[    4.432681] microcode: CPU28: patch_level=3D0x06000832
[    4.437634] microcode: CPU29: patch_level=3D0x06000832
[    4.442736] microcode: CPU30: patch_level=3D0x06000832
[    4.447688] microcode: CPU31: patch_level=3D0x06000832
[    4.452836] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[    4.461617] AVX version of gcm_enc/dec engaged.
[    4.466135] AES CTR mode by8 optimization enabled
[    4.507374] registered taskstats version 1
[    4.511477] Loading compiled-in X.509 certificates
[    4.517127] Loaded X.509 cert 'Build time autogenerated kernel key: d3ef=
5bf4e7da8af313a5b06e1df49a7fa209fab2'
[    4.527104] zswap: loaded using pool lzo/zbud
[    4.532351]   Magic number: 0:786:970
[    4.536456] rtc_cmos 00:01: setting system clock to 2016-01-26 04:58:11 =
UTC (1453784291)
[    4.546832] Freeing unused kernel memory: 1520K (ffffffff81d46000 - ffff=
ffff81ec2000)
[    4.554672] Write protecting the kernel read-only data: 12288k
[    4.561495] Freeing unused kernel memory: 332K (ffff8800017ad000 - ffff8=
80001800000)
[    4.571227] Freeing unused kernel memory: 644K (ffff880001b5f000 - ffff8=
80001c00000)
[    4.582366] random: systemd urandom read with 15 bits of entropy availab=
le
[    4.612822] systemd[1]: systemd 222 running in system mode. (+PAM +AUDIT=
 +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    4.631573] systemd[1]: Detected architecture x86-64.
[    4.636653] systemd[1]: Running in initial RAM disk.

Welcome to Fedora 23 (Twenty Three) dracut-043-63.git20151211.fc23 (Initram=
fs)!

[    4.650773] systemd[1]: Set hostname to <amd-dinar-02.lab.bos.redhat.com=
>.
[  OK  ] Reached target Local File Systems.
[    4.723015] systemd[1]: Reached target Local File Systems.
[    4.728551] systemd[1]: Starting Local File Systems.
[  OK  ] Reached target Swap.
[    4.738835] systemd[1]: Reached target Swap.
[    4.743107] systemd[1]: Starting Swap.
[  OK  ] Reached target Timers.
[    4.752045] systemd[1]: Reached target Timers.
[    4.756489] systemd[1]: Starting Timers.
[  OK  ] Created slice -.slice.
[    4.765995] systemd[1]: Created slice -.slice.
[    4.770476] systemd[1]: Starting -.slice.
[  OK  ] Listening on Journal Socket.
[    4.779995] systemd[1]: Listening on Journal Socket.
[    4.784997] systemd[1]: Starting Journal Socket.
[  OK  ] Listening on Journal Socket (/dev/log).
[    4.797041] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.802956] systemd[1]: Starting Journal Socket (/dev/log).
[  OK  ] Listening on udev Control Socket.
[    4.815171] systemd[1]: Listening on udev Control Socket.
[    4.820567] systemd[1]: Starting udev Control Socket.
[  OK  ] Created slice System Slice.
[    4.830726] systemd[1]: Created slice System Slice.
[    4.835614] systemd[1]: Starting System Slice.
[    4.849432] systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
[    4.860801] systemd[1]: Started Load Kernel Modules.
[    4.861744] systemd[1]: Starting Create list of required static device n=
odes for the current kernel...
         Starting Create list of required st... nodes for the current kerne=
l...
[    4.890987] systemd[1]: Started dracut ask for additional cmdline parame=
ters.
[    4.898849] systemd[1]: Starting dracut cmdline hook...
         Starting dracut cmdline hook...
[    4.909340] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[  OK  ] Listening on udev Kernel Socket.
[    4.925993] systemd[1]: Listening on udev Kernel Socket.
[    4.931330] systemd[1]: Starting udev Kernel Socket.
[  OK  ] Listening on Journal Audit Socket.
[    4.942826] systemd[1]: Listening on Journal Audit Socket.
[    4.948308] systemd[1]: Starting Journal Audit Socket.
[    4.971314] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[  OK  ] Reached target Sockets.
[    4.985704] systemd[1]: Reached target Sockets.
[    4.990254] systemd[1]: Starting Sockets.
[  OK  ] Reached target Slices.
[    4.998683] systemd[1]: Reached target Slices.
[    5.003150] systemd[1]: Starting Slices.
[    5.007481] clocksource: Switched to clocksource tsc
[  OK  ] Started Setup Virtual Console.
[    5.018794] systemd[1]: Started Setup Virtual Console.
[    5.024194] audit: type=3D1130 audit(1453784291.987:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-vcon=
sole-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Started Create list of required sta...ce nodes for the current ker=
nel.
[    5.054999] systemd[1]: Started Create list of required static device no=
des for the current kernel.
[    5.064076] audit: type=3D1130 audit(1453784292.027:3): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dkmod-static-=
nodes comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Started dracut cmdline hook.
[    5.090007] systemd[1]: Started dracut cmdline hook.
[    5.095020] audit: type=3D1130 audit(1453784292.058:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-cmdli=
ne comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'
[  OK  ] Started Apply Kernel Variables.
[    5.122001] systemd[1]: Started Apply Kernel Variables.
[    5.127269] audit: type=3D1130 audit(1453784292.090:5): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-sysc=
tl comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'
[  OK  ] Started Journal Service.
[    5.151932] systemd[1]: Started Journal Service.
[    5.156640] audit: type=3D1130 audit(1453784292.120:6): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-jour=
nald comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
? terminal=3D? res=3Dsuccess'
         Starting dracut pre-udev hook...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Create Static Device Nodes in /dev.
[    5.208899] audit: type=3D1130 audit(1453784292.172:7): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-tmpf=
iles-setup-dev comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Started dracut pre-udev hook.
[    5.234823] audit: type=3D1130 audit(1453784292.198:8): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-pre-u=
dev comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=
 terminal=3D? res=3Dsuccess'
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
[    5.276785] audit: type=3D1130 audit(1453784292.240:9): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-udev=
d comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dsuccess'
         Starting udev Coldplug all Devices...
         Mounting Configuration File System...
[  OK  ] Mounted Configuration File System.
[    5.364733] FUJITSU Extended Socket Network Device Driver - version 1.0 =
- Copyright (c) 2015 FUJITSU LIMITED
[  OK  [    5.375425] bnx2: QLogic bnx2 Gigabit Ethernet Driver v2.2.6 (Jan=
uary 29, 2014)
] Started udev C[    5.383594]  amd_iommu_dma_supported: 0000:01:00.0 ***=
=20
oldplug all Devi[    5.390440]  alloc_coherent: 0000:01:00.0 ***=20
ces.
[    5.395953]  dma_addr: 1000, size=3D1000 ***=20
[    5.400776] audit: type=3D1130 audit(1453784292.364:10): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-ude=
v-trigger comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
[    5.401549] bnx2 0000:01:00.0 eth0: Broadcom NetXtreme II BCM5709 1000Ba=
se-T (C0) PCI Express found at mem ca000000, IRQ 25, node addr 00:00:1a:1a:=
94:70
[    5.401606]  amd_iommu_dma_supported: 0000:00:14.1 ***=20
[    5.401637]  alloc_coherent: 0000:00:14.1 ***=20
[    5.401643]  dma_addr: 1000, size=3D1000 ***=20
[    5.401652]  alloc_coherent: 0000:00:14.1 ***=20
[    5.401656]  dma_addr: 2000, size=3D1000 ***=20
[    5.404072]  amd_iommu_dma_supported: 0000:01:00.1 ***=20
[    5.404318]  alloc_coherent: 0000:01:00.1 ***=20
[    5.404322]  dma_addr: 2000, size=3D1000 ***=20
[    5.405030] bnx2 0000:01:00.1 eth1: Broadcom NetXtreme II BCM5709 1000Ba=
se-T (C0) PCI Express found at mem cc000000, IRQ 27, node addr 00:00:1a:1a:=
94:71
[    5.405434] scsi host6: pata_atiixp
[    5.405736] scsi host7: pata_atiixp
[    5.405864] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x2410 irq=
 14
[    5.405866] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x2418 irq=
 15
[    5.449117] bnx2 0000:01:00.1 enp1s0f1: renamed from eth1
[    5.512625] [drm] Initialized drm 1.1.0 20060810
[    5.550300] [drm] radeon kernel modesetting enabled.
[    5.568685] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[    5.574705] AMD IOMMUv2 functionality not available on this system
[    5.584047] CRAT table not found
[    5.587299] Finished initializing topology ret=3D0
[    5.592065] kfd kfd: Initialized module
[    5.595092] bnx2 0000:01:00.0 enp1s0f0: renamed from eth0
         Startin[    5.602506] [drm] initializing kernel modesetting (RV100=
 0x1002:0x515E 0x1002:0x515E).
g Show Plymouth [    5.610989]  amd_iommu_dma_supported: 0000:02:06.0 ***=
=20
[    5.611003] [drm] register mmio base: 0xCE000000
Boot Screen...
[    5.611003] [drm] register mmio size: 65536
[    5.611078] radeon 0000:02:06.0: VRAM: 128M 0x00000000D0000000 - 0x00000=
000D7FFFFFF (32M used)
[    5.611079] radeon 0000:02:06.0: GTT: 512M 0x00000000B0000000 - 0x000000=
00CFFFFFFF
[    5.611087] [drm] Detected VRAM RAM=3D128M, BAR=3D128M
[    5.611087] [drm] RAM width 16bits DDR
[    5.611458] [TTM] Zone  kernel: Available graphics memory: 3978878 kiB
[   5.611459] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    5.611459] [TTM] Initializing pool allocator
[    5.611464] [TTM] Initializing DMA pool allocator
[    5.611482] [drm] radeon: 32M of VRAM memory ready
[    5.611482] [drm] radeon: 512M of GTT memory ready.
[    5.611496] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    5.612006]  alloc_coherent: 0000:02:06.0 ***=20
[    5.612099]  dma_addr: 80000, size=3D80000 ***=20
[    5.622332] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000240 flags=3D0x0000]
[    5.622333] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000280 flags=3D0x0000]
[    5.622334] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x00000000000002c0 flags=3D0x0000]
[    5.622335] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000300 flags=3D0x0000]
[    5.622336] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000340 flags=3D0x0000]
[    5.622337] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000380 flags=3D0x0000]
[    5.622338] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000240 flags=3D0x0000]
[    5.622339] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000280 flags=3D0x0000]
[    5.622340] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x00000000000002c0 flags=3D0x0000]
[    5.622341] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000300 flags=3D0x0000]
[    5.622341] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000340 flags=3D0x0000]
[    5.622342] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.4 domain=
=3D0x0009 address=3D0x0000000000000380 flags=3D0x0000]
[    5.632194] [drm] PCI GART of 512M enabled (table at 0x0000000000080000).
[    5.632205] radeon 0000:02:06.0: WB disabled
[    5.632207] radeon 0000:02:06.0: fence driver on ring 0 use gpu addr 0x0=
0000000b0000000 and cpu addr 0xffff88000013e000
[    5.632208] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    5.632208] [drm] Driver supports precise vblank timestamp query.
[    5.632240] [drm] radeon: irq initialized.
[    5.632251] [drm] Loading R100 Microcode
[    5.632542] [drm] radeon: ring at 0x00000000B0001000
[    5.632576] [drm] ring test succeeded in 0 usecs
[    5.632744] [drm] ib test succeeded in 0 usecs
[    5.633213] [drm] No TV DAC info found in BIOS
[    5.633251] [drm] Radeon Display Connectors
[    5.633252] [drm] Connector 0:
[    5.633252] [drm]   VGA-1
[    5.633253] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[    5.633254] [drm]   Encoders:
[    5.633254] [drm]     CRT1: INTERNAL_DAC1
[    5.633254] [drm] Connector 1:
[    5.633255] [drm]   DVI-I-1
[    5.633255] [drm]   HPD2
[    5.633256] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
[    5.633256] [drm]   Encoders:
[    5.633257] [drm]     CRT2: INTERNAL_DAC2
[    5.633257] [drm]     DFP2: INTERNAL_DVO1
[    5.684946] [drm] fb mappable at 0xD0040000
[    5.684947] [drm] vram apper at 0xD0000000
[    5.684947] [drm] size 786432
[    5.684947] [drm] fb depth is 8
[    5.684948] [drm]    pitch is 1024
[    5.967924] fbcon: radeondrmfb (fb0) is primary device
[    6.142971] Console: switching to colour frame buffer device 128x48
[    6.176011] radeon 0000:02:06.0: fb0: radeondrmfb frame buffer device
         Starting dracut initqueue hook...
[    6.212984] [drm] Initialized radeon 2.43.0 20080528 for 0000:02:06.0 on=
 minor 0
[  OK  ] Reached target System Initialization.
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Basic System.
[  OK  ] Found device /dev/mapper/fedora_amd--dinar--02-root.
[    6.569706] random: nonblocking pool is initialized
[  OK  ] Started dracut initqueue hook.
         Starting File System Check on /dev/...er/fedora_amd--dinar--02-roo=
t...
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[  OK  ] Started File System Check on /dev/mapper/fedora_amd--dinar--02-roo=
t.
         Mounting /sysroot...
[    6.791795] EXT4-fs (dm-0): mounted filesystem with ordered data mode. O=
pts: (null)
[  OK  ] Mounted /sysroot.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[  OK  ] Started Reload Configuration from the Real Root.
[  OK  ] Reached target Initrd File Systems.
[  OK  ] Reached target Initrd Default Target.
         Starting dracut pre-pivot and cleanup hook...
[  OK  ] Started dracut pre-pivot and cleanup hook.
         Starting Cleaning Up and Shutting Down Daemons...
[  OK  ] Stopped target Timers.
         Starting Plymouth switch root service...
[  OK  ] Stopped Cleaning Up and Shutting Down Daemons.
[  OK  ] Stopped dracut pre-pivot and cleanup hook.
         Stopping dracut pre-pivot and cleanup hook...
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped target Remote File Systems (Pre).
[  OK  ] Stopped dracut initqueue hook.
         Stopping dracut initqueue hook...
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target System Initialization.
[  OK  ] Stopped target Local File Systems.
[  OK  ] Stopped udev Coldplug all Devices.
         Stopping udev Coldplug all Devices...
[  OK  ] Stopped Apply Kernel Variables.
         Stopping Apply Kernel Variables...
[  OK  ] Stopped target Swap.
         Stopping udev Kernel Device Manager...
[  OK  ] Stopped target Slices.
[  OK  ] Stopped target Sockets.
[  OK  ] Stopped target Paths.
[  OK  ] Stopped udev Kernel Device Manager.
[  OK  ] Stopped dracut pre-udev hook.
         Stopping dracut pre-udev hook...
[  OK  ] Stopped d[    7.175299] systemd-journald[449]: Received SIGTERM fr=
om PID 1 (systemd).
racut cmdline hook.
         Stopping dracut cmdline hook...
[  OK  ] Stopped Create Static Device Nodes in /dev.
         Stopping Create Static Device Nodes in /dev...
[  OK  ] Stopped Create list of required sta...ce nodes for the current ker=
nel.
         Stopping Create list of required st... nodes for the current kerne=
l...
[  OK  ] Closed udev Kernel Socket.
[  OK  ] Closed udev Control Socket.
         Starting Cleanup udevd DB...
[  OK  ] Started Cleanup udevd DB.
[  OK  ] Reached target Switch Root.
[  OK  ] Started Plymouth switch root service.
         Starting Switch Root...
[    7.950460] SELinux:  Permission validate_trans in class security not de=
fined in policy.
[    7.958657] SELinux: the above unknown classes and permissions will be a=
llowed
[    8.004447] systemd[1]: Successfully loaded SELinux policy in 188.790ms.
[    8.115169] systemd[1]: RTC configured in localtime, applying delta of -=
300 minutes to system time.
[    8.150304] systemd[1]: Relabelled /dev and /run in 23.238ms.

Welcome to Fedora 23 (Twenty Three)!

[    9.087668] audit_printk_skb: 93 callbacks suppressed
[    9.092707] audit: type=3D1130 audit(1453802296.049:42): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    9.114377] audit: type=3D1131 audit(1453802296.076:43): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    9.136389] audit: type=3D1130 audit(1453802296.099:44): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/syst=
emd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    9.158272] audit: type=3D1131 audit(1453802296.121:45): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/syst=
emd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[  OK  [    9.180559] audit: type=3D1130 audit(1453802296.142:46): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:=
s0 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    9.203315] audit: type=3D1131 audit(1453802296.165:47): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
] Stopped Switch Root.
[  OK  ] Stopped Journal Service.
         Starting Journal Service...
[  OK  ] Listening on LVM2 poll daemon socket.
[  OK  ] Created slice system-systemd\x2dfsck.slice.
[  OK  ] Listening on Device-mapper event daemon FIFOs.
         Mounting Debug File System...
         Mounting NFSD configuration filesystem...
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  OK  ] Stopped target Switch Root.
         Mounting Temporary Directory...
[  OK  ] Set up automount Arbitrary Executab...ats File System Automount Po=
int.
         Starting Remount Root and Kernel File S[    9.496736] audit: type=
=3D1305 audit(1453802296.459:48): audit_enabled=3D1 old=3D1 auid=3D42949672=
95 ses=3D4294967295 subj=3Dsystem_u:system_r:syslogd_t:s0 res=3D1
ystems...
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on LVM2 metadata daemon socket.
         Starting Monitoring of LVM2 mirrors... dmeventd or progress pollin=
g...
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Encrypted Volumes.
[  OK  ] Reached target Slices.
         Mounting Huge Pages File System...
         Mounting POSIX Message Queue File System...
[  OK  ] Stopped target Initrd File Systems.
[  OK  ] Created slice system-getty.slice.
         Starting Create list of required st... nodes for the current kerne=
l...
         Starting Apply Kernel Variables...
[  OK  ] Stopped target Initrd Root File System.
[=1B[3[    9.610030] audit: type=3D1130 audit(1453802296.572:49): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s=
0 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
2m  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Reached target Paths.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted Debug File System.
[  OK  ] Mounted Temporary Directory.
[  OK  ] Started Journal Service.
[    9.690391] EXT4-fs (dm-0): re-mounted. Opts: (null)
[    9.696619] audit: type=3D1130 audit(1453802296.658:50): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-remount-fs comm=3D"systemd" exe=3D"/usr/lib/systemd/syst=
emd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Flush Journal to Persistent Storage...
         Starting udev Coldplug all Devices...
         Starting Configure read-only root support...
[    9.863760] audit: type=3D1130 audit(1453802296.826:51): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dkmod-static-nodes comm=3D"systemd" exe=3D"/usr/lib/systemd/syste=
md" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Started Create list of required sta...ce nodes for the current ker=
nel.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Started Apply Kernel Variables.
[   10.017318] systemd-journald[833]: Received request to flush runtime jou=
rnal from PID 1
[  OK  ] Started LVM2 metadata daemon.
         Starting LVM2 metadata daemon...
[   10.396296] RPC: Registered named UNIX socket transport module.
[   10.402233] RPC: Registered udp transport module.
[   10.406924] RPC: Registered tcp transport module.
[   10.411611] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  OK  ] Started Configure read-only root support.
         Starting Load/Save Random Seed...
[   10.547630] systemd-journald[833]: File /var/log/journal/ad2d85e0d6434a2=
ba5102dbc59a2fb6f/system.journal corrupted or uncleanly shut down, renaming=
 and replacing.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
[   10.679891] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
[  OK  ] Mounted NFSD configuration filesystem.
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started Monitoring of LVM2 mirrors,...ng dmeventd or progress poll=
ing.
[  OK  ] Started udev Kernel Device Manager.
[   11.652047] acpi-cpufreq: overriding BIOS provided _PSD data
[  OK  ] Found device /dev/ttyS0.
[   11.745347] input: PC Speaker as /devices/platform/pcspkr/input/input3
[   11.780362] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0x2040, r=
evision 0
[   11.787981] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at=
 0x2060
[   11.952185] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   11.958641] sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revisi=
on ID: 0x3d
[   11.966340] sp5100_tco: failed to find MMIO address, giving up.
[   12.002604] EDAC MC: Ver: 3.0.0
[   12.172381] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.224074] MCE: In-kernel MCE decoding enabled.
[   12.315675] AMD64 EDAC driver v3.4.0
[   12.319332] EDAC amd64: DRAM ECC enabled.
[   12.323466] EDAC amd64: F15h detected (node 0).
[   12.328140] EDAC amd64: MC: 0:     0MB 1:     0MB
[   12.332895] EDAC amd64: MC: 2:  1024MB 3:     0MB
[   12.337600] EDAC amd64: MC: 4:     0MB 5:     0MB
[   12.342294] EDAC amd64: MC: 6:     0MB 7:     0MB
[   12.347001] EDAC amd64: MC: 0:     0MB 1:     0MB
[   12.351717] EDAC amd64: MC: 2:  1024MB 3:     0MB
[   12.356417] EDAC amd64: MC: 4:     0MB 5:     0MB
[   12.361109] EDAC amd64: MC: 6:     0MB 7:     0MB
[   12.365818] EDAC amd64: using x8 syndromes.
[   12.370019] EDAC amd64: MCT channel count: 2
[   12.374429] EDAC MC0: Giving out device to module amd64_edac controller =
F15h: DEV 0000:00:18.2 (INTERRUPT)
[   12.384534] EDAC amd64: DRAM ECC enabled.
[   12.388777] EDAC amd64: F15h detected (node 1).
[   12.393379] EDAC amd64: MC: 0:     0MB 1:     0MB
[   12.398120] EDAC amd64: MC: 2:  1024MB 3:     0MB
[   12.402824] EDAC amd64: MC: 4:     0MB 5:     0MB
[   12.407517] EDAC amd64: MC: 6:     0MB 7:     0MB
[   12.412224] EDAC amd64: MC: 0:     0MB 1:     0MB
[   12.416928] EDAC amd64: MC: 2:  1024MB 3:     0MB
[   12.421622] EDAC amd64: MC: 4:     0MB 5:     0MB
[   12.426316] EDAC amd64: MC: 6:     0MB 7:     0MB
[   12.431009] EDAC amd64: using x8 syndromes.
[   12.435194] EDAC amd64: MCT channel count: 2
[   12.439796] EDAC MC1: Giving out device to module amd64_edac controller =
F15h: DEV 0000:00:19.2 (INTERRUPT)
[   12.449641] EDAC amd64: DRAM ECC enabled.
[   12.453852] EDAC amd64: F15h detected (node 2).
[   12.458452] EDAC amd64: MC: 0:     0MB 1:     0MB
[   12.463193] EDAC amd64: MC: 2:  1024MB 3:     0MB
[   12.467902] EDAC amd64: MC: 4:     0MB 5:     0MB
[   12.472609] EDAC amd64: MC: 6:     0MB 7:     0MB
[   12.477327] EDAC amd64: MC: 0:     0MB 1:     0MB
[   12.482059] EDAC amd64: MC: 2:  1024MB 3:     0MB
[   12.486792] EDAC amd64: MC: 4:     0MB 5:     0MB
[   12.491506] EDAC amd64: MC: 6:     0MB 7:     0MB
[   12.496209] EDAC amd64: using x8 syndromes.
[   12.500404] EDAC amd64: MCT channel count: 2
[   12.505625] EDAC MC2: Giving out device to module amd64_edac controller =
F15h: DEV 0000:00:1a.2 (INTERRUPT)
[   12.515492] EDAC amd64: DRAM ECC enabled.
[   12.519712] EDAC amd64: F15h detected (node 3).
[   12.524276] EDAC amd64: MC: 0:     0MB 1:     0MB
[   12.529006] EDAC amd64: MC: 2:  1024MB 3:     0MB
[   12.533694] EDAC amd64: MC: 4:     0MB 5:     0MB
[   12.538389] EDAC amd64: MC: 6:     0MB 7:     0MB
[   12.543106] EDAC amd64: MC: 0:     0MB 1:     0MB
[   12.547808] EDAC amd64: MC: 2:  1024MB 3:     0MB
[   12.552527] EDAC amd64: MC: 4:     0MB 5:     0MB
[   12.557244] EDAC amd64: MC: 6:     0MB 7:     0MB
[   12.561946] EDAC amd64: using x8 syndromes.
[   12.566127] EDAC amd64: MCT channel count: 2
[   12.570584] EDAC MC3: Giving out device to module amd64_edac controller =
F15h: DEV 0000:00:1b.2 (INTERRUPT)
[   12.580281] EDAC PCI0: Giving out device to module amd64_edac controller=
 EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[  OK  ] Found device /dev/mapper/fedora_amd--dinar--02-swap.
         Activating swap /dev/mapper/fedora_amd--dinar--02-swap...
[  OK  ] Found device WDC_WD5001AALS-00L3B2 1.
         Starting File System Check on /dev/...e-9f82-425c-8923-e601936ce87=
8...
[  OK  ] Created slice system-lvm2\x2dpvscan.slice.
         Starting LVM2 PV scan on device 8:2...
[   13.008599] Adding 8257532k swap on /dev/mapper/fedora_amd--dinar--02-sw=
ap.  Priority:-1 extents:1 across:8257532k FS
[  OK  ] Activated swap /dev/mapper/fedora_amd--dinar--02-swap.
[  OK  ] Reached target Swap.
[   13.057346] kvm: Nested Virtualization enabled
[   13.061797] kvm: Nested Paging enabled
[  OK  ] Started File System Check on /dev/d...42e-9f82-425c-8923-e601936ce=
878.
         Mounting /boot...
[  OK  ] Found device /dev/mapper/fedora_amd--dinar--02-home.
[   13.789408] EXT4-fs (sda1): mounted filesystem with ordered data mode. O=
pts: (null)
         Starting File System Check on /dev/...er/fedora_amd--dinar--02-hom=
e...
[  OK  ] Started LVM2 PV scan on device 8:2.
[  OK  ] Mounted /boot.
[  OK  ] Started File System Check on /dev/mapper/fedora_amd--dinar--02-hom=
e.
         Mounting /home...
[   14.173845] EXT4-fs (dm-2): mounted filesystem with ordered data mode. O=
pts: (null)
[  OK  ] Mounted /home.
[  OK  ] Reached target Local File Systems.
         Starting Preprocess NFS configuration...
         Starting Restore /run/initramfs on shutdown...
      [   14.323515] audit_printk_skb: 36 callbacks suppressed
[   14.329774] audit: type=3D1130 audit(1453802301.285:64): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dnfs-config comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hos=
tname=3D? addr=3D? terminal=3D? res=3Dsuccess'
   Starting Impo[   14.351384] audit: type=3D1130 audit(1453802301.313:65):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_=
r:init_t:s0 msg=3D'unit=3Ddracut-shutdown comm=3D"systemd" exe=3D"/usr/lib/=
systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
rt network configuration from initramfs...
         Starting Tell Plymouth To Write Out Runtime Data...
[  OK  ] Started Preprocess NFS configuration.
[  OK[   14.388521] audit: type=3D1130 audit(1453802301.350:66): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dplymouth-read-write comm=3D"systemd" exe=3D"/usr/lib/systemd=
/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   14.411730] audit: type=3D1131 audit(1453802301.374:67): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dplymouth-read-write comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
  ] Started Restore /run/initramfs on shutdown.
[  OK  ] Started Tell Plymouth To[   14.442398] audit: type=3D1130 audit(14=
53802301.404:68): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=
=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dfedora-import-state comm=3D"sy=
stemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? =
res=3Dsuccess'
 Write Out Runtime Data.
[  OK  ] Started Import network configuration from initramfs.
         Starting Create Volatile Files and Directories...
[   14.631244] audit: type=3D1130 audit(1453802301.593:69): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-tmpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Started Create Volatile Files and Directories.
         Starting Security Auditing Service...
         Mounting RPC Pipe File System...
[  OK  ] Mounted RPC Pi[   14.741642] audit: type=3D1305 audit(1453802301.7=
03:70): auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:auditct=
l_t:s0 op=3D"add_rule" key=3D(null) list=3D1 res=3D1
pe File System.
[  OK  [   14.759121] audit: type=3D1130 audit(1453802301.721:71): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:=
s0 msg=3D'unit=3Dauditd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
] Started Security Auditing Service.
         Starting Update UTMP about System Boot/Shutdown...
[   14.845222] audit: type=3D1305 audit(1453802301.807:72): audit_enabled=
=3D1 old=3D1 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:au=
ditd_t:s0 res=3D1
[   14.858601] audit: type=3D1305 audit(1453802301.821:73): audit_pid=3D112=
0 old=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:audit=
d_t:s0 res=3D1
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Reached target System Initialization.
[  OK  ] Reached target Timers.
[  OK  ] Listening on RPCbind Server Activation Socket.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting GSSAPI Proxy Daemon...
         Starting Network Manager...
         Starting NTP client/server...
         Starting Login Service...
[  OK  ] Started D-Bus System Message Bus.
         Starting D-Bus System Message Bus...
[  OK  ] Started GSSAPI Proxy Daemon.
[  OK  ] Reached target NFS client services.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
         Starting Permit User Sessions...
[  OK  ] Started Login Service.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Job spooling tools.
         Starting Job spooling tools...
         Starting Wait for Plymouth Boot Screen to Quit...
         Starting Terminate Plymouth Boot Screen...
[   16.454448] IPv6: ADDRCONF(NETDEV_UP): enp1s0f1: link is not ready
[   16.587593]  alloc_coherent: 0000:01:00.1 ***=20
[   16.592064]  dma_addr: 3000, size=3D1000 ***=20
[   16.596289]  alloc_coherent: 0000:01:00.1 ***=20
[   16.600748]  dma_addr: 4000, size=3D1000 ***=20
[   16.604929]  alloc_coherent: 0000:01:00.1 ***=20
[   16.609363]  dma_addr: 5000, size=3D1000 ***=20
[   16.613542]  alloc_coherent: 0000:01:00.1 ***=20
[   16.617972]  dma_addr: 6000, size=3D1000 ***=20
[   16.622148]  alloc_coherent: 0000:01:00.1 ***=20
[   16.626581]  dma_addr: 7000, size=3D1000 ***=20
[   16.630757]  alloc_coherent: 0000:01:00.1 ***=20
[   16.635193]  dma_addr: 8000, size=3D1000 ***=20
[   16.639365]  alloc_coherent: 0000:01:00.1 ***=20
[   16.643802]  dma_addr: 9000, size=3D1000 ***=20
[   16.647977]  alloc_coherent: 0000:01:00.1 ***=20
[   16.652408]  dma_addr: a000, size=3D1000 ***=20
[   16.656585]  alloc_coherent: 0000:01:00.1 ***=20
[   16.661015]  dma_addr: b000, size=3D1000 ***=20
[   16.665191]  alloc_coherent: 0000:01:00.1 ***=20
[   16.669624]  dma_addr: c000, size=3D1000 ***=20
[   16.673800]  alloc_coherent: 0000:01:00.1 ***=20
[   16.678236]  dma_addr: d000, size=3D1000 ***=20
[   16.682405]  alloc_coherent: 0000:01:00.1 ***=20
[   16.686846]  dma_addr: e000, size=3D1000 ***=20
[   16.691019]  alloc_coherent: 0000:01:00.1 ***=20
[   16.695456]  dma_addr: f000, size=3D1000 ***=20
[   16.699626]  alloc_coherent: 0000:01:00.1 ***=20
[   16.704063]  dma_addr: 10000, size=3D1000 ***=20
[   16.708325]  alloc_coherent: 0000:01:00.1 ***=20
[   16.712754]  dma_addr: 11000, size=3D1000 ***=20
[   16.717018]  alloc_coherent: 0000:01:00.1 ***=20
[   16.721451]  dma_addr: 12000, size=3D1000 ***=20
[   16.725715]  alloc_coherent: 0000:01:00.1 ***=20
[   16.730148]  dma_addr: 13000, size=3D1000 ***=20
[   16.734407]  alloc_coherent: 0000:01:00.1 ***=20
[   16.738844]  dma_addr: 14000, size=3D1000 ***=20
[   16.784619] bnx2 0000:01:00.1 enp1s0f1: using MSIX
[   16.789723] IPv6: ADDRCONF(NETDEV_UP): enp1s0f1: link is not ready
[   16.799230] IPv6: ADDRCONF(NETDEV_UP): enp1s0f0: link is not ready
[   16.805754]  alloc_coherent: 0000:01:00.0 ***=20
[   16.810228]  dma_addr: 80d000, size=3D1000 ***=20
[   16.814579]  alloc_coherent: 0000:01:00.0 ***=20
[   16.819022]  dma_addr: 80e000, size=3D1000 ***=20
[   16.823384]  alloc_coherent: 0000:01:00.0 ***=20
[   16.827815]  dma_addr: 80f000, size=3D1000 ***=20
[   16.832166]  alloc_coherent: 0000:01:00.0 ***=20
[   16.836603]  dma_addr: 810000, size=3D1000 ***=20
[   16.840946]  alloc_coherent: 0000:01:00.0 ***=20
[   16.845383]  dma_addr: 811000, size=3D1000 ***=20
[   16.849731]  alloc_coherent: 0000:01:00.0 ***=20
[   16.854168]  dma_addr: 812000, size=3D1000 ***=20
[   16.858511]  alloc_coherent: 0000:01:00.0 ***=20
[   16.862951]  dma_addr: 813000, size=3D1000 ***=20
[   16.867294]  alloc_coherent: 0000:01:00.0 ***=20
[   16.871726]  dma_addr: 814000, size=3D1000 ***=20
[   16.876076]  alloc_coherent: 0000:01:00.0 ***=20
[   16.880505]  dma_addr: 815000, size=3D1000 ***=20
[   16.884858]  alloc_coherent: 0000:01:00.0 ***=20
[   16.889292]  dma_addr: 816000, size=3D1000 ***=20
[   16.893644]  alloc_coherent: 0000:01:00.0 ***=20
[   16.898078]  dma_addr: 817000, size=3D1000 ***=20
[   16.902421]  alloc_coherent: 0000:01:00.0 ***=20
[   16.906859]  dma_addr: 818000, size=3D1000 ***=20
[   16.911208]  alloc_coherent: 0000:01:00.0 ***=20
[   16.915650]  dma_addr: 819000, size=3D1000 ***=20
[   16.920003]  alloc_coherent: 0000:01:00.0 ***=20
[   16.924443]  dma_addr: 81a000, size=3D1000 ***=20
[   16.928794]  alloc_coherent: 0000:01:00.0 ***=20
[   16.933236]  dma_addr: 81b000, size=3D1000 ***=20
[   16.937577]  alloc_coherent: 0000:01:00.0 ***=20
[   16.942018]  dma_addr: 81c000, size=3D1000 ***=20
[   16.946373]  alloc_coherent: 0000:01:00.0 ***=20
[   16.950810]  dma_addr: 81d000, size=3D1000 ***=20
[   16.955163]  alloc_coherent: 0000:01:00.0 ***=20
[   16.959602]  dma_addr: 81e000, size=3D1000 ***=20
[   17.005620] bnx2 0000:01:00.0 enp1s0f0: using MSIX
[   17.010639] IPv6: ADDRCONF(NETDEV_UP): enp1s0f0: link is not ready
[   20.174656] bnx2 0000:01:00.0 enp1s0f0: NIC Copper Link is Up, 1000 Mbps=
 full duplex
[   20.182417]=20
[   20.184020] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0f0: link becomes ready

Fedora 23 (Twenty Three)
Kernel 4.5.0-rc1+ on an x86_64 (ttyS0)

amd-dinar-02 login:=20
Fedora 23 (Twenty Three)
Kernel 4.5.0-rc1+ on an x86_64 (ttyS0)

amd-dinar-02 login: root
Password:=20
Last login: Tue Jan 26 04:54:53 on ttyS0
**  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **
                 This System is reserved by bhe-H+wXaHxf7aKXj1p+fO2waQ@public.gmane.org

 To return this system early. You can run the command: return2beaker.sh
  Ensure you have your logs off the system before returning to Beaker

 To extend your reservation time. You can run the command:
  extendtesttime.sh
 This is an interactive script. You will be prompted for how many
  hours you would like to extend the reservation.

 You should verify the watchdog was updated succesfully after
  you extend your reservation.
  https://beaker.engineering.redhat.com/recipes/2440655

 For ssh, kvm, serial and power control operations please look here:
  https://beaker.engineering.redhat.com/view/amd-dinar-02.lab.bos.redhat.com

 For the default root password, see:
  https://beaker.engineering.redhat.com/prefs/

      Beaker Test information:
                         HOSTNAME=3Damd-dinar-02.lab.bos.redhat.com
                            JOBID=3D1202330
                         RECIPEID=3D2440655
                    RESULT_SERVER=3D[::1]:7091
                           DISTRO=3DFedora-23-20151030
                     ARCHITECTURE=3Dx86_64

      Job Whiteboard:=20

      Recipe Whiteboard:=20
**  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **
[root@amd-dinar-02 ~]# ./k.sh=20
kexec: unloaded kdump kernel
Stopping kdump: [OK]
kexec: loaded kdump kernel
Star[  160.397218] sysrq: SysRq : Trigger a crash
[  160.401799] BUG: unable to handle kernel NULL pointer dereference at    =
       (null)
[  160.409624] IP: [<ffffffff814a7766>] sysrq_handle_crash+0x16/0x20
[  160.415715] PGD 0=20
[  160.417728] Oops: 0002 [#1] SMP=20
[  160.420969] Modules linked in: kvm_amd kvm irqbypass crct10dif_pclmul cr=
c32_pclmul crc32c_intel amd64_edac_mod edac_mce_amd shpchp edac_core ghash_=
clmulni_intel sp5100_tco fam15h_power k10temp i2c_piix4 pcspkr tpm_infineon=
 acpi_cpufreq tpm_tis tpm nfsd auth_rpcgss nfs_acl lockd grace sunrpc amdkf=
d amd_iommu_v2 radeon i2c_algo_bit drm_kms_helper ttm ata_generic pata_acpi=
 drm serio_raw pata_atiixp bnx2 fjes
ting kdump: [OK][  160.457175] CPU: 20 PID: 1361 Comm: bash Not tainted 4.5=
=2E0-rc1+ #3
[  160.464721] Hardware name: AMD Dinar/Dinar, BIOS RDN1505B 06/05/2013
[  160.471061] task: ffff8801b39ed880 ti: ffff88007cb0c000 task.ti: ffff880=
07cb0c000
[  160.478516] RIP: 0010:[<ffffffff814a7766>]  [<ffffffff814a7766>] sysrq_h=
andle_crash+0x16/0x20
[  160.487026] RSP: 0018:ffff88007cb0fdd0  EFLAGS: 00010282
[  160.492319] RAX: 000000000000000f RBX: 0000000000000063 RCX: 00000000000=
00000
[  160.499430] RDX: 0000000000000000 RSI: ffff8801b5d0dfb8 RDI: 00000000000=
00063
[  160.506540] RBP: ffff88007cb0fdd0 R08: 0000000000000002 R09: 00000000000=
0050d
[  160.513651] R10: 0000000000000001 R11: 000000000000050d R12: 00000000000=
00007
[  160.520760] R13: 0000000000000000 R14: ffffffff81cc8080 R15: 00000000000=
00000
[  160.527872] FS:  00007fbf2b6ec700(0000) GS:ffff8801b5d00000(0000) knlGS:=
0000000000000000
[  160.535932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  160.541656] CR2: 0000000000000000 CR3: 0000000035e2c000 CR4: 00000000000=
406e0
[  160.548766] Stack:
[  160.550769]  ffff88007cb0fe00 ffffffff814a7f3a 0000000000000002 ffffffff=
fffffffb
[  160.558182]  ffff88007cb0ff18 0000000000000002 ffff88007cb0fe18 ffffffff=
814a83bf
[  160.565594]  ffff88003610e780 ffff88007cb0fe38 ffffffff812a1df2 ffff8801=
34bec800
[  160.573008] Call Trace:
[  160.575454]  [<ffffffff814a7f3a>] __handle_sysrq+0xea/0x140
[  160.581007]  [<ffffffff814a83bf>] write_sysrq_trigger+0x2f/0x40
[  160.586907]  [<ffffffff812a1df2>] proc_reg_write+0x42/0x70
[  160.592376]  [<ffffffff81232c67>] __vfs_write+0x37/0x110
[  160.597670]  [<ffffffff8133f36d>] ? security_file_permission+0x3d/0xc0
[  160.604177]  [<ffffffff810eaa42>] ? percpu_down_read+0x12/0x50
[  160.609989]  [<ffffffff81233579>] vfs_write+0xa9/0x1a0
[  160.615111]  [<ffffffff812344a5>] SyS_write+0x55/0xc0
[  160.620148]  [<ffffffff817a552e>] entry_SYSCALL_64_fastpath+0x12/0x71
[  160.626564] Code: ef e8 1f f8 ff ff eb db 66 2e 0f 1f 84 00 00 00 00 00 =
0f 1f 00 0f 1f 44 00 00 55 c7 05 68 ca a7 00 01 00 00 00 48 89 e5 0f ae f8 =
<c6>=20
04 25 00 00 00 00 01 5d c3 0f 1f 44 00 00 55 c7 05 d0 c9 7a=20
[  160.646370] RIP  [<ffffffff814a7766>] sysrq_handle_crash+0x16/0x20
[  160.652543]  RSP <ffff88007cb0fdd0>
[  160.656018] CR2: 0000000000000000
[    0.000000] Linux version 4.5.0-rc1+ (root-U2nCED00ozjD7sV1v1AExoa7Q5UgA9LkuPsksrO3nyI@public.gmane.org=
om) (gcc version 5.3.1 20151207 (Red Hat 5.3.1-2) (GCC) ) #3 SMP Tue Jan 26=
 04:50:54 EST 2016
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-4.5.0-rc1+ root=3D/dev/m=
apper/fedora_amd--dinar--02-root ro rd.lvm.lv=3Dfedora_amd-dinar-02/root rd=
=2Elvm.lv=3Dfedora_amd-dinar-02/swap console=3DttyS0,115200n81 LANG=3Den_US=
=2EUTF-8 irqpoll nr_cpus=3D1 reset_devices cgroup_disable=3Dmemory mce=3Dof=
f numa=3Doff udev.children-max=3D2 panic=3D10 rootflags=3Dnofail acpi_no_me=
mhotplug transparent_hugepage=3Dnever disable_cpu_apicid=3D0 elfcorehdr=3D8=
67732K
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point =
registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x0000000000097fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000098000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000d2000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000025000000-0x0000000034f64fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c7eb0000-0x00000000c7ec0fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000c7ec1000-0x00000000c7ec2fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000c7ec3000-0x00000000c7efefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000c7f00000-0x00000000c7ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] e820: last_pfn =3D 0x34f65 max_arch_pfn =3D 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT=
 =20
[    0.000000] found SMP MP-table at [mem 0x000f7b40-0x000f7b4f] mapped at =
[ffff8800000f7b40]
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x31b74000-0x32ffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F7B10 000024 (v02 PTLTD )
[    0.000000] ACPI: XSDT 0x00000000C7EB3B22 00009C (v01 PTLTD  ? XSDT   06=
040000  LTP 00000000)
[    0.000000] ACPI: FACP 0x00000000C7EBA50B 0000F4 (v03 AMD    Dinar    06=
040000 AMD  000F4240)
[    0.000000] ACPI: DSDT 0x00000000C7EB3BBE 00694D (v02 AMD    SB700    06=
040000 MSFT 03000001)
[    0.000000] ACPI: FACS 0x00000000C7EC2FC0 000040
[    0.000000] ACPI: FACS 0x00000000C7EC2FC0 000040
[    0.000000] ACPI: TCPA 0x00000000C7EBA673 000032 (v02 AMD             06=
040000 PTEC 00000000)
[    0.000000] ACPI: IVRS 0x00000000C7EBA6A5 0000A8 (v01 AMD    RD890S   06=
040000 AMD  00000000)
[    0.000000] ACPI: EINJ 0x00000000C7EBA74D 0001B0 (v01 PTL    WHEAPTL  06=
040000 PTL  00000001)
[    0.000000] ACPI: HEST 0x00000000C7EBA8FD 00031C (v01 PTL    WHEAPTL  06=
040000 PTL  00000001)
[    0.000000] ACPI: BERT 0x00000000C7EBAC19 000030 (v01 PTL    WHEAPTL  06=
040000 PTL  00000001)
[    0.000000] ACPI: SSDT 0x00000000C7EBAC49 0000F0 (v01 wheaos wheaosc  06=
040000 INTL 20090625)
[    0.000000] ACPI: ERST 0x00000000C7EBAD39 000270 (v01 PTL    WHEAPTL  06=
040000 PTL  00000001)
[    0.000000] ACPI: SSDT 0x00000000C7EBAFA9 005984 (v01 AMD    POWERNOW 06=
040000 AMD  00000001)
[    0.000000] ACPI: SLIT 0x00000000C7EC092D 00003C (v01 AMD    AGESA    06=
040000 AMD  00000001)
[    0.000000] ACPI: SRAT 0x00000000C7EC0969 000320 (v02 AMD    AGESA    06=
040000 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000C7EC0C89 0000F5 (v01 AMD-K8 AMD-ACPI 06=
040000  AMD 00000001)
[    0.000000] ACPI: APIC 0x00000000C7EC0D7E 00020E (v01 PTLTD  ? APIC   06=
040000  LTP 00000000)
[    0.000000] ACPI: MCFG 0x00000000C7EC0F8C 00003C (v01 PTLTD    MCFG   06=
040000  LTP 00000000)
[    0.000000] ACPI: HPET 0x00000000C7EC0FC8 000038 (v01 PTLTD  HPETTBL  06=
040000  LTP 00000001)
[    0.000000] NUMA turned off
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000034f64fff]
[    0.000000] NODE_DATA(0) allocated [mem 0x34f53000-0x34f64fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x0000000034f64fff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000097fff]
[    0.000000]   node   0: [mem 0x0000000025000000-0x0000000034f64fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000034f64=
fff]
[    0.000000] ACPI: PM-Timer IO Port: 0x2008
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 0/0x20 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 1/0x21 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 2/0x22 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 3/0x23 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 4/0x24 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 5/0x25 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 6/0x26 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 7/0x27 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 8/0x28 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 9/0x29 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 10/0x2a ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 11/0x2b ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 12/0x2c ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 13/0x2d ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 14/0x2e ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 15/0x2f ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 16/0x40 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 17/0x41 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 18/0x42 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keepi=
ng one slot for boot cpu.  Processor 19/0x43 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2=
1/0x45 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2=
2/0x46 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2=
3/0x47 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2=
4/0x48 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2=
5/0x49 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2=
6/0x4a ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2=
7/0x4b ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2=
8/0x4c ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2=
9/0x4d ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 3=
0/0x4e ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 3=
1/0x4f ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-=
23
[    0.000000] IOAPIC[1]: apic_id 1, version 33, address 0xc8000000, GSI 24=
-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 low level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x43538301 base: 0xfed00000
[    0.000000] smpboot: 32 Processors exceeds NR_CPUS limit of 1
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00098000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000d1fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000d2000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x00100000-0x24ffffff]
[    0.000000] e820: [mem 0x34f65000-0xc7eaffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_=
node_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff880034c00000 s98648 r8192=
 d32424 u2097152
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Tota=
l pages: 64486
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-4.5.0-rc1+ root=
=3D/dev/mapper/fedora_amd--dinar--02-root ro rd.lvm.lv=3Dfedora_amd-dinar-0=
2/root rd.lvm.lv=3Dfedora_amd-dinar-02/swap console=3DttyS0,115200n81 LANG=
=3Den_US.UTF-8 irqpoll nr_cpus=3D1 reset_devices cgroup_disable=3Dmemory mc=
e=3Doff numa=3Doff udev.children-max=3D2 panic=3D10 rootflags=3Dnofail acpi=
_no_memhotplug transparent_hugepage=3Dnever disable_cpu_apicid=3D0 elfcoreh=
dr=3D867732K
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] PID hash table entries: 1024 (order: 1, 8192 bytes)
[    0.000000] Memory: 215728K/262128K available (7848K kernel code, 1297K =
rwdata, 3452K rodata, 1520K init, 1472K bss, 46400K reserved, 0K cma-reserv=
ed)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=3D1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS:4352 nr_irqs:256 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0.
[    0.000000] Spurious LAPIC timer interrupt on cpu 0
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2793.084 MHz processor
[    0.000053] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5586.16 BogoMIPS (lpj=3D2793084)
[    0.010671] pid_max: default: 32768 minimum: 301
[    0.015285] ACPI: Core revision 20160108
[    0.029433] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    0.035809]=20
[    0.037345] Security Framework initialized
[    0.041459] Yama: becoming mindful.
[    0.044939] SELinux:  Initializing.
[    0.048548] Dentry cache hash table entries: 32768 (order: 6, 262144 byt=
es)
[    0.055672] Inode-cache hash table entries: 16384 (order: 5, 131072 byte=
s)
[    0.062625] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.069163] Mountpoint-cache hash table entries: 512 (order: 0, 4096 byt=
es)
[    0.076614] Disabling memory control group subsystem
[    0.081795] CPU: Physical Processor ID: 1
[    0.085821] CPU: Processor Core ID: 4
[    0.089471] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.095368] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.112332] Freeing SMP alternatives memory: 32K (ffffffff81ec2000 - fff=
fffff81eca000)
[    0.123972] ftrace: allocating 29513 entries in 116 pages
[    0.151885] Translation is already enabled - trying to copy translation =
structures
[    0.290328] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.407733] smpboot: CPU0: AMD Opteron(tm) Processor 6386 SE (family: 0x=
15, model: 0x2, stepping: 0x0)
[    0.417090] Performance Events: Fam15h core perfctr, Broken BIOS detecte=
d, complain to your hardware vendor.
[    0.426968] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR=
 c0010200 is 530076)
[    0.435377] AMD PMU driver.
[    0.438162] ... version:                0
[    0.442158] ... bit width:              48
[    0.446239] ... generic registers:      6
[    0.450235] ... value mask:             0000ffffffffffff
[    0.455529] ... max period:             00007fffffffffff
[    0.460822] ... fixed-purpose events:   0
[    0.464818] ... event mask:             000000000000003f
[    0.471348] x86: Booted up 1 node, 1 CPUs
[    0.475382] smpboot: Total of 1 processors activated (5586.16 BogoMIPS)
[    0.481995] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    0.494117] devtmpfs: initialized
[    0.503448] PM: Registering ACPI NVS region [mem 0xc7ec1000-0xc7ec2fff] =
(8192 bytes)
[    0.511340] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.521227] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[    0.528210] pinctrl core: initialized pinctrl subsystem
[    0.533519] RTC time:  5:00:51, date: 01/26/16
[    0.538193] NET: Registered protocol family 16
[    0.543091] cpuidle: using governor menu
[    0.547295] ACPI: bus type PCI registered
[    0.551328] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.557924] PCI: MMCONFIG for domain 0000 [bus 00-01] at [mem 0xe0000000=
-0xe01fffff] (base 0xe0000000)
[    0.567202] PCI: not using MMCONFIG
[    0.570679] PCI: Using configuration type 1 for base access
[    0.576233] PCI: Using configuration type 1 for extended access
[    0.585263] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.592009] ACPI: Added _OSI(Module Device)
[    0.596216] ACPI: Added _OSI(Processor Device)
[    0.600647] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.605337] ACPI: Added _OSI(Processor Aggregator Device)
[    0.623324] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.630806] ACPI: Interpreter enabled
[    0.634515] ACPI: (supports S0 S3 S5)
[    0.638168] ACPI: Using IOAPIC for interrupt routing
[    0.643218] PCI: MMCONFIG for domain 0000 [bus 00-01] at [mem 0xe0000000=
-0xe01fffff] (base 0xe0000000)
[    0.653271] PCI: MMCONFIG at [mem 0xe0000000-0xe01fffff] reserved in ACP=
I motherboard resources
[    0.662055] HEST: Table parsing has been initialized.
[    0.667128] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.692067] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-bf])
[    0.698270] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    0.707097] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER =
PCIeCapability]
[    0.715125] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [=
bus 00-01] only partially covers this bridge
[    0.727493] acpi PNP0A08:00: host bridge window expanded to [io  0x03e0-=
0x0cf7]; [io  0x03e0-0x0cf7 window] ignored
[    0.738331] PCI host bridge to bus 0000:00
[    0.742418] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.749185] pci_bus 0000:00: root bus resource [io  0x0d00-0x3fff window]
[    0.755953] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.763414] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xd7fffff=
f window]
[    0.770872] pci_bus 0000:00: root bus resource [mem 0xc8000000-0xce0ffff=
f window]
[    0.778333] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    0.784495] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000caff=
f window]
[    0.791953] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4500=
0 window]
[    0.799412] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.806180] pci_bus 0000:00: root bus resource [bus 00-bf]
[    0.812308] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.818619] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.824580] pci 0000:00:12.1: System wakeup disabled by ACPI
[    0.830588] pci 0000:00:12.2: System wakeup disabled by ACPI
[    0.836558] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.842515] pci 0000:00:13.1: System wakeup disabled by ACPI
[    0.848521] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.854713] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    0.861827] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.868334] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    0.875447] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.882552] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.888513] pci 0000:00:14.5: System wakeup disabled by ACPI
[    0.900681] pci 0000:00:04.0: PCI bridge to [bus 01]
[    0.906090] pci 0000:00:14.4: PCI bridge to [bus 02] (subtractive decode)
[    0.913802] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
[    0.920512] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
[    0.927219] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
[    0.933920] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
[    0.940623] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
[    0.947325] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
[    0.954026] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
[    0.960740] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
[    0.968252] ACPI: PCI Interrupt Link [LN24] (IRQs *24)
[    0.973513] ACPI: PCI Interrupt Link [LN25] (IRQs *25)
[    0.978773] ACPI: PCI Interrupt Link [LN26] (IRQs *26)
[    0.984030] ACPI: PCI Interrupt Link [LN27] (IRQs *27)
[    0.989286] ACPI: PCI Interrupt Link [LN28] (IRQs *28)
[    0.994539] ACPI: PCI Interrupt Link [LN29] (IRQs *29)
[    0.999795] ACPI: PCI Interrupt Link [LN30] (IRQs *30)
[    1.005051] ACPI: PCI Interrupt Link [LN31] (IRQs *31)
[    1.010307] ACPI: PCI Interrupt Link [LN32] (IRQs *32)
[    1.015560] ACPI: PCI Interrupt Link [LN33] (IRQs *33)
[    1.020814] ACPI: PCI Interrupt Link [LN34] (IRQs *34)
[    1.026069] ACPI: PCI Interrupt Link [LN35] (IRQs *35)
[    1.031324] ACPI: PCI Interrupt Link [LN36] (IRQs *36)
[    1.036576] ACPI: PCI Interrupt Link [LN37] (IRQs *37)
[    1.041831] ACPI: PCI Interrupt Link [LN38] (IRQs *38)
[    1.047085] ACPI: PCI Interrupt Link [LN39] (IRQs *39)
[    1.052336] ACPI: PCI Interrupt Link [LN40] (IRQs *40)
[    1.057587] ACPI: PCI Interrupt Link [LN41] (IRQs *41)
[    1.062840] ACPI: PCI Interrupt Link [LN42] (IRQs *42)
[    1.068095] ACPI: PCI Interrupt Link [LN43] (IRQs *43)
[    1.073346] ACPI: PCI Interrupt Link [LN44] (IRQs *44)
[    1.078600] ACPI: PCI Interrupt Link [LN45] (IRQs *45)
[    1.083862] ACPI: PCI Interrupt Link [LN46] (IRQs *46)
[    1.089118] ACPI: PCI Interrupt Link [LN47] (IRQs *47)
[    1.094371] ACPI: PCI Interrupt Link [LN48] (IRQs *48)
[    1.099626] ACPI: PCI Interrupt Link [LN49] (IRQs *49)
[    1.104881] ACPI: PCI Interrupt Link [LN50] (IRQs *50)
[    1.110135] ACPI: PCI Interrupt Link [LN51] (IRQs *51)
[    1.115387] ACPI: PCI Interrupt Link [LN52] (IRQs *52)
[    1.120644] ACPI: PCI Interrupt Link [LN53] (IRQs *53)
[    1.125899] ACPI: PCI Interrupt Link [LN54] (IRQs *54)
[    1.131154] ACPI: PCI Interrupt Link [LN55] (IRQs *55)
[    1.136450] ACPI: Enabled 2 GPEs in block 00 to 1F
[    1.141481] vgaarb: setting as boot device: PCI:0000:02:06.0
[    1.147120] vgaarb: device added: PCI:0000:02:06.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    1.155186] vgaarb: loaded
[    1.157884] vgaarb: bridge control possible 0000:02:06.0
[    1.163382] SCSI subsystem initialized
[    1.167287] ACPI: bus type USB registered
[    1.171358] usbcore: registered new interface driver usbfs
[    1.176881] usbcore: registered new interface driver hub
[    1.182195] usbcore: registered new device driver usb
[    1.187409] PCI: Using ACPI for IRQ routing
[    1.191969] NetLabel: Initializing
[    1.195394] NetLabel:  domain hash size =3D 128
[    1.199737] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    1.204708] NetLabel:  unlabeled traffic allowed by default
[    1.210518] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    1.215704] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    1.223630] clocksource: Switched to clocksource hpet
[    1.246994] VFS: Disk quotas dquot_6.6.0
[    1.250974] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    1.258447] pnp: PnP ACPI init
[    1.262021] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    1.268658] system 00:00: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    1.275604] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.282203] system 00:00: [mem 0xc8000000-0xc8007fff] could not be reser=
ved
[    1.290335] system 00:04: [io  0x0220-0x022f] has been reserved
[    1.296277] system 00:04: [io  0x040b] has been reserved
[    1.301578] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    1.307485] system 00:04: [io  0x04d6] has been reserved
[    1.312785] system 00:04: [io  0x0530-0x0537] has been reserved
[    1.318691] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    1.324599] system 00:04: [io  0x0c14] has been reserved
[    1.329900] system 00:04: [io  0x0c50-0x0c52] has been reserved
[    1.335805] system 00:04: [io  0x0c6c] has been reserved
[    1.341107] system 00:04: [io  0x0c6f] has been reserved
[    1.346408] system 00:04: [io  0x0ca0-0x0caf] has been reserved
[    1.352314] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
[    1.358222] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
[    1.364130] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
[    1.370038] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
[    1.375946] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    1.381852] system 00:04: [io  0x2000-0x205f] could not be reserved
[    1.388104] system 00:04: [io  0x2100-0x21ff window] has been reserved
[    1.394625] system 00:04: [io  0x2200-0x22ff window] has been reserved
[    1.401139] system 00:04: [io  0x0f40-0x0f47] has been reserved
[    1.407045] system 00:04: [io  0x087f] has been reserved
[    1.412545] system 00:05: [mem 0x000e0000-0x000fffff] could not be reser=
ved
[    1.419528] system 00:05: [mem 0xfff00000-0xffffffff] has been reserved
[    1.426127] system 00:05: [mem 0xfec10000-0xfec1001f] has been reserved
[    1.433735] pnp: PnP ACPI: found 7 devices
[    1.446036] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    1.454920] pci 0000:01:00.0: BAR 6: no space for [mem size 0x00020000 p=
ref]
[    1.461954] pci 0000:01:00.0: BAR 6: failed to assign [mem size 0x000200=
00 pref]
[    1.469333] pci 0000:01:00.1: BAR 6: no space for [mem size 0x00020000 p=
ref]
[    1.476366] pci 0000:01:00.1: BAR 6: failed to assign [mem size 0x000200=
00 pref]
[    1.483744] pci 0000:00:04.0: PCI bridge to [bus 01]
[    1.488700] pci 0000:00:04.0:   bridge window [mem 0xca000000-0xcdffffff]
[    1.495481] pci 0000:02:06.0: BAR 6: assigned [mem 0xce020000-0xce03ffff=
 pref]
[    1.502689] pci 0000:00:14.4: PCI bridge to [bus 02]
[    1.507646] pci 0000:00:14.4:   bridge window [io  0x3000-0x3fff]
[    1.513728] pci 0000:00:14.4:   bridge window [mem 0xce000000-0xce0fffff]
[    1.520503] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xd7ffffff=
 pref]
[    1.527861] NET: Registered protocol family 2
[    1.532594] TCP established hash table entries: 2048 (order: 2, 16384 by=
tes)
[    1.539694] TCP bind hash table entries: 2048 (order: 3, 32768 bytes)
[    1.546135] TCP: Hash tables configured (established 2048 bind 2048)
[    1.552506] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    1.558333] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    1.564673] NET: Registered protocol family 1
[    1.823902] Unpacking initramfs...
[    2.701963] Freeing initrd memory: 21040K (ffff880031b74000 - ffff880033=
000000)
[    2.845292]  amd_iommu_add_device: 0000:00:00.0 ***=20
[    2.850347] allocated domain->id: 12 ***
[    2.855299]  amd_iommu_attach_device: 0000:00:00.0 ***=20
[    2.860518] iommu: Adding device 0000:00:00.0 to group 0
[    2.865818]  amd_iommu_add_device: 0000:00:00.2 ***=20
[    2.870772]  amd_iommu_add_device: 0000:00:04.0 ***=20
[    2.875748] allocated domain->id: 13 ***
[    2.880660]  amd_iommu_attach_device: 0000:00:04.0 ***=20
[    2.885876] iommu: Adding device 0000:00:04.0 to group 1
[    2.891176]  amd_iommu_add_device: 0000:00:11.0 ***=20
[    2.896147] allocated domain->id: 14 ***
[    2.901060]  amd_iommu_attach_device: 0000:00:11.0 ***=20
[    2.906278] iommu: Adding device 0000:00:11.0 to group 2
[    2.911576]  amd_iommu_add_device: 0000:00:12.0 ***=20
[    2.916620] allocated domain->id: 15 ***
[    2.921494]  amd_iommu_attach_device: 0000:00:12.0 ***=20
[    2.926742] iommu: Adding device 0000:00:12.0 to group 3
[    2.932040]  amd_iommu_add_device: 0000:00:12.1 ***=20
[    2.937016]  amd_iommu_attach_device: 0000:00:12.1 ***=20
[    2.942233] iommu: Adding device 0000:00:12.1 to group 3
[    2.947531]  amd_iommu_add_device: 0000:00:12.2 ***=20
[    2.952503]  amd_iommu_attach_device: 0000:00:12.2 ***=20
[    2.957720] iommu: Adding device 0000:00:12.2 to group 3
[    2.963018]  amd_iommu_add_device: 0000:00:13.0 ***=20
[    2.968015] allocated domain->id: 16 ***
[    2.972962]  amd_iommu_attach_device: 0000:00:13.0 ***=20
[    2.978178] iommu: Adding device 0000:00:13.0 to group 4
[    2.983478]  amd_iommu_add_device: 0000:00:13.1 ***=20
[    2.988451]  amd_iommu_attach_device: 0000:00:13.1 ***=20
[    2.993666] iommu: Adding device 0000:00:13.1 to group 4
[    2.998965]  amd_iommu_add_device: 0000:00:13.2 ***=20
[    3.003939]  amd_iommu_attach_device: 0000:00:13.2 ***=20
[    3.009154] iommu: Adding device 0000:00:13.2 to group 4
[    3.014455]  amd_iommu_add_device: 0000:00:14.0 ***=20
[    3.019428] allocated domain->id: 17 ***
[    3.024339]  amd_iommu_attach_device: 0000:00:14.0 ***=20
[    3.029553] iommu: Adding device 0000:00:14.0 to group 5
[    3.034853]  amd_iommu_add_device: 0000:00:14.1 ***=20
[    3.039824] allocated domain->id: 18 ***
[    3.044737]  amd_iommu_attach_device: 0000:00:14.1 ***=20
[    3.049952] iommu: Adding device 0000:00:14.1 to group 6
[    3.055251]  amd_iommu_add_device: 0000:00:14.3 ***=20
[    3.060225] allocated domain->id: 19 ***
[    3.065134]  amd_iommu_attach_device: 0000:00:14.3 ***=20
[    3.070351] iommu: Adding device 0000:00:14.3 to group 7
[    3.075651]  amd_iommu_add_device: 0000:00:14.4 ***=20
[    3.080624] allocated domain->id: 20 ***
[    3.085499]  amd_iommu_attach_device: 0000:00:14.4 ***=20
[    3.090747] iommu: Adding device 0000:00:14.4 to group 8
[    3.096047]  amd_iommu_add_device: 0000:00:14.5 ***=20
[    3.101020] allocated domain->id: 21 ***
[    3.105933]  amd_iommu_attach_device: 0000:00:14.5 ***=20
[    3.111148] iommu: Adding device 0000:00:14.5 to group 9
[    3.116447]  amd_iommu_add_device: 0000:00:18.0 ***=20
[    3.121402]  amd_iommu_add_device: 0000:00:18.1 ***=20
[    3.126355]  amd_iommu_add_device: 0000:00:18.2 ***=20
[    3.131309]  amd_iommu_add_device: 0000:00:18.3 ***=20
[    3.136263]  amd_iommu_add_device: 0000:00:18.4 ***=20
[    3.141214]  amd_iommu_add_device: 0000:00:18.5 ***=20
[    3.146168]  amd_iommu_add_device: 0000:00:19.0 ***=20
[    3.151119]  amd_iommu_add_device: 0000:00:19.1 ***=20
[    3.156073]  amd_iommu_add_device: 0000:00:19.2 ***=20
[    3.161027]  amd_iommu_add_device: 0000:00:19.3 ***=20
[    3.165980]  amd_iommu_add_device: 0000:00:19.4 ***=20
[    3.170934]  amd_iommu_add_device: 0000:00:19.5 ***=20
[    3.175888]  amd_iommu_add_device: 0000:00:1a.0 ***=20
[    3.180842]  amd_iommu_add_device: 0000:00:1a.1 ***=20
[    3.185796]  amd_iommu_add_device: 0000:00:1a.2 ***=20
[    3.190747]  amd_iommu_add_device: 0000:00:1a.3 ***=20
[    3.195701]  amd_iommu_add_device: 0000:00:1a.4 ***=20
[    3.200651]  amd_iommu_add_device: 0000:00:1a.5 ***=20
[    3.205605]  amd_iommu_add_device: 0000:00:1b.0 ***=20
[    3.210559]  amd_iommu_add_device: 0000:00:1b.1 ***=20
[    3.215513]  amd_iommu_add_device: 0000:00:1b.2 ***=20
[    3.220466]  amd_iommu_add_device: 0000:00:1b.3 ***=20
[    3.225420]  amd_iommu_add_device: 0000:00:1b.4 ***=20
[    3.230374]  amd_iommu_add_device: 0000:00:1b.5 ***=20
[    3.235328]  amd_iommu_add_device: 0000:01:00.0 ***=20
[    3.240329] allocated domain->id: 22 ***
[    3.245275]  amd_iommu_attach_device: 0000:01:00.0 ***=20
[    3.250492] iommu: Adding device 0000:01:00.0 to group 10
[    3.255877]  amd_iommu_add_device: 0000:01:00.1 ***=20
[    3.260867]  amd_iommu_attach_device: 0000:01:00.1 ***=20
[    3.266125] iommu: Adding device 0000:01:00.1 to group 10
[    3.271510]  amd_iommu_add_device: 0000:02:06.0 ***=20
[    3.276474]  amd_iommu_attach_device: 0000:02:06.0 ***=20
[    3.281688] iommu: Adding device 0000:02:06.0 to group 8
[    3.286989] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    3.292288] AMD-Vi: Interrupt remapping enabled
[    3.297062] AMD-Vi: Lazy IO/TLB flushing enabled
[    3.301993] perf: AMD NB counters detected
[    3.306125] LVT offset 0 assigned for vector 0x400
[    3.310951] perf: AMD IBS detected (0x000000ff)
[    3.316405] futex hash table entries: 256 (order: 2, 16384 bytes)
[    3.322610] audit: initializing netlink subsys (disabled)
[    3.328069] audit: type=3D2000 audit(1453784451.349:1): initialized
[    3.334845] Initialise system trusted keyring
[    3.343543] zbud: loaded
[    3.347241] Key type big_key registered
[    3.360128] NET: Registered protocol family 38
[    3.364605] Key type asymmetric registered
[    3.368748] Asymmetric key parser 'x509' registered
[    3.373716] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 250)
[    3.381175] io scheduler noop registered
[    3.385096] io scheduler deadline registered
[    3.389433] io scheduler cfq registered (default)
[    3.394765] ACPI: PCI Interrupt Link [LN52] enabled at IRQ 52
[    3.400948] pcieport 0000:00:04.0: Signaling PME through PCIe PME interr=
upt
[    3.407942] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    3.414458] pci 0000:01:00.1: Signaling PME through PCIe PME interrupt
[    3.420995] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    3.426577] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    3.433388] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    3.441760] ACPI: Power Button [PWRB]
[    3.445515] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    3.452927] ACPI: Power Button [PWRF]
[    3.457003] ERST: Error Record Serialization Table (ERST) support is ini=
tialized.
[    3.464511] pstore: Registered erst as persistent store backend
[    3.471154] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    3.477538] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.504687] 00:06: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    3.515124] Non-volatile memory driver v1.3
[    3.519399] Linux agpgart interface v0.103
[    3.527991] ACPI: PCI Interrupt Link [LN44] enabled at IRQ 44
[    3.534003] ACPI: PCI Interrupt Link [LN45] enabled at IRQ 45
[    3.541025]  amd_iommu_dma_supported: 0000:00:11.0 ***=20
[    3.546306] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x=
3f impl SATA mode
[    3.554466] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led clo pmp pi=
o slum part ccc=20
[    3.562563]  alloc_coherent: 0000:00:11.0 ***=20
[    3.567044] set_dte_entry  devid: 00:11.0, domain->id:14 ***=20
[    3.572810]  __map_single: 0000:00:11.0 ***=20
[    3.577073]  dma_addr: 20000, size=3D17000 ***=20
[    3.581443]  alloc_coherent: 0000:00:11.0 ***=20
[    3.585922]  dma_addr: 40000, size=3D17000 ***=20
[    3.590328]  alloc_coherent: 0000:00:11.0 ***=20
[    3.594805]  dma_addr: 60000, size=3D17000 ***=20
[    3.599210]  alloc_coherent: 0000:00:11.0 ***=20
[    3.603688]  dma_addr: 80000, size=3D17000 ***=20
[    3.608093]  alloc_coherent: 0000:00:11.0 ***=20
[    3.612577]  dma_addr: a0000, size=3D17000 ***=20
[    3.616945]  alloc_coherent: 0000:00:11.0 ***=20
[    3.621423]  dma_addr: c0000, size=3D17000 ***=20
[    3.627038] scsi host0: ahci
[    3.630117] scsi host1: ahci
[    3.633170] scsi host2: ahci
[    3.636224] scsi host3: ahci
[    3.639279] scsi host4: ahci
[    3.642333] scsi host5: ahci
[    3.645335] ata1: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801410=
0 irq 22
[    3.652713] ata2: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801418=
0 irq 22
[    3.660091] ata3: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801420=
0 irq 22
[    3.667470] ata4: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801428=
0 irq 22
[    3.674847] ata5: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801430=
0 irq 22
[    3.682223] ata6: SATA max UDMA/133 abar m1024@0xc8014000 port 0xc801438=
0 irq 22
[    3.690034] libphy: Fixed MDIO Bus: probed
[    3.694277] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.700830] ehci-pci: EHCI PCI platform driver
[    3.705570] ehci-pci 0000:00:12.2: EHCI Host Controller
[    3.710850] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus =
number 1
[    3.718267] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    3.726955] ehci-pci 0000:00:12.2: debug port 1
[    3.731482]  alloc_coherent: 0000:00:12.2 ***=20
[    3.735921] set_dte_entry  devid: 00:12.2, domain->id:15 ***=20
[    3.741655]  __map_single: 0000:00:12.2 ***=20
[    3.745915]  dma_addr: 1000, size=3D1000 ***=20
[    3.750090]  alloc_coherent: 0000:00:12.2 ***=20
[    3.754529]  dma_addr: 2000, size=3D1000 ***=20
[    3.758704]  alloc_coherent: 0000:00:12.2 ***=20
[    3.763141]  dma_addr: 3000, size=3D1000 ***=20
[    3.767361] ehci-pci 0000:00:12.2: irq 17, io mem 0xc8014400
[    3.778589] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    3.784408] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.791216] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.798422] usb usb1: Product: EHCI Host Controller
[    3.803289] usb usb1: Manufacturer: Linux 4.5.0-rc1+ ehci_hcd
[    3.809021] usb usb1: SerialNumber: 0000:00:12.2
[    3.813850] hub 1-0:1.0: USB hub found
[    3.817646] hub 1-0:1.0: 6 ports detected
[    3.822281] ehci-pci 0000:00:13.2: EHCI Host Controller
[    3.827613] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus =
number 2
[    3.834994] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    3.843681] ehci-pci 0000:00:13.2: debug port 1
[    3.848207]  alloc_coherent: 0000:00:13.2 ***=20
[    3.852645] set_dte_entry  devid: 00:13.2, domain->id:16 ***=20
[    3.858379]  __map_single: 0000:00:13.2 ***=20
[    3.862639]  dma_addr: 1000, size=3D1000 ***=20
[    3.866813]  alloc_coherent: 0000:00:13.2 ***=20
[    3.871250]  dma_addr: 2000, size=3D1000 ***=20
[    3.875424]  alloc_coherent: 0000:00:13.2 ***=20
[    3.879859]  dma_addr: 3000, size=3D1000 ***=20
[    3.884078] ehci-pci 0000:00:13.2: irq 19, io mem 0xc8014800
[    3.895568] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    3.901394] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.908206] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.915410] usb usb2: Product: EHCI Host Controller
[    3.920277] usb usb2: Manufacturer: Linux 4.5.0-rc1+ ehci_hcd
[    3.926011] usb usb2: SerialNumber: 0000:00:13.2
[    3.931217] hub 2-0:1.0: USB hub found
[    3.935013] hub 2-0:1.0: 6 ports detected
[    3.939402] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.945606] ohci-pci: OHCI PCI platform driver
[    3.950329] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    3.955980] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus =
number 3
[    3.963428]  alloc_coherent: 0000:00:12.0 ***=20
[    3.967867] set_dte_entry  devid: 00:12.0, domain->id:15 ***=20
[    3.973605]  __map_single: 0000:00:12.0 ***=20
[    3.977868]  dma_addr: 4000, size=3D1000 ***=20
[    3.982110] ohci-pci 0000:00:12.0: irq 16, io mem 0xc8015000
[    3.997964] ata2: SATA link down (SStatus 0 SControl 300)
[    4.003388] ata1: SATA link down (SStatus 0 SControl 300)
[    4.008830] ata5: SATA link down (SStatus 0 SControl 300)
[    4.014266] ata3: SATA link down (SStatus 0 SControl 300)
[    4.042831] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    4.049640] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    4.056845] usb usb3: Product: OHCI PCI host controller
[    4.062059] usb usb3: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    4.067790] usb usb3: SerialNumber: 0000:00:12.0
[    4.072662] hub 3-0:1.0: USB hub found
[    4.076449] hub 3-0:1.0: 3 ports detected
[    4.080994] ohci-pci 0000:00:12.1: OHCI PCI host controller
[    4.086624] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus =
number 4
[    4.094044]  alloc_coherent: 0000:00:12.1 ***=20
[    4.098482] set_dte_entry  devid: 00:12.1, domain->id:15 ***=20
[    4.104214]  __map_single: 0000:00:12.1 ***=20
[    4.108475]  dma_addr: 5000, size=3D1000 ***=20
[    4.112666] ohci-pci 0000:00:12.1: irq 16, io mem 0xc8016000
[    4.172620] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.178813] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.185101] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    4.191919] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    4.199125] usb usb4: Product: OHCI PCI host controller
[    4.204339] usb usb4: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    4.210071] usb usb4: SerialNumber: 0000:00:12.1
[    4.214704] ata6.00: ATAPI: Optiarc DVD RW AD-7240S, 1.01, max UDMA/100
[    4.221453] ata4.00: ATA-8: WDC WD5001AALS-00L3B2, 01.03B01, max UDMA/133
[    4.228236] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)=
, AA
[    4.235368] hub 4-0:1.0: USB hub found
[    4.239137] ata6.00: configured for UDMA/100
[    4.243416] hub 4-0:1.0: 3 ports detected
[    4.248006] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    4.253641] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus =
number 5
[    4.261080]  alloc_coherent: 0000:00:13.0 ***=20
[    4.265539] set_dte_entry  devid: 00:13.0, domain->id:16 ***=20
[    4.271278]  __map_single: 0000:00:13.0 ***=20
[    4.275540]  dma_addr: 4000, size=3D1000 ***=20
[    4.279722] ata4.00: configured for UDMA/133
[    4.284251] scsi 3:0:0:0: Direct-Access     ATA      WDC WD5001AALS-0 3B=
01 PQ: 0 ANSI: 5
[    4.292375] ohci-pci 0000:00:13.0: irq 18, io mem 0xc8017000
[    4.298313] sd 3:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB=
/466 GiB)
[    4.305783] tsc: Refined TSC clocksource calibration: 2793.093 MHz
[    4.311951] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x284=
2c42090e, max_idle_ns: 440795320979 ns
[    4.322018] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    4.327410] sd 3:0:0:0: [sda] Write Protect is off
[    4.332504] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.342167] scsi 5:0:0:0: CD-ROM            Optiarc  DVD RW AD-7240S  1.=
01 PQ: 0 ANSI: 5
[    4.354344]  sda: sda1 sda2
[    4.357643] sd 3:0:0:0: [sda] Attached SCSI disk
[    4.362341] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    4.369148] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    4.376356] usb usb5: Product: OHCI PCI host controller
[    4.381569] usb usb5: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    4.387301] usb usb5: SerialNumber: 0000:00:13.0
[    4.392124] hub 5-0:1.0: USB hub found
[    4.396102] hub 5-0:1.0: 3 ports detected
[    4.400566] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    4.406196] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus =
number 6
[    4.413635]  alloc_coherent: 0000:00:13.1 ***=20
[    4.418110] set_dte_entry  devid: 00:13.1, domain->id:16 ***=20
[    4.423855]  __map_single: 0000:00:13.1 ***=20
[    4.428116]  dma_addr: 5000, size=3D1000 ***=20
[    4.432299] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd=
/rw xa/form2 cdda tray
[    4.440889] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.446117] ohci-pci 0000:00:13.1: irq 18, io mem 0xc8018000
[    4.452086] sr 5:0:0:0: Attached scsi generic sg1 type 5
[    4.506634] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    4.513444] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    4.520649] usb usb6: Product: OHCI PCI host controller
[    4.525861] usb usb6: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    4.531594] usb usb6: SerialNumber: 0000:00:13.1
[    4.536414] hub 6-0:1.0: USB hub found
[    4.540213] hub 6-0:1.0: 3 ports detected
[    4.544763] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    4.550398] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus =
number 7
[    4.557818]  alloc_coherent: 0000:00:14.5 ***=20
[    4.562256] set_dte_entry  devid: 00:14.5, domain->id:21 ***=20
[    4.567987]  __map_single: 0000:00:14.5 ***=20
[    4.572249]  dma_addr: 1000, size=3D1000 ***=20
[    4.576439] ohci-pci 0000:00:14.5: irq 18, io mem 0xc8019000
[    4.636627] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    4.643436] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    4.650644] usb usb7: Product: OHCI PCI host controller
[    4.655856] usb usb7: Manufacturer: Linux 4.5.0-rc1+ ohci_hcd
[    4.661588] usb usb7: SerialNumber: 0000:00:14.5
[    4.666469] hub 7-0:1.0: USB hub found
[    4.670264] hub 7-0:1.0: 2 ports detected
[    4.674493] uhci_hcd: USB Universal Host Controller Interface driver
[    4.680950] usbcore: registered new interface driver usbserial
[    4.686830] usbcore: registered new interface driver usbserial_generic
[    4.693354] usbserial: USB Serial support registered for generic
[    4.699423] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0=
x60,0x64 irq 1,12
[    4.959939] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.965071] mousedev: PS/2 mouse device common for all mice
[    4.971004] rtc_cmos 00:01: RTC can wake from S4
[    4.975795] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    4.981968] rtc_cmos 00:01: alarms up to one month, 114 bytes nvram, hpe=
t irqs
[    4.989281] device-mapper: uevent: version 1.0.3
[    4.994430] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised:=
 dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    5.004153] hidraw: raw HID events driver (C) Jiri Kosina
[    5.009676] usbcore: registered new interface driver usbhid
[    5.015277] usbhid: USB HID core driver
[    5.019264] drop_monitor: Initializing network drop monitor service
[    5.025691] ip_tables: (C) 2000-2006 Netfilter Core Team
[    5.031060] Initializing XFRM netlink socket
[    5.035712] NET: Registered protocol family 10
[    5.040591] mip6: Mobile IPv6
[    5.043599] NET: Registered protocol family 17
[    5.048047] mce: Unable to init device /dev/mcelog (rc: -5)
[    5.053874] microcode: CPU0: patch_level=3D0x06000832
[    5.058835] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[    5.067667] AVX version of gcm_enc/dec engaged.
[    5.072230] AES CTR mode by8 optimization enabled
[    5.135491] registered taskstats version 1
[    5.139654] Loading compiled-in X.509 certificates
[    5.146658] Loaded X.509 cert 'Build time autogenerated kernel key: d3ef=
5bf4e7da8af313a5b06e1df49a7fa209fab2'
[    5.156625] zswap: loaded using pool lzo/zbud
[    5.161644]   Magic number: 0:412:12
[    5.165371] rtc_cmos 00:01: setting system clock to 2016-01-26 05:00:55 =
UTC (1453784455)
[    5.173793] hpet1: lost 10 rtc interrupts
[    5.181147] Freeing unused kernel memory: 1520K (ffffffff81d46000 - ffff=
ffff81ec2000)
[    5.188994] Write protecting the kernel read-only data: 12288k
[    5.195251] Freeing unused kernel memory: 332K (ffff8800337ad000 - ffff8=
80033800000)
[    5.206664] Freeing unused kernel memory: 644K (ffff880033b5f000 - ffff8=
80033c00000)
[    5.218808] hpet1: lost 2 rtc interrupts
[    5.223449] systemd[1]: RTC configured in localtime, applying delta of -=
300 minutes to system time.
[    5.235047] random: systemd urandom read with 15 bits of entropy availab=
le
[    5.243903] systemd[1]: systemd 222 running in system mode. (+PAM +AUDIT=
 +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    5.262122] systemd[1]: Detected architecture x86-64.
[    5.267224] systemd[1]: Running in initial RAM disk.

Welcome to Fedora 23 (Twenty Three) dracut-043-63.git20151211.fc23 (Initram=
fs)!

[    5.282695] systemd[1]: Set hostname to <amd-dinar-02.lab.bos.redhat.com=
>.
[    5.343580] clocksource: Switched to clocksource tsc
[    5.377722] hpet1: lost 5 rtc interrupts
[  OK  ] Created slice -.slice.
[    5.386658] systemd[1]: Created slice -.slice.
[    5.391161] systemd[1]: Starting -.slice.
[  OK  ] Listening on Journal Socket (/dev/log).
[    5.401645] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.407627] systemd[1]: Starting Journal Socket (/dev/log).
[  OK  ] Reached target Local File Systems.
[    5.419661] systemd[1]: Reached target Local File Systems.
[    5.425200] systemd[1]: Starting Local File Systems.
[    5.430310] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    5.438266] systemd[1]: Starting Dispatch Password Requests to Console D=
irectory Watch.
[  OK  ] Reached target Paths.
[    5.450645] systemd[1]: Reached target Paths.
[    5.455060] systemd[1]: Starting Paths.
[  OK  ] Reached target Timers.
[    5.463649] systemd[1]: Reached target Timers.
[    5.468148] systemd[1]: Starting Timers.
[  OK  ] Created slice System Slice.
[    5.476664] systemd[1]: Created slice System Slice.
[    5.481601] systemd[1]: Starting System Slice.
[  OK  ] Reached target Swap.
[    5.490642] systemd[1]: Reached target Swap.
[    5.494968] systemd[1]: Starting Swap.
[  OK  ] Reached target Slices.
[    5.503644] systemd[1]: Reached target Slices.
[    5.508144] systemd[1]: Starting Slices.
[  OK  ] Listening on Journal Audit Socket.
[    5.518660] systemd[1]: Listening on Journal Audit Socket.
[    5.524202] systemd[1]: Starting Journal Audit Socket.
[  OK  ] Listening on udev Control Socket.
[    5.535659] systemd[1]: Listening on udev Control Socket.
[    5.541112] systemd[1]: Starting udev Control Socket.
[  OK  ] Listening on Journal Socket.
[    5.552659] systemd[1]: Listening on Journal Socket.
[    5.557683] systemd[1]: Starting Journal Socket.
[    5.562607] systemd[1]: Started Load Kernel Modules.
[    5.568380] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[    5.581529] systemd[1]: Starting Create list of required static device n=
odes for the current kernel...
         Starting Create list of required st... nodes for the current kerne=
l...
[    5.602428] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[  OK  ] Listening on udev Kernel Socket.
[    5.622655] systemd[1]: Listening on udev Kernel Socket.
[    5.630555] systemd[1]: Starting udev Kernel Socket.
[    5.641620] systemd[1]: Started dracut ask for additional cmdline parame=
ters.
[    5.657538] systemd[1]: Starting dracut cmdline hook...
         Starting dracut cmdline hook...
[  OK  ] Reached target Sockets.
[    5.682657] systemd[1]: Reached target Sockets.
[    5.691558] systemd[1]: Starting Sockets.
[  OK  ] Started Apply Kernel Variables.
[    5.711662] systemd[1]: Started Apply Kernel Variables.
[    5.723640] audit: type=3D1130 audit(1453802456.057:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-sysc=
tl comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'
[  OK  ] Started Create list of required sta...ce nodes for the current ker=
nel.
[    5.792670] systemd[1]: Started Create list of required static device no=
des for the current kernel.
[    5.808578] audit: type=3D1130 audit(1453802456.142:3): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dkmod-static-=
nodes comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Started Journal Service.
[    5.853663] systemd[1]: Started Journal Service.
[    5.860628] audit: type=3D1130 audit(1453802456.194:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-jour=
nald comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
? terminal=3D? res=3Dsuccess'
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Create Static Device Nodes in /dev.
[    5.928755] audit: type=3D1130 audit(1453802456.262:5): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-tmpf=
iles-setup-dev comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
[  OK  ] Started dracut cmdline hook.
[    6.050749] audit: type=3D1130 audit(1453802456.384:6): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-cmdli=
ne comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'
         Starting dracut pre-udev hook...
[  OK  ] Started dracut pre-udev hook.
[    6.135763] audit: type=3D1130 audit(1453802456.469:7): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-pre-u=
dev comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=
 terminal=3D? res=3Dsuccess'
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
         Mounting Configuration File System...
[  OK  ] Mounted Configuration File System.
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Reached target System Initialization.
[  OK  ] Reached target Basic System.
         Starting dracut initqueue hook...
[    6.409670] FUJITSU Extended Socket Network Device Driver - version 1.0 =
- Copyright (c) 2015 FUJITSU LIMITED
[    6.500391] bnx2: QLogic bnx2 Gigabit Ethernet Driver v2.2.6 (January 29=
, 2014)
[    6.516580]  amd_iommu_dma_supported: 0000:01:00.0 ***=20
[    6.526760]  alloc_coherent: 0000:01:00.0 ***=20
[    6.536525] set_dte_entry  devid: 01:00.0, domain->id:22 ***=20
[    6.542293]  __map_single: 0000:01:00.0 ***=20
[    6.546556]  dma_addr: 1000, size=3D1000 ***=20
[    6.565085] bnx2 0000:01:00.0 eth0: Broadcom NetXtreme II BCM5709 1000Ba=
se-T (C0) PCI Express found at mem ca000000, IRQ 25, node addr 00:00:1a:1a:=
94:70
[    6.593690]  amd_iommu_dma_supported: 0000:01:00.1 ***=20
[    6.604756]  alloc_coherent: 0000:01:00.1 ***=20
[    6.614523] set_dte_entry  devid: 01:00.1, domain->id:22 ***=20
[    6.620291]  __map_single: 0000:01:00.1 ***=20
[    6.624554]  dma_addr: 2000, size=3D1000 ***=20
[    6.628745] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b3840 flags=3D0x0020]
[    6.639341] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b3880 flags=3D0x0020]
[    6.649932] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b3890 flags=3D0x0020]
[    6.662080] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b4040 flags=3D0x0020]
[    6.672711] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b4080 flags=3D0x0020]
[    6.683302] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b4090 flags=3D0x0020]
[    6.707032] bnx2 0000:01:00.1 eth1: Broadcom NetXtreme II BCM5709 1000Ba=
se-T (C0) PCI Express found at mem cc000000, IRQ 27, node addr 00:00:1a:1a:=
94:71
[    6.792201] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b5840 flags=3D0x0020]
[    6.802864] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b5880 flags=3D0x0020]
[    6.813460] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b5890 flags=3D0x0020]
[    7.076449] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b6040 flags=3D0x0020]
[    7.087091] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b6080 flags=3D0x0020]
[    7.097686] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b6090 flags=3D0x0020]
[    7.114999]  amd_iommu_dma_supported: 0000:00:14.1 ***=20
[    7.129585]  alloc_coherent: 0000:00:14.1 ***=20
[    7.137542] set_dte_entry  devid: 00:14.1, domain->id:18 ***=20
[    7.143313]  __map_single: 0000:00:14.1 ***=20
[    7.147578]  dma_addr: 1000, size=3D1000 ***=20
[    7.161367]  alloc_coherent: 0000:00:14.1 ***=20
[    7.176066]  dma_addr: 2000, size=3D1000 ***=20
[    7.192284] scsi host6: pata_atiixp
[    7.195819] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b7840 flags=3D0x0020]
[    7.206414] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b7880 flags=3D0x0020]
[    7.217004] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b7890 flags=3D0x0020]
[    7.236531] scsi host7: pata_atiixp
[    7.244270] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x2410 irq=
 14
[    7.251255] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x2418 irq=
 15
[    7.300848] [drm] Initialized drm 1.1.0 20060810
[    7.366132] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b8040 flags=3D0x0020]
[    7.376766] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b8080 flags=3D0x0020]
[    7.387357] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b8090 flags=3D0x0020]
[    7.408778] [drm] radeon kernel modesetting enabled.
[    7.425809] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b9840 flags=3D0x0020]
[    7.436404] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b9890 flags=3D0x0020]
[    7.446993] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008b9880 flags=3D0x0020]
[    7.474426] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008ba040 flags=3D0x0020]
[    7.485058] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008ba080 flags=3D0x0020]
[    7.495650] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008ba090 flags=3D0x0020]
[    7.508647] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[    7.514674] AMD IOMMUv2 functionality not available on this system
[    7.544630] CRAT table not found
[    7.547890] Finished initializing topology ret=3D0
[    7.561534] kfd kfd: Initialized module
[    7.569583] [drm] initializing kernel modesetting (RV100 0x1002:0x515E 0=
x1002:0x515E).
[    7.577486]  amd_iommu_dma_supported: 0000:02:06.0 ***=20
[    7.595533] [drm] register mmio base: 0xCE000000
[    7.600173] [drm] register mmio size: 65536
[    7.614735] radeon 0000:02:06.0: VRAM: 128M 0x00000000D0000000 - 0x00000=
000D7FFFFFF (32M used)
[    7.623328] radeon 0000:02:06.0: GTT: 512M 0x00000000B0000000 - 0x000000=
00CFFFFFFF
[    7.630892] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bb840 flags=3D0x0020]
[    7.641485] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bb880 flags=3D0x0020]
[    7.652280] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bb890 flags=3D0x0020]
[    7.662874] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bc040 flags=3D0x0020]
[    7.673464] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bc080 flags=3D0x0020]
[    7.684056] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bc090 flags=3D0x0020]
[    7.694644] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bd840 flags=3D0x0020]
[    7.705234] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bd880 flags=3D0x0020]
[    7.715824] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bd890 flags=3D0x0020]
[    7.747544] [drm] Detected VRAM RAM=3D128M, BAR=3D128M
[    7.752361] [drm] RAM width 16bits DDR
[    7.758631] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008be040 flags=3D0x0020]
[    7.769260] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008be080 flags=3D0x0020]
[    7.779910] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008be090 flags=3D0x0020]
[    7.790509] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bf840 flags=3D0x0020]
[    7.801102] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bf880 flags=3D0x0020]
[    7.811693] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008bf890 flags=3D0x0020]
[    7.835428] [TTM] Zone  kernel: Available graphics memory: 119648 kiB
[    7.841893] [TTM] Initializing pool allocator
[    7.856303] [TTM] Initializing DMA pool allocator
[    7.869570] [drm] radeon: 32M of VRAM memory ready
[    7.882651] [drm] radeon: 512M of GTT memory ready.
[    7.896876] set_dte_entry  devid: 02:06.0, domain->id:20 ***=20
[    7.902647] set_dte_entry  devid: 00:14.4, domain->id:20 ***=20
[    7.908383]  __map_single: 0000:02:06.0 ***=20
[    7.912646] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    7.939353] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c0040 flags=3D0x0020]
[    7.949987] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c0080 flags=3D0x0020]
[    7.960582] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c0090 flags=3D0x0020]
[    7.990279] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c1840 flags=3D0x0020]
[    8.000912] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c1880 flags=3D0x0020]
[    8.011504] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c1890 flags=3D0x0020]
[    8.027142]  alloc_coherent: 0000:02:06.0 ***=20
[    8.031790]  dma_addr: 80000, size=3D80000 ***=20
[    8.067684] [drm] PCI GART of 512M enabled (table at 0x0000000000080000).
[    8.109531] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c2040 flags=3D0x0020]
[    8.120161] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c2080 flags=3D0x0020]
[    8.130757] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c2090 flags=3D0x0020]
[    8.144864] radeon 0000:02:06.0: WB disabled
[    8.149170] radeon 0000:02:06.0: fence driver on ring 0 use gpu addr 0x0=
0000000b0000000 and cpu addr 0xffff8800320ef000
[    8.163335] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c3840 flags=3D0x0020]
[    8.173968] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c3880 flags=3D0x0020]
[    8.184559] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c3890 flags=3D0x0020]
[    8.219670] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    8.226305] [drm] Driver supports precise vblank timestamp query.
[    8.256309] [drm] radeon: irq initialized.
[    8.260419] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c4040 flags=3D0x0020]
[    8.271014] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c4080 flags=3D0x0020]
[    8.281605] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c4090 flags=3D0x0020]
[    8.292322] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c5840 flags=3D0x0020]
[    8.302911] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c5880 flags=3D0x0020]
[    8.313501] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c5890 flags=3D0x0020]
[    8.326440] [drm] Loading R100 Microcode
[    8.333039] [drm] radeon: ring at 0x00000000B0001000
[    8.350202] [drm] ring test succeeded in 1 usecs
[    8.419941] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c6040 flags=3D0x0020]
[    8.430572] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c6080 flags=3D0x0020]
[    8.441162] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c6090 flags=3D0x0020]
[    8.578530] bnx2 0000:01:00.0 enp1s0f0: renamed from eth0
[    8.595584] bnx2 0000:01:00.1 enp1s0f1: renamed from eth1
[    8.846040] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c7840 flags=3D0x0020]
[    8.856640] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c7880 flags=3D0x0020]
[    8.867230] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c7890 flags=3D0x0020]
[    8.878053] [drm] ib test succeeded in 0 usecs
[    8.883709] [drm] No TV DAC info found in BIOS
[    8.888618] [drm] Radeon Display Connectors
[    8.892829] [drm] Connector 0:
[    8.895878] [drm]   VGA-1
[    8.898494] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[    8.904483] [drm]   Encoders:
[    8.907444] [drm]     CRT1: INTERNAL_DAC1
[    8.911442] [drm] Connector 1:
[    8.914489] [drm]   DVI-I-1
[    8.917277] [drm]   HPD2
[    8.919803] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
[    8.925791] [drm]   Encoders:
[    8.928751] [drm]     CRT2: INTERNAL_DAC2
[    8.932750] [drm]     DFP2: INTERNAL_DVO1
[    8.988951] [drm] fb mappable at 0xD0040000
[    8.993221] [drm] vram apper at 0xD0000000
[    8.997307] [drm] size 786432
[    9.000267] [drm] fb depth is 8
[    9.003400] [drm]    pitch is 1024
[    9.006800] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c8040 flags=3D0x0020]
[    9.017396] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c8080 flags=3D0x0020]
[    9.027985] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c8090 flags=3D0x0020]
[    9.039112] fbcon: radeondrmfb (fb0) is primary device
[    9.216473] Console: switching to colour frame buffer device 128x48
[    9.249538] radeon 0000:02:06.0: fb0: radeondrmfb frame buffer device
[    9.256286] [drm] Initialized radeon 2.43.0 20080528 for 0000:02:06.0 on=
 minor 0
[    9.298102] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c9840 flags=3D0x0020]
[    9.308730] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c9880 flags=3D0x0020]
[    9.319319] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008c9890 flags=3D0x0020]
[    9.421945] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008ca040 flags=3D0x0020]
[    9.432730] hpet_rtc_timer_reinit: 11 callbacks suppressed
[    9.432731] hpet1: lost 72 rtc interrupts
[    9.442271] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008ca080 flags=3D0x0020]
[    9.452864] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008ca090 flags=3D0x0020]
[    9.463457] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cb840 flags=3D0x0020]
[    9.474045] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cb890 flags=3D0x0020]
[    9.484634] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cb880 flags=3D0x0020]
[    9.659756] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cc040 flags=3D0x0020]
[    9.670389] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cc080 flags=3D0x0020]
[    9.680979] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cc090 flags=3D0x0020]
[    9.822401] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cd840 flags=3D0x0020]
[    9.833023] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cd880 flags=3D0x0020]
[    9.843616] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cd890 flags=3D0x0020]
[    9.881146] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008ce040 flags=3D0x0020]
[    9.891821] hpet1: lost 29 rtc interrupts
[    9.891919] random: nonblocking pool is initialized
[    9.900782] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008ce080 flags=3D0x0020]
[    9.911372] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008ce090 flags=3D0x0020]
[    9.921966] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cf840 flags=3D0x0020]
[    9.932555] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cf880 flags=3D0x0020]
[    9.943145] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008cf890 flags=3D0x0020]
[    9.994188] hpet1: lost 5 rtc interrupts
[  OK  ] Found device /dev/mapper/fedora_amd--dinar--02-root.
[   10.078006] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d0040 flags=3D0x0020]
[   10.088632] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d0080 flags=3D0x0020]
[   10.099225] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d0090 flags=3D0x0020]
[   10.184662] hpet1: lost 10 rtc interrupts
[  OK  ] Started dracut initqueue hook.
[   10.196237] audit: type=3D1130 audit(1453802460.529:10): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-init=
queue comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
[   10.221341] hpet1: lost 1 rtc interrupts
         Starting File System Check on /dev/...er/fedora_amd--dinar--02-roo=
t...
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[   10.352439] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d1840 flags=3D0x0020]
[   10.363039] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d1880 flags=3D0x0020]
[   10.373629] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d1890 flags=3D0x0020]
[   10.423998] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d2040 flags=3D0x0020]
[   10.434605] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d2080 flags=3D0x0020]
[   10.445194] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d2090 flags=3D0x0020]
[   10.546938] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d3840 flags=3D0x0020]
[   10.557567] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d3880 flags=3D0x0020]
[   10.568158] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d3890 flags=3D0x0020]
[   10.627953] hpet1: lost 25 rtc interrupts
[  OK  ] Started File System Check on /dev/mapper/fedora_amd--dinar--02-roo=
t.
[   10.644761] audit: type=3D1130 audit(1453802460.978:11): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-fsc=
k-root comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
         Mounting /sysroot...
[   10.699380] EXT4-fs (dm-0): mounted filesystem with ordered data mode. O=
pts: (null)
[  OK  ] Mounted /sysroot.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[   10.770064] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d4040 flags=3D0x0020]
[   10.780755] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d4080 flags=3D0x0020]
[   10.791437] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d4090 flags=3D0x0020]
[   10.879871] AMD-Vi: Event logged [[   10.883152] hpet1: lost 5 rtc inter=
rupts

[   10.887144] IO_PAGE_FAULT device=3D01:00.0 domain=3D0x0016 address=3D0x0=
0000000008d5840 flags=3D0x0020]
[   10.896002] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d5880 flags=3D0x0020]
[   10.906592] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d5890 flags=3D0x0020]
[   10.917184] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d6040 flags=3D0x0020]
[   10.927772] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d6080 flags=3D0x0020]
[   10.938370] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d6090 flags=3D0x0020]
[   10.973262] hpet1: lost 5 rtc interrupts
[  OK  ] Started Reload Configuration from the Real Root.
[  OK  ] Reached target Initrd File Systems.
[  OK  ] Reached target Initrd Default Target.
         Starting dracut pre-pivot and cleanup hook...
[   11.025123] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d7840 flags=3D0x0020]
[   11.035756] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d7880 flags=3D0x0020]
[   11.046345] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d7890 flags=3D0x0020]
[  OK  ] Started dracut pre-pivot and cleanup hook.
         Starting Kdump Vmcore Save Service...
[   10.250205] kdump.sh[492]: /bin/kdump.sh: line 8: /dev/console: Input/ou=
tput error
[FAILED] Failed to start Kdump Vmcore Save Service.
See 'systemctl status kdump-capture.service' for details.
[  OK  ] Stopped Cleani[   11.306903] AMD-Vi: Event logged [ng Up and Shutt=
iIO_PAGE_FAULT device=3D01:00.0 domain=3D0x0016 address=3D0x00000000008d804=
0 flags=3D0x0020]
ng Down Daemons.[   11.319806] AMD-Vi: Event logged [
IO_PAGE_FAULT device=3D01:00.0 domain=3D0x0016 address=3D0x00000000008d8080=
 flags=3D0x0020]
[   11.331987] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d8090 flags=3D0x0020]
[   11.342584] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d9840 flags=3D0x0020]
[   11.353173] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d9880 flags=3D0x0020]
[   11.363761] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008d9890 flags=3D0x0020]
[  OK  ] Stopped target Timers.
[  OK  ] Stopped dracut pre-pivot and cleanup hook.
         Stopping dracut pre-pivot and cleanup hook...
[  OK  ] Stopped File System Check on /dev/mapper/fedora_amd--dinar--02-roo=
t.
         Stopping File System Check on /dev/...er/fedora_amd--dinar--02-roo=
t...
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Initrd Root File System.
[   11.425961] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008da040 flags=3D0x0020]
[   11.436602] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008da080 flags=3D0x0020]
[   11.447192] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008da090 flags=3D0x0020]
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Slices.
[  OK  ] Stopped target Initrd File Systems.
[  OK  ] Stopped target Sockets.
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped target Remote File Systems (Pre).
[  OK  ] Stopped dracut initqueue hook.
         Stopping dracut initqueue hook...
[  OK  ] Stopped target Paths.
[  OK  ] Stopped target System Initialization.
[   11.523383] systemd[1]: Stopping Journal Service...
[   11.528735] systemd-journald[164]: Received SIGTERM from PID 1 (systemd).
         Stopping Journal Service...
[  OK  ] Stopped Apply Kernel Variables.
[   11.546772] systemd[1]: Stopped Apply Kernel Variables.
[   11.552141] systemd[1]: Stopping Apply Kernel Variables...
         Stopping Apply Kernel Variables...
[  OK  ] Stopped target Local File Systems.
[   11.568674] systemd[1]: Stopped target Local File Systems.
[   11.574213] systemd[1]: Stopping Local File Systems.
[  OK  ] Stopped udev Coldplug all Devices.
[   11.585739] systemd[1]: Stopped udev Coldplug all Devices.
[   11.591364] systemd[1]: Stopping udev Coldplug all Devices...
         Stopping udev Coldplug all Devices...
[  OK  ] Stopped target Swap.
[   11.606690] systemd[1]: Stopped target Swap.
[   11.611017] systemd[1]: Stopping Swap.
[   11.615673] systemd[1]: Starting Kdump Emergency...
         Starting Kdump E[   11.625708] systemd[1]: Stopping udev Kernel De=
vice Manager...
mergency...
         Stoppin[   11.635469] systemd[1]: Starting Setup Virtual Console...
g udev Kernel Device Manager...
         Startin[   11.646426] systemd[1]: Stopped Journal Service.
g Setup Virtual Console...
[  OK  ] Stopped Journal Service.
[  OK  [   11.677310] systemd[1]: Stopped udev Kernel Device Manager.
] Stopped udev Kernel Device Manager.
[  OK  ] Stopped Kdump Emergency.
[   11.700698] systemd[1]: Stopped Kdump Emergency.
[  OK  ] Listening on Journal Audit Socket.
[   11.717675] systemd[1]: Listening on Journal Audit Socket.
[   11.731116] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[  OK  ] Stopped target Emergency Mode.
[   11.756683] systemd[1]: Stopped target Emergency Mode.
[  OK  ] Stopped dracut pre-udev hook.
[   11.772670] systemd[1]: Stopped dracut pre-udev hook.
[   11.782821] systemd[1]: Stopping dracut pre-udev hook...
         Stopping dracut pre-udev hook...
[  OK  ] Stopped dracut cmdline hook.
[   11.802668] systemd[1]: Stopped dracut cmdline hook.
[   11.812791] systemd[1]: Stopping dracut cmdline hook...
         Stopping dracut cmdline hook...
[  OK  ] Stopped Create Static Device Nodes in /dev.
[   11.834668] systemd[1]: Stopped Create Static Device Nodes in /dev.
[   11.845800] systemd[1]: Stopping Create Static Device Nodes in /dev...
         Stopping Create Static Device Nodes in /dev...
[  OK  ] Stopped Create list of required sta...ce nodes for the current ker=
nel.
[   11.873668] systemd[1]: Stopped Create list of required static device no=
des for the current kernel.
[   11.882705] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008db840 flags=3D0x0020]
[   11.893300] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008db880 flags=3D0x0020]
[   11.903893] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008db890 flags=3D0x0020]
[   11.914481] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008dc040 flags=3D0x0020]
[   11.925072] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008dc080 flags=3D0x0020]
[   11.935668] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008dc090 flags=3D0x0020]
[   11.953792] systemd[1]: Stopping Create list of required static device n=
odes for the current kernel...
[   11.963118] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008dd840 flags=3D0x0020]
[   11.973710] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008dd880 flags=3D0x0020]
[   11.984301] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008dd890 flags=3D0x0020]
         Stopping Create list of required st... nodes for the current kerne=
l...
[  OK  ] Closed udev Control Socket.
[   12.017667] systemd[1]: Closed udev Control Socket.
[   12.027548] systemd[1]: Stopping udev Control Socket.
[  OK  ] Closed udev Kernel Socket.
[   12.042667] systemd[1]: Closed udev Kernel Socket.
[   12.051548] systemd[1]: Stopping udev Kernel Socket.
[  OK  ] Started Journal Service.
[   12.066669] systemd[1]: Started Journal Service.
[   12.091857] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008de040 flags=3D0x0020]
[   12.102484] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008de080 flags=3D0x0020]
[   12.113073] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008de090 flags=3D0x0020]
[  OK  ] Started Setup Virtual Console.
         Starting Kdump Error Handler...
Kdump: Executing default action reboot
         Unmounting /sysroot...
[  OK  ] Removed slice -.slice.
[  OK  ] Stopped Setup Virtual Console.
         Stopping Setup Virtual Console...
[  OK  ] Reached target Shutdown.
[  OK  ] Unmounted /sysroot.
[  OK  ] Reached target Unmount All Filesystems.
[  OK  ] Reached target Final Step.
         Starting Reboot...
Warning! D-Bus c[   12.276375] systemd-shutdown[1]: Sending SIGTERM to rema=
ining processes...
[   12.289133] systemd-journald[505]: Received SIGTERM from PID 1 (systemd-=
shutdow).
[   12.297637] systemd-shutdown[1]: Sending SIGKILL to remaining processes.=
=2E.
[   12.309608] systemd-shutdown[1]: Unmounting file systems.
[   12.315046] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008df840 flags=3D0x0020]
[   12.325637] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008df880 flags=3D0x0020]
[   12.336226] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008df890 flags=3D0x0020]
[   12.347111] systemd-shutdown[1]: All filesystems unmounted.
[   12.352717] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008e0040 flags=3D0x0020]
[   12.363311] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008e0080 flags=3D0x0020]
[   12.373902] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008e0090 flags=3D0x0020]
[   12.384514] systemd-shutdown[1]: Deactivating swaps.
[   12.389564] systemd-shutdown[1]: All swaps deactivated.
[   12.394829] systemd-shutdown[1]: Detaching loop devices.
[   12.400298] systemd-shutdown[1]: All loop devices detached.
[   12.405909] systemd-shutdown[1]: Detaching DM devices.
[   12.411830] systemd-shutdown[1]: Detaching DM 253:1.
[   12.422658] systemd-shutdown[1]: Detaching DM 253:0.
[   12.427994] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008e1840 flags=3D0x0020]
[   12.438599] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008e1880 flags=3D0x0020]
[   12.449187] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D01:00.0 domain=
=3D0x0016 address=3D0x00000000008e1890 flags=3D0x0020]
[   12.462646] systemd-shutdown[1]: All DM devices detached.
[   12.468594] systemd-shutdown[1]: Rebooting.
[   12.473269] sd 3:0:0:0: [sda] Synchronizing SCSI cache
[   12.479304] pci 0000:00:00.2: can't derive routing for PCI INT A
[   12.485331] pci 0000:00:00.2: PCI INT A: no GSI
[   12.489945] reboot: Restarting system
[   12.493598] reboot: machine restart

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-tv.log"

-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] RD890 Northbridge only dual slot (2x16) PCI-e GFX Hydra part
           +-00.2  Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory Management Unit (IOMMU)
           +-04.0-[01]--+-00.0  Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet
           |            \-00.1  Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet
           +-11.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode]
           +-12.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
           +-12.1  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller
           +-12.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
           +-13.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
           +-13.1  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller
           +-13.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
           +-14.0  Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller
           +-14.1  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 IDE Controller
           +-14.3  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller
           +-14.4-[02]----06.0  Advanced Micro Devices, Inc. [AMD/ATI] ES1000
           +-14.5  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
           +-18.0  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
           +-18.1  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
           +-18.2  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
           +-18.3  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
           +-18.4  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
           +-18.5  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
           +-19.0  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
           +-19.1  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
           +-19.2  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
           +-19.3  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
           +-19.4  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
           +-19.5  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
           +-1a.0  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
           +-1a.1  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
           +-1a.2  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
           +-1a.3  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
           +-1a.4  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
           +-1a.5  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
           +-1b.0  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
           +-1b.1  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
           +-1b.2  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
           +-1b.3  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
           +-1b.4  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
           \-1b.5  Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-vvv.log"

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 Northbridge only dual slot (2x16) PCI-e GFX Hydra part (rev 02)
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] RD890 Northbridge only dual slot (2x16) PCI-e GFX Hydra part
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Capabilities: [f0] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [c4] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=20 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b+
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency 0: [e]
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [40] HyperTransport: Retry Mode
	Capabilities: [54] HyperTransport: UnitID Clumping
	Capabilities: [9c] HyperTransport: #1a
	Capabilities: [70] MSI: Enable- Count=1/4 Maskable- 64bit-
		Address: 00000000  Data: 0000

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory Management Unit (IOMMU)
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory Management Unit (IOMMU)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 24
	Capabilities: [40] Secure device <?>
	Capabilities: [54] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee20000  Data: 4041
	Capabilities: [64] HyperTransport: MSI Mapping Enable+ Fixed+

00:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (PCI express gpp port D) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 26
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ca000000-cdffffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <1us, L1 <8us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #4, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00000  Data: 0000
	Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 5a10
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [190 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (prog-if 01 [AHCI 1.0])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at 2430 [size=8]
	Region 1: I/O ports at 2424 [size=4]
	Region 2: I/O ports at 2428 [size=8]
	Region 3: I/O ports at 2420 [size=4]
	Region 4: I/O ports at 2400 [size=16]
	Region 5: Memory at c8014000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] SATA HBA v1.0 InCfgSpace
	Kernel driver in use: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at c8015000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:12.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at c8016000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at c8014400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci-pci

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at c8017000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:13.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at c8018000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at c8014800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci-pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller (rev 3d)
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco

00:14.1 IDE interface: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 IDE Controller (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 IDE Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at 2410 [size=16]
	Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: pata_atiixp
	Kernel modules: pata_atiixp, pata_acpi, ata_generic

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: ce000000-ce0fffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at c8019000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b+
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: [e]
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [e0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: amd64_edac
	Kernel modules: amd64_edac_mod

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: fam15h_power
	Kernel modules: fam15h_power

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:19.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [e0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-

00:19.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:19.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: amd64_edac
	Kernel modules: amd64_edac_mod

00:19.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:19.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel modules: fam15h_power

00:19.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:1a.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [e0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=N/C DwFcInEn- LWO=N/C DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 200MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-

00:1a.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:1a.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: amd64_edac
	Kernel modules: amd64_edac_mod

00:1a.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:1a.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [e0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=N/C DwFcInEn- LWO=N/C DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 200MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Kernel driver in use: fam15h_power
	Kernel modules: fam15h_power

00:1a.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:1b.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-
	Capabilities: [e0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 500MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-

00:1b.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:1b.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: amd64_edac
	Kernel modules: amd64_edac_mod

00:1b.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:1b.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel modules: fam15h_power

00:1b.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet (rev 20)
	Subsystem: Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at ca000000 (64-bit, non-prefetchable) [size=32M]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: Broadcom NetXtreme II Ethernet Controller
		Read-only fields:
			[PN] Part number: BCM95706A0
			[EC] Engineering changes: 220197-2
			[SN] Serial number: 0123456789
			[MN] Manufacture ID: 31 34 65 34
			[RV] Reserved: checksum good, 30 byte(s) reserved
		End
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable+ Count=9 Masked-
		Vector table: BAR=0 offset=0000c000
		PBA: BAR=0 offset=0000e000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <2us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Device Serial Number 00-00-1a-ff-fe-1a-94-70
	Capabilities: [110 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Kernel driver in use: bnx2
	Kernel modules: bnx2

01:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet (rev 20)
	Subsystem: Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 0
	Region 0: Memory at cc000000 (64-bit, non-prefetchable) [size=32M]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: Broadcom NetXtreme II Ethernet Controller
		Read-only fields:
			[PN] Part number: BCM95706A0
			[EC] Engineering changes: 220197-2
			[SN] Serial number: 0123456789
			[MN] Manufacture ID: 31 34 65 34
			[RV] Reserved: checksum good, 30 byte(s) reserved
		End
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable+ Count=9 Masked-
		Vector table: BAR=0 offset=0000c000
		PBA: BAR=0 offset=0000e000
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <2us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Device Serial Number 00-00-1a-ff-fe-1a-94-71
	Capabilities: [110 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Kernel driver in use: bnx2
	Kernel modules: bnx2

02:06.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] ES1000 (rev 02) (prog-if 00 [VGA controller])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] ES1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+ DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 66 (2000ns min), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at ce000000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at ce020000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: radeon
	Kernel modules: radeon


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--4Ckj6UjgE2iN1+kY--
