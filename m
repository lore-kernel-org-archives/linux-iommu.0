From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [Linux-4.19] ThinkPad T470 not booting with "intel_iommu=on"
Date: Tue, 25 Sep 2018 13:57:23 +0200
Message-ID: <20180925115723.mf7njwpcmykbkpsu@8bytes.org>
References: <CA+icZUXnB2LbB-X_pQeM=OQDEVcWQdUr9TLbG1cXnpwuTe=mNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+icZUXnB2LbB-X_pQeM=OQDEVcWQdUr9TLbG1cXnpwuTe=mNw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Lu,

can you please have a look at this problem?

On Wed, Sep 05, 2018 at 02:04:38PM +0200, Sedat Dilek wrote:
> Hi Joerg,
> 
> "intel_ioomu=on" was working fine here on my ThinkPad T470 with
> debian/testing AMD64 with Linux v4.17.y and v4.18.y.
> 
> With testing Linux v4.19-rc1 and v4.19-rc2 my machine is not booting -
> black screen.
> These kernels are built with LLVM/Clang v7.0.0rc2 (v4.18.y too).
> 
> Furthermore, I switched from GRUB to systemd-boot v239.
> 
> [ /boot/efi/loader/entries/debian.conf ]
> 
> title Debian GNU/Linux buster/sid [ debian kernel ]
> linux /vmlinuz-4.17.0-3-amd64
> initrd /initrd.img-4.17.0-3-amd64
> options root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro intel_iommu=on
> 
> [ /boot/efi/loader/entries/debian-llvmlinux.conf ]
> 
> title Debian GNU/Linux buster/sid [ llvmlinux kernel (EXPERIMENTAL) ]
> linux /vmlinuz-4.19.0-rc2-3-iniza-llvmlinux
> initrd /initrd.img-4.19.0-rc2-3-iniza-llvmlinux
> options root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro
> 
> Any hints or hints to debug this?
> Any other kernel boot cheats [1] I can try?
> 
> My kernel-config and dmesg output is attached.
> 
> Thanks in advance.
> 
> Regards,
> - Sedat -
> 
> 
> Documentation/intel_txt.txt
> Documentation/admin-guide/kernel-parameters.txt
> Documentation/Intel-IOMMU.txt
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n1645
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/Intel-IOMMU.txt
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/intel_txt.txt

> [    0.000000] microcode: microcode updated early to revision 0x8e, date = 2018-03-24
> [    0.000000] Linux version 4.19.0-rc2-3-iniza-llvmlinux (sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org@iniza) (clang version 7.0.0 (https://github.com/llvm-mirror/clang.git 1e368d3a364d4dc7f3279727abe01dbe5e4b947c) (https://github.com/llvm-mirror/llvm.git 8be5c4fc9a8f2bb3f77d5175e021fcc350d6236a)) #1 SMP 2018-09-04
> [    0.000000] Command line: initrd=\initrd.img-4.19.0-rc2-3-iniza-llvmlinux root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008505dfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000008505e000-0x000000008505efff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000008505f000-0x000000008505ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000085060000-0x000000008e99cfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000008e99d000-0x000000008ff2cfff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000008ff2d000-0x000000008ff99fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000008ff9a000-0x000000008fffefff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000008ffff000-0x000000008fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000090000000-0x0000000097ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000098600000-0x000000009c7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f3ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004627fffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] efi: EFI v2.50 by Lenovo
> [    0.000000] efi:  SMBIOS=0x8f099000  SMBIOS 3.0=0x8f096000  ACPI=0x8fffe000  ACPI 2.0=0x8fffe014  ESRT=0x8ef63000  MEMATTR=0x89828298  TPMEventLog=0x85196018 
> [    0.000000] SMBIOS 3.0.0 present.
> [    0.000000] DMI: LENOVO 20HDCTO1WW/20HDCTO1WW, BIOS N1QET68W (1.43 ) 11/10/2017
> [    0.000000] tsc: Detected 2900.000 MHz processor
> [    0.002007] tsc: Detected 2904.000 MHz TSC
> [    0.002008] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.002013] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.002026] last_pfn = 0x462800 max_arch_pfn = 0x400000000
> [    0.002033] MTRR default type: write-back
> [    0.002035] MTRR fixed ranges enabled:
> [    0.002037]   00000-9FFFF write-back
> [    0.002039]   A0000-BFFFF uncachable
> [    0.002041]   C0000-FFFFF write-protect
> [    0.002042] MTRR variable ranges enabled:
> [    0.002045]   0 base 00C0000000 mask 7FC0000000 uncachable
> [    0.002046]   1 base 00A0000000 mask 7FE0000000 uncachable
> [    0.002048]   2 base 009C000000 mask 7FFC000000 uncachable
> [    0.002049]   3 base 009A000000 mask 7FFE000000 uncachable
> [    0.002050]   4 disabled
> [    0.002051]   5 disabled
> [    0.002052]   6 disabled
> [    0.002053]   7 disabled
> [    0.002054]   8 disabled
> [    0.002055]   9 disabled
> [    0.004477] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.006043] last_pfn = 0x90000 max_arch_pfn = 0x400000000
> [    0.030791] esrt: Reserving ESRT space from 0x000000008ef63000 to 0x000000008ef63088.
> [    0.030822] Base memory trampoline at [(____ptrval____)] 96000 size 28672
> [    0.030828] Using GB pages for direct mapping
> [    0.030832] BRK [0x36677b000, 0x36677bfff] PGTABLE
> [    0.030835] BRK [0x36677c000, 0x36677cfff] PGTABLE
> [    0.030836] BRK [0x36677d000, 0x36677dfff] PGTABLE
> [    0.030896] BRK [0x36677e000, 0x36677efff] PGTABLE
> [    0.030900] BRK [0x36677f000, 0x36677ffff] PGTABLE
> [    0.031200] BRK [0x366780000, 0x366780fff] PGTABLE
> [    0.031275] BRK [0x366781000, 0x366781fff] PGTABLE
> [    0.031512] BRK [0x366782000, 0x366782fff] PGTABLE
> [    0.031598] BRK [0x366783000, 0x366783fff] PGTABLE
> [    0.031703] Secure boot disabled
> [    0.031706] RAMDISK: [mem 0x7e3c9000-0x7fffefff]
> [    0.031724] ACPI: Early table checksum verification disabled
> [    0.031750] ACPI: RSDP 0x000000008FFFE014 000024 (v02 LENOVO)
> [    0.031758] ACPI: XSDT 0x000000008FFC2188 00010C (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031769] ACPI: FACP 0x000000008FFF5000 0000F4 (v05 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031778] ACPI: DSDT 0x000000008FFD0000 020C9B (v02 LENOVO SKL      00000000 INTL 20160527)
> [    0.031785] ACPI: FACS 0x000000008FF3D000 000040
> [    0.031790] ACPI: SSDT 0x000000008FFFC000 0003CC (v02 LENOVO Tpm2Tabl 00001000 INTL 20160527)
> [    0.031796] ACPI: TPM2 0x000000008FFFB000 000034 (v03 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031802] ACPI: UEFI 0x000000008FF53000 000042 (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031807] ACPI: SSDT 0x000000008FFF7000 003235 (v02 LENOVO SaSsdt   00003000 INTL 20160527)
> [    0.031814] ACPI: SSDT 0x000000008FFF6000 0005B6 (v02 LENOVO PerfTune 00001000 INTL 20160527)
> [    0.031819] ACPI: HPET 0x000000008FFF4000 000038 (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031825] ACPI: APIC 0x000000008FFF3000 0000BC (v03 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031830] ACPI: MCFG 0x000000008FFF2000 00003C (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031836] ACPI: ECDT 0x000000008FFF1000 000053 (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031842] ACPI: SSDT 0x000000008FFCF000 00021C (v01 LENOVO Rmv_Batt 00001000 INTL 20160527)
> [    0.031847] ACPI: SSDT 0x000000008FFCD000 00174F (v02 LENOVO ProjSsdt 00000010 INTL 20160527)
> [    0.031853] ACPI: BOOT 0x000000008FFCC000 000028 (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031859] ACPI: BATB 0x000000008FFCB000 00004A (v02 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031864] ACPI: SLIC 0x000000008FFCA000 000176 (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031870] ACPI: SSDT 0x000000008FFC8000 0017AE (v02 LENOVO CpuSsdt  00003000 INTL 20160527)
> [    0.031876] ACPI: SSDT 0x000000008FFC7000 00056D (v02 LENOVO CtdpB    00001000 INTL 20160527)
> [    0.031882] ACPI: SSDT 0x000000008FFC6000 000634 (v02 LENOVO UsbCTabl 00001000 INTL 20160527)
> [    0.031887] ACPI: WSMT 0x000000008FFC5000 000028 (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031893] ACPI: SSDT 0x000000008FFC4000 000141 (v02 LENOVO HdaDsp   00000000 INTL 20160527)
> [    0.031899] ACPI: SSDT 0x000000008FFC3000 0004C5 (v02 LENOVO TbtTypeC 00000000 INTL 20160527)
> [    0.031904] ACPI: DBGP 0x000000008FFFD000 000034 (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031910] ACPI: DBG2 0x000000008FFC1000 000054 (v00 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031916] ACPI: MSDM 0x000000008FFC0000 000055 (v03 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031921] ACPI: DMAR 0x000000008FFBF000 0000CC (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031927] ACPI: ASF! 0x000000008FFBE000 0000A0 (v32 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031933] ACPI: FPDT 0x000000008FFBD000 000044 (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031938] ACPI: BGRT 0x000000008FFBC000 000038 (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031944] ACPI: UEFI 0x000000008FF3A000 00013E (v01 LENOVO TP-N1Q   00001430 PTEC 00000002)
> [    0.031958] ACPI: Local APIC address 0xfee00000
> [    0.032103] No NUMA configuration found
> [    0.032106] Faking a node at [mem 0x0000000000000000-0x00000004627fffff]
> [    0.032113] NODE_DATA(0) allocated [mem 0x4627fb000-0x4627fffff]
> [    0.032170] Zone ranges:
> [    0.032172]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.032176]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.032179]   Normal   [mem 0x0000000100000000-0x00000004627fffff]
> [    0.032181]   Device   empty
> [    0.032184] Movable zone start for each node
> [    0.032185] Early memory node ranges
> [    0.032188]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
> [    0.032190]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
> [    0.032192]   node   0: [mem 0x0000000000100000-0x000000008505dfff]
> [    0.032194]   node   0: [mem 0x0000000085060000-0x000000008e99cfff]
> [    0.032195]   node   0: [mem 0x000000008ffff000-0x000000008fffffff]
> [    0.032197]   node   0: [mem 0x0000000100000000-0x00000004627fffff]
> [    0.032273] Reserved but unavailable: 5833 pages
> [    0.032276] Initmem setup node 0 [mem 0x0000000000001000-0x00000004627fffff]
> [    0.032281] On node 0 totalpages: 4133175
> [    0.032283]   DMA zone: 64 pages used for memmap
> [    0.032284]   DMA zone: 22 pages reserved
> [    0.032285]   DMA zone: 3995 pages, LIFO batch:0
> [    0.032363]   DMA32 zone: 9063 pages used for memmap
> [    0.032364]   DMA32 zone: 579996 pages, LIFO batch:63
> [    0.045381]   Normal zone: 55456 pages used for memmap
> [    0.045383]   Normal zone: 3549184 pages, LIFO batch:63
> [    0.108162] Reserving Intel graphics memory at [mem 0x9a800000-0x9c7fffff]
> [    0.108435] ACPI: PM-Timer IO Port: 0x1808
> [    0.108438] ACPI: Local APIC address 0xfee00000
> [    0.108447] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.108449] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.108450] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.108452] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.108454] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> [    0.108455] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> [    0.108457] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> [    0.108458] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> [    0.108495] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.108499] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.108501] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.108504] ACPI: IRQ0 used by override.
> [    0.108506] ACPI: IRQ9 used by override.
> [    0.108509] Using ACPI (MADT) for SMP configuration information
> [    0.108511] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.108525] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [    0.108550] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.108553] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
> [    0.108556] PM: Registered nosave memory: [mem 0x0009d000-0x000fffff]
> [    0.108559] PM: Registered nosave memory: [mem 0x8505e000-0x8505efff]
> [    0.108561] PM: Registered nosave memory: [mem 0x8505f000-0x8505ffff]
> [    0.108563] PM: Registered nosave memory: [mem 0x8e99d000-0x8ff2cfff]
> [    0.108565] PM: Registered nosave memory: [mem 0x8ff2d000-0x8ff99fff]
> [    0.108566] PM: Registered nosave memory: [mem 0x8ff9a000-0x8fffefff]
> [    0.108569] PM: Registered nosave memory: [mem 0x90000000-0x97ffffff]
> [    0.108571] PM: Registered nosave memory: [mem 0x98000000-0x985fffff]
> [    0.108572] PM: Registered nosave memory: [mem 0x98600000-0x9c7fffff]
> [    0.108574] PM: Registered nosave memory: [mem 0x9c800000-0xefffffff]
> [    0.108575] PM: Registered nosave memory: [mem 0xf0000000-0xf3ffffff]
> [    0.108577] PM: Registered nosave memory: [mem 0xf4000000-0xfe00ffff]
> [    0.108578] PM: Registered nosave memory: [mem 0xfe010000-0xfe010fff]
> [    0.108580] PM: Registered nosave memory: [mem 0xfe011000-0xffffffff]
> [    0.108583] [mem 0x9c800000-0xefffffff] available for PCI devices
> [    0.108585] Booting paravirtualized kernel on bare hardware
> [    0.108590] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.236503] random: get_random_bytes called from start_kernel+0x93/0x491 with crng_init=0
> [    0.236513] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
> [    0.237102] percpu: Embedded 44 pages/cpu @(____ptrval____) s142104 r8192 d29928 u524288
> [    0.237113] pcpu-alloc: s142104 r8192 d29928 u524288 alloc=1*2097152
> [    0.237114] pcpu-alloc: [0] 0 1 2 3 
> [    0.237162] Built 1 zonelists, mobility grouping on.  Total pages: 4068570
> [    0.237165] Policy zone: Normal
> [    0.237168] Kernel command line: initrd=\initrd.img-4.19.0-rc2-3-iniza-llvmlinux root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro
> [    0.249718] Calgary: detecting Calgary via BIOS EBDA area
> [    0.249720] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [    0.334885] Memory: 16090872K/16532700K available (12300K kernel code, 1060K rwdata, 2900K rodata, 1612K init, 656K bss, 441828K reserved, 0K cma-reserved)
> [    0.335064] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.335076] Kernel/User page tables isolation: enabled
> [    0.350427] ftrace: allocating 28706 entries in 113 pages
> [    0.373465] rcu: Hierarchical RCU implementation.
> [    0.373469] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
> [    0.373471] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.377946] NR_IRQS: 33024, nr_irqs: 1024, preallocated irqs: 16
> [    0.378501] Console: colour dummy device 80x25
> [    0.378839] console [tty0] enabled
> [    0.378868] ACPI: Core revision 20180810
> [    0.379505] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> [    0.379545] hpet clockevent registered
> [    0.379599] APIC: Switch to symmetric I/O mode setup
> [    0.379605] DMAR: Host address width 39
> [    0.379608] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> [    0.379621] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> [    0.379627] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> [    0.379637] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> [    0.379641] DMAR: RMRR base: 0x0000008f49f000 end: 0x0000008f4befff
> [    0.379646] DMAR: RMRR base: 0x0000009a000000 end: 0x0000009c7fffff
> [    0.379649] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
> [    0.379654] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> [    0.379658] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> [    0.379661] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> [    0.381530] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    0.381535] x2apic enabled
> [    0.381557] Switched APIC routing to cluster x2apic.
> [    0.385878] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.403565] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x29dc05e54fc, max_idle_ns: 440795291716 ns
> [    0.403573] Calibrating delay loop (skipped), value calculated using timer frequency.. 5808.00 BogoMIPS (lpj=11616000)
> [    0.403580] pid_max: default: 32768 minimum: 301
> [    0.404640] Security Framework initialized
> [    0.404645] Yama: becoming mindful.
> [    0.404695] AppArmor: AppArmor initialized
> [    0.408126] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
> [    0.410264] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> [    0.410346] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
> [    0.410412] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
> [    0.410769] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.410773] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
> [    0.410785] mce: CPU supports 8 MCE banks
> [    0.410803] CPU0: Thermal monitoring enabled (TM1)
> [    0.410835] process: using mwait in idle threads
> [    0.410841] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.410845] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    0.410849] Spectre V2 : Mitigation: Full generic retpoline
> [    0.410852] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.410856] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
> [    0.410860] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.410865] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    0.419032] Freeing SMP alternatives memory: 28K
> [    0.427693] TSC deadline timer enabled
> [    0.427700] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz (family: 0x6, model: 0x8e, stepping: 0x9)
> [    0.427849] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.427920] ... version:                4
> [    0.427923] ... bit width:              48
> [    0.427925] ... generic registers:      4
> [    0.427928] ... value mask:             0000ffffffffffff
> [    0.427931] ... max period:             00007fffffffffff
> [    0.427933] ... fixed-purpose events:   3
> [    0.427936] ... event mask:             000000070000000f
> [    0.428003] rcu: Hierarchical SRCU implementation.
> [    0.428915] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.428981] smp: Bringing up secondary CPUs ...
> [    0.429088] x86: Booting SMP configuration:
> [    0.429092] .... node  #0, CPUs:      #1 #2 #3
> [    0.433010] smp: Brought up 1 node, 4 CPUs
> [    0.433010] smpboot: Max logical packages: 1
> [    0.433010] smpboot: Total of 4 processors activated (23232.00 BogoMIPS)
> [    0.436165] devtmpfs: initialized
> [    0.436165] x86/mm: Memory block size: 128MB
> [    0.437716] PM: Registering ACPI NVS region [mem 0x8505e000-0x8505efff] (4096 bytes)
> [    0.437716] PM: Registering ACPI NVS region [mem 0x8ff2d000-0x8ff99fff] (446464 bytes)
> [    0.437716] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.437716] futex hash table entries: 1024 (order: 4, 65536 bytes)
> [    0.437716] pinctrl core: initialized pinctrl subsystem
> [    0.437716] NET: Registered protocol family 16
> [    0.437716] audit: initializing netlink subsys (disabled)
> [    0.437716] audit: type=2000 audit(1536066650.060:1): state=initialized audit_enabled=0 res=1
> [    0.437716] cpuidle: using governor ladder
> [    0.437716] cpuidle: using governor menu
> [    0.437716] Simple Boot Flag at 0x47 set to 0x1
> [    0.437716] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.437716] ACPI: bus type PCI registered
> [    0.437716] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.439604] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf0000000-0xf3ffffff] (base 0xf0000000)
> [    0.439623] PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in E820
> [    0.439658] PCI: Using configuration type 1 for base access
> [    0.441014] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.441014] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.441014] ACPI: Added _OSI(Module Device)
> [    0.441014] ACPI: Added _OSI(Processor Device)
> [    0.441014] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.441014] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.441014] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.441014] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.441014] ACPI: EC: EC started
> [    0.441014] ACPI: EC: interrupt blocked
> [    0.441014] ACPI: \: Used as first EC
> [    0.441014] ACPI: \: GPE=0x16, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.441014] ACPI: \: Used as boot ECDT EC to handle transactions
> [    0.522563] ACPI: 11 ACPI AML tables successfully acquired and loaded
> [    0.533649] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.546404] ACPI: Dynamic OEM Table Load:
> [    0.546435] ACPI: SSDT 0xFFFF8D364FC85000 0006F6 (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
> [    0.547275] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
> [    0.549023] ACPI: Dynamic OEM Table Load:
> [    0.549042] ACPI: SSDT 0xFFFF8D364FCF1000 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
> [    0.549824] ACPI: Dynamic OEM Table Load:
> [    0.549839] ACPI: SSDT 0xFFFF8D364FD86180 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
> [    0.550435] ACPI: Dynamic OEM Table Load:
> [    0.550450] ACPI: SSDT 0xFFFF8D364FC83000 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
> [    0.551659] ACPI: Dynamic OEM Table Load:
> [    0.551680] ACPI: SSDT 0xFFFF8D36520A4000 000D14 (v02 PmRef  ApIst    00003000 INTL 20160527)
> [    0.553410] ACPI: Dynamic OEM Table Load:
> [    0.553426] ACPI: SSDT 0xFFFF8D364FCF1C00 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
> [    0.554226] ACPI: Dynamic OEM Table Load:
> [    0.554241] ACPI: SSDT 0xFFFF8D364FCF0800 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
> [    0.556982] ACPI: Interpreter enabled
> [    0.557083] ACPI: (supports S0 S3 S4 S5)
> [    0.557086] ACPI: Using IOAPIC for interrupt routing
> [    0.557154] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.558120] ACPI: Enabled 7 GPEs in block 00 to 7F
> [    0.564124] ACPI: Power Resource [PUBS] (on)
> [    0.564509] acpi PNP0C0A:01: ACPI dock station (docks/bays count: 1)
> [    0.588178] ACPI: Power Resource [WRST] (on)
> [    0.588741] ACPI: Power Resource [WRST] (on)
> [    0.608860] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
> [    0.608887] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.609087] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER PCIeCapability]
> [    0.609181] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
> [    0.609186] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
> [    0.609190] acpi PNP0A08:00: _OSC: platform willing to grant [LTR]
> [    0.609193] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
> [    0.612850] PCI host bridge to bus 0000:00
> [    0.612859] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.612863] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.612867] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.612871] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
> [    0.612875] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
> [    0.612879] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
> [    0.612883] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
> [    0.612887] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
> [    0.612891] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
> [    0.612894] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
> [    0.612898] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
> [    0.612902] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> [    0.612906] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> [    0.612910] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
> [    0.612914] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
> [    0.612917] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
> [    0.612921] pci_bus 0000:00: root bus resource [mem 0x9c800000-0xefffffff window]
> [    0.612925] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> [    0.612930] pci_bus 0000:00: root bus resource [bus 00-3e]
> [    0.612946] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
> [    0.614352] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
> [    0.614372] pci 0000:00:02.0: reg 0x10: [mem 0xeb000000-0xebffffff 64bit]
> [    0.614383] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff 64bit pref]
> [    0.614390] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
> [    0.614415] pci 0000:00:02.0: BAR 2: assigned to efifb
> [    0.615882] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
> [    0.615913] pci 0000:00:14.0: reg 0x10: [mem 0xec220000-0xec22ffff 64bit]
> [    0.616011] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.617560] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
> [    0.617590] pci 0000:00:14.2: reg 0x10: [mem 0xec248000-0xec248fff 64bit]
> [    0.619131] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
> [    0.619395] pci 0000:00:15.0: reg 0x10: [mem 0xec249000-0xec249fff 64bit]
> [    0.621693] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
> [    0.621729] pci 0000:00:16.0: reg 0x10: [mem 0xec24a000-0xec24afff 64bit]
> [    0.621827] pci 0000:00:16.0: PME# supported from D3hot
> [    0.623309] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
> [    0.623419] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.624916] pci 0000:00:1c.6: [8086:9d16] type 01 class 0x060400
> [    0.625034] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
> [    0.626520] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
> [    0.626635] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.628132] pci 0000:00:1d.2: [8086:9d1a] type 01 class 0x060400
> [    0.628246] pci 0000:00:1d.2: PME# supported from D0 D3hot D3cold
> [    0.629742] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
> [    0.631326] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
> [    0.631346] pci 0000:00:1f.2: reg 0x10: [mem 0xec244000-0xec247fff]
> [    0.632793] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
> [    0.632830] pci 0000:00:1f.3: reg 0x10: [mem 0xec240000-0xec243fff 64bit]
> [    0.632872] pci 0000:00:1f.3: reg 0x20: [mem 0xec230000-0xec23ffff 64bit]
> [    0.632967] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    0.634445] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
> [    0.634502] pci 0000:00:1f.4: reg 0x10: [mem 0xec24b000-0xec24b0ff 64bit]
> [    0.634554] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
> [    0.636071] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
> [    0.636104] pci 0000:00:1f.6: reg 0x10: [mem 0xec200000-0xec21ffff]
> [    0.636239] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
> [    0.637755] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.638287] pci 0000:04:00.0: [8086:24fd] type 00 class 0x028000
> [    0.638439] pci 0000:04:00.0: reg 0x10: [mem 0xec100000-0xec101fff 64bit]
> [    0.639058] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> [    0.639239] pci 0000:04:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:1c.6 (capable of 7.876 Gb/s with 8 GT/s x1 link)
> [    0.640746] pci 0000:00:1c.6: PCI bridge to [bus 04]
> [    0.640755] pci 0000:00:1c.6:   bridge window [mem 0xec100000-0xec1fffff]
> [    0.640827] pci 0000:00:1d.0: PCI bridge to [bus 05-3d]
> [    0.640841] pci 0000:00:1d.0:   bridge window [mem 0xd4000000-0xea0fffff]
> [    0.640847] pci 0000:00:1d.0:   bridge window [mem 0xb0000000-0xd1ffffff 64bit pref]
> [    0.641137] pci 0000:3e:00.0: [17aa:0004] type 00 class 0x010802
> [    0.641176] pci 0000:3e:00.0: reg 0x10: [mem 0xec000000-0xec003fff 64bit]
> [    0.641365] pci 0000:3e:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8 GT/s x2 link at 0000:00:1d.2 (capable of 31.504 Gb/s with 8 GT/s x4 link)
> [    0.641581] pci 0000:00:1d.2: PCI bridge to [bus 3e]
> [    0.641589] pci 0000:00:1d.2:   bridge window [mem 0xec000000-0xec0fffff]
> [    0.645277] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.645383] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
> [    0.645482] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.645581] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.645678] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.645776] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.645874] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.645970] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.647838] ACPI: EC: interrupt unblocked
> [    0.647889] ACPI: EC: event unblocked
> [    0.647910] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x16, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.647915] ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to handle transactions and events
> [    0.648039] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=mem,locks=none
> [    0.648039] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.648039] pci 0000:00:02.0: vgaarb: setting as boot device
> [    0.648039] vgaarb: loaded
> [    0.648039] pps_core: LinuxPPS API ver. 1 registered
> [    0.648039] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> [    0.648039] PTP clock support registered
> [    0.648039] EDAC MC: Ver: 3.0.0
> [    0.648039] Registered efivars operations
> [    0.687820] PCI: Using ACPI for IRQ routing
> [    0.691681] PCI: pci_cache_line_size set to 64 bytes
> [    0.692114] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
> [    0.692117] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
> [    0.692119] e820: reserve RAM buffer [mem 0x8505e000-0x87ffffff]
> [    0.692120] e820: reserve RAM buffer [mem 0x8e99d000-0x8fffffff]
> [    0.692122] e820: reserve RAM buffer [mem 0x462800000-0x463ffffff]
> [    0.692317] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    0.692317] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> [    0.694275] clocksource: Switched to clocksource tsc-early
> [    0.707890] VFS: Disk quotas dquot_6.6.0
> [    0.707918] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.708080] AppArmor: AppArmor Filesystem Enabled
> [    0.708114] pnp: PnP ACPI init
> [    0.708430] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
> [    0.708437] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
> [    0.708441] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
> [    0.708446] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reserved
> [    0.708451] system 00:00: [mem 0xfe036000-0xfe03bfff] has been reserved
> [    0.708455] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
> [    0.708459] system 00:00: [mem 0xfe410000-0xfe7fffff] has been reserved
> [    0.708469] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.709061] system 00:01: [io  0xff00-0xfffe] has been reserved
> [    0.709070] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.710277] system 00:02: [io  0x0680-0x069f] has been reserved
> [    0.710282] system 00:02: [io  0xffff] has been reserved
> [    0.710287] system 00:02: [io  0xffff] has been reserved
> [    0.710291] system 00:02: [io  0xffff] has been reserved
> [    0.710295] system 00:02: [io  0x1800-0x18fe] has been reserved
> [    0.710299] system 00:02: [io  0x164e-0x164f] has been reserved
> [    0.710307] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.710499] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.710567] system 00:04: [io  0x1854-0x1857] has been reserved
> [    0.710575] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
> [    0.710607] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
> [    0.710635] pnp 00:06: Plug and Play ACPI device, IDs LEN006f PNP0f13 (active)
> [    0.710812] system 00:07: [io  0x1800-0x189f] could not be reserved
> [    0.710818] system 00:07: [io  0x0800-0x087f] has been reserved
> [    0.710823] system 00:07: [io  0x0880-0x08ff] has been reserved
> [    0.710827] system 00:07: [io  0x0900-0x097f] has been reserved
> [    0.710831] system 00:07: [io  0x0980-0x09ff] has been reserved
> [    0.710835] system 00:07: [io  0x0a00-0x0a7f] has been reserved
> [    0.710839] system 00:07: [io  0x0a80-0x0aff] has been reserved
> [    0.710844] system 00:07: [io  0x0b00-0x0b7f] has been reserved
> [    0.710848] system 00:07: [io  0x0b80-0x0bff] has been reserved
> [    0.710852] system 00:07: [io  0x15e0-0x15ef] has been reserved
> [    0.710856] system 00:07: [io  0x1600-0x167f] could not be reserved
> [    0.710860] system 00:07: [io  0x1640-0x165f] could not be reserved
> [    0.710865] system 00:07: [mem 0xf0000000-0xf3ffffff] has been reserved
> [    0.710870] system 00:07: [mem 0xfed10000-0xfed13fff] has been reserved
> [    0.710874] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.710878] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.710882] system 00:07: [mem 0xfeb00000-0xfebfffff] has been reserved
> [    0.710887] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.710892] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    0.710896] system 00:07: [mem 0xeffe0000-0xefffffff] has been reserved
> [    0.710904] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.713072] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.714648] system 00:09: [mem 0xfed10000-0xfed17fff] could not be reserved
> [    0.714654] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.714659] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.714663] system 00:09: [mem 0xf0000000-0xf3ffffff] has been reserved
> [    0.714668] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.714674] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    0.714678] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    0.714683] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
> [    0.714687] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
> [    0.714692] system 00:09: [mem 0xeffe0000-0xefffffff] has been reserved
> [    0.714700] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.715193] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reserved
> [    0.715198] system 00:0a: [mem 0x000f0000-0x000fffff] could not be reserved
> [    0.715203] system 00:0a: [mem 0x00100000-0x9c7fffff] could not be reserved
> [    0.715208] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be reserved
> [    0.715212] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be reserved
> [    0.715220] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.715429] pnp: PnP ACPI: found 11 devices
> [    0.722008] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.722039] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
> [    0.722043] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
> [    0.722046] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 02] add_size 200000 add_align 100000
> [    0.722071] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 05-3d] add_size 1000
> [    0.722096] pci 0000:00:1c.0: BAR 14: assigned [mem 0x9c800000-0x9c9fffff]
> [    0.722116] pci 0000:00:1c.0: BAR 15: assigned [mem 0x9ca00000-0x9cbfffff 64bit pref]
> [    0.722123] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
> [    0.722129] pci 0000:00:1d.0: BAR 13: assigned [io  0x3000-0x3fff]
> [    0.722135] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.722149] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> [    0.722165] pci 0000:00:1c.0:   bridge window [mem 0x9c800000-0x9c9fffff]
> [    0.722181] pci 0000:00:1c.0:   bridge window [mem 0x9ca00000-0x9cbfffff 64bit pref]
> [    0.722198] pci 0000:00:1c.6: PCI bridge to [bus 04]
> [    0.722213] pci 0000:00:1c.6:   bridge window [mem 0xec100000-0xec1fffff]
> [    0.722233] pci 0000:00:1d.0: PCI bridge to [bus 05-3d]
> [    0.722243] pci 0000:00:1d.0:   bridge window [io  0x3000-0x3fff]
> [    0.722256] pci 0000:00:1d.0:   bridge window [mem 0xd4000000-0xea0fffff]
> [    0.722268] pci 0000:00:1d.0:   bridge window [mem 0xb0000000-0xd1ffffff 64bit pref]
> [    0.722283] pci 0000:00:1d.2: PCI bridge to [bus 3e]
> [    0.722296] pci 0000:00:1d.2:   bridge window [mem 0xec000000-0xec0fffff]
> [    0.722314] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.722316] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.722319] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.722320] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
> [    0.722322] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
> [    0.722324] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
> [    0.722326] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
> [    0.722328] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
> [    0.722330] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
> [    0.722331] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
> [    0.722333] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
> [    0.722335] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
> [    0.722337] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
> [    0.722339] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
> [    0.722341] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
> [    0.722342] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
> [    0.722344] pci_bus 0000:00: resource 20 [mem 0x9c800000-0xefffffff window]
> [    0.722346] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff window]
> [    0.722348] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
> [    0.722350] pci_bus 0000:02: resource 1 [mem 0x9c800000-0x9c9fffff]
> [    0.722352] pci_bus 0000:02: resource 2 [mem 0x9ca00000-0x9cbfffff 64bit pref]
> [    0.722354] pci_bus 0000:04: resource 1 [mem 0xec100000-0xec1fffff]
> [    0.722356] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
> [    0.722358] pci_bus 0000:05: resource 1 [mem 0xd4000000-0xea0fffff]
> [    0.722360] pci_bus 0000:05: resource 2 [mem 0xb0000000-0xd1ffffff 64bit pref]
> [    0.722361] pci_bus 0000:3e: resource 1 [mem 0xec000000-0xec0fffff]
> [    0.722606] NET: Registered protocol family 2
> [    0.722829] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes)
> [    0.722926] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> [    0.723217] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [    0.723454] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.723508] UDP hash table entries: 8192 (order: 6, 262144 bytes)
> [    0.723592] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
> [    0.723703] NET: Registered protocol family 1
> [    0.723727] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.724469] PCI: CLS 0 bytes, default 64
> [    0.724520] Unpacking initramfs...
> [    1.512593] Freeing initrd memory: 28888K
> [    1.512720] DMAR: ACPI device "device:79" under DMAR at fed91000 as 00:15.0
> [    1.535620] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    1.535634] software IO TLB: mapped [mem 0x8a007000-0x8e007000] (64MB)
> [    1.535693] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc05e54fc, max_idle_ns: 440795291716 ns
> [    1.535716] clocksource: Switched to clocksource tsc
> [    1.536639] Initialise system trusted keyrings
> [    1.536706] workingset: timestamp_bits=40 max_order=22 bucket_order=0
> [    1.538602] zbud: loaded
> [    1.539075] pstore: using deflate compression
> [    1.888728] Key type asymmetric registered
> [    1.888733] Asymmetric key parser 'x509' registered
> [    1.888746] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
> [    1.888789] io scheduler noop registered
> [    1.888793] io scheduler deadline registered
> [    1.888835] io scheduler cfq registered (default)
> [    1.888839] io scheduler mq-deadline registered
> [    1.889909] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    1.889935] efifb: probing for efifb
> [    1.889956] efifb: framebuffer at 0xa0000000, using 8100k, total 8100k
> [    1.889959] efifb: mode is 1920x1080x32, linelength=7680, pages=1
> [    1.889961] efifb: scrolling: redraw
> [    1.889965] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    1.897913] Console: switching to colour frame buffer device 240x67
> [    1.905754] fb0: EFI VGA frame buffer device
> [    1.905793] intel_idle: MWAIT substates: 0x11142120
> [    1.905794] intel_idle: v0.4.1 model 0x8E
> [    1.906073] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    1.907219] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    1.928496] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    1.929580] Linux agpgart interface v0.103
> [    1.929700] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> [    1.929745] AMD IOMMUv2 functionality not available on this system
> [    1.930362] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> [    1.932518] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.932562] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    1.932879] mousedev: PS/2 mouse device common for all mice
> [    1.932996] rtc_cmos 00:03: RTC can wake from S4
> [    1.933685] rtc_cmos 00:03: registered as rtc0
> [    1.933741] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> [    1.933853] intel_pstate: Intel P-state driver initializing
> [    1.934338] intel_pstate: HWP enabled
> [    1.934428] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.934587] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    1.935163] NET: Registered protocol family 10
> [    1.939754] Segment Routing with IPv6
> [    1.939791] mip6: Mobile IPv6
> [    1.939805] NET: Registered protocol family 17
> [    1.939825] mpls_gso: MPLS GSO support
> [    1.940157] microcode: sig=0x806e9, pf=0x80, revision=0x8e
> [    1.940265] microcode: Microcode Update Driver: v2.2.
> [    1.940273] sched_clock: Marking stable (1943156682, -2896000)->(1954272676, -14011994)
> [    1.940402] registered taskstats version 1
> [    1.940436] Loading compiled-in X.509 certificates
> [    1.940467] zswap: loaded using pool lzo/zbud
> [    1.940501] AppArmor: AppArmor sha1 policy hashing enabled
> [    1.941612] rtc_cmos 00:03: setting system clock to 2018-09-04 13:10:52 UTC (1536066652)
> [    2.094973] Freeing unused kernel image memory: 1612K
> [    2.120278] Write protecting the kernel read-only data: 18432k
> [    2.121227] Freeing unused kernel image memory: 2024K
> [    2.121458] Freeing unused kernel image memory: 1196K
> [    2.126827] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    2.126845] x86/mm: Checking user space page tables
> [    2.132073] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    2.132090] Run /init as init process
> [    2.214407] ACPI: bus type USB registered
> [    2.214443] usbcore: registered new interface driver usbfs
> [    2.215355] usbcore: registered new interface driver hub
> [    2.215406] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
> [    2.217491] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    2.217593] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [    2.218448] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    2.218625] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    2.219389] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [    2.220417] usbcore: registered new device driver usb
> [    2.223779] cryptd: max_cpu_qlen set to 1000
> [    2.226510] nvme nvme0: pci function 0000:3e:00.0
> [    2.227798] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> [    2.229181] AVX2 version of gcm_enc/dec engaged.
> [    2.229252] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    2.230381] AES CTR mode by8 optimization enabled
> [    2.233619] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [    2.235797] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000109810
> [    2.236635] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> [    2.237010] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [    2.237569] thermal LNXTHERM:00: registered as thermal_zone0
> [    2.238160] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.239264] ACPI: Thermal Zone [THM0] (44 C)
> [    2.241616] usb usb1: Product: xHCI Host Controller
> [    2.242651] usb usb1: Manufacturer: Linux 4.19.0-rc2-3-iniza-llvmlinux xhci-hcd
> [    2.243838] usb usb1: SerialNumber: 0000:00:14.0
> [    2.245184] hub 1-0:1.0: USB hub found
> [    2.246035] hub 1-0:1.0: 12 ports detected
> [    2.248305] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    2.249180] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [    2.249986] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
> [    2.250939] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
> [    2.251970] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.253036] usb usb2: Product: xHCI Host Controller
> [    2.253929] usb usb2: Manufacturer: Linux 4.19.0-rc2-3-iniza-llvmlinux xhci-hcd
> [    2.254729] usb usb2: SerialNumber: 0000:00:14.0
> [    2.255764] hub 2-0:1.0: USB hub found
> [    2.255898] alg: No test for pcbc(aes) (pcbc-aes-aesni)
> [    2.256613] hub 2-0:1.0: 6 ports detected
> [    2.259173] usb: port power management may be unreliable
> [    2.501761] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
> [    2.556917]  nvme0n1: p1 p2 p3 p4 p5 p6
> [    2.587655] usb 1-1: new low-speed USB device number 2 using xhci_hcd
> [    2.593635] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 54:e1:ad:a0:6b:a0
> [    2.596742] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
> [    2.599842] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0FF
> [    2.604576] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
> [    2.751907] usb 1-1: New USB device found, idVendor=046a, idProduct=0023, bcdDevice= 2.20
> [    2.755508] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    2.764465] hidraw: raw HID events driver (C) Jiri Kosina
> [    2.784960] usbcore: registered new interface driver usbhid
> [    2.788132] usbhid: USB HID core driver
> [    2.794363] input: HID 046a:0023 as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:046A:0023.0001/input/input3
> [    2.856290] cherry 0003:046A:0023.0001: input,hidraw0: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:14.0-1/input0
> [    2.860018] input: HID 046a:0023 as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:046A:0023.0002/input/input4
> [    2.868206] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> [    2.900298] usb 2-3: New USB device found, idVendor=0bda, idProduct=0316, bcdDevice= 2.04
> [    2.903548] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    2.906776] usb 2-3: Product: USB3.0-CRW
> [    2.909959] usb 2-3: Manufacturer: Generic
> [    2.913117] usb 2-3: SerialNumber: 20120501030900000
> [    2.919762] cherry 0003:046A:0023.0002: input,hidraw1: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:14.0-1/input1
> [    2.934385] SCSI subsystem initialized
> [    2.934859] random: fast init done
> [    2.940966] usb-storage 2-3:1.0: USB Mass Storage device detected
> [    2.943140] scsi host0: usb-storage 2-3:1.0
> [    2.944747] usbcore: registered new interface driver usb-storage
> [    2.946827] usbcore: registered new interface driver uas
> [    3.019582] usb 1-3: new full-speed USB device number 3 using xhci_hcd
> [    3.043579] raid6: sse2x1   gen() 12272 MB/s
> [    3.100928] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4690]
> [    3.111575] raid6: sse2x1   xor()  9273 MB/s
> [    3.132597] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
> [    3.134133] psmouse serio1: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.
> [    3.176751] usb 1-3: New USB device found, idVendor=058f, idProduct=9540, bcdDevice= 1.20
> [    3.178372] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.179963] usb 1-3: Product: EMV Smartcard Reader
> [    3.179966] raid6: sse2x2   gen() 14702 MB/s
> [    3.181057] usb 1-3: Manufacturer: Generic
> [    3.199569] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf002a3/0x940300/0x12e800/0x400000, board id: 3276, fw id: 2491725
> [    3.201196] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
> [    3.240221] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input2
> [    3.247578] raid6: sse2x2   xor() 10719 MB/s
> [    3.311578] usb 1-4: new low-speed USB device number 4 using xhci_hcd
> [    3.315574] raid6: sse2x4   gen() 17126 MB/s
> [    3.383575] raid6: sse2x4   xor() 11606 MB/s
> [    3.451573] raid6: avx2x1   gen() 24904 MB/s
> [    3.462862] usb 1-4: New USB device found, idVendor=046d, idProduct=c077, bcdDevice=72.00
> [    3.464462] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    3.466049] usb 1-4: Product: USB Optical Mouse
> [    3.467630] usb 1-4: Manufacturer: Logitech
> [    3.471342] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:046D:C077.0003/input/input6
> [    3.473141] hid-generic 0003:046D:C077.0003: input,hidraw2: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:14.0-4/input0
> [    3.519576] raid6: avx2x1   xor() 16489 MB/s
> [    3.587574] raid6: avx2x2   gen() 27116 MB/s
> [    3.599578] usb 1-7: new full-speed USB device number 5 using xhci_hcd
> [    3.655575] raid6: avx2x2   xor() 20466 MB/s
> [    3.723575] raid6: avx2x4   gen() 31366 MB/s
> [    3.748668] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2b, bcdDevice= 0.10
> [    3.750322] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    3.791575] raid6: avx2x4   xor() 19861 MB/s
> [    3.792575] raid6: using algorithm avx2x4 gen() 31366 MB/s
> [    3.793576] raid6: .... xor() 19861 MB/s, rmw enabled
> [    3.794596] raid6: using avx2x2 recovery algorithm
> [    3.795961] xor: automatically using best checksumming function   avx       
> [    3.797185] async_tx: api initialized (async)
> [    3.811818] device-mapper: uevent: version 1.0.3
> [    3.813065] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> [    3.869057] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
> [    3.879731] usb 1-8: new high-speed USB device number 6 using xhci_hcd
> [    3.962782] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [    3.971047] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [    4.072571] usb 1-8: New USB device found, idVendor=13d3, idProduct=5619, bcdDevice=16.20
> [    4.072576] usb 1-8: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> [    4.072579] usb 1-8: Product: Integrated Camera
> [    4.072582] usb 1-8: Manufacturer: AzureWave
> [    4.072585] usb 1-8: SerialNumber: NULL
> [    4.097348] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input5
> [    4.204079] usb 1-9: new full-speed USB device number 7 using xhci_hcd
> [    4.354408] usb 1-9: New USB device found, idVendor=138a, idProduct=0097, bcdDevice= 1.64
> [    4.354414] usb 1-9: New USB device strings: Mfr=0, Product=0, SerialNumber=1
> [    4.354417] usb 1-9: SerialNumber: decd885354aa
> [    9.949306] NET: Registered protocol family 38
> [   10.096618] random: cryptsetup: uninitialized urandom read (2 bytes read)
> [   10.109226] random: lvm: uninitialized urandom read (4 bytes read)
> [   10.130668] random: lvm: uninitialized urandom read (4 bytes read)
> [   10.235817] Btrfs loaded, crc32c=crc32c-intel
> [   10.300601] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
> [   10.330669] random: crng init done
> [   10.331691] random: 1 urandom warning(s) missed due to ratelimiting
> [   10.392585] systemd[1]: RTC configured in localtime, applying delta of 120 minutes to system time.
> [   10.492028] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [   10.512466] systemd[1]: Detected architecture x86-64.
> [   10.518918] systemd[1]: Set hostname to <iniza>.
> [   10.596338] systemd[1]: Reached target User and Group Name Lookups.
> [   10.598467] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [   10.600609] systemd[1]: Listening on udev Control Socket.
> [   10.603140] systemd[1]: Listening on Syslog Socket.
> [   10.605219] systemd[1]: Listening on Journal Socket (/dev/log).
> [   10.607271] systemd[1]: Listening on Journal Audit Socket.
> [   10.609754] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> [   10.655526] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro
> [   10.660387] lp: driver loaded but no devices found
> [   10.663732] RPC: Registered named UNIX socket transport module.
> [   10.663732] RPC: Registered udp transport module.
> [   10.663733] RPC: Registered tcp transport module.
> [   10.663733] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [   10.668332] ppdev: user-space parallel port driver
> [   10.678702] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
> [   10.742128] systemd-journald[394]: Received request to flush runtime journal from PID 1
> [   10.791697] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input7
> [   10.794091] ACPI: Sleep Button [SLPB]
> [   10.795001] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input8
> [   10.796016] ACPI: Lid Switch [LID]
> [   10.800316] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input9
> [   10.801358] ACPI: Power Button [PWRF]
> [   10.836419] ACPI: AC Adapter [AC] (off-line)
> [   10.838852] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
> [   10.840141] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
> [   10.843175] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x0, rev-id 78)
> [   10.864593] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
> [   10.874540] battery: ACPI: Battery Slot [BAT0] (battery present)
> [   10.884240] iTCO_vendor_support: vendor-support=0
> [   10.898757] Non-volatile memory driver v1.3
> [   10.915489] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [   10.921256] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   10.923011] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [   10.924382] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
> [   10.925796] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [   10.927194] thinkpad_acpi: ThinkPad ACPI Extras v0.26
> [   10.928556] thinkpad_acpi: http://ibm-acpi.sf.net/
> [   10.929920] thinkpad_acpi: ThinkPad BIOS N1QET68W (1.43 ), EC unknown
> [   10.931290] thinkpad_acpi: Lenovo ThinkPad T470, model 20HDCTO1WW
> [   10.933150] EFI Variables Facility v0.08 2004-May-17
> [   10.979110] input: PC Speaker as /devices/platform/pcspkr/input/input11
> [   10.979122] i915 0000:00:02.0: enabling device (0006 -> 0007)
> [   10.991360] pstore: Registered efi as persistent store backend
> [   10.992835] thinkpad_acpi: radio switch found; radios are enabled
> [   10.994011] battery: ACPI: Battery Slot [BAT1] (battery present)
> [   10.994408] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
> [   10.996333] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
> [   10.997639] Error: Driver 'pcspkr' is already registered, aborting...
> [   11.001345] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   11.004225] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [   11.007744] cfg80211: failed to load regulatory.db
> [   11.008761] checking generic (a0000000 7e9000) vs hw (a0000000 10000000)
> [   11.012072] fb: switching to inteldrmfb from EFI VGA
> [   11.015176] Console: switching to colour dummy device 80x25
> [   11.015724] [drm] Replacing VGA console driver
> [   11.021609] Intel(R) Wireless WiFi driver for Linux
> [   11.021613] Copyright(c) 2003- 2015 Intel Corporation
> [   11.021681] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
> [   11.023982] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> [   11.023987] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   11.023989] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   11.023990] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   11.023992] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [   11.023994] RAPL PMU: hw unit of domain psys 2^-14 Joules
> [   11.026103] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   11.026108] [drm] Driver supports precise vblank timestamp query.
> [   11.031567] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=mem
> [   11.034492] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
> [   11.035811] [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> [   11.041849] iwlwifi 0000:04:00.0: loaded firmware version 36.e91976c0.0 op_mode iwlmvm
> [   11.079160] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
> [   11.086961] thinkpad_acpi: battery 2 registered (start 0, stop 100)
> [   11.097660] thinkpad_acpi: battery 1 registered (start 0, stop 100)
> [   11.097669] battery: new extension: ThinkPad Battery Extension
> [   11.097717] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input10
> [   11.108414] [drm] Initialized i915 1.6.0 20180719 for 0000:00:02.0 on minor 0
> [   11.118095] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [   11.118256] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input12
> [   11.118643] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> [   11.119472] iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wireless AC 8265, REV=0x230
> [   11.124254] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Opts: (null)
> [   11.132948] intel_rapl: Found RAPL domain package
> [   11.132955] intel_rapl: Found RAPL domain core
> [   11.132957] intel_rapl: Found RAPL domain uncore
> [   11.132959] intel_rapl: Found RAPL domain dram
> [   11.148198] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC298: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   11.148204] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   11.148207] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=2 (0x17/0x21/0x0/0x0/0x0)
> [   11.148209] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [   11.148211] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [   11.148213] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
> [   11.148214] snd_hda_codec_realtek hdaudioC0D0:      Dock Mic=0x19
> [   11.148216] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> [   11.178059] iwlwifi 0000:04:00.0: base HW address: bc:a8:a6:d1:3f:49
> [   11.223454] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
> [   11.227923] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
> [   11.228279] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
> [   11.228323] input: HDA Intel PCH Dock Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
> [   11.228363] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
> [   11.228416] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
> [   11.228454] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
> [   11.228493] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
> [   11.228532] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
> [   11.228570] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
> [   11.264292] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
> [   11.264497] thermal thermal_zone3: failed to read out thermal zone (-61)
> [   11.302013] audit: type=1400 audit(1536059461.859:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/lxc-start" pid=578 comm="apparmor_parser"
> [   11.306185] audit: type=1400 audit(1536059461.859:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=585 comm="apparmor_parser"
> [   11.306802] audit: type=1400 audit(1536059461.859:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/mysqld-akonadi" pid=576 comm="apparmor_parser"
> [   11.306808] audit: type=1400 audit(1536059461.859:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/mysqld-akonadi///usr/sbin/mysqld" pid=576 comm="apparmor_parser"
> [   11.306962] audit: type=1400 audit(1536059461.859:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/tcpdump" pid=577 comm="apparmor_parser"
> [   11.310106] audit: type=1400 audit(1536059461.863:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=590 comm="apparmor_parser"
> [   11.318322] audit: type=1400 audit(1536059461.871:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=591 comm="apparmor_parser"
> [   11.324989] audit: type=1400 audit(1536059461.879:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/telepathy/mission-control-5" pid=579 comm="apparmor_parser"
> [   11.324999] audit: type=1400 audit(1536059461.879:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/telepathy/telepathy-*" pid=579 comm="apparmor_parser"
> [   11.325003] audit: type=1400 audit(1536059461.879:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/telepathy/telepathy-*//pxgsettings" pid=579 comm="apparmor_parser"
> [   11.439318] new mount options do not match the existing superblock, will be ignored
> [   11.488510] fuse init (API version 7.27)
> [   11.586010] fbcon: inteldrmfb (fb0) is primary device
> [   11.637748] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
> [   12.242831] media: Linux media interface: v0.10
> [   12.265844] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   12.271952] videodev: Linux video capture interface: v2.00
> [   12.311386] Bluetooth: Core ver 2.22
> [   12.311431] NET: Registered protocol family 31
> [   12.311434] Bluetooth: HCI device and connection manager initialized
> [   12.311442] Bluetooth: HCI socket layer initialized
> [   12.311448] Bluetooth: L2CAP socket layer initialized
> [   12.311470] Bluetooth: SCO socket layer initialized
> [   12.440901] usbcore: registered new interface driver btusb
> [   12.441607] Bluetooth: hci0: Firmware revision 0.1 build 244 week 24 2018
> [   12.458076] uvcvideo: Found UVC 1.00 device Integrated Camera (13d3:5619)
> [   12.469277] uvcvideo: Failed to initialize entity for entity 6
> [   12.469280] uvcvideo: Failed to register entites (-22).
> [   12.469468] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/input/input23
> [   12.469668] usbcore: registered new interface driver uvcvideo
> [   12.469669] USB Video Class driver (1.1.1)
> [   12.778566] Console: switching to colour frame buffer device 240x67
> [   12.811519] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
> [   13.878630] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> [   13.878995] NFSD: starting 45-second grace period (net f00000a8)
> [   13.885223] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   13.886602] Bluetooth: BNEP filters: protocol multicast
> [   13.886614] Bluetooth: BNEP socket layer initialized
> [   13.897633] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready
> [   14.112113] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready
> [   14.155695] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
> [   14.377620] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
> [   14.603973] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
> [   14.694749] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
> [   16.937882] e1000e: enp0s31f6 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> [   16.937946] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s31f6: link becomes ready
> [   18.260135] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
> [   19.169028] wlp4s0: authenticate with 44:d9:e7:8b:f2:31
> [   19.180469] wlp4s0: send auth to 44:d9:e7:8b:f2:31 (try 1/3)
> [   19.185581] wlp4s0: authenticated
> [   19.187674] wlp4s0: associate with 44:d9:e7:8b:f2:31 (try 1/3)
> [   19.188706] wlp4s0: RX AssocResp from 44:d9:e7:8b:f2:31 (capab=0x11 status=0 aid=1)
> [   19.191111] wlp4s0: associated
> [   19.363684] IPv6: ADDRCONF(NETDEV_CHANGE): wlp4s0: link becomes ready
> [   23.671479] Bluetooth: RFCOMM TTY layer initialized
> [   23.671491] Bluetooth: RFCOMM socket layer initialized
> [   23.671497] Bluetooth: RFCOMM ver 1.11
> [   38.400560] wlp4s0: deauthenticating from 44:d9:e7:8b:f2:31 by local choice (Reason: 3=DEAUTH_LEAVING)
> [   38.411389] IPv6: ADDRCONF(NETDEV_UP): wlp4s0: link is not ready
> [   41.644180] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> [   41.674832] IPv6: ADDRCONF(NETDEV_UP): lxcbr0: link is not ready
> [   41.700769] vboxdrv: loading out-of-tree module taints kernel.
> [   41.743496] vboxdrv: Found 4 processor cores
> [   41.778183] vboxdrv: TSC mode is Invariant, tentative frequency 2903965744 Hz
> [   41.778188] vboxdrv: Successfully loaded version 5.2.18_Debian (interface 0x00290001)
> [   41.806454] VBoxNetFlt: Successfully started.
> [   41.821835] VBoxNetAdp: Successfully started.
> [   41.859387] VBoxPciLinuxInit
> [   41.868470] vboxpci: IOMMU not found (not registered)
> [   41.882337] kauditd_printk_skb: 23 callbacks suppressed
> [   41.882341] audit: type=1400 audit(1536059492.434:35): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="/usr/bin/lxc-start" pid=2443 comm="apparmor_parser"
> [   41.924338] audit: type=1400 audit(1536059492.478:36): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="lxc-container-default" pid=2474 comm="apparmor_parser"
> [   41.924345] audit: type=1400 audit(1536059492.478:37): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="lxc-container-default-cgns" pid=2474 comm="apparmor_parser"
> [   41.924349] audit: type=1400 audit(1536059492.478:38): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="lxc-container-default-with-mounting" pid=2474 comm="apparmor_parser"
> [   41.924353] audit: type=1400 audit(1536059492.478:39): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="lxc-container-default-with-nesting" pid=2474 comm="apparmor_parser"
