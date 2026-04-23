Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDD53E9298
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946924; cv=none; b=AV06njB3X8mVz/J2OKjM4dAzivAKaWrj1NypXgv5sHoBw2Z+/KMp7DW1GOOAa8XXqBqKro4TovamL4DscZnr/lNbS/hAzuFAuqAvLOafAKXZtLozuUtCERjl+k9+1QLRbjTf43v66on5R4jEYoqfYX+mhzRxeCuRCtH+gbiVXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946924; c=relaxed/simple;
	bh=rvTOm+n4H7j5Mn3/1QxMu4/oJFA7C15Vx6tiO3azK+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhSBtgMZxuEzcEE/jheXjxNm7MdppLmymGghRGZ6+TNjiyBgbTcupxkB94ccLQ1W50IPz5qIfw8ytynzulq1pBY/QJD8RHUWfvb3jSC9RgjksGCx6vkGzoYdy1OUrsQZ/aOFQTzunrCQ9f94dDYX+Z4m/G7G8JBPLv9FMYIKSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=O9AYXNd7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="O9AYXNd7"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c79506f3c40so2414634a12.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776946917; x=1777551717; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PeMI2tYrxbScjVPqN6uKrbdnroF9iNrBjkzvLk0HbNE=;
        b=O9AYXNd7ETvY3i6MhO44q+/2ZZUyJbJ/OiDsUmoIt5zM8ron+lmtoXION2TRrGSM/e
         30faQqsqRVqs9g2XG094SdPfiz3mwKlF40kF23o86hpqxTqPLNyQgu7jCnjTjnUO/8rd
         68LK6gOfrh2Td/4Xztv3cZ1q1xjvzHwoYLL4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776946917; x=1777551717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeMI2tYrxbScjVPqN6uKrbdnroF9iNrBjkzvLk0HbNE=;
        b=EFToXotoijCKU/iVUErd+Md3sYZUWsaPoPftS5AOfb4AIVldTPnDFVTOpc5K3VG0vW
         nHBDD1a+rD9UF5ND15N3FqJa1l3Fdv5+OJsvj+TCqJni/i0go13HU+Qzopc1PI0yulGb
         XPVtaO8bfjc4dxFVsRxq6Ew+L7BXxTSweGT46EtfS5D1fmd7+k25dKc1lt/CzXHu7lax
         s/nh20J6kKAkaHohGqSR5JVpXqlwhp6Vrl5t6ph+GqMf2SxzMI/yvaMk2GhJXBie+U4T
         ZeAtYQ8zGFmc+R4fZGRxCJWYdDcz6ghkSClcxmYlw3U3KsoXwOU80PiBxqE6Q6b39SY2
         EMEA==
X-Gm-Message-State: AOJu0Yx/LcIfsiN1SOpk9Y8+VxzcYxDvjesps5k9tnFvCZ5eI8Nn4Grj
	NklH19KdmLcduOapGQtYj4YzX2LzFiY7HZiiEKvElfCv24RCCqY5gCpaBfZWkK6UrFM=
X-Gm-Gg: AeBDieu8XZVvQKQUBFRtbmhp+9lhWnFkJe55V9E2afCzV9yIyPeAGdM1WNQY4dIl2C6
	qRcckPSfxmLDD9CxF3Unstg6BpFUwMrf0EMXpuIKFJPf+ywJH5fxbV5s2f5rFeShfSUIJxpKLKg
	tBK0Py5TJnIax6pX3iolOqtQVg5J46aTl6vU1mzjCJgWNCLMskb6PPedtNS/fow1Qi0NTnyKg/s
	Ty8Ub+ZkGdsXfj2mQWVJOzt1bIzDmkWQurhBLq6vSKVXszotuw03X61vCXT3g0U2fUHRoIMhg3s
	NFJNYCt7U2kFYFe8oBejjdLYeDj5vw7pG5Epjyb5MeQIvJK5V0pQUEdZNWpvUZZnPrEDH7WfDki
	TbQEfzDiEAoQGn+kAYOMapBiy4m8wcdu7lc7W59pakMYwd0eecn68GQYjyasshuwfPGwDvpP06F
	IB/5wCi+Yw21KryAGrAdB+gxT1DI94Cent9ek8CnB+ykgyP4n2rGGe/3Ts2umq75ureIkzuYO7a
	Rh6jqNOzb8V
X-Received: by 2002:a05:6a00:4c0b:b0:82c:e4b4:b04f with SMTP id d2e1a72fcca58-82f8c9d598amr26401235b3a.47.1776946917133;
        Thu, 23 Apr 2026 05:21:57 -0700 (PDT)
Received: from eulgyu-desktop.localdomain ([147.46.174.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb28sm19133748b3a.13.2026.04.23.05.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 05:21:56 -0700 (PDT)
From: Eulgyu Kim <eulgyukim@snu.ac.kr>
To: jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	byoungyoung@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: slab-use-after-free Read in __iommufd_test_syz_conv_iova
Date: Thu, 23 Apr 2026 21:21:51 +0900
Message-ID: <20260423122151.1867271-1-eulgyukim@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We encountered a "KASAN: slab-use-after-free Read in __iommufd_test_syz_conv_iova"
on kernel version v7.0.

We have included the following items below:
- C reproducer (~100 lines)
- kernel delay patch
- KASAN crash log

To reliably trigger the race condition bug, we patched the kernel
to inject a delay at a specific point.

The kernel config used is the same as the syzbot configuration.

Unfortunately, we do not have a fix ready for this bug yet.
As this issue was identified via fuzzing and we have limited background,
we find it challenging to propose a correct fix or evaluate
its potential severity.

We hope this report helps address the issue. Please let us know
if any further information is needed.

Thank you.

Best Regards,
Eulgyu Kim



kernel delay patch:
==================================================================
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 782314209..413b631e6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
+#include <linux/delay.h>
 #include <uapi/linux/iommufd.h>
 #include <linux/generic_pt/iommu.h>
 #include "../iommu-pages.h"
@@ -72,6 +73,8 @@ static unsigned long __iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
             area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
                if (nth == 0) {
                        up_read(&iopt->iova_rwsem);
+                       if (!strcmp(current->comm, "slowme"))
+                               mdelay(2000);
                        return iopt_area_iova(area) + syz->offset;
                }
                nth--;
==================================================================



C reproducer:
==================================================================
#define _GNU_SOURCE

#include <fcntl.h>
#include <pthread.h>
#include <stdint.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include <unistd.h>

#define MAP_SIZE 0x1000
#define IOMMUFD_TYPE ';'

#define IOMMU_IOAS_ALLOC _IO(IOMMUFD_TYPE, 0x81)
#define IOMMU_IOAS_COPY _IO(IOMMUFD_TYPE, 0x83)
#define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, 0x85)
#define IOMMU_IOAS_UNMAP _IO(IOMMUFD_TYPE, 0x86)

#define IOMMU_IOAS_MAP_WRITEABLE (1U << 1)
#define IOMMU_IOAS_MAP_READABLE (1U << 2)
#define MOCK_FLAGS_ACCESS_SYZ (1U << 16)

struct iommu_ioas_alloc {
	uint32_t size;
	uint32_t flags;
	uint32_t out_ioas_id;
};

struct iommu_ioas_map {
	uint32_t size;
	uint32_t flags;
	uint32_t ioas_id;
	uint32_t __reserved;
	uint64_t user_va;
	uint64_t length;
	uint64_t iova;
};

struct iommu_ioas_copy {
	uint32_t size;
	uint32_t flags;
	uint32_t dst_ioas_id;
	uint32_t src_ioas_id;
	uint64_t length;
	uint64_t dst_iova;
	uint64_t src_iova;
};

struct iommu_ioas_unmap {
	uint32_t size;
	uint32_t ioas_id;
	uint64_t iova;
	uint64_t length;
};

static int fd;
static uint32_t ioas_id;

static void *copy_thread()
{
	struct iommu_ioas_copy copy = {
		.size = sizeof(copy),
		.flags = IOMMU_IOAS_MAP_READABLE | MOCK_FLAGS_ACCESS_SYZ,
		.dst_ioas_id = ioas_id,
		.src_ioas_id = ioas_id,
		.length = MAP_SIZE,
		.src_iova = 0,
	};

	prctl(PR_SET_NAME, "slowme", 0, 0, 0);
	ioctl(fd, IOMMU_IOAS_COPY, &copy);
	return NULL;
}

int main(void)
{
	pthread_t th;
	void *buf;
	struct iommu_ioas_alloc alloc = {
		.size = sizeof(alloc),
	};
	struct iommu_ioas_map map = {
		.size = sizeof(map),
		.flags = IOMMU_IOAS_MAP_READABLE | IOMMU_IOAS_MAP_WRITEABLE,
		.length = MAP_SIZE,
	};
	struct iommu_ioas_unmap unmap = {
		.size = sizeof(unmap),
		.iova = 0,
		.length = UINT64_MAX,
	};

	fd = open("/dev/iommu", O_RDWR);
	buf = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	memset(buf, 0x41, MAP_SIZE);

	ioctl(fd, IOMMU_IOAS_ALLOC, &alloc);

	ioas_id = alloc.out_ioas_id;
	map.ioas_id = ioas_id;
	map.user_va = (uintptr_t)buf;
	ioctl(fd, IOMMU_IOAS_MAP, &map);

	pthread_create(&th, NULL, copy_thread, NULL);
	
	sleep(1);
	unmap.ioas_id = ioas_id;
	ioctl(fd, IOMMU_IOAS_UNMAP, &unmap);
	
	return 0;
}

==================================================================



KASAN crash log:
==================================================================
BUG: KASAN: slab-use-after-free in iopt_area_iova drivers/iommu/iommufd/io_pagetable.h:95 [inline]
BUG: KASAN: slab-use-after-free in __iommufd_test_syz_conv_iova+0x183/0x220 drivers/iommu/iommufd/selftest.c:78
Read of size 8 at addr ffff888116171c18 by task slowme/10158
CPU: 6 UID: 0 PID: 10158 Comm: slowme Not tainted 7.0.0-g398249279dc5 #28 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 iopt_area_iova drivers/iommu/iommufd/io_pagetable.h:95 [inline]
 __iommufd_test_syz_conv_iova+0x183/0x220 drivers/iommu/iommufd/selftest.c:78
 iommufd_test_syz_conv_iova_id+0xd4/0x230 drivers/iommu/iommufd/selftest.c:114
 iommufd_ioas_copy+0x12c/0x720 drivers/iommu/iommufd/ioas.c:293
 iommufd_fops_ioctl+0x45e/0x580 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x41598d
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007fc4cdb7a1b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc4cdb7acdc RCX: 000000000041598d
RDX: 00007fc4cdb7a210 RSI: 0000000000003b83 RDI: 0000000000000003
RBP: 00007fc4cdb7a200 R08: 0000000000000000 R09: 00007fc4cdb7a6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc4cdb7a6c0
R13: ffffffffffffffb8 R14: 0000000000000000 R15: 00007fffd466f630
 </TASK>
Allocated by task 10157:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x321/0x670 mm/slub.c:5380
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 iopt_area_alloc drivers/iommu/iommufd/io_pagetable.c:248 [inline]
 iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:267 [inline]
 iopt_map_pages+0x122/0x1070 drivers/iommu/iommufd/io_pagetable.c:381
 iopt_map_common+0x2bb/0x4f0 drivers/iommu/iommufd/io_pagetable.c:425
 iopt_map_user_pages+0xbc/0xd0 drivers/iommu/iommufd/io_pagetable.c:466
 iommufd_ioas_map+0x392/0x4c0 drivers/iommu/iommufd/ioas.c:270
 iommufd_fops_ioctl+0x45e/0x580 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Freed by task 10157:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kfree+0x1c3/0x640 mm/slub.c:6483
 iopt_abort_area drivers/iommu/iommufd/io_pagetable.c:334 [inline]
 iopt_unmap_iova_range+0x351/0x570 drivers/iommu/iommufd/io_pagetable.c:811
 iommufd_ioas_unmap+0x23d/0x4f0 drivers/iommu/iommufd/ioas.c:352
 iommufd_fops_ioctl+0x45e/0x580 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
The buggy address belongs to the object at ffff888116171c00
 which belongs to the cache kmalloc-cg-192 of size 192
The buggy address is located 24 bytes inside of
 freed 192-byte region [ffff888116171c00, ffff888116171cc0)
The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x116170
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88811ace6601
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff88810004b540 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800200020 00000000f5000000 ffff88811ace6601
head: 017ff00000000040 ffff88810004b540 dead000000000100 dead000000000122
head: 0000000000000000 0000000800200020 00000000f5000000 ffff88811ace6601
head: 017ff00000000001 ffffea0004585c01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 5217675454, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x23d/0x2a0 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24e0/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x77/0x670 mm/slub.c:3481
 new_slab mm/slub.c:3539 [inline]
 refill_objects+0x33a/0x3d0 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 alloc_full_sheaf mm/slub.c:2834 [inline]
 __pcs_replace_empty_main+0x40c/0x730 mm/slub.c:4626
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 __do_kmalloc_node mm/slub.c:5259 [inline]
 __kmalloc_noprof+0x473/0x770 mm/slub.c:5272
 kmalloc_noprof include/linux/slab.h:954 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 __register_sysctl_table+0x72/0x1340 fs/proc/proc_sysctl.c:1379
 i915_perf_sysctl_register+0x21/0x30 drivers/gpu/drm/i915/i915_perf.c:5182
 i915_init+0x5a/0x120 drivers/gpu/drm/i915/i915_module.c:87
 do_one_initcall+0x1f1/0x880 init/main.c:1382
 do_initcall_level+0x104/0x190 init/main.c:1444
 do_initcalls+0x59/0xa0 init/main.c:1460
 kernel_init_freeable+0x2a7/0x3e0 init/main.c:1692
 kernel_init+0x1d/0x1d0 init/main.c:1582
 ret_from_fork+0x513/0xba0 arch/x86/kernel/process.c:158
page_owner free stack trace missing
Memory state around the buggy address:
 ffff888116171b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888116171b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888116171c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888116171c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888116171d00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
