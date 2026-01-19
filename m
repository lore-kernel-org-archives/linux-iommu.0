Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D232938A;
	Mon, 19 Jan 2026 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840630; cv=none; b=h8dXASxP7RgayJYtn//HXo4f6M3GXWADncqVuC3k3Nu4K+zu3G812X7eAFQoemNbBYvoxfg5d//m2fCXwXMiW1YOW5baiMJovkfXQ/CoQYK/ZJMO/CBrjZ+hArFzQn0Ae8VPY06F7sPAmjRJjlwaESciWG8KRhkNMhP2cDNL72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840630; c=relaxed/simple;
	bh=ub+qAJDLLb1fhmiDbV2qAjHDOewnGOLItmEQMfTdU2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXT92x5SJLLRLrb5Y/W6dw2fTKT8p2ERBRWGaOcR6jGq5u1VNf9VO8PthNTFWAfJ5fthIb5h4UrGHKF3Yt+L5XlFOJDhMwG9PWsXlX7vUwi5BYxwMJqDgAN5qSTDXmFJAwufAZ23StLWfjt2LfOzScN/rSZsKXKcA3pmIEyVEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C7FB497;
	Mon, 19 Jan 2026 08:37:01 -0800 (PST)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6F683F632;
	Mon, 19 Jan 2026 08:37:06 -0800 (PST)
Message-ID: <4f42d3b1-9eef-417b-9937-36578f5db6de@arm.com>
Date: Mon, 19 Jan 2026 16:37:05 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-direct: swiotlb: Skip encryption toggles for swiotlb
 allocations
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: steven.price@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Claire Chang <tientzu@chromium.org>
References: <20260102155448.2554240-1-aneesh.kumar@kernel.org>
 <cddcaeff-9652-4685-ba6c-0fda79bd8680@arm.com> <yq5a7btr5wii.fsf@kernel.org>
 <1290fd7e-bfaf-47ce-b12f-cca0b938b293@arm.com> <yq5acy3eet1b.fsf@kernel.org>
 <CGME20260114094941eucas1p2b2985accee8c2eb5ccd48f94463adffa@eucas1p2.samsung.com>
 <yq5aldi0cyms.fsf@kernel.org>
 <0ad7a059-8c51-4d26-9d7e-055abb702b66@samsung.com>
 <3110c452-22d7-453f-bc60-7578b2458089@arm.com> <yq5a8qdtlht8.fsf@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <yq5a8qdtlht8.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/01/2026 3:53 pm, Aneesh Kumar K.V wrote:
> Robin Murphy <robin.murphy@arm.com> writes:
> 
>> On 19/01/2026 9:52 am, Marek Szyprowski wrote:
>>> On 14.01.2026 10:49, Aneesh Kumar K.V wrote:
>>>> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>>> On 2026-01-09 2:51 am, Aneesh Kumar K.V wrote:
>>>>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>>>>> On 2026-01-02 3:54 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>>>>>> Swiotlb backing pages are already mapped decrypted via
>>>>>>>>> swiotlb_update_mem_attributes(), so dma-direct does not need to call
>>>>>>>>> set_memory_decrypted() during allocation or re-encrypt the memory on
>>>>>>>>> free.
>>>>>>>>>
>>>>>>>>> Handle swiotlb-backed buffers explicitly: obtain the DMA address and
>>>>>>>>> zero the linear mapping for lowmem pages, and bypass the decrypt/encrypt
>>>>>>>>> transitions when allocating/freeing from the swiotlb pool (detected via
>>>>>>>>> swiotlb_find_pool()).
>>>>>>>> swiotlb_update_mem_attributes() only applies to the default SWIOTLB
>>>>>>>> buffer, while the dma_direct_alloc_swiotlb() path is only for private
>>>>>>>> restricted pools (because the whole point is that restricted DMA devices
>>>>>>>> cannot use the regular allocator/default pools). There is no redundancy
>>>>>>>> here AFAICS.
>>>>>>>>
>>>>>>> But rmem_swiotlb_device_init() is also marking the entire pool decrypted
>>>>>>>
>>>>>>> 	set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>>>>>>> 			     rmem->size >> PAGE_SHIFT);
>>>>>> OK, so why doesn't the commit message mention that instead of saying
>>>>>> something which fails to justify the patch at all? ;)
>>>>>>
>>>>>> Furthermore, how much does this actually matter? The "real" restricted
>>>>>> DMA use-case is on systems where dma_set_decrypted() is a no-op anyway.
>>>>>> I know we used restricted DMA as a hack in the early days of CCA
>>>>>> prototyping, but is it intended to actually deploy that as a supported
>>>>>> and recommended mechanism now?
>>>>>>
>>>>>> Note also that the swiotlb_alloc path is essentially an emergency
>>>>>> fallback, which doesn't work for all situations anyway - any restricted
>>>>>> device that actually needs to make significant coherent allocations (or
>>>>>> rather, that firmware cannot assume won't want to do so) should really
>>>>>> have a proper coherent pool alongside its restricted one. The expected
>>>>>> use-case here is for something like a wifi driver that only needs to
>>>>>> allocate one or two small coherent buffers once at startup, then do
>>>>>> everything else with streaming DMA.
>>>>> I was aiming to bring more consistency in how swiotlb buffers are
>>>>> handled, specifically by treating all swiotlb memory as decrypted
>>>>> buffers, which is also how the current code behaves.
>>>>>
>>>>> If we are concluding that restricted DMA is not used in conjunction with
>>>>> memory encryption, then we could, in fact, remove the
>>>>> set_memory_decrypted() call from rmem_swiotlb_device_init() and
>>>>> instead add failure conditions for force_dma_unencrypted(dev) in
>>>>> is_swiotlb_for_alloc(). However, it’s worth noting that the initial
>>>>> commit did take the memory encryption feature into account
>>>>> (0b84e4f8b793eb4045fd64f6f514165a7974cd16).
>>>>>
>>>>> Please let me know if you think this needs to be fixed.
>>>> Something like.
>>>>
>>>> dma-direct: restricted-dma: Do not mark the restricted DMA pool unencrypted
>>>>
>>>> As per commit f4111e39a52a ("swiotlb: Add restricted DMA alloc/free
>>>> support"), the restricted-dma-pool is used in conjunction with the
>>>> shared-dma-pool. Since allocations from the shared-dma-pool are not
>>>> marked unencrypted, skip marking the restricted-dma-pool as unencrypted
>>>> as well. We do not expect systems using the restricted-dma-pool to have
>>>> memory encryption or to run with confidential computing features enabled.
>>>>
>>>> If a device requires unencrypted access (force_dma_unencrypted(dev)),
>>>> the dma-direct allocator will mark the restricted-dma-pool allocation as
>>>> unencrypted.
>>>>
>>>> The only disadvantage is that, when running on a CC guest with a
>>>> different hypervisor page size, restricted-dma-pool allocation sizes
>>>> must now be aligned to the hypervisor page size. This alignment would
>>>> not be required if the entire pool were marked unencrypted. However, the
>>>> new code enables the use of the restricted-dma-pool for trusted devices.
>>>> Previously, because the entire pool was marked unencrypted, trusted
>>>> devices were unable to allocate from it.
>>>>
>>>> There is still an open question regarding allocations from the
>>>> shared-dma-pool. Currently, they are not marked unencrypted.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>>>
>>>> 1 file changed, 2 deletions(-)
>>>> kernel/dma/swiotlb.c | 2 --
>>>>
>>>> modified   kernel/dma/swiotlb.c
>>>> @@ -1835,8 +1835,6 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>>>>     			return -ENOMEM;
>>>>     		}
>>>>     
>>>> -		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>>>> -				     rmem->size >> PAGE_SHIFT);
>>>>     		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
>>>>     					 false, nareas);
>>>>     		mem->force_bounce = true;
>>>
>>> Robin, could You review this? Is it ready for applying?
>>
>> But wouldn't this break the actual intended use of restricted pools for
>> streaming DMA bouncing, which does depend on the buffer being
>> pre-decrypted/shared? (Since streaming DMA mappings definitely need to
>> be supported in nowait contexts)
>>
> 
> Only if we are using a restricted pool with encrypted memory.
> 
> If we assume that swiotlb bounce buffers are always decrypted, then
> allocations from that pool can safely skip the decrypt/encrypt
> transitions. However, we still need to address coherent allocations via
> the shared-dma-pool, which are explicitly marked as unencrypted.
> 
> Given this, I’m wondering whether the best approach is to revisit the
> original patch I posted, which moved swiotlb allocations out of
> __dma_direct_alloc_pages(). With that separation in place, we could then
> fix up dma_alloc_from_dev_coherent() accordingly.
> 
> If the conclusion is that systems with encrypted memory will, in
> practice, never use restricted-dma-pool or shared-dma-pool, then we can
> take this patch?

But if the conclusion is that it doesn't matter then that can only mean
we don't need this patch either.

We've identified that the combination of restricted DMA and a
"meaningful" memory encryption API is theoretically slightly broken and
can't ever have worked properly, so how do we benefit from churning it
to just be theoretically more broken in a different way? That makes even
less sense than invasive churn to "fix" the theoretical problem that
hasn't been an issue in practice.

> If you can suggest the approach you would like to see taken with
> restricted-dma-pool/shared-dma-pool, I can work on the final change.

TBH my first choice is "do nothing"; second would be something like the
below, then wait and see if any future CoCo development does justify
changing our expectations.

Thanks,
Robin.

----->8-----

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a547c7693135..3786a81eac40 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1784,6 +1784,10 @@ bool swiotlb_free(struct device *dev, struct page *page, size_t size)
  
  	swiotlb_release_slots(dev, tlb_addr, pool);
  
+	/* We really don't expect this combination, and making it work is a pain */
+	dev_WARN_ONCE(dev, cc_platform_has(CC_ATTR_MEM_ENCRYPT)),
+		      "Freeing coherent allocation potentially corrupts restricted DMA pool\n");
+
  	return true;
  }
  

