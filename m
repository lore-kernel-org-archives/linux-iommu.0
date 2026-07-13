Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D330C160
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958326; cv=none; b=Mte3qPSWiCZ4+UwvwEMS8SdNpbRk0sLP5T/xi02OlYWbPbz8EpDlfrio8j/ChsoODDTFg/o2d/nH+JJLZY6IP6wB4IC06surEJpycgdhanJ4wpBNcyMo7ZjVFSlxr57ztOmsGExpHn8vDQcviqC8i/FGuCDipixxoPSDwnu1EFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958326; c=relaxed/simple;
	bh=7TVTqfM89Eo7wpqXJRAy/V5o7BcTzvaQxsqr/vTm3LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwyrXbBEwsIG7GfNjTdx0tD87O+Px+bwgOQtjkdASMfjYlMb5SrpobEDDKOTypEngd4j30kkn9bdWzCvlnrxlaeOhjWvyjYKw37QaefC3Oe5/KFx/Vpshkp5qKxHAXNK66NsKWAMUA6wW3o+8z81aA3I0JlcBwNn+Gr0W6EqgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eagBoJm6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eagBoJm6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso107485e9.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783958323; x=1784563123; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dzo0aQhKHRe0yCpBtRorQ5XeL5CGII/S8gcGTTckFLg=;
        b=eagBoJm67ytiMM4+hqhAMZbonqAj9fhMri/rVp3N4u/orS9PCaEhnSK7Ni6VSwT9NX
         67fwwuWvWeHJtMs3EiyW5HkZIYp8Z0YhMEB4K9u9f7jnzUMr6fFn+fUKA2JMH41S3dsZ
         wKUw0lDe9oUzcOsPIZQkrBAxkfW8SGl1HPpdypI67tFaP4RSzsKtnkmNB3GNZYOilWxY
         jmVuLDmLrOXUE7G2HgRfXxOItk5S4S3GwDSA28leKubSEdHKQXeW1ZfOhjgJyiq/X7eE
         tr9Oa2rJgnrwHa4mUU2JPdyA0xCj7v+PO78Yc7lnvHsuWJK/gUFKRyRvBM9D2cOyNx81
         9EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958323; x=1784563123;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dzo0aQhKHRe0yCpBtRorQ5XeL5CGII/S8gcGTTckFLg=;
        b=LD1fjVtE2HpIn3VJXY+vHpoFe3D//IwLrI+ZHYBWIX4wenxrOPR2Bw35w5FkiFtLaM
         tCzKELzpPzNTRy/FIgFmanrziMbBw+dNMv2NZJu4nmJt/T2TLf0xwiidmAyYBUklbabY
         wEFZy1cIm8xl8rZzjHw6hqzahUPb8zayPdy63RGSh3x2rw9ZDZFr43ZQd+kMfOHsUeeg
         O6JfM2AOAdCIOki2E+G93Yc4QmITQQHo8aeMsU+cIEh0v/EfVoR11DnizsyhueQbOqwt
         Yt3Gbvhf9j/9071Wu7HPw/Zh9HWH+DAmI3wXHkPj0TUVbR5L9fAo/q7D0ZMKDFTNvwST
         0b2w==
X-Forwarded-Encrypted: i=1; AHgh+RpzQ/ZN+SLy0FTQ7SDlkGWEWu6+pf+hxmQyu7eTClt1hxkkAaXyut/kPHvPBSTgbvmBWu/sDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQsnL0QfA+K/8smIGMG84BXp9mwsCms4kADhxQ+Zl3jI9nQsBq
	+JX1LcfRinsVGGRBUzg9ck7baR3xmDsgPtXtQO0gggwMP/DJQVQ7/GtI3T3mOgPvbA==
X-Gm-Gg: AfdE7cm4cni+jN9RvAaMrHYcQcHDIvQqsNk5uOIfx5S3gP4//ObNwpmeM7tk6zHylsy
	wnrE19YkAxaP4sFHWB/QJhB2k4K8Km8In71z5cb82lzluG/xN6/D5oYfUz5Z/2wkFKtwsfgCr/B
	TUEqIbL+7fe9Dn5nlSgFLttruFnYckJaz2MxUVf/rnhl1osA2tLCAfK81ZnpQUI431UpXQvHr5K
	cj4nm6SiuaAVOAYIJO342Mi6VoAc9rQN7iINiY/a5CIVAG3yvuvtfOgXTx6fi6+Q9Cogt+Xrpzn
	sSa67JaVr2hx4nYEhFPRtxDOTbHDM9s16riAdhvigwwi5igZUdJJFBZ07kHzHvzoAu4y9zGTC+C
	ubRLB9oiOaGKZA4C8KhpdoJZsehs9JpJHAZAjh+f8YJ85nykduEcA7mR2bk0xEKYuQ6bgK9z4J8
	6sfMYr0VL6ibSCFt/cp9gK/5J3ZGzFil05cEKhZpc/W9RriJVk
X-Received: by 2002:a05:600c:46cc:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-494621553d8mr511115e9.6.1783958322657;
        Mon, 13 Jul 2026 08:58:42 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49510c8e220sm1623155e9.15.2026.07.13.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:58:41 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:58:38 +0000
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
Message-ID: <alULLrgdVUZvYYui@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <alTnAy7jvjUamwUA@google.com>
 <alTvf7iiOWn4PKE8@google.com>
 <alUA7zsJO1FGnss-@google.com>
 <alUD1IiSgNkhzFGR@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUD1IiSgNkhzFGR@google.com>

On Mon, Jul 13, 2026 at 04:27:16PM +0100, Vincent Donnefort wrote:
> On Mon, Jul 13, 2026 at 04:14:55PM +0100, Vincent Donnefort wrote:
> > On Mon, Jul 13, 2026 at 02:00:31PM +0000, Mostafa Saleh wrote:
> > > On Mon, Jul 13, 2026 at 02:24:19PM +0100, Vincent Donnefort wrote:
> > > > On Fri, May 01, 2026 at 11:19:10AM +0000, Mostafa Saleh wrote:
> > > > > Create a page-table for the IOMMU that shadows the host CPU stage-2
> > > > > to establish DMA isolation.
> > > > > 
> > > > > An initial snapshot is created after the driver init, then
> > > > > on every permission change a callback would be called for
> > > > > the IOMMU driver to update the page table.
> > > > > 
> > > 
> > > [...]
> > > 
> > > > > +	 */
> > > > > +	if (pte && !kvm_pte_valid(pte))
> > > > > +		return 0;
> > > > > +
> > > > > +	if (kvm_pte_valid(pte)) {
> > > > > +		prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte));
> > > > > +		/* If the range is mapped in a single PTE, it must be the same type.*/
> > > > > +		if (!addr_is_memory(start))
> > > > > +			prot |= IOMMU_MMIO;
> > > > > +
> > > > > +		return kvm_iommu_ops->host_stage2_idmap(start, end, prot);
> > > > 
> > > > Do we really need to do that when is_memory()? 
> > > > 
> > > > fix_host_ownership_walker() by calling host_stage2_idmap_locked() and
> > > > host_stage2_set_owner_locked() should already handle the memory region. That
> > > > would also get rid of kvm_idmap_initialized.
> > > > 
> > > > So this one here could only take care of the MMIO?
> > > > 
> > > > Overall we would have a common point of synchro which is
> > > > fix_host_ownership_walker() after which the host ownership is ready for both
> > > > CPU stage-2 and the IOMMU?
> > > > 
> > > 
> > > I am not sure I understand, this is another empty page table, so we
> > > have to walk all of the host CPU stage-2 page table to shadow it in the
> > > IOMMU. if you are refering to the case where it handle zero ptes for
> > > memory, I can drop that but it will not change much in this logic.
> > 
> > In fixup_host_ownership() we already walk the hyp pgtable to know what needs to be
> > map/unmapped from the host stage-2. Can't we rely on that for the IOMMU
> > page-table as well?
> > 
> > As of, fix_host_ownership() could handle the host stage-2 __and__ the iommu? 
> 
> What I have in mind is the completely untested snippet:
> 
> index 75b00c323310..64cd175ad6c0 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -226,10 +226,11 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
>         case PKVM_PAGE_SHARED_OWNED:
>                 set_hyp_state(page, PKVM_PAGE_SHARED_OWNED);
>                 set_host_state(page, PKVM_PAGE_SHARED_BORROWED);
> +               kvm_iommu_host_stage2_idmap(phys, PAGE_SIZE, IOMMU_READ | IOMMU_WRITE);
>                 break;
>         case PKVM_PAGE_SHARED_BORROWED:
>                 set_hyp_state(page, PKVM_PAGE_SHARED_BORROWED);
> -               set_host_state(page, PKVM_PAGE_SHARED_OWNED);
> +               kvm_iommu_host_stage2_idmap(phys, PAGE_SIZE, IOMMU_READ | IOMMU_WRITE);
>                 break;
>         default:
>                 return -EINVAL;
> @@ -258,15 +259,20 @@ static int fix_host_ownership(void)
>                 .cb     = fix_host_ownership_walker,
>                 .flags  = KVM_PGTABLE_WALK_LEAF,
>         };
> +       u64 mmio = 0;
>         int i, ret;
> 
>         for (i = 0; i < hyp_memblock_nr; i++) {
>                 struct memblock_region *reg = &hyp_memory[i];
>                 u64 start = (u64)hyp_phys_to_virt(reg->base);
> 
> +               kvm_iommu_host_stage2_idmap(mmio, start, IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO);
> +
>                 ret = kvm_pgtable_walk(&pkvm_pgtable, start, reg->size, &walker);
>                 if (ret)
>                         return ret;
> +
> +               mmio = start + reg->size;
>         }
> 
> I believe this does the same as kvm_iommu_snapshot_host_stage2(). WDYS?
>

I see. However, that does not init the memory owned by the host, neither
unmaps hypervisor owned MMIO.

Besides, as mentioned in the reply, that mean that the IOMMU has to be
init earlier which has it's own problems. So, I do not think that it
is worth changing the current logic.

Thanks,
Mostafa

