Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C93D96B
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="Rz/IRLmB"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 502F515E0CA;
	Mon, 11 Dec 2023 14:01:13 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1702299673; bh=GqgdD5vBHRpXHBZ9myHZrhikHhnZmHg4Q0B8HRHjSX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rz/IRLmBDVtf+75PPRlBJ1PQ6+vSmERJAlOSCgTdzgJlduA2eLpW3vF4T/h1YrF8T
	 p8f1VR9wRnKU+PTncuSafat4AhHvpZEvkW33Z48dGQ+xCjdzu87qkgWghVlvT7sZfF
	 4wM3u/Q6E8Zrc4QC5n1SnVh5FnnFSHaYL3i1VOadyQL+SFHqDyDGv7Jq4cSoJH6h/M
	 Q831LVlea0z/CB8r4pxN58WKmt8EmupqwtG5UbRFSmHaO6wCtJiYnEonVaSVZZaCqA
	 7OiqSxiOOisj2+3lMo2BZEER3XcCv2Px8PdgXYp7PrY4OszRyliQ8sHsO1dqk1sNYW
	 ovdZpVkf010KA==
Date: Mon, 11 Dec 2023 14:01:11 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
 linux-kernel@vger.kernel.org (open list), Wangkefeng
 <wangkefeng.wang@huawei.com>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH RESEND] swiotlb: reduce area lock contention for
 non-primary IO TLB pools
Message-ID: <20231211140111.5dbb74c0@meshulam.tesarici.cz>
In-Reply-To: <20231201121352.195-1-petrtesarik@huaweicloud.com>
References: <20231201121352.195-1-petrtesarik@huaweicloud.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Christoph,

just a friendly ping about the following patch. Does it need more time
to review, or has it gone lost?

Petr T

On Fri,  1 Dec 2023 13:13:52 +0100
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> If multiple areas and multiple IO TLB pools exist, first iterate the
> current CPU specific area in all pools. Then move to the next area index.
> 
> This is best illustrated by a diagram:
> 
>         area 0 |  area 1 | ... | area M |
> pool 0    A         B              C
> pool 1    D         E
> ...
> pool N    F         G              H
> 
> Currently, each pool is searched before moving on to the next pool,
> i.e. the search order is A, B ... C, D, E ... F, G ... H. With this patch,
> each area is searched in all pools before moving on to the next area,
> i.e. the search order is A, D ... F, B, E ... G ... C ... H.
> 
> Note that preemption is not disabled, and raw_smp_processor_id() may not
> return a stable result, but it is called only once to determine the initial
> area index. The search will iterate over all areas eventually, even if the
> current task is preempted.
> 
> Next, some pools may have less (but not more) areas than default_nareas.
> Skip such pools if the distance from the initial area index is greater than
> pool->nareas. This logic ensures that for every pool the search starts in
> the initial CPU's own area and never tries any area twice.
> 
> To verify performance impact, I booted the kernel with a minimum pool
> size ("swiotlb=512,4,force"), so multiple pools get allocated, and I ran
> these benchmarks:
> 
> - small: single-threaded I/O of 4 KiB blocks,
> - big: single-threaded I/O of 64 KiB blocks,
> - 4way: 4-way parallel I/O of 4 KiB blocks.
> 
> The "var" column in the tables below is the coefficient of variance over 5
> runs of the test, the "diff" column is the relative difference against base
> in read-write I/O bandwidth (MiB/s).
> 
> Tested on an x86 VM against a QEMU virtio SATA driver backed by a RAM-based
> block device on the host:
> 
> 	base	   patched
> 	var	var	diff
> small	0.69%	0.62%	+25.4%
> big	2.14%	2.27%	+25.7%
> 4way	2.65%	1.70%	+23.6%
> 
> Tested on a Raspberry Pi against a class-10 A1 microSD card:
> 
> 	base	   patched
> 	var	var	diff
> small	0.53%	1.96%	-0.3%
> big	0.02%	0.57%	+0.8%
> 4way	6.17%	0.40%	+0.3%
> 
> These results confirm that there is significant performance boost in the
> software IO TLB slot allocation itself. Where performance is dominated by
> actual hardware, there is no measurable change.
> 
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  kernel/dma/swiotlb.c | 90 +++++++++++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 33d942615be5..e20b856255ef 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -957,7 +957,7 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
>  #endif /* CONFIG_DEBUG_FS */
>  
>  /**
> - * swiotlb_area_find_slots() - search for slots in one IO TLB memory area
> + * swiotlb_search_pool_area() - search one memory area in one pool
>   * @dev:	Device which maps the buffer.
>   * @pool:	Memory pool to be searched.
>   * @area_index:	Index of the IO TLB memory area to be searched.
> @@ -972,7 +972,7 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
>   *
>   * Return: Index of the first allocated slot, or -1 on error.
>   */
> -static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
> +static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool,
>  		int area_index, phys_addr_t orig_addr, size_t alloc_size,
>  		unsigned int alloc_align_mask)
>  {
> @@ -1066,41 +1066,50 @@ static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
>  	return slot_index;
>  }
>  
> +#ifdef CONFIG_SWIOTLB_DYNAMIC
> +
>  /**
> - * swiotlb_pool_find_slots() - search for slots in one memory pool
> + * swiotlb_search_area() - search one memory area in all pools
>   * @dev:	Device which maps the buffer.
> - * @pool:	Memory pool to be searched.
> + * @start_cpu:	Start CPU number.
> + * @cpu_offset:	Offset from @start_cpu.
>   * @orig_addr:	Original (non-bounced) IO buffer address.
>   * @alloc_size: Total requested size of the bounce buffer,
>   *		including initial alignment padding.
>   * @alloc_align_mask:	Required alignment of the allocated buffer.
> + * @retpool:	Used memory pool, updated on return.
>   *
> - * Search through one memory pool to find a sequence of slots that match the
> + * Search one memory area in all pools for a sequence of slots that match the
>   * allocation constraints.
>   *
>   * Return: Index of the first allocated slot, or -1 on error.
>   */
> -static int swiotlb_pool_find_slots(struct device *dev, struct io_tlb_pool *pool,
> -		phys_addr_t orig_addr, size_t alloc_size,
> -		unsigned int alloc_align_mask)
> +static int swiotlb_search_area(struct device *dev, int start_cpu,
> +		int cpu_offset, phys_addr_t orig_addr, size_t alloc_size,
> +		unsigned int alloc_align_mask, struct io_tlb_pool **retpool)
>  {
> -	int start = raw_smp_processor_id() & (pool->nareas - 1);
> -	int i = start, index;
> -
> -	do {
> -		index = swiotlb_area_find_slots(dev, pool, i, orig_addr,
> -						alloc_size, alloc_align_mask);
> -		if (index >= 0)
> -			return index;
> -		if (++i >= pool->nareas)
> -			i = 0;
> -	} while (i != start);
> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	struct io_tlb_pool *pool;
> +	int area_index;
> +	int index = -1;
>  
> -	return -1;
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(pool, &mem->pools, node) {
> +		if (cpu_offset >= pool->nareas)
> +			continue;
> +		area_index = (start_cpu + cpu_offset) & (pool->nareas - 1);
> +		index = swiotlb_search_pool_area(dev, pool, area_index,
> +						 orig_addr, alloc_size,
> +						 alloc_align_mask);
> +		if (index >= 0) {
> +			*retpool = pool;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return index;
>  }
>  
> -#ifdef CONFIG_SWIOTLB_DYNAMIC
> -
>  /**
>   * swiotlb_find_slots() - search for slots in the whole swiotlb
>   * @dev:	Device which maps the buffer.
> @@ -1124,18 +1133,17 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  	unsigned long nslabs;
>  	unsigned long flags;
>  	u64 phys_limit;
> +	int cpu, i;
>  	int index;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(pool, &mem->pools, node) {
> -		index = swiotlb_pool_find_slots(dev, pool, orig_addr,
> -						alloc_size, alloc_align_mask);
> -		if (index >= 0) {
> -			rcu_read_unlock();
> +	cpu = raw_smp_processor_id();
> +	for (i = 0; i < default_nareas; ++i) {
> +		index = swiotlb_search_area(dev, cpu, i, orig_addr, alloc_size,
> +					    alloc_align_mask, &pool);
> +		if (index >= 0)
>  			goto found;
> -		}
>  	}
> -	rcu_read_unlock();
> +
>  	if (!mem->can_grow)
>  		return -1;
>  
> @@ -1148,8 +1156,8 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  	if (!pool)
>  		return -1;
>  
> -	index = swiotlb_pool_find_slots(dev, pool, orig_addr,
> -					alloc_size, alloc_align_mask);
> +	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr,
> +					 alloc_size, alloc_align_mask);
>  	if (index < 0) {
>  		swiotlb_dyn_free(&pool->rcu);
>  		return -1;
> @@ -1192,9 +1200,21 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  		size_t alloc_size, unsigned int alloc_align_mask,
>  		struct io_tlb_pool **retpool)
>  {
> -	*retpool = &dev->dma_io_tlb_mem->defpool;
> -	return swiotlb_pool_find_slots(dev, *retpool,
> -				       orig_addr, alloc_size, alloc_align_mask);
> +	struct io_tlb_pool *pool;
> +	int start, i;
> +	int index;
> +
> +	*retpool = pool = &dev->dma_io_tlb_mem->defpool;
> +	i = start = raw_smp_processor_id() & (pool->nareas - 1);
> +	do {
> +		index = swiotlb_search_pool_area(dev, pool, i, orig_addr,
> +						 alloc_size, alloc_align_mask);
> +		if (index >= 0)
> +			return index;
> +		if (++i >= pool->nareas)
> +			i = 0;
> +	} while (i != start);
> +	return -1;
>  }
>  
>  #endif /* CONFIG_SWIOTLB_DYNAMIC */

