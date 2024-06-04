Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9712209B
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484592; cv=none; b=mimeU4m8b6wkof19XSXL4vuPGItZcN20/O35+nQdux2impwiLYPeqgtbmz9FZnKmV3eaWPFslRY3ecyffol8dnLPS1bejBKJouyGuW3Cl5kTBJMnZmV0UUYsgBXaVpBd6eip7/MVj3wEI9uNjPB7oMakzRcJHB/r+cZowsVwwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484592; c=relaxed/simple;
	bh=FmtZE0QDhnWtssc5nt4OLbqQeX0Q//9bpFfVcjIAA6Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lMVuEBJ5jE0Zue6y1C0BrDlxL4KNWQI/0Cf1iQxBNxrqOxgaqo3iqwwbM6jYx/IZI3rvuvZXnI9LWZBOOAya7dWWURbnmeYw3ALkqpH6SxOwOjIEyHZ9iYKiq+Dl1DPsCjUGEF8EYnUcE/edZrDYVchG1J1nDAV7GcmpK8exhy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZU1RH9Lr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZU1RH9Lr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717484591; x=1749020591;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FmtZE0QDhnWtssc5nt4OLbqQeX0Q//9bpFfVcjIAA6Y=;
  b=ZU1RH9LrtgwL0PV5gPp6YZ6UoLVJryBrGn84SqSVFE/EKi6aMcoDYDp1
   bVRW/F6odawXf3ZRaaYMmhdOOPO3N/XoL3bJO6YLHTwQT++jce6vXLcYF
   esbCL1xwaiNO7Y8xoUlwrptViGVpRtoC6hgNhBk9tz8+lEHApdiLQgVyo
   WpwHS2t8RLS7t3E/DjB4NUPEtuYpjL6RO1eRR966R+Tsmio5DZcSgXN2X
   3cTflyRQzk3lh2wIkZZL059u9ZB/nJ7lTkHHR4l/qiCXHpGrR6HY0djqd
   0r5uepHBkHmU2QVJWVfJC5W4vm3TQzKJQ4VThf3PYrBaN3KPTaApvZZy/
   g==;
X-CSE-ConnectionGUID: fXTewDuDRCeSy9jVou7iKg==
X-CSE-MsgGUID: 2jiAhdSjSW64J6EleKZM/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17843702"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="17843702"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 00:03:10 -0700
X-CSE-ConnectionGUID: MRQ8mHfJTKyKyFvLEmuY2A==
X-CSE-MsgGUID: VJWzSxe+RWeCmcJRzriSmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37776292"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2024 00:03:08 -0700
Message-ID: <74992544-de5d-40a3-a68d-7a9bcd03ae71@linux.intel.com>
Date: Tue, 4 Jun 2024 15:01:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
To: "Zhang, Tina" <tina.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20240517003728.251115-1-tina.zhang@intel.com>
 <20240517003728.251115-2-tina.zhang@intel.com>
 <2b390228-190c-4508-b98f-1811c54c9e5c@linux.intel.com>
 <MW5PR11MB588165376224FEA74A0426D989FF2@MW5PR11MB5881.namprd11.prod.outlook.com>
 <7440cd36-41e0-4705-a597-f2ce3f841a70@linux.intel.com>
 <MW5PR11MB58814B632958A5776B6C31FF89F82@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <MW5PR11MB58814B632958A5776B6C31FF89F82@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 1:59 PM, Zhang, Tina wrote:
>> -----Original Message-----
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 4, 2024 9:15 AM
>> To: Zhang, Tina<tina.zhang@intel.com>; Tian, Kevin<kevin.tian@intel.com>
>> Cc:baolu.lu@linux.intel.com;iommu@lists.linux.dev; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
>> invalidation commands
>>
>> On 6/3/24 3:37 PM, Zhang, Tina wrote:
>>>> -----Original Message-----
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Sunday, May 19, 2024 5:43 PM
>>>> To: Zhang, Tina<tina.zhang@intel.com>; Tian,
>>>> Kevin<kevin.tian@intel.com>
>>>> Cc:baolu.lu@linux.intel.com;iommu@lists.linux.dev; linux-
>>>> kernel@vger.kernel.org
>>>> Subject: Re: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
>>>> invalidation commands
>>>>
>>>> On 5/17/24 8:37 AM, Tina Zhang wrote:
>>>>> Introduce a new parameter batch_desc to the QI based IOTLB/dev-IOTLB
>>>>> invalidation operations to support batching invalidation descriptors.
>>>>> This batch_desc is a pointer to the descriptor entry in a batch cmds
>>>>> buffer. If the batch_desc is NULL, it indicates that batch
>>>>> submission is not being used, and descriptors will be submitted individually.
>>>>>
>>>>> Also fix an issue reported by checkpatch about "unsigned mask":
>>>>>            "Prefer 'unsigned int' to bare use of 'unsigned'"
>>>>>
>>>>> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
>>>>> ---
>>>>>     drivers/iommu/intel/cache.c | 33 +++++++++++-------
>>>>>     drivers/iommu/intel/dmar.c  | 67 ++++++++++++++++++++-----------------
>>>>>     drivers/iommu/intel/iommu.c | 27 +++++++++------
>>>>>     drivers/iommu/intel/iommu.h | 21 ++++++++----
>>>>>     drivers/iommu/intel/pasid.c | 20 ++++++-----
>>>>>     5 files changed, 100 insertions(+), 68 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/intel/cache.c
>>>>> b/drivers/iommu/intel/cache.c index e8418cdd8331..dcf5e0e6af17
>>>>> 100644
>>>>> --- a/drivers/iommu/intel/cache.c
>>>>> +++ b/drivers/iommu/intel/cache.c
>>>>> @@ -278,7 +278,7 @@ void cache_tag_flush_range(struct dmar_domain
>>>> *domain, unsigned long start,
>>>>>     		case CACHE_TAG_NESTING_IOTLB:
>>>>>     			if (domain->use_first_level) {
>>>>>     				qi_flush_piotlb(iommu, tag->domain_id,
>>>>> -						tag->pasid, addr, pages, ih);
>>>>> +						tag->pasid, addr, pages, ih,
>>>> NULL);
>>>>>     			} else {
>>>> I'd like to have all batched descriptors code inside this file to
>>>> make it easier for maintenance. Perhaps we can add the below
>>>> infrastructure in the dmar_domain structure together with the cache tag.
>>> Does it suggest we need to add a batch version of
>> qi_flush_iotlb/qi_flush_dev_iotlb/qi_flush_piotlb/qi_flush_dev_iotlb_pasid() in
>> the cache.c file? It doesn't sound like an easy to maintain those functions, does
>> it?
>>
>> Yes. I don't think it's that difficult as the helpers just compose a qi descriptor and
>> insert it in a local queue. This local queue will be flushed after finishing iterating
>> all cache tags, or there's no room for more descriptors, or switches to a different
>> iommu. Have I missed anything?
> In current VT-d driver, only qi_flush_xxx() functions have the knowledge about how to make IOTLB invalidation descriptors. In qi_flush_xxx() functions, VT-d invalidation descriptors are populated and submitted to hardware immediately.
> 
> To support batching command, I think we can have two choices:
> 1. Extend qi_flush_xxx() functions to support batching descriptors. (Just like the implementation in this version)
> In this way, the knowledge of populating an IOTLB invalidation descriptor in qi_flush_xxx() is reused. Additional code change is for batching the descriptor command into a buffer.
> 
> 2. Introduce a new set of interfaces to populate IOTLB descriptors and batch them into a batch buffer.
> The new set of interfaces is implemented in the cache.c file and we need to copy the knowledge about how to populate IOTLB descriptors from qi_flush_xxx() interfaces into the new interfaces. I hesitated to choose this option because it would duplicate code. Maybe we can generalize the knowledge of populating IOTLB descriptors into lower level interfaces and make the current qi_flush_xxx() and the new set of interfaces call them.
> 
> Which option do you think is better?

We can share the common code without changing the current helper
interfaces. Something like this,

static inline void qi_desc_iotlb(struct intel_iommu *iommu, u16 did, u64 
addr,
                                  unsigned int size_order, u64 type,
                                  struct qi_desc *desc)
{
         u8 dw = 0, dr = 0;
         int ih = 0;

         if (cap_write_drain(iommu->cap))
                 dw = 1;

         if (cap_read_drain(iommu->cap))
                 dr = 1;

         desc->qw0 = QI_IOTLB_DID(did) | QI_IOTLB_DR(dr) | QI_IOTLB_DW(dw)
                 | QI_IOTLB_GRAN(type) | QI_IOTLB_TYPE;
         desc->qw1 = QI_IOTLB_ADDR(addr) | QI_IOTLB_IH(ih)
                 | QI_IOTLB_AM(size_order);
         desc->qw2 = 0;
         desc->qw3 = 0;
}

void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
                     unsigned int size_order, u64 type)
{
         struct qi_desc desc;

         qi_desc_iotlb(iommu, did, addr, size_order, type, &desc)
         qi_submit_sync(iommu, &desc, 1, 0);
}

The qi_desc_iotlb() can be used in both batched and non-batched paths.
Does this work for you?

Best regards,
baolu
