Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9AD5CBE
	for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 17:03:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 342781595;
	Fri, 16 Sep 2022 10:03:38 -0700 (PDT)
Received: from [10.57.18.118] (unknown [10.57.18.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1A013F73D;
	Fri, 16 Sep 2022 10:03:30 -0700 (PDT)
Message-ID: <7317c5f1-be57-7ddd-36d0-5b80226462fd@arm.com>
Date: Fri, 16 Sep 2022 18:03:25 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] iommu/iova: using separate rcache for SAC and DAC
Content-Language: en-GB
To: "brookxu.cn" <brookxu.cn@gmail.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220916154613.104965-1-brookxu.cn@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220916154613.104965-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-16 16:46, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> While iommu_dma_forcedac disable, for PCI device kernel
> try SAC first, if failed then try DAC. Since now rcache
> does not distinguish SAC and DAC, if all PFNs contained
> in cpu loaded cache is larger than SAC max PFN, but the
> SAC address space is sufficient, as cpu loaded cached is
> not empty, kernel will iova_alloc () to alloc IOVA. For
> PCI device, kernel alloc SAC most, loaded cache may
> invalid for SAC alloc for a long time, kernel will enter
> alloc_iova() slow path frequencely, as result performance
> is degrade. To circumvent this problem, SAC and DAC maybe
> better to use separate caches.

I really dislike the idea of doubling the already significantly large 
footprint of rcaches purely to optimise for the stupid case. If you've 
got to the point of hitting contention in the SAC path, you presumably 
don't have broken hardware/drivers so you're infinitely better off using 
forcedac and avoiding it entirely to begin with. And frankly even if you 
*do* have broken hardware, if you care about performance you're still 
better off fixing the relevant driver(s) to set correct DMA masks so you 
can use forcedac.

Since this mechanism now officially serves as a bandage for broken 
hardware/drivers and little else, I had an idea to make it a lot better, 
guess it's time to have a go at writing that patch up...

Thanks,
Robin.

> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> ---
>   drivers/iommu/iova.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 47d1983dfa2a..d5775719a143 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -16,6 +16,7 @@
>   #define IOVA_ANCHOR	~0UL
>   
>   #define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
> +#define IOVA_RANGE_CACHE_ARRAY_SIZE (2 * IOVA_RANGE_CACHE_MAX_SIZE)
>   
>   static bool iova_rcache_insert(struct iova_domain *iovad,
>   			       unsigned long pfn,
> @@ -723,13 +724,13 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   	unsigned int cpu;
>   	int i, ret;
>   
> -	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
> +	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_ARRAY_SIZE,
>   				 sizeof(struct iova_rcache),
>   				 GFP_KERNEL);
>   	if (!iovad->rcaches)
>   		return -ENOMEM;
>   
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
>   		struct iova_cpu_rcache *cpu_rcache;
>   		struct iova_rcache *rcache;
>   
> @@ -825,11 +826,15 @@ static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
>   			       unsigned long size)
>   {
>   	unsigned int log_size = order_base_2(size);
> +	unsigned int index;
>   
>   	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
>   		return false;
>   
> -	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
> +	if (pfn > DMA_BIT_MASK(32))
> +		index = log_size + IOVA_RANGE_CACHE_MAX_SIZE;
> +
> +	return __iova_rcache_insert(iovad, &iovad->rcaches[index], pfn);
>   }
>   
>   /*
> @@ -881,11 +886,20 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   				     unsigned long limit_pfn)
>   {
>   	unsigned int log_size = order_base_2(size);
> +	unsigned long iova_pfn;
> +	unsigned int index;
>   
>   	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
>   		return 0;
>   
> -	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
> +	iova_pfn = __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
> +
> +	if (!iova_pfn && limit_pfn > DMA_BIT_MASK(32)) {
> +		index = log_size + IOVA_RANGE_CACHE_MAX_SIZE;
> +		iova_pfn = __iova_rcache_get(&iovad->rcaches[index], limit_pfn - size);
> +	}
> +
> +	return iova_pfn
>   }
>   
>   /*
> @@ -898,7 +912,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   	unsigned int cpu;
>   	int i, j;
>   
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
>   		rcache = &iovad->rcaches[i];
>   		if (!rcache->cpu_rcaches)
>   			break;
> @@ -926,7 +940,7 @@ static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>   	unsigned long flags;
>   	int i;
>   
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
>   		rcache = &iovad->rcaches[i];
>   		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>   		spin_lock_irqsave(&cpu_rcache->lock, flags);
> @@ -945,7 +959,7 @@ static void free_global_cached_iovas(struct iova_domain *iovad)
>   	unsigned long flags;
>   	int i, j;
>   
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
>   		rcache = &iovad->rcaches[i];
>   		spin_lock_irqsave(&rcache->lock, flags);
>   		for (j = 0; j < rcache->depot_size; ++j) {
