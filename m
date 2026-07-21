Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8113EDF6C
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652722; cv=none; b=jp7xgthIjVuS1h6kQlaQs7nFEGxCg+Y/xmNO386llzSFbvwjkP07ssuc7ouDfODBdx4dknBeSEMeHDFfr7IP9vpGeiCHbPnqjvynzXKDwFfU0aFoQrSX7UfEkkBHRTHITSub6ZkMfJEtSQBL3MITmRSULioE/gk85UI7VEqZ7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652722; c=relaxed/simple;
	bh=2gr/BESiJ3kodzJBF5f2mgZcxG03bcuZ59hnvhuJXQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nL+j0oUSxSlBuVLhYc20NjYMKE+yf8+I9xOmB6dsBi+UjgdKTL4IGLGv5bED52aBI/k/2rWDh4njolbGSwt3JHbtlUy1vZ+O+IfbGZHh9FKIniRzlLtAVM09yZlf3mvQ6OanuDde5VE66s3NWw2yyorg1wRfYjKMugqxxre44ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bN4o1aFM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bN4o1aFM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899C41595;
	Tue, 21 Jul 2026 09:51:54 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E207D3F86F;
	Tue, 21 Jul 2026 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784652718; bh=2gr/BESiJ3kodzJBF5f2mgZcxG03bcuZ59hnvhuJXQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bN4o1aFMcwa3S9SAqoIL1boAMeE3gZP9TOluuP4zN0UfLC+3w28cwjvIdoqQ7Rp42
	 i1PzPalj7/iIyhwYgeBbvJYm1gimbM4tmwbRkjhgwt+2rDlRpImzZYVloqhn9lYEJC
	 xpWBUjvQazoymwpYYFMaczeTJrYTZtACw5e4Jhs0=
Message-ID: <135476af-6f4b-49d5-9727-af77465a79b9@arm.com>
Date: Tue, 21 Jul 2026 17:51:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260721-iommu_contig_hint-v2-1-90c731a41163@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260721-iommu_contig_hint-v2-1-90c731a41163@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/07/2026 4:28 am, Vijayanand Jitta wrote:
> From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> 
> Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
> When a set of consecutive PTEs map a naturally-aligned contiguous block
> of memory, the CONT bit can be set on all entries in the group to allow
> the hardware to combine them into a single TLB entry, improving TLB
> utilization.
> 
> The contiguous hint sizes per granule are:
> 
>    Page Size | CONT PTE |  Block  | CONT Block | L1 Block | CONT L1
>    ----------+----------+---------+------------+----------+---------
>        4K    |   64K    |   2M    |    32M     |    1G    |   16G
>       16K    |    2M    |  32M    |     1G     |          |
>       64K    |    2M    | 512M    |    16G     |          |
> 
> Contiguous hint sizes are advertised in pgsize_bitmap so that IOMMU API
> users can align allocations to these sizes and benefit from the TLB
> optimization automatically.
> 
> Partial unmaps of a contiguous group are rejected, ensuring the full
> group is always invalidated as a unit. The
> IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disable
> contiguous hint support at runtime for hardware with
> implementation-specific errata.
> 
> Co-developed-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> ---
> Changes in v2:
> - Extend contiguous hint support to level-1 (1G) blocks for the 4K granule,
>    adding a CONT L1 (16G) grouping alongside the existing CONT PTE/CONT Block
>    sizes.
> - Replace the compile-time CONFIG_IOMMU_IO_PGTABLE_CONTIG_HINT Kconfig option
>    with a runtime quirk, IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT, so SMMU drivers
>    can opt out per page table instance instead of at build time.
> - Simplify __arm_lpae_map() to program the CONT-sized block directly via
>    arm_lpae_init_pte() instead of recursing into the next level with an
>    adjusted pgcount.
> - Reject unmaps that are not aligned to the contiguous group size with
>    WARN_ON_ONCE(), instead of clearing the CONT bit on a partial group before
>    invalidation.
> - Link to v1: https://patch.msgid.link/20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com
> 
> To: Will Deacon <will@kernel.org>
> To: Robin Murphy <robin.murphy@arm.com>
> To: "Joerg Roedel (AMD)" <joro@8bytes.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/iommu/io-pgtable-arm.c | 167 +++++++++++++++++++++++++++++++++++++++--
>   include/linux/io-pgtable.h     |   3 +
>   2 files changed, 162 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 476c0e25631af..241efa37f8631 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -86,6 +86,21 @@
>   /* Software bit for solving coherency races */
>   #define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
>   
> +/* PTE Contiguous Bit */
> +#define ARM_LPAE_PTE_CONT		(((arm_lpae_iopte)1) << 52)
> +
> +/*
> + * CONTIG HINT SUPPORT TABLE
> + *
> + *------------------------------------------------------------------
> + *| Page Size | CONT PTE |  Block  | CONT Block | L1 Block | CONT L1 |
> + *------------------------------------------------------------------
> + *|     4K    |   64K    |   2M    |    32M     |    1G    |   16G   |
> + *|    16K    |    2M    |  32M    |     1G     |          |         |
> + *|    64K    |    2M    | 512M    |    16G     |          |         |
> + *------------------------------------------------------------------
> + */
> +
>   /* Stage-1 PTE */
>   #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
>   #define ARM_LPAE_PTE_AP_RDONLY_BIT	7
> @@ -453,6 +468,112 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
>   	return old;
>   }
>   
> +static inline bool arm_lpae_cont_hint_enabled(struct io_pgtable_cfg *cfg)
> +{
> +	return !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT);
> +}
> +
> +static inline int arm_lpae_cont_ptes(unsigned long size)
> +{
> +	if (size == SZ_4K)
> +		return 16;
> +	if (size == SZ_16K)
> +		return 128;
> +	if (size == SZ_64K)
> +		return 32;
> +	return 1;
> +}
> +
> +static inline unsigned long arm_lpae_cont_pte_size(unsigned long size)
> +{
> +	return arm_lpae_cont_ptes(size) * size;
> +}
> +
> +static inline int arm_lpae_cont_blks(unsigned long size)
> +{
> +	if (size == SZ_2M)
> +		return 16;
> +	if (size == SZ_32M)
> +		return 32;
> +	if (size == SZ_512M)
> +		return 32;
> +	if (size == SZ_1G)
> +		return 16;
> +	return 1;
> +}
> +
> +static inline unsigned long arm_lpae_cont_blk_size(unsigned long size)
> +{
> +	return arm_lpae_cont_blks(size) * size;
> +}
> +
> +static unsigned long arm_lpae_get_cont_sizes(struct io_pgtable_cfg *cfg)
> +{
> +	unsigned long pg_size, blk_size, cont_sizes;
> +	int pg_shift, bits_per_level;
> +
> +	if (!cfg->pgsize_bitmap || !arm_lpae_cont_hint_enabled(cfg))
> +		return 0;
> +
> +	pg_shift = __ffs(cfg->pgsize_bitmap);
> +	bits_per_level = pg_shift - ilog2(sizeof(arm_lpae_iopte));
> +	pg_size = (1UL << pg_shift);
> +	blk_size = (pg_size << bits_per_level);
> +
> +	cont_sizes = arm_lpae_cont_pte_size(pg_size) |
> +		     arm_lpae_cont_blk_size(blk_size);
> +
> +	/*
> +	 * Only add the level-1 contiguous block size if level-1 block mappings
> +	 * are supported for this granule. For 16K and 64K granules, level-1
> +	 * block mappings do not exist, so blk_size << bits_per_level would not
> +	 * be in pgsize_bitmap after arm_lpae_restrict_pgsizes() has filtered it.
> +	 * For 4K granule, 1G blocks are supported, giving a 16G contiguous group.
> +	 */
> +	if (cfg->pgsize_bitmap & (blk_size << bits_per_level))
> +		cont_sizes |= arm_lpae_cont_blk_size(blk_size << bits_per_level);
> +
> +	return cont_sizes;
> +}
> +
> +static u32 arm_lpae_find_num_cont(struct arm_lpae_io_pgtable *data, int lvl)
> +{
> +	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
> +		return arm_lpae_cont_ptes(ARM_LPAE_BLOCK_SIZE(lvl, data));
> +	else if (lvl >= ARM_LPAE_MAX_LEVELS - 3)
> +		return arm_lpae_cont_blks(ARM_LPAE_BLOCK_SIZE(lvl, data));
> +	else
> +		return 1;
> +}

This still seems horribly overcomplicated - the leaf sizes never 
overlap, and we already have the per-level size to hand in both map and 
unmap, so I wouldn't imagine needing anything more than e.g.:

static int arm_lpae_num_cont(size_t size)
{
	switch (size) {
	case SZ_4K:
	case SZ_2M:
	case SZ_1G:
		return 16;
	case SZ_64K:
	case SZ_32M:
	case SZ_512M:
		return 32;
	case SZ_16K:
		return 128;
	default:
		return 1;
	}
}

> +
> +static u32 arm_lpae_check_num_cont(struct arm_lpae_io_pgtable *data, size_t size, int lvl)
> +{
> +	int num_cont;
> +
> +	num_cont = arm_lpae_find_num_cont(data, lvl);
> +	if (size == num_cont * ARM_LPAE_BLOCK_SIZE(lvl, data))
> +		return num_cont;
> +	else
> +		return 1;
> +}
> +
> +static bool arm_lpae_pte_is_contiguous_range(struct arm_lpae_io_pgtable *data,
> +					     unsigned long size,
> +					     int lvl, u32 *num_cont)
> +{
> +	unsigned long block_size;
> +
> +	if (!arm_lpae_cont_hint_enabled(&data->iop.cfg)) {
> +		*num_cont = 1;
> +		return false;
> +	}
> +
> +	*num_cont = arm_lpae_find_num_cont(data, lvl);
> +	block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +
> +	return size == (*num_cont * block_size);

This can't be right if it's not also accounting for the relative alignment.

> +}
> +
>   static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>   			  phys_addr_t paddr, size_t size, size_t pgcount,
>   			  arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
> @@ -463,6 +584,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>   	size_t tblsz = ARM_LPAE_GRANULE(data);
>   	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>   	int ret = 0, num_entries, max_entries, map_idx_start;
> +	u32 num_cont = 1;
>   
>   	/* Find our entry at the current level */
>   	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> @@ -479,6 +601,22 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>   		return ret;
>   	}
>   
> +	if (arm_lpae_pte_is_contiguous_range(data, size, lvl, &num_cont)) {
> +		size_t ct_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +
> +		max_entries = arm_lpae_max_entries(map_idx_start, data);
> +		num_entries = min_t(int, num_cont * pgcount, max_entries);
> +
> +		/* Set cont bit */
> +		prot |= ARM_LPAE_PTE_CONT;
> +
> +		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl,
> +					num_entries, ptep);

This definitely looks wrong - the io-pgtable design already deals with 
arbitrary ranges of contiguous PTEs (modulo table boundaries); the only 
change I'd expect to see at this level is a) something like this:

@@ -462,13 +462,18 @@ static int __arm_lpae_map(struct 
arm_lpae_io_pgtable *data, unsigned long iova,
  	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
  	size_t tblsz = ARM_LPAE_GRANULE(data);
  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	int ret = 0, num_entries, max_entries, map_idx_start;
+	int ret = 0, num_entries, max_entries, map_idx_start, num_cont;

  	/* Find our entry at the current level */
  	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
  	ptep += map_idx_start;

  	/* If we can install a leaf entry at this level, then do so */
+	num_cont == arm_lpae_num_cont(block_size);
+	if (size == block_size * num_cont) {
+		pgcount *= num_cont;
+		size /= num_cont; //so maybe it wants to be cont_shift?
+	}
  	if (size == block_size) {
  		max_entries = arm_lpae_max_entries(map_idx_start, data);
  		num_entries = min_t(int, pgcount, max_entries);

(similarly in the unmap path), and b) a bit of extra logic somewhere 
between __arm_lpae_map() and arm_lpae_init_pte() to add the explicit 
CONT bit to prot where PTEs within the given range do cover an aligned 
multiple of the appropriate number (which may not be the full input 
range). Duplicating the PTE-setting itself is a big red flag.

> +		if (!ret)
> +			*mapped += num_entries * ct_size;
> +		return ret;
> +	}
> +
>   	/* We can't allocate tables at the final level */
>   	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
>   		return -EINVAL;
> @@ -660,7 +798,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   {
>   	arm_lpae_iopte pte;
>   	struct io_pgtable *iop = &data->iop;
> -	int i = 0, num_entries, max_entries, unmap_idx_start;
> +	int i = 0, num_cont = 1, num_entries, max_entries, unmap_idx_start;
>   
>   	/* Something went horribly wrong and we ran out of page table */
>   	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
> @@ -675,9 +813,19 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   	}
>   
>   	/* If the size matches this level, we're in the right place */
> -	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> +	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data) ||
> +	    (size == arm_lpae_find_num_cont(data, lvl) *
> +		     ARM_LPAE_BLOCK_SIZE(lvl, data))) {
> +		size_t pte_size;
> +
>   		max_entries = arm_lpae_max_entries(unmap_idx_start, data);
> -		num_entries = min_t(int, pgcount, max_entries);
> +		num_cont = arm_lpae_check_num_cont(data, size, lvl);
> +		num_entries = min_t(int, num_cont * pgcount, max_entries);
> +		pte_size = size / num_cont;
> +
> +		if (num_cont > 1 &&
> +		    WARN_ON_ONCE(!IS_ALIGNED(iova, size)))
> +			return 0;

So if someone does iommu_map(iova=0x1000,size=0x10000), then 
legitimately tries to unmap it again, they get yelled at? That's rather 
unfair...

Since iommu_unmap() also permits unmapping a range formed by multiple 
adjacent iommu_map() calls, we can't infer much from the given page size 
either - the only thing we could reasonably try to warn about here is 
when we look at the PTEs we're clearing, if we see CONT set at the start 
(or end) of a range when that is not at a suitably-aligned offset.
     >   		/* Find and handle non-leaf entries */
>   		for (i = 0; i < num_entries; i++) {
> @@ -691,7 +839,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
>   
>   				/* Also flush any partial walks */
> -				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
> +				io_pgtable_tlb_flush_walk(iop, iova + i * pte_size, pte_size,
>   							  ARM_LPAE_GRANULE(data));
>   				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
>   			}
> @@ -702,9 +850,9 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   
>   		if (gather && !iommu_iotlb_gather_queued(gather))
>   			for (int j = 0; j < i; j++)
> -				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
> +				io_pgtable_tlb_add_page(iop, gather, iova + j * pte_size, pte_size);
>   
> -		return i * size;
> +		return i * pte_size;
>   	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
>   		WARN_ONCE(true, "Unmap of a partial large IOPTE is not allowed");
>   		return 0;
> @@ -943,6 +1091,7 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>   	}
>   
>   	cfg->pgsize_bitmap &= page_sizes;
> +	cfg->pgsize_bitmap |= arm_lpae_get_cont_sizes(cfg);
>   	cfg->ias = min(cfg->ias, max_addr_bits);
>   	cfg->oas = min(cfg->oas, max_addr_bits);
>   }
> @@ -1001,7 +1150,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
>   			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
>   			    IO_PGTABLE_QUIRK_ARM_HD |
> -			    IO_PGTABLE_QUIRK_NO_WARN))
> +			    IO_PGTABLE_QUIRK_NO_WARN |
> +			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> @@ -1103,7 +1253,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>   	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
>   
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB |
> -			    IO_PGTABLE_QUIRK_NO_WARN))
> +			    IO_PGTABLE_QUIRK_NO_WARN |
> +			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index e19872e37e067..7b2097aaffb09 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -86,6 +86,8 @@ struct io_pgtable_cfg {
>   	 *
>   	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
>   	 * IO_PGTABLE_QUIRK_ARM_S2FWB: Use the FWB format for the MemAttrs bits
> +	 * IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT: Disable use of the contiguous
> +	 *	hint for hardware affected by implementation-specific errata.
>   	 *
>   	 * IO_PGTABLE_QUIRK_NO_WARN: Do not WARN_ON() on conflicting
>   	 *	mappings, but silently return -EEXISTS.  Normally an attempt
> @@ -103,6 +105,7 @@ struct io_pgtable_cfg {
>   	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
>   	#define IO_PGTABLE_QUIRK_ARM_S2FWB		BIT(8)
>   	#define IO_PGTABLE_QUIRK_NO_WARN		BIT(9)
> +	#define IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT	BIT(10)

This should perhaps be an opt-in rather than an opt-out, but either way 
it should not result in ARM_MALI_LPAE being given extra page sizes that 
that format does not have.

Thanks,
Robin.

>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
> 
> ---
> base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
> change-id: 20260618-iommu_contig_hint-71ae491fbb52
> 
> Best regards,
> --
> Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> 

