Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53562FF654
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143678; cv=none; b=Oewx9y8oXHtsQgmoU1GDNPNCSPAr5Vd7qu0hbjkDQa8SEwkGXtR+z4brjHpLdiwm3tocV0X5sD9bVHoXNgjorhE5ZnGm7FQ8QnVRdFcOVnrgaBtch/Uvc+TidcQKQ/Fa8bxf2a8tI0ZTgZ0WWy0B+tuJsX3+9wSvwH3ok+0ts0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143678; c=relaxed/simple;
	bh=pY5ptJQJD5hC5Yld/qr6VRXciRKFgD9s0GcbegbNqCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFEj+bRwSPaKlGoW49jvqWPLy7hwB6nEhOUfPT6JP/0TXX28yJpGPAM+Q+NA93eW58ahTL4uyMu7Lj5lv0ARsc0/iMC0CtQh8HqNRI5wmeKyTfo9Pg4bL1FZBt1MtxPhf+2jyv5PNZzT2Fl14AWhv2bxR6mQfeJM0m7pPqVB9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wd8oHkrE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wd8oHkrE"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e32c0e273so101325e9.1
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759143675; x=1759748475; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rg8kwxsOK3RvjQ0Oy8bn6on+o39qQD/CbdbTzAEerLQ=;
        b=wd8oHkrEdkuW7yBbGQDGONoM9QAPg8E08QhNKGr6nz5dZ01YyzqAR2pPfMdtLCXAYT
         BYP7FCGHy3aXZs6vGjiA5djyjCugWg2N6+zW3XhvoHlpNsEl+eJOxjx5TVfNQuk+CuBR
         te87f0xyst82QzCtyjjycPNpN2OXx7eF0UeTAZQcQe45hhuxY3DuqkCRwASYZLc58Xmd
         lN/4l12O/HJJBwhWT6RNMt87prBqTLCXl8HRWjfvpnUrjOS/C47rO1AH3ws0UOp0GVnb
         bGc17NkCdsPKuGNywhF0xBxbwRP2/lLOQscvL1MIrLAzGICtSLW2cFScTgbo6hKWgYUz
         wJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143675; x=1759748475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg8kwxsOK3RvjQ0Oy8bn6on+o39qQD/CbdbTzAEerLQ=;
        b=D+G3S1OZUiSNb7ZUCMA6SocedhHJQ7lcgEEPsj353d19bY0GSwPF0jZ3MxF8Cyyy+l
         kl65vxITMDLX/wtR5KjLSaDu6HCKxLl6CgdRv49T1OG+X4pZZgz9AcVb7l3iBOAnLebF
         WxrQ7xRPX8FLU9XHwSWdrRRntipq4NqHOfyedHdkndXVz0PFUDo8HD76iXP7XfXtjGqv
         G+eGkU6RR5oHePFTLOpRY1vjDwRX5+op5PE/AX3ZI0/nJTJ5tqZPizpOnicVyeMgEEOc
         vWfdvWsEFi2MOMxA3auuopozGjZ5E5kPIBa2aGgpnh9fXn4XCmYCRp1LikRF5N/eu58I
         RClA==
X-Forwarded-Encrypted: i=1; AJvYcCXqr67gA3yhPpdIBV//iMO/gd2JqD+Rh3u2b0yAt47aHgHzDByHJfuRJuPY84Vqmbxtxk1uzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkC9PpA+p21VFFFH0nqETS9LOHewTEiLXpPrqi8O+06zaQ+1vp
	eHggLhGXdTpM/Orl3Wg83kDjPTMT/2+KdvPgEgJYQinGB293M9bdcW7DDTBsmGXaF61GfrXZ3JL
	tEszvYg==
X-Gm-Gg: ASbGnctScO7MnlcEDl32BT6fuJkqRULrOwAU4EMxSSBqkZnQWmVJaQlX1QmFsHeiOYP
	L4dKx3OxIgT9NNLos7N0iKKi0j63UGE0vEOGb0VrSvkBIZeruw6k+E4i9/Ah4MDxOxU9msa6gHI
	0bmUol1LJAw8hgPs579nETWPIPqoA4I9essY/gsbKAkq1TuKicx5/0rGKnCgxO6TVDX4nEKQZ/8
	VBZcj2ITOqLQ4kUaOwUnic7RgJLVeUKV3Ici3oFKgZCQr/axG6ffljmsH5TaRwQ43BY7XHMzJoc
	ZerR3firz1LsN/kIgo24/5LilbAW/HzPUZSY8l6y+hbGdOuFsSggxy+i8M9OKEvXlJXclK0CGxr
	F6dby+XOjoPRjkYeeAV/gOV/DHxl/cNqXlG9uiGHFcS7z2a0/8yo6Odfc+H9MrY6KnYQ=
X-Google-Smtp-Source: AGHT+IFg+hCsYGMP/Ez1tXXALpy4mbn6kahyoJaMM4qeV/gbtw19iOEwbJlDUZ+YOlPn2J+hesMSFw==
X-Received: by 2002:a05:600c:a31b:b0:45d:f51c:193 with SMTP id 5b1f17b1804b1-46e575a116emr243565e9.7.1759143674689;
        Mon, 29 Sep 2025 04:01:14 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e4ab0bf62sm70168175e9.9.2025.09.29.04.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:01:13 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:01:10 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 10/28] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <aNpm9odmzv__2RyA@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-11-smostafa@google.com>
 <aMA8vz0v0Vn-02QP@willie-the-truck>
 <aMlzLsj5slPQhWEr@google.com>
 <aNamXlTErXDs1K8Z@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNamXlTErXDs1K8Z@willie-the-truck>

On Fri, Sep 26, 2025 at 03:42:38PM +0100, Will Deacon wrote:
> On Tue, Sep 16, 2025 at 02:24:46PM +0000, Mostafa Saleh wrote:
> > On Tue, Sep 09, 2025 at 03:42:07PM +0100, Will Deacon wrote:
> > > On Tue, Aug 19, 2025 at 09:51:38PM +0000, Mostafa Saleh wrote:
> > > > diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > > > index a01c036c55be..f7d1c8feb358 100644
> > > > --- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > > > +++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > > > @@ -4,15 +4,94 @@
> > > >   *
> > > >   * Copyright (C) 2022 Linaro Ltd.
> > > >   */
> > > > +#include <linux/iommu.h>
> > > > +
> > > >  #include <nvhe/iommu.h>
> > > > +#include <nvhe/mem_protect.h>
> > > > +#include <nvhe/spinlock.h>
> > > >  
> > > >  /* Only one set of ops supported */
> > > >  struct kvm_iommu_ops *kvm_iommu_ops;
> > > >  
> > > > +/* Protected by host_mmu.lock */
> > > > +static bool kvm_idmap_initialized;
> > > > +
> > > > +static inline int pkvm_to_iommu_prot(enum kvm_pgtable_prot prot)
> > > > +{
> > > > +	int iommu_prot = 0;
> > > > +
> > > > +	if (prot & KVM_PGTABLE_PROT_R)
> > > > +		iommu_prot |= IOMMU_READ;
> > > > +	if (prot & KVM_PGTABLE_PROT_W)
> > > > +		iommu_prot |= IOMMU_WRITE;
> > > > +	if (prot == PKVM_HOST_MMIO_PROT)
> > > > +		iommu_prot |= IOMMU_MMIO;
> > > 
> > > This looks a little odd to me.
> > > 
> > > On the CPU side, the only different between PKVM_HOST_MEM_PROT and
> > > PKVM_HOST_MMIO_PROT is that the former has execute permission. Both are
> > > mapped as cacheable at stage-2 because it's the job of the host to set
> > > the more restrictive memory type at stage-1.
> > > 
> > > Carrying that over to the SMMU would suggest that we don't care about
> > > IOMMU_MMIO at stage-2 at all, so why do we need to set it here?
> > 
> > Unlike the CPU, the host can set the SMMU to bypass, in that case the
> > hypervisor will attach its stage-2 with no stage-1 configured. So,
> > stage-2 must have the correct attrs for MMIO.
> 
> I'm not sure about that.
> 
> If the SMMU is in stage-1 bypass, we still have the incoming memory
> attributes from the transaction (modulo MTCFG which we shouldn't be
> setting) and they should combine with the stage-2 attributes in roughly
> the same way as the CPU, no?

Makes sense, we can remove that for now and map all stage-2 with
IOMMU_CACHE. However, that might not be true for other IOMMUs,
as they might not combine attributes as SMMUv3 stage-2, but we
can ignore that for now. I will update the logic in v5.

Thanks,
Mostafa

> 
> > > > +static int __snapshot_host_stage2(const struct kvm_pgtable_visit_ctx *ctx,
> > > > +				  enum kvm_pgtable_walk_flags visit)
> > > > +{
> > > > +	u64 start = ctx->addr;
> > > > +	kvm_pte_t pte = *ctx->ptep;
> > > > +	u32 level = ctx->level;
> > > > +	u64 end = start + kvm_granule_size(level);
> > > > +	int prot =  IOMMU_READ | IOMMU_WRITE;
> > > > +
> > > > +	/* Keep unmapped. */
> > > > +	if (pte && !kvm_pte_valid(pte))
> > > > +		return 0;
> > > > +
> > > > +	if (kvm_pte_valid(pte))
> > > > +		prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte));
> > > > +	else if (!addr_is_memory(start))
> > > > +		prot |= IOMMU_MMIO;
> > > 
> > > Why do we need to map MMIO regions pro-actively here? I'd have thought
> > > we could just do:
> > > 
> > > 	if (!kvm_pte_valid(pte))
> > > 		return 0;
> > > 
> > > 	prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte);
> > > 	kvm_iommu_ops->host_stage2_idmap(start, end, prot);
> > > 	return 0;
> > > 
> > > but I think that IOMMU_MMIO is throwing me again...
> > 
> > We have to map everything pro-actively as we don’t handle page faults
> > in the SMMUv3 driver.
> > This would be a future work where the CPU stage-2 page table is shared with
> > the SMMUv3.
> 
> Ah yes, I'd forgotten about that.
> 
> Thanks,
> 
> Will
