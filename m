From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 2/3] iommu/io-pgtable: Add helper functions for TLB ops
Date: Sat, 16 Jan 2016 01:24:46 +0200
Message-ID: <2259104.4U5Th3i3Hp@avalon>
References: <cover.1450383740.git.robin.murphy@arm.com>
	<a2a13711c528af068e932ce6af4c3be50bef5812.1450383740.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a2a13711c528af068e932ce6af4c3be50bef5812.1450383740.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thank you for the patch.

On Thursday 17 December 2015 20:50:58 Robin Murphy wrote:
> Add some simple wrappers to avoid having the guts of the TLB operations
> spilled all over the page table implementations, and to provide a point
> to implement extra common functionality.

Good idea, that's cleaner.

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 48 ++++++++++++++++-------------------
>  drivers/iommu/io-pgtable-arm.c     | 21 +++++++----------
>  drivers/iommu/io-pgtable.c         |  2 +-
>  drivers/iommu/io-pgtable.h         | 16 +++++++++++++
>  4 files changed, 46 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c
> b/drivers/iommu/io-pgtable-arm-v7s.c index 17800db..3164b6b 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -416,9 +416,7 @@ static int arm_v7s_map(struct io_pgtable_ops *ops,
> unsigned long iova, phys_addr_t paddr, size_t size, int prot)
>  {
>  	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
> -	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> -	const struct iommu_gather_ops *tlb = cfg->tlb;
> -	void *cookie = data->iop.cookie;
> +	struct io_pgtable *iop = &data->iop;
>  	int ret;
> 
>  	/* If no access, then nothing to do */
> @@ -430,10 +428,10 @@ static int arm_v7s_map(struct io_pgtable_ops *ops,
> unsigned long iova, * Synchronise all PTE updates for the new mapping
> before there's * a chance for anything to kick off a table walk for the new
> iova. */
> -	if (cfg->quirks & IO_PGTABLE_QUIRK_TLBI_ON_MAP) {
> -		tlb->tlb_add_flush(iova, size, ARM_V7S_BLOCK_SIZE(2), false,
> -				   cookie);
> -		tlb->tlb_sync(cookie);
> +	if (iop->cfg.quirks & IO_PGTABLE_QUIRK_TLBI_ON_MAP) {
> +		io_pgtable_tlb_add_flush(iop, iova, size,
> +					 ARM_V7S_BLOCK_SIZE(2), false);
> +		io_pgtable_tlb_sync(iop);
>  	} else {
>  		wmb();
>  	}
> @@ -461,8 +459,7 @@ static void arm_v7s_split_cont(struct arm_v7s_io_pgtable
> *data, unsigned long iova, int idx, int lvl,
>  			       arm_v7s_iopte *ptep)
>  {
> -	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> -	void *cookie = data->iop.cookie;
> +	struct io_pgtable *iop = &data->iop;
>  	arm_v7s_iopte pte;
>  	size_t size = ARM_V7S_BLOCK_SIZE(lvl);
>  	int i;
> @@ -474,11 +471,11 @@ static void arm_v7s_split_cont(struct
> arm_v7s_io_pgtable *data, pte += size;
>  	}
> 
> -	__arm_v7s_pte_sync(ptep, ARM_V7S_CONT_PAGES, cfg);
> +	__arm_v7s_pte_sync(ptep, ARM_V7S_CONT_PAGES, &iop->cfg);
> 
>  	size *= ARM_V7S_CONT_PAGES;
> -	cfg->tlb->tlb_add_flush(iova, size, size, true, cookie);
> -	cfg->tlb->tlb_sync(cookie);
> +	io_pgtable_tlb_add_flush(iop, iova, size, size, true);
> +	io_pgtable_tlb_sync(iop);
>  }
> 
>  static int arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
> @@ -488,7 +485,6 @@ static int arm_v7s_split_blk_unmap(struct
> arm_v7s_io_pgtable *data, unsigned long blk_start, blk_end, blk_size;
>  	phys_addr_t blk_paddr;
>  	arm_v7s_iopte table = 0;
> -	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>  	int prot = arm_v7s_pte_to_prot(*ptep, 1);
> 
>  	blk_size = ARM_V7S_BLOCK_SIZE(1);
> @@ -516,9 +512,9 @@ static int arm_v7s_split_blk_unmap(struct
> arm_v7s_io_pgtable *data, }
>  	}
> 
> -	__arm_v7s_set_pte(ptep, table, 1, cfg);
> +	__arm_v7s_set_pte(ptep, table, 1, &data->iop.cfg);
>  	iova &= ~(blk_size - 1);
> -	cfg->tlb->tlb_add_flush(iova, blk_size, blk_size, true, data-
>iop.cookie);
> +	io_pgtable_tlb_add_flush(&data->iop, iova, blk_size, blk_size, true);
> return size;
>  }
> 
> @@ -527,9 +523,7 @@ static int __arm_v7s_unmap(struct arm_v7s_io_pgtable
> *data, arm_v7s_iopte *ptep)
>  {
>  	arm_v7s_iopte pte[ARM_V7S_CONT_PAGES];
> -	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> -	const struct iommu_gather_ops *tlb = cfg->tlb;
> -	void *cookie = data->iop.cookie;
> +	struct io_pgtable *iop = &data->iop;
>  	int idx, i = 0, num_entries = size >> ARM_V7S_LVL_SHIFT(lvl);
> 
>  	/* Something went horribly wrong and we ran out of page table */
> @@ -555,20 +549,19 @@ static int __arm_v7s_unmap(struct arm_v7s_io_pgtable
> *data, if (num_entries) {
>  		size_t blk_size = ARM_V7S_BLOCK_SIZE(lvl);
> 
> -		__arm_v7s_set_pte(ptep, 0, num_entries, cfg);
> +		__arm_v7s_set_pte(ptep, 0, num_entries, &iop->cfg);
> 
>  		for (i = 0; i < num_entries; i++) {
>  			if (ARM_V7S_PTE_IS_TABLE(pte[i], lvl)) {
>  				/* Also flush any partial walks */
> -				tlb->tlb_add_flush(iova, blk_size,
> -						   ARM_V7S_BLOCK_SIZE(lvl + 1),
> -						   false, cookie);
> -				tlb->tlb_sync(cookie);
> +				io_pgtable_tlb_add_flush(iop, iova, blk_size,
> +					ARM_V7S_BLOCK_SIZE(lvl + 1), false);
> +				io_pgtable_tlb_sync(iop);
>  				ptep = iopte_deref(pte[i], lvl);
>  				__arm_v7s_free_table(ptep, lvl + 1, data);
>  			} else {
> -				tlb->tlb_add_flush(iova, blk_size, blk_size,
> -						   true, cookie);
> +				io_pgtable_tlb_add_flush(iop, iova, blk_size,
> +							 blk_size, true);
>  			}
>  			iova += blk_size;
>  		}
> @@ -589,13 +582,12 @@ static int __arm_v7s_unmap(struct arm_v7s_io_pgtable
> *data, static int arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long
> iova, size_t size)
>  {
> -	size_t unmapped;
>  	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
> -	struct io_pgtable *iop = &data->iop;
> +	size_t unmapped;
> 
>  	unmapped = __arm_v7s_unmap(data, iova, size, 1, data->pgd);
>  	if (unmapped)
> -		iop->cfg.tlb->tlb_sync(iop->cookie);
> +		io_pgtable_tlb_sync(&data->iop);
> 
>  	return unmapped;
>  }
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 8bbcbfe..4095af2 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -445,7 +445,6 @@ static int arm_lpae_split_blk_unmap(struct
> arm_lpae_io_pgtable *data, unsigned long blk_start, blk_end;
>  	phys_addr_t blk_paddr;
>  	arm_lpae_iopte table = 0;
> -	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> 
>  	blk_start = iova & ~(blk_size - 1);
>  	blk_end = blk_start + blk_size;
> @@ -471,9 +470,9 @@ static int arm_lpae_split_blk_unmap(struct
> arm_lpae_io_pgtable *data, }
>  	}
> 
> -	__arm_lpae_set_pte(ptep, table, cfg);
> +	__arm_lpae_set_pte(ptep, table, &data->iop.cfg);
>  	iova &= ~(blk_size - 1);
> -	cfg->tlb->tlb_add_flush(iova, blk_size, blk_size, true, data-
>iop.cookie);
> +	io_pgtable_tlb_add_flush(&data->iop, iova, blk_size, blk_size, true);
> return size;
>  }
> 
> @@ -482,8 +481,7 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable
> *data, arm_lpae_iopte *ptep)
>  {
>  	arm_lpae_iopte pte;
> -	const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> -	void *cookie = data->iop.cookie;
> +	struct io_pgtable *iop = &data->iop;
>  	size_t blk_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> 
>  	/* Something went horribly wrong and we ran out of page table */
> @@ -497,17 +495,17 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable
> *data,
> 
>  	/* If the size matches this level, we're in the right place */
>  	if (size == blk_size) {
> -		__arm_lpae_set_pte(ptep, 0, &data->iop.cfg);
> +		__arm_lpae_set_pte(ptep, 0, &iop->cfg);
> 
>  		if (!iopte_leaf(pte, lvl)) {
>  			/* Also flush any partial walks */
> -			tlb->tlb_add_flush(iova, size, ARM_LPAE_GRANULE(data),
> -					   false, cookie);
> -			tlb->tlb_sync(cookie);
> +			io_pgtable_tlb_add_flush(iop, iova, size,
> +						ARM_LPAE_GRANULE(data), false);
> +			io_pgtable_tlb_sync(iop);
>  			ptep = iopte_deref(pte, data);
>  			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
>  		} else {
> -			tlb->tlb_add_flush(iova, size, size, true, cookie);
> +			io_pgtable_tlb_add_flush(iop, iova, size, size, true);
>  		}
> 
>  		return size;
> @@ -531,13 +529,12 @@ static int arm_lpae_unmap(struct io_pgtable_ops *ops,
> unsigned long iova, {
>  	size_t unmapped;
>  	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> -	struct io_pgtable *iop = &data->iop;
>  	arm_lpae_iopte *ptep = data->pgd;
>  	int lvl = ARM_LPAE_START_LVL(data);
> 
>  	unmapped = __arm_lpae_unmap(data, iova, size, lvl, ptep);
>  	if (unmapped)
> -		iop->cfg.tlb->tlb_sync(iop->cookie);
> +		io_pgtable_tlb_sync(&data->iop);
> 
>  	return unmapped;
>  }
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index 8c615b7..876f6a7 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -75,6 +75,6 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops)
>  		return;
> 
>  	iop = container_of(ops, struct io_pgtable, ops);
> -	iop->cfg.tlb->tlb_flush_all(iop->cookie);
> +	io_pgtable_tlb_flush_all(iop);
>  	io_pgtable_init_table[iop->fmt]->free(iop);
>  }
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index aa57073..95c5565 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -144,6 +144,22 @@ struct io_pgtable {
> 
>  #define io_pgtable_ops_to_pgtable(x) container_of((x), struct io_pgtable,
> ops)
> 
> +static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
> +{
> +	iop->cfg.tlb->tlb_flush_all(iop->cookie);
> +}
> +
> +static inline void io_pgtable_tlb_add_flush(struct io_pgtable *iop,
> +		unsigned long iova, size_t size, size_t granule, bool leaf)
> +{
> +	iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf, iop->cookie);
> +}
> +
> +static inline void io_pgtable_tlb_sync(struct io_pgtable *iop)
> +{
> +	iop->cfg.tlb->tlb_sync(iop->cookie);
> +}
> +
>  /**
>   * struct io_pgtable_init_fns - Alloc/free a set of page tables for a
>   *                              particular format.

-- 
Regards,

Laurent Pinchart
