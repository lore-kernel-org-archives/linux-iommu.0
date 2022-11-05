Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219FB1101
	for <iommu@lists.linux.dev>; Sat,  5 Nov 2022 01:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667613288; x=1699149288;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=BWyOVHcYjGNHgPgYJFQZxzrNVguTi2BzFshMjf3Fowo=;
  b=Fd3ppsJk5DVtpKKq9n4dIPqfQQaxbkGJmhKgrRX6iXEKozTOeU5rGlP5
   3lgk4qOGn6VEX/I6eoOofGrTukqFprzuuJMHOV4YhaH6jwjaeUIeAFEDx
   lKsZCoS5Ek+OpBjp+E211fbsL77mA1mc7wjwrlq9YO+rI+eA0Tg81Sr/n
   EXnMw/0wENkJTPUHZBtJY4xG09dzDHwp9k3u2kLGuhhwXY/iLmgHfYISR
   aGvwZ26/XNhGimbGf/qJYm6mYl/0dlUSujuwzelFSN1AW/hJytTfuaBz8
   IzWdtmGbAtRVUOfJ9wiqk+0bGW2mQfRxZjj97G1Vxkk0hhDWHmEuY1TC7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="289837723"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="289837723"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 18:54:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="666568585"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="666568585"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.180]) ([10.254.213.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 18:54:44 -0700
Message-ID: <5e9bf515-0d3a-9c4e-69b7-820b14979f6b@linux.intel.com>
Date: Sat, 5 Nov 2022 09:54:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C5A49961FA71CC7881428C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/7] iommu/vt-d: Add blocking domain support
In-Reply-To: <BN9PR11MB5276C5A49961FA71CC7881428C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/11/4 10:11, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 3, 2022 1:53 PM
>>
>> +/*
>> + * Clear the page table pointer in context or pasid table entries so that
>> + * all DMA requests without PASID from the device are blocked. If the page
>> + * table has been set, clean up the data structures.
>> + */
>> +static void device_block_translation(struct device *dev)
> 
> given this helper will be used both by existing paths and the new block
> domain, it makes more sense to have it work with existing paths first
> i.e. merging with patch3 and then add block domain after.

Yes. Sounds good.

> 
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	unsigned long flags;
>> +
>> +	if (!dev_is_real_dma_subdevice(dev)) {
>> +		if (sm_supported(iommu))
>> +			intel_pasid_tear_down_entry(iommu, dev,
>> +						    PASID_RID2PASID, false);
> 
> Since commit 4140d77a aliases devices don't share pasid table,
> which implies that pci_for_each_dma_alias() is required as did
> in domain_context_clear().

The PCI alias devices have already been covered by the iommu group
concept in the iommu core. On the contrary, I've been thinking about
retiring pci_for_each_dma_alias() in domain_context_clear().



> 
>> +		else
>> +			domain_context_clear(info);
>> +	}
>> +
>> +	if (!info->domain)
>> +		return;
>> +
>> +	spin_lock_irqsave(&info->domain->lock, flags);
>> +	list_del(&info->link);
>> +	spin_unlock_irqrestore(&info->domain->lock, flags);
>> +
>> +	domain_detach_iommu(info->domain, iommu);
>> +	info->domain = NULL;
>> +}
>> +

Best regards,
baolu
