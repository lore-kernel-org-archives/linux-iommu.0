Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9343AB4
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697961; cv=none; b=m79WhQuob5aBVxt7o2xmqPbQ4Crik09y6OLQRfUMZK5YKd7QYpiTsCh7LDc4rHdT+HWoLhvnIEdQ32awrLX4i8oeftXhSfYQZfhvaQsbVgjkyMvQAi6PSomTjrzk2yjXi1y4QqM1Pw9rHPGYUC1OQNuZq6LGFUml45DdmM2S7DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697961; c=relaxed/simple;
	bh=EtGvGEZElsYS4fyScOlvnDWq7zYBUt5GQrukO64qXIU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dQqZEoGJDmT1LTvjShVd07v2c7h8fnoVCvABdKujLrZJZ6uHmnn6ItUxQ3VuyhC60F19c8Nstqq+SAyVXP1IMN0l96OyMtwObFpGbT+FX7IcW/KINEmyV64vhXfk+QkjxBf2XvclXkCSfU49H6NP3Wy7ZJnl/p9v1Fuzd+3pMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUoyIblL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUoyIblL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723697961; x=1755233961;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EtGvGEZElsYS4fyScOlvnDWq7zYBUt5GQrukO64qXIU=;
  b=GUoyIblLNz5eAvG7kCdG5TlCiMUXHF54hrxbTPcUSOkml8q8IplFZKyK
   KtabFGju9yenPahpXst33FfspwY/inLuW7kU+r+k/IbWdWwGmhjLQVHD+
   VlZZfuaBCsY4dD1zZqnrXWmvPk8Nj9RQrk7FVxJyXlRy+um0jtaUSO9wE
   kiAXUFXpNcK2awVhUNS8NHdvmVOpYXTULBCUQf7EEMudTgMPUA9awgDNu
   ACwB9xH8auuLaQjKeV1IaO4F96N45OgA/6IM/SytD7dkZ3qRJ83ujUB7s
   XnHzlFSXJPyvz/kJQ1NtmCqVD0oKDNgZPOm8UYTBmshAfzw5kA6KLT8Ih
   g==;
X-CSE-ConnectionGUID: +OMk291pTEyVrq6LBNmLjw==
X-CSE-MsgGUID: HWRJFVCLTumGi7cjXOzc4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33094668"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="33094668"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 21:59:20 -0700
X-CSE-ConnectionGUID: v8p/RHvlQHqEQ2DO+qgZ3Q==
X-CSE-MsgGUID: onmvrL/bTIyKyToAUWd8oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="64079401"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 21:59:16 -0700
Message-ID: <60778628-2b2c-4671-b1c6-276db3cd42ea@linux.intel.com>
Date: Thu, 15 Aug 2024 12:59:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/15 11:28, Vasant Hegde wrote:
> Jason, Kevin,
> 
> 
> On 8/15/2024 4:10 AM, Jason Gunthorpe wrote:
>> On Wed, Aug 14, 2024 at 02:38:58AM +0000, Tian, Kevin wrote:
>>
>>>> Flags = 0 means the domain cannot be attached to a PASID
>>>> Flags = 0 means the domain cannot be attached to the RID while PASID
>>>> is in use
>>>  From my understanding there are only two type of formats so far:
>>>
>>>    - a format only working with RID (V1 in AMD, S2 in ARM)
>>>    - a format working with both RID and PASID (V2 in AMD, S1 in ARM,
>>>     S1/S2 in Intel)
>>>
>>> With that in mind we only need one bit to indicate whether a domain
>>> allows PASID attach. The user learns the PASID capability via
>>> GET_HW_INFO and should set or clear the PASID flag consistently
>>> for all non-nesting domains attached to a same device (RID, or RID+PASID).
>>>
>>> for AMD/ARM this consistency is mandatory as one device can only be
>>> configured to a single format. no mix.
>>>
>>> for Intel there's more flexibility but I don't see a reason to mix S1/S2
>>> between RID and PASID, and now both are fixed to S2 for UNMANAGED.
>>>
>>>> The core code should enforce this rule always.
>>>>
>>>> Above that we minimally need
>>>>
>>>> Flags = IOMMU_HWPT_ALLOC_PASID allows the domain to be attached to a
>>>> PASID
>>>>
>>>> And you need to decide if the RID usage is bundled with the above as
>>>> well.
>>> A single bit IOMMU_HWPT_ALLOC_PASID is what I meant. Setting it
>>> means the domain can be attached to both RID and PASID, i.e. RID
>>> attach is always implied.
>> OK, lets try it like that then
>>
>> I also know of no HW that would need it to be different on the RID
> Ok. Single macro with `IOMMU_HWPT_ALLOC_PASID` which allocates PASID capable
> domain if both IOMMU and device supports the feature. If not allocate normal
> domain -OR- return error?
> 
> Also I would assume we want to enhance iommufd_get_hw_info ioctl to get device
> PASID capability. Is that correct?

I suppose that this also includes converting paging domain to user
domain allocation in VFIO (ideally vhost-vdpa as well), right?

Thanks,
baolu
