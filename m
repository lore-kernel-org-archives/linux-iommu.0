From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v4 0/9] *** Fix kdump failure in system with amd iommu***
Date: Wed, 25 May 2016 15:02:03 +0800
Message-ID: <20160525070203.GA3198@x1.redhat.com>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464157735-8865-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: vincent.wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joerg,

Attachments are console log of normal kernel and kdump kernel on a test
machine at my hand, and the related information of lspci -vt and lspci
-vvv. Before I tried to defer the calling of set_dte_entry() until the
device driver try to call __map_single() to really allocate coherent
memory or do the mapping, seems it didn't work. I am surprised by the
simplicity and effectiveness of Intel IOMMU fix, but can't think of
where I have missed. 





--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-vt.log"

-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Root Complex
           +-00.2  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) I/O Memory Management Unit
           +-01.0  Advanced Micro Devices, Inc. [AMD/ATI] Kaveri [Radeon R7 Graphics]
           +-01.1  Advanced Micro Devices, Inc. [AMD/ATI] Kaveri HDMI/DP Audio Controller
           +-02.0  Advanced Micro Devices, Inc. [AMD] Device 1424
           +-03.0  Advanced Micro Devices, Inc. [AMD] Device 1424
           +-03.1-[01]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
           +-04.0  Advanced Micro Devices, Inc. [AMD] Device 1424
           +-10.0  Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller
           +-10.1  Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller
           +-11.0  Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [IDE mode]
           +-12.0  Advanced Micro Devices, Inc. [AMD] FCH USB OHCI Controller
           +-12.2  Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller
           +-13.0  Advanced Micro Devices, Inc. [AMD] FCH USB OHCI Controller
           +-13.2  Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller
           +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
           +-14.1  Advanced Micro Devices, Inc. [AMD] FCH IDE Controller
           +-14.2  Advanced Micro Devices, Inc. [AMD] FCH Azalia Controller
           +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
           +-14.4-[02]--
           +-14.5  Advanced Micro Devices, Inc. [AMD] FCH USB OHCI Controller
           +-18.0  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 0
           +-18.1  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 1
           +-18.2  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 2
           +-18.3  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 3
           +-18.4  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 4
           \-18.5  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 5

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-vvv.log"


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amd_iommu.log"

[    0.000000] Linux version 4.6.0-rc7+ (bhe-sa4SJRhfYT7yzlqKoElxGh/sF2h8X+2i0E9HWUfgJXw@public.gmane.org) (gcc version 5.1.1 20150618 (Red Hat 5.1.1-4) (GCC) ) #34 SMP Tue May 24 17:6
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.6.0-rc7+ root=/dev/mapper/fedora_dhcp--129--10-root ro rd.lvm.lv=fedora_dhcp-129-10/root rd.lvm.lvl
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007cc99fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007cc9a000-0x000000007ccc9fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ccca000-0x000000007cf9ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007cfa0000-0x000000007d06dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007d06e000-0x000000007e1c7fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007e1c8000-0x000000007e1c8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007e1c9000-0x000000007e3cefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007e3cf000-0x000000007e850fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007e851000-0x000000007efe1fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007efe2000-0x000000007effffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] e820: last_pfn = 0x23f000 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: last_pfn = 0x7f000 max_arch_pfn = 0x400000000
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000fd6f0-0x000fd6ff] mapped at [ffff8800000fd6f0]
[    0.000000]   mpc: fd430-fd66c
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x35663000-0x36b29fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000007D024080 000084 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000007D02A598 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20160108/tbfadt-654)
[    0.000000] ACPI: DSDT 0x000000007D0241A0 0063F2 (v02 ALASKA A M I    00000088 INTL 20051117)
[    0.000000] ACPI: FACS 0x000000007D063080 000040
[    0.000000] ACPI: APIC 0x000000007D02A6A8 00007E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000007D02A728 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000007D02A770 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x000000007D02A7B0 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: WDRT 0x000000007D02A7E8 000047 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: IVRS 0x000000007D02A830 000078 (v02 AMD    BANTRY   00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x000000007D02A8A8 000B9C (v01 AMD    BANTRY   00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000007D02B448 00033B (v02 AMD    BANTRY   00000002 MSFT 04000000)
[    0.000000] ACPI: CRAT 0x000000007D02B788 000550 (v01 AMD    BANTRY   00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000007D02BCD8 001457 (v01 AMD    CPMDFIGP 00000001 INTL 20051117)
[    0.000000] ACPI: SSDT 0x000000007D02D130 00122C (v01 AMD    CPMCMN   00000001 INTL 20051117)
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000023effffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x23efe9000-0x23effafff]
[    0.000000] Reserving 256MB of memory at 592MB for crashkernel (System RAM: 7107MB)
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000023effffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007cc99fff]
[    0.000000]   node   0: [mem 0x000000007ccca000-0x000000007cf9ffff]
[    0.000000]   node   0: [mem 0x000000007e1c8000-0x000000007e1c8fff]
[    0.000000]   node   0: [mem 0x000000007e3cf000-0x000000007e850fff]
[    0.000000]   node   0: [mem 0x000000007efe2000-0x000000007effffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000023effffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000023effffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 1, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.000000] mapped IOAPIC to ffffffffff5fa000 (fec01000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7cc9a000-0x7ccc9fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7cfa0000-0x7d06dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x7d06e000-0x7e1c7fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7e1c9000-0x7e3cefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7e851000-0x7efe1fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7f000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec01fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec02000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed3ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed40000-0xfed44fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed45000-0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0x7f000000-0xfebfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 34 pages/cpu @ffff88023ec00000 s98776 r8192 d32296 u524288
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1791113
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.6.0-rc7+ root=/dev/mapper/fedora_dhcp--129--10-root ro rd.lvm.lv=fedora_dhcp-129-10/root rdl
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 6796480K/7278268K available (7903K kernel code, 1294K rwdata, 3188K rodata, 1536K init, 1468K bss, 481788K reserved, 0K cma-re)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:4352 nr_irqs:1000 16
[    0.000000]  Offload RCU callbacks from all CPUs
[    0.000000]  Offload RCU callbacks from CPUs: 0-3.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3693.324 MHz processor
[    0.000023] Calibrating delay loop (skipped), value calculated using timer frequency.. 7386.64 BogoMIPS (lpj=3693324)
[    0.010821] pid_max: default: 32768 minimum: 301
[    0.015544] ACPI: Core revision 20160108
[    0.023313] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.031540] 
[    0.033151] Security Framework initialized
[    0.037344] Yama: becoming mindful.
[    0.040935] SELinux:  Initializing.
[    0.045029] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.054691] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.062900] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.069919] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.077629] CPU: Physical Processor ID: 0
[    0.081792] CPU: Processor Core ID: 0
[    0.085557] mce: CPU supports 7 MCE banks
[    0.089671] LVT offset 1 assigned for vector 0xf9
[    0.094460] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.100463] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.107427] Freeing SMP alternatives memory: 32K (ffffffff81ec5000 - ffffffff81ecd000)
[    0.117817] ftrace: allocating 29742 entries in 117 pages
[    0.132879] smpboot: Max logical packages: 2
[    0.137287] smpboot: APIC(10) Converting physical 1 to logical package 0
[    0.144611] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b8 info 0000
[    0.151442] AMD-Vi:        mmio-addr: 00000000feb80000
[    0.156689] AMD-Vi:   DEV_SELECT_RANGE_START  devid: 00:01.0 flags: 00
[    0.163316] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.6
[    0.168875] AMD-Vi:   DEV_ALIAS_RANGE                 devid: 02:00.0 flags: 00 devid_to: 00:14.4
[    0.176602] AMD-Vi:   DEV_RANGE_END           devid: 02:1f.7
[    0.181674] AMD-Vi:   DEV_SPECIAL(HPET[0])           devid: 00:14.0
[    0.187259] AMD-Vi:   DEV_SPECIAL(IOAPIC[0])         devid: 00:14.0
[    0.193014] AMD-Vi:   DEV_SPECIAL(IOAPIC[1])         devid: 00:00.0
[    0.275798] enabled ExtINT on CPU#0
[    0.279622] ENABLING IO-APIC IRQs
[    0.283285] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.299386] Using local APIC timer interrupts.
[    0.299386] calibrating APIC timer ...
[    0.409172] ... lapic delta = 623858
[    0.412858] ... PM-Timer delta = 357951
[    0.416787] ... PM-Timer result ok
[    0.420283] ..... delta 623858
[    0.423447] ..... mult: 26794497
[    0.426772] ..... calibration result: 99817
[    0.431054] ..... CPU clock speed is 3693.0244 MHz.
[    0.436029] ..... host bus clock speed is 99.0817 MHz.
[    0.441270] smpboot: CPU0: AMD A10-7850K Radeon R7, 12 Compute Cores 4C+8G (family: 0x15, model: 0x30, stepping: 0x1)
[    0.452198] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.458779] ... version:                0
[    0.462888] ... bit width:              48
[    0.467081] ... generic registers:      6
[    0.471191] ... value mask:             0000ffffffffffff
[    0.476599] ... max period:             00007fffffffffff
[    0.482005] ... fixed-purpose events:   0
[    0.486113] ... event mask:             000000000000003f
[    0.492136] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.500444] x86: Booting SMP configuration:
[    0.504723] .... node  #0, CPUs:      #1
[    0.508790] masked ExtINT on CPU#1
[    0.574481]  #2
[    0.576243] masked ExtINT on CPU#2
[    0.641428]  #3
[    0.643156] masked ExtINT on CPU#3
[    0.708351] x86: Booted up 1 node, 4 CPUs
[    0.712534] smpboot: Total of 4 processors activated (29540.57 BogoMIPS)
[    0.720256] devtmpfs: initialized
[    0.723759] x86/mm: Memory block size: 128MB
[    0.730410] PM: Registering ACPI NVS region [mem 0x7cfa0000-0x7d06dfff] (843776 bytes)
[    0.738534] PM: Registering ACPI NVS region [mem 0x7e1c9000-0x7e3cefff] (2121728 bytes)
[    0.746765] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.756697] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.763775] pinctrl core: initialized pinctrl subsystem
[    0.769136] RTC time:  6:50:29, date: 05/25/16
[    0.773850] NET: Registered protocol family 16
[    0.781365] cpuidle: using governor menu
[    0.785628] ACPI: bus type PCI registered
[    0.789742] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.796397] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.805829] PCI: not using MMCONFIG
[    0.809413] PCI: Using configuration type 1 for base access
[    0.815079] PCI: Using configuration type 1 for extended access
[    0.825565] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.832027] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.838839] ACPI: Added _OSI(Module Device)
[    0.843152] ACPI: Added _OSI(Processor Device)
[    0.847700] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.852503] ACPI: Added _OSI(Processor Aggregator Device)
[    0.858385] ACPI: Executed 1 blocks of module-level executable AML code
[    0.868360] ACPI: Interpreter enabled
[    0.872182] ACPI: (supports S0 S3 S4 S5)
[    0.876206] ACPI: Using IOAPIC for interrupt routing
[    0.881388] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.890849] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.899688] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.909340] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    0.917422] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    0.925505] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    0.937814] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.944096] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.952567] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.960966] PCI host bridge to bus 0000:00
[    0.965161] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.972041] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.978923] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.985801] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.992685] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.000297] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    1.007898] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
[    1.015506] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.021797] pci 0000:00:03.1: System wakeup disabled by ACPI
[    1.027860] pci 0000:00:10.0: System wakeup disabled by ACPI
[    1.033790] pci 0000:00:10.1: System wakeup disabled by ACPI
[    1.039653] pci 0000:00:11.0: set SATA to AHCI mode
[    1.044791] pci 0000:00:12.0: System wakeup disabled by ACPI
[    1.050686] pci 0000:00:12.2: System wakeup disabled by ACPI
[    1.056557] pci 0000:00:13.0: System wakeup disabled by ACPI
[    1.062457] pci 0000:00:13.2: System wakeup disabled by ACPI
[    1.068438] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    1.075667] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.082289] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    1.089517] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.096328] pci 0000:00:14.2: System wakeup disabled by ACPI
[    1.102357] pci 0000:00:14.4: System wakeup disabled by ACPI
[    1.108247] pci 0000:00:14.5: System wakeup disabled by ACPI
[    1.116260] pci 0000:00:03.1: PCI bridge to [bus 01]
[    1.121414] pci 0000:00:14.4: PCI bridge to [bus 02] (subtractive decode)
[    1.128790] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    1.135993] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    1.143204] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    1.150430] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    1.157608] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    1.164803] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    1.171979] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    1.179171] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    1.186593] vgaarb: setting as boot device: PCI:0000:00:01.0
[    1.192362] vgaarb: device added: PCI:0000:00:01.0,decodes=io+mem,owns=io+mem,locks=none
[    1.200589] vgaarb: loaded
[    1.203396] vgaarb: bridge control possible 0000:00:01.0
[    1.208883] SCSI subsystem initialized
[    1.212898] ACPI: bus type USB registered
[    1.217049] usbcore: registered new interface driver usbfs
[    1.222640] usbcore: registered new interface driver hub
[    1.228067] usbcore: registered new device driver usb
[    1.233373] PCI: Using ACPI for IRQ routing
[    1.244487] NetLabel: Initializing
[    1.247994] NetLabel:  domain hash size = 128
[    1.252446] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.257519] NetLabel:  unlabeled traffic allowed by default
[    1.263378] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.268540] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    1.277520] clocksource: Switched to clocksource hpet
[    1.289710] VFS: Disk quotas dquot_6.6.0
[    1.293759] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.300848] pnp: PnP ACPI init
[    1.304124] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    1.310920] system 00:01: [mem 0x80000000-0xbfffffff] has been reserved
[    1.317720] system 00:02: [mem 0xfeb80000-0xfebfffff] could not be reserved
[    1.324927] system 00:03: [io  0x0220-0x0227] has been reserved
[    1.330971] system 00:03: [io  0x0228-0x0237] has been reserved
[    1.336984] system 00:03: [io  0x0a20-0x0a2f] has been reserved
[    1.343467] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    1.349734] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    1.355757] system 00:08: [io  0x040b] has been reserved
[    1.361165] system 00:08: [io  0x04d6] has been reserved
[    1.366554] system 00:08: [io  0x0c00-0x0c01] has been reserved
[    1.372550] system 00:08: [io  0x0c14] has been reserved
[    1.377959] system 00:08: [io  0x0c50-0x0c51] has been reserved
[    1.383974] system 00:08: [io  0x0c52] has been reserved
[    1.389382] system 00:08: [io  0x0c6c] has been reserved
[    1.396453] system 00:08: [io  0x0c6f] has been reserved
[    1.401860] system 00:08: [io  0x0cd0-0x0cd1] has been reserved
[    1.407877] system 00:08: [io  0x0cd2-0x0cd3] has been reserved
[    1.413892] system 00:08: [io  0x0cd4-0x0cd5] has been reserved
[    1.419907] system 00:08: [io  0x0cd6-0x0cd7] has been reserved
[    1.425921] system 00:08: [io  0x0cd8-0x0cdf] has been reserved
[    1.431936] system 00:08: [io  0x0800-0x089f] could not be reserved
[    1.438307] system 00:08: [io  0x0b20-0x0b3f] has been reserved
[    1.444320] system 00:08: [io  0x0900-0x090f] has been reserved
[    1.450334] system 00:08: [io  0x0910-0x091f] has been reserved
[    1.456349] system 00:08: [io  0xfe00-0xfefe] has been reserved
[    1.462365] system 00:08: [mem 0xfec00000-0xfec00fff] could not be reserved
[    1.469418] system 00:08: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.476126] system 00:08: [mem 0xfed80000-0xfed8ffff] has been reserved
[    1.482851] system 00:08: [mem 0xfed61000-0xfed70fff] has been reserved
[    1.489543] system 00:08: [mem 0xfec10000-0xfec10fff] has been reserved
[    1.496251] system 00:08: [mem 0xfed00000-0xfed00fff] could not be reserved
[    1.503305] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    1.510150] pnp: PnP ACPI: found 9 devices
[    1.520896] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.529909] pci 0000:00:03.1: PCI bridge to [bus 01]
[    1.534974] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    1.541162] pci 0000:00:03.1:   bridge window [mem 0xfea00000-0xfeafffff]
[    1.548041] pci 0000:00:03.1:   bridge window [mem 0xd0800000-0xd08fffff 64bit pref]
[    1.555916] pci 0000:00:14.4: PCI bridge to [bus 02]
[    1.561039] NET: Registered protocol family 2
[    1.565702] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    1.573245] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.580227] TCP: Hash tables configured (established 65536 bind 65536)
[    1.586885] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.593107] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.599817] NET: Registered protocol family 1
[    1.604317] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.851961] Unpacking initramfs...
[    2.172878] Freeing initrd memory: 21276K (ffff880035663000 - ffff880036b2a000)
[    2.180474] AMD-Vi: IOMMU performance counters supported
[    2.185907] AMD-Vi: Applying ATS write check workaround for IOMMU at 0000:00:00.2
[    2.193663] pci 0000:00:00.2: can't derive routing for PCI INT A
[    2.199808] pci 0000:00:00.2: PCI INT A: not connected
[    2.205899] iommu: Adding device 0000:00:00.0 to group 0
[    2.211798] iommu: Adding device 0000:00:01.0 to group 1
[    2.217231] iommu: Using direct mapping for device 0000:00:01.0
[    2.223272] iommu: Adding device 0000:00:01.1 to group 1
[    2.228957] iommu: Adding device 0000:00:02.0 to group 2
[    2.234834] iommu: Adding device 0000:00:03.0 to group 3
[    2.240332] iommu: Adding device 0000:00:03.1 to group 3
[    2.246078] iommu: Adding device 0000:00:04.0 to group 4
[    2.251895] iommu: Adding device 0000:00:10.0 to group 5
[    2.257391] iommu: Adding device 0000:00:10.1 to group 5
[    2.263130] iommu: Adding device 0000:00:11.0 to group 6
[    2.268938] iommu: Adding device 0000:00:12.0 to group 7
[    2.274434] iommu: Adding device 0000:00:12.2 to group 7
[    2.280186] iommu: Adding device 0000:00:13.0 to group 8
[    2.285680] iommu: Adding device 0000:00:13.2 to group 8
[    2.291430] iommu: Adding device 0000:00:14.0 to group 9
[    2.296930] iommu: Adding device 0000:00:14.1 to group 9
[    2.302364] iommu: Adding device 0000:00:14.2 to group 9
[    2.307794] iommu: Adding device 0000:00:14.3 to group 9
[    2.313599] iommu: Adding device 0000:00:14.4 to group 10
[    2.319429] iommu: Adding device 0000:00:14.5 to group 11
[    2.325342] iommu: Adding device 0000:00:18.0 to group 12
[    2.330926] iommu: Adding device 0000:00:18.1 to group 12
[    2.336447] iommu: Adding device 0000:00:18.2 to group 12
[    2.341965] iommu: Adding device 0000:00:18.3 to group 12
[    2.347487] iommu: Adding device 0000:00:18.4 to group 12
[    2.353009] iommu: Adding device 0000:00:18.5 to group 12
[    2.358524] iommu: Adding device 0000:01:00.0 to group 3
[    2.363950] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    2.369377] AMD-Vi:  Extended features:  PPR GT IA PC
[    2.374769] AMD-Vi: Interrupt remapping enabled
[    2.379725] AMD-Vi: Lazy IO/TLB flushing enabled
[    2.386298] perf: AMD NB counters detected
[    2.390685] LVT offset 0 assigned for vector 0x400
[    2.395690] perf: AMD IBS detected (0x000001ff)
[    2.400337] perf: amd_iommu: Detected. (2 banks, 4 counters/bank)
[    2.407469] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    2.413821] audit: initializing netlink subsys (disabled)
[    2.419352] audit: type=2000 audit(1464159028.886:1): initialized
[    2.425866] Initialise system trusted keyring
[    2.430634] workingset: timestamp_bits=35 max_order=21 bucket_order=0
[    2.438887] zbud: loaded
[    2.442076] Key type big_key registered
[    2.489616] NET: Registered protocol family 38
[    2.494195] Key type asymmetric registered
[    2.498408] Asymmetric key parser 'x509' registered
[    2.503455] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    2.511095] io scheduler noop registered
[    2.515133] io scheduler deadline registered
[    2.519546] io scheduler cfq registered (default)
[    2.524705] pcieport 0000:00:03.1: Signaling PME through PCIe PME interrupt
[    2.531808] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    2.538453] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.544141] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.550948] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.559486] ACPI: Power Button [PWRB]
[    2.563295] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.570851] ACPI: Power Button [PWRF]
[    2.575158] GHES: HEST is not enabled!
[    2.579126] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.606147] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.614092] Non-volatile memory driver v1.3
[    2.618423] Linux agpgart interface v0.103
[    2.623595] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    2.631848] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    2.640644] scsi host0: ahci
[    2.643940] scsi host1: ahci
[    2.647256] scsi host2: ahci
[    2.650481] scsi host3: ahci
[    2.653601] ata1: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71100 irq 19
[    2.661155] ata2: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71180 irq 19
[    2.668714] ata3: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71200 irq 19
[    2.676267] ata4: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71280 irq 19
[    2.683941] libphy: Fixed MDIO Bus: probed
[    2.688328] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.694966] ehci-pci: EHCI PCI platform driver
[    2.699680] ehci-pci 0000:00:12.2: EHCI Host Controller
[    2.705193] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    2.712747] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.721614] ehci-pci 0000:00:12.2: debug port 1
[    2.726290] ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb6f000
[    2.737746] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.743674] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.750604] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.757983] usb usb1: Product: EHCI Host Controller
[    2.762966] usb usb1: Manufacturer: Linux 4.6.0-rc7+ ehci_hcd
[    2.768819] usb usb1: SerialNumber: 0000:00:12.2
[    2.773785] hub 1-0:1.0: USB hub found
[    2.777690] hub 1-0:1.0: 5 ports detected
[    2.782123] ehci-pci 0000:00:13.2: EHCI Host Controller
[    2.787696] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    2.795257] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.804117] ehci-pci 0000:00:13.2: debug port 1
[    2.808789] ehci-pci 0000:00:13.2: irq 17, io mem 0xfeb6d000
[    2.820735] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    2.826645] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.833576] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.840959] usb usb2: Product: EHCI Host Controller
[    2.845947] usb usb2: Manufacturer: Linux 4.6.0-rc7+ ehci_hcd
[    2.851802] usb usb2: SerialNumber: 0000:00:13.2
[    2.856786] hub 2-0:1.0: USB hub found
[    2.860682] hub 2-0:1.0: 5 ports detected
[    2.865000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.871302] ohci-pci: OHCI PCI platform driver
[    2.875990] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    2.881864] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
[    2.889477] ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb70000
[    2.949837] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.956761] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.964161] usb usb3: Product: OHCI PCI host controller
[    2.969497] usb usb3: Manufacturer: Linux 4.6.0-rc7+ ohci_hcd
[    2.975347] usb usb3: SerialNumber: 0000:00:12.0
[    2.980314] hub 3-0:1.0: USB hub found
[    2.984257] hub 3-0:1.0: 5 ports detected
[    2.988685] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    2.989920] ata1: SATA link down (SStatus 0 SControl 300)
[    2.993656] ata3: SATA link down (SStatus 0 SControl 300)
[    2.994599] ata2: SATA link down (SStatus 0 SControl 300)
[    3.012918] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 4
[    3.020511] ohci-pci 0000:00:13.0: irq 18, io mem 0xfeb6e000
[    3.080831] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.087723] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.095085] usb usb4: Product: OHCI PCI host controller
[    3.100414] usb usb4: Manufacturer: Linux 4.6.0-rc7+ ohci_hcd
[    3.106264] usb usb4: SerialNumber: 0000:00:13.0
[    3.111336] hub 4-0:1.0: USB hub found
[    3.115232] hub 4-0:1.0: 5 ports detected
[    3.119637] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    3.125478] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 5
[    3.133026] ohci-pci 0000:00:14.5: irq 18, io mem 0xfeb6c000
[    3.142742] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.150798] ata4.00: ATA-8: ST31000524NS, SN12, max UDMA/133
[    3.156567] ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    3.165378] ata4.00: configured for UDMA/133
[    3.170144] scsi 3:0:0:0: Direct-Access     ATA      ST31000524NS     SN12 PQ: 0 ANSI: 5
[    3.185066] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    3.185107] sd 3:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    3.185216] sd 3:0:0:0: [sda] Write Protect is off
[    3.185260] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.193693] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.193695] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.193696] usb usb5: Product: OHCI PCI host controller
[    3.193697] usb usb5: Manufacturer: Linux 4.6.0-rc7+ ohci_hcd
[    3.193697] usb usb5: SerialNumber: 0000:00:14.5
[    3.193842] hub 5-0:1.0: USB hub found
[    3.193850] hub 5-0:1.0: 2 ports detected
[    3.193962] uhci_hcd: USB Universal Host Controller Interface driver
[    3.194112] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    3.194165] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
[    3.194394] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    3.194589] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
[    3.194590] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.194591] usb usb6: Product: xHCI Host Controller
[    3.194592] usb usb6: Manufacturer: Linux 4.6.0-rc7+ xhci-hcd
[    3.194593] usb usb6: SerialNumber: 0000:00:10.0
[    3.194692] hub 6-0:1.0: USB hub found
[    3.194699] hub 6-0:1.0: 2 ports detected
[    3.194775] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    3.194819] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 7
[    3.196602]  sda: sda1 sda2
[    3.196862] sd 3:0:0:0: [sda] Attached SCSI disk
[    3.197773] usb usb7: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.197786] usb usb7: New USB device found, idVendor=1d6b, idProduct=0003
[    3.197787] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.197788] usb usb7: Product: xHCI Host Controller
[    3.197789] usb usb7: Manufacturer: Linux 4.6.0-rc7+ xhci-hcd
[    3.197789] usb usb7: SerialNumber: 0000:00:10.0
[    3.197884] hub 7-0:1.0: USB hub found
[    3.197891] hub 7-0:1.0: 2 ports detected
[    3.198045] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    3.198098] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 8
[    3.198311] xhci_hcd 0000:00:10.1: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    3.198489] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[    3.198491] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.198491] usb usb8: Product: xHCI Host Controller
[    3.198492] usb usb8: Manufacturer: Linux 4.6.0-rc7+ xhci-hcd
[    3.198493] usb usb8: SerialNumber: 0000:00:10.1
[    3.198596] hub 8-0:1.0: USB hub found
[    3.198602] hub 8-0:1.0: 2 ports detected
[    3.198677] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    3.198719] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 9
[    3.201704] usb usb9: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.201716] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[    3.201717] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.201717] usb usb9: Product: xHCI Host Controller
[    3.201718] usb usb9: Manufacturer: Linux 4.6.0-rc7+ xhci-hcd
[    3.201719] usb usb9: SerialNumber: 0000:00:10.1
[    3.201812] hub 9-0:1.0: USB hub found
[    3.201818] hub 9-0:1.0: 2 ports detected
[    3.201921] usbcore: registered new interface driver usbserial
[    3.201926] usbcore: registered new interface driver usbserial_generic
[    3.201931] usbserial: USB Serial support registered for generic
[    3.201960] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    3.202412] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.202415] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.202527] mousedev: PS/2 mouse device common for all mice
[    3.202729] rtc_cmos 00:06: RTC can wake from S4
[    3.202878] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    3.202912] rtc_cmos 00:06: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    3.202965] device-mapper: uevent: version 1.0.3
[    3.203039] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    3.203335] hidraw: raw HID events driver (C) Jiri Kosina
[    3.203378] usbcore: registered new interface driver usbhid
[    3.203379] usbhid: USB HID core driver
[    3.203457] drop_monitor: Initializing network drop monitor service
[    3.203528] ip_tables: (C) 2000-2006 Netfilter Core Team
[    3.219329] Initializing XFRM netlink socket
[    3.219468] NET: Registered protocol family 10
[    3.219685] mip6: Mobile IPv6
[    3.219687] NET: Registered protocol family 17
[    3.250520] microcode: CPU0: patch_level=0x06003104
[    3.250530] microcode: CPU1: patch_level=0x06003104
[    3.250542] microcode: CPU2: patch_level=0x06003104
[    3.250544] microcode: CPU3: patch_level=0x06003104
[    3.250591] microcode: Microcode Update Driver: v2.01 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    3.256973] ... APIC ID:      10000000 (10)
[    3.256974] ... APIC VERSION: 80050010
[    3.256977] 0000000000000000000000000000000000000000000000000000000000000000
[    3.256979] 0000000000000000000000000000000000000000000000000000000000000000
[    3.256981] 0000000000000000000000000000000000000000000000000000000000008000
[    3.256982] 
[    3.256990] ... APIC ID:      11000000 (11)
[    3.256991] ... APIC VERSION: 80050010
[    3.256993] 0000000000000000000000000000000000000000000000000000000000000000
[    3.256994] 0000000000000000000000000000000000000000000000000000000000000000
[    3.256996] 0000000000000000000000000000000000000000000000000000000020000000
[    3.256997] 
[    3.257005] ... APIC ID:      12000000 (12)
[    3.257005] ... APIC VERSION: 80050010
[    3.257009] 0000000000000000000000000000000000000000000000000000000000000000
[    3.257011] 0000000000000000000000000000000000000000000000000000000000000000
[    3.257013] 0000000000000000000000000000000000000000000000000000000000000000
[    3.257014] 
[    3.257015] ... APIC ID:      13000000 (13)
[    3.257015] ... APIC VERSION: 80050010
[    3.257017] 0000000000000000000000000000000000000000000000000000000000000000
[    3.257019] 0000000000000000000000000000000000000000000000000000000000000000
[    3.257020] 0000000000000000000000000000000000000000000000000000000000000000
[    3.257021] 
[    3.257023] testing the IO APIC.......................
[    3.257221] .................................... done.
[    3.257229] AVX version of gcm_enc/dec engaged.
[    3.257229] AES CTR mode by8 optimization enabled
[    3.279454] registered taskstats version 1
[    3.279469] Loading compiled-in X.509 certificates
[    3.280697] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[    3.281420] Loaded X.509 cert 'Build time autogenerated kernel key: 0e2826147936663a5ac6eeec89769acff5dfb9ef'
[    3.281451] zswap: loaded using pool lzo/zbud
[    3.281803]   Magic number: 0:295:823
[    3.285305] rtc_cmos 00:06: setting system clock to 2016-05-25 06:50:31 UTC (1464159031)
[    3.339609] usb 3-3: new low-speed USB device number 2 using ohci-pci
[    3.407608] tsc: Refined TSC clocksource calibration: 3693.281 MHz
[    3.407610] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a791632c9c, max_idle_ns: 881591001453 ns
[    3.502871] usb 3-3: New USB device found, idVendor=413c, idProduct=2105
[    3.502872] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.502873] usb 3-3: Product: Dell USB Keyboard
[    3.502874] usb 3-3: Manufacturer: Dell
[    3.527126] input: Dell Dell USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb3/3-3/3-3:1.0/0003:413C:2105.0001/input/input5
[    3.577769] hid-generic 0003:413C:2105.0001: input,hidraw0: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] on usb-0000:00:12.0-3/input0
[    3.698603] usb 3-4: new low-speed USB device number 3 using ohci-pci
[    3.846865] usb 3-4: New USB device found, idVendor=17ef, idProduct=6050
[    3.846867] usb 3-4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    3.846868] usb 3-4: Product: Lenovo Precision USB Mouse
[    3.855100] input: Lenovo Precision USB Mouse as /devices/pci0000:00/0000:00:12.0/usb3/3-4/3-4:1.0/0003:17EF:6050.0002/input/input6
[    3.855258] hid-generic 0003:17EF:6050.0002: input,hidraw1: USB HID v1.11 Mouse [Lenovo Precision USB Mouse] on usb-0000:00:12.0-4/input0
[    3.955223] Freeing unused kernel memory: 1536K (ffffffff81d45000 - ffffffff81ec5000)
[    3.965099] Write protecting the kernel read-only data: 12288k
[    3.971413] Freeing unused kernel memory: 272K (ffff8800017bc000 - ffff880001800000)
[    3.981315] Freeing unused kernel memory: 908K (ffff880001b1d000 - ffff880001c00000)
[    3.992133] random: systemd urandom read with 18 bits of entropy available
[    4.009864] systemd[1]: systemd 222 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GN)
[    4.028319] systemd[1]: Detected architecture x86-64.
[    4.033522] systemd[1]: Running in initial RAM disk.

Welcome to Fedora 23 (Twenty Three) dracut-043-60.git20150811.fc23 (Initramfs)!

[    4.047895] systemd[1]: Set hostname to <dhcp-129-10.nay.redhat.com>.
[  OK  ] Reached target Timers.
[    4.104795] systemd[1]: Reached target Timers.
[    4.109401] systemd[1]: Starting Timers.
[  OK  ] Reached target Local File Systems.
[    4.119826] systemd[1]: Reached target Local File Systems.
[    4.125433] systemd[1]: Starting Local File Systems.
[  OK  ] Reached target Swap.
[    4.135825] systemd[1]: Reached target Swap.
[    4.140217] systemd[1]: Starting Swap.
[  OK  ] Created slice -.slice.
[    4.149809] systemd[1]: Created slice -.slice.
[    4.154406] systemd[1]: Starting -.slice.
[  OK  ] Listening on udev Kernel Socket.
[    4.164824] systemd[1]: Listening on udev Kernel Socket.
[    4.170257] systemd[1]: Starting udev Kernel Socket.
[  OK  ] Created slice System Slice.
[    4.180829] systemd[1]: Created slice System Slice.
[    4.185853] systemd[1]: Starting System Slice.
[  OK  ] Listening on udev Control Socket.
[    4.196822] systemd[1]: Listening on udev Control Socket.
[    4.202341] systemd[1]: Starting udev Control Socket.
[  OK  ] Listening on Journal Socket.
[    4.212818] systemd[1]: Listening on Journal Socket.
[    4.217910] systemd[1]: Starting Journal Socket.
[    4.231110] systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
[    4.242517] systemd[1]: Starting Create list of required static device nodes for the current kernel...
         Starting Create list of required st... nodes for the current kernel...
[    4.261934] systemd[1]: Started Load Kernel Modules.
[    4.267080] systemd[1]: Started dracut ask for additional cmdline parameters.
[    4.274968] systemd[1]: Starting dracut cmdline hook...
         Starting dracut cmdline hook...
[    4.285395] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[  OK  ] Listening on Journal Socket (/dev/log).
[    4.301595] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.307676] systemd[1]: Starting Journal Socket (/dev/log).
[  OK  ] Reached target Slices.
[    4.317549] systemd[1]: Reached target Slices.
[    4.322125] systemd[1]: Starting Slices.
[  OK  ] Listening on Journal Audit Socket.
[    4.332632] systemd[1]: Listening on Journal Audit Socket.
[    4.338269] systemd[1]: Starting Journal Audit Socket.
[  OK  ] Reached target Sockets.
[    4.347634] systemd[1]: Reached target Sockets.
[    4.352301] systemd[1]: Starting Sockets.
[    4.367070] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[  OK  ] Started Setup Virtual Console.
[    4.383694] systemd[1]: Started Setup Virtual Console.
[    4.389088] audit: type=1130 audit(1464159032.605:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm'
[    4.409645] clocksource: Switched to clocksource tsc
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[    4.423771] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    4.433025] audit: type=1130 audit(1464159032.650:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="sys'
[  OK  ] Started dracut cmdline hook.
[    4.458755] systemd[1]: Started dracut cmdline hook.
[    4.463899] audit: type=1130 audit(1464159032.681:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="system'
[  OK  ] Started Apply Kernel Variables.
[    4.490764] systemd[1]: Started Apply Kernel Variables.
[    4.496175] audit: type=1130 audit(1464159032.713:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="system'
[  OK  ] Started Journal Service.
[    4.521843] systemd[1]: Started Journal Service.
[    4.526699] audit: type=1130 audit(1464159032.743:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="syst'
         Starting dracut pre-udev hook...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Create Static Device Nodes in /dev.
[    4.582704] audit: type=1130 audit(1464159032.799:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev '
[  OK  ] Started dracut pre-udev hook.
[    4.608733] audit: type=1130 audit(1464159032.825:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="syste'
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
[    4.650863] audit: type=1130 audit(1464159032.867:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd'
         Starting udev Coldplug all Devices...
         Mounting Configuration File System...
[  OK  ] Mounted Configuration File System.
[  OK  ] Started udev Coldplug all Devices.
[    4.717666] audit: type=1130 audit(1464159032.934:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm='
[    4.739295] [drm] Initialized drm 1.1.0 20060810
         Startin[    4.745383] scsi host4: pata_atiixp
g dracut initque[    4.750042] scsi host5: pata_atiixp
ue hook...
[    4.754510] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf100 irq 14
[    4.762132] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf108 irq 15
         Starting Show Pl[    4.770198] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
ymouth Boot Scre[    4.777861] r8169 0000:01:00.0 eth0: RTL8168evl/8111evl at 0xffffc90000f12000, fc:aa:14:c0:c2:7e, XID 0c900880 IRQ 37
en...
[    4.789260] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    4.790595] r8169 0000:01:00.0 enp1s0: renamed from eth0
[    4.810491] [drm] radeon kernel modesetting enabled.
[    4.817612] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[    4.826762] Found CRAT image with size=1360
[    4.831042] Parsing CRAT table with 1 nodes
[    4.835331] Found CU entry in CRAT table with proximity_domain=0 caps=0
[    4.842051] CU CPU: cores=4 id_base=16
[    4.845902] Found CU entry in CRAT table with proximity_domain=0 caps=0
[    4.852613] CU GPU: simds=32 id_base=-2147483648
[    4.857335] Found memory entry in CRAT table with proximity_domain=0
[    4.863769] Found memory entry in CRAT table with proximity_domain=0
[    4.870199] Found cache entry in CRAT table with processor_id=16
[    4.870199] Found cache entry in CRAT table with processor_id=16
[    4.870200] Found cache entry in CRAT table with processor_id=16
[    4.870201] Found cache entry in CRAT table with processor_id=17
[    4.870201] Found cache entry in CRAT table with processor_id=18
[    4.870201] Found cache entry in CRAT table with processor_id=18
[    4.870201] Found cache entry in CRAT table with processor_id=18
[    4.870202] Found cache entry in CRAT table with processor_id=19
[    4.870202] Found TLB entry in CRAT table (not processing)
[    4.870202] Found TLB entry in CRAT table (not processing)
[    4.870203] Found TLB entry in CRAT table (not processing)
[    4.870203] Found TLB entry in CRAT table (not processing)
[    4.870203] Found TLB entry in CRAT table (not processing)
[    4.870203] Found TLB entry in CRAT table (not processing)
[    4.870204] Found TLB entry in CRAT table (not processing)
[    4.870204] Found TLB entry in CRAT table (not processing)
[    4.870205] Found TLB entry in CRAT table (not processing)
[    4.870205] Found TLB entry in CRAT table (not processing)
[    4.870205] Creating topology SYSFS entries
[    4.870226] Finished initializing topology ret=0
[    4.870289] kfd kfd: Initialized module
[    4.870994] [drm] initializing kernel modesetting (KAVERI 0x1002:0x130F 0x1002:0x0123 0x00).
[    4.871007] [drm] register mmio base: 0xFEB00000
[    4.871007] [drm] register mmio size: 262144
[    4.871010] [drm] doorbell mmio base: 0xD0000000
[    4.871010] [drm] doorbell mmio size: 8388608
[    4.871058] ATOM BIOS: 113
[    4.871123] radeon 0000:00:01.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    4.871125] radeon 0000:00:01.0: GTT: 2048M 0x0000000040000000 - 0x00000000BFFFFFFF
[    4.871126] [drm] Detected VRAM RAM=1024M, BAR=256M
[    4.871126] [drm] RAM width 128bits DDR
[    4.871167] [TTM] Zone  kernel: Available graphics memory: 3443228 kiB
[    4.871168] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    4.871168] [TTM] Initializing pool allocator
[    4.871172] [TTM] Initializing DMA pool allocator
[    4.871190] [drm] radeon: 1024M of VRAM memory ready
[    4.871190] [drm] radeon: 2048M of GTT memory ready.
[    4.871198] [drm] Loading kaveri Microcode
[    4.871302] [drm] Internal thermal controller without fan control
[    4.872502] [drm] radeon: dpm initialized
[    4.874170] [drm] Found VCE firmware/feedback version 40.2.2 / 15!
[    4.874177] [drm] GART: num cpu pages 524288, num gpu pages 524288
[    4.891823] [drm] PCIE GART of 2048M enabled (table at 0x0000000000324000).
[    4.892058] radeon 0000:00:01.0: WB enabled
[    4.892068] radeon 0000:00:01.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffff880231772c00
[    4.892070] radeon 0000:00:01.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffff880231772c04
[    4.892071] radeon 0000:00:01.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffff880231772c08
[    4.892073] radeon 0000:00:01.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffff880231772c0c
[    4.892074] radeon 0000:00:01.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffff880231772c10
[    4.892459] radeon 0000:00:01.0: fence driver on ring 5 use gpu addr 0x0000000000076c98 and cpu addr 0xffffc90001436c98
[    4.892709] radeon 0000:00:01.0: fence driver on ring 6 use gpu addr 0x0000000040000c18 and cpu addr 0xffff880231772c18
[    4.892711] radeon 0000:00:01.0: fence driver on ring 7 use gpu addr 0x0000000040000c1c and cpu addr 0xffff880231772c1c
[    4.892712] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.892713] [drm] Driver supports precise vblank timestamp query.
[    4.892749] radeon 0000:00:01.0: radeon: using MSI.
[    4.892787] [drm] radeon: irq initialized.
[    4.894670] [drm] ring test on 0 succeeded in 2 usecs
[    4.894748] [drm] ring test on 1 succeeded in 1 usecs
[    4.894762] [drm] ring test on 2 succeeded in 1 usecs
[    4.894893] [drm] ring test on 3 succeeded in 2 usecs
[    4.894898] [drm] ring test on 4 succeeded in 3 usecs
[    4.940931] [drm] ring test on 5 succeeded in 0 usecs
[    4.950943] [drm] UVD initialized successfully.
[    4.985908] ata6.00: ATAPI: PIONEER DVD-ROM DVD-232, 1.00, max UDMA/100
[    4.985911] ata6.00: limited to UDMA/33 due to 40-wire cable
[    5.057889] ata6.00: configured for UDMA/33
[    5.060981] [drm] ring test on 6 succeeded in 9 usecs
[    5.060992] [drm] ring test on 7 succeeded in 2 usecs
[    5.060993] [drm] VCE initialized successfully.
[    5.071725] scsi 5:0:0:0: CD-ROM            PIONEER  DVD-ROM DVD-232  1.00 PQ: 0 ANSI: 5
[    5.090415] [drm] ib test on ring 0 succeeded in 0 usecs
[    5.090444] [drm] ib test on ring 1 succeeded in 0 usecs
[    5.090472] [drm] ib test on ring 2 succeeded in 0 usecs
[    5.090504] [drm] ib test on ring 3 succeeded in 0 usecs
[    5.090533] [drm] ib test on ring 4 succeeded in 0 usecs
[    5.100806] sr 5:0:0:0: [sr0] scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
[    5.100807] cdrom: Uniform CD-ROM driver Revision: 3.20
[    5.101080] sr 5:0:0:0: Attached scsi generic sg1 type 5
[    5.601790] [drm] ib test on ring 5 succeeded
[    5.627181] [drm] ib test on ring 6 succeeded
[    5.632701] [drm] ib test on ring 7 succeeded
[    5.637865] [drm] Radeon Display Connectors
[    5.642193] [drm] Connector 0:
[    5.645352] [drm]   DVI-D-1
[    5.648247] [drm]   HPD3
[    5.650882] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
[    5.658385] [drm]   Encoders:
[    5.661456] [drm]     DFP2: INTERNAL_UNIPHY2
[    5.665822] [drm] Connector 1:
[    5.668976] [drm]   HDMI-A-1
[    5.671959] [drm]   HPD1
[    5.674565] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
[    5.682071] [drm]   Encoders:
[    5.685142] [drm]     DFP1: INTERNAL_UNIPHY
[    5.689422] [drm] Connector 2:
[    5.692548] [drm]   VGA-1
[    5.695271] [drm]   HPD2
[    5.697906] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
[    5.705410] [drm]   Encoders:
[    5.708480] [drm]     CRT1: INTERNAL_UNIPHY3
[    5.712845] [drm]     CRT1: NUTMEG
[    5.814989] [drm] fb mappable at 0xC0728000
[    5.819305] [drm] vram apper at 0xC0000000
[    5.823477] [drm] size 5242880
[    5.826601] [drm] fb depth is 24
[    5.829903] [drm]    pitch is 5120
[    5.833531] fbcon: radeondrmfb (fb0) is primary device
[    5.898310] Console: switching to colour frame buffer device 160x64
[    5.912900] radeon 0000:00:01.0: fb0: radeondrmfb frame buffer device
G[  OK  ] Reached target System Initialization.
G[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Reached target Paths.
[\_SB_.ALIB]ched targe[    5.935299] ACPI Error: t Basic System.
 Namespace lookup failure, AE_NOT_FOUND (20160108/psargs-359)
[    5.947172] ACPI Error: Method parse/execution failed [\_SB.PCI0.VGA.ATC0] (Node ffff8802370c8028), AE_NOT_FOUND (20160108/psparse-542)
[    5.959470] ACPI Error: Method parse/execution failed [\_SB.PCI0.VGA.ATCS] (Node ffff8802370c8000), AE_NOT_FOUND (20160108/psparse-542)
[    5.974563] kfd kfd: Allocated 3944480 bytes on gart for device(1002:130f)
[    5.981578] kfd kfd: added device (1002:130f)
[    5.985958] [drm] Initialized radeon 2.43.0 20080528 for 0000:00:01.0 on minor 0
[    6.440823] random: nonblocking pool is initialized
[  OK  ] Found device /dev/mapper/fedora_dhcp--129--10-root.
[  OK  ] Started dracut initqueue hook.
         Starting File System Check on /dev/mapper/fedora_dhcp--129--10-root...
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[  OK  ] Started File System Check on /dev/mapper/fedora_dhcp--129--10-root.
         Mounting /sysroot...
[    6.696476] SGI XFS with ACLs, security attributes, no debug enabled
[    6.706168] XFS (dm-0): Mounting V5 Filesystem
[    6.829498] XFS (dm-0): Ending clean mount
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
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Sockets.
[  OK  ] Stopped target System Initialization.
[  OK  ] Stopped Apply Kernel Variables.
         Stopping Apply Kernel Variables...
[  OK  ] Stopped target Local File Systems.
         Stopping udev Kernel Device Manager...
[  OK  ] Stopped target Swap.
[  OK  ] Stopped target Slices.
[  OK  ] Stopped target Paths.
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped target Remote File Systems (Pre).
[  OK  ] Stopped dracut initqueue hook.
         Stopping dracut initqueue hook...
[  OK  ] Stopped udev Coldplug all Devices.
  [    7.167152] systemd-journald[296]: Received SIGTERM from PID 1 (n/a).
       Stopping udev Coldplug all Devices...
[  OK  ] Stopped udev Kernel Device Manager.
[  OK  ] Stopped dracut pre-udev hook.
         Stopping dracut pre-udev hook...
[  OK  ] Stopped dracut cmdline hook.
         Stopping dracut cmdline hook...
[  OK  ] Stopped Create Static Device Nodes in /dev.
         Stopping Create Static Device Nodes in /dev...
[  OK  ] Stopped Create list of required sta...ce nodes for the current kernel.
         Stopping Create list of required st... nodes for the current kernel...
[  OK  ] Closed udev Kernel Socket.
[  OK  ] Closed udev Control Socket.
         Starting Cleanup udevd DB...
[  OK  ] Started Cleanup udevd DB.
[  OK  ] Reached target Switch Root.
[  OK  ] Started Plymouth switch root service.
         Starting Switch Root...
[    7.552763] audit_printk_skb: 87 callbacks suppressed
[    7.558855] audit: type=1404 audit(1464159035.769:40): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[    7.747046] SELinux:  Permission validate_trans in class security not defined in policy.
[    7.756286] SELinux: the above unknown classes and permissions will be allowed
[    7.773701] audit: type=1403 audit(1464159035.990:41): policy loaded auid=4294967295 ses=4294967295
[    7.789241] systemd[1]: Successfully loaded SELinux policy in 244.026ms.
[    7.878494] systemd[1]: Relabelled /dev and /run in 17.723ms.

Welcome to Fedora 23 (Twenty Three)!

[    8.632312] audit: type=1130 audit(1464159036.848:42): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=syste'
[    8.656140] audit: type=1131 audit(1464159036.873:43): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=syste'
[    8.680483] audit: type=1130 audit(1464159036.897:44): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=initr'
[  OK  ] Stopped Switch[    8.704713] audit: type=1131 audit(1464159036.922:45): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:in'
 Root.
[    8.729692] audit: type=1130 audit(1464159036.946:46): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=syste'
[    8.729716] audit: type=1131 audit(1464159036.946:47): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=syste'
[  OK  ] Stopped Journal Service.
         Starting Journal Service...
[  OK  ] Reached target Encrypted Volumes.
[  OK  ] Set up automount Arbitrary Executab...ats File System Automount Point.
[    8.856223] audit: type=1305 audit(1464159037.072:48): audit_enabled=1 old=1 auid=4294967295 ses=4294967295 subj=system_u:system_r:syslogd_t:s0 re1
         Mounting Temporary Directory...
         Mounting Debug File System...
         Starting Create list of[    8.928793] audit: type=1130 audit(1464159037.145:49): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:sy'
 required st... nodes for the current kernel...
[  OK  ] Stopped File System Check on Root Device.
         Stopping File System Check on Root Device...
[  OK  ] Created slice system-systemd\x2dfsck.slice.
[  OK  ] Listening on Device-mapper event daemon FIFOs.
         Mounting Huge Pages File System...
[  OK  ] Listening on udev Control Socket.
         Mounting POSIX Message Queue File System...
[  OK  ] Reached target Remote File Systems.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Created slice system-getty.slice.
[  OK  ] Listening on LVM2 poll daemon socket.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Listening on LVM2 metadata daemon socket.
         Starting Monitoring of LVM2 mirrors... dmeventd or progress polling...
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Slices.
[  OK  ] Created slice system-serial\x2dgetty.slice.
         Starting Apply Kernel Variables...
[  OK  ] Stopped target Switch Root.
[  OK  ] Stopped target Initrd File Systems.
[  OK  ] Stopped target Initrd Root File System.
[  OK  ] Reached target Paths.
[  OK  ] Mounted Debug File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted Temporary Directory.
[  OK  ] Started Journal Service.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting udev Coldplug all Devices...
         Starting Configure read-only root support...
         Starting Create Static Device Nodes in /dev...
         Starting Flush Journal to Persistent Storage...
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started LVM2 metadata daemon.
         Starting LVM2 metadata daemon...
[    9.383570] systemd-journald[607]: Received request to flush runtime journal from PID 1
[  OK  ] Started udev Coldplug all Devices.
[    9.551404] systemd-journald[607]: File /var/log/journal/8f17e1b512944c6188871fa5fbde084f/system.journal corrupted or uncleanly shut down, renamin.
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Reached target Local File Systems (Pre).
         Starting udev Kernel Device Manager...
[  OK  ] Started Configure read-only root support.
         Starting Load/Save Random Seed...
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started udev Kernel Device Manager.
[   10.678408] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   10.725122] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   10.733295] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[   10.742758] acpi device:02: registered as cooling_device4
[   10.749491] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/LNXVIDEO:00/input/input7
[  OK  ] Found device /dev/ttyS0.
[   11.204572] EDAC MC: Ver: 3.0.0
[   11.211495] MCE: In-kernel MCE decoding enabled.
[   11.264477] acpi-cpufreq: overriding BIOS provided _PSD data
[  OK  ] Started Monitoring of LVM2 mirrors,...ng dmeventd or progress polling.
[  OK  ] Started Flush Journal to Persistent Storage.
[   11.464076] AMD64 EDAC driver v3.4.0
[   11.469381] EDAC amd64: DRAM ECC disabled.
[   11.475208] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[   11.475208]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
[   11.475208]  (Note that use of the override may cause unknown side effects.)
[   11.504551] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[   11.514341] input: PC Speaker as /devices/platform/pcspkr/input/input8
[   11.543518] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   11.552308] piix4_smbus 0000:00:14.0: Using register 0x2e for SMBus port selection
[   11.562135] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[   11.582705] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input9
[   11.594033] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC892: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[   11.605832] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   11.614993] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   11.623888] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   11.631519] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x11/0x1e
[   11.639021] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   11.645659] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
[   11.653427] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[   11.660723] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[   11.660836] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   11.660944] sp5100_tco: PCI Vendor ID: 0x1022, Device ID: 0x780b, Revision ID: 0x16
[   11.660949] sp5100_tco: I/O address 0x0cd6 already in use
GG[   11.710028] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card1/input10
[   11.720970] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card1/input11
[   11.731567] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:14.2/sound/card1/input12
[   11.741668] input: HD-Audio Generic Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card1/input13
[   11.752582] input: HD-Audio Generic Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card1/input14
[   11.763800] input: HD-Audio Generic Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card1/input15
[   11.774717] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card1/input16
[  OK  ] Reached target Sound Card.
[  OK  ] Created slice system-systemd\x2dbacklight.slice.
         Starting Load/Save Screen Backlight...ness of backlight:acpi_video0...
[  OK  ] Started Load/Save Screen Backlight ...htness of backlight:acpi_video0.
[  OK  ] Found device ST31000524NS 1.
         Starting File System Check on /dev/...b-6c5b-4610-8ddb-a557b1d40e0a...
[  OK  ] Created slice system-lvm2\x2dpvscan.slice.
         Starting LVM2 PV scan on device 8:2...
[   12.627817] kvm: Nested Virtualization enabled
[   12.633947] kvm: Nested Paging enabled
[  OK  ] Found device /dev/mapper/fedor[   12.699549] audit_printk_skb: 42 callbacks suppressed
a_dhcp--129--10-home.
[  [   12.699550] audit: type=1130 audit(1464159040.916:64): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=lv'
OK  ] Started LVM2 PV scan on device 8:2.
         Mounting /home...
[   12.754253] XFS (dm-2): Mounting V5 Filesystem
[   13.048263] audit: type=1130 audit(1464159041.264:65): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=syste'
[  OK  ] Started File System Check on /dev/d...0db-6c5b-4610-8ddb-a557b1d40e0a.
[   13.082306] XFS (dm-2): Starting recovery (logdev: internal)
m  OK  ] Found device /dev/mapper/fedora_dhcp--129--10-swap.
         Activating swap /dev/mapper/fedora_dhcp--129--10-swap...
         Mounting /boot...
[   13.195926] Adding 7208956k swap on /dev/mapper/fedora_dhcp--129--10-swap.  Priority:-1 extents:1 across:7208956k FS
[  OK  ] Activated swap /dev/mapper/fedora_dhcp--129--10-swap.
[  OK  ] Reached target Swap.
[   13.233122] XFS (dm-2): Ending recovery (logdev: internal)
[  OK  ] Mounted /home.
[   13.261738] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[  OK  ] Mounted /boot.
[  OK  ] Reached target Local File Systems.
         Starting Restore /run/initramfs on shutdown...
         Starting Import network configuration from initramfs...
         Starting Tell Plymouth To Write Out Runtime Data...
[   13.442660] audit: type=1130 audit(1464159041.659:66): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dracu'
[  OK  ] Started Restore /run/initramfs[   13.545008] audit: type=1130 audit(1464159041.761:67): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=syst'
 on shutdown.
[  OK  ] Started Tell Plymouth To Write[   13.573416] audit: type=1131 audit(1464159041.790:68): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=syst'
 Out Runtime Data.
[   13.599702] audit: type=1130 audit(1464159041.816:69): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=fedor'
[  OK  ] Started Import network configuration from initramfs.
         Starting Create Volatile Files and Directories...
[   13.744621] audit: type=1130 audit(1464159041.961:70): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=syste'
[  OK  ] Started Create Volatile Files and Directories.
         Starting Security Auditing Service...
[   13.816045] audit: type=1305 audit(1464159042.032:71): auid=4294967295 ses=4294967295 subj=system_u:system_r:auditctl_t:s0 op="add_rule" key=(null1
[   13.839064] audit: type=1130 audit(1464159042.055:72): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=audit'
[  OK  ] Started Security Auditing Service.
         Starting Update UTMP about System Boot/Shutdown...
[   13.904750] audit: type=1305 audit(1464159042.121:73): audit_enabled=1 old=1 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res1
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Login Service...
         Starting firewalld - dynamic firewall daemon...
[  OK  ] Started D-Bus System Message Bus.
         Starting D-Bus System Message Bus...
         Starting Permit User Sessions...
[  OK  ] Reached target Timers.
[  OK  ] Started Login Service.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Command Scheduler.
         Starting Command Scheduler...
         Starting Wait for Plymouth Boot Screen to Quit...
         Starting Terminate Plymouth Boot Screen...
[   15.880582] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   15.936800] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   16.106198] Ebtables v2.0 registered
[   16.152448] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[   17.241573] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
[   17.567458] r8169 0000:01:00.0 enp1s0: link down
[   17.567461] r8169 0000:01:00.0 enp1s0: link down
[   17.576934] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready

Fedora 23 (Twenty Three)
Kernel 4.6.0-rc7+ on an x86_64 (ttyS0)

dhcp-129-10 login: [   20.477010] r8169 0000:01:00.0 enp1s0: link up
[   20.481593] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
root
Password: 
Last login: Wed May 25 14:47:43 on ttyS0
k[root@dhcp-129-10 ~]# kdumpctl restart
kexec: unloaded kdump kernel
Stopping kdump: [OK]
kexec: loaded kdump kernel
Starting kdump: [OK]
[root@dhcp-129-10 ~]# echo c >/proc/sysrq-trigger 
[   56.916226] sysrq: SysRq : Trigger a crash
[   56.920465] BUG: unable to handle kernel NULL pointer dereference at           (null)
[   56.928408] IP: [<ffffffff814aec36>] sysrq_handle_crash+0x16/0x20
[   56.934569] PGD 0 
[   56.936624] Oops: 0002 [#1] SMP 
[   56.939917] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_broute bridge stp llc ebtable_nat ebtable_filter ebtai
[   57.019471] CPU: 3 PID: 1288 Comm: bash Not tainted 4.6.0-rc7+ #34
[   57.025683] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88X-D3H, BIOS F5 05/28/2014
[   57.035770] task: ffff88007e703b00 ti: ffff88022ded4000 task.ti: ffff88022ded4000
[   57.043304] RIP: 0010:[<ffffffff814aec36>]  [<ffffffff814aec36>] sysrq_handle_crash+0x16/0x20
[   57.051925] RSP: 0018:ffff88022ded7dd0  EFLAGS: 00010282
[   57.057277] RAX: 000000000000000f RBX: 0000000000000063 RCX: 0000000000000000
[   57.064464] RDX: 0000000000000000 RSI: ffff88023ed8e018 RDI: 0000000000000063
[   57.071673] RBP: ffff88022ded7dd0 R08: 00000000000000c2 R09: 0000000000000002
[   57.078875] R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000007
[   57.086068] R13: 0000000000000000 R14: ffffffff81cc59c0 R15: 0000000000000000
[   57.093271] FS:  00007f286620e700(0000) GS:ffff88023ed80000(0000) knlGS:0000000000000000
[   57.101440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.107234] CR2: 0000000000000000 CR3: 0000000233e83000 CR4: 00000000000406e0
[   57.114445] Stack:
[   57.116500]  ffff88022ded7e00 ffffffff814af40a 0000000000000002 fffffffffffffffb
[   57.124036]  ffff88022ded7f18 0000000000000002 ffff88022ded7e18 ffffffff814af88f
[   57.131543]  ffff880232f01cc0 ffff88022ded7e38 ffffffff812a5012 ffff88022ac15000
[   57.139057] Call Trace:
[   57.141529]  [<ffffffff814af40a>] __handle_sysrq+0xea/0x140
[   57.147136]  [<ffffffff814af88f>] write_sysrq_trigger+0x2f/0x40
[   57.153125]  [<ffffffff812a5012>] proc_reg_write+0x42/0x70
[   57.158671]  [<ffffffff81238f77>] __vfs_write+0x37/0x100
[   57.164071]  [<ffffffff81343b3d>] ? security_file_permission+0x3d/0xc0
[   57.170664]  [<ffffffff810ece62>] ? percpu_down_read+0x12/0x50
[   57.176567]  [<ffffffff81239f29>] vfs_write+0xa9/0x1a0
[   57.181762]  [<ffffffff8123b385>] SyS_write+0x55/0xc0
[   57.186843]  [<ffffffff817b30b2>] entry_SYSCALL_64_fastpath+0x1a/0xa4
[   57.193314] Code: 48 c7 c7 fa 40 a6 81 e8 39 2b c9 ff e9 e0 fe ff ff 0f 1f 40 00 0f 1f 44 00 00 55 c7 05 18 85 a7 00 01 00 00 00 48 89 e5 0f ae f8 
[   57.213815] RIP  [<ffffffff814aec36>] sysrq_handle_crash+0x16/0x20
[   57.220055]  RSP <ffff88022ded7dd0>
[   57.223567] CR2: 0000000000000000
[    0.000000] Linux version 4.6.0-rc7+ (bhe-sa4SJRhfYT7yzlqKoElxGh/sF2h8X+2i0E9HWUfgJXw@public.gmane.org) (gcc version 5.1.1 20150618 (Red Hat 5.1.1-4) (GCC) ) #34 SMP Tue May 24 17:6
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.6.0-rc7+ root=/dev/mapper/fedora_dhcp--129--10-root ro rd.lvm.lv=fedora_dhcp-129-10/root rd.lvm.lvK
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000025000000-0x0000000034f5cfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000034fffc00-0x0000000034ffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007cc9a000-0x000000007ccc9fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007cfa0000-0x000000007d06dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007d06e000-0x000000007e1c7fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007e1c9000-0x000000007e3cefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007e851000-0x000000007efe1fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] e820: last_pfn = 0x35000 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000fd6f0-0x000fd6ff] mapped at [ffff8800000fd6f0]
[    0.000000]   mpc: fd430-fd66c
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x31aa2000-0x32ffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000007D024080 000084 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000007D02A598 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20160108/tbfadt-654)
[    0.000000] ACPI: DSDT 0x000000007D0241A0 0063F2 (v02 ALASKA A M I    00000088 INTL 20051117)
[    0.000000] ACPI: FACS 0x000000007D063080 000040
[    0.000000] ACPI: APIC 0x000000007D02A6A8 00007E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000007D02A728 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000007D02A770 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x000000007D02A7B0 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: WDRT 0x000000007D02A7E8 000047 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: IVRS 0x000000007D02A830 000078 (v02 AMD    BANTRY   00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x000000007D02A8A8 000B9C (v01 AMD    BANTRY   00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000007D02B448 00033B (v02 AMD    BANTRY   00000002 MSFT 04000000)
[    0.000000] ACPI: CRAT 0x000000007D02B788 000550 (v01 AMD    BANTRY   00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000007D02BCD8 001457 (v01 AMD    CPMDFIGP 00000001 INTL 20051117)
[    0.000000] ACPI: SSDT 0x000000007D02D130 00122C (v01 AMD    CPMCMN   00000001 INTL 20051117)
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] NUMA turned off
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000034ffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x34f4b000-0x34f5cfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x0000000034ffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000025000000-0x0000000034f5cfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000034f5cfff]
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keeping one slot for boot cpu.  Processor 0/0x10 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keeping one slot for boot cpu.  Processor 1/0x11 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keeping one slot for boot cpu.  Processor 2/0x12 ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 1, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] smpboot: 4 Processors exceeds NR_CPUS limit of 1
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.000000] mapped IOAPIC to ffffffffff5fa000 (fec01000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x00100000-0x24ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x34f5d000-0x34ffffff]
[    0.000000] e820: [mem 0x7efe2000-0xfebfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 34 pages/cpu @ffff880034c00000 s98776 r8192 d32296 u2097152
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 64485
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.6.0-rc7+ root=/dev/mapper/fedora_dhcp--129--10-root ro rd.lvm.lv=fedora_dhcp-129-10/root rdK
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] PID hash table entries: 1024 (order: 1, 8192 bytes)
[    0.000000] Memory: 214876K/262124K available (7903K kernel code, 1294K rwdata, 3188K rodata, 1536K init, 1468K bss, 47248K reserved, 0K cma-reser)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
[    0.000000] NR_IRQS:4352 nr_irqs:256 16
[    0.000000]  Offload RCU callbacks from all CPUs
[    0.000000]  Offload RCU callbacks from CPUs: 0.
[    0.000000] Spurious LAPIC timer interrupt on cpu 0
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3693.260 MHz processor
[    0.000044] Calibrating delay loop (skipped), value calculated using timer frequency.. 7386.52 BogoMIPS (lpj=3693260)
[    0.010884] pid_max: default: 32768 minimum: 301
[    0.015613] ACPI: Core revision 20160108
[    0.028251] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.034805] 
[    0.036408] Security Framework initialized
[    0.040630] Yama: becoming mindful.
[    0.044220] SELinux:  Initializing.
[    0.047907] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.055093] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.062131] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.068780] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.076280] Disabling memory control group subsystem
[    0.081437] CPU: Physical Processor ID: 0
[    0.085574] CPU: Processor Core ID: 1
[    0.089337] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.095350] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.111999] Freeing SMP alternatives memory: 32K (ffffffff81ec5000 - ffffffff81ecd000)
[    0.121535] ftrace: allocating 29742 entries in 117 pages
[    0.146933] smpboot: Max logical packages: 2
[    0.151332] smpboot: APIC(13) Converting physical 1 to logical package 0
[    0.158831] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b8 info 0000
[    0.165656] AMD-Vi:        mmio-addr: 00000000feb80000
[    0.170907] Translation is already enabled - trying to copy translation structures
[    0.178576] AMD-Vi:   DEV_SELECT_RANGE_START  devid: 00:01.0 flags: 00
[    0.185197] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.6
[    0.191236] AMD-Vi:   DEV_ALIAS_RANGE                 devid: 02:00.0 flags: 00 devid_to: 00:14.4
[    0.198959] AMD-Vi:   DEV_RANGE_END           devid: 02:1f.7
[    0.204025] AMD-Vi:   DEV_SPECIAL(HPET[0])           devid: 00:14.0
[    0.209604] AMD-Vi:   DEV_SPECIAL(IOAPIC[0])         devid: 00:14.0
[    0.215359] AMD-Vi:   DEV_SPECIAL(IOAPIC[1])         devid: 00:00.0
[    0.223493] Copied translation tables from previous kernel.
[    0.316710] masked ExtINT on CPU#0
[    0.320450] ESR value before enabling vector: 0x00000008  after: 0x00000000
[    0.327531] ENABLING IO-APIC IRQs
[    0.331282] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.347385] Using local APIC timer interrupts.
[    0.347385] calibrating APIC timer ...
[    0.457723] ... lapic delta = 623858
[    0.461399] ... PM-Timer delta = 357950
[    0.465332] ... PM-Timer result ok
[    0.468835] ..... delta 623858
[    0.471987] ..... mult: 26794497
[    0.475306] ..... calibration result: 99817
[    0.479582] ..... CPU clock speed is 3693.0242 MHz.
[    0.484555] ..... host bus clock speed is 99.0817 MHz.
[    0.489803] smpboot: CPU0: AMD A10-7850K Radeon R7, 12 Compute Cores 4C+8G (family: 0x15, model: 0x30, stepping: 0x1)
[    0.500673] Performance Events: Fam15h core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    0.510735] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
[    0.519265] AMD PMU driver.
[    0.522163] ... version:                0
[    0.526269] ... bit width:              48
[    0.530465] ... generic registers:      6
[    0.534572] ... value mask:             0000ffffffffffff
[    0.539983] ... max period:             00007fffffffffff
[    0.545390] ... fixed-purpose events:   0
[    0.549497] ... event mask:             000000000000003f
[    0.555976] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.564091] x86: Booted up 1 node, 1 CPUs
[    0.568203] smpboot: Total of 1 processors activated (7386.52 BogoMIPS)
[    0.575458] devtmpfs: initialized
[    0.579051] x86/mm: Memory block size: 128MB
[    0.587217] PM: Registering ACPI NVS region [mem 0x7cfa0000-0x7d06dfff] (843776 bytes)
[    0.595313] PM: Registering ACPI NVS region [mem 0x7e1c9000-0x7e3cefff] (2121728 bytes)
[    0.603560] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.613548] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.620637] pinctrl core: initialized pinctrl subsystem
[    0.626013] RTC time:  6:51:28, date: 05/25/16
[    0.630726] NET: Registered protocol family 16
[    0.635728] cpuidle: using governor menu
[    0.640086] ACPI: bus type PCI registered
[    0.644227] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.650898] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.660305] PCI: not using MMCONFIG
[    0.663891] PCI: Using configuration type 1 for base access
[    0.669557] PCI: Using configuration type 1 for extended access
[    0.677887] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.684396] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.691130] ACPI: Added _OSI(Module Device)
[    0.695437] ACPI: Added _OSI(Processor Device)
[    0.699977] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.704779] ACPI: Added _OSI(Processor Aggregator Device)
[    0.710972] ACPI: Executed 1 blocks of module-level executable AML code
[    0.723697] ACPI: Interpreter enabled
[    0.727521] ACPI: (supports S0 S3 S4 S5)
[    0.731543] ACPI: Using IOAPIC for interrupt routing
[    0.736807] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.746262] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.755105] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.765110] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    0.773261] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    0.781455] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    0.798248] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.804593] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.813229] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.821919] PCI host bridge to bus 0000:00
[    0.826116] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.832996] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.839877] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.846758] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.853642] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.861222] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.868805] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
[    0.876387] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.883213] pci 0000:00:03.1: System wakeup disabled by ACPI
[    0.889507] pci 0000:00:10.0: System wakeup disabled by ACPI
[    0.895591] pci 0000:00:10.1: System wakeup disabled by ACPI
[    0.901848] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.907888] pci 0000:00:12.2: System wakeup disabled by ACPI
[    0.913897] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.919936] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.926032] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.933261] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.939883] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.947110] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.954027] pci 0000:00:14.2: System wakeup disabled by ACPI
[    0.960134] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.966129] pci 0000:00:14.5: System wakeup disabled by ACPI
[    0.974841] pci 0000:00:03.1: PCI bridge to [bus 01]
[    0.980066] pci 0000:00:14.4: PCI bridge to [bus 02] (subtractive decode)
[    0.987992] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.995202] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    1.002412] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    1.009618] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    1.016806] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    1.023987] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    1.031153] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    1.038330] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    1.045929] vgaarb: setting as boot device: PCI:0000:00:01.0
[    1.051699] vgaarb: device added: PCI:0000:00:01.0,decodes=io+mem,owns=io+mem,locks=none
[    1.059895] vgaarb: loaded
[    1.062706] vgaarb: bridge control possible 0000:00:01.0
[    1.068278] SCSI subsystem initialized
[    1.072293] ACPI: bus type USB registered
[    1.076464] usbcore: registered new interface driver usbfs
[    1.082025] usbcore: registered new interface driver hub
[    1.087446] usbcore: registered new device driver usb
[    1.092734] PCI: Using ACPI for IRQ routing
[    1.104913] NetLabel: Initializing
[    1.108443] NetLabel:  domain hash size = 128
[    1.112895] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.117976] NetLabel:  unlabeled traffic allowed by default
[    1.123955] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.129073] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    1.137053] clocksource: Switched to clocksource hpet
[    1.154164] VFS: Disk quotas dquot_6.6.0
[    1.158244] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.165525] pnp: PnP ACPI init
[    1.168945] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    1.175791] system 00:01: [mem 0x80000000-0xbfffffff] has been reserved
[    1.182657] system 00:02: [mem 0xfeb80000-0xfebfffff] could not be reserved
[    1.190034] system 00:03: [io  0x0220-0x0227] has been reserved
[    1.196052] system 00:03: [io  0x0228-0x0237] has been reserved
[    1.202049] system 00:03: [io  0x0a20-0x0a2f] has been reserved
[    1.208870] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    1.215400] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    1.221479] system 00:08: [io  0x040b] has been reserved
[    1.226893] system 00:08: [io  0x04d6] has been reserved
[    1.232303] system 00:08: [io  0x0c00-0x0c01] has been reserved
[    1.238325] system 00:08: [io  0x0c14] has been reserved
[    1.243732] system 00:08: [io  0x0c50-0x0c51] has been reserved
[    1.249750] system 00:08: [io  0x0c52] has been reserved
[    1.255166] system 00:08: [io  0x0c6c] has been reserved
[    1.260583] system 00:08: [io  0x0c6f] has been reserved
[    1.265998] system 00:08: [io  0x0cd0-0x0cd1] has been reserved
[    1.272013] system 00:08: [io  0x0cd2-0x0cd3] has been reserved
[    1.278028] system 00:08: [io  0x0cd4-0x0cd5] has been reserved
[    1.284019] system 00:08: [io  0x0cd6-0x0cd7] has been reserved
[    1.290039] system 00:08: [io  0x0cd8-0x0cdf] has been reserved
[    1.296024] system 00:08: [io  0x0800-0x089f] could not be reserved
[    1.302390] system 00:08: [io  0x0b20-0x0b3f] has been reserved
[    1.308414] system 00:08: [io  0x0900-0x090f] has been reserved
[    1.314436] system 00:08: [io  0x0910-0x091f] has been reserved
[    1.320452] system 00:08: [io  0xfe00-0xfefe] has been reserved
[    1.327701] system 00:08: [mem 0xfec00000-0xfec00fff] could not be reserved
[    1.334762] system 00:08: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.341478] system 00:08: [mem 0xfed80000-0xfed8ffff] has been reserved
[    1.348195] system 00:08: [mem 0xfed61000-0xfed70fff] has been reserved
[    1.354911] system 00:08: [mem 0xfec10000-0xfec10fff] has been reserved
[    1.361627] system 00:08: [mem 0xfed00000-0xfed00fff] could not be reserved
[    1.368684] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    1.375663] pnp: PnP ACPI: found 9 devices
[    1.387020] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.396025] pci 0000:00:03.1: PCI bridge to [bus 01]
[    1.401097] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    1.407295] pci 0000:00:03.1:   bridge window [mem 0xfea00000-0xfeafffff]
[    1.414184] pci 0000:00:03.1:   bridge window [mem 0xd0800000-0xd08fffff 64bit pref]
[    1.422037] pci 0000:00:14.4: PCI bridge to [bus 02]
[    1.427218] NET: Registered protocol family 2
[    1.432029] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    1.439199] TCP bind hash table entries: 2048 (order: 3, 32768 bytes)
[    1.445744] TCP: Hash tables configured (established 2048 bind 2048)
[    1.452213] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    1.458153] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    1.464573] NET: Registered protocol family 1
[    1.469051] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.632577] Unpacking initramfs...
[    2.373337] Freeing initrd memory: 21880K (ffff880031aa2000 - ffff880033000000)
[    2.380891] AMD-Vi: IOMMU performance counters supported
[    2.386513] pci 0000:00:00.2: can't derive routing for PCI INT A
[    2.392689] pci 0000:00:00.2: PCI INT A: not connected
[    2.398687] iommu: Adding device 0000:00:00.0 to group 0
[    2.404867] iommu: Adding device 0000:00:01.0 to group 1
[    2.410368] iommu: Using direct mapping for device 0000:00:01.0
[    2.416403] iommu: Adding device 0000:00:01.1 to group 1
[    2.422546] iommu: Adding device 0000:00:02.0 to group 2
[    2.428686] iommu: Adding device 0000:00:03.0 to group 3
[    2.434176] iommu: Adding device 0000:00:03.1 to group 3
[    2.440339] iommu: Adding device 0000:00:04.0 to group 4
[    2.446508] iommu: Adding device 0000:00:10.0 to group 5
[    2.451936] iommu: Adding device 0000:00:10.1 to group 5
[    2.458037] iommu: Adding device 0000:00:11.0 to group 6
[    2.464273] iommu: Adding device 0000:00:12.0 to group 7
[    2.469698] iommu: Adding device 0000:00:12.2 to group 7
[    2.475797] iommu: Adding device 0000:00:13.0 to group 8
[    2.481286] iommu: Adding device 0000:00:13.2 to group 8
[    2.487461] iommu: Adding device 0000:00:14.0 to group 9
[    2.492890] iommu: Adding device 0000:00:14.1 to group 9
[    2.498316] iommu: Adding device 0000:00:14.2 to group 9
[    2.503743] iommu: Adding device 0000:00:14.3 to group 9
[    2.509837] iommu: Adding device 0000:00:14.4 to group 10
[    2.516155] iommu: Adding device 0000:00:14.5 to group 11
[    2.522420] iommu: Adding device 0000:00:18.0 to group 12
[    2.527931] iommu: Adding device 0000:00:18.1 to group 12
[    2.533444] iommu: Adding device 0000:00:18.2 to group 12
[    2.538955] iommu: Adding device 0000:00:18.3 to group 12
[    2.544470] iommu: Adding device 0000:00:18.4 to group 12
[    2.549982] iommu: Adding device 0000:00:18.5 to group 12
[    2.555501] iommu: Adding device 0000:01:00.0 to group 3
[    2.560911] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    2.566325] AMD-Vi:  Extended features:  PPR GT IA PC
[    2.571666] AMD-Vi: Interrupt remapping enabled
[    2.576489] AMD-Vi: Lazy IO/TLB flushing enabled
[    2.581491] perf: AMD NB counters detected
[    2.585756] LVT offset 0 assigned for vector 0x400
[    2.590651] perf: AMD IBS detected (0x000001ff)
[    2.595290] perf: amd_iommu: Detected. (2 banks, 4 counters/bank)
[    2.602324] futex hash table entries: 256 (order: 2, 16384 bytes)
[    2.608583] audit: initializing netlink subsys (disabled)
[    2.614143] audit: type=2000 audit(1464159087.662:1): initialized
[    2.620971] Initialise system trusted keyring
[    2.625588] workingset: timestamp_bits=35 max_order=16 bucket_order=0
[    2.635221] zbud: loaded
[    2.638725] Key type big_key registered
[    2.738863] NET: Registered protocol family 38
[    2.743452] Key type asymmetric registered
[    2.747667] Asymmetric key parser 'x509' registered
[    2.752732] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    2.760326] io scheduler noop registered
[    2.764362] io scheduler deadline registered
[    2.768784] io scheduler cfq registered (default)
[    2.774140] pcieport 0000:00:03.1: Signaling PME through PCIe PME interrupt
[    2.781204] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    2.787847] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.793528] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.800384] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.808930] ACPI: Power Button [PWRB]
[    2.812754] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.820318] ACPI: Power Button [PWRF]
[    2.824102] AMD-Vi: Event logged [IO_PAGE_FAULT device=01:00.0 domain=0x0011 address=0x0000000000003580 flags=0x0020]
[    2.834893] AMD-Vi: Event logged [IO_PAGE_FAULT device=01:00.0 domain=0x0011 address=0x0000000000003580 flags=0x0000]
[    2.845681] AMD-Vi: Event logged [IO_PAGE_FAULT device=01:00.0 domain=0x0011 address=0x0000000000164000 flags=0x0020]
[    2.856735] GHES: HEST is not enabled!
[    2.860718] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.887770] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.895916] Non-volatile memory driver v1.3
[    2.900316] Linux agpgart interface v0.103
[    2.905353] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    2.913583] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    2.922598] scsi host0: ahci
[    2.925735] scsi host1: ahci
[    2.928853] scsi host2: ahci
[    2.931973] scsi host3: ahci
[    2.935059] ata1: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71100 irq 19
[    2.942587] ata2: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71180 irq 19
[    2.950117] ata3: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71200 irq 19
[    2.957649] ata4: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71280 irq 19
[    2.965415] libphy: Fixed MDIO Bus: probed
[    2.969726] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.976391] ehci-pci: EHCI PCI platform driver
[    2.981100] ehci-pci 0000:00:12.2: EHCI Host Controller
[    2.986481] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    2.994046] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    3.002881] ehci-pci 0000:00:12.2: debug port 1
[    3.007558] ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb6f000
[    3.019291] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    3.025246] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.032166] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.039524] usb usb1: Product: EHCI Host Controller
[    3.044507] usb usb1: Manufacturer: Linux 4.6.0-rc7+ ehci_hcd
[    3.050354] usb usb1: SerialNumber: 0000:00:12.2
[    3.055277] hub 1-0:1.0: USB hub found
[    3.059213] hub 1-0:1.0: 5 ports detected
[    3.063772] ehci-pci 0000:00:13.2: EHCI Host Controller
[    3.069167] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    3.076733] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    3.085571] ehci-pci 0000:00:13.2: debug port 1
[    3.090242] ehci-pci 0000:00:13.2: irq 17, io mem 0xfeb6d000
[    3.101292] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    3.107230] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.114144] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.121502] usb usb2: Product: EHCI Host Controller
[    3.126483] usb usb2: Manufacturer: Linux 4.6.0-rc7+ ehci_hcd
[    3.132325] usb usb2: SerialNumber: 0000:00:13.2
[    3.137260] hub 2-0:1.0: USB hub found
[    3.141195] hub 2-0:1.0: 5 ports detected
[    3.145588] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.151878] ohci-pci: OHCI PCI platform driver
[    3.156614] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    3.162358] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
[    3.170008] ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb70000
[    3.230421] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    3.237347] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.244670] usb usb3: Product: OHCI PCI host controller
[    3.249996] usb usb3: Manufacturer: Linux 4.6.0-rc7+ ohci_hcd
[    3.255845] usb usb3: SerialNumber: 0000:00:12.0
[    3.261259] hub 3-0:1.0: USB hub found
[    3.265137] hub 3-0:1.0: 5 ports detected
[    3.269767] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    3.275550] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 4
[    3.283101] ata1: SATA link down (SStatus 0 SControl 300)
[    3.288632] ata3: SATA link down (SStatus 0 SControl 300)
[    3.294171] ata2: SATA link down (SStatus 0 SControl 300)
[    3.299726] ohci-pci 0000:00:13.0: irq 18, io mem 0xfeb6e000
[    3.360406] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.367327] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.374658] usb usb4: Product: OHCI PCI host controller
[    3.381211] usb usb4: Manufacturer: Linux 4.6.0-rc7+ ohci_hcd
[    3.387058] usb usb4: SerialNumber: 0000:00:13.0
[    3.392192] hub 4-0:1.0: USB hub found
[    3.396098] hub 4-0:1.0: 5 ports detected
[    3.400620] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    3.406391] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 5
[    3.413958] ohci-pci 0000:00:14.5: irq 18, io mem 0xfeb6c000
[    3.456308] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.464538] ata4.00: ATA-8: ST31000524NS, SN12, max UDMA/133
[    3.470317] ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    3.481408] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.488330] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.495661] usb usb5: Product: OHCI PCI host controller
[    3.500992] usb usb5: Manufacturer: Linux 4.6.0-rc7+ ohci_hcd
[    3.506839] usb usb5: SerialNumber: 0000:00:14.5
[    3.511970] hub 5-0:1.0: USB hub found
[    3.515941] hub 5-0:1.0: 2 ports detected
[    3.520078] ata4.00: configured for UDMA/133
[    3.535610] uhci_hcd: USB Universal Host Controller Interface driver
[    3.542244] scsi 3:0:0:0: Direct-Access     ATA      ST31000524NS     SN12 PQ: 0 ANSI: 5
[    3.550706] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    3.556264] sd 3:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    3.564135] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    3.569605] sd 3:0:0:0: [sda] Write Protect is off
[    3.574583] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
[    3.582185] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.591608] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    3.600510] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
[    3.607405] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.614742] usb usb6: Product: xHCI Host Controller
[    3.619732] usb usb6: Manufacturer: Linux 4.6.0-rc7+ xhci-hcd
[    3.625577] usb usb6: SerialNumber: 0000:00:10.0
[    3.630323]  sda: sda1 sda2
[    3.633248] tsc: Refined TSC clocksource calibration: 3693.282 MHz
[    3.639529] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a7918f751d, max_idle_ns: 881590915016 ns
[    3.649900] sd 3:0:0:0: [sda] Attached SCSI disk
[    3.655433] hub 6-0:1.0: USB hub found
[    3.659336] hub 6-0:1.0: 2 ports detected
[    3.663630] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    3.668996] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 7
[    3.676547] usb usb7: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.684744] usb 3-3: new low-speed USB device number 2 using ohci-pci
[    3.691308] usb usb7: New USB device found, idVendor=1d6b, idProduct=0003
[    3.698193] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.705513] usb usb7: Product: xHCI Host Controller
[    3.710491] usb usb7: Manufacturer: Linux 4.6.0-rc7+ xhci-hcd
[    3.716332] usb usb7: SerialNumber: 0000:00:10.0
[    3.721201] hub 7-0:1.0: USB hub found
[    3.725125] hub 7-0:1.0: 2 ports detected
[    3.729565] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    3.734936] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 8
[    3.753560] xhci_hcd 0000:00:10.1: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    3.762255] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[    3.769143] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.776469] usb usb8: Product: xHCI Host Controller
[    3.781445] usb usb8: Manufacturer: Linux 4.6.0-rc7+ xhci-hcd
[    3.787288] usb usb8: SerialNumber: 0000:00:10.1
[    3.792181] hub 8-0:1.0: USB hub found
[    3.796084] hub 8-0:1.0: 2 ports detected
[    3.800345] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    3.805711] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 9
[    3.813275] usb usb9: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.821487] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[    3.828344] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.835673] usb usb9: Product: xHCI Host Controller
[    3.840647] usb usb9: Manufacturer: Linux 4.6.0-rc7+ xhci-hcd
[    3.846489] usb usb9: SerialNumber: 0000:00:10.1
[    3.851387] hub 9-0:1.0: USB hub found
[    3.855282] hub 9-0:1.0: 2 ports detected
[    3.859543] usbcore: registered new interface driver usbserial
[    3.865520] usbcore: registered new interface driver usbserial_generic
[    3.872172] usbserial: USB Serial support registered for generic
[    3.878343] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    3.885762] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.890839] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.896202] mousedev: PS/2 mouse device common for all mice
[    3.902197] rtc_cmos 00:06: RTC can wake from S4
[    3.907065] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    3.913334] rtc_cmos 00:06: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    3.921195] device-mapper: uevent: version 1.0.3
[    3.926051] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    3.935183] hidraw: raw HID events driver (C) Jiri Kosina
[    3.940798] usbcore: registered new interface driver usbhid
[    3.946521] usbhid: USB HID core driver
[    3.950604] drop_monitor: Initializing network drop monitor service
[    3.957021] usb 3-3: New USB device found, idVendor=413c, idProduct=2105
[    3.963839] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.971077] usb 3-3: Product: Dell USB Keyboard
[    3.975712] usb 3-3: Manufacturer: Dell
[    3.979875] ip_tables: (C) 2000-2006 Netfilter Core Team
[    3.985350] Initializing XFRM netlink socket
[    3.989970] NET: Registered protocol family 10
[    3.994891] mip6: Mobile IPv6
[    3.998059] NET: Registered protocol family 17
[    4.002748] mce: Unable to init device /dev/mcelog (rc: -5)
[    4.008797] microcode: CPU0: patch_level=0x06003104
[    4.013861] microcode: Microcode Update Driver: v2.01 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    4.022847] ... APIC ID:      13000000 (13)
[    4.027124] ... APIC VERSION: 80050010
[    4.030973] 0000000000000000000000000000000000000000000000000000000000000000
[    4.038425] 0000000000000000000000000000000000000000000000000000000000000000
[    4.045875] 0000000010000000000000000000000000000000000000000000000200008000
[    4.053322] 
[    4.054912] testing the IO APIC.......................
[    4.060500] .................................... done.
[    4.065927] AVX version of gcm_enc/dec engaged.
[    4.070577] AES CTR mode by8 optimization enabled
[    4.100205] input: Dell Dell USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb3/3-3/3-3:1.0/0003:413C:2105.0001/input/input5
[    4.134391] registered taskstats version 1
[    4.138659] Loading compiled-in X.509 certificates
[    4.145876] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[    4.155167] Loaded X.509 cert 'Build time autogenerated kernel key: 0e2826147936663a5ac6eeec89769acff5dfb9ef'
[    4.165379] hid-generic 0003:413C:2105.0001: input,hidraw0: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] on usb-0000:00:12.0-3/input0
[    4.177819] zswap: loaded using pool lzo/zbud
[    4.182918]   Magic number: 0:845:873
[    4.186810] rtc_cmos 00:06: setting system clock to 2016-05-25 06:51:31 UTC (1464159091)
[    4.206144] hpet1: lost 16 rtc interrupts
[    4.212811] Freeing unused kernel memory: 1536K (ffffffff81d45000 - ffffffff81ec5000)
[    4.220813] Write protecting the kernel read-only data: 12288k
[    4.227069] Freeing unused kernel memory: 272K (ffff8800337bc000 - ffff880033800000)
[    4.238942] Freeing unused kernel memory: 908K (ffff880033b1d000 - ffff880033c00000)
[    4.250337] hpet1: lost 2 rtc interrupts
[    4.255762] random: systemd urandom read with 15 bits of entropy available
[    4.264221] systemd[1]: systemd 222 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GN)
[    4.282601] systemd[1]: Detected architecture x86-64.
[    4.287833] systemd[1]: Running in initial RAM disk.

Welcome to Fedora 23 (Twenty Three) dracut-043-60.git20150811.fc23 (Initramfs)!

[    4.302529] systemd[1]: Set hostname to <dhcp-129-10.nay.redhat.com>.
[    4.333151] usb 3-4: new low-speed USB device number 3 using ohci-pci
[    4.391347] hpet1: lost 4 rtc interrupts
[  OK  ] Reached target Local File Systems.
[    4.402467] systemd[1]: Reached target Local File Systems.
[    4.408148] systemd[1]: Starting Local File Systems.
[    4.413401] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    4.421449] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[    4.429685] hpet1: lost 1 rtc interrupts
[  OK  ] Reached target Timers.
[    4.439468] systemd[1]: Reached target Timers.
[    4.444104] systemd[1]: Starting Timers.
[  OK  ] Reached target Paths.
[    4.453462] systemd[1]: Reached target Paths.
[    4.457993] systemd[1]: Starting Paths.
[  OK  ] Reached target Swap.
[    4.467467] systemd[1]: Reached target Swap.
[    4.471915] systemd[1]: Starting Swap.
[  OK  ] Created slice -.slice.
[    4.481491] systemd[1]: Created slice -.slice.
[    4.486133] systemd[1]: Starting -.slice.
[  OK  ] Listening on Journal Socket.
[    4.495461] systemd[1]: Listening on Journal Socket.
[    4.500625] systemd[1]: Starting Journal Socket.
[  OK  ] Created slice System Slice.
[    4.510503] systemd[1]: Created slice System Slice.
[    4.515582] systemd[1]: Starting System Slice.
[    4.520500] systemd[1]: Started Load Kernel Modules.
[    4.526824] usb 3-4: New USB device found, idVendor=17ef, idProduct=6050
[    4.533635] usb 3-4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    4.540868] usb 3-4: Product: Lenovo Precision USB Mouse
[    4.547183] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[    4.560538] systemd[1]: Started dracut ask for additional cmdline parameters.
[    4.568326] input: Lenovo Precision USB Mouse as /devices/pci0000:00/0000:00:12.0/usb3/3-4/3-4:1.0/0003:17EF:6050.0002/input/input6
[    4.581367] systemd[1]: Starting dracut cmdline hook...
[    4.586852] hid-generic 0003:17EF:6050.0002: input,hidraw1: USB HID v1.11 Mouse [Lenovo Precision USB Mouse] on usb-0000:00:12.0-4/input0
         Starting dracut cmdline hook...
[  OK  ] Listening on Journal Audit Socket.
[    4.614241] systemd[1]: Listening on Journal Audit Socket.
[    4.623220] systemd[1]: Starting Journal Audit Socket.
[  OK  ] Listening on udev Kernel Socket.
[    4.640226] systemd[1]: Listening on udev Kernel Socket.
[    4.649183] systemd[1]: Starting udev Kernel Socket.
[    4.656169] clocksource: Switched to clocksource tsc
[  OK  ] Listening on udev Control Socket.
[    4.670244] systemd[1]: Listening on udev Control Socket.
[    4.679119] systemd[1]: Starting udev Control Socket.
[  OK  ] Reached target Slices.
[    4.694247] systemd[1]: Reached target Slices.
[    4.701117] systemd[1]: Starting Slices.
[  OK  ] Listening on Journal Socket (/dev/log).
[    4.715257] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.725127] systemd[1]: Starting Journal Socket (/dev/log).
[    4.737737] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[  OK  ] Reached target Sockets.
[    4.761248] systemd[1]: Reached target Sockets.
[    4.770129] systemd[1]: Starting Sockets.
[    4.785875] systemd[1]: Starting Create list of required static device nodes for the current kernel...
         Starting Create list of required st... nodes for the current kernel...
[  OK  ] Started Apply Kernel Variables.
[    4.832230] systemd[1]: Started Apply Kernel Variables.
[    4.843226] audit: type=1130 audit(1464159092.155:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="system'
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[    4.913270] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    4.929168] audit: type=1130 audit(1464159092.241:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="sys'
[  OK  ] Started dracut cmdline hook.
[    4.961415] systemd[1]: Started dracut cmdline hook.
[    4.966613] audit: type=1130 audit(1464159092.279:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="system'
[  OK  ] Started Journal Service.
[    4.992411] systemd[1]: Started Journal Service.
[    4.997338] audit: type=1130 audit(1464159092.309:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="syst'
         Starting dracut pre-udev hook...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Create Static Device Nodes in /dev.
[    5.045321] audit: type=1130 audit(1464159092.357:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev '
[  OK  ] Started dracut pre-udev hook.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
         Mounting Configuration File System...
[  OK  ] Mounted Configuration File System.
[  OK  ] Started udev Coldplug all Devices.
         Starting dracut initqueue hook...
[  OK  ] Reached target System Initialization.
[  OK  ] Reached target Basic System.
[    5.339659] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    5.346228] [drm] Initialized drm 1.1.0 20060810
[    5.359767] r8169 0000:01:00.0 eth0: RTL8168evl/8111evl at 0xffffc900000fe000, fc:aa:14:c0:c2:7e, XID 0c900880 IRQ 31
[    5.370545] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    5.490181] [drm] radeon kernel modesetting enabled.
[    5.510470] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[    5.533611] Found CRAT image with size=1360
[    5.543162] Parsing CRAT table with 1 nodes
[    5.551105] Found CU entry in CRAT table with proximity_domain=0 caps=0
[    5.557881] CU CPU: cores=4 id_base=16
[    5.561736] Found CU entry in CRAT table with proximity_domain=0 caps=0
[    5.568444] CU GPU: simds=32 id_base=-2147483648
[    5.573158] Found memory entry in CRAT table with proximity_domain=0
[    5.608494] Found memory entry in CRAT table with proximity_domain=0
[    5.615244] Found cache entry in CRAT table with processor_id=16
[    5.621559] Found cache entry in CRAT table with processor_id=16
[    5.627925] Found cache entry in CRAT table with processor_id=16
[    5.634291] Found cache entry in CRAT table with processor_id=17
[    5.640365] Found cache entry in CRAT table with processor_id=18
[    5.646471] Found cache entry in CRAT table with processor_id=18
[    5.652570] Found cache entry in CRAT table with processor_id=18
[    5.658685] Found cache entry in CRAT table with processor_id=19
[    5.664794] Found TLB entry in CRAT table (not processing)
[    5.670347] Found TLB entry in CRAT table (not processing)
[    5.675926] Found TLB entry in CRAT table (not processing)
[    5.681507] Found TLB entry in CRAT table (not processing)
[    5.687089] Found TLB entry in CRAT table (not processing)
[    5.692671] Found TLB entry in CRAT table (not processing)
[    5.698251] Found TLB entry in CRAT table (not processing)
[    5.703833] Found TLB entry in CRAT table (not processing)
[    5.709416] Found TLB entry in CRAT table (not processing)
[    5.714996] Found TLB entry in CRAT table (not processing)
[    5.720579] Creating topology SYSFS entries
[    5.728892] Finished initializing topology ret=0
[    5.733790] kfd kfd: Initialized module
[    5.739824] [drm] initializing kernel modesetting (KAVERI 0x1002:0x130F 0x1002:0x0123 0x00).
[    5.750669] [drm] register mmio base: 0xFEB00000
[    5.755455] [drm] register mmio size: 262144
[    5.759933] [drm] doorbell mmio base: 0xD0000000
[    5.764675] [drm] doorbell mmio size: 8388608
[    5.769300] ATOM BIOS: 113
[    5.772233] radeon 0000:00:01.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    5.781240] radeon 0000:00:01.0: GTT: 2048M 0x0000000040000000 - 0x00000000BFFFFFFF
[    5.789009] [drm] Detected VRAM RAM=1024M, BAR=256M
[    5.793992] [drm] RAM width 128bits DDR
[    5.798358] [TTM] Zone  kernel: Available graphics memory: 119752 kiB
[    5.804946] [TTM] Initializing pool allocator
[    5.809469] [TTM] Initializing DMA pool allocator
[    5.814475] [drm] radeon: 1024M of VRAM memory ready
[    5.819597] [drm] radeon: 2048M of GTT memory ready.
[    5.824859] [drm] Loading kaveri Microcode
[    5.829574] [drm] Internal thermal controller without fan control
[    5.837857] [drm] radeon: dpm initialized
[    5.845211] [drm] Found VCE firmware/feedback version 40.2.2 / 15!
[    5.851657] [drm] GART: num cpu pages 524288, num gpu pages 524288
[    5.875319] [drm] PCIE GART of 2048M enabled (table at 0x0000000000324000).
[    5.882573] radeon 0000:00:01.0: WB enabled
[    5.887244] radeon 0000:00:01.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffff8800322cac00
[    5.898165] radeon 0000:00:01.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffff8800322cac04
[    5.909052] radeon 0000:00:01.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffff8800322cac08
[    5.919933] radeon 0000:00:01.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffff8800322cac0c
[    5.930808] radeon 0000:00:01.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffff8800322cac10
[    5.942092] radeon 0000:00:01.0: fence driver on ring 5 use gpu addr 0x0000000000076c98 and cpu addr 0xffffc90000436c98
[    5.953992] radeon 0000:00:01.0: fence driver on ring 6 use gpu addr 0x0000000040000c18 and cpu addr 0xffff8800322cac18
[    5.964917] radeon 0000:00:01.0: fence driver on ring 7 use gpu addr 0x0000000040000c1c and cpu addr 0xffff8800322cac1c
[    5.976114] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    5.982890] [drm] Driver supports precise vblank timestamp query.
[    5.989238] radeon 0000:00:01.0: radeon: using MSI.
[    5.994425] [drm] radeon: irq initialized.
[    6.537517] [drm:cik_ring_test [radeon]] *ERROR* radeon: ring 0 test failed (scratch(0x3010C)=0xCAFEDEAD)
[    6.547217] radeon 0000:00:01.0: disabling GPU acceleration
[    6.877171] [drm] Radeon Display Connectors
[    6.881486] [drm] Connector 0:
[    6.884602] [drm]   DVI-D-1
[    6.887459] [drm]   HPD3
[    6.890052] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
[    6.897537] [drm]   Encoders:
[    6.900564] [drm]     DFP2: INTERNAL_UNIPHY2
[    6.904889] [drm] Connector 1:
[    6.907997] [drm]   HDMI-A-1
[    6.910937] [drm]   HPD1
[    6.913528] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
[    6.921014] [drm]   Encoders:
[    6.924041] [drm]     DFP1: INTERNAL_UNIPHY
[    6.928279] [drm] Connector 2:
[    6.931388] [drm]   VGA-1
[    6.934069] [drm]   HPD2
[    6.936659] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
[    6.944145] [drm]   Encoders:
[    6.947172] [drm]     CRT1: INTERNAL_UNIPHY3
[    6.951499] [drm]     CRT1: NUTMEG
[    7.056990] [drm] fb mappable at 0xC0725000
[    7.061299] [drm] vram apper at 0xC0000000
[    7.065463] [drm] size 5242880
[    7.068576] [drm] fb depth is 24
[    7.071860] [drm]    pitch is 5120
[    7.076478] fbcon: radeondrmfb (fb0) is primary device
[    7.139790] Console: switching to colour frame buffer device 160x64
[    7.156764] radeon 0000:00:01.0: fb0: radeondrmfb frame buffer device
[    7.172347] ACPI Error: [\_SB_.ALIB] Namespace lookup failure, AE_NOT_FOUND (20160108/psargs-359)
[    7.181360] ACPI Error: Method parse/execution failed [\_SB.PCI0.VGA.ATC0] (Node ffff880030cc1028), AE_NOT_FOUND (20160108/psparse-542)
[    7.193765] ACPI Error: Method parse/execution failed [\_SB.PCI0.VGA.ATCS] (Node ffff880030cc1000), AE_NOT_FOUND (20160108/psparse-542)
[    7.210347] ------------[ cut here ]------------
[    7.215068] WARNING: CPU: 0 PID: 298 at drivers/gpu/drm/radeon/radeon_gart.c:293 radeon_gart_bind+0xe3/0xf0 [radeon]
[    7.225647] trying to bind memory to uninitialized GART !
[    7.231082] Modules linked in: pata_atiixp(+) amdkfd amd_iommu_v2 radeon(+) i2c_algo_bit drm_kms_helper ttm r8169 drm mii
[    7.242401] CPU: 0 PID: 298 Comm: systemd-udevd Not tainted 4.6.0-rc7+ #34
[    7.249316] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88X-D3H, BIOS F5 05/28/2014
[    7.259395]  0000000000000286 00000000df735c6c ffff880032c0f550 ffffffff813c452e
[    7.266935]  ffff880032c0f5a0 0000000000000000 ffff880032c0f590 ffffffff810a325b
[    7.274449]  0000012500000005 ffff880032c0f778 0000000000000007 ffff880032c0f778
[    7.281981] Call Trace:
[    7.284456]  [<ffffffff813c452e>] dump_stack+0x63/0x85
[    7.289623]  [<ffffffff810a325b>] __warn+0xcb/0xf0
[    7.294439]  [<ffffffff810a32df>] warn_slowpath_fmt+0x5f/0x80
[    7.300264]  [<ffffffffa00d58a3>] radeon_gart_bind+0xe3/0xf0 [radeon]
[    7.306784]  [<ffffffffa00d2d48>] radeon_ttm_backend_bind+0x68/0x270 [radeon]
[    7.314007]  [<ffffffffa00d3035>] ? radeon_ttm_tt_populate+0xe5/0x2d0 [radeon]
[    7.321274]  [<ffffffffa0059cba>] ttm_tt_bind+0x4a/0x70 [ttm]
[    7.327080]  [<ffffffffa005bfbd>] ttm_bo_handle_move_mem+0x5cd/0x650 [ttm]
[    7.334030]  [<ffffffffa005c6b7>] ? ttm_bo_mem_space+0x137/0x3b0 [ttm]
[    7.340621]  [<ffffffffa005cdc0>] ttm_bo_validate+0x1f0/0x210 [ttm]
[    7.346954]  [<ffffffffa005d0b9>] ttm_bo_init+0x2d9/0x420 [ttm]
[    7.352975]  [<ffffffffa00d40cb>] radeon_bo_create+0x19b/0x250 [radeon]
[    7.359670]  [<ffffffffa00d3c00>] ? radeon_update_memory_usage.isra.3+0x50/0x50 [radeon]
[    7.367853]  [<ffffffffa01a3479>] alloc_gtt_mem+0x99/0x250 [radeon]
[    7.374164]  [<ffffffffa025b276>] kgd2kfd_device_init+0x86/0x480 [amdkfd]
[    7.381060]  [<ffffffffa01a37a9>] radeon_kfd_device_init+0x89/0xb0 [radeon]
[    7.388106]  [<ffffffffa00b954a>] radeon_driver_load_kms+0x14a/0x220 [radeon]
[    7.395303]  [<ffffffffa000e4e7>] drm_dev_register+0xa7/0xb0 [drm]
[    7.401543]  [<ffffffffa0010a7d>] drm_get_pci_dev+0x8d/0x1e0 [drm]
[    7.407817]  [<ffffffffa00b5417>] radeon_pci_probe+0xd7/0x100 [radeon]
[    7.414382]  [<ffffffff814117e5>] local_pci_probe+0x45/0xa0
[    7.420016]  [<ffffffff81412bcd>] pci_device_probe+0xfd/0x140
[    7.425834]  [<ffffffff814fde7c>] driver_probe_device+0x22c/0x440
[    7.431996]  [<ffffffff814fe161>] __driver_attach+0xd1/0xf0
[    7.439467]  [<ffffffff814fe090>] ? driver_probe_device+0x440/0x440
[    7.447605]  [<ffffffff814fb7cc>] bus_for_each_dev+0x6c/0xc0
[    7.455166]  [<ffffffff814fd55e>] driver_attach+0x1e/0x20
[    7.462474]  [<ffffffff814fcffb>] bus_add_driver+0x1eb/0x280
[    7.470046]  [<ffffffff814fea90>] driver_register+0x60/0xe0
[    7.477525]  [<ffffffff8141112c>] __pci_register_driver+0x4c/0x50
[    7.485566]  [<ffffffffa0010cb0>] drm_pci_init+0xe0/0x110 [drm]
[    7.493401]  [<ffffffffa0226000>] ? 0xffffffffa0226000
[    7.500457]  [<ffffffffa0226098>] radeon_init+0x98/0xad [radeon]
[    7.508347]  [<ffffffff81002123>] do_one_initcall+0xb3/0x200
[    7.515857]  [<ffffffff817af198>] ? preempt_schedule_common+0x18/0x30
[    7.524220]  [<ffffffff817af1cc>] ? _cond_resched+0x1c/0x30
[    7.531712]  [<ffffffff81216819>] ? kmem_cache_alloc_trace+0x189/0x1f0
[    7.540203]  [<ffffffff811f78ee>] ? vfree+0x2e/0x70
[    7.547022]  [<ffffffff811aded2>] ? do_init_module+0x27/0x1d7
[    7.554695]  [<ffffffff811adf0a>] do_init_module+0x5f/0x1d7
[    7.562199]  [<ffffffff8112aa84>] load_module+0x20c4/0x26f0
[    7.569690]  [<ffffffff811273c0>] ? __symbol_put+0x60/0x60
[    7.577118]  [<ffffffff81239e64>] ? vfs_read+0x114/0x130
[    7.584368]  [<ffffffff8112b326>] SYSC_finit_module+0xe6/0x120
[    7.592085]  [<ffffffff8112b37e>] SyS_finit_module+0xe/0x10
[    7.599614]  [<ffffffff81003d92>] do_syscall_64+0x62/0x110
[    7.607049]  [<ffffffff817b3161>] entry_SYSCALL64_slow_path+0x25/0x25
[    7.615509] ---[ end trace f7b5b4469c50f04a ]---
[    7.622110] [drm:radeon_ttm_backend_bind [radeon]] *ERROR* failed to bind 964 pages at 0x00312000
[    7.634405] radeon 0000:00:01.0: failed to allocate BO for amdkfd (-22)
[    7.643013] kfd kfd: Could not allocate 3944480 bytes for device (1002:130f)
[    7.652080] [drm] Initialized radeon 2.43.0 20080528 for 0000:00:01.0 on minor 0
[    7.669135] scsi host4: pata_atiixp
[    7.684110] scsi host5: pata_atiixp
[    7.694181] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf100 irq 14
[    7.703088] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf108 irq 15
[    7.910432] ata6.00: ATAPI: PIONEER DVD-ROM DVD-232, 1.00, max UDMA/100
[    7.918872] ata6.00: limited to UDMA/33 due to 40-wire cable
[    7.984408] r8169 0000:01:00.0 enp1s0: renamed from eth0
[    7.998448] ata6.00: configured for UDMA/33
[    8.025692] scsi 5:0:0:0: CD-ROM            PIONEER  DVD-ROM DVD-232  1.00 PQ: 0 ANSI: 5
[    8.083604] sr 5:0:0:0: [sr0] scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
[    8.092668] cdrom: Uniform CD-ROM driver Revision: 3.20
[    8.114216] sr 5:0:0:0: Attached scsi generic sg1 type 5
[    8.466612] random: nonblocking pool is initialized
[    8.656390] hpet_rtc_timer_reinit: 9 callbacks suppressed
[    8.663575] hpet1: lost 204 rtc interrupts
[  OK  ] Found device /dev/mapper/fedora_dhcp--129--10-root.
[    8.686172] hpet1: lost 1 rtc interrupts
[    8.794017] hpet1: lost 5 rtc interrupts
[  OK  ] Started dracut initqueue hook.
[    8.808024] audit: type=1130 audit(1464159096.120:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="sys'
[    8.835816] hpet1: lost 1 rtc interrupts
         Starting File System Check on /dev/mapper/fedora_dhcp--129--10-root...
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[    8.888920] hpet1: lost 2 rtc interrupts
[  OK  ] Started File System Check on /dev/mapper/fedora_dhcp--129--10-root.
[    8.905613] audit: type=1130 audit(1464159096.218:11): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-fsck-root comm="sy'
         Mounting /sysroot...
[    8.988028] SGI XFS with ACLs, security attributes, no debug enabled
[    9.004337] XFS (dm-0): Mounting V5 Filesystem
[    9.128906] XFS (dm-0): Starting recovery (logdev: internal)
[    9.607280] XFS (dm-0): Ending recovery (logdev: internal)
[    9.615877] hpet1: lost 41 rtc interrupts
[  OK  ] Mounted /sysroot.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[    9.738684] hpet1: lost 2 rtc interrupts
[  OK  ] Started Reload Configuration from the Real Root.
[    9.753973] audit: type=1130 audit(1464159097.066:12): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="sys'
[  OK  ] Reached target Initrd File Systems.
[  OK  ] Reached target Initrd Default Target.
         Starting dracut pre-pivot and cleanup hook...
[  OK  ] Started dracut pre-pivot and cleanup hook.
         Starting Kdump Vmcore Save Service...
kdump: dump target is /dev/mapper/fedora_dhcp--129--10-root
kdump: saving to /sysroot//var/crash/127.0.0.1-2016-05-25-14:51:37/
kdump: saving vmcore-dmesg.txt
kdump: saving vmcore-dmesg.txt complete
kdump: saving vmcore
Copying data                       : [100.0 %] |
kdump: saving vmcore complete
[  OK  ] Stopped target Timers.
[  OK  ] Stopped Kdump Vmcore Save Service.
[  OK  ] Stopped dracut pre-pivot and cleanup hook.
         Stopping dracut pre-pivot and cleanup hook...
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped target Remote File Systems (Pre).
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Initrd Root File System.
[  OK  ] Stopped target Initrd File Systems.
         Starting Cleaning Up and Shutting Down Daemons...
[   11.423770] XFS (dm-0): Unmounting Filesystem
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target System Initialization.
[  OK  ] Stopped target Swap.
[  OK  ] Stopped Create Static Device Nodes in /dev.
         Stopping Create Static Device Nodes in /dev...
[  OK  ] Stopped Apply Kernel Variables.
         Stopping Apply Kernel Variables...
[  OK  ] Stopped target Local File Systems.
         Unmounting /sysroot...
[  OK  ] Stopped target Slices.
[  OK  ] Removed slice -.slice.
[  OK  ] Stopped target Sockets.
[  OK  ] Stopped target Paths.
[  OK  ] Reached target Shutdown.
[FAILED] Failed to start Cleaning Up and Shutting Down Daemons.
See 'systemctl status initrd-cleanup.service' for details.
[  OK  ] Unmounted /sysroot.
[  OK  ] Reached target Unmount All Filesystems.
[  OK  ] Reached target Final Step.
         Starting Re[   11.518541] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
boot...
[   11.533504] systemd-journald[214]: Received SIGTERM from PID 1 (systemd-shutdow).
[   11.544593] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[   11.557583] systemd-shutdown[1]: Unmounting file systems.
[   11.565360] systemd-shutdown[1]: All filesystems unmounted.
[   11.573048] systemd-shutdown[1]: Deactivating swaps.
[   11.580193] systemd-shutdown[1]: All swaps deactivated.
[   11.587560] systemd-shutdown[1]: Detaching loop devices.
[   11.595103] systemd-shutdown[1]: All loop devices detached.
[   11.602809] systemd-shutdown[1]: Detaching DM devices.
[   11.610638] systemd-shutdown[1]: Detaching DM 253:1.
[   11.623498] systemd-shutdown[1]: Detaching DM 253:0.
[   11.634492] systemd-shutdown[1]: All DM devices detached.
[   11.642453] systemd-shutdown[1]: Rebooting.
[   11.650558] sd 3:0:0:0: [sda] Synchronizing SCSI cache
[   11.660588] reboot: Restarting system
[   11.666300] reboot: machine restart


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--2oS5YaxWCcQjTEyO--
