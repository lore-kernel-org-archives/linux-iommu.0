Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C628376
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654130; cv=none; b=dyhZIPqNOli6WByRLrwfbq4gdRVOhwjCCu1OqQjoLzEqgcf+gx8ek4QSEBoSTlVJCKk5XF4HDWYKFij1oMkMqxW2Vd/0a2yBrh0GuS5LdkY0rbEUYl2Z4Mm6dNulmfGSIQ1kXole9S0dAcFxr4ka/7sbMaibEkHEL+VNap7x2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654130; c=relaxed/simple;
	bh=13akkfKAq2hsSCLQoZwEGPw7tB5uWCBWFWWz8dMiHsQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=akFD9zI8DkwmGzN20gIXuVXJ7me3USsAB7wOvySVdOOImzqIeBmtnEtksEgVg4ETP02KG2kjg74gOY8o0dev+c3OgpOH2mzIbiMbC6OeOvFY1GFy79cRitwq6FVrW72uI5kLOdJWpjjYFfXfXMbnzcTjM+r3l/Z6/E1orycyeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCZXbMKE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCZXbMKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717654127; x=1749190127;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=13akkfKAq2hsSCLQoZwEGPw7tB5uWCBWFWWz8dMiHsQ=;
  b=jCZXbMKEDHHvI4y6nuqEGQuaHalM+qfjCxaqz1qeRcWEzIH2Xs2YSs1S
   /7eZREiK7WdylUbDFYsVSlpOfb4uOy9Qsi8yb5dQY0azYsrbv5645rFbV
   SfInkiwV8jWmRmEoEaxgY1Hq03wTBE6IDRn4XFoxlLppDUZsKI9tMkoE0
   TCPnhXitP0lFtF2joQIGL47GFBAC5f0pKO8sZ38m+4TTsgRqICQs7M3uF
   7N55P9U8daWVDAZL0juRFZfgrYImsqZUJsGU0HYRpaqaVHWN3lTL8Ct1J
   x+NEuHqEPBYPTIdZzJjshqrHlx+QlvYYYu2ETFQieVaYzjNDkRKitpDFm
   w==;
X-CSE-ConnectionGUID: xrJ/O48FTgO3C5V4ThFoSQ==
X-CSE-MsgGUID: tGl8AxibQOu5VUXdIuIiDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14104137"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14104137"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 23:08:46 -0700
X-CSE-ConnectionGUID: v7Q61PdfSESz90u4pDDIQA==
X-CSE-MsgGUID: MzwVyrGjSHCTg59Wl3M16w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="68663885"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 05 Jun 2024 23:08:43 -0700
Message-ID: <afaf133b-7175-467f-a254-060b66b9cb4e@linux.intel.com>
Date: Thu, 6 Jun 2024 14:06:32 +0800
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/10] iommu: Remove sva handle list
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527658A85092F88329EB73E98CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527658A85092F88329EB73E98CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 4:15 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 27, 2024 12:05 PM
>>
>> @@ -69,11 +68,16 @@ static struct iommu_mm_data
>> *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>>    */
>>   struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
>> mm_struct *mm)
>>   {
>> +	struct iommu_group *group = dev->iommu_group;
>> +	struct iommu_attach_handle *attach_handle;
>>   	struct iommu_mm_data *iommu_mm;
>>   	struct iommu_domain *domain;
>>   	struct iommu_sva *handle;
> 
> it's confusing to have both 'handle' and 'attach_handle' in one function.
> 
> Clearer to rename 'handle' as 'sva'.

Yes. Could be cleaned up in a separated patch. All sva handle in
iommu-sva.c should be converted if we decide to do that.

> 
>>   	int ret;
>>
>> +	if (!group)
>> +		return ERR_PTR(-ENODEV);
>> +
>>   	mutex_lock(&iommu_sva_lock);
>>
>>   	/* Allocate mm->pasid if necessary. */
>> @@ -83,12 +87,13 @@ struct iommu_sva *iommu_sva_bind_device(struct
>> device *dev, struct mm_struct *mm
>>   		goto out_unlock;
>>   	}
>>
>> -	list_for_each_entry(handle, &mm->iommu_mm->sva_handles,
>> handle_item) {
>> -		if (handle->dev == dev) {
>> -			refcount_inc(&handle->users);
>> -			mutex_unlock(&iommu_sva_lock);
>> -			return handle;
>> -		}
>> +	/* A bond already exists, just take a reference`. */
>> +	attach_handle = iommu_attach_handle_get(group, iommu_mm-
>>> pasid, IOMMU_DOMAIN_SVA);
>> +	if (!IS_ERR(attach_handle)) {
>> +		handle = container_of(attach_handle, struct iommu_sva,
>> handle);
>> +		refcount_inc(&handle->users);
>> +		mutex_unlock(&iommu_sva_lock);
>> +		return handle;
>>   	}
> 
> It's counter-intuitive to move forward when an error is returned.
> 
> e.g. if it's -EBUSY indicating the pasid already used for another type then
> following attempts shouldn't been tried.
> 
> probably we should have iommu_attach_handle_get() return NULL
> instead of -ENOENT when the entry is free? then:
> 
> 	attach_handle = iommu_attach_handle_get();
> 	if (IS_ERR(attach_handle)) {
> 		ret = PTR_ERR(attach_handle);
> 		goto out_unlock;
> 	} else if (attach_handle) {
> 		/* matched and increase handle->users */
> 	}
> 
> 	/* free entry falls through */
> But then there is one potential issue with the design that 'handle'
> can be optional in iommu_attach_device_pasid(). In that case
> xa_load returns NULL then we cannot differentiate a real unused
> PASID vs. one which has been attached w/o an handle.

The PASID should be allocated exclusively. This means that once a PASID
is assigned to A, it shouldn't be assigned to B at the same time. If a
single PASID is used for multiple purposes, it's likely a bug in the
system.

So the logic of iommu_attach_handle_get() here is: has an SVA domain
already been installed for this PASID? If so, just reuse it. Otherwise,
try to install a new SVA domain.

> Does it suggest that having the caller to always provide a handle
> makes more sense?

I'm neutral on this since only sva bind and iopf path delivery currently
require an attach handle.

Best regards,
baolu
