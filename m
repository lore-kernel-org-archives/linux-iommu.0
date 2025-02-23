Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45714156F41
	for <iommu@lists.linux.dev>; Sun, 23 Feb 2025 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740316718; cv=none; b=tCU8P+nDfxK5pec0GOHfRLUrCVHfJJyytvWqeECx96CafKEq2o6Cg6jlud2dZlZZ84ZtdPG8KBZlG5NGpUsiS7eB4zFt+QcWt7skgRwHPbWy4jpjaFdzmPAAE0eks7TmeR72VTWpplyX7bYcUmdYEIp2CnkuD8t2aCkqTAF3y38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740316718; c=relaxed/simple;
	bh=zhofopF9lAae3SzVMhV6xvL91LmD3RIHuRhrRtfZ8eY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f8kk2QpUeAJKd9Iw/g3M5Zwm6uB6Eodwy+aPDCigqwLQih+bykzbV4Xr2SDNR6grNOSrlH9G50SNNxWho1SNQqIBTh3nFQgp/fiBeKfa3BFOEkCzXCoYXT3BdhIr8baMy7VJ3pDxY3H+WfYsurfzySTklSdzrJNJ9sBZERz7r/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2VU5kuc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2VU5kuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740316717; x=1771852717;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zhofopF9lAae3SzVMhV6xvL91LmD3RIHuRhrRtfZ8eY=;
  b=b2VU5kucM7I9qqUMIaWKSvImvnXuEU4YbjhxAEdwgLsmsIZSx1kvJD8X
   FPgCXTRKJxMJ5EMQb0Bk0Dnp/sNDXT14Arzyo1RTRy501jqDZ0ZZCq9tD
   JHjc51AOjKGjJSLd7olq47sYQtpH3Bx+2I68YdJkoGSXq9Z/TglwEuy6f
   pL3B4wLGiFuS6U0zTLXiO98XUGtGLbJZiBOUe6ZgavGjczitzrtfUTqJi
   02SirQ7NGzLuGKUwlYIP7YV33L5951DRNS6pkJ8q1ZA2wpm+VShnUlOoV
   C3Xgc+MnpX7jl3f4CMXYIZl1A8Iqxh26b9mZn8EHUkH9kjfTC6gA2kl36
   g==;
X-CSE-ConnectionGUID: 2oTda4tCQs+4S9lMp4DNeg==
X-CSE-MsgGUID: bBVvjtRiTHS2oCzDn8KhqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40317628"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40317628"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:18:37 -0800
X-CSE-ConnectionGUID: RbnFCCRBTRaTqX7yBHkH8w==
X-CSE-MsgGUID: Uh+0nPNaT/uOleg8Em6xRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="139048842"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.93]) ([10.124.240.93])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:18:34 -0800
Message-ID: <0998ec60-9b91-4d81-b45f-1d0a5db02bee@linux.intel.com>
Date: Sun, 23 Feb 2025 21:18:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, iommu@lists.linux.dev,
 robin.murphy@arm.com, nicolinc@nvidia.com, will@kernel.org
Subject: Re: [PATCH v2 2/4] iommu: Drop iommu_group_replace_domain()
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-3-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250221143335.49874-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/21 22:33, Yi Liu wrote:
> iommufd does not use it now, so drop it.

iommufd still uses iommu_group_replace_domain() in Joerg's tree. This
could cause compiling issues if this series goes through the iommu tree.

$ git grep  iommu_group_replace_domain
drivers/iommu/iommu-priv.h:int iommu_group_replace_domain(struct 
iommu_group *group,
drivers/iommu/iommu.c: * iommu_group_replace_domain - replace the domain 
that a group is attached to
drivers/iommu/iommu.c:int iommu_group_replace_domain(struct iommu_group 
*group,
drivers/iommu/iommu.c:EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, 
"IOMMUFD_INTERNAL");
drivers/iommu/iommu.c: * This is a variant of 
iommu_group_replace_domain(). It allows the caller to
drivers/iommu/iommufd/iommufd_private.h:        return 
iommu_group_replace_domain(idev->igroup->group, hwpt->domain);

> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu-priv.h |  3 ---
>   drivers/iommu/iommu.c      | 35 ++++++-----------------------------
>   2 files changed, 6 insertions(+), 32 deletions(-)

Thanks,
baolu
