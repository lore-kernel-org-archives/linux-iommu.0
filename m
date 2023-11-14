Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221B41215
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-421ae930545so29168741cf.0
        for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 07:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699974419; x=1700579219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49/TSl5BXl9feikMu/ppPQBOvFNvogUkUSumbRICJ2o=;
        b=Tn4jLb9VArwxXVFYK2S/gv6xL7AcqWfHVXPCduBzxL659/bl4HQ4Lwim7lYfHTjrVb
         acMAvplfGukuu3gqC6XS7XeiqXiu8x0Nx5aghYEgD7eg5QceXcXY1RKJTkWQK3nzbA01
         Gc3jymwtgCLelenaFwV/jRj53nTHp6Nro0Zfu6tl48Zj/uKFrbqv1CJj2a2s17DuYGYC
         9phl/5s8y3ILX+rYY2OtC15AAlxF6qDMYHTdU1wYrTSvyxFoYiUuul5vkDqHtuBObPlv
         L5UJOo7iw87b+dVvg+vnpQ6qjyEChLURHfzQ54+bXcrNL4RjcBB3FSSASQ4PSSRUd+by
         +CCA==
X-Gm-Message-State: AOJu0YyTGoKQ/S1V4/qVAdvDPRFrRd1M3ZVkdPGgVdtHJ6sQwV7nZhWc
	XQQJ79MybDCSM5ttGXEHQH0=
X-Google-Smtp-Source: AGHT+IHOkQA7trkMJ7osbvsrLTv4JQlJkC28SW8kMNbAujGoVg3fogDciqoZALdU1M62vb9S1XSH3g==
X-Received: by 2002:ac8:7f4c:0:b0:421:b186:d2a9 with SMTP id g12-20020ac87f4c000000b00421b186d2a9mr2903649qtk.13.1699974419422;
        Tue, 14 Nov 2023 07:06:59 -0800 (PST)
Received: from localhost ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id ka2-20020a05622a440200b0041b7f007546sm2777271qtb.82.2023.11.14.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:06:59 -0800 (PST)
Date: Tue, 14 Nov 2023 07:06:57 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 01/19] iommu/arm-smmu-v3: Add a type for the STE
Message-ID: <ZVONEV2wtAMQp3-Q@archbook>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>

On Mon, Nov 13, 2023 at 01:53:08PM -0400, Jason Gunthorpe wrote:
> Instead of passing a naked __le16 * around to represent a STE wrap it in a
> "struct arm_smmu_ste" with an array of the correct size. This makes it
> much clearer which functions will comprise the "STE API".
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 54 ++++++++++-----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 ++-
>  2 files changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7445454c2af244..519749d15fbda0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1249,7 +1249,7 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
>  }
>  
>  static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> -				      __le64 *dst)
> +				      struct arm_smmu_ste *dst)
>  {
>  	/*
>  	 * This is hideously complicated, but we only really care about
> @@ -1267,7 +1267,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  	 * 2. Write everything apart from dword 0, sync, write dword 0, sync
>  	 * 3. Update Config, sync
>  	 */
> -	u64 val = le64_to_cpu(dst[0]);
> +	u64 val = le64_to_cpu(dst->data[0]);
>  	bool ste_live = false;
>  	struct arm_smmu_device *smmu = NULL;
>  	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
> @@ -1325,10 +1325,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  		else
>  			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
>  
> -		dst[0] = cpu_to_le64(val);
> -		dst[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
> +		dst->data[0] = cpu_to_le64(val);
> +		dst->data[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
>  						STRTAB_STE_1_SHCFG_INCOMING));
> -		dst[2] = 0; /* Nuke the VMID */
> +		dst->data[2] = 0; /* Nuke the VMID */
>  		/*
>  		 * The SMMU can perform negative caching, so we must sync
>  		 * the STE regardless of whether the old value was live.
> @@ -1343,7 +1343,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
>  
>  		BUG_ON(ste_live);
> -		dst[1] = cpu_to_le64(
> +		dst->data[1] = cpu_to_le64(
>  			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
>  			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
>  			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> @@ -1352,7 +1352,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  
>  		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
>  		    !master->stall_enabled)
> -			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
> +			dst->data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>  
>  		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
>  			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> @@ -1362,7 +1362,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  
>  	if (s2_cfg) {
>  		BUG_ON(ste_live);
> -		dst[2] = cpu_to_le64(
> +		dst->data[2] = cpu_to_le64(
>  			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
>  			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
>  #ifdef __BIG_ENDIAN
> @@ -1371,18 +1371,18 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			 STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
>  			 STRTAB_STE_2_S2R);
>  
> -		dst[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
> +		dst->data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
>  
>  		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
>  	}
>  
>  	if (master->ats_enabled)
> -		dst[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
> +		dst->data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
>  						 STRTAB_STE_1_EATS_TRANS));
>  
>  	arm_smmu_sync_ste_for_sid(smmu, sid);
>  	/* See comment in arm_smmu_write_ctx_desc() */
> -	WRITE_ONCE(dst[0], cpu_to_le64(val));
> +	WRITE_ONCE(dst->data[0], cpu_to_le64(val));
>  	arm_smmu_sync_ste_for_sid(smmu, sid);
>  
>  	/* It's likely that we'll want to use the new STE soon */
> @@ -1390,7 +1390,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
>  }
>  
> -static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent, bool force)
> +static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
> +				      unsigned int nent, bool force)
>  {
>  	unsigned int i;
>  	u64 val = STRTAB_STE_0_V;
> @@ -1401,11 +1402,11 @@ static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent, bool fo
>  		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
>  
>  	for (i = 0; i < nent; ++i) {
> -		strtab[0] = cpu_to_le64(val);
> -		strtab[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
> -						   STRTAB_STE_1_SHCFG_INCOMING));
> -		strtab[2] = 0;
> -		strtab += STRTAB_STE_DWORDS;
> +		strtab->data[0] = cpu_to_le64(val);
> +		strtab->data[1] = cpu_to_le64(FIELD_PREP(
> +			STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
> +		strtab->data[2] = 0;
> +		strtab++;
>  	}
>  }
>  
> @@ -2209,26 +2210,22 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>  	return 0;
>  }
>  
> -static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> +static struct arm_smmu_ste *
> +arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
>  {
> -	__le64 *step;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>  
>  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> -		struct arm_smmu_strtab_l1_desc *l1_desc;
>  		int idx;
>  
>  		/* Two-level walk */
>  		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
> -		l1_desc = &cfg->l1_desc[idx];
> -		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
> -		step = &l1_desc->l2ptr[idx];
> +		return &cfg->l1_desc[idx].l2ptr[sid & ((1 << STRTAB_SPLIT) - 1)];
>  	} else {
>  		/* Simple linear lookup */
> -		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
> +		return (struct arm_smmu_ste *)&cfg
> +			       ->strtab[sid * STRTAB_STE_DWORDS];
>  	}
> -
> -	return step;
>  }
>  
>  static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
> @@ -2238,7 +2235,8 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
>  
>  	for (i = 0; i < master->num_streams; ++i) {
>  		u32 sid = master->streams[i].id;
> -		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
> +		struct arm_smmu_ste *step =
> +			arm_smmu_get_step_for_sid(smmu, sid);
>  
>  		/* Bridged PCI devices may end up with duplicated IDs */
>  		for (j = 0; j < i; j++)
> @@ -3769,7 +3767,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
>  	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
>  
>  	list_for_each_entry(e, &rmr_list, list) {
> -		__le64 *step;
> +		struct arm_smmu_ste *step;
>  		struct iommu_iort_rmr_data *rmr;
>  		int ret, i;
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 961205ba86d25d..03f9e526cbd92f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -206,6 +206,11 @@
>  #define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 6)
>  
>  #define STRTAB_STE_DWORDS		8
> +
> +struct arm_smmu_ste {
> +	__le64 data[STRTAB_STE_DWORDS];
> +};
> +
>  #define STRTAB_STE_0_V			(1UL << 0)
>  #define STRTAB_STE_0_CFG		GENMASK_ULL(3, 1)
>  #define STRTAB_STE_0_CFG_ABORT		0
> @@ -571,7 +576,7 @@ struct arm_smmu_priq {
>  struct arm_smmu_strtab_l1_desc {
>  	u8				span;
>  
> -	__le64				*l2ptr;
> +	struct arm_smmu_ste		*l2ptr;
>  	dma_addr_t			l2ptr_dma;
>  };
>  
> -- 
> 2.42.0
> 
