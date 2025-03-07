Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DC199FC1
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331032; cv=none; b=aifiPqp2FMsVs5/fi2I6nMQGXIrhIlQT7Bcfb7JLunwo7BNxz3LyHcCTcKrjsQv/J9cHXdqPAFwReqCQqQNNHHWX+G10hYUrQ3F+7CAcSbaph2adgR62VgML0ZjJ5ZxdJJxn8po7b8WWIWHCTEhdRmUDA7Why6uBH0THftDm8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331032; c=relaxed/simple;
	bh=I7musfAjoxrpjDIHGOc51sSxyVvwsm8uoGmjn/H7FrQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fiq4BGG1VKzUlMQ+eMmxedGr8VQYwk8QqF3drPLcnJq2QWLF/KTrTjgem2ylSPiP/S6Z3T+zbahF1BMWzUoAiS/M7eNFJqxRBEJmuAzPorUYF+CvoIrsT6X9utLaVm+8QjjWcoIil2haX9OSFP/isyq0tTljEJBJNw1letIliYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZtcs3Iu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZtcs3Iu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741331030; x=1772867030;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I7musfAjoxrpjDIHGOc51sSxyVvwsm8uoGmjn/H7FrQ=;
  b=QZtcs3IuEgiJDs225U8Vgp58H6jcDyCWaRFCBcSe1Fm/0sJ0+ksG7szY
   rzdX/zO38KfsF/iMGwXEEiUMyhTH7iLpgz0B1c0KNZM2MWD2Yf/u1eY00
   Loa4B3NZFcKUoJf2JPXn3Qfgvf60QiuxlYzqEk40P0IGFhx97GHwZPY5C
   y/dSJEBkcA9bKoEaC2wUKNlQ55gXsguWQHfR05RwovFg46ov/FejZe1vk
   eNYMvon2dfpIhMtS2GxkI3Ufi0o006ZADawNNT4WY18UebsQNYRSXL9Qa
   my2nu0ehXnrxySLLhB9YsC3NU/VW9YY1To2b9ahOCsJ/tyhOrSTuDrKAH
   A==;
X-CSE-ConnectionGUID: SDmwaBw1Q22/XulPm750SA==
X-CSE-MsgGUID: G2ajKFTyTsqo3C560WliOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41624493"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="41624493"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 23:03:50 -0800
X-CSE-ConnectionGUID: yhqH1oUBRUetBVYmH4AODw==
X-CSE-MsgGUID: 5rI8rjaYQ8+4onwmY6yvWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123429431"
Received: from yinpingw-mobl.ccr.corp.intel.com (HELO [10.124.242.35]) ([10.124.242.35])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 23:03:40 -0800
Message-ID: <16690409-1cb5-4b58-93fb-e5919ff1fc1f@linux.intel.com>
Date: Fri, 7 Mar 2025 15:03:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
 robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iommu: Sort out domain user data
To: Nicolin Chen <nicolinc@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <da7cc6d365ec6a77f6e6007f898eb3de2e581f80.1741294235.git.nicolinc@nvidia.com>
 <fabd6483-af48-4893-b539-2835640c5316@linux.intel.com>
 <Z8qKyvNyNU6dkN7V@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Z8qKyvNyNU6dkN7V@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/3/7 13:57, Nicolin Chen wrote:
> On Fri, Mar 07, 2025 at 10:28:20AM +0800, Baolu Lu wrote:
>> On 3/7/25 05:00, Nicolin Chen wrote:
>>> From: Robin Murphy<robin.murphy@arm.com>
> Robin had remarks here, wrt iommu_set_fault_handler():
> 
>>> The fact is that all these cookie types are
>>> mutually exclusive, in the sense that combining them makes zero sense
>>> and/or would be catastrophic (iommu_set_fault_handler() on an SVA
>>> domain, anyone?) - the only combination which*might* be reasonable is
>>> perhaps a fault handler and an MSI cookie, but nobody's doing that at
>>> the moment, so let's rule it out as well for the sake of being clear and
>>> robust.
> [...]
>>> @@ -224,10 +234,10 @@ struct iommu_domain {
>>>    		      phys_addr_t msi_addr);
>>>    #endif
>>> -	union { /* Pointer usable by owner of the domain */
>>> -		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
>>> -	};
>>> -	union { /* Fault handler */
>>> +	union { /* cookie */
>>> +		struct iommu_dma_cookie *iova_cookie;
>>> +		struct iommu_dma_msi_cookie *msi_cookie;
>>> +		struct iommufd_hw_pagetable *iommufd_hwpt;
>>>    		struct {
>>>    			iommu_fault_handler_t handler;
>>>    			void *handler_token;exs
>> My feeling is that IOMMU_COOKIE_FAULT_HANDLER isn't exclusive to
>> IOMMU_COOKIE_DMA_IOVA; both might be used for kernel DMA with a paging
>> domain.
>>
>> I am afraid that iommu_set_fault_handler() doesn't work anymore as the
>> domain's cookie type has already been set to IOMMU_COOKIE_DMA_IOVA.
> All three existing iommu_set_fault_handler() callers in the tree
> are UNMANAGED domain users:
>     5    451  drivers/gpu/drm/msm/msm_iommu.c <<msm_iommu_gpu_new>>
>               iommu_set_fault_handler(iommu->domain, msm_fault_handler, iommu);
>     6    453  drivers/infiniband/hw/usnic/usnic_uiom.c <<usnic_uiom_alloc_pd>>
>               iommu_set_fault_handler(pd->domain, usnic_uiom_dma_fault, NULL);
>     8    118  drivers/remoteproc/remoteproc_core.c <<rproc_enable_iommu>>
>               iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
> 
> On the other hand, IOMMU_COOKIE_DMA_IOVA is a private cookie for
> dma-iommu only.
> 
> So, I think we are probably fine?
If all existing use cases are for UNMANAGED domains, that's fine. And
when iommu_set_fault_handler() is miss-used, we already have a WARN_ON()
there.

Thanks,
baolu
