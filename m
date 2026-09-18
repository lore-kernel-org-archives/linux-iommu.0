Received: from mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D114AB1B7
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718898; cv=none; b=aFoh8n0pceA3OU/dhzwxXuRzGdtLctdPlSXquImTcY3EgCI8+zgTPyMGjxiTYymFhaT8BHdDORyMo5AoYiZb8vqVW0G18DBgI9A6wROuFLTFlEDgHxK7HxeL72SSDgHg//0GcM1KUzCPxiby1onMFHLMZS1q0AatQIn4I1GFvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718898; c=relaxed/simple;
	bh=xyISkBw574ZsXxKvu3xwdAxcFPyzjbZIs1ckRKr/QYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdP3Ti5KKy0TUH8SQFgH+V1Y+5Vxpu7FlVm2b/uGUjHHQvMZX1xJbXPjJQFQw8z3cx7dDs7nNx7xbskpfxmRnEO/YZA68/OUSC88fu73GLWFYKgIsgKKtZcxeoQExQP5Q+rGGoDc94Dh07vxY93v03U+hCEJmo656PuhZofmtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GYOIjE9T; arc=none smtp.client-ip=91.218.175.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GYOIjE9T"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=xyISkBw574ZsXxKvu3xwdAxcFPyzjbZIs1ckRKr/QYs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789718893; v=1; x=1790323693;
 b=GYOIjE9TCS52kB3fasEHvocV/8o9kyickSQMkR89NrjEqDrcRo7nQvB/cqQnO+0Tj5dPpoTG
 nBygKi9DiR9Q8JDpWZYaeMzZhRwyJr700RwTNBDgmq+K6LMw5VsDWStD4oF15tqYBf9N6CpOzZE
 iQwloIBn/uTyOTtX1ltiWxJE=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id e05f79cdbbeb581e;
	Fri, 18 Sep 2026 08:08:13 +0000
X-Mizu-Trace-ID: e05f79cdbbeb581e
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 16:08:10 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
	alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
Message-ID: <aqzxavL91icLw-Xv@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902073116.802752-7-chenwandun1@gmail.com>

On 09/02/26 at 03:31pm, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Add MEMBLOCK_NODUMP to mark regions that should be excluded from
> kdump vmcores.
> 
> The flag is meant for reserved memory that carries no data useful for
> crash analysis. Reusable reserved regions such as CMA may hold useful
> data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
> patches wire this up for /reserved-memory and /memreserve/ entries.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> ---
>  include/linux/memblock.h |  9 +++++++++
>  mm/memblock.c            | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index d62db9e776cf..b2fcf11fba2b 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
>   * kernel that we know is good to use. It is the only memory that
>   * allocations may happen from in this phase.
>   * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
> + * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
> + * for crash analysis (e.g. firmware carveouts).
>   */
>  enum memblock_flags {
>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> @@ -63,6 +65,7 @@ enum memblock_flags {
>  	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>  	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
>  	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
> +	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
>  };
>  
>  /**
> @@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
>  int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
> +int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
>  
>  void memblock_free(void *ptr, size_t size);
>  void reset_all_zones_managed_pages(void);
> @@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
>  	return m->flags & MEMBLOCK_KHO_SCRATCH;
>  }
>  
> +static inline bool memblock_is_nodump(struct memblock_region *m)
> +{
> +	return m->flags & MEMBLOCK_NODUMP;
> +}
> +
>  int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
>  			    unsigned long  *end_pfn);
>  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
> diff --git a/mm/memblock.c b/mm/memblock.c
> index f2952d725c10..2e87f39826dd 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1204,6 +1204,21 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
>  				    MEMBLOCK_KHO_SCRATCH);
>  }
>  
> +/**
> + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * Mark the region as not to be included in crash dumps.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
      ~~~~~~~~~~~~~~^
Is it impossible to use at runtime even thought it claims to be generic?


> +{
> +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
> +				    MEMBLOCK_NODUMP);
> +}
> +
>  static bool should_skip_region(struct memblock_type *type,
>  			       struct memblock_region *m,
>  			       int nid, int flags)
> @@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
>  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
>  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
>  	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
> +	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
>  };
>  
>  static int memblock_debug_show(struct seq_file *m, void *private)
> -- 
> 2.43.0
> 
