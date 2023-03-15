Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74E23A3
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 07:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9C7C4339B;
	Wed, 15 Mar 2023 07:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678865787;
	bh=ZYDZG0AFkg85mqgfMegLB+mKtObXC9wAdTrE7vX9jrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9Spjvp6W7BjDBA/iYXhFVE7AUm80xx8cDbgtOxMku3suGMLkuODlPhoBzMFnUXtN
	 GS0DQwP4SK3tS4fNtb6pnjvGQCe0WnL77nD1BZ237/9ALrjfJwxNpLuuenWSZCy1BN
	 sLYb5yzoxfXdvmREH2oqAKBCyLu9jTzTcv6BHT29/jmZRugYVkHewJbpJbjFEiZ9/D
	 MM1mnPXf7EX8yadgEdQNp88+tbXM/OoQBa5c/hTu/1NrtP5v5419ve9mu/Fzunrq9k
	 lHOCEispcIUBCmJ628AL9W9TPOx0knlgTYPxFNbds0CwpA1eBNxzsM+WPy5d4S1HOX
	 YFGEwIF5CuAtg==
Received: from johan by xi.lan with local (Exim 4.94.2)
	(envelope-from <johan@kernel.org>)
	id 1pcLhU-0004TL-Ba; Wed, 15 Mar 2023 08:37:33 +0100
Date: Wed, 15 Mar 2023 08:37:32 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <ZBF1vFBWKXhHeD2v@hovoldconsulting.com>
References: <20230314184659.176473-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314184659.176473-1-manivannan.sadhasivam@linaro.org>

On Wed, Mar 15, 2023 at 12:16:59AM +0530, Manivannan Sadhasivam wrote:
> The logic used to find the quirky firmware that intercepts the writes to
> S2CR register to replace bypass type streams with a fault, and ignore the
> fault type, is not working with the firmware on newer SoCs like SC8280XP.
> 
> The current logic uses the last stream mapping group (num_mapping_groups
> - 1) as an index for finding quirky firmware. But on SC8280XP, NUMSMRG
> reports a value of 162 due to emulation and the logic is not working for
> stream mapping groups > 128. (Note that the ARM SMMU architecture
> specification defines NUMSMRG in the range of 0-127).
> 
> So the current logic that checks the (162-1)th S2CR entry fails to detect
> the quirky firmware on these devices and SMMU triggers invalid context
> fault for bypass streams.
> 
> To fix this issue, let's limit "num_mapping_groups" to 128 as per ARM SMMU
> spec and rework the logic to find the first non-valid (free) stream mapping
> register group (SMR) and use that index to access S2CR for detecting the
> bypass quirk. If no free groups are available, then just skip the quirk
> detection.
> 
> While at it, let's move the quirk detection logic to a separate function
> and change the local variable name from last_s2cr to free_s2cr.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v3:
> 
> * Limited num_mapping_groups to 128 as per ARM SMMU spec and removed the
>   check for 128 groups in qcom_smmu_bypass_quirk()
> * Reworded the commit message accordingly
> 
> Changes in v2:
> 
> * Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
> * Moved the quirk handling to its own function
> * Collected review tag from Bjorn

> +static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> +{
> +	u32 smr;
> +	int i;
> +
> +	/*
> +	 * Limit the number of stream matching groups to 128 as the ARM SMMU architecture
> +	 * specification defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> +	 * range of 0-127, but some Qcom platforms emulate more stream mapping groups. And
> +	 * those groups don't exhibit the same behavior as the architecture supported ones.
> +	 */

Please fix your editor so that it wraps lines at 80 columns, which is
still the preferred (soft) limit.

> +	if (smmu->num_mapping_groups > 128) {
> +		dev_warn(smmu->dev, "\tLimiting the stream matching groups to 128\n");

dev_notice() should do since there's nothing a user can do about this.

> +		smmu->num_mapping_groups = 128;
> +	}

So this hunk is really all that is needed to make the current quirk
detection work on sc8280xp. Why not simply stick with the current logic
and use the last group until there is a need for anything more?

Also, should this not be done in arm_smmu_device_cfg_probe() as I
suggested earlier (e.g. to avoid allocating resources for the groups
that will never be used)?

> +
> +	qcom_smmu_bypass_quirk(smmu);
>  
>  	for (i = 0; i < smmu->num_mapping_groups; i++) {
>  		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));

Johan
