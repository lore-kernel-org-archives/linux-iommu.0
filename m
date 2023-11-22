Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB94D5AD
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 561DE1595;
	Wed, 22 Nov 2023 06:24:54 -0800 (PST)
Received: from [10.57.82.227] (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D5FB3F7A6;
	Wed, 22 Nov 2023 06:24:06 -0800 (PST)
Message-ID: <4059ba61-07f5-4551-b8b8-37aa77554038@arm.com>
Date: Wed, 22 Nov 2023 14:24:04 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommu: Extend LPAE page table format to support
 custom allocators
Content-Language: en-GB
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>, Gaurav Kohli <quic_gkohli@quicinc.com>,
 Steven Price <steven.price@arm.com>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
 <20231110094352.565347-3-boris.brezillon@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231110094352.565347-3-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-10 9:43 am, Boris Brezillon wrote:
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
> 
> I might also be valuable for other aspects of GPU and similar
> use-cases, like fine-grained memory accounting and resource limiting.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
> v2:
> - Add Steven R-b
> - Expand on possible use-cases for custom allocators
> ---
>   drivers/iommu/io-pgtable-arm.c | 55 ++++++++++++++++++++++++----------
>   1 file changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 72dcdd468cf3..4a4e2c315083 100644
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

It makes no sense for a dedicated allocator here to ever be able to 
return non-zeroed pagetables, so I'd rather avoid giving that impression 
via adding __GFP_ZERO here. As before, logically the allocator should be 
inherently responsible for zeroing the memory and we're only passing gfp 
through for the sake of what it might represent about the calling 
context; alloc_pages_node() is just the special case since it's *not* a 
dedicated pagetable allocator and the way to get it to return zeroed 
memory happens to also be a gfp flag.

I guess it's worth the @alloc kerneldoc in patch #1 explicitly calling 
out the expectations that the memory it returns should be zeroed, and 
suitable for dma_map_single() and virt_to_phys() (which does still 
constrain us to page-backed kernel memory for now, although it doesn't 
seem overly difficult to add sync and virt_to_phys methods if we wanted 
to completely generalise things in future).

With that fixed,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

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
> @@ -1080,26 +1098,31 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>   }
>   
>   struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
> +	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
>   	.alloc	= arm_64_lpae_alloc_pgtable_s1,
>   	.free	= arm_lpae_free_pgtable,
>   };
>   
>   struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = {
> +	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
>   	.alloc	= arm_64_lpae_alloc_pgtable_s2,
>   	.free	= arm_lpae_free_pgtable,
>   };
>   
>   struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = {
> +	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
>   	.alloc	= arm_32_lpae_alloc_pgtable_s1,
>   	.free	= arm_lpae_free_pgtable,
>   };
>   
>   struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
> +	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
>   	.alloc	= arm_32_lpae_alloc_pgtable_s2,
>   	.free	= arm_lpae_free_pgtable,
>   };
>   
>   struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
> +	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
>   	.alloc	= arm_mali_lpae_alloc_pgtable,
>   	.free	= arm_lpae_free_pgtable,
>   };
