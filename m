Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D213FD9B
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487310; cv=none; b=Wvk9326JJToW0DWDxoaPnplg0rmb+TMp1tte/a4VukZgQEWjDpxDmNLhMlaefBWJ3ERndHXRQW2grqx/JFsRxMTSSXoVKF+oo6fu95i35/O2Mpbz8DDRQiVUYyur1i8K8w+J0ytlLOr5O/CCWgTMkt1Rx+Lr2DEZ2qz5qRsYGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487310; c=relaxed/simple;
	bh=vCitIq86zHiouZSAKcvxwEFguJ/k1OQJuGOVFY1W6dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1JBfhXQyi4fdhcYH12uvbiAw6kTbmf48Xwthc0gOoqY78T6ugb4FVO4OzOlhnt4NU1QC7mso2Pb8rvqJdM52vLbtZxDT08K2t8MfpJBjC2Lbj0x/Lb+xESnbopQQO+RD0CoxW7BX3SQQmN19V2uIPbKc9KdDx1gsMX5FrJ7BcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fm9v1zLK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fm9v1zLK"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so36962771fa.1
        for <iommu@lists.linux.dev>; Tue, 04 Jun 2024 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717487307; x=1718092107; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlJzONumJ7hGmF7Lx8HSrbgepz7pi58FM6gnNMiUIJU=;
        b=Fm9v1zLKEe5vE8iCsOVA8ykl2zTKuUUEFPZTeBtZyKgHwDsjA/aYSVcJNrn42Cjlv3
         O/3KuFewtOgqvXw/hBj5Qnb7lVaax5xnb/ykzwkK6SJk4/uui6ufqwjfNtzhv+YOgO4N
         3d1dPg2eTlTOFj7F3yd2YRCxozQvIBEV801HgGqrOYROmSO3H6TSnYM3dfQAZtwcaRIi
         uYw2CGQaHi0DW70/aOmjkb910CyBRUpnjm9wjs1wfjbNIac41J7pPtyEBbz7IvspALJ8
         dPIrboEz2ZA3WYAldv5feZPTJCZuSLm3oM7arNtXLpUKUccpQlKWDcp644NZLMGTwrkk
         sBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717487307; x=1718092107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlJzONumJ7hGmF7Lx8HSrbgepz7pi58FM6gnNMiUIJU=;
        b=iTwOOHQ8J1oT8DETPzRhStz7/cereOaG7ptDmL1R2gB6lcVmTA9rMwnOjr+h0jW3Rp
         Zx5awuwXhO/j31Bz7RkCJrCWazJuiP0IGmwVFAsr0jLp2k14bZEb2IPpl8StRYxKJ+vz
         sQGhQSRS6o3wDQN+kSB+wsct/jruznvZkEB6mOD4O7oysJj2/W6gbleyCmNZEDwpRH0Q
         R2zxdTSv0E9LFr3W3vBCnONPo1aq+6bK0HOXLEyozIkl264/YKov+tfYaMtXXtu4ALzm
         tHo4R1TsuXjb9HycSwRPwEdq5lofErkmdC8hQLN1+ZI7rYRwbs5liKPHURYNg8e+GG7j
         KYIw==
X-Forwarded-Encrypted: i=1; AJvYcCUtlK7kndWv8PwA+3nHNW49XutPw6TJK5UVmyA1Fe5SpudZqH6DJVYVxV2JmQt75qAztFIUgwgFaABm/fYL3tFUH2/mH9I=
X-Gm-Message-State: AOJu0YwRBqX87bEIcDVCy+q4mhYBybasxSy9sSqAeZM39E/NPZ91+pB6
	Nn0XuIyH9S2uzIohWn0SowwRNxzRBIdIUc1NyxZzDvXL9M5GPjRmPbK9Ku7cRPI=
X-Google-Smtp-Source: AGHT+IGqL1YJgziLvhDKlAs/q9qv00KwD6G0YPzlvyHwSRHM2CF7Ig4MUCHZdylu6wx8bzJ0XpEuCQ==
X-Received: by 2002:a19:9110:0:b0:52b:8417:fa95 with SMTP id 2adb3069b0e04-52b896b6e1emr6758126e87.41.1717487306746;
        Tue, 04 Jun 2024 00:48:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ba4c99cb8sm142098e87.62.2024.06.04.00.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 00:48:25 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:48:23 +0300
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
Subject: Re: [PATCH v2 06/22] drm/msm: Use iommu_paging_domain_alloc()
Message-ID: <zm65wqngmcji4t4ox6ak7il7p5beup6a2yidytp376gbxkfq2w@duieucwqwj6r>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604015134.164206-7-baolu.lu@linux.intel.com>

On Tue, Jun 04, 2024 at 09:51:18AM +0800, Lu Baolu wrote:
> The domain allocated in msm_iommu_new() is for the @dev. Replace
> iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/msm/msm_iommu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thank you!

> 
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index d5512037c38b..2a94e82316f9 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -407,10 +407,13 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
>  	struct msm_iommu *iommu;
>  	int ret;
>  
> -	domain = iommu_domain_alloc(dev->bus);
> -	if (!domain)
> +	if (!device_iommu_mapped(dev))
>  		return NULL;
>  
> +	domain = iommu_paging_domain_alloc(dev);
> +	if (IS_ERR(domain))
> +		return ERR_CAST(domain);
> +
>  	iommu_set_pgtable_quirks(domain, quirks);
>  
>  	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
