From: Dave Jones <davej@codemonkey.org.uk>
Subject: intel-iommu sysfs oops.
Date: Thu, 23 Feb 2017 14:44:06 -0500
Message-ID: <20170223194406.i3scsushn7bbizdv@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: jroedel@suse.de, dwmw2@infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

cat /sys/devices/virtual/iommu/dmar0/intel-iommu/version

Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
CPU: 2 PID: 1488 Comm: cat Not tainted 4.10.0-think+ #5 
task: ffff8804ee440040 task.stack: ffffc90000d48000
RIP: 0010:intel_iommu_show_version+0x13/0x40
RSP: 0018:ffffc90000d4bcf0 EFLAGS: 00010286
RAX: ffff8804ede80008 RBX: ffffffff81ec2c80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81ec2c80 RDI: ffff88017fc2d5d0
RBP: ffffc90000d4bcf0 R08: 0000000000000000 R09: ffff8804ede80008
R10: 00000000068b13bb R11: 0000000000000006 R12: 0000000000001000
R13: ffffffff81a96f10 R14: ffff8804fdd131b8 R15: ffff8804ede80008
FS:  00007feb8ad5e700(0000) GS:ffff880507c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000004ee49a000 CR4: 00000000001406e0
Call Trace:
 dev_attr_show+0x20/0x50
 ? sysfs_file_ops+0x46/0x70
 sysfs_kf_seq_show+0xb7/0x110
 kernfs_seq_show+0x26/0x30
 seq_read+0x129/0x4a0
 kernfs_fop_read+0x13b/0x1a0
 __vfs_read+0x37/0x140
 ? __context_tracking_exit.part.5+0x82/0x150
 vfs_read+0xab/0x180
 SyS_read+0x58/0xc0
 do_syscall_64+0x61/0x170
 entry_SYSCALL64_slow_path+0x25/0x25
RIP: 0033:0x7feb8a8875a0
RSP: 002b:00007fff8dece608 EFLAGS: 00000246
ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007feb8a8875a0
RDX: 0000000000020000 RSI: 00007feb8aba2000 RDI: 0000000000000003
RBP: 00007feb8aba2000 R08: ffffffffffffffff R09: 0000000000000000
R10: 000000000000037b R11: 0000000000000246 R12: 00007feb8aba2000
R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000001000


$ dmesg | grep -i dmar
[    0.000000] ACPI: DMAR 0x00000000D479B0B8 0000B8 (v01 LENOVO TC-FB    00001B30 INTL 00000001)
[    0.190199] DMAR: Host address width 39
[    0.190208] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.190235] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020660462 ecap f0101a
[    0.190250] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.190272] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008020660462 ecap f010da
[    0.190286] DMAR: RMRR base: 0x000000d5e6c000 end: 0x000000d5e92fff
[    0.190302] DMAR: RMRR base: 0x000000d7000000 end: 0x000000df1fffff
[    0.190318] DMAR-IR: IOAPIC id 8 under DRHD base  0xfed91000 IOMMU 1
[    0.190330] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.190341] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.190634] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    1.050338] DMAR: No ATSR found
[    1.050717] DMAR: dmar0: Using Queued invalidation
[    1.050739] DMAR: dmar1: Using Queued invalidation
[    1.050799] DMAR: Setting RMRR:
[    1.050938] DMAR: Setting identity map for device 0000:00:02.0 [0xd7000000 - 0xdf1fffff]
[    1.051763] DMAR: Setting identity map for device 0000:00:14.0 [0xd5e6c000 - 0xd5e92fff]
[    1.051911] DMAR: Setting identity map for device 0000:00:1a.0 [0xd5e6c000 - 0xd5e92fff]
[    1.052054] DMAR: Setting identity map for device 0000:00:1d.0 [0xd5e6c000 - 0xd5e92fff]
[    1.052083] DMAR: Prepare 0-16MiB unity mapping for LPC
[    1.052200] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    1.052331] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    1.220475] [drm] DMAR active, disabling use of stolen memory
[    1.653051] calling  dmar_free_unused_resources+0x0/0xcf @ 1
[    1.653054] initcall dmar_free_unused_resources+0x0/0xcf returned 0 after 1 usecs

$ dmesg | grep -i iommu
[    0.190318] DMAR-IR: IOAPIC id 8 under DRHD base  0xfed91000 IOMMU 1
[    0.568456] calling  iommu_init+0x0/0x2b @ 1
[    0.568470] initcall iommu_init+0x0/0x2b returned 0 after 0 usecs
[    0.570137] calling  iommu_dev_init+0x0/0x19 @ 1
[    0.570158] initcall iommu_dev_init+0x0/0x19 returned 0 after 0 usecs
[    1.050256] calling  pci_iommu_init+0x0/0x3c @ 1
[    1.052700] iommu: Adding device 0000:00:00.0 to group 0
[    1.052767] iommu: Adding device 0000:00:02.0 to group 1
[    1.052833] iommu: Adding device 0000:00:03.0 to group 2
[    1.052895] iommu: Adding device 0000:00:14.0 to group 3
[    1.052965] iommu: Adding device 0000:00:16.0 to group 4
[    1.053026] iommu: Adding device 0000:00:19.0 to group 5
[    1.053093] iommu: Adding device 0000:00:1a.0 to group 6
[    1.053157] iommu: Adding device 0000:00:1b.0 to group 7
[    1.053220] iommu: Adding device 0000:00:1c.0 to group 8
[    1.053286] iommu: Adding device 0000:00:1c.3 to group 9
[    1.053348] iommu: Adding device 0000:00:1d.0 to group 10
[    1.053443] iommu: Adding device 0000:00:1f.0 to group 11
[    1.053487] iommu: Adding device 0000:00:1f.2 to group 11
[    1.053529] iommu: Adding device 0000:00:1f.3 to group 11
[    1.053599] iommu: Adding device 0000:02:00.0 to group 12
[    1.065133] initcall pci_iommu_init+0x0/0x3c returned 0 after 14515 usecs
