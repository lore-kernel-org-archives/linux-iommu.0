Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793171F80A1
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019369; cv=none; b=dACV2g4XSTW0T8hSSckhUpZqBy9Dy51CzRYCBNkzyUCJ74P/U9NY+eI3BrItrJbzihR7gELVEoD17eJTfYbu/zgFHEvBxGR8XpCqobOKgoyB1V0t6kEL5uOX6jNY+Ffi/AAuN/DQY5vxq8YlwWL1JA6QfMFLo7fjWEh72W2jNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019369; c=relaxed/simple;
	bh=u1uAwktf6kk8nVT1WwQn5qWjduf1jXs8aWE0d1BVCG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FwEJ7GgEM9WyxhDBUQlybmcTk6hffaONVEFOlNb5Wpo/WPcAtARGFuNzNetRx+Z1fIz7j2mBgds+oZcMjh0piaXyul2c6raw2ayRqdkKJyIWYyjkQq4A7l9kbgtM0egC1V6y4q0DQCTV4QLvapbz83ptX1GUaepZS30LrXGHlM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so42775675ab.0
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 12:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019365; x=1729624165;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITeBmiKPxke1DH9sYqgNIlVHlUNkQ0WHvvDjCpx3+Bc=;
        b=XDldSkKeuzstv+51SUcex+MaHUuTN5xX6K4ff+XjgpmoQNCl2Ha/W5nbAUagjbOtWL
         TvAaoHXWIdeP1EziZHmTT9kRay4R2kbpIh7ni0skdyJHGvLmbnENxFwrpzEYxnUdcf9E
         FmmQpQatQP37E8XgswcQ/2dtEHkrjAU6tObzXpxfmQ0LK5kt9dCRvUZmIca/EjrifA33
         ohg59ExVCMMRy2I2a+AzHW4MIVU5e2eqZMHkFHCTydSg4TZJuDCh32APyuTLnA2B6F7T
         1p/jV45hc5V7Y7sNDtWE0Jq7DLqO5HaMZUtD82DdsaE/zocQt0F0/T/+6LeaEO6TXbBO
         ne9A==
X-Forwarded-Encrypted: i=1; AJvYcCVjJ/gFGT+SGtI7GGweGZGpc9im2H7YqrhoV2fdVrWTH4ihJUDoLwffgS2oqSV+gVlD+e4lPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKJVMUumkQVDgGGFdYq0Sl5vGUqF3wRuI3ofxZ/HSWP+Rlmn9v
	qE0H5+/7/O2l8MBENKQhXcD50hYiU9StSa0gZXLRPqF+N7Kx49gqx8IXmVb+CX1siszx7AGik+Y
	YDj4lnUvRtck70KWS1F7FXWM9SW1sJcOEoRSQH7YjhlL2/OwOMvr69Bs=
X-Google-Smtp-Source: AGHT+IGpa/p4mxM4VBJEqmkiVGZ8cJWslOWsSMrxRUbbSmaJdDs5orv+v+JB1Enu97wMr+0RJBPRjJkwpL520np+r35DT4O/0bZ6
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:3a3:afa3:5155 with SMTP id
 e9e14a558f8ab-3a3b6050e70mr145590025ab.25.1729019365547; Tue, 15 Oct 2024
 12:09:25 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:09:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670ebde5.050a0220.d9b66.0154.GAE@google.com>
Subject: [syzbot] [iommu?] kernel BUG in dma_alloc_attrs
From: syzbot <syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com>
To: hch@lst.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1d227fcc7222 Merge tag 'net-6.12-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c56f07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=b4bfacdec173efaa8567
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14572840580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12572840580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-1d227fcc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea82465646ea/vmlinux-1d227fcc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f764dd6d008a/bzImage-1d227fcc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5114 Comm: syz-executor411 Not tainted 6.12.0-rc2-syzkaller-00205-g1d227fcc7222 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__phys_addr+0x162/0x170 arch/x86/mm/physaddr.c:28
Code: e8 23 e8 51 00 48 c7 c7 c0 86 7a 8e 4c 89 f6 4c 89 fa e8 f1 98 b1 03 e9 45 ff ff ff e8 07 e8 51 00 90 0f 0b e8 ff e7 51 00 90 <0f> 0b e8 f7 e7 51 00 90 0f 0b 0f 1f 40 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002d4f4c0 EFLAGS: 00010293
RAX: ffffffff8142ff51 RBX: 0000000000000001 RCX: ffff88800023a440
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002d4f5e8 R08: ffffffff8142fe9c R09: 312e64313a30303a
R10: dffffc0000000000 R11: fffff91ffff86755 R12: ffffe8ffffc33a60
R13: dffffc0000000000 R14: 000040800b111000 R15: 000000000000002e
FS:  0000555576947380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffabc3020f0 CR3: 000000004020a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virt_to_phys arch/x86/include/asm/io.h:131 [inline]
 perf_trace_dma_alloc+0x3dd/0x620 include/trace/events/dma.h:117
 trace_dma_alloc include/trace/events/dma.h:117 [inline]
 dma_alloc_attrs+0x46c/0x4e0 kernel/dma/mapping.c:622
 usbdev_mmap+0x247/0x900 drivers/usb/core/devio.c:251
 call_mmap include/linux/fs.h:2172 [inline]
 mmap_region+0x1add/0x2990 mm/mmap.c:1440
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffabc28b979
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4658b118 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffabc28b979
RDX: 0000000001000002 RSI: 0000000000400000 RDI: 0000000020000000
RBP: 00007ffabc2fe5f0 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000011012 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x162/0x170 arch/x86/mm/physaddr.c:28
Code: e8 23 e8 51 00 48 c7 c7 c0 86 7a 8e 4c 89 f6 4c 89 fa e8 f1 98 b1 03 e9 45 ff ff ff e8 07 e8 51 00 90 0f 0b e8 ff e7 51 00 90 <0f> 0b e8 f7 e7 51 00 90 0f 0b 0f 1f 40 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002d4f4c0 EFLAGS: 00010293
RAX: ffffffff8142ff51 RBX: 0000000000000001 RCX: ffff88800023a440
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002d4f5e8 R08: ffffffff8142fe9c R09: 312e64313a30303a
R10: dffffc0000000000 R11: fffff91ffff86755 R12: ffffe8ffffc33a60
R13: dffffc0000000000 R14: 000040800b111000 R15: 000000000000002e
FS:  0000555576947380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffabc3020f0 CR3: 000000004020a000 CR4: 0000000000352ef0
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
