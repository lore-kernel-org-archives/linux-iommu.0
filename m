From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 4/7] iommu/io-pgtable-arm: Add support for non-strict
 mode
Date: Fri, 28 Sep 2018 13:17:38 +0100
Message-ID: <20180928121738.GA1577@brain-police>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <9a666d63a96ab97dc53df2a64b3a8d22a0986423.1537458163.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9a666d63a96ab97dc53df2a64b3a8d22a0986423.1537458163.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 20, 2018 at 05:10:24PM +0100, Robin Murphy wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Non-strict mode is simply a case of skipping 'regular' leaf TLBIs, since
> the sync is already factored out into ops->iotlb_sync at the core API
> level. Non-leaf invalidations where we change the page table structure
> itself still have to be issued synchronously in order to maintain walk
> caches correctly.
> 
> To save having to reason about it too much, make sure the invalidation
> in arm_lpae_split_blk_unmap() just performs its own unconditional sync
> to minimise the window in which we're technically violating the break-
> before-make requirement on a live mapping. This might work out redundant
> with an outer-level sync for strict unmaps, but we'll never be splitting
> blocks on a DMA fastpath anyway.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> [rm: tweak comment, commit message, split_blk_unmap logic and barriers]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v8: Add barrier for the fiddly cross-cpu flush case
> 
>  drivers/iommu/io-pgtable-arm.c | 14 ++++++++++++--
>  drivers/iommu/io-pgtable.h     |  5 +++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 2f79efd16a05..237cacd4a62b 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -576,6 +576,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>  		tablep = iopte_deref(pte, data);
>  	} else if (unmap_idx >= 0) {
>  		io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
> +		io_pgtable_tlb_sync(&data->iop);
>  		return size;
>  	}
>  
> @@ -609,6 +610,13 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>  			io_pgtable_tlb_sync(iop);
>  			ptep = iopte_deref(pte, data);
>  			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
> +		} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
> +			/*
> +			 * Order the PTE update against queueing the IOVA, to
> +			 * guarantee that a flush callback from a different CPU
> +			 * has observed it before the TLBIALL can be issued.
> +			 */
> +			smp_wmb();

Looks good to me. In the case that everything happens on the same CPU, are
we relying on the TLB invalidation code in the SMMU driver(s) to provide the
DSB for pushing the new entry out to the walker?

Will
