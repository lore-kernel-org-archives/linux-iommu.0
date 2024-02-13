Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B0C5FEF0
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844893; cv=none; b=tAQQ2mTp8DWngXftnbM7Mo1Hcxk9G78bklfmD3nY3oWjdNt7neZg6b5HxcW9U8gUictqo5dro9b8YKt+sqvIZXfC734W88zo+D/NEbY85I+fPHsgrQuUrpHk+G+aWM6LoBxLphpoJr5zx9GXNew4hc07P3mbhWApxS4f3KFZ/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844893; c=relaxed/simple;
	bh=hcjAdGU2y1Rf2EkMPADXNOQHw5fbyPnlF3WuzFPmY/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDTZXckxsww8E4CqW61zlo8uYOnNUiKcW9x6a87kjG9haOUWXv0kmmr4MyrCCP/N4LevlqxRO5IwtVmn8w3aQJNyarTNTd0yMBkMSAjtHBkSjqsTsGZstFtbx60xeeMXFmlhPojqvXsRod/gwMI4xOh6l94t/CFswT/78QcHP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CIBno/Lk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CIBno/Lk"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78717221b97so91674585a.0
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 09:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707844890; x=1708449690; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfOPh/BqdQypQuQgOAcqvG3lzkEYY5+SsbNQWX/xDNY=;
        b=CIBno/Lk2eHIYWdN2XKHU1M4gepb2yXap6h262OX3D6dEErBZViboxs/6WXkiqY5ww
         73uneRbOoXz0j0rEkRXqzC2ejrOldAC/1a8nif6nBtP3H5HhoABAVUL7NJAa6Ot8rNOD
         Dr6vSBizR1IdmpdrUglzarfsoVVvjHLHLI0SjhJI7ZektLxdMPeyLUsgS9GEFWHlD63B
         M5n05UvkeDD9BG5Z4Y8wfxaEFQOuFyuCGtJ9drIyxOYhZstGfWXAYYKWkSH/zG/wiJe7
         Qeo9oO9jKabDkhu8AUWLL64+fUE+NzpPRTwDLFFzyNSMZUoPQl4XmFOROTBt7/iGodYB
         FAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844890; x=1708449690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfOPh/BqdQypQuQgOAcqvG3lzkEYY5+SsbNQWX/xDNY=;
        b=Nnp9CXl5pooAbVhNOtoipJBDvTPOrDUUgfhFBIglHuc7jm3YaC/N3rRdS9Mz/PMn9l
         wM9A27A5qYGlhCQeFAQVne5HQnl142xOgfKWc4d/XklutspPM0RpQbmIYDuJna8ErdKj
         93ve0xJLpGlvZTXlOiVYveIL3JPpnGpY7TMxTydeME8vq7raoE7QWdxO8k4rknOorwKD
         eHxo1T+HdCAQmkBRogbcn8Xmnz8MjhZFODSOO0V6ffKJK1b9/JnKLVnUIK4ZvKhxy1NI
         dhPMo7bYaLdC9nKLTB4GkyxVGF72XBdlnLYVTFXcVM/b6PIGiGTJecCYwSicVvs4yB/1
         NbgA==
X-Gm-Message-State: AOJu0YwhDEIJRrRYLiquztvbpZIKhunNsH6LwTOtdH4f/cdM/bzi73dF
	sXjTFOSS27KQb0V6g8qfSLL+CgirKJhBwV2rQf2ZpB+QEkSWllBri9+tw6Pel/M=
X-Google-Smtp-Source: AGHT+IG8vF8/kAolu+KbN/OJVluGuZcuIB2j+u8jMp0YTm90zXLxcGA3ZvyJYK/SOL+JmUfs4WG4aw==
X-Received: by 2002:a05:620a:11a6:b0:787:199f:23b8 with SMTP id c6-20020a05620a11a600b00787199f23b8mr215600qkk.64.1707844890105;
        Tue, 13 Feb 2024 09:21:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGORr6d4Zg/HR+6mysaX0NMW4ZUpUUx42HuvkW71LSBigOet/8jqa2JAR3j5trOh5dgDymLQXx+cpDCRZGdkgoVwNob7aeC/3lrJnyLgedj550ZHysDTBqULru7WMPXIBM0BH99M9XW/QCch94e/IrK4rGl3wC6oHh7sQ49rE9+zOqXX6Bl9TA+5eXJwooyU6UGwPIHWshYmCvtWlzV5sqpiUOEmRcqd4p8xsAjj7Nm1H0FHoPXH8Q/m+IUNlX6sd9IhWBdWIuYsn7FEFBHTiEHnz0NH4vhG1X+EsYX0qd4r7tkzl3BZ8am4ICuvyYJ5WZJR3f7VP7gA/vRKpRRMQMy1fq4CP2qaTVDzCTn7yuOMgaEabdpjcCUBbMqj4ZJKPj3kcVhFqD5P83+HKJOUnzDmkYmYXCXxv0DFDEgUnY1qx+ROALb+EghKvUeWHOlLgQCXs0tpgyN+8XT1pMm3zoDvlGWELlXRE0LugnZaLGzjuIaDBOuavWjv+U36oayh1YPfOHqhqJ9DFt4Qf+7q2ME2KYd8iQpMuGiyBWjEVcZvfG
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id w17-20020ae9e511000000b007856bff53d3sm3084439qkf.54.2024.02.13.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:21:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZwTI-005N9E-UB;
	Tue, 13 Feb 2024 13:21:28 -0400
Date: Tue, 13 Feb 2024 13:21:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, jroedel@suse.de,
	tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
	gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
	vaibhav@linux.ibm.com, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/iommu: Fix the missing iommu_group_put() during
 platform domain attach
Message-ID: <20240213172128.GM765010@ziepe.ca>
References: <170784021983.6249.10039296655906636112.stgit@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170784021983.6249.10039296655906636112.stgit@linux.ibm.com>

On Tue, Feb 13, 2024 at 10:05:22AM -0600, Shivaprasad G Bhat wrote:
> The function spapr_tce_platform_iommu_attach_dev() is missing to call
> iommu_group_put() when the domain is already set. This refcount leak
> shows up with BUG_ON() during DLPAR remove operation as,
> 
>   KernelBug: Kernel bug in state 'None': kernel BUG at arch/powerpc/platforms/pseries/iommu.c:100!
>   Oops: Exception in kernel mode, sig: 5 [#1]
>   LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
>   <snip>
>   Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
>   NIP:  c0000000000ff4d4 LR: c0000000000ff4cc CTR: 0000000000000000
>   REGS: c0000013aed5f840 TRAP: 0700   Tainted: G          I         (6.8.0-rc3-autotest-g99bd3cb0d12e)
>   MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44002402  XER: 20040000
>   CFAR: c000000000a0d170 IRQMASK: 0
>   GPR00: c0000000000ff4cc c0000013aed5fae0 c000000001512700 c0000013aa362138
>   GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000119c8afd0
>   GPR08: 0000000000000000 c000001284442b00 0000000000000001 0000000000001003
>   GPR12: 0000000300000000 c0000018ffff2f00 0000000000000000 0000000000000000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR24: c0000013aed5fc40 0000000000000002 0000000000000000 c000000002757d90
>   GPR28: c0000000000ff440 c000000002757cb8 c00000183799c1a0 c0000013aa362b00
>   NIP [c0000000000ff4d4] iommu_reconfig_notifier+0x94/0x200
>   LR [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200
>   Call Trace:
>   [c0000013aed5fae0] [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200 (unreliable)
>   [c0000013aed5fb10] [c0000000001a27b0] notifier_call_chain+0xb8/0x19c
>   [c0000013aed5fb70] [c0000000001a2a78] blocking_notifier_call_chain+0x64/0x98
>   [c0000013aed5fbb0] [c000000000c4a898] of_reconfig_notify+0x44/0xdc
>   [c0000013aed5fc20] [c000000000c4add4] of_detach_node+0x78/0xb0
>   [c0000013aed5fc70] [c0000000000f96a8] ofdt_write.part.0+0x86c/0xbb8
>   [c0000013aed5fce0] [c00000000069b4bc] proc_reg_write+0xf4/0x150
>   [c0000013aed5fd10] [c0000000005bfeb4] vfs_write+0xf8/0x488
>   [c0000013aed5fdc0] [c0000000005c0570] ksys_write+0x84/0x140
>   [c0000013aed5fe10] [c000000000033358] system_call_exception+0x138/0x330
>   [c0000013aed5fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
>   --- interrupt: 3000 at 0x20000433acb4
>   <snip>
>   ---[ end trace 0000000000000000 ]---
> 
> The patch adds the missing iommu_group_put() call.
> 
> Fixes: a8ca9fc9134c ("powerpc/iommu: Do not do platform domain attach atctions after probe")
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  arch/powerpc/kernel/iommu.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Doh, that is a weird splat for this but thanks for finding it

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
