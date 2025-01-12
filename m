Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155FE2581
	for <iommu@lists.linux.dev>; Sun, 12 Jan 2025 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736664323; cv=none; b=sxnh9DD+CLpZE8//p/vvUECMiOTVx8LSvW+fE5Vs1yNO+E+T//NzvDjuIH+prtm9VqaGdqzyYzkjBJtNJStU/kS9S+7IfUuTlwbiHdDTbAHXxe86F7BhTMfm32fM4tRbCiAs32inJWYdqb06Nzh/ydw7fdCFmEDAxl534uprIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736664323; c=relaxed/simple;
	bh=xbzOFbhlixQ7eTb0zM5l7iGlgscFt7fafTOcvw/+6Gs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DO8hWISKi/lhBadpybUes+64+uhwi5OyKDwX9sAqip3c3TMErMrUqVNEHCe5PGcAXZE6Tmqhg1N785qWAxyPOqC+8Vf5Ywf8bfXtxY0ZILZqIf/UWpHjzLn6kzPcochDm2G5H5tlog7w+LXUKinVQPXnUMuhQholX5VPhkqdbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ce51b2fcc6so45032015ab.1
        for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 22:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736664321; x=1737269121;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLq8zTWGTcIk+AYd9zs5KeEJaaq0PNJXVC6RLIMwgWQ=;
        b=DClp9qNaXQzf7SFt+jFhiHrg7MNMyJ2Dpt2raSc7CcRLQHYXGZT5vW1LqDnujWkBmV
         JTVvTOtZ3F7fh75tmKi8AJNo+1YcsCoEjUYtzqtV0uSw5WgZiuFQyPnffHE2E73Xg/42
         5bsOrQyy3gsP1OTNI7h6khd9Ii4roD+s/jPwg6h/iwGq1ZZzfwWLNXdF6bToblAfLILG
         C8roN82FCbKWta8y2QH/jyACSmZcc4BGtix3VMRQgilY+1Aj0145MpZ+LJrTY4jUXFtq
         ZxxIiObdufm24jmvdgaK5MN4QhKEedKbsDKriv+lUJz47KQdjMD/8OhpYdP8z50IgAcu
         gh1Q==
X-Gm-Message-State: AOJu0YyChgdgjkLFMhSPY6dFUBBozvhKY/nQRr0noR+8h6nMwRxjZOcE
	mQK3OicI/QcQhR2+DedXsja/roQJALe5CSQ9/IuRO33N8DdBcp5v+mgbh40RRBPLUg2XY/l0VA4
	jmKkOVKJJa4KPd97dXR6pTz8swo4BwNecVPObNiplzN7wcRZeRJLnGCbobQ==
X-Google-Smtp-Source: AGHT+IFtSPYn4NmDpOOTknk8S1AqgLrydigC7fV6sigjoC6hn7gzKrrDuZJA6v0Ta2A+lbz3FUCHfS40UuzVxfV3bo4Y1lTxdS/n
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c548:0:b0:3a7:e8e1:cbc9 with SMTP id
 e9e14a558f8ab-3ce3a8f2809mr108673525ab.22.1736664321315; Sat, 11 Jan 2025
 22:45:21 -0800 (PST)
Date: Sat, 11 Jan 2025 22:45:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67836501.050a0220.216c54.002c.GAE@google.com>
Subject: [syzbot] [iommu?] UBSAN: shift-out-of-bounds in iova_bitmap_alloc
From: syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@nvidia.com, jgg@ziepe.ca, 
	joao.m.martins@oracle.com, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    09a0fa92e5b4 Merge tag 'selinux-pr-20250107' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16e35b0f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=85992ace37d5b7b51635
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121fbedf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159e8ef8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c59c19cd5728/disk-09a0fa92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/27a8ecc530b5/vmlinux-09a0fa92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ed4573ed205/bzImage-09a0fa92.xz

The issue was bisected to:

commit 266ce58989ba05e2a24460fdbf402d766c2e3870
Author: Joao Martins <joao.m.martins@oracle.com>
Date:   Tue Oct 24 13:51:05 2023 +0000

    iommufd/selftest: Test IOMMU_HWPT_ALLOC_DIRTY_TRACKING

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f3b218580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13f3b218580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f3b218580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com
Fixes: 266ce58989ba ("iommufd/selftest: Test IOMMU_HWPT_ALLOC_DIRTY_TRACKING")

iommufd_mock iommufd_mock0: Adding to iommu group 0
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/iommu/iommufd/iova_bitmap.c:133:27
shift exponent 63 is too large for 32-bit type 'int'
CPU: 1 UID: 0 PID: 5829 Comm: syz-executor365 Not tainted 6.13.0-rc6-syzkaller-00038-g09a0fa92e5b4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 iova_bitmap_offset_to_index drivers/iommu/iommufd/iova_bitmap.c:133 [inline]
 iova_bitmap_alloc+0x2bd/0x2d0 drivers/iommu/iommufd/iova_bitmap.c:259
 iommu_read_and_clear_dirty drivers/iommu/iommufd/io_pagetable.c:534 [inline]
 iopt_read_and_clear_dirty_data+0x35a/0x6c0 drivers/iommu/iommufd/io_pagetable.c:594
 iommufd_hwpt_get_dirty_bitmap+0x17c/0x2e0 drivers/iommu/iommufd/hw_pagetable.c:470
 iommufd_fops_ioctl+0x4d6/0x5a0 drivers/iommu/iommufd/main.c:409
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa2fda974a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc593f2558 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc593f2728 RCX: 00007fa2fda974a9
RDX: 0000000020000300 RSI: 0000000000003b8c RDI: 0000000000000003
RBP: 00007fa2fdb0a610 R08: 00007ffc593f2728 R09: 00007ffc593f2728
R10: 00007ffc593f2728 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc593f2718 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
