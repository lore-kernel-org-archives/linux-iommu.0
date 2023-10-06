Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61912F58
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D81C8C15;
	Fri,  6 Oct 2023 05:05:46 -0700 (PDT)
Received: from [10.57.66.230] (unknown [10.57.66.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 919003F762;
	Fri,  6 Oct 2023 05:05:05 -0700 (PDT)
Message-ID: <a75f54d3-cd16-499d-b6d2-eed38153b0e2@arm.com>
Date: Fri, 6 Oct 2023 13:05:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] iommu/arm-smmu: Reorganize
 arm_smmu_domain_add_master()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <jroedel@suse.de>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>
References: <1-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-05 19:28, Jason Gunthorpe wrote:
> Make arm_smmu_domain_add_master() not use the smmu_domain to detect the
> s2cr configuration, instead pass it in as a parameter. It always returns
> zero so make it return void.

It doesn't follow that a function named arm_smmu_domain_<operation>() 
should not operate on an arm_smmu_domain... I think this is the point to 
rename it to something like arm_smmu_master_install_s2crs() to reflect 
that what it's actually doing by now is a lot less than it did 10 years ago.

> This is done to make the next two patches able to re-use this code without
> forcing the creation of a struct arm_smmu_domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc069..7f33363719f4ac 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1081,21 +1081,14 @@ static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg,
>   	mutex_unlock(&smmu->stream_map_mutex);
>   }
>   
> -static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
> -				      struct arm_smmu_master_cfg *cfg,
> -				      struct iommu_fwspec *fwspec)
> +static void arm_smmu_domain_add_master(struct arm_smmu_device *smmu,

We already have the SMMU device in cfg->smmu, no need to pass it twice.

Thanks,
Robin.

> +				       struct arm_smmu_master_cfg *cfg,
> +				       enum arm_smmu_s2cr_type type, u8 cbndx,
> +				       struct iommu_fwspec *fwspec)
>   {
> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   	struct arm_smmu_s2cr *s2cr = smmu->s2crs;
> -	u8 cbndx = smmu_domain->cfg.cbndx;
> -	enum arm_smmu_s2cr_type type;
>   	int i, idx;
>   
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS)
> -		type = S2CR_TYPE_BYPASS;
> -	else
> -		type = S2CR_TYPE_TRANS;
> -
>   	for_each_cfg_sme(cfg, fwspec, i, idx) {
>   		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
>   			continue;
> @@ -1105,7 +1098,6 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>   		s2cr[idx].cbndx = cbndx;
>   		arm_smmu_write_s2cr(smmu, idx);
>   	}
> -	return 0;
>   }
>   
>   static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> @@ -1153,7 +1145,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	}
>   
>   	/* Looks ok, so add the device to the domain */
> -	ret = arm_smmu_domain_add_master(smmu_domain, cfg, fwspec);
> +	arm_smmu_domain_add_master(smmu, cfg,
> +				   smmu_domain->stage ==
> +						   ARM_SMMU_DOMAIN_BYPASS ?
> +					   S2CR_TYPE_BYPASS :
> +					   S2CR_TYPE_TRANS,
> +				   smmu_domain->cfg.cbndx, fwspec);
>   
>   	/*
>   	 * Setup an autosuspend delay to avoid bouncing runpm state.
