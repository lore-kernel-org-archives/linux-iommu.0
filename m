Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71042377
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 02:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695349602; x=1726885602;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gAIOorlW34g9DMzI0VzKyqvYPPKTCi8OLTLEgY2Hhic=;
  b=J4TIMzyfpq5vUALQnWDOBWdlhqlBzcrjubT9sSAah1K3qjxmvUK0mrPy
   hvwAws1053ijZkXaTQWu9JeJArqnNjewnndCBImjIMZT3CzmeLH2+Jf4L
   HV+91QYHiZvZZH/kZMux0GS3xAFajr6UObhV+ycn77bmWXK6F4agxTD6i
   8XBJXPb9Ouqsr/x1ufUf3cupUuxVDN9ZuENVDPN7RMUod7T9Dc+oi0nGH
   UHxXupR91gbKvRgTNvIox0Bh9/TPBjM5OEXy8B3SWFyqbL6CFa17kIS4l
   nKzwzHknZNL0hc8W9YLAB6eZc7uGts33FaOien+neecjB0NQRKQWES7/a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360970356"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360970356"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 19:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="782474857"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="782474857"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2023 19:26:36 -0700
Message-ID: <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
Date: Fri, 22 Sep 2023 10:23:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 "Huang2, Wei" <Wei.Huang2@amd.com>, "jsnitsel@redhat.com"
 <jsnitsel@redhat.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230921163154.GO13733@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/23 12:31 AM, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 03:15:42PM +0000, Deucher, Alexander wrote:
>>>> Does this patch or the following patches make any functional changes
>>>> for devices?  E.g., devices which supported ATS would have been put
>>>> into an identity mapping mode previously Is that still retained?
>>>
>>> Huh? Why would we ever want to do that?
>>>
>>> Policy for the default domain belongs in the iommu subsystem except in
>>> extreme cases, the AMD driver should not be doing random things like forcing
>>> identity for ATS capable PCI devices.
>>
>> I'm just concerned about regressions in random devices due to a
>> change in policy in the IOMMU driver.  Previously the IOMMU driver
>> would put ATS compatible devices into 1:1 mode.  Also some of the
>> earlier integrated GPUs require 1:1 mapping for display from system
>> memory due to hardware limitations.  There were also a lot of sbios
>> bugs in the carrizo/raven timeframe because windows didn't enable
>> the IOMMU so lots of OEMs had bogus IOMMU ACPI tables which didn't
>> cause problems when 1:1 mode was used.
> 
> That is a fair concern.
> 
> But we need to root those out and fix them as narrow quirks. We don't
> want a driver to have blanket ATS == identity configuration, it will
> harm other legitimate applications.

I am interested in the policy that an IOMMU driver would apply to ATS
when the default domain is configured in PASSTHROUGH mode.

I have considered the following cases:

1) PCI device supports ATS but *no* PASID
    In this case, ATS only means a TLB cache in the device, and it does
    not make much sense to cache the 1:1 mappings in the device. Even
    worse, the ATS translation requests could probably cause I/O
    congestion in corner cases. Therefore, the best choice is probably to
    disable ATS on the device.

2) PCI device supports ATS and PASID
    In this case, ATS is required for PRI, so we should enable it even if
    the default domain has been configured to PASSTHROUGH mode.

Is this the right way to think about it?

Best regards,
baolu
