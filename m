Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEEF3FBEBC
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017792; cv=none; b=E0/G0wTtml7dRRuqBVtmPQZVmUVVQUfbqaSKnT8zWqViQf2Q0z25ZhZoyyE/SSxT+SiFJeH48ryPde/fDHBDROQxHKX4N6+XkpmfiVRi3N5eJTlIMh7HJmzwJ5Q1olpf3GsweNHs3xetXpH7uxsTb9o4l8kZd6r4BwltfkrtTZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017792; c=relaxed/simple;
	bh=ocFVzAC3/f6XF2JEGGnEYrZo88e1CemFP3AD9C04FJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDBC60+yhmzHsYTfOkI2y1SdoqoM9Bto/JCyuiTE5wvoO+gtBwTEzYZYh/f7JjNk2aCrbJxhhdCa+1O9VUf67NZ58QxwB8Iqlks48hh5MObWxwnX9Xkmbi9Y0jB4/gxQ6r4JXbpVG+1Uim42Rgzm+jPGV30WydPYI7I2J0HvDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKu32v6N; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKu32v6N"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c556ada3so42575e9.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 01:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784017784; x=1784622584; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h1XR0xXH676IkskJiy7lkXwYtMlnQ7GpPOPMnybj7LE=;
        b=gKu32v6NczZSO/Xlev2CdlQk0tzGSwTqzjhqUWw+L6lJaVzrPdkmSNc92TkJPrIHDt
         yVrPc/s8PGmFOj8w6O17dfNi1UUy+xLZOerJJbTZI5/W1+98CuNXUVraoAOOQDy4Ic/O
         a2D2kqFYssJwfZsJjREXiXRM2CwKHxrGdTZtXZ/u7xkwv9ych0psnDR2BuKC0l6d62K9
         uBWyiksRSmAKHJxhG9DxT4kCY8DyNVPa4FACc2IoWNSEs12ib1PMB7QF+b5ijeYQVOxb
         P1Mdo2o0piTNk3OQKfBrSN3huuZ5Cz26bqO1di0wtCL/p8SB7bnGIDRnSNkq3j+2bOia
         7kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784017784; x=1784622584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h1XR0xXH676IkskJiy7lkXwYtMlnQ7GpPOPMnybj7LE=;
        b=o8FjPKaU4W9j9nNSOSyD7XsiRR5C5CbZRoLIJY9A0YYAulqtYH/Eac7fipqq25KraU
         XI0kb6PZK3AojS7EO140FGCaWR95XzWsBb2Mh5y2SFdVYWR0z2IeH2tXJkwau1Hs+9MD
         fo+qD3zEOSAWXhw0lJiRpzqL6X8hvF+ad2M03aZnFP63vJXOYLR4dWe18SkD76o8WM/6
         LAVH06owR1dRBinaFpyyvdiz607wmlc5j5IiEMU237RH/dq80Yd2u0LHEbKv6X1jK8ZD
         jLRTdDgCwLNt+YE0wLWsbCBp48QBr81rZCi2nT3xYprwQfLKzoJb8j4R0c64Zznz6M0n
         WOSg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8SmAW0xc+tfl7L1sNP1z4RcnnaHILY5Aa1FWPZCY0F8w17SuubM9dD6W9s2/g6Zohdq03vg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgppCFmBDrcHD+qI3kfX7ldb4Gdj24YoVW2ZMxbrcVjTcGE/Vn
	41XQKgMaqofxGQUe/fLLKR9OC/RA+rRSEheJPn8uvzw7UhnhyH12cVyt2xSJx+R/pg==
X-Gm-Gg: AfdE7cmkUjFrdTGiLpyhpmHkzqXOfIL2A0KAXLqwlerpzPQMcUB5nR9AFH8/5gYiSCw
	VECUXjG1J38587sptcDK1ZQvKaqh4T7tbwEUKzV6Lo4g/RdAdPZvIJXbCqlAkbhA2V/EilNDwCd
	m/sBv0k4Dshst7a5z/GPuorBsTTsSNE4nWLVS5sYsvtG9k5f3ZpJs6jZUegZbm4zAFlcSyKiL07
	Z1qs+b5SnkAvaRNaKbMxEQDCKQGUia04jexMJWY5F9aNhpLwopxDLSgr7INlt6hGKAqzfRhqEnS
	DjeLl7ovKLKcyrNwpOVHrW/MDY7Ikc7fcj0FjZu2YB4Ys3mgcLeCgH12GcFl/aCnecK5p/rd4+s
	pY2TUBMKJ0F5L4ORT5Y5gk4nfuhcyas4hBRrYZcAXUtkBPJ1w0OtQawCl4H639iP4JuV8zPiHhA
	ofhXMCtqv8Ytn8VT/WDTZF+T+OFlyHwzwaKWCWjHaOz1Yw8myE
X-Received: by 2002:a05:600c:621b:b0:493:b169:784d with SMTP id 5b1f17b1804b1-49462165300mr1774335e9.8.1784017783083;
        Tue, 14 Jul 2026 01:29:43 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm6301185f8f.35.2026.07.14.01.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:29:42 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:29:38 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <alXzcrnxWADIEL2H@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <alTnAy7jvjUamwUA@google.com>
 <alTvf7iiOWn4PKE8@google.com>
 <alUA7zsJO1FGnss-@google.com>
 <alUJa5cbjjqZ8n72@google.com>
 <alUMVU7DYcrvgAYi@google.com>
 <alUsLFBQ5qKFOgwQ@google.com>
 <alXwXRGqECTUZ3ou@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alXwXRGqECTUZ3ou@google.com>

On Tue, Jul 14, 2026 at 09:16:29AM +0100, Vincent Donnefort wrote:
> On Mon, Jul 13, 2026 at 06:19:24PM +0000, Mostafa Saleh wrote:
> > 
> > That would walk the table twice, first time with a massive map, then
> > to unmap the pages that was just mapped, issuing TLB invalidations
> > for all of those, also as the IOMMU page table code never frees tables
> > that means we would immediately exahust the IOMMU pool.
> 
> Well the massive map is pretty quick we would mostly just allocate the PGD? And
> then it would be just for the subsequent unmaps to split the blocks. So nothing
> to be freed really and no risk to exhaust the pool. But if you put the calls to
> the host_stage2_* functions that's pretty transparent.

Not for the IOMMU, everything is mapped with a leaf mapping, because
the pgtable code does not support splitting blocks, this is something
I plan to add support for in a follow up series after this one is
merged along side other optimizations.

> 
> Just to make sure I am clear. Here's what it could look like:
> 
> in iommu.c:
> 
> int kvm_iommu_stage2_idmap_init(struct kvm_s2_mmu *host_mmu)
> {
> 	u64 addr = 0;
> 
> 	for (i = 0; i < hyp_memblock_nr; i++) { 
> 		kvm_iommu_stage2_idmap(addr, reg->start, IOMMU_MMIO);
> 
> 		addr = reg->start + reg->size;
> 		kvm_iommu_stage2_idmap(reg->start, addr, IOMMU_READ | IOMMU_WRITE);
> 	}
> 
> 	kvm_iommu_stage2_idmap(addr, kvm_phys_size(host_mmu), IOMMU_MMIO);
> }
> 
> in mem_protect.c:
> 
> int kvm_host_prepare_stage2(void *pgt_pool_base)
> {
> 	...
> 
> 	return kvm_iommu_stage2_idmap_init(mmu);
> 
> 	/* 
> 	 * From here, all the changes to the host stage-2 will be reported to
> 	 * the iommu driver
> 	 */
> }
> 
> On the pro side: no custom walker and we really couple the iommu idmap to the
> host stage-2 map.
> 
> On the con side: As you've pointed out, we'd need indeed the iommu to be ready
> early enough.
> 
> If you want to stick to the snapshot function, could we have the walker to
> first walk the hyp_memblock? the .arg could just pass if we are walking a MMIO
> region? That would avoid that find_mem_range_from() and I believe would
> massively simplify the snapshot walker.
> 

I see, let me try that.


Unrelated to this, but while looking into option#2 I see that
__pkvm_guest_share_host() does not call either of the
host_stage2_set_owner* so that requires another explicit
pkvm_iommu_host_stage2_idmap() call.

I still plan to use option#2 in v7.

Thanks,
Mostafa

