Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB892605C4
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129945; cv=none; b=m4sLXgypR9qecveGqgt7TgIN3yB/7XVgvTGYzksdsBKqI81P+F5LubWVzCCTLQYOzV65NUmLLT6SgUDwZPdR/hnGJtpAE+JxPim8daEQ9eMlT9BXFuHlsYk6AZhx+Zp8OZneCUO2gKs5A64it0Xb0DnPdVSkX5bsPz/Jp8bEues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129945; c=relaxed/simple;
	bh=2dco4Cp7gHDSJYMxBQIxVotRD/Rta+qI5bnqZqq5OTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thwxcI+Jlag2aBUbQ4DPSKPeQz02vTC8crwRGBJI80acH0P4+wqVnAk+vUU4VQgdhdq6iT5wyybWVdplDt0tB5gbyTyyE/nFdqrxMEWavfJtmzQBiGGEJ4LDrIEsfxMI7nxh/y/9DxbwEN0m/ptn7D4yKdOnyVQcikyi5Yk+Rqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1wLomNB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1wLomNB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4146f72e2dfso6935e9.1
        for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711129942; x=1711734742; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9oMrg7TwImkd0pYqNwG2LgH+fmS6/ZJ6R8JYrsRy8A=;
        b=Y1wLomNBdOH+nla0WPgpa8/v0pNoJ67DzQSjECl7ZlTIALJlJUgwf4ZZvFGhwMbWcT
         pHJ50zN/jhE0DE4EnOarJ/NwSufspXR5EfV3RsLcbl5TUQ7N7rw1BIVo+FrTT3YE8m5W
         sd0MinowFLKLCSh/DXe1lHA4IXdm7/aHOwiDV9VTQgWYB5S511Y4j4+Fw1Oo3E9OPJzQ
         6qFdhxl5pMGrEdrGgtfU0fN1bwD/XRKfpnDkiA2uYEVYAZEglTdxlVEYhD5ZxyQjzzvN
         lkeUuhv8vovZUzTlAvAowHqcT0itWnXkH5F8UVD1N/mQyC7Hs1DA84aD26suXThReOkg
         MZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711129942; x=1711734742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9oMrg7TwImkd0pYqNwG2LgH+fmS6/ZJ6R8JYrsRy8A=;
        b=UozS1f+qrWNam4Ovu1b4j0ukG0KLJDmuBlXVpbUBtKCD1dRUFAnqBqR56fiApdyREn
         t7ZLtI8lPObbqGF6b6gn7wMnBbCQaXhReV0u270jtFN+hrGRyCw66idf7tAc4bIFG4Lp
         4ndwR5OLLM1XqArMhjWqLVZJNuNY/0aUv6LJdhHTE2D7pekKnH0Em5Ubx2hsDmyr8Bmq
         J4tys1wOBUqLbBY3QNbexWsxYy2xnfKrAzTyVVBySl/xSxayO+1zNfrD/Kbt3l/fAKW1
         7Tb7T0JmmkgvW/YYyAilopbhQAYu/mQ00UPbq/ujfotTRe9or8EidmRs+aqVgBa8grE4
         RNdg==
X-Gm-Message-State: AOJu0YynaqVsRjoWaz7v3CDEcrzRpzGhC+FJpwJxIpdQhTzxDgXmLXur
	ABAPHvx3/pRyonwkarBE4HHfjH5doLZGxjB9YFRcPC8BfqWJQvxMnaaig9G3UiuQNeK8ZbhWTEf
	r2A==
X-Google-Smtp-Source: AGHT+IHjj0LOYPDRfLbOApiA9FqEKKJaqaDdBH5Vx421Ez+M6eX4Mh4lnvz3MgI9eUzeo+z4tILx6g==
X-Received: by 2002:a05:600c:4f47:b0:414:6467:3471 with SMTP id m7-20020a05600c4f4700b0041464673471mr501995wmq.1.1711129941796;
        Fri, 22 Mar 2024 10:52:21 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id t21-20020a05600c451500b004146e58cc35sm141612wmo.46.2024.03.22.10.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:52:21 -0700 (PDT)
Date: Fri, 22 Mar 2024 17:52:17 +0000
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
Subject: Re: [PATCH v5 03/27] iommu/arm-smmu-v3: Add a type for the CD entry
Message-ID: <Zf3FUestghRLc3XX@google.com>
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <3-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>

On Mon, Mar 04, 2024 at 07:43:51PM -0400, Jason Gunthorpe wrote:
> Instead of passing a naked __le16 * around to represent a CD table entry
> wrap it in a "struct arm_smmu_cd" with an array of the correct size. This
> makes it much clearer which functions will comprise the "CD API".
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 ++++++-
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9e9233331c4636..c60b067c1f553e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1219,7 +1219,8 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
>  	WRITE_ONCE(*dst, cpu_to_le64(val));
>  }
>  
> -static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
> +static struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
> +					       u32 ssid)
>  {
>  	__le64 *l1ptr;
>  	unsigned int idx;
> @@ -1228,7 +1229,8 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
>  	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
>  
>  	if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
> -		return cd_table->cdtab + ssid * CTXDESC_CD_DWORDS;
> +		return (struct arm_smmu_cd *)(cd_table->cdtab +
> +					      ssid * CTXDESC_CD_DWORDS);
>  
>  	idx = ssid >> CTXDESC_SPLIT;
>  	l1_desc = &cd_table->l1_desc[idx];
> @@ -1242,7 +1244,7 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
>  		arm_smmu_sync_cd(master, ssid, false);
>  	}
>  	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
> -	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
> +	return &l1_desc->l2ptr[idx];
>  }
>  
>  int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
> @@ -1261,7 +1263,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  	 */
>  	u64 val;
>  	bool cd_live;
> -	__le64 *cdptr;
> +	struct arm_smmu_cd *cdptr;
>  	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
>  	struct arm_smmu_device *smmu = master->smmu;
>  
> @@ -1272,7 +1274,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  	if (!cdptr)
>  		return -ENOMEM;
>  
> -	val = le64_to_cpu(cdptr[0]);
> +	val = le64_to_cpu(cdptr->data[0]);
>  	cd_live = !!(val & CTXDESC_CD_0_V);
>  
>  	if (!cd) { /* (5) */
> @@ -1289,9 +1291,9 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  		 * this substream's traffic
>  		 */
>  	} else { /* (1) and (2) */
> -		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
> -		cdptr[2] = 0;
> -		cdptr[3] = cpu_to_le64(cd->mair);
> +		cdptr->data[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
> +		cdptr->data[2] = 0;
> +		cdptr->data[3] = cpu_to_le64(cd->mair);
>  
>  		/*
>  		 * STE may be live, and the SMMU might read dwords of this CD in any
> @@ -1323,7 +1325,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  	 *   field within an aligned 64-bit span of a structure can be altered
>  	 *   without first making the structure invalid.
>  	 */
> -	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
> +	WRITE_ONCE(cdptr->data[0], cpu_to_le64(val));
>  	arm_smmu_sync_cd(master, ssid, true);
>  	return 0;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 23baf117e7e4b5..7078ed569fd4d3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -282,6 +282,11 @@ struct arm_smmu_ste {
>  #define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
>  
>  #define CTXDESC_CD_DWORDS		8
> +
> +struct arm_smmu_cd {
> +	__le64 data[CTXDESC_CD_DWORDS];
> +};
> +
>  #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
>  #define CTXDESC_CD_0_TCR_TG0		GENMASK_ULL(7, 6)
>  #define CTXDESC_CD_0_TCR_IRGN0		GENMASK_ULL(9, 8)
> @@ -591,7 +596,7 @@ struct arm_smmu_ctx_desc {
>  };
>  
>  struct arm_smmu_l1_ctx_desc {
> -	__le64				*l2ptr;
> +	struct arm_smmu_cd		*l2ptr;
>  	dma_addr_t			l2ptr_dma;
>  };
>  
> -- 
> 2.43.2
>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa
