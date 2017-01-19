From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: Install bypass STEs for
	IOMMU_DOMAIN_IDENTITY domains
Date: Thu, 19 Jan 2017 18:56:40 +0000
Message-ID: <900d38e4-d847-9920-f74a-0c0ed77d8894@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
	<1484849955-1871-4-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484849955-1871-4-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 19/01/17 18:19, Will Deacon wrote:
> In preparation for allowing the default domain type to be overridden,
> this patch adds support for IOMMU_DOMAIN_IDENTITY domains to the
> ARM SMMUv3 driver.
> 
> An identity domain is created by placing the corresponding stream table
> entries into "bypass" mode, which allows transactions to flow through
> the SMMU without any translation.
> 
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index c254325b0c7a..d33291274455 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -629,6 +629,7 @@ enum arm_smmu_domain_stage {
>  	ARM_SMMU_DOMAIN_S1 = 0,
>  	ARM_SMMU_DOMAIN_S2,
>  	ARM_SMMU_DOMAIN_NESTED,
> +	ARM_SMMU_DOMAIN_BYPASS,
>  };
>  
>  struct arm_smmu_domain {
> @@ -1385,7 +1386,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  {
>  	struct arm_smmu_domain *smmu_domain;
>  
> -	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_DMA &&
> +	    type != IOMMU_DOMAIN_IDENTITY)
>  		return NULL;
>  
>  	/*
> @@ -1516,6 +1519,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> +		return 0;
> +	}
> +
>  	/* Restrict the stage to what we can actually support */
>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
>  		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> @@ -1651,7 +1659,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	ste->bypass = false;
>  	ste->valid = true;
>  
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS) {
> +		ste->bypass = true;

How is this intended to interact with the disable_bypass parameter? at
the moment, that will still end up transforming this into a faulting
STE, and I'm not sure that's right. I'd say we want to treat "bypass
because not attached to a domain" and "bypass because attached to a
passthrough domain" as distinct things, and it's only really the former
which makes sense to disable.

Robin.

> +	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		ste->s1_cfg = &smmu_domain->s1_cfg;
>  		ste->s2_cfg = NULL;
>  		arm_smmu_write_ctx_desc(smmu, ste->s1_cfg);
> 
