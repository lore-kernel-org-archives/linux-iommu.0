Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870A6FC3
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310669; cv=none; b=SGFVPatQncQKx+7sgRczFddoRBxk8zHggHepK5pPjcS4dSKY8TOhJUONMLK/GUsEs3o2Y7Zec96PSRb/GLF/MoKVgEYoRZoP3IubauPoy8I0Jn0hpESrwzBV46hP66glkW804P3OMaNX6/2Q6Yt95OqjaGwrpmiIAbfJKKkfXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310669; c=relaxed/simple;
	bh=gPs75YsO7ff3VozFD0e5ZnalDU67IHv6X3S1J9OSSIU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O3R4YDu5nWR81AiZ/0Ik9144sp7+taInw/7mEPGK+sdvBENelWYoP2ErDjRUDHq0tKlpAgeXg8XpGeJE9e5Fu0U7n76hSMrhh091+inOaJL2K2hglAUs/5eg4/1hqEdTANLEAsoovveXO7VYScy4JDzNN/EfgRc84gUQi5sJlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7d740d7e5a3so31421697a34.2
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 17:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310667; x=1774915467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1irIxosQIlOvxzpxXn3zovOdnKS4Tm+73/3nZQ+Nj4Q=;
        b=Jer1JCPiuFKUYWZ6euwYS190+3mauvYbFxjna5i9PVAYavEGrQBSzWwT0N0qtZyZxV
         Q1Dr7CLrbC6dh4YVp/6fJet7a8yv8iHZj0DpMjZ/FziNuFkxvOfV4oX27/ceaZjgLtlW
         nudeSvW1NswN5YB1stF8d30mQB4C0BIxW0UmK0cK2rZi4+ZOdTguHKTwMTZSOA0Lin0n
         uwbWoIjggBKySVcXUXin8r7e6QXReNENP7OVVJEHk3zSN5MZLpT93ZxTpFk5qhW5KgWs
         VeQTkz0ETpcqp1b5SxGxrCovHrkk520yRxxI+OZiJmuDjygYLhuzCroSEBPdpWbgE4lH
         PaJw==
X-Gm-Message-State: AOJu0Yy7MU2F/9ivvVAGI/QWJUjgXzycM4eLQqaewGn556dSqRax1gHW
	gqMwzeSjfcPiohRDQRRCQ/OJ3WrD9HNMqCZOZf2kYE4jB4WYa2TMcxJwEb422h1ThrtpQJQYXlL
	Em3eOgzv5/X03L7jCaH00Kxiwnwlnuakb5i+k1J9HMYhh6UUGr/GWCnIhIIF+4w==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2103:b0:67d:eeb3:a2e1 with SMTP id
 006d021491bc7-67deeb3a7aamr3635958eaf.28.1774310667097; Mon, 23 Mar 2026
 17:04:27 -0700 (PDT)
Date: Mon, 23 Mar 2026 17:04:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c1d50b.a70a0220.3cae05.0001.GAE@google.com>
Subject: [syzbot] [iommu?] WARNING in pt_iommu_amdv1_init
From: syzbot <syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0e4f8f1a3d08 Merge tag 'parisc-for-7.0-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176df352580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
dashboard link: https://syzkaller.appspot.com/bug?extid=453eb7add07c3767adab
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0e4f8f1a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/838ecdb7b55f/vmlinux-0e4f8f1a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3742378914db/bzImage-0e4f8f1a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com

iommufd_mock iommufd_mock1: Adding to iommu group 10
------------[ cut here ]------------
!iommu_table->driver_ops || !iommu_table->driver_ops->change_top || !iommu_table->driver_ops->get_top_lock
WARNING: drivers/iommu/generic_pt/fmt/../iommu_pt.h:1249 at pt_iommu_amdv1_init+0xa10/0xb20 drivers/iommu/generic_pt/iommu_pt.h:1249, CPU#1: syz.0.1303/9714
Modules linked in:
CPU: 1 UID: 0 PID: 9714 Comm: syz.0.1303 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:pt_iommu_amdv1_init+0xa10/0xb20 drivers/iommu/generic_pt/iommu_pt.h:1249
Code: e8 95 a4 e7 fc e9 aa f6 ff ff e8 db 18 7b fc 89 ab 94 00 00 00 e9 15 ff ff ff e8 cb 18 7b fc e9 e4 fd ff ff e8 c1 18 7b fc 90 <0f> 0b 90 e9 19 ff ff ff bd a1 ff ff ff e9 cc fd ff ff 4c 89 cf 4c
RSP: 0018:ffffc90003747a68 EFLAGS: 00010287
RAX: 00000000000007ee RBX: ffff88802bb03500 RCX: ffffc9000407a000
RDX: 0000000000080000 RSI: ffffffff858db73f RDI: ffff888026f94980
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000034 R11: 0000000000000000 R12: 0000000000000034
R13: 0000000000000040 R14: 0000000000000000 R15: 0000000000000034
FS:  00007f29a60136c0(0000) GS:ffff8880d6442000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3f39c7 CR3: 000000003d1d7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mock_domain_alloc_pgtable drivers/iommu/iommufd/selftest.c:491 [inline]
 mock_domain_alloc_paging_flags+0x29b/0x680 drivers/iommu/iommufd/selftest.c:548
 iommufd_hwpt_paging_alloc+0x393/0xb20 drivers/iommu/iommufd/hw_pagetable.c:149
 iommufd_hwpt_alloc+0xb46/0x1af0 drivers/iommu/iommufd/hw_pagetable.c:369
 iommufd_fops_ioctl+0x358/0x520 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f29a519c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f29a6013028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f29a5415fa0 RCX: 00007f29a519c799
RDX: 0000200000000200 RSI: 0000000000003b89 RDI: 0000000000000009
RBP: 00007f29a5232c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f29a5416038 R14: 00007f29a5415fa0 R15: 00007ffedd2b95c8
 </TASK>


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
