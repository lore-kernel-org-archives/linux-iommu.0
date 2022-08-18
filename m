Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F233F3C1D
	for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660821198; x=1692357198;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q6bejHNbuks/D/XWIoTaxaxn4NjhAHgyJDnpMYChr3o=;
  b=aOazxKWQ41kfDA67U0vK97iCZ2ft7gTcKwcwf8l3LMcezb68YbvEcy04
   1fNz2Zfn29OOXaEpgdHKblxky7jOs1llq50+LP7HFXrSRnGBVXLzm9I0j
   UnmobW8P4h71hi+S05/Q8qHrTolLZ9RIojN+1+lus+uryFzvqjKxFnrjS
   fubzs3fMJ2Pcw0kteiqAO1lrrvpZf9/4iCdCJL48rDj3om9U4VKjuMWN4
   r7OXiPVGNgT/R91yjoCiRESwvWRUU5B3csN/vB52gR0eSqJRh9huHhWjT
   kR2HccnGXPc3DLwdlG9en5RQgZpo9XkaHEraEnggS+/YeyDNJrMxoxQkq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275779109"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="275779109"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:13:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="668061559"
Received: from gaoshunl-mobl.ccr.corp.intel.com (HELO [10.254.209.211]) ([10.254.209.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:13:15 -0700
Message-ID: <11e8ceac-97a5-c8ea-73c3-760929bca263@linux.intel.com>
Date: Thu, 18 Aug 2022 19:13:13 +0800
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276364739832848F15932B68C6D9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/18 16:32, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, August 17, 2022 9:11 AM
>>
>> The translation table copying code for kdump kernels is currently based
>> on the extended root/context entry formats of ECS mode defined in older
>> VT-d v2.5, and doesn't handle the scalable mode formats. This causes
>> the kexec capture kernel boot failure with DMAR faults if the IOMMU was
>> enabled in scalable mode by the previous kernel.
>>
>> The ECS mode has already been deprecated by the VT-d spec since v3.0 and
>> Intel IOMMU driver doesn't support this mode as there's no real hardware
>> implementation. Hence this converts ECS checking in copying table code
>> into scalable mode.
>>
>> The existing copying code consumes a bit in the context entry as a mark
>> of copied entry. This marker needs to work for the old format as well as
>> for extended context entries. It's hard to find such a bit for both
> 
> The 2nd sentence "This marker..." is misleading. better removed.

Okay. I will make it like "It needs to work for ...".

> 
>> legacy and scalable mode context entries. This replaces it with a per-
>> IOMMU bitmap.
>>
>> Fixes: 7373a8cc38197 ("iommu/vt-d: Setup context and enable RID2PASID
>> support")
>> Cc: stable@vger.kernel.org
>> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> Tested-by: Wen Jin <wen.jin@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ...
>> @@ -2735,8 +2693,8 @@ static int copy_translation_tables(struct
>> intel_iommu *iommu)
>>   	bool new_ext, ext;
>>
>>   	rtaddr_reg = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
>> -	ext        = !!(rtaddr_reg & DMA_RTADDR_RTT);
>> -	new_ext    = !!ecap_ecs(iommu->ecap);
>> +	ext        = !!(rtaddr_reg & DMA_RTADDR_SMT);
>> +	new_ext    = !!ecap_smts(iommu->ecap);
> 
> should be !!sm_supported()

Not really. The IOMMU was setup by the previous kernel. Here we just
check whether the scalable mode was enabled there.

> 
>>
>>   	/*
>>   	 * The RTT bit can only be changed when translation is disabled,
>> @@ -2747,6 +2705,10 @@ static int copy_translation_tables(struct
>> intel_iommu *iommu)
>>   	if (new_ext != ext)
>>   		return -EINVAL;
>>
>> +	iommu->copied_tables = bitmap_zalloc(BIT_ULL(16), GFP_KERNEL);
>> +	if (!iommu->copied_tables)
>> +		return -ENOMEM;
>> +
>>   	old_rt_phys = rtaddr_reg & VTD_PAGE_MASK;
>>   	if (!old_rt_phys)
>>   		return -EINVAL;
> 
> Out of curiosity. What is the rationale that we copy root table and
> context tables but not pasid tables?

We only copy the context table and reconstruct it when the default
domain is attached. Before that, there's no need to reconstruct the
pasid table, hence it's safe to use the previous pasid tables.

Best regards,
baolu
