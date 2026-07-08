Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033E31A057
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507566; cv=none; b=ebtSSF+tFfXgDKHlp6VXlNK13v47bmHK3fHPD92nxqukin/5BIn1Qbz/GQl+vHftWYN86K6S1wZRuyvo3TjKllbELGwe4u9k6AYJeZZhVIDbUUeCMU3WtUKm/dbmVa0c/6Jz8Dm0IXweeLarHf6TWMfCPv5zUn6Wv+68bzpZrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507566; c=relaxed/simple;
	bh=g3cYy+2wpaVKpgIL1n/KNknfKn11UWCXVvbvv5cb1l4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NHpG+8GNxbIKTfnnaFVjIFBhySVNfWGgx2ItnWE7ZRhZNNWvM4Yv9tJngtmRRg7hp/beXlbG7t5+MvBWULRjBXOnSrPWT/SAo0HX7M0pW1dpM7IYcygitY6xIkLle3XCkpb5dmPhMuWDaFtdxDrUj1UKF5kFfrNLVLIF6JhFkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=o+IZDEN7; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="o+IZDEN7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783507476;
	bh=Uk4xqQ+bviljJFyBl8SiHUb7toJ7tsCtS92nSRJ1Lt0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=o+IZDEN7tx78LlDJORlmzHjF6ifED/PCpeCXYFBvurpX+cUYo3c7s5MgZEa5iioof
	 uVpMUYse4GVqBvWG0uIVs6LXcBIbLxcsZAl8BB5ZqFXFOCAHt+BlCz8ATCmiOPcNlr
	 J/VcIMqa9ODNze7U3YuSIGTp4ZjWKVbdkhyccAvI=
X-QQ-mid: esmtpgz10t1783507467t8972c7ee
X-QQ-Originating-IP: 1KGGn+aJynxNkPWscSE9bpwBIsFM/bpIFzrsIEYrp1U=
Received: from [127.0.0.1] ( [36.152.24.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 18:44:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17622274136005425647
Message-ID: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>
Date: Wed, 8 Jul 2026 18:44:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: jgg@ziepe.ca, kevin.tian@intel.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [BUG] iommufd: dma-buf-backed iopt_pages wrongly reaches userspace
 GUP path and triggers lockdep warning
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Ma4CB9LXNscGCYQY1UpGKuttXHnx7uZig8FB7y7g/LSRduT0qdHdBy3S
	yIUq11bQiDSRwQSGF1JZtBgAIiA/Em+tTsJPP2uPgUwjCwSCk/nVAAQpUTGKRLePBNlc3ML
	5TAUfMoFE7qj3QTlsb9r8ets8mCGNRCZNqJj3X7Loq8d4dfFXKqZUQ5UzYDes2fAxYpY0gl
	IsT+Ngf3Ry14VPiOikMfkTdQPNXPL9innhCJZEPZmZNOWiblBqina2kI+TXpewaHirQkwb2
	+NVu/wZAkatBFaPC+ny8j8ca4WXdYk5+HE1kQRuQFtdyOPaE+R5Pox8oV8+UyINU/+k0Aij
	wZzZ9NLdU9UxzhV98a3WIn1FYsufcU5ubI216qJWpOIiZy+OinzX1aXfEVSkXf9xRYp9AoB
	buR/UsN54NxaXc6DG2GzpeN1j0ld/kzEk9F8FHhlhLOeeZus++ZB8KHfyMEie9tb4PbUjq7
	5HNmJWRWe11cdF8FgLRuezwIxdbGmJT8r9C0lxkOSIR3j3eSp9T5GvePJCWOg1uvOKR8Bri
	R9/omJbjeuR6eYxk0Ia/PD08VfEJ13dRICF9R8+yxgR69qHYXrSLa9gEZKnNPYSD4xJy8cj
	6z+8SfKQFjUWNXMgFAaKaHL5xpBf+3oPPrfUpaPzuNA4TPwzBKMGP2I4vuYl8e7s7K9xWaX
	MvVxSuBOzDv6/H8XbWN35yLW3t16wQsAXt6zJBxjFYcTRwefv6e67NomEiHucsFRnNREilp
	XVQ+Q+esFDwYG4AwTtAXp7JU4p8O4j5kIBrz+7UFIjf4woTmBMuVZViAfApjzbgCnMgwg91
	EFrjgG5mHVbzsSh7USpL7uPHHxb7uWd6N8xvpOrp1kubwiLNntbPQ5BAOqMuB1wE/fhrUS2
	OM//mcOMzzLylZpqiJ8D1nq+zXmXU6TsMQbEGCn38J2zIHiiA6YpmiD710tr/QzUvp5Ya2Z
	R7Xy70235h3PaGzyfZ6AvPdE3hLuTCAGB3+55grCasQ/YHcO5+Txeg0AwGKk4nt0WMoD+6D
	hkNKN7ltmQx0de3gK4157fyzj+iXNG/qG+qKZfgCywJpF7J0CtcsKDaD7vDjY=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Hello Linux kernel developers and maintainers,

We found a lockdep warning titled "possible deadlock in gup_fast_fallback" when fuzzing IOMMUFD with Syzkaller using selftest.

It is known that lockdep can sometimes have false-positives, but after our digging, we believe this warning is real.
It is caused by this circular lock dependency:

mm->mmap_lock
-> reservation_ww_class_mutex
-> pages_dmabuf_mutex_key
-> mm->mmap_lock

The detailed analysis is given below.

And this warning is NOT the same as this Syzbot report: https://lore.kernel.org/all/6a0321a3.050a0220.106bf4.0005.GAE@google.com/.
They share the same lockdep warning title but have different root causes.

===========
Kernel info
===========

Version: commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1).
(We believe the bug is also possible in the current mainline after analysing its code.
Note that the line numbers in the following analysis are also based on this kernel version)

Relevant config: (the complete config is available in https://drive.google.com/file/d/12oVjpfA3-PnZGMI6afFT6Ik33jXDcIn9/view?usp=sharing)

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

We have prepared a simple C PoC in https://drive.google.com/file/d/1Ui9yXAGv6BJkGUeaiEytCKuDnZlVUW_3/view?usp=sharing
which can trigger the warning stably.
You can run it in a 7.1 kernel compiled with above config.

================
Syzkaller report
================

iommufd_mock iommufd_mock1: Adding to iommu group 1
======================================================
WARNING: possible circular locking dependency detected
7.1.0 #3 Tainted: G        W          
------------------------------------------------------
syz.0.141/10892 is trying to acquire lock:
ffff8880216cccb8 (&mm->mmap_lock){++++}-{4:4}, at: gup_fast_fallback+0x1881/0x2640 mm/gup.c:3193

but task is already holding lock:
ffff888049f25068 (&pages_dmabuf_mutex_key){+.+.}-{4:4}, at: iopt_area_add_access+0xc5/0x410 drivers/iommu/iommufd/pages.c:2452

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&pages_dmabuf_mutex_key){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a2/0x1ad0 kernel/locking/mutex.c:820
       iopt_map_dmabuf drivers/iommu/iommufd/pages.c:1501 [inline]
       iopt_alloc_dmabuf_pages+0x2e6/0x530 drivers/iommu/iommufd/pages.c:1562
       iopt_map_file_pages+0xd1/0x230 drivers/iommu/iommufd/io_pagetable.c:504
       iommufd_ioas_map_file+0x324/0x6b0 drivers/iommu/iommufd/ioas.c:231
       iommufd_fops_ioctl+0x367/0x540 drivers/iommu/iommufd/main.c:533
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (reservation_ww_class_mutex){+.+.}-{4:4}:
       ww_acquire_init include/linux/ww_mutex.h:164 [inline]
       dma_resv_lockdep+0x271/0x660 drivers/dma-buf/dma-resv.c:791
       do_one_initcall+0x124/0x770 init/main.c:1392
       do_initcall_level init/main.c:1454 [inline]
       do_initcalls init/main.c:1470 [inline]
       do_basic_setup init/main.c:1490 [inline]
       kernel_init_freeable+0x59d/0x910 init/main.c:1703
       kernel_init+0x1c/0x2b0 init/main.c:1593
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (reservation_ww_class_acquire){+.+.}-{0:0}:
       ww_acquire_init include/linux/ww_mutex.h:163 [inline]
       dma_resv_lockdep+0x24c/0x660 drivers/dma-buf/dma-resv.c:791
       do_one_initcall+0x124/0x770 init/main.c:1392
       do_initcall_level init/main.c:1454 [inline]
       do_initcalls init/main.c:1470 [inline]
       do_basic_setup init/main.c:1490 [inline]
       kernel_init_freeable+0x59d/0x910 init/main.c:1703
       kernel_init+0x1c/0x2b0 init/main.c:1593
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1576/0x25f0 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1ab/0x360 kernel/locking/lockdep.c:5825
       gup_fast_fallback+0x18c0/0x2640 mm/gup.c:3193
       pin_user_pages_fast+0xa7/0xf0 mm/gup.c:3315
       pfn_reader_user_pin+0xcc0/0x10a0 drivers/iommu/iommufd/pages.c:932
       iopt_pages_fill drivers/iommu/iommufd/pages.c:2156 [inline]
       iopt_pages_fill_xarray+0x39f/0xb20 drivers/iommu/iommufd/pages.c:2223
       iopt_area_add_access+0x22a/0x410 drivers/iommu/iommufd/pages.c:2471
       iommufd_access_pin_pages+0x66a/0xa40 drivers/iommu/iommufd/device.c:1455
       iommufd_test_access_pages drivers/iommu/iommufd/selftest.c:1580 [inline]
       iommufd_test+0x44d4/0x6190 drivers/iommu/iommufd/selftest.c:2100
       iommufd_fops_ioctl+0x367/0x540 drivers/iommu/iommufd/main.c:533
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> reservation_ww_class_mutex --> &pages_dmabuf_mutex_key

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pages_dmabuf_mutex_key);
                               lock(reservation_ww_class_mutex);
                               lock(&pages_dmabuf_mutex_key);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

4 locks held by syz.0.141/10892:
 #0: ffff888021827a70 (&staccess->lock){+.+.}-{4:4}, at: iommufd_test_access_pages drivers/iommu/iommufd/selftest.c:1579 [inline]
 #0: ffff888021827a70 (&staccess->lock){+.+.}-{4:4}, at: iommufd_test+0x4497/0x6190 drivers/iommu/iommufd/selftest.c:2100
 #1: ffff888056ff2888 (&access->ioas_lock){+.+.}-{4:4}, at: iommufd_access_pin_pages+0x240/0xa40 drivers/iommu/iommufd/device.c:1430
 #2: ffff888057e379b0 (&iopt->iova_rwsem){++++}-{4:4}, at: iommufd_access_pin_pages+0x289/0xa40 drivers/iommu/iommufd/device.c:1437
 #3: ffff888049f25068 (&pages_dmabuf_mutex_key){+.+.}-{4:4}, at: iopt_area_add_access+0xc5/0x410 drivers/iommu/iommufd/pages.c:2452

stack backtrace:
CPU: 0 UID: 0 PID: 10892 Comm: syz.0.141 Tainted: G        W           7.1.0 #3 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10e/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x26e/0x340 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x1576/0x25f0 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1ab/0x360 kernel/locking/lockdep.c:5825
 gup_fast_fallback+0x18c0/0x2640 mm/gup.c:3193
 pin_user_pages_fast+0xa7/0xf0 mm/gup.c:3315
 pfn_reader_user_pin+0xcc0/0x10a0 drivers/iommu/iommufd/pages.c:932
 iopt_pages_fill drivers/iommu/iommufd/pages.c:2156 [inline]
 iopt_pages_fill_xarray+0x39f/0xb20 drivers/iommu/iommufd/pages.c:2223
 iopt_area_add_access+0x22a/0x410 drivers/iommu/iommufd/pages.c:2471
 iommufd_access_pin_pages+0x66a/0xa40 drivers/iommu/iommufd/device.c:1455
 iommufd_test_access_pages drivers/iommu/iommufd/selftest.c:1580 [inline]
 iommufd_test+0x44d4/0x6190 drivers/iommu/iommufd/selftest.c:2100
 iommufd_fops_ioctl+0x367/0x540 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f92cbfa788d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f92ccf29018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f92cc235fa0 RCX: 00007f92cbfa788d
RDX: 0000200000000500 RSI: 0000000000003ba0 RDI: 0000000000000003
RBP: 00007f92cc04ee27 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f92cc236038 R14: 00007f92cc235fa0 R15: 00007ffd41aa98b0
 </TASK>
iommufd_mock iommufd_mock2: Adding to iommu group 2

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

The complete log is available in https://drive.google.com/file/d/1mqRQUxm3mgexDUryBPb831MWdvTpXVJW/view?usp=sharing

==========
Root cause
==========

This lockdep warning is caused by this circular lock dependency:

mm->mmap_lock
-> reservation_ww_class_mutex
-> pages_dmabuf_mutex_key
-> mm->mmap_lock

The first edge is modeled by dma_resv_lockdep():

dma_resv_lockdep()
drivers/dma-buf/dma-resv.c:776
--> mmap_read_lock(mm)
    drivers/dma-buf/dma-resv.c:790
--> ww_acquire_init(&ctx, &reservation_ww_class)
    drivers/dma-buf/dma-resv.c:791
--> dma_resv_lock(&obj, &ctx)
    drivers/dma-buf/dma-resv.c:792

So lockdep learns: mm->mmap_lock -> reservation_ww_class_mutex

The second edge is created when iommufd maps a dma-buf into an IOAS.
For IOPT_ADDRESS_DMABUF pages, iommufd first changes pages->mutex to the special
dma-buf lock class:

iopt_alloc_dmabuf_pages()
drivers/iommu/iommufd/pages.c:1527
--> lockdep_set_class(&pages->mutex, &pages_dmabuf_mutex_key)
    drivers/iommu/iommufd/pages.c:1554
--> pages->type = IOPT_ADDRESS_DMABUF
    drivers/iommu/iommufd/pages.c:1558
--> iopt_map_dmabuf(ictx, pages, dmabuf)
    drivers/iommu/iommufd/pages.c:1562

Then iopt_map_dmabuf() takes the dma-buf reservation lock before pages->mutex:

iopt_map_dmabuf()
drivers/iommu/iommufd/pages.c:1484
--> dma_resv_lock(dmabuf->resv, NULL) /* reservation_ww_class_mutex is held here */
    drivers/iommu/iommufd/pages.c:1495
--> mutex_lock(&pages->mutex)
    drivers/iommu/iommufd/pages.c:1501

Since this pages->mutex has already been assigned the pages_dmabuf_mutex_key class,
lockdep records: reservation_ww_class_mutex -> pages_dmabuf_mutex_key

This part is intentional.  The important assumption is documented in
iopt_alloc_dmabuf_pages():

drivers/iommu/iommufd/pages.c:1548
    "The mmap_lock can be held when obtaining the dmabuf reservation lock
    which creates a locking cycle with the pages mutex which is held while
    obtaining the mmap_lock. This locking path is not present for
    IOPT_ADDRESS_DMABUF so split the lock class."

The current implementation seems to violate this assumption because the access-pin path
can still run on a dma-buf-backed IOAS area.

From userspace, we can open /dev/iommu and issues:

    ioctl(iommufd, IOMMU_TEST_CMD, {.op = IOMMU_TEST_OP_DMABUF_GET, ...})
        to obtain a dma-buf fd from the iommufd selftest interface;
    ioctl(iommufd, IOMMU_IOAS_MAP_FILE, {.ioas_id = ioas_id,
                                         .fd = dmabuf_fd, ...})
        to map that dma-buf into the IOAS;
    ioctl(iommufd, IOMMU_TEST_CMD, {.op = IOMMU_TEST_OP_CREATE_ACCESS, ...})
        to create an iommufd access object for the IOAS;
    ioctl(iommufd, IOMMU_TEST_CMD, {.op = IOMMU_TEST_OP_ACCESS_PAGES, ...})
        to request page access through that access object.

The last ioctl reaches:

iommufd_test_access_pages()
drivers/iommu/iommufd/selftest.c:1580
--> iommufd_access_pin_pages()
    drivers/iommu/iommufd/device.c:1408
--> iopt_area_add_access()
    drivers/iommu/iommufd/device.c:1455

iommufd_access_pin_pages() DOES NOT reject dma-buf-backed areas before calling
iopt_area_add_access().  iopt_area_add_access() also DOES NOT reject
IOPT_ADDRESS_DMABUF before taking pages->mutex:

iopt_area_add_access()
drivers/iommu/iommufd/pages.c:2441
--> mutex_lock(&pages->mutex)
    drivers/iommu/iommufd/pages.c:2452
--> iopt_pages_fill_xarray(pages, ...)
    drivers/iommu/iommufd/pages.c:2471

For a dma-buf-backed area, this means the task is now holding pages_dmabuf_mutex_key.
The fill path then uses the normal user-memory GUP reader:

iopt_pages_fill_xarray()
drivers/iommu/iommufd/pages.c:2184
--> iopt_pages_fill()
    drivers/iommu/iommufd/pages.c:2223
--> pfn_reader_user_pin()
    drivers/iommu/iommufd/pages.c:2156
--> pin_user_pages_fast()
    drivers/iommu/iommufd/pages.c:932
--> gup_fast_fallback()
    mm/gup.c:3315
--> might_lock_read(&current->mm->mmap_lock)
    mm/gup.c:3193

Thus the access-pin path creates the reverse dependency: pages_dmabuf_mutex_key -> mm->mmap_lock.

This is exactly the locking path that the comment in iopt_alloc_dmabuf_pages()
says is not present for IOPT_ADDRESS_DMABUF.

The nearby iopt_pages_rw_access() path already rejects dma-buf-backed pages:

iopt_pages_rw_access()
drivers/iommu/iommufd/pages.c:2348
--> if (iopt_is_dmabuf(pages))
        return -EINVAL;
    drivers/iommu/iommufd/pages.c:2363

So the root cause is that iommufd's ACCESS_PAGES / access-pin path missed the
same kind of IOPT_ADDRESS_DMABUF rejection.

=============
Suggested fix
=============

If above analysis is correct, we should add dma-buf rejection in iopt_area_add_access()
or/and iommufd_access_pin_pages(), similar to iopt_pages_rw_access().

Thanks,
Peiyang

