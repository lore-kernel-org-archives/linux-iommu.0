Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18819CCEC;
	Fri,  5 Sep 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078020; cv=none; b=jHhdAjfQoPo1vW7/LllcJXWns5irsV0z8fVySWsM9HOAt20dCYkXx4sTow9ErytFBhf8Dq+uJbQzXUsvEL2wkpJnZCFZgwGaHeS0NGnbV6bau1hRLSGp7ik9LEjO6jFUYsBCSO8GFFVbi6yZkdUnrejB3mdG9l/uiWEbkZrjkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078020; c=relaxed/simple;
	bh=GKuxMe2A+mKDUW7bUgrTL/4xbuivAI7n6nsCHRDlrS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuZqD2YYjb2CWD3VxGkgi9mRyNOgPGiNQr80MSh5PcpXElgsUTITvysfHKwZMc9iP+CXn/BSv2/62/fn5lGrAJE8qqtibjNUulbA1DI5bsv15+mIGotN7pkqkgtX5dizDYqyK5tlh51qvRnTmo9fPlUBoKefR6LUWZJB++WarP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7C5C4CEF1;
	Fri,  5 Sep 2025 13:13:37 +0000 (UTC)
Date: Fri, 5 Sep 2025 14:13:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, suzuki.poulose@arm.com,
	akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
Message-ID: <aLrh_rbzWLPw9LnH@arm.com>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905055441.950943-1-aneesh.kumar@kernel.org>

Hi Aneesh,

On Fri, Sep 05, 2025 at 11:24:41AM +0530, Aneesh Kumar K.V (Arm) wrote:
> When running with private memory guests, the guest kernel must allocate
> memory with specific constraints when sharing it with the hypervisor.
> 
> These shared memory buffers are also accessed by the host kernel, which
> means they must be aligned to the host kernel's page size.

So this is the case where the guest page size is smaller than the host
one. Just trying to understand what would go wrong if we don't do
anything here. Let's say the guest uses 4K pages and the host a 64K
pages. Within a 64K range, only a 4K is shared/decrypted. If the host
does not explicitly access the other 60K around the shared 4K, can
anything still go wrong? Is the hardware ok with speculative loads from
non-shared ranges?

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index ea84a61ed508..389070e9ee65 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -337,12 +337,14 @@ void __init bootmem_init(void)
>  
>  void __init arch_mm_preinit(void)
>  {
> +	unsigned int swiotlb_align = PAGE_SIZE;
>  	unsigned int flags = SWIOTLB_VERBOSE;
>  	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>  
>  	if (is_realm_world()) {
>  		swiotlb = true;
>  		flags |= SWIOTLB_FORCE;
> +		swiotlb_align = arch_shared_mem_alignment();
>  	}
>  
>  	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {
> @@ -356,7 +358,7 @@ void __init arch_mm_preinit(void)
>  		swiotlb = true;
>  	}
>  
> -	swiotlb_init(swiotlb, flags);
> +	swiotlb_init(swiotlb, swiotlb_align, flags);
>  	swiotlb_update_mem_attributes();

I think there's too much change just to pass down an alignment. We have
IO_TLB_MIN_SLABS, we could add an IO_TLB_MIN_ALIGN that's PAGE_SIZE by
default but can be overridden to something dynamic for arm64.

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 467cb78435a9..e2142bbca13b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -213,16 +213,20 @@ static gfp_t gfp_flags_quirk;
>  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>  					 unsigned int order)
>  {
> +	long new_order;
>  	struct page *page;
>  	int ret = 0;
>  
> -	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> +	/* align things to hypervisor page size */
> +	new_order = get_order(ALIGN((PAGE_SIZE << order), arch_shared_mem_alignment()));
> +
> +	page = alloc_pages_node(node, gfp | gfp_flags_quirk, new_order);
>  
>  	if (!page)
>  		return NULL;
>  
>  	ret = set_memory_decrypted((unsigned long)page_address(page),
> -				   1 << order);
> +				   1 << new_order);

At some point this could move to the DMA API.

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 24c359d9c879..5db5baad5efa 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -255,6 +255,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	    dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> +	if (force_dma_unencrypted(dev))
> +		/*  align to hypervisor size */
> +		size = ALIGN(size, arch_shared_mem_alignment());
>  	/* we always manually zero the memory once we are done */
>  	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);

You align the size but does __dma_direct_alloc_pages() guarantee a
natural alignment? Digging through cma_alloc_aligned(), it guarantees
the minimum of size and CONFIG_CMA_ALIGNMENT. The latter can be
configured to a page order of 2.

> @@ -382,7 +384,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  
>  	nslabs = default_nslabs;
>  	nareas = limit_nareas(default_nareas, nslabs);
> -	while ((tlb = swiotlb_memblock_alloc(nslabs, flags, remap)) == NULL) {
> +	while ((tlb = swiotlb_memblock_alloc(nslabs, alignment, flags, remap)) == NULL) {
>  		if (nslabs <= IO_TLB_MIN_SLABS)
>  			return;
>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
> @@ -417,9 +419,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		swiotlb_print_info();
>  }

We also have the dynamic swiotlb allocations via swiotlb_dyn_alloc() ->
swiotlb_alloc_pool() -> swiotlb_alloc_tlb(). I don't see any alignment
guarantees.

TBH, I'm not too keen on this patch. It feels like a problem to be
solved by the host - don't advertise smaller page sizes to guest or cope
with sub-page memory sharing. Currently the streaming DMA is handled via
bouncing but we may, at some point, just allow set_memory_decrypted() on
the DMA-mapped page. The above requirements will not allow this.

I cannot come up with a better solution though. I hope the hardware can
cope with sub-page shared/non-shared ranges.

-- 
Catalin
