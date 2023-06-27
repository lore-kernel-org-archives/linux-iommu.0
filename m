Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F415ACE
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 08:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687854162; x=1719390162;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dVqZCQ9tRTsVoV0IWARrFflzjFDg8LSURCopWadXZ/g=;
  b=IWcxqrTLHQY8XZ2kUNNlcSY/noQoJp9sPZnedVEquxnNqr/4RM6vzT2y
   XfwLlQjhLw9rrS7kmaVE+DJ/nf56nOKw6P9fXo5BsQ/9nYPFdVFtPWq+d
   MC5I2v1mefBrxrLFNdcZoNwIE2Ztlzc/zYVcKxcDWXPq3Bbl5MU7NbJIi
   5ICg+9iyNnSnccsFrsTUoDLkv0F0Gaddwp+OvKdkWGiDDbqn9e4cdxsed
   Il2m/+XhSy1Oyzr1VPYzbIYFnDWCSLn6V22jmMyzCycqhY09GKb8RHVge
   QyjFz79S6PdHTLgbbGpqmIPH52m0En/uVmleUH1oXAtYTQAKUZpcsfyqu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="361552085"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="361552085"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 01:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="781757134"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="781757134"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.29]) ([10.254.215.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 01:22:38 -0700
Message-ID: <1c8f6bf4-f0ad-2888-ada0-056c12647c41@linux.intel.com>
Date: Tue, 27 Jun 2023 16:21:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/2] iommu: Prevent RESV_DIRECT devices from blocking
 domains
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Jingqi"
 <jingqi.liu@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230607035145.343698-1-baolu.lu@linux.intel.com>
 <20230607035145.343698-2-baolu.lu@linux.intel.com>
 <8cc1d69e-f86d-fd04-7737-914d967dc0f5@intel.com>
 <69f50ced-e806-717a-0c74-a4cfa58600fa@linux.intel.com>
 <BN9PR11MB52768ACA721898D5C43CBE9B8C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f1b2e7fa-7be3-9e4b-1eba-5dba01b88c19@linux.intel.com>
 <BN9PR11MB527613D6C657A4AE0DE169758C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527613D6C657A4AE0DE169758C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/6/27 16:15, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 27, 2023 4:01 PM
>>
>> On 2023/6/27 15:54, Tian, Kevin wrote:
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, June 13, 2023 11:15 AM
>>>>
>>>> On 6/12/23 4:28 PM, Liu, Jingqi wrote:
>>>>> On 6/7/2023 11:51 AM, Lu Baolu wrote:
>>>>>> -
>>>>>> -    BUG_ON(!domain->pgsize_bitmap);
>>>>>> -
>>>>>> -    pg_size = 1UL << __ffs(domain->pgsize_bitmap);
>>>>>> +    pg_size = domain->pgsize_bitmap ? 1UL <<
>>>>>> __ffs(domain->pgsize_bitmap) : 0;
>>>>> Would it be better to add the following check here?
>>>>>        if (WARN_ON(!pg_size))
>>>>>                return -EINVAL;
>>>>>
>>>>> Instead of checking latter in the loop as follows.
>>>>>        if (WARN_ON_ONCE(!pg_size)) {
>>>>>                ret = -EINVAL;
>>>>>                goto out;
>>>>>        }
>>>> I am afraid no. Only the paging domains need a valid pg_size. That's the
>>>> reason why I put it after the iommu_is_dma_domain() check. The
>> previous
>>>> code has the same behavior too.
>>>>
>>> You could also add the dma domain check here. pg_size is static
>>> then it makes more sense to verify it once instead of in a loop.
>> Agreed. Does below additional change make sense?
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index e59de7852067..3be88b5f36bb 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -962,6 +962,9 @@ static int
>> iommu_create_device_direct_mappings(struct iommu_domain *domain,
>>           pg_size = domain->pgsize_bitmap ? 1UL <<
>> __ffs(domain->pgsize_bitmap) : 0;
>>           INIT_LIST_HEAD(&mappings);
>>
>> +       if (WARN_ON_ONCE((domain->type & __IOMMU_DOMAIN_PAGING)
>> &&
>> !pg_size))
>> +               return -EINVAL;
> what's the reason of not using iommu_is_dma_domain()? this is called
> in the probe path only for the default domain. Otherwise if you change
> like this then you also want to change the check in the loop later to be
> consistent.
> 

Yes. iommu_is_dma_domain() is better.

Best regards,
baolu
