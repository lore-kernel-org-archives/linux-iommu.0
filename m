Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC9A48
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 06:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683095862; x=1714631862;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=igBS5JYjxm12TUIwYix1XFx53k9IZdzxu0ykqR6Gpfk=;
  b=Zb6ACV6P0SlYwB+eM7BFG44wIOMArSSB9mVDE5J021JIZkdHNu+K6VZd
   WlH18sb5lZTRGd2QoawGRQyVJ+16IcspS1TmVlETl9lT8Mp7Hx/eZnXS2
   haWD8oj8c/wPzQx1KxlGHPzENGei+/AY469LtJh1ZAMAUBuhPPOLYCkrk
   f7fMZ51wbrJBtgmPe8iIhLkgIx78OiouUSGtHN85xJ5mFrTG9bGGeKp63
   78aHMsBZPUMe8DThWvFh/vWy/ab8Qs4qxntyq9ntD9CLTCPp8/Q5Kkcyx
   wVIg4PQyE5nr10ywRw1pDHVyNwg17wH5AiQe4gLf5lNPLX1rTo74Z7AmS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="348623713"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="348623713"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 23:37:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="673962607"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="673962607"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 02 May 2023 23:37:36 -0700
Message-ID: <9fb1c0dd-ea78-a3f7-9eac-3154f5d08ad5@linux.intel.com>
Date: Wed, 3 May 2023 14:37:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: Re: [PATCH v5 4/7] iommu/vt-d: Factoring out PASID set up helper
 function
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-5-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276726E67301703BD10833B8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276726E67301703BD10833B8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/23 5:47 PM, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Friday, April 28, 2023 1:50 AM
>>
>>
>> +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
>> +					   struct intel_iommu *iommu,
>> +					   struct device *dev, ioasid_t pasid)
>> +{
>> +	int ret;
>> +
>> +	/* PASID table is mandatory for a PCI device in scalable mode. */
>> +	if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
>> +		return -EOPNOTSUPP;
> 
> "&&" should be "||"
> 

Also should return success instead if this is a RID case. Perhaps,

	if (!sm_supported(iommu) || dev_is_real_dma_subdevice(dev))
		return pasid == RID2PASID ? 0 : -EOPNOTSUPP;

Best regards,
baolu
