From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Lockdep warning in VFIO using v4.2-rc3
Date: Thu, 23 Jul 2015 11:15:58 +0200
Message-ID: <20150723091558.GJ10969@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

I stumbled over this lockdep warning yesterday while testing my VT-d
changes. It looks like one code path is taking the locks:

	group->device_lock
	driver_lock
	pci_bus_sem

while another path is taking

	pci_bus_sem
	group->device_lock

which could lead to a deadlock. I attach the full warning, can you
please have a look?

[  252.892008] ======================================================
[  252.892008] [ INFO: possible circular locking dependency detected ]
[  252.892008] 4.2.0-rc3+ #16 Not tainted
[  252.892008] -------------------------------------------------------
[  252.892008] qemu-system-x86/4986 is trying to acquire lock:
[  252.892008]  (&group->device_lock){+.+.+.}, at: [<ffffffffa0569da4>] vfio_group_get_device+0x24/0xb0 [vfio]
[  252.892008] 
but task is already holding lock:
[  252.892008]  (pci_bus_sem){++++.+}, at: [<ffffffff813ee47e>] pci_walk_bus+0x2e/0xa0
[  252.892008] 
which lock already depends on the new lock.

[  252.892008] 
the existing dependency chain (in reverse order) is:
[  252.892008] 
-> #2 (pci_bus_sem){++++.+}:
[  252.892008]        [<ffffffff810c9152>] __lock_acquire+0xca2/0x1550
[  252.892008]        [<ffffffff810c9b6f>] lock_acquire+0xdf/0x2c0
[  252.892008]        [<ffffffff81710c4c>] down_read+0x4c/0xa0
[  252.892008]        [<ffffffff813ee47e>] pci_walk_bus+0x2e/0xa0
[  252.892008]        [<ffffffffa0657dcb>] vfio_pci_release+0x18b/0x3c0 [vfio_pci]
[  252.892008]        [<ffffffffa056a100>] vfio_device_fops_release+0x20/0x40 [vfio]
[  252.892008]        [<ffffffff81211460>] __fput+0xf0/0x200
[  252.892008]        [<ffffffff812115be>] ____fput+0xe/0x10
[  252.892008]        [<ffffffff8108f5fd>] task_work_run+0x8d/0xc0
[  252.892008]        [<ffffffff8106d35c>] do_exit+0x32c/0xc30
[  252.892008]        [<ffffffff8106f10c>] do_group_exit+0x4c/0xc0
[  252.892008]        [<ffffffff8107d678>] get_signal+0x328/0x9e0
[  252.892008]        [<ffffffff81003458>] do_signal+0x28/0x9e0
[  252.892008]        [<ffffffff81003e75>] do_notify_resume+0x65/0x80
[  252.892008]        [<ffffffff81713e2e>] int_signal+0x12/0x17
[  252.892008] 
-> #1 (driver_lock){+.+.+.}:
[  252.892008]        [<ffffffff810c9152>] __lock_acquire+0xca2/0x1550
[  252.892008]        [<ffffffff810c9b6f>] lock_acquire+0xdf/0x2c0
[  252.892008]        [<ffffffff8170e71b>] mutex_lock_nested+0x6b/0x420
[  252.892008]        [<ffffffffa06576b8>] vfio_pci_open+0x38/0x270 [vfio_pci]
[  252.892008]        [<ffffffffa056ab17>] vfio_group_fops_unl_ioctl+0x267/0x460 [vfio]
[  252.892008]        [<ffffffff8122454d>] do_vfs_ioctl+0x30d/0x580
[  252.892008]        [<ffffffff81224839>] SyS_ioctl+0x79/0x90
[  252.892008]        [<ffffffff81713c32>] entry_SYSCALL_64_fastpath+0x16/0x7a
[  252.892008] 
-> #2 (&group->device_lock){+.+.+.}:
[  252.892008]        [<ffffffff810c6c6c>] check_prevs_add+0x8fc/0x900
[  252.892008]        [<ffffffff810c9152>] __lock_acquire+0xca2/0x1550
[  252.892008]        [<ffffffff810c9b6f>] lock_acquire+0xdf/0x2c0
[  252.892008]        [<ffffffff8170e71b>] mutex_lock_nested+0x6b/0x420
[  252.892008]        [<ffffffffa0569da4>] vfio_group_get_device+0x24/0xb0 [vfio]
[  252.892008]        [<ffffffffa056a165>] vfio_device_get_from_dev+0x45/0xa0 [vfio]
[  252.892008]        [<ffffffffa065762c>] vfio_pci_get_devs+0x2c/0x80 [vfio_pci]
[  252.892008]        [<ffffffffa065706d>] vfio_pci_walk_wrapper+0x5d/0x70 [vfio_pci]
[  252.892008]        [<ffffffff813ee4c5>] pci_walk_bus+0x75/0xa0
[  252.892008]        [<ffffffffa0657e93>] vfio_pci_release+0x253/0x3c0 [vfio_pci]
[  252.892008]        [<ffffffffa056a100>] vfio_device_fops_release+0x20/0x40 [vfio]
[  252.892008]        [<ffffffff81211460>] __fput+0xf0/0x200
[  252.892008]        [<ffffffff812115be>] ____fput+0xe/0x10
[  252.892008]        [<ffffffff8108f5fd>] task_work_run+0x8d/0xc0
[  252.892008]        [<ffffffff8106d35c>] do_exit+0x32c/0xc30
[  252.892008]        [<ffffffff8106f10c>] do_group_exit+0x4c/0xc0
[  252.892008]        [<ffffffff8107d678>] get_signal+0x328/0x9e0
[  252.892008]        [<ffffffff81003458>] do_signal+0x28/0x9e0
[  252.892008]        [<ffffffff81003e75>] do_notify_resume+0x65/0x80
[  252.892008]        [<ffffffff81713e2e>] int_signal+0x12/0x17
[  252.892008] 
other info that might help us debug this:

[  252.892008] Chain exists of:
  &group->device_lock --> driver_lock --> pci_bus_sem

[  252.892008]  Possible unsafe locking scenario:

[  252.892008]        CPU0                    CPU1
[  252.892008]        ----                    ----
[  252.892008]   lock(pci_bus_sem);
[  252.892008]                                lock(driver_lock);
[  252.892008]                                lock(pci_bus_sem);
[  252.892008]   lock(&group->device_lock);
[  252.892008] 
 *** DEADLOCK ***

[  252.892008] 2 locks held by qemu-system-x86/4986:
[  252.892008]  #0:  (driver_lock){+.+.+.}, at: [<ffffffffa0657c67>] vfio_pci_release+0x27/0x3c0 [vfio_pci]
[  252.892008]  #1:  (pci_bus_sem){++++.+}, at: [<ffffffff813ee47e>] pci_walk_bus+0x2e/0xa0
[  252.892008] 
stack backtrace:
[  252.892008] CPU: 5 PID: 4986 Comm: qemu-system-x86 Not tainted 4.2.0-rc3+ #16
[  252.892008] Hardware name: Dell Inc. Precision T3610/09M8Y8, BIOS A06 02/28/2014
[  252.892008]  ffffffff828e8d10 ffff88042af47818 ffffffff8170a128 0000000000000000
[  252.892008]  ffffffff828e54e0 ffff88042af47868 ffffffff81704b1d ffff880374b41180
[  252.892008]  ffff88042af478a8 ffff88042af47868 0000000000000001 ffff880374b41a20
[  252.892008] Call Trace:
[  252.892008]  [<ffffffff8170a128>] dump_stack+0x4c/0x6e
[  252.892008]  [<ffffffff81704b1d>] print_circular_bug+0x202/0x213
[  252.892008]  [<ffffffff810c6c6c>] check_prevs_add+0x8fc/0x900
[  252.892008]  [<ffffffff8100dac9>] ? sched_clock+0x9/0x10
[  252.892008]  [<ffffffff810c9152>] __lock_acquire+0xca2/0x1550
[  252.892008]  [<ffffffff810c9b6f>] lock_acquire+0xdf/0x2c0
[  252.892008]  [<ffffffffa0569da4>] ? vfio_group_get_device+0x24/0xb0 [vfio]
[  252.892008]  [<ffffffff8170e71b>] mutex_lock_nested+0x6b/0x420
[  252.892008]  [<ffffffffa0569da4>] ? vfio_group_get_device+0x24/0xb0 [vfio]
[  252.892008]  [<ffffffffa0569da4>] ? vfio_group_get_device+0x24/0xb0 [vfio]
[  252.892008]  [<ffffffff810c72fd>] ? trace_hardirqs_on+0xd/0x10
[  252.892008]  [<ffffffffa0569da4>] vfio_group_get_device+0x24/0xb0 [vfio]
[  252.892008]  [<ffffffffa056a165>] vfio_device_get_from_dev+0x45/0xa0 [vfio]
[  252.892008]  [<ffffffffa0657010>] ? vfio_pci_count_devs+0x10/0x10 [vfio_pci]
[  252.892008]  [<ffffffffa065762c>] vfio_pci_get_devs+0x2c/0x80 [vfio_pci]
[  252.892008]  [<ffffffffa0657010>] ? vfio_pci_count_devs+0x10/0x10 [vfio_pci]
[  252.892008]  [<ffffffffa065706d>] vfio_pci_walk_wrapper+0x5d/0x70 [vfio_pci]
[  252.892008]  [<ffffffff813ee4c5>] pci_walk_bus+0x75/0xa0
[  252.892008]  [<ffffffffa0657e93>] vfio_pci_release+0x253/0x3c0 [vfio_pci]
[  252.892008]  [<ffffffffa0657600>] ? vfio_pci_rw+0x60/0x60 [vfio_pci]
[  252.892008]  [<ffffffffa056a100>] vfio_device_fops_release+0x20/0x40 [vfio]
[  252.892008]  [<ffffffff81211460>] __fput+0xf0/0x200
[  252.892008]  [<ffffffff812115be>] ____fput+0xe/0x10
[  252.892008]  [<ffffffff8108f5fd>] task_work_run+0x8d/0xc0
[  252.892008]  [<ffffffff8106d35c>] do_exit+0x32c/0xc30
[  252.892008]  [<ffffffff81713110>] ? _raw_spin_unlock_irq+0x30/0x60
[  252.892008]  [<ffffffff8106f10c>] do_group_exit+0x4c/0xc0
[  252.892008]  [<ffffffff8107d678>] get_signal+0x328/0x9e0
[  252.892008]  [<ffffffff81003458>] do_signal+0x28/0x9e0
[  252.892008]  [<ffffffff8110cba1>] ? do_futex+0xd1/0x500
[  252.892008]  [<ffffffff811ca67d>] ? __might_fault+0x4d/0xa0
[  252.892008]  [<ffffffff81713ddb>] ? int_very_careful+0x5/0x46
[  252.892008]  [<ffffffff81003e75>] do_notify_resume+0x65/0x80
[  252.892008]  [<ffffffff81713e2e>] int_signal+0x12/0x17
