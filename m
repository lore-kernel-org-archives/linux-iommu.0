Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A3132133
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260510; cv=none; b=kVSF/2PDgVSfISV+ofOtMEElKzwntkD/Rf5OB6OgrVOs2SqVcUX5QlS9SFPWn1QIFDntsyD2HXplsDk9YnJjaFCyGYEBsFi5+JUGXvlgj+wa8yWqxQoG49p8wyRby4uRXGzDtzjdQSscrR0jr94AicVoshEXSsSRpdHSc4g5sKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260510; c=relaxed/simple;
	bh=2YW1VcDO5vvDgSqZENQpnOTikqYo3+QOeHpBuHEJ79k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TjFoIz6QI3BYu+5eQRsVsEn/Kk6Q/YfUiKhbjd15pZdF/3CPR8zoyxL6M8huamCFZ1g8LqdQwuZFOP1huTirurJpoX5UmFlBhtwygIZ+Ne9sawnERG9lsNOLRSXcLAHvSmtkV+Ec0HDqUG9BNuqpYK+pbzygZzf02L2WliNMnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGE89Za5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGE89Za5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718260509; x=1749796509;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2YW1VcDO5vvDgSqZENQpnOTikqYo3+QOeHpBuHEJ79k=;
  b=dGE89Za5TQg0DkR+uU7MDBQlhQSfQZKn60oE/4g899mT5IIBVqBU4d+q
   AWW513cPSXKAqrk1Nflr2V3+lbelNma+crpR1nlvShh2puvB0O4IeWEKK
   pt0ATtOa3e1deO1W/m/KYgqi6Dzcva4zdo6gzlIqPo+BidlB4NeR1htL0
   X+9ZjmZo7F83WctpYKM3LlgH0cQoxeEpb8pZbNHJ3o9GEjYPNSfeEhP4j
   wY9vobIHCGvW+uAm3Dj4JnVktIPO27AOFQQxFVwaPYXlu6IiV6xCOXTbm
   bYt5kK2O3Rh5jQSdIfkUengLC3Oh8VGAe3wsj+KI7ZwjPu4tpFYK+SHCV
   w==;
X-CSE-ConnectionGUID: 2SA9bscXSISLMBNaeCfT1Q==
X-CSE-MsgGUID: jARsrehOQ66v2rtN6727MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18881202"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18881202"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:35:09 -0700
X-CSE-ConnectionGUID: jdv7yU8XQAu31tmE04AqOg==
X-CSE-MsgGUID: x3FFM3qqTRWUpMXS9tD9RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="71241593"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jun 2024 23:35:05 -0700
Message-ID: <52144c4e-0421-46ca-bd00-8602c12c901a@linux.intel.com>
Date: Thu, 13 Jun 2024 14:32:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
 <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240612131946.GT791043@ziepe.ca> <20240612135021.GY791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612135021.GY791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:50 PM, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2024 at 10:19:46AM -0300, Jason Gunthorpe wrote:
>>>> I prefer not to mess the definition of user API data and the kernel
>>>> driver implementation. The kernel driver may change in the future, but
>>>> the user API will remain stable for a long time.
>>> sure it remains stable for reasonable reason. Here we defined some
>>> fields but they are even not used and checked in the kernel. IMHO it
>>> suggests redundant definition. If there is value to keep them, do we
>>> need to at least verify them same as the completion record?
>> They are not here for the kernel, they are here for userspace.
>>
>> A single HWPT and a single fault queue can be attached to multiple
>> devices we need to return the dev_id so that userspace can know which
>> device initiated the PRI. Same with PASID.
>>
>> The only way we could remove them is if we are sure that no vIOMMU
>> requires RID or PASID in the virtual fault queue PRI fault message.. I
>> don't think that is true?
>>
>> Cookie is not a replacement, cookie is an opaque value for the kernel
>> to use to match a response to a request.
> Oh I got this wrong, the above is the response, yeah we can ditch
> everything but the cookie, and code right?
> 
> struct iommu_hwpt_page_response {
>         __u32 cookie;
>         __u32 code;
> };
> 
> What is the workflow here? We expect the VMM will take the vIOMMU
> response and match it to a request cookie for the kernel to complete?

The workflow in the host kernel involves looking up the iopf_group using
the cookie value in the response queue and then responding to the
iopf_group with the code. Therefore, from the host kernel's perspective,
it is acceptable if the user only passes the cookie and code in the
response message.

Since you both agreed that the response message could be simplified, I
will implement the above structure in the new version.

Best regards,
baolu
