Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84E4C78
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 13:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AD5C433C1;
	Mon, 14 Nov 2022 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668433863;
	bh=ugtcmt7FyPihhJ5NcM21Bx302D5wCzUkW8Okfg6RYvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8onaSjHBRHzE8wxh5vslXQpRI4NRb3sBz31h0p92zvb4qVsENG1qmK+olWrWD6e2
	 1xyLH14xUBfssEMvnKDJD+AZIaP55MHe2Lb6lCsOLaYBqv2y864dbbRvckC1CaE1A1
	 bzpEc+RonbXCltx3H71Zm7iKa+0p/vCMSznz31SLiL3BMjEHHwEat/I36CEyHtlTDe
	 Q0odXn13SjXBG46audjKy1Ru3qO6MY9Jln9+LuU51+5sXhtOrwTuCc/SkXH/cyZCCW
	 6633Qoo+XuB1f5OI50TvZqcZRzTqYaLNV2DdFZwAEoB51gtgO6lyVuoIzYfYAaZlkt
	 REI43axuPvQpw==
Date: Mon, 14 Nov 2022 13:50:58 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jgg@nvidia.com,
	robin.murphy@arm.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Restore prints in
 arm_smmu_attach_dev()
Message-ID: <20221114135057.GE30263@willie-the-truck>
References: <20221109184636.14264-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109184636.14264-1-nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Nov 09, 2022 at 10:46:36AM -0800, Nicolin Chen wrote:
> The prints for incompatible failures in arm_smmu_attach_dev() might be
> still useful for error diagnosis. As VFIO and IOMMUFD would do testing
> attach() call, having previous dev_err() isn't ideal either.
> 
> Add the prints back using dev_dbg().
> 
> Fixes: f4a147735793 ("iommu: Use EINVAL for incompatible device/domain in ->attach_dev")
> Suggested-by: Will Deacon <will@kernel.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v1->v2:
>  * Add "Fixes" line and Reviewed-by from Jason
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ab160198edd6..076d3710b1fe 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2433,14 +2433,21 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  			goto out_unlock;
>  		}
>  	} else if (smmu_domain->smmu != smmu) {
> +		dev_dbg(dev, "cannot attach to SMMU %s (upstream of %s)\n",
> +			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>  		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> +		dev_dbg(dev,
> +			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
> +			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>  		   smmu_domain->stall_enabled != master->stall_enabled) {
> +		dev_dbg(dev, "cannot attach to stall-%s domain\n",
> +			smmu_domain->stall_enabled ? "enabled" : "disabled");
>  		ret = -EINVAL;
>  		goto out_unlock;

Thanks!

Acked-by: Will Deacon <will@kernel.org>

Will
