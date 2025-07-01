Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636E27466A
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372665; cv=none; b=UkDgyrxNuTlAtogTFPopSOg/N3iqYKSmWMpif7HqZg4Zq4MmViQ7SnGjdq7SVhI63g8UJfMSgidrSpAvVTHQ6/hFpK8IP0fOSZMJunsRm6PV3GykSuBdgbMRkyODBVLli/e2cHTPFYzoENSrzSvchAsiFxMTYEZO+Ld6StcRIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372665; c=relaxed/simple;
	bh=n8ZZkcIMTZ4oqwXL8cuzmbKEBEW4c7SvXxR443L664I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+XCWoEuYqmu54hDbYMQ47k7JkzOyMmeOhwtS+B4115RZrzRQsaUWku0siSJOJe4mQvUpPbsOneLO40hmAMNx6CzuuwUcCwwFbchuk4j4GPjP/I9FbBAGJSBNOaGV44UNBDHWwLUFcfzR+qgndgll9/FWdQafu/jra4H/mHthxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZD9F6Pk8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZD9F6Pk8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2357c61cda7so116105ad.1
        for <iommu@lists.linux.dev>; Tue, 01 Jul 2025 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751372663; x=1751977463; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7vYU5IpUGkedTKGsOw7fqDjAvdD4uWcycZwbigztzQ=;
        b=ZD9F6Pk8QFCZXI2gmxf2+i9cmbFnzJdhx8azZw0r5D7EPFQHkDX0NZwFDAN0+i//Ns
         TJPEQhBheE71scUAbcMjvpF6DdSN9YiQkcH9/ej+n01HXP9mP9vXhYSVWX0Me4CRCSX4
         LzYoQt89RM/hW2TAhxKyFYJfoynN3URcAEpvqWgPT3dH/5A+gFYOOgnyznW/kE4/79DH
         Yd3Q5UD2SPevojz+DOC5XlKlkQgd/RysR+DJ70HzwQvQKV2l3I2MQITvkqYFjbu6sivh
         h6F+RVihsrGweeTtXRMe5aCFXW+EUtTefsZyU4yAVus5tgiXQycWzqMy/ibNSk+QpG30
         QScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372663; x=1751977463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7vYU5IpUGkedTKGsOw7fqDjAvdD4uWcycZwbigztzQ=;
        b=DimknPnhWwNW3GAzAhJcO2V31PhwYVmg/PVTFvHlRKxojF2oiL4C7kciin42tqJaSk
         X3woEhCmLo92oDHZn8N94P/Hfl0EYJeQLHgSWKfcE2hCZHrnfQC1urWfzuKJtMv0bJSf
         43gUV8tAewn1YsQRwnF5e0U+wLr9Q/cE9VbmD8eGoDvmwsW35g9MA18/rUfc+ZMPO0IS
         +IH8s9wlkR9As4rq06TUrBRefUAPe2ll9TnQhiwCjnDngL95Xx9MfHhcStNgxeOqVijo
         5RNLmSDifJMHUZzhXGIII2Uftr7TA1bgbubaEmQlZU7t1G5HWJII0F2e6JQNb1arhgZ2
         nIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjxmv9LrBNMfSyMm4zZATT+hpFSFuvT4dhvMfju5EJph1IB4T8y43a0lStZCRjJFmYXADWSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbgM0NOXn1UUKlEAmVV/91mYJ8fw9qFp7JxLNztJtaH0fbqsH/
	jIyx80/C57go+U2Z73p+gFIw/0Jia6Ea1MhzmeTU0O1hls/GDLuiO50zoBEpiEEa+A==
X-Gm-Gg: ASbGnctsgblGOkFqwWVfBDng6B/08wiqp5bKcApXEdRrKQMn7b7Ej+wG1wkDI3zAcBm
	0Q4zp6A8w0ut6Rvtpc8MjEy3+ZJtRLC7fD2j3XFxCruzP9g7P4c4UYFzsyIFthzMvssQySgISxt
	XJyqqgOg/9hgu4nN6YufXgb1UPkpPotKfsZFjGsphSgTukMaIef9lFXKTNJCAjQfnQqFUgsE6is
	tKjnPvvGcuKJt0C6LHaOiojOKuGniUARoMM3oLk7JPiLDqna4Ct1TwbqGb+W9RDtGPk5r2Ci246
	8/WiQZEpVUR65ros5jxtuzgcmbxVibcoQWdoBzDj3l9riaYcapg35pr7khAnQPMBHCyD9eK25QU
	RsNwtgrtN/mioSxNS4AfV
X-Google-Smtp-Source: AGHT+IH4JQ2MdaL4TQHuSEKzEVU+2Jy2z1P1pCYvzTGLNdSVTsldrYDv/hBtBO4QCMRhsGfAvLyPYg==
X-Received: by 2002:a17:902:e54e:b0:235:e1e4:efc4 with SMTP id d9443c01a7336-23c60105131mr2451315ad.14.1751372662789;
        Tue, 01 Jul 2025 05:24:22 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5437b40sm15776317a91.37.2025.07.01.05.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:24:21 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:24:07 +0000
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
Subject: Re: [PATCH v7 23/28] iommu/arm-smmu-v3-iommufd: Add hw_info to
 impl_ops
Message-ID: <aGPTZ3uHRIIRMF4c@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <205f234c05d6b09de52124a72a6978b74d832cfb.1750966133.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <205f234c05d6b09de52124a72a6978b74d832cfb.1750966133.git.nicolinc@nvidia.com>

On Thu, Jun 26, 2025 at 12:34:54PM -0700, Nicolin Chen wrote:
> This will be used by Tegra241 CMDQV implementation to report a non-default
> HW info data.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 7 +++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 07589350b2a1..836d5556008e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -721,6 +721,13 @@ struct arm_smmu_impl_ops {
>  	int (*init_structures)(struct arm_smmu_device *smmu);
>  	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
>  		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
> +	/*
> +	 * An implementation should define its own type other than the default
> +	 * IOMMU_HW_INFO_TYPE_ARM_SMMUV3. And it must validate the input @type
> +	 * to return its own structure.
> +	 */
> +	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length,
> +			 enum iommu_hw_info_type *type);

Thanks for adding the comment, this looks good.

>  	const size_t vsmmu_size;
>  	const enum iommu_viommu_type vsmmu_type;
>  	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 2ab1c6cf4aac..1cf9646e776f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -11,13 +11,17 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
>  		       enum iommu_hw_info_type *type)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	const struct arm_smmu_impl_ops *impl_ops = master->smmu->impl_ops;
>  	struct iommu_hw_info_arm_smmuv3 *info;
>  	u32 __iomem *base_idr;
>  	unsigned int i;
>  
>  	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
> -	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
> -		return ERR_PTR(-EOPNOTSUPP);
> +	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
> +		if (!impl_ops || !impl_ops->hw_info)
> +			return ERR_PTR(-EOPNOTSUPP);
> +		return impl_ops->hw_info(master->smmu, length, type);
> +	}
>  
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 
