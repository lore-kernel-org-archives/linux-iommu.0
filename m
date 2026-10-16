Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC538A729
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122086; cv=none; b=YAShqIyhwMEvXWzTRpcW2+vceWQBURRN5xizXcyMSmufRY+0l8zpQ4ZwWwg9hwZ7FS4waT7isybKadgJh0Td27KZdFo+rucm9E098xnyIz0ZNCS2Yw75DdD/0OvX5ArNt4IUWN+0kgJtz8CeI/nc1H8CgbpFjR7Cy832pFEyyBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122086; c=relaxed/simple;
	bh=/gKhrnSB2Ga0boparH1a8Djf6iN4HKSr9MVFBg/1NOE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RLq7Kcxf4o5rIglyjBwDr19Uz9IvAxHzP2G4zT6SvYOR9agG8Qq9cSmkpLkW6sYUEQqNTbgzUWl9lAXZ8l1mdJHFnTt4fHeZN01C/BLOtgXQ3upeeOXI/Fyy0t5dA5b4uEcq1IqI3SmoPwAZGjgVVGxEVLb3LVAEnO4JSR3z20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-5384e381fbbso341080b6e.2
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 20:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122084; x=1792726884;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dom8hMmQmzUIGCj8Zk/utIF9ipnYSkCSo6FcsDXzWKE=;
        b=vNv5ndNgQSEwQhHyhKOq58ErAgnCCoPoY26t+8rmf8eulK5XtrTv1AkX7rM8MrIxQh
         OcLA8/7pLZg+Wb7p0YXt0opJuzx8EBXreNHyy0NVzYOC74DBXO41czcR5uxRTnOrQFZm
         CQCoqFCYrwAdIYw2a1nkIzsQPHlNOk3H45hLX5HD3YkNhV0GRis/R/tq6Cd/TRCjyYm5
         +adbXHW60dCIjeB9U0AY4E5IWgA7oMg8BMkESFAlsKtMURkMV5VNllsgo0FspSptPaJW
         3DPYdJYqF3gWV/ZIBi4uCsQY4qJp+J3bdZCvg9gcm0c3RuDBwUbtwLir76itPYybISx+
         K2sw==
X-Gm-Message-State: AFq9FYLNCG1R9YdkKWMlSA7aKLCP7w+jwlDEsLeXtylIgLaZSOmYGZTy
	kFqTHyijDiwW08DfhAK3pUaPDldsGUaAzEIuQx6TfOzQYmy4EzSidpZzpmctSjKFKPgtPhlzKqF
	fSWzAvLOOIsbzYOlOQLlU6xbglpFERStu5/rJ4rNVgMGlrih4MczytGshdf8=
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4495:b0:4d6:9293:9bc3 with SMTP id
 5614622812f47-50c592a3a14mr16787609b6e.61.1792122084109; Thu, 15 Oct 2026
 20:41:24 -0700 (PDT)
Date: Thu, 15 Oct 2026 20:41:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad19ce4.7952420f.283480.01c3.GAE@google.com>
Subject: [syzbot] [iommu?] WARNING in iommu_setup_default_domain
From: syzbot <syzbot+2a4570d89a1e13003dbf@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, joro@8bytes.org, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b88c841d1164 Merge tag 'input-for-v7.3-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117d540d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44ac479246d4559b
dashboard link: https://syzkaller.appspot.com/bug?extid=2a4570d89a1e13003dbf
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b88c841d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e27770b53aa6/vmlinux-b88c841d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a314a5eb19d/bzImage-b88c841d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a4570d89a1e13003dbf@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
ret
WARNING: drivers/iommu/iommu.c:3205 at iommu_setup_default_domain+0xbb6/0xf30 drivers/iommu/iommu.c:3205, CPU#2: syz.2.802/11603
Modules linked in:
CPU: 2 UID: 0 PID: 11603 Comm: syz.2.802 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:iommu_setup_default_domain+0xbb6/0xf30 drivers/iommu/iommu.c:3205
Code: 24 10 48 89 de ba 01 00 00 00 e8 25 5e ff ff 31 ff 41 89 c4 89 c6 e8 79 97 42 fc 45 85 e4 0f 84 37 fc ff ff e8 fb 9c 42 fc 90 <0f> 0b 90 e9 4b fd ff ff e8 ed 9c 42 fc 8b 35 c7 c9 7c 0c 48 8b 7c
RSP: 0018:ffffc90002d87610 EFLAGS: 00010287

RAX: 000000000003c9f5 RBX: ffff88801d082c00 RCX: ffffc9000c001000
RDX: 0000000000080000 RSI: ffffffff85c90575 RDI: ffff888024200000
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000001 R12: 00000000fffffff4
R13: 0000000000000000 R14: ffff888026609150 R15: ffff888026609048
FS:  0000000000000000(0000) GS:ffff88809594a000(0063) knlGS:00000000f5456b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7fa8000 CR3: 000000004dc43000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __iommu_probe_device+0x1174/0x1550 drivers/iommu/iommu.c:678
 iommu_probe_device+0x28/0x130 drivers/iommu/iommu.c:715
 iommu_bus_notifier drivers/iommu/iommu.c:1823 [inline]
 iommu_bus_notifier+0x5b/0x110 drivers/iommu/iommu.c:1815
 notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
 blocking_notifier_call_chain kernel/notifier.c:380 [inline]
 blocking_notifier_call_chain+0x69/0xa0 kernel/notifier.c:368
 bus_notify+0x56/0x80 drivers/base/bus.c:1086
 device_add+0x1169/0x1970 drivers/base/core.c:3741
 pci_device_add+0xdb6/0x1820 drivers/pci/probe.c:2769
 pci_scan_single_device drivers/pci/probe.c:2794 [inline]
 pci_scan_single_device+0x1d0/0x240 drivers/pci/probe.c:2780
 pci_scan_slot+0x1c9/0x7c0 drivers/pci/probe.c:2877
 pci_scan_child_bus_extend+0x6b/0x7b0 drivers/pci/probe.c:3096
 pci_scan_child_bus drivers/pci/probe.c:3209 [inline]
 pci_rescan_bus+0x18/0x40 drivers/pci/probe.c:3500
 rescan_store+0xfb/0x130 drivers/pci/pci-sysfs.c:474
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7fa7fec
Code: Unable to access opcode bytes at 0xf7fa7fc2.
RSP: 002b:00000000f545650c EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000080000140
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
