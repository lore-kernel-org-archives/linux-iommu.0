Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF051AF4D5;
	Fri,  9 Jan 2026 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927083; cv=none; b=eTXG1+gZw9tx5bhgfSnvWcfnmZ+ALTDr0EiaLKhoJExSBs6tyCk6+yla6t9e06MdFt+Q2OysCWayKZIOBA1+KufFPg/apHt74lYEfhA55CrGMD2ucwhVmIc1iblWXG0sllaVoOHiP6qmlUX6TiKuJdrYDwhTL00SmCtgSHiEGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927083; c=relaxed/simple;
	bh=Z1DkHI2EuSaenJqhG2ApGpt2HhIdds9p7J0ELsY9y9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UO3g7kb0t2wem3EJ3BikB+Txy3pzUnC6GHGGcRCDTMLhi1bs7/Hq75+uiHAPk1Vv0xeevEY93REtsA6GDL5v2rHRM2dMWivnBX9RSNkDAzrsbWH+MF49nfAj8lVb+vrbDbcUda2t1K7EZZa4ruVE1Goj8h4A/ceRGQH1R8trPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt8kzj2B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt8kzj2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D96C116C6;
	Fri,  9 Jan 2026 02:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767927083;
	bh=Z1DkHI2EuSaenJqhG2ApGpt2HhIdds9p7J0ELsY9y9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Nt8kzj2BUSa+jSW3XY66yETn5hJ3BV/CtCg/i6LyHZ9f1S19TefldRKBXXbA7qSTr
	 wPVYZKPkXy/M7CiKBfYYqJf7eMD8j5ExrDuEva/cwdoSrUsvZl6InGku29jEHxvfB9
	 feHqsXeF+iq1YvW8jfy9J8PzXEQCyH3CHRd1jxBZWyvAUUGHGszbmaVusHNZe56QBa
	 M9U7SGP1UsZLIt7qRVCfwpIaSYXMrwp/yJn0HJev0+LBFAIzq+cmXmy6Q6GC27OXSA
	 /7GxwFcCxttAl7wEC6n4NVMdCu+f1XrXAJml9VeQrRr2AOpoAY4bpK5Vu4w0w3KIdG
	 C6Qdjcbes9woQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, steven.price@arm.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] dma-direct: swiotlb: Skip encryption toggles for
 swiotlb allocations
In-Reply-To: <cddcaeff-9652-4685-ba6c-0fda79bd8680@arm.com>
References: <20260102155448.2554240-1-aneesh.kumar@kernel.org>
 <cddcaeff-9652-4685-ba6c-0fda79bd8680@arm.com>
Date: Fri, 09 Jan 2026 08:21:17 +0530
Message-ID: <yq5a7btr5wii.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Robin Murphy <robin.murphy@arm.com> writes:

> On 2026-01-02 3:54 pm, Aneesh Kumar K.V (Arm) wrote:
>> Swiotlb backing pages are already mapped decrypted via
>> swiotlb_update_mem_attributes(), so dma-direct does not need to call
>> set_memory_decrypted() during allocation or re-encrypt the memory on
>> free.
>> 
>> Handle swiotlb-backed buffers explicitly: obtain the DMA address and
>> zero the linear mapping for lowmem pages, and bypass the decrypt/encrypt
>> transitions when allocating/freeing from the swiotlb pool (detected via
>> swiotlb_find_pool()).
>
> swiotlb_update_mem_attributes() only applies to the default SWIOTLB 
> buffer, while the dma_direct_alloc_swiotlb() path is only for private 
> restricted pools (because the whole point is that restricted DMA devices 
> cannot use the regular allocator/default pools). There is no redundancy 
> here AFAICS.
>

But rmem_swiotlb_device_init() is also marking the entire pool decrypted

	set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
			     rmem->size >> PAGE_SHIFT);

-aneesh

>
> Thanks,
> Robin.
>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   kernel/dma/direct.c | 56 +++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 46 insertions(+), 10 deletions(-)
>> 
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index faf1e41afde8..c4ef4457bd74 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -104,15 +104,27 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
>>   	dma_free_contiguous(dev, page, size);
>>   }
>>   
>> -static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
>> +static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size,
>> +					     dma_addr_t *dma_handle)
>>   {
>> -	struct page *page = swiotlb_alloc(dev, size);
>> +	void *lm_addr;
>> +	struct page *page;
>> +
>> +	page = swiotlb_alloc(dev, size);
>> +	if (!page)
>> +		return NULL;
>>   
>> -	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>> +	if (!dma_coherent_ok(dev, page_to_phys(page), size)) {
>>   		swiotlb_free(dev, page, size);
>>   		return NULL;
>>   	}
>> +	/* If HighMem let caller take care of creating a mapping */
>> +	if (PageHighMem(page))
>> +		return page;
>>   
>> +	lm_addr = page_address(page);
>> +	memset(lm_addr, 0, size);
>> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>>   	return page;
>>   }
>>   
>> @@ -125,9 +137,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>>   
>>   	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>>   
>> -	if (is_swiotlb_for_alloc(dev))
>> -		return dma_direct_alloc_swiotlb(dev, size);
>> -
>>   	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
>>   	page = dma_alloc_contiguous(dev, size, gfp);
>>   	if (page) {
>> @@ -204,6 +213,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>   {
>>   	bool remap = false, set_uncached = false;
>> +	bool mark_mem_decrypt = true;
>>   	bool allow_highmem = true;
>>   	struct page *page;
>>   	void *ret;
>> @@ -251,6 +261,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   	    dma_direct_use_pool(dev, gfp))
>>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>>   
>> +	if (is_swiotlb_for_alloc(dev)) {
>> +		page = dma_direct_alloc_swiotlb(dev, size, dma_handle);
>> +		if (page) {
>> +			mark_mem_decrypt = false;
>> +			goto setup_page;
>> +		}
>> +		return NULL;
>> +	}
>>   
>>   	if (force_dma_unencrypted(dev))
>>   		/*
>> @@ -266,6 +284,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   	if (!page)
>>   		return NULL;
>>   
>> +setup_page:
>>   	/*
>>   	 * dma_alloc_contiguous can return highmem pages depending on a
>>   	 * combination the cma= arguments and per-arch setup.  These need to be
>> @@ -295,7 +314,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   		ret = page_address(page);
>>   	}
>>   
>> -	if (force_dma_unencrypted(dev)) {
>> +	if (mark_mem_decrypt && force_dma_unencrypted(dev)) {
>>   		void *lm_addr;
>>   
>>   		lm_addr = page_address(page);
>> @@ -316,7 +335,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   	return ret;
>>   
>>   out_encrypt_pages:
>> -	if (dma_set_encrypted(dev, page_address(page), size))
>> +	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
>>   		return NULL;
>>   out_free_pages:
>>   	__dma_direct_free_pages(dev, page, size);
>> @@ -328,6 +347,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   void dma_direct_free(struct device *dev, size_t size,
>>   		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>>   {
>> +	bool mark_mem_encrypted = true;
>>   	unsigned int page_order = get_order(size);
>>   
>>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>> @@ -356,6 +376,9 @@ void dma_direct_free(struct device *dev, size_t size,
>>   	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>>   		return;
>>   
>> +	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
>> +		mark_mem_encrypted = false;
>> +
>>   	if (is_vmalloc_addr(cpu_addr)) {
>>   		vunmap(cpu_addr);
>>   	} else {
>> @@ -363,7 +386,7 @@ void dma_direct_free(struct device *dev, size_t size,
>>   			arch_dma_clear_uncached(cpu_addr, size);
>>   	}
>>   
>> -	if (force_dma_unencrypted(dev)) {
>> +	if (mark_mem_encrypted && force_dma_unencrypted(dev)) {
>>   		void *lm_addr;
>>   
>>   		lm_addr = phys_to_virt(dma_to_phys(dev, dma_addr));
>> @@ -385,6 +408,15 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>>   	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>>   
>> +	if (is_swiotlb_for_alloc(dev)) {
>> +		page = dma_direct_alloc_swiotlb(dev, size, dma_handle);
>> +		if (page && PageHighMem(page)) {
>> +			swiotlb_free(dev, page, size);
>> +			return NULL;
>> +		}
>> +		return page;
>> +	}
>> +
>>   	page = __dma_direct_alloc_pages(dev, size, gfp, false);
>>   	if (!page)
>>   		return NULL;
>> @@ -404,13 +436,17 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>>   		enum dma_data_direction dir)
>>   {
>>   	void *vaddr = page_address(page);
>> +	bool mark_mem_encrypted = true;
>>   
>>   	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
>>   	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>>   	    dma_free_from_pool(dev, vaddr, size))
>>   		return;
>>   
>> -	if (dma_set_encrypted(dev, vaddr, size))
>> +	if (swiotlb_find_pool(dev, page_to_phys(page)))
>> +		mark_mem_encrypted = false;
>> +
>> +	if (mark_mem_encrypted && dma_set_encrypted(dev, vaddr, size))
>>   		return;
>>   	__dma_direct_free_pages(dev, page, size);
>>   }
