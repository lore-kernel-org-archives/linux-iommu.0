Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3233C19F
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172849; cv=none; b=jS+PYnECp2/gE/15nQweNZN/RXyc3X8oF+7nmRAqcb1g38FAMBClUH38jH88Fp9SxogyUCbLwsBIUvyqKGChtWwOoyRVwOFeTzpjPvvir//pQjhKcmKMoq8c/OE5juHDb0JYknv13um6jGXx/04mD1PZFX+Wz3l/bXEFfsyAVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172849; c=relaxed/simple;
	bh=h0SxTkaoDPbb2W37BYZc5Fke0UBeyd6stOCq9eXOHkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC2PVgjcAFCGGgHcI/QMO6aIq6Nenmjd2prxYvNaBv+UaG6qyMTdxLsudi/fBkxrXaeHv0ajb9DT4fzzDds3JXIcTwegEKSIy5ZIuceZj1zJOZcdwPpwUZNdy6MBCgeLGxbGGJvNFzdBIHh4M1VTE5E18qA+zHOaF87iAMAZQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AgQ4vHHb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AgQ4vHHb"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EAFBA40E016C;
	Wed, 26 Nov 2025 16:00:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mqLyJcWa217K; Wed, 26 Nov 2025 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764172839; bh=HygReu3x+YLBX+tLq7J1t0NTINx5NJJKUawr2psUbHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgQ4vHHb65Jcar5FDE6nf4kZ2958/Z0xEGPKVHij1/ktd9Z4TNIqeGEczq4BHKXN2
	 wObnkpGeMVgEFP2AkE3lH+YSk0u1o/HAKyaK0QOzgtX6co7RSPpDQiIfWItIvR+Y72
	 a/KxE+n991WE5LGkntH6xU/hcJFQ7kgQcA72H5haOq/VIz6eMbYZwVgqv1L7XpMLaV
	 jUgwMemulOYVxH4vAFLMCaI7LBQNOT0vu+JRJVAWb0174Vbfa4UZSDaaLNTWTry26z
	 Ijz7sGXJU7qBNHA3dn1apnHzZfF5R7bNZJdjxaJjo0WShB41x+Z9hFiFYW61Hzq6sj
	 4J5sfxwsjOifRGOS2hMX/IY8t+k2NuL3lt6Ukz7PHGOzHvcIp38ngzLI8FJYyIL9Sv
	 X91zYgvkv+BHKojI6grnKskw0tnLdIpz4MJTQUARpDHhzV05nSJMEG86bd8dJfIK9q
	 67bhlez50E87aLGPxMM1FKkXfynXKxiRjSJOQKtXjTPYksnlTiSxMuXWmIHEkPd8WV
	 zVP/19vKPySfgNLBtkv0pM4lGFpERgmjRqWKSAK13iCBc3Z7Sr7E0q1aiHMq2R3jF5
	 FEGR7WrFvIbcTEOQl9XO78U/h/dPPiknideYs11c4lfsW7Yq/yOYyKicRBNj1Kz3Ku
	 DKqtJw6XI/utwFyIUde4v0Ck=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8386840E016E;
	Wed, 26 Nov 2025 16:00:32 +0000 (UTC)
Date: Wed, 26 Nov 2025 17:00:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: iommu@lists.linux.dev, Vasant Hegde <vasant.hegde@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
Message-ID: <20251126160031.GGaSckH3SHrC8ckPa7@fat_crate.local>
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>

+ Vasant.

On Wed, Nov 26, 2025 at 03:32:19PM +0100, Borislav Petkov wrote:
> Hi,
> 
> this is latest Linus + latest tip/master. Box is Zen3. CCing AMD IOMMU folks
> because the backtrace points to it.
> 
> Ideas?
> 
> [   12.946913] (journald)[506]: Found cgroup2 on /sys/fs/cgroup/, full unified hierarchy
> [   12.948083] (journald)[506]: Successfully forked off '(sd-mkuserns)' as PID 507.
> [   12.977579] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
> [   12.983638] rcu: blocking rcu_node structures (internal RCU debug): l=1:0-15:0x1/.
> [   12.983644] Sending NMI from CPU 1 to CPUs 0:
> [   12.983652] NMI backtrace for cpu 0
> [   12.983655] CPU: 0 UID: 0 PID: 504 Comm: (modprobe) Not tainted 6.18.0-rc7+ #1 PREEMPT(voluntary) 
> [   12.983658] Hardware name: Supermicro Super Server/H12SSL-i, BIOS 2.5 09/08/2022
> [   12.983660] RIP: 0010:delay_halt_mwaitx+0x37/0x40
> [   12.983665] Code: 01 31 d2 89 d1 48 05 00 d0 3a 83 0f 01 fa b8 ff ff ff ff b9 02 00 00 00 48 39 c6 48 0f 46 c6 48 89 c3 b8 f0 00 00 00 0f 01 fb <5b> e9 ae 2b 1d ff 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> [   12.983666] RSP: 0018:ffffc90000003d88 EFLAGS: 00000097
> [   12.983668] RAX: 00000000000000f0 RBX: 0000000000000b9b RCX: 0000000000000002
> [   12.983670] RDX: 0000000000000000 RSI: 0000000000000b9b RDI: 00000034e14b49dc
> [   12.983671] RBP: 00000034e14b49dc R08: 000000000000006c R09: 0000000000000002
> [   12.983672] R10: 0000000000000050 R11: 0000000000000002 R12: 00000000000001a4
> [   12.983673] R13: 0000000000000002 R14: ffff888100064018 R15: ffff888100064000
> [   12.983674] FS:  00007f8ae7452e00(0000) GS:ffff889086e58000(0000) knlGS:0000000000000000
> [   12.983675] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.983676] CR2: 00007f8ae6c9a8a0 CR3: 0000000141913004 CR4: 0000000000770ef0
> [   12.983677] PKRU: 55555554
> [   12.983678] Call Trace:
> [   12.983680]  <IRQ>
> [   12.983682]  delay_halt+0x3b/0x60
> [   12.983685]  iommu_completion_wait.part.0.isra.0+0xd3/0x100
> [   12.983693]  domain_flush_complete+0x64/0xc0
> [   12.983696]  amd_iommu_flush_iotlb_all+0x33/0x50
> [   12.983700]  fq_flush_timeout+0x34/0xd0
> [   12.983703]  ? __pfx_fq_flush_timeout+0x10/0x10
> [   12.983706]  call_timer_fn+0xa8/0x220
> [   12.983713]  ? __pfx_fq_flush_timeout+0x10/0x10
> [   12.983715]  __run_timers+0x1f6/0x2b0
> [   12.983724]  run_timer_base+0x46/0x60
> [   12.983727]  run_timer_softirq+0x16/0x30
> [   12.983729]  handle_softirqs+0xe5/0x430
> [   12.983736]  __irq_exit_rcu+0xc3/0x120
> [   12.983738]  irq_exit_rcu+0xa/0x30
> [   12.983740]  sysvec_apic_timer_interrupt+0x89/0xb0
> [   12.983744]  </IRQ>
> [   12.983744]  <TASK>
> [   12.983746]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> [   12.983749] RIP: 0010:console_flush_all+0x49e/0x620
> [   12.983751] Code: 90 60 01 02 0f 85 91 01 00 00 48 83 c4 40 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f e9 78 a1 d5 ff e8 c8 ce 0e 00 fb 0f 1f 44 00 00 <41> 80 3c 24 00 48 8b 43 58 0f 84 07 ff ff ff eb ba e8 5c cf 0e 00
> [   12.983752] RSP: 0018:ffffc90003d87bf8 EFLAGS: 00000202
> [   12.983754] RAX: 000000000000162f RBX: ffffffff82a59f80 RCX: 0000000000000000
> [   12.983755] RDX: 0000000000000000 RSI: ffffffff8255d9fc RDI: ffffffff82532a7e
> [   12.983755] RBP: 0000000000000200 R08: 0000000000000001 R09: 0000000000000000
> [   12.983756] R10: 0000000000000001 R11: 0000000000000003 R12: ffffc90003d87c73
> [   12.983757] R13: ffffc90003d87c78 R14: 0000000000000000 R15: ffffffff813a9e3d
> [   12.983758]  ? console_flush_all+0x33d/0x620
> [   12.983768]  ? console_flush_all+0x498/0x620
> [   12.983770]  ? console_flush_all+0x3d/0x620
> [   12.983776]  console_unlock+0x155/0x230
> [   12.983781]  vprintk_emit+0x2e5/0x500
> [   12.983787]  devkmsg_emit.constprop.0+0x56/0x70
> [   12.983793]  devkmsg_write.cold+0x1c/0x4a
> [   12.983797]  do_iter_readv_writev+0x139/0x230
> [   12.983802]  vfs_writev+0xfa/0x500
> [   12.983817]  ? do_writev+0x7e/0x120
> [   12.983819]  do_writev+0x7e/0x120
> [   12.983824]  do_syscall_64+0x62/0x350
> [   12.983828]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   12.983830] RIP: 0033:0x7f8ae6a99687
> [   12.983832] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [   12.983833] RSP: 002b:00007ffc877c5cf0 EFLAGS: 00000202 ORIG_RAX: 0000000000000014
> [   12.983835] RAX: ffffffffffffffda RBX: 00007f8ae7452e00 RCX: 00007f8ae6a99687
> [   12.983836] RDX: 0000000000000007 RSI: 00007ffc877c5dc0 RDI: 0000000000000003
> [   12.983836] RBP: 00007f8ae6f133c6 R08: 0000000000000000 R09: 0000000000000000
> [   12.983837] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> [   12.983838] R13: 00007ffc877c5f88 R14: 000000000000001f R15: 0000000000000000
> [   12.983847]  </TASK>
> [   12.984730] (journald)[506]: ID-mapping is supported for exec directory /run/systemd/journal
> [   13.400185] (journald)[506]: Successfully forked off '(sd-mkdcreds)' as PID 510.
> [   13.400955] (sd-mkdcre[510]: Changing mount propagation /dev (MS_REC|MS_SLAVE "")
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
