Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202B3B4EA5
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188820; cv=none; b=r2JJ3NJt7oWKFHGxTC695zoX2o++u21N4Kf0ZixniXMTRemUSkLIEt0c4kiH/xK0G0xcB5XmlDsH+R/Ld/Sy53dkMNbfCdktgBfEQLp36+tn+p6IeYwbVmskksMz/zt0YCLQcDlqdfWr4GQLIm3tMapmKbGH75V/iKxD1zfOyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188820; c=relaxed/simple;
	bh=bLHvC6K9JqJ0RlgA15nPRG2hHu4cpHRoKhj+9AVrCoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Frv8vtBM7PTUIo2G6mYXNfYx5aU1ByCkR1rrz4oumCJktICJcz+aGBHkFY1g0Myku+Y8hJlhb/FRW8G5pSvLuY2GgW3mbD/MzbPmMrc0dEV8UznnsqoIssQ4PBYgji/+bSZ3MnAEkNdaG53UT6t/a1oWrrh9h6ryBaggZubhGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TslOQH34; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TslOQH34"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so335e9.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779188817; x=1779793617; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gqrcVfnO7KvHz04L9yl4e6Ci0L4LjlQK4/aWUr5steg=;
        b=TslOQH3462506C3lEf4WNnePiB773er43vyeWVfS7cRL7P/hXO60gf2R3VHQra+hHS
         ie/DcGutSWVdL5fg2F3AHzcmm6GAYfoCoq00We+mOptO89I8F01mwR3mb0ZmSk8MN3t4
         KFPYjMQLoKk+uJFdaRkQsDJovNWNijL0dHNL1oJVn/9CqMkKy7TdwH0eBHdI/MO01S+K
         0gNMC9bOvHWenT9j+HfantcPQsi8ck9azCP0LvfGR6IzFIUMjy/QK1ZH38Q/FjLoywSV
         f5b0cAXY18QrFpn4N38R898XvhU2Ah0ThT28PZ7PoAB7oePGhkjTjbgRSPS7KYdUuZ48
         z6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188817; x=1779793617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqrcVfnO7KvHz04L9yl4e6Ci0L4LjlQK4/aWUr5steg=;
        b=el0UsADKAv+CYxnWYEe/V7m6GNvxj0cvImBu4Wj8T+xfMKvWbUdnIFBIC2qFSTgK81
         JlBos9Zhwf8+MFjLxCpJgVrlOPxLWDsEQO7Mp3yI+fdv8VUz4SZwIB1gtKzeEx0/pYPo
         QEHt0LnIzN7HpWZXGbQ2Pzrc0AduIVIEbPvhW05w3iiX9jjZyaQp7nw+Ew0eTaq86+Am
         LthiwXvJk4RK4OqTWBKece6nQB+vgIMaoSMx8qvj9DKqEJ3rj7OhJqLgSlpgn0YCbBBQ
         UADqigYv/HeJf+kg6BfQMjsq1hbah8Lj1AMFSjkwfK86pLthxbNsN0OMsX/5VUjy9s+N
         n0Ww==
X-Forwarded-Encrypted: i=1; AFNElJ/TD6VmdYmFEYUdbO7Yv44q75idgFHavOyrSMbKjdNB+oT/XMGDvQlD+SNbXSnoBTMyY6NSPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd57sKG1o08RwMDEXUcYGxdYYRr95tpRhYDdQO8JYVFBL28hF9
	BlGWYIMut6vs8hYo67/iDyVTkX2z/XbWXLqngxeci97NoHpGoGecIi54ZLyiQycjfQ==
X-Gm-Gg: Acq92OGiqZomgvLC+pqyLmBv3t0TCBUcwvXd+uLro4WnmE+YKhn8NugQczQvIEsJHmZ
	Y6ya8mW7WHEUZgfI3esJarq/UmcBVSsnhxYHWh2uz8pJe104X7XUKXXKihQ/NxpXOJtuV19P1B/
	SpXNEQR1fRkKShukPGBE3bjZ4rWl/TrT0KnnaoCP4sfKSDyLEOrUY3QZq+76+uHUiMrZipnOeM8
	G6MwXjRLiFctTRJP/vt6HiyR4cq13KCkXavxmUHtbuan+CPN+Bs9d3Oq78U8EkStVXDPbAD0o2i
	Le/SWCvyK4yGrqNrXy56pGDUxK1kw07SL9QG3SzyCc33PFrDADjDHZ9G/ZGJ5tK90t32ybTiONt
	ac6sdt0B7Rv3w4LGP0HD9PRTyy0ic+CaLoZKJS1V96QsJyohjV74P3n8U3cuAf/nh8P9NwKtmMf
	lFKopR0b2EHuVtsIv3//z7g7A4BLXSk5Af//juozL+8IYenIi2XYSNPlLTPU50jsLnz8/U4lcpO
	GggIpbNunMECw==
X-Received: by 2002:a05:600c:418b:b0:488:960f:60b8 with SMTP id 5b1f17b1804b1-48ffa5e1272mr2275185e9.6.1779188816592;
        Tue, 19 May 2026 04:06:56 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53767ecsm288995945e9.10.2026.05.19.04.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:06:55 -0700 (PDT)
Date: Tue, 19 May 2026 11:06:52 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxETC1rXBUSkWYg@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
 <20260514123529.GZ7702@ziepe.ca>
 <agXfm3mS_M3fvRrN@google.com>
 <20260515225113.GN7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515225113.GN7702@ziepe.ca>

On Fri, May 15, 2026 at 07:51:13PM -0300, Jason Gunthorpe wrote:
> On Thu, May 14, 2026 at 02:43:39PM +0000, Mostafa Saleh wrote:
> > > That's a somewhat different problem, we have the dev->trusted stuff
> > > that is supposed to deal with this kind of security. We need it for
> > > IOMMU based systems too, eg hot plug thunderbolt should have it.
> > 
> > I see that it is used only for dma-iommu and for PCI devices.
> > However, I think that should be a problem with other CCA solutions
> > with emulated devices as they are untrusted. As I'd expect they
> > would have virtio devices.
> 
> Yes, any security solution with an out of TCB device should be using either
> memory encryption so the kernel already bounces or this trusted stuff
> and a force strict dma-iommu so the dma layer is careful.
> 
> This is more policy from userspace what devices they want in or out of
> their TCB. Like you make accept the device into T=1 but then still
> want to keep it out of your TCB with the vIOMMU, I can see good
> arguments for something like that.
> 
> > > > While we can debate the aesthetics of the setup , this is
> > > > the exisitng behaviour for Linux, which existed for years
> > > > and pKVM relies on and is used extensively.
> > > > And, this patch alters that long-standing logic and introduces
> > > > a functional regression.
> > > 
> > > Yeah, Aneesh needs to do something here, I'm pointing out it is
> > > entirely seperate thing from the CC path we are working on which is
> > > decoupling CC from reylying on force swiotlb.
> > 
> > I am looking into converting pKVM to use the CC stuff, I replied with
> > a patch to Aneesh in this thread. However, I need to do more testing
> > and make sure there are not any unwanted consequences.
> 
> Yeah, it is a nice patch and I think it will help reduce the
> complexity if it aligns to CCA type stuff.
> 
> > > In a pkvm world it should be the same, the S2 table for the SMMU will
> > > control what the device can access, and if the SMMU points to a
> > > "private" or "shared" page is not something the device needs to know
> > > or care about.
> > 
> > I see that's because dma-iommu chooses the attrs for iommu_map().
> 
> Long term the DMA API path through the dma-iommu will pass the
> ATTR_CC_SHARED through to iommu_map so when the arch requires a
> different IOPTE it can construct it.
> 
> > In pKVM, dma_addr_t and IOPTE are the same for private and shared,
> > so nothing differs in that case.
> 
> Yes, so you don't have to worry.
> 
> > We don’t expect pass-through devices to interact with shared
> > memory (T=0) at the moment.
> > However, I can see use cases for that, where the host and the guest
> > collaborate with device passthrough and require zero copy.
> 
> Once you add the CC patch it becomes immediately possible though
> because the user can allocate a CC shared DMA HEAP and feed that all
> over the place.
> 
> > One other interesting case for device-passthrough is non-coherent
> > devices which then require private pools for bouncing.
> 
> Why does shared/private matter for bouncing? Why do you need to bounce
> at all? Do cmo's not work in pkvm guests?

At the moment, in iommu_dma_map_phys(), if a non coherent device
tries to map an unaligned address or size it will be bounced.
In pKVM, dma-iommu is used for assigned devices which operate on
private memory, so bouncing that through the SWIOTLB would leak
information from the guest as the SWIOTLB is decrypted.
In that case, the device needs a pool which remains private.

Thanks,
Mostafa

> 
> Jason
