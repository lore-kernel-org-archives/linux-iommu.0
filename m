Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143EB247294
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799103; cv=none; b=iw/LqTuo2cEIPI4TB3aUYsI+cekyxyh9Msqv0R0esJ5hihFgG8EikQxr61jRjBMxHAPgtEz7RS7ouuY15cqrKRQWkTwV1LybziQErtH+L/4zAOjmUTNeeOJX1gQBkrkSaO7kC18PgUf4eRsyVF3LAxpN9+ws0vALeGUUXMZIycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799103; c=relaxed/simple;
	bh=J87+9qooBPbJnMdctmuBgxzHJJMtdq6vrxmX2JYX0M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+kWxilN1eOgiF7MzOVIkvDyB06fKOGb7Ums4fyN00My40TD49W9oz8U1mlWmWzB5JfN8IWf3SbMBItqfKq43iQaciUSiLZ6gePd3AKTDbUHjUQjWGweEujMJhj/VVXXz6VavmzGPkBVtj211H7q7J/G+BOgedGW3gOVNeMAKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tg2BDM3X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tg2BDM3X"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2242ac37caeso128335ad.1
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744799101; x=1745403901; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+ySUBqpDCStVJ0jbWaBzxgrHSQdW0U948zt5rBiQC4=;
        b=Tg2BDM3XCsHVO10g7Fho78XzUXnEdunGkGBj/JhgynuKtKWX5K2NhzomZB9wflM5os
         XKPA8JSFliy0zfs/LtsDRRmVj51MrNZT8RIy38oWgP9X3tep2doEQmwaFXKpWBBgxNYF
         WZ2TG/2TI8ztMUH5xbWew2TYASIXb8PRpBBjkXKBMSqRJvowWZI6+BjVuSBcArJag9dz
         qJxJd6PkkTv5QUxxzL7U+6D0sz1OOd8p+9nUcZ0vS7g5lD7SHxScwboDJCGHesWEXY1y
         pbJpLgmH541tQZ97u0vi6Y8060p3cX0/GfMzB3v0u0z4qxKSxFrS5RZK5TsptkApA3jV
         1veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799101; x=1745403901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+ySUBqpDCStVJ0jbWaBzxgrHSQdW0U948zt5rBiQC4=;
        b=fpQ6M36nIZd814YuJSbeRCawD44rt7ZcqZaRBlvTKmPx1GNNCzFLird/K5ISqVeDl4
         RbuLuRRBHIS7iC1UJ6rfLZZqXLJgNUrhOSJ9P7FjZirW+pVAOa4x3jby/uRSxlvQsErj
         e3p8KNctf8xKkF5UeFOGVG43iHvW0RsBtiedoZ3qxDQrbAmQk2rCsZtgXumFSifNEiKl
         o66uhW/nBKT5ZfuFzhjb2+9lJjPm3ULXZ2GPJEJSdkubVVIAx4UU+/Asva7VDUZPUuln
         idXX3raWO2BatU8eo2d7V1ldqXDCGchhzlebIf+ulNR1CZIq08WefzPHjoB+BMWKfNOR
         4UOw==
X-Forwarded-Encrypted: i=1; AJvYcCVYxdrFJiiNACgRptW4eUafhq++h6No9+5J93VC9aEtisbSNkkamM/P3zPwlBm+cyRAvPdsXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLixvHnQbcqoBGEgJF91oOPMJ5cLnUsUC/4F5c3r/IUVceL9ji
	RQLhA+D3+1IB7LoH7vMERvxN7qQQsIGCzMuFMwzPNFE5fxPSC7c0WLK+/oXznw==
X-Gm-Gg: ASbGncuNl9iVqxc0/UfLtCvvnlTcZS0uY2GjcNP/UIFQRI5B1xrA+8VxJQKw/pdJ6cO
	Vx0D3HzMwfxOcP/fx6bfJXyP5qgj92MheT0sKpzqPQu7iWs081DcD2bNHR09CtaruNfGoNKA0S7
	GiWC2dR+diRliX5iF5zgN/jcr4B8WorI6JwSyUXePPzuNXoNMcbkRRlAQfy2GUi0yg/gSC/eyhC
	IScRF86EwZA8QepEPPtUoQGDdZn4E4gzAfkMFdTJel1J5+AkM/MYLEkvpCjPGLN7BdRwV/IDvXn
	vtJsRCHg3NElXdeYFtS6a7+j5+/mK4EMw7etntw8HClqeyCHLxYrgTslYccl3d4fgXhL+K9S
X-Google-Smtp-Source: AGHT+IEMGqdg7xAaFs0kezfOI2UIIHUMPeGEH7fNgj34+MnckZTdetwR2157erfMNen+R9kUElYeMw==
X-Received: by 2002:a17:902:f745:b0:215:7ced:9d66 with SMTP id d9443c01a7336-22c354b5f6cmr1181905ad.10.1744799101146;
        Wed, 16 Apr 2025 03:25:01 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6171sm1216834a91.2.2025.04.16.03.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:25:00 -0700 (PDT)
Date: Wed, 16 Apr 2025 10:24:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z_-FdLizyrz2_ovi@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
 <Z_7Fx-Q8baoyzJe2@google.com>
 <Z/7dqjiVdjnoZ+2w@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/7dqjiVdjnoZ+2w@Asurada-Nvidia>

On Tue, Apr 15, 2025 at 03:28:58PM -0700, Nicolin Chen wrote:
> On Tue, Apr 15, 2025 at 08:47:03PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Apr 14, 2025 at 02:26:19PM -0700, Nicolin Chen wrote:
> > > > On a system with vCMDQs, there are currently one standard SMMU
> > > > CMDQ and two vCMDQs, i.e. totally 3 cmdqs that could be picked
> > > > in this context. Perhaps SMMU might need a list of cmdqs that
> > > > any new allocated cmdq must be added to, so we can iterate all
> > > > the cmdqs in the list?
> > > 
> > > Another tricky thing: if a vcmdq is assigned to a guest VM, it
> > > won't be added to the "list" above. Should we wait for them or
> > > simply rely on VMM sending a suspend signal to all its VMs?
> > > 
> > 
> > Hmm... I haven't looked at the vCMDQ series (of the vIOMMU) yet but I'm
> > assuming that's what we're talking about here?
> > 
> > I'm not sure if sending a signal to the VMM would help if we have some
> > stalled transactions? I guess we'll need to somehow figure out if
> > there's some PCI device assigned that's using that vIOMMU/vCMDQ ? 
> 
> If all VMs go into suspend prior to the host machine and all
> guest-owned vcmdqs are ensured to be empty, we would be fine.
> 
> But this is difficult to tell, since a VMM might not signal
> a suspend to all guests VMs. And even if it does, not all the
> guest kernels might have implemented a suspend routine in the
> guest vcmdq driver draining all guest-owned vcmdqs.
> 

I skimmed through the vCMDQ series and I have some context now. (Btw,
nicely written cover letter :) )

The issue is that we may have dedicated CMDQs (like the Tegra vCMDQ)
assigned to the guest and we may not know what's their status..and the
whole point of this is to avoid VM_exits for cache invalidations..

Since we're mmap-ing an mmio region for passing it through to the guest,
I asssume the host has access to the prod/cons registers for the vCMDQ?
If yes, then we could have a notifier tell the host driver that a vCMDQ
has been assigned to a VM and the host driver could simply poll on those
indices till it's drained?

Also, this would mean that we'll have to take care if the Guest Kernel
ends up touching the mmio region while the SMMU is suspended?

Let me go through the entire series and the tegra-vcmdq driver once.. if
at all the Guest kernel ends up calling the host-kernel vCMDQ driver, in
that case I think we should be able to handle this well... otherwise
we'd need to disable power management for cases where vCMDQs are
assigned..

I'll just go through the vCMDQ series as well..

> > Maybe we can smartly flush only the PCIe ATC inv and pri resp commands?
> 
> Yes, I suspect the host driver will have to do something like
> that for the reason that I mentioned.
> 
> Thanks
> Nicolin

Thanks
Praan
