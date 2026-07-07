Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5543876B8
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404798; cv=none; b=hQjup1ExtpsMH6c99fYLaxBz1EaY0en6/Ai3c9eCS5BKRXbuLXPpuwmWMdW9AbiF2L1B2sivj6wro5hvnZwOITipD0iraLqrjTDPeE9psEOfQJhYwQUmEYoENTnPJ1WuQvyA2Oe8EYcUv+dkbEOPyhmdu0k/zGl9+c1R604J/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404798; c=relaxed/simple;
	bh=XM74iV19C6d+cW1kSOA0Jug3y2Gq2S3lury8I8T2M80=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=umCYwRaR3Xd7Bced08pw/UI4AhtBWEK75P5hEsKY586Xkqij93DPj5A0fiTKp2hz3mI5WNDlrIh7NEBblbEJ5udMsx/lt30HKqKGOcpYxwmWGQclxRMggTCOXOugkcgYL3hsMdiQ1XLTdYsjxxS/Cn9jVL/Hs3vo69FMA97VO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=kvvbsBha; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="kvvbsBha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783404763;
	bh=LQL4Q8xt9z2Jk0TeUltU+c/L8g0cWovH41/uuAxLmRk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=kvvbsBhadm8Ddsd0aVQXkvC0uUp4rmezwH3rA3osmvBGgKaZATpgsN6AZUMA3FK3v
	 oMRY9MKZ3gCSdRa3NFvXMmqtSUWuW/2/5yNKiefJvoMH/m7iLWHYu294l9XiSQ6Gix
	 eYpwbx5WICa40PJmvgPBJvqRYBh1iUG5naWPDyEs=
X-QQ-mid: zesmtpgz9t1783404756t15c4f62f
X-QQ-Originating-IP: 27GoA2m4Z37WnktNQkNxp334/EMOXRP05hl74xZPEFU=
Received: from [127.0.0.1] ( [36.152.24.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Jul 2026 14:12:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7430359193746171167
Message-ID: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
Date: Tue, 7 Jul 2026 14:12:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [BUG] iommu: KASAN slab-use-after-free in
 iommufd_auto_response_faults
To: jgg@ziepe.ca, kevin.tian@intel.com, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 baolu.lu@linux.intel.com, nicolinc@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, yi.l.liu@intel.com,
 jpb@kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OKKvvo6f47/bszRYGf2+WUYxvk8H3QWcp3gRZC5rIg+r3TUA1v/jfC+9
	WFA5L0BVlHQY/lFUaSWLVQYFUaNbkxJDMcj2/0tJJtxFf0RuuJKJUOuYZztXFodmkhHLBAf
	VPGk8AgnKH4YWCXaGmDlun07J8dNnccg/Pkmb2JytyiEZVtSh4/IwEpeJ/wdwqF5/nPQa1w
	u0e3EKYsLs1n/wUYaOMxXOL4d7MnNErY4F6rKf102xyt18Hv9BX9PgAbmIh6C6PnCZOzqYJ
	I5B/7puoJmFWKX51bkBwWAxa7NVhubBVB1ACVjxiWF+AmsTkQcrn/Zx17BeHJtSF/5NaD0K
	2X57oF064TqAi9z82mMEn8KQOdc5B3y61j/hU63XX2xYgM8j8qn5AagH53Rftaev0YZ4HZ+
	mTAl6admJ9IEZA9ErnVLP4DlZotyI7u8qgn617nZfpNgofF5A7OMibRbWS2ce5eu5/sAGm1
	eXWbiV70BPKpQcPvjYDeD6evw1WP7RmmJ/OywXggi9b4pr07ijrdSfd9pBqXF1pBWuVPrgD
	3T+uhqwseLUHHF03uMTw/5g+++aj2SGUEN4lJYYCdEhWuzD+NlRaar9y5hxGhNs4JiUs4H8
	93roDRFNGJ4+LnoKYdTxIlWY4EstV3CyT9YWHXAWzrqtLoh9rpu7YGl3ytyQy3nPPbQ+6u4
	WdHzkZ7WQtX9hoUd9oS0T1OKJWcRddJPBDZ5roTDs9GW8i6MlQYj6N/hzKYwRp76BsVBoht
	SBrkmUyBWF2csk3efa8mnid1ICLjbQMHasyA117/FwXV4TWLX9gF0m9xPjr/DyMxv9j60xR
	AjuSTs/IdqHIsWSCnkF/CtqOZYCOeBVLyzDL5A+7RF4r8i9rWWsXQAPvIYXWgaVu20ZNsBD
	0VFP9SVOI+N0OdAvRFvlg7N7PJElAeAOF8cM/Oigghsisdq1jf6cwKbo7M4l9Eu7DQA7GrX
	b3VQ4NNTIMKAGao2fNGJqYE8xyo2mJ4IWJAo6+PGZg/YoWo+6bSx72fKJrNcDVUfruCGH1k
	fPxI1cnfTEh2ORjObSKXv9gJqR9NxGt782OHGv/y2QAhfgupUOoVD0GPxKdMw=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Hello Linux kernel developers and maintainers,

We found a KASAN slab-use-after-free bug in iommufd_auto_response_faults when fuzzing with Syzkaller.

After our digging, we believe the root cause is that the same iopf_group can
remain linked from the IOMMUFD fault delivery/response queues while the generic
IOPF queue removal path frees it during HWPT detach.

Kernel version: commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1).
And we believe the bug is also possible in the current mainline.
Note that the code line numbers in the following analysis are based on this kernel version.

Relevant kernel config: (the complete config is available in https://drive.google.com/file/d/12oVjpfA3-PnZGMI6afFT6Ik33jXDcIn9/view?usp=sharing)

CONFIG_IOMMU_SUPPORT=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_IOPF=y
CONFIG_IOMMU_SVA=y
CONFIG_IOMMUFD=y
CONFIG_IOMMUFD_TEST=y
CONFIG_FAULT_INJECTION=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y


================
Syzkaller report
================

BUG: KASAN: slab-use-after-free in iommufd_auto_response_faults+0x66f/0x710 drivers/iommu/iommufd/eventq.c:33
Read of size 8 at addr ffff888047e6f0c0 by task syz.2.3/9340

CPU: 0 UID: 0 PID: 9340 Comm: syz.2.3 Not tainted 7.1.0 #3 PREEMPT(full) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10e/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xf7/0x600 mm/kasan/report.c:482
 kasan_report+0xe4/0x120 mm/kasan/report.c:595
 iommufd_auto_response_faults+0x66f/0x710 drivers/iommu/iommufd/eventq.c:33
 iommufd_hwpt_detach_device drivers/iommu/iommufd/device.c:557 [inline]
 iommufd_hw_pagetable_detach+0x399/0x6a0 drivers/iommu/iommufd/device.c:706
 iommufd_device_detach+0x1c/0x70 drivers/iommu/iommufd/device.c:1059
 iommufd_selftest_destroy+0x75/0xf0 drivers/iommu/iommufd/selftest.c:1920
 iommufd_fops_release+0x1aa/0x3f0 drivers/iommu/iommufd/main.c:361
 __fput+0x402/0xb80 fs/file_table.c:510
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x107/0x4e0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x629/0x800 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa0621a788d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe5bc4d088 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ffe5bc4d158 RCX: 00007fa0621a788d
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fa062437da0 R08: 0000000000000001 R09: 000000216224f34c
R10: 0000001b32020000 R11: 0000000000000246 R12: 00007fa062435fac
R13: 00007fa062435fa0 R14: 000000000002c4fa R15: 000000000002c458
 </TASK>

Allocated by task 9341:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 iopf_group_alloc drivers/iommu/io-pgfault.c:88 [inline]
 iommu_report_device_fault+0x480/0x1b00 drivers/iommu/io-pgfault.c:252
 iommufd_test_trigger_iopf drivers/iommu/iommufd/selftest.c:1756 [inline]
 iommufd_test+0x2868/0x6190 drivers/iommu/iommufd/selftest.c:2128
 iommufd_fops_ioctl+0x367/0x540 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9340:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kfree+0x301/0x6e0 mm/slub.c:6566
 iopf_free_group drivers/iommu/io-pgfault.c:58 [inline]
 iopf_queue_remove_device+0x573/0x990 drivers/iommu/io-pgfault.c:481
 mock_dev_disable_iopf drivers/iommu/iommufd/selftest.c:594 [inline]
 mock_dev_disable_iopf drivers/iommu/iommufd/selftest.c:584 [inline]
 mock_domain_nop_attach+0x443/0x510 drivers/iommu/iommufd/selftest.c:244
 __iommu_attach_device drivers/iommu/iommu.c:2172 [inline]
 __iommu_device_set_domain+0x1d3/0x470 drivers/iommu/iommu.c:2426
 __iommu_group_set_domain_internal+0x1aa/0x460 drivers/iommu/iommu.c:2498
 __iommu_group_set_domain_nofail drivers/iommu/iommu.c:157 [inline]
 __iommu_group_set_core_domain+0x9c/0xf0 drivers/iommu/iommu.c:2161
 iommu_detach_group_handle+0x27/0x40 drivers/iommu/iommu.c:3955
 iommufd_hwpt_detach_device drivers/iommu/iommufd/device.c:553 [inline]
 iommufd_hw_pagetable_detach+0x387/0x6a0 drivers/iommu/iommufd/device.c:706
 iommufd_device_detach+0x1c/0x70 drivers/iommu/iommufd/device.c:1059
 iommufd_selftest_destroy+0x75/0xf0 drivers/iommu/iommufd/selftest.c:1920
 iommufd_fops_release+0x1aa/0x3f0 drivers/iommu/iommufd/main.c:361
 __fput+0x402/0xb80 fs/file_table.c:510
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x107/0x4e0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x629/0x800 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888047e6f000
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 192 bytes inside of
 freed 256-byte region [ffff888047e6f000, ffff888047e6f100)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47e6e
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff888015c41b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff888015c41b40 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 04fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 8164, tgid 8164 (syz-executor), ts 181531236805, free_ts 173068828921
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfc/0x120 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x75b/0x3220 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x27e/0x2b00 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab mm/slub.c:3467 [inline]
 new_slab+0xa6/0x670 mm/slub.c:3525
 refill_objects+0x278/0x420 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x2ed/0x640 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 __do_kmalloc_node mm/slub.c:5295 [inline]
 __kmalloc_noprof+0x68d/0x850 mm/slub.c:5308
 kmalloc_noprof include/linux/slab.h:954 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 fib_create_info+0x5c3/0x4680 net/ipv4/fib_semantics.c:1400
 fib_table_insert+0x177/0x1c40 net/ipv4/fib_trie.c:1212
 fib_magic+0x4d4/0x5c0 net/ipv4/fib_frontend.c:1134
 fib_add_ifaddr+0x4d2/0x580 net/ipv4/fib_frontend.c:1178
 fib_netdev_event+0x3cf/0x710 net/ipv4/fib_frontend.c:1516
 notifier_call_chain+0xbc/0x430 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2249
 call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
 call_netdevice_notifiers net/core/dev.c:2301 [inline]
 __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9797
 netif_change_flags+0x108/0x160 net/core/dev.c:9826
page last free pid 8177 tgid 8177 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 __free_frozen_pages+0x763/0xfc0 mm/page_alloc.c:2938
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_noprof+0x2ff/0x6f0 mm/slub.c:4906
 alloc_filename fs/namei.c:142 [inline]
 do_getname+0x35/0x390 fs/namei.c:182
 class_filename_uflags_constructor include/linux/fs.h:2556 [inline]
 do_faccessat+0x111/0xc10 fs/open.c:486
 __do_sys_faccessat2 fs/open.c:542 [inline]
 __se_sys_faccessat2 fs/open.c:539 [inline]
 __x64_sys_faccessat2+0x96/0x100 fs/open.c:539
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888047e6ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047e6f000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888047e6f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff888047e6f100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047e6f180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

The complete log is available in https://drive.google.com/file/d/1lvOOQPeVBrr9WP5Mkfj0vIywDzoKjX9a/view?usp=sharing

==========
Root cause
==========

G = a iopf_group allocated by iommu_report_device_fault().
F = a iommufd_fault bound to the hardware page table.
H = a iommufd_hw_pagetable being detached.
M = a mock_dev used by the iommufd selftest path.

TLDR:

The detach path frees G in iopf_queue_remove_device() while detaching the mock
device. The same thread then continues the same iommufd_hwpt_detach_device()
call and dereferences G AGAIN from IOMMUFD's fault state in
iommufd_auto_response_faults().

The precondition is that a fault-capable HWPT has an outstanding fault that was
delivered to IOMMUFD but has not yet been responded to by userspace.
Once that state exists, detach deterministically exposes the stale ownership:
the generic IOPF removal path frees G without first removing it from IOMMUFD's
F->common.deliver list or F->response xarray.


Detailed call stack:

iommufd selftest injects an IOPF for M
--> iommufd_test() /* case IOMMU_TEST_OP_TRIGGER_IOPF */
    drivers/iommu/iommufd/selftest.c:2061
    --> iommu_report_device_fault(M, ...)
        drivers/iommu/io-pgfault.c:214
        --> allocate G
            drivers/iommu/io-pgfault.c:252
        --> put G on the generic pending list via G->pending_node
            drivers/iommu/io-pgfault.c:110
        --> call group->attach_handle->domain->iopf_handler(G)
            drivers/iommu/io-pgfault.c:262
            --> iommufd_fault_iopf_handler(G)
                drivers/iommu/iommufd/eventq.c:456
                --> queue G to F->common.deliver via G->node
                drivers/iommu/iommufd/eventq.c:465

After this synchronous fault injection returns, the same G is reachable from:
1. generic fault_param->faults via G->pending_node
2. IOMMUFD F->common.deliver via G->node, or F->response as an xarray value

close/destroy iommufd object
--> iommufd_fops_release()
    drivers/iommu/iommufd/main.c:325
    --> iommufd_selftest_destroy()
        drivers/iommu/iommufd/selftest.c:1914
        --> iommufd_device_detach()
            drivers/iommu/iommufd/device.c:1055
            --> iommufd_hw_pagetable_detach()
                drivers/iommu/iommufd/device.c:687
                --> iommufd_hwpt_detach_device(H, M, IOMMU_NO_PASID)
                    drivers/iommu/iommufd/device.c:545
                    --> handle = iommufd_device_get_attach_handle(...)
                        drivers/iommu/iommufd/device.c:551
                    --> iommu_detach_group_handle(H->domain, M->group)
                        drivers/iommu/iommufd/device.c:553

                        /* Detach switches the mock device away from H. */
                        --> mock_domain_nop_attach()
                            drivers/iommu/iommufd/selftest.c:212
                            --> mock_dev_disable_iopf(M, H->domain)
                                drivers/iommu/iommufd/selftest.c:584
                                --> iopf_queue_remove_device(..., M)
                                    drivers/iommu/io-pgfault.c:450
                                    --> list_for_each_entry_safe(G, ...)
                                        over fault_param->faults
                                        drivers/iommu/io-pgfault.c:471
                                    --> list_del_init(&G->pending_node)
                                        drivers/iommu/io-pgfault.c:480
                                    --> iopf_free_group(G)
                                        drivers/iommu/io-pgfault.c:481
                                        /* G is freed here. */

                    /* The same iommufd_hwpt_detach_device() invocation. */
                    --> iommufd_auto_response_faults(H, handle)
                        drivers/iommu/iommufd/eventq.c:19
                        --> list_for_each_entry_safe(G, next,
                                                     &F->common.deliver, node)
                            drivers/iommu/iommufd/eventq.c:33
                        --> if (G->attach_handle != &handle->handle)
                            drivers/iommu/iommufd/eventq.c:34
                            --> KASAN: use-after-free, because G was freed by
                                iopf_queue_remove_device() but is still linked
                                from F->common.deliver.

                        Or, if G has already moved to F->response:
                        --> xa_for_each(&F->response, index, G)
                            drivers/iommu/iommufd/eventq.c:46
                        --> if (G->attach_handle != &handle->handle)
                            drivers/iommu/iommufd/eventq.c:47
                            --> same stale G pointer can be dereferenced from
                                the xarray.

The analysis above goes through the iommufd selftest mock device (M). We
have not reproduced this on real Intel/AMD hardware, but the same lifetime
issue is not specific to the mock driver: Intel and AMD both have real detach
paths that can reach the very same iopf_queue_remove_device(). This is exactly
what iommufd_hwpt_detach_device() triggers, via iommu_detach_group_handle() /
iommu_detach_device_pasid(), right before it calls iommufd_auto_response_faults().

The following is a static code-path analysis.

iommu_detach_group_handle() (RID-level detach) dispatches through the
blocking domain's attach_dev op, like mock_domain_nop_attach() in the
above analysis. iommu_detach_device_pasid() (PASID-level detach) is different:
it dispatches through the blocking domain's set_dev_pasid op instead
(drivers/iommu/iommu.c:3815 -> drivers/iommu/iommu.c:3553).

Intel (drivers/iommu/intel/) reaches iopf_queue_remove_device() on both paths:
  blocking_domain_attach_dev()       [attach_dev, RID]       iommu.c:2755
  blocking_domain_set_dev_pasid()    [set_dev_pasid, PASID]  iommu.c:3557
  --> iopf_for_domain_remove()                               iommu.h:1263
  --> intel_iommu_disable_iopf()                             iommu.c:3471
  --> iopf_queue_remove_device()                             iommu.c:3483

AMD (drivers/iommu/amd/): the evidence here only covers the RID/group-detach
path.
  blocked_domain_attach_device()     [attach_dev, RID]       iommu.c:2883
  --> detach_device()                                        iommu.c:2398
  --> amd_iommu_iopf_remove_device()                         ppr.c:270
  --> iopf_queue_remove_device()                             ppr.c:273
AMD's PASID path, blocked_domain_set_dev_pasid() (iommu.c:2900), only calls
amd_iommu_remove_dev_pasid() and does not reach iopf_queue_remove_device().

====
Note
====
LLM assistance was used when analyzing the root cause and writing this report.
But we have made our best effort to ensure the description and analysis in this
report are accurate and correct.

Thanks,
Peiyang
