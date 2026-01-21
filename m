Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A047F2E0;
	Wed, 21 Jan 2026 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010856; cv=none; b=IKRDqvJkOoOunG9SMwi18hOg/KwvhS8Nn8XqC/QqB6PlNFDyuS9naVw6+aUZOI1L7FnrUTWZZ6Bnv754pVWrgHV+Y3Pzpbwx04XLrozvX+/wqA6nY1CjLCkd9wk7N4ghuO/TaSSNCz8LpkGA8+9WwG4mKSsgwyC5afcA2SvMd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010856; c=relaxed/simple;
	bh=+141CksYSv3b4SLpMVPnysGzcabKoPf7/a948LcWCGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1Vrb6pij80S1XD621t3knq1/2F6Zk0Ws762sQ6BTq0mXw3rpkh8QTXaHTNJ2j0GjKmCJAsCsvHjU+Psd4l0k40b423OT36hbAN8PM0L2ZJMddDXHG+5/iDcJeuDc85ZdUL4gCEt8WNYxp/RMHYll+c00ExIekrzD2Uno2vPZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7PyGp6q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7PyGp6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9D3C4CEF1;
	Wed, 21 Jan 2026 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769010854;
	bh=+141CksYSv3b4SLpMVPnysGzcabKoPf7/a948LcWCGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7PyGp6qaS2fhjUjuXbfeoViLVg1VdUaQV7i21HfFLr1KRrNpiJBC0hv4FbJeywiK
	 ZA8Ex9jLxgJwER1WDj3rqmTP5sgOAUpSqeixhKaCnRdJ4gJ3/hhWDQrFRXaMADZ+9C
	 1oMzOYrqkgHIjMVp6hBMriwd323Jn0BYNPHzNTrud5C5JULW/vjVNn25N8tsV04sHd
	 v3cz8509AyBuXDS5sLLJWWWmXSeAkOTzAjT7N3Ux78yMfBrv7v8AwejLqHMt+/NsDS
	 r1Y8Nlj8q8uFHTGTYvB2PtFdQ7apDmoKMtIwFGjAPiEWk6PLwxF1+L/p9xj3NyWjuC
	 T8Ie1VLQWJLSw==
Date: Wed, 21 Jan 2026 09:54:11 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	robin.clark@oss.qualcomm.com, hanguidong02@gmail.com, quic_c_gdjako@quicinc.com, 
	dmitry.baryshkov@oss.qualcomm.com, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: do not register driver in probe()
Message-ID: <h2jbtahw5zcrn3rckul6ixesdvqpcdboz6daselk6cpnxosrii@ui45pvdammup>
References: <20260121141215.29658-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121141215.29658-1-dakr@kernel.org>

On Wed, Jan 21, 2026 at 03:12:01PM +0100, Danilo Krummrich wrote:
> Commit 0b4eeee2876f ("iommu/arm-smmu-qcom: Register the TBU driver in
> qcom_smmu_impl_init") intended to also probe the TBU driver when
> CONFIG_ARM_SMMU_QCOM_DEBUG is disabled, but also moved the corresponding
> platform_driver_register() call into qcom_smmu_impl_init() which is
> called from arm_smmu_device_probe().
> 
> However, it neither makes sense to register drivers from probe()
> callbacks of other drivers, nor does the driver core allow registering
> drivers with a device lock already being held.
> 
> The latter was revealed by commit dc23806a7c47 ("driver core: enforce
> device_lock for driver_match_device()") leading to a deadlock condition
> described in [1].
> 
> Additionally, it was noted by Robin that the current approach is
> potentially racy with async probe [2].
> 
> Hence, fix this by registering the qcom_smmu_tbu_driver from
> module_init(). Unfortunately, due to the vendoring of the driver, this
> requires an indirection through arm-smmu-impl.c.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/lkml/7ae38e31-ef31-43ad-9106-7c76ea0e8596@sirena.org.uk/
> Link: https://lore.kernel.org/lkml/DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org/ [1]
> Link: https://lore.kernel.org/lkml/0c0d3707-9ea5-44f9-88a1-a65c62e3df8d@arm.com/ [2]
> Fixes: dc23806a7c47 ("driver core: enforce device_lock for driver_match_device()")
> Fixes: 0b4eeee2876f ("iommu/arm-smmu-qcom: Register the TBU driver in qcom_smmu_impl_init")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Thank you Danilo.

Tested-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 14 +++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 14 +++++++++----
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 24 +++++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 +++++
>  4 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index db9b9a8e139c..4565a58bb213 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -228,3 +228,17 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  
>  	return smmu;
>  }
> +
> +int __init arm_smmu_impl_module_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM))
> +		return qcom_smmu_module_init();
> +
> +	return 0;
> +}
> +
> +void __exit arm_smmu_impl_module_exit(void)
> +{
> +	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM))
> +		qcom_smmu_module_exit();
> +}
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 573085349df3..22906d2c9a2d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -774,10 +774,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
>  	const struct device_node *np = smmu->dev->of_node;
>  	const struct of_device_id *match;
> -	static u8 tbu_registered;
> -
> -	if (!tbu_registered++)
> -		platform_driver_register(&qcom_smmu_tbu_driver);
>  
>  #ifdef CONFIG_ACPI
>  	if (np == NULL) {
> @@ -802,3 +798,13 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  
>  	return smmu;
>  }
> +
> +int __init qcom_smmu_module_init(void)
> +{
> +	return platform_driver_register(&qcom_smmu_tbu_driver);
> +}
> +
> +void __exit qcom_smmu_module_exit(void)
> +{
> +	platform_driver_unregister(&qcom_smmu_tbu_driver);
> +}
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 5e690cf85ec9..1e218fbea35a 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2365,7 +2365,29 @@ static struct platform_driver arm_smmu_driver = {
>  	.remove = arm_smmu_device_remove,
>  	.shutdown = arm_smmu_device_shutdown,
>  };
> -module_platform_driver(arm_smmu_driver);
> +
> +static int __init arm_smmu_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&arm_smmu_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = arm_smmu_impl_module_init();
> +	if (ret)
> +		platform_driver_unregister(&arm_smmu_driver);
> +
> +	return ret;
> +}
> +module_init(arm_smmu_init);
> +
> +static void __exit arm_smmu_exit(void)
> +{
> +	arm_smmu_impl_module_exit();
> +	platform_driver_unregister(&arm_smmu_driver);
> +}
> +module_exit(arm_smmu_exit);
>  
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>  MODULE_AUTHOR("Will Deacon <will@kernel.org>");
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 2dbf3243b5ad..26d2e33cd328 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -540,6 +540,11 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
>  struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
>  struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
>  
> +int __init arm_smmu_impl_module_init(void);
> +void __exit arm_smmu_impl_module_exit(void);
> +int __init qcom_smmu_module_init(void);
> +void __exit qcom_smmu_module_exit(void);
> +
>  void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
>  int arm_mmu500_reset(struct arm_smmu_device *smmu);
>  
> 
> base-commit: dc23806a7c47ec5f1293aba407fb69519f976ee0
> -- 
> 2.52.0
> 
> 
