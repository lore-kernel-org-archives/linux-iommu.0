Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD4629
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729486950; cv=none; b=gghduJBT4IqldrzYeHD6TDckxCRZUk5C6fN10elOvxk6PTKefOOaHSRO4LwhNsJQjKo0LaH+dhwWxkP+z2ct0iptgeKSNuyKlJKr4gw2rku2cELi43VLrfnLbZ1vr5Wc3vOdlYzKjRfz2zBCZDQnD1TL8OwaPy8CjOPgomrBZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729486950; c=relaxed/simple;
	bh=vLR8N0I/7PZfsyTiwfofHUGMirKk9BoUaPdDcZFKE8o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GatgjtzR47pd6aPd7YJ+aOHucbC8RDsuQk++CH7U9pAjZD+BUJjXHAgQQiY5knb40yz3gC5duuZIg5myxuk6hq5ZX1p/3f0s4n6lWGveWxjay7gIGuDnsgbaJzlD8Fguzzjxdx5yQDZR9zvksKfSTa2u9Ewa1jGYzmjcghIIL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJE5DW94; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJE5DW94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729486949; x=1761022949;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vLR8N0I/7PZfsyTiwfofHUGMirKk9BoUaPdDcZFKE8o=;
  b=iJE5DW94uInsdCNNpT8HfbTQunY2djkO6OcuZiExzS9hY0jNQkYlUQWP
   vUF+8rEU27zvnT519BOZ/zzpvIt2u6/SVdI2HLa6F8l9Dw3oO62pEXVB/
   PQeaozwKjOzltYDxavgs8IBz3miPydJbXNMSogq8VdqniaRvXgSFMfi52
   pGkb8JkVh2UpTfRQJLHp0Kwti6Op27a0UwjyXfPyQauZReZGB4YPLadVD
   F+2IEEEOR1p9s68ffdljxaz0nulHVFwuq2ELY/NqFUsJTfpJhazR+WibJ
   R1h8rrhu4NTgWn+RMvxd2Wadcao1UDlz23txBUsytAaKyb5HCkiv/K4no
   w==;
X-CSE-ConnectionGUID: xLt8p5k0TK27265b2SvR/w==
X-CSE-MsgGUID: SE5InpFcRL+UsaWmEzZW4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="28832059"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="28832059"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 22:02:28 -0700
X-CSE-ConnectionGUID: EsjlBKJ0Svei76Pxh+CH+A==
X-CSE-MsgGUID: YhbeeKB8RxKHawO2qTt5kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="116869581"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 22:02:24 -0700
Message-ID: <e68bdd82-077e-481f-968a-4302e1b1b77d@linux.intel.com>
Date: Mon, 21 Oct 2024 13:02:22 +0800
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
 kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID
 capable domain
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-4-vasant.hegde@amd.com>
 <798b486e-ec49-4f51-89d4-a2083bdaddf1@linux.intel.com>
 <20241018124328.GE948948@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241018124328.GE948948@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/18 20:43, Jason Gunthorpe wrote:
> On Fri, Oct 18, 2024 at 11:43:02AM +0800, Baolu Lu wrote:
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 9f6b0780f2ef..d7546ab18e18 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3539,12 +3539,16 @@ intel_iommu_domain_alloc_user(struct device *dev,
>> u32 flags,
>>          }
>>
>>          if (flags &
>> -           (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
>> +           (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
>> +              IOMMU_HWPT_ALLOC_DIRTY_TRACKING) |
>> +              IOMMU_HWPT_ALLOC_PASID))
>>                  return ERR_PTR(-EOPNOTSUPP);
>>          if (nested_parent && !nested_supported(iommu))
>>                  return ERR_PTR(-EOPNOTSUPP);
>>          if (user_data || (dirty_tracking && !ssads_supported(iommu)))
>>                  return ERR_PTR(-EOPNOTSUPP);
>> +       if ((flags & IOMMU_HWPT_ALLOC_PASID) && !pasid_supported(iommu))
>> +               return ERR_PTR(-EOPNOTSUPP);
> I think the decision here should only be about supported domain
> type. Like on AMD if the iommu instance doesn't support v2 then it
> should fail.
> 
> If there is some other thing that says the instance supports pasid,
> that should be checked during attach time only.
> 
> IIRC intel can use either page table format for pasid, so it probably
> doesn't need to do anything here?

yes.

Thanks,
baolu
