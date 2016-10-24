From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu: arm-smmu-v2: Enable 16 bit ASID
Date: Mon, 24 Oct 2016 12:01:50 +0100
Message-ID: <565784ce-a740-315d-e4db-5fdbb5a0316e@arm.com>
References: <1477112524-13023-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1477112524-13023-1-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geetha sowjanya <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geetha,

On 22/10/16 06:02, Geetha sowjanya wrote:
>  Support up to 16 bit ASID. This patch enables
>  16 bit ASID when supported.

Why? "Because we can" is not a compelling rationale. I assume this is
actually related to the globally-unique ASID workaround for the TLB
sharing erratum, but if so that should be called out explicitly -
describe the problem being fixed.

> Signed-off-by: Geetha sowjanya <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Acked-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c841eb7..9740846 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -258,6 +258,9 @@ enum arm_smmu_s2cr_privcfg {
>  #define TTBCR2_SEP_SHIFT		15
>  #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
>  
> +#define TTBCR2_AS_SHIFT			4
> +#define TTBCR2_AS_ENABLE		(1 << TTBCR2_AS_SHIFT)
> +

The style here for single-bit fields is simply:

#define TTBCR2_AS			(1 << 4)

>  #define TTBRn_ASID_SHIFT		48
>  
>  #define FSR_MULTI			(1 << 31)
> @@ -773,6 +776,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>  			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
>  			reg2 |= TTBCR2_SEP_UPSTREAM;
> +		/* Enable 16 bit ASID if 16 bit VMID is supported */
> +			if (smmu->features & ARM_SMMU_FEAT_VMID16)

This should be a check for AArch64 context format - VMID16 has nothing
to do with it. 16-bit ASID support for stage 1 AArch64 contexts is
already implied by SMMUv2 (TCR2.AS is not optional).

Robin.

> +				reg |= TTBCR2_AS_ENABLE;
>  		}
>  		if (smmu->version > ARM_SMMU_V1)
>  			writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);
> 
