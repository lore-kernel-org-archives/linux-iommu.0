Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B343EC69B
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140106; cv=none; b=Smiqu6cipAr6mkARPvjtkWWxaWEemKfCovXLp3tCr1faLWanFIh0JGA+9qzM0QPx6Bcj/TTbxd0Bw/Rxw1BQd93lZF1pUPeYV7OaDPMU+B1PgYt63cPVVDhlbwUoIPb5b/2CCuuyhWjkEulCnLHOMd5rZl/ueGrkcvSJ0D0kDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140106; c=relaxed/simple;
	bh=dw3irkLJQj/TqyBuabDE06fNr/KqbQCYaRdJl6Kni4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2JeoryQrOq3M0qxYzVG5MSEASjTWcDmd7R9dg6V23DCohR9x/I4B6ica3jDypWK/+yNA5UuloOZot1V0qW8BoQEXUIBX2MhnZPNGRlssuF5z2Pwe6NMSi2LslmBJ9DNXYZyypTIxGQ3J74brdLdxReEBL4U932wT45xPAKJXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1SbygAT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1SbygAT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso6765e9.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784140092; x=1784744892; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ciQ1DWmOl90RU8Z0TC+0zcZO7jcoRA4J346GsiDnDic=;
        b=f1SbygATLQh5lxRAK/BWqeZqLtb/8xZQvzhULa0HSd9a2EWhES6ZKLju58Kbz9z2Qb
         FBhZoo52Oq7vJBefZyc+a6TzyQUzW85AYNTC1yOFosoto1DyaaN8oyjcXCbmpidZxGcg
         efVwG9T/npUxm1+GS6zFZ22W9Tj6ZmOqUobOneFaMAhpP/Z9sCYm2ZPW7Dhau+L4m0GX
         uu0rf0dy4kJB2uMi9oA+6DN1nc8sDZLDaKXxoiLOQc96mRY1WRS9e8Bx/iMaBQM38BP4
         r1MsyCX+Fi6XB38zLekohIwMwGjPY/cSZbWKEZcOhtcu7qbp/GDTOARcBrxUvRfaTlxT
         sQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784140092; x=1784744892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ciQ1DWmOl90RU8Z0TC+0zcZO7jcoRA4J346GsiDnDic=;
        b=NxnneHq4naCvDmF2XU/h0Tw11Ut+9CFEKXwUv7kxkPhy7GROxqu0tH1avK3BPXgUC/
         vHwoxZQ9HNXEPOWCChcmWeLkTok0rh7f1q5lLkG2t7HpC1EaLwn2dUDyzljKFYzgD8RL
         aJszpmQnRVz99RhGT6y8j0CLJSMKHhlfZODMZmwbKxOe3AYpEHyRMlIHfqS7XwQP7MeZ
         3AL2NEwZKCG2qMASj/+NUwwQc+Vub3SCRxQR/s8sfbNzjUjZsw0EPCnXdlog8IAzd2xM
         Hi4f+NJbGpJjH5GLnd69vbgz//d6DIjGeQjSAgXq9iKO1Dz8HY11oMPaslM2u5/5buCs
         pLbQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKND8HtN5UXvg0U32ur560SpYH0lcUIbcCn27R01oagWJ/4/Sua32KjYVDTZ8PHrludpdRdw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw42Aqm74EPskY+AZmEsRg68nXRMFaUcPQEr4SDEl+Fiu3tGcr
	OKfIOrX4RSubXP1GahWkcjvsgFJ1V1DnLGiCOjTha0BuXeGV4UmTaGnOgBBvIGI32g==
X-Gm-Gg: AfdE7cmwbX/tXqqeeRAv5cjyQttM3XpR1LwPYFbRCZjEmsHQV1UN6wzFnRXvy3qA1Xc
	vHth/s6ATGEPkZQsvdgWBVdq+0iC/KaL7K8LeWXkj5OiMUvUbz331oB4kg8y33sYlGBLP4RFerQ
	/C0EmaOL6L4ou8OJrYL6f4S6MVBFmCn71ySXZmlWl0M2IWHVgQFFDO2kro0Q+wT4zLELaSvWuJ3
	LQYkf26ZoJ0UXq1klH6xqd7HXaxrv7o2LLx5NDx7XMlB5be2q7+kJnGwl5wmmcWRQn4+dqF+1Xu
	+7mFsaCCId9/iLMym0tVYznYX/5Jtf7hFZ+0y7uQLR3f2DiAl2YxP3n5bl3dfbFfsZl+psv5Fqq
	9zLsuoo9O1xSi+RYzMJo/D/IGWTXORp3QAptYYlWf5my7/7Az2cwqSqaGUSHPMXeaGgQVxHCrnu
	hfs5Z/l9ovPgzQ/rL6AyEidJ2n9fhnFezWXq9IwJlbYP5BED6L
X-Received: by 2002:a05:600c:5797:b0:493:b86f:c913 with SMTP id 5b1f17b1804b1-49541e941fbmr34885e9.1.1784140091687;
        Wed, 15 Jul 2026 11:28:11 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ac02sm771805e9.14.2026.07.15.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:28:10 -0700 (PDT)
Date: Wed, 15 Jul 2026 18:28:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v7 02/24] KVM: arm64: Donate MMIO to the hypervisor
Message-ID: <alfRNu-Y7EMol7Gd@google.com>
References: <20260715115906.2664882-1-smostafa@google.com>
 <20260715115906.2664882-3-smostafa@google.com>
 <alfCz_WQR_Al2lFw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alfCz_WQR_Al2lFw@google.com>

On Wed, Jul 15, 2026 at 06:26:39PM +0100, Vincent Donnefort wrote:
> On Wed, Jul 15, 2026 at 11:58:43AM +0000, Mostafa Saleh wrote:
> > Add a function to donate MMIO to the hypervisor so IOMMU hypervisor
> > drivers can protect and access the MMIO of IOMMUs.
> > 
> > As donating MMIO is very rare, and we don’t need to encode the full
> > state, it’s reasonable to have a separate function to do this.
> > It will init the host s2 page table with an invalid leaf with the owner ID
> > to prevent the host from mapping the page on faults.
> > 
> > Also, prevent kvm_pgtable_stage2_unmap() from removing owner ID from
> > stage-2 PTEs, as this can be triggered from recycle logic under memory
> > pressure. There is no code relying on this, as all ownership changes is
> > done via kvm_pgtable_stage2_set_owner()
> > 
> > For the error path in IOMMU drivers, add a function to donate MMIO
> > back from hyp to host. However, that leaks the hypervisor virtual
> > address range which should be acceptable as this is quite rare and
> > it matches the behaviour of fix_map/block.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  7 ++
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 91 ++++++++++++++++++-
> >  arch/arm64/kvm/hyp/pgtable.c                  | 11 +--
> >  3 files changed, 102 insertions(+), 7 deletions(-)
> > 
[...]
> > +	u64 offset;
> > +	int ret;
> > +
> > +	/* Only before de-privilege. */
> > +	if (static_branch_unlikely(&kvm_protected_mode_initialized))
> > +		return -EPERM;
> > +
> > +	if (!PAGE_ALIGNED(addr | size) ||
> 
> You wouldn't need that with u64 pfn, u64 nr_pages :) 

Well that need to be added somewhere :) but I am ok changing the args.

> 
> > +	    !pfn_range_is_valid(hyp_phys_to_pfn(addr), size >> PAGE_SHIFT))
> > +		return -EINVAL;
> > +
> > +	ret = __pkvm_create_private_mapping(addr, size, PAGE_HYP_DEVICE, haddr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	host_lock_component();
> > +	for (offset = 0; offset < size; offset += PAGE_SIZE) {
> > +		if (addr_is_memory(addr + offset)) {
> > +			ret = -EINVAL;
> > +			goto unlock;
> > +		}
> > +		ret = kvm_pgtable_get_leaf(&host_mmu.pgt, addr + offset, &pte, NULL);
> > +		if (ret)
> > +			goto unlock;
> 
> Is that called for big regions? because that looks quite inefficient even for
> something that is init and IIRC we want to use this for GIC hardening too?
> 

It is 128KB, and that's called once at boot (where we walk the whole
addres space anyway) so I don't think it has any impact, and we do
that in other hot paths as __pkvm_guest_share_host().

> Perhaps it wouldn't be complicated to walk hyp_memory[] to make sure this
> doesn't overlap any memory region. And then to reuse check_page_state_range() to
> verify the host stage-2? 

tbh, I think that current implementation is simpler, as we need to
write a special callback for check_page_state_range()

> 
> > +		if (pte && !kvm_pte_valid(pte)) {
> > +			ret = -EPERM;
> > +			goto unlock;
> > +		}
> > +	}
> > +	/*
> > +	 * We set HYP as the owner of the MMIO pages in the host stage-2, for:
> > +	 * - host aborts: host_stage2_adjust_range() would fail for invalid non zero PTEs.
> > +	 * - recycle under memory pressure: host_stage2_unmap_dev_all() would call
> > +	 *   kvm_pgtable_stage2_unmap() which will not clear non zero invalid ptes (counted).
> > +	 * - other MMIO donation: Would fail as we check that the PTE is valid or empty.
> > +	 */
> 
> Not sure we want that level of detail, it will probably become stall very
> quickly. Perhaps we can simply say "the annotation is refcounted and protects
> this region until it is released with __pkvm_hyp_donate_host_mmio()" or
> something like that?
> 
> Also that makes me think, do we want to add this to the ownership_selftest?

Sure, I can look into that.

> 
> > +	ret = host_stage2_try(kvm_pgtable_stage2_annotate, &host_mmu.pgt,
> > +			      addr, size, &host_s2_pool,
> > +			      KVM_HOST_INVALID_PTE_TYPE_DONATION,
> > +			      FIELD_PREP(KVM_HOST_DONATION_PTE_OWNER_MASK, PKVM_ID_HYP));
> > +unlock:
> > +	host_unlock_component();
> > +	return ret;
> > +}
> > +
> > +int __pkvm_hyp_donate_host_mmio(phys_addr_t addr, size_t size)
> > +{
> > +	kvm_pte_t pte;
> > +	u64 offset;
> > +	int ret = 0;
> > +
> > +	if (static_branch_unlikely(&kvm_protected_mode_initialized))
> > +		return -EPERM;
> > +
> > +	if (!PAGE_ALIGNED(addr | size) ||
> > +	    !pfn_range_is_valid(hyp_phys_to_pfn(addr), size >> PAGE_SHIFT))
> > +		return -EINVAL;
> > +
> > +	host_lock_component();
> > +	for (offset = 0; offset < size; offset += PAGE_SIZE) {
> > +		if (addr_is_memory(addr + offset)) {
> > +			ret = -EINVAL;
> > +			goto unlock;
> > +		}
> > +		ret = kvm_pgtable_get_leaf(&host_mmu.pgt, addr + offset, &pte, NULL);
> > +		if (ret)
> > +			goto unlock;
> > +		if (!pte || kvm_pte_valid(pte)) {
> > +			ret = -EINVAL;
> > +			goto unlock;
> > +		}
> > +		if (FIELD_GET(KVM_HOST_DONATION_PTE_OWNER_MASK, pte) != PKVM_ID_HYP) {
> > +			ret = -EPERM;
> > +			goto unlock;
> > +		}
> > +	}
> > +	WARN_ON(host_stage2_idmap_locked(addr, size, PKVM_HOST_MMIO_PROT));
> > +unlock:
> > +	host_unlock_component();
> > +	return ret;
> > +}
> > +
> >  int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
> >  {
> >  	u64 phys = hyp_pfn_to_phys(pfn);
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 91a7dfad6686..3073184cf6ad 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -1161,13 +1161,12 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
> >  	kvm_pte_t *childp = NULL;
> >  	bool need_flush = false;
> >  
> > -	if (!kvm_pte_valid(ctx->old)) {
> > -		if (stage2_pte_is_counted(ctx->old)) {
> > -			kvm_clear_pte(ctx->ptep);
> > -			mm_ops->put_page(ctx->ptep);
> > -		}
> > +	/*
> > +	 * That also ignores stage2_pte_is_counted() instead of clearing
> > +	 * the PTE as the MMIO can be owned by the hypervisor.
> 
> Not sure we should reference something pKVM specific in that code. Perhaps just
> say we don't touch refcounted PTEs?

Sure, I can simplify it.

Thanks,
Mostafa
