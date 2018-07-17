From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: usb HC busted?
Date: Tue, 17 Jul 2018 14:04:11 +0200
Message-ID: <20180717120411.GB28592@kroah.com>
References: <42ec4ab07d96b4302b875ac9c5eb76675bf85690.camel@linux.intel.com>
	<20180606164524.n4vb7xre6rykzxih@debian>
	<2e8829c2-850d-6bca-5f0c-58a809dc9499@linux.intel.com>
	<20180621005332.5uy74tkjoel6w4xy@debian>
	<2b4fe87a-3706-0aa8-2b61-a9c1d1352a7a@linux.intel.com>
	<20180625161500.dbyxd4b434jh5jhj@debian>
	<20180627115948.ww534mkoovkt3uwb@debian>
	<4b269009-7593-a41f-9f0f-203ee174b52e@linux.intel.com>
	<20180630210704.vzkt2poh5qr3hpff@debian>
	<20180717114104.irgdb5rmg2qxclgp@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180717114104.irgdb5rmg2qxclgp@debian>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 17, 2018 at 12:41:04PM +0100, Sudip Mukherjee wrote:
> Hi Mathias,
> 
> On Sat, Jun 30, 2018 at 10:07:04PM +0100, Sudip Mukherjee wrote:
> > Hi Mathias,
> > 
> > On Fri, Jun 29, 2018 at 02:41:13PM +0300, Mathias Nyman wrote:
> > > On 27.06.2018 14:59, Sudip Mukherjee wrote:
> > > > > > Can you share a bit more details on the platform you are using, and what types of test you are running.
> > > > > 
> <snip>
> > Then to track what is going on, I added the slub debugging and :(
> > I have attached part of dmesg for you to check.
> > Will appreciate your help in finding out the problem.
> 
> I did some more debugging. Tested with a KASAN enabled kernel and that
> shows the problem. The report is attached.
> 
> To my understanding:
> 
> btusb_work() is calling usb_set_interface() with alternate = 0. which
> again calls usb_hcd_alloc_bandwidth() and that frees the rings by
> xhci_free_endpoint_ring(). But then usb_set_interface() continues and
> calls usb_disable_interface() -> usb_hcd_flush_endpoint()->unlink1()->
> xhci_urb_dequeue() which at the end gives the command to stop endpoint.
> 
> In all the cycles I have tested I see that only in the fail case
> handle_cmd_completion() gets called, but in the cycles where the error
> is not there handle_cmd_completion() is not called with that command.
> 
> I am not sure what is happening, and you are the best person to understand
> what is happening. :)
> 
> But for now (untill you are back from holiday and suggest a proper solution),
> I made a hacky patch (attached) which is working and I donot get any
> corruption after that. Both KASAN and slub debug are also happy.
> 
> So, now waiting for you to analyze what is going on and suggest a proper
> fix.
> 
> Thanks in advance.
> 
> --
> Regards
> Sudip

> [  236.814156] ==================================================================
> [  236.814187] BUG: KASAN: use-after-free in xhci_trb_virt_to_dma+0x2e/0x74 [xhci_hcd]
> [  236.814193] Read of size 8 at addr ffff8800789329c8 by task weston/138
> 
> [  236.814203] CPU: 0 PID: 138 Comm: weston Tainted: G     U  W  O    4.14.47-20180606+ #7
> [  236.814206] Hardware name: xxx, BIOS 2017.01-00087-g43e04de 08/30/2017
> [  236.814209] Call Trace:
> [  236.814214]  <IRQ>
> [  236.814226]  dump_stack+0x46/0x59
> [  236.814238]  print_address_description+0x6b/0x23b
> [  236.814255]  ? xhci_trb_virt_to_dma+0x2e/0x74 [xhci_hcd]
> [  236.814262]  kasan_report+0x220/0x246
> [  236.814278]  xhci_trb_virt_to_dma+0x2e/0x74 [xhci_hcd]
> [  236.814294]  trb_in_td+0x3b/0x1cd [xhci_hcd]
> [  236.814311]  handle_cmd_completion+0x1181/0x2c9b [xhci_hcd]
> [  236.814329]  ? xhci_queue_new_dequeue_state+0x5d9/0x5d9 [xhci_hcd]
> [  236.814337]  ? drm_handle_vblank+0x4ec/0x590
> [  236.814352]  xhci_irq+0x529/0x3294 [xhci_hcd]
> [  236.814362]  ? __accumulate_pelt_segments+0x24/0x33
> [  236.814378]  ? finish_td.isra.40+0x223/0x223 [xhci_hcd]
> [  236.814384]  ? __accumulate_pelt_segments+0x24/0x33
> [  236.814390]  ? __accumulate_pelt_segments+0x24/0x33
> [  236.814405]  ? xhci_irq+0x3294/0x3294 [xhci_hcd]
> [  236.814412]  __handle_irq_event_percpu+0x149/0x3db
> [  236.814421]  handle_irq_event_percpu+0x65/0x109
> [  236.814428]  ? __handle_irq_event_percpu+0x3db/0x3db
> [  236.814436]  ? ttwu_do_wakeup.isra.18+0x3a2/0x3ce
> [  236.814442]  handle_irq_event+0xa8/0x10a
> [  236.814449]  handle_edge_irq+0x4b2/0x538
> [  236.814458]  handle_irq+0x3e/0x45
> [  236.814465]  do_IRQ+0x5c/0x126
> [  236.814474]  common_interrupt+0x7a/0x7a
> [  236.814478]  </IRQ>
> [  236.814483] RIP: 0023:0xf79d3d82
> [  236.814486] RSP: 002b:00000000ffc588e8 EFLAGS: 00200282 ORIG_RAX: ffffffffffffffdc
> [  236.814493] RAX: 0000000000000000 RBX: 00000000f7bebd5c RCX: 0000000000000000
> [  236.814496] RDX: 0000000008d4197c RSI: 0000000000000000 RDI: 00000000f746c020
> [  236.814499] RBP: 00000000ffc588e8 R08: 0000000000000000 R09: 0000000000000000
> [  236.814503] R10: 0000000000000000 R11: 0000000000200206 R12: 0000000000000000
> [  236.814506] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> [  236.814513] Allocated by task 2082:
> [  236.814521]  kasan_kmalloc.part.1+0x51/0xc7
> [  236.814526]  kmem_cache_alloc_trace+0x178/0x187
> [  236.814540]  xhci_segment_alloc.isra.11+0x9d/0x3bf [xhci_hcd]
> [  236.814553]  xhci_alloc_segments_for_ring+0x9e/0x176 [xhci_hcd]
> [  236.814566]  xhci_ring_alloc.constprop.16+0x197/0x4ba [xhci_hcd]
> [  236.814579]  xhci_endpoint_init+0x77a/0x9ba [xhci_hcd]
> [  236.814592]  xhci_add_endpoint+0x3bc/0x43b [xhci_hcd]
> [  236.814615]  usb_hcd_alloc_bandwidth+0x7ef/0x857 [usbcore]
> [  236.814637]  usb_set_interface+0x294/0x681 [usbcore]
> [  236.814645]  btusb_work+0x2e6/0x981 [btusb]
> [  236.814651]  process_one_work+0x579/0x9e9
> [  236.814656]  worker_thread+0x68f/0x804
> [  236.814662]  kthread+0x31c/0x32b
> [  236.814668]  ret_from_fork+0x35/0x40
> 
> [  236.814672] Freed by task 1533:
> [  236.814678]  kasan_slab_free+0xb3/0x15e
> [  236.814683]  kfree+0x103/0x1a9
> [  236.814696]  xhci_ring_free+0x205/0x286 [xhci_hcd]
> [  236.814709]  xhci_free_endpoint_ring+0x4d/0x83 [xhci_hcd]
> [  236.814722]  xhci_check_bandwidth+0x57b/0x65a [xhci_hcd]
> [  236.814743]  usb_hcd_alloc_bandwidth+0x665/0x857 [usbcore]
> [  236.814765]  usb_set_interface+0x294/0x681 [usbcore]
> [  236.814772]  btusb_work+0x664/0x981 [btusb]
> [  236.814777]  process_one_work+0x579/0x9e9
> [  236.814782]  worker_thread+0x68f/0x804
> [  236.814788]  kthread+0x31c/0x32b
> [  236.814793]  ret_from_fork+0x35/0x40
> 
> [  236.814799] The buggy address belongs to the object at ffff8800789329c8
>  which belongs to the cache kmalloc-64 of size 64
> [  236.814804] The buggy address is located 0 bytes inside of
>  64-byte region [ffff8800789329c8, ffff880078932a08)
> [  236.814806] The buggy address belongs to the page:
> [  236.814812] page:ffffea0001e24c80 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
> [  236.825813] flags: 0x4000000000008100(slab|head)
> [  236.830981] raw: 4000000000008100 0000000000000000 0000000000000000 0000000100130013
> [  236.830988] raw: ffffea0000cfbaa0 ffffea00010ddf20 ffff88013b80f640 0000000000000000
> [  236.830990] page dumped because: kasan: bad access detected
> 
> [  236.830993] Memory state around the buggy address:
> [  236.830999]  ffff880078932880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  236.831004]  ffff880078932900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  236.831008] >ffff880078932980: fc fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb
> [  236.831011]                                               ^
> [  236.831015]  ffff880078932a00: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  236.831019]  ffff880078932a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  236.831021] ==================================================================
> [  236.831024] Disabling lock debugging due to kernel taint

> >From cbbe6dc59ac90a4f2c358de56e58e254320171e0 Mon Sep 17 00:00:00 2001
> From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date: Tue, 10 Jul 2018 09:50:00 +0100
> Subject: [PATCH] hacky solution to mem-corruption
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/core/message.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 7cd4ec33dbf4..7fdf7a27611d 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1398,7 +1398,8 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
>  		remove_intf_ep_devs(iface);
>  		usb_remove_sysfs_intf_files(iface);
>  	}
> -	usb_disable_interface(dev, iface, true);
> +	if (!(iface->cur_altsetting && alt))
> +		usb_disable_interface(dev, iface, true);



This feels like a "correct" patch anyway, why would a driver keep
calling set_interface to an interface that it was already set to?

But can't we check for this higher up in the function?  This hack will
just not disable an interface but it will do all of the other stuff
being asked for.  Does the patch below also solve this for you?  It's
not a good solution of course, but it might work around the problem a
bit better.

thanks,

greg k-h

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 1a15392326fc..0f718f1a1ca3 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1376,6 +1376,14 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
 		return -EINVAL;
 	}
 
+	if (iface->cur_altsetting == alt) {
+		/*
+		 * foolish bluetooth stack, don't try to set a setting you are
+		 * already set to...
+		 */
+		return 0;
+	}
+
 	/* Make sure we have enough bandwidth for this alternate interface.
 	 * Remove the current alt setting and add the new alt setting.
 	 */
