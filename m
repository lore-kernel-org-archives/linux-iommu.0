Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A06E1509AB
	for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277882; cv=none; b=qXHavbux0FKicvac6g7edA2SU47CQVLDPeYnkhXtHnfgum/zmKd0/h+zgvCQEOr3elQ++SqwLD/IIjlmBv312uhXZZoHT08ka2xGeEZbw9j+Hh3rlpuj99uu3RTzFTB5Cbw+UZU/WTnC4r1XADGJU9rG6y4Lun2oPpnXcl7jyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277882; c=relaxed/simple;
	bh=loj95alexQ30u6RYGhFIYnYsaA5hCj9ehW16PyQpKvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wtc4LXR0sE9I11ZsyC4uFOML/YDlFJ8Kzil+lt635lh1l5sSBkaVKXiubkknTLHNEA0JRzTqkfZiC/WCg4gNWgj3Ig1bOUhvvpPDtHPYMbCc96nyb+oLfSEgt7ojcOh+UU7BZwZFt0eVhgERNnFBIfr4GnaysHB+ewZoNV1veH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ReDeWjYW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ReDeWjYW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e389599fso213725ad.0
        for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753277879; x=1753882679; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+JLK8o3lT0td/MYczWJEZnb2L8d00AyuRGacnswf14=;
        b=ReDeWjYWi4WBmiGe7nINCSSmtLjNxNKMYqjBuLdGlXiW7qJwLK01fr5PyWwBl379B8
         GBLF3XuGN1Lsaxaaj+qtL66X542C/U8z4mME/C0PKtNNTAsIHV2PR9xUAI+4YR2FpjWZ
         8BPclLN4KKhhPMc+lrkqihG9+NgC2xvC/52SkHUGkvTBOwwiybtero7v5vTjVUTkYYmC
         FKiCde2F3pLuSOeydyZ7LHldG/6VcTmJL2hlVOZAzMtVVTwwcUSUgkOLmURydsdYIJYN
         OfiH8lnGxRYFfjGKqXlqRegR3Ehhu2f8fG35DQSyHrF1dryhaIcpkynmvGkcYWVmExVK
         9wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277879; x=1753882679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+JLK8o3lT0td/MYczWJEZnb2L8d00AyuRGacnswf14=;
        b=ey9mzKxQv7m/VJTFNM1NpOqb2j+jnRXYvFRrH9+T2LxiOtYAKeh2MJVHrHCar7oEla
         9XQ6+EasGvnuI7z2jJ85scj13hDZ3XqkZfri0FZgeQYkgWLHt8iQzkIduVleD4vlg/L7
         /VfEq6xrDULpVhH+Yshrnw+0ziQgEkXLGWNhJaN4r6tl8IUKuzouBEQdV2yuESg1cErz
         uEM4INM8YsT0FJiQD5l4AcJOMcbokDKQc2squstWnXONKkAp8S/iI4eXL3MDb+H8ebK+
         8TdU8mJ2OnycW2W0wyzA11xvmrDecEJbZNfq2+9CIu2ZrBF3Lq+opWyGF7J8QPpezD8y
         vGwg==
X-Forwarded-Encrypted: i=1; AJvYcCWVVrTbkw3Ur/VzCs1K5Oo6S45yCXN1266D+96uvBg5gf7tVdZPwm54CRBTMktjoRr2x0cSlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcayKm8K5NKclL23PUtu+szgk19Whzrt0P49PVL8dMRYEqad5K
	b5giDg31Oduq7bH+/uiA7QNv/adtegi/Yei53T/VFJFm/RO3pOMzWJ1mD9pS69GuWw==
X-Gm-Gg: ASbGncswCo9G1byXEoRH8xhq8NCjDv7FSi0PIHKrP9/fNaCr8V2aFV3h+8eAIxDE6qN
	5Pqkqi5zRoGgHh03odf97KqUnh7GyhnyuuV0H6vuaSaM+HiSl5xwgMQ6JEpdeXCS882WJMkBAXw
	jtb9/XDwYV7DdrdtRSma9gmet4mdMvEm8YfE1ZTKz8XOsQwp7KY5scUK4Sg87r98Tb6iYKeQvvu
	fltoBIZrgYXQAfmcrlXQrxZXxtHPgDT9wrkGZ61DG2kR5nrWib4XveIN6xgDAyAULrMS+iCgRfp
	Sn7sse537tcKv80lu0zyCdm/yeh/V0bVbzLCQF1BsdOjmrLRrc7U+pk5dQZaILZmwbx1G+0Q6Ek
	1jZ50K0t4S72bBuQnGdfo6bmFfy2E8KDvb5J1rkgrA5atONSAh87eSGH6UGGvGR5E3dw=
X-Google-Smtp-Source: AGHT+IHNDySI/nH+OMkMv0ChQEdtb4UFgDV0ZT5tuGjSaRubSm3kOT/oocHqF0dfxqVXTEfR3wYujw==
X-Received: by 2002:a17:903:15c3:b0:234:13ad:7f9f with SMTP id d9443c01a7336-23f978e398cmr3323895ad.22.1753277878789;
        Wed, 23 Jul 2025 06:37:58 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23f75d13bdfsm77086475ad.51.2025.07.23.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:37:58 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:37:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIDlsUvF2Xbdelvx@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721200444.1740461-3-nicolinc@nvidia.com>

On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> It's more flexible to have a get_viommu_size op. Replace static vsmmu_size
> and vsmmu_type with that.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  8 ++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  4 ++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  3 +--
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     | 14 ++++++++++++--
>  4 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index c034d6c5468f..8cd8929bbfdf 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -423,10 +423,9 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
>  	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
>  		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
>  
> -	if (!smmu->impl_ops || !smmu->impl_ops->vsmmu_size ||
> -	    viommu_type != smmu->impl_ops->vsmmu_type)
> +	if (!smmu->impl_ops || !smmu->impl_ops->get_viommu_size)
>  		return 0;
> -	return smmu->impl_ops->vsmmu_size;
> +	return smmu->impl_ops->get_viommu_size(viommu_type);
>  }
>  
>  int arm_vsmmu_init(struct iommufd_viommu *viommu,
> @@ -451,9 +450,6 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
>  		return 0;
>  	}
>  
> -	/* Unsupported type was rejected in arm_smmu_get_viommu_size() */
> -	if (WARN_ON(viommu->type != smmu->impl_ops->vsmmu_type))
> -		return -EOPNOTSUPP;
>  	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
>  }
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9f4ad3705801..f56113107c8a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4716,8 +4716,8 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
>  
>  	ops = new_smmu->impl_ops;
>  	if (ops) {
> -		/* vsmmu_size and vsmmu_init ops must be paired */
> -		if (WARN_ON(!ops->vsmmu_size != !ops->vsmmu_init)) {
> +		/* get_viommu_size and vsmmu_init ops must be paired */
> +		if (WARN_ON(!ops->get_viommu_size != !ops->vsmmu_init)) {
>  			ret = -EINVAL;
>  			goto err_remove;
>  		}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 3fa02c51df9f..e332f5ba2f8a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -728,8 +728,7 @@ struct arm_smmu_impl_ops {
>  	 */
>  	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length,
>  			 enum iommu_hw_info_type *type);
> -	const size_t vsmmu_size;
> -	const enum iommu_viommu_type vsmmu_type;
> +	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
>  	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
>  			  const struct iommu_user_data *user_data);
>  };
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 4c86eacd36b1..46005ed52bc2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -832,6 +832,13 @@ static void *tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu, u32 *length,
>  	return info;
>  }
>  
> +static size_t tegra241_cmdqv_get_vintf_size(enum iommu_viommu_type viommu_type)
> +{
> +	if (viommu_type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
> +		return 0;
> +	return VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core);
> +}
> +
>  static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
>  	/* For in-kernel use */
>  	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
> @@ -839,8 +846,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
>  	.device_remove = tegra241_cmdqv_remove,
>  	/* For user-space use */
>  	.hw_info = tegra241_cmdqv_hw_info,
> -	.vsmmu_size = VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core),
> -	.vsmmu_type = IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> +	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
>  	.vsmmu_init = tegra241_cmdqv_init_vintf_user,
>  };
>  
> @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
>  	phys_addr_t page0_base;
>  	int ret;
>  
> +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
> +	if (WARN_ON(vsmmu->core.type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV))
> +		return -EOPNOTSUPP;
> +

Nit: I don't think we'd expect a call to this if the vintf_size returned
0? I see that in iommufd_viommu_alloc_ioctl, we already have a check:


        viommu_size = ops->get_viommu_size(idev->dev, cmd->type);
	        if (!viommu_size) {
			rc = -EOPNOTSUPP;
			goto out_put_idev;
		}

And call ops->viommu_init only when the above isn't met. Thus,
if we still end up calling ops->viommu_init, shouldn't we BUG_ON() it?
I'd rather have the core code handle such things (since the driver is
simply implementing the ops) and BUG_ON() something that's terribly
wrong..

I can't see any ops->viommu_init being called elsewhere atm, let me
know if there's a different path that I missed..

Apart from the above nit,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

>  	if (!user_data)
>  		return -EINVAL;
>  
> -- 
> 2.43.0
> 
> 
