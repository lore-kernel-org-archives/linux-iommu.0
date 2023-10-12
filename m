Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCE802
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDGE7WqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613C1C433C7;
	Thu, 12 Oct 2023 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697115374;
	bh=vNui3MSrHwAI++J+DJ8BgqwZ/T4bJhNXSFBtteOZtHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDGE7WqEjJP9fczYEAK2GxMtarIG+Mw1T4I/MMiGZ2e8RuFK6lB7xSJDsj2vch82I
	 GGQh5SDSOfSQslY2IvZ5ynphv/hafD3WvIHGqCQC+joaRg775lstfsHAV7/RQz7wGL
	 AE4D6ahH+D1IUzMNYTUp6609UQdAZaYazgWz9w5MzrozKT2aHsfbaC2bZuEz6Syw6v
	 REIJfLp8gbKuwKyczeh/jJHI3icq15VMMeAg1cptLjzOv1QLx68uouTO0JC3KAzXDM
	 FJlAj6r13eHhG6ARDsKWP3Z3ytqonFqIz7VN7uES2KjyyC+DFUxz7zPV15+FEPnsQq
	 uhRuiaV+JKEGw==
Date: Thu, 12 Oct 2023 13:56:09 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, jgg@nvidia.com,
	baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iommu/arm-smmu: Don't register fwnode for legacy
 binding
Message-ID: <20231012125609.GA12142@willie-the-truck>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <3a5cd62dd21ed58f337bb9a389d301054e503dc3.1697047261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5cd62dd21ed58f337bb9a389d301054e503dc3.1697047261.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 11, 2023 at 07:14:52PM +0100, Robin Murphy wrote:
> When using the legacy binding we bypass the of_xlate mechanism, so avoid
> registering the instance fwnodes which act as keys for that. This will
> help __iommu_probe_device() to retrieve the registered ops the same way
> as for x86 etc. when no fwspec has previously been set up by of_xlate.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc0..4b83a3adacd6 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2161,7 +2161,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
> +	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
> +				    using_legacy_binding ? NULL : dev);
>  	if (err) {
>  		dev_err(dev, "Failed to register iommu\n");
>  		iommu_device_sysfs_remove(&smmu->iommu);
> -- 
> 2.39.2.101.g768bb238c484.dirty

Acked-by: Will Deacon <will@kernel.org>

Will
