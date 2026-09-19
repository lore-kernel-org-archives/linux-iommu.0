Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F86238C1A;
	Sat, 19 Sep 2026 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789801897; cv=none; b=fvT//CZMjxvpoqjcrkzErzPXVh9dEWrxhWBNRObQHiv9Svx+o3HysJNgMCWikNG23X0anTEmlWHwR533PAnY1xi4qQWFsj8vvKdU0in1ZwE2+2kUAleNFROcwlshG9TmIqQf644YxJaggBNS7xBCdQH9XZ2hs7ZLKDHPASPE3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789801897; c=relaxed/simple;
	bh=/2N3uvbIbDkxyC4wzUUbQ69EypzM5/Q2LWe/nHYww5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlBvGyOG/yZBw+PykLoocWlZyZm1Q3c5kFz4ZTAEEynN5nKJbPWXEzjDy1y+SeXkv+a4OGlTVCMOSF8SpwtHg9eESurPbUa7M6gIUIaKT7iPzUsddiCBMjAvrBLO6lAS59oJADWe/3FHqWaY/6moTU/K+VmPfyCL8fy6UcWFz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4W1bQei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4W1bQei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3261F000FF;
	Sat, 19 Sep 2026 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789801895;
	bh=bEP94n9v3wLAo85N51UgdrheAoXFz2CprleV4BZJMM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F4W1bQei0WbJqW4r8EVplbGGhiwx7NXzD9fjTAJz1nnroqL5YVOgqQUiArkdtmHyr
	 W9CUxLppulp2QWgWTUWbd/dAehRrSW/lkzZ8oqUe3f2GoaBZ9mxErL6fLMqXM7hUoW
	 pflbnHmqkcZuRmlsQGGEHcLyopvAXc13ZfvUKI6JKD4iUk+a26j861qNbyRs7NwWAe
	 5rxSiPFeIPanXD5TpncL4/J1QB4XlrZSZXGeFurkupyx3dvKksXmU0uWgTWfiWByEt
	 kIY5KOkGCC+OaHU6gMgpAmJdMdOpQb8sI62v9yK0E5VZLKYJBnSZK7nFcRXx41rwCe
	 CYxurd2l460hw==
Date: Sat, 19 Sep 2026 10:11:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <baoquan.he@linux.dev>
Cc: Wandun Chen <chenwandun1@gmail.com>, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, m.szyprowski@samsung.com, mark.rutland@arm.com,
	kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
Message-ID: <aq41nFRPtRWTQ7cK@kernel.org>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com>
 <aqzxavL91icLw-Xv@fedora>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqzxavL91icLw-Xv@fedora>

On Fri, Sep 18, 2026 at 04:08:10PM +0800, Baoquan He wrote:
> On 09/02/26 at 03:31pm, Wandun Chen wrote:
> > From: Wandun Chen <chenwandun@lixiang.com>
> > 
> > Add MEMBLOCK_NODUMP to mark regions that should be excluded from
> > kdump vmcores.
> > 
> > The flag is meant for reserved memory that carries no data useful for
> > crash analysis. Reusable reserved regions such as CMA may hold useful
> > data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
> > patches wire this up for /reserved-memory and /memreserve/ entries.
> > 
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> > Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> > ---
> >  include/linux/memblock.h |  9 +++++++++
> >  mm/memblock.c            | 16 ++++++++++++++++
> >  2 files changed, 25 insertions(+)
> > 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index d62db9e776cf..b2fcf11fba2b 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
> >   * kernel that we know is good to use. It is the only memory that
> >   * allocations may happen from in this phase.
> >   * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
> > + * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
> > + * for crash analysis (e.g. firmware carveouts).
> >   */
> >  enum memblock_flags {
> >  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> > @@ -63,6 +65,7 @@ enum memblock_flags {
> >  	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
> >  	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
> >  	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
> > +	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
> >  };
> >  
> >  /**
> > @@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
> >  int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
> >  int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
> >  int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
> > +int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
> >  
> >  void memblock_free(void *ptr, size_t size);
> >  void reset_all_zones_managed_pages(void);
> > @@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
> >  	return m->flags & MEMBLOCK_KHO_SCRATCH;
> >  }
> >  
> > +static inline bool memblock_is_nodump(struct memblock_region *m)
> > +{
> > +	return m->flags & MEMBLOCK_NODUMP;
> > +}
> > +
> >  int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
> >  			    unsigned long  *end_pfn);
> >  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index f2952d725c10..2e87f39826dd 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1204,6 +1204,21 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
> >  				    MEMBLOCK_KHO_SCRATCH);
> >  }
> >  
> > +/**
> > + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
> > + * @base: the base phys addr of the region
> > + * @size: the size of the region
> > + *
> > + * Mark the region as not to be included in crash dumps.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
>       ~~~~~~~~~~~~~~^
> Is it impossible to use at runtime even thought it claims to be generic?

This should only happen at boot.

Allowing modifications of memblock properties in runtime is a can of worms
I don't want to open.
 
> > +{
> > +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
> > +				    MEMBLOCK_NODUMP);
> > +}
> > +
> >  static bool should_skip_region(struct memblock_type *type,
> >  			       struct memblock_region *m,
> >  			       int nid, int flags)
> > @@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
> >  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
> >  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
> >  	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
> > +	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
> >  };
> >  
> >  static int memblock_debug_show(struct seq_file *m, void *private)
> > -- 
> > 2.43.0
> > 

-- 
Sincerely yours,
Mike.
