Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBEB28506A;
	Mon, 12 Jan 2026 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224337; cv=none; b=cj+hHC/jIuFbUt6bHpuEEJWtK2uzCc0IYTNrkm7QAuR/G4YfclIMk4TfFXo/HCm3ykm6f15x6ZSN4wMn1L7MYNQ6IA/zELMOqGOoi7Rv1cYEjPX3/M39LaoszGo0joCOQH5NHwexW6CpaoABFTjHaN/3SY+IXhWfg3WFPrge4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224337; c=relaxed/simple;
	bh=Ob20nRWVYCw2kHmjDIHZz04i4j313QulmE2WbE6tgWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSHJTWe+Zp6uxsGUvEOcF3pNtW8+aP8ROrCtNlrZ0oA2bs3z1GfnGcmEpimCk3Bx3n7QF2r0o6l/ArKLHxWJAE9f5Dq51nOV7O/gWUWe6svgPJ+J9egJzAqzUCewwt9iYRvEqhxDZCJUPXdICDb7yFt6sUgC8qp8oiubcdG/23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 303B9497;
	Mon, 12 Jan 2026 05:25:27 -0800 (PST)
Received: from [10.57.48.115] (unknown [10.57.48.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5A223F694;
	Mon, 12 Jan 2026 05:25:32 -0800 (PST)
Message-ID: <1290fd7e-bfaf-47ce-b12f-cca0b938b293@arm.com>
Date: Mon, 12 Jan 2026 13:25:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-direct: swiotlb: Skip encryption toggles for swiotlb
 allocations
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, steven.price@arm.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20260102155448.2554240-1-aneesh.kumar@kernel.org>
 <cddcaeff-9652-4685-ba6c-0fda79bd8680@arm.com> <yq5a7btr5wii.fsf@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <yq5a7btr5wii.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-09 2:51 am, Aneesh Kumar K.V wrote:
> Robin Murphy <robin.murphy@arm.com> writes:
> 
>> On 2026-01-02 3:54 pm, Aneesh Kumar K.V (Arm) wrote:
>>> Swiotlb backing pages are already mapped decrypted via
>>> swiotlb_update_mem_attributes(), so dma-direct does not need to call
>>> set_memory_decrypted() during allocation or re-encrypt the memory on
>>> free.
>>>
>>> Handle swiotlb-backed buffers explicitly: obtain the DMA address and
>>> zero the linear mapping for lowmem pages, and bypass the decrypt/encrypt
>>> transitions when allocating/freeing from the swiotlb pool (detected via
>>> swiotlb_find_pool()).
>>
>> swiotlb_update_mem_attributes() only applies to the default SWIOTLB
>> buffer, while the dma_direct_alloc_swiotlb() path is only for private
>> restricted pools (because the whole point is that restricted DMA devices
>> cannot use the regular allocator/default pools). There is no redundancy
>> here AFAICS.
>>
> 
> But rmem_swiotlb_device_init() is also marking the entire pool decrypted
> 
> 	set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> 			     rmem->size >> PAGE_SHIFT);

OK, so why doesn't the commit message mention that instead of saying 
something which fails to justify the patch at all? ;)

Furthermore, how much does this actually matter? The "real" restricted 
DMA use-case is on systems where dma_set_decrypted() is a no-op anyway. 
I know we used restricted DMA as a hack in the early days of CCA 
prototyping, but is it intended to actually deploy that as a supported 
and recommended mechanism now?

Note also that the swiotlb_alloc path is essentially an emergency 
fallback, which doesn't work for all situations anyway - any restricted 
device that actually needs to make significant coherent allocations (or 
rather, that firmware cannot assume won't want to do so) should really 
have a proper coherent pool alongside its restricted one. The expected 
use-case here is for something like a wifi driver that only needs to 
allocate one or two small coherent buffers once at startup, then do 
everything else with streaming DMA.

Thanks,
Robin.

> 
> -aneesh
> 
>>
>> Thanks,
>> Robin.
>>
>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>> ---
>>>    kernel/dma/direct.c | 56 +++++++++++++++++++++++++++++++++++++--------
>>>    1 file changed, 46 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index faf1e41afde8..c4ef4457bd74 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -104,15 +104,27 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
>>>    	dma_free_contiguous(dev, page, size);
>>>    }
>>>    
>>> -static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
>>> +static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size,
>>> +					     dma_addr_t *dma_handle)
>>>    {
>>> -	struct page *page = swiotlb_alloc(dev, size);
>>> +	void *lm_addr;
>>> +	struct page *page;
>>> +
>>> +	page = swiotlb_alloc(dev, size);
>>> +	if (!page)
>>> +		return NULL;
>>>    
>>> -	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>>> +	if (!dma_coherent_ok(dev, page_to_phys(page), size)) {
>>>    		swiotlb_free(dev, page, size);
>>>    		return NULL;
>>>    	}
>>> +	/* If HighMem let caller take care of creating a mapping */
>>> +	if (PageHighMem(page))
>>> +		return page;
>>>    
>>> +	lm_addr = page_address(page);
>>> +	memset(lm_addr, 0, size);
>>> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>>>    	return page;
>>>    }
>>>    
>>> @@ -125,9 +137,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>>>    
>>>    	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>>>    
>>> -	if (is_swiotlb_for_alloc(dev))
>>> -		return dma_direct_alloc_swiotlb(dev, size);
>>> -
>>>    	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
>>>    	page = dma_alloc_contiguous(dev, size, gfp);
>>>    	if (page) {
>>> @@ -204,6 +213,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>    		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>>    {
>>>    	bool remap = false, set_uncached = false;
>>> +	bool mark_mem_decrypt = true;
>>>    	bool allow_highmem = true;
>>>    	struct page *page;
>>>    	void *ret;
>>> @@ -251,6 +261,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>    	    dma_direct_use_pool(dev, gfp))
>>>    		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>>>    
>>> +	if (is_swiotlb_for_alloc(dev)) {
>>> +		page = dma_direct_alloc_swiotlb(dev, size, dma_handle);
>>> +		if (page) {
>>> +			mark_mem_decrypt = false;
>>> +			goto setup_page;
>>> +		}
>>> +		return NULL;
>>> +	}
>>>    
>>>    	if (force_dma_unencrypted(dev))
>>>    		/*
>>> @@ -266,6 +284,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>    	if (!page)
>>>    		return NULL;
>>>    
>>> +setup_page:
>>>    	/*
>>>    	 * dma_alloc_contiguous can return highmem pages depending on a
>>>    	 * combination the cma= arguments and per-arch setup.  These need to be
>>> @@ -295,7 +314,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>    		ret = page_address(page);
>>>    	}
>>>    
>>> -	if (force_dma_unencrypted(dev)) {
>>> +	if (mark_mem_decrypt && force_dma_unencrypted(dev)) {
>>>    		void *lm_addr;
>>>    
>>>    		lm_addr = page_address(page);
>>> @@ -316,7 +335,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>    	return ret;
>>>    
>>>    out_encrypt_pages:
>>> -	if (dma_set_encrypted(dev, page_address(page), size))
>>> +	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
>>>    		return NULL;
>>>    out_free_pages:
>>>    	__dma_direct_free_pages(dev, page, size);
>>> @@ -328,6 +347,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>    void dma_direct_free(struct device *dev, size_t size,
>>>    		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>>>    {
>>> +	bool mark_mem_encrypted = true;
>>>    	unsigned int page_order = get_order(size);
>>>    
>>>    	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>>> @@ -356,6 +376,9 @@ void dma_direct_free(struct device *dev, size_t size,
>>>    	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>>>    		return;
>>>    
>>> +	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
>>> +		mark_mem_encrypted = false;
>>> +
>>>    	if (is_vmalloc_addr(cpu_addr)) {
>>>    		vunmap(cpu_addr);
>>>    	} else {
>>> @@ -363,7 +386,7 @@ void dma_direct_free(struct device *dev, size_t size,
>>>    			arch_dma_clear_uncached(cpu_addr, size);
>>>    	}
>>>    
>>> -	if (force_dma_unencrypted(dev)) {
>>> +	if (mark_mem_encrypted && force_dma_unencrypted(dev)) {
>>>    		void *lm_addr;
>>>    
>>>    		lm_addr = phys_to_virt(dma_to_phys(dev, dma_addr));
>>> @@ -385,6 +408,15 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>>>    	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>>>    		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>>>    
>>> +	if (is_swiotlb_for_alloc(dev)) {
>>> +		page = dma_direct_alloc_swiotlb(dev, size, dma_handle);
>>> +		if (page && PageHighMem(page)) {
>>> +			swiotlb_free(dev, page, size);
>>> +			return NULL;
>>> +		}
>>> +		return page;
>>> +	}
>>> +
>>>    	page = __dma_direct_alloc_pages(dev, size, gfp, false);
>>>    	if (!page)
>>>    		return NULL;
>>> @@ -404,13 +436,17 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>>>    		enum dma_data_direction dir)
>>>    {
>>>    	void *vaddr = page_address(page);
>>> +	bool mark_mem_encrypted = true;
>>>    
>>>    	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
>>>    	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>>>    	    dma_free_from_pool(dev, vaddr, size))
>>>    		return;
>>>    
>>> -	if (dma_set_encrypted(dev, vaddr, size))
>>> +	if (swiotlb_find_pool(dev, page_to_phys(page)))
>>> +		mark_mem_encrypted = false;
>>> +
>>> +	if (mark_mem_encrypted && dma_set_encrypted(dev, vaddr, size))
>>>    		return;
>>>    	__dma_direct_free_pages(dev, page, size);
>>>    }

