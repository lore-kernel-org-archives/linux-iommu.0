Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C47605B4
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129871; cv=none; b=muMks8BPafOVAUpddi6jUY7NShb0TfEbbR6nFLSoHkMa/wYh3OtYypN8BQYOirh0unpzkZGcy8CHPvaKOgDq452Xw3yXnwR/XuKzyiMZdFcLlb9qMUEgYoE8/lWTWd93wWFHk7weINTgT6plbgnp7f2DF30+TN+1cZ94SmCPLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129871; c=relaxed/simple;
	bh=B26xAHkjaWc8Ytd0vcrUSK8pxm6Eyu4Y89+p93t+Qbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k17ioNCA7VUqBmF/2rHPgG6Ck4UXqY7UazIuAuLMRkxGfT8uljwzXr38VeLZNPo0lfNqwSy0PSB/YfJ3a0uGZhz1Do4itDuIMZ64vnERGTaLVOFwxJAzYEi0BM1mrvvnTFGnkcVBS9RVUgLAFXH5wrWFPTWkxDgWdRS95UoeLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XV23DjkS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XV23DjkS"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4140eed8a4fso8235e9.0
        for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711129868; x=1711734668; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TD8wow2OS08EXkll41wG+2OWJgdRcKgoxTd9QmAS51w=;
        b=XV23DjkSGv9p4hU98vyhRp9ptYeAcLEiDUnOo4iROSMp2nonqTGCnZ69XQKyTNJSs7
         CDGNMB6SuWHCznjM7rboTACauHv6Q4cJ+3Uvy1MXR4J02kleHr72fw/+E+c3QKt3UsS2
         sYq7O3v3rE0i7/YCUqNdp+gl/LqqAf86FRrQaH3mTO93B+M93tiXhhOKpS6Zrhi7VRA9
         Qn+oeBDNG14bDvcpBMmkbAceRircBMN5lX7XNO6Pv6dXpx27M8xQTj3Iw7jsTJ6BDg+t
         JeH3Ui6X/d5t7sTr255rYpyI2OzblBdloVrWePulF2W51igfkCIfnx3VN7YToBcJnmR2
         ua1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711129868; x=1711734668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD8wow2OS08EXkll41wG+2OWJgdRcKgoxTd9QmAS51w=;
        b=JHFxdWF1EYxKQM0R9v8XT44jRJpWnG9pKGHSFcibZWtWpzhDMMuOeXDLazSd1EVJ0k
         Vk8FOxx8wEoOBodJJcF+c1fnP68MGfB9n/rs+Q/Fps/y3YMfvCLlAxBpCvecpIUnll5X
         6l4xYsd4XEazwR4Ifc1oiYaNNjEYq3Jzv04i0eG4k9gYLfMV1FF2tzlUZYOfnPErj5TC
         OxYuPsHa5t7ncI3Kf7/fQzTBqyoHYoznP+/mwL9c9gEy2meZl6NFiV+9XeE+aPiE+V1C
         2uLKxnKWQbUWokU5tiRSt+DyJnCLvFoF5EV7BnXZUvluOPqbRicFbnjAhCyZ/TitWeH2
         B7iA==
X-Gm-Message-State: AOJu0Yxgz6pF9NFVdK0NKqprYJcLutNqdps/T+XRccTtHm7SwItfhwfc
	zFOOKrU/7f78E0lGlkoVt74bxOi3X0X8zUivR7faGWrc9qhoON1bsJrbLh0OjQ==
X-Google-Smtp-Source: AGHT+IF+yj96IjCX1EMz/Pt0bDbPQTk6WDPsn7ok0J8RLbHozW2+cvsxJL8Ng4N/Lk7Z45oOH64boQ==
X-Received: by 2002:a05:600c:4856:b0:414:1400:a776 with SMTP id j22-20020a05600c485600b004141400a776mr499710wmo.5.1711129867768;
        Fri, 22 Mar 2024 10:51:07 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id a13-20020a056000050d00b0033e239040d8sm2527556wrf.84.2024.03.22.10.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:51:07 -0700 (PDT)
Date: Fri, 22 Mar 2024 17:51:03 +0000
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
Subject: Re: [PATCH v5 02/27] iommu/arm-smmu-v3: Do not ATC invalidate the
 entire domain
Message-ID: <Zf3FB3N0yjALqscA@google.com>
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <2-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>

Hi Jason,

On Mon, Mar 04, 2024 at 07:43:50PM -0400, Jason Gunthorpe wrote:
> At this point we know which master we are going to change the PCI config
> on, this is the only device we need to invalidate. Switch
> arm_smmu_atc_inv_domain() for arm_smmu_atc_inv_master().
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d1bc151a5dff8c..9e9233331c4636 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2447,7 +2447,10 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master,
>  	pdev = to_pci_dev(master->dev);
>  
>  	atomic_inc(&smmu_domain->nr_ats_masters);
> -	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
> +	/*
> +	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
> +	 */
> +	arm_smmu_atc_inv_master(master);
>  	if (pci_enable_ats(pdev, stu))
>  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
>  }
> -- 
> 2.43.2

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa
