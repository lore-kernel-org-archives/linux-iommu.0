Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61933CBAB
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 05:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676440791; x=1707976791;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Nbi3mP9Kgb35UQ1cRJ+mP6vwRct3vE93ciQ5o3UA2Q=;
  b=gzIdgo5OndIKaATFPb5Z5fBTovkiKjSJv7W/V7FAw+YbKui8HoSl0eLq
   iH2oduJgR99Bk/BW6RpVHefrTcmAL3wMXvsDPmY5u6st9Qvg6F/Caj9I+
   cheoL/JuU4s4zuTcJdPFxHcs80RpQjp1xTivlqwPBq3CTheXXIwxMz/vv
   +9crINkJNUiR3SeX64vS9teXPAHuiKl0ngd0jsfe/e56tD9Zhft/Erj3d
   0/fLGFKjLO1UlzEQ8nDPBL/TFgE69FX0qVFojL4L94dKRO0fX66Kc8n2C
   c2zXZn0H/KVivJr2ZTR7qIJiivHpWoT0Hzpe+fqmg2wUxfmABOMM8G9Xi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311719995"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="311719995"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 21:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="671499354"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="671499354"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2023 21:59:37 -0800
Message-ID: <b7f501b0-42c4-5402-7bb1-b4681b6e624c@linux.intel.com>
Date: Wed, 15 Feb 2023 13:51:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iommu: Use group ownership to avoid driver attachment
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-3-baolu.lu@linux.intel.com>
 <Y+pG9kWzR2c5I9FU@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y+pG9kWzR2c5I9FU@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/23 10:19 PM, Jason Gunthorpe wrote:
> On Mon, Feb 13, 2023 at 03:49:39PM +0800, Lu Baolu wrote:
>> The iommu_group_store_type() requires the devices in the iommu group are
>> not bound to any device driver during the whole operation. The existing
>> code locks the device with device_lock(dev) and use device_is_bound() to
>> check whether any driver is bound to device.
>>
>> In fact, this can be achieved through the DMA ownership helpers. Replace
>> them with iommu_group_claim/release_dma_owner() helpers.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 27 +++++++++++++--------------
>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 4f71dcd2621b..6547cb38480c 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2807,12 +2807,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>>   
>>   	mutex_lock(&group->mutex);
>>   
>> -	if (group->default_domain != group->domain) {
>> -		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
>> -		ret = -EBUSY;
>> -		goto out;
>> -	}
>> -
>>   	/*
>>   	 * iommu group wasn't locked while acquiring device lock in
>>   	 * iommu_group_store_type(). So, make sure that the device count hasn't
>> @@ -2971,6 +2965,7 @@ static void iommu_group_unfreeze_dev_ops(struct iommu_group *group)
>>   static ssize_t iommu_group_store_type(struct iommu_group *group,
>>   				      const char *buf, size_t count)
>>   {
>> +	bool group_owner_claimed = false;
>>   	struct group_device *grp_dev;
>>   	struct device *dev;
>>   	int ret, req_type;
>> @@ -2992,6 +2987,14 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>>   	else
>>   		return -EINVAL;
>>   
>> +	if (req_type != IOMMU_DOMAIN_DMA_FQ ||
>> +	    group->default_domain->type != IOMMU_DOMAIN_DMA) {
>> +		ret = iommu_group_claim_dma_owner(group, (void *)buf);
>> +		if (ret)
>> +			return ret;
>> +		group_owner_claimed = true;
>> +	}
> 
> I don't get it, this should be done unconditionally. If we couldn't
> take ownership then we simply can't progress.

The existing code allows the user to switch the default domain from
strict to lazy invalidation mode. The default domain is not changed,
hence it should be seamless and transparent to the device driver.

> 
> But there is more to it than that, a device that is owned should not
> be release and to achieve this the general logic around the owner
> scheme assumes that a driver is attached.

Yes. Current ownership scheme was built on this assumption.

> 
> So if you call it from this non-driver context you have to hold the
> group_mutex as previously discussed,

Yes.

> which also means this needs to be
> an externally version of iommu_group_claim_dma_owner()

Sorry! What does "an externally version of
iommu_group_claim_dma_owner()" mean?

My understanding is that we should limit iommu_group_claim_dma_owner()
use in the driver context. For this non-driver context, we should not
use iommu_group_claim_dma_owner() directly, but hold the group->mutex
and check the group->owner_cnt directly:

         mutex_lock(&group->mutex);
         if (group->owner_cnt) {
                 ret = -EPERM;
                 goto unlock_out;
         }

the group->mutex should be held until everything is done.

Best regards,
baolu
