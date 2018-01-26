From: Baoquan He <bhe@redhat.com>
Subject: Re: Kdump kernel start failed with intel_iommu=on
Date: Fri, 26 Jan 2018 15:50:44 +0800
Message-ID: <20180126075044.GA7859@localhost.localdomain>
References: <31352608-7dce-0e79-dc03-bd329ba4581d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <31352608-7dce-0e79-dc03-bd329ba4581d@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Weilong Chen <chenweilong@huawei.com>
Cc: dwmw2@infradead.org, joro@8bytes.org, iommu@lists.linux-foundation.org, Kefeng Wang <wangkefeng.wang@huawei.com>, qiaonuohan@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 01/23/18 at 06:20pm, Weilong Chen wrote:
> Hi,
> 
> We came across this problem:
> Second kernel hang with intel_iommu=on
> 
> We can reproduce the problem by the following steps:
> 1. start the kernel with intel_iommu=on
> 2. ifconfig eth6 up;ifconfig eth8 up.(eth6 is Intel Corporation 82599ES
> 10-Gigabit and eth8 is Broadcom Limited NetXtreme BCM5719 Gigabit Ethernet)
> 3. echo c > /proc/sysrq-trigger

I saw you set intel_iommu=on in 1st kernel, while intel_iommu=off in
kdump kernel. The intel_iommu=off in kdump kernel caused the failure.

I met the similar issue on amd system with iommu, it also failed with
amd_iommu=off in kdump kernel. Will raise it in a separate thread.

> 
> Some infomation:
> 1. CPU: Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz  "Ivy Bridge-EP" (22 nm)
> Efficient Performance
> 2. # lspci | grep Eth
> 01:00.0 Ethernet controller: Broadcom Limited NetXtreme BCM5719 Gigabit
> Ethernet PCIe (rev 01)
> 01:00.1 Ethernet controller: Broadcom Limited NetXtreme BCM5719 Gigabit
> Ethernet PCIe (rev 01)
> 01:00.2 Ethernet controller: Broadcom Limited NetXtreme BCM5719 Gigabit
> Ethernet PCIe (rev 01)
> 01:00.3 Ethernet controller: Broadcom Limited NetXtreme BCM5719 Gigabit
> Ethernet PCIe (rev 01)
> 82:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+
> Network Connection (rev 01)
> 82:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+
> Network Connection (rev 01)
> 3. # uname -a
> Linux linux-BPxjsg 4.15.0-rc8 #1 SMP Mon Jan 22 20:22:21 CST 2018 x86_64
> x86_64 x86_64 GNU/Linux
> 4.# cat /proc/cmdline
> BOOT_IMAGE=/vmlinuz-4.15.0-rc8 root=/dev/cpsVG/rootfs oops=panic
> net.ifnames=0 biosdevname=0 noexec=on 8250.nr_uarts=8 efi=old_map
> nmi_watchdog=1 intel_iommu=on selinux=0 pci=realloc console=tty0
> console=ttyS0,115200 nohz=off highres=on hpet=enable reserve_kbox_mem=16M
> crashkernel=334M@48M panic=3 crash_kexec_post_notifiers audit=0
> coredump_filter=0x33f elevator=cfq read_ahead_kb=512 nopku LANG=en_US.UTF-8
> 
> 5. kexec load cmd:
> /sbin/kexec  -p --command-line="BOOT_IMAGE=/vmlinuz-4.15.0-rc8 oops=panic
> net.ifnames=0 biosdevname=0 noexec=on 8250.nr_uarts=8 efi=old_map
> nmi_watchdog=1 selinux=0 pci=realloc console=tty0 console=ttyS0,115200
> nohz=off highres=on hpet=enable panic=3 crash_kexec_post_notifiers audit=0
> coredump_filter=0x33f elevator=cfq read_ahead_kb=512 nopku LANG=en_US.UTF-8
> root=UUID="c3765029-27f3-49b4-be20-579a8dc03914" irqpoll reset_devices
> cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10
> rootflags=nofail acpi_no_memhotplug intel_iommu=off disable_cpu_apicid=0
> nr_cpus=24" --initrd=/boot/initramfs-4.15.0-rc8kdump.img
> /boot/vmlinuz-4.15.0-rc8
> 
> 6.dmesg | grep IOMMU
> [    0.000000] DMAR: IOMMU enabled
> [    0.009000] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffe000 IOMMU 0
> [    0.010000] DMAR-IR: IOAPIC id 8 under DRHD base  0xcfffc000 IOMMU 1
> [    0.011000] DMAR-IR: IOAPIC id 9 under DRHD base  0xcfffc000 IOMMU 1
> 
> 7.# dmesg | grep -i dma
> [    0.000000] ACPI: DMAR 0x000000007EF0D000 000118 (v01 INSYDE Romley
> 00000001 ACPI 00000001)
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3996 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 8016 pages used for memmap
> [    0.000000]   DMA32 zone: 513024 pages, LIFO batch:31
> [    0.000000] DMAR: IOMMU enabled
> [    0.001000] DMAR: Host address width 46
> [    0.002000] DMAR: DRHD base: 0x000000fbffe000 flags: 0x0
> [    0.003000] DMAR: dmar0: reg_base_addr fbffe000 ver 1:0 cap
> d2078c106f0466 ecap f020de
> [    0.004000] DMAR: DRHD base: 0x000000cfffc000 flags: 0x1
> [    0.005000] DMAR: dmar1: reg_base_addr cfffc000 ver 1:0 cap
> d2078c106f0466 ecap f020de
> [    0.006000] DMAR: ATSR flags: 0x0
> [    0.007000] DMAR: ATSR flags: 0x0
> [    0.008000] DMAR: RMRR base: 0x0000007e8b5000 end: 0x0000007e8bbfff
> [    0.009000] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffe000 IOMMU 0
> [    0.010000] DMAR-IR: IOAPIC id 8 under DRHD base  0xcfffc000 IOMMU 1
> [    0.011000] DMAR-IR: IOAPIC id 9 under DRHD base  0xcfffc000 IOMMU 1
> [    0.012000] DMAR-IR: HPET id 0 under DRHD base 0xcfffc000
> [    0.013000] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out
> bit.
> [    0.013000] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS
> setting.
> [    0.015000] DMAR-IR: Enabled IRQ remapping in xapic mode
> [    3.995469] pnp 00:04: [dma 0 disabled]
> [    5.049374] DMAR: dmar0: Using Queued invalidation
> [    5.054565] DMAR: dmar1: Using Queued invalidation
> [    5.059749] DMAR: Setting RMRR:
> [    5.065182] DMAR: Setting identity map for device 0000:00:1a.0
> [0x7e8b5000 - 0x7e8bbfff]
> [    5.076264] DMAR: Setting identity map for device 0000:00:1d.0
> [0x7e8b5000 - 0x7e8bbfff]
> [    5.085086] DMAR: Prepare 0-16MiB unity mapping for LPC
> [    5.092965] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 -
> 0xffffff]
> [    5.101014] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [    7.305444] megaraid_sas 0000:02:00.0: 64 bit DMA mask and 32 bit
> consistent mask
> [    7.478850] ata1: SATA max UDMA/133 abar m2048@0x94b24000 port 0x94b24100
> irq 53
> [    7.478851] ata2: SATA max UDMA/133 abar m2048@0x94b24000 port 0x94b24180
> irq 53
> [    7.478853] ata3: SATA max UDMA/133 abar m2048@0x94b24000 port 0x94b24200
> irq 53
> [    7.478855] ata4: SATA max UDMA/133 abar m2048@0x94b24000 port 0x94b24280
> irq 53
> [    7.478857] ata5: SATA max UDMA/133 abar m2048@0x94b24000 port 0x94b24300
> irq 53
> [    7.478858] ata6: SATA max UDMA/133 abar m2048@0x94b24000 port 0x94b24380
> irq 53
> [   20.344328] ioatdma: Intel(R) QuickData Technology Driver 4.00
> [   22.281179] tg3 0000:01:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
> [   22.291362] tg3 0000:01:00.1 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
> [   22.302828] tg3 0000:01:00.2 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
> [   22.314845] tg3 0000:01:00.3 eth4: dma_rwctrl[00000001] dma_mask[64-bit]
> 
> 8. Second kernel's boot log
> 
> [2018-01-23 15:01:15 INFO] linux-BPxjsg login: [  230.074068] sysrq: SysRq :
> Trigger a crash
> [2018-01-23 15:01:15 INFO] [  230.078554] BUG: unable to handle kernel NULL
> pointer dereference at           (null)
> [2018-01-23 15:01:15 INFO] [  230.087080] IP: sysrq_handle_crash+0x12/0x20
> [2018-01-23 15:01:15 INFO] [  230.091723] PGD 8000004fcbe84067 P4D
> 8000004fcbe84067 PUD 4fce77c067 PMD 0
> [2018-01-23 15:01:15 INFO] [  230.099054] Oops: 0002 [#1] SMP PTI
> [2018-01-23 15:01:15 INFO] [  230.102921] Modules linked in: fuse
> ebtable_filter ebtables ip6table_filter ip6_tables ipt_MASQUERADE
> nf_nat_masquerade_ipv4 iptable_nat xt_addrtype iptable_filter xt_conntrack
> br_netfilter vport_vxlan vxlan ip6_udp_tunnel udp_tunnel bridge openvswitch
> nsh stp llc nf_conntrack_ipv6 nf_nat_ipv6 nf_nat_ipv4 nf_defrag_ipv6 nf_nat
> dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio loop iTCO_wdt
> iTCO_vendor_support intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp
> coretemp kvm_intel kvm ixgbe tg3 crct10dif_pclmul crc32_pclmul ptp ses
> enclosure ghash_clmulni_intel pcbc aesni_intel sg mei_me ioatdma crypto_simd
> glue_helper ipmi_si pcspkr mei pps_core mdio shpchp dca cryptd ipmi_devintf
> ipmi_msghandler i2c_i801 i2c_core lpc_ich wmi vhost_net tun vhost tap
> ip_tables ext4 mbcache jbd2 sd_mod isci
> [2018-01-23 15:01:15 INFO] [  230.176985]  libsas ahci libahci
> scsi_transport_sas libata serio_raw megaraid_sas nf_conntrack_ipv4
> nf_defrag_ipv4 nf_conntrack dm_mod vfio_pci irqbypass vfio_virqfd
> vfio_iommu_type1 vfio xt_sctp sctp libcrc32c crc32c_intel
> [2018-01-23 15:01:15 INFO] [  230.197784] CPU: 5 PID: 5194 Comm: bash Not
> tainted 4.15.0-rc8 #1
> [2018-01-23 15:01:15 INFO] [  230.204244] Hardware name: Huawei Technologies
> Co., Ltd. RH2288H V2-24S/BC11SRSG1, BIOS RMIBV516 06/14/2016
> [2018-01-23 15:01:15 INFO] [  230.214641] RIP:
> 0010:sysrq_handle_crash+0x12/0x20
> [2018-01-23 15:01:15 INFO] [  230.219804] RSP: 0018:ffffb8594f8cfe08 EFLAGS:
> 00010246
> [2018-01-23 15:01:15 INFO] [  230.225402] RAX: 000000000000000f RBX:
> ffffffffb8168ac0 RCX: 0000000000000000
> [2018-01-23 15:01:15 INFO] [  230.232909] RDX: 0000000000000000 RSI:
> ffff97dbded56938 RDI: 0000000000000063
> [2018-01-23 15:01:15 INFO] [  230.240418] RBP: 0000000000000063 R08:
> 0000000000000000 R09: 000000000000055d
> [2018-01-23 15:01:15 INFO] [  230.247929] R10: 0000000000000000 R11:
> ffffb8594f8cfb80 R12: 0000000000000000
> [2018-01-23 15:01:15 INFO] [  230.255433] R13: 0000000000000003 R14:
> 0000000000000002 R15: 0000000000000000
> [2018-01-23 15:01:15 INFO] [  230.262942] FS:  00007f5b9c2fb740(0000)
> GS:ffff97dbded40000(0000) knlGS:0000000000000000
> [2018-01-23 15:01:15 INFO] [  230.271704] CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> [2018-01-23 15:01:15 INFO] [  230.277821] CR2: 0000000000000000 CR3:
> 0000004fca950001 CR4: 00000000001606e0
> [2018-01-23 15:01:15 INFO] [  230.285313] Call Trace:
> [2018-01-23 15:01:15 INFO] [  230.288156]  __handle_sysrq+0xec/0x140
> [2018-01-23 15:01:15 INFO] [  230.292295]  write_sysrq_trigger+0x24/0x40
> [2018-01-23 15:01:15 INFO] [  230.296770]  proc_reg_write+0x39/0x70
> [2018-01-23 15:01:15 INFO] [  230.300826]  __vfs_write+0x33/0x170
> [2018-01-23 15:01:15 INFO] [  230.304694]  ? handle_mm_fault+0xc4/0x1d0
> [2018-01-23 15:01:15 INFO] [  230.309096]  ? __do_page_fault+0x273/0x4d0
> [2018-01-23 15:01:15 INFO] [  230.313553]  ? _cond_resched+0x15/0x30
> [2018-01-23 15:01:15 INFO] [  230.317682]  vfs_write+0xad/0x1a0
> [2018-01-23 15:01:15 INFO] [  230.321377]  SyS_write+0x52/0xc0
> [2018-01-23 15:01:15 INFO] [  230.324978]
> entry_SYSCALL_64_fastpath+0x20/0x83
> [2018-01-23 15:01:15 INFO] [  230.329972] RIP: 0033:0x7f5b9b9e5c60
> [2018-01-23 15:01:15 INFO] [  230.333921] RSP: 002b:00007ffc8e60e588 EFLAGS:
> 00000246
> [2018-01-23 15:01:15 INFO] [  230.333923] Code: cc ff 0f 1f 44 00 00 0f ff
> c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 c7 05 7d 3e
> bd 00 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 0f 1f
> 44 00 00 53 8d
> [2018-01-23 15:01:15 INFO] [  230.359372] RIP: sysrq_handle_crash+0x12/0x20
> RSP: ffffb8594f8cfe08
> [2018-01-23 15:01:15 INFO] [  230.366003] CR2: 0000000000000000
> [2018-01-23 15:01:15 INFO] [  230.369715] ---[ end trace 6ef1213676a70a14
> ]---
> [2018-01-23 15:01:24 INFO] [  238.980322] Kernel panic - not syncing: Fatal
> exception
> [2018-01-23 15:01:24 INFO] [  238.988846] Kernel Offset: 0x36000000 from
> 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [2018-01-23 15:01:33 INFO] [    0.000000] Linux version 4.15.0-rc8
> (root@linux-BPxjsg) (gcc version 4.8.3 20140911 (EulerOS 4.8.3-10.h1) (GCC))
> #1 SMP Mon Jan 22 20:22:21 CST 2018
> [2018-01-23 15:01:34 INFO] [    0.000000] Command line:
> BOOT_IMAGE=/vmlinuz-4.15.0-rc8 oops=panic net.ifnames=0 biosdevname=0
> noexec=on 8250.nr_uarts=8 efi=old_map nmi_watchdog=1 selinux=0 pci=realloc
> console=tty0 console=ttyS0,115200 nohz=off highres=on hpet=enable panic=3
> crash_kexec_post_notifiers audit=0 coredump_filter=0x33f elevator=cfq
> read_ahead_kb=512 nopku LANG=en_US.UTF-8
> root=UUID="c3765029-27f3-49b4-be20-579a8dc03914" irqpoll reset_devices
> cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10
> rootflags=nofail acpi_no_memhotplug intel_iommu=off disable_cpu_apicid=0
> nr_cpus=24 elfcorehdr=390528K
> [2018-01-23 15:01:34 INFO] [    0.000000] x86/fpu: Supporting XSAVE feature
> 0x001: 'x87 floating point registers'
> [2018-01-23 15:01:34 INFO] [    0.000000] x86/fpu: Supporting XSAVE feature
> 0x002: 'SSE registers'
> [2018-01-23 15:01:34 INFO] [    0.000000] x86/fpu: Supporting XSAVE feature
> 0x004: 'AVX registers'
> [2018-01-23 15:01:34 INFO] [    0.000000] x86/fpu: xstate_offset[2]: 576,
> xstate_sizes[2]:  256
> [2018-01-23 15:01:34 INFO] [    0.000000] x86/fpu: Enabled xstate features
> 0x7, context size is 832 bytes, using 'standard' format.
> [2018-01-23 15:01:34 INFO] [    0.000000] e820: BIOS-provided physical RAM
> map:
> [2018-01-23 15:01:34 INFO] [    0.000000] BIOS-e820: [mem
> 0x0000000000001000-0x000000000009cfff] usable
> [2018-01-23 15:01:34 INFO] [    0.000000] BIOS-e820: [mem
> 0x0000000003000000-0x0000000017d5ffff] usable
> [2018-01-23 15:01:34 INFO] [    0.000000] BIOS-e820: [mem
> 0x000000007e8ff000-0x000000007eefefff] ACPI NVS
> [2018-01-23 15:01:34 INFO] [    0.000000] BIOS-e820: [mem
> 0x000000007eeff000-0x000000007effefff] ACPI data
> [2018-01-23 15:01:34 INFO] [    0.000000] NX (Execute Disable) protection:
> active
> [2018-01-23 15:01:34 INFO] [    0.000000] random: fast init done
> [2018-01-23 15:01:34 INFO] [    0.000000] SMBIOS 2.7 present.
> [2018-01-23 15:01:34 INFO] [    0.000000] DMI: Huawei Technologies Co., Ltd.
> RH2288H V2-24S/BC11SRSG1, BIOS RMIBV516 06/14/2016
> [2018-01-23 15:01:34 INFO] [    0.000000] e820: last_pfn = 0x17d60
> max_arch_pfn = 0x400000000
> [2018-01-23 15:01:34 INFO] [    0.000000] x86/PAT: Configuration [0-7]: WB
> WC  UC- UC  WB  WP  UC- WT
> [2018-01-23 15:01:34 INFO] [    0.000000] found SMP MP-table at [mem
> 0x000fe1b0-0x000fe1bf] mapped at [        (ptrval)]
> [2018-01-23 15:01:34 INFO] [    0.000000] Using GB pages for direct mapping
> [2018-01-23 15:01:34 INFO] [    0.000000] RAMDISK: [mem
> 0x13d2f000-0x15ffffff]
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: Early table checksum
> verification disabled
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: RSDP 0x00000000000FE020
> 000024 (v02 INSYDE)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: XSDT 0x000000007EFFE170
> 0000BC (v01 INSYDE Romley   00000001      01000013)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: FACP 0x000000007EFFB000
> 0000F4 (v04 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: DSDT 0x000000007EFE9000
> 00DEE2 (v01 INSYDE Romley   00000000 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: FACS 0x000000007EDCA000
> 000040
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: FACS 0x000000007EDCA000
> 000040
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: SPMI 0x000000007EFFD000
> 000040 (v05 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: BOOT 0x000000007EFFC000
> 000028 (v01 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: APIC 0x000000007EFF9000
> 000BB6 (v03 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: MCFG 0x000000007EFF8000
> 00003C (v01 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: SLIC 0x000000007EFF7000
> 000176 (v01 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: SRAT 0x000000007EFE7000
> 001340 (v02 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: SLIT 0x000000007EFE6000
> 00003C (v01 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: BDAT 0x000000007EFE5000
> 000030 (v01 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: PRAD 0x000000007EFE4000
> 0000BC (v02 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: MSDM 0x000000007EFE3000
> 000055 (v03 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: SSDT 0x000000007EF0F000
> 0D3050 (v02 INSYDE Romley   00004000 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: HPET 0x000000007EFFA000
> 000038 (v01 INSYDE Romley   00000001 ACPI 00040000)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: WDAT 0x000000007EF0E000
> 000194 (v01 INSYDE INSYDE   00000001 MSFT 01000013)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: DMAR 0x000000007EF0D000
> 000118 (v01 INSYDE Romley   00000001 ACPI 00000001)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: HEST 0x000000007EF0C000
> 0000A8 (v01 INSYDE Romley   00000001 ?    00000001)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: ERST 0x000000007EF0B000
> 000230 (v01 INSYDE Romley   00000001 ?    00000001)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: BERT 0x000000007EF0A000
> 000030 (v01 INSYDE Romley   00000001 ?    00000001)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: EINJ 0x000000007EF09000
> 000130 (v01 INSYDE Romley   00000001 ?    00000001)
> [2018-01-23 15:01:34 INFO] [    0.000000] NUMA turned off
> [2018-01-23 15:01:34 INFO] [    0.000000] Faking a node at [mem
> 0x0000000000000000-0x0000000017d5ffff]
> [2018-01-23 15:01:34 INFO] [    0.000000] NODE_DATA(0) allocated [mem
> 0x17d35000-0x17d5ffff]
> [2018-01-23 15:01:34 INFO] [    0.000000] tsc: Fast TSC calibration using
> PIT
> [2018-01-23 15:01:34 INFO] [    0.000000] Zone ranges:
> [2018-01-23 15:01:34 INFO] [    0.000000]   DMA      [mem
> 0x0000000000001000-0x0000000000ffffff]
> [2018-01-23 15:01:34 INFO] [    0.000000]   DMA32    [mem
> 0x0000000001000000-0x0000000017d5ffff]
> [2018-01-23 15:01:34 INFO] [    0.000000]   Normal   empty
> [2018-01-23 15:01:34 INFO] [    0.000000]   Device   empty
> [2018-01-23 15:01:34 INFO] [    0.000000] Movable zone start for each node
> [2018-01-23 15:01:34 INFO] [    0.000000] Early memory node ranges
> [2018-01-23 15:01:34 INFO] [    0.000000]   node   0: [mem
> 0x0000000000001000-0x000000000009cfff]
> [2018-01-23 15:01:34 INFO] [    0.000000]   node   0: [mem
> 0x0000000003000000-0x0000000017d5ffff]
> [2018-01-23 15:01:34 INFO] [    0.000000] Initmem setup node 0 [mem
> 0x0000000000001000-0x0000000017d5ffff]
> [2018-01-23 15:01:34 INFO] [    0.000000] Reserved but unavailable: 100
> pages
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: PM-Timer IO Port: 0x408
> [2018-01-23 15:01:34 INFO] [    0.000000] APIC: Disabling requested cpu.
> Processor 0/0x0 ignored.
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: X2APIC_NMI (uid[0xffffffff]
> high edge lint[0x1])
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff]
> high edge lint[0x1])
> [2018-01-23 15:01:34 INFO] [    0.000000] IOAPIC[0]: apic_id 8, version 32,
> address 0xfec00000, GSI 0-23
> [2018-01-23 15:01:34 INFO] [    0.000000] IOAPIC[1]: apic_id 9, version 32,
> address 0xfec01000, GSI 24-47
> [2018-01-23 15:01:34 INFO] [    0.000000] IOAPIC[2]: apic_id 10, version 32,
> address 0xfec40000, GSI 48-71
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0
> global_irq 2 dfl dfl)
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9
> global_irq 9 high level)
> [2018-01-23 15:01:34 INFO] [    0.000000] Using ACPI (MADT) for SMP
> configuration information
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: HPET id: 0x8086a701 base:
> 0xfed00000
> [2018-01-23 15:01:34 INFO] [    0.000000] smpboot: 144 Processors exceeds
> NR_CPUS limit of 24
> [2018-01-23 15:01:34 INFO] [    0.000000] smpboot: Allowing 24 CPUs, 1
> hotplug CPUs
> [2018-01-23 15:01:34 INFO] [    0.000000] PM: Registered nosave memory: [mem
> 0x00000000-0x00000fff]
> [2018-01-23 15:01:34 INFO] [    0.000000] PM: Registered nosave memory: [mem
> 0x0009d000-0x02ffffff]
> [2018-01-23 15:01:34 INFO] [    0.000000] e820: [mem 0x7efff000-0xffffffff]
> available for PCI devices
> [2018-01-23 15:01:34 INFO] [    0.000000] Booting paravirtualized kernel on
> bare hardware
> [2018-01-23 15:01:34 INFO] [    0.000000] clocksource: refined-jiffies:
> mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [2018-01-23 15:01:34 INFO] [    0.000000] setup_percpu: NR_CPUS:8192
> nr_cpumask_bits:24 nr_cpu_ids:24 nr_node_ids:1
> [2018-01-23 15:01:34 INFO] [    0.000000] percpu: Embedded 45 pages/cpu @
> (ptrval) s145368 r8192 d30760 u262144
> [2018-01-23 15:01:34 INFO] [    0.000000] Built 1 zonelists, mobility
> grouping on.  Total pages: 84142
> [2018-01-23 15:01:34 INFO] [    0.000000] Policy zone: DMA32
> [2018-01-23 15:01:34 INFO] [    0.000000] Kernel command line:
> BOOT_IMAGE=/vmlinuz-4.15.0-rc8 oops=panic net.ifnames=0 biosdevname=0
> noexec=on 8250.nr_uarts=8 efi=old_map nmi_watchdog=1 selinux=0 pci=realloc
> console=tty0 console=ttyS0,115200 nohz=off highres=on hpet=enable panic=3
> crash_kexec_post_notifiers audit=0 coredump_filter=0x33f elevator=cfq
> read_ahead_kb=512 nopku LANG=en_US.UTF-8
> root=UUID="c3765029-27f3-49b4-be20-579a8dc03914" irqpoll reset_devices
> cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10
> rootflags=nofail acpi_no_memhotplug intel_iommu=off disable_cpu_apicid=0
> nr_cpus=24 elfcorehdr=390528K
> [2018-01-23 15:01:34 INFO] [    0.000000] audit: disabled (until reboot)
> [2018-01-23 15:01:34 INFO] [    0.000000] x86: 'nopku' specified, disabling
> Memory Protection Keys
> [2018-01-23 15:01:34 INFO] [    0.000000] Misrouted IRQ fixup and polling
> support enabled
> [2018-01-23 15:01:34 INFO] [    0.000000] This may significantly impact
> system performance
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR: IOMMU disabled
> [2018-01-23 15:01:34 INFO] [    0.000000] Memory: 268532K/342000K available
> (10252K kernel code, 2189K rwdata, 3488K rodata, 2256K init, 3068K bss,
> 73468K reserved, 0K cma-reserved)
> [2018-01-23 15:01:34 INFO] [    0.000000] SLUB: HWalign=64, Order=0-3,
> MinObjects=0, CPUs=24, Nodes=1
> [2018-01-23 15:01:34 INFO] [    0.000000] Kernel/User page tables isolation:
> enabled
> [2018-01-23 15:01:34 INFO] [    0.000000] ftrace: allocating 32500 entries
> in 127 pages
> [2018-01-23 15:01:34 INFO] [    0.000000] Hierarchical RCU implementation.
> [2018-01-23 15:01:34 INFO] [    0.000000]     RCU restricting CPUs from
> NR_CPUS=8192 to nr_cpu_ids=24.
> [2018-01-23 15:01:34 INFO] [    0.000000] RCU: Adjusting geometry for
> rcu_fanout_leaf=16, nr_cpu_ids=24
> [2018-01-23 15:01:34 INFO] [    0.000000] NR_IRQS: 524544, nr_irqs: 1432,
> preallocated irqs: 16
> [2018-01-23 15:01:34 INFO] [    0.000000]     Offload RCU callbacks from
> CPUs: .
> [2018-01-23 15:01:34 INFO] [    0.000000] Spurious LAPIC timer interrupt on
> cpu 0
> [2018-01-23 15:01:34 INFO] [    0.000000] Console: colour VGA+ 80x25
> [2018-01-23 15:01:34 INFO] [    0.000000] console [tty0] enabled
> [2018-01-23 15:01:34 INFO] [    0.000000] console [ttyS0] enabled
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: Core revision 20170831
> [2018-01-23 15:01:34 INFO] [    0.000000] ACPI: 2 ACPI AML tables
> successfully acquired and loaded
> [2018-01-23 15:01:34 INFO] [    0.000000] clocksource: hpet: mask:
> 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> [2018-01-23 15:01:34 INFO] [    0.000000] APIC: Switch to symmetric I/O mode
> setup
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR: Host address width 46
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR: DRHD base: 0x000000fbffe000
> flags: 0x0
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR: dmar0: reg_base_addr
> fbffe000 ver 1:0 cap d2078c106f0466 ecap f020de
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR: DRHD base: 0x000000cfffc000
> flags: 0x1
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR: dmar1: reg_base_addr
> cfffc000 ver 1:0 cap d2078c106f0466 ecap f020de
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR: ATSR flags: 0x0
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR: ATSR flags: 0x0
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR: RMRR base: 0x0000007e8b5000
> end: 0x0000007e8bbfff
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR-IR: IOAPIC id 10 under DRHD
> base  0xfbffe000 IOMMU 0
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR-IR: IOAPIC id 8 under DRHD
> base  0xcfffc000 IOMMU 1
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR-IR: IOAPIC id 9 under DRHD
> base  0xcfffc000 IOMMU 1
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR-IR: HPET id 0 under DRHD base
> 0xcfffc000
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR-IR: x2apic is disabled
> because BIOS sets x2apic opt out bit.
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR-IR: Use
> 'intremap=no_x2apic_optout' to override the BIOS setting.
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR-IR: Copied IR table for dmar0
> from previous kernel
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR-IR: Copied IR table for dmar1
> from previous kernel
> [2018-01-23 15:01:34 INFO] [    0.000000] DMAR-IR: Enabled IRQ remapping in
> xapic mode
> [2018-01-23 15:01:34 INFO] [    0.000000] x2apic: IRQ remapping doesn't
> support X2APIC mode
> [2018-01-23 15:01:34 INFO] [    0.000000] Switched APIC routing to physical
> flat.
> [2018-01-23 15:01:34 INFO] [    0.000000] ..TIMER: vector=0x30 apic1=0
> pin1=2 apic2=-1 pin2=-1
> [2018-01-23 15:01:34 INFO] [    0.005000] tsc: Fast TSC calibration using
> PIT
> [2018-01-23 15:01:34 INFO] [    0.006000] tsc: Detected 2100.151 MHz
> processor
> [2018-01-23 15:01:34 INFO] [    0.007000] Calibrating delay loop (skipped),
> value calculated using timer frequency.. 4200.30 BogoMIPS (lpj=2100151)
> [2018-01-23 15:01:34 INFO] [    0.008024] pid_max: default: 32768 minimum:
> 301
> [2018-01-23 15:01:34 INFO] [    0.009067] Security Framework initialized
> [2018-01-23 15:01:34 INFO] [    0.010027] SELinux:  Disabled at boot.
> [2018-01-23 15:01:34 INFO] [    0.011168] Dentry cache hash table entries:
> 65536 (order: 7, 524288 bytes)
> [2018-01-23 15:01:34 INFO] [    0.012084] Inode-cache hash table entries:
> 32768 (order: 6, 262144 bytes)
> [2018-01-23 15:01:34 INFO] [    0.013039] Mount-cache hash table entries:
> 1024 (order: 1, 8192 bytes)
> [2018-01-23 15:01:35 INFO] [    0.014029] Mountpoint-cache hash table
> entries: 1024 (order: 1, 8192 bytes)
> [2018-01-23 15:01:35 INFO] [    0.016143] Disabling memory control group
> subsystem
> [2018-01-23 15:01:35 INFO] [    0.017065] CPU: Physical Processor ID: 0
> [2018-01-23 15:01:35 INFO] [    0.018023] CPU: Processor Core ID: 5
> [2018-01-23 15:01:35 INFO] [    0.019037] ENERGY_PERF_BIAS: Set to 'normal',
> was 'performance'
> [2018-01-23 15:01:35 INFO] [    0.020026] ENERGY_PERF_BIAS: View and update
> with x86_energy_perf_policy(8)
> [2018-01-23 15:01:35 INFO] [    0.021031] process: using mwait in idle
> threads
> [2018-01-23 15:01:35 INFO] [    0.022025] Last level iTLB entries: 4KB 512,
> 2MB 8, 4MB 8
> [2018-01-23 15:01:35 INFO] [    0.023023] Last level dTLB entries: 4KB 512,
> 2MB 0, 4MB 0, 1GB 4
> [2018-01-23 15:01:35 INFO] [    0.024031] Spectre V2 mitigation: Vulnerable:
> Minimal generic ASM retpoline
> [2018-01-23 15:01:35 INFO] [    0.025145] Freeing SMP alternatives memory:
> 28K
> [2018-01-23 15:01:35 INFO] [    0.027536] smpboot: CPU0: Intel(R) Xeon(R)
> CPU E5-2620 v2 @ 2.10GHz (family: 0x6, model: 0x3e, stepping: 0x4)
> [2018-01-23 15:01:35 INFO] [    0.028101] Performance Events: PEBS fmt1+,
> IvyBridge events, 16-deep LBR, full-width counters, Broken BIOS detected,
> complain to your hardware vendor.
> [2018-01-23 15:01:35 INFO] [    0.029003] [Firmware Bug]: the BIOS has
> corrupted hw-PMU resources (MSR 38d is b0)
> [2018-01-23 15:01:35 INFO] [    0.030004] Intel PMU driver.
> [2018-01-23 15:01:35 INFO] [    0.031007] ... version:                3
> [2018-01-23 15:01:35 INFO] [    0.032004] ... bit width:              48
> [2018-01-23 15:01:35 INFO] [    0.033001] ... generic registers:      4
> [2018-01-23 15:01:35 INFO] [    0.034001] ... value mask: 0000ffffffffffff
> [2018-01-23 15:01:35 INFO] [    0.035001] ... max period: 00007fffffffffff
> [2018-01-23 15:01:35 INFO] [    0.036001] ... fixed-purpose events:   3
> [2018-01-23 15:01:35 INFO] [    0.037001] ... event mask: 000000070000000f
> [2018-01-23 15:01:35 INFO] [    0.038060] Hierarchical SRCU implementation.
> [2018-01-23 15:01:35 INFO] [    0.041600] NMI watchdog: Enabled. Permanently
> consumes one hw-PMU counter.
> [2018-01-23 15:01:35 INFO] [    0.042024] smp: Bringing up secondary CPUs
> ...
> [2018-01-23 15:01:35 INFO] [    0.043094] x86: Booting SMP configuration:
> [2018-01-23 15:01:35 INFO] [    0.044008] .... node  #0, CPUs:        #1
> #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20
> #21 #22
> [2018-01-23 15:01:35 INFO] [    0.130057] smp: Brought up 1 node, 23 CPUs
> [2018-01-23 15:01:35 INFO] [    0.132002] smpboot: Max logical packages: 2
> [2018-01-23 15:01:35 INFO] [    0.133002] smpboot: Total of 23 processors
> activated (96677.50 BogoMIPS)
> [2018-01-23 15:01:35 INFO] [    0.135538] devtmpfs: initialized
> [2018-01-23 15:01:35 INFO] [    0.136061] x86/mm: Memory block size: 128MB
> [2018-01-23 15:01:35 INFO] [    0.137268] evm: security.selinux
> [2018-01-23 15:01:35 INFO] [    0.138002] evm: security.ima
> [2018-01-23 15:01:35 INFO] [    0.139004] evm: security.capability
> [2018-01-23 15:01:35 INFO] [    0.140150] PM: Registering ACPI NVS region
> [mem 0x7e8ff000-0x7eefefff] (6291456 bytes)
> [2018-01-23 15:01:35 INFO] [    0.141185] clocksource: jiffies: mask:
> 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [2018-01-23 15:01:35 INFO] [    0.142038] futex hash table entries: 8192
> (order: 7, 524288 bytes)
> [2018-01-23 15:01:35 INFO] [    0.143226] pinctrl core: initialized pinctrl
> subsystem
> [2018-01-23 15:01:35 INFO] [    0.144150] NET: Registered protocol family 16
> [2018-01-23 15:01:35 INFO] [    0.145300] cpuidle: using governor menu
> [2018-01-23 15:01:35 INFO] [    0.149173] Simple Boot Flag at 0x44 set to
> 0x1
> [2018-01-23 15:01:35 INFO] [    0.154031] ACPI FADT declares the system
> doesn't support PCIe ASPM, so disable it
> [2018-01-23 15:01:35 INFO] [    0.162003] ACPI: bus type PCI registered
> [2018-01-23 15:01:35 INFO] [    0.167002] acpiphp: ACPI Hot Plug PCI
> Controller Driver version: 0.5
> [2018-01-23 15:01:35 INFO] [    0.174084] PCI: MMCONFIG for domain 0000 [bus
> 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [2018-01-23 15:01:35 INFO] [    0.184019] PCI: not using MMCONFIG
> [2018-01-23 15:01:35 INFO] [    0.188004] PCI: Using configuration type 1
> for base access
> [2018-01-23 15:01:35 INFO] [    0.194152] core: PMU erratum BJ122, BV98,
> HSD29 worked around, HT is on
> [2018-01-23 15:01:35 INFO] [    0.203049] HugeTLB registered 1.00 GiB page
> size, pre-allocated 0 pages
> [2018-01-23 15:01:35 INFO] [    0.210006] HugeTLB registered 2.00 MiB page
> size, pre-allocated 0 pages
> [2018-01-23 15:01:35 INFO] [    0.217132] ACPI: Added _OSI(Module Device)
> [2018-01-23 15:01:35 INFO] [    0.222003] ACPI: Added _OSI(Processor Device)
> [2018-01-23 15:01:35 INFO] [    0.227002] ACPI: Added _OSI(3.0 _SCP
> Extensions)
> [2018-01-23 15:01:35 INFO] [    0.232001] ACPI: Added _OSI(Processor
> Aggregator Device)
> [2018-01-23 15:01:35 INFO] [    0.385903] ACPI: Interpreter enabled
> [2018-01-23 15:01:35 INFO] [    0.390027] ACPI: (supports S0 S4 S5)
> [2018-01-23 15:01:35 INFO] [    0.394002] ACPI: Using IOAPIC for interrupt
> routing
> [2018-01-23 15:01:35 INFO] [    0.400072] PCI: MMCONFIG for domain 0000 [bus
> 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [2018-01-23 15:01:35 INFO] [    0.410528] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.420004] ACPI Error: Method parse/execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.430005] ACPI Error: Method execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:35 INFO] [    0.440160] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.450003] ACPI Error: Method parse/execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.460004] ACPI Error: Method execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:35 INFO] [    0.470086] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.480003] ACPI Error: Method parse/execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.490003] ACPI Error: Method execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:35 INFO] [    0.500084] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.510003] ACPI Error: Method parse/execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.520003] ACPI Error: Method execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:35 INFO] [    0.530428] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.540003] ACPI Error: Method parse/execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.551004] ACPI Error: Method execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:35 INFO] [    0.560098] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.570003] ACPI Error: Method parse/execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.581004] ACPI Error: Method execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:35 INFO] [    0.590032] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.600003] ACPI Error: Method parse/execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.611003] ACPI Error: Method execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:35 INFO] [    0.620033] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.630003] ACPI Error: Method parse/execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.640003] ACPI Error: Method execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:35 INFO] [    0.650424] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.660004] ACPI Error: Method parse/execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.671004] ACPI Error: Method execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:35 INFO] [    0.681098] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:35 INFO] [    0.690003] ACPI Error: Method parse/execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:35 INFO] [    0.701004] ACPI Error: Method execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.711033] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.720003] ACPI Error: Method parse/execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    0.731003] ACPI Error: Method execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.740032] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.750003] ACPI Error: Method parse/execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    0.761004] ACPI Error: Method execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.770424] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.780003] ACPI Error: Method parse/execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    0.791005] ACPI Error: Method execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.801097] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.810003] ACPI Error: Method parse/execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    0.821004] ACPI Error: Method execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.831033] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.840002] ACPI Error: Method parse/execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    0.851004] ACPI Error: Method execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.861033] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.870003] ACPI Error: Method parse/execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    0.881003] ACPI Error: Method execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.891424] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.901004] ACPI Error: Method parse/execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    0.911004] ACPI Error: Method execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.921098] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.931003] ACPI Error: Method parse/execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    0.941004] ACPI Error: Method execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.951032] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.961003] ACPI Error: Method parse/execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    0.971003] ACPI Error: Method execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    0.981033] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    0.990003] ACPI Error: Method parse/execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    1.001003] ACPI Error: Method execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    1.011126] [Firmware Info]: PCI: MMCONFIG at
> [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> [2018-01-23 15:01:36 INFO] [    1.022002] PCI: not using MMCONFIG
> [2018-01-23 15:01:36 INFO] [    1.026037] HEST: Table parsing has been
> initialized.
> [2018-01-23 15:01:36 INFO] [    1.031005] PCI: Using host bridge windows
> from ACPI; if necessary, use "pci=nocrs" and report a bug
> [2018-01-23 15:01:36 INFO] [    1.041316] ACPI: Enabled 7 GPEs in block 00
> to 3F
> [2018-01-23 15:01:36 INFO] [    1.048254] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    1.067005] ACPI Error: Method parse/execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    1.078005] ACPI Error: Method execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    1.090583] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    1.100004] ACPI Error: Method parse/execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    1.110004] ACPI Error: Method execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    1.120933] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    1.131004] ACPI Error: Method parse/execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    1.141004] ACPI Error: Method execution
> failed _SB.PCI2.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    1.151942] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:36 INFO] [    1.162004] ACPI Error: Method parse/execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:36 INFO] [    1.172005] ACPI Error: Method execution
> failed _SB.PCI3.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:36 INFO] [    1.194374] ACPI: PCI Root Bridge [PCI0]
> (domain 0000 [bus 00-7e])
> [2018-01-23 15:01:36 INFO] [    1.201010] acpi PNP0A08:00: _OSC: OS supports
> [ASPM ClockPM Segments MSI]
> [2018-01-23 15:01:36 INFO] [    1.208091] acpi PNP0A08:00: _OSC: not
> requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> [2018-01-23 15:01:36 INFO] [    1.219020] acpi PNP0A08:00: fail to add
> MMCONFIG information, can't access extended PCI configuration space under
> this bridge.
> [2018-01-23 15:01:36 INFO] [    1.231522] PCI host bridge to bus 0000:00
> [2018-01-23 15:01:36 INFO] [    1.236005] pci_bus 0000:00: root bus resource
> [io  0x0000-0x0cf7 window]
> [2018-01-23 15:01:36 INFO] [    1.243002] pci_bus 0000:00: root bus resource
> [io  0x1000-0xbfff window]
> [2018-01-23 15:01:36 INFO] [    1.250002] pci_bus 0000:00: root bus resource
> [mem 0x000a0000-0x000bffff window]
> [2018-01-23 15:01:36 INFO] [    1.259002] pci_bus 0000:00: root bus resource
> [mem 0x90000000-0xcfffefff window]
> [2018-01-23 15:01:36 INFO] [    1.267003] pci_bus 0000:00: root bus resource
> [bus 00-7e]
> [2018-01-23 15:01:36 INFO] [    1.278166] pci 0000:00:01.0: PCI bridge to
> [bus 01]
> [2018-01-23 15:01:36 INFO] [    1.283059] pci 0000:00:02.0: PCI bridge to
> [bus 03]
> [2018-01-23 15:01:36 INFO] [    1.289181] pci 0000:00:02.2: PCI bridge to
> [bus 02]
> [2018-01-23 15:01:36 INFO] [    1.294425] pci 0000:00:11.0: PCI bridge to
> [bus 04]
> [2018-01-23 15:01:36 INFO] [    1.300067] pci 0000:00:1c.0: PCI bridge to
> [bus 05]
> [2018-01-23 15:01:36 INFO] [    1.305059] pci 0000:00:1c.2: PCI bridge to
> [bus 06]
> [2018-01-23 15:01:36 INFO] [    1.314021] pci 0000:00:1c.3: PCI bridge to
> [bus 07]
> [2018-01-23 15:01:36 INFO] [    1.319090] pci 0000:00:1e.0: PCI bridge to
> [bus 08] (subtractive decode)
> [2018-01-23 15:01:36 INFO] [    1.326402] ACPI: PCI Root Bridge [UNC0]
> (domain 0000 [bus 7f])
> [2018-01-23 15:01:36 INFO] [    1.333005] acpi PNP0A03:00: _OSC: OS supports
> [ASPM ClockPM Segments MSI]
> [2018-01-23 15:01:36 INFO] [    1.340005] acpi PNP0A03:00: _OSC failed
> (AE_NOT_FOUND); disabling ASPM
> [2018-01-23 15:01:36 INFO] [    1.347011] acpi PNP0A03:00: fail to add
> MMCONFIG information, can't access extended PCI configuration space under
> this bridge.
> [2018-01-23 15:01:36 INFO] [    1.360070] PCI host bridge to bus 0000:7f
> [2018-01-23 15:01:36 INFO] [    1.364003] pci_bus 0000:7f: root bus resource
> [bus 7f]
> [2018-01-23 15:01:36 INFO] [    1.372322] ACPI: PCI Root Bridge [PCI1]
> (domain 0000 [bus 80-fe])
> [2018-01-23 15:01:36 INFO] [    1.379005] acpi PNP0A08:01: _OSC: OS supports
> [ASPM ClockPM Segments MSI]
> [2018-01-23 15:01:36 INFO] [    1.386053] acpi PNP0A08:01: _OSC: not
> requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> [2018-01-23 15:01:36 INFO] [    1.397009] acpi PNP0A08:01: fail to add
> MMCONFIG information, can't access extended PCI configuration space under
> this bridge.
> [2018-01-23 15:01:36 INFO] [    1.409194] PCI host bridge to bus 0000:80
> [2018-01-23 15:01:36 INFO] [    1.414004] pci_bus 0000:80: root bus resource
> [io  0x0000-0x0cf7 window]
> [2018-01-23 15:01:36 INFO] [    1.421002] pci_bus 0000:80: root bus resource
> [io  0xc000-0xffff window]
> [2018-01-23 15:01:36 INFO] [    1.428002] pci_bus 0000:80: root bus resource
> [mem 0x000a0000-0x000bffff window]
> [2018-01-23 15:01:36 INFO] [    1.436002] pci_bus 0000:80: root bus resource
> [mem 0xd0000000-0xfbffffff window]
> [2018-01-23 15:01:36 INFO] [    1.444004] pci_bus 0000:80: root bus resource
> [bus 80-fe]
> [2018-01-23 15:01:36 INFO] [    1.451720] pci 0000:80:02.0: PCI bridge to
> [bus 81]
> [2018-01-23 15:01:36 INFO] [    1.457277] pci 0000:80:02.2: PCI bridge to
> [bus 82]
> [2018-01-23 15:01:36 INFO] [    1.463113] ACPI: PCI Root Bridge [UNC1]
> (domain 0000 [bus ff])
> [2018-01-23 15:01:36 INFO] [    1.469004] acpi PNP0A03:01: _OSC: OS supports
> [ASPM ClockPM Segments MSI]
> [2018-01-23 15:01:36 INFO] [    1.477005] acpi PNP0A03:01: _OSC failed
> (AE_NOT_FOUND); disabling ASPM
> [2018-01-23 15:01:36 INFO] [    1.484011] acpi PNP0A03:01: fail to add
> MMCONFIG information, can't access extended PCI configuration space under
> this bridge.
> [2018-01-23 15:01:36 INFO] [    1.496064] PCI host bridge to bus 0000:ff
> [2018-01-23 15:01:36 INFO] [    1.500003] pci_bus 0000:ff: root bus resource
> [bus ff]
> [2018-01-23 15:01:36 INFO] [    1.508259] APIC: Disabling requested cpu.
> Processor 144/0x0 ignored.
> [2018-01-23 15:01:36 INFO] [    1.515003] ACPI: Unable to map lapic to
> logical cpu number
> [2018-01-23 15:01:36 INFO] [    1.525509] ACPI: PCI Interrupt Link [LNKA]
> (IRQs 1 *3 4 5 6 7 10 11 12 14 15), disabled.
> [2018-01-23 15:01:36 INFO] [    1.535054] ACPI: PCI Interrupt Link [LNKB]
> (IRQs 1 3 4 *5 6 7 10 11 12 14 15), disabled.
> [2018-01-23 15:01:36 INFO] [    1.544052] ACPI: PCI Interrupt Link [LNKC]
> (IRQs 1 3 4 5 *6 7 10 11 12 14 15), disabled.
> [2018-01-23 15:01:36 INFO] [    1.553050] ACPI: PCI Interrupt Link [LNKD]
> (IRQs 1 3 4 5 6 *7 10 11 12 14 15), disabled.
> [2018-01-23 15:01:36 INFO] [    1.562051] ACPI: PCI Interrupt Link [LNKE]
> (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [2018-01-23 15:01:36 INFO] [    1.571050] ACPI: PCI Interrupt Link [LNKF]
> (IRQs 1 3 4 5 6 7 *10 11 12 14 15), disabled.
> [2018-01-23 15:01:36 INFO] [    1.580050] ACPI: PCI Interrupt Link [LNKG]
> (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [2018-01-23 15:01:36 INFO] [    1.589051] ACPI: PCI Interrupt Link [LNKH]
> (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9, disabled.
> [2018-01-23 15:01:36 INFO] [    1.598178] pci 0000:07:00.0: vgaarb: setting
> as boot VGA device
> [2018-01-23 15:01:36 INFO] [    1.599000] pci 0000:07:00.0: vgaarb: VGA
> device added: decodes=io+mem,owns=io+mem,locks=none
> [2018-01-23 15:01:36 INFO] [    1.614019] pci 0000:07:00.0: vgaarb: bridge
> control possible
> [2018-01-23 15:01:36 INFO] [    1.620002] vgaarb: loaded
> [2018-01-23 15:01:36 INFO] [    1.623135] SCSI subsystem initialized
> [2018-01-23 15:01:36 INFO] [    1.628026] ACPI: bus type USB registered
> [2018-01-23 15:01:36 INFO] [    1.632020] usbcore: registered new interface
> driver usbfs
> [2018-01-23 15:01:36 INFO] [    1.638012] usbcore: registered new interface
> driver hub
> [2018-01-23 15:01:36 INFO] [    1.644083] usbcore: registered new device
> driver usb
> [2018-01-23 15:01:36 INFO] [    1.649070] EDAC MC: Ver: 3.0.0
> [2018-01-23 15:01:36 INFO] [    1.653229] PCI: Using ACPI for IRQ routing
> [2018-01-23 15:01:36 INFO] [    1.658331] NetLabel: Initializing
> [2018-01-23 15:01:36 INFO] [    1.662002] NetLabel:  domain hash size = 128
> [2018-01-23 15:01:36 INFO] [    1.667001] NetLabel:  protocols = UNLABELED
> CIPSOv4 CALIPSO
> [2018-01-23 15:01:36 INFO] [    1.673022] NetLabel:  unlabeled traffic
> allowed by default
> [2018-01-23 15:01:36 INFO] [    1.679169] hpet0: at MMIO 0xfed00000, IRQs 2,
> 8, 0, 0, 0, 0, 0, 0
> [2018-01-23 15:01:36 INFO] [    1.685003] hpet0: 8 comparators, 64-bit
> 14.318180 MHz counter
> [2018-01-23 15:01:37 INFO] [    1.694059] clocksource: Switched to
> clocksource hpet
> [2018-01-23 15:01:37 INFO] [    1.708970] VFS: Disk quotas dquot_6.6.0
> [2018-01-23 15:01:37 INFO] [    1.713346] VFS: Dquot-cache hash table
> entries: 512 (order 0, 4096 bytes)
> [2018-01-23 15:01:37 INFO] [    1.721479] pnp: PnP ACPI init
> [2018-01-23 15:01:37 INFO] [    1.725075] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:37 INFO] [    1.734808] ACPI Error: Method parse/execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:37 INFO] [    1.745243] ACPI Error: Method execution
> failed _SB.PCI0.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:37 INFO] [    1.755056] pnp 00:00: can't evaluate _CRS: 1
> [2018-01-23 15:01:37 INFO] [    1.760106] system 00:01: [io 0x0680-0x069f]
> has been reserved
> [2018-01-23 15:01:37 INFO] [    1.766480] system 00:01: [io 0x0400-0x0453]
> has been reserved
> [2018-01-23 15:01:37 INFO] [    1.772834] system 00:01: [io 0x0458-0x047f]
> has been reserved
> [2018-01-23 15:01:37 INFO] [    1.779187] system 00:01: [io 0x0500-0x057f]
> has been reserved
> [2018-01-23 15:01:37 INFO] [    1.785539] system 00:01: [io 0x164e-0x164f]
> has been reserved
> [2018-01-23 15:01:37 INFO] [    1.792015] system 00:03: [io 0x0454-0x0457]
> has been reserved
> [2018-01-23 15:01:37 INFO] [    1.798492] ACPI Exception: AE_ERROR, Returned
> by Handler for [PCI_Config] (20170831/evregion-300)
> [2018-01-23 15:01:37 INFO] [    1.808228] ACPI Error: Method parse/execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/psparse-550)
> [2018-01-23 15:01:37 INFO] [    1.818631] ACPI Error: Method execution
> failed _SB.PCI1.PDRC._CRS, AE_ERROR (20170831/uteval-103)
> [2018-01-23 15:01:37 INFO] [    1.828453] pnp 00:05: can't evaluate _CRS: 1
> [2018-01-23 15:01:37 INFO] [    1.833632] pnp: PnP ACPI: found 6 devices
> [2018-01-23 15:01:37 INFO] [    1.844527] clocksource: acpi_pm: mask:
> 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [2018-01-23 15:01:37 INFO] [    1.854192] pci 0000:02:00.0: can't claim BAR
> 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
> [2018-01-23 15:01:37 INFO] [    1.864867] pci 0000:07:00.0: can't claim BAR
> 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
> [2018-01-23 15:01:37 INFO] [    1.875581] pci 0000:00:01.0: PCI bridge to
> [bus 01]
> [2018-01-23 15:01:37 INFO] [    1.880968] pci 0000:00:01.0:   bridge window
> [mem 0x94800000-0x948fffff 64bit pref]
> [2018-01-23 15:01:37 INFO] [    1.889461] pci 0000:00:02.0: PCI bridge to
> [bus 03]
> [2018-01-23 15:01:37 INFO] [    1.894842] pci 0000:00:02.0:   bridge window
> [io  0x5000-0x5fff]
> [2018-01-23 15:01:37 INFO] [    1.901360] pci 0000:00:02.0:   bridge window
> [mem 0x94c00000-0x94dfffff]
> [2018-01-23 15:01:37 INFO] [    1.908567] pci 0000:00:02.0:   bridge window
> [mem 0x94e00000-0x94ffffff 64bit pref]
> [2018-01-23 15:01:37 INFO] [    1.917096] pci 0000:02:00.0: BAR 6: assigned
> [mem 0x94a60000-0x94a7ffff pref]
> [2018-01-23 15:01:37 INFO] [    1.925097] pci 0000:00:02.2: PCI bridge to
> [bus 02]
> [2018-01-23 15:01:37 INFO] [    1.930482] pci 0000:00:02.2:   bridge window
> [io  0x3000-0x3fff]
> [2018-01-23 15:01:37 INFO] [    1.936991] pci 0000:00:02.2:   bridge window
> [mem 0x94a00000-0x94afffff]
> [2018-01-23 15:01:37 INFO] [    1.944197] pci 0000:00:02.2:   bridge window
> [mem 0x95000000-0x951fffff 64bit pref]
> [2018-01-23 15:01:37 INFO] [    1.952712] pci 0000:00:11.0: PCI bridge to
> [bus 04]
> [2018-01-23 15:01:37 INFO] [    1.958103] pci 0000:00:11.0:   bridge window
> [io  0x2000-0x2fff]
> [2018-01-23 15:01:37 INFO] [    1.964613] pci 0000:00:11.0:   bridge window
> [mem 0x94900000-0x949fffff]
> [2018-01-23 15:01:37 INFO] [    1.971820] pci 0000:00:11.0:   bridge window
> [mem 0x94000000-0x944fffff 64bit pref]
> [2018-01-23 15:01:37 INFO] [    1.980338] pci 0000:00:1c.0: PCI bridge to
> [bus 05]
> [2018-01-23 15:01:37 INFO] [    1.985733] pci 0000:00:1c.2: PCI bridge to
> [bus 06]
> [2018-01-23 15:01:37 INFO] [    1.991135] pci 0000:07:00.0: BAR 6: no space
> for [mem size 0x00010000 pref]
> [2018-01-23 15:01:37 INFO] [    1.998594] pci 0000:07:00.0: BAR 6: failed to
> assign [mem size 0x00010000 pref]
> [2018-01-23 15:01:37 INFO] [    2.006762] pci 0000:00:1c.3: PCI bridge to
> [bus 07]
> [2018-01-23 15:01:37 INFO] [    2.012149] pci 0000:00:1c.3:   bridge window
> [mem 0x94600000-0x947fffff]
> [2018-01-23 15:01:37 INFO] [    2.019361] pci 0000:00:1c.3:   bridge window
> [mem 0x90000000-0x93ffffff 64bit pref]
> [2018-01-23 15:01:37 INFO] [    2.027877] pci 0000:00:1e.0: PCI bridge to
> [bus 08]
> [2018-01-23 15:01:37 INFO] [    2.033362] pci 0000:80:02.0: PCI bridge to
> [bus 81]
> [2018-01-23 15:01:37 INFO] [    2.038754] pci 0000:80:02.2: PCI bridge to
> [bus 82]
> [2018-01-23 15:01:37 INFO] [    2.044140] pci 0000:80:02.2:   bridge window
> [io  0xc000-0xcfff]
> [2018-01-23 15:01:37 INFO] [    2.050652] pci 0000:80:02.2:   bridge window
> [mem 0xd0300000-0xd06fffff]
> [2018-01-23 15:01:37 INFO] [    2.057851] pci 0000:80:02.2:   bridge window
> [mem 0xd0000000-0xd01fffff 64bit pref]
> [2018-01-23 15:01:37 INFO] [    2.066446] NET: Registered protocol family 2
> [2018-01-23 15:01:37 INFO] [    2.071531] TCP established hash table
> entries: 4096 (order: 3, 32768 bytes)
> [2018-01-23 15:01:37 INFO] [    2.088751] TCP bind hash table entries: 4096
> (order: 4, 65536 bytes)
> [2018-01-23 15:01:37 INFO] [    2.095616] TCP: Hash tables configured
> (established 4096 bind 4096)
> [2018-01-23 15:01:37 INFO] [    2.102460] UDP hash table entries: 256
> (order: 1, 8192 bytes)
> [2018-01-23 15:01:37 INFO] [    2.108705] UDP-Lite hash table entries: 256
> (order: 1, 8192 bytes)
> [2018-01-23 15:01:37 INFO] [    2.115507] NET: Registered protocol family 1
> [2018-01-23 15:01:37 INFO] [    2.120881] pci 0000:02:00.0: [Firmwai
> [2018-01-23 15:01:37 INFO] [    2.132161] pci 0000:07:00.0: Video device
> with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [2018-01-23 15:01:37 INFO] [    2.141489] Unpacking initramfs...
> [2018-01-23 15:01:38 INFO] [    2.814841] Freeing initrd memory: 35652K
> [2018-01-23 15:01:38 INFO] [    2.821165] RAPL PMU: API unit is 2^-32
> Joules, 3 fixed counters, 163840 ms ovfl timer
> [2018-01-23 15:01:38 INFO] [    2.829852] RAPL PMU: hw unit of domain
> pp0-core 2^-16 Joules
> [2018-01-23 15:01:38 INFO] [    2.836017] RAPL PMU: hw unit of domain
> package 2^-16 Joules
> [2018-01-23 15:01:38 INFO] [    2.842105] RAPL PMU: hw unit of domain dram
> 2^-16 Joules
> [2018-01-23 15:01:38 INFO] [    2.852900] Initialise system trusted keyrings
> [2018-01-23 15:01:38 INFO] [    2.857776] Key type blacklist registered
> [2018-01-23 15:01:38 INFO] [    2.862252] workingset: timestamp_bits=36
> max_order=17 bucket_order=0
> [2018-01-23 15:01:38 INFO] [    2.870237] zbud: loaded
> [2018-01-23 15:01:38 INFO] [    2.929909] NET: Registered protocol family 38
> [2018-01-23 15:01:38 INFO] [    2.934782] Key type asymmetric registered
> [2018-01-23 15:01:38 INFO] [    2.939307] Asymmetric key parser 'x509'
> registered
> [2018-01-23 15:01:38 INFO] [    2.944621] Block layer SCSI generic (bsg)
> driver version 0.4 loaded (major 249)
> [2018-01-23 15:01:38 INFO] [    2.952876] io scheduler noop registered
> [2018-01-23 15:01:38 INFO] [    2.957222] io scheduler deadline registered
> [2018-01-23 15:01:38 INFO] [    2.961956] io scheduler cfq registered
> (default)
> [2018-01-23 15:01:38 INFO] [    2.967091] io scheduler mq-deadline
> registered
> [2018-01-23 15:01:38 INFO] [    2.972037] io scheduler kyber registered
> [2018-01-23 15:01:38 INFO] [    2.976716] atomic64_test: passed for x86-64
> platform with CX8 and with SSE
> [2018-01-23 15:01:38 INFO] [    3.022243] input: Power Button as
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [2018-01-23 15:01:38 INFO] [    3.030427] ACPI: Power Button [PWRF]
> [2018-01-23 15:01:38 INFO] [    3.059915] ERST: Error Record Serialization
> Table (ERST) support is initialized.
> [2018-01-23 15:01:38 INFO] [    3.068173] pstore: using zlib compression
> [2018-01-23 15:01:38 INFO] [    3.072675] pstore: Registered erst as
> persistent store backend
> [2018-01-23 15:01:38 INFO] [    3.079317] GHES: APEI firmware first mode is
> enabled by APEI bit and WHEA _OSC.
> [2018-01-23 15:01:38 INFO] [    3.087573] Serial: 8250/16550 driver, 8
> ports, IRQ sharing enabled
> [2018-01-23 15:01:38 INFO] [    3.114931] 00:04: ttyS0 at I/O 0x3f8 (irq =
> 4, base_baud = 115200) is a 16550A
> [2018-01-23 15:01:38 INFO] [    3.123878] Non-volatile memory driver v1.3
> [2018-01-23 15:01:38 INFO] [    3.128544] Linux agpgart interface v0.103
> [2018-01-23 15:01:38 INFO] [    3.135321] rdac: device handler registered
> [2018-01-23 15:01:38 INFO] [    3.139965] hp_sw: device handler registered
> [2018-01-23 15:01:38 INFO] [    3.144642] emc: device handler registered
> [2018-01-23 15:01:38 INFO] [    3.149240] alua: device handler registered
> [2018-01-23 15:01:38 INFO] [    3.153880] libphy: Fixed MDIO Bus: probed
> [2018-01-23 15:01:38 INFO] [    3.158457] ehci_hcd: USB 2.0 'Enhanced' Host
> Controller (EHCI) Driver
> [2018-01-23 15:01:38 INFO] [    3.165408] ehci-pci: EHCI PCI platform driver
> [2018-01-23 15:01:38 INFO] [    3.170423] ehci-pci 0000:00:1a.0: EHCI Host
> Controller
> [2018-01-23 15:01:38 INFO] [    3.176116] ehci-pci 0000:00:1a.0: new USB bus
> registered, assigned bus number 1
> [2018-01-23 15:01:38 INFO] [    3.184300] ehci-pci 0000:00:1a.0: debug port
> 2
> [2018-01-23 15:01:38 INFO] [    3.193177] ehci-pci 0000:00:1a.0: irq 16, io
> mem 0x94b26000
> [2018-01-23 15:01:38 INFO] [    3.206050] ehci-pci 0000:00:1a.0: USB 2.0
> started, EHCI 1.00
> [2018-01-23 15:01:38 INFO] [    3.212265] usb usb1: New USB device found,
> idVendor=1d6b, idProduct=0002
> [2018-01-23 15:01:38 INFO] [    3.219463] usb usb1: New USB device strings:
> Mfr=3, Product=2, SerialNumber=1
> [2018-01-23 15:01:38 INFO] [    3.227460] usb usb1: Product: EHCI Host
> Controller
> [2018-01-23 15:01:38 INFO] [    3.232759] usb usb1: Manufacturer: Linux
> 4.15.0-rc8 ehci_hcd
> [2018-01-23 15:01:38 INFO] [    3.238920] usb usb1: SerialNumber:
> 0000:00:1a.0
> [2018-01-23 15:01:38 INFO] [    3.244091] hub 1-0:1.0: USB hub found
> [2018-01-23 15:01:38 INFO] [    3.248277] hub 1-0:1.0: 6 ports detected
> [2018-01-23 15:01:38 INFO] [    3.252991] ehci-pci 0000:00:1d.0: EHCI Host
> Controller
> [2018-01-23 15:01:38 INFO] [    3.258694] ehci-pci 0000:00:1d.0: new USB bus
> registered, assigned bus number 2
> [2018-01-23 15:01:38 INFO] [    3.266874] ehci-pci 0000:00:1d.0: debug port
> 2
> [2018-01-23 15:01:38 INFO] [    3.275750] ehci-pci 0000:00:1d.0: irq 23, io
> mem 0x94b25000
> [2018-01-23 15:01:38 INFO] [    3.288054] ehci-pci 0000:00:1d.0: USB 2.0
> started, EHCI 1.00
> [2018-01-23 15:01:38 INFO] [    3.294267] usb usb2: New USB device found,
> idVendor=1d6b, idProduct=0002
> [2018-01-23 15:01:38 INFO] [    3.301451] usb usb2: New USB device strings:
> Mfr=3, Product=2, SerialNumber=1
> [2018-01-23 15:01:38 INFO] [    3.309452] usb usb2: Product: EHCI Host
> Controller
> [2018-01-23 15:01:38 INFO] [    3.314741] usb usb2: Manufacturer: Linux
> 4.15.0-rc8 ehci_hcd
> [2018-01-23 15:01:38 INFO] [    3.320893] usb usb2: SerialNumber:
> 0000:00:1d.0
> [2018-01-23 15:01:38 INFO] [    3.326071] hub 2-0:1.0: USB hub found
> [2018-01-23 15:01:38 INFO] [    3.330245] hub 2-0:1.0: 8 ports detected
> [2018-01-23 15:01:38 INFO] [    3.334835] ohci_hcd: USB 1.1 'Open' Host
> Controller (OHCI) Driver
> [2018-01-23 15:01:38 INFO] [    3.341437] ohci-pci: OHCI PCI platform driver
> [2018-01-23 15:01:38 INFO] [    3.346326] uhci_hcd: USB Universal Host
> Controller Interface driver
> [2018-01-23 15:01:38 INFO] [    3.353157] usbcore: registered new interface
> driver usbserial_generic
> 
> I also post this bug to kernel bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=198559
> 
> thanks
> 
> 
> 
> .
> 
> 
> 
> .
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
