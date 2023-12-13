Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D31C2F
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCfDbLYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702436811; x=1733972811;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZjD71DlGEIIFrCdIe9f5RzX0tD7jMDiwT/xx03wcMDs=;
  b=CCfDbLYQg04dsVNpiZnL5Z7UU/z7z5jetQLCxI/ek6VjqtKft9kv3EHA
   IuFvWGSoPrXjBVR09d1Zs63H15P157WgATv8TEORD9ay5qT0E/ZbfCSVG
   GQLIWvshq+0xO917KVq20kpwSyn90hu6pDljnRs5vQler8+c9UUdFY4Xk
   p6K07ZsA2uBRH6e8f1Bygxj3x6A3iE4p24QYtRWn2UA7VgHtfioN5GpOj
   ETn+MBOPoihzlGeq1B9D7yRj+AQwe47Gvxa38X4cAs/9F5bYGSQB+NX++
   0P+TsIWKcqL32Cu8IdCElwweuhcMZbt2ViLOZLSzmW+m6E/exlzaZNdoa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2039555"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2039555"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 19:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="808008365"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="808008365"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2023 19:06:47 -0800
Message-ID: <7d3a30cd-bd70-47e3-948e-32b0b68da3a3@linux.intel.com>
Date: Wed, 13 Dec 2023 11:02:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1161d8aa-9fcc-4e9e-a7d3-c461fee19a54@linux.intel.com>
 <BN9PR11MB5276AC40C423A0BAAE9F40A98C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bef0f903-3665-492f-8999-fe759be5fed4@linux.intel.com>
 <BN9PR11MB5276614392E99F75B6A592C68C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d16460ff-f46f-4b20-8173-a81ac413b56d@linux.intel.com>
 <DM4PR11MB5278A37E1F30141D3DBF3FBF8C8DA@DM4PR11MB5278.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DM4PR11MB5278A37E1F30141D3DBF3FBF8C8DA@DM4PR11MB5278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/23 11:04 AM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, December 13, 2023 10:44 AM
>>
>> On 12/13/23 10:20 AM, Tian, Kevin wrote:
>>>>> 	if (!dmar_map_gfx)
>>>>> 		iommu_identity_mapping |= IDENTMAP_GFX;
>>>> So with above cleaned up, we have no need to worry about drivers that
>>>> are not capable of handling remapped dma address any more.
>>>>
>>>> Did I miss anything?
>>> I prefer to removing IDENTMAP_GFX in this series and put a comment
>>> explaining why Azalia device has no problem.
>>>
>>> Then send a separate patch to remove the GFX workaround option.
>>> If there is any valid usage still relying on that, it's easy to revert.
>> Agreed. We should be more cautious. Perhaps I will postpone this series
>> to a time when we are sure that graphic drivers are okay with this
>> change. As a first step, perhaps we can make a change to remove the
>> workaround for graphic drivers, so that any hidden bugs in the graphic
>> driver could be reported.
>>
>> The patch looks like,
>>
>> iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
>>
>> Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA
>> option for
>> broken graphics drivers") was introduced 24 years ago as a temporary
>> workaround for graphics drivers that used physical addresses for DMA and
>> avoided DMA APIs. This workaround was disabled by default.
>>
>> As 24 years have passed, it is expected that graphics driver developers
>> have migrated their drivers to use kernel DMA APIs. Therefore, this
>> workaround is no longer required and could been removed.
> and igfx_off option is still available just in case.

Yeah!

> 
>> Suggested-by: Kevin Tian<kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>    drivers/iommu/intel/iommu.c | 10 ----------
>>    drivers/iommu/intel/Kconfig | 11 -----------
>>    2 files changed, 21 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 84b78e42a470..27b8638291f2 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2357,9 +2357,6 @@ static int device_def_domain_type(struct device
>> *dev)
>>
>>    		if ((iommu_identity_mapping & IDENTMAP_AZALIA) &&
>> IS_AZALIA(pdev))
>>    			return IOMMU_DOMAIN_IDENTITY;
>> -
>> -		if ((iommu_identity_mapping & IDENTMAP_GFX) &&
>> IS_GFX_DEVICE(pdev))
>> -			return IOMMU_DOMAIN_IDENTITY;
>>    	}
>>
>>    	return 0;
>> @@ -2660,13 +2657,6 @@ static int __init init_dmars(void)
>>    		iommu_set_root_entry(iommu);
>>    	}
>>
>> -#ifdef CONFIG_INTEL_IOMMU_BROKEN_GFX_WA
>> -	dmar_map_gfx = 0;
>> -#endif
>> -
>> -	if (!dmar_map_gfx)
>> -		iommu_identity_mapping |= IDENTMAP_GFX;
>> -
> let's remove IDENTMAP_GFX (and all its references) in a separate patch.
> 
> this patch is for removing the workaround option.
> 
> another patch removes IDENTMAP_GFX as it's meaningless when
> dmar_map_gfx simply implies disabling the gfx iommu.

Okay, it's fine to me.

Best regards,
baolu
