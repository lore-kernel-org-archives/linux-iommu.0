From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 0/9] Fix AMD IOMMU faults in kdump kernel
Date: Fri, 6 Nov 2015 20:14:00 +0800
Message-ID: <20151106121400.GA20377@dhcp-128-28.nay.redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446811851-20623-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The kdump kernel boog log is attached here.


On 11/06/15 at 08:10pm, Baoquan He wrote:
> This is v2 draft patch set. It mainly functions as the following steps:
> 
> 1. Checking if it's in kdump kernel and previously enabled
> 2. If yes do below operatons:
>     a. Do not disable amd iommu and do not touch dev tables before coping old dev tables
>     b. Copy dev table from old kernel and set the old domain id in amd_iommu_pd_alloc_bitmap
>     c. Copy irq tables from old kernel
>     d. Copy command buffer and event buffer
>     e. Don't call update_domain() to set domain->pt_root to dev entries before device driver initialization.
>     f. Reset the pre-enabled status in case IOMMU_DMA_OPS of state_next(). 
> 
> Existed problems:
> 
> 1. It always prints the following message whenever do a flush:
> 
> 	"AMD-Vi: Completion-Wait loop timed out"
> 
> 2. Maybe there's someing wrong with the old irq remapping handling, the hard disk can't be brought up
> successfully. You can check the attached kdump kernel boot log with this patchset applied.
> 
> Baoquan He (9):
>   iommu/amd: Use standard bitmap operation to set bitmap
>   iommu/amd: Detect pre enabled translation
>   iommu/amd: make several functions global
>   iommu/amd: add copy_irq_table function
>   iommu/amd: Add function copy_dev_tables
>   iommu/amd: Add functions copy_command_buffer/copy_event_buffer
>   iommu/amd: copy old tables and do not update dev tables before driver
>     init
>   iommu/amd: Do not update the information of domain to devtables before
>     device driver init
>   iommu/amd: Clear the iommu pre enabled setting
> 
>  drivers/iommu/amd_iommu.c       |  27 +++---
>  drivers/iommu/amd_iommu_init.c  | 208 +++++++++++++++++++++++++++++++++-------
>  drivers/iommu/amd_iommu_proto.h |   6 ++
>  drivers/iommu/amd_iommu_types.h |   4 +
>  4 files changed, 198 insertions(+), 47 deletions(-)
> 
> -- 
> 2.4.0
> 

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amd-iommu-copy-buffer.log"

[42155.054145] sysrq: SysRq : Trigger a crash
[42155.058421] BUG: unable to handle kernel NULL pointer dereference at           (null)
[42155.067825] IP: [<ffffffff8147b996>] sysrq_handle_crash+0x16/0x20
[42155.075477] PGD 0 
[42155.079006] Oops: 0002 [#1] SMP 
[42155.083819] Modules linked in: nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_fili
[42155.176856] CPU: 3 PID: 2443 Comm: bash Tainted: G        W       4.3.0+ #69
[42155.185856] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88X-D3H, BIOS F5 05/28/2014
[42155.197831] task: ffff880218c02880 ti: ffff8800797e8000 task.ti: ffff8800797e8000
[42155.207311] RIP: 0010:[<ffffffff8147b996>]  [<ffffffff8147b996>] sysrq_handle_crash+0x16/0x20
[42155.217883] RSP: 0018:ffff8800797ebdd0  EFLAGS: 00010282
[42155.225227] RAX: 000000000000000f RBX: 0000000000000063 RCX: 0000000000000000
[42155.234404] RDX: 0000000000000000 RSI: ffff88023ed8df78 RDI: 0000000000000063
[42155.243582] RBP: ffff8800797ebdd0 R08: 0000000000000002 R09: 000000000000042b
[42155.252765] R10: 0000000000000001 R11: 000000000000042b R12: 0000000000000007
[42155.261986] R13: 0000000000000000 R14: ffffffff81cbfdc0 R15: 0000564198fb23d0
[42155.271217] FS:  00007f93dcc93700(0000) GS:ffff88023ed80000(0000) knlGS:0000000000000000
[42155.281406] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[42155.289268] CR2: 0000000000000000 CR3: 0000000218c50000 CR4: 00000000000406e0
[42155.298534] Stack:
[42155.302605]  ffff8800797ebe00 ffffffff8147c16a 0000000000000002 fffffffffffffffb
[42155.312211]  ffff8800797ebf18 0000000000000002 ffff8800797ebe18 ffffffff8147c5ef
[42155.321848]  ffff88023458e000 ffff8800797ebe38 ffffffff81280122 ffff880070a5a500
[42155.331508] Call Trace:
[42155.336093]  [<ffffffff8147c16a>] __handle_sysrq+0xea/0x140
[42155.343855]  [<ffffffff8147c5ef>] write_sysrq_trigger+0x2f/0x40
[42155.351955]  [<ffffffff81280122>] proc_reg_write+0x42/0x70
[42155.359632]  [<ffffffff81216927>] __vfs_write+0x37/0x100
[42155.367088]  [<ffffffff81322e33>] ? selinux_file_permission+0xc3/0x100
[42155.375804]  [<ffffffff81318b8d>] ? security_file_permission+0x3d/0xc0
[42155.384519]  [<ffffffff810e39b2>] ? percpu_down_read+0x12/0x50
[42155.392482]  [<ffffffff812172a9>] vfs_write+0xa9/0x1a0
[42155.399773]  [<ffffffff81318f23>] ? security_file_fcntl+0x43/0x60
[42155.408059]  [<ffffffff81217f65>] SyS_write+0x55/0xc0
[42155.415316]  [<ffffffff8178b52e>] entry_SYSCALL_64_fastpath+0x12/0x71
[42155.423930] Code: ef e8 1f f8 ff ff eb db 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 55 c7 05 b8 b6 a9 00 01 00 00 00 48 89 e5 0f ae f8 <c6> 04 25 00 00 00 00 01 5d c3 0f 1f  
[42155.448508] RIP  [<ffffffff8147b996>] sysrq_handle_crash+0x16/0x20
[42155.456903]  RSP <ffff8800797ebdd0>
[42155.462666] CR2: 0000000000000000
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.3.0+ (bhe-0VdLhd/A9PknZhOiLRORzh/sF2h8X+2i0E9HWUfgJXw@public.gmane.org) (gcc version 5.1.1 20150618 (Red Hat 5.1.1-4) (GCC) ) #69 SMP Thu Nov 5 17:22:12 CST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.3.0+ root=UUID=4b765449-4873-42cc-845f-56aba6804aff ro LANG=en_US.UTF-8 console=tty0 console=ttyS0,115200n8 amd_iommu_dump irqpoll nr_cpuK
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000028000000-0x0000000037f5cfff] usable
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
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000001000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000028000000-0x000000002800006f] usable
[    0.000000] reserve setup_data: [mem 0x0000000028000070-0x0000000037f5cfff] usable
[    0.000000] reserve setup_data: [mem 0x000000007cc9a000-0x000000007ccc9fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007cfa0000-0x000000007d06dfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007d06e000-0x000000007e1c7fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007e1c9000-0x000000007e3cefff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007e851000-0x000000007efe1fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec01fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0x7d024000  ACPI 2.0=0x7d024000  SMBIOS=0xf04c0  MPS=0xfd430 
[    0.000000] SMBIOS 2.7 present.
[    0.000000] e820: last_pfn = 0x37f5d max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] found SMP MP-table at [mem 0x000fd6f0-0x000fd6ff] mapped at [ffff8800000fd6f0]
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000] init_memory_mapping: [mem 0x37c00000-0x37dfffff]
[    0.000000] init_memory_mapping: [mem 0x28000000-0x37bfffff]
[    0.000000] init_memory_mapping: [mem 0x37e00000-0x37f5cfff]
[    0.000000] RAMDISK: [mem 0x34c49000-0x35ffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007D024000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000007D024088 00008C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000007D02A5A0 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20150930/tbfadt-654)
[    0.000000] ACPI: DSDT 0x000000007D0241A8 0063F2 (v02 ALASKA A M I    00000088 INTL 20051117)
[    0.000000] ACPI: FACS 0x000000007D063080 000040
[    0.000000] ACPI: APIC 0x000000007D02A6B0 00007E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000007D02A730 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000007D02A778 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x000000007D02A7B8 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: WDRT 0x000000007D02A7F0 000047 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: IVRS 0x000000007D02A838 000078 (v02 AMD    BANTRY   00000001 AMD  00000000)
[    0.000000] ACPI: BGRT 0x000000007D02A8B0 000038 (v00 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000007D02A8E8 000B9C (v01 AMD    BANTRY   00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000007D02B488 00033B (v02 AMD    BANTRY   00000002 MSFT 04000000)
[    0.000000] ACPI: CRAT 0x000000007D02B7C8 000550 (v01 AMD    BANTRY   00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000007D02BD18 001457 (v01 AMD    CPMDFIGP 00000001 INTL 20051117)
[    0.000000] ACPI: SSDT 0x000000007D02D170 00122C (v01 AMD    CPMCMN   00000001 INTL 20051117)
[    0.000000] NUMA turned off
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000037f5cfff]
[    0.000000] NODE_DATA(0) allocated [mem 0x37f49000-0x37f5cfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x0000000037f5cfff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000028000000-0x0000000037f5cfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000037f5cfff]
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keeping one slot for boot cpu.  Processor 0/0x10 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keeping one slot for boot cpu.  Processor 1/0x11 ignored.
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 almost reached. Keeping one slot for boot cpu.  Processor 2/0x12 ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 1, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] smpboot: 4 Processors exceeds NR_CPUS limit of 1
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x27ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x28000000-0x28000fff]
[    0.000000] e820: [mem 0x7efe2000-0xfebfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff880037c00000 s98328 r8192 d32744 u2097152
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 64485
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.3.0+ root=UUID=4b765449-4873-42cc-845f-56aba6804aff ro LANG=en_US.UTF-8 console=tty0 console=ttyS0,115200n8 amd_iommu_dump irqpollK
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] Disabling memory control group subsystem
[    0.000000] PID hash table entries: 1024 (order: 1, 8192 bytes)
[    0.000000] Memory: 218672K/262128K available (7744K kernel code, 1258K rwdata, 3396K rodata, 1508K init, 1464K bss, 43456K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS:4352 nr_irqs:256 16
[    0.000000]  Offload RCU callbacks from all CPUs
[    0.000000]  Offload RCU callbacks from CPUs: 0.
[    0.000000] Spurious LAPIC timer interrupt on cpu 0
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3693.278 MHz processor
[    0.000044] Calibrating delay loop (skipped), value calculated using timer frequency.. 7386.55 BogoMIPS (lpj=3693278)
[    0.010694] pid_max: default: 32768 minimum: 301
[    0.015322] ACPI: Core revision 20150930
[    0.028080] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.034710] Security Framework initialized
[    0.038810] Yama: becoming mindful.
[    0.042306] SELinux:  Initializing.
[    0.045889] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.052955] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.059872] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.066415] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.073652] Initializing cgroup subsys io
[    0.077703] Initializing cgroup subsys memory
[    0.082061] Initializing cgroup subsys devices
[    0.086504] Initializing cgroup subsys freezer
[    0.090951] Initializing cgroup subsys net_cls
[    0.095396] Initializing cgroup subsys perf_event
[    0.100102] Initializing cgroup subsys net_prio
[    0.104635] Initializing cgroup subsys hugetlb
[    0.109109] CPU: Physical Processor ID: 0
[    0.113117] CPU: Processor Core ID: 3
[    0.116786] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.122704] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.137593] Freeing SMP alternatives memory: 28K (ffffffff81eb5000 - ffffffff81ebc000)
[    0.146968] Ignoring BGRT: failed to allocate memory for image (wanted 3913597517 bytes)
[    0.155062] ftrace: allocating 29299 entries in 115 pages
[    0.181255] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b8 info 0000
[    0.188018] AMD-Vi:        mmio-addr: 00000000feb80000
[    0.193172] Translation is already enabled - trying to copy translation structures
[    0.200742] AMD-Vi:   DEV_SELECT_RANGE_START  devid: 00:01.0 flags: 00
[    0.207266] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.6
[    0.212611] AMD-Vi:   DEV_ALIAS_RANGE                 devid: 02:00.0 flags: 00 devid_to: 00:14.4
[    0.220183] AMD-Vi:   DEV_RANGE_END           devid: 02:1f.7
[    0.225150] AMD-Vi:   DEV_SPECIAL(HPET[0])           devid: 00:14.0
[    0.230632] AMD-Vi:   DEV_SPECIAL(IOAPIC[0])         devid: 00:14.0
[    0.236288] AMD-Vi:   DEV_SPECIAL(IOAPIC[1])         devid: 00:00.0
[    0.360316] AMD-Vi: Completion-Wait loop timed out
[    0.365636] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.488449] AMD-Vi: Completion-Wait loop timed out
[    0.604883] smpboot: CPU0: AMD A10-7850K Radeon R7, 12 Compute Cores 4C+8G (family: 0x15, model: 0x30, stepping: 0x1)
[    0.615601] Performance Events: Fam15h core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    0.625498] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
[    0.633939] AMD PMU driver.
[    0.636735] ... version:                0
[    0.640748] ... bit width:              48
[    0.644847] ... generic registers:      6
[    0.648861] ... value mask:             0000ffffffffffff
[    0.654173] ... max period:             00007fffffffffff
[    0.659486] ... fixed-purpose events:   0
[    0.663498] ... event mask:             000000000000003f
[    0.669821] x86: Booted up 1 node, 1 CPUs
[    0.673904] smpboot: Total of 1 processors activated (7386.55 BogoMIPS)
[    0.680540] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.805479] AMD-Vi: Completion-Wait loop timed out
[    0.927273] AMD-Vi: Completion-Wait loop timed out
[    1.049058] AMD-Vi: Completion-Wait loop timed out
[    1.170844] AMD-Vi: Completion-Wait loop timed out
[    1.292626] AMD-Vi: Completion-Wait loop timed out
[    1.414377] AMD-Vi: Completion-Wait loop timed out
[    1.536160] AMD-Vi: Completion-Wait loop timed out
[    1.657945] AMD-Vi: Completion-Wait loop timed out
[    1.779731] AMD-Vi: Completion-Wait loop timed out
[    1.901511] AMD-Vi: Completion-Wait loop timed out
[    2.023263] AMD-Vi: Completion-Wait loop timed out
[    2.145047] AMD-Vi: Completion-Wait loop timed out
[    2.266833] AMD-Vi: Completion-Wait loop timed out
[    2.388616] AMD-Vi: Completion-Wait loop timed out
[    2.393886] devtmpfs: initialized
[    2.400936] PM: Registering ACPI NVS region [mem 0x7cfa0000-0x7d06dfff] (843776 bytes)
[    2.408944] PM: Registering ACPI NVS region [mem 0x7e1c9000-0x7e3cefff] (2121728 bytes)
[    2.417098] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    2.426973] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    2.433968] pinctrl core: initialized pinctrl subsystem
[    2.439243] RTC time:  2:28:34, date: 11/06/15
[    2.443872] NET: Registered protocol family 16
[    2.448716] cpuidle: using governor menu
[    2.452924] ACPI: bus type PCI registered
[    2.456999] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.463538] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    2.472847] PCI: not using MMCONFIG
[    2.476344] PCI: Using configuration type 1 for base access
[    2.481915] PCI: Using configuration type 1 for extended access
[    2.490417] ACPI: Added _OSI(Module Device)
[    2.494664] ACPI: Added _OSI(Processor Device)
[    2.499109] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.503816] ACPI: Added _OSI(Processor Aggregator Device)
[    2.512105] ACPI: Executed 1 blocks of module-level executable AML code
[    2.523813] ACPI: Interpreter enabled
[    2.527520] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150930/hwxface-580)
[    2.536780] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150930/hwxface-580)
[    2.546072] ACPI: (supports S0 S3 S4 S5)
[    2.550002] ACPI: Using IOAPIC for interrupt routing
[    2.555163] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    2.564526] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    2.573248] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.583147] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    2.591223] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    2.599290] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    2.616065] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    2.622314] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.630856] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    2.639451] PCI host bridge to bus 0000:00
[    2.643551] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    2.650338] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    2.657130] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    2.663917] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.670704] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.678185] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    2.685674] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
[    2.693161] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.699876] pci 0000:00:03.1: System wakeup disabled by ACPI
[    2.706057] pci 0000:00:10.0: System wakeup disabled by ACPI
[    2.712025] pci 0000:00:10.1: System wakeup disabled by ACPI
[    2.718177] pci 0000:00:12.0: System wakeup disabled by ACPI
[    2.724104] pci 0000:00:12.2: System wakeup disabled by ACPI
[    2.730005] pci 0000:00:13.0: System wakeup disabled by ACPI
[    2.735934] pci 0000:00:13.2: System wakeup disabled by ACPI
[    2.741973] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    2.749112] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    2.755637] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    2.762769] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    2.769560] pci 0000:00:14.2: System wakeup disabled by ACPI
[    2.775603] pci 0000:00:14.4: System wakeup disabled by ACPI
[    2.781469] pci 0000:00:14.5: System wakeup disabled by ACPI
[    2.789460] pci 0000:00:03.1: PCI bridge to [bus 01]
[    2.794599] pci 0000:00:14.4: PCI bridge to [bus 02] (subtractive decode)
[    2.802387] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    2.809277] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    2.816164] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    2.823048] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    2.829929] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    2.836778] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    2.843637] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    2.850479] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    2.857693] vgaarb: setting as boot device: PCI:0000:00:01.0
[    2.863354] vgaarb: device added: PCI:0000:00:01.0,decodes=io+mem,owns=io+mem,locks=none
[    2.871453] vgaarb: loaded
[    2.874168] vgaarb: bridge control possible 0000:00:01.0
[    2.879652] SCSI subsystem initialized
[    2.883554] ACPI: bus type USB registered
[    2.887623] usbcore: registered new interface driver usbfs
[    2.893155] usbcore: registered new interface driver hub
[    2.898488] usbcore: registered new device driver usb
[    2.903739] PCI: Using ACPI for IRQ routing
[    2.915800] NetLabel: Initializing
[    2.919237] NetLabel:  domain hash size = 128
[    2.923594] NetLabel:  protocols = UNLABELED CIPSOv4
[    2.928577] NetLabel:  unlabeled traffic allowed by default
[    2.934429] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    2.939386] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    2.947270] clocksource: Switched to clocksource hpet
[    2.964016] pnp: PnP ACPI init
[    2.967387] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    2.974162] system 00:01: [mem 0x80000000-0xbfffffff] has been reserved
[    2.980932] system 00:02: [mem 0xfeb80000-0xfebfffff] could not be reserved
[    2.988217] system 00:03: [io  0x0220-0x0227] has been reserved
[    2.994201] system 00:03: [io  0x0228-0x0237] has been reserved
[    3.000128] system 00:03: [io  0x0a20-0x0a2f] has been reserved
[    3.006851] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    3.013322] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    3.019247] system 00:08: [io  0x040b] has been reserved
[    3.024569] system 00:08: [io  0x04d6] has been reserved
[    3.029889] system 00:08: [io  0x0c00-0x0c01] has been reserved
[    3.035817] system 00:08: [io  0x0c14] has been reserved
[    3.041139] system 00:08: [io  0x0c50-0x0c51] has been reserved
[    3.047067] system 00:08: [io  0x0c52] has been reserved
[    3.052388] system 00:08: [io  0x0c6c] has been reserved
[    3.057710] system 00:08: [io  0x0c6f] has been reserved
[    3.063030] system 00:08: [io  0x0cd0-0x0cd1] has been reserved
[    3.068960] system 00:08: [io  0x0cd2-0x0cd3] has been reserved
[    3.074886] system 00:08: [io  0x0cd4-0x0cd5] has been reserved
[    3.080814] system 00:08: [io  0x0cd6-0x0cd7] has been reserved
[    3.086742] system 00:08: [io  0x0cd8-0x0cdf] has been reserved
[    3.092673] system 00:08: [io  0x0800-0x089f] could not be reserved
[    3.098947] system 00:08: [io  0x0b20-0x0b3f] has been reserved
[    3.104875] system 00:08: [io  0x0900-0x090f] has been reserved
[    3.110803] system 00:08: [io  0x0910-0x091f] has been reserved
[    3.116731] system 00:08: [io  0xfe00-0xfefe] has been reserved
[    3.122658] system 00:08: [mem 0xfec00000-0xfec00fff] could not be reserved
[    3.129627] system 00:08: [mem 0xfee00000-0xfee00fff] has been reserved
[    3.136247] system 00:08: [mem 0xfed80000-0xfed8ffff] has been reserved
[    3.142870] system 00:08: [mem 0xfed61000-0xfed70fff] has been reserved
[    3.149490] system 00:08: [mem 0xfec10000-0xfec10fff] has been reserved
[    3.156112] system 00:08: [mem 0xfed00000-0xfed00fff] could not be reserved
[    3.163081] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    3.169965] pnp: PnP ACPI: found 9 devices
[    3.181322] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.190228] pci 0000:00:03.1: PCI bridge to [bus 01]
[    3.195200] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    3.201302] pci 0000:00:03.1:   bridge window [mem 0xfea00000-0xfeafffff]
[    3.208096] pci 0000:00:03.1:   bridge window [mem 0xd0800000-0xd08fffff 64bit pref]
[    3.215849] pci 0000:00:14.4: PCI bridge to [bus 02]
[    3.220939] NET: Registered protocol family 2
[    3.225581] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    3.232659] TCP bind hash table entries: 2048 (order: 3, 32768 bytes)
[    3.239111] TCP: Hash tables configured (established 2048 bind 2048)
[    3.245492] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    3.251338] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    3.257653] NET: Registered protocol family 1
[    3.416656] Unpacking initramfs...
[    4.074583] Freeing initrd memory: 20188K (ffff880034c49000 - ffff880036000000)
[    4.082015] AMD-Vi: IOMMU performance counters supported
[    4.088154] iommu: Adding device 0000:00:00.0 to group 0
[    4.094241] iommu: Adding device 0000:00:01.0 to group 1
[    4.224699] AMD-Vi: Completion-Wait loop timed out
[    4.229573] iommu: Using direct mapping for device 0000:00:01.0
[    4.235507] iommu: Adding device 0000:00:01.1 to group 1
[    4.241545] iommu: Adding device 0000:00:02.0 to group 2
[    4.247682] iommu: Adding device 0000:00:03.0 to group 3
[    4.253073] iommu: Adding device 0000:00:03.1 to group 3
[    4.259082] iommu: Adding device 0000:00:04.0 to group 4
[    4.265163] iommu: Adding device 0000:00:10.0 to group 5
[    4.270558] iommu: Adding device 0000:00:10.1 to group 5
[    4.276630] iommu: Adding device 0000:00:11.0 to group 6
[    4.282766] iommu: Adding device 0000:00:12.0 to group 7
[    4.288155] iommu: Adding device 0000:00:12.2 to group 7
[    4.294164] iommu: Adding device 0000:00:13.0 to group 8
[    4.299552] iommu: Adding device 0000:00:13.2 to group 8
[    4.305637] iommu: Adding device 0000:00:14.0 to group 9
[    4.311027] iommu: Adding device 0000:00:14.1 to group 9
[    4.316356] iommu: Adding device 0000:00:14.2 to group 9
[    4.321685] iommu: Adding device 0000:00:14.3 to group 9
[    4.327757] iommu: Adding device 0000:00:14.4 to group 10
[    4.333949] iommu: Adding device 0000:00:14.5 to group 11
[    4.340123] iommu: Adding device 0000:00:18.0 to group 12
[    4.345604] iommu: Adding device 0000:00:18.1 to group 12
[    4.351024] iommu: Adding device 0000:00:18.2 to group 12
[    4.356440] iommu: Adding device 0000:00:18.3 to group 12
[    4.361856] iommu: Adding device 0000:00:18.4 to group 12
[    4.367279] iommu: Adding device 0000:00:18.5 to group 12
[    4.372699] iommu: Adding device 0000:01:00.0 to group 3
[    4.378017] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    4.383338] AMD-Vi:  Extended features:  PPR GT IA PC
[    4.388503] AMD-Vi: Interrupt remapping enabled
[    4.393215] AMD-Vi: Lazy IO/TLB flushing enabled
[    4.398174] perf: AMD NB counters detected
[    4.402292] perf: amd_iommu: Detected. (2 banks, 4 counters/bank)
[    4.408421] LVT offset 0 assigned for vector 0x400
[    4.413228] perf: AMD IBS detected (0x000001ff)
[    4.418536] futex hash table entries: 256 (order: 2, 16384 bytes)
[    4.424723] audit: initializing netlink subsys (disabled)
[    4.430182] audit: type=2000 audit(1446776914.314:1): initialized
[    4.436788] Initialise system trusted keyring
[    4.441319] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    4.450510] zbud: loaded
[    4.453433] VFS: Disk quotas dquot_6.6.0
[    4.457454] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.464984] Key type big_key registered
[    4.474589] NET: Registered protocol family 38
[    4.479072] Key type asymmetric registered
[    4.483191] Asymmetric key parser 'x509' registered
[    4.488156] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    4.495617] io scheduler noop registered
[    4.499557] io scheduler deadline registered
[    4.503892] io scheduler cfq registered (default)
[    4.634190] AMD-Vi: Completion-Wait loop timed out
[    4.755953] AMD-Vi: Completion-Wait loop timed out
[    4.877615] AMD-Vi: Completion-Wait loop timed out
[    4.882491] pcieport 0000:00:03.1: Signaling PME through PCIe PME interrupt
[    4.889455] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    4.896003] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    4.901589] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    4.908390] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    4.916779] ACPI: Power Button [PWRB]
[    4.920506] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    4.927938] ACPI: Power Button [PWRF]
[    4.931929] GHES: HEST is not enabled!
[    4.935815] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.962768] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    4.970754] Non-volatile memory driver v1.3
[    4.975051] Linux agpgart interface v0.103
[    5.104563] AMD-Vi: Completion-Wait loop timed out
[    5.234725] AMD-Vi: Completion-Wait loop timed out
[    5.364945] AMD-Vi: Completion-Wait loop timed out
[    5.495146] AMD-Vi: Completion-Wait loop timed out
[    5.500012] tsc: Refined TSC clocksource calibration: 3693.488 MHz
[    5.506195] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a7a9c77452, max_idle_ns: 881591025061 ns
[    5.641533] AMD-Vi: Completion-Wait loop timed out
[    5.771718] AMD-Vi: Completion-Wait loop timed out
[    5.901897] AMD-Vi: Completion-Wait loop timed out
[    6.032082] AMD-Vi: Completion-Wait loop timed out
[    6.162267] AMD-Vi: Completion-Wait loop timed out
[    6.292459] AMD-Vi: Completion-Wait loop timed out
[    6.422610] AMD-Vi: Completion-Wait loop timed out
[    6.552807] AMD-Vi: Completion-Wait loop timed out
[    6.557700] clocksource: Switched to clocksource tsc
[    6.679765] AMD-Vi: Completion-Wait loop timed out
[    6.685404] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    6.693500] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    6.818533] AMD-Vi: Completion-Wait loop timed out
[    6.940186] AMD-Vi: Completion-Wait loop timed out
[    6.945586] scsi host0: ahci
[    6.948649] scsi host1: ahci
[    6.951661] scsi host2: ahci
[    6.954681] scsi host3: ahci
[    6.957696] ata1: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71100 irq 19
[    6.965094] ata2: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71180 irq 19
[    6.972495] ata3: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71200 irq 19
[    6.979895] ata4: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71280 irq 19
[    6.987515] libphy: Fixed MDIO Bus: probed
[    6.991727] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.998295] ehci-pci: EHCI PCI platform driver
[    7.002903] ehci-pci 0000:00:12.2: EHCI Host Controller
[    7.008184] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    7.015614] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    7.024320] ehci-pci 0000:00:12.2: debug port 1
[    7.145688] AMD-Vi: Completion-Wait loop timed out
[    7.267345] AMD-Vi: Completion-Wait loop timed out
[    7.272229] ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb6f000
[    7.283522] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    7.289394] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    7.296186] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.303412] usb usb1: Product: EHCI Host Controller
[    7.308298] usb usb1: Manufacturer: Linux 4.3.0+ ehci_hcd
[    7.313696] usb usb1: SerialNumber: 0000:00:12.2
[    7.318539] hub 1-0:1.0: USB hub found
[    7.322372] hub 1-0:1.0: 5 ports detected
[    7.326829] ehci-pci 0000:00:13.2: EHCI Host Controller
[    7.332131] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    7.339579] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    7.348293] ehci-pci 0000:00:13.2: debug port 1
[    7.352873] ehci-pci 0000:00:13.2: irq 17, io mem 0xfeb6d000
[    7.364526] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    7.370401] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    7.377229] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.384456] usb usb2: Product: EHCI Host Controller
[    7.389340] usb usb2: Manufacturer: Linux 4.3.0+ ehci_hcd
[    7.394739] usb usb2: SerialNumber: 0000:00:13.2
[    7.399395] ata3: SATA link down (SStatus 0 SControl 300)
[    7.404832] ata2: SATA link down (SStatus 0 SControl 300)
[    7.410259] ata1: SATA link down (SStatus 0 SControl 300)
[    7.415885] hub 2-0:1.0: USB hub found
[    7.419722] hub 2-0:1.0: 5 ports detected
[    7.423974] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.430898] ohci-pci: OHCI PCI platform driver
[    7.435589] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    7.441239] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
[    7.565492] AMD-Vi: Completion-Wait loop timed out
[    7.687151] AMD-Vi: Completion-Wait loop timed out
[    7.692032] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.698267] ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb70000
[    7.758610] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    7.765434] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.772663] usb usb3: Product: OHCI PCI host controller
[    7.777892] usb usb3: Manufacturer: Linux 4.3.0+ ohci_hcd
[    7.783292] usb usb3: SerialNumber: 0000:00:12.0
[    7.788129] hub 3-0:1.0: USB hub found
[    7.791970] hub 3-0:1.0: 5 ports detected
[    7.796393] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    7.802129] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 4
[    7.809584] ohci-pci 0000:00:13.0: irq 18, io mem 0xfeb6e000
[    7.869626] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    7.876455] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.883682] usb usb4: Product: OHCI PCI host controller
[    7.888915] usb usb4: Manufacturer: Linux 4.3.0+ ohci_hcd
[    7.894322] usb usb4: SerialNumber: 0000:00:13.0
[    7.899231] hub 4-0:1.0: USB hub found
[    7.903069] hub 4-0:1.0: 5 ports detected
[    7.907524] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    7.913174] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 5
[    7.920604] ohci-pci 0000:00:14.5: irq 18, io mem 0xfeb6c000
[    7.981512] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    7.988332] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.995561] usb usb5: Product: OHCI PCI host controller
[    8.000792] usb usb5: Manufacturer: Linux 4.3.0+ ohci_hcd
[    8.006189] usb usb5: SerialNumber: 0000:00:14.5
[    8.011087] hub 5-0:1.0: USB hub found
[    8.014929] hub 5-0:1.0: 2 ports detected
[    8.019102] uhci_hcd: USB Universal Host Controller Interface driver
[    8.025699] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    8.031002] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
[    8.038603] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    8.163979] AMD-Vi: Completion-Wait loop timed out
[    8.285641] AMD-Vi: Completion-Wait loop timed out
[    8.407365] AMD-Vi: Completion-Wait loop timed out
[    8.529025] AMD-Vi: Completion-Wait loop timed out
[    8.533973] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
[    8.540763] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.547992] usb usb6: Product: xHCI Host Controller
[    8.552877] usb usb6: Manufacturer: Linux 4.3.0+ xhci-hcd
[    8.558275] usb usb6: SerialNumber: 0000:00:10.0
[    8.563043] hub 6-0:1.0: USB hub found
[    8.566845] hub 6-0:1.0: 2 ports detected
[    8.571014] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    8.576328] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 7
[    8.583766] usb usb7: We don't know the algorithms for LPM for this host, disabling LPM.
[    8.591897] usb usb7: New USB device found, idVendor=1d6b, idProduct=0003
[    8.598689] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.605910] usb usb7: Product: xHCI Host Controller
[    8.610796] usb usb7: Manufacturer: Linux 4.3.0+ xhci-hcd
[    8.616194] usb usb7: SerialNumber: 0000:00:10.0
[    8.620948] hub 7-0:1.0: USB hub found
[    8.624745] hub 7-0:1.0: 2 ports detected
[    8.629029] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    8.634302] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 8
[    8.641916] xhci_hcd 0000:00:10.1: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    8.650364] usb 4-5: new low-speed USB device number 2 using ohci-pci
[    8.773733] AMD-Vi: Completion-Wait loop timed out
[    8.895393] AMD-Vi: Completion-Wait loop timed out
[    9.017217] AMD-Vi: Completion-Wait loop timed out
[    9.138874] AMD-Vi: Completion-Wait loop timed out
[    9.143784] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[    9.150576] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.157804] usb usb8: Product: xHCI Host Controller
[    9.162696] ohci-pci 0000:00:13.0: frame counter not updating; disabled
[    9.162698] ohci-pci 0000:00:13.0: HC died; cleaning up
[    9.174571] usb usb8: Manufacturer: Linux 4.3.0+ xhci-hcd
[    9.179971] usb usb8: SerialNumber: 0000:00:10.1
[    9.184737] hub 8-0:1.0: USB hub found
[    9.188538] hub 8-0:1.0: 2 ports detected
[    9.192696] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    9.197991] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 9
[    9.205443] usb usb9: We don't know the algorithms for LPM for this host, disabling LPM.
[    9.213550] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[    9.220341] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.227564] usb usb9: Product: xHCI Host Controller
[    9.232448] usb usb9: Manufacturer: Linux 4.3.0+ xhci-hcd
[    9.237847] usb usb9: SerialNumber: 0000:00:10.1
[    9.242596] hub 9-0:1.0: USB hub found
[    9.246396] hub 9-0:1.0: 2 ports detected
[    9.250600] usbcore: registered new interface driver usbserial
[    9.256473] usbcore: registered new interface driver usbserial_generic
[    9.263008] usbserial: USB Serial support registered for generic
[    9.269072] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    9.393053] AMD-Vi: Completion-Wait loop timed out
[    9.514713] AMD-Vi: Completion-Wait loop timed out
[    9.636521] AMD-Vi: Completion-Wait loop timed out
[    9.758218] AMD-Vi: Completion-Wait loop timed out
[    9.879873] AMD-Vi: Completion-Wait loop timed out
[   10.001549] AMD-Vi: Completion-Wait loop timed out
[   10.123208] AMD-Vi: Completion-Wait loop timed out
[   10.128074] serio: i8042 KBD port at 0x60,0x64 irq 1
[   10.133051] serio: i8042 AUX port at 0x60,0x64 irq 12
[   10.138274] mousedev: PS/2 mouse device common for all mice
[   10.144166] rtc_cmos 00:06: RTC can wake from S4
[   10.148911] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[   10.271847] AMD-Vi: Completion-Wait loop timed out
[   10.393506] AMD-Vi: Completion-Wait loop timed out
[   10.398381] rtc_cmos 00:06: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   10.406115] device-mapper: uevent: version 1.0.3
[   10.410862] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[   10.419751] EFI Variables Facility v0.08 2004-May-17
[   10.432356] hidraw: raw HID events driver (C) Jiri Kosina
[   10.437968] usbcore: registered new interface driver usbhid
[   10.443607] usbhid: USB HID core driver
[   10.447559] drop_monitor: Initializing network drop monitor service
[   10.453970] ip_tables: (C) 2000-2006 Netfilter Core Team
[   10.459358] Initializing XFRM netlink socket
[   10.463834] NET: Registered protocol family 10
[   10.468593] mip6: Mobile IPv6
[   10.471632] NET: Registered protocol family 17
[   10.476088] mce: Unable to init device /dev/mcelog (rc: -5)
[   10.481880] AVX version of gcm_enc/dec engaged.
[   10.486472] AES CTR mode by8 optimization enabled
[   10.535284] registered taskstats version 1
[   10.539475] Loading compiled-in X.509 certificates
[   10.545911] Loaded X.509 cert 'Build time autogenerated kernel key: 973d71201d002d4a90850c219c9e7fe0462e744b'
[   10.555925] zswap: loaded using pool lzo/zbud
[   10.560756]   Magic number: 7:615:459
[   10.564565] rtc_cmos 00:06: setting system clock to 2015-11-06 02:28:42 UTC (1446776922)
[   10.689694] AMD-Vi: Completion-Wait loop timed out
[   10.811355] AMD-Vi: Completion-Wait loop timed out
[   12.703850] ata4.00: qc timeout (cmd 0xec)
[   12.707981] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   13.173916] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   14.018348] AMD-Vi: No event written to event log
[   14.023122] AMD-Vi: Event logged [
[   14.026373] UNKNOWN type=0x0f]
[   14.029629] AMD-Vi: Event logged [
[   14.032857] UNKNOWN type=0x0f]
[   14.036120] AMD-Vi: Event logged [
[   14.039350] UNKNOWN type=0x0f]
[   14.042619] AMD-Vi: Event logged [
[   14.045850] UNKNOWN type=0x0f]
[   14.049101] AMD-Vi: Event logged [
[   14.052331] UNKNOWN type=0x0e]
[   14.055591] AMD-Vi: Event logged [
[   14.058831] UNKNOWN type=0x0f]
[   14.062092] AMD-Vi: Event logged [
[   14.065323] UNKNOWN type=0x0f]
[   14.068576] AMD-Vi: Event logged [
[   14.071805] UNKNOWN type=0x0f]
[   14.075067] AMD-Vi: Event logged [
[   14.078296] UNKNOWN type=0x0f]
[   14.081549] AMD-Vi: Event logged [
[   14.084779] UNKNOWN type=0x0f]
[   14.088041] AMD-Vi: Event logged [
[   14.091271] UNKNOWN type=0x0f]
[   14.094533] AMD-Vi: Event logged [
[   14.097761] UNKNOWN type=0x0f]
[   14.101005] AMD-Vi: Event logged [
[   14.104236] UNKNOWN type=0x0f]
[   14.107505] AMD-Vi: Event logged [
[   14.110737] UNKNOWN type=0x0f]
[   14.113989] AMD-Vi: Event logged [
[   14.117219] UNKNOWN type=0x0f]
[   14.120480] AMD-Vi: Event logged [
[   14.123709] UNKNOWN type=0x0f]
[   14.126972] AMD-Vi: Event logged [
[   14.130201] UNKNOWN type=0x0f]
[   14.133464] AMD-Vi: Event logged [
[   14.136693] UNKNOWN type=0x0f]
[   14.139955] AMD-Vi: Event logged [
[   14.143183] UNKNOWN type=0x0f]
[   14.146444] AMD-Vi: Event logged [
[   14.149675] UNKNOWN type=0x0f]
[   14.152937] AMD-Vi: Event logged [
[   14.156166] UNKNOWN type=0x0f]
[   14.276520] AMD-Vi: No event written to event log
[   14.398401] AMD-Vi: No event written to event log
[   14.520335] AMD-Vi: No event written to event log
[   14.642211] AMD-Vi: No event written to event log
[   14.646981] AMD-Vi: Event logged [
[   14.650210] UNKNOWN type=0x0f]
[   14.653455] AMD-Vi: Event logged [
[   14.656694] UNKNOWN type=0x0c]
[   14.659956] AMD-Vi: Event logged [
[   14.663184] UNKNOWN type=0x0f]
[   14.666446] AMD-Vi: Event logged [
[   14.669677] UNKNOWN type=0x0f]
[   14.790038] AMD-Vi: No event written to event log
[   14.911880] AMD-Vi: No event written to event log
[   15.033785] AMD-Vi: No event written to event log
[   15.064755] sched: RT throttling activated
[   15.159816] AMD-Vi: No event written to event log
[   15.281684] AMD-Vi: No event written to event log
[   15.403553] AMD-Vi: No event written to event log
[   15.525490] AMD-Vi: No event written to event log
[   15.647372] AMD-Vi: No event written to event log
[   15.769246] AMD-Vi: No event written to event log
[   15.891125] AMD-Vi: No event written to event log
[   16.013013] AMD-Vi: No event written to event log
[   16.134854] AMD-Vi: No event written to event log
[   16.256721] AMD-Vi: No event written to event log
[   16.378684] AMD-Vi: No event written to event log
[   16.500557] AMD-Vi: No event written to event log
[   16.622490] AMD-Vi: No event written to event log
[   16.744361] AMD-Vi: No event written to event log
[   16.866231] AMD-Vi: No event written to event log
[   16.988102] AMD-Vi: No event written to event log
[   17.110029] AMD-Vi: No event written to event log
[   17.231869] AMD-Vi: No event written to event log
[   17.353725] AMD-Vi: No event written to event log
[   17.475593] AMD-Vi: No event written to event log
[   17.597494] AMD-Vi: No event written to event log
[   17.719361] AMD-Vi: No event written to event log
[   17.841233] AMD-Vi: No event written to event log
[   17.963110] AMD-Vi: No event written to event log
[   18.085025] AMD-Vi: No event written to event log
[   18.206862] AMD-Vi: No event written to event log
[   18.328838] AMD-Vi: No event written to event log
[   18.450717] AMD-Vi: No event written to event log
[   18.572588] AMD-Vi: No event written to event log
[   18.694458] AMD-Vi: No event written to event log
[   18.816330] AMD-Vi: No event written to event log
[   18.938201] AMD-Vi: No event written to event log
[   19.060076] AMD-Vi: No event written to event log
[   19.181925] AMD-Vi: No event written to event log
[   19.303750] AMD-Vi: No event written to event log
[   19.425622] AMD-Vi: No event written to event log
[   19.547524] AMD-Vi: No event written to event log
[   19.669392] AMD-Vi: No event written to event log
[   19.791270] AMD-Vi: No event written to event log
[   19.796049] AMD-Vi: Event logged [COMMAND_HARDWARE_ERROR address=0x00000000000b11f9 flags=0x0000]
[   19.922054] AMD-Vi: No event written to event log
[   20.043927] AMD-Vi: No event written to event log
[   20.165851] AMD-Vi: No event written to event log
[   20.287733] AMD-Vi: No event written to event log
[   20.409602] AMD-Vi: No event written to event log
[   20.531506] AMD-Vi: No event written to event log
[   20.653379] AMD-Vi: No event written to event log
[   20.775250] AMD-Vi: No event written to event log
[   20.897122] AMD-Vi: No event written to event log
[   21.019025] AMD-Vi: No event written to event log
[   21.140863] AMD-Vi: No event written to event log
[   21.262725] AMD-Vi: No event written to event log
[   21.384597] AMD-Vi: No event written to event log
[   21.506476] AMD-Vi: No event written to event log
[   21.628408] AMD-Vi: No event written to event log
[   21.750277] AMD-Vi: No event written to event log
[   21.872152] AMD-Vi: No event written to event log
[   21.994021] AMD-Vi: No event written to event log
[   22.116019] AMD-Vi: No event written to event log
[   22.237857] AMD-Vi: No event written to event log
[   22.359737] AMD-Vi: No event written to event log
[   22.481609] AMD-Vi: No event written to event log
[   22.603542] AMD-Vi: No event written to event log
[   22.725410] AMD-Vi: No event written to event log
[   22.847282] AMD-Vi: No event written to event log
[   22.969151] AMD-Vi: No event written to event log
[   23.091086] AMD-Vi: No event written to event log
[   23.212932] AMD-Vi: No event written to event log
[   23.334765] AMD-Vi: No event written to event log
[   23.456635] AMD-Vi: No event written to event log
[   23.578570] AMD-Vi: No event written to event log
[   23.700438] AMD-Vi: No event written to event log
[   23.822312] AMD-Vi: No event written to event log
[   23.944179] AMD-Vi: No event written to event log
[   24.066201] AMD-Vi: No event written to event log
[   24.188069] AMD-Vi: No event written to event log
[   24.309905] AMD-Vi: No event written to event log
[   24.431740] AMD-Vi: No event written to event log
[   24.553674] AMD-Vi: No event written to event log
[   24.675544] AMD-Vi: No event written to event log
[   24.797415] AMD-Vi: No event written to event log
[   24.919286] AMD-Vi: No event written to event log
[   25.041219] AMD-Vi: No event written to event log
[   25.163106] AMD-Vi: No event written to event log
[   25.284942] AMD-Vi: No event written to event log
[   25.406762] AMD-Vi: No event written to event log
[   25.528694] AMD-Vi: No event written to event log
[   25.650564] AMD-Vi: No event written to event log
[   25.772436] AMD-Vi: No event written to event log
[   25.894304] AMD-Vi: No event written to event log
[   26.016270] AMD-Vi: No event written to event log
[   26.138145] AMD-Vi: No event written to event log
[   26.260012] AMD-Vi: No event written to event log
[   26.381858] AMD-Vi: No event written to event log
[   26.503729] AMD-Vi: No event written to event log
[   26.625669] AMD-Vi: No event written to event log
[   26.747538] AMD-Vi: No event written to event log
[   26.869419] AMD-Vi: No event written to event log
[   26.991297] AMD-Vi: No event written to event log
[   27.113233] AMD-Vi: No event written to event log
[   27.235102] AMD-Vi: No event written to event log
[   27.356945] AMD-Vi: No event written to event log
[   27.478763] AMD-Vi: No event written to event log
[   27.600715] AMD-Vi: No event written to event log
[   27.722584] AMD-Vi: No event written to event log
[   27.844455] AMD-Vi: No event written to event log
[   27.966325] AMD-Vi: No event written to event log
[   28.088259] AMD-Vi: No event written to event log
[   28.210131] AMD-Vi: No event written to event log
[   28.332000] AMD-Vi: No event written to event log
[   28.453808] AMD-Vi: No event written to event log
[   28.575744] AMD-Vi: No event written to event log
[   28.697614] AMD-Vi: No event written to event log
[   28.819482] AMD-Vi: No event written to event log
[   28.941355] AMD-Vi: No event written to event log
[   29.063287] AMD-Vi: No event written to event log
[   29.185159] AMD-Vi: No event written to event log
[   29.307034] AMD-Vi: No event written to event log
[   29.428871] AMD-Vi: No event written to event log
[   29.550806] AMD-Vi: No event written to event log
[   29.672676] AMD-Vi: No event written to event log
[   29.794546] AMD-Vi: No event written to event log
[   29.916499] AMD-Vi: No event written to event log
[   30.038438] AMD-Vi: No event written to event log
[   30.160314] AMD-Vi: No event written to event log
[   30.282184] AMD-Vi: No event written to event log
[   30.404056] AMD-Vi: No event written to event log
[   30.525955] AMD-Vi: No event written to event log
[   30.647770] AMD-Vi: No event written to event log
[   30.769641] AMD-Vi: No event written to event log
[   30.891520] AMD-Vi: No event written to event log
[   31.013393] AMD-Vi: No event written to event log
[   31.135267] AMD-Vi: No event written to event log
[   31.257134] AMD-Vi: No event written to event log
[   31.379006] AMD-Vi: No event written to event log
[   31.500816] AMD-Vi: No event written to event log
[   31.622761] AMD-Vi: No event written to event log
[   31.744627] AMD-Vi: No event written to event log
[   31.866594] AMD-Vi: No event written to event log
[   31.988462] AMD-Vi: No event written to event log
[   32.110415] AMD-Vi: No event written to event log
[   32.232285] AMD-Vi: No event written to event log
[   32.354153] AMD-Vi: No event written to event log
[   32.476027] AMD-Vi: No event written to event log
[   32.597924] AMD-Vi: No event written to event log
[   32.719759] AMD-Vi: No event written to event log
[   32.841630] AMD-Vi: No event written to event log
[   32.963500] AMD-Vi: No event written to event log
[   33.085434] AMD-Vi: No event written to event log
[   33.207303] AMD-Vi: No event written to event log
[   33.329172] AMD-Vi: No event written to event log
[   33.451054] AMD-Vi: No event written to event log
[   33.572955] AMD-Vi: No event written to event log
[   33.694876] AMD-Vi: No event written to event log
[   33.816835] AMD-Vi: No event written to event log
[   33.938712] AMD-Vi: No event written to event log
[   34.060643] AMD-Vi: No event written to event log
[   34.182521] AMD-Vi: No event written to event log
[   34.304391] AMD-Vi: No event written to event log
[   34.426263] AMD-Vi: No event written to event log
[   34.548213] AMD-Vi: No event written to event log
[   34.670081] AMD-Vi: No event written to event log
[   34.791922] AMD-Vi: No event written to event log
[   34.913764] AMD-Vi: No event written to event log
[   35.035697] AMD-Vi: No event written to event log
[   35.157568] AMD-Vi: No event written to event log
[   35.279437] AMD-Vi: No event written to event log
[   35.401317] AMD-Vi: No event written to event log
[   35.523221] AMD-Vi: No event written to event log
[   35.645093] AMD-Vi: No event written to event log
[   35.767025] AMD-Vi: No event written to event log
[   35.888833] AMD-Vi: No event written to event log
[   36.010715] AMD-Vi: No event written to event log
[   36.132616] AMD-Vi: No event written to event log
[   36.254482] AMD-Vi: No event written to event log
[   36.376354] AMD-Vi: No event written to event log
[   36.498222] AMD-Vi: No event written to event log
[   36.620100] AMD-Vi: No event written to event log
[   36.741941] AMD-Vi: No event written to event log
[   36.863776] AMD-Vi: No event written to event log
[   36.985647] AMD-Vi: No event written to event log
[   37.107520] AMD-Vi: No event written to event log
[   37.229389] AMD-Vi: No event written to event log
[   37.351260] AMD-Vi: No event written to event log
[   37.473129] AMD-Vi: No event written to event log
[   37.594971] AMD-Vi: No event written to event log
[   37.716874] AMD-Vi: No event written to event log
[   37.838744] AMD-Vi: No event written to event log
[   37.960614] AMD-Vi: No event written to event log
[   38.082515] AMD-Vi: No event written to event log
[   38.204383] AMD-Vi: No event written to event log
[   38.326260] AMD-Vi: No event written to event log
[   38.448150] AMD-Vi: No event written to event log
[   38.570052] AMD-Vi: No event written to event log
[   38.691890] AMD-Vi: No event written to event log
[   38.813763] AMD-Vi: No event written to event log
[   38.935634] AMD-Vi: No event written to event log
[   39.057538] AMD-Vi: No event written to event log
[   39.179410] AMD-Vi: No event written to event log
[   39.301279] AMD-Vi: No event written to event log
[   39.423153] AMD-Vi: No event written to event log
[   39.545087] AMD-Vi: No event written to event log
[   39.667017] AMD-Vi: No event written to event log
[   39.788826] AMD-Vi: No event written to event log
[   39.910696] AMD-Vi: No event written to event log
[   40.032631] AMD-Vi: No event written to event log
[   40.154497] AMD-Vi: No event written to event log
[   40.276369] AMD-Vi: No event written to event log
[   40.398240] AMD-Vi: No event written to event log
[   40.520175] AMD-Vi: No event written to event log
[   40.642051] AMD-Vi: No event written to event log
[   40.763887] AMD-Vi: No event written to event log
[   40.885766] AMD-Vi: No event written to event log
[   41.007638] AMD-Vi: No event written to event log
[   41.129572] AMD-Vi: No event written to event log
[   41.251440] AMD-Vi: No event written to event log
[   41.373312] AMD-Vi: No event written to event log
[   41.495181] AMD-Vi: No event written to event log
[   41.617215] AMD-Vi: No event written to event log
[   41.739097] AMD-Vi: No event written to event log
[   41.860934] AMD-Vi: No event written to event log
[   41.982770] AMD-Vi: No event written to event log
[   42.104704] AMD-Vi: No event written to event log
[   42.226574] AMD-Vi: No event written to event log
[   42.348450] AMD-Vi: No event written to event log
[   42.470322] AMD-Vi: No event written to event log
[   42.592257] AMD-Vi: No event written to event log
[   42.714123] AMD-Vi: No event written to event log
[   42.835960] AMD-Vi: No event written to event log
[   42.957795] AMD-Vi: No event written to event log
[   43.079730] AMD-Vi: No event written to event log
[   43.201619] AMD-Vi: No event written to event log
[   43.323486] AMD-Vi: No event written to event log
[   43.445357] AMD-Vi: No event written to event log
[   43.567389] AMD-Vi: No event written to event log
[   43.689265] AMD-Vi: No event written to event log
[   43.811135] AMD-Vi: No event written to event log
[   43.932973] AMD-Vi: No event written to event log
[   44.054862] AMD-Vi: No event written to event log
[   44.176732] AMD-Vi: No event written to event log
[   44.298601] AMD-Vi: No event written to event log
[   44.420473] AMD-Vi: No event written to event log
[   44.542408] AMD-Vi: No event written to event log
[   44.664285] AMD-Vi: No event written to event log
[   44.786155] AMD-Vi: No event written to event log
[   44.908025] AMD-Vi: No event written to event log
[   45.029899] AMD-Vi: No event written to event log
[   45.151770] AMD-Vi: No event written to event log
[   45.273638] AMD-Vi: No event written to event log
[   45.395511] AMD-Vi: No event written to event log
[   45.517469] AMD-Vi: No event written to event log
[   45.639339] AMD-Vi: No event written to event log
[   45.761217] AMD-Vi: No event written to event log
[   45.883088] AMD-Vi: No event written to event log
[   46.004924] AMD-Vi: No event written to event log
[   46.126832] AMD-Vi: No event written to event log
[   46.248701] AMD-Vi: No event written to event log
[   46.370574] AMD-Vi: No event written to event log
[   46.492442] AMD-Vi: No event written to event log
[   46.614378] AMD-Vi: No event written to event log
[   46.736245] AMD-Vi: No event written to event log
[   46.858116] AMD-Vi: No event written to event log
[   46.979960] AMD-Vi: No event written to event log
[   47.101858] AMD-Vi: No event written to event log
[   47.223727] AMD-Vi: No event written to event log
[   47.345602] AMD-Vi: No event written to event log
[   47.467563] AMD-Vi: No event written to event log
[   47.589499] AMD-Vi: No event written to event log
[   47.711369] AMD-Vi: No event written to event log
[   47.833241] AMD-Vi: No event written to event log
[   47.955109] AMD-Vi: No event written to event log
[   48.077008] AMD-Vi: No event written to event log
[   48.198819] AMD-Vi: No event written to event log
[   48.320690] AMD-Vi: No event written to event log
[   48.442559] AMD-Vi: No event written to event log
[   48.564492] AMD-Vi: No event written to event log
[   48.686369] AMD-Vi: No event written to event log
[   48.808241] AMD-Vi: No event written to event log
[   48.930113] AMD-Vi: No event written to event log
[   49.052010] AMD-Vi: No event written to event log
[   49.173827] AMD-Vi: No event written to event log
[   49.295700] AMD-Vi: No event written to event log
[   49.417666] AMD-Vi: No event written to event log
[   49.539599] AMD-Vi: No event written to event log
[   49.661467] AMD-Vi: No event written to event log
[   49.783339] AMD-Vi: No event written to event log
[   49.905209] AMD-Vi: No event written to event log
[   50.027144] AMD-Vi: No event written to event log
[   50.148995] AMD-Vi: No event written to event log
[   50.270807] AMD-Vi: No event written to event log
[   50.392674] AMD-Vi: No event written to event log
[   50.514545] AMD-Vi: No event written to event log
[   50.636418] AMD-Vi: No event written to event log
[   50.758287] AMD-Vi: No event written to event log
[   50.880159] AMD-Vi: No event written to event log
[   51.002031] AMD-Vi: No event written to event log
[   51.123904] AMD-Vi: No event written to event log
[   51.245778] AMD-Vi: No event written to event log
[   51.367749] AMD-Vi: No event written to event log
[   51.489616] AMD-Vi: No event written to event log
[   51.611549] AMD-Vi: No event written to event log
[   51.733419] AMD-Vi: No event written to event log
[   51.855299] AMD-Vi: No event written to event log
[   51.977170] AMD-Vi: No event written to event log
[   52.099102] AMD-Vi: No event written to event log
[   52.220939] AMD-Vi: No event written to event log
[   52.342790] AMD-Vi: No event written to event log
[   52.464661] AMD-Vi: No event written to event log
[   52.586594] AMD-Vi: No event written to event log
[   52.708465] AMD-Vi: No event written to event log
[   52.830334] AMD-Vi: No event written to event log
[   52.952205] AMD-Vi: No event written to event log
[   53.074140] AMD-Vi: No event written to event log
[   53.195976] AMD-Vi: No event written to event log
[   53.317910] AMD-Vi: No event written to event log
[   53.439778] AMD-Vi: No event written to event log
[   53.561690] AMD-Vi: No event written to event log
[   53.683561] AMD-Vi: No event written to event log
[   53.805433] AMD-Vi: No event written to event log
[   53.927311] AMD-Vi: No event written to event log
[   54.049215] AMD-Vi: No event written to event log
[   54.171097] AMD-Vi: No event written to event log
[   54.292934] AMD-Vi: No event written to event log
[   54.414786] AMD-Vi: No event written to event log
[   54.536674] AMD-Vi: No event written to event log
[   54.658546] AMD-Vi: No event written to event log
[   54.780416] AMD-Vi: No event written to event log
[   54.902288] AMD-Vi: No event written to event log
[   55.024159] AMD-Vi: No event written to event log
[   55.145995] AMD-Vi: No event written to event log
[   55.267912] AMD-Vi: No event written to event log
[   55.389789] AMD-Vi: No event written to event log
[   55.511659] AMD-Vi: No event written to event log
[   55.633532] AMD-Vi: No event written to event log
[   55.755402] AMD-Vi: No event written to event log
[   55.877271] AMD-Vi: No event written to event log
[   55.999145] AMD-Vi: No event written to event log
[   56.121020] AMD-Vi: No event written to event log
[   56.242823] AMD-Vi: No event written to event log
[   56.364703] AMD-Vi: No event written to event log
[   56.486575] AMD-Vi: No event written to event log
[   56.608486] AMD-Vi: No event written to event log
[   56.730359] AMD-Vi: No event written to event log
[   56.852230] AMD-Vi: No event written to event log
[   56.974102] AMD-Vi: No event written to event log
[   57.095970] AMD-Vi: No event written to event log
[   57.217895] AMD-Vi: No event written to event log
[   57.339766] AMD-Vi: No event written to event log
[   57.461638] AMD-Vi: No event written to event log
[   57.583539] AMD-Vi: No event written to event log
[   57.705404] AMD-Vi: No event written to event log
[   57.827276] AMD-Vi: No event written to event log
[   57.949146] AMD-Vi: No event written to event log
[   58.071053] AMD-Vi: No event written to event log
[   58.192864] AMD-Vi: No event written to event log
[   58.197640] AMD-Vi: Event logged [ILLEGAL_COMMAND_ERROR address=0x010f00000047eb81]
[   58.205328] general protection fault: 0000 [#1] SMP 
[   58.210325] Modules linked in:
[   58.213404] CPU: 0 PID: 26 Comm: irq/24-AMD-Vi Not tainted 4.3.0+ #69
[   58.219852] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88X-D3H, BIOS F5 05/28/2014
[   58.229856] task: ffff8800339e5e80 ti: ffff880035a4c000 task.ti: ffff880035a4c000
[   58.237336] RIP: 0010:[<ffffffff814b05c1>]  [<ffffffff814b05c1>] amd_iommu_int_thread+0x371/0x4a0
[   58.246236] RSP: 0018:ffff880035a4fdb0  EFLAGS: 00010246
[   58.251545] RAX: ffff880000000000 RBX: 0000000000000000 RCX: 010e88000047eb81
[   58.258678] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
[   58.265811] RBP: ffff880035a4fe20 R08: 0000000000000002 R09: 0000000000000496
[   58.272943] R10: ffff8800341f5840 R11: 0000000000000496 R12: ffff8800341e8800
[   58.280076] R13: 0000000000001840 R14: 0000000000000093 R15: ffff8800341f5840
[   58.287219] FS:  00007f6b8eee5700(0000) GS:ffff880037c00000(0000) knlGS:0000000000000000
[   58.295308] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.301048] CR2: 00007f6b8e67b848 CR3: 0000000036c09000 CR4: 00000000000406b0
[   58.308199] Stack:
[   58.310217]  381113ef4d9a8bbf 00000b0037c16c80 000053fa00000000 0000000000000005
[   58.317695]  0000000000e853fa ffffffff81c10980 ffffffff81c104c0 ffff880035a4fe30
[   58.325166]  00000000b5bdbf82 ffff880033bfbf00 ffff880035a44000 ffff880035a44000
[   58.332646] Call Trace:
[   58.335107]  [<ffffffff810f4070>] ? irq_forced_thread_fn+0x70/0x70
[   58.341292]  [<ffffffff810f4090>] irq_thread_fn+0x20/0x50
[   58.346691]  [<ffffffff810f4368>] irq_thread+0x138/0x1c0
[   58.352003]  [<ffffffff810f4180>] ? wake_threads_waitq+0x30/0x30
[   58.358018]  [<ffffffff810f4230>] ? irq_thread_dtor+0xb0/0xb0
[   58.363765]  [<ffffffff810bb7a8>] kthread+0xd8/0xf0
[   58.368651]  [<ffffffff810bb6d0>] ? kthread_worker_fn+0x160/0x160
[   58.374743]  [<ffffffff8178b88f>] ret_from_fork+0x3f/0x70
[   58.380144]  [<ffffffff810bb6d0>] ? kthread_worker_fn+0x160/0x160
[   58.386243] Code: c7 78 43 ac 81 e8 25 7e ce ff eb b2 48 89 de 48 c7 c7 48 43 ac 81 e8 14 7e ce ff 48 b8 00 00 00 00 00 88 ff ff 48 8d 0c 03 31 db <8b> 14 99 89 de 48 c7 c7 ea 15 aa 81  
[   58.406217] RIP  [<ffffffff814b05c1>] amd_iommu_int_thread+0x371/0x4a0
[   58.412770]  RSP <ffff880035a4fdb0>
[   58.416269] ---[ end trace f9b4fcc4380d17cc ]---
[   58.420910] ata4.00: qc timeout (cmd 0xec)
[   58.425023] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   58.431124] ata4: limiting SATA link speed to 1.5 Gbps
[   58.896507] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   60.117536] BUG: unable to handle kernel paging request at ffffffffffffffd8
[   60.124561] IP: [<ffffffff810bbe00>] kthread_data+0x10/0x20
[   60.130179] PGD 36c0c067 PUD 36c0e067 PMD 0 
[   60.134504] Oops: 0000 [#2] SMP 
[   60.137771] Modules linked in:
[   60.140848] CPU: 0 PID: 26 Comm: irq/24-AMD-Vi Tainted: G      D         4.3.0+ #69
[   60.148514] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88X-D3H, BIOS F5 05/28/2014
[   60.158507] task: ffff8800339e5e80 ti: ffff880035a4c000 task.ti: ffff880035a4c000
[   60.165994] RIP: 0010:[<ffffffff810bbe00>]  [<ffffffff810bbe00>] kthread_data+0x10/0x20
[   60.174034] RSP: 0018:ffff880035a4fbb0  EFLAGS: 00010202
[   60.179354] RAX: 0000000000000000 RBX: ffff8800339e5e80 RCX: 0000000000000000
[   60.186486] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8800339e5e80
[   60.193619] RBP: ffff880035a4fbb0 R08: 0000000000000000 R09: ffff880035a4fb90
[   60.200751] R10: 0000000000000000 R11: 0000000000000004 R12: ffff8800339e6470
[   60.207885] R13: ffff8800339e5e80 R14: 0000000000000000 R15: ffff8800341f5840
[   60.215028] FS:  00007f6b8eee5700(0000) GS:ffff880037c00000(0000) knlGS:0000000000000000
[   60.223117] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.228867] CR2: ffffffffffffffd8 CR3: 0000000036c09000 CR4: 00000000000406b0
[   60.235999] Stack:
[   60.238018]  ffff880035a4fbd0 ffffffff810f41a3 ffffffff81f17d40 ffff8800339e6470
[   60.245488]  ffff880035a4fc00 ffffffff810b9c83 ffff8800339e5e80 000000000000000b
[   60.252948]  0000000000000000 0000000000000001 ffff880035a4fc78 ffffffff810a091d
[   60.260411] Call Trace:
[   60.262869]  [<ffffffff810f41a3>] irq_thread_dtor+0x23/0xb0
[   60.268458]  [<ffffffff810b9c83>] task_work_run+0x73/0x90
[   60.273865]  [<ffffffff810a091d>] do_exit+0x38d/0xaa0
[   60.278918]  [<ffffffff810188ca>] oops_end+0x9a/0xd0
[   60.283891]  [<ffffffff81018d8b>] die+0x4b/0x70
[   60.288426]  [<ffffffff810162f9>] do_general_protection+0xc9/0x150
[   60.294605]  [<ffffffff8178d6a8>] general_protection+0x28/0x30
[   60.300440]  [<ffffffff814b05c1>] ? amd_iommu_int_thread+0x371/0x4a0
[   60.306790]  [<ffffffff810f4070>] ? irq_forced_thread_fn+0x70/0x70
[   60.312969]  [<ffffffff810f4090>] irq_thread_fn+0x20/0x50
[   60.318369]  [<ffffffff810f4368>] irq_thread+0x138/0x1c0
[   60.323681]  [<ffffffff810f4180>] ? wake_threads_waitq+0x30/0x30
[   60.329698]  [<ffffffff810f4230>] ? irq_thread_dtor+0xb0/0xb0
[   60.335442]  [<ffffffff810bb7a8>] kthread+0xd8/0xf0
[   60.340331]  [<ffffffff810bb6d0>] ? kthread_worker_fn+0x160/0x160
[   60.346422]  [<ffffffff8178b88f>] ret_from_fork+0x3f/0x70
[   60.351824]  [<ffffffff810bb6d0>] ? kthread_worker_fn+0x160/0x160
[   60.357922] Code: cf 48 89 e7 e8 82 cd 6c 00 e9 55 ff ff ff e8 a8 1d fe ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 48 04 00 00 55 48 89 e5 <48> 8b 40 d8 5d c3 66 2e 0f 1f 84 00  
[   60.377879] RIP  [<ffffffff810bbe00>] kthread_data+0x10/0x20
[   60.383564]  RSP <ffff880035a4fbb0>
[   60.387066] CR2: ffffffffffffffd8
[   60.390388] ---[ end trace f9b4fcc4380d17cd ]---
[   60.395005] Fixing recursive fault but reboot is needed!
[   88.904126] ata4.00: qc timeout (cmd 0xec)
[   88.908243] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   89.374180] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   89.382666] Freeing unused kernel memory: 1508K (ffffffff81d3c000 - ffffffff81eb5000)
[   89.390572] Write protecting the kernel read-only data: 12288k
[   89.396762] Freeing unused kernel memory: 436K (ffff880036793000 - ffff880036800000)
[   89.407368] Freeing unused kernel memory: 700K (ffff880036b51000 - ffff880036c00000)
[   89.430438] ------------[ cut here ]------------
[   89.435126] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:225 note_page+0x5e1/0x780()
[   89.443835] x86/mm: Found insecure W+X mapping at address fffffffefd06e000/0xfffffffefd06e000
[   89.452361] Modules linked in:
[   89.455451] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D         4.3.0+ #69
[   89.462676] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88X-D3H, BIOS F5 05/28/2014
[   89.472677]  0000000000000000 00000000c8d99987 ffff8800341dbd48 ffffffff813922ff
[   89.480173]  ffff8800341dbd90 ffff8800341dbd80 ffffffff8109ddb2 ffff8800341dbe90
[   89.487661]  00000000000000e3 0000000000000003 0000000000000000 0000000000000000
[   89.495153] Call Trace:
[   89.497612]  [<ffffffff813922ff>] dump_stack+0x44/0x55
[   89.502758]  [<ffffffff8109ddb2>] warn_slowpath_common+0x82/0xc0
[   89.508771]  [<ffffffff8109de4c>] warn_slowpath_fmt+0x5c/0x80
[   89.514517]  [<ffffffff8106d711>] note_page+0x5e1/0x780
[   89.519743]  [<ffffffff8106dadf>] ptdump_walk_pgd_level_core+0x22f/0x440
[   89.526446]  [<ffffffff8106dd97>] ptdump_walk_pgd_level_checkwx+0x17/0x20
[   89.533238]  [<ffffffff810639b4>] mark_rodata_ro+0xf4/0x100
[   89.538828]  [<ffffffff8177fdc0>] ? rest_init+0x80/0x80
[   89.544051]  [<ffffffff8177fddd>] kernel_init+0x1d/0xe0
[   89.549279]  [<ffffffff8178b88f>] ret_from_fork+0x3f/0x70
[   89.554678]  [<ffffffff8177fdc0>] ? rest_init+0x80/0x80
[   89.559903] ---[ end trace f9b4fcc4380d17ce ]---
[   89.564610] x86/mm: Checked W+X mappings: FAILED, 10500 W+X pages found.
[   89.690381] AMD-Vi: Completion-Wait loop timed out
[   89.709306] random: systemd urandom read with 7 bits of entropy available
[   89.833298] AMD-Vi: Completion-Wait loop timed out
[   89.954960] AMD-Vi: Completion-Wait loop timed out
[   90.076764] AMD-Vi: Completion-Wait loop timed out
[   90.082369] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELF)
[   90.100589] systemd[1]: Detected architecture x86-64.
[   90.105692] systemd[1]: Running in initial RAM disk.
[   90.227556] AMD-Vi: Completion-Wait loop timed out
[   90.349212] AMD-Vi: Completion-Wait loop timed out

Welcome to Fedora 22 (Twenty Two) dracut-041-10.fc22.1 (Initramfs)!

[   90.480129] AMD-Vi: Completion-Wait loop timed out
[   90.485133] systemd[1]: Set hostname to <dhcp-128-84.nay.redhat.com>.
[   90.657994] AMD-Vi: Completion-Wait loop timed out
[   90.779649] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Timers.
[   90.906091] AMD-Vi: Completion-Wait loop timed out
[   90.910991] systemd[1]: Reached target Timers.
[   90.915479] systemd[1]: Starting Timers.
[   90.919567] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   90.927549] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[   91.052478] AMD-Vi: Completion-Wait loop timed out
[   91.174136] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Paths.
[   91.301175] AMD-Vi: Completion-Wait loop timed out
[   91.306111] systemd[1]: Reached target Paths.
[   91.310512] systemd[1]: Starting Paths.
[   91.431281] AMD-Vi: Completion-Wait loop timed out
[   91.552939] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Swap.
[   91.680156] AMD-Vi: Completion-Wait loop timed out
[   91.685073] systemd[1]: Reached target Swap.
[   91.689388] systemd[1]: Starting Swap.
[   91.810407] AMD-Vi: Completion-Wait loop timed out
[   91.932074] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Created slice -.slice.
[   92.059177] AMD-Vi: Completion-Wait loop timed out
[   92.064096] systemd[1]: Created slice -.slice.
[   92.068584] systemd[1]: Starting -.slice.
[   92.189640] AMD-Vi: Completion-Wait loop timed out
[   92.311299] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on Journal Socket (/dev/log).
[   92.440230] AMD-Vi: Completion-Wait loop timed out
[   92.445196] systemd[1]: Listening on Journal Socket (/dev/log).
[   92.451157] systemd[1]: Starting Journal Socket (/dev/log).
[   92.573736] AMD-Vi: Completion-Wait loop timed out
[   92.695400] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on udev Kernel Socket.
[   92.824262] AMD-Vi: Completion-Wait loop timed out
[   92.829225] systemd[1]: Listening on udev Kernel Socket.
[   92.834580] systemd[1]: Starting udev Kernel Socket.
[   92.956634] AMD-Vi: Completion-Wait loop timed out
[   93.078294] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Created slice System Slice.
[   93.205316] AMD-Vi: Completion-Wait loop timed out
[   93.210274] systemd[1]: Created slice System Slice.
[   93.215210] systemd[1]: Starting System Slice.
[   93.336769] AMD-Vi: Completion-Wait loop timed out
[   93.458431] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Created slice system-systemd\x2dfsck.slice.
[   93.587303] AMD-Vi: Completion-Wait loop timed out
[   93.592263] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   93.598573] systemd[1]: Starting system-systemd\x2dfsck.slice.
[   93.721336] AMD-Vi: Completion-Wait loop timed out
[   93.842997] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Slices.
[   93.970359] AMD-Vi: Completion-Wait loop timed out
[   93.975314] systemd[1]: Reached target Slices.
[   93.979805] systemd[1]: Starting Slices.
[   94.100768] AMD-Vi: Completion-Wait loop timed out
[   94.222425] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on Journal Socket.
[   94.349379] AMD-Vi: Completion-Wait loop timed out
[   94.354336] systemd[1]: Listening on Journal Socket.
[   94.359347] systemd[1]: Starting Journal Socket.
[   94.364820] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[   94.492793] AMD-Vi: Completion-Wait loop timed out
[   94.614456] AMD-Vi: Completion-Wait loop timed out
         Starting Create list of required st... nodes for the current kernel...
[   94.746370] AMD-Vi: Completion-Wait loop timed out
[   94.751588] systemd[1]: Started Load Kernel Modules.
[   94.756724] systemd[1]: Started dracut ask for additional cmdline parameters.
[   94.764662] systemd[1]: Starting dracut cmdline hook...
[   94.890231] AMD-Vi: Completion-Wait loop timed out
[   95.011892] AMD-Vi: Completion-Wait loop timed out
         Starting dracut cmdline hook...
[   95.237430] AMD-Vi: Completion-Wait loop timed out
[   95.243129] systemd[1]: Starting Apply Kernel Variables...
[   95.367288] AMD-Vi: Completion-Wait loop timed out
[   95.488949] AMD-Vi: Completion-Wait loop timed out
         Starting Apply Kernel Variables...
[   95.617469] AMD-Vi: Completion-Wait loop timed out
[   95.739394] AMD-Vi: Completion-Wait loop timed out
[   95.861052] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on udev Control Socket.
[   95.989398] AMD-Vi: Completion-Wait loop timed out
[   95.994361] systemd[1]: Listening on udev Control Socket.
[   95.999835] systemd[1]: Starting udev Control Socket.
[   96.121886] AMD-Vi: Completion-Wait loop timed out
[   96.243546] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on Journal Audit Socket.
[   96.371421] AMD-Vi: Completion-Wait loop timed out
[   96.376390] systemd[1]: Listening on Journal Audit Socket.
[   96.381948] systemd[1]: Starting Journal Audit Socket.
[   96.387913] systemd[1]: Starting Journal Service...
[   96.512592] AMD-Vi: Completion-Wait loop timed out
[   96.634251] AMD-Vi: Completion-Wait loop timed out
         Starting Journal Service...
[   96.804446] AMD-Vi: Completion-Wait loop timed out
[   96.926437] AMD-Vi: Completion-Wait loop timed out
[   97.048101] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Sockets.
[   97.175508] AMD-Vi: Completion-Wait loop timed out
[   97.180559] systemd[1]: Reached target Sockets.
[   97.185176] systemd[1]: Starting Sockets.
[   97.306238] AMD-Vi: Completion-Wait loop timed out
[   97.427901] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Local File Systems.
[   97.556562] AMD-Vi: Completion-Wait loop timed out
[   97.561625] systemd[1]: Reached target Local File Systems.
[   97.567191] systemd[1]: Starting Local File Systems.
[   97.689732] AMD-Vi: Completion-Wait loop timed out
[   97.811393] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Journal Service.
[   97.938510] AMD-Vi: Completion-Wait loop timed out
[   97.943570] systemd[1]: Started Journal Service.
[   97.948547] audit: type=1130 audit(1446777009.877:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hos'
[   98.085858] AMD-Vi: Completion-Wait loop timed out
[   98.207522] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[   98.339609] AMD-Vi: Completion-Wait loop timed out
[   98.345122] audit: type=1130 audit(1446777010.273:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" ho'
[   98.482428] AMD-Vi: Completion-Wait loop timed out
[   98.604094] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started dracut cmdline hook.
[   98.730566] AMD-Vi: Completion-Wait loop timed out
[   98.736045] audit: type=1130 audit(1446777010.664:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostn'
[   98.873010] AMD-Vi: Completion-Wait loop timed out
[   98.994657] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Apply Kernel Variables.
[   99.122580] AMD-Vi: Completion-Wait loop timed out
[   99.128089] audit: type=1130 audit(1446777011.056:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostn'
[   99.272467] AMD-Vi: Completion-Wait loop timed out
[   99.394129] AMD-Vi: Completion-Wait loop timed out
         Starting dracut pre-udev hook...
[   99.524460] AMD-Vi: Completion-Wait loop timed out
[   99.682192] AMD-Vi: Completion-Wait loop timed out
[   99.803823] AMD-Vi: Completion-Wait loop timed out
         Starting Create Static Device Nodes in /dev...
[   99.935713] AMD-Vi: Completion-Wait loop timed out
[  100.058614] AMD-Vi: Completion-Wait loop timed out
[  100.180277] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started dracut pre-udev hook.
[  100.307746] AMD-Vi: Completion-Wait loop timed out
[  100.313220] audit: type=1130 audit(1446777012.241:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" host'
[  100.450304] AMD-Vi: Completion-Wait loop timed out
[  100.571967] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Create Static Device Nodes in /dev.
[  100.700765] AMD-Vi: Completion-Wait loop timed out
[  100.706244] audit: type=1130 audit(1446777012.634:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/sy'
[  100.849535] AMD-Vi: Completion-Wait loop timed out
[  100.971197] AMD-Vi: Completion-Wait loop timed out
         Starting udev Kernel Device Manager...
[  101.103779] AMD-Vi: Completion-Wait loop timed out
[  101.226357] AMD-Vi: Completion-Wait loop timed out
[  101.348015] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started udev Kernel Device Manager.
[  101.476751] AMD-Vi: Completion-Wait loop timed out
[  101.482268] audit: type=1130 audit(1446777013.410:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostna'
[  101.619923] AMD-Vi: Completion-Wait loop timed out
[  101.741587] AMD-Vi: Completion-Wait loop timed out
         Starting dracut pre-trigger hook...
[  101.872594] AMD-Vi: Completion-Wait loop timed out
[  102.009972] AMD-Vi: Completion-Wait loop timed out
[  102.131642] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started dracut pre-trigger hook.
[  102.259757] AMD-Vi: Completion-Wait loop timed out
[  102.265268] audit: type=1130 audit(1446777014.193:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-trigger comm="systemd" exe="/usr/lib/systemd/systemd" h'
[  102.403487] AMD-Vi: Completion-Wait loop timed out
[  102.525153] AMD-Vi: Completion-Wait loop timed out
         Starting udev Coldplug all Devices...
[  102.655658] AMD-Vi: Completion-Wait loop timed out
[  102.812481] AMD-Vi: Completion-Wait loop timed out
[  102.934152] AMD-Vi: Completion-Wait loop timed out
[  102.989420] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[  103.002692] [drm] Initialized drm 1.1.0 20060810
[  103.128288] AMD-Vi: Completion-Wait loop timed out
         Mounting Configuration File System...
[  103.325680] AMD-Vi: Completion-Wait loop timed out
[  103.361888] [drm] radeon kernel modesetting enabled.
[  103.371392] [drm] initializing kernel modesetting (KAVERI 0x1002:0x130F 0x1002:0x0123).
[  103.380910] r8169 0000:01:00.0 eth0: RTL8168evl/8111evl at 0xffffc900000ee000, fc:aa:14:c0:c2:7e, XID 0c900880 IRQ 31
[  103.391582] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[  103.403272] [drm] register mmio base: 0xFEB00000
[  103.407955] [drm] register mmio size: 262144
[  103.412324] [drm] doorbell mmio base: 0xD0000000
[  103.416952] [drm] doorbell mmio size: 8388608
[  103.430840] ATOM BIOS: 113
[  103.437837] radeon 0000:00:01.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[  103.446781] radeon 0000:00:01.0: GTT: 2048M 0x0000000040000000 - 0x00000000BFFFFFFF
[  103.454448] [drm] Detected VRAM RAM=1024M, BAR=256M
[  103.459329] [drm] RAM width 128bits DDR
[  103.580832] AMD-Vi: Completion-Wait loop timed out
[  103.702492] AMD-Vi: Completion-Wait loop timed out
[  103.740945] [TTM] Zone  kernel: Available graphics memory: 120766 kiB
[  103.747458] [TTM] Initializing pool allocator
[  103.760903] [TTM] Initializing DMA pool allocator
[  103.765717] [drm] radeon: 1024M of VRAM memory ready
[  103.770795] [drm] radeon: 2048M of GTT memory ready.
[  103.775783] [drm] Loading kaveri Microcode
[  103.780126] [drm] Internal thermal controller without fan control
[  103.788243] [drm] radeon: dpm initialized
[  103.795394] [drm] Found VCE firmware/feedback version 40.2.2 / 15!
[  103.801724] [drm] GART: num cpu pages 524288, num gpu pages 524288
[  103.815106] [drm] PCIE GART of 2048M enabled (table at 0x0000000000324000).
[  103.822247] radeon 0000:00:01.0: WB enabled
[  103.826772] radeon 0000:00:01.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffff88002ff52c00
[  103.837627] radeon 0000:00:01.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffff88002ff52c04
[  103.848409] radeon 0000:00:01.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffff88002ff52c08
[  103.859191] radeon 0000:00:01.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffff88002ff52c0c
[  103.869972] radeon 0000:00:01.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffff88002ff52c10
[  103.881176] radeon 0000:00:01.0: fence driver on ring 5 use gpu addr 0x0000000000076c98 and cpu addr 0xffffc90000436c98
[  103.892708] radeon 0000:00:01.0: fence driver on ring 6 use gpu addr 0x0000000040000c18 and cpu addr 0xffff88002ff52c18
[  103.903559] radeon 0000:00:01.0: fence driver on ring 7 use gpu addr 0x0000000040000c1c and cpu addr 0xffff88002ff52c1c
[  103.914536] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[  103.921188] [drm] Driver supports precise vblank timestamp query.
[  103.927389] do_IRQ: 0.195 No irq handler for vector
[  104.049591] AMD-Vi: Completion-Wait loop timed out
[[  104.054630] radeon 0000:00:01.0: radeon: using MSI.
  OK  ][  104.176562] AMD-Vi: Completion-Wait loop timed out
[  104.298239] AMD-Vi: Completion-Wait loop timed out
 Mounted Configu[  104.303172] [drm] radeon: irq initialized.
ration File System.
[  104.731543] AMD-Vi: Completion-Wait loop timed out
[  104.853951] AMD-Vi: Completion-Wait loop timed out
[  104.975611] AMD-Vi: Completion-Wait loop timed out
[  105.128194] [drm:cik_ring_test [radeon]] *ERROR* radeon: ring 0 test failed (scratch(0x3010C)=0xCAFEDEAD)
[  105.137794] radeon 0000:00:01.0: disabling GPU acceleration
[  OK  ] Started udev Coldplug all Devices.
[  105.555537] AMD-Vi: Completion-Wait loop timed out
[  105.560765] audit: type=1130 audit(1446777017.489:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd'
[  105.703566] AMD-Vi: Completion-Wait loop timed out
[  105.825233] AMD-Vi: Completion-Wait loop timed out
[  105.948074] AMD-Vi: Completion-Wait loop timed out
         Starting dracut initqueue hook...
[  106.078832] AMD-Vi: Completion-Wait loop timed out
[  106.215441] AMD-Vi: Completion-Wait loop timed out
[  106.337284] AMD-Vi: Completion-Wait loop timed out
[  106.458948] AMD-Vi: Completion-Wait loop timed out
[  106.469974] [drm] Radeon Display Connectors
[  106.474228] [drm] Connector 0:
[  106.477295] [drm]   DVI-D-1
[  106.480100] [drm]   HPD3
[  106.482642] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
[  106.490043] [drm]   Encoders:
[  106.493014] [drm]     DFP2: INTERNAL_UNIPHY2
[  106.497287] [drm] Connector 1:
[  106.500344] [drm]   HDMI-A-1
[  106.503232] [drm]   HPD1
[  106.505773] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
[  106.513168] [drm]   Encoders:
[  106.516146] [drm]     DFP1: INTERNAL_UNIPHY
[  106.520330] [drm] Connector 2:
[  106.523392] [drm]   VGA-1
[  106.526015] [drm]   HPD2
[  106.528557] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
[  106.535951] [drm]   Encoders:
[  106.538921] [drm]     CRT1: INTERNAL_UNIPHY3
[  106.543194] [drm]     CRT1: NUTMEG
[  OK  ] Reached target System Initialization.
[  106.684991] AMD-Vi: Completion-Wait loop timed out
[  106.807637] AMD-Vi: Completion-Wait loop timed out
[  106.929299] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Basic System.
[  107.067259] AMD-Vi: Completion-Wait loop timed out
[  107.133197] [drm] fb mappable at 0xC0725000
[  107.137420] [drm] vram apper at 0xC0000000
[  107.141530] [drm] size 7299072
[  107.144594] [drm] fb depth is 24
[  107.147825] [drm]    pitch is 6912
[  107.152241] fbcon: radeondrmfb (fb0) is primary device
[  107.206570] Console: switching to colour frame buffer device 210x65
[  107.224311] radeon 0000:00:01.0: fb0: radeondrmfb frame buffer device
[  107.239580] ACPI Error: [\_SB_.ALIB] Namespace lookup failure, AE_NOT_FOUND (20150930/psargs-359)
[  107.248637] ACPI Error: Method parse/execution failed [\_SB.PCI0.VGA.ATC0] (Node ffff8800340af028), AE_NOT_FOUND (20150930/psparse-542)
[  107.261024] ACPI Error: Method parse/execution failed [\_SB.PCI0.VGA.ATCS] (Node ffff8800340af000), AE_NOT_FOUND (20150930/psparse-542)
[  107.273682] [drm] Initialized radeon 2.43.0 20080528 for 0000:00:01.0 on minor 0
[  107.398349] AMD-Vi: Completion-Wait loop timed out
[  107.520036] AMD-Vi: Completion-Wait loop timed out
[  107.553640] [drm] amdgpu kernel modesetting enabled.
[  107.675585] AMD-Vi: Completion-Wait loop timed out
[  107.797273] AMD-Vi: Completion-Wait loop timed out
[  107.809651] scsi host4: pata_atiixp
[  107.814710] scsi host5: pata_atiixp
[  107.819671] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf100 irq 14
[  107.826739] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf108 irq 15
[  108.036339] ata6.00: ATAPI: PIONEER DVD-ROM DVD-232, 1.00, max UDMA/100
[  108.042996] ata6.00: limited to UDMA/33 due to 40-wire cable
[  108.088791] r8169 0000:01:00.0 enp1s0: renamed from eth0
[  108.114376] ata6.00: configured for UDMA/33
[  108.131061] scsi 5:0:0:0: CD-ROM            PIONEER  DVD-ROM DVD-232  1.00 PQ: 0 ANSI: 5
[  108.185652] sr 5:0:0:0: [sr0] scsi3-mmc drive: 22x/227x dvd-ram changer
[  108.202915] cdrom: Uniform CD-ROM driver Revision: 3.20
[  108.213322] sr 5:0:0:0: Attached scsi CD-ROM sr0
[  108.224131] sr 5:0:0:0: Attached scsi generic sg0 type 5
[  270.913008] random: nonblocking pool is initialized
[  293.108088] AMD-Vi: Completion-Wait loop timed out
[  293.229785] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Kdump V[  291.860644] dracut-initqueue[254]: Warning: Could not boot.
[  293.257816] audit: type=1130 audit(1446777205.175:11): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" ho'
[  292.148115] dracut-initqueue[254]: Warning: /dev/disk/by-uui[  293.401441] AMD-Vi: Completion-Wait loop timed out
[  293.573785] AMD-Vi: Completion-Wait loop timed out
[  293.695482] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped File System Check on /dev/d...449-4873-42cc-845f-56aba6804aff.
[  293.827686] AMD-Vi: Completion-Wait loop timed out
[  293.951130] AMD-Vi: Completion-Wait loop timed out
[  294.072826] AMD-Vi: Completion-Wait loop timed out
         Starting Setup Virtual Console...
[  294.206619] AMD-Vi: Completion-Wait loop timed out
[  294.443575] AMD-Vi: Completion-Wait loop timed out
[  294.565230] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Slices.
[  294.719735] AMD-Vi: Completion-Wait loop timed out
[  294.842377] AMD-Vi: Completion-Wait loop timed out
[  294.965482] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Paths.
[  295.093683] AMD-Vi: Completion-Wait loop timed out
[  295.218201] AMD-Vi: Completion-Wait loop timed out
[  295.341246] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Apply Kernel Variables.
[  295.470780] AMD-Vi: Completion-Wait loop timed out
[  295.477617] audit: type=1131 audit(1446777207.395:12): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" host'
[  295.618770] AMD-Vi: Completion-Wait loop timed out
[  295.741993] AMD-Vi: Completion-Wait loop timed out
         Stopping Apply Kernel Variables...
[  295.870800] AMD-Vi: Completion-Wait loop timed out
[  295.994243] AMD-Vi: Completion-Wait loop timed out
[  296.117374] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Initrd File Systems.
[  296.247787] AMD-Vi: Completion-Wait loop timed out
[  296.254871] systemd-journald[203]: Received SIGTERM from PID 1 (systemd).
[  296.263284] systemd[1]: Stopping Journal Service...
[  296.387245] AMD-Vi: Completion-Wait loop timed out
[  296.510400] AMD-Vi: Completion-Wait loop timed out
         Stopping Journal Service...
[  296.638768] AMD-Vi: Completion-Wait loop timed out
[  296.762161] AMD-Vi: Completion-Wait loop timed out
[  296.885270] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Timers.
[  297.013866] AMD-Vi: Completion-Wait loop timed out
[  297.020424] systemd[1]: Stopped target Timers.
[  297.026458] systemd[1]: Stopping Timers.
[  297.148821] AMD-Vi: Completion-Wait loop timed out
[  297.271977] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Swap.
[  297.399814] AMD-Vi: Completion-Wait loop timed out
[  297.406165] systemd[1]: Stopped target Swap.
[  297.411899] systemd[1]: Stopping Swap.
[  297.533986] AMD-Vi: Completion-Wait loop timed out
[  297.657046] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Local File Systems.
[  297.786876] AMD-Vi: Completion-Wait loop timed out
[  297.793099] systemd[1]: Stopped target Local File Systems.
[  297.799968] systemd[1]: Stopping Local File Systems.
[  297.923207] AMD-Vi: Completion-Wait loop timed out
[  298.046222] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Remote File Systems.
[  298.175932] AMD-Vi: Completion-Wait loop timed out
[  298.182152] systemd[1]: Stopped target Remote File Systems.
[  298.306033] AMD-Vi: Completion-Wait loop timed out
[  298.429016] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Remote File Systems (Pre).
[  298.558955] AMD-Vi: Completion-Wait loop timed out
[  298.565225] systemd[1]: Stopped target Remote File Systems (Pre).
[  298.689718] AMD-Vi: Completion-Wait loop timed out
[  298.812675] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Removed slice system-systemd\x2dfsck.slice.
[  298.942977] AMD-Vi: Completion-Wait loop timed out
[  298.949142] systemd[1]: Removed slice system-systemd\x2dfsck.slice.
[  298.956702] systemd[1]: Stopping system-systemd\x2dfsck.slice.
[  298.963845] systemd[1]: Stopped Dispatch Password Requests to Console Directory Watch.
[  298.973047] systemd[1]: Stopping Dispatch Password Requests to Console Directory Watch.
[  299.099248] AMD-Vi: Completion-Wait loop timed out
[  299.222177] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Sockets.
[  299.350924] AMD-Vi: Completion-Wait loop timed out
[  299.357085] systemd[1]: Stopped target Sockets.
[  299.362840] systemd[1]: Stopping Sockets.
[  299.484894] AMD-Vi: Completion-Wait loop timed out
[  299.607645] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Reload Configuration from the Real Root.
[  299.738987] AMD-Vi: Completion-Wait loop timed out
[  299.744993] systemd[1]: Stopped Reload Configuration from the Real Root.
[  299.869816] AMD-Vi: Completion-Wait loop timed out
[  299.992622] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Initrd Root File System.
[  300.122008] AMD-Vi: Completion-Wait loop timed out
[  300.128133] systemd[1]: Stopped target Initrd Root File System.
[  300.252170] AMD-Vi: Completion-Wait loop timed out
[  300.375021] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped dracut pre-mount hook.
[  300.505064] AMD-Vi: Completion-Wait loop timed out
[  300.511170] systemd[1]: Stopped dracut pre-mount hook.
[  300.634514] AMD-Vi: Completion-Wait loop timed out
[  300.757345] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped dracut initqueue hook.
[  300.887050] AMD-Vi: Completion-Wait loop timed out
[  300.893202] systemd[1]: Stopped dracut initqueue hook.
[  300.899672] audit: type=1131 audit(1446777212.817:13): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" ho'
[  300.922080] systemd[1]: Stopping dracut initqueue hook...
[  301.045668] AMD-Vi: Completion-Wait loop timed out
[  301.168594] AMD-Vi: Completion-Wait loop timed out
         Stopping dracut initqueue hook...
[  301.297107] AMD-Vi: Completion-Wait loop timed out
[  301.420861] AMD-Vi: Completion-Wait loop timed out
[  301.543800] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped udev Coldplug all Devices.
[  301.674094] AMD-Vi: Completion-Wait loop timed out
[  301.680243] systemd[1]: Stopped udev Coldplug all Devices.
[  301.687076] audit: type=1131 audit(1446777213.604:14): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd'
[  301.710029] systemd[1]: Stopping udev Coldplug all Devices...
[  301.834133] AMD-Vi: Completion-Wait loop timed out
[  301.957229] AMD-Vi: Completion-Wait loop timed out
         Stopping udev Coldplug all Devices...
[  302.086153] AMD-Vi: Completion-Wait loop timed out
[  302.209822] AMD-Vi: Completion-Wait loop timed out
[  302.332919] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped dracut pre-trigger hook.
[  302.463140] AMD-Vi: Completion-Wait loop timed out
[  302.469459] systemd[1]: Stopped dracut pre-trigger hook.
[  302.476335] audit: type=1131 audit(1446777214.394:15): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-trigger comm="systemd" exe="/usr/lib/systemd/systemd" '
[  302.499553] systemd[1]: Stopping dracut pre-trigger hook...
[  302.623626] AMD-Vi: Completion-Wait loop timed out
[  302.746886] AMD-Vi: Completion-Wait loop timed out
         Stopping dracut pre-trigger hook...
[  302.876198] AMD-Vi: Completion-Wait loop timed out
[  302.883531] systemd[1]: Stopping udev Kernel Device Manager...
[  303.008987] AMD-Vi: Completion-Wait loop timed out
[  303.132247] AMD-Vi: Completion-Wait loop timed out
         Stopping udev Kernel Device Manager...
[  303.261221] AMD-Vi: Completion-Wait loop timed out
[  303.385665] AMD-Vi: Completion-Wait loop timed out
[  303.508940] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Journal Service.
[  303.637176] AMD-Vi: Completion-Wait loop timed out
[  303.643796] systemd[1]: Stopped Journal Service.
[  303.650190] audit: type=1131 audit(1446777215.567:16): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" ho'
[  303.790827] AMD-Vi: Completion-Wait loop timed out
[  303.914233] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped udev Kernel Device Manager.
[  304.044200] AMD-Vi: Completion-Wait loop timed out
[  304.050891] systemd[1]: Stopped udev Kernel Device Manager.
[  304.058264] audit: type=1131 audit(1446777215.975:17): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostn'
[  304.198880] AMD-Vi: Completion-Wait loop timed out
[  304.322366] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Kdump Emergency.
[  304.451303] AMD-Vi: Completion-Wait loop timed out
[  304.458017] systemd[1]: Stopped Kdump Emergency.
[  304.464547] audit: type=1130 audit(1446777216.382:18): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=emergency comm="systemd" exe="/usr/lib/systemd/systemd" hostname='
[  304.487683] audit: type=1131 audit(1446777216.405:19): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=emergency comm="systemd" exe="/usr/lib/systemd/systemd" hostname='
[  304.628394] AMD-Vi: Completion-Wait loop timed out
[  304.752199] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Setup Virtual Console.
[  304.882241] AMD-Vi: Completion-Wait loop timed out
[  304.889283] systemd[1]: Started Setup Virtual Console.
[  304.896641] audit: type=1130 audit(1446777216.814:20): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/syste'
[  304.930827] systemd[1]: Starting Kdump Error Handler...
[  305.055527] AMD-Vi: Completion-Wait loop timed out
[  305.179427] AMD-Vi: Completion-Wait loop timed out
         [  305.187098] systemd[1]: Stopped Create Static Device Nodes in /dev.
Starting Kdump E[  305.203301] audit: type=1131 audit(1446777217.120:21): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/u'
Kdump: Executing default action kdump_emergency_shell
Warning: /dev/disk/by-uuid/4b765449-4873-42cc-84[  305.254880] systemd[1]: Stopping Create Static Device Nodes in /dev...
5f-56aba6804aff does not exist

Generating "/run/initramfs/rdsosreport.txt"
         [  305.271773] systemd[1]: Stopped Create list of required static device nodes for the current kernel.
Stopping Create [  305.283927] audit: type=1131 audit(1446777217.201:22): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/sy'
Static Device No[  305.310175] systemd[1]: Stopping Create list of required static device nodes for the current kernel...
des in /dev...
[  305.323752] systemd[1]: Stopped dracut pre-udev hook.
[  OK  [  305.332514] systemd[1]: Stopping dracut pre-udev hook...
] Stopped Create[  305.341896] systemd[1]: Stopped dracut cmdline hook.
 list of require[  305.350536] systemd[1]: Stopping dracut cmdline hook...
d sta...ce nodes[  305.359792] systemd[1]: Closed udev Kernel Socket.
 for the current[  305.368558] systemd[1]: Stopping udev Kernel Socket.
 kernel.
      [  305.377544] systemd[1]: Closed udev Control Socket.
   Stopping Crea[  305.386319] systemd[1]: Stopping udev Control Socket.
te list of requi[  305.395371] systemd[1]: Closed Journal Audit Socket.
red st... nodes [  305.404168] systemd[1]: Stopping Journal Audit Socket.
for the current kernel...
[  OK  ] Stopped dracut pre-udev hook.
         Stopping dracut pre-udev hook...
[  OK  ] Stopped dracut cmdline hook.
         Stopping dracut cmdline hook...
[  OK  ] Closed udev Kernel Socket.
[  OK  ] Closed udev Control Socket.
[  OK  ] Closed Journal Audit Socket.


Entering emergency mode. Exit the shell to continue.
Type "journalctl" to view system logs.
You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or /boot
after mounting them and attach it to a bug report.

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--cWoXeonUoKmBZSoM--
