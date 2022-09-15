Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B97F
	for <iommu@lists.linux.dev>; Thu, 15 Sep 2022 07:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663226492; x=1694762492;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cs0ARHqTg/sLxBqGoBiCU8P4JJO3ea/6zqkCpGynC1g=;
  b=ke6FfvOl+uCQboaUxPvRQ5llTMub+GAxZAYyDFJtK2j+6HhEho3w7EK7
   pnNtcn6sGpq8WdRXOM3Q/O5cJpI3aa6dK4N7D0GinyN3N5lwLz4ffqHr0
   dQ+xstFrcsSByYWirMW7HVM+avU/2mkW7UArlI6/KN/3rykfojy/VKMcQ
   BmlKn45zP0IgqsBW7D7vGZP3FKmZrV6JJ/lvF1UpTw2wWNUoeiLrA/gOY
   XXPmEF7n8bSwtWsy75UumZi5kj8JFVfw0QIlkIKFmNc7gprnvQbO6j+3o
   f44U8Uyw5bvQhldBphzVyZMys3fyFZYGWvl07w/qaqqDhQiJZgXz4cXtP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="297364517"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="297364517"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 00:21:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="568322212"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.238]) ([10.254.208.238])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 00:21:20 -0700
Message-ID: <78da3b7e-c930-f433-8c80-b1ac53f9ab58@linux.intel.com>
Date: Thu, 15 Sep 2022 15:21:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52766A868879689D55AE9DC68C479@BN9PR11MB5276.namprd11.prod.outlook.com>
 <826a10fa-7dc3-887d-8a08-e03dcf1fa59c@linux.intel.com>
 <BN9PR11MB527688C87CEA57CACD5324608C499@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527688C87CEA57CACD5324608C499@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/15 11:22, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, September 13, 2022 5:25 PM
>>
>> On 2022/9/13 16:01, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Monday, September 12, 2022 10:48 AM
>>>>
>>>> @@ -1401,7 +1403,6 @@ static void iommu_enable_dev_iotlb(struct
>>>> device_domain_info *info)
>>>
>>> This is not the right name now as dev_iotlb is only related to ATS.
>>
>> Yes. This name is confusing. Perhaps we can split it into some specific
>> helpers,
>>
>> - intel_iommu_enable_pci_ats()
>> - intel_iommu_enabel_pci_pri()
>> - intel_iommu_enable_pci_pasid()
>> ?
> 
> Probably intel_iommu_enable_pci_caps()

It's better.

> 
>>
>>>
>>>>    		info->pfsid = pci_dev_id(pf_pdev);
>>>>    	}
>>>>
>>>> -#ifdef CONFIG_INTEL_IOMMU_SVM
>>>>    	/* The PCIe spec, in its wisdom, declares that the behaviour of
>>>>    	   the device if you enable PASID support after ATS support is
>>>>    	   undefined. So always enable PASID support on devices which
>>>> @@ -1414,7 +1415,7 @@ static void iommu_enable_dev_iotlb(struct
>>>> device_domain_info *info)
>>>>    	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)
>>>> &&
>>>>    	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
>>>>    		info->pri_enabled = 1;
>>>> -#endif
>>>> +
>>>>    	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>>>>    	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>>>>    		info->ats_enabled = 1;
>>>
>>> iommu_enable_dev_iotlb() is currently called both when the device is
>> probed
>>> and when sva is enabled (which is actually useless). From this angle the
>> commit
>>> msg is inaccurate.
>>
>> The logic is a bit tricky. iommu_support_dev_iotlb() only returns a
>> devinfo pointer when ATS is supported on the device. So, you are right
>> if device supports both ATS and PASID; otherwise PASID will not be
>> enabled.
> 
> Yes, that is what the first part of this patch fixes.
> 
> But my point is about the message that previously PASID was enabled
> only when FEAT_SVA is enabled and now the patch moves it to the
> probe time.
> 
> My point is that even in old way iommu_enable_dev_iotlb() was called
> twice: one at probe time and the other at FEAT_SVA. If ATS exists
> then PASID is enabled at probe time already. If ATS doesn't exist then
> PASID is always disabled.
> 
> So this patch is really to decouple PASID enabling from ATS and remove
> the unnecessary/duplicated call of iommu_enable_dev_iotlb() in
> intel_iommu_enable_sva().

Yes. Exactly. I will rephrase the commit message and send a v2.

Best regards,
baolu
