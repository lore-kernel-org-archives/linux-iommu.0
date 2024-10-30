Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD572141AE
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305586; cv=none; b=sTk9JbjnCd04oP2E+WNaeLBA70DOsjhcIKuXFbbi1IgVF9yLwe1ZUHSFmgkwgQjRcF+VFw7V4INaaKritnEy1dacps39d/UpHIL2rhavRYjf88AfN6e79a0Kz1gMKUXpaJWocON9XDHv8QngBWcXx5k5vlXuTLzWo2NQHxUpGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305586; c=relaxed/simple;
	bh=wzGL5UpvG0bdwTiYnT824JUIRPqrqwRpm/7xcQNirR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr4VSgms3LQy5h/476J0O8LeE70Pb1y4/9HsIAhFLlXTTMkCw/EBOxYtMhFts3bJl2moKM/HM/xyrR7S1z9JKcH5QnH0lJPybUj4nkAS+ATuRbk9v+mqhBPKig6YNGj5zZMaWY2Kd1BwcDOEHi7KpPnhw3K73WzZlJREfAkNUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kek2cHsZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kek2cHsZ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so262185e9.0
        for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730305583; x=1730910383; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UYLjFAMj81rJ/LVUvePRD+K/hBtRYfZ9cIPVkpzOQ4=;
        b=kek2cHsZoQKrNnOeGbvOciGSfLN3Jl6+Y1isfJCsB5XWT7zhfubCFaPlS817Aqo1Sf
         gj9+ZHea1CNeKq0sRhLhyYTF310goDfaw/Bn5jLlQ4ziI0kX4Ro+iru8XrgjwRZ2biCp
         9t+oo/I21gwH8SA3KJEyO8z6/mecBfcBb5bf72d3uXoyyZdGvkNIAVtODaDxWOsgSK0y
         grBeSTnsNmKIKtbLKcdgr1pyj4CDV4bI7T7j2uugdbJ8aqmxvctPEWc3IZv0jWnF+M+e
         qMzIZVC/gl+t+5KAfJWPH5PiDf7Kppnuc9E9mAM+cgJEVD8K1VkWgzJQr/Ps/nbQqmx/
         BtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305583; x=1730910383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UYLjFAMj81rJ/LVUvePRD+K/hBtRYfZ9cIPVkpzOQ4=;
        b=H0K+N9q7+ljY9rpZGWVtoW6jXdn05GCM+aUVV0P6MzdnYbVSAi83YZm1o6+NXyCW9/
         2Ymhq7c6qtej/KU/v63UWNJQE0p7xOwfQaHjqrhasz3mv/7Dab70K55amAaWeVoD0fj+
         1SENzPk3yh/dn8bfWt1bVu8fbNCLutbqfMChx7j6MwMlHDZKBT/T3m5fcH6MJPy4mkDV
         uXpwnDRoyUFGHLfWOl7gAIcXD1cRLYs1y4/tyC/fxqUFNofRrrIzEgsZt696UJMFAO8C
         gVYNUog4EsCRUKI7WDzJx0ZjLopxM59s3GCxDfMTqFUdL65q4ImXsJzRtd+XjUv/QraF
         IULA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Cf1WP7WejwnrPGlzzPiLpE9IUdz381VEwBav9L+DeskezU8bC0UxYNXoHdFfrKX11vaAyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCDVZpJUqo3C5k8yWQA9p5/XBUB3dqLbOxIlklJKcZFoAW+05k
	LsZYMNzxKY37X63D/ENUY68UaVTf3y8R2W5sdmkOG3kgNUXX72JwqyUI17Ky3g==
X-Gm-Gg: ASbGncuwc1u6qmAybCrmamDzuUBNsOm8MAoMevUebLkfz9HEg4HzM4rs2NbirIC0LFL
	kHXLjI2Q1sgeeh5XnPTteSh7i+mCQPnXzjurqBc/2PLwnglakKjGQLc+c/yKCJpChG/97TlNtOs
	5AHf3guU1/jzC87Uowojoc4cv9CmhICdO/UKF0oyUuk6kEiEZCeH7j/5RFcIlk3r/RxZoR6OFG8
	pZhC2+yhltheF3ENRB0lWsdFJdbVtqR+QMQFeyVDl95Q+v9UYgSgc2hKc1leAUdSse9czpzfn8h
	0ICAJCQiXA==
X-Google-Smtp-Source: AGHT+IF5k+xhEFV5HljKvzF9cSpzzYGRlJbocUjKE5hnuGSngP/vDOPF5xH9U8BJE4SMib7JrVlCvw==
X-Received: by 2002:a05:600c:1e04:b0:431:43a1:4cac with SMTP id 5b1f17b1804b1-431b4a21ba1mr10153235e9.3.1730305582787;
        Wed, 30 Oct 2024 09:26:22 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4287sm15691567f8f.114.2024.10.30.09.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:26:21 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:26:16 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 6/9] iommu/arm-smmu-v3: Implement
 IOMMU_HWPT_ALLOC_NEST_PARENT
Message-ID: <ZyJeKPvMRBaKpMeJ@google.com>
References: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
 <6-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>

On Wed, Oct 09, 2024 at 01:23:12PM -0300, Jason Gunthorpe wrote:
> For SMMUv3 the parent must be a S2 domain, which can be composed
> into a IOMMU_DOMAIN_NESTED.
> 
> In future the S2 parent will also need a VMID linked to the VIOMMU and
> even to KVM.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 996774d461aea2..80847fa386fcd2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3114,7 +3114,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  			   const struct iommu_user_data *user_data)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> +				 IOMMU_HWPT_ALLOC_NEST_PARENT;
>  	struct arm_smmu_domain *smmu_domain;
>  	int ret;
>  
> @@ -3127,6 +3128,14 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  	if (IS_ERR(smmu_domain))
>  		return ERR_CAST(smmu_domain);
>  
> +	if (flags & IOMMU_HWPT_ALLOC_NEST_PARENT) {
> +		if (!(master->smmu->features & ARM_SMMU_FEAT_NESTING)) {
> +			ret = -EOPNOTSUPP;
> +			goto err_free;
> +		}
> +		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> +	}
> +
>  	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
>  	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
>  	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, flags);
> -- 
> 2.46.2
> 
