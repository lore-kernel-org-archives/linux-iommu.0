Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66C1AB52F
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687568; cv=none; b=MVTBLEL9E4g8EHs+edXAi92ndhDNaoRkOP1NnXOzEUa/rYFkLVzhIqPe8jXBMyDDlxJm0oLFwEK3QZyiI/jmYLznVG6rfJD99Bar7czHiGB2yxbuv+9e4kiQhjbNXG95CmwT8WBzHB+sWBb0fcMBYqznX5bPCXQLe8NBtdioua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687568; c=relaxed/simple;
	bh=N/DS2UPuDFxY71af1hp1NKD32f7hQfM2pZop9wqcd0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/cKfaGzQWYJYs0kCPBfZqIQX9q+LJDzujG7bILmsobHQtrV3mvPC/sJ443NEMlSKuQAnCg7sFpjbjxspiu6NjgHOtndajbRK6RfjZMGkOxyBx74ftfB82CQOF0DPuHJmR8Sl4ADAbQUy+VlILz3sfA24CqoSOHIoSrNx4omhOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dRiyJDsG; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dRiyJDsG"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b1539faa0bso442873685a.1
        for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729687565; x=1730292365; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wl+qgnogUkN5MEPeYkB7yoKN7ziZfTYq1MNIIp4EJoU=;
        b=dRiyJDsGcTv9A6V4szzVHWx75kHKMABrgn9vnPsCkSHFl/bCJz846wQbhseL7covfj
         d46W6pivuFAClKc5XSTNz2muYJA6z9uVX+m8E2m87dfjxud/33fk3Zc6r7VoKRhRI3Re
         6F/62o/HlnLNmhWKF0hgMYiaErO2k5IJqROJg/QcZg8P3sOtGr05kfVN3ib/Lco9+4yK
         lw+Re/GeYxqNT3CaX9F4TflhcNId6wECoTJ+E+U4VrsJW30fdEWO5uvswNTuxLTNs3Uc
         aHbsUO1E0gfgWhWcpCINSgJ90aM47vbt61T2dqlOT2q9m/eKngrp4E1ecppoWVH2py9p
         ylXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729687565; x=1730292365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl+qgnogUkN5MEPeYkB7yoKN7ziZfTYq1MNIIp4EJoU=;
        b=lI8pRAIgMSoR5KBKT+wFicO62CFkBq9sT+aOI4DrCrS24UzvRvjcb0RE8Su+gw6u7/
         tx+av0ANolzfu4RLasb+KRcT//n/5Y8+euQ+zXeQDm1NBr5X9YFrCzqekeOosj2DczeJ
         sJZWD/Ylr/gvDkib4yC/OADyEbCyWuY9gj99StkN0EWmQEN6H8b3C8+QFM7pZqp6VXFB
         Bgc+Q2umnUh7cKXcCe11Co81KezhsqrkIaxzVJs/NUpCywpbEUx2Rm/5lwOq9oG3CdDP
         9KkOAHX0z3GtvFnPirr1g/nIxBAuV1fjEcM5QfFnl1sL8DT/AYNAUbYl8u5/Eae1gLFO
         IPJg==
X-Gm-Message-State: AOJu0YywqonH7eGXCFU9EWpDGyBaA8zWTOiyOrtKN8Yjp9njmGKAMy8E
	acb4/M59x0BBwf+yJd9I+gI92wENWQwAThwzzD4HHx6szjL/UFBN2oWQtImD5sM=
X-Google-Smtp-Source: AGHT+IHh7jEs6XJHX7y5Hfc9fLKrGq5NiwJrviB+n0Wu2wHVs2AJ4BroMabT7c0fu7ouwA8JGwbZFQ==
X-Received: by 2002:a05:620a:1905:b0:7a9:a1b5:26f5 with SMTP id af79cd13be357-7b17e56a0e7mr376115485a.26.1729687564922;
        Wed, 23 Oct 2024 05:46:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1659b9335sm382376885a.1.2024.10.23.05.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:46:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t3akV-007dkm-9c;
	Wed, 23 Oct 2024 09:46:03 -0300
Date: Wed, 23 Oct 2024 09:46:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v4 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
Message-ID: <20241023124603.GC13306@ziepe.ca>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023104207.5894-10-vasant.hegde@amd.com>

On Wed, Oct 23, 2024 at 10:42:04AM +0000, Vasant Hegde wrote:
> Previous patch enhanced core layer to check device PASID capability and
> pass right flags to ops->domain_alloc_user().
> 
> Enhance amd_iommu_domain_alloc_user() to allocate domain with
> appropriate page table based on flags parameter.
>   - If flags is empty then allocate domain with default page table type.
>     This will eventually replace ops->domain_alloc().
>     For UNMANAGED domain, core will call this interface with flags=0. So
>     AMD driver will continue to allocate V1 page table.
> 
>   - If IOMMU_HWPT_ALLOC_PASID flags is passed then allocate domain with v2
>     page table.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index cb6a72564c23..cdc93c794eff 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2403,10 +2403,26 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>  
>  {
>  	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
> +	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> +						IOMMU_HWPT_ALLOC_PASID;
>  
> -	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
> +	if ((flags & ~supported_flags) || parent || user_data)
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> +	/* Allocate domain with default page table */
> +	if (!flags) {
> +		return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
> +					     dev, 0, amd_iommu_pgtable);
> +	}
> +
> +	/* Allocate domain with v2 page table if IOMMU supports PASID. */
> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> +		if (!amd_iommu_pasid_supported())
> +			return ERR_PTR(-EOPNOTSUPP);
> +
> +		return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V2);
> +	}
> +
>  	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);

This should be more specific about what the dirty_tracking
configuration needs:

	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) {
		if (!amd_iommu_hd_support(iommu) ||
		    (flags & IOMMU_HWPT_ALLOC_PASID))
			return ERR_PTR(-EOPNOTSUPP);
		return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
	}

	if (flags & IOMMU_HWPT_ALLOC_PASID) {
		if (!amd_iommu_pasid_supported())
			return ERR_PTR(-EOPNOTSUPP);
		return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V2);
	}

	/* If nothing specific is required use the kernel commandline default */
	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA, dev, 0,
				     amd_iommu_pgtable);

Jason
