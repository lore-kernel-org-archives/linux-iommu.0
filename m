Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4A1F940A
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076754; cv=none; b=g9nUxURBBPTbsIvysY1od0/8py4DDB5Z+QjxjJmKYo7wv6Hd0Tf1s1KRo1TGC2JpHTLeQOVabHEHhzcyXLusI15ObAOLT35xZDefSGEevgWGbkWvAMYWVMjgRSwhAcF+OT9U3+d8Zt3uwm6Ay0Cpc/CLDj1reL9ytwcTF+2voMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076754; c=relaxed/simple;
	bh=LWaROX7SXgmCqlPc9buCPJ2DbnKs+5PqvizBKQBGnPE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q6ry2V4Ziqn5Q2qHHZ01l5npO5zZ3iMtF4X6K6XDqg8kPiW+ivEffjAv39iGWg46aDWsYRCWtqbfiMxsycBCXvaU+tMvXdYIa/RTi2xi8z42eyWC4gQk6RPPGPUsCmnH9qniUsqETHypeZAj8s8oSPgsUgtspBwIlTi9ydMeycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXDnjk7C; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXDnjk7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741076753; x=1772612753;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LWaROX7SXgmCqlPc9buCPJ2DbnKs+5PqvizBKQBGnPE=;
  b=LXDnjk7CVTmAZjor6j5h7l2OwHMLE/vNwQfSdKLVMtJcvxpUtQv2y/St
   nAGEHuTM/opQcz6EURneqKG+p7d+386opAFLErj3k14rWa04GKhmASFup
   mqKUo1gd9/TfNzy2gYOYy4ltVJ4zfGj2AWbDtU5YKtk//IgfOic5oihwr
   B/oclotScPr/dIlEMMZcEFV1GLwxq5oYQcCFocMBqMc2wHFB6tYgM65Tj
   TaMvhSDN+XElcpKqdDQWys7gsX+Rg+TtZ1Z2lTqoEQr/O0rVQton0SrNs
   RC/gxC7lYLm40kGx6y80woVw+7BRFNMS/v7CQI8zr3PV7kIffP3TL+Kg4
   w==;
X-CSE-ConnectionGUID: 4WykMHq/SIO4u6zanQ3j5Q==
X-CSE-MsgGUID: vD5EfwaPQGmfUtg6nR9rKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45909124"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="45909124"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:25:53 -0800
X-CSE-ConnectionGUID: LYPIdh6bQe+dhpS+hpcqAg==
X-CSE-MsgGUID: HxsuqgwDSTetz9/nVdtNJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118036387"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.112]) ([10.124.240.112])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:25:49 -0800
Message-ID: <3963b517-a609-4c53-b373-f0424cb84099@linux.intel.com>
Date: Tue, 4 Mar 2025 16:25:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Jiang, Dave" <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/12] iommu/vt-d: Move scalable mode ATS enablement to
 probe path
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
 <20250228092631.3425464-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52768462B8DDFBAB1EDE02C28CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768462B8DDFBAB1EDE02C28CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/3/4 16:15, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Friday, February 28, 2025 5:26 PM
>>
>> Device ATS is currently enabled when a domain is attached to the device
>> and disabled when the domain is detached. This creates a limitation:
>> when the IOMMU is operating in scalable mode and IOPF is enabled, the
>> device's domain cannot be changed.
> could you extend it with your earlier reply?
> 
> https://lore.kernel.org/linux-iommu/6a418974-d06e-46e3-879f- 
> ab4c84a95231@linux.intel.com/
> 
>> -static void iommu_enable_pci_caps(struct device_domain_info *info)
>> +static void iommu_enable_pci_ats(struct device_domain_info *info)
>>   {
>>   	struct pci_dev *pdev;
>>
>> -	if (!dev_is_pci(info->dev))
>> +	if (!info->ats_supported)
>>   		return;
>>
>>   	pdev = to_pci_dev(info->dev);
>> -	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>> -	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
>> +	if (!pci_ats_page_aligned(pdev))
>> +		return;
>> +
>> +	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
>>   		info->ats_enabled = 1;
>>   }
>>
> still prefer to some comment above as you explained in above
> reply. It's not obvious w/o knowing the tricky background.

Okay, sure.
