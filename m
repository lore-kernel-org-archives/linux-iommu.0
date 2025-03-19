Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8A215073
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427075; cv=none; b=IGHuZRkQrwPyCvbJ5qZYmwOxofGbSsE8wFeEVdAmvZG/MIrGaEjjq2my8XQk89lOfn911TlWfiV0i9ecqZVm2/5xURPJAwvjJQ2j2PA8XmESMbMnwigdQr/dlp2UIoL1JPnhI2ZfGaeJupIkRPwJiOWm0Ug3nZzDIZouO3OjWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427075; c=relaxed/simple;
	bh=e/aVP6eOTZsft9iFZcwXAD1XtErl4pGxkmwMBFfGLBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe0YRSimpCp0tsjV+gPihxsev1JrtuJK6asZK2OndS+dfa1xSIvjh2OwabAA28eDN5kfTU0EKbuNxGzTDpgHPpqO+Mz1JRwT43rSmZt9Xa7ZHlWcT1vKos5zMt63TIuzAJzo4pbny4f+ZwJDQF/4+i7BzV6FFWRpI4nmXf0BVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mZzs0yGg; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mZzs0yGg"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c55500d08cso25881685a.0
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 16:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742427072; x=1743031872; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqUvfgCQOghdtTuF5HGBJ7Mi+2WRJ2Z/XQlW4JgLaXg=;
        b=mZzs0yGgByHeRArn0FDG4PmYx0PbwrvDFo/eHgVmDl7gGC2C8jOHEi27KZgQtgIZz8
         3HQQYjmCxe0g1DiBChVkVR/pB4DMVtHScRkSFDBbtR5R1wu3LZB7BVlf2tjPfQLRtIjf
         /KUCypcJivrZe+BZvXijFTHX2WDm/rlPomdaw/Lda8JGshsneJnBO6C5ZNfWmKJqM+G0
         foByq3jGdI/y/6BWayAD8YpWAreD8cZILcog/+aVqH0ObaBmNoQhSIj+K5OXPL5FH7Rh
         oEcfUcEDWnU2htWy7uOdr7U65Nk0FQ+QcPseEqja+TCj0oYkavzqUHXZ4FQnH4rlsOTw
         +oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742427072; x=1743031872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqUvfgCQOghdtTuF5HGBJ7Mi+2WRJ2Z/XQlW4JgLaXg=;
        b=lC6Ru1q4umkhAA6OeFgwakJ+AsPkEYgmNEuzDshh1Eub6ZFxSrMdpC0FNbIbn8luJd
         YPCQvKTTS3nKrREGNd8xoDJvkxVF0t92soISUbQ1aOGchJuEhiixGLK9GC14IvrjcKnQ
         IOK8TnYAvPn/oTD6u2Gx6XPw8y/JDcp++XNlbMoIwT32XNk1SLw2xM/b0SkYrMdVkxAy
         ia2Mh/X8JLvHh+1KvQOiCFqDBDsqHWKvxSfhpcbocZ2AK2b4OEL1fDg4Lc5bKJxM/GIk
         vEKPDE5iIh9wA+uFWkzAzfej3dIjpdTVOFGD1lDSfP6dnUGqJoAEGBV9IOE4ZwKn2Vqn
         Et5A==
X-Forwarded-Encrypted: i=1; AJvYcCXzLyP3Cng2ehshU8zQUBYAGXJma1s5hitoDDXcIhvXoBdZ/x+LDORBP4W9xz/7IWannp25TA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFU7SP34ciuc+Ymkvzc1PDH/Q6N9pJ2GEbSr/LFOYdYW6dnAtQ
	SYk1RwUfga9oT/J6YR3Qgwe4JVJNnkFiT5Y47L23XI6/y+P/5WfDI3Y8vxhScfY=
X-Gm-Gg: ASbGncuJj5CBiM30b9Q08NXQnNTlHO/1epYILpiTg9dNOQHBBYxexM+pzRlcL1GaBUM
	VtCCa+2myzWnvucTCkoP1urW5gIKglN308Dt1FrtmF15/qgHLNOWSEdHplaYQJ8iwtViE5wi+Cx
	73+yrOLFcCivTXuAiFwxHejqvDTU8SskL28lrk/X8dVs/37IFAz1srAORFnS12AVd5t4NxIKD1I
	atZuyOUVoyHLl4yo8hgTOGp3t2BqFuCe4vYlifuwiG3MgTZl9F/VysYIAM/YtfCOCX5hB6AJCOv
	6g3bTgam6Rx7jxDTY32LKjSGfa43uHiJnbZZZpQNB6fc/Sgj8UOcnPQ2ZQp5CAYywutH+Z16EXV
	awLhiV2rHp4lODhCtyA==
X-Google-Smtp-Source: AGHT+IGNIMXR9mOReHrVF+QcyuezWXU/5MU0g6sktMSQ902CBz/Kbj5Gj4SCICqdqfl7AjCygX5vIA==
X-Received: by 2002:a05:620a:1a28:b0:7c5:47d3:10c2 with SMTP id af79cd13be357-7c5a84a2882mr665758285a.52.1742427072577;
        Wed, 19 Mar 2025 16:31:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573b3a042sm926026885a.0.2025.03.19.16.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:31:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tv2sR-00000000cc7-0ov1;
	Wed, 19 Mar 2025 20:31:11 -0300
Date: Wed, 19 Mar 2025 20:31:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
	kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org,
	oliver.upton@linux.dev, will@kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jean-philippe@linaro.org,
	jonathan.cameron@huawei.com
Subject: Re: [RFC PATCH v3 3/5] iommu/arm-smmu-v3-iommufd: Pass in kvm
 pointer to viommu_alloc
Message-ID: <20250319233111.GE126678@ziepe.ca>
References: <20250319173202.78988-1-shameerali.kolothum.thodi@huawei.com>
 <20250319173202.78988-4-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319173202.78988-4-shameerali.kolothum.thodi@huawei.com>

On Wed, Mar 19, 2025 at 05:32:00PM +0000, Shameer Kolothum wrote:
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 69b88e8c7c26..e157d786f295 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -47,7 +47,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  		goto out_put_hwpt;
>  	}
>  
> -	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
> +	viommu = ops->viommu_alloc(idev->dev, idev->kvm,
> +				   hwpt_paging->common.domain,
>  				   ucmd->ictx, cmd->type);
>  	if (IS_ERR(viommu)) {
>  		rc = PTR_ERR(viommu);

This has a lifetime issue on the kvm pointer.

Because nothing is taking a refcount on the kvm we are relying on the
caller to hold the kvm refcount for the lifetime of the
iommufd_device_bind()/unbind() which is creating the idev.

However, the lifetime of the viommu object is not linked to the
lifetime of the idev. So the idev could be destroyed, and the kvm
refcount put before the viommu is destroyed.

Probably the right answer is to take a refcount on the kvm for the
viommu object somewhere along this path.

Jason
