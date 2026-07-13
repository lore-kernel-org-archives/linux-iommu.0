Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8C3368AA
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938953; cv=none; b=Nc+s/tnHettU97Ii1jIGhbgv0AXaxmwI4XXTHTHkobmmKuo1TsYk7zwH1qpIpfBVp+XntAl2XBMQSoQdnt7pIU2YQJXjmToFJYMWjROgXtbz8TL+EVsgdepnYowBEl9VYf5HaEfI1pjAhuBuIarzVqNukFXrwiMXc9z/zC5Je+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938953; c=relaxed/simple;
	bh=XMiCZTmiiA8F9BgpScMjYv+1HiDLmlR0kg2oIK8j4ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2eWo2PhJfY7dD/ClU0zZn6BKBOsL7/QvGAsGR1y0mSUprgF4Eukv41e93xXM2OzFBlpdDMmO6tUUKwrvhw2yFc5HAX9bM7S1tfQsplYOaZkT9UyQSrhpBhOOZcVPlJqnpQkkqGyuwNrI6785WG638KnH4XPqeuYiAr6OUjrtEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J47wgG0O; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J47wgG0O"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso84505e9.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783938950; x=1784543750; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4DXPy0h679aPXo6JYjKQdkbMOuE0zeRtrYWKC8kOOJg=;
        b=J47wgG0O/Z8lvfia0rw0Lu/GuvobpTpfY420CauGMKtLiWR9BUcufUtvB/4Lph2ape
         f7lf4Wk1nNhCEiaiIkrbtJsoY9NnbHwRheyb/1EUFXLqpWzWPzBhjFvwpMOu+XMLvJ/p
         yCdneqw141yG3whHJMBIXmMrd2pu4ACdKoLafmGv2iayv0zNUyiQAYHGWn/WXodayOLb
         vsUGzRCy0P3dWgKMbEiijrmGxJCwdkl1V3JrpCX0ZauH01kXfFvz6pZ8tqjNahGeMbMM
         UpKeb4KjSApT8aCYQmdmTN1I3GD38u7X6S9tqFdHd8qBDuaRLoNAibvU/fLqSScFi88k
         80Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783938950; x=1784543750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4DXPy0h679aPXo6JYjKQdkbMOuE0zeRtrYWKC8kOOJg=;
        b=Lk3waIsAD1edrxHYPhD8VOmyHxhOcz7YC7AV1TV8xExmN0RqN4mGPj5yKFC48Fm2p3
         Ca/SLsRaTodG57hIQ8AChy1PO3s6AYWp8wadRvqb7VTiJ9eKGeNfYKO1RLe9aMTec0Q4
         erJK99tVpD67aK3Y3OLhvde4UtWRIw0zCdJw14+udtv+TKnuBMy0xBP9ipzX0BORjn8n
         /s9TppPmY6lSg3xpW4Z37A3F3WYF0n1SHsT4+nMnffHcLjqXfJgvvEHmXtA22Yh5Js/v
         FME/ByzmjjEggP8Uj3RlbApVjemdFafKzXllhzFvFiSDrdsVgYa5yCyj3C18kJoYCZJT
         kLBw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0BsoaTYOUJwjUW4zxT1GebUz0BTcsOQqNEfM3QMgY0bmSf75zmWwGqSJ570waooA/q0oihQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmZCKKbDzfsGz/E6v2tamtR+q+ZHJXQcM1Ng8yrdzqRPj34A4X
	dzRvlBQ7P2RsYzy8EzF2PxleHcd3KENstbPlx9G4iACt8Iai7R/MoYWwOqa5MD3kkQ==
X-Gm-Gg: AfdE7cnJ3xP2uirujGiKERAKy0ZT0LIT9cVmn4nlPNm0g6iM4yCeI5s2CbnPHXbfjsT
	blr74mjD7ahwZ/rz6/xVR1v3lDqueKdtaQuqgXeE9U4zqUMf7lJeydzAnaEqHmAMioZjA4qY1A9
	qDBC04WihEQp2A1ndu39NgtgGgtJ0UDS6b6v647SeCMXT7gzG5k/TnW3oR8bflKGW98sXAgSB8F
	py+wRfKYP0S8JbYPWS48duTgbXYWfWLr5Gy6ZhtDOO+CC6GQDkeOL5VoC4foSKiYl+r4FfcHW9s
	FMy2S9pfw8XKlqYsBnyEuwIV0+sUAjiW8lJEmA9j+dS6G8zSFjmSMOkdmqGj+LG667+bEpQau75
	MZH7f5FKlH71C2zYVfmpWT6wlMTitNLJA3KVjd5pMFGc8C5xbPeaILjJNSsoc/O0A6W/xX9nGRZ
	KhJl13yq+csTvU5d1MqkD+9WiaXTW62QSRpvc0T6QhRWrc6+OeU402q0AMASw=
X-Received: by 2002:a05:600c:828c:b0:493:b279:6012 with SMTP id 5b1f17b1804b1-4945e2be9femr228985e9.0.1783938949719;
        Mon, 13 Jul 2026 03:35:49 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f2465ae8bsm28188355f8f.36.2026.07.13.03.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:35:48 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:35:44 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 09/25] KVM: arm64: iommu: Add memory pool
Message-ID: <alS_gB5uSEbFV-jH@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-10-smostafa@google.com>
 <alEeyoXnMC0J4zFQ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEeyoXnMC0J4zFQ@google.com>

On Fri, Jul 10, 2026 at 05:33:14PM +0100, Vincent Donnefort wrote:
> On Fri, May 01, 2026 at 11:19:11AM +0000, Mostafa Saleh wrote:
> > IOMMU drivers would require to allocate memory for the shadow page
> > table. Similar to the host stage-2 CPU page table, the IOMMU pool
> > is allocated early from the carveout and it's memory is added in
> > a pool which the IOMMU driver can allocate from and reclaim at
> > run time.
> > 
> > As this is too early for drivers to use init calls, set the number of
> > page allocated from the kernel command line "kvm-arm.hyp_iommu_pages".
> > 
> > Later when the driver registers, it will pass how many pages it
> > needs, and if it was less than what was allocated, it will fail
> > to register.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  4 +++
> >  arch/arm64/include/asm/kvm_host.h             |  3 +-
> >  arch/arm64/kvm/hyp/include/nvhe/iommu.h       |  7 +++-
> >  arch/arm64/kvm/hyp/nvhe/iommu/iommu.c         | 21 +++++++++++-
> >  arch/arm64/kvm/hyp/nvhe/setup.c               | 12 ++++++-
> >  arch/arm64/kvm/iommu.c                        | 33 ++++++++++++++++++-
> >  arch/arm64/kvm/pkvm.c                         |  1 +
> >  7 files changed, 76 insertions(+), 5 deletions(-)
> > 
[...]
> If we expect drivers to use that perhaps we should document a bit better (same
> for kvm_iommu_reclaim_pages()

Will do.

> 
> > +void *kvm_iommu_donate_pages(u8 order);
> > +void kvm_iommu_reclaim_pages(void *ptr);
> > +
> >  #endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
> > diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > index 1db52bd87c38..53cb5e4b0aac 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> 
> Do we really need that subfolder iommu/ ?

Propably not, I will remove it.

> 
> > @@ -15,6 +15,7 @@ struct kvm_iommu_ops *kvm_iommu_ops;
> >  
> >  /* Protected by host_mmu.lock */
> >  static bool kvm_idmap_initialized;
> > +static struct hyp_pool iommu_pages_pool;
> >  
> >  static inline int pkvm_to_iommu_prot(enum kvm_pgtable_prot prot)
> >  {
> > @@ -95,7 +96,7 @@ static int kvm_iommu_snapshot_host_stage2(void)
> >  	return ret;
> >  }
> >  
> > -int kvm_iommu_init(void)
> > +int kvm_iommu_init(void *pool_base, unsigned int nr_pages)
> >  {
> >  	int ret;
> >  
> > @@ -103,6 +104,14 @@ int kvm_iommu_init(void)
> >  	    !kvm_iommu_ops->host_stage2_idmap)
> >  		return 0;
> >  
> > +	if (!nr_pages)
> > +		return -ENOMEM;
> > +
> > +	ret = hyp_pool_init(&iommu_pages_pool, hyp_virt_to_pfn(pool_base),
> > +			    nr_pages, 0);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = kvm_iommu_ops->init();
> >  	if (ret)
> >  		return ret;
> > @@ -120,3 +129,13 @@ int kvm_iommu_host_stage2_idmap(phys_addr_t start, phys_addr_t end,
> >  
> >  	return kvm_iommu_ops->host_stage2_idmap(start, end, pkvm_to_iommu_prot(prot));
> >  }
> > +
> > +void *kvm_iommu_donate_pages(u8 order)
> > +{
> > +	return hyp_alloc_pages(&iommu_pages_pool, order);
> > +}
> > +
> > +void kvm_iommu_reclaim_pages(void *ptr)
> > +{
> > +	hyp_put_page(&iommu_pages_pool, ptr);
> > +}
> > diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> > index 1f6b221db9a0..215014e42c27 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> > @@ -23,6 +23,9 @@
> >  
> >  unsigned long hyp_nr_cpus;
> >  
> > +/* See kvm_iommu_pages() */
> > +unsigned int hyp_kvm_iommu_pages;
> 
> nit: we tend to use everywhere unsigned long or u64 for nr_pages.

Initially it was size_t. However, the hyp allocator uses unsigned int
so I was matching its type, I was considering to send a patch upstream
for this but that is not really a problem at the moment as it only
overflows if the system has ~2TB of memory.

> 
> > +
> >  #define hyp_percpu_size ((unsigned long)__per_cpu_end - \
> >  			 (unsigned long)__per_cpu_start)
> >  
> > @@ -34,6 +37,7 @@ static void *selftest_base;
> >  static void *ffa_proxy_pages;
> >  static struct kvm_pgtable_mm_ops pkvm_pgtable_mm_ops;
> >  static struct hyp_pool hpool;
> > +static void *iommu_base;
> >  
> >  static int divide_memory_pool(void *virt, unsigned long size)
> >  {
> > @@ -71,6 +75,12 @@ static int divide_memory_pool(void *virt, unsigned long size)
> >  	if (!ffa_proxy_pages)
> >  		return -ENOMEM;
> >  
> > +	if (hyp_kvm_iommu_pages) {
> > +		iommu_base = hyp_early_alloc_contig(hyp_kvm_iommu_pages);
> > +		if (!iommu_base)
> > +			return -ENOMEM;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -330,7 +340,7 @@ void __noreturn __pkvm_init_finalise(void)
> >  	if (ret)
> >  		goto out;
> >  
> > -	ret = kvm_iommu_init();
> > +	ret = kvm_iommu_init(iommu_base, hyp_kvm_iommu_pages);
> >  	if (ret)
> >  		goto out;
> >  
> > diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
> > index f247384fa193..213429ceb549 100644
> > --- a/arch/arm64/kvm/iommu.c
> > +++ b/arch/arm64/kvm/iommu.c
> > @@ -7,10 +7,11 @@
> >  #include <linux/kvm_host.h>
> >  
> >  extern struct kvm_iommu_ops *kvm_nvhe_sym(kvm_iommu_ops);
> > +extern unsigned int kvm_nvhe_sym(hyp_kvm_iommu_pages);
> >  
> >  static DEFINE_MUTEX(kvm_iommu_reg_lock);
> >  
> > -int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
> > +int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops, unsigned int pool_pages)
> 
> nit: kvm_iommu_init uses nr_pages. 
> 
> >  {
> >  	guard(mutex)(&kvm_iommu_reg_lock);
> >  
> > @@ -21,6 +22,36 @@ int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
> >  	if (kvm_nvhe_sym(kvm_iommu_ops))
> >  		return -EBUSY;
> >  
> > +	/* See kvm_iommu_pages() */
> > +	if (pool_pages > kvm_nvhe_sym(hyp_kvm_iommu_pages)) {
> > +		kvm_err("Not enough memory for the IOMMU pool, need 0x%x pages, check kvm-arm.hyp_iommu_pages",
> > +			pool_pages);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	kvm_nvhe_sym(kvm_iommu_ops) = hyp_ops;
> >  	return 0;
> >  }
> > +
> > +unsigned int kvm_iommu_pages(void)
> > +{
> > +	/*
> > +	 * This is used very early during setup_arch() before any initcalls
> > +	 * or any drivers are registered.
> > +	 * This value is set by a command line option.
> > +	 * Later, when the driver is registered, it will pass the number
> > +	 * pages needed for it's page tables, if it was less that what
> > +	 * the system has already allocated, the registration will fail.
> > +	 */
> > +	return kvm_nvhe_sym(hyp_kvm_iommu_pages);
> > +}
> 
> Could we actually estimate the memory needed, based on the allocation for the
> host stage-2 and an estimation of MMIO coverage? This would allow the whole
> thing to run without setting this value as a best effort and to make it
> optional, which is surely more user-friendly?

Not really, this abstracts the IOMMU, so it does not have to match the
host stage-2, in addition that the SMMUv3 driver requires extra pages
for other in-memory data-structure.

At the moment, this is set from the command line which is not really
best effort as the driver later confirms how much memory it needs.

> 
> > +
> > +/* Number of pages to reserve for iommu pool*/
> > +static int __init early_hyp_iommu_pages(char *arg)
> > +{
> > +	if (!arg)
> > +		return -EINVAL;
> > +
> > +	return kstrtouint(arg, 0, &kvm_nvhe_sym(hyp_kvm_iommu_pages));
> 
> How about using a memory size here with memparse()? This would be more
> transparent for the commandline which can work on different page-size systems.

Makes sense, will do.

Thanks,
Mostafa
