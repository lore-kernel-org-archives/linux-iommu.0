Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7110F4
	for <iommu@lists.linux.dev>; Fri, 17 Nov 2023 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNCRpeem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700183635; x=1731719635;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=srIWrIHi33EZYV+G7ToWg2W37bXl/+0uSAUvKtzS4DE=;
  b=lNCRpeemZcwkcHNQK+dQTGwKO1iAxsv/TXc8y9w4v80GSXhWW1IhzvUH
   dXJ1nShyte9SEH2P/z5S6UkeeK0ckdtyTrU7ryTQEyNzlJUWC7TFQ2CO2
   /H01g43dGaGrDoyiQXIfPHnipqzW+klq09ik3kFM1pfertzIebFlP/LX5
   1fHdHuScfsnrNbWQ/fccCoGtta6sY83fWGJ5vTH62oGVtvSVnx7AKjFvm
   W9Lc9iaOGOotTCGuJ6Ivo0w2+XxQsz18ybJL4+iaAWi35puSVYxnWglFf
   0WfCXD+XCacNs/SwJtY7lBRyKeC9sqENjrPAJ0zRM3wfjvmaZG6k1ant1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="12762606"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="12762606"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 17:13:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="741932026"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="741932026"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2023 17:13:51 -0800
Message-ID: <4643b52a-432b-48a7-9dcc-da5deead0a81@linux.intel.com>
Date: Fri, 17 Nov 2023 09:09:38 +0800
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
Subject: Re: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
 <0f8c95f3-c16e-497e-9734-85936ae08f82@linux.intel.com>
 <BN9PR11MB52761B8ECFC7A5724A61894E8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52761B8ECFC7A5724A61894E8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/23 4:24 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 16, 2023 3:35 PM
>>
>> On 2023/11/14 9:10, Lu Baolu wrote:
>>> When IOMMU hardware operates in legacy mode, the TT field of the
>> context
>>> entry determines the translation type, with three supported types (Section
>>> 9.3 Context Entry):
>>>
>>> - DMA translation without device TLB support
>>> - DMA translation with device TLB support
>>> - Passthrough mode with translated and translation requests blocked
>>>
>>> Device TLB support is absent when hardware is configured in passthrough
>>> mode.
>>>
>>> Disable the PCI ATS feature when IOMMU is configured for passthrough
>>> translation type in legacy (non-scalable) mode.
>>>
>>> Fixes: 0faa19a1515f ("iommu/vt-d: Decouple PASID & PRI enabling from
>> SVA")
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>    drivers/iommu/intel/iommu.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 11670cd812a3..c3ec09118ab1 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1413,6 +1413,10 @@ static void iommu_enable_pci_caps(struct
>> device_domain_info *info)
>>>    	if (!dev_is_pci(info->dev))
>>>    		return;
>>>
>>> +	if (!sm_supported(info->iommu) && info->domain &&
>>> +	    domain_type_is_si(info->domain))
>>> +		return;
>>> +
>>>    	pdev = to_pci_dev(info->dev);
>>>
>>>    	/* The PCIe spec, in its wisdom, declares that the behaviour of
>>
>> Perhaps we could move the check into the caller and make this helper
>> transparent to the iommu mode and domain type?
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 11670cd812a3..9bddd4fbbdf8 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2492,7 +2492,8 @@ static int dmar_domain_attach_device(struct
>> dmar_domain *domain,
>>                   return ret;
>>           }
>>
>> -       iommu_enable_pci_caps(info);
>> +       if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
>> +               iommu_enable_pci_caps(info);
>>
> 
> IMHO both old and this new version are confusing regarding to that
> the commit msg talks only about ATS but the actual code disable all
> pci caps. It's correct, being that only ATS is relevant in legacy mode,
> but the readability is not good.

The function name is a bit misleading, but its actual purpose is to
enable the ATS feature. PASID is enabled within this function due to a
specification requirement that prevents modifications to PASID registers
after ATS activation.

> 
> what about introducing a helper e.g. device_domain_ats_supported(info)
> which includes above checks plus info->ats_supported and then use it
> to replace info->ats_supported in iommu_enable_pci_caps()?
> 

I have a patch series under test which moves the ATS control out to the
device drivers or users (through sysfs node). With that done, we could
simply remove all these and give the control to device drivers or users.

How about considering above after I post that series? And for now, we
can make the fix patch quick and simple.

Best regards,
baolu
