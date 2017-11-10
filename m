From: Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>
Subject: Re: DMAR global lock circular dependency
Date: Fri, 10 Nov 2017 14:36:54 +0900
Message-ID: <20171110143654.57c95649@shemminger-XPS-13-9360>
References: <20171109151718.60a38fba@shemminger-XPS-13-9360>
	<253293b5-d902-1239-d806-478df3061664@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <253293b5-d902-1239-d806-478df3061664-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 9 Nov 2017 14:05:56 +0000
Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> Hi Stephen,
> 
> On 09/11/17 06:17, Stephen Hemminger wrote:
> > Running kernel with lockdep on my XPS13 logs a locking error from the DMAR subsystem.
> > 
> > [   32.823763] ACPI: button: The lid device is not compliant to SW_LID.
> > [   32.844606] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400
> > [   32.844683] pci 0000:01:00.0: enabling Extended Tags
> > [   32.844828] pci 0000:01:00.0: supports D1 D2
> > [   32.844830] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > 
> > [   32.845168] ======================================================
> > [   32.845169] WARNING: possible circular locking dependency detected
> > [   32.845171] 4.14.0-rc7-net-next+ #9 Not tainted
> > [   32.845172] ------------------------------------------------------
> > [   32.845173] kworker/u8:2/99 is trying to acquire lock:
> > [   32.845174]  (dmar_global_lock){++++}, at: [<ffffffff8c04297e>] dmar_pci_bus_notifier+0x4e/0xe0
> > [   32.845180]
> >                 but task is already holding lock:
> > [   32.845181]  (&(&priv->bus_notifier)->rwsem){++++}, at: [<ffffffff8bac35b5>] __blocking_notifier_call_chain+0x35/0x70
> > [   32.845185]
> >                 which lock already depends on the new lock.  
> 
> This looks a lot like what Jan reported recently:
> 
> https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg20151.html
> 
> Does the patch from that thread (commit ec154bf56b27 in the current 
> linux-next tree) work for you?
> 
> Robin.
> 
> > 
> > [   32.845186]
> >                 the existing dependency chain (in reverse order) is:
> > [   32.845187]  
> >                 -> #1 (&(&priv->bus_notifier)->rwsem){++++}:  
> > [   32.845192]        lock_acquire+0xe3/0x1d0
> > [   32.845194]        down_write+0x40/0x70
> > [   32.845196]        blocking_notifier_chain_register+0x21/0xb0
> > [   32.845197]        bus_register_notifier+0x1c/0x20
> > [   32.845199]        dmar_dev_scope_init+0x2d6/0x2ff
> > [   32.845200]        intel_iommu_init+0x108/0x1377
> > [   32.845202]        pci_iommu_init+0x17/0x41
> > [   32.845203]        do_one_initcall+0x52/0x198
> > [   32.845206]        kernel_init_freeable+0x200/0x29c
> > [   32.845208]        kernel_init+0xe/0x100
> > [   32.845209]        ret_from_fork+0x2a/0x40
> > [   32.845210]  
> >                 -> #0 (dmar_global_lock){++++}:  
> > [   32.845214]        __lock_acquire+0x13c9/0x1400
> > [   32.845215]        lock_acquire+0xe3/0x1d0
> > [   32.845217]        down_write+0x40/0x70
> > [   32.845218]        dmar_pci_bus_notifier+0x4e/0xe0
> > [   32.845220]        notifier_call_chain+0x4a/0x70
> > [   32.845221]        __blocking_notifier_call_chain+0x4d/0x70
> > [   32.845222]        blocking_notifier_call_chain+0x16/0x20
> > [   32.845223]        device_add+0x370/0x650
> > [   32.845226]        pci_device_add+0x1b0/0x230
> > [   32.845227]        pci_scan_single_device+0xb3/0xd0
> > [   32.845229]        pci_scan_slot+0x52/0x110
> > [   32.845231]        acpiphp_rescan_slot+0x7f/0x90
> > [   32.845233]        enable_slot+0x41/0x310
> > [   32.845235]        acpiphp_check_bridge.part.7+0x102/0x150
> > [   32.845237]        acpiphp_hotplug_notify+0x14a/0x1e0
> > [   32.845238]        acpi_device_hotplug+0xa1/0x4c0
> > [   32.845240]        acpi_hotplug_work_fn+0x1e/0x30
> > [   32.845242]        process_one_work+0x26c/0x680
> > [   32.845243]        worker_thread+0x4b/0x410
> > [   32.845244]        kthread+0x114/0x150
> > [   32.845246]        ret_from_fork+0x2a/0x40
> > [   32.845247]
> >                 other info that might help us debug this:
> > 
> > [   32.845248]  Possible unsafe locking scenario:
> > 
> > [   32.845249]        CPU0                    CPU1
> > [   32.845250]        ----                    ----
> > [   32.845250]   lock(&(&priv->bus_notifier)->rwsem);
> > [   32.845252]                                lock(dmar_global_lock);
> > [   32.845253]                                lock(&(&priv->bus_notifier)->rwsem);
> > [   32.845254]   lock(dmar_global_lock);
> > [   32.845256]
> >                  *** DEADLOCK ***
> > 
> > [   32.845258] 6 locks held by kworker/u8:2/99:
> > [   32.845258]  #0:  ("kacpi_hotplug"){+.+.}, at: [<ffffffff8baba3a6>] process_one_work+0x1f6/0x680
> > [   32.845261]  #1:  ((&hpw->work)){+.+.}, at: [<ffffffff8baba3a6>] process_one_work+0x1f6/0x680
> > [   32.845264]  #2:  (device_hotplug_lock){+.+.}, at: [<ffffffff8c054a07>] lock_device_hotplug+0x17/0x20
> > [   32.845267]  #3:  (acpi_scan_lock){+.+.}, at: [<ffffffff8bf85b5c>] acpi_device_hotplug+0x3c/0x4c0
> > [   32.845269]  #4:  (pci_rescan_remove_lock){+.+.}, at: [<ffffffff8bf2d667>] pci_lock_rescan_remove+0x17/0x20
> > [   32.845272]  #5:  (&(&priv->bus_notifier)->rwsem){++++}, at: [<ffffffff8bac35b5>] __blocking_notifier_call_chain+0x35/0x70
> > [   32.845275]
> >                 stack backtrace:
> > [   32.845278] CPU: 2 PID: 99 Comm: kworker/u8:2 Not tainted 4.14.0-rc7-net-next+ #9
> > [   32.845278] Hardware name: Dell Inc. XPS 13 9360/05JK94, BIOS 1.3.2 01/18/2017
> > [   32.845282] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> > [   32.845283] Call Trace:
> > [   32.845287]  dump_stack+0x86/0xcf
> > [   32.845289]  print_circular_bug.isra.42+0x1e7/0x1f5
> > [   32.845292]  __lock_acquire+0x13c9/0x1400
> > [   32.845294]  ? __lock_acquire+0xd31/0x1400
> > [   32.845296]  lock_acquire+0xe3/0x1d0
> > [   32.845298]  ? lock_acquire+0xe3/0x1d0
> > [   32.845300]  ? dmar_pci_bus_notifier+0x4e/0xe0
> > [   32.845302]  down_write+0x40/0x70
> > [   32.845303]  ? dmar_pci_bus_notifier+0x4e/0xe0
> > [   32.845305]  dmar_pci_bus_notifier+0x4e/0xe0
> > [   32.845306]  notifier_call_chain+0x4a/0x70
> > [   32.845308]  __blocking_notifier_call_chain+0x4d/0x70
> > [   32.845310]  blocking_notifier_call_chain+0x16/0x20
> > [   32.845311]  device_add+0x370/0x650
> > [   32.845313]  pci_device_add+0x1b0/0x230
> > [   32.845315]  pci_scan_single_device+0xb3/0xd0
> > [   32.845317]  pci_scan_slot+0x52/0x110
> > [   32.845319]  acpiphp_rescan_slot+0x7f/0x90
> > [   32.845321]  enable_slot+0x41/0x310
> > [   32.845324]  ? pci_read+0x2c/0x30
> > [   32.845326]  ? pci_bus_read_config_dword+0x5a/0x70
> > [   32.845328]  ? get_slot_status+0xa3/0xe0
> > [   32.845330]  acpiphp_check_bridge.part.7+0x102/0x150
> > [   32.845332]  acpiphp_hotplug_notify+0x14a/0x1e0
> > [   32.845334]  ? free_bridge+0x120/0x120
> > [   32.845335]  acpi_device_hotplug+0xa1/0x4c0
> > [   32.845337]  acpi_hotplug_work_fn+0x1e/0x30
> > [   32.845339]  process_one_work+0x26c/0x680
> > [   32.845341]  worker_thread+0x4b/0x410
> > [   32.845343]  kthread+0x114/0x150
> > [   32.845344]  ? process_one_work+0x680/0x680
> > [   32.845346]  ? kthread_create_on_node+0x70/0x70
> > [   32.845347]  ? kthread_create_on_node+0x70/0x70
> > [   32.845349]  ret_from_fork+0x2a/0x40
> > [   32.845555] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400
> > [   32.845621] pci 0000:02:00.0: enabling Extended Tags
> > [   32.845711] pci 0000:02:00.0: supports D1 D2
> > _______________________________________________
> > iommu mailing list
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >   

Yes this looks the same problem. Don't want to bother cherry-picking now.
I will retest after 4.15-rc1 and make sure the patch fixed it.
