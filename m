Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E27B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676508279; x=1708044279;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H9B37YND2PlxQzaqANv6jo0wgH3eFakVkiI7KDSHJJI=;
  b=i5NHg9JyzqmjmXzUilutMYnxBnLsNPZu53xLS9NV0ymVTuwt8CFZ8krT
   ek2zgUfWccUbedfMv3eI27k3aq3mq+F7ARXwILhle5v2iB3EiqyrFuENC
   AkXp24pykCl6q+7IRy2bSWID0/xZi4EOM5nj+Mjd25W4bOHdu4UXrUeZh
   OD+EdQZMSbP2XrH9nqIlushmzWidvIXi8FaoHFpb3HaJlhpRQphuFFz/I
   vCVIbbC4Va0q5EVLiUqWRzX/l6qbdNlbEQpziGedcgmtBiNa4NPswX225
   KBwQM1I31jumowWUgGx+f/Eqj2a7ox3dqMxoYFhI/W2WO45yS81voW/wU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311213604"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="311213604"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 16:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="647469372"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="647469372"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2023 16:44:35 -0800
Message-ID: <e1928792-55be-40ce-1ab8-e95e0d95f0d5@linux.intel.com>
Date: Thu, 16 Feb 2023 08:36:12 +0800
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
 <b7f501b0-42c4-5402-7bb1-b4681b6e624c@linux.intel.com>
 <Y+zWgSzwzWFjGL6m@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y+zWgSzwzWFjGL6m@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/23 8:56 PM, Jason Gunthorpe wrote:
> On Wed, Feb 15, 2023 at 01:51:14PM +0800, Baolu Lu wrote:
>> On 2/13/23 10:19 PM, Jason Gunthorpe wrote:
>>> On Mon, Feb 13, 2023 at 03:49:39PM +0800, Lu Baolu wrote:
>>>> The iommu_group_store_type() requires the devices in the iommu group are
>>>> not bound to any device driver during the whole operation. The existing
>>>> code locks the device with device_lock(dev) and use device_is_bound() to
>>>> check whether any driver is bound to device.
>>>>
>>>> In fact, this can be achieved through the DMA ownership helpers. Replace
>>>> them with iommu_group_claim/release_dma_owner() helpers.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/iommu.c | 27 +++++++++++++--------------
>>>>    1 file changed, 13 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 4f71dcd2621b..6547cb38480c 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -2807,12 +2807,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>>>>    	mutex_lock(&group->mutex);
>>>> -	if (group->default_domain != group->domain) {
>>>> -		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
>>>> -		ret = -EBUSY;
>>>> -		goto out;
>>>> -	}
>>>> -
>>>>    	/*
>>>>    	 * iommu group wasn't locked while acquiring device lock in
>>>>    	 * iommu_group_store_type(). So, make sure that the device count hasn't
>>>> @@ -2971,6 +2965,7 @@ static void iommu_group_unfreeze_dev_ops(struct iommu_group *group)
>>>>    static ssize_t iommu_group_store_type(struct iommu_group *group,
>>>>    				      const char *buf, size_t count)
>>>>    {
>>>> +	bool group_owner_claimed = false;
>>>>    	struct group_device *grp_dev;
>>>>    	struct device *dev;
>>>>    	int ret, req_type;
>>>> @@ -2992,6 +2987,14 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>>>>    	else
>>>>    		return -EINVAL;
>>>> +	if (req_type != IOMMU_DOMAIN_DMA_FQ ||
>>>> +	    group->default_domain->type != IOMMU_DOMAIN_DMA) {
>>>> +		ret = iommu_group_claim_dma_owner(group, (void *)buf);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		group_owner_claimed = true;
>>>> +	}
>>> I don't get it, this should be done unconditionally. If we couldn't
>>> take ownership then we simply can't progress.
>> The existing code allows the user to switch the default domain from
>> strict to lazy invalidation mode. The default domain is not changed,
>> hence it should be seamless and transparent to the device driver.
> So make that a special case, get the group lock check if it is this
> case and then just adjust it and exit, otherwise get ownership under
> the group lock as discussed.

OK. Will do like this in the next version.

Best regards,
baolu
