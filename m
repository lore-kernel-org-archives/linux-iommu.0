From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: Invalidate TLBs properly
Date: Mon, 7 Dec 2015 18:28:21 +0000
Message-ID: <20151207182821.GH26191@arm.com>
References: <2acaea8656f14a4421d7d466dd242fe5a3d0f6f6.1449246988.git.robin.murphy@arm.com>
	<ac2d6aedf473cf01eb1df48a1f81614f0f74b0b1.1449501523.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ac2d6aedf473cf01eb1df48a1f81614f0f74b0b1.1449501523.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 07, 2015 at 06:18:52PM +0000, Robin Murphy wrote:
> When invalidating an IOVA range potentially spanning multiple pages,
> such as when removing an entire intermediate-level table, we currently
> only issue an invalidation for the first IOVA of that range. Since the
> architecture specifies that address-based TLB maintenance operations
> target a single entry, an SMMU could feasibly retain live entries for
> subsequent pages within that unmapped range, which is not good.
> 
> Make sure we hit every possible entry by iterating over the whole range
> at the granularity provided by the pagetable implementation.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: include SMMUv3 fix, use the same shorter loop construct everywhere.
> 
>  drivers/iommu/arm-smmu-v3.c |  5 ++++-
>  drivers/iommu/arm-smmu.c    | 16 +++++++++++++---
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index c302b65..8bb5abf 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1354,7 +1354,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>  	}
>  
> -	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> +	do {
> +		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> +		cmd.tlbi.addr += granule;
> +	} while (size -= granule);
>  }
>  
>  static struct iommu_gather_ops arm_smmu_gather_ops = {
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 601e3dd..eb28c3e 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -597,12 +597,18 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>  		if (!IS_ENABLED(CONFIG_64BIT) || smmu->version == ARM_SMMU_V1) {
>  			iova &= ~12UL;
>  			iova |= ARM_SMMU_CB_ASID(cfg);
> -			writel_relaxed(iova, reg);
> +			do {
> +				writel_relaxed(iova, reg);
> +				iova += granule;
> +			} while (size -= granule);
>  #ifdef CONFIG_64BIT
>  		} else {
>  			iova >>= 12;
>  			iova |= (u64)ARM_SMMU_CB_ASID(cfg) << 48;
> -			writeq_relaxed(iova, reg);
> +			do {
> +				writeq_relaxed(iova, reg);
> +				iova += granule >> 12;
> +			} while (size -= granule)

This doesn't compile.

>  #endif
>  		}
>  #ifdef CONFIG_64BIT
> @@ -610,7 +616,11 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>  		reg = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
>  		reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L :
>  			      ARM_SMMU_CB_S2_TLBIIPAS2;
> -		writeq_relaxed(iova >> 12, reg);
> +		iova >>= 12;
> +		do {
> +			writeq_relaxed(iova, reg);
> +			iova += granule >> 12;
> +		} while (size -= granule)

Same here.

Please at least build your patches, and preferably test them too.

Will
