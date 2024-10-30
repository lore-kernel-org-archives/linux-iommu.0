Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC014F90
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277180; cv=none; b=tUUlJ5Ifa9DAHwqGgVX5JKGF11x5j2Iga3SO9T+mFMj5BVAlxLBjSqbyGeWHkJ/b5gpt61Fb5wPv0LMopd/WALWKqS6ztYKHNQyqrCjJevfFgi8O2VbuwXbl4NnNBhehwzRjkgaliF7JluU0cCHpRio3ndsKfZv3uHnq4+DA4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277180; c=relaxed/simple;
	bh=QQ+pxASCsT2NB2DayXgXGRpcgDcPcXAGaZi+vCJo4CI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YV+L9NPyFtR2OSWla31S19HQ0/g5YJy1pEhNVm/1HsDFwen7bRVAFYo8Bg0GfDioP0rnoJwHeKjwSqkKl04/Y6FvbULysjupVTEVwo6V7+7Wx6K20mbzyD9YaxtpBeq9BHAeGTBwMhRjiCXUh4NPRhMMLj85cz5HPys/VR75HRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQO58ozg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQO58ozg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730277177; x=1761813177;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QQ+pxASCsT2NB2DayXgXGRpcgDcPcXAGaZi+vCJo4CI=;
  b=bQO58ozggA+r+9rgf/Bfu9udXxlBiwUuebIJBXcyICVPPmk3sPn3jq4I
   DdJevs6LXaDxak9OFzX/JWIJVfOQGRCnwuUHpjnazMM41HP10Wb2m8yB3
   2Dh4yS746noYY0B7LY9eX9TOQJJtDmqLx6Hk7ucTYpVQ1Q3UW9PR6JKs2
   AmQQ/PXw1nKQI4inMyuGuVYyLvSgPsQSP+CGzcGzfxRYCnU6LVqtb63T8
   jLFUwUrjlJkcuIR9bMiZ4RCYQZAb5MYoiXSNZPbSxOkblA1XF3+xbk7mn
   DYQTRijZG74CNqRGgO6uDZfSIGiBr7r4BF6RRHQWxjcFunyMeYrNE1Nyn
   Q==;
X-CSE-ConnectionGUID: 992dOXoaRMmu0Sk5ArgtPA==
X-CSE-MsgGUID: Ys6VuAI3SjKwAiA5z+mxfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30112036"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30112036"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 01:32:56 -0700
X-CSE-ConnectionGUID: nlRvCMxRRa+F69QRCkTKfw==
X-CSE-MsgGUID: 6GXUWZ5XQbedtVmBquCWYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82406864"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 01:32:49 -0700
Message-ID: <36ce098c-4862-4490-a3ed-3226c08aa6d1@linux.intel.com>
Date: Wed, 30 Oct 2024 16:32:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
To: Yi Liu <yi.l.liu@intel.com>, Joel Granados <joel.granados@kernel.org>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
 <ujexsgcpvcjux2ugfes6mzjxl53j3icarfbu25imhzliqskyv6@l7f42nv4fhmy>
 <bbd95589-f4c9-4dcf-939b-c3c407eeed21@linux.intel.com>
 <91d59b7d-58b0-4da2-af59-18a980273bb4@intel.com>
 <acd5c4a6-040c-48ff-9e6b-1a33e5ff118d@linux.intel.com>
 <ccd8352c-16e7-4845-a94e-b22bdb3ec5c7@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ccd8352c-16e7-4845-a94e-b22bdb3ec5c7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/30 13:51, Yi Liu wrote:
> On 2024/10/29 13:39, Baolu Lu wrote:
>> On 2024/10/29 13:13, Yi Liu wrote:
>>> On 2024/10/29 11:12, Baolu Lu wrote:
>>>> On 2024/10/28 18:24, Joel Granados wrote:
>>>>> On Mon, Oct 28, 2024 at 03:50:46PM +0800, Yi Liu wrote:
>>>>>> On 2024/10/16 05:08, Joel Granados wrote:
>>>>>>> From: Klaus Jensen<k.jensen@samsung.com>
>>>>>>>
>>>>>>> PASID is not strictly needed when handling a PRQ event; remove 
>>>>>>> the check
>>>>>>> for the pasid present bit in the request. This change was not 
>>>>>>> included
>>>>>>> in the creation of prq.c to emphasize the change in capability 
>>>>>>> checks
>>>>>>> when handing PRQ events.
>>>>>>>
>>>>>>> Signed-off-by: Klaus Jensen<k.jensen@samsung.com>
>>>>>>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>>>>>>> Signed-off-by: Joel Granados<joel.granados@kernel.org>
>>>>>> looks like the PRQ draining is missed for the PRI usage. When a pasid
>>>>>> entry is destroyed, it might need to add helper similar to the
>>>>>> intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.
>>>>> These types of user space PRIs (non-pasid, non-svm) are created by
>>>>> making use of iommufd_hwpt_replace_device. Which adds an entry to the
>>>>> pasid_array indexed on IOMMU_NO_PASID (0U) via the following path:
>>>>>
>>>>> iommufd_hwpt_replace_device
>>>>>    -> iommufd_fault_domain_repalce_dev
>>>>>      -> __fault_domain_replace_dev
>>>>>        -> iommu_replace_group_handle
>>>>             -> __iommu_group_set_domain
>>>>               -> intel_iommu_attach_device
>>>>                  -> device_block_translation
>>>>                    -> intel_pasid_tear_down_entry(IOMMU_NO_PASID)
>>>>
>>>> Here a domain is removed from the pasid entry, hence we need to flush
>>>> all page requests that are pending in the IOMMU page request queue or
>>>> the PCI fabric.
>>>>
>>>>>          -> xa_reserve(&group->pasid_array, IOMMU_NO_PASID, 
>>>>> GFP_KERNEL);
>>>>>
>>>>> It is my understanding that this will provide the needed relation
>>>>> between the device and the prq in such a way that when  
>>>>> remove_dev_pasid
>>>>> is called, intel_iommu_drain_pasid_prq will be called with the
>>>>> appropriate pasid value set to IOMMU_NO_PASID. Please correct me if 
>>>>> I'm
>>>>> mistaken.
>>>>
>>>> Removing a domain from a RID and a PASID are different paths.
>>>> Previously, this IOMMU driver only supported page requests on PASID
>>>> (non-IOMMU_NO_PASID). It is acceptable that it does not flush the 
>>>> PRQ in
>>>> the domain-removing RID path.
>>>>
>>>> With the changes made in this series, the driver now supports page
>>>> requests for RID. It should also flush the PRQ when removing a domain
>>>> from a PASID entry for IOMMU_NO_PASID.
>>>>
>>>>>
>>>>> Does this answer your question? Do you have a specific path that 
>>>>> you are
>>>>> looking at where a specific non-pasid drain is needed?
>>>>
>>>> Perhaps we can simply add below change.
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index e860bc9439a2..a24a42649621 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -4283,7 +4283,6 @@ static void 
>>>> intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>>>>          intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>>>          kfree(dev_pasid);
>>>>          intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>>>> -       intel_drain_pasid_prq(dev, pasid);
>>>>   }
>>>>
>>>>   static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>>> index 2e5fa0a23299..8639f3eb4264 100644
>>>> --- a/drivers/iommu/intel/pasid.c
>>>> +++ b/drivers/iommu/intel/pasid.c
>>>> @@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct 
>>>> intel_iommu *iommu, struct device *dev,
>>>>                  iommu->flush.flush_iotlb(iommu, did, 0, 0, 
>>>> DMA_TLB_DSI_FLUSH);
>>>>
>>>>          devtlb_invalidation_with_pasid(iommu, dev, pasid);
>>>> +       intel_drain_pasid_prq(dev, pasid);
>>>>   }
>>>>
>>>>   /*
>>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>>> index 078d1e32a24e..ff88f31053d1 100644
>>>> --- a/drivers/iommu/intel/svm.c
>>>> +++ b/drivers/iommu/intel/svm.c
>>>> @@ -304,9 +304,6 @@ void intel_drain_pasid_prq(struct device *dev, 
>>>> u32 pasid)
>>>>          int qdep;
>>>>
>>>>          info = dev_iommu_priv_get(dev);
>>>> -       if (WARN_ON(!info || !dev_is_pci(dev)))
>>>> -               return;
>>>> -
>>>>          if (!info->pri_enabled)
>>>>                  return;
>>>>
>>>> Generally, intel_drain_pasid_prq() should be called if
>>>>
>>>> - a translation is removed from a pasid entry; and
>>>> - PRI on this device is enabled.
>>>
>>> If the @pasid==IOMMU_NO_PASID, PRQ drain should use the iotlb 
>>> invalidation
>>> and dev-tlb invalidation descriptors. So extra code change is needed in
>>> intel_drain_pasid_prq(). Or perhaps it's better to have a separate 
>>> helper
>>> for draining prq for non-pasid case.
>>
>> According to VT-d spec, section 7.10, "Software Steps to Drain Page
>> Requests & Responses", we can simply replace p_iotlb_inv_dsc and
>> p_dev_tlb_inv_dsc with iotlb_inv_dsc and dev_tlb_inv_dsc. Any
>> significant negative performance impact?
> 
> It's not about performance impact. My point is to use iotlb_inv_dsc and
> dev_tlb_inv_dsc for the @pasid==IOMMU_NO_PASID case. The existing
> intel_drain_pasid_prq() only uses p_iotlb_inv_dsc and p_dev_tlb_inv_dsc.
> The way you described in above reply works. But it needs to add if/else
> to use the correct invalidation descriptor. Since the descriptor
> composition has several lines, so just an ask if it's better to have a
> separate helper. :)

The spec says (7.10 Software Steps to Drain Page Requests & Responses):

"
Submit an IOTLB invalidate descriptor (iotlb_inv_dsc or p_iotlb_inv_dsc)
followed by DeviceTLB invalidation descriptor (dev_tlb_inv_dsc or
p_dev_tlb_inv_dsc) targeting the endpoint device. These invalidation
requests can be of any granularity. Per the ordering requirements
described in Section 7.8, older page group responses issued by software
to the endpoint device before step (a) are guaranteed to be received by
the endpoint before the endpoint receives this Device-TLB invalidation
request.
"

The purpose of the cache invalidation requests sent to the device is to
leverage PCI ordering requirements to ensure that all page group
responses are received by the device before it processes the TLB
invalidation request. Therefore, the specification doesn't mandate the
type and granularity of invalidation requests, as long as they are
valid.

Given that the Page Request Interface (PRI) is only supported when the
IOMMU operates in scalable mode, I don't believe we need to make any
changes to the invalidation types at this time.

--
baolu
