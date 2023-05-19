Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB50D10942
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 17:09:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4D9C1FB;
	Fri, 19 May 2023 10:10:37 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9653B3F59C;
	Fri, 19 May 2023 10:09:50 -0700 (PDT)
Message-ID: <30a91384-157c-0192-443c-12c835ad3b35@arm.com>
Date: Fri, 19 May 2023 18:09:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 13/15] iommu/dma: Force bouncing if the size is not
 cacheline-aligned
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
 <20230518173403.1150549-14-catalin.marinas@arm.com>
 <9dc3e036-75cd-debf-7093-177ef6c7a3ae@arm.com> <ZGeBcLVFKpLdTveZ@arm.com>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZGeBcLVFKpLdTveZ@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/05/2023 3:02 pm, Catalin Marinas wrote:
> On Fri, May 19, 2023 at 01:29:38PM +0100, Robin Murphy wrote:
>> On 2023-05-18 18:34, Catalin Marinas wrote:
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 7a9f0b0bddbd..ab1c1681c06e 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -956,7 +956,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>>>    	struct scatterlist *sg;
>>>    	int i;
>>> -	if (dev_use_swiotlb(dev))
>>> +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
>>>    		for_each_sg(sgl, sg, nelems, i)
>>>    			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>>>    						      sg->length, dir);
>>> @@ -972,7 +972,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>>>    	struct scatterlist *sg;
>>>    	int i;
>>> -	if (dev_use_swiotlb(dev))
>>> +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
>>>    		for_each_sg(sgl, sg, nelems, i)
>>>    			iommu_dma_sync_single_for_device(dev,
>>>    							 sg_dma_address(sg),
>>> @@ -998,7 +998,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>>>    	 * If both the physical buffer start address and size are
>>>    	 * page aligned, we don't need to use a bounce page.
>>>    	 */
>>> -	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
>>> +	if ((dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) ||
>>> +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
>>>    		void *padding_start;
>>>    		size_t padding_size, aligned_size;
>>> @@ -1210,7 +1211,21 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>>    			goto out;
>>>    	}
>>> -	if (dev_use_swiotlb(dev))
>>> +	/*
>>> +	 * If kmalloc() buffers are not DMA-safe for this device and
>>> +	 * direction, check the individual lengths in the sg list. If one of
>>> +	 * the buffers is deemed unsafe, follow the iommu_dma_map_sg_swiotlb()
>>> +	 * path for potential bouncing.
>>> +	 */
>>> +	if (!dma_kmalloc_safe(dev, dir)) {
>>> +		for_each_sg(sg, s, nents, i)
>>> +			if (!dma_kmalloc_size_aligned(s->length)) {
>>
>> Just to remind myself, we're not checking s->offset on the grounds that if
>> anyone wants to DMA into an unaligned part of a larger allocation that
>> remains at their own risk, is that right?
> 
> Right. That's the case currently as well and those users that were
> relying on ARCH_KMALLOC_MINALIGN for this have either been migrated to
> ARCH_DMA_MINALIGN in this series or the logic rewritten (as in the
> crypto code).

OK, I did manage to summon a vague memory of this being discussed 
before, which at least stopped me asking "Should we be checking..." - 
perhaps a comment on dma_kmalloc_safe() to help remember that reasoning 
might not go amiss?

>> Do we care about the (probably theoretical) case where someone might build a
>> scatterlist for multiple small allocations such that ones which happen to be
>> adjacent might get combined into a single segment of apparently "safe"
>> length but still at "unsafe" alignment?
> 
> I'd say that's theoretical only. One could write such code but normally
> you'd go for an array rather than relying on the randomness of the
> kmalloc pointers to figure out adjacent objects. It also only works if
> the individual struct size is exactly one of the kmalloc cache sizes, so
> not generic enough.

FWIW I was imagining something like sg_alloc_table_from_pages() but at a 
smaller scale, queueing up some list/array of, say, 32-byte buffers into 
a scatterlist to submit as a single DMA job. I'm not aware that such a 
thing exists though, and I'm inclined to agree that it probably is 
sufficiently unrealistic to be concerned about. As usual I just want to 
feel comfortable that we've explored all the possibilities :)

>>> +				sg_dma_mark_bounced(sg);
>>
>> I'd prefer to have iommu_dma_map_sg_swiotlb() mark the segments, since
>> that's in charge of the actual bouncing. Then we can fold the alignment
>> check into dev_use_swiotlb() (with the dev_is_untrusted() condition taking
>> priority), and sync/unmap can simply rely on sg_is_dma_bounced() alone.
> 
> With this patch we only set the SG_DMA_BOUNCED on the first element of
> the sglist. Do you want to set this flag only on individual elements
> being bounced? It makes some sense in principle but the
> iommu_dma_unmap_sg() path would need to scan the list again to decide
> whether to go the swiotlb path.
> 
> If we keep the SG_DMA_BOUNCED flag only on the first element, I can
> change it to your suggestion, assuming I understood it.

Indeed that should be fine - sync_sg/unmap_sg always have to be given 
the same arguments which were passed to map_sg (and note that in the 
normal case, the DMA address/length will often end up concatenated 
entirely into the first element), so while we still have the two 
distinct flows internally, I don't think there's any issue with only 
tagging the head of the list to steer between them. Of course if it then 
works out to be trivial enough to tag *all* the segments for good 
measure, there should be no harm in that either - at the moment the flag 
is destined to have more of a "this might be bounced, so needs checking" 
meaning than "this definitely is bounced" either way.

Cheers,
Robin.
