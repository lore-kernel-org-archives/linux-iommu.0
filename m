Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793592097;
	b=v9jWjuKm7pWKH5OKB0MzEp4VeZAC22lipdlGaJIuACsbHDCMCyeQTCscplAZpaRku+h1
	 Db+XhEWbZNBRJcqaFWlhG65+DkdlLwICmMpsGxHY/Bhru8tETBTN4eQpp3pJoZh1BOvfU
	 RH8+JEJz3NWXXxqyHHEqAM0gt0mGumT24gE6f2whAze8mSBWvhtPwlJ1F1d5Jsp6AwRJq
	 jtiYPSeIK52c+pAnq1rDjTaJWigILFdB274GuK3JCabFuO9PoP2Z78ubyM2lUHnmvQhVD
	 SSApJENKWNwYRbTyoqjjbPRm+MfVU5JGAm9GQJpSxOgbEuLU8Cg8ubRfPNJR4F1R+lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793592097;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:In-Reply-To:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=9GuEW49aZUzLgO1IBi6JN1m+bJNtvvMVZK06g6wbN2g=;
	b=gns55ksqAz+Da4CvOaOyg1/hDutIP6F4pmhC6hAfxaMFlGl6RxTy99oGbv6h9Q8zXEj8
	 SKE9/Wi1zzt3L4u4lxb3Xo3dFWgpHFIRRMoxJy3FCneetNXYkY2Mn7a+ooAMMBc8b/1Ob
	 fN+5iO8cO8nLShYSY3B9CLCg2w3U7nzV5roXhPZ7BnERTaOTdA5+txTlYx5k4hZv/o/6C
	 pn0DWxk5J6GZAco08aAIH4u5UWnUxkU1N5r0wJX4ANnJt0+TuI+k4cl1hIode1GPaLQf3
	 9wi4mPW2VO7q1lig21Ax/XRJaoFN5E5cSXr/AKmk0OvxIbdMRUhOw1UfzSNvR2MHEqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C1606A324
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 04:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 034C1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-85a6d046af0so3576557a34.2
        for <iommu@lists.linux.dev>; Sun, 01 Nov 2026 20:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793592096; x=1794196896;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9GuEW49aZUzLgO1IBi6JN1m+bJNtvvMVZK06g6wbN2g=;
        b=L0gmSAIWUKaUyDo6oBjtB43qA54DWrSQJPmoBNeQnTEaJNYGJo495xhJ8CQlzsVs1J
         Qv8Jvk69SG3mnNF6DA9pd+sM3ZKdgWBEzxlhURMSLwqLCgEhmKyqxbngHQBIS7ijqOTZ
         DNQ0hB1CzI23n/lFrh0ppxA7XX1A3yHPAVOFwL8eAKnltGr5m6eVfy/MKz+soSwnu0C8
         RoF2BZpVwecj5YyZIQfXFDP20LcVjTeAag4TwpIjp9bDcw6WJz89Z/sEqABAjmkN8Z/T
         301pTl6L4Bt/je/p8M1aT0gIxDavgLqWGGWkEdMqEGd37bbtoTBrRIQRaRUHVYxUZnzk
         adqw==
X-Gm-Message-State: AFq9FYLWyP5F3/qo6/QgKLS5M3eyGWhP2cm+GPj/Qa/g6YbM9LL3Iah0
	W1UgihKOBb+lXSg7aMKhDUKzraypYl1y2QN/Ms7iFnHLb9kCqOXJTcR6mLy6G7ykbPJ0aaIlSa8
	bxenUWFHRgKULgKK5Zx5zx4tONFdGeEqOH4UXIV9LKXjFN4KZLyfVWp9i65E=
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a507:20b0:6de:1071:8b18 with SMTP id
 006d021491bc7-714f29fa7c1mr3121380eaf.75.1793592096008; Sun, 01 Nov 2026
 20:01:36 -0800 (PST)
Date: Sun, 01 Nov 2026 20:01:35 -0800
In-Reply-To: <6ae402bb.0c1d3ab6.e3d48.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae80b1f.c8ffc79a.e3697.002e.GAE@google.com>
Subject: Re: [syzbot] [iommu?] memory leak in iommu_fwspec_init
From: syzbot <syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    46fec1c3029b Merge tag 'sched-urgent-2026-11-01' of git://..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1263dc8d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=441b6cc593d83cc4
dashboard link: https://syzkaller.appspot.com/bug?extid=fe84fc6a684e0beb86e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107b1795580000

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
unreferenced object 0xffff888129294b00 (size 64):
  comm "syz.3.20", pid 6865, jiffies 4294946901
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
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
