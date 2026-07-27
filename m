Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFBD40DB3F
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172474; cv=none; b=jBxLyQVMOkN8a35bte2ElBkHnDSGMMfqgLLdtEZi0CRK3xfwATBeF1lHRexWr6QOhUMd3B0Quq2+BlEgo2b6ohzU0eB6JBaYDpTNo7o0wnJ3LLzVo450nxGhPRVRNYmA+NowW3sW/ZKGmJ4Awsz/745tikMi5WF+XTImzwvS4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172474; c=relaxed/simple;
	bh=NceNdXss+IYFUd5WJwy+5Lycac/YVGli4KhPahl9bdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiYxHR7DW1sL1lNJlnfijmMKZ6WcI0WtQDz9frk7gmQyXmCoPYFHchSz0d2q1g/QIrFLqe06QD6AfAqa5yyGOHJ5OO6yJhq7KXQbgR24T8eNQzQG/6m++3/4JKFgu5yUO2Y1e2qBzSE0DPqX2NxgE/mj74LZMtBHV7bHqurhfow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OFjK3NWG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OFjK3NWG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 185501682;
	Mon, 27 Jul 2026 10:14:28 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BC0C3F763;
	Mon, 27 Jul 2026 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785172472; bh=NceNdXss+IYFUd5WJwy+5Lycac/YVGli4KhPahl9bdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OFjK3NWGki9leejOv6ZADA4vNcgV/vbFQJawCY8MMN3IZA0LOqghAYptHMftmJIPY
	 Xv/gV3NGJksKCztx+Wg7KgLSeSADS4vwu2Wzz+b/zbMmWwBg8bduFvi3r+smOPFChq
	 EYsNujXCIC/Sd+9pUtgc17mi/wIqC+Fsjoyb5kfY=
Message-ID: <9ca5da69-50da-4583-97ae-986b90b5ef16@arm.com>
Date: Mon, 27 Jul 2026 18:14:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/iova: Move CPU magazine init to first insert
To: Logan Odell <loganodell@google.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 mclapinski@google.com, skhawaja@google.com
References: <20260727155720.2692587-1-loganodell@google.com>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20260727155720.2692587-1-loganodell@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/07/2026 4:57 pm, Logan Odell wrote:
> A large amount of memory may be allocated for these magazines on
> machines with a lot of IOMMU groups and CPU cores. Not all may be used
> as some devices may be unused or be bound to drivers that do not use the
> DMA-API. Furthermore, some drivers may not use all levels or CPUs.
> 
> Move the initialization of the loaded and prev magazines for each CPU on
> the first attempt to try to insert a freed IOVA to them.
> 
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
> v2: only rebase
> v3: Combine the initilaization logic with new magazine logic in __iova_rcache_insert

LGTM,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Although as a process nit, since you've now taken back custody of the 
patch to make this update, technically you should either add your 
sign-off a second time after Michal's, or perhaps more neatly, give 
Michal a Co-developed-by and swap the sign-offs[1].

Thanks,
Robin.

[1] 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> ---
> 
> Change-Id: I987b6dfb2b1125d8da8618fff540f315b99bad13
> ---
>   drivers/iommu/iova.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 021daf6528de..82d52eb12e4c 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -621,6 +621,9 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   	unsigned long flags;
>   	int i;
>   
> +	if (!mag)
> +		return;
> +
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>   
>   	for (i = 0 ; i < mag->size; ++i) {
> @@ -739,12 +742,6 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>   
>   			spin_lock_init(&cpu_rcache->lock);
> -			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
> -			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
> -			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
> -				ret = -ENOMEM;
> -				goto out_err;
> -			}
>   		}
>   	}
>   
> @@ -777,19 +774,23 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>   	spin_lock_irqsave(&cpu_rcache->lock, flags);
>   
> -	if (!iova_magazine_full(cpu_rcache->loaded)) {
> +	if (cpu_rcache->loaded && !iova_magazine_full(cpu_rcache->loaded)) {
>   		can_insert = true;
> -	} else if (!iova_magazine_full(cpu_rcache->prev)) {
> +	} else if (cpu_rcache->prev && !iova_magazine_full(cpu_rcache->prev)) {
>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>   		can_insert = true;
>   	} else {
>   		struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
>   
>   		if (new_mag) {
> -			spin_lock(&rcache->lock);
> -			iova_depot_push(rcache, cpu_rcache->loaded);
> -			spin_unlock(&rcache->lock);
> -			schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
> +			if (cpu_rcache->loaded && !cpu_rcache->prev) {
> +				cpu_rcache->prev = cpu_rcache->loaded;
> +			} else if (cpu_rcache->loaded) {
> +				spin_lock(&rcache->lock);
> +				iova_depot_push(rcache, cpu_rcache->loaded);
> +				spin_unlock(&rcache->lock);
> +				schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
> +			}
>   
>   			cpu_rcache->loaded = new_mag;
>   			can_insert = true;
> @@ -831,9 +832,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>   	spin_lock_irqsave(&cpu_rcache->lock, flags);
>   
> -	if (!iova_magazine_empty(cpu_rcache->loaded)) {
> +	if (cpu_rcache->loaded && !iova_magazine_empty(cpu_rcache->loaded)) {
>   		has_pfn = true;
> -	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
> +	} else if (cpu_rcache->prev && !iova_magazine_empty(cpu_rcache->prev)) {
>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>   		has_pfn = true;
>   	} else {

