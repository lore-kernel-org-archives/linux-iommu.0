Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B321C8FBA
	for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569173; cv=none; b=NxaAsGGDqDRQQWiR1ZIs+Vs0hC2mz2lzt5sKSZdhMD7EE3hT/MbP3MUADrciRGAmOTZ0fR1ZPeGUnrxq7BJDiEWSCXME7NLYsEzkQ3u6g+dUFR9DPTwph99RVB4A1DyVKf0dJE8qPvK9trx4VzKy+FN87O8nJOfUtqKMvVX8Z58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569173; c=relaxed/simple;
	bh=JkHJp34IYIvqsSnI1yqdi0T331jiFtzzKSsoryx4qCM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LBG/PctEe4X9mbHMzWNf2W287WgiIb6euquJxm0sWa8mSSAUG5Ipz80ZGzoehLmHZpaYhWPmOAkvxk98yo6r2oGpc0oMHTqAYmxGojRconzfUSlU8xLx+tCbaaw7k3WLblD84o5kwwA6yxbQGIK8pWCBpqMbowchY7CiYJEnwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vl2awmnp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vl2awmnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728569172; x=1760105172;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JkHJp34IYIvqsSnI1yqdi0T331jiFtzzKSsoryx4qCM=;
  b=Vl2awmnpyy0FKT698iJr7HmVnq1DL+K3XQ/o6BrtSdTz6GA4sVfXd89m
   bqtm8d2iS0DonEnPfFCfPsJotjeMRhShSCHLSvZ+3FOARuHe1Tfwv9eMr
   bNuqIsLMgsr6ZvCgw9Cj0Uv5ena1ne+cibGHtdJ/77DAo89mZM/8N+EmM
   oKwUehVRu6jwvV0Wyt5WWpLHlMcO9UF9CGiVJ6boNBtEfR+eDoeYvnjfw
   wehhIPY0jKx87bURcvCfwWTFPZs2IPfZAmJWsD7NNJwMha2WlGZr0vCyy
   phQmi9e1wFNuguPsC7TvnbhAP29+hfm3m4I2jiAP3/sqd3gZQaIBmi9Ig
   Q==;
X-CSE-ConnectionGUID: NYUb1jGXRsC4ykB+j+qE7g==
X-CSE-MsgGUID: +n4kGkYaSGCzyXLCPScJKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28042998"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28042998"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:06:11 -0700
X-CSE-ConnectionGUID: h6NxArEFSPSXXj0E5P+r5A==
X-CSE-MsgGUID: hVJo1ZzBQqCWM/bH3EZSMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76262850"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:06:08 -0700
Message-ID: <3e83bc8a-c827-413d-b652-893a154d6dc9@linux.intel.com>
Date: Thu, 10 Oct 2024 22:06:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Vasant Hegde <vasant.hegde@amd.com>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
 <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
 <9d0101b4-af13-4bf6-94a5-43a79f4d9989@amd.com>
 <20241009121548.GE762027@ziepe.ca>
 <f8cf4532-3bfe-4b0a-9399-0760ab6a4612@linux.intel.com>
 <2ba53bb0-b84a-4eae-91da-4ff7d13b582b@linux.intel.com>
 <20241010113817.GG762027@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241010113817.GG762027@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/10 19:38, Jason Gunthorpe wrote:
> On Thu, Oct 10, 2024 at 02:48:09PM +0800, Baolu Lu wrote:
>> On 2024/10/10 14:40, Baolu Lu wrote:
>>> On 2024/10/9 20:15, Jason Gunthorpe wrote:
>>>> On Wed, Oct 09, 2024 at 03:23:16PM +0530, Vasant Hegde wrote:
>>>>
>>>>>> This change might cause a functional regression when it comes to nested
>>>>>> translation. In nested translation mode, the user page table (e.g.,
>>>>>> created and managed by a guest VM for guest kernel DMA) must be in the
>>>>>> first-stage page table format. Then, it can be nested on a second-stage
>>>>>> page table managed by the host kernel.
>>>>>>
>>>>>> Currently, the kernel automatically selects the page table formats. For
>>>>>> example, the Intel IOMMU driver always uses the first-stage page table
>>>>>> for guest kernel DMA. After this change, this assumption no
>>>>>> longer holds
>>>>>> true. This means the kernel might use a second-stage page table for
>>>>>> guest kernel DMA, breaking nested translation.
>>>>> Hmmm. I assumed after discussion in v1 series you are fine.
>>>>> Looks like I misread it?
>>>> It is a bug in the implementation in the intel driver.
>>>>
>>>> intel_iommu_domain_alloc_user() should always allocate a page table
>>>> that works, if you are in a guest context it must allocate a first
>>>> level/guest page table otherwise nested VFIO will be broken.
>>>>
>>>> For this reason Intel driver should always allocate the guest
>>>> compatible page table unless IOMMU_HWPT_ALLOC_NEST_PARENT is
>>>> specified.
>>>>
>>>> Something like this:
>>> This will break the existing dirty page tracking functionality. Intel
>>> IOMMU only supports enabling or disabling dirty page tracking at the
>>> second-stage page table.
>> So, perhaps something like below?
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 1497f3112b12..e11dde259afa 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -544,6 +544,8 @@ enum {
>>                                  ecap_slads((iommu)->ecap))
>>   #define nested_supported(iommu)        (sm_supported(iommu) &&         \
>>                                   ecap_nest((iommu)->ecap))
>> +#define flts_supported(iommu)  (sm_supported(iommu) &&                 \
>> +                                ecap_flts((iommu)->ecap))
>>
>>   struct pasid_entry;
>>   struct pasid_state_entry;
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 9f6b0780f2ef..d1a7378489a4 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3530,6 +3530,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32
>> flags,
>>          struct intel_iommu *iommu = info->iommu;
>>          struct dmar_domain *dmar_domain;
>>          struct iommu_domain *domain;
>> +       bool first_stage;
>>
>>          /* Must be NESTING domain */
>>          if (parent) {
>> @@ -3546,8 +3547,14 @@ intel_iommu_domain_alloc_user(struct device *dev, u32
>> flags,
>>          if (user_data || (dirty_tracking && !ssads_supported(iommu)))
>>                  return ERR_PTR(-EOPNOTSUPP);
>>
>> -       /* Do not use first stage for user domain translation. */
>> -       dmar_domain = paging_domain_alloc(dev, false);
>> +       /*
>> +        * Always allocate the guest compatible page table unless
>> +        * IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>> +        * is specified.
>> +        */
>> +       first_stage = (nested_parent || dirty_tracking) ?
>> +                       false : flts_supported(iommu);
> That makes sense, but these flags still need to be rejected if the
> second level is not supported in the HW.
> 
> +	if ((flags & (IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)) && !intel_cap_slts_sanity())
> +		return ERR_PTR(-EOPNOTSUPP);
> 
> I also think my version was cleaner as we should be using
> first_level_by_default() consistently to make that decision.
> 
> Also don't care for ternary expressions 🙂

Okay, seems that we are on the same page now. :-)

I have a series to add domain_alloc_paging support in the Intel iommu
driver. I will convert the change in a formal patch and put it in that
series for further review.

Thanks,
baolu
