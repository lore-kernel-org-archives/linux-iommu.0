Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0619202F8B;
	Mon, 21 Jul 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125822; cv=none; b=jmB1LBKLrqq7Q4CrpYD0Me61ZQ2YdbPlT8HAdXSGdvYgA+2TMgghKTYZN+3Pz1DSJ/pLgsgAiGJnovH859anMala9G2TAfC//FPLN1CPMlPs7DvvutFFZ813CEcvugGEQ9RQ/AdYwxpuh4i8J4eKDPbetaGxBOuAXlcuPXQa6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125822; c=relaxed/simple;
	bh=Aws3PhmMgoBZ58qJM7UE1xab7bz1LhXmpSvwVKlcB+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEUsaGX78lyFno/qiCNwvL83PD1NKpBvuGhz9Rbh7aJJ5RJmcb2Kepv30NowANOlIYfATDTHEWSkCYsqfBazNHWWJGlidKn5cxQ+XKhJ7Jt4L9MIciO51DCJv1xnwvVT/QDFOJNwEmJDXyVYZGfHx48yHrOt35uZyjHhz8SW6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL+KKSZn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL+KKSZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2949C4CEED;
	Mon, 21 Jul 2025 19:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753125821;
	bh=Aws3PhmMgoBZ58qJM7UE1xab7bz1LhXmpSvwVKlcB+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PL+KKSZnBXHZpDllvLIVOosemhc1Ker6OgY95UYhzdDRMWX2Rfrt5r299/Q3RIfUg
	 RPRTawET1NkkiQjmkifIXqjRa+hDGUJRxIxvjBGPAd9XjSlX0pffoFcWwB60vbm/9o
	 ILUGtXLbFp7w/m/6/gkVtPbw0HAhJbgaLjx2FomVI9CpapYAlr735kk0nIk1ChCmJC
	 fm4niJFKVCR77ogTpcHQAMvaZqxZMjURJCd5Mb/iDMUgavAg3sNk22XwDhEPlEoNbM
	 5D98rLIpv5u8cZsZKpLtWwj6a8VSC+3lEY9sAolvvw8yJMXLRzBaH5NRprSmcYcw+P
	 nPudwUgR+ZcMg==
Date: Mon, 21 Jul 2025 20:23:36 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Do not bother impl_ops if
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3
Message-ID: <aH6TuLAz4DeoLByx@willie-the-truck>
References: <20250721191236.1739951-1-nicolinc@nvidia.com>
 <20250721191236.1739951-2-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721191236.1739951-2-nicolinc@nvidia.com>

On Mon, Jul 21, 2025 at 12:12:35PM -0700, Nicolin Chen wrote:
> When viommu type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, always return or init the
> standard struct arm_vsmmu, instead of going through impl_ops that must have
> its own viommu type than the standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3.
> 
> Given that arm_vsmmu_init() is called after arm_smmu_get_viommu_size(), any
> unsupported viommu->type must be a corruption. And it must be a driver bug
> that its vsmmu_size and vsmmu_init ops aren't paired. Warn these two cases.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 ++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 14 +++++++++++
>  2 files changed, 27 insertions(+), 11 deletions(-)

Cheers for the quick respin.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 181d07bc1a9d..dfe7f40fac35 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4703,6 +4703,7 @@ static void arm_smmu_impl_remove(void *data)
>  static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
>  {
>  	struct arm_smmu_device *new_smmu = ERR_PTR(-ENODEV);
> +	const struct arm_smmu_impl_ops *ops;
>  	int ret;
>  
>  	if (smmu->impl_dev && (smmu->options & ARM_SMMU_OPT_TEGRA241_CMDQV))
> @@ -4713,11 +4714,24 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
>  	if (IS_ERR(new_smmu))
>  		return new_smmu;
>  
> +	ops = new_smmu->impl_ops;
> +	if (ops) {
> +		/* vsmmu_size and vsmmu_init ops must be paired */
> +		if (WARN_ON(!ops->vsmmu_size ^ !ops->vsmmu_init)) {
> +			ret = -EINVAL;
> +			goto err_remove;
> +		}

I suppose that could be != instead of ^ to avoid mixing up logical and
arithmetic operators, but it does the trick either way so:

Acked-by: Will Deacon <will@kernel.org>

Will
