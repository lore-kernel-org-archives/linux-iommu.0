Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC5429827
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949069; cv=none; b=Dqj8OVxP4EXygozkqudhKBuuGHUcxdxepHUa1tgqTRphw8Ys+szld06KZyEIY2wsZTU1zq2GrEHfaAJsrlvPtePNkm0mdoZq5Pt6uZfJol8MdyQZg2KBBj5eHn1HzgcFnsyIc57HFDXK45WXaSoocqw7DhpQVxDO/HoP0ffs1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949069; c=relaxed/simple;
	bh=OGTaZIw8xsC9mmZcxQGK3hmSHJDE7QOCAIzCpZffmpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUNX4jsNzfb6Ad5vYvwQZbIM+ah9TEU6hNZAPZeJC+wWFA+44jQ0Nof92ffGoNaz+ZpmFlYDZZPMnJsOITANch6hpcXk6MirfKW93GhwvdDnxwJ2o84gkfdWmPtW8LEe3tMGnPLEJAgtjoI0cz35nv9ccoiQOFFFTKVfxRHs3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mfpf11Q3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mfpf11Q3"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493f6de72faso12611575e9.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783949064; x=1784553864; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FPb9nw2DjjX5vlFuty7FNZD2YGQlvsv+r37tv8hIR3A=;
        b=Mfpf11Q39vmcQSI4/GYrt2XF+HjkRR3te3i1c5laDsUkbThiLUY6HIbkVFLj2Euhn0
         rCJLduzjfAdK5ljNJiPIfjGi02W0yo2VXko1kdpKKBMPNjdL9cWgMJ/aWP0KYp9kI0J8
         8+e3Ab1vFOjvbH11jUTvyx4S938CrCZed39V+7um3r7KfoQLDuJP5oBK/wZvfLft7JH7
         h02joCEkkwPoJa86CWNRAlsqcHsB2amlbQbcxWuBvW6s3I1CIJ1Ha5+UOGaUUftKccZg
         43n92i2lyxaJEDw/5bOMDtg5d0r8dgI05nOA38eEbWavoy54eBI+Q45+qWINjyEObwC0
         NFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783949064; x=1784553864;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPb9nw2DjjX5vlFuty7FNZD2YGQlvsv+r37tv8hIR3A=;
        b=kIKz0QujMdXrqiJ/SHQspqgYduPhQs4mDH90GRdseh3ajdBIfOohdjqg2ChJL7e2by
         69CgEXMrF150uy+nS3tCirYE0aMJ6RT1IHQsZGLGY0v7lEmdMbH8pcZ7OxpkRLkTOIpJ
         +qxkOIhoT4jyymkZ0iSSObkEMHEfA2msnXv5/JmXZy8CL1WEBCAazqBHUy8R+0RR7TWb
         FaYP2qPt7dSCsZpL3p8PCLjRyhcpZ3j5bdyU7D+1UZzPFGf/3nxUwhCukZTSjsSFsokC
         2K/QDtnmFRfY+2ylM1r2/VUpnlALiL3x01DHbzBCJSIrKAqJaeVmNXVbkkP1UAVEV5w9
         jHug==
X-Forwarded-Encrypted: i=1; AHgh+RoDyHp4JUbjFdhZJRQjSFfBlM6SRgvMYzCpTKg/PFe9bT0bAGgvGa2BBwDHkVvUXHs+/THkTA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1KDAkIDW1m1ZhMN5eZtqPoOxEDZFDmnJA6vQrm90x78e7IYll
	g+WsXniV5f9JZkWNF9old8gBlWRoR2x4JXkBm6TDeAyKBGfrlykkERKIxZUw4s4khQ==
X-Gm-Gg: AfdE7ckWDfti8XygLvV8Dfmhuhzf7T/z0Ogv7EOLd3/tv9LOfeccNdt5qz1y4mxsnj1
	Su1ppYzlMphMFyDR/1jUZQUXkepw6Cx8+tF2fwSMU7Yr4L9Ibzi3CcXsmXiLP+QBgB7W+awRxmq
	qny2DzXQMrSnYC/bIGrNnVNp7dOvLiIUUg3+WpkR9T1ithy8eQWKi20mn8eRxYjXXQENSq2BvEK
	ytnggbLE4IxKsjAj5a4E3Op2gI4ifyrz98TstpCF7i3rQyIuOGc1wUD/jX/qxjB1oI/brFZPTpa
	UwvgpY+1R83EcktwME3wjVahrTM+YfRuH0m+SuvTaIaxW5ixmE9u3c/RsZRErr3QRfVqRPlCs6/
	DX+szLUy6I1GWmzGDG8AfCVRvhYNScfpIUd44+MSJrpdqVf2WxcBSZBoRAkIyehNMpEEhu63iGV
	TbikxkwRBE+A9DlWy6WZowq5tN0evrasCf5o827zlj5HHOlwBY5ao=
X-Received: by 2002:a05:600c:1c27:b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-493f887ab70mr98283125e9.2.1783949063602;
        Mon, 13 Jul 2026 06:24:23 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm356961685e9.1.2026.07.13.06.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:24:22 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:24:19 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <alTnAy7jvjUamwUA@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501111928.259252-9-smostafa@google.com>

On Fri, May 01, 2026 at 11:19:10AM +0000, Mostafa Saleh wrote:
> Create a page-table for the IOMMU that shadows the host CPU stage-2
> to establish DMA isolation.
> 
> An initial snapshot is created after the driver init, then
> on every permission change a callback would be called for
> the IOMMU driver to update the page table.
> 
> There are 3 different ways to add the callback:
> 1) In the high level memory transitions: (__pkvm_host_donate_hyp(),
>   __pkvm_host_donate_guest()...
> 
> 2) In Lower level functions covering all transitions
>   - host_stage2_set_owner_metadata_locked() which covers:
>    - __pkvm_host_donate_hyp()
>    - __pkvm_host_donate_guest()
>    - __pkvm_host_donate_hyp()
>    - __pkvm_guest_unshare_host()
>   - host_stage2_set_owner_locked() only for ID_HOST which covers:
>    - __pkvm_hyp_donate_host()
>    - __pkvm_host_force_reclaim_page_guest()
>    - __pkvm_host_reclaim_page_guest()
>    - __pkvm_guest_share_host()
> 
> 3) In the lowest level function __host_update_page_state(), which
>    requires only one callback. However, in that case the page state
>    is not enough as we might need to know the old state also.
> 
> Option #3 was implemented here.
> 
> For some cases, an SMMUv3 may be able to share the same page-table
> used with the host CPU stage-2 directly.
> 
> However, this is too strict and requires changes to the core hypervisor
> page-table code, plus it would require the hypervisor to handle IOMMU
> page-faults. This can be added later as an optimization for SMMUV3.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/iommu.h       |   4 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   2 +
>  arch/arm64/kvm/hyp/nvhe/iommu/iommu.c         | 108 +++++++++++++++++-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  35 ++++++
>  4 files changed, 146 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
> index 1ac70cc28a9e..6277d845cdcf 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
> @@ -3,11 +3,15 @@
>  #define __ARM64_KVM_NVHE_IOMMU_H__
>  
>  #include <asm/kvm_host.h>
> +#include <asm/kvm_pgtable.h>
>  
>  struct kvm_iommu_ops {
>  	int (*init)(void);
> +	int (*host_stage2_idmap)(phys_addr_t start, phys_addr_t end, int prot);
>  };
>  
>  int kvm_iommu_init(void);
>  
> +int kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
> +				enum kvm_pgtable_prot prot);
>  #endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index ff440204d2c7..f7faecc3b70a 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -54,6 +54,8 @@ int __pkvm_host_test_clear_young_guest(u64 gfn, u64 nr_pages, bool mkold, struct
>  int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu);
>  
>  bool addr_is_memory(phys_addr_t phys);
> +u64 find_mem_range_from(u64 start, bool *is_memory);
> +
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
>  int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id);
>  int kvm_host_prepare_stage2(void *pgt_pool_base);
> diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> index 406c8fb9b3b9..1db52bd87c38 100644
> --- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> +++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> @@ -4,17 +4,119 @@
>   *
>   * Copyright (C) 2022 Linaro Ltd.
>   */
> +#include <linux/iommu.h>
> +
>  #include <nvhe/iommu.h>
> +#include <nvhe/mem_protect.h>
> +#include <nvhe/spinlock.h>
>  
>  /* Only one set of ops supported */
>  struct kvm_iommu_ops *kvm_iommu_ops;
>  
> +/* Protected by host_mmu.lock */
> +static bool kvm_idmap_initialized;
> +
> +static inline int pkvm_to_iommu_prot(enum kvm_pgtable_prot prot)
> +{
> +	int iommu_prot = 0;
> +
> +	if (prot & KVM_PGTABLE_PROT_R)
> +		iommu_prot |= IOMMU_READ;
> +	if (prot & KVM_PGTABLE_PROT_W)
> +		iommu_prot |= IOMMU_WRITE;
> +
> +	/* We don't understand that, might be dangerous. */
> +	WARN_ON(prot & ~PKVM_HOST_MEM_PROT);
> +	return iommu_prot;
> +}
> +
> +static int __snapshot_host_stage2(const struct kvm_pgtable_visit_ctx *ctx,
> +				  enum kvm_pgtable_walk_flags visit)
> +{
> +	u64 start = ctx->addr;
> +	u64 end = start + kvm_granule_size(ctx->level);
> +	kvm_pte_t pte = *ctx->ptep;
> +	bool is_memory;
> +	u64 region_end;
> +	int prot;
> +	int ret;
> +
> +	/*
> +	 * Keep annotated PTEs unmapped, and map everything else even lazily
> +	 * mapped MMIO with pte == 0, as the IOMMU can't handle page faults.
> +	 * That maps the whole address space which can be large, but that doesn't
> +	 * use a lot of memory as it will be mostly large block (1 GB with 4kb pages)
> +	 */
> +	if (pte && !kvm_pte_valid(pte))
> +		return 0;
> +
> +	if (kvm_pte_valid(pte)) {
> +		prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte));
> +		/* If the range is mapped in a single PTE, it must be the same type.*/
> +		if (!addr_is_memory(start))
> +			prot |= IOMMU_MMIO;
> +
> +		return kvm_iommu_ops->host_stage2_idmap(start, end, prot);

Do we really need to do that when is_memory()? 

fix_host_ownership_walker() by calling host_stage2_idmap_locked() and
host_stage2_set_owner_locked() should already handle the memory region. That
would also get rid of kvm_idmap_initialized.

So this one here could only take care of the MMIO?

Overall we would have a common point of synchro which is
fix_host_ownership_walker() after which the host ownership is ready for both
CPU stage-2 and the IOMMU?

> +	}
> +
> +	/* In case of invalid PTE, we need to figure out which part of it is MMIO */
> +	do {
> +		prot = IOMMU_READ | IOMMU_WRITE;
> +		region_end = find_mem_range_from(start, &is_memory);
> +		region_end = min(end, region_end);
> +		if (!is_memory)
> +			prot |= IOMMU_MMIO;
> +
> +		ret = kvm_iommu_ops->host_stage2_idmap(start, region_end, prot);
> +		if (ret)
> +			return ret;
> +
> +		start = region_end;
> +	} while (start < end);
> +
> +	return 0;
> +}
> +
> +static int kvm_iommu_snapshot_host_stage2(void)
> +{
> +	int ret;
> +	struct kvm_pgtable_walker walker = {
> +		.cb	= __snapshot_host_stage2,
> +		.flags	= KVM_PGTABLE_WALK_LEAF,
> +	};
> +	struct kvm_pgtable *pgt = &host_mmu.pgt;
> +
> +	hyp_spin_lock(&host_mmu.lock);
> +	ret = kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker);
> +	/* Start receiving calls to host_stage2_idmap. */
> +	kvm_idmap_initialized = !ret;
> +	hyp_spin_unlock(&host_mmu.lock);
> +
> +	return ret;
> +}
>  
>  int kvm_iommu_init(void)
>  {
> -	/* Keep DMA isolation optional. */
> -	if (!kvm_iommu_ops || !kvm_iommu_ops->init)
> +	int ret;
> +
> +	if (!kvm_iommu_ops || !kvm_iommu_ops->init ||
> +	    !kvm_iommu_ops->host_stage2_idmap)
> +		return 0;
> +
> +	ret = kvm_iommu_ops->init();
> +	if (ret)
> +		return ret;
> +
> +	return kvm_iommu_snapshot_host_stage2();
> +}
> +
> +int kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
> +				enum kvm_pgtable_prot prot)
> +{
> +	hyp_assert_lock_held(&host_mmu.lock);
> +
> +	if (!kvm_idmap_initialized)
>  		return 0;
>  
> -	return kvm_iommu_ops->init();
> +	return kvm_iommu_ops->host_stage2_idmap(start, end, pkvm_to_iommu_prot(prot));
>  }
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 2fb20a63a417..b54cb72ed88c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -15,6 +15,7 @@
>  #include <hyp/fault.h>
>  
>  #include <nvhe/gfp.h>
> +#include <nvhe/iommu.h>
>  #include <nvhe/memory.h>
>  #include <nvhe/mem_protect.h>
>  #include <nvhe/mm.h>
> @@ -481,6 +482,14 @@ static int check_range_allowed_memory(u64 start, u64 end)
>  	return 0;
>  }
>  
> +u64 find_mem_range_from(u64 start, bool *is_memory)
> +{
> +	struct kvm_mem_range r;
> +
> +	*is_memory = !!find_mem_range(start, &r);
> +	return r.end;
> +}
> +
>  static bool range_is_memory(u64 start, u64 end)
>  {
>  	struct kvm_mem_range r;
> @@ -577,8 +586,34 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
>  
>  static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_state state)

I would really split this. I know that this is convinient, but as the function
says, it only update the page state so it shouldn't hide an update to the IOMMU.

Beside, we have examples already in Android where we want to update the
page-state but not the IOMMU, so it doesn't feel future-proof...

>  {
> +	enum pkvm_page_state old = get_host_state(hyp_phys_to_page(addr));
> +	enum kvm_pgtable_prot prot = 0;
> +
>  	for_each_hyp_page(page, addr, size)
>  		set_host_state(page, state);
> +
> +	/*
> +	 * Any transition to PKVM_NOPAGE, unmaps the page from the host
> +	 * Any transition to PKVM_PAGE_SHARED_BORROWED, maps the page in the host
> +	 * Any transition to PKVM_PAGE_SHARED_OWNED is ignored as page is already mapped.
> +	 * Transitions to PKVM_PAGE_OWNED from anything but PKVM_NOPAGE are ignored.
> +	 * Transitions to PKVM_PAGE_OWNED from PKVM_NOPAGE will map the page.
> +	 */
> +	if ((state == PKVM_PAGE_SHARED_OWNED) ||
> +		((state == PKVM_PAGE_OWNED) && (old != PKVM_NOPAGE)))
> +		return;
> +
> +	if ((state == PKVM_PAGE_SHARED_BORROWED) ||
> +		(state == PKVM_PAGE_OWNED))
> +		prot = PKVM_HOST_MEM_PROT;

... and that would avoid that sort of things here. The caller decides if the IOMMU
is updated or not.

And as the patch says, we "shadow" the host stage2. So probably modifying
host_stage2_idmap and host_stage2_set_owner_metdata() sounds really a better
approach.

> +
> +	/*
> +	 * Only update the IOMMU from here, as MMIO can't transition after
> +	 * de-privilege, that will need to change when device assignment
> +	 * is supported.
> +	 * And WARN on failure as we can't unroll at this point.
> +	 */
> +	WARN_ON(kvm_iommu_host_stage2_idmap(addr, addr + size, prot));

>  }
>  
>  #define KVM_HOST_DONATION_PTE_OWNER_MASK	GENMASK(3, 1)
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
