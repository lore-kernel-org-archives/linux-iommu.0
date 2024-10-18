Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B520E31C
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729224145; cv=none; b=grVGbb4whzJbTGSrsBwqZ/2wk8jKFx9ecx3oAcbK3crIFl455xqowmpqIe0ttOZjYJSS3/9v9vrNWLeWJi643VDmiS9hU+6rMcV8O3esDdrFGI0WvhLxPRwYRUihTc8la6x6MBxrUyd+/A/NVpeUyyUfXQXBZsGKcdzB5zRcFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729224145; c=relaxed/simple;
	bh=L99nBj9msHi13xBa2EXvRB5nuM5AOLN7IinPULdqHdY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fK+TgaCDUOJ4FxFtZduYpyjLezTXep9eUd5IY8zOT3FFsil/p5KA7MuP4+lXayHbEUylPpCbnT4MGzO7y+qgJ7SazYbCj1MbNt6GeZcinmXkQ2RnFyly5iKRWjNg/BP4fKaBWDFqmZQY1a/X7H+UuUsnwLIOOhYo3CJgFkxFzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrcQ0A/d; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrcQ0A/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729224144; x=1760760144;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L99nBj9msHi13xBa2EXvRB5nuM5AOLN7IinPULdqHdY=;
  b=SrcQ0A/d3oN24sqZ49FBpY7K/RJ0X769SJ1tvopccBTx2RrsJVrwcCqo
   mFJ4a1F3H6hjfqSs2HjtJCekm7ZAUDM7/d9PearFC3oL1cP1UG/7stdfp
   KJ5xnvrTOya6MXndD3zG9lBToCzGven2xUq/w+kbbr8MHnyFFe4jEjUGv
   4Sy8ewxikXXGUZs9eXZMY7f/NSbd6ni2E42HAb6smi00Sh8zGXsf75Fka
   yA4JKmaAW9sHCShxIvhQyOJcztGKDpVYaVCi0FFRoWR4nZLlcu6ihGM/N
   suXc5uSoNQ0kY61NzTLlfQDg2uQp5K9nTYJqBSTOqTVohD/TlfuTt2b1N
   w==;
X-CSE-ConnectionGUID: qHcpEHQOSdSL/n8jj3NKZg==
X-CSE-MsgGUID: 3vMOrjTMTVStdmlIw0OQhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28894672"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28894672"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 21:02:23 -0700
X-CSE-ConnectionGUID: YW9xfNo4TYuouYeY1oZR+w==
X-CSE-MsgGUID: 6vbSUJyVR6OUMQJiMViKug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="79174198"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 21:02:20 -0700
Message-ID: <0b898ef2-5c1e-4ebc-8f9c-944f64027524@linux.intel.com>
Date: Fri, 18 Oct 2024 12:02:17 +0800
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
Subject: Re: [PATCH v3 11/12] iommu: Put domain allocation in
 __iommu_group_alloc_blocking_domain()
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-12-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241017140137.6028-12-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/17 22:01, Vasant Hegde wrote:
> From: Jason Gunthorpe<jgg@nvidia.com>
> 
> There is no longer a reason to call __iommu_domain_alloc() to allocate
> the blocking domain. All drivers that support a native blocking domain
> provide it via the ops, for other drivers we should call
> iommu_paging_domain_alloc().
> 
> __iommu_group_alloc_blocking_domain() is the only place that allocates
> an BLOCKED domain, so move the ops->blocked_domain logic there.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> ---
>   drivers/iommu/iommu.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu
