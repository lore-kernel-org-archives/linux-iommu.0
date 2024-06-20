Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40D2B9B8
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864859; cv=none; b=jJay0fRsdgr4RVK6sJt1RiG3rJLq40a2dsu9G7gZwkEY/RjlSRN12pGwTQMXcU3g/8IsqN7MKt7HVEfTxkRHLE/Q5JhvIQ1AuLvCaTT8wnBHm3yctp4Cz2kOwtXIzmEG296YEyEcU0Qi/V1sD4LlN00sHWQDOwRwHGjLZu7uTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864859; c=relaxed/simple;
	bh=4K30b5dp3sj+V+cw881bFFO4IS728f+ho2gPwsieBCs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JMJFi7KCY2M9oyADthf0DuM7Fx1xb+eraqI051wEcHL167y+hz56WsTtQBSGDCXBIB2cQ8XRYE+gdmWBFKRGLv9zc7DDXfNtRFy5qNxcYGmmM7oOoj7j4zsZEgDiD6MHobgFGCAeigyR1BKYgXUiRMHATDsCEyyMy3Ej7K4HPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhaKJdMV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhaKJdMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718864858; x=1750400858;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4K30b5dp3sj+V+cw881bFFO4IS728f+ho2gPwsieBCs=;
  b=UhaKJdMVmRg3vgLXJPg+LUPJw18i/sLBU7Bz94zee3VC6CZ21bWb7CUW
   Nj3lknqgveaTufZxcAein1bLg4hLk9A084v4JyXxUhkVxgPBJTLB5fymd
   f3NHh3iXNOjKSDNj/k2n1N+y/1EZha4GQCHIxNZtHhaE2RyohR07V6Qdx
   vEjFea6DWRKUjtahGUPEJO9RLwrN9K8Lb68jxmNtfLFfq2JprTkERajCD
   vJn3sIvxTWQrSHiJc37wVgmYJtt++WqfwL8OwZzPasORAvDcE1WIpK32W
   Ko8tepGiZH+jvmXpjE59djuJf7YsggAi1G+OvhvpiyaAx/cBCDCJq2uSF
   A==;
X-CSE-ConnectionGUID: MWLcg+9STCKTKQyv/Kem+w==
X-CSE-MsgGUID: n/gy/9Q3Tymy/8LDGnV6Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15652775"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15652775"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:27:37 -0700
X-CSE-ConnectionGUID: nWcQuqGATX2PF1ovSj6dzA==
X-CSE-MsgGUID: LVAjM0a4T6KPM0RxYaGT9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42592334"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:27:35 -0700
Message-ID: <8c78f966-539c-4c81-92a6-32d32bb10e8b@linux.intel.com>
Date: Thu, 20 Jun 2024 14:27:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
To: Vasant Hegde <vasant.hegde@amd.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
 <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/20 13:54, Vasant Hegde wrote:
> On 6/20/2024 8:43 AM, Baolu Lu wrote:
>> On 6/20/24 11:04 AM, Tian, Kevin wrote:
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Thursday, June 20, 2024 8:50 AM
>>>>
>>>> On 6/20/24 12:46 AM, Jason Gunthorpe wrote:
>>>>> On Wed, Jun 19, 2024 at 09:53:45AM +0800, Lu Baolu wrote:
>>>>>> When a domain is attached to a device, the required cache tags are
>>>>>> assigned to the domain so that the related caches could be flushed
>>>>>> whenever it is needed. The device TLB cache tag is created selectively
>>>>>> by checking the ats_enabled field of the device's iommu data. This
>>>>>> creates an ordered dependency between attach and ATS enabling paths.
>>>>>>
>>>>>> The device TLB cache tag will not be created if device's ATS is enabled
>>>>>> after the domain attachment. This causes some devices, for example
>>>>>> intel_vpu, to malfunction.
>>>>> What? How is this even possible?
>>>>>
>>>>> ATS is controlled exclusively by the iommu driver, how can it be
>>>>> changed without the driver knowing??
>>>> Yes. ATS is currently controlled exclusively by the iommu driver. The
>>>> intel iommu driver enables PCI/ATS on the probe path after the default
>>>> domain is attached. That means when the default domain is attached to
>>>> the device, the ats_supported is set, but ats_enabled is cleared. So the
>>>> cache tag for the device TLB won't be created.
>>> I don't quite get why this is specific to the probe path and the default
>>> domain.
>> The issue is with the domain attaching device path, not specific to the
>> probe or default domain.
>>
>>> dmar_domain_attach_device()
>>> {
>>>      cache_tag_assign_domain();
>>>      //setup pasid entry for pt/1st/2nd
>>>      iommu_enable_pci_caps();
>>> }
>>>
>>> seems that for all domain attaches above is coded in a wrong order
>>> as ats is enabled after the cache tag is assigned.
>> Yes, exactly. But simply changing the order isn't future-proof,
>> considering ATS control will eventually be moved out of iommu drivers.
> [Unrelated to this patch]
> 
> You mean ATS setup will be moved to individual device driver? Is there any
> reason for that?

Not exactly to individual device drivers, but it should be out of the
iommu drivers.

https://lore.kernel.org/linux-iommu/BL1PR12MB51441FC4303BD0442EDB7A9CF7FFA@BL1PR12MB5144.namprd12.prod.outlook.com/

Best regards,
baolu
