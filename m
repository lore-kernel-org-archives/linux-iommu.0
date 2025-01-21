Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C131D554
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737425078; cv=none; b=CRHFxXZoG7xDPAhFVAAFmiyJ9nRx0IjjOhIa/MU4q59wh5X7f2JIcAAWcO0yDpeLctttEWLfEtn7Apsd3+6foglagtjiCeKonkNXOaJCsJtXZo6FbO5N5uWTPTXuzidKpbVolmcowS9MTChWCb3D0WxAReZ47dEmbf1fAxqoFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737425078; c=relaxed/simple;
	bh=CmrYHOARt2HUIqBVGEG2ajX7wHZBZobv4TrXZTMBb6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTFw4fNLxfqS9O4fUa1TeY7WO+im3aRm2VSKKFnZrLOG7CH0+XyDRM3znVShiIbMToS6yVVm2olcVKy/EZC451ECEXEMkuluezX6VNJRBTWEYFREgaDPmCZR8K5VdO/RHygCgcKVjgXxFd6+JpDldgxZZIWgPHzGpQNKQbvZ6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVC2aR0W; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVC2aR0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737425077; x=1768961077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CmrYHOARt2HUIqBVGEG2ajX7wHZBZobv4TrXZTMBb6Q=;
  b=SVC2aR0WZ3FdeHDXROdnJQh5rtju7+pv22kk2utGCXG+97xgtg6pOkG8
   B5IfSmHSxLqAMYjIU0+a6vgzaClHQhI8+fG6FPQStayMWZAFjqCsW3ui2
   sz7DnwoPoRvGxKL5efKm0H79utC3iC9eWJ7dWkJoqEbAL6F21djeNuwaJ
   OS+Ru/TpDnyHK6tiM2MskpREJKhxg7GbsL2ErIT+oZMm255M17AhMvCaI
   hKacGDtoG+wvFYJWqpuYRrDE1eD4IjUQhBuuTkyMzCPgGOHVHt5dZiSnJ
   dk6NyZxBWahDIQghNV7oY1+ff4zCYaT9BTU2fn/cbEhiaEgVNbmDqKhQg
   Q==;
X-CSE-ConnectionGUID: /bZP53qiTROrdEIJRsmrDQ==
X-CSE-MsgGUID: OxmpbaLhQ5yBF+fsYIeFmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37096313"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; 
   d="scan'208";a="37096313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 18:04:36 -0800
X-CSE-ConnectionGUID: KKdTg2CnQp6plGz8ZVLUBA==
X-CSE-MsgGUID: 1iq7ivpGQuinlnGhQpJ/Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129926716"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 18:04:34 -0800
Message-ID: <220d60c8-036e-4394-85e6-334a8d09a8fd@linux.intel.com>
Date: Tue, 21 Jan 2025 10:02:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Store either domain or handle in
 group->pasid_array
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, iommu@lists.linux.dev,
 jacob.pan@linux.microsoft.com, robin.murphy@arm.com, nicolinc@nvidia.com,
 will@kernel.org
References: <20250120030840.4171-1-yi.l.liu@intel.com>
 <20250120030840.4171-2-yi.l.liu@intel.com> <20250120155535.GK5556@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250120155535.GK5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/25 23:55, Jason Gunthorpe wrote:
>> @@ -3397,10 +3400,14 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   		}
>>   	}
>>   
>> -	if (handle)
>> +	if (handle) {
>>   		handle->domain = domain;
>> +		xa_entry = xa_tag_pointer(handle, IOMMU_PASID_ARRAY_HANDLE);
>> +	} else {
>> +		xa_entry = xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
>> +	}
> What about iommu_attach_group_handle() ?
> 
> 	mutex_lock(&group->mutex);
> 	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> 	if (ret)
> 
> And iommu_replace_group_handle() ?
> 
> 	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> 
> I think it should be consistent and it should call xa_tag_poiner() too
> (even though it implicitly always is since the domain is stored in the
> group)??

We may eventually consider retiring group->domain.

---
baolu
