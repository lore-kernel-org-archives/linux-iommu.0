Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D56C13B582
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226570; cv=none; b=oQfCMMKigewALbl8JdzgplehtGSoOBSwJZDWlV8aF5FYeJzqYFqXI+G2J4ITal/GfgfgMS9TaLtZN9K5Bj9VJ2xkhOdv76zOOySnZDGQbZ+fknrIbFdeN88NL4s1T/F2nF9hgeEevabAMEJqsfgQXy5JgMBNRI6r8qXO6O1EsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226570; c=relaxed/simple;
	bh=OFyLE1q7WBU8Ccw3gBNY/owYbpctX5c3SO2pO98pqzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ur1pLZERWhakA+YaCPrM5qDv2XnHDLypFIveQzvHIgqqjBE01vJQqDIBniW5zGzIMX3HsDVvqp+FxHlPzoS+pvC1txsp/wiQDE/MbFfO4jSdeNdJQERp08/mj3G/cI0y9EFJSwv6WXGWLWgi5c6X+yZ3yn2tCaYVfrLR9g7se0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86899DA7;
	Mon, 24 Jun 2024 03:56:32 -0700 (PDT)
Received: from [10.57.74.124] (unknown [10.57.74.124])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D86B3F73B;
	Mon, 24 Jun 2024 03:56:06 -0700 (PDT)
Message-ID: <5149c162-cf38-4aa4-9e96-27c6897cad36@arm.com>
Date: Mon, 24 Jun 2024 11:56:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: Bettering utilizing cpu_rcaches in no-strict
 mode
To: Zhang Zekun <zhangzekun11@huawei.com>, joro@8bytes.org, will@kernel.org,
 john.g.garry@oracle.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240624083952.52612-1-zhangzekun11@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240624083952.52612-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-24 9:39 am, Zhang Zekun wrote:
> Currently, when iommu working in no-strict mode, fq_flush_timeout()
> will always try to free iovas on one cpu. Freeing the iovas from all
> cpus on one cpu is not cache-friendly to iova_rcache, because it will
> first filling up the cpu_rcache and then pushing iovas to the depot,
> iovas in the depot will finally goto the underlying rbtree if the
> depot_size is greater than num_online_cpus().

That is the design intent - if the excess magazines sit in the depot 
long enough to be reclaimed then other CPUs didn't want them either. 
We're trying to minimise the amount of unused cached IOVAs sitting 
around wasting memory, since IOVA memory consumption has proven to be 
quite significant on large systems.

As alluded to in the original cover letter, 100ms for IOVA_DEPOT_DELAY 
was just my arbitrary value of "long enough" to keep the initial 
implementation straightforward - I do expect that certain workloads 
might benefit from tuning it differently, but without proof of what they 
are and what they want, there's little justification for introducing 
extra complexity and potential user ABI yet.

> Let fq_flush_timeout()
> freeing iovas on cpus who call dma_unmap* APIs, can decrease the overall
> time caused by fq_flush_timeout() by better utilizing the iova_rcache,
> and minimizing the competition for the iova_rbtree_lock().

I would have assumed that a single CPU simply throwing magazines into 
the depot list from its own percpu cache is quicker, or at least no 
slower, than doing the same while causing additional contention/sharing 
by interfering with other percpu caches as well. And where does the 
rbtree come into that either way? If an observable performance issue 
actually exists here, I'd like a more detailed breakdown to understand it.

Thanks,
Robin.

> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 22 +++++++++++++---------
>   drivers/iommu/iova.c      | 21 ++++++++++++++-------
>   include/linux/iova.h      |  7 +++++++
>   3 files changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 43520e7275cc..217b7c70d06c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -145,7 +145,8 @@ static inline unsigned int fq_ring_add(struct iova_fq *fq)
>   	return idx;
>   }
>   
> -static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
> +static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq *fq,
> +				int cpu)
>   {
>   	u64 counter = atomic64_read(&cookie->fq_flush_finish_cnt);
>   	unsigned int idx;
> @@ -158,20 +159,21 @@ static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq
>   			break;
>   
>   		iommu_put_pages_list(&fq->entries[idx].freelist);
> -		free_iova_fast(&cookie->iovad,
> +		free_iova_fast_cpu(&cookie->iovad,
>   			       fq->entries[idx].iova_pfn,
> -			       fq->entries[idx].pages);
> +			       fq->entries[idx].pages, cpu);
>   
>   		fq->head = (fq->head + 1) & fq->mod_mask;
>   	}
>   }
>   
> -static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
> +static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq,
> +			 int cpu)
>   {
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&fq->lock, flags);
> -	fq_ring_free_locked(cookie, fq);
> +	fq_ring_free_locked(cookie, fq, cpu);
>   	spin_unlock_irqrestore(&fq->lock, flags);
>   }
>   
> @@ -191,10 +193,11 @@ static void fq_flush_timeout(struct timer_list *t)
>   	fq_flush_iotlb(cookie);
>   
>   	if (cookie->options.qt == IOMMU_DMA_OPTS_SINGLE_QUEUE) {
> -		fq_ring_free(cookie, cookie->single_fq);
> +		cpu = smp_processor_id();
> +		fq_ring_free(cookie, cookie->single_fq, cpu);
>   	} else {
>   		for_each_possible_cpu(cpu)
> -			fq_ring_free(cookie, per_cpu_ptr(cookie->percpu_fq, cpu));
> +			fq_ring_free(cookie, per_cpu_ptr(cookie->percpu_fq, cpu), cpu);
>   	}
>   }
>   
> @@ -205,6 +208,7 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
>   	struct iova_fq *fq;
>   	unsigned long flags;
>   	unsigned int idx;
> +	int cpu = smp_processor_id();
>   
>   	/*
>   	 * Order against the IOMMU driver's pagetable update from unmapping
> @@ -227,11 +231,11 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
>   	 * flushed out on another CPU. This makes the fq_full() check below less
>   	 * likely to be true.
>   	 */
> -	fq_ring_free_locked(cookie, fq);
> +	fq_ring_free_locked(cookie, fq, cpu);
>   
>   	if (fq_full(fq)) {
>   		fq_flush_iotlb(cookie);
> -		fq_ring_free_locked(cookie, fq);
> +		fq_ring_free_locked(cookie, fq, cpu);
>   	}
>   
>   	idx = fq_ring_add(fq);
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d59d0ea2fd21..46a2188c263b 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -20,7 +20,7 @@
>   
>   static bool iova_rcache_insert(struct iova_domain *iovad,
>   			       unsigned long pfn,
> -			       unsigned long size);
> +			       unsigned long size, int cpu);
>   static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   				     unsigned long size,
>   				     unsigned long limit_pfn);
> @@ -423,12 +423,19 @@ EXPORT_SYMBOL_GPL(alloc_iova_fast);
>   void
>   free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
>   {
> -	if (iova_rcache_insert(iovad, pfn, size))
> +	free_iova_fast_cpu(iovad, pfn, size, smp_processor_id());
> +}
> +EXPORT_SYMBOL_GPL(free_iova_fast);
> +
> +void
> +free_iova_fast_cpu(struct iova_domain *iovad, unsigned long pfn,
> +		   unsigned long size, int cpu)
> +{
> +	if (iova_rcache_insert(iovad, pfn, size, cpu))
>   		return;
>   
>   	free_iova(iovad, pfn);
>   }
> -EXPORT_SYMBOL_GPL(free_iova_fast);
>   
>   static void iova_domain_free_rcaches(struct iova_domain *iovad)
>   {
> @@ -762,13 +769,13 @@ EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
>    */
>   static bool __iova_rcache_insert(struct iova_domain *iovad,
>   				 struct iova_rcache *rcache,
> -				 unsigned long iova_pfn)
> +				 unsigned long iova_pfn, int cpu)
>   {
>   	struct iova_cpu_rcache *cpu_rcache;
>   	bool can_insert = false;
>   	unsigned long flags;
>   
> -	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
> +	cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>   	spin_lock_irqsave(&cpu_rcache->lock, flags);
>   
>   	if (!iova_magazine_full(cpu_rcache->loaded)) {
> @@ -799,14 +806,14 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   }
>   
>   static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
> -			       unsigned long size)
> +			       unsigned long size, int cpu)
>   {
>   	unsigned int log_size = order_base_2(size);
>   
>   	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
>   		return false;
>   
> -	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
> +	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn, cpu);
>   }
>   
>   /*
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index d2c4fd923efa..91e4e3d5bcb3 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -93,6 +93,8 @@ struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
>   	bool size_aligned);
>   void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
>   		    unsigned long size);
> +void free_iova_fast_cpu(struct iova_domain *iovad, unsigned long pfn,
> +			unsigned long size, int cpu);
>   unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   			      unsigned long limit_pfn, bool flush_rcache);
>   struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
> @@ -134,6 +136,11 @@ static inline void free_iova_fast(struct iova_domain *iovad,
>   {
>   }
>   
> +static inline void free_iova_fast_cpu(struct iova_domain *iovad, unsigned long pfn,
> +				      unsigned long size, int cpu);
> +{
> +}
> +
>   static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
>   					    unsigned long size,
>   					    unsigned long limit_pfn,
