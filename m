Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA04A2C
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661257; cv=none; b=SkCkDMpbAqAo6s+2BrV/dCE+7HWUCOc3eeHtIMq6PaRYu2BqLWHaHkbMpGnwd2v0eM+SQFLbBVQs702vW2ohym/XykK1KnHrot2a4w6HFuzhdxeE+d19lIAoNSx3uCUHp0DARjEwyxVHR6OQXFKVymVdz5XFUCrBwq6jzf0/ks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661257; c=relaxed/simple;
	bh=5gaNNBF8ciKxjGoSl85VzRdoVgd1yJClgJA1s0kDGqM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rmG4GpjHxzc9yqXL4pq2jeR8azlASyLbSBMKOgRP/HXKNTvJf8TwFNym7ESExDozdwZIwpI8dwben5HypJdvZHYI3YoUwaE4XyDOg+bjclule/L9T8BJNdmfbsRr4ZvQjvPockACgnF1cQoidfBQHow4x72SAdPzvY6sP8xBY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VV248i+m; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VV248i+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724661256; x=1756197256;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5gaNNBF8ciKxjGoSl85VzRdoVgd1yJClgJA1s0kDGqM=;
  b=VV248i+m+np4HfrwDeULQsuji3uwAM6owhx00yy7aZqHOWcP97MSS42U
   iigFZhN7458KjDNud7Q2Z9SKsXpaCikABAXT2mqQnwaB5FQ3CpLrvracb
   w4s4i/5OvUSD28d8iZRWE9WSe07iVVYakwKucf4aP5gKPJFVJdHecN2zP
   ylvB5X7xFO2eddBGe0MAa5ghaurwCQydlKil2idIaqiMRxayvR8r6pJFo
   4r5Wd8Wa35YUm1N9bwx861un8omL47HCrVWj40/yaX8z0JsfRUIDdHV4A
   0NgBBrGl+qvlFogHSYin/G9DLUHl0R7RxBv3uX6aTT105XWf31+Jyxuz1
   A==;
X-CSE-ConnectionGUID: 9IzubAR0TlCV+boRKuxgbQ==
X-CSE-MsgGUID: yklZGhwARcymFPaR1FvTJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33689052"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33689052"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 01:34:15 -0700
X-CSE-ConnectionGUID: Y4/lExnqQrq+idPFdCObtg==
X-CSE-MsgGUID: WWbYiNiXTkSbGY2037xkEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="63159017"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 01:34:13 -0700
Message-ID: <7ca97716-fe84-426e-bc73-808f8182ddbf@linux.intel.com>
Date: Mon, 26 Aug 2024 16:34:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Vasant Hegde <vasant.hegde@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>
 <20240822124307.GC3468552@ziepe.ca>
 <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>
 <BN9PR11MB5276296DD7C9503378C9227B8C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276296DD7C9503378C9227B8C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/26 16:08, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Friday, August 23, 2024 10:48 AM
>>
>> On 8/22/24 8:43 PM, Jason Gunthorpe wrote:
>>> On Thu, Aug 22, 2024 at 09:50:57AM +0800, Baolu Lu wrote:
>>>> On 8/22/24 12:31 AM, Jason Gunthorpe wrote:
>>>>>>      I think instead of having separate function it may be better to
>>>>>>      enhance __iommu_domain_alloc() such that:
>>>>>>        - Keep below changes from this patch
>>>>>>          - iommu_domain_init()
>>>>>>          - iommu_get_dma_cookie call inside
>> iommu_setup_default_domain()
>>>>>>        - modify __iommu_domain_alloc() to additional param (flags)
>>>>>>        - iommu_paging_domain_alloc_flags() will call
>> __iommu_domain_alloc()
>>>>> My expectation was to basically remove iommu_domain_alloc() entirely
>>>>> once Lu's work is merged.
>>>>>
>>>>> Instead we'd have these direct APIs:
>>>>>      iommu_domain_alloc_paging_flags()
>>>> Is it possible to use different domain allocation APIs for kernel DMA
>>>> and user-space DMA? Right now, we differentiate between these two
>> types
>>>> of domains using IOMMU_DOMAIN_DMA and
>> IOMMU_DOMAIN_UNMANAGED.
>>> I really don't want to have such a distinction.
>>>
>>>> I'm thinking about this because the Intel iommu driver has a similar
>>>> need to AMD. They both recommend using different page table formats
>> for
>>>> IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED, which is
> Where is such recommendation coming from?
> 
>> currently stopping
>>>> us from implementing domain_alloc_paging in the Intel iommu driver.
>>> Why? What exactly is the issue?
>>>
>>> It is inhernetly wrong to behave differently based on DMA API or VFIO.
>>> They are not different things.
>>>
>>> If you have different behaviors and different properies, like AMD's
>>> PASID, then they should be described and mapped to some kind of flag.
>>>
>>> Otherwise the driver should always allocate a paging domain that gives
>>> the highest performance.
>> It relates to Intel VT-d's nested translation. Intel VT-d has two types
>> of page table formats for DMA translation: first level and second level.
>> In nested translation, the first level page table is used for first-
>> stage translation, and the second level page table is used for second-
>> stage translation.
>>
>> The iommu driver for vIOMMU in the guest kernel must use the first level
>> page table format for kernel DMA. This page table will then be nested on
>> a second level page table in the VMM host kernel.
> If a 'legacy-only' vIOMMU is exposed the guest kernel will certainly
> use the 2nd stage page table.
> 
> nested is an optimization manageable by VMM. Not something that
> the kernel driver needs to restrict.
> 
>> Our current design uses the first level page table for both the host and
>> guest kernel for simplicity. This is why we use different page table
>> formats for IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED.
> As you said it's the current 'design', not an arch limitation. 😊
> 
>> We considered determining the page table format based on whether the
>> iommu has caching mode capability. This would result in the first level
>> page table format being used for guest kernel DMA and the second level
>> page table format being used for host kernel DMA. However, this approach
>> creates an inconsistency between the host and guest kernels.
> Why would one care about such consistency between the host and the guest?
> 
> In the end the iommu driver needs to decide based on the requested hwpt
> type and available iommu cap to decide the format.
> 
> e.g. is there a problem with a simple policy below?
> 
> - Default use stage-1 for both DMA/UNMANAGED, if nesting_parent is
>    not specified and stage-1 is supported by hw
> - Otherwise use stage-2

First-stage has some limitations for an UNMANAGED domain. For example,

- No separate controls for the Access/Dirty page tracking;
- No Write-only permission support;
- No page-level control for forcing snoop.

Thanks,
baolu
