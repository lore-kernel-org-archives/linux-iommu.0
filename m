Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D13B38A9;
	Tue, 10 Mar 2026 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161428; cv=none; b=KMhVHaCtKDzLQHAAk/X3GoKENMvsZatOA57T78glWVBGzQMMltJg9gGvsHW+merFa5uNtCRFJsWQ2Oxu+g3Mh3YzeESQwgWmQqjRm3InbVCkoom/QfveEFMH317Skj2JP/9JaqUtOJMxXslCEPmyMONtX7zBsop2LNfc+iTnbAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161428; c=relaxed/simple;
	bh=BAxA5cq+4SCMpHLZSPR6IGnVcUVzSzmQy7VsDQVyUX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSKX2KuOzOFuqDg2ITfbKF2QUiUQO6jLbq961aqBKJky61hAsgwVG7JY/nGkGA6erexdUQp8gcMTcHd6EzLAT9kpf9QqwaTMSxd4Dxy3+QmoFkTLd6dGzGJu12imp+ru9WYiDE0LD5Ff6KylswJlTbt4IAZg9+kSy43kxl48H8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULTxrBpN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULTxrBpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93214C2BC9E;
	Tue, 10 Mar 2026 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773161428;
	bh=BAxA5cq+4SCMpHLZSPR6IGnVcUVzSzmQy7VsDQVyUX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULTxrBpNDsZcxV9AuGVsXi+DANSUSzVpfnuy2GPkkgeYbPno1sr+1uOzV718EewgQ
	 AC7sj6TUvxixeh67QfgXBu2PGYdNCMyWR4/H91vk3sKnEwxY+5Ycd7N8fXSXI+jCfa
	 W9JmAF1nN330XEAqewpnqCJiSXT5r9sKFJop5ITYVaS4TnuvudoZUOnhTbmaoXJB6g
	 +2I8j3Z/+TpbZw3ALUqKns73fQHgarvkhFgaZ9Y29scfKcfEmQYaW2BTFG2jG/hf/i
	 Dcr52hbeabN0EcsfDoMf0EkN9uTgZDGMWTuVTnwuiC/Kfvk7M741MEv3w5aofGPEBs
	 wzfpNE9GeiRbA==
Date: Tue, 10 Mar 2026 16:50:23 +0000
From: Will Deacon <will@kernel.org>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: arm-smmu-qcom: Ensure smmu is powered up in
 set_ttbr0_cfg
Message-ID: <abBLz16xYE0xJqgE@willie-the-truck>
References: <20260210-qcom_smmu_pmfix-v1-1-78b7143ac053@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-qcom_smmu_pmfix-v1-1-78b7143ac053@gmail.com>

On Tue, Feb 10, 2026 at 05:17:38PM +0100, Anna Maniscalco wrote:
> Previously the device was being accessed while potentially in a
> suspended state.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 573085349df3..ca34b7a141e6 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -231,16 +231,27 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
>  	struct io_pgtable *pgtable = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>  	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(smmu_domain->smmu->dev);
> +	if (ret < 0) {
> +		dev_err(smmu_domain->smmu->dev, "failed to get runtime PM: %d\n", ret);
> +		return -ENODEV;
> +	}
>  
>  	/* The domain must have split pagetables already enabled */
> -	if (cb->tcr[0] & ARM_SMMU_TCR_EPD1)
> -		return -EINVAL;
> +	if (cb->tcr[0] & ARM_SMMU_TCR_EPD1) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

Presumably, you only need to stabilise the power state across the call
to arm_smmu_write_context_bank(), in which case why not defer that until
you've gone past all these early exits?

Will
