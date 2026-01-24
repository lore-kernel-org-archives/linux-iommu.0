Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A76A55
	for <iommu@lists.linux.dev>; Sat, 24 Jan 2026 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769237128; cv=none; b=jYKUM9PgqOtt0bAEyugGeZZyaIpuf1qLRn6VIv7dNpVTwkzj+8Cq1vqtfKjD/4nVE2goZTQbSCYYTCy+AG2aG1Xv+1idF5DJVq6mLxR+6dG3/WNGelnGs6Y0MP1D3cC3oqQoYHu9IembWIvYv2ewDXDjJ0NbFaHoGTxrPSKtfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769237128; c=relaxed/simple;
	bh=YV68kNdKM4zJaVK+ywP3hgURCx89+6pauX8u8UfgnyU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NOk3Mqe9W+KT56qWQHTcyGyxOKpq+ohfSl2HZIOZWCMrYePLCWtamCwAP3DuxXtDIY55LeT1EgpwNXuTdYaH496lXh8AhoM38oJekhpd7+19YzByRLchb+Mv/7r46UFKirPSOiqk288W31dnvski268yY/hsBSIJPVBq0HFNFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-662c684f983so6719868eaf.2
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 22:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769237126; x=1769841926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovvaLSDGwqTtnbf8Py+CqfNAbKXz7Vu52LEEzigpIn8=;
        b=LiFukSLdz+Ya24oKm8XS9zD0+FDS6fvaQcFIAR1lCQV4kGEWkVmm6WU/p7NzLJP2lc
         vFFeTLT9myyVaAuDqWhkfyKVJtTjADnGIFaak2qPRubMu8boer2WWDle3OAEK5SsVT36
         mMIZMyKoJ6k6BdYNTsIvLNDPY5iNzMxnGdEXC4YR3AWZuj/tpqRoevhl1p4xflSytzUE
         00979mi6bG1Ezmm8I6z/HODtiwOs6TNSZ1gltoHHfBpxkPTxFRHz7Y4CDP1pUZoGdF/k
         nrYV6b0hJBJX7ZbTaaAOhSe61FEn3yKvi8v1UfulIiTfMwsIDA8Gb3K/WfK6wGBvSddx
         hj3w==
X-Gm-Message-State: AOJu0YzLIA6UhXPphDoE6COtPOHqQMR/Brm8h2J+xfIJ7Bb3vZICK0wM
	nC20Cejbu7sqsK+3ETg/oRusJqFkCiQ6DLaI+ahLqgQGoouQObtfui5n9WMmDbr4FvoENWgZOm2
	s/DwYm3DXa0YtCpfBpMWzlhOLWUqDAxjDyFy0G+/hZ+2MdiFkL5hpq3yxJHtoMg==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f028:b0:661:23:e422 with SMTP id
 006d021491bc7-662caad722fmr2499213eaf.11.1769237126395; Fri, 23 Jan 2026
 22:45:26 -0800 (PST)
Date: Fri, 23 Jan 2026 22:45:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69746a86.050a0220.226181.0002.GAE@google.com>
Subject: [syzbot] [iommu?] KMSAN: uninit-value in pfn_reader_next
From: syzbot <syzbot+df28076a30d726933015@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c072629f05d7 Merge tag 'v6.19-p4' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1716005a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bf02b9e495b9fcd
dashboard link: https://syzkaller.appspot.com/bug?extid=df28076a30d726933015
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1436b79a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a63d22580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b6b938ba4a72/disk-c072629f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bb1384b011b2/vmlinux-c072629f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1dd4bb2f206e/bzImage-c072629f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df28076a30d726933015@syzkaller.appspotmail.com

iommufd_mock iommufd_mock0: Adding to iommu group 0
=====================================================
BUG: KMSAN: uninit-value in batch_add_pfn_num drivers/iommu/iommufd/pages.c:365 [inline]
BUG: KMSAN: uninit-value in batch_add_pfn drivers/iommu/iommufd/pages.c:398 [inline]
BUG: KMSAN: uninit-value in batch_from_pages drivers/iommu/iommufd/pages.c:658 [inline]
BUG: KMSAN: uninit-value in pfn_reader_fill_span drivers/iommu/iommufd/pages.c:1220 [inline]
BUG: KMSAN: uninit-value in pfn_reader_next+0x1d5a/0x3e50 drivers/iommu/iommufd/pages.c:1247
 batch_add_pfn_num drivers/iommu/iommufd/pages.c:365 [inline]
 batch_add_pfn drivers/iommu/iommufd/pages.c:398 [inline]
 batch_from_pages drivers/iommu/iommufd/pages.c:658 [inline]
 pfn_reader_fill_span drivers/iommu/iommufd/pages.c:1220 [inline]
 pfn_reader_next+0x1d5a/0x3e50 drivers/iommu/iommufd/pages.c:1247
 pfn_reader_first+0xbcf/0xee0 drivers/iommu/iommufd/pages.c:1354
 iopt_area_fill_domains+0x202/0x1590 drivers/iommu/iommufd/pages.c:1917
 iopt_fill_domains_pages drivers/iommu/iommufd/io_pagetable.c:359 [inline]
 iopt_map_pages+0x1ba5/0x2130 drivers/iommu/iommufd/io_pagetable.c:387
 iopt_map_common+0x224/0x610 drivers/iommu/iommufd/io_pagetable.c:425
 iopt_map_user_pages+0x148/0x1c0 drivers/iommu/iommufd/io_pagetable.c:466
 iommufd_ioas_map+0x6a2/0x9b0 drivers/iommu/iommufd/ioas.c:270
 iommufd_fops_ioctl+0x82a/0x9e0 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:583
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
 x64_sys_call+0x18a7/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable pfns created at:
 iopt_area_fill_domains+0x5c/0x1590 drivers/iommu/iommufd/pages.c:1900
 iopt_fill_domains_pages drivers/iommu/iommufd/io_pagetable.c:359 [inline]
 iopt_map_pages+0x1ba5/0x2130 drivers/iommu/iommufd/io_pagetable.c:387

CPU: 0 UID: 0 PID: 6065 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
=====================================================


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
