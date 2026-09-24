Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB049E5C2
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263578; cv=none; b=ANRNEYHCtHi6mLr49m//KSL81/6Ym8B4sinPf0T9bpv++N5RPJvI+NBIclundoNd9TA+u3QKOivsaCGzlgDuittaGId4FxnL5T5P48w6J06fblVkljV+z/V02tHJm+IO92cUIO+oxRSGEvOpQYOGsKAmClPUnLD0IqbYM4uTtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263578; c=relaxed/simple;
	bh=B+Qpq0mGaw3xi25XZVIMrbmAYpvPUbmJS4mCwVTqyrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeLH8JtRNdt1pIh3AxziBB61rwoXHJmauVPCsPMw2WhehRd73oztyUB9PazLaRX3ep7Y7PpChBROEDRoL+H4SLw6jq74F+xAOivfTZfVevvSzCxdO3LheAT7O3ubAXptAYBXYjYB2+RRgzwBXvzeXFkvuuJg/ByLm0aY1ZSTjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l6n9ELTV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l6n9ELTV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55C7B1476;
	Thu, 24 Sep 2026 08:26:12 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A883F86F;
	Thu, 24 Sep 2026 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790263575; bh=B+Qpq0mGaw3xi25XZVIMrbmAYpvPUbmJS4mCwVTqyrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l6n9ELTVe2ZkaCPB8nIwz5Sc7JZOs68VmMkYvZCShdny6ZjohUe8b19JXSchJMYF4
	 uO3QIiF/YMJxoSE0UMYdLjyadb9nHTaDBWegle8Ib7Io9p8Jy5sXqC9NrROZxTUzzZ
	 GNcyquiJ6/sK6Y7PClYCIdP05QXcDxGvwxBTKEdQ=
Message-ID: <9547761f-7688-4351-b172-9e9d5fa28b15@arm.com>
Date: Thu, 24 Sep 2026 16:26:06 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] iommu/iova: convert from rbtree to maple tree
To: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, liam@infradead.org, maple-tree@lists.infradead.org,
 linux-mm@kvack.org, ashok.raj@oss.qualcomm.com, jgg@ziepe.ca,
 kyle@mcmartin.ca
References: <20260818152505.1057922-1-riel@surriel.com>
 <20260818152505.1057922-2-riel@surriel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260818152505.1057922-2-riel@surriel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 4:25 pm, Rik van Riel wrote:
> alloc_iova() looks for free space by walking the rbtree linearly.
> On production workloads at Meta, enough CPUs have ended up in that walk
> at the same time to trigger soft lockups.
> 
> Index the iova ranges in a maple tree instead. Its gap search makes
> alloc_iova() O(log n).
> 
> __alloc_and_insert_iova_range() asks mas_empty_area_rev() for the
> highest free range below limit_pfn. Alignment is handled by rounding
> up the allocation size, prioritizing speed over address space waste,
> with the thought that many iova requests on a system will be similar
> in size, and reuse the same holes.
[...]
>   static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   		unsigned long size, unsigned long limit_pfn,
>   			struct iova *new, bool size_aligned)
>   {
> -	struct rb_node *curr, *prev;
> -	struct iova *curr_iova;
>   	unsigned long flags;
> -	unsigned long new_pfn, retry_pfn;
> +	unsigned long new_pfn;
>   	unsigned long align_mask = ~0UL;
> -	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
> +	unsigned long search_size = size;
> +	MA_STATE(mas, &iovad->mtree, 0, 0);
> +
> +	if (size_aligned) {
> +		unsigned long align = 1UL << fls_long(size - 1);
>   
> -	if (size_aligned)
>   		align_mask <<= fls_long(size - 1);
> +		search_size = size + align - 1;
> +	}

Perhaps it's a bit too much of a cool trick, but I think technically we 
could just do "search_size = size + ~align_mask" unconditionally.

However, either way I do worry somewhat about the increase in 
fragmentation and premature failures once the space starts to fill up. 
Say for simplicity we have a start_pfn of 0 and limit_pfn of 4 - with 
the current code we can successfully allocate a size of 1 (to IOVA 3) 
followed by a size of 3 (to IOVA 0), or even in the opposite order for 
the same result, whereas with this workaround we couldn't ever allocate 
the 3 either way if its search_size has to be 7.

AFAIK there are real-world use-cases where the usable IOVA space is 
relatively small compared to the sizes of some of the buffers being 
mapped, such that packing density matters (i.e. media stuff in mobile 
SoCs), so if at all possible it would be good if maple tree itself could 
be improved to support searching for a free range with a particular 
alignment (either explicit, or implied natural alignemnt of the size) 
rather than having to bodge it this way. Unfortunately we also can't 
just relax the general DMA API guarantee that DMA addresses are 
naturally-aligned to the mapping/allocation size, as who knows how many 
devices that might break.

> -	/* Walk the tree backwards */
> -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);

FWIW I'm not much of a fan of the implicit scoped-cleanup stuff in 
general, but this seems like an instance where using guard() to simplify 
all the early returns might be worthwhile.

Thanks,
Robin.

> +	spin_lock_irqsave(&iovad->iova_lock, flags);
> +	/* No 32-bit request this large can fit until the hint is cleared. */
>   	if (limit_pfn <= iovad->dma_32bit_pfn &&
>   			size >= iovad->max32_alloc_size)
> -		goto iova32_full;
> -
> -	curr = __get_cached_rbnode(iovad, limit_pfn);
> -	curr_iova = to_iova(curr);
> -	retry_pfn = curr_iova->pfn_hi;
> -
> -retry:
> -	do {
> -		high_pfn = min(high_pfn, curr_iova->pfn_lo);
> -		new_pfn = (high_pfn - size) & align_mask;
> -		prev = curr;
> -		curr = rb_prev(curr);
> -		curr_iova = to_iova(curr);
> -	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
> -
> -	if (high_pfn < size || new_pfn < low_pfn) {
> -		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
> -			high_pfn = limit_pfn;
> -			low_pfn = retry_pfn + 1;
> -			curr = iova_find_limit(iovad, limit_pfn);
> -			curr_iova = to_iova(curr);
> -			goto retry;
> -		}
> -		iovad->max32_alloc_size = size;
> -		goto iova32_full;
> +		goto alloc_fail;
> +
> +	if (mas_empty_area_rev(&mas, iovad->start_pfn,
> +				 limit_pfn - 1, search_size)) {
> +		/* Only real exhaustion sets the hint, not a failed store. */
> +		if (limit_pfn <= iovad->dma_32bit_pfn)
> +			iovad->max32_alloc_size = size;
> +		goto alloc_fail;
>   	}
>   
> -	/* pfn_lo will point to size aligned address if size_aligned is set */
> +	/* The gap is search_size wide, so alignment cannot pass start_pfn. */
> +	new_pfn = (mas.last - size + 1) & align_mask;
> +
>   	new->pfn_lo = new_pfn;
> -	new->pfn_hi = new->pfn_lo + size - 1;
> +	new->pfn_hi = new_pfn + size - 1;
>   
> -	/* If we have 'prev', it's a valid place to start the insertion. */
> -	iova_insert_rbtree(&iovad->rbroot, new, prev);
> -	__cached_rbnode_insert_update(iovad, new);
> +	mas.index = new->pfn_lo;
> +	mas.last = new->pfn_hi;
> +	if (mas_store_gfp(&mas, new, GFP_ATOMIC))
> +		goto alloc_fail;
>   
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	spin_unlock_irqrestore(&iovad->iova_lock, flags);
>   	return 0;
>   
> -iova32_full:
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +alloc_fail:
> +	spin_unlock_irqrestore(&iovad->iova_lock, flags);
>   	return -ENOMEM;
>   }
