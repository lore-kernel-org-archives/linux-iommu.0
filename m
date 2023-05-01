Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5603C3C
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 17:05:06 +0000 (UTC)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-32f240747cdso169577605ab.1
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 10:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960705; x=1685552705;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p99cAvb9xfZFZuLGxMlazQRuLg+Nxa1vUJXjCMtx29E=;
        b=kUAIa21BctzZyQJMjZbkzEIKPzq4eTh8IemCD16ENmSVI0E5W9Al+fThU5dZPL2TSy
         2s1gRbhgoZMJk3LsmnQrhoVO3mbpXtMkcU0AQKh1PayJ0F3daxMQZ8d6aHaRxICmCSoN
         G1d0mlIH+rjNBYQA/uGiI+oTJ32SL9fRVIi2aIMm/J97eSq47tFpO/hd2h5JHJk4WYtj
         pNobDfI/0mY2oRCTr/J1x/kNCqGjSY0duAJCIBr7rCdniI/hG+EH3CmQb1tiB7q2hEod
         OFC/IXRsnVq2+Icn2ZgTgNON1TF/sFt/zztpyFjITHyVrqcvNlA2QBoPe7yfPrjDqnjB
         YHcg==
X-Gm-Message-State: AC+VfDxm8oqjgpQ5gMrJimn99BTEL0+2mD+JIGI4Su+HvMdSTTl6Onh2
	cg/uHHY76Kz203Nc94FD0+p8ByRDOA56RkOmZfKk2cy+e5dDQGFYXw==
X-Google-Smtp-Source: ACHHUZ55iYDCoAplJ9+ye7AUc2JiONaOplCp1rZrNIW5RQQUWDHOhgpjgR0KOGFgWfGGhPHP6+VhZjKbCSk2zc1ZKCdfSJXjZF1m
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dd5:b0:40f:9d2e:24ae with SMTP id
 m21-20020a0566380dd500b0040f9d2e24aemr12858571jaj.0.1682960705733; Mon, 01
 May 2023 10:05:05 -0700 (PDT)
Date: Mon, 01 May 2023 10:05:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000094fdd05faa4d3a4@google.com>
Subject: [syzbot] [iommu?] WARNING in iommufd_test_check_pages
From: syzbot <syzbot+353c7be4964c6253f24a@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    825a0714d2b3 Merge tag 'efi-next-for-v6.4' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12a7395fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ecbb03c21601216
dashboard link: https://syzkaller.appspot.com/bug?extid=353c7be4964c6253f24a
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15779a30280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10974ad8280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0ab84480405/disk-825a0714.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/38eb102366c9/vmlinux-825a0714.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6aba8fe75f7/bzImage-825a0714.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+353c7be4964c6253f24a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4989 at drivers/iommu/iommufd/selftest.c:762 iommufd_test_check_pages+0x240/0x250
Modules linked in:
CPU: 0 PID: 4989 Comm: syz-executor410 Not tainted 6.3.0-syzkaller-11733-g825a0714d2b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:iommufd_test_check_pages+0x240/0x250 drivers/iommu/iommufd/selftest.c:762
Code: 65 48 8b 04 25 28 00 00 00 48 3b 84 24 80 00 00 00 75 21 44 89 f0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 80 b9 c0 fc <0f> 0b 41 be f2 ff ff ff eb ac e8 b1 28 e4 05 90 f3 0f 1e fa 55 41
RSP: 0018:ffffc90003a3fb80 EFLAGS: 00010293
RAX: ffffffff84caf670 RBX: 1ffff92000747f78 RCX: ffff888028a01dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc90003a3fc50 R08: ffffffff84caf556 R09: fffffbfff1caba86
R10: 0000000000000000 R11: dffffc0000000001 R12: ffffffffffffff7b
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc90003a3fbe0
FS:  000055555727d300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000075e70000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommufd_test_access_pages drivers/iommu/iommufd/selftest.c:831 [inline]
 iommufd_test+0x20ae/0x28b0 drivers/iommu/iommufd/selftest.c:964
 iommufd_fops_ioctl+0x4c2/0x580 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0457ed7d79
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb7c1f6c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0457ed7d79
RDX: 0000000020000280 RSI: 0000000000003ba0 RDI: 0000000000000004
RBP: 00007f0457e9bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0457e9bfb0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
