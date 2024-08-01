Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CEA1EB498
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529440; cv=none; b=i9iqDqD68ezztM8MECh2D4jDa5N0lA5/bmT0KLSOPxozHAUhp6nPZeKR6Bez2XVVHgAuFg0ux0xfVC9bB12gViPA/pwnHKXcmXC2nyh2/5ijC6jYXR6GHv2737dKy7WtbHye8YDSmFasf7HCfoUigs2c84fNVqnYo0UGzFffAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529440; c=relaxed/simple;
	bh=8wknI1VZhWP+7iiJFkBcGdRkSto79tQSbk3Dra6m08U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0dS5VChgnUkLnYEz3j3A+C9LwJtnwU7egh6Ax3G6S26sKzHWF60UMYnrKt+RHtBaW5wYsKy+/2XF9qu+QepP5GUCH9czr6bNcJNlWlD3LQ2+jzwUjJPdjp6ios79N6DXfXJtFNntZO38sMumcc7dWlIEpd2fD1vSEnhtYTALTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92FB415A1;
	Thu,  1 Aug 2024 09:24:23 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD24F3F5A1;
	Thu,  1 Aug 2024 09:23:50 -0700 (PDT)
Message-ID: <f71896b4-876e-4bcc-95ae-8d182c259771@arm.com>
Date: Thu, 1 Aug 2024 17:23:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] iommu: Optimize IOMMU UnMap
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240801033432.106837-1-amhetre@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240801033432.106837-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2024 4:34 am, Ashish Mhetre wrote:
> The current __arm_lpae_unmap() function calls dma_sync() on individual
> PTEs after clearing them. Overall unmap performance can be improved by
> around 25% for large buffer sizes by combining the syncs for adjacent
> leaf entries.
> Optimize the unmap time by clearing all the leaf entries and issuing a
> single dma_sync() for them.
> Below is detailed analysis of average unmap latency(in us) with and
> without this optimization obtained by running dma_map_benchmark for
> different buffer sizes.
> 
> 		UnMap Latency(us)
> Size	Without		With		% gain with
> 	optimiztion	optimization	optimization
> 
> 4KB	3		3		0
> 8KB	4		3.8		5
> 16KB	6.1		5.4		11.48
> 32KB	10.2		8.5		16.67
> 64KB	18.5		14.9		19.46
> 128KB	35		27.5		21.43
> 256KB	67.5		52.2		22.67
> 512KB	127.9		97.2		24.00
> 1MB	248.6		187.4		24.62
> 2MB	65.5		65.5		0
> 4MB	119.2		119		0.17
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
> Changes in V2:
> - Updated the commit message to be imperative.
> - Fixed ptep at incorrect index getting cleared for non-leaf entries.
> ---
>   drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5d9fd1f45bf..32401948b980 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -274,13 +274,15 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
>   				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
>   }
>   
> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
>   {
> +	int i;

You can make this a nice tidy loop-local declaration now.

> -	*ptep = 0;
> +	for (i = 0; i < num_entries; i++)
> +		ptep[i] = 0;
>   
>   	if (!cfg->coherent_walk)
> -		__arm_lpae_sync_pte(ptep, 1, cfg);
> +		__arm_lpae_sync_pte(ptep, num_entries, cfg);
>   }
>   
>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> @@ -635,9 +637,10 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   			       unsigned long iova, size_t size, size_t pgcount,
>   			       int lvl, arm_lpae_iopte *ptep)
>   {
> +	bool gather_queued;
>   	arm_lpae_iopte pte;
>   	struct io_pgtable *iop = &data->iop;
> -	int i = 0, num_entries, max_entries, unmap_idx_start;
> +	int i = 0, j = 0, num_entries, max_entries, unmap_idx_start;

Similarly there's no need to initialise j here, but I'd make it 
loop-local anyway.

>   	/* Something went horribly wrong and we ran out of page table */
>   	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
> @@ -652,28 +655,33 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   	/* If the size matches this level, we're in the right place */
>   	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>   		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
> +		gather_queued = iommu_iotlb_gather_queued(gather);

This is used exactly once, do we really need to introduce the variable?

>   		num_entries = min_t(int, pgcount, max_entries);
>   
> -		while (i < num_entries) {
> -			pte = READ_ONCE(*ptep);
> +		/* Find and handle non-leaf entries */
> +		for (i = 0; i < num_entries; i++) {
> +			pte = READ_ONCE(ptep[i]);
>   			if (WARN_ON(!pte))
>   				break;
>   
> -			__arm_lpae_clear_pte(ptep, &iop->cfg);
> -
>   			if (!iopte_leaf(pte, lvl, iop->fmt)) {
> +				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
> +
>   				/* Also flush any partial walks */
>   				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
>   							  ARM_LPAE_GRANULE(data));
>   				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
> -			} else if (!iommu_iotlb_gather_queued(gather)) {
> -				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
>   			}
> -
> -			ptep++;
> -			i++;
>   		}
>   
> +		/* Clear the remaining entries */
> +		if (i)

It seems a little non-obvious to optimise for one specific corner of 
unexpected failures here. I'd hope a zero-sized dma_sync wouldn't blow 
up in that case, but if you want to be safe then I'd cover it by 
tweaking the condition in __arm_lpae_clear_pte() to "if 
(!cfg->coherent_walk && num_entries)".

Thanks,
Robin.

> +			__arm_lpae_clear_pte(ptep, &iop->cfg, i);
> +
> +		if (!gather_queued)
> +			for (j = 0; j < i; j++)
> +				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
> +
>   		return i * size;
>   	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
>   		/*
