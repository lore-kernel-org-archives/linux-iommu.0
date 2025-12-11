Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B5946C
	for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 03:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765423585; cv=none; b=hFnwKTir9oFqhghzlBi4uuI7DMNGY2xbh3P+IYCe4RSfVwlb6QU8K5fTqpJiMYdi5A/F76iBFIXL9hmaTol9C7I82hKEd9nkg/J1YBylrHUolP7fZZkDDgF3RIsg2Hr3qjuML+p/6NpTnDlF2VB2vy+n6X5+N/fvt3KIcKRquLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765423585; c=relaxed/simple;
	bh=klNGCBt6YuSvlqu7yRNzb6h6r1bUjX8hISme8ZHiVis=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e+g4BWngm1MX8dVeaqMTfQHlMUiqRfamKCBcUtsiO95SYYHR3+mTWVkuFTLUFPxtmBn5LeUyjR3NiVpUdvkMy60jrzqDd+Jrjyq/T90mLUZ7V2DnW53zdZVO5uBZwd5M8lP9lcRzl9p72UugkW8b/NZnqlbjVeeMeSP8bOxSed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-656b2edce07so917476eaf.0
        for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 19:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765423583; x=1766028383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57hsFZoh7Pk00KLKsDzTbCpl4xO4RAK+OPRa9h3ftNk=;
        b=ZWjQcPAYYH0k/cYPH5udQLUd0EjfYRdKpbuER//sRWXR6xR3yJLTlwg7HPLt2i+xGP
         RploWpDq7L+gFHSPaxGW9zG2baW7UQZAmP+LbQVxCN7dUVP19jFDuhLhRn1OAt04QyKO
         C2TxeFjmj+YFeMpmQs+/lM/kmBDlzdjwDPzjbgkVxA69rn0mZhC5gB/HulktpfllkMdH
         Xk4WET6+MXV5mC/E0T4JSi1sBN0dVFJGfTK4WGUzn16NTQAxKOfcKQYFTKQUDTNHKlNM
         JXtF3ambZaQ5UoA6wpKMnAzMzf0FakhAie3bx1H2G4Hix4BsHGdUuruGhlrGXGCOeq72
         0/WQ==
X-Gm-Message-State: AOJu0YwlYdr3B3OoCkbNq6RuL2DxDSIGr+29wxgboUzt5Xy6aD6kcCi+
	UA3alIvk4fUkE1zPtOtGjEFhgPcgnqCoi+wBJUWE4EfP0zHQTYhvUyVJITTymvhG8HG3XDJJwPT
	wXpGyJTq1Q4K7B+q/AJkASFLERnYWXg/EFENG64oheigEnPnLW6n/HepuBGXTNw==
X-Google-Smtp-Source: AGHT+IGtjo97LZF4/j8qcQKqczjVRbiVChvKpdhO6AdCovWa+w4B/qyYhXGitNkNipZ89Vqm3tHLZoRVOahW4iE2t4u0hc5BGASP
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:189a:b0:659:9a49:8f40 with SMTP id
 006d021491bc7-65b2ada16bfmr2629446eaf.81.1765423582986; Wed, 10 Dec 2025
 19:26:22 -0800 (PST)
Date: Wed, 10 Dec 2025 19:26:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693a39de.050a0220.4004e.02ce.GAE@google.com>
Subject: [syzbot] [iommu?] kernel BUG in iommu_pages_start_incoherent
From: syzbot <syzbot+e06bb7478e687f235ad7@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, joro@8bytes.org, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c06c303832ec ocfs2: fix xattr array entry __counted_by error
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175a2992580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3ce1cfe3996fc8b
dashboard link: https://syzkaller.appspot.com/bug?extid=e06bb7478e687f235ad7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c06c3038.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa14148a2ef4/vmlinux-c06c3038.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2d5f3a106bf/bzImage-c06c3038.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e06bb7478e687f235ad7@syzkaller.appspotmail.com

Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:73 [inline]
 should_fail_ex+0x414/0x560 lib/fault-inject.c:174
 prepare_alloc_pages+0x22b/0x650 mm/page_alloc.c:4985
 __alloc_frozen_pages_noprof+0x123/0x370 mm/page_alloc.c:5199
 __alloc_pages_noprof mm/page_alloc.c:5244 [inline]
 __folio_alloc_noprof+0x18/0x120 mm/page_alloc.c:5254
 __folio_alloc_node_noprof include/linux/gfp.h:296 [inline]
 iommu_alloc_pages_node_sz+0x152/0x320 drivers/iommu/iommu-pages.c:66
 _table_alloc drivers/iommu/generic_pt/iommu_pt.h:373 [inline]
 table_alloc drivers/iommu/generic_pt/iommu_pt.h:408 [inline]
 pt_iommu_new_table drivers/iommu/generic_pt/iommu_pt.h:424 [inline]
 __map_range+0x1f2/0xa80 drivers/iommu/generic_pt/iommu_pt.h:584
 pt_descend drivers/iommu/generic_pt/pt_iter.h:391 [inline]
 __map_range+0x511/0xa80 drivers/iommu/generic_pt/iommu_pt.h:619
 pt_descend drivers/iommu/generic_pt/pt_iter.h:391 [inline]
 __map_range+0x511/0xa80 drivers/iommu/generic_pt/iommu_pt.h:619
 pt_iommu_vtdss_map_pages+0x6a3/0x960 drivers/iommu/generic_pt/iommu_pt.h:905
 iommu_map_nosync+0x30a/0x840 drivers/iommu/iommu.c:2549
 iommu_map_sg+0x579/0xae0 drivers/iommu/iommu.c:2721
 iommu_dma_map_sg+0x908/0x1000 drivers/iommu/dma-iommu.c:1493
 __dma_map_sg_attrs+0xd0/0x520 kernel/dma/mapping.c:245
 dma_map_sg_attrs+0x32/0x50 kernel/dma/mapping.c:284
 ata_sg_setup drivers/ata/libata-core.c:4773 [inline]
 ata_qc_issue+0x515/0xf30 drivers/ata/libata-core.c:5085
 ata_scsi_translate drivers/ata/libata-scsi.c:1755 [inline]
 __ata_scsi_queuecmd+0x957/0xf60 drivers/ata/libata-scsi.c:4355
 ata_scsi_queuecmd+0x3d4/0x5c0 drivers/ata/libata-scsi.c:4400
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1638 [inline]
 scsi_queue_rq+0x18bc/0x30d0 drivers/scsi/scsi_lib.c:1895
 blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2137
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
 __blk_mq_sched_dispatch_requests+0xdac/0x1570 block/blk-mq-sched.c:307
 blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
 blk_mq_run_hw_queue+0x404/0x4f0 block/blk-mq.c:2375
 blk_mq_dispatch_list+0xd0b/0xe00 include/linux/spinlock.h:-1
 blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2986
 blk_add_rq_to_plug+0x175/0x450 block/blk-mq.c:1407
 blk_mq_submit_bio+0xd5b/0x26b0 block/blk-mq.c:3232
 __submit_bio+0x207/0x5a0 block/blk-core.c:637
 __submit_bio_noacct_mq block/blk-core.c:724 [inline]
 submit_bio_noacct_nocheck+0x377/0xa30 block/blk-core.c:755
 __blkdev_direct_IO+0x915/0xf90 block/fops.c:264
 blkdev_direct_IO+0x1261/0x17e0 block/fops.c:441
 blkdev_direct_write+0x7c/0x140 block/fops.c:727
 blkdev_write_iter+0x547/0x710 block/fops.c:795
 do_iter_readv_writev+0x623/0x8c0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_writev+0x14d/0x2d0 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae01b8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae02b02038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fae01de5fa0 RCX: 00007fae01b8f7c9
RDX: 0000000000000021 RSI: 0000200000000a40 RDI: 0000000000000004
RBP: 00007fae02b02090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fae01de6038 R14: 00007fae01de5fa0 R15: 00007ffd45480c38
 </TASK>
------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__phys_addr+0x16b/0x180 arch/x86/mm/physaddr.c:28
Code: 8b b3 00 e9 45 ff ff ff e8 b2 af 4b 00 48 c7 c7 f0 33 fb 8d 48 89 de 4c 89 f2 e8 50 c0 52 03 e9 4d ff ff ff e8 96 af 4b 00 90 <0f> 0b e8 8e af 4b 00 90 0f 0b e8 86 af 4b 00 90 0f 0b 0f 1f 00 90
RSP: 0018:ffffc9000aae5f80 EFLAGS: 00010093
RAX: ffffffff817610fa RBX: 0000778000000000 RCX: ffff8880007ca4c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000778000000000
RBP: ffffc9000aae6130 R08: ffffffff8e26c433 R09: 1ffffffff1c4d886
R10: dffffc0000000000 R11: fffffbfff1c4d887 R12: 0000000000000011
R13: dffffc0000000000 R14: 0000000080000000 R15: dffffc0000000000
FS:  00007fae02b026c0(0000) GS:ffff88808d23e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fae01d2dea0 CR3: 000000000b669000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1432 [inline]
 virt_to_ioptdesc drivers/iommu/iommu-pages.h:49 [inline]
 iommu_pages_start_incoherent+0x52/0x310 drivers/iommu/iommu-pages.c:148
 _table_alloc drivers/iommu/generic_pt/iommu_pt.h:377 [inline]
 table_alloc drivers/iommu/generic_pt/iommu_pt.h:408 [inline]
 pt_iommu_new_table drivers/iommu/generic_pt/iommu_pt.h:424 [inline]
 __map_range+0x270/0xa80 drivers/iommu/generic_pt/iommu_pt.h:584
 pt_descend drivers/iommu/generic_pt/pt_iter.h:391 [inline]
 __map_range+0x511/0xa80 drivers/iommu/generic_pt/iommu_pt.h:619
 pt_descend drivers/iommu/generic_pt/pt_iter.h:391 [inline]
 __map_range+0x511/0xa80 drivers/iommu/generic_pt/iommu_pt.h:619
 pt_iommu_vtdss_map_pages+0x6a3/0x960 drivers/iommu/generic_pt/iommu_pt.h:905
 iommu_map_nosync+0x30a/0x840 drivers/iommu/iommu.c:2549
 iommu_map_sg+0x579/0xae0 drivers/iommu/iommu.c:2721
 iommu_dma_map_sg+0x908/0x1000 drivers/iommu/dma-iommu.c:1493
 __dma_map_sg_attrs+0xd0/0x520 kernel/dma/mapping.c:245
 dma_map_sg_attrs+0x32/0x50 kernel/dma/mapping.c:284
 ata_sg_setup drivers/ata/libata-core.c:4773 [inline]
 ata_qc_issue+0x515/0xf30 drivers/ata/libata-core.c:5085
 ata_scsi_translate drivers/ata/libata-scsi.c:1755 [inline]
 __ata_scsi_queuecmd+0x957/0xf60 drivers/ata/libata-scsi.c:4355
 ata_scsi_queuecmd+0x3d4/0x5c0 drivers/ata/libata-scsi.c:4400
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1638 [inline]
 scsi_queue_rq+0x18bc/0x30d0 drivers/scsi/scsi_lib.c:1895
 blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2137
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
 __blk_mq_sched_dispatch_requests+0xdac/0x1570 block/blk-mq-sched.c:307
 blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
 blk_mq_run_hw_queue+0x404/0x4f0 block/blk-mq.c:2375
 blk_mq_dispatch_list+0xd0b/0xe00 include/linux/spinlock.h:-1
 blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2986
 blk_add_rq_to_plug+0x175/0x450 block/blk-mq.c:1407
 blk_mq_submit_bio+0xd5b/0x26b0 block/blk-mq.c:3232
 __submit_bio+0x207/0x5a0 block/blk-core.c:637
 __submit_bio_noacct_mq block/blk-core.c:724 [inline]
 submit_bio_noacct_nocheck+0x377/0xa30 block/blk-core.c:755
 __blkdev_direct_IO+0x915/0xf90 block/fops.c:264
 blkdev_direct_IO+0x1261/0x17e0 block/fops.c:441
 blkdev_direct_write+0x7c/0x140 block/fops.c:727
 blkdev_write_iter+0x547/0x710 block/fops.c:795
 do_iter_readv_writev+0x623/0x8c0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_writev+0x14d/0x2d0 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae01b8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae02b02038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fae01de5fa0 RCX: 00007fae01b8f7c9
RDX: 0000000000000021 RSI: 0000200000000a40 RDI: 0000000000000004
RBP: 00007fae02b02090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fae01de6038 R14: 00007fae01de5fa0 R15: 00007ffd45480c38
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x16b/0x180 arch/x86/mm/physaddr.c:28
Code: 8b b3 00 e9 45 ff ff ff e8 b2 af 4b 00 48 c7 c7 f0 33 fb 8d 48 89 de 4c 89 f2 e8 50 c0 52 03 e9 4d ff ff ff e8 96 af 4b 00 90 <0f> 0b e8 8e af 4b 00 90 0f 0b e8 86 af 4b 00 90 0f 0b 0f 1f 00 90
RSP: 0018:ffffc9000aae5f80 EFLAGS: 00010093
RAX: ffffffff817610fa RBX: 0000778000000000 RCX: ffff8880007ca4c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000778000000000
RBP: ffffc9000aae6130 R08: ffffffff8e26c433 R09: 1ffffffff1c4d886
R10: dffffc0000000000 R11: fffffbfff1c4d887 R12: 0000000000000011
R13: dffffc0000000000 R14: 0000000080000000 R15: dffffc0000000000
FS:  00007fae02b026c0(0000) GS:ffff88808d23e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fae01d2dea0 CR3: 000000000b669000 CR4: 0000000000352ef0


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
