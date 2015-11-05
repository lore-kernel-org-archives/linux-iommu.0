From: Jinpu Wang <jinpu.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Subject: Re: [RFI] Watchdog detected hard LOCKUP on alloc_iova
Date: Thu, 5 Nov 2015 17:47:08 +0100
Message-ID: <CAMGffE=a0=_+jsJaFn=PcM8eqhbmxUaj-Fa=ocUit0MeqHkTpw@mail.gmail.com>
References: <CAMGffEnuCpptLphnh6VcahZrTnckMH=GrzE6k9tUnwEPK=dk-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMGffEnuCpptLphnh6VcahZrTnckMH=GrzE6k9tUnwEPK=dk-g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Christian Zander <christian-dt00mrq0sMmU+1/U8MakDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 4, 2015 at 11:08 AM, Jinpu Wang <jinpu.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org> wrote:
> Hi David,
>
> We hit the warning during test:
>
> Oct 19 15:23:20 storage9-qa kernel: [  638.139722] ------------[ cut
> here ]------------
> Oct 19 15:23:20 storage9-qa kernel: [  638.139730] WARNING: CPU: 5
> PID: 1281 at kernel/watchdog.c:290
> watchdog_overflow_callback+0x98/0xc0()
> Oct 19 15:23:20 storage9-qa kernel: [  638.139731] Watchdog detected
> hard LOCKUP on cpu 5
> Oct 19 15:23:20 storage9-qa kernel: [  638.139732] Modules linked in:
> ibnbd_server(O) ibtrs_server(O) rdma_ucm rdma_cm iw_cm ib_ipoib ib_cm
> ib_uverbs ib_umad mlx4_ib ib_sa ib_mad ib_core ib_addr mlx4_core ipv6
> hid_generic usbhid ipmi_devintf loop null_blk brd sb_edac edac_core
> i2c_i801 i2c_core ehci_pci ehci_hcd ioatdma ipmi_si dca
> ipmi_msghandler button dm_mod sg ahci libahci e1000e libata [last
> unloaded: mlx4_core]
> Oct 19 15:23:20 storage9-qa kernel: [  638.139754] CPU: 5 PID: 1281
> Comm: kworker/u16:2 Tainted: G           O   3.18.21-1-storage #1
> Oct 19 15:23:20 storage9-qa kernel: [  638.139755] Hardware name:
> Supermicro X9SRL-F/X9SRL-F, BIOS 3.2 01/16/2015
> Oct 19 15:23:20 storage9-qa kernel: [  638.139759] Workqueue: ib_mad1
> ib_post_send_mad [ib_mad]
> Oct 19 15:23:20 storage9-qa kernel: [  638.139761]  0000000000000122
> ffff88047fd46ba8 ffffffff815c3e55 0000000000000122
> Oct 19 15:23:20 storage9-qa kernel: [  638.139763]  ffff88047fd46bf8
> ffff88047fd46be8 ffffffff8105360c 0000000000000000
> Oct 19 15:23:20 storage9-qa kernel: [  638.139765]  ffff8804692e0000
> 0000000000000000 ffff88047fd46d28 0000000000000000
> Oct 19 15:23:20 storage9-qa kernel: [  638.139767] Call Trace:
> Oct 19 15:23:20 storage9-qa kernel: [  638.139768]  <NMI>
> [<ffffffff815c3e55>] dump_stack+0x49/0x5c
> Oct 19 15:23:20 storage9-qa kernel: [  638.139775]
> [<ffffffff8105360c>] warn_slowpath_common+0x8c/0xc0
> Oct 19 15:23:20 storage9-qa kernel: [  638.139777]
> [<ffffffff810536f6>] warn_slowpath_fmt+0x46/0x50
> Oct 19 15:23:20 storage9-qa kernel: [  638.139779]
> [<ffffffff810dcdf8>] watchdog_overflow_callback+0x98/0xc0
> Oct 19 15:23:20 storage9-qa kernel: [  638.139782]
> [<ffffffff81117d5c>] __perf_event_overflow+0x9c/0x220
> Oct 19 15:23:20 storage9-qa kernel: [  638.139785]
> [<ffffffff81018a0a>] ? x86_perf_event_set_period+0xda/0x170
> Oct 19 15:23:20 storage9-qa kernel: [  638.139788]
> [<ffffffff81118614>] perf_event_overflow+0x14/0x20
> Oct 19 15:23:20 storage9-qa kernel: [  638.139790]
> [<ffffffff81020b62>] intel_pmu_handle_irq+0x202/0x3f0
> Oct 19 15:23:20 storage9-qa kernel: [  638.139793]
> [<ffffffff8115a381>] ? unmap_kernel_range_noflush+0x11/0x20
> Oct 19 15:23:20 storage9-qa kernel: [  638.139797]
> [<ffffffff8139613d>] ? ghes_copy_tofrom_phys+0xfd/0x1f0
> Oct 19 15:23:20 storage9-qa kernel: [  638.139799]
> [<ffffffff810180b4>] perf_event_nmi_handler+0x34/0x60
> Oct 19 15:23:20 storage9-qa kernel: [  638.139802]
> [<ffffffff8100c2b3>] ? native_sched_clock+0x33/0xd0
> Oct 19 15:23:20 storage9-qa kernel: [  638.139804]
> [<ffffffff81006bfb>] nmi_handle+0x7b/0x120
> Oct 19 15:23:20 storage9-qa kernel: [  638.139806]
> [<ffffffff81006eb4>] default_do_nmi+0x54/0x110
> Oct 19 15:23:20 storage9-qa kernel: [  638.139808]
> [<ffffffff81007000>] do_nmi+0x90/0xd0
> Oct 19 15:23:20 storage9-qa kernel: [  638.139811]
> [<ffffffff815ca781>] end_repeat_nmi+0x1e/0x2e
> Oct 19 15:23:20 storage9-qa kernel: [  638.139814]
> [<ffffffff81310347>] ? rb_prev+0x27/0x60
> Oct 19 15:23:20 storage9-qa kernel: [  638.139815]
> [<ffffffff81310347>] ? rb_prev+0x27/0x60
> Oct 19 15:23:20 storage9-qa kernel: [  638.139817]
> [<ffffffff81310347>] ? rb_prev+0x27/0x60
> Oct 19 15:23:20 storage9-qa kernel: [  638.139818]  <<EOE>>
> [<ffffffff815056f6>] alloc_iova+0xc6/0x220
> Oct 19 15:23:20 storage9-qa kernel: [  638.139823]
> [<ffffffff81507cf5>] intel_alloc_iova+0xb5/0xf0
> Oct 19 15:23:20 storage9-qa kernel: [  638.139825]
> [<ffffffff8150a887>] __intel_map_single+0xb7/0x230
> Oct 19 15:23:20 storage9-qa kernel: [  638.139828]
> [<ffffffff8150aa39>] intel_map_page+0x39/0x40
> Oct 19 15:23:20 storage9-qa kernel: [  638.139830]
> [<ffffffffa00c7fc4>] ib_send_mad+0x274/0x770 [ib_mad]
> Oct 19 15:23:20 storage9-qa kernel: [  638.139833]
> [<ffffffffa00c9c28>] ib_post_send_mad+0xae8/0x1990 [ib_mad]
> Oct 19 15:23:20 storage9-qa kernel: [  638.139836]
> [<ffffffff8106a6a5>] process_one_work+0x145/0x450
> Oct 19 15:23:20 storage9-qa kernel: [  638.139838]
> [<ffffffff8106aace>] worker_thread+0x11e/0x4f0
> Oct 19 15:23:20 storage9-qa kernel: [  638.139840]
> [<ffffffff815c42d9>] ? __schedule+0x369/0x880
> Oct 19 15:23:20 storage9-qa kernel: [  638.139842]
> [<ffffffff8106a9b0>] ? process_one_work+0x450/0x450
> Oct 19 15:23:20 storage9-qa kernel: [  638.139844]
> [<ffffffff8106fa5e>] kthread+0xce/0x100
> Oct 19 15:23:20 storage9-qa kernel: [  638.139847]
> [<ffffffff8106f990>] ? kthread_freezable_should_stop+0x70/0x70
> Oct 19 15:23:20 storage9-qa kernel: [  638.139849]
> [<ffffffff815c8758>] ret_from_fork+0x58/0x90
> Oct 19 15:23:20 storage9-qa kernel: [  638.139851]
> [<ffffffff8106f990>] ? kthread_freezable_should_stop+0x70/0x70
> Oct 19 15:23:20 storage9-qa kernel: [  638.139853] ---[ end trace
> 36c298c3dad5c3f5 ]---
>
> gdb show last call:
> gdb) list *alloc_iova+0xc6
> 0xffffffff815056f6 is in alloc_iova (drivers/iommu/iova.c:107).
> 102 /* Walk the tree backwards */
> 103 spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> 104 saved_pfn = limit_pfn;
> 105 curr = __get_cached_rbnode(iovad, &limit_pfn);
> 106 prev = curr;
> 107 while (curr) {
> 108 struct iova *curr_iova = container_of(curr, struct iova, node);
> 109
> 110 if (limit_pfn < curr_iova->pfn_lo)
> 111 goto move_left;
> 112 else if (limit_pfn < curr_iova->pfn_hi)
> 113 goto adjust_limit_pfn;
> 114 else
> { 115 if (size_aligned) 116 pad_size = iova_get_pad_size(size,
> limit_pfn); 117 if ((curr_iova->pfn_hi + size + pad_size) <=
> limit_pfn) 118 break; /* found a free slot */ 119 }
> 120 adjust_limit_pfn:
> 121 limit_pfn = curr_iova->pfn_lo - 1;
> 122 move_left:
> 123 prev = curr;
> 124 curr = rb_prev(curr);
> 125 }
> (gdb)
>
> so looks it's loop for very long time with lock hold.
>
> I checked the git log no bugfix for this, IMHO, but maybe I miss something.
>
> This happen with the fix from Christan (commit:ba2374fd iommu/vt-d:
> fix range computation when making room for large pages) on top of
> 3.18.21.
>
> It also happened when we pass kernel parameter "intel_iommu=sp_off"
>
> Looking forward to your input.
>

I found one thing a little strange:

during unmap:
1 by default: intel iommu do batch flush which check both WATER_MARK
and timer (10 ms to flush the mapping), the timer and WATER_MARK check
only happened in unmap.
2 if intel_iommu_strict is enabled, it will flush and release iova directly.
In our test case, we we only map the session memory pool, we hasn't
call unmap yet, maybe this is why map was hang, I guess enable
intel_iommu_strict will not help, maybe could fix by start the timer
in map not only when unmap

Regards,
Jack
