From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 10/10] iommu/amd: Copy the old ir table
Date: Sat, 10 Oct 2015 20:40:04 +0800
Message-ID: <20151010124004.GD31787@dhcp-16-116.nay.redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
	<1443076656-31776-11-git-send-email-bhe@redhat.com>
	<20150929161140.GQ3036@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150929161140.GQ3036-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09/29/15 at 06:11pm, Joerg Roedel wrote:
> On Thu, Sep 24, 2015 at 02:37:36PM +0800, Baoquan He wrote:
> Is it necessary to copy the old ir tables? On AMD these tables are
> per-device, so it is probably the best to handle them like the io
> page-tables and just update the pointer to it in the device-table upon
> interrupt initialization.

Now the timer interrupt bug disappeared, but I may not handle the irq
remapping correctly. Currently I add another function copy_irq_table()
to fill out the table->table if the irq remapping table existed in
amd_iommu_dev_table[devid].data[2]. This is called in copy_dev_tables().
However my ata hard disk always startup wrongly, then the kdump failed
because no root disk. From log and adding dump_stack() it should be the
irq remapping issues, always there are many lines of message triggered
by modify_irte() calling like below:

*****************************
AMD-Vi: Completion-Wait loop timed out
*****************************

I don't know which part of irq remapping handling I didn't noticed. The
attachment is the kdump boot log with my current debugging code. If you
think that's helpful I can arrange and repost another round of draft
patch sets.


static void copy_irq_table(u16 devid)
{
        struct irq_remap_table *table = NULL;
        u16 alias;
        u64 dte;

        alias = amd_iommu_alias_table[devid];
        table = irq_lookup_table[alias];
        if (table) {
                irq_lookup_table[devid] = table;
                return;
        }
        dte     = amd_iommu_dev_table[devid].data[2];
        dte &= DTE_IRQ_PHYS_ADDR_MASK;
        if(!dte)
                return;

        table = kzalloc(sizeof(*table), GFP_ATOMIC);
        if (!table){
                pr_warn("AMD-Vi: amd irq table allocation failed\n");
                return;
        }
        table->table = ioremap_cache(dte, MAX_IRQS_PER_TABLE * sizeof(u32));
        irq_lookup_table[devid] = table;
}

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kdump-amd.log"

[root@dhcp-128-84 ~]# echo c >/proc/sysrq-trigger 
[  112.587912] sysrq: SysRq : Trigger a crash
[  112.592192] BUG: unable to handle kernel NULL pointer dereference at           (null)
[  112.601519] IP: [<ffffffff81477ea6>] sysrq_handle_crash+0x16/0x20
[  112.609119] PGD 0 
[  112.612635] Oops: 0002 [#1] SMP 
[  112.617386] Modules linked in: nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_filti
[  112.715034] CPU: 2 PID: 1467 Comm: bash Not tainted 4.3.0-rc3+ #50
[  112.723074] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88X-D3H, BIOS F5 05/28/2014
[  112.734987] task: ffff88021aea9b00 ti: ffff88021ad30000 task.ti: ffff88021ad30000
[  112.744394] RIP: 0010:[<ffffffff81477ea6>]  [<ffffffff81477ea6>] sysrq_handle_crash+0x16/0x20
[  112.754901] RSP: 0018:ffff88021ad33dd0  EFLAGS: 00010282
[  112.762160] RAX: 000000000000000f RBX: 0000000000000063 RCX: 0000000000000000
[  112.771256] RDX: 0000000000000000 RSI: ffff88023ed0df78 RDI: 0000000000000063
[  112.780346] RBP: ffff88021ad33dd0 R08: 0000000000000002 R09: 0000000000000421
[  112.789442] R10: 0000000000000001 R11: 0000000000000421 R12: 0000000000000007
[  112.798536] R13: 0000000000000000 R14: ffffffff81cc03e0 R15: 000055a89131c3d0
[  112.807629] FS:  00007f13fa8a3700(0000) GS:ffff88023ed00000(0000) knlGS:0000000000000000
[  112.817665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.825401] CR2: 0000000000000000 CR3: 000000006fb58000 CR4: 00000000000406e0
[  112.834590] Stack:
[  112.838585]  ffff88021ad33e00 ffffffff814786aa 0000000000000002 fffffffffffffffb
[  112.848053]  ffff88021ad33f18 0000000000000002 ffff88021ad33e18 ffffffff81478b2f
[  112.856708]  ffff880232ed9b40 ffff88021ad33e38 ffffffff8127e582 ffff880221d10b00
[  112.865310] Call Trace:
[  112.868910]  [<ffffffff814786aa>] __handle_sysrq+0xea/0x140
[  112.875642]  [<ffffffff81478b2f>] write_sysrq_trigger+0x2f/0x40
[  112.882696]  [<ffffffff8127e582>] proc_reg_write+0x42/0x70
[  112.889318]  [<ffffffff81214f57>] __vfs_write+0x37/0x100
[  112.895791]  [<ffffffff813213d3>] ? selinux_file_permission+0xc3/0x100
[  112.903480]  [<ffffffff8131710d>] ? security_file_permission+0x3d/0xc0
[  112.911140]  [<ffffffff810e2fd4>] ? percpu_down_read+0x14/0x60
[  112.918131]  [<ffffffff812158d6>] vfs_write+0xa6/0x1a0
[  112.924431]  [<ffffffff813174a3>] ? security_file_fcntl+0x43/0x60
[  112.931688]  [<ffffffff81216595>] SyS_write+0x55/0xc0
[  112.937920]  [<ffffffff8177a4ae>] entry_SYSCALL_64_fastpath+0x12/0x71
[  112.945534] Code: ef e8 1f f8 ff ff eb db 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 55 c7 05 28 e2 a9 00 01 00 00 00 48 89 e5 0f ae f8 <c6> 04 25 00 00 00 00 01 5d c3 0f 1f 4 
[  112.967823] RIP  [<ffffffff81477ea6>] sysrq_handle_crash+0x16/0x20
[  112.975255]  RSP <ffff88021ad33dd0>
[  112.979986] CR2: 0000000000000000
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.3.0-rc3+ (bhe-0VdLhd/A9PknZhOiLRORzh/sF2h8X+2i0E9HWUfgJXw@public.gmane.org) (gcc version 5.1.1 20150618 (Red Hat 5.1.1-4) (GCC) ) #50 SMP Sat Oct 10 20:00:15 CST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.3.0-rc3+ root=UUID=4b765449-4873-42cc-845f-56aba6804aff ro LANG=en_US.UTF-8 console=tty0 console=ttyS0,115200n8 amd_iommu_dump irqpoll nr_K
[    0.000000] x86/fpu: xstate_offset[2]: 0240, xstate_sizes[2]: 0100
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 0x340 bytes, using 'standard' format.
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
[    0.000000] RAMDISK: [mem 0x34c4a000-0x35ffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007D024000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000007D024088 00008C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000007D02A5A0 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20150818/tbfadt-654)
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
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 3/0x13 ignored.
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
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff880037c00000 s98392 r8192 d32680 u2097152
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 64485
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.3.0-rc3+ root=UUID=4b765449-4873-42cc-845f-56aba6804aff ro LANG=en_US.UTF-8 console=tty0 console=ttyS0,115200n8 amd_iommu_dump irqpK
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] Disabling memory control group subsystem
[    0.000000] PID hash table entries: 1024 (order: 1, 8192 bytes)
[    0.000000] Memory: 218680K/262128K available (7677K kernel code, 1258K rwdata, 3372K rodata, 1504K init, 1464K bss, 43448K reserved, 0K cma-reserved)
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
[    0.000000] tsc: Detected 3693.584 MHz processor
[    0.000027] Calibrating delay loop (skipped), value calculated using timer frequency.. 7387.16 BogoMIPS (lpj=3693584)
[    0.010642] pid_max: default: 32768 minimum: 301
[    0.015261] ACPI: Core revision 20150818
[    0.024162] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.030766] Security Framework initialized
[    0.034860] Yama: becoming mindful.
[    0.038342] SELinux:  Initializing.
[    0.041887] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.048913] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.055821] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.062334] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.069463] Initializing cgroup subsys io
[    0.073497] Initializing cgroup subsys memory
[    0.077852] Initializing cgroup subsys devices
[    0.082292] Initializing cgroup subsys freezer
[    0.086734] Initializing cgroup subsys net_cls
[    0.091176] Initializing cgroup subsys perf_event
[    0.095877] Initializing cgroup subsys net_prio
[    0.100406] Initializing cgroup subsys hugetlb
[    0.104867] CPU: Physical Processor ID: 0
[    0.108873] CPU: Processor Core ID: 2
[    0.112528] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.118440] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.129928] Freeing SMP alternatives memory: 28K (ffffffff81eb4000 - ffffffff81ebb000)
[    0.138798] ------------[ cut here ]------------
[    0.143416] WARNING: CPU: 0 PID: 0 at mm/early_ioremap.c:137 __early_ioremap+0x102/0x1bb()
[    0.151666] Modules linked in:
[    0.154738] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.3.0-rc3+ #50
[    0.161084] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88X-D3H, BIOS F5 05/28/2014
[    0.171070]  0000000000000000 7a089a9d8b0fe8b0 ffffffff81c03e40 ffffffff8139038f
[    0.178521]  0000000000000000 ffffffff81c03e78 ffffffff8109d322 000000007141f000
[    0.185967]  0000000000000000 0000000000000001 0000000000000001 0000000000000045
[    0.193414] Call Trace:
[    0.195860]  [<ffffffff8139038f>] dump_stack+0x44/0x55
[    0.200993]  [<ffffffff8109d322>] warn_slowpath_common+0x82/0xc0
[    0.206993]  [<ffffffff8109d46a>] warn_slowpath_null+0x1a/0x20
[    0.212819]  [<ffffffff81d88e14>] __early_ioremap+0x102/0x1bb
[    0.218560]  [<ffffffff81d89081>] early_memremap+0x13/0x15
[    0.224041]  [<ffffffff81d8908c>] early_ioremap+0x9/0xb
[    0.229263]  [<ffffffff81d74fb1>] efi_bgrt_init+0x166/0x1bd
[    0.234829]  [<ffffffff81d7458a>] efi_late_init+0x9/0xb
[    0.240051]  [<ffffffff81d55ff5>] start_kernel+0x46f/0x49f
[    0.245532]  [<ffffffff81d55120>] ? early_idt_handler_array+0x120/0x120
[    0.252138]  [<ffffffff81d55339>] x86_64_start_reservations+0x2a/0x2c
[    0.258572]  [<ffffffff81d55485>] x86_64_start_kernel+0x14a/0x16d
[    0.264661] ---[ end trace e602a5cbd93445bd ]---
[    0.269272] Ignoring BGRT: failed to map image memory
[    0.274314] ftrace: allocating 29049 entries in 114 pages
[    0.291759] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b8 info 0000
[    0.298454] AMD-Vi:        mmio-addr: 00000000feb80000
[    0.303588] ******** first_device:0, last_device:0
[    0.308386] Translation is already enabled - trying to copy translation structures
[    0.315944] AMD-Vi:   DEV_SELECT_RANGE_START  devid: 00:01.0 flags: 00
[    0.322462] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.6
[    0.327665] AMD-Vi:   DEV_ALIAS_RANGE                 devid: 02:00.0 flags: 00 devid_to: 00:14.4
[    0.335245] AMD-Vi:   DEV_RANGE_END           devid: 02:1f.7
[    0.340207] AMD-Vi:   DEV_SPECIAL(HPET[0])           devid: 00:14.0
[    0.345684] AMD-Vi:   DEV_SPECIAL(IOAPIC[0])         devid: 00:14.0
[    0.351329] AMD-Vi:   DEV_SPECIAL(IOAPIC[1])         devid: 00:00.0
[    0.466880] AMD-Vi: Completion-Wait loop timed out
[    0.472177] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.586816] AMD-Vi: Completion-Wait loop timed out
[    0.703305] smpboot: CPU0: AMD A10-7850K Radeon R7, 12 Compute Cores 4C+8G (family: 0x15, model: 0x30, stepping: 0x1)
[    0.713973] Performance Events: Fam15h core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    0.723833] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
[    0.732258] AMD PMU driver.
[    0.735053] ... version:                0
[    0.739060] ... bit width:              48
[    0.743155] ... generic registers:      6
[    0.747164] ... value mask:             0000ffffffffffff
[    0.752471] ... max period:             00007fffffffffff
[    0.757781] ... fixed-purpose events:   0
[    0.761788] ... event mask:             000000000000003f
[    0.767721] x86: Booted up 1 node, 1 CPUs
[    0.771794] smpboot: Total of 1 processors activated (7387.16 BogoMIPS)
[    0.778414] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.895091] AMD-Vi: Completion-Wait loop timed out
[    1.008630] AMD-Vi: Completion-Wait loop timed out
[    1.122158] AMD-Vi: Completion-Wait loop timed out
[    1.235689] AMD-Vi: Completion-Wait loop timed out
[    1.349220] AMD-Vi: Completion-Wait loop timed out
[    1.462752] AMD-Vi: Completion-Wait loop timed out
[    1.576245] AMD-Vi: Completion-Wait loop timed out
[    1.689776] AMD-Vi: Completion-Wait loop timed out
[    1.803310] AMD-Vi: Completion-Wait loop timed out
[    1.916794] AMD-Vi: Completion-Wait loop timed out
[    2.030327] AMD-Vi: Completion-Wait loop timed out
[    2.143856] AMD-Vi: Completion-Wait loop timed out
[    2.257387] AMD-Vi: Completion-Wait loop timed out
[    2.370920] AMD-Vi: Completion-Wait loop timed out
[    2.484414] AMD-Vi: Completion-Wait loop timed out
[    2.489601] devtmpfs: initialized
[    2.495076] PM: Registering ACPI NVS region [mem 0x7cfa0000-0x7d06dfff] (843776 bytes)
[    2.503057] PM: Registering ACPI NVS region [mem 0x7e1c9000-0x7e3cefff] (2121728 bytes)
[    2.511146] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    2.520933] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    2.527892] pinctrl core: initialized pinctrl subsystem
[    2.533143] RTC time: 12:03:28, date: 10/10/15
[    2.537701] NET: Registered protocol family 16
[    2.542359] cpuidle: using governor menu
[    2.546439] ACPI: bus type PCI registered
[    2.550479] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.556991] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    2.566283] PCI: not using MMCONFIG
[    2.569770] PCI: Using configuration type 1 for base access
[    2.575337] PCI: Using configuration type 1 for extended access
[    2.582725] ACPI: Added _OSI(Module Device)
[    2.586933] ACPI: Added _OSI(Processor Device)
[    2.591374] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.596073] ACPI: Added _OSI(Processor Aggregator Device)
[    2.710811] AMD-Vi: Completion-Wait loop timed out
[    2.824285] AMD-Vi: Completion-Wait loop timed out
[    2.830037] ACPI: Executed 1 blocks of module-level executable AML code
[    2.839650] ACPI: Interpreter enabled
[    2.843343] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150818/hwxface-580)
[    2.852586] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150818/hwxface-580)
[    2.861844] ACPI: (supports S0 S3 S4 S5)
[    2.865762] ACPI: Using IOAPIC for interrupt routing
[    2.870859] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    2.880180] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    2.888902] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.898467] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    2.906418] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    2.914355] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    2.927565] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    2.933807] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.942175] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    2.950499] PCI host bridge to bus 0000:00
[    2.954593] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.960072] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    2.966851] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    2.973631] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    2.980411] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.987189] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.994664] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    3.002136] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
[    3.010375] pci 0000:00:03.1: System wakeup disabled by ACPI
[    3.016376] pci 0000:00:10.0: System wakeup disabled by ACPI
[    3.022217] pci 0000:00:10.1: System wakeup disabled by ACPI
[    3.028165] pci 0000:00:12.0: System wakeup disabled by ACPI
[    3.033971] pci 0000:00:12.2: System wakeup disabled by ACPI
[    3.039758] pci 0000:00:13.0: System wakeup disabled by ACPI
[    3.045564] pci 0000:00:13.2: System wakeup disabled by ACPI
[    3.051457] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    3.058581] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    3.065101] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    3.072226] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    3.078942] pci 0000:00:14.2: System wakeup disabled by ACPI
[    3.084823] pci 0000:00:14.4: System wakeup disabled by ACPI
[    3.090604] pci 0000:00:14.5: System wakeup disabled by ACPI
[    3.098566] pci 0000:00:03.1: PCI bridge to [bus 01]
[    3.103702] pci 0000:00:14.4: PCI bridge to [bus 02] (subtractive decode)
[    3.111455] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    3.118338] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    3.125212] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    3.132096] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    3.138971] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    3.145811] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    3.152653] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    3.159501] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    3.166769] vgaarb: setting as boot device: PCI:0000:00:01.0
[    3.172487] vgaarb: device added: PCI:0000:00:01.0,decodes=io+mem,owns=io+mem,locks=none
[    3.180576] vgaarb: loaded
[    3.183294] vgaarb: bridge control possible 0000:00:01.0
[    3.188778] SCSI subsystem initialized
[    3.192685] ACPI: bus type USB registered
[    3.196760] usbcore: registered new interface driver usbfs
[    3.202287] usbcore: registered new interface driver hub
[    3.207612] usbcore: registered new device driver usb
[    3.212859] PCI: Using ACPI for IRQ routing
[    3.224925] NetLabel: Initializing
[    3.228359] NetLabel:  domain hash size = 128
[    3.232713] NetLabel:  protocols = UNLABELED CIPSOv4
[    3.237694] NetLabel:  unlabeled traffic allowed by default
[    3.243468] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    3.248426] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    3.256305] clocksource: Switched to clocksource hpet
[    3.273267] pnp: PnP ACPI init
[    3.276598] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    3.283383] system 00:01: [mem 0x80000000-0xbfffffff] has been reserved
[    3.290115] system 00:02: [mem 0xfeb80000-0xfebfffff] could not be reserved
[    3.297432] system 00:03: [io  0x0220-0x0227] has been reserved
[    3.303382] system 00:03: [io  0x0228-0x0237] has been reserved
[    3.309305] system 00:03: [io  0x0a20-0x0a2f] has been reserved
[    3.316026] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    3.322451] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    3.328407] system 00:08: [io  0x040b] has been reserved
[    3.333723] system 00:08: [io  0x04d6] has been reserved
[    3.339040] system 00:08: [io  0x0c00-0x0c01] has been reserved
[    3.344961] system 00:08: [io  0x0c14] has been reserved
[    3.350277] system 00:08: [io  0x0c50-0x0c51] has been reserved
[    3.356200] system 00:08: [io  0x0c52] has been reserved
[    3.361517] system 00:08: [io  0x0c6c] has been reserved
[    3.366832] system 00:08: [io  0x0c6f] has been reserved
[    3.372148] system 00:08: [io  0x0cd0-0x0cd1] has been reserved
[    3.378070] system 00:08: [io  0x0cd2-0x0cd3] has been reserved
[    3.383992] system 00:08: [io  0x0cd4-0x0cd5] has been reserved
[    3.389915] system 00:08: [io  0x0cd6-0x0cd7] has been reserved
[    3.395837] system 00:08: [io  0x0cd8-0x0cdf] has been reserved
[    3.401760] system 00:08: [io  0x0800-0x089f] could not be reserved
[    3.408031] system 00:08: [io  0x0b20-0x0b3f] has been reserved
[    3.413953] system 00:08: [io  0x0900-0x090f] has been reserved
[    3.419876] system 00:08: [io  0x0910-0x091f] has been reserved
[    3.425797] system 00:08: [io  0xfe00-0xfefe] has been reserved
[    3.431721] system 00:08: [mem 0xfec00000-0xfec00fff] could not be reserved
[    3.438683] system 00:08: [mem 0xfee00000-0xfee00fff] has been reserved
[    3.445296] system 00:08: [mem 0xfed80000-0xfed8ffff] has been reserved
[    3.451912] system 00:08: [mem 0xfed61000-0xfed70fff] has been reserved
[    3.458528] system 00:08: [mem 0xfec10000-0xfec10fff] has been reserved
[    3.465141] system 00:08: [mem 0xfed00000-0xfed00fff] could not be reserved
[    3.472107] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    3.478985] pnp: PnP ACPI: found 9 devices
[    3.490316] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.499207] pci 0000:00:03.1: PCI bridge to [bus 01]
[    3.504175] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    3.510273] pci 0000:00:03.1:   bridge window [mem 0xfea00000-0xfeafffff]
[    3.517065] pci 0000:00:03.1:   bridge window [mem 0xd0800000-0xd08fffff 64bit pref]
[    3.524814] pci 0000:00:14.4: PCI bridge to [bus 02]
[    3.529901] NET: Registered protocol family 2
[    3.534534] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    3.541639] TCP bind hash table entries: 2048 (order: 3, 32768 bytes)
[    3.548087] TCP: Hash tables configured (established 2048 bind 2048)
[    3.554463] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    3.560302] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    3.566615] NET: Registered protocol family 1
[    3.724250] Unpacking initramfs...
[    4.377039] Freeing initrd memory: 20184K (ffff880034c4a000 - ffff880036000000)
[    4.384469] AMD-Vi: IOMMU performance counters supported
[    4.390674] iommu: Adding device 0000:00:00.0 to group 0
[    4.396816] iommu: Adding device 0000:00:01.0 to group 1
[    4.527226] AMD-Vi: Completion-Wait loop timed out
[    4.532062] iommu: Using direct mapping for device 0000:00:01.0
[    4.538000] iommu: Adding device 0000:00:01.1 to group 1
[    4.543966] iommu: Adding device 0000:00:02.0 to group 2
[    4.550029] iommu: Adding device 0000:00:03.0 to group 3
[    4.555418] iommu: Adding device 0000:00:03.1 to group 3
[    4.561491] iommu: Adding device 0000:00:04.0 to group 4
[    4.567626] iommu: Adding device 0000:00:10.0 to group 5
[    4.573017] iommu: Adding device 0000:00:10.1 to group 5
[    4.579018] iommu: Adding device 0000:00:11.0 to group 6
[    4.585155] iommu: Adding device 0000:00:12.0 to group 7
[    4.590475] iommu: Adding device 0000:00:12.2 to group 7
[    4.596550] iommu: Adding device 0000:00:13.0 to group 8
[    4.601933] iommu: Adding device 0000:00:13.2 to group 8
[    4.607943] iommu: Adding device 0000:00:14.0 to group 9
[    4.613328] iommu: Adding device 0000:00:14.1 to group 9
[    4.618652] iommu: Adding device 0000:00:14.2 to group 9
[    4.623976] iommu: Adding device 0000:00:14.3 to group 9
[    4.629973] iommu: Adding device 0000:00:14.4 to group 10
[    4.636192] iommu: Adding device 0000:00:14.5 to group 11
[    4.642395] iommu: Adding device 0000:00:18.0 to group 12
[    4.647867] iommu: Adding device 0000:00:18.1 to group 12
[    4.653278] iommu: Adding device 0000:00:18.2 to group 12
[    4.658691] iommu: Adding device 0000:00:18.3 to group 12
[    4.664101] iommu: Adding device 0000:00:18.4 to group 12
[    4.669512] iommu: Adding device 0000:00:18.5 to group 12
[    4.674923] iommu: Adding device 0000:01:00.0 to group 3
[    4.680236] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    4.685551] AMD-Vi:  Extended features:  PPR GT IA PC
[    4.690696] AMD-Vi: Interrupt remapping enabled
[    4.695407] AMD-Vi: Lazy IO/TLB flushing enabled
[    4.700326] perf: AMD NB counters detected
[    4.704437] perf: amd_iommu: Detected. (2 banks, 4 counters/bank)
[    4.710605] microcode: CPU0: patch_level=0x06003104
[    4.715591] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
[    4.724412] LVT offset 0 assigned for vector 0x400
[    4.729214] perf: AMD IBS detected (0x000001ff)
[    4.734460] futex hash table entries: 256 (order: 2, 16384 bytes)
[    4.740643] audit: initializing netlink subsys (disabled)
[    4.746103] audit: type=2000 audit(1444478608.308:1): initialized
[    4.752700] Initialise system trusted keyring
[    4.757224] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    4.766440] zbud: loaded
[    4.769332] VFS: Disk quotas dquot_6.6.0
[    4.773381] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.780979] Key type big_key registered
[    4.790539] NET: Registered protocol family 38
[    4.795019] Key type asymmetric registered
[    4.799131] Asymmetric key parser 'x509' registered
[    4.804047] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    4.811478] io scheduler noop registered
[    4.815413] io scheduler deadline registered
[    4.819747] io scheduler cfq registered (default)
[    4.949981] AMD-Vi: Completion-Wait loop timed out
[    5.071624] AMD-Vi: Completion-Wait loop timed out
[    5.193166] AMD-Vi: Completion-Wait loop timed out
[    5.198029] pcieport 0000:00:03.1: Signaling PME through PCIe PME interrupt
[    5.204990] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    5.211529] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    5.217112] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    5.223873] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    5.232285] ACPI: Power Button [PWRB]
[    5.236011] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    5.243434] ACPI: Power Button [PWRF]
[    5.247425] GHES: HEST is not enabled!
[    5.251303] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    5.278237] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    5.286237] Non-volatile memory driver v1.3
[    5.290537] Linux agpgart interface v0.103
[    5.294786] agpgart-amd64 0000:00:00.2: can't derive routing for PCI INT A
[    5.301689] agpgart-amd64 0000:00:00.2: PCI INT A: no GSI
[    5.432340] AMD-Vi: Completion-Wait loop timed out
[    5.562353] AMD-Vi: Completion-Wait loop timed out
[    5.692446] AMD-Vi: Completion-Wait loop timed out
[    5.822519] AMD-Vi: Completion-Wait loop timed out
[    5.827377] tsc: Refined TSC clocksource calibration: 3693.483 MHz
[    5.833555] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a7a9164d53, max_idle_ns: 881590498552 ns
[    5.968826] AMD-Vi: Completion-Wait loop timed out
[    6.098833] AMD-Vi: Completion-Wait loop timed out
[    6.228864] AMD-Vi: Completion-Wait loop timed out
[    6.358929] AMD-Vi: Completion-Wait loop timed out
[    6.488994] AMD-Vi: Completion-Wait loop timed out
[    6.619054] AMD-Vi: Completion-Wait loop timed out
[    6.749144] AMD-Vi: Completion-Wait loop timed out
[    6.879194] AMD-Vi: Completion-Wait loop timed out
[    6.884081] clocksource: Switched to clocksource tsc
[    7.006084] AMD-Vi: Completion-Wait loop timed out
[    7.011621] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    7.019711] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    7.144673] AMD-Vi: Completion-Wait loop timed out
[    7.266217] AMD-Vi: Completion-Wait loop timed out
[    7.271608] scsi host0: ahci
[    7.274667] scsi host1: ahci
[    7.277683] scsi host2: ahci
[    7.280695] scsi host3: ahci
[    7.283710] ata1: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71100 irq 19
[    7.291100] ata2: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71180 irq 19
[    7.298494] ata3: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71200 irq 19
[    7.305889] ata4: SATA max UDMA/133 abar m2048@0xfeb71000 port 0xfeb71280 irq 19
[    7.313511] libphy: Fixed MDIO Bus: probed
[    7.317912] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    7.323180] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[    7.330793] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    7.456329] AMD-Vi: Completion-Wait loop timed out
[    7.577882] AMD-Vi: Completion-Wait loop timed out
[    7.699426] AMD-Vi: Completion-Wait loop timed out
[    7.820998] AMD-Vi: Completion-Wait loop timed out
[    7.942539] AMD-Vi: Completion-Wait loop timed out
[    7.947424] ata3: SATA link down (SStatus 0 SControl 300)
[    7.952851] ata2: SATA link down (SStatus 0 SControl 300)
[    7.958267] ata1: SATA link down (SStatus 0 SControl 300)
[    7.963747] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    7.970532] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.977749] usb usb1: Product: xHCI Host Controller
[    7.982626] usb usb1: Manufacturer: Linux 4.3.0-rc3+ xhci-hcd
[    7.988368] usb usb1: SerialNumber: 0000:00:10.0
[    7.993137] hub 1-0:1.0: USB hub found
[    7.996962] hub 1-0:1.0: 2 ports detected
[    8.001123] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    8.006424] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[    8.013868] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    8.021978] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    8.028762] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.035985] usb usb2: Product: xHCI Host Controller
[    8.040862] usb usb2: Manufacturer: Linux 4.3.0-rc3+ xhci-hcd
[    8.046606] usb usb2: SerialNumber: 0000:00:10.0
[    8.051353] hub 2-0:1.0: USB hub found
[    8.055181] hub 2-0:1.0: 2 ports detected
[    8.059461] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    8.064727] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[    8.072333] xhci_hcd 0000:00:10.1: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    8.197803] AMD-Vi: Completion-Wait loop timed out
[    8.202677] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.325656] AMD-Vi: Completion-Wait loop timed out
[    8.447202] AMD-Vi: Completion-Wait loop timed out
[    8.568752] AMD-Vi: Completion-Wait loop timed out
[    8.690298] AMD-Vi: Completion-Wait loop timed out
[    8.695200] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    8.701987] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.709202] usb usb3: Product: xHCI Host Controller
[    8.714083] usb usb3: Manufacturer: Linux 4.3.0-rc3+ xhci-hcd
[    8.719824] usb usb3: SerialNumber: 0000:00:10.1
[    8.724570] hub 3-0:1.0: USB hub found
[    8.728400] hub 3-0:1.0: 2 ports detected
[    8.732554] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    8.737848] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 4
[    8.745288] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    8.753391] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    8.760173] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.767387] usb usb4: Product: xHCI Host Controller
[    8.772268] usb usb4: Manufacturer: Linux 4.3.0-rc3+ xhci-hcd
[    8.778007] usb usb4: SerialNumber: 0000:00:10.1
[    8.782753] hub 4-0:1.0: USB hub found
[    8.786548] hub 4-0:1.0: 2 ports detected
[    8.790718] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    8.797280] ehci-pci: EHCI PCI platform driver
[    8.801858] ehci-pci 0000:00:12.2: EHCI Host Controller
[    8.807127] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 5
[    8.814555] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    8.823254] ehci-pci 0000:00:12.2: debug port 1
[    8.944506] AMD-Vi: Completion-Wait loop timed out
[    9.066049] AMD-Vi: Completion-Wait loop timed out
[    9.070992] ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb6f000
[    9.082137] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    9.087975] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    9.094792] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.102016] usb usb5: Product: EHCI Host Controller
[    9.106894] usb usb5: Manufacturer: Linux 4.3.0-rc3+ ehci_hcd
[    9.112635] usb usb5: SerialNumber: 0000:00:12.2
[    9.117460] hub 5-0:1.0: USB hub found
[    9.121297] hub 5-0:1.0: 5 ports detected
[    9.125745] ehci-pci 0000:00:13.2: EHCI Host Controller
[    9.131043] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 6
[    9.138472] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    9.147172] ehci-pci 0000:00:13.2: debug port 1
[    9.151753] ehci-pci 0000:00:13.2: irq 17, io mem 0xfeb6d000
[    9.163065] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    9.168920] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
[    9.175732] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.182946] usb usb6: Product: EHCI Host Controller
[    9.187825] usb usb6: Manufacturer: Linux 4.3.0-rc3+ ehci_hcd
[    9.193567] usb usb6: SerialNumber: 0000:00:13.2
[    9.198394] hub 6-0:1.0: USB hub found
[    9.202231] hub 6-0:1.0: 5 ports detected
[    9.206488] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    9.212703] ohci-pci: OHCI PCI platform driver
[    9.217377] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    9.223031] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 7
[    9.348219] AMD-Vi: Completion-Wait loop timed out
[    9.469765] AMD-Vi: Completion-Wait loop timed out
[    9.474676] ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb70000
[    9.534821] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    9.541647] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.548867] usb usb7: Product: OHCI PCI host controller
[    9.554092] usb usb7: Manufacturer: Linux 4.3.0-rc3+ ohci_hcd
[    9.559831] usb usb7: SerialNumber: 0000:00:12.0
[    9.564660] hub 7-0:1.0: USB hub found
[    9.568433] hub 7-0:1.0: 5 ports detected
[    9.572849] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    9.578578] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 8
[    9.586019] ohci-pci 0000:00:13.0: irq 18, io mem 0xfeb6e000
[    9.646725] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    9.653549] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.660771] usb usb8: Product: OHCI PCI host controller
[    9.665995] usb usb8: Manufacturer: Linux 4.3.0-rc3+ ohci_hcd
[    9.671736] usb usb8: SerialNumber: 0000:00:13.0
[    9.676647] hub 8-0:1.0: USB hub found
[    9.680448] hub 8-0:1.0: 5 ports detected
[    9.684834] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    9.690495] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 9
[    9.697921] ohci-pci 0000:00:14.5: irq 18, io mem 0xfeb6c000
[    9.758817] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001
[    9.765641] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.772863] usb usb9: Product: OHCI PCI host controller
[    9.778088] usb usb9: Manufacturer: Linux 4.3.0-rc3+ ohci_hcd
[    9.783828] usb usb9: SerialNumber: 0000:00:14.5
[    9.788721] hub 9-0:1.0: USB hub found
[    9.792560] hub 9-0:1.0: 2 ports detected
[    9.796723] uhci_hcd: USB Universal Host Controller Interface driver
[    9.803164] usbcore: registered new interface driver usbserial
[    9.809012] usbcore: registered new interface driver usbserial_generic
[    9.815544] usbserial: USB Serial support registered for generic
[    9.821597] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    9.945471] AMD-Vi: Completion-Wait loop timed out
[   10.066982] AMD-Vi: Completion-Wait loop timed out
[   10.188702] AMD-Vi: Completion-Wait loop timed out
[   10.310346] AMD-Vi: Completion-Wait loop timed out
[   10.431886] AMD-Vi: Completion-Wait loop timed out
[   10.553408] AMD-Vi: Completion-Wait loop timed out
[   10.674947] AMD-Vi: Completion-Wait loop timed out
[   10.679813] usb 8-4: new low-speed USB device number 2 using ohci-pci
[   10.686258] serio: i8042 KBD port at 0x60,0x64 irq 1
[   10.691250] serio: i8042 AUX port at 0x60,0x64 irq 12
[   10.696486] mousedev: PS/2 mouse device common for all mice
[   10.702372] rtc_cmos 00:06: RTC can wake from S4
[   10.707164] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[   10.829992] AMD-Vi: Completion-Wait loop timed out
[   10.951535] AMD-Vi: Completion-Wait loop timed out
[   10.956377] ohci-pci 0000:00:13.0: frame counter not updating; disabled
[   10.962981] ohci-pci 0000:00:13.0: HC died; cleaning up
[   10.968256] rtc_cmos 00:06: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   10.975982] device-mapper: uevent: version 1.0.3
[   10.980701] device-mapper: ioctl: 4.33.0-ioctl (2015-8-18) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[   10.989514] EFI Variables Facility v0.08 2004-May-17
[   11.002145] hidraw: raw HID events driver (C) Jiri Kosina
[   11.007757] usbcore: registered new interface driver usbhid
[   11.013385] usbhid: USB HID core driver
[   11.017339] drop_monitor: Initializing network drop monitor service
[   11.023739] ip_tables: (C) 2000-2006 Netfilter Core Team
[   11.029133] Initializing XFRM netlink socket
[   11.033578] NET: Registered protocol family 10
[   11.038353] mip6: Mobile IPv6
[   11.041392] NET: Registered protocol family 17
[   11.045845] mce: Unable to init device /dev/mcelog (rc: -5)
[   11.051605] AVX version of gcm_enc/dec engaged.
[   11.056199] AES CTR mode by8 optimization enabled
[   11.106634] registered taskstats version 1
[   11.110816] Loading compiled-in X.509 certificates
[   11.117264] Loaded X.509 cert 'Build time autogenerated kernel key: 973d71201d002d4a90850c219c9e7fe0462e744b'
[   11.127272] zswap: loaded using pool lzo/zbud
[   11.132088]   Magic number: 3:560:76
[   11.135812] rtc_cmos 00:06: setting system clock to 2015-10-10 12:03:37 UTC (1444478617)
[   11.260840] AMD-Vi: Completion-Wait loop timed out
[   11.382387] AMD-Vi: Completion-Wait loop timed out
[   13.204532] ata4.00: qc timeout (cmd 0xec)
[   13.208657] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   13.674151] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   15.804565] AMD-Vi: No event written to event log
[   15.926413] AMD-Vi: No event written to event log
[   16.048166] AMD-Vi: No event written to event log
[   16.169927] AMD-Vi: No event written to event log
[   16.291652] AMD-Vi: No event written to event log
[   16.413472] AMD-Vi: No event written to event log
[   16.535235] AMD-Vi: No event written to event log
[   16.656992] AMD-Vi: No event written to event log
[   16.778748] AMD-Vi: No event written to event log
[   16.900575] AMD-Vi: No event written to event log
[   17.022329] AMD-Vi: No event written to event log
[   17.144093] AMD-Vi: No event written to event log
[   17.265823] AMD-Vi: No event written to event log
[   17.375613] sched: RT throttling activated
[   17.391758] AMD-Vi: No event written to event log
[   17.513451] AMD-Vi: No event written to event log
[   17.635209] AMD-Vi: No event written to event log
[   17.756962] AMD-Vi: No event written to event log
[   17.878782] AMD-Vi: No event written to event log
[   18.000537] AMD-Vi: No event written to event log
[   18.122310] AMD-Vi: No event written to event log
[   18.244066] AMD-Vi: No event written to event log
[   18.365842] AMD-Vi: No event written to event log
[   18.487535] AMD-Vi: No event written to event log
[   18.609300] AMD-Vi: No event written to event log
[   18.731058] AMD-Vi: No event written to event log
[   18.852844] AMD-Vi: No event written to event log
[   18.974595] AMD-Vi: No event written to event log
[   19.096475] AMD-Vi: No event written to event log
[   19.218229] AMD-Vi: No event written to event log
[   19.340012] AMD-Vi: No event written to event log
[   19.461745] AMD-Vi: No event written to event log
[   19.583464] AMD-Vi: No event written to event log
[   19.705219] AMD-Vi: No event written to event log
[   19.826976] AMD-Vi: No event written to event log
[   19.948744] AMD-Vi: No event written to event log
[   20.070498] AMD-Vi: No event written to event log
[   20.192257] AMD-Vi: No event written to event log
[   20.314013] AMD-Vi: No event written to event log
[   20.435711] AMD-Vi: No event written to event log
[   20.557464] AMD-Vi: No event written to event log
[   20.679221] AMD-Vi: No event written to event log
[   20.800975] AMD-Vi: No event written to event log
[   20.922767] AMD-Vi: No event written to event log
[   21.044646] AMD-Vi: No event written to event log
[   21.166403] AMD-Vi: No event written to event log
[   21.288159] AMD-Vi: No event written to event log
[   21.409911] AMD-Vi: No event written to event log
[   21.531638] AMD-Vi: No event written to event log
[   21.653393] AMD-Vi: No event written to event log
[   21.775166] AMD-Vi: No event written to event log
[   21.896954] AMD-Vi: No event written to event log
[   22.018703] AMD-Vi: No event written to event log
[   22.140462] AMD-Vi: No event written to event log
[   22.262226] AMD-Vi: No event written to event log
[   22.383979] AMD-Vi: No event written to event log
[   22.505705] AMD-Vi: No event written to event log
[   22.627459] AMD-Vi: No event written to event log
[   22.749218] AMD-Vi: No event written to event log
[   22.871226] AMD-Vi: No event written to event log
[   22.993107] AMD-Vi: No event written to event log
[   23.114859] AMD-Vi: No event written to event log
[   23.236614] AMD-Vi: No event written to event log
[   23.358435] AMD-Vi: No event written to event log
[   23.480198] AMD-Vi: No event written to event log
[   23.601955] AMD-Vi: No event written to event log
[   23.723686] AMD-Vi: No event written to event log
[   23.845502] AMD-Vi: No event written to event log
[   23.967259] AMD-Vi: No event written to event log
[   24.089014] AMD-Vi: No event written to event log
[   24.210778] AMD-Vi: No event written to event log
[   24.332600] AMD-Vi: No event written to event log
[   24.454364] AMD-Vi: No event written to event log
[   24.576119] AMD-Vi: No event written to event log
[   24.697839] AMD-Vi: No event written to event log
[   24.819570] AMD-Vi: No event written to event log
[   24.941515] AMD-Vi: No event written to event log
[   25.063272] AMD-Vi: No event written to event log
[   25.185038] AMD-Vi: No event written to event log
[   25.306793] AMD-Vi: No event written to event log
[   25.428617] AMD-Vi: No event written to event log
[   25.550395] AMD-Vi: No event written to event log
[   25.672158] AMD-Vi: No event written to event log
[   25.793913] AMD-Vi: No event written to event log
[   25.915701] AMD-Vi: No event written to event log
[   26.037435] AMD-Vi: No event written to event log
[   26.159194] AMD-Vi: No event written to event log
[   26.280948] AMD-Vi: No event written to event log
[   26.402779] AMD-Vi: No event written to event log
[   26.524535] AMD-Vi: No event written to event log
[   26.646288] AMD-Vi: No event written to event log
[   26.768044] AMD-Vi: No event written to event log
[   26.889950] AMD-Vi: No event written to event log
[   27.011669] AMD-Vi: No event written to event log
[   27.133401] AMD-Vi: No event written to event log
[   27.255156] AMD-Vi: No event written to event log
[   27.376983] AMD-Vi: No event written to event log
[   27.498741] AMD-Vi: No event written to event log
[   27.620495] AMD-Vi: No event written to event log
[   27.742250] AMD-Vi: No event written to event log
[   27.864070] AMD-Vi: No event written to event log
[   27.985825] AMD-Vi: No event written to event log
[   28.107520] AMD-Vi: No event written to event log
[   28.229276] AMD-Vi: No event written to event log
[   28.351096] AMD-Vi: No event written to event log
[   28.472860] AMD-Vi: No event written to event log
[   28.594614] AMD-Vi: No event written to event log
[   28.716369] AMD-Vi: No event written to event log
[   28.838312] AMD-Vi: No event written to event log
[   28.960065] AMD-Vi: No event written to event log
[   29.081822] AMD-Vi: No event written to event log
[   29.203543] AMD-Vi: No event written to event log
[   29.325364] AMD-Vi: No event written to event log
[   29.447118] AMD-Vi: No event written to event log
[   29.568876] AMD-Vi: No event written to event log
[   29.690630] AMD-Vi: No event written to event log
[   29.812387] AMD-Vi: No event written to event log
[   29.934225] AMD-Vi: No event written to event log
[   30.055978] AMD-Vi: No event written to event log
[   30.177708] AMD-Vi: No event written to event log
[   30.299430] AMD-Vi: No event written to event log
[   30.421250] AMD-Vi: No event written to event log
[   30.543004] AMD-Vi: No event written to event log
[   30.664760] AMD-Vi: No event written to event log
[   30.786630] AMD-Vi: No event written to event log
[   30.908447] AMD-Vi: No event written to event log
[   31.030203] AMD-Vi: No event written to event log
[   31.151966] AMD-Vi: No event written to event log
[   31.273697] AMD-Vi: No event written to event log
[   31.395456] AMD-Vi: No event written to event log
[   31.517211] AMD-Vi: No event written to event log
[   31.638966] AMD-Vi: No event written to event log
[   31.760722] AMD-Vi: No event written to event log
[   31.882542] AMD-Vi: No event written to event log
[   32.004296] AMD-Vi: No event written to event log
[   32.126052] AMD-Vi: No event written to event log
[   32.247774] AMD-Vi: No event written to event log
[   32.369543] AMD-Vi: No event written to event log
[   32.491299] AMD-Vi: No event written to event log
[   32.613051] AMD-Vi: No event written to event log
[   32.734935] AMD-Vi: No event written to event log
[   32.856759] AMD-Vi: No event written to event log
[   32.978529] AMD-Vi: No event written to event log
[   33.100284] AMD-Vi: No event written to event log
[   33.222041] AMD-Vi: No event written to event log
[   33.343861] AMD-Vi: No event written to event log
[   33.465589] AMD-Vi: No event written to event log
[   33.587312] AMD-Vi: No event written to event log
[   33.709067] AMD-Vi: No event written to event log
[   33.830886] AMD-Vi: No event written to event log
[   33.952649] AMD-Vi: No event written to event log
[   34.074405] AMD-Vi: No event written to event log
[   34.196163] AMD-Vi: No event written to event log
[   34.317983] AMD-Vi: No event written to event log
[   34.439711] AMD-Vi: No event written to event log
[   34.561423] AMD-Vi: No event written to event log
[   34.683292] AMD-Vi: No event written to event log
[   34.805048] AMD-Vi: No event written to event log
[   34.926868] AMD-Vi: No event written to event log
[   35.048622] AMD-Vi: No event written to event log
[   35.170378] AMD-Vi: No event written to event log
[   35.292135] AMD-Vi: No event written to event log
[   35.413955] AMD-Vi: No event written to event log
[   35.535681] AMD-Vi: No event written to event log
[   35.657393] AMD-Vi: No event written to event log
[   35.779152] AMD-Vi: No event written to event log
[   35.900972] AMD-Vi: No event written to event log
[   36.022724] AMD-Vi: No event written to event log
[   36.144482] AMD-Vi: No event written to event log
[   36.266238] AMD-Vi: No event written to event log
[   36.388056] AMD-Vi: No event written to event log
[   36.509819] AMD-Vi: No event written to event log
[   36.631639] AMD-Vi: No event written to event log
[   36.753358] AMD-Vi: No event written to event log
[   36.875175] AMD-Vi: No event written to event log
[   36.996941] AMD-Vi: No event written to event log
[   37.118696] AMD-Vi: No event written to event log
[   37.240463] AMD-Vi: No event written to event log
[   37.362251] AMD-Vi: No event written to event log
[   37.484019] AMD-Vi: No event written to event log
[   37.605741] AMD-Vi: No event written to event log
[   37.727453] AMD-Vi: No event written to event log
[   37.849250] AMD-Vi: No event written to event log
[   37.971019] AMD-Vi: No event written to event log
[   38.092773] AMD-Vi: No event written to event log
[   38.214528] AMD-Vi: No event written to event log
[   38.336296] AMD-Vi: No event written to event log
[   38.458054] AMD-Vi: No event written to event log
[   38.579894] AMD-Vi: No event written to event log
[   38.701591] AMD-Vi: No event written to event log
[   38.823350] AMD-Vi: No event written to event log
[   38.945104] AMD-Vi: No event written to event log
[   39.066869] AMD-Vi: No event written to event log
[   39.188625] AMD-Vi: No event written to event log
[   39.310390] AMD-Vi: No event written to event log
[   39.432152] AMD-Vi: No event written to event log
[   39.553876] AMD-Vi: No event written to event log
[   39.675599] AMD-Vi: No event written to event log
[   39.797353] AMD-Vi: No event written to event log
[   39.919143] AMD-Vi: No event written to event log
[   40.040895] AMD-Vi: No event written to event log
[   40.162650] AMD-Vi: No event written to event log
[   40.284417] AMD-Vi: No event written to event log
[   40.406202] AMD-Vi: No event written to event log
[   40.528043] AMD-Vi: No event written to event log
[   40.649737] AMD-Vi: No event written to event log
[   40.771493] AMD-Vi: No event written to event log
[   40.893281] AMD-Vi: No event written to event log
[   41.015040] AMD-Vi: No event written to event log
[   41.136799] AMD-Vi: No event written to event log
[   41.258555] AMD-Vi: No event written to event log
[   41.380340] AMD-Vi: No event written to event log
[   41.502066] AMD-Vi: No event written to event log
[   41.623787] AMD-Vi: No event written to event log
[   41.745543] AMD-Vi: No event written to event log
[   41.867364] AMD-Vi: No event written to event log
[   41.989126] AMD-Vi: No event written to event log
[   42.110883] AMD-Vi: No event written to event log
[   42.232638] AMD-Vi: No event written to event log
[   42.354457] AMD-Vi: No event written to event log
[   42.476335] AMD-Vi: No event written to event log
[   42.598056] AMD-Vi: No event written to event log
[   42.719767] AMD-Vi: No event written to event log
[   42.841586] AMD-Vi: No event written to event log
[   42.963341] AMD-Vi: No event written to event log
[   43.085098] AMD-Vi: No event written to event log
[   43.206863] AMD-Vi: No event written to event log
[   43.328683] AMD-Vi: No event written to event log
[   43.450435] AMD-Vi: No event written to event log
[   43.572192] AMD-Vi: No event written to event log
[   43.693888] AMD-Vi: No event written to event log
[   43.815708] AMD-Vi: No event written to event log
[   43.937462] AMD-Vi: No event written to event log
[   44.059218] AMD-Vi: No event written to event log
[   44.180975] AMD-Vi: No event written to event log
[   44.302730] AMD-Vi: No event written to event log
[   44.424661] AMD-Vi: No event written to event log
[   44.546425] AMD-Vi: No event written to event log
[   44.668181] AMD-Vi: No event written to event log
[   44.789913] AMD-Vi: No event written to event log
[   44.911732] AMD-Vi: No event written to event log
[   45.033486] AMD-Vi: No event written to event log
[   45.155242] AMD-Vi: No event written to event log
[   45.277001] AMD-Vi: No event written to event log
[   45.398819] AMD-Vi: No event written to event log
[   45.520572] AMD-Vi: No event written to event log
[   45.642329] AMD-Vi: No event written to event log
[   45.764050] AMD-Vi: No event written to event log
[   45.885834] AMD-Vi: No event written to event log
[   46.007589] AMD-Vi: No event written to event log
[   46.129347] AMD-Vi: No event written to event log
[   46.251102] AMD-Vi: No event written to event log
[   46.373041] AMD-Vi: No event written to event log
[   46.494799] AMD-Vi: No event written to event log
[   46.616561] AMD-Vi: No event written to event log
[   46.738327] AMD-Vi: No event written to event log
[   46.860121] AMD-Vi: No event written to event log
[   46.981814] AMD-Vi: No event written to event log
[   47.103571] AMD-Vi: No event written to event log
[   47.225327] AMD-Vi: No event written to event log
[   47.347151] AMD-Vi: No event written to event log
[   47.468909] AMD-Vi: No event written to event log
[   47.590665] AMD-Vi: No event written to event log
[   47.712421] AMD-Vi: No event written to event log
[   47.834205] AMD-Vi: No event written to event log
[   47.955899] AMD-Vi: No event written to event log
[   48.077665] AMD-Vi: No event written to event log
[   48.199420] AMD-Vi: No event written to event log
[   48.321249] AMD-Vi: No event written to event log
[   48.443029] AMD-Vi: No event written to event log
[   48.564786] AMD-Vi: No event written to event log
[   48.686540] AMD-Vi: No event written to event log
[   48.808370] AMD-Vi: No event written to event log
[   48.930098] AMD-Vi: No event written to event log
[   49.051820] AMD-Vi: No event written to event log
[   49.173583] AMD-Vi: No event written to event log
[   49.295339] AMD-Vi: No event written to event log
[   49.417160] AMD-Vi: No event written to event log
[   49.538912] AMD-Vi: No event written to event log
[   49.660669] AMD-Vi: No event written to event log
[   49.782436] AMD-Vi: No event written to event log
[   49.904220] AMD-Vi: No event written to event log
[   50.025913] AMD-Vi: No event written to event log
[   50.147672] AMD-Vi: No event written to event log
[   50.269537] AMD-Vi: No event written to event log
[   50.391356] AMD-Vi: No event written to event log
[   50.513124] AMD-Vi: No event written to event log
[   50.634878] AMD-Vi: No event written to event log
[   50.756635] AMD-Vi: No event written to event log
[   50.878452] AMD-Vi: No event written to event log
[   51.000172] AMD-Vi: No event written to event log
[   51.121876] AMD-Vi: No event written to event log
[   51.243634] AMD-Vi: No event written to event log
[   51.365452] AMD-Vi: No event written to event log
[   51.487218] AMD-Vi: No event written to event log
[   51.608977] AMD-Vi: No event written to event log
[   51.730728] AMD-Vi: No event written to event log
[   51.852548] AMD-Vi: No event written to event log
[   51.974302] AMD-Vi: No event written to event log
[   52.095997] AMD-Vi: No event written to event log
[   52.217867] AMD-Vi: No event written to event log
[   52.339686] AMD-Vi: No event written to event log
[   52.461449] AMD-Vi: No event written to event log
[   52.583206] AMD-Vi: No event written to event log
[   52.704960] AMD-Vi: No event written to event log
[   52.826780] AMD-Vi: No event written to event log
[   52.948544] AMD-Vi: No event written to event log
[   53.070300] AMD-Vi: No event written to event log
[   53.192022] AMD-Vi: No event written to event log
[   53.313842] AMD-Vi: No event written to event log
[   53.435596] AMD-Vi: No event written to event log
[   53.557361] AMD-Vi: No event written to event log
[   53.679116] AMD-Vi: No event written to event log
[   53.800935] AMD-Vi: No event written to event log
[   53.922688] AMD-Vi: No event written to event log
[   54.044648] AMD-Vi: No event written to event log
[   54.166525] AMD-Vi: No event written to event log
[   54.288278] AMD-Vi: No event written to event log
[   54.410101] AMD-Vi: No event written to event log
[   54.531827] AMD-Vi: No event written to event log
[   54.653549] AMD-Vi: No event written to event log
[   54.775313] AMD-Vi: No event written to event log
[   54.897132] AMD-Vi: No event written to event log
[   55.018887] AMD-Vi: No event written to event log
[   55.140642] AMD-Vi: No event written to event log
[   55.262398] AMD-Vi: No event written to event log
[   55.384217] AMD-Vi: No event written to event log
[   55.505942] AMD-Vi: No event written to event log
[   55.627651] AMD-Vi: No event written to event log
[   55.749409] AMD-Vi: No event written to event log
[   55.871216] AMD-Vi: No event written to event log
[   55.992973] AMD-Vi: No event written to event log
[   56.114851] AMD-Vi: No event written to event log
[   56.236616] AMD-Vi: No event written to event log
[   56.358428] AMD-Vi: No event written to event log
[   56.480182] AMD-Vi: No event written to event log
[   56.601902] AMD-Vi: No event written to event log
[   56.723626] AMD-Vi: No event written to event log
[   56.845396] AMD-Vi: No event written to event log
[   56.967153] AMD-Vi: No event written to event log
[   57.088911] AMD-Vi: No event written to event log
[   57.210666] AMD-Vi: No event written to event log
[   57.332425] AMD-Vi: No event written to event log
[   57.454180] AMD-Vi: No event written to event log
[   57.575920] AMD-Vi: No event written to event log
[   57.697683] AMD-Vi: No event written to event log
[   57.819441] AMD-Vi: No event written to event log
[   57.941197] AMD-Vi: No event written to event log
[   58.063073] AMD-Vi: No event written to event log
[   58.184838] AMD-Vi: No event written to event log
[   58.306627] AMD-Vi: No event written to event log
[   58.428389] AMD-Vi: No event written to event log
[   58.550152] AMD-Vi: No event written to event log
[   58.671880] AMD-Vi: No event written to event log
[   58.793638] AMD-Vi: No event written to event log
[   58.915396] AMD-Vi: No event written to event log
[   59.037160] AMD-Vi: No event written to event log
[   59.158917] AMD-Vi: No event written to event log
[   59.280682] AMD-Vi: No event written to event log
[   59.402472] AMD-Vi: No event written to event log
[   59.524228] AMD-Vi: No event written to event log
[   59.645925] AMD-Vi: No event written to event log
[   59.767679] AMD-Vi: No event written to event log
[   59.889470] AMD-Vi: No event written to event log
[   60.011357] AMD-Vi: No event written to event log
[   60.133114] AMD-Vi: No event written to event log
[   60.254879] AMD-Vi: No event written to event log
[   60.376700] AMD-Vi: No event written to event log
[   60.498455] AMD-Vi: No event written to event log
[   60.620217] AMD-Vi: No event written to event log
[   60.741938] AMD-Vi: No event written to event log
[   60.863759] AMD-Vi: No event written to event log
[   60.985512] AMD-Vi: No event written to event log
[   61.107271] AMD-Vi: No event written to event log
[   61.229026] AMD-Vi: No event written to event log
[   61.350855] AMD-Vi: No event written to event log
[   61.472609] AMD-Vi: No event written to event log
[   61.594365] AMD-Vi: No event written to event log
[   61.716086] AMD-Vi: No event written to event log
[   61.837870] AMD-Vi: No event written to event log
[   61.959745] AMD-Vi: No event written to event log
[   62.081502] AMD-Vi: No event written to event log
[   62.203258] AMD-Vi: No event written to event log
[   62.325078] AMD-Vi: No event written to event log
[   62.446842] AMD-Vi: No event written to event log
[   62.568596] AMD-Vi: No event written to event log
[   62.690353] AMD-Vi: No event written to event log
[   62.812137] AMD-Vi: No event written to event log
[   62.933831] AMD-Vi: No event written to event log
[   63.055587] AMD-Vi: No event written to event log
[   63.177345] AMD-Vi: No event written to event log
[   63.299173] AMD-Vi: No event written to event log
[   63.420946] AMD-Vi: No event written to event log
[   63.542700] AMD-Vi: No event written to event log
[   63.664457] AMD-Vi: No event written to event log
[   63.786213] AMD-Vi: No event written to event log
[   63.908092] AMD-Vi: No event written to event log
[   64.029786] AMD-Vi: No event written to event log
[   64.151543] AMD-Vi: No event written to event log
[   64.273301] AMD-Vi: No event written to event log
[   64.395122] AMD-Vi: No event written to event log
[   64.516872] AMD-Vi: No event written to event log
[   64.638627] AMD-Vi: No event written to event log
[   64.760384] AMD-Vi: No event written to event log
[   64.882170] AMD-Vi: No event written to event log
[   65.003862] AMD-Vi: No event written to event log
[   65.125620] AMD-Vi: No event written to event log
[   65.247384] AMD-Vi: No event written to event log
[   65.369207] AMD-Vi: No event written to event log
[   65.490961] AMD-Vi: No event written to event log
[   65.612716] AMD-Vi: No event written to event log
[   65.734471] AMD-Vi: No event written to event log
[   65.856387] AMD-Vi: No event written to event log
[   65.978114] AMD-Vi: No event written to event log
[   66.099818] AMD-Vi: No event written to event log
[   66.221573] AMD-Vi: No event written to event log
[   66.343396] AMD-Vi: No event written to event log
[   66.465148] AMD-Vi: No event written to event log
[   66.586903] AMD-Vi: No event written to event log
[   66.708660] AMD-Vi: No event written to event log
[   66.830482] AMD-Vi: No event written to event log
[   66.952243] AMD-Vi: No event written to event log
[   67.073938] AMD-Vi: No event written to event log
[   67.195695] AMD-Vi: No event written to event log
[   67.317514] AMD-Vi: No event written to event log
[   67.439278] AMD-Vi: No event written to event log
[   67.561032] AMD-Vi: No event written to event log
[   67.682807] AMD-Vi: No event written to event log
[   67.804750] AMD-Vi: No event written to event log
[   67.926510] AMD-Vi: No event written to event log
[   68.048267] AMD-Vi: No event written to event log
[   68.169988] AMD-Vi: No event written to event log
[   68.291808] AMD-Vi: No event written to event log
[   68.413563] AMD-Vi: No event written to event log
[   68.535317] AMD-Vi: No event written to event log
[   68.657075] AMD-Vi: No event written to event log
[   68.778830] AMD-Vi: No event written to event log
[   68.900649] AMD-Vi: No event written to event log
[   69.022406] AMD-Vi: No event written to event log
[   69.144129] AMD-Vi: No event written to event log
[   69.265849] AMD-Vi: No event written to event log
[   69.387671] AMD-Vi: No event written to event log
[   69.509431] AMD-Vi: No event written to event log
[   69.631204] AMD-Vi: No event written to event log
[   69.753083] AMD-Vi: No event written to event log
[   69.874903] AMD-Vi: No event written to event log
[   69.996656] AMD-Vi: No event written to event log
[   70.118418] AMD-Vi: No event written to event log
[   70.240176] AMD-Vi: No event written to event log
[   70.361936] AMD-Vi: No event written to event log
[   70.483683] AMD-Vi: No event written to event log
[   70.605437] AMD-Vi: No event written to event log
[   70.727194] AMD-Vi: No event written to event log
[   70.849013] AMD-Vi: No event written to event log
[   70.970775] AMD-Vi: No event written to event log
[   71.092548] AMD-Vi: No event written to event log
[   71.214306] AMD-Vi: No event written to event log
[   71.336089] AMD-Vi: No event written to event log
[   71.457794] AMD-Vi: No event written to event log
[   71.579549] AMD-Vi: No event written to event log
[   71.701427] AMD-Vi: No event written to event log
[   71.823256] AMD-Vi: No event written to event log
[   71.945009] AMD-Vi: No event written to event log
[   72.066765] AMD-Vi: No event written to event log
[   72.188522] AMD-Vi: No event written to event log
[   72.310341] AMD-Vi: No event written to event log
[   72.432094] AMD-Vi: No event written to event log
[   72.553792] AMD-Vi: No event written to event log
[   72.675546] AMD-Vi: No event written to event log
[   72.797364] AMD-Vi: No event written to event log
[   72.919121] AMD-Vi: No event written to event log
[   73.040875] AMD-Vi: No event written to event log
[   73.162641] AMD-Vi: No event written to event log
[   73.284460] AMD-Vi: No event written to event log
[   73.406214] AMD-Vi: No event written to event log
[   73.527938] AMD-Vi: No event written to event log
[   73.649804] AMD-Vi: No event written to event log
[   73.771562] AMD-Vi: No event written to event log
[   73.893399] AMD-Vi: No event written to event log
[   74.015154] AMD-Vi: No event written to event log
[   74.136908] AMD-Vi: No event written to event log
[   74.258666] AMD-Vi: No event written to event log
[   74.380474] AMD-Vi: No event written to event log
[   74.502231] AMD-Vi: No event written to event log
[   74.623950] AMD-Vi: No event written to event log
[   74.745681] AMD-Vi: No event written to event log
[   74.867471] AMD-Vi: No event written to event log
[   74.989238] AMD-Vi: No event written to event log
[   75.111005] AMD-Vi: No event written to event log
[   75.232759] AMD-Vi: No event written to event log
[   75.354542] AMD-Vi: No event written to event log
[   75.476300] AMD-Vi: No event written to event log
[   75.598137] AMD-Vi: No event written to event log
[   75.719829] AMD-Vi: No event written to event log
[   75.841595] AMD-Vi: No event written to event log
[   75.963351] AMD-Vi: No event written to event log
[   76.085107] AMD-Vi: No event written to event log
[   76.206862] AMD-Vi: No event written to event log
[   76.328639] AMD-Vi: No event written to event log
[   76.450395] AMD-Vi: No event written to event log
[   76.572113] AMD-Vi: No event written to event log
[   76.693846] AMD-Vi: No event written to event log
[   76.815634] AMD-Vi: No event written to event log
[   76.937394] AMD-Vi: No event written to event log
[   77.059149] AMD-Vi: No event written to event log
[   77.180904] AMD-Vi: No event written to event log
[   77.302696] AMD-Vi: No event written to event log
[   77.424455] AMD-Vi: No event written to event log
[   77.546288] AMD-Vi: No event written to event log
[   77.667983] AMD-Vi: No event written to event log
[   77.789778] AMD-Vi: No event written to event log
[   77.911547] AMD-Vi: No event written to event log
[   78.033303] AMD-Vi: No event written to event log
[   78.038095] ata4.00: qc timeout (cmd 0xec)
[   78.042202] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   78.048291] ata4: limiting SATA link speed to 1.5 Gbps
[   78.512773] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  108.492201] ata4.00: qc timeout (cmd 0xec)
[  108.496328] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  108.961828] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  108.968564] Freeing unused kernel memory: 1504K (ffffffff81d3c000 - ffffffff81eb4000)
[  108.976462] Write protecting the kernel read-only data: 12288k
[  108.982671] Freeing unused kernel memory: 504K (ffff880036782000 - ffff880036800000)
[  108.990761] Freeing unused kernel memory: 724K (ffff880036b4b000 - ffff880036c00000)
[  109.117486] AMD-Vi: Completion-Wait loop timed out
[  109.136444] random: systemd urandom read with 7 bits of entropy available
[  109.260307] AMD-Vi: Completion-Wait loop timed out
[  109.381851] AMD-Vi: Completion-Wait loop timed out
[  109.503535] AMD-Vi: Completion-Wait loop timed out
[  109.509140] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFU)
[  109.527353] systemd[1]: Detected architecture x86-64.
[  109.532449] systemd[1]: Running in initial RAM disk.
[  109.654198] AMD-Vi: Completion-Wait loop timed out
[  109.775709] AMD-Vi: Completion-Wait loop timed out

Welcome to Fedora 22 (Twenty Two) dracut-041-10.fc22.1 (Initramfs)!

[  109.906788] AMD-Vi: Completion-Wait loop timed out
[  109.911819] systemd[1]: Set hostname to <dhcp-128-84.nay.redhat.com>.
[  110.084869] AMD-Vi: Completion-Wait loop timed out
[  110.206388] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Local File Systems.
[  110.334413] AMD-Vi: Completion-Wait loop timed out
[  110.339367] systemd[1]: Reached target Local File Systems.
[  110.344886] systemd[1]: Starting Local File Systems.
[  110.467001] AMD-Vi: Completion-Wait loop timed out
[  110.588548] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Created slice -.slice.
[  110.715047] AMD-Vi: Completion-Wait loop timed out
[  110.719994] systemd[1]: Created slice -.slice.
[  110.724483] systemd[1]: Starting -.slice.
[  110.845425] AMD-Vi: Completion-Wait loop timed out
[  110.966968] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on Journal Socket (/dev/log).
[  111.095711] AMD-Vi: Completion-Wait loop timed out
[  111.100643] systemd[1]: Listening on Journal Socket (/dev/log).
[  111.106599] systemd[1]: Starting Journal Socket (/dev/log).
[  111.228983] AMD-Vi: Completion-Wait loop timed out
[  111.350526] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Swap.
[  111.477406] AMD-Vi: Completion-Wait loop timed out
[  111.482380] systemd[1]: Reached target Swap.
[  111.486704] systemd[1]: Starting Swap.
[  111.607474] AMD-Vi: Completion-Wait loop timed out
[  111.729015] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Created slice System Slice.
[  111.856070] AMD-Vi: Completion-Wait loop timed out
[  111.860960] systemd[1]: Created slice System Slice.
[  111.865882] systemd[1]: Starting System Slice.
[  111.987145] AMD-Vi: Completion-Wait loop timed out
[  112.108692] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Slices.
[  112.235763] AMD-Vi: Completion-Wait loop timed out
[  112.240700] systemd[1]: Reached target Slices.
[  112.245207] systemd[1]: Starting Slices.
[  112.366174] AMD-Vi: Completion-Wait loop timed out
[  112.487721] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Created slice system-systemd\x2dfsck.slice.
[  112.616426] AMD-Vi: Completion-Wait loop timed out
[  112.621358] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[  112.627683] systemd[1]: Starting system-systemd\x2dfsck.slice.
[  112.633682] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[  112.641659] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[  112.766547] AMD-Vi: Completion-Wait loop timed out
[  112.888092] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on udev Control Socket.
[  113.016009] AMD-Vi: Completion-Wait loop timed out
[  113.020906] systemd[1]: Listening on udev Control Socket.
[  113.026347] systemd[1]: Starting udev Control Socket.
[  113.148303] AMD-Vi: Completion-Wait loop timed out
[  113.269848] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on udev Kernel Socket.
[  113.397672] AMD-Vi: Completion-Wait loop timed out
[  113.402600] systemd[1]: Listening on udev Kernel Socket.
[  113.407953] systemd[1]: Starting udev Kernel Socket.
[  113.529730] AMD-Vi: Completion-Wait loop timed out
[  113.651272] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Timers.
[  113.778398] AMD-Vi: Completion-Wait loop timed out
[  113.783345] systemd[1]: Reached target Timers.
[  113.787833] systemd[1]: Starting Timers.
[  113.908696] AMD-Vi: Completion-Wait loop timed out
[  114.030240] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on Journal Socket.
[  114.157095] AMD-Vi: Completion-Wait loop timed out
[  114.162057] systemd[1]: Listening on Journal Socket.
[  114.167095] systemd[1]: Starting Journal Socket.
[  114.172045] systemd[1]: Started Load Kernel Modules.
[  114.177703] systemd[1]: Starting Apply Kernel Variables...
[  114.300753] AMD-Vi: Completion-Wait loop timed out
[  114.422254] AMD-Vi: Completion-Wait loop timed out
         Starting Apply Kernel Variables...
[  114.551762] AMD-Vi: Completion-Wait loop timed out
[  114.557531] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[  114.684430] AMD-Vi: Completion-Wait loop timed out
[  114.805917] AMD-Vi: Completion-Wait loop timed out
         Starting Create list of required st... nodes for the current kernel...
[  114.936330] AMD-Vi: Completion-Wait loop timed out
[  114.941422] systemd[1]: Started dracut ask for additional cmdline parameters.
[  114.949481] systemd[1]: Starting dracut cmdline hook...
[  115.072101] AMD-Vi: Completion-Wait loop timed out
[  115.193585] AMD-Vi: Completion-Wait loop timed out
         Starting dracut cmdline hook...
[  115.320837] AMD-Vi: Completion-Wait loop timed out
[  115.537819] AMD-Vi: Completion-Wait loop timed out
[  115.659371] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on Journal Audit Socket.
[  115.787578] AMD-Vi: Completion-Wait loop timed out
[  115.792542] systemd[1]: Listening on Journal Audit Socket.
[  115.798067] systemd[1]: Starting Journal Audit Socket.
[  115.920014] AMD-Vi: Completion-Wait loop timed out
[  116.041559] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Sockets.
[  116.168241] AMD-Vi: Completion-Wait loop timed out
[  116.173204] systemd[1]: Reached target Sockets.
[  116.177799] systemd[1]: Starting Sockets.
[  116.182650] systemd[1]: Starting Journal Service...
[  116.305004] AMD-Vi: Completion-Wait loop timed out
[  116.426518] AMD-Vi: Completion-Wait loop timed out
         Starting Journal Service...
[  116.552778] AMD-Vi: Completion-Wait loop timed out
[  116.717018] AMD-Vi: Completion-Wait loop timed out
[  116.838571] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target Paths.
[  116.965608] AMD-Vi: Completion-Wait loop timed out
[  116.970651] systemd[1]: Reached target Paths.
[  116.975090] systemd[1]: Starting Paths.
[  117.096320] AMD-Vi: Completion-Wait loop timed out
[  117.217865] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Journal Service.
[  117.345272] AMD-Vi: Completion-Wait loop timed out
[  117.350341] systemd[1]: Started Journal Service.
[  117.355355] audit: type=1130 audit(1444478723.813:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" host'
[  117.492516] AMD-Vi: Completion-Wait loop timed out
[  117.614061] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Apply Kernel Variables.
[  117.741857] AMD-Vi: Completion-Wait loop timed out
[  117.746996] audit: type=1130 audit(1444478724.205:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostna'
[  117.883880] AMD-Vi: Completion-Wait loop timed out
[  118.005428] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[  118.137497] AMD-Vi: Completion-Wait loop timed out
[  118.142995] audit: type=1130 audit(1444478724.601:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hos'
[  118.280232] AMD-Vi: Completion-Wait loop timed out
[  118.401781] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started dracut cmdline hook.
[  118.528164] AMD-Vi: Completion-Wait loop timed out
[  118.533248] audit: type=1130 audit(1444478724.992:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostna'
[  118.677413] AMD-Vi: Completion-Wait loop timed out
[  118.798969] AMD-Vi: Completion-Wait loop timed out
         Starting dracut pre-udev hook...
[  118.926678] AMD-Vi: Completion-Wait loop timed out
[  119.087560] AMD-Vi: Completion-Wait loop timed out
[  119.209114] AMD-Vi: Completion-Wait loop timed out
         Starting Create Static Device Nodes in /dev...
[  119.336435] AMD-Vi: Completion-Wait loop timed out
[  119.459259] AMD-Vi: Completion-Wait loop timed out
[  119.580807] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started dracut pre-udev hook.
[  119.709181] AMD-Vi: Completion-Wait loop timed out
[  119.714321] audit: type=1130 audit(1444478726.174:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostn'
[  119.851282] AMD-Vi: Completion-Wait loop timed out
[  119.972829] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Create Static Device Nodes in /dev.
[  120.101760] AMD-Vi: Completion-Wait loop timed out
[  120.107267] audit: type=1130 audit(1444478726.567:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/sys'
[  120.250426] AMD-Vi: Completion-Wait loop timed out
[  120.371972] AMD-Vi: Completion-Wait loop timed out
         Starting udev Kernel Device Manager...
[  120.499290] AMD-Vi: Completion-Wait loop timed out
[  120.621705] AMD-Vi: Completion-Wait loop timed out
[  120.743248] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started udev Kernel Device Manager.
[  120.871077] AMD-Vi: Completion-Wait loop timed out
[  120.876217] audit: type=1130 audit(1444478727.337:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostnam'
[  121.013453] AMD-Vi: Completion-Wait loop timed out
[  121.134963] AMD-Vi: Completion-Wait loop timed out
         Starting dracut pre-trigger hook...
[  121.262612] AMD-Vi: Completion-Wait loop timed out
[  121.403624] AMD-Vi: Completion-Wait loop timed out
[  121.525179] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started dracut pre-trigger hook.
[  121.653427] AMD-Vi: Completion-Wait loop timed out
[  121.658507] audit: type=1130 audit(1444478728.120:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-trigger comm="systemd" exe="/usr/lib/systemd/systemd" ho'
[  121.796692] AMD-Vi: Completion-Wait loop timed out
[  121.918214] AMD-Vi: Completion-Wait loop timed out
         Starting udev Coldplug all Devices...
[  122.045920] AMD-Vi: Completion-Wait loop timed out
[  122.200675] AMD-Vi: Completion-Wait loop timed out
[  122.322223] AMD-Vi: Completion-Wait loop timed out
         Mounting Configuration File System...
[  122.452561] AMD-Vi: Completion-Wait loop timed out
[  122.506271] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[  122.519493] [drm] Initialized drm 1.1.0 20060810
[  122.643944] AMD-Vi: Completion-Wait loop timed out
[  122.766049] AMD-Vi: Completion-Wait loop timed out
[  122.887596] AMD-Vi: Completion-Wait loop timed out
[  122.997836] [drm] radeon kernel modesetting enabled.
[  123.007044] r8169 0000:01:00.0 eth0: RTL8168evl/8111evl at 0xffffc900000ee000, fc:aa:14:c0:c2:7e, XID 0c900880 IRQ 31
[  123.017709] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[  123.029068] [drm] initializing kernel modesetting (KAVERI 0x1002:0x130F 0x1002:0x0123).
[  OK  ] Mounted Configuration File System.
[  123.159924] AMD-Vi: Completion-Wait loop timed out
[  123.169024] [drm] register mmio base: 0xFEB00000
[  123.173710] [drm] register mmio size: 262144
[  123.189880] [drm] doorbell mmio base: 0xD0000000
[  123.194561] [drm] doorbell mmio size: 8388608
[  123.209906] ATOM BIOS: 113
[  123.216023] radeon 0000:00:01.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[  123.224958] radeon 0000:00:01.0: GTT: 2048M 0x0000000040000000 - 0x00000000BFFFFFFF
[  123.232610] [drm] Detected VRAM RAM=1024M, BAR=256M
[  123.237488] [drm] RAM width 128bits DDR
[  123.263470] [TTM] Zone  kernel: Available graphics memory: 120812 kiB
[  123.269943] [TTM] Initializing pool allocator
[  123.274396] [TTM] Initializing DMA pool allocator
[  123.279174] [drm] radeon: 1024M of VRAM memory ready
[  123.284176] [drm] radeon: 2048M of GTT memory ready.
[  123.406712] AMD-Vi: Completion-Wait loop timed out
[  123.528259] AMD-Vi: Completion-Wait loop timed out
[  123.533206] [drm] Loading kaveri Microcode
[  123.537537] [drm] Internal thermal controller without fan control
[  123.545454] [drm] radeon: dpm initialized
[  123.552634] [drm] Found VCE firmware/feedback version 40.2.2 / 15!
[  123.558892] [drm] GART: num cpu pages 524288, num gpu pages 524288
[  123.580001] [drm] PCIE GART of 2048M enabled (table at 0x0000000000324000).
[  123.587161] radeon 0000:00:01.0: WB enabled
[  123.591684] radeon 0000:00:01.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffff88002ff3cc00
[  123.602522] radeon 0000:00:01.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffff88002ff3cc04
[  123.613294] radeon 0000:00:01.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffff88002ff3cc08
[  123.624061] radeon 0000:00:01.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffff88002ff3cc0c
[  123.634835] radeon 0000:00:01.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffff88002ff3cc10
[  123.646022] radeon 0000:00:01.0: fence driver on ring 5 use gpu addr 0x0000000000076c98 and cpu addr 0xffffc90000436c98
[  123.657519] radeon 0000:00:01.0: fence driver on ring 6 use gpu addr 0x0000000040000c18 and cpu addr 0xffff88002ff3cc18
[  123.668357] radeon 0000:00:01.0: fence driver on ring 7 use gpu addr 0x0000000040000c1c and cpu addr 0xffff88002ff3cc1c
[  123.679324] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[  123.685968] [drm] Driver supports precise vblank timestamp query.
[  123.809334] AMD-Vi: Completion-Wait loop timed out
[[  123.814376] radeon 0000:00:01.0: radeon: using MSI.
  OK  ][  123.819359] do_IRQ: 0.227 No irq handler for vector
 Started udev Co[  123.942445] AMD-Vi: Completion-Wait loop timed out
[  124.063999] AMD-Vi: Completion-Wait loop timed out
ldplug all Devic[  124.068974] [drm] radeon: irq initialized.
es.
[  124.496949] AMD-Vi: Completion-Wait loop timed out
[  124.501943] audit: type=1130 audit(1444478730.966:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd"'
[  124.644743] AMD-Vi: Completion-Wait loop timed out
[  124.766293] AMD-Vi: Completion-Wait loop timed out
[  124.918633] [drm:cik_ring_test [radeon]] *ERROR* radeon: ring 0 test failed (scratch(0x3010C)=0xCAFEDEAD)
[  124.928256] radeon 0000:00:01.0: disabling GPU acceleration
         Starting dracut initqueue hook...
[  125.346842] AMD-Vi: Completion-Wait loop timed out
[  125.468567] AMD-Vi: Completion-Wait loop timed out
[  125.590108] AMD-Vi: Completion-Wait loop timed out
[  125.735280] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Reached target System Initialization.
[  125.857603] AMD-Vi: Completion-Wait loop timed out
[  125.979205] AMD-Vi: Completion-Wait loop timed out
[  126.101050] AMD-Vi: Completion-Wait loop timed out
[  126.222597] AMD-Vi: Completion-Wait loop timed out
[  126.234207] [drm] Radeon Display Connectors
[  126.238468] [drm] Connector 0:
[  126.241525] [drm]   DVI-D-1
[  126.244320] [drm]   HPD3
[  126.246857] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
[  126.254246] [drm]   Encoders:
[  126.257221] [drm]     DFP2: INTERNAL_UNIPHY2
[  126.261489] [drm] Connector 1:
[  126.264547] [drm]   HDMI-A-1
[  126.267429] [drm]   HPD1
[  126.269968] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
[  126.277357] [drm]   Encoders:
[  126.280330] [drm]     DFP1: INTERNAL_UNIPHY
[  126.284513] [drm] Connector 2:
[  126.287568] [drm]   VGA-1
[  126.290191] [drm]   HPD2
[  126.292729] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
[  126.300118] [drm]   Encoders:
[  126.303086] [drm]     CRT1: INTERNAL_UNIPHY3
[  126.307354] [drm]     CRT1: NUTMEG
[  OK  ] Reached target Basic System.
[  126.447219] AMD-Vi: Completion-Wait loop timed out
[  126.531921] [drm] fb mappable at 0xC0725000
[  126.536178] [drm] vram apper at 0xC0000000
[  126.540282] [drm] size 5242880
[  126.543344] [drm] fb depth is 24
[  126.546572] [drm]    pitch is 5120
[  126.550984] fbcon: radeondrmfb (fb0) is primary device
[  126.608228] Console: switching to colour frame buffer device 160x64
[  126.624424] radeon 0000:00:01.0: fb0: radeondrmfb frame buffer device
[  126.640232] ACPI Error: [\_SB_.ALIB] Namespace lookup failure, AE_NOT_FOUND (20150818/psargs-359)
[  126.649230] ACPI Error: Method parse/execution failed [\_SB.PCI0.VGA.ATC0] (Node ffff8800340af028), AE_NOT_FOUND (20150818/psparse-542)
[  126.661598] ACPI Error: Method parse/execution failed [\_SB.PCI0.VGA.ATCS] (Node ffff8800340af000), AE_NOT_FOUND (20150818/psparse-542)
[  126.674244] [drm] Initialized radeon 2.43.0 20080528 for 0000:00:01.0 on minor 0
[  126.798771] AMD-Vi: Completion-Wait loop timed out
[  126.920345] AMD-Vi: Completion-Wait loop timed out
[  126.954279] [drm] amdgpu kernel modesetting enabled.
[  127.076114] AMD-Vi: Completion-Wait loop timed out
[  127.197687] AMD-Vi: Completion-Wait loop timed out
[  127.210139] scsi host4: pata_atiixp
[  127.215227] scsi host5: pata_atiixp
[  127.220194] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf100 irq 14
[  127.227252] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf108 irq 15
[  127.434560] ata6.00: ATAPI: PIONEER DVD-ROM DVD-232, 1.00, max UDMA/100
[  127.441223] ata6.00: limited to UDMA/33 due to 40-wire cable
[  127.489733] r8169 0000:01:00.0 enp1s0: renamed from eth0
[  127.522494] ata6.00: configured for UDMA/33
[  127.539354] scsi 5:0:0:0: CD-ROM            PIONEER  DVD-ROM DVD-232  1.00 PQ: 0 ANSI: 5
[  127.593666] sr 5:0:0:0: [sr0] scsi3-mmc drive: 0x/0x caddy
[  127.599178] cdrom: Uniform CD-ROM driver Revision: 3.20
[  127.613423] sr 5:0:0:0: Attached scsi generic sg0 type 5
[  291.971401] random: nonblocking pool is initialized
[  312.307799] AMD-Vi: Completion-Wait loop timed out
[  312.429378] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Kdump V[  311.026308] dracut-initqueue[254]: Warning: Could not boot.
[  311.275719] dracut-initqueue[254]: Warning: /dev/disk/by-uuid/4b765449-4873-42cc-845f-56aba6804aff does not e[  312.454473] systemd-journald[203]: Received SIGTERM from PID 1 (systemd).
xist
[  311.283[  312.462298] systemd[1]: Stopping Journal Service...
606] dracut-init[  312.469556] systemd[1]: Stopped target Initrd File Systems.
queue[254]: Job for emergency.se[  312.476938] systemd[1]: Stopped target Remote File Systems.
[  312.484568] systemd[1]: Stopped target Remote File Systems (Pre).

[  312.608289] AMD-Vi: Completion-Wait loop timed out
[  312.780052] AMD-Vi: Completion-Wait loop timed out
[  312.901629] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Slices.
[  313.130027] AMD-Vi: Completion-Wait loop timed out
[  313.135039] systemd[1]: Stopped target Slices.
[  313.139605] systemd[1]: Stopping Slices.
[  313.260856] AMD-Vi: Completion-Wait loop timed out
[  313.382427] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Apply Kernel Variables.
[  313.511688] AMD-Vi: Completion-Wait loop timed out
[  313.517995] systemd[1]: Stopped Apply Kernel Variables.
[  313.524713] audit: type=1131 audit(1444478920.156:11): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostn'
[  313.547337] systemd[1]: Stopping Apply Kernel Variables...
[  313.671149] AMD-Vi: Completion-Wait loop timed out
[  313.794197] AMD-Vi: Completion-Wait loop timed out
         Stopping Apply Kernel Variables...
[  313.923324] AMD-Vi: Completion-Wait loop timed out
[  314.046517] AMD-Vi: Completion-Wait loop timed out
[  314.169514] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Timers.
[  314.297993] AMD-Vi: Completion-Wait loop timed out
[  314.304314] systemd[1]: Stopped target Timers.
[  314.310273] systemd[1]: Stopping Timers.
[  314.432469] AMD-Vi: Completion-Wait loop timed out
[  314.555434] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped File System Check on /dev/d...449-4873-42cc-845f-56aba6804aff.
[  314.688598] AMD-Vi: Completion-Wait loop timed out
[  314.694932] systemd[1]: Stopped File System Check on /dev/disk/by-uuid/4b765449-4873-42cc-845f-56aba6804aff.
[  314.823358] AMD-Vi: Completion-Wait loop timed out
[  314.946308] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Removed slice system-systemd\x2dfsck.slice.
[  315.076252] AMD-Vi: Completion-Wait loop timed out
[  315.082652] systemd[1]: Removed slice system-systemd\x2dfsck.slice.
[  315.090406] systemd[1]: Stopping system-systemd\x2dfsck.slice.
[  315.214513] AMD-Vi: Completion-Wait loop timed out
[  315.337542] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Sockets.
[  315.465894] AMD-Vi: Completion-Wait loop timed out
[  315.472220] systemd[1]: Stopped target Sockets.
[  315.478244] systemd[1]: Stopping Sockets.
[  315.600506] AMD-Vi: Completion-Wait loop timed out
[  315.723418] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Paths.
[  315.851536] AMD-Vi: Completion-Wait loop timed out
[  315.857794] systemd[1]: Stopped target Paths.
[  315.863552] systemd[1]: Stopping Paths.
[  315.868743] systemd[1]: Stopped Dispatch Password Requests to Console Directory Watch.
[  315.877987] systemd[1]: Stopping Dispatch Password Requests to Console Directory Watch.
[  316.004166] AMD-Vi: Completion-Wait loop timed out
[  316.127074] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Reload Configuration from the Real Root.
[  316.258199] AMD-Vi: Completion-Wait loop timed out
[  316.264409] systemd[1]: Stopped Reload Configuration from the Real Root.
[  316.389337] AMD-Vi: Completion-Wait loop timed out
[  316.512254] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped target Initrd Root File System.
[  316.641859] AMD-Vi: Completion-Wait loop timed out
[  316.648050] systemd[1]: Stopped target Initrd Root File System.
[  316.772141] AMD-Vi: Completion-Wait loop timed out
[  316.894995] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped dracut pre-mount hook.
[  317.024520] AMD-Vi: Completion-Wait loop timed out
[  317.030615] systemd[1]: Stopped dracut pre-mount hook.
[  317.154938] AMD-Vi: Completion-Wait loop timed out
[  317.277740] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Journal Service.
[  317.406246] AMD-Vi: Completion-Wait loop timed out
[  317.412327] systemd[1]: Stopped Journal Service.
[  317.418327] audit: type=1131 audit(1444478924.053:12): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hos'
[  317.557963] AMD-Vi: Completion-Wait loop timed out
[  317.680740] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped dracut initqueue hook.
[  317.810789] AMD-Vi: Completion-Wait loop timed out
[  317.816941] systemd[1]: Stopped dracut initqueue hook.
[  317.823497] audit: type=1130 audit(1444478924.458:13): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hos'
[  317.846199] audit: type=1131 audit(1444478924.481:14): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hos'
[  317.986348] AMD-Vi: Completion-Wait loop timed out
[  318.109440] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Stopped Kdump Emergency.
[  318.237436] AMD-Vi: Completion-Wait loop timed out
[  318.243885] systemd[1]: Stopped Kdump Emergency.
[  318.250174] audit: type=1130 audit(1444478924.885:15): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=emergency comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?'
[  318.272700] audit: type=1131 audit(1444478924.908:16): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=emergency comm="systemd" exe="/usr/lib/systemd/systemd" hostname=?'
[  318.412409] AMD-Vi: Completion-Wait loop timed out
[  318.535630] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Started Setup Virtual Console.
[  318.666034] AMD-Vi: Completion-Wait loop timed out
[  318.672646] systemd[1]: Started Setup Virtual Console.
[  318.679550] audit: type=1130 audit(1444478925.315:17): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/system'
[  318.829811] AMD-Vi: Completion-Wait loop timed out
[  318.953146] AMD-Vi: Completion-Wait loop timed out
[  OK  ] Listening on Journal Audit Socket.
[  319.082685] AMD-Vi: Completion-Wait loop timed out
[  319.089432] systemd[1]: Listening on Journal Audit Socket.
[  319.097602] systemd[1]: Starting Journal Service...
[  319.221414] AMD-Vi: Completion-Wait loop timed out
[  319.344750] AMD-Vi: Completion-Wait loop timed out
[  319.353940] audit: type=1305 audit(1444478925.990:18): audit_enabled=1 old=1 auid=4294967295 ses=4294967295 subj=kernel res=1
         Starting Journal Service...
[  319.493299] AMD-Vi: Completion-Wait loop timed out
[  319.500917] systemd[1]: Starting Kdump Error Handler...
[  319.625208] AMD-Vi: Completion-Wait loop timed out
[  319.748594] AMD-Vi: Completion-Wait loop timed out
         [  319.756138] systemd[1]: Stopped udev Coldplug all Devices.
Starting Kdump E[  319.770129] audit: type=1131 audit(1444478926.407:19): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/'
Kdump: Executing default action kdump_emergency_shell
Warning: /dev/di[  319.819054] systemd[1]: Stopping udev Coldplug all Devices...
sk/by-uuid/4b765449-4873-42cc-845f-56aba6804aff does not exist

Generating "/run/initramfs/rdsosreport.txt"
 [  319.835881] systemd[1]: Stopped dracut pre-trigger hook.
        Stopping udev Coldplug a[  319.845390] audit: type=1131 audit(1444478926.482:20): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-trigger comm="systemd" '
ll Devices...
[[  319.871278] systemd[1]: Stopping dracut pre-trigger hook...
  OK  ][  319.880140] systemd[1]: Stopping udev Kernel Device Manager...
 Stopped dracut pre-trigger hook[  319.891579] systemd[1]: Started Journal Service.
.
         Stop[  319.899217] audit: type=1130 audit(1444478926.536:21): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd'
ping dracut pre-[  319.925351] audit: type=1131 audit(1444478926.562:22): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd'
trigger hook...
         Stopping udev Kernel D[  319.953461] audit: type=1131 audit(1444478926.590:23): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="sy'
evice Manager...[  319.981113] audit: type=1131 audit(1444478926.618:24): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/sys'

[  OK    320.007339] audit: type=1131 audit(1444478926.644:25): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd'
0m] Started Jour[  320.033648] audit: type=1131 audit(1444478926.670:26): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/system'
nal Service.
[  OK  ] Stopped udev Kernel Device Manager.
[  OK  ] Stopped Create Static Device Nodes in /dev.
         Stopping Create Static Device Nodes in /dev...
[  OK  ] Stopped Create list of required sta...ce nodes for the current kernel.
         Stopping Create list of required st... nodes for the current kernel...
[  OK  ] Stopped dracut pre-udev hook.
         Stopping dracut pre-udev hook...
[  OK  ] Stopped dracut cmdline hook.
         Stopping dracut cmdline hook...
[  OK  ] Closed udev Kernel Socket.
[  OK  ] Closed udev Control Socket.


Entering emergency mode. Exit the shell to continue.
Type "journalctl" to view system logs.
You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or /boot
after mounting them and attach it to a bug report.

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--TB36FDmn/VVEgNH/--
