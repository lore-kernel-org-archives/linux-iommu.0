Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582B182C0;
	Thu, 20 Jul 2023 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689862707; x=1721398707;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BFG+lxSO1zBFfL9o8M5wrEKd1L4tJiPtfHsH/2e/ZoQ=;
  b=JD+ehAlQeJ29Bt2jarrwXtza5zR1z3wTsRBQAqpHlEnUu+/NKKWbtiMP
   jW+NrCHJ1ve0gnAAi+UarpVcp6ZhTzBI92GyDNixWXKrCmbGwwnyQgSEb
   BPv2NcuekpOc4X2+jb1YiuDH71xCSCavd/u0X64VTht79ZEjpx8Jtm1ek
   dt0VFBklwf5lYpgLoWOgMvn3b1xbbF01bRZkpx0IMp2oK44meA66jRw7d
   9mpNVi+D6f2m3MiysfCBPXfzHjB7lTLZaHMEU+pepf17+r6jmPexK55Cg
   qmdi11tnwSqN7VjnhnhvYAq9RUCen/6l2r05KBZUNHmm1Y/vIyYhKDBp2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="369414757"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="369414757"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 07:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="674703327"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="674703327"
Received: from hli37-mobl.amr.corp.intel.com (HELO [10.252.191.120]) ([10.252.191.120])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 07:01:58 -0700
Message-ID: <c98c37bb-57c5-faec-1d17-730f3ceb2b21@linux.intel.com>
Date: Thu, 20 Jul 2023 22:01:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 03/10] iommu: Add generic_single_device_group()
To: Jason Gunthorpe <jgg@nvidia.com>
References: <3-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <32eadc5b-bb39-5bb1-f124-44feead97ce9@linux.intel.com>
 <ZLkiu7IyimCckiFs@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZLkiu7IyimCckiFs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/20 20:04, Jason Gunthorpe wrote:
> On Thu, Jul 20, 2023 at 03:39:27PM +0800, Baolu Lu wrote:
>> On 2023/7/19 3:05, Jason Gunthorpe wrote:
>>> This implements the common pattern seen in drivers of a single
>>> iommu_group for the entire iommu driver. Implement this in core code
>>> so the drivers that want this can select it from their ops.
>>>
>>> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
>>> ---
>>>    drivers/iommu/iommu.c | 25 +++++++++++++++++++++++++
>>>    include/linux/iommu.h |  3 +++
>>>    2 files changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 9e41ad4e3219b6..1e0c5d9a0370fb 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -289,6 +289,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
>>>    	spin_lock(&iommu_device_lock);
>>>    	list_del(&iommu->list);
>>>    	spin_unlock(&iommu_device_lock);
>>> +
>>> +	/* Pairs with the alloc in generic_single_device_group() */
>>> +	iommu_group_put(iommu->singleton_group);
>>>    }
>>>    EXPORT_SYMBOL_GPL(iommu_device_unregister);
>>> @@ -1595,6 +1598,28 @@ struct iommu_group *generic_device_group(struct device *dev)
>>>    }
>>>    EXPORT_SYMBOL_GPL(generic_device_group);
>>> +/*
>>> + * Generic device_group call-back function. It just allocates one
>>> + * iommu-group per iommu driver.
>>> + */
>>> +struct iommu_group *generic_single_device_group(struct device *dev)
>>> +{
>>> +	struct iommu_device *iommu = dev->iommu->iommu_dev;
>>> +
>>> +	lockdep_assert_held(&dev_iommu_group_lock);
>>> +
>>> +	if (!iommu->singleton_group) {
>>> +		struct iommu_group *group;
>>> +
>>> +		group = iommu_group_alloc();
>>> +		if (IS_ERR(group))
>>> +			return group;
>>> +		iommu->singleton_group = group;
>>> +	}
>>> +	return iommu_group_ref_get(iommu->singleton_group);
>>> +}
>>> +EXPORT_SYMBOL_GPL(generic_single_device_group);
>> When allocating the singleton group for the first time, the group's
>> refcount is taken twice.
> Yes, that is correct.
> 
> The refcount from alloc belongs to iommu->singleton_group and the
> pair'd put is here:
> 
> @@ -289,6 +289,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
>   	spin_lock(&iommu_device_lock);
>   	list_del(&iommu->list);
>   	spin_unlock(&iommu_device_lock);
> +
> +	/* Pairs with the alloc in generic_single_device_group() */
> +	iommu_group_put(iommu->singleton_group);
>   }
> 
> The refcount from iommu_group_ref_get() belongs to the caller and the
> caller must have a paired put.

Oh, yes! The extra reference counter is paired with above put.

Thanks for the explanation.

Then, another small comment:

iommu->singleton_group will be freed with above put, right? Do you need
to set iommu->singleton_group to NULL? Given that iommu_device is not
freed here.

Best regards,
baolu

