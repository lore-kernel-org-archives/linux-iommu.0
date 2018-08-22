From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 3/5] iommu/io-pgtable-arm: add support for non-strict
 mode
Date: Wed, 22 Aug 2018 18:52:40 +0100
Message-ID: <88575452-d370-2488-dd3f-6c3d3ebe150d@arm.com>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
 <1534296510-12888-4-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534296510-12888-4-git-send-email-thunder.leizhen@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 15/08/18 02:28, Zhen Lei wrote:
> To support the non-strict mode, now we only tlbi and sync for the strict
> mode. But for the non-leaf case, always follow strict mode.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 20 ++++++++++++++------
>   drivers/iommu/io-pgtable.h     |  3 +++
>   2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 010a254..20d3e98 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -538,6 +538,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   	phys_addr_t blk_paddr;
>   	size_t tablesz = ARM_LPAE_GRANULE(data);
>   	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +	size_t unmapped = size;
>   	int i, unmap_idx = -1;
> 
>   	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
> @@ -575,11 +576,16 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   		tablep = iopte_deref(pte, data);
>   	}
> 
> -	if (unmap_idx < 0)

[ side note: the more I see this test the more it looks slightly wrong, 
but that's a separate issue. I'll have to sit down and really remember 
what's going on here... ]

> -		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
> +	if (unmap_idx < 0) {
> +		unmapped = __arm_lpae_unmap(data, iova, size, lvl, tablep);
> +		if (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT))
> +			return unmapped;
> +	}

I don't quite get this change - we should only be recursing back into 
__arm_lpae_unmap() here if nothing's actually been unmapped at this 
point - the block entry is simply replaced by a full next-level table 
and we're going to come back and split another block at that next level, 
or we raced against someone else splitting the same block and that's 
their table instead. Since that's reverting back to a "regular" unmap, I 
don't see where the need to introduce an additional flush to that path 
comes from (relative to the existing behaviour, at least).

>   	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);

This is the flush which corresponds to whatever page split_blk_unmap() 
actually unmapped itself (and also covers any recursively-split 
intermediate-level entries)...

> -	return size;
> +	io_pgtable_tlb_sync(&data->iop);

...which does want this sync, but only technically for non-strict mode, 
since it's otherwise covered by the sync in iommu_unmap().

I'm not *against* tightening up the TLB maintenance here in general, but 
if so that should be a separately-reasoned patch, not snuck in with 
other changes.

Robin.

> +
> +	return unmapped;
>   }
> 
>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> @@ -609,7 +615,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   			io_pgtable_tlb_sync(iop);
>   			ptep = iopte_deref(pte, data);
>   			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
> -		} else {
> +		} else if (!(iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT)) {
>   			io_pgtable_tlb_add_flush(iop, iova, size, size, true);
>   		}
> 
> @@ -771,7 +777,8 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>   	u64 reg;
>   	struct arm_lpae_io_pgtable *data;
> 
> -	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
> +	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
> +			IO_PGTABLE_QUIRK_NON_STRICT))
>   		return NULL;
> 
>   	data = arm_lpae_alloc_pgtable(cfg);
> @@ -863,7 +870,8 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>   	struct arm_lpae_io_pgtable *data;
> 
>   	/* The NS quirk doesn't apply at stage 2 */
> -	if (cfg->quirks & ~IO_PGTABLE_QUIRK_NO_DMA)
> +	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NO_DMA |
> +		IO_PGTABLE_QUIRK_NON_STRICT))
>   		return NULL;
> 
>   	data = arm_lpae_alloc_pgtable(cfg);
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 2df7909..beb14a3 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -71,12 +71,15 @@ struct io_pgtable_cfg {
>   	 *	be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
>   	 *	software-emulated IOMMU), such that pagetable updates need not
>   	 *	be treated as explicit DMA data.
> +	 * IO_PGTABLE_QUIRK_NON_STRICT: Put off TLBs invalidation and release
> +	 *	memory first.
>   	 */
>   	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
>   	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
>   	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
>   	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
>   	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
> +	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
> --
> 1.8.3
> 
> 
