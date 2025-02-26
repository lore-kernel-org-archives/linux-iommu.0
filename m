Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BD219EB8
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536677; cv=none; b=bo2es0DfVEDo7zgD2wFSOcB/l5j8ASUqHGf7cZWTyH5wjKo5B5IRZwL0bDxFL6zsejfIlbvMXPWd5fop4y4SOs3EZf3fSD8cjM2vcDQ+0vZzmhmCM6bX9m9XbTfhc51sjMhwIkqB+nmWO9jDhQ7vjLTGmm53HGxdd49gNSE5enM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536677; c=relaxed/simple;
	bh=1jc/lMGlv3kVPdpmD2HJI1EUBDZydt78W/8USOd/RYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRQn5PlsqxiWaVDb8SGITqOqDVZvh6nDMGhp6bpB9XAy+lBYHAvhJxkQXXd0tlWMwSN9qEgAYOzLPBlzyu31XBHzS4mTtlkSzLCuYkw/NsY0NjQmDHD7UTofgIh+iE66z9Osn5CM/SUZGFEooj8Jupf9hcp9AfvRMimNw9J7/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S68HDoQ3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S68HDoQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740536676; x=1772072676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1jc/lMGlv3kVPdpmD2HJI1EUBDZydt78W/8USOd/RYU=;
  b=S68HDoQ39CcFJIFxgLracO9USjD1wBQM/cFBYAMoRdyF8h6HhRjkO/X/
   pHn2hgiHmqu27CxBmRu+ZgeHTDv37l5M5Q4t7geabYZCwx5pzg3s7qcpY
   PPtPdBxl51x28t7ESCoAN2QIM7ekEsUoNZ9IbLQT+jIajAQo8S+uSsu2A
   U49U1jHYWZo3QmLNFt+YmYFyGP3av7cF+j+gpe7EtPi17uLhb06bDxD80
   lg09ZeUC3drUCd95GaLzCurpfItYgruliUwKgxa9VAkRlXSSWsTMZe53P
   dGtRnrrnE59SU7F13z75nLuEsJHaOWbhA0pl6cCJNkZcNJtK1XSkvPe4+
   g==;
X-CSE-ConnectionGUID: rXCWoKoLQB2Y2EYdhSnGeQ==
X-CSE-MsgGUID: pgyjM6nUR8qZpW6ZZn2nKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44193292"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="44193292"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:24:35 -0800
X-CSE-ConnectionGUID: ISu3iAzhTau6FaqIh6n+JQ==
X-CSE-MsgGUID: eiQlo4eBSoGlt5eNoos+DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121815601"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:24:33 -0800
Message-ID: <6a418974-d06e-46e3-879f-ab4c84a95231@linux.intel.com>
Date: Wed, 26 Feb 2025 10:21:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] iommu/vt-d: Move scalable mode ATS enablement to
 probe path
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276066807236213BCFDD2538CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276066807236213BCFDD2538CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 15:28, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, February 24, 2025 1:16 PM
>>
>> Device ATS is currently enabled when a domain is attached to the device
>> and disabled when the domain is detached. This creates a limitation:
>> when the IOMMU is operating in scalable mode and IOPF is enabled, the
>> device's domain cannot be changed.
> 
> I got what this patch does, but not this description. Can you elaborate
> about the limitation?

Okay, sure.

The previous code enables ATS when a domain is set to a device's RID and
disables it during RID domain switch. So, if a PASID is set with a
domain requiring PRI, ATS should remain enabled until the domain is
removed. During the PASID domain's lifecycle, if the RID's domain
changes, PRI will be disrupted because it depends on ATS, which is
disabled when the blocking domain is set for the device's RID.

> 
>> @@ -1556,12 +1528,22 @@ domain_context_mapping(struct dmar_domain
>> *domain, struct device *dev)
>>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>   	struct intel_iommu *iommu = info->iommu;
>>   	u8 bus = info->bus, devfn = info->devfn;
>> +	struct pci_dev *pdev;
>> +	int ret;
>>
>>   	if (!dev_is_pci(dev))
>>   		return domain_context_mapping_one(domain, iommu, bus,
>> devfn);
>>
>> -	return pci_for_each_dma_alias(to_pci_dev(dev),
>> -				      domain_context_mapping_cb, domain);
>> +	pdev = to_pci_dev(dev);
>> +	ret = pci_for_each_dma_alias(pdev, domain_context_mapping_cb,
>> domain);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>> +	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
>> +		info->ats_enabled = 1;
>> +
>> +	return 0;
>>   }
> 
> It'd be good to add a note here for why legacy mode still requires
> dynamic toggle at attach/detach time. It's not obvious w/o knowing
> the story about legacy + identity.

"legacy + identity" is part of the reason. Additionally, in legacy mode,
the ATS control bit is defined as a translation type and should be set
together with the page table pointer in the context entry. Separating
ATS enablement and the translation page table into different places
would make the code more complex and fragile.

> btw the same enabling logic occurs in multiple places. Probably
> you can still make a helper for that.

Yes, I will make a helper like this,

+static void device_enable_pci_ats(struct pci_dev *pdev)
+{
+       struct device_domain_info *info = dev_iommu_priv_get(&pdev->dev);
+
+       if (!info->ats_supported)
+               return;
+
+       if (!pci_ats_page_aligned(pdev))
+               return;
+
+       if(!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
+               info->ats_enabled = 1;
+}

> Otherwise,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks,
baolu
