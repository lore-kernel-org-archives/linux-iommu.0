Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C72394
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708305785; cv=none; b=MXmIFsWCMazU6ffwnjnPtTfN9Jyc8eC6IRHBfola2j791cgofpRx2M6EWzt6nmBFBM8ziM32Y+XpO3vqfIKH5v8XCf6eha/HMIVBs1WrmL5jLxCO6+rUbs+vzGY1qPtanJ1yEz0m6yYJWZ2ziFklhnvkfFBWtohDYrzkuSPKP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708305785; c=relaxed/simple;
	bh=ErUsHVWm03NCXjrA3IcMgqDugYAVFHcylMYYcp9ewZk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eqOKWL1NFYhUHeD5k+sloP4GX393yqMCQh97A71I4KqdSGfXJ7o4TgFD1S4afZD1blQWQZ3A6kAcMj7NSraOYQ/hzZQgB+ptMmQng1SCnF2+B2qoHR3IsIVcNGzyHKk4vUtgfPURqvvnnUgU5NHqP+XXlQwvKDorOKNUSI6JXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njwW/XO6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njwW/XO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708305784; x=1739841784;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ErUsHVWm03NCXjrA3IcMgqDugYAVFHcylMYYcp9ewZk=;
  b=njwW/XO6KfKXhgu6gkPhPiIBZvmmthyMSCbWD8ZMOdq7qfuIo/ncRHlH
   RHe+Beu3GhzIvtZbsbeFULdLy85faNokB/ng+nAnC2A+a458zha6dTmgL
   Ldb1mamloWepwdXpp0Ye72TeaCY7fVZpMMwJRjr+aoswEhQfafH/CKLeQ
   xSr7U2Oz6yOaLGKAJzonCq6tF36aR6/tMpEwe9SYWtRXGqA4uUr24R807
   kimrNnANjZsk4W+Pfbc9UbR0NALr6BFwi6MxhipuZZEYXWBfuft5141sL
   ClaLR9+CTP6DGTFKNPTEJLW/4LFSkgGjYAwjfIGxyFDHCrCKVD/cAMmBf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13480215"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="13480215"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 17:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="9004397"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 18 Feb 2024 17:23:02 -0800
Message-ID: <11a7fa60-ee7f-4acc-ac17-70f63ecd2d4b@linux.intel.com>
Date: Mon, 19 Feb 2024 09:17:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 09/11] iommu/vt-d: Reuse intel_iommu_set_dev_pasid
 function
Content-Language: en-US
To: "Zhang, Tina" <tina.zhang@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-10-tina.zhang@intel.com>
 <5f57c685-04ab-4c70-b305-aa42b97b703a@linux.intel.com>
 <MW5PR11MB5881593A3C0398E97F6B07A589512@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <MW5PR11MB5881593A3C0398E97F6B07A589512@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 9:01 AM, Zhang, Tina wrote:
>>> +		if (ret)
>>> +			goto out_free;
>>> +
>>> +		ret = domain_attach_iommu(dmar_domain, iommu);
>> The same here.
>>
>> The domain_attach_iommu() is called to setup the relationship between a
>> domain and an iommu. You should make it compatible with sva domain as
>> well.
> The problem is whether we need struct iommu_domain_info for sva domain. I didn't see any necessary to allocate struct iommu_domain_info instance for sva domain, as all the fields of struct iommu_domain_info can be gotten from dev_pasids.
> 
> Since we want to make the domain_attach_iommu() generic (i.e., all domains, no matter what type they are, need to call this function), I think we can check the domain type within the function and add comments there to tell that we didn't see any necessary to let sva domain have a struct iommu_domain_info and therefore the function returns immediately if it meets a sva domain. What do you think?

The SVA domain is nothing special compared to other types of domains.
The ultimate goal is that we should have a common attach-detach
implementation for all.

The iommu_domain_info structure stores the relationship between a domain
and IOMMU, mainly for the cache tag information, also known as the
domain ID. It's a bit outdated if we consider SVA and nested domains. As
I told in another thread, I am working on a solution to address
this. Let's sync our efforts to avoid duplication of efforts.

Best regards,
baolu
