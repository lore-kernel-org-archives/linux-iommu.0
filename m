From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH v3 1/2] iommu: Disable preemption around use of this_cpu_ptr()
Date: Wed,  1 Jun 2016 12:10:08 +0100
Message-ID: <1464779409-26711-1-git-send-email-chris@chris-wilson.co.uk>
References: <1464776603-11998-1-git-send-email-chris@chris-wilson.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464776603-11998-1-git-send-email-chris@chris-wilson.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: intel-gfx@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Between acquiring the this_cpu_ptr() and using it, ideally we don't want
to be preempted and work on another CPU's private data. this_cpu_ptr()
checks whether or not preemption is disable, and get_cpu_ptr() provides
a convenient wrapper for operating on the cpu ptr inside a preemption
disabled critical section (which currently is provided by the
spinlock). Indeed if we disable preemption around this_cpu_ptr,
we do not need the CPU local spinlock - so long as take care that no other
CPU is running that code as do perform the cross-CPU cache flushing and
teardown, but that is a subject for another patch.

[  167.997877] BUG: using smp_processor_id() in preemptible [00000000] code: usb-storage/216
[  167.997940] caller is debug_smp_processor_id+0x17/0x20
[  167.997945] CPU: 7 PID: 216 Comm: usb-storage Tainted: G     U          4.7.0-rc1-gfxbench-RO_Patchwork_1057+ #1
[  167.997948] Hardware name: Hewlett-Packard HP Pro 3500 Series/2ABF, BIOS 8.11 10/24/2012
[  167.997951]  0000000000000000 ffff880118b7f9c8 ffffffff8140dca5 0000000000000007
[  167.997958]  ffffffff81a3a7e9 ffff880118b7f9f8 ffffffff8142a927 0000000000000000
[  167.997965]  ffff8800d499ed58 0000000000000001 00000000000fffff ffff880118b7fa08
[  167.997971] Call Trace:
[  167.997977]  [<ffffffff8140dca5>] dump_stack+0x67/0x92
[  167.997981]  [<ffffffff8142a927>] check_preemption_disabled+0xd7/0xe0
[  167.997985]  [<ffffffff8142a947>] debug_smp_processor_id+0x17/0x20
[  167.997990]  [<ffffffff81507e17>] alloc_iova_fast+0xb7/0x210
[  167.997994]  [<ffffffff8150c55f>] intel_alloc_iova+0x7f/0xd0
[  167.997998]  [<ffffffff8151021d>] intel_map_sg+0xbd/0x240
[  167.998002]  [<ffffffff810e5efd>] ? debug_lockdep_rcu_enabled+0x1d/0x20
[  167.998009]  [<ffffffff81596059>] usb_hcd_map_urb_for_dma+0x4b9/0x5a0
[  167.998013]  [<ffffffff81596d19>] usb_hcd_submit_urb+0xe9/0xaa0
[  167.998017]  [<ffffffff810cff2f>] ? mark_held_locks+0x6f/0xa0
[  167.998022]  [<ffffffff810d525c>] ? __raw_spin_lock_init+0x1c/0x50
[  167.998025]  [<ffffffff810e5efd>] ? debug_lockdep_rcu_enabled+0x1d/0x20
[  167.998028]  [<ffffffff815988f3>] usb_submit_urb+0x3f3/0x5a0
[  167.998032]  [<ffffffff810d0082>] ? trace_hardirqs_on_caller+0x122/0x1b0
[  167.998035]  [<ffffffff81599ae7>] usb_sg_wait+0x67/0x150
[  167.998039]  [<ffffffff815dc202>] usb_stor_bulk_transfer_sglist.part.3+0x82/0xd0
[  167.998042]  [<ffffffff815dc29c>] usb_stor_bulk_srb+0x4c/0x60
[  167.998045]  [<ffffffff815dc42e>] usb_stor_Bulk_transport+0x17e/0x420
[  167.998049]  [<ffffffff815dcf32>] usb_stor_invoke_transport+0x242/0x540
[  167.998052]  [<ffffffff810e5efd>] ? debug_lockdep_rcu_enabled+0x1d/0x20
[  167.998058]  [<ffffffff815dba19>] usb_stor_transparent_scsi_command+0x9/0x10
[  167.998061]  [<ffffffff815de518>] usb_stor_control_thread+0x158/0x260
[  167.998064]  [<ffffffff815de3c0>] ? fill_inquiry_response+0x20/0x20
[  167.998067]  [<ffffffff815de3c0>] ? fill_inquiry_response+0x20/0x20
[  167.998071]  [<ffffffff8109ddfa>] kthread+0xea/0x100
[  167.998078]  [<ffffffff817ac6af>] ret_from_fork+0x1f/0x40
[  167.998081]  [<ffffffff8109dd10>] ? kthread_create_on_node+0x1f0/0x1f0

v2: convert preempt_disable(); var = this_cpu_ptr() to var = get_cpu_ptr()
v3: Actually use get_cpu_ptr (not get_cpu_var). Drop the spinlock
removal, concentrate on the immediate bug fix.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=96293
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iommu/iova.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index ba764a0835d3..e23001bfcfee 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -420,8 +420,10 @@ retry:
 
 		/* Try replenishing IOVAs by flushing rcache. */
 		flushed_rcache = true;
+		preempt_disable();
 		for_each_online_cpu(cpu)
 			free_cpu_cached_iovas(cpu, iovad);
+		preempt_enable();
 		goto retry;
 	}
 
@@ -749,7 +751,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 	bool can_insert = false;
 	unsigned long flags;
 
-	cpu_rcache = this_cpu_ptr(rcache->cpu_rcaches);
+	cpu_rcache = get_cpu_ptr(rcache->cpu_rcaches);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
 	if (!iova_magazine_full(cpu_rcache->loaded)) {
@@ -779,6 +781,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 		iova_magazine_push(cpu_rcache->loaded, iova_pfn);
 
 	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
+	put_cpu_ptr(rcache->cpu_rcaches);
 
 	if (mag_to_free) {
 		iova_magazine_free_pfns(mag_to_free, iovad);
@@ -812,7 +815,7 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 	bool has_pfn = false;
 	unsigned long flags;
 
-	cpu_rcache = this_cpu_ptr(rcache->cpu_rcaches);
+	cpu_rcache = get_cpu_ptr(rcache->cpu_rcaches);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
 	if (!iova_magazine_empty(cpu_rcache->loaded)) {
@@ -834,6 +837,7 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 		iova_pfn = iova_magazine_pop(cpu_rcache->loaded, limit_pfn);
 
 	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
+	put_cpu_ptr(rcache->cpu_rcaches);
 
 	return iova_pfn;
 }
-- 
2.8.1
