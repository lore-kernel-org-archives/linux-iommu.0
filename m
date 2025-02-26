Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDDD253F05
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 03:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542238; cv=none; b=FqIXjb2jgG+GmRDh+IqAS3lJTYV2TKjhg9VF6pjTHojw7aljB1h9qMOjEsBp5K2cB4o27wcvU5q1D40jlcKKM9CRR5rAaMjab5qBNjtpw4HgySUEx5IryWoGXCJkwex9WYlohLxU54Z1R9rG9pML2ZxNdNlX01STT62cJtj13So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542238; c=relaxed/simple;
	bh=KIekncOvePM5NKw6JbgRwP4wE48O3fWrIywopUrLN74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMreYX9BMhi1d0ondaTbcxYOJYqcp//h/fJ/ISCTOWX2GU9wkpS6jGyhmpjZIoRVy9ncmrsGpRszrfPzg3Wql6Szk5CHfoQDxlVyxFKcOpYu7Gy2x98/MAECBeYndFoKnYO1tZUTvWAhhsKRagExP6Lz6dW0OEJx+KL1fZSFemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYGydRjE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYGydRjE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740542237; x=1772078237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KIekncOvePM5NKw6JbgRwP4wE48O3fWrIywopUrLN74=;
  b=LYGydRjED14iZIKI1aMQ8aAoTee3iHUf2fCux0l1E9gDipOv80ZWueoE
   zkuzxkSMAGnZHQgWbsXEr/pi5z5UMCE3YSvkDrWJiDShQ4CXaHJj411Nz
   81fFUci2OAdVLqwucxzOIGcgZX5wpCesIE7IL2JGsk4kXGEA6CwCcfiUJ
   51TpPIn8yZ1duyywn8qNybPKf51DUp6cvF9VSi7LNcZJ8SqqbBJBZYkei
   Lsh0W/hbYMPu+SuK1hgOTcFAnbaTVMzTFU5HMFYCejbQHQ8Cr/cKlVC2B
   d6RfWqkA3HOAApCpYxrXVDWOD1vN1cOLqf+B5zCvS0gYpt2McorELnFvA
   w==;
X-CSE-ConnectionGUID: BEs0Tj+xRumZtcfBXL4Aug==
X-CSE-MsgGUID: oNh9jQ9iQ5GFdRhhcXvn8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52796094"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52796094"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 19:57:17 -0800
X-CSE-ConnectionGUID: PxpyvfMUSpioPxnV9dK6ZQ==
X-CSE-MsgGUID: YTThknudSJ618ybi9ndS3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121684445"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 19:57:14 -0800
Message-ID: <34f96069-2fe4-4578-85e2-8d506ef1df14@linux.intel.com>
Date: Wed, 26 Feb 2025 11:53:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] iommu/vt-d: Move PRI enablement in probe path
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-6-baolu.lu@linux.intel.com>
 <BN9PR11MB527693E12F3AE890697C00608CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527693E12F3AE890697C00608CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 15:37, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, February 24, 2025 1:16 PM
>>
>> @@ -3743,6 +3743,16 @@ static struct iommu_device
>> *intel_iommu_probe_device(struct device *dev)
>>   			else
>>   				info->ats_enabled = 1;
>>   		}
>> +
>> +		if (info->ats_enabled && info->pri_supported) {
>> +			/* PASID is required in PRG Response Message. */
>> +			if (info->pasid_enabled
>> || !pci_prg_resp_pasid_required(pdev)) {
> 
> this should be:
> 
> 	if (!info->pasid_enabled || pci_prg_resp_pasid_required(pdev))

Yes, fixed.

> 
> 
>> @@ -3761,6 +3771,13 @@ static void intel_iommu_release_device(struct
>> device *dev)
>>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>   	struct intel_iommu *iommu = info->iommu;
>>
>> +	WARN_ON(info->iopf_refcount);
> 
> call iopf_queue_remove_device() in this case?

Yes. I will make it like this,

         if (WARN_ON(info->iopf_refcount))
                 iopf_queue_remove_device(iommu->iopf_queue, dev);

>> +void intel_iommu_disable_iopf(struct device *dev)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct intel_iommu *iommu = info->iommu;
>> +
>> +	if (WARN_ON(!info->pri_enabled))
>> +		return;
> 
> also warn on !info->iopf_refcount

Yes, added.

Thanks,
baolu
