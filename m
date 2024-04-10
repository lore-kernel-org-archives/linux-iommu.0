Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42A10A03
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727683; cv=none; b=PUAlma2yEwqwmBM2BkTVg23CTQ/xLX/ompI/c8yPVJcFXmcWqcd3EHBhA1A4bxT4VnaY6/zRvThJThrUfuu/9xFpRgmM0Ge8c03HNVXvOxa+UHZhwW+t8obiQ1X4V4hXWc2gJwTbjKeSwyRJmEuIkR7Rd1wuR+qhe9kr9681R0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727683; c=relaxed/simple;
	bh=Ee1cNhLXadhjiT2wd8OVcDLddzxAfRUeUwIPB4amfDU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FjU7DNlKfZpgTwpUu+alLagI1p0VSFR0wGF3ifvU81wbSMlqt38CT769yr4lJ6Mug+4wEhnZV/VbBryblQVYKaUXK9yyoJn4Z3glLG/aNiVaSqMIf79nelunLDqv+eJliYbkJkS4SpjNCi7pmlsxJo8qxagqcc84CzUBgVP0znU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyjJWGx+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyjJWGx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712727682; x=1744263682;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ee1cNhLXadhjiT2wd8OVcDLddzxAfRUeUwIPB4amfDU=;
  b=ZyjJWGx+WjJuGQEMIp9Aypytq9NQ0Tx5vTAIAvINBpwPIHt9SKTrJ9j7
   IsE9Qh9t6DdAZ5Xarf90A/3bvo+E1wuNelQ69nh4Wq6ir3Sq86SJ1P4wO
   Xhh6FDD23ZmGG1BtZrFwdGLQGmx9/oLUqB1yAdQRevzt5qeCRW70JjSGv
   ADRbW/fCGfoBzWgIab2oO3YWVVhg99wg3UNmRRvpVr4GFlwWWjYZHt+zz
   mGSA5HGIeHPvGhxB2mgxWov3pzuNLfQjL8RUpt0tT+hD00v7xODMlDEgK
   xYXDb/Sj/pbJaWh1yFM0c2uk6Y4F+jBnDn8Qwl8KgKsoL/C+0BFByi+zv
   g==;
X-CSE-ConnectionGUID: grPWNYsuQq+ntBE7PJt12w==
X-CSE-MsgGUID: N/oALJ1GRp25DJOvLQPerw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11845669"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11845669"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:41:21 -0700
X-CSE-ConnectionGUID: bvZ+Gip1TzOTCYQtJdO0jA==
X-CSE-MsgGUID: wX9sPajgSKyJInMLXsHbGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20513571"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 22:41:19 -0700
Message-ID: <ed515555-06e1-43e2-a2cc-63ad7bcb0cb1@linux.intel.com>
Date: Wed, 10 Apr 2024 13:40:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
 <20240407144232.190355-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52764F42C20B6B18DDE7E66B8C072@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764F42C20B6B18DDE7E66B8C072@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 3:30 PM, Tian, Kevin wrote:
>> Remove the caching mode check before device TLB invalidation to ensure
>> compatibility with the scalable mode use cases.
>>
>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
>> default")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 493b6a600394..681789b1258d 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct
>> intel_iommu *iommu,
>>   	else
>>   		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>>
>> -	if (!cap_caching_mode(iommu->cap) && !map)
>> +	if (!map)
>>   		iommu_flush_dev_iotlb(domain, addr, mask);
> as commented earlier better squash this in patch1.

Okay, let me squash them into a single patch and make the commit message 
more descriptive.

Best regards,
baolu
