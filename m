Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F28747F
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747743387; cv=none; b=h1IMqsnNK2k8U+LwZH4SZ2iN4wGiCiy890uLNyDiOlyQX/9uVgIB6AmnzP/UD3Lm23dPMl/AIlLuGa7z8W0K7f8LErZ/X0Jugl9xs/9Mc871WRBy+M+v/QJeTf5LAAWqLlioDQzhho8yM89gcYI3WGMm1jo6N9w3BhDzZn2Eygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747743387; c=relaxed/simple;
	bh=ldMywFu5QmpEYepIL1ipNR+VY/RLgHaXu7L23QybUXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ApMMExUcDSGQvwrVxzRITyPAy6czh9N+vuWid5OOxKKjffSURCJ70hDaI+GHHjVqpWUrww90F51vXVn698FBIjzEvPUvApuayU6gk3r/8C6GVMPTd0AHlmBK8svW503bGSrYvkWpjosNg9+JwV71GaNRC79ND7Pgyqw39uWL2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86463467dddso503556939f.3
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 05:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747743384; x=1748348184;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjNWPEZdhMSxjaR9yA6n/SpkVcsVB3yIV3t3BOT2tD4=;
        b=gKxq2vnMXtMpVdU1WEuoHaKhPPzl4cYcJX+J80xy1O73jc263/f5ik7dic/G1LYxLq
         lQylIZM8ntIjCooqg1pksXDtJW7guv7Zct9+GEX5Gs3jotCJsvbRlV6daFl3jN4R0c57
         6LiBegJ1LJagTtbdmjepX5Yvr61XprcWptBPRS6Rs6cm9zdeHNf29KGKyX4fmE+S0N/9
         6O+jimhJppthdItVRm1YyCPEKzZvsHPPHRQ3esSB6Vj62fcwQQE7r7Ro9M1Wg63Ohpx3
         zI/stbsRLjBL2OQ9WyuafoY1mjY9Ael3Fu8b1gkmhKpJSc+qeUdquNFsp4qO2787RuHE
         SC6g==
X-Gm-Message-State: AOJu0YzHKV7YOofbm50/LDMe810fdZOSDdoDbjHx8JCCzMvhCRlbHSyz
	cOX/utpDjAq+W6s0GSws05N21QS+lPbBVH40py5llIaJHKS/LXfSlppOFY3RLeuZxkxDvNs+ojj
	nmmWuReFyk5crGGZ8qbTDPhf6d4oDPRjza+KTbdEsHC3nFg2zG3I2xPaS3Oq1YQ==
X-Google-Smtp-Source: AGHT+IH67N9/9D+l78rju9YJWPAoT9puKVQDfq+7Km825wOQ5Hfpzs/DmxysdGLAQKnmbdmMd9E3aFQuEmbH/lW+Tav8NJ+lKyRV
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3799:b0:85b:4afc:11d1 with SMTP id
 ca18e2360f4ac-86a2319bccdmr2240372039f.5.1747743384469; Tue, 20 May 2025
 05:16:24 -0700 (PDT)
Date: Tue, 20 May 2025 05:16:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682c7298.050a0220.ade60.09bb.GAE@google.com>
Subject: [syzbot] [iommu?] WARNING in dma_direct_map_sg
From: syzbot <syzbot+17804d5cb52bc23a2fd6@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fee3e843b309 Merge tag 'bcachefs-2025-05-15' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1121c2d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f080d149583fe67
dashboard link: https://syzkaller.appspot.com/bug?extid=17804d5cb52bc23a2fd6
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1321c2d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cd76f4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-fee3e843.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6eb790f7fe0f/vmlinux-fee3e843.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aac1df830737/zImage-fee3e843.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17804d5cb52bc23a2fd6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3103 at kernel/dma/direct.h:87 dma_direct_map_page kernel/dma/direct.h:87 [inline]
WARNING: CPU: 1 PID: 3103 at kernel/dma/direct.h:87 dma_direct_map_sg+0x360/0x3f0 kernel/dma/direct.c:489
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 UID: 0 PID: 3103 Comm: syz-executor240 Not tainted 6.15.0-rc6-syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Call trace: 
[<802019e4>] (dump_backtrace) from [<80201ae0>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:828227fc r5:00000000 r4:82257ddc
[<80201ac8>] (show_stack) from [<80220020>] (__dump_stack lib/dump_stack.c:94 [inline])
[<80201ac8>] (show_stack) from [<80220020>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:120)
[<8021ffcc>] (dump_stack_lvl) from [<80220060>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r5:00000000 r4:82a70d4c
[<80220048>] (dump_stack) from [<802025f8>] (panic+0x120/0x374 kernel/panic.c:354)
[<802024d8>] (panic) from [<802619e8>] (check_panic_on_warn kernel/panic.c:243 [inline])
[<802024d8>] (panic) from [<802619e8>] (get_taint+0x0/0x1c kernel/panic.c:238)
 r3:8280c604 r2:00000001 r1:8223e9a4 r0:822464a4
 r7:8031f1d4
[<80261974>] (check_panic_on_warn) from [<80261b4c>] (__warn+0x80/0x188 kernel/panic.c:749)
[<80261acc>] (__warn) from [<80261dcc>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:776)
 r8:00000009 r7:82252200 r6:df9a1bf4 r5:845ed400 r4:00000000
[<80261c58>] (warn_slowpath_fmt) from [<8031f1d4>] (dma_direct_map_page kernel/dma/direct.h:87 [inline])
[<80261c58>] (warn_slowpath_fmt) from [<8031f1d4>] (dma_direct_map_sg+0x360/0x3f0 kernel/dma/direct.c:489)
 r10:82abccb0 r9:00000000 r8:00000000 r7:83813810 r6:849b8000 r5:00018100
 r4:846cc200
[<8031ee74>] (dma_direct_map_sg) from [<8031d998>] (__dma_map_sg_attrs+0x4c/0x2fc kernel/dma/mapping.c:214)
 r10:84483e00 r9:83813f40 r8:00000001 r7:849b8000 r6:00000000 r5:83813810
 r4:846cc200
[<8031d94c>] (__dma_map_sg_attrs) from [<8031dc9c>] (dma_map_sgtable+0x2c/0x40 kernel/dma/mapping.c:294)
 r10:84483e00 r9:83813f40 r8:84483ec0 r7:849d82c0 r6:849d82c0 r5:00000000
 r4:846cc200
[<8031dc70>] (dma_map_sgtable) from [<80ac4fb4>] (drm_gem_map_dma_buf+0x58/0xc4 drivers/gpu/drm/drm_prime.c:662)
 r4:846cc200
[<80ac4f5c>] (drm_gem_map_dma_buf) from [<80b83be4>] (__map_dma_buf+0x24/0x88 drivers/dma-buf/dma-buf.c:799)
 r7:849d82c0 r6:00000000 r5:849d82c0 r4:849d82c0
[<80b83bc0>] (__map_dma_buf) from [<80b83cb8>] (dma_buf_map_attachment+0x70/0xa4 drivers/dma-buf/dma-buf.c:1147)
 r7:849d82c0 r6:83813c00 r5:00000000 r4:849d82c0
[<80b83c48>] (dma_buf_map_attachment) from [<80b83d28>] (dma_buf_map_attachment_unlocked+0x3c/0x78 drivers/dma-buf/dma-buf.c:1202)
 r5:00000000 r4:849d82c0
[<80b83cec>] (dma_buf_map_attachment_unlocked) from [<80ac5914>] (drm_gem_prime_import_dev drivers/gpu/drm/drm_prime.c:958 [inline])
[<80b83cec>] (dma_buf_map_attachment_unlocked) from [<80ac5914>] (drm_gem_prime_import_dev+0x88/0x1a0 drivers/gpu/drm/drm_prime.c:928)
 r5:84483d00 r4:83a9c300
[<80ac588c>] (drm_gem_prime_import_dev) from [<80ac5f58>] (drm_gem_prime_import drivers/gpu/drm/drm_prime.c:1001 [inline])
[<80ac588c>] (drm_gem_prime_import_dev) from [<80ac5f58>] (drm_gem_prime_fd_to_handle+0x17c/0x228 drivers/gpu/drm/drm_prime.c:319)
 r9:83813f40 r8:84483ec0 r7:df9a1e64 r6:83813c00 r5:84483e00 r4:83a9c300
[<80ac5ddc>] (drm_gem_prime_fd_to_handle) from [<80ac6118>] (drm_prime_fd_to_handle_ioctl+0x34/0x38 drivers/gpu/drm/drm_prime.c:375)
 r9:845ed400 r8:83813c00 r7:df9a1e64 r6:80ac60e4 r5:84483e00 r4:00000000
[<80ac60e4>] (drm_prime_fd_to_handle_ioctl) from [<80ab7710>] (drm_ioctl_kernel+0xb8/0x120 drivers/gpu/drm/drm_ioctl.c:796)
 r5:84483e00 r4:00000020
[<80ab7658>] (drm_ioctl_kernel) from [<80ab79dc>] (drm_ioctl+0x264/0x5b0 drivers/gpu/drm/drm_ioctl.c:893)
 r8:81d354f0 r7:83813c00 r6:c00c642e r5:0000000c r4:0000000c
[<80ab7778>] (drm_ioctl) from [<8056b450>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<80ab7778>] (drm_ioctl) from [<8056b450>] (do_vfs_ioctl fs/ioctl.c:860 [inline])
[<80ab7778>] (drm_ioctl) from [<8056b450>] (__do_sys_ioctl fs/ioctl.c:904 [inline])
[<80ab7778>] (drm_ioctl) from [<8056b450>] (sys_ioctl+0x138/0xd84 fs/ioctl.c:892)
 r10:845ed400 r9:00000004 r8:84861c00 r7:20000300 r6:84861c00 r5:00000000
 r4:c00c642e
[<8056b318>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdf9a1fa8 to 0xdf9a1ff0)
1fa0:                   ffffffff 00000000 00000004 c00c642e 20000300 00000000
1fc0: ffffffff 00000000 0008e0c8 00000036 7e845e0c 00000000 00000001 00000000
1fe0: 7e845c70 7e845c60 00010854 0002eec0
 r10:00000036 r9:845ed400 r8:8020029c r7:00000036 r6:0008e0c8 r5:00000000
 r4:ffffffff
Rebooting in 86400 seconds..


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
