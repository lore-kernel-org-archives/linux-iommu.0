Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E22437136
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951241; cv=none; b=Cff+sNUaePE+Bdab/ZbirhPkKDqgVL+WPAL0K6eaWaZu7sEQHWeL1eUwz3s3ZxxZphccOLRKmZgabOG9O+OA/x/WszIQKheH8Jx5JhzJ+7s6D5z7O8FuMpqtvv6Qnkf/V4963Qc1UNlrAirIkBGcrTcjqpQqeFJWynR2oTG7nQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951241; c=relaxed/simple;
	bh=bMIBopPRKUwgx4lNvc1cfKNevynafbW2a4cGAOw5U/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNmdin6D8rYiIp7WVsrsYItUm43vfpwyzjhYrss+DH6FxQ3RIAOEdr7mt44pOT6bF03Mnl1K11mW2mRrkQQUOQWL2MNTcpg7Huj+gIxb7EsWBIeMYm/IuCOalCvPSlM/uydRQdtPaWqTiptFay4HrWC6cAFLFET7APs9Ibp8+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGDTlhJ0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGDTlhJ0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso97385e9.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783951238; x=1784556038; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FSjsOyZhkm+OarIp2DDhMFpCZd5ArExcqSVv0NgiTKM=;
        b=vGDTlhJ06Suuo+sqld5UfHA2/p+ARRdSjHDXP5iegJfx+/slPNz2NKuVTCxGLT9C9a
         fotlMSUKGkfro+nWteCb418avDNRKc79oeUZ2DlX2y7oeHDj6v9hwp4j0aYGkA3d6sOe
         /Z8P0N8dNDwFFeCUr5jvEeuYUS1wj8a/PZ64pg4NRvHd/DcG3E0J8E4PO0tqeDT3V2U1
         3yhKgD7vH080PfxtNVlhxIP5At6ocJMb9i628OiZnm6PKtKld7vaNblnpd7L6tsacfRe
         O+klwEQw/OJbl6quu860VyrGFZHAVZPhbNNX2g1y5oVz5qrz2bZw6C0UTn2I+lCgaFeQ
         +Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951238; x=1784556038;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSjsOyZhkm+OarIp2DDhMFpCZd5ArExcqSVv0NgiTKM=;
        b=lSAahRpLUX+ilAyfjHTEsWo+wRkQI2yjjFg0TVMJV9DpFWJqbZV28LItMJRZUvuijj
         I8vfm7Zmd0RqUVPf5jS8v9tgq9nogLNAPf5sSBklOXlCZwXboa0kLlRjlIba+gNhSDPc
         EeLx5OB6qv7YmlBfkyC0fCZX0K5kc/Qdg8Xf0AaSzTpV9KFmRvajR0dFQNkq8ythBn9z
         bUmVcIk7/UzzlPVWGU09CbEURYOycqfkLE8PDXBbPP5jhdxozzncogOqSCYNmZO1lWVz
         sGt5wSqrQtaM+PMCdumakuHNtayOmpzEk0sVWxAwrR5eEbldSaED8g6F1vlqequkKzYH
         dVGw==
X-Forwarded-Encrypted: i=1; AHgh+Rqyvol9vzcZrkhTCXmV2xr8JLQQcbLy4hS29PpCDYTsqZoyQsfZyBazkVNK0avX/5PXLu34sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWat2YASFc2GU9IfXZhrdUDLPAiL3AOfzBgQU+UWpUfQ2ddfjM
	3lrnlI8sK85EmABZ22YB7J9spURFlP0JKjitbOpOijjKQzVvAK37rY5bbl2gfQmUSg==
X-Gm-Gg: AfdE7clVKgHJ6TnpzWtb0KpYHty4dDy3hMTmEk9vfke/TdtVMlGenITb+mVl8D9Vwj2
	a4LcclRyt5hySqkr200rsEkm/CcIRMDPD0pJdHsUwms0nthNF1XmAQRobf/7B5d7w/DtaQqoYem
	w/AOiCTtJNnSq/vFVwWkUnTrOQVtICUUvZSy9p3fdAsd0IB82+mA7NL1wDcBFoeF7X+sazlzhfP
	cSBzX/Hf3G0EOV0rsS+CAyTLfdWeDDDL5VcvrzM9QFhlHin4fi+Coxz641Y36eMqyAwq4wVZB+Q
	QgEmoFgeKD8tOhrMqzRc494XmobunT5FARyxSAyJ/lzgVjhKVmnMcHe4zwgW4+cLTX2r1zhsEOQ
	O52yPFbm7Ii4cYwcy56t+LYsqPP8jDGcA9CZE9mTxCg8s9+NEs0hOlFTSfVyBn9yqCK9w7nGG4V
	XsSfcVAwkEKY2aEEEujavjPiPCAa4VEe6K+78n1M2IGEOYxtpG
X-Received: by 2002:a05:600c:2942:b0:493:a96b:f9fe with SMTP id 5b1f17b1804b1-4945e4218c8mr367445e9.4.1783951237852;
        Mon, 13 Jul 2026 07:00:37 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e0f165sm211046175e9.0.2026.07.13.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:00:36 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:00:31 +0000
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
Message-ID: <alTvf7iiOWn4PKE8@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <alTnAy7jvjUamwUA@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alTnAy7jvjUamwUA@google.com>

On Mon, Jul 13, 2026 at 02:24:19PM +0100, Vincent Donnefort wrote:
> On Fri, May 01, 2026 at 11:19:10AM +0000, Mostafa Saleh wrote:
> > Create a page-table for the IOMMU that shadows the host CPU stage-2
> > to establish DMA isolation.
> > 
> > An initial snapshot is created after the driver init, then
> > on every permission change a callback would be called for
> > the IOMMU driver to update the page table.
> > 

[...]

> > +	 */
> > +	if (pte && !kvm_pte_valid(pte))
> > +		return 0;
> > +
> > +	if (kvm_pte_valid(pte)) {
> > +		prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte));
> > +		/* If the range is mapped in a single PTE, it must be the same type.*/
> > +		if (!addr_is_memory(start))
> > +			prot |= IOMMU_MMIO;
> > +
> > +		return kvm_iommu_ops->host_stage2_idmap(start, end, prot);
> 
> Do we really need to do that when is_memory()? 
> 
> fix_host_ownership_walker() by calling host_stage2_idmap_locked() and
> host_stage2_set_owner_locked() should already handle the memory region. That
> would also get rid of kvm_idmap_initialized.
> 
> So this one here could only take care of the MMIO?
> 
> Overall we would have a common point of synchro which is
> fix_host_ownership_walker() after which the host ownership is ready for both
> CPU stage-2 and the IOMMU?
> 

I am not sure I understand, this is another empty page table, so we
have to walk all of the host CPU stage-2 page table to shadow it in the
IOMMU. if you are refering to the case where it handle zero ptes for
memory, I can drop that but it will not change much in this logic.

> > +	}
> > +
> > +	/* In case of invalid PTE, we need to figure out which part of it is MMIO */

[...]

> >  #include <nvhe/mm.h>
> > @@ -481,6 +482,14 @@ static int check_range_allowed_memory(u64 start, u64 end)
> >  	return 0;
> >  }
> >  
> > +u64 find_mem_range_from(u64 start, bool *is_memory)
> > +{
> > +	struct kvm_mem_range r;
> > +
> > +	*is_memory = !!find_mem_range(start, &r);
> > +	return r.end;
> > +}
> > +
> >  static bool range_is_memory(u64 start, u64 end)
> >  {
> >  	struct kvm_mem_range r;
> > @@ -577,8 +586,34 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
> >  
> >  static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_state state)
> 
> I would really split this. I know that this is convinient, but as the function
> says, it only update the page state so it shouldn't hide an update to the IOMMU.

I mention a couple of alternatives in the commit message, I tried to
implement it differently which was harder to reason about as the calls
was scattered everywhere and any small refactor will possibly break it.

Did you have a split in my mind? I open to rework it.

> 
> Beside, we have examples already in Android where we want to update the
> page-state but not the IOMMU, so it doesn't feel future-proof...
> 
> >  {
> > +	enum pkvm_page_state old = get_host_state(hyp_phys_to_page(addr));
> > +	enum kvm_pgtable_prot prot = 0;
> > +
> >  	for_each_hyp_page(page, addr, size)
> >  		set_host_state(page, state);
> > +
> > +	/*
> > +	 * Any transition to PKVM_NOPAGE, unmaps the page from the host
> > +	 * Any transition to PKVM_PAGE_SHARED_BORROWED, maps the page in the host
> > +	 * Any transition to PKVM_PAGE_SHARED_OWNED is ignored as page is already mapped.
> > +	 * Transitions to PKVM_PAGE_OWNED from anything but PKVM_NOPAGE are ignored.
> > +	 * Transitions to PKVM_PAGE_OWNED from PKVM_NOPAGE will map the page.
> > +	 */
> > +	if ((state == PKVM_PAGE_SHARED_OWNED) ||
> > +		((state == PKVM_PAGE_OWNED) && (old != PKVM_NOPAGE)))
> > +		return;
> > +
> > +	if ((state == PKVM_PAGE_SHARED_BORROWED) ||
> > +		(state == PKVM_PAGE_OWNED))
> > +		prot = PKVM_HOST_MEM_PROT;
> 
> ... and that would avoid that sort of things here. The caller decides if the IOMMU
> is updated or not.

Typically, the IOMMU is updated if the CPU is.

> 
> And as the patch says, we "shadow" the host stage2. So probably modifying
> host_stage2_idmap and host_stage2_set_owner_metdata() sounds really a better
> approach.

Initially, before the pKVM merge upstream I was doing something similar
as that only required one hook [1]. However, after rebasing I found that
would be too complicated and I have to add many more (as mentioned in
the commit message). But I can re-visit this approach in v7.

[1] https://lore.kernel.org/all/20250819215156.2494305-11-smostafa@google.com/

Thanks,
Mostafa

