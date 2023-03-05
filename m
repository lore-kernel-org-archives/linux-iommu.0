Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5FD2E2
	for <iommu@lists.linux.dev>; Sun,  5 Mar 2023 03:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677985609; x=1709521609;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6j2czBUasix/Si30IrOEzCkpwnec8zlaVJBpQd4RERs=;
  b=FS0LuZ2shW9x//rlGYksPis+abX+Ej3NxKuKkVK/21GZ7Ka+HZ358yS9
   P0han9EWw4Nvm2Jk4mFJhie8iQUYoGbWhY+uuh78AJuzk78s+TjUx95Ez
   NxGi8O1WRfyioPwB8PqBal8UO01ekQImJNdjOAQtUvUtUF7yDIqBPsjDX
   p3GgKhfhnmfbbdvQDnzAG74QHLz/7TIQe+nuTd/Z8Z+ZX6t8Gssp8Edes
   FhzlHt3rvuOP7agmJy3DIHQpeWuyqYSEHmemAc/j0N2nsvhmCwt8+Ai2u
   DnsDV93TiuPtn1dLs+ImwpNY2rRiyA8fQ0eePCEchi0d3dfQFW/FVeWkM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="362944370"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="362944370"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 19:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="818927690"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="818927690"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2023 19:06:45 -0800
Message-ID: <c54aebf7-4282-b8a6-f03b-03af2deea59c@linux.intel.com>
Date: Sun, 5 Mar 2023 11:05:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default
 domain
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
 <BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230303083512.663ce758@jacob-builder>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230303083512.663ce758@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/23 12:35 AM, Jacob Pan wrote:
>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>> Sent: Thursday, March 2, 2023 10:07 PM
>>>    
>>>> +
>>>> +	if (hw_pass_through && domain_type_is_si(dmar_domain))
>>>> +		ret = intel_pasid_setup_pass_through(iommu,
>>>> dmar_domain,
>>>> +						     dev, pasid);
>>>> +	else if (dmar_domain->use_first_level)
>>>> +		ret = domain_setup_first_level(iommu, dmar_domain,
>>>> +					       dev, pasid);
>>>> +	else
>>>> +		ret = intel_pasid_setup_second_level(iommu,
>>>> dmar_domain,
>>>> +						     dev, pasid);
>>>> +
>>>> +	return ret;
>>>> +}
>>> Do you need to consider pasid cache invalidation?
>>>    
>> To avoid confusion this is not about invalidation of pasid cache itself
>> which should be covered by above setup functions already.
>>
>> Here actually means per-PASID invalidation in iotlb and devtlb. Today
>> only RID is tracked per domain for invalidation. it needs extension to
>> walk attached pasid too.
> Yes, will add.
> 
> For the set up path, there is no need to flush IOTLBs,  because we're going
> from non present to present.
> 
> On the remove path, IOTLB flush should be covered when device driver
> calls iommu_detach_device_pasid(). Covered with this patch.

It's not only for the PASID teardown path, but also for unmap(). As the
device has issued DMA requests with PASID, the IOMMU probably will cache
the DMA translation with PASID tagged. Hence, we need to invalidate the
PASID-specific IOTLB and device TLB in the unmap() path.

I once had a patch for this:

https://lore.kernel.org/linux-iommu/20220614034411.1634238-1-baolu.lu@linux.intel.com/

Probably you can use it as a starting point.

Best regards,
baolu
