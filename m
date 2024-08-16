Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE971B8E9B;
	Fri, 16 Aug 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814469; cv=none; b=V7BZSfp/6WenQjZhQIOUxFFG0NU2xpceIYlUKw2Ez4wJr63xlPl0RJgV1y024zRFemVbPELZ/vQvoRPXGTEwGlqLqFrtrJgaGbuIak0d/njNH2cSRWatKjt1p1FU95MY2BgV/ukZCXGwEqLI1BmM2bmg9W8GWSltzA4Ql/ndN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814469; c=relaxed/simple;
	bh=a2Kf6a8V9/SSavactzIhoatEiARq9RMYi5B2/3we3eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af5MLUTFYYtERNDq1Cpgu7mNCKogviOapWKHp639WXPpaouM8M+lNYaw7S7yo0x9FPUn2eNPz51H6uYe2Lnc2ZM8RoEG5dI+YY3rQ7+wy8Vsm+axXKq6yD9M1ClRin6Rk1ATvfLA/0RkOw+jhZoz9ZH+AO0p81+3HObuGxLiAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1Ux+NDM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1Ux+NDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B88EC32782;
	Fri, 16 Aug 2024 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723814469;
	bh=a2Kf6a8V9/SSavactzIhoatEiARq9RMYi5B2/3we3eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1Ux+NDMqLquWHD24RThGYzsYU5Ru0ybzHSSg6uRINnbKY6yKpzOy8Iyyb2K1xmkH
	 Xj48wX2XIWpHykMiimGieQQyQEu/6oCgfzRG1ljEhCTGTqB4griDrOsx0pe2iALSZd
	 OR/lkakZ8L6T0qy3o57lEtnliFPctKWHYFA5O7w9yYOaXJtX24YmZJurAQGMOEEYeO
	 PoB7SDkiuw9NJs5GJ2qc60Q7OEAHvcGKeH4zZ8hrrdCjVvCaUXE5+t7wfvDMKo9hYS
	 CxbfPBgvcV6AK04uAdMge/h6yQaf4B+y3ywwPXpDobOoMXMO/7mqHESOl29Zx4C2Yd
	 i9RTMYO38baog==
Date: Fri, 16 Aug 2024 14:21:03 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 9/9] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <20240816132103.GA24411@willie-the-truck>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <153fb887cf4bf6318c6f313a4be9b40a25a24e7d.1722993435.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153fb887cf4bf6318c6f313a4be9b40a25a24e7d.1722993435.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 06, 2024 at 07:11:54PM -0700, Nicolin Chen wrote:
> When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
> only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
> add a new helper to scan the input cmd to make sure it is supported when
> selecting a queue, though this assumes that SMMUv3 driver will only add
> the same type of commands into an arm_smmu_cmdq_batch as it does today.
> 
> Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
> guest kernel driver writing it or not, i.e. the hypervisor running in the
> host OS should wire this bit to zero when trapping a write access to this
> VINTF_CONFIG register from a guest kernel.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 22 +++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +-
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 35 ++++++++++++++++++-
>  3 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 18d940c65e2c..8ff8e264d5e7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -336,12 +336,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  	return 0;
>  }
>  
> -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> +static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
> +					       u8 opcode)
>  {
>  	struct arm_smmu_cmdq *cmdq = NULL;
>  
>  	if (smmu->impl && smmu->impl->get_secondary_cmdq)
> -		cmdq = smmu->impl->get_secondary_cmdq(smmu);
> +		cmdq = smmu->impl->get_secondary_cmdq(smmu, opcode);
>  
>  	return cmdq ?: &smmu->cmdq;
>  }
> @@ -889,7 +890,7 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  	}
>  
>  	return arm_smmu_cmdq_issue_cmdlist(
> -		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
> +		smmu, arm_smmu_get_cmdq(smmu, ent->opcode), cmd, 1, sync);
>  }
>  
>  static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> @@ -905,10 +906,13 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
>  }
>  
>  static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
> -				     struct arm_smmu_cmdq_batch *cmds)
> +				     struct arm_smmu_cmdq_batch *cmds,
> +				     u8 opcode)
>  {
> +	WARN_ON_ONCE(!opcode);

This seems like a fairly arbitrary warning. Remove it?

> +
>  	cmds->num = 0;
> -	cmds->cmdq = arm_smmu_get_cmdq(smmu);
> +	cmds->cmdq = arm_smmu_get_cmdq(smmu, opcode);

If we stashed the opcode here, we could actually just enforce that all
commands in the batch are the same type in arm_smmu_cmdq_batch_add().

Would that work better for you or not?

Will
