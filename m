Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2E19E7ED
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681921; cv=none; b=NMdZXozf+FRQ+vYNFzv6RPlQ5/eMw9fFGWQnGaB2rvaL2u7KHxX6oMmholBjiLj+fNVBujGJQ8wa2XN/wemyiML8/J1LJ/rXc8chtSpZhNs4va1zOkgD/uhMP4J1xaMQEgqE5Q0Wa4Svj6t8tt6N/TTrN0hFiaYqLHQTE7TkdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681921; c=relaxed/simple;
	bh=7JStf212Hwpx69UkzBHWq0UfzruuX/4ktnWU08qVv7o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pjRpCYiBY+o1LVjCHk91O3uSwejzCxulpB/kk5znjef+klZFA6SjT0cKeVt2ORMZ/VJ/PBn2AScyBBHnWDCTo6GFCiB4xCm7QFw6/WlmneLuh6ZhWIJM0INZifRsWeCqj8oreRQILoZSB7gPgXTnJg9u+14y+Kpgp83ZIogUaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3lYhq5T; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3lYhq5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729681921; x=1761217921;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7JStf212Hwpx69UkzBHWq0UfzruuX/4ktnWU08qVv7o=;
  b=V3lYhq5T+Z56Ny6j02P0A3vTd9HuWulpzZlveIQOi2o6qHaIITtOopc9
   sFPEWQ7rpTtvjZvvhXgqqCHBO9fHpVmo6RYPsdQLpS5sAnC/RIG2Id1DR
   +KopWVS5VbI+Ug9peXdSbOBaBSyvDLZMLjiJXoi6HDpmlRhEXCWbvyw+6
   n0LjB8yf+hZ3nPQ5rjMXnmu86mDF5raX96DBCZpneDUze5p0RPdJJQz5+
   /bL3J0Oht8rBCumrNoI5ailjrvCJB8s656OFWEW/MgZAcBuU1SN0e9ycA
   LWYP5TVUNmM0mOR0Vf7ykSaVJuqqX6Rlg/k5Tucp2cxH8Hptso7A3rGxa
   Q==;
X-CSE-ConnectionGUID: CqSh/fSnSpOcjNulxnhvXg==
X-CSE-MsgGUID: BrC0+jdsQwC5/qe2gG0vdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29378584"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29378584"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 04:12:00 -0700
X-CSE-ConnectionGUID: x3lyqTHBSt+qTM8pHQY8XA==
X-CSE-MsgGUID: pgIKe41RRIGQSytLEzQRNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84139301"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 04:11:57 -0700
Message-ID: <10b6180b-dbee-4c30-b835-6accf99af2ea@linux.intel.com>
Date: Wed, 23 Oct 2024 19:11:54 +0800
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
Subject: Re: [PATCH v4 03/12] iommu: Add new flag to explictly request PASID
 capable domain
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-4-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241023104207.5894-4-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/23 18:41, Vasant Hegde wrote:
> From: Jason Gunthorpe<jgg@ziepe.ca>
> 
> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
> If IOMMU supports PASID it will allocate domain. Otherwise return error.
> In error path check for -EOPNOTSUPP and try to allocate non-PASID
> domain so that DMA-API mode work fine for drivers which does not support
> PASID as well.
> 
> Also modify __iommu_group_alloc_default_domain() to call
> iommu_paging_domain_alloc_flags() with appropriate flag when allocating
> paging domain.
> 
> Signed-off-by: Jason Gunthorpe<jgg@ziepe.ca>
> Co-developed-by: Vasant Hegde<vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> ---
>   drivers/iommu/iommu.c        | 56 +++++++++++++++++++++++++++++-------
>   include/uapi/linux/iommufd.h |  8 ++++++
>   2 files changed, 53 insertions(+), 11 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu
