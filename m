Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96BB27145F
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767382605; cv=none; b=MOcx55Cu5zNh25fzHXHjVQxF263X8z/Vx2UcxOQiWx03A9aP7V9ePiSJSohr+eE9NPA9kVznxitL9TIGd0N8fZGNk+TyLpHrYoQNBSalggPhs3oquh0ivCcgNrzGYsF0IIeL0x5xwb9g5SoroMHJUjQTPns/aAZB8aUD5hTRl50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767382605; c=relaxed/simple;
	bh=S7xBrxw6PAq9JT4DAcabRoijg9yUSwH4F7wpviulOwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs5dQb5EKXWzSh18BUWuQgT/joKNJxl/w4A3gQG6ZJsSBAbnorKvFoKfyiz60pY7oSbzcpqN/YA9AY3HtJ/re5Jzeszt75hTU1S1dzyY727ZfuNwYaF3YyW4Inydeh9/KZ9oybHbgPToAEqe2wyt6YwMZ6jZBWDDuFeNgqX15XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zj1ilR+c; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zj1ilR+c"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c24f867b75so482293785a.2
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 11:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767382601; x=1767987401; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GyxeyUuUNajnc3zJOlyDv0WvsNhoQVpXnpgGVnl/NOA=;
        b=Zj1ilR+c6c4jMibI2oXiTH9gSzOPzjblfGdGw4Ko88Y/K6IUThnog1tUvMAetZuZ6P
         LUdG2IFzX2pOsx3UPP3vIzpsL5UCUaKGB9x6gCrvDF074UBNOIUewgjpmeUNLRg9P0Ba
         GqUBU4+TRLqR0QZdmgA91b7SLBmCa4pmbe3BmB3g+wu2u4KNb0L7lfhV147drWO115nY
         qSlSKzr9TnuxVPo90UaSm5tsaq+1r7HC3DpDteoOEVqEqN2DCdiEntImyad8YT4aN44j
         nlPa0mRBZiBAmRXQOHVkArBs5xUVLDDHiWGNVm8R3hoRMq/UW4Sr+ZlZFNK7UXfntCzz
         wrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382601; x=1767987401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyxeyUuUNajnc3zJOlyDv0WvsNhoQVpXnpgGVnl/NOA=;
        b=UFBflGfd7wV29b3myT2uEfak5HbC2CdCvTk8pjsdcb3KcDw+X1QJYTp+cylhItMdkP
         57AP/LVc0JcNtUQMj9cltbPUCUZYdkBCETT9v+wgv+h4CpSWg8ODPsM1wPHXcUFqF0sl
         +uH3so9ATcUEVEyod/yqOX8gzU2a3ImTSm/YuMvPniRCOOedgG2H6kCF283tztR5mQyR
         T6aPdhHPbSNA0gH7YSEEoOomOOfHrVx0aPJ3HXAnPCCtdhaQjeB91863E1X+Us9yA4Uk
         Wjy+as4PsWejOpataBKGC/V61Nm5KsnJNv9dwL3Xyly4WLNNLuBTHLdPUQT2aZUYQRpM
         isXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+TssyWAqSCedB1a1QFKRaU7zeUHKZMWGpUc2GIHaWhoi9bfkBIvl21eh98na1cmMthMq4UA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq2JR6bKAAjM4F2TF6sxVAVmkdfR7bRkrGHBG6Q2GwoauhQYPr
	iL3QRij4cOvsxrRl8P1x2C8v1sHCQ9kZ0udiVygaJZfs6z3ecO7WsCPI9VNt2diaJVY=
X-Gm-Gg: AY/fxX51dbaSI64bElkWT8qj3ciEpdS2qFA8Uw4/S6xetcm6TxtcezbTdck1ctcji2d
	+IdEiUFZqaRpQMQ3ocOKJdoYNd/bnFseQM5NQgQTl4qjB9oUTL36SMboXQOzG/XLDz6aC5Q2P6Y
	hFg5BXOFb6aawEzk1BykdVKy9qPna8wBiXn9oEgVUhqTL/mWvlYXk8yedsXjbbyouY7pbLuest1
	7RVpYQazSIKwYjmmQLP5eYfMD2VUa5RrjIs38IRErqH3RcerrL3v1GrBTBkw6SrJmzxkVOMfpK6
	44Q9Qd685vEjASrMc50HgAMK63KP2D8s2P2vcAVnUCn53M/hgGmUbA+oQQ1tGHYX1Yi3m1cK1Rq
	Vdro/kDWYmDimNe1pMxqv86k3n9k12cP0shkai357MBGBexD1d4PsMwGoJsyf6unCfNSEhTdKCR
	AOthGkt+c4ZV14JoK3yE6gqFyAvdxolAEK0X+yt6vSGjfi4tZZyWUIoUy45HhMtVF6/YbNPHRmw
	JXpzg==
X-Google-Smtp-Source: AGHT+IEVRW8SRr0/+EA+FBx4hyl3IYlD4yKjGYpIKlWnEFf3x2j/o3tABg0ljBozlOxqvraqax+FMw==
X-Received: by 2002:a05:622a:5985:b0:4ec:f791:738f with SMTP id d75a77b69052e-4f4abd753b4mr612505561cf.49.1767382601412;
        Fri, 02 Jan 2026 11:36:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ad519939sm304877161cf.2.2026.01.02.11.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:36:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vbkwx-00000000oWI-3K6q;
	Fri, 02 Jan 2026 15:36:39 -0400
Date: Fri, 2 Jan 2026 15:36:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: fix selftest link dependency on amdv1 driver
Message-ID: <20260102193639.GB125261@ziepe.ca>
References: <20251223215127.603969-1-arnd@kernel.org>
 <aUtHZ1KHTJjW7SPP@ziepe.ca>
 <beb85629-4912-4279-b025-a7debd1dfc6a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb85629-4912-4279-b025-a7debd1dfc6a@app.fastmail.com>

On Wed, Dec 24, 2025 at 11:17:13AM +0100, Arnd Bergmann wrote:
> On Wed, Dec 24, 2025, at 02:52, Jason Gunthorpe wrote:
> > On Tue, Dec 23, 2025 at 10:51:22PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> When CONFIG_AMD_IOMMU is disabled, the selftest runs into a link failure:
> >> 
> >> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o: in function `mock_domain_alloc_pgtable.isra.0':
> >> selftest.c:(.text+0x1590): undefined reference to `pt_iommu_amdv1_init'
> >> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x280): undefined reference to `pt_iommu_amdv1_map_pages'
> >> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x288): undefined reference to `pt_iommu_amdv1_unmap_pages'
> >> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x2b0): undefined reference to `pt_iommu_amdv1_iova_to_phys'
> >> aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x2d8): undefined reference to `pt_iommu_amdv1_read_and_clear_dirty'
> >> 
> >> Change the top-level function to skip all the amdv1 tests in this
> >> configuration.
> >
> > kconfig shouldn't let this build happen:
> >
> > config IOMMUFD_TEST
> >         bool "IOMMU Userspace API Test support"
> >         depends on DEBUG_KERNEL
> >         depends on FAULT_INJECTION
> >         depends on RUNTIME_TESTING_MENU
> >         depends on IOMMU_PT_AMDV1
> >         select IOMMUFD_DRIVER
> >
> > I think this is more fall out from Geert's change to make GENERIC_PT 
> > unselectable, the 'depends on' is no longer enough??
> >
> > I guess the right fix is to add a "select GENERIC_PT" above, does that
> > work for you?
> 
> No, it's already set.
> 
> The configuration that had the build failure contains
> 
> CONFIG_ARM64=y
> # CONFIG_AMD_IOMMU is not set
> CONFIG_GENERIC_PT=y
> CONFIG_IOMMU_PT=m
> CONFIG_IOMMU_PT_AMDV1=m
> CONFIG_IOMMUFD=y
> CONFIG_IOMMUFD_TEST=y
> 
> I suspect this is because IOMMUFD_TEST is 'bool' and can be enabled
> even when its dependencies are =m, but if the test code is built-in,
> it can't actually link.

Okay, that makes more sense..

> This should be fixable using
> 
>        depends on IOMMU_PT_AMDV1=y || IOMMUFD=IOMMU_PT_AMDV1

This is probably the best option, can you check it with the
problematic .config?

> or by forcing the iommufd code to be a loadable module when
> IOMMU_PT_AMDV=m, e.g. through
> 
> config IOMMUFD
>       depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1 || !RUNTIME_TESTING_MENU

Because we don't want this restriction for production builds..

> A cleaner approach might be to split out IOMMUFD_TEST into a separate
> module rather than including it inside of the IOMMUFD module,
> but that is likely much more work.

I think there are cross calls that would make that difficult :\

Jason
