Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DDC612D
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 13:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93292C433CA;
	Wed,  9 Aug 2023 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691589030;
	bh=Ttd/GCX5wRwkEEojWI8vGi9iFAE5AgRVud/qLF/aTj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQYhiZ4zfQt35rRYlT6nQITMz8qubxI0lUV2X7d2J8IqZIK2wyTROCAzjEhUStMI/
	 pVHNF8XaepzYEmib0IzCOq+uFKVNdeJcJeMdp8v4+cIyPkbRifzRLyT3hZjOidGWwu
	 uLyStbavPg+g5T7c64Ht6gvqjOE6sWW6MHnSy9IdtAYAKI3mYchHKsbKzeZfd8NdbB
	 Q62Xm02yu/2o1eWw6AL3ZEd5R2SWTyyk7AHZkXvmNXC7rkgyvukE4xwh00FBwsxKrX
	 iS2Xt1Osorq8s5Dccxiw32V/kIZy44eh0i1hOPIzQ9KfCfuEb0og7qrnI0dAHW/pfj
	 R2pyL9F/CDduA==
Date: Wed, 9 Aug 2023 14:50:25 +0100
From: Will Deacon <will@kernel.org>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 6/9] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <20230809135024.GD4226@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 09, 2023 at 01:12:02AM +0800, Michael Shavit wrote:
> @@ -2203,7 +2186,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>  		ias = min_t(unsigned long, ias, VA_BITS);
>  		oas = smmu->ias;
>  		fmt = ARM_64_LPAE_S1;
> -		finalise_stage_fn = arm_smmu_domain_finalise_s1;
> +		finalise_stage_fn = arm_smmu_domain_finalise_cd;

Why is this a better name? Now we have inconsistency with
arm_smmu_domain_finalise_s2().

>  		break;
>  	case ARM_SMMU_DOMAIN_NESTED:
>  	case ARM_SMMU_DOMAIN_S2:
> @@ -2402,6 +2385,16 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  	master->domain = NULL;
>  	master->ats_enabled = false;
>  	arm_smmu_install_ste_for_dev(master);
> +	/*
> +	 * The table is uninstalled before clearing the CD to prevent an
> +	 * unnecessary sync in arm_smmu_write_ctx_desc. Although clearing the
> +	 * CD entry isn't strictly required to detach the domain since the
> +	 * table is uninstalled anyway, it's more proper and helps avoid
> +	 * confusion in the call to arm_smmu_write_ctx_desc on the next attach

You can remove the "it's more proper" part.

> +	 * (which expects the entry to be empty).
> +	 */
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 && master->cd_table.cdtab)
> +		arm_smmu_write_ctx_desc(master, 0, NULL);
>  }
>  
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> @@ -2436,22 +2429,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	if (!smmu_domain->smmu) {
>  		smmu_domain->smmu = smmu;
>  		ret = arm_smmu_domain_finalise(domain, master);
> -		if (ret) {
> +		if (ret)
>  			smmu_domain->smmu = NULL;
> -			goto out_unlock;
> -		}
> -	} else if (smmu_domain->smmu != smmu) {
> -		ret = -EINVAL;
> -		goto out_unlock;
> -	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> -		   master->ssid_bits != smmu_domain->cd_table.max_cds_bits) {
> +	} else if (smmu_domain->smmu != smmu)
>  		ret = -EINVAL;
> -		goto out_unlock;
> -	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> -		   smmu_domain->cd_table.stall_enabled != master->stall_enabled) {
> -		ret = -EINVAL;
> -		goto out_unlock;
> -	}

Removing these checks on the domain is pretty nice.

> @@ -2465,6 +2450,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>  		master->ats_enabled = arm_smmu_ats_supported(master);
>  
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +		if (!master->cd_table.cdtab) {
> +			ret = arm_smmu_alloc_cd_tables(master);
> +			if (ret) {
> +				master->domain = NULL;
> +				return ret;
> +			}
> +		}
> +
> +		ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
> +		if (ret) {
> +			master->domain = NULL;
> +			return ret;

Can you leak the cd tables here if you just allocated them?

> @@ -2472,10 +2473,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
>  	arm_smmu_enable_ats(master);
> -
> -out_unlock:
> -	mutex_unlock(&smmu_domain->init_mutex);
> -	return ret;
> +	return 0;
>  }
>  
>  static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
> @@ -2719,6 +2717,8 @@ static void arm_smmu_release_device(struct device *dev)
>  	arm_smmu_detach_dev(master);
>  	arm_smmu_disable_pasid(master);
>  	arm_smmu_remove_master(master);
> +	if (master->cd_table.cdtab_dma)

Why are you checking 'cdtab_dma' here instead of just 'cdtab'?

Will
