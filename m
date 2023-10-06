Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D94414
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABCD1C15;
	Fri,  6 Oct 2023 06:44:34 -0700 (PDT)
Received: from [10.57.66.230] (unknown [10.57.66.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C33D3F641;
	Fri,  6 Oct 2023 06:43:53 -0700 (PDT)
Message-ID: <db259336-1203-4d12-ac80-3108aaf5ec82@arm.com>
Date: Fri, 6 Oct 2023 14:43:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] iommu/arm-smmu: Pass arm_smmu_domain to
 arm_smmu_init_domain_context()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <jroedel@suse.de>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>
References: <4-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-05 19:28, Jason Gunthorpe wrote:
> Instead of putting container_of() casts in the internals, use the proper
> type in this call chain. This makes it easier to check that the two global
> static domains are not leaking into call chains they should not.

Is there something inherently difficult about to_smmu_domain()? It's 
hard to tell how the aforementioned checks might expect to work since 
they don't appear to be added anywhere :/

That's not to say that there's anything necessarily wrong with the logic 
of "use the internal type internally" if it doesn't hurt the code 
structure or readability, but this isn't justifying that for its own sake...

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 28 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 0fc4f2e8bf3ed5..bf5f541be2399f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -393,7 +393,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   	u32 fsr, fsynr, cbfrsynra;
>   	unsigned long iova;
>   	struct iommu_domain *domain = dev;
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_domain *smmu_domain = dev;
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   	int idx = smmu_domain->cfg.cbndx;
>   	int ret;
> @@ -607,7 +607,7 @@ static int arm_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
>   	return __arm_smmu_alloc_bitmap(smmu->context_map, start, smmu->num_context_banks);
>   }
>   
> -static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> +static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
>   					struct arm_smmu_device *smmu,
>   					struct device *dev)
>   {
> @@ -616,7 +616,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	struct io_pgtable_ops *pgtbl_ops;
>   	struct io_pgtable_cfg pgtbl_cfg;
>   	enum io_pgtable_fmt fmt;
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);

If at all, I think I'd rather just flip this to a local "struct 
iommu_domain *domain = &smmu_domain->domain;" and avoid the hunk of 
churn below. For a non-functional change with only a readability and 
maintenance angle (the compiler generally won't mind whether load/store 
offsets are positive or negative within the size of the overall 
structure), making those geometry assignments even denser isn't really 
helping.

Thanks,
Robin.

>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	irqreturn_t (*context_fault)(int irq, void *dev);
>   
> @@ -764,16 +763,16 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	}
>   
>   	/* Update the domain's page sizes to reflect the page table format */
> -	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> +	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>   
>   	if (pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> -		domain->geometry.aperture_start = ~0UL << ias;
> -		domain->geometry.aperture_end = ~0UL;
> +		smmu_domain->domain.geometry.aperture_start = ~0UL << ias;
> +		smmu_domain->domain.geometry.aperture_end = ~0UL;
>   	} else {
> -		domain->geometry.aperture_end = (1UL << ias) - 1;
> +		smmu_domain->domain.geometry.aperture_end = (1UL << ias) - 1;
>   	}
>   
> -	domain->geometry.force_aperture = true;
> +	smmu_domain->domain.geometry.force_aperture = true;
>   
>   	/* Initialise the context bank with our page table cfg */
>   	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> @@ -790,8 +789,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	else
>   		context_fault = arm_smmu_context_fault;
>   
> -	ret = devm_request_irq(smmu->dev, irq, context_fault,
> -			       IRQF_SHARED, "arm-smmu-context-fault", domain);
> +	ret = devm_request_irq(smmu->dev, irq, context_fault, IRQF_SHARED,
> +			       "arm-smmu-context-fault", smmu_domain);
>   	if (ret < 0) {
>   		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
>   			cfg->irptndx, irq);
> @@ -812,9 +811,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> -static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
> +static void arm_smmu_destroy_domain_context(struct arm_smmu_domain *smmu_domain)
>   {
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	int ret, irq;
> @@ -835,7 +833,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>   
>   	if (cfg->irptndx != ARM_SMMU_INVALID_IRPTNDX) {
>   		irq = smmu->irqs[cfg->irptndx];
> -		devm_free_irq(smmu->dev, irq, domain);
> +		devm_free_irq(smmu->dev, irq, smmu_domain);
>   	}
>   
>   	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
> @@ -875,7 +873,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>   	 * Free the domain resources. We assume that all devices have
>   	 * already been detached.
>   	 */
> -	arm_smmu_destroy_domain_context(domain);
> +	arm_smmu_destroy_domain_context(smmu_domain);
>   	kfree(smmu_domain);
>   }
>   
> @@ -1125,7 +1123,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   		return ret;
>   
>   	/* Ensure that the domain is finalised */
> -	ret = arm_smmu_init_domain_context(domain, smmu, dev);
> +	ret = arm_smmu_init_domain_context(smmu_domain, smmu, dev);
>   	if (ret < 0)
>   		goto rpm_put;
>   
