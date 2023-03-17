Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C8377
	for <iommu@lists.linux.dev>; Fri, 17 Mar 2023 00:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679014068; x=1710550068;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ykYG82z5mHxoqH9AyNm4njZqoTQYz7loMeJ7mZo0a7o=;
  b=Ycd4NCcjRJkIqzV0tQQzKRaCRnDc3IcF/v0YRNr4mKgP4G10SI08HGWW
   joRlpeXSRQLCXryajUYLUfCT6gs9vOs1o/lNDb1+QXzyBKIT0bEmudRay
   M+X4C4sETZaZ4MsbMcsY2KGwjLPlzKY8JR/U8dp405QnnWah/mQVUqCTK
   EzzacDZx1nBdq6BkkNEf/HFIKtMmENc361w7fRepIdavgi2PdARrNkS1w
   1Cs90p2iXa+cWeLxaMSlhdCy9pv1J90twa/KOBvXc/nMIo5jz/VrssmL2
   BMjvfa6UZuK9JUJkfmfncnllbV8aDI8QpvPv4dRKOTIYVTpRIfc5UviYQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="338163900"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="338163900"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 17:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="744370389"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="744370389"
Received: from junjiego-mobl1.ccr.corp.intel.com (HELO [10.254.209.106]) ([10.254.209.106])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 17:47:38 -0700
Message-ID: <2e308d39-4f17-3b54-9f52-2b4b9ff7f951@linux.intel.com>
Date: Fri, 17 Mar 2023 08:47:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] iommu/vt-d: Move PRI handling to IOPF feature path
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D4948FA00CB02D3F2188CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4a9dd732-344d-64f3-0c9c-b21c196bf940@linux.intel.com>
 <BN9PR11MB527679AADCC5CA762C5BFAA68CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527679AADCC5CA762C5BFAA68CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/17 8:06, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, March 16, 2023 4:17 PM
>>
>> On 2023/3/16 15:17, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, March 9, 2023 10:57 AM
>>>>
>>>> @@ -4689,17 +4704,21 @@ static int intel_iommu_disable_iopf(struct
>> device
>>>> *dev)
>>>>    {
>>>>    	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>>    	struct intel_iommu *iommu = info->iommu;
>>>> -	int ret;
>>>>
>>>> -	ret = iommu_unregister_device_fault_handler(dev);
>>>> -	if (ret)
>>>> -		return ret;
>>>> +	if (!info->pri_enabled)
>>>> +		return -EINVAL;
>>>>
>>>> -	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
>>>> -	if (ret)
>>>> -		iommu_register_device_fault_handler(dev,
>>>> iommu_queue_iopf, dev);
>>>> +	pci_disable_pri(to_pci_dev(dev));
>>>> +	info->pri_enabled = 0;
>>>>
>>>> -	return ret;
>>>> +	/*
>>>> +	 * With pri_enabled checked, unregistering fault handler and
>>>> +	 * removing device from iopf queue should never fail.
>>>> +	 */
>>>> +	iommu_unregister_device_fault_handler(dev);
>>>> +	iopf_queue_remove_device(iommu->iopf_queue, dev);
>>>> +
>>>> +	return 0;
>>>>    }
>>>
>>> PCIe spec says that clearing the enable bit doesn't mean in-fly
>>> page requests are completed:
>>> --
>>> Enable (E) - This field, when set, indicates that the Page Request
>>> Interface is allowed to make page requests. If this field is Clear,
>>> the Page Request Interface is not allowed to issue page requests.
>>> If both this field and the Stopped field are Clear, then the Page
>>> Request Interface will not issue new page requests, but has
>>> outstanding page requests that have been transmitted or are
>>> queued for transmission
>>
>> Yes. So the iommu driver should drain the in-fly PRQs.
>>
>> The Intel VT-d implementation drains the PRQs when any PASID is unbound
>> from the iommu domain (see intel_svm_drain_prq()) before reuse. Before
>> disabling iopf, the device driver should unbind pasid and disable sva,
>> so when it comes here, the PRQ should have been drained.
>>
>> Perhaps I can add below comments to make this clear:
>>
>>           /*
>>            * PCIe spec states that by clearing PRI enable bit, the Page
>>            * Request Interface will not issue new page requests, but has
>>            * outstanding page requests that have been transmitted or are
>>            * queued for transmission. This is supposed to be called after
>>            * the device driver has stopped DMA, all PASIDs have been
>>            * unbound and the outstanding PRQs have been drained.
>>            */
>>
> 
> this is fine. But it should be a separate patch which removes
> check of return value. It's not caused by this PRI handling move
> patch.

Okay, that will be clearer.

Best regards,
baolu
