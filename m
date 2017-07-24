From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: intel-iommu: possible circular locking dependency?
Date: Mon, 24 Jul 2017 13:58:30 +0200
Message-ID: <1b6c6aa5-a008-4052-e507-cd1c232fc5b9@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

this trigger for this is out-of-tree [1], but my understanding so far is
that this is an in-tree issue:

[   14.841871] ======================================================
[   14.841874] WARNING: possible circular locking dependency detected
[   14.841878] 4.13.0-rc2-dbg+ #174 Tainted: G           O   
[   14.841881] ------------------------------------------------------
[   14.841884] jailhouse/6120 is trying to acquire lock:
[   14.841887]  (dmar_global_lock){++++..}, at: [<ffffffff814d6e43>] dmar_pci_bus_notifier+0x4f/0xcb
[   14.841907] 
[   14.841907] but task is already holding lock:
[   14.841910]  (&(&priv->bus_notifier)->rwsem){++++..}, at: [<ffffffff8106d853>] __blocking_notifier_call_chain+0x31/0x65
[   14.841925] 
[   14.841925] which lock already depends on the new lock.
[   14.841925] 
[   14.841930] 
[   14.841930] the existing dependency chain (in reverse order) is:
[   14.841933] 
[   14.841933] -> #1 (&(&priv->bus_notifier)->rwsem){++++..}:
[   14.841943]        lock_acquire+0x148/0x1f6
[   14.841951]        down_write+0x3b/0x6a
[   14.841954]        blocking_notifier_chain_register+0x33/0x53
[   14.841960]        bus_register_notifier+0x1c/0x1e
[   14.841972]        dmar_dev_scope_init+0x2c6/0x2db
[   14.841976]        intel_iommu_init+0xeb/0x12cb
[   14.841983]        pci_iommu_init+0x17/0x41
[   14.841989]        do_one_initcall+0x90/0x143
[   14.841994]        kernel_init_freeable+0x1cc/0x256
[   14.841999]        kernel_init+0xe/0xf8
[   14.842004]        ret_from_fork+0x2a/0x40
[   14.842008] 
[   14.842008] -> #0 (dmar_global_lock){++++..}:
[   14.842017]        __lock_acquire+0xfe4/0x1521
[   14.842021]        lock_acquire+0x148/0x1f6
[   14.842026]        down_write+0x3b/0x6a
[   14.842031]        dmar_pci_bus_notifier+0x4f/0xcb
[   14.842036]        notifier_call_chain+0x3c/0x5e
[   14.842041]        __blocking_notifier_call_chain+0x4c/0x65
[   14.842046]        blocking_notifier_call_chain+0x14/0x16
[   14.842051]        device_add+0x40c/0x522
[   14.842062]        pci_device_add+0x1c0/0x1ce
[   14.842066]        pci_scan_single_device+0x92/0x9d
[   14.842071]        pci_scan_slot+0x59/0xff
[   14.842078]        jailhouse_pci_do_all_devices+0x74/0x263 [jailhouse]
[   14.842084]        jailhouse_pci_virtual_root_devices_add+0x40/0x42 [jailhouse]
[   14.842090]        jailhouse_cmd_enable+0x4fd/0x5e3 [jailhouse]
[   14.842096]        jailhouse_ioctl+0x28/0x70 [jailhouse]
[   14.842106]        vfs_ioctl+0x18/0x34
[   14.842111]        do_vfs_ioctl+0x512/0x5da
[   14.842116]        SyS_ioctl+0x50/0x7b
[   14.842121]        entry_SYSCALL_64_fastpath+0x1f/0xbe
[   14.842125] 
[   14.842125] other info that might help us debug this:
[   14.842125] 
[   14.842134]  Possible unsafe locking scenario:
[   14.842134] 
[   14.842140]        CPU0                    CPU1
[   14.842144]        ----                    ----
[   14.842148]   lock(&(&priv->bus_notifier)->rwsem);
[   14.842155]                                lock(dmar_global_lock);
[   14.842160]                                lock(&(&priv->bus_notifier)->rwsem);
[   14.842166]   lock(dmar_global_lock);
[   14.842170] 
[   14.842170]  *** DEADLOCK ***
[   14.842170] 
[   14.842179] 2 locks held by jailhouse/6120:
[   14.842183]  #0:  (jailhouse_lock){+.+.+.}, at: [<ffffffffa03c1fd3>] jailhouse_cmd_enable+0x130/0x5e3 [jailhouse]
[   14.842194]  #1:  (&(&priv->bus_notifier)->rwsem){++++..}, at: [<ffffffff8106d853>] __blocking_notifier_call_chain+0x31/0x65
[   14.842204] 
[   14.842204] stack backtrace:
[   14.842211] CPU: 0 PID: 6120 Comm: jailhouse Tainted: G           O    4.13.0-rc2-dbg+ #174
[   14.842217] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[   14.842225] Call Trace:
[   14.842232]  dump_stack+0x85/0xbe
[   14.842237]  print_circular_bug+0x29b/0x2a9
[   14.842243]  __lock_acquire+0xfe4/0x1521
[   14.842248]  ? save_trace+0x3b/0x9b
[   14.842253]  lock_acquire+0x148/0x1f6
[   14.842257]  ? lock_acquire+0x148/0x1f6
[   14.842262]  ? dmar_pci_bus_notifier+0x4f/0xcb
[   14.842268]  down_write+0x3b/0x6a
[   14.842272]  ? dmar_pci_bus_notifier+0x4f/0xcb
[   14.842277]  dmar_pci_bus_notifier+0x4f/0xcb
[   14.842282]  notifier_call_chain+0x3c/0x5e
[   14.842287]  __blocking_notifier_call_chain+0x4c/0x65
[   14.842292]  blocking_notifier_call_chain+0x14/0x16
[   14.842297]  device_add+0x40c/0x522
[   14.842302]  pci_device_add+0x1c0/0x1ce
[   14.842306]  pci_scan_single_device+0x92/0x9d
[   14.842311]  pci_scan_slot+0x59/0xff
[   14.842316]  jailhouse_pci_do_all_devices+0x74/0x263 [jailhouse]
[   14.842322]  jailhouse_pci_virtual_root_devices_add+0x40/0x42 [jailhouse]
[   14.842329]  jailhouse_cmd_enable+0x4fd/0x5e3 [jailhouse]
[   14.842337]  jailhouse_ioctl+0x28/0x70 [jailhouse]
[   14.842342]  vfs_ioctl+0x18/0x34
[   14.842346]  do_vfs_ioctl+0x512/0x5da
[   14.842352]  ? kmem_cache_free+0x15b/0x1fa
[   14.842357]  ? entry_SYSCALL_64_fastpath+0x5/0xbe
[   14.842362]  ? trace_hardirqs_on_caller+0x180/0x19c
[   14.842367]  SyS_ioctl+0x50/0x7b
[   14.842372]  entry_SYSCALL_64_fastpath+0x1f/0xbe

Didn't see this with 4.12, so a 4.13 regression?

Jan

[1] https://github.com/siemens/jailhouse/blob/7ef4b98ebe04f49f63985b6547a09875dcbe28ec/driver/pci.c#L75-- 
Siemens AG
Corporate Technology
CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
Otto-Hahn-Ring 6
81739 Muenchen
Tel.: +49 89 636-634006
Fax: +49 89 636-33045
mailto:jan.kiszka@siemens.com

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard
Cromme; Managing Board: Joe Kaeser, Chairman, President and Chief
Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina
Kugel, Cedrik Neike, Michael Sen, Ralf P. Thomas; Registered offices:
Berlin and Munich, Germany; Commercial registries: Berlin
Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
