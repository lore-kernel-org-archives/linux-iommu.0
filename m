Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45D7F1
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 01:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691718195; x=1723254195;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VpNe3KG6YE2UxMhHpsSTPKnMAYPUPp2Qol79EMM11+4=;
  b=NX9b6wLvTozyOnZ7UlWzEKeTtVTJsQx9SwyO8hr8UrPLzmulqg+3YHqH
   icNyATJhqDFfFfBtgtO8dgFp56qrXXNrr/kvw25t4G9d6TFXRd6SlleFz
   xYb8LNwl644BixuqN/TGpQPlFwaEW6heLlnkWKGJGy0mCLHz9wjNlHL4d
   zD0+TRS9KW8mG5VrKCZhkFfHSUdMWUCEI66OKCoNAbbyu75D3nbEn+zhx
   JRWDguFu7FLR9+/2UOQrfOy5B3u+qCGKECwADR1VL5zbuKaxQVo6VJk9q
   Cb46FqTdsTKqbhpZD0uoGaY7qaBbBn1bh1tioyVPSXfn1WGMKsJuuUWN9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="402537882"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="402537882"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="762010588"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="762010588"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.70]) ([10.254.214.70])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:43:10 -0700
Message-ID: <621683c0-ad01-22ff-dbf9-4edb27f42640@linux.intel.com>
Date: Fri, 11 Aug 2023 09:43:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] iommu: Make dev->fault_param static
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-7-baolu.lu@linux.intel.com>
 <ZNUqV5Mte2AsVa1L@ziepe.ca> <ZNUwgjJ+2GHf2MOW@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNUwgjJ+2GHf2MOW@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/11 2:46, Jason Gunthorpe wrote:
> On Thu, Aug 10, 2023 at 03:20:07PM -0300, Jason Gunthorpe wrote:
>> On Thu, Jul 27, 2023 at 01:48:31PM +0800, Lu Baolu wrote:
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 4ba3bb692993..3e4ff984aa85 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -302,7 +302,15 @@ static int dev_iommu_get(struct device *dev)
>>>   		return -ENOMEM;
>>>   
>>>   	mutex_init(&param->lock);
>>> +	param->fault_param = kzalloc(sizeof(*param->fault_param), GFP_KERNEL);
>>> +	if (!param->fault_param) {
>>> +		kfree(param);
>>> +		return -ENOMEM;
>>> +	}
>>> +	mutex_init(&param->fault_param->lock);
>>> +	INIT_LIST_HEAD(&param->fault_param->faults);
>>>   	dev->iommu = param;
>> This allocation seems pointless?
>>
>> If we always allocate the fault param then just don't make it a
>> pointer in the first place.
>>
>> The appeal of allocation would be to save a few bytes in the common
>> case that the driver doesn't support faulting.
>>
>> Which means the driver needs to make some call to enable faulting for
>> a device. In this case I'd continue to lazy free on release like this
>> patch does.
> For instance allocate the fault_param in iopf_queue_add_device() which
> is the only thing that needs it.
> 
> Actually probably just merge struct iopf_device_param and
> iommu_fault_param ?
> 
> When you call iopf_queue_add_device() it enables page faulting mode,
> does 1 additional allocation for all additional required per-device
> memory and thats it.

Agreed.

I originally kept the iommu_fault_param structure because I thought it
could also be used to store temporary data for unrecoverable faults,
just like the iopf_device_param structure is used for iopf. However, I
am not sure whether we actually need any temporary data for
unrecoverable fault forwarding, which doesn't require any response.

So, it's better to do like you suggested. It's cleaner and simpler.

Best regards,
baolu

