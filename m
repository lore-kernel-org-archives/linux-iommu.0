Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD5314A98
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642315; cv=none; b=HVnEjukORqdVciKyPYMCACVFcRRnrqmqhoHQMzUS3XmiLBxgfCiXGzhQqHuts5dBNDSI/k9D7pGbfvBkHyoVEcK3zCGnIpYW1nGUgEY6mZa9qCZK3+jKK6wrqNH6JrDz3pxoiw7x4G4VyJYrI0p47YXFEkRVVo8BaJqd1xTNmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642315; c=relaxed/simple;
	bh=yRbsaIenMXgEK1Gk4AsMIjbJDs3Ig22fD+PcCY04YF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdBK3p2tHD1eY8Ovke3jxCf89eC6ElWVs/qV27FD5FEZylalMbfQbKE6CMhBfdRKfHaPtMz4130d6mcmgGhht+o9AH0qSc0muooA2+s6RIl0aVO09ev5OShn4BtkgDZz6BB5flDNqmIg063ZZTjKGMmzoHfSmGU5oqtlMVeycsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMwqKFfX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMwqKFfX"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so18905ad.0
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 13:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781642313; x=1782247113; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQz3Sw9zxa6xC6R+gWy6vC8YGv1nZf7Z0czKC6/lgYU=;
        b=lMwqKFfXhWXAHySJi4AWCJXSH8jPqKohUZX4i0ipWLC12N8a9a1CFAFQqLzBgJTNKy
         k05a133QpmD/c5j1jOaFW86NKP5s92L3sSAaN5J5jiOmGMoDev64QWqjir6zbUyUkx6E
         U3DRXk7bAYdjySOkIk2zKk9LJf+kuvD8RCHBHPLPogo1Ol+8WyLPO8Iiiav459qu0xnc
         atVDsbYtOVAfgDG2tyo9RmHqSH7HeSfzEVXUFcHjBIN4rZIVBIVMUmpDyiURkv5TV4ld
         tl/Qj6vIA/GE8K4H9Xrk5HE1XVBNyLqhXY11GgiUANMB4uWOcD4T8txOQ9qILczYEyuc
         hliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642313; x=1782247113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQz3Sw9zxa6xC6R+gWy6vC8YGv1nZf7Z0czKC6/lgYU=;
        b=P2RqsHfJHMvjPAXUR3YCQ5YSZNAVPmqZ1G3wMaupLhaY3fYkhWj0688bMT7eshK95s
         14p4Z+ycBkig/G2Fh6d98EXjARMkENnMcyec8KvWQOijUex8aXIjsCf6GDHQWdfyxxwY
         7Of4orWwXGLhgTY9mNvBLlWtfS2nzEQ/2P8S6md9oJ0mDIhvk/JJQ4AFowpe+Wi9gq7t
         fDbrIpzxAiG3ldt6uTyWkyD6nqQVk3pN8SNNYxJcbtAl3T9eZ6YR4/RWo3zoJcSAnmw9
         rPNW96gG3CsMp7FTTX/NSgYBzlHIkIM0NHdnUY5HPaHD6m9sjAtYnyvCZa6gEhK3D0V6
         KxLg==
X-Forwarded-Encrypted: i=1; AFNElJ/lbhBSVEXmB2k33F2XbVUxgYws8qJO655kJAGU/8TNPIKw48AUWueOD04894vQGkaapI2pRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJCShEWW02VNQwHYb+coXn2oYYiUgb88p2HRPip8VVfOhCuCXk
	oIVzlHkTzY6DXlxTdiL1dL/xmPF3NddojVqN/C2L2s8aZ/Q2qyhy9S3RmsNSy8bIxw==
X-Gm-Gg: AfdE7cmtMi8rXx2rZPNrEWnUYcPyo55K4TRzE7y+kM63eyVzbhP4UGAKHhcKN3L6NeJ
	xOgQSDr0POarRGmClAHMK3RSXiRHi706DHLfzZnPu8beqE0y7/k8Kb/xogmrc9Wy+I0JK49BExl
	dnXA2EICMyjPjqPIwLwN+HZhMCF2goiCLuLDtP9kVb5rNW5ulnbBMDAy4RfmE31sgd58nvJ0oIc
	FExTN3W68j+vxc5fZJx0WTaspm7bbjvx3zlvmZEmdoQbjg7mIfHrtsIwO8CIM2RSIRfuLCblIyG
	B9DG2B9V8btVEXY0P7IUE/1J+Z4LKeMg2Uw4Uxv9g/t5yyFECWO4fFGbW/ynKokrkq2CYIdHl3Y
	TzfH9MEELyd8jw5lYYRTVNfvlJckSCuDNVgDnNfDqcwwiInIFVtSiTkUsIVL1AcwSo+NPJf9iwt
	CNceycvE9FeVBRcbDHnR4+uGXMQj5v/6svIAnu5uMxfIso4spPvvSjNlrOgICQ
X-Received: by 2002:a17:902:c94b:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2c6bd3ddaa6mr167145ad.11.1781642312500;
        Tue, 16 Jun 2026 13:38:32 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521aa047sm4812201a91.3.2026.06.16.13.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:38:31 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:38:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 3/6] iommufd: Allow binding to a noiommu device
Message-ID: <ajG0QK08xQ0SaeVv@google.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-4-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611172658.3421138-4-jacob.pan@linux.microsoft.com>

On Thu, Jun 11, 2026 at 10:26:55AM -0700, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
> a dummy igroup for such devices and skipping hwpt operations.
> 
> This enables noiommu devices to operate through the same iommufd API as IOMMU-
> capable devices.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

[...]

> +/*
> + * Detect a noiommu device for the cdev path. We check dev->iommu rather than
> + * using device_iommu_mapped() (which checks dev->iommu_group) because when
> + * both group and cdev interfaces coexist, the group path assigns a fake
> + * noiommu iommu_group to the device. That would cause device_iommu_mapped()
> + * to return true and hide the noiommu case from the cdev path. dev->iommu is
> + * reliably NULL when no IOMMU driver is managing the device.
> + */
> +static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
> +{
> +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->dev->iommu;
> +}
> +

Helpful comment! Thanks :)

>  static void iommufd_group_release(struct kref *kref)
>  {
>  	struct iommufd_group *igroup =
> @@ -30,9 +43,11 @@ static void iommufd_group_release(struct kref *kref)
>  
>  	WARN_ON(!xa_empty(&igroup->pasid_attach));
>  
> -	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
> -		   NULL, GFP_KERNEL);
> -	iommu_group_put(igroup->group);
> +	if (igroup->group) {
> +		xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group),
> +			   igroup, NULL, GFP_KERNEL);
> +		iommu_group_put(igroup->group);
> +	}
>  	mutex_destroy(&igroup->lock);
>  	kfree(igroup);
>  }

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
