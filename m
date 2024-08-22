Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59F79C2
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290935; cv=none; b=LHOtdtD4KchfEpDhnGiPXqeOpZizUehJCIWNH8fbHV0EXTnfmU4fTnXagBcsugiyCoyCXT1H0S2jCSIYVGLRBO4SttD0Syz44Tw2EkYuw14TMnBuV26gNE/MhzgCA9J8rFV1f/tzhb4hbU5P37uFgokmUHaAKSrJRyOuVUHiAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290935; c=relaxed/simple;
	bh=TVIKdgZOMxAM/s0RkmCn+Wbbueg36cnxTX3pSxyGzL0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OGd9/HqyzOE8WbAGMIv/kA/JWc/NNQbAM2GVaziCyF/bAflFE5jb+UkJelAqxzoSnVVYs4cJPilN/Q2hZqCfkrHjfid+fhn2VjhkxUHLLq8HjyxOcS8F/y9UnUdvwzUf38Sr9VQyYG0ECgMj9/DYoT4Tm+JTVhj3gQ6b0pq1m90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3jy4uPv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3jy4uPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724290933; x=1755826933;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TVIKdgZOMxAM/s0RkmCn+Wbbueg36cnxTX3pSxyGzL0=;
  b=T3jy4uPvua5qrEjMVYAiOWVs4O0K/GDFMrPbyoPQQRiLDfvJi7ruzjMB
   HMFTuXCu9StB1YcSFV9e13pufD8NG2YtjywbApl3zHmdkcyAnDym5Fbgw
   O/xbwE1WRAAZPxtxexRy2laC4CrToF20eM78oeBYjNANgeRJ7gKplk66U
   aEo7fsifMJAIr3EBNLNBV+qjmYxX6hGDqL0dyJZlAJAxuebmAX6uO64rA
   dmh4znI+pWh041qbesb+uXsQmnWqEzH85T/mkVff8y+3FdeU8vB6QVENW
   7mS4ds80lAIRbRiIXVo5JjrfcJyDvVTYaoNJ9tmABi/zQM843cwJrwvUQ
   A==;
X-CSE-ConnectionGUID: BbOrU+dZS7SeUUueYTKXgw==
X-CSE-MsgGUID: otpckCocSnCvh7//KDMNzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33251936"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="33251936"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:42:13 -0700
X-CSE-ConnectionGUID: /HyB/yvdTdCtJToTbY7rAQ==
X-CSE-MsgGUID: fhgeegHIQvquc+GU6bqwuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="65975512"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2024 18:42:10 -0700
Message-ID: <a85e4bc3-0046-46fd-91e4-bac451574d11@linux.intel.com>
Date: Thu, 22 Aug 2024 09:38:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
 kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240821133554.7405-2-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 9:35 PM, Vasant Hegde wrote:
> From: Jason Gunthorpe<jgg@ziepe.ca>
> 
> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
> UNAMANAGED domain. This is not sufficient to support PASID with
> UNAMANAGED domain as some HW like AMD requires certain page table type
> to support PASIDs.
> 
> Also domain_alloc_paging() passes device as param for domain
> allocation. This is not sufficient for AMD driver to decide the right
> page table.
> 
> Hence add iommu_paging_domain_alloc_flags() API which takes flags as
> parameter. Also update default domain allocation path to use this new
> API whenever device is PASID capable. HW driver should implement
> domain_alloc_user() to allocate PASID capable domain.
> 
> Finally introduce new flag (IOMMUFD_HWPT_ALLOC_PASID) to
> domain_alloc_users() ops. If both IOMMU and device supports PASID it
> will allocate domain. Otherwise return error.

I would suggest one patch for one thing. This will make the changes
easier to review, especially for those who don't have much context. It
might be helpful to split this into some smaller changes:

- Code refactoring with no functionality change;
- Introduce new domain allocation API;
- Introduce domain allocation flag;
- Code refactoring afterwards.

> 
> Signed-off-by: Jason Gunthorpe<jgg@ziepe.ca>
> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>


[...]

> ---+static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
> +						       unsigned int type,
> +						       unsigned int flags)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct iommu_domain *domain;
> +
> +	if (!dev_has_iommu(dev))
> +		return ERR_PTR(-ENODEV);

This check is unnecessary as you have already called dev_iommu_ops(),
which assumes that the device is iommu probed.

If you are worrying about the caller passing a non-iommu-probed device,
you can make it like this:

	const struct iommu_ops *ops;

	if (!dev_has_iommu(dev))
		return ERR_PTR(-ENODEV);

	ops = dev_iommu_ops(dev);

> +
> +	if (ops->domain_alloc_paging && !flags)
> +		domain = ops->domain_alloc_paging(dev);
> +	else if (ops->domain_alloc_user)
> +		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> +	else if (ops->domain_alloc && !flags)
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> +	else
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	if (IS_ERR(domain))
> +		return domain;
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	iommu_domain_init(domain, type, ops);
> +	return domain;
> +}
> +
>   /**
> - * iommu_paging_domain_alloc() - Allocate a paging domain
> + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
>    * @dev: device for which the domain is allocated
> + * @flags: Bitmap of iommufd_hwpt_alloc_flags
>    *
>    * Allocate a paging domain which will be managed by a kernel driver. Return
>    * allocated domain if successful, or a ERR pointer for failure.
>    */
> -struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> +						     unsigned int flags)
>   {
> -	if (!dev_has_iommu(dev))
> -		return ERR_PTR(-ENODEV);
> -
> -	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
> +	return __iommu_paging_domain_alloc_flags(dev,
> +					 IOMMU_DOMAIN_UNMANAGED, flags);
>   }
> -EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
> +EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);

Some external modules are still using iommu_paging_domain_alloc(). Would
it break the kernel build if you simply remove it here?

[...]

Thanks,
baolu
