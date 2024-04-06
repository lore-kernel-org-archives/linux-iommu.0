Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF5208D4
	for <iommu@lists.linux.dev>; Sat,  6 Apr 2024 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712384992; cv=none; b=ursqYAFDLoxeslBtX3b6kAkydJhMZSUn/ehUrYqJASm5+WIxYBHs8/cU1LUB+5XFyoiBn/yhwbQ8e5qDE0u0dZPPg6x8oZiTZBBXOuzd9shReafBZdjYYvpLKiyP1aMzHkEMd4ALrJ9g/rOtEak/rrEtiy+raaok1hAVrxhBjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712384992; c=relaxed/simple;
	bh=UMB1y8DSo+UPVEoOObQx/TI5qIqyG6i7IBdbk9Misvg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Eu5ql8gtgDn2Rpdm//Tp9C8ftxSgB2QE/CTEij9L86r0rYzjeZUu9nJpBiviCI3prqJU+Mc64gzP/M86XTU7AjkHMsxTFzSqY42eq6pp3qsQkdsA3pDZxN3fBwlAcxucguSgpsPqc0rVCoyRwuNvvtbudqeaBIz9WViV7ZHYbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQBVvc4t; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQBVvc4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712384991; x=1743920991;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UMB1y8DSo+UPVEoOObQx/TI5qIqyG6i7IBdbk9Misvg=;
  b=gQBVvc4tB2rMdX4lWCPe9oNyjXloP4nfQoeJeASjc1tv/ZXBQeoQMw4w
   A6BaCv3MKqQk8JIVD41mdiaDX3Pt13BuO6+Jt6kFGsBD+jaxF6Ku+M2NE
   H8xPn9ZmHkF0s8xJOiY1Lp1Y4FHwZdquwngvcN39i9xZXxYhGt7D1mGe1
   PSTDLGP9OtQlTtyHsgniUwbW8fIBUzBG1y989iJuv1Hsl5lj++Yl4eIiK
   DNZ57pMVh6PufHZU8sDYrI9nPsp6s0eUUZPdF4oA37R7Y83tg9fhWSnnk
   Do4DVdQDTXty4fsR2ktTOZkvonlHEQUDhqXsru5H7D2BvLdw/E1r7qiLx
   A==;
X-CSE-ConnectionGUID: /EQQTmS0TUW6kdAGSPXzrw==
X-CSE-MsgGUID: uv/VsCaBQ7WYLRXT7jVaiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7580661"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7580661"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 23:29:50 -0700
X-CSE-ConnectionGUID: bd3muIeKTE6+/DabsIqkTQ==
X-CSE-MsgGUID: iFs4qfuWTYqwAmrMEpV2hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="56858666"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 05 Apr 2024 23:29:47 -0700
Message-ID: <8b71bd41-dc1a-4a28-a380-8f470264f8da@linux.intel.com>
Date: Sat, 6 Apr 2024 14:28:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240403115913.GC1363414@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
>> -	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>> -	if (--domain->users == 0) {
>> -		list_del(&domain->next);
>> -		iommu_domain_free(domain);
>> +	iommu_attach_handle_put(handle);
>> +	if (refcount_read(&handle->users) == 1) {
>> +		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>> +		if (--domain->users == 0) {
>> +			list_del(&domain->next);
>> +			iommu_domain_free(domain);
>> +		}
>>   	}
> Though I'm not convinced the refcount should be elevated into the core
> structure. The prior patch I showed you where the caller can provide
> the memory for the handle and we don't have a priv would make it easy
> to put the refcount in a SVA dervied handle struct without more
> allocation. Then we don't need this weirdness.

It's fine to move the refcount out of the core and allow the caller to
specify and manage its own attach handler. The refcount would then be
managed by the SVA code.

For the IOMMUFD case, we've discussed that all outstanding iopf's
should be automatically responded in the detach process. This ensures
the attach handle won't be used once the detach process completes.
Therefore, if this is true, there appears to be no need for a refcount
for IOMMUFD.

> 
>>   	mutex_unlock(&iommu_sva_lock);
>> -	kfree(handle);
> Also do we need iommu_sva_lock here anymore? I wonder if the group
> mutex would be sufficient..

The iommu_sva_lock protects the whole process of a mm binding, from
pasid allocation to domain attachment. While the group mutex only
protects the data within it structure. I don't think we could replace
iommu_sva_lock with group mutex in this patch. Or any misunderstanding?

Best regards,
baolu
