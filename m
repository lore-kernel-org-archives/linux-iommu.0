Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B1163A9B
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970868; cv=none; b=KsdRwSw2ah3RzHp5ZKYlCiMItnwhd4SVjjt+pO67Xroi9aZrG2qckw3lk4iXW9XhF2ZwHiQvOK4lCoD3JXwefOzB7IB5OT6IuxnN8DtMbd1h4c9KbI8JKrCzprTP+HTrQt1moSHOlUZYPkJ+XIbsw8I4qLWmCPU7a+hQ3McGfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970868; c=relaxed/simple;
	bh=GvQlmrtOsIq9NPc29uY9RaT1100f0FwdAhRIUUBDucs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkCCQsurXxIN+4o1W5EGdLktNT/vIp6z2q0u3GdK7TuPQaouc3aBg1MoDDn0qh07Zcsd/PVAIpvT6UTlX5ab2moj127/6CggSTa2thRW2dR6+Y0tU4nfobXfzOMeIAdOyWqMR3tkjc7Qu1cgEokvKhm7MytevlOb+COnRA2Hi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJM5FBf6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJM5FBf6"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e73359b900so18380891fa.2
        for <iommu@lists.linux.dev>; Wed, 29 May 2024 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716970864; x=1717575664; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NlPH0P994GSLr65I7MtbS6ikre4n5vkaipn9KH2517g=;
        b=QJM5FBf650j/Pm3DGpOTcGAjlJ0To+dY8S591fj+5VoSyIUvlKJI3Un4F4m0IOeyTG
         9IJKXQPcBt24oA5pUw8almSj2pb4UJKIDlrBAyA6gUngjiPANV+KjXQ20pp6MvlFWElG
         zqYq67STfLrrVoGuHc7ePvmaWBtdEJQqbz0QT/UdNWvrxzmD8JZzWWFAOcCjP94vsDzo
         xVtbDQrF26St3lev3dNflESSV6BjYMVRvWCTSpy6NXcHUQjutTjQxBly/ksISxJjdJAa
         DM6MkbFzgkW5ntZOn7HLjFYCw8vgaQo9eCGJNeOnG9/GDiPolEpx4iiM07cEdYEF8pN9
         IeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970864; x=1717575664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlPH0P994GSLr65I7MtbS6ikre4n5vkaipn9KH2517g=;
        b=nQAMC4fJ4wJ42tf5phkjh7xhXA48Bfp94o0fckjhXvOChOPjcUb8oXfIFWtSHpnOT7
         rRVSolUiZaTCqiA9bEWzzp74cea4F8cwXkzWY0IWYb4Hp+bZudKhD/tfozAWWBn1vVoz
         WGGuSyTySSjuJEEW9pbK6nfbQ/St3RzbnCq86LrF1uF37vH0/CQUpIRlHdIL8J2Erjv4
         qZNLoKMLIVBSfeCngvumz1EFy4gcpZvR/3o3hIpXc1d+lDu2Q9jXd7KC3HyXMN1ZNKvW
         kxhy6ZxCkImKmeWkwJDzOiAbcDe9/aqf7mpEu1LVDmyztulfow0NA1UWz9HwHDGjMr7Q
         EXUg==
X-Forwarded-Encrypted: i=1; AJvYcCU5pBaSs8l4awUb4lyS3D63f7l903oiBxpnCBnCuX9Cb6BpOso4GJ1CounOhPWi81bMn1Vokbox+dNjZY6n3421iC8/bcM=
X-Gm-Message-State: AOJu0YyDsSuIPxE4hGF88JzoQ3Vp++nh2fmA6XipPpbeU1qc6KTmxHAp
	T/Ca4yjI+vmmX1FYs6Au8FEH5+h7T84gO8iiaJnsf3hS2K2eypOmZc/EHrDfhUI=
X-Google-Smtp-Source: AGHT+IGHFRFnp+MyYG+YuWo3CGNhxr5zVQkELmm+9aSx5PbZeqdQ7lHk7UJdLwxeRsOL0b9TVbrimQ==
X-Received: by 2002:a2e:99c2:0:b0:2df:e0c4:8429 with SMTP id 38308e7fff4ca-2e95b0c22abmr100784511fa.18.1716970864023;
        Wed, 29 May 2024 01:21:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc48c8sm25085331fa.14.2024.05.29.01.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:21:03 -0700 (PDT)
Date: Wed, 29 May 2024 11:21:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com, Jason Wang <jasowang@redhat.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] drm/msm: Use iommu_paging_domain_alloc()
Message-ID: <jd7df7jshswukstxwbfoxuswyltyemdmkx272i5mpldlfsk4t7@ad36olyvmw27>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <20240529053250.91284-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529053250.91284-7-baolu.lu@linux.intel.com>

On Wed, May 29, 2024 at 01:32:36PM +0800, Lu Baolu wrote:
> The domain allocated in msm_iommu_new() is for the @dev. Replace
> iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
> 
> Update msm_iommu_new() to always return ERR_PTR in failure cases instead
> of NULL.

Please don't mix unrelated changes, because ...

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index d5512037c38b..f7e28d4b5f62 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
>  	struct msm_iommu *iommu;
>  	int ret;
>  
> -	domain = iommu_domain_alloc(dev->bus);
> -	if (!domain)
> -		return NULL;
> +	domain = iommu_paging_domain_alloc(dev);
> +	if (IS_ERR(domain))
> +		return ERR_CAST(domain);
>  
>  	iommu_set_pgtable_quirks(domain, quirks);
>  
> @@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
>  	struct msm_mmu *mmu;
>  
>  	mmu = msm_iommu_new(dev, quirks);
> -	if (IS_ERR_OR_NULL(mmu))
> +	if (IS_ERR(mmu))
>  		return mmu;

NAK, not having an IOMMU is a poor but legit usecase for some of devices
which don't have IOMMU support yet (for example because of the buggy
implementation for which we were not able to get all the hooks in).

Please don't break compatibility for existing platforms.

>  
>  	iommu = to_msm_iommu(mmu);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
