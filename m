Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E45134B0
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717652144; cv=none; b=A+9CXi5J0z5xz0QapLblhOC9e/CF4PJeGuXZ/zkKxw0l+w0bMkbJrM+JDUdumxdFCa/qQv2lX8XUUNA5jMlpMJJH1auW40EmrenizK5KmWzQCgT0cqx/bsTfGuU75RaWIJpf3KnR36zaQQNiAB2YikjQSSOnV42nAPaaAlRgEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717652144; c=relaxed/simple;
	bh=InCQzcleHQrhQdMJPefCKWuAUYL7XdU2W+O2UOMCf1o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UWGZfTTGi6BAsXSmFQA01SVSKawjq4Ssj63ovsiA3BTv1tiuK1N2SoRdY2etnkv7TeqHHOzHxQJFhRMH//mEvlCUmDr9ZiO4VX0WWjsxtnsXBBGGp8GN07zIidMe+noG0ILU9VUgZyKrdWWB8CXURuwGofQdd4kg5EQCOiCn0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaVleXGk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaVleXGk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717652143; x=1749188143;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=InCQzcleHQrhQdMJPefCKWuAUYL7XdU2W+O2UOMCf1o=;
  b=OaVleXGkuxKF2kIkS5Rj1iI9KYjFhIEj+Ba7GDJIvB2vl93yQBfG0J8y
   FV2iyV3X6s8lbUgNZHzgTTxwE5gH3/2tCgdnpWZ1Q71Q9TGXcCD/0m9xQ
   vCmPEssTlh1yjS6jDH0DhxIDldYExLQpUuxsYu/3aC8gTptJBpZ5HForv
   lmDSCiQDVzTYpiygr5TjJcSOTDS/kh+eyEmqQZrjCpp2TEthEJ4sZhDGY
   8O/S42gxjDwcC740Ce5Z12jzxjuRHiW+4t5eIBt8RtePCB4aGKewiYGKQ
   fdB9Jm0MyIfwC/yMTask9WOKpGHY1dm6jp7yxlQECqVb5GMROBC3e7uU6
   w==;
X-CSE-ConnectionGUID: lWbjqhGCTfORwG4i8RtcWg==
X-CSE-MsgGUID: NAjex9IIQjOXb0vnJIU0WA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14136534"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14136534"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 22:35:42 -0700
X-CSE-ConnectionGUID: 7WWfxiLaQamFNN8Wrip2bQ==
X-CSE-MsgGUID: 32paJY4dQeO+RRptTXFT9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42940006"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 05 Jun 2024 22:35:39 -0700
Message-ID: <ae7c05b0-104e-4c71-99aa-fed2a4f209fb@linux.intel.com>
Date: Thu, 6 Jun 2024 13:33:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v6 01/10] iommu: Introduce domain attachment handle
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767B3B1F441D9AA656AC258CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52767B3B1F441D9AA656AC258CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 4:02 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 27, 2024 12:05 PM
>>
>> @@ -99,7 +99,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device
>> *dev, struct mm_struct *mm
>>
>>   	/* Search for an existing domain. */
>>   	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
>> -		ret = iommu_attach_device_pasid(domain, dev, iommu_mm-
>>> pasid);
>> +		handle->handle.domain = domain;
>> +		ret = iommu_attach_device_pasid(domain, dev, iommu_mm-
>>> pasid,
>> +						&handle->handle);
> 
> move the setting of handle.domain into the helper?

Yes.

> 
>> @@ -3382,11 +3383,9 @@ int iommu_attach_device_pasid(struct
>> iommu_domain *domain,
>>   		}
>>   	}
>>
>> -	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
>> GFP_KERNEL);
>> -	if (curr) {
>> -		ret = xa_err(curr) ? : -EBUSY;
>> +	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
>> +	if (ret)
>>   		goto out_unlock;
>> -	}
> 
> this leads to a slightly different implication comparing to the old code.
> 
> the domain pointer was always tracked in the old code but now the handle
> is optional.
> 
> if iommu core only needs to know whether a pasid has been attached (as
> in this helper), it still works as xa_insert() will mark the entry as reserved
> if handle==NULL and next xa_insert() at the same index will fail due to
> the entry being reserved.
> 
> But if certain path (other than iopf) in the iommu core needs to know
> the exact domain pointer then this change breaks it.

The iommu core should not fetch the domain pointer in paths other than
attach/detach/replace. There is currently no reference counter for an
iommu domain, hence fetching the domain for other purposes will
potentially lead to a use-after-free issue.

> 
> Anyway some explanation is welcomed here for why this change is safe.
> 
>> @@ -3414,7 +3413,7 @@ void iommu_detach_device_pasid(struct
>> iommu_domain *domain, struct device *dev,
>>
>>   	mutex_lock(&group->mutex);
>>   	__iommu_remove_group_pasid(group, pasid, domain);
>> -	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
>> +	xa_erase(&group->pasid_array, pasid);
> 
> if the entry is valid do we want to keep the WARN_ON() upon handle->domain?

The domain pointer has already been passed to the iommu driver in
__iommu_remove_group_pasid(). Therefore, the check for the pointer's
validity should be performed before calling
__iommu_remove_group_pasid(). Hence, in my view, using WARN_ON() around
xa_erase() is not very useful.

Best regards,
baolu
