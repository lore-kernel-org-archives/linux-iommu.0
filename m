Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F2366
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914087; cv=none; b=GFJYiOxikEaw/oTnrCjPUPeN/CPZ2h2PzL6UC70gckS88f8agkE4pFaoXAGGCGycsECbk6iFtskHIWiILtViqmgv7srqyXaRJ2Ca8Y7F3o4YrlPwkvTpTETs4aneyjxJkOjHQRtVePmTVhf3nLW0z/z609MQYe9eRFgtAA3UCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914087; c=relaxed/simple;
	bh=4776VYAwYZcBlvK+XQSJBOsbq5ySlZEiham03xKgXWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q48DgBWnvekkTqvuqPv5zAsenIcaC5ZbXg8axrM4T3rjacbultcONbhsQuZ56bv64x6iaML6+ITG+maOG5LSb6gofYLHMNM4WbgRD99wlll8Hk5QSWZDlvxPBUvXcCXlC/UU+HA8yjFtGRaciQZmHgsNoDZJdGEZqeA/IrfSscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04365C15;
	Fri,  8 Mar 2024 08:08:41 -0800 (PST)
Received: from [10.57.68.92] (unknown [10.57.68.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02C33F73F;
	Fri,  8 Mar 2024 08:08:02 -0800 (PST)
Message-ID: <5c7c7407-5356-4e12-a648-ae695fe0d1cb@arm.com>
Date: Fri, 8 Mar 2024 16:08:01 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings >=
 PAGE_SIZE
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, iommu@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20240308152829.25754-1-will@kernel.org>
 <20240308152829.25754-7-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240308152829.25754-7-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-08 3:28 pm, Will Deacon wrote:
> For swiotlb allocations >= PAGE_SIZE, the slab search historically
> adjusted the stride to avoid checking unaligned slots. This had the
> side-effect of aligning large mapping requests to PAGE_SIZE, but that
> was broken by 0eee5ae10256 ("swiotlb: fix slot alignment checks").
> 
> Since this alignment could be relied upon drivers, reinstate PAGE_SIZE
> alignment for swiotlb mappings >= PAGE_SIZE.

This seems clear enough to keep me happy now, thanks! And apologies that 
I managed to confuse even myself in the previous thread...

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   kernel/dma/swiotlb.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c381a7ed718f..c5851034523f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -992,6 +992,17 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>   	BUG_ON(!nslots);
>   	BUG_ON(area_index >= pool->nareas);
>   
> +	/*
> +	 * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
> +	 * page-aligned in the absence of any other alignment requirements.
> +	 * 'alloc_align_mask' was later introduced to specify the alignment
> +	 * explicitly, however this is passed as zero for streaming mappings
> +	 * and so we preserve the old behaviour there in case any drivers are
> +	 * relying on it.
> +	 */
> +	if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
> +		alloc_align_mask = PAGE_SIZE - 1;
> +
>   	/*
>   	 * Ensure that the allocation is at least slot-aligned and update
>   	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> @@ -1006,13 +1017,6 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>   	 */
>   	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
>   
> -	/*
> -	 * For allocations of PAGE_SIZE or larger only look for page aligned
> -	 * allocations.
> -	 */
> -	if (alloc_size >= PAGE_SIZE)
> -		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> -
>   	spin_lock_irqsave(&area->lock, flags);
>   	if (unlikely(nslots > pool->area_nslabs - area->used))
>   		goto not_found;
