Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9681EB9E3;
	Tue, 11 Mar 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709624; cv=none; b=prZZsj+bJD45RIJ602aBdjscLs0JxW3Qw23bnkzxvTMbOqQZLldX9PUqTOzhaoIr82vDkiz6OhbBkt3hcLNGZnQS+tV8EkRBfHhSAX4WbMyIxCdJ7xvtIrbjND46H5rX5LGVGhC6yX9ItKUoNhyCzahf0shl1M/tqBtNUdLSGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709624; c=relaxed/simple;
	bh=Q72aDixIkaux456M7FZBKvpgHRVOfglTKc9SKUy0GkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG4+caQpsDi/uHmpk2nLtYHV/c7NkPncnZL5sFroYjsw90ypMyHACAjJzAc394P3GxAOibEQ9161nn1AwM7/B0zzxKjeVgUe/HVdUyGV5ME4kvlFS7doLx/ZtLSdR+j36LxkI3rVh4pOtLPN7xV+MxJw/QGToz/eBNV1zRwUQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub0Og0TP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub0Og0TP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D00C4CEE9;
	Tue, 11 Mar 2025 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709624;
	bh=Q72aDixIkaux456M7FZBKvpgHRVOfglTKc9SKUy0GkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ub0Og0TPVcpoP7rNq+fKRAsbnps8GFpaAAmIp1FHpKsPO07iwVHp5pZew2lRHcaAZ
	 WKSGAeQLOTNuX3/fQAAdfsiZdHl7ejsEprfdociAmDDyLTjA7bMGp8bNdMxuaHdD9L
	 ABn9UQhqR9dnhNw7WWce7CbGSQOzu8GNRxdxnJTPGyY0UjfYccCT5MlehahNPoYSTz
	 UxNmJQ8H16OLIRGWyV5zg+t4MsOdgeFSV0Yry4ysyiMkjhPr9JxJ6Er4CnUeoxBb5C
	 qCcXnUNzZsf1r2OMW7LEx/P5r1+Mqotb8z7KaB5vZGIB3BobqhlRjK3kSkWTBSYoXA
	 o+E7CSYV4VJog==
Date: Tue, 11 Mar 2025 16:13:38 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 01/12] iommu/arm-smmu-v3: Put iopf enablement in the
 domain attach path
Message-ID: <20250311161337.GD5138@willie-the-truck>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
 <20250228092631.3425464-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228092631.3425464-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 28, 2025 at 05:26:20PM +0800, Lu Baolu wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> SMMUv3 co-mingles FEAT_IOPF and FEAT_SVA behaviors so that fault reporting
> doesn't work unless both are enabled. This is not correct and causes
> problems for iommufd which does not enable FEAT_SVA for it's fault capable
> domains.
> 
> These APIs are both obsolete, update SMMUv3 to use the new method like AMD
> implements.
> 
> A driver should enable iopf support when a domain with an iopf_handler is
> attached, and disable iopf support when the domain is removed.
> 
> Move the fault support logic to sva domain allocation and to domain
> attach, refusing to create or attach fault capable domains if the HW
> doesn't support it.
> 
> Move all the logic for controlling the iopf queue under
> arm_smmu_attach_prepare(). Keep track of the number of domains on the
> master (over all the SSIDs) that require iopf. When the first domain
> requiring iopf is attached create the iopf queue, when the last domain is
> detached destroy it.
> 
> Turn FEAT_IOPF and FEAT_SVA into no ops.
> 
> Remove the sva_lock, this is all protected by the group mutex.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  86 +-------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 105 +++++++++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  39 ++-----
>  3 files changed, 91 insertions(+), 139 deletions(-)

[...]

> @@ -2748,6 +2750,54 @@ to_smmu_domain_devices(struct iommu_domain *domain)
>  	return NULL;
>  }
>  
> +static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
> +				struct arm_smmu_master_domain *master_domain)
> +{
> +	int ret;
> +
> +	iommu_group_mutex_assert(master->dev);
> +
> +	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Drivers for devices supporting PRI or stall require iopf others have
> +	 * device-specific fault handlers and don't need IOPF, so this is not a
> +	 * failure.
> +	 */
> +	if (!master->stall_enabled)
> +		return 0;
> +
> +	/* We're not keeping track of SIDs in fault events */
> +	if (master->num_streams != 1)
> +		return -EOPNOTSUPP;
> +
> +	if (master->iopf_refcount) {
> +		master->iopf_refcount++;
> +		master_domain->using_iopf = true;
> +		return 0;
> +	}
> +
> +	ret = iopf_queue_add_device(master->smmu->evtq.iopf, master->dev);
> +	if (ret)
> +		return ret;
> +	master->iopf_refcount = 1;
> +	master_domain->using_iopf = true;
> +	return 0;
> +}
> +
> +static void arm_smmu_disable_iopf(struct arm_smmu_master *master)
> +{
> +	iommu_group_mutex_assert(master->dev);
> +
> +	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
> +		return;

I think it would be a little cleaner to push the '->using_iopf' check
in here rather than have the callers check it. Then the SVA check above
makes more sense and I think the enable/disable paths are a bit more
symmetric.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
