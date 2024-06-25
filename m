Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95717C6C
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278445; cv=none; b=ZWgEP28imsO84xc9e11Pbla/aiPiWD7hasdWi+pcZvjqTMmXGJHzgWOVgDwL0Z0VglUgjz/yMOhZo4YdZTI2++segHsxTlvM2eqC4MWM5ouCK3R7GBZiqPURZK62GIBt1pODihvPAr/2W5gPZd+suNp0ncKBud9NvOuJX/ACGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278445; c=relaxed/simple;
	bh=U6XAiC13vaXq5UsI3E92/M07+WJrfK31lsjb3JRY1ps=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WmffY9AlAlJgFWFnRDnqPCYOKXj4DavUR8GQFnFhyott3hlGdjalv4YAUYTwIlMcPN7noIrK5a3AHKY9h7jbDrU1LBQP5/GRKoNvRO1wMYEm4OTngylCGsy72+mAAJgGKyJSKljGWA04cKXq6aosb4GQ2trHlCs/ervAwobiMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDk5OBnq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDk5OBnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719278444; x=1750814444;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U6XAiC13vaXq5UsI3E92/M07+WJrfK31lsjb3JRY1ps=;
  b=iDk5OBnqHtsmpzifI5bPjzQCSmRYYMo1nkqHlALCwvAHczP5deUUBLlT
   dCzKl6xF8imPaYw3ZtjeHeBZRQt6YKV0AFe9bmbDe2sLAGLcCou0bYRGh
   MDTYgOwzWjqyPaToeZBKYFmvGid5r7456I38l4NHj4vVXIRXgW039PqA/
   zxZhG6tlh1N+olAJmzVEPMYwmqG4PX5aoYEg0FwUPNjBXEIeldGWcfxhg
   +lbGfbqHemqVJ02O319W5MVvEy2luTAC9VlCnZgtskqGNaN/rrn2UZKuD
   AZoagIDpKNVr3FoCcmbiGh5Lotw9bGsIvODs7VgLdIzepQBqo3CWKpZj/
   A==;
X-CSE-ConnectionGUID: AhB5llWMS5mgHKf9henY8A==
X-CSE-MsgGUID: +pJjunLXQA+Vp121OBs0dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33812918"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33812918"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 18:20:43 -0700
X-CSE-ConnectionGUID: 2MUKm378QzWdCxybgJGdZA==
X-CSE-MsgGUID: NAxNJ6sbTpmExBVHbHA4Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48019532"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2024 18:20:41 -0700
Message-ID: <adac26cc-0d9e-4413-a0b7-c1d6929b9543@linux.intel.com>
Date: Tue, 25 Jun 2024 09:18:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [RFC PATCH] iommu/xen: Add Xen PV-IOMMU driver
To: Robin Murphy <robin.murphy@arm.com>, Teddy Astie
 <teddy.astie@vates.tech>, Jason Gunthorpe <jgg@ziepe.ca>
References: <fe36b8d36ed3bc01c78901bdf7b87a71cb1adaad.1718286176.git.teddy.astie@vates.tech>
 <20240619163000.GK791043@ziepe.ca>
 <750967b7-252f-4523-872f-64b79358c97c@vates.tech>
 <4ba90f86-fd14-4d2a-b7a0-c3eaab243565@linux.intel.com>
 <4c941977-868a-4bd0-9c57-eb58255d95bf@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4c941977-868a-4bd0-9c57-eb58255d95bf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/24 7:09 PM, Robin Murphy wrote:
> On 2024-06-23 4:21 am, Baolu Lu wrote:
>> On 6/21/24 11:09 PM, Teddy Astie wrote:
>>> Le 19/06/2024 à 18:30, Jason Gunthorpe a écrit :
>>>> On Thu, Jun 13, 2024 at 01:50:22PM +0000, Teddy Astie wrote:
>>>>
>>>>> +struct iommu_domain *xen_iommu_domain_alloc(unsigned type)
>>>>> +{
>>>>> +    struct xen_iommu_domain *domain;
>>>>> +    u16 ctx_no;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (type & IOMMU_DOMAIN_IDENTITY) {
>>>>> +        /* use default domain */
>>>>> +        ctx_no = 0;
>>>> Please use the new ops, domain_alloc_paging and the static identity 
>>>> domain.
>>> Yes, in the v2, I will use this newer interface.
>>>
>>> I have a question on this new interface : is it valid to not have a
>>> identity domain (and "default domain" being blocking); well in the
>>> current implementation it doesn't really matter, but at some point, we
>>> may want to allow not having it (thus making this driver mandatory).
>>
>> It's valid to not have an identity domain if "default domain being
>> blocking" means a paging domain with no mappings.
>>
>> In the iommu driver's iommu_ops::def_domain_type callback, just always
>> return IOMMU_DOMAIN_DMA, which indicates that the iommu driver doesn't
>> support identity translation.
> 
> That's not necessary - if neither ops->identity_domain nor 
> ops->domain_alloc(IOMMU_DOMAIN_IDENTITY) gives a valid domain then we 
> fall back to IOMMU_DOMAIN_DMA anyway.

Yes. That's true.

Best regards,
baolu
