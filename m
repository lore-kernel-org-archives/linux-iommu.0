Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866642D59F7;
	Mon, 21 Jul 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104071; cv=none; b=a034YGiUaXHgw8gd64f+wjrxScja9Yn7YpWI6C5/wQZXmQF74BJsUBfGRS4v0caSqjtdlVRcJQ6gd5xJyOv/kNZwjv1DVKMjlDPW6Sk6WeYg8bY/68PkKzBam6FHtBG0nuzfNQqsA90QvoiMn/NoBgJcM4vM+BlncEucE8cDYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104071; c=relaxed/simple;
	bh=+Rs7u8kTc1dBhO1Z31VFKO/SHgaW/BFajAQvzqyjiYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPoAzA9xOL204OsvtSxUwwv6QhCrbsEneDoe03X896sRMLny4RQaB0hK4lFPbzdjC03uYewpydPmFjjhZgxP3uZNSZL0g+u11MyPP80cO3NhUFGgQnS9jdFABIEwAYUwrtjjuqDQt+EQsQTFxdl9hUNNM/+SJJGJi0KcAPxbW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqQj/Jki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqQj/Jki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBC6C4CEED;
	Mon, 21 Jul 2025 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753104071;
	bh=+Rs7u8kTc1dBhO1Z31VFKO/SHgaW/BFajAQvzqyjiYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqQj/Jki5T+/WgNKZRIa4TjprbZLIziLodKspyeiIB3vvvz4xTHhcFphB/Evp1c6/
	 UQK6T5FrOvRqR1RUAlsYkk4TfVbpyrlCMvBLZVud5w4i31n0snbxU9nJJsAmvzhDtU
	 5FHKvNPQX6Kt47DzhLdPKoTPL1Dxxg0ftR9G8FofdOWGtSejYaz7/3WWUN5zemfxlp
	 xDwgtBeo0J1sQ1k7JnZcIWA+GXEAMbt5ddmLnWw4z8t+XrCTc8CSdjIXIyiNrLNB+n
	 tsGKYbcZnUtQYKXl6ThksZR/UlpaDbsYSTSGShp3J45wsooZuTL8MQ0mvW67wVc4X7
	 0LTfRhUvJ+YBA==
Date: Mon, 21 Jul 2025 14:21:06 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Do not bother impl_ops if
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3
Message-ID: <aH4-wuIjtjyo3aOo@willie-the-truck>
References: <20250718234822.1734190-1-nicolinc@nvidia.com>
 <20250718234822.1734190-2-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718234822.1734190-2-nicolinc@nvidia.com>

On Fri, Jul 18, 2025 at 04:48:21PM -0700, Nicolin Chen wrote:
> When viommu type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, always return or init the
> standard struct arm_vsmmu, instead of going through impl_ops that must have
> its own viommu type than the standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3.
> 
> Given that arm_vsmmu_init() is called after arm_smmu_get_viommu_size(), any
> unsupported viommu->type must be a corruption. And missing a pairing impl's
> vsmmu_init should be a driver bug too. Warn these two cases.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 30 ++++++++++++-------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index d9bea8f1f636..0b2acb80f41b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -420,14 +420,13 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
>  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
>  		return 0;
>  
> -	if (smmu->impl_ops && smmu->impl_ops->vsmmu_size &&
> -	    viommu_type == smmu->impl_ops->vsmmu_type)
> -		return smmu->impl_ops->vsmmu_size;
> +	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
>  
> -	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +	if (!smmu->impl_ops || !smmu->impl_ops->vsmmu_size ||
> +	    viommu_type != smmu->impl_ops->vsmmu_type)
>  		return 0;
> -
> -	return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
> +	return smmu->impl_ops->vsmmu_size;
>  }
>  
>  int arm_vsmmu_init(struct iommufd_viommu *viommu,
> @@ -447,12 +446,21 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
>  	/* FIXME Move VMID allocation from the S2 domain allocation to here */
>  	vsmmu->vmid = s2_parent->s2_cfg.vmid;
>  
> -	if (smmu->impl_ops && smmu->impl_ops->vsmmu_init &&
> -	    viommu->type == smmu->impl_ops->vsmmu_type)
> -		return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
> +	if (viommu->type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3) {
> +		viommu->ops = &arm_vsmmu_ops;
> +		return 0;
> +	}
>  
> -	viommu->ops = &arm_vsmmu_ops;
> -	return 0;
> +	/*
> +	 * If a non standard type was supported in arm_smmu_get_viommu_size() by
> +	 * an implementation, a pairing vsmmu_init op must exist.
> +	 */
> +	if (WARN_ON_ONCE(!smmu->impl_ops || !smmu->impl_ops->vsmmu_init))
> +		return -EOPNOTSUPP;

It might be cleaner to check the impl_ops in arm_smmu_impl_probe() where
we're in a slightly better situation for failing gracefully and
deterministically.

Otherwise, looks good. Thanks!

Will
