Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91048C07E96
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 15:43:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E93616E8
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 15:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E93616E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F040C60B6F;
	Thu,  8 Jul 2021 15:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KkT4DaZE-mjA; Thu,  8 Jul 2021 15:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7CECB6061A;
	Thu,  8 Jul 2021 15:43:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 394A3C0010;
	Thu,  8 Jul 2021 15:43:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 022BFC000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 15:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2B5740381
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 15:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id je-llJbbsatV for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 15:43:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0360540364
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 15:43:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ECAAED1;
 Thu,  8 Jul 2021 08:43:07 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3B433F66F;
 Thu,  8 Jul 2021 08:43:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] dma-iommu: fix swiotlb SKIP_CPU_SYNC and arch sync
To: Joerg Roedel <joro@8bytes.org>, David Stevens <stevensd@chromium.org>
References: <20210702053742.842850-1-stevensd@google.com>
 <YObCtaW2UPii7mUL@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3f63e831-72a2-6482-aeea-7c8e84228b8c@arm.com>
Date: Thu, 8 Jul 2021 16:43:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YObCtaW2UPii7mUL@8bytes.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-07-08 10:17, Joerg Roedel wrote:
> Adding Robin.
> 
> On Fri, Jul 02, 2021 at 02:37:41PM +0900, David Stevens wrote:
>> From: David Stevens <stevensd@chromium.org>
>>
>> Make map_swiotlb and unmap_swiotlb only for mapping, and consistently
>> use sync_single_for and sync_sg_for functions for swiotlb sync and arch
>> sync. This ensures that the same code path is responsible for syncing
>> regardless of whether or not SKIP_CPU_SYNC is set. In the process, fix
>> various places where the original physical address and swiotlb tlb_addr
>> are mixed up:
>>    - Make sync_sg functions call sync_single functions for untrusted
>>      devices, so they use tlb_addr when checking is_swiotlb_buffer and
>>      when doing arch sync if necessary.
>>    - Use tlb_addr for arch sync in map_page if necessary.
>>    - In map_sg, map before syncing so that arch sync can target the
>>      bounce buffer if necessary.
>>    - Pass SKIP_CPU_SYNC to swiotlb map and unmap to avoid double syncing
>>      the swiotlb. This had previously only happened in the unmap_page
>>      case, but is now necessary for all swiotlb cases.
>>
>> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")

Hmm, there's a lot going on here, and it's not really clear to me what's 
what, especially WRT the comment about addresses being mixed up. Is 
there an actual correctness bug anywhere, i.e. an address which *should* 
be synced *isn't*? If so, please fix that minimally in a standalone 
patch without all the additional complication. If it's purely an 
efficiency improvement - i.e. the bounce page getting synced twice 
(which shouldn't have *too* much impact) or the original copy geting 
redundantly synced *as well* as the bounce page, then please clarify 
whether you've measured significant impact in practice or if this is 
just an observation from code inspection.

TBH I don't find the overall justification in the commit message 
particularly convincing - to a less generous reading it kind of comes 
across as "move things around for the sake of it". Yes one can argue for 
keeping all the cache maintenance in one place, but one can equally 
argue for the keeping all the low-level practicalities of bouncing under 
SWIOTLB's umbrella such that it doesn't clutter up the IOMMU-focused 
code. The point of utilising the SWIOTLB machinery in the first place 
was to share and reuse as much of its "normal" flow as possible to keep 
things simple (see the thread at [1] for where the history began).

Now, what is true is that the integration into iommu-dma is a bit rough 
and bolted-on in places. IIRC it was done expediently to un-block 
further development on the Intel driver, and it was always the plan to 
come back and improve it later (like only bouncing the unaligned start 
and end of larger buffers such that whole pages in the middle can still 
be mapped in-place). As such I'm very happy to see that someone has the 
time and interest to improve things, but some of this patch looks like 
adding more mess to work around the existing mess, rather than more 
fundamentally cleaning it up. For example, rather than further cementing 
the bodge of having two separate map_sg implementations, I think the 
bouncing could be streamlined into iommu-dma's own flow as part of its 
scatterlist transformation (AFAICS temporarily swizzling sg_page so that 
iommu_map_sg() maps the bounced copy would be no worse than what it's 
already doing).

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/20190312163845.GA13141@infradead.org/

>> Signed-off-by: David Stevens <stevensd@chromium.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 82 ++++++++++++++++++++++++---------------
>>   1 file changed, 51 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 7bcdd1205535..24d1042cd052 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -505,7 +505,8 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
>>   	__iommu_dma_unmap(dev, dma_addr, size);
>>   
>>   	if (unlikely(is_swiotlb_buffer(phys)))
>> -		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
>> +		swiotlb_tbl_unmap_single(dev, phys, size, dir,
>> +					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
>>   }
>>   
>>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>> @@ -536,7 +537,8 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>>   
>>   static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>>   		size_t org_size, dma_addr_t dma_mask, bool coherent,
>> -		enum dma_data_direction dir, unsigned long attrs)
>> +		enum dma_data_direction dir, unsigned long attrs,
>> +		phys_addr_t *adj_phys)
>>   {
>>   	int prot = dma_info_to_prot(dir, coherent, attrs);
>>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>> @@ -555,7 +557,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>>   	    iova_offset(iovad, phys | org_size)) {
>>   		aligned_size = iova_align(iovad, org_size);
>>   		phys = swiotlb_tbl_map_single(dev, phys, org_size,
>> -					      aligned_size, dir, attrs);
>> +					      aligned_size, dir,
>> +					      attrs | DMA_ATTR_SKIP_CPU_SYNC);
>>   
>>   		if (phys == DMA_MAPPING_ERROR)
>>   			return DMA_MAPPING_ERROR;
>> @@ -573,6 +576,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>>   
>>   		memset(padding_start, 0, padding_size);
>>   	}
>> +	if (adj_phys)
>> +		*adj_phys = phys;
>>   
>>   	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
>>   	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
>> @@ -785,15 +790,17 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>>   		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
>>   }
>>   
>> -static void iommu_dma_sync_single_for_device(struct device *dev,
>> -		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>> +static void __iommu_dma_sync_single_for_device(struct device *dev,
>> +		dma_addr_t dma_handle, size_t size,
>> +		enum dma_data_direction dir, phys_addr_t phys)
>>   {
>> -	phys_addr_t phys;
>> -
>>   	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
>>   		return;
>>   
>> -	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
>> +	if (phys == 0)
>> +		phys = iommu_iova_to_phys(iommu_get_dma_domain(dev),
>> +					  dma_handle);
>> +
>>   	if (is_swiotlb_buffer(phys))
>>   		swiotlb_sync_single_for_device(dev, phys, size, dir);
>>   
>> @@ -801,6 +808,12 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
>>   		arch_sync_dma_for_device(phys, size, dir);
>>   }
>>   
>> +static void iommu_dma_sync_single_for_device(struct device *dev,
>> +		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>> +{
>> +	__iommu_dma_sync_single_for_device(dev, dma_handle, size, dir, 0);
>> +}
>> +
>>   static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>>   		struct scatterlist *sgl, int nelems,
>>   		enum dma_data_direction dir)
>> @@ -811,14 +824,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>>   	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
>>   		return;
>>   
>> -	for_each_sg(sgl, sg, nelems, i) {
>> -		if (!dev_is_dma_coherent(dev))
>> +	if (dev_is_untrusted(dev))
>> +		for_each_sg(sgl, sg, nelems, i)
>> +			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>> +						      sg->length, dir);
>> +	else
>> +		for_each_sg(sgl, sg, nelems, i)
>>   			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
>> -
>> -		if (is_swiotlb_buffer(sg_phys(sg)))
>> -			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
>> -						    sg->length, dir);
>> -	}
>>   }
>>   
>>   static void iommu_dma_sync_sg_for_device(struct device *dev,
>> @@ -831,29 +843,30 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>>   	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
>>   		return;
>>   
>> -	for_each_sg(sgl, sg, nelems, i) {
>> -		if (is_swiotlb_buffer(sg_phys(sg)))
>> -			swiotlb_sync_single_for_device(dev, sg_phys(sg),
>> -						       sg->length, dir);
>> -
>> -		if (!dev_is_dma_coherent(dev))
>> +	if (dev_is_untrusted(dev))
>> +		for_each_sg(sgl, sg, nelems, i)
>> +			__iommu_dma_sync_single_for_device(dev,
>> +							   sg_dma_address(sg),
>> +							   sg->length, dir, 0);
>> +	else
>> +		for_each_sg(sgl, sg, nelems, i)
>>   			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
>> -	}
>>   }
>>   
>>   static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>>   		unsigned long offset, size_t size, enum dma_data_direction dir,
>>   		unsigned long attrs)
>>   {
>> -	phys_addr_t phys = page_to_phys(page) + offset;
>> +	phys_addr_t phys = page_to_phys(page) + offset, adj_phys;
>>   	bool coherent = dev_is_dma_coherent(dev);
>>   	dma_addr_t dma_handle;
>>   
>> -	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
>> -			coherent, dir, attrs);
>> -	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>> +	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size,
>> +			dma_get_mask(dev), coherent, dir, attrs, &adj_phys);
>> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>>   	    dma_handle != DMA_MAPPING_ERROR)
>> -		arch_sync_dma_for_device(phys, size, dir);
>> +		__iommu_dma_sync_single_for_device(dev, dma_handle, size,
>> +						   dir, adj_phys);
>>   	return dma_handle;
>>   }
>>   
>> @@ -960,7 +973,7 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
>>   	for_each_sg(sg, s, nents, i) {
>>   		sg_dma_address(s) = __iommu_dma_map_swiotlb(dev, sg_phys(s),
>>   				s->length, dma_get_mask(dev),
>> -				dev_is_dma_coherent(dev), dir, attrs);
>> +				dev_is_dma_coherent(dev), dir, attrs, NULL);
>>   		if (sg_dma_address(s) == DMA_MAPPING_ERROR)
>>   			goto out_unmap;
>>   		sg_dma_len(s) = s->length;
>> @@ -991,17 +1004,24 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   	dma_addr_t iova;
>>   	size_t iova_len = 0;
>>   	unsigned long mask = dma_get_seg_boundary(dev);
>> -	int i;
>> +	int i, early_mapped = 0;
>>   
>>   	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>>   	    iommu_deferred_attach(dev, domain))
>>   		return 0;
>>   
>> +	if (dev_is_untrusted(dev)) {
>> +		early_mapped = iommu_dma_map_sg_swiotlb(dev, sg, nents,
>> +							dir, attrs);
>> +		if (!early_mapped)
>> +			return 0;
>> +	}
>> +
>>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>>   		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
>>   
>> -	if (dev_is_untrusted(dev))
>> -		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>> +	if (early_mapped)
>> +		return early_mapped;
>>   
>>   	/*
>>   	 * Work out how much IOVA space we need, and align the segments to
>> -- 
>> 2.32.0.93.g670b81a890-goog
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
