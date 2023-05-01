Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF423D78
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 17:05:06 +0000 (UTC)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-763761822f0so395093039f.0
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 10:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960706; x=1685552706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsTGMr+b06aWySt7vwx94agD1ZqSsCQJjB1y6g1Qy0A=;
        b=TR4nyHHBDAKTnZPUEKwkn/vZ7djcG1XjgpuAQ0oVpjnnV1ryFEIrJgtyGJsBFMucm9
         7MBjxDvZItORbPRZFOUJU+Fh9wLPoaR6jRYvvt2qvIQIgDFi7ANACCm7VQt6owHrDVXv
         wHL8PPHUfU66NoEHzVT6KQXTG8sThiIYcwGzuFU/HhEJUidAPu0uRlY9pVeV7TXn7gUj
         vTClAwoA9iCT9FqixgtvS86mFwYgeQsHCeT69Sxa3qJzovcuvMWJRS7n1LJqTQOPNO8a
         EJF5tIvjlACH4ElFw/xjwg6f4RgGqTu9O26KzEcZebP0m3S4l2WEddq+K5tDCZVoPtAf
         ylnA==
X-Gm-Message-State: AC+VfDxAia/VgVZpLYqggRH1FyKI6rm3wz0YYZSPGX4nZxfIntT6uXce
	GFj+RAU2mRzCWN2JNrkUIbguQ6QGNpL3KbIcM418hZjGBGnnwc0rPg==
X-Google-Smtp-Source: ACHHUZ6lUoW8rG6obvY3JKL7jjOM6btcBE0aKUnbRWv/8Sn+UAORNua1QCYam+dnD4Y39suylbDImkTJ5tJXd8rDJ7PmxAmtyFT3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a6b:c41a:0:b0:745:70d7:4962 with SMTP id
 y26-20020a6bc41a000000b0074570d74962mr6593724ioa.0.1682960705960; Mon, 01 May
 2023 10:05:05 -0700 (PDT)
Date: Mon, 01 May 2023 10:05:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cd0fb05faa4d351@google.com>
Subject: [syzbot] [iommu?] WARNING in iommufd_test
From: syzbot <syzbot+94646b0ed2dcbb1f9c2f@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=171c01f8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d56ffc213bf6bf4a
dashboard link: https://syzkaller.appspot.com/bug?extid=94646b0ed2dcbb1f9c2f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16310d5fc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168c5330280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51c43e265c8a/disk-58390c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c64f4eeaf4d/vmlinux-58390c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5d8f49c4804/bzImage-58390c8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94646b0ed2dcbb1f9c2f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5005 at drivers/iommu/iommufd/selftest.c:762 iommufd_test_check_pages drivers/iommu/iommufd/selftest.c:762 [inline]
WARNING: CPU: 1 PID: 5005 at drivers/iommu/iommufd/selftest.c:762 iommufd_test_access_pages drivers/iommu/iommufd/selftest.c:831 [inline]
WARNING: CPU: 1 PID: 5005 at drivers/iommu/iommufd/selftest.c:762 iommufd_test+0x1bed/0x2c20 drivers/iommu/iommufd/selftest.c:964
Modules linked in:
CPU: 1 PID: 5005 Comm: syz-executor411 Not tainted 6.3.0-syzkaller-12049-g58390c8ce1bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:iommufd_test_check_pages drivers/iommu/iommufd/selftest.c:762 [inline]
RIP: 0010:iommufd_test_access_pages drivers/iommu/iommufd/selftest.c:831 [inline]
RIP: 0010:iommufd_test+0x1bed/0x2c20 drivers/iommu/iommufd/selftest.c:964
Code: 48 85 db 0f 88 36 0a 00 00 e8 0f fb ed fc 48 89 de bf 01 00 00 00 e8 42 f7 ed fc 48 83 fb 01 0f 84 51 ff ff ff e8 f3 fa ed fc <0f> 0b 41 bf f2 ff ff ff e8 e6 fa ed fc e8 e1 fa ed fc 48 8b 54 24
RSP: 0018:ffffc9000398fcd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880196f0000 RSI: ffffffff849662ad RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000001
R10: 0000000000000000 R11: 1ffffffff21a07c8 R12: ffffffffffffff7b
R13: ffff888017a4b410 R14: 0000000000000001 R15: ffffc9000398fd68
FS:  00005555556bf300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000061cca0 CR3: 0000000017fbd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fadd8712d79
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff30e101f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fadd8712d79
RDX: 0000000020000280 RSI: 0000000000003ba0 RDI: 0000000000000004
RBP: 00007fadd86d6f20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fadd86d6fb0
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
