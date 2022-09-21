Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8881C27
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 06:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663742967; x=1695278967;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XawNPyqzrCuNlg8rwhRO9w7/Tv1o2gsrQDcffFviwHs=;
  b=P3kQRvkzyDa6I71B7VR1ABJuowHExQMG3rxZtFO1uOQI26u3QjKbE30D
   aXyk3t8tWETWfaIZuUlkYkb2U7P2cRGQY9ThSNCIOkgeNAD7kYJzZNQXt
   rSWz/5ZvX+6F8uo4xN6DiSGwA30UyK0oQi22kDD6AsU09HLyTOArtfO8J
   YTjiqnYMEVDHa/pK3CEnTDu2wIupP1orJYMy9J+9fn/Me4efZucqDObhl
   XAQRjKA4oFNeDz786oQy0hqKeEpAEZj+64j3fsC4XAJ5nvPLJ6OXNhqXR
   AJbw7KquSyPeGiTNZWRRWPvqV7P44YukDvxENT22p5X1zlMqMhDe9vgx+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299905869"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="299905869"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:49:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="708318589"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.217]) ([10.254.208.217])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:49:20 -0700
Message-ID: <bbc6da4d-c2d9-c5ee-aced-3f08831672bc@linux.intel.com>
Date: Wed, 21 Sep 2022 14:49:18 +0800
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Avoid unnecessary global IRTE cache
 invalidation
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
 <20220919062523.3438951-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52760E6985B16235A30B57978C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760E6985B16235A30B57978C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/20 15:51, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, September 19, 2022 2:25 PM
>>
>> Some VT-d hardware implementations invalidate all interrupt remapping
>> hardware translation caches as part of SIRTP flow. The VT-d spec adds
>> a ESIRTPS (Enhanced Set Interrupt Remap Table Pointer Support, section
>> 11.4.2 in VT-d spec) capability bit to indicate this. With this bit set,
>> software has no need to issue the global invalidation request.
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h         | 1 +
>>   drivers/iommu/intel/irq_remapping.c | 3 ++-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index eef1a166b855..5407d82df4d1 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -146,6 +146,7 @@
>>   /*
>>    * Decoding Capability Register
>>    */
>> +#define cap_esirtps(c)		(((c) >> 62) & 1)
>>   #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
>>   #define cap_pi_support(c)	(((c) >> 59) & 1)
>>   #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
>> diff --git a/drivers/iommu/intel/irq_remapping.c
>> b/drivers/iommu/intel/irq_remapping.c
>> index 2e9683e970f8..b4a91fbd1c2f 100644
>> --- a/drivers/iommu/intel/irq_remapping.c
>> +++ b/drivers/iommu/intel/irq_remapping.c
>> @@ -494,7 +494,8 @@ static void iommu_set_irq_remapping(struct
>> intel_iommu *iommu, int mode)
>>   	 * Global invalidation of interrupt entry cache to make sure the
>>   	 * hardware uses the new irq remapping table.
>>   	 */
>> -	qi_global_iec(iommu);
>> +	if (!cap_esirtps(iommu->cap))
>> +		qi_global_iec(iommu);
>>   }
>>
> 
> Same check is also required in iommu_disable_irq_remapping().
> 
> The spec says that:
> 
> --
> For implementations reporting the Enhanced Set Interrupt Remap Table
> Pointer Support (ESIRTPS) field as Set, hardware performs global
> invalidation on all Interrupt remapping caches as part of Interrupt
> Remapping Disable operation.
> --

Yes. I will add the same check in iommu_disable_irq_remapping(). Thanks
for the reminding.

> While looking at that code I think it's problematic to invalidate interrupt
> cache before disabling interrupt remapping. Presumably invalidations
> should be done only after a configuration is changed, no matter it's 'enable'
> or 'disable'.

I understand your concern. The spec doesn't state the sequence in the
interrupt remapping disabling flow. Need to check it with the spec
developers before any change here.

Best regards,
baolu
