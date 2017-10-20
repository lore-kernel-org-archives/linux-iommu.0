From: Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Shift overflow in qi_flush_dev_iotlb
Date: Fri, 20 Oct 2017 19:36:54 +0100
Message-ID: <2d694fb1-d223-2d6c-107a-1ce9e6d14952@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


Hi all,

Detected by ubsan:

  UBSAN: Undefined behaviour in drivers/iommu/dmar.c:1345:3
  shift exponent 64 is too large for 32-bit type 'int'
  CPU: 2 PID: 1167 Comm: perf_pmu Not tainted 4.14.0-rc5+ #532
  Hardware name: LENOVO 80MX/Lenovo E31-80, BIOS DCCN34WW(V2.03) 12/01/2015
  Call Trace:
   <IRQ>
   dump_stack+0xab/0xfe
   ? _atomic_dec_and_lock+0x112/0x112
   ? get_unsigned_val+0x48/0x91
   ubsan_epilogue+0x9/0x49
   __ubsan_handle_shift_out_of_bounds+0x1ea/0x241
   ? __ubsan_handle_load_invalid_value+0x136/0x136
   ? _raw_spin_unlock_irqrestore+0x32/0x50
   ? qi_submit_sync+0x642/0x820
   ? qi_flush_dev_iotlb+0x158/0x1b0
   qi_flush_dev_iotlb+0x158/0x1b0
   ? qi_flush_iotlb+0x110/0x110
   ? do_raw_spin_lock+0x93/0x130
   iommu_flush_dev_iotlb+0xff/0x170
   iommu_flush_iova+0x168/0x220
   iova_domain_flush+0x2b/0x50
   fq_flush_timeout+0xa6/0x1e0
   ? fq_ring_free+0x260/0x260
   ? call_timer_fn+0xfd/0x600
   call_timer_fn+0x160/0x600
   ? fq_ring_free+0x260/0x260
   ? trace_timer_cancel+0x1d0/0x1d0
   ? _raw_spin_unlock_irq+0x29/0x40
   ? fq_ring_free+0x260/0x260
   ? fq_ring_free+0x260/0x260
   run_timer_softirq+0x3bb/0x9a0
   ? timer_fixup_init+0x30/0x30
   ? __lock_is_held+0x35/0x150
   ? sched_clock_cpu+0x14/0x180
   __do_softirq+0x159/0x9c7
   irq_exit+0x118/0x170
   smp_apic_timer_interrupt+0xda/0x530
   apic_timer_interrupt+0x9d/0xb0
   </IRQ>
  RIP: 0010:__asan_load4+0xa/0x80
  RSP: 0018:ffff88012f647380 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff10
  RAX: ffff7fffffffffff RBX: ffff88012f647548 RCX: ffffffff9a07ea01
  RDX: dffffc0000000000 RSI: ffff88012f647808 RDI: ffff88012f647548
  RBP: ffff88012f640000 R08: fffffbfff3b27e96 R09: fffffbfff3b27e95
  R10: ffffffff9d93f4ad R11: fffffbfff3b27e96 R12: ffff88012f648000
  R13: ffff88012f647558 R14: ffff88012f647550 R15: ffff88012f647808
   ? stack_access_ok+0x61/0x110
   stack_access_ok+0x6d/0x110
   deref_stack_reg+0x64/0x120
   ? __read_once_size_nocheck.constprop.3+0x50/0x50
   ? deref_stack_reg+0x120/0x120
   ? __kmalloc+0x13a/0x550
   unwind_next_frame+0xc04/0x14e0
   ? kasan_kmalloc+0xa0/0xd0
   ? __kmalloc+0x13a/0x550
   ? __kmalloc+0x13a/0x550
   ? deref_stack_reg+0x120/0x120
   ? unwind_next_frame+0xf3e/0x14e0
   ? i915_gem_do_execbuffer+0x4fd/0x2570 [i915]
   __save_stack_trace+0x7a/0x120
   ? __kmalloc+0x13a/0x550
   save_stack+0x33/0xa0
   ? save_stack+0x33/0xa0
   ? kasan_kmalloc+0xa0/0xd0
   ? _raw_spin_unlock+0x24/0x30
   ? deactivate_slab+0x650/0xb90
   ? ___slab_alloc+0x3e0/0x940
   ? ___slab_alloc+0x3e0/0x940
   ? i915_gem_do_execbuffer+0x4fd/0x2570 [i915]
   ? __lock_is_held+0x35/0x150
   ? mark_held_locks+0x33/0x130
   ? kasan_unpoison_shadow+0x30/0x40
   kasan_kmalloc+0xa0/0xd0
   __kmalloc+0x13a/0x550
   ? depot_save_stack+0x16a/0x7f0
   i915_gem_do_execbuffer+0x4fd/0x2570 [i915]
   ? save_stack+0x92/0xa0
   ? eb_relocate_slow+0x890/0x890 [i915]
   ? debug_check_no_locks_freed+0x200/0x200
   ? ___slab_alloc+0x3e0/0x940
   ? ___slab_alloc+0x3e0/0x940
   ? i915_gem_execbuffer2+0xdb/0x5f0 [i915]
   ? __lock_is_held+0x35/0x150
   ? i915_gem_execbuffer+0x580/0x580 [i915]
   i915_gem_execbuffer2+0x2c1/0x5f0 [i915]
   ? i915_gem_execbuffer+0x580/0x580 [i915]
   ? lock_downgrade+0x310/0x310
   ? i915_gem_execbuffer+0x580/0x580 [i915]
   drm_ioctl_kernel+0xdc/0x190
   drm_ioctl+0x46a/0x6e0
   ? i915_gem_execbuffer+0x580/0x580 [i915]
   ? drm_setversion+0x430/0x430
   ? lock_downgrade+0x310/0x310
   do_vfs_ioctl+0x138/0xbf0
   ? ioctl_preallocate+0x180/0x180
   ? do_raw_spin_unlock+0xf5/0x1d0
   ? do_raw_spin_trylock+0x90/0x90
   ? task_work_run+0x35/0x120
   ? mark_held_locks+0x33/0x130
   ? _raw_spin_unlock_irq+0x29/0x40
   ? mark_held_locks+0x33/0x130
   ? entry_SYSCALL_64_fastpath+0x5/0xad
   ? trace_hardirqs_on_caller+0x184/0x360
   SyS_ioctl+0x3b/0x70
   entry_SYSCALL_64_fastpath+0x18/0xad
  RIP: 0033:0x7fc0e1f0d587
  RSP: 002b:00007ffcfd9929f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fc0e1f0d587
  RDX: 00007ffcfd992a90 RSI: 0000000040406469 RDI: 0000000000000003
  RBP: 0000000000000003 R08: 00007ffcfd992a50 R09: 0000000000000000
  R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000001
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Code is:

void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
			u64 addr, unsigned mask)
{
	struct qi_desc desc;

	if (mask) {
		BUG_ON(addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1));

^^^ This last line is where the warning comes. Digging deeper 
VTD_PAGE_SHIFT is 12 and the passed in mask comes from iommu_flush_iova 
(via iommu_flush_dev_iotlb) as MAX_AGAW_PFN_WIDTH which is:

#define MAX_AGAW_WIDTH 64
#define MAX_AGAW_PFN_WIDTH	(MAX_AGAW_WIDTH - VTD_PAGE_SHIFT)

So mask is 64, which overflows the left shift in the BUG_ON.

Regards,

Tvrtko
