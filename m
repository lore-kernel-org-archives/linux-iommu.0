Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E66290F
	for <iommu@lists.linux.dev>; Fri, 31 May 2024 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117285; cv=none; b=X5E7WXGNc4c5YcyPUyNH9Ndw2WrGEchMeN+1DIIjKVkgzShTEgZK3VclHvkCh4D29vSKo3jOsshb0m7bYQKJbeRQP/2IE8iHoHy/iJSBmCtx0dHYc1ympoosBPGM7PT6y6HyW9bBnPmzVwumS4fTu4G+saVZ2HYMrAuDOwdVcws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117285; c=relaxed/simple;
	bh=Ok5WtKpA99niKOAeQZIUoy/NxG0jU4SaVokvbGP0n+4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G1O3yAiFWFd8oCZH2dBj/yJaGu6y3C85/afamy42dMfj6KQtlAjYHW1IvYUYxRojwFi/9uzynqcFpiH1mTYi+mUZpCmx+zzDU4VRWto24M07x6/8tNic31YonUTcoNbAkAJOD8C4Y5e+YZtnlo8ms0P0q89ZttFpr9RFiDN2Qvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbrIggOf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbrIggOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717117284; x=1748653284;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ok5WtKpA99niKOAeQZIUoy/NxG0jU4SaVokvbGP0n+4=;
  b=SbrIggOf5Fy0NTfZxzZy6BAHjdqom4h0Wi26dxqO6XYwhDuUJDZoFexZ
   HqXwunGH6HmycVECy07RQLIOJ0qCOcmZsjhtNFCk3Mm0/VzTtL97y+kSb
   d11RUwREoJDGw32pafk/xUxCvlvBRsHBmDxnVrZUturnMkcxbvjEfASLe
   7YEn/s1/BRJ/NI5FydJpRjf3shK55jnPC1nZyWB9aFLVvlRkcmFrSYLJy
   6ehbcMmTNZA/GRgSd0BTf+3nGI/NvAEjSfvzULa8GKOA3ovQKH/C/Sltj
   lr93MSiLkwzWKKoDDStU0LoqFJeCW60DjDJGqTxK2ttaf2CQk6IyALOSl
   Q==;
X-CSE-ConnectionGUID: xatnva3oQ3CtPGzOYtvEAw==
X-CSE-MsgGUID: 2gGW4aFGQuekInPpjk8bzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24207079"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24207079"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:01:23 -0700
X-CSE-ConnectionGUID: ek2BmyUbTJy0FItK1wPepw==
X-CSE-MsgGUID: 9pojCTkBREqGRr18kKBuyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36103816"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 30 May 2024 18:01:20 -0700
Message-ID: <cb8f4a3f-75f4-436a-96dc-301b6d65a55c@linux.intel.com>
Date: Fri, 31 May 2024 08:59:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
To: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240528045458.81458-1-baolu.lu@linux.intel.com>
 <fdc3bffa-7149-48a4-949a-dd469c6c2726@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <fdc3bffa-7149-48a4-949a-dd469c6c2726@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 4:52 PM, Vasant Hegde wrote:
> On 5/28/2024 10:24 AM, Lu Baolu wrote:
>> iommu_sva_domain_alloc() is only called in iommu-sva.c, hence make it
>> static.
>>
>> On the other hand, iommu_sva_domain_alloc() should not return NULL anymore
>> after commit <80af5a452024> ("iommu: Add ops->domain_alloc_sva()"), the
>> removal of inline code avoids potential confusion.
>>
>> Fixes: 80af5a452024 ("iommu: Add ops->domain_alloc_sva()")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h     | 8 --------
>>   drivers/iommu/iommu-sva.c | 6 ++++--
>>   2 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 7bc8dff7cf6d..5cdd3d41b87b 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -1527,8 +1527,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>>   					struct mm_struct *mm);
>>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>> -struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>> -					    struct mm_struct *mm);
>>   #else
>>   static inline struct iommu_sva *
>>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>> @@ -1553,12 +1551,6 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
>>   }
>>   
>>   static inline void mm_pasid_drop(struct mm_struct *mm) {}
>> -
>> -static inline struct iommu_domain *
>> -iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
>> -{
>> -	return NULL;
>> -}
>>   #endif /* CONFIG_IOMMU_SVA */
>>   
>>   #ifdef CONFIG_IOMMU_IOPF
>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>> index 18a35e798b72..25e581299226 100644
>> --- a/drivers/iommu/iommu-sva.c
>> +++ b/drivers/iommu/iommu-sva.c
>> @@ -10,6 +10,8 @@
>>   #include "iommu-priv.h"
>>   
>>   static DEFINE_MUTEX(iommu_sva_lock);
>> +static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>> +						   struct mm_struct *mm);
> If we move move iommu_sva_domain_alloc() before iommu_sva_bind_device() then we
> can avoid this forward declaration.

Yeah, but that means moving 144 lines of code. That's why I went with
this approach

Best regards,
baolu
