Received: from mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098E34B662
	for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875236; cv=none; b=Xw0m42XNH7SYANhunDjhtePuzi5/em3m7QozrhnOLpARwItQ2RlUqgdq/mwLzAlijIGGyY35rJTm6i4JgIvzKzbqzuf9CQRZD/5WwnDWQGQ44OaMlEb3TlIfsCzmJEfzVWt4KMzGxW4Hg+Fk4V+7lI2aJsewr78i5L09PGegw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875236; c=relaxed/simple;
	bh=hXLqE47HqcLGyqOng+gJY4MA1aiOWDH2fotgfictL0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSti3n9owIdmV9WxfW0KQpXUTigNXb8Uzthk4VOZCdveI2rXRs1FCaKl0vViJ/HfbFT3EU6NqlCEzg1fOOQJVk8ZzZXsJOfdHZDZYuxR+YWunY3wAOqK/PmEGwTb231ZqG05OZoOzRS7oojmSRyez4cKOZooSZfk/Bj5MGSasm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MjFuIBdx; arc=none smtp.client-ip=95.215.58.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MjFuIBdx"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=hXLqE47HqcLGyqOng+gJY4MA1aiOWDH2fotgfictL0g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789875232; v=1; x=1790480032;
 b=MjFuIBdxri6mnPIUOZ/bHRkOn9QfFFAQ/Q0tabD86fdfsLaHgHc5pFS1MJG6bPQIFl3Gca6t
 kDUwPfcgXw4TbXfFtT1ksq+r5VLNgYmTTo+y/m6Qe1Fm5WLBb1VtWBJjhIKxd4GXgMgK888pnSb
 W4ddmcOquFJ+NHn4dj3C3t4o=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 15499ad898b25d57;
	Sun, 20 Sep 2026 03:33:52 +0000
X-Mizu-Trace-ID: 15499ad898b25d57
X-Migadu-Flow: FLOW_OUT
Date: Sun, 20 Sep 2026 11:33:45 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
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
Message-ID: <aq9UGXeqmCfuPHdD@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com>
 <aqzxavL91icLw-Xv@fedora>
 <aq41nFRPtRWTQ7cK@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq41nFRPtRWTQ7cK@kernel.org>

On 09/19/26 at 10:11am, Mike Rapoport wrote:
> On Fri, Sep 18, 2026 at 04:08:10PM +0800, Baoquan He wrote:
> > On 09/02/26 at 03:31pm, Wandun Chen wrote:
...snip... 
> > > +/**
> > > + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
> > > + * @base: the base phys addr of the region
> > > + * @size: the size of the region
> > > + *
> > > + * Mark the region as not to be included in crash dumps.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
> >       ~~~~~~~~~~~~~~^
> > Is it impossible to use at runtime even thought it claims to be generic?
> 
> This should only happen at boot.
> 
> Allowing modifications of memblock properties in runtime is a can of worms
> I don't want to open.

Thank you. This is why I said this can't be claimed as a generic way to
mark memory region as no dump. The generic way I'd like to see is
at any time of system we can mark any unwanted memory region as no dump.
And it won't impact the behaviour of the current system.

>  
> > > +{
> > > +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
> > > +				    MEMBLOCK_NODUMP);
> > > +}
> > > +
> > >  static bool should_skip_region(struct memblock_type *type,
> > >  			       struct memblock_region *m,
> > >  			       int nid, int flags)
> > > @@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
> > >  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
> > >  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
> > >  	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
> > > +	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
> > >  };
> > >  
> > >  static int memblock_debug_show(struct seq_file *m, void *private)
> > > -- 
> > > 2.43.0
> > > 
> 
> -- 
> Sincerely yours,
> Mike.
