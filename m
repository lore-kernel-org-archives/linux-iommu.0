Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC715CD
	for <iommu@lists.linux.dev>; Wed, 19 Apr 2023 02:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872055; x=1713408055;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s1n4TUCaTvsj1tO3ERxhVhLwpHBq/J7NSZHIspGt7hw=;
  b=IYcenWdnvPvuQxCssSMeKkgLeF9hXGsvFO8Ho7MI0N0ePrF2rgrfjATE
   3mHd35a98dRRGbpBHon0cZz1oQik7ikpNbxQ++3kI75KQ8e4zzWqjhQeb
   LX+en91HSaPH8EVHeDv6oObk88ddNF3LMOMnVfJjL8gfk2KJKVJrOBXev
   0pcuFg4e8Bmpb7+c2RxQyfs+1o1VglM0Wu/mTjdWxvX+RcLaltusbmmDn
   Xff6Dag9kBUMt51WNe5PwIwUY4lpjBpLQZQZMUDwp/CDunewLR4eqgal6
   20YdO3G/3PmUBtDQ+hAaZT81zh7TTh7mIruxveL9HUp0V+zrMtBHdg1ld
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373214547"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373214547"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780703605"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780703605"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2023 19:40:50 -0700
Message-ID: <7e182125-f5ab-3201-e69d-b6c96eeede01@linux.intel.com>
Date: Wed, 19 Apr 2023 10:40:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v4 3/7] iommu: Support allocation of global PASIDs outside
 SVA
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
 <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <5882ee52-9657-250d-0474-13edffa7b6b9@linux.intel.com>
 <20230417094629.59fcfde6@jacob-builder>
 <a1a82bc0-9a7a-5363-cda8-a0226eff0073@linux.intel.com>
 <20230418160450.4ea7fb7d@jacob-builder>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230418160450.4ea7fb7d@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/23 7:04 AM, Jacob Pan wrote:
> On Tue, 18 Apr 2023 10:06:12 +0800, Baolu Lu<baolu.lu@linux.intel.com>
> wrote:
> 
>> On 4/18/23 12:46 AM, Jacob Pan wrote:
>>> On Wed, 12 Apr 2023 09:37:48 +0800, Baolu Lu<baolu.lu@linux.intel.com>
>>> wrote:
>>>    
>>>> On 4/11/23 4:02 PM, Tian, Kevin wrote:
>>>>>> From: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>>>>> Sent: Saturday, April 8, 2023 2:06 AM
>>>>>> @@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct
>>>>>> *mm, ioasid_t min, ioasid_t ma
>>>>>>     		goto out;
>>>>>>     	}
>>>>>>
>>>>>> -	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
>>>>>> GFP_KERNEL);
>>>>>> -	if (ret < min)
>>>>>> +	ret = iommu_alloc_global_pasid(min, max);
>>>>> I wonder whether this can take a device pointer so
>>>>> dev->iommu->max_pasids is enforced inside the alloc function.
>>>> Agreed. Instead of using the open code, it looks better to have a
>>>> helper like dev_iommu_max_pasids().
>>> yes, probably export dev_iommu_get_max_pasids(dev)?
>>>
>>> But if I understood Kevin correctly, he's also suggesting that the
>>> interface should be changed to iommu_alloc_global_pasid(dev), my
>>> concern is that how do we use this function to reserve RID_PASID which
>>> is not specific to a device?
>> Probably we can introduce a counterpart dev->iommu->min_pasids, so that
>> there's no need to reserve the RID_PASID. At present, we can set it to 1
>> in the core as ARM/AMD/Intel all treat PASID 0 as a special pasid.
>>
>> In the future, if VT-d supports using arbitrary number as RID_PASID for
>> any specific device, we can call iommu_alloc_global_pasid() for that
>> device.
>>
>> The device drivers don't know and don't need to know the range of viable
>> PASIDs, so the @min, @max parameters seem to be unreasonable.
> Sure, that is reasonable. Another question is whether global PASID
> allocation is always for a single device, if not I prefer to keep the
> current iommu_alloc_global_pasid() and add a wrapper
> iommu_alloc_global_pasid_dev(dev) to extract the @min, @max. OK?

No problem from the code perspective. But we only need one API.

We can now add the kAPI that we really need. In this series, the idxd
driver wants to allocate a global PASID for its kernel dma with pasid
purpose. So, iommu_alloc_global_pasid_dev() seems to be sufficient.

If, in the future, we will have a need to provide global pasid
allocation other than device drivers, we can easily add the variants.

Best regards,
baolu
