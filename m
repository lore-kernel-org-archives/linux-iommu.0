Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAD170826
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791750; cv=none; b=blLx9EkiCRxDduCnwo94tE+EWhuAcv4TVseQwtlHry1cpPhNG3+QO92GfbvAAGAyn2YVmfcBy9m7SPVICizZD+mQ6QvUutAwVfUoBmKoR30f2aSJK5TGL34Z1FU1EABIzMmQlUN0w7Y/9gJTljzSIJnONntX0alIUWGtnXLAw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791750; c=relaxed/simple;
	bh=O0gFzXOU6bBYNceD9Mk1SINCLL1DWYmVSUSwT8C0/Ys=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SL9VsBEPG+1aEKOEzPVFT5jv2bks5qsC29tf74I15VaKxCogxtuXDzrL3JYO/VucqoOwgkqmWLmagXStfwVckTloQaOES0sPcscrhf+Ya+Li0PY1uskwe2hLEPp1K2aMHucQtqNyPFOf3W6yyjCgrkbDvPpo9GI+q5O05hlJdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddd01c6f9bso1837305ab.1
        for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 12:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750791748; x=1751396548;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xv0opqnUy3DoijGykm0kwmTQcZr6xsjlBLIf8bKI7h0=;
        b=aA3JBOywhUbQ3Sum1OMQ5W7DbnYHj7FIn1nQgH7VAsTRm56Juw2+4azzwzpLCSSYI9
         VvOD4nIGFDbRB7yTbpQ8C24D4k7Qh6Hx/qCSPp9ifnY0SHjtfwz3xOx95qK5oRVkUXZx
         n9k7Ly/rSthNEDX/zEv13Ryr+t3TxRjFMgfrct/biEAXvpeugpdv0A+b0jSvzgZtRkhn
         LiHUgpzUJ7GPR76vgsyTT+ITa8D7HXJkEo/I89jXLBE9uOUWU2VswChmqVf/KBT/K6T+
         5+E35yeXJyn6M0rUepKO+D0EOA7Z+Qw6Aa4oiCu19rU6qAeJ7gfudBf8cULQF4AVrsWm
         enmg==
X-Gm-Message-State: AOJu0YwVMo2X5YvKv5dibIEpNhE4MQdw3zXoI6JPPC0M956IqW7Ntg4P
	T2f1/3ibquBwOWU7X6S6uysAY05NG0PunxtQ4GdWOx9Kc3DSZcjUmkoYJJqmXkDGWRsRbAg3Q7C
	QBvU81nsueeE/+cW465bmkVK865xi5R3UX9zbsxUSmhjkvxk+bKw8z+qRWKNjkw==
X-Google-Smtp-Source: AGHT+IFyw4/s4f0Wf6MFmbd7vcvsPCfQxEAct1BguQB1AnsNkBIdribQp31ZKGKnnn0l7deJEhYqriaRST84VEQLcTy9bk7TrvTs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184c:b0:3d4:2ea4:6b87 with SMTP id
 e9e14a558f8ab-3df32d9de81mr510555ab.11.1750791748245; Tue, 24 Jun 2025
 12:02:28 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:02:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685af644.a00a0220.2e5631.0094.GAE@google.com>
Subject: [syzbot] [iommu?] WARNING in iopt_map_pages (2)
From: syzbot <syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86731a2a651e Linux 6.16-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1488eb0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34e751e88b020813
dashboard link: https://syzkaller.appspot.com/bug?extid=c2f65e2801743ca64e08
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145cbb0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125cbb0c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42f791fcfdf5/disk-86731a2a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13fce21e7fbc/vmlinux-86731a2a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55232ab2d633/bzImage-86731a2a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5834 at drivers/iommu/iommufd/io_pagetable.c:283 iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:283 [inline]
WARNING: CPU: 0 PID: 5834 at drivers/iommu/iommufd/io_pagetable.c:283 iopt_map_pages+0xce7/0xda0 drivers/iommu/iommufd/io_pagetable.c:367
Modules linked in:
CPU: 0 UID: 0 PID: 5834 Comm: syz-executor127 Not tainted 6.16.0-rc3-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:283 [inline]
RIP: 0010:iopt_map_pages+0xce7/0xda0 drivers/iommu/iommufd/io_pagetable.c:367
Code: 89 d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 4e f6 17 06 cc e8 c8 94 68 fc 90 0f 0b 90 e9 ca f7 ff ff e8 ba 94 68 fc 90 <0f> 0b 90 e9 88 f5 ff ff e8 2c 1b 15 06 44 89 f1 80 e1 07 80 c1 03
RSP: 0018:ffffc90003fb7880 EFLAGS: 00010293
RAX: ffffffff8557f866 RBX: 00000000ffffffea RCX: ffff88802f885a00
RDX: 0000000000000000 RSI: 00000000ffffffea RDI: 0000000000000000
RBP: ffffc90003fb7ab0 R08: ffff88802f885a00 R09: 0000000000000002
R10: 00000000ffffffff R11: 0000000000000000 R12: ffffc90003fb7b70
R13: dffffc0000000000 R14: ffff88803340d810 R15: ffffc90003fb7ce0
FS:  0000555556f1e380(0000) GS:ffff888125a1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 0000000077afa000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iopt_map_common+0x2bb/0x4f0 drivers/iommu/iommufd/io_pagetable.c:411
 iopt_map_user_pages+0xbc/0xd0 drivers/iommu/iommufd/io_pagetable.c:452
 iommufd_ioas_map+0x392/0x4c0 drivers/iommu/iommufd/ioas.c:276
 iommufd_fops_ioctl+0x446/0x520 drivers/iommu/iommufd/main.c:419
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5a2c8b13e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5a46ce18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007f5a2c8b13e9
RDX: 0000200000000080 RSI: 0000000000003b85 RDI: 0000000000000003
RBP: 00007f5a2c924610 R08: 00007fff5a46cfe8 R09: 00007fff5a46cfe8
R10: 00007fff5a46cfe8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff5a46cfd8 R14: 0000000000000001 R15: 0000000000000001
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
