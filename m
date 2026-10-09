Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3163366806
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572279; cv=none; b=GfzA+XRtV94uTxQ1DDIlB0/qtfr+cr0xIgbcwSKUpwzqCHSXlcA87CL+8mX6j5n5EIvaVmtFX4GpxVsOIffsob7cL+EF/5mJrIpC9Cn50k2gk33o9oSDaeO3gzsZcY5F0sCOjkk6GV3wJxgMDY2WW1rzEV+syQ1vyc0LbYckESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572279; c=relaxed/simple;
	bh=Ua5EHL6b+gTOqBRYadB8BrVHkYJG9ZhK4okG7rSjkHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgFuljk6GPKWaZqFKbjE/ZjXVAXlNDiWapTztwdVBzMACrzgRFqPbLLa2CZ+yxIO/+Ooq6uYM+NAQN8UOL8/OTNYqdEl/IrlJhSmOxrR3GnL6HsNEUEnYmnkt51I5K23PKVXf2iSoIEyhTGcq/mIbiYBtjdhFtDEqKdSQOTgxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gbLbLZjp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gbLbLZjp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FB1C1D14;
	Fri,  9 Oct 2026 11:57:51 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D65403F66F;
	Fri,  9 Oct 2026 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791572275; bh=Ua5EHL6b+gTOqBRYadB8BrVHkYJG9ZhK4okG7rSjkHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gbLbLZjpRFqwozxVNXaVrq3ItXD4LZnc/Fi5Wnx/aryvye/DtUXnbwPiLb/OHO8OZ
	 yO+BnXbu/fXJWeWysUmHDMkcGbNb9Akl/Z+bBJEGEPfl5FXLzw1NVcYMZZbKzt8TUo
	 GXmSxtU1b1v9uPrBBEsscz2h6nzKw3pKUmgVjJ4M=
Message-ID: <2a2a81fc-5402-4f07-aaf2-a0dc853f1bad@arm.com>
Date: Fri, 9 Oct 2026 19:57:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 12:14 pm, Vijayanand Jitta wrote:
> From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> 
> Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
> When a set of consecutive PTEs map a naturally aligned contiguous block of
> memory, set CONT on every descriptor in that group so the hardware can
> combine translations and improve TLB reach.
> 
> Advertise the supported CONT group sizes in pgsize_bitmap. Callers select
> those sizes through the normal page-size selection path; io-pgtable-arm
> then installs the corresponding tagged descriptors directly. A partial
> unmap of a tagged CONT group is rejected before modifying any descriptor,
> so a rejected request cannot leave the group partly unmapped.
> 
> The IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disable
> CONT support for hardware with implementation-specific errata.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> ---
> Changes in v5:
> - Keep CONT sizes that exactly span the configured IAS or OAS, allowing a
>    valid mapping at address zero.
> - Derive CONT sizes from the architecture-valid base page-size bitmap and
>    constrain the final result by IAS and OAS, replacing the bespoke
>    arm_lpae_get_cont_sizes() helpers.
> - Guard CONT-size expansion against 32-bit overflow.
> - Let callers select exact CONT sizes through pgsize_bitmap, and remove the
>    internal prefix/group/suffix promotion path.
> - Reject a partial CONT-group unmap before any PTE is cleared, making the
>    rejection a complete no-op.
> - Link to v4: https://lore.kernel.org/all/20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com/
> 
> Changes in v4:
> - Merge each run of consecutive aligned (or consecutive non-aligned)
>    num_cont windows within arm_lpae_install_leaf() into a single
>    arm_lpae_init_pte() call instead of one call per window. idx and
>    paddr both advance by block_size per entry, so once a window
>    qualifies (or fails to qualify) for the CONT hint, every later whole
>    window in the same call does too - collapsing the common fully-
>    aligned or fully-unaligned case back down to one call, matching v2's
>    call count without reintroducing v2's alignment gaps.
> - Fix min_t(int, pgcount, max_entries) truncating pgcount (size_t) to a
>    signed int in both __arm_lpae_map() and __arm_lpae_unmap(), which
>    could go negative and spin the caller's while (pgcount) loop forever
>    for a large enough single request - especially reachable now that
>    pgcount is scaled by num_cont (up to 128) for whole-CONT-group
>    requests. Compare in size_t via min_t(size_t, ...) instead; the
>    result remains bounded by max_entries before being stored back into
>    the int num_entries. Reported by the Sashiko AI review bot on v3.
> - Stop short of the offending entry instead of returning 0 outright
>    when __arm_lpae_unmap() detects a misaligned CONT group mid-loop.
>    Earlier entries in the same call may already have had non-leaf
>    sub-tables torn down and freed, so returning 0 both under-reports
>    the actual unmap progress to the caller and skips the bulk
>    clear/gather for those already-freed entries. Breaking out of the
>    loop at the current index lets the existing post-loop clear/gather
>    path handle entries [0, i) correctly and report i * size unmapped.
>    Reported by the Sashiko AI review bot on v3.
> - Link to v3: https://lore.kernel.org/all/20260722-iommu_contig_hint-v3-1-10923a683441@oss.qualcomm.com/
> 
> Changes in v3:
> - Collapse arm_lpae_cont_ptes()/arm_lpae_cont_blks()/
>    arm_lpae_cont_pte_size()/arm_lpae_cont_blk_size()/
>    arm_lpae_find_num_cont() into a single arm_lpae_num_cont(size_t size)
>    helper, since leaf/block/L1-block sizes never overlap across granules.
> - Fix arm_lpae_pte_is_contiguous_range() never checking that iova/paddr
>    are aligned to the contiguous group size, by removing it entirely -
>    __arm_lpae_map()'s new arm_lpae_install_leaf() helper scans for
>    aligned sub-chunks and independently verifies paddr alignment for
>    each one before applying the CONT hint.
> - Fold the CONT case into __arm_lpae_map()'s existing size == block_size
>    leaf path instead of duplicating arm_lpae_init_pte() in a separate
>    branch. A request whose size exactly matches a whole CONT group is
>    normalized down to block_size/scaled pgcount so it reaches that path;
>    arm_lpae_install_leaf() then walks the resulting range in chunks,
>    tagging only the sub-chunks that are both index-aligned and
>    paddr-aligned to the group size, since a single map_pages() call at
>    the plain block_size can still contain such an aligned group midway
>    through a larger, otherwise ungrouped range.
> - Replace the unmap-side WARN_ON_ONCE(!IS_ALIGNED(iova, size)) with a
>    check on the actual ARM_LPAE_PTE_CONT bit of the PTEs being cleared.
>    The previous check incorrectly warned on any unmap whose size
>    happened to numerically match a CONT group size, even when the
>    underlying PTEs were never CONT-tagged (e.g. because the original
>    iommu_map() wasn't group-aligned), and even though iommu_unmap() can
>    legitimately assemble such a size from multiple independent prior
>    iommu_map() calls.
> - Close a leak where ARM_MALI_LPAE would gain CONT-sized entries in its
>    pgsize_bitmap despite the format having no CONT bit, by having
>    arm_mali_lpae_alloc_pgtable() set IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT
>    internally rather than special-casing the format in the shared
>    arm_lpae_restrict_pgsizes()/arm_lpae_get_cont_sizes() path.
> - Gate each contiguous-hint size in arm_lpae_get_cont_sizes() on whether
>    a single group actually fits within the configured IAS/OAS, so e.g. a
>    16G level-1 CONT group is never advertised for an IAS too small to
>    address it.
> - Link to v2: https://patch.msgid.link/20260721-iommu_contig_hint-v2-1-90c731a41163@oss.qualcomm.com
> 
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
> Changes in v1:
> - Initial version.
> 
> To: Will Deacon <will@kernel.org>
> To: Robin Murphy <robin.murphy@arm.com>
> To: "Joerg Roedel (AMD)" <joro@8bytes.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/iommu/io-pgtable-arm.c | 125 ++++++++++++++++++++++++++++++++++++-----
>   include/linux/io-pgtable.h     |   3 +
>   2 files changed, 115 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 476c0e25631af..01d98959c514f 100644
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
> + * Contiguous hint group sizes per granule:
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
> @@ -453,6 +468,24 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
>   	return old;
>   }
>   
> +static int arm_lpae_num_cont(size_t size)
> +{
> +	switch (size) {
> +	case SZ_4K:
> +	case SZ_2M:
> +	case SZ_1G:
> +		return 16;
> +	case SZ_64K:
> +	case SZ_32M:
> +	case SZ_512M:
> +		return 32;
> +	case SZ_16K:
> +		return 128;
> +	default:
> +		return 1;
> +	}
> +}
> +
>   static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>   			  phys_addr_t paddr, size_t size, size_t pgcount,
>   			  arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
> @@ -462,20 +495,41 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>   	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
>   	size_t tblsz = ARM_LPAE_GRANULE(data);
>   	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> -	int ret = 0, num_entries, max_entries, map_idx_start;
> +	int num_cont = arm_lpae_num_cont(block_size);
> +	size_t cont_size = 0, entries_per_map;
> +	int num_entries, max_entries, map_idx_start;
> +	bool cont = false;
> +
> +	if (num_cont > 1 && block_size <= SIZE_MAX / num_cont)
> +		cont_size = num_cont * block_size;

Again, why can't this just be:

	if (num_cont > 1 && size / num_cont == block_size) {
		size = block_size;
		pgcount *= num_cont;
		prot |= ARM_LPAE_PTE_CONT;
	}

Although TBH even just one non-constant division is still more than 
necessary, as "block_size * num_cont == size" will actually work 
correctly for 32-bit anyway (since unsigned overflow in C is 
well-defined and "size" cannot be 0).

(I guess if you really really wanted to then you could put an "#ifdef 
CONFIG_64BIT" around the "case SZ_1G:" in arm_lpae_num_cont(), but I'd 
hope it's sufficiently obvious already why it could never realistically 
matter.)

>   	/* Find our entry at the current level */
>   	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
>   	ptep += map_idx_start;
>   
>   	/* If we can install a leaf entry at this level, then do so */
> -	if (size == block_size) {
> +	if (size == block_size ||
> +	    (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT) &&
> +	     size == cont_size)) {
> +		int ret;
> +
> +		cont = size == cont_size;
> +		if (cont && (!IS_ALIGNED(iova, size) || !IS_ALIGNED(paddr, size)))
> +			return -EINVAL;

We don't validate that the addresses are aligned to "size" in any other 
case, so why complicate this one? Either we trust callers to interpret 
pgsize_bitmap correctly, or we don't.

> +
> +		entries_per_map = size / block_size;

Why are we recalculating something we know already (cont ? num_cont : 
1), in about the most expensive way possible!?

>   		max_entries = arm_lpae_max_entries(map_idx_start, data);
> -		num_entries = min_t(int, pgcount, max_entries);
> -		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
> +		num_entries = min_t(size_t, pgcount,
> +				    max_entries / entries_per_map) * entries_per_map;

This is so confusing - what does "per_map" mean, and what does the whole 
thing even achieve? Is it once again just conditionally multiplying by 
num_cont in about the most expensive way possible?

> +		if (!num_entries)
> +			return -EINVAL;

How could that ever happen at all!?

> +		if (cont)
> +			prot |= ARM_LPAE_PTE_CONT;
> +
> +		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl,
> +					num_entries, ptep);
>   		if (!ret)
> -			*mapped += num_entries * size;
> -
> +			*mapped += num_entries * block_size;
>   		return ret;
>   	}
>   
> @@ -660,12 +714,18 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   {
>   	arm_lpae_iopte pte;
>   	struct io_pgtable *iop = &data->iop;
> +	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +	int num_cont = arm_lpae_num_cont(block_size);
> +	size_t cont_size = 0, entries_per_map;
>   	int i = 0, num_entries, max_entries, unmap_idx_start;
>   
>   	/* Something went horribly wrong and we ran out of page table */
>   	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>   		return 0;
>   
> +	if (num_cont > 1 && block_size <= SIZE_MAX / num_cont)
> +		cont_size = num_cont * block_size;
> +
>   	unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
>   	ptep += unmap_idx_start;
>   	pte = READ_ONCE(*ptep);
> @@ -675,9 +735,27 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   	}
>   
>   	/* If the size matches this level, we're in the right place */
> -	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> +	if (size == block_size ||
> +	    (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT) &&
> +	     size == cont_size)) {
> +		entries_per_map = size / block_size;
>   		max_entries = arm_lpae_max_entries(unmap_idx_start, data);
> -		num_entries = min_t(int, pgcount, max_entries);
> +		num_entries = min_t(size_t, pgcount,
> +				    max_entries / entries_per_map) * entries_per_map;
> +		if (!num_entries)
> +			return 0;

All the same comments as before for all this lot, although in this case 
we could actually do with the "bool cont" for the sake of the validation 
below.

> +
> +		/*
> +		 * A CONT group must be invalidated as a unit. Reject a request that
> +		 * starts or ends inside a tagged group before changing any PTEs.
> +		 */
> +		if ((READ_ONCE(*ptep) & ARM_LPAE_PTE_CONT &&

We already have the first entry read into "pte", we don't need to read 
it again.

> +		     !IS_ALIGNED(iova, cont_size)) ||
> +		    (READ_ONCE(ptep[num_entries - 1]) & ARM_LPAE_PTE_CONT &&
> +		     !IS_ALIGNED(iova + num_entries * block_size, cont_size))) {

How's that ever going to do anything if we've already rounded 
"num_entries" down to to a multiple of "num_cont" (i.e. the confusingly 
quasi-redundant "entries_per_map") above?

That said, I think this could be even simpler anyway - for any _valid_ 
unmap of a cont range the original "size" will be the cont size, so it 
should simply be the case that if we ever see PTE_CONT set when the 
original size was _not_ the cont size (i.e. just the base block_size) 
then it must be an erroneous partial unmap, so that can just be an extra 
condition in the loop below where we're checking every PTE already.

Again as for the IOVA alignment, we should either factor the cont size 
into the ARM_LPAE_LEVEL_IDX() calculations to be consistent with the 
existing behaviour (perhaps another argument for having it as a 
cont_shift rather than a num_cont), or if we did want to change and 
start checking for bogus usage which should never exist anyway then we 
should just test "iova & (pgsize - 1)" right after we validate "pgsize" 
itself at the very beginning. What we should not have is inconsistently 
different behaviour depending on the request size.

> +			WARN_ONCE(true, "Unmap of a partial CONT IOPTE group is not allowed");
> +			return 0;
> +		}
>   
>   		/* Find and handle non-leaf entries */
>   		for (i = 0; i < num_entries; i++) {
> @@ -691,7 +769,8 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
>   
>   				/* Also flush any partial walks */
> -				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
> +				io_pgtable_tlb_flush_walk(iop,
> +							  iova + i * block_size, block_size,
>   							  ARM_LPAE_GRANULE(data));
>   				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
>   			}
> @@ -702,9 +781,10 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   
>   		if (gather && !iommu_iotlb_gather_queued(gather))
>   			for (int j = 0; j < i; j++)
> -				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
> +				io_pgtable_tlb_add_page(iop, gather,
> +							iova + j * block_size, block_size);
>   
> -		return i * size;
> +		return i * block_size;
>   	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
>   		WARN_ONCE(true, "Unmap of a partial large IOPTE is not allowed");
>   		return 0;
> @@ -943,8 +1023,23 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>   	}
>   
>   	cfg->pgsize_bitmap &= page_sizes;
> +	if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT)) {
> +		unsigned long sizes = cfg->pgsize_bitmap;
> +
> +		while (sizes) {
> +			unsigned long size = BIT(__ffs(sizes));
> +			int num_cont = arm_lpae_num_cont(size);
> +
> +			if (size <= ULONG_MAX / num_cont)
> +				cfg->pgsize_bitmap |= num_cont * size;
> +			sizes &= ~size;
> +		}
> +	}

Open-coded for_each_set_bit()?

> +
>   	cfg->ias = min(cfg->ias, max_addr_bits);
>   	cfg->oas = min(cfg->oas, max_addr_bits);
> +	cfg->pgsize_bitmap &= GENMASK_ULL(cfg->ias, 0);
> +	cfg->pgsize_bitmap &= GENMASK_ULL(cfg->oas, 0);

This is new behaviour for all users irrespective of the new 
functionality - we never did it before, why start doing it now?

>   }
>   
>   static struct arm_lpae_io_pgtable *
> @@ -1001,7 +1096,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
>   			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
>   			    IO_PGTABLE_QUIRK_ARM_HD |
> -			    IO_PGTABLE_QUIRK_NO_WARN))
> +			    IO_PGTABLE_QUIRK_NO_WARN |
> +			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> @@ -1103,7 +1199,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>   	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
>   
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB |
> -			    IO_PGTABLE_QUIRK_NO_WARN))
> +			    IO_PGTABLE_QUIRK_NO_WARN |
> +			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> @@ -1224,6 +1321,8 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>   		return NULL;
>   
>   	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
> +	/* Mali LPAE has no CONT bit - never advertise CONT page sizes */
> +	cfg->quirks |= IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
>   	if (!data)
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

I'm not changing my mind that this chould be a positive opt-in - again, 
Panfrost and Panthor still don't want it, and while it is architectural 
for true VMSA users I'd still be a little wary of whether Adreno might 
get confused by suddenly getting extra sizes in its bitmap (in the case 
where it doesn't immediately remove them all anyway). Also it's perhaps 
notable that historically ipmmu-vmsa only supported cont at L3 (64KB), 
but I don't know if that was for a specific reason or just that it 
didn't expect to ever be mapping 32MB+ at once (it also didn't support 
1GB blocks either).

Thanks,
Robin.

>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
> 
> ---
> base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
> change-id: 20260618-iommu_contig_hint-71ae491fbb52
> 
> Best regards,
> --
> Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> 

