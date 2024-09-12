Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB42C190
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726114137; cv=none; b=c5lovRUfDc/hJwV6Hgb3zSL1wSfk2HN8G0ML4JujnEB8TYYrm7qWO+nuHdvdKOAYLHCR3L3xt5lJ7w+y8jRH08hjKWJfW7b353m6O9g5efsgpyNRvNn+XSke9Cbn/ew0A2+dTczyKUv5sQihAhvw7nrgeizcSIJGwq5VryGfK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726114137; c=relaxed/simple;
	bh=ZVHr7b5EfUBAewUCemUI9XIEhKIRuMGR1P8URIuHow4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bbFxFQfltmq1WNHC3WArqscWtksph92RppEsSoGZLdBo+eapyEkqZar7TaB9Jnm7nFnP5f9f55wtg/ydid+lwORn2hxkkmIp+Q/rb/GeAMlBGaq2WnLGzl3K/Booqbej/ttDYGUayO02q3ij7CyUtlQqI6S0H4/5jKESRr92sfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5hy/YBq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5hy/YBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726114136; x=1757650136;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZVHr7b5EfUBAewUCemUI9XIEhKIRuMGR1P8URIuHow4=;
  b=e5hy/YBq+Aufwzrvh/ZhjUZ7ntRcAskZ32WZUJnVG3KhhpCBGrHiWbZ8
   c9J6h5EkUBTW0lD2NpsP/UqFXggq5982xZusEj819CLxInL/DqDry6kNO
   MPPuKlrHjWb6U3Z9wFoIOWmeRt8frMXyPYAaQxO996UNuNiQFcgEIZiDZ
   KOjokjrS9z77JzfvdDOi1s97aDetL9ESPS6PYUtxbB5aW9e2mdSFvyk+H
   L8dcqWGdDMmJtYciJxZK5gdMaRmKpYD0r5LCp5ZxZs6BV07NCoukyFjB0
   WoXc1ftXQm3Av50L9hQUmxGikEf867PiK3No+KjTsLwKkAaPUZ40+O9Gu
   w==;
X-CSE-ConnectionGUID: YEicyrFxQYWAvJbE7MCYUw==
X-CSE-MsgGUID: bZfulfb7RT22jEZm0dk6Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24766676"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="24766676"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 21:08:55 -0700
X-CSE-ConnectionGUID: RDRll1FiT7qH9WQP3goLgQ==
X-CSE-MsgGUID: dR664TqaSAaVWFUozPZ0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="72359091"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 11 Sep 2024 21:08:53 -0700
Message-ID: <2e2c18f5-382a-4144-9a78-29e3dfc973c4@linux.intel.com>
Date: Thu, 12 Sep 2024 12:04:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
 kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 2/8] iommu: Introduce iommu_paging_domain_alloc_flags()
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-3-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240911101911.6269-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 6:19 PM, Vasant Hegde wrote:
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
> +	const struct iommu_ops *ops;
> +	struct iommu_domain *domain;
> +
>   	if (!dev_has_iommu(dev))
>   		return ERR_PTR(-ENODEV);
>   
> -	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
> +	ops = dev_iommu_ops(dev);
> +
> +	if (ops->domain_alloc_paging && !flags)
> +		domain = ops->domain_alloc_paging(dev);
> +	else if (ops->domain_alloc_user)
> +		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> +	else if (ops->domain_alloc && !flags)
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> +	else
> +		return ERR_PTR(-EOPNOTSUPP);

How about

	if (flags) {
		if (!ops->domain_alloc_user)
			return ERR_PTR(-EOPNOTSUPP);
		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
	} else if (ops->domain_alloc_paging) {
		domain = ops->domain_alloc_paging(dev);
	} else if (ops->domain_alloc) {
		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
	} else {
		return ERR_PTR(-EOPNOTSUPP);
	}

?

> +
> +	if (IS_ERR(domain))
> +		return domain;
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
> +	return domain;
>   }
> -EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
> +EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);

Thanks,
baolu
