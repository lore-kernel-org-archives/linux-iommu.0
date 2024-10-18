Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CF291E
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729221052; cv=none; b=B6IKVdHkXAUvqQn9AJiJYCxGQymKNFCs0dOgBCfFLSAlupwymfIbgvZmMGqEB6HCuev+PnE4C4fnSquvCAUr3ayQAfYIn2olCElAKebFifHqbg1dwFT5d+o+2cGA++zR5dM652xZxk7+1w6IL+PcMR3CWneHPF12KjPZWcsGPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729221052; c=relaxed/simple;
	bh=vIoJ2cvDwDJM42nkGDfYZGuhyiL+RbClbcwuAr0eHDs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=htBSNi4IK4QHyIUG3VY7J6b5HZNhL3iPZmDtcKRF5x/Rjm54q+eavcJUlw2zT301OdBgmAqRar75E1Ks9zT5z4pb3pHvfdxRMRxJG/wRmf2j+1WNd9kPP0Uuixx3eGw9b5YHfkA5ff1IIr+A/7va7gt9vgtUGBr8MvaZHbs7X2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvkT+92D; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvkT+92D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729221051; x=1760757051;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vIoJ2cvDwDJM42nkGDfYZGuhyiL+RbClbcwuAr0eHDs=;
  b=fvkT+92D1JdmABPxfFHwXEO2rI0iukYsiBTCFx2D9PJHccQd9T52shGD
   gyYM4ZL/Sgr4rxyaGwyhDZVyrCECG2roqz0bkumkcxEKqIEZTxqSdl/Iu
   A30oMllQmnKRAiJyeqKQw0x4v6X61mx/8Gb80TP+MdTf+uWDC3p4vDhGU
   RuaYFzsO+6QmNg5efLkfgVWsgFenBKCeZAjc7D2MIaE9XIE3oemlxBcw2
   KVAxNHKXs6DgBU+JGucJl1N61eQ2J4CcaycevOBdjhoLLp86ls6Ett3Ox
   fjTBfBtUuO17BBTLu0NKSgnoYrYsLNE7Bxvo8WRSYH5KQuglyXuYGv18t
   A==;
X-CSE-ConnectionGUID: x7e07RzGQPS9q69hD/nqvA==
X-CSE-MsgGUID: T4VFEQQrSmiB2YooL2ORtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28871790"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28871790"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:10:50 -0700
X-CSE-ConnectionGUID: HciKyT69RqmUl/1X3M6FNA==
X-CSE-MsgGUID: bYC/7C29TZeVRsEGmhEvyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="79088859"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:10:47 -0700
Message-ID: <fce1b1b7-6cab-4f3d-a215-fe1b38df3e9e@linux.intel.com>
Date: Fri, 18 Oct 2024 11:10:45 +0800
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
Subject: Re: [PATCH v3 00/12] iommu: Domain allocation enhancements
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20241017140137.6028-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241017140137.6028-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/17 22:01, Vasant Hegde wrote:
> This series adds iommu_paging_domain_alloc_flags() which takes flags to
> pass additional details for domain allocation (like domain with PASID
> support). Also adjusts core code to handler variuos domain allocations.
> 
> Also updates AMD IOMMU driver domain allocation code. With this by
> default it will allocate domain with V2 page table for PASID capable
> device and v1 page table for rest of the devices.
> 
> 
> TODO:
> @Jason, @Kevin, @Baolu,
>    With this series if driver implements domain_alloc_user() then we assume
>    IOMMU always supports PASID. If IOMMU doesn't support PASID (ex: AMD driver

I don't think this assumption is true for all iommu drivers. In my
opinion, domain_alloc_user() will eventually be a common callback used
by the iommu core to allocate paging domains. It includes an allocation
flag that specifies various requirements, including PASID, which is a
special requirement for the amd iommu driver.

>    not supporting V2 page table) and device is PASID capable, then driver will
>    return error. Device probe will fail.
> 
>    I think if driver return error, core layer should retry without
>    IOMMU_HWPT_ALLOC_PASID flag. Other option is indivisual driver in error path
>    of domain_alloc_user allocating non-PASID capable domain.
> 
>    I prefer first option. Just wanted to discuss before implementing. Any preferred
>    option here? OR any other better way to solve this?
> 
> 
> Note :
>    vt-d specific changes is handled in separate series [1].
> 
> [1]https://lore.kernel.org/linux-iommu/20241011042722.73930-8- 
> baolu.lu@linux.intel.com/
> 
> @Baolu,
>    Do you want me to include above patch in this series so that it doesn't break intel driver?

I haven't read through the whole series yet, but let's avoid creating
unnecessary dependencies.

Thanks,
baolu
