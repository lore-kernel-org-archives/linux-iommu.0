Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690976FAA
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 14:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEFDC433D2;
	Wed, 22 Mar 2023 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679493991;
	bh=mSFTh2io+5nE1DlYXY/49SnI5K+3qCrWULBm9ytRUMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJrI86yPgo9CQzNsI67X4JmWkFOuqsLXgouJaUzBpka6eS3mzGYQ/ieRqDEBJzDY7
	 BfGQuocSKpcpHH9Vd+dFU5fpdlMJsujL1nVgM7LXzp42GfXHQyRVFMphQcqns0MYi9
	 mTuy2bucnxHKUEMlO0Y26hx8j1mvu1lTZ0zS2qaegunYOaK2Z/RIoeS+yhMA/ly2U+
	 FzKIRq7NBdBwh9T1VnKOMRzP0eSSeCu4Ko4z97FOEPsauSYJ1fITXQvMFJ0LotMtX/
	 CcNMLaOiOBI7280uhQmF3ga0jyB4ui/oI83f5vLYxyjMZA6IPDWSw+am7f+AMicM3Z
	 VFfo1+ULWhLIA==
Date: Wed, 22 Mar 2023 07:09:43 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	johan+linaro@kernel.org, steev@kali.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Message-ID: <20230322140943.v6hhtyszw4k3vclr@ripper>
References: <20230321091332.18334-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321091332.18334-1-manivannan.sadhasivam@linaro.org>

On Tue, Mar 21, 2023 at 02:43:32PM +0530, Manivannan Sadhasivam wrote:
> On some Qualcomm platforms, the hypervisor emulates more than 128 SMR
> (Stream Matching Register) groups.

As we last week discussed, this isn't at all the case. The hardware has
more than 128 SMRs, it's _not_ emulating additional SMRs.

As pointed out by Robin that might not be according to spec, so it might
be wrong to claim it's compatible with mmu-500. I think limiting the
num_mapping_groups to 128 is a good way to handle this until further
clarity can be acquired.

> This doesn't conform to the ARM SMMU
> architecture specification which defines the range of 0-127. Moreover, the
> emulated groups don't exhibit the same behavior as the architecture
> supported ones.
> 
> For instance, emulated groups will not detect the quirky behavior of some
> firmware versions intercepting writes to S2CR register, thus skipping the
> quirk implemented in the driver and causing boot crash.
> 

From the history of this driver we know that hypervisor traps the writes
to these registers, could it be that the trap doesn't act correctly for
the higher SMRs - for some reason?

> So let's limit the groups to 128 and issue a notice to users in that case.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v4:
> 
> * Spun off the SMR limiting part into a separate patch
> * Dropped the quirk rework part as it is not really needed for now
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
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d1b296b95c86..54f62d409619 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -268,12 +268,26 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  
>  static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
>  {
> -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
>  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	unsigned int last_s2cr;
>  	u32 reg;
>  	u32 smr;
>  	int i;
>  
> +	/*
> +	 * Limit the number of stream matching groups to 128 as the ARM SMMU
> +	 * architecture specification defines NUMSMRG (Number of Stream Mapping
> +	 * Register Groups) in the range of 0-127, but some Qcom platforms
> +	 * emulate more stream mapping groups.

As discussed, this isn't true.

>                                              And those groups don't exhibit
> +	 * the same behavior as the architecture supported ones.

I share this observation, and I think the patch is reasonable - but not
the commit message and above part of the comment.

Regards,
Bjorn

> +	 */
> +	if (smmu->num_mapping_groups > 128) {
> +		dev_notice(smmu->dev, "\tLimiting the stream matching groups to 128\n");
> +		smmu->num_mapping_groups = 128;
> +	}
> +
> +	last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> +
>  	/*
>  	 * With some firmware versions writes to S2CR of type FAULT are
>  	 * ignored, and writing BYPASS will end up written as FAULT in the
> -- 
> 2.25.1
> 
