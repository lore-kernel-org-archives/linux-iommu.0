Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF06A1DD9AD
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765179692; cv=none; b=sW9IxoN4heisrIyfuJW2dRv9DEVcizJGcT9YeyifitydPyqqSd1OAMAcau+FDtIGUQmN7rjkeKA126UZKQNI985oz94Y/VpqS9BlB/D2JhTsXy+toeLRQ0Mi9QbZLT4mClC3AtKIw++VtPnWfimajkHhM5z5O3ou6YD4fYXxjsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765179692; c=relaxed/simple;
	bh=8ute7w9wLXoahEQANY+xPGVSg6gT9OLxUyr44xQp2bI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tgaYXdMUM1UckVIOXksxFwFyqxMn9oOh7iSbmpG0iuydiYS3ny1c2ckksfGSDCP1HuT4C4HGQD8JuG4OAFE/3z5IiJiz7vAFTsAmFAbb8PDKdfD9X0ayKHxe52apQPvw5pF7QY1lfCj2jHMHqFyiBODHA5BrzL5VkTkKwWUP+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6577e29de71so5429510eaf.0
        for <iommu@lists.linux.dev>; Sun, 07 Dec 2025 23:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765179690; x=1765784490;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyUcL13dbyJpJ5RpkRLXBTIvh3y1cenBQytv0s+r4Is=;
        b=PzO7qMr8/8/dNaiS4l7BKxoaP3PKzTcFR9Ig47kldgn3viy7GxS2gFFMip17WyNMfV
         ZNu7pT85YkVYNXA1lto8qQbul0uMW+4mbhEw/04F402CSv2LZ6ZJ6nSaOb4Fzu6kO85T
         mqDzmHl8v6tVfekGXiKxPDXTIBXIMrokDhw8hDZeKfLqsrHomBLCoLpNByj5GwmJvA3R
         MeEuzK5gSTLD25oqBvRPrZgQjZDa4Um6Eu3E2V8wg0weCKoBiG78BNhYr+eTxugMU4Wl
         4igoblMwrRDJVbo85SlMLpzAfBXof5kVm8FfH2uAW5IyGk/3OmFK2V/1L07Gya4b+Wab
         1XzQ==
X-Gm-Message-State: AOJu0YwPSJ6bFKUrLWmbQvd89S92vb8Pu+urt7OTzc9kkZX3nhCuM0PS
	us1rFmQyD+mbZ1tUelf1k1HVftHy4yw4b0IjIbDDlsSClRj7N/ebsilgPgoWEtEh+/3l5D7a+oJ
	6NHBI/eCGQPns+WrpmJS/g7czsX7hM5GMNsEzrvEYHrt9y/5uCvCWlBrq0m57KQ==
X-Google-Smtp-Source: AGHT+IFa9TcIQ+1Xd5nwfxBZeDjdyYe81umLMekAYZQnrlYCU8EB8bYqn+MOyzkwmlvydesNBh8zok27jKOtXadchtvzWHbfOeCs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1621:b0:659:9a49:9045 with SMTP id
 006d021491bc7-6599a8b6ef8mr3208869eaf.16.1765179689921; Sun, 07 Dec 2025
 23:41:29 -0800 (PST)
Date: Sun, 07 Dec 2025 23:41:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69368129.a70a0220.38f243.008f.GAE@google.com>
Subject: [syzbot] [iommu?] WARNING in iopt_map_pages (3)
From: syzbot <syzbot+57fdb0cf6a0c5d1f15a2@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05c93f3395ed Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14eb7c1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b5338ad1e59a06c
dashboard link: https://syzkaller.appspot.com/bug?extid=57fdb0cf6a0c5d1f15a2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dfc992580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a926c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b5c913e373c/disk-05c93f33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15e75f1266ef/vmlinux-05c93f33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd930129c578/Image-05c93f33.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57fdb0cf6a0c5d1f15a2@syzkaller.appspotmail.com

iommufd_mock iommufd_mock0: Adding to iommu group 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6739 at drivers/iommu/iommufd/io_pagetable.c:292 iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:292 [inline]
WARNING: CPU: 0 PID: 6739 at drivers/iommu/iommufd/io_pagetable.c:292 iopt_map_pages+0xd7c/0xdcc drivers/iommu/iommufd/io_pagetable.c:376
Modules linked in:
CPU: 0 UID: 0 PID: 6739 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:292 [inline]
pc : iopt_map_pages+0xd7c/0xdcc drivers/iommu/iommufd/io_pagetable.c:376
lr : iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:292 [inline]
lr : iopt_map_pages+0xd7c/0xdcc drivers/iommu/iommufd/io_pagetable.c:376
sp : ffff8000a04f76c0
x29: ffff8000a04f78a0 x28: ffff0000d66f4810 x27: 1fffe0001acde944
x26: ffff8000a04f7b00 x25: 0000000000002fff x24: 0000000000003000
x23: ffff0000d66f4a20 x22: ffff0000d66f49f8 x21: 00000000ffffffea
x20: dfff800000000000 x19: ffff8000a04f79b0 x18: 0000000000000000
x17: ffff800083ce6110 x16: ffff80008052b3c8 x15: 0000000000000007
x14: 0000000000000000 x13: 00000000ffffffff x12: 0000000000ff0100
x11: ffff0000c72f5c40 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c72f5c40 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : ffffffffffffefff x3 : ffffffffffffefff
x2 : 0000000000f03fff x1 : 00000000ffffffea x0 : 0000000000000000
Call trace:
 iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:292 [inline] (P)
 iopt_map_pages+0xd7c/0xdcc drivers/iommu/iommufd/io_pagetable.c:376 (P)
 iopt_map_common+0x204/0x420 drivers/iommu/iommufd/io_pagetable.c:420
 iopt_map_user_pages+0xb4/0xd8 drivers/iommu/iommufd/io_pagetable.c:461
 iommufd_ioas_map+0x2d4/0x3d0 drivers/iommu/iommufd/ioas.c:276
 iommufd_fops_ioctl+0x424/0x54c drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:583
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 1160
hardirqs last  enabled at (1159): [<ffff80008ae21fa0>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1159): [<ffff80008ae21fa0>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (1160): [<ffff80008adf99f4>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:412
softirqs last  enabled at (132): [<ffff8000801f96d0>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (130): [<ffff8000801f969c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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
