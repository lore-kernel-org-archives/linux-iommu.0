Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BB2C9D
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668167837; x=1699703837;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Lmn4C24AWDgykOuF/NFLzvFk/w6nibxOYuugloUk8zU=;
  b=J/I3PCqYjqfRh7nzoObfRSIOpxjHufamvUeZwrlbVxrCtrSvmu6o6b8Q
   sWCcnFa0WNV8zHKphz3tszZhCgb7AY1mZy2O68Ue1WI/jP9NATOGIrROu
   RvjrdRQL27z6J/vQLQMzvop9DOr0DjtyR8eutZA4UxUXtGKAW8cDla22j
   lGEEHFbEXB7GNNcFmsMAGyypicpCSEN+T0vYVA4BrnwGkXcvOLTxrFrPz
   YZXpuAA+4ATBMZutOrI25YH6ySacHx12+o81VGYfdw3lhk3PL/7tW6V0v
   MC7V6kySn/oruvq7tXDAHbbgxdMaLH+l/ZygjYyCfSt4/bqBZ2Bxlyun6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373714649"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="373714649"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:57:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812422141"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="812422141"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.246]) ([10.254.215.246])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:57:14 -0800
Message-ID: <804d8102-f22c-2ac3-55d8-76b85cf526af@linux.intel.com>
Date: Fri, 11 Nov 2022 19:57:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
 <20221108073408.1005721-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52766AB454992F154C301CB28C009@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d7f72290-c11a-64f7-c8ac-b752835d182d@linux.intel.com>
 <BN9PR11MB5276C64B56A1D1C658825C0B8C009@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 2/8] iommu/vt-d: Improve iommu_enable_pci_caps()
In-Reply-To: <BN9PR11MB5276C64B56A1D1C658825C0B8C009@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/11/11 16:16, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, November 11, 2022 2:59 PM
>>
>> On 2022/11/11 11:45, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, November 8, 2022 3:34 PM
>>>>
>>>> The PCI subsystem triggers WARN() if a feature is repeatedly enabled.
>>>> This improves iommu_enable_pci_caps() to avoid unnecessary kernel
>>>> traces through checking and enabling. This also adds kernel messages
>>>> if any feature enabling results in failure. It is worth noting that
>>>> PRI depends on ATS. This adds a check as well.
>>>
>>> Cannot we have a helper to check whether this device has been attached
>>> to any domain? If no in the blocking path then disable PCI caps. If no
>>> in the attaching path then enable PCI caps.
>>>
>>> I just didn't get the point of leaving them enabled while the device can
>>> not do any DMA at all.
>>
>> Ideally, the kernel owns the default policy (default on or off). The
>> upper layers are able to control it over IOMMUFD uAPI or kerneld kAPI.
>> I can't see the benefits of associating these features with the
>> existence of any domain.
> 
> we don't have such uAPI or kAPI today.
> 
> the current behavior before your change is default off and then toggled
> along with attach/detach domain. as only one domain is allowed per
> RID it implies the capabilities are toggled along with DMA allow/block.
> 
> now you change it to a messy model:
> 
>    - default off when the device is probed
>    - turn on at the 1st domain attach and never turn off until release
>    - but iommu_enable_pci_caps() is still called at every domain attach
>      with band-aid to allow re-entrant
> 
> this isn't like a good cleanup...

Fair enough. We should not bury this behavior change in a cleanup
series. Okay! I will keep the previous behavior.

Best regards,
baolu
