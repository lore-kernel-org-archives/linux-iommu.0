Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C105125A0
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSMpcX2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743F1C433C7;
	Fri, 13 Oct 2023 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697193459;
	bh=zCl130cOhlxlcu/IVPK/z4AycuQkVXegO7G7ZHK+xp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSMpcX2f5FxjXe9YktbGYZgX7ur3ftBIFHsxR5w4Rtam5S0OFZw9ECxtJ2NpkNhhy
	 9S1Cyn2D34bVKtWolQSyXWSggDlabV1eBFEHCSX96xlsEh1fZkBGE64sWHsMnEmV1o
	 fPSDWkxkhYGAivKPB8HaK3R6AGMccAgz88IAtEHDh3mLRWSCXGTp6vLG2vgF20MH+k
	 MY8MRYEc9giNUUTkZ4dFQTpWZxECIK6O1yeIadkv1CHCM6JtFN6EkP0lu1vLgY/7Nd
	 vM+d/FUl9T7N76bv5fJqH4u/qUz5TP4kDeurzTYVVy6G304x48MZlUfjRBGKAYwaZU
	 Fmfu4RjhnoYjg==
Date: Fri, 13 Oct 2023 11:37:35 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 01/19] iommu/arm-smmu-v3: Add a type for the STE
Message-ID: <20231013103734.GA13594@willie-the-truck>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <1-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 10, 2023 at 09:33:07PM -0300, Jason Gunthorpe wrote:
> Instead of passing a naked __le16 * around to represent a STE wrap it in a
> "struct arm_smmu_ste" with an array of the correct size. This makes it
> much clearer which functions will comprise the "STE API".
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 54 ++++++++++-----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 ++-
>  2 files changed, 32 insertions(+), 29 deletions(-)

[...]

> @@ -2209,26 +2210,22 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>  	return 0;
>  }
>  
> -static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> +static struct arm_smmu_ste *
> +arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
>  {
> -	__le64 *step;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>  
>  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> -		struct arm_smmu_strtab_l1_desc *l1_desc;
>  		int idx;
>  
>  		/* Two-level walk */
>  		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
> -		l1_desc = &cfg->l1_desc[idx];
> -		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
> -		step = &l1_desc->l2ptr[idx];
> +		return &cfg->l1_desc[idx].l2ptr[sid & ((1 << STRTAB_SPLIT) - 1)];
>  	} else {
>  		/* Simple linear lookup */
> -		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
> +		return (struct arm_smmu_ste *)&cfg
> +			       ->strtab[sid * STRTAB_STE_DWORDS];

Why not change the type of 'struct arm_smmu_strtab_cfg::strtab' at the same
time?

Will
