Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0562C
	for <iommu@lists.linux.dev>; Wed,  1 Feb 2023 06:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675234152; x=1706770152;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HHPn6pdrMP+Yeqd9fDLmVbypM3R0VnG01kodEBiqXv8=;
  b=Up3xd6gQ9fCyn8xH0MCCMOZaDF9ai85Dndvp/6Y0vL0jkrNVhUep5CPf
   1mWPbWukRmPBkNLPfrau6Cr5QTVOXp/oC5o/6Vto1kx6mStPiARo9dJqd
   Uzc6qCUtG/mjsAKA5iubvnpZTp4Hi0/e7rUqhMNKxmDcPh7M8QtPD9Afd
   Nt6js4jXh4dfRxqwV3MVUaQ6SxzWyQVMKyAyHqJEZTkJ12qgnsGPgJwEN
   Bxrf/ECBhw5WszFgTHedfLsR2bLwH/YbUq5WnEc7kqw3apotoEy3T76L3
   rqIEKlCSA+MD3t+QEeEqvsEktu1ZBeTYTxDKfj5P2vZdb4y8g6IbMu0Kc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="329358381"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="329358381"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 22:49:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="753555901"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="753555901"
Received: from xduan-mobl1.ccr.corp.intel.com (HELO [10.254.215.167]) ([10.254.215.167])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 22:49:10 -0800
Message-ID: <df494d34-d804-e743-023f-d1effc881628@linux.intel.com>
Date: Wed, 1 Feb 2023 14:49:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "Lu, Baolu" <baolu.lu@intel.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9ZMulxEyGvnvW0X@Asurada-Nvidia> <Y9eaLpD1XIvE/3Nh@Asurada-Nvidia>
 <BN9PR11MB52769883FEE25F0BA731220B8CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769883FEE25F0BA731220B8CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/1 11:07, Tian, Kevin wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Monday, January 30, 2023 6:22 PM
>>
>> On Sun, Jan 29, 2023 at 02:38:55AM -0800, Nicolin Chen wrote:
>>
>>>>> @@ -385,10 +372,8 @@ void iommufd_device_detach(struct
>>>>> iommufd_device *idev)
>>>>>        struct iommufd_hw_pagetable *hwpt = idev->hwpt;
>>>>>
>>>>>        mutex_lock(&hwpt->ioas->mutex);
>>>>> -     mutex_lock(&hwpt->devices_lock);
>>>>>        refcount_dec(hwpt->devices_users);
>>>>> -     list_del(&idev->devices_item);
>>>>> -     if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
>>>>> +     if (iommufd_hw_pagetable_has_device(hwpt, idev->dev)) {
>>>>>                if (refcount_read(hwpt->devices_users) == 1) {
>>>>>                        iopt_table_remove_domain(&hwpt->ioas->iopt,
>>>>>                                                 hwpt->domain);
>>>>> @@ -397,7 +382,6 @@ void iommufd_device_detach(struct
>> iommufd_device
>>>>> *idev)
>>>>>                iommu_detach_group(hwpt->domain, idev->group);
>>>>>        }
>>>>
>>>> emmm how do we track last device detach in a group? Here the first
>>>> device detach already leads to group detach...
>>>
>>> Oh no. That's a bug. Thanks for catching it.
>>>
>>> We need an additional refcount somewhere to track the number of
>>> attached devices in the iommu_group.
>>
>> Wondering if we can let iommu_attach/detach_device handle this:
>>
> 
> that is the desired way to fully remove group awareness in iommufd.
> 
> but iirc there were some concerns on changing their semantics. But
> I don't remember the detail now. Jason might know. also +Baolu/Robin.
> 
> otherwise as long as the group attach/detach continues to be used
> then identifying last device in the group always needs some hack
> within iommufd itself.

I have tried to solve this problem.

https://lore.kernel.org/linux-iommu/20220106022053.2406748-1-baolu.lu@linux.intel.com/

I may need to review the original discussion to see if I can update a
new version.

Best regards,
baolu
