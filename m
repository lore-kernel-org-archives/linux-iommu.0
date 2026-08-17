Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494A44E64A
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984476; cv=none; b=KcsrBJ1pOFRokvodWi1I1kpWITj1uc0DMDsBYa39gvpgMslnLNNnSS4HMmOVpBFr7/RV2FIzCh/qbqE1rDinaFg2r2xP6A2QYuMpM45Nk3ZU1jluyYCQIz9An2ad89vL2GXiWEdvozVW0Jjf7qNUqsDu6QHmYFTxAJkAk2REI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984476; c=relaxed/simple;
	bh=j+6dLP4KOZXfLiW35D3amX88j9BD+eDPnLlo3S4BffA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V5Sn/E8WpftHIXyXtqO163qjuX9CYcaMbtEHJvWA8hnYkDwzQKWhcZH4NpiruzPD6WI9tNrmO+KMiUNNNzyj9kFMETI38BST274cv7F9v6euSfuv7ia8EozMnexAbGvPQyChyWy+JWhD4RONDWIQW54SbRBy6GkuVtOWAFm6c84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4af7193adb7so1150147b6e.0
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 09:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984473; x=1787589273;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZCmRIn0qSWyL5jBP9JKHJFrfolODivBzvEU9FKadEE=;
        b=ZEFr3GmrSofJ6LozCpMZqZC1j+sCIHFQXsent8uNSvTLah0lhv4a8YyZKArrkX0X/3
         1iDO1RkXV1oZVZuJYvxf1XdkHm2Pa/LYyq6ERwO7/lvjDf+vYEibm9htPoq7772yn5Fv
         D8nZhZ8GmmN79qf4AUyEYZIRVFCMyEGkXhKRb2GrGOvRtVSd0LJAD/JLVo9uALTD2nDf
         +LBr3NLykcno0FzH3L4w+1N1jL3cU1zYLe2VgmghvWYPFgnBhHEicHVDESkYA5Prz5ur
         AaWNQW47tBho2UGzBgMsv7mfpghjujru1qa6k8zen+AiT4lBF/emWngrExKTa8LmRaOq
         zOaw==
X-Gm-Message-State: AOJu0Yz4m/7peIc/nfzVLxFtSS8MjLE/iFNlLFsoveBaZOaZEXBUcoHF
	WIpOEmN+GsvEHFYLkDiwNCtES4riENSQxa6FWkO+1FtdW8weqzqrVE/5DVuFb3gjHwZ6gL4IiDk
	iJRPFSD+qqIh7eRcXN41394sI4vd80D1cLli0rndUBURH8bqS0X8L/4TupqlLJg==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14cc:b0:486:8a11:6e8b with SMTP id
 5614622812f47-4b2974c9ae2mr1812016b6e.2.1786984473022; Mon, 17 Aug 2026
 09:34:33 -0700 (PDT)
Date: Mon, 17 Aug 2026 09:34:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a833819.4d75e56a.c9a88.0001.GAE@google.com>
Subject: [syzbot] [iommu?] general protection fault in iommufd_ioas_change_process
From: syzbot <syzbot+48637757323884de77a2@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b01a9e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=48637757323884de77a2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dbb225580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b01a9e580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3d6d8176.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f486efba4dfc/vmlinux-3d6d8176.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b9dcf9ee9f3/bzImage-3d6d8176.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48637757323884de77a2@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000018: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
CPU: 2 UID: 0 PID: 6443 Comm: syz.0.201 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:iommufd_ioas_change_process+0x513/0x11c0 drivers/iommu/iommufd/ioas.c:538
Code: 5b fc 48 8d 7b 68 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85 e1 0a 00 00 48 8b 6b 68 48 8d bd c0 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 74 08 3c 03 0f 8e d5 0a 00 00 8b ad c0 00 00
RSP: 0018:ffffc9000503fba0 EFLAGS: 00010206
RAX: 0000000000000018 RBX: ffff8880550e9400 RCX: ffffffff8526f53b
RDX: ffff88802c6b8000 RSI: ffffffff85af13fb RDI: 00000000000000c0
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000001fff R11: 0000000000000000 R12: 0000000000000007
R13: fffffbfff22438f4 R14: dffffc0000000000 R15: ffffc9000503fc38
FS:  00007f1248ff36c0(0000) GS:ffff8880d5fec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1248ff2ff8 CR3: 000000005355a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 iommufd_fops_ioctl+0x358/0x520 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f124819e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1248ff3028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1248426090 RCX: 00007f124819e0d9
RDX: 0000200000000000 RSI: 0000000000003b92 RDI: 0000000000000003
RBP: 00007f1248235024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1248426128 R14: 00007f1248426090 R15: 00007ffea12de908
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iommufd_ioas_change_process+0x513/0x11c0 drivers/iommu/iommufd/ioas.c:538
Code: 5b fc 48 8d 7b 68 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85 e1 0a 00 00 48 8b 6b 68 48 8d bd c0 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 74 08 3c 03 0f 8e d5 0a 00 00 8b ad c0 00 00
RSP: 0018:ffffc9000503fba0 EFLAGS: 00010206
RAX: 0000000000000018 RBX: ffff8880550e9400 RCX: ffffffff8526f53b
RDX: ffff88802c6b8000 RSI: ffffffff85af13fb RDI: 00000000000000c0
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000001fff R11: 0000000000000000 R12: 0000000000000007
R13: fffffbfff22438f4 R14: dffffc0000000000 R15: ffffc9000503fc38
FS:  00007f1248ff36c0(0000) GS:ffff8880d5fec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1248ff2ff8 CR3: 000000005355a000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	5b                   	pop    %rbx
   1:	fc                   	cld
   2:	48 8d 7b 68          	lea    0x68(%rbx),%rdi
   6:	48 89 f8             	mov    %rdi,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  12:	0f 85 e1 0a 00 00    	jne    0xaf9
  18:	48 8b 6b 68          	mov    0x68(%rbx),%rbp
  1c:	48 8d bd c0 00 00 00 	lea    0xc0(%rbp),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	74 08                	je     0x3b
  33:	3c 03                	cmp    $0x3,%al
  35:	0f 8e d5 0a 00 00    	jle    0xb10
  3b:	8b                   	.byte 0x8b
  3c:	ad                   	lods   %ds:(%rsi),%eax
  3d:	c0 00 00             	rolb   $0x0,(%rax)


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
