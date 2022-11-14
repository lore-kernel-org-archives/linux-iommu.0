Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021679F8
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 18:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12482C433C1;
	Mon, 14 Nov 2022 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668449307;
	bh=6ggcnc4EObNXAZUMEIKulorxPo+p100CcZmu7UYGb10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EScOKEF44ljWX/gUv9/uotNv54Kv7ghtCDDZi1ZPDSO8XhstlO9EuqqwviqhrV0gw
	 MCUCIh68fnbB7WY0yxfxhJePGoCgXtnSfpODVHIUWsln6deXWrWaRAnvzcwY5UfMyf
	 kVYWwPkr0U+XPqTXfVdiSjvQQTBu00gj2J8Xt6G2j8HEjXBqN7gBgIP6DNF9JpFQy6
	 lEX8H0wv9N0z9byS7aZxEbZ654Q7KNvjis2rOeQJJfOAO7QbfL13Hq7wnRzK+EQVP7
	 lT7UgoMUdWSd6T5PND93GTDLTcsF+cPLCNa66v8rXrI+HjFm8eX+wpryPwgA2157R0
	 nvYDmVhkP2S3w==
Date: Mon, 14 Nov 2022 18:08:22 +0000
From: Will Deacon <will@kernel.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] iommu: fix smmu initialization memory leak problem
Message-ID: <20221114180821.GC31476@willie-the-truck>
References: <20221021035147.15292-1-liulongfang@huawei.com>
 <20221021035147.15292-3-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021035147.15292-3-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Oct 21, 2022 at 11:51:47AM +0800, Longfang Liu wrote:
> When iommu_device_register() in arm_smmu_device_probe() fails,
> in addition to sysfs needs to be deleted, device should also
> be disabled, and the memory of iopf needs to be released to
> prevent memory leak of iopf.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a1db07bed6a9..c70defb0c866 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3816,11 +3816,16 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>  	if (ret) {
>  		dev_err(dev, "Failed to register iommu\n");
> -		iommu_device_sysfs_remove(&smmu->iommu);
> -		return ret;
> +		goto err_sysfs_remove;
>  	}
>  
>  	return 0;
> +
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(&smmu->iommu);
> +	arm_smmu_device_disable(smmu);
> +	iopf_queue_free(smmu->evtq.iopf);
> +	return ret;

Doesn't this miss the cases where iommu_device_sysfs_add() or
arm_smmu_device_reset() fail?

We'd probably be better off using something like devres_alloc() to track
the iopf queue here.

Will
