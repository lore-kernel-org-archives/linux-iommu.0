Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC258233D9E
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714023; cv=none; b=r56A6PJwk+gcE9Rtf3epRGr7ajSPYz9oZda8oe+n1PhizaboW1OPAoE7Bc0GnRNWoLi+PG9XZlzz1sS7t5QHGN73crzm0n9TWrkIKSL0kblhKkhFDBl8wdC9nNhAaHXM0qd3p0cVo/yILFhC5yv2XKZNqH/KIMW3bbQzV/5ECOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714023; c=relaxed/simple;
	bh=50WPZ8pOFAoTpg4BrEzmSLx7Vu+pq0k6ac6lFMaXkog=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=lQp3wtMo3FkAj3OjICmQZ+p22y6QrQCGQZvq1leYc0AFXMTMBF1wXJKRyExRrwPRa4kHpheuR+ElZvOH803niOMefrBEUD4igH8OkLxqp+CrYh80KR6/1wp2WGfq4pZ2Vgd5Bx9QW5Q7+QFeh65OeNAYSY/hM2enAalFE45gdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=MXhhW4u+; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="MXhhW4u+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1784713953;
	bh=d4wPBcc5V+KZqHVXz1K5HUsY3u5gpzAdt5s0wyNGass=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=MXhhW4u+S0VTOIaTcoSjD6vHyuOqC89mTKkegpsUcKt3bOpZ+3BaQUkoHjpFMXc0C
	 QoSFtDUBMOLTIGlbDV7HR+dWGRIXnMe2PYPCWCuOmhEAJMg8W0Xl2DBLREXcBsV9Me
	 Xjoz75IWpXUYALp2n0skTRHJ6M8qrQeGu8D/3S5w=
X-QQ-mid: zesmtpgz3t1784713944t3f64982c
X-QQ-Originating-IP: g0ZOJh/cgyvHSjlaOqUpgOeJkvImzClYuQtXVLscM3I=
Received: from [127.0.0.1] ( [36.152.24.148])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Jul 2026 17:52:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2386200228584197907
Message-ID: <D5E3AA41600B2056+f4e15662-bd2b-43ea-91cb-518de429e72c@smail.nju.edu.cn>
Date: Wed, 22 Jul 2026 17:52:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [BUG] iommufd/selftest: KASAN slab-use-after-free in
 iommu_report_device_fault
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MafFL+VUl/OQeLK5Td412lwjJ6lcx6PNb9vd14Sf2kAZ7T8ELkrGXYWC
	o7QlKSJgXTSpoJ0QIZwdhaDGO+ER8+5XRTeUKAvyDffB4fcj11d8zkP3MejIG1Y3hB8br+n
	31yz59jSrkbAerofcEXV2RJkYjDrLqaqWvZrIl6hGu0oHNMsVH+o1VfTeUd1fm2fNsUFnWx
	3Hhbe3iAO1TL83rKku0Nbgw0paZIs8lAMZxcaRAxuPgqtGF+ljV8tO9WaDRIYo4mgiK37Ix
	enBEUBAuDXt0O1hI9jU1FOf9Ae5Qfa9VGEHf25duEHosK47MmCjO1AqgkbIHu6aeJthx4Ho
	1AbdaUq9sNwaL6Xy8a0d346nmkUUVioRJnkzhwjkcQRWoxeqSnnRmTUY6OzjIxRH9zmcuYj
	/CzDVHnEj6PugKuzNcvgyYiuRhdvbsyrMXc6AphKYEWqWOQfeSjMLZXoCMk4Q0AvDWz0oVD
	V96KBvkOkHmFK4vIYTEMDaSHWjQ+CbFDyICCF386YJPhcOEgixgiFP3dr9sj/D06cjxsZDK
	eOUNMzeehOFcZawxdQW9jtuNeKn+PjxqujPcKCfGEsK/L/7YwiSHCjlBBcrVntKzENo7Q6P
	xnFawsQuz36CMG+nO0lVCt4x61yZDBJgw/BYTBYiqWQ9aDMln1L24gwfiz3ue3fPwCYIM/+
	us5VMM+CUInckiBUa8POXslMUU1sCA04xlDPgO+KeClzDjquXDNeHioDksk1IUjPt8lCDRZ
	8js2AlDzERnr2x5wvZInNVYI0+nMrg8/K3SxRmk4qg1PVqDjj+XE1ymJdVB0Sn0ENkw/SAm
	fI2yempvismUnOq51/PtsR4EytNgGulwf+DK7BD5eLF6M4Qsvan+6rqfaEG1skMCgnPfPpU
	pR8CY1tThGSp/Ik06UeoXcSYn22G4tDJRcPrxj7V3Sycow+4zQcf/p34geFEH35HDNmnKOf
	WCgkxTuSpjKCM6y3EUKVoEBBZ8FYqXFEeZcC9mzHeHEmwFu0ziuxfC6QySqlMnizfQSHnx3
	ZoA7IyN7e2faBmoAZo40mCDxUJX8anP5Iry8q9yOivzlUZV/kc
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Hello Linux kernel developers and maintainers,

We found a KASAN slab-use-after-free in iommu_report_device_fault when fuzzing IOMMUFD with selftest
with Syzkaller.

The root cause is that a selftest TRIGGER_IOPF thread borrows an attach handle from group->pasid_array
without synchronizing against PASID detach, then iommu_report_device_fault() dereferences that borrowed
handle's domain pointer after the detach erases the handle and kfree()'s the backing struct
iommufd_attach_handle.
More detailed analysis will be given below.

===========
Kernel info
===========

Actually we found this UAF in a *tainted* kernel.
The base commit is 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1)
and we applied the following 3 patches so this KASAN warning won't be
masked by previous warnings:

  - https://lore.kernel.org/all/9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn/
  - https://lore.kernel.org/all/3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn/
  - https://lore.kernel.org/all/80BDADA0C8AB6928+20260720085017.3998878-3-peiyang_he@smail.nju.edu.cn/

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

==========
Kernel log
==========

[  181.301361][T10586] BUG: KASAN: slab-use-after-free in iommu_report_device_fault+0x1ae6/0x1bf0
[  181.301361][T10586] Read of size 8 at addr ffff888073f17b00 by task syz.3.41/10586
[  181.301361][T10586] 
[  181.301361][T10586] CPU: 3 UID: 0 PID: 10586 Comm: syz.3.41 Tainted: G        W           7.2.0-rc3-00013-gfd00fba8533a-dirty #8 PREEMPT(full) 
[  181.301361][T10586] Tainted: [W]=WARN
[  181.301361][T10586] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  181.301361][T10586] Call Trace:
[  181.301361][T10586]  <TASK>
[  181.301361][T10586]  dump_stack_lvl+0x10e/0x1f0
[  181.301361][T10586]  print_report+0xf7/0x600
[  181.301361][T10586]  ? iommu_report_device_fault+0x1ae6/0x1bf0
[  181.301361][T10586]  ? __virt_addr_valid+0x22c/0x420
[  181.301361][T10586]  ? iommu_report_device_fault+0x1ae6/0x1bf0
[  181.301361][T10586]  kasan_report+0xe4/0x120
[  181.301361][T10586]  ? iommu_report_device_fault+0x1ae6/0x1bf0
[  181.301361][T10586]  iommu_report_device_fault+0x1ae6/0x1bf0
[  181.301361][T10586]  ? __pfx_iommu_report_device_fault+0x10/0x10
[  181.301361][T10586]  ? xa_load+0x149/0x2c0
[  181.301361][T10586]  ? __pfx_iommufd_get_object+0x10/0x10
[  181.301361][T10586]  ? __pfx_avc_has_extended_perms+0x10/0x10
[  181.301361][T10586]  iommufd_test+0x2a74/0x6170
[  181.301361][T10586]  ? __lock_acquire+0x452/0x22e0
[  181.301361][T10586]  ? __pfx_iommufd_test+0x10/0x10
[  181.301361][T10586]  ? __lock_acquire+0x452/0x22e0
[  181.301361][T10586]  ? find_held_lock+0x2b/0x80
[  181.301361][T10586]  ? __might_fault+0xbc/0x130
[  181.301361][T10586]  iommufd_fops_ioctl+0x367/0x540
[  181.301361][T10586]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[  181.301361][T10586]  ? hook_file_ioctl_common+0x140/0x440
[  181.301361][T10586]  ? selinux_file_ioctl+0x13b/0x290
[  181.301361][T10586]  ? selinux_file_ioctl+0xb6/0x290
[  181.301361][T10586]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[  181.301361][T10586]  __x64_sys_ioctl+0x18e/0x210
[  181.301361][T10586]  do_syscall_64+0x116/0x800
[  181.301361][T10586]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  181.301361][T10586] RIP: 0033:0x7f5c927a70cd
[  181.301361][T10586] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
[  181.301361][T10586] RSP: 002b:00007f5c9360f018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  181.301361][T10586] RAX: ffffffffffffffda RBX: 00007f5c92a35fa0 RCX: 00007f5c927a70cd
[  181.301361][T10586] RDX: 0000200000000280 RSI: 0000000000003ba0 RDI: 0000000000000003
[  181.301361][T10586] RBP: 00007f5c9284f10f R08: 0000000000000000 R09: 0000000000000000
[  181.301361][T10586] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  181.301361][T10586] R13: 00007f5c92a36038 R14: 00007f5c92a35fa0 R15: 00007ffc45f1c130
[  181.301361][T10586]  </TASK>
[  181.301361][T10586] 
[  181.322145][T10605] iommufd_mock iommufd_mock0: Adding to iommu group 0
[  181.314036][T10586] Allocated by task 10586:
[  181.314036][T10586]  kasan_save_stack+0x33/0x60
[  181.314036][T10586]  kasan_save_track+0x14/0x30
[  181.314036][T10586]  __kasan_kmalloc+0xaa/0xb0
[  181.391372][T10586]  __kmalloc_cache_noprof+0x2e4/0x6f0
[  181.391372][T10586]  iommufd_hw_pagetable_attach+0x6e5/0xdd0
[  181.403803][T10586]  iommufd_device_do_attach+0x24/0x50
[  181.403803][T10586]  iommufd_device_change_pt+0x5a4/0xf70
[  181.403803][T10586]  iommufd_device_attach+0x2b/0xe0
[  181.403803][T10586]  iommufd_test+0x33bc/0x6170
[  181.403803][T10586]  iommufd_fops_ioctl+0x367/0x540
[  181.403803][T10586]  __x64_sys_ioctl+0x18e/0x210
[  181.403803][T10586]  do_syscall_64+0x116/0x800
[  181.403803][T10586]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  181.403803][T10586] 
[  181.403803][T10586] Freed by task 10598:
[  181.403803][T10586]  kasan_save_stack+0x33/0x60
[  181.403803][T10586]  kasan_save_track+0x14/0x30
[  181.403803][T10586]  kasan_save_free_info+0x3b/0x60
[  181.403803][T10586]  __kasan_slab_free+0x5f/0x80
[  181.403803][T10586]  kfree+0x2fc/0x6e0
[  181.403803][T10586]  iommufd_hw_pagetable_detach+0x3a3/0x6a0
[  181.403803][T10586]  iommufd_device_detach+0x1c/0x70
[  181.403803][T10586]  iommufd_test+0x7ac/0x6170
[  181.403803][T10586]  iommufd_fops_ioctl+0x367/0x540
[  181.403803][T10586]  __x64_sys_ioctl+0x18e/0x210
[  181.403803][T10586]  do_syscall_64+0x116/0x800
[  181.403803][T10586]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  181.403803][T10586] 
[  181.403803][T10586] The buggy address belongs to the object at ffff888073f17b00
[  181.403803][T10586]  which belongs to the cache kmalloc-16 of size 16
[  181.403803][T10586] The buggy address is located 0 bytes inside of
[  181.403803][T10586]  freed 16-byte region [ffff888073f17b00, ffff888073f17b10)
[  181.403803][T10586] 
[  181.403803][T10586] The buggy address belongs to the physical page:
[  181.403803][T10586] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888073f178c0 pfn:0x73f17
[  181.403803][T10586] flags: 0x4fff00000000200(workingset|node=1|zone=1|lastcpupid=0x7ff)
[  181.403803][T10586] page_type: f5(slab)
[  181.403803][T10586] raw: 04fff00000000200 ffff888015c42640 ffffea0001b4e650 ffffea0001228510
[  181.403803][T10586] raw: ffff888073f178c0 000000080080006a 00000000f5000000 0000000000000000
[  181.403803][T10586] page dumped because: kasan: bad access detected
[  181.403803][T10586] page_owner tracks the page as allocated
[  181.403803][T10586] page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4437, tgid 4437 (systemd-journal), ts 154690715548, free_ts 134710626173
[  181.403803][T10586]  post_alloc_hook+0xfc/0x120
[  181.403803][T10586]  get_page_from_freelist+0xef3/0x3420
[  181.403803][T10586]  __alloc_frozen_pages_noprof+0x2a6/0x2da0
[  181.403803][T10586]  new_slab+0xa6/0x600
[  181.403803][T10586]  refill_objects+0xe3/0x410
[  181.403803][T10586]  __pcs_replace_empty_main+0x2ee/0x670
[  181.403803][T10586]  __kmalloc_cache_noprof+0x59b/0x6f0
[  181.403803][T10586]  proc_self_get_link+0x189/0x1f0
[  181.403803][T10586]  pick_link+0xb17/0x13c0
[  181.403803][T10586]  step_into_slowpath+0x9bf/0xf90
[  181.403803][T10586]  link_path_walk+0xdcd/0x1b00
[  181.403803][T10586]  path_lookupat+0x74/0xc40
[  181.403803][T10586]  path_openat+0x24b7/0x42e0
[  181.403803][T10586]  do_file_open+0x20c/0x430
[  181.403803][T10586]  do_sys_openat2+0x103/0x1d0
[  181.403803][T10586]  __x64_sys_openat+0x141/0x200
[  181.403803][T10586] page last free pid 8539 tgid 8539 stack trace:
[  181.403803][T10586]  free_pages_prepare+0x531/0xcb0
[  181.403803][T10586]  __free_contig_range_common+0x14f/0x250
[  181.403803][T10586]  free_pages_bulk+0x12a/0x200
[  181.403803][T10586]  vm_area_free_pages+0x153/0x240
[  181.403803][T10586]  vfree+0x10f/0x760
[  181.403803][T10586]  kcov_close+0x34/0x60
[  181.403803][T10586]  __fput+0x402/0xb80
[  181.403803][T10586]  task_work_run+0x150/0x240
[  181.403803][T10586]  do_exit+0x947/0x2bb0
[  181.403803][T10586]  do_group_exit+0xd5/0x2a0
[  181.403803][T10586]  get_signal+0x2075/0x2270
[  181.403803][T10586]  arch_do_signal_or_restart+0x90/0x7e0
[  181.403803][T10586]  exit_to_user_mode_loop+0xd4/0x560
[  181.403803][T10586]  do_syscall_64+0x629/0x800
[  181.403803][T10586]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  181.403803][T10586] 
[  181.403803][T10586] Memory state around the buggy address:
[  181.403803][T10586]  ffff888073f17a00: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
[  181.403803][T10586]  ffff888073f17a80: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
[  181.403803][T10586] >ffff888073f17b00: fa fb fc fc 00 00 fc fc 00 01 fc fc 00 01 fc fc
[  181.403803][T10586]                    ^
[  181.403803][T10586]  ffff888073f17b80: 00 01 fc fc fa fb fc fc 00 06 fc fc 00 06 fc fc
[  181.530012][T10586]  ffff888073f17c00: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
[  181.530012][T10586] ==================================================================

==========
Root cause
==========

H = an iommu_attach_handle returned by iommu_attach_handle_get().
P = dev->iommu->fault_param.
T_fault = the thread issuing IOMMU_TEST_OP_TRIGGER_IOPF.
T_detach = the thread issuing IOMMU_TEST_OP_PASID_DETACH.

TLDR:

T_fault first finds H in group->pasid_array and keeps using it without any
synchronization against detach. T_detach then detaches the PASID,
erases the same handle from group->pasid_array, and finally frees the
backing struct iommufd_attach_handle with kfree(). If T_fault dereferences
H->domain after that, KASAN reports a slab-use-after-free in iommu_report_device_fault().

T_fault:

--> iommufd_test_trigger_iopf()
    --> iommu_report_device_fault(dev, event)
        --> find_fault_handler(dev, event)
            --> iommu_attach_handle_get(dev->iommu_group, pasid, 0) /* Get H here */

At this point T_fault has only obtained a borrowed attach handle H.
The iommu core explicitly documents that callers of iommu_attach_handle_get()
MUST synchronize the call with attachment and detachment:

"Callers are required to synchronize the call of iommu_attach_handle_get()
with domain attachment and detachment."

However, iommu_report_device_fault() does not synchronize with detach here.
find_fault_handler() immediately dereferences H:

            --> if (!attach_handle->domain->iopf_handler)
                --> return NULL;
            --> return attach_handle;

The KASAN report shows that the freed object is the 16-byte
struct iommufd_attach_handle allocated in the PASID attach path:

--> iommufd_hwpt_attach_device()
    --> handle = kzalloc_obj(*handle)
    --> iommu_attach_device_pasid(..., &handle->handle)

struct iommufd_attach_handle is:

    struct iommufd_attach_handle {
        struct iommu_attach_handle handle;
        struct iommufd_device *idev;
    };

So a "Read of size 8" at the start of the freed 16-byte object matches
reading H->domain after the backing iommufd_attach_handle was freed.


Meanwhile T_detach does:

--> iommufd_device_detach()
    --> iommufd_hw_pagetable_detach()
        --> iommufd_hwpt_detach_device(hwpt, idev, pasid)
            --> handle = iommufd_device_get_attach_handle(idev, pasid)
            --> iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid)
                --> __iommu_remove_group_pasid(...) /* call set_dev_pasid() each driver registers */
                --> xa_erase(&group->pasid_array, pasid)
            --> iommufd_auto_response_faults(hwpt, handle)
            --> kfree(handle) /* H is freed here */

Therefore the lifetime of H ends entirely inside the detach path, while
iommu_report_device_fault() still treats H as valid.

The same detach path also disables IOPF and clears P:

--> iommu_detach_device_pasid()
    --> __iommu_remove_group_pasid(...)
        --> mock_domain_set_dev_pasid_nop() /* the set_dev_pasid() that mock device registers */
            --> mock_dev_disable_iopf(dev, old)
                --> iopf_queue_remove_device(mock_iommu_iopf_queue, dev)
                    --> rcu_assign_pointer(param->fault_param, NULL)

So once T_fault races with T_detach, there are two unsynchronized objects that
can disappear:

1. H from group->pasid_array
2. P from dev->iommu->fault_param

If T_fault has already borrowed H and later dereferences H->domain after the
backing struct iommufd_attach_handle has been freed, it triggers this KASAN bug.

If T_fault gets past find_fault_handler() but later reaches the fault_param
lookup after P has already been cleared, it fails at:

    iopf_param = iopf_get_dev_fault_param(dev);
    if (WARN_ON(!iopf_param))
        goto err_bad_iopf;

That is the warning caused by iommu_report_device_fault() racing with the point
where P from dev->iommu->fault_param is cleared.

=============
Suggested fix
=============

Since iommu_attach_handle_get() explicitly says that the caller should be
responsible for "synchronize the call of iommu_attach_handle_get()
with domain attachment and detachment", maybe we shouldn't add extra lifetime
management mechanism around iommu_attach_handle, instead we should fix this at the caller side.

Fault report can run concurrently with PASID detach and replacement, but
before the old attach handle is removed and freed, mockdev must block new reports
for that PASID and wait for in-flight iommu_report_device_fault() calls to finish.

Thanks,
Peiyang
