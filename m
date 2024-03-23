Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858A1A38F4
	for <iommu@lists.linux.dev>; Sat, 23 Mar 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200034; cv=none; b=hoMf4510GRQFo60E5IOIHxFSlq2qojo2QtYTOwgElw9ah87ypEoTGjFdbVdE0ONMrR1P5UpPqT/J16hAjFQ+B55qK9dsSOSlB+poSr0RDDCrmyIZ2WVg4G5Rds15M8l25y9Di+dDCArrSwjlxedAYufsNrBwHsx6+/h8WFOmMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200034; c=relaxed/simple;
	bh=If5L4+J09fkclx46PdddIx3BxSe6ZCDMfw+j3u8/wkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjRRWSnk6di3oZnISUWFf1hNdy0g40DuMoBTB/67668qd6PKfXiQU8YA7DyPl7U33Ewcq2LQKHl896X0M2+y3TCdb5ftTqpvZvaiFYKshagVBWC1rbkbqa7AkBmei1xahc47dkWFFn+P6OiKDH2NGIIS5wCbTSyS+jYr1/yM4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUWvKby6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUWvKby6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4140eed8a4fso31615e9.0
        for <iommu@lists.linux.dev>; Sat, 23 Mar 2024 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711200031; x=1711804831; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfQtnxAwOWYfo0w6j630z7lwupN1BOC7EGLxCw7HttQ=;
        b=lUWvKby6jERyGqdQnpLjonQAhQC0z67kOrt0UrnBPIqctoHgOUfR/NDpJhVzaVq3KS
         6ZlKq3bp3TNtwZntN9UQGTkXUZap7h0JCZuRbxepgFgbvWBsJQZ9x8ZqB/CwEHTNZc1r
         gk2mRF40dFyszqaVoAr7mWS0pvQgioQ6CIoP/09JUlKvp6Ss/wWN9bCjWXncbFBn4SFs
         fRQ/QfJEXkr3Sm+09uPAiHXzFgjZOjzI+aGTo3gBwc4iXPosEiANBbFlzh5yFZAq9JSO
         n2Tx4CbH0V9EvLwX6s+CImRx8r4uZ+1DDf429GfSREBvueeHdVU+gKQcscvWRQ2qxw0B
         sz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711200031; x=1711804831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfQtnxAwOWYfo0w6j630z7lwupN1BOC7EGLxCw7HttQ=;
        b=men+MQxrc7uHGHQ1qFMjjF8Lk4JQdOz8zrN0eCVbeLhoXDQQe63gVab81BXMvo9gfS
         HGWZQZzRJI+j/MZ03iYG4F2sqOAY1yUfxXkSQTFIv7Vh+WmSbQvVATA3WAw0dpqSIzf5
         ct2vTefL/U1rI1ivovc8FMbImd5ZQtjgDwu9fD0N6d28M8Ws1+vkAGFdZ4mRNLJrBDyU
         9xJD3yQmmUphQ04DXg7KKpTtBxsjnWFzpk4lEQO3XGWdn8b3+VKP8pMFfsacFnySre9r
         y7HgHNTgNagi5HRAdZNiKqy+R1NUVDUcz5i8MBqzhWO2EyunGYDPvRWO3v5pLbXep4sx
         FN6g==
X-Gm-Message-State: AOJu0YwqUdkXV12VXAZVcmewbytjpzZjPc9+ty6R2zdJZbGazMIcM68R
	7njq2t/ZrIZ3aTV1yyZcnl5qgXCeV4NXjZryDjnm/94ujzJUqweghRCDthYEJQ==
X-Google-Smtp-Source: AGHT+IFLjq+OOC6HxABObw2+dsRnAVN5vFTiItAERR8JUOvvPuzRVIyifpVCOExX/b8eIUFeDkfEtQ==
X-Received: by 2002:a05:600c:1c8d:b0:414:800f:f992 with SMTP id k13-20020a05600c1c8d00b00414800ff992mr143664wms.2.1711200031343;
        Sat, 23 Mar 2024 06:20:31 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id q2-20020adfcd82000000b0033e7603987dsm4443672wrj.12.2024.03.23.06.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 06:20:30 -0700 (PDT)
Date: Sat, 23 Mar 2024 13:20:27 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v5 11/27] iommu/arm-smmu-v3: Build the whole CD in
 arm_smmu_make_s1_cd()
Message-ID: <Zf7XG_uI1jI4pvxp@google.com>
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <11-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>

Hi Jason,

On Mon, Mar 04, 2024 at 07:43:59PM -0400, Jason Gunthorpe wrote:
> Half the code was living in arm_smmu_domain_finalise_s1(), just move it
> here and take the values directly from the pgtbl_ops instead of storing
> copies.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 47 ++++++++-------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 --
>  2 files changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 50d17e3ce0a956..dfdd48cf217c4e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1301,15 +1301,25 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
>  			 struct arm_smmu_domain *smmu_domain)
>  {
>  	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
> +	const struct io_pgtable_cfg *pgtbl_cfg =
> +		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
> +	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =
> +		&pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  
>  	memset(target, 0, sizeof(*target));
>  
>  	target->data[0] = cpu_to_le64(
> -		cd->tcr |
> +		FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
> +		FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
> +		FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
> +		FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
> +		FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
> +		CTXDESC_CD_0_TCR_EPD1 |
>  #ifdef __BIG_ENDIAN
>  		CTXDESC_CD_0_ENDI |
>  #endif
>  		CTXDESC_CD_0_V |
> +		FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
>  		CTXDESC_CD_0_AA64 |
>  		(master->stall_enabled ? CTXDESC_CD_0_S : 0) |
>  		CTXDESC_CD_0_R |
> @@ -1317,9 +1327,9 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
>  		CTXDESC_CD_0_ASET |
>  		FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid)
>  		);
> -
> -	target->data[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
> -	target->data[3] = cpu_to_le64(cd->mair);
> +	target->data[1] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.ttbr &
> +				      CTXDESC_CD_1_TTB0_MASK);
> +	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.mair);
>  }
>  
>  void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
> @@ -2305,13 +2315,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  }
>  
>  static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
> -				       struct arm_smmu_domain *smmu_domain,
> -				       struct io_pgtable_cfg *pgtbl_cfg)
> +				       struct arm_smmu_domain *smmu_domain)
>  {
>  	int ret;
>  	u32 asid;
>  	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
> -	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  
>  	refcount_set(&cd->refs, 1);
>  
> @@ -2319,31 +2327,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
>  	mutex_lock(&arm_smmu_asid_lock);
>  	ret = xa_alloc(&arm_smmu_asid_xa, &asid, cd,
>  		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
> -	if (ret)
> -		goto out_unlock;
> -
>  	cd->asid	= (u16)asid;
> -	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> -	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
> -			  FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
> -			  FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
> -			  FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
> -			  FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
> -			  FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
> -			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
> -	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
> -
> -	mutex_unlock(&arm_smmu_asid_lock);
> -	return 0;
> -
> -out_unlock:
>  	mutex_unlock(&arm_smmu_asid_lock);
>  	return ret;
>  }
>  
>  static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
> -				       struct arm_smmu_domain *smmu_domain,
> -				       struct io_pgtable_cfg *pgtbl_cfg)
> +				       struct arm_smmu_domain *smmu_domain)
>  {
>  	int vmid;
>  	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
> @@ -2367,8 +2357,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  	struct io_pgtable_cfg pgtbl_cfg;
>  	struct io_pgtable_ops *pgtbl_ops;
>  	int (*finalise_stage_fn)(struct arm_smmu_device *smmu,
> -				 struct arm_smmu_domain *smmu_domain,
> -				 struct io_pgtable_cfg *pgtbl_cfg);
> +				 struct arm_smmu_domain *smmu_domain);
>  
>  	/* Restrict the stage to what we can actually support */
>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
> @@ -2411,7 +2400,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
>  	smmu_domain->domain.geometry.force_aperture = true;
>  
> -	ret = finalise_stage_fn(smmu, smmu_domain, &pgtbl_cfg);
> +	ret = finalise_stage_fn(smmu, smmu_domain);
>  	if (ret < 0) {
>  		free_io_pgtable_ops(pgtbl_ops);
>  		return ret;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8eabcccb9420ba..468cd33b80ac35 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -587,9 +587,6 @@ struct arm_smmu_strtab_l1_desc {
>  
>  struct arm_smmu_ctx_desc {
>  	u16				asid;
> -	u64				ttbr;
> -	u64				tcr;
> -	u64				mair;
>  
>  	refcount_t			refs;
>  	struct mm_struct		*mm;
> -- 
> 2.43.2
>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa
