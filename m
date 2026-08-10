Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2553BBFB2
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359036; cv=none; b=ojxsFcqysC8xIy+cSKe9akKOZAp8OHZjSrE6igSDJcP1wv1WOLyYG5qzzaVCLxeOmTvIbPIrQXDlM1J9vBKie0JLOBnGvcGnttHrm9apt0VosVwth4LdXnhVHQ8MLNBR4+wfaj1N/L0JudE/7A+359lJjfZQw93Pv7+3K/v4xPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359036; c=relaxed/simple;
	bh=YsjBObEpDr/7/coIY8BIWKaXvfy27zxI/gcyGpzdiqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WLCPDHW1ubn/P9q21wj9XzFMkh57Qw9IYiwU6cPf1gAU+OAqxeIKvuJWFNRXKoHkP/Uo/qUfaw7/kcOfBTQbJq03+aQlzea6vV78rBS2us1+WB1Du+mUrZ/kDiIHJzoVDMIfGN2JFXkBnNpqJQnC0aiU1EmFGZvYC+bM3c1zd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UFNAcSoV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UFNAcSoV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F418F14BF;
	Mon, 10 Aug 2026 03:50:29 -0700 (PDT)
Received: from [10.57.44.151] (unknown [10.57.44.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 120D53F86F;
	Mon, 10 Aug 2026 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786359033; bh=YsjBObEpDr/7/coIY8BIWKaXvfy27zxI/gcyGpzdiqw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UFNAcSoV4po7XUOdfPA3jNoFaZOdzgni2dKYTYFu5M7wUrCYmU58HMAGASs22vyUQ
	 pNkB6jNHtZ/ayvo5QpbQeiF7peozzV92fUR57JjcMREQtT0aQfJIBAF56awThgtCQ1
	 H4+ZuvV1iQ8DczMIHdBRtPLWDR7TY5RMj3VR19Qw=
Message-ID: <68eebaf3-2427-48c0-93d3-87455ff266fb@arm.com>
Date: Mon, 10 Aug 2026 11:50:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in free_iova
To: syzbot <syzbot+90c2d711b5218d10ce61@syzkaller.appspotmail.com>,
 baolu.lu@linux.intel.com, dwmw2@infradead.org, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, will@kernel.org
References: <6a7910da.9c11d2ce.289b96.00da.GAE@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <6a7910da.9c11d2ce.289b96.00da.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-10 12:44 am, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    562bfb501c54 Merge tag 'integrity-v7.2-rc7' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ba93b9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c05be6c9b0d36cb9
> dashboard link: https://syzkaller.appspot.com/bug?extid=90c2d711b5218d10ce61
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-562bfb50.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7580e6506574/vmlinux-562bfb50.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/883f7f234497/bzImage-562bfb50.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+90c2d711b5218d10ce61@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in private_find_iova drivers/iommu/iova.c:285 [inline]
> BUG: KASAN: slab-use-after-free in free_iova+0xab/0x200 drivers/iommu/iova.c:355
> Read of size 8 at addr ffff888000274d60 by task syz.0.0/5327
> 
> CPU: 0 UID: 0 PID: 5327 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>   <IRQ>
>   dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>   print_address_description+0x55/0x1e0 mm/kasan/report.c:378
>   print_report+0x58/0x70 mm/kasan/report.c:482
>   kasan_report+0x117/0x150 mm/kasan/report.c:595
>   private_find_iova drivers/iommu/iova.c:285 [inline]
>   free_iova+0xab/0x200 drivers/iommu/iova.c:355
>   fq_ring_free_locked+0x1ab/0x310 drivers/iommu/dma-iommu.c:155
>   fq_ring_free drivers/iommu/dma-iommu.c:170 [inline]
>   fq_flush_timeout+0x234/0x2d0 drivers/iommu/dma-iommu.c:194

So apparently the timer is firing with a non-empty queue...

>   call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
>   expire_timers kernel/time/timer.c:1799 [inline]
>   __run_timers kernel/time/timer.c:2374 [inline]
>   __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
>   run_timer_base kernel/time/timer.c:2395 [inline]
>   run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
>   handle_softirqs+0x225/0x840 kernel/softirq.c:622
>   __do_softirq kernel/softirq.c:656 [inline]
>   invoke_softirq kernel/softirq.c:496 [inline]
>   __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
>   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
>   </IRQ>
>   <TASK>
>   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
> RIP: 0010:console_flush_one_record arch/x86/include/asm/irqflags.h:-1 [inline]
> RIP: 0010:console_flush_all+0x7d2/0xaf0 kernel/printk/printk.c:3343
> Code: ff ff e8 81 3b 21 00 90 0f 0b 90 e9 9c fc ff ff e8 73 3b 21 00 e8 ce 5d 2d 0a 48 85 db 74 c0 e8 64 3b 21 00 fb 48 8b 5c 24 18 <48> 8b 44 24 28 42 80 3c 20 00 4d 8d 77 58 74 08 4c 89 f7 e8 e6 6d
> RSP: 0018:ffffc9000f6271e0 EFLAGS: 00000283
> RAX: ffffffff81a5e75c RBX: ffffc9000f627340 RCX: 0000000000100000
> RDX: ffffc9000edfa000 RSI: 000000000002c5aa RDI: 000000000002c5ab
> RBP: ffffc9000f6272f0 R08: ffffffff9057c237 R09: 1ffffffff20af846
> R10: dffffc0000000000 R11: fffffbfff20af847 R12: dffffc0000000000
> R13: 0000000000000001 R14: 0000000000000000 R15: ffffffff8f471ce0
>   __console_flush_and_unlock kernel/printk/printk.c:3373 [inline]
>   console_unlock+0xd1/0x1c0 kernel/printk/printk.c:3413
>   vprintk_emit+0x485/0x560 kernel/printk/printk.c:2479
>   __warn_printf lib/bug.c:189 [inline]
>   __report_bug+0x3c5/0x570 lib/bug.c:249
>   report_bug_entry+0x19a/0x290 lib/bug.c:274
>   handle_bug+0xce/0x200 arch/x86/kernel/traps.c:431
>   exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:490
>   asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:593
> RIP: 0010:debug_print_object+0x18a/0x230 lib/debugobjects.c:629
> Code: f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 3d 13 56 fd 4d 8b 0f 4c 89 ef 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f0 ff 34 24 <67> 48 0f b9 3a 48 83 c4 08 ff 05 03 b3 77 0b 48 83 c4 10 5b 41 5c
> RSP: 0018:ffffc9000f6276f0 EFLAGS: 00010246
> RAX: 1ffffffff17decd0 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: ffffffff8c4bf940 RSI: ffffffff8c4bf3c0 RDI: ffffffff90632440
> RBP: ffffffff8c4bf940 R08: ffff8880002684e0 R09: ffffffff8bef79e0
> R10: dffffc0000000000 R11: ffffffff81b33db0 R12: 0000000000000000
> R13: ffffffff90632440 R14: ffff8880002684e0 R15: ffffffff8bef6680
>   __debug_check_no_obj_freed lib/debugobjects.c:1171 [inline]
>   debug_check_no_obj_freed+0x2e3/0x450 lib/debugobjects.c:1201
>   slab_free_hook mm/slub.c:2608 [inline]
>   slab_free mm/slub.c:6377 [inline]
>   kfree+0x13e/0x640 mm/slub.c:6692
>   iommu_domain_free drivers/iommu/iommu.c:2131 [inline]
>   iommu_deinit_device+0x401/0x840 drivers/iommu/iommu.c:600
>   __iommu_group_remove_device+0x1dd/0x270 drivers/iommu/iommu.c:764
>   iommu_release_device drivers/iommu/iommu.c:783 [inline]
>   iommu_bus_notifier+0x6d/0x2c0 drivers/iommu/iommu.c:1826
>   notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
>   blocking_notifier_call_chain+0x6a/0x90 kernel/notifier.c:380
>   bus_notify+0x143/0x180 drivers/base/bus.c:1086
>   device_del+0x740/0x8f0 drivers/base/core.c:3978
>   pci_destroy_dev drivers/pci/remove.c:46 [inline]
>   pci_remove_bus_device+0x12a/0x2a0 drivers/pci/remove.c:110
>   pci_stop_and_remove_bus_device drivers/pci/remove.c:129 [inline]
>   pci_stop_and_remove_bus_device_locked+0x7f/0xb0 drivers/pci/remove.c:136
>   remove_store+0xe5/0x150 drivers/pci/pci-sysfs.c:523
>   kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
>   new_sync_write fs/read_write.c:595 [inline]
>   vfs_write+0x612/0xba0 fs/read_write.c:687
>   ksys_write+0x150/0x270 fs/read_write.c:739
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2afa79e019
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2afb6f9fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f2afaa25fa0 RCX: 00007f2afa79e019
> RDX: 0000000000000001 RSI: 00002000000000c0 RDI: 0000000000000008
> RBP: 00007f2afa83500c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f2afaa26038 R14: 00007f2afaa25fa0 R15: 00007fff4eb947c8
>   </TASK>
> 
> Allocated by task 1:
>   kasan_save_stack mm/kasan/common.c:57 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>   unpoison_slab_object mm/kasan/common.c:340 [inline]
>   __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
>   kasan_slab_alloc include/linux/kasan.h:253 [inline]
>   slab_post_alloc_hook mm/slub.c:4584 [inline]
>   slab_alloc_node mm/slub.c:4917 [inline]
>   kmem_cache_alloc_noprof+0x2a0/0x5f0 mm/slub.c:4931
>   alloc_iova_mem drivers/iommu/iova.c:231 [inline]
>   alloc_and_init_iova drivers/iommu/iova.c:474 [inline]
>   __insert_new_range drivers/iommu/iova.c:489 [inline]
>   reserve_iova+0x2b0/0x480 drivers/iommu/iova.c:544
>   iova_reserve_pci_windows drivers/iommu/dma-iommu.c:521 [inline]
>   iova_reserve_iommu_regions drivers/iommu/dma-iommu.c:563 [inline]
>   iommu_dma_init_domain drivers/iommu/dma-iommu.c:723 [inline]
>   iommu_setup_dma_ops+0xa21/0x1820 drivers/iommu/dma-iommu.c:2159
>   bus_iommu_probe+0x296/0x470 drivers/iommu/iommu.c:1983
>   iommu_device_register+0x1af/0x210 drivers/iommu/iommu.c:307
>   intel_iommu_init+0x6f0/0x8e0 drivers/iommu/intel/iommu.c:2662
>   pci_iommu_init+0x38/0x70 arch/x86/kernel/pci-dma.c:174
>   do_one_initcall+0x250/0x870 init/main.c:1347
>   do_initcall_level+0x10a/0x1a0 init/main.c:1409
>   do_initcalls+0x59/0xa0 init/main.c:1425
>   kernel_init_freeable+0x29d/0x3e0 init/main.c:1658
>   kernel_init+0x1d/0x1d0 init/main.c:1548
>   ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> Freed by task 5327:
>   kasan_save_stack mm/kasan/common.c:57 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
>   poison_slab_object mm/kasan/common.c:253 [inline]
>   __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
>   kasan_slab_free include/linux/kasan.h:235 [inline]
>   slab_free_hook mm/slub.c:2677 [inline]
>   slab_free mm/slub.c:6377 [inline]
>   kmem_cache_free+0x182/0x650 mm/slub.c:6504
>   free_iova_mem drivers/iommu/iova.c:237 [inline]
>   put_iova_domain+0xcc/0x100 drivers/iommu/iova.c:454

...except that right in between here we've called iommu_dma_free_fq() 
which would have already invoked timer_delete_sync() and freed the queue 
itself. Wut?

There is the "if (!cookie->fq_domain)" bypass, but I can't see how that 
could be legitimately be taken given that we must have already observed 
fq_domain being non-NULL in order to have any IOVAs in the queue to 
begin with, and once it is set we never clear it. Has something else 
corrupted the iommu_domain::iova_cookie?

Although given the allocation backtrace above, it also looks 
suspiciously wrong that a reserved IOVA could have ended up on a flush 
queue, so this whole thing starts to look like a symptom of one or more 
bugs elsewhere rather than an issue in iommu-dma itself...

Thansk,
Robin.

>   iommu_put_dma_cookie+0x45c/0x560 drivers/iommu/dma-iommu.c:431
>   iommu_domain_free drivers/iommu/iommu.c:2131 [inline]
>   iommu_deinit_device+0x401/0x840 drivers/iommu/iommu.c:600
>   __iommu_group_remove_device+0x1dd/0x270 drivers/iommu/iommu.c:764
>   iommu_release_device drivers/iommu/iommu.c:783 [inline]
>   iommu_bus_notifier+0x6d/0x2c0 drivers/iommu/iommu.c:1826
>   notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
>   blocking_notifier_call_chain+0x6a/0x90 kernel/notifier.c:380
>   bus_notify+0x143/0x180 drivers/base/bus.c:1086
>   device_del+0x740/0x8f0 drivers/base/core.c:3978
>   pci_destroy_dev drivers/pci/remove.c:46 [inline]
>   pci_remove_bus_device+0x12a/0x2a0 drivers/pci/remove.c:110
>   pci_stop_and_remove_bus_device drivers/pci/remove.c:129 [inline]
>   pci_stop_and_remove_bus_device_locked+0x7f/0xb0 drivers/pci/remove.c:136
>   remove_store+0xe5/0x150 drivers/pci/pci-sysfs.c:523
>   kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
>   new_sync_write fs/read_write.c:595 [inline]
>   vfs_write+0x612/0xba0 fs/read_write.c:687
>   ksys_write+0x150/0x270 fs/read_write.c:739
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888000274d40
>   which belongs to the cache iommu_iova of size 40
> The buggy address is located 32 bytes inside of
>   freed 40-byte region [ffff888000274d40, ffff888000274d68)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x274
> flags: 0x7ff00000000000(node=0|zone=0|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 007ff00000000000 ffff888030463500 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000800400040 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 8498569964, free_ts 0
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
>   prep_new_page mm/page_alloc.c:1867 [inline]
>   get_page_from_freelist+0x21fa/0x2270 mm/page_alloc.c:3946
>   __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
>   alloc_slab_page mm/slub.c:3266 [inline]
>   allocate_slab+0x79/0x5e0 mm/slub.c:3380
>   new_slab mm/slub.c:3426 [inline]
>   refill_objects+0x2d5/0x350 mm/slub.c:7310
>   refill_sheaf mm/slub.c:2804 [inline]
>   __pcs_replace_empty_main+0x2bf/0x6b0 mm/slub.c:4675
>   alloc_from_pcs mm/slub.c:4773 [inline]
>   slab_alloc_node mm/slub.c:4905 [inline]
>   kmem_cache_alloc_noprof+0x382/0x5f0 mm/slub.c:4931
>   alloc_iova_mem drivers/iommu/iova.c:231 [inline]
>   alloc_and_init_iova drivers/iommu/iova.c:474 [inline]
>   __insert_new_range drivers/iommu/iova.c:489 [inline]
>   reserve_iova+0x2b0/0x480 drivers/iommu/iova.c:544
>   iova_reserve_pci_windows drivers/iommu/dma-iommu.c:521 [inline]
>   iova_reserve_iommu_regions drivers/iommu/dma-iommu.c:563 [inline]
>   iommu_dma_init_domain drivers/iommu/dma-iommu.c:723 [inline]
>   iommu_setup_dma_ops+0xa21/0x1820 drivers/iommu/dma-iommu.c:2159
>   bus_iommu_probe+0x296/0x470 drivers/iommu/iommu.c:1983
>   iommu_device_register+0x1af/0x210 drivers/iommu/iommu.c:307
>   intel_iommu_init+0x6f0/0x8e0 drivers/iommu/intel/iommu.c:2662
>   pci_iommu_init+0x38/0x70 arch/x86/kernel/pci-dma.c:174
>   do_one_initcall+0x250/0x870 init/main.c:1347
>   do_initcall_level+0x10a/0x1a0 init/main.c:1409
>   do_initcalls+0x59/0xa0 init/main.c:1425
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
>   ffff888000274c00: 00 00 00 00 00 fc fc fc 00 00 00 00 00 fc fc fc
>   ffff888000274c80: fa fb fb fb fb fc fc fc fa fb fb fb fb fc fc fc
>> ffff888000274d00: fa fb fb fb fb fc fc fc fa fb fb fb fb fc fc fc
>                                                         ^
>   ffff888000274d80: fa fb fb fb fb fc fc fc 00 00 00 00 00 fc fc fc
>   ffff888000274e00: 00 00 00 00 00 fc fc fc 00 00 00 00 00 fc fc fc
> ==================================================================
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>     0:	ff                   	ljmp   (bad)
>     1:	e8 81 3b 21 00       	call   0x213b87
>     6:	90                   	nop
>     7:	0f 0b                	ud2
>     9:	90                   	nop
>     a:	e9 9c fc ff ff       	jmp    0xfffffcab
>     f:	e8 73 3b 21 00       	call   0x213b87
>    14:	e8 ce 5d 2d 0a       	call   0xa2d5de7
>    19:	48 85 db             	test   %rbx,%rbx
>    1c:	74 c0                	je     0xffffffde
>    1e:	e8 64 3b 21 00       	call   0x213b87
>    23:	fb                   	sti
>    24:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
> * 29:	48 8b 44 24 28       	mov    0x28(%rsp),%rax <-- trapping instruction
>    2e:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
>    33:	4d 8d 77 58          	lea    0x58(%r15),%r14
>    37:	74 08                	je     0x41
>    39:	4c 89 f7             	mov    %r14,%rdi
>    3c:	e8                   	.byte 0xe8
>    3d:	e6 6d                	out    %al,$0x6d
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

