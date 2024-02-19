Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E42208A8
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325932; cv=none; b=R64+EMuUywrTEWpyRKjqoNwOUbG4LbY1e54lcDEuMqNdgVTFcYh7Sh3Tf1Y2yU9IPfUQWiAmDuE4I3cAHmBvZhsARyVTAIuNhIbwuSvB/zvb8HGXh9hlwytAjd4PD6swAW5QYGLivBCopxL4Hxc35oNIooJZunwZUjbE4gserCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325932; c=relaxed/simple;
	bh=Pb1aZOld1EmcUHzmbXWEjtyFmhh3gojEOq9lhsXaZFQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WpMPBlmIRhceLzEhO6+NjodjaiZ+V9iiXdMd/TyJ6HzfTX70+xt87eaBMloPMSFDEohXYeys2LNWqSTw59kXHXkbS52yt8lslvY9y3pQ5jQG6UBl6LekxURShDCvmz9kM78NxnziBzDrypVUbfLV28GOXuSmjXBAHOKnFxfA95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fouEvq+8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fouEvq+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708325931; x=1739861931;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pb1aZOld1EmcUHzmbXWEjtyFmhh3gojEOq9lhsXaZFQ=;
  b=fouEvq+80VyD3u7kkocFMvmKzirDw5ajJpLwO1jP7ThAdtxxBKIUQqx6
   VDHJMWLFC/5j1Y4WtGG34qrvJw8mtv5R8KcOBqyfeNSC27B1AocG+roRg
   c5w6TR0PwjBMQptpF0HJgMIrKZ98KgWIhFLrLiSY0TuT0JPrvvcvBlaBL
   bPiVHJcjMgpvHUU1eDzdtMc4Qzz7tCM79hrL9Ve6duuY71dp/jVdnIzxJ
   EGcW1hV2TSvcXGZpT7Q5QEB+fXHc9sy0KMq0b9oxvXQvspF8dn9qnul3I
   9weZjkk4CUoOz9OY3q4HR2M/Vd1II2YT0Lf5SaPcWV/HyCOqskpmB1U9L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2254836"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2254836"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9077661"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.112]) ([10.254.215.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:58:47 -0800
Message-ID: <e59f6ba0-a289-4c3f-8746-b58f9474a35b@linux.intel.com>
Date: Mon, 19 Feb 2024 14:58:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Huang Jiaqing <jiaqing.huang@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
 <0da83c5c-0e35-4087-aacf-6831060cab8e@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0da83c5c-0e35-4087-aacf-6831060cab8e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/19 14:54, Ethan Zhao wrote:
> On 2/15/2024 3:22 PM, Lu Baolu wrote:
>> The existing IO page fault handler currently locates the PCI device by
>> calling pci_get_domain_bus_and_slot(). This function searches the list
>> of all PCI devices until the desired device is found. To improve lookup
>> efficiency, a helper function named device_rbtree_find() is introduced
>> to search for the device within the rbtree. Replace
>> pci_get_domain_bus_and_slot() in the IO page fault handling path.
>>
>> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
>> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h |  1 +
>>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>>   drivers/iommu/intel/svm.c   | 14 ++++++--------
>>   3 files changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 54eeaa8e35a9..f13c228924f8 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -1081,6 +1081,7 @@ void free_pgtable_page(void *vaddr);
>>   void iommu_flush_write_buffer(struct intel_iommu *iommu);
>>   struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain 
>> *parent,
>>                              const struct iommu_user_data *user_data);
>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
>>   #ifdef CONFIG_INTEL_IOMMU_SVM
>>   void intel_svm_check(struct intel_iommu *iommu);
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 09009d96e553..d92c680bcc96 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -120,6 +120,35 @@ static int device_rid_cmp(struct rb_node *lhs, 
>> const struct rb_node *rhs)
>>       return device_rid_cmp_key(&key, rhs);
>>   }
>> +/*
>> + * Looks up an IOMMU-probed device using its source ID.
>> + *
>> + * If the device is found:
>> + *  - Increments its reference count.
>> + *  - Returns a pointer to the device.
>> + *  - The caller must call put_device() after using the pointer.
>> + *
>> + * If the device is not found, returns NULL.
>> + */
>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
>> +{
>> +    struct device_domain_info *info;
>> +    struct device *dev = NULL;
>> +    struct rb_node *node;
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> 
> Though per iommu device rbtree isn't a big tree, given already holds 
> spin_lock
> why still needs irq off ?

I want it to be usable not only in the normal execution flow, but also
in the interrupt context, such as for the DMA remapping fault
(unrecoverable) reporting path.

Best regards,
baolu
