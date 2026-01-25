Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403E1EE7D5
	for <iommu@lists.linux.dev>; Sun, 25 Jan 2026 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769320951; cv=none; b=AlF0Kus5h0v+Gq3FMwTQDRdtuUnTRijYTNLrrIbRHRjPoSX2w7Msu7dtsYGZ2cFD842SvY4+NE0x/fZdhxAYKsO0eKdhFc5HapQPe36lDmyf+lwMtJqIZOmc5YNDoLrfvM78Gq3mlKD2j88EmfLX+JYvl3E+LHg3gm6O7IcZMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769320951; c=relaxed/simple;
	bh=zE+LHEVzDerPodawcsD5m1dYFUj/lMmrsDptshOXCUk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uEuGXYeF9J5OKbFdgWrwJvoCj4YITpKlZqvtcyiqShpjtK3EzMAqs8wNHAdsZLzgAyha+sAKUwHfqCWQ3OS3hACt1p89HuibKy4HrCc+kkHGSNZZYG+ybPgjfyg2y8wvjmNQCpna5/b7TIuQeg/Ic1dnJBbesXJHf8zuEDpC8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-662c6ddda94so9582209eaf.0
        for <iommu@lists.linux.dev>; Sat, 24 Jan 2026 22:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769320948; x=1769925748;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+q1jqIaaxEeT0dCDcERCUMQ+PfeBJqze3pTvLgu0Hc=;
        b=Y3Vi/o90SCqE29fzqhJzzSRakODW57TJqDk99RVzZf5LRmGLMCJB2uOeIOLx/vmtpF
         XNf7RSNLIrxlTy0T92Na40Cwuz6MtqPlPfGTv94a1eVpzWq3hdrIGRyqBHIlHMNYG0gD
         EqhOkHsngyQXCwamYCxGhB3av8SDeinBpPVOlULty6vB7vRd/NkzKQrFTWIv+Jg0w3PK
         a5hFaaHy8IAYW+lXcoW7J4IpK8p6H8y1UUu8P+o0ropRMjTcxADiDckEIRMHJ7D+vjj8
         SOvF9GyZVKk5lijft9I1iCLM3sADZHwnmmvLNuzKU+wv1BtAY6VOIWCKiVlfE9YmYU0p
         /XAg==
X-Gm-Message-State: AOJu0YxzwSIWtsZl8KmKJSrsrzZw9hDTCd5UrZpOZrByV5VoMnieNDrQ
	tZhHDQaGCw/i1kb+jefLdbYHk5PoiATdOf65zUJsv792vb9rVq44361V+xubdD08xY5Ht0eU53a
	xfpmb1l0yePQ/CNjVTHMfitKe4TyKCpdatU7mGXDsWv0eK+bFM1tvFlxwUGV3AQ==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1622:b0:662:c029:682d with SMTP id
 006d021491bc7-662e046d5d3mr497728eaf.51.1769320948542; Sat, 24 Jan 2026
 22:02:28 -0800 (PST)
Date: Sat, 24 Jan 2026 22:02:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6975b1f4.a00a0220.33ccc7.001f.GAE@google.com>
Subject: [syzbot] [iommu?] KMSAN: uninit-value in iopt_pages_unfill_xarray
From: syzbot <syzbot+a0c841e02f328005bbcc@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6c790212c588 Merge tag 'devicetree-fixes-for-6.19-3' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113ef852580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bf02b9e495b9fcd
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c841e02f328005bbcc
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1796579a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13919d22580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/913c7571d705/disk-6c790212.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62003bdb5d84/vmlinux-6c790212.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fd53ea608c6/bzImage-6c790212.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0c841e02f328005bbcc@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in batch_add_pfn_num drivers/iommu/iommufd/pages.c:365 [inline]
BUG: KMSAN: uninit-value in batch_add_pfn drivers/iommu/iommufd/pages.c:398 [inline]
BUG: KMSAN: uninit-value in batch_from_xarray_clear drivers/iommu/iommufd/pages.c:590 [inline]
BUG: KMSAN: uninit-value in iopt_pages_unpin_xarray drivers/iommu/iommufd/pages.c:2030 [inline]
BUG: KMSAN: uninit-value in iopt_pages_unfill_xarray+0xfe3/0x1660 drivers/iommu/iommufd/pages.c:2068
 batch_add_pfn_num drivers/iommu/iommufd/pages.c:365 [inline]
 batch_add_pfn drivers/iommu/iommufd/pages.c:398 [inline]
 batch_from_xarray_clear drivers/iommu/iommufd/pages.c:590 [inline]
 iopt_pages_unpin_xarray drivers/iommu/iommufd/pages.c:2030 [inline]
 iopt_pages_unfill_xarray+0xfe3/0x1660 drivers/iommu/iommufd/pages.c:2068
 iopt_area_remove_access+0x508/0x650 drivers/iommu/iommufd/pages.c:2516
 iommufd_access_unpin_pages+0x637/0xa50 drivers/iommu/iommufd/device.c:1358
 iommufd_test_access_unmap+0x423/0x6b0 drivers/iommu/iommufd/selftest.c:1384
 iommufd_test_staccess_release+0x7f/0x140 drivers/iommu/iommufd/selftest.c:1425
 __fput+0x60e/0x1050 fs/file_table.c:468
 ____fput+0x25/0x30 fs/file_table.c:496
 task_work_run+0x208/0x2b0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0x2ff/0x1b20 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x1d7/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable batch created at:
 iopt_pages_unfill_xarray+0x86/0x1660 drivers/iommu/iommufd/pages.c:2053
 iopt_area_remove_access+0x508/0x650 drivers/iommu/iommufd/pages.c:2516

CPU: 0 UID: 0 PID: 6001 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(voluntary) 
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
