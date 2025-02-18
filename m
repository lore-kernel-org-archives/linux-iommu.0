Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2A243361
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887780; cv=none; b=SywPTvW1dIf/zJItE6/jIoSdJBXGaDBNZpYgGLwZHPjyRVEKPtPxTd0vyTVEapluGU7XALbMt9J4BvyuzxfYF+JzetXMf0N6OZ6s/xK6AmLcX2XXEIKmalt6LxAjXo307cXCJLRxdLAfM3S5+eTsX/8RL2vWGcj74N0dp1okb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887780; c=relaxed/simple;
	bh=LDe4YY/D/KG814sUzaFt57nrvQqaY4+cHfBTOTZhp4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCK5CbnYyzXpPSE/lREwqwFvqMdpd7SaruZYQrI02LNEJTohZxIEwkqgnjH2LI+PGczaQwkRZIfprY8aZTdaKUgB9i5YXldBdfJW9el8e8ufP1g8waPrkmjEyNHH+a7tCwGFb3DG/wNhVpRMnf0xli5ynx/pT0iW95tP4eQ+rJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so4106490a12.3
        for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 06:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887777; x=1740492577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOqpNPfprzC/VuOUsgbWKiDS4uVsWF0Gzq7YLXne2M0=;
        b=b/L3VlNhTE/HOFlgKqhBkjZEdYtIUs9XIqXRlplFkt3fxBHmzp0QJ7KOwWVKfjo0BG
         i2yfiePc7A8ENzrjzQLEsi/g2Vmlz3E3dLbvVOOZKdnlzVsaZVvyH2Fj6MBCRNjwTT1d
         mB++YDnlD9Lzq9PhTbHYFz22IkFlorloGhOq36VnojC6ZHoPe8H5AFkbK4sWX8o193eb
         ZuqqhBkaLUxg1skJ5mNvo/QJ7y+rjELLXBq1Ks0rEzUDP4VcgTUNDJeLJLyO7RhXoQvI
         J8On7kGbxBR+j8EpVFmD33RDXF6MAuIyk65aWmlih7AGw57zpKvzO+/Vq8aYgoMLPKAE
         wrqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG3bZSN1ZNpys9qc44GgH3la4GzOADC7SOv09/uWLjRxvP/LLWyGcSmyrHk8OwlUBADuOXSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDRzGVMqdjXKRW+iyVnq9zw2pFwWD10HDFd0MLXLCuoXtRrxYk
	sSd1mV+nw0218pYLMdw1G8aYFV67+aHFxDBAETxQl2Gc2TDcGHDrvZ6KbA==
X-Gm-Gg: ASbGncvbQh60Suu/4tP9NTfPKaZGrMfQnme1N9bh1G1tkyRQ4Kd1kUtyHsJTpWKd6cX
	JqzN1Do5i9T8f160MJcHvUPKjFrEFvy0aJOLL86bNsQ4bfxXDNxTNiOCNL/tl8FCeaTRw16sp4m
	aExW/r3omEiOtCKbgSayfQiK6joJ1LpBO6waxNjhj/UxW15/oe1zvS+FLv36skagO2th9qA1NhN
	gW/1C3AwylraKXHWMXmGNSKI0o81ytirqI515oM59damOx/CKcjWGtZOdDe9pcFmGASya8C7cFc
	EfNPnBo=
X-Google-Smtp-Source: AGHT+IF5nwrMpEy7s0eR61eGJJWsqTPMythWKfZZ2UKJQmRW6VNlsUYbb7Fb2C34VdjEApYgHubpIQ==
X-Received: by 2002:a17:907:70d:b0:aba:5e4b:b0b6 with SMTP id a640c23a62f3a-abb70e53b7dmr1229698566b.54.1739887776310;
        Tue, 18 Feb 2025 06:09:36 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba4fc0c29sm295532566b.157.2025.02.18.06.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:09:35 -0800 (PST)
Date: Tue, 18 Feb 2025 06:09:33 -0800
From: Breno Leitao <leitao@debian.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix suspicious RCU usage
Message-ID: <20250218-meaty-clever-buffalo-9ba688@leitao>
References: <20250218022422.2315082-1-baolu.lu@linux.intel.com>
 <Z7RdnR2onJ2AZIJl@shredder>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RdnR2onJ2AZIJl@shredder>

On Tue, Feb 18, 2025 at 12:14:53PM +0200, Ido Schimmel wrote:
> + Breno who also encountered this issue

Thanks. Please add the following if you feel appropriate.

Reported-by: Breno Leitao <leitao@debian.org>

> On Tue, Feb 18, 2025 at 10:24:21AM +0800, Lu Baolu wrote:
> > Commit <d74169ceb0d2> ("iommu/vt-d: Allocate DMAR fault interrupts
> > locally") moved the call to enable_drhd_fault_handling() to a code
> > path that does not hold any lock while traversing the drhd list. Fix
> > it by ensuring the dmar_global_lock lock is held when traversing the
> > drhd list.
> > 
> > Without this fix, the following warning is triggered:
> >  =============================
> >  WARNING: suspicious RCU usage
> >  6.14.0-rc3 #55 Not tainted
> >  -----------------------------
> >  drivers/iommu/intel/dmar.c:2046 RCU-list traversed in non-reader section!!
> >                other info that might help us debug this:
> >                rcu_scheduler_active = 1, debug_locks = 1
> >  2 locks held by cpuhp/1/23:
> >  #0: ffffffff84a67c50 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
> >  #1: ffffffff84a6a380 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
> >  stack backtrace:
> >  CPU: 1 UID: 0 PID: 23 Comm: cpuhp/1 Not tainted 6.14.0-rc3 #55
> >  Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0xb7/0xd0
> >   lockdep_rcu_suspicious+0x159/0x1f0
> >   ? __pfx_enable_drhd_fault_handling+0x10/0x10
> >   enable_drhd_fault_handling+0x151/0x180
> >   cpuhp_invoke_callback+0x1df/0x990
> >   cpuhp_thread_fun+0x1ea/0x2c0
> >   smpboot_thread_fn+0x1f5/0x2e0
> >   ? __pfx_smpboot_thread_fn+0x10/0x10
> >   kthread+0x12a/0x2d0
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork+0x4a/0x60
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork_asm+0x1a/0x30
> >   </TASK>
> > 
> > Simply holding the lock in enable_drhd_fault_handling() will trigger a
> > lock order splat. Avoid holding the dmar_global_lock when calling
> > iommu_device_register(), which starts the device probe process.
> > 
> > Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> > Reported-by: Ido Schimmel <idosch@idosch.org>
> > Closes: https://lore.kernel.org/linux-iommu/Zx9OwdLIc_VoQ0-a@shredder.mtl.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Thanks for the fix. I tested it and the warning is gone.
> 
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Tested-by: Breno Leitao <leitao@debian.org>
