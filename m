Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906725464B
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729222990; cv=none; b=ndWQYqa2C5/oMqvmNaQWlrgBbo5C5Ruw4jH5+z8pA0yTcLksOtE++9qeoDvHWhefbhtPv4tIhGhtoUgalOOnzvO6B1Ud6q4A6YzMiSM+C6EABg0dICEdTg2j/4K1PjsVcD6kko5U0OMZXGpxT+8j3qjB4eL2EG9EgOmr6vLK8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729222990; c=relaxed/simple;
	bh=wkiZI6q5ShYcsrTcODdgfVkpzQb+Hb/8XCi8r4xaaq0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PRqtGIf753G4jl1UazOMijkg5nrv8Qi5uXfyJutwUMOnCYXsgmNkx/vzt5P4ha/9afI56HvWKeWNtpInsfY+ubEClLPr6k+GezgbzmrrrKJXkxHoD69dysHS3hbYiIoVeWJbLpOOeYdMPd0rMEr01mG5gjsNWe+MM41OehnUWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYW2frXT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYW2frXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729222988; x=1760758988;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wkiZI6q5ShYcsrTcODdgfVkpzQb+Hb/8XCi8r4xaaq0=;
  b=bYW2frXTjGvwVQPApx/ZTi68QVe4TF6bgnQBUVPqzzs02b2lOCi/p57P
   RRYjPVS9k07UFfAeEbWsQgft0Rvat6P4tKI9H2o0IgU8oZP5vWflNX+ib
   Gg839ulFeFGEo3FPvzfPgGtw+jtdyYZGlD9cNyL9ImJrwQix9afQp0jFW
   n+v7G3HEkw0YcdKaJ8mYwwcbQk70Y6lhNHKWkfufqBwT5ePGQySIqd1zo
   nGElje7PfX+fcKis7zuzMAFqwPZMGmxRqoiu1nc6TJ9aqZ4qlzDatO44s
   K9L92W+J6TBov06gk8etY/UlKEoQMXUm5cVmxMs1HSSCpmSd6D+WNEUDH
   Q==;
X-CSE-ConnectionGUID: Ty/IbrqPRaOrKrnRucLpgA==
X-CSE-MsgGUID: jxqcQS84SXaAw9lu8wQKlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28180497"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28180497"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:43:08 -0700
X-CSE-ConnectionGUID: VHX/zP3TRVGZqO4dWQz90Q==
X-CSE-MsgGUID: ADxHA9c2QeuGTU/UFK+tiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="83521510"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:43:04 -0700
Message-ID: <798b486e-ec49-4f51-89d4-a2083bdaddf1@linux.intel.com>
Date: Fri, 18 Oct 2024 11:43:02 +0800
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
Subject: Re: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID
 capable domain
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-4-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241017140137.6028-4-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/17 22:01, Vasant Hegde wrote:
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
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> ---
>   drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------
>   include/uapi/linux/iommufd.h |  6 +++++
>   2 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e13d64ffd14f..107016b3ba3d 100644
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

Perhaps we need below change in intel iommu driver, otherwise the
default domain allocation will return failure.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..d7546ab18e18 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3539,12 +3539,16 @@ intel_iommu_domain_alloc_user(struct device 
*dev, u32 flags,
         }

         if (flags &
-           (~(IOMMU_HWPT_ALLOC_NEST_PARENT | 
IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+           (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
+              IOMMU_HWPT_ALLOC_DIRTY_TRACKING) |
+              IOMMU_HWPT_ALLOC_PASID))
                 return ERR_PTR(-EOPNOTSUPP);
         if (nested_parent && !nested_supported(iommu))
                 return ERR_PTR(-EOPNOTSUPP);
         if (user_data || (dirty_tracking && !ssads_supported(iommu)))
                 return ERR_PTR(-EOPNOTSUPP);
+       if ((flags & IOMMU_HWPT_ALLOC_PASID) && !pasid_supported(iommu))
+               return ERR_PTR(-EOPNOTSUPP);

         /* Do not use first stage for user domain translation. */
         dmar_domain = paging_domain_alloc(dev, false);

Thanks,
baolu
