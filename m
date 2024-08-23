Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680917C66
	for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381491; cv=none; b=l10oFn8WXh16oVBLVUb9g+qKcSVedBSaxdYJeecQujn5uKvEDGy5pbT8jEyqwx/UhGwz37Z/hzBFx8/VkWah2IzdzPU82McgHzoU/A7yvVvZ7QVR1R2TIQRBLrLBXDyXE9KAZpLnaynfUqQMH7u07oiC/rV5cwhsRTGEMphswQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381491; c=relaxed/simple;
	bh=igslMP1pELUNjl4CHqed5nWyHq9JsrowKlfHqV5kgWA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OsgiGXgcw9X70fNeTknai9XTJNHvrFRP30dW6MmHyw0Bv7oXW3xHCBcShK0H9DWWVNauDK06Ftvtq/BZym5DrO9GQttbWmgqIrGyLnONd4d336qM1duPZpDXh7FE45G+EWqBlYisHA42qutdoUttFq6pPZZ5OAbMU9eH9zWQeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPAD4v33; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPAD4v33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724381490; x=1755917490;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=igslMP1pELUNjl4CHqed5nWyHq9JsrowKlfHqV5kgWA=;
  b=JPAD4v33sI5/nmemj4Uj6FBnqg3CwzyAy8lkyhJaYBKXX7Q7mNNkVVmV
   ox01XIx1Vr9a5RKTl0ytBDd4QrAQNouVyHZthS3uyxBU5ZApedWZkteaO
   qqSVGqwQmECa9q9z9DgJ+3+wcfWVfpUgk8pbX0JY4t0iNQatefbGroyuO
   CBdybLnfBboselaR3FJ/kBxOjgz5CEflXspiF2CPBVtDtB3qsiwAMKXEv
   /q+jqLcwSVCrzwWBZfCKYbjCcQq4je/qxn6ET/3SjW0TMAfD19bFMotJl
   c9dRLf5D5XIDl9klWBpKjxeqv1jxpnIx9Eu2+rnsZmn4KLahT8Iut7FLd
   w==;
X-CSE-ConnectionGUID: hrQHyZMWQsWnJGnAZSFOkA==
X-CSE-MsgGUID: PFavLQW7RQ+jO3EC6ORYew==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22983553"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="22983553"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:51:29 -0700
X-CSE-ConnectionGUID: /fbc1kn/R0aA3OeQrJHwbA==
X-CSE-MsgGUID: DqZAVDR8SyuLe9YD6A90hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61681295"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 22 Aug 2024 19:51:27 -0700
Message-ID: <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>
Date: Fri, 23 Aug 2024 10:47:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Vasant Hegde <vasant.hegde@amd.com>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>
 <20240822124307.GC3468552@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240822124307.GC3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 8:43 PM, Jason Gunthorpe wrote:
> On Thu, Aug 22, 2024 at 09:50:57AM +0800, Baolu Lu wrote:
>> On 8/22/24 12:31 AM, Jason Gunthorpe wrote:
>>>>     I think instead of having separate function it may be better to
>>>>     enhance __iommu_domain_alloc() such that:
>>>>       - Keep below changes from this patch
>>>>         - iommu_domain_init()
>>>>         - iommu_get_dma_cookie call inside iommu_setup_default_domain()
>>>>       - modify __iommu_domain_alloc() to additional param (flags)
>>>>       - iommu_paging_domain_alloc_flags() will call __iommu_domain_alloc()
>>> My expectation was to basically remove iommu_domain_alloc() entirely
>>> once Lu's work is merged.
>>>
>>> Instead we'd have these direct APIs:
>>>     iommu_domain_alloc_paging_flags()
>> Is it possible to use different domain allocation APIs for kernel DMA
>> and user-space DMA? Right now, we differentiate between these two types
>> of domains using IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED.
> I really don't want to have such a distinction.
> 
>> I'm thinking about this because the Intel iommu driver has a similar
>> need to AMD. They both recommend using different page table formats for
>> IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED, which is currently stopping
>> us from implementing domain_alloc_paging in the Intel iommu driver.
> Why? What exactly is the issue?
> 
> It is inhernetly wrong to behave differently based on DMA API or VFIO.
> They are not different things.
> 
> If you have different behaviors and different properies, like AMD's
> PASID, then they should be described and mapped to some kind of flag.
> 
> Otherwise the driver should always allocate a paging domain that gives
> the highest performance.

It relates to Intel VT-d's nested translation. Intel VT-d has two types
of page table formats for DMA translation: first level and second level.
In nested translation, the first level page table is used for first-
stage translation, and the second level page table is used for second-
stage translation.

The iommu driver for vIOMMU in the guest kernel must use the first level
page table format for kernel DMA. This page table will then be nested on
a second level page table in the VMM host kernel.

Our current design uses the first level page table for both the host and
guest kernel for simplicity. This is why we use different page table
formats for IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED.

We considered determining the page table format based on whether the
iommu has caching mode capability. This would result in the first level
page table format being used for guest kernel DMA and the second level
page table format being used for host kernel DMA. However, this approach
creates an inconsistency between the host and guest kernels.

I am not sure about other architectures, like AMD, ARM and RISC-V.
Perhaps all of them have the similar need?

Thanks,
baolu
