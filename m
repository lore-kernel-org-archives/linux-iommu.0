From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb HC busted?
Date: Thu, 19 Jul 2018 18:32:56 +0100
Message-ID: <20180719173256.hc5aprma4biuqd4p@debian>
References: <20180717114104.irgdb5rmg2qxclgp@debian>
	<Pine.LNX.4.44L0.1807171022001.1689-100000@iolanthe.rowland.org>
	<20180717144022.4wabhdhysori3mvg@debian>
	<20180717144918.7ymzbhijxfcc3fhb@debian>
	<20180717151017.yk5d4glzwqcrxpqc@debian>
	<f7801c24-fa98-6338-0b26-33a0ac9498bb@linux.intel.com>
	<20180719113455.urktqxijzoyhfoou@debian>
	<ab814c88-0857-5444-57da-34c21b8d7f6c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ab814c88-0857-5444-57da-34c21b8d7f6c-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Mathias,

On Thu, Jul 19, 2018 at 06:42:19PM +0300, Mathias Nyman wrote:
> > > As first aid I could try to implement checks that make sure the flushed URBs
> > > trb pointers really are on the current endpoint ring, and also add some warning
> > > if we are we are dropping endpoints with URBs still queued.
> > 
> > Yes, please. I think your first-aid will be a much better option than
> > the hacky patch I am using atm.
> > 
> 
> Attached a patch that checks canceled URB td/trb pointers.
> I haven't tested it at all (well compiles and boots, but new code never exercised)
> 
> Does it work for you?

No, not exactly. :(

I can see your message getting printed.
[  249.518394] xhci_hcd 0000:00:14.0: Canceled URB td not found on endpoint ring
[  249.518431] xhci_hcd 0000:00:14.0: Canceled URB td not found on endpoint ring

But I can see the message from slub debug again:

[  348.279986] =============================================================================
[  348.279993] BUG kmalloc-96 (Tainted: G     U     O   ): Poison overwritten
[  348.279995] -----------------------------------------------------------------------------

[  348.279997] Disabling lock debugging due to kernel taint
[  348.280000] INFO: 0xe5acda60-0xe5acda67. First byte 0x60 instead of 0x6b
[  348.280012] INFO: Allocated in xhci_ring_alloc.constprop.14+0x31/0x125 [xhci_hcd] age=129264 cpu=0 pid=33
[  348.280019] 	___slab_alloc.constprop.24+0x1fc/0x292
[  348.280023] 	__slab_alloc.isra.18.constprop.23+0x1c/0x25
[  348.280026] 	kmem_cache_alloc_trace+0x78/0x141
[  348.280032] 	xhci_ring_alloc.constprop.14+0x31/0x125 [xhci_hcd]
[  348.280038] 	xhci_endpoint_init+0x25f/0x30a [xhci_hcd]
[  348.280044] 	xhci_add_endpoint+0x126/0x149 [xhci_hcd]
[  348.280057] 	usb_hcd_alloc_bandwidth+0x26a/0x2a0 [usbcore]
[  348.280067] 	usb_set_interface+0xeb/0x25d [usbcore]
[  348.280071] 	btusb_work+0xeb/0x324 [btusb]
[  348.280076] 	process_one_work+0x163/0x2b2
[  348.280080] 	worker_thread+0x1a9/0x25c
[  348.280083] 	kthread+0xf8/0xfd
[  348.280087] 	ret_from_fork+0x2e/0x38
[  348.280095] INFO: Freed in xhci_ring_free+0xa7/0xc6 [xhci_hcd] age=98722 cpu=0 pid=33
[  348.280098] 	__slab_free+0x4b/0x27a
[  348.280100] 	kfree+0x12e/0x155
[  348.280106] 	xhci_ring_free+0xa7/0xc6 [xhci_hcd]
[  348.280112] 	xhci_free_endpoint_ring+0x16/0x20 [xhci_hcd]
[  348.280118] 	xhci_check_bandwidth+0x1c2/0x211 [xhci_hcd]
[  348.280129] 	usb_hcd_alloc_bandwidth+0x205/0x2a0 [usbcore]
[  348.280139] 	usb_set_interface+0xeb/0x25d [usbcore]
[  348.280142] 	btusb_work+0x228/0x324 [btusb]
[  348.280145] 	process_one_work+0x163/0x2b2
[  348.280148] 	worker_thread+0x1a9/0x25c
[  348.280151] 	kthread+0xf8/0xfd
[  348.280154] 	ret_from_fork+0x2e/0x38
[  348.280158] INFO: Slab 0xf46e0fe0 objects=29 used=29 fp=0x  (null) flags=0x40008100
[  348.280160] INFO: Object 0xe5acda48 @offset=6728 fp=0xe5acd700

[  348.280164] Redzone e5acda40: bb bb bb bb bb bb bb bb                          ........
[  348.280167] Object e5acda48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  348.280169] Object e5acda58: 6b 6b 6b 6b 6b 6b 6b 6b 60 da ac e5 60 da ac e5  kkkkkkkk`...`...
[  348.280171] Object e5acda68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  348.280174] Object e5acda78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  348.280176] Object e5acda88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  348.280179] Object e5acda98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
[  348.280181] Redzone e5acdaa8: bb bb bb bb                                      ....
[  348.280183] Padding e5acdb50: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
[  348.280188] CPU: 0 PID: 133 Comm: weston Tainted: G    BU     O    4.14.55-20180712+ #2
[  348.280190] Hardware name: xxx, BIOS 2017.01-00087-g43e04de 08/30/2017
[  348.280192] Call Trace:
[  348.280199]  dump_stack+0x47/0x5b
[  348.280202]  print_trailer+0x12b/0x133
[  348.280206]  check_bytes_and_report+0x6c/0xae
[  348.280210]  check_object+0x10a/0x1db
[  348.280214]  alloc_debug_processing+0x79/0x123
[  348.280218]  ___slab_alloc.constprop.24+0x1fc/0x292
[  348.280224]  ? drm_mode_atomic_ioctl+0x374/0x75e
[  348.280227]  ? drm_mode_atomic_ioctl+0x374/0x75e
[  348.280231]  ? drm_mode_object_get+0x28/0x3a
[  348.280235]  ? __radix_tree_lookup+0x27/0x7e
[  348.280238]  ? drm_mode_object_get+0x28/0x3a
[  348.280242]  ? drm_mode_object_put+0x28/0x4c
[  348.280246]  __slab_alloc.isra.18.constprop.23+0x1c/0x25
[  348.280249]  ? __slab_alloc.isra.18.constprop.23+0x1c/0x25
[  348.280253]  kmem_cache_alloc_trace+0x78/0x141
[  348.280257]  ? drm_mode_atomic_ioctl+0x374/0x75e
[  348.280261]  drm_mode_atomic_ioctl+0x374/0x75e
[  348.280267]  ? drm_atomic_set_property+0x442/0x442
[  348.280272]  drm_ioctl_kernel+0x52/0x88
[  348.280275]  drm_ioctl+0x1fc/0x2c1
[  348.280279]  ? drm_atomic_set_property+0x442/0x442
[  348.280288]  ? xhci_irq+0x109f/0x10a9 [xhci_hcd]
[  348.280293]  ? __fget+0x5f/0x67
[  348.280297]  ? drm_getstats+0x17/0x17
[  348.280301]  vfs_ioctl+0x1f/0x29
[  348.280304]  do_vfs_ioctl+0x4f3/0x562
[  348.280309]  ? smk_curacc+0x24/0x29
[  348.280314]  ? smack_file_ioctl+0x4d/0x52
[  348.280317]  ? smack_file_lock+0x29/0x29
[  348.280321]  ? security_file_ioctl+0x34/0x45
[  348.280324]  SyS_ioctl+0x42/0x5b
[  348.280328]  do_fast_syscall_32+0xd3/0x171
[  348.280333]  entry_SYSENTER_32+0x47/0x71
[  348.280336] EIP: 0xb7eedab1
[  348.280338] EFLAGS: 00200286 CPU: 0
[  348.280340] EAX: ffffffda EBX: 0000000f ECX: c03864bb EDX: bfeb2228
[  348.280342] ESI: bfeb2228 EDI: c03864bb EBP: bfeb21c8 ESP: bfeb2188
[  348.280345]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  348.280350] FIX kmalloc-96: Restoring 0xe5acda60-0xe5acda67=0x6b

--
Regards
Sudip
