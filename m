Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4183C9454
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521084; cv=none; b=XZng1HGOWL4hB1lVmPrSfHZVrvUQdu7hXLZ7pRlS5CF91WMzf3y6/tL80SpjMEM/+Yglrrr7jJKwKfP+cOpapbUHSf2wo6FpyBhxyPVa2BcxfWkd1FJLIZO3Qf6Nqq3T8KMZnkKKJ966lVzkzEZILrA/7EmzGsJofRQOnWoGhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521084; c=relaxed/simple;
	bh=yxqi3/yFH4IAIjS+smm9Fz81z7itO7TOtYYrTbrwaNo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ydu4VqH1tBos+5uNIYoa7ibKHQ2l/UvFUsR7egj+6Lbz/N01jZTpw84JhnkY+r8y+ajr2J8oQDH5Sx4XNklfsqNFSuVu6oQSwzrhHVmGjDCWMm2p1cYKthCShdn5FcRmeKK+14P7NX7tKI2KF/sW11cBcXE/0CJcRHN4BODKw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7d7f7164b12so1158756a34.1
        for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 03:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774521081; x=1775125881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdCyu3ENC/ipHyqUzoadB5I9NoGEDt4/nKN2d+wJFf0=;
        b=q1WcG20tD444jbXqZaGCTrECzyJn+gHqzs2lrdG3fju2nDfMJH0GatZzoxE1jd4V3u
         RIuUrbap5UpLWIZZaMjEaPWz1g9kMgaxGMR1YkH4Qt4AL73qF7HEUhgv/bYTB5tlvzLy
         rPMJQdI1VKA9CgfcZwG2JDHRCZ2IvUo/sCo7v/PjObs7HoKv/qOnulLuyXnHjhg653G7
         AzgmjrmcfNoUwRb6S112gZz6PXh91uMMf97pqH/9LgqF/Jt12usC6XlGmecALcyUy9NJ
         xeFIJbDjAOssPY1CjzBMHLM7LCbplQNCyeAVu9TptqatqSrFeA1Sq634wOTrvUZuA38I
         Ao5A==
X-Forwarded-Encrypted: i=1; AJvYcCVWtFniYDsdgrr1vL9O3hC6fUnHv82oLNPS/axgWBosxngPfn+Ofxnl2Y0qGkKY1iuTcSii8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgkPv0f1czrVimhainDmAXpfKLfrtY6VPs83OU1tox3Bc9nF1C
	Fx1CgvuPRUvrvQRAGQbOymtOaL+ddkvCmHtNv7bqdpDfvg6eq1fD8R6Q1sd3utLM/lRsCYSIEFy
	TmGzMYalcMIu5Uu7A2VhsOpIGuLaFYUOdCWv3u4CNEGn5TsjN3JpXvvVs4uU=
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:62a:b0:67e:10bb:cd34 with SMTP id
 006d021491bc7-67e10cb21e0mr401752eaf.23.1774521081465; Thu, 26 Mar 2026
 03:31:21 -0700 (PDT)
Date: Thu, 26 Mar 2026 03:31:21 -0700
In-Reply-To: <69c1d50b.a70a0220.3cae05.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c50af9.a70a0220.234938.0086.GAE@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in pt_iommu_amdv1_init
From: syzbot <syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com>
To: ankit.soni@amd.com, iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, 
	kevin.tian@intel.com, linux-kernel@vger.kernel.org, praan@google.com, 
	robin.murphy@arm.com, skhawaja@google.com, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d2a43e7f89da Merge tag 'hardening-v7.0-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f4d06a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d46eab0cfd31c214
dashboard link: https://syzkaller.appspot.com/bug?extid=453eb7add07c3767adab
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cfa1d6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13beecca580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d2a43e7f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/971507ed4baf/vmlinux-d2a43e7f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c5926dab5b8b/bzImage-d2a43e7f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com

iommufd_mock iommufd_mock0: Adding to iommu group 11
------------[ cut here ]------------
!iommu_table->driver_ops || !iommu_table->driver_ops->change_top || !iommu_table->driver_ops->get_top_lock
WARNING: drivers/iommu/generic_pt/fmt/../iommu_pt.h:1251 at pt_iommu_amdv1_init+0x631/0x9f0 drivers/iommu/generic_pt/iommu_pt.h:1249, CPU#0: syz.0.17/5472
Modules linked in:
CPU: 0 UID: 0 PID: 5472 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:pt_iommu_amdv1_init+0x631/0x9f0 drivers/iommu/generic_pt/iommu_pt.h:1249
Code: 48 89 df 44 89 fa e8 de 05 00 00 48 89 c3 48 3d 01 f0 ff ff 72 1e e8 de 77 6f fc eb 5e e8 d7 77 6f fc eb 05 e8 d0 77 6f fc 90 <0f> 0b 90 bb ea ff ff ff eb 47 e8 c0 77 6f fc 43 80 7c 35 00 00 74
RSP: 0018:ffffc9000e277a20 EFLAGS: 00010293
RAX: ffffffff855639f9 RBX: 0000000000000000 RCX: ffff8880369c24c0
RDX: 0000000000000000 RSI: 0000000000000034 RDI: 0000000000000000
RBP: ffff8880540f4f70 R08: ffff8880540f4f97 R09: 0000000000000000
R10: ffff8880540f4f68 R11: ffffed100a81e9f3 R12: ffff8880540f4f88
R13: 1ffff1100a81e9f1 R14: dffffc0000000000 R15: 0000000000000cc0
FS:  000055558cba0500(0000) GS:ffff88808ca51000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000037dbd000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mock_domain_alloc_pgtable drivers/iommu/iommufd/selftest.c:491 [inline]
 mock_domain_alloc_paging_flags+0x3ba/0x780 drivers/iommu/iommufd/selftest.c:548
 iommufd_hwpt_paging_alloc+0x3ab/0x830 drivers/iommu/iommufd/hw_pagetable.c:149
 iommufd_hwpt_alloc+0x496/0xc10 drivers/iommu/iommufd/hw_pagetable.c:369
 iommufd_fops_ioctl+0x4b5/0x5d0 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b6999c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd240fb7c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7b69c15fa0 RCX: 00007f7b6999c799
RDX: 0000200000000200 RSI: 0000000000003b89 RDI: 0000000000000008
RBP: 00007f7b69a32c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7b69c15fac R14: 00007f7b69c15fa0 R15: 00007f7b69c15fa0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
