Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3C1E25EC
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476450; cv=none; b=I+ke3MBLnhVPJ7ZN4HHLP1TuKQAhpX0XbaTX1M0pv7ildTe5rDdL2D9OsN7weLAI1ZkvDstDrMtPrfnuWg5OAIbs4lL2V75TlGs8Mwz58XldoCNd0efCnTCK30pL9AGIkckwEn4HuHdxwi++sL+lKr0+vYXQq1G+WrqqSxUxpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476450; c=relaxed/simple;
	bh=Y74PrUFn3AxYE1teYnMHTvsdwkXlzQQxRMJBXwkz2c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE/M7kNNxUXu8s7BJGT7gqdzhLNTUTbin9W6V0ffvfpDwl4f/Xyulsqe7HRAzpWphMtCZTZuunrd79vJMLWKsLYnONqHIoVWbltiPB3/gJ0T92r6zBe1dWsNAWGclr0VBsPPF5PDJ0v2G9uwWAJ7rAg7nlCg54EZiQj/uVX5820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYi9Wy1T; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYi9Wy1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736476449; x=1768012449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y74PrUFn3AxYE1teYnMHTvsdwkXlzQQxRMJBXwkz2c0=;
  b=aYi9Wy1Tq6ZMa+t7A5LVpc888p7bxNYcHpigrmhYs2kgb+PDVeT6uRMA
   dh3ZB2rfqbcmzHZcz0guWbKf/rQsPgNwNbTHvJ8s2zhZaUnvGRu9+EL1r
   SVFtARaeNZL0k8jGHqMecBj2ij5J7LA3QFQU+jdAKQbERXRHNsu1ug3uE
   fWIcwOMqq0JgotUKX076QBM/BYHPI6VKWlP4ftfzfHwUQKBI+etDu/Z22
   Y4LyVIAKxij2Y3XU92HBjWwdSU69TXApACKhEUja/eQwZ2680vrakNhE2
   37cvNxUZq4P/EzMmzyFmx6P7+Ga7obnGQfPRvWxm3aN4U0MlxeFXlYWGd
   Q==;
X-CSE-ConnectionGUID: RYln5EyBT4W6+raLLVQ5ag==
X-CSE-MsgGUID: TOzTZT5qQ/ikhtnPcW1QVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36648442"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36648442"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 18:34:08 -0800
X-CSE-ConnectionGUID: je1ExmAYTUO3Yg/EuqnfYg==
X-CSE-MsgGUID: hcXx/AzFSJKOlE9egyux9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107645437"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 18:33:53 -0800
Message-ID: <2ab7fb0e-0351-4b2d-861a-da6f72138778@linux.intel.com>
Date: Fri, 10 Jan 2025 10:31:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "will@kernel.org" <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <BN9PR11MB527699DB033F2B192DC120EE8C132@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250109144315.GY5556@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250109144315.GY5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/9/25 22:43, Jason Gunthorpe wrote:
> On Thu, Jan 09, 2025 at 07:20:01AM +0000, Tian, Kevin wrote:
>>> From: Tian, Kevin
>>> Sent: Thursday, January 9, 2025 3:08 PM
>>>
>>>> From: Liu, Yi L<yi.l.liu@intel.com>
>>>> Sent: Thursday, December 19, 2024 9:28 PM
>>>>
>>>> +/**
>>>> + * iommu_replace_device_pasid - Replace the domain that a pasid is
>>>> attached to
>>>> + * @domain: the new iommu domain
>>>> + * @dev: the attached device.
>>>> + * @pasid: the pasid of the device.
>>>> + * @handle: the attach handle.
>>>> + *
>>>> + * This API allows the pasid to switch domains. Return 0 on success, or an
>>>> + * error. The pasid will keep the old configuration if replacement failed.
>>>> + * This is supposed to be used by iommufd, and iommufd can guarantee
>>>> that
>>>> + * both iommu_attach_device_pasid() and iommu_replace_device_pasid()
>>>> would
>>>> + * pass in a valid @handle.
>>>> + */
>>> Better explain why a valid handle is required here.
>> Okay, it's because __iommu_set_group_pasid() requires the old domain now
>> and the only way to retrieve it at this point is via a handle. It's probably also
>> ok to directly store a domain pointer to the xarray when the handle is missing
>> but that sounds more confusing.
> I had shared a xarray approach to do that at one point, it apparently
> was scary enough nobody picked it up 🙂
> 
> https://lore.kernel.org/linux-iommu/20240322165927.GG66976@ziepe.ca/

I evaluated it at that time and ultimately decided not using it. At that
time, there was no requirement for pasid replacement, so the 'old
domain' was not yet an issue. This is why I chose to allocate on demand
at that stage. :-)

---
baolu
