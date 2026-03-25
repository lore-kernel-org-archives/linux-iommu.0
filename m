Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF733D6FD
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431781; cv=none; b=U9pteOK+ScyNYrvM6umacMcbp2bk+KKQucOUvTkvY80Q2mUpiCOEesw9V+hVTkM7Wwn4t9rZfOBu3yM8e61Yx3WjwYAmtvNf5iCqMOecOAiXVQ7xAJfOw5zX2auLK79cv8GIJY1io9DgJM7DTfQH3qep3iYCmSHBGAunoV7R9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431781; c=relaxed/simple;
	bh=KqqO5Qx7MI3VU+BXJKMlc121HIcrzrJGXEtbCiZ5OrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcGr24y35VSOynG4Dc8DpndsFCNinFdp9hjgW24Mt2B3ztypLtki2TSRQ+LUOBTRlbyRt9jaNz+owfCSV6qC74sL0WYu04Ry+90DBK/NpHAq/8ky4+N0MxvWgDOy2syTJb1jVfTOueKoRjHwrEXAfP8D5FytUqvwSfxgClwk4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDmPmkVq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDmPmkVq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0b260d309so53745ad.1
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774431779; x=1775036579; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8q5oKgmZODAxLm8Q3smT3MhZZPU3P4zba0bwHslxpOw=;
        b=jDmPmkVq7UNSHIqwq7jlaYnAHPEjC7DluCVjJ78OqLtCFXvjc1F5s52Nfz8NCHjPQa
         w56xa2uG2kkMvVH3NxfSGR11pQM6O3Ri+5LHPq1cDexD36MsyaGo+a8JJVBBXoew4GBn
         oPVfhckh3ZxQSzjQeZh1RZqhl18QxUjqxVZeRIjd86EVjS/i37ITUdo7DRt1v1XnsMIQ
         BvQ7Epe/3J6fSsoVLfvN9mOcuM5gcAYho6dwdak2iv+8g7+BD3p5yrBpLasO4zGaU9/w
         5XqDaa1qn9uCS/LVnmbsL/x6KCDw8Vl+DjXS4bzfmuR2AymwARPJaJFTmbnI3/HkTcCe
         fHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774431779; x=1775036579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q5oKgmZODAxLm8Q3smT3MhZZPU3P4zba0bwHslxpOw=;
        b=Psaf1IFqF5tOywOU24jpflYRgGZpRKn+M4AYSgro2kkid7bvESuqAdwIsvMptXSVS+
         ifWV7z6L/HfQ2ezlSaIHpfIuhLy+trSX6f532fp3NW3JPE6TE1fX4iUmcPOE3KeLXpwU
         XpCRJ/kccm2Ky4Mw6y7YG2cT36xU/2IxCtGO4CzfPps3pxJjG4ROTfmJYvb7FRljgDoG
         r6wTiaZ+TKyfQsDF9mLvloamxmNa6Gt2mZy3CEyaW8lsR8HzXnhWx7TAETPQZta0357B
         ilShb8Eb9aOATQErnBSoYwQ609OW8ZOVdNDuLQts7w702yC2DgJ+lO3JEVKJRb8lkecD
         zfHA==
X-Forwarded-Encrypted: i=1; AJvYcCVVlw9dlwETPffY3VsSb7y9pcysMQb0mgOsRQWaKvmq4QOH4SdCyRqiMfDRhRllXQKOaOy4Sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/PIj5ZMS7ML6pX/xePB3Mxu7JPA3SIZJjZPN5rih7MDeXeXbi
	i9q6tddWO1cKZs/ULD1TeH4DvFT2QNFmRmv59oC8ie0rwjCecbBiS/O8XAoJCgm0JA==
X-Gm-Gg: ATEYQzxP9j39uVmd1oMHiC5XixAppXLQBWKz/9bdVlIQtRlXoPfQ2XysBoth5IMpQO7
	hymsxZ9aTY1NPsKGJ4SbIQsYJuyKODaSPgJimZWO3/ActYCLs0Nn3X5Vwj4/JA9K7kxnjl1Yl5L
	zgSKPDsOi8Y5/yRA9uGILEqwLUsF/4bNHU/uP2LmtGHc4MWk8HWywoZVo/6RuV+/Lzb1lFC/NHh
	BjiSmyzlnHW/6Y3OkdfEI2zOeyDIjew4XTVAoMyT6AjPC76OuAxPEwTpowluqi2//vzOmnFJoRV
	BfBGOZ5504/kMfBNROiRcUoURvtDMOfq3xKcMUbgydPHDJ8i90EpwsPKVxJvrqUwSZ8tDFiwF/i
	DCbSnhcZoAuVy36iSQBrMyFDyz1o/I4KVOSURni5K1DhPDE3cq757I2fUMzx9KypPQUWgBfEB3U
	xXNK7HPNvZqhsvbESfIKDR+QLb56iWTegIM/uQj5pM49NDYCfV675m8LxVOg==
X-Received: by 2002:a17:902:f710:b0:2b0:9a61:9d9 with SMTP id d9443c01a7336-2b0b2a45b05mr1694045ad.9.1774431778833;
        Wed, 25 Mar 2026 02:42:58 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655474sm225621335ad.48.2026.03.25.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:42:58 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:42:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: syzbot <syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com>,
	iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org,
	kevin.tian@intel.com, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: Re: [syzbot] [iommu?] WARNING in pt_iommu_amdv1_init
Message-ID: <acOuHIOx8jnZUseW@google.com>
References: <69c1d50b.a70a0220.3cae05.0001.GAE@google.com>
 <acKhtdpfSctT5r5I@google.com>
 <nvmacpqf4nisbhxct3vfiphyhqllfn5ojf5r5dm47aflseocwl@4bwo7kz6bjuf>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nvmacpqf4nisbhxct3vfiphyhqllfn5ojf5r5dm47aflseocwl@4bwo7kz6bjuf>

On Wed, Mar 25, 2026 at 05:19:51AM +0000, Ankit Soni wrote:
> On Tue, Mar 24, 2026 at 02:37:41PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Mar 23, 2026 at 05:04:27PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    0e4f8f1a3d08 Merge tag 'parisc-for-7.0-rc5' of git://git.k..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=176df352580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=453eb7add07c3767adab
> > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0e4f8f1a.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/838ecdb7b55f/vmlinux-0e4f8f1a.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/3742378914db/bzImage-0e4f8f1a.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
> > > 
> > > iommufd_mock iommufd_mock1: Adding to iommu group 10
> > > ------------[ cut here ]------------
> > > !iommu_table->driver_ops || !iommu_table->driver_ops->change_top || !iommu_table->driver_ops->get_top_lock
> > > WARNING: drivers/iommu/generic_pt/fmt/../iommu_pt.h:1249 at pt_iommu_amdv1_init+0xa10/0xb20 drivers/iommu/generic_pt/iommu_pt.h:1249, CPU#1: syz.0.1303/9714
> > > Modules linked in:
> > > CPU: 1 UID: 0 PID: 9714 Comm: syz.0.1303 Tainted: G             L      syzkaller #0 PREEMPT(full) 
> > > Tainted: [L]=SOFTLOCKUP
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > RIP: 0010:pt_iommu_amdv1_init+0xa10/0xb20 drivers/iommu/generic_pt/iommu_pt.h:1249
> > > Code: e8 95 a4 e7 fc e9 aa f6 ff ff e8 db 18 7b fc 89 ab 94 00 00 00 e9 15 ff ff ff e8 cb 18 7b fc e9 e4 fd ff ff e8 c1 18 7b fc 90 <0f> 0b 90 e9 19 ff ff ff bd a1 ff ff ff e9 cc fd ff ff 4c 89 cf 4c
> > > RSP: 0018:ffffc90003747a68 EFLAGS: 00010287
> > > RAX: 00000000000007ee RBX: ffff88802bb03500 RCX: ffffc9000407a000
> > > RDX: 0000000000080000 RSI: ffffffff858db73f RDI: ffff888026f94980
> > > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > > R10: 0000000000000034 R11: 0000000000000000 R12: 0000000000000034
> > > R13: 0000000000000040 R14: 0000000000000000 R15: 0000000000000034
> > > FS:  00007f29a60136c0(0000) GS:ffff8880d6442000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 000000110c3f39c7 CR3: 000000003d1d7000 CR4: 0000000000352ef0
> > > Call Trace:
> > >  <TASK>
> > >  mock_domain_alloc_pgtable drivers/iommu/iommufd/selftest.c:491 [inline]
> > >  mock_domain_alloc_paging_flags+0x29b/0x680 drivers/iommu/iommufd/selftest.c:548
> > >  iommufd_hwpt_paging_alloc+0x393/0xb20 drivers/iommu/iommufd/hw_pagetable.c:149
> > >  iommufd_hwpt_alloc+0xb46/0x1af0 drivers/iommu/iommufd/hw_pagetable.c:369
> > >  iommufd_fops_ioctl+0x358/0x520 drivers/iommu/iommufd/main.c:533
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> > >  __se_sys_ioctl fs/ioctl.c:583 [inline]
> > >  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7f29a519c799
> > > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f29a6013028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > > RAX: ffffffffffffffda RBX: 00007f29a5415fa0 RCX: 00007f29a519c799
> > > RDX: 0000200000000200 RSI: 0000000000003b89 RDI: 0000000000000009
> > > RBP: 00007f29a5232c99 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 00007f29a5416038 R14: 00007f29a5415fa0 R15: 00007ffedd2b95c8
> > >  </TASK>
> > > 
> > > 
> > 
> > I believe this is because we don't populate struct pt_iommu_driver_ops
> > for the "mock" iommu / selftest? Would defining mock ops help fix this?
> > 
> > I have a patch that seems to fix the WARN_ON:
> > 
> > diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> > index 9607416f8069..1599eb737d2a 100644
> > --- a/drivers/iommu/iommufd/selftest.c
> > +++ b/drivers/iommu/iommufd/selftest.c
> > @@ -119,6 +119,7 @@ struct mock_iommu_domain {
> >  		struct pt_iommu_amdv1 amdv1;
> >  	};
> >  	unsigned long flags;
> > +	spinlock_t lock;
> 
> May be top_lock for consistency with kunit?
> Otherwise looks good to me.
> 
> -Ankit
> 

Ack. Sure, I'll send out a patch. Thanks!

Thanks,
Praan
