From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Hang (due to HW?) in qi_submit_sync()
Date: Mon, 05 Jan 2015 19:54:20 -0700
Message-ID: <1420512860.3541.77.camel@redhat.com>
References: <1420505840-30096-1-git-send-email-roland@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1420505840-30096-1-git-send-email-roland-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Roland Dreier <roland-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-01-05 at 16:57 -0800, Roland Dreier wrote:
> From: Roland Dreier <roland-BHEL68pLQRGGvPXPguhicg@public.gmane.org>
> 
> Hi, we're running kernel 3.10.59 (pretty recent long-term kernel) on a
> 2-socket Xeon E5 v3 (Haswell) system.  We're using vfio to access some
> PCI devices from userspace, and occasionally when we kill a process,
> we see the system hang in qi_submit_sync().
> 
> Based on a very old patch from Intel <https://lkml.org/lkml/2009/5/20/341>,
> we added code to the dmar driver:
> 
> int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu )
> {
> 
> //...
> 
> 	/*
> 	 * update the HW tail register indicating the presence of
> 	 * new descriptors.
> 	 */
> 	writel(qi->free_head << DMAR_IQ_SHIFT, iommu->reg + DMAR_IQT_REG);
> 
> 	start_time = get_cycles();
> 	while (qi->desc_status[wait_index] != QI_DONE) {
> 		/*
> 		 * We will leave the interrupts disabled, to prevent interrupt
> 		 * context to queue another cmd while a cmd is already submitted
> 		 * and waiting for completion on this cpu. This is to avoid
> 		 * a deadlock where the interrupt context can wait indefinitely
> 		 * for free slots in the queue.
> 		 */
> 		rc = qi_check_fault(iommu, index);
> 		if (rc)
> 			break;
> 
> 		raw_spin_unlock(&qi->q_lock);
> 
> // We added this -->
> 		if (get_cycles() - start_time > DMAR_OPERATION_TIMEOUT) {
> 			printk(KERN_EMERG "desc_status[%d] = %d.\n",
> 			       wait_index, qi->desc_status[wait_index]);
> /* line 888: */		BUG();
> 		}
> // <-- to here
> 
> 		cpu_relax();
> 		raw_spin_lock(&qi->q_lock);
> 	}
> 
> and indeed when the system hangs, we see for example
> 
>     desc_status[69] = 1.
>     ------------[ cut here ]------------
>     kernel BUG at drivers/iommu/dmar.c:888!
>     CPU: 8 PID: 12211 Comm: foed Tainted: P           O 3.10.59+ #201412290537+4e4984e.platinum
>     task: ffff88275ac643e0 ti: ffff8825d329a000 task.ti: ffff8825d329a000
>     RIP: 0010:[<ffffffff81529737>]  [<ffffffff81529737>] qi_submit_sync+0x3f7/0x490
>     RSP: 0018:ffff8825d329ba10  EFLAGS: 00010092
>     RAX: 0000000000000014 RBX: 0000000000000044 RCX: ffff881fffb0ec00
>     RDX: 0000000000000000 RSI: ffff881fffb0d048 RDI: 0000000000000046
>     RBP: ffff8825d329ba78 R08: ffffffffffffffff R09: 000000000001a4a1
>     R10: 0000000000000051 R11: 00000000000000e4 R12: 00007068faa64fc8
>     R13: ffff881fff40c780 R14: 0000000000000114 R15: ffff883ffec01a00
>     FS:  00007f3c86ffb700(0000) GS:ffff881fffb00000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 00007f996d3f1ba0 CR3: 00000026222f0000 CR4: 00000000001407e0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>     Stack:
>      ffff8825d329ba88 0000000000000450 0000000000000440 ffff881ff3215000
>      00000044d329bb18 0000000000000086 0000000000000044 ffff882500000045
>      ffff881ff12b1600 0000000000000000 0000000000000246 ffff881ff278e858
>     Call Trace:
>      [<ffffffff8152f6b5>] free_irte+0xc5/0x100
>      [<ffffffff81530834>] free_remapped_irq+0x44/0x60
>      [<ffffffff81027b23>] destroy_irq+0x33/0xd0
>      [<ffffffff81027ede>] native_teardown_msi_irq+0xe/0x10
>      [<ffffffff812a6a70>] default_teardown_msi_irqs+0x60/0x80
>      [<ffffffff812a64d9>] free_msi_irqs+0x99/0x150
>      [<ffffffff812a749d>] pci_disable_msix+0x3d/0x60
>      [<ffffffffa0078748>] vfio_msi_disable+0xc8/0xe0 [vfio_pci]
>      [<ffffffffa0078f86>] vfio_pci_set_msi_trigger+0x2a6/0x2d0 [vfio_pci]
>      [<ffffffffa007941c>] vfio_pci_set_irqs_ioctl+0x8c/0xa0 [vfio_pci]
>      [<ffffffffa00773b0>] vfio_pci_release+0x70/0x150 [vfio_pci]
>      [<ffffffffa006dcbc>] vfio_device_fops_release+0x1c/0x40 [vfio]
>      [<ffffffff8114d7db>] __fput+0xdb/0x220
>      [<ffffffff8114d92e>] ____fput+0xe/0x10
>      [<ffffffff810614ac>] task_work_run+0xbc/0xe0
>      [<ffffffff81043d0e>] do_exit+0x3ce/0xe50
>      [<ffffffff8104557f>] do_group_exit+0x3f/0xa0
>      [<ffffffff81054769>] get_signal_to_deliver+0x1a9/0x5b0
>      [<ffffffff810023f8>] do_signal+0x48/0x5e0
> 
> as far as I can understand the driver, this is a "shouldn't happen,
> your hardware is broken" occurrence.  However I haven't been able to
> find any relevant looking sightings for our CPU.
> 
> Does anyone from Intel (or elsewhere) have any suggestions on how to
> chase this further?

Try disabling CONFIG_NET_DMA
