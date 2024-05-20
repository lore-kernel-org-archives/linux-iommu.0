Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2D10788
	for <iommu@lists.linux.dev>; Mon, 20 May 2024 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176120; cv=none; b=knfk3Vy7Ty+pY34FR0Dv8yBfl0mQIJsf3wlsnb2KNr2jQAXtAk2BobjVaRxY7YJsgD0291X8zwW8K8xz3n58i62GxAb6e44niEkAhXQDdtXP7P+0YvC4X9NNuP0PdN7Pb1VSxIj7PT7/To0jbrGeuH8LWPyRE2Hyd/yTnSWNaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176120; c=relaxed/simple;
	bh=TyIccgQPmJ538S0O8+lQ26LzdVubeSZpjoAXC6h4Ua8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pyJEMErUdaJ3+FVI9k6OWUAnS2TQdniqSQSllXCmMc5f6AjBdd8eg0RMk5lWeapDzn8uPS/vZ54dRPMo9w5hmqc/9vLCIPh8nDDoaOLYOFmwYGXjkfGPW6YHQb3KSoHpRJIsOJ+5gLEmQVwsV4L6qbMVg9hAcuD8CHXECKdP67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCFETEMa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCFETEMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716176119; x=1747712119;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TyIccgQPmJ538S0O8+lQ26LzdVubeSZpjoAXC6h4Ua8=;
  b=aCFETEMayu3O8kb6ZpvMoNGMeYxQaBSi13q3k1WCbiVSKoj1WQGg5uWA
   UaAf9YZr6orNQTgFQ72MSIiAFysbbBKE9Oon2Mw4hFhGHJ2JGO5ISdTPN
   YRr9GU0Qhq/iOxkWhpQYuqN47TyFT/p24E6ZsdJQ/VWRCSR67m+FX9p4r
   +hYcNckswTIXJR6PFNWFT3FfB90WRX1j59da8SRtSKmjK7JP8oj7BpXSH
   BWqXNzoPP4IrFcy9s5Tl8wMnPyNbQCms89p8aHM7Vb3fNUbcpKx+RiXoj
   HcprubQn5HRXMU/8wK8GnVUeTj6tAhj/DSQ0UnEGEHv7HxvcRX6ty+ibP
   g==;
X-CSE-ConnectionGUID: B3PiOxIQS/qM8zUTAw41Ww==
X-CSE-MsgGUID: 3I4mcw7wS72Gk+B9CD5z0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="16112116"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="16112116"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:35:18 -0700
X-CSE-ConnectionGUID: X10/efDWSWmQ623fE/SvSQ==
X-CSE-MsgGUID: 1w8bNEQKRkGz01cACbMgXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="36906579"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 19 May 2024 20:35:14 -0700
Message-ID: <04288162-e5fd-48f3-bb60-a41b4ed2c244@linux.intel.com>
Date: Mon, 20 May 2024 11:33:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
 <BN9PR11MB5276A68C9DCDA201826714018CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A68C9DCDA201826714018CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/24 11:24 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Sunday, May 19, 2024 10:38 PM
>>
>> On 2024/5/15 15:43, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, April 30, 2024 10:57 PM
>>>>
>>>> iommu_hwpt_pgfaults represent fault messages that the userspace can
>>>> retrieve. Multiple iommu_hwpt_pgfaults might be put in an iopf group,
>>>> with the IOMMU_PGFAULT_FLAGS_LAST_PAGE flag set only for the last
>>>> iommu_hwpt_pgfault.
>>>
>>> Do you envision extending the same structure to report unrecoverable
>>> fault in the future?
>>
>> I am not envisioning extending this to report unrecoverable faults in
>> the future. The unrecoverable faults are not always related to a hwpt,
>> and therefore it's more suitable to route them through a viommu object
>> which is under discussion in Nicolin's series.
> 
> OK, I'll take a look at that series when reaching it in my TODO list. 😊
> 
>>>> + * @length: a hint of how much data the requestor is expecting to fetch.
>> For
>>>> + *          example, if the PRI initiator knows it is going to do a 10MB
>>>> + *          transfer, it could fill in 10MB and the OS could pre-fault in
>>>> + *          10MB of IOVA. It's default to 0 if there's no such hint.
>>>
>>> This is not clear to me and I don't remember PCIe spec defines such
>>> mechanism.
>>
>> This came up in a previous discussion. While it's not currently part of
> 
> Can you provide a link to that discussion?

https://lore.kernel.org/linux-iommu/20240322170410.GH66976@ziepe.ca/

> 
>> the PCI specification and may not be in the future, we'd like to add
>> this mechanism for potential future advanced device features as it
>> offers significant optimization benefits.
>>
> 
> We design uAPI for real usages. It's a bit weird to introduce a format
> for unknown future features w/o an actual user to demonstrate its
> correctness.

Best regards,
baolu
