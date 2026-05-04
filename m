Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A53A1A3B
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912829; cv=none; b=axyBpSb76ZAHnDtc3hdKMC8IIgCMsxL0UXzcaDbN4q4pJ44VY+3CHWdvjrdLcx7VjPD4C5/Xk55umU6lg3Co3r6XNb0OHM3AhS0jcEZwfs/jnamrj1BW2OLX7XwdUvt+ugcbuagcbY/zKLnE4rFFCfST3gpV5OSc3gmE/hzDyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912829; c=relaxed/simple;
	bh=98KswLkf9R7TSt34ZPEI3zBKrsIAN9qmZYzkdwfwxNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvQAyRCAGNQG5avbw3yWWVQ7ahkePkcxk8qY/2HyieecEu/Yt/UBJUymXx2hmBSf38oDlXmj+FhoY62KmMYw5mvNJZmrAzT9qwdml8nYzuSych2sFPAU3+4CJttByq7D+PpF0WN41XXpfxkLCMzQUr1y21iPbyqO8Wd3TpGMb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czGYd3bF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czGYd3bF"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso2815ad.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777912826; x=1778517626; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SysG5imseDEgi7rKptNpjMCLBMz/0m14tYC8Zg14SjQ=;
        b=czGYd3bFkrENH0paLa9kepGWwr65mD4rSRzPvNE7uo4CGMJCKwXXPWtGtMfCvwrRZO
         8+Ml2WXb/1xfWxiRsaSHpSsUzigL6/DI0vmQbDbXv3Cbx84TPWSZmPD+6Pr4j15DDxcT
         MnBe7ERXakFmT+xjaLyzJQ42efloPMs5b7t7zVAp9bQWN1XF32BUMV21huRJfWWl/pJD
         Svuu9MlvR3LjkIColLiOS8I4ZlQtOzcpIQzqnYGEvLneNgIHo2ldVuwwUl/vvLAK2ccd
         D0ApPOHWFlJdkQohURXTk09aYPYav+KRccUSgWNfGZG5Kn1ZRsEwyPCTFA+W2z3pq8gT
         t4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777912826; x=1778517626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SysG5imseDEgi7rKptNpjMCLBMz/0m14tYC8Zg14SjQ=;
        b=f2Dncj/GhXoUXG6Mjkau56o6yVue+UZOQSPGrZWBTw9A6Bwe92jBCAy6kak4bGa2m3
         0Qe3+iLXHJMqcdPe/WViGEd5VQLf9JADD21UV1BwTskBHnTzmdK4PdIwQmTRgE8MmL/b
         J5iCXHEuf1qBqrAf0ctp+vT/VLO7U4CtszPAaY0eJm47j/Z5FtGueMd2o4jcy6QfZLNg
         8IyhsdBN4+2duBlGmPE3ne8dZvkKFdEGHOikAsi680nZUL/AnoYh86mEJy71F43MCdo9
         dLPTsgXNBVtieUqzNz49kj0x7mdCy9IxBnScvSewXzTDeMKk1yxkV3davtI648PzHqKQ
         Zq1g==
X-Gm-Message-State: AOJu0Yx3fKQpUXnW9FkfzAEBXQ9fatB0zpFzGOBuURq7fZQkB8nJX9cv
	CTfHR0o0ia7WrUHZ7vMs6uYsGxPRybl2GgwoU5e0AL0tcXOAlItDPeQrwmfvFMwbC15Oqwazy4Q
	jCcy6NQ==
X-Gm-Gg: AeBDietBMc//ekgVnT6Zk8tGaSux2nxFa6zVyZVVZAEWxYbFHy2Uls3vcAjh3aIs9IK
	7xoAUDaPLMiapE5UMsdmyxFMsnMzvu/FV68OTLlzi5KYuNOAvGnZkuZRMLIJnh4SfdK5hA72WEa
	TQYiW5B+ulvj7wZHKUfbq0KxUpp0CTZlUFFYVwUe8z7Zo/D7v0s1/XZXz33iMEMvozw46mXBoyc
	z/Mcs6qkrOq2osOmEajYZ5yGLxkf76cE9WmKgJmwiHlYED/n42gnKmZN3mh5vTqfhyGDYE5RDs7
	dYivxMDMKZ77ZLIOl+CDOUKQj6XmbJ7tMCjE6Ntbg3cfHKG0I9BYaIXwiJ6CG19ie6ZHHffOQVL
	etYuKRKbXVzPKaUNHPx5EEtSyU2srpcaoS9AIh9VeVYa9eDhbAvOLXura3wk2Eh38lZ00oyXtEI
	fMoMyuU2D7MLmmFDBhRh4KsQK56C0ctnREYSSF6aR5CF67Spkx170d7tHb+NxvdZF2o5uGA1HyX
	O+mlmM=
X-Received: by 2002:a17:903:98f:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2b9f5891294mr4674545ad.13.1777912824310;
        Mon, 04 May 2026 09:40:24 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83812cbdb1csm3081921b3a.20.2026.05.04.09.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:40:23 -0700 (PDT)
Date: Mon, 4 May 2026 16:40:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Fix inconsistent ATS state tracking
Message-ID: <afjL8sUdlFCdVfno@google.com>
References: <20260504125343.2088858-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504125343.2088858-1-praan@google.com>

On Mon, May 04, 2026 at 12:53:42PM +0000, Pranjal Shrivastava wrote:
> arm_smmu_enable_ats() ignores the return value of pci_enable_ats(). If
> pci_enable_ats() fails, the driver still updates its internal state
> master->ats_enabled to true in arm_smmu_attach_commit().
> 
> This leads to a state mismatch between the SMMU driver and the PCI core,
> the SMMU driver operates assuming ATS is enabled. Later, when detaching
> the device the driver callspci_disable_ats() because it believes ATS is
> enabled. This triggers a warning in the PCI core since ATS was never
> actually enabled on the device:
> 
> [  127.925080] ------------[ cut here ]------------
> [  127.925084] WARNING: drivers/pci/ats.c:132 at pci_disable_ats+0x94/0xa8, CPU#42: iova_stress/12240
> [  127.949761] Modules linked in: vfat fat dummy bridge stp llc cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd
> [  127.961760] CPU: 42 UID: 0 PID: 12240 Comm: iova_stress Not tainted 7.1.0-smp-DEV #4 PREEMPTLAZY
> [  127.970619] Hardware name: <REDACTED>
> [  127.977655] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [  127.984603] pc : pci_disable_ats+0x94/0xa8
> [  127.988687] lr : arm_smmu_attach_prepare+0x104/0x310
> [  127.993641] sp : ffff8000ae013ab0
> [  127.996943] x29: ffff8000ae013ac0 x28: ffff0001481b0000 x27: ffff000103d17980
> [  128.004066] x26: ffff0001093aad48 x25: ffff0001093ab020 x24: ffff0001118200c8
> [  128.011189] x23: ffffcf76ddf1ca1c x22: ffffcf76df679020 x21: ffff000148f1df00
> [  128.018311] x20: ffff8000ae013c18 x19: ffff8000ae013b28 x18: 0000000000000000
> [  128.025434] x17: 0000000000000000 x16: ffff00010945a358 x15: ffff000110ffd080
> [  128.032557] x14: 0000000000000200 x13: 0000000000000002 x12: 0000000000000001
> [  128.039679] x11: 0000000000004040 x10: 0000000000000001 x9 : ffffcf76dd37f504
> [  128.046801] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> [  128.053924] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff0001093ab000
> [  128.061046] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffff000111820000
> [  128.068169] Call trace:
> [  128.070603]  pci_disable_ats+0x94/0xa8 (P)
> [  128.074688]  arm_smmu_attach_prepare+0x104/0x310
> [  128.079292]  arm_smmu_attach_dev_ste+0x128/0x1e0
> [  128.083899]  arm_smmu_attach_dev_blocked+0x50/0x88
> [  128.088677]  __iommu_attach_device+0x30/0x138
> [  128.093026]  __iommu_group_set_domain_internal+0xdc/0x228
> [  128.098412]  __iommu_take_dma_ownership+0x118/0x150
> [  128.103278]  iommu_group_claim_dma_owner+0x48/0x80
> [  128.108056]  vfio_container_attach_group+0xc8/0x1b0
> [  128.112927]  vfio_group_fops_unl_ioctl+0x578/0x968
> [  128.117706]  __arm64_sys_ioctl+0x90/0xe8
> [  128.121622]  invoke_syscall+0x50/0x108
> [  128.125366]  el0_svc_common+0x94/0xe8
> [  128.129016]  do_el0_svc+0x24/0x38
> [  128.132319]  el0_svc+0x44/0xf8
> [  128.135364]  el0t_64_sync_handler+0x68/0xe0
> [  128.139534]  el0t_64_sync+0x1b0/0x1b8
> [  128.143185] ---[ end trace 0000000000000000 ]---
> 
> The issue was exposed under heavy load when running a VFIO-based DMA map
> stress test: iova_stress [1]
> 
> Fix this by propagating the error from arm_smmu_enable_ats() and updating
> state->ats_enabled to false on failure. This ensures that
> master->ats_enabled correctly reflects the actual state of the device.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> [1] https://github.com/soleen/iova_stress

Missed the Fixes tag here, posted a v2:

https://lore.kernel.org/all/20260504163842.2692314-1-praan@google.com/

Thanks,
Praan
