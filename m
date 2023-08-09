Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B87612D
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 13:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E572C433C8;
	Wed,  9 Aug 2023 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691589005;
	bh=Vfzf3DcTQNARPIgieTdLo0FAmtPjuxVwHbX9fj9y1UI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAgIavLaAKCZSAOHzytGHHIp2PZc4sqkDzxhiubWoGPybVffCRNJ92r5bt18raD+l
	 WQ2fTGwdrUy8SuMe/vn95QhqhJNBfg7DMDVzpubuFhhgXtQm+OUv65ywezyA3mye1X
	 wbUBkLH/V7L6rQSqZEZa+mj/6ys8AZlO8F+DwQjlpLlNaX4QUxc/rGg3ZbouF5l7lj
	 7ZYZ5wo5yKaHVfTQIoKYfjUi60Ca43tAisXibrGNrrL/lIMoByxsEonJXjavCyQpEA
	 8gSoCn01Qr4aPzssj6LWW1o7KzD5BVHArlcpPoECSUnVduYLw6oZL1yboMH8xl08FG
	 g/a3wPquAJVYg==
Date: Wed, 9 Aug 2023 14:50:00 +0100
From: Will Deacon <will@kernel.org>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <20230809134959.GB4226@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 09, 2023 at 01:12:01AM +0800, Michael Shavit wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 968559d625c40..e3992a0c16377 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -37,6 +37,24 @@ struct arm_smmu_bond {
>  
>  static DEFINE_MUTEX(sva_lock);
>  
> +static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
> +					    int ssid,
> +					    struct arm_smmu_ctx_desc *cd)
> +{
> +	struct arm_smmu_master *master;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +		ret = arm_smmu_write_ctx_desc(master, ssid, cd);
> +		if (ret)
> +			break;
> +	}
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +	return ret;
> +}
> +
>  /*
>   * Check if the CPU ASID is available on the SMMU side. If a private context
>   * descriptor is using it, try to replace it.
> @@ -80,7 +98,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  	 * be some overlap between use of both ASIDs, until we invalidate the
>  	 * TLB.
>  	 */
> -	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
> +	arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
>  
>  	/* Invalidate TLB entries previously associated with that context */
>  	arm_smmu_tlb_inv_asid(smmu, asid);
> @@ -222,7 +240,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
>  	 * but disable translation.
>  	 */
> -	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
> +	arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
>  
>  	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
>  	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
> @@ -279,9 +297,11 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
>  		goto err_free_cd;
>  	}
>  
> -	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> -	if (ret)
> +	ret = arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, cd);
> +	if (ret) {
> +		arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, NULL);

Why is it safe to drop the lock between these two calls?

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index c01023404c26c..34bd7815aeb8e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -971,14 +971,12 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
>  	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  }
>  
> -static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
> +static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>  			     int ssid, bool leaf)
>  {
>  	size_t i;
> -	unsigned long flags;
> -	struct arm_smmu_master *master;
>  	struct arm_smmu_cmdq_batch cmds;
> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_device *smmu = master->smmu;
>  	struct arm_smmu_cmdq_ent cmd = {
>  		.opcode	= CMDQ_OP_CFGI_CD,
>  		.cfgi	= {
> @@ -988,15 +986,10 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
>  	};
>  
>  	cmds.num = 0;
> -
> -	spin_lock_irqsave(&smmu_domain->devices_lock, flags);

Since you're dropping this and relying on the lock being taken higher up
callstack, can we add a lockdep assertion that we do actually hold the
devices_lock, please?

Will
