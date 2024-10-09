Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312245948
	for <iommu@lists.linux.dev>; Wed,  9 Oct 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442041; cv=none; b=OKE38IE7xwbt3JPsZbRADsqghL3iBaej8sGmzkxzMsJvmJiFXScYchohE+0oUCw4oZHmyFSq2o5qgEQomqVMERe3MEh5LM4Ybsb3VdyKs8MARcLqUxxPud9SwJk8VNUrpwW6VlG7NCIjza5WO69c2C9Iarzx/ZvpDuj0EYIqbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442041; c=relaxed/simple;
	bh=UqW2GyTxqXYMpzhcY1eS9V7K1mpkvOTBwPm3cAnV/8A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fFNxbciSwd/WxHOsmyc0lppds3Fvs4Rc8offA/qykF3yIQBl3+we83RPX1WiZ0+Uix7OVcvG4+yEULGAJn6gkrHqkfiOOk5T9760V1Fz3fU0kieOMDdrrxCXcZumFWB+iBxEYgfOW4rHGdds/U5fddwOVFzrR0POIHQX4hDW7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNpQTk0l; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNpQTk0l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728442040; x=1759978040;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UqW2GyTxqXYMpzhcY1eS9V7K1mpkvOTBwPm3cAnV/8A=;
  b=mNpQTk0lhp4Gx6K0FxMAM7rX3qJ0EdCqRK4cBs62/j6DA+uGN1Z6Ul3Z
   mGOYMtkFNCIf1NxA/wIwnbyx25iWPNitl5aB83XlrFO/ntRYDs/WdpPHP
   /yZnbgWhBbxAzDtQgBbiJAeDkK5/eiLoGYc23XCwYUwUhebUx0jHjPRVD
   Bo+BkQ/hIqQ4NI1WlFeOgxHaOIoe18N7bGApjpJ0fkhtfU5zKC6qzRj+3
   mrZGA3j6tlD77ab/KV7pzVYp1rfFuM/ZxEz0ipNwguB6ESodWwwJAttpz
   YW1kLjbt3s7Maj0HsRezqGZop1GKbN70Y1LXCf8T1FQIpt09XPgfgO0iR
   Q==;
X-CSE-ConnectionGUID: NzTG8FjITpm+olUDXNwOEg==
X-CSE-MsgGUID: xukZ4FHzQ1WBmPF0yS8Mhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27596428"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27596428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 19:47:19 -0700
X-CSE-ConnectionGUID: yaMkQ+nUSM6tQdm1VU7l7g==
X-CSE-MsgGUID: y+vshZtRRL2JBVBNoa5PUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="75963992"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 19:47:17 -0700
Message-ID: <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
Date: Wed, 9 Oct 2024 10:47:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, yi.l.liu@intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/2 13:30, Vasant Hegde wrote:
> On 9/11/2024 3:49 PM, Vasant Hegde wrote:
>> This series adds iommu_paging_domain_alloc_flags() which takes flags to
>> pass additional details for domain allocation (like domain with PASID
>> support).
>>
>> Also updates AMD IOMMU driver domain allocation code. With this by
>> default it will allocate domain with V2 page table for PASID capable
>> device and v1 page table for rest of the devices.
>>
>> @Baolu,
>>    With this changes (patch 1), to allocate PASID capable device core
>>    will call domain_alloc_user() interface. Do we need any changes to
>>    intel driver?
> @Baolu,
>    Looks like intel driver works fine with this change. Is that correct -OR- do
> we need any changes to intel_iommu_domain_alloc_user() ?

I still have a question about the following change:

https://lore.kernel.org/linux-iommu/a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com/

This change might cause a functional regression when it comes to nested
translation. In nested translation mode, the user page table (e.g.,
created and managed by a guest VM for guest kernel DMA) must be in the
first-stage page table format. Then, it can be nested on a second-stage
page table managed by the host kernel.

Currently, the kernel automatically selects the page table formats. For
example, the Intel IOMMU driver always uses the first-stage page table
for guest kernel DMA. After this change, this assumption no longer holds
true. This means the kernel might use a second-stage page table for
guest kernel DMA, breaking nested translation.

Thanks,
baolu
