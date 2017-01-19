From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: Install bypass S2CRs for
 IOMMU_DOMAIN_IDENTITY domains
Date: Thu, 19 Jan 2017 18:50:48 +0000
Message-ID: <20946171-e832-0803-2450-c095e19b2f64@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <1484849955-1871-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484849955-1871-3-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

On 19/01/17 18:19, Will Deacon wrote:
> In preparation for allowing the default domain type to be overridden,
> this patch adds support for IOMMU_DOMAIN_IDENTITY domains to the
> ARM SMMU driver.
> 
> An identity domain is created by placing the corresponding S2CR
> registers into "bypass" mode, which allows transactions to flow through
> the SMMU without any translation.

The other subtle nicety this opens the door to is being able to disable
unmatched stream bypass without needing enough context banks for every
single known device, since S2CRs are generally more abundant.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a328ffb75509..0f5e42a719e5 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -404,6 +404,7 @@ enum arm_smmu_domain_stage {
>  	ARM_SMMU_DOMAIN_S1 = 0,
>  	ARM_SMMU_DOMAIN_S2,
>  	ARM_SMMU_DOMAIN_NESTED,
> +	ARM_SMMU_DOMAIN_BYPASS,
>  };
>  
>  struct arm_smmu_domain {
> @@ -824,6 +825,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	if (smmu_domain->smmu)
>  		goto out_unlock;
>  
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> +		smmu_domain->smmu = smmu;
> +		goto out_unlock;
> +	}
> +
>  	/*
>  	 * Mapping the requested stage onto what we support is surprisingly
>  	 * complicated, mainly because the spec allows S1+S2 SMMUs without
> @@ -984,7 +991,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>  	void __iomem *cb_base;
>  	int irq;
>  
> -	if (!smmu)
> +	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>  		return;
>  
>  	/*
> @@ -1007,7 +1014,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  {
>  	struct arm_smmu_domain *smmu_domain;
>  
> -	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_DMA &&
> +	    type != IOMMU_DOMAIN_IDENTITY)
>  		return NULL;
>  	/*
>  	 * Allocate the domain and initialise some of its data structures.
> @@ -1205,10 +1214,15 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>  {
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_s2cr *s2cr = smmu->s2crs;
> -	enum arm_smmu_s2cr_type type = S2CR_TYPE_TRANS;
>  	u8 cbndx = smmu_domain->cfg.cbndx;
> +	enum arm_smmu_s2cr_type type;
>  	int i, idx;
>  
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS)
> +		type = S2CR_TYPE_BYPASS;
> +	else
> +		type = S2CR_TYPE_TRANS;
> +
>  	for_each_cfg_sme(fwspec, i, idx) {
>  		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
>  			continue;
> 
