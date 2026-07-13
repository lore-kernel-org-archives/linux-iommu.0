Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343D3537E8
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966773; cv=none; b=OGV60ngPMAS0n7mZoRqshOpXeXdp1PviJstNDguHaUCG6MeBWIkeIT6/MpMpA7FnilfLeBtt6/7uYBdHYb2SR242gx/h3k5uDRQHwklmgcJn7UtwBZWi9XCf8pE/nMbZl9Bs4eespd5pCcUwvCjgwixIiHQY4ohwp+17qxaxz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966773; c=relaxed/simple;
	bh=XcDcA4ks+cWLMqfNxD6uU8FdP6C/NUsSvAF8nhH1dgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWeI8C8rMEhsGsqFqMG4QgfxjGxkxuj4heze2KVF3qgdj9avdD2IWzVF7f79TUi+E0fGOaTdPnaYXQ9jbHg0rBtnHs1ImT/n+25Ump+hfhDqEkYcIyqE6xvUVPEl0oHQfpEQDUDgNDzIqESfa3JNGJw8NfM+88bxnanO9mR1YHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+Lwq6Gk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+Lwq6Gk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b8d99342so5655e9.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783966770; x=1784571570; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TRa3gkBurBR7N5v7ETtohTvNPFwYZWxGltJdYj43XxQ=;
        b=m+Lwq6Gk7VPqcSJAD8yKKnllb7yIZUIAMABfgEnZQDmfDXh3zhyViA0pgkTQQHsug4
         kr4kk2PLUm0PLE4p2baK9ZPc15Nc4NUy6ArC/+2ujdWYGcYrJ3eJZ8vHL1YW1S/kNLRK
         hb9kl3xkjiWxituPt0ljzcpUSDEMOqgR/W5sP4hHprjULFemtO5AJWuNSBR4cFSdEViM
         CqCdqXijQwS0eX4x+6OBKNXpHlyuyOjDiy64lhYH5TEYOLoMqJC/Qh3qAwHDdC8EsWet
         MQTdoiTV9+mOkhUhVmWJ4/ojKlDmdm5X3JntaiVQypb3cqBlfwiD0bY+5qq5uMOl4kLf
         qxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966770; x=1784571570;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TRa3gkBurBR7N5v7ETtohTvNPFwYZWxGltJdYj43XxQ=;
        b=tHXl1jbQDLpZiWFi9ogARrhU65/QFRgqzrFT1WVWce6AvSidByKt0e9nsdToWea3uu
         GNBk9XNbBBwBC9g7fGsDbNu4lJ1K5yqPCe/slR1oF3rDNS3/9OH1DDoqsyXTh3lnLa08
         Mo4kXRkM0TZqh/Rll7OdiQRPXxMwVUoL4hS3lPP90FfB4ZKrZWuZYXdql3lsMbLZdI+S
         KK/4FAGa/wc+qSpK3HA9VNCaSWNNwyqiRvdAWSNetPIKrhvfWP7694tQUAvrwRuO4/WU
         GyklUY45ZE5LjPGMaKvX2esCRaNRKB15PILDj0xd3fB0SeCtB5ihX8NK/VxNYZsc2cYU
         nnQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqW2ojoCJIOHx5S13oJOPukGc3goDH3fhaGY7ygCjoOLf/58neHmiqdmCJtBRceoXOoJAhBdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBYl2ocht6pQFpddhZa8icoAZnlqjOhTNeHY6pPToL/NhvQPyP
	bqaRiFpsJTqAkTjsMlChlqW6t9SefFIZGSHiMqMvXzCWirAzn7EImoiy8qzn2zvlzA==
X-Gm-Gg: AfdE7ckCUwlAVX+G7OjIXZzFtB2a7wrWggW4JTl9KV3axJS9qeS8bd9X7SnmiRTma82
	VAdAXgZD4+1GsZM9/tg6R2gFsnsNt6wlSZN9p5XzD4dibadiGp4tEDRHOwgn4108uj+Rgoz2Z7K
	oN703jRQPM6g6BEnfJ+QFwwoKa7aF5OXvQYKsgFbk7rxXjlo5ZCAZysqI538+hoP1UT30UEXOAG
	Lp/jYZqRtnlXVzZBPrq4b/vR+ESB/983ktKa2wEXbVjEasIRMvnfZhxjiOSq9yj++t1z/aUL1gg
	uJmCbNCA28ZgUiBugMHSnoxdlfO6xYfawTh955Y3TEkuW5cK+qwAYXyDGBR9ijPkyHCtJlaIs5Q
	PIpYJ6RvAKNl/E5V96osUrrfauBOWvIc08t+Sw3NMvwl16zqKrhClUtk2DyH5U0uau7PlkoL1io
	AcKdUW0w56cZ7/ujyLYpW6xQH0Vy2dNmfLvDPGrpd1xQ01Clih
X-Received: by 2002:a05:600c:3f19:b0:493:adf3:d892 with SMTP id 5b1f17b1804b1-49462146d30mr789945e9.3.1783966770170;
        Mon, 13 Jul 2026 11:19:30 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a38b19sm215129925e9.0.2026.07.13.11.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 11:19:29 -0700 (PDT)
Date: Mon, 13 Jul 2026 18:19:24 +0000
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
Message-ID: <alUsLFBQ5qKFOgwQ@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <alTnAy7jvjUamwUA@google.com>
 <alTvf7iiOWn4PKE8@google.com>
 <alUA7zsJO1FGnss-@google.com>
 <alUJa5cbjjqZ8n72@google.com>
 <alUMVU7DYcrvgAYi@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUMVU7DYcrvgAYi@google.com>

On Mon, Jul 13, 2026 at 05:03:33PM +0100, Vincent Donnefort wrote:
> On Mon, Jul 13, 2026 at 03:51:07PM +0000, Mostafa Saleh wrote:
> > On Mon, Jul 13, 2026 at 04:14:55PM +0100, Vincent Donnefort wrote:
> > > On Mon, Jul 13, 2026 at 02:00:31PM +0000, Mostafa Saleh wrote:
> > > > On Mon, Jul 13, 2026 at 02:24:19PM +0100, Vincent Donnefort wrote:
> > > > > On Fri, May 01, 2026 at 11:19:10AM +0000, Mostafa Saleh wrote:
> > > > > > Create a page-table for the IOMMU that shadows the host CPU stage-2
> > > > > > to establish DMA isolation.
> > > > > > 
> > > > > > An initial snapshot is created after the driver init, then
> > > > > > on every permission change a callback would be called for
> > > > > > the IOMMU driver to update the page table.
> > > > > > 
> > > > 
> > > > [...]
> > > > 
> > > > > > +	 */
> > > > > > +	if (pte && !kvm_pte_valid(pte))
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	if (kvm_pte_valid(pte)) {
> > > > > > +		prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte));
> > > > > > +		/* If the range is mapped in a single PTE, it must be the same type.*/
> > > > > > +		if (!addr_is_memory(start))
> > > > > > +			prot |= IOMMU_MMIO;
> > > > > > +
> > > > > > +		return kvm_iommu_ops->host_stage2_idmap(start, end, prot);
> > > > > 
> > > > > Do we really need to do that when is_memory()? 
> > > > > 
> > > > > fix_host_ownership_walker() by calling host_stage2_idmap_locked() and
> > > > > host_stage2_set_owner_locked() should already handle the memory region. That
> > > > > would also get rid of kvm_idmap_initialized.
> > > > > 
> > > > > So this one here could only take care of the MMIO?
> > > > > 
> > > > > Overall we would have a common point of synchro which is
> > > > > fix_host_ownership_walker() after which the host ownership is ready for both
> > > > > CPU stage-2 and the IOMMU?
> > > > > 
> > > > 
> > > > I am not sure I understand, this is another empty page table, so we
> > > > have to walk all of the host CPU stage-2 page table to shadow it in the
> > > > IOMMU. if you are refering to the case where it handle zero ptes for
> > > > memory, I can drop that but it will not change much in this logic.
> > > 
> > > In fixup_host_ownership() we already walk the hyp pgtable to know what needs to be
> > > map/unmapped from the host stage-2. Can't we rely on that for the IOMMU
> > > page-table as well?
> > > 
> > > As of, fix_host_ownership() could handle the host stage-2 __and__ the iommu? 
> > 
> > fix_host_ownership() only walks the hypervisor page table, and fixes the
> > hypervisor pages in the host.
> 
> Yeah, Looking closer I don't think my proposal simplify things so much in the
> end.
> 
> > That means that the IOMMU page table has
> > to  be fully populated first, then we unmap the donated pages.
> > That seems more complicated and it feels that decoupling the IOMMU
> > logic outside of this would be better.
> 
> Why more complicated? That's actually another solution I was thinking about, to
> just map everything as soon as possible and let host_stage2_idmap_locked() and
> host_stage2_set_owner_locked() unmap what is needed here. (and also in
> __pkvm_host_donate_hyp_mmio())
> 
> We wouldn't need any specific setup walker for the iommu at all.

That would walk the table twice, first time with a massive map, then
to unmap the pages that was just mapped, issuing TLB invalidations
for all of those, also as the IOMMU page table code never frees tables
that means we would immediately exahust the IOMMU pool.

Also, I believe that it is better to isolate the IOMMU page table
shadowing logic from the core hypervisor page table setup, specially
AFAICT, that was not what fix_host_ownership() was designed for, and
seems the IOMMU will just piggyback on a existing walker.

> 
> > 
> > Also, I rely on the IOMMU init to be done at the end of setup, so we
> > do not have to clean the IOMMU init if any other part of KVM fails.
> 
> We could just leak those pages if it fails?

It is not just about pages, the hypervisor will also configure the SMMU
registers. Ideally, we would need a remove() driver ops for such cases
but I added the IOMMU init call at the end to avoid making this series
any bigger.

Thanks,
Mostafa

