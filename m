Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECED2AE6A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510061; cv=none; b=uy2g6M5P0PvgQ+OI0rj14MqRPcg3ZM1rwmDvdEOl4eRMEgHOeSfzgzO0+hO46vDBHOJtbTpsEmLlNatfHyb2vOx9NDBF5Y12isCR/2bMmv8KCpc+drSHVmRA5PYNfOjPAGgxzJXFBweilHq5DKurA/MdMdAc0E1Kp/+8QBG5tX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510061; c=relaxed/simple;
	bh=g1ghp9Svh+dBXRcTv7E0bBqDeLuPcReqj1pF9rWN+Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxhJNmZTX5R4HfT2czXI5IBpta2SonXizzmK/GMqenldCErb1dhRrUuLIPvMFfC0IRTpgEtstaCSZS2J2UKhqQuHXWliCiu8Gti3ldNgSjTJxt///XQLxeOsLwhql/+FkqPu/qMc8Sq7swTijFzcTzOg4kliDPA8W9iR9z1gG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhO+tkTE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhO+tkTE"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so9745e9.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742510058; x=1743114858; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9Nj9LbU3FSpnziCk42HRr2vbZlAAyrm1kCxfgtsG8k=;
        b=YhO+tkTEFkQnCsKjhkFydZ1qYQHWR2KVgKWVuMCSMNdpVABi/pofVoiDSyjPKreqAH
         /nLQGKODsnblu4uqYW4rrMld7c4DyvbypcJfdnWSSc3rRCT7yo4Rsg1z7zvURrHBpkxP
         YGPLxmQsVSvbvhL7jQqzkUyFgdkiDRSLpJn8T86SLoMfkS1qRR8o5y11c71qDwAMRwUg
         BaksWgTPRs2GkSAONGwHUntSyYnI1+Z+H+MpXZbne1CQvVTvK8M9oqbMRSnGDCuqbCIy
         wf8TDIj+34/8SPvCC1JT0GOornCcRihucg+IsfFGsbqCS75LIlo4dB9kTPzMp+ArjGwO
         SC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510058; x=1743114858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9Nj9LbU3FSpnziCk42HRr2vbZlAAyrm1kCxfgtsG8k=;
        b=IlTZdOc3FSv7vLesfnSFTat/s1JfChD6Upqmtc4Bo0RF+iVqn0KJBY5CJ5oBhGSTTx
         NjY6BGeOY60693/HonokIdhpmRh3UksNvDHcuFc9meU32KT6vfdVmPDElfHU0mxoor+n
         4SqGjezVyCfxCTRSuKImNUBK8aMzT06pNOBJriKw0qsWSEVT+4GA/awj2qTiWZoL55Rh
         IJlyuXR3hfEJMsXcWGmJdRAbqPdyVkpF7kwQO8rdjXQcRI9WBWvp+vWVY0GXKID6K8ps
         sFwPvDgL361CUYDj2czL740lTGzB56fJD/wzKGyhcde9HVD29CEx0ycZBqBbOWu5uRIE
         048w==
X-Forwarded-Encrypted: i=1; AJvYcCUFHE/C/TwyM16UgKpn4NSWNyRuEQupOdWq6wBkvYO+40WxJVRKXjWUKXHfONHljDd8+NnIWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwROhbtYo2yfwrAx/CBXYI78E6ckLjgi5xNf8INSY/JWZ8MnIx
	e7E34TIQf3owHZ6OLyBHC87w0CE60spF9XHdrj81U89WnDepfBRqmKHL0ybWSg==
X-Gm-Gg: ASbGnct7zduuxLGYpbOnW3RI62ivdZ0Uky+TDZFxeeizKrPbeqabBpLGlZgL7LUr1bc
	yqXlnweUGp9PpX02CIN3LzE2fmez7mwM9v4udDdVINRweFilZ7dmflhXqK2hwsoxvqMAFKgBSkG
	ULEz7MG0N5hVU9E6rUYpWlfV1KclafLdYJ19weg2fMnaGyxRqPBUGpqKy94P6OT5GO+iTCcw5l/
	96eDxyhS9hHN20k3eNOXpsCpTlJJHWqPmtKnOTVeLgk6t/yNxEslethEOFFoKNs7dHTwzN7A7/n
	tMEyVCwiWv3+xg89u1zrPmWIUmwk99S3MC5YUydNb7H61xJlE0yLdkOE2Ml+fab43ZDjCONmOyH
	WWl0AvPeuj7q0adM=
X-Google-Smtp-Source: AGHT+IHcK39upsRNfeww0Nhdi7fsHbCIo3cfyzT2OxVR02ItpHZsCmSkVEUAMx3AVIKlkFAeRSuKJQ==
X-Received: by 2002:a05:600c:3d93:b0:439:9434:1b6c with SMTP id 5b1f17b1804b1-43d515c6a85mr144495e9.3.1742510057479;
        Thu, 20 Mar 2025 15:34:17 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9957d9sm723190f8f.9.2025.03.20.15.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:34:16 -0700 (PDT)
Date: Thu, 20 Mar 2025 22:34:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 4/5] iommu/arm-smmu-v3: Enable pm_runtime and setup
 devlinks
Message-ID: <Z9yX5DmFy49o7Qso@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-5-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319004254.2547950-5-praan@google.com>

On Wed, Mar 19, 2025 at 12:42:53AM +0000, Pranjal Shrivastava wrote:
> Enable PM runtime for SMMUs having a power-domain during smmu probe.
> Add a devlink between the clients and SMMU device. The absence of a
> power domain effectively disables runtime power management.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index caf750470772..602784e84e84 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3515,6 +3515,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  		pci_prepare_ats(to_pci_dev(dev), stu);
>  	}
>  
> +	device_link_add(dev, smmu->dev,
> +			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
> +
>  	return &smmu->iommu;
>  
>  err_free_master:
> @@ -4836,11 +4839,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_disable;
>  
> +	if (dev->pm_domain) {
> +		pm_runtime_set_active(dev);
> +		pm_runtime_use_autosuspend(dev);
> +		pm_runtime_set_autosuspend_delay(dev, RPM_AUTOSUSPEND_DELAY_MS);
> +		pm_runtime_enable(dev);
> +	}
> +
>  	/* And we're up. Go go go! */
>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>  				     "smmu3.%pa", &ioaddr);
>  	if (ret)
> -		goto err_disable;
> +		goto err_rpm_disable;
>  
>  	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>  	if (ret) {
> @@ -4852,6 +4862,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  
>  err_free_sysfs:
>  	iommu_device_sysfs_remove(&smmu->iommu);
> +err_rpm_disable:
> +	pm_runtime_disable(dev);
>  err_disable:
>  	arm_smmu_device_disable(smmu);
>  err_free_iopf:
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 
