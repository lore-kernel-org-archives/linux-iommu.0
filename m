Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C770235B15F;
	Mon, 19 Jan 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832918; cv=none; b=o5X+RAWtGLyLmeskw3xHa8DSdy5KJS/Ab2PGpm0FhJ/zvbgySYdtAxhACKgqh3VKv+fyHDbHN4AZGCCF49fE9Cvyh0U0u4nRNgQkxUKvA63vouixeOSN/iBRwnQWOSMtcVbX3zoGl4+alicfgLi0qolZ6B1W64B2olAQiqwbDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832918; c=relaxed/simple;
	bh=ve+Hz0ZxHCZpnZdkG3b0WTI75EsvXcb7rVB7KGcU8Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j801Hma7VIHegKKkwjCkqiLqCSJSvOJgnrQWh9VZKvdEONMxTQ17HYuH4osozKitGuWZDBMn4tz4nbFgnoJWCa6lhuTezh7ADdbwjaFxbmw4gDLSfTV062Efz6vPPiSKyhUPOIe62ok14nIA5ll2cizM6eE+RAtLoBrVxMfgZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF26497;
	Mon, 19 Jan 2026 06:28:29 -0800 (PST)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A5783F632;
	Mon, 19 Jan 2026 06:28:26 -0800 (PST)
Message-ID: <3110c452-22d7-453f-bc60-7578b2458089@arm.com>
Date: Mon, 19 Jan 2026 14:28:25 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-direct: swiotlb: Skip encryption toggles for swiotlb
 allocations
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: steven.price@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Claire Chang <tientzu@chromium.org>
References: <20260102155448.2554240-1-aneesh.kumar@kernel.org>
 <cddcaeff-9652-4685-ba6c-0fda79bd8680@arm.com> <yq5a7btr5wii.fsf@kernel.org>
 <1290fd7e-bfaf-47ce-b12f-cca0b938b293@arm.com> <yq5acy3eet1b.fsf@kernel.org>
 <CGME20260114094941eucas1p2b2985accee8c2eb5ccd48f94463adffa@eucas1p2.samsung.com>
 <yq5aldi0cyms.fsf@kernel.org>
 <0ad7a059-8c51-4d26-9d7e-055abb702b66@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0ad7a059-8c51-4d26-9d7e-055abb702b66@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/01/2026 9:52 am, Marek Szyprowski wrote:
> On 14.01.2026 10:49, Aneesh Kumar K.V wrote:
>> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>> On 2026-01-09 2:51 am, Aneesh Kumar K.V wrote:
>>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>>> On 2026-01-02 3:54 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>>>> Swiotlb backing pages are already mapped decrypted via
>>>>>>> swiotlb_update_mem_attributes(), so dma-direct does not need to call
>>>>>>> set_memory_decrypted() during allocation or re-encrypt the memory on
>>>>>>> free.
>>>>>>>
>>>>>>> Handle swiotlb-backed buffers explicitly: obtain the DMA address and
>>>>>>> zero the linear mapping for lowmem pages, and bypass the decrypt/encrypt
>>>>>>> transitions when allocating/freeing from the swiotlb pool (detected via
>>>>>>> swiotlb_find_pool()).
>>>>>> swiotlb_update_mem_attributes() only applies to the default SWIOTLB
>>>>>> buffer, while the dma_direct_alloc_swiotlb() path is only for private
>>>>>> restricted pools (because the whole point is that restricted DMA devices
>>>>>> cannot use the regular allocator/default pools). There is no redundancy
>>>>>> here AFAICS.
>>>>>>
>>>>> But rmem_swiotlb_device_init() is also marking the entire pool decrypted
>>>>>
>>>>> 	set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>>>>> 			     rmem->size >> PAGE_SHIFT);
>>>> OK, so why doesn't the commit message mention that instead of saying
>>>> something which fails to justify the patch at all? ;)
>>>>
>>>> Furthermore, how much does this actually matter? The "real" restricted
>>>> DMA use-case is on systems where dma_set_decrypted() is a no-op anyway.
>>>> I know we used restricted DMA as a hack in the early days of CCA
>>>> prototyping, but is it intended to actually deploy that as a supported
>>>> and recommended mechanism now?
>>>>
>>>> Note also that the swiotlb_alloc path is essentially an emergency
>>>> fallback, which doesn't work for all situations anyway - any restricted
>>>> device that actually needs to make significant coherent allocations (or
>>>> rather, that firmware cannot assume won't want to do so) should really
>>>> have a proper coherent pool alongside its restricted one. The expected
>>>> use-case here is for something like a wifi driver that only needs to
>>>> allocate one or two small coherent buffers once at startup, then do
>>>> everything else with streaming DMA.
>>> I was aiming to bring more consistency in how swiotlb buffers are
>>> handled, specifically by treating all swiotlb memory as decrypted
>>> buffers, which is also how the current code behaves.
>>>
>>> If we are concluding that restricted DMA is not used in conjunction with
>>> memory encryption, then we could, in fact, remove the
>>> set_memory_decrypted() call from rmem_swiotlb_device_init() and
>>> instead add failure conditions for force_dma_unencrypted(dev) in
>>> is_swiotlb_for_alloc(). However, it’s worth noting that the initial
>>> commit did take the memory encryption feature into account
>>> (0b84e4f8b793eb4045fd64f6f514165a7974cd16).
>>>
>>> Please let me know if you think this needs to be fixed.
>> Something like.
>>
>> dma-direct: restricted-dma: Do not mark the restricted DMA pool unencrypted
>>
>> As per commit f4111e39a52a ("swiotlb: Add restricted DMA alloc/free
>> support"), the restricted-dma-pool is used in conjunction with the
>> shared-dma-pool. Since allocations from the shared-dma-pool are not
>> marked unencrypted, skip marking the restricted-dma-pool as unencrypted
>> as well. We do not expect systems using the restricted-dma-pool to have
>> memory encryption or to run with confidential computing features enabled.
>>
>> If a device requires unencrypted access (force_dma_unencrypted(dev)),
>> the dma-direct allocator will mark the restricted-dma-pool allocation as
>> unencrypted.
>>
>> The only disadvantage is that, when running on a CC guest with a
>> different hypervisor page size, restricted-dma-pool allocation sizes
>> must now be aligned to the hypervisor page size. This alignment would
>> not be required if the entire pool were marked unencrypted. However, the
>> new code enables the use of the restricted-dma-pool for trusted devices.
>> Previously, because the entire pool was marked unencrypted, trusted
>> devices were unable to allocate from it.
>>
>> There is still an open question regarding allocations from the
>> shared-dma-pool. Currently, they are not marked unencrypted.
>>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>
>> 1 file changed, 2 deletions(-)
>> kernel/dma/swiotlb.c | 2 --
>>
>> modified   kernel/dma/swiotlb.c
>> @@ -1835,8 +1835,6 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>>    			return -ENOMEM;
>>    		}
>>    
>> -		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>> -				     rmem->size >> PAGE_SHIFT);
>>    		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
>>    					 false, nareas);
>>    		mem->force_bounce = true;
> 
> Robin, could You review this? Is it ready for applying?

But wouldn't this break the actual intended use of restricted pools for 
streaming DMA bouncing, which does depend on the buffer being 
pre-decrypted/shared? (Since streaming DMA mappings definitely need to 
be supported in nowait contexts)

Thanks,
Robin.
