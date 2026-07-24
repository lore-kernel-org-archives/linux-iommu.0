Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65031F9AC
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904655; cv=none; b=DlBaGZt8lyiEl7hYPYrXJxOwLtXZkN/sdFH2m/SQok1g61+UOBtiWPqXC/uxYGgLILX7StBzNSemEfjEgTvrwQb1/n4MzqlTMS/bk+bgSOmOy8dXSfTkMxEnlNMSeDUpq6jnj7G266vyiGBXQu/zf+rTS6XVLM45gbqWYM12e/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904655; c=relaxed/simple;
	bh=IFsilcSS+LYS/ySQaW4JxBUDmdO9WuVP32YKvHLSDdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUIL2HFb59mLVnPt0lJ3sMcfvCGhWEUNx8rIz846+ptIFqsepI4NWolkTdAVMZGtTlmTogNZlq3bbW5HYtwGRMQkWfsBW/CKPIwfO0WzrI9Zo8LWP/gj2Rbi/0HP91PpDystGYfdOyS/Rp93D4XKRMOF6UoR3E6qK29QXEZT7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vOznsJng; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vOznsJng"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63B9A1477;
	Fri, 24 Jul 2026 07:50:45 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C66743F66F;
	Fri, 24 Jul 2026 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784904649; bh=IFsilcSS+LYS/ySQaW4JxBUDmdO9WuVP32YKvHLSDdk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vOznsJngofNqB/0e/jrBh5PIPFyGgv1AEIHDcU5kmC237Syd4X30xkwNWfsYP4dWK
	 UqHBNK7528IjHyFJr1E0AJD0lkks2lTUW+8a9tg+tGGOxMpoOIbnPH58zqkPlx9QPd
	 SJncUfnZXzdqMK05ilN0GlEfjkl1cFNUxDPF/EIA=
Message-ID: <599c4aae-540b-4f22-8d2d-43e5250e8e9c@arm.com>
Date: Fri, 24 Jul 2026 15:50:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] iommu/iova: Move CPU magazine init to first
 insert
To: Michal Clapinski <mclapinski@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>,
 Logan Odell <loganodell@google.com>
References: <20260724134419.1051078-1-mclapinski@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260724134419.1051078-1-mclapinski@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2026 2:44 pm, Michal Clapinski wrote:
> From: Logan Odell <loganodell@google.com>
> 
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
> ---
>   drivers/iommu/iova.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 021daf6528de..1a4bbf45dbb9 100644
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
> @@ -737,14 +740,7 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   		}
>   		for_each_possible_cpu(cpu) {
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> -
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
> @@ -777,8 +773,20 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>   	spin_lock_irqsave(&cpu_rcache->lock, flags);
>   
> +	if (!cpu_rcache->loaded) {
> +		cpu_rcache->loaded = iova_magazine_alloc(GFP_ATOMIC | __GFP_NOWARN);
> +		if (!cpu_rcache->loaded)
> +			goto unlock;

I think it would make sense to at least maintain the existing allocation 
pattern to preserve the invariant that if loaded is valid then prev must 
be valid as well. I can accept the argument for not allocating them at 
all, but as soon as we _do_ start using the mechanism then there is 
really no reason to ever have one without the other.

Furthermore it would seem more logical to either do this in 
__iova_rcache_get() if you want late-initialisation to be an explicit 
special case. Or alternatively, just fold it even more into the existing 
flow - AFAICS the only real difference should be that if both loaded and 
prev are "full" (i.e. unable to accept the PFN) due to not existing at 
all, then there's obviously nothing to push to the depot, but otherwise 
that path should work just the same to initialise loaded at least. I 
guess it might take a bit more fiddling to ensure prev ends up ever 
getting allocated though...

Thanks,
Robin.

> +	}
> +
>   	if (!iova_magazine_full(cpu_rcache->loaded)) {
>   		can_insert = true;
> +	} else if (!cpu_rcache->prev) {
> +		cpu_rcache->prev = iova_magazine_alloc(GFP_ATOMIC | __GFP_NOWARN);
> +		if (!cpu_rcache->prev)
> +			goto unlock;
> +		swap(cpu_rcache->prev, cpu_rcache->loaded);
> +		can_insert = true;
>   	} else if (!iova_magazine_full(cpu_rcache->prev)) {
>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>   		can_insert = true;
> @@ -799,6 +807,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   	if (can_insert)
>   		iova_magazine_push(cpu_rcache->loaded, iova_pfn);
>   
> +unlock:
>   	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>   
>   	return can_insert;
> @@ -831,9 +840,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
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

