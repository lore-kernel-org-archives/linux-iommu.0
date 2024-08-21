Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE01B5302
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255844; cv=none; b=L3L7fxssiDiuAK8Ud9mkf49AI5b+l/a2d+k6GrikP0A9iSGxEwV6EnZYEHmm1SVSUGDcv96O0E03a9dzpCILcvNSYqK1kQterA5NGSY9aNFczi11R22GJSqwj/SwMV4GBSlV4qYFELhtUsrEio4q/ENhYGXeVttzY98scThK7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255844; c=relaxed/simple;
	bh=UeONmyymiYsE6RZzQIKm7lLALiChnLhL+oPI3OcT4ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDYUtPJGCQkIASLFHkvAI49m0OSm8dcptJwfoGris5udW2tCnIiHa/JTjajJlWIl2llYRu32KDZuzBBz5GUsig2Ee439hyXPkVQhCn/4JfxUaqb9RlUofYMPGVPvqQoibW4zwuuVbMtKX+M8g/D9UzMdysktmeg/V4Cuxw4KphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WJWe5FM9; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WJWe5FM9"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6bf9ac165d3so19610376d6.0
        for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724255840; x=1724860640; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XjJ3pUyPvbVFiijkfvnfU789ugHJYjT51iGt66I0rPc=;
        b=WJWe5FM9Uj58ue2GwEclgtjqM3uxZMbm7Y+pQTHkZALnuKBIgoGsblbE+C5U7GSWhN
         tYHko+XPbPU+OL+ESLSjzh43XA/yLSJWJjssN4qN9xzeLePJt21FaSKQS58A5b8HGTs9
         1zARJD1MX76VXuoCkpwkLSGRa/DqrEVH5s8/s6GIes0fgswsDeMF+96EgM9GgtS4KnId
         CF58qpIRdae8IBnpPobzlKWEAUxYiVKWGY6HkQdoWBguTtriWT3QOhgoU22fmeoiu0uf
         RVx36FlVFyg5n+6QVk2ihfDnkxzCjlV35P4DzATrSBAXUP68inSHLBN9Zb71aUiAjMUK
         g4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255840; x=1724860640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjJ3pUyPvbVFiijkfvnfU789ugHJYjT51iGt66I0rPc=;
        b=Fhj0Qwf1U6X9WJMtL80CX1C5eSI1ZtO0lfk9iki1XX07YEa/Tqy0zZbhHzznv81iNj
         EiJAWeQYAmtH/15VM7MN3DbwzdBDcxncVbky2ka7O9NiLdLBNoSLKE/fQdh+yOQgWzZY
         UC6cu5PUrFCxgxQmNCFjxKECB4NUD3iw86OZ2hoIqNmkRjwG+Zcs94bc9rLCgkkjXum4
         2Oevh9FjE0opBCDFPunKoXte0YDo0/7TEqTfdzv0sRaXflPJ09GrX09EgQAJpFKKMeBm
         ZQ+qBlZhtSk5Va2q8etobAkfgeRLvie3pCBHxYRiy4TuwThYLcoLgi/poDDDHhDOt1Qw
         4HbA==
X-Gm-Message-State: AOJu0Yy6/uLhHtvEfdGbA4JK7x/Wx8YnJejbLdd8kS2ZxhxbrwPsEQ8w
	74iWf8D2gWCJ4iHHkDDYONIsah4pHBxAYEBAkRLH+MoVinBvFyqBIjnuuFruc5E=
X-Google-Smtp-Source: AGHT+IE/hUiSP9fhX3bPABaUPLwME1q+pnoRjC/7lZvrg18Mi0QHjcZn891aYLGTescN+BrApFX2TA==
X-Received: by 2002:a05:6214:3d0c:b0:6bb:bcfd:1905 with SMTP id 6a1803df08f44-6c155df1370mr30839256d6.39.1724255840446;
        Wed, 21 Aug 2024 08:57:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec604asm62564076d6.77.2024.08.21.08.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:57:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sgni3-00BMlM-0E;
	Wed, 21 Aug 2024 12:57:19 -0300
Date: Wed, 21 Aug 2024 12:57:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 5/5] iommu/amd: Add iommu_ops->domain_alloc_paging support
Message-ID: <20240821155719.GY3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821133554.7405-6-vasant.hegde@amd.com>

On Wed, Aug 21, 2024 at 01:35:54PM +0000, Vasant Hegde wrote:
> Add support to allocate paging domain. Note that core will call
> domain_alloc_user() to allocate PASID capable domain. Hence its not
> checking device capability and allocates page table based on
> amd_iommu_pgtable.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a4e6789f0487..7bd1ce5469ae 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2437,6 +2437,12 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
>  	return domain;
>  }
>  
> +static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
> +				     dev, 0, amd_iommu_pgtable);
> +}
> +
>  static struct iommu_domain *
>  amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>  			    struct iommu_domain *parent,
> @@ -2879,6 +2885,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
>  const struct iommu_ops amd_iommu_ops = {
>  	.capable = amd_iommu_capable,
>  	.domain_alloc = amd_iommu_domain_alloc,
> +	.domain_alloc_paging = amd_iommu_domain_alloc_paging,

Can you include the identity domain conversion too and remove
domain_alloc entirely in this series?

It looks like it would be pretty simple?

Jason
