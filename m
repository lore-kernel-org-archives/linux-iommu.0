Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A01CF83
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724119785; cv=none; b=XQCKlleLhE3E61zyRnsIsB6fdQ8aQ+WTmK6IdiT90ZcSm7egS/jv7uYmvvbNyZtgQMJJK+L3HC02yLpuNCaIDu3Dc3YSV0/UkTO/5Qfg/nNH1MWcV6Sjy8OOrKeWI10a4GSnDwP7yUBycKCL1LZVqBxhoiZEUKGwQ2fu0e+QToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724119785; c=relaxed/simple;
	bh=A0VDvdd/F4J3i4n62dLsMitufA5R1HMZW2f2x0OMSqs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LNS9AeyGroOvK2n2bAHBYvg2pl89tsYH08CZAFc9PISa4QQTLqSvmhG58kWa6E63BCeoTVCHxjZSXMNUuMwgXeFxnWE78IhpCXxlsVfLkukDHTfTahPQW4uDlxdMDfl0fledzOKYSTMHBx206wIUVQgn/CozIl57vuAPlZtkm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPqHVok1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPqHVok1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724119784; x=1755655784;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A0VDvdd/F4J3i4n62dLsMitufA5R1HMZW2f2x0OMSqs=;
  b=gPqHVok1RmcHidgNAZL6RfYNXhEJmvoCoDD1RGPuVM6YbAX4Oz8FpbPJ
   EWC0RrbB7MXFgVF7B7ddDyReiC4xnwSjh2EG1CsC1gsw/4N9iOvImaBm9
   xpB3tlSLYYRr/JPt+ke8WxrWvLF6748sIIhIDO52FaxDKNn7Sv+yNqPc0
   Lrp5QGUzUDm1+AAAfnPMgHzhdgd0gBv3wH7pfH62PktA8ngWiWuFOqsbz
   ZOvVdSzvGkXXRIpBfi+PcXSg1ZAyvKg7B0jnwizb3nTWT/p9Gwrtvrdwl
   yGXT+7A6YiVTBIjcUmcYvU162ynLU35sNksnkm5yosYGOkJfpW01lQqEu
   w==;
X-CSE-ConnectionGUID: qlIFkJ5yRIajcV7WeBOl7Q==
X-CSE-MsgGUID: AgRGQ9ebSOW/wNtlb3mpSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22534701"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22534701"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 19:09:43 -0700
X-CSE-ConnectionGUID: wz0b53h9RO+/HAwLaK5Wrg==
X-CSE-MsgGUID: lYDHs4euTimJ5HRIApDkDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="98027961"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2024 19:09:42 -0700
Message-ID: <8da6a9b6-01f4-4c4f-9619-148fdb3828d0@linux.intel.com>
Date: Tue, 20 Aug 2024 10:06:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Tina Zhang <tina.zhang@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iommu/vt-d: Introduce batched cache invalidation
To: Jacob Pan <jacob.pan@linux.microsoft.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
 <20240815065221.50328-5-tina.zhang@intel.com>
 <20240816093846.40dbd623@DESKTOP-0403QTC.>
 <afec1d30-4bb3-4d39-9ff1-eb8ecb26bed3@linux.intel.com>
 <20240819084056.298a9924@DESKTOP-0403QTC.>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240819084056.298a9924@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 11:40 PM, Jacob Pan wrote:
> On Sat, 17 Aug 2024 11:28:21 +0800
> Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> 
>> On 2024/8/17 0:38, Jacob Pan wrote:
>>> On Thu, 15 Aug 2024 14:52:21 +0800
>>> Tina Zhang<tina.zhang@intel.com>  wrote:
>>>    
>>>> @@ -270,7 +343,8 @@ static void cache_tag_flush_iotlb(struct
>>>> dmar_domain *domain, struct cache_tag * u64 type =
>>>> DMA_TLB_PSI_FLUSH;
>>>>    	if (domain->use_first_level) {
>>>> -		qi_flush_piotlb(iommu, tag->domain_id, tag->pasid,
>>>> addr, pages, ih);
>>>> +		qi_batch_add_piotlb(iommu, tag->domain_id,
>>>> tag->pasid, addr,
>>>> +				    pages, ih, domain->qi_batch);
>>>>    		return;
>>>>    	}
>>>>    
>>>> @@ -287,7 +361,8 @@ static void cache_tag_flush_iotlb(struct
>>>> dmar_domain *domain, struct cache_tag * }
>>>>    
>>>>    	if (ecap_qis(iommu->ecap))
>>>> -		qi_flush_iotlb(iommu, tag->domain_id, addr | ih,
>>>> mask, type);
>>>> +		qi_batch_add_iotlb(iommu, tag->domain_id, addr |
>>>> ih, mask, type,
>>>> +				   domain->qi_batch);
>>>>      
>>> If I understand this correctly, IOTLB flush maybe deferred until the
>>> batch array is full, right? If so, is there a security gap where
>>> callers think the mapping is gone after the call returns?
>> No. All related caches are flushed before function return. A domain
>> can have multiple cache tags. Previously, we sent individual cache
>> invalidation requests to hardware. This change combines all necessary
>> invalidation requests into a single batch and raise them to hardware
>> together to make it more efficient.
> I was looking at the code below, if the index does not reach
> QI_MAX_BATCHED_DESC_COUNT. There will be no flush after
> cache_tag_flush_iotlb() returns, right?

No. qi_batch_flush_descs() is called explicitly before return.

@@ -341,6 +417,7 @@ static void cache_tag_flush_devtlb_all(struct 
dmar_domain *domain, struct cache_
  void cache_tag_flush_range(struct dmar_domain *domain, unsigned long 
start,
                            unsigned long end, int ih)
  {
+       struct intel_iommu *iommu = NULL;
         unsigned long pages, mask, addr;
         struct cache_tag *tag;
         unsigned long flags;
@@ -349,6 +426,10 @@ void cache_tag_flush_range(struct dmar_domain 
*domain, unsigned long start,

         spin_lock_irqsave(&domain->cache_lock, flags);
         list_for_each_entry(tag, &domain->cache_tags, node) {
+               if (iommu && iommu != tag->iommu)
+                       qi_batch_flush_descs(iommu, domain->qi_batch);
+               iommu = tag->iommu;
+
                 switch (tag->type) {
                 case CACHE_TAG_IOTLB:
                 case CACHE_TAG_NESTING_IOTLB:
@@ -372,6 +453,7 @@ void cache_tag_flush_range(struct dmar_domain 
*domain, unsigned long start,

                 trace_cache_tag_flush_range(tag, start, end, addr, 
pages, mask);
         }
+       qi_batch_flush_descs(iommu, domain->qi_batch);
         spin_unlock_irqrestore(&domain->cache_lock, flags);
  }

Thanks,
baolu
