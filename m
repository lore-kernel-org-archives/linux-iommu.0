Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E53FE35C
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363071; cv=none; b=dZzYF9AmYI3GmQLPnDfxfVXeV5yZfg2hlEceG2uwg+3WeL4RnBnwYiMR7dahTpCjLLxkddfI3U3QjhyMT2iSobQPQrYOIXwpvWl+/YVg6CPPdUiK+aZY3nSamJOWL3bJIy1RbS7bzS5T614wBe5XfH6/OK+82dIZG7Jz83sJNvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363071; c=relaxed/simple;
	bh=1sk38y6BFPbnln9nbap5Q/ErjzXRwclt7LVSQepLIm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKwfcjTbELWfLjgJmemfbmK5UPFm3uMrnkGPV8J6xoi4BEfGb2RQJRgeFkqG8gTt3oYpAamfDJLQLh6/A6A4LF320KozorpWeCieNxBR9yKjGY8ZV/RXxccOkjj1zH6fMicRfLs67J8q+OWEvQ9rLCFrtPs20mdOb1oUbDZG/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8QwX2au; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8QwX2au"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so90385ad.0
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774363069; x=1774967869; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw8J3CuQJxBjnJT6zeArfsADtu1fMvrF3SD6r5XL12o=;
        b=B8QwX2auQiG7v8Pqjfca1dLGdQMgpJq2FLQPh67MhHJW57ukqcZgYg0PcTy3DIh0d3
         JXTymSsGMlagnXldLN+IWFEGqH8A2wx71BZILhhFUlW5VRajFS1IUK85w4z+MMI9Q2a4
         9Ag1dzuSfjh1g2lftQXWarzRlsUAmZ9gLP8Y8rqCIgGiDkLb0rb10PbgyF8wfH8xu9wA
         Qv1Uijxw+KzDnaT5BHLU+LgvSv4mu8VS3DJov/IE+kMtdPGRkWukJPC6caqT3ky52Pl9
         o1TYECtUL0N+Z0aBwZ5ogBOVVNBA5tqKihlYkW0i6yGceAQk9Xq8kH7rlpcQze73+lTH
         mTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363069; x=1774967869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aw8J3CuQJxBjnJT6zeArfsADtu1fMvrF3SD6r5XL12o=;
        b=aVfzgBf5Icn+5c0dwnM0KabHUsohI2DmBWx1Mc1m5lJmgK32PGMQPXh9YLHFFFs5T2
         7AIF9eJZ30LcUR4kblyEIbAUe/eQnCMD3w5M1VwaBgHRifnItfjmeoulHEJchG25cjAX
         kMJMI/dSaZgJjdNcZcrp6b0CTg3VFIrQB7YM80z/kkDo8HSuzWmXzwIqhlDkQLUtKpnr
         uFeGV1tw1MGUUEKlwrgimqs6k5R9aLbrPq9CQUO3E9tdilA1sWDziO5FZ6x0vwnZYS2h
         gd/klYrVbm8CIht/jpCaUPndFzJ+5Im42qu7DV32bakjhAoxpA5dOB/xZR/cbMxeFvTL
         IGqg==
X-Gm-Message-State: AOJu0YyFkrdKgcVaNQBhkEnu1sOjILcVqmjYHjwDzjNJTDUtdEMIHR17
	jAQ8JKxjnPNHAR9mVTdWM2bp6pVJ5guom7G0CVFYyGLziLc5Y37BOjWJTTvduoKSxg==
X-Gm-Gg: ATEYQzwm5eEMneDc0UW/apUrlcooYP13QfjIF7KsuUNJsGCScEcJzGtVLWL6GpO1Nq9
	TWjKi8PneyDUqxlQmghOlb3fnhsF0ulclmZtAcJNikEeLMVztJ1qbY0ot3QmLhm88XecTie1ROV
	8kZ8f3yBtO6NMAumMBADaGBxVFwFBw/B/EPC92L2GON6QGYf/zaofkSbP7mRNw1R+saUX7JuLYI
	PmHoLQOA1G9hYZ7dWHpjZ9p6GOv1h0UoiHVIFEjIK7wb+jvZTqNX35EScE7TL8oy11OTvucd7b9
	I5ojBRX3ZwGIwYEMf3Km8a/FdqrHPmGyu1mWLVM1MuSZPq0UFV1nx2ubpA6rn/WvXBB0ly72QI5
	rhoMjKRFkvP2a8FoJFdQ4WgEUDwG6uAYQFgQvnaqiNmW3L5zeaUi4Oatk6I+jOH3VVaym5E97LT
	eehJTIunv5huY3YfcIKTxQkzAEQYVMUpsDz1MqVtY3lYLhsadWvgzHl4kdLQ==
X-Received: by 2002:a17:902:cec2:b0:2ae:c358:bb9f with SMTP id d9443c01a7336-2b0a53e7c67mr2990335ad.10.1774363068327;
        Tue, 24 Mar 2026 07:37:48 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa7d8esm12362659b3a.4.2026.03.24.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:37:47 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:37:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: syzbot <syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com>
Cc: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org,
	kevin.tian@intel.com, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: Re: [syzbot] [iommu?] WARNING in pt_iommu_amdv1_init
Message-ID: <acKhtdpfSctT5r5I@google.com>
References: <69c1d50b.a70a0220.3cae05.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c1d50b.a70a0220.3cae05.0001.GAE@google.com>

On Mon, Mar 23, 2026 at 05:04:27PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0e4f8f1a3d08 Merge tag 'parisc-for-7.0-rc5' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=176df352580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
> dashboard link: https://syzkaller.appspot.com/bug?extid=453eb7add07c3767adab
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0e4f8f1a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/838ecdb7b55f/vmlinux-0e4f8f1a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3742378914db/bzImage-0e4f8f1a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
> 
> iommufd_mock iommufd_mock1: Adding to iommu group 10
> ------------[ cut here ]------------
> !iommu_table->driver_ops || !iommu_table->driver_ops->change_top || !iommu_table->driver_ops->get_top_lock
> WARNING: drivers/iommu/generic_pt/fmt/../iommu_pt.h:1249 at pt_iommu_amdv1_init+0xa10/0xb20 drivers/iommu/generic_pt/iommu_pt.h:1249, CPU#1: syz.0.1303/9714
> Modules linked in:
> CPU: 1 UID: 0 PID: 9714 Comm: syz.0.1303 Tainted: G             L      syzkaller #0 PREEMPT(full) 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:pt_iommu_amdv1_init+0xa10/0xb20 drivers/iommu/generic_pt/iommu_pt.h:1249
> Code: e8 95 a4 e7 fc e9 aa f6 ff ff e8 db 18 7b fc 89 ab 94 00 00 00 e9 15 ff ff ff e8 cb 18 7b fc e9 e4 fd ff ff e8 c1 18 7b fc 90 <0f> 0b 90 e9 19 ff ff ff bd a1 ff ff ff e9 cc fd ff ff 4c 89 cf 4c
> RSP: 0018:ffffc90003747a68 EFLAGS: 00010287
> RAX: 00000000000007ee RBX: ffff88802bb03500 RCX: ffffc9000407a000
> RDX: 0000000000080000 RSI: ffffffff858db73f RDI: ffff888026f94980
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000034 R11: 0000000000000000 R12: 0000000000000034
> R13: 0000000000000040 R14: 0000000000000000 R15: 0000000000000034
> FS:  00007f29a60136c0(0000) GS:ffff8880d6442000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c3f39c7 CR3: 000000003d1d7000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  mock_domain_alloc_pgtable drivers/iommu/iommufd/selftest.c:491 [inline]
>  mock_domain_alloc_paging_flags+0x29b/0x680 drivers/iommu/iommufd/selftest.c:548
>  iommufd_hwpt_paging_alloc+0x393/0xb20 drivers/iommu/iommufd/hw_pagetable.c:149
>  iommufd_hwpt_alloc+0xb46/0x1af0 drivers/iommu/iommufd/hw_pagetable.c:369
>  iommufd_fops_ioctl+0x358/0x520 drivers/iommu/iommufd/main.c:533
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f29a519c799
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f29a6013028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f29a5415fa0 RCX: 00007f29a519c799
> RDX: 0000200000000200 RSI: 0000000000003b89 RDI: 0000000000000009
> RBP: 00007f29a5232c99 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f29a5416038 R14: 00007f29a5415fa0 R15: 00007ffedd2b95c8
>  </TASK>
> 
> 

I believe this is because we don't populate struct pt_iommu_driver_ops
for the "mock" iommu / selftest? Would defining mock ops help fix this?

I have a patch that seems to fix the WARN_ON:

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 9607416f8069..1599eb737d2a 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -119,6 +119,7 @@ struct mock_iommu_domain {
 		struct pt_iommu_amdv1 amdv1;
 	};
 	unsigned long flags;
+	spinlock_t lock;
 };
 PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, amdv1.iommu, domain);
@@ -129,6 +130,29 @@ to_mock_domain(struct iommu_domain *domain)
 	return container_of(domain, struct mock_iommu_domain, domain);
 }
 
+static void mock_domain_change_top(struct pt_iommu *iommu_table,
+				   phys_addr_t top_paddr,
+				   unsigned int top_level)
+{
+	/*
+	 * The selftest doesn't have real hardware, so there is no need to
+	 * perform any root table moves.
+	 */
+}
+
+static spinlock_t *mock_domain_get_top_lock(struct pt_iommu *iommu_table)
+{
+	struct mock_iommu_domain *mock =
+		container_of(iommu_table, struct mock_iommu_domain, iommu);
+
+	return &mock->lock;
+}
+
+static const struct pt_iommu_driver_ops mock_driver_ops = {
+	.change_top = &mock_domain_change_top,
+	.get_top_lock = &mock_domain_get_top_lock,
+};
+
 struct mock_iommu_domain_nested {
 	struct iommu_domain domain;
 	struct mock_viommu *mock_viommu;
@@ -445,6 +469,8 @@ mock_domain_alloc_pgtable(struct device *dev,
 	if (!mock)
 		return ERR_PTR(-ENOMEM);
 	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
+	spin_lock_init(&mock->lock);
+	mock->amdv1.iommu.driver_ops = &mock_driver_ops;
 
 	mock->amdv1.iommu.nid = NUMA_NO_NODE;
 

LMK, if I shall send this as a separate patch?

Thanks,
Praan
