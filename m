Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EE283138
	for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276781; cv=none; b=Ya3sxlxEKjHoSuFrgR0+jeK0Vnye8fTfGCExIoa1d5HLyHqIoCrdS0U7Jw9v4EqAvD/+pn0cT7RTb7rpADMlALqK7Z9lSekskC7H9TuIPrUgCqWLK/Fp1q32TUZFxYAcrq4YetlB3MwjHaFUW+fmmw4jLag6mPWv58I7qw/1tBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276781; c=relaxed/simple;
	bh=3wO7ofU7WlEoFNNaUev6B9+Jglx7cQTZpeu6LIwLyC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAQKbbgQlnfqhEirHDw8YWvBVYPDjK0/zAHWXDhJH0ZAD/dvpcnaLDYxorRpSSiko9tmRQ4pC81UIXJ+p1mCPUFpmLhAwg3fYjP4/vE6jZdG9y4IdOPEhWSlPo4r6B9NCaEOZ9Amr3zZShG85tERni+czmKgKVsDjLehyRCdDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYR8eXwB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYR8eXwB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-237f18108d2so177085ad.0
        for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753276779; x=1753881579; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb0/7yMT9K2SX5uLjkUISpIiyNMkZYnJ5i8nHLSmhqw=;
        b=MYR8eXwBZGOlRpJsCqeM7pvlho6Mi2BZ7zYK4+yZv9Ny597xVgxD6wdIpI4S/zM7eG
         MwzPJAOnljJ5TD2TRI/iygmpTTp7yv2VtxldsLEnjiPxEOEnslzUXsV0YCvj8831sPF5
         hPDity8DpxZVGQ155/aj0wTtmszPnBw6Rag8fuiVi0M0Ekm+j3drRnU0MXnM7J/64FXJ
         UNboZ3+2VJdY/8tc26v0yRP9T0/mnaZLZoEiwbStWk3sL8jmDsoIR715xBv4d5JLiIlO
         wrWYcLWfnPe7Vf0OIiLjr6hcaARtygLSTkX6VRx+i71elELkBMyu7F1euZ9YRns8sy/1
         oGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753276779; x=1753881579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb0/7yMT9K2SX5uLjkUISpIiyNMkZYnJ5i8nHLSmhqw=;
        b=SkcjLLCLe9CJirswOsKmAuVTxv3w63c07DXe86j3j3Zgm0BGjIOyjIcQTdB8QbFAZO
         Y6AawykoPXQuu3U66SFAM/8FLDfeo2c8h0plah3HyPMReXt4/y2NR1WL8G//5LbmqrCK
         gzS2/ugfsmeBwXp27c9TMh5ThsN3EWwz7+NbS6s6Kc0i6mi9ZB3cEd5WQ66HAm/USCyR
         bxOTLId9eoi0lLsRzAnqxfYnGtPHb0/NjtrI8qHZPoNdrGYTDBcIolhp/su5vlZQBeen
         IlYALa/JuZvHSqej2lHEgoEJmgpB2gpmO0B3DU+Tsn23AB0t8TFNqI0K/dGKuCAhES2F
         6l2w==
X-Forwarded-Encrypted: i=1; AJvYcCXzIAe9S7CE4Tw1uQtf3KYRbdcfdQa/ggBBqTViR/fpjB7+s9+8Cwy5Z/QxMF/TC1sA2BNcSA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2kIKBrFC7xPGkXk9Doc+nWfmdwou7gWBNp69ceiC6LtLI8FnY
	EvCROzFgRk48y7cvft2dd1Sd6FXdvegeCIRyvGXeRZMwN8+a1Bp1fCn+1FcDIcc/wA==
X-Gm-Gg: ASbGncuOT40+p+nGgpOdMhJfbdNNe3s6yO+IuLAoE41VMqzkK7NWVPSqKZuilxCjxSb
	bi7qdAt2CbGnRWSqqH4hJUGKW6sMWhaKUSJAuVGoSEieV8cOoYBDgwfoj8Zt7RawqBASjGrcdeK
	0hZ2MKWimde/dEGwmPvUZgW/PS/ioe8/4j2hORwHRuBC6w0L7Y1ccpznWYHIsJoMq545kxvl9K1
	JfaIqQOQ0BnOMXLazAEznrkoOBh17b2XPpndci+942sh2KFwKa4UOOClfobDuX2qU0Y39mNLDyh
	klYNrL7YgACLUk3XC5I+1WDQWFf2nBvGNYSYHGNEhHlp35YVAMDa5VqcTd0P8DLaGS0/urajLld
	L7HRmwHFM3bUCFts073FgUTZ+9Q2ZZMjkmNFrGH0Nsgcfkm27zzC8nww8ZhTpY8bn6L8=
X-Google-Smtp-Source: AGHT+IHbupigD7UyWy96X++uPcWs3IP3RJjiuOFwsDzZsLXWJ+ydnHjuzs1Cy05YPmOdWDc6ThTsAg==
X-Received: by 2002:a17:902:d4cf:b0:23d:d290:70c with SMTP id d9443c01a7336-23f9774ca0amr3106875ad.6.1753276779019;
        Wed, 23 Jul 2025 06:19:39 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d4esm96942565ad.23.2025.07.23.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:19:37 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:19:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Do not bother impl_ops if
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3
Message-ID: <aIDhY3JTaT3JC9T4@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-2-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721200444.1740461-2-nicolinc@nvidia.com>

On Mon, Jul 21, 2025 at 01:04:43PM -0700, Nicolin Chen wrote:
> When viommu type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, always return or init the
> standard struct arm_vsmmu, instead of going through impl_ops that must have
> its own viommu type than the standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3.
> 
> Given that arm_vsmmu_init() is called after arm_smmu_get_viommu_size(), any
> unsupported viommu->type must be a corruption. And it must be a driver bug
> that its vsmmu_size and vsmmu_init ops aren't paired. Warn these two cases.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> ---
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 ++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 14 +++++++++++
>  2 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index d9bea8f1f636..c034d6c5468f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -420,14 +420,13 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
>  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
>  		return 0;
>  
> -	if (smmu->impl_ops && smmu->impl_ops->vsmmu_size &&
> -	    viommu_type == smmu->impl_ops->vsmmu_type)
> -		return smmu->impl_ops->vsmmu_size;
> +	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
>  
> -	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +	if (!smmu->impl_ops || !smmu->impl_ops->vsmmu_size ||
> +	    viommu_type != smmu->impl_ops->vsmmu_type)
>  		return 0;
> -
> -	return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
> +	return smmu->impl_ops->vsmmu_size;
>  }
>  
>  int arm_vsmmu_init(struct iommufd_viommu *viommu,
> @@ -447,12 +446,15 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
>  	/* FIXME Move VMID allocation from the S2 domain allocation to here */
>  	vsmmu->vmid = s2_parent->s2_cfg.vmid;
>  
> -	if (smmu->impl_ops && smmu->impl_ops->vsmmu_init &&
> -	    viommu->type == smmu->impl_ops->vsmmu_type)
> -		return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
> +	if (viommu->type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3) {
> +		viommu->ops = &arm_vsmmu_ops;
> +		return 0;
> +	}
>  
> -	viommu->ops = &arm_vsmmu_ops;
> -	return 0;
> +	/* Unsupported type was rejected in arm_smmu_get_viommu_size() */
> +	if (WARN_ON(viommu->type != smmu->impl_ops->vsmmu_type))
> +		return -EOPNOTSUPP;
> +	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
>  }
>  
>  int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 181d07bc1a9d..9f4ad3705801 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4703,6 +4703,7 @@ static void arm_smmu_impl_remove(void *data)
>  static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
>  {
>  	struct arm_smmu_device *new_smmu = ERR_PTR(-ENODEV);
> +	const struct arm_smmu_impl_ops *ops;
>  	int ret;
>  
>  	if (smmu->impl_dev && (smmu->options & ARM_SMMU_OPT_TEGRA241_CMDQV))
> @@ -4713,11 +4714,24 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
>  	if (IS_ERR(new_smmu))
>  		return new_smmu;
>  
> +	ops = new_smmu->impl_ops;
> +	if (ops) {
> +		/* vsmmu_size and vsmmu_init ops must be paired */
> +		if (WARN_ON(!ops->vsmmu_size != !ops->vsmmu_init)) {
> +			ret = -EINVAL;
> +			goto err_remove;
> +		}
> +	}
> +
>  	ret = devm_add_action_or_reset(new_smmu->dev, arm_smmu_impl_remove,
>  				       new_smmu);
>  	if (ret)
>  		return ERR_PTR(ret);
>  	return new_smmu;
> +
> +err_remove:
> +	arm_smmu_impl_remove(new_smmu);
> +	return ERR_PTR(ret);
>  }
>  
>  static int arm_smmu_device_probe(struct platform_device *pdev)
> -- 
> 2.43.0
> 
> 
