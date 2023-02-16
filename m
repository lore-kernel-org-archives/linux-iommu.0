Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1C7B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 00:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676508695; x=1708044695;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oMDsR2cvqxAJeRoEB/geejBEB5K+GYsJeTdIhBnoWzI=;
  b=HJU6vu/Q1dntZbFarwJ+4zHEbPmA0QN+k7+qd8H3uDRBZ23kLUq8o76M
   PFyim4otE4HDMJGlxh+GHUGCKgNW/aZQBZflYKPRsm4lkuavb5/Cntg3R
   xwb6KM62jJY7K+t9U2nLh3JqX9ufADK77MfHatz/yxedFb/bpS5gAWG/f
   N+6XJW94Gmon7rfiJovlev8QrqIzU4SRpeXCmCdxPJieUvVs/u8aVJzZA
   BdB1GI7nDxYucgv+oeXH81/e+nIXiWJCK9rh07aeDIh5unCJKUvdLvSus
   9ZYcyxKAyhgb0qZaruO+RK8PgHn4j4Jcou7yA92QKTOj8wCVUwW29qdac
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="417808076"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="417808076"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 16:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="793835234"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="793835234"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2023 16:51:16 -0800
Message-ID: <694e3fe4-084d-2da5-83f6-cc275fac4463@linux.intel.com>
Date: Thu, 16 Feb 2023 08:42:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] iommu: Use group ownership to avoid driver attachment
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-3-baolu.lu@linux.intel.com>
 <Y+pG9kWzR2c5I9FU@nvidia.com>
 <b7f501b0-42c4-5402-7bb1-b4681b6e624c@linux.intel.com>
 <BN9PR11MB52768BD174CE9F4AE40C12078CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4ac228af-fb74-2d89-b8d7-462186170e12@linux.intel.com>
 <f4559966-c99e-47d2-a5ab-d248c7ed8e52@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f4559966-c99e-47d2-a5ab-d248c7ed8e52@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/15/23 7:09 PM, Robin Murphy wrote:
> On 2023-02-15 07:28, Baolu Lu wrote:
>> On 2023/2/15 14:56, Tian, Kevin wrote:
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Wednesday, February 15, 2023 1:51 PM
>>>>
>>>> On 2/13/23 10:19 PM, Jason Gunthorpe wrote:
>>>>> On Mon, Feb 13, 2023 at 03:49:39PM +0800, Lu Baolu wrote:
>>>>>> @@ -2992,6 +2987,14 @@ static ssize_t iommu_group_store_type(struct
>>>> iommu_group *group,
>>>>>>        else
>>>>>>            return -EINVAL;
>>>>>>
>>>>>> +    if (req_type != IOMMU_DOMAIN_DMA_FQ ||
>>>>>> +        group->default_domain->type != IOMMU_DOMAIN_DMA) {
>>>>>> +        ret = iommu_group_claim_dma_owner(group, (void *)buf);
>>>>>> +        if (ret)
>>>>>> +            return ret;
>>>>>> +        group_owner_claimed = true;
>>>>>> +    }
>>>>> I don't get it, this should be done unconditionally. If we couldn't
>>>>> take ownership then we simply can't progress.
>>>> The existing code allows the user to switch the default domain from
>>>> strict to lazy invalidation mode. The default domain is not changed,
>>>> hence it should be seamless and transparent to the device driver.
>>> Is there real usage relying on this transition for a bound device?
>>>
>>> In concept strict->lazy transition implies relaxed DMA security. It's 
>>> hard
>>> to think of a motivation of doing so while the device might be doing
>>> in-fly DMAs.
>>>
>>> Presumably such perf/security tradeoff should be planned way before
>>> binding device/driver together.
>>>
>>> btw if strict->lazy is allowed why lazy->strict is prohibited?
>>>
>>
>> We all know, strict vs. lazy is a tradeoff between performance and
>> security.
>>
>> strict -> lazy: driver works in secure mode. This transition trades off
>> security for better performance.
>>
>> lazy->strict: The driver is already working in non-safety mode. This
>> transition only results in worse performance. It makes no sense. If user
>> want to put the driver in a secure mode, they need to unbind the driver,
>> reset the device and do the lazy->strict transition.
>>
>> Robin might have better insights.
> 
> Yes, this was added for a definite use-case in ChromeOS, where 
> strict->lazy needs to support being done "live" since the device in 
> question is the storage controller for the already-mounted root 
> filesystem.

Thanks for letting us know this.

> Your reasoning seems to match what I summarised in the 
> original commit message 😄

Haha, it seems that my memory is till good. :-)

Best regards,
baolu
