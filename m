Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0A3588F
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cT9G3xcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701101024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvqaglNtu4K9nheWWeKuAYfg79wzEjLTYDWq+jeP1xI=;
	b=cT9G3xcrzojAtgGBolR6uBV4aciTiMfOTirT2hOMpLxvEe9zu0oRc8o7bO7pn7UJHzmLGA
	l1vAPQSiecrZfH/XpHMBN8E6gHv7rtmExBVa72LJ7L+T1qYPL7NQyxrJaKQVwZh+20OpLN
	2atVdwrwsAJRQkHw2E7nxjAnjCj1Qwg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-cdR_tFBiOqmjhx1WNV9VdQ-1; Mon, 27 Nov 2023 11:03:42 -0500
X-MC-Unique: cdR_tFBiOqmjhx1WNV9VdQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b29868c6eso25810475e9.3
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 08:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101020; x=1701705820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvqaglNtu4K9nheWWeKuAYfg79wzEjLTYDWq+jeP1xI=;
        b=wfM9EUPGU+OM7nz4jr9jMtT7OW1gbEWe/hCXN/yf2USMqmFJi57pQKj7bdKQB8v6Pe
         aXl6zDPdkLBrVZPBB67Tik4C5NtXq6YiTHUlPZfMgjnMBd6G6TIkanVkIXgivYbqKAi4
         rCy4b4LIBTM5Apw+BShjhKGMxcyVLiXdpl0cgrA86BSXwLsbL9XpnqLBzjgj8M0HrMWU
         5SuudhzmCqwlyIYgd9wPaTEhwzt8GrWBXDijP0ZpXvhopkyqdQnOO4ZU24tQ617gBFEi
         TDmyVQfALpaYDfuhvVcC7bRMecdUX5rYg5EwZDDKmhKg/I4mRvyIlZpoy09C2GDP023O
         0ZZQ==
X-Gm-Message-State: AOJu0YwVrZYe+vyA1Ep4AK+cFQSOI10IMQ90T0M7GIchUlF5OF+1DG8y
	HTyS0iyTeiiZfxPNyT6Ze3QJf0+mJxAzcdnulKR7eDd1g22cpW27jtO5nMDc/knPhrC4FLAfVYi
	mn/1tbivED9S/CmE=
X-Received: by 2002:a05:600c:3110:b0:404:7670:90b8 with SMTP id g16-20020a05600c311000b00404767090b8mr9289214wmo.27.1701101019603;
        Mon, 27 Nov 2023 08:03:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9sNQX3EZc4oex7nnBKWO0b66qfaHUEyT4GOPK3Wtl4CXNMUuRHlyLLfD+Uf8SuMJp8JzsBQ==
X-Received: by 2002:a05:600c:3110:b0:404:7670:90b8 with SMTP id g16-20020a05600c311000b00404767090b8mr9289157wmo.27.1701101019014;
        Mon, 27 Nov 2023 08:03:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id je4-20020a05600c1f8400b00407460234f9sm14438897wmb.21.2023.11.27.08.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 08:03:38 -0800 (PST)
Message-ID: <0a2a9fb5-0506-4a46-9c93-3c4001d0b966@redhat.com>
Date: Mon, 27 Nov 2023 17:03:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] iommu/arm-smmu-v3: Add a type for the STE
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/13/23 18:53, Jason Gunthorpe wrote:
> Instead of passing a naked __le16 * around to represent a STE wrap it in a
> "struct arm_smmu_ste" with an array of the correct size. This makes it
> much clearer which functions will comprise the "STE API".
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
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
This looks less readable to me than it was before.
>  	} else {
>  		/* Simple linear lookup */
> -		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
> +		return (struct arm_smmu_ste *)&cfg
> +			       ->strtab[sid * STRTAB_STE_DWORDS];

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


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

