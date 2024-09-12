Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E912629D
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726114695; cv=none; b=pdGY7X2eCafPfNWUInKS07pz8bWPUBs4r9PRiAkregV3ZUZFvfebcq8M8lYWo+XrUjqPygQeF1lmNWu5sRGfL3mQB+k0x7MXu0StiH0DW+E9QC4V1mj+FcI+fn07Qn6hQ5RihgGcjrQr6OjAM+Aa5UziLK6qL/pfg2xkUlJHOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726114695; c=relaxed/simple;
	bh=ZDQtMMKUiZL3xipxRmpdhkUXy7XbQ0MmOjQTb0b3kwE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c/zIjjWQVSP1bZNUDcxCGCXMqYktsKbRS7Di5IEjFq6jxKbgEgqDetQwEPxF932FFro0rMUKx+BAytfcknY/jUOYD1Ooaoy7m8x2vEWuWVC38OkxzojHwx/gyirhrVKX+A7ZNGJJKoIL/w4tfVISl14mMLt5AMjn1FJe6cKwy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+WCN9M7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+WCN9M7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726114694; x=1757650694;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZDQtMMKUiZL3xipxRmpdhkUXy7XbQ0MmOjQTb0b3kwE=;
  b=h+WCN9M7JmFyl4LIasVseYkAae5tu4ZTui7r35TVbspj4BFAKBHNwY2u
   UlPT3a+CFeEUjGK3i3fZ6kdzKIXHvUNLg3XyoDFhB6wq3q8fgdy2Thpyz
   4uo9yZSYWAjtBF8ro0X2YND5miXMcdFuTL3oUxm/wseRPrKwdHtLPt7Jf
   /O3kHEpTBZJYLI8ezqJX76MDoTN77M7NTzsFUexTvhtnLFmksarueheLp
   njX+Gd01LndsVm1Wx+9+4C85QywVVPS0AqFBUX6FMjvYMVqS4CrV681Ok
   tT1qcdCN0ivPD7cAbYy6QYWL0S4JlIjzTZNBx/IyIYQx6VXx+fUcneeTS
   w==;
X-CSE-ConnectionGUID: IMtTglwcQj6l22PwxzTBLw==
X-CSE-MsgGUID: tWIGTs7YTO6q+pkI8ZmShA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28724937"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28724937"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 21:18:13 -0700
X-CSE-ConnectionGUID: e1e3hx1lR/u8xN3KQX8YfQ==
X-CSE-MsgGUID: 3mosQg6ARI6f+pQI2V1Z6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="72379190"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 11 Sep 2024 21:18:11 -0700
Message-ID: <a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com>
Date: Thu, 12 Sep 2024 12:14:06 +0800
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
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-4-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240911101911.6269-4-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 6:19 PM, Vasant Hegde wrote:
> From: Jason Gunthorpe<jgg@ziepe.ca>
> 
> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
> If both IOMMU and device supports PASID it will allocate domain.
> Otherwise return error.
> 
> Also modify __iommu_group_alloc_default_domain() to call
> iommu_paging_domain_alloc_flags() with appropriate flag when allocating
> paging domain.
> 
> Signed-off-by: Jason Gunthorpe<jgg@ziepe.ca>
> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> ---
>   drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------
>   include/uapi/linux/iommufd.h |  6 +++++
>   2 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5d1cef36f633..f3f1244fe90a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -32,6 +32,7 @@
>   #include <trace/events/iommu.h>
>   #include <linux/sched/mm.h>
>   #include <linux/msi.h>
> +#include <uapi/linux/iommufd.h>
>   
>   #include "dma-iommu.h"
>   #include "iommu-priv.h"
> @@ -99,6 +100,9 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   				 struct device *dev);
>   static int __iommu_attach_group(struct iommu_domain *domain,
>   				struct iommu_group *group);
> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
> +						       unsigned int type,
> +						       unsigned int flags);
>   
>   enum {
>   	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
> @@ -1589,8 +1593,19 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>   static struct iommu_domain *
>   __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>   {
> +	struct device *dev = iommu_group_first_dev(group);
> +
>   	if (group->default_domain && group->default_domain->type == req_type)
>   		return group->default_domain;
> +
> +	/*
> +	 * When allocating the DMA API domain assume that the driver is going to
> +	 * use PASID and make sure the RID's domain is PASID compatible.
> +	 */
> +	if (req_type & __IOMMU_DOMAIN_PAGING)
> +		return __iommu_paging_domain_alloc_flags(dev, req_type,
> +				dev->iommu->max_pasids ? IOMMU_HWPT_ALLOC_PASID : 0);

This changes default domain allocation paths.

Previously, the default domain was allocated by domain_alloc_paging or
domain_alloc. Now, it will be allocated through domain_alloc_user,
which, based on my understanding, is intended for user domain
allocation.

Thanks,
baolu
