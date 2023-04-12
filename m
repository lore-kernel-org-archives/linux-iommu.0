Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2343C02
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 11:51:47 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id dw2so21122410qvb.11
        for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681300306; x=1683892306;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6asngVmOq+TTi63ftv80tbHF2c1gAR73aFDLAWFey8s=;
        b=sMsLkJLyjeOGsM5cPrK564DXtqDLZJg8Xuj0kPfnCjghD6m+PsHRrdnbe++M3E8+8S
         W+fYHvxZMNZIW18Ns8jDUsAzRM8jrhcKdy4cuVKHqSbY1fFmgbc3jjRy9uSk7Z8Na7Uo
         wrr4zK2jv7yzHBcKJAWZK38n9C++FY9vMF8L5kVD2Iw0nAy8T2c3Xw6Px+BOoGRfS+dM
         NBvKydD/Xt5BcWXtSEAJ0o6cOXyFqNchAF5wUSfptYUk1/BaL7CZDdrvZVJtD5jOvHCH
         3cGFejrw2q7ZxqMTiTIyiPuRkxb6tVWutNsosn/UtHLBBSILtXa3WXwQUfHDJ6Ds1RHs
         cq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681300306; x=1683892306;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6asngVmOq+TTi63ftv80tbHF2c1gAR73aFDLAWFey8s=;
        b=I0NO9mF3b7bbMzgboty0gmpwrQD/H5z+tYscO9jhfF8aloT3kGWsewSo4XSQvx24iD
         +VpWWAHjl/iumJyX0WVBkvQGDiUFPfT2BuxysMKSQAbSJwngxaJnzuGNft+r48CFbDbG
         WIL4Mn+sfFNhVRfffnINXaRJ/k9k+29WOFCmRt8MoqKxA0aNtsuJjH9i2KfhVoe6sluO
         VBO6Jta9vzodvsYfvcjLYRqg8eOBWEBTQAOBzXUapeRMTW/GvOAXT56Kci7kV6pUVSb+
         6pAujR9T0Oz8vhyTOd1CXuj5z2AD07KoSMT11pAlKjC6D0I3/3VoJP5M/U/WfK98oVFl
         xyag==
X-Gm-Message-State: AAQBX9eiH8u4MczqmcQLGoPxZn+iwdCzxC6iiRGimM7D9o5ecHD7Aa+x
	txZ0QjIsmDOUPy+wQ/jJ3NA=
X-Google-Smtp-Source: AKy350aAgryt1t7xcwyNsSX/nzJgzvqb+Wdg8l9IACtgHHnwqC9nWpEcttqnbLXXxua4hQd0SjO74Q==
X-Received: by 2002:ad4:5bed:0:b0:56e:a35b:9aaf with SMTP id k13-20020ad45bed000000b0056ea35b9aafmr3393137qvc.20.1681300305924;
        Wed, 12 Apr 2023 04:51:45 -0700 (PDT)
Received: from ip-172-31-85-199.ec2.internal (ec2-44-201-124-83.compute-1.amazonaws.com. [44.201.124.83])
        by smtp.gmail.com with ESMTPSA id mk7-20020a056214580700b005ef48706138sm3551qvb.97.2023.04.12.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 04:51:45 -0700 (PDT)
Date: Wed, 12 Apr 2023 19:51:43 +0800
From: Xingyuan Mo <hdthky0@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: syzkaller@googlegroups.com, iommu@lists.linux.dev
Subject: KASAN: slab-use-after-free Read in iopt_unmap_iova_range
Message-ID: <ZDabT/uRl/jxFhm0@ip-172-31-85-199.ec2.internal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Recently, when using our tool to fuzz kernel, the following bug was
triggered.

HEAD commit: 09a9639e56c0 ("Linux 6.3-rc6")
git tree: mainline
compiler: gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
kernel config: https://drive.google.com/file/d/1FoYieVV2RhjXXwTcmsUzz8dT6_DN61w8/view?usp=share_link
C reproducer: https://drive.google.com/file/d/1OGmuq_C9DsG78CTMex3Wiq7sPBB6fKkX/view?usp=share_link

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: Xingyuan Mo <hdthky0@gmail.com>

Kernel log:

BUG: KASAN: slab-use-after-free in iopt_unmap_iova_range+0x5ba/0x5f0 drivers/iommu/iommufd/io_pagetable.c:499
Read of size 4 at addr ffff88814fb28984 by task syz-executor410/8190

CPU: 0 PID: 8190 Comm: syz-executor410 Not tainted 6.3.0-rc6 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 iopt_unmap_iova_range+0x5ba/0x5f0 drivers/iommu/iommufd/io_pagetable.c:499
 iopt_unmap_all+0x27/0x50 drivers/iommu/iommufd/io_pagetable.c:555
 iommufd_ioas_unmap+0x3d1/0x480 drivers/iommu/iommufd/ioas.c:300
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5bc153dbdd
Code: c3 e8 97 2a 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64
 89 01 48
RSP: 002b:00007f5bc14c2d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5bc15d12f8 RCX: 00007f5bc153dbdd
RDX: 0000000020000000 RSI: 0000000000003b86 RDI: 0000000000000000
RBP: 00007f5bc15d12f0 R08: 00007f5bc14c3700 R09: 0000000000000000
R10: 00007f5bc14c3700 R11: 0000000000000246 R12: 00007f5bc15d12fc
R13: 00007f5bc159e074 R14: 6d6f692f7665642f R15: 00007f5bc14c2e80
 </TASK>

Allocated by task 8189:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 iopt_alloc_area_pages+0x94/0x560 drivers/iommu/iommufd/io_pagetable.c:234
 iopt_map_pages drivers/iommu/iommufd/io_pagetable.c:339 [inline]
 iopt_map_user_pages+0x205/0x4e0 drivers/iommu/iommufd/io_pagetable.c:404
 iommufd_ioas_map+0x329/0x5f0 drivers/iommu/iommufd/ioas.c:222
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 8189:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 iopt_abort_area drivers/iommu/iommufd/io_pagetable.c:292 [inline]
 iopt_unmap_iova_range+0x288/0x5f0 drivers/iommu/iommufd/io_pagetable.c:509
 iopt_unmap_all+0x27/0x50 drivers/iommu/iommufd/io_pagetable.c:555
 iommufd_ioas_unmap+0x3d1/0x480 drivers/iommu/iommufd/ioas.c:300
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88814fb28900
 which belongs to the cache kmalloc-cg-192 of size 192
The buggy address is located 132 bytes inside of
 freed 192-byte region [ffff88814fb28900, ffff88814fb289c0)

The buggy address belongs to the physical page:
page:ffffea00053eca00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14fb28
memcg:ffff888150318b01
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000200 ffff88801244ddc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff ffff888150318b01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 8173, tgid 8172 (syz-executor410), ts 70683710169, free_ts 67978925587
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4326
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5592
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa9b/0x13e0 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3491
 kmalloc_trace+0x26/0xe0 mm/slab_common.c:1061
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 iommufd_test_alloc_access drivers/iommu/iommufd/selftest.c:534 [inline]
 iommufd_test_create_access drivers/iommu/iommufd/selftest.c:563 [inline]
 iommufd_test+0x124a/0x2720 drivers/iommu/iommufd/selftest.c:810
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1504
 free_unref_page_prepare mm/page_alloc.c:3388 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3483
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc5/0x140 mm/swap.c:129
 folio_put include/linux/mm.h:1309 [inline]
 put_page include/linux/mm.h:1378 [inline]
 anon_pipe_buf_release+0x3fb/0x4c0 fs/pipe.c:138
 pipe_buf_release include/linux/pipe_fs_i.h:203 [inline]
 pipe_read+0x614/0x1110 fs/pipe.c:324
 call_read_iter include/linux/fs.h:1845 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7fa/0x930 fs/read_write.c:470
 ksys_read+0x1ec/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88814fb28880: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88814fb28900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88814fb28980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff88814fb28a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88814fb28a80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
