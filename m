Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1917AE12
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038289; cv=none; b=d20nUOOXECetW2wq9UJRb44jk6JZUC0YDeavoQVtxN+pjCTmWnLEag+5bLDHHrhTM5bUWziULGh6WDbDN32acTRSVluQTANv3723jFlIXA5ZP0EqfqY1YOtZ1SFFfGatJFSIXROFAexrNv5KXNVgSuJuWnA1bvkLWOWpaRydDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038289; c=relaxed/simple;
	bh=YbiRuZqFbYuSNax1zoWq9R2X/At7541H2Uhgv1dAU0Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tLtYxfoGGf5OZE8sjBz9aIrSeqkqI2axWor1aeBJLQ7KKKdpFTtRYAtMpsVTrURG6tuy138aHABnrXlzO6QuJVBLb4LCFwM1cPaJ/dUeZ1OIgppr8jWRTMzxeGEO8ObFGou79/Erh7gXQm3EQ2E1jfCcdc66ObDMrCmYjfvUfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kg7JPJio; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kg7JPJio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723038288; x=1754574288;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YbiRuZqFbYuSNax1zoWq9R2X/At7541H2Uhgv1dAU0Y=;
  b=kg7JPJioDSajkiJ1T2qEr/jv/cF/ZXNu/XUZwidKQ2VkJ6vyd7XCJz3K
   2/pPGWF4ka6fx9JMBxLs7bAQXXT26t27zuL7WzRRB74uaH4btk/NyfIGJ
   0u9V7rVrZlMt+cnRp6l7+sIEBmTXkQFPZdnejJe0r58cNEPe4ap4S930/
   lOs21r8baXq4ZAqQ1GSNSKm3BV9Z9UNkYyHFpvCUDhQSRACWmhJu1wvCL
   d6frukUn5x0BqfsvFAJ4XHtQL1E9fFcj+QNxgNkMVvs1PJHHaF6TGyt6/
   7WuUsWAQEfNrbLAxUwWvgW2MjFBjJQXBoE9Esp6LD2goD5upGHxhjM99F
   g==;
X-CSE-ConnectionGUID: PtGAYqyjRbuxczZR0rsN1A==
X-CSE-MsgGUID: nLktdJy4QfizbippbWQ8qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="24984725"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="24984725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:44:47 -0700
X-CSE-ConnectionGUID: 2OUDSPMBTLq9rTym9ACm1Q==
X-CSE-MsgGUID: JD/ng8w9QLatwK/968S6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="94432182"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:44:45 -0700
Message-ID: <4d273959-5925-4df5-929a-88cd5c31748a@linux.intel.com>
Date: Wed, 7 Aug 2024 21:44:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Prepare for global static identity
 domain
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-5-baolu.lu@linux.intel.com>
 <20240806171236.GM676757@ziepe.ca>
 <9aa9e93e-915e-4c6d-9adb-b7d5facdf3bc@linux.intel.com>
 <20240807121712.GD8473@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240807121712.GD8473@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/7 20:17, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 02:41:39PM +0800, Baolu Lu wrote:
>> On 2024/8/7 1:12, Jason Gunthorpe wrote:
>>> On Tue, Aug 06, 2024 at 10:39:38AM +0800, Lu Baolu wrote:
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index c019fb3b3e78..f37c8c3cba3c 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -1270,6 +1270,9 @@ void domain_update_iotlb(struct dmar_domain *domain)
>>>>    	bool has_iotlb_device = false;
>>>>    	unsigned long flags;
>>>> +	if (!domain)
>>>> +		return;
>>>> +
>>> This seems really strange, maybe wrong..
>>>
>>> The only callers that could take advantage are
>>> iommu_enable_pci_caps()/iommu_disable_pci_caps()
>> Yes.
>>
>> When the PCI ATS status changes, the domain attached to the device
>> should have its domain->has_iotlb_device flag updated.
>>
>> The global static identity domain is a dummy domain without a
>> corresponding dmar_domain structure. Consequently, the device's
>> info->domain will be NULL. This is why a check is necessary.
> I get it, but you can't have ATS turned on at all if you can push the
> invalidations. So it seems like something is missing to enforce that
> with the identity domains.
> 
>>> So I looked at this and, uh, who even reads domain->has_iotlb_device ?
>> The has_iotlb_device flag indicates whether a domain is attached to
>> devices with ATS enabled. If a domain lacks this flag, no device TBLs
>> need to be invalidated during unmap operations. This optimization avoids
>> unnecessary looping through all attached devices.
> Not any more, that was removed in commit 06792d067989 ("iommu/vt-d:
> Cleanup use of iommu_flush_iotlb_psi()")

Yeah! How stupid I was! It's actually a dead code after the
implementation of cache tags.

> 
> This compiles, so you should do this instead:

Yes. I will cleanup this in a separated patch.

Thanks,
baolu
