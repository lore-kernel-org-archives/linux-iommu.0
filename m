Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CB1D7985
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153171; cv=none; b=MJQXAwNRIXFhayVpRDO2LWNY3fxaHay7LwY88/V5DMKN1jsYfur5Nyt04SRSVk8OYPXRUej5tP6qwGPHTYe4FBVCcHsIwyG45IbXw9SkxnsSThhECK88xHcZbYy5cKNsVgVpMl0JnWZgg94RtJXsktnDKbPetXpTHDyVztAu/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153171; c=relaxed/simple;
	bh=AmrnCmsQvKDavdaqMUpAgT8D+53xpeBI3PNIM0WAudY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXoZw56SFRqC1tMkG8oUc76b8Idt7NE5veGFRCNTkaCMps9gu8u+gqPvDjD8OsreoXTHi9mzYrLiAJEo9o9/y3tKWvAGUrMnTufHoPOxRLDKgr7Ds+pRCrwbiYWZquWd1HkZ2MDp3c51yzLsqlR2jaFxYrH5eGS05xiK+KrZeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWI0k/hh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWI0k/hh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741153170; x=1772689170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AmrnCmsQvKDavdaqMUpAgT8D+53xpeBI3PNIM0WAudY=;
  b=gWI0k/hhDaG9IeeRZKqjophgBNqKqgTDOYzrQmQqlQuh4h28dGR0O75h
   SYs0kxRZHjTG8zTG4ejHzLiO/N+NbInasZnZGTUbpJHh+EKY8mj+N5FDJ
   ABLO5Mblz07PqhvfgW0So7NMvhPjaqBZdBRyeHTEVowWNRrdsXoiW8nw8
   GcsTURLmZAZEfeytW6qJ01Gh2KB1Yr2ZsMH16KguKHj10/QsxDynwOt8o
   x4ATY8bJXTrITir+XVi/NUWjCsoY5Xp/TWRQWlKyqLpzLMPTDhnKOPAeM
   Q4RNiBb225gYeqHFm9/OaYAW1OcvzPIyey1n0xS6SkhkTcJAztGzxNERT
   A==;
X-CSE-ConnectionGUID: /nztIT2aSvi703YvHOmhlw==
X-CSE-MsgGUID: mVea7/hBTM+dbq/gXRZBCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41349597"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="41349597"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 21:39:29 -0800
X-CSE-ConnectionGUID: sJmDI49ERvKccI/5alj7UQ==
X-CSE-MsgGUID: E7UbQgR4QI6+MASRlWaZFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="118736138"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 21:39:26 -0800
Message-ID: <c6d20839-f4c1-429c-b12c-c8d06ae0ce03@linux.intel.com>
Date: Wed, 5 Mar 2025 13:36:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] iommu/vt-d: Cleanup
 intel_context_flush_present()
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-7-baolu.lu@linux.intel.com>
 <f7d84e3d-a648-4292-a652-408f704411c7@intel.com>
 <51cb2ef8-3cce-4af7-b6ce-c3e3d490e6a3@linux.intel.com>
 <338ee285-ae28-4e3f-a7de-57205d9e9873@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <338ee285-ae28-4e3f-a7de-57205d9e9873@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 11:34, Yi Liu wrote:
> On 2025/3/5 10:21, Baolu Lu wrote:
>> On 3/4/25 16:43, Yi Liu wrote:
>>> On 2025/2/24 13:16, Lu Baolu wrote:
>>>> The intel_context_flush_present() is called in places where either the
>>>> scalable mode is disabled, or scalable mode is enabled but all PASID
>>>> entries are known to be non-present. In these cases, the flush_domains
>>>> path within intel_context_flush_present() will never execute. This dead
>>>> code is therefore removed.
>>>
>>> The reason for this path is the remaining caller of
>>> intel_context_flush_present() is only the domain_context_clear_one() 
>>> which
>>> is called in legacy mode path. Is it?
>>> If so, it seems unnecessary to keep __context_flush_dev_iotlb(info); 
>>> in the
>>> end of the new intel_context_flush_present(). Also, since this helper 
>>> is more for legacy mode, might be good to move it out of pasid.c.:)
>>
>> This helper is for invalidating various caches when a context entry is
>> present and certain fields are changed. It is used in both legacy and
>> scalable modes.
> 
> hmmm. the kdoc says all the pasid entries are non-present, is it necessary
> to flush dev_tlb in such scenario? I suppose no present pasid entry means
> no pagetable as well.

The spec has defined the software behavior for cache invalidation in
"Table 28: Guidance to Software for Invalidations". This helper was
written according to it.

> 
>> In the past, this helper would work even if some PASIDs were still in
>> use. After the changes introduced in this series, this PASID-in-use case
>> is removed. So remove the dead code.
> 
> yeah, I got this part. As I mentioned, the only caller now is the
> domain_context_clear_one() which is used in the legacy path. That's why I
> feel like it is now more for legacy mode path now after this series.

It's also called by device_pasid_table_teardown().

Thanks,
baolu
