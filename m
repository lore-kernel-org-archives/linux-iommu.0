Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDDE63D6
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 18:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931F9C433C1;
	Mon, 21 Nov 2022 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669053958;
	bh=2lsKTqMwT3+dFZ/UNz0+idX/0zWQNI0kZA93uSAEzok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNE83fCrpTjfNKpfavKQY0d8ZCGu+vrkGg/8UyFeYRvXlX1NfEZcNR/tYILbpqLLr
	 /XZ7a/uc811rQ0jPlBBMo1llNzphr+iZpkz+odRkW40P656uPlQi3r49C39atQkCl3
	 eG6dpAhOioHmpQX1FY1iq0PToG+Jq4dLKxxLUhMIEgBHpC3mZULCOgsIiPpcz0EJIX
	 KLk58eVphGBPJSWXFkPnErSMUKwP18Yyy5q9oINMj+PKrK1RMfpcWZ6ESMSEUeOjYY
	 WpHFXSodtjxs6v+WD8j+7uqx+HaPaKRFsTEtovoOBIHNwI2+itL2wywcsfYuF76zJh
	 DV9BckaYUyxag==
Date: Mon, 21 Nov 2022 18:05:53 +0000
From: Will Deacon <will@kernel.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: fix smmu initialization memory leak problem
Message-ID: <20221121180552.GB7645@willie-the-truck>
References: <20221121030421.19295-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121030421.19295-1-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Nov 21, 2022 at 11:04:21AM +0800, Longfang Liu wrote:
> When iommu_device_register() in arm_smmu_device_probe() fails,
> in addition to sysfs needs to be deleted, device should also
> be disabled, and the memory of iopf needs to be released to
> prevent memory leak of iopf.
> 
> Changes v1 -> v2:
> 	-Improve arm_smmu_device_probe() abnormal exit function.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ab160198edd6..b892f5233f88 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3815,7 +3815,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	/* Initialise in-memory data structures */
>  	ret = arm_smmu_init_structures(smmu);
>  	if (ret)
> -		return ret;
> +		goto err_iopf;
>  
>  	/* Record our private device structure */
>  	platform_set_drvdata(pdev, smmu);
> @@ -3826,22 +3826,28 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	/* Reset the device */
>  	ret = arm_smmu_device_reset(smmu, bypass);
>  	if (ret)
> -		return ret;
> +		goto err_iopf;
>  
>  	/* And we're up. Go go go! */
>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>  				     "smmu3.%pa", &ioaddr);
>  	if (ret)
> -		return ret;
> +		goto err_reset;
>  
>  	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>  	if (ret) {
>  		dev_err(dev, "Failed to register iommu\n");
> -		iommu_device_sysfs_remove(&smmu->iommu);
> -		return ret;
> +		goto err_sysfs_add;
>  	}
>  
>  	return 0;
> +err_sysfs_add:
> +	iommu_device_sysfs_remove(&smmu->iommu);
> +err_reset:
> +	arm_smmu_device_disable(smmu);
> +err_iopf:
> +	iopf_queue_free(smmu->evtq.iopf);
> +	return ret;

I previously suggested using devres_alloc() for this instead. Did that
not work?

Will
