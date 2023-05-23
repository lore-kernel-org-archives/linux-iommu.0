Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98A1D2BA
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 15:48:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A929B139F;
	Tue, 23 May 2023 08:48:44 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D4603F840;
	Tue, 23 May 2023 08:47:57 -0700 (PDT)
Message-ID: <378d2261-81ec-a68a-7ba4-7602f7a335f9@arm.com>
Date: Tue, 23 May 2023 16:47:52 +0100
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
Content-Language: en-GB
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
 <30a91384-157c-0192-443c-12c835ad3b35@arm.com> <ZGsZcYvIpRD1kMlw@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZGsZcYvIpRD1kMlw@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2023 8:27 am, Catalin Marinas wrote:
> On Fri, May 19, 2023 at 06:09:45PM +0100, Robin Murphy wrote:
>> On 19/05/2023 3:02 pm, Catalin Marinas wrote:
>>> On Fri, May 19, 2023 at 01:29:38PM +0100, Robin Murphy wrote:
>>>> On 2023-05-18 18:34, Catalin Marinas wrote:
>>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>>> index 7a9f0b0bddbd..ab1c1681c06e 100644
>>>>> --- a/drivers/iommu/dma-iommu.c
>>>>> +++ b/drivers/iommu/dma-iommu.c
> [...]
>>>>> @@ -1210,7 +1211,21 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>>>>     			goto out;
>>>>>     	}
>>>>> -	if (dev_use_swiotlb(dev))
>>>>> +	/*
>>>>> +	 * If kmalloc() buffers are not DMA-safe for this device and
>>>>> +	 * direction, check the individual lengths in the sg list. If one of
>>>>> +	 * the buffers is deemed unsafe, follow the iommu_dma_map_sg_swiotlb()
>>>>> +	 * path for potential bouncing.
>>>>> +	 */
>>>>> +	if (!dma_kmalloc_safe(dev, dir)) {
>>>>> +		for_each_sg(sg, s, nents, i)
>>>>> +			if (!dma_kmalloc_size_aligned(s->length)) {
>>>>
>>>> Just to remind myself, we're not checking s->offset on the grounds that if
>>>> anyone wants to DMA into an unaligned part of a larger allocation that
>>>> remains at their own risk, is that right?
>>>
>>> Right. That's the case currently as well and those users that were
>>> relying on ARCH_KMALLOC_MINALIGN for this have either been migrated to
>>> ARCH_DMA_MINALIGN in this series or the logic rewritten (as in the
>>> crypto code).
>>
>> OK, I did manage to summon a vague memory of this being discussed before,
>> which at least stopped me asking "Should we be checking..." - perhaps a
>> comment on dma_kmalloc_safe() to help remember that reasoning might not go
>> amiss?
> 
> I'll add some notes in the comment.
> 
>>>> Do we care about the (probably theoretical) case where someone might build a
>>>> scatterlist for multiple small allocations such that ones which happen to be
>>>> adjacent might get combined into a single segment of apparently "safe"
>>>> length but still at "unsafe" alignment?
>>>
>>> I'd say that's theoretical only. One could write such code but normally
>>> you'd go for an array rather than relying on the randomness of the
>>> kmalloc pointers to figure out adjacent objects. It also only works if
>>> the individual struct size is exactly one of the kmalloc cache sizes, so
>>> not generic enough.
>>
>> FWIW I was imagining something like sg_alloc_table_from_pages() but at a
>> smaller scale, queueing up some list/array of, say, 32-byte buffers into a
>> scatterlist to submit as a single DMA job. I'm not aware that such a thing
>> exists though, and I'm inclined to agree that it probably is sufficiently
>> unrealistic to be concerned about. As usual I just want to feel comfortable
>> that we've explored all the possibilities :)
> 
> The strict approach would be to check each pointer and size (not just
> small ones) and, if unaligned, test whether it comes from a slab
> allocation and what its actual alignment is, something similar to
> ksize(). But this adds too many checks for (I think) a theoretical
> issue. We discussed this in previous iterations of this series and
> concluded to only check the size and bounce accordingly (even if we may
> bounce fully aligned slabs or miss cases like the one you mentioned).
> Anyway, we have a backup plan if we trip over something like this, just
> slightly more expensive.
> 
>>>>> +				sg_dma_mark_bounced(sg);
>>>>
>>>> I'd prefer to have iommu_dma_map_sg_swiotlb() mark the segments, since
>>>> that's in charge of the actual bouncing. Then we can fold the alignment
>>>> check into dev_use_swiotlb() (with the dev_is_untrusted() condition taking
>>>> priority), and sync/unmap can simply rely on sg_is_dma_bounced() alone.
>>>
>>> With this patch we only set the SG_DMA_BOUNCED on the first element of
>>> the sglist. Do you want to set this flag only on individual elements
>>> being bounced? It makes some sense in principle but the
>>> iommu_dma_unmap_sg() path would need to scan the list again to decide
>>> whether to go the swiotlb path.
>>>
>>> If we keep the SG_DMA_BOUNCED flag only on the first element, I can
>>> change it to your suggestion, assuming I understood it.
>>
>> Indeed that should be fine - sync_sg/unmap_sg always have to be given the
>> same arguments which were passed to map_sg (and note that in the normal
>> case, the DMA address/length will often end up concatenated entirely into
>> the first element), so while we still have the two distinct flows
>> internally, I don't think there's any issue with only tagging the head of
>> the list to steer between them. Of course if it then works out to be trivial
>> enough to tag *all* the segments for good measure, there should be no harm
>> in that either - at the moment the flag is destined to have more of a "this
>> might be bounced, so needs checking" meaning than "this definitely is
>> bounced" either way.
> 
> I renamed SG_DMA_BOUNCED to SG_DMA_USE_SWIOTLB (to match
> dev_use_swiotlb()). The past participle of bounce does make you think
> that it was definitely bounced.
> 
> Before I post a v5, does this resemble what you suggested:

Indeed; I hadn't got as far as considering optimising checks for the sg 
case, but the overall shape looks like what I was imagining. Possibly 
some naming nitpicks, but I'm not sure how much I can be bothered :)

Thanks,
Robin.

> ------8<------------------------------
>  From 6558c2bc242ea8598d16b842c8cc77105ce1d5fa Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Tue, 8 Nov 2022 11:19:31 +0000
> Subject: [PATCH] iommu/dma: Force bouncing if the size is not
>   cacheline-aligned
> 
> Similarly to the direct DMA, bounce small allocations as they may have
> originated from a kmalloc() cache not safe for DMA. Unlike the direct
> DMA, iommu_dma_map_sg() cannot call iommu_dma_map_sg_swiotlb() for all
> non-coherent devices as this would break some cases where the iova is
> expected to be contiguous (dmabuf). Instead, scan the scatterlist for
> any small sizes and only go the swiotlb path if any element of the list
> needs bouncing (note that iommu_dma_map_page() would still only bounce
> those buffers which are not DMA-aligned).
> 
> To avoid scanning the scatterlist on the 'sync' operations, introduce a
> SG_DMA_USE_SWIOTLB flag set during the iommu_dma_map_sg_swiotlb() call
> (suggested by Robin Murphy).
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/dma-iommu.c   | 50 ++++++++++++++++++++++++++++++-------
>   include/linux/scatterlist.h | 25 +++++++++++++++++--
>   2 files changed, 64 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7a9f0b0bddbd..24a8b8c2368c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -520,9 +520,38 @@ static bool dev_is_untrusted(struct device *dev)
>   	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>   }
>   
> -static bool dev_use_swiotlb(struct device *dev)
> +static bool dev_use_swiotlb(struct device *dev, size_t size,
> +			    enum dma_data_direction dir)
>   {
> -	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
> +	return IS_ENABLED(CONFIG_SWIOTLB) &&
> +		(dev_is_untrusted(dev) ||
> +		 dma_kmalloc_needs_bounce(dev, size, dir));
> +}
> +
> +static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
> +			       int nents, enum dma_data_direction dir)
> +{
> +	struct scatterlist *s;
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_SWIOTLB))
> +		return false;
> +
> +	if (dev_is_untrusted(dev))
> +		return true;
> +
> +	/*
> +	 * If kmalloc() buffers are not DMA-safe for this device and
> +	 * direction, check the individual lengths in the sg list. If any
> +	 * element is deemed unsafe, use the swiotlb for bouncing.
> +	 */
> +	if (!dma_kmalloc_safe(dev, dir)) {
> +		for_each_sg(sg, s, nents, i)
> +			if (!dma_kmalloc_size_aligned(s->length))
> +				return true;
> +	}
> +
> +	return false;
>   }
>   
>   /**
> @@ -922,7 +951,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -938,7 +967,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -956,7 +985,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (dev_use_swiotlb(dev))
> +	if (sg_is_dma_use_swiotlb(sgl))
>   		for_each_sg(sgl, sg, nelems, i)
>   			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>   						      sg->length, dir);
> @@ -972,7 +1001,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (dev_use_swiotlb(dev))
> +	if (sg_is_dma_use_swiotlb(sgl))
>   		for_each_sg(sgl, sg, nelems, i)
>   			iommu_dma_sync_single_for_device(dev,
>   							 sg_dma_address(sg),
> @@ -998,7 +1027,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	 * If both the physical buffer start address and size are
>   	 * page aligned, we don't need to use a bounce page.
>   	 */
> -	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
> +	if (dev_use_swiotlb(dev, size, dir) &&
> +	    iova_offset(iovad, phys | size)) {
>   		void *padding_start;
>   		size_t padding_size, aligned_size;
>   
> @@ -1166,6 +1196,8 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
>   	struct scatterlist *s;
>   	int i;
>   
> +	sg_dma_mark_use_swiotlb(sg);
> +
>   	for_each_sg(sg, s, nents, i) {
>   		sg_dma_address(s) = iommu_dma_map_page(dev, sg_page(s),
>   				s->offset, s->length, dir, attrs);
> @@ -1210,7 +1242,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   			goto out;
>   	}
>   
> -	if (dev_use_swiotlb(dev))
> +	if (dev_use_sg_swiotlb(dev, sg, nents, dir))
>   		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>   
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> @@ -1315,7 +1347,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	struct scatterlist *tmp;
>   	int i;
>   
> -	if (dev_use_swiotlb(dev)) {
> +	if (sg_is_dma_use_swiotlb(sg)) {
>   		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
>   		return;
>   	}
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 87aaf8b5cdb4..e0f9fea456c1 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -248,6 +248,29 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>   	sg->page_link &= ~SG_END;
>   }
>   
> +#define SG_DMA_BUS_ADDRESS	(1 << 0)
> +#define SG_DMA_USE_SWIOTLB	(1 << 1)
> +
> +#ifdef CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC
> +static inline bool sg_is_dma_use_swiotlb(struct scatterlist *sg)
> +{
> +	return sg->dma_flags & SG_DMA_USE_SWIOTLB;
> +}
> +
> +static inline void sg_dma_mark_use_swiotlb(struct scatterlist *sg)
> +{
> +	sg->dma_flags |= SG_DMA_USE_SWIOTLB;
> +}
> +#else
> +static inline bool sg_is_dma_use_swiotlb(struct scatterlist *sg)
> +{
> +	return false;
> +}
> +static inline void sg_dma_mark_use_swiotlb(struct scatterlist *sg)
> +{
> +}
> +#endif
> +
>   /*
>    * CONFIG_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
>    * in struct scatterlist (assuming also CONFIG_NEED_SG_DMA_LENGTH is set).
> @@ -256,8 +279,6 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>    */
>   #ifdef CONFIG_PCI_P2PDMA
>   
> -#define SG_DMA_BUS_ADDRESS (1 << 0)
> -
>   /**
>    * sg_dma_is_bus address - Return whether a given segment was marked
>    *			   as a bus address
