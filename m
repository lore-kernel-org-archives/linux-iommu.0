Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6AEA3D
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 05:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232833; x=1692768833;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6i2RpXaeSR7jqoTd/Rc9CeF8XiQpcxD4PplfZTVczFs=;
  b=oJFpHUPCinjUUtUnTWi+1fl+cNqNjI5BaUdYeo7hWr8j8azyPcOkmjd7
   TfvV3oKStmgAaGtdFItioi4MYVK+M+2NTBFv1wbW6Rm/pUPV2ryUYPTdu
   IZyX28wQvcNFRsbo0DCmID95e+dhx//czpQe20DCkvAcp1AdRV3tmMzh6
   ugqKtlCWds8+xAWJ/AXuOMCxzMIvxKFci4fOBbjh4J8hzahuTKx66QdY9
   ZnoXBCZZXOAEkr9i+Gi3Zy4QpHCfTfTKYB6n6QQTzVNZ/leCs85ZjLnR0
   f5g1H6lz87MBaPvsodj+rky5scc4x5E/D4zBsO0g2xetGy59RpNWi9XPY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="319635830"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="319635830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:33:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="642310659"
Received: from xujinlon-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:33:42 -0700
Message-ID: <dce4044b-071a-263d-9bf5-fccc06a5619a@linux.intel.com>
Date: Tue, 23 Aug 2022 13:33:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>, "Jin, Wen" <wen.jin@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Fix kdump kernels boot failure with
 scalable mode
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220817011035.3250131-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276364739832848F15932B68C6D9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <11e8ceac-97a5-c8ea-73c3-760929bca263@linux.intel.com>
 <BN9PR11MB52763F4F7641AEA6D942E88A8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763F4F7641AEA6D942E88A8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/22 12:42, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, August 18, 2022 7:13 PM
>>>>    	rtaddr_reg = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
>>>> -	ext        = !!(rtaddr_reg & DMA_RTADDR_RTT);
>>>> -	new_ext    = !!ecap_ecs(iommu->ecap);
>>>> +	ext        = !!(rtaddr_reg & DMA_RTADDR_SMT);
>>>> +	new_ext    = !!ecap_smts(iommu->ecap);
>>>
>>> should be !!sm_supported()
>>
>> Not really. The IOMMU was setup by the previous kernel. Here we just
>> check whether the scalable mode was enabled there.
> 
> You want to compare whether old kernel and new kernel enable
> the same mode. ecap_smts is only about the capability. only
> sm_supported() can tell the mode which is actually used by the
> new kernel.

Oh, yes! You are right. I will update this.

> 
>>
>>>
>>>>
>>>>    	/*
>>>>    	 * The RTT bit can only be changed when translation is disabled,
>>>> @@ -2747,6 +2705,10 @@ static int copy_translation_tables(struct
>>>> intel_iommu *iommu)
>>>>    	if (new_ext != ext)
>>>>    		return -EINVAL;
>>>>
>>>> +	iommu->copied_tables = bitmap_zalloc(BIT_ULL(16), GFP_KERNEL);
>>>> +	if (!iommu->copied_tables)
>>>> +		return -ENOMEM;
>>>> +
>>>>    	old_rt_phys = rtaddr_reg & VTD_PAGE_MASK;
>>>>    	if (!old_rt_phys)
>>>>    		return -EINVAL;
>>>
>>> Out of curiosity. What is the rationale that we copy root table and
>>> context tables but not pasid tables?
>>
>> We only copy the context table and reconstruct it when the default
>> domain is attached. Before that, there's no need to reconstruct the
>> pasid table, hence it's safe to use the previous pasid tables.
>>
> 
> I still didn't get why context table must be reconstructed but not
> pasid table...

The pasid table is also reconstructed. The context table entry and the
pasid tables are reconstructed together, hence there's no need to copy
the pasid table.

Best regards,
baolu
