Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F773530
	for <iommu@lists.linux.dev>; Mon, 15 Apr 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189871; cv=none; b=AbvmsgG4txB0UgKUBOWbP1dSz4awh+hXikZb/p0hNgfuSxFoHALLiDmEF5LvmpKXeR7I4HkMzj945XudoHlaUMAY40X4UCN61HoEeZJfxaX6SNYOkfbwI89lr3yk8mrQj+J69a/TQoMf6/PgHiK1Lorr9kDOiwgDhL2m4z7EVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189871; c=relaxed/simple;
	bh=rkjgCvLIlbUTEBSshlMQwhfYMvYYW2XsogAggojTHjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sWlOHsJX2gjD3L5yKUh77TmGqafdlUGgX2oLSJ4cJ2DRz319ZZRG1io/hTeNGfinKeDhNpmDIY5OmZQGnnDZaADLAwtOyUTQpW6De6pRU3+xjDiEv5wCvo+oIbh4n0aQK6jZpRLjJwyWI4fkDa/k2mqKUYsFxfvOrSqPTTmH0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC172F4;
	Mon, 15 Apr 2024 07:04:56 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3AAF3F738;
	Mon, 15 Apr 2024 07:04:27 -0700 (PDT)
Message-ID: <1bdeb8a0-4b92-4cf4-93b9-60528fb487a5@arm.com>
Date: Mon, 15 Apr 2024 15:04:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: Consider NUMA affinity when allocating memory
 for per-CPU iova_magazine
To: Li RongQing <lirongqing@baidu.com>, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev
References: <20240415065653.33018-1-lirongqing@baidu.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240415065653.33018-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/04/2024 7:56 am, Li RongQing wrote:
> per-CPU iova_magazine are dominantly accessed from their own local CPUs,
> so allocate them node-local to improve performance.

Note that this will only hold for certain workloads (typically rather 
light ones, I'd guess) - do you have one where this makes a measurable 
difference? If so I'd be interested to know what sort of numbers we're 
talking about.

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/iommu/iova.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d59d0ea..70f89ea 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -597,11 +597,11 @@ unsigned long iova_rcache_range(void)
>   	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
>   }
>   
> -static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
> +static struct iova_magazine *iova_magazine_alloc_node(gfp_t flags, int node)
>   {
>   	struct iova_magazine *mag;
>   
> -	mag = kmem_cache_alloc(iova_magazine_cache, flags);
> +	mag = kmem_cache_alloc_node(iova_magazine_cache, flags, node);
>   	if (mag)
>   		mag->size = 0;
>   
> @@ -707,7 +707,7 @@ static void iova_depot_work_func(struct work_struct *work)
>   int iova_domain_init_rcaches(struct iova_domain *iovad)
>   {
>   	unsigned int cpu;
> -	int i, ret;
> +	int i, ret, nid;
>   
>   	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
>   				 sizeof(struct iova_rcache),
> @@ -731,10 +731,11 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   		}
>   		for_each_possible_cpu(cpu) {
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> +			nid = cpu_to_node(cpu);
>   
>   			spin_lock_init(&cpu_rcache->lock);
> -			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
> -			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
> +			cpu_rcache->loaded = iova_magazine_alloc_node(GFP_KERNEL, nid);
> +			cpu_rcache->prev = iova_magazine_alloc_node(GFP_KERNEL, nid);

This much seems reasonable - however small the benefit might be, there's 
little harm in aiming for optimal initial conditions, for as long as 
they do happen to last...

>   			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
>   				ret = -ENOMEM;
>   				goto out_err;
> @@ -777,7 +778,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>   		can_insert = true;
>   	} else {
> -		struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
> +		int nid = cpu_to_node(raw_smp_processor_id());
> +		struct iova_magazine *new_mag =
> +			iova_magazine_alloc_node(GFP_ATOMIC, nid);

...however if we get to this point then we're already busy enough to be 
churning magazines between the CPU caches and the global depot, so it's 
unlikely that new ones are going to stay CPU-local for very long either.

Thanks,
Robin.

>   
>   		if (new_mag) {
>   			spin_lock(&rcache->lock);
