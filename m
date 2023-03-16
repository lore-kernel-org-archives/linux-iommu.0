Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6D20EE
	for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678954626; x=1710490626;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mvM3U4HAfsIGubHuWNsDYEqyKLly6yHWxDKSYIjSFvQ=;
  b=XYLyLCEfmz8snZoTatk5sz92bG2Fmn7xrbNGo7lYCz/9MnzXyI9VciOp
   +ho1rGQW3kHRxXtXa0FT1CpsdzTULTFebPpRvjD+8ojd831qzSEqLwLlc
   jXAaJaEoXjLdZed3kzCZTu0uw3twvpRZZtUP8eZjz0BvpJ3ndukYsEKqU
   /tD750Klahsi9KglHvPGZECTcx/YQx9XUTFoZzjlMwMAx6bMihacEB66Z
   332c798+DpcpVbD6mAcQTXakq24X6waEdC+b4/tcVZ1n+l41g1XilQUkL
   VNEUf+3RUPzl3CMXY3/eSmQrhx0xm+Fvu+A0YVaHYPH1qnSUiSE6H5pSI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="400494717"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="400494717"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="853923169"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="853923169"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.173.173]) ([10.249.173.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:17:02 -0700
Message-ID: <4a9dd732-344d-64f3-0c9c-b21c196bf940@linux.intel.com>
Date: Thu, 16 Mar 2023 16:17:00 +0800
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
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D4948FA00CB02D3F2188CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766D4948FA00CB02D3F2188CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/16 15:17, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, March 9, 2023 10:57 AM
>>
>> @@ -4689,17 +4704,21 @@ static int intel_iommu_disable_iopf(struct device
>> *dev)
>>   {
>>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>   	struct intel_iommu *iommu = info->iommu;
>> -	int ret;
>>
>> -	ret = iommu_unregister_device_fault_handler(dev);
>> -	if (ret)
>> -		return ret;
>> +	if (!info->pri_enabled)
>> +		return -EINVAL;
>>
>> -	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
>> -	if (ret)
>> -		iommu_register_device_fault_handler(dev,
>> iommu_queue_iopf, dev);
>> +	pci_disable_pri(to_pci_dev(dev));
>> +	info->pri_enabled = 0;
>>
>> -	return ret;
>> +	/*
>> +	 * With pri_enabled checked, unregistering fault handler and
>> +	 * removing device from iopf queue should never fail.
>> +	 */
>> +	iommu_unregister_device_fault_handler(dev);
>> +	iopf_queue_remove_device(iommu->iopf_queue, dev);
>> +
>> +	return 0;
>>   }
> 
> PCIe spec says that clearing the enable bit doesn't mean in-fly
> page requests are completed:
> --
> Enable (E) - This field, when set, indicates that the Page Request
> Interface is allowed to make page requests. If this field is Clear,
> the Page Request Interface is not allowed to issue page requests.
> If both this field and the Stopped field are Clear, then the Page
> Request Interface will not issue new page requests, but has
> outstanding page requests that have been transmitted or are
> queued for transmission

Yes. So the iommu driver should drain the in-fly PRQs.

The Intel VT-d implementation drains the PRQs when any PASID is unbound
from the iommu domain (see intel_svm_drain_prq()) before reuse. Before
disabling iopf, the device driver should unbind pasid and disable sva,
so when it comes here, the PRQ should have been drained.

Perhaps I can add below comments to make this clear:

         /*
          * PCIe spec states that by clearing PRI enable bit, the Page
          * Request Interface will not issue new page requests, but has
          * outstanding page requests that have been transmitted or are
          * queued for transmission. This is supposed to be called after
          * the device driver has stopped DMA, all PASIDs have been
          * unbound and the outstanding PRQs have been drained.
          */

Best regards,
baolu
