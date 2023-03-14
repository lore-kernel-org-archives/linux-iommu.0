Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676333F1
	for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 11:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F55C433D2;
	Tue, 14 Mar 2023 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678792595;
	bh=X79Nu2WajvAG3kli7S5MqWpdmAMN0QzyYnzwzhO4DiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNE0y1y2KTBBZNwv8LIEziaJnVts65bVWMcZFkN4LOMqucsm+9GLRotYVlSBKkzHq
	 LNxX3Dv8lO4mCn5e4NlsmtnCd27Djfrxvj6ar3nxsHI4YtE6GHw1soHtBRrx4GYp++
	 AmoaE00KaCYFF6XArFU+hvJ/Ex3FF17mmuW+uz9IqGpeDG8OI+V8bW4+Rs+WKhyqaf
	 zVwKLdKA/3/XeLd/YuLttb6/j+uHtyNbCcjh1uNx9dV1cWjjBtrofsL8CLHURaYsb1
	 aA76qu9Ty+5XZfkNa+iXw6Z8xIT7pW21xQD+SGZifTxZNxxozfvgyu+e2la4as6OGY
	 +gFdKkShEgBNg==
Received: from johan by xi.lan with local (Exim 4.94.2)
	(envelope-from <johan@kernel.org>)
	id 1pc2ew-0006CO-B7; Tue, 14 Mar 2023 12:17:39 +0100
Date: Tue, 14 Mar 2023 12:17:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com>
References: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>

On Tue, Mar 14, 2023 at 04:29:05PM +0530, Manivannan Sadhasivam wrote:
> The logic used to find the quirky firmware that intercepts the writes to
> S2CR register to replace bypass type streams with a fault, and ignore the
> fault type, is not working with the firmware on newer SoCs like SC8280XP.
> 
> The current logic uses the last stream mapping group (num_mapping_groups
> - 1) as an index for finding quirky firmware. But on SC8280XP, NUSMRG
> reports a value of 162 (possibly emulated by the hypervisor) and logic is
> not working for stream mapping groups > 128. (Note that the ARM SMMU
> architecture specification defines NUMSMRG in the range of 0-127).
> 
> So the current logic that checks the (162-1)th S2CR entry fails to detect
> the quirky firmware on these devices and SMMU triggers invalid context
> fault for bypass streams.
> 
> To fix this issue, rework the logic to find the first non-valid (free)
> stream mapping register group (SMR) within 128 groups and use that index
> to access S2CR for detecting the bypass quirk. If no free groups are
> available, then just skip the quirk detection.
> 
> While at it, let's move the quirk detection logic to a separate function
> and change the local variable name from last_s2cr to free_s2cr.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> * Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
> * Moved the quirk handling to its own function
> * Collected review tag from Bjorn
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 48 ++++++++++++++++++----
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d1b296b95c86..48362d7ef451 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -266,25 +266,49 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	return 0;
>  }
>  
> -static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> +static void qcom_smmu_bypass_quirk(struct arm_smmu_device *smmu)
>  {
> -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
>  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> -	u32 reg;
> -	u32 smr;
> +	u32 free_s2cr;
> +	u32 reg, smr;
>  	int i;
>  
> +	/*
> +	 * Find the first non-valid (free) stream mapping register group and
> +	 * use that index to access S2CR for detecting the bypass quirk.
> +	 *
> +	 * Note that only the first 128 stream mapping groups are considered for
> +	 * the check. This is because the ARM SMMU architecture specification
> +	 * defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> +	 * range of 0-127, but some Qcom platforms emulate more stream mapping
> +	 * groups with the help of hypervisor. And those groups don't exhibit
> +	 * the quirky behavior.
> +	 */
> +	for (i = 0; i < 128; i++) {

This may now access registers beyond smmu->num_mapping_groups. Should
you not use the minimum of these two values here (and below)?

> +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +
> +		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> +			break;
> +	}
> +
> +	/* If no free stream mapping register group is available, skip the check */
> +	if (i == 128)
> +		return;

Johan
