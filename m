Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A54174E
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b4145e887bso3209469b6e.3
        for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 07:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699975471; x=1700580271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pEJtTjQ92iWXYQimS9Z8IOa0koTvQAG8NahE3En98Y=;
        b=Ndelc0XRWUpwiVaxiQsB5g86kzAEHQmSTfMN1HfjupjNjksvzSVlxRGLZOaVhC8QTe
         S0cVK5+XpFW2HoTTaGP6dg8GlYgiy3FTA++pk1/oT192Vw6xrxjSRZtzPrullvvHuAQx
         imnz7v3r0JooR0zuyJDPN69bRUfZ06OnTyWoK/+sQqsMRk/jyOWBcvOVHrordq7jfO55
         aJoSM0f+1cACuF2ialvAysel8a7IVNYocTjGcyzIBeJVp68rEPLqu/2YrtJLJjkn0Uig
         lLPK63pHa1hAsRaT3WOYbjxE08MzweCu9vG7NLzay/5jROUIlsWI8e2PcQHqZ4jlBYkC
         BPkg==
X-Gm-Message-State: AOJu0YwEBGUC3cW/lELx9qQPs3fIO0H3BXQAt9yodsZETp27gMv6i7Nq
	vAA0cwoz4q2Gw89LqtdHILj3U1ejCx0=
X-Google-Smtp-Source: AGHT+IFqK/0dumTatiPU+3EfpbujhEQ1qY0WalzRWhXRLoCMYfPIbwNxQaOhTP24T1XKI5yFZap48Q==
X-Received: by 2002:aca:d02:0:b0:3ae:511e:179e with SMTP id 2-20020aca0d02000000b003ae511e179emr11061178oin.54.1699975470632;
        Tue, 14 Nov 2023 07:24:30 -0800 (PST)
Received: from localhost ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85491000000b00419ab6ffedasm2810249qtq.29.2023.11.14.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:24:30 -0800 (PST)
Date: Tue, 14 Nov 2023 07:24:28 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 07/19] iommu/arm-smmu-v3: Move the STE generation for
 S1 and S2 domains into functions
Message-ID: <ZVORLFEWlmXSqOiH@archbook>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <7-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>

On Mon, Nov 13, 2023 at 01:53:14PM -0400, Jason Gunthorpe wrote:
> This is preparation to move the STE calculation higher up in to the call
> chain and remove arm_smmu_write_strtab_ent(). These new functions will be
> called directly from attach_dev.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 115 +++++++++++---------
>  1 file changed, 63 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 3fc8787db2dbc1..1c63fdebbda9d4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1463,13 +1463,70 @@ static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
>  		FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
>  }
>  
> +static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
> +				      struct arm_smmu_master *master,
> +				      struct arm_smmu_ctx_desc_cfg *cd_table)
> +{
> +	struct arm_smmu_device *smmu = master->smmu;
> +
> +	memset(target, 0, sizeof(*target));
> +	target->data[0] = cpu_to_le64(
> +		STRTAB_STE_0_V |
> +		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> +		FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt) |
> +		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> +		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
> +
> +	target->data[1] = cpu_to_le64(
> +		FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
> +		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> +		FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> +		FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
> +		((smmu->features & ARM_SMMU_FEAT_STALLS &&
> +		  !master->stall_enabled) ?
> +			 STRTAB_STE_1_S1STALLD :
> +			 0) |
> +		FIELD_PREP(STRTAB_STE_1_EATS,
> +			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
> +		FIELD_PREP(STRTAB_STE_1_STRW,
> +			   (smmu->features & ARM_SMMU_FEAT_E2H) ?
> +				   STRTAB_STE_1_STRW_EL2 :
> +				   STRTAB_STE_1_STRW_NSEL1));
> +}
> +
> +static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> +					struct arm_smmu_master *master,
> +					struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
> +
> +	memset(target, 0, sizeof(*target));
> +
> +	target->data[0] = cpu_to_le64(
> +		STRTAB_STE_0_V |
> +		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS));
> +
> +	target->data[1] |= cpu_to_le64(
> +		FIELD_PREP(STRTAB_STE_1_EATS,
> +			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
> +
> +	target->data[2] = cpu_to_le64(
> +		FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
> +		FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
> +		STRTAB_STE_2_S2AA64 |
> +#ifdef __BIG_ENDIAN
> +		STRTAB_STE_2_S2ENDI |
> +#endif
> +		STRTAB_STE_2_S2PTW |
> +		STRTAB_STE_2_S2R);
> +
> +	target->data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
> +}
> +
>  static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  				      struct arm_smmu_ste *dst)
>  {
> -	u64 val;
>  	struct arm_smmu_device *smmu = master->smmu;
> -	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
> -	struct arm_smmu_s2_cfg *s2_cfg = NULL;
>  	struct arm_smmu_domain *smmu_domain = master->domain;
>  	struct arm_smmu_ste target = {};
>  
> @@ -1484,61 +1541,15 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  
>  	switch (smmu_domain->stage) {
>  	case ARM_SMMU_DOMAIN_S1:
> -		cd_table = &master->cd_table;
> +		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
>  		break;
>  	case ARM_SMMU_DOMAIN_S2:
> -		s2_cfg = &smmu_domain->s2_cfg;
> +		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
>  		break;
>  	case ARM_SMMU_DOMAIN_BYPASS:
>  		arm_smmu_make_bypass_ste(&target);
> -		arm_smmu_write_ste(smmu, sid, dst, &target);
> -		return;
> +		break;
>  	}
> -
> -	/* Nuke the existing STE_0 value, as we're going to rewrite it */
> -	val = STRTAB_STE_0_V;
> -
> -	if (cd_table) {
> -		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
> -			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
> -
> -		target.data[1] = cpu_to_le64(
> -			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
> -			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> -			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> -			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
> -			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
> -
> -		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
> -		    !master->stall_enabled)
> -			target.data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
> -
> -		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> -			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> -			FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax) |
> -			FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
> -	}
> -
> -	if (s2_cfg) {
> -		target.data[2] = cpu_to_le64(
> -			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
> -			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
> -#ifdef __BIG_ENDIAN
> -			 STRTAB_STE_2_S2ENDI |
> -#endif
> -			 STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
> -			 STRTAB_STE_2_S2R);
> -
> -		target.data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
> -
> -		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
> -	}
> -
> -	if (master->ats_enabled)
> -		target.data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
> -						 STRTAB_STE_1_EATS_TRANS));
> -
> -	target.data[0] = cpu_to_le64(val);
>  	arm_smmu_write_ste(smmu, sid, dst, &target);
>  }
>  
> -- 
> 2.42.0
> 
