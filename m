Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881A214A9B
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689449; cv=none; b=Qvh/F/Sllgg7GUVddAYBAd7xSAKj+u2zykZySPcPoT2aw3Xy8FODjd7lDq97i9koIm7MK/NOkSrI5SkLoSGR2QxC8+GWzSxnvDUuho8ubPMIcjVmmzGWLcjSv53/BrUsf/xGU/x12CVSfd7qXX9G763LqZzhtQCio2cmwH012t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689449; c=relaxed/simple;
	bh=8Rz6KdkD6wWCWFdhdHww6PoXidXXVNEfj0zdlLd5JcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXVvDnNIy4fKJ6zBp600GmYIdKSrUf1HdR2AXp49roIHGwtrASuLdub75+SXAx2Db3vSftNxGuF2ZnBC97ap8ury1txO+CQyFqFLiR9gzEDjMCpqY7PfiiQX8L4yLBNDoYLgwduuQqsERR/ocubKJJ5osKtRCM71ibxxs0bHhsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOJa/VBQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOJa/VBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763689446; x=1795225446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Rz6KdkD6wWCWFdhdHww6PoXidXXVNEfj0zdlLd5JcU=;
  b=YOJa/VBQZrLsqBc2tqT8WZQgJuljVHJShArfRIXY849fJ2AXnGNjhVRX
   n9AQGTRiWQbkwtPrlIvF3gB2QfO3WFo69P6HA/k6ZgG1LPb0oWVI7yUBl
   Wc8rxRT6V5n1ovEFYNbaLydCFUdm7nd/p9Y+G0XWz3vFSe3pH+yuHkWIY
   RwKaSuSVLYkaTCYVHX/VkgL4smFR8b7R3YnIiy0aHN/6nByilaoOy9ECr
   bpzjq6NLST2oDZrn5U/VjitNuGiigPmVdFsqWH8zpNbh/o7LizBsjSj4K
   6Hsko3twh3o5p9jTsqcgECk1athBjZwQR9FgwiL21yGL4AnKL8c2ZsNzM
   w==;
X-CSE-ConnectionGUID: PlCj3Nr/T6SkgsdhGg3Tiw==
X-CSE-MsgGUID: bMvXSncFS0qqsN7qShKtjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="77245668"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="77245668"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 17:44:06 -0800
X-CSE-ConnectionGUID: DlsJg1rJTe2Zi4aFweVI5g==
X-CSE-MsgGUID: UmQwAcdNTuua2+y1+yXKfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="190833349"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 17:44:04 -0800
Message-ID: <e5376ae5-20f8-4e49-a912-7412361c66fd@linux.intel.com>
Date: Fri, 21 Nov 2025 09:39:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Restore previous domain::aperture_end
 calculation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251120072524.3218282-1-baolu.lu@linux.intel.com>
 <20251120130045.GB153257@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251120130045.GB153257@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 21:00, Jason Gunthorpe wrote:
> On Thu, Nov 20, 2025 at 03:25:24PM +0800, Lu Baolu wrote:
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2817,6 +2817,16 @@ intel_iommu_domain_alloc_first_stage(struct device *dev,
>>   		cfg.common.hw_max_vasz_lg2 = 57;
>>   	else
>>   		cfg.common.hw_max_vasz_lg2 = 48;
>> +
>> +	/*
>> +	 * Spec 3.6 First-Stage Translation:
>> +	 *
>> +	 * Software must limit addresses to less than the minimum of MGAW
>> +	 * and the lower canonical address width implied by FSPM (i.e.,
>> +	 * 47-bit when FSPM is 4-level and 56-bit when FSPM is 5-level).
>> +	 */
>> +	cfg.common.hw_max_vasz_lg2 = min(cap_mgaw(iommu->cap),
>> +					 cfg.common.hw_max_vasz_lg2);
>>   	cfg.common.hw_max_oasz_lg2 = 52;
>>   	cfg.common.features = BIT(PT_FEAT_SIGN_EXTEND) |
>>   			      BIT(PT_FEAT_FLUSH_RANGE);
> This is missing the hunk for paging_domain_compatible_first_stage(), I
> think that is important!

Yes. I want to make that a separate patch as that will be Cc'd to stable
and backported further than this one. We should have such a
compatibility check even without the generic iopt conversion, right?

Thanks,
baolu
