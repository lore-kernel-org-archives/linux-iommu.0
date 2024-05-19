Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B6487BE
	for <iommu@lists.linux.dev>; Sun, 19 May 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716129465; cv=none; b=UbsV8tMTGEON03ZfRRizeGM3Tjnu5nsSG0BFmpQNb7RCZsClr99CBLZWM/5p7J4Chd3bfb5mB4t2JspvKSC8O2pptwkYnVuSx3/51/FeJ4XpKRQqo1fiIER5L2+PhgokjryAdObv7qyJNbWg/8q5RnDKfiUAW66SKqTCFaKlo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716129465; c=relaxed/simple;
	bh=7T1VueeZHq6IfwKomhlIjMYUhBWiRr9Lz4G4Ygn6vuw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fl+vMrZygXmv4xpTkivav4jhQ8HJfmLuEtsvheam/SncAigP2KZj/WwxPUhe5l2QSLRdPjXByU73YXWPc7WvGoHwr9UUkM4Wk0igtZvhPujueLPI9qqS62urmXag77mfv+5StepQ5g7cPADh1u6bomo56BGVbcZosATqHcR0U8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6h1cjpc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6h1cjpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716129465; x=1747665465;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7T1VueeZHq6IfwKomhlIjMYUhBWiRr9Lz4G4Ygn6vuw=;
  b=L6h1cjpcIZK7VpnlYXKQckg7IzzolQGV8CgNWJ8s8wDj9FzS2YmalF60
   Uy7Nq+oE2WkBkWoEeazNjhM/2b0ubhxYbPinNy8MLGv+vIUqB0FwQrybC
   RNBot84KmL7gyFBUrY6EQ6tl5RhY15WOOvEaNK48moqAAwMvGtEZGZjIT
   EPTVIFOYEN8KN3S35t9OjjZy2NgbvRWUAmfYMnNnXX6ZlpKsXzkPUuA+l
   gRagyc2oZzFK+Mqs2Lt2QS0/+qaLHsOpKku8RGHV61i8kR3P+zJ0DBRT1
   GU61KH3dq41w4uaHAl8twTD8A+EUjO69gQCGM7wTT/huXidxMIUNcKO5C
   Q==;
X-CSE-ConnectionGUID: kYpIfSTbSRqD3Hh6PhRpCA==
X-CSE-MsgGUID: isPoHwrURiWoYMJCMzvjgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="23664495"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="23664495"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 07:37:45 -0700
X-CSE-ConnectionGUID: U/887R5zRvye6aFdnJdRfQ==
X-CSE-MsgGUID: HCWUP5VSScSsFHQ85uSJHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="63505015"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.244.72]) ([10.125.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 07:37:41 -0700
Message-ID: <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
Date: Sun, 19 May 2024 22:37:38 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/15 15:43, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>>
>> iommu_hwpt_pgfaults represent fault messages that the userspace can
>> retrieve. Multiple iommu_hwpt_pgfaults might be put in an iopf group,
>> with the IOMMU_PGFAULT_FLAGS_LAST_PAGE flag set only for the last
>> iommu_hwpt_pgfault.
> 
> Do you envision extending the same structure to report unrecoverable
> fault in the future?

I am not envisioning extending this to report unrecoverable faults in
the future. The unrecoverable faults are not always related to a hwpt,
and therefore it's more suitable to route them through a viommu object
which is under discussion in Nicolin's series.

> 
> If yes this could be named more neutral e.g. iommu_hwpt_faults with
> flags to indicate it's a recoverable PRI request.
> 
> If it's only for PRI probably iommu_hwpt_pgreqs is clearer.
> 
>> +
>> +/**
>> + * struct iommu_hwpt_pgfault - iommu page fault data
>> + * @size: sizeof(struct iommu_hwpt_pgfault)
>> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
>> + * @dev_id: id of the originated device
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
>> + * @addr: Page address
> 
> 'Fault address'

Okay.

> 
>> + * @length: a hint of how much data the requestor is expecting to fetch. For
>> + *          example, if the PRI initiator knows it is going to do a 10MB
>> + *          transfer, it could fill in 10MB and the OS could pre-fault in
>> + *          10MB of IOVA. It's default to 0 if there's no such hint.
> 
> This is not clear to me and I don't remember PCIe spec defines such
> mechanism.

This came up in a previous discussion. While it's not currently part of
the PCI specification and may not be in the future, we'd like to add
this mechanism for potential future advanced device features as it
offers significant optimization benefits.

> 
>> +/**
>> + * enum iommufd_page_response_code - Return status of fault handlers
>> + * @IOMMUFD_PAGE_RESP_SUCCESS: Fault has been handled and the page
>> tables
>> + *                             populated, retry the access. This is the
>> + *                             "Success" defined in PCI 10.4.2.1.
>> + * @IOMMUFD_PAGE_RESP_INVALID: General error. Drop all subsequent
>> faults
>> + *                             from this device if possible. This is the
>> + *                             "Response Failure" in PCI 10.4.2.1.
>> + * @IOMMUFD_PAGE_RESP_FAILURE: Could not handle this fault, don't
>> retry the
>> + *                             access. This is the "Invalid Request" in PCI
>> + *                             10.4.2.1.
> 
> the comment for 'INVALID' and 'FAILURE' are misplaced. Also I'd more
> use the spec words to be accurate.

Yes. Fixed.

> 
>> + */
>> +enum iommufd_page_response_code {
>> +	IOMMUFD_PAGE_RESP_SUCCESS = 0,
>> +	IOMMUFD_PAGE_RESP_INVALID,
>> +	IOMMUFD_PAGE_RESP_FAILURE,
>> +};
>> +

Best regards,
baolu
