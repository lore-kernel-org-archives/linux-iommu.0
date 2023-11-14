Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A941232
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso2777406fac.0
        for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 07:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699975089; x=1700579889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CiYZOT0ewHfs0j150rypc6HVEddSdF4ZubZ8pkDprA=;
        b=EoU94Zzm5xFzzHIHIOZ18GZWEM284djTIBKgtACtkkZiU6fzm9vREDjtbhYxzM6b/y
         KZJfdfn2UYYB41lbkXvX2m38bNzMEj+r4B+TqAeBoLfWADKWj/fmf7NwlcwSDEGj549W
         8SkW6zWggF2Og2rLnOr1T3lUng9aoQkBC5dPHW+KFrrnRLp/rCn8+vHAq0Z/IZa6hhVl
         fTvkv602vHTNNzmHEaHshoXGWr19ZowEPM2pOI8aAdDycijXFJCwCyQ4+YohgG/n1Ktv
         /6IDNBeZxDkTw2/SVdF50Mifs9nrt1aVL2m7uoTjU6WDOL1pSfsfts9ZKcDfNhFevc1P
         PCpA==
X-Gm-Message-State: AOJu0Yw/wTVHKQfLHGZc0uYtgZ50omjO4F5FeS6pqUvkx9EEk7UaIDwT
	3sFsAoQdI5akMASeLQ+xq0U=
X-Google-Smtp-Source: AGHT+IHFChdzmpFe6VrlAomWf//2t/+49QDYQP/zsLXbPO7/+vSLDdE2t38ElmuFVV6WFtvw6v2oKg==
X-Received: by 2002:a05:6870:3293:b0:1e9:b29b:b145 with SMTP id q19-20020a056870329300b001e9b29bb145mr10335803oac.7.1699975088839;
        Tue, 14 Nov 2023 07:18:08 -0800 (PST)
Received: from localhost ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85491000000b00419ab6ffedasm2805617qtq.29.2023.11.14.07.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:18:08 -0800 (PST)
Date: Tue, 14 Nov 2023 07:18:06 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 03/19] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
Message-ID: <ZVOPri4bpBcM7Bum@archbook>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <3-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>

On Mon, Nov 13, 2023 at 01:53:10PM -0400, Jason Gunthorpe wrote:
> Currently this is exactly the same as ARM_SMMU_DOMAIN_S2, so just remove
> it. The ongoing work to add nesting support through iommufd will do
> something a little different.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9117e769a965e1..bf7218adbc2822 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1286,7 +1286,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			cd_table = &master->cd_table;
>  			break;
>  		case ARM_SMMU_DOMAIN_S2:
> -		case ARM_SMMU_DOMAIN_NESTED:
>  			s2_cfg = &smmu_domain->s2_cfg;
>  			break;
>  		default:
> @@ -2167,7 +2166,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>  		fmt = ARM_64_LPAE_S1;
>  		finalise_stage_fn = arm_smmu_domain_finalise_s1;
>  		break;
> -	case ARM_SMMU_DOMAIN_NESTED:
>  	case ARM_SMMU_DOMAIN_S2:
>  		ias = smmu->ias;
>  		oas = smmu->oas;
> @@ -2735,7 +2733,7 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
>  	if (smmu_domain->smmu)
>  		ret = -EPERM;
>  	else
> -		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
> +		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
>  	mutex_unlock(&smmu_domain->init_mutex);
>  
>  	return ret;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 03f9e526cbd92f..27ddf1acd12cea 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -715,7 +715,6 @@ struct arm_smmu_master {
>  enum arm_smmu_domain_stage {
>  	ARM_SMMU_DOMAIN_S1 = 0,
>  	ARM_SMMU_DOMAIN_S2,
> -	ARM_SMMU_DOMAIN_NESTED,
>  	ARM_SMMU_DOMAIN_BYPASS,
>  };
>  
> -- 
> 2.42.0
> 
