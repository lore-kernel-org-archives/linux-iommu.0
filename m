Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61D17B506;
	Mon,  8 Sep 2025 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324229; cv=none; b=iOI3H7hcaiYIgoMccOgQzo3g2B6rYZk+Xs1SqkQGVDRbSwJ2g90QSGboOEVquaRV73+L/BT9i9tpmUDt9rKGf4E2LE8g32r21DDJkyTBLfzsqOyiabLnDREQTyLNGZwowawNny/fjlYgHbd1Q3lH1JTF4M8frspqR9gaMXGhZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324229; c=relaxed/simple;
	bh=2jVn9AE2QjNTRbb9+CE7vOo9eWmwmzgndn2CK1URhkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YMteRCxKCo5seoJBCzIAvc7o3U7Olc1CQK82v2/e5NCcDElxoFnuuP0zPjCFQbI4dMIzVZ08xyzML6K8/yGdK12abgGpxbPtyaM29E/PPa10Mo3ofRZaH9ddYwRmehBdG4iV/WRpsD7vUYz6sykhXJW4jyEGgAh61eGU7tzF1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLJxgK6t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLJxgK6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03872C4CEF1;
	Mon,  8 Sep 2025 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757324228;
	bh=2jVn9AE2QjNTRbb9+CE7vOo9eWmwmzgndn2CK1URhkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nLJxgK6ty8OyyYcXET93QHr+IdZNNU5Zlf2crSGADPHxsw1GV5o9Xk2CbUMHNYLrj
	 TQPFMEFyulMFG/uB32BSptFhZv3asjecGT39TPQKl1aFPJYSL4N9D1B1v/fQL2OSY9
	 t2xSVtEEVXsieKWw7T8pKD6/0dZh/gNiEXmrsUnqCPEhRTaJX4UN/YWGKQajxE9pGc
	 px4RVDzXuPwiHo012HmYqHTdDEqIXwt68U+HkBHHNu2MNE65yY9h2LzyOpU62MxXS3
	 46dnRl+3ZYpSgv5X1N/YXTxXwL+dNoAhdqS03X1Fr5GMMk24Ihu1nl3YQwKLeS4/eP
	 p8J1ryKkkYyRQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, suzuki.poulose@arm.com,
	akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
In-Reply-To: <aLrh_rbzWLPw9LnH@arm.com>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
Date: Mon, 08 Sep 2025 15:07:00 +0530
Message-ID: <yq5aikht1e0z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> Hi Aneesh,
>
> On Fri, Sep 05, 2025 at 11:24:41AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> When running with private memory guests, the guest kernel must allocate
>> memory with specific constraints when sharing it with the hypervisor.
>> 
>> These shared memory buffers are also accessed by the host kernel, which
>> means they must be aligned to the host kernel's page size.
>
> So this is the case where the guest page size is smaller than the host
> one. Just trying to understand what would go wrong if we don't do
> anything here. Let's say the guest uses 4K pages and the host a 64K
> pages. Within a 64K range, only a 4K is shared/decrypted. If the host
> does not explicitly access the other 60K around the shared 4K, can
> anything still go wrong? Is the hardware ok with speculative loads from
> non-shared ranges?
>

With features like guest_memfd, the goal is to explicitly prevent the
host from mapping private memory, rather than relying on the host to
avoid accessing those regions.

As per Arm ARM:
RVJLXG: Accesses are checked against the GPC configuration for the
physical granule being accessed, regardless of the stage 1 and stage 2
translation configuration.

For example, if GPCCR_EL3.PGS is configured to a smaller granule size
than the configured stage 1 and stage 2 translation granule size,
accesses are checked at the GPCCR_EL3.PGS granule size.

>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index ea84a61ed508..389070e9ee65 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -337,12 +337,14 @@ void __init bootmem_init(void)
>>  
>>  void __init arch_mm_preinit(void)
>>  {
>> +	unsigned int swiotlb_align = PAGE_SIZE;
>>  	unsigned int flags = SWIOTLB_VERBOSE;
>>  	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>>  
>>  	if (is_realm_world()) {
>>  		swiotlb = true;
>>  		flags |= SWIOTLB_FORCE;
>> +		swiotlb_align = arch_shared_mem_alignment();
>>  	}
>>  
>>  	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {
>> @@ -356,7 +358,7 @@ void __init arch_mm_preinit(void)
>>  		swiotlb = true;
>>  	}
>>  
>> -	swiotlb_init(swiotlb, flags);
>> +	swiotlb_init(swiotlb, swiotlb_align, flags);
>>  	swiotlb_update_mem_attributes();
>
> I think there's too much change just to pass down an alignment. We have
> IO_TLB_MIN_SLABS, we could add an IO_TLB_MIN_ALIGN that's PAGE_SIZE by
> default but can be overridden to something dynamic for arm64.
>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 467cb78435a9..e2142bbca13b 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -213,16 +213,20 @@ static gfp_t gfp_flags_quirk;
>>  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>>  					 unsigned int order)
>>  {
>> +	long new_order;
>>  	struct page *page;
>>  	int ret = 0;
>>  
>> -	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
>> +	/* align things to hypervisor page size */
>> +	new_order = get_order(ALIGN((PAGE_SIZE << order), arch_shared_mem_alignment()));
>> +
>> +	page = alloc_pages_node(node, gfp | gfp_flags_quirk, new_order);
>>  
>>  	if (!page)
>>  		return NULL;
>>  
>>  	ret = set_memory_decrypted((unsigned long)page_address(page),
>> -				   1 << order);
>> +				   1 << new_order);
>
> At some point this could move to the DMA API.
>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 24c359d9c879..5db5baad5efa 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -255,6 +255,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>  	    dma_direct_use_pool(dev, gfp))
>>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>>  
>> +	if (force_dma_unencrypted(dev))
>> +		/*  align to hypervisor size */
>> +		size = ALIGN(size, arch_shared_mem_alignment());
>>  	/* we always manually zero the memory once we are done */
>>  	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
>
> You align the size but does __dma_direct_alloc_pages() guarantee a
> natural alignment? Digging through cma_alloc_aligned(), it guarantees
> the minimum of size and CONFIG_CMA_ALIGNMENT. The latter can be
> configured to a page order of 2.
>

I will check this.

>
>> @@ -382,7 +384,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>>  
>>  	nslabs = default_nslabs;
>>  	nareas = limit_nareas(default_nareas, nslabs);
>> -	while ((tlb = swiotlb_memblock_alloc(nslabs, flags, remap)) == NULL) {
>> +	while ((tlb = swiotlb_memblock_alloc(nslabs, alignment, flags, remap)) == NULL) {
>>  		if (nslabs <= IO_TLB_MIN_SLABS)
>>  			return;
>>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
>> @@ -417,9 +419,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>>  		swiotlb_print_info();
>>  }
>
> We also have the dynamic swiotlb allocations via swiotlb_dyn_alloc() ->
> swiotlb_alloc_pool() -> swiotlb_alloc_tlb(). I don't see any alignment
> guarantees.
>
> TBH, I'm not too keen on this patch. It feels like a problem to be
> solved by the host - don't advertise smaller page sizes to guest or cope
> with sub-page memory sharing. Currently the streaming DMA is handled via
> bouncing but we may, at some point, just allow set_memory_decrypted() on
> the DMA-mapped page. The above requirements will not allow this.
>
> I cannot come up with a better solution though. I hope the hardware can
> cope with sub-page shared/non-shared ranges.
>

-aneesh
