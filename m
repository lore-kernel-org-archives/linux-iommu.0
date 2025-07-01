Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F442741A6
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374459; cv=none; b=BO6UwLK9VOexmLa6essm78Sv+4GcxpvxPZW3GVZbJBZKvqOHWpyeKE4RsDHK+PLxZRiqqoCNVzVGmhSAIr7CVGAO/K4o8GrfYgUg8DnBAMDjxYpNp9hm7vQG/Xq0KENlKwF4/i9hmTiemA0anCkhcxhtIQZM3av4kqRFj8wfrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374459; c=relaxed/simple;
	bh=3gJtS77mHK7VTcYFcjrd5hF6WARIXk6d2X2+wZ3Hta4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU20O83KXUuVjoOcPIbmPMOvaE7HX92SnP3zXpt4IY6aYwvzRInWcrnV7Hh6jtfPV3evxyQeo7dG4po8C4S44GRPPS8u1zaiNVgCuAruyoNxwcH5wv1p44mLm28vRwDw8l6PIkOHPz3OWs01wBjHVeYVb0UiyR8mZXFOuXonrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jzF0FoCA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzF0FoCA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2357c61cda7so119405ad.1
        for <iommu@lists.linux.dev>; Tue, 01 Jul 2025 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751374456; x=1751979256; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/L74aNTJbvTixP9x7JPOzIa2qX6+0XWisdXXC8NLNbk=;
        b=jzF0FoCA+El+kxFgOqE/7z98VejgQFp9NJdLfe6ERhNHJT5VW8/svwSqQc/5fAeyJX
         66/BRaO/pUIarisVF3jl00/yDMw8FMK82NzGp5vHunmwp/fO8mRYkrC7gLSpsWfVTy8s
         45UDY+tnksiyMFofsIJfHFbiiGpdf3K6wfLn2avQEX0TWJldy99H43pyHN0JPrA4nFE/
         VIbI2l5tKbpu9Waad6p4vW6+l2ZT1pmW/Wn3CnwUUM7/odhp5nrEOg+8g10zNGXGdTyQ
         ubjl126leQ0YFcvgW2iOJzZ9hQf7phxHpn8ekkOJVOAMhsO/e+ChIO4cYsnKjRj9aDVX
         TPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751374456; x=1751979256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L74aNTJbvTixP9x7JPOzIa2qX6+0XWisdXXC8NLNbk=;
        b=TDHQI01SLa1vD4sJT6Aj9Fzd5CwO0RPQYXx6PBVs5IadK3D0aamOmfu5C0kKaq8miQ
         w8vD/0OYwf2oQI5hO6jKW9vQJ8IWcWArYwcz06d8L5InJWMYao93Znx4wN9FAEuuFtWi
         GMObjVhC2fmSvcOEPqX/8uarvQ41fGGbom+zQL21kcyPJQJ/Rwjxj6cqldWqB7Zi2+hB
         ZmHnOY9hACoRJU8E2khrnVTvLtIrjoXlC2/D/PxDqXj9OXCc0/2AMByM63XvcQdZdFwp
         05kBkGsXYwgjrbP3By/dav5+NcqpYPN8F9MihA4rZOc3DzmFMoYRNQst287CmUDmX6rb
         4rqg==
X-Forwarded-Encrypted: i=1; AJvYcCVHaKGBmaXFERJaIx5pTpamfV/wr0xi335CctTI/zEq4S3h4feDqOXoCDlsSQ/2NdD8vGHZPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrPeZtrP6o//8t3Gzidhmaw0d375YdLX3pSLYik3aIoavWJNDi
	xbDP6R0VheVUVxStZBMJ5md/63ZzpVr/EMq0OZJyJoHg3llOYgK/EfnHvumMRpS8ug==
X-Gm-Gg: ASbGncu/ZT+fsKv+1W2h9J6KXhvu/6IvFhErSNCZj8ZmYkapyr2XdZ1AKEJRMRXyfaA
	aQPUMLCy8moeQ2gjtRw9J2JcICUkx28gczHI5QcOaBu4wQvzmhekp9nVIBmb3X2jTvj3jnSGB6n
	EWWixsZ2i1GTgBwjccFHpoDVlHqqOqFKg6yKWyOFjII0ZbDl2u3fpzzglZ0LyzQMa09C/JgsyJs
	r+433tameuaih3gTYnwtxhXkhOslxk38c18cMvb/2BAr59uAGeXaM27sfE5/CXlz1svjTBydHPl
	gtj8Xt32hMMVdYeZ8Ffcavp+mQwQ+DRGcxX0X7LTTa8Nhpgn5PFAIWCvy1IQf9h0aiXGba8eo4B
	9qpEUXRNKEBpfhekgiDJr
X-Google-Smtp-Source: AGHT+IFmb6IkHO5vc0UO9aOVGDXMpB2kmzp4LmZ2sU6rPiqzBx0SBn3BZ18jaHfT4NmGETFHxk/nSg==
X-Received: by 2002:a17:902:f688:b0:231:ed22:e230 with SMTP id d9443c01a7336-23c6010f25amr2110315ad.15.1751374455431;
        Tue, 01 Jul 2025 05:54:15 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7a47sm108535025ad.166.2025.07.01.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:54:13 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:54:05 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 19/28] iommu: Allow an input type in hw_info op
Message-ID: <aGPabX6M2REffzjY@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <d8c395d6956045fd1fa1349538d29e3b6f9fada8.1750966133.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c395d6956045fd1fa1349538d29e3b6f9fada8.1750966133.git.nicolinc@nvidia.com>

On Thu, Jun 26, 2025 at 12:34:50PM -0700, Nicolin Chen wrote:
> The hw_info uAPI will support a bidirectional data_type field that can be
> used as an input field for user space to request for a specific info data.
> 
> To prepare for the uAPI update, change the iommu layer first:
>  - Add a new IOMMU_HW_INFO_TYPE_DEFAULT as an input, for which driver can
>    output its only (or firstly) supported type
>  - Update the kdoc accordingly
>  - Roll out the type validation in the existing drivers
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                               | 3 ++-
>  include/uapi/linux/iommufd.h                        | 4 +++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 ++++
>  drivers/iommu/intel/iommu.c                         | 4 ++++
>  drivers/iommu/iommufd/device.c                      | 3 +++
>  drivers/iommu/iommufd/selftest.c                    | 4 ++++
>  6 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e06a0fbe4bc7..e8b59ef54e48 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -603,7 +603,8 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
>   * @capable: check capability
>   * @hw_info: report iommu hardware information. The data buffer returned by this
>   *           op is allocated in the iommu driver and freed by the caller after
> - *           use.
> + *           use. @type can input a requested type and output a supported type.
> + *           Driver should reject an unsupported data @type input
>   * @domain_alloc: Do not use in new drivers
>   * @domain_alloc_identity: allocate an IDENTITY domain. Drivers should prefer to
>   *                         use identity_domain instead. This should only be used
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index f091ea072c5f..6ad361ff9b06 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -593,13 +593,15 @@ struct iommu_hw_info_arm_smmuv3 {
>  
>  /**
>   * enum iommu_hw_info_type - IOMMU Hardware Info Types
> - * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
> + * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
>   *                           info
> + * @IOMMU_HW_INFO_TYPE_DEFAULT: Input to request for a default type
>   * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
>   * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
>   */
>  enum iommu_hw_info_type {
>  	IOMMU_HW_INFO_TYPE_NONE = 0,
> +	IOMMU_HW_INFO_TYPE_DEFAULT = 0,
>  	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
>  	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
>  };
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 170d69162848..eb9fe1f6311a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -15,6 +15,10 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
>  	u32 __iomem *base_idr;
>  	unsigned int i;
>  
> +	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
> +	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 850f1a6f548c..5f75faffca15 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4098,6 +4098,10 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length,
>  	struct intel_iommu *iommu = info->iommu;
>  	struct iommu_hw_info_vtd *vtd;
>  
> +	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
> +	    *type != IOMMU_HW_INFO_TYPE_INTEL_VTD)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
>  	if (!vtd)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 8f078fda795a..64a51993e6a1 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -1519,6 +1519,9 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>  	    cmd->__reserved[2])
>  		return -EOPNOTSUPP;
>  
> +	/* Clear the type field since drivers don't support a random input */
> +	cmd->out_data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
> +
>  	idev = iommufd_get_device(ucmd, cmd->dev_id);
>  	if (IS_ERR(idev))
>  		return PTR_ERR(idev);
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 8b2c44b32530..a5dc36219a90 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -310,6 +310,10 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length,
>  {
>  	struct iommu_test_hw_info *info;
>  
> +	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
> +	    *type != IOMMU_HW_INFO_TYPE_SELFTEST)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return ERR_PTR(-ENOMEM);

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 
