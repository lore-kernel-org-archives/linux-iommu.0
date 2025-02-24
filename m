Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619EEEA8
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740373838; cv=none; b=q12c0+DHfsseDqPml1iTjfdXYn/aDQGma/oIGnwzuHqXgj5lhnROqXW22htiy9HaiTE/GxT+VDyy7i/KHnpPr9fupx/EbSrIOKQQTO+r14ArsYkE68I570bP5vYn+il/1SC8uhj+w8Vjxv0jNqRbKBTRAVas/SRlEVSaeWUBGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740373838; c=relaxed/simple;
	bh=GRQJmCpDLaPovwIoPmtEmVbVYVG865oJ3j5l6e3Xu+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkj0rihczco2GcVFSI+5o8V30Ug2vjmSWuoPcwpgse5IPPNPQ+U3t4KQJ8EnaLg+lk4SlcJ7KfS37gKWdQ/2KYrtmM+46lNf3C3QzVvXAlKavYTltHWoO7TOoaiXAb60wbCvBiIF4FubDLEWtXjXpdn6iHf210Et6VDavFaR1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLExIcDX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLExIcDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740373837; x=1771909837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GRQJmCpDLaPovwIoPmtEmVbVYVG865oJ3j5l6e3Xu+Q=;
  b=MLExIcDXkTB7nmf2ZaeONnRyqEur0LD9dDkC2PBQ63OP3bBsuQBrnoQh
   tiBFe4feDENgS/trSn8Gju2mc7l83xM66iUe0fhRa8G8ezvYg1yiYa8xU
   POTqhtjYADWwBb5uiu6zOYxx98NaHTF6g8zDrybE2+UWRXav3YD45UyoY
   m4Wb7lw5rwiRl25xSDpvn1YlzHutT8P17aZcDbeqoKG6D6JxevB2iCpY6
   ry/xSrd4evbnNUdhJFU6sqtPuOiiVyyyxdkpz2hdwLiB29PqpZAQnDYlW
   8uRcNYx/WmIsWvUiDJMzR/l5iKksSfOydeflbWR+KqubBT7phis3ekD3p
   A==;
X-CSE-ConnectionGUID: NgsWN+ilRF+BBVsx6rO80Q==
X-CSE-MsgGUID: wfQgl0WGSmCm7Ell5uA56w==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="44894565"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44894565"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:10:36 -0800
X-CSE-ConnectionGUID: hkiyoaDbSoC8nlzU+rLPcA==
X-CSE-MsgGUID: ATq6Lo42QEyrxLHULBpcjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121220258"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:10:34 -0800
Message-ID: <2dccba8b-5f98-4d08-a3ca-b9028fe5d03a@linux.intel.com>
Date: Mon, 24 Feb 2025 13:07:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Swap the order of setting
 group->pasid_array and calling attach op of iommu drivers
To: Yi Liu <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
 iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-5-yi.l.liu@intel.com> <Z7i3dvyA/opurciP@Asurada-Nvidia>
 <ceb475fa-dfdf-4bcb-a4ba-8128ba86a39a@intel.com>
 <9ad4766e-e37b-4310-acec-dc8eb91dde64@linux.intel.com>
 <c71cb2bc-e1f0-4d42-a695-026a996e8f6e@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c71cb2bc-e1f0-4d42-a695-026a996e8f6e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/24/25 12:38, Yi Liu wrote:
> On 2025/2/23 21:32, Baolu Lu wrote:
>> On 2025/2/22 9:59, Yi Liu wrote:
>>> On 2025/2/22 01:27, Nicolin Chen wrote:
>>>> On Fri, Feb 21, 2025 at 06:33:35AM -0800, Yi Liu wrote:
>>>>> The current implementation stores entry to the group->pasid_array 
>>>>> before
>>>>> the underlying iommu driver has successfully set the new domain. 
>>>>> This can
>>>>> lead to issues where PRIs are received on the new domain before the 
>>>>> attach
>>>>> operation is completed.
>>>>>
>>>>> This patch swaps the order of operations to ensure that the domain 
>>>>> is set
>>>>> in the underlying iommu driver before updating the group->pasid_array.
>>>>>
>>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>
>>>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>
>>>> A nit:
>>>>
>>>>> ---
>>>>>   drivers/iommu/iommu.c | 44 ++++++++++++++++++++++++++++++ 
>>>>> +------------
>>>>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>> index eff5f678883b..73555e1cf016 100644
>>>>> --- a/drivers/iommu/iommu.c
>>>>> +++ b/drivers/iommu/iommu.c
>>>>> @@ -3388,13 +3388,25 @@ int iommu_attach_device_pasid(struct 
>>>>> iommu_domain *domain,
>>>>>       entry = iommu_make_pasid_array_entry(domain, handle);
>>>>> -    ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
>>>>> +    ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, 
>>>>> GFP_KERNEL);
>>>>
>>>> Maybe xa_reserve() pairing xa_release()? Same thing though..
>>>
>>> there is slight difference. xa_reserve() will return 0 if there is 
>>> already
>>> a valid entry. xa_insert() shall fail with EBUSY. We want to catch such
>>> failures here. You may notice that the replace function uses 
>>> xa_reserve()
>>> as it intend to replace existing entry.
>>
>> Do you mind adding some comments around the code explaining why
>> xa_insert() is used instead of xa_reserve() here? This will make the
>> code easier to understand without needing to refer to this discussion.
> 
> hmmm. do you think it is enough when referring to the kdoc of xa_insert()?
> It notes it acts just like xa_reserve() when no stored or reserved entry.
> It fails if there is another present entry, and this suits the need here
> since it does not intend to replace existing entry.
> 
> 
>    * Inserting a NULL entry will store a reserved entry (like xa_reserve())
>    * if no entry is present.  Inserting will fail if a reserved entry is
>    * present, even though loading from this index will return NULL.
> 
>    * Return: 0 if the store succeeded.  -EBUSY if another entry was 
> present.
>    * -ENOMEM if memory could not be allocated.

I feel that it's enough if we add something like:

	/*
	 * Entry present is a failure case. Use xa_insert() instead of
	 * xa_reserve().
	 */

Thanks,
baolu
