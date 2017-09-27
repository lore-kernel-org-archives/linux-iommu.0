From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: intel-dmar: possible circular locking dependency detected
Date: Wed, 27 Sep 2017 14:14:29 +0200
Message-ID: <4e9f9665-38f7-c5f0-2a9d-13bb3a00aab2@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

while I'm triggering this with a still out-of-tree module from the
Jailhouse project, the potential deadlock appears to me being unrelated
to it. Please have a look:

======================================================
WARNING: possible circular locking dependency detected
4.14.0-rc2-dbg+ #176 Tainted: G           O
------------------------------------------------------
jailhouse/6105 is trying to acquire lock:
dmar_pci_bus_notifier+0x4f/0xcb

but task is already holding lock:
__blocking_notifier_call_chain+0x31/0x65

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&(&priv->bus_notifier)->rwsem){++++}:
       __lock_acquire+0xed7/0x113b
       lock_acquire+0x148/0x1f6
       down_write+0x3b/0x6a
       blocking_notifier_chain_register+0x33/0x53
       bus_register_notifier+0x1c/0x1e
       dmar_dev_scope_init+0x2c6/0x2db
       intel_iommu_init+0xec/0x11c2
       pci_iommu_init+0x17/0x41
       do_one_initcall+0x90/0x143
       kernel_init_freeable+0x1cc/0x256
       kernel_init+0xe/0xf8
       ret_from_fork+0x2a/0x40

-> #0 (dmar_global_lock){++++}:
       check_prev_add+0x112/0x65f
       __lock_acquire+0xed7/0x113b
       lock_acquire+0x148/0x1f6
       down_write+0x3b/0x6a
       dmar_pci_bus_notifier+0x4f/0xcb
       notifier_call_chain+0x3c/0x5e
       __blocking_notifier_call_chain+0x4c/0x65
       blocking_notifier_call_chain+0x14/0x16
       device_add+0x40c/0x522
       pci_device_add+0x1c0/0x1ce
       pci_scan_single_device+0x92/0x9d
       pci_scan_slot+0x59/0x10a
       jailhouse_pci_do_all_devices+0x74/0x263 [jailhouse]
       jailhouse_pci_virtual_root_devices_add+0x40/0x42 [jailhouse]
       jailhouse_cmd_enable+0x4fd/0x5e8 [jailhouse]
       jailhouse_ioctl+0x28/0x70 [jailhouse]
       vfs_ioctl+0x18/0x34
       do_vfs_ioctl+0x51b/0x5e3
       SyS_ioctl+0x50/0x7b
       entry_SYSCALL_64_fastpath+0x1f/0xbe

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&priv->bus_notifier)->rwsem);
                               lock(dmar_global_lock);
                               lock(&(&priv->bus_notifier)->rwsem);
  lock(dmar_global_lock);

 *** DEADLOCK ***

2 locks held by jailhouse/6105:
jailhouse_cmd_enable+0x130/0x5e8 [jailhouse]
__blocking_notifier_call_chain+0x31/0x65

stack backtrace:
CPU: 1 PID: 6105 Comm: jailhouse Tainted: G           O
4.14.0-rc2-dbg+ #176
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 dump_stack+0x85/0xbe
 print_circular_bug+0x389/0x398
 ? add_lock_to_list.isra.23+0x96/0x96
 check_prev_add+0x112/0x65f
 ? kernel_text_address+0x1c/0x6a
 ? add_lock_to_list.isra.23+0x96/0x96
 __lock_acquire+0xed7/0x113b
 ? __lock_acquire+0xed7/0x113b
 lock_acquire+0x148/0x1f6
 ? dmar_pci_bus_notifier+0x4f/0xcb
 down_write+0x3b/0x6a
 ? dmar_pci_bus_notifier+0x4f/0xcb
 dmar_pci_bus_notifier+0x4f/0xcb
 notifier_call_chain+0x3c/0x5e
 __blocking_notifier_call_chain+0x4c/0x65
 blocking_notifier_call_chain+0x14/0x16
 device_add+0x40c/0x522
 pci_device_add+0x1c0/0x1ce
 pci_scan_single_device+0x92/0x9d
 pci_scan_slot+0x59/0x10a
 jailhouse_pci_do_all_devices+0x74/0x263 [jailhouse]
 jailhouse_pci_virtual_root_devices_add+0x40/0x42 [jailhouse]
 jailhouse_cmd_enable+0x4fd/0x5e8 [jailhouse]
 jailhouse_ioctl+0x28/0x70 [jailhouse]
 vfs_ioctl+0x18/0x34
 do_vfs_ioctl+0x51b/0x5e3
 ? kmem_cache_free+0x15b/0x1fa
 ? entry_SYSCALL_64_fastpath+0x5/0xbe
 ? trace_hardirqs_on_caller+0x180/0x19c
 SyS_ioctl+0x50/0x7b
 entry_SYSCALL_64_fastpath+0x1f/0xbe
RIP: 0033:0x7f8b3b110d87
RSP: 002b:00007ffc44b70088 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000046 RCX: 00007f8b3b110d87
RDX: 0000000000604010 RSI: 0000000040080000 RDI: 0000000000000003
RBP: 0000000000604010 R08: 00007f8b3b3ade80 R09: 00000000000885d0
R10: 00007ffc44b6fe40 R11: 0000000000000206 R12: 00000000000025d4
R13: 0000000000000000 R14: 00007ffc44b714a4 R15: 0000000000000000

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
