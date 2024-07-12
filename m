Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D1567D
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720748599; cv=none; b=BNN1QfUCl+u38gsQbMmvMYWpGwtohyt7QqnS5xWk1gCOOQ3tGzcu62GF9RH8dHVVNmZM74j1tY2UdkRFBqveIAz5rlXYPv/Z6cPNSsOKjCKixQctVgoE1XOcdmNl4OqAujwVlhfcXRMZTjoobGRdTcBTuONjbgp5FZp+voZ/+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720748599; c=relaxed/simple;
	bh=Qs8snwVjLvbCvsKZo4DAwGXwoc+Pb9ZkyH0ihWbcFTI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g+WylJvO8o2l1RKfLZzglsGPh2j+xnHf3rIhPeLiPpFzP9A54dOQejqhbPZZo4aEytN7UL9+uBZgRKksRX1oYuUxtt0cuZJk34WhHVRIOQLINWvROhTSdI2U6CaYc3sni476pj1yQNAwEOKGYcztJ/SKy3BHJWWayLwLz7ebnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQ/wMdcG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQ/wMdcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720748598; x=1752284598;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qs8snwVjLvbCvsKZo4DAwGXwoc+Pb9ZkyH0ihWbcFTI=;
  b=fQ/wMdcGvFpwEk7B19yHFUQ/fJJzncVHtXoBsFmkxEJihO1mu14Q8Iwu
   edUgiDTJbpdQL+ofZXt1IKFy/UVrX3XPptoRx+Ib5jcxvjydytJOEPt3+
   GhCdUXyCNYylYA7wVdf7L2fSC8sa9dEJ4arnm7HHUBTn1JPqcqzrYQG0w
   V4PFClHRuHwCyUz+zk/D1UZozq6VPbMJL/wxrRwHXLsgbXtmEZb62q8ne
   O2j4xY+4JdG1NiSxLfas8W5RD2Lg1AStwAXwsa59lCwwxTXZrrBrjy7cE
   aUPNljq66aK6SPuVZ7VzDvRKtDpEIeDMoKExZFxdt+WvknuuDIboHp/fS
   g==;
X-CSE-ConnectionGUID: 4T9Gz3nSQB6JwmGR8hpYhw==
X-CSE-MsgGUID: +hK2fqolREeZIeTa9jdQKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18017948"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="18017948"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 18:42:50 -0700
X-CSE-ConnectionGUID: 9sr7lJJCQt+1HnPBuO61Dg==
X-CSE-MsgGUID: D/5K5hKdQ1ejwHjOGH/HHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="48849974"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa009.jf.intel.com with ESMTP; 11 Jul 2024 18:42:47 -0700
Message-ID: <f75d4ce8-d4e2-414b-b3c4-76abef779eb4@linux.intel.com>
Date: Fri, 12 Jul 2024 09:39:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <4ffc953f-4968-46c7-b6a0-b7b2fc454564@amd.com>
 <71880aa8-adb9-4f3f-ba9a-7862e8d30b46@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <71880aa8-adb9-4f3f-ba9a-7862e8d30b46@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 9:56 PM, Yi Liu wrote:
> 
>> For UNMANAGED domain (like vfio-pci), we would need a indication from 
>> core layer
>> saying whether we want to allocate PASID capable domain or not. So that
>> internally we can allocate appropriate page table type.
>>
>> That means from VFIO layer we need to pass this detail to IOMMU layer.
>> For this part, I will start watching your patch. May be we can start 
>> discussion
>> in that thread itself.
>>
> 
> yeah. Looks like you need to pass a hint to iommu driver for domain
> allocation. For the usage vfio+iommufd, it is fine as the domain_alloc_user
> accepts a flag. For legacy vfio (using vfio iommu type1) usage, it's a bit
> tough as the domain allocation is within kernel, userspace does not have
> any input on it so far. And vfio type1 does not expose the domain concept
> to userspace, it only exposes container which is kind of an address space
> object. This means no good way for userspace to control the domain
> allocation.
> 
> If it's only a matter when PASID is enabled, perhaps we can skip vfio iommu
> type1 as it is not supposed to support PASID.

As we have already agreed that new features should go through IOMMUFD
and vfio/type1 is only kept for legacy compatible purpose, I don't think
we need to carry any PASID bits in the vifo path. Did I miss anything?

Thanks,
baolu
