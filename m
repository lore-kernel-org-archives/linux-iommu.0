Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10675339BB
	for <iommu@lists.linux.dev>; Wed, 20 Sep 2023 16:42:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FB931FB;
	Wed, 20 Sep 2023 09:42:43 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6994B3F5A1;
	Wed, 20 Sep 2023 09:42:05 -0700 (PDT)
Message-ID: <04ae3d0c-d850-63c7-80bb-f90e26f5b758@arm.com>
Date: Wed, 20 Sep 2023 17:42:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] iommu: Extend LPAE page table format to support
 custom allocators
Content-Language: en-GB
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>
References: <20230809121744.2341454-1-boris.brezillon@collabora.com>
 <20230809121744.2341454-3-boris.brezillon@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230809121744.2341454-3-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/08/2023 1:17 pm, Boris Brezillon wrote:
> We need that in order to implement the VM_BIND ioctl in the GPU driver
> targeting new Mali GPUs.
> 
> VM_BIND is about executing MMU map/unmap requests asynchronously,
> possibly after waiting for external dependencies encoded as dma_fences.
> We intend to use the drm_sched framework to automate the dependency
> tracking and VM job dequeuing logic, but this comes with its own set
> of constraints, one of them being the fact we are not allowed to
> allocate memory in the drm_gpu_scheduler_ops::run_job() to avoid this
> sort of deadlocks:
> 
> - VM_BIND map job needs to allocate a page table to map some memory
>    to the VM. No memory available, so kswapd is kicked
> - GPU driver shrinker backend ends up waiting on the fence attached to
>    the VM map job or any other job fence depending on this VM operation.
> 
> With custom allocators, we will be able to pre-reserve enough pages to
> guarantee the map/unmap operations we queued will take place without
> going through the system allocator. But we can also optimize
> allocation/reservation by not free-ing pages immediately, so any
> upcoming page table allocation requests can be serviced by some free
> page table pool kept at the driver level.

We should bear in mind it's also potentially valuable for other aspects 
of GPU and similar use-cases, like fine-grained memory accounting and 
resource limiting. That's a significant factor in this approach vs. 
internal caching schemes that could only solve the specific reclaim concern.

> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 50 +++++++++++++++++++++++-----------
>   drivers/iommu/io-pgtable.c     | 12 ++++++++
>   2 files changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 72dcdd468cf3..c5c04f0106f3 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -188,20 +188,28 @@ static dma_addr_t __arm_lpae_dma_addr(void *pages)
>   }
>   
>   static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
> -				    struct io_pgtable_cfg *cfg)
> +				    struct io_pgtable_cfg *cfg,
> +				    void *cookie)
>   {
>   	struct device *dev = cfg->iommu_dev;
>   	int order = get_order(size);
> -	struct page *p;
>   	dma_addr_t dma;
>   	void *pages;
>   
>   	VM_BUG_ON((gfp & __GFP_HIGHMEM));
> -	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
> -	if (!p)
> +
> +	if (cfg->alloc) {
> +		pages = cfg->alloc(cookie, size, gfp | __GFP_ZERO);

I think it should be a fundamental requirement of the interface that an 
allocator always returns zeroed pages, since there's no obvious use-case 
for it ever not doing so. Ideally I'd like to not pass a gfp value at 
all, given the intent that a custom allocator will typically be 
something *other* than alloc_pages() by necessity, but it's conceivable 
that contextual flags like GFP_ATOMIC and __GFP_NOWARN could still be 
meaningful, so ultimately it doesn't really seem worthwhile trying to 
re-encode them differently just for the sake of it.

> +	} else {
> +		struct page *p;
> +
> +		p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
> +		pages = p ? page_address(p) : NULL;
> +	}
> +
> +	if (!pages)
>   		return NULL;
>   
> -	pages = page_address(p);
>   	if (!cfg->coherent_walk) {
>   		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
>   		if (dma_mapping_error(dev, dma))
> @@ -220,18 +228,28 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>   out_unmap:
>   	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
>   	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
> +
>   out_free:
> -	__free_pages(p, order);
> +	if (cfg->free)
> +		cfg->free(cookie, pages, size);
> +	else
> +		free_pages((unsigned long)pages, order);
> +
>   	return NULL;
>   }
>   
>   static void __arm_lpae_free_pages(void *pages, size_t size,
> -				  struct io_pgtable_cfg *cfg)
> +				  struct io_pgtable_cfg *cfg,
> +				  void *cookie)
>   {
>   	if (!cfg->coherent_walk)
>   		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
>   				 size, DMA_TO_DEVICE);
> -	free_pages((unsigned long)pages, get_order(size));
> +
> +	if (cfg->free)
> +		cfg->free(cookie, pages, size);
> +	else
> +		free_pages((unsigned long)pages, get_order(size));
>   }
>   
>   static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
> @@ -373,13 +391,13 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>   	/* Grab a pointer to the next level */
>   	pte = READ_ONCE(*ptep);
>   	if (!pte) {
> -		cptep = __arm_lpae_alloc_pages(tblsz, gfp, cfg);
> +		cptep = __arm_lpae_alloc_pages(tblsz, gfp, cfg, data->iop.cookie);
>   		if (!cptep)
>   			return -ENOMEM;
>   
>   		pte = arm_lpae_install_table(cptep, ptep, 0, data);
>   		if (pte)
> -			__arm_lpae_free_pages(cptep, tblsz, cfg);
> +			__arm_lpae_free_pages(cptep, tblsz, cfg, data->iop.cookie);
>   	} else if (!cfg->coherent_walk && !(pte & ARM_LPAE_PTE_SW_SYNC)) {
>   		__arm_lpae_sync_pte(ptep, 1, cfg);
>   	}
> @@ -524,7 +542,7 @@ static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
>   		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
>   	}
>   
> -	__arm_lpae_free_pages(start, table_size, &data->iop.cfg);
> +	__arm_lpae_free_pages(start, table_size, &data->iop.cfg, data->iop.cookie);
>   }
>   
>   static void arm_lpae_free_pgtable(struct io_pgtable *iop)
> @@ -552,7 +570,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>   		return 0;
>   
> -	tablep = __arm_lpae_alloc_pages(tablesz, GFP_ATOMIC, cfg);
> +	tablep = __arm_lpae_alloc_pages(tablesz, GFP_ATOMIC, cfg, data->iop.cookie);
>   	if (!tablep)
>   		return 0; /* Bytes unmapped */
>   
> @@ -575,7 +593,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   
>   	pte = arm_lpae_install_table(tablep, ptep, blk_pte, data);
>   	if (pte != blk_pte) {
> -		__arm_lpae_free_pages(tablep, tablesz, cfg);
> +		__arm_lpae_free_pages(tablep, tablesz, cfg, data->iop.cookie);
>   		/*
>   		 * We may race against someone unmapping another part of this
>   		 * block, but anything else is invalid. We can't misinterpret
> @@ -882,7 +900,7 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   
>   	/* Looking good; allocate a pgd */
>   	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
> -					   GFP_KERNEL, cfg);
> +					   GFP_KERNEL, cfg, cookie);
>   	if (!data->pgd)
>   		goto out_free_data;
>   
> @@ -984,7 +1002,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>   
>   	/* Allocate pgd pages */
>   	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
> -					   GFP_KERNEL, cfg);
> +					   GFP_KERNEL, cfg, cookie);
>   	if (!data->pgd)
>   		goto out_free_data;
>   
> @@ -1059,7 +1077,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>   		 << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV));
>   
>   	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
> -					   cfg);
> +					   cfg, cookie);
>   	if (!data->pgd)
>   		goto out_free_data;
>   
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index f4caf630638a..e273c18ae22b 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -47,6 +47,18 @@ static int check_custom_allocator(enum io_pgtable_fmt fmt,
>   	if (!cfg->alloc)
>   		return 0;
>   
> +	switch (fmt) {
> +	case ARM_32_LPAE_S1:
> +	case ARM_32_LPAE_S2:
> +	case ARM_64_LPAE_S1:
> +	case ARM_64_LPAE_S2:
> +	case ARM_MALI_LPAE:
> +		return 0;

I remain not entirely convinced by the value of this, but could it at 
least be done in a more scalable manner like some kind of flag provided 
by the format itself?

Thanks,
Robin.


> +
> +	default:
> +		break;
> +	}
> +
>   	return -EINVAL;
>   }
>   
