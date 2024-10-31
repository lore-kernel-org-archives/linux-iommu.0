Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531BF881E
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368629; cv=none; b=ew4qLvfQtgnReEgca6+nn7niCA4r0yd2t0I+NJ6gY4TiD0LkjajdMrbindzc6JEj4tUjKyXt7dYqpHuZrZ5viGBVixwL1ombX+AOIAAZPA4vvLx2R4i11fzcK57tBOVdrsVq7JUhlTUrBOUngHx/B78PcnBFvMyTma9b7l57Sn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368629; c=relaxed/simple;
	bh=wrv865FUe9AO+6dZsgWIL2pl5G/GoNjNq14Vfd1V9cg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N/gLHv6Rc9VqKw1134IKjZ1yf80JOjVM+oSPbrZ9zWboA4KEGDIXRx/Hox15ce5JaMiaofvoGy7Jdry4O3/lo6QIPaNVTFBUTSlM+N+BXxl+V9c4lcAQvho7BXwyCI7MKiH6BCQX3w7gn4H+kfA46lVvYEyMoAIJuK8ucmsmZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9DpRVvR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9DpRVvR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730368627; x=1761904627;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wrv865FUe9AO+6dZsgWIL2pl5G/GoNjNq14Vfd1V9cg=;
  b=X9DpRVvRreDFH5FAzW2gfYcnPEptqSFY603SHmISG70KTHx8lO7J7MEE
   gT/rSikOhBEIrDzHRD+znfiA4CreE6z5bx2WWSoSUQyPCNlJMiP5bxYy/
   x18ZkgAiYjvNlPMTU1jb3S22LeL3wiXEGBaXXCY7gmdwQRxE/UBAl2RI6
   0o6kq9zqb1tblGKub2fP42zHo0GnIM15N+mQXAvonn+Ah0oTX9FKoTiV6
   +XvNKmELwFmfXcHjs+/tOILxPVoElkVWMmOi/2sxOXHLpt4e0XygUgrDk
   4YBiuhrAke2MdFhE+7oa9gmRQnJXe6Hl+4dPwE9EEidqQFUXL5fUpfC6i
   g==;
X-CSE-ConnectionGUID: TCkdMpBXR1aKYiME/LbvLA==
X-CSE-MsgGUID: l1ymIx/+ReGfwUCIK8Jo4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52653158"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52653158"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:57:07 -0700
X-CSE-ConnectionGUID: J3+j4Oh4SmmRdoIliHsGzg==
X-CSE-MsgGUID: TvlBuP0hQuK+6pwv/jr22w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113372936"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:57:04 -0700
Message-ID: <e5063ae2-ff84-4bfc-babc-b2a58073e263@linux.intel.com>
Date: Thu, 31 Oct 2024 17:57:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Klaus Jensen <its@irrelevant.dk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
To: Joel Granados <joel.granados@kernel.org>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
 <ujexsgcpvcjux2ugfes6mzjxl53j3icarfbu25imhzliqskyv6@l7f42nv4fhmy>
 <bbd95589-f4c9-4dcf-939b-c3c407eeed21@linux.intel.com>
 <pdslu36mhfxbzs254tlte2wavfkmecm53xhdtdelm4nfnemt3f@m5ed4hn6zmbl>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <pdslu36mhfxbzs254tlte2wavfkmecm53xhdtdelm4nfnemt3f@m5ed4hn6zmbl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/30 22:28, Joel Granados wrote:
> On Tue, Oct 29, 2024 at 11:12:49AM +0800, Baolu Lu wrote:
>> On 2024/10/28 18:24, Joel Granados wrote:
>>> On Mon, Oct 28, 2024 at 03:50:46PM +0800, Yi Liu wrote:
>>>> On 2024/10/16 05:08, Joel Granados wrote:
>>>>> From: Klaus Jensen<k.jensen@samsung.com>
>>>>>
>>>>> PASID is not strictly needed when handling a PRQ event; remove the check
>>>>> for the pasid present bit in the request. This change was not included
>>>>> in the creation of prq.c to emphasize the change in capability checks
>>>>> when handing PRQ events.
>>>>>
>>>>> Signed-off-by: Klaus Jensen<k.jensen@samsung.com>
>>>>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>>>>> Signed-off-by: Joel Granados<joel.granados@kernel.org>
>>>> looks like the PRQ draining is missed for the PRI usage. When a pasid
>>>> entry is destroyed, it might need to add helper similar to the
>>>> intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.
>>> These types of user space PRIs (non-pasid, non-svm) are created by
>>> making use of iommufd_hwpt_replace_device. Which adds an entry to the
>>> pasid_array indexed on IOMMU_NO_PASID (0U) via the following path:
>>>
>>> iommufd_hwpt_replace_device
>>>     -> iommufd_fault_domain_repalce_dev
>>>       -> __fault_domain_replace_dev
>>>         -> iommu_replace_group_handle
>>              -> __iommu_group_set_domain
>>                -> intel_iommu_attach_device
>>                   -> device_block_translation
>>                     -> intel_pasid_tear_down_entry(IOMMU_NO_PASID)
>>
>> Here a domain is removed from the pasid entry, hence we need to flush
>> all page requests that are pending in the IOMMU page request queue or
>> the PCI fabric.
> This make a lot of sense: To use iommufd_hwpt_replace_device to replace
> the existing hwpt with a iopf enabled one, the soon to be irrelevant
> page requests from the existing hwpt need to be flushed. And we were not
> doing that here.
> 
>>>           -> xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
>>>
>>> It is my understanding that this will provide the needed relation
>>> between the device and the prq in such a way that when  remove_dev_pasid
>>> is called, intel_iommu_drain_pasid_prq will be called with the
>>> appropriate pasid value set to IOMMU_NO_PASID. Please correct me if I'm
>>> mistaken.
>> Removing a domain from a RID and a PASID are different paths.
>> Previously, this IOMMU driver only supported page requests on PASID
>> (non-IOMMU_NO_PASID). It is acceptable that it does not flush the PRQ in
>> the domain-removing RID path.
>>
>> With the changes made in this series, the driver now supports page
>> requests for RID. It should also flush the PRQ when removing a domain
>> from a PASID entry for IOMMU_NO_PASID.
> Thank you for your explanation. Clarifies where I lacked understanding.
> 
>>> Does this answer your question? Do you have a specific path that you are
>>> looking at where a specific non-pasid drain is needed?
>> Perhaps we can simply add below change.
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index e860bc9439a2..a24a42649621 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4283,7 +4283,6 @@ static void intel_iommu_remove_dev_pasid(struct
>> device *dev, ioasid_t pasid,
>>           intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>           kfree(dev_pasid);
>>           intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>> -       intel_drain_pasid_prq(dev, pasid);
>>    }
>>
>>    static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 2e5fa0a23299..8639f3eb4264 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu
>> *iommu, struct device *dev,
>>                   iommu->flush.flush_iotlb(iommu, did, 0, 0,
>> DMA_TLB_DSI_FLUSH);
>>
>>           devtlb_invalidation_with_pasid(iommu, dev, pasid);
>> +       intel_drain_pasid_prq(dev, pasid);
>>    }
> This make sense logically as the intel_drain_pasid_prq keeps being
> called at the end of intel_iommu_remove_dev_pasid, but it is now also
> included in the intel_pasid_tear_down_entry call which adds it to the
> case discussed.
> 
>>    /*
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index 078d1e32a24e..ff88f31053d1 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -304,9 +304,6 @@ void intel_drain_pasid_prq(struct device *dev, u32
>> pasid)
>>           int qdep;
>>
>>           info = dev_iommu_priv_get(dev);
>> -       if (WARN_ON(!info || !dev_is_pci(dev)))
>> -               return;
> Did you mean to take out both checks?:
>    1. The info pointer check
>    2. the dev_is_pci check
> 
> I can understand the dev_is_pci check, but we should definitely take
> action if info is NULL. Right?
> 
>> -
>>           if (!info->pri_enabled)
>>                   return;
>>
>> Generally, intel_drain_pasid_prq() should be called if
>>
>> - a translation is removed from a pasid entry; and
> This is the path that is already mentiond
> 
>> - PRI on this device is enabled.
> And this path is:
>    -> intel_iommu_enable_iopf
>      -> context_flip_pri
>        -> intel_context_flush_present
>          -> qi_flush_pasid_cache
> 
> Right?
> 
> I'll put this in my next version if I see that there is a consensus in
> the current discussion.

I post a patch to address what we are discussing here, so that you don't
need to send a new version.

https://lore.kernel.org/linux-iommu/20241031095139.44220-1-baolu.lu@linux.intel.com/

--
baolu
