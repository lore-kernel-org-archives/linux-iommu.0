Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBFA7468
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DE151595;
	Wed, 22 Nov 2023 05:09:12 -0800 (PST)
Received: from [10.57.82.227] (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27DEB3F7A6;
	Wed, 22 Nov 2023 05:08:22 -0800 (PST)
Message-ID: <501de6e6-420b-4419-bc8f-66327875e1ca@arm.com>
Date: Wed, 22 Nov 2023 13:08:20 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu: Allow passing custom allocators to pgtable
 drivers
Content-Language: en-GB
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>, Gaurav Kohli <quic_gkohli@quicinc.com>,
 Steven Price <steven.price@arm.com>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
 <20231110094352.565347-2-boris.brezillon@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231110094352.565347-2-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-10 9:43 am, Boris Brezillon wrote:
> This will be useful for GPU drivers who want to keep page tables in a
> pool so they can:
> 
> - keep freed page tables in a free pool and speed-up upcoming page
>    table allocations
> - batch page table allocation instead of allocating one page at a time
> - pre-reserve pages for page tables needed for map/unmap operations,
>    to ensure map/unmap operations don't try to allocate memory in paths
>    they're allowed to block or fail
> 
> It might also be valuable for other aspects of GPU and similar
> use-cases, like fine-grained memory accounting and resource limiting.
> 
> We will extend the Arm LPAE format to support custom allocators in a
> separate commit.

A couple of very minor nits below, but regardless,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
> v2:
> - Add Steven R-b
> - Expand on possible use-cases for custom allocators
> - Add a caps fields to io_pgtable_init_fns so we can simplify the
>    check_custom_allocator() logic (Robin Murphy)
> ---
>   drivers/iommu/io-pgtable.c | 23 +++++++++++++++++++++++
>   include/linux/io-pgtable.h | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index b843fcd365d2..4febf73c83ff 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -34,6 +34,26 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
>   #endif
>   };
>   
> +static int check_custom_allocator(enum io_pgtable_fmt fmt,
> +				  struct io_pgtable_cfg *cfg)
> +{
> +	/* When passing a custom allocator, both the alloc and free
> +	 * functions should be provided.
> +	 */
> +	if ((cfg->alloc != NULL) != (cfg->free != NULL))
> +		return -EINVAL;
> +
> +	/* No custom allocator, no need to check the format. */
> +	if (!cfg->alloc)
> +		return 0;

I can see why you've done it this way round, but logically it seems 
weird to check that the allocator is valid *before* checking that we 
have an allocator. My instinct would be something like:

	if (!cfg->alloc && !cfg->free)
		return 0;

	if (!cfg->alloc || !cfg->free)
		return -EINVAL

but yeah, I'm still not sure it's *significantly* more readable :/

> +
> +	/* Make sure the format supports custom allocators. */
> +	if (io_pgtable_init_table[fmt]->caps & IO_PGTABLE_CAP_CUSTOM_ALLOCATOR)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
>   struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
>   					    struct io_pgtable_cfg *cfg,
>   					    void *cookie)
> @@ -44,6 +64,9 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
>   	if (fmt >= IO_PGTABLE_NUM_FMTS)
>   		return NULL;
>   
> +	if (check_custom_allocator(fmt, cfg))
> +		return NULL;
> +
>   	fns = io_pgtable_init_table[fmt];
>   	if (!fns)
>   		return NULL;
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 1b7a44b35616..17681ac678ee 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -100,6 +100,27 @@ struct io_pgtable_cfg {
>   	const struct iommu_flush_ops	*tlb;
>   	struct device			*iommu_dev;
>   
> +	/**
> +	 * @alloc: Custom page allocator.
> +	 *
> +	 * Optional hook used to allocate page tables. If this function is NULL,
> +	 * @free must be NULL too.
> +	 *
> +	 * Not all formats support custom page allocators. Before considering
> +	 * passing a non-NULL value, make sure the chosen page format supports
> +	 * this feature.
> +	 */
> +	void *(*alloc)(void *cookie, size_t size, gfp_t gfp);
> +
> +	/**
> +	 * @free: Custom page de-allocator.
> +	 *
> +	 * Optional hook used to free page tables allocated with the @alloc
> +	 * hook. Must be non-NULL if @alloc is not NULL, must be NULL
> +	 * otherwise.
> +	 */
> +	void (*free)(void *cookie, void *pages, size_t size);
> +
>   	/* Low-level data specific to the table format */
>   	union {
>   		struct {
> @@ -237,14 +258,24 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
>   		iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
>   }
>   
> +/**
> + * enum io_pgtable_caps - IO page table backend capabilities.
> + */
> +enum io_pgtable_caps {
> +	/** @IO_PGTABLE_CAP_CUSTOM_ALLOCATOR: Backend accepts custom page table allocators. */
> +	IO_PGTABLE_CAP_CUSTOM_ALLOCATOR = BIT(0),
> +};
> +
>   /**
>    * struct io_pgtable_init_fns - Alloc/free a set of page tables for a
>    *                              particular format.
>    *
> + * @caps:  Combination of @io_pgtable_caps flags encoding the backend capabilities.
>    * @alloc: Allocate a set of page tables described by cfg.
>    * @free:  Free the page tables associated with iop.
>    */
>   struct io_pgtable_init_fns {
> +	u32 caps;

I'd put this last in the structure for cosmetic and padding reasons.

Cheers,
Robin.

>   	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void *cookie);
>   	void (*free)(struct io_pgtable *iop);
>   };
