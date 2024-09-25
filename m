Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587113AD3F
	for <iommu@lists.linux.dev>; Wed, 25 Sep 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271932; cv=none; b=ugVLAD/F0I1Gx8GWfm+uzqKCj7f6dk1IQGeam30om/zMp2kGyAPvUKSoc2qEpsaeLPNnOjYR5zW0Q4fNpW3FwcAZ+h7ZZNT6bfzYWCOp1yXWM+EibnYLhiZbZNSjKrLbbxAfhR20SYXLJdp9/iH+aMmdSI20+wDgRzz6snQDWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271932; c=relaxed/simple;
	bh=+ZKG31H3fAaEzdcyYn09k2egXs3dE0H/T+D5GvxwY9I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YJkzwo5NA8BHfkw3X5HqAEsiPEW5RHGcWR51h+pVVUoBeN3YMQma+crJG0+OaSlGle0rcrO7Z9Poi/xJxOcL+lR5kopUB88fTgCqn9HKMOEdPYxvMfLc/PJ8pmAzqfScvWeAoyWCmOdZtoAgGxWypGEr1gBk3mlxzohx45ADUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso76152155ab.1
        for <iommu@lists.linux.dev>; Wed, 25 Sep 2024 06:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727271930; x=1727876730;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=is1K5gecx6xdHsjAhZUx+Z6qmkYUnW93aVWBJa+eg4Q=;
        b=HE5qximOKGu8pIYq94iqlHTUugYVZOr4ASDWwQtDaP1N0cZllvbm6K07g7R1NlByU6
         usMmApLLVsu8XwwnZ6NNpwGW/MKKCjuPFtRVr99Hgu+48ZAFMhQHQW7pLf7rMb+I8w14
         pEIBvR6Knml599VkKcV9CUn2ywRrME++fIgDzZ2HhPne14dHYZ/P3cFmF8PdapdXm0Zj
         SjnmaJG0brvXx8VhtNtkNAwoU13VCIhYaQX9F+juBunOriqs4UzxVE3FLHnbBegubdH+
         iKgj6QP3FSRBL5F5g0PzjFzO2GuZNoEPqcBN95ul3p0BCP8Vh/9pqt/70Yqlp9wj5VYM
         Am+g==
X-Forwarded-Encrypted: i=1; AJvYcCWOwUtDSlKli3FLd/okYw4kp7nc1JUPTFjJJTqc9KHam3OpekNg3WdYZIXmhGqPiufvjfFo1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhU4BBJKXANra5UrpHukK5Ngx9xgvdJ093LYzZO/YbvRzp+/nI
	/K9/TC1XFJN2w298StxMJcJQWfqq1lvKKOywDawfnpvhm+ITidZ1qO2exJOqzHaXYBz4LB34o+D
	Jb3GZMZMHHGq46GlWJ8+Ae8FudUCye3X5yueIARAEJnErxYHlWujlAEU=
X-Google-Smtp-Source: AGHT+IGyrBZWFKg0GpuC3WhVxj7WTGQ8sPoK2Ow+DRtwUWnlP5ZssBnuWTy07h4RgwmjzTKdD/f0fkIXBFtgKvyfzomLIIfFBsF7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:396:e8b8:88d with SMTP id
 e9e14a558f8ab-3a26d77492amr31042835ab.11.1727271930011; Wed, 25 Sep 2024
 06:45:30 -0700 (PDT)
Date: Wed, 25 Sep 2024 06:45:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f413f9.050a0220.211276.0031.GAE@google.com>
Subject: [syzbot] [iommu?] kernel BUG in trace_dma_map_sg
From: syzbot <syzbot+d409db2070842f867cd1@syzkaller.appspotmail.com>
To: hch@lst.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1868f9d0260e Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d11e9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0b35925215243c6
dashboard link: https://syzkaller.appspot.com/bug?extid=d409db2070842f867cd1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1868f9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79ecea60635a/vmlinux-1868f9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e88a1660d19/bzImage-1868f9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d409db2070842f867cd1@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name fail_usercopy, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5101 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-07462-g1868f9d0260e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:153
 _inline_copy_to_user include/linux/uaccess.h:177 [inline]
 _copy_to_user+0x2f/0xb0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 simple_read_from_buffer+0xca/0x150 fs/libfs.c:1124
 proc_fail_nth_read+0x1e9/0x250 fs/proc/base.c:1481
 vfs_read+0x201/0xbc0 fs/read_write.c:567
 ksys_read+0x1a0/0x2c0 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f145197c93c
Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 69 8e 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 bf 8e 02 00 48
RSP: 002b:00007f1452852030 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1451b35f80 RCX: 00007f145197c93c
RDX: 000000000000000f RSI: 00007f14528520a0 RDI: 0000000000000004
RBP: 00007f1452852090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f1451b35f80 R15: 00007ffd70304738
 </TASK>
------------[ cut here ]------------
kernel BUG at include/linux/scatterlist.h:171!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5101 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-07462-g1868f9d0260e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:sg_page include/linux/scatterlist.h:171 [inline]
RIP: 0010:sg_phys include/linux/scatterlist.h:389 [inline]
RIP: 0010:perf_trace_dma_map_sg+0xf34/0xf40 include/trace/events/dma.h:178
Code: 00 00 00 fc ff df e9 60 fc ff ff e8 c6 81 17 00 48 c7 c7 40 84 94 8e 4c 89 f6 e8 a7 70 72 03 e9 e3 f2 ff ff e8 ad 81 17 00 90 <0f> 0b e8 b5 eb 41 0a 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0000:ffffc9000308e9e0 EFLAGS: 00010093
RAX: ffffffff817d3d73 RBX: ffffe8ffffc40d6d RCX: ffff88801fb54880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000308eb40 R08: ffffffff817d33c4 R09: 322e66313a30303a
R10: dffffc0000000000 R11: fffff91ffff881ae R12: ffff888000ae26a8
R13: 0000000000000038 R14: 0000000000000008 R15: ffff88804b9e1781
FS:  00007f14528526c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14519dc900 CR3: 000000001ffb0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_dma_map_sg+0x1da/0x240 include/trace/events/dma.h:178
 __dma_map_sg_attrs+0x106/0x1a0 kernel/dma/mapping.c:222
 dma_map_sg_attrs+0x34/0x50 kernel/dma/mapping.c:254
 ata_sg_setup drivers/ata/libata-core.c:4651 [inline]
 ata_qc_issue+0x4cf/0xf40 drivers/ata/libata-core.c:4963
 ata_scsi_translate drivers/ata/libata-scsi.c:1760 [inline]
 __ata_scsi_queuecmd+0x9fb/0x1030 drivers/ata/libata-scsi.c:4189
 ata_scsi_queuecmd+0x3bb/0x530 drivers/ata/libata-scsi.c:4234
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1608 [inline]
 scsi_queue_rq+0x1d7c/0x2e90 drivers/scsi/scsi_lib.c:1850
 blk_mq_dispatch_rq_list+0xb89/0x1b30 block/blk-mq.c:2032
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xcb/0x140 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x9a5/0xae0 block/blk-mq.c:2245
 blk_mq_flush_plug_list+0x1127/0x1890 block/blk-mq.c:2797
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1199
 blk_finish_plug+0x5e/0x80 block/blk-core.c:1226
 read_pages+0x644/0x840 mm/readahead.c:183
 page_cache_ra_unbounded+0x24c/0x8a0 mm/readahead.c:257
 do_sync_mmap_readahead+0x499/0x970
 filemap_fault+0x820/0x1750 mm/filemap.c:3325
 __do_fault+0x135/0x460 mm/memory.c:4670
 do_read_fault mm/memory.c:5076 [inline]
 do_fault mm/memory.c:5206 [inline]
 do_pte_missing mm/memory.c:3962 [inline]
 handle_pte_fault+0x3228/0x7010 mm/memory.c:5536
 __handle_mm_fault mm/memory.c:5679 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:5847
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f1451951958
Code: 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 62 e2 7d 28 7a ce 89 f8 25 ff 0f 00 00 3d e0 0f 00 00 0f 87 b8 01 00 00 <62> e1 fe 28 6f 17 62 a1 f5 20 ef da 62 a1 6d 20 da db 62 b2 66 20
RSP: 002b:00007f145284f8b8 EFLAGS: 00010283
RAX: 0000000000000900 RBX: 00007f145284fe30 RCX: 0000000000000000
RDX: 00007f1452851f78 RSI: 0000000000000025 RDI: 00007f14519dc900
RBP: 00000000fbad8004 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f145284fe10
R13: 00007f1452851f78 R14: 00007f1451b35f80 R15: 00007ffd70304738
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sg_page include/linux/scatterlist.h:171 [inline]
RIP: 0010:sg_phys include/linux/scatterlist.h:389 [inline]
RIP: 0010:perf_trace_dma_map_sg+0xf34/0xf40 include/trace/events/dma.h:178
Code: 00 00 00 fc ff df e9 60 fc ff ff e8 c6 81 17 00 48 c7 c7 40 84 94 8e 4c 89 f6 e8 a7 70 72 03 e9 e3 f2 ff ff e8 ad 81 17 00 90 <0f> 0b e8 b5 eb 41 0a 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0000:ffffc9000308e9e0 EFLAGS: 00010093
RAX: ffffffff817d3d73 RBX: ffffe8ffffc40d6d RCX: ffff88801fb54880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000308eb40 R08: ffffffff817d33c4 R09: 322e66313a30303a
R10: dffffc0000000000 R11: fffff91ffff881ae R12: ffff888000ae26a8
R13: 0000000000000038 R14: 0000000000000008 R15: ffff88804b9e1781
FS:  00007f14528526c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14519dc900 CR3: 000000001ffb0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
