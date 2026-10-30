Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327804;
	b=C/EIrqadvHH6dJrTTRCkSCBZLUM4NoBdzZvVAHekGWBIutw8RzQE3WBDG/l+SzfXyviV
	 4cTU7LMMchlThj2ZnLGJAV86MT7F2x37keHffKN+qCeLD1IcXtA2OR8cZHViR8n7l/fm3
	 yBExZL9larLRYKo0W/92x+Nqnt6OeUjcYCB4QPNient1lgedfgzWVT1z+7hcWW6Vb6k7c
	 VaUD9zhk7gXR6PYpQqbZJzpDh4Hi7gzBiZgFZtM+clSOjUlyaWYhkE3sIiH5s57bXs5ni
	 JLCzUx7FUvUT7TjnbAzkU+lfznUFnz0qAIEINXIj/aJ1z0+wVxDQCO+qsj9X2iUEOKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327804;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=nzg7svtxDTS64P/SYLljyKCWug0ZFvOK1tCQQbwdXGo=;
	b=OFZJpr0jITJHQiidCNjbqiEGOgS6BWsIWjE0maw5q3bRZXTudRppCF6jDqzLcrYaYZu7
	 npJeT9oEB3nNb7qrkkho8Hdte+v8MEmSNw7BSz5Rcc/i1sMBe7zZI0nOxvtBNZl7le6PJ
	 GRij2Elr6Ic7dvQAbtNRKU+Domgy+UTPu8uB2px9F6+J07uyy+CyQWRxiSB6rIBGuRyWM
	 gxZoirBtGJ7bE4ORGVGbPKz6/2BMc0chkMXmNSHt+9fn7/FAgydCJId3ZqvcBE/b2Dbpj
	 fFjf0BLCyJTGv62qcEymPO7Dd7G7T3X49pn9U9kEJphbk26k+ojpg6ZfQ3sr8dB/RYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BA606A325
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 02:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 854BA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-5384e381fbbso216893b6e.2
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 19:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327803; x=1793932603;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nzg7svtxDTS64P/SYLljyKCWug0ZFvOK1tCQQbwdXGo=;
        b=Qtnz3Kh7Fm9Mno07C/PYNmyp8FXcYeUnVlNQsnXYf9zlyA21GgytucV7DlWRLgQF3H
         E746uhPEjR+CJXR15TsClxlYFlCxVHU5/9znOr5NoPekkSN4ld4YRDqJ4JYgiosYixRL
         6nZzC/aSv9HcHAOgGzBzjXUBMBtAhwjxB5/VH3q/B5MYH6qy09K9zRI0FpGwE8SRqEom
         vITUvvSqWMa1SZ5PtdsAtdcWUUHPj+P8TnhrVx0cQbrQF6NdSXfDMCLdlt4kAnPEfn7r
         NN7cRF9+C4t5dJ0M1I3g9x7mzD0rU7exN0naxOC/imebkRo7CFmznNudUqQ+cJNrVPRf
         dYuA==
X-Gm-Message-State: AFq9FYJgTdMZG4FAU1c1EEY7BTbGw7ICHTao9JK9SeeoWzMU3AR4V97b
	XP5KBeGlfxqzaGFxv7AgoZXcJyucQk/2vtCagouStnYFWXYYrjHCDhJorrOAiIDQFMVq+zcqMv6
	l9q5WiQSInrvum+LFFiGsEuT4EBcQSMDqPJvjZUxhyOA6MPI+vUUJeTYBL0o=
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f6a:b0:4b9:a88b:8884 with SMTP id
 5614622812f47-5640dc8f99amr783868b6e.26.1793327803631; Thu, 29 Oct 2026
 19:36:43 -0700 (PDT)
Date: Thu, 29 Oct 2026 19:36:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae402bb.0c1d3ab6.e3d48.006d.GAE@google.com>
Subject: [syzbot] [iommu?] memory leak in iommu_fwspec_init
From: syzbot <syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    65ba8f34ec88 Merge tag 'xtensa-20261027' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15067d31580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbf447a1375a1948
dashboard link: https://syzkaller.appspot.com/bug?extid=fe84fc6a684e0beb86e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b22a3c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4e738ce5f2b/disk-65ba8f34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1de9d1ecbbb6/vmlinux-65ba8f34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a3d79b65181/bzImage-65ba8f34.xz

AI-generated root cause summary:
A memory leak of `struct dev_iommu` occurs when `iommu_fwspec_init()` allocates
`dev->iommu` via `dev_iommu_get()`, but subsequently fails on allocating the
`iommu_fwspec` structure (e.g. via fault injection) and returns -ENOMEM without
releasing `dev->iommu`. Furthermore, callers such as `iommu_mock_device_add()`
do not invoke `dev_iommu_free()` on error from `iommu_fwspec_init()`. When
device initialization fails and the device is released, `dev->iommu` remains
allocated, causing an unreferenced object memory leak.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=fe84fc6a684e0beb86e2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812bad6bc0 (size 64):
  comm "syz.0.26", pid 5965, jiffies 4294941985
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4733 [inline]
    slab_alloc_node mm/slub.c:5033 [inline]
    __kmalloc_cache_noprof+0x35f/0x3f0 mm/slub.c:5676
    _kmalloc_noprof include/linux/slab.h:991 [inline]
    _kzalloc_noprof include/linux/slab.h:1312 [inline]
    dev_iommu_get drivers/iommu/iommu.c:408 [inline]
    dev_iommu_get drivers/iommu/iommu.c:399 [inline]
    iommu_fwspec_init+0x20d/0x240 drivers/iommu/iommu.c:3086
    iommu_mock_device_add+0x29/0x90 drivers/iommu/iommu.c:385
    mock_dev_create drivers/iommu/iommufd/selftest.c:1026 [inline]
    iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:1068 [inline]
    iommufd_test+0x1a97/0x2ec0 drivers/iommu/iommufd/selftest.c:2104
    iommufd_fops_ioctl+0x1ed/0x370 drivers/iommu/iommufd/main.c:556
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
