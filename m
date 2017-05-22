From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Use context bank TLBSTATUS registers
Date: Mon, 22 May 2017 10:50:19 +0100
Message-ID: <47a51b35-5a0a-0034-cf7c-8428d63f60b3@arm.com>
References: <1495443328-19646-1-git-send-email-vjitta@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1495443328-19646-1-git-send-email-vjitta-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: vjitta-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: shashim-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, guptap-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 22/05/17 09:55, vjitta-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org wrote:
> From: Vijayanand Jitta <vjitta-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> There are TLBSTATUS registers in SMMU global register space as well as
> context bank register space.  Currently we're polling the global
> TLBSTATUS registers after TLB invalidation, even when using the TLB
> invalidation registers from context bank address space.  This violates
> the usage model described in the ARM SMMU spec.  Fix this by polling
> context bank TLBSTATUS registers for context bank TLB operations, and
> global TLBSTATUS registers for global TLB operations.

Note that these registers don't exist for SMMUv1 stage 2 contexts...

> Signed-off-by: Vijayanand Jitta <vjitta-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7cecc37..8dc6da9 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -233,6 +233,9 @@ enum arm_smmu_s2cr_privcfg {
>  #define ARM_SMMU_CB_S1_TLBIVAL		0x620
>  #define ARM_SMMU_CB_S2_TLBIIPAS2	0x630
>  #define ARM_SMMU_CB_S2_TLBIIPAS2L	0x638
> +#define ARM_SMMU_CB_TLBSYNC		0x7f0
> +#define ARM_SMMU_CB_TLBSTATUS		0x7f4
> +#define TLBSTATUS_SACTIVE		(1 << 0)
>  #define ARM_SMMU_CB_ATS1PR		0x800
>  #define ARM_SMMU_CB_ATSR		0x8f0
>  
> @@ -580,6 +583,19 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
>  }
>  
>  /* Wait for any pending TLB invalidations to complete */
> +static void arm_smmu_tlb_sync_cb(struct arm_smmu_device *smmu,
> +				int cbndx)
> +{
> +	void __iomem *base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cbndx);
> +	u32 val;
> +
> +	writel_relaxed(0, base + ARM_SMMU_CB_TLBSYNC);
> +	if (readl_poll_timeout_atomic(base + ARM_SMMU_CB_TLBSTATUS, val,
> +				      !(val & TLBSTATUS_SACTIVE),
> +				      0, TLB_LOOP_TIMEOUT))
> +		dev_err(smmu->dev, "TLBSYNC timeout!\n");
> +}
> +
>  static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>  {
>  	int count = 0;
> @@ -601,7 +617,7 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>  static void arm_smmu_tlb_sync(void *cookie)
>  {
>  	struct arm_smmu_domain *smmu_domain = cookie;
> -	__arm_smmu_tlb_sync(smmu_domain->smmu);
> +	arm_smmu_tlb_sync_cb(smmu_domain->smmu, smmu_domain->cfg.cbndx);

...which makes this goes wrong for sync-on-unmap with MMU-400/401 (and
any other implementations which may exist) - in practice they will
probably RAZ, leading us to believe it's always inactive.

Anyway, this patch isn't going to apply against 4.12-rc - guess how I
know ;)

Robin.

>  }
>  
>  static void arm_smmu_tlb_inv_context(void *cookie)
> @@ -616,13 +632,13 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
>  		writel_relaxed(ARM_SMMU_CB_ASID(smmu, cfg),
>  			       base + ARM_SMMU_CB_S1_TLBIASID);
> +		arm_smmu_tlb_sync_cb(smmu, cfg->cbndx);
>  	} else {
>  		base = ARM_SMMU_GR0(smmu);
>  		writel_relaxed(ARM_SMMU_CB_VMID(smmu, cfg),
>  			       base + ARM_SMMU_GR0_TLBIVMID);
> +		__arm_smmu_tlb_sync(smmu);
>  	}
> -
> -	__arm_smmu_tlb_sync(smmu);
>  }
>  
>  static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> 
