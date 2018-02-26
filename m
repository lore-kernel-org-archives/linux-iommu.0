From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/4] iommu/io-pgtable-arm: Support 52-bit physical
	address
Date: Mon, 26 Feb 2018 18:05:01 +0000
Message-ID: <20180226180501.GC26147@arm.com>
References: <cover.1512038236.git.robin.murphy@arm.com>
	<fde583dacee8099ed4e952dbf1c4dfb42070e9c5.1512038236.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fde583dacee8099ed4e952dbf1c4dfb42070e9c5.1512038236.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kristina.martsenko-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 14, 2017 at 04:58:51PM +0000, Robin Murphy wrote:
> Bring io-pgtable-arm in line with the ARMv8.2-LPA feature allowing
> 52-bit physical addresses when using the 64KB translation granule.
> This will be supported by SMMUv3.1.
> 
> Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: Fix TCR_PS/TCR_IPS copy-paste error
> 
>  drivers/iommu/io-pgtable-arm.c | 65 ++++++++++++++++++++++++++++++------------
>  1 file changed, 47 insertions(+), 18 deletions(-)

[...]

> @@ -203,6 +199,25 @@ struct arm_lpae_io_pgtable {
>  
>  typedef u64 arm_lpae_iopte;
>  
> +static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
> +				     struct arm_lpae_io_pgtable *data)
> +{
> +	arm_lpae_iopte pte = paddr;
> +
> +	/* Of the bits which overlap, either 51:48 or 15:12 are always RES0 */
> +	return (pte | (pte >> 36)) & ARM_LPAE_PTE_ADDR_MASK;
> +}

I don't particularly like relying on properties of the paddr for correct
construction of the pte here. The existing macro doesn't have this
limitation. I suspect it's all fine at the moment because we only use TTBR0,
but I'd rather not bake that in if we can avoid it.

> +static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
> +				  struct arm_lpae_io_pgtable *data)
> +{
> +	phys_addr_t paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
> +	phys_addr_t paddr_hi = paddr & (ARM_LPAE_GRANULE(data) - 1);
> +
> +	/* paddr_hi spans nothing for 4K granule, and only RES0 bits for 16K */
> +	return (paddr ^ paddr_hi) | (paddr_hi << 36);

Why do we need xor here?

>  static bool selftest_running = false;
>  
>  static dma_addr_t __arm_lpae_dma_addr(void *pages)
> @@ -287,7 +302,7 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>  		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
>  
>  	pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
> -	pte |= pfn_to_iopte(paddr >> data->pg_shift, data);
> +	pte |= paddr_to_iopte(paddr, data);
>  
>  	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
>  }
> @@ -528,7 +543,7 @@ static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>  	if (size == split_sz)
>  		unmap_idx = ARM_LPAE_LVL_IDX(iova, lvl, data);
>  
> -	blk_paddr = iopte_to_pfn(blk_pte, data) << data->pg_shift;
> +	blk_paddr = iopte_to_paddr(blk_pte, data);
>  	pte = iopte_prot(blk_pte);
>  
>  	for (i = 0; i < tablesz / sizeof(pte); i++, blk_paddr += split_sz) {
> @@ -652,12 +667,13 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>  
>  found_translation:
>  	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
> -	return ((phys_addr_t)iopte_to_pfn(pte,data) << data->pg_shift) | iova;
> +	return iopte_to_paddr(pte, data) | iova;
>  }
>  
>  static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>  {
> -	unsigned long granule;
> +	unsigned long granule, page_sizes;
> +	unsigned int max_addr_bits = 48;
>  
>  	/*
>  	 * We need to restrict the supported page sizes to match the
> @@ -677,17 +693,24 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>  
>  	switch (granule) {
>  	case SZ_4K:
> -		cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
> +		page_sizes = (SZ_4K | SZ_2M | SZ_1G);
>  		break;
>  	case SZ_16K:
> -		cfg->pgsize_bitmap &= (SZ_16K | SZ_32M);
> +		page_sizes = (SZ_16K | SZ_32M);
>  		break;
>  	case SZ_64K:
> -		cfg->pgsize_bitmap &= (SZ_64K | SZ_512M);
> +		max_addr_bits = 52;
> +		page_sizes = (SZ_64K | SZ_512M);
> +		if (cfg->oas > 48)
> +			page_sizes |= 1ULL << 42; /* 4TB */
>  		break;
>  	default:
> -		cfg->pgsize_bitmap = 0;
> +		page_sizes = 0;
>  	}
> +
> +	cfg->pgsize_bitmap &= page_sizes;
> +	cfg->ias = min(cfg->ias, max_addr_bits);
> +	cfg->oas = min(cfg->oas, max_addr_bits);

I don't think we should be writing to the ias/oas fields here, at least
now without auditing the drivers and updating the comments about the
io-pgtable API. For example, the SMMUv3 driver uses its own ias local
variable to initialise the domain geometry, and won't pick up any changes
made here.

Will
