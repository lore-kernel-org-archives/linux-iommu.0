Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC672156F5D
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729222197; cv=none; b=dzmHbv4TZuP1f5uJo5e+PAX2PGts7tyfCw/m7hW93GK9IRMSctezXXU32AcX4bMwguI5ZZ+Jv6OWdGf7f+P1eHiy5dULAJQn6odqppCW7CVDIod76ZIqYYW0VIhjOa7kAJ1HioKdDG4a3wjRr6k9lxkINZUQdbC5Sxpz0N/cex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729222197; c=relaxed/simple;
	bh=Cv/iYlqhMU30AVRnQZDeFN6m6U6RLcqkACaJPCrUlkg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SpUESxLP5ve474VgLb6DZuSnliX/qJoJM+WNVjlpIQv79i4YP4Zt2g6x8xWNVvoiTMGO4WTCswLTT2MLl6AlBDNHlC6k8drYwxOQudAw9vWSbZdYHPjJElS8J0LquGx5P0ZjmBPAEslTKzdC+GqCUfXcv9UWmpK16S6yCWvtFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JP3Du96M; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JP3Du96M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729222196; x=1760758196;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cv/iYlqhMU30AVRnQZDeFN6m6U6RLcqkACaJPCrUlkg=;
  b=JP3Du96M0ANt7Ooh3RMHKzs68CrKQFRH7ytuB7rlxhbY4SlDGnZHTPI/
   2M9gsgjpy6WwON/x9KxwhywGHZs5KttG7BNTOcceNJN7IPZtwrJuwLJQc
   q1XFKyT9mroXmnh0wwwVde+eI43Huhs+c1i0dzdR60fTspFAXuZKNcisa
   ByB5RAlaie+AlHflWnxTTUYbCIj1btogGuKtyQXmb4gSA8SZSYeSnAH3l
   QLxk65zP7elhzDv84C5VIwM69iybao8rPaxy0xRkWwi21DA87a8qhMy8D
   t6jQiKd39A7mTlur4H8+2hn0yYHzkgHEn7QtvQL52Pii/3anV+VKWSfnc
   A==;
X-CSE-ConnectionGUID: pQooSuq4TXyX+82cUIw07w==
X-CSE-MsgGUID: rXrCH+ArT1+jcgNIeAslqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28179873"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28179873"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:29:55 -0700
X-CSE-ConnectionGUID: /i5BgODfSyihwudPl7S5lA==
X-CSE-MsgGUID: 0VJF84CKTKawh9aW0wTjGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="83518154"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:29:52 -0700
Message-ID: <7b920612-b4be-40e7-b12a-ea6e19a74991@linux.intel.com>
Date: Fri, 18 Oct 2024 11:29:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
 kevin.tian@intel.com, jacob.pan@linux.microsoft.com,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 02/12] iommu: Introduce
 iommu_paging_domain_alloc_flags()
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-3-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241017140137.6028-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/17 22:01, Vasant Hegde wrote:
> From: Jason Gunthorpe<jgg@ziepe.ca>
> 
> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
> UNMANAGED domain. This is not sufficient to support PASID with
> UNMANAGED domain as some HW like AMD requires certain page table type
> to support PASIDs.
> 
> Also domain_alloc_paging() passes device as param for domain
> allocation. This is not sufficient for AMD driver to decide the right
> page table.
> 
> Hence add iommu_paging_domain_alloc_flags() API which takes flags as
> parameter. Driver can pass additional parameter to indicate type of
> domain required, etc. iommu_paging_domain_alloc_flags() internally calls
> appropriate callback function to allocate a domain.
> 
> Signed-off-by: Jason Gunthorpe<jgg@ziepe.ca>
> [Added description - Vasant]
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++++----
>   include/linux/iommu.h | 14 +++++++++++---
>   2 files changed, 37 insertions(+), 7 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 811748bec4b0..e13d64ffd14f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2027,20 +2027,42 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
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

Above works.

If we want to deprecate domain_alloc and make domain_alloc_user a
generic callback for paging domain allocation, perhaps we can make it
like below:

	if (flags && !ops->domain_alloc_user)
		return ERR_PTR(-EOPNOTSUPP);

	if (ops->domain_alloc_user)
		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
	else if (ops->domain_alloc_paging)
		domain = ops->domain_alloc_paging(dev);
	else if (ops->domain_alloc)
		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
	else
		return ERR_PTR(-EOPNOTSUPP);

Thanks,
baolu
