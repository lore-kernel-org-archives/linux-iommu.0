Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF863AB
	for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 17:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CAAC433D2;
	Fri, 10 Feb 2023 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676051146;
	bh=18FvvRc/b4qiJdjxT1xNMr4blSjUYCJiD2qx4j/NdFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOEaCQCDMdAtfCJi5EQOUFQ/QsJRkMmsN/shi62fWTv9KwqWeQEUUu+DILi0GEUu1
	 2Ygj4LrLRSPzVmvKGU+Cja2tF6jASohwN+ehzzFmbk3nE2ggO8Vv0Reh1wLrTObpBb
	 WJq5GvD+iLVtwx59vizkc39ZfuNempRkNIengrIQAUc9z+XnwFgMTHhZegylhZLw1o
	 istVLBx9CAp7P2e7825Z74KwT0zIaOfib3kOq6I+AAimgZ49j5tv7VKfNJOagsXzlc
	 PWZ96/JXYnwowTakemLwHC3EIX8q9UdNDFzMqu+umM02lQob+8P8WX79sx/it87fCO
	 mThytW40PmU5g==
Date: Fri, 10 Feb 2023 09:47:55 -0800
From: Bjorn Andersson <andersson@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	johan+linaro@kernel.org, steev@kali.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Rework the logic finding the bypass
 quirk
Message-ID: <20230210174755.la6rj3m3a33d53lf@ripper>
References: <20230201082500.61656-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201082500.61656-1-manivannan.sadhasivam@linaro.org>

On Wed, Feb 01, 2023 at 01:55:00PM +0530, Manivannan Sadhasivam wrote:
> The logic used to find the quirky firmware that intercepts the writes to
> S2CR register to replace bypass type streams with a fault, and ignore the
> fault type, is not working with the firmware on newer SoCs like SC8280XP.
> 
> The current logic uses the last stream mapping group (num_mapping_groups
> - 1) as an index for finding quirky firmware. But on SC8280XP, this
> logic is not working as the number of stream mapping groups reported by
> the SMMU (163 as on the SC8280XP-CRD device) is not valid for some reason.
> So the current logic that checks the (163-1) S2CR entry fails to detect
> the quirky firmware on these devices and triggers invalid context fault
> for bypass streams.
> 
> To fix this issue, rework the logic to find the first non-valid (free)
> stream mapping register group (SMR) and use that index to access S2CR
> for detecting the bypass quirk.
> 
> This also warrants a change in variable name from last_s2cr to free_s2cr.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 +++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 78fc0e1bf215..4104f81b8d8f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -267,23 +267,37 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  
>  static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
>  {
> -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
>  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	u32 free_s2cr;
>  	u32 reg;
>  	u32 smr;
>  	int i;
>  
> +	/*
> +	 * Find the first non-valid (free) stream mapping register group and
> +	 * use that index to access S2CR for detecting the bypass quirk.
> +	 */
> +	for (i = 0; i < smmu->num_mapping_groups; i++) {
> +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +
> +		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> +			break;
> +	}
> +
> +	free_s2cr = ARM_SMMU_GR0_S2CR(i);
> +
>  	/*
>  	 * With some firmware versions writes to S2CR of type FAULT are
>  	 * ignored, and writing BYPASS will end up written as FAULT in the
> -	 * register. Perform a write to S2CR to detect if this is the case and
> -	 * if so reserve a context bank to emulate bypass streams.
> +	 * register. Perform a write to the first free S2CR to detect if
> +	 * this is the case and if so reserve a context bank to emulate
> +	 * bypass streams.
>  	 */
>  	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
>  	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
>  	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
> -	arm_smmu_gr0_write(smmu, last_s2cr, reg);
> -	reg = arm_smmu_gr0_read(smmu, last_s2cr);
> +	arm_smmu_gr0_write(smmu, free_s2cr, reg);
> +	reg = arm_smmu_gr0_read(smmu, free_s2cr);
>  	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
>  		qsmmu->bypass_quirk = true;
>  		qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
> -- 
> 2.25.1
> 
