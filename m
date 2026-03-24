Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950603A4F28
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331461; cv=none; b=fYZqD4D29kJTohN7qCdn0cf/767gDuEoIdEeFctfkpISSD2UIyI1b2C6F0KJNg/3m5Lu/7wTGFLYdOh9p6bHvqFMThUdluRDeGL0cbkGc9czlSe8ezkJ3QGm9YmF3tRMeJ5EOOTE0wR7+q4NxZnyamgO2x42L/DtlK+r+SdI8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331461; c=relaxed/simple;
	bh=k885x72Ya5uiV7AGu3ut3HNC+6QhEbIhM5rje7nHiVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCmKGKlIaNaGD59I1AcYm8fco3qrTBcB7RRTRC+WYxFICJps2DADrUAGpNZA/+e8zFw3kOHmyIJN9yaYyfa52BnClARHsb+U5aoRSdSqUiFKQH2y6xKe/Weohc703eiUb9NWjNt3tROQyACB7TWYnRgdjoAMBxY7FZGc2mHeTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLcUh0oB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLcUh0oB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774331459; x=1805867459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k885x72Ya5uiV7AGu3ut3HNC+6QhEbIhM5rje7nHiVg=;
  b=lLcUh0oBj0/OFM6YoJMLXvYcLqOGYU/GKPOSJSsjPU0S4IQG5orUtaDE
   sTd7al1gUF8qfgMDmFFs9BsS01FLfgAnH3Z2+/6umXeEUbBKwnCrLn1FM
   nf7Qqr6WyJscBSEjcuIX4xT77879YMlIdIlKAa/8wpQNMzndaWc2Xjeam
   F7he8J9hZ/RsNO/whTliZJBiUkyI/HFk9d2kiHID7ZZ9Co5FeEjRGeXqe
   HEqFG/FiM7wtIX8sXnd8xlpc/9fY7Kv+EzvOR30w7ar1MzBxpVhn2mnwl
   NYTbmmLsP0//ZvW6nujR5x67+eYZsq/a7T4D/Mexgdq9XplZFv+K1FrTp
   w==;
X-CSE-ConnectionGUID: KbF2+QnFQEKuq8hike5QsA==
X-CSE-MsgGUID: Q9H4g8CfSOScYFjoFngA1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74524387"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="74524387"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 22:50:58 -0700
X-CSE-ConnectionGUID: v8xZjOIPSWqSVE3kddvSAA==
X-CSE-MsgGUID: auo0UWbURdCqAINXBLW0KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224260312"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 22:50:55 -0700
Message-ID: <beef03b1-44fa-45de-9b66-fa1c8942bd0b@linux.intel.com>
Date: Tue, 24 Mar 2026 13:49:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Dmytro Maluka <dmaluka@chromium.org>,
 Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <abOjJf4HJ50vCIyg@Asurada-Nvidia>
 <02344098-c2da-4634-8f34-e03c88d030a2@linux.intel.com>
 <20260323125945.GD7340@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260323125945.GD7340@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 20:59, Jason Gunthorpe wrote:
> On Mon, Mar 16, 2026 at 02:24:57PM +0800, Baolu Lu wrote:
> 
>>>> +	writer->ops->get_used(entry, cur_used);
>>>> +	writer->ops->get_used(target, target_used);
>>>
>>> SMMU has get_update_safe now. Can we take it together?
>>
>> I will look into the SMMUv3 get_update_safe implementation. Or integrate
>> that specially when we transition the ARM SMMUv3 driver to use this
>> generic entry_sync library.
> 
> The intention was to copy the existing ARM code as is, the draft I
> sent was before these changes from Nicolin, so it should get updated..

Okay.

> 
>>>> +EXPORT_SYMBOL(NS(entry_sync_write));
>>>
>>> There is also a KUNIT test coverage in arm-smmu-v3 for all of these
>>> functions. Maybe we can make that generic as well?
>>
>> Same here.
> 
> That will be a bit hard since it depends on driver functions.
> 
>>> But maybe we could just call them:
>>>       entry_sync_writer_le64
>>>       entry_sync_writer_u128
>>> ?
>> I'm fine with the new naming. It is more explicit. I will update the
>> names unless there are further objections.
> 
> I was wondering if we should just be using void * here as the type
> safety seems a bit harmful if the goal is to make the 128 bit option
> fall back to 64 bits if not supported.
> 
> The maximum supported HW atomic quanta can be passed in through the
> struct.

I will explore refactoring the library to use void * and a dynamic
quanta size for v2.

Thanks,
baolu
