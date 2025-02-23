Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84B1E50B
	for <iommu@lists.linux.dev>; Sun, 23 Feb 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740317571; cv=none; b=UsgUrmO2p5RZt5AsfQ0/BMHX1hJhOUYaPsefZnTLQSTcTo0L2kxJ/uZHUEPM8td2Vmqc3N3o+9gSKARb9lq76jH1DeqfYIZJp7xfVUTq51Zyz+YuV1Qgt+gWkXU/fKZa0a0QtKS13vYDYcumtjekf4lc8GWUFnSULbSlnrEkvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740317571; c=relaxed/simple;
	bh=lmFqVktFc+NlKk1AwvxHfSDqtIYqXpiV8GVEb7YvipE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cjNTc/AHxwTs6yUkU0sCvevmwyLBRAhr6171bGhJRRjYCHohnwFQ5TfQ3Dmb6uC3DSub469AGMOt9em+a3V5tpMOVdLPJocOML22dQUgjSwbm44EOYXCfd3zHTSNmQuMmlnU/C407HW2Yxo9pamWt/Z/vORJ/ON7V0s8/YTywsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+r9V0VV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+r9V0VV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740317570; x=1771853570;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lmFqVktFc+NlKk1AwvxHfSDqtIYqXpiV8GVEb7YvipE=;
  b=D+r9V0VVx41xI6aLNDtWMmHtkgtV/J25AdosXUTKFLGHAd1g7pvMx4gJ
   FHGARG/VtcNXK3CVlUwosX1eg2Bcq+w3r9fBVQZEtwMLvrSTb+cqu7mrN
   RRKp46Fp9rSgJKyVtR5a54g1+7vpvJgt66qP9UbT80uhARz0aPkGN0O+9
   eIV2uhRSEVtc30EeOU9zs/SBglNFN5paJ34J3oqj42a8q8uQPKKAMXLwk
   DWhuqdZooUS+HjkkUZyViBHWFN4y72+GFymFw0pd0ge3J8DXRp/QLCcSm
   bCZWUGDtFcet3DVQleXxpFeVkvihj/zVOlT0Tv73Pfwf6H+hcCI8CgQrp
   w==;
X-CSE-ConnectionGUID: a7phD24cTde2k2S9ZtUidg==
X-CSE-MsgGUID: qVsRTI3TQS+zPFkB3mEz6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40272012"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40272012"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:32:49 -0800
X-CSE-ConnectionGUID: KqZQfqrMQb6UUiGJRkUptg==
X-CSE-MsgGUID: SjdCS+GoTVmPkB0c1QNehg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120445313"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.93]) ([10.124.240.93])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:32:47 -0800
Message-ID: <9ad4766e-e37b-4310-acec-dc8eb91dde64@linux.intel.com>
Date: Sun, 23 Feb 2025 21:32:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com, iommu@lists.linux.dev, robin.murphy@arm.com,
 will@kernel.org
Subject: Re: [PATCH v2 4/4] iommu: Swap the order of setting
 group->pasid_array and calling attach op of iommu drivers
To: Yi Liu <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-5-yi.l.liu@intel.com> <Z7i3dvyA/opurciP@Asurada-Nvidia>
 <ceb475fa-dfdf-4bcb-a4ba-8128ba86a39a@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ceb475fa-dfdf-4bcb-a4ba-8128ba86a39a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/2/22 9:59, Yi Liu wrote:
> On 2025/2/22 01:27, Nicolin Chen wrote:
>> On Fri, Feb 21, 2025 at 06:33:35AM -0800, Yi Liu wrote:
>>> The current implementation stores entry to the group->pasid_array before
>>> the underlying iommu driver has successfully set the new domain. This 
>>> can
>>> lead to issues where PRIs are received on the new domain before the 
>>> attach
>>> operation is completed.
>>>
>>> This patch swaps the order of operations to ensure that the domain is 
>>> set
>>> in the underlying iommu driver before updating the group->pasid_array.
>>>
>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>
>> A nit:
>>
>>> ---
>>>   drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++------------
>>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index eff5f678883b..73555e1cf016 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -3388,13 +3388,25 @@ int iommu_attach_device_pasid(struct 
>>> iommu_domain *domain,
>>>       entry = iommu_make_pasid_array_entry(domain, handle);
>>> -    ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
>>> +    ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, 
>>> GFP_KERNEL);
>>
>> Maybe xa_reserve() pairing xa_release()? Same thing though..
> 
> there is slight difference. xa_reserve() will return 0 if there is already
> a valid entry. xa_insert() shall fail with EBUSY. We want to catch such
> failures here. You may notice that the replace function uses xa_reserve()
> as it intend to replace existing entry.

Do you mind adding some comments around the code explaining why
xa_insert() is used instead of xa_reserve() here? This will make the
code easier to understand without needing to refer to this discussion.

Thanks,
baolu
