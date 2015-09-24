From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/10] Fix AMD IOMMU faults in kdump kernel
Date: Thu, 24 Sep 2015 14:37:26 +0800
Message-ID: <1443076656-31776-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a draft patchset trying to fix the issue that AMD IOMMU doesn't
work well in kdump kernel. The patch arrangement is not foraml, just
presenting what I have done and what's the problem being encountered
currently.


It contains 3 parts.

1) Clean up patch
  Patch 1/10, 2/10, 3/10 are code clean up patches, which later part will
  be based on.

2) IO page mapping
  Patch 4/10 ~ 9/10
 .> Checking if it's in kdump kernel and previously enabled
 .> If yes do below operatons:
        .> Do not disable amd iommu and do not touch dev tables before coping old dev tables
        .> Copy dev table form old kernel and set the old domain id in amd_iommu_pd_alloc_bitmap
        .> Don't call update_domain() to set domain->pt_root to dev entries before device driver initialization. 
        .> Reset the pre-enabled status when the first __map_single() is called during device driver init

3)interrupt remapping
  Patch 10/10
 .> I didn't think of this well. Now I only copy the old irq table when it first calls get_irq_table().
  This need people's suggestion. Maybe not correct old irq table copy cause kdump kernel hang.

Now there are several problems I got:
Now there's always a hang when go into kdump kernel so that I can't test
futher if command buffer/envent buffer need be copied and where flush need
be called.

Kdump kernel hang and dump the call trace to show it happened in check_timer.
This is similar as people found when they debugged intel iommu issue.
http://lists.infradead.org/pipermail/kexec/2014-December/013137.html

[   12.296525] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[   12.302513] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0+ #18
[   12.308500] Hardware name: AMD Dinar/Dinar, BIOS RDN1505B 06/05/2013
[   12.314832]  0000000000000000 0000000085c693e9 ffff880030d6fd58
ffffffff8139746f
[   12.322239]  00000000000000a0 ffff880030d6fd90 ffffffff814b4813
ffff880030d283c0
[   12.329645]  ffff880030d2e100 0000000000000002 0000000000000000
ffff880030c29808
[   12.337052] Call Trace:
[   12.339493]  [<ffffffff8139746f>] dump_stack+0x44/0x55
[   12.344616]  [<ffffffff814b4813>] modify_irte+0x23/0xc0
[   12.349827]  [<ffffffff814b48cc>] irq_remapping_deactivate+0x1c/0x20
[   12.356162]  [<ffffffff814b48de>] irq_remapping_activate+0xe/0x10
[   12.362238]  [<ffffffff810fa6b1>] irq_domain_activate_irq+0x41/0x50
[   12.368486]  [<ffffffff810fa69b>] irq_domain_activate_irq+0x2b/0x50
[   12.374736]  [<ffffffff81d6ccbb>] setup_IO_APIC+0x33e/0x7e4
[   12.380294]  [<ffffffff81052039>] ? clear_IO_APIC+0x39/0x60
[   12.385853]  [<ffffffff81d6b82c>] apic_bsp_setup+0xa1/0xac
[   12.391323]  [<ffffffff81d69463>] native_smp_prepare_cpus+0x25f/0x2db
[   12.397747]  [<ffffffff81d550ee>] kernel_init_freeable+0xc9/0x228
[   12.403824]  [<ffffffff81762370>] ? rest_init+0x80/0x80
[   12.409034]  [<ffffffff8176237e>] kernel_init+0xe/0xe0
[   12.414158]  [<ffffffff8176e19f>] ret_from_fork+0x3f/0x70
[   12.419541]  [<ffffffff81762370>] ? rest_init+0x80/0x80
[   12.424751]   modify_irte     devid: 00:14.0 index: 2, vector:48
[   12.440491] Kernel panic - not syncing: timer doesn't work through
Interrupt-remapped IO-APIC
[   12.449022] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0+ #18
[   12.455008] Hardware name: AMD Dinar/Dinar, BIOS RDN1505B 06/05/2013
[   12.461340]  0000000000000000 0000000085c693e9 ffff880030d6fd58
ffffffff8139746f
[   12.468753]  ffffffff81a3cdf8 ffff880030d6fde0 ffffffff8119e921
0000000000000008
[   12.476165]  ffff880030d6fdf0 ffff880030d6fd88 0000000085c693e9
ffffffff813a41b5
[   12.483577] Call Trace:
[   12.486018]  [<ffffffff8139746f>] dump_stack+0x44/0x55
[   12.491142]  [<ffffffff8119e921>] panic+0xd3/0x20b
[   12.495919]  [<ffffffff813a41b5>] ? delay_tsc+0x25/0x60
[   12.501129]  [<ffffffff814bfaba>] panic_if_irq_remap+0x1a/0x20
[   12.506947]  [<ffffffff81d6ccf2>] setup_IO_APIC+0x375/0x7e4
[   12.512503]  [<ffffffff81052039>] ? clear_IO_APIC+0x39/0x60
[   12.518060]  [<ffffffff81d6b82c>] apic_bsp_setup+0xa1/0xac
[   12.523530]  [<ffffffff81d69463>] native_smp_prepare_cpus+0x25f/0x2db
[   12.529952]  [<ffffffff81d550ee>] kernel_init_freeable+0xc9/0x228
[   12.536030]  [<ffffffff81762370>] ? rest_init+0x80/0x80
[   12.541238]  [<ffffffff8176237e>] kernel_init+0xe/0xe0
[   12.546361]  [<ffffffff8176e19f>] ret_from_fork+0x3f/0x70
[   12.551745]  [<ffffffff81762370>] ? rest_init+0x80/0x80
[   12.556957] Rebooting in 10 seconds..
The problem happened in check_timer(). Seems timer interrupt doesn't
work well after modify_irte(). I don't know why it happened. Though I
have copied the old irte tables.

Baoquan He (10):
  iommu/amd: Use standard bitmap operation to set bitmap
  iommu/amd: Adjust functons which get first/last devid by reading pci
    config
  iommu/amd: Get the first/last device of iommu earlier
  iommu/amd: Detect pre enabled translation
  iommu/amd: Add function copy_dev_tables
  iommu/amd: Add functions copy_command_buffer/copy_event_buffer
  iommu/amd: copy old dev tables and do not change it
  iommu/amd: Do not update the information of domain to devtables before
    device driver init
  iommu/amd: Clear the iommu pre enabled setting
  iommu/amd: Copy the old ir table

 drivers/iommu/amd_iommu.c       |  31 ++++--
 drivers/iommu/amd_iommu_init.c  | 205 +++++++++++++++++++++++++++++++---------
 drivers/iommu/amd_iommu_proto.h |   4 +
 drivers/iommu/amd_iommu_types.h |   3 +
 4 files changed, 189 insertions(+), 54 deletions(-)

-- 
2.4.0
