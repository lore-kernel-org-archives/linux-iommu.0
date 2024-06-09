Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D6542071
	for <iommu@lists.linux.dev>; Sun,  9 Jun 2024 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717939411; cv=none; b=k+ZiLEHvDgmTevDISMnI2EwTRSaffK7Is1n2CpF9JUWMfjKpTsMJ6wgLuevmZpWRgywAwMF2Siec0FCVLEplkXkKeACAJ76UbE2P+y2zNt7mA8dQVHbabVtTLGM4wbjxHKwtuDNaaAAC3RXUqM4U9IYoONEiWfFe5rqYXcxW6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717939411; c=relaxed/simple;
	bh=B0r8b/jAHsefhlfdZ48avZFS/6czpF9hmwvgYAEAzU4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R3EduGehJ89Bn4I4YhPkg08Qa2FIVc7UYt19ZGk8h6EFJjkqc/OFaytL0BnZlJVTkbh/mA92g2fSXkVtIf/BqUaLj/C1BsTznykAfzAXL+e66FNZbJ8LMqRbe1WE7x5jCApiXHPuLDoh13w3lv0hYpGcSzzkcF1AJTxdehVrsxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so444986139f.2
        for <iommu@lists.linux.dev>; Sun, 09 Jun 2024 06:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717939409; x=1718544209;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndDzAK+vS/lqj0cA5nY0ecgAvAllUyEKdFmgWGwIrws=;
        b=EOt92qWMnotPY9bxSW9GA33/k0Gc0x68EchkBZIc1Y1W0AxqDgIjfmIJ76klNVD5DE
         iWZoXNRwkhmfDpZxtmI/TCenOXKK7Ewrl3WSWF0/VjuEmwmNpBkw9suCS0uAWfPD3lab
         VCLyh+grg9NJsMkakSAqfBN6fliQqB9dkr4nuhQbLsnYxm5u9Ait3A1dl2iRq85OKn3B
         GDe+q5/syKmEpECqdkR5dIMqY3hPdzHg1S1cSNWTnzVWE2bPHYCDinjMHMZ+MRH+61gu
         ojq06CWyxYl54j7syn10k4UcB7lQQGq7qij0orpx9KD4LzhBiby7DkAAfFF81SZInFEr
         pozQ==
X-Gm-Message-State: AOJu0YyQFxGSQEBiZBYLs46ofYpydI61359J1nVlIqnzZByeFJ3Kh6wq
	NirUOt+QPkaqg1bvnXVI4W6RlHwgTXcdbNCWvMDfukZlwwy5H09PsdoYJ+p+STQPCjZ2pEuK8c2
	nxGIEIIfvc7cuNq6dGLRsLeU41RE0PEQH6tMgipAIkj/idWyiDYc4+zoPsQ==
X-Google-Smtp-Source: AGHT+IEfPa5yFAkh8lwyvR/wMC8EgcDCwA2xWjDIrZ/+eiIrsLv5+QOog+H8tSRnXXiSlpkjmVz3Jr5sCWHka7n8O56AWVgS9Wf8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4121:b0:4b7:ca39:5869 with SMTP id
 8926c6da1cb9f-4b7ca395b64mr329855173.6.1717939409024; Sun, 09 Jun 2024
 06:23:29 -0700 (PDT)
Date: Sun, 09 Jun 2024 06:23:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000388410061a74f014@google.com>
Subject: [syzbot] [iommu?] WARNING in iopt_map_pages
From: syzbot <syzbot+16073ebbc4c64b819b47@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32f88d65f01b Merge tag 'linux_kselftest-fixes-6.10-rc3' of..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1360240a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0e2e3f7ede77526
dashboard link: https://syzkaller.appspot.com/bug?extid=16073ebbc4c64b819b47
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176155f2980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ef6d64980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/02b9da12baef/disk-32f88d65.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f0b1ac64a11/vmlinux-32f88d65.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d97bebf9fd91/bzImage-32f88d65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16073ebbc4c64b819b47@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5091 at drivers/iommu/iommufd/io_pagetable.c:268 iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:268 [inline]
WARNING: CPU: 0 PID: 5091 at drivers/iommu/iommufd/io_pagetable.c:268 iopt_map_pages+0xf95/0x1050 drivers/iommu/iommufd/io_pagetable.c:352
Modules linked in:
CPU: 0 PID: 5091 Comm: syz-executor391 Not tainted 6.10.0-rc2-syzkaller-00022-g32f88d65f01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:268 [inline]
RIP: 0010:iopt_map_pages+0xf95/0x1050 drivers/iommu/iommufd/io_pagetable.c:352
Code: fc e9 a4 f3 ff ff e8 9a 9f 4b fc 41 be e4 ff ff ff e9 8a f3 ff ff e8 8a 9f 4b fc 90 0f 0b 90 e9 37 f5 ff ff e8 7c 9f 4b fc 90 <0f> 0b 90 e9 68 f3 ff ff 48 c7 c1 6c 78 ad 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90002d4f9e0 EFLAGS: 00010293
RAX: ffffffff854a7704 RBX: 00000000ffffffef RCX: ffff88801978bc00
RDX: 0000000000000000 RSI: 00000000ffffffef RDI: 0000000000000000
RBP: ffffc90002d4fc50 R08: ffffffff854a7290 R09: ffffffff854a70a2
R10: 0000000000000002 R11: ffff88801978bc00 R12: ffff888021c4b010
R13: 0000000000000000 R14: 1ffff920005a9f68 R15: ffffc90002d4fd00
FS:  0000555563931380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000073cd8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommufd_ioas_copy+0x610/0x7b0 drivers/iommu/iommufd/ioas.c:274
 iommufd_fops_ioctl+0x4d9/0x5a0 drivers/iommu/iommufd/main.c:421
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f83aa0f1b39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd80781a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f83aa0f1b39
RDX: 0000000020000140 RSI: 0000000000003b83 RDI: 0000000000000003
RBP: 00007f83aa1645f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
